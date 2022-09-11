import * as React from 'react'
import { Card } from '../Card'
import CourseRow from './CourseRow'
import type { Section } from './SectionRow'
import { CheckIcon } from '@heroicons/react/outline'
import { ReviewButton, DetailsButton } from './Buttons'
import { IsBetaTesterContext } from './context'

type Props = {
  isBetaTester: boolean
  sections: Section[]
}

export default function PreviousCoursesListCard({ isBetaTester, sections }: Props): JSX.Element {
  return (
    <IsBetaTesterContext.Provider value={isBetaTester}>
      <Card id="previous-courses" title="Previous Courses">
        <ul className="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
          {sections.map((section) => {
            const reviewButton = section.isReviewed ? (
              <div className="flex items-center text-gray-500 dark:text-gray-400 text-sm">
                Reviewed <CheckIcon className="h-5 w-5 ml-1 text-gray-400 dark:text-gray-500" />
              </div>
            ) : (
              <ReviewButton sectionId={section.id} />
            )
            const actionButtons = (
              <>
                <DetailsButton link={section.detailsLink} />
                {reviewButton}
              </>
            )
            return <CourseRow key={section.id} section={section} actionButtons={actionButtons} />
          })}
        </ul>
      </Card>
    </IsBetaTesterContext.Provider>
  )
}
