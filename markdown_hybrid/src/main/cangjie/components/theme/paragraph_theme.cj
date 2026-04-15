package markdown.components.theme

/**
 * 段落样式
 */
public class ParagraphTheme <: MarkdownBaseTheme {
    public var paragraphBackgroundColor: ?Color = None // 段落背景颜色
    public var paragraphMarginTop: Float64 = 0.0 // 段落上外边距
    public var paragraphMarginRight: Float64 = 0.0 // 段落右外边距
    public var paragraphMarginBottom: Float64 = 0.0 // 段落下外边距
    public var paragraphMarginLeft: Float64 = 0.0 // 段落左外边距
    public var paragraphPaddingTop: Float64 = 0.0 // 段落上内边距
    public var paragraphPaddingRight: Float64 = 0.0 // 段落右内边距
    public var paragraphPaddingBottom: Float64 = 0.0 // 段落下内边距
    public var paragraphPaddingLeft: Float64 = 0.0 // 段落左内边距
    public var paragraphTextFontColor: Color = COLOR_FF191919 // 段落文本颜色
    public var paragraphTextFontSize: Float64 = 14.0 // 段落文本尺寸
    public var paragraphTextFontStyle: FontStyle = FontStyle.Normal // 段落文本字体样式
    public var paragraphTextFontWeight: FontWeight = FontWeight.W400 // 段落文本字体粗细
    public var paragraphTextFontFamily: String = "HarmonyOS Sans" // 段落文本字体
    public var paragraphTextLineHeight: Float64 = 22.0 // 段落文本行高
    public var paragraphTextLetterSpacing: Float64 = 0.0 // 段落文本字符间距

    /**
     * 设置段落背景颜色
     *
     * @param color 段落背景颜色
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphBackgroundColor(color: Color): ParagraphTheme {
        this.paragraphBackgroundColor = color
        return this
    }

    /**
     * 统一设置段落外边距
     *
     * @param margin 外边距
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphMargin(margin: Float64): ParagraphTheme {
        this.paragraphMarginTop = margin
        this.paragraphMarginRight = margin
        this.paragraphMarginBottom = margin
        this.paragraphMarginLeft = margin
        return this
    }

    /**
     * 分别设置段落四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): ParagraphTheme {
        this.paragraphMarginTop = top
        this.paragraphMarginRight = right
        this.paragraphMarginBottom = bottom
        this.paragraphMarginLeft = left
        return this
    }

    /**
     * 统一设置段落内边距
     *
     * @param padding 内边距
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphPadding(padding: Float64): ParagraphTheme {
        this.paragraphPaddingTop = padding
        this.paragraphPaddingRight = padding
        this.paragraphPaddingBottom = padding
        this.paragraphPaddingLeft = padding
        return this
    }

    /**
     * 分别设置段落四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphPadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): ParagraphTheme {
        this.paragraphPaddingTop = top
        this.paragraphPaddingRight = right
        this.paragraphPaddingBottom = bottom
        this.paragraphPaddingLeft = left
        return this
    }

    /**
     * 设置段落文本颜色
     *
     * @param color 段落文本颜色
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphTextFontColor(color: Color): ParagraphTheme {
        this.paragraphTextFontColor = color
        return this
    }

    /**
     * 设置段落文本尺寸
     *
     * @param size 段落文本尺寸
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphTextFontSize(size: Float64): ParagraphTheme {
        this.paragraphTextFontSize = size
        return this
    }

    /**
     * 设置段落文本字体样式
     *
     * @param style 段落文本字体样式
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphTextFontStyle(style: FontStyle): ParagraphTheme {
        this.paragraphTextFontStyle = style
        return this
    }

    /**
     * 设置段落文本字体粗细
     *
     * @param weight 段落文本字体粗细
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphTextFontWeight(weight: FontWeight): ParagraphTheme {
        this.paragraphTextFontWeight = weight
        return this
    }

    /**
     * 设置段落文本字体
     *
     * @param family 段落文本字体
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphTextFontFamily(family: String): ParagraphTheme {
        this.paragraphTextFontFamily = family
        return this
    }

    /**
     * 设置段落文本行高
     *
     * @param lineHeight 段落文本行高
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphTextLineHeight(lineHeight: Float64): ParagraphTheme {
        this.paragraphTextLineHeight = lineHeight
        return this
    }

    /**
     * 设置段落文本字符间距
     *
     * @param spacing 段落文本字符间距
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphTextLetterSpacing(spacing: Float64): ParagraphTheme {
        this.paragraphTextLetterSpacing = spacing
        return this
    }
}