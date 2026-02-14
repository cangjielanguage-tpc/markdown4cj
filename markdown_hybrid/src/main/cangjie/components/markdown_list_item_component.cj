/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)自定义控件
 */
@Component
class MarkdownListItemComponent {
    /**
     * markdown配置
     */
    var listItemMarkdownConfiguration: MarkdownConfiguration

    /**
     * 列表节点
     */
    var listItemNodeView: NodeView

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var listItemComponentWidth: Float64

    /**
     * 表格控件宽度 - 单位vp
     */
    @Prop
    var listItemTableBlockComponentWidth: Float64

    /**
     * 缓存的数据
     */
    var listItemMarkdownCacheConfiguration: MarkdownCacheConfiguration

    /**
     * 广告布局
     */
    @BuilderParam
    var listItemAdBuilder: (NodeView) -> Unit

    /**
     * 视频布局
     */
    @BuilderParam
    var listItemVideoBuilder: (NodeView, MarkdownTheme, (String) -> Unit, (String, (String, Float64, Int64) -> Unit) -> Unit, ?(String) -> Unit, ?(String) -> Unit) -> Unit

    /**
     * 音频布局
     */
    @BuilderParam
    var listItemAudioBuilder: (NodeView, MarkdownTheme, ?(String) -> Unit) -> Unit

    /**
     * 自定义块结构布局
     */
    @BuilderParam
    var listItemCustomBlockBuilder: (NodeView, Int64) -> Unit

    /**
     * 自定义行内标题布局
     */
    @BuilderParam
    var listItemCustomHeadingLineBuilder: (NodeView, Int64) -> Unit

    /**
     * 自定义行内段落布局
     */
    @BuilderParam
    var listItemCustomParagraphLineBuilder: (NodeView, Int64) -> Unit

    /**
     * 自定义行内表格布局
     */
    @BuilderParam
    var listItemCustomTableLineBuilder: (NodeView, Int64) -> Unit

    /**
     * 脚注点击事件
     */
    var listItemFootnoteCallback: (String) -> Unit

    /**
     * TOC列表点击事件回调
     */
    var listItemTocListOnClick: (Int64) -> Unit

    /**
     * 图片点击事件
     */
    var listItemImageCallback: (String) -> Unit

    /**
     * 视频点击事件
     */
    var listItemVideoCallback: (String) -> Unit

    /**
     * 注脚事件回调数据
     */
    var listItemIndexFootnoteHashMap: HashMap<String, Float64>

    /**
     * 列表深度
     */
    var listItemDepth: Int64

