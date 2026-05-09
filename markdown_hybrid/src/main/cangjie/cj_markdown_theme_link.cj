package markdown

import ohos.ark_interop_macro.*
import markdown.components.theme.MarkdownTextDecorationStyle

@Interop[ArkTS]
public class CJMarkdownLinkTheme {
    /**
     * 链接是否是图片显示
     */
    var linkIsIcon: ?Bool = None

    /**
     * 列表中的单行链接是否是图片显示
     */
    var linkListIsIcon: ?Bool = None

    /**
     * 链接文本颜色
     */
    var linkTextFontColor: ?Color = None

    /**
     * 链接文本尺寸
     */
    var linkTextFontSize: ?Float64 = None

    /**
     * 链接文本字体样式
     */
    var linkTextFontStyle: ?FontStyle = None

    /**
     * 链接文本字体粗细
     */
    var linkTextFontWeight: ?FontWeight = None

    /**
     * 链接文本字体
     */
    var linkTextFontFamily: ?String = None

    /**
     * 链接文本行高
     */
    var linkTextLineHeight: ?Float64 = None

    /**
     * 链接文本字符间距
     */
    var linkTextLetterSpacing: ?Float64 = None

    /**
     * 链接文本装饰线类型
     */
    var linkTextDecorationType: ?TextDecorationType = None

    /**
     * 链接文本装饰线颜色
     */
    var linkTextDecorationColor: ?Color = None

    /**
     * 链接文本装饰线样式
     */
    var linkTextDecorationStyle: ?MarkdownTextDecorationStyle = None

    /**
     * 链接文本背景颜色
     */
    var linkTextBackgroundColor: ?Color = None

    /**
     * 链接文本背景左上圆角
     */
    var linkTextBackgroundRadiusTopLeft: ?Float64 = None

    /**
     * 链接文本背景右上圆角
     */
    var linkTextBackgroundRadiusTopRight: ?Float64 = None

    /**
     * 链接文本背景左下圆角
     */
    var linkTextBackgroundRadiusBottomLeft: ?Float64 = None

    /**
     * 链接文本背景右下圆角
     */
    var linkTextBackgroundRadiusBottomRight: ?Float64 = None

    /**
     * 圆形图片格式链接主题背景颜色
     */
    var linkCircleIconBackgroundColor: ?Color = None

    /**
     * 圆形图片格式链接控件背景颜色
     */
    var linkCircleIconButtonBackgroundColor: ?Color = None

    /**
     * 圆形图片格式链接文字大小
     */
    var linkCircleIconTextSize: ?Float64 = None

    /**
     * 圆形图片格式链接文字颜色
     */
    var linkCircleIconTextColor: ?Color = None

    /**
     * 圆形图片格式链接半径
     */
    var linkCircleIconRadius: ?Float64 = None

    /**
     * 圆形图片格式链接左右外边距
     */
    var linkCircleIconMargin: ?Float64 = None

    /**
     * 圆角矩形图片格式链接主题背景颜色
     */
    var linkRectIconBackgroundColor: ?Color = None

    /**
     * 圆角矩形图片格式链接控件背景颜色
     */
    var linkRectIconButtonBackgroundColor: ?Color = None

    /**
     * 圆角矩形图片格式链接文字大小
     */
    var linkRectIconTextSize: ?Float64 = None

    /**
     * 圆角矩形图片格式链接文字颜色
     */
    var linkRectIconTextColor: ?Color = None

    /**
     * 圆角矩形图片格式链接控件高度
     */
    var linkRectIconHeight: ?Float64 = None

    /**
     * 圆角矩形图片格式链接左右内边距
     */
    var linkRectIconPadding: ?Float64 = None

    /**
     * 圆角矩形图片格式链接圆角半径
     */
    var linkRectIconRadius: ?Float64 = None

    /**
     * 圆角矩形图片格式链接左右外边距
     */
    var linkRectIconMargin: ?Float64 = None

