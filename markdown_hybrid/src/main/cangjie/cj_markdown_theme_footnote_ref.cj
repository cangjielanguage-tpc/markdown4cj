package markdown

import ohos.ark_interop_macro.*
import markdown.components.theme.MarkdownTextDecorationStyle

@Interop[ArkTS]
public class CJMarkdownFootnoteRefTheme {
    /**
     * 脚注引用文本颜色
     */
    var footnoteRefTextFontColor: ?Color = None

    /**
     * 脚注引用文本尺寸
     */
    var footnoteRefTextFontSize: ?Float64 = None

    /**
     * 脚注引用文本字体样式
     */
    var footnoteRefTextFontStyle: ?FontStyle = None

    /**
     * 脚注引用文本字体粗细
     */
    var footnoteRefTextFontWeight: ?FontWeight = None

    /**
     * 脚注引用文本字体
     */
    var footnoteRefTextFontFamily: ?String = None

    /**
     * 脚注引用文本行高
     */
    var footnoteRefTextLineHeight: ?Float64 = None

    /**
     * 脚注引用文本字符间距
     */
    var footnoteRefTextLetterSpacing: ?Float64 = None

    /**
     * 脚注引用文本背景颜色
     */
    var footnoteRefTextBackgroundColor: ?Color = None

    /**
     * 脚注引用文本装饰线类型
     */
    var footnoteRefTextDecorationType: ?TextDecorationType = None

    /**
     * 脚注引用文本装饰线颜色
     */
    var footnoteRefTextDecorationColor: ?Color = None

    /**
     * 脚注引用文本装饰线样式
     */
    var footnoteRefTextDecorationStyle: ?MarkdownTextDecorationStyle = None

    /**
     * 脚注引用文本背景左上圆角
     */
    var footnoteRefTextBackgroundRadiusTopLeft: ?Float64 = None

    /**
     * 脚注引用文本背景右上圆角
     */
    var footnoteRefTextBackgroundRadiusTopRight: ?Float64 = None

    /**
     * 脚注引用文本背景左下圆角
     */
    var footnoteRefTextBackgroundRadiusBottomLeft: ?Float64 = None

    /**
     * 脚注引用文本背景右下圆角
     */
    var footnoteRefTextBackgroundRadiusBottomRight: ?Float64 = None

    public init() {}

    /**
     * 设置脚注引用文本颜色
     *
     * @param color 文本颜色
     */
    public func setFootnoteRefTextFontColor(color: UInt32): Unit {
        footnoteRefTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置脚注引用文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setFootnoteRefTextFontSize(size: Float64): Unit {
        footnoteRefTextFontSize = size
    }

    /**
     * 设置脚注引用文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setFootnoteRefTextFontStyle(style: Int64): Unit {
        footnoteRefTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置脚注引用文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setFootnoteRefTextFontWeight(weight: String): Unit {
        footnoteRefTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置脚注引用文本字体
     *
     * @param family 文本字体
     */
    public func setFootnoteRefTextFontFamily(family: String): Unit {
        footnoteRefTextFontFamily = family
    }

    /**
     * 设置脚注引用文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setFootnoteRefTextLineHeight(lineHeight: Float64): Unit {
        footnoteRefTextLineHeight = lineHeight
    }

    /**
     * 设置脚注引用文本字符间距
     *
     * @param spacing 文本字符间距
     */
    public func setFootnoteRefTextLetterSpacing(spacing: Float64): Unit {
        footnoteRefTextLetterSpacing = spacing
    }

    /**
     * 设置脚注引用文本背景颜色
     *
     * @param color 背景颜色
     */
    public func setFootnoteRefTextBackgroundColor(color: UInt32): Unit {
        footnoteRefTextBackgroundColor = transColorForTrasparent(color)
    }

    /**
     * 设置脚注引用文本装饰线类型
     *
     * @param decorationType 装饰线类型
     */
    public func setFootnoteRefTextDecorationType(decorationType: Int64): Unit {
        footnoteRefTextDecorationType = convertTextDecorationType(decorationType)
    }

    /**
     * 设置脚注引用文本装饰线颜色
     *
     * @param color 装饰线颜色
     */
    public func setFootnoteRefTextDecorationColor(color: UInt32): Unit {
        footnoteRefTextDecorationColor = transColorForTrasparent(color)
    }

    /**
     * 设置脚注引用文本装饰线样式
     *
     * @param style 装饰线样式
     */
    public func setFootnoteRefTextDecorationStyle(style: Int64): Unit {
        footnoteRefTextDecorationStyle = convertMarkdownTextDecorationStyle(style)
    }

    /**
     * 设置脚注引用文本背景4个圆角为统一值
     *
     * @param radius 圆角
     */
    public func setFootnoteRefTextBackgroundAllRadius(radius: Float64): Unit {
        footnoteRefTextBackgroundRadiusTopLeft = radius
        footnoteRefTextBackgroundRadiusTopRight = radius
        footnoteRefTextBackgroundRadiusBottomLeft = radius
        footnoteRefTextBackgroundRadiusBottomRight = radius
    }

    /**
     * 分别设置脚注引用文本背景4个圆角
     *
     * @param topLeft-左上圆角 命名参数
     * @param topRight-右上圆角 命名参数
     * @param bottomLeft-左下圆角 命名参数
     * @param bottomRight-右下圆角 命名参数
     */
    public func setFootnoteRefTextBackgroundRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        footnoteRefTextBackgroundRadiusTopLeft = topLeft
        footnoteRefTextBackgroundRadiusTopRight = topRight
        footnoteRefTextBackgroundRadiusBottomLeft = bottomLeft
        footnoteRefTextBackgroundRadiusBottomRight = bottomRight
    }
}
