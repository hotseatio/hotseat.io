import * as React from 'react'
import { InformationCircleIcon } from '@heroicons/react/24/outline'

export function DetailsButton({ link }: { link: string }): JSX.Element {
  return (
    <a title="Details" href={link} className="button-secondary">
      <InformationCircleIcon className="h-5 w-5" />
    </a>
  )
}

export function RegistrarButton({ link }: { link: string }): JSX.Element {
  return (
    <a title="UCLA Registrar" href={link} rel="noopener noreferrer" target="_blank" className="button-secondary">
      <InformationCircleIcon className="h-5 w-5" />
    </a>
  )
}

type ReviewButtonProps = {
  sectionId: number
}

export function ReviewButton({ sectionId }: ReviewButtonProps): JSX.Element {
  return (
    <a href={`/reviews/new?section=${sectionId}`} className="button-primary">
      Review
    </a>
  )
}
