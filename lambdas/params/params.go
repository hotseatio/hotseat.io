package params

import (
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

type FetchSubjectAreas struct {
	Term registrar.Term `json:"term"`
}

type FetchCourses struct {
	Term registrar.Term `json:"term"`
}

type FetchSections struct {
	Term                       registrar.Term `json:"term"`
	ShouldInsertEnrollmentData bool           `json:"shouldInsertEnrollmentData"`
}

type FetchInstructors struct {
	SubjectArea registrar.SubjectArea      `json:"subjectArea"`
	Term        registrar.Term             `json:"term"`
	Sections    []registrar.SectionListing `json:"sections"`
}

type TriggerTextbooks struct {
	Term registrar.Term `json:"term"`
}

type FetchTextbooks struct {
	Term     registrar.Term      `json:"term"`
	Sections []registrar.Section `json:"sections"`
}

type FetchCourseDescriptions struct {
	SubjectArea registrar.SubjectArea `json:"subjectArea"`
}
