import * as React from 'react'
import {useState} from 'react'
import {sortBy} from 'lodash-es'

import RequestButton from 'components/RequestButton'
import {subscribeToPush} from 'utilities/webpushNotifications'
import type {Device} from 'utilities/webpushNotifications'

type Props = {
  devices: Device[]
}

function capitalizeFirstLetter(str: string): string {
  return str.charAt(0).toUpperCase() + str.slice(1)
}

function formatDeviceName(device: Device): string {
  return device.name ?? `${capitalizeFirstLetter(device.browser)} (${device.os})`
}

export default function DevicesTable({devices: initialDevices}: Props) {
  const [devices, setDevices] = useState(initialDevices)

  const addDevice = async () => {
    const newDevice = await subscribeToPush()
    if (devices.some((device) => device.id === newDevice.id)) {
      window.alert('Device is already added!')
    } else {
      setDevices(sortBy([...devices, newDevice], 'id'))
    }
  }
  const removeDevice = (id: number) => {
    setDevices(
      devices.filter((device: Device) => {
        device.id !== id
      })
    )
  }

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
            onClick={addDevice}
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
                      <RequestButton
                        method="DELETE"
                        resource={`/webpush_devices/${device.id}`}
                        className="text-red-600 hover:text-red-900"
                        onClick={() => removeDevice(device.id)}
                      >
                        Remove<span className="sr-only">, {formatDeviceName(device)}</span>
                      </RequestButton>
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
