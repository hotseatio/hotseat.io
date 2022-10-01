package main

import (
	"flag"
	"os"
	"testing"

	"github.com/stretchr/testify/require"

	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
	"github.com/nathunsmitty/hotseat.io/lambdas/testutil"
)

func TestMain(m *testing.M) {
	flag.Parse()
	os.Exit(m.Run())
}

func TestParseCourseDescriptions(t *testing.T) {
	subjectArea := registrar.SubjectArea{
		ID:   42,
		Code: "COM SCI",
		Name: "Computer Science",
	}
	input := testutil.ReadFixture(t, "com-sci-2021.json")
	courses, err := ParseCourseDescriptions(subjectArea, input)
	require.NoError(t, err)
	testutil.RequireGoldenMatch(t, "com-sci-2021.golden", courses)
}
