package parseutil

import (
	"regexp"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestCreateRegexMatchMap(t *testing.T) {
	closedByDeptRegex := regexp.MustCompile(`^Closed by Dept[a-zA-Z,/ ]*(\((?P<Capacity>\d+) capacity, (?P<EnrolledCount>\d+) enrolled, (?P<WaitlistedCount>\d+) waitlisted\))?`)
	input := "Closed by Dept Computer Science (0 capacity, 1 enrolled, 0 waitlisted)"
	matchMap := CreateRegexMatchMap(closedByDeptRegex, input)
	expectedMap := map[string]string{
		"Capacity":        "0",
		"EnrolledCount":   "1",
		"WaitlistedCount": "0",
	}

	assert.Equal(t, expectedMap, matchMap)
}

func TestCleanHTMLStrings(t *testing.T) {
	input := []string{"Nathan", "Tim   ", "    Mackenzie"}
	CleanHTMLStrings(input)
	assert.Equal(t, []string{"Nathan", "Tim", "Mackenzie"}, input)
}

func TestCleanHTMLString(t *testing.T) {
	s := "  \u0000  blah &amp; \u0000blah "
	assert.Equal(t, "blah & blah", CleanHTMLString(s))
}
