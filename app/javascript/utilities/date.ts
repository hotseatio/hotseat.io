// Duration constants. Unit duration is 1 ms, consistent with most JavaScript
// APIs. Inspired by Go: https://golang.org/pkg/time/#Nanosecond
export const MILLISECOND = 1
export const SECOND = 1000 * MILLISECOND
export const MINUTE = 60 * SECOND
export const HOUR = 60 * MINUTE

// Returns the Date d+delta.
export function add(d: Date, delta: number): Date {
  return new Date(d.getTime() + delta)
}

// Returns the duration d-c for Dates d and c in milliseconds. For d-dur for
// duration dur, use add(d, -dur).
export function sub(d: Date, c: Date): number {
  return d.getTime() - c.getTime()
}

// In case of ties, returns the first date provided.
export function earliest(date: Date, ...dates: Date[]): Date {
  for (const d of dates) {
    if (d.getTime() < date.getTime()) {
      date = d
    }
  }
  return date
}

// In case of ties, returns the first date provided.
export function latest(date: Date, ...dates: Date[]): Date {
  for (const d of dates) {
    if (d.getTime() > date.getTime()) {
      date = d
    }
  }
  return date
}
