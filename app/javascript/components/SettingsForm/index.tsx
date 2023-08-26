import * as React from 'react'
import {useState} from 'react'
import {Switch} from '@headlessui/react'
import {clsx} from 'clsx'
import {FireIcon} from '@heroicons/react/24/outline'

import CopyToClipboardInput from './CopyToClipboardInput'
import PhoneInput from './PhoneInput'
import DevicesTable from './DevicesTable'
import NotificationPreferencesTable from './NotificationPreferencesTable'
import type {NotificationPreferences} from './NotificationPreferencesTable'

import LoadingCircle from 'components/icons/LoadingCircle'
import Alert from 'components/Alert'
import type {AlertType} from 'components/Alert'
import snakecaseObject from 'utilities/snakecaseObject'
import {authenticityHeaders} from 'utilities/authenticityHeaders'
import type {Device} from 'utilities/webpushNotifications'

type Props = {
  updateUrl: string
  name: string
  email: string
  phoneNumber: string | undefined
  betaTester: boolean
  referralLink: string
  devices: Device[]
  notificationPreferences: NotificationPreferences
}

type Response = {
  type: AlertType
  title: string
  msg?: string
}

export default function SettingsForm({updateUrl, phoneNumber, devices, ...props}: Props): JSX.Element {
  const [response, setResponse] = useState<Response | null>(null)

  const [isSubmitting, setIsSubmitting] = useState(false)
  const [betaTester, setBetaTester] = useState(props.betaTester)
  const [notificationPreferences, setNotificationPreferences] = useState(props.notificationPreferences)
  const onPreferenceChange = (id: string, notificationType: string, value: boolean) => {
    const newPreferences = {...notificationPreferences}
    newPreferences[id][notificationType] = value
    setNotificationPreferences(newPreferences)
  }

  const onSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()
    setIsSubmitting(true)
    const body = {beta_tester: betaTester, notification_preferences: snakecaseObject(notificationPreferences)}
    const response = await fetch(updateUrl, {
      method: 'PUT',
      headers: authenticityHeaders({'Content-Type': 'application/json'}),
      body: JSON.stringify(body),
    })

    const responseBody = await response.json()
    if (response.status !== 200) {
      setResponse({type: 'error', title: responseBody.title, msg: responseBody.msg})
    } else {
      setResponse({type: 'success', title: responseBody.title, msg: responseBody.msg})
    }

    setIsSubmitting(false)
  }

  return (
    <div className="pt-8 sm:px-6 lg:px-8">
      <div className="sm:mx-auto sm:w-full sm:max-w-md">
        <FireIcon className="mx-auto h-16 w-auto" aria-hidden="true" />
        <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900 dark:text-gray-50">Settings</h2>
      </div>

      <div className="mt-8 sm:mx-auto sm:w-full sm:max-w-2xl">
        <div className="bg-white dark:bg-gray-900 py-8 px-4 shadow sm:rounded-lg sm:px-10">
          <form acceptCharset="UTF-8" onSubmit={onSubmit} className="space-y-6">
            <div>
              <label className="input-label" htmlFor="user_name">
                Name
              </label>
              <input
                className="text-field"
                disabled={true}
                type="text"
                value={props.name}
                name="user[name]"
                id="user_name"
              />
              <p className="mt-0.5 text-xs text-gray-500 dark:text-gray-400">
                You can change your name via your{' '}
                <a
                  href="https://myaccount.google.com/personal-info"
                  className="underline focus:outline-none focus:ring-2 focus:ring-inset focus:ring-red-500"
                >
                  UCLA Google Account
                </a>
                .
              </p>
            </div>

            <div>
              <label className="input-label" htmlFor="user_email">
                UCLA Email
              </label>
              <input
                className="text-field"
                disabled={true}
                type="email"
                value={props.email}
                name="user[email]"
                id="user_email"
              />
            </div>

            <PhoneInput initialPhoneNumber={phoneNumber ?? null} />

            <div>
              <label className="input-label" htmlFor="referral_input">
                Referrals
              </label>
              <p className="text-xs text-gray-500 dark:text-gray-400">
                {
                  "Referred users earn two notification tokens for the first review they write. You'll receive a bonus notification token as well!"
                }
              </p>

              <CopyToClipboardInput value={props.referralLink} name="referral_input" id="referral_input" />
            </div>

            <NotificationPreferencesTable
              preferences={notificationPreferences}
              onPreferenceChange={onPreferenceChange}
            />
            <DevicesTable devices={devices} />

            <Switch.Group as="div" className="flex items-center justify-between" id="beta_tester">
              <Switch.Label<'span'> as="span" className="flex-grow flex flex-col" passive>
                <span className="input-label">Beta Test New Features</span>
                <span className="text-sm text-gray-500 mr-4">
                  As a tester, you will receive access to features that may be unstable. We may occaisionally reach out
                  to you for feedback on these features. You can opt out at any time by disabling this toggle.
                </span>
              </Switch.Label>
              <Switch
                checked={betaTester}
                onChange={setBetaTester}
                className={clsx(
                  betaTester ? 'bg-red-600' : 'bg-gray-200',
                  'relative inline-flex flex-shrink-0 h-6 w-11 border-2 border-transparent rounded-full cursor-pointer transition-colors ease-in-out duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500'
                )}
              >
                <span className="sr-only">Become a beta tester</span>
                <span
                  aria-hidden="true"
                  className={clsx(
                    betaTester ? 'translate-x-5' : 'translate-x-0',
                    'pointer-events-none inline-block h-5 w-5 rounded-full bg-white shadow transform ring-0 transition ease-in-out duration-200'
                  )}
                />
              </Switch>
            </Switch.Group>

            {response !== null && (
              <Alert type={response.type} title={response.title}>
                {response.msg && <p>{response.msg}</p>}
              </Alert>
            )}

            <button
              type="submit"
              name="button"
              className="mt-4 submit-button disabled:opacity-50 flex items-center justify-center"
              disabled={isSubmitting}
            >
              <span>Update account</span>
              {isSubmitting && <LoadingCircle className="ml-2 h-5 w-5" />}
            </button>
          </form>
        </div>
      </div>
    </div>
  )
}
