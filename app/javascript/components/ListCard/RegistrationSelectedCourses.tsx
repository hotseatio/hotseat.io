import * as React from 'react'
import {useState} from 'react'
import {TrashIcon} from '@heroicons/react/24/outline'

import RegistrationCourseRow from './RegistrationCourseRow'
import type {Section} from './SectionRow'
import {IsBetaTesterContext} from './context'

import {TableCard} from 'components/Card'

type Props = {
  isBetaTester: boolean
  enrollmentPeriod: string
  sections: Section[]
  id: string
  title: string
}

function CourseListHeader(): JSX.Element {
  return (
    <div className="block">
      <div className="grid grid-cols-12 gap-4">
        <div className="col-span-1 ml-4 flex items-center flex-shrink-0 space-x-2" />

        <div className="col-span-5 min-w-0 flex-1 sm:flex sm:items-center sm:justify-between">
          <div className="sm:flex-1 min-w-0">
            <div className="flex flex-row items-center mb-0.5">
              <p>Course name</p>
            </div>
          </div>
        </div>
        <div className="col-span-4 min-w-0 flex-1 sm:flex sm:items-center sm:justify-between">
          <div className="sm:flex-1 min-w-0">
            <div className="flex flex-row items-center mb-0.5">
              <p>Professor</p>
            </div>
          </div>
        </div>
        <div className="col-span-2 min-w-0 flex-1 sm:flex sm:items-center sm:justify-between">
          <div className="sm:flex-1 min-w-0">
            <div className="flex flex-row items-center mb-0.5">
              <p>Quarter</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

function CourseList({sections: initialSections}: {sections: Section[]}): JSX.Element {
  const [sections, setSections] = useState(initialSections)
  const testSections = [
    {
      id: 123012389123,
      title: 'COMM 1: Principles of Oral Communication',
      instructorCount: null,
      instructorLabel: null,
      timeLabel: null,
      locationLabel: null,
      termLabel: null,
      isFollowed: false,
      isSubscribed: false,
      isReviewed: false,
      badgeLabel: null,
      badgeColor: null,
      detailsLink: '',
    },
  ]

  return (
    <ul className="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
      {testSections.map((section) => {
        const actionButtons = (
          <button
            title="Delete course"
            onClick={() => {
              console.log(sections)
              setSections(testSections)
            }}
          >
            <TrashIcon className="h-5 w-5" />
          </button>
        )
        return <RegistrationCourseRow key={section.id} section={section} actionButtons={actionButtons} />
      })}
    </ul>
  )
}

export default function RegistrationSelectedCourses({isBetaTester, sections}: Props): JSX.Element {
  return (
    <IsBetaTesterContext.Provider value={isBetaTester}>
      <TableCard id="selected-courses" title="Selected Courses" tableHeader={<CourseListHeader />}>
        <CourseList sections={sections} />
      </TableCard>
    </IsBetaTesterContext.Provider>
  )
}
