package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownOrderedListTheme {
    /**
     * 有序列表背景颜色
     */
    var orderedListBackgroundColor: ?Color = None

    /**
     * 有序列表上外边距
     */
    var orderedListMarginTop: ?Float64 = None

    /**
     * 有序列表右外边距
     */
    var orderedListMarginRight: ?Float64 = None

    /**
     * 有序列表下外边距
     */
    var orderedListMarginBottom: ?Float64 = None

    /**
     * 有序列表左外边距
     */
    var orderedListMarginLeft: ?Float64 = None

    /**
     * 有序列表上内边距
     */
    var orderedListPaddingTop: ?Float64 = None

    /**
     * 有序列表右内边距
     */
    var orderedListPaddingRight: ?Float64 = None

    /**
     * 有序列表下内边距
     */
    var orderedListPaddingBottom: ?Float64 = None

    /**
     * 有序列表左内边距
     */
    var orderedListPaddingLeft: ?Float64 = None

    /**
     * 有序列表子模块上下间距
     */
    var orderedListChildSpacing: ?Int64 = None

    /**
     * 有序列表子模块中子模块上下间距
     */
    var orderedListChildChildSpacing: ?Int64 = None

    /**
     * 有序列表列表编号和列表内容间距
     */
    var orderedListMarkerSpacing: ?Float64 = None

    /**
     * 有序列表列表编号文本颜色
     */
    var orderedListMarkerTextFontColor: ?Color = None

    /**
     * 有序列表列表编号文本尺寸
     */
    var orderedListMarkerTextFontSize: ?Float64 = None

    /**
     * 有序列表列表编号文本字体样式
     */
    var orderedListMarkerTextFontStyle: ?FontStyle = None

    /**
     * 有序列表列表编号文本字体粗细
     */
    var orderedListMarkerTextFontWeight: ?FontWeight = None

    /**
     * 有序列表列表编号文本字体
     */
    var orderedListMarkerTextFontFamily: ?String = None

    /**
     * 有序列表列表编号文本行高
     */
    var orderedListMarkerTextLineHeight: ?Float64 = None

    public init() {}

    /**
     * 设置有序列表背景颜色
     *
     * @param color 背景颜色
     */
    public func setOrderedListBackgroundColor(color: UInt32): Unit {
        orderedListBackgroundColor = transColorForTrasparent(color)
    }

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     */
    public func setOrderedListAllMargin(margin: Float64): Unit {
        orderedListMarginTop = margin
        orderedListMarginRight = margin
        orderedListMarginBottom = margin
        orderedListMarginLeft = margin
    }

    /**
     * 分别设置4个外边距
     *
     * @param top-上外边距 命名参数
     * @param right-右外边距 命名参数
     * @param bottom-下外边距 命名参数
     * @param left-左外边距 命名参数
     */
    public func setOrderedListMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        orderedListMarginTop = top
        orderedListMarginRight = right
        orderedListMarginBottom = bottom
        orderedListMarginLeft = left
    }

    /**
     * 设置4个内边距为统一值
     *
     * @param padding 内边距
     */
    public func setOrderedListAllPadding(padding: Float64): Unit {
        orderedListPaddingTop = padding
        orderedListPaddingRight = padding
        orderedListPaddingBottom = padding
        orderedListPaddingLeft = padding
    }

    /**
     * 分别设置4个内边距
     *
     * @param top-上内边距 命名参数
     * @param right-右内边距 命名参数
     * @param bottom-下内边距 命名参数
     * @param left-左内边距 命名参数
     */
    public func setOrderedListPadding(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        orderedListPaddingTop = top
        orderedListPaddingRight = right
        orderedListPaddingBottom = bottom
        orderedListPaddingLeft = left
    }

    /**
     * 设置有序列表子模块上下间距
     *
     * @param spacing 上下间距
     */
    public func setOrderedListChildSpacing(spacing: Int64): Unit {
        orderedListChildSpacing = spacing
    }

    /**
     * 设置有序列表列表编号和列表内容间距
     *
     * @param spacing 间距
     */
    public func setOrderedListMarkerSpacing(spacing: Float64): Unit {
        orderedListMarkerSpacing = spacing
    }

    /**
     * 设置有序列表列表编号文本颜色
     *
     * @param color 文本颜色
     */
    public func setOrderedListMarkerTextFontColor(color: UInt32): Unit {
        orderedListMarkerTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置有序列表列表编号文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setOrderedListMarkerTextFontSize(size: Float64): Unit {
        orderedListMarkerTextFontSize = size
    }

    /**
     * 设置有序列表列表编号文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setOrderedListMarkerTextFontStyle(style: Int64): Unit {
        orderedListMarkerTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置有序列表列表编号文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setOrderedListMarkerTextFontWeight(weight: Int64): Unit {
        orderedListMarkerTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置有序列表列表编号文本字体
     *
     * @param family 文本字体
     */
    public func setOrderedListMarkerTextFontFamily(family: String): Unit {
        orderedListMarkerTextFontFamily = family
    }

    /**
     * 设置有序列表列表编号文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setOrderedListMarkerTextLineHeight(lineHeight: Float64): Unit {
        orderedListMarkerTextLineHeight = lineHeight
    }

    /**
     * 设置有序列表子模块中子模块上下间距
     *
     * @param spacing 间距
     */
    public func setOrderedListChildChildSpacing(spacing: Int64): Unit {
        orderedListChildChildSpacing = spacing
    }
}
