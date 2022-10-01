import * as React from 'react'
import { UserIcon, UsersIcon, CalendarIcon } from '@heroicons/react/outline'
import Badge from '../Badge'
import type { Section } from './SectionRow'

export type CourseRowProps = {
  section: Section
  actionButtons: React.ReactNode
}

// Display a section primarily by its course
export default function CourseRow({
  section: { title, instructorCount, instructorLabel, termLabel, badgeLabel, badgeColor },
  actionButtons,
}: CourseRowProps) {
  return (
    <li>
      <div className="block hover:bg-gray-50 dark:hover:bg-gray-700">
        <div className="flex items-center px-4 py-2 sm:px-6">
          <div className="min-w-0 flex-1 sm:flex sm:items-center sm:justify-between">
            <div className="sm:flex-1 min-w-0">
              <div className="flex flex-row items-center mb-0.5">
                <p className="text-base font-medium text-gray-700 dark:text-gray-200 truncate">{title}</p>
                {badgeLabel && badgeColor && (
                  <Badge className="ml-2 inline-flex text-xs" label={badgeLabel} color={badgeColor} size="small" />
                )}
              </div>

              <div className="sm:flex sm:space-x-3">
                {instructorLabel !== null && instructorCount !== null && (
                  <p className="flex items-center text-sm text-gray-500">
                    {instructorCount > 1 ? (
                      <UsersIcon className="flex-shrink-0 mr-1.5 h-5 w-5 text-gray-400 dark:text-gray-500" />
                    ) : (
                      <UserIcon className="flex-shrink-0 mr-1.5 h-5 w-5 text-gray-400 dark:text-gray-500" />
                    )}
                    {instructorLabel}
                  </p>
                )}

                {termLabel && (
                  <p className="flex items-center text-sm text-gray-500 dark:text-gray-400">
                    <CalendarIcon
                      className="flex-shrink-0 mr-1.5 h-5 w-5 text-gray-400 dark:text-gray-500"
                      aria-hidden="true"
                    />
                    {termLabel}
                  </p>
                )}
              </div>
            </div>
          </div>
          <div className="ml-4 flex items-center flex-shrink-0 space-x-2">{actionButtons}</div>
        </div>
      </div>
    </li>
  )
}
