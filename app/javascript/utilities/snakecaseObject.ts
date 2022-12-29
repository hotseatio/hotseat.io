import { snakeCase } from 'lodash-es'
import type { SnakeCasedProperties } from 'type-fest'

export default function snakecaseObject<T extends object>(obj: T): SnakeCasedProperties<T> {
  // @ts-expect-error: TODO figure out this error
  return Object.fromEntries(Object.entries(obj).map(([key, value]) => [snakeCase(key), value]))
}
