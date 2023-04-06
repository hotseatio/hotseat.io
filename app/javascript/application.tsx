import '@hotwired/turbo-rails'
import * as React from 'react'
import {createRoot} from 'react-dom/client'
import ahoy from 'ahoy.js'

// React components
import Search from 'components/Search'
import EnrollmentCard from 'components/EnrollmentCard'
import GradeCard from 'components/GradeCard'
import ReviewForm from 'components/ReviewForm'
import SettingsForm from 'components/SettingsForm'
import FilterButton from 'components/FilterButton'
import {SectionListCard, CurrentCoursesListCard, PreviousCoursesListCard} from 'components/ListCard'

const components = {
  Search,
  EnrollmentCard,
  GradeCard,
  ReviewForm,
  SettingsForm,
  FilterButton,
  SectionListCard,
  CurrentCoursesListCard,
  PreviousCoursesListCard,
}

document.addEventListener('turbo:load', () => {
  for (const [name, Component] of Object.entries(components)) {
    if (document.getElementById(name)) {
      const container = document.getElementById(name)
      const root = createRoot(container)

      const rawProps = container.getAttribute('data-react-props')
      const props = JSON.parse(rawProps)
      root.render(<Component {...props} />)
    }
  }
})

// Ahoy
ahoy.configure({
  visitsUrl: '/hotcount/visits',
  eventsUrl: '/hotcount/events',
})
ahoy.trackView()
ahoy.trackClicks('a, button, input[type=submit]')
ahoy.trackSubmits('form')

// Register service worker for notifications
navigator.serviceWorker.register('/service-worker.js')
navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
  serviceWorkerRegistration.pushManager.subscribe({
    userVisibleOnly: true,
    applicationServerKey: window.vapidPublicKey,
  })
})
