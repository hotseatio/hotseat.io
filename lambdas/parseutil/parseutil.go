package parseutil

import (
	"html"
	"regexp"
	"strings"
)

// CreateCreateRegexMatchMap takes a regexp with named capture groups and returns a map with keys
// for each capture group and values for the corresponding captured value.
// https://stackoverflow.com/questions/20750843/using-named-matches-from-go-regex
func CreateRegexMatchMap(re *regexp.Regexp, str string) (matchMap map[string]string) {
	match := re.FindStringSubmatch(str)
	matchMap = make(map[string]string)
	for i, name := range re.SubexpNames() {
		if name != "" && i > 0 && i <= len(match) {
			matchMap[name] = match[i]
		}
	}
	return matchMap
}

// CleanHTMLStrings trims the space of each string in place.
func CleanHTMLStrings(strings []string) {
	for i, s := range strings {
		strings[i] = CleanHTMLString(s)
	}
}

// CleanHTMLString unescapes HTML characters, trims the string, and removes unwanted characters.
func CleanHTMLString(s string) string {
	s = html.UnescapeString(s)
	s = strings.ReplaceAll(s, "\u0000", "")
	s = strings.TrimSpace(s)

	return s
}
