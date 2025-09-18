/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
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
func headingTextComponent18(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, level: Int64) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, true, level))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, true))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
}

/**
 * 标题文本
 */
@Builder
func headingTextComponent19(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, level: Int64) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, true, level))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, true))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme)))
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
}

/**
 * 标题文本
 */
@Builder
func headingTextComponent(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, level: Int64) {
    if (DeviceInfo.sdkApiVersion >= 19) {
        headingTextComponent19(nodeView, markdownAIConfiguration, level)
    } else {
        headingTextComponent18(nodeView, markdownAIConfiguration, level)
    }
}

/**
 * 标题链接文本
 */
@Builder
func headingLinkComponent18(nodeView: NodeView, link: String, markdownAIConfiguration: MarkdownAIConfiguration, level: Int64) {
    // 设置文本内容
    Span(link)
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, true, level))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, true))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
}

/**
 * 标题链接文本
 */
@Builder
func headingLinkComponent19(nodeView: NodeView, link: String, markdownAIConfiguration: MarkdownAIConfiguration, level: Int64) {
    // 设置文本内容
    Span(link)
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, true, level))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, true))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, true, markdownAIConfiguration.markdownAITheme)))
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
}

/**
 * 标题链接文本
 */
@Builder
func headingLinkComponent(nodeView: NodeView, link: String, markdownAIConfiguration: MarkdownAIConfiguration, level: Int64) {
    if (DeviceInfo.sdkApiVersion >= 19) {
        headingLinkComponent19(nodeView, link, markdownAIConfiguration, level)
    } else {
        headingLinkComponent18(nodeView, link, markdownAIConfiguration, level)
    }
}

/**
 * 标题内联代码
 */
@Builder
func headingCodeComponent18(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownAIConfiguration.markdownAITheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownAIConfiguration.markdownAITheme, true, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownAIConfiguration.markdownAITheme, true))
        // 自定义背景色
        .interopStyle(true, markdownAIConfiguration.markdownAITheme.codeBackgroundColor)
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownAIConfiguration.linkCallback)}
}

/**
 * 标题内联代码
 */
@Builder
func headingCodeComponent19(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownAIConfiguration.markdownAITheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownAIConfiguration.markdownAITheme, true, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownAIConfiguration.markdownAITheme, true))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(true, false, markdownAIConfiguration.markdownAITheme)))
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownAIConfiguration.linkCallback)}
}

/**
 * 标题内联代码
 */
@Builder
func headingCodeComponent(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration) {
    if (DeviceInfo.sdkApiVersion >= 19) {
        headingCodeComponent19(nodeView, markdownAIConfiguration)
    } else {
        headingCodeComponent18(nodeView, markdownAIConfiguration)
    }
}

/**
 * 标题脚注文本
 */
@Builder
func headingFootnoteComponent18(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, level: Int64, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, true, level))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, true))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
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
func headingFootnoteComponent19(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, level: Int64, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, true, level))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, true))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme)))
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
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
func headingFootnoteComponent(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, level: Int64, fontCallback: (String) -> Unit) {
    if (DeviceInfo.sdkApiVersion >= 19) {
        headingFootnoteComponent19(nodeView, markdownAIConfiguration, level, fontCallback)
    } else {
        headingFootnoteComponent18(nodeView, markdownAIConfiguration, level, fontCallback)
    }
}

/**
 * 段落文本
 */
@Builder
func paragraphTextComponent18(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, false))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
}

/**
 * 段落文本
 */
@Builder
func paragraphTextComponent19(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme)))
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
}

/**
 * 段落文本
 */
@Builder
func paragraphTextComponent(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration) {
    if (DeviceInfo.sdkApiVersion >= 19) {
        paragraphTextComponent19(nodeView, markdownAIConfiguration)
    } else {
        paragraphTextComponent18(nodeView, markdownAIConfiguration)
    }
}

/**
 * 段落链接文本
 */
@Builder
func paragraphLinkComponent18(nodeView: NodeView, link: String, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Span(link)
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, false))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
}

