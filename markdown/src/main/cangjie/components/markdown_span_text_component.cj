package markdown.components

import ohos.state_macro_manage.*

/**
 * Span控件
 *
 * @param spanMarkdownConfiguration markdown配置
 * @param nodeView NodeView
 * @param spanTocListOnClick TOC点击事件
 * @param spanFootnoteCallback 脚注点击事件
 */
@Builder
func markdownSpanComponent(
    spanMarkdownConfiguration: MarkdownConfiguration,
    nodeView: NodeView,
    spanTocListOnClick: ?(Int64) -> Unit,
    spanFootnoteCallback: (String) -> Unit,
    isTableFirst: Bool
) {
    if (DeviceInfo.sdkApiVersion >= 19) {
        // API大于等级19
        if (nodeView.isSubNode || nodeView.isSupNode) {
            // 上标或者下标
            Span(nodeView.nodeText)
                .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                .fontWeight(spanFontWeight(nodeView, isTableFirst, spanMarkdownConfiguration.markdownTheme))
                .fontStyle(spanFontStyle(nodeView, spanMarkdownConfiguration.markdownTheme))
                .fontColor(spanFontColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                .textBackgroundStyle(spanBackgroundColor19(nodeView, spanMarkdownConfiguration.markdownTheme))
                .baselineOffset(spanBaselineOffset(nodeView, spanMarkdownConfiguration.markdownTheme))
                .onClick({
                    evt => spanOnClick(spanMarkdownConfiguration, nodeView, spanTocListOnClick, spanFootnoteCallback)
                })
        } else {
            // 其他标签
            Span(nodeView.nodeText)
                .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                .fontWeight(spanFontWeight(nodeView, isTableFirst, spanMarkdownConfiguration.markdownTheme))
                .fontStyle(spanFontStyle(nodeView, spanMarkdownConfiguration.markdownTheme))
                .fontColor(spanFontColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                .textBackgroundStyle(spanBackgroundColor19(nodeView, spanMarkdownConfiguration.markdownTheme))
                .lineHeight(spanLineHeight(nodeView, spanMarkdownConfiguration.markdownTheme))
                .onClick({
                    evt => spanOnClick(spanMarkdownConfiguration, nodeView, spanTocListOnClick, spanFootnoteCallback)
                })
        }
    } else {
        // API小于19
        if (nodeView.isSubNode || nodeView.isSupNode) {
            // 上标或者下标
            Span(nodeView.nodeText)
                .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                .fontWeight(spanFontWeight(nodeView, isTableFirst, spanMarkdownConfiguration.markdownTheme))
                .fontStyle(spanFontStyle(nodeView, spanMarkdownConfiguration.markdownTheme))
                .fontColor(spanFontColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                .interopStyle(true, spanBackgroundColor18(nodeView, spanMarkdownConfiguration.markdownTheme))
                .interopBaselineOffset(CJLengthMetrics(spanLineHeight(nodeView, spanMarkdownConfiguration.markdownTheme), 1))
                .onClick({
                    evt => spanOnClick(spanMarkdownConfiguration, nodeView, spanTocListOnClick, spanFootnoteCallback)
                })
        } else {
            // 其他标签
            Span(nodeView.nodeText)
                .fontFamily(spanFontFamily(nodeView, spanMarkdownConfiguration.markdownTheme))
                .fontSize(spanFontSize(nodeView, spanMarkdownConfiguration.markdownTheme))
                .fontWeight(spanFontWeight(nodeView, isTableFirst, spanMarkdownConfiguration.markdownTheme))
                .fontStyle(spanFontStyle(nodeView, spanMarkdownConfiguration.markdownTheme))
                .fontColor(spanFontColor(nodeView, spanMarkdownConfiguration.markdownTheme))
                .letterSpacing(spanLetterSpacing(nodeView, spanMarkdownConfiguration.markdownTheme))
                .interopDecorationStyle(spanDecoration(nodeView, spanMarkdownConfiguration.markdownTheme))
                .interopStyle(true, spanBackgroundColor18(nodeView, spanMarkdownConfiguration.markdownTheme))
                .interopLineHeight(spanLineHeight(nodeView, spanMarkdownConfiguration.markdownTheme))
                .onClick({
                    evt => spanOnClick(spanMarkdownConfiguration, nodeView, spanTocListOnClick, spanFootnoteCallback)
                })
        }
    }
}
