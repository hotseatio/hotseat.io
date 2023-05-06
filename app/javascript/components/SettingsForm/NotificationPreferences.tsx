import * as React from 'react'

const settings = [
  {
    title: 'Hotseat News',
    description: 'Get updates about new features.',
    email: true,
    sms: null,
    push: false,
  },
  {
    title: 'Enrollment updates',
    description: 'Get notified about changes in subscribed classes.',
    email: null,
    sms: true,
    push: true,
  },
]

export default function NotificationPreferences() {
  return (
    <div>
      <div className="mt-8">
        <div className="overflow-x-auto">
          <table className="min-w-full divide-y divide-gray-300">
            <thead>
              <tr>
                <th scope="col" className="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-0">
                  Notification Preferences
                </th>
                <th scope="col" className="px-3 py-3.5 text-center text-sm font-medium text-gray-500">
                  Web Push
                </th>
                <th scope="col" className="px-3 py-3.5 text-center text-sm font-medium text-gray-500">
                  SMS
                </th>
                <th scope="col" className="px-3 py-3.5 text-center text-sm font-medium text-gray-500">
                  Email
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200">
              {settings.map((setting) => (
                <tr key={setting.title}>
                  <td className="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-0">
                    <div className="font-medium text-gray-900">{setting.title}</div>
                    <div className="font-light text-gray-500">{setting.description}</div>
                  </td>
                  <td className="px-3 py-4 text-sm text-gray-500">
                    <div className="flex items-center justify-center">
                      <input
                        type="checkbox"
                        className="h-4 w-4 rounded border-gray-300 text-red-600 focus:ring-red-600"
                      />
                    </div>
                  </td>
                  <td className="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                    <div className="flex items-center justify-center">
                      <input
                        type="checkbox"
                        className="h-4 w-4 rounded border-gray-300 text-red-600 focus:ring-red-600"
                      />
                    </div>
                  </td>
                  <td className="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                    <div className="flex items-center justify-center">
                      <input
                        type="checkbox"
                        className="h-4 w-4 rounded border-gray-300 text-red-600 focus:ring-red-600"
                      />
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  )
}
