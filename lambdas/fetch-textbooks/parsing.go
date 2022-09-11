package main

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"regexp"
	"strconv"
	"strings"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

type RawTextbook struct {
	Required string `json:"courseMaterialRequirement"` // usually "Required" or "Optional"
	ISBN     string `json:"isbn"`
	Title    string `json:"longTitle"`
	Author   string `json:"bookAuthor"`
	Edition  string `json:"bookEdition"`
}

type RawContent struct {
	Books []RawTextbook `json:"items"`
}

var courseIDRegex = regexp.MustCompile(`ccid=(\d+)`)

var ErrNoCourseID = errors.New("no course id found in response")
var ErrNoTextbooks = errors.New("no textbooks found in response")

func ParseUCLAStoreCourseID(ctx context.Context, content []byte) (string, error) {
	span, logger, _ := envutil.GetLoggerAndNewSpan(ctx, "ParseTextbooks")
	defer span.Finish()

	match := courseIDRegex.FindSubmatch(content)
	if match == nil {
		logger.WithField("content", string(content)).Info("Could not find UCLA store course id")
		return "", ErrNoCourseID
	}

	submatch := match[1]
	logger.WithField("match", string(submatch)).Info("Found match")

	return string(submatch), nil
}

func ParseTextbooks(ctx context.Context, content []byte) (textbooks []registrar.Textbook, err error) {
	span, logger, _ := envutil.GetLoggerAndNewSpan(ctx, "ParseTextbooks")
	defer span.Finish()

	logger.Info("Parsing response")

	fmt.Print(string(content))

	var rawContent []RawContent

	err = json.Unmarshal(content, &rawContent)
	if err != nil {
		logger.WithError(err).Error("Error parsing JSON of textbooks content")
		return textbooks, err
	}
	logger.Info("Parsed json string")

	if len(rawContent) != 1 {
		logger.WithField("rawContent", rawContent).Error("Raw content does not contain a single item")
	}

	for _, rawTextbook := range rawContent[0].Books {
		logger = logger.WithField("rawTextbook", rawTextbook)

		if rawTextbook.Title == "No Textbook Is Being Required For This Course" {
			logger.Info("`No textbook required` listed, skipping textbook")
			continue
		}

		var edition int64
		if rawTextbook.Edition != "" {
			edition, err = strconv.ParseInt(rawTextbook.Edition, 10, 16)
			if err != nil {
				logger.WithError(err).Error("Error parsing edition number")
			}
		}

		textbook := registrar.Textbook{
			IsRequired: strings.TrimSpace(rawTextbook.Required) == "Required",
			ISBN:       rawTextbook.ISBN,
			Title:      rawTextbook.Title,
			Author:     rawTextbook.Author,
			Edition:    int16(edition),
		}
		textbooks = append(textbooks, textbook)
	}

	logger.WithField("textbooks", textbooks).Info("Response parsed")

	return textbooks, nil
}
