package main

import (
	"context"

	"github.com/nathunsmitty/hotseat.io/lambdas/envutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

var subjectAreasThatIncludeTAs = map[string]bool{
	"ARCH&UD": true,
	"ART":     true,
	"DESMA":   true,
	"PSYCH":   true,
	"WL ARTS": true,
}

func FilterInstructors(
	ctx context.Context,
	course registrar.Course,
	section *registrar.Section,
) {
	span, logger, _ := envutil.GetLoggerAndNewSpan(ctx, "FilterInstructors")
	defer span.Finish()

	if subjectAreasThatIncludeTAs[course.SubjectAreaCode] {
		logger.Info("Filtering instructors due to included TAs")
		section.Instructors = section.Instructors[:1]
	}
}
