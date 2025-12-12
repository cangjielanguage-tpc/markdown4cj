/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 标题文本
 */
@Builder
func headingTextComponent18(nodeView: NodeView, markdownConfiguration: MarkdownConfiguration, level: Int64) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, true, level))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, true))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownConfiguration.markdownTheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 标题文本
 */
@Builder
func headingTextComponent19(nodeView: NodeView, markdownConfiguration: MarkdownConfiguration, level: Int64) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, true, level))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, true))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownConfiguration.markdownTheme)))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 标题链接文本
 */
@Builder
func headingLinkComponent18(nodeView: NodeView, link: String, markdownConfiguration: MarkdownConfiguration, level: Int64) {
    // 设置文本内容
    Span(link)
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, true, level))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, true))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownConfiguration.markdownTheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 标题链接文本
 */
@Builder
func headingLinkComponent19(nodeView: NodeView, link: String, markdownConfiguration: MarkdownConfiguration, level: Int64) {
    // 设置文本内容
    Span(link)
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, true, level))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, true))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, true, markdownConfiguration.markdownTheme)))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 标题内联代码
 */
@Builder
func headingCodeComponent18(nodeView: NodeView, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownConfiguration.markdownTheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownConfiguration.markdownTheme, true, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownConfiguration.markdownTheme, true))
        // 自定义背景色
        .interopStyle(true, markdownConfiguration.markdownTheme.codeBackgroundColor)
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 标题内联代码
 */
@Builder
func headingCodeComponent19(nodeView: NodeView, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownConfiguration.markdownTheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownConfiguration.markdownTheme, true, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownConfiguration.markdownTheme, true))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(true, false, markdownConfiguration.markdownTheme)))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 标题脚注文本
 */
@Builder
func headingFootnoteComponent18(nodeView: NodeView, markdownConfiguration: MarkdownConfiguration, level: Int64, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, true, level))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, true))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownConfiguration.markdownTheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.node is Footnote) {
                fontCallback((nodeView.node as Footnote)().noteid)
            }
        }
}

/**
 * 标题脚注文本
 */
@Builder
func headingFootnoteComponent19(nodeView: NodeView, markdownConfiguration: MarkdownConfiguration, level: Int64, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, true, level))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, true))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownConfiguration.markdownTheme)))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.node is Footnote) {
                fontCallback((nodeView.node as Footnote)().noteid)
            }
        }
}

/**
 * 段落文本
 */
@Builder
func paragraphTextComponent18(nodeView: NodeView, isDescList: Bool, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isDescList, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, isDescList))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownConfiguration.markdownTheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 段落文本
 */
@Builder
func paragraphTextComponent19(nodeView: NodeView, isDescList: Bool, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isDescList, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, isDescList))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownConfiguration.markdownTheme)))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 段落Toc文本
 */
@Builder
func paragraphTocComponent18(nodeView: NodeView, isDescList: Bool, markdownConfiguration: MarkdownConfiguration, tocListOnClick: (Int64) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isDescList, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, isDescList))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownConfiguration.markdownTheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => tocListOnClick((nodeView.node as HeadLink)().headIndex)}
}

/**
 * 段落Toc文本
 */
@Builder
func paragraphTocComponent19(nodeView: NodeView, isDescList: Bool, markdownConfiguration: MarkdownConfiguration, tocListOnClick: (Int64) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isDescList, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, isDescList))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownConfiguration.markdownTheme)))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => tocListOnClick((nodeView.node as HeadLink)().headIndex)}
}

/**
 * 段落链接文本
 */
@Builder
func paragraphLinkComponent18(nodeView: NodeView, isDescList: Bool, link: String, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(link)
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isDescList, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, isDescList))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownConfiguration.markdownTheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 段落链接文本
 */
@Builder
func paragraphLinkComponent19(nodeView: NodeView, isDescList: Bool, link: String, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(link)
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isDescList, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, isDescList))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, true, markdownConfiguration.markdownTheme)))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 段落内联代码
 */
@Builder
func paragraphCodeComponent18(nodeView: NodeView, isDescList: Bool, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isDescList, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, isDescList))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownConfiguration.markdownTheme, false))
        // 自定义背景色
        .interopStyle(true, markdownConfiguration.markdownTheme.codeBackgroundColor)
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 段落内联代码
 */
@Builder
func paragraphCodeComponent19(nodeView: NodeView, isDescList: Bool, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isDescList, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, isDescList))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownConfiguration.markdownTheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(true, false, markdownConfiguration.markdownTheme)))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 段落脚注文本
 */
