import * as React from 'react'

import type {Section} from './SectionRow'

import Select from 'components/Select'

export type RegistrationCourseRowProps = {
  section: Section
  actionButtons: React.ReactNode
}

// Display a section primarily by its course
export default function RegistrationCourseRow({section: {title}, actionButtons}: RegistrationCourseRowProps) {
  const testProf = [
    {id: 0, label: 'Bob'},
    {id: 1, label: 'Candice'},
  ]
  const testQuarter = [
    {id: 0, label: '23F'},
    {id: 1, label: '24W'},
  ]

  return (
    <li>
      <div className="block hover:bg-gray-50 dark:hover:bg-gray-700 px-4 sm:px-6">
        <div className="grid grid-cols-12 gap-4">
          <div className="col-span-1 ml-4 flex items-center flex-shrink-0 space-x-2">{actionButtons}</div>

          <div className="col-span-5 min-w-0 flex-1 sm:flex sm:items-center sm:justify-between">
            <div className="sm:flex-1 min-w-0">
              <div className="flex flex-row items-center mb-0.5">
                <p className="text-base font-medium text-gray-700 dark:text-gray-200">{title}</p>
              </div>
            </div>
          </div>

          <div className="col-span-4 min-w-0 flex-1 sm:flex sm:items-center sm:justify-between w-3/4">
            <div className="sm:flex-1 min-w-0">
              <Select
                id="prof"
                label=""
                labelInvisible
                onSelect={() => console.log('select prof')}
                items={testProf}
                value={0}
              />
            </div>
          </div>

          <div className="col-span-2 min-w-0 flex-1 sm:flex sm:items-center sm:justify-between w-3/4">
            <div className="sm:flex-1 min-w-0">
              <Select
                id="quarter"
                label=""
                labelInvisible
                onSelect={() => console.log('select quarter')}
                items={testQuarter}
                value={0}
              />
            </div>
          </div>
        </div>
      </div>
    </li>
  )
}