    /**
     * 懒加载数据源
     */
    var listItemNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

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
        List() {
            LazyForEach(
                listItemNodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.nodeType == "Paragraph") {
                        // 段落
                        ListItem() {
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
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "Heading" || item.nodeType == "IdHeading") {
                        // 标题/标题ID
                        ListItem() {
                            MarkdownHeadingComponent(
                                headingMarkdownConfiguration: listItemMarkdownConfiguration,
                                headingNodeView: item,
                                headingComponentWidth: listItemComponentWidth,
                                headingComponents: listItemMarkdownCacheConfiguration.headingComponents,
                                headingCustomHeadingLineBuilder: listItemCustomHeadingLineBuilder,
                                headingImageCallback: listItemImageCallback,
                                headingFootnoteCallback: listItemFootnoteCallback
                            )
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "FencedCodeBlockListBlock") {
                        // 围栏代码块列表
                        ListItem() {
                            blockCodeBlockListComponent(
                                listItemMarkdownConfiguration,
                                item,
                                toCodeList(item)
                            )
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "FencedCodeBlock") {
                        // 围栏代码块
                        ListItem() {
                            MarkdownCodeFencedBlockComponent(
                                markdownConfiguration: listItemMarkdownConfiguration,
                                codeText: item.nodeText,
                                info: item.codeInfo(),
                                nodeHash: item.nodeHash,
                                fencedCodeComponents: listItemMarkdownCacheConfiguration.fencedCodeComponents
                            )
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "IndentedCodeBlock") {
                        // 缩进代码块
                        ListItem() {
                            MarkdownCodeIndentedBlockComponent(
                                markdownConfiguration: listItemMarkdownConfiguration,
                                codeText: item.nodeText,
                                nodeHash: item.nodeHash,
                                indentedCodeComponents: listItemMarkdownCacheConfiguration.indentedCodeComponents
                            )
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "BulletList") {
                        // 无序列表
                        ListItem() {
                            MarkdownListComponent(
                                listMarkdownConfiguration: listItemMarkdownConfiguration,
                                listNodeView: listItemNodeView,
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
                                listIndexFootnoteHashMap: listItemIndexFootnoteHashMap,
                                listDepth: listItemDepth + 1
                            )
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "OrderedList") {
                        // 有序列表
                        ListItem() {
                            MarkdownListComponent(
                                listMarkdownConfiguration: listItemMarkdownConfiguration,
                                listNodeView: listItemNodeView,
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
                                listIndexFootnoteHashMap: listItemIndexFootnoteHashMap,
                                listDepth: listItemDepth + 1
                            )
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "BlockQuote") {
                        // 块引用
                        ListItem() {
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
                                quoteIndexFootnoteHashMap: listItemIndexFootnoteHashMap,
                                quoteDepth: listItemDepth + 1
                            )
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "LatexMathBlock") {
                        // 数学公式块
                        ListItem() {
                            MarkdownLatexMathBlockComponent(
                                markdownTheme: listItemMarkdownConfiguration.markdownTheme,
                                latexMathBlockStr: item.nodeText,
                                latexImageCallback: listItemMarkdownConfiguration.latexImageCallback,
                                latexStrCallback: listItemMarkdownConfiguration.latexStrCallback
                            )
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "TableBlock") {
                        // 表格
                        ListItem() {
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
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "ThematicBreak") {
                        // 分割线
                        ListItem() {
                            MarkdownThematicBreakComponent(markdownTheme: listItemMarkdownConfiguration.markdownTheme)
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "FootnoteBlock") {
                        // 脚注
                        ListItem() {
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
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "SlideBlock") {
                        // 图片幻灯片
                        ListItem() {
                            MarkdownBannerComponent(
                                markdownTheme: listItemMarkdownConfiguration.markdownTheme,
                                nodeView: item,
                                imageCallback: listItemImageCallback
                            )
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "BlockVideo") {
                        // 视频
                        ListItem() {
                            listItemVideoBuilder(
                                item,
                                listItemMarkdownConfiguration.markdownTheme,
                                listItemVideoCallback,
                                listItemMarkdownConfiguration.videoImageCallback,
                                listItemMarkdownConfiguration.videoReleaseCallback,
                                listItemMarkdownConfiguration.videoDownloadCallback
                            )
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "BlockAudio") {
                        // 音频
                        ListItem() {
                            listItemAudioBuilder(
                                item,
                                listItemMarkdownConfiguration.markdownTheme,
                                listItemMarkdownConfiguration.audioCallback
                            )
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else if (item.nodeType == "BlockAD") {
                        // 广告
                        ListItem() {
                            listItemAdBuilder(item)
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
                    } else {
                        // 其他
                        ListItem() {
                            listItemCustomBlockBuilder(
                                item,
                                idx
                            )
                        }
                        .margin(top: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins, bottom: listItemMarkdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
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
        let refreshNodeViewChildren = listItemNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = listItemNodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            refreshListItemDatas(dataSourceSize, refreshNodeViewChildren)
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                listItemNodeViewDataSource.addData(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            refreshListItemDatas(dataSourceSize, refreshNodeViewChildren)
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            refreshListItemDatas(refreshNodeViewSize, refreshNodeViewChildren)
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
            let newBlockHash = refreshNodeView.nodeHash
            let oldBlockHash = dataSourceNode.nodeHash
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            // 唯一ID是否相同
            if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                listItemNodeViewDataSource.replaceData(i, refreshNodeView)
            } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                listItemNodeViewDataSource.replaceData(i, refreshNodeView)
            } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                if (refreshNodeView.nodeType == "Paragraph") {
                    // 段落
                    let paragraphComponents = listItemMarkdownCacheConfiguration.paragraphComponents
                    let cache = paragraphComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshParagraphData(refreshNodeView)
                    }
                } else if (refreshNodeView.nodeType == "Heading" || refreshNodeView.nodeType == "IdHeading") {
                    // 标题
                    let headingComponents = listItemMarkdownCacheConfiguration.headingComponents
                    let cache = headingComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshHeadingData(refreshNodeView)
                    }
                } else if (refreshNodeView.nodeType == "FencedCodeBlock") {
                    // 围栏代码块
                    let fencedCodeComponents = listItemMarkdownCacheConfiguration.fencedCodeComponents
                    let cache = fencedCodeComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(refreshNodeView.nodeText, refreshNodeView.codeInfo(), refreshNodeView.nodeHash)
                    }
                } else if (refreshNodeView.nodeType == "IndentedCodeBlock") {
                    // 缩进代码块
                    let indentedCodeComponents = listItemMarkdownCacheConfiguration.indentedCodeComponents
                    let cache = indentedCodeComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(refreshNodeView.nodeText, Option<String>.None, refreshNodeView.nodeHash)
                    }
                } else if (refreshNodeView.nodeType == "BulletList" || refreshNodeView.nodeType == "OrderedList") {
                    // 无序列表/有序列表
                    let listComponents = listItemMarkdownCacheConfiguration.listComponents
                    let cache = listComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshListData(refreshNodeView)
                    }
                } else if (refreshNodeView.nodeType == "BlockQuote") {
                    // 块引用
                    let quoteComponents = listItemMarkdownCacheConfiguration.quoteComponents
                    let cache = quoteComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshQuoteData(refreshNodeView)
                    }
                } else if (refreshNodeView.nodeType == "TableBlock") {
                    // 表格
                    let tableComponents = listItemMarkdownCacheConfiguration.tableComponents
                    let cache = tableComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshTableBlockData(refreshNodeView)
                    }
                } else if (refreshNodeView.nodeType == "FootnoteBlock") {
                    // 脚注
                    let footnoteComponent = listItemMarkdownCacheConfiguration.footnoteComponent
                    let cache = footnoteComponent.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshFootnoteData(refreshNodeView)
                    }
                } else {
                    // TODO 其他
                    listItemNodeViewDataSource.replaceData(i, refreshNodeView)
                }
            }
        }
    }
}
