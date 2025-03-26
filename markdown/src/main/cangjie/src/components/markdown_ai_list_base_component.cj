/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 段落
 */
@Builder
func listParagraphINCComponent(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, componentWidth: Float64) {
    MarkdownAIParagraphComponent(
        markdownAIConfiguration: markdownAIConfiguration,
        nodeViews: nodeView.children,
        marginTop: 0.0,
        marginBottom: 0.0,
        componentWidth: componentWidth
    )
}

/**
 * 标题
 */
@Builder
func listHeadingINCComponent(nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, componentWidth: Float64) {
    MarkdownAIHeadingComponent(
        markdownAIConfiguration: markdownAIConfiguration,
        nodeViews: nodeView.children,
        level : (nodeView.node as Heading)().getLevel(),
        marginTop: 0.0,
        marginBottom: 0.0,
        componentWidth: componentWidth
    )
}

/**
 * 围栏代码、缩进代码
 */
@Builder
func listCodeBlockINCComponent(codeText: String, infos: ?String, nodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, isFull: Bool) {
    if (isFull) {
        if(nodeView.node is IndentedCodeBlock){
            MarkdownAIFencedCodeBlockComponent(
                markdownAIConfiguration: markdownAIConfiguration,
                codeText: (nodeView.node as IndentedCodeBlock)().getLiteral(),
                info: Option<String>.None,
                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
            )
        } else if(nodeView.node is FencedCodeBlock){
            MarkdownAIFencedCodeBlockComponent(
                markdownAIConfiguration: markdownAIConfiguration,
                codeText: (nodeView.node as FencedCodeBlock)().getLiteral(),
                info: (nodeView.node as FencedCodeBlock)().getInfo(),
                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
            )
        }
    } else {
        MarkdownAIIndentedCodeBlockComponent(
            markdownAIConfiguration: markdownAIConfiguration,
            codeText: codeText,
            codeItem: nodeView,
            info: infos,
            marginTop: 0.0,
            marginBottom: 0.0
        )
    }
}

/**
 * 表格
 */
@Builder
func listTableBlockINCComponent(tableNodeView: NodeView, markdownAIConfiguration: MarkdownAIConfiguration, componentWidth: Float64, isFull: Bool) {
    MarkdownAITableBlockComponent(
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
    if (isClosed) {
        // 结束显示数学公式
        MarkdownAILatexMathBlockComponent(
            markdownAIConfiguration: markdownAIConfiguration,
            latexStr: latexStr,
            marginTop: 0.0,
            marginBottom: 0.0
        )
    } else {
        // 没结束显示纯文本
        Text(latexStr)
    }
}
