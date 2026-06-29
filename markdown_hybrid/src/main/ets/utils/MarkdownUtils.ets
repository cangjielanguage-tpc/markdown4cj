import { SECONDS_PER_HOUR, SECONDS_PER_MINUTE } from "../base/Constants"
import { BulletListTheme } from "../theme/BulletListTheme"

/**
 * 判断软换行是否换行
 *
 * @param isLineBreak 软换行是否需要换行
 * @return 返回需要换行或者空格的内容
 */
export function spanSoftLineBreak(isLineBreak: boolean): string {
  if (isLineBreak) {
    return "\n"
  } else {
    return " "
  }
}

/**
 * 表格格子对齐方式
 *
 * @param alignment TableAlignment
 * @return 对齐方式
 */
export function renderTableCellColumnAlign(alignment ?: string): HorizontalAlign {
  switch (alignment) {
    case "LEFT":
      return HorizontalAlign.Start
    case "CENTER":
      return HorizontalAlign.Center
    case "LEFT":
      return HorizontalAlign.End
    default:
      return HorizontalAlign.Start
  }
}

/**
 * 将秒转换成时分秒并以HH:MM:SS 格式输出
 *
 * @param totalSeconds 秒数
 * @return 返回时分秒文本
 */
export function formatDurationToTime(totalSeconds: number): string {
  const hours = Math.floor(totalSeconds / SECONDS_PER_HOUR)
  const minutes = Math.floor((totalSeconds % SECONDS_PER_HOUR) / SECONDS_PER_MINUTE)
  const seconds = totalSeconds % SECONDS_PER_MINUTE
  const strHours = String(hours).padStart(2, '0')
  const strMinutes = String(minutes).padStart(2, '0')
  const strSeconds = String(seconds).padStart(2, '0')
  return `${strHours}:${strMinutes}:${strSeconds}`
}

/**
 * 有序/无序前缀文本内容
 *
 * @param item NodeView
 * @param listDepth 列表深度
 * @param isBullet 是否是无序列表
 * @param markdownTheme markdown样式
 * @return 前缀文本内容
 */
export function listPrefixStr(index: number, listDepth: number, isOrderList: boolean,
  bulletListTheme: BulletListTheme): string {
  if (isOrderList) {
    // 有序列表
    return `${index}.`
  }
  if (bulletListTheme.bulletListBulletIsCircle) {
    return `${solidCircleToUnicode()}`
  }
  if (listDepth == 0) {
    return `${solidCircleToUnicode()}`
  }
  if (listDepth == 1) {
    return `${hollowCircleToUnicode()}`
  }
  return `${solidSquareToUnicode()}`
}

/**
 * 实心圆形
 *
 * @return 实心圆形UniCode码
 */
export function solidCircleToUnicode(): string {
  // ●
  let solidDots: string = '\u{25CF}'
  return solidDots
}

/**
 * 空心圆形
 *
 * @return 空心圆形UniCode码
 */
export function hollowCircleToUnicode(): string {
  // ○
  let hollowCircle: string = '\u{25CB}'
  return hollowCircle
}

/**
 * 实心正方形
 *
 * @return 实心正方形UniCode码
 */
export function solidSquareToUnicode(): string {
  // ■
  let solidSquare: string = '\u{25A0}'
  return solidSquare
}

/**
 *
 *
 * @return
 */
export function imageUrlHandle(url?: string): ResourceStr | undefined {
  if (url?.startsWith("./")) {
    const resStr = url.replace("./", "")
    const res = $rawfile(resStr)
    return res
  } else {
    return url
  }
}

/**
 * 处理图片的宽高
 *
 * @param componentImageWidth 控件宽度
 * @param imageResWidth 图片真实宽度
 * @param imageResHeight 图片真实高度
 * @param imageWidth 图片设置宽度
 * @param imageHeight 图片设置高度
 * @param imageMaxWidth 图片设置宽度
 * @param imageFixedRatioWidth 图片基于父布局宽度缩放百分比
 * @param imageMaximumWidth 图片基于自身宽度缩放百分比
 * @return 图片的宽高单位是PX
 */
