import {detect} from 'detect-browser'

import {authenticityHeaders} from 'utilities/authenticityHeaders'

export type Device = {
  id: number
  name: string | null
  browser: string
  os: string
}

export async function registerServiceWorker() {
  if ('serviceWorker' in navigator) {
    const registration = await navigator.serviceWorker.getRegistration()
    if (!registration) {
      await navigator.serviceWorker.register('/service-worker.js')
    }
  }
}

export async function subscribeToPush(): Promise<Device> {
  const registration = await navigator.serviceWorker.getRegistration()
  const subscription = await registration.pushManager.subscribe({
    userVisibleOnly: true,
    applicationServerKey: window.vapidPublicKey,
  })

  return sendSubscriptionToServer(subscription)
}

async function sendSubscriptionToServer(subscription: PushSubscription): Promise<Device> {
  const browserInfo = detect()
  if (browserInfo.type !== 'browser') {
    throw new Error('Unsupported browser')
  }

  const {auth, p256dh} = getSubscriptionKeyAndAuth(subscription)

  const body = {
    browser: browserInfo.name,
    os: browserInfo.os,
    endpoint: subscription.endpoint,
    auth,
    p256dh,
  }

  const response = await fetch('/webpush_devices', {
    method: 'POST',
    headers: authenticityHeaders({'Content-Type': 'application/json'}),
    body: JSON.stringify(body),
  })
  const device: Device = await response.json()
  return device
}

function getSubscriptionKeyAndAuth(subscription: PushSubscription) {
  const jsonSubscription = subscription.toJSON()
  return {
    p256dh: jsonSubscription.keys.p256dh,
    auth: jsonSubscription.keys.auth,
  }
}
