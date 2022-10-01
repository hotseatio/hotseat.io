package main

import (
	"context"
	"errors"
	"sync"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/params"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

func FetchAndSaveTextbooksForSection(ctx context.Context, section registrar.Section, term registrar.Term) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "FetchAndSaveTextbooksForSection")
	defer span.Finish()

	logger = logger.WithField("section", section)

	courseID := section.ASUCLAID
	if courseID == "" {
		logger.Info("Could not find ASUCLA Store id, fetching")

		// Fetch UCLA store course id, required for textbook api
		content, err := FetchUCLAStoreCourseID(ctx, section, term)
		if err != nil {
			return
		}
		courseID, err = ParseUCLAStoreCourseID(ctx, content)
		if err != nil {
			return
		}
		SaveUCLAStoreCourseID(ctx, section, courseID)
	} else {
		logger.Info("ASUCLA Store id found, reusing")
	}

	content, err := FetchTextbooks(ctx, courseID)
	if err != nil {
		logger.WithError(err).Error("Error fetching textbooks")
		return
	}
	textbooks, err := ParseTextbooks(ctx, content)
	if errors.Is(err, ErrNoTextbooks) {
		return
	} else if err != nil {
		logger.WithError(err).Error("Error parsing textbooks")
		return
	}
	err = SaveTextbooks(ctx, textbooks, section)
	if err != nil {
		logger.WithError(err).Error("Error saving textbooks")
		return
	}
}

func FetchAndSaveTextbooksForAllSections(ctx context.Context, sections []registrar.Section, term registrar.Term) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "FetchAndSaveTextbooksForAllSections")
	defer span.Finish()

	var wg sync.WaitGroup

	maxGoroutines := envutil.InitMaxGoroutines()
	logger.WithField("maxGoroutines", maxGoroutines).Info("Spawning goroutines")
	sem := make(chan struct{}, maxGoroutines)

	for _, section := range sections {
		wg.Add(1)
		go func(section registrar.Section) {
			sem <- struct{}{}
			defer func() { <-sem }()
			defer wg.Done()
			FetchAndSaveTextbooksForSection(ctx, section, term)
		}(section)
	}

	wg.Wait()
	return nil
}

func HandleRequest(ctx context.Context, params params.FetchTextbooks) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "HandleRequest")
	defer span.Finish()
	logger.WithField("params", params).Info("Starting request")

	term := params.Term
	err := term.Validate()
	if err != nil {
		logger.WithError(err).Error("Error with term param")
		return err
	}
	logger = logger.WithField("term", term)
	logger.Info("Term and termId initialized")

	sections := params.Sections

	err = FetchAndSaveTextbooksForAllSections(ctx, sections, term)
	if err != nil {
		logger.WithError(err).Error("Error fetching and saving for all textbooks")
		return err
	}

	return nil
}

func init() {
	envutil.Init()
}

func main() {
	envutil.Start(HandleRequest)
}