/**
 * 段落链接文本
 */
@Builder
func paragraphLinkComponent19(nodeView: NodeView, link: String, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Span(link)
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, true, markdownAIConfiguration.markdownAITheme)))
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
}

/**
 * 段落链接文本
 */
@Builder
func paragraphLinkComponent(nodeView: NodeView, link: String, markdownAIConfiguration: MarkdownAIConfiguration) {
    if (DeviceInfo.sdkApiVersion >= 19) {
        paragraphLinkComponent19(nodeView, link, markdownAIConfiguration)
    } else {
        paragraphLinkComponent18(nodeView, link, markdownAIConfiguration)
    }
}

/**
 * 段落内联代码
 */
@Builder
func paragraphCodeComponent18(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownAIConfiguration.markdownAITheme, false))
        // 自定义背景色
        .interopStyle(true, markdownAIConfiguration.markdownAITheme.codeBackgroundColor)
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownAIConfiguration.linkCallback)}
}

/**
 * 段落内联代码
 */
@Builder
func paragraphCodeComponent19(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownAIConfiguration.markdownAITheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(true, false, markdownAIConfiguration.markdownAITheme)))
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownAIConfiguration.linkCallback)}
}

/**
 * 段落内联代码
 */
@Builder
func paragraphCodeComponent(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration) {
    if (DeviceInfo.sdkApiVersion >= 19) {
        paragraphCodeComponent19(nodeView, markdownAIConfiguration)
    } else {
        paragraphCodeComponent18(nodeView, markdownAIConfiguration)
    }
}

/**
 * 段落脚注文本
 */
@Builder
func paragraphFootnoteComponent18(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, false))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
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
func paragraphFootnoteComponent19(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme)))
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
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
func paragraphFootnoteComponent(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, fontCallback: (String) -> Unit) {
    if (DeviceInfo.sdkApiVersion >= 19) {
        paragraphFootnoteComponent19(nodeView, markdownAIConfiguration, fontCallback)
    } else {
        paragraphFootnoteComponent18(nodeView, markdownAIConfiguration, fontCallback)
    }
}

/**
 * 表格文本
 */
@Builder
func tableComponentText18(nodeView: NodeView, isHeader: Bool, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, false))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
}

/**
 * 表格文本
 */
@Builder
func tableComponentText19(nodeView: NodeView, isHeader: Bool, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme)))
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
}

/**
 * 表格文本
 */
@Builder
func tableComponentText(nodeView: NodeView, isHeader: Bool, markdownAIConfiguration: MarkdownAIConfiguration) {
    if (DeviceInfo.sdkApiVersion >= 19) {
        tableComponentText19(nodeView, isHeader, markdownAIConfiguration)
    } else {
        tableComponentText18(nodeView, isHeader, markdownAIConfiguration)
    }
}

/**
 * 表格内联代码
 */
@Builder
func tableComponentCode18(nodeView: NodeView, isHeader: Bool, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownAIConfiguration.markdownAITheme, false))
        // 自定义背景色
        .interopStyle(true, markdownAIConfiguration.markdownAITheme.codeBackgroundColor)
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownAIConfiguration.linkCallback)}
}

/**
 * 表格内联代码
 */
@Builder
func tableComponentCode19(nodeView: NodeView, isHeader: Bool, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownAIConfiguration.markdownAITheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(true, false, markdownAIConfiguration.markdownAITheme)))
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownAIConfiguration.linkCallback)}
}

/**
 * 表格内联代码
 */
@Builder
func tableComponentCode(nodeView: NodeView, isHeader: Bool, markdownAIConfiguration: MarkdownAIConfiguration) {
    if (DeviceInfo.sdkApiVersion >= 19) {
        tableComponentCode19(nodeView, isHeader, markdownAIConfiguration)
    } else {
        tableComponentCode18(nodeView, isHeader, markdownAIConfiguration)
    }
}

/**
 * 表格链接文本
 */
