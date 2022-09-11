package main

import (
	"context"
	"fmt"
	"net/http"
	"net/url"
	"os"
	"strings"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/fetchutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

func NotifySubscribedUsers(
	ctx context.Context,
	course registrar.Course,
	section registrar.Section,
	prevEnrollmentNumbers registrar.EnrollmentNumbers,
) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "NotifySubscribedUsers")
	defer span.Finish()

	users, err := GetSubscribedUsers(ctx, section)
	if err != nil {
		logger.WithError(err).Error("Could not retrieve subscribed users")
		return err
	}
	if len(users) == 0 {
		return nil
	}
	message := FormatMessage(course, section, prevEnrollmentNumbers)
	for _, user := range users {
		SendNotificationToUser(ctx, user, message)
	}

	return nil
}

func FormatMessage(
	course registrar.Course,
	section registrar.Section,
	prevEnrollmentNumbers registrar.EnrollmentNumbers,
) string {
	message := fmt.Sprintf("Hotseat Alert: %s enrollment status changed from %s to %s", course.ShortTitle(), prevEnrollmentNumbers.EnrollmentStatus, section.EnrollmentStatus)

	if section.EnrollmentStatus == "Open" || section.EnrollmentStatus == "Waitlist" {
		message += fmt.Sprintf("\n\nEnroll now: https://hotseat.io/enroll/%d", section.ID)
	}

	return message
}

func TwilioSenderNumber() string {
	return os.Getenv("TWILIO_SENDER_NUMBER")
}

func TwilioSID() string {
	return os.Getenv("TWILIO_SID")
}

func TwilioAuthToken() string {
	return os.Getenv("TWILIO_AUTH_TOKEN")
}

func TwilioRequestURL() string {
	return "https://api.twilio.com/2010-04-01/Accounts/" + TwilioSID() + "/Messages.json"
}

func SendNotificationToUser(
	ctx context.Context,
	user registrar.User,
	message string,
) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "SendNotificationToUser")
	defer span.Finish()
	logger = logger.WithField("user", user.ID)
	logger.Info("Sending notification to user")

	msgData := url.Values{}
	msgData.Set("To", user.Phone)
	msgData.Set("From", TwilioSenderNumber())
	msgData.Set("Body", message)
	req, err := http.NewRequestWithContext(ctx, http.MethodPost, TwilioRequestURL(), strings.NewReader(msgData.Encode()))
	if err != nil {
		return err
	}

	req.SetBasicAuth(TwilioSID(), TwilioAuthToken())
	req.Header.Add("Accept", "application/json")
	req.Header.Add("Content-Type", "application/x-www-form-urlencoded")

	// Make HTTP POST request and return message SID
	response, err := fetchutil.Client.Do(req)
	if err != nil {
		return err
	}
	if response.StatusCode != http.StatusOK {
		return fetchutil.ErrStatusCode
	}
	defer response.Body.Close()

	logger.Info("Notification successful!")

	return nil
}
