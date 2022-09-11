import * as Turbo from '@hotwired/turbo'

declare global {
  interface Window {
    Turbo: Turbo
  }
}
