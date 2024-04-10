import * as React from 'react'
import {useState} from 'react'

import Select from 'components/Select'
import type {SelectItem} from 'components/Select'

const years = [
  {id: 0, label: 'First'},
  {id: 1, label: 'Second'},
  {id: 2, label: 'Third'},
  {id: 3, label: 'Fourth+'},
]

export default function SelectYear(): JSX.Element {
  const [currentYear, setCurrentYear] = useState(0)
  return (
    <Select
      id="year"
      className="mt-4"
      label=""
      labelInvisible={true}
      items={years}
      value={currentYear}
      onSelect={(selected: SelectItem, i: number) => setCurrentYear(i)}
    />
  )
}
