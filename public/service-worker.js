console.log('hi from the service worker')

self.addEventListener('push', (event) => {
  console.log('event: ', event)
  // Get the push message
  var message = event.data
  // Display a notification
  event.waitUntil(self.registration.showNotification('Example'))
})
