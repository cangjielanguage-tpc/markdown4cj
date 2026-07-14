package markdown.components

import ohos.state_macro_manage.*

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)自定义控件
 */
@Component
class MarkdownListItemComponent {
    var listItemMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    @Watch[refreshListItemData]
    var listItemNodeView: NodeView // 列表节点
    @Prop
    var listItemComponentWidth: Float64 // 控件宽度 - 单位vp
    @Prop
    var listItemTableBlockComponentWidth: Float64 // 表格控件宽度 - 单位vp
    @BuilderParam
    var listItemAdBuilder: (NodeView) -> Unit // 广告布局
    @BuilderParam
    var listItemVideoBuilder: (NodeView, MarkdownTheme, (String) -> Unit, (String, (String, Float64, Int64) -> Unit) -> Unit, ?(String) -> Unit, ?(String) -> Unit) -> Unit // 视频布局
    @BuilderParam
    var listItemAudioBuilder: (NodeView, MarkdownTheme, ?(String) -> Unit) -> Unit // 音频布局
    @BuilderParam
    var listItemCustomBlockBuilder: (NodeView, Int64) -> Unit // 自定义块结构布局
    @BuilderParam
    var listItemCustomHeadingLineBuilder: (NodeView, Int64) -> Unit // 自定义行内标题布局
    @BuilderParam
    var listItemCustomParagraphLineBuilder: (NodeView, Int64) -> Unit // 自定义行内段落布局
    @BuilderParam
    var listItemCustomTableLineBuilder: (NodeView, Int64) -> Unit // 自定义行内表格布局
    var listItemFootnoteCallback: (String) -> Unit // 脚注点击事件
    var listItemTocListOnClick: (Int64) -> Unit // TOC列表点击事件回调
    var listItemImageCallback: (String) -> Unit // 图片点击事件
    var listItemVideoCallback: (String) -> Unit // 视频点击事件
    var listItemDepth: Int64 // 列表深度
    var listItemNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>()) // 懒加载数据源

    protected override func aboutToAppear(): Unit {
        refreshListItemData() // 初始化刷新数据
    }

    func build() {
        List(space: listChildChildSpacing(listItemMarkdownConfiguration.markdownTheme, listItemNodeView)) {
            LazyForEach(
                listItemNodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 =>  ListItem() {
                        if (item.nodeType == "Paragraph") {
                            // 段落
                            MarkdownParagraphComponent(
                                paragraphMarkdownConfiguration: listItemMarkdownConfiguration,
                                paragraphNodeView: item,
                                paragraphComponentWidth: listItemComponentWidth,
                                paragraphCustomParagraphLineBuilder: listItemCustomParagraphLineBuilder,
                                paragraphTocListOnClick: listItemTocListOnClick,
                                paragraphImageCallback: listItemImageCallback,
                                paragraphFootnoteCallback: listItemFootnoteCallback
                            )
                        } else if (item.nodeType == "Heading" || item.nodeType == "IdHeading") {
                            // 标题/标题ID
                            MarkdownHeadingComponent(
                                headingMarkdownConfiguration: listItemMarkdownConfiguration,
                                headingNodeView: item,
                                headingComponentWidth: listItemComponentWidth,
                                headingCustomHeadingLineBuilder: listItemCustomHeadingLineBuilder,
                                headingImageCallback: listItemImageCallback,
                                headingFootnoteCallback: listItemFootnoteCallback
                            )
                        } else if (item.nodeType == "FencedCodeBlockListBlock") {
                            // 围栏代码块列表
                            blockCodeBlockListComponent(
                                listItemMarkdownConfiguration,
                                item,
                                toCodeList(item)
                            )
                        } else if (item.nodeType == "FencedCodeBlock") {
                            // 围栏代码块
                            MarkdownCodeFencedBlockComponent(
                                markdownConfiguration: listItemMarkdownConfiguration,
                                codeText: item.nodeText,
                                info: item.codeInfo(),
                                nodeHash: item.nodeHash
                            )
                        } else if (item.nodeType == "IndentedCodeBlock") {
                            // 缩进代码块
                            MarkdownCodeIndentedBlockComponent(
                                markdownConfiguration: listItemMarkdownConfiguration,
                                codeText: item.nodeText,
                                nodeHash: item.nodeHash
                            )
                        } else if (item.nodeType == "BulletList") {
                            // 无序列表
                            MarkdownListComponent(
                                listMarkdownConfiguration: listItemMarkdownConfiguration,
                                listNodeView: item,
                                listComponentWidth: listItemComponentWidth,
                                listTableBlockComponentWidth: listItemTableBlockComponentWidth,
                                isOrdered: false,
                                listAdBuilder: listItemAdBuilder,
                                listVideoBuilder: listItemVideoBuilder,
                                listAudioBuilder: listItemAudioBuilder,
                                listCustomBlockBuilder: listItemCustomBlockBuilder,
                                listCustomHeadingLineBuilder: listItemCustomHeadingLineBuilder,
                                listCustomParagraphLineBuilder: listItemCustomParagraphLineBuilder,
                                listCustomTableLineBuilder: listItemCustomTableLineBuilder,
                                listFootnoteCallback: listItemFootnoteCallback,
                                listTocListOnClick: listItemTocListOnClick,
                                listImageCallback: listItemImageCallback,
                                listVideoCallback: listItemVideoCallback,
                                listDepth: listItemDepth + 1
                            )
                        } else if (item.nodeType == "OrderedList") {
                            // 有序列表
                            MarkdownListComponent(
                                listMarkdownConfiguration: listItemMarkdownConfiguration,
                                listNodeView: item,
                                listComponentWidth: listItemComponentWidth,
                                listTableBlockComponentWidth: listItemTableBlockComponentWidth,
                                isOrdered: true,
                                listAdBuilder: listItemAdBuilder,
                                listVideoBuilder: listItemVideoBuilder,
                                listAudioBuilder: listItemAudioBuilder,
                                listCustomBlockBuilder: listItemCustomBlockBuilder,
                                listCustomHeadingLineBuilder: listItemCustomHeadingLineBuilder,
                                listCustomParagraphLineBuilder: listItemCustomParagraphLineBuilder,
                                listCustomTableLineBuilder: listItemCustomTableLineBuilder,
                                listFootnoteCallback: listItemFootnoteCallback,
                                listTocListOnClick: listItemTocListOnClick,
                                listImageCallback: listItemImageCallback,
                                listVideoCallback: listItemVideoCallback,
                                listDepth: listItemDepth + 1
                            )
                        } else if (item.nodeType == "BlockQuote") {
                            // 块引用
                            MarkdownQuoteComponent(
                                quoteMarkdownConfiguration: listItemMarkdownConfiguration,
                                quoteNodeView: item,
                                quoteComponentWidth: listItemComponentWidth,
                                quoteTableBlockComponentWidth: listItemTableBlockComponentWidth,
                                quoteAdBuilder: listItemAdBuilder,
                                quoteVideoBuilder: listItemVideoBuilder,
                                quoteAudioBuilder: listItemAudioBuilder,
                                quoteCustomBlockBuilder: listItemCustomBlockBuilder,
                                quoteCustomHeadingLineBuilder: listItemCustomHeadingLineBuilder,
                                quoteCustomParagraphLineBuilder: listItemCustomParagraphLineBuilder,
                                quoteCustomTableLineBuilder: listItemCustomTableLineBuilder,
                                quoteFootnoteCallback: listItemFootnoteCallback,
                                quoteTocListOnClick: listItemTocListOnClick,
                                quoteImageCallback: listItemImageCallback,
                                quoteVideoCallback: listItemVideoCallback,
                                quoteDepth: listItemDepth + 1
                            )
                        } else if (item.nodeType == "LatexMathBlock") {
                            // 数学公式块
                            MarkdownLatexMathBlockComponent(
                                markdownTheme: listItemMarkdownConfiguration.markdownTheme,
                                latexMathBlockStr: item.nodeText,
                                latexImageCallback: listItemMarkdownConfiguration.latexImageCallback,
                                latexStrCallback: listItemMarkdownConfiguration.latexStrCallback
                            )
                        } else if (item.nodeType == "TableBlock") {
                            // 表格
                            MarkdownTableBlockComponent(
                                tableBlockMarkdownConfiguration: listItemMarkdownConfiguration,
                                tableBlockNodeView: item,
                                tableBlockComponentWidth: listItemTableBlockComponentWidth,
                                tableBlockCustomTableLineBuilder: listItemCustomTableLineBuilder,
                                tableBlockImageCallback: listItemImageCallback,
                                tableBlockFootnoteCallback: listItemFootnoteCallback
                            )
                        } else if (item.nodeType == "ThematicBreak") {
                            // 分割线
                            MarkdownThematicBreakComponent(markdownTheme: listItemMarkdownConfiguration.markdownTheme)
                        } else if (item.nodeType == "FootnoteBlock") {
                            // 脚注
                            MarkdownFootnoteComponent(
                                footnoteMarkdownConfiguration: listItemMarkdownConfiguration,
                                footnoteNodeView: item,
                                footnoteComponentWidth: listItemComponentWidth,
                                footnoteCustomParagraphLineBuilder: listItemCustomParagraphLineBuilder,
                                footnoteTocListOnClick: listItemTocListOnClick,
                                footnoteImageCallback: listItemImageCallback,
                                footnoteFootnoteCallback: listItemFootnoteCallback
                            )
                        } else if (item.nodeType == "SlideBlock") {
                            // 图片幻灯片
                            MarkdownBannerComponent(
                                markdownTheme: listItemMarkdownConfiguration.markdownTheme,
                                nodeView: item,
                                imageCallback: listItemImageCallback
                            )
                        } else if (item.nodeType == "BlockVideo") {
                            // 视频
                            listItemVideoBuilder(
                                item,
                                listItemMarkdownConfiguration.markdownTheme,
                                listItemVideoCallback,
                                listItemMarkdownConfiguration.videoImageCallback,
                                listItemMarkdownConfiguration.videoReleaseCallback,
                                listItemMarkdownConfiguration.videoDownloadCallback
                            )
                        } else if (item.nodeType == "BlockAudio") {
                            // 音频
                            listItemAudioBuilder(
                                item,
                                listItemMarkdownConfiguration.markdownTheme,
                                listItemMarkdownConfiguration.audioCallback
                            )
                        } else if (item.nodeType == "BlockAD") {
                            // 广告
                            listItemAdBuilder(item)
                        } else {
                            // 其他
                            listItemCustomBlockBuilder(
                                item,
                                idx
                            )
                        }
                    }
                },
                keyGeneratorFunc: {
                    listItemNodeView: NodeView, idx: Int64 => return "${idx}-${listItemNodeView.nodeHash}-${listItemNodeView.contentHash}"
                }
            )
        }
        .listDirection(Axis.Vertical)
        .alignListItem(ListItemAlign.Start)
        .layoutWeight(1)
    }

    /**
     * 数据刷新
     * 通过smartUpdateDataArray驱动UI更新，无需页面缓存。
     * keyGenerator含contentHash，hash变化时框架自动重建对应组件。
     */
    public func refreshListItemData(): Unit {
        let refreshNodeViewChildren = this.listItemNodeView.children // 子节点数据
        if (refreshNodeViewChildren.size == 0) {
            listItemNodeViewDataSource.clear()
            return
        }
        listItemNodeViewDataSource.smartUpdateDataArray(refreshNodeViewChildren)
    }
}
