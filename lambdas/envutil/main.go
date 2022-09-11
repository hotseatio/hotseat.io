package envutil

import (
	"os"

	ddlambda "github.com/DataDog/datadog-lambda-go"
	"github.com/aws/aws-lambda-go/lambda"
	opentracing "github.com/opentracing/opentracing-go"
	log "github.com/sirupsen/logrus"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil/opentracer"
)

// Init should be called from the init() function in every lambda. It performs
// once-per-process setup like logging and tracing.
func Init() {
	InitLogging()
	InitTracing()
}

// InitLogging sets up logging for a lambda.
func InitLogging() {
	if os.Getenv("LOGGING") == "json" {
		log.SetFormatter(&log.JSONFormatter{})
	}

	log.SetOutput(os.Stdout)

	logLevel := os.Getenv("LOG_LEVEL")
	if logLevel == "info" {
		log.SetLevel(log.InfoLevel)
		log.Info("Log level set to info")
	} else {
		log.SetLevel(log.WarnLevel)
		log.WithField("LOG_LEVEL", logLevel).Warn("Log level set to warn")
	}

	log.Info("Logging Initialized")
}

// InitTracing sets a Datadog-compatible tracer as the global tracer for
// OpenTracing.
func InitTracing() {
	opentracing.SetGlobalTracer(opentracer.Default)
}

// Start starts a AWS Lambda function with the given handler. See
// https://pkg.go.dev/github.com/aws/aws-lambda-go/lambda#Start
// on requirements for the handler function.
func Start(handler interface{}) {
	lambda.Start(ddlambda.WrapHandler(handler, nil))
}
