/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

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
        .padding(left: markdownAIConfiguration.markdownAITheme.blockMargin, right: 10.0)
        .lineHeight(22.0)
        .textAlign(TextAlign.Center)
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
        .margin(left: markdownAIConfiguration.markdownAITheme.blockMargin, right: 10.0)
}

/**
 * 段落
 */
@Builder
func listParagraphINCComponent(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration,
    componentWidth: Float64) {
    MarkdownAIParagraphComponent(
        paragraphNodeView: nodeView,
        markdownAIConfiguration: markdownAIConfiguration,
        marginTop: 0.0,
        marginBottom: 0.0,
        componentWidth: componentWidth
    )
}

/**
 * 标题
 */
@Builder
func listHeadingINCComponent(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration,
    componentWidth: Float64) {
    MarkdownAIHeadingComponent(
        headingNodeView: nodeView,
        markdownAIConfiguration: markdownAIConfiguration,
        marginTop: 0.0,
        marginBottom: 0.0,
        componentWidth: componentWidth
    )
}

/**
 * 围栏代码、缩进代码
 */
@Builder
func listCodeBlockINCComponent(codeText: String, infos: ?String, nodeView: NodeView,
    markdownAIConfiguration: MarkdownAIConfiguration) {
    MarkdownAIIndentedCodeBlockComponent(
        markdownAIConfiguration: markdownAIConfiguration,
        codeText: codeText,
        codeItem: nodeView,
        info: infos,
        marginTop: 0.0,
        marginBottom: 0.0
    )
}

/**
 * 表格
 */
@Builder
func listTableBlockINCComponent(tableNodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration,
    componentWidth: Float64, isFull: Bool) {
    MarkdownTableBlockINCComponent(
        tableNodeView: tableNodeView,
        markdownAIConfiguration: markdownAIConfiguration,
        marginTop: 0.0,
        marginBottom: 0.0,
        componentWidth: componentWidth,
        isFull: isFull
    )
}

/**
 * 单行的数学公式
 */
@Builder
func listLatexMathBlockINCComponent(latexStr: String, isClosed: Bool, markdownAIConfiguration: MarkdownAIConfiguration) {
    MarkdownAILatexMathBlockComponent(
        latexStr: latexStr,
        isClosed: isClosed,
        markdownAIConfiguration: markdownAIConfiguration,
        marginTop: 0.0,
        marginBottom: 0.0
    )
}
