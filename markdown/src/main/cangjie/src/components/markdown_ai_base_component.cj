/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 标题一级二级分割线
 */
@Builder
func headingDividerComponent(markdownAIConfiguration: MarkdownAIConfiguration) {
    Divider()
        // 设置分割线颜色
        .color(markdownAIConfiguration.markdownAITheme.headingBreakColor)
        // 设置分割线宽度
        .strokeWidth(markdownAIConfiguration.markdownAITheme.headingBreakHeight)
}

/**
 * 标题文本
 */
@Builder
func headingTextComponent(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, level: Int64) {
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
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownAIConfiguration.linkCallback)}
}

/**
 * 段落文本
 */
@Builder
func paragraphTextComponent(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration) {
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
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownAIConfiguration.linkCallback)}
}

/**
 * 表格文本
 */
@Builder
func tableComponentText(nodeView: NodeView, isHeader: Bool, markdownAIConfiguration: MarkdownAIConfiguration) {
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
        .onClick {evt => linkOnClick(nodeView, markdownAIConfiguration.linkCallback)}
}

/**
 * 表格内联代码
 */
@Builder
func tableComponentCode(nodeView: NodeView, isHeader: Bool, markdownAIConfiguration: MarkdownAIConfiguration) {
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
        // 设置文本字符间距
        .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownAIConfiguration.linkCallback)}
}
