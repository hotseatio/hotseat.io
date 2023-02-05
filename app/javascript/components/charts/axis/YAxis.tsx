import * as React from 'react'
import {ScaleLinear} from 'd3-scale'

import {useChartDimensions} from 'components/charts/Chart'

type Props = {
  scale: ScaleLinear<number, number, never>
  formatTick: (tick: number) => string
  label?: string
}

/**
 * A vertical axis.
 */
export default function YAxis({scale, label, formatTick}: Props): JSX.Element {
  const dimensions = useChartDimensions()

  const numberOfTicks = dimensions.boundedHeight / 70
  const ticks = scale.ticks(numberOfTicks)

  return (
    <g>
      <line className="stroke-gray-700 dark:stroke-gray-200 stroke-1" y2={dimensions.boundedHeight} />

      {ticks.map((tick) => (
        <g key={tick} transform={`translate(-4, ${scale(tick)})`}>
          <text
            className="fill-gray-800 dark:fill-gray-100 text-xs"
            style={{
              textAnchor: 'end',
            }}
          >
            {formatTick(tick)}
          </text>
        </g>
      ))}

      {label && (
        <text
          style={{
            transform: `translate(-56px, ${dimensions.boundedHeight / 2}px) rotate(-90deg)`,
          }}
        >
          {label}
        </text>
      )}
    </g>
  )
}
