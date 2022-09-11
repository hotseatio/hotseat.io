import { useRef, useEffect, useState } from 'react'

export type DefinedDimensions = {
  marginTop?: number
  marginRight?: number
  marginBottom?: number
  marginLeft?: number
  height?: number
  width?: number
  boundedHeight?: number
  boundedWidth?: number
}

export type PartialDimensions = {
  marginTop?: number
  marginRight?: number
  marginBottom?: number
  marginLeft?: number
  height: number
  width: number
  boundedHeight?: number
  boundedWidth?: number
}

export type Dimensions = {
  marginTop: number
  marginRight: number
  marginBottom: number
  marginLeft: number
  height: number
  width: number
  boundedHeight: number
  boundedWidth: number
}

export const defaultDimensions: Dimensions = {
  marginTop: 10,
  marginRight: 10,
  marginBottom: 40,
  marginLeft: 40,
  height: 0,
  width: 0,
  boundedHeight: 0,
  boundedWidth: 0,
}

const combineChartDimensions = (dimensions: PartialDimensions) => {
  const parsedDimensions = {
    ...dimensions,
    marginTop: dimensions.marginTop || defaultDimensions.marginTop,
    marginRight: dimensions.marginRight || defaultDimensions.marginRight,
    marginBottom: dimensions.marginBottom || defaultDimensions.marginBottom,
    marginLeft: dimensions.marginLeft || defaultDimensions.marginLeft,
  }
  return {
    ...parsedDimensions,
    boundedHeight: Math.max(parsedDimensions.height - parsedDimensions.marginTop - parsedDimensions.marginBottom, 0),
    boundedWidth: Math.max(parsedDimensions.width - parsedDimensions.marginLeft - parsedDimensions.marginRight, 0),
  }
}

export function useChartDimensions<T extends Element>(
  passedDimensions: DefinedDimensions
): [React.MutableRefObject<T | null>, Dimensions] {
  const ref = useRef<T>(null)
  const [width, changeWidth] = useState(0)
  const [height, changeHeight] = useState(0)

  useEffect(() => {
    if (passedDimensions.width && passedDimensions.height) return

    const element = ref.current
    if (!element) return

    const resizeObserver = new ResizeObserver((entries: ResizeObserverEntry[]) => {
      if (!Array.isArray(entries)) return
      if (!entries.length) return

      const entry = entries[0]

      if (width != entry.contentRect.width) changeWidth(entry.contentRect.width)
      if (height != entry.contentRect.height) changeHeight(entry.contentRect.height)
    })

    resizeObserver.observe(element)

    return () => resizeObserver.unobserve(element)
  }, [])

  const newSettings = combineChartDimensions({
    ...passedDimensions,
    width: passedDimensions.width || width,
    height: passedDimensions.height || height,
  })

  return [ref, newSettings]
}
