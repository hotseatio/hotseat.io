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
	course registrar.Course,
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

// func FormatMessage(
// 	course registrar.Course,
// 	section registrar.Section,
// 	prevEnrollmentNumbers registrar.EnrollmentNumbers,
// ) string {
// 	message := fmt.Sprintf("Hotseat Alert: %s enrollment status changed from %s to %s", course.ShortTitle(), prevEnrollmentNumbers.EnrollmentStatus, section.EnrollmentStatus)

// 	if section.EnrollmentStatus == "Open" || section.EnrollmentStatus == "Waitlist" {
// 		message += fmt.Sprintf("\n\nEnroll now: https://hotseat.io/enroll/%d", section.ID)
// 	}

// 	message += fmt.Sprintf("\n\nAlready enrolled? Unsubscribe: https://hotseat.io/unsubscribe/%d", section.ID)

// 	return message
// }

// func SendNotificationToUser(
// 	ctx context.Context,
// 	user registrar.User,
// 	message string,
// ) {
// 	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "SendNotificationToUser")
// 	defer span.Finish()
// 	logger = logger.WithFields(log.Fields{"message": message, "user": user.ID})
// 	logger.Info("Sending notification to user")

// 	client := envutil.CreateAWSClient()
// 	input := &sns.PublishInput{
// 		Message:     aws.String(message),
// 		PhoneNumber: aws.String(user.Phone),
// 	}
// 	output, err := client.PublishWithContext(ctx, input)
// 	if err != nil {
// 		logger.WithError(err).Error("Could not send text message for user")
// 	}
// 	logger.WithField("messageID", *output.MessageId).Info("Notification successful!")
// }
