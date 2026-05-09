package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownDividerTheme {
    /**
     * 分割线上外边距
     */
    var dividerMarginTop: ?Float64 = None

    /**
     * 分割线右外边距
     */
    var dividerMarginRight: ?Float64 = None

    /**
     * 分割线下外边距
     */
    var dividerMarginBottom: ?Float64 = None

    /**
     * 分割线左外边距
     */
    var dividerMarginLeft: ?Float64 = None

    /**
     * 分割线上内边距
     */
    var dividerPaddingTop: ?Float64 = None

    /**
     * 分割线右内边距
     */
    var dividerPaddingRight: ?Float64 = None

    /**
     * 分割线下内边距
     */
    var dividerPaddingBottom: ?Float64 = None

    /**
     * 分割线左内边距
     */
    var dividerPaddingLeft: ?Float64 = None

    /**
     * 分割线颜色
     */
    var dividerColor: ?Color = None

    /**
     * 分割线宽度
     */
    var dividerStrokeWidth: ?Float64 = None

    /**
     * 分割线端点样式
     */
    var dividerStyle: ?LineCapStyle = None

    public init() {}

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     */
    public func setDividerAllMargin(margin: Float64): Unit {
        dividerMarginTop = margin
        dividerMarginRight = margin
        dividerMarginBottom = margin
        dividerMarginLeft = margin
    }

    /**
     * 分别设置4个外边距
     *
     * @param top-上外边距 命名参数
     * @param right-右外边距 命名参数
     * @param bottom-下外边距 命名参数
     * @param left-左外边距 命名参数
     */
    public func setDividerMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        dividerMarginTop = top
        dividerMarginRight = right
        dividerMarginBottom = bottom
        dividerMarginLeft = left
    }

    /**
     * 设置4个内边距为统一值
     *
     * @param padding 内边距
     */
    public func setDividerAllPadding(padding: Float64): Unit {
        dividerPaddingTop = padding
        dividerPaddingRight = padding
        dividerPaddingBottom = padding
        dividerPaddingLeft = padding
    }

    /**
     * 分别设置4个内边距
     *
     * @param top-上内边距 命名参数
     * @param right-右内边距 命名参数
     * @param bottom-下内边距 命名参数
     * @param left-左内边距 命名参数
     */
    public func setDividerPadding(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        dividerPaddingTop = top
        dividerPaddingRight = right
        dividerPaddingBottom = bottom
        dividerPaddingLeft = left
    }

    /**
     * 设置分割线颜色
     *
     * @param color 分割线颜色
     */
    public func setDividerColor(color: UInt32): Unit {
        dividerColor = transColorForTransparent(color)
    }

    /**
     * 设置分割线宽度
     *
     * @param strokeWidth 分割线宽度
     */
    public func setDividerStrokeWidth(strokeWidth: Float64): Unit {
        dividerStrokeWidth = strokeWidth
    }

    /**
     * 设置分割线端点样式
     *
     * @param style 分割线端点样式
     */
    public func setDividerStyle(style: Int64): Unit {
        dividerStyle = convertLineCapStyle(style)
    }
}
