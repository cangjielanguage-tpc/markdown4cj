export const COLOR_WHITE: ResourceColor = '#FFFFFFFF'

export const COLOR_RED: ResourceColor = '#FFFF0000'

export const COLOR_BLACK: ResourceColor = '#FF000000'

export const COLOR_TRANSPARENT: ResourceColor = '#00000000'

export const COLOR_GRAY: ResourceColor = '#FF888888'

export const COLOR_FF191919: ResourceColor = '#FF191919'

export const COLOR_FFEAEAEA: ResourceColor = '#FFEAEAEA'

export const COLOR_E6000000: ResourceColor = '#E6000000'

export const COLOR_FFF5F5F5: ResourceColor = '#FFF5F5F5'

export const COLOR_FFE0E0E0: ResourceColor = '#FFE0E0E0'

export const COLOR_33000000: ResourceColor = '#33000000'

export const COLOR_1A000000: ResourceColor = '#1A000000'

export const COLOR_80000000: ResourceColor = '#80000000'

export const COLOR_FFFFF59D: ResourceColor = '#FFFFF59D'

export const COLOR_FFF5F2F0: ResourceColor = '#FFF5F2F0'

export const COLOR_DD000000: ResourceColor = '#DD000000'

export const SECONDS_PER_HOUR: number = 3600

export const SECONDS_PER_MINUTE: number = 60

/**
 * 判断是否是Margin对象
 * @param obj obj
 * @returns 是否是Margin对象
 */
export function isMargin(obj: Object): boolean {
  const keys = Object.keys(obj)
  return keys.includes('top')
    || keys.includes('right')
    || keys.includes('bottom')
    || keys.includes('left')
}

/**
 * 判断是否是Padding对象
 * @param obj obj
 * @returns 是否是Padding对象
 */
export function isPadding(obj: Object): boolean {
  const keys = Object.keys(obj)
  return keys.includes('top')
    || keys.includes('right')
    || keys.includes('bottom')
    || keys.includes('left')
}

/**
 * 判断是否是BorderRadiuses对象
 * @param obj obj
 * @returns 是否是BorderRadiuses对象
 */
export function isBorderRadiuses(obj: Object): boolean {
  const keys = Object.keys(obj)
  return keys.includes('topLeft')
    || keys.includes('topRight')
    || keys.includes('bottomLeft')
    || keys.includes('bottomRight')
}
