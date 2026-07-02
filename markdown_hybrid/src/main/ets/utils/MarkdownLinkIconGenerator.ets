import { image } from "@kit.ImageKit"
import { drawCircleImage, drawRectImage, drawRectToolImage } from 'libtext_to_img.so'
import { LinkTheme } from "../theme/LinkTheme"
import { urlSafeBase64Decode } from "./MarkdownUtils"
import { NUM_00000000, NUM_33000000, NUM_333D73CF, NUM_33B41700, NUM_FF000000, NUM_FF0000FF, NUM_FF008000, NUM_FF3D73CF, NUM_FF888888, NUM_FF884800, NUM_FFB41700, NUM_FFFFFF00, NUM_FFFFFFFF, NUM_FFFF0000, NUM_FFFFA500, NUM_FFFFC0CB } from "../base/Constants"

/**
 * 链接图标类型枚举
 */
export const LINK_ICON_TYPE_CIRCLE = 0
export const LINK_ICON_TYPE_RECT = 1
export const LINK_ICON_TYPE_TOOL = 2

/**
 * 链接图标信息
 */
export interface LinkIconInfo {
  iconType: number
  typeStr: string
}

/**
 * 链接图标生成结果
 */
export interface LinkIconResult {
  pixelMap: PixelMap
  width: number
  height: number
}

/**
 * 链接类型颜色对（数值型）
 */
interface TypeColorPairNum {
  foreground: number
  background: number
}

/**
 * ResourceColor转number（ARGB uint32）
 * 处理三种情况：
 * 1. Color枚举索引(0-11) → 映射到ARGB值
 * 2. 数字ARGB值(>11) → 直接返回
 * 3. 字符串hex色值(#AARRGGBB) → 解析为数字
 *
 * @param color 资源颜色
 * @return 颜色的数字值
 */
function resourceColorToNumber(color: ResourceColor): number {
  if (typeof color === 'number') {
    const num = color
    if (num >= 0 && num <= 11) {
      switch (num) {
        case 0: return NUM_FFFFFFFF
        case 1: return NUM_FF000000
        case 2: return NUM_FF0000FF
        case 3: return NUM_FF884800
        case 4: return NUM_FF888888
        case 5: return NUM_FF008000
        case 6: return NUM_FF888888
        case 7: return NUM_FFFFFF00
        case 8: return NUM_FFFF0000
        case 9: return NUM_FFFFC0CB
        case 10: return NUM_FFFFA500
        case 11: return NUM_00000000
        default: return NUM_FF000000
      }
    }
    return num >>> 0
  }
  if (typeof color === 'string') {
    if (color.startsWith('#')) {
      let hex: string = color.substring(1)
      if (hex.length === 6) {
        hex = 'FF' + hex
      }
      const num = parseInt(hex, 16)
      if (!isNaN(num)) {
        return num >>> 0
      }
    }
  }
  return NUM_FF000000
}

/**
 * Length转number
 *
 * @param length 长度
 * @return 长度的数字值
 */
function lengthToNumber(length: Length): number {
  if (typeof length === 'number') {
    return length
  }
  return 0
}

/**
 * 根据类型字符串返回前景色和背景色（数值型 ARGB）
 *
 * @param str 类型字符串
 * @return 类型颜色对
 */
function typeStringColorNum(str: string): TypeColorPairNum {
  let fg: number = NUM_FF000000
  let bg: number = NUM_33000000
  switch (str) {
    case 'PDF':
      fg = NUM_FFB41700
      bg = NUM_33B41700
      break
    case 'DOC':
    case 'DOCX':
      fg = NUM_FF3D73CF
      bg = NUM_333D73CF
      break
    case 'TXT':
      fg = NUM_FF000000
      bg = NUM_33000000
      break
    default:
      break
  }
  const result: TypeColorPairNum = { foreground: fg, background: bg }
  return result
}

/**
 * 根据链接URL和文本计算图标类型和类型字符串
 *
 * @param url 链接URL
 * @param text 链接文本
 * @return 链接图标信息
 */
export function computeLinkIconInfo(url: string, text: string): LinkIconInfo {
  const isHttp = url.startsWith('http://') || url.startsWith('https://')
  const trimmedText = text.trim()
  const runeCount = Array.from(trimmedText).length

  if (isHttp && runeCount === 1) {
    const result: LinkIconInfo = { iconType: LINK_ICON_TYPE_CIRCLE, typeStr: '' }
    return result
  } else if (isHttp && runeCount > 1) {
    const result: LinkIconInfo = { iconType: LINK_ICON_TYPE_RECT, typeStr: '' }
    return result
  } else {
    const typeStr = urlSafeBase64Decode(url)
    if (typeStr.length === 0) {
      const result: LinkIconInfo = { iconType: LINK_ICON_TYPE_RECT, typeStr: '' }
      return result
    }
    const result: LinkIconInfo = { iconType: LINK_ICON_TYPE_TOOL, typeStr: typeStr }
    return result
  }
}

