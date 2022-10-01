import * as React from 'react'
import { useState } from 'react'
import { scaleBand, scaleLinear } from 'd3-scale'
import { max } from 'd3-array'

import Chart from '../charts/Chart'
import XAxis from '../charts/axis/XAxis'
import YAxis from '../charts/axis/YAxis'
import { RedGradient, redGradientId } from '../charts/Gradient'
import { useChartDimensions } from '../charts/hooks/useChartDimensions'

const POSSIBLE_GRADES = ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F']
const GAP_SIZE = 2

type TooltipProps = {
  grade: string
  percentage: number
  x: number
  y: number
}

function Tooltip({ grade, percentage, x, y }: TooltipProps): JSX.Element {
  const styles = { left: x + 10, top: y - 16 }
  return (
    <div className="absolute bg-black text-white text-sm rounded py-1 px-2" style={styles}>
      <p>
        {grade}: {percentage}%
      </p>
    </div>
  )
}

type Props = {
  data: number[]
}

export default function GradeChart({ data }: Props): JSX.Element {
  const [tooltipGrade, setTooltipGrade] = useState<string | null>(null)
  const [tooltipPercentage, setTooltipPercentage] = useState<number | null>(null)
  const [tooltipCoords, setTooltipCoords] = useState({ x: 0, y: 0 })

  const [ref, dimensions] = useChartDimensions<HTMLDivElement>({
    marginLeft: 36,
    marginTop: 20,
    height: 300,
  })

  const xScale = scaleBand().domain(POSSIBLE_GRADES).range([0, dimensions.boundedWidth])
  const yScale = scaleLinear()
    .domain([0, max(data) ?? 0 + 5])
    .range([dimensions.boundedHeight, 0])
    .nice()

  const width = Math.max(0, xScale.bandwidth() - GAP_SIZE)

  return (
    <div className="Histogram" ref={ref}>
      <Chart dimensions={dimensions}>
        <defs>
          <RedGradient />
        </defs>
        {data.map((d, i) => {
          const x = xScale(POSSIBLE_GRADES[i])
          const y = yScale(d)
          const height = dimensions.boundedHeight - y
          return (
            <rect
              onMouseMove={(e) => {
                setTooltipGrade(POSSIBLE_GRADES[i])
                setTooltipPercentage(d)
                setTooltipCoords({ x: e.pageX, y: e.pageY })
              }}
              onMouseLeave={() => {
                setTooltipGrade(null)
                setTooltipPercentage(null)
              }}
              key={i}
              x={x}
              y={y}
              width={width}
              height={height}
              style={{ fill: `url(#${redGradientId})` }}
            />
          )
        })}
        <XAxis scale={xScale} formatTick={(tick: string) => tick} />
        <YAxis scale={yScale} formatTick={(tick: number) => `${tick}%`} />
      </Chart>
      {tooltipGrade !== null && tooltipPercentage !== null && (
        <Tooltip grade={tooltipGrade} percentage={tooltipPercentage} x={tooltipCoords.x} y={tooltipCoords.y} />
      )}
    </div>
  )
}
