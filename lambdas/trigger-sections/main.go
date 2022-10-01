package main

import (
	"context"
	"encoding/json"

	"github.com/aws/aws-sdk-go/aws"
	lambdasdk "github.com/aws/aws-sdk-go/service/lambda"
	log "github.com/sirupsen/logrus"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/params"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

var defaultLambdaName = "fetch-sections"

func init() {
	envutil.Init()
}

func main() {
	envutil.Start(HandleRequest)
}

func HandleRequest(ctx context.Context, param params.TriggerSections) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "HandleRequest")
	defer span.Finish()
	logger.WithField("param", param).Info("Starting request")

	// Validate params
	term := param.Term
	err := term.Validate()
	if err != nil {
		logger.Error(err)
		return err
	}
	logger = logger.WithField("term", term)
	logger.Info("Received term")

	courses, err := RetrieveCourses(ctx, term)
	if err != nil {
		return err
	}

	lambdaClient, err := envutil.InitLambdaClient()
	if err != nil {
		logger.WithError(err).Error("Could not initialize lambda client")
		return err
	}

	batchSize := envutil.InitBatchSize()

	for i := 0; i < len(courses); i += batchSize {
		j := envutil.FindBatchEnd(i, batchSize, len(courses))
		coursesBatch := courses[i:j]
		StartLambda(
			ctx,
			lambdaClient,
			term,
			coursesBatch,
			param.ShouldInsertEnrollmentData,
		)
	}

	return nil
}

func StartLambda(
	ctx context.Context,
	lambdaClient *lambdasdk.Lambda,
	term registrar.Term,
	courses []registrar.Course,
	shouldInsertEnrollmentData bool,
) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "StartLambda")
	defer span.Finish()

	lambdaParams, err := json.Marshal(params.FetchSections{
		Term:                       term,
		Courses:                    courses,
		ShouldInsertEnrollmentData: shouldInsertEnrollmentData,
	})
	if err != nil {
		logger.WithError(err).Error("Unable to marshal lambda param")
		return
	}

	logger = logger.WithFields(log.Fields{
		"lambda_name": defaultLambdaName,
		"params":      lambdaParams,
	})

	// Note: we invoke fetch-sections syncronously, as a way of rate limiting
	// as to avoid overwhelming the registrar's servers
	input := &lambdasdk.InvokeInput{
		Payload:      lambdaParams,
		FunctionName: aws.String(defaultLambdaName),
		Qualifier:    nil,
	}
	isDryRun := envutil.InitIsDryRun()
	if isDryRun {
		input.InvocationType = aws.String(lambdasdk.InvocationTypeDryRun)
	}

	logger.Info("Invoking lambda")
	output, err := lambdaClient.InvokeWithContext(ctx, input)
	logger.WithField("status", output.StatusCode).Info("Invoked lambda")
	if err != nil {
		logger.WithError(err).Error("Error invoking lambda function")
		return
	}
}
