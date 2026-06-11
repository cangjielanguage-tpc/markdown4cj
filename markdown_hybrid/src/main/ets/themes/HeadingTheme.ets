import { MarkdownMarginOptions, MarkdownPaddingOptions } from "./MarkdownTheme"

/**
 * Markdown用户可设置的样式-标题样式
 */
export class HeadingTheme {
  /**
   * 一级标题背景颜色
   */
  private heading1BackgroundColor?: number = undefined

  /**
   * 一级标题上外边距
   */
  private heading1MarginTop?: number = undefined

  /**
   * 一级标题右外边距
   */
  private heading1MarginRight?: number = undefined

  /**
   * 一级标题下外边距
   */
  private heading1MarginBottom?: number = undefined

  /**
   * 一级标题左外边距
   */
  private heading1MarginLeft?: number = undefined

  /**
   * 一级标题上内边距
   */
  private heading1PaddingTop?: number = undefined

  /**
   * 一级标题右内边距
   */
  private heading1PaddingRight?: number = undefined

  /**
   * 一级标题下内边距
   */
  private heading1PaddingBottom?: number = undefined

  /**
   * 一级标题左内边距
   */
  private heading1PaddingLeft?: number = undefined

  /**
   * 一级标题文本颜色
   */
  private heading1TextFontColor?: number = undefined

  /**
   * 一级标题文本尺寸
   */
  private heading1TextFontSize?: number = undefined

  /**
   * 一级标题文本字体样式
   */
  private heading1TextFontStyle?: FontStyle = undefined

  /**
   * 一级标题文本字体粗细
   */
  private heading1TextFontWeight?: FontWeight = undefined

  /**
   * 一级标题文本字体
   */
  private heading1TextFontFamily?: string = undefined

  /**
   * 一级标题文本行高
   */
  private heading1TextLineHeight?: number = undefined

  /**
   * 一级标题文本字符间距
   */
  private heading1TextLetterSpacing?: number = undefined

  /**
   * 一级标题下划线高度
   */
  private heading1UnderlineHeight?: number = undefined

  /**
   * 一级标题下划线颜色
   */
  private heading1UnderlineColor?: number = undefined

  /**
   * 一级标题距离标题文本间距
   */
  private heading1UnderlineSpacing?: number = undefined

  /**
   * 二级标题背景颜色
   */
  private heading2BackgroundColor?: number = undefined

  /**
   * 二级标题上外边距
   */
  private heading2MarginTop?: number = undefined

  /**
   * 二级标题右外边距
   */
  private heading2MarginRight?: number = undefined

  /**
   * 二级标题下外边距
   */
  private heading2MarginBottom?: number = undefined

  /**
   * 二级标题左外边距
   */
  private heading2MarginLeft?: number = undefined

  /**
   * 二级标题上内边距
   */
  private heading2PaddingTop?: number = undefined

  /**
   * 二级标题右内边距
   */
  private heading2PaddingRight?: number = undefined

  /**
   * 二级标题下内边距
   */
  private heading2PaddingBottom?: number = undefined

  /**
   * 二级标题左内边距
   */
  private heading2PaddingLeft?: number = undefined

  /**
   * 二级标题文本颜色
   */
  private heading2TextFontColor?: number = undefined

  /**
   * 二级标题文本尺寸
   */
  private heading2TextFontSize?: number = undefined

  /**
   * 二级标题文本字体样式
   */
  private heading2TextFontStyle?: FontStyle = undefined

  /**
   * 二级标题文本字体粗细
   */
  private heading2TextFontWeight?: FontWeight = undefined

  /**
   * 二级标题文本字体
   */
  private heading2TextFontFamily?: string = undefined

  /**
   * 二级标题文本行高
   */
  private heading2TextLineHeight?: number = undefined

  /**
   * 二级标题文本字符间距
   */
  private heading2TextLetterSpacing?: number = undefined

  /**
   * 二级标题下划线高度
   */
  private heading2UnderlineHeight?: number = undefined

  /**
   * 二级标题下划线颜色
   */
  private heading2UnderlineColor?: number = undefined

  /**
   * 二级标题距离标题文本间距
   */
  private heading2UnderlineSpacing?: number = undefined

  /**
   * 三级标题背景颜色
   */
  private heading3BackgroundColor?: number = undefined

  /**
   * 三级标题上外边距
   */
  private heading3MarginTop?: number = undefined

  /**
   * 三级标题右外边距
   */
  private heading3MarginRight?: number = undefined

  /**
   * 三级标题下外边距
   */
  private heading3MarginBottom?: number = undefined

  /**
   * 三级标题左外边距
   */
  private heading3MarginLeft?: number = undefined

  /**
   * 三级标题上内边距
   */
  private heading3PaddingTop?: number = undefined

  /**
   * 三级标题右内边距
   */
  private heading3PaddingRight?: number = undefined

  /**
   * 三级标题下内边距
   */
  private heading3PaddingBottom?: number = undefined

  /**
   * 三级标题左内边距
   */
  private heading3PaddingLeft?: number = undefined

  /**
   * 三级标题文本颜色
   */
  private heading3TextFontColor?: number = undefined

  /**
   * 三级标题文本尺寸
   */
  private heading3TextFontSize?: number = undefined

  /**
   * 三级标题文本字体样式
   */
  private heading3TextFontStyle?: FontStyle = undefined

  /**
   * 三级标题文本字体粗细
   */
  private heading3TextFontWeight?: FontWeight = undefined

  /**
   * 三级标题文本字体
   */
  private heading3TextFontFamily?: string = undefined

  /**
   * 三级标题文本行高
   */
  private heading3TextLineHeight?: number = undefined

  /**
   * 三级标题文本字符间距
   */
  private heading3TextLetterSpacing?: number = undefined

  /**
   * 四级标题背景颜色
   */
  private heading4BackgroundColor?: number = undefined

  /**
   * 四级标题上外边距
   */
  private heading4MarginTop?: number = undefined

  /**
   * 四级标题右外边距
   */
  private heading4MarginRight?: number = undefined

  /**
   * 四级标题下外边距
   */
  private heading4MarginBottom?: number = undefined

  /**
   * 四级标题左外边距
   */
  private heading4MarginLeft?: number = undefined

  /**
   * 四级标题上内边距
   */
  private heading4PaddingTop?: number = undefined

  /**
   * 四级标题右内边距
   */
  private heading4PaddingRight?: number = undefined

  /**
   * 四级标题下内边距
   */
  private heading4PaddingBottom?: number = undefined

  /**
   * 四级标题左内边距
   */
  private heading4PaddingLeft?: number = undefined

  /**
   * 四级标题文本颜色
   */
  private heading4TextFontColor?: number = undefined

  /**
   * 四级标题文本尺寸
   */
  private heading4TextFontSize?: number = undefined

  /**
   * 四级标题文本字体样式
   */
  private heading4TextFontStyle?: FontStyle = undefined

  /**
   * 四级标题文本字体粗细
   */
  private heading4TextFontWeight?: FontWeight = undefined

  /**
   * 四级标题文本字体
   */
  private heading4TextFontFamily?: string = undefined

