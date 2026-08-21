import { JsNodeImpl } from "@cangjie-tpc/markdown_parser_hybrid/Index"
import {
  SECONDS_PER_HOUR,
  SECONDS_PER_MINUTE,
  NUM_FF000000,
  NUM_FFFFFFFF,
  NUM_00000000,
  NUM_FFC0C0C0,
  NUM_FF808080,
  NUM_FF800000,
  NUM_FFFF0000,
  NUM_FF800080,
  NUM_FFFF00FF,
  NUM_FF008000,
  NUM_FF00FF00,
  NUM_FF808000,
  NUM_FFFFFF00,
  NUM_FF000080,
  NUM_FF0000FF,
  NUM_FF008080,
  NUM_FF00FFFF,
  NUM_FFF0F8FF,
  NUM_FFFAEBD7,
  NUM_FF7FFFD4,
  NUM_FFF0FFFF,
  NUM_FFF5F5DC,
  NUM_FFFFE4C4,
  NUM_FF8A2BE2,
  NUM_FFA52A2A,
  NUM_FFDEB887,
  NUM_FF5F9EA0,
  NUM_FF7FFF00,
  NUM_FFD2691E,
  NUM_FFFF7F50,
  NUM_FF6495ED,
  NUM_FFFFF8DC,
  NUM_FFDC143C,
  NUM_FF00008B,
  NUM_FF008B8B,
  NUM_FFB8860B,
  NUM_FFA9A9A9,
  NUM_FF006400,
  NUM_FFBDB76B,
  NUM_FF8B008B,
  NUM_FF556B2F,
  NUM_FFFF8C00,
  NUM_FF9932CC,
  NUM_FF8B0000,
  NUM_FFE9967A,
  NUM_FF8FBC8F,
  NUM_FF483D8B,
  NUM_FF2F4F4F,
  NUM_FF00CED1,
  NUM_FF9400D3,
  NUM_FFFF1493,
  NUM_FF00BFFF,
  NUM_FF696969,
  NUM_FF1E90FF,
  NUM_FFB22222,
  NUM_FFFFFAF0,
  NUM_FF228B22,
  NUM_FFDCDCDC,
  NUM_FFF8F8FF,
  NUM_FFFFD700,
  NUM_FFDAA520,
  NUM_FFADFF2F,
  NUM_FFF0FFF0,
  NUM_FFFF69B4,
  NUM_FFCD5C5C,
  NUM_FF4B0082,
  NUM_FFFFFFF0,
  NUM_FFF0E68C,
  NUM_FFE6E6FA,
  NUM_FFFFF0F5,
  NUM_FF7CFC00,
  NUM_FFFFFACD,
  NUM_FFADD8E6,
  NUM_FFF08080,
  NUM_FFE0FFFF,
  NUM_FFFAFAD2,
  NUM_FFD3D3D3,
  NUM_FF90EE90,
  NUM_FFFFB6C1,
  NUM_FFFFA07A,
  NUM_FF20B2AA,
  NUM_FF87CEFA,
  NUM_FF778899,
  NUM_FFB0C4DE,
  NUM_FFFFFFE0,
  NUM_FF32CD32,
  NUM_FFFAF0E6,
  NUM_FF66CDAA,
  NUM_FF0000CD,
  NUM_FFBA55D3,
  NUM_FF9370DB,
  NUM_FF3CB371,
  NUM_FF7B68EE,
  NUM_FF00FA9A,
  NUM_FF48D1CC,
  NUM_FFC71585,
  NUM_FF191970,
  NUM_FFF5FFFA,
  NUM_FFFFE4E1,
  NUM_FFFFE4B5,
  NUM_FFFFDEAD,
  NUM_FFFDF5E6,
  NUM_FF6B8E23,
  NUM_FFFFA500,
  NUM_FFFF4500,
  NUM_FFDA70D6,
  NUM_FFEEE8AA,
  NUM_FF98FB98,
  NUM_FFAFEEEE,
  NUM_FFDB7093,
  NUM_FFFFEFD5,
  NUM_FFFFDAB9,
  NUM_FFCD853F,
  NUM_FFFFC0CB,
  NUM_FFDDA0DD,
  NUM_FFB0E0E6,
  NUM_FFBC8F8F,
  NUM_FF4169E1,
  NUM_FF8B4513,
  NUM_FFFA8072,
  NUM_FFF4A460,
  NUM_FF2E8B57,
  NUM_FFFFF5EE,
  NUM_FFA0522D,
  NUM_FF87CEEB,
  NUM_FF6A5ACD,
  NUM_FF708090,
  NUM_FFFFFAFA,
  NUM_FF00FF7F,
  NUM_FF4682B4,
  NUM_FFD2B48C,
  NUM_FFD8BFD8,
  NUM_FFFF6347,
  NUM_FF40E0D0,
  NUM_FFEE82EE,
  NUM_FFF5DEB3,
  NUM_FFF5F5F5,
  NUM_FF9ACD32
} from "../base/Constants"
import { BulletListTheme } from "../theme/BulletListTheme"
import { hilog } from "@kit.PerformanceAnalysisKit"

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
    case "RIGHT":
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
  const t = Math.floor(totalSeconds)
  const hours = Math.floor(t / SECONDS_PER_HOUR)
  const minutes = Math.floor((t % SECONDS_PER_HOUR) / SECONDS_PER_MINUTE)
  const seconds = t % SECONDS_PER_MINUTE
  const strHours = String(hours).padStart(2, '0')
  const strMinutes = String(minutes).padStart(2, '0')
  const strSeconds = String(seconds).padStart(2, '0')
  return `${strHours}:${strMinutes}:${strSeconds}`
}

