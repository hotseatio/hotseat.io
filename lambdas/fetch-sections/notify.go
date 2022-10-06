package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/service/sns"
	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
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

func SendNotificationToUser(
	ctx context.Context,
	user registrar.User,
	message string,
) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "SendNotificationToUser")
	defer span.Finish()
	logger = logger.WithField("user", user.ID)
	logger.Info("Sending notification to user")

	client := envutil.CreateAWSClient()
	input := &sns.PublishInput{
		Message:     aws.String(message),
		PhoneNumber: aws.String(user.Phone),
	}
	output, err := client.PublishWithContext(ctx, input)
	if err != nil {
		return err
	}
	logger.WithField("messageID", *output.MessageId).Info("Notification successful!")

	return nil
}
