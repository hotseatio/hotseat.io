package main

import (
	"context"
	"errors"

	"github.com/jackc/pgtype"
	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
	log "github.com/sirupsen/logrus"
)

var errNoRowsFound = errors.New("no row found to delete")

const (
	insertTextbook string = `
INSERT INTO textbooks (
	is_required,
	isbn,
	title,
	author,
	edition,
	copyright_year,
	created_at,
	updated_at
)
VALUES ($1, $2, $3, $4, $5, $6, NOW(), NOW())
ON CONFLICT (isbn)
DO UPDATE
SET
is_required = EXCLUDED.is_required,
isbn = EXCLUDED.isbn,
title = EXCLUDED.title,
author = EXCLUDED.author,
edition = EXCLUDED.edition,
copyright_year = EXCLUDED.copyright_year,
updated_at = NOW()
RETURNING id
`
	insertSectionRelation string = `
INSERT INTO sections_textbooks (
	section_id, textbook_id
)
VALUES ($1, $2)
ON CONFLICT (section_id, textbook_id)
DO NOTHING
`
	updateSectionStoreID string = `
UPDATE sections SET asucla_id = $1 WHERE id = $2;
`
)

func SaveUCLAStoreCourseID(ctx context.Context, section registrar.Section, storeID string) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "SaveTextbooks")
	defer span.Finish()

	db, err := envutil.CreateDatabasePool()
	if err != nil {
		return err
	}

	logger.WithFields(log.Fields{"storeID": storeID, "sectionID": section.ID}).Info("Updating store id for section")
	commandTag, err := db.Exec(ctx, updateSectionStoreID, storeID, section.ID)
	if err != nil {
		return err
	}
	if commandTag.RowsAffected() != 1 {
		return errNoRowsFound
	}

	return nil
}

func SaveTextbooks(ctx context.Context, textbooks []registrar.Textbook, section registrar.Section) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "SaveTextbooks")
	defer span.Finish()

	db, err := envutil.CreateDatabasePool()
	if err != nil {
		return err
	}

	logger.Info("Inserting textbooks")
	for _, textbook := range textbooks {
		logger = logger.WithField("textbook", textbook)

		tx, err := db.Begin(ctx)
		if err != nil {
			logger.WithError(err).Error("Unable to create transaction")
			continue
		}

		err = tx.QueryRow(
			ctx,
			insertTextbook,
			textbook.IsRequired,
			textbook.ISBN,
			textbook.Title,
			textbook.Author,
			ConvertInt16ToPgType(textbook.Edition),
			textbook.CopyrightYear,
		).Scan(&textbook.ID)
		if err != nil {
			logger.WithError(err).Error("Error inserting textbook")
			err = tx.Rollback(ctx)
			if err != nil {
				logger.WithError(err).Error("Could not rollback transaction")
			}
			continue
		}

		logger.Info("Inserting section/textbook relation")
		_, err = tx.Exec(ctx, insertSectionRelation,
			section.ID,
			textbook.ID,
		)
		if err != nil {
			logger.WithError(err).Error("Error section relation")
			err = tx.Rollback(ctx)
			if err != nil {
				logger.WithError(err).Error("Could not rollback transaction")
			}
			continue
		}

		err = tx.Commit(ctx)
		if err != nil {
			logger.WithError(err).Error("Could not commit transaction")
		}
	}

	return nil
}

func ConvertInt16ToPgType(i int16) pgtype.Int2 {
	status := pgtype.Present
	if i == 0 {
		status = pgtype.Null
	}
	return pgtype.Int2{
		Int:    i,
		Status: status,
	}
}
