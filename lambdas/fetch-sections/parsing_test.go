package main

import (
	"flag"
	"fmt"
	"os"
	"testing"
	"time"

	log "github.com/sirupsen/logrus"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
	"github.com/nathunsmitty/hotseat.io/lambdas/testutil"
)

func TestMain(m *testing.M) {
	flag.Parse()
	os.Exit(m.Run())
}

func TestParseEnrollmentData_Tentative(t *testing.T) {
	input := "Tentative"
	enrollmentStatus, enrollmentCount, enrollmentCapacity := ParseEnrollmentData(log.New(), input)

	assert.Equal(t, "Tentative", enrollmentStatus)
	assert.Equal(t, 0, enrollmentCount)
	assert.Equal(t, 0, enrollmentCapacity)
}

func TestParseEnrollmentData_Canceled(t *testing.T) {
	input := "Cancelled"
	enrollmentStatus, enrollmentCount, enrollmentCapacity := ParseEnrollmentData(log.New(), input)

	assert.Equal(t, "Canceled", enrollmentStatus)
	assert.Equal(t, 0, enrollmentCount)
	assert.Equal(t, 0, enrollmentCapacity)
}

func TestParseEnrollmentData_Closed1(t *testing.T) {
	input := "Closed by Dept Computer Science (0 capacity, 1 enrolled, 0 waitlisted)"
	enrollmentStatus, enrollmentCount, enrollmentCapacity := ParseEnrollmentData(log.New(), input)

	assert.Equal(t, "Closed", enrollmentStatus)
	assert.Equal(t, 1, enrollmentCount)
	assert.Equal(t, 0, enrollmentCapacity)
}

func TestParseEnrollmentData_Closed2(t *testing.T) {
	input := "Closed by Dept Indo-European Studies (3 capacity, 3 enrolled, 0 waitlisted)"
	enrollmentStatus, enrollmentCount, enrollmentCapacity := ParseEnrollmentData(log.New(), input)

	assert.Equal(t, "Closed", enrollmentStatus)
	assert.Equal(t, 3, enrollmentCount)
	assert.Equal(t, 3, enrollmentCapacity)
}

func TestParseEnrollmentData_Closed3(t *testing.T) {
	input := "Closed by Dept Design / Media Arts (0 capacity, 3 enrolled, 0 waitlisted)"
	enrollmentStatus, enrollmentCount, enrollmentCapacity := ParseEnrollmentData(log.New(), input)

	assert.Equal(t, "Closed", enrollmentStatus)
	assert.Equal(t, 3, enrollmentCount)
	assert.Equal(t, 0, enrollmentCapacity)
}

func TestParseEnrollmentData_Closed4(t *testing.T) {
	input := "Closed by Dept Computer Science (0 capacity, 0 enrolled, 20 waitlisted)"
	enrollmentStatus, enrollmentCount, enrollmentCapacity := ParseEnrollmentData(log.New(), input)

	assert.Equal(t, "Closed", enrollmentStatus)
	assert.Equal(t, 0, enrollmentCount)
	assert.Equal(t, 0, enrollmentCapacity)
}

func TestParseEnrollmentData_Full(t *testing.T) {
	input := "ClosedClass Full (195)"
	enrollmentStatus, enrollmentCount, enrollmentCapacity := ParseEnrollmentData(log.New(), input)

	assert.Equal(t, "Full", enrollmentStatus)
	assert.Equal(t, 195, enrollmentCount)
	assert.Equal(t, 195, enrollmentCapacity)
}

func TestParseEnrollmentData_FullOverenrolled(t *testing.T) {
	input := "ClosedClass Full (90), Over Enrolled By 1"
	enrollmentStatus, enrollmentCount, enrollmentCapacity := ParseEnrollmentData(log.New(), input)

	assert.Equal(t, "Full", enrollmentStatus)
	assert.Equal(t, 91, enrollmentCount)
	assert.Equal(t, 90, enrollmentCapacity)
}

func TestParseEnrollmentData_Open(t *testing.T) {
	input := "Open18 of 25 Enrolled7 Spots Left"
	enrollmentStatus, enrollmentCount, enrollmentCapacity := ParseEnrollmentData(log.New(), input)

	assert.Equal(t, "Open", enrollmentStatus)
	assert.Equal(t, 18, enrollmentCount)
	assert.Equal(t, 25, enrollmentCapacity)
}