  /**
   * 四级标题文本行高
   */
  private heading4TextLineHeight?: number = undefined

  /**
   * 四级标题文本字符间距
   */
  private heading4TextLetterSpacing?: number = undefined

  /**
   * 五级标题背景颜色
   */
  private heading5BackgroundColor?: number = undefined

  /**
   * 五级标题上外边距
   */
  private heading5MarginTop?: number = undefined

  /**
   * 五级标题右外边距
   */
  private heading5MarginRight?: number = undefined

  /**
   * 五级标题下外边距
   */
  private heading5MarginBottom?: number = undefined

  /**
   * 五级标题左外边距
   */
  private heading5MarginLeft?: number = undefined

  /**
   * 五级标题上内边距
   */
  private heading5PaddingTop?: number = undefined

  /**
   * 五级标题右内边距
   */
  private heading5PaddingRight?: number = undefined

  /**
   * 五级标题下内边距
   */
  private heading5PaddingBottom?: number = undefined

  /**
   * 五级标题左内边距
   */
  private heading5PaddingLeft?: number = undefined

  /**
   * 五级标题文本颜色
   */
  private heading5TextFontColor?: number = undefined

  /**
   * 五级标题文本尺寸
   */
  private heading5TextFontSize?: number = undefined

  /**
   * 五级标题文本字体样式
   */
  private heading5TextFontStyle?: FontStyle = undefined

  /**
   * 五级标题文本字体粗细
   */
  private heading5TextFontWeight?: FontWeight = undefined

  /**
   * 五级标题文本字体
   */
  private heading5TextFontFamily?: string = undefined

  /**
   * 五级标题文本行高
   */
  private heading5TextLineHeight?: number = undefined

  /**
   * 五级标题文本字符间距
   */
  private heading5TextLetterSpacing?: number = undefined

  /**
   * 六级标题背景颜色
   */
  private heading6BackgroundColor?: number = undefined

  /**
   * 六级标题上外边距
   */
  private heading6MarginTop?: number = undefined

  /**
   * 六级标题右外边距
   */
  private heading6MarginRight?: number = undefined

  /**
   * 六级标题下外边距
   */
  private heading6MarginBottom?: number = undefined

  /**
   * 六级标题左外边距
   */
  private heading6MarginLeft?: number = undefined

  /**
   * 六级标题上内边距
   */
  private heading6PaddingTop?: number = undefined

  /**
   * 六级标题右内边距
   */
  private heading6PaddingRight?: number = undefined

  /**
   * 六级标题下内边距
   */
  private heading6PaddingBottom?: number = undefined

  /**
   * 六级标题左内边距
   */
  private heading6PaddingLeft?: number = undefined

  /**
   * 六级标题文本颜色
   */
  private heading6TextFontColor?: number = undefined

  /**
   * 六级标题文本尺寸
   */
  private heading6TextFontSize?: number = undefined

  /**
   * 六级标题文本字体样式
   */
  private heading6TextFontStyle?: FontStyle = undefined

  /**
   * 六级标题文本字体粗细
   */
  private heading6TextFontWeight?: FontWeight = undefined

  /**
   * 六级标题文本字体
   */
  private heading6TextFontFamily?: string = undefined

  /**
   * 六级标题文本行高
   */
  private heading6TextLineHeight?: number = undefined

  /**
   * 六级标题文本字符间距
   */
  private heading6TextLetterSpacing?: number = undefined

  /**
   * 设置标题的背景颜色：设置所有标题为统一背景颜色
   *
   * @param color 背景颜色
   */
  setBackgroundColorForAllHeading(color: number): HeadingTheme {
    this.heading1BackgroundColor = color
    this.heading2BackgroundColor = color
    this.heading3BackgroundColor = color
    this.heading4BackgroundColor = color
    this.heading5BackgroundColor = color
    this.heading6BackgroundColor = color
    return this
  }

  /**
   * 设置标题的背景颜色：通过集合的方式，分别设置每级标题的背景颜色
   *
   * @param colorList 背景颜色集合
   */
  setBackgroundColorForEachHeading(colorList: number[]): HeadingTheme {
    let level = 1
    for (const color of colorList) {
      this.setBackgroundColorForDesignateHeading(level, color)
      level += 1
    }
    return this
  }

  /**
   * 设置标题的背景颜色：指定标题等级，设置该等级标题的背景颜色
   *
   * @param level 标题等级
   * @param color 背景颜色
   */
  setBackgroundColorForDesignateHeading(level: number, color: number): HeadingTheme {
    switch (level) {
      case 1:
        this.heading1BackgroundColor = color
        break
      case 2:
        this.heading2BackgroundColor = color
        break
      case 3:
        this.heading3BackgroundColor = color
        break
      case 4:
        this.heading4BackgroundColor = color
        break
      case 5:
        this.heading5BackgroundColor = color
        break
      case 6:
        this.heading6BackgroundColor = color
        break
      default:
        break
    }
    return this
  }

  /**
   * 设置标题的4个外边距：设置H1-H6级标题，所有等级的某一个外边距为统一值
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时所有外边距设为相同值
   *                  入参 MarkdownMarginOptions 类型时设置H1-H6级的top（right, bottom, left）外边距为统一值
   */
  setMarginForAllHeadingEachLevel(options: MarkdownMarginOptions | number): HeadingTheme {
    this.setMarginForDesignateHeading(1, options)
    this.setMarginForDesignateHeading(2, options)
    this.setMarginForDesignateHeading(3, options)
    this.setMarginForDesignateHeading(4, options)
    this.setMarginForDesignateHeading(5, options)
    this.setMarginForDesignateHeading(6, options)
    return this
  }

  /**
   * 设置标题的4个外边距：设置H1-H6级标题，每级标题自己的4个外边距为统一值
   *
   * @param marginList 外边距集合
   */
  setMarginForEachHeading(marginList: number[]): HeadingTheme {
    let level = 1
    for (const margin of marginList) {
      this.setMarginForDesignateHeading(level, margin)
      level += 1
    }
    return this
  }

  /**
   * 设置标题的4个外边距：分别设置H1-H6每级标题的每个外边距
   *
   * @param top 上外边距集合
   * @param right 右外边距集合
   * @param bottom 下外边距集合
   * @param left 左外边距集合
   */
  setMarginForEachHeadingDetail(top: number[], right: number[], bottom: number[], left: number[]): HeadingTheme {
    for (let index = 0; index < top.length; index++) {
      this.setMarginForDesignateHeading((index + 1), {top: top[index]})
    }
    for (let index = 0; index < right.length; index++) {
      this.setMarginForDesignateHeading((index + 1), {right: right[index]})
    }
    for (let index = 0; index < bottom.length; index++) {
      this.setMarginForDesignateHeading((index + 1), {bottom: bottom[index]})
    }
    for (let index = 0; index < left.length; index++) {
      this.setMarginForDesignateHeading((index + 1), {left: left[index]})
    }
    return this
  }

