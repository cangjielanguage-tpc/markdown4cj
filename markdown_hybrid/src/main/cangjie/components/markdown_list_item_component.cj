package markdown.components

import ohos.state_macro_manage.*

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)自定义控件
 */
@Component
class MarkdownListItemComponent {
    var listItemMarkdownConfiguration: MarkdownConfiguration // markdown配置
    var listItemNodeView: NodeView // 列表节点
    @Prop
    var listItemComponentWidth: Float64 // 控件宽度 - 单位vp
    @Prop
    var listItemTableBlockComponentWidth: Float64 // 表格控件宽度 - 单位vp
    var listItemMarkdownCacheConfiguration: MarkdownCacheConfiguration // 缓存的数据
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
        refreshListItemData(listItemNodeView) // 初始化刷新数据
        listItemMarkdownCacheConfiguration.listItemComponents.add(listItemNodeView.nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = listItemMarkdownCacheConfiguration.listItemComponents.get(listItemNodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                listItemMarkdownCacheConfiguration.listItemComponents.remove(listItemNodeView.nodeHash)
            }
        } else {
            listItemMarkdownCacheConfiguration.listItemComponents.remove(listItemNodeView.nodeHash)
        }
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
                                paragraphComponents: listItemMarkdownCacheConfiguration.paragraphComponents,
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
                                headingComponents: listItemMarkdownCacheConfiguration.headingComponents,
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
                                nodeHash: item.nodeHash,
                                fencedCodeComponents: listItemMarkdownCacheConfiguration.fencedCodeComponents
                            )
                        } else if (item.nodeType == "IndentedCodeBlock") {
                            // 缩进代码块
                            MarkdownCodeIndentedBlockComponent(
                                markdownConfiguration: listItemMarkdownConfiguration,
                                codeText: item.nodeText,
                                nodeHash: item.nodeHash,
                                indentedCodeComponents: listItemMarkdownCacheConfiguration.indentedCodeComponents
                            )
                        } else if (item.nodeType == "BulletList") {
                            // 无序列表
                            MarkdownListComponent(
                                listMarkdownConfiguration: listItemMarkdownConfiguration,
                                listNodeView: item,
                                listComponentWidth: listItemComponentWidth,
                                listTableBlockComponentWidth: listItemTableBlockComponentWidth,
                                listMarkdownCacheConfiguration: listItemMarkdownCacheConfiguration,
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
                                listMarkdownCacheConfiguration: listItemMarkdownCacheConfiguration,
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
                                quoteMarkdownCacheConfiguration: listItemMarkdownCacheConfiguration,
                                quoteFootnoteCallback: listItemFootnoteCallback,
                                quoteTocListOnClick: listItemTocListOnClick,
                                quoteImageCallback: listItemImageCallback,
                                quoteVideoCallback: listItemVideoCallback,
                                quoteDepth: listItemDepth + 1
                            )
                        } else if (item.nodeType == "TableBlock") {
                            // 表格
                            MarkdownTableBlockComponent(
                                tableBlockMarkdownConfiguration: listItemMarkdownConfiguration,
                                tableBlockNodeView: item,
                                tableBlockComponentWidth: listItemTableBlockComponentWidth,
                                tableComponents: listItemMarkdownCacheConfiguration.tableComponents,
                                tableRowComponents: listItemMarkdownCacheConfiguration.tableRowComponents,
                                tableCellComponents: listItemMarkdownCacheConfiguration.tableCellComponents,
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
                                footnoteMarkdownCacheConfiguration: listItemMarkdownCacheConfiguration,
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
     */
    public func refreshListItemData(listItemNodeView: NodeView): Unit {
        this.listItemNodeView = listItemNodeView
        let refreshNodeViewChildren = listItemNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = listItemNodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            listItemNodeViewDataSource.clear()
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            refreshListItemDatas(dataSourceSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                listItemNodeViewDataSource.addData(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            refreshListItemDatas(dataSourceSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
        } else {
            // 新数据小于页面数据
            refreshListItemDatas(refreshNodeViewSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                listItemNodeViewDataSource.deleteData(i)
            }
        }
    }

    /**
     * 循环判断历史数据有没有做过修改
     *
     * @param size 长度
     * @param refreshNodeViews 刷新的数据
     */
    func refreshListItemDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = listItemNodeViewDataSource.getData(i)
            let newNodeHash = refreshNodeView.nodeHash
            let oldNodeHash = dataSourceNode.nodeHash
            if (newNodeHash != oldNodeHash) {
                // 自身节点唯一ID不相同需要刷新数据
                listItemNodeViewDataSource.replaceData(i, refreshNodeView)
                continue
            }
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            if (newContentHash != oldContentHash) {
                // 子节点唯一ID不相同需要刷新子节点数据
                if (refreshNodeView.nodeType == "Paragraph") {
                    // 段落节点
                    let paragraphComponents = listItemMarkdownCacheConfiguration.paragraphComponents
                    let cache = paragraphComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshParagraphData(refreshNodeView)
                        listItemNodeViewDataSource.update(i, refreshNodeView)
                    } else {
                        listItemNodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "Heading" || refreshNodeView.nodeType == "IdHeading") {
                    // 标题节点
                    let headingComponents = listItemMarkdownCacheConfiguration.headingComponents
                    let cache = headingComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshHeadingData(refreshNodeView)
                        listItemNodeViewDataSource.update(i, refreshNodeView)
                    } else {
                        listItemNodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "FencedCodeBlock") {
                    // 围栏代码块节点
                    let fencedCodeComponents = listItemMarkdownCacheConfiguration.fencedCodeComponents
                    let cache = fencedCodeComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(refreshNodeView.nodeText, refreshNodeView.codeInfo(), refreshNodeView.nodeHash)
                        listItemNodeViewDataSource.update(i, refreshNodeView)
                    } else {
                        listItemNodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "IndentedCodeBlock") {
                    // 缩进代码块节点
                    let indentedCodeComponents = listItemMarkdownCacheConfiguration.indentedCodeComponents
                    let cache = indentedCodeComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(refreshNodeView.nodeText, Option<String>.None, refreshNodeView.nodeHash)
                        listItemNodeViewDataSource.update(i, refreshNodeView)
                    } else {
                        listItemNodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "BulletList" || refreshNodeView.nodeType == "OrderedList") {
                    // 无序列表/有序列表节点
                    let listComponents = listItemMarkdownCacheConfiguration.listComponents
                    let cache = listComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshListData(refreshNodeView)
                        listItemNodeViewDataSource.update(i, refreshNodeView)
                    } else {
                        listItemNodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "BlockQuote") {
                    // 块引用节点
                    let quoteComponents = listItemMarkdownCacheConfiguration.quoteComponents
                    let cache = quoteComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshQuoteData(refreshNodeView)
                        listItemNodeViewDataSource.update(i, refreshNodeView)
                    } else {
                        listItemNodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "TableBlock") {
                    // 表格节点
                    let tableComponents = listItemMarkdownCacheConfiguration.tableComponents
                    let cache = tableComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshTableBlockData(refreshNodeView)
                        listItemNodeViewDataSource.update(i, refreshNodeView)
                    } else {
                        listItemNodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "FootnoteBlock") {
                    // 脚注节点
                    let footnoteComponent = listItemMarkdownCacheConfiguration.footnoteComponent
                    let cache = footnoteComponent.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshFootnoteData(refreshNodeView)
                        listItemNodeViewDataSource.update(i, refreshNodeView)
                    } else {
                        listItemNodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                    continue
                }
                // 其他节点
                listItemNodeViewDataSource.replaceData(i, refreshNodeView)
            }
        }
    }
}
