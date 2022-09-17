import * as React from 'react'
import { useMemo, useState } from 'react'
import { compact } from 'lodash-es'

import EnrollmentChart from './EnrollmentChart'
import type { Marker, EnrollmentDatumJSON } from './EnrollmentChart'

import Select from 'components/Select'
import { Card } from 'components/Card'

type TermEnrollmentSection = {
  label: string
  data: EnrollmentDatumJSON[]
}

type TermEnrollmentDatum = {
  term: string
  enrollmentPeriod: {
    start: string
    end: string
    markers: Marker[]
    sections: TermEnrollmentSection[]
    isLive: boolean
  }
  quarterStart: {
    start: string
    end: string
    markers: Marker[]
    sections: TermEnrollmentSection[]
    isLive: boolean
  }
}

type Props = {
  id: string
  termEnrollmentData: TermEnrollmentDatum[]
}

export default function EnrollmentCard({ id, termEnrollmentData }: Props): JSX.Element {
  const terms = termEnrollmentData.map((d) => d.term)
  const [selectedTermIndex, setSelectedTermIndex] = useState(0)
  const selectedTermData = termEnrollmentData[selectedTermIndex]

  const periodItems = useMemo(
    () =>
      compact([
        selectedTermData.enrollmentPeriod.sections.length > 0 ? { label: 'Enrollment', id: 'enroll' } : null,
        selectedTermData.quarterStart.sections.length > 0 ? { label: 'Drops', id: 'drop' } : null,
      ]),
    [selectedTermData]
  )

  const [selectedPeriod, setSelectedPeriod] = useState(periodItems[0].id)

  const termItems = useMemo(() => terms.map((term) => ({ id: term, label: term })), [terms])

  const SelectNodes = [
    <Select
      key="period"
      label="Enrollment or drops:"
      labelInvisible
      className="w-32"
      onSelect={(period) => setSelectedPeriod(period.id.toString())}
      items={periodItems}
    />,
    <Select
      key="term"
      label="Select a term:"
      labelInvisible
      className="w-24"
      onSelect={(_, i) => setSelectedTermIndex(i)}
      items={termItems}
    />,
  ]

  const { markers, start, end, sections, isLive } =
    selectedPeriod === 'drop' ? selectedTermData.quarterStart : selectedTermData.enrollmentPeriod

  return (
    <Card id={id} title="Enrollment Progress" rightContent={SelectNodes}>
      <EnrollmentChart
        markers={markers}
        enrollmentStart={start}
        enrollmentEnd={end}
        sectionLabels={sections.map((s) => s.label)}
        sectionData={sections.map((s) => s.data)}
        isLive={isLive}
      />
    </Card>
  )
}
