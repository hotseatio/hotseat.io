import * as React from 'react'
import {useState} from 'react'

import {RemovePhoneModal, AddPhoneModal, ChangePhoneModal} from './PhoneModals'

type Props = {
  initialPhoneNumber: string | null
}

export default function PhoneInput({initialPhoneNumber}: Props): JSX.Element {
  const [phone, setPhone] = useState(initialPhoneNumber)
  const [isModalOpen, setIsModalOpen] = useState<false | 'new' | 'change' | 'delete'>(false)

  const input = phone ? (
    <div className="flex rounded-md shadow-sm">
      <div className="relative flex items-stretch flex-grow focus-within:z-10">
        <input
          type="tel"
          value={phone ?? undefined}
          name="user[phone]"
          id="user_phone"
          className="base-input block w-full rounded-none rounded-l-md"
          disabled={true}
        />
      </div>
      <button type="button" className="inline-button" onClick={() => setIsModalOpen('change')}>
        Change
      </button>
      <button type="button" className="inline-button rounded-r-md" onClick={() => setIsModalOpen('delete')}>
        Remove
      </button>
    </div>
  ) : (
    <button
      type="button"
      id="user_phone"
      className="rounded-md px-3 py-2 text-sm font-semibold text-gray-900 dark:text-gray-50 bg-white dark:bg-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 dark:ring-gray-600 hover:bg-gray-50 dark:hover:bg-gray-800"
      onClick={() => setIsModalOpen('new')}
    >
      Add
    </button>
  )

  return (
    <div id="phone">
      <label className="input-label mb-1" htmlFor="user_phone">
        Phone Number
      </label>
      {input}
      <AddPhoneModal
        isOpen={isModalOpen === 'new'}
        onCancel={() => setIsModalOpen(false)}
        onConfirm={(verifiedPhone: string) => {
          setIsModalOpen(false)
          setPhone(verifiedPhone)
        }}
      />
      <ChangePhoneModal
        isOpen={isModalOpen === 'change'}
        onCancel={() => setIsModalOpen(false)}
        onConfirm={(verifiedPhone: string) => {
          setIsModalOpen(false)
          setPhone(verifiedPhone)
        }}
      />
      <RemovePhoneModal
        isOpen={isModalOpen === 'delete'}
        onCancel={() => setIsModalOpen(false)}
        onRemove={() => {
          setPhone(null)
          setIsModalOpen(false)
        }}
      />
    </div>
  )
}
