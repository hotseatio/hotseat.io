export type OtherHeaders = { [id: string]: string }
export type AuthenticityHeaders = OtherHeaders & {
  'X-CSRF-Token': string | null
  'X-Requested-With': string
}

export function authenticityToken(): string | null {
  return document.querySelector('[name="csrf-token"]')?.getAttribute('content')
}

export function authenticityHeaders(otherHeaders: OtherHeaders = {}): AuthenticityHeaders {
  return Object.assign(otherHeaders, {
    'X-CSRF-Token': authenticityToken(),
    'X-Requested-With': 'XMLHttpRequest',
  })
}