export function imageWidthAndHeight(
  componentImageWidth: number,
  imageResWidth: number,
  imageResHeight: number,
  imageWidthPx: number | undefined,
  imageHeightPx: number | undefined,
  imageMaxWidth: number | undefined,
  imageMaxHeight: number | undefined,
  imageFixedRatioWidth: number | undefined,
  imageMaximumWidth: number
): Array<number> {
  let width: number = 0
  let height: number = 0
  const componentImageWidthNew = (imageMaxWidth !== undefined)
    ? Math.min(vp2px(imageMaxWidth), componentImageWidth)
    : componentImageWidth
  const aspectRatio: number = imageResHeight / imageResWidth
  if (imageWidthPx !== undefined && imageHeightPx !== undefined) {
    const aspectRatioNew: number = imageHeightPx / imageWidthPx
    let widthNew = (imageFixedRatioWidth !== undefined)
      ? componentImageWidth * imageFixedRatioWidth
      : imageWidthPx * imageMaximumWidth
    widthNew = Math.min(widthNew, componentImageWidthNew)
    let heightNew: number = widthNew * aspectRatioNew
    if (imageMaxHeight !== undefined) {
      const imageMaxHeightPX = vp2px(imageMaxHeight)
      if (heightNew < imageMaxHeightPX) {
        width = widthNew
        height = heightNew
      } else {
        const aspectRatioHeightNew = imageMaxHeightPX / heightNew
        width = widthNew * aspectRatioHeightNew
        height = imageMaxHeightPX
      }
    } else {
      width = widthNew
      height = heightNew
    }
  } else if (imageWidthPx !== undefined && imageHeightPx === undefined) {
    let widthNew = (imageFixedRatioWidth !== undefined)
      ? componentImageWidth * imageFixedRatioWidth
      : imageWidthPx * imageMaximumWidth
    widthNew = Math.min(widthNew, componentImageWidthNew)
    let heightNew: number = widthNew * aspectRatio
    if (imageMaxHeight !== undefined) {
      const imageMaxHeightPX = vp2px(imageMaxHeight)
      if (heightNew < imageMaxHeightPX) {
        width = widthNew
        height = heightNew
      } else {
        const aspectRatioHeightNew = imageMaxHeightPX / heightNew
        width = widthNew * aspectRatioHeightNew
        height = imageMaxHeightPX
      }
    } else {
      width = widthNew
      height = heightNew
    }
  } else if (imageWidthPx === undefined && imageHeightPx !== undefined) {
    let widthNew = (imageFixedRatioWidth !== undefined)
      ? componentImageWidth * imageFixedRatioWidth
      : (imageHeightPx / aspectRatio) * imageMaximumWidth
    widthNew = Math.min(widthNew, componentImageWidthNew)
    let heightNew: number = widthNew * aspectRatio
    if (imageMaxHeight !== undefined) {
      const imageMaxHeightPX = vp2px(imageMaxHeight)
      if (heightNew < imageMaxHeightPX) {
        width = widthNew
        height = heightNew
      } else {
        const aspectRatioHeightNew = imageMaxHeightPX / heightNew
        width = widthNew * aspectRatioHeightNew
        height = imageMaxHeightPX
      }
    } else {
      width = widthNew
      height = heightNew
    }
  } else {
    let widthNew = (imageFixedRatioWidth !== undefined)
      ? componentImageWidth * imageFixedRatioWidth
      : imageResWidth * imageMaximumWidth
    widthNew = Math.min(widthNew, componentImageWidthNew)
    let heightNew: number = widthNew * aspectRatio
    if (imageMaxHeight !== undefined) {
      const imageMaxHeightPX = vp2px(imageMaxHeight)
      if (heightNew < imageMaxHeightPX) {
        width = widthNew
        height = heightNew
      } else {
        const aspectRatioHeightNew = imageMaxHeightPX / heightNew
        width = widthNew * aspectRatioHeightNew
        height = imageMaxHeightPX
      }
    } else {
      width = widthNew
      height = heightNew
    }
  }
  return [width, height]
}

/**
 * 将字符串解析为数值（用于HTML图片width/height属性）
 *
 * @param str 字符串形式的数值（如 "100"）
 * @return 数值，解析失败返回undefined
 */
export function strToLengthNumber(str: string | undefined): number | undefined {
  if (str === undefined || str.length === 0) {
    return undefined
  }
  const trimmed = str.trim()
  if (trimmed.length === 0) {
    return undefined
  }
  if (trimmed.toLowerCase().endsWith('px')) {
    const numStr = trimmed.substring(0, trimmed.length - 2)
    const num = Number.parseFloat(numStr)
    if (!Number.isNaN(num)) {
      return num
    }
    return undefined
  }
  const num = Number.parseFloat(trimmed)
  if (!Number.isNaN(num)) {
    return num
  }
  return undefined
}

