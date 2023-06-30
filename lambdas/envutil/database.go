package envutil

import (
	"context"
	"os"
	"sync"

	"github.com/jackc/pgx/v4"
	"github.com/jackc/pgx/v4/log/logrusadapter"
	"github.com/jackc/pgx/v4/pgxpool"
	log "github.com/sirupsen/logrus"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil/pgxtrace"
)

type DB = pgxtrace.WrappedConn

var (
	db     DB
	dbOnce sync.Once
)

func CreateDatabaseConnection(ctx context.Context) (*pgx.Conn, error) {
	connectionURL := os.Getenv("DATABASE_URL")
	config, err := pgx.ParseConfig(connectionURL)
	if err != nil {
		log.WithField("connection", connectionURL).Error(err)
		return nil, err
	}
	config.LogLevel = pgx.LogLevelWarn
	config.Logger = logrusadapter.NewLogger(log.StandardLogger())

	conn, err := pgx.Connect(ctx, connectionURL)
	if err != nil {
		log.WithField("connection", connectionURL).Error(err)
		return nil, err
	}

	err = conn.Ping(ctx)
	if err != nil {
		log.WithField("connection", connectionURL).Error(err)
		return nil, err
	}

	log.Info("Connected to database")

	return conn, nil
}

func CreateDatabasePool() (_ DB, err error) {
	dbOnce.Do(func() {
		db, err = createDatabasePool()
	})
	return db, err
}

func createDatabasePool() (DB, error) {
	connectionURL := os.Getenv("DATABASE_URL")
	config, err := pgxpool.ParseConfig(connectionURL)
	if err != nil {
		log.WithField("connection", connectionURL).Error(err)
		return nil, err
	}
	config.ConnConfig.LogLevel = pgx.LogLevelWarn
	config.ConnConfig.Logger = logrusadapter.NewLogger(log.StandardLogger())
	config.MaxConns = 15

	db, err := pgxtrace.ConnectPoolConfig(context.Background(), config, pgxtrace.WithServiceName("lambda-pgx"))
	if err != nil {
		log.WithField("connection", connectionURL).Error(err)
		return nil, err
	}

	return db, nil
}
