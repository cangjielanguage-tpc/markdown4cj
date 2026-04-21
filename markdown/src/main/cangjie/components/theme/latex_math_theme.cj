package markdown.components.theme

/**
 * 数学公式样式
 */
public class LatexMathTheme <: MarkdownBaseTheme {
    public var latexMathMarginTop: Float64 = 0.0 // 块结构数学公式上外边距
    public var latexMathMarginRight: Float64 = 0.0 // 块结构数学公式右外边距
    public var latexMathMarginBottom: Float64 = 0.0 // 块结构数学公式下外边距
    public var latexMathMarginLeft: Float64 = 0.0 // 块结构数学公式左外边距
    public var latexMathPaddingTop: Float64 = 0.0 // 块结构数学公式上内边距
    public var latexMathPaddingRight: Float64 = 0.0 // 块结构数学公式右内边距
    public var latexMathPaddingBottom: Float64 = 0.0 // 块结构数学公式下内边距
    public var latexMathPaddingLeft: Float64 = 0.0 // 块结构数学公式左内边距
    public var latexMathDefaultText: Bool = true // 数学公式未加载状态是否显示文字
    public var latexMathDefaultTextFontColor: Color = Color.RED // 数学公式未加载状态文本颜色
    public var latexMathDefaultTextFontSize: Float64 = 16.0 // 数学公式未加载状态文本尺寸
    public var latexMathDefaultTextFontStyle: FontStyle = FontStyle.Normal // 数学公式未加载状态文本字体样式
    public var latexMathDefaultTextFontWeight: FontWeight = FontWeight.W400 // 数学公式未加载状态文本字体粗细
    public var latexMathDefaultTextFontFamily: String = "HarmonyOS Sans" // 数学公式未加载状态文本字体
    public var latexMathTextSize: Float64 = 16.0 // 数学公式文本大小 - 实际使用要转换
    public var latexMathBackgroundColor: Color = Color.TRANSPARENT // 数学公式背景色
    public var latexMathTextColor: Color = COLOR_BLACK // 数学公式文本颜色
    public var latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888 // 数学公式生成图片格式
    public var latexMathBlockCenter: Bool = false // 块结构的数学公式是否居中
    public var latexMathResPath: String = "/data/storage/el1/bundle/entry/resources/resfile/res" // 数学公式字体路径

    /**
     * 统一设置块结构数学公式外边距
     *
     * @param margin 外边距
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathMargin(margin: Float64): LatexMathTheme {
        this.latexMathMarginTop = margin
        this.latexMathMarginRight = margin
        this.latexMathMarginBottom = margin
        this.latexMathMarginLeft = margin
        return this
    }

    /**
     * 分别设置块结构数学公式四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): LatexMathTheme {
        this.latexMathMarginTop = top
        this.latexMathMarginRight = right
        this.latexMathMarginBottom = bottom
        this.latexMathMarginLeft = left
        return this
    }

    /**
     * 统一设置块结构数学公式内边距
     *
     * @param padding 内边距
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathPadding(padding: Float64): LatexMathTheme {
        this.latexMathPaddingTop = padding
        this.latexMathPaddingRight = padding
        this.latexMathPaddingBottom = padding
        this.latexMathPaddingLeft = padding
        return this
    }

    /**
     * 分别设置块结构数学公式四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathPadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): LatexMathTheme {
        this.latexMathPaddingTop = top
        this.latexMathPaddingRight = right
        this.latexMathPaddingBottom = bottom
        this.latexMathPaddingLeft = left
        return this
    }

    /**
     * 设置数学公式未加载状态是否显示文字
     *
     * @param showDefaultText 是否显示文字
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathDefaultText(showDefaultText: Bool): LatexMathTheme {
        this.latexMathDefaultText = showDefaultText
        return this
    }

    /**
     * 设置数学公式未加载状态文本颜色
     *
     * @param color 文本颜色
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathDefaultTextFontColor(color: Color): LatexMathTheme {
        this.latexMathDefaultTextFontColor = color
        return this
    }

    /**
     * 设置数学公式未加载状态文本尺寸
     *
     * @param size 文本尺寸
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathDefaultTextFontSize(size: Float64): LatexMathTheme {
        this.latexMathDefaultTextFontSize = size
        return this
    }

    /**
     * 设置数学公式未加载状态文本字体样式
     *
     * @param style 字体样式
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathDefaultTextFontStyle(style: FontStyle): LatexMathTheme {
        this.latexMathDefaultTextFontStyle = style
        return this
    }

    /**
     * 设置数学公式未加载状态文本字体粗细
     *
     * @param weight 字体粗细
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathDefaultTextFontWeight(weight: FontWeight): LatexMathTheme {
        this.latexMathDefaultTextFontWeight = weight
        return this
    }

    /**
     * 设置数学公式未加载状态文本字体
     *
     * @param family 字体
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathDefaultTextFontFamily(family: String): LatexMathTheme {
        this.latexMathDefaultTextFontFamily = family
        return this
    }

    /**
     * 设置数学公式文本大小
     *
     * @param size 文本大小
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathTextSize(size: Float64): LatexMathTheme {
        this.latexMathTextSize = size
        return this
    }

    /**
     * 设置数学公式背景色
     *
     * @param color 背景色
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathBackgroundColor(color: Color): LatexMathTheme {
        this.latexMathBackgroundColor = color
        return this
    }

    /**
     * 设置数学公式文本颜色
     *
     * @param color 文本颜色
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathTextColor(color: Color): LatexMathTheme {
        this.latexMathTextColor = color
        return this
    }

    /**
     * 设置数学公式生成图片格式
     *
     * @param format 生成图片格式
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathColorFormat(format: LatexMathColorFormat): LatexMathTheme {
        this.latexMathColorFormat = format
        return this
    }

    /**
     * 设置块结构的数学公式是否居中
     *
     * @param center 是否居中
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathBlockCenter(center: Bool): LatexMathTheme {
        this.latexMathBlockCenter = center
        return this
    }

    /**
     * 设置数学公式字体路径
     *
     * @param path 字体路径
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathResPath(path: String): LatexMathTheme {
        this.latexMathResPath = path
        return this
    }
}