/**
 * HTML标签font-size属性字符串转换数值
 *
 * @param sizeString font-size属性值（如 "26px"、"x-small"、"10"）
 * @return 对应的数值（无法识别返回undefined）
 */
export function sizeStringToSize(sizeString: string): number | undefined {
  const sizeStr = sizeString.toLowerCase().trim()
  let size: number | undefined
  switch (sizeStr) {
    case 'xx-small':
      size = 9
      break
    case 'x-small':
      size = 10
      break
    case 'small':
      size = 13
      break
    case 'medium':
      size = 16
      break
    case 'large':
      size = 18
      break
    case 'x-large':
      size = 24
      break
    case 'xx-large':
      size = 32
      break
    case 'xxx-large':
      size = 36
      break
    default:
      if (sizeStr.length > 2 && sizeStr.substring(sizeStr.length - 2) === 'px') {
        const num = Number.parseFloat(sizeStr.substring(0, sizeStr.length - 2))
        if (!Number.isNaN(num)) {
          size = num
        }
      } else {
        const num = Number.parseFloat(sizeStr)
        if (!Number.isNaN(num)) {
          size = num
        }
      }
      break
  }
  return size
}

/**
 * HTML标签font-weight属性转换FontWeight枚举
 *
 * @param weightString font-weight属性值（如 "bold"、"normal"、"400"）
 * @return 对应的FontWeight（未匹配返回undefined）
 */
export function fontWeightToValue(weightString: string): FontWeight | undefined {
  const weightStr = weightString.toLowerCase().trim()
  switch (weightStr) {
    case 'normal':
      return FontWeight.Normal
    case 'bold':
      return FontWeight.Bold
    case 'lighter':
      return FontWeight.Lighter
    case 'bolder':
      return FontWeight.Bolder
    case '100':
      return 100
    case '200':
      return 200
    case '300':
      return 300
    case '400':
      return 400
    case '500':
      return 500
    case '600':
      return 600
    case '700':
      return 700
    case '800':
      return 800
    case '900':
      return 900
    default:
      return undefined
  }
}

/**
 * 通过颜色名查找ARGB数值
 *
 * @param colorStr 小写颜色名（如 "red"、"blue"）
 * @return ARGB数值，未匹配返回undefined
 */
