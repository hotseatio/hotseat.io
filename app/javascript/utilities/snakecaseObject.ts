import { snakeCase } from 'lodash-es'

type Arg = {
  [key: string]: string | boolean | number
}

type ReturnValue = {}

type CamelToSnakeCase<S extends string> = S extends `${infer T}${infer U}`
  ? `${T extends Capitalize<T> ? '_' : ''}${Lowercase<T>}${CamelToSnakeCase<U>}`
  : S

export default function snakecaseObject(body: Body) {
  return Object.fromEntries(Object.entries(body).map(([key, value]) => [snakeCase(key), value]))
}
