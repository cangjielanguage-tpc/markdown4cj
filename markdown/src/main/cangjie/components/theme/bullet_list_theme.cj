package markdown.components.theme

/**
 * 无序/任务列表样式
 */
public class BulletListTheme <: MarkdownBaseTheme {
    public var bulletListBackgroundColor: ?Color = None // 无序/任务背景颜色
    public var bulletListMarginTop: Float64 = 0.0 // 无序/任务上外边距
    public var bulletListMarginRight: Float64 = 0.0 // 无序/任务右外边距
    public var bulletListMarginBottom: Float64 = 0.0 // 无序/任务下外边距
    public var bulletListMarginLeft: Float64 = 8.0 // 无序/任务左外边距
    public var bulletListPaddingTop: Float64 = 0.0 // 无序/任务上内边距
    public var bulletListPaddingRight: Float64 = 0.0 // 无序/任务右内边距
    public var bulletListPaddingBottom: Float64 = 0.0 // 无序/任务下内边距
    public var bulletListPaddingLeft: Float64 = 0.0 // 无序/任务左内边距
    public var bulletListChildSpacing: Int64 = 8 // 无序/任务子模块上下间距
    public var bulletListChildChildSpacing: Int64 = 8 // 无序/任务子模块中子模块上下间距
    public var bulletListBulletSpacing: Float64 = 8.0 // 无序列表列表符号和列表内容间距
    public var bulletListBulletIsCircle: Bool = false // 无序列表列表符号是否全部是实心圆型
    public var bulletListBulletTextFontColor: Color = COLOR_FF191919 // 无序列表列表符号文本颜色
    public var bulletListBulletTextFontSize: Float64 = 4.0 // 无序列表列表符号文本尺寸
    public var bulletListBulletTextFontStyle: FontStyle = FontStyle.Normal // 无序列表列表符号文本字体样式
    public var bulletListBulletTextFontWeight: FontWeight = FontWeight.W400 // 无序列表列表符号文本字体粗细
    public var bulletListBulletTextFontFamily: String = "HarmonyOS Sans" // 无序列表列表符号文本字体
    public var bulletListBulletTextLineHeight: Float64 = 18.0 // 无序列表列表符号文本行高
    public var bulletListCheckboxSpacing: Float64 = 8.0 // 任务列表多选框和列表内容间距
    public var bulletListCheckboxWidth: Float64 = 15.0 // 任务列表多选框宽度
    public var bulletListCheckboxHeight: Float64 = 15.0 // 任务列表多选框高度
    public var bulletListCheckboxSelectedColor: Color = COLOR_GRAY // 任务列表多选框选中颜色
    public var bulletListCheckboxShape: CheckBoxShape = CheckBoxShape.ROUNDED_SQUARE // 任务列表多选框形状

    /**
     * 设置无序/任务背景颜色
     *
     * @param color 无序/任务背景颜色
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBackgroundColor(color: Color): BulletListTheme {
        this.bulletListBackgroundColor = color
        return this
    }

    /**
     * 统一设置无序/任务外边距
     *
     * @param margin 外边距
     * @return 当前BulletListTheme对象
     */
    public func setBulletListMargin(margin: Float64): BulletListTheme {
        this.bulletListMarginTop = margin
        this.bulletListMarginRight = margin
        this.bulletListMarginBottom = margin
        this.bulletListMarginLeft = margin
        return this
    }

