import * as React from 'react'
import {useMemo, useState, useEffect, useReducer} from 'react'

import Alert from 'components/Alert'
import AutocompletableInput, {renderCourse} from 'components/AutocompletableInput'
import LoadingCircle from 'components/icons/LoadingCircle'
import Select, {SelectItem} from 'components/Select'
import {Course, Term, Section} from 'api'

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
  coursesUrl: string
  sectionSuggestionsUrl: string
  termSuggestionsUrl: string
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

interface ReviewClassPickerState {
  terms: Term[]
  precedingCourse: Course | null
  supersedingCourse: Course | null
  selectedCourse: Course | null
  selectedTermIndex: number | 'placeholder'
  selectedSectionIndex: number | 'placeholder'
  sections: Section[]
  // Loading states
  isLoadingTerms: boolean
  isLoadingSections: boolean
}

const reviewClassPickerReducer = (
  state: ReviewClassPickerState,
  partialState: Partial<ReviewClassPickerState>
): ReviewClassPickerState => {
  const nextState = {
    ...state,
    ...partialState,
  }

  return nextState
}

const initializeReviewClassPickerState = (initialSuggestion: InitialSuggestion): ReviewClassPickerState => {
  // Render initial suggestion, if there is one
  let selectedCourse: Course | null = null
  let terms: Term[] = []
  let sections: Section[] = []
  let precedingCourse: Course | null = null
  let supersedingCourse: Course | null = null
  let selectedTermIndex: number | 'placeholder' = 'placeholder'
  let selectedSectionIndex: number | 'placeholder' = 'placeholder'

  if (initialSuggestion?.type === 'course') {
    selectedCourse = initialSuggestion.course
  } else if (initialSuggestion?.type === 'section') {
    const {selectedTerm, selectedSection} = initialSuggestion

    selectedCourse = initialSuggestion.course
    sections = initialSuggestion.sections
    terms = initialSuggestion.termSuggestion.terms
    precedingCourse = initialSuggestion.termSuggestion.precedingCourse
    supersedingCourse = initialSuggestion.termSuggestion.supersedingCourse

    selectedTermIndex = terms.findIndex((term) => term.term === selectedTerm.term)
    selectedSectionIndex = sections.findIndex((section) => section.id === selectedSection.id)
  }

  return {
    selectedCourse,
    selectedTermIndex,
    selectedSectionIndex,
    sections,
    terms,
    precedingCourse,
    supersedingCourse,
    isLoadingTerms: false,
    isLoadingSections: false,
  }
}

function ReviewClassPicker({
  coursesUrl,
  sectionSuggestionsUrl,
  termSuggestionsUrl,

  initialSuggestion = null,
  onSectionSelect: onSectionSelectCallback,
}: Props): JSX.Element {
  useEffect(() => {
    if (initialSuggestion?.type === 'section') {
      // Trigger the section selection callback, since we're starting with a selected section!
      onSectionSelectCallback(initialSuggestion.selectedSection.id.toString())
    }
    // Only run on initial mount
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  const [state, updateState] = useReducer(reviewClassPickerReducer, initialSuggestion, initializeReviewClassPickerState)
  const {selectedCourse, sections, terms, selectedTermIndex, selectedSectionIndex, precedingCourse, supersedingCourse} =
    state

  // Derived state
  const selectedTerm = terms[selectedTermIndex]
  // Memoized derived state
  const termItems = useMemo(() => terms.map((term) => ({id: term.term, label: term.readable})), [terms])
  const sectionItems = useMemo(
    () => sections.map((section) => ({id: section.id, label: sectionToLabel(section)})),
    [sections]
  )

  // Fetch the terms and deprecation info for a given course.
  // Triggered on changes to selected course.
  useEffect(() => {
    const fetchTerms = async () => {
      if (selectedCourse === null) return

      const url = new URL(`${termSuggestionsUrl}?course_id=${selectedCourse.id}`)
      updateState({isLoadingTerms: true})
      try {
        const res = await fetch(url.toString(), {
          headers: {Accept: 'application/json'},
        })
        if (res.ok) {
          const termSuggestion: TermReviewSuggestion = await res.json()
          updateState({...termSuggestion})
        } else {
          console.error('Could not get terms', url.toString(), res.status)
        }
      } finally {
        updateState({isLoadingTerms: false})
      }
    }
    fetchTerms()
  }, [selectedCourse, termSuggestionsUrl])

  // Fetch sections corresponding to currently chosen course and term.
  // Triggered on changes to selected course or term.
  useEffect(() => {
    const fetchSections = async () => {
      if (selectedCourse === null || selectedTerm === null) return

      const url = new URL(`${sectionSuggestionsUrl}?course_id=${selectedCourse.id}&term=${selectedTerm.term}`)
      updateState({isLoadingSections: true})
      try {
        const res = await fetch(url.toString(), {
          headers: {Accept: 'application/json'},
        })
        if (res.ok) {
          const sections = await res.json()
          updateState({sections})
        } else {
          console.error('Could not get sections', url.toString(), res.status)
        }
      } finally {
        updateState({isLoadingSections: false})
      }
    }
    fetchSections()
  }, [sectionSuggestionsUrl, selectedCourse, selectedTerm])

  const onCourseSelect = (course: Course) => {
    updateState({
      selectedCourse: course,
      selectedTermIndex: 'placeholder',
      selectedSectionIndex: 'placeholder',
      sections: [],
    })
  }

  const onTermSelect = (_: SelectItem, i: number) => {
    updateState({selectedTermIndex: i, selectedSectionIndex: 'placeholder'})
  }

  const onSectionSelect = (_: SelectItem, i: number) => {
    const section = sections[i]
    updateState({selectedSectionIndex: i})
    onSectionSelectCallback(section.id.toString())
  }

  return (
    <div className="w-full space-y-4">
      <AutocompletableInput
        id="review-class-picker"
        suggestionUrl={coursesUrl}
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
        (state.isLoadingTerms ? (
          <LoadingCircle className="h-5 w-5 my-2" />
        ) : (
          <Select id="term" label="Term" items={termItems} onSelect={onTermSelect} value={selectedTermIndex} />
        ))}

      {selectedCourse &&
        selectedTerm &&
        (state.isLoadingSections ? (
          <LoadingCircle className="h-5 w-5 my-2" />
        ) : (
          <Select
            id="section"
            label="Section"
            items={sectionItems}
            onSelect={onSectionSelect}
            value={selectedSectionIndex}
          />
        ))}
    </div>
  )
}

export default ReviewClassPicker
