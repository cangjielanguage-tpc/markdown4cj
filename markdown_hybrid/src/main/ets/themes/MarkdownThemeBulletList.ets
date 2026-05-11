/**
 * Markdown用户可设置的样式-无序/任务列表样式
 */
export class MarkdownThemeBulletList {
  /**
   * 无序/任务背景颜色
   */
  private bulletListBackgroundColor?: number = undefined

  /**
   * 无序/任务上外边距
   */
  private bulletListMarginTop?: number = undefined

  /**
   * 无序/任务右外边距
   */
  private bulletListMarginRight?: number = undefined

  /**
   * 无序/任务下外边距
   */
  private bulletListMarginBottom?: number = undefined

  /**
   * 无序/任务左外边距
   */
  private bulletListMarginLeft?: number = undefined

  /**
   * 无序/任务上内边距
   */
  private bulletListPaddingTop?: number = undefined

  /**
   * 无序/任务右内边距
   */
  private bulletListPaddingRight?: number = undefined

  /**
   * 无序/任务下内边距
   */
  private bulletListPaddingBottom?: number = undefined

  /**
   * 无序/任务左内边距
   */
  private bulletListPaddingLeft?: number = undefined

  /**
   * 无序/任务子模块上下间距
   */
  private bulletListChildSpacing?: number = undefined

  /**
   * 无序/任务子模块中子模块上下间距
   */
  private bulletListChildChildSpacing?: number = undefined

  /**
   * 无序列表列表符号和列表内容间距
   */
  private bulletListBulletSpacing?: number = undefined

  /**
   * 无序列表列表符号是否全部是实心圆型
   */
  private bulletListBulletIsCircle?: boolean = undefined

  /**
   * 无序列表列表符号文本颜色
   */
  private bulletListBulletTextFontColor?: number = undefined

  /**
   * 无序列表列表符号文本尺寸
   */
  private bulletListBulletTextFontSize?: number = undefined

  /**
   * 无序列表列表符号文本字体样式
   */
  private bulletListBulletTextFontStyle?: FontStyle = undefined

  /**
   * 无序列表列表符号文本字体粗细
   */
  private bulletListBulletTextFontWeight?: FontWeight = undefined

  /**
   * 无序列表列表符号文本字体
   */
  private bulletListBulletTextFontFamily?: string = undefined

  /**
   * 无序列表列表符号文本行高
   */
  private bulletListBulletTextLineHeight?: number = undefined

  /**
   * 任务列表多选框和列表内容间距
   */
  private bulletListCheckboxSpacing?: number = undefined

  /**
   * 任务列表多选框宽度
   */
  private bulletListCheckboxWidth?: number = undefined

  /**
   * 任务列表多选框高度
   */
  private bulletListCheckboxHeight?: number = undefined

  /**
   * 任务列表多选框选中颜色
   */
  private bulletListCheckboxSelectedColor?: number = undefined

  /**
   * 任务列表多选框形状
   */
  private bulletListCheckboxShape?: CheckBoxShape = undefined

  /**
   * 设置无序/任务背景颜色
   *
   * @param color 无序/任务背景颜色
   */
  setBulletListBackgroundColor(color: number): void {
    this.bulletListBackgroundColor = color
  }

  /**
   * 统一设置无序/任务外边距
   *
   * @param margin 外边距
   */
  setBulletListAllMargin(margin: number): void {
    this.bulletListMarginTop = margin
    this.bulletListMarginRight = margin
    this.bulletListMarginBottom = margin
    this.bulletListMarginLeft = margin
  }

  /**
   * 分别设置无序/任务四个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setBulletListMargin(top?: number, right?: number, bottom?: number, left?: number): void {
    this.bulletListMarginTop = top
    this.bulletListMarginRight = right
    this.bulletListMarginBottom = bottom
    this.bulletListMarginLeft = left
  }

  /**
   * 统一设置无序/任务内边距
   *
   * @param padding 内边距
   */
  setBulletListAllPadding(padding: number): void {
    this.bulletListPaddingTop = padding
    this.bulletListPaddingRight = padding
    this.bulletListPaddingBottom = padding
    this.bulletListPaddingLeft = padding
  }

  /**
   * 分别设置无序/任务四个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setBulletListPadding(top?: number, right?: number, bottom?: number, left?: number): void {
    this.bulletListPaddingTop = top
    this.bulletListPaddingRight = right
    this.bulletListPaddingBottom = bottom
    this.bulletListPaddingLeft = left
  }

  /**
   * 设置无序/任务子模块上下间距
   *
   * @param spacing 无序/任务子模块上下间距
   */
  setBulletListChildSpacing(spacing: number): void {
    this.bulletListChildSpacing = spacing
  }

