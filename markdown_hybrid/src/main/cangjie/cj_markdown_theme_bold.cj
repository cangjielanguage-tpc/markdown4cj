package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownBoldTheme {
    /**
     * 加粗文本颜色
     */
    var boldTextFontColor: ?Color = None

    /**
     * 加粗文本尺寸
     */
    var boldTextFontSize: ?Float64 = None

    /**
     * 加粗文本字体样式
     */
    var boldTextFontStyle: ?FontStyle = None

    /**
     * 加粗文本字体粗细
     */
    var boldTextFontWeight: ?FontWeight = None

    /**
     * 加粗文本字体
     */
    var boldTextFontFamily: ?String = None

    /**
     * 加粗文本行高
     */
    var boldTextLineHeight: ?Float64 = None

    /**
     * 加粗文本字符间距
     */
    var boldTextLetterSpacing: ?Float64 = None

    public init() {}

    /**
     * 设置加粗文本颜色
     *
     * @param color 文本颜色
     */
    public func setBoldTextFontColor(color: UInt32): Unit {
        boldTextFontColor = transColorForTransparent(color)
    }

    /**
     * 设置加粗文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setBoldTextFontSize(size: Float64): Unit {
        boldTextFontSize = size
    }

    /**
     * 设置加粗文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setBoldTextFontStyle(style: Int64): Unit {
        boldTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置加粗文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setBoldTextFontWeight(weight: Int64): Unit {
        boldTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置加粗文本字体
     *
     * @param family 文本字体
     */
    public func setBoldTextFontFamily(family: String): Unit {
        boldTextFontFamily = family
    }

    /**
     * 设置加粗文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setBoldTextLineHeight(lineHeight: Float64): Unit {
        boldTextLineHeight = lineHeight
    }

    /**
     * 设置加粗文本字符间距
     *
     * @param spacing 文本字符间距
     */
    public func setBoldTextLetterSpacing(spacing: Float64): Unit {
        boldTextLetterSpacing = spacing
    }
}
