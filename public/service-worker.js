function getLinkForAction(actions, actionTitle) {
  return actions.find((action) => action.title === actionTitle).action
}

self.addEventListener('install', (event) => {
  console.log('Service worker installed.')
})

self.addEventListener('activate', (event) => {
  console.log('Service worker activated.')
})

self.addEventListener('push', (event) => {
  console.log('Push message received')
  const pushMessage = event.data.json()

  const enrollLink = getLinkForAction(pushMessage.actions, 'Enroll')
  const unsubscribeLink = getLinkForAction(pushMessage.actions, 'Unsubscribe')
  const manageLink = getLinkForAction(pushMessage.actions, 'Manage')

  event.waitUntil(
    self.registration.showNotification(pushMessage.title, {
      body: pushMessage.body,
      tag: pushMessage.tag,
      actions: pushMessage.actions,
      data: {
        status: pushMessage.status,
        enrollLink,
        unsubscribeLink,
        manageLink,
      },
      icon: '/images/icons-192.png',
    })
  )
})

self.addEventListener('notificationclick', async (event) => {
  console.log('Notification clicked')
  if (event.action) {
    console.log('Opening event action: ', event)
    self.clients.openWindow(event.action)
  } else {
    const notification = event.notification
    const {status, enrollLink, manageLink} = notification.data
    if (status === 'Open' || status === 'Waitlist') {
      console.log(`Defaulting to opening enrollment link: ${enrollLink}`)
      self.clients.openWindow(enrollLink)
    } else {
      console.log(`Defaulting to opening manage link: ${manageLink}`)
      self.clients.openWindow(manageLink)
    }
  }
})
