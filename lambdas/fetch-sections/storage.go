// Functions that deal with retrieving and saving data from the database.
package main

import (
	"context"
	"errors"
	"time"

	"github.com/jackc/pgtype"
	"github.com/jackc/pgx/v4"
	log "github.com/sirupsen/logrus"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

const (
	selectCourses string = `
SELECT courses.id, courses.title, courses.number, subject_areas.code, course_section_indices.indices
FROM courses
JOIN courses_terms ON courses.id = courses_terms.course_id
JOIN subject_areas ON courses.subject_area_id = subject_areas.id
LEFT JOIN course_section_indices ON courses.id = course_section_indices.course_id
  AND course_section_indices.term_id = courses_terms.term_id
WHERE courses_terms.term_id = $1
`
	selectPreviousSectionInfo string = `
SELECT
enrollment_status,
enrollment_count,
enrollment_capacity,
waitlist_status,
waitlist_count,
waitlist_capacity,
should_update_instructor
FROM sections
WHERE registrar_id = $1
AND term_id = $2
`
	selectSubscribedUsers string = `
SELECT u.id, u.phone
FROM relationships AS r
JOIN users AS u
ON r.user_id = u.id
WHERE notify IS TRUE
AND u.phone IS NOT NULL
AND r.section_id = $1`
	insertInstructor string = `
INSERT INTO instructors (
	registrar_listing,
	created_at,
	updated_at
)
VALUES ($1, NOW(), NOW())
ON CONFLICT (registrar_listing)
DO UPDATE
SET
updated_at = NOW()
RETURNING id
`
	insertSectionWithoutInstructor string = `
INSERT INTO sections (
	registrar_id,
	term_id,
	course_id,

	format,
	index,
	days,
	times,
	locations,
	registrar_instructors,
	enrollment_status,
	enrollment_count,
	enrollment_capacity,
	waitlist_status,
	waitlist_count,
	waitlist_capacity,

	website,
	final_start,
	final_end,

	summer_session,
	summer_duration_weeks,

	created_at,
	updated_at
)
VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, NOW(), NOW())
ON CONFLICT (registrar_id, term_id)
DO UPDATE
SET
updated_at = NOW(),

course_id = EXCLUDED.course_id,

format = EXCLUDED.format,
index = EXCLUDED.index,
days = EXCLUDED.days,
times = EXCLUDED.times,
locations = EXCLUDED.locations,
registrar_instructors = EXCLUDED.registrar_instructors,
enrollment_status = EXCLUDED.enrollment_status,
enrollment_count = EXCLUDED.enrollment_count,
enrollment_capacity = EXCLUDED.enrollment_capacity,
waitlist_status = EXCLUDED.waitlist_status,
waitlist_count = EXCLUDED.waitlist_count,
waitlist_capacity = EXCLUDED.waitlist_capacity,

website = EXCLUDED.website,
final_start = EXCLUDED.final_start,
final_end = EXCLUDED.final_end,

summer_session = EXCLUDED.summer_session,
summer_duration_weeks = EXCLUDED.summer_duration_weeks

RETURNING id
`
	insertSectionWithInstructor string = `
INSERT INTO sections (
	registrar_id,
	term_id,
	course_id,
	instructor_id,

	format,
	index,
	days,
	times,
	locations,
	registrar_instructors,
	enrollment_status,
	enrollment_count,
	enrollment_capacity,
	waitlist_status,
	waitlist_count,
	waitlist_capacity,

	website,
	final_start,
	final_end,

	summer_session,
	summer_duration_weeks,

	created_at,
	updated_at
)
VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, NOW(), NOW())
ON CONFLICT (registrar_id, term_id)
DO UPDATE
SET
updated_at = NOW(),

instructor_id = EXCLUDED.instructor_id,
course_id = EXCLUDED.course_id,

format = EXCLUDED.format,
index = EXCLUDED.index,
days = EXCLUDED.days,
times = EXCLUDED.times,
locations = EXCLUDED.locations,
registrar_instructors = EXCLUDED.registrar_instructors,
enrollment_status = EXCLUDED.enrollment_status,
enrollment_count = EXCLUDED.enrollment_count,
enrollment_capacity = EXCLUDED.enrollment_capacity,
waitlist_status = EXCLUDED.waitlist_status,
waitlist_count = EXCLUDED.waitlist_count,
waitlist_capacity = EXCLUDED.waitlist_capacity,

website = EXCLUDED.website,
final_start = EXCLUDED.final_start,
final_end = EXCLUDED.final_end,

summer_session = EXCLUDED.summer_session,
summer_duration_weeks = EXCLUDED.summer_duration_weeks

RETURNING id
`
	insertEnrollmentData string = `
INSERT INTO enrollment_data (
	section_id,
	enrollment_status,
	enrollment_count,
	enrollment_capacity,
	waitlist_status,
	waitlist_count,
	waitlist_capacity,
	created_at,
	updated_at
)
VALUES ($1, $2, $3, $4, $5, $6, $7, NOW(), NOW())
`
)

// RetrieveCourses selects course information from the database.
func RetrieveCourses(ctx context.Context, term registrar.Term) (courses []registrar.Course, err error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "RetrieveCourses")
	defer span.Finish()
	logger.Info("Retrieving courses from DB")

	db, err := envutil.CreateDatabasePool()
	if err != nil {
		return courses, err
	}

	rows, err := db.Query(ctx, selectCourses, term.ID)
	if err != nil {
		return courses, err
	}
	defer rows.Close()

	for rows.Next() {
		course := registrar.Course{}
		err = rows.Scan(&course.ID, &course.Title, &course.Number, &course.SubjectAreaCode, &course.SectionIndices)
		if err != nil {
			logger.WithField("courses", courses).WithError(err).Error("Error reading course from DB, trying next course")
			continue
		}
		if _, ok := registrar.SpecialSubjectAreas[course.SubjectAreaCode]; registrar.CourseNumbersToIgnoreRegex.MatchString(course.Number) && !ok {
			logger.WithField("course", course).Info("Skipping course because it isn't interesting")
			continue
		}
		logger.WithField("course", course).Info("Reading course")
		if len(course.SectionIndices) == 0 ||
			len(course.SectionIndices) == 1 && course.SectionIndices[0] == "" {
			course.SectionIndices = []string{"%"}
		}
		courses = append(courses, course)
	}
	err = rows.Err()
	if err != nil {
		logger.WithField("courses", courses).WithError(err).Error("Error after reading all courses")
		return courses, err
	}

	logger.WithField("courses", courses).Info("Courses retrieved")

	return courses, nil
}

