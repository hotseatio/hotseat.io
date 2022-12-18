import * as React from 'react'
import { useState } from 'react'
import {clsx} from 'clsx'
import { usePopper } from 'react-popper'
import { Listbox } from '@headlessui/react'
import { CheckIcon, FilterIcon, SelectorIcon } from '@heroicons/react/solid'

type Link = {
  key: string
  label: string
  url: string
  selected: boolean
}

type Props = {
  links: Link[]
}

export default function FilterButton({ links }: Props): JSX.Element | null {
  const [referenceElement, setReferenceElement] = useState<HTMLButtonElement | null>(null)
  const [popperElement, setPopperElement] = useState<HTMLUListElement | null>(null)
  const { styles, attributes } = usePopper(referenceElement, popperElement, {
    placement: 'bottom-end',
  })

  if (links.length === 0) {
    return null
  }

  const selectedItem = links.find((link) => link.selected)

  return (
    <Listbox
      value={selectedItem}
      onChange={() => {
        /* noop */
      }}
    >
      <Listbox.Button
        className="w-full bg-white dark:bg-gray-900 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm px-4 py-2 inline-flex justify-center text-sm text-gray-700 dark:text-gray-200 hover:bg-gray-50 dark:hover:bg-gray-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
        ref={setReferenceElement}
      >
        <FilterIcon className="mr-3 h-5 w-5 text-gray-400 dark:text-gray-500" aria-hidden="true" />
        {selectedItem?.label ?? 'Filter'}
        <SelectorIcon className="ml-2.5 -mr-1.5 h-5 w-5 text-gray-400 dark:text-gray-500" aria-hidden="true" />
      </Listbox.Button>

      <Listbox.Options
        className="mt-2 w-56 max-h-96 py-1 overflow-auto rounded-md shadow-lg bg-white dark:bg-gray-900 ring-1 ring-black ring-opacity-5 focus:outline-none"
        ref={setPopperElement}
        style={styles.popper}
        {...attributes.popper}
      >
        {links.map((link) => (
          <Listbox.Option
            key={link.key}
            value={link}
            className={({ selected, active }) =>
              clsx(
                active ? 'text-white bg-red-600' : 'text-gray-900 dark:text-white',
                selected ? 'font-semibold' : 'font-normal',
                'text-sm'
              )
            }
          >
            {({ selected, active }) => (
              <a href={link.url} className={'block px-4 py-2 relative'}>
                {link.label}
                {selected ? (
                  <span
                    className={clsx(
                      active ? 'text-white' : 'text-red-600',
                      'absolute inset-y-0 right-0 flex items-center pr-4'
                    )}
                  >
                    <CheckIcon className="h-5 w-5" aria-hidden="true" />
                  </span>
                ) : null}
              </a>
            )}
          </Listbox.Option>
        ))}
      </Listbox.Options>
    </Listbox>
  )
}
