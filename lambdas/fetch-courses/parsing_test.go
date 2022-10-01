package main

import (
	"flag"
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
	"github.com/nathunsmitty/hotseat.io/lambdas/testutil"
)

func TestMain(m *testing.M) {
	flag.Parse()
	os.Exit(m.Run())
}

func TestParseFirstPage_NoResults(t *testing.T) {
	courseMap := make(map[string]*registrar.Course)
	doc := testutil.ReadFixtureToDocument(t, "no-results.html")
	ctx := testutil.MockContext(t)

	pageCount, err := ParseFirstPage(ctx, 42, doc, courseMap)
	assert.Equal(t, 0, pageCount)
	assert.Error(t, err)
	assert.Equal(t, 0, len(courseMap))
}

func TestParseFirstPage(t *testing.T) {
	courseMap := make(map[string]*registrar.Course)
	doc := testutil.ReadFixtureToDocument(t, "fall2020-comsci.html")
	ctx := testutil.MockContext(t)

	pageCount, err := ParseFirstPage(ctx, 42, doc, courseMap)
	require.NoError(t, err)
	assert.Equal(t, 3, pageCount)
}

func TestParseFirstPageModel(t *testing.T) {
	doc := testutil.ReadFixtureToDocument(t, "fall2020-comsci.html")
	ctx := testutil.MockContext(t)

	model := ParseFirstPageModel(ctx, doc)
	testutil.RequireGoldenMatch(t, "fall2020-comsci-model.json", model)
}

func TestParseCourses(t *testing.T) {
	courseMap := make(map[string]*registrar.Course)
	var subjectAreaID int64 = 42
	doc := testutil.ReadFixtureToDocument(t, "fall2020-comsci.html")
	ctx := testutil.MockContext(t)

	ParseCourses(ctx, subjectAreaID, doc, courseMap)
	testutil.RequireGoldenMatch(t, "fall2020-comsci-courses.json", courseMap)
}

func TestParseCourses_SecondPage(t *testing.T) {
	courseMap := make(map[string]*registrar.Course)
	var subjectAreaID int64 = 42
	doc := testutil.ReadFixtureToDocument(t, "spring2021-comsci-page2.html")
	ctx := testutil.MockContext(t)

	ParseCourses(ctx, subjectAreaID, doc, courseMap)
	testutil.RequireGoldenMatch(t, "spring2021-comsci-courses.json", courseMap)
}
