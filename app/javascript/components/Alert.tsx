import * as React from 'react'
import {XCircleIcon, ExclamationTriangleIcon, CheckCircleIcon, InformationCircleIcon} from '@heroicons/react/20/solid'
import {clsx} from 'clsx'

export type AlertType = 'error' | 'warn' | 'success' | 'info'

type Props = {
  type: AlertType
  title: string
  children: React.ReactNode
}

function getColors(type: AlertType) {
  switch (type) {
    case 'error':
      return {bg: 'bg-red-50', icon: 'text-red-400', headerText: 'text-red-800', bodyText: 'text-red-700'}
    case 'warn':
      return {bg: 'bg-yellow-50', icon: 'text-yellow-400', headerText: 'text-yellow-800', bodyText: 'text-yellow-700'}
    case 'success':
      return {bg: 'bg-green-50', icon: 'text-green-400', headerText: 'text-green-800', bodyText: 'text-green-700'}
    case 'info':
    default:
      return {bg: 'bg-blue-50', icon: 'text-blue-400', headerText: 'text-blue-800', bodyText: 'text-blue-700'}
  }
}

function getIcon(type: AlertType): (props: React.SVGProps<SVGSVGElement>) => JSX.Element {
  switch (type) {
    case 'error':
      return XCircleIcon
    case 'warn':
      return ExclamationTriangleIcon
    case 'success':
      return CheckCircleIcon
    case 'info':
    default:
      return InformationCircleIcon
  }
}

export default function Alert({type, title, children}: Props): JSX.Element {
  const colors = getColors(type)
  const Icon = getIcon(type)
  return (
    <div className={clsx(colors.bg, 'rounded-md p-4 my-2')}>
      <div className="flex">
        <div className="flex-shrink-0">
          <Icon className={clsx(colors.icon, 'h-5 w-5')} aria-hidden="true" />
        </div>
        <div className="ml-3">
          <h3 className={clsx(colors.headerText, 'text-sm font-medium')}>{title}</h3>
          {!!children && <div className={clsx(colors.bodyText, 'mt-2 text-sm')}>{children}</div>}
        </div>
      </div>
    </div>
  )
}
