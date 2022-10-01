import * as React from 'react'
import { useState } from 'react'
import classNames from 'classnames'

import LoadingCircle from 'components/icons/LoadingCircle'
import { authenticityHeaders } from 'utilities/authenticityHeaders'

type Props = {
  title?: string
  className?: string
  loadingClassName?: string
  resource: string
  method: string
  body?: { [key: string]: string | number | boolean }
  onClick?: (payload: any) => void // eslint-disable-line @typescript-eslint/no-explicit-any
  onError?: (payload?: any) => void // eslint-disable-line @typescript-eslint/no-explicit-any
  children: React.ReactNode
  disabled?: boolean
}

export default function RequestButton({
  title,
  className,
  loadingClassName,
  resource,
  method,
  body,
  onClick,
  onError,
  disabled = false,
  children,
}: Props): JSX.Element {
  const [isSubmitting, setIsSubmitting] = useState(false)

  const onSubmit = async (e: React.MouseEvent<HTMLElement>) => {
    e.preventDefault()
    setIsSubmitting(true)
    const response = await fetch(resource, {
      method,
      headers: authenticityHeaders({ 'Content-Type': 'application/json' }),
      body: body ? JSON.stringify(body) : undefined,
    })

    if (response.redirected === true) {
      window.location.href = response.url
      return
    }

    setIsSubmitting(false)
    if (!response.ok) {
      console.error(response)
      if (onError) {
        try {
          const responseBody = await response.json()
          onError(responseBody)
        } catch {
          onError()
        }
      }
    } else {
      if (onClick) {
        const responseBody = await response.json()
        onClick(responseBody)
      }
    }
  }

  return isSubmitting ? (
    <LoadingCircle className={classNames('h-5 w-5', loadingClassName)} />
  ) : (
    <button title={title} className={className} onClick={onSubmit} disabled={disabled}>
      {children}
    </button>
  )
}
