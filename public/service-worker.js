console.log('hi from the service worker')

self.addEventListener('push', (event) => {
  const pushMessage = event.data.json()

  event.waitUntil(
    self.registration.showNotification(pushMessage.title, {
      body: pushMessage.body,
      tag: pushMessage.tag,
      actions: pushMessage.actions,
      data: { status: pushMessage.status },
    })
  )
})

self.addEventListener('notificationclick', async function(event) {
  if (event.action) {
    self.clients.openWindow(event.action)
  } else {
    console.log('event: ', event)
  }
})
