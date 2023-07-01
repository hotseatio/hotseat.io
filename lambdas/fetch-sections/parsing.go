// Functions that parse scraped data.
package main

import (
	"errors"
	"regexp"
	"strconv"
	"strings"
	"time"

	"github.com/PuerkitoBio/goquery"
	log "github.com/sirupsen/logrus"

	"github.com/nathunsmitty/hotseat.io/lambdas/parseutil"
	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
)

var errSectionRowParse = errors.New("could not find section row id")

const (
	FormatAndIndexCount = 2
)

// Enrollment and waitlist statuses.
const (
	// Enrollment and waitlist.
	Full = "Full"
	Open = "Open"

	// Enrollment only.
	Tentative = "Tentative"
	Canceled  = "Canceled"
	Closed    = "Closed"
	Waitlist  = "Waitlist"

	// Waitlist only.
	None    = "None"
	Contact = "Contact instructor"
)

// Enrollment Regexes.
var (
	tentativeRegex    = regexp.MustCompile(`^Tentative`)
	canceledRegex     = regexp.MustCompile(`^Cancelled`)
	closedByDeptRegex = regexp.MustCompile(`^Closed by Dept[a-zA-Z,/\- ]*(\((?P<Capacity>\d+) capacity, (?P<EnrolledCount>\d+) enrolled, (?P<WaitlistedCount>\d+) waitlisted\))?`)
	classFullRegex    = regexp.MustCompile(`ClosedClass Full \((?P<Capacity>\d+)\)(, Over Enrolled By (?P<OverenrolledCount>\d+))?`)
	classOpenRegex    = regexp.MustCompile(`Open(\d+) of (\d+) Enrolled(\d+) Spots? Left`)
	waitlistOnlyRegex = regexp.MustCompile(`^Waitlist$`)
	waitlistFullRegex = regexp.MustCompile(`^WaitlistClass Full \((?P<Capacity>\d+)\)(, Over Enrolled By (?P<OverenrolledCount>\d+))?`)
)

// Waitlist Regexes.
var (
	waitlistOpenRegex         = regexp.MustCompile(`(\d+) of (\d+) Taken`)
	noWaitlistRegex           = regexp.MustCompile(`No Waitlist`)
	waitlistClosedRegex       = regexp.MustCompile(`Waitlist Full \((\d+)\)`)
	waitlistClosedByDeptRegex = regexp.MustCompile(`(\d+) Waitlisted, Contact Instructor/Department`)
)

// Final Time Regex.
var finalTimeRegex = regexp.MustCompile(`\d+(:\d\d)?(pm|am)-\d+(:\d\d)?(pm|am)`)

// Summer Info Regex.
var summerTitleRegex = regexp.MustCompile(`Session (?P<Session>[A-Z])(?P<Duration>\d+)`)

// Index Regex.
var indexRegex = regexp.MustCompile(`(G)?(?P<Index>\d+)`)

func ParseClosedStatus(logger log.FieldLogger, enrollmentData string) (enrollmentStatus string, enrollmentCount, enrollmentCapacity int) {
	enrollmentStatus = Closed
	matchMap := parseutil.CreateRegexMatchMap(closedByDeptRegex, enrollmentData)

	capacity, err := strconv.Atoi(matchMap["Capacity"])
	if err != nil {
		logger.WithFields(log.Fields{"data": enrollmentData, "matchMap": matchMap}).Error("cannot parse capacity")
	}

	count, err := strconv.Atoi(matchMap["EnrolledCount"])
	if err != nil {
		logger.WithFields(log.Fields{"data": enrollmentData, "matchMap": matchMap}).Error("cannot parse enrollment count")
	}

	enrollmentCapacity = capacity
	enrollmentCount = count
	return enrollmentStatus, enrollmentCount, enrollmentCapacity
}