@Builder
func paragraphFootnoteComponent18(nodeView: NodeView, isDescList: Bool, markdownConfiguration: MarkdownConfiguration, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isDescList, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, isDescList))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownConfiguration.markdownTheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.node is Footnote) {
                fontCallback((nodeView.node as Footnote)().noteid)
            }
        }
}

/**
 * 段落脚注文本
 */
@Builder
func paragraphFootnoteComponent19(nodeView: NodeView, isDescList: Bool, markdownConfiguration: MarkdownConfiguration, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isDescList, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, isDescList))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownConfiguration.markdownTheme)))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.node is Footnote) {
                fontCallback((nodeView.node as Footnote)().noteid)
            }
        }
}

/**
 * 表格文本
 */
@Builder
func tableComponentText18(nodeView: NodeView, isHeader: Bool, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownConfiguration.markdownTheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 表格文本
 */
@Builder
func tableComponentText19(nodeView: NodeView, isHeader: Bool, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownConfiguration.markdownTheme)))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 表格内联代码
 */
@Builder
func tableComponentCode18(nodeView: NodeView, isHeader: Bool, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownConfiguration.markdownTheme, false))
        // 自定义背景色
        .interopStyle(true, markdownConfiguration.markdownTheme.codeBackgroundColor)
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 表格内联代码
 */
@Builder
func tableComponentCode19(nodeView: NodeView, isHeader: Bool, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownConfiguration.markdownTheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(true, false, markdownConfiguration.markdownTheme)))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 表格链接文本
 */
@Builder
func tableLinkComponent18(nodeView: NodeView, isHeader: Bool, link: String, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(link)
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownConfiguration.markdownTheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 表格链接文本
 */
@Builder
func tableLinkComponent19(nodeView: NodeView, isHeader: Bool, link: String, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(link)
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownConfiguration.markdownTheme)))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 表格脚注文本
 */
@Builder
func tableComponentFootnote18(nodeView: NodeView, isHeader: Bool, markdownConfiguration: MarkdownConfiguration, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownConfiguration.markdownTheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.node is Footnote) {
                fontCallback((nodeView.node as Footnote)().noteid)
            }
        }
}

/**
 * 表格脚注文本
 */
@Builder
func tableComponentFootnote19(nodeView: NodeView, isHeader: Bool, markdownConfiguration: MarkdownConfiguration, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView, false))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownConfiguration.markdownTheme)))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.node is Footnote) {
                fontCallback((nodeView.node as Footnote)().noteid)
            }
        }
}

/**
 * 无序列表和有序列表的前缀文本
 */
