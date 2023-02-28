package main

import (
	"context"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

const (
	selectSubjectAreas string = `
SELECT id, name, code FROM subject_areas
`
	updateCourse string = `
	UPDATE courses
	SET
	updated_at = NOW(),
	description = $1,
	units = $2
	WHERE subject_area_id = $3
	AND number = $4
	AND title = $5
	`
)

func RetrieveSubjectAreas(ctx context.Context) (subjectAreas []registrar.SubjectArea, err error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "RetrieveSubjectAreas")
	defer span.Finish()

	logger.Info("Connecting to Database")
	db, err := envutil.CreateDatabasePool()
	if err != nil {
		return subjectAreas, err
	}

	rows, err := db.Query(ctx, selectSubjectAreas)
	if err != nil {
		return subjectAreas, err
	}
	defer rows.Close()

	for rows.Next() {
		subjectArea := registrar.SubjectArea{}
		err = rows.Scan(&subjectArea.ID, &subjectArea.Name, &subjectArea.Code)
		if err != nil {
			continue
		}
		subjectAreas = append(subjectAreas, subjectArea)
	}

	return subjectAreas, nil
}

func SaveCourseDescriptions(
	ctx context.Context,
	courses []registrar.Course,
) (int, error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "SaveCourseDescriptions")
	defer span.Finish()

	logger.Info("Connecting to database")

	db, err := envutil.CreateDatabasePool()
	if err != nil {
		return 0, err
	}

	logger.Info("Updating database rows")
	for _, course := range courses {
		logger = logger.WithField("course", course)
		logger.Info("Updating course")
		commandTag, err := db.Exec(ctx, updateCourse,
			course.Description,
			course.Units,
			course.SubjectAreaID,
			course.Number,
			course.Title,
		)
		if err != nil {
			logger.Error(err)
		}
		if commandTag.RowsAffected() > 1 {
			logger.Error("Updated more than one row")
		} else if commandTag.RowsAffected() == 0 {
			logger.Info("Did not update any rows")
		}
	}

	logger.Info("Database update complete")

	return len(courses), nil
}
