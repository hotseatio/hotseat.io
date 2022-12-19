import * as React from 'react'
import { useState } from 'react'
import { ClipboardIcon } from '@heroicons/react/20/solid'

type Props = {
  value: string
  name: string
  id: string
}

export default function CopyToClipboardInput({ value, name, id }: Props) {
  const [wasRecentlyCopied, setWasRecentlyCopied] = useState(false)

  const onClick = () => {
    navigator.clipboard.writeText(value)
    setWasRecentlyCopied(true)
    setTimeout(() => setWasRecentlyCopied(false), 2000)
  }

  return (
    <div className="mt-1 flex rounded-md shadow-sm">
      <input
        className="base-input block w-full rounded-none rounded-l-md"
        disabled={true}
        type="text"
        value={value}
        name={name}
        id={id}
      />
      <button type="button" className="inline-button rounded-r-md" onClick={onClick}>
        <span>{wasRecentlyCopied ? 'Copied!' : 'Copy'}</span>
        <ClipboardIcon className="h-5 w-5 text-gray-400" aria-hidden="true" />
      </button>
    </div>
  )
}