    /**
     * 空心圆角矩形图片格式链接主题背景颜色
     */
    var linkRectToolIconBackgroundColor: ?Color = None

    /**
     * 空心圆角矩形图片格式链接控件背景颜色
     */
    var linkRectToolIconButtonBackgroundColor: ?Color = None

    /**
     * 空心圆角矩形图片格式链接文字大小
     */
    var linkRectToolIconTextSize: ?Float64 = None

    /**
     * 空心圆角矩形图片格式链接控件高度
     */
    var linkRectToolIconHeight: ?Float64 = None

    /**
     * 空心圆角矩形图片格式链接左右内边距
     */
    var linkRectToolIconPadding: ?Float64 = None

    /**
     * 空心圆角矩形图片格式链接边框宽度
     */
    var linkRectToolIconBorderWidth: ?Float64 = None

    /**
     * 空心圆角矩形图片格式链接分割线宽度
     */
    var linkRectToolIconDividingLineWidth: ?Float64 = None

    /**
     * 空心圆角矩形图片格式链接左右外边距
     */
    var linkRectToolIconMargin: ?Float64 = None

    /**
     * 空心圆角矩形图片格式分割线和文本左边距
     */
    var linkRectToolIconLineLeftPadding: ?Float64 = None

    /**
     * 空心圆角矩形图片格式分割线和文本右边距
     */
    var linkRectToolIconLineRightPadding: ?Float64 = None

    public init() {}

    /**
     * 设置链接是否是图片显示
     *
     * @param isIcon 链接是否是图片显示
     */
    public func setLinkIsIcon(isIcon: Bool): Unit {
        linkIsIcon = isIcon
    }

    /**
     * 设置列表中的单行链接是否是图片显示
     *
     * @param isIcon 列表中的单行链接是否是图片显示
     */
    public func setLinkListIsIcon(isIcon: Bool): Unit {
        linkListIsIcon = isIcon
    }

    /**
     * 设置链接文本颜色
     *
     * @param color 文本颜色
     */
    public func setLinkTextFontColor(color: UInt32): Unit {
        linkTextFontColor = transColorForTransparent(color)
    }

    /**
     * 设置链接文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setLinkTextFontSize(size: Float64): Unit {
        linkTextFontSize = size
    }

    /**
     * 设置链接文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setLinkTextFontStyle(style: Int64): Unit {
        linkTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置链接文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setLinkTextFontWeight(weight: Int64): Unit {
        linkTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置链接文本字体
     *
     * @param family 文本字体
     */
    public func setLinkTextFontFamily(family: String): Unit {
        linkTextFontFamily = family
    }

    /**
     * 设置链接文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setLinkTextLineHeight(lineHeight: Float64): Unit {
        linkTextLineHeight = lineHeight
    }

    /**
     * 设置链接文本字符间距
     *
     * @param spacing 文本字符间距
     */
    public func setLinkTextLetterSpacing(spacing: Float64): Unit {
        linkTextLetterSpacing = spacing
    }

    /**
     * 设置链接文本装饰线类型
     *
     * @param decorationType 装饰线类型
     */
    public func setLinkTextDecorationType(decorationType: Int64): Unit {
        linkTextDecorationType = convertTextDecorationType(decorationType)
    }

    /**
     * 设置链接文本装饰线颜色
     *
     * @param color 装饰线颜色
     */
    public func setLinkTextDecorationColor(color: UInt32): Unit {
        linkTextDecorationColor = transColorForTransparent(color)
    }

    /**
     * 设置链接文本装饰线样式
     *
     * @param style 装饰线样式
     */
    public func setLinkTextDecorationStyle(style: Int64): Unit {
        linkTextDecorationStyle = convertMarkdownTextDecorationStyle(style)
    }

    /**
     * 设置链接文本背景颜色
     *
     * @param color 背景颜色
     */
    public func setLinkTextBackgroundColor(color: UInt32): Unit {
        linkTextBackgroundColor = transColorForTransparent(color)
    }