    /**
     * 分别设置无序/任务四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前BulletListTheme对象
     */
    public func setBulletListMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 8.0): BulletListTheme {
        this.bulletListMarginTop = top
        this.bulletListMarginRight = right
        this.bulletListMarginBottom = bottom
        this.bulletListMarginLeft = left
        return this
    }

    /**
     * 统一设置无序/任务内边距
     *
     * @param padding 内边距
     * @return 当前BulletListTheme对象
     */
    public func setBulletListPadding(padding: Float64): BulletListTheme {
        this.bulletListPaddingTop = padding
        this.bulletListPaddingRight = padding
        this.bulletListPaddingBottom = padding
        this.bulletListPaddingLeft = padding
        return this
    }

    /**
     * 分别设置无序/任务四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前BulletListTheme对象
     */
    public func setBulletListPadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): BulletListTheme {
        this.bulletListPaddingTop = top
        this.bulletListPaddingRight = right
        this.bulletListPaddingBottom = bottom
        this.bulletListPaddingLeft = left
        return this
    }

    /**
     * 设置无序/任务子模块上下间距
     *
     * @param spacing 无序/任务子模块上下间距
     * @return 当前BulletListTheme对象
     */
    public func setBulletListChildSpacing(spacing: Int64): BulletListTheme {
        this.bulletListChildSpacing = spacing
        return this
    }

    /**
     * 设置无序/任务子模块中子模块上下间距
     *
     * @param spacing 无序/任务子模块中子模块上下间距
     * @return 当前BulletListTheme对象
     */
    public func setBulletListChildChildSpacing(spacing: Int64): BulletListTheme {
        this.bulletListChildChildSpacing = spacing
        return this
    }

    /**
     * 设置无序列表列表符号和列表内容间距
     *
     * @param spacing 无序列表列表符号和列表内容间距
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletSpacing(spacing: Float64): BulletListTheme {
        this.bulletListBulletSpacing = spacing
        return this
    }

    /**
     * 设置无序列表列表符号是否全部是实心圆型
     *
     * @param isCircle 无序列表列表符号是否全部是实心圆型
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletIsCircle(isCircle: Bool): BulletListTheme {
        this.bulletListBulletIsCircle = isCircle
        return this
    }

    /**
     * 设置无序列表列表符号文本颜色
     *
     * @param color 无序列表列表符号文本颜色
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletTextFontColor(color: Color): BulletListTheme {
        this.bulletListBulletTextFontColor = color
        return this
    }

    /**
     * 设置无序列表列表符号文本尺寸
     *
     * @param size 无序列表列表符号文本尺寸
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletTextFontSize(size: Float64): BulletListTheme {
        this.bulletListBulletTextFontSize = size
        return this
    }

    /**
     * 设置无序列表列表符号文本字体样式
     *
     * @param style 无序列表列表符号文本字体样式
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletTextFontStyle(style: FontStyle): BulletListTheme {
        this.bulletListBulletTextFontStyle = style
        return this
    }

    /**
     * 设置无序列表列表符号文本字体粗细
     *
     * @param weight 无序列表列表符号文本字体粗细
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletTextFontWeight(weight: FontWeight): BulletListTheme {
        this.bulletListBulletTextFontWeight = weight
        return this
    }

    /**
     * 设置无序列表列表符号文本字体
     *
     * @param family 无序列表列表符号文本字体
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletTextFontFamily(family: String): BulletListTheme {
        this.bulletListBulletTextFontFamily = family
        return this
    }

    /**
     * 设置无序列表列表符号文本行高
     *
     * @param lineHeight 无序列表列表符号文本行高
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletTextLineHeight(lineHeight: Float64): BulletListTheme {
        this.bulletListBulletTextLineHeight = lineHeight
        return this
    }

    /**
     * 设置任务列表多选框和列表内容间距
     *
     * @param spacing 任务列表多选框和列表内容间距
     * @return 当前BulletListTheme对象
     */
    public func setBulletListCheckboxSpacing(spacing: Float64): BulletListTheme {
        this.bulletListCheckboxSpacing = spacing
        return this
    }

    /**
     * 设置任务列表多选框宽度
     *
     * @param width 任务列表多选框宽度
     * @return 当前BulletListTheme对象
     */
    public func setBulletListCheckboxWidth(width: Float64): BulletListTheme {
        this.bulletListCheckboxWidth = width
        return this
    }

    /**
     * 设置任务列表多选框高度
     *
     * @param height 任务列表多选框高度
     * @return 当前BulletListTheme对象
     */
    public func setBulletListCheckboxHeight(height: Float64): BulletListTheme {
        this.bulletListCheckboxHeight = height
        return this
    }

    /**
     * 设置任务列表多选框选中颜色
     *
     * @param color 任务列表多选框选中颜色
     * @return 当前BulletListTheme对象
     */
    public func setBulletListCheckboxSelectedColor(color: Color): BulletListTheme {
        this.bulletListCheckboxSelectedColor = color
        return this
    }

    /**
     * 设置任务列表多选框形状
     *
     * @param shape 任务列表多选框形状
     * @return 当前BulletListTheme对象
     */
    public func setBulletListCheckboxShape(shape: CheckBoxShape): BulletListTheme {
        this.bulletListCheckboxShape = shape
        return this
    }
}