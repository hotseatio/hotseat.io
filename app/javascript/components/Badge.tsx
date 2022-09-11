import * as React from 'react'
import classNames from 'classnames'

export type BadgeColor = { text: string; background: string }

type Props = {
  label: string
  color: BadgeColor
  className?: string
  size?: 'small' | 'medium' | 'large'
}

export default function Badge({ label, color, className, size = 'medium' }: Props): JSX.Element {
  return (
    <span
      className={classNames(
        'inline-flex items-center rounded-full text-xs font-medium',
        {
          'px-2 py-0.5': size === 'small',
          'px-2.5 py-0.5': size === 'medium',
          'px-3 py-0.5': size === 'large',
        },
        color.background,
        color.text,
        className
      )}
    >
      {label}
    </span>
  )
}
