import * as React from 'react'
import {useState} from 'react'

import AddMajorMinorModal from './AddMajorMinorModal'

export default function AddMajorMinor(): JSX.Element {
  const [isModalOneOpen, setIsModalOneOpen] = useState(false)
  const [isModalTwoOpen, setIsModalTwoOpen] = useState(false)

  const onOpenModalOne = () => {
    setIsModalOneOpen(true)
  }

  const onOpenModalTwo = () => {
    setIsModalTwoOpen(true)
  }

  return (
    <>
      <div className="mt-6 space-y-6">
        <h3 className="mt-2 text-lg font-bold text-gray-900 dark:text-white">Major(s)</h3>
        <button className="button-background-unrounded" onClick={onOpenModalOne}>
          Add a major
        </button>
        <AddMajorMinorModal open={isModalOneOpen} setOpen={setIsModalOneOpen} addType="major" />
      </div>
      <div className="mt-6 space-y-6">
        <h3 className="mt-2 text-lg font-bold text-gray-900 dark:text-white">Minor(s)</h3>
        <button className="button-background-unrounded" onClick={onOpenModalTwo}>
          Add a minor
        </button>
        <AddMajorMinorModal open={isModalTwoOpen} setOpen={setIsModalTwoOpen} addType="minor" />
      </div>
    </>
  )
}
