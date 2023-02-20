UNAME := $(shell uname)

GOARGS ?= CGO_ENABLED=0 GOOS=linux GOARCH=amd64
GOBUILD = $(GOARGS) go build

.PHONY: lint
lint:
	golangci-lint run ./...

.PHONY: fix
fix:
	golangci-lint run ./... --fix

# Builds
.PHONY: build
build: build-fs build-fc build-tc build-fsa build-ft build-tt build-tcd build-fcd

.PHONY: build-fetch-subject-areas build-fsa
build-fetch-subject-areas build-fsa:
	$(GOBUILD) -o ./bin/fetch-subject-areas ./fetch-subject-areas

.PHONY: build-trigger-courses build-tc
build-trigger-courses build-tc:
	$(GOBUILD) -o ./bin/trigger-courses ./trigger-courses

.PHONY: build-fetch-courses build-fc
build-fetch-courses build-fc:
	$(GOBUILD) -o ./bin/fetch-courses ./fetch-courses

.PHONY: build-fetch-sections build-fs
build-fetch-sections build-fs:
	$(GOBUILD) -o ./bin/fetch-sections ./fetch-sections

.PHONY: build-trigger-course-descriptions build-tcd
build-trigger-course-descriptions build-tcd:
	$(GOBUILD) -o ./bin/trigger-course-descriptions ./trigger-course-descriptions

.PHONY: build-fetch-course-descriptions build-fcd
build-fetch-course-descriptions build-fcd:
	$(GOBUILD) -o ./bin/fetch-course-descriptions ./fetch-course-descriptions

.PHONY: local-fetch-subject-areas local-fsa
local-fetch-subject-areas local-fsa: build-fsa
ifeq ($(UNAME),Darwin)
	sls invoke local -f FetchSubjectAreas --path default-event.json -s mac-dev \
	--docker-arg='--platform linux/amd64'
else
	sls invoke local -f FetchSubjectAreas --path default-event.json -s linux-dev
endif

.PHONY: local-trigger-courses local-tc
local-trigger-courses local-tc: build-tc
ifeq ($(UNAME),Darwin)
	sls invoke local -f TriggerCourses --path default-event.json -s mac-dev \
	--docker-arg='--platform linux/amd64'
else
	sls invoke local -f TriggerCourses --path default-event.json -s linux-dev
endif

.PHONY: local-fetch-courses local-fc
local-fetch-courses local-fc: build-fc
ifeq ($(UNAME),Darwin)
	sls invoke local -f FetchCourses --path ./fetch-courses/event.json -s mac-dev \
	--docker-arg='--platform linux/amd64'
else
	sls invoke local -f FetchCourses --path ./fetch-courses/event.json -s linux-dev
endif

.PHONY: local-fetch-sections local-fs
local-fetch-sections local-fs: build-fs
ifeq ($(UNAME),Darwin)
	sls invoke local -f FetchSections --path default-event.json -s mac-dev \
	--docker-arg='--platform linux/amd64'
else
	sls invoke local -f FetchSections --path default-event.json -s linux-dev
endif

.PHONY: local-trigger-course-descriptions local-tcd
local-trigger-course-descriptions local-tcd: build-tcd
ifeq ($(UNAME),Darwin)
	sls invoke local -f TriggerCourseDescriptions --path ./trigger-course-descriptions/event.json -s mac-dev \
	--docker-arg='--platform linux/amd64'
else
	sls invoke local -f TriggerCourseDescriptions --path ./trigger-course-descriptions/event.json -s linux-dev
endif

.PHONY: local-fetch-course-descriptions local-fcd
local-fetch-course-descriptions local-fcd: build-fcd
ifeq ($(UNAME),Darwin)
	sls invoke local -f FetchCourseDescriptions --path ./fetch-course-descriptions/event.json -s mac-dev \
	--docker-arg='--platform linux/amd64'
else
	sls invoke local -f FetchCourseDescriptions --path ./fetch-course-descriptions/event.json -s linux-dev
endif

.PHONY: test
test:
	go test ./...

.PHONY: test-update
test-update:
	go test ./fetch-sections -update
	go test ./fetch-courses -update
	go test ./fetch-subject-areas -update

CURL ?= curl

.PHONY: fixtures
fixtures: fetch-subject-areas/testdata/fixtures/fall2020.html fetch-courses/testdata/fixtures/fall2020-comsci.html fetch-courses/testdata/fixtures/no-results.html fetch-sections/testdata/fixtures/winter2021-comsci-32.html fetch-sections/testdata/fixtures/winter2021-music-185H.html

