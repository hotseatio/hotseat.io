package main

import (
	"context"
	"errors"
	"sync"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/params"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
	log "github.com/sirupsen/logrus"
)

func FetchAndParseCourses(ctx context.Context, subjectArea registrar.SubjectArea, term registrar.Term) (courses []registrar.Course, err error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "FetchAndParseCourses")
	span.SetTag("subjectArea", subjectArea.Code)
	defer span.Finish()

	firstPage, err := FetchFirstPage(ctx, subjectArea, term.Term)
	if err != nil {
		return courses, err
	}

	// A map of course title/numbers (keys) to course objects
	courseMap := make(map[string]*registrar.Course)
	pageCount, err := ParseFirstPage(ctx, subjectArea.ID, firstPage, courseMap)
	if err != nil {
		if !errors.Is(err, errNoResults) {
			logger.WithError(err).Error("Error parsing first page")
		}
		return courses, err
	}

	logger.WithField("pageCount", pageCount).Info("Page count found; ready to parse additional pages")

	if pageCount > 1 {
		var courseMapMux sync.Mutex
		var wg sync.WaitGroup

		model := ParseFirstPageModel(ctx, firstPage)
		for page := 2; page <= pageCount; page++ {
			page := page
			logger := logger.WithField("page", page)

			wg.Add(1)
			go func() {
				defer wg.Done()

				logger.Info("Fetching additional page")
				pageDoc, err := FetchAdditionalPage(ctx, model, page)
				if err != nil {
					return
				}

				logger.Info("Parsing additional page")
				courseMapMux.Lock()
				defer courseMapMux.Unlock()
				ParseCourses(ctx, subjectArea.ID, pageDoc, courseMap)
			}()
		}

		wg.Wait()
	}

	courses = make([]registrar.Course, 0, len(courseMap))
	for _, course := range courseMap {
		courses = append(courses, *course)
	}
	return courses, nil
}

func FetchParseAndSaveCourses(ctx context.Context, subjectArea registrar.SubjectArea, term registrar.Term) int {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "FetchParseAndSaveCourses")
	defer span.Finish()
	logger = logger.WithFields(log.Fields{"subjectArea": subjectArea.Code, "term": term.Term})
	ctx = envutil.WithLogger(ctx, logger)

	courses, err := FetchAndParseCourses(ctx, subjectArea, term)
	if errors.Is(err, errNoResults) {
		// We don't want to error when no results are found, because it happens pretty frequently.
		// (e.g., deprecated subject areas)
		logger.Info("Canceling due to no results found")
		return 0
	} else if err != nil {
		logger.WithError(err).Error("Error parsing courses")
		return 0
	}

	savedCount, err := SaveCourses(ctx, courses, term)
	if err != nil {
		logger.WithError(err).Error("Error saving courses")
		return 0
	}

	return savedCount
}

func HandleRequest(ctx context.Context, param params.FetchCourses) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "HandleRequest")
	defer span.Finish()
	logger.WithField("param", param).Info("Starting request")

	// Validate params
	term := param.Term
	err := term.Validate()
	if err != nil {
		logger.WithError(err).Error("Invalid term param")
		return err
	}

	// Fetch all subject areas
	subjectAreas, err := RetrieveSubjectAreas(ctx)
	if err != nil {
		logger.WithError(err).Error("Error retrieving subject areas")
		return err
	}

	// For each subject area: fetch, parse, and save courses
	maxGoroutines := envutil.InitMaxGoroutines()
	logger.WithFields(log.Fields{"maxGoroutines": maxGoroutines, "subjectAreaLen": len(subjectAreas)}).Info("Spawning goroutines")

	numGoroutines := maxGoroutines
	if len(subjectAreas) < maxGoroutines {
		numGoroutines = len(subjectAreas)
	}

	totalSavedCourses := 0

	subjectAreasCh := make(chan registrar.SubjectArea)
	var wg sync.WaitGroup
	for i := 0; i < numGoroutines; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for subjectArea := range subjectAreasCh {
				totalSavedCourses += FetchParseAndSaveCourses(ctx, subjectArea, term)
			}
		}()
	}
	for _, subjectArea := range subjectAreas {
		subjectAreasCh <- subjectArea
	}
	close(subjectAreasCh)
	wg.Wait()

	logger.WithField("totalSavedCourses", totalSavedCourses).Info("Finish fetching and saving all courses")

	return nil
}

func init() {
	envutil.Init()
}

func main() {
	envutil.Start(HandleRequest)
}