  /**
   * 设置标题的4个外边距：指定标题等级，分别设置该标题的每个外边距
   *
   * @param level 标题等级
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setMarginForDesignateHeading(level: number, options: MarkdownMarginOptions | number): HeadingTheme {
    switch (level) {
      case 1:
        if (typeof options === 'number') {
          this.heading1MarginTop = options
          this.heading1MarginRight = options
          this.heading1MarginBottom = options
          this.heading1MarginLeft = options
        } else {
          if (options.top !== undefined) this.heading1MarginTop = options.top
          if (options.right !== undefined) this.heading1MarginRight = options.right
          if (options.bottom !== undefined) this.heading1MarginBottom = options.bottom
          if (options.left !== undefined) this.heading1MarginLeft = options.left
        }
        break
      case 2:
        if (typeof options === 'number') {
          this.heading2MarginTop = options
          this.heading2MarginRight = options
          this.heading2MarginBottom = options
          this.heading2MarginLeft = options
        } else {
          if (options.top !== undefined) this.heading2MarginTop = options.top
          if (options.right !== undefined) this.heading2MarginRight = options.right
          if (options.bottom !== undefined) this.heading2MarginBottom = options.bottom
          if (options.left !== undefined) this.heading2MarginLeft = options.left
        }
        break
      case 3:
        if (typeof options === 'number') {
          this.heading3MarginTop = options
          this.heading3MarginRight = options
          this.heading3MarginBottom = options
          this.heading3MarginLeft = options
        } else {
          if (options.top !== undefined) this.heading3MarginTop = options.top
          if (options.right !== undefined) this.heading3MarginRight = options.right
          if (options.bottom !== undefined) this.heading3MarginBottom = options.bottom
          if (options.left !== undefined) this.heading3MarginLeft = options.left
        }
        break
      case 4:
        if (typeof options === 'number') {
          this.heading4MarginTop = options
          this.heading4MarginRight = options
          this.heading4MarginBottom = options
          this.heading4MarginLeft = options
        } else {
          if (options.top !== undefined) this.heading4MarginTop = options.top
          if (options.right !== undefined) this.heading4MarginRight = options.right
          if (options.bottom !== undefined) this.heading4MarginBottom = options.bottom
          if (options.left !== undefined) this.heading4MarginLeft = options.left
        }
        break
      case 5:
        if (typeof options === 'number') {
          this.heading5MarginTop = options
          this.heading5MarginRight = options
          this.heading5MarginBottom = options
          this.heading5MarginLeft = options
        } else {
          if (options.top !== undefined) this.heading5MarginTop = options.top
          if (options.right !== undefined) this.heading5MarginRight = options.right
          if (options.bottom !== undefined) this.heading5MarginBottom = options.bottom
          if (options.left !== undefined) this.heading5MarginLeft = options.left
        }
        break
      case 6:
        if (typeof options === 'number') {
          this.heading6MarginTop = options
          this.heading6MarginRight = options
          this.heading6MarginBottom = options
          this.heading6MarginLeft = options
        } else {
          if (options.top !== undefined) this.heading6MarginTop = options.top
          if (options.right !== undefined) this.heading6MarginRight = options.right
          if (options.bottom !== undefined) this.heading6MarginBottom = options.bottom
          if (options.left !== undefined) this.heading6MarginLeft = options.left
        }
        break
      default:
        break
    }
    return this
  }

  /**
   * 设置标题的4个内边距：设置H1-H6级标题，所有等级的内边距为统一值，或某一个内边距6个级别为统一值
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时所有内边距设为相同值
   *                  入参 MarkdownPaddingOptions 类型时设置H1-H6级的top（right, bottom, left）内边距为统一值
   */
  setPaddingForAllHeadingEachLevel(options: MarkdownPaddingOptions | number): HeadingTheme {
    this.setPaddingForDesignateHeading(1, options)
    this.setPaddingForDesignateHeading(2, options)
    this.setPaddingForDesignateHeading(3, options)
    this.setPaddingForDesignateHeading(4, options)
    this.setPaddingForDesignateHeading(5, options)
    this.setPaddingForDesignateHeading(6, options)
    return this
  }

  /**
   * 设置标题的4个内边距：设置H1-H6级标题，每级标题自己的4个内边距为统一值
   *
   * @param paddingList 内边距集合
   */
  setPaddingForEachHeading(paddingList: number[]): HeadingTheme {
    let level = 1
    for (const padding of paddingList) {
      this.setPaddingForDesignateHeading(level, padding)
      level += 1
    }
    return this
  }

  /**
   * 设置标题的4个内边距：分别设置H1-H6每级标题的每个内边距
   *
   * @param top 上内边距集合
   * @param right 右内边距集合
   * @param bottom 下内边距集合
   * @param left 左内边距集合
   */
  setPaddingForEachHeadingDetail(top: number[], right: number[], bottom: number[], left: number[]): HeadingTheme {
    for (let index = 0; index < top.length; index++) {
      this.setPaddingForDesignateHeading((index + 1), {top:top[index]})
    }
    for (let index = 0; index < right.length; index++) {
      this.setPaddingForDesignateHeading((index + 1), {right:right[index]})
    }
    for (let index = 0; index < bottom.length; index++) {
      this.setPaddingForDesignateHeading((index + 1), {bottom:bottom[index]})
    }
    for (let index = 0; index < left.length; index++) {
      this.setPaddingForDesignateHeading((index + 1), {left:left[index]})
    }
    return this
  }

