import * as React from 'react'
import {useState} from 'react'
import {RadioGroup} from '@headlessui/react'
import {clsx} from 'clsx'

const plans = [
  {name: 'Not Following'},
  {name: 'Plan', description: 'Add course to your quarter plan.'},
  {
    name: 'Notify',
    description: 'Get text message alerts about the course. Will use one of your X notification tokens.',
  },
  {name: 'Enroll', description: 'Add to your enrolled courses.'},
]

export default function Example() {
  const [selected, setSelected] = useState(plans[0])

  return (
    <RadioGroup value={selected} onChange={setSelected}>
      <RadioGroup.Label className="sr-only"> Server size </RadioGroup.Label>
      <div className="space-y-4">
        {plans.map((plan) => (
          <RadioGroup.Option
            key={plan.name}
            value={plan}
            className={({checked, active}) =>
              clsx(
                checked ? 'border-transparent' : 'border-gray-300',
                active ? 'border-indigo-500 ring-2 ring-indigo-500' : '',
                'relative block cursor-pointer rounded-lg border bg-white px-6 py-4 shadow-sm focus:outline-none sm:flex sm:justify-between'
              )
            }
          >
            {({active, checked}) => (
              <>
                <span className="flex items-center">
                  <span className="flex flex-col text-sm">
                    {/* @ts-expect-error */}
                    <RadioGroup.Label as="span" className="font-medium text-gray-900">
                      {plan.name}
                    </RadioGroup.Label>
                    {plan.description && (
                      // @ts-expect-error
                      <RadioGroup.Description as="span" className="text-gray-500">
                        {plan.description}
                      </RadioGroup.Description>
                    )}
                  </span>
                </span>
                <span
                  className={clsx(
                    active ? 'border' : 'border-2',
                    checked ? 'border-indigo-500' : 'border-transparent',
                    'pointer-events-none absolute -inset-px rounded-lg'
                  )}
                  aria-hidden="true"
                />
              </>
            )}
          </RadioGroup.Option>
        ))}
      </div>
    </RadioGroup>
  )
}
