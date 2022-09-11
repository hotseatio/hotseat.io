import * as React from 'react'
import * as colors from 'tailwindcss/colors'

type Props = React.SVGProps<SVGLinearGradientElement> & {
  id: string
  colors: string[]
}

/**
 * A SVG linear gradient. Requires a unique ID and an array of color values.
 */
export default function Gradient({ id, colors, ...props }: Props): JSX.Element {
  return (
    <linearGradient id={id} gradientUnits="userSpaceOnUse" spreadMethod="pad" {...props}>
      {colors.map((color, i) => (
        <stop key={i} offset={`${(i * 100) / (colors.length - 1)}%`} stopColor={color} />
      ))}
    </linearGradient>
  )
}

export const redGradientId = 'hotseat-red-gradient'

/**
 * A red gradient.
 */
export function RedGradient(): JSX.Element {
  return <Gradient id={redGradientId} colors={[colors.red['600'], colors.red['100']]} x2="0" y2="100%" />
}
