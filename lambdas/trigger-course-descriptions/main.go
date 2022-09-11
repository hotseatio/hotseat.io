package main

import (
	"context"
	"encoding/json"
	"time"

	"github.com/aws/aws-sdk-go/aws"
	lambdasdk "github.com/aws/aws-sdk-go/service/lambda"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/params"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

var defaultLambdaName = "fetch-course-descriptions"

func init() {
	envutil.Init()
}

func main() {
	envutil.Start(HandleRequest)
}

func HandleRequest(ctx context.Context) error {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "StartLambda")
	defer span.Finish()
	logger.Info("Starting request")

	subjectAreas, err := RetrieveSubjectAreas(ctx)
	if err != nil {
		logger.WithError(err).Error("Unable to query subject areas")
		return err
	}

	lambdaClient, err := envutil.InitLambdaClient()
	if err != nil {
		logger.WithError(err).Error("Could not initialize lambda client")
		return err
	}

	for _, subjectArea := range subjectAreas {
		StartLambda(
			ctx,
			lambdaClient,
			subjectArea,
		)
		// Space requests out so we don't overload the server
		time.Sleep(envutil.InitLambdaInvokeDelay())
	}

	logger.Info("Finished successfully!")
	return nil
}

func StartLambda(
	ctx context.Context,
	lambdaClient *lambdasdk.Lambda,
	subjectArea registrar.SubjectArea,
) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "StartLambda")
	defer span.Finish()

	lambdaParams, err := json.Marshal(params.FetchCourseDescriptions{
		SubjectArea: subjectArea,
	})
	if err != nil {
		logger.WithError(err).Error("Unable to marshal lambda param")
		return
	}

	logger = logger.WithField("lambda_name", defaultLambdaName)

	input := &lambdasdk.InvokeInput{
		Payload:        lambdaParams,
		FunctionName:   aws.String(defaultLambdaName),
		Qualifier:      nil,
		InvocationType: aws.String(lambdasdk.InvocationTypeEvent), // async execution
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
