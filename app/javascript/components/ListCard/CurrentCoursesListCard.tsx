import * as React from 'react'
import { useState } from 'react'
import { AcademicCapIcon } from '@heroicons/react/outline'


import CourseRow from './CourseRow'
import type { Section } from './SectionRow'
import { DetailsButton, FollowButton, SubscribeButton } from './Buttons'
import { IsBetaTesterContext } from './context'

import { GetMoreTokensButton } from 'components/GetTokensButton'
import { Card } from 'components/Card'
import type { SubjectArea } from 'api'

type Props = {
  isBetaTester: boolean
  enrollmentPeriod: string
  sections: Section[]
  id: string
  title: string
  notificationTokenCount?: number
  subjectAreas: SubjectArea[]
}

function CourseList({ sections: initialSections }: { sections: Section[] }): JSX.Element {
  const [sections, setSections] = useState(initialSections)
  const onFollowToggle = (sectionIndex: number) => {
    sections[sectionIndex].isFollowed = !sections[sectionIndex].isFollowed
    if (sections[sectionIndex].isFollowed === false) {
      // Remove section when it is no longer followed
      setSections(sections.filter((_, i) => i !== sectionIndex))
    } else {
      setSections([...sections])
    }
  }
  const onSubscribeToggle = (sectionIndex: number) => {
    sections[sectionIndex].isSubscribed = !sections[sectionIndex].isSubscribed
    setSections([...sections])
  }

  return (
    <ul className="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
      {sections.map((section) => {
        const actionButtons = (
          <>
            <DetailsButton link={section.detailsLink} />
            <FollowButton
              isFollowed={section.isFollowed}
              sectionId={section.id}
              onClick={() => onFollowToggle(section.id)}
            />
            <SubscribeButton
              isSubscribed={section.isSubscribed}
              sectionId={section.id}
              onClick={() => onSubscribeToggle(section.id)}
            />
          </>
        )
        return <CourseRow key={section.id} section={section} actionButtons={actionButtons} />
      })}
    </ul>
  )
}

function EmptyState({ subjectAreas }: { subjectAreas: SubjectArea[] }): JSX.Element {
  return (
    <div className="text-center p-12">
      <AcademicCapIcon className="mx-auto h-12 w-12 text-gray-400 dark:text-gray-500" />
      <h3 className="mt-2 text-sm font-medium text-gray-900 dark:text-white">No courses</h3>
      <p className="mt-1 text-sm text-gray-400 mb-4 dark:text-gray-500">
        Add courses by searching for them above or by picking a subject.
      </p>
      <ul className="grid gap-y-2 gap-x-4 grid-cols-2 md:grid-cols-3">
        {subjectAreas.map((subjectArea) => (
          <a href={subjectArea.linkUrl} key={subjectArea.id} className="cursor-pointer">
            <li className="inline-flex items-center px-3 py-0.5 rounded-lg text-sm font-medium bg-red-100 text-red-800 hover:bg-red-200">
              {subjectArea.name}
            </li>
          </a>
        ))}
      </ul>
    </div>
  )
}

export default function CurrentCoursesListCard({
  isBetaTester,
  sections,
  notificationTokenCount,
  subjectAreas,
}: Props): JSX.Element {
  const rightContent = (
    <div className="flex items-center">
      <p className="hidden sm:inline-block text-sm text-gray-500 dark:text-gray-400 pr-2">{`Notification tokens: ${notificationTokenCount}`}</p>
      <GetMoreTokensButton />
    </div>
  )

  return (
    <IsBetaTesterContext.Provider value={isBetaTester}>
      <Card id="current-courses" title="Current Courses" rightContent={rightContent}>
        {sections.length > 0 ? <CourseList sections={sections} /> : <EmptyState subjectAreas={subjectAreas} />}
      </Card>
    </IsBetaTesterContext.Provider>
  )
}
