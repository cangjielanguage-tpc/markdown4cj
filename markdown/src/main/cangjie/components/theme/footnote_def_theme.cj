package markdown.components.theme

/**
 * 脚注定义样式
 */
public class FootnoteDefTheme <: MarkdownBaseTheme {
    public var footnoteDefBackgroundColor: ?Color = None // 脚注定义背景颜色
    public var footnoteDefMarginTop: Float64 = 0.0 // 脚注定义上外边距
    public var footnoteDefMarginRight: Float64 = 0.0 // 脚注定义右外边距
    public var footnoteDefMarginBottom: Float64 = 0.0 // 脚注定义下外边距
    public var footnoteDefMarginLeft: Float64 = 0.0 // 脚注定义左外边距
    public var footnoteDefPaddingTop: Float64 = 0.0 // 脚注定义上内边距
    public var footnoteDefPaddingRight: Float64 = 0.0 // 脚注定义右内边距
    public var footnoteDefPaddingBottom: Float64 = 0.0 // 脚注定义下内边距
    public var footnoteDefPaddingLeft: Float64 = 0.0 // 脚注定义左内边距

    /**
     * 设置脚注定义背景颜色
     *
     * @param color 脚注定义背景颜色
     * @return 当前FootnoteDefTheme对象
     */
    public func setFootnoteDefBackgroundColor(color: Color): FootnoteDefTheme {
        this.footnoteDefBackgroundColor = color
        return this
    }

    /**
     * 统一设置脚注定义外边距
     *
     * @param margin 外边距
     * @return 当前FootnoteDefTheme对象
     */
    public func setFootnoteDefMargin(margin: Float64): FootnoteDefTheme {
        this.footnoteDefMarginTop = margin
        this.footnoteDefMarginRight = margin
        this.footnoteDefMarginBottom = margin
        this.footnoteDefMarginLeft = margin
        return this
    }

    /**
     * 分别设置脚注定义四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前FootnoteDefTheme对象
     */
    public func setFootnoteDefMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): FootnoteDefTheme {
        this.footnoteDefMarginTop = top
        this.footnoteDefMarginRight = right
        this.footnoteDefMarginBottom = bottom
        this.footnoteDefMarginLeft = left
        return this
    }

    /**
     * 统一设置脚注定义内边距
     *
     * @param padding 内边距
     * @return 当前FootnoteDefTheme对象
     */
    public func setFootnoteDefPadding(padding: Float64): FootnoteDefTheme {
        this.footnoteDefPaddingTop = padding
        this.footnoteDefPaddingRight = padding
        this.footnoteDefPaddingBottom = padding
        this.footnoteDefPaddingLeft = padding
        return this
    }

    /**
     * 分别设置脚注定义四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前FootnoteDefTheme对象
     */
    public func setFootnoteDefPadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): FootnoteDefTheme {
        this.footnoteDefPaddingTop = top
        this.footnoteDefPaddingRight = right
        this.footnoteDefPaddingBottom = bottom
        this.footnoteDefPaddingLeft = left
        return this
    }
}