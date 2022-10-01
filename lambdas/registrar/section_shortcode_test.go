package registrar

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestSectionShortcodeRead(t *testing.T) {
	shortcodeStr := "LAW 100-2 (REGISTRAR)"
	expectedShortcode := SectionShortcode{
		SubjectArea: "LAW",
		Number:      "100",
		Index:       "2",
	}

	shortcode := SectionShortcode{}
	shortcode.Read(shortcodeStr)
	assert.Equal(t, expectedShortcode, shortcode)
}

func TestSectionShortcodeWrite(t *testing.T) {
	shortcode := SectionShortcode{
		SubjectArea: "LAW",
		Number:      "100",
		Index:       "2",
	}
	expectedShortcodeStr := "LAW 100-2"

	shortcodeStr := shortcode.Write()
	assert.Equal(t, expectedShortcodeStr, shortcodeStr)
}

func TestSectionShortcodeLessThan(t *testing.T) {
	shortcode1 := SectionShortcode{
		SubjectArea: "COM SCI",
		Number:      "M151B",
		Index:       "2",
	}
	shortcode2 := SectionShortcode{
		SubjectArea: "COM SCI",
		Number:      "M152A",
		Index:       "1",
	}

	assert.True(t, shortcode1.LessThan(shortcode2))
}

func TestSectionShortcodeGreaterThan(t *testing.T) {
	shortcode1 := SectionShortcode{
		SubjectArea: "COM SCI",
		Number:      "M151B",
		Index:       "2",
	}
	shortcode2 := SectionShortcode{
		SubjectArea: "COM SCI",
		Number:      "M151B",
		Index:       "1",
	}

	assert.True(t, shortcode1.GreaterThan(shortcode2))
}