  /**
   * 设置标题的4个内边距：指定标题等级，分别设置该标题的每个内边距
   *
   * @param level 标题等级
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setPaddingForDesignateHeading(level: number, options: MarkdownPaddingOptions | number): HeadingTheme {
    switch (level) {
      case 1:
        if (typeof options === 'number') {
          this.heading1PaddingTop = options
          this.heading1PaddingRight = options
          this.heading1PaddingBottom = options
          this.heading1PaddingLeft = options
        } else {
          if (options.top !== undefined) this.heading1PaddingTop = options.top
          if (options.right !== undefined) this.heading1PaddingRight = options.right
          if (options.bottom !== undefined) this.heading1PaddingBottom = options.bottom
          if (options.left !== undefined) this.heading1PaddingLeft = options.left
        }
        break
      case 2:
        if (typeof options === 'number') {
          this.heading2PaddingTop = options
          this.heading2PaddingRight = options
          this.heading2PaddingBottom = options
          this.heading2PaddingLeft = options
        } else {
          if (options.top !== undefined) this.heading2PaddingTop = options.top
          if (options.right !== undefined) this.heading2PaddingRight = options.right
          if (options.bottom !== undefined) this.heading2PaddingBottom = options.bottom
          if (options.left !== undefined) this.heading2PaddingLeft = options.left
        }
        break
      case 3:
        if (typeof options === 'number') {
          this.heading3PaddingTop = options
          this.heading3PaddingRight = options
          this.heading3PaddingBottom = options
          this.heading3PaddingLeft = options
        } else {
          if (options.top !== undefined) this.heading3PaddingTop = options.top
          if (options.right !== undefined) this.heading3PaddingRight = options.right
          if (options.bottom !== undefined) this.heading3PaddingBottom = options.bottom
          if (options.left !== undefined) this.heading3PaddingLeft = options.left
        }
        break
      case 4:
        if (typeof options === 'number') {
          this.heading4PaddingTop = options
          this.heading4PaddingRight = options
          this.heading4PaddingBottom = options
          this.heading4PaddingLeft = options
        } else {
          if (options.top !== undefined) this.heading4PaddingTop = options.top
          if (options.right !== undefined) this.heading4PaddingRight = options.right
          if (options.bottom !== undefined) this.heading4PaddingBottom = options.bottom
          if (options.left !== undefined) this.heading4PaddingLeft = options.left
        }
        break
      case 5:
        if (typeof options === 'number') {
          this.heading5PaddingTop = options
          this.heading5PaddingRight = options
          this.heading5PaddingBottom = options
          this.heading5PaddingLeft = options
        } else {
          if (options.top !== undefined) this.heading5PaddingTop = options.top
          if (options.right !== undefined) this.heading5PaddingRight = options.right
          if (options.bottom !== undefined) this.heading5PaddingBottom = options.bottom
          if (options.left !== undefined) this.heading5PaddingLeft = options.left
        }
        break
      case 6:
        if (typeof options === 'number') {
          this.heading6PaddingTop = options
          this.heading6PaddingRight = options
          this.heading6PaddingBottom = options
          this.heading6PaddingLeft = options
        } else {
          if (options.top !== undefined) this.heading6PaddingTop = options.top
          if (options.right !== undefined) this.heading6PaddingRight = options.right
          if (options.bottom !== undefined) this.heading6PaddingBottom = options.bottom
          if (options.left !== undefined) this.heading6PaddingLeft = options.left
        }
        break
      default:
        break
    }
    return this
  }

  /**
   * 设置标题文本颜色：所有标题的统一文本颜色
   *
   * @param color 文本颜色
   */
  setTextFontColorForAllHeading(color: number): HeadingTheme {
    this.heading1TextFontColor = color
    this.heading2TextFontColor = color
    this.heading3TextFontColor = color
    this.heading4TextFontColor = color
    this.heading5TextFontColor = color
    this.heading6TextFontColor = color
    return this
  }

  /**
   * 设置标题文本颜色：分别设置每级标题的文本颜色
   *
   * @param colorList 文本颜色集合
   */
  setTextFontColorForEachHeading(colorList: number[]): HeadingTheme {
    let level = 1
    for (const color of colorList) {
      this.setTextFontColorForDesignateHeading(level, color)
      level += 1
    }
    return this
  }

  /**
   * 设置标题文本颜色：设置指定等级的标题的文本颜色
   *
   * @param level 标题等级
   * @param color 文本颜色
   */
  setTextFontColorForDesignateHeading(level: number, color: number): HeadingTheme {
    switch (level) {
      case 1:
        this.heading1TextFontColor = color
        break
      case 2:
        this.heading2TextFontColor = color
        break
      case 3:
        this.heading3TextFontColor = color
        break
      case 4:
        this.heading4TextFontColor = color
        break
      case 5:
        this.heading5TextFontColor = color
        break
      case 6:
        this.heading6TextFontColor = color
        break
      default:
        break
    }
    return this
  }

  /**
   * 设置标题文本尺寸：所有标题的统一文本尺寸
   *
   * @param size 文本尺寸
   */
  setTextFontSizeForAllHeading(size: number): HeadingTheme {
    this.heading1TextFontSize = size
    this.heading2TextFontSize = size
    this.heading3TextFontSize = size
    this.heading4TextFontSize = size
    this.heading5TextFontSize = size
    this.heading6TextFontSize = size
    return this
  }

  /**
   * 设置标题文本尺寸：分别设置每级标题的文本尺寸
   *
   * @param sizeList 文本尺寸集合
   */
  setTextFontSizeForEachHeading(sizeList: number[]): HeadingTheme {
    let level = 1
    for (const size of sizeList) {
      this.setTextFontSizeForDesignateHeading(level, size)
      level += 1
    }
    return this
  }

  /**
   * 设置标题文本尺寸：设置指定等级的标题的文本尺寸
   *
   * @param level 标题等级
   * @param size 文本尺寸
   */
  setTextFontSizeForDesignateHeading(level: number, size: number): HeadingTheme {
    switch (level) {
      case 1:
        this.heading1TextFontSize = size
        break
      case 2:
        this.heading2TextFontSize = size
        break
      case 3:
        this.heading3TextFontSize = size
        break
      case 4:
        this.heading4TextFontSize = size
        break
      case 5:
        this.heading5TextFontSize = size
        break
      case 6:
        this.heading6TextFontSize = size
        break
      default:
        break
    }
    return this
  }

  /**
   * 设置标题文本字体样式：所有标题的统一文本字体样式
   *
   * @param style 文本字体样式
   */
  setTextFontStyleForAllHeading(style: FontStyle): HeadingTheme {
    this.heading1TextFontStyle = style
    this.heading2TextFontStyle = style
    this.heading3TextFontStyle = style
    this.heading4TextFontStyle = style
    this.heading5TextFontStyle = style
    this.heading6TextFontStyle = style
    return this
  }

  /**
   * 设置标题文本字体样式：分别设置每级标题的文本字体样式
   *
   * @param styleList 文本字体样式集合
   */
  setTextFontStyleForEachHeading(styleList: FontStyle[]): HeadingTheme {
    let level = 1
    for (const style of styleList) {
      this.setTextFontStyleForDesignateHeading(level, style)
      level += 1
    }
    return this
  }

  /**
   * 设置标题文本字体样式：设置指定等级的标题的文本字体样式
   *
   * @param level 标题等级
   * @param style 文本字体样式
   */
  setTextFontStyleForDesignateHeading(level: number, style: FontStyle): HeadingTheme {
    switch (level) {
      case 1:
        this.heading1TextFontStyle = style
        break
      case 2:
        this.heading2TextFontStyle = style
        break
      case 3:
        this.heading3TextFontStyle = style
        break
      case 4:
        this.heading4TextFontStyle = style
        break
      case 5:
        this.heading5TextFontStyle = style
        break
      case 6:
        this.heading6TextFontStyle = style
        break
      default:
        break
    }
    return this
  }

  /**
   * 设置标题文本字体粗细：所有标题的统一文本字体粗细
   *
   * @param weight 文本字体粗细
   */
  setTextFontWeightForAllHeading(weight: FontWeight): HeadingTheme {
    this.heading1TextFontWeight = weight
    this.heading2TextFontWeight = weight
    this.heading3TextFontWeight = weight
    this.heading4TextFontWeight = weight
    this.heading5TextFontWeight = weight
    this.heading6TextFontWeight = weight
    return this
  }

  /**
   * 设置标题文本字体粗细：分别设置每级标题的文本字体粗细
   *
   * @param weightList 文本字体粗细集合
   */
  setTextFontWeightForEachHeading(weightList: FontWeight[]): HeadingTheme {
    let level = 1
    for (const weight of weightList) {
      this.setTextFontWeightForDesignateHeading(level, weight)
      level += 1
    }
    return this
  }

