import * as React from 'react'

import {subscribeToPush} from 'utilities/webpushNotifications'

export type Device = {
  id: number
  name: string | null
  browser: string
  os: string
}

type Props = {
  devices: Device[]
}

function capitalizeFirstLetter(str: string): string {
  return str.charAt(0).toUpperCase() + str.slice(1)
}

function formatDeviceName(device: Device): string {
  return device.name ?? `${capitalizeFirstLetter(device.browser)} (${device.os})`
}

export default function DevicesTable({devices}: Props) {
  return (
    <div>
      <div className="sm:flex sm:items-center mt-12">
        <div className="sm:flex-auto">
          <h1 className="text-base font-semibold leading-6 text-gray-900">Devices</h1>
          <p className="mt-2 text-sm text-gray-700">Your devices that will receive notifications from Hotseat.</p>
        </div>
        <div className="mt-4 sm:ml-16 sm:mt-0 sm:flex-none">
          <button
            type="button"
            className="block rounded-md bg-red-600 px-3 py-2 text-center text-sm font-semibold text-white shadow-sm hover:bg-red-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600"
            onClick={subscribeToPush}
          >
            Add current device
          </button>
        </div>
      </div>
      <div className="mt-2 flow-root">
        <div className="-mx-4 -my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
          <div className="inline-block min-w-full py-2 align-middle sm:px-6 lg:px-8">
            <table className="min-w-full divide-y divide-gray-300">
              <thead>
                <tr>
                  <th scope="col" className="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">
                    Client
                  </th>
                  <th scope="col" className="py-3.5">
                    <span className="sr-only">Remove</span>
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200">
                {devices.map((device) => (
                  <tr key={device.id}>
                    <td className="px-3 py-4 text-sm text-gray-500">{formatDeviceName(device)}</td>
                    <td className="py-4 text-right text-sm font-medium sm:pr-0">
                      <a href="#" className="text-red-600 hover:text-red-900">
                        Remove<span className="sr-only">, {formatDeviceName(device)}</span>
                      </a>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  )
}
