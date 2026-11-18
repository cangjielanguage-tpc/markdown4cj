import { MarkdownBaseTheme } from './MarkdownBaseTheme'

/**
 * 斜体样式配置
 */
@Observed
export class ItalicTheme implements MarkdownBaseTheme {
  italicTextFontColor: ResourceColor | undefined = undefined // 字体颜色
  italicTextFontSize: number | string | Resource | undefined = undefined // 字体大小
  italicTextFontWeight: number | FontWeight | undefined = undefined // 字体粗细
  italicTextFontFamily: string | Resource | undefined = undefined // 字体族
  italicTextLineHeight: number | string | Resource | undefined = undefined // 行高
  italicTextLetterSpacing: number | undefined = undefined // 字间距

  /**
   * 设置斜体字体颜色
   *
   * @param color 字体颜色
   * @return ItalicTheme
   */
  setItalicTextFontColor(color: ResourceColor): ItalicTheme {
    this.italicTextFontColor = color
    return this
  }

  /**
   * 设置斜体字体大小
   *
   * @param size 字体大小
   * @return ItalicTheme
   */
  setItalicTextFontSize(size: number | string | Resource): ItalicTheme {
    this.italicTextFontSize = size
    return this
  }

  /**
   * 设置斜体字体粗细
   *
   * @param weight 字体粗细
   * @return ItalicTheme
   */
  setItalicTextFontWeight(weight: number | FontWeight): ItalicTheme {
    this.italicTextFontWeight = weight
    return this
  }

  /**
   * 设置斜体字体族
   *
   * @param family 字体族
   * @return ItalicTheme
   */
  setItalicTextFontFamily(family: string | Resource): ItalicTheme {
    this.italicTextFontFamily = family
    return this
  }

  /**
   * 设置斜体行高
   *
   * @param lineHeight 行高
   * @return ItalicTheme
   */
  setItalicTextLineHeight(lineHeight: number | string | Resource): ItalicTheme {
    this.italicTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置斜体字间距
   *
   * @param spacing 字间距
   * @return ItalicTheme
   */
  setItalicTextLetterSpacing(spacing: number): ItalicTheme {
    this.italicTextLetterSpacing = spacing
    return this
  }

  /**
   * 原地合并另一实例的字段到当前实例（动态换肤通道）。
   *
   * MarkdownTheme.applyFrom 逐子主题调用本方法完成样式合并；字段逐一显式赋值，
   * ArkTS 限制使用 Object.assign 等受限标准库 API；新增字段时需同步维护本方法。
   *
   * @param other 来源实例
   * @return ItalicTheme
   */
  applyFrom(other: ItalicTheme): ItalicTheme {
    this.italicTextFontColor = other.italicTextFontColor
    this.italicTextFontSize = other.italicTextFontSize
    this.italicTextFontWeight = other.italicTextFontWeight
    this.italicTextFontFamily = other.italicTextFontFamily
    this.italicTextLineHeight = other.italicTextLineHeight
    this.italicTextLetterSpacing = other.italicTextLetterSpacing
    return this
  }
}