/**
 * 有序/无序前缀文本内容
 *
 * @param index 序号
 * @param listDepth 列表深度
 * @param isOrderList 是否是有序列表
 * @param bulletListTheme 无序列表样式
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
  if (listDepth === 0) {
    return `${solidCircleToUnicode()}`
  }
  if (listDepth === 1) {
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
 * 处理图片URL，若为相对路径（./开头）则转换为rawfile资源
 *
 * @param url 图片URL，可选
 * @return ResourceStr资源或undefined
 */
export function imageUrlHandle(url?: string): ResourceStr | undefined {
  if (url?.startsWith("./")) {
    return $rawfile(url.substring(2))
  } else {
    return url
  }
}

/**
 * 处理图片的宽高
 *
 * @param componentImageWidth 控件宽度（vp，函数内部会转成px）
 * @param imageResWidth 图片真实宽度（px）
 * @param imageResHeight 图片真实高度（px）
 * @param imageWidthPx 图片设置宽度（px）
 * @param imageHeightPx 图片设置高度（px）
 * @param imageMaxWidth 图片最大宽度（vp，函数内部会转成px）
 * @param imageMaxHeight 图片最大高度（vp，函数内部会转成px）
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
  const componentImageWidthPx = vp2px(componentImageWidth)
  const componentImageWidthNew = (imageMaxWidth !== undefined)
    ? Math.min(vp2px(imageMaxWidth), componentImageWidthPx)
    : componentImageWidthPx
  const imageMaxHeightPx = (imageMaxHeight !== undefined) ? vp2px(imageMaxHeight) : undefined
  if (!(imageResWidth > 0) || !(imageResHeight > 0)) {
    return [0, 0]
  }
  const aspectRatio: number = imageResHeight / imageResWidth
  if (imageWidthPx !== undefined && imageHeightPx !== undefined) {
    const aspectRatioNew: number = imageWidthPx > 0 ? imageHeightPx / imageWidthPx : aspectRatio
    let widthNew = (imageFixedRatioWidth !== undefined)
      ? componentImageWidthPx * imageFixedRatioWidth
      : Math.min(imageWidthPx, componentImageWidthNew) * imageMaximumWidth
    widthNew = Math.min(widthNew, componentImageWidthNew)
    let heightNew: number = widthNew * aspectRatioNew
    if (imageMaxHeightPx !== undefined) {
      if (heightNew < imageMaxHeightPx) {
        width = widthNew
        height = heightNew
      } else if (heightNew > 0) {
        const aspectRatioHeightNew = imageMaxHeightPx / heightNew
        width = widthNew * aspectRatioHeightNew
        height = imageMaxHeightPx
      } else {
        width = 0
        height = 0
      }
    } else {
      width = widthNew
      height = heightNew
    }
  } else if (imageWidthPx !== undefined && imageHeightPx === undefined) {
    let widthNew = (imageFixedRatioWidth !== undefined)
      ? componentImageWidthPx * imageFixedRatioWidth
      : Math.min(imageWidthPx, componentImageWidthNew) * imageMaximumWidth
    widthNew = Math.min(widthNew, componentImageWidthNew)
    let heightNew: number = widthNew * aspectRatio
    if (imageMaxHeightPx !== undefined) {
      if (heightNew < imageMaxHeightPx) {
        width = widthNew
        height = heightNew
      } else if (heightNew > 0) {
        const aspectRatioHeightNew = imageMaxHeightPx / heightNew
        width = widthNew * aspectRatioHeightNew
        height = imageMaxHeightPx
      } else {
        width = 0
        height = 0
      }
    } else {
      width = widthNew
      height = heightNew
    }
  } else if (imageWidthPx === undefined && imageHeightPx !== undefined) {
    let widthNew = (imageFixedRatioWidth !== undefined)
      ? componentImageWidthPx * imageFixedRatioWidth
      : Math.min(imageHeightPx / aspectRatio, componentImageWidthNew) * imageMaximumWidth
    widthNew = Math.min(widthNew, componentImageWidthNew)
    let heightNew: number = widthNew * aspectRatio
    if (imageMaxHeightPx !== undefined) {
      if (heightNew < imageMaxHeightPx) {
        width = widthNew
        height = heightNew
      } else if (heightNew > 0) {
        const aspectRatioHeightNew = imageMaxHeightPx / heightNew
        width = widthNew * aspectRatioHeightNew
        height = imageMaxHeightPx
      } else {
        width = 0
        height = 0
      }
    } else {
      width = widthNew
      height = heightNew
    }
  } else {
    let widthNew = (imageFixedRatioWidth !== undefined)
      ? componentImageWidthPx * imageFixedRatioWidth
      : Math.min(imageResWidth, componentImageWidthNew) * imageMaximumWidth
    widthNew = Math.min(widthNew, componentImageWidthNew)
    let heightNew: number = widthNew * aspectRatio
    if (imageMaxHeightPx !== undefined) {
      if (heightNew < imageMaxHeightPx) {
        width = widthNew
        height = heightNew
      } else if (heightNew > 0) {
        const aspectRatioHeightNew = imageMaxHeightPx / heightNew
        width = widthNew * aspectRatioHeightNew
        height = imageMaxHeightPx
      } else {
        width = 0
        height = 0
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
  if (str === undefined) {
    return undefined
  }
  if (str.length === 0) {
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
 * 将Length类型转换为数值（vp）
 * number直接返回，string通过strToLengthNumber解析，Resource无法同步转换返回undefined
 *
 * @param length Length值
 * @return 数值（vp），无法转换返回undefined
 */
