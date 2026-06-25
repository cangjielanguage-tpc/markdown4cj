import { SECONDS_PER_HOUR, SECONDS_PER_MINUTE } from "../base/Constants"
import { NodeView } from "../model/NodeView"
import { BulletListTheme } from "../theme/BulletListTheme"
import { LengthMetrics } from "@kit.ArkUI"

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
export function listPrefixStr(item: NodeView, listDepth: number, isOrderList: boolean,
  bulletListTheme: BulletListTheme): string {
  if (isOrderList) {
    // 有序列表
    return `${item.orderedListNumber}.`
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

