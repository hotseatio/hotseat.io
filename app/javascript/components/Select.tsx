import * as React from 'react'
import { Fragment, useMemo, useState } from 'react'
import { Listbox, Transition } from '@headlessui/react'
import { CheckIcon, SelectorIcon } from '@heroicons/react/solid'
import classNames from 'classnames'

export type SelectItemID = number | string
export type SelectItem = {
  id: SelectItemID
  label: string
}

type Props = {
  id?: string
  className?: string
  items: SelectItem[]
  placeholder?: boolean
  placeholderText?: string
  label?: string
  labelInvisible?: boolean
  onSelect: (selected: SelectItem, index: number) => void
  initialSelectedIndex?: number
}

export default function Select({
  id,
  className,
  label,
  labelInvisible = false,
  items,
  onSelect,
  // Zero-width nonbreaking space - keeps the line height of text without containing content
  placeholderText = '\u200b',
  placeholder = false,
  initialSelectedIndex = 0,
}: Props): JSX.Element {
  const initialSelectedItem = placeholder || !(initialSelectedIndex in items) ? undefined : items[initialSelectedIndex]
  const [selectedID, setSelectedID] = useState<SelectItemID | undefined>(initialSelectedItem?.id)
  const selectedItem = useMemo(() => items.find((item) => item.id === selectedID), [items, selectedID])

  const onChange = (newSelectedID: SelectItemID) => {
    const newSelectedIndex = items.findIndex((item) => item.id === newSelectedID)
    setSelectedID(newSelectedID)
    onSelect(items[newSelectedIndex], newSelectedIndex)
  }

  return (
    <div id={id} className={className} role="presentation">
      <Listbox value={selectedID} onChange={onChange}>
        {({ open }) => (
          <>
            {label && (
              <Listbox.Label
                className={classNames(
                  'block text-sm font-medium text-gray-700 dark:text-gray-200 mb-1',
                  labelInvisible && 'sr-only'
                )}
              >
                {label}
              </Listbox.Label>
            )}
            <div className="relative" role="presentation">
              <Listbox.Button className="bg-white dark:bg-gray-600 relative w-full border border-gray-300 dark:border-gray-600 rounded-md shadow-sm pl-3 pr-10 py-2 text-left cursor-default focus:outline-none focus:ring-1 focus:ring-red-500 focus:border-red-500 sm:text-sm">
                <span className="block">{selectedItem?.label ?? placeholderText}</span>

                <span className="absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
                  <SelectorIcon className="h-5 w-5 text-gray-400 dark:text-gray-500" aria-hidden="true" />
                </span>
              </Listbox.Button>

              <Transition
                show={open}
                as={Fragment}
                leave="transition ease-in duration-100"
                leaveFrom="opacity-100"
                leaveTo="opacity-0"
              >
                <Listbox.Options
                  static
                  className="absolute z-10 mt-1 w-full bg-white dark:bg-black shadow-lg max-h-60 rounded-md py-1 text-base ring-1 ring-black ring-opacity-5 overflow-auto focus:outline-none sm:text-sm"
                >
                  {items.map((item) => (
                    <Listbox.Option
                      key={item.id}
                      className={({ active }) =>
                        classNames(
                          active ? 'text-white bg-red-600' : 'text-gray-900 dark:text-white',
                          'cursor-default select-none relative py-2 pl-3 pr-9'
                        )
                      }
                      value={item.id}
                    >
                      {({ selected, active }) => (
                        <>
                          <span className={classNames(selected ? 'font-semibold' : 'font-normal', 'block truncate')}>
                            {item.label}
                          </span>

                          {selected ? (
                            <span
                              className={classNames(
                                active ? 'text-white' : 'text-red-600',
                                'absolute inset-y-0 right-0 flex items-center pr-4'
                              )}
                            >
                              <CheckIcon className="h-5 w-5" aria-hidden="true" />
                            </span>
                          ) : null}
                        </>
                      )}
                    </Listbox.Option>
                  ))}
                </Listbox.Options>
              </Transition>
            </div>
          </>
        )}
      </Listbox>
    </div>
  )
}
