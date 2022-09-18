import * as React from 'react'
import { useMemo, useState } from 'react'

import GradeChart from './GradeChart'

import { TermSelectCard } from 'components/Card'


type TermGradeDatum = {
  term: string
  // 13 numbers, representing the percentages of A+, A, A-, ... , F
  grades: [number, number, number, number, number, number, number, number, number, number, number, number, number]
}

type Props = {
  id: string
  termGradeData: TermGradeDatum[]
}

export default function GradeCard({ id, termGradeData }: Props): JSX.Element {
  const terms = useMemo(() => termGradeData.map((d: TermGradeDatum) => d.term), [termGradeData])
  const [selectedTermIndex, setSelectedTermIndex] = useState(0)
  const selectedData = termGradeData[selectedTermIndex].grades

  return (
    <TermSelectCard id={id} title="Previous Grades" onTermSelect={setSelectedTermIndex} terms={terms}>
      <GradeChart data={selectedData} />
    </TermSelectCard>
  )
}
