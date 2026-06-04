import { MarkdownMarginOptions, MarkdownPaddingOptions, MarkdownRadiusOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-块引用样式
 */
export class BlockQuoteTheme {
  /**
   * 块引用背景颜色
   */
  private blockQuoteBackgroundColor?: number = undefined

  /**
   * 块引用上外边距
   */
  private blockQuoteMarginTop?: number = undefined

  /**
   * 块引用右外边距
   */
  private blockQuoteMarginRight?: number = undefined

  /**
   * 块引用下外边距
   */
  private blockQuoteMarginBottom?: number = undefined

  /**
   * 块引用左外边距
   */
  private blockQuoteMarginLeft?: number = undefined

  /**
   * 块引用上内边距
   */
  private blockQuotePaddingTop?: number = undefined

  /**
   * 块引用右内边距
   */
  private blockQuotePaddingRight?: number = undefined

  /**
   * 块引用下内边距
   */
  private blockQuotePaddingBottom?: number = undefined

  /**
   * 块引用左内边距
   */
  private blockQuotePaddingLeft?: number = undefined

  /**
   * 块引用边框左上圆角
   */
  private blockQuoteRadiusTopLeft?: number = undefined

  /**
   * 块引用边框右上圆角
   */
  private blockQuoteRadiusTopRight?: number = undefined

  /**
   * 块引用边框左下圆角
   */
  private blockQuoteRadiusBottomLeft?: number = undefined

  /**
   * 块引用边框右下圆角
   */
  private blockQuoteRadiusBottomRight?: number = undefined

  /**
   * 块引用左侧边框宽度
   */
  private blockQuoteLeftBorderWidth?: number = undefined

  /**
   * 块引用左侧边框颜色
   */
  private blockQuoteLeftBorderColor?: number = undefined

  /**
   * 块引用子模块上下间距
   */
  private blockQuoteChildSpacing?: number = undefined

  /**
   * 设置块引用背景颜色
   *
   * @param color 块引用背景颜色
   */
  setBlockQuoteBackgroundColor(color: number): void {
    this.blockQuoteBackgroundColor = color
  }

  /**
   * 块引用设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setBlockQuoteMargin(options: MarkdownMarginOptions | number): void {
    if (typeof options === 'number') {
      this.blockQuoteMarginTop = options
      this.blockQuoteMarginRight = options
      this.blockQuoteMarginBottom = options
      this.blockQuoteMarginLeft = options
    } else {
      if (options.top !== undefined) {
        this.blockQuoteMarginTop = options.top
      }
      if (options.right !== undefined) {
        this.blockQuoteMarginRight = options.right
      }
      if (options.bottom !== undefined) {
        this.blockQuoteMarginBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.blockQuoteMarginLeft = options.left
      }
    }
  }

  /**
   * 块引用设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setBlockQuotePadding(options: MarkdownPaddingOptions | number): void {
    if (typeof options === 'number') {
      this.blockQuotePaddingTop = options
      this.blockQuotePaddingRight = options
      this.blockQuotePaddingBottom = options
      this.blockQuotePaddingLeft = options
    } else {
      if (options.top !== undefined) {
        this.blockQuotePaddingTop = options.top
      }
      if (options.right !== undefined) {
        this.blockQuotePaddingRight = options.right
      }
      if (options.bottom !== undefined) {
        this.blockQuotePaddingBottom = options.bottom
      }
      if (options.left !== undefined) {
        this.blockQuotePaddingLeft = options.left
      }
    }
  }

  /**
   * 块引用设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setBlockQuoteRadius(options: MarkdownRadiusOptions | number): void {
    if (typeof options === 'number') {
      this.blockQuoteRadiusTopLeft = options
      this.blockQuoteRadiusTopRight = options
      this.blockQuoteRadiusBottomLeft = options
      this.blockQuoteRadiusBottomRight = options
    } else {
      if (options.topLeft !== undefined) {
        this.blockQuoteRadiusTopLeft = options.topLeft
      }
      if (options.topRight !== undefined) {
        this.blockQuoteRadiusTopRight = options.topRight
      }
      if (options.bottomLeft !== undefined) {
        this.blockQuoteRadiusBottomLeft = options.bottomLeft
      }
      if (options.bottomRight !== undefined) {
        this.blockQuoteRadiusBottomRight = options.bottomRight
      }
    }
  }

  /**
   * 设置块引用左侧边框宽度
   *
   * @param width 块引用左侧边框宽度
   */
  setBlockQuoteLeftBorderWidth(width: number): void {
    this.blockQuoteLeftBorderWidth = width
  }

  /**
   * 设置块引用左侧边框颜色
   *
   * @param color 块引用左侧边框颜色
   */
  setBlockQuoteLeftBorderColor(color: number): void {
    this.blockQuoteLeftBorderColor = color
  }

  /**
   * 设置块引用子模块上下间距
   *
   * @param spacing 块引用子模块上下间距
   */
  setBlockQuoteChildSpacing(spacing: number): void {
    this.blockQuoteChildSpacing = spacing
  }

  /**
   * 获取blockQuoteBackgroundColor
   *
   * @returns blockQuoteBackgroundColor
   */
  getBlockQuoteBackgroundColor(): number | undefined {
    return this.blockQuoteBackgroundColor
  }

  /**
   * 获取blockQuoteMarginTop
   *
   * @returns blockQuoteMarginTop
   */
  getBlockQuoteMarginTop(): number | undefined {
    return this.blockQuoteMarginTop
  }

  /**
   * 获取blockQuoteMarginRight
   *
   * @returns blockQuoteMarginRight
   */
  getBlockQuoteMarginRight(): number | undefined {
    return this.blockQuoteMarginRight
  }

  /**
   * 获取blockQuoteMarginBottom
   *
   * @returns blockQuoteMarginBottom
   */
  getBlockQuoteMarginBottom(): number | undefined {
    return this.blockQuoteMarginBottom
  }

  /**
   * 获取blockQuoteMarginLeft
   *
   * @returns blockQuoteMarginLeft
   */
  getBlockQuoteMarginLeft(): number | undefined {
    return this.blockQuoteMarginLeft
  }

  /**
   * 获取blockQuotePaddingTop
   *
   * @returns blockQuotePaddingTop
   */
  getBlockQuotePaddingTop(): number | undefined {
    return this.blockQuotePaddingTop
  }

  /**
   * 获取blockQuotePaddingRight
   *
   * @returns blockQuotePaddingRight
   */
  getBlockQuotePaddingRight(): number | undefined {
    return this.blockQuotePaddingRight
  }

  /**
   * 获取blockQuotePaddingBottom
   *
   * @returns blockQuotePaddingBottom
   */
  getBlockQuotePaddingBottom(): number | undefined {
    return this.blockQuotePaddingBottom
  }

  /**
   * 获取blockQuotePaddingLeft
   *
   * @returns blockQuotePaddingLeft
   */
  getBlockQuotePaddingLeft(): number | undefined {
    return this.blockQuotePaddingLeft
  }

  /**
   * 获取blockQuoteRadiusTopLeft
   *
   * @returns blockQuoteRadiusTopLeft
   */
  getBlockQuoteRadiusTopLeft(): number | undefined {
    return this.blockQuoteRadiusTopLeft
  }

  /**
   * 获取blockQuoteRadiusTopRight
   *
   * @returns blockQuoteRadiusTopRight
   */
  getBlockQuoteRadiusTopRight(): number | undefined {
    return this.blockQuoteRadiusTopRight
  }

  /**
   * 获取blockQuoteRadiusBottomLeft
   *
   * @returns blockQuoteRadiusBottomLeft
   */
  getBlockQuoteRadiusBottomLeft(): number | undefined {
    return this.blockQuoteRadiusBottomLeft
  }

  /**
   * 获取blockQuoteRadiusBottomRight
   *
   * @returns blockQuoteRadiusBottomRight
   */
  getBlockQuoteRadiusBottomRight(): number | undefined {
    return this.blockQuoteRadiusBottomRight
  }

  /**
   * 获取blockQuoteLeftBorderWidth
   *
   * @returns blockQuoteLeftBorderWidth
   */
  getBlockQuoteLeftBorderWidth(): number | undefined {
    return this.blockQuoteLeftBorderWidth
  }

  /**
   * 获取blockQuoteLeftBorderColor
   *
   * @returns blockQuoteLeftBorderColor
   */
  getBlockQuoteLeftBorderColor(): number | undefined {
    return this.blockQuoteLeftBorderColor
  }

  /**
   * 获取blockQuoteChildSpacing
   *
   * @returns blockQuoteChildSpacing
   */
  getBlockQuoteChildSpacing(): number | undefined {
    return this.blockQuoteChildSpacing
  }
}
