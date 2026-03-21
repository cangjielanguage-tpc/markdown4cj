/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.state_macro_manage.*

/**
 * Markdown块引用自定义控件
 */
@Component
public class MarkdownQuoteComponent {
    /**
     * markdown配置
     */
    var quoteMarkdownConfiguration: MarkdownConfiguration

    /**
     * 列表节点
     */
    @Prop
    var quoteNodeView: NodeView

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var quoteComponentWidth: Float64

    /**
     * 表格控件宽度 - 单位vp
     */
    @Prop
    var quoteTableBlockComponentWidth: Float64

    /**
     * 缓存的数据
     */
    var quoteMarkdownCacheConfiguration: MarkdownCacheConfiguration

    /**
     * 自定义广告块结构布局
     */
    @BuilderParam
    var quoteAdBuilder: (NodeView) -> Unit = ADBuilder

    /**
     * 自定义视频块结构布局
     */
    @BuilderParam
    var quoteVideoBuilder: (NodeView, MarkdownTheme, (String) -> Unit, (String, (String, Float64, Int64) -> Unit) -> Unit, ?(String) -> Unit, ?(String) -> Unit) -> Unit

    /**
     * 自定义音频块结构布局
     */
    @BuilderParam
    var quoteAudioBuilder: (NodeView, MarkdownTheme, ?(String) -> Unit) -> Unit

    /**
     * 自定义块结构布局
     */
    @BuilderParam
    var quoteCustomBlockBuilder: (NodeView, Int64) -> Unit

    /**
     * 自定义行内标题布局
     */
    @BuilderParam
    var quoteCustomHeadingLineBuilder: (NodeView, Int64) -> Unit

    /**
     * 自定义行内段落布局
     */
    @BuilderParam
    var quoteCustomParagraphLineBuilder: (NodeView, Int64) -> Unit

    /**
     * 自定义行内表格布局
     */
    @BuilderParam
    var quoteCustomTableLineBuilder: (NodeView, Int64) -> Unit

    /**
     * 脚注点击事件
     */
    var quoteFootnoteCallback: (String) -> Unit

    /**
     * TOC列表点击事件回调
     */
    var quoteTocListOnClick: (Int64) -> Unit

    /**
     * 图片点击事件
     */
    var quoteImageCallback: (String) -> Unit

    /**
     * 视频点击事件
     */
    var quoteVideoCallback: (String) -> Unit

    /**
     * 注脚事件回调数据
     */
    var quoteIndexFootnoteHashMap: HashMap<String, Int64>

    /**
     * 列表深度
     */
    var quoteDepth: Int64

    /**
     * 懒加载数据源
     */
    @State
    var quoteNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    /**
     * 最后一条数据的位置
     */
    @State
    var lastViewIndex: Int64 = 0

    protected override func aboutToAppear(): Unit {
        refreshQuoteData(quoteNodeView, quoteNodeView.isEndData) // 初始化刷新数据
        quoteMarkdownCacheConfiguration.quoteComponents.add(quoteNodeView.nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = quoteMarkdownCacheConfiguration.quoteComponents.get(quoteNodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                quoteMarkdownCacheConfiguration.quoteComponents.remove(quoteNodeView.nodeHash)
            }
        } else {
            quoteMarkdownCacheConfiguration.quoteComponents.remove(quoteNodeView.nodeHash)
        }
    }

    func build() {
        List() {
            LazyForEach(
                quoteNodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 =>  ListItem() {
                        if (item.nodeType == "Paragraph") {
                            // 段落
                            MarkdownParagraphComponent(
                                paragraphMarkdownConfiguration: quoteMarkdownConfiguration,
                                paragraphNodeView: item,
                                paragraphComponentWidth: quoteComponentWidth,
                                paragraphComponents: quoteMarkdownCacheConfiguration.paragraphComponents,
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
                                headingComponents: quoteMarkdownCacheConfiguration.headingComponents,
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
                                nodeHash: item.nodeHash,
                                fencedCodeComponents: quoteMarkdownCacheConfiguration.fencedCodeComponents,
                                isEndByParent: item.isEndData
                            )
                        } else if (item.nodeType == "IndentedCodeBlock") {
                            // 缩进代码块
                            MarkdownCodeIndentedBlockComponent(
                                markdownConfiguration: quoteMarkdownConfiguration,
                                codeText: item.nodeText,
                                nodeHash: item.nodeHash,
                                indentedCodeComponents: quoteMarkdownCacheConfiguration.indentedCodeComponents,
                                isEndByParent: item.isEndData
                            )
                        } else if (item.nodeType == "BulletList") {
                            // 无序列表
                            MarkdownListComponent(
                                listMarkdownConfiguration: quoteMarkdownConfiguration,
                                listNodeView: item,
                                listComponentWidth: quoteComponentWidth,
                                listTableBlockComponentWidth: quoteTableBlockComponentWidth,
                                listMarkdownCacheConfiguration: quoteMarkdownCacheConfiguration,
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
                                listIndexFootnoteHashMap: quoteIndexFootnoteHashMap,
                                listDepth: quoteDepth + 1
                            )
                        } else if (item.nodeType == "OrderedList") {
                            // 有序列表
                            MarkdownListComponent(
                                listMarkdownConfiguration: quoteMarkdownConfiguration,
                                listNodeView: item,
                                listComponentWidth: quoteComponentWidth,
                                listTableBlockComponentWidth: quoteTableBlockComponentWidth,
                                listMarkdownCacheConfiguration: quoteMarkdownCacheConfiguration,
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
                                listIndexFootnoteHashMap: quoteIndexFootnoteHashMap,
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
                                quoteMarkdownCacheConfiguration: quoteMarkdownCacheConfiguration,
                                quoteFootnoteCallback: quoteFootnoteCallback,
                                quoteTocListOnClick: quoteTocListOnClick,
                                quoteImageCallback: quoteImageCallback,
                                quoteVideoCallback: quoteVideoCallback,
                                quoteIndexFootnoteHashMap: quoteIndexFootnoteHashMap,
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
                                tableComponents: quoteMarkdownCacheConfiguration.tableComponents,
                                tableRowComponents: quoteMarkdownCacheConfiguration.tableRowComponents,
                                tableCellComponents: quoteMarkdownCacheConfiguration.tableCellComponents,
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
                                footnoteMarkdownCacheConfiguration: quoteMarkdownCacheConfiguration,
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
                    .padding(left: quoteMarkdownConfiguration.markdownTheme.blockQuoteRightMargin)
                    .margin(right: quoteMarkdownConfiguration.markdownTheme.blockQuoteRightMargin, top: quoteMarkdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins, bottom: quoteMarkdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins)
                },
                keyGeneratorFunc: {
                    quoteNodeView: NodeView, idx: Int64 => return "${idx}-${quoteNodeView.nodeHash}-${quoteNodeView.contentHash}-${quoteNodeView.canRefresh}"
                }
            )
        }
        .backgroundColor(quoteMarkdownConfiguration.markdownTheme.blockQuoteBackGroupColor)
        .width(100.percent)
        .listDirection(Axis.Vertical)
        .alignListItem(ListItemAlign.Start)
        .borderColor(quoteMarkdownConfiguration.markdownTheme.blockQuoteColor)
        .borderWidth(EdgeWidths(left: quoteMarkdownConfiguration.markdownTheme.blockQuoteWidth.vp))
        .margin(left: quoteMarkdownConfiguration.markdownTheme.blockQuoteLeftMargin)
    }

    /**
     * 数据刷新
     */
    public func refreshQuoteData(quoteNodeView: NodeView, isEnd: Bool): Unit {
        let refreshNodeViewChildren = quoteNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = quoteNodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            refreshQuoteDatas(dataSourceSize, refreshNodeViewChildren, false) // 循环判断历史数据有没有做过修改
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                if (isEnd && (i == refreshNodeViewSize - 1)) {
                    refreshNodeViewChildren[i].isEndData = true
                }
                quoteNodeViewDataSource.addData(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            refreshQuoteDatas(dataSourceSize, refreshNodeViewChildren, isEnd) // 循环判断历史数据有没有做过修改
        } else {
            // 新数据小于页面数据
            refreshQuoteDatas(refreshNodeViewSize, refreshNodeViewChildren, isEnd) // 循环判断历史数据有没有做过修改
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                quoteNodeViewDataSource.deleteData(i)
            }
        }
        lastViewIndex = quoteNodeViewDataSource.totalCount() - 1 // 缓存的数据长度
    }

    /**
     * 循环判断历史数据有没有做过修改
     *
     * @param size 长度
     * @param refreshNodes 刷新的数据
     */
    func refreshQuoteDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>, isEnd: Bool): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = quoteNodeViewDataSource.getData(i)
            let newNodeHash = refreshNodeView.nodeHash
            let oldNodeHash = dataSourceNode.nodeHash
            // 当前层的倒数第二条数据，因为可能一行多个
            let isSecondToLast: Bool = (i == lastViewIndex - 1)
            if (isEnd) {
                refreshNodeView.isEndData = (i == lastViewIndex && !isSecondToLast)
            } else {
                refreshNodeView.isEndData = false
            }
            if (newNodeHash != oldNodeHash) {
                // 自身节点唯一ID不相同需要刷新数据
                quoteNodeViewDataSource.replaceData(i, refreshNodeView)
                continue
            }
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            if (newContentHash != oldContentHash) {
                // 子节点唯一ID不相同需要刷新子节点数据
                if (refreshNodeView.nodeType == "Paragraph") {
                    // 段落节点
                    let paragraphComponents = quoteMarkdownCacheConfiguration.paragraphComponents
                    let cache = paragraphComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshParagraphData(refreshNodeView, isSecondToLast || isEnd)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "Heading" || refreshNodeView.nodeType == "IdHeading") {
                    // 标题/标题ID节点
                    let headingComponents = quoteMarkdownCacheConfiguration.headingComponents
                    let cache = headingComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshHeadingData(refreshNodeView, isSecondToLast || isEnd)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "FencedCodeBlock") {
                    // 围栏代码块节点
                    let fencedCodeComponents = quoteMarkdownCacheConfiguration.fencedCodeComponents
                    let cache = fencedCodeComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(refreshNodeView.nodeText, refreshNodeView.codeInfo(), refreshNodeView.nodeHash, isSecondToLast || isEnd)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "IndentedCodeBlock") {
                    // 缩进代码块节点
                    let indentedCodeComponents = quoteMarkdownCacheConfiguration.indentedCodeComponents
                    let cache = indentedCodeComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(refreshNodeView.nodeText, Option<String>.None, refreshNodeView.nodeHash, isSecondToLast || isEnd)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "BulletList" || refreshNodeView.nodeType == "OrderedList") {
                    // 无序列表/有序列表节点
                    let listComponents = quoteMarkdownCacheConfiguration.listComponents
                    let cache = listComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshListData(refreshNodeView, isSecondToLast || isEnd)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "BlockQuote") {
                    // 块引用节点
                    let quoteComponents = quoteMarkdownCacheConfiguration.quoteComponents
                    let cache = quoteComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshQuoteData(refreshNodeView, isSecondToLast || isEnd)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "TableBlock") {
                    // 表格节点
                    let tableComponents = quoteMarkdownCacheConfiguration.tableComponents
                    let cache = tableComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshTableBlockData(refreshNodeView, isSecondToLast || isEnd)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "FootnoteBlock") {
                    // 脚注节点
                    let footnoteComponent = quoteMarkdownCacheConfiguration.footnoteComponent
                    let cache = footnoteComponent.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshFootnoteData(refreshNodeView, isSecondToLast || isEnd)
                    }
                    continue
                }
                // 其他节点
                quoteNodeViewDataSource.replaceData(i, refreshNodeView)
                continue
            }
            if (dataSourceNode.canRefresh) {
                refreshNodeView.isEndData = false
                refreshNodeView.canRefresh = false
                if (refreshNodeView.nodeType == "Paragraph") {
                    // 段落节点
                    let paragraphComponents = quoteMarkdownCacheConfiguration.paragraphComponents
                    let cache = paragraphComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshParagraphData(refreshNodeView, isSecondToLast || isEnd)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "Heading" || refreshNodeView.nodeType == "IdHeading") {
                    // 标题/标题ID节点
                    let headingComponents = quoteMarkdownCacheConfiguration.headingComponents
                    let cache = headingComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshHeadingData(refreshNodeView, isSecondToLast || isEnd)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "FencedCodeBlock") {
                    // 围栏代码块节点
                    let fencedCodeComponents = quoteMarkdownCacheConfiguration.fencedCodeComponents
                    let cache = fencedCodeComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(refreshNodeView.nodeText, refreshNodeView.codeInfo(), refreshNodeView.nodeHash, isSecondToLast || isEnd)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "IndentedCodeBlock") {
                    // 缩进代码块节点
                    let indentedCodeComponents = quoteMarkdownCacheConfiguration.indentedCodeComponents
                    let cache = indentedCodeComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(refreshNodeView.nodeText, Option<String>.None, refreshNodeView.nodeHash, isSecondToLast || isEnd)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "BulletList" || refreshNodeView.nodeType == "OrderedList") {
                    // 无序列表/有序列表节点
                    let listComponents = quoteMarkdownCacheConfiguration.listComponents
                    let cache = listComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshListData(refreshNodeView, isSecondToLast || isEnd)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "BlockQuote") {
                    // 块引用节点
                    let quoteComponents = quoteMarkdownCacheConfiguration.quoteComponents
                    let cache = quoteComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshQuoteData(refreshNodeView, isSecondToLast || isEnd)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "TableBlock") {
                    // 表格节点
                    let tableComponents = quoteMarkdownCacheConfiguration.tableComponents
                    let cache = tableComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshTableBlockData(refreshNodeView, isSecondToLast || isEnd)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "FootnoteBlock") {
                    // 脚注节点
                    let footnoteComponent = quoteMarkdownCacheConfiguration.footnoteComponent
                    let cache = footnoteComponent.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshFootnoteData(refreshNodeView, isSecondToLast || isEnd)
                    }
                    continue
                }
                // 其他节点
                quoteNodeViewDataSource.replaceData(i, refreshNodeView)
            }
        }
    }
}
