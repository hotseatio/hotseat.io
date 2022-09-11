package pgxtrace

import "github.com/jackc/pgx/v4"

// from https://github.com/jackc/pgx/blob/v4.10.1/rows.go

// connRow implements the Row interface for Conn.QueryRow.
type connRow struct{ rows pgx.Rows }

func (r connRow) Scan(dest ...interface{}) (err error) {
	rows := r.rows

	if rows.Err() != nil {
		return rows.Err()
	}

	if !rows.Next() {
		if rows.Err() == nil {
			return pgx.ErrNoRows
		}
		return rows.Err()
	}

	_ = rows.Scan(dest...)
	rows.Close()
	return rows.Err()
}
