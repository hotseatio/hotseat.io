// Package envutil provides functions to easily initialize various settings and variables used by multiple lambdas.
package envutil

import (
	"os"
	"strconv"
	"time"

	"github.com/aws/aws-sdk-go/aws/session"
	lambdasdk "github.com/aws/aws-sdk-go/service/lambda"
	traceaws "gopkg.in/DataDog/dd-trace-go.v1/contrib/aws/aws-sdk-go/aws"
)

// Default options.
var (
	defaultDryRun                = false
	defaultBatchSize             = 20
	defaultMaxGoroutines         = 10
	defaultUsePreparedStatements = false
	defaultLambdaInvokeDelay     = 50 * time.Millisecond
)

// InitLambdaInvokeDelay reads the LAMBDA_INVOKE_DELAY_MS environment variable, used by trigger functions.
func InitLambdaInvokeDelay() time.Duration {
	lambdaInvokeDelay := defaultLambdaInvokeDelay
	if envLambdaInvokeDelay, err := strconv.Atoi(os.Getenv("LAMBDA_INVOKE_DELAY_MS")); err == nil {
		lambdaInvokeDelay = time.Duration(envLambdaInvokeDelay) * time.Millisecond
	}
	return lambdaInvokeDelay
}

// InitIsDryRun reads the DRY_RUN environment variable, used by trigger functions.
func InitIsDryRun() bool {
	dryRun := defaultDryRun
	if envDryRun, boolErr := strconv.ParseBool(os.Getenv("DRY_RUN")); boolErr == nil {
		dryRun = envDryRun
	}
	return dryRun
}

// InitBatchSize reads the BATCH_SIZE environment variable, used by trigger
// functions that batch inputs to fetch functions.
func InitBatchSize() int {
	batchSize := defaultBatchSize
	if envBatchSize, err := strconv.Atoi(os.Getenv("BATCH_SIZE")); err == nil {
		batchSize = envBatchSize
	}
	return batchSize
}

// FindBatchEnd finds the end index of a slice given its length, batch size, and
// starting index.
func FindBatchEnd(i, batchSize, length int) int {
	j := i + batchSize
	if j > length {
		j = length
	}
	return j
}

// InitLambdaClient establishes an AWS lambda client.
func InitLambdaClient() (*lambdasdk.Lambda, error) {
	awsSession, err := session.NewSessionWithOptions(session.Options{
		SharedConfigState: session.SharedConfigEnable,
	})
	if err != nil {
		return nil, err
	}
	awsSession = traceaws.WrapSession(awsSession)
	return lambdasdk.New(awsSession), nil
}

// InitMaxGoroutines reads the MAX_GOROUTINES environment varialble, which sets
// an upper limit on the number of concurrent goroutines in a lambda.
func InitMaxGoroutines() int {
	maxGoroutines := defaultMaxGoroutines
	if envMaxGoroutines, err := strconv.Atoi(os.Getenv("MAX_GOROUTINES")); err == nil {
		maxGoroutines = envMaxGoroutines
	}
	return maxGoroutines
}

func InitUsePreparedStatements() bool {
	usePreparedStatements := defaultUsePreparedStatements
	if envUsePreparedStatements, err := strconv.ParseBool(os.Getenv("USE_PREPARED_STATEMENTS")); err == nil {
		usePreparedStatements = envUsePreparedStatements
	}
	return usePreparedStatements
}
