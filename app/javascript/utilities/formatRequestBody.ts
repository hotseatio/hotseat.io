import { snakeCase } from 'lodash-es'

interface Body {
  [key: string]: any
}

export function formatRequestBody(body: Body) {
  return Object.fromEntries(Object.entries(body).map(([key, value]) => [snakeCase(key), value]))
}
