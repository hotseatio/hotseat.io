package main

import (
	"bytes"
	"context"
	"encoding/json"
	"net/http"
	"os"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/fetchutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
	log "github.com/sirupsen/logrus"
)

func NotifySubscribedUsers(
	ctx context.Context,
	section registrar.Section,
	prevEnrollmentNumbers registrar.EnrollmentNumbers,
) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "NotifySubscribedUsers")
	defer span.Finish()
	endpoint := os.Getenv("NOTIFICATION_ENDPOINT")
	token := os.Getenv("NOTIFICATION_ENDPOINT_TOKEN")

	requestBody, err := json.Marshal(map[string]interface{}{
		"section_id":                  section.ID,
		"previous_enrollment_numbers": prevEnrollmentNumbers,
	})
	if err != nil {
		return err
	}

	bearer := "Bearer " + token

	req, err := http.NewRequestWithContext(ctx, "POST", endpoint, bytes.NewReader(requestBody))
	if err != nil {
		return err
	}
	req.Header.Add("Authorization", bearer)
	req.Header.Add("Accept", "application/json")
	req.Header.Add("Content-Type", "application/json")

	logger.WithFields(log.Fields{"endpoint": endpoint, "section": section.ID}).Info("Making request to Hotseat to send notification")
	response, err := fetchutil.Client.Do(req)

	if err != nil {
		return err
	}
	if response.StatusCode != http.StatusOK {
		return fetchutil.ErrStatusCode
	}
	defer response.Body.Close()

	return nil
}
