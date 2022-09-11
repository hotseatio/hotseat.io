package main

import (
	"context"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

const (
	insertSubjectArea string = `
	INSERT INTO subject_areas (name, code, created_at, updated_at)
	VALUES ($1, $2, NOW(), NOW())
	ON CONFLICT (code)
	DO UPDATE
	SET name = EXCLUDED.name, updated_at = NOW()
	RETURNING id
	`
)

func SaveSubjectAreas(ctx context.Context, subjectAreas []registrar.SubjectArea) (err error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "SaveSubjectAreas")
	defer span.Finish()
	logger.Info("Connecting to database")

	db, err := envutil.CreateDatabasePool()
	if err != nil {
		return err
	}

	logger.Info("Inserting to database")
	for _, subjectArea := range subjectAreas {
		var id int64
		err := db.QueryRow(ctx, insertSubjectArea, subjectArea.Name, subjectArea.Code).Scan(&id)
		if err != nil {
			logger.WithField("subjectArea", subjectArea).Error(err)
		}
	}

	logger.Info("Database insert complete")

	return nil
}
