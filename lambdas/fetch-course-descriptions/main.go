package main

import (
	"context"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/params"
)

func init() {
	envutil.Init()
}

func main() {
	envutil.Start(HandleRequest)
}

func HandleRequest(ctx context.Context, params params.FetchCourseDescriptions) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "HandleRequest")
	defer span.Finish()

	logger.WithField("params", params).Info("Starting request")

	subjectArea := params.SubjectArea
	err := subjectArea.Validate()
	if err != nil {
		logger.WithError(err).Error("Invalid subject area param")
		return err
	}

	doc, err := FetchCourseDescriptions(ctx, subjectArea)
	if err != nil {
		return err
	}

	courses, err := ParseCourseDescriptions(subjectArea, doc)
	if err != nil {
		return err
	}

	err = SaveCourseDescriptions(ctx, courses)
	if err != nil {
		return err
	}

	return nil

}
