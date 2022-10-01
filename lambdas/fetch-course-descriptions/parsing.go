package main

import (
	"encoding/json"
	"regexp"

	"github.com/nathunsmitty/hotseat.io/lambdas/parseutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

type CourseDetail struct {
	Title       string `json:"course_title"`
	Description string `json:"crs_desc"`
	Units       string `json:"unt_rng"`
}

var courseTitleRegex = regexp.MustCompile(`(?P<Number>.*)\. (?P<Title>.*)`)

func ParseNumberAndTitle(rawTitle string) (number, title string) {
	rawTitle = parseutil.CleanHTMLString(rawTitle)
	matchMap := parseutil.CreateRegexMatchMap(courseTitleRegex, rawTitle)
	number = parseutil.CleanHTMLString(matchMap["Number"])
	title = parseutil.CleanHTMLString(matchMap["Title"])
	return number, title
}

func ParseCourseDescriptions(
	subjectArea registrar.SubjectArea,
	content []byte,
) (courses []registrar.Course, err error) {

	var details []CourseDetail
	err = json.Unmarshal(content, &details)
	if err != nil {
		return nil, err
	}

	for _, detail := range details {
		number, title := ParseNumberAndTitle(detail.Title)
		description := parseutil.CleanHTMLString(detail.Description)
		units := parseutil.CleanHTMLString(detail.Units)

		courses = append(courses, registrar.Course{
			SubjectAreaID:   subjectArea.ID,
			SubjectAreaCode: subjectArea.Code,
			Title:           title,
			Number:          number,
			Description:     description,
			Units:           units,
		})

	}

	return courses, nil
}
