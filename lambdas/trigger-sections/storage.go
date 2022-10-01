package main

import (
	"context"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

// SQL queries.
const selectCourses string = `
SELECT courses.id, courses.title, courses.number, subject_areas.code, course_section_indices.indices
FROM courses
JOIN courses_terms ON courses.id = courses_terms.course_id
JOIN subject_areas ON courses.subject_area_id = subject_areas.id
LEFT JOIN course_section_indices ON courses.id = course_section_indices.course_id
  AND course_section_indices.term_id = courses_terms.term_id
WHERE courses_terms.term_id = $1
`

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