function colorNameToArgb(colorStr: string): number | undefined {
  switch (colorStr) {
    // CSS基础色
    case 'black': return 0xFF000000
    case 'silver': return 0xFFC0C0C0
    case 'gray': return 0xFF808080
    case 'grey': return 0xFF808080
    case 'white': return 0xFFFFFFFF
    case 'maroon': return 0xFF800000
    case 'red': return 0xFFFF0000
    case 'purple': return 0xFF800080
    case 'fuchsia': return 0xFFFF00FF
    case 'green': return 0xFF008000
    case 'lime': return 0xFF00FF00
    case 'olive': return 0xFF808000
    case 'yellow': return 0xFFFFFF00
    case 'navy': return 0xFF000080
    case 'blue': return 0xFF0000FF
    case 'teal': return 0xFF008080
    case 'aqua': return 0xFF00FFFF
    case 'cyan': return 0xFF00FFFF
    // 扩展色
    case 'aliceblue': return 0xFFF0F8FF
    case 'antiquewhite': return 0xFFFAEBD7
    case 'aquamarine': return 0xFF7FFFD4
    case 'azure': return 0xFFF0FFFF
    case 'beige': return 0xFFF5F5DC
    case 'bisque': return 0xFFFFE4C4
    case 'blueviolet': return 0xFF8A2BE2
    case 'brown': return 0xFFA52A2A
    case 'burlywood': return 0xFFDEB887
    case 'cadetblue': return 0xFF5F9EA0
    case 'chartreuse': return 0xFF7FFF00
    case 'chocolate': return 0xFFD2691E
    case 'coral': return 0xFFFF7F50
    case 'cornflowerblue': return 0xFF6495ED
    case 'cornsilk': return 0xFFFFF8DC
    case 'crimson': return 0xFFDC143C
    case 'darkblue': return 0xFF00008B
    case 'darkcyan': return 0xFF008B8B
    case 'darkgoldenrod': return 0xFFB8860B
    case 'darkgray': return 0xFFA9A9A9
    case 'darkgreen': return 0xFF006400
    case 'darkkhaki': return 0xFFBDB76B
    case 'darkmagenta': return 0xFF8B008B
    case 'darkolivegreen': return 0xFF556B2F
    case 'darkorange': return 0xFFFF8C00
    case 'darkorchid': return 0xFF9932CC
    case 'darkred': return 0xFF8B0000
    case 'darksalmon': return 0xFFE9967A
    case 'darkseagreen': return 0xFF8FBC8F
    case 'darkslateblue': return 0xFF483D8B
    case 'darkslategray': return 0xFF2F4F4F
    case 'darkturquoise': return 0xFF00CED1
    case 'darkviolet': return 0xFF9400D3
    case 'deeppink': return 0xFFFF1493
    case 'deepskyblue': return 0xFF00BFFF
    case 'dimgray': return 0xFF696969
    case 'dodgerblue': return 0xFF1E90FF
    case 'firebrick': return 0xFFB22222
    case 'floralwhite': return 0xFFFFFAF0
    case 'forestgreen': return 0xFF228B22
    case 'gainsboro': return 0xFFDCDCDC
    case 'ghostwhite': return 0xFFF8F8FF
    case 'gold': return 0xFFFFD700
    case 'goldenrod': return 0xFFDAA520
    case 'greenyellow': return 0xFFADFF2F
    case 'honeydew': return 0xFFF0FFF0
    case 'hotpink': return 0xFFFF69B4
    case 'indianred': return 0xFFCD5C5C
    case 'indigo': return 0xFF4B0082
    case 'ivory': return 0xFFFFFFF0
    case 'khaki': return 0xFFF0E68C
    case 'lavender': return 0xFFE6E6FA
    case 'lavenderblush': return 0xFFFFF0F5
    case 'lawngreen': return 0xFF7CFC00
    case 'lemonchiffon': return 0xFFFFFACD
    case 'lightblue': return 0xFFADD8E6
    case 'lightcoral': return 0xFFF08080
    case 'lightcyan': return 0xFFE0FFFF
    case 'lightgoldenrodyellow': return 0xFFFAFAD2
    case 'lightgray': return 0xFFD3D3D3
    case 'lightgreen': return 0xFF90EE90
    case 'lightpink': return 0xFFFFB6C1
    case 'lightsalmon': return 0xFFFFA07A
    case 'lightseagreen': return 0xFF20B2AA
    case 'lightskyblue': return 0xFF87CEFA
    case 'lightslategray': return 0xFF778899
    case 'lightsteelblue': return 0xFFB0C4DE
    case 'lightyellow': return 0xFFFFFFE0
    case 'limegreen': return 0xFF32CD32
    case 'linen': return 0xFFFAF0E6
    case 'magenta': return 0xFFFF00FF
    case 'mediumaquamarine': return 0xFF66CDAA
    case 'mediumblue': return 0xFF0000CD
    case 'mediumorchid': return 0xFFBA55D3
    case 'mediumpurple': return 0xFF9370DB
    case 'mediumseagreen': return 0xFF3CB371
    case 'mediumslateblue': return 0xFF7B68EE
    case 'mediumspringgreen': return 0xFF00FA9A
    case 'mediumturquoise': return 0xFF48D1CC
    case 'mediumvioletred': return 0xFFC71585
    case 'midnightblue': return 0xFF191970
    case 'mintcream': return 0xFFF5FFFA
    case 'mistyrose': return 0xFFFFE4E1
    case 'moccasin': return 0xFFFFE4B5
    case 'navajowhite': return 0xFFFFDEAD
    case 'oldlace': return 0xFFFDF5E6
    case 'olivedrab': return 0xFF6B8E23
    case 'orange': return 0xFFFFA500
    case 'orangered': return 0xFFFF4500
    case 'orchid': return 0xFFDA70D6
    case 'palegoldenrod': return 0xFFEEE8AA
    case 'palegreen': return 0xFF98FB98
    case 'paleturquoise': return 0xFFAFEEEE
    case 'palevioletred': return 0xFFDB7093
    case 'papayawhip': return 0xFFFFEFD5
    case 'peachpuff': return 0xFFFFDAB9
    case 'peru': return 0xFFCD853F
    case 'pink': return 0xFFFFC0CB
    case 'plum': return 0xFFDDA0DD
    case 'powderblue': return 0xFFB0E0E6
    case 'rosybrown': return 0xFFBC8F8F
    case 'royalblue': return 0xFF4169E1
    case 'saddlebrown': return 0xFF8B4513
    case 'salmon': return 0xFFFA8072
    case 'sandybrown': return 0xFFF4A460
    case 'seagreen': return 0xFF2E8B57
    case 'seashell': return 0xFFFFF5EE
    case 'sienna': return 0xFFA0522D
    case 'skyblue': return 0xFF87CEEB
    case 'slateblue': return 0xFF6A5ACD
    case 'slategray': return 0xFF708090
    case 'snow': return 0xFFFFFAFA
    case 'springgreen': return 0xFF00FF7F
    case 'steelblue': return 0xFF4682B4
    case 'tan': return 0xFFD2B48C
    case 'thistle': return 0xFFD8BFD8
    case 'tomato': return 0xFFFF6347
    case 'turquoise': return 0xFF40E0D0
    case 'violet': return 0xFFEE82EE
    case 'wheat': return 0xFFF5DEB3
    case 'whitesmoke': return 0xFFF5F5F5
    case 'yellowgreen': return 0xFF9ACD32
    // HarmonyOS Color枚举
    case 'transparent': return 0x00000000
    default: return undefined
  }
}

