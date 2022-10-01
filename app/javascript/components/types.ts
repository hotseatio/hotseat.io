export type Term = {
  term: string
  readable: string
}

export type SubjectArea = {
  id: number
  name: string
  code: string
  linkUrl: string
}

export type Course = {
  id: number
  title: string
  number: string
  subjectAreaCode: string
}

export type Instructor = {
  id: number
  fullLabel: string
  linkUrl: string
}

export type Section = {
  id: number
  days: string[]
  times: string[]
  locations: string[]
  units: string
  index: number | undefined
  term: Term
  instructor: Instructor
  registrarInstructors: string[]
}

export type Pagination = {
  current: number
  total: number
}

export type Paginated<T> = {
  page: Pagination | undefined
  results: T[]
}
