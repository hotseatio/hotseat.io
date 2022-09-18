import * as React from 'react'
import { ClockIcon, LocationMarkerIcon, UserIcon, UsersIcon, CalendarIcon } from '@heroicons/react/outline'

import Badge from 'components/Badge'
import type { BadgeColor } from 'components/Badge'

export type Section = {
  id: number
  title: string
  instructorCount: number | null
  instructorLabel: string | null
  timeLabel: string | null
  locationLabel: string | null
  termLabel: string | null
  isFollowed: boolean
  isSubscribed: boolean
  isReviewed: boolean
  badgeLabel: string | null
  badgeColor: BadgeColor | null
  detailsLink: string
}

export type SectionRowProps = {
  section: Section
  actionButtons: React.ReactNode
}

export default function SectionRow({
  section: { title, instructorCount, instructorLabel, timeLabel, locationLabel, termLabel, badgeLabel, badgeColor },
  actionButtons,
}: SectionRowProps) {
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
                {timeLabel && (
                  <p className="flex items-center text-sm text-gray-500 dark:text-gray-400">
                    <ClockIcon
                      className="flex-shrink-0 mr-1.5 h-5 w-5 text-gray-400 dark:text-gray-500"
                      aria-hidden="true"
                    />
                    {timeLabel}
                  </p>
                )}
                {locationLabel && (
                  <p className="flex items-center text-sm text-gray-500 dark:text-gray-400">
                    <LocationMarkerIcon
                      className="flex-shrink-0 mr-1.5 h-5 w-5 text-gray-400 dark:text-gray-500"
                      aria-hidden="true"
                    />
                    {locationLabel}
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
