package envutil

import (
	"context"
	"fmt"
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

func createDatabaseURL() (psqlInfo string) {
	host := os.Getenv("DB_HOST")
	port := os.Getenv("DB_PORT")
	user := os.Getenv("DB_USER")
	password := os.Getenv("DB_PASS")
	dbname := os.Getenv("DB_NAME")
	dbSSLMode := os.Getenv("DB_SSL_MODE")

	if password != "" {
		psqlInfo = fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=%s",
			host, port, user, password, dbname, dbSSLMode)
	} else {
		psqlInfo = fmt.Sprintf("host=%s port=%s user=%s dbname=%s sslmode=%s",
			host, port, user, dbname, dbSSLMode)
	}

	return psqlInfo
}

func CreateDatabasePool() (_ DB, err error) {
	dbOnce.Do(func() {
		db, err = createDatabasePool()
	})
	return db, err
}

func createDatabasePool() (DB, error) {
	connectionURL := createDatabaseURL()
	config, err := pgxpool.ParseConfig(connectionURL)
	if err != nil {
		log.WithField("connection", connectionURL).Error(err)
		return nil, err
	}
	config.ConnConfig.LogLevel = pgx.LogLevelWarn
	config.ConnConfig.Logger = logrusadapter.NewLogger(log.StandardLogger())
	config.MaxConns = 15
	usePreparedStatements := InitUsePreparedStatements()
	if !usePreparedStatements {
		config.ConnConfig.BuildStatementCache = nil
		config.ConnConfig.PreferSimpleProtocol = true
	}

	db, err := pgxtrace.ConnectPoolConfig(context.Background(), config, pgxtrace.WithServiceName("lambda-pgx"))
	if err != nil {
		log.WithField("connection", connectionURL).Error(err)
		return nil, err
	}

	return db, nil
}
