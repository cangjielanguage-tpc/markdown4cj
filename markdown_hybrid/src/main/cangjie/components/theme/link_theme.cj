package markdown.components.theme

/**
 * 链接文本样式
 */
public class LinkTheme <: MarkdownBaseTheme {
    public var linkIsIcon: Bool = false // 链接是否是图片显示
    public var linkListIsIcon: Bool = false // 列表中的单行链接是否是图片显示
    public var linkTextFontColor: Color = COLOR_RED // 链接文本颜色
    public var linkTextFontSize: ?Float64 = None // 链接文本尺寸
    public var linkTextFontStyle: ?FontStyle = None // 链接文本字体样式
    public var linkTextFontWeight: ?FontWeight = None // 链接文本字体粗细
    public var linkTextFontFamily: ?String = None // 链接文本字体
    public var linkTextLineHeight: ?Float64 = None // 链接文本行高
    public var linkTextLetterSpacing: ?Float64 = None // 链接文本字符间距
    public var linkTextDecorationType: TextDecorationType = TextDecorationType.Underline // 链接文本装饰线类型
    public var linkTextDecorationColor: Color = COLOR_RED // 链接文本装饰线颜色
    public var linkTextDecorationStyle: MarkdownTextDecorationStyle = MarkdownTextDecorationStyle.SOLID // 链接文本装饰线样式
    public var linkTextBackgroundColor: Color = COLOR_TRANSPARENT // 链接文本背景颜色
    public var linkTextBackgroundRadiusTopLeft: Float64 = 0.0 // 链接文本背景左上圆角
    public var linkTextBackgroundRadiusTopRight: Float64 = 0.0 // 链接文本背景右上圆角
    public var linkTextBackgroundRadiusBottomLeft: Float64 = 0.0 // 链接文本背景左下圆角
    public var linkTextBackgroundRadiusBottomRight: Float64 = 0.0 // 链接文本背景右下圆角
    public var linkCircleIconBackgroundColor: Color = COLOR_TRANSPARENT // 圆形图片格式链接主题背景颜色
    public var linkCircleIconButtonBackgroundColor: Color = COLOR_BLACK // 圆形图片格式链接控件背景颜色
    public var linkCircleIconTextSize: Float64 = 14.0 // 圆形图片格式链接文字大小 - 实际使用要转换
    public var linkCircleIconTextColor: Color = COLOR_WHITE // 圆形图片格式链接文字颜色
    public var linkCircleIconRadius: Float64 = 20.0 // 圆形图片格式链接半径 - 实际使用要转换
    public var linkCircleIconMargin: Float64 = 6.0 // 圆形图片格式链接左右外边距
    public var linkRectIconBackgroundColor: Color = COLOR_TRANSPARENT // 圆角矩形图片格式链接主题背景颜色
    public var linkRectIconButtonBackgroundColor: Color = COLOR_BLACK // 圆角矩形图片格式链接控件背景颜色
    public var linkRectIconTextSize: Float64 = 14.0 // 圆角矩形图片格式链接文字大小 - 实际使用要转换
    public var linkRectIconTextColor: Color = COLOR_WHITE // 圆角矩形图片格式链接文字颜色
    public var linkRectIconHeight: Float64 = 20.0 // 圆角矩形图片格式链接控件高度 - 实际使用要转换
    public var linkRectIconPadding: Float64 = 6.0 // 圆角矩形图片格式链接左右内边距 - 实际使用要转换
    public var linkRectIconRadius: Float64 = 6.0 // 圆角矩形图片格式链接圆角半径 - 实际使用要转换
    public var linkRectIconMargin: Float64 = 6.0 // 圆角矩形图片格式链接左右外边距
    public var linkRectToolIconBackgroundColor: Color = COLOR_TRANSPARENT // 空心圆角矩形图片格式链接主题背景颜色
    public var linkRectToolIconButtonBackgroundColor: Color = COLOR_WHITE // 空心圆角矩形图片格式链接控件背景颜色
    public var linkRectToolIconTextSize: Float64 = 14.0 // 空心圆角矩形图片格式链接文字大小 - 实际使用要转换
    public var linkRectToolIconHeight: Float64 = 21.0 // 空心圆角矩形图片格式链接控件高度 - 实际使用要转换
    public var linkRectToolIconPadding: Float64 = 6.0 // 空心圆角矩形图片格式链接左右内边距 - 实际使用要转换
    public var linkRectToolIconBorderWidth: Float64 = 1.0 // 空心圆角矩形图片格式链接边框宽度 - 实际使用要转换
    public var linkRectToolIconDividingLineWidth: Float64 = 1.0 // 空心圆角矩形图片格式链接分割线宽度 - 实际使用要转换
    public var linkRectToolIconMargin: Float64 = 6.0 // 空心圆角矩形图片格式链接左右外边距
    public var linkRectToolIconLineLeftPadding: Float64 = 3.0 // 空心圆角矩形图片格式分割线和文本左边距 - 实际使用要转换
    public var linkRectToolIconLineRightPadding: Float64 = 3.0 // 空心圆角矩形图片格式分割线和文本右边距 - 实际使用要转换

