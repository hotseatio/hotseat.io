package pgxtrace

import (
	"context"
	"time"

	"github.com/jackc/pgconn"
	"github.com/jackc/pgx/v4"
	"gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer"
)

type tracedBatchResults struct {
	pgx.BatchResults
	*traceParams
	ctx context.Context
}

var _ pgx.BatchResults = (*tracedBatchResults)(nil)

func (b *tracedBatchResults) Exec() (pgconn.CommandTag, error) {
	start := time.Now()
	tag, err := b.BatchResults.Exec()
	b.tryTrace(b.ctx, queryTypeExec, "", start, err)
	return tag, err
}

func (b *tracedBatchResults) Query() (pgx.Rows, error) {
	start := time.Now()
	rows, err := b.BatchResults.Query()
	b.tryTrace(b.ctx, queryTypeQuery, "", start, err)
	return rows, err
}

func (b *tracedBatchResults) QueryRow() pgx.Row {
	rows, _ := b.Query()
	return connRow{rows}
}

func (b *tracedBatchResults) Close() error {
	start := time.Now()
	err := b.BatchResults.Close()
	b.tryTrace(b.ctx, queryTypeClose, "", start, err)
	span, _ := tracer.SpanFromContext(b.ctx)
	span.Finish(tracer.WithError(err))
	return err
}
