import * as React from 'react'
import {useState} from 'react'

import Select from 'components/Select'
import type {SelectItem} from 'components/Select'

const years = [
  {id: 1, label: 'First'},
  {id: 2, label: 'Second'},
  {id: 3, label: 'Third'},
  {id: 4, label: 'Fourth+'},
]

export default function SelectYear(): JSX.Element {
  const [currentYear, setCurrentYear] = useState(1)
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