export function lengthToVpNumber(length: Length): number | undefined {
  if (typeof length === 'number') {
    return length
  }
  if (typeof length === 'string') {
    return strToLengthNumber(length)
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
    case 'black':
      return NUM_FF000000
    case 'silver':
      return NUM_FFC0C0C0
    case 'gray':
      return NUM_FF808080
    case 'grey':
      return NUM_FF808080
    case 'white':
      return NUM_FFFFFFFF
    case 'maroon':
      return NUM_FF800000
    case 'red':
      return NUM_FFFF0000
    case 'purple':
      return NUM_FF800080
    case 'fuchsia':
      return NUM_FFFF00FF
    case 'green':
      return NUM_FF008000
    case 'lime':
      return NUM_FF00FF00
    case 'olive':
      return NUM_FF808000
    case 'yellow':
      return NUM_FFFFFF00
    case 'navy':
      return NUM_FF000080
    case 'blue':
      return NUM_FF0000FF
    case 'teal':
      return NUM_FF008080
    case 'aqua':
      return NUM_FF00FFFF
    case 'cyan':
      return NUM_FF00FFFF
    // 扩展色
    case 'aliceblue':
      return NUM_FFF0F8FF
    case 'antiquewhite':
      return NUM_FFFAEBD7
    case 'aquamarine':
      return NUM_FF7FFFD4
    case 'azure':
      return NUM_FFF0FFFF
    case 'beige':
      return NUM_FFF5F5DC
    case 'bisque':
      return NUM_FFFFE4C4
    case 'blueviolet':
      return NUM_FF8A2BE2
    case 'brown':
      return NUM_FFA52A2A
    case 'burlywood':
      return NUM_FFDEB887
    case 'cadetblue':
      return NUM_FF5F9EA0
    case 'chartreuse':
      return NUM_FF7FFF00
    case 'chocolate':
      return NUM_FFD2691E
    case 'coral':
      return NUM_FFFF7F50
    case 'cornflowerblue':
      return NUM_FF6495ED
    case 'cornsilk':
      return NUM_FFFFF8DC
    case 'crimson':
      return NUM_FFDC143C
    case 'darkblue':
      return NUM_FF00008B
    case 'darkcyan':
      return NUM_FF008B8B
    case 'darkgoldenrod':
      return NUM_FFB8860B
    case 'darkgray':
      return NUM_FFA9A9A9
    case 'darkgreen':
      return NUM_FF006400
    case 'darkkhaki':
      return NUM_FFBDB76B
    case 'darkmagenta':
      return NUM_FF8B008B
    case 'darkolivegreen':
      return NUM_FF556B2F
    case 'darkorange':
      return NUM_FFFF8C00
    case 'darkorchid':
      return NUM_FF9932CC
    case 'darkred':
      return NUM_FF8B0000
    case 'darksalmon':
      return NUM_FFE9967A
    case 'darkseagreen':
      return NUM_FF8FBC8F
    case 'darkslateblue':
      return NUM_FF483D8B
    case 'darkslategray':
      return NUM_FF2F4F4F
    case 'darkturquoise':
      return NUM_FF00CED1
    case 'darkviolet':
      return NUM_FF9400D3
    case 'deeppink':
      return NUM_FFFF1493
    case 'deepskyblue':
      return NUM_FF00BFFF
    case 'dimgray':
      return NUM_FF696969
    case 'dodgerblue':
      return NUM_FF1E90FF
    case 'firebrick':
      return NUM_FFB22222
    case 'floralwhite':
      return NUM_FFFFFAF0
    case 'forestgreen':
      return NUM_FF228B22
    case 'gainsboro':
      return NUM_FFDCDCDC
    case 'ghostwhite':
      return NUM_FFF8F8FF
    case 'gold':
      return NUM_FFFFD700
    case 'goldenrod':
      return NUM_FFDAA520
    case 'greenyellow':
      return NUM_FFADFF2F
    case 'honeydew':
      return NUM_FFF0FFF0
    case 'hotpink':
      return NUM_FFFF69B4
    case 'indianred':
      return NUM_FFCD5C5C
    case 'indigo':
      return NUM_FF4B0082
    case 'ivory':
      return NUM_FFFFFFF0
    case 'khaki':
      return NUM_FFF0E68C
    case 'lavender':
      return NUM_FFE6E6FA
    case 'lavenderblush':
      return NUM_FFFFF0F5
    case 'lawngreen':
      return NUM_FF7CFC00
    case 'lemonchiffon':
      return NUM_FFFFFACD
    case 'lightblue':
      return NUM_FFADD8E6
    case 'lightcoral':
      return NUM_FFF08080
    case 'lightcyan':
      return NUM_FFE0FFFF
    case 'lightgoldenrodyellow':
      return NUM_FFFAFAD2
    case 'lightgray':
      return NUM_FFD3D3D3
    case 'lightgreen':
      return NUM_FF90EE90
    case 'lightpink':
      return NUM_FFFFB6C1
    case 'lightsalmon':
      return NUM_FFFFA07A
    case 'lightseagreen':
      return NUM_FF20B2AA
    case 'lightskyblue':
      return NUM_FF87CEFA
    case 'lightslategray':
      return NUM_FF778899
    case 'lightsteelblue':
      return NUM_FFB0C4DE
    case 'lightyellow':
      return NUM_FFFFFFE0
    case 'limegreen':
      return NUM_FF32CD32
    case 'linen':
      return NUM_FFFAF0E6
    case 'magenta':
      return NUM_FFFF00FF
    case 'mediumaquamarine':
      return NUM_FF66CDAA
    case 'mediumblue':
      return NUM_FF0000CD
    case 'mediumorchid':
      return NUM_FFBA55D3
    case 'mediumpurple':
      return NUM_FF9370DB
    case 'mediumseagreen':
      return NUM_FF3CB371
    case 'mediumslateblue':
      return NUM_FF7B68EE
    case 'mediumspringgreen':
      return NUM_FF00FA9A
    case 'mediumturquoise':
      return NUM_FF48D1CC
    case 'mediumvioletred':
      return NUM_FFC71585
    case 'midnightblue':
      return NUM_FF191970
    case 'mintcream':
      return NUM_FFF5FFFA
    case 'mistyrose':
      return NUM_FFFFE4E1
    case 'moccasin':
      return NUM_FFFFE4B5
    case 'navajowhite':
      return NUM_FFFFDEAD
    case 'oldlace':
      return NUM_FFFDF5E6
    case 'olivedrab':
      return NUM_FF6B8E23
    case 'orange':
      return NUM_FFFFA500
    case 'orangered':
      return NUM_FFFF4500
    case 'orchid':
      return NUM_FFDA70D6
    case 'palegoldenrod':
      return NUM_FFEEE8AA
    case 'palegreen':
      return NUM_FF98FB98
    case 'paleturquoise':
      return NUM_FFAFEEEE
    case 'palevioletred':
      return NUM_FFDB7093
    case 'papayawhip':
      return NUM_FFFFEFD5
    case 'peachpuff':
      return NUM_FFFFDAB9
    case 'peru':
      return NUM_FFCD853F
    case 'pink':
      return NUM_FFFFC0CB
    case 'plum':
      return NUM_FFDDA0DD
    case 'powderblue':
      return NUM_FFB0E0E6
    case 'rosybrown':
      return NUM_FFBC8F8F
    case 'royalblue':
      return NUM_FF4169E1
    case 'saddlebrown':
      return NUM_FF8B4513
    case 'salmon':
      return NUM_FFFA8072
    case 'sandybrown':
      return NUM_FFF4A460
    case 'seagreen':
      return NUM_FF2E8B57
    case 'seashell':
      return NUM_FFFFF5EE
    case 'sienna':
      return NUM_FFA0522D
    case 'skyblue':
      return NUM_FF87CEEB
    case 'slateblue':
      return NUM_FF6A5ACD
    case 'slategray':
      return NUM_FF708090
    case 'snow':
      return NUM_FFFFFAFA
    case 'springgreen':
      return NUM_FF00FF7F
    case 'steelblue':
      return NUM_FF4682B4
    case 'tan':
      return NUM_FFD2B48C
    case 'thistle':
      return NUM_FFD8BFD8
    case 'tomato':
      return NUM_FFFF6347
    case 'turquoise':
      return NUM_FF40E0D0
    case 'violet':
      return NUM_FFEE82EE
    case 'wheat':
      return NUM_FFF5DEB3
    case 'whitesmoke':
      return NUM_FFF5F5F5
    case 'yellowgreen':
      return NUM_FF9ACD32
    // HarmonyOS Color枚举
    case 'transparent':
      return NUM_00000000
    default:
      return undefined
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
      return num >>> 0
    }
    return undefined
  }
  // 3. #RRGGBB 或 #AARRGGBB 格式（如 "#FF0000"、"#FF0000FF"）
  if (colorStr.startsWith('#')) {
    const hex = colorStr.substring(1)
    if (isHexString(hex)) {
      if (hex.length === 6) {
        // #RRGGBB → 补 FF alpha
        return (NUM_FF000000 | Number.parseInt(hex, 16)) >>> 0
      } else if (hex.length === 8) {
        // #AARRGGBB
        return Number.parseInt(hex, 16) >>> 0
      } else if (hex.length === 3) {
        // #RGB → #RRGGBB
        const expanded = expandHex3(hex)
        return (NUM_FF000000 | Number.parseInt(expanded, 16)) >>> 0
      }
    }
    return undefined
  }
  // 4. 纯数字（如 "123"）按十进制处理
  const num = Number.parseInt(colorStr, 10)
  if (!Number.isNaN(num)) {
    return num >>> 0
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
    if (str === undefined || str === null) {
      continue
    }
    if (str.length === 0) {
      continue
    }
    try {
      // 去除空格、引号、花括号，转小写
      let style = str.replace(/ /g, '')
        .replace(/"/g, '')
        .replace(/'/g, '')
        .replace(/{/g, '')
        .replace(/}/g, '')
        .toLowerCase()
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
      console.error('parsePicStyle parse error: ' + JSON.stringify(e))
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
 * @return 数值（vp），解析失败返回undefined
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

/**
 * URL-safe Base64解码
 *
 * 将URL-safe Base64（使用_和-）转换为标准Base64后解码为UTF-8字符串。
 * 用于解析非HTTP链接URL中编码的文件类型信息。
 *
 * @param v URL-safe Base64字符串
 * @return 解码后提取的文件扩展名（大写），无法提取时返回空字符串
 */
export function urlSafeBase64Decode(v: string): string {
  try {
    let vNew = v.replaceAll('_', '/').replaceAll('-', '+')
    // 补齐Base64填充
    const pad = vNew.length % 4
    if (pad === 1) {
      return ''
    }
    if (pad === 2) {
      vNew += '=='
    } else if (pad === 3) {
      vNew += '='
    }
    // Base64解码
    const decoded = base64Decode(vNew)
    // 查找file-name=xxx.yyy模式
    const match = decoded.match(/file-name=([^&]+)/)
    if (match === null) {
      return ''
    }
    if (match.length > 1) {
      if (match[1] !== undefined) {
        const parts = match[1].split('.')
        if (parts.length > 1) {
          return parts[parts.length - 1].toUpperCase()
        }
      }
    }
    return ''
  } catch (e) {
    console.error('getFileExtensionFromUrl failed: ' + JSON.stringify(e))
    return ''
  }
}

/**
 * 纯TypeScript Base64解码（UTF-8/ASCII）
 *
 * @param input 标准Base64字符串
 * @return 解码后的字符串
 */
function base64Decode(input: string): string {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  let str = input.replace(/[^A-Za-z0-9+/=]/g, '')
  const bytes: number[] = []

  for (let i = 0; i < str.length; i += 4) {
    const a = chars.indexOf(str.charAt(i))
    const b = chars.indexOf(str.charAt(i + 1))
    const cChar = str.charAt(i + 2)
    const dChar = str.charAt(i + 3)
    const c = cChar === '=' ? -1 : chars.indexOf(cChar)
    const d = dChar === '=' ? -1 : chars.indexOf(dChar)

    if (a === -1 || b === -1) {
      break
    }

    const n = (a << 18) | (b << 12) | ((c !== -1 ? c : 0) << 6) | (d !== -1 ? d : 0)

    bytes.push((n >> 16) & 0xFF)
    if (c !== -1) {
      bytes.push((n >> 8) & 0xFF)
    }
    if (d !== -1) {
      bytes.push(n & 0xFF)
    }
  }

  // 将字节数组转为字符串（兼容UTF-8多字节字符）
  const parts: string[] = []
  let i = 0
  while (i < bytes.length) {
    const b = bytes[i]
    if (b < 0x80) {
      parts.push(String.fromCharCode(b))
      i++
    } else if (b < 0xC0) {
      // 无效的UTF-8起始字节，跳过
      i++
    } else if (b < 0xE0) {
      if (i + 1 < bytes.length) {
        const c2 = bytes[i + 1]
        parts.push(String.fromCharCode(((b & 0x1F) << 6) | (c2 & 0x3F)))
        i += 2
      } else {
        i++
      }
    } else if (b < 0xF0) {
      if (i + 2 < bytes.length) {
        const c2 = bytes[i + 1]
        const c3 = bytes[i + 2]
        parts.push(String.fromCharCode(((b & 0x0F) << 12) | ((c2 & 0x3F) << 6) | (c3 & 0x3F)))
        i += 3
      } else {
        i++
      }
    } else {
      if (i + 3 < bytes.length) {
        const c2 = bytes[i + 1]
        const c3 = bytes[i + 2]
        const c4 = bytes[i + 3]
        const cp = ((b & 0x07) << 18) | ((c2 & 0x3F) << 12) | ((c3 & 0x3F) << 6) | (c4 & 0x3F)
        // 转为UTF-16代理对
        const offset = cp - 0x10000
        parts.push(String.fromCharCode(0xD800 + (offset >> 10)))
        parts.push(String.fromCharCode(0xDC00 + (offset & 0x3FF)))
        i += 4
      } else {
        i++
      }
    }
  }

  return parts.join("")
}

export function safeString(str: string | null | undefined): string {
  if (str === null || str === undefined) {
    return "";
  }
  return str;
}

export function printNodes(node: JsNodeImpl| null | undefined) {
  if(node !== null && node != undefined){
    let current = node
    while (current.parent !== null && current.parent != undefined){
      current = current.parent
    }
    let builder:String = ""
    printNode2(current, 0, builder)
  }
}

 function printNode2(node: JsNodeImpl| null | undefined, depth: number, builder: String) {
  if(node !== null && node != undefined){
    let str = (node.nodeType+"---"+node.toStr).toString().replace("\n","\\n")
    builder = dealWithBuilder(builder,depth,str)
    let child = node.firstChild
    printNode2(child,depth+4,builder)
    let next = node.next
    printNode2(next,depth,builder)
  }
}

function dealWithBuilder(builder:String,depth:number,str:String):string{
  for(let i = 0;i<depth;i++){
    builder = builder+" "
  }
  let res = builder.toString()+str+"\n"
  return res
}

