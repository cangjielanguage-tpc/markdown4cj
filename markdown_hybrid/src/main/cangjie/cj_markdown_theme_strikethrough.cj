package markdown

import ohos.ark_interop_macro.*
import markdown.components.theme.MarkdownTextDecorationStyle

@Interop[ArkTS]
public class CJMarkdownStrikethroughTheme {
    /**
     * 删除线文本颜色
     */
    var strikethroughTextFontColor: ?Color = None

    /**
     * 删除线文本尺寸
     */
    var strikethroughTextFontSize: ?Float64 = None

    /**
     * 删除线文本字体样式
     */
    var strikethroughTextFontStyle: ?FontStyle = None

    /**
     * 删除线文本字体粗细
     */
    var strikethroughTextFontWeight: ?FontWeight = None

    /**
     * 删除线文本字体
     */
    var strikethroughTextFontFamily: ?String = None

    /**
     * 删除线文本行高
     */
    var strikethroughTextLineHeight: ?Float64 = None

    /**
     * 删除线文本字符间距
     */
    var strikethroughTextLetterSpacing: ?Float64 = None

    /**
     * 删除线文本装饰线颜色
     */
    var strikethroughTextDecorationColor: ?Color = None

    /**
     * 删除线文本装饰线样式
     */
    var strikethroughTextDecorationStyle: ?MarkdownTextDecorationStyle = None

    public init() {}

    /**
     * 设置删除线文本颜色
     *
     * @param color 文本颜色
     */
    public func setStrikethroughTextFontColor(color: UInt32): Unit {
        strikethroughTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置删除线文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setStrikethroughTextFontSize(size: Float64): Unit {
        strikethroughTextFontSize = size
    }

    /**
     * 设置删除线文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setStrikethroughTextFontStyle(style: Int64): Unit {
        strikethroughTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置删除线文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setStrikethroughTextFontWeight(weight: Int64): Unit {
        strikethroughTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置删除线文本字体
     *
     * @param family 文本字体
     */
    public func setStrikethroughTextFontFamily(family: String): Unit {
        strikethroughTextFontFamily = family
    }

    /**
     * 设置删除线文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setStrikethroughTextLineHeight(lineHeight: Float64): Unit {
        strikethroughTextLineHeight = lineHeight
    }

    /**
     * 设置删除线文本字符间距
     *
     * @param spacing 文本字符间距
     */
    public func setStrikethroughTextLetterSpacing(spacing: Float64): Unit {
        strikethroughTextLetterSpacing = spacing
    }

    /**
     * 设置删除线文本装饰线颜色
     *
     * @param color 装饰线颜色
     */
    public func setStrikethroughTextDecorationColor(color: UInt32): Unit {
        strikethroughTextDecorationColor = transColorForTrasparent(color)
    }

    /**
     * 设置删除线文本装饰线样式
     *
     * @param style 装饰线样式
     */
    public func setStrikethroughTextDecorationStyle(style: Int64): Unit {
        strikethroughTextDecorationStyle = convertMarkdownTextDecorationStyle(style)
    }
}
