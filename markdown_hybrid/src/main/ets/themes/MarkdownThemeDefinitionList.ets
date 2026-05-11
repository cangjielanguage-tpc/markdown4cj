/**
 * Markdown用户可设置的样式-定义列表样式
 */
export class MarkdownThemeDefinitionList {
  /**
   * 定义列表背景颜色
   */
  private definitionListBackgroundColor?: number = undefined

  /**
   * 定义列表上外边距
   */
  private definitionListMarginTop?: number = undefined

  /**
   * 定义列表右外边距
   */
  private definitionListMarginRight?: number = undefined

  /**
   * 定义列表下外边距
   */
  private definitionListMarginBottom?: number = undefined

  /**
   * 定义列表左外边距
   */
  private definitionListMarginLeft?: number = undefined

  /**
   * 定义列表上内边距
   */
  private definitionListPaddingTop?: number = undefined

  /**
   * 定义列表右内边距
   */
  private definitionListPaddingRight?: number = undefined

  /**
   * 定义列表下内边距
   */
  private definitionListPaddingBottom?: number = undefined

  /**
   * 定义列表左内边距
   */
  private definitionListPaddingLeft?: number = undefined

  /**
   * 定义列表术语和定义行之间间距
   */
  private definitionListTermToDescriptionSpacing?: number = undefined

  /**
   * 定义列表术语文本字体粗细
   */
  private definitionListTermTextFontWeight?: FontWeight = undefined

  /**
   * 定义列表术语文本字体样式
   */
  private definitionListTermTextFontStyle?: FontStyle = undefined

  /**
   * 定义列表定义行之间间距
   */
  private definitionListDescriptionItemSpacing?: number = undefined

  /**
   * 定义列表定义行左缩进距离
   */
  private definitionListDescriptionIndent?: number = undefined

  /**
   * 设置4个外边距为统一值
   *
   * @param margin 外边距
   */
  setDefinitionListAllMargin(margin: number): void {
    this.definitionListMarginTop = margin
    this.definitionListMarginRight = margin
    this.definitionListMarginBottom = margin
    this.definitionListMarginLeft = margin
  }

  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setDefinitionListMargin(top?: number, right?: number, bottom?: number, left?: number): void {
    this.definitionListMarginTop = top
    this.definitionListMarginRight = right
    this.definitionListMarginBottom = bottom
    this.definitionListMarginLeft = left
  }

  /**
   * 设置4个内边距为统一值
   *
   * @param padding 内边距
   */
  setDefinitionListAllPadding(padding: number): void {
    this.definitionListPaddingTop = padding
    this.definitionListPaddingRight = padding
    this.definitionListPaddingBottom = padding
    this.definitionListPaddingLeft = padding
  }

  /**
   * 分别设置4个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setDefinitionListPadding(top?: number, right?: number, bottom?: number, left?: number): void {
    this.definitionListPaddingTop = top
    this.definitionListPaddingRight = right
    this.definitionListPaddingBottom = bottom
    this.definitionListPaddingLeft = left
  }

  /**
   * 设置定义列表背景颜色
   *
   * @param color 定义列表背景颜色
   */
  setDefinitionListBackgroundColor(color: number): void {
    this.definitionListBackgroundColor = color
  }

  /**
   * 设置定义列表术语和定义行之间间距
   *
   * @param spacing 间距
   */
  setDefinitionListTermToDescriptionSpacing(spacing: number): void {
    this.definitionListTermToDescriptionSpacing = spacing
  }

  /**
   * 设置定义列表术语文本字体粗细
   *
   * @param weight 文本字体粗细
   */
  setDefinitionListTermTextFontWeight(weight: FontWeight): void {
    this.definitionListTermTextFontWeight = weight
  }

  /**
   * 设置定义列表术语文本字体样式
   *
   * @param style 定义列表术语文本字体样式
   */
  setDefinitionListTermTextFontStyle(style: FontStyle): void {
    this.definitionListTermTextFontStyle = style
  }

  /**
   * 设置定义列表定义行之间间距
   *
   * @param spacing 间距
   */
  setDefinitionListDescriptionItemSpacing(spacing: number): void {
    this.definitionListDescriptionItemSpacing = spacing
  }

  /**
   * 设置定义列表定义行左缩进距离
   *
   * @param indent 左缩进距离
   */
  setDefinitionListDescriptionIndent(indent: number): void {
    this.definitionListDescriptionIndent = indent
  }

  /**
   * 获取definitionListBackgroundColor
   *
   * @returns definitionListBackgroundColor
   */
  getDefinitionListBackgroundColor(): number | undefined {
    return this.definitionListBackgroundColor
  }

  /**
   * 获取definitionListMarginTop
   *
   * @returns definitionListMarginTop
   */
  getDefinitionListMarginTop(): number | undefined {
    return this.definitionListMarginTop
  }

  /**
   * 获取definitionListMarginRight
   *
   * @returns definitionListMarginRight
   */
  getDefinitionListMarginRight(): number | undefined {
    return this.definitionListMarginRight
  }

  /**
   * 获取definitionListMarginBottom
   *
   * @returns definitionListMarginBottom
   */
  getDefinitionListMarginBottom(): number | undefined {
    return this.definitionListMarginBottom
  }

  /**
   * 获取definitionListMarginLeft
   *
   * @returns definitionListMarginLeft
   */
  getDefinitionListMarginLeft(): number | undefined {
    return this.definitionListMarginLeft
  }

  /**
   * 获取definitionListPaddingTop
   *
   * @returns definitionListPaddingTop
   */
  getDefinitionListPaddingTop(): number | undefined {
    return this.definitionListPaddingTop
  }

  /**
   * 获取definitionListPaddingRight
   *
   * @returns definitionListPaddingRight
   */
  getDefinitionListPaddingRight(): number | undefined {
    return this.definitionListPaddingRight
  }

  /**
   * 获取definitionListPaddingBottom
   *
   * @returns definitionListPaddingBottom
   */
  getDefinitionListPaddingBottom(): number | undefined {
    return this.definitionListPaddingBottom
  }

  /**
   * 获取definitionListPaddingLeft
   *
   * @returns definitionListPaddingLeft
   */
  getDefinitionListPaddingLeft(): number | undefined {
    return this.definitionListPaddingLeft
  }

  /**
   * 获取definitionListTermToDescriptionSpacing
   *
   * @returns definitionListTermToDescriptionSpacing
   */
  getDefinitionListTermToDescriptionSpacing(): number | undefined {
    return this.definitionListTermToDescriptionSpacing
  }

  /**
   * 获取definitionListTermTextFontWeight
   *
   * @returns definitionListTermTextFontWeight
   */
  getDefinitionListTermTextFontWeight(): FontWeight | undefined {
    return this.definitionListTermTextFontWeight
  }

  /**
   * 获取definitionListTermTextFontStyle
   *
   * @returns definitionListTermTextFontStyle
   */
  getDefinitionListTermTextFontStyle(): FontStyle | undefined {
    return this.definitionListTermTextFontStyle
  }

  /**
   * 获取definitionListDescriptionItemSpacing
   *
   * @returns definitionListDescriptionItemSpacing
   */
  getDefinitionListDescriptionItemSpacing(): number | undefined {
    return this.definitionListDescriptionItemSpacing
  }

  /**
   * 获取definitionListDescriptionIndent
   *
   * @returns definitionListDescriptionIndent
   */
  getDefinitionListDescriptionIndent(): number | undefined {
    return this.definitionListDescriptionIndent
  }
}
