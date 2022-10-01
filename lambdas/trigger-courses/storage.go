package main

import (
	"context"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

// SQL queries.
const selectSubjectAreas string = `
SELECT subject_areas.id, name, code FROM subject_areas
`

func RetrieveSubjectAreas(ctx context.Context) (subjectAreas []registrar.SubjectArea, err error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "RetrieveSubjectAreas")
	defer span.Finish()
	logger.Info("Retrieving subject areas from DB")

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
