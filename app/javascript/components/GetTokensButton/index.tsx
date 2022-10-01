import * as React from 'react'
import { useState } from 'react'

import GetMoreTokensModal from './GetMoreTokensModal'

export function GetMoreTokensButton(): JSX.Element {
  const [isModalOpen, setIsModalOpen] = useState(false)

  const onOpenModal = () => {
    setIsModalOpen(true)
  }

  return (
    <>
      <button className="button-primary" onClick={onOpenModal}>
        Get tokens
      </button>
      <GetMoreTokensModal open={isModalOpen} setOpen={setIsModalOpen} />
    </>
  )
}
