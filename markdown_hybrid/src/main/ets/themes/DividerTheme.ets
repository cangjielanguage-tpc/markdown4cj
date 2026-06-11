import { MarkdownMarginOptions, MarkdownPaddingOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-分割线样式
 */
export class DividerTheme {
  /**
   * 分割线上外边距
   */
  private dividerMarginTop?: number = undefined

  /**
   * 分割线右外边距
   */
  private dividerMarginRight?: number = undefined

  /**
   * 分割线下外边距
   */
  private dividerMarginBottom?: number = undefined

  /**
   * 分割线左外边距
   */
  private dividerMarginLeft?: number = undefined

  /**
   * 分割线上内边距
   */
  private dividerPaddingTop?: number = undefined

  /**
   * 分割线右内边距
   */
  private dividerPaddingRight?: number = undefined

  /**
   * 分割线下内边距
   */
  private dividerPaddingBottom?: number = undefined

  /**
   * 分割线左内边距
   */
  private dividerPaddingLeft?: number = undefined

  /**
   * 分割线颜色
   */
  private dividerColor?: number = undefined

  /**
   * 分割线宽度
   */
  private dividerStrokeWidth?: number = undefined

  /**
   * 分割线端点样式
   */
  private dividerStyle?: LineCapStyle = undefined

  /**
   * 分割线设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setDividerMargin(options: MarkdownMarginOptions | number): DividerTheme {
    if (typeof options === "number") {
      this.dividerMarginTop = options
      this.dividerMarginRight = options
      this.dividerMarginBottom = options
      this.dividerMarginLeft = options
    } else {
      if (options.top !== undefined) {
        this.dividerMarginTop = options.top
      }
      if (options.right !== undefined) {
        this.dividerMarginRight = options.right
      }
      if (options.bottom !== undefined) {
        this.dividerMarginBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.dividerMarginLeft = options.left
      }
    }
    return this
  }

  /**
   * 分割线设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setDividerPadding(options: MarkdownPaddingOptions | number): DividerTheme {
    if (typeof options === "number") {
      this.dividerPaddingTop = options
      this.dividerPaddingRight = options
      this.dividerPaddingBottom = options
      this.dividerPaddingLeft = options
    } else {
      if (options.top !== undefined) {
        this.dividerPaddingTop = options.top
      }
      if (options.right !== undefined) {
        this.dividerPaddingRight = options.right
      }
      if (options.bottom !== undefined) {
        this.dividerPaddingBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.dividerPaddingLeft = options.left
      }
    }
    return this
  }

  /**
   * 设置分割线颜色
   *
   * @param color 分割线颜色
   */
  setDividerColor(color: number): DividerTheme {
    this.dividerColor = color
    return this
  }

  /**
   * 设置分割线宽度
   *
   * @param strokeWidth 分割线宽度
   */
  setDividerStrokeWidth(strokeWidth: number): DividerTheme {
    this.dividerStrokeWidth = strokeWidth
    return this
  }

  /**
   * 设置分割线端点样式
   *
   * @param style 分割线端点样式
   */
  setDividerStyle(style: LineCapStyle): DividerTheme {
    this.dividerStyle = style
    return this
  }

  /**
   * 获取dividerMarginTop
   *
   * @returns dividerMarginTop
   */
  getDividerMarginTop(): number | undefined {
    return this.dividerMarginTop
  }

  /**
   * 获取dividerMarginRight
   *
   * @returns dividerMarginRight
   */
  getDividerMarginRight(): number | undefined {
    return this.dividerMarginRight
  }

  /**
   * 获取dividerMarginBottom
   *
   * @returns dividerMarginBottom
   */
  getDividerMarginBottom(): number | undefined {
    return this.dividerMarginBottom
  }

  /**
   * 获取dividerMarginLeft
   *
   * @returns dividerMarginLeft
   */
  getDividerMarginLeft(): number | undefined {
    return this.dividerMarginLeft
  }

  /**
   * 获取dividerPaddingTop
   *
   * @returns dividerPaddingTop
   */
  getDividerPaddingTop(): number | undefined {
    return this.dividerPaddingTop
  }

  /**
   * 获取dividerPaddingRight
   *
   * @returns dividerPaddingRight
   */
  getDividerPaddingRight(): number | undefined {
    return this.dividerPaddingRight
  }

  /**
   * 获取dividerPaddingBottom
   *
   * @returns dividerPaddingBottom
   */
  getDividerPaddingBottom(): number | undefined {
    return this.dividerPaddingBottom
  }

  /**
   * 获取dividerPaddingLeft
   *
   * @returns dividerPaddingLeft
   */
  getDividerPaddingLeft(): number | undefined {
    return this.dividerPaddingLeft
  }

  /**
   * 获取dividerColor
   *
   * @returns dividerColor
   */
  getDividerColor(): number | undefined {
    return this.dividerColor
  }

  /**
   * 获取dividerStrokeWidth
   *
   * @returns dividerStrokeWidth
   */
  getDividerStrokeWidth(): number | undefined {
    return this.dividerStrokeWidth
  }

  /**
   * 获取dividerStyle
   *
   * @returns dividerStyle
   */
  getDividerStyle(): LineCapStyle | undefined {
    return this.dividerStyle
  }
}
