import * as React from 'react'
import { useState } from 'react'
import { clsx } from 'clsx'

import AutocompletableInput from 'components/AutocompletableInput'
import { Course, Instructor } from 'api'

export type CourseSearchSuggestion = {
  id: string
  searchableType: 'Course'
  searchable: Course & { linkUrl: string }
}

export type InstructorSearchSuggestion = {
  id: string
  searchableType: 'Instructor'
  searchable: Instructor
}

export type SearchSuggestion = CourseSearchSuggestion | InstructorSearchSuggestion

type Props = {
  label: string
  placeholder?: string
  initialValue?: string
  searchUrl: string
  suggestionUrl: string
  magnifyingGlass?: boolean
  isShrinkable: boolean
}

const renderSearchSuggestion = (s: SearchSuggestion) => {
  switch (s.searchableType) {
    case 'Course':
      return (
        <div className="w-full truncate">
          {`${s.searchable.subjectAreaCode} ${s.searchable.number} `}
          <span className="text-gray-400 dark:text-gray-500">{s.searchable.title}</span>
        </div>
      )
    case 'Instructor':
      return s.searchable.fullLabel
  }
}

const suggestionToString = (s: SearchSuggestion | null): string => {
  switch (s?.searchableType) {
    case 'Course':
      return `${s.searchable.subjectAreaCode} ${s.searchable.number}: ${s.searchable.title}`
    case 'Instructor':
      return s.searchable.fullLabel
    default:
      return 'unknown'
  }
}

export default function Search({
  searchUrl,
  suggestionUrl,
  placeholder = '',
  initialValue = undefined,
  label = 'Search',
  magnifyingGlass = false,
  isShrinkable = false,
}: Props): JSX.Element {
  const [isExpanded, setIsExpanded] = useState(false)
  const [inputValue, setInputValue] = useState(initialValue)

  const onSelect = (selectedItem: SearchSuggestion) => {
    // Do not import turbolinks since that fails for server-side rendering.
    if (self.Turbo) {
      self.Turbo.visit(selectedItem.searchable.linkUrl)
    } else {
      location.assign(selectedItem.searchable.linkUrl)
    }
  }

  const onInputChange = (input: string | undefined) => {
    setInputValue(input)
  }

  const onFormSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    if (self.Turbo) {
      event.preventDefault()
      if (inputValue) {
        const url = new URL(searchUrl, document.URL)
        url.searchParams.set('q', inputValue)
        self.Turbo.visit(url.toString())
      }
    }
  }

  const onFocus = isShrinkable ? () => setIsExpanded(true) : undefined
  const onBlur = isShrinkable ? () => setIsExpanded(false) : undefined
  const className = isShrinkable
    ? clsx('w-full mx-auto transition-all duration-300 ease-in-out', isExpanded ? 'sm:max-w-xl' : 'sm:max-w-xs')
    : undefined

  return (
    <form method="get" action={searchUrl} onSubmit={onFormSubmit}>
      <AutocompletableInput
        id="search-downshift-input"
        className={className}
        label={label}
        placeholder={placeholder}
        shouldDisplayIcon={magnifyingGlass}
        suggestionUrl={suggestionUrl}
        onSelect={onSelect}
        onFocus={onFocus}
        onBlur={onBlur}
        onInputChange={onInputChange}
        renderSuggestion={renderSearchSuggestion}
        suggestionToString={suggestionToString}
      />
    </form>
  )
}
