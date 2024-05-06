import * as React from 'react'
import {useMemo, useState} from 'react'
import type {ReactNode} from 'react'
import {clsx} from 'clsx'

import Select from 'components/Select'
import type {SelectItem} from 'components/Select'

type Props = {
  id: string
  title: string
  children: ReactNode
  rightContent?: ReactNode
}

/**
 * A display card. The React equivalent of shared/_card.html.erb.
 */
export function Card({id, children, title, rightContent}: Props): JSX.Element {
  if (Array.isArray(rightContent)) {
    rightContent = React.Children.map(rightContent, (item, i) => (
      <div className={clsx(i === 0 && 'ml-auto', 'flex-shrink-0')} role="presentation">
        {item}
      </div>
    ))
  } else {
    if (typeof rightContent === 'string' || typeof rightContent === 'number') {
      rightContent = <p className="text-sm text-gray-500 dark:text-gray-400">{rightContent}</p>
    }
    rightContent = (
      <div className="ml-auto flex-shrink-0" role="presentation">
        {rightContent}
      </div>
    )
  }

  const titleID = id + '-title'

  return (
    <section id={id} aria-labelledby={titleID} className="bg-white dark:bg-gray-900 shadow rounded-lg my-4">
      <header className="px-4 py-5 border-b border-gray-200 dark:border-gray-700 sm:px-6 flex items-center justify-between flex-wrap sm:flex-nowrap gap-2">
        <h3 id={titleID}>{title}</h3>
        {rightContent}
      </header>
      {children}
    </section>
  )
}

type TermSelectCardProps = {
  id: string
  title: string
  children: React.ReactNode
  terms: string[]
  onTermSelect: (termIndex: number) => void
}

/**
 * A display card with a selectable term.
 */
export function TermSelectCard({id, title, children, onTermSelect, terms}: TermSelectCardProps): JSX.Element {
  const [selectedTermIndex, setSelectedTermIndex] = useState(0)
  const termItems = useMemo(() => terms.map((term) => ({id: term, label: term})), [terms])

  const onSelect = (_selected: SelectItem, i: number) => {
    setSelectedTermIndex(i)
    onTermSelect(i)
  }

  const SelectNode = (
    <Select
      label="Select a term:"
      labelInvisible
      className="w-24"
      onSelect={onSelect}
      items={termItems}
      value={selectedTermIndex}
    />
  )

  return (
    <Card id={id} title={title} rightContent={SelectNode}>
      {children}
    </Card>
  )
}

type TableCardProps = {
  id: string
  title: string
  children: ReactNode
  rightContent?: ReactNode
  tableHeader?: ReactNode
}

export function TableCard({id, children, title, rightContent, tableHeader}: TableCardProps): JSX.Element {
  if (Array.isArray(rightContent)) {
    rightContent = React.Children.map(rightContent, (item, i) => (
      <div className={clsx(i === 0 && 'ml-auto', 'flex-shrink-0')} role="presentation">
        {item}
      </div>
    ))
  } else {
    if (typeof rightContent === 'string' || typeof rightContent === 'number') {
      rightContent = <p className="text-sm text-gray-500 dark:text-gray-400">{rightContent}</p>
    }
    rightContent = (
      <div className="ml-auto flex-shrink-0" role="presentation">
        {rightContent}
      </div>
    )
  }

  const titleID = id + '-title'

  return (
    <section id={id} aria-labelledby={titleID} className="bg-white dark:bg-gray-900 shadow rounded-lg my-4">
      <header className="px-4 py-5 border-b border-gray-200 dark:border-gray-700 sm:px-6">
        <div className="grid grid-rows-2 gap-4">
          <div>
            <h3 id={titleID} className="text-base font-medium text-gray-700 dark:text-gray-200">
              {title}
            </h3>
            {rightContent}
          </div>
          <div>{tableHeader}</div>
        </div>
      </header>
      {children}
    </section>
  )
}
