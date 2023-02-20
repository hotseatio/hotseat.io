package main

import (
	"context"
	"sync"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/params"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
	log "github.com/sirupsen/logrus"
)

func init() {
	envutil.Init()
}

func main() {
	envutil.Start(HandleRequest)
}

func FetchParseAndSaveCourseDescriptions(ctx context.Context, subjectArea registrar.SubjectArea) int {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "FetchParseAndSaveCourseDescriptions")
	defer span.Finish()
	logger = logger.WithField("subjectArea", subjectArea.Code)
	ctx = envutil.WithLogger(ctx, logger)

	doc, err := FetchCourseDescriptions(ctx, subjectArea)
	if err != nil {
		logger.WithError(err).Error("Error fetching course descriptions")
		return 0
	}

	courses, err := ParseCourseDescriptions(subjectArea, doc)
	if err != nil {
		logger.WithError(err).Error("Error parsing course descriptions")
		return 0
	}

	savedCount, err := SaveCourseDescriptions(ctx, courses)
	if err != nil {
		logger.WithError(err).Error("Error saving course descriptions")
		return 0
	}

	return savedCount
}

func HandleRequest(ctx context.Context, params params.FetchCourseDescriptions) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "HandleRequest")
	defer span.Finish()

	logger.WithField("params", params).Info("Starting request")

	subjectAreas, err := RetrieveSubjectAreas(ctx)
	if err != nil {
		logger.WithError(err).Error("Unable to query subject areas")
		return err
	}

	// For each subject area: fetch, parse, and save course descriptions
	maxGoroutines := envutil.InitMaxGoroutines()
	logger.WithFields(log.Fields{"maxGoroutines": maxGoroutines, "subjectAreaLen": len(subjectAreas)}).Info("Spawning goroutines")

	numGoroutines := maxGoroutines
	if len(subjectAreas) < maxGoroutines {
		numGoroutines = len(subjectAreas)
	}

	totalSavedDescriptions := 0

	subjectAreasCh := make(chan registrar.SubjectArea)
	var wg sync.WaitGroup
	for i := 0; i < numGoroutines; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for subjectArea := range subjectAreasCh {
				totalSavedDescriptions += FetchParseAndSaveCourseDescriptions(ctx, subjectArea)
			}
		}()
	}
	for _, subjectArea := range subjectAreas {
		subjectAreasCh <- subjectArea
	}
	close(subjectAreasCh)
	wg.Wait()

	logger.WithField("totalSavedDescriptions", totalSavedDescriptions).Info("Finish fetching and saving all course descriptions")

	return nil
}