  /**
   * 设置标题文本字体粗细：设置指定等级的标题的文本字体粗细
   *
   * @param level 标题等级
   * @param weight 文本字体粗细
   */
  setTextFontWeightForDesignateHeading(level: number, weight: FontWeight): HeadingTheme {
    switch (level) {
      case 1:
        this.heading1TextFontWeight = weight
        break
      case 2:
        this.heading2TextFontWeight = weight
        break
      case 3:
        this.heading3TextFontWeight = weight
        break
      case 4:
        this.heading4TextFontWeight = weight
        break
      case 5:
        this.heading5TextFontWeight = weight
        break
      case 6:
        this.heading6TextFontWeight = weight
        break
      default:
        break
    }
    return this
  }

  /**
   * 设置标题文本字体：所有标题的统一文本字体
   *
   * @param family 文本字体
   */
  setTextFontFamilyForAllHeading(family: string): HeadingTheme {
    this.heading1TextFontFamily = family
    this.heading2TextFontFamily = family
    this.heading3TextFontFamily = family
    this.heading4TextFontFamily = family
    this.heading5TextFontFamily = family
    this.heading6TextFontFamily = family
    return this
  }

  /**
   * 设置标题文本字体：分别设置每级标题的文本字体
   *
   * @param familyList 文本字体集合
   */
  setTextFontFamilyForEachHeading(familyList: string[]): HeadingTheme {
    let level = 1
    for (const family of familyList) {
      this.setTextFontFamilyForDesignateHeading(level, family)
      level += 1
    }
    return this
  }

  /**
   * 设置标题文本字体：设置指定等级的标题的文本字体
   *
   * @param level 标题等级
   * @param family 文本字体
   */
  setTextFontFamilyForDesignateHeading(level: number, family: string): HeadingTheme {
    switch (level) {
      case 1:
        this.heading1TextFontFamily = family
        break
      case 2:
        this.heading2TextFontFamily = family
        break
      case 3:
        this.heading3TextFontFamily = family
        break
      case 4:
        this.heading4TextFontFamily = family
        break
      case 5:
        this.heading5TextFontFamily = family
        break
      case 6:
        this.heading6TextFontFamily = family
        break
      default:
        break
    }
    return this
  }

  /**
   * 设置标题文本行高：所有标题的统一文本行高
   *
   * @param lineHeight 文本行高
   */
  setTextLineHeightForAllHeading(lineHeight: number): HeadingTheme {
    this.heading1TextLineHeight = lineHeight
    this.heading2TextLineHeight = lineHeight
    this.heading3TextLineHeight = lineHeight
    this.heading4TextLineHeight = lineHeight
    this.heading5TextLineHeight = lineHeight
    this.heading6TextLineHeight = lineHeight
    return this
  }

  /**
   * 设置标题文本行高：分别设置每级标题的文本行高
   *
   * @param lineHeightList 文本行高集合
   */
  setTextLineHeightForEachHeading(lineHeightList: number[]): HeadingTheme {
    let level = 1
    for (const lineHeight of lineHeightList) {
      this.setTextLineHeightForDesignateHeading(level, lineHeight)
      level += 1
    }
    return this
  }

  /**
   * 设置标题文本行高：设置指定等级的标题的文本行高
   *
   * @param level 标题等级
   * @param lineHeight 文本行高
   */
  setTextLineHeightForDesignateHeading(level: number, lineHeight: number): HeadingTheme {
    switch (level) {
      case 1:
        this.heading1TextLineHeight = lineHeight
        break
      case 2:
        this.heading2TextLineHeight = lineHeight
        break
      case 3:
        this.heading3TextLineHeight = lineHeight
        break
      case 4:
        this.heading4TextLineHeight = lineHeight
        break
      case 5:
        this.heading5TextLineHeight = lineHeight
        break
      case 6:
        this.heading6TextLineHeight = lineHeight
        break
      default:
        break
    }
    return this
  }

  /**
   * 设置标题文本字符间距：所有标题的统一文本字符间距
   *
   * @param spacing 文本字符间距
   */
  setTextLetterSpacingForAllHeading(spacing: number): HeadingTheme {
    this.heading1TextLetterSpacing = spacing
    this.heading2TextLetterSpacing = spacing
    this.heading3TextLetterSpacing = spacing
    this.heading4TextLetterSpacing = spacing
    this.heading5TextLetterSpacing = spacing
    this.heading6TextLetterSpacing = spacing
    return this
  }

  /**
   * 设置标题文本字符间距：分别设置每级标题的文本字符间距
   *
   * @param spacingList 文本字符间距集合
   */
  setTextLetterSpacingForEachHeading(spacingList: number[]): HeadingTheme {
    let level = 1
    for (const spacing of spacingList) {
      this.setTextLetterSpacingForDesignateHeading(level, spacing)
      level += 1
    }
    return this
  }

  /**
   * 设置标题文本字符间距：设置指定等级的标题的文本字符间距
   *
   * @param level 标题等级
   * @param spacing 文本字符间距
   */
  setTextLetterSpacingForDesignateHeading(level: number, spacing: number): HeadingTheme {
    switch (level) {
      case 1:
        this.heading1TextLetterSpacing = spacing
        break
      case 2:
        this.heading2TextLetterSpacing = spacing
        break
      case 3:
        this.heading3TextLetterSpacing = spacing
        break
      case 4:
        this.heading4TextLetterSpacing = spacing
        break
      case 5:
        this.heading5TextLetterSpacing = spacing
        break
      case 6:
        this.heading6TextLetterSpacing = spacing
        break
      default:
        break
    }
    return this
  }

  /**
   * 设置标题下划线高度：H1和H2标题的统一下划线高度
   *
   * @param height 下划线高度
   */
  setUnderlineHeightForAllHeading(height: number): HeadingTheme {
    this.heading1UnderlineHeight = height
    this.heading2UnderlineHeight = height
    return this
  }

  /**
   * 设置标题下划线高度：设置指定等级标题的下划线高度（仅H1和H2）
   *
   * @param level 标题等级
   * @param height 下划线高度
   */
  setUnderlineHeightForDesignateHeading(level: number, height: number): HeadingTheme {
    switch (level) {
      case 1:
        this.heading1UnderlineHeight = height
        break
      case 2:
        this.heading2UnderlineHeight = height
        break
      default:
        break
    }
    return this
  }

  /**
   * 设置标题下划线颜色：H1和H2标题的统一下划线颜色
   *
   * @param color 下划线颜色
   */
  setUnderlineColorForAllHeading(color: number): HeadingTheme {
    this.heading1UnderlineColor = color
    this.heading2UnderlineColor = color
    return this
  }

  /**
   * 设置标题下划线颜色：设置指定等级标题的下划线颜色（仅H1和H2）
   *
   * @param level 标题等级
   * @param color 下划线颜色
   */
  setUnderlineColorForDesignateHeading(level: number, color: number): HeadingTheme {
    switch (level) {
      case 1:
        this.heading1UnderlineColor = color
        break
      case 2:
        this.heading2UnderlineColor = color
        break
      default:
        break
    }
    return this
  }

