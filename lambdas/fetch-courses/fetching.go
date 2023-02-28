package main

import (
	"context"
	"net/http"
	"strconv"

	"github.com/PuerkitoBio/goquery"
	log "github.com/sirupsen/logrus"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/fetchutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

const (
	FirstPageURL      string = "https://sa.ucla.edu/ro/Public/SOC/Results"
	AdditionalPageURL string = "https://sa.ucla.edu/ro/Public/SOC/Results/CourseTitlesView"
)

// Retrieves the first page of a list of courses by subject area.
func FetchFirstPage(ctx context.Context, subjectArea registrar.SubjectArea, term string) (*goquery.Document, error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "FetchFirstPage")
	defer span.Finish()

	req, err := http.NewRequestWithContext(ctx, http.MethodGet, FirstPageURL, nil)
	if err != nil {
		logger.WithError(err).Error("Unable to create request")
		return nil, err
	}

	query := req.URL.Query()
	query.Add("t", term)
	query.Add("sBy", "subject")
	query.Add("subj", subjectArea.Code)
	req.URL.RawQuery = query.Encode()
	logger = logger.WithField("url", req.URL.String())

	logger.Info("Fetching first page URL")
	response, err := fetchutil.Client.Do(req)
	if err != nil {
		logger.WithError(err).Error("Unable to fetch URL")
		return nil, err
	}
	defer response.Body.Close()

	if response.StatusCode != http.StatusOK {
		err := fetchutil.ErrStatusCode
		logger.WithError(err).WithFields(log.Fields{"code": response.StatusCode, "status": response.Status}).Warn("Response status not OK")
		return nil, err
	}

	doc, err := goquery.NewDocumentFromReader(response.Body)
	if err != nil {
		logger.WithError(err).Error("Unable to read document with goquery")
	}
	return doc, err
}

// Retrieves additional pages of a subject area's course list.
func FetchAdditionalPage(ctx context.Context, model string, pageNumber int) (*goquery.Document, error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "FetchAdditionalPage")
	defer span.Finish()

	req, err := http.NewRequestWithContext(ctx, http.MethodGet, AdditionalPageURL, nil)
	if err != nil {
		logger.WithError(err).Error("Unable to create request")
		return nil, err
	}

	// This header is required, otherwise we get a 404
	req.Header.Add("X-Requested-With", "XMLHttpRequest")
	query := req.URL.Query()
	query.Add("model", model)
	query.Add("search_by", "subject")
	query.Add("filterFlags", registrar.FilterFlags)
	query.Add("pageNumber", strconv.Itoa(pageNumber))
	req.URL.RawQuery = query.Encode()
	logger = logger.WithField("url", req.URL.String())

	logger.Info("Fetching additional page URL")
	response, err := fetchutil.Client.Do(req)
	if err != nil {
		logger.WithError(err).Error("Unable to fetch URL")
		return nil, err
	}
	defer response.Body.Close()

	if response.StatusCode != http.StatusOK {
		err := fetchutil.ErrStatusCode
		logger.WithError(err).WithFields(log.Fields{"code": response.StatusCode, "status": response.Status}).Warn("Response status not OK")
		return nil, err
	}

	doc, err := goquery.NewDocumentFromReader(response.Body)
	if err != nil {
		logger.WithError(err).Error("Unable to read document with goquery")
	}
	return doc, err
}