fetch-subject-areas/testdata/fixtures/fall2020.html:
	$(CURL) -o $@ 'https://sa.ucla.edu/ro/ClassSearch/Public/Search/GetSimpleSearchData?search_type=subject&term_cd=20F' -H "X-Requested-With: XMLHttpRequest"
fetch-courses/testdata/fixtures/fall2020-comsci.html:
	$(CURL) -o $@ 'https://sa.ucla.edu/ro/Public/SOC/Results?t=20F&sBy=subject&subj=COM+SCI'
fetch-courses/testdata/fixtures/no-results.html:
	$(CURL) -o $@ 'https://sa.ucla.edu/ro/Public/SOC/Results?t=20F&sBy=subject&subj=blah'
fetch-sections/testdata/fixtures/winter2021-comsci-32.html:
	$(CURL) -o $@ 'https://sa.ucla.edu/ro/Public/SOC/Results/GetCourseSummary?model=%7B%22Term%22%3A%2221W%22%2C%22SubjectAreaCode%22%3A%22COM+SCI%22%2C%22CatalogNumber%22%3A%220032++++%22%2C%22IsRoot%22%3Atrue%2C%22SessionGroup%22%3A%22%25%22%2C%22ClassNumber%22%3A%22%25%22%2C%22SequenceNumber%22%3Anull%2C%22Path%22%3A%22COMSCI0032%22%2C%22MultiListedClassFlag%22%3A%22n%22%2C%22Token%22%3A%22MDAzMiAgICBDT01TQ0kwMDMy%22%7D&FilterFlags=%7B%22enrollment_status%22%3A%22O%2CW%2CC%2CX%2CT%2CS%22%2C%22advanced%22%3A%22y%22%2C%22meet_days%22%3A%22M%2CT%2CW%2CR%2CF%22%2C%22start_time%22%3A%228%3A00+am%22%2C%22end_time%22%3A%228%3A00+pm%22%2C%22meet_locations%22%3Anull%2C%22meet_units%22%3Anull%2C%22instructor%22%3Anull%2C%22class_career%22%3Anull%2C%22impacted%22%3Anull%2C%22enrollment_restrictions%22%3Anull%2C%22enforced_requisites%22%3Anull%2C%22individual_studies%22%3Anull%2C%22summer_session%22%3Anull%7D' -H 'X-Requested-With: XMLHttpRequest'
fetch-sections/testdata/fixtures/winter2021-music-185H.html:
	$(CURL) -o $@ 'https://sa.ucla.edu/ro/Public/SOC/Results/GetCourseSummary?model=%7B%22Term%22%3A%2221W%22%2C%22SubjectAreaCode%22%3A%22MUSC+++%22%2C%22CatalogNumber%22%3A%220185H+++%22%2C%22IsRoot%22%3Atrue%2C%22SessionGroup%22%3A%22%25%22%2C%22ClassNumber%22%3A%22%25%22%2C%22SequenceNumber%22%3Anull%2C%22Path%22%3A%22MUSC0185H%22%2C%22MultiListedClassFlag%22%3A%22n%22%2C%22Token%22%3A%22MDE4NUggICBNVVNDMDE4NUg%3D%22%7D&FilterFlags=%7B%22enrollment_status%22%3A%22O%2CW%2CC%2CX%2CT%2CS%22%2C%22advanced%22%3A%22y%22%2C%22meet_days%22%3A%22M%2CT%2CW%2CR%2CF%22%2C%22start_time%22%3A%229%3A00+am%22%2C%22end_time%22%3A%2210%3A00+pm%22%2C%22meet_locations%22%3Anull%2C%22meet_units%22%3Anull%2C%22instructor%22%3Anull%2C%22class_career%22%3Anull%2C%22impacted%22%3A%22N%22%2C%22enrollment_restrictions%22%3Anull%2C%22enforced_requisites%22%3Anull%2C%22individual_studies%22%3Anull%2C%22summer_session%22%3Anull%7D&_=1605849646690' -H 'X-Requested-With: XMLHttpRequest'

.PHONY: deploy
deploy: build
	env -u DD_TRACE_ENABLED sls deploy -s production

.PHONY: clean
clean:
	rm -f bin/*
	go mod tidy