    /**
     * 设置链接是否是图片显示
     *
     * @param isIcon 链接是否是图片显示
     * @return 当前LinkTheme对象
     */
    public func setLinkIsIcon(isIcon: Bool): LinkTheme {
        this.linkIsIcon = isIcon
        return this
    }

    /**
     * 设置列表中的单行链接是否是图片显示
     *
     * @param isIcon 列表中的单行链接是否是图片显示
     * @return 当前LinkTheme对象
     */
    public func setLinkListIsIcon(isIcon: Bool): LinkTheme {
        this.linkListIsIcon = isIcon
        return this
    }

    /**
     * 设置链接文本颜色
     *
     * @param color 链接文本颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkTextFontColor(color: Color): LinkTheme {
        this.linkTextFontColor = color
        return this
    }

    /**
     * 设置链接文本尺寸
     *
     * @param size 链接文本尺寸
     * @return 当前LinkTheme对象
     */
    public func setLinkTextFontSize(size: Float64): LinkTheme {
        this.linkTextFontSize = size
        return this
    }

    /**
     * 设置链接文本字体样式
     *
     * @param style 链接文本字体样式
     * @return 当前LinkTheme对象
     */
    public func setLinkTextFontStyle(style: FontStyle): LinkTheme {
        this.linkTextFontStyle = style
        return this
    }

    /**
     * 设置链接文本字体粗细
     *
     * @param weight 链接文本字体粗细
     * @return 当前LinkTheme对象
     */
    public func setLinkTextFontWeight(weight: FontWeight): LinkTheme {
        this.linkTextFontWeight = weight
        return this
    }

    /**
     * 设置链接文本字体
     *
     * @param family 链接文本字体
     * @return 当前LinkTheme对象
     */
    public func setLinkTextFontFamily(family: String): LinkTheme {
        this.linkTextFontFamily = family
        return this
    }

    /**
     * 设置链接文本行高
     *
     * @param lineHeight 链接文本行高
     * @return 当前LinkTheme对象
     */
    public func setLinkTextLineHeight(lineHeight: Float64): LinkTheme {
        this.linkTextLineHeight = lineHeight
        return this
    }

    /**
     * 设置链接文本字符间距
     *
     * @param spacing 链接文本字符间距
     * @return 当前LinkTheme对象
     */
    public func setLinkTextLetterSpacing(spacing: Float64): LinkTheme {
        this.linkTextLetterSpacing = spacing
        return this
    }

