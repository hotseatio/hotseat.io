package main

import (
	"context"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"strings"

	"github.com/PuerkitoBio/goquery"
	log "github.com/sirupsen/logrus"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/fetchutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

const (
	sectionsQueryURL = "https://sa.ucla.edu/ro/Public/SOC/Results/GetCourseSummary"
	detailsQueryURL  = "https://sa.ucla.edu/ro/Public/SOC/Results/ClassDetailTooltip"
)

func CreateCourseCatalogNumber(course registrar.Course) string {
	leadingChars, number, trailingChars := course.SplitNumber()
	formattedLeadingChars := fmt.Sprintf("%-2s", leadingChars)
	formattedTrailingChars := fmt.Sprintf("%-2s", trailingChars)
	formattedNumber := fmt.Sprintf("%04s", number)
	catalogNumber := formattedNumber + formattedTrailingChars + formattedLeadingChars
	log.WithField("catalogNumber", catalogNumber).Info("Create course catalog number")
	return catalogNumber
}

var subjectAreaCodeReplacer = strings.NewReplacer("&", "", " ", "")

func CreateFormattedModel(course registrar.Course, classNumber string, term string) string {
	subjectAreaCode := fmt.Sprintf("%-7s", course.SubjectAreaCode)

	catalogNumber := CreateCourseCatalogNumber(course)
	leadingChars, number, trailingChars := course.SplitNumber()
	formattedNumber := fmt.Sprintf("%04s", number)

	formattedSubjectAreaCode := subjectAreaCodeReplacer.Replace(course.SubjectAreaCode)

	courseID := formattedSubjectAreaCode + formattedNumber + trailingChars + leadingChars

	preencodedToken := catalogNumber + courseID
	token := base64.StdEncoding.EncodeToString([]byte(preencodedToken))

	model := registrar.Model{
		Term:                 term,
		SubjectAreaCode:      subjectAreaCode,
		CatalogNumber:        catalogNumber,
		IsRoot:               true,
		SessionGroup:         "%",
		ClassNumber:          classNumber,
		SequenceNumber:       nil,
		Path:                 courseID,
		MultiListedClassFlag: "n",
		Token:                token,
	}

	mBytes, err := json.Marshal(model)
	if err != nil {
		log.WithFields(log.Fields{"model": model}).Error("Could not marshal to json")
	}

	modelStr := string(mBytes)
	log.WithFields(log.Fields{"model": modelStr}).Info("Created model")

	return modelStr
}

func FetchSectionsForCourse(
	ctx context.Context,
	course registrar.Course,
	index string,
	term registrar.Term,
) (_ *goquery.Document, err error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "FetchSectionsForCourse")
	defer span.Finish()

	req, err := http.NewRequestWithContext(ctx, "GET", sectionsQueryURL, nil)
	if err != nil {
		return nil, err
	}

	model := CreateFormattedModel(course, index, term.Term)

	params := req.URL.Query()
	params.Add("model", model)
	params.Add("FilterFlags", registrar.FilterFlags)
	req.URL.RawQuery = params.Encode()

	logger.WithField("URL", req.URL.String()).Info("Making request to course summary URL")
	response, err := fetchutil.Client.Do(req)

	if err != nil {
		return nil, err
	}
	if response.StatusCode != http.StatusOK {
		return nil, fetchutil.ErrStatusCode
	}
	defer response.Body.Close()

	doc, err := goquery.NewDocumentFromReader(response.Body)
	if err != nil {
		return nil, err
	}

	return doc, nil
}

func FetchDetailsForSection(
	ctx context.Context,
	course registrar.Course,
	index int,
	registrarID string,
	term registrar.Term,
) (_ *goquery.Document, err error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "FetchDetailsForSection")
	defer span.Finish()

	req, err := http.NewRequestWithContext(ctx, "GET", detailsQueryURL, nil)
	if err != nil {
		return nil, err
	}

	// This header is required, otherwise we get a 404
	req.Header.Add("X-Requested-With", "XMLHttpRequest")

	termParam := "term_cd=" + term.Term
	subjAreaParam := "subj_area_cd=" + url.QueryEscape(course.SubjectAreaCode)
	catalogNumberParam := "crs_catlg_no=" + CreateCourseCatalogNumber(course)
	classIDParam := "class_id=" + registrarID
	classNumberParam := "class_no=" + fmt.Sprintf(" %03d", index)

	params := []string{termParam, subjAreaParam, catalogNumberParam, classIDParam, classNumberParam}
	req.URL.RawQuery = strings.ReplaceAll(strings.Join(params, "&"), " ", "%20")

	logger.WithField("URL", req.URL.String()).Info("Making request for section details URL")
	response, err := fetchutil.Client.Do(req)

	if err != nil {
		return nil, err
	}
	if response.StatusCode != http.StatusOK {
		return nil, fetchutil.ErrStatusCode
	}
	defer response.Body.Close()

	doc, err := goquery.NewDocumentFromReader(response.Body)
	if err != nil {
		return nil, err
	}

	return doc, nil
}
