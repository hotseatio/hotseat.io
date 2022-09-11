package main

import (
	"context"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

// SQL queries.
const selectSubjectAreas string = `
SELECT id, name, code FROM subject_areas
`

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
