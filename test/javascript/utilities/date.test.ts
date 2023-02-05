import {earliest, latest} from 'utilities/date'

describe('earliest', () => {
  it('returns the earliest date', () => {
    const a = new Date('2020-12-22T08:00:00Z')
    const a2 = new Date(a.getTime())
    const b = new Date('2020-12-23T08:00:00Z')
    expect(earliest(a, b, a2)).toBe(a)
    expect(earliest(a2, b, a)).toBe(a2)
    expect(earliest(b)).toBe(b)
  })
})

describe('latest works', () => {
  it('returns the latest date', () => {
    const a = new Date('2020-12-22T08:00:00Z')
    const a2 = new Date(a.getTime())
    const b = new Date('2020-12-23T08:00:00Z')
    const b2 = new Date(b.getTime())
    expect(latest(a, b, a2, b2)).toBe(b)
    expect(latest(b2, a, b)).toBe(b2)
    expect(latest(a)).toBe(a)
  })
})
