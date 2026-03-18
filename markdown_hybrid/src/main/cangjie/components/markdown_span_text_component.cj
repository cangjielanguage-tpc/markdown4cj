/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown.components

import ohos.state_macro_manage.*

/**
 * Span控件
 *
 * @param spanMarkdownConfiguration markdown配置
 * @param nodeView NodeView
 * @param spanTocListOnClick TOC点击事件
 * @param spanFootnoteCallback 脚注点击事件
 * @param isEnd 是否是最后一条数据
 */
@Builder
func markdownSpanComponent(
    spanMarkdownConfiguration: MarkdownConfiguration,
    nodeView: NodeView,
    spanTocListOnClick: ?(Int64) -> Unit,
    spanFootnoteCallback: (String) -> Unit,
    isTableFirst: Bool,
    isEnd: Bool
) {
    if (DeviceInfo.sdkApiVersion >= 19) {
        // API大于等级19
        if (nodeView.isSubNode || nodeView.isSupNode) {
            if (isEnd) {
                // 上标或者下标
                Span(spanEndText(nodeView.nodeText)[0])
                    .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontWeight(spanFontWeight(nodeView, isTableFirst))
                    .fontStyle(spanFontStyle(nodeView))
                    .fontColor(spanFontColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(nodeView, spanMarkdownConfiguration.markdownTheme)))
                    .baselineOffset(spanBaselineOffset(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .onClick({
                        evt => spanOnClick(spanMarkdownConfiguration, nodeView, spanTocListOnClick, spanFootnoteCallback)
                    })

                // 最后一个字符
                Span(spanEndText(nodeView.nodeText)[1])
                    .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontWeight(spanFontWeight(nodeView, false))
                    .fontStyle(spanFontStyle(nodeView))
                    .fontColor(spanMarkdownConfiguration.markdownTheme.typeWriterColor)
                    .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(nodeView, spanMarkdownConfiguration.markdownTheme)))
                    .baselineOffset(spanBaselineOffset(nodeView, spanMarkdownConfiguration.markdownTheme))

            } else {
                // 上标或者下标
                Span(nodeView.nodeText)
                    .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontWeight(spanFontWeight(nodeView, isTableFirst))
                    .fontStyle(spanFontStyle(nodeView))
                    .fontColor(spanFontColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(nodeView, spanMarkdownConfiguration.markdownTheme)))
                    .baselineOffset(spanBaselineOffset(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .onClick({
                        evt => spanOnClick(spanMarkdownConfiguration, nodeView, spanTocListOnClick, spanFootnoteCallback)
                    })
            }
        } else {
            if (isEnd) {
                // 其他标签
                Span(spanEndText(nodeView.nodeText)[0])
                    .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontWeight(spanFontWeight(nodeView, isTableFirst))
                    .fontStyle(spanFontStyle(nodeView))
                    .fontColor(spanFontColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(nodeView, spanMarkdownConfiguration.markdownTheme)))
                    .lineHeight(spanLineHeight(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .onClick({
                        evt => spanOnClick(spanMarkdownConfiguration, nodeView, spanTocListOnClick, spanFootnoteCallback)
                    })

                // 最后一个字符
                Span(spanEndText(nodeView.nodeText)[1])
                    .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontWeight(spanFontWeight(nodeView, false))
                    .fontStyle(spanFontStyle(nodeView))
                    .fontColor(spanMarkdownConfiguration.markdownTheme.typeWriterColor)
                    .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(nodeView, spanMarkdownConfiguration.markdownTheme)))
                    .lineHeight(spanLineHeight(nodeView, spanMarkdownConfiguration.markdownTheme))

            } else {
                // 其他标签
                Span(nodeView.nodeText)
                    .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontWeight(spanFontWeight(nodeView, isTableFirst))
                    .fontStyle(spanFontStyle(nodeView))
                    .fontColor(spanFontColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .textBackgroundStyle(TextBackgroundStyle(color: spanBackgroundColor(nodeView, spanMarkdownConfiguration.markdownTheme)))
                    .lineHeight(spanLineHeight(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .onClick({
                        evt => spanOnClick(spanMarkdownConfiguration, nodeView, spanTocListOnClick, spanFootnoteCallback)
                    })
            }
        }
    } else {
        // API小于19
        if (nodeView.isSubNode || nodeView.isSupNode) {
            if (isEnd) {
                // 上标或者下标
                Span(spanEndText(nodeView.nodeText)[0])
                    .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontWeight(spanFontWeight(nodeView, isTableFirst))
                    .fontStyle(spanFontStyle(nodeView))
                    .fontColor(spanFontColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopStyle(true, spanBackgroundColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopBaselineOffset(CJLengthMetrics(spanLineHeight(nodeView, spanMarkdownConfiguration.markdownTheme), 1))
                    .onClick({
                        evt => spanOnClick(spanMarkdownConfiguration, nodeView, spanTocListOnClick, spanFootnoteCallback)
                    })

                // 最后一个字符
                Span(spanEndText(nodeView.nodeText)[1])
                    .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontWeight(spanFontWeight(nodeView, false))
                    .fontStyle(spanFontStyle(nodeView))
                    .fontColor(spanMarkdownConfiguration.markdownTheme.typeWriterColor)
                    .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopStyle(true, spanBackgroundColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopBaselineOffset(CJLengthMetrics(spanLineHeight(nodeView, spanMarkdownConfiguration.markdownTheme), 1))

            } else {
                // 上标或者下标
                Span(nodeView.nodeText)
                    .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontWeight(spanFontWeight(nodeView, isTableFirst))
                    .fontStyle(spanFontStyle(nodeView))
                    .fontColor(spanFontColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopStyle(true, spanBackgroundColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopBaselineOffset(CJLengthMetrics(spanLineHeight(nodeView, spanMarkdownConfiguration.markdownTheme), 1))
                    .onClick({
                        evt => spanOnClick(spanMarkdownConfiguration, nodeView, spanTocListOnClick, spanFootnoteCallback)
                    })
            }
        } else {
            if (isEnd) {
                // 其他标签
                Span(spanEndText(nodeView.nodeText)[0])
                    .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontWeight(spanFontWeight(nodeView, isTableFirst))
                    .fontStyle(spanFontStyle(nodeView))
                    .fontColor(spanFontColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopStyle(true, spanBackgroundColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopLineHeight(spanLineHeight(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .onClick({
                        evt => spanOnClick(spanMarkdownConfiguration, nodeView, spanTocListOnClick, spanFootnoteCallback)
                    })

                // 最后一个字符
                Span(spanEndText(nodeView.nodeText)[1])
                    .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontWeight(spanFontWeight(nodeView, false))
                    .fontStyle(spanFontStyle(nodeView))
                    .fontColor(spanMarkdownConfiguration.markdownTheme.typeWriterColor)
                    .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopStyle(true, spanBackgroundColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopLineHeight(spanLineHeight(nodeView, spanMarkdownConfiguration.markdownTheme))

            } else {
                // 其他标签
                Span(nodeView.nodeText)
                    .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .fontWeight(spanFontWeight(nodeView, isTableFirst))
                    .fontStyle(spanFontStyle(nodeView))
                    .fontColor(spanFontColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopStyle(true, spanBackgroundColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .interopLineHeight(spanLineHeight(nodeView, spanMarkdownConfiguration.markdownTheme))
                    .onClick({
                        evt => spanOnClick(spanMarkdownConfiguration, nodeView, spanTocListOnClick, spanFootnoteCallback)
                    })
            }
        }
    }
}