func TestParseEnrollmentData_Waitlisted(t *testing.T) {
	input := "WaitlistClass Full (180)"
	enrollmentStatus, enrollmentCount, enrollmentCapacity := ParseEnrollmentData(log.New(), input)

	assert.Equal(t, "Waitlist", enrollmentStatus)
	assert.Equal(t, 180, enrollmentCount)
	assert.Equal(t, 180, enrollmentCapacity)
}

func TestParseEnrollmentData_WaitlistedOverenrolled(t *testing.T) {
	input := "WaitlistClass Full (20), Over Enrolled By 11"
	enrollmentStatus, enrollmentCount, enrollmentCapacity := ParseEnrollmentData(log.New(), input)

	assert.Equal(t, "Waitlist", enrollmentStatus)
	assert.Equal(t, 31, enrollmentCount)
	assert.Equal(t, 20, enrollmentCapacity)
}

func TestParseEnrollmentData_WaitlistOnly(t *testing.T) {
	input := "Waitlist"
	enrollmentStatus, enrollmentCount, enrollmentCapacity := ParseEnrollmentData(log.New(), input)

	assert.Equal(t, "Waitlist", enrollmentStatus)
	assert.Equal(t, 0, enrollmentCount)
	assert.Equal(t, 0, enrollmentCapacity)
}

func TestParseEnrollmentData_Unknown(t *testing.T) {
	input := "blah"
	enrollmentStatus, enrollmentCount, enrollmentCapacity := ParseEnrollmentData(log.New(), input)

	assert.Equal(t, "", enrollmentStatus)
	assert.Equal(t, 0, enrollmentCount)
	assert.Equal(t, 0, enrollmentCapacity)
}

func TestParseWaitlistData_Open(t *testing.T) {
	input := "4 of 30 Taken"
	waitlistStatus, waitlistCount, waitlistCapacity := ParseWaitlistData(log.New(), input)

	assert.Equal(t, "Open", waitlistStatus)
	assert.Equal(t, 4, waitlistCount)
	assert.Equal(t, 30, waitlistCapacity)
}

func TestParseWaitlistData_Full(t *testing.T) {
	input := "Waitlist Full (40)"
	waitlistStatus, waitlistCount, waitlistCapacity := ParseWaitlistData(log.New(), input)

	assert.Equal(t, "Full", waitlistStatus)
	assert.Equal(t, 40, waitlistCount)
	assert.Equal(t, 40, waitlistCapacity)
}

func TestParseWaitlistData_None(t *testing.T) {
	input := "No Waitlist"
	waitlistStatus, waitlistCount, waitlistCapacity := ParseWaitlistData(log.New(), input)

	assert.Equal(t, "None", waitlistStatus)
	assert.Equal(t, 0, waitlistCount)
	assert.Equal(t, 0, waitlistCapacity)
}

func TestParseWaitlistData_Closed(t *testing.T) {
	input := "20 Waitlisted, Contact Instructor/Department"
	waitlistStatus, waitlistCount, waitlistCapacity := ParseWaitlistData(log.New(), input)

	assert.Equal(t, "Contact instructor", waitlistStatus)
	assert.Equal(t, 20, waitlistCount)
	assert.Equal(t, 0, waitlistCapacity)
}

func TestParseEntries_Locations(t *testing.T) {
	input := "Bunche Hall 1209B<br/>Rolfe Hall 1200"
	arr := ParseEntries(log.New(), input)

	assert.Equal(t, []string{"Bunche Hall 1209B", "Rolfe Hall 1200"}, arr)
}

func TestParseEntries_LocationsWithWrapper(t *testing.T) {
	input := `<button class="popover-bottom linkLikeButton" data-content="Online - Recorded: Classes will be held at scheduled times with faculty delivering course content using remote communication tools and with students in attendance using those tools. Faculty &lt;strong&gt;will record&lt;/strong&gt; the class and make available those scheduled activities for subsequent use by students. However, students should be aware that faculty may still request their participation during scheduled meeting times.">Online - Recorded <br />Boelter Hall 4413</button>`
	arr := ParseEntries(log.New(), input)

	assert.Equal(t, []string{"Online - Recorded", "Boelter Hall 4413"}, arr)
}

func TestParseBodyToRows(t *testing.T) {
	input := testutil.ReadFixtureToDocument(t, "winter2021-comsci-32.html")
	table := ParseBodyToTable(input)
	rows := ParseTableToRows(table)
	assert.Equal(t, rows.Length(), 3)
}

