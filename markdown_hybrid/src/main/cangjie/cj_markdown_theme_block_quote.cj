package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownBlockQuoteTheme {
    /**
     * 块引用背景颜色
     */
    var blockQuoteBackgroundColor: ?Color = None

    /**
     * 块引用上外边距
     */
    var blockQuoteMarginTop: ?Float64 = None

    /**
     * 块引用右外边距
     */
    var blockQuoteMarginRight: ?Float64 = None

    /**
     * 块引用下外边距
     */
    var blockQuoteMarginBottom: ?Float64 = None

    /**
     * 块引用左外边距
     */
    var blockQuoteMarginLeft: ?Float64 = None

    /**
     * 块引用上内边距
     */
    var blockQuotePaddingTop: ?Float64 = None

    /**
     * 块引用右内边距
     */
    var blockQuotePaddingRight: ?Float64 = None

    /**
     * 块引用下内边距
     */
    var blockQuotePaddingBottom: ?Float64 = None

    /**
     * 块引用左内边距
     */
    var blockQuotePaddingLeft: ?Float64 = None

    /**
     * 块引用边框左上圆角
     */
    var blockQuoteRadiusTopLeft: ?Float64 = None

    /**
     * 块引用边框右上圆角
     */
    var blockQuoteRadiusTopRight: ?Float64 = None

    /**
     * 块引用边框左下圆角
     */
    var blockQuoteRadiusBottomLeft: ?Float64 = None

    /**
     * 块引用边框右下圆角
     */
    var blockQuoteRadiusBottomRight: ?Float64 = None

    /**
     * 块引用左侧边框宽度
     */
    var blockQuoteLeftBorderWidth: ?Float64 = None

    /**
     * 块引用左侧边框颜色
     */
    var blockQuoteLeftBorderColor: ?Color = None

    /**
     * 块引用左侧线条和内容的间距
     */
    var blockQuoteBorderContentSpacing: ?Float64 = None

    /**
     * 块引用子模块上下间距
     */
    var blockQuoteChildSpacing: ?Float64 = None

    public init() {}

    /**
     * 设置块引用背景颜色
     *
     * @param color 背景颜色
     */
    public func setBlockQuoteBackgroundColor(color: UInt32): Unit {
        blockQuoteBackgroundColor = transColorForTrasparent(color)
    }

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     */
    public func setBlockQuoteAllMargin(margin: Float64): Unit {
        blockQuoteMarginTop = margin
        blockQuoteMarginRight = margin
        blockQuoteMarginBottom = margin
        blockQuoteMarginLeft = margin
    }

    /**
     * 分别设置4个外边距
     *
     * @param top-上外边距 命名参数
     * @param right-右外边距 命名参数
     * @param bottom-下外边距 命名参数
     * @param left-左外边距 命名参数
     */
    public func setBlockQuoteMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        blockQuoteMarginTop = top
        blockQuoteMarginRight = right
        blockQuoteMarginBottom = bottom
        blockQuoteMarginLeft = left
    }

    /**
     * 设置4个内边距为统一值
     *
     * @param padding 内边距
     */
    public func setBlockQuoteAllPadding(padding: Float64): Unit {
        blockQuotePaddingTop = padding
        blockQuotePaddingRight = padding
        blockQuotePaddingBottom = padding
        blockQuotePaddingLeft = padding
    }

    /**
     * 分别设置4个内边距
     *
     * @param top-上内边距 命名参数
     * @param right-右内边距 命名参数
     * @param bottom-下内边距 命名参数
     * @param left-左内边距 命名参数
     */
    public func setBlockQuotePadding(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        blockQuotePaddingTop = top
        blockQuotePaddingRight = right
        blockQuotePaddingBottom = bottom
        blockQuotePaddingLeft = left
    }

    /**
     * 设置块引用4个圆角为统一值
     *
     * @param radius 圆角
     */
    public func setBlockQuoteAllRadius(radius: Float64): Unit {
        blockQuoteRadiusTopLeft = radius
        blockQuoteRadiusTopRight = radius
        blockQuoteRadiusBottomLeft = radius
        blockQuoteRadiusBottomRight = radius
    }

    /**
     * 分别设置块引用4个圆角
     *
     * @param topLeft-左上圆角 命名参数
     * @param topRight-右上圆角 命名参数
     * @param bottomLeft-左下圆角 命名参数
     * @param bottomRight-右下圆角 命名参数
     */
    public func setBlockQuoteRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        blockQuoteRadiusTopLeft = topLeft
        blockQuoteRadiusTopRight = topRight
        blockQuoteRadiusBottomLeft = bottomLeft
        blockQuoteRadiusBottomRight = bottomRight
    }

    /**
     * 设置块引用左侧边框宽度
     *
     * @param width 边框宽度
     */
    public func setBlockQuoteLeftBorderWidth(width: Float64): Unit {
        blockQuoteLeftBorderWidth = width
    }

    /**
     * 设置块引用左侧边框颜色
     *
     * @param color 边框颜色
     */
    public func setBlockQuoteLeftBorderColor(color: UInt32): Unit {
        blockQuoteLeftBorderColor = transColorForTrasparent(color)
    }

    /**
     * 设置块引用左侧线条和内容的间距
     *
     * @param space 块引用左侧线条和内容的间距
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteBorderContentSpacing(space: Float64): Unit {
        blockQuoteBorderContentSpacing = space
    }

    /**
     * 设置块引用子模块上下间距
     *
     * @param marginY 子模块上下间距
     */
    public func setBlockQuoteChildSpacing(spacing: Float64): Unit {
        blockQuoteChildSpacing = spacing
    }
}