  /**
   * 设置无序/任务子模块中子模块上下间距
   *
   * @param spacing 无序/任务子模块中子模块上下间距
   */
  setBulletListChildChildSpacing(spacing: number): void {
    this.bulletListChildChildSpacing = spacing
  }

  /**
   * 设置无序列表列表符号和列表内容间距
   *
   * @param spacing 无序列表列表符号和列表内容间距
   */
  setBulletListBulletSpacing(spacing: number): void {
    this.bulletListBulletSpacing = spacing
  }

  /**
   * 设置无序列表列表符号是否全部是实心圆型
   *
   * @param isCircle 无序列表列表符号是否全部是实心圆型
   */
  setBulletListBulletIsCircle(isCircle: boolean): void {
    this.bulletListBulletIsCircle = isCircle
  }

  /**
   * 设置无序列表列表符号文本颜色
   *
   * @param color 无序列表列表符号文本颜色
   */
  setBulletListBulletTextFontColor(color: number): void {
    this.bulletListBulletTextFontColor = color
  }

  /**
   * 设置无序列表列表符号文本尺寸
   *
   * @param size 无序列表列表符号文本尺寸
   */
  setBulletListBulletTextFontSize(size: number): void {
    this.bulletListBulletTextFontSize = size
  }

  /**
   * 设置无序列表列表符号文本字体样式
   *
   * @param style 无序列表列表符号文本字体样式
   */
  setBulletListBulletTextFontStyle(style: FontStyle): void {
    this.bulletListBulletTextFontStyle = style
  }

  /**
   * 设置无序列表列表符号文本字体粗细
   *
   * @param weight 无序列表列表符号文本字体粗细
   */
  setBulletListBulletTextFontWeight(weight: FontWeight): void {
    this.bulletListBulletTextFontWeight = weight
  }

  /**
   * 设置无序列表列表符号文本字体
   *
   * @param family 无序列表列表符号文本字体
   */
  setBulletListBulletTextFontFamily(family: string): void {
    this.bulletListBulletTextFontFamily = family
  }

  /**
   * 设置无序列表列表符号文本行高
   *
   * @param lineHeight 无序列表列表符号文本行高
   */
  setBulletListBulletTextLineHeight(lineHeight: number): void {
    this.bulletListBulletTextLineHeight = lineHeight
  }

  /**
   * 设置任务列表多选框和列表内容间距
   *
   * @param spacing 任务列表多选框和列表内容间距
   */
  setBulletListCheckboxSpacing(spacing: number): void {
    this.bulletListCheckboxSpacing = spacing
  }

  /**
   * 设置任务列表多选框宽度
   *
   * @param width 任务列表多选框宽度
   */
  setBulletListCheckboxWidth(width: number): void {
    this.bulletListCheckboxWidth = width
  }

  /**
   * 设置任务列表多选框高度
   *
   * @param height 任务列表多选框高度
   */
  setBulletListCheckboxHeight(height: number): void {
    this.bulletListCheckboxHeight = height
  }

  /**
   * 设置任务列表多选框选中颜色
   *
   * @param color 任务列表多选框选中颜色
   */
  setBulletListCheckboxSelectedColor(color: number): void {
    this.bulletListCheckboxSelectedColor = color
  }

  /**
   * 设置任务列表多选框形状
   *
   * @param shape 任务列表多选框形状
   */
  setBulletListCheckboxShape(shape: CheckBoxShape): void {
    this.bulletListCheckboxShape = shape
  }

  /**
   * 获取bulletListBackgroundColor
   *
   * @returns bulletListBackgroundColor
   */
  getBulletListBackgroundColor(): number | undefined {
    return this.bulletListBackgroundColor
  }

  /**
   * 获取bulletListMarginTop
   *
   * @returns bulletListMarginTop
   */
  getBulletListMarginTop(): number | undefined {
    return this.bulletListMarginTop
  }

  /**
   * 获取bulletListMarginRight
   *
   * @returns bulletListMarginRight
   */
  getBulletListMarginRight(): number | undefined {
    return this.bulletListMarginRight
  }

  /**
   * 获取bulletListMarginBottom
   *
   * @returns bulletListMarginBottom
   */
  getBulletListMarginBottom(): number | undefined {
    return this.bulletListMarginBottom
  }

