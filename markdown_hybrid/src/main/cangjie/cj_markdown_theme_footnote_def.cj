package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownFootnoteDefTheme {
    /**
     * 脚注定义背景颜色
     */
    var footnoteDefBackgroundColor: ?Color = None

    /**
     * 脚注定义上外边距
     */
    var footnoteDefMarginTop: ?Float64 = None

    /**
     * 脚注定义右外边距
     */
    var footnoteDefMarginRight: ?Float64 = None

    /**
     * 脚注定义下外边距
     */
    var footnoteDefMarginBottom: ?Float64 = None

    /**
     * 脚注定义左外边距
     */
    var footnoteDefMarginLeft: ?Float64 = None

    /**
     * 脚注定义上内边距
     */
    var footnoteDefPaddingTop: ?Float64 = None

    /**
     * 脚注定义右内边距
     */
    var footnoteDefPaddingRight: ?Float64 = None

    /**
     * 脚注定义下内边距
     */
    var footnoteDefPaddingBottom: ?Float64 = None

    /**
     * 脚注定义左内边距
     */
    var footnoteDefPaddingLeft: ?Float64 = None

    public init() {}

    /**
     * 设置脚注定义背景颜色
     *
     * @param color 背景颜色
     */
    public func setFootnoteDefBackgroundColor(color: UInt32): Unit {
        footnoteDefBackgroundColor = transColorForTransparent(color)
    }

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     */
    public func setFootnoteDefAllMargin(margin: Float64): Unit {
        footnoteDefMarginTop = margin
        footnoteDefMarginRight = margin
        footnoteDefMarginBottom = margin
        footnoteDefMarginLeft = margin
    }

    /**
     * 分别设置4个外边距
     *
     * @param top-上外边距 命名参数
     * @param right-右外边距 命名参数
     * @param bottom-下外边距 命名参数
     * @param left-左外边距 命名参数
     */
    public func setFootnoteDefMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        footnoteDefMarginTop = top
        footnoteDefMarginRight = right
        footnoteDefMarginBottom = bottom
        footnoteDefMarginLeft = left
    }

    /**
     * 设置4个内边距为统一值
     *
     * @param padding 内边距
     */
    public func setFootnoteDefAllPadding(padding: Float64): Unit {
        footnoteDefPaddingTop = padding
        footnoteDefPaddingRight = padding
        footnoteDefPaddingBottom = padding
        footnoteDefPaddingLeft = padding
    }

    /**
     * 分别设置4个内边距
     *
     * @param top-上内边距 命名参数
     * @param right-右内边距 命名参数
     * @param bottom-下内边距 命名参数
     * @param left-左内边距 命名参数
     */
    public func setFootnoteDefPadding(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        footnoteDefPaddingTop = top
        footnoteDefPaddingRight = right
        footnoteDefPaddingBottom = bottom
        footnoteDefPaddingLeft = left
    }

}
