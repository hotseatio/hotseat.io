import * as React from 'react'

export type QuestionType = 'agreement' | 'time' | 'binary' | 'count' | 'final'

function questionValueRange(type: 'agreement'): [1, 2, 3, 4, 5, 6, 7]
function questionValueRange(type: 'time'): string[]
function questionValueRange(type: 'binary'): ['false', 'true']
function questionValueRange(type: 'count'): [0, 1, 2, 3]
function questionValueRange(type: 'final'): ['none', '10th', 'finals']
function questionValueRange(type: QuestionType): number[] | string[] {
  switch (type) {
    case 'agreement':
      return [1, 2, 3, 4, 5, 6, 7]
    case 'time':
      return ['0-5', '5-10', '10-15', '15-20', '20+']
    case 'binary':
      return ['false', 'true']
    case 'count':
      return [0, 1, 2, 3]
    case 'final':
      return ['none', '10th', 'finals']
  }
}

function questionLabelForValue(
  q:
    | {type: 'agreement'; value: 1 | 2 | 3 | 4 | 5 | 6 | 7}
    | {type: 'count'; value: 0 | 1 | 2 | 3}
    | {type: 'binary'; value: 'false' | 'true'}
    | {type: 'final'; value: 'none' | '10th' | 'finals'}
    | {type: 'time'; value: string}
): string {
  const likertResponsesAgreement = {
    1: 'Strongly disagree',
    2: 'Disagree',
    3: 'Somewhat disagree',
    4: 'Neutral',
    5: 'Somewhat agree',
    6: 'Agree',
    7: 'Strongly agree',
  }
  const responsesCount = {
    0: '0',
    1: '1',
    2: '2',
    3: '3 or more',
  }
  const responsesBinary = {
    false: 'No',
    true: 'Yes',
  }
  const responsesFinal = {
    none: 'No',
    '10th': 'Yes, during 10th week',
    finals: 'Yes, during finals week',
  }

  switch (q.type) {
    case 'agreement':
      return likertResponsesAgreement[q.value]
    case 'time':
      return `${q.value} hrs/week`
    case 'binary':
      return responsesBinary[q.value]
    case 'count':
      return responsesCount[q.value]
    case 'final':
      return responsesFinal[q.value]
  }
}

type QuestionProps = {
  id: string
  text: string
  type: QuestionType
  required: boolean
  onSelect: (id: string, value: string) => void
  value: number | string | null
}

export default function Question({
  id,
  text,
  type,
  required,
  onSelect,
  value: checkedValue,
}: QuestionProps): JSX.Element {
  const onChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    onSelect(id, e.target.value)
  }
  return (
    <div className="mb-12" id={id} role="presentation">
      <h4 className="text-center my-4 text-lg font-bold" aria-hidden>
        {text}
      </h4>
      <div className="max-w-xl mx-auto flex flex-col sm:flex-row justify-between" role="radiogroup" aria-label={text}>
        {
          // @ts-ignore: TypeScript can't tell that questionValueRange works
          questionValueRange(type).map((value: any, i: number) => {
            const inputId = `review_${id}_${i}`
            return (
              <div
                key={inputId}
                className="flex-1 flex flex-row sm:flex-col items-center text-center text-sm mb-2 sm:mb-0"
              >
                <input
                  type="radio"
                  id={inputId}
                  name={`review[${id}]`}
                  value={value}
                  className="rating-radio"
                  required={required}
                  onChange={onChange}
                  checked={value === checkedValue}
                />
                <label htmlFor={inputId} className="ml-2 sm:ml-0">
                  {questionLabelForValue({type, value})}
                </label>
              </div>
            )
          })
        }
      </div>
    </div>
  )
}
