package main

import (
	"context"
	"io"
	"net/http"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/fetchutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
	log "github.com/sirupsen/logrus"
)

const (
	URL string = "https://api.ucla.edu/sis/publicapis/course/getcoursedetail"
)

func FetchCourseDescriptions(
	ctx context.Context,
	subjectArea registrar.SubjectArea,
) ([]byte, error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "FetchCourseDescriptions")
	defer span.Finish()

	req, err := http.NewRequestWithContext(ctx, http.MethodGet, URL, nil)
	if err != nil {
		logger.WithError(err).Error("Unable to create request")
		return nil, err
	}

	query := req.URL.Query()
	query.Add("subjectarea", subjectArea.Code)
	req.URL.RawQuery = query.Encode()
	logger = logger.WithField("url", req.URL.String())

	logger.Info("Fetching URL")
	response, err := fetchutil.Client.Do(req)
	if err != nil {
		logger.WithError(err).Error("Unable to fetch URL")
		return nil, err
	}
	defer response.Body.Close()

	if response.StatusCode != http.StatusOK {
		err := fetchutil.ErrStatusCode
		logger.WithError(err).WithFields(log.Fields{"code": response.StatusCode, "status": response.Status}).Error("Response status not OK")
		return nil, err
	}

	content, err := io.ReadAll(response.Body)
	if err != nil {
		log.Error(err)
		return nil, err
	}
	log.WithFields(log.Fields{"response": string(content)}).Info("Response received")

	return content, nil
}
