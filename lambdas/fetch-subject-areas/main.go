package main

import (
	"context"
	"fmt"
	"io"
	"net/http"

	log "github.com/sirupsen/logrus"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/fetchutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/params"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

type RawSubjectArea struct {
	Label string `json:"label"`
	Value string `json:"value"`
}

func RequestSubjectAreas(ctx context.Context, term registrar.Term) ([]byte, error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "RequestSubjectAreas")
	defer span.Finish()

	const url = "https://sa.ucla.edu/ro/ClassSearch/Public/Search/GetSimpleSearchData"
	req, err := http.NewRequestWithContext(ctx, "GET", url, nil)
	if err != nil {
		logger.Error(err)
		return make([]byte, 0), err
	}
	req.Header.Add("X-Requested-With", "XMLHttpRequest")
	query := req.URL.Query()
	query.Add("term_cd", term.Term)
	query.Add("search_type", "subject")
	req.URL.RawQuery = query.Encode()

	logger.Info(fmt.Sprintf("Making request to %s", url))
	response, err := fetchutil.Client.Do(req)
	if err != nil {
		logger.Error(err)
		return make([]byte, 0), err
	}
	defer response.Body.Close()
	if response.StatusCode != http.StatusOK {
		err := fetchutil.ErrStatusCode
		logger.WithError(err).WithFields(log.Fields{"code": response.StatusCode, "status": response.Status}).Error("Response status not OK")
		return nil, err
	}

	content, err := io.ReadAll(response.Body)
	if err != nil {
		logger.Error(err)
		return make([]byte, 0), err
	}
	logger.WithFields(log.Fields{"response": string(content)}).Info("Response received")

	return content, nil
}

func HandleRequest(ctx context.Context, param params.FetchSubjectAreas) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "HandleRequest")
	defer span.Finish()

	term := param.Term
	err := term.Validate()
	if err != nil {
		logger.Error(err)
		return err
	}

	content, err := RequestSubjectAreas(ctx, term)
	if err != nil {
		return err
	}
	subjectAreas, err := ParseSubjectAreas(ctx, content)
	if err != nil {
		return err
	}
	err = SaveSubjectAreas(ctx, subjectAreas)
	if err != nil {
		return err
	}

	logger.Info("fetch-subject-areas finished successfully")

	return nil
}

func init() {
	envutil.Init()
}

func main() {
	envutil.Start(HandleRequest)
}