  /**
   * 设置标题下划线间距：H1和H2标题的统一下划线间距
   *
   * @param spacing 下划线间距
   */
  setUnderlineSpacingForAllHeading(spacing: number): HeadingTheme {
    this.heading1UnderlineSpacing = spacing
    this.heading2UnderlineSpacing = spacing
    return this
  }

  /**
   * 设置标题下划线间距：设置指定等级标题的下划线间距（仅H1和H2）
   *
   * @param level 标题等级
   * @param spacing 下划线间距
   */
  setUnderlineSpacingForDesignateHeading(level: number, spacing: number): HeadingTheme {
    switch (level) {
      case 1:
        this.heading1UnderlineSpacing = spacing
        break
      case 2:
        this.heading2UnderlineSpacing = spacing
        break
      default:
        break
    }
    return this
  }

  /**
   * 获取heading1BackgroundColor
   *
   * @returns heading1BackgroundColor
   */
  getHeading1BackgroundColor(): number | undefined {
    return this.heading1BackgroundColor
  }

  /**
   * 获取heading1MarginTop
   *
   * @returns heading1MarginTop
   */
  getHeading1MarginTop(): number | undefined {
    return this.heading1MarginTop
  }

  /**
   * 获取heading1MarginRight
   *
   * @returns heading1MarginRight
   */
  getHeading1MarginRight(): number | undefined {
    return this.heading1MarginRight
  }

  /**
   * 获取heading1MarginBottom
   *
   * @returns heading1MarginBottom
   */
  getHeading1MarginBottom(): number | undefined {
    return this.heading1MarginBottom
  }

  /**
   * 获取heading1MarginLeft
   *
   * @returns heading1MarginLeft
   */
  getHeading1MarginLeft(): number | undefined {
    return this.heading1MarginLeft
  }

  /**
   * 获取heading1PaddingTop
   *
   * @returns heading1PaddingTop
   */
  getHeading1PaddingTop(): number | undefined {
    return this.heading1PaddingTop
  }

  /**
   * 获取heading1PaddingRight
   *
   * @returns heading1PaddingRight
   */
  getHeading1PaddingRight(): number | undefined {
    return this.heading1PaddingRight
  }

  /**
   * 获取heading1PaddingBottom
   *
   * @returns heading1PaddingBottom
   */
  getHeading1PaddingBottom(): number | undefined {
    return this.heading1PaddingBottom
  }

  /**
   * 获取heading1PaddingLeft
   *
   * @returns heading1PaddingLeft
   */
  getHeading1PaddingLeft(): number | undefined {
    return this.heading1PaddingLeft
  }

  /**
   * 获取heading1TextFontColor
   *
   * @returns heading1TextFontColor
   */
  getHeading1TextFontColor(): number | undefined {
    return this.heading1TextFontColor
  }

  /**
   * 获取heading1TextFontSize
   *
   * @returns heading1TextFontSize
   */
  getHeading1TextFontSize(): number | undefined {
    return this.heading1TextFontSize
  }

  /**
   * 获取heading1TextFontStyle
   *
   * @returns heading1TextFontStyle
   */
  getHeading1TextFontStyle(): FontStyle | undefined {
    return this.heading1TextFontStyle
  }

  /**
   * 获取heading1TextFontWeight
   *
   * @returns heading1TextFontWeight
   */
  getHeading1TextFontWeight(): FontWeight | undefined {
    return this.heading1TextFontWeight
  }

  /**
   * 获取heading1TextFontFamily
   *
   * @returns heading1TextFontFamily
   */
  getHeading1TextFontFamily(): string | undefined {
    return this.heading1TextFontFamily
  }

  /**
   * 获取heading1TextLineHeight
   *
   * @returns heading1TextLineHeight
   */
  getHeading1TextLineHeight(): number | undefined {
    return this.heading1TextLineHeight
  }

  /**
   * 获取heading1TextLetterSpacing
   *
   * @returns heading1TextLetterSpacing
   */
  getHeading1TextLetterSpacing(): number | undefined {
    return this.heading1TextLetterSpacing
  }

  /**
   * 获取heading1UnderlineHeight
   *
   * @returns heading1UnderlineHeight
   */
  getHeading1UnderlineHeight(): number | undefined {
    return this.heading1UnderlineHeight
  }

  /**
   * 获取heading1UnderlineColor
   *
   * @returns heading1UnderlineColor
   */
  getHeading1UnderlineColor(): number | undefined {
    return this.heading1UnderlineColor
  }

  /**
   * 获取heading1UnderlineSpacing
   *
   * @returns heading1UnderlineSpacing
   */
  getHeading1UnderlineSpacing(): number | undefined {
    return this.heading1UnderlineSpacing
  }

  /**
   * 获取heading2BackgroundColor
   *
   * @returns heading2BackgroundColor
   */
  getHeading2BackgroundColor(): number | undefined {
    return this.heading2BackgroundColor
  }

  /**
   * 获取heading2MarginTop
   *
   * @returns heading2MarginTop
   */
  getHeading2MarginTop(): number | undefined {
    return this.heading2MarginTop
  }

  /**
   * 获取heading2MarginRight
   *
   * @returns heading2MarginRight
   */
  getHeading2MarginRight(): number | undefined {
    return this.heading2MarginRight
  }

  /**
   * 获取heading2MarginBottom
   *
   * @returns heading2MarginBottom
   */
  getHeading2MarginBottom(): number | undefined {
    return this.heading2MarginBottom
  }

  /**
   * 获取heading2MarginLeft
   *
   * @returns heading2MarginLeft
   */
  getHeading2MarginLeft(): number | undefined {
    return this.heading2MarginLeft
  }

  /**
   * 获取heading2PaddingTop
   *
   * @returns heading2PaddingTop
   */
  getHeading2PaddingTop(): number | undefined {
    return this.heading2PaddingTop
  }

  /**
   * 获取heading2PaddingRight
   *
   * @returns heading2PaddingRight
   */
  getHeading2PaddingRight(): number | undefined {
    return this.heading2PaddingRight
  }

  /**
   * 获取heading2PaddingBottom
   *
   * @returns heading2PaddingBottom
   */
  getHeading2PaddingBottom(): number | undefined {
    return this.heading2PaddingBottom
  }

  /**
   * 获取heading2PaddingLeft
   *
   * @returns heading2PaddingLeft
   */
  getHeading2PaddingLeft(): number | undefined {
    return this.heading2PaddingLeft
  }

  /**
   * 获取heading2TextFontColor
   *
   * @returns heading2TextFontColor
   */
  getHeading2TextFontColor(): number | undefined {
    return this.heading2TextFontColor
  }

  /**
   * 获取heading2TextFontSize
   *
   * @returns heading2TextFontSize
   */
  getHeading2TextFontSize(): number | undefined {
    return this.heading2TextFontSize
  }

  /**
   * 获取heading2TextFontStyle
   *
   * @returns heading2TextFontStyle
   */
  getHeading2TextFontStyle(): FontStyle | undefined {
    return this.heading2TextFontStyle
  }

  /**
   * 获取heading2TextFontWeight
   *
   * @returns heading2TextFontWeight
   */
  getHeading2TextFontWeight(): FontWeight | undefined {
    return this.heading2TextFontWeight
  }

