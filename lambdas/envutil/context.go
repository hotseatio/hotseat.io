package envutil

import (
	"context"
	"time"

	log "github.com/sirupsen/logrus"
	"gopkg.in/DataDog/dd-trace-go.v1/ddtrace"
	"gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer"
)

type loggerKey struct{}

// GetLoggerAndNewSpan starts a new ddtrace span on the context and retreives the logger
// on the context, creating a new logger if one does not exist.
func GetLoggerAndNewSpan(ctx context.Context, spanLabel string) (ddtrace.Span, log.FieldLogger, context.Context) {
	span, ctx := tracer.StartSpanFromContext(ctx, spanLabel)
	logger, ctx := GetLogger(ctx)
	return span, logger, ctx
}

// GetLogger returns the logger on a context. If a logger doesn't exist,
// one is created.
func GetLogger(ctx context.Context) (log.FieldLogger, context.Context) {
	logger, ok := ctx.Value(loggerKey{}).(log.FieldLogger)
	// Create logger if it doesn't exist
	if !ok {
		logger = log.WithContext(ctx)
		ctx = WithLogger(ctx, logger)
	}
	return logger, ctx
}

// WithLogger adds a logger to a context.
func WithLogger(ctx context.Context, logger log.FieldLogger) context.Context {
	return context.WithValue(ctx, loggerKey{}, logger)
}

// CensorDeadline returns a context that inherits values from ctx but will
// never be canceled.
func CensorDeadline(ctx context.Context) context.Context {
	return censorDeadline{ctx}
}

type censorDeadline struct{ c context.Context }

func (c censorDeadline) Deadline() (time.Time, bool)       { return time.Time{}, false }
func (c censorDeadline) Done() <-chan struct{}             { return nil }
func (c censorDeadline) Value(key interface{}) interface{} { return c.c.Value(key) }
func (c censorDeadline) Err() error                        { return nil }