    /**
     * 设置链接文本背景4个圆角为统一值
     *
     * @param radius 圆角
     */
    public func setLinkTextBackgroundAllRadius(radius: Float64): Unit {
        linkTextBackgroundRadiusTopLeft = radius
        linkTextBackgroundRadiusTopRight = radius
        linkTextBackgroundRadiusBottomLeft = radius
        linkTextBackgroundRadiusBottomRight = radius
    }

    /**
     * 分别设置链接文本背景4个圆角
     *
     * @param topLeft-左上圆角 命名参数
     * @param topRight-右上圆角 命名参数
     * @param bottomLeft-左下圆角 命名参数
     * @param bottomRight-右下圆角 命名参数
     */
    public func setLinkTextBackgroundRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        linkTextBackgroundRadiusTopLeft = topLeft
        linkTextBackgroundRadiusTopRight = topRight
        linkTextBackgroundRadiusBottomLeft = bottomLeft
        linkTextBackgroundRadiusBottomRight = bottomRight
    }

    /**
     * 设置圆形图片格式链接主题背景颜色
     *
     * @param color 圆形图片格式链接主题背景颜色
     */
    public func setLinkCircleIconBackgroundColor(color: UInt32): Unit {
        linkCircleIconBackgroundColor = transColorForTransparent(color)
    }

    /**
     * 设置圆形图片格式链接控件背景颜色
     *
     * @param color 圆形图片格式链接控件背景颜色
     */
    public func setLinkCircleIconButtonBackgroundColor(color: UInt32): Unit {
        linkCircleIconButtonBackgroundColor = transColorForTransparent(color)
    }

    /**
     * 设置圆形图片格式链接文字大小
     *
     * @param size 圆形图片格式链接文字大小
     */
    public func setLinkCircleIconTextSize(size: Float64): Unit {
        linkCircleIconTextSize = size
    }

    /**
     * 设置圆形图片格式链接文字颜色
     *
     * @param color 圆形图片格式链接文字颜色
     */
    public func setLinkCircleIconTextColor(color: UInt32): Unit {
        linkCircleIconTextColor = transColorForTransparent(color)
    }

    /**
     * 设置圆形图片格式链接半径
     *
     * @param radius 圆形图片格式链接半径
     */
    public func setLinkCircleIconRadius(radius: Float64): Unit {
        linkCircleIconRadius = radius
    }

    /**
     * 设置圆形图片格式链接左右外边距
     *
     * @param margin 圆形图片格式链接左右外边距
     */
    public func setLinkCircleIconMargin(margin: Float64): Unit {
        linkCircleIconMargin = margin
    }

    /**
     * 设置圆角矩形图片格式链接主题背景颜色
     *
     * @param color 圆角矩形图片格式链接主题背景颜色
     */
    public func setLinkRectIconBackgroundColor(color: UInt32): Unit {
        linkRectIconBackgroundColor = transColorForTransparent(color)
    }

    /**
     * 设置圆角矩形图片格式链接控件背景颜色
     *
     * @param color 圆角矩形图片格式链接控件背景颜色
     */
    public func setLinkRectIconButtonBackgroundColor(color: UInt32): Unit {
        linkRectIconButtonBackgroundColor = transColorForTransparent(color)
    }

    /**
     * 设置圆角矩形图片格式链接文字大小
     *
     * @param size 圆角矩形图片格式链接文字大小
     */
    public func setLinkRectIconTextSize(size: Float64): Unit {
        linkRectIconTextSize = size
    }

    /**
     * 设置圆角矩形图片格式链接文字颜色
     *
     * @param color 圆角矩形图片格式链接文字颜色
     */
    public func setLinkRectIconTextColor(color: UInt32): Unit {
        linkRectIconTextColor = transColorForTransparent(color)
    }

    /**
     * 设置圆角矩形图片格式链接控件高度
     *
     * @param height 圆角矩形图片格式链接控件高度
     */
    public func setLinkRectIconHeight(height: Float64): Unit {
        linkRectIconHeight = height
    }

    /**
     * 设置圆角矩形图片格式链接左右内边距
     *
     * @param padding 圆角矩形图片格式链接左右内边距
     */
    public func setLinkRectIconPadding(padding: Float64): Unit {
        linkRectIconPadding = padding
    }

    /**
     * 设置圆角矩形图片格式链接圆角半径
     *
     * @param radius 圆角矩形图片格式链接圆角半径
     */
    public func setLinkRectIconRadius(radius: Float64): Unit {
        linkRectIconRadius = radius
    }

    /**
     * 设置圆角矩形图片格式链接左右外边距
     *
     * @param margin 圆角矩形图片格式链接左右外边距
     */
    public func setLinkRectIconMargin(margin: Float64): Unit {
        linkRectIconMargin = margin
    }

    /**
     * 设置空心圆角矩形图片格式链接主题背景颜色
     *
     * @param color 空心圆角矩形图片格式链接主题背景颜色
     */
    public func setLinkRectToolIconBackgroundColor(color: UInt32): Unit {
        linkRectToolIconBackgroundColor = transColorForTransparent(color)
    }

    /**
     * 设置空心圆角矩形图片格式链接控件背景颜色
     *
     * @param color 空心圆角矩形图片格式链接控件背景颜色
     */
    public func setLinkRectToolIconButtonBackgroundColor(color: UInt32): Unit {
        linkRectToolIconButtonBackgroundColor = transColorForTransparent(color)
    }

    /**
     * 设置空心圆角矩形图片格式链接文字大小
     *
     * @param size 空心圆角矩形图片格式链接文字大小
     */
    public func setLinkRectToolIconTextSize(size: Float64): Unit {
        linkRectToolIconTextSize = size
    }

    /**
     * 设置空心圆角矩形图片格式链接控件高度
     *
     * @param height 空心圆角矩形图片格式链接控件高度
     */
    public func setLinkRectToolIconHeight(height: Float64): Unit {
        linkRectToolIconHeight = height
    }

    /**
     * 设置空心圆角矩形图片格式链接左右内边距
     *
     * @param padding 空心圆角矩形图片格式链接左右内边距
     */
    public func setLinkRectToolIconPadding(padding: Float64): Unit {
        linkRectToolIconPadding = padding
    }

    /**
     * 设置空心圆角矩形图片格式链接边框宽度
     *
     * @param width 空心圆角矩形图片格式链接边框宽度
     */
    public func setLinkRectToolIconBorderWidth(width: Float64): Unit {
        linkRectToolIconBorderWidth = width
    }

    /**
     * 设置空心圆角矩形图片格式链接分割线宽度
     *
     * @param width 空心圆角矩形图片格式链接分割线宽度
     */
    public func setLinkRectToolIconDividingLineWidth(width: Float64): Unit {
        linkRectToolIconDividingLineWidth = width
    }

    /**
     * 设置空心圆角矩形图片格式链接左右外边距
     *
     * @param margin 空心圆角矩形图片格式链接左右外边距
     */
    public func setLinkRectToolIconMargin(margin: Float64): Unit {
        linkRectToolIconMargin = margin
    }

    /**
     * 设置空心圆角矩形图片格式分割线和文本左边距
     *
     * @param padding 空心圆角矩形图片格式分割线和文本左边距
     */
    public func setLinkRectToolIconLineLeftPadding(padding: Float64): Unit {
        linkRectToolIconLineLeftPadding = padding
    }

    /**
     * 设置空心圆角矩形图片格式分割线和文本右边距
     *
     * @param padding 空心圆角矩形图片格式分割线和文本右边距
     */
    public func setLinkRectToolIconLineRightPadding(padding: Float64): Unit {
        linkRectToolIconLineRightPadding = padding
    }
}
