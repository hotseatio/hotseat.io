'use strict'

const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/views/**/*.turbostream.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/javascript/**/*.tsx',
    './app/javascript/**/*.ts',
    './config/initializers/simple_form_tailwind.rb',
  ],
  theme: {
    extend: {
      borderColor: (theme) => ({
        DEFAULT: theme('colors.red.200', 'currentColor'),
      }),
      colors: {
        gray: colors.neutral,
      },
      fill: {
        none: 'none',
        black: colors.black,
        white: colors.white,
        gray: colors.neutral,
        red: colors.red,
        yellow: colors.amber,
        green: colors.emerald,
        blue: colors.blue,
        indigo: colors.indigo,
        purple: colors.violet,
        pink: colors.pink,
      },
      ringColor: (theme) => ({
        DEFAULT: theme('colors.red.500'),
      }),
      stroke: {
        current: 'currentColor',
        black: colors.black,
        white: colors.white,
        gray: colors.neutral,
        red: colors.red,
        yellow: colors.amber,
        green: colors.emerald,
        blue: colors.blue,
        indigo: colors.indigo,
        purple: colors.violet,
        pink: colors.pink,
      },
      strokeWidth: {
        1.5: '1.5',
      },
    },
  },
  plugins: [require('@tailwindcss/forms'), require('@tailwindcss/typography')],
}
