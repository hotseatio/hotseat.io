import * as React from 'react'
import { useMemo, useState } from 'react'
import { CheckIcon } from '@heroicons/react/24/outline'


import SectionRow from './SectionRow'
import type { Section } from './SectionRow'
import { IsBetaTesterContext } from './context'
import { ReviewButton, RegistrarButton, FollowButton, SubscribeButton } from './Buttons'

import { TermSelectCard } from 'components/Card'

type EnrollmentPeriod = 'pre' | 'current' | 'post'

type TermSections = {
  // Whether or not enrollment is currently open for the sections.
  enrollmentPeriod: EnrollmentPeriod
  sections: Section[]
}

type Props = {
  isBetaTester: boolean
  id: string
  sectionsByTerm: [string, TermSections][]
}

const constructActionButtons = (
  enrollmentPeriod: EnrollmentPeriod,
  section: Section,
  sectionIndex: number,
  callbacks: { onSubscribeToggle: (sectionIndex: number) => void; onFollowToggle: (sectionIndex: number) => void }
): React.ReactNode => {
  let actionButtons = null
  if (enrollmentPeriod === 'post') {
    const reviewButton = section.isReviewed ? (
      <div className="flex items-center text-gray-500 dark:text-gray-400 text-sm">
        Reviewed <CheckIcon className="h-5 w-5 ml-1 text-gray-400 dark:text-gray-500" />
      </div>
    ) : (
      <ReviewButton sectionId={section.id} />
    )
    actionButtons = (
      <>
        <RegistrarButton link={section.detailsLink} />
        {reviewButton}
      </>
    )
  } else if (enrollmentPeriod === 'current') {
    actionButtons = (
      <>
        <RegistrarButton link={section.detailsLink} />
        <FollowButton
          isFollowed={section.isFollowed}
          sectionId={section.id}
          onClick={() => callbacks.onFollowToggle(sectionIndex)}
        />
        <SubscribeButton
          isSubscribed={section.isSubscribed}
          sectionId={section.id}
          onClick={() => callbacks.onSubscribeToggle(sectionIndex)}
        />
      </>
    )
  }

  return actionButtons
}

export default function SectionListCard({ isBetaTester, sectionsByTerm: initialSectionsByTerm }: Props): JSX.Element {
  const [sectionsByTerm, setSectionsByTerm] = useState(initialSectionsByTerm)
  const [selectedTermIndex, setSelectedTermIndex] = useState(0)
  const terms = useMemo(() => sectionsByTerm.map(([term]) => term), [sectionsByTerm])
  const { enrollmentPeriod, sections } = sectionsByTerm[selectedTermIndex][1]

  const onFollowToggle = (sectionIndex: number) => {
    sections[sectionIndex].isFollowed = !sections[sectionIndex].isFollowed
    setSectionsByTerm([...sectionsByTerm])
  }
  const onSubscribeToggle = (sectionIndex: number) => {
    sections[sectionIndex].isSubscribed = !sections[sectionIndex].isSubscribed
    setSectionsByTerm([...sectionsByTerm])
  }

  return (
    <IsBetaTesterContext.Provider value={isBetaTester}>
      <TermSelectCard id="sections" title="Section List" onTermSelect={setSelectedTermIndex} terms={terms}>
        <ul className="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
          {sections.map((section, sectionIndex) => {
            const actionButtons = constructActionButtons(enrollmentPeriod, section, sectionIndex, {
              onFollowToggle,
              onSubscribeToggle,
            })
            return <SectionRow key={section.id} section={section} actionButtons={actionButtons} />
          })}
        </ul>
      </TermSelectCard>
    </IsBetaTesterContext.Provider>
  )
}
