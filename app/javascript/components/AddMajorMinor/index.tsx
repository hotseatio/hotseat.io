import * as React from 'react'
import {useState} from 'react'

import AddMajorMinorModal from './AddMajorMinorModal'

export default function AddMajorMinor(): JSX.Element {
  const [isModalOpen, setIsModalOpen] = useState(false)

  const onOpenModal = () => {
    setIsModalOpen(true)
  }

  return (
    <>
      <button className="button-primary" onClick={onOpenModal}>
        Add a major
      </button>
      <AddMajorMinorModal open={isModalOpen} setOpen={setIsModalOpen} />
    </>
  )
}
