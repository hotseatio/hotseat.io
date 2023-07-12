package main

import (
	"bytes"
	"context"
	"encoding/json"
	"io/ioutil"
	"net/http"
	"os"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/fetchutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
	log "github.com/sirupsen/logrus"
)

type NotificationResponse struct {
	NotificationsSent int    `json:"notifications_sent,omitempty"`
	NotEnrollable     bool   `json:"not_enrollable,omitempty"`
	Error             string `json:"error,omitempty"`
}

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

	logger.WithField("endpoint", endpoint).Warn("Making request to Hotseat to send notification")
	// TODO: False positive from bodyclose here, maybe we can disable later.
	response, err := fetchutil.Client.Do(req) //nolint:bodyclose
	if err != nil {
		return err
	}
	defer response.Body.Close()

	if response.StatusCode != http.StatusOK {
		logger.WithFields(log.Fields{"endpoint": endpoint, "status code": response.StatusCode}).Error("Received a non-200 response from Hotseat")
		return fetchutil.ErrStatusCode
	}

	body, err := ioutil.ReadAll(response.Body)
	if err != nil {
		return err
	}

	parsedResponse := NotificationResponse{}
	err = json.Unmarshal(body, &response)
	if err != nil {
		logger.WithError(err).Error("Error parsing json response")
	}

	if parsedResponse.NotEnrollable {
		logger.Error("Section is not enrollable")
		return nil
	}

	logger.WithFields(log.Fields{"section": section.ID, "count": parsedResponse.NotificationsSent}).Warn("Sent notifications to users")

	return nil
}
