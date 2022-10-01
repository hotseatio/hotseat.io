package registrar

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestTermValidate_Valid(t *testing.T) {
	term := Term{
		ID:   67,
		Term: "21W",
	}

	err := term.Validate()
	require.NoError(t, err)
}

func TestTermValidate_Invalid(t *testing.T) {
	term := Term{
		ID:   0,
		Term: "21W",
	}

	err := term.Validate()
	require.Error(t, err)
}

func TestTermIsSummer_False(t *testing.T) {
	term := Term{
		ID:   67,
		Term: "98S",
	}

	assert.False(t, term.IsSummer())
}

func TestTermIsSummer_True(t *testing.T) {
	term := Term{
		ID:   67,
		Term: "981",
	}

	assert.True(t, term.IsSummer())
}

func TestSubjectAreaValidate_Valid(t *testing.T) {
	subjectArea := SubjectArea{
		ID:   42,
		Name: "Computer Science",
		Code: "COM SCI",
	}

	err := subjectArea.Validate()
	require.NoError(t, err)
}

func TestSubjectAreaValidate_Invalid(t *testing.T) {
	subjectArea := SubjectArea{
		ID:   42,
		Name: "Computer Science",
	}

	err := subjectArea.Validate()
	require.Error(t, err)
}

func TestCourseValidate_Valid(t *testing.T) {
	course := Course{
		ID:            2734,
		SubjectAreaID: 42,
		Title:         "Introduction to Computer Science I",
		Number:        "31",
	}

	err := course.Validate()
	require.NoError(t, err)
}

func TestCourseValidate_Invalid(t *testing.T) {
	course := Course{}

	err := course.Validate()
	require.Error(t, err)
}

func TestSplitCourseNumber(t *testing.T) {
	courseNumber := "CM152B"
	leadingChars, number, trailingChars := splitCourseNumber(courseNumber)
	assert.Equal(t, "CM", leadingChars)
	assert.Equal(t, "152", number)
	assert.Equal(t, "B", trailingChars)
}