func TestParseRow_CS32_1(t *testing.T) {
	input := testutil.ReadFixtureToDocument(t, "winter2021-comsci-32.html")
	table := ParseBodyToTable(input)
	rows := ParseTableToRows(table)
	row := rows.First()
	term := registrar.Term{Term: "21W", ID: 42}
	section, err := ParseRow(log.New(), row, term, 3365)

	require.NoError(t, err)
	testutil.RequireGoldenMatch(t, "winter2021-comsci-32-row-1.json", section)
}

func TestParseRow_MUSIC185H_1(t *testing.T) {
	input := testutil.ReadFixtureToDocument(t, "winter2021-music-185H.html")
	table := ParseBodyToTable(input)
	rows := ParseTableToRows(table)
	row := rows.First()
	term := registrar.Term{Term: "21W", ID: 36}
	section, err := ParseRow(log.New(), row, term, 4222)

	require.NoError(t, err)
	testutil.RequireGoldenMatch(t, "winter2021-music-185H-row-1.json", section)
}

func TestParseFinalTimes_CSM146_1(t *testing.T) {
	var location, err = time.LoadLocation("America/Los_Angeles")
	require.NoError(t, err)
	doc := testutil.ReadFixtureToDocument(t, "winter2021-comsci-m146-details.html")
	start, end, err := ParseFinalTimes(log.New(), doc)

	expectedStart := time.Date(2021, time.March, 15, 8, 0, 0, 0, location)
	expectedEnd := time.Date(2021, time.March, 15, 11, 0, 0, 0, location)

	require.NoError(t, err)
	assert.True(t, expectedStart.Equal(start))
	assert.True(t, expectedEnd.Equal(end))
}

func TestParseFinalTimes_CS143_1(t *testing.T) {
	var location, err = time.LoadLocation("America/Los_Angeles")
	require.NoError(t, err)
	doc := testutil.ReadFixtureToDocument(t, "winter2021-comsci-143-details.html")
	start, end, err := ParseFinalTimes(log.New(), doc)

	expectedStart := time.Date(2021, time.March, 17, 11, 30, 0, 0, location)
	expectedEnd := time.Date(2021, time.March, 17, 14, 30, 0, 0, location)
	fmt.Printf("%v\n", start)
	fmt.Printf("%v\n", expectedStart)

	require.NoError(t, err)
	assert.True(t, expectedStart.Equal(start))
	assert.True(t, expectedEnd.Equal(end))
}

func TestParseFinalTimes_LAW205_1(t *testing.T) {
	doc := testutil.ReadFixtureToDocument(t, "spring2021-law-205-details.html")
	start, end, err := ParseFinalTimes(log.New(), doc)

	// Should be 0 time
	expectedStart := time.Time{}
	expectedEnd := time.Time{}

	require.NoError(t, err)
	assert.True(t, expectedStart.Equal(start))
	assert.True(t, expectedEnd.Equal(end))
}

func TestParseFinalTimes_LAW212_1(t *testing.T) {
	doc := testutil.ReadFixtureToDocument(t, "spring2021-law-212-details.html")
	start, end, err := ParseFinalTimes(log.New(), doc)

	// Should be 0 time
	expectedStart := time.Time{}
	expectedEnd := time.Time{}

	require.NoError(t, err)
	assert.True(t, expectedStart.Equal(start))
	assert.True(t, expectedEnd.Equal(end))
}

func TestParseWebsite_CSM146_1(t *testing.T) {
	doc := testutil.ReadFixtureToDocument(t, "winter2021-comsci-m146-details.html")
	website := ParseWebsite(log.New(), doc)
	expectedWebsite := "https://ccle.ucla.edu/course/view/21W-COMSCIM146-1"
	assert.Equal(t, expectedWebsite, website)
}

func TestParseWebsite_CS143_1(t *testing.T) {
	doc := testutil.ReadFixtureToDocument(t, "winter2021-comsci-143-details.html")
	website := ParseWebsite(log.New(), doc)
	expectedWebsite := "https://ccle.ucla.edu/course/view/21W-COMSCI143-1"
	assert.Equal(t, expectedWebsite, website)
}

func TestParseSummerInfo(t *testing.T) {
	title := "Session A10: Meets from 6/21-8/13: Duration 10 weeks"
	info := ParseSummerInfoFromTitle(log.New(), title)
	assert.Equal(t, info.SummerSession, "A")
	assert.Equal(t, info.SummerDurationWeeks, 10)
}

func TestParseSectionFormatAndIndex(t *testing.T) {
	text := "Lec G3"
	format, index := ParseSectionFormatAndIndex(log.New(), text)
	assert.Equal(t, format, "LEC")
	assert.Equal(t, index, 3)
}
