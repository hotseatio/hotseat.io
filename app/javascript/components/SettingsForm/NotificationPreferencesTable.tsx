import * as React from 'react'

export interface NotificationPreference {
  id: string
  email: boolean | null
  sms: boolean | null
  push: boolean | null
}

export interface NotificationPreferences {
  announcements: NotificationPreference
  enrollmentNotifications: NotificationPreference
}

const labels = {
  announcements: {
    title: 'Hotseat News',
    description: 'Get the latest on new features.',
  },
  enrollmentNotifications: {
    title: 'Enrollment updates',
    description: 'Get notified about changes in subscribed classes.',
  },
}

interface NotificationPreferenceCheckboxProps {
  // Hides the checkbox if null
  checked: boolean | null
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void
}

function NotificationPreferenceCheckbox({checked, onChange}: NotificationPreferenceCheckboxProps) {
  return (
    <td className="whitespace-nowrap px-3 py-4 text-sm text-gray-500 dark:text-gray-400">
      {checked !== null && (
        <div className="flex items-center justify-center">
          <input
            type="checkbox"
            className="h-4 w-4 rounded border-gray-300 dark:border-gray-600 dark:bg-gray-800 text-red-600 focus:ring-red-600"
            checked={checked}
            onChange={onChange}
          />
        </div>
      )}
    </td>
  )
}

interface Props {
  preferences: NotificationPreferences
  onPreferenceChange: (id: string, notificationType: string, value: boolean) => void
}

export default function NotificationPreferencesTable({preferences, onPreferenceChange}: Props) {
  console.log('preferences: ', preferences)
  return (
    <div>
      <div className="mt-8">
        <div className="overflow-x-auto">
          <table className="min-w-full divide-y divide-gray-300">
            <thead>
              <tr>
                <th
                  scope="col"
                  className="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 dark:text-gray-50 sm:pl-0"
                >
                  Notification Preferences
                </th>
                <th
                  scope="col"
                  className="px-3 py-3.5 text-center text-sm font-medium text-gray-500 dark:text-gray-400"
                >
                  Push Alerts
                </th>
                <th
                  scope="col"
                  className="px-3 py-3.5 text-center text-sm font-medium text-gray-500 dark:text-gray-400"
                >
                  SMS
                </th>
                <th
                  scope="col"
                  className="px-3 py-3.5 text-center text-sm font-medium text-gray-500 dark:text-gray-400"
                >
                  Email
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200">
              {[preferences.announcements, preferences.enrollmentNotifications].map((preference, i) => (
                <tr key={preference.id}>
                  <td className="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 dark:text-gray-50 sm:pl-0">
                    <div className="font-medium text-gray-900 dark:text-gray-50">{labels[preference.id].title}</div>
                    <div className="font-light text-gray-500 dark:text-gray-400">
                      {labels[preference.id].description}
                    </div>
                  </td>
                  <NotificationPreferenceCheckbox
                    checked={preference.push}
                    onChange={(e) => onPreferenceChange(preference.id, 'push', e.target.checked)}
                  />
                  <NotificationPreferenceCheckbox
                    checked={preference.sms}
                    onChange={(e) => onPreferenceChange(preference.id, 'sms', e.target.checked)}
                  />
                  <NotificationPreferenceCheckbox
                    checked={preference.email}
                    onChange={(e) => onPreferenceChange(preference.id, 'email', e.target.checked)}
                  />
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  )
}
