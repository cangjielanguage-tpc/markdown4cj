/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown

import ohos.ark_interop_macro.*
import markdown.components.theme.MarkdownTextDecorationStyle

@Interop[ArkTS]
public class CJMarkdownHtmlUnderlineTheme {
    /**
     * HTML下划线文本颜色
     */
    var htmlUnderlineTextFontColor: ?Color = None

    /**
     * HTML下划线文本尺寸
     */
    var htmlUnderlineTextFontSize: ?Float64 = None

    /**
     * HTML下划线文本字体样式
     */
    var htmlUnderlineTextFontStyle: ?FontStyle = None

    /**
     * HTML下划线文本字体粗细
     */
    var htmlUnderlineTextFontWeight: ?FontWeight = None

    /**
     * HTML下划线文本字体
     */
    var htmlUnderlineTextFontFamily: ?String = None

    /**
     * HTML下划线文本行高
     */
    var htmlUnderlineTextLineHeight: ?Float64 = None

    /**
     * HTML下划线文本字符间距
     */
    var htmlUnderlineTextLetterSpacing: ?Float64 = None

    /**
     * HTML下划线文本装饰线颜色
     */
    var htmlUnderlineTextDecorationColor: ?Color = None

    /**
     * HTML下划线文本装饰线样式
     */
    var htmlUnderlineTextDecorationStyle: ?MarkdownTextDecorationStyle = None

    public init() {}

    /**
     * 设置HTML下划线文本颜色
     *
     * @param color 文本颜色
     */
    public func setHtmlUnderlineTextFontColor(color: UInt32): Unit {
        htmlUnderlineTextFontColor = transColorForTrasparent(color)
    }

    /**
     * 设置HTML下划线文本尺寸
     *
     * @param size 文本尺寸
     */
    public func setHtmlUnderlineTextFontSize(size: Float64): Unit {
        htmlUnderlineTextFontSize = size
    }

    /**
     * 设置HTML下划线文本字体样式
     *
     * @param style 文本字体样式
     */
    public func setHtmlUnderlineTextFontStyle(style: Int64): Unit {
        htmlUnderlineTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置HTML下划线文本字体粗细
     *
     * @param weight 文本字体粗细
     */
    public func setHtmlUnderlineTextFontWeight(weight: String): Unit {
        htmlUnderlineTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置HTML下划线文本字体
     *
     * @param family 文本字体
     */
    public func setHtmlUnderlineTextFontFamily(family: String): Unit {
        htmlUnderlineTextFontFamily = family
    }

    /**
     * 设置HTML下划线文本行高
     *
     * @param lineHeight 文本行高
     */
    public func setHtmlUnderlineTextLineHeight(lineHeight: Float64): Unit {
        htmlUnderlineTextLineHeight = lineHeight
    }

    /**
     * 设置HTML下划线文本字符间距
     *
     * @param spacing 文本字符间距
     */
    public func setHtmlUnderlineTextLetterSpacing(spacing: Float64): Unit {
        htmlUnderlineTextLetterSpacing = spacing
    }

    /**
     * 设置HTML下划线文本装饰线颜色
     *
     * @param color 装饰线颜色
     */
    public func setHtmlUnderlineTextDecorationColor(color: UInt32): Unit {
        htmlUnderlineTextDecorationColor = transColorForTrasparent(color)
    }

    /**
     * 设置HTML下划线文本装饰线样式
     *
     * @param style 装饰线样式
     */
    public func setHtmlUnderlineTextDecorationStyle(style: Int64): Unit {
        htmlUnderlineTextDecorationStyle = convertMarkdownTextDecorationStyle(style)
    }
}
