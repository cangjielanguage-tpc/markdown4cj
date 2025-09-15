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
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
}

/**
 * 链接文本
 */
@Builder
func headingLinkComponent(nodeView: NodeView, link:String, markdownAIConfiguration: MarkdownAIConfiguration, level: Int64) {
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
        // 自定义背景色
        .interopStyle(true, markdownAIConfiguration.markdownAITheme.codeBackgroundColor)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownAIConfiguration.linkCallback)}
}

/**
 * 标题脚注文本
 */
@Builder
func headingFootnoteComponent(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, level: Int64, fontCallback: (String) -> Unit) {
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
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
}

/**
 * 段落链接
 */
@Builder
func paragraphLinkComponent(nodeView: NodeView, link:String, markdownAIConfiguration: MarkdownAIConfiguration) {
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
        // 自定义背景色
        .interopStyle(true, markdownAIConfiguration.markdownAITheme.codeBackgroundColor)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownAIConfiguration.linkCallback)}
}

/**
 * 段落脚注文本
 */
@Builder
func paragraphFootnoteComponent(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, fontCallback: (String) -> Unit) {
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
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownAIConfiguration.linkCallback)
            }
        }
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
        // 自定义背景色
        .interopStyle(true, markdownAIConfiguration.markdownAITheme.codeBackgroundColor)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[0], color: spanDecoration(nodeView, markdownAIConfiguration.markdownAITheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownAIConfiguration.linkCallback)}
}

/**
 * 表格脚注文本
 */
@Builder
func tableComponentFootnote(nodeView: NodeView, isHeader: Bool, markdownAIConfiguration: MarkdownAIConfiguration, fontCallback: (String) -> Unit) {
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