// Given a term id and section id, retrieves the most recent past enrollment numbers for that section.
func GetPreviousSectionInfo(ctx context.Context, logger log.FieldLogger, tx pgx.Tx, registrarID string, termID int64) (prevEnrollmentNumbers registrar.EnrollmentNumbers, shouldUpdateInstructor bool, err error) {
	logger.Info("Getting previous section numbers")
	err = tx.QueryRow(ctx, selectPreviousSectionInfo, registrarID, termID).Scan(
		&prevEnrollmentNumbers.EnrollmentStatus,
		&prevEnrollmentNumbers.EnrollmentCount,
		&prevEnrollmentNumbers.EnrollmentCapacity,
		&prevEnrollmentNumbers.WaitlistStatus,
		&prevEnrollmentNumbers.WaitlistCount,
		&prevEnrollmentNumbers.WaitlistCapacity,
		&shouldUpdateInstructor,
	)
	if errors.Is(err, pgx.ErrNoRows) {
		logger.Info("No rows found")
		return prevEnrollmentNumbers, true, nil
	} else if err != nil {
		logger.WithError(err).Error("Error retrieving previous section numbers")
		return prevEnrollmentNumbers, true, err
	}
	return prevEnrollmentNumbers, shouldUpdateInstructor, nil
}

func GetSubscribedUsers(ctx context.Context, section registrar.Section) (users []registrar.User, err error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "GetSubscribedUsers")
	defer span.Finish()
	logger.Info("Retrieving users from DB")

	db, err := envutil.CreateDatabasePool()
	if err != nil {
		return users, err
	}

	rows, err := db.Query(ctx, selectSubscribedUsers, section.ID)
	if err != nil {
		return users, err
	}
	defer rows.Close()

	for rows.Next() {
		user := registrar.User{}
		err = rows.Scan(&user.ID, &user.Phone)
		if err != nil {
			logger.WithError(err).Error("Error reading user from DB, trying next user")
			continue
		}
		users = append(users, user)
	}
	err = rows.Err()
	if err != nil {
		logger.WithField("users", users).WithError(err).Error("Error after reading all users")
		return users, err
	}

	logger.WithField("users", users).Info("Subscribed users retrieved")

	return users, nil
}

