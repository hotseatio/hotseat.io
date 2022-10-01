package main

import (
	"flag"
	"os"
	"testing"

	"github.com/nathunsmitty/hotseat.io/lambdas/testutil"
	"github.com/stretchr/testify/require"
)

func TestMain(m *testing.M) {
	flag.Parse()
	os.Exit(m.Run())
}

func TestParseSubjectAreas_Fall2020(t *testing.T) {
	input := testutil.ReadFixture(t, "fall2020.html")
	ctx := testutil.MockContext(t)

	subjectAreas, err := ParseSubjectAreas(ctx, input)

	require.NoError(t, err)
	testutil.RequireGoldenMatch(t, "fall2020.golden", subjectAreas)
}

func TestParseSubjectAreas_Spring2021(t *testing.T) {
	input := testutil.ReadFixture(t, "spring2021.html")
	ctx := testutil.MockContext(t)

	subjectAreas, err := ParseSubjectAreas(ctx, input)

	require.NoError(t, err)
	testutil.RequireGoldenMatch(t, "spring2021.golden", subjectAreas)
}
