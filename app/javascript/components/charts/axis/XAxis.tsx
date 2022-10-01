import * as React from 'react'
import { useChartDimensions } from '../Chart'
import { ScaleTime, ScaleBand } from 'd3-scale'
import { timeDay } from 'd3-time'

interface CommonProps {
  label?: string
  showTickMarks?: boolean
}

interface TimeProps extends CommonProps {
  scale: ScaleTime<number, number, number>
  formatTick: (tick: Date) => string
}

interface BandProps extends CommonProps {
  scale: ScaleBand<string>
  formatTick: (tick: string) => string
}

/**
 * A horizontal axis.
 */
export default function XAxis(props: TimeProps | BandProps): JSX.Element {
  const { showTickMarks = false, label } = props
  let ticks: JSX.Element
  const dimensions = useChartDimensions()

  if (isBandProps(props)) {
    const { scale, formatTick } = props
    const tickValues = scale.domain()
    const getX = (value: string) => {
      const x = props.scale(value)
      if (x === undefined) throw new Error('')
      return x + scale.bandwidth() / 2
    }
    ticks = createTicksLabels<string>(tickValues, getX, formatTick, showTickMarks)
  } else {
    const { scale, formatTick } = props
    const timeInterval = timeDay.every(3)
    const tickValues = timeInterval ? scale.ticks(timeInterval) : scale.ticks()
    const getX = (value: Date) => scale(value)
    ticks = createTicksLabels<Date>(tickValues, getX, formatTick, showTickMarks)
  }

  return (
    <g className="Axis AxisHorizontal" transform={`translate(0, ${dimensions.boundedHeight})`}>
      <line className="stroke-gray-700 dark:stroke-gray-200 stroke-1" x2={dimensions.boundedWidth} />
      {ticks}
      {label && (
        <text
          className="fill-gray-800 dark:stroke-gray-100 text-md"
          transform={`translate(${dimensions.boundedWidth / 2}, 60)`}
        >
          {label}
        </text>
      )}
    </g>
  )
}

function createTicksLabels<T>(
  ticks: T[],
  getX: (tick: T) => number,
  formatTick: (tick: T) => string,
  showTickMarks: boolean
): JSX.Element {
  return (
    <>
      {ticks.map((tick: T) => {
        return (
          <g key={formatTick(tick)} transform={`translate(${getX(tick)}, 0)`}>
            {showTickMarks && <line y2="6" stroke="currentColor" />}
            <text
              className="fill-gray-800 dark:fill-gray-100 text-xs"
              style={{
                textAnchor: 'middle',
                transform: 'translateY(20px)',
              }}
            >
              {formatTick(tick)}
            </text>
          </g>
        )
      })}
    </>
  )
}

function isBandProps(props: BandProps | TimeProps): props is BandProps {
  return (props as BandProps).scale.bandwidth !== undefined
}
