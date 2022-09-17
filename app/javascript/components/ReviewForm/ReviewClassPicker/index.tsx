import * as React from 'react'
import { useMemo, useState, useEffect } from 'react'

import Alert from '../../Alert'
import AutocompletableInput, { renderCourse } from '../../AutocompletableInput'
import LoadingCircle from '../../icons/LoadingCircle'
import Select, { SelectItem } from '../../Select'
import { Course, Term, Section } from '../../types'

export type TermReviewSuggestion = {
  terms: Term[]
  precedingCourse: Course
  supersedingCourse: Course
}

type CourseSuggestion = {
  type: 'course'
  course: Course
}

type SectionSuggestion = {
  type: 'section'
  course: Course
  termSuggestion: TermReviewSuggestion
  selectedTerm: Term
  sections: Section[]
  selectedSection: Section
}

export type InitialSuggestion = CourseSuggestion | SectionSuggestion | null

type Props = {
  coursesURL: string
  sectionSuggestionsURL: string
  termSuggestionsURL: string
  onSectionSelect: (sectionId: string) => void
  initialSuggestion?: InitialSuggestion
}

const courseToString = (c: Course | null): string =>
  c === null ? 'unknown' : `${c.subjectAreaCode} ${c.number}: ${c.title}`

const sectionToLabel = (section: Section): string => {
  let label = ''
  if (section.index) {
    label += `Lecture ${section.index}: `
  }
  if (section.instructor) {
    label += section.instructor.fullLabel
  } else {
    label += section.registrarInstructors[0]
  }
  if (section.days[0]) {
    label += ` (${section.days[0]}${section.times[0] && ` at ${section.times[0]}`})`
  }
  return label
}