  /**
   * 获取heading2TextFontFamily
   *
   * @returns heading2TextFontFamily
   */
  getHeading2TextFontFamily(): string | undefined {
    return this.heading2TextFontFamily
  }

  /**
   * 获取heading2TextLineHeight
   *
   * @returns heading2TextLineHeight
   */
  getHeading2TextLineHeight(): number | undefined {
    return this.heading2TextLineHeight
  }

  /**
   * 获取heading2TextLetterSpacing
   *
   * @returns heading2TextLetterSpacing
   */
  getHeading2TextLetterSpacing(): number | undefined {
    return this.heading2TextLetterSpacing
  }

  /**
   * 获取heading2UnderlineHeight
   *
   * @returns heading2UnderlineHeight
   */
  getHeading2UnderlineHeight(): number | undefined {
    return this.heading2UnderlineHeight
  }

  /**
   * 获取heading2UnderlineColor
   *
   * @returns heading2UnderlineColor
   */
  getHeading2UnderlineColor(): number | undefined {
    return this.heading2UnderlineColor
  }

  /**
   * 获取heading2UnderlineSpacing
   *
   * @returns heading2UnderlineSpacing
   */
  getHeading2UnderlineSpacing(): number | undefined {
    return this.heading2UnderlineSpacing
  }

  /**
   * 获取heading3BackgroundColor
   *
   * @returns heading3BackgroundColor
   */
  getHeading3BackgroundColor(): number | undefined {
    return this.heading3BackgroundColor
  }

  /**
   * 获取heading3MarginTop
   *
   * @returns heading3MarginTop
   */
  getHeading3MarginTop(): number | undefined {
    return this.heading3MarginTop
  }

  /**
   * 获取heading3MarginRight
   *
   * @returns heading3MarginRight
   */
  getHeading3MarginRight(): number | undefined {
    return this.heading3MarginRight
  }

  /**
   * 获取heading3MarginBottom
   *
   * @returns heading3MarginBottom
   */
  getHeading3MarginBottom(): number | undefined {
    return this.heading3MarginBottom
  }

  /**
   * 获取heading3MarginLeft
   *
   * @returns heading3MarginLeft
   */
  getHeading3MarginLeft(): number | undefined {
    return this.heading3MarginLeft
  }

  /**
   * 获取heading3PaddingTop
   *
   * @returns heading3PaddingTop
   */
  getHeading3PaddingTop(): number | undefined {
    return this.heading3PaddingTop
  }

  /**
   * 获取heading3PaddingRight
   *
   * @returns heading3PaddingRight
   */
  getHeading3PaddingRight(): number | undefined {
    return this.heading3PaddingRight
  }

  /**
   * 获取heading3PaddingBottom
   *
   * @returns heading3PaddingBottom
   */
  getHeading3PaddingBottom(): number | undefined {
    return this.heading3PaddingBottom
  }

  /**
   * 获取heading3PaddingLeft
   *
   * @returns heading3PaddingLeft
   */
  getHeading3PaddingLeft(): number | undefined {
    return this.heading3PaddingLeft
  }

  /**
   * 获取heading3TextFontColor
   *
   * @returns heading3TextFontColor
   */
  getHeading3TextFontColor(): number | undefined {
    return this.heading3TextFontColor
  }

  /**
   * 获取heading3TextFontSize
   *
   * @returns heading3TextFontSize
   */
  getHeading3TextFontSize(): number | undefined {
    return this.heading3TextFontSize
  }

  /**
   * 获取heading3TextFontStyle
   *
   * @returns heading3TextFontStyle
   */
  getHeading3TextFontStyle(): FontStyle | undefined {
    return this.heading3TextFontStyle
  }

  /**
   * 获取heading3TextFontWeight
   *
   * @returns heading3TextFontWeight
   */
  getHeading3TextFontWeight(): FontWeight | undefined {
    return this.heading3TextFontWeight
  }

  /**
   * 获取heading3TextFontFamily
   *
   * @returns heading3TextFontFamily
   */
  getHeading3TextFontFamily(): string | undefined {
    return this.heading3TextFontFamily
  }

  /**
   * 获取heading3TextLineHeight
   *
   * @returns heading3TextLineHeight
   */
  getHeading3TextLineHeight(): number | undefined {
    return this.heading3TextLineHeight
  }

  /**
   * 获取heading3TextLetterSpacing
   *
   * @returns heading3TextLetterSpacing
   */
  getHeading3TextLetterSpacing(): number | undefined {
    return this.heading3TextLetterSpacing
  }

  /**
   * 获取heading4BackgroundColor
   *
   * @returns heading4BackgroundColor
   */
  getHeading4BackgroundColor(): number | undefined {
    return this.heading4BackgroundColor
  }

  /**
   * 获取heading4MarginTop
   *
   * @returns heading4MarginTop
   */
  getHeading4MarginTop(): number | undefined {
    return this.heading4MarginTop
  }

  /**
   * 获取heading4MarginRight
   *
   * @returns heading4MarginRight
   */
  getHeading4MarginRight(): number | undefined {
    return this.heading4MarginRight
  }

  /**
   * 获取heading4MarginBottom
   *
   * @returns heading4MarginBottom
   */
  getHeading4MarginBottom(): number | undefined {
    return this.heading4MarginBottom
  }

  /**
   * 获取heading4MarginLeft
   *
   * @returns heading4MarginLeft
   */
  getHeading4MarginLeft(): number | undefined {
    return this.heading4MarginLeft
  }

  /**
   * 获取heading4PaddingTop
   *
   * @returns heading4PaddingTop
   */
  getHeading4PaddingTop(): number | undefined {
    return this.heading4PaddingTop
  }

  /**
   * 获取heading4PaddingRight
   *
   * @returns heading4PaddingRight
   */
  getHeading4PaddingRight(): number | undefined {
    return this.heading4PaddingRight
  }

  /**
   * 获取heading4PaddingBottom
   *
   * @returns heading4PaddingBottom
   */
  getHeading4PaddingBottom(): number | undefined {
    return this.heading4PaddingBottom
  }

  /**
   * 获取heading4PaddingLeft
   *
   * @returns heading4PaddingLeft
   */
  getHeading4PaddingLeft(): number | undefined {
    return this.heading4PaddingLeft
  }

  /**
   * 获取heading4TextFontColor
   *
   * @returns heading4TextFontColor
   */
  getHeading4TextFontColor(): number | undefined {
    return this.heading4TextFontColor
  }

  /**
   * 获取heading4TextFontSize
   *
   * @returns heading4TextFontSize
   */
  getHeading4TextFontSize(): number | undefined {
    return this.heading4TextFontSize
  }

  /**
   * 获取heading4TextFontStyle
   *
   * @returns heading4TextFontStyle
   */
  getHeading4TextFontStyle(): FontStyle | undefined {
    return this.heading4TextFontStyle
  }

  /**
   * 获取heading4TextFontWeight
   *
   * @returns heading4TextFontWeight
   */
  getHeading4TextFontWeight(): FontWeight | undefined {
    return this.heading4TextFontWeight
  }

