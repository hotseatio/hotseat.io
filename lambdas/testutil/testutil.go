// testutil provides a set of utilities for testing our registrar functions, mainly around golden testing.
package testutil

import (
	"bytes"
	"context"
	"encoding/json"
	"flag"
	"io"
	"os"
	"testing"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/sirupsen/logrus/hooks/test"

	"github.com/PuerkitoBio/goquery"
	"github.com/stretchr/testify/require"
)

var shouldUpdate = flag.Bool("update", false, "Update the golden files of this test")

func MockContext(t *testing.T) context.Context {
	ctx := context.Background()
	if deadline, ok := t.Deadline(); ok {
		var cancel context.CancelFunc
		ctx, cancel = context.WithDeadline(ctx, deadline)
		t.Cleanup(cancel)
	}
	logger, _ := test.NewNullLogger()
	ctx = envutil.WithLogger(ctx, logger)
	return ctx
}

// readFile returns the entire content of a file, with spaces trimmed.
func readFile(f *os.File) ([]byte, error) {
	content, err := io.ReadAll(f)
	if err != nil {
		return nil, err
	}
	content = bytes.TrimSpace(content)
	return content, nil
}

func openFixture(t testing.TB, file string) *os.File {
	t.Helper()
	path := "testdata/fixtures/" + file

	f, err := os.Open(path)
	if err != nil {
		t.Fatalf("Error opening file %s: %s", path, err)
	}

	return f
}

func ReadFixtureToDocument(t testing.TB, file string) *goquery.Document {
	t.Helper()
	f := openFixture(t, file)
	defer f.Close()

	doc, err := goquery.NewDocumentFromReader(f)
	if err != nil {
		t.Fatalf("Error reading file %s: %s", f.Name(), err)
	}

	return doc
}

// ReadFixture reads a file in testdata/fixtures/ to establish some base state for a test.
func ReadFixture(t testing.TB, file string) []byte {
	t.Helper()
	f := openFixture(t, file)
	defer f.Close()

	content, err := readFile(f)
	if err != nil {
		t.Fatalf("Error reading file %s: %s", f.Name(), err)
	}

	return content
}

// EncodeToGolden takes an object and encodes it into an easy to diff format. Intended for writing to golden files.
func EncodeToGolden(t testing.TB, value interface{}) (output []byte) {
	switch v := value.(type) {
	case string:
		output = []byte(v)
	case []byte:
		output = v
	default:
		json, err := json.MarshalIndent(v, "", "  ")
		if err != nil {
			t.Fatalf("Error encoding newValue: %s", err)
		}
		output = json
	}
	return output
}

// ReadGoldenFile reads and returns a file in testdata/golden/. If the update flag is set, it updates that file.
func ReadGoldenFile(t testing.TB, file string, newValue interface{}) []byte {
	t.Helper()
	path := "testdata/golden/" + file

	if *shouldUpdate {
		f, err := os.Create(path)
		if err != nil {
			t.Fatalf("Error opening file %s: %s", path, err)
		}
		defer f.Close()

		encodedValue := EncodeToGolden(t, newValue)
		// Add a trailing newline for writing golden files.
		// Note that the trailing newline is stripped for comparison.
		output := append(encodedValue, '\n')
		_, err = f.Write(output)
		if err != nil {
			t.Fatalf("Error writing to file %s: %s", path, err)
		}

		return encodedValue
	}

	f, err := os.Open(path)
	if err != nil {
		t.Fatalf("Error opening file %s: %s", path, err)
	}
	defer f.Close()

	content, err := readFile(f)
	if err != nil {
		t.Fatalf("Error reading file %s: %s", path, err)
	}

	return content
}

// RequireGoldenMatch takes a golden file path and an object. Fails the test if the object does not match the file.
func RequireGoldenMatch(t testing.TB, goldenFilePath string, actualResult interface{}) {
	encodedResponse := EncodeToGolden(t, actualResult)
	expectedResponse := ReadGoldenFile(t, goldenFilePath, encodedResponse)
	require.Equal(t, string(expectedResponse), string(encodedResponse))
}
