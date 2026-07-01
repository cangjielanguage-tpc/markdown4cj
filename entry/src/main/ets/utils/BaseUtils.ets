import { util } from "@kit.ArkTS";
import hilog from "@ohos.hilog";

/**
 * 文本颜色需要反转颜色，显示更清楚
 *
 * @param color 文本颜色颜色
 * @return 反转之后的颜色
 */
export function colorSwitch(color: number): number {
  switch (color) {
    case 0xFFE0E0E0:
      return 0xFF000000
    case 0xFFFFFFFF:
      return 0xFF000000
    case 0xFFEAEAEA:
      return 0xFF000000
    case 0xFFF5F5F5:
      return 0xFF000000
    default:
      return 0xFFFFFFFF
  }
}
/**
 * 文本颜色需要反转颜色，显示更清楚
 *
 * @param color 文本颜色颜色
 * @return 反转之后的颜色
 */
export function colorSwitch1(color: number): number {
  switch (color) {
    case 0xFF808080:
      return 0xFF000000
    default:
      return 0xFF808080
  }
}

/**
 * uint8Array转换成string
 */
export function uint8ArrayToString(array: Uint8Array) {
  let textDecoderOptions: util.TextDecoderOptions = {
    fatal: false,
    ignoreBOM: true
  }
  let decodeToStringOptions: util.DecodeToStringOptions = {
    stream: false
  }
  let textDecoder = util.TextDecoder.create('utf-8', textDecoderOptions);
  let retStr = textDecoder.decodeToString(array, decodeToStringOptions);
  return retStr;
}

/**
 * 颜色列表转换文本
 */
export function numberArrayToColorString(color: Array<number>): string {
  let returnString = ""
  for (let index = 0; index < color.length; index++) {
    returnString = returnString + numberToColorString(color[index]) + " ";
  }
  return returnString
}

/**
 * 颜色转换文本
 */
export function numberToColorString(color: number | undefined): string {
  switch (color) {
    case 0xFF000000:
      return "黑"
    case 0xFFFFFFFF:
      return "白"
    case 0xFFFF0000:
      return "红"
    case 0xFF00FF00:
      return "绿"
    case 0xFF0000FF:
      return "蓝"
    case 0xFFE0E0E0:
      return "银灰"
    case 0xFF333333:
      return "深灰"
    case 0xFF808080:
      return "灰"
    case 0xFFCCCCCC:
      return "浅灰"
    case 0xFF4CAF50:
      return "翠绿"
    case 0xFFFFC107:
      return "橙黄"
    case 0xFFF44336:
      return "鲜红"
    case 0xFF2196F3:
      return "天蓝"
    case 0xFF1976D2:
      return "深蓝"
    case 0xFFF5F5F5:
      return "烟白"
    case 0xFF191919:
      return "炭黑"
    case 0xFF00F5FF:
      return "绿松石"
    case 0xFF6A5ACD:
      return "板岩蓝"
    case 0xFF32CD32:
      return "酸橙绿"
    case 0xFFFFD700:
      return "金"
    case 0xFFFA8072:
      return "肉粉"
    case 0xFFEE82EE:
      return "紫罗兰"
    case 0xFF7EC0EE:
      return "天空蓝"
    case 0xFF8B0000:
      return "深红"
    case 0x00000000:
      return "透明"
    case undefined:
      return "null"
  }
  return ""
}

/**
 * 文本转换布尔值
 */
export function stringToBoolean(isFull: string): boolean {
  switch (isFull) {
    case "全量加载":
      return true
    case "增量加载":
      return false
  }
  return true
}

/**
 * 布尔值转换文本
 */
export function booleanToString(isFull: boolean): string {
  switch (isFull) {
    case true:
      return "全量加载"
    case false:
      return "增量加载"
  }
}

/**
 * 下划线样式转文本
 */
export function styleToString(style: TextDecorationStyle): string {
  switch (style) {
    case TextDecorationStyle.SOLID:
      return "单实线"
    case TextDecorationStyle.DOUBLE:
      return "双实线"
    case TextDecorationStyle.DOTTED:
      return "点线"
    case TextDecorationStyle.DASHED:
      return "虚线"
    case TextDecorationStyle.WAVY:
      return "波浪线"
    default :
      return "null"
  }
}

/**
 * 数学公式生成图片格式转文本
 */
// export function enumToString(e: LatexMathColorFormat): string {
//   switch (e) {
//     case LatexMathColorFormat.COLOR_FORMAT_RGB_565:
//       return "COLOR_FORMAT_RGB_565"
//     case LatexMathColorFormat.COLOR_FORMAT_BGRA_8888:
//       return "COLOR_FORMAT_BGRA_8888"
//     default :
//       return "null"
//   }
// }

/**
 * BorderStyle样式转文本
 */
export function borderStyleToString(style: BorderStyle): string {
  switch (style) {
    case BorderStyle.Solid:
      return "实线"
    case BorderStyle.Dashed:
      return "虚线"
    case BorderStyle.Dotted:
      return "点线"
    default:
      return "null"
  }
}

/**
 * FontStyle样式转文本
 */
export function fontStyleToString(style: FontStyle): string {
  switch (style) {
    case FontStyle.Normal:
      return "正常"
    case FontStyle.Italic:
      return "斜体"
    default:
      return "正常"
  }
}

/**
 * FontWeight样式转文本
 */
export function fontWeightToString(weight: FontWeight): string {
  switch (weight) {
    case FontWeight.Normal:
      return "正常"
    case FontWeight.Lighter:
      return "较细"
    case FontWeight.Medium:
      return "适中"
    case FontWeight.Regular:
      return "稍粗"
    case FontWeight.Bold:
      return "加粗"
    case FontWeight.Bolder:
      return "非常粗"
    default:
      return "正常"
  }
}

/**
 * TextDecorationType样式转文本
 */
export function decorationTypeToString(decorationType: TextDecorationType): string {
  switch (decorationType) {
    case TextDecorationType.None:
      return "无"
    case TextDecorationType.Underline:
      return "下划线"
    case TextDecorationType.LineThrough:
      return "删除线"
    case TextDecorationType.Overline:
      return "上划线"
    default:
      return "无"
  }
}

/**
 * ImageFit样式转文本
 */
export function imageFitToString(fitType: ImageFit): string {
  switch (fitType) {
    case ImageFit.Contain:
      return "Contain"
    case ImageFit.Cover:
      return "Cover"
    case ImageFit.Fill:
      return "Fill"
    case ImageFit.ScaleDown:
      return "ScaleDown"
    case ImageFit.None:
      return "None"
    default:
      return "Contain"
  }
}

/**
 * BarState样式转文本
 */
export function barStateToString(state: BarState): string {
  switch (state) {
    case BarState.Off:
      return "Off"
    case BarState.On:
      return "On"
    case BarState.Auto:
      return "Auto"
    default:
      return "Off"
  }
}

/**
 * 分割线端点样式转文本
 */
export function lineCapStyleToString(state: LineCapStyle): string {
  switch (state) {
    case LineCapStyle.Butt:
      return "平行线"
    case LineCapStyle.Round:
      return "半圆"
    case LineCapStyle.Square:
      return "延伸半圆"
    default:
      return "平行线"
  }
}

export function resToString(item: Resource | undefined): string {
  if (item !== undefined) {
    return item.id.toString()
  } else {
    return "undefined"
  }
}