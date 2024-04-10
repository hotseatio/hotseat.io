import * as React from 'react'
import {Fragment} from 'react'
import {Dialog, Transition} from '@headlessui/react'

import SearchMajorMinor from './SearchMajorMinor'

import CloseButton from 'components/GetTokensButton/CloseButton'

type Props = {
  open: boolean
  setOpen: (open: boolean) => void
  addType: string
}

export default function AddMajorMinorModal({open, setOpen, addType}: Props) {
  const placeholder = 'Search for your ' + addType
  return (
    <Transition.Root show={open} as={Fragment}>
      <Dialog className="fixed z-10 inset-0 overflow-y-auto" onClose={setOpen}>
        <div className="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block lg:p-0">
          <Transition.Child
            as={Fragment}
            enter="ease-out duration-300"
            enterFrom="opacity-0"
            enterTo="opacity-100"
            leave="ease-in duration-200"
            leaveFrom="opacity-100"
            leaveTo="opacity-0"
          >
            <Dialog.Overlay className="fixed inset-0 bg-gray-500 dark:bg-gray-400 bg-opacity-75 transition-opacity" />
          </Transition.Child>

          {/* This element is to trick the browser into centering the modal contents. */}
          <span className="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">
            &#8203;
          </span>
          <Transition.Child
            as={Fragment}
            enter="ease-out duration-300"
            enterFrom="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            enterTo="opacity-100 translate-y-0 sm:scale-100"
            leave="ease-in duration-200"
            leaveFrom="opacity-100 translate-y-0 sm:scale-100"
            leaveTo="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
          >
            <div className="inline-block align-bottom bg-white dark:bg-gray-900 rounded-lg px-4 pt-5 pb-4 text-left overflow-hidden shadow-xl transform transition-all sm:align-middle sm:max-w-4xl sm:p-6">
              <CloseButton onClick={() => setOpen(false)} />

              <div className="text-center max-w-7xl mx-auto px-4 sm:px-6 h-5/6 lg:h-2/3 mt-8 sm:mt-0">
                <h1 className="mt-2 text-lg font-bold text-gray-900 dark:text-white">Select your {addType}(s)</h1>
              </div>
              <h2 className="mt-2 text-sm font-medium text-gray-900 dark:text-white">Selected {addType}s</h2>
              <div className="flex-1 flex items-center justify-center px-2 py-4">
                <SearchMajorMinor
                  searchUrl="invalidSearchUrl"
                  suggestionUrl="invalidSuggestionUrl"
                  magnifyingGlass={true}
                  placeholder={placeholder}
                  isShrinkable={false}
                  label="Search"
                />
              </div>
            </div>
          </Transition.Child>
        </div>
      </Dialog>
    </Transition.Root>
  )
}
