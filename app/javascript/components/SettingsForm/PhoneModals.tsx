import * as React from 'react'
import { useEffect, useState } from 'react'
import classNames from 'classnames'
import { PhoneIcon } from '@heroicons/react/solid'

import ConfirmModal from 'components/ConfirmModal'
import RequestButton from 'components/RequestButton'

type PhoneModalProps = {
  isOpen: boolean
  onCancel: () => void
  onConfirm: (verifiedPhone: string) => void
}

type AddChangePhoneModalProps = PhoneModalProps & {
  type: 'new' | 'change'
}

export function AddChangePhoneModal({ isOpen, type, onCancel, onConfirm }: AddChangePhoneModalProps): JSX.Element {
  const [phone, setPhone] = useState<string | null>(null)
  const [confirmationCodeSent, setConfirmationCodeSent] = useState(false)
  const [confirmationCode, setConfirmationCode] = useState<string | null>(null)
  const [phoneErrorMessage, setPhoneErrorMessage] = useState<string | null>(null)
  const [codeErrorMessage, setCodeErrorMessage] = useState<string | null>(null)
  const [codePlaceholder, setCodePlaceholder] = useState<string | null>(null)

  // Reset modal on open
  useEffect(() => {
    if (isOpen) {
      setPhone(null)
      setConfirmationCodeSent(false)
      setConfirmationCode(null)
      setPhoneErrorMessage(null)
      setCodeErrorMessage(null)
    }
  }, [isOpen])

  const onPhoneInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setPhone(e.target.value)
  }
  const onConfirmationCodeInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setConfirmationCode(e.target.value)
  }

  return (
    <ConfirmModal
      isOpen={isOpen}
      title={type === 'new' ? 'Add Phone Number' : 'Change Phone Number'}
      description="Standard SMS rates may apply."
      onCancel={onCancel}
      onConfirm={() => {
        setPhoneErrorMessage(null)
        setCodeErrorMessage(null)
        if (phone) onConfirm(phone)
      }}
      onError={(error) => {
        setCodeErrorMessage(error?.msg ?? 'Invalid confirmation code')
      }}
      confirmLabel="Verify"
      confirmRequest={{
        method: 'POST',
        resource: '/users/confirm-verify-phone',
        body: phone && confirmationCode ? { phone, code: confirmationCode } : undefined,
      }}
      confirmDisabled={confirmationCode?.length !== 6}
      Icon={PhoneIcon}
    >
      <div className="w-3/5 mx-auto my-6">
        <div>
          <label htmlFor="phone-number" className={confirmationCodeSent ? 'input-label' : 'sr-only'}>
            Phone Number
          </label>
          <div className="mt-1 flex items-center rounded-md shadow-sm w-full">
            <input
              type="tel"
              name="phone-number"
              id="phone-number"
              className={classNames('base-input rounded-l-md sm:text-sm border-gray-300', {
                'text-red-900 placeholder-red-300 dark:placeholder-red-500 focus:outline-none focus:ring-red-500 focus:border-red-500':
                  phoneErrorMessage,
              })}
              placeholder="+1 (555) 987-6543"
              onChange={onPhoneInputChange}
              value={phone}
              aria-invalid={phoneErrorMessage ? 'true' : undefined}
              aria-describedby={phoneErrorMessage ? 'phone-error-message' : undefined}
            />
            <RequestButton
              method="POST"
              resource="/users/verify-phone"
              body={phone ? { phone } : undefined}
              className="-ml-px relative items-center space-x-2 button-background-unrounded rounded-r-md"
              loadingClassName="ml-3"
              onError={(body) => setPhoneErrorMessage(body?.msg ?? 'Could not set phone number')}
              onClick={(body) => {
                if (body.formattedPhone) {
                  setPhone(body.formattedPhone)
                }
                setCodePlaceholder(body.confirmationCodePlaceholder ?? null)
                setConfirmationCodeSent(true)
                setPhoneErrorMessage(null)
              }}
            >
              Add
            </RequestButton>
          </div>
          {phoneErrorMessage && (
            <p className="mt-0.5 text-sm text-red-600" id="phone-error-message">
              {phoneErrorMessage}
            </p>
          )}
        </div>
        {confirmationCodeSent && (
          <div className="mt-2">
            <label htmlFor="phone-number" className="input-label">
              Confirmation Code
            </label>
            <div className="mt-1 flex items-center rounded-md shadow-sm w-full">
              <input
                type="text"
                name="confirmation-code"
                id="confirmation-code"
                className={classNames('base-input rounded-l-md sm:text-sm border-gray-300 block w-full rounded-md', {
                  'text-red-900 placeholder-red-300 dark:placeholder-red-500 focus:outline-none focus:ring-red-500 focus:border-red-500':
                    codeErrorMessage,
                })}
                onChange={onConfirmationCodeInputChange}
                placeholder={codePlaceholder}
                aria-invalid={codeErrorMessage ? 'true' : undefined}
                aria-describedby={codeErrorMessage ? 'code-error-message' : undefined}
              />
            </div>
            {codeErrorMessage && (
              <p className="mt-1 text-sm text-red-600" id="code-error-message">
                {codeErrorMessage}
              </p>
            )}
          </div>
        )}
      </div>
    </ConfirmModal>
  )
}

export function AddPhoneModal(props: PhoneModalProps): JSX.Element {
  return <AddChangePhoneModal type="new" {...props} />
}

export function ChangePhoneModal(props: PhoneModalProps): JSX.Element {
  return <AddChangePhoneModal type="change" {...props} />
}

type RemovePhoneModalProps = {
  isOpen: boolean
  onCancel: () => void
  onRemove: () => void
}

export function RemovePhoneModal({ isOpen, onCancel, onRemove }: RemovePhoneModalProps): JSX.Element {
  return (
    <ConfirmModal
      isOpen={isOpen}
      title="Remove Phone Number"
      description="Removing your phone number will unsubscribe you from all classes. Are you sure?"
      onCancel={onCancel}
      onConfirm={onRemove}
      confirmLabel="Remove"
      confirmRequest={{
        method: 'PUT',
        resource: '/users/remove-phone',
      }}
      Icon={PhoneIcon}
    />
  )
}
