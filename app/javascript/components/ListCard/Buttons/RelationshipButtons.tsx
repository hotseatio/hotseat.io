import * as React from 'react'
import { useState } from 'react'
import RequestButton from '../../RequestButton'
import ConfirmModal from '../../ConfirmModal'
import GetMoreTokensModal from '../../GetTokensButton/GetMoreTokensModal'
import { StarIcon as StarIconSolid, BellIcon as BellIconSolid } from '@heroicons/react/solid'
import { StarIcon as StarIconOutline, BellIcon as BellIconOutline } from '@heroicons/react/outline'

type ButtonProps = {
  sectionId: number
  onClick?: () => void
}

export function FollowButton({ isFollowed, ...props }: ButtonProps & { isFollowed: boolean }): JSX.Element {
  return isFollowed ? <ToggledFollowButton {...props} /> : <UntoggledFollowButton {...props} />
}

export function SubscribeButton({ isSubscribed, ...props }: ButtonProps & { isSubscribed: boolean }): JSX.Element {
  return isSubscribed ? <ToggledSubscribeButton {...props} /> : <UntoggledSubscribeButton {...props} />
}

function UntoggledFollowButton({ sectionId, onClick }: ButtonProps): JSX.Element {
  return (
    <RequestButton
      title="Add to my courses"
      className="button-secondary"
      resource="/relationships"
      method="POST"
      body={{ section_id: sectionId, subscribe: false }}
      onClick={onClick}
    >
      <StarIconOutline className="h-5 w-5" />
    </RequestButton>
  )
}

function ToggledFollowButton({ sectionId, onClick }: ButtonProps): JSX.Element {
  return (
    <RequestButton
      title="Remove from my courses"
      className="button-secondary"
      resource={`/relationships/${sectionId}`}
      method="DELETE"
      body={{ section_id: sectionId, subscription_only: false }}
      onClick={onClick}
    >
      <StarIconSolid className="h-5 w-5" />
    </RequestButton>
  )
}

function UntoggledSubscribeButton({ sectionId, onClick }: ButtonProps): JSX.Element {
  const [isModalOpen, setIsModalOpen] = useState(false)
  const [notificationTokens, setNotificationTokens] = useState(0)
  const [phone, setPhone] = useState<string | null>(null)

  const onOpenModal = (payload: { notificationTokens: number; phone: string }) => {
    setNotificationTokens(payload.notificationTokens)
    setPhone(payload.phone)
    setIsModalOpen(true)
  }
  const onConfirm = () => {
    setIsModalOpen(false)
    if (onClick) onClick()
  }

  const showGetMoreTokensModal = notificationTokens === 0
  let subscribeDisabled = false
  let description: string | null = null
  if (phone === null) {
    description = "You don't currently have a phone number set. Go over to Settings to add your number!"
    subscribeDisabled = true
  } else {
    description = `You will receive text message alerts to ${phone} about enrollment changes to this class. Message and data rates may apply. You may unsubscribe at any time in your settings page. This subscription will use one of your ${notificationTokens} notification tokens. To obtain more notification tokens, write reviews for classes you've taken.`
  }

  return (
    <>
      <RequestButton
        title="Notify me"
        className="button-primary"
        resource="/user/details"
        method="GET"
        onClick={onOpenModal}
      >
        <BellIconOutline className="h-5 w-5" />
      </RequestButton>
      {showGetMoreTokensModal ? (
        <GetMoreTokensModal open={isModalOpen} setOpen={setIsModalOpen} />
      ) : (
        <ConfirmModal
          title="Confirm subscription"
          description={description}
          isOpen={isModalOpen}
          Icon={BellIconOutline}
          onConfirm={onConfirm}
          onCancel={() => setIsModalOpen(false)}
          confirmDisabled={subscribeDisabled}
          confirmLabel="Subscribe"
          confirmRequest={{
            method: 'POST',
            resource: '/relationships',
            body: { section_id: sectionId, subscribe: true },
          }}
        />
      )}
    </>
  )
}

function ToggledSubscribeButton({ sectionId, onClick }: ButtonProps): JSX.Element {
  const [isModalOpen, setIsModalOpen] = useState(false)
  const onConfirm = () => {
    setIsModalOpen(false)
    if (onClick) onClick()
  }

  return (
    <>
      <button title="Don't notify me" className="button-primary" onClick={() => setIsModalOpen(true)}>
        <BellIconSolid className="h-5 w-5" />
      </button>
      <ConfirmModal
        title="Confirm unsubscribe"
        isOpen={isModalOpen}
        Icon={BellIconOutline}
        onConfirm={onConfirm}
        onCancel={() => setIsModalOpen(false)}
        confirmLabel="Unsubscribe"
        confirmRequest={{
          method: 'DELETE',
          resource: `/relationships/${sectionId}`,
          body: { section_id: sectionId, subscription_only: true },
        }}
      />
    </>
  )
}
