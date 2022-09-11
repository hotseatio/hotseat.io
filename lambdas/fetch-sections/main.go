package main

import (
	"context"
	"sync"

	"github.com/PuerkitoBio/goquery"
	log "github.com/sirupsen/logrus"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/params"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

func ParseAndSaveTableRows(
	ctx context.Context,
	course registrar.Course,
	term registrar.Term,
	rows *goquery.Selection,
	summerInfo *registrar.SummerInfo,
	shouldInsertEnrollmentData bool,
) {
	span, _, ctx := envutil.GetLoggerAndNewSpan(ctx, "ParseAndSaveTableRows")
	defer span.Finish()

	var wg sync.WaitGroup
	for i := range rows.Nodes {
		wg.Add(1)
		row := rows.Eq(i)
		go func(row *goquery.Selection) {
			defer wg.Done()
			section, err := ParseSectionAndDetails(ctx, course, term, row)
			if err != nil {
				return
			}
			if summerInfo != nil {
				section.SummerInfo = *summerInfo
			}

			FilterInstructors(ctx, course, &section)
			err = SaveSection(ctx, course, section, shouldInsertEnrollmentData)
			if err != nil {
				log.WithError(err).Error("Error saving section")
			}
		}(row)
	}
	wg.Wait()
}

func ParseSectionAndDetails(ctx context.Context, course registrar.Course, term registrar.Term, row *goquery.Selection) (section registrar.Section, err error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "ParseSectionAndDetails")
	span.SetTag("subjectArea", course.ShortTitle())
	defer span.Finish()

	section, err = ParseRow(logger, row, term, course.ID)
	if err != nil {
		log.WithError(err).Error("Error parsing section")
		return section, err
	}

	doc, err := FetchDetailsForSection(ctx, course, section.Index, section.RegistrarID, term)
	if err != nil {
		log.WithError(err).Error("Error fetching additional details for section")
	} else {
		ParseAdditionalDetails(logger, doc, &section)
	}

	return section, nil
}

func FetchAndSaveSectionsForCourse(
	ctx context.Context,
	course registrar.Course,
	term registrar.Term,
	shouldInsertEnrollmentData bool,
) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "FetchAndSaveSectionsForCourse")
	span.SetTag("course", course.ShortTitle())
	defer span.Finish()

	logger = logger.WithField("course", course)
	logger.Info("Fetching and saving course")

	for _, index := range course.SectionIndices {
		logger := logger.WithField("section index", index)
		ctx := envutil.WithLogger(ctx, logger)

		doc, err := FetchSectionsForCourse(ctx, course, index, term)
		if err != nil {
			log.WithError(err).Error("Error fetching course")
			continue
		}

		if term.IsSummer() {
			summerTitles, summerTables := ParseSummerBodyToTables(doc)
			for i := range summerTables.Nodes {
				title := summerTitles.Eq(i).Text()
				summerInfo := ParseSummerInfoFromTitle(logger, title)
				table := summerTables.Eq(i)
				rows := ParseTableToRows(table)
				ParseAndSaveTableRows(ctx, course, term, rows, &summerInfo, shouldInsertEnrollmentData)
			}
		} else {
			table := ParseBodyToTable(doc)
			rows := ParseTableToRows(table)
			ParseAndSaveTableRows(ctx, course, term, rows, nil, shouldInsertEnrollmentData)
		}
	}
}

func FetchAndSaveSectionsForAllCourses(
	ctx context.Context,
	courses []registrar.Course,
	term registrar.Term,
	shouldInsertEnrollmentData bool,
) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "FetchAndSaveSectionsForAllCourses")
	defer span.Finish()

	maxGoroutines := envutil.InitMaxGoroutines()
	logger.WithFields(log.Fields{"maxGoroutines": maxGoroutines, "courseLen": len(courses)}).Info("Spawning goroutines")

	numGoroutines := maxGoroutines
	if len(courses) < maxGoroutines {
		numGoroutines = len(courses)
	}

	coursesCh := make(chan registrar.Course)

	var wg sync.WaitGroup
	for i := 0; i < numGoroutines; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for course := range coursesCh {
				FetchAndSaveSectionsForCourse(ctx, course, term, shouldInsertEnrollmentData)
			}
		}()
	}
	for _, course := range courses {
		coursesCh <- course
	}
	close(coursesCh)
	wg.Wait()

	return nil
}

func HandleRequest(ctx context.Context, params params.FetchSections) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "HandleRequest")
	defer span.Finish()
	logger.WithField("params", params).Info("Starting request")

	// Validate params
	term := params.Term
	err := term.Validate()
	if err != nil {
		logger.WithError(err).Error("Error with term param")
		return err
	}
	logger = logger.WithField("term", term)
	logger.Info("Term and termId initialized")

	courses := params.Courses

	err = FetchAndSaveSectionsForAllCourses(ctx, courses, term, params.ShouldInsertEnrollmentData)
	if err != nil {
		logger.WithError(err).Error("Error fetching and saving for all courses")
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
