import { MarkdownBaseTheme } from './MarkdownBaseTheme'
import { COLOR_FF191919, isMargin, isPadding } from "../base/Constants"

/**
 * 有序列表样式配置
 */
@Observed
export class OrderedListTheme implements MarkdownBaseTheme {
  orderedListBackgroundColor: ResourceColor | undefined = undefined // 有序列表背景颜色
  orderedListMarginTop: Length = 0.0 // 有序列表外边距上
  orderedListMarginRight: Length = 0.0 // 有序列表外边距右
  orderedListMarginBottom: Length = 0.0 // 有序列表外边距下
  orderedListMarginLeft: Length = 8.0 // 有序列表外边距左
  orderedListPaddingTop: Length = 0.0 // 有序列表内边距上
  orderedListPaddingRight: Length = 0.0 // 有序列表内边距右
  orderedListPaddingBottom: Length = 0.0 // 有序列表内边距下
  orderedListPaddingLeft: Length = 0.0 // 有序列表内边距左
  orderedListChildSpacing: number = 8 // 有序列表子项间距
  orderedListChildChildSpacing: number = 8 // 有序列表子子项间距
  orderedListMarkerSpacing: number = 8.0 // 有序列表标记间距
  orderedListMarkerTextFontColor: ResourceColor = COLOR_FF191919 // 有序列表标记文本字体颜色
  orderedListMarkerTextFontSize: number | string | Resource = 14.0 // 有序列表标记文本字体大小
  orderedListMarkerTextFontStyle: FontStyle = FontStyle.Normal // 有序列表标记文本字体样式
  orderedListMarkerTextFontWeight: number | FontWeight = FontWeight.Normal // 有序列表标记文本字体粗细
  orderedListMarkerTextFontFamily: string | Resource = 'HarmonyOS Sans' // 有序列表标记文本字体族
  orderedListMarkerTextLineHeight: number | string | Resource = 22.0 // 有序列表标记文本行高

  /**
   * 设置有序列表背景颜色
   *
   * @param color 有序列表背景颜色
   * @return OrderedListTheme
   */
  setOrderedListBackgroundColor(color: ResourceColor): OrderedListTheme {
    this.orderedListBackgroundColor = color
    return this
  }

  /**
   * 设置有序列表外边距
   *
   * @param options 有序列表外边距选项或统一数值
   * @return OrderedListTheme
   */
  setOrderedListMargin(options: Margin | Length): OrderedListTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.orderedListMarginTop = options
      this.orderedListMarginRight = options
      this.orderedListMarginBottom = options
      this.orderedListMarginLeft = options
    }
    // 2. 如果是 object，它要么是 Margin，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Margin 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Margin 处理
      if (isMargin(options)) {
        const margin = options as Margin
        if (margin.top !== undefined) {
          this.orderedListMarginTop = margin.top
        }
        if (margin.right !== undefined) {
          this.orderedListMarginRight = margin.right
        }
        if (margin.bottom !== undefined) {
          this.orderedListMarginBottom = margin.bottom
        }
        if (margin.left !== undefined) {
          this.orderedListMarginLeft = margin.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.orderedListMarginTop = options as Length
        this.orderedListMarginRight = options as Length
        this.orderedListMarginBottom = options as Length
        this.orderedListMarginLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置有序列表内边距
   *
   * @param options 有序列表内边距选项或统一数值
   * @return OrderedListTheme
   */
  setOrderedListPadding(options: Padding | Length): OrderedListTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.orderedListPaddingTop = options
      this.orderedListPaddingRight = options
      this.orderedListPaddingBottom = options
      this.orderedListPaddingLeft = options
    }
    // 2. 如果是 object，它要么是 Padding，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Padding 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Padding 处理
      if (isPadding(options)) {
        const padding = options as Padding
        if (padding.top !== undefined) {
          this.orderedListPaddingTop = padding.top
        }
        if (padding.right !== undefined) {
          this.orderedListPaddingRight = padding.right
        }
        if (padding.bottom !== undefined) {
          this.orderedListPaddingBottom = padding.bottom
        }
        if (padding.left !== undefined) {
          this.orderedListPaddingLeft = padding.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.orderedListPaddingTop = options as Length
        this.orderedListPaddingRight = options as Length
        this.orderedListPaddingBottom = options as Length
        this.orderedListPaddingLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置有序列表子项间距
   *
   * @param spacing 有序列表子项间距
   * @return OrderedListTheme
   */
  setOrderedListChildSpacing(spacing: number): OrderedListTheme {
    this.orderedListChildSpacing = spacing
    return this
  }

  /**
   * 设置有序列表子子项间距
   *
   * @param spacing 有序列表子子项间距
   * @return OrderedListTheme
   */
  setOrderedListChildChildSpacing(spacing: number): OrderedListTheme {
    this.orderedListChildChildSpacing = spacing
    return this
  }

  /**
   * 设置有序列表标记间距
   *
   * @param spacing 有序列表标记间距
   * @return OrderedListTheme
   */
  setOrderedListMarkerSpacing(spacing: number): OrderedListTheme {
    this.orderedListMarkerSpacing = spacing
    return this
  }

  /**
   * 设置有序列表标记文本字体颜色
   *
   * @param color 有序列表标记文本字体颜色
   * @return OrderedListTheme
   */
  setOrderedListMarkerTextFontColor(color: ResourceColor): OrderedListTheme {
    this.orderedListMarkerTextFontColor = color
    return this
  }

  /**
   * 设置有序列表标记文本字体大小
   *
   * @param size 有序列表标记文本字体大小
   * @return OrderedListTheme
   */
  setOrderedListMarkerTextFontSize(size: number | string | Resource): OrderedListTheme {
    this.orderedListMarkerTextFontSize = size
    return this
  }

  /**
   * 设置有序列表标记文本字体样式
   *
   * @param style 有序列表标记文本字体样式
   * @return OrderedListTheme
   */
  setOrderedListMarkerTextFontStyle(style: FontStyle): OrderedListTheme {
    this.orderedListMarkerTextFontStyle = style
    return this
  }

  /**
   * 设置有序列表标记文本字体粗细
   *
   * @param weight 有序列表标记文本字体粗细
   * @return OrderedListTheme
   */
  setOrderedListMarkerTextFontWeight(weight: number | FontWeight): OrderedListTheme {
    this.orderedListMarkerTextFontWeight = weight
    return this
  }

  /**
   * 设置有序列表标记文本字体族
   *
   * @param family 有序列表标记文本字体族
   * @return OrderedListTheme
   */
  setOrderedListMarkerTextFontFamily(family: string | Resource): OrderedListTheme {
    this.orderedListMarkerTextFontFamily = family
    return this
  }

  /**
   * 设置有序列表标记文本行高
   *
   * @param lineHeight 有序列表标记文本行高
   * @return OrderedListTheme
   */
  setOrderedListMarkerTextLineHeight(lineHeight: number | string | Resource): OrderedListTheme {
    this.orderedListMarkerTextLineHeight = lineHeight
    return this
  }
}
