package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownSupTheme {
    /**
     * 上标文本颜色
     */
    var supTextFontColor: ?Color = None

    /**
     * 上标文本尺寸
     */
    var supTextFontSize: ?Float64 = None

    /**
     * 上标文本字体样式
     */
    var supTextFontStyle: ?FontStyle = None

    /**
     * 上标文本字体粗细
     */
    var supTextFontWeight: ?FontWeight = None

    /**
     * 上标文本字体
     */
    var supTextFontFamily: ?String = None

    /**
     * 上标文本字符间距
     */
    var supTextLetterSpacing: ?Float64 = None

    /**
     * 上标文本基线的偏移量
     */
    var supTextBaselineOffset: ?Float64 = None

    public init() {}

    /**
     * 设置上标文本颜色
     *
     * @param color 文本颜色
     */
    public func setSupTextFontColor(color: UInt32): Unit {
        supTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置上标文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setSupTextFontSize(size: Float64): Unit {
        supTextFontSize = size
    }

    /**
     * 设置上标文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setSupTextFontStyle(style: Int64): Unit {
        supTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置上标文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setSupTextFontWeight(weight: String): Unit {
        supTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置上标文本字体
     *
     * @param family 文本字体
     */
    public func setSupTextFontFamily(family: String): Unit {
        supTextFontFamily = family
    }

    /**
     * 设置上标文本字符间距
     *
     * @param spacing 文本字符间距
     */
    public func setSupTextLetterSpacing(spacing: Float64): Unit {
        supTextLetterSpacing = spacing
    }

    /**
     * 设置上标文本基线的偏移量
     *
     * @param offset 基线偏移量
     */
    public func setSupTextBaselineOffset(offset: Float64): Unit {
        supTextBaselineOffset = offset
    }
}
