/**
 * @jest-environment jsdom
 */

import * as React from 'react'
import {render} from '@testing-library/react'

import EnrollmentChart, {EnrollmentDatumJSON} from 'components/EnrollmentCard/EnrollmentChart'
import {add, HOUR} from 'utilities/date'

test('loads lectures', async () => {
  const baseTime = new Date('2020-12-22T08:00:00Z')
  const enrollmentData: EnrollmentDatumJSON[] = [
    {
      enrollmentCount: 2,
      enrollmentCapacity: 200,
      enrollmentStatus: 'Open',
      waitlistCount: 0,
      waitlistCapacity: 0,
      waitlistStatus: 'None',
      createdAt: baseTime.toJSON(),
      updatedAt: baseTime.toJSON(),
    },
    {
      enrollmentCount: 3,
      enrollmentCapacity: 200,
      enrollmentStatus: 'Open',
      waitlistCount: 0,
      waitlistCapacity: 0,
      waitlistStatus: 'None',
      createdAt: add(baseTime, HOUR).toJSON(),
      updatedAt: add(baseTime, HOUR).toJSON(),
    },
    {
      enrollmentCount: 4,
      enrollmentCapacity: 200,
      enrollmentStatus: 'Open',
      waitlistCount: 0,
      waitlistCapacity: 0,
      waitlistStatus: 'None',
      createdAt: add(baseTime, 3 * HOUR).toJSON(),
      updatedAt: add(baseTime, 3 * HOUR).toJSON(),
    },
  ]

  render(
    <EnrollmentChart
      isLive={false}
      markers={[]}
      enrollmentStart="2020-12-22T08:00:00Z"
      enrollmentEnd="2020-12-31T08:00:00Z"
      sectionLabels={['LEC 1']}
      sectionData={[enrollmentData]}
    />
  )
  expect(true).toBe(true)
})
