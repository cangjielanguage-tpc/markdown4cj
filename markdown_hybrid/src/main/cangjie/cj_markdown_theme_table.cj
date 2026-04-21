/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownTableTheme {
    /**
     * 表格标题背景颜色
     */
    var tableTitleBackgroundColor: ?Color = None

    /**
     * 表格内容奇数行背景颜色
     */
    var tableContentOddRowBackgroundColor: ?Color = None

    /**
     * 表格内容偶数行背景颜色
     */
    var tableContentEvenRowBackgroundColor: ?Color = None

    /**
     * 表格上外边距
     */
    var tableMarginTop: ?Float64 = None

    /**
     * 表格右外边距
     */
    var tableMarginRight: ?Float64 = None

    /**
     * 表格下外边距
     */
    var tableMarginBottom: ?Float64 = None

    /**
     * 表格左外边距
     */
    var tableMarginLeft: ?Float64 = None

    /**
     * 表格上内边距
     */
    var tablePaddingTop: ?Float64 = None

    /**
     * 表格右内边距
     */
    var tablePaddingRight: ?Float64 = None

    /**
     * 表格下内边距
     */
    var tablePaddingBottom: ?Float64 = None

    /**
     * 表格左内边距
     */
    var tablePaddingLeft: ?Float64 = None

    /**
     * 表格内容上内边距
     */
    var tableCellPaddingTop: ?Float64 = None

    /**
     * 表格内容右内边距
     */
    var tableCellPaddingRight: ?Float64 = None

    /**
     * 表格内容下内边距
     */
    var tableCellPaddingBottom: ?Float64 = None

    /**
     * 表格内容左内边距
     */
    var tableCellPaddingLeft: ?Float64 = None

    /**
     * 表格边框样式
     */
    var tableBorderStyle: ?BorderStyle = None

    /**
     * 表格边框宽度
     */
    var tableBorderWidth: ?Float64 = None

    /**
     * 表格边框颜色
     */
    var tableBorderColor: ?Color = None

    /**
     * 表格边框左上圆角
     */
    var tableRadiusTopLeft: ?Float64 = None

    /**
     * 表格边框右上圆角
     */
    var tableRadiusTopRight: ?Float64 = None

    /**
     * 表格边框左下圆角
     */
    var tableRadiusBottomLeft: ?Float64 = None

    /**
     * 表格边框右下圆角
     */
    var tableRadiusBottomRight: ?Float64 = None

    /**
     * 表格滚动条状态
     */
    var tableScrollBarState: ?BarState = None

    /**
     * 表格滚动条颜色
     */
    var tableScrollBarColor: ?Color = None

    /**
     * 表格一格最小宽度
     */
    var tableMinCellWidth: ?Float64 = None

    /**
     * 表格一格最大宽度
     */
    var tableMaxCellWidth: ?Float64 = None

    /**
     * 表格第一列是否加粗
     */
    var tableFirstColumnIsBold: ?Bool = None

    /**
     * 表格标题文本颜色
     */
    var tableTitleTextFontColor: ?Color = None

    /**
     * 表格标题文本尺寸
     */
    var tableTitleTextFontSize: ?Float64 = None

    /**
     * 表格标题文本字体样式
     */
    var tableTitleTextFontStyle: ?FontStyle = None

    /**
     * 表格标题文本字体粗细
     */
    var tableTitleTextFontWeight: ?FontWeight = None

    /**
     * 表格标题文本字体
     */
    var tableTitleTextFontFamily: ?String = None

    /**
     * 表格标题文本行高
     */
    var tableTitleTextLineHeight: ?Float64 = None

    /**
     * 表格标题文本字符间距
     */
    var tableTitleTextLetterSpacing: ?Float64 = None

    /**
     * 表格内容文本颜色
     */
    var tableContentTextFontColor: ?Color = None

    /**
     * 表格内容文本尺寸
     */
    var tableContentTextFontSize: ?Float64 = None

    /**
     * 表格内容文本字体样式
     */
    var tableContentTextFontStyle: ?FontStyle = None

    /**
     * 表格内容文本字体粗细
     */
    var tableContentTextFontWeight: ?FontWeight = None

    /**
     * 表格内容文本字体
     */
    var tableContentTextFontFamily: ?String = None

    /**
     * 表格内容文本行高
     */
    var tableContentTextLineHeight: ?Float64 = None

    /**
     * 表格内容文本字符间距
     */
    var tableContentTextLetterSpacing: ?Float64 = None

    public init() {}

    /**
     * 设置表格标题背景颜色
     *
     * @param color 背景颜色
     */
    public func setTableTitleBackgroundColor(color: UInt32): Unit {
        tableTitleBackgroundColor = transColorForTrasparent(color)
    }

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     */
    public func setTableAllMargin(margin: Float64): Unit {
        tableMarginTop = margin
        tableMarginRight = margin
        tableMarginBottom = margin
        tableMarginLeft = margin
    }

    /**
     * 分别设置4个外边距
     *
     * @param top-上外边距 命名参数
     * @param right-右外边距 命名参数
     * @param bottom-下外边距 命名参数
     * @param left-左外边距 命名参数
     */
    public func setTableMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        tableMarginTop = top
        tableMarginRight = right
        tableMarginBottom = bottom
        tableMarginLeft = left
    }

    /**
     * 设置4个内边距为统一值
     *
     * @param padding 内边距
     */
    public func setTableAllPadding(padding: Float64): Unit {
        tablePaddingTop = padding
        tablePaddingRight = padding
        tablePaddingBottom = padding
        tablePaddingLeft = padding
    }

    /**
     * 分别设置4个内边距
     *
     * @param top-上内边距 命名参数
     * @param right-右内边距 命名参数
     * @param bottom-下内边距 命名参数
     * @param left-左内边距 命名参数
     */
    public func setTablePadding(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        tablePaddingTop = top
        tablePaddingRight = right
        tablePaddingBottom = bottom
        tablePaddingLeft = left
    }

    /**
     * 设置表格内容内边距为统一值
     *
     * @param padding 内边距
     */
    public func setTableCellAllPadding(padding: Float64): Unit {
        tableCellPaddingTop = padding
        tableCellPaddingRight = padding
        tableCellPaddingBottom = padding
        tableCellPaddingLeft = padding
    }

    /**
     * 分别设置表格内容4个内边距
     *
     * @param top-上内边距 命名参数
     * @param right-右内边距 命名参数
     * @param bottom-下内边距 命名参数
     * @param left-左内边距 命名参数
     */
    public func setTableCellPadding(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        tableCellPaddingTop = top
        tableCellPaddingRight = right
        tableCellPaddingBottom = bottom
        tableCellPaddingLeft = left
    }

    /**
     * 设置表格边框4个圆角为统一值
     *
     * @param radius 圆角
     */
    public func setTableAllRadius(radius: Float64): Unit {
        tableRadiusTopLeft = radius
        tableRadiusTopRight = radius
        tableRadiusBottomLeft = radius
        tableRadiusBottomRight = radius
    }

    /**
     * 分别设置表格边框4个圆角
     *
     * @param topLeft-左上圆角 命名参数
     * @param topRight-右上圆角 命名参数
     * @param bottomLeft-左下圆角 命名参数
     * @param bottomRight-右下圆角 命名参数
     */
    public func setTableRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        tableRadiusTopLeft = topLeft
        tableRadiusTopRight = topRight
        tableRadiusBottomLeft = bottomLeft
        tableRadiusBottomRight = bottomRight
    }

    /**
     * 设置表格内容奇数行背景颜色
     *
     * @param color 背景颜色
     */
    public func setTableContentOddRowBackgroundColor(color: UInt32): Unit {
        tableContentOddRowBackgroundColor = transColorForTrasparent(color)
    }

    /**
     * 设置表格内容偶数行背景颜色
     *
     * @param color 背景颜色
     */
    public func setTableContentEvenRowBackgroundColor(color: UInt32): Unit {
        tableContentEvenRowBackgroundColor = transColorForTrasparent(color)
    }

    /**
     * 设置表格边框样式
     *
     * @param style 边框样式
     */
    public func setTableBorderStyle(style: Int64): Unit {
        tableBorderStyle = convertBorderStyle(style)
    }

    /**
     * 设置表格边框宽度
     *
     * @param width 边框宽度
     */
    public func setTableBorderWidth(width: Float64): Unit {
        tableBorderWidth = width
    }

    /**
     * 设置表格边框颜色
     *
     * @param color 边框颜色
     */
    public func setTableBorderColor(color: UInt32): Unit {
        tableBorderColor = transColorForTrasparent(color)
    }

    /**
     * 设置表格滚动条状态
     *
     * @param state 滚动条状态
     */
    public func setTableScrollBarState(state: Int64): Unit {
        tableScrollBarState = convertBarState(state)
    }

    /**
     * 设置表格滚动条颜色
     *
     * @param color 滚动条颜色
     */
    public func setTableScrollBarColor(color: UInt32): Unit {
        tableScrollBarColor = transColorForTrasparent(color)
    }

    /**
     * 设置表格一格最小宽度
     *
     * @param width 最小宽度
     */
    public func setTableMinCellWidth(width: Float64): Unit {
        tableMinCellWidth = width
    }

    /**
     * 设置表格一格最大宽度
     *
     * @param width 最大宽度
     */
    public func setTableMaxCellWidth(width: Float64): Unit {
        tableMaxCellWidth = width
    }

    /**
     * 设置表格第一列是否加粗
     *
     * @param isBold 是否加粗
     */
    public func setTableFirstColumnIsBold(isBold: Bool): Unit {
        tableFirstColumnIsBold = isBold
    }

    /**
     * 设置表格标题文本颜色
     *
     * @param color 文本颜色
     */
    public func setTableTitleTextFontColor(color: UInt32): Unit {
        tableTitleTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置表格标题文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setTableTitleTextFontSize(size: Float64): Unit {
        tableTitleTextFontSize = size
    }

    /**
     * 设置表格标题文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setTableTitleTextFontStyle(style: Int64): Unit {
        tableTitleTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置表格标题文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setTableTitleTextFontWeight(weight: Int64): Unit {
        tableTitleTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置表格标题文本字体
     *
     * @param family 文本字体
     */
    public func setTableTitleTextFontFamily(family: String): Unit {
        tableTitleTextFontFamily = family
    }

    /**
     * 设置表格标题文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setTableTitleTextLineHeight(lineHeight: Float64): Unit {
        tableTitleTextLineHeight = lineHeight
    }

    /**
     * 设置表格标题文本字符间距
     *
     * @param spacing 文本字符间距
     */
    public func setTableTitleTextLetterSpacing(spacing: Float64): Unit {
        tableTitleTextLetterSpacing = spacing
    }

    /**
     * 设置表格内容文本颜色
     *
     * @param color 文本颜色
     */
    public func setTableContentTextFontColor(color: UInt32): Unit {
        tableContentTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置表格内容文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setTableContentTextFontSize(size: Float64): Unit {
        tableContentTextFontSize = size
    }

    /**
     * 设置表格内容文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setTableContentTextFontStyle(style: Int64): Unit {
        tableContentTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置表格内容文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setTableContentTextFontWeight(weight: Int64): Unit {
        tableContentTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置表格内容文本字体
     *
     * @param family 文本字体
     */
    public func setTableContentTextFontFamily(family: String): Unit {
        tableContentTextFontFamily = family
    }

    /**
     * 设置表格内容文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setTableContentTextLineHeight(lineHeight: Float64): Unit {
        tableContentTextLineHeight = lineHeight
    }

    /**
     * 设置表格内容文本字符间距
     *
     * @param spacing 文本字符间距
     */
    public func setTableContentTextLetterSpacing(spacing: Float64): Unit {
        tableContentTextLetterSpacing = spacing
    }
}
