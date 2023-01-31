import * as React from 'react'
import {Fragment, useState} from 'react'
import {Dialog, Transition} from '@headlessui/react'
import {
  ArchiveBoxIcon,
  Bars3BottomLeftIcon,
  Bars4Icon,
  ClockIcon,
  HomeIcon,
  UserCircleIcon as UserCircleIconOutline,
  XMarkIcon,
  MapPinIcon,
} from '@heroicons/react/24/outline'
import {
  BellIcon,
  CalendarIcon,
  ChatBubbleLeftEllipsisIcon,
  CheckCircleIcon,
  LockOpenIcon,
  MagnifyingGlassIcon,
  PencilIcon,
  TagIcon,
  UserCircleIcon as UserCircleIconMini,
} from '@heroicons/react/20/solid'

export default function DrawerHeader() {
  return (
    <aside className="mb-6">
      <h2 className="sr-only">Details</h2>
      <div className="flex flex-col">
        <div className="flex items-center space-x-2">
          <MapPinIcon className="h-5 w-5 text-gray-500" aria-hidden="true" />
          <span className="text-sm font-medium text-gray-900">Entrepreneurs Hall C124</span>
        </div>
        <div className="flex items-center space-x-2">
          <ClockIcon className="h-5 w-5 text-gray-400" aria-hidden="true" />
          <span className="text-sm font-medium text-gray-900">TR 12-1:15</span>
        </div>
        <div className="flex items-center space-x-2">
          <CalendarIcon className="h-5 w-5 text-gray-400" aria-hidden="true" />
          <span className="text-sm font-medium text-gray-900">
            Created on <time dateTime="2020-12-02">Dec 2, 2020</time>
          </span>
        </div>
      </div>
    </aside>
  )
}