/**
 * 生成链接图标PixelMap（通过C++原生绘图）
 *
 * @param text 链接文本
 * @param url 链接URL
 * @param linkTheme 链接样式
 * @return 链接图标像素图结果
 */
export function generateLinkIconPixelMap(
  text: string,
  url: string,
  linkTheme: LinkTheme
): Promise<LinkIconResult | undefined> {
  const iconInfo = computeLinkIconInfo(url, text)
  const trimmedText = text.trim()
  const colorFormat = 5

  let buffer: ArrayBuffer | undefined = undefined

  if (iconInfo.iconType === LINK_ICON_TYPE_CIRCLE) {
    const textHeight = vp2px(linkTheme.linkCircleIconRadius)
    const fontSize = vp2px(linkTheme.linkCircleIconTextSize)
    const fontColor = resourceColorToNumber(linkTheme.linkCircleIconTextColor)
    const fontBgColor = resourceColorToNumber(linkTheme.linkCircleIconButtonBackgroundColor)
    const bgColor = resourceColorToNumber(linkTheme.linkCircleIconBackgroundColor)
    buffer = drawCircleImage(trimmedText, fontSize, fontColor, fontBgColor, bgColor, textHeight, colorFormat)
  } else if (iconInfo.iconType === LINK_ICON_TYPE_RECT) {
    const textHeight = vp2px(lengthToNumber(linkTheme.linkRectIconHeight))
    const fontSize = vp2px(linkTheme.linkRectIconTextSize)
    const fontColor = resourceColorToNumber(linkTheme.linkRectIconTextColor)
    const fontBgColor = resourceColorToNumber(linkTheme.linkRectIconButtonBackgroundColor)
    const bgColor = resourceColorToNumber(linkTheme.linkRectIconBackgroundColor)
    const padding = vp2px(linkTheme.linkRectIconPadding)
    const radius = vp2px(linkTheme.linkRectIconRadius)
    buffer = drawRectImage(trimmedText, fontSize, fontColor, fontBgColor, bgColor, textHeight, colorFormat, padding, radius, false)
  } else {
    const colors = typeStringColorNum(iconInfo.typeStr)
    const textHeight = vp2px(lengthToNumber(linkTheme.linkRectToolIconHeight))
    const fontSize = vp2px(linkTheme.linkRectToolIconTextSize)
    const fontColor = colors.foreground
    const fontBgColor = resourceColorToNumber(linkTheme.linkRectToolIconButtonBackgroundColor)
    const bgColor = resourceColorToNumber(linkTheme.linkRectToolIconBackgroundColor)
    const borderColor = colors.foreground
    const borderWidth = vp2px(lengthToNumber(linkTheme.linkRectToolIconBorderWidth))
    const divLineColor = colors.background
    const divLineWidth = vp2px(lengthToNumber(linkTheme.linkRectToolIconDividingLineWidth))
    const padding = vp2px(linkTheme.linkRectToolIconPadding)
    const lineLeftPadding = vp2px(linkTheme.linkRectToolIconLineLeftPadding)
    const lineRightPadding = vp2px(linkTheme.linkRectToolIconLineRightPadding)
    buffer = drawRectToolImage(trimmedText, iconInfo.typeStr, fontSize, fontColor, fontBgColor, bgColor,
      borderColor, borderWidth, divLineColor, divLineWidth, textHeight, colorFormat,
      padding, lineLeftPadding, lineRightPadding)
  }

  if (buffer === undefined) {
    return Promise.resolve(undefined)
  }
  if (buffer.byteLength === 0) {
    return Promise.resolve(undefined)
  }

  let imageSource: image.ImageSource | undefined = undefined
  try {
    imageSource = image.createImageSource(buffer)
  } catch (e) {
    console.error('bufferToPixelMap createImageSource failed: ' + JSON.stringify(e))
    return Promise.resolve(undefined)
  }
  if (imageSource === undefined || imageSource === null) {
    return Promise.resolve(undefined)
  }
  const source = imageSource
  let imageSourceReleased = false
  return source.createPixelMap()
    .then((pm: PixelMap) => {
      return pm.getImageInfo()
        .then((info: image.ImageInfo) => {
          imageSourceReleased = true
          try {
            source.release()
          } catch (e) {
            console.error('LinkIcon source release failed: ' + JSON.stringify(e))
          }
          const result: LinkIconResult = {
            pixelMap: pm,
            width: info.size.width,
            height: info.size.height
          }
          return result
        })
        .catch(() => {
          try {
            pm.release()
          } catch (e) {
            console.error('LinkIcon pm release failed: ' + JSON.stringify(e))
          }
          if (!imageSourceReleased) {
            imageSourceReleased = true
            try {
              source.release()
            } catch (e) {
              console.error('LinkIcon source release failed: ' + JSON.stringify(e))
            }
          }
          return undefined
        })
    })
    .catch(() => {
      if (!imageSourceReleased) {
        imageSourceReleased = true
        try {
          source.release()
        } catch (e) {
          console.error('LinkIcon source release failed: ' + JSON.stringify(e))
        }
      }
      return undefined
    })
}
