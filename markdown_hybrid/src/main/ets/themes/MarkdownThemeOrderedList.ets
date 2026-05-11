/**
 * Markdown用户可设置的样式-有序列表样式
 */
export class MarkdownThemeOrderedList {
  /**
   * 有序列表背景颜色
   */
  private orderedListBackgroundColor?: number = undefined

  /**
   * 有序列表上外边距
   */
  private orderedListMarginTop?: number = undefined

  /**
   * 有序列表右外边距
   */
  private orderedListMarginRight?: number = undefined

  /**
   * 有序列表下外边距
   */
  private orderedListMarginBottom?: number = undefined

  /**
   * 有序列表左外边距
   */
  private orderedListMarginLeft?: number = undefined

  /**
   * 有序列表上内边距
   */
  private orderedListPaddingTop?: number = undefined

  /**
   * 有序列表右内边距
   */
  private orderedListPaddingRight?: number = undefined

  /**
   * 有序列表下内边距
   */
  private orderedListPaddingBottom?: number = undefined

  /**
   * 有序列表左内边距
   */
  private orderedListPaddingLeft?: number = undefined

  /**
   * 有序列表子模块上下间距
   */
  private orderedListChildSpacing?: number = undefined

  /**
   * 有序列表子模块中子模块上下间距
   */
  private orderedListChildChildSpacing?: number = undefined

  /**
   * 有序列表列表编号和列表内容间距
   */
  private orderedListMarkerSpacing?: number = undefined

  /**
   * 有序列表列表编号文本颜色
   */
  private orderedListMarkerTextFontColor?: number = undefined

  /**
   * 有序列表列表编号文本尺寸
   */
  private orderedListMarkerTextFontSize?: number = undefined

  /**
   * 有序列表列表编号文本字体样式
   */
  private orderedListMarkerTextFontStyle?: FontStyle = undefined

  /**
   * 有序列表列表编号文本字体粗细
   */
  private orderedListMarkerTextFontWeight?: FontWeight = undefined

  /**
   * 有序列表列表编号文本字体
   */
  private orderedListMarkerTextFontFamily?: string = undefined

  /**
   * 有序列表列表编号文本行高
   */
  private orderedListMarkerTextLineHeight?: number = undefined

  /**
   * 设置有序列表背景颜色
   *
   * @param color 有序列表背景颜色
   */
  setOrderedListBackgroundColor(color: number): void {
    this.orderedListBackgroundColor = color
  }

  /**
   * 设置4个外边距为统一值
   *
   * @param margin 外边距
   */
  setOrderedListAllMargin(margin: number): void {
    this.orderedListMarginTop = margin
    this.orderedListMarginRight = margin
    this.orderedListMarginBottom = margin
    this.orderedListMarginLeft = margin
  }

  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setOrderedListMargin(top?: number, right?: number, bottom?: number, left?: number): void {
    this.orderedListMarginTop = top
    this.orderedListMarginRight = right
    this.orderedListMarginBottom = bottom
    this.orderedListMarginLeft = left
  }

  /**
   * 设置4个内边距为统一值
   *
   * @param padding 内边距
   */
  setOrderedListAllPadding(padding: number): void {
    this.orderedListPaddingTop = padding
    this.orderedListPaddingRight = padding
    this.orderedListPaddingBottom = padding
    this.orderedListPaddingLeft = padding
  }

  /**
   * 分别设置4个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setOrderedListPadding(top?: number, right?: number, bottom?: number, left?: number): void {
    this.orderedListPaddingTop = top
    this.orderedListPaddingRight = right
    this.orderedListPaddingBottom = bottom
    this.orderedListPaddingLeft = left
  }

  /**
   * 设置有序列表子模块上下间距
   *
   * @param spacing 上下间距
   */
  setOrderedListChildSpacing(spacing: number): void {
    this.orderedListChildSpacing = spacing
  }

  /**
   * 设置有序列表子模块中子模块上下间距
   *
   * @param spacing 上下间距
   */
  setOrderedListChildChildSpacing(spacing: number): void {
    this.orderedListChildChildSpacing = spacing
  }

  /**
   * 设置有序列表列表编号和列表内容间距
   *
   * @param spacing 间距
   */
  setOrderedListMarkerSpacing(spacing: number): void {
    this.orderedListMarkerSpacing = spacing
  }

  /**
   * 设置有序列表列表编号文本颜色
   *
   * @param color 列表编号文本颜色
   */
  setOrderedListMarkerTextFontColor(color: number): void {
    this.orderedListMarkerTextFontColor = color
  }

  /**
   * 设置有序列表列表编号文本尺寸
   *
   * @param size 列表编号文本尺寸
   */
  setOrderedListMarkerTextFontSize(size: number): void {
    this.orderedListMarkerTextFontSize = size
  }

  /**
   * 设置有序列表列表编号文本字体样式
   *
   * @param style 列表编号文本字体样式
   */
  setOrderedListMarkerTextFontStyle(style: FontStyle): void {
    this.orderedListMarkerTextFontStyle = style
  }

