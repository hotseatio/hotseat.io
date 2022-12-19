import * as React from 'react'
import { XMarkIcon } from '@heroicons/react/24/outline'

type Props = {
  onClick: () => void
}

export default function CloseButton({ onClick }: Props) {
  return (
    <div className="block absolute top-0 right-0 pt-4 pr-4">
      <button
        type="button"
        className="rounded-md text-gray-400 dark:text-gray-500 hover:text-gray-500 dark:hover:text-gray-400 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
        onClick={onClick}
      >
        <span className="sr-only">Close</span>
        <XMarkIcon className="h-6 w-6" aria-hidden="true" />
      </button>
    </div>
  )
}
