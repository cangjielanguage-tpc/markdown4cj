/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
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
func headingTextComponent(nodeView: NodeView, markdownConfiguration: MarkdownConfiguration, level: Int64, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, true, level))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, true))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownConfiguration.linkCallback)
            }
        }
}

/**
 * 标题内联代码
 */
@Builder
func headingCodeComponent(nodeView: NodeView, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownConfiguration.markdownTheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownConfiguration.markdownTheme, true, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownConfiguration.markdownTheme, true))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.headingTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
}

/**
 * 标题脚注
 */
@Builder
func headingFootnoteComponent(nodeView: NodeView, markdownConfiguration: MarkdownConfiguration, level: Int64, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, true))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, true, level))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, true))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, true))
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
func paragraphTextComponent(nodeView: NodeView, markdownConfiguration: MarkdownConfiguration, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownConfiguration.linkCallback)
            }
        }
}

/**
 * 段落文本
 */
@Builder
func paragraphTocComponent(nodeView: NodeView, markdownConfiguration: MarkdownConfiguration, tocListOnClick: (Int64) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => tocListOnClick((nodeView.node as HeadLink)().headIndex)
        }
}

/**
 * 段落内联代码
 */
@Builder
func paragraphCodeComponent(nodeView: NodeView, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownConfiguration.markdownTheme, false))
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
func paragraphFootnoteComponent(nodeView: NodeView, markdownConfiguration: MarkdownConfiguration, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, false))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
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
func tableComponentText(nodeView: NodeView, isHeader: Bool, markdownConfiguration: MarkdownConfiguration, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
        // 设置文本字符间距
        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
        // 设置文本装饰线样式及其颜色
        .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
        // 点击动作触发该方法调用
        .onClick {
            evt => if (nodeView.link.isSome()) {
                linkOnClick(nodeView, markdownConfiguration.linkCallback)
            }
        }
}

/**
 * 表格内联代码
 */
@Builder
func tableComponentCode(nodeView: NodeView, isHeader: Bool, markdownConfiguration: MarkdownConfiguration) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(true, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, true, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, true, markdownConfiguration.markdownTheme, false))
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
func tableComponentFootnote(nodeView: NodeView, isHeader: Bool, markdownConfiguration: MarkdownConfiguration, fontCallback: (String) -> Unit) {
    // 设置文本内容
    Span(spanText(nodeView))
        // 设置文本的字体列表
        .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
        // 设置文本尺寸
        .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
        // 设置文本的字体粗细
        .fontWeight(spanFontWeight(nodeView, isHeader))
        // 设置文本的字体样式
        .fontStyle(spanFontStyle(nodeView))
        // 设置文本颜色
        .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
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
    Text(listPrefixStr(item, isBullet))
        // 设置文本颜色
        .fontColor(listPrefixColor(markdownConfiguration.markdownTheme, isBullet))
        // 设置文本尺寸
        .fontSize(listPrefixSize(markdownConfiguration.markdownTheme, isBullet))
        // 设置内边距属性
        .padding(left: markdownConfiguration.markdownTheme.blockMargin, right: 8.0)
        // 设置行高
        .lineHeight(listPrefixLineHeight(isBullet, markdownConfiguration))
        // 设置文本段落在水平方向的对齐方式
        .textAlign(TextAlign.Center)
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
        .margin(left: markdownConfiguration.markdownTheme.blockMargin, right: 10.0)
}

/**
 * 普通图片
 */
@Builder
func imageSpanComponent(destination: String, markdownConfiguration: MarkdownConfiguration) {
    ImageSpan(destination)
        // 设置图片的缩放类型
        .objectFit(ImageFit.Contain)
        // 设置约束尺寸
        .constraintSize(maxWidth: 100.percent)
        // 点击动作触发该方法调用
        .onClick {
            evt => imageOnClick(destination, markdownConfiguration.imageCallback)
        }
}

/**
 * HTML图片
 */
@Builder
func htmlImageSpanComponent(destination: String, imageHeight: ?Float64, imageWidth: ?Float64, markdownConfiguration: MarkdownConfiguration) {
    if (imageHeight.isSome() && imageWidth.isSome()) {
        ImageSpan(destination)
            // 设置组件自身的高度
            .height(imageHeight().px)
            // 设置组件自身的宽度
            .width(imageWidth())
            // 设置图片的缩放类型
            .objectFit(ImageFit.Contain)
            // 设置约束尺寸
            .constraintSize(maxWidth: 100.percent)
            // 点击动作触发该方法调用
            .onClick {
                evt => imageOnClick(destination, markdownConfiguration.imageCallback)
            }
    } else if (imageHeight.isSome() && !imageWidth.isSome()) {
        ImageSpan(destination)
            // 设置组件自身的高度
            .height(imageHeight().px)
            // 设置图片的缩放类型
            .objectFit(ImageFit.Contain)
            // 设置约束尺寸
            .constraintSize(maxWidth: 100.percent)
            // 点击动作触发该方法调用
            .onClick {
                evt => imageOnClick(destination, markdownConfiguration.imageCallback)
            }
    } else if (!imageHeight.isSome() && imageWidth.isSome()) {
        ImageSpan(destination)
            // 设置组件自身的宽度
            .width(imageWidth().px)
            // 设置图片的缩放类型
            .objectFit(ImageFit.Contain)
            // 设置约束尺寸
            .constraintSize(maxWidth: 100.percent)
            // 点击动作触发该方法调用
            .onClick {
                evt => imageOnClick(destination, markdownConfiguration.imageCallback)
            }
    } else if (!imageHeight.isSome() && !imageWidth.isSome()) {
        ImageSpan(destination)
            // 设置图片的缩放类型
            .objectFit(ImageFit.Contain)
            // 设置约束尺寸
            .constraintSize(maxWidth: 100.percent)
            // 点击动作触发该方法调用
            .onClick {
                evt => imageOnClick(destination, markdownConfiguration.imageCallback)
            }
    }
}
