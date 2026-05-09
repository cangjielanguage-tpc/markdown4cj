package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownSubTheme {
    /**
     * 下标文本颜色
     */
    var subTextFontColor: ?Color = None

    /**
     * 下标文本尺寸
     */
    var subTextFontSize: ?Float64 = None

    /**
     * 下标文本字体样式
     */
    var subTextFontStyle: ?FontStyle = None

    /**
     * 下标文本字体粗细
     */
    var subTextFontWeight: ?FontWeight = None

    /**
     * 下标文本字体
     */
    var subTextFontFamily: ?String = None

    /**
     * 下标文本字符间距
     */
    var subTextLetterSpacing: ?Float64 = None

    /**
     * 下标文本基线的偏移量
     */
    var subTextBaselineOffset: ?Float64 = None

    public init() {}

    /**
     * 设置下标文本颜色
     *
     * @param color 文本颜色
     */
    public func setSubTextFontColor(color: UInt32): Unit {
        subTextFontColor = transColorForTransparent(color)
    }

    /**
     * 设置下标文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setSubTextFontSize(size: Float64): Unit {
        subTextFontSize = size
    }

    /**
     * 设置下标文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setSubTextFontStyle(style: Int64): Unit {
        subTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置下标文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setSubTextFontWeight(weight: Int64): Unit {
        subTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置下标文本字体
     *
     * @param family 文本字体
     */
    public func setSubTextFontFamily(family: String): Unit {
        subTextFontFamily = family
    }

    /**
     * 设置下标文本字符间距
     *
     * @param spacing 文本字符间距
     */
    public func setSubTextLetterSpacing(spacing: Float64): Unit {
        subTextLetterSpacing = spacing
    }

    /**
     * 设置下标文本基线的偏移量
     *
     * @param offset 基线偏移量
     */
    public func setSubTextBaselineOffset(offset: Float64): Unit {
        subTextBaselineOffset = offset
    }
}
