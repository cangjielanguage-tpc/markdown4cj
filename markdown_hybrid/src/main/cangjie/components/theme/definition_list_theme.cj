package markdown.components.theme

/**
 * 定义列表样式
 */
public class DefinitionListTheme <: MarkdownBaseTheme {
    public var definitionListBackgroundColor: ?Color = None // 定义列表背景颜色
    public var definitionListMarginTop: Float64 = 0.0 // 定义列表上外边距
    public var definitionListMarginRight: Float64 = 0.0 // 定义列表右外边距
    public var definitionListMarginBottom: Float64 = 0.0 // 定义列表下外边距
    public var definitionListMarginLeft: Float64 = 0.0 // 定义列表左外边距
    public var definitionListPaddingTop: Float64 = 0.0 // 定义列表上内边距
    public var definitionListPaddingRight: Float64 = 0.0 // 定义列表右内边距
    public var definitionListPaddingBottom: Float64 = 0.0 // 定义列表下内边距
    public var definitionListPaddingLeft: Float64 = 0.0 // 定义列表左内边距
    public var definitionListTermToDescriptionSpacing: Float64 = 8.0 // 定义列表术语和定义行之间间距
    public var definitionListTermTextFontWeight: FontWeight = FontWeight.W600 // 定义列表术语文本字体粗细
    public var definitionListTermTextFontStyle: FontStyle = FontStyle.Italic // 定义列表术语文本字体样式
    public var definitionListDescriptionItemSpacing: Float64 = 8.0 // 定义列表定义行之间间距
    public var definitionListDescriptionIndent: Float64 = 8.0 // 定义列表定义行左缩进距离

    /**
     * 设置定义列表背景颜色
     *
     * @param color 定义列表背景颜色
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListBackgroundColor(color: Color): DefinitionListTheme {
        this.definitionListBackgroundColor = color
        return this
    }

    /**
     * 统一设置定义列表外边距
     *
     * @param margin 外边距
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListMargin(margin: Float64): DefinitionListTheme {
        this.definitionListMarginTop = margin
        this.definitionListMarginRight = margin
        this.definitionListMarginBottom = margin
        this.definitionListMarginLeft = margin
        return this
    }

    /**
     * 分别设置定义列表四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): DefinitionListTheme {
        this.definitionListMarginTop = top
        this.definitionListMarginRight = right
        this.definitionListMarginBottom = bottom
        this.definitionListMarginLeft = left
        return this
    }

    /**
     * 统一设置定义列表内边距
     *
     * @param padding 内边距
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListPadding(padding: Float64): DefinitionListTheme {
        this.definitionListPaddingTop = padding
        this.definitionListPaddingRight = padding
        this.definitionListPaddingBottom = padding
        this.definitionListPaddingLeft = padding
        return this
    }

    /**
     * 分别设置定义列表四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListPadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): DefinitionListTheme {
        this.definitionListPaddingTop = top
        this.definitionListPaddingRight = right
        this.definitionListPaddingBottom = bottom
        this.definitionListPaddingLeft = left
        return this
    }

    /**
     * 设置定义列表术语和定义行之间间距
     *
     * @param spacing 定义列表术语和定义行之间间距
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListTermToDescriptionSpacing(spacing: Float64): DefinitionListTheme {
        this.definitionListTermToDescriptionSpacing = spacing
        return this
    }

    /**
     * 设置定义列表术语文本字体粗细
     *
     * @param weight 定义列表术语文本字体粗细
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListTermTextFontWeight(weight: FontWeight): DefinitionListTheme {
        this.definitionListTermTextFontWeight = weight
        return this
    }

    /**
     * 设置定义列表术语文本字体样式
     *
     * @param style 定义列表术语文本字体样式
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListTermTextFontStyle(style: FontStyle): DefinitionListTheme {
        this.definitionListTermTextFontStyle = style
        return this
    }

    /**
     * 设置定义列表定义行之间间距
     *
     * @param spacing 定义列表定义行之间间距
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListDescriptionItemSpacing(spacing: Float64): DefinitionListTheme {
        this.definitionListDescriptionItemSpacing = spacing
        return this
    }

    /**
     * 设置定义列表定义行左缩进距离
     *
     * @param indent 定义列表定义行左缩进距离
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListDescriptionIndent(indent: Float64): DefinitionListTheme {
        this.definitionListDescriptionIndent = indent
        return this
    }
}