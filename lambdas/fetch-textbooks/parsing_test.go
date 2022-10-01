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

func TestParseTextbooks_1(t *testing.T) {
	ctx := testutil.MockContext(t)
	input := testutil.ReadFixture(t, "winter2022-ls-107.json")
	textbooks, err := ParseTextbooks(ctx, input)
	require.NoError(t, err)
	testutil.RequireGoldenMatch(t, "winter2022-ls-107.golden", textbooks)
}
