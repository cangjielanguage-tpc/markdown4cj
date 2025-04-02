/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown段落自定义页面
 */
@Component
class MarkdownAIParagraphComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 段落内容数据
     */
    var nodeViews: ArrayList<NodeView>

    /**
     * 脚注
     */
    var footnoteBlock: Option<FootnoteBlock> = Option<FootnoteBlock>.None

    /**
     * 上边距 - 单位vp
     */
    var marginTop: Float64

    /**
     * 下边距 - 单位vp
     */
    var marginBottom: Float64

    /**
     * 控件宽度 - 单位px
     */
    var componentWidth: Float64

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    func build() {
        Text() {
            if(footnoteBlock.isSome()){
                Span("[^${footnoteBlock().noteid}]")
                    // 设置文本尺寸
                    .fontSize(markdownAIConfiguration.markdownAITheme.paragraphTextSize)
                    // 设置文本的字体粗细
                    .fontWeight(FontWeight.W400)
                    // 设置文本颜色
                    .fontColor(markdownAIConfiguration.markdownAITheme.paragraphTextColor)
            }
            ForEach(
                nodeViews,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText || item.node is Footnote) {
                        // 文本或者脚注
                        paragraphTextComponent(item, markdownAIConfiguration, fontCallback)
                    } else if (item.node is Code) {
                        // 内联代码
                        paragraphCodeComponent(item, markdownAIConfiguration)
                    } else if (item.node is HardLineBreak) {
                        // 硬换行
                        Span("\n")
                    } else if (item.node is SoftLineBreak) {
                        // 软换行
                        Span(spanSoftLineBreak(markdownAIConfiguration.markdownAITheme.isLineBreak))
                    } else if (item.node is CommonmarkImage) {
                        // 图片节点
                        MarkdownAIImageSpanComponent(
                            markdownAIConfiguration: markdownAIConfiguration,
                            destination: (item.node as CommonmarkImage)().getDestination()
                        )
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        MarkdownAILatexImageSpanComponent(
                            markdownAIConfiguration: markdownAIConfiguration,
                            componentWidth: componentWidth,
                            strLatexMath: (item.node as LatexMathNode)().latex
                        )
                    } else if (item.node is ImageHtmlNode) {
                        // HTML图片
                        MarkdownAIHtmlImageSpanComponent(
                            markdownAIConfiguration: markdownAIConfiguration,
                            destination: (item.node as ImageHtmlNode)().getDestination(),
                            strHeight: (item.node as ImageHtmlNode)().getHeight(),
                            strWidth: (item.node as ImageHtmlNode)().getWidth()
                        )
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                }
            )
        }
        // 设置多行文本的文本对齐方式
        .textAlign(TextAlign.Start)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置行高
        .lineHeight(22.0)
    }
}
