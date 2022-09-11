import * as React from 'react'
import { createContext, useContext } from 'react'
import { defaultDimensions, Dimensions } from './hooks/useChartDimensions'

const ChartContext = createContext(defaultDimensions)
export const useChartDimensions = (): Dimensions => useContext(ChartContext)

type Props = {
  dimensions: Dimensions
  children: React.ReactNode
  onPointerMove?: (event: React.PointerEvent<SVGSVGElement>) => void
  onPointerLeave?: () => void
}

export default function Chart({ dimensions, children, onPointerMove, onPointerLeave }: Props): JSX.Element {
  return (
    <ChartContext.Provider value={dimensions}>
      <svg
        className="Chart"
        width={dimensions.width}
        height={dimensions.height}
        onTouchStart={(e) => e.preventDefault()}
        onPointerMove={onPointerMove}
        onPointerLeave={onPointerLeave}
      >
        <g transform={`translate(${dimensions.marginLeft}, ${dimensions.marginTop})`}>{children}</g>
      </svg>
    </ChartContext.Provider>
  )
}
