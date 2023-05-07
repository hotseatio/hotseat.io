import '@hotwired/turbo-rails'
import * as React from 'react'
import {createRoot} from 'react-dom/client'
import ahoy from 'ahoy.js'

import Search from 'components/Search'
import EnrollmentCard from 'components/EnrollmentCard'
import GradeCard from 'components/GradeCard'
import ReviewForm from 'components/ReviewForm'
import SettingsForm from 'components/SettingsForm'
import FilterButton from 'components/FilterButton'
import {SectionListCard, CurrentCoursesListCard, PreviousCoursesListCard} from 'components/ListCard'
import {registerServiceWorker} from 'utilities/webpushNotifications'

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

  // Service worker
  registerServiceWorker()
})

// Ahoy
ahoy.configure({
  visitsUrl: '/hotcount/visits',
  eventsUrl: '/hotcount/events',
})
ahoy.trackView()
ahoy.trackClicks('a, button, input[type=submit]')
ahoy.trackSubmits('form')
