package pgxtrace

import (
	"context"
	"time"

	"github.com/jackc/pgconn"
	"github.com/jackc/pgx/v4"
)

type tracedTx struct {
	pgx.Tx
	*traceParams
}

var _ pgx.Tx = (*tracedTx)(nil)

func (t *tracedTx) Begin(ctx context.Context) (pgx.Tx, error) {
	start := time.Now()
	tx, err := t.Tx.Begin(ctx)
	t.tryTrace(ctx, queryTypeBegin, "", start, err)
	tx = &tracedTx{tx, t.traceParams}
	return tx, err
}

func (t *tracedTx) Commit(ctx context.Context) (err error) {
	start := time.Now()
	err = t.Tx.Commit(ctx)
	t.tryTrace(ctx, queryTypeCommit, "", start, err)
	return err
}

func (t *tracedTx) Rollback(ctx context.Context) error {
	start := time.Now()
	err := t.Tx.Rollback(ctx)
	t.tryTrace(ctx, queryTypeRollback, "", start, err)
	return err
}

func (t *tracedTx) Prepare(ctx context.Context, name, sql string) (*pgconn.StatementDescription, error) {
	start := time.Now()
	desc, err := t.Tx.Prepare(ctx, name, sql)
	t.tryTrace(ctx, queryTypePrepare, sql, start, err)
	return desc, err
}

func (t *tracedTx) Exec(ctx context.Context, sql string, args ...interface{}) (pgconn.CommandTag, error) {
	start := time.Now()
	tag, err := t.Tx.Exec(ctx, sql, args...)
	t.tryTrace(ctx, queryTypeExec, sql, start, err)
	return tag, err
}

func (t *tracedTx) Query(ctx context.Context, sql string, args ...interface{}) (pgx.Rows, error) {
	start := time.Now()
	rows, err := t.Tx.Query(ctx, sql, args...)
	t.tryTrace(ctx, queryTypeQuery, sql, start, err)
	return rows, err
}

func (t *tracedTx) QueryFunc(ctx context.Context, sql string, args []interface{}, scans []interface{}, f func(pgx.QueryFuncRow) error) (pgconn.CommandTag, error) {
	start := time.Now()
	tag, err := t.Tx.QueryFunc(ctx, sql, args, scans, f)
	t.tryTrace(ctx, queryTypeQuery, sql, start, err)
	return tag, err
}

func (t *tracedTx) QueryRow(ctx context.Context, sql string, args ...interface{}) pgx.Row {
	rows, _ := t.Query(ctx, sql, args...)
	return connRow{rows}
}
