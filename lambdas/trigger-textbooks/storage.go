package main

import (
	"context"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
	log "github.com/sirupsen/logrus"
)

// SQL queries.
const selectSections string = `
SELECT id, registrar_id, asucla_id
FROM sections
WHERE term_id = $1
`

func RetrieveSections(ctx context.Context, logger log.FieldLogger, term registrar.Term) (sections []registrar.Section, err error) {
	logger.Info("Retrieving sections from DB")

	db, err := envutil.CreateDatabasePool()
	if err != nil {
		return sections, err
	}

	rows, err := db.Query(ctx, selectSections, term.ID)
	if err != nil {
		return sections, err
	}
	defer rows.Close()

	for rows.Next() {
		section := registrar.Section{}
		err = rows.Scan(&section.ID, &section.RegistrarID, &section.ASUCLAID)
		if err != nil {
			logger.WithField("sections", sections).WithError(err).Error("Error reading course from DB, trying next course")
			continue
		}

		sections = append(sections, section)
	}
	err = rows.Err()
	if err != nil {
		logger.WithField("sections", sections).WithError(err).Error("Error after reading all sections")
		return sections, err
	}

	logger.WithField("courses", sections).Info("Sections retrieved")

	return sections, nil
}