function ReviewClassPicker({
  coursesURL,
  sectionSuggestionsURL,
  termSuggestionsURL,

  initialSuggestion = null,
  onSectionSelect: onSectionSelectCallback,
}: Props): JSX.Element {
  // Render initial suggestion, if there is one
  let needPlaceholder = true
  let initialSelectedCourse: Course | null = null
  let initialTermSuggestion: TermReviewSuggestion | null = null
  let initialSelectedTerm: Term | null = null
  let initialSections: Section[] = []
  let initialSelectedSection: Section | null = null

  if (initialSuggestion?.type === 'course') {
    initialSelectedCourse = initialSuggestion.course
  } else if (initialSuggestion?.type === 'section') {
    initialSelectedCourse = initialSuggestion.course
    initialTermSuggestion = initialSuggestion.termSuggestion
    initialSelectedTerm = initialSuggestion.selectedTerm
    initialSections = initialSuggestion.sections
    initialSelectedSection = initialSuggestion.selectedSection
    // We don't want placeholder select values, since we have selected values!
    needPlaceholder = false
  }

  useEffect(() => {
    if (initialSuggestion?.type === 'section') {
      // Trigger the section selection callback, since we're starting with a selected section!
      onSectionSelectCallback(initialSuggestion.selectedSection.id.toString())
    }
    // Only run on initial mount
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  const [selectedCourse, setSelectedCourse] = useState<Course | null>(initialSelectedCourse)
  const [selectedTerm, setSelectedTerm] = useState<Term | null>(initialSelectedTerm)
  const [selectedSection, setSelectedSection] = useState<Section | null>(initialSelectedSection)
  const [sections, setSections] = useState<Section[]>(initialSections)
  const [termSuggestion, setTermSuggestion] = useState<TermReviewSuggestion | null>(initialTermSuggestion)
  const precedingCourse = termSuggestion?.precedingCourse ?? null
  const supersedingCourse = termSuggestion?.supersedingCourse ?? null

  // Loading states
  const [isLoadingTerms, setLoadingTerms] = useState(false)
  const [isLoadingSections, setLoadingSections] = useState(false)

  // Memoized
  const terms = useMemo(() => termSuggestion?.terms ?? [], [termSuggestion])
  const termItems = useMemo(() => terms.map((term) => ({ id: term.term, label: term.readable })), [terms])
  const sectionItems = useMemo(
    () => sections.map((section) => ({ id: section.id, label: sectionToLabel(section) })),
    [sections]
  )

  // Fetch the terms and deprecation info for a given course.
  // Triggered on changes to selected course.
  useEffect(() => {
    const fetchTerms = async () => {
      if (selectedCourse === null) return

      const url = new URL(`${termSuggestionsURL}?course_id=${selectedCourse.id}`)
      setLoadingTerms(true)
      try {
        const res = await fetch(url.toString(), {
          headers: { Accept: 'application/json' },
        })
        if (res.ok) {
          const termsSuggestion: TermReviewSuggestion = await res.json()
          setTermSuggestion(termsSuggestion)
        } else {
          console.error('Could not get terms', url.toString(), res.status)
        }
      } finally {
        setLoadingTerms(false)
      }
    }
    fetchTerms()
  }, [selectedCourse, termSuggestionsURL])

  // Fetch sections corresponding to currently chosen course and term.
  // Triggered on changes to selected course or term.
  useEffect(() => {
    const fetchSections = async () => {
      if (selectedCourse === null || selectedTerm === null) return

      const url = new URL(`${sectionSuggestionsURL}?course_id=${selectedCourse.id}&term=${selectedTerm.term}`)
      setLoadingSections(true)
      try {
        const res = await fetch(url.toString(), {
          headers: { Accept: 'application/json' },
        })
        if (res.ok) {
          const sections = await res.json()
          setSections(sections)
        } else {
          console.error('Could not get sections', url.toString(), res.status)
        }
      } finally {
        setLoadingSections(false)
      }
    }
    fetchSections()
  }, [sectionSuggestionsURL, selectedCourse, selectedTerm])

  const onCourseSelect = (course: Course) => {
    setSelectedCourse(course)
    setSelectedTerm(null)
    setSections([])
  }

  const onTermSelect = (_: SelectItem, i: number) => {
    const term = terms[i]
    setSelectedTerm(term)
  }

  const onSectionSelect = (_: SelectItem, i: number) => {
    const section = sections[i]
    setSelectedSection(section)
    onSectionSelectCallback(section.id.toString())
  }

  const selectedTermIndex = selectedTerm ? terms.findIndex((term) => term.term === selectedTerm.term) : undefined
  const selectedSectionIndex = selectedSection
    ? sections.findIndex((section) => section.id === selectedSection.id)
    : undefined

  return (
    <div className="w-full space-y-4">
      <AutocompletableInput
        id="review-class-picker"
        suggestionURL={coursesURL}
        label="Course"
        placeholder="Search for your class…"
        onSelect={onCourseSelect}
        initialSelectedItem={selectedCourse}
        required={true}
        renderSuggestion={renderCourse}
        suggestionToString={courseToString}
      />

      {precedingCourse !== null && (
        <Alert type="info" title="Can't find your term?">
          <p>
            This course was previously offered as{' '}
            <a className="underline cursor-pointer" onClick={() => onCourseSelect(precedingCourse)}>
              {courseToString(precedingCourse)}
            </a>
            .
          </p>
        </Alert>
      )}

      {supersedingCourse !== null && (
        <Alert type="info" title="Can't find your term?">
          <p>
            This course is no longer offered and has been renamed to{' '}
            <a className="underline cursor-pointer" onClick={() => onCourseSelect(supersedingCourse)}>
              {courseToString(supersedingCourse)}
            </a>
            .
          </p>
        </Alert>
      )}

      {selectedCourse &&
        (isLoadingTerms ? (
          <LoadingCircle className="h-5 w-5 my-2" />
        ) : (
          <Select
            id="term"
            label="Term"
            placeholder={needPlaceholder}
            items={termItems}
            onSelect={onTermSelect}
            initialSelectedIndex={selectedTermIndex}
          />
        ))}

      {selectedCourse &&
        selectedTerm &&
        (isLoadingSections ? (
          <LoadingCircle className="h-5 w-5 my-2" />
        ) : (
          <Select
            id="section"
            label="Section"
            placeholder={needPlaceholder}
            items={sectionItems}
            onSelect={onSectionSelect}
            initialSelectedIndex={selectedSectionIndex}
          />
        ))}
    </div>
  )
}

export default ReviewClassPicker