    /**
     * 设置链接文本装饰线类型
     *
     * @param decorationType 链接文本装饰线类型
     * @return 当前LinkTheme对象
     */
    public func setLinkTextDecorationType(decorationType: TextDecorationType): LinkTheme {
        this.linkTextDecorationType = decorationType
        return this
    }

    /**
     * 设置链接文本装饰线颜色
     *
     * @param color 链接文本装饰线颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkTextDecorationColor(color: Color): LinkTheme {
        this.linkTextDecorationColor = color
        return this
    }

    /**
     * 设置链接文本装饰线样式
     *
     * @param style 链接文本装饰线样式
     * @return 当前LinkTheme对象
     */
    public func setLinkTextDecorationStyle(style: MarkdownTextDecorationStyle): LinkTheme {
        this.linkTextDecorationStyle = style
        return this
    }

    /**
     * 设置链接文本背景颜色
     *
     * @param color 链接文本背景颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkTextBackgroundColor(color: Color): LinkTheme {
        this.linkTextBackgroundColor = color
        return this
    }

    /**
     * 统一设置链接文本背景四个圆角
     *
     * @param radius 统一圆角半径，同时赋值给四个角
     * @return 当前LinkTheme对象
     */
    public func setLinkTextBackgroundRadius(radius: Float64): LinkTheme {
        this.linkTextBackgroundRadiusTopLeft = radius
        this.linkTextBackgroundRadiusTopRight = radius
        this.linkTextBackgroundRadiusBottomLeft = radius
        this.linkTextBackgroundRadiusBottomRight = radius
        return this
    }

