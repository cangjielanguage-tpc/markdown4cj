package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownBulletListTheme {
    /**
     * 无序列表背景颜色
     */
    var bulletListBackgroundColor: ?Color = None

    /**
     * 无序列表上外边距
     */
    var bulletListMarginTop: ?Float64 = None

    /**
     * 无序列表右外边距
     */
    var bulletListMarginRight: ?Float64 = None

    /**
     * 无序列表下外边距
     */
    var bulletListMarginBottom: ?Float64 = None

    /**
     * 无序列表左外边距
     */
    var bulletListMarginLeft: ?Float64 = None

    /**
     * 无序列表上内边距
     */
    var bulletListPaddingTop: ?Float64 = None

    /**
     * 无序列表右内边距
     */
    var bulletListPaddingRight: ?Float64 = None

    /**
     * 无序列表下内边距
     */
    var bulletListPaddingBottom: ?Float64 = None

    /**
     * 无序列表左内边距
     */
    var bulletListPaddingLeft: ?Float64 = None

    /**
     * 无序列表子模块上下间距
     */
    var bulletListChildSpacing: ?Int64 = None

    /**
     * 无序/任务子模块中子模块上下间距
     */
    var bulletListChildChildSpacing: ?Int64 = None

    /**
     * 无序列表列表符号和列表内容间距
     */
    var bulletListBulletSpacing: ?Float64 = None

    /**
     * 无序列表列表符号是否全部是实心圆型
     */
    var bulletListBulletIsCircle: ?Bool = None

    /**
     * 无序列表列表符号文本颜色
     */
    var bulletListBulletTextFontColor: ?Color = None

    /**
     * 无序列表列表符号文本尺寸
     */
    var bulletListBulletTextFontSize: ?Float64 = None

    /**
     * 无序列表列表符号文本字体样式
     */
    var bulletListBulletTextFontStyle: ?FontStyle = None

    /**
     * 无序列表列表符号文本字体粗细
     */
    var bulletListBulletTextFontWeight: ?FontWeight = None

    /**
     * 无序列表列表符号文本字体
     */
    var bulletListBulletTextFontFamily: ?String = None

    /**
     * 无序列表列表符号文本行高
     */
    var bulletListBulletTextLineHeight: ?Float64 = None

    /**
     * 任务列表多选框和列表内容间距
     */
    var bulletListCheckboxSpacing: ?Float64 = None

    /**
     * 任务列表多选框宽度
     */
    var bulletListCheckboxWidth: ?Float64 = None

    /**
     * 任务列表多选框高度
     */
    var bulletListCheckboxHeight: ?Float64 = None

    /**
     * 任务列表多选框选中颜色
     */
    var bulletListCheckboxSelectedColor: ?Color = None

    /**
     * 任务列表多选框形状
     */
    var bulletListCheckboxShape: ?CheckBoxShape = None

    public init() {}

    /**
     * 设置无序列表背景颜色
     *
     * @param color 背景颜色
     */
    public func setBulletListBackgroundColor(color: UInt32): Unit {
        bulletListBackgroundColor = transColorForTrasparent(color)
    }

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     */
    public func setBulletListAllMargin(margin: Float64): Unit {
        bulletListMarginTop = margin
        bulletListMarginRight = margin
        bulletListMarginBottom = margin
        bulletListMarginLeft = margin
    }

    /**
     * 分别设置4个外边距
     *
     * @param top-上外边距 命名参数
     * @param right-右外边距 命名参数
     * @param bottom-下外边距 命名参数
     * @param left-左外边距 命名参数
     */
    public func setBulletListMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        bulletListMarginTop = top
        bulletListMarginRight = right
        bulletListMarginBottom = bottom
        bulletListMarginLeft = left
    }

    /**
     * 设置4个内边距为统一值
     *
     * @param padding 内边距
     */
    public func setBulletListAllPadding(padding: Float64): Unit {
        bulletListPaddingTop = padding
        bulletListPaddingRight = padding
        bulletListPaddingBottom = padding
        bulletListPaddingLeft = padding
    }

    /**
     * 分别设置4个内边距
     *
     * @param top-上内边距 命名参数
     * @param right-右内边距 命名参数
     * @param bottom-下内边距 命名参数
     * @param left-左内边距 命名参数
     */
    public func setBulletListPadding(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        bulletListPaddingTop = top
        bulletListPaddingRight = right
        bulletListPaddingBottom = bottom
        bulletListPaddingLeft = left
    }

    /**
     * 设置无序列表子模块上下间距
     *
     * @param spacing 上下间距
     */
    public func setBulletListChildSpacing(spacing: Int64): Unit {
        bulletListChildSpacing = spacing
    }

    /**
     * 设置无序/任务子模块中子模块上下间距
     *
     * @param spacing 无序/任务子模块中子模块上下间距
     */
    public func setBulletListChildChildSpacing(spacing: Int64): Unit {
        bulletListChildChildSpacing = spacing
    }

    /**
     * 设置无序列表列表符号和列表内容间距
     *
     * @param spacing 间距
     */
    public func setBulletListBulletSpacing(spacing: Float64): Unit {
        bulletListBulletSpacing = spacing
    }

    /**
     * 设置无序列表列表符号是否全部是实心圆型
     *
     * @param isCircle 是否全部是实心圆型
     */
    public func setBulletListBulletIsCircle(isCircle: Bool): Unit {
        bulletListBulletIsCircle = isCircle
    }

    /**
     * 设置无序列表列表符号文本颜色
     *
     * @param color 文本颜色
     */
    public func setBulletListBulletTextFontColor(color: UInt32): Unit {
        bulletListBulletTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置无序列表列表符号文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setBulletListBulletTextFontSize(size: Float64): Unit {
        bulletListBulletTextFontSize = size
    }

    /**
     * 设置无序列表列表符号文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setBulletListBulletTextFontStyle(style: Int64): Unit {
        bulletListBulletTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置无序列表列表符号文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setBulletListBulletTextFontWeight(weight: String): Unit {
        bulletListBulletTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置无序列表列表符号文本字体
     *
     * @param family 文本字体
     */
    public func setBulletListBulletTextFontFamily(family: String): Unit {
        bulletListBulletTextFontFamily = family
    }

    /**
     * 设置无序列表列表符号文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setBulletListBulletTextLineHeight(lineHeight: Float64): Unit {
        bulletListBulletTextLineHeight = lineHeight
    }

    /**
     * 设置任务列表多选框和列表内容间距
     *
     * @param spacing 间距
     */
    public func setBulletListCheckboxSpacing(spacing: Float64): Unit {
        bulletListCheckboxSpacing = spacing
    }

    /**
     * 设置任务列表多选框宽度
     *
     * @param width 多选框宽度
     */
    public func setBulletListCheckboxWidth(width: Float64): Unit {
        bulletListCheckboxWidth = width
    }

    /**
     * 设置任务列表多选框高度
     *
     * @param height 多选框高度
     */
    public func setBulletListCheckboxHeight(height: Float64): Unit {
        bulletListCheckboxHeight = height
    }

    /**
     * 设置任务列表多选框选中颜色
     *
     * @param color 选中颜色
     */
    public func setBulletListCheckboxSelectedColor(color: UInt32): Unit {
        bulletListCheckboxSelectedColor = transColorForTrasparent(color)
    }

    /**
     * 设置任务列表多选框形状
     *
     * @param shape 多选框形状
     */
    public func setBulletListCheckboxShape(shape: Int64): Unit {
        bulletListCheckboxShape = convertCheckBoxShape(shape)
    }
}