/**
 * 判断字符串是否仅由十六进制字符组成
 *
 * @param s 输入字符串
 * @return true表示全是0-9a-f
 */
function isHexString(s: string): boolean {
  for (let i = 0; i < s.length; i++) {
    const c = s.charCodeAt(i)
    const isDigit = c >= 48 && c <= 57 // 0-9
    const isLowerHex = c >= 97 && c <= 102 // a-f
    if (!isDigit && !isLowerHex) {
      return false
    }
  }
  return true
}

/**
 * 将#RGB扩展为#RRGGBB
 *
 * @param hex 3位十六进制颜色（如 "F00"）
 * @return 6位十六进制颜色（如 "FF0000"）
 */
function expandHex3(hex: string): string {
  let result = ''
  for (let i = 0; i < hex.length; i++) {
    const ch = hex.charAt(i)
    result += ch + ch
  }
  return result
}

/**
 * HTML标签color属性字符串转换ResourceColor
 *
 * @param colorString color属性值（如 "red"、"0xFFFF0000"、"#FF0000FF"）
 * @return ResourceColor（无法识别返回undefined）
 */
export function colorStringToColor(colorString: string): ResourceColor | undefined {
  const colorStr = colorString.toLowerCase().trim()
  if (colorStr.length === 0) {
    return undefined
  }
  // 1. 颜色名（如 "red"、"blue"）
  const named = colorNameToArgb(colorStr)
  if (named !== undefined) {
    return named
  }
  // 2. 0xARGB格式（如 "0xFFFF0000"）
  if (colorStr.startsWith('0x') || colorStr.startsWith('-0x')) {
    const num = Number.parseInt(colorStr, 16)
    if (!Number.isNaN(num)) {
      return num
    }
    return undefined
  }
  // 3. #RRGGBB 或 #AARRGGBB 格式（如 "#FF0000"、"#FF0000FF"）
  if (colorStr.startsWith('#')) {
    const hex = colorStr.substring(1)
    if (isHexString(hex)) {
      if (hex.length === 6) {
        // #RRGGBB → 补 FF alpha
        return 0xFF000000 | Number.parseInt(hex, 16)
      } else if (hex.length === 8) {
        // #AARRGGBB
        return Number.parseInt(hex, 16)
      } else if (hex.length === 3) {
        // #RGB → #RRGGBB
        const expanded = expandHex3(hex)
        return 0xFF000000 | Number.parseInt(expanded, 16)
      }
    }
    return undefined
  }
  // 4. 纯数字（如 "123"）按十进制处理
  const num = Number.parseInt(colorStr, 10)
  if (!Number.isNaN(num)) {
    return num
  }
  return undefined
}

/**
 * StyleImage样式解析结果
 */
export interface PicStyleObj {
  width: number | undefined
  height: number | undefined
  borderRadius: Length | undefined
  align: HorizontalAlign | undefined
}

/**
 * 对StyleImage的style数组进行解析
 * 样式格式如 ":width=100px"、":height=200px"、":align=center"、":border-radius=10px"
 *
 * @param picStyle 样式字符串数组
 * @return PicStyleObj对象
 */
