/**
 * Markdown用户可设置的样式-上标文本样式
 */
export class SupTheme {
  /**
   * 上标文本颜色
   */
  private supTextFontColor?: number = undefined

  /**
   * 上标文本尺寸
   */
  private supTextFontSize?: number = undefined

  /**
   * 上标文本字体样式
   */
  private supTextFontStyle?: FontStyle = undefined

  /**
   * 上标文本字体粗细
   */
  private supTextFontWeight?: FontWeight = undefined

  /**
   * 上标文本字体
   */
  private supTextFontFamily?: string = undefined

  /**
   * 上标文本字符间距
   */
  private supTextLetterSpacing?: number = undefined

  /**
   * 上标文本基线的偏移量
   */
  private supTextBaselineOffset?: number = undefined

  /**
   * 设置上标文本颜色
   *
   * @param color 上标文本颜色
   */
  setSupTextFontColor(color: number): SupTheme {
    this.supTextFontColor = color
    return this
  }

  /**
   * 设置上标文本尺寸
   *
   * @param size 上标文本尺寸
   */
  setSupTextFontSize(size: number): SupTheme {
    this.supTextFontSize = size
    return this
  }

  /**
   * 设置上标文本字体样式
   *
   * @param style 上标文本字体样式
   */
  setSupTextFontStyle(style: FontStyle): SupTheme {
    this.supTextFontStyle = style
    return this
  }

  /**
   * 设置上标文本字体粗细
   *
   * @param weight 上标文本字体粗细
   */
  setSupTextFontWeight(weight: FontWeight): SupTheme {
    this.supTextFontWeight = weight
    return this
  }

  /**
   * 设置上标文本字体
   *
   * @param family 上标文本字体
   */
  setSupTextFontFamily(family: string): SupTheme {
    this.supTextFontFamily = family
    return this
  }

  /**
   * 设置上标文本字符间距
   *
   * @param spacing 上标文本字符间距
   */
  setSupTextLetterSpacing(spacing: number): SupTheme {
    this.supTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置上标文本基线的偏移量
   *
   * @param offset 上标文本基线的偏移量
   */
  setSupTextBaselineOffset(offset: number): SupTheme {
    this.supTextBaselineOffset = offset
    return this
  }

  /**
   * 获取supTextFontColor
   *
   * @returns supTextFontColor
   */
  getSupTextFontColor(): number | undefined {
    return this.supTextFontColor
  }

  /**
   * 获取supTextFontSize
   *
   * @returns supTextFontSize
   */
  getSupTextFontSize(): number | undefined {
    return this.supTextFontSize
  }

  /**
   * 获取supTextFontStyle
   *
   * @returns supTextFontStyle
   */
  getSupTextFontStyle(): FontStyle | undefined {
    return this.supTextFontStyle
  }

  /**
   * 获取supTextFontWeight
   *
   * @returns supTextFontWeight
   */
  getSupTextFontWeight(): FontWeight | undefined {
    return this.supTextFontWeight
  }

  /**
   * 获取supTextFontFamily
   *
   * @returns supTextFontFamily
   */
  getSupTextFontFamily(): string | undefined {
    return this.supTextFontFamily
  }

  /**
   * 获取supTextLetterSpacing
   *
   * @returns supTextLetterSpacing
   */
  getSupTextLetterSpacing(): number | undefined {
    return this.supTextLetterSpacing
  }

  /**
   * 获取supTextBaselineOffset
   *
   * @returns supTextBaselineOffset
   */
  getSupTextBaselineOffset(): number | undefined {
    return this.supTextBaselineOffset
  }
}