  /**
   * 设置有序列表列表编号文本字体粗细
   *
   * @param weight 列表编号文本字体粗细
   */
  setOrderedListMarkerTextFontWeight(weight: FontWeight): void {
    this.orderedListMarkerTextFontWeight = weight
  }

  /**
   * 设置有序列表列表编号文本字体
   *
   * @param family 列表编号文本字体
   */
  setOrderedListMarkerTextFontFamily(family: string): void {
    this.orderedListMarkerTextFontFamily = family
  }

  /**
   * 设置有序列表列表编号文本行高
   *
   * @param lineHeight 列表编号文本行高
   */
  setOrderedListMarkerTextLineHeight(lineHeight: number): void {
    this.orderedListMarkerTextLineHeight = lineHeight
  }

  /**
   * 获取orderedListBackgroundColor
   *
   * @returns orderedListBackgroundColor
   */
  getOrderedListBackgroundColor(): number | undefined {
    return this.orderedListBackgroundColor
  }

  /**
   * 获取orderedListMarginTop
   *
   * @returns orderedListMarginTop
   */
  getOrderedListMarginTop(): number | undefined {
    return this.orderedListMarginTop
  }

  /**
   * 获取orderedListMarginRight
   *
   * @returns orderedListMarginRight
   */
  getOrderedListMarginRight(): number | undefined {
    return this.orderedListMarginRight
  }

  /**
   * 获取orderedListMarginBottom
   *
   * @returns orderedListMarginBottom
   */
  getOrderedListMarginBottom(): number | undefined {
    return this.orderedListMarginBottom
  }

  /**
   * 获取orderedListMarginLeft
   *
   * @returns orderedListMarginLeft
   */
  getOrderedListMarginLeft(): number | undefined {
    return this.orderedListMarginLeft
  }

  /**
   * 获取orderedListPaddingTop
   *
   * @returns orderedListPaddingTop
   */
  getOrderedListPaddingTop(): number | undefined {
    return this.orderedListPaddingTop
  }

  /**
   * 获取orderedListPaddingRight
   *
   * @returns orderedListPaddingRight
   */
  getOrderedListPaddingRight(): number | undefined {
    return this.orderedListPaddingRight
  }

  /**
   * 获取orderedListPaddingBottom
   *
   * @returns orderedListPaddingBottom
   */
  getOrderedListPaddingBottom(): number | undefined {
    return this.orderedListPaddingBottom
  }

  /**
   * 获取orderedListPaddingLeft
   *
   * @returns orderedListPaddingLeft
   */
  getOrderedListPaddingLeft(): number | undefined {
    return this.orderedListPaddingLeft
  }

  /**
   * 获取orderedListChildSpacing
   *
   * @returns orderedListChildSpacing
   */
  getOrderedListChildSpacing(): number | undefined {
    return this.orderedListChildSpacing
  }

  /**
   * 获取orderedListChildChildSpacing
   *
   * @returns orderedListChildChildSpacing
   */
  getOrderedListChildChildSpacing(): number | undefined {
    return this.orderedListChildChildSpacing
  }

  /**
   * 获取orderedListMarkerSpacing
   *
   * @returns orderedListMarkerSpacing
   */
  getOrderedListMarkerSpacing(): number | undefined {
    return this.orderedListMarkerSpacing
  }

  /**
   * 获取orderedListMarkerTextFontColor
   *
   * @returns orderedListMarkerTextFontColor
   */
  getOrderedListMarkerTextFontColor(): number | undefined {
    return this.orderedListMarkerTextFontColor
  }

  /**
   * 获取orderedListMarkerTextFontSize
   *
   * @returns orderedListMarkerTextFontSize
   */
  getOrderedListMarkerTextFontSize(): number | undefined {
    return this.orderedListMarkerTextFontSize
  }

  /**
   * 获取orderedListMarkerTextFontStyle
   *
   * @returns orderedListMarkerTextFontStyle
   */
  getOrderedListMarkerTextFontStyle(): FontStyle | undefined {
    return this.orderedListMarkerTextFontStyle
  }

  /**
   * 获取orderedListMarkerTextFontWeight
   *
   * @returns orderedListMarkerTextFontWeight
   */
  getOrderedListMarkerTextFontWeight(): FontWeight | undefined {
    return this.orderedListMarkerTextFontWeight
  }

  /**
   * 获取orderedListMarkerTextFontFamily
   *
   * @returns orderedListMarkerTextFontFamily
   */
  getOrderedListMarkerTextFontFamily(): string | undefined {
    return this.orderedListMarkerTextFontFamily
  }

  /**
   * 获取orderedListMarkerTextLineHeight
   *
   * @returns orderedListMarkerTextLineHeight
   */
  getOrderedListMarkerTextLineHeight(): number | undefined {
    return this.orderedListMarkerTextLineHeight
  }
}
