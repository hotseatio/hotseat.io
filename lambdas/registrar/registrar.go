// Common structs and functions for the UCLA registrar.
package registrar

import (
	"errors"
	"regexp"
	"strconv"
	"strings"
	"time"
)

var ErrBadTerm = errors.New("malformed term parameters")
var ErrBadSubjectArea = errors.New("malformed subject area parameters")
var ErrBadCourse = errors.New("malformed course parameters")

// Regexes.
var courseNumberRegex = regexp.MustCompile(`([CM]*)([0-9]*)([A-Z]*)`)

func splitCourseNumber(courseNumber string) (leadingChars, number, trailingChars string) {
	matches := courseNumberRegex.FindStringSubmatch(courseNumber)
	leadingChars = matches[1]
	number = matches[2]
	trailingChars = matches[3]
	return leadingChars, number, trailingChars
}

func splitAndConvertCourseNumber(courseNumber string) (leadingChars string, number int, trailingChars string) {
	leadingChars, numberStr, trailingChars := splitCourseNumber(courseNumber)
	// If we encounter an empty string or error, we want 0.
	number, _ = strconv.Atoi(numberStr)
	return leadingChars, number, trailingChars
}

// CourseNumbersToIgnoreRegex There are some graduate 300-500 courses that aren't worth counting.
var CourseNumbersToIgnoreRegex = regexp.MustCompile(`[35]\d{2}`)
var SpecialSubjectAreas = map[string]struct{}{
	"LAW":  {},
	"DENT": {},
	"MED":  {},
}

type Term struct {
	ID   int64  `json:"id"`
	Term string `json:"term"`
}

func (t Term) Validate() error {
	if t.Term == "" || t.ID == 0 {
		return ErrBadTerm
	}
	return nil
}

func (t Term) IsSummer() bool {
	return strings.HasSuffix(t.Term, "1")
}

type SubjectArea struct {
	ID   int64  `json:"id,omitempty"`
	Name string `json:"name"`
	Code string `json:"code"`
}

func (sa SubjectArea) Validate() error {
	if sa.ID == 0 || sa.Name == "" || sa.Code == "" {
		return ErrBadSubjectArea
	}
	return nil
}

type Course struct {
	ID              int64    `json:"id,omitempty"`
	SubjectAreaID   int64    `json:"subjectAreaId"`
	SubjectAreaCode string   `json:"subjectAreaCode,omitempty"`
	Title           string   `json:"title"`
	Number          string   `json:"number"`
	Model           string   `json:"model,omitempty"`
	SectionIndices  []string `json:"sectionIndices,omitempty"`
	Description     string   `json:"description,omitempty"`
	Units           string   `json:"units,omitempty"`
}

func (c Course) Validate() error {
	if c.ID == 0 || c.SubjectAreaID == 0 || c.Title == "" || c.Number == "" {
		return ErrBadCourse
	}
	return nil
}

func (c *Course) AddSectionIndex(index string) {
	c.SectionIndices = append(c.SectionIndices, index)
}

func (c Course) SplitNumber() (leadingChars, number, trailingChars string) {
	return splitCourseNumber(c.Number)
}

func (c Course) ShortTitle() string {
	return c.SubjectAreaCode + " " + c.Number
}

type EnrollmentNumbers struct {
	EnrollmentStatus   string `json:"enrollment_status"`
	EnrollmentCount    int    `json:"enrollment_count"`
	EnrollmentCapacity int    `json:"enrollment_capacity"`
	WaitlistStatus     string `json:"waitlist_status"`
	WaitlistCount      int    `json:"waitlist_count"`
	WaitlistCapacity   int    `json:"waitlist_capacity"`
}

type SummerInfo struct {
	SummerSession       string `json:"summerSession"`
	SummerDurationWeeks int    `json:"summerDurationWeeks"`
}

type Section struct {
	ID          int64  `json:"id,omitempty"`
	RegistrarID string `json:"registrarId"` // An ID assigned to the section by the registrar.
	TermID      int64  `json:"termId"`
	CourseID    int64  `json:"courseId"`
	ASUCLAID    string `json:"asuclaId,omitempty"`

	Format      string   `json:"format"`
	Index       int      `json:"index"`
	Days        []string `json:"days"`
	Times       []string `json:"times"`
	Locations   []string `json:"locations"`
	Instructors []string `json:"instructors"`
	EnrollmentNumbers

	Website    string    `json:"website"`
	FinalStart time.Time `json:"finalStart"`
	FinalEnd   time.Time `json:"finalEnd"`

	SummerInfo
}

// FilterFlags is a parameter used in fetching a section.
const FilterFlags = `{"enrollment_status":"O,W,C,X,T,S","advanced":"y","meet_days":"M,T,W,R,F,S,U","start_time":"2:00 am","end_time":"11:00 pm","meet_locations":null,"meet_units":null,"instructor":null,"class_career":null,"impacted":null,"enrollment_restrictions":null,"enforced_requisites":null,"individual_studies":null,"summer_session":null}`

// Model is a request parameter used in fetching a section.
type Model struct {
	Term                 string
	SubjectAreaCode      string
	CatalogNumber        string
	IsRoot               bool
	SessionGroup         string
	ClassNumber          string
	SequenceNumber       *string
	Path                 string
	MultiListedClassFlag string
	Token                string
}

type SectionListing struct {
	SectionID    int64  `json:"id,omitempty"`
	CourseNumber string `json:"courseNumber"`
	Index        int    `json:"index"`
}

type Instructor struct {
	ID         int64
	SectionID  int64
	FirstNames []string
	LastNames  []string
}

func (i *Instructor) AddName(firstName, lastName string) {
	i.FirstNames = append(i.FirstNames, firstName)
	i.LastNames = append(i.LastNames, lastName)
}

type Textbook struct {
	ID            int64  `json:"id,omitempty"`
	Edition       int16  `json:"edition,omitempty"`
	IsRequired    bool   `json:"isRequired,omitempty"`
	ISBN          string `json:"isbn"`
	Title         string `json:"title"`
	Author        string `json:"author,omitempty"`
	CopyrightYear string `json:"copyrightYear,omitempty"`
}

type User struct {
	ID    int64  `json:"id"`
	Phone string `json:"phone"`
}