export function parsePicStyle(picStyle: Array<string> | undefined): PicStyleObj {
  const picStyleObj: PicStyleObj = {
    width: undefined,
    height: undefined,
    borderRadius: undefined,
    align: undefined
  }
  // 分步判空，避免||短路求值在ArkTS运行时不可靠导致undefined.length异常
  if (picStyle === undefined) {
    return picStyleObj
  }
  if (picStyle === null) {
    return picStyleObj
  }
  if (picStyle.length === 0) {
    return picStyleObj
  }
  for (let i = 0; i < picStyle.length; i++) {
    const str: string | undefined = picStyle[i]
    if (str === undefined || str === null || str.length === 0) {
      continue
    }
    try {
      // 去除空格、引号、花括号，转小写
      let style = str.replace(/ /g, '').replace(/"/g, '').replace(/'/g, '')
        .replace(/{/g, '').replace(/}/g, '').toLowerCase()
      // 去除开头的冒号（如 ":width=200" → "width=200"）
      if (style.startsWith(':')) {
        style = style.substring(1)
      }
      if (style.length === 0) {
        continue
      }
      // 处理 style= 复合CSS属性（如 style=width:200px;height:100px;border-radius:10px）
      if (style.startsWith('style=')) {
        const cssContent = style.substring(6)
        const cssProps = cssContent.split(';')
        for (let j = 0; j < cssProps.length; j++) {
          applyStyleProp(cssProps[j], picStyleObj)
        }
      } else {
        // 单个属性，如 width=200、width:200、border-radius=20、align=left
        applyStyleProp(style, picStyleObj)
      }
    } catch (e) {
      // 忽略解析错误
    }
  }
  return picStyleObj
}

/**
 * 应用单个样式属性到PicStyleObj
 * 支持两种分隔符：=（如 width=200）和 :（如 width:200px）
 *
 * @param prop 样式属性字符串（如 "width=200"、"border-radius:10px"）
 * @param picStyleObj 待填充的样式对象
 */
function applyStyleProp(prop: string, picStyleObj: PicStyleObj): void {
  if (prop.length === 0) {
    return
  }
  // 查找分隔符（= 或 :），取最先出现的作为键值分隔
  const eqIdx = prop.indexOf('=')
  const colonIdx = prop.indexOf(':')
  let sepIdx = -1
  if (eqIdx >= 0 && colonIdx >= 0) {
    sepIdx = Math.min(eqIdx, colonIdx)
  } else if (eqIdx >= 0) {
    sepIdx = eqIdx
  } else if (colonIdx >= 0) {
    sepIdx = colonIdx
  } else {
    return
  }
  const key = prop.substring(0, sepIdx)
  const value = prop.substring(sepIdx + 1)
  if (key === 'width') {
    const w = parseStyleLength(value)
    if (w !== undefined) {
      picStyleObj.width = w
    }
  } else if (key === 'height') {
    const h = parseStyleLength(value)
    if (h !== undefined) {
      picStyleObj.height = h
    }
  } else if (key === 'border-radius') {
    if (value.endsWith('px')) {
      const num = Number.parseFloat(value.substring(0, value.length - 2))
      if (!Number.isNaN(num)) {
        picStyleObj.borderRadius = num
      }
    } else {
      const num = Number.parseFloat(value)
      if (!Number.isNaN(num)) {
        picStyleObj.borderRadius = num
      }
    }
  } else if (key === 'align') {
    if (value === 'left') {
      picStyleObj.align = HorizontalAlign.Start
    } else if (value === 'center') {
      picStyleObj.align = HorizontalAlign.Center
    } else if (value === 'right') {
      picStyleObj.align = HorizontalAlign.End
    }
  }
}

/**
 * 解析样式中的长度值（支持px和纯数字）
 *
 * @param value 长度字符串（如 "100px"、"100"）
 * @return 数值（px），解析失败返回undefined
 */
function parseStyleLength(value: string): number | undefined {
  if (value.length === 0) {
    return undefined
  }
  if (value.endsWith('px')) {
    const num = Number.parseFloat(value.substring(0, value.length - 2))
    if (!Number.isNaN(num)) {
      return num
    }
    return undefined
  }
  if (value.endsWith('%')) {
    // 百分比暂不支持，返回undefined
    return undefined
  }
  const num = Number.parseFloat(value)
  if (!Number.isNaN(num)) {
    return num
  }
  return undefined
}