  /**
   * 获取heading4TextFontFamily
   *
   * @returns heading4TextFontFamily
   */
  getHeading4TextFontFamily(): string | undefined {
    return this.heading4TextFontFamily
  }

  /**
   * 获取heading4TextLineHeight
   *
   * @returns heading4TextLineHeight
   */
  getHeading4TextLineHeight(): number | undefined {
    return this.heading4TextLineHeight
  }

  /**
   * 获取heading4TextLetterSpacing
   *
   * @returns heading4TextLetterSpacing
   */
  getHeading4TextLetterSpacing(): number | undefined {
    return this.heading4TextLetterSpacing
  }

  /**
   * 获取heading5BackgroundColor
   *
   * @returns heading5BackgroundColor
   */
  getHeading5BackgroundColor(): number | undefined {
    return this.heading5BackgroundColor
  }

  /**
   * 获取heading5MarginTop
   *
   * @returns heading5MarginTop
   */
  getHeading5MarginTop(): number | undefined {
    return this.heading5MarginTop
  }

  /**
   * 获取heading5MarginRight
   *
   * @returns heading5MarginRight
   */
  getHeading5MarginRight(): number | undefined {
    return this.heading5MarginRight
  }

  /**
   * 获取heading5MarginBottom
   *
   * @returns heading5MarginBottom
   */
  getHeading5MarginBottom(): number | undefined {
    return this.heading5MarginBottom
  }

  /**
   * 获取heading5MarginLeft
   *
   * @returns heading5MarginLeft
   */
  getHeading5MarginLeft(): number | undefined {
    return this.heading5MarginLeft
  }

  /**
   * 获取heading5PaddingTop
   *
   * @returns heading5PaddingTop
   */
  getHeading5PaddingTop(): number | undefined {
    return this.heading5PaddingTop
  }

  /**
   * 获取heading5PaddingRight
   *
   * @returns heading5PaddingRight
   */
  getHeading5PaddingRight(): number | undefined {
    return this.heading5PaddingRight
  }

  /**
   * 获取heading5PaddingBottom
   *
   * @returns heading5PaddingBottom
   */
  getHeading5PaddingBottom(): number | undefined {
    return this.heading5PaddingBottom
  }

  /**
   * 获取heading5PaddingLeft
   *
   * @returns heading5PaddingLeft
   */
  getHeading5PaddingLeft(): number | undefined {
    return this.heading5PaddingLeft
  }

  /**
   * 获取heading5TextFontColor
   *
   * @returns heading5TextFontColor
   */
  getHeading5TextFontColor(): number | undefined {
    return this.heading5TextFontColor
  }

  /**
   * 获取heading5TextFontSize
   *
   * @returns heading5TextFontSize
   */
  getHeading5TextFontSize(): number | undefined {
    return this.heading5TextFontSize
  }

  /**
   * 获取heading5TextFontStyle
   *
   * @returns heading5TextFontStyle
   */
  getHeading5TextFontStyle(): FontStyle | undefined {
    return this.heading5TextFontStyle
  }

  /**
   * 获取heading5TextFontWeight
   *
   * @returns heading5TextFontWeight
   */
  getHeading5TextFontWeight(): FontWeight | undefined {
    return this.heading5TextFontWeight
  }

  /**
   * 获取heading5TextFontFamily
   *
   * @returns heading5TextFontFamily
   */
  getHeading5TextFontFamily(): string | undefined {
    return this.heading5TextFontFamily
  }

  /**
   * 获取heading5TextLineHeight
   *
   * @returns heading5TextLineHeight
   */
  getHeading5TextLineHeight(): number | undefined {
    return this.heading5TextLineHeight
  }

  /**
   * 获取heading5TextLetterSpacing
   *
   * @returns heading5TextLetterSpacing
   */
  getHeading5TextLetterSpacing(): number | undefined {
    return this.heading5TextLetterSpacing
  }

  /**
   * 获取heading6BackgroundColor
   *
   * @returns heading6BackgroundColor
   */
  getHeading6BackgroundColor(): number | undefined {
    return this.heading6BackgroundColor
  }

  /**
   * 获取heading6MarginTop
   *
   * @returns heading6MarginTop
   */
  getHeading6MarginTop(): number | undefined {
    return this.heading6MarginTop
  }

  /**
   * 获取heading6MarginRight
   *
   * @returns heading6MarginRight
   */
  getHeading6MarginRight(): number | undefined {
    return this.heading6MarginRight
  }

  /**
   * 获取heading6MarginBottom
   *
   * @returns heading6MarginBottom
   */
  getHeading6MarginBottom(): number | undefined {
    return this.heading6MarginBottom
  }

  /**
   * 获取heading6MarginLeft
   *
   * @returns heading6MarginLeft
   */
  getHeading6MarginLeft(): number | undefined {
    return this.heading6MarginLeft
  }

  /**
   * 获取heading6PaddingTop
   *
   * @returns heading6PaddingTop
   */
  getHeading6PaddingTop(): number | undefined {
    return this.heading6PaddingTop
  }

  /**
   * 获取heading6PaddingRight
   *
   * @returns heading6PaddingRight
   */
  getHeading6PaddingRight(): number | undefined {
    return this.heading6PaddingRight
  }

  /**
   * 获取heading6PaddingBottom
   *
   * @returns heading6PaddingBottom
   */
  getHeading6PaddingBottom(): number | undefined {
    return this.heading6PaddingBottom
  }

  /**
   * 获取heading6PaddingLeft
   *
   * @returns heading6PaddingLeft
   */
  getHeading6PaddingLeft(): number | undefined {
    return this.heading6PaddingLeft
  }

  /**
   * 获取heading6TextFontColor
   *
   * @returns heading6TextFontColor
   */
  getHeading6TextFontColor(): number | undefined {
    return this.heading6TextFontColor
  }

  /**
   * 获取heading6TextFontSize
   *
   * @returns heading6TextFontSize
   */
  getHeading6TextFontSize(): number | undefined {
    return this.heading6TextFontSize
  }

  /**
   * 获取heading6TextFontStyle
   *
   * @returns heading6TextFontStyle
   */
  getHeading6TextFontStyle(): FontStyle | undefined {
    return this.heading6TextFontStyle
  }

  /**
   * 获取heading6TextFontWeight
   *
   * @returns heading6TextFontWeight
   */
  getHeading6TextFontWeight(): FontWeight | undefined {
    return this.heading6TextFontWeight
  }

  /**
   * 获取heading6TextFontFamily
   *
   * @returns heading6TextFontFamily
   */
  getHeading6TextFontFamily(): string | undefined {
    return this.heading6TextFontFamily
  }

  /**
   * 获取heading6TextLineHeight
   *
   * @returns heading6TextLineHeight
   */
  getHeading6TextLineHeight(): number | undefined {
    return this.heading6TextLineHeight
  }

  /**
   * 获取heading6TextLetterSpacing
   *
   * @returns heading6TextLetterSpacing
   */
  getHeading6TextLetterSpacing(): number | undefined {
    return this.heading6TextLetterSpacing
  }
}