func ParseFullStatus(logger log.FieldLogger, enrollmentData string) (enrollmentStatus string, enrollmentCount, enrollmentCapacity int) {
	log.Info("Parsing full enrollment status")
	enrollmentStatus = Full
	matchMap := parseutil.CreateRegexMatchMap(classFullRegex, enrollmentData)

	capacity, err := strconv.Atoi(matchMap["Capacity"])
	if err != nil {
		logger.WithFields(log.Fields{"data": enrollmentData, "matchMap": matchMap}).Error("cannot parse capacity")
	}

	enrollmentCapacity = capacity
	enrollmentCount = enrollmentCapacity

	if matchMap["OverenrolledCount"] != "" {
		count, err := strconv.Atoi(matchMap["OverenrolledCount"])
		if err != nil {
			logger.WithFields(log.Fields{"data": enrollmentData, "matchMap": matchMap}).Error("cannot parse capacity")
		}
		enrollmentCount += count
	}

	return enrollmentStatus, enrollmentCount, enrollmentCapacity
}

func ParseOpenStatus(logger log.FieldLogger, enrollmentData string) (enrollmentStatus string, enrollmentCount, enrollmentCapacity int) {
	enrollmentStatus = Open
	matches := classOpenRegex.FindStringSubmatch(enrollmentData)
	capacity, err := strconv.Atoi(matches[2])
	if err != nil {
		logger.WithFields(log.Fields{"matches": matches}).Error("cannot parse capacity (matches[2])")
	}
	enrollmentCapacity = capacity
	count, err := strconv.Atoi(matches[1])
	if err != nil {
		logger.WithFields(log.Fields{"matches": matches}).Error("cannot parse capacity (matches[1])")
	}
	enrollmentCount = count

	return enrollmentStatus, enrollmentCount, enrollmentCapacity
}

func ParseWaitlistStatus(logger log.FieldLogger, enrollmentData string) (enrollmentStatus string, enrollmentCount, enrollmentCapacity int) {
	log.Info("Parsing waitlisted class")
	enrollmentStatus = Waitlist
	matchMap := parseutil.CreateRegexMatchMap(waitlistFullRegex, enrollmentData)
	capacity, err := strconv.Atoi(matchMap["Capacity"])
	if err != nil {
		logger.WithFields(log.Fields{"data": enrollmentData, "matchMap": matchMap}).Error("cannot parse capacity")
	}

	enrollmentCapacity = capacity
	enrollmentCount = capacity

	if matchMap["OverenrolledCount"] != "" {
		count, err := strconv.Atoi(matchMap["OverenrolledCount"])
		if err != nil {
			logger.WithFields(log.Fields{"data": enrollmentData, "matchMap": matchMap}).Error("cannot parse capacity")
		}
		enrollmentCount += count
	}

	return enrollmentStatus, enrollmentCount, enrollmentCapacity
}

// ParseEnrollmentData parses the status and enrollment numbers of a section.
func ParseEnrollmentData(logger log.FieldLogger, enrollmentData string) (status string, count, capacity int) {
	switch {
	case tentativeRegex.MatchString(enrollmentData):
		status = Tentative
	case canceledRegex.MatchString(enrollmentData):
		status = Canceled
	case closedByDeptRegex.MatchString(enrollmentData):
		return ParseClosedStatus(logger, enrollmentData)
	case classFullRegex.MatchString(enrollmentData):
		return ParseFullStatus(logger, enrollmentData)
	case classOpenRegex.MatchString(enrollmentData):
		return ParseOpenStatus(logger, enrollmentData)
	case waitlistFullRegex.MatchString(enrollmentData):
		return ParseWaitlistStatus(logger, enrollmentData)
	case waitlistOnlyRegex.MatchString(enrollmentData):
		status = Waitlist
	default:
		logger.WithFields(log.Fields{"enrollmentData": enrollmentData}).Error("unrecognized string")
	}

	return status, count, capacity
}

