import { MarkdownBaseTheme } from './MarkdownBaseTheme'
import { COLOR_FF191919, isMargin, isPadding } from "../base/Constants"

/**
 * 分割线样式配置
 */
@Observed
export class DividerTheme implements MarkdownBaseTheme {
  dividerMarginTop: Length = 0.0 // 分割线上外边距
  dividerMarginRight: Length = 0.0 // 分割线右外边距
  dividerMarginBottom: Length = 0.0 // 分割线下外边距
  dividerMarginLeft: Length = 0.0 // 分割线左外边距
  dividerPaddingTop: Length = 0.0 // 分割线上内边距
  dividerPaddingRight: Length = 0.0 // 分割线右内边距
  dividerPaddingBottom: Length = 0.0 // 分割线下内边距
  dividerPaddingLeft: Length = 0.0 // 分割线左内边距
  dividerColor: ResourceColor = COLOR_FF191919 // 分割线颜色
  dividerStrokeWidth: number = 0.5 // 分割线线条宽度
  dividerStyle: LineCapStyle = LineCapStyle.Butt // 分割线样式

  /**
   * 设置分割线外边距
   *
   * @param options 分割线外边距选项或统一数值
   * @return DividerTheme
   */
  setDividerMargin(options: Margin | Length): DividerTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.dividerMarginTop = options
      this.dividerMarginRight = options
      this.dividerMarginBottom = options
      this.dividerMarginLeft = options
    }
    // 2. 如果是 object，它要么是 Margin，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Margin 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Margin 处理
      if (isMargin(options)) {
        const margin = options as Margin
        if (margin.top !== undefined) {
          this.dividerMarginTop = margin.top
        }
        if (margin.right !== undefined) {
          this.dividerMarginRight = margin.right
        }
        if (margin.bottom !== undefined) {
          this.dividerMarginBottom = margin.bottom
        }
        if (margin.left !== undefined) {
          this.dividerMarginLeft = margin.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.dividerMarginTop = options as Length
        this.dividerMarginRight = options as Length
        this.dividerMarginBottom = options as Length
        this.dividerMarginLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置分割线内边距
   *
   * @param options 分割线内边距选项或统一数值
   * @return DividerTheme
   */
  setDividerPadding(options: Padding | Length): DividerTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.dividerPaddingTop = options
      this.dividerPaddingRight = options
      this.dividerPaddingBottom = options
      this.dividerPaddingLeft = options
    }
    // 2. 如果是 object，它要么是 Padding，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Padding 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Padding 处理
      if (isPadding(options)) {
        const padding = options as Padding
        if (padding.top !== undefined) {
          this.dividerPaddingTop = padding.top
        }
        if (padding.right !== undefined) {
          this.dividerPaddingRight = padding.right
        }
        if (padding.bottom !== undefined) {
          this.dividerPaddingBottom = padding.bottom
        }
        if (padding.left !== undefined) {
          this.dividerPaddingLeft = padding.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.dividerPaddingTop = options as Length
        this.dividerPaddingRight = options as Length
        this.dividerPaddingBottom = options as Length
        this.dividerPaddingLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置分割线颜色
   *
   * @param color 分割线颜色
   * @return DividerTheme
   */
  setDividerColor(color: ResourceColor): DividerTheme {
    this.dividerColor = color
    return this
  }

  /**
   * 设置分割线线条宽度
   *
   * @param strokeWidth 分割线线条宽度
   * @return DividerTheme
   */
  setDividerStrokeWidth(strokeWidth: number): DividerTheme {
    this.dividerStrokeWidth = strokeWidth
    return this
  }

  /**
   * 设置分割线样式
   *
   * @param style 分割线样式
   * @return DividerTheme
   */
  setDividerStyle(style: LineCapStyle): DividerTheme {
    this.dividerStyle = style
    return this
  }
}
