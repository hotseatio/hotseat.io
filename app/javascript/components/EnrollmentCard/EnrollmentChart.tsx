import * as React from 'react'
import { useState, useMemo, useCallback } from 'react'
import { pointer } from 'd3-selection'
import { max, bisector } from 'd3-array'
import { scaleTime, scaleLinear } from 'd3-scale'
import { timeDay } from 'd3-time'
import { line } from 'd3-shape'

import { add, sub, earliest, HOUR } from '../../utilities/date'
import { useChartDimensions } from '../charts/hooks/useChartDimensions'
import XAxis from '../charts/axis/XAxis'
import YAxis from '../charts/axis/YAxis'
import Chart from '../charts/Chart'
import { RedGradient, redGradientId } from '../charts/Gradient'

type EnrollmentDatumNonDate = {
  enrollmentCapacity: number
  enrollmentCount: number
  enrollmentStatus: string
  waitlistCapacity: number
  waitlistCount: number
  waitlistStatus: string
}

export type EnrollmentDatumJSON = EnrollmentDatumNonDate & { createdAt: string; updatedAt: string }
export type EnrollmentDatum = EnrollmentDatumNonDate & { createdAt: Date }

export type Marker = {
  label: string
  time: string
}

type Props = {
  sectionLabels: string[]
  sectionData: EnrollmentDatumJSON[][]
  enrollmentStart: string
  enrollmentEnd: string
  markers: Marker[]
  isLive: boolean
}

// How often the Schedule crawler runs.
const UPDATE_PERIOD = 1 * HOUR

const TIME_FORMAT_OPTIONS: Intl.DateTimeFormatOptions = {
  month: 'short',
  day: 'numeric',
  hour: 'numeric',
  timeZone: 'America/Los_Angeles',
  timeZoneName: 'short',
}

function formatLegendLabel(datum: EnrollmentDatum): string {
  return `${datum.enrollmentCount + datum.waitlistCount}/${
    datum.enrollmentCapacity + datum.waitlistCapacity
  } seats taken (${datum.enrollmentStatus})`
}

function formatHoverLabel(datum: EnrollmentDatum): string {
  return (datum.enrollmentCount + datum.waitlistCount).toString()
}

function fillOmittedData(
  jsonData: EnrollmentDatumJSON[],
  { enrollmentEnd, isLive }: { enrollmentEnd: Date; isLive: boolean }
): EnrollmentDatum[] {
  const out: EnrollmentDatum[] = []
  let prev: EnrollmentDatum | undefined

  for (const jsonDatum of jsonData) {
    const cur = {
      ...jsonDatum,
      createdAt: new Date(jsonDatum.createdAt),
    }

    // Handle sharp enrollment spikes.
    // https://github.com/nathunsmitty/hotseat.io/issues/62
    if (prev && sub(cur.createdAt, prev.createdAt) > 1.5 * UPDATE_PERIOD) {
      const copyDate = add(cur.createdAt, -UPDATE_PERIOD)
      out.push({
        ...prev,
        createdAt: copyDate,
      })
    }

    out.push(cur)
    prev = cur
  }

  // Duplicate the last datapoint, so that the line is extended
  // to the entire timeframe for which we have data.
  if (prev) {
    const end = isLive ? earliest(new Date(), enrollmentEnd) : enrollmentEnd
    out.push({
      ...prev,
      createdAt: end,
    })
  }

  return out
}

const datumBisector = bisector((d: EnrollmentDatum) => d.createdAt).left

