package main

import (
	"context"
	"encoding/json"
	"time"

	"github.com/aws/aws-sdk-go/aws"
	lambdasdk "github.com/aws/aws-sdk-go/service/lambda"
	log "github.com/sirupsen/logrus"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/params"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

var defaultLambdaName = "fetch-courses"

func init() {
	envutil.Init()
}

func main() {
	envutil.Start(HandleRequest)
}

func HandleRequest(ctx context.Context, param params.TriggerCourses) error {
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

	subjectAreas, err := RetrieveSubjectAreas(ctx)
	if err != nil {
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
			term,
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
	term registrar.Term,
	subjectArea registrar.SubjectArea,
) {
	span, logger, ctx := envutil.GetLoggerAndNewSpan(ctx, "StartLambda")
	span.SetTag("subjectArea", subjectArea.Code)
	defer span.Finish()

	lambdaParams, err := json.Marshal(params.FetchCourses{
		Term:        term,
		SubjectArea: subjectArea,
	})
	if err != nil {
		logger.WithError(err).Error("Unable to marshal lambda param")
		return
	}

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

	logger.WithFields(log.Fields{
		"lambda_name": defaultLambdaName,
		"params":      string(lambdaParams),
	}).Info("Invoking lambda")
	output, err := lambdaClient.InvokeWithContext(ctx, input)
	logger.WithField("status", output.StatusCode).Info("Invoked lambda")
	if err != nil {
		logger.WithError(err).Error("Error invoking lambda function")
		return
	}
}
