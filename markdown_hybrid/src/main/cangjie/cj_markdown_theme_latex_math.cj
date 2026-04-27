/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown

import ohos.ark_interop_macro.*
import markdown.components.theme.LatexMathColorFormat

@Interop[ArkTS]
public class CJMarkdownLatexMathTheme {
    /**
     * 块结构数学公式上外边距
     */
    var latexMathMarginTop: ?Float64 = None

    /**
     * 块结构数学公式右外边距
     */
    var latexMathMarginRight: ?Float64 = None

    /**
     * 块结构数学公式下外边距
     */
    var latexMathMarginBottom: ?Float64 = None

    /**
     * 块结构数学公式左外边距
     */
    var latexMathMarginLeft: ?Float64 = None

    /**
     * 块结构数学公式上内边距
     */
    var latexMathPaddingTop: ?Float64 = None

    /**
     * 块结构数学公式右内边距
     */
    var latexMathPaddingRight: ?Float64 = None

    /**
     * 块结构数学公式下内边距
     */
    var latexMathPaddingBottom: ?Float64 = None

    /**
     * 块结构数学公式左内边距
     */
    var latexMathPaddingLeft: ?Float64 = None

    /**
     * 数学公式未加载状态是否显示文字
     */
    var latexMathDefaultText: ?Bool = None

    /**
     * 数学公式未加载状态文本颜色
     */
    var latexMathDefaultTextFontColor: ?Color = None

    /**
     * 数学公式未加载状态文本尺寸
     */
    var latexMathDefaultTextFontSize: ?Float64 = None

    /**
     * 数学公式未加载状态文本字体样式
     */
    var latexMathDefaultTextFontStyle: ?FontStyle = None

    /**
     * 数学公式未加载状态文本字体粗细
     */
    var latexMathDefaultTextFontWeight: ?FontWeight = None

    /**
     * 数学公式未加载状态文本字体
     */
    var latexMathDefaultTextFontFamily: ?String = None

    /**
     * 数学公式文本大小
     */
    var latexMathTextSize: ?Float64 = None

    /**
     * 数学公式背景颜色
     */
    var latexMathBackgroundColor: ?Color = None

    /**
     * 数学公式文本颜色
     */
    var latexMathTextColor: ?Color = None

    /**
     * 数学公式生成图片格式
     */
    var latexMathColorFormat: ?LatexMathColorFormat = None

    /**
     * 块结构的数学公式是否居中
     */
    var latexMathBlockCenter: ?Bool = None

    /**
     * 数学公式资源路径
     */
    var latexMathResPath: ?String = None

    public init() {}

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     */
    public func setLatexMathAllMargin(margin: Float64): Unit {
        latexMathMarginTop = margin
        latexMathMarginRight = margin
        latexMathMarginBottom = margin
        latexMathMarginLeft = margin
    }

    /**
     * 分别设置4个外边距
     *
     * @param top-上外边距 命名参数
     * @param right-右外边距 命名参数
     * @param bottom-下外边距 命名参数
     * @param left-左外边距 命名参数
     */
    public func setLatexMathMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        latexMathMarginTop = top
        latexMathMarginRight = right
        latexMathMarginBottom = bottom
        latexMathMarginLeft = left
    }

    /**
     * 设置4个内边距为统一值
     *
     * @param padding 内边距
     */
    public func setLatexMathAllPadding(padding: Float64): Unit {
        latexMathPaddingTop = padding
        latexMathPaddingRight = padding
        latexMathPaddingBottom = padding
        latexMathPaddingLeft = padding
    }

    /**
     * 分别设置4个内边距  separately
     *
     * @param top-上内边距 命名参数
     * @param right-右内边距 命名参数
     * @param bottom-下内边距 命名参数
     * @param left-左内边距 命名参数
     */
    public func setLatexMathPadding(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        latexMathPaddingTop = top
        latexMathPaddingRight = right
        latexMathPaddingBottom = bottom
        latexMathPaddingLeft = left
    }

    /**
     * 设置数学公式未加载状态是否显示文字
     *
     * @param defaultText 是否显示文字
     */
    public func setLatexMathDefaultText(defaultText: Bool): Unit {
        latexMathDefaultText = defaultText
    }

    /**
     * 设置数学公式未加载状态文本颜色
     *
     * @param color 文本颜色
     */
    public func setLatexMathDefaultTextFontColor(color: UInt32): Unit {
        latexMathDefaultTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置数学公式未加载状态文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setLatexMathDefaultTextFontSize(size: Float64): Unit {
        latexMathDefaultTextFontSize = size
    }

    /**
     * 设置数学公式未加载状态文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setLatexMathDefaultTextFontStyle(style: Int64): Unit {
        latexMathDefaultTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置数学公式未加载状态文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setLatexMathDefaultTextFontWeight(weight: String): Unit {
        latexMathDefaultTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置数学公式未加载状态文本字体
     *
     * @param family 文本字体
     */
    public func setLatexMathDefaultTextFontFamily(family: String): Unit {
        latexMathDefaultTextFontFamily = family
    }

    /**
     * 设置数学公式文本大小
     *
     * @param size 文本大小
     */
    public func setLatexMathTextSize(size: Float64): Unit {
        latexMathTextSize = size
    }

    /**
     * 设置数学公式背景颜色
     *
     * @param color 背景颜色
     */
    public func setLatexMathBackgroundColor(color: UInt32): Unit {
        latexMathBackgroundColor = transColorForTrasparent(color)
    }

    /**
     * 设置数学公式文本颜色
     *
     * @param color 文本颜色
     */
    public func setLatexMathTextColor(color: UInt32): Unit {
        latexMathTextColor = transColorForTrasparent(color)
    }

    /**
     * 设置数学公式生成图片格式
     *
     * @param latexMathColorFormat 数学公式生成图片格式 - 默认LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
     */
    public func setLatexMathColorFormat(colorFormat: Int64): Unit {
        match (colorFormat) {
            case 0 => latexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_RGB_565
            case 1 => latexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
            case _ => latexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_RGB_565
        }
    }

    /**
     * 设置块结构的数学公式是否居中
     *
     * @param center 是否居中
     */
    public func setLatexMathBlockCenter(center: Bool): Unit {
        latexMathBlockCenter = center
    }

    /**
     * 设置数学公式资源路径
     *
     * @param path 资源路径
     */
    public func setLatexMathResPath(path: String): Unit {
        latexMathResPath = path
    }
}
