/**
 * Markdown用户可设置的样式-无序/任务列表样式
 */
export class MarkdownThemeBulletList {
  /**
   * 无序/任务背景颜色
   */
  bulletListBackgroundColor?: number = undefined

  /**
   * 无序/任务上外边距
   */
  bulletListMarginTop?: number = undefined

  /**
   * 无序/任务右外边距
   */
  bulletListMarginRight?: number = undefined

  /**
   * 无序/任务下外边距
   */
  bulletListMarginBottom?: number = undefined

  /**
   * 无序/任务左外边距
   */
  bulletListMarginLeft?: number = undefined

  /**
   * 无序/任务上内边距
   */
  bulletListPaddingTop?: number = undefined

  /**
   * 无序/任务右内边距
   */
  bulletListPaddingRight?: number = undefined

  /**
   * 无序/任务下内边距
   */
  bulletListPaddingBottom?: number = undefined

  /**
   * 无序/任务左内边距
   */
  bulletListPaddingLeft?: number = undefined

  /**
   * 无序/任务子模块上下间距
   */
  bulletListChildSpacing?: number = undefined

  /**
   * 无序/任务子模块中子模块上下间距
   */
  bulletListChildChildSpacing?: number = undefined

  /**
   * 无序列表列表符号和列表内容间距
   */
  bulletListBulletSpacing?: number = undefined

  /**
   * 无序列表列表符号是否全部是实心圆型
   */
  bulletListBulletIsCircle?: boolean = undefined

  /**
   * 无序列表列表符号文本颜色
   */
  bulletListBulletTextFontColor?: number = undefined

  /**
   * 无序列表列表符号文本尺寸
   */
  bulletListBulletTextFontSize?: number = undefined

  /**
   * 无序列表列表符号文本字体样式
   */
  bulletListBulletTextFontStyle?: FontStyle = undefined

  /**
   * 无序列表列表符号文本字体粗细
   */
  bulletListBulletTextFontWeight?: FontWeight = undefined

  /**
   * 无序列表列表符号文本字体
   */
  bulletListBulletTextFontFamily?: string = undefined

  /**
   * 无序列表列表符号文本行高
   */
  bulletListBulletTextLineHeight?: number = undefined

  /**
   * 任务列表多选框和列表内容间距
   */
  bulletListCheckboxSpacing?: number = undefined

  /**
   * 任务列表多选框宽度
   */
  bulletListCheckboxWidth?: number = undefined

  /**
   * 任务列表多选框高度
   */
  bulletListCheckboxHeight?: number = undefined

  /**
   * 任务列表多选框选中颜色
   */
  bulletListCheckboxSelectedColor?: number = undefined

  /**
   * 任务列表多选框形状
   */
  bulletListCheckboxShape?: CheckBoxShape = undefined

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
}
