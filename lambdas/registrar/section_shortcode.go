package registrar

import (
	"fmt"
	"regexp"
	"strings"

	"github.com/nathunsmitty/hotseat.io/lambdas/parseutil"
)

var shortcodeRegex = regexp.MustCompile(`^(?P<SubjectArea>[A-Z ]{1,7}) (?P<Number>[\w]+)-(?P<Index>\d+)`)

type SectionShortcode struct {
	SubjectArea string `json:"subjectArea"`
	Number      string `json:"number"`
	Index       string `json:"index"`
}

func (sc *SectionShortcode) Read(input string) {
	cleanedInput := parseutil.CleanHTMLString(strings.TrimSuffix(input, "(Registrar)"))
	matchMap := parseutil.CreateRegexMatchMap(shortcodeRegex, cleanedInput)
	sc.SubjectArea = matchMap["SubjectArea"]
	sc.Number = matchMap["Number"]
	sc.Index = matchMap["Index"]
}

func (sc SectionShortcode) Write() string {
	return fmt.Sprintf("%s %s-%s", sc.SubjectArea, sc.Number, sc.Index)
}

func (sc SectionShortcode) LessThan(otherShortcode SectionShortcode) bool {
	_, number1, trailingChars1 := splitAndConvertCourseNumber(sc.Number)
	_, number2, trailingChars2 := splitAndConvertCourseNumber(otherShortcode.Number)

	if number1 < number2 {
		return true
	} else if number1 > number2 {
		return false
	}
	// number1 == number2
	return trailingChars1 < trailingChars2
}

func (sc SectionShortcode) GreaterThan(otherShortcode SectionShortcode) bool {
	return sc != otherShortcode && !sc.LessThan(otherShortcode)
}
