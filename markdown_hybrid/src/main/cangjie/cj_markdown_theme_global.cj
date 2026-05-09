package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownGlobalTheme {
    /**
     * markdown是否同步解析
     */
    var isMarkdownParserSync: ?Bool = None

    /**
     * 是否打开长按复制粘贴
     */
    var isOnCopy: ?Bool = None

    /**
     * markdown全局上外边距
     */
    var blockMarginTop: ?Float64 = None

    /**
     * markdown全局右外边距
     */
    var blockMarginRight: ?Float64 = None

    /**
     * markdown全局下外边距
     */
    var blockMarginBottom: ?Float64 = None

    /**
     * markdown全局左外边距
     */
    var blockMarginLeft: ?Float64 = None

    /**
     * 模块间上下间距
     */
    var markdownBlockSpacing: ?Int64 = None

    /**
     * 软换行是否换行
     */
    var isLineBreak: ?Bool = None

    /**
     * markdown是否允许滑动
     */
    var openGestureSwipe: ?Bool = None

    /**
     * 背景颜色
     */
    var backgroundColor: ?Color = None

    public init() {}

    /**
     * 设置markdown是否同步解析
     *
     * @param isSync 是否同步解析
     */
    public func setIsMarkdownParserSync(isSync: Bool): Unit {
        isMarkdownParserSync = isSync
    }

    /**
     * 设置是否打开长按复制粘贴
     *
     * @param onCopy 是否打开
     */
    public func setIsOnCopy(onCopy: Bool): Unit {
        isOnCopy = onCopy
    }

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     */
    public func setGlobalAllMargin(margin: Float64): Unit {
        blockMarginTop = margin
        blockMarginRight = margin
        blockMarginBottom = margin
        blockMarginLeft = margin
    }

    /**
     * 分别设置4个外边距
     *
     * @param top-上外边距 命名参数
     * @param right-右外边距 命名参数
     * @param bottom-下外边距 命名参数
     * @param left-左外边距 命名参数
     */
    public func setGlobalMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        blockMarginTop = top
        blockMarginRight = right
        blockMarginBottom = bottom
        blockMarginLeft = left
    }

    /**
     * 设置模块间上下间距
     *
     * @param margins 模块间上下间距
     */
    public func setBlockSpacing(spacing: Int64): Unit {
        markdownBlockSpacing = spacing
    }

    /**
     * 设置软换行是否换行
     *
     * @param isLineBreak 是否换行
     */
    public func setIsLineBreak(lineBreak: Bool): Unit {
        isLineBreak = lineBreak
    }

    /**
     * 设置markdown是否允许滑动
     *
     * @param openGestureSwipe 是否允许滑动
     */
    public func setOpenGestureSwipe(openSwipe: Bool): Unit {
        openGestureSwipe = openSwipe
    }

    /**
     * 设置背景颜色
     *
     * @param color 背景颜色
     */
    public func setBackgroundColor(color: UInt32): Unit {
        backgroundColor = transColorForTransparent(color)
    }
}
