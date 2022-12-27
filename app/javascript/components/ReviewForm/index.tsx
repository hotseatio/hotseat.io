import * as React from 'react'
import { useMemo, useState, useReducer } from 'react'
import { omit, camelCase } from 'lodash-es'

import ReviewClassPicker, { InitialSuggestion } from './ReviewClassPicker'
import Question from './Question'
import type { QuestionType } from './Question'

import Alert from 'components/Alert'
import Select from 'components/Select'
import type { SelectItem } from 'components/Select'
import LoadingCircle from 'components/icons/LoadingCircle'
import { authenticityHeaders } from 'utilities/authenticityHeaders'
import { formatRequestBody } from 'utilities/formatRequestBody'

type QuestionData = {
  id: string
  text: string
  type: QuestionType
  required: boolean
}

type QuestionSection = {
  title: string
  questions: QuestionData[]
}

type Review = {
  id: string
  organization: number
  clarity: number
  overall: number
  grade: string
  weeklyTime: string
  groupProject: boolean
  extraCredit: boolean
  attendance: boolean
  midtermCount: number
  final: string
  textbook: boolean
  comments: string
}

type Props = {
  questionSections: QuestionSection[]
  grades: string[]
  createURL: string
  coursesURL: string
  sectionSuggestionsURL: string
  termSuggestionsURL: string
  initialSuggestion?: InitialSuggestion
  review: Review | null
}

interface FormState {
  sectionId: string
  grade: string | null
  gradeIndex: number | 'placeholder'
  organization: number
  clarity: number
  overall: number
  weeklyTime: string
  groupProject: boolean
  extraCredit: boolean
  attendance: boolean
  midtermCount: number
  final: string
  textbook: boolean
  comments: string
}

const formReducer = (state: Partial<FormState>, partialState: Partial<FormState>) => {
  const nextState = {
    ...state,
    ...partialState,
  }

  return nextState
}

const initializeReviewFormState = ([review, grades]: [review: Review | null, grades: string[]]): Partial<FormState> => {
  let gradeIndex: number | 'placeholder' = grades.findIndex((grade) => grade === review.grade)
  if (gradeIndex === -1) {
    gradeIndex = 'placeholder'
  }

  return { gradeIndex, ...omit(review, 'id') }
}

export default function ReviewForm({
  createURL,
  coursesURL,
  sectionSuggestionsURL,
  termSuggestionsURL,
  initialSuggestion,
  questionSections,
  grades,
  review,
}: Props): JSX.Element {
  const [error, setError] = useState<string | null>(null)
  const [isSubmitting, setIsSubmitting] = useState(false)

  const [formData, updateFormData] = useReducer(formReducer, [review, grades], initializeReviewFormState)
  const gradeItems = useMemo(() => grades.map((grade) => ({ id: grade, label: grade })), [grades])
  const isEdit = review !== null

  const onSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()
    setIsSubmitting(true)
    const body = { review: omit(formData, 'gradeIndex') }
    const response = await fetch(createURL, {
      method: 'POST',
      headers: authenticityHeaders({ 'Content-Type': 'application/json' }),
      body: JSON.stringify(formatRequestBody(body)),
    })

    if (response.status !== 200) {
      const responseBody = await response.json()
      setError(responseBody.msg)
    } else {
      if (response.redirected === true) {
        window.location.href = response.url
      }
    }
    setIsSubmitting(false)
  }

  console.log('formData: ', formData)
  return (
    <form action="/reviews" acceptCharset="UTF-8" method="post" onSubmit={onSubmit}>
      <h3 className="my-6 text-2xl font-extrabold text-gray-900 dark:text-white">The class</h3>
      <ReviewClassPicker
        coursesURL={coursesURL}
        sectionSuggestionsURL={sectionSuggestionsURL}
        termSuggestionsURL={termSuggestionsURL}
        initialSuggestion={initialSuggestion}
        onSectionSelect={(sectionId: string) => updateFormData({ sectionId })}
      />

      <Select
        id="grade"
        className="mt-4"
        label="Received grade"
        items={gradeItems}
        value={formData.gradeIndex}
        onSelect={(selected: SelectItem, i: number) => updateFormData({ grade: selected.label, gradeIndex: i })}
      />

      {questionSections.map((section) => (
        <div className="my-4" key={section.title}>
          <h3 className="my-6 text-2xl font-extrabold text-gray-900 dark:text-white">{section.title}</h3>
          {section.questions.map((question) => {
            const id = camelCase(question.id)
            return (
              <Question
                key={id}
                id={id}
                text={question.text}
                type={question.type}
                required={question.required}
                onSelect={(id: string, value: string) => updateFormData({ [id]: value })}
                value={formData[id] ?? null}
              />
            )
          })}
        </div>
      ))}

      <div className="my-4">
        <h3 id="comments" className="text-2xl font-extrabold text-gray-900 dark:text-white">
          Comments
        </h3>
        <div className="text-sm text-gray-500 dark:text-gray-400">
          <p className="mb-1">Not sure what to write? Here are some places to start!</p>
          <ul className="list-disc list-inside">
            <li>What did you like about lectures? What could the instructor improve upon?</li>
            <li>Were you prepared for tests from lectures, readings, and the homeworks?</li>
            <li>Did you receive the grade you expected?</li>
            <li>Did you learn what you wanted to from the class?</li>
          </ul>
        </div>

        <textarea
          required={true}
          rows={8}
          className="text-field mt-4"
          name="review[comments]"
          id="review_comments"
          onChange={(e: React.ChangeEvent<HTMLTextAreaElement>) => updateFormData({ comments: e.target.value })}
          aria-labelledby="comments"
          value={formData.comments}
        />
      </div>

      {error !== null && (
        <Alert type="error" title="Could not submit review">
          <p>{error}</p>
        </Alert>
      )}

      <button
        type="submit"
        name="button"
        className="mt-4 submit-button disabled:opacity-50 flex items-center justify-center"
        disabled={isSubmitting}
      >
        <span>Publish review</span>
        {isSubmitting && <LoadingCircle className="ml-2 h-5 w-5" />}
      </button>
    </form>
  )
}