// Saves a section to the database.
func SaveSection(
	ctx context.Context,
	course registrar.Course,
	section registrar.Section,
	shouldInsertEnrollmentData bool,
) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "SaveSection")
	defer span.Finish()
	logger = logger.WithField("section", section)

	db, err := envutil.CreateDatabasePool()
	if err != nil {
		return err
	}

	tx, err := db.Begin(ctx)
	if err != nil {
		logger.WithError(err).Error("Unable to create transaction")
		return err
	}
	defer tx.Rollback(ctx)

	// Get current and previous enrollment numbers.
	// We must do this before we insert new data!
	currentEnrollmentNumbers := section.EnrollmentNumbers
	prevEnrollmentNumbers, shouldUpdateInstructor, err := GetPreviousSectionInfo(ctx, logger, tx, section.RegistrarID, section.TermID)
	if err != nil {
		return err
	}

	if shouldUpdateInstructor {
		logger.Info("Inserting instructor")
		var instructorID int64
		err = tx.QueryRow(
			ctx,
			insertInstructor,
			section.Instructors,
		).Scan(&instructorID)
		if err != nil {
			return err
		}

		logger.Info("Inserting section with instructor")
		err = tx.QueryRow(
			ctx,
			insertSectionWithInstructor,
			section.RegistrarID,
			section.TermID,
			section.CourseID,
			instructorID,

			section.Format,
			section.Index,
			section.Days,
			section.Times,
			section.Locations,
			section.Instructors,
			section.EnrollmentStatus,
			section.EnrollmentCount,
			section.EnrollmentCapacity,
			section.WaitlistStatus,
			section.WaitlistCount,
			section.WaitlistCapacity,

			ConvertStringToPgType(section.Website),
			ConvertTimeToPgType(section.FinalStart),
			ConvertTimeToPgType(section.FinalEnd),

			ConvertStringToPgType(section.SummerSession),
			ConvertIntToPgType(section.SummerDurationWeeks),
		).Scan(&section.ID)
		if err != nil {
			return err
		}
	} else {
		logger.Info("Inserting section without instructor")
		err = tx.QueryRow(
			ctx,
			insertSectionWithoutInstructor,
			section.RegistrarID,
			section.TermID,
			section.CourseID,

			section.Format,
			section.Index,
			section.Days,
			section.Times,
			section.Locations,
			section.Instructors,
			section.EnrollmentStatus,
			section.EnrollmentCount,
			section.EnrollmentCapacity,
			section.WaitlistStatus,
			section.WaitlistCount,
			section.WaitlistCapacity,

			ConvertStringToPgType(section.Website),
			ConvertTimeToPgType(section.FinalStart),
			ConvertTimeToPgType(section.FinalEnd),

			ConvertStringToPgType(section.SummerSession),
			ConvertIntToPgType(section.SummerDurationWeeks),
		).Scan(&section.ID)
		if err != nil {
			return err
		}
	}

	if currentEnrollmentNumbers.EnrollmentStatus != prevEnrollmentNumbers.EnrollmentStatus {
		logger.Info("Notifying subscribed users")
		err = NotifySubscribedUsers(ctx, course, section, prevEnrollmentNumbers)
		if err != nil {
			logger.WithError(err).Error("Could not notify users")
		}
	}

	// If we don't need to insert enrollment data, we can exit early.
	if !shouldInsertEnrollmentData {
		logger.Info("Don't need to insert enrollment data, commiting")
		return tx.Commit(ctx)
	}

	logger.WithFields(log.Fields{
		"prevEnrollmentNumbers":    prevEnrollmentNumbers,
		"currentEnrollmentNumbers": currentEnrollmentNumbers,
		"Not Equal?":               currentEnrollmentNumbers != prevEnrollmentNumbers,
	}).Info("Checking if should insert into section enrollment data")

	if currentEnrollmentNumbers != prevEnrollmentNumbers {
		logger.Info("Inserting section enrollment data")
		_, err = tx.Exec(ctx, insertEnrollmentData,
			section.ID,
			currentEnrollmentNumbers.EnrollmentStatus,
			currentEnrollmentNumbers.EnrollmentCount,
			currentEnrollmentNumbers.EnrollmentCapacity,
			currentEnrollmentNumbers.WaitlistStatus,
			currentEnrollmentNumbers.WaitlistCount,
			currentEnrollmentNumbers.WaitlistCapacity,
		)
		if err != nil {
			return err
		}
	}

	return tx.Commit(ctx)
}

func ConvertIntToPgType(i int) pgtype.Int4 {
	status := pgtype.Present
	if i == 0 {
		status = pgtype.Null
	}
	return pgtype.Int4{
		Int:    int32(i),
		Status: status,
	}
}

func ConvertStringToPgType(s string) pgtype.Text {
	status := pgtype.Present
	if s == "" {
		status = pgtype.Null
	}
	return pgtype.Text{
		String: s,
		Status: status,
	}
}

func ConvertTimeToPgType(time time.Time) pgtype.Timestamptz {
	status := pgtype.Present
	if time.IsZero() {
		status = pgtype.Null
	}
	return pgtype.Timestamptz{
		Time:   time,
		Status: status,
	}
}
