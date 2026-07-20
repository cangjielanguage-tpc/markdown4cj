package markdown.components

import ohos.state_macro_manage.*

/**
 * Markdown块引用自定义控件
 */
@Component
public class MarkdownQuoteComponent {
    @Prop
    var quoteMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var quoteNodeView: NodeView // 列表节点
    @Prop
    var quoteComponentWidth: Float64 // 控件宽度 - 单位vp
    @Prop
    var quoteTableBlockComponentWidth: Float64 // 表格控件宽度 - 单位vp
    @BuilderParam
    var quoteAdBuilder: (NodeView) -> Unit = ADBuilder // 自定义广告块结构布局
    @BuilderParam
    var quoteVideoBuilder: (NodeView, MarkdownTheme, (String) -> Unit, (String, (String, Float64, Int64) -> Unit) -> Unit, ?(String) -> Unit, ?(String) -> Unit) -> Unit // 自定义视频块结构布局
    @BuilderParam
    var quoteAudioBuilder: (NodeView, MarkdownTheme, ?(String) -> Unit) -> Unit // 自定义音频块结构布局
    @BuilderParam
    var quoteCustomBlockBuilder: (NodeView, Int64) -> Unit // 自定义块结构布局
    @BuilderParam
    var quoteCustomHeadingLineBuilder: (NodeView, Int64) -> Unit // 自定义行内标题布局
    @BuilderParam
    var quoteCustomParagraphLineBuilder: (NodeView, Int64) -> Unit // 自定义行内段落布局
    @BuilderParam
    var quoteCustomTableLineBuilder: (NodeView, Int64) -> Unit // 自定义行内表格布局
    var quoteFootnoteCallback: (String) -> Unit // 脚注点击事件
    var quoteTocListOnClick: (Int64) -> Unit // TOC列表点击事件回调
    var quoteImageCallback: (String) -> Unit // 图片点击事件
    var quoteVideoCallback: (String) -> Unit // 视频点击事件
    var quoteDepth: Int64 // 列表深度
    @State
    var quoteNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>()) // 懒加载数据源

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(quoteNodeView.nodeHash, refreshQuoteData)
        refreshQuoteData(quoteNodeView)
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(quoteNodeView.nodeHash)
    }

    func build() {
        List(space: quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteChildSpacing) {
            LazyForEach(
                quoteNodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        if (item.nodeType == "Paragraph") {
                            // 段落
                            MarkdownParagraphComponent(
                                paragraphMarkdownConfiguration: quoteMarkdownConfiguration,
                                paragraphNodeView: item,
                                paragraphComponentWidth: quoteComponentWidth,
                                paragraphCustomParagraphLineBuilder: quoteCustomParagraphLineBuilder,
                                paragraphTocListOnClick: quoteTocListOnClick,
                                paragraphImageCallback: quoteImageCallback,
                                paragraphFootnoteCallback: quoteFootnoteCallback
                            )
                        } else if (item.nodeType == "Heading" || item.nodeType == "IdHeading") {
                            // 标题/标题ID
                            MarkdownHeadingComponent(
                                headingMarkdownConfiguration: quoteMarkdownConfiguration,
                                headingNodeView: item,
                                headingComponentWidth: quoteComponentWidth,
                                headingCustomHeadingLineBuilder: quoteCustomHeadingLineBuilder,
                                headingImageCallback: quoteImageCallback,
                                headingFootnoteCallback: quoteFootnoteCallback
                            )
                        } else if (item.nodeType == "FencedCodeBlockListBlock") {
                            // 围栏代码块列表
                            blockCodeBlockListComponent(
                                quoteMarkdownConfiguration,
                                item,
                                toCodeList(item)
                            )
                        } else if (item.nodeType == "FencedCodeBlock") {
                            // 围栏代码块
                            MarkdownCodeFencedBlockComponent(
                                markdownConfiguration: quoteMarkdownConfiguration,
                                codeText: item.nodeText,
                                info: item.codeInfo(),
                                nodeHash: item.nodeHash
                            )
                        } else if (item.nodeType == "IndentedCodeBlock") {
                            // 缩进代码块
                            MarkdownCodeIndentedBlockComponent(
                                markdownConfiguration: quoteMarkdownConfiguration,
                                codeText: item.nodeText,
                                nodeHash: item.nodeHash
                            )
                        } else if (item.nodeType == "BulletList") {
                            // 无序列表
                            MarkdownListComponent(
                                listMarkdownConfiguration: quoteMarkdownConfiguration,
                                listNodeView: item,
                                listComponentWidth: quoteComponentWidth,
                                listTableBlockComponentWidth: quoteTableBlockComponentWidth,
                                isOrdered: false,
                                listAdBuilder: quoteAdBuilder,
                                listVideoBuilder: quoteVideoBuilder,
                                listAudioBuilder: quoteAudioBuilder,
                                listCustomBlockBuilder: quoteCustomBlockBuilder,
                                listCustomHeadingLineBuilder: quoteCustomHeadingLineBuilder,
                                listCustomParagraphLineBuilder: quoteCustomParagraphLineBuilder,
                                listCustomTableLineBuilder: quoteCustomTableLineBuilder,
                                listFootnoteCallback: quoteFootnoteCallback,
                                listTocListOnClick: quoteTocListOnClick,
                                listImageCallback: quoteImageCallback,
                                listVideoCallback: quoteVideoCallback,
                                listDepth: quoteDepth + 1
                            )
                        } else if (item.nodeType == "OrderedList") {
                            // 有序列表
                            MarkdownListComponent(
                                listMarkdownConfiguration: quoteMarkdownConfiguration,
                                listNodeView: item,
                                listComponentWidth: quoteComponentWidth,
                                listTableBlockComponentWidth: quoteTableBlockComponentWidth,
                                isOrdered: true,
                                listAdBuilder: quoteAdBuilder,
                                listVideoBuilder: quoteVideoBuilder,
                                listAudioBuilder: quoteAudioBuilder,
                                listCustomBlockBuilder: quoteCustomBlockBuilder,
                                listCustomHeadingLineBuilder: quoteCustomHeadingLineBuilder,
                                listCustomParagraphLineBuilder: quoteCustomParagraphLineBuilder,
                                listCustomTableLineBuilder: quoteCustomTableLineBuilder,
                                listFootnoteCallback: quoteFootnoteCallback,
                                listTocListOnClick: quoteTocListOnClick,
                                listImageCallback: quoteImageCallback,
                                listVideoCallback: quoteVideoCallback,
                                listDepth: quoteDepth + 1
                            )
                        } else if (item.nodeType == "BlockQuote") {
                            // 块引用
                            MarkdownQuoteComponent(
                                quoteMarkdownConfiguration: quoteMarkdownConfiguration,
                                quoteNodeView: item,
                                quoteComponentWidth: quoteComponentWidth,
                                quoteTableBlockComponentWidth: quoteTableBlockComponentWidth,
                                quoteAdBuilder: quoteAdBuilder,
                                quoteVideoBuilder: quoteVideoBuilder,
                                quoteAudioBuilder: quoteAudioBuilder,
                                quoteCustomBlockBuilder: quoteCustomBlockBuilder,
                                quoteCustomHeadingLineBuilder: quoteCustomHeadingLineBuilder,
                                quoteCustomParagraphLineBuilder: quoteCustomParagraphLineBuilder,
                                quoteCustomTableLineBuilder: quoteCustomTableLineBuilder,
                                quoteFootnoteCallback: quoteFootnoteCallback,
                                quoteTocListOnClick: quoteTocListOnClick,
                                quoteImageCallback: quoteImageCallback,
                                quoteVideoCallback: quoteVideoCallback,
                                quoteDepth: quoteDepth + 1
                            )
                        } else if (item.nodeType == "LatexMathBlock") {
                            // 数学公式块
                            MarkdownLatexMathBlockComponent(
                                markdownTheme: quoteMarkdownConfiguration.markdownTheme,
                                latexMathBlockStr: item.nodeText,
                                latexImageCallback: quoteMarkdownConfiguration.latexImageCallback,
                                latexStrCallback: quoteMarkdownConfiguration.latexStrCallback
                            )
                        } else if (item.nodeType == "TableBlock") {
                            // 表格
                            MarkdownTableBlockComponent(
                                tableBlockMarkdownConfiguration: quoteMarkdownConfiguration,
                                tableBlockNodeView: item,
                                tableBlockComponentWidth: quoteTableBlockComponentWidth,
                                tableBlockCustomTableLineBuilder: quoteCustomTableLineBuilder,
                                tableBlockImageCallback: quoteImageCallback,
                                tableBlockFootnoteCallback: quoteFootnoteCallback
                            )
                        } else if (item.nodeType == "ThematicBreak") {
                            // 分割线
                            MarkdownThematicBreakComponent(markdownTheme: quoteMarkdownConfiguration.markdownTheme)
                        } else if (item.nodeType == "FootnoteBlock") {
                            // 脚注
                            MarkdownFootnoteComponent(
                                footnoteMarkdownConfiguration: quoteMarkdownConfiguration,
                                footnoteNodeView: item,
                                footnoteComponentWidth: quoteComponentWidth,
                                footnoteCustomParagraphLineBuilder: quoteCustomParagraphLineBuilder,
                                footnoteTocListOnClick: quoteTocListOnClick,
                                footnoteImageCallback: quoteImageCallback,
                                footnoteFootnoteCallback: quoteFootnoteCallback
                            )
                        } else if (item.nodeType == "SlideBlock") {
                            // 图片幻灯片
                            MarkdownBannerComponent(
                                markdownTheme: quoteMarkdownConfiguration.markdownTheme,
                                nodeView: item,
                                imageCallback: quoteImageCallback
                            )
                        } else if (item.nodeType == "BlockVideo") {
                            // 视频
                            quoteVideoBuilder(
                                item,
                                quoteMarkdownConfiguration.markdownTheme,
                                quoteVideoCallback,
                                quoteMarkdownConfiguration.videoImageCallback,
                                quoteMarkdownConfiguration.videoReleaseCallback,
                                quoteMarkdownConfiguration.videoDownloadCallback
                            )
                        } else if (item.nodeType == "BlockAudio") {
                            // 音频
                            quoteAudioBuilder(
                                item,
                                quoteMarkdownConfiguration.markdownTheme,
                                quoteMarkdownConfiguration.audioCallback
                            )
                        } else if (item.nodeType == "BlockAD") {
                            // 广告
                            quoteAdBuilder(item)
                        } else {
                            // 其他
                            quoteCustomBlockBuilder(
                                item,
                                idx
                            )
                        }
                    }
                    .layoutWeight(1)
                },
                keyGeneratorFunc: {
                    quoteNodeView: NodeView, idx: Int64 => return "${idx}-${quoteNodeView.nodeHash}-${quoteNodeView.contentHash}"
                }
            )
        }
        .listDirection(Axis.Vertical)
        .alignListItem(ListItemAlign.Start)
        .backgroundColor(quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteBackgroundColor)
        .borderRadius(
            topLeft: quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteRadiusTopLeft,
            topRight: quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteRadiusTopRight,
            bottomLeft: quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteRadiusBottomLeft,
            bottomRight: quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteRadiusBottomRight
        )
        .borderWidth(EdgeWidths(left: quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteLeftBorderWidth.vp))
        .borderColor(quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteLeftBorderColor)
        .padding(
            top: quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuotePaddingTop,
            right: quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuotePaddingRight,
            bottom: quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuotePaddingBottom,
            left: quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuotePaddingLeft
        )
        .margin(
            top: quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteMarginTop,
            right: quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteMarginRight,
            bottom: quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteMarginBottom,
            left: quoteMarkdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteMarginLeft
        )
    }

    /**
     * 数据刷新
     * 通过smartUpdateDataArray驱动UI更新，无需页面缓存。
     * keyGenerator含contentHash，hash变化时框架自动重建对应组件。
     */
    public func refreshQuoteData(newNodeView: NodeView): Unit {
        this.quoteNodeView = newNodeView
        let refreshNodeViewChildren = quoteNodeView.children // 子节点数据
        if (refreshNodeViewChildren.size == 0) {
            quoteNodeViewDataSource.clear()
            return
        }
        quoteNodeViewDataSource.smartUpdateDataArray(refreshNodeViewChildren)
    }
}
