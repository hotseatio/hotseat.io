package main

import (
	"context"
	"encoding/json"
	"regexp"
	"strings"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/parseutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
	log "github.com/sirupsen/logrus"
)

func ParseSubjectAreas(ctx context.Context, content []byte) (subjectAreas []registrar.SubjectArea, err error) {
	span, logger, _ := envutil.GetLoggerAndNewSpan(ctx, "ParseSubjectAreas")
	defer span.Finish()

	logger.Info("Parsing response")

	var rawSubjectAreas []RawSubjectArea

	re := regexp.MustCompile(`SearchPanelSetup\('([^']+)`)
	match := re.FindSubmatch(content)[1]
	jsonString := strings.ReplaceAll(string(match), "&quot;", "\"")
	logger.WithField("jsonString", jsonString).Info("Parsed json string")

	err = json.Unmarshal([]byte(jsonString), &rawSubjectAreas)
	if err != nil {
		logger.Error(err)
		return subjectAreas, err
	}

	subjectAreaCodeMatcher := regexp.MustCompile(` \([A-Z&\- ]*\)`)

	for _, element := range rawSubjectAreas {
		cleanedName := subjectAreaCodeMatcher.ReplaceAllString(element.Label, "")
		cleanedCode := parseutil.CleanHTMLString(element.Value)
		subjectAreas = append(subjectAreas, registrar.SubjectArea{Name: cleanedName, Code: cleanedCode})
	}

	logger.WithFields(log.Fields{"subjectAreas": subjectAreas}).Info("Response parsed")

	return subjectAreas, nil
}
