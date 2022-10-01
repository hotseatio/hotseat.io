import * as React from 'react'
import { useMemo, useState } from 'react'
import ReviewClassPicker, { InitialSuggestion } from './ReviewClassPicker'
import Alert from '../Alert'
import Select from '../Select'
import LoadingCircle from '../icons/LoadingCircle'
import Question from './Question'
import type { QuestionType } from './Question'
import { authenticityHeaders } from 'utilities/authenticityHeaders'

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

type Props = {
  questionSections: QuestionSection[]
  grades: string[]
  createURL: string
  coursesURL: string
  sectionSuggestionsURL: string
  termSuggestionsURL: string
  initialSuggestion?: InitialSuggestion
}

export default function ReviewForm({
  createURL,
  coursesURL,
  sectionSuggestionsURL,
  termSuggestionsURL,
  initialSuggestion,
  questionSections,
  grades,
}: Props): JSX.Element {
  const [error, setError] = useState<string | null>(null)
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [formData, setFormData] = useState({})
  const onInputSelect = (id: string, value: string) => {
    setFormData({
      ...formData,
      [id]: value,
    })
  }

  const gradeItems = useMemo(() => grades.map((grade) => ({ id: grade, label: grade })), [grades])

  const onSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()
    setIsSubmitting(true)
    const body = { review: formData }
    const response = await fetch(createURL, {
      method: 'POST',
      headers: authenticityHeaders({ 'Content-Type': 'application/json' }),
      body: JSON.stringify(body),
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

  const onSectionSelect = (sectionId: string) => onInputSelect('section_id', sectionId)

  return (
    <form action="/reviews" acceptCharset="UTF-8" method="post" onSubmit={onSubmit}>
      <h3 className="my-6 text-2xl font-extrabold text-gray-900 dark:text-white">The class</h3>
      <ReviewClassPicker
        coursesURL={coursesURL}
        sectionSuggestionsURL={sectionSuggestionsURL}
        termSuggestionsURL={termSuggestionsURL}
        initialSuggestion={initialSuggestion}
        onSectionSelect={onSectionSelect}
      />

      <Select
        id="grade"
        className="mt-4"
        placeholder={true}
        label="Received grade"
        items={gradeItems}
        onSelect={(selected) => onInputSelect('grade', selected.label)}
      />

      {questionSections.map((section) => (
        <div className="my-4" key={section.title}>
          <h3 className="my-6 text-2xl font-extrabold text-gray-900 dark:text-white">{section.title}</h3>
          {section.questions.map((question) => (
            <Question
              key={question.id}
              id={question.id}
              text={question.text}
              type={question.type}
              required={question.required}
              onSelect={onInputSelect}
            />
          ))}
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
          onChange={(e: React.ChangeEvent<HTMLTextAreaElement>) => onInputSelect('comments', e.target.value)}
          aria-labelledby="comments"
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