  /**
   * 获取bulletListMarginLeft
   *
   * @returns bulletListMarginLeft
   */
  getBulletListMarginLeft(): number | undefined {
    return this.bulletListMarginLeft
  }

  /**
   * 获取bulletListPaddingTop
   *
   * @returns bulletListPaddingTop
   */
  getBulletListPaddingTop(): number | undefined {
    return this.bulletListPaddingTop
  }

  /**
   * 获取bulletListPaddingRight
   *
   * @returns bulletListPaddingRight
   */
  getBulletListPaddingRight(): number | undefined {
    return this.bulletListPaddingRight
  }

  /**
   * 获取bulletListPaddingBottom
   *
   * @returns bulletListPaddingBottom
   */
  getBulletListPaddingBottom(): number | undefined {
    return this.bulletListPaddingBottom
  }

  /**
   * 获取bulletListPaddingLeft
   *
   * @returns bulletListPaddingLeft
   */
  getBulletListPaddingLeft(): number | undefined {
    return this.bulletListPaddingLeft
  }

  /**
   * 获取bulletListChildSpacing
   *
   * @returns bulletListChildSpacing
   */
  getBulletListChildSpacing(): number | undefined {
    return this.bulletListChildSpacing
  }

  /**
   * 获取bulletListChildChildSpacing
   *
   * @returns bulletListChildChildSpacing
   */
  getBulletListChildChildSpacing(): number | undefined {
    return this.bulletListChildChildSpacing
  }

  /**
   * 获取bulletListBulletSpacing
   *
   * @returns bulletListBulletSpacing
   */
  getBulletListBulletSpacing(): number | undefined {
    return this.bulletListBulletSpacing
  }

  /**
   * 获取bulletListBulletIsCircle
   *
   * @returns bulletListBulletIsCircle
   */
  getBulletListBulletIsCircle(): boolean | undefined {
    return this.bulletListBulletIsCircle
  }

  /**
   * 获取bulletListBulletTextFontColor
   *
   * @returns bulletListBulletTextFontColor
   */
  getBulletListBulletTextFontColor(): number | undefined {
    return this.bulletListBulletTextFontColor
  }

  /**
   * 获取bulletListBulletTextFontSize
   *
   * @returns bulletListBulletTextFontSize
   */
  getBulletListBulletTextFontSize(): number | undefined {
    return this.bulletListBulletTextFontSize
  }

  /**
   * 获取bulletListBulletTextFontStyle
   *
   * @returns bulletListBulletTextFontStyle
   */
  getBulletListBulletTextFontStyle(): FontStyle | undefined {
    return this.bulletListBulletTextFontStyle
  }

  /**
   * 获取bulletListBulletTextFontWeight
   *
   * @returns bulletListBulletTextFontWeight
   */
  getBulletListBulletTextFontWeight(): FontWeight | undefined {
    return this.bulletListBulletTextFontWeight
  }

  /**
   * 获取bulletListBulletTextFontFamily
   *
   * @returns bulletListBulletTextFontFamily
   */
  getBulletListBulletTextFontFamily(): string | undefined {
    return this.bulletListBulletTextFontFamily
  }

  /**
   * 获取bulletListBulletTextLineHeight
   *
   * @returns bulletListBulletTextLineHeight
   */
  getBulletListBulletTextLineHeight(): number | undefined {
    return this.bulletListBulletTextLineHeight
  }

  /**
   * 获取bulletListCheckboxSpacing
   *
   * @returns bulletListCheckboxSpacing
   */
  getBulletListCheckboxSpacing(): number | undefined {
    return this.bulletListCheckboxSpacing
  }

  /**
   * 获取bulletListCheckboxWidth
   *
   * @returns bulletListCheckboxWidth
   */
  getBulletListCheckboxWidth(): number | undefined {
    return this.bulletListCheckboxWidth
  }

  /**
   * 获取bulletListCheckboxHeight
   *
   * @returns bulletListCheckboxHeight
   */
  getBulletListCheckboxHeight(): number | undefined {
    return this.bulletListCheckboxHeight
  }

  /**
   * 获取bulletListCheckboxSelectedColor
   *
   * @returns bulletListCheckboxSelectedColor
   */
  getBulletListCheckboxSelectedColor(): number | undefined {
    return this.bulletListCheckboxSelectedColor
  }

  /**
   * 获取bulletListCheckboxShape
   *
   * @returns bulletListCheckboxShape
   */
  getBulletListCheckboxShape(): CheckBoxShape | undefined {
    return this.bulletListCheckboxShape
  }
}
