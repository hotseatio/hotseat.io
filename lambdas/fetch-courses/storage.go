package main

import (
	"context"

	log "github.com/sirupsen/logrus"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/envutil/pgxtrace"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

// SQL queries.
const (
	SelectSubjectAreas string = `
SELECT subject_areas.id, name, code FROM subject_areas
`
	InsertCourse string = `
		INSERT INTO courses (subject_area_id, title, number, created_at, updated_at)
		VALUES ($1, $2, $3, NOW(), NOW())
		ON CONFLICT (subject_area_id, title, number)
		DO UPDATE
		SET updated_at = NOW()
		RETURNING id
	`
	InsertIndices string = `
		INSERT INTO course_section_indices (course_id, term_id, indices, created_at, updated_at)
		VALUES ($1, $2, $3, NOW(), NOW())
		ON CONFLICT (course_id, term_id)
		DO UPDATE
		SET updated_at = NOW(), indices = EXCLUDED.indices
	`
	InsertTerms string = `
		INSERT INTO courses_terms (course_id, term_id)
		VALUES ($1, $2)
		ON CONFLICT (course_id, term_id) DO NOTHING
	`
)

func RetrieveSubjectAreas(ctx context.Context) (subjectAreas []registrar.SubjectArea, err error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "RetrieveSubjectAreas")
	defer span.Finish()
	logger.Info("Retrieving subject areas from DB")

	db, err := envutil.CreateDatabasePool()
	if err != nil {
		return subjectAreas, err
	}

	rows, err := db.Query(ctx, SelectSubjectAreas)
	if err != nil {
		return subjectAreas, err
	}
	defer rows.Close()

	for rows.Next() {
		sa := registrar.SubjectArea{}
		err = rows.Scan(&sa.ID, &sa.Name, &sa.Code)
		if err != nil {
			logger.WithField("subjectArea", sa).WithError(err).Error("Error reading course from DB, trying next course")
			continue
		}
		subjectAreas = append(subjectAreas, sa)
	}
	err = rows.Err()
	if err != nil {
		logger.WithField("subjectAreas", subjectAreas).WithError(err).Error("Error after reading all subject areas")
		return subjectAreas, err
	}

	logger.WithField("subjectAreas", subjectAreas).Info("Subject areas retrieved")

	return subjectAreas, nil
}

func SaveCourse(ctx context.Context, db pgxtrace.WrappedConn, course registrar.Course, term registrar.Term) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "SaveCourse")
	defer span.Finish()

	logger = logger.WithFields(log.Fields{"subjectAreaID": course.SubjectAreaID, "number": course.Number, "title": course.Title})
	logger.Info("Inserting course")

	tx, err := db.Begin(ctx)
	if err != nil {
		logger.WithError(err).Error("Unable to create transaction")
		return err
	}
	defer tx.Rollback(ctx)

	err = tx.QueryRow(ctx, InsertCourse, course.SubjectAreaID, course.Title, course.Number).Scan(&course.ID)
	if err != nil {
		logger.WithError(err).Error("Unable to insert course")
		return err
	}

	logger = logger.WithField("courseID", course.ID)

	logger.WithField("termID", term.ID).Info("Inserting course into courses_terms")
	if _, err := tx.Exec(ctx, InsertTerms, course.ID, term.ID); err != nil {
		logger.WithError(err).Error("Unable to insert into courses_terms")
		return err
	}

	if len(course.SectionIndices) > 0 {
		logger.Info("Inserting course section indices")
		if _, err := tx.Exec(ctx, InsertIndices, course.ID, term.ID, course.SectionIndices); err != nil {
			logger.WithError(err).WithFields(log.Fields{"course": course, "term": term.Term, "termID": term.ID}).Error(err)
			return err
		}
	}

	return tx.Commit(ctx)
}

func SaveCourses(ctx context.Context, courses []registrar.Course, term registrar.Term) (int, error) {
	span, _, _ := envutil.GetLoggerAndNewSpan(ctx, "SaveCourses")
	defer span.Finish()

	db, err := envutil.CreateDatabasePool()
	if err != nil {
		return 0, err
	}

	for _, course := range courses {
		SaveCourse(ctx, db, course, term)
	}

	return len(courses), nil
}
