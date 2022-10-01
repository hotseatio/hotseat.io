package main

import (
	"context"
	"encoding/json"
	"errors"
	"regexp"
	"strconv"

	"github.com/PuerkitoBio/goquery"
	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
	log "github.com/sirupsen/logrus"
)

// Regular expressions.
var (
	firstPageModelRegex = regexp.MustCompile(`(SearchPanel\.SearchData = JSON\.stringify\()({.*})`)
	headerRegex         = regexp.MustCompile(`(\S*) - (.*)`)
	modelRegex          = regexp.MustCompile(`AddToCourseData\(.*({.*?})\)`)
)

var (
	errNoResults   = errors.New("could not find any results")
	errNoPageCount = errors.New("could not find page count")
)

func ParseFirstPage(ctx context.Context, subjectAreaID int64, doc *goquery.Document, courseMap map[string]*registrar.Course) (pageCount int, err error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "ParseFirstPage")
	defer span.Finish()

	logger = logger.WithField("subjectAreaID", subjectAreaID)
	logger.Info("Parsing first page")
	// Check for search results
	noSearchResults := doc.Find("#spanNoSearchResults")
	if len(noSearchResults.Nodes) != 0 {
		logger.Info("Could not find any results")
		return pageCount, errNoResults
	}

	ParseCourses(ctx, subjectAreaID, doc, courseMap)

	pageCountStr, exists := doc.Find("#pageCount").Attr("value")
	if !exists {
		return pageCount, errNoPageCount
	}
	pageCount, err = strconv.Atoi(pageCountStr)
	if err != nil {
		return pageCount, errNoPageCount
	}

	return pageCount, nil
}

func ParseFirstPageModel(ctx context.Context, doc *goquery.Document) string {
	span, logger, _ := envutil.GetLoggerAndNewSpan(ctx, "ParseFirstPageModel")
	defer span.Finish()

	body, err := goquery.OuterHtml(doc.Selection)
	if err != nil {
		logger.WithFields(log.Fields{"body": body}).WithError(err).Error("Could not get OuterHtml of firstPage")
	}
	matches := firstPageModelRegex.FindStringSubmatch(body)
	model := matches[2]
	return model
}

// ParseCourses parses all the courses on a given page and adds them to the course map.
func ParseCourses(ctx context.Context, subjectAreaID int64, doc *goquery.Document, courseMap map[string]*registrar.Course) {
	span, logger, _ := envutil.GetLoggerAndNewSpan(ctx, "ParseCourses")
	defer span.Finish()

	results := doc.Find("#resultsTitle")
	links := results.Find("h3 > button")
	scripts := results.Find("script[type='text/javascript']")

	for i := range links.Nodes {
		link := links.Eq(i).Text()
		script := scripts.Eq(i).Text()

		header := headerRegex.FindStringSubmatch(link)
		modelStr := modelRegex.FindStringSubmatch(script)

		number, title := header[1], header[2]
		logger := logger.WithFields(log.Fields{"number": number, "title": title})
		if number == "" || title == "" {
			logger.WithFields(log.Fields{"header": header}).Warn("Empty number or title")
		}

		modelRawJSON := modelStr[1]
		var model registrar.Model
		err := json.Unmarshal([]byte(modelRawJSON), &model)
		if err != nil {
			logger.WithFields(log.Fields{"modelStr": modelStr}).WithError(err).Warn("Failed to parse registrar model")
		}

		key := createCourseMapKey(number, title)
		if _, ok := courseMap[key]; ok {
			sectionIndex := model.ClassNumber

			logger.WithFields(log.Fields{"sectionIndex": sectionIndex}).Info("Found alternate listing of variable course, adding new section number")
			courseMap[key].AddSectionIndex(sectionIndex)
		} else {
			course := registrar.Course{
				SubjectAreaID:  subjectAreaID,
				Title:          title,
				Number:         number,
				Model:          modelRawJSON,
				SectionIndices: make([]string, 0),
			}

			if model.ClassNumber != "%" {
				sectionIndex := model.ClassNumber
				logger.WithFields(log.Fields{"sectionIndex": sectionIndex}).Info("Found listing of variable course, adding new section number")
				course.AddSectionIndex(sectionIndex)
			}

			logger.Info("Parsed and created new course")
			courseMap[key] = &course
		}
	}
}

// Generate a key for a course map from the course's number and title.
func createCourseMapKey(number, title string) (key string) {
	key = number + "-" + title
	return key
}
