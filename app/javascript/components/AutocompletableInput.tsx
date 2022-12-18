import * as React from 'react'
import { useState } from 'react'
import { useCombobox } from 'downshift'
import { useDebounceCallback } from '@react-hook/debounce'
import { SearchIcon } from '@heroicons/react/solid'
import {clsx} from 'clsx'

import { Course } from 'api'

interface IdObj {
  id: string | number
}

type Props<Suggestion> = {
  id: string
  className?: string

  suggestionURL: string
  label: string
  placeholder?: string
  // Whether or not to display the search icon.
  shouldDisplayIcon?: boolean
  // When a user selects an autocomplete suggestion.
  onSelect: (s: Suggestion) => void
  // When a user submits their input.
  onInputChange?: (input: string | undefined) => void
  // When input is focused
  onFocus?: () => void
  // When input is unfocused
  onBlur?: () => void

  renderSuggestion: (s: Suggestion) => JSX.Element | string
  suggestionToString: (s: Suggestion | null) => string

  initialSelectedItem?: Suggestion | null
  required?: boolean
}

export const renderCourse = (c: Course): JSX.Element => {
  return (
    <div className="w-full truncate">
      {`${c.subjectAreaCode} ${c.number} `}
      <span className="text-gray-400 dark:text-gray-500">{c.title}</span>
    </div>
  )
}

export default function AutocompletableInput<Suggestion extends IdObj>({
  id,
  className,
  suggestionURL,
  label,
  onSelect,
  onInputChange,
  onFocus,
  onBlur,
  placeholder,
  renderSuggestion,
  suggestionToString,
  shouldDisplayIcon = false,
  initialSelectedItem,
  required = false,
}: Props<Suggestion>): JSX.Element {
  const [suggestions, setSuggestions] = useState<Suggestion[]>([])

  const fetchSuggestions = useDebounceCallback(async (value: string) => {
    const url = new URL(suggestionURL)
    url.searchParams.set('q', value)
    try {
      const res = await fetch(url.toString(), { headers: { Accept: 'application/json' } })
      if (res.ok) {
        setSuggestions((await res.json()) as Suggestion[])
      } else {
        console.error('Could not get suggestions', res.status)
      }
    } catch (error) {
      console.error(url, error)
    }
  }, 200)

  const { isOpen, getLabelProps, getMenuProps, getInputProps, getComboboxProps, highlightedIndex, getItemProps } =
    useCombobox({
      id,
      items: suggestions,
      initialSelectedItem,
      itemToString: suggestionToString,
      onInputValueChange: ({ inputValue }) => {
        if (onInputChange) {
          onInputChange(inputValue)
        }
        if (inputValue) {
          fetchSuggestions(inputValue)
        }
      },
      onSelectedItemChange: ({ selectedItem }) => {
        if (selectedItem) {
          onSelect(selectedItem)
        }
      },
    })

  return (
    <div className={clsx('relative', className)} role="presentation">
      <label className="sr-only" {...getLabelProps()}>
        {label}
      </label>
      <div {...getComboboxProps()} className="rounded-md shadow-sm">
        {shouldDisplayIcon && (
          <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
            <SearchIcon className="h-5 w-5 text-gray-400 dark:text-gray-500" fill="currentColor" aria-hidden="true" />
          </div>
        )}
        <input
          {...getInputProps({ onFocus, onBlur })}
          placeholder={placeholder}
          type="text"
          className={clsx('base-input block w-full rounded-md', { 'pl-10': shouldDisplayIcon })}
          required={required}
        />
      </div>
      <ul
        {...getMenuProps()}
        // Only show when we have results, otherwise the menu looks weird!
        hidden={!isOpen || suggestions.length === 0}
        className="absolute z-10 mt-1 py-1 bg-white dark:bg-black w-full shadow-lg max-h-60 rounded-md text-base ring-1 ring-black ring-opacity-5 overflow-auto focus:outline-none sm:text-md"
      >
        {suggestions.map((suggestion, index) => (
          <li
            className={clsx(
              highlightedIndex === index ? 'text-white bg-red-600' : 'text-gray-900 dark:text-gray-50',
              'cursor-default select-none relative py-2 pl-8 pr-4'
            )}
            key={suggestion.id}
            {...getItemProps({ item: suggestion, index })}
          >
            {renderSuggestion(suggestion)}
          </li>
        ))}
      </ul>
    </div>
  )
}
