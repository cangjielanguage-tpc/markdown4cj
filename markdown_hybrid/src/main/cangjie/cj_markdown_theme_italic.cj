package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownItalicTheme {
    /**
     * 斜体文本颜色
     */
    var italicTextFontColor: ?Color = None

    /**
     * 斜体文本尺寸
     */
    var italicTextFontSize: ?Float64 = None

    /**
     * 斜体文本字体粗细
     */
    var italicTextFontWeight: ?FontWeight = None

    /**
     * 斜体文本字体
     */
    var italicTextFontFamily: ?String = None

    /**
     * 斜体文本行高
     */
    var italicTextLineHeight: ?Float64 = None

    /**
     * 斜体文本字符间距
     */
    var italicTextLetterSpacing: ?Float64 = None

    public init() {}

    /**
     * 设置斜体文本颜色
     *
     * @param color 文本颜色
     */
    public func setItalicTextFontColor(color: UInt32): Unit {
        italicTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置斜体文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setItalicTextFontSize(size: Float64): Unit {
        italicTextFontSize = size
    }

    /**
     * 设置斜体文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setItalicTextFontWeight(weight: String): Unit {
        italicTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置斜体文本字体
     *
     * @param family 文本字体
     */
    public func setItalicTextFontFamily(family: String): Unit {
        italicTextFontFamily = family
    }

    /**
     * 设置斜体文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setItalicTextLineHeight(lineHeight: Float64): Unit {
        italicTextLineHeight = lineHeight
    }

    /**
     * 设置斜体文本字符间距
     *
     * @param spacing 文本字符间距
     */
    public func setItalicTextLetterSpacing(spacing: Float64): Unit {
        italicTextLetterSpacing = spacing
    }
}