    /**
     * 分别设置4个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前LinkTheme对象
     */
    public func setLinkTextBackgroundRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): LinkTheme {
        this.linkTextBackgroundRadiusTopLeft = topLeft
        this.linkTextBackgroundRadiusTopRight = topRight
        this.linkTextBackgroundRadiusBottomLeft = bottomLeft
        this.linkTextBackgroundRadiusBottomRight = bottomRight
        return this
    }

    /**
     * 设置圆形图片格式链接主题背景颜色
     *
     * @param color 圆形图片格式链接主题背景颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkCircleIconBackgroundColor(color: Color): LinkTheme {
        this.linkCircleIconBackgroundColor = color
        return this
    }

    /**
     * 设置圆形图片格式链接控件背景颜色
     *
     * @param color 圆形图片格式链接控件背景颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkCircleIconButtonBackgroundColor(color: Color): LinkTheme {
        this.linkCircleIconButtonBackgroundColor = color
        return this
    }

    /**
     * 设置圆形图片格式链接文字大小
     *
     * @param size 圆形图片格式链接文字大小
     * @return 当前LinkTheme对象
     */
    public func setLinkCircleIconTextSize(size: Float64): LinkTheme {
        this.linkCircleIconTextSize = size
        return this
    }

    /**
     * 设置圆形图片格式链接文字颜色
     *
     * @param color 圆形图片格式链接文字颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkCircleIconTextColor(color: Color): LinkTheme {
        this.linkCircleIconTextColor = color
        return this
    }

    /**
     * 设置圆形图片格式链接半径
     *
     * @param radius 圆形图片格式链接半径
     * @return 当前LinkTheme对象
     */
    public func setLinkCircleIconRadius(radius: Float64): LinkTheme {
        this.linkCircleIconRadius = radius
        return this
    }

    /**
     * 设置圆形图片格式链接左右外边距
     *
     * @param margin 圆形图片格式链接左右外边距
     * @return 当前LinkTheme对象
     */
    public func setLinkCircleIconMargin(margin: Float64): LinkTheme {
        this.linkCircleIconMargin = margin
        return this
    }

    /**
     * 设置圆角矩形图片格式链接主题背景颜色
     *
     * @param color 圆角矩形图片格式链接主题背景颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconBackgroundColor(color: Color): LinkTheme {
        this.linkRectIconBackgroundColor = color
        return this
    }

    /**
     * 设置圆角矩形图片格式链接控件背景颜色
     *
     * @param color 圆角矩形图片格式链接控件背景颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconButtonBackgroundColor(color: Color): LinkTheme {
        this.linkRectIconButtonBackgroundColor = color
        return this
    }

    /**
     * 设置圆角矩形图片格式链接文字大小
     *
     * @param size 圆角矩形图片格式链接文字大小
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconTextSize(size: Float64): LinkTheme {
        this.linkRectIconTextSize = size
        return this
    }

    /**
     * 设置圆角矩形图片格式链接文字颜色
     *
     * @param color 圆角矩形图片格式链接文字颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconTextColor(color: Color): LinkTheme {
        this.linkRectIconTextColor = color
        return this
    }

    /**
     * 设置圆角矩形图片格式链接控件高度
     *
     * @param height 圆角矩形图片格式链接控件高度
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconHeight(height: Float64): LinkTheme {
        this.linkRectIconHeight = height
        return this
    }

    /**
     * 设置圆角矩形图片格式链接左右内边距
     *
     * @param padding 圆角矩形图片格式链接左右内边距
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconPadding(padding: Float64): LinkTheme {
        this.linkRectIconPadding = padding
        return this
    }

    /**
     * 设置圆角矩形图片格式链接圆角半径
     *
     * @param radius 圆角矩形图片格式链接圆角半径
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconRadius(radius: Float64): LinkTheme {
        this.linkRectIconRadius = radius
        return this
    }

    /**
     * 设置圆角矩形图片格式链接左右外边距
     *
     * @param margin 圆角矩形图片格式链接左右外边距
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconMargin(margin: Float64): LinkTheme {
        this.linkRectIconMargin = margin
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接主题背景颜色
     *
     * @param color 空心圆角矩形图片格式链接主题背景颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconBackgroundColor(color: Color): LinkTheme {
        this.linkRectToolIconBackgroundColor = color
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接控件背景颜色
     *
     * @param color 空心圆角矩形图片格式链接控件背景颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconButtonBackgroundColor(color: Color): LinkTheme {
        this.linkRectToolIconButtonBackgroundColor = color
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接文字大小
     *
     * @param size 空心圆角矩形图片格式链接文字大小
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconTextSize(size: Float64): LinkTheme {
        this.linkRectToolIconTextSize = size
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接控件高度
     *
     * @param height 空心圆角矩形图片格式链接控件高度
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconHeight(height: Float64): LinkTheme {
        this.linkRectToolIconHeight = height
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接左右内边距
     *
     * @param padding 空心圆角矩形图片格式链接左右内边距
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconPadding(padding: Float64): LinkTheme {
        this.linkRectToolIconPadding = padding
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接边框宽度
     *
     * @param width 空心圆角矩形图片格式链接边框宽度
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconBorderWidth(width: Float64): LinkTheme {
        this.linkRectToolIconBorderWidth = width
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接分割线宽度
     *
     * @param width 空心圆角矩形图片格式链接分割线宽度
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconDividingLineWidth(width: Float64): LinkTheme {
        this.linkRectToolIconDividingLineWidth = width
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接左右外边距
     *
     * @param margin 空心圆角矩形图片格式链接左右外边距
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconMargin(margin: Float64): LinkTheme {
        this.linkRectToolIconMargin = margin
        return this
    }

    /**
     * 设置空心圆角矩形图片格式分割线和文本左边距
     *
     * @param padding 空心圆角矩形图片格式分割线和文本左边距
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconLineLeftPadding(padding: Float64): LinkTheme {
        this.linkRectToolIconLineLeftPadding = padding
        return this
    }

    /**
     * 设置空心圆角矩形图片格式分割线和文本右边距
     *
     * @param padding 空心圆角矩形图片格式分割线和文本右边距
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconLineRightPadding(padding: Float64): LinkTheme {
        this.linkRectToolIconLineRightPadding = padding
        return this
    }
}