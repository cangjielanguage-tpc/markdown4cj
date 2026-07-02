import { MarkdownBaseTheme } from './MarkdownBaseTheme'
import { COLOR_FF191919, isMargin, isPadding } from "../base/Constants"
import { MarkdownMarginArrayOptions, MarkdownPaddingArrayOptions } from './MarkdownTheme'

/**
 * 标题样式配置
 */
@Observed
export class HeadingTheme implements MarkdownBaseTheme {
  heading1BackgroundColor: ResourceColor | undefined = undefined // H1级标题背景颜色
  heading1MarginTop: Length = 0.0 // H1级标题上外边距
  heading1MarginRight: Length = 0.0 // H1级标题右外边距
  heading1MarginBottom: Length = 0.0 // H1级标题下外边距
  heading1MarginLeft: Length = 0.0 // H1级标题左外边距
  heading1PaddingTop: Length = 0.0 // H1级标题上内边距
  heading1PaddingRight: Length = 0.0 // H1级标题右内边距
  heading1PaddingBottom: Length = 0.0 // H1级标题下内边距
  heading1PaddingLeft: Length = 0.0 // H1级标题左内边距
  heading1TextFontColor: ResourceColor = COLOR_FF191919 // H1级标题字体颜色
  heading1TextFontSize: number | string | Resource = 20.0 // H1级标题字体大小
  heading1TextFontStyle: FontStyle = FontStyle.Normal // H1级标题字体样式
  heading1TextFontWeight: number | FontWeight = FontWeight.Bold // H1级标题字体粗细
  heading1TextFontFamily: string | Resource = 'HarmonyOS Sans' // H1级标题字体族
  heading1TextLineHeight: number | string | Resource = 22.0 // H1级标题行高
  heading1TextLetterSpacing: number = 0.0 // H1级标题字母间距
  heading1UnderlineHeight: number = 0.5 // H1级标题下划线高度
  heading1UnderlineColor: ResourceColor = COLOR_FF191919 // H1级标题下划线颜色
  heading1UnderlineSpacing: number = 0.0 // H1级标题下划线间距
  heading2BackgroundColor: ResourceColor | undefined = undefined // H2级标题背景颜色
  heading2MarginTop: Length = 0.0 // H2级标题上外边距
  heading2MarginRight: Length = 0.0 // H2级标题右外边距
  heading2MarginBottom: Length = 0.0 // H2级标题下外边距
  heading2MarginLeft: Length = 0.0 // H2级标题左外边距
  heading2PaddingTop: Length = 0.0 // H2级标题上内边距
  heading2PaddingRight: Length = 0.0 // H2级标题右内边距
  heading2PaddingBottom: Length = 0.0 // H2级标题下内边距
  heading2PaddingLeft: Length = 0.0 // H2级标题左内边距
  heading2TextFontColor: ResourceColor = COLOR_FF191919 // H2级标题字体颜色
  heading2TextFontSize: number | string | Resource = 17.0 // H2级标题字体大小
  heading2TextFontStyle: FontStyle = FontStyle.Normal // H2级标题字体样式
  heading2TextFontWeight: number | FontWeight = FontWeight.Bold // H2级标题字体粗细
  heading2TextFontFamily: string | Resource = 'HarmonyOS Sans' // H2级标题字体族
  heading2TextLineHeight: number | string | Resource = 22.0 // H2级标题行高
  heading2TextLetterSpacing: number = 0.0 // H2级标题字母间距
  heading2UnderlineHeight: number = 0.5 // H2级标题下划线高度
  heading2UnderlineColor: ResourceColor = COLOR_FF191919 // H2级标题下划线颜色
  heading2UnderlineSpacing: number = 0.0 // H2级标题下划线间距
  heading3BackgroundColor: ResourceColor | undefined = undefined // H3级标题背景颜色
  heading3MarginTop: Length = 0.0 // H3级标题上外边距
  heading3MarginRight: Length = 0.0 // H3级标题右外边距
  heading3MarginBottom: Length = 0.0 // H3级标题下外边距
  heading3MarginLeft: Length = 0.0 // H3级标题左外边距
  heading3PaddingTop: Length = 0.0 // H3级标题上内边距
  heading3PaddingRight: Length = 0.0 // H3级标题右内边距
  heading3PaddingBottom: Length = 0.0 // H3级标题下内边距
  heading3PaddingLeft: Length = 0.0 // H3级标题左内边距
  heading3TextFontColor: ResourceColor = COLOR_FF191919 // H3级标题字体颜色
  heading3TextFontSize: number | string | Resource = 16.0 // H3级标题字体大小
  heading3TextFontStyle: FontStyle = FontStyle.Normal // H3级标题字体样式
  heading3TextFontWeight: number | FontWeight = FontWeight.Bold // H3级标题字体粗细
  heading3TextFontFamily: string | Resource = 'HarmonyOS Sans' // H3级标题字体族
  heading3TextLineHeight: number | string | Resource = 22.0 // H3级标题行高
  heading3TextLetterSpacing: number = 0.0 // H3级标题字母间距
  heading4BackgroundColor: ResourceColor | undefined = undefined // H4级标题背景颜色
  heading4MarginTop: Length = 0.0 // H4级标题上外边距
  heading4MarginRight: Length = 0.0 // H4级标题右外边距
  heading4MarginBottom: Length = 0.0 // H4级标题下外边距
  heading4MarginLeft: Length = 0.0 // H4级标题左外边距
  heading4PaddingTop: Length = 0.0 // H4级标题上内边距
  heading4PaddingRight: Length = 0.0 // H4级标题右内边距
  heading4PaddingBottom: Length = 0.0 // H4级标题下内边距
  heading4PaddingLeft: Length = 0.0 // H4级标题左内边距
  heading4TextFontColor: ResourceColor = COLOR_FF191919 // H4级标题字体颜色
  heading4TextFontSize: number | string | Resource = 15.0 // H4级标题字体大小
  heading4TextFontStyle: FontStyle = FontStyle.Normal // H4级标题字体样式
  heading4TextFontWeight: number | FontWeight = FontWeight.Bold // H4级标题字体粗细
  heading4TextFontFamily: string | Resource = 'HarmonyOS Sans' // H4级标题字体族
  heading4TextLineHeight: number | string | Resource = 22.0 // H4级标题行高
  heading4TextLetterSpacing: number = 0.0 // H4级标题字母间距
  heading5BackgroundColor: ResourceColor | undefined = undefined // H5级标题背景颜色
  heading5MarginTop: Length = 0.0 // H5级标题上外边距
  heading5MarginRight: Length = 0.0 // H5级标题右外边距
  heading5MarginBottom: Length = 0.0 // H5级标题下外边距
  heading5MarginLeft: Length = 0.0 // H5级标题左外边距
  heading5PaddingTop: Length = 0.0 // H5级标题上内边距
  heading5PaddingRight: Length = 0.0 // H5级标题右内边距
  heading5PaddingBottom: Length = 0.0 // H5级标题下内边距
  heading5PaddingLeft: Length = 0.0 // H5级标题左内边距
  heading5TextFontColor: ResourceColor = COLOR_FF191919 // H5级标题字体颜色
  heading5TextFontSize: number | string | Resource = 15.0 // H5级标题字体大小
  heading5TextFontStyle: FontStyle = FontStyle.Normal // H5级标题字体样式
  heading5TextFontWeight: number | FontWeight = FontWeight.Bold // H5级标题字体粗细
  heading5TextFontFamily: string | Resource = 'HarmonyOS Sans' // H5级标题字体族
  heading5TextLineHeight: number | string | Resource = 22.0 // H5级标题行高
  heading5TextLetterSpacing: number = 0.0 // H5级标题字母间距
  heading6BackgroundColor: ResourceColor | undefined = undefined // H6级标题背景颜色
  heading6MarginTop: Length = 0.0 // H6级标题上外边距
  heading6MarginRight: Length = 0.0 // H6级标题右外边距
  heading6MarginBottom: Length = 0.0 // H6级标题下外边距
  heading6MarginLeft: Length = 0.0 // H6级标题左外边距
  heading6PaddingTop: Length = 0.0 // H6级标题上内边距
  heading6PaddingRight: Length = 0.0 // H6级标题右内边距
  heading6PaddingBottom: Length = 0.0 // H6级标题下内边距
  heading6PaddingLeft: Length = 0.0 // H6级标题左内边距
  heading6TextFontColor: ResourceColor = COLOR_FF191919 // H6级标题字体颜色
  heading6TextFontSize: number | string | Resource = 13.0 // H6级标题字体大小
  heading6TextFontStyle: FontStyle = FontStyle.Normal // H6级标题字体样式
  heading6TextFontWeight: number | FontWeight = FontWeight.Bold // H6级标题字体粗细
  heading6TextFontFamily: string | Resource = 'HarmonyOS Sans' // H6级标题字体族
  heading6TextLineHeight: number | string | Resource = 22.0 // H6级标题行高
  heading6TextLetterSpacing: number = 0.0 // H6级标题字母间距