@Builder
func listPrefixTextINCComponent(item: NodeView, isBullet: Bool, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Text(listPrefixStr(item, isBullet, markdownConfiguration))
        // 设置文本颜色
        .fontColor(listPrefixColor(markdownConfiguration.markdownTheme, isBullet))
        // 设置文本尺寸
        .fontSize(listPrefixSize(markdownConfiguration.markdownTheme, isBullet))
        // 设置内边距属性
        .padding(left: markdownConfiguration.markdownTheme.blockLeftMargin, right: markdownConfiguration.markdownTheme.blockRightMargin)
        // 设置行高
        .lineHeight(listPrefixLineHeight(isBullet, markdownConfiguration))
        // 设置文本段落在水平方向的对齐方式
        .textAlign(TextAlign.Center)
        // 设置文本的字体粗细
        .fontWeight(isFontWeight(markdownConfiguration.markdownTheme.orderedListItemPrefixBold))
        // 块内容前的起始边距
        .margin(top: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
}

/**
 * 任务列表的前缀多选框
 */
@Builder
func listPrefixCheckboxINCComponent(item: NodeView, markdownConfiguration: MarkdownConfiguration) {
    Checkbox()
        // 设置组件自身的高度
        .height(markdownConfiguration.markdownTheme.taskListItemLength)
        // 设置组件自身的宽度
        .width(markdownConfiguration.markdownTheme.taskListItemLength)
        // 设置按钮形状样式
        .select(taskSelect(item))
        // 值为 true 表示组件可用，可响应点击等操作；值为 false 时，不响应点击等操作
        .enabled(false)
        // 切换CheckBox组件形状
        .shape(CheckBoxShape.ROUNDED_SQUARE)
        // 设置外边距属性
        .margin(left: markdownConfiguration.markdownTheme.blockLeftMargin, right: markdownConfiguration.markdownTheme.blockRightMargin, top: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
}

/**
 *
 */
@Builder
func codeBlockTextComponent(str: String, markdownConfiguration: MarkdownConfiguration) {
    Row() {
        Text(str)
            // 设置字体颜色
            .fontColor(indentedCodeodeBlockTypeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
            // 设置字体大小
            .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
            // 设置文本的最大行数
            .maxLines(1)
            // 设置文本超长时的显示方式
            .textOverflow(TextOverflow.Ellipsis)
            // 设置外边距
            .margin(left: 8)
    }
    // 设置宽度
    .width(30.percent)
    // 设置子组件在水平方向上的对齐格式
    .justifyContent(FlexAlign.Start)
}

/**
 * 图片占位图
 */
@Builder
func imagePlaceholderComponent(imageResource: AppResource, imageMarginTop: Float64, imageMarginBottom: Float64, imageFixedRatioWidth: Option<Float64>, imageMaximumWidth: Float64, imageBorderRadius: Float64, componentImageWidth: Float64) {
    // 有占位图
    ImageSpan(imageResource)
        // 设置外边距属性
        .margin(top: imageMarginTop, bottom: imageMarginBottom)
        // 自定义图片圆角
        .interopBorderRadius(imageBorderRadius)
        // 设置组件自身的宽度
        .width(if (imageFixedRatioWidth.isSome()) {
            (componentImageWidth * imageFixedRatioWidth()).px
        } else {
            (componentImageWidth * imageMaximumWidth).px
        })
        // 设置组件自身的高度
        .height(if (imageFixedRatioWidth.isSome()) {
            (componentImageWidth * 9.0 / 16.0 * imageFixedRatioWidth()).px
        } else {
            (componentImageWidth * 9.0 / 16.0 * imageMaximumWidth).px
        })
        // 设置图片的缩放类型
        .objectFit(ImageFit.Cover)
        // 设置图片基于文本的对齐方式
        .verticalAlign(ImageSpanAlignment.CENTER)
        // 设置约束尺寸，组件布局时，进行尺寸范围限制
        .constraintSize(maxWidth: 100.percent)
}

/**
 * 图片替换图片
 */
@Builder
func imageCallBackComponent(imagePixelMap: PixelMap, imageMarginTop: Float64, imageMarginBottom: Float64, imageBorderRadius: Float64, imageFixedRatioWidth: Option<Float64>, componentImageWidth: Float64, imageWidth: Float64, imageHeight: Float64, imageMaximumWidth: Float64, markdownConfiguration: MarkdownConfiguration, isLink: Bool, imageCallback: (String) -> Unit, linkCallback: ?(String) -> Unit, linkUrl: ?String, destination: String) {
    ImageSpan(imagePixelMap)
        // 设置外边距属性
        .margin(top: imageMarginTop, bottom: imageMarginBottom)
        // 自定义图片圆角
        .interopBorderRadius(imageBorderRadius)
        // 设置组件自身的宽度
        .width(imageSpanWidth(imageFixedRatioWidth, componentImageWidth, imageWidth, imageMaximumWidth))
        // 设置组件自身的高度
        .height(imageSpanHeight(imageFixedRatioWidth, componentImageWidth, imageWidth, imageHeight, imageMaximumWidth))
        // 设置图片的缩放类型
        .objectFit(markdownConfiguration.markdownTheme.imageFitType)
        // 设置图片基于文本的对齐方式
        .verticalAlign(ImageSpanAlignment.CENTER)
        // 点击动作触发该方法调用
        .onClick {evt => imageSpanOnClick(isLink, imageCallback, linkCallback, linkUrl, destination)}
}

/**
 * html图片
 */
@Builder
func htmlImageSpanComponent(item: NodeView, markdownConfiguration: MarkdownConfiguration, componentWidth: Float64, imageCallback: (String) -> Unit) {
    if (DeviceInfo.sdkApiVersion >= 15) {
        MarkdownImgHtml15Component(
            markdownConfigurationHtml15: markdownConfiguration,
            destinationHtml15: (item.node as ImageHtmlNode)().getDestination(),
            componentWidthHtml15: componentWidth,
            imageWidthHtml15: strToFloat64((item.node as ImageHtmlNode)().getWidth()),
            imageHeightHtml15: strToFloat64((item.node as ImageHtmlNode)().getHeight()),
            imageCallbackHtml15: imageCallback,
            linkCallbackHtml15: markdownConfiguration.linkCallback,
            isLinkHtml15: item.link.isSome(),
            linkUrlHtml15: if (item.link.isSome()) { item.link().getDestination() } else { Option<String>.None }
        )
    } else {
        MarkdownImgHtml14Component(
            markdownConfigurationHtml14: markdownConfiguration,
            destinationHtml14: (item.node as ImageHtmlNode)().getDestination(),
            componentWidthHtml14: componentWidth,
            imageWidthHtml14: strToFloat64((item.node as ImageHtmlNode)().getWidth()),
            imageHeightHtml14: strToFloat64((item.node as ImageHtmlNode)().getHeight()),
            imageCallbackHtml14: imageCallback,
            linkCallbackHtml14: markdownConfiguration.linkCallback,
            isLinkHtml14: item.link.isSome(),
            linkUrlHtml14: if (item.link.isSome()) { item.link().getDestination() } else { Option<String>.None }
        )
    }
}

/**
 * style图片
 */
@Builder
func styleImageSpanComponent(item: NodeView, markdownConfiguration: MarkdownConfiguration, componentWidth: Float64, imageCallback: (String) -> Unit) {
    if (markdownConfiguration.imageCallbackCallback.isNone()) {
        if ((item.node as StyleImage)().getDestination().startsWith("./")) {
            MarkdownImgStyleRawFileComponent(
                markdownConfigurationStyleRawFile: markdownConfiguration,
                destinationStyleRawFile: (item.node as StyleImage)().getDestination(),
                componentWidthStyleRawFile: componentWidth,
                picStyle: (item.node as StyleImage)().styles,
                imageCallbackStyleRawFile: imageCallback,
                linkCallbackStyleRawFile: markdownConfiguration.linkCallback,
                isLinkStyleRawFile: item.link.isSome(),
                linkUrlStyleRawFile: if (item.link.isSome()) {
                    item.link().getDestination()
                } else {
                    Option<String>.None
                },
            )
        } else {
            if (DeviceInfo.sdkApiVersion >= 15) {
                MarkdownImgStyleUrl15Component(
                    markdownConfigurationStyleUrl15: markdownConfiguration,
                    destinationStyleUrl15: (item.node as StyleImage)().getDestination(),
                    componentWidthStyleUrl15: componentWidth,
                    picStyle: (item.node as StyleImage)().styles,
                    imageCallbackStyleUrl15: imageCallback,
                    linkCallbackStyleUrl15: markdownConfiguration.linkCallback,
                    isLinkStyleUrl15: item.link.isSome(),
                    linkUrlStyleUrl15: if (item.link.isSome()) {
                        item.link().getDestination()
                    } else {
                        Option<String>.None
                    },
                )
            } else {
                MarkdownImgStyleUrl14Component(
                    markdownConfigurationStyleUrl14: markdownConfiguration,
                    destinationStyleUrl14: (item.node as StyleImage)().getDestination(),
                    componentWidthStyleUrl14: componentWidth,
                    picStyle: (item.node as StyleImage)().styles,
                    imageCallbackStyleUrl14: imageCallback,
                    linkCallbackStyleUrl14: markdownConfiguration.linkCallback,
                    isLinkStyleUrl14: item.link.isSome(),
                    linkUrlStyleUrl14: if (item.link.isSome()) {
                        item.link().getDestination()
                    } else {
                        Option<String>.None
                    },
                )
            }
        }
    } else {
        if ((item.node as StyleImage)().getDestination().startsWith("./")) {
            MarkdownImgStyleRawFileCallbackComponent(
                markdownConfigurationStyleRawFileCallback: markdownConfiguration,
                destinationStyleRawFileCallback: (item.node as StyleImage)().getDestination(),
                componentWidthStyleRawFileCallback: componentWidth,
                picStyle: (item.node as StyleImage)().styles,
                imageCallbackStyleRawFileCallback: imageCallback,
                linkCallbackStyleRawFileCallback: markdownConfiguration.linkCallback,
                isLinkStyleRawFileCallback: item.link.isSome(),
                linkUrlStyleRawFileCallback: if (item.link.isSome()) {
                    item.link().getDestination()
                } else {
                    Option<String>.None
                },
            )
        } else {
            if (DeviceInfo.sdkApiVersion >= 15) {
                MarkdownImgStyleUrlCallback15Component(
                    markdownConfigurationStyleUrlCallback15: markdownConfiguration,
                    destinationStyleUrlCallback15: (item.node as StyleImage)().getDestination(),
                    componentWidthStyleUrlCallback15: componentWidth,
                    picStyle: (item.node as StyleImage)().styles,
                    imageCallbackStyleUrlCallback15: imageCallback,
                    linkCallbackStyleUrlCallback15: markdownConfiguration.linkCallback,
                    isLinkStyleUrlCallback15: item.link.isSome(),
                    linkUrlStyleUrlCallback15: if (item.link.isSome()) {
                        item.link().getDestination()
                    } else {
                        Option<String>.None
                    },
                )
            } else {
                MarkdownImgStyleUrlCallback14Component(
                    markdownConfigurationStyleUrlCallback14: markdownConfiguration,
                    destinationStyleUrlCallback14: (item.node as StyleImage)().getDestination(),
                    componentWidthStyleUrlCallback14: componentWidth,
                    picStyle: (item.node as StyleImage)().styles,
                    imageCallbackStyleUrlCallback14: imageCallback,
                    linkCallbackStyleUrlCallback14: markdownConfiguration.linkCallback,
                    isLinkStyleUrlCallback14: item.link.isSome(),
                    linkUrlStyleUrlCallback14: if (item.link.isSome()) {
                        item.link().getDestination()
                    } else {
                        Option<String>.None
                    },
                )
            }
        }
    }
}

/**
 * 基础图片
 */
@Builder
func coreImageSpanComponent(item: NodeView, markdownConfiguration: MarkdownConfiguration, componentWidth: Float64, imageCallback: (String) -> Unit) {
    if (markdownConfiguration.imageCallbackCallback.isNone()) {
        if ((item.node as CommonmarkImage)().getDestination().startsWith("./")) {
            MarkdownImgRawFileComponent(
                markdownConfigurationRawFile: markdownConfiguration,
                destinationRawFile: (item.node as CommonmarkImage)().getDestination(),
                componentWidthRawFile: componentWidth,
                imageCallbackRawFile: imageCallback,
                linkCallbackRawFile: markdownConfiguration.linkCallback,
                isLinkRawFile: item.link.isSome(),
                linkUrlRawFile: if (item.link.isSome()) {
                    item.link().getDestination()
                } else {
                    Option<String>.None
                },
            )
        } else {
            if (DeviceInfo.sdkApiVersion >= 15) {
                MarkdownImgUrl15Component(
                    markdownConfigurationUrl15: markdownConfiguration,
                    destinationUrl15: (item.node as CommonmarkImage)().getDestination(),
                    componentWidthUrl15: componentWidth,
                    imageCallbackUrl15: imageCallback,
                    linkCallbackUrl15: markdownConfiguration.linkCallback,
                    isLinkUrl15: item.link.isSome(),
                    linkUrlUrl15: if (item.link.isSome()) {
                        item.link().getDestination()
                    } else {
                        Option<String>.None
                    },
                )
            } else {
                MarkdownImgUrl14Component(
                    markdownConfigurationUrl14: markdownConfiguration,
                    destinationUrl14: (item.node as CommonmarkImage)().getDestination(),
                    componentWidthUrl14: componentWidth,
                    imageCallbackUrl14: imageCallback,
                    linkCallbackUrl14: markdownConfiguration.linkCallback,
                    isLinkUrl14: item.link.isSome(),
                    linkUrlUrl14: if (item.link.isSome()) {
                        item.link().getDestination()
                    } else {
                        Option<String>.None
                    },
                )
            }
        }
    } else {
        if ((item.node as CommonmarkImage)().getDestination().startsWith("./")) {
            MarkdownImgRawFileCallbackComponent(
                markdownConfigurationRawFileCallback: markdownConfiguration,
                destinationRawFileCallback: (item.node as CommonmarkImage)().getDestination(),
                componentWidthRawFileCallback: componentWidth,
                imageCallbackRawFileCallback: imageCallback,
                linkCallbackRawFileCallback: markdownConfiguration.linkCallback,
                isLinkRawFileCallback: item.link.isSome(),
                linkUrlRawFileCallback: if (item.link.isSome()) {
                    item.link().getDestination()
                } else {
                    Option<String>.None
                },
            )
        } else {
            if (DeviceInfo.sdkApiVersion >= 15) {
                MarkdownImgUrlCallback15Component(
                    markdownConfigurationUrlCallback15: markdownConfiguration,
                    destinationUrlCallback15: (item.node as CommonmarkImage)().getDestination(),
                    componentWidthUrlCallback15: componentWidth,
                    imageCallbackUrlCallback15: imageCallback,
                    linkCallbackUrlCallback15: markdownConfiguration.linkCallback,
                    isLinkUrlCallback15: item.link.isSome(),
                    linkUrlUrlCallback15: if (item.link.isSome()) {
                        item.link().getDestination()
                    } else {
                        Option<String>.None
                    },
                )
            } else {
                MarkdownImgUrlCallback14Component(
                    markdownConfigurationUrlCallback14: markdownConfiguration,
                    destinationUrlCallback14: (item.node as CommonmarkImage)().getDestination(),
                    componentWidthUrlCallback14: componentWidth,
                    imageCallbackUrlCallback14: imageCallback,
                    linkCallbackUrlCallback14: markdownConfiguration.linkCallback,
                    isLinkUrlCallback14: item.link.isSome(),
                    linkUrlUrlCallback14: if (item.link.isSome()) {
                        item.link().getDestination()
                    } else {
                        Option<String>.None
                    },
                )
            }
        }
    }
}

/**
 * 数学公式 - 行内
 */
@Builder
func latexSpanComponent(item: NodeView, markdownConfiguration: MarkdownConfiguration, componentWidth: Float64) {
    MarkdownLatexImageSpanComponent(
        markdownConfiguration: markdownConfiguration,
        componentWidth: componentWidth,
        strLatexMath: (item.node as LatexMathNode)().latex,
        linkCallback: markdownConfiguration.linkCallback,
        isLink: item.link.isSome(),
        linkUrl: if (item.link.isSome()) {
            item.link().getDestination()
        } else {
            Option<String>.None
        }
    )
}

/**
 * 链接块
 */
@Builder
func linkSpanComponent(isOneLink: Bool, isListTo: Bool, level: Int64, item: NodeView, markdownConfiguration: MarkdownConfiguration, componentWidth: Float64, imageCallback: (String) -> Unit, isHeader: Bool, isDescList: Bool, nodeType: Int64, isListLinkStyle: Bool) {
    if ((isListTo && !isListLinkStyle && isOneLink) || !markdownConfiguration.markdownTheme.isLinkStyle) {
        if (getLinkString(item).isSome()) {
            if (nodeType == 0) {
                if (DeviceInfo.sdkApiVersion >= 19) {
                    headingLinkComponent19(item, getLinkString(item)(), markdownConfiguration, level)
                } else {
                    headingLinkComponent18(item, getLinkString(item)(), markdownConfiguration, level)
                }
            } else if (nodeType == 1) {
                if (DeviceInfo.sdkApiVersion >= 19) {
                    paragraphLinkComponent19(item, isDescList, getLinkString(item)(), markdownConfiguration)
                } else {
                    paragraphLinkComponent18(item, isDescList, getLinkString(item)(), markdownConfiguration)
                }
            } else if (nodeType == 2) {
                if (DeviceInfo.sdkApiVersion >= 19) {
                    tableLinkComponent19(item, isHeader, getLinkString(item)(), markdownConfiguration)
                } else {
                    tableLinkComponent18(item, isHeader, getLinkString(item)(), markdownConfiguration)
                }
            }
        } else {
            Span("")
        }
    } else {
        if ((item.node as CommonmarkLink)().getDestination().startsWith("http://") || (item.node as CommonmarkLink)().getDestination().startsWith("https://")) {
            if (getLinkString(item).isSome()) {
                if (getLinkString(item)().trimAscii().toRuneArray().size > 1) {
                    MarkdownLinkRectImageComponent(
                        markdownConfiguration: markdownConfiguration,
                        strText: getLinkString(item)().trimAscii(),
                        strUrl: (item.node as CommonmarkLink)().getDestination()
                    )
                } else {
                    MarkdownLinkCircleImageComponent(
                        markdownConfiguration: markdownConfiguration,
                        strText: getLinkString(item)().trimAscii(),
                        strUrl: (item.node as CommonmarkLink)().getDestination()
                    )
                }
            } else {
                Span("")
            }
        } else {
            if (getLinkString(item).isSome()) {
                MarkdownLinkRectToolImageComponent(
                    markdownConfiguration: markdownConfiguration,
                    strText: getLinkString(item)(),
                    strUrl: (item.node as CommonmarkLink)().getDestination(),
                    strType: urlSafeBase64Decode((item.node as CommonmarkLink)().getDestination())
                )
            } else {
                Span("")
            }
        }
    }
}

/**
 * 内联代码
 */
@Builder
func inLineCodeSpanComponent(item: NodeView, markdownConfiguration: MarkdownConfiguration, isFakeBoldText: Bool, isHeader: Bool, isDescList: Bool, nodeType: Int64) {
    if (markdownConfiguration.markdownTheme.isCodeStyle) {
        MarkdownCodeLineImageSpanComponent(
            markdownConfiguration: markdownConfiguration,
            strCode: (item.node as Code)().getLiteral(),
            strUrl: linkUrl(item),
            isFakeBoldText: isFakeBoldText
        )
    } else {
        if (nodeType == 0) {
            if (DeviceInfo.sdkApiVersion >= 19) {
                headingCodeComponent19(item, markdownConfiguration)
            } else {
                headingCodeComponent18(item, markdownConfiguration)
            }
        } else if (nodeType == 1) {
            if (DeviceInfo.sdkApiVersion >= 19) {
                paragraphCodeComponent19(item, isDescList, markdownConfiguration)
            } else {
                paragraphCodeComponent18(item, isDescList, markdownConfiguration)
            }
        } else if (nodeType == 2) {
            if (DeviceInfo.sdkApiVersion >= 19) {
                tableComponentCode19(item, isHeader, markdownConfiguration)
            } else {
                tableComponentCode18(item, isHeader, markdownConfiguration)
            }
        }
    }
}

/**
 * 标题
 */
@Builder
func blockHeadingComponent(markdownConfiguration: MarkdownConfiguration, item: NodeView, fontCallback: (String) -> Unit, imageCallback: (String) -> Unit, componentWidth: Float64, isListTo: Bool, headingComponents: HashMap<Int64, MarkdownHeadingComponent>) {
    MarkdownHeadingComponent(
        markdownConfiguration: markdownConfiguration,
        nodeView: item,
        fontCallback: fontCallback,
        imageCallback: imageCallback,
        componentWidth: componentWidth,
        isListTo: isListTo,
        headingComponents: headingComponents
    )
}

/**
 * 段落
 */
@Builder
func blockParagraphComponent(markdownConfiguration: MarkdownConfiguration, item: NodeView, footnoteBlock: Option<FootnoteBlock>, fontCallback: (String) -> Unit, tocListOnClick: (Int64) -> Unit, imageCallback: (String) -> Unit, componentWidth: Float64, isListTo: Bool, isDescList: Bool, paragraphComponents: HashMap<Int64, MarkdownParagraphComponent>) {
    MarkdownParagraphComponent(
        markdownConfiguration: markdownConfiguration,
        nodeView: item,
        footnoteBlock: footnoteBlock,
        fontCallback: fontCallback,
        tocListOnClick: tocListOnClick,
        imageCallback: imageCallback,
        componentWidth: componentWidth,
        isListTo: isListTo,
        paragraphComponents: paragraphComponents
    )
}

/**
 * 围栏代码
 */
@Builder
func blockFencedCodeComponent(markdownConfiguration: MarkdownConfiguration, item: NodeView, fencedCodeComponents: HashMap<Int64, MarkdownFencedCodeBlockComponent>) {
    MarkdownFencedCodeBlockComponent(
        markdownConfiguration: markdownConfiguration,
        nodeView: item,
        fencedCodeComponents: fencedCodeComponents
    )
}

/**
 * 缩进代码
 */
@Builder
func blockIndentedCodeComponent(markdownConfiguration: MarkdownConfiguration, item: NodeView, indentedCodeComponents: HashMap<Int64, MarkdownIndentedCodeBlockComponent>) {
    MarkdownIndentedCodeBlockComponent(
        markdownConfiguration: markdownConfiguration,
        nodeView: item,
        indentedCodeComponents: indentedCodeComponents
    )
}

/**
 * 表格
 */
@Builder
func blockTableComponent(markdownConfiguration: MarkdownConfiguration, item: NodeView, fontCallback: (String) -> Unit, imageCallback: (String) -> Unit, componentWidth: Float64, tableComponents: HashMap<Int64, MarkdownTableBlockComponent>, tableRowComponents: HashMap<Int64, MarkdownTableBlockRowComponent>, tableCellComponents: HashMap<Int64, MarkdownTableBlockCellComponent>) {
    MarkdownTableBlockComponent(
        markdownConfiguration: markdownConfiguration,
        nodeView: item,
        fontCallback: fontCallback,
        imageCallback: imageCallback,
        componentWidth: componentWidth,
        tableComponents: tableComponents,
        tableRowComponents: tableRowComponents,
        tableCellComponents: tableCellComponents
    )
}

/**
 * 数学公式 -单行
 */
@Builder
func blockLatextComponent(markdownConfiguration: MarkdownConfiguration, item: NodeView) {
    if ((item.node as LatexMathBlock)().isClosed) {
        // 结束显示数学公式
        MarkdownLatexMathBlockComponent(
            markdownConfiguration: markdownConfiguration,
            nodeView: item,
            latexStr: (item.node as LatexMathBlock)().latex
        )
    } else {
        // 没结束显示纯文本
        Text((item.node as LatexMathBlock)().latex)
    }
}

/**
 * 图片幻灯片
 */
@Builder
func blockImageBannerComponent(markdownConfiguration: MarkdownConfiguration, item: NodeView, imageCallback: (String) -> Unit) {
    MarkdownImageBannerComponent(
        slideBlockNodeView: item,
        markdownConfiguration: markdownConfiguration,
        imageCallback: imageCallback
    )
}

/**
 * 组合代码
 */
@Builder
func blockCodeBlockListComponent(markdownConfiguration: MarkdownConfiguration, item: NodeView, res: (ArrayList<String>, ArrayList<String>, ArrayList<String>)) {
    MarkdownCodeBlockListComponent(
        nodeView: item,
        strInfos: res[0],
        strText: res[1],
        strInfoText: res[2],
        markdownConfiguration: markdownConfiguration
    )
}

/**
 *
 */
@Builder
func codeNumberComponent(lineArray: ObservedArrayList<Int64>, markdownConfiguration: MarkdownConfiguration) {
    Column() {
        ForEach(
            lineArray,
            itemGeneratorFunc: {
                item: Int64, idx: Int64 => Text((idx + 1).toString())
                    // 设置文本颜色
                    .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                    // 设置文本尺寸
                    .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                    // 设置行高
                    .lineHeight(markdownConfiguration.markdownTheme.codeBlockLineHeight)
                    // 设置文本的最大行数
                    .maxLines(1)
                    // 设置文本超长时的显示方式
                    .textOverflow(TextOverflow.Ellipsis)
            },
            keyGeneratorFunc: {
                item: Int64, idx: Int64 => return "${idx}-${item}"
            }
        )
    }
    // 设置外边距属性
    .margin(bottom: 10)
    // 设置内边距属性
    .padding(left: 8, right: 8)
    // 设置 Column 子组件在水平方向上的对齐格式
    .alignItems(HorizontalAlign.End)
    // 设置边框的宽度
    .borderWidth(EdgeWidths(right: markdownConfiguration.markdownTheme.thematicBreakHeight.vp))
    // 设置元素的边框样式
    .borderStyle(BorderStyle.Solid)
    // 设置边框的颜色
    .borderColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
    // 控件显示和隐藏
    .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockLineNumberHide))
}

/**
 *
 */
@Builder
func codeImageComponent(markdownConfiguration: MarkdownConfiguration, codeText: String, info: Option<String>, info1: String, typ: Int64) {
    Row() {
        if (markdownConfiguration.markdownTheme.codeCopyIcon.isSome()) {
            Row() {
                Image(markdownConfiguration.markdownTheme.codeCopyIcon())
                    // 设置组件自身的宽度
                    .width(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                    // 设置组件自身的高度
                    .height(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Contain)

                Row()
                    // 设置宽度
                    .width(5)

                if (markdownConfiguration.markdownTheme.codeBlockIconTextHide) {
                    Text("复制代码")
                        // 设置字体颜色
                        .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                        // 设置字体大小
                        .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                        // 设置容器元素绘制区域内的子元素的对齐方式
                        .align(Alignment.End)
                        // 设置文本的最大行数
                        .maxLines(1)
                        // 设置文本超长时的显示方式
                        .textOverflow(TextOverflow.Ellipsis)
                        // 设置外边距
                        .margin(right: 4)
                }
            }
            // 设置子组件在水平方向上的对齐格式
            .justifyContent(FlexAlign.End)
            // 点击动作触发该方法调用
            .onClick {evt => codeCopyOnClick(codeText, markdownConfiguration.codeCopyCallback)}
        }

        if (markdownConfiguration.markdownTheme.codeFullScreenIcon.isSome()) {
            Row() {
                Image(markdownConfiguration.markdownTheme.codeFullScreenIcon())
                    // 设置组件自身的宽度
                    .width(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                    // 设置组件自身的高度
                    .height(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                    // 设置外边距属性
                    .margin(left: 4)
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Contain)

                Row()
                    // 设置宽度
                    .width(5)

                if (markdownConfiguration.markdownTheme.codeBlockIconTextHide) {
                    Text("全屏代码")
                        // 设置字体颜色
                        .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                        // 设置字体大小
                        .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                        // 设置容器元素绘制区域内的子元素的对齐方式
                        .align(Alignment.End)
                        // 设置文本的最大行数
                        .maxLines(1)
                        // 设置文本超长时的显示方式
                        .textOverflow(TextOverflow.Ellipsis)
                        // 设置外边距
                        .margin(right: 4)
                }
            }
            // 设置子组件在水平方向上的对齐格式
            .justifyContent(FlexAlign.End)
            // 控制当前组件显示或隐藏
            .visibility(isVisibility(markdownConfiguration.markdownTheme.isCodeFullScreen))
            // 点击动作触发该方法调用
            .onClick {
                evt => codeFullScreenOnClick(codeText, if(typ == 0) {info} else {info1}, markdownConfiguration.codeFullScreenCallback)
            }
        }
    }
    // 设置宽度
    .width(70.percent)
    // 设置子组件在水平方向上的对齐格式
    .justifyContent(FlexAlign.End)
}