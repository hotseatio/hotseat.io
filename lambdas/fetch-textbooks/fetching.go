package main

import (
	"context"
	"fmt"
	"io"
	"net/http"

	log "github.com/sirupsen/logrus"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/fetchutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

const netsuiteURL = "https://5803383.extforms.netsuite.com/app/site/hosting/scriptlet.nl"
const uclaStoreURL = "https://www.uclastore.com/sca-dev-2020-2-0/extensions/CampusStores/AdoptionSearchExtension/1.2.1/services/AdoptionSearch.Service.ss"

func FetchUCLAStoreCourseID(ctx context.Context, section registrar.Section, term registrar.Term) ([]byte, error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "FetchUCLAStoreCourseID")
	defer span.Finish()

	req, err := http.NewRequestWithContext(ctx, http.MethodGet, netsuiteURL, nil)
	if err != nil {
		log.Error(err)
		return make([]byte, 0), err
	}
	query := req.URL.Query()
	query.Add("script", "733")
	query.Add("deploy", "1")
	query.Add("compid", "5803383")
	query.Add("h", "fe05b6f2a8e5377c4d03")
	query.Add("asucla_courseid", term.Term+section.RegistrarID)
	req.URL.RawQuery = query.Encode()

	log.Info(fmt.Sprintf("Making request to %s", req.URL))
	response, err := fetchutil.Client.Do(req)
	if err != nil {
		log.Error(err)
		return make([]byte, 0), err
	}
	defer response.Body.Close()
	if response.StatusCode != http.StatusOK {
		err := fetchutil.ErrStatusCode
		logger.WithError(err).WithFields(log.Fields{"code": response.StatusCode}).Error("Response status not OK")
		return nil, err
	}

	content, err := io.ReadAll(response.Body)
	if err != nil {
		log.Error(err)
		return make([]byte, 0), err
	}
	log.Info("Response received")

	return content, nil
}

func FetchTextbooks(ctx context.Context, courseID string) ([]byte, error) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "FetchTextbooks")
	defer span.Finish()

	req, err := http.NewRequestWithContext(ctx, http.MethodGet, uclaStoreURL, nil)
	if err != nil {
		log.Error(err)
		return make([]byte, 0), err
	}
	query := req.URL.Query()
	query.Add("ccId", courseID)
	query.Add("searchAdoptions", "true")
	req.URL.RawQuery = query.Encode()

	log.Info(fmt.Sprintf("Making request to %s", uclaStoreURL))
	response, err := fetchutil.Client.Do(req)
	if err != nil {
		log.Error(err)
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
		log.Error(err)
		return make([]byte, 0), err
	}
	log.Info("Response received")

	return content, nil
}