  /**
   * 设置所有标题等级背景颜色
   *
   * @param color 背景颜色
   * @return HeadingTheme
   */
  setBackgroundColorForAllHeading(color: ResourceColor): HeadingTheme {
    this.heading1BackgroundColor = color
    this.heading2BackgroundColor = color
    this.heading3BackgroundColor = color
    this.heading4BackgroundColor = color
    this.heading5BackgroundColor = color
    this.heading6BackgroundColor = color
    return this
  }

  /**
   * 分别设置每个标题等级背景颜色
   *
   * @param colorList 背景颜色列表
   * @return HeadingTheme
   */
  setBackgroundColorForEachHeading(colorList: ResourceColor[]): HeadingTheme {
    colorList.forEach((color, index) => {
      this.setBackgroundColorForDesignateHeading(index + 1, color)
    })
    return this
  }

  /**
   * 设置指定标题等级背景颜色
   *
   * @param level 标题等级
   * @param color 背景颜色
   * @return HeadingTheme
   */
  setBackgroundColorForDesignateHeading(level: number, color: ResourceColor): HeadingTheme {
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
    }
    return this
  }

  /**
   * 设置所有标题等级外边距
   *
   * @param margin 外边距
   * @return HeadingTheme
   */
  setMarginForAllHeading(margin: Length): HeadingTheme {
    for (let i = 1; i <= 6; i++) {
      this.setMarginForDesignateHeading(i, margin)
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
  setMarginForAllHeadingEachLevel(options: Margin | Length): HeadingTheme {
    this.setMarginForDesignateHeading(1, options)
    this.setMarginForDesignateHeading(2, options)
    this.setMarginForDesignateHeading(3, options)
    this.setMarginForDesignateHeading(4, options)
    this.setMarginForDesignateHeading(5, options)
    this.setMarginForDesignateHeading(6, options)
    return this
  }

  /**
   * 分别设置每个标题等级外边距
   *
   * @param marginList 外边距列表
   * @return HeadingTheme
   */
  setMarginForEachHeading(marginList: Length[]): HeadingTheme {
    marginList.forEach((margin, index) => {
      this.setMarginForDesignateHeading(index + 1, margin)
    })
    return this
  }

  /**
   * 分别设置H1-H6每级标题的每个外边距
   *
   * @param options 包含四个外边距的H1-H6的数值集合
   * @return HeadingTheme
   */
  setMarginForEachHeadingDetail(options: MarkdownMarginArrayOptions): HeadingTheme {
    if (options.top !== undefined) {
      for (let index = 0; index < options.top.length; index++) {
        this.setMarginForDesignateHeading(index + 1, { top: options.top[index] })
      }
    }
    if (options.right !== undefined) {
      for (let index = 0; index < options.right.length; index++) {
        this.setMarginForDesignateHeading(index + 1, { right: options.right[index] })
      }
    }
    if (options.bottom !== undefined) {
      for (let index = 0; index < options.bottom.length; index++) {
        this.setMarginForDesignateHeading(index + 1, { bottom: options.bottom[index] })
      }
    }
    if (options.left !== undefined) {
      for (let index = 0; index < options.left.length; index++) {
        this.setMarginForDesignateHeading(index + 1, { left: options.left[index] })
      }
    }
    return this
  }

  /**
   * 设置指定标题等级外边距
   *
   * @param level 标题等级
   * @param options 外边距选项或统一数值
   * @return HeadingTheme
   */
  setMarginForDesignateHeading(level: number, options: Margin | Length): HeadingTheme {
    let t: Length | undefined = undefined
    let r: Length | undefined = undefined
    let b: Length | undefined = undefined
    let l: Length | undefined = undefined
    if (typeof options === "number" || typeof options === "string") {
      t = options
      r = options
      b = options
      l = options
    } else if (typeof options === "object" && options !== null) {
      if (isMargin(options)) {
        const margin = options as Margin
        t = margin.top
        r = margin.right
        b = margin.bottom
        l = margin.left
      } else {
        t = options as Length
        r = options as Length
        b = options as Length
        l = options as Length
      }
    }
    switch (level) {
      case 1:
        if (t !== undefined) this.heading1MarginTop = t
        if (r !== undefined) this.heading1MarginRight = r
        if (b !== undefined) this.heading1MarginBottom = b
        if (l !== undefined) this.heading1MarginLeft = l
        break
      case 2:
        if (t !== undefined) this.heading2MarginTop = t
        if (r !== undefined) this.heading2MarginRight = r
        if (b !== undefined) this.heading2MarginBottom = b
        if (l !== undefined) this.heading2MarginLeft = l
        break
      case 3:
        if (t !== undefined) this.heading3MarginTop = t
        if (r !== undefined) this.heading3MarginRight = r
        if (b !== undefined) this.heading3MarginBottom = b
        if (l !== undefined) this.heading3MarginLeft = l
        break
      case 4:
        if (t !== undefined) this.heading4MarginTop = t
        if (r !== undefined) this.heading4MarginRight = r
        if (b !== undefined) this.heading4MarginBottom = b
        if (l !== undefined) this.heading4MarginLeft = l
        break
      case 5:
        if (t !== undefined) this.heading5MarginTop = t
        if (r !== undefined) this.heading5MarginRight = r
        if (b !== undefined) this.heading5MarginBottom = b
        if (l !== undefined) this.heading5MarginLeft = l
        break
      case 6:
        if (t !== undefined) this.heading6MarginTop = t
        if (r !== undefined) this.heading6MarginRight = r
        if (b !== undefined) this.heading6MarginBottom = b
        if (l !== undefined) this.heading6MarginLeft = l
        break
    }
    return this
  }

  /**
   * 设置所有标题等级内边距
   *
   * @param padding 内边距
   * @return HeadingTheme
   */
  setPaddingForAllHeading(padding: Length): HeadingTheme {
    for (let i = 1; i <= 6; i++) {
      this.setPaddingForDesignateHeading(i, padding)
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
  setPaddingForAllHeadingEachLevel(options: Padding | Length): HeadingTheme {
    this.setPaddingForDesignateHeading(1, options)
    this.setPaddingForDesignateHeading(2, options)
    this.setPaddingForDesignateHeading(3, options)
    this.setPaddingForDesignateHeading(4, options)
    this.setPaddingForDesignateHeading(5, options)
    this.setPaddingForDesignateHeading(6, options)
    return this
  }

  /**
   * 分别设置每个标题等级内边距
   *
   * @param paddingList 内边距列表
   * @return HeadingTheme
   */
  setPaddingForEachHeading(paddingList: Length[]): HeadingTheme {
    paddingList.forEach((padding, index) => {
      this.setPaddingForDesignateHeading(index + 1, padding)
    })
    return this
  }

  /**
   * 分别设置H1-H6每级标题的每个内边距
   *
   * @param options 包含四个内边距的H1-H6的数值集合
   * @return HeadingTheme
   */
  setPaddingForEachHeadingDetail(options: MarkdownPaddingArrayOptions): HeadingTheme {
    if (options.top !== undefined) {
      for (let index = 0; index < options.top.length; index++) {
        this.setPaddingForDesignateHeading(index + 1, { top: options.top[index] })
      }
    }
    if (options.right !== undefined) {
      for (let index = 0; index < options.right.length; index++) {
        this.setPaddingForDesignateHeading(index + 1, { right: options.right[index] })
      }
    }
    if (options.bottom !== undefined) {
      for (let index = 0; index < options.bottom.length; index++) {
        this.setPaddingForDesignateHeading(index + 1, { bottom: options.bottom[index] })
      }
    }
    if (options.left !== undefined) {
      for (let index = 0; index < options.left.length; index++) {
        this.setPaddingForDesignateHeading(index + 1, { left: options.left[index] })
      }
    }
    return this
  }

  /**
   * 设置指定标题等级内边距
   *
   * @param level 标题等级
   * @param options 内边距选项或统一数值
   * @return HeadingTheme
   */
  setPaddingForDesignateHeading(level: number, options: Padding | Length): HeadingTheme {
    let t: Length | undefined = undefined
    let r: Length | undefined = undefined
    let b: Length | undefined = undefined
    let l: Length | undefined = undefined
    if (typeof options === "number" || typeof options === "string") {
      t = options
      r = options
      b = options
      l = options
    } else if (typeof options === "object" && options !== null) {
      if (isPadding(options)) {
        const padding = options as Padding
        t = padding.top
        r = padding.right
        b = padding.bottom
        l = padding.left
      } else {
        t = options as Length
        r = options as Length
        b = options as Length
        l = options as Length
      }
    }
    switch (level) {
      case 1:
        if (t !== undefined) this.heading1PaddingTop = t
        if (r !== undefined) this.heading1PaddingRight = r
        if (b !== undefined) this.heading1PaddingBottom = b
        if (l !== undefined) this.heading1PaddingLeft = l
        break
      case 2:
        if (t !== undefined) this.heading2PaddingTop = t
        if (r !== undefined) this.heading2PaddingRight = r
        if (b !== undefined) this.heading2PaddingBottom = b
        if (l !== undefined) this.heading2PaddingLeft = l
        break
      case 3:
        if (t !== undefined) this.heading3PaddingTop = t
        if (r !== undefined) this.heading3PaddingRight = r
        if (b !== undefined) this.heading3PaddingBottom = b
        if (l !== undefined) this.heading3PaddingLeft = l
        break
      case 4:
        if (t !== undefined) this.heading4PaddingTop = t
        if (r !== undefined) this.heading4PaddingRight = r
        if (b !== undefined) this.heading4PaddingBottom = b
        if (l !== undefined) this.heading4PaddingLeft = l
        break
      case 5:
        if (t !== undefined) this.heading5PaddingTop = t
        if (r !== undefined) this.heading5PaddingRight = r
        if (b !== undefined) this.heading5PaddingBottom = b
        if (l !== undefined) this.heading5PaddingLeft = l
        break
      case 6:
        if (t !== undefined) this.heading6PaddingTop = t
        if (r !== undefined) this.heading6PaddingRight = r
        if (b !== undefined) this.heading6PaddingBottom = b
        if (l !== undefined) this.heading6PaddingLeft = l
        break
    }
    return this
  }

  /**
   * 设置所有标题等级文本字体颜色
   *
   * @param color 字体颜色
   * @return HeadingTheme
   */
  setTextFontColorForAllHeading(color: ResourceColor): HeadingTheme {
    for (let i = 1; i <= 6; i++) {
      this.setTextFontColorForDesignateHeading(i, color)
    }
    return this
  }

  /**
   * 分别设置每个标题等级文本字体颜色
   *
   * @param colorList 字体颜色列表
   * @return HeadingTheme
   */
  setTextFontColorForEachHeading(colorList: ResourceColor[]): HeadingTheme {
    colorList.forEach((color, index) => {
      this.setTextFontColorForDesignateHeading(index + 1, color)
    })
    return this
  }

  /**
   * 设置指定标题等级文本字体颜色
   *
   * @param level 标题等级
   * @param color 字体颜色
   * @return HeadingTheme
   */
  setTextFontColorForDesignateHeading(level: number, color: ResourceColor): HeadingTheme {
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
    }
    return this
  }

  /**
   * 设置所有标题等级文本字体大小
   *
   * @param size 字体大小
   * @return HeadingTheme
   */
  setTextFontSizeForAllHeading(size: number | string | Resource): HeadingTheme {
    for (let i = 1; i <= 6; i++) {
      this.setTextFontSizeForDesignateHeading(i, size)
    }
    return this
  }

  /**
   * 分别设置每个标题等级文本字体大小
   *
   * @param sizeList 字体大小列表
   * @return HeadingTheme
   */
  setTextFontSizeForEachHeading(sizeList: (number | string | Resource)[]): HeadingTheme {
    sizeList.forEach((size, index) => {
      this.setTextFontSizeForDesignateHeading(index + 1, size)
    })
    return this
  }

  /**
   * 设置指定标题等级文本字体大小
   *
   * @param level 标题等级
   * @param size 字体大小
   * @return HeadingTheme
   */
  setTextFontSizeForDesignateHeading(level: number, size: number | string | Resource): HeadingTheme {
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
    }
    return this
  }

  /**
   * 设置所有标题等级文本字体样式
   *
   * @param style 字体样式
   * @return HeadingTheme
   */
  setTextFontStyleForAllHeading(style: FontStyle): HeadingTheme {
    for (let i = 1; i <= 6; i++) {
      this.setTextFontStyleForDesignateHeading(i, style)
    }
    return this
  }

  /**
   * 分别设置每个标题等级文本字体样式
   *
   * @param styleList 字体样式列表
   * @return HeadingTheme
   */
  setTextFontStyleForEachHeading(styleList: FontStyle[]): HeadingTheme {
    styleList.forEach((style, index) => {
      this.setTextFontStyleForDesignateHeading(index + 1, style)
    })
    return this
  }

  /**
   * 设置指定标题等级文本字体样式
   *
   * @param level 标题等级
   * @param style 字体样式
   * @return HeadingTheme
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
    }
    return this
  }

  /**
   * 设置所有标题等级文本字体粗细
   *
   * @param weight 字体粗细
   * @return HeadingTheme
   */
  setTextFontWeightForAllHeading(weight: number | FontWeight): HeadingTheme {
    for (let i = 1; i <= 6; i++) {
      this.setTextFontWeightForDesignateHeading(i, weight)
    }
    return this
  }

  /**
   * 分别设置每个标题等级文本字体粗细
   *
   * @param weightList 字体粗细列表
   * @return HeadingTheme
   */
  setTextFontWeightForEachHeading(weightList: (number | FontWeight)[]): HeadingTheme {
    weightList.forEach((weight, index) => {
      this.setTextFontWeightForDesignateHeading(index + 1, weight)
    })
    return this
  }

  /**
   * 设置指定标题等级文本字体粗细
   *
   * @param level 标题等级
   * @param weight 字体粗细
   * @return HeadingTheme
   */
  setTextFontWeightForDesignateHeading(level: number, weight: number | FontWeight): HeadingTheme {
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
    }
    return this
  }

  /**
   * 设置所有标题等级文本字体族
   *
   * @param family 字体族
   * @return HeadingTheme
   */
  setTextFontFamilyForAllHeading(family: string | Resource): HeadingTheme {
    for (let i = 1; i <= 6; i++) {
      this.setTextFontFamilyForDesignateHeading(i, family)
    }
    return this
  }

  /**
   * 分别设置每个标题等级文本字体族
   *
   * @param familyList 字体族列表
   * @return HeadingTheme
   */
  setTextFontFamilyForEachHeading(familyList: (string | Resource)[]): HeadingTheme {
    familyList.forEach((family, index) => {
      this.setTextFontFamilyForDesignateHeading(index + 1, family)
    })
    return this
  }

  /**
   * 设置指定标题等级文本字体族
   *
   * @param level 标题等级
   * @param family 字体族
   * @return HeadingTheme
   */
  setTextFontFamilyForDesignateHeading(level: number, family: string | Resource): HeadingTheme {
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
    }
    return this
  }

  /**
   * 设置所有标题等级文本行高
   *
   * @param lineHeight 文本行高
   * @return HeadingTheme
   */
  setTextLineHeightForAllHeading(lineHeight: number | string | Resource): HeadingTheme {
    for (let i = 1; i <= 6; i++) {
      this.setTextLineHeightForDesignateHeading(i, lineHeight)
    }
    return this
  }

  /**
   * 分别设置每个标题等级文本行高
   *
   * @param lineHeightList 文本行高列表
   * @return HeadingTheme
   */
  setTextLineHeightForEachHeading(lineHeightList: (number | string | Resource)[]): HeadingTheme {
    lineHeightList.forEach((lineHeight, index) => {
      this.setTextLineHeightForDesignateHeading(index + 1, lineHeight)
    })
    return this
  }

  /**
   * 设置指定标题等级文本行高
   *
   * @param level 标题等级
   * @param lineHeight 文本行高
   * @return HeadingTheme
   */
  setTextLineHeightForDesignateHeading(level: number, lineHeight: number | string | Resource): HeadingTheme {
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
    }
    return this
  }

  /**
   * 设置所有标题等级字母间距
   *
   * @param spacing 字母间距
   * @return HeadingTheme
   */
  setTextLetterSpacingForAllHeading(spacing: number): HeadingTheme {
    for (let i = 1; i <= 6; i++) {
      this.setTextLetterSpacingForDesignateHeading(i, spacing)
    }
    return this
  }

  /**
   * 分别设置每个标题等级字母间距
   *
   * @param spacingList 字母间距列表
   * @return HeadingTheme
   */
  setTextLetterSpacingForEachHeading(spacingList: number[]): HeadingTheme {
    spacingList.forEach((spacing, index) => {
      this.setTextLetterSpacingForDesignateHeading(index + 1, spacing)
    })
    return this
  }

  /**
   * 设置指定标题等级字母间距
   *
   * @param level 标题等级
   * @param spacing 字母间距
   * @return HeadingTheme
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
    }
    return this
  }

  /**
   * 设置所有标题下划线高度
   *
   * @param height 下划线高度
   * @return HeadingTheme
   */
  setUnderlineHeightForAllHeading(height: number): HeadingTheme {
    this.heading1UnderlineHeight = height
    this.heading2UnderlineHeight = height
    return this
  }

  /**
   * 设置指定标题等级下划线高度
   *
   * @param level 标题等级
   * @param height 下划线高度
   * @return HeadingTheme
   */
  setUnderlineHeightForDesignateHeading(level: number, height: number): HeadingTheme {
    switch (level) {
      case 1:
        this.heading1UnderlineHeight = height
        break
      case 2:
        this.heading2UnderlineHeight = height
        break
    }
    return this
  }

  /**
   * 设置所有标题下划线颜色
   *
   * @param color 下划线颜色
   * @return HeadingTheme
   */
  setUnderlineColorForAllHeading(color: ResourceColor): HeadingTheme {
    this.heading1UnderlineColor = color
    this.heading2UnderlineColor = color
    return this
  }

  /**
   * 设置指定标题等级下划线颜色
   *
   * @param level 标题等级
   * @param color 下划线颜色
   * @return HeadingTheme
   */
  setUnderlineColorForDesignateHeading(level: number, color: ResourceColor): HeadingTheme {
    switch (level) {
      case 1:
        this.heading1UnderlineColor = color
        break
      case 2:
        this.heading2UnderlineColor = color
        break
    }
    return this
  }

  /**
   * 设置所有标题下划线间距
   *
   * @param spacing 下划线间距
   * @return HeadingTheme
   */
  setUnderlineSpacingForAllHeading(spacing: number): HeadingTheme {
    this.heading1UnderlineSpacing = spacing
    this.heading2UnderlineSpacing = spacing
    return this
  }

  /**
   * 设置指定标题等级下划线间距
   *
   * @param level 标题等级
   * @param spacing 下划线间距
   * @return HeadingTheme
   */
  setUnderlineSpacingForDesignateHeading(level: number, spacing: number): HeadingTheme {
    switch (level) {
      case 1:
        this.heading1UnderlineSpacing = spacing
        break
      case 2:
        this.heading2UnderlineSpacing = spacing
        break
    }
    return this
  }
}