@Builder
func tableLinkComponent18(nodeView: NodeView, isHeader: Bool, link: String, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Span(link)
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, false))
        // 自定义背景色
        .interopStyle(nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme.linkBackGroupColor)
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
}

/**
 * 表格链接文本
 */
@Builder
func tableLinkComponent19(nodeView: NodeView, isHeader: Bool, link: String, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Span(link)
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme)))
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
}

/**
 * 表格链接文本
 */
@Builder
func tableLinkComponent(nodeView: NodeView, isHeader: Bool, link: String, markdownAIConfiguration: MarkdownAIConfiguration) {
    if (DeviceInfo.sdkApiVersion >= 19) {
        tableLinkComponent19(nodeView, isHeader, link, markdownAIConfiguration)
    } else {
        tableLinkComponent18(nodeView, isHeader, link, markdownAIConfiguration)
    }
}

/**
 * 表格脚注文本
 */
@Builder
func tableComponentFootnote18(nodeView: NodeView, isHeader: Bool, markdownAIConfiguration: MarkdownAIConfiguration, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
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
func tableComponentFootnote19(nodeView: NodeView, isHeader: Bool, markdownAIConfiguration: MarkdownAIConfiguration, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownAIConfiguration.markdownAITheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownAIConfiguration.markdownAITheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownAIConfiguration.markdownAITheme, false))
        // 设置背景样式
        .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(false, nodeView.link.isSome(), markdownAIConfiguration.markdownAITheme)))
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
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
func tableComponentFootnote(nodeView: NodeView, isHeader: Bool, markdownAIConfiguration: MarkdownAIConfiguration, fontCallback: (String) -> Unit) {
    if (DeviceInfo.sdkApiVersion >= 19) {
        tableComponentFootnote19(nodeView, isHeader, markdownAIConfiguration, fontCallback)
    } else {
        tableComponentFootnote18(nodeView, isHeader, markdownAIConfiguration, fontCallback)
    }
}

/**
 * 无序列表和有序列表的前缀文本
 */
@Builder
func listPrefixTextINCComponent(item: NodeView, isBullet: Bool, markdownAIConfiguration: MarkdownAIConfiguration) {
    // 设置文本内容
    Text(listPrefixStr(item, isBullet))
        // 设置文本颜色
        .fontColor(listPrefixColor(markdownAIConfiguration.markdownAITheme, isBullet))
        // 设置文本尺寸
        .fontSize(listPrefixSize(markdownAIConfiguration.markdownAITheme, isBullet))
        // 设置内边距属性
        .padding(left: markdownAIConfiguration.markdownAITheme.blockLeftMargin, right: markdownAIConfiguration.markdownAITheme.blockRightMargin)
        // 设置行高
        .lineHeight(listPrefixLineHeight(isBullet, markdownAIConfiguration))
        // 设置文本段落在水平方向的对齐方式
        .textAlign(TextAlign.Center)
        // 设置文本的字体粗细
        .fontWeight(isFontWeight(markdownAIConfiguration.markdownAITheme.orderedListItemPrefixBold))
        // 块内容前的起始边距
        .margin(top: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins, bottom: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins)
}

/**
 * 任务列表的前缀多选框
 */
@Builder
func listPrefixCheckboxINCComponent(item: NodeView, markdownAIConfiguration: MarkdownAIConfiguration) {
    Checkbox()
        // 设置组件自身的高度
        .height(markdownAIConfiguration.markdownAITheme.taskListItemLength)
        // 设置组件自身的宽度
        .width(markdownAIConfiguration.markdownAITheme.taskListItemLength)
        // 设置按钮形状样式
        .select(taskSelect(item))
        // 值为 true 表示组件可用，可响应点击等操作；值为 false 时，不响应点击等操作
        .enabled(false)
        // 切换CheckBox组件形状
        .shape(CheckBoxShape.ROUNDED_SQUARE)
        // 设置外边距属性
        .margin(left: markdownAIConfiguration.markdownAITheme.blockLeftMargin, right: markdownAIConfiguration.markdownAITheme.blockRightMargin, top: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins, bottom: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins)
}