export default function EnrollmentChart({
  sectionData,
  sectionLabels,
  enrollmentStart,
  enrollmentEnd,
  markers,
  isLive,
}: Props): JSX.Element {
  const [ref, dms] = useChartDimensions<HTMLDivElement>({
    marginRight: 30,
    marginLeft: 50,
    height: 300,
  })

  const [mouseX, setMouseX] = useState<number | null>(null)
  const [highlightedDataPoints, setHighlightedDataPoints] = useState<Array<EnrollmentDatum> | null>(null)

  const sanitizedSectionData = useMemo(
    () => sectionData.map((data) => fillOmittedData(data, { enrollmentEnd: new Date(enrollmentEnd), isLive })),
    [sectionData, enrollmentEnd, isLive]
  )
  const latestSectionData = useMemo(() => sanitizedSectionData.map((data) => data[data.length - 1]), [
    sanitizedSectionData,
  ])
  const legendSectionData = highlightedDataPoints ?? latestSectionData

  const yMax = useMemo(
    () =>
      max(sanitizedSectionData.flat(), (d) =>
        Math.max(d.enrollmentCapacity + d.waitlistCapacity, d.enrollmentCount + d.waitlistCount)
      ),
    [sanitizedSectionData]
  )

  const formatXAxisTick = (date: Date) => {
    const rawDaysCount = timeDay.count(new Date(enrollmentStart), date)
    const daysCount = Math.max(rawDaysCount, 0)
    const suffix = `day${daysCount === 1 ? '' : 's'}`
    return `${daysCount} ${suffix}`
  }

  const xScale = scaleTime()
    .domain([new Date(enrollmentStart), new Date(enrollmentEnd)])
    .range([0, dms.boundedWidth])
  // .nice()

  const yScale = scaleLinear()
    .domain([0, (yMax ?? 200) + 20])
    .range([dms.boundedHeight, 0])
  // .nice()

  const pathGenerator = line<EnrollmentDatum>()
    .x((d) => xScale(d.createdAt))
    .y((d) => yScale(d.enrollmentCount + d.waitlistCount))

  const sectionPaths = sanitizedSectionData.map((data) => pathGenerator(data))

  const firstDataPoint = sanitizedSectionData[0][0]
  const lastDataPoint = sanitizedSectionData[0][sanitizedSectionData[0].length - 1]
  const leftmostX = Math.max(xScale(firstDataPoint.createdAt), 0)
  const rightmostX = Math.min(xScale(lastDataPoint.createdAt), dms.boundedWidth)

  const setMouseXOnMove = useCallback(
    (event: React.MouseEvent<SVGSVGElement, MouseEvent>) => {
      const [x] = pointer(event)
      const adjustedX = x - dms.marginLeft

      if (adjustedX < leftmostX || adjustedX > rightmostX) {
        setMouseXOnLeave()
        return
      }
      setMouseX(adjustedX)

      const newHighlightedDataPoints = sanitizedSectionData.map((data) => {
        const date = xScale.invert(adjustedX)
        const index = datumBisector(data, date, 1)

        if (index === 0) {
          return data[index]
        }

        const a = data[index - 1]
        const b = data[index]

        if (b === undefined) {
          return a
        }

        return date.getTime() - a.createdAt.getTime() > b.createdAt.getTime() - date.getTime() ? b : a
      })
      setHighlightedDataPoints(newHighlightedDataPoints)
    },
    [sanitizedSectionData, xScale, dms.marginLeft, leftmostX, rightmostX]
  )

  const setMouseXOnLeave = () => {
    setMouseX(null)
    setHighlightedDataPoints(null)
  }

  return (
    <div>
      <div className="text-right mx-6 my-2 text-sm text-gray-900 dark:text-white bg-white dark:bg-gray-900">
        <div>{legendSectionData[0].createdAt.toLocaleDateString('en-US', TIME_FORMAT_OPTIONS)}</div>
        {legendSectionData.map((datum, i) => (
          <div key={i}>
            {sectionLabels[i]}: {formatLegendLabel(datum)}
          </div>
        ))}
      </div>
      <div ref={ref}>
        <Chart dimensions={dms} onPointerMove={setMouseXOnMove} onPointerLeave={setMouseXOnLeave}>
          <defs>
            <RedGradient />
          </defs>

          {sectionPaths.map((path, i) => (
            <path key={i} d={path ?? undefined} className="fill-none stroke-1.5" stroke={`url(#${redGradientId})`} />
          ))}

          {mouseX !== null && highlightedDataPoints !== null && (
            <g className="mouse-effects">
              <path
                d={`M${mouseX},${dms.boundedHeight} ${mouseX},0`}
                className="stroke-gray-900 dark:stroke-white stroke-1"
              />
              {highlightedDataPoints.map((datum, i) => (
                <g key={i} transform={`translate(${mouseX},${yScale(datum.enrollmentCount + datum.waitlistCount)})`}>
                  <circle r={4} className="fill-none stroke-red-600 stroke-1" />
                  <text className="fill-gray-800 dark:fill-gray-100 text-xs" transform="translate(-26,0)">
                    {formatHoverLabel(datum)}
                  </text>
                </g>
              ))}
            </g>
          )}

          {markers.map(({ label, time: rawTime }) => {
            const time = new Date(rawTime)
            return (
              <g key={rawTime} transform={`translate(${xScale(time)},0)`}>
                <line
                  className="stroke-gray-700 dark:stroke-gray-200 stroke-1"
                  strokeDasharray="2"
                  y2={dms.boundedHeight}
                />
                <text className="fill-gray-800 dark:fill-gray-100 text-xs" transform={`translate(4,10)`}>
                  {label}
                </text>
              </g>
            )
          })}

          <XAxis scale={xScale} formatTick={formatXAxisTick} showTickMarks={true} />
          <YAxis scale={yScale} formatTick={(tick: number) => tick.toString()} />
        </Chart>
      </div>
      {isLive && (
        <div className="text-center mx-6 my-2 text-sm text-gray-500 dark:text-gray-400 bg-white dark:bg-gray-900">
          <p>Displayed data is updated hourly from the UCLA Registrar.</p>
        </div>
      )}
    </div>
  )
}
