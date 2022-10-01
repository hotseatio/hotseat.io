// Package pgxtrace adds DataDog tracing support to pgx.
package pgxtrace

import (
	"context"
	"time"

	"github.com/jackc/pgconn"
	"github.com/jackc/pgx/v4"
	"github.com/jackc/pgx/v4/pgxpool"
	"gopkg.in/DataDog/dd-trace-go.v1/ddtrace"
	"gopkg.in/DataDog/dd-trace-go.v1/ddtrace/ext"
	"gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer"
)

// ConnectPool creates a new traced pgxpool.Pool, much like pgxpool.Connect.
// The original *pgxpool.Pool can be obtained through WrappedConn.Underlying.
func ConnectPool(ctx context.Context, connString string, opts ...Option) (WrappedConn, error) {
	config, err := pgxpool.ParseConfig(connString)
	if err != nil {
		return nil, err
	}
	return ConnectPoolConfig(ctx, config, opts...)
}

// ConnectPoolConfig creates a new traced pgxpool.Pool, much like
// pgxpool.ConnectConfig.
// The original *pgxpool.Pool can be obtained through WrappedConn.Underlying.
func ConnectPoolConfig(ctx context.Context, conf *pgxpool.Config, opts ...Option) (WrappedConn, error) {
	pool, err := pgxpool.ConnectConfig(ctx, conf)
	if err != nil {
		return nil, err
	}

	cfg := &config{}
	for _, opt := range opts {
		opt(cfg)
	}
	return &tracedConn{
		Conn: pool,
		traceParams: &traceParams{
			cfg:  cfg,
			meta: configToMeta(&conf.ConnConfig.Config),
		},
	}, nil
}

// Connect creates a new traced pgx.Conn, much like pgx.Connect.
// The original *pgx.Conn can be obtained through WrappedConn.Underlying.
func Connect(ctx context.Context, connString string, opts ...Option) (WrappedConn, error) {
	config, err := pgx.ParseConfig(connString)
	if err != nil {
		return nil, err
	}
	return ConnectConfig(ctx, config, opts...)
}

// ConnectConfig creates a new traced pgx.Conn, much like pgx.ConnectConfig.
// The original *pgx.Conn can be obtained through WrappedConn.Underlying.
func ConnectConfig(ctx context.Context, conf *pgx.ConnConfig, opts ...Option) (WrappedConn, error) {
	conn, err := pgx.ConnectConfig(ctx, conf)
	if err != nil {
		return nil, err
	}

	cfg := &config{}
	for _, opt := range opts {
		opt(cfg)
	}
	return &tracedConn{
		Conn: conn,
		traceParams: &traceParams{
			cfg:  cfg,
			meta: configToMeta(&conf.Config),
		},
	}, nil
}

// Conn abstracts a pgx connection. See pgx.Conn for documentation on
// individual methods.
type Conn interface {
	Begin(ctx context.Context) (pgx.Tx, error)
	BeginTx(ctx context.Context, txOptions pgx.TxOptions) (pgx.Tx, error)
	Exec(ctx context.Context, sql string, args ...interface{}) (pgconn.CommandTag, error)
	Query(ctx context.Context, sql string, args ...interface{}) (pgx.Rows, error)
	QueryFunc(ctx context.Context, sql string, args []interface{}, scans []interface{}, f func(pgx.QueryFuncRow) error) (pgconn.CommandTag, error)
	QueryRow(ctx context.Context, sql string, args ...interface{}) pgx.Row
	SendBatch(ctx context.Context, b *pgx.Batch) pgx.BatchResults
}

// WrappedConn is a wrapper of a Conn.
type WrappedConn interface {
	Conn
	Underlying() Conn
}

var _ Conn = (*pgxpool.Pool)(nil)
var _ Conn = (*pgx.Conn)(nil)
var _ WrappedConn = (*tracedConn)(nil)

type tracedConn struct {
	Conn
	*traceParams
}

func (c *tracedConn) Begin(ctx context.Context) (pgx.Tx, error) {
	start := time.Now()
	tx, err := c.Conn.Begin(ctx)
	c.tryTrace(ctx, queryTypeBegin, "", start, err)
	tx = &tracedTx{tx, c.traceParams}
	return tx, err
}

func (c *tracedConn) BeginTx(ctx context.Context, txOptions pgx.TxOptions) (pgx.Tx, error) {
	start := time.Now()
	tx, err := c.Conn.BeginTx(ctx, txOptions)
	c.tryTrace(ctx, queryTypeBegin, "", start, err)
	tx = &tracedTx{tx, c.traceParams}
	return tx, err
}

func (c *tracedConn) Exec(ctx context.Context, sql string, args ...interface{}) (pgconn.CommandTag, error) {
	start := time.Now()
	tag, err := c.Conn.Exec(ctx, sql, args...)
	c.tryTrace(ctx, queryTypeExec, sql, start, err)
	return tag, err
}

func (c *tracedConn) Query(ctx context.Context, sql string, args ...interface{}) (pgx.Rows, error) {
	start := time.Now()
	rows, err := c.Conn.Query(ctx, sql, args...)
	c.tryTrace(ctx, queryTypeQuery, sql, start, err)
	return rows, err
}

func (c *tracedConn) QueryFunc(ctx context.Context, sql string, args []interface{}, scans []interface{}, f func(pgx.QueryFuncRow) error) (pgconn.CommandTag, error) {
	start := time.Now()
	tag, err := c.Conn.QueryFunc(ctx, sql, args, scans, f)
	c.tryTrace(ctx, queryTypeQuery, sql, start, err)
	return tag, err
}

func (c *tracedConn) QueryRow(ctx context.Context, sql string, args ...interface{}) pgx.Row {
	rows, _ := c.Query(ctx, sql, args...)
	return connRow{rows}
}

func (c *tracedConn) SendBatch(ctx context.Context, b *pgx.Batch) pgx.BatchResults {
	_, ctx = c.startSpan(ctx, queryTypeBatch, "", time.Now())
	results := c.Conn.SendBatch(ctx, b)
	return &tracedBatchResults{
		BatchResults: results,
		traceParams:  c.traceParams,
		ctx:          ctx,
	}
}

func (c *tracedConn) Underlying() Conn {
	return c.Conn
}

func (tp *traceParams) startSpan(ctx context.Context, qtype queryType, query string, startTime time.Time) (tracer.Span, context.Context) {
	name := "pgx.query"
	opts := []ddtrace.StartSpanOption{
		tracer.ServiceName(tp.cfg.serviceName),
		tracer.SpanType(ext.SpanTypeSQL),
		tracer.StartTime(startTime),
	}
	span, ctx := tracer.StartSpanFromContext(ctx, name, opts...)
	resource := qtype.String()
	if query != "" {
		resource = query
	}
	span.SetTag(ext.ResourceName, resource)
	span.SetTag("sql.query_type", qtype.String())

	for k, v := range tp.meta {
		span.SetTag(k, v)
	}
	if meta, ok := ctx.Value(spanTagsKey{}).(map[string]string); ok {
		for k, v := range meta {
			span.SetTag(k, v)
		}
	}
	return span, ctx
}

func (tp *traceParams) tryTrace(ctx context.Context, qtype queryType, query string, startTime time.Time, err error) {
	span, _ := tp.startSpan(ctx, qtype, query, startTime)
	span.Finish(tracer.WithError(err))
}