// ParseWaitlistData parses the status and enrollment numbers of a section's waitlist.
func ParseWaitlistData(logger log.FieldLogger, waitlistData string) (waitlistStatus string, waitlistCount, waitlistCapacity int) {
	switch {
	case waitlistOpenRegex.MatchString(waitlistData):
		{
			waitlistStatus = Open
			matches := waitlistOpenRegex.FindStringSubmatch(waitlistData)
			capacity, err := strconv.Atoi(matches[2])
			if err != nil {
				logger.WithFields(log.Fields{"matches": matches}).Error("cannot parse capacity (matches[2])")
			}
			waitlistCapacity = capacity
			count, err := strconv.Atoi(matches[1])
			if err != nil {
				logger.WithFields(log.Fields{"matches": matches}).Error("cannot parse count (matches[1])")
			}
			waitlistCount = count
		}
	case waitlistClosedRegex.MatchString(waitlistData):
		{
			waitlistStatus = Full
			matches := waitlistClosedRegex.FindStringSubmatch(waitlistData)
			capacity, err := strconv.Atoi(matches[1])
			if err != nil {
				logger.WithFields(log.Fields{"matches": matches}).Error("cannot parse capacity (matches[1])")
			}
			waitlistCapacity = capacity
			waitlistCount = waitlistCapacity
		}
	case waitlistClosedByDeptRegex.MatchString(waitlistData):
		{
			waitlistStatus = Contact
			waitlistCapacity = 0
			matches := waitlistClosedByDeptRegex.FindStringSubmatch(waitlistData)
			count, err := strconv.Atoi(matches[1])
			if err != nil {
				logger.WithFields(log.Fields{"matches": matches}).Error("cannot parse count (matches[1])")
			}
			waitlistCount = count
		}
	case noWaitlistRegex.MatchString(waitlistData):
		waitlistStatus = None
	}

	return waitlistStatus, waitlistCount, waitlistCapacity
}

// ParseEntries takes the HTML text of a row entry and parses it into a slice of values.
// Used to parse dates, times, locations, professors.
func ParseEntries(logger log.FieldLogger, rawText string) []string {
	tagMatcher := regexp.MustCompile(`<wbr/>|<(/)?(a|p|button)[^>]*>`)
	text := tagMatcher.ReplaceAllString(rawText, "")
	entries := regexp.MustCompile("<br */>").Split(text, -1)
	parseutil.CleanHTMLStrings(entries)
	logger.WithFields(log.Fields{"entries": entries, "length": len(entries)}).Info("Parsed entries")
	return entries
}

// ParseBodyToRows takes a HTML body/document and returns the rows of section data.
func ParseTableToRows(table *goquery.Selection) *goquery.Selection {
	rows := table.ChildrenFiltered("div")
	return rows
}

func ParseBodyToTable(doc *goquery.Document) (table *goquery.Selection) {
	return doc.Find("div[id$=-children]")
}

// ParseSummerBodyToTables finds the tables by summer sessions for a particular summer course offering.
func ParseSummerBodyToTables(doc *goquery.Document) (summerTitles *goquery.Selection, summerTables *goquery.Selection) {
	children := doc.Find("div[id$=-children]")
	summerTitles = children.Find(".summer-session-title")
	summerTables = children.Find(".summer_classes_data_rows")
	return summerTitles, summerTables
}

func ParseSectionFormatAndIndex(logger log.FieldLogger, rawText string) (format string, index int) {
	data := strings.Split(rawText, " ")
	if len(data) != FormatAndIndexCount {
		logger.Error("Error parsing section format and index")
		return format, index
	}

	format = strings.ToUpper(data[0])
	rawIndex := data[1]
	matchMap := parseutil.CreateRegexMatchMap(indexRegex, rawIndex)
	index, err := strconv.Atoi(matchMap["Index"])
	if err != nil {
		logger.WithError(err).Error("Error parsing section index")
		return format, index
	}

	return format, index
}

