package pgxtrace

import (
	"context"

	"github.com/jackc/pgconn"
)

// from https://github.com/DataDog/dd-trace-go/blob/v1.28.0/contrib/database/sql/option.go

// Option represents an option that can be passed to Register, Open or OpenDB.
type Option func(*config)

// WithServiceName sets the given service name when registering a driver,
// or opening a database connection.
func WithServiceName(name string) Option {
	return func(cfg *config) {
		cfg.serviceName = name
	}
}

type queryType string

const (
	queryTypeQuery    queryType = "Query"
	queryTypePrepare  queryType = "Prepare"
	queryTypeExec     queryType = "Exec"
	queryTypeBegin    queryType = "Begin"
	queryTypeCommit   queryType = "Commit"
	queryTypeRollback queryType = "Rollback"
	queryTypeBatch    queryType = "Batch"
	queryTypeClose    queryType = "Close"
)

func (qt queryType) String() string { return string(qt) }

type traceParams struct {
	cfg  *config
	meta map[string]string
}

type config struct {
	serviceName string
}

type spanTagsKey struct{}

// WithSpanTags creates a new context containing the given set of tags.
// They will be added to any query created with the returned context.
func WithSpanTags(ctx context.Context, tags map[string]string) context.Context {
	return context.WithValue(ctx, spanTagsKey{}, tags)
}

func configToMeta(config *pgconn.Config) map[string]string {
	if config == nil {
		return nil
	}
	meta := make(map[string]string)
	meta["database"] = config.Database
	meta["host"] = config.Host
	meta["user"] = config.User
	for key, value := range config.RuntimeParams {
		meta[key] = value
	}
	return meta
}