// ParseRow parses a row of a section table into a section object.
func ParseRow(logger log.FieldLogger, row *goquery.Selection, term registrar.Term, courseID int64) (section registrar.Section, err error) {
	rowID, exists := row.Attr("id")
	if !exists {
		return section, errSectionRowParse
	}
	idRegex := regexp.MustCompile(`([0-9]+)_`)
	matches := idRegex.FindStringSubmatch(rowID)
	registrarID := matches[1]
	logger = logger.WithField("registrarID", registrarID)

	formatAndIndexElement := row.Find(".sectionColumn a")
	sectionFormat, sectionIndex := ParseSectionFormatAndIndex(logger, formatAndIndexElement.Text())

	enrollmentData := parseutil.CleanHTMLString(row.Find("div[id$=-status_data]").Text())
	waitlistData := parseutil.CleanHTMLString(row.Find("div[id$=-waitlist_data]").Text())
	enrollmentStatus, enrollmentCount, enrollmentCapacity := ParseEnrollmentData(logger, enrollmentData)
	waitlistStatus, waitlistCount, waitlistCapacity := ParseWaitlistData(logger, waitlistData)

	rawDaysText, _ := row.Find("div[id$=-days_data]").First().Html()
	days := ParseEntries(logger, rawDaysText)
	rawTimesText, _ := row.Find("div[id$=-time_data] > p").Html()
	times := ParseEntries(logger, rawTimesText)

	// Account for a lack of time in "Varies"
	if len(days) != len(times) {
		for i, element := range days {
			if element == "Varies" {
				// Insert
				// https://github.com/golang/go/wiki/SliceTricks#insert
				times = append(times, "")
				copy(times[i+1:], times[i:])
				times[i] = ""
				break
			}
		}
	}

	rawLocationsText, _ := row.Find("div[id$=-location_data]").Html()
	locations := ParseEntries(logger, rawLocationsText)
	rawInstructorText, _ := row.Find("div[id$=-instructor_data]").Html()
	instructors := ParseEntries(logger, rawInstructorText)

	section = registrar.Section{
		RegistrarID: registrarID,
		TermID:      term.ID,
		CourseID:    courseID,
		Format:      sectionFormat,
		Index:       sectionIndex,
		Days:        days,
		Times:       times,
		Locations:   locations,
		Instructors: instructors,
		EnrollmentNumbers: registrar.EnrollmentNumbers{
			EnrollmentStatus:   enrollmentStatus,
			EnrollmentCount:    enrollmentCount,
			EnrollmentCapacity: enrollmentCapacity,
			WaitlistStatus:     waitlistStatus,
			WaitlistCount:      waitlistCount,
			WaitlistCapacity:   waitlistCapacity,
		},
	}

	logger.WithFields(log.Fields{"section": section}).Info("Parsed section")

	return section, nil
}

const shortTimeForm = "1/2/2006 3pm"
const longTimeForm = "1/2/2006 3:04pm"

var location, _ = time.LoadLocation("America/Los_Angeles")

func ParseFinalTimes(logger log.FieldLogger, doc *goquery.Document) (start, end time.Time, err error) {
	content := doc.Find(".final_exam_content tbody tr.final_exam")
	rawDate := content.Find("td:nth-child(1) .hide-small").Text()
	rawTime := content.Find("td:nth-child(3)").Text()

	if rawDate == "None listed" ||
		!finalTimeRegex.MatchString(rawTime) {
		logger.WithFields(log.Fields{"rawTime": rawTime, "rawDate": rawDate}).Info("Could not find final time")
		return start, end, nil
	}

	rawTimes := strings.Split(rawTime, "-")

	rawStart := rawTimes[0]
	rawEnd := rawTimes[1]
	start, err = time.ParseInLocation(shortTimeForm, rawDate+" "+rawStart, location)
	if err != nil {
		start, err = time.ParseInLocation(longTimeForm, rawDate+" "+rawStart, location)
		if err != nil {
			return time.Time{}, time.Time{}, err
		}
	}

	end, err = time.ParseInLocation(shortTimeForm, rawDate+" "+rawEnd, location)
	if err != nil {
		end, err = time.ParseInLocation(longTimeForm, rawDate+" "+rawEnd, location)
		if err != nil {
			return time.Time{}, time.Time{}, err
		}
	}

	return start, end, nil
}

func ParseWebsite(logger log.FieldLogger, doc *goquery.Document) (website string) {
	rawLink := doc.Find(".grade_type_content a")
	website, exists := rawLink.Attr("href")
	if !exists {
		logger.Info("No website found")
		return ""
	}
	return website
}

func ParseAdditionalDetails(logger log.FieldLogger, doc *goquery.Document, section *registrar.Section) {
	logger = logger.WithField("section", section)

	website := ParseWebsite(logger, doc)
	section.Website = website

	start, end, err := ParseFinalTimes(logger, doc)
	if err != nil {
		logger.WithError(err).Error("Error parsing final times")
	}
	section.FinalStart = start
	section.FinalEnd = end
}

func ParseSummerInfoFromTitle(logger log.FieldLogger, title string) registrar.SummerInfo {
	cleanedTitle := parseutil.CleanHTMLString(title)
	matchMap := parseutil.CreateRegexMatchMap(summerTitleRegex, cleanedTitle)

	duration, err := strconv.Atoi(matchMap["Duration"])
	if err != nil {
		logger.WithError(err).Error("Error parsing duration")
	}

	return registrar.SummerInfo{
		SummerSession:       matchMap["Session"],
		SummerDurationWeeks: duration,
	}
}
