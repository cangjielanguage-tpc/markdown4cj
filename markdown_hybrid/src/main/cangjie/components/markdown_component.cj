/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

protected let prism: Prism = Prism(GrammarLocatorGrammarUtils())

/**
 * Markdown预览自定义控件
 */
@Component
public class MarkdownComponent {
    /**
     * 外部传入的Markdown文档
     */
    @Prop
    @Watch[refreshData]
    var output: String

    /**
     * 流式输入是否输入结束(true:结束输入,false:持续输入)
     */
    @Prop
    @Watch[inputEndedData]
    var isInputEnded: Bool

    /**
     * markdown是否增量解析(true:增量解析,false:全量解析)
     */
    @Prop
    @Watch[analysisData]
    var incrementalAnalysis: Bool

    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration = MarkdownConfiguration.create()

    /**
     * markdown插件
     */
    var markdownPlugin: Markdown = Markdown
        .builder()
        // HTML插件
        .usePlugin(HtmlPlugin.create())
        // 任务列表插件
        .usePlugin(TaskListPlugin.create())
        // 删除线插件
        .usePlugin(StrikethroughPlugin.create())
        // 表格插件
        .usePlugin(TablePlugin.create())
        // 数学公式插件
        .usePlugin(LatexMathPluginV2.create())
        // 音频插件
        .usePlugin(BlockAudioPlugin.create())
        // 视频插件
        .usePlugin(BlockVideoPlugin.create())
        // 自动链接插件
        .usePlugin(LinkifyPlugin.create())
        // 幻灯片插件
        .usePlugin(ImageSlidePlugin.create())
        // ImageStyle插件
        .usePlugin(ImageStylePlugin.create())
        // 代码列表标签插件
        .usePlugin(CodeListPlugin.create())
        // 脚注插件
        .usePlugin(FootnotePlugin.create())
        // TOC插件
        .usePlugin(TocPlugin.create())
        // 图片列表插件
        .usePlugin(ImageCollectPlugin.create())
        // 唯一ID标识插件
        .usePlugin(NodeIdPlugin.create())
        // BLOCKS_AND_INLINES
        .includeSourceSpans(2)
        .build()

    /**
     * 自定义广告块结构布局
     */
    @BuilderParam
    var adBuilder: (NodeView) -> Unit = ADBuilder

    /**
     * 自定义视频块结构布局
     */
    @BuilderParam
    var videoBuilder: (NodeView, MarkdownTheme, (String) -> Unit, (String, (String, Float64, Int64) -> Unit) -> Unit, ?(String) -> Unit, ?(String) -> Unit) -> Unit = VideoBuilder

    /**
     * 自定义音频块结构布局
     */
    @BuilderParam
    var audioBuilder: (NodeView, MarkdownTheme, ?(String) -> Unit) -> Unit = AudioBuilder

    /**
     * 自定义块结构布局
     */
    @BuilderParam
    var customBlockBuilder: (NodeView, Int64) -> Unit = CustomBlockBuilder

    /**
     * 自定义行内标题布局
     */
    @BuilderParam
    var customHeadingLineBuilder: (NodeView, Int64) -> Unit = CustomHeadingLineBuilder

    /**
     * 自定义行内段落布局
     */
    @BuilderParam
    var customParagraphLineBuilder: (NodeView, Int64) -> Unit = CustomParagraphLineBuilder

    /**
     * 自定义行内表格布局
     */
    @BuilderParam
    var customTableLineBuilder: (NodeView, Int64) -> Unit = CustomTableLineBuilder

    /**
     * 屏幕宽度 - 单位px
     */
    let screenWidth: Int32 = getDefaultDisplaySync().width

    /**
     * 控件宽度 - 单位vp
     */
    @State
    var componentWidth: Float64 = 0.0

    /**
     * 控件宽度 - 单位vp
     */
    @State
    var tableBlockComponentWidth: Float64 = 0.0

    /**
     * 缓存的数据
     */
    let markdownCacheConfiguration: MarkdownCacheConfiguration = MarkdownCacheConfiguration()

    /**
     * 注脚事件回调数据
     */
    var indexFootnoteHashMap: HashMap<String, Float64> = HashMap<String, Float64>()

    /**
     * toc事件回调数据
     */
    var indexTocHashMap: HashMap<Int64, Float64> = HashMap<Int64, Float64>()

    /**
     * list控制器
     */
    let scroller: Scroller = Scroller()

    /**
     * markdown解析器
     */
    var incBase: ?IncreaseParser = Option<IncreaseParser>.None

    /**
     * 锁
     */
    let parseReentrantMutex: Mutex = Mutex()

    /**
     * 刷新判定
     */
    let isRefreshData: AtomicBool = AtomicBool(true)

    /**
     * 懒加载数据源
     */
    var nodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    /**
     * 所有图片视频的url
     */
    var imageAndVideoList: ArrayList<String> = ArrayList<String>()

    /**
     * 上一次的输入内容
     */
    var oldOutput: String = ""

    /**
     * 最后一条数据的位置
     */
    @State
    var lastViewIndex: Int64 = 0

    protected override func aboutToAppear(): Unit {
        tableBlockComponentWidth = vp2px((markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp)().value // 表格每个格子最大宽度
        // 加载插件
        incBase = IncreaseParser(markdownPlugin)
        // 默认控件宽度等于屏幕宽度
        componentWidth = px2vp(Float64(screenWidth).px).getOrThrow().value
        // 首次加载
        refreshData()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        markdownCacheConfiguration.clearAll()
    }

    func build() {
        if (!markdownConfiguration.markdownTheme.isSeparateCodeBlock) {
            List(scroller: scroller) {
                LazyForEach(
                    nodeViewDataSource,
                    itemGeneratorFunc: {
                        item: NodeView, idx: Int64 => if (item.nodeType == "Paragraph") {
                            // 段落
                            ListItem() {
                                MarkdownParagraphComponent(
                                    paragraphMarkdownConfiguration: markdownConfiguration,
                                    paragraphNodeView: item,
                                    paragraphComponentWidth: componentWidth,
                                    paragraphComponents: markdownCacheConfiguration.paragraphComponents,
                                    paragraphCustomParagraphLineBuilder: customParagraphLineBuilder,
                                    paragraphTocListOnClick: tocListOnClick,
                                    paragraphImageCallback: imageCallback,
                                    paragraphFootnoteCallback: footnoteCallback
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "Heading" || item.nodeType == "IdHeading") {
                            // 标题/标题ID
                            ListItem() {
                                MarkdownHeadingComponent(
                                    headingMarkdownConfiguration: markdownConfiguration,
                                    headingNodeView: item,
                                    headingComponentWidth: componentWidth,
                                    headingComponents: markdownCacheConfiguration.headingComponents,
                                    headingCustomHeadingLineBuilder: customHeadingLineBuilder,
                                    headingImageCallback: imageCallback,
                                    headingFootnoteCallback: footnoteCallback
                                )
                            }
                            .interopOnAreaChange {oldValue, newValue => indexTocHashMap.add(idx, newValue.globalPosition.y)}
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "FencedCodeBlockListBlock") {
                            // 围栏代码块列表
                            ListItem() {
                                blockCodeBlockListComponent(
                                    markdownConfiguration,
                                    item,
                                    toCodeList(item)
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "FencedCodeBlock") {
                            // 围栏代码块
                            ListItem() {
                                MarkdownCodeFencedBlockComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    codeText: item.nodeText,
                                    info: item.codeInfo(),
                                    nodeHash: item.nodeHash,
                                    fencedCodeComponents: markdownCacheConfiguration.fencedCodeComponents
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "IndentedCodeBlock") {
                            // 缩进代码块
                            ListItem() {
                                MarkdownCodeIndentedBlockComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    codeText: item.nodeText,
                                    nodeHash: item.nodeHash,
                                    indentedCodeComponents: markdownCacheConfiguration.indentedCodeComponents
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "BulletList") {
                            // 无序列表
                            ListItem() {
                                MarkdownListComponent(
                                    listMarkdownConfiguration: markdownConfiguration,
                                    listNodeView: item,
                                    listComponentWidth: componentWidth,
                                    listTableBlockComponentWidth: tableBlockComponentWidth,
                                    listMarkdownCacheConfiguration: markdownCacheConfiguration,
                                    isOrdered: true,
                                    listAdBuilder: adBuilder,
                                    listVideoBuilder: videoBuilder,
                                    listAudioBuilder: audioBuilder,
                                    listCustomBlockBuilder: customBlockBuilder,
                                    listCustomHeadingLineBuilder: customHeadingLineBuilder,
                                    listCustomParagraphLineBuilder: customParagraphLineBuilder,
                                    listCustomTableLineBuilder: customTableLineBuilder,
                                    listFootnoteCallback: footnoteCallback,
                                    listTocListOnClick: tocListOnClick,
                                    listImageCallback: imageCallback,
                                    listVideoCallback: videoCallback,
                                    listIndexFootnoteHashMap: indexFootnoteHashMap,
                                    listDepth: 0
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "OrderedList") {
                            // 有序列表
                            ListItem() {
                                MarkdownListComponent(
                                    listMarkdownConfiguration: markdownConfiguration,
                                    listNodeView: item,
                                    listComponentWidth: componentWidth,
                                    listTableBlockComponentWidth: tableBlockComponentWidth,
                                    listMarkdownCacheConfiguration: markdownCacheConfiguration,
                                    isOrdered: false,
                                    listAdBuilder: adBuilder,
                                    listVideoBuilder: videoBuilder,
                                    listAudioBuilder: audioBuilder,
                                    listCustomBlockBuilder: customBlockBuilder,
                                    listCustomHeadingLineBuilder: customHeadingLineBuilder,
                                    listCustomParagraphLineBuilder: customParagraphLineBuilder,
                                    listCustomTableLineBuilder: customTableLineBuilder,
                                    listFootnoteCallback: footnoteCallback,
                                    listTocListOnClick: tocListOnClick,
                                    listImageCallback: imageCallback,
                                    listVideoCallback: videoCallback,
                                    listIndexFootnoteHashMap: indexFootnoteHashMap,
                                    listDepth: 0
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "BlockQuote") {
                            // 块引用
                            ListItem() {
                                MarkdownQuoteComponent(
                                    quoteMarkdownConfiguration: markdownConfiguration,
                                    quoteNodeView: item,
                                    quoteComponentWidth: componentWidth,
                                    quoteTableBlockComponentWidth: tableBlockComponentWidth,
                                    quoteAdBuilder: adBuilder,
                                    quoteVideoBuilder: videoBuilder,
                                    quoteAudioBuilder: audioBuilder,
                                    quoteCustomBlockBuilder: customBlockBuilder,
                                    quoteCustomHeadingLineBuilder: customHeadingLineBuilder,
                                    quoteCustomParagraphLineBuilder: customParagraphLineBuilder,
                                    quoteCustomTableLineBuilder: customTableLineBuilder,
                                    quoteMarkdownCacheConfiguration: markdownCacheConfiguration,
                                    quoteFootnoteCallback: footnoteCallback,
                                    quoteTocListOnClick: tocListOnClick,
                                    quoteImageCallback: imageCallback,
                                    quoteVideoCallback: videoCallback,
                                    quoteIndexFootnoteHashMap: indexFootnoteHashMap,
                                    quoteDepth: 0
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "LatexMathBlock") {
                            // 数学公式块
                            ListItem() {
                                MarkdownLatexMathBlockComponent(
                                    markdownTheme:markdownConfiguration.markdownTheme,
                                    latexMathBlockStr:item.nodeText,
                                    latexImageCallback:markdownConfiguration.latexImageCallback,
                                    latexStrCallback:markdownConfiguration.latexStrCallback,
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "TableBlock") {
                            // 表格
                            ListItem() {
                                MarkdownTableBlockComponent(
                                    tableBlockMarkdownConfiguration:markdownConfiguration,
                                    tableBlockNodeView:item,
                                    tableBlockComponentWidth:tableBlockComponentWidth,
                                    tableComponents:markdownCacheConfiguration.tableComponents,
                                    tableRowComponents:markdownCacheConfiguration.tableRowComponents,
                                    tableCellComponents:markdownCacheConfiguration.tableCellComponents,
                                    tableBlockCustomTableLineBuilder:customTableLineBuilder,
                                    tableBlockImageCallback:imageCallback,
                                    tableBlockFootnoteCallback:footnoteCallback
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "ThematicBreak") {
                            // 分割线
                            ListItem() {
                                MarkdownThematicBreakComponent(
                                    markdownTheme: markdownConfiguration.markdownTheme
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "FootnoteBlock") {
                            // 脚注
                            ListItem() {
                                MarkdownFootnoteComponent(
                                    footnoteMarkdownConfiguration:markdownConfiguration,
                                    footnoteNodeView:item,
                                    footnoteComponentWidth:componentWidth,
                                    footnoteMarkdownCacheConfiguration:markdownCacheConfiguration,
                                    footnoteCustomParagraphLineBuilder:customParagraphLineBuilder,
                                    footnoteTocListOnClick:tocListOnClick,
                                    footnoteImageCallback:imageCallback,
                                    footnoteFootnoteCallback:footnoteCallback
                                )
                            }
                            .interopOnAreaChange {oldValue, newValue => indexFootnoteHashMap.add(item.footnoteID(), newValue.globalPosition.y)}
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "DescList") {
                            // 定义列表
                            ListItem() {
                                MarkdownDescListComponent(
                                    descListMarkdownConfiguration:markdownConfiguration,
                                    descListNodeView:item,
                                    descListComponentWidth:componentWidth,
                                    descListMarkdownCacheConfiguration:markdownCacheConfiguration,
                                    descListCustomParagraphLineBuilder:customParagraphLineBuilder,
                                    descListTocListOnClick:tocListOnClick,
                                    descListImageCallback:imageCallback,
                                    descListFootnoteCallback:footnoteCallback
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "SlideBlock") {
                            // 图片幻灯片
                            ListItem() {
                                MarkdownBannerComponent(
                                    markdownTheme:markdownConfiguration.markdownTheme,
                                    nodeView:item,
                                    imageCallback:imageCallback
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "BlockVideo") {
                            // 视频
                            ListItem() {
                                videoBuilder(
                                    item,
                                    markdownConfiguration.markdownTheme,
                                    videoCallback,
                                    markdownConfiguration.videoImageCallback,
                                    markdownConfiguration.videoReleaseCallback,
                                    markdownConfiguration.videoDownloadCallback
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "BlockAudio") {
                            // 音频
                            ListItem() {
                                audioBuilder(
                                    item,
                                    markdownConfiguration.markdownTheme,
                                    markdownConfiguration.audioCallback
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else if (item.nodeType == "BlockAD") {
                            // 广告
                            ListItem() {
                                adBuilder(
                                    item
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                         } else if (item.nodeType == "CardNode") {
                             // 卡片
                             ListItem() {
                                 MarkdownCardComponent(
                                     markdownConfiguration: markdownConfiguration,
                                     nodeView: item,
                                     cardName: item.cardName(),
                                     cardData: item.cardData()
                                 )
                             }
                             .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        } else {
                            // 其他
                            ListItem() {
                                customBlockBuilder(
                                    item,
                                    idx
                                )
                            }
                            .margin(top: marginNodeTop(idx, item, markdownConfiguration.markdownTheme), bottom: marginNodeBottom(idx, lastViewIndex, item, markdownConfiguration.markdownTheme))
                        }
                    },
                    keyGeneratorFunc: {
                        item: NodeView, idx: Int64 => "${idx}-${item.nodeHash}-${item.contentHash}"
                    }
                )
            }
            .listDirection(Axis.Vertical)
            .alignListItem(ListItemAlign.Start)
            .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))
            .interopOnSizeChange {
                old, new => if (componentWidth != new.width) {
                    componentWidth = new.width
                }
            }
        } else {
            List(scroller: scroller) {
                LazyForEach(
                    nodeViewDataSource,
                    itemGeneratorFunc: {
                        item: NodeView, idx: Int64 => if (idx == 0 && (item.nodeType == "FencedCodeBlock" || item.nodeType == "IndentedCodeBlock")) {
                            ListItem() {
                                MarkdownCodeComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    codeText: item.nodeText,
                                    info: item.codeInfo,
                                    nodeHash: item.nodeHash,
                                    codeComponents: markdownCacheConfiguration.codeComponents,
                                    codeTextComponents: markdownCacheConfiguration.codeTextComponents
                                )
                            }
                        } else {
                            ListItem() {
                                Text("")
                            }
                        }
                    },
                    keyGeneratorFunc: {
                        item: NodeView, idx: Int64 => "${idx}-${item.nodeHash}-${item.contentHash}"
                    }
                )
            }
            .nestedScroll(NestedScrollOptions(NestedScrollMode.PARENT_FIRST, NestedScrollMode.PARENT_FIRST))
        }
    }

    /**
     * 刷新数据
     */
    func refreshData(): Unit {
        if (markdownConfiguration
            .markdownTheme
            .isMarkdownParserSync) {
            let nodeview = mdparse()
            if (let Some(v) <- nodeview) {
                stringToNodesSync(v)
            }
        } else {
            // 上一步解析完成才继续解析
            if (isRefreshData.load()) {
                spawn {
                    // 异步解析，加锁
                    synchronized(parseReentrantMutex) {
                        isRefreshData.store(false)
                        let nodeview = mdparse()
                        if (let Some(v) <- nodeview) {
                            stringToNodes(v)
                        }
                        isRefreshData.store(true)
                    }
                }
            }
        }
    }

    /**
     * markdown解析
     *
     * @return NodeView
     */
    func mdparse(): ?NodeView {
        try {
            let doc = if (incrementalAnalysis) {
                // 增量解析
                let diff: String = output[oldOutput.size..]
                incBase().parseIncremental(diff)
            } else {
                // 全量解析
                markdownPlugin.toMarkdown(output)
            }
            oldOutput = output
            if (let Some(v) <- markdownConfiguration.nodeString) {
                v(NodeViewStringBuilder(doc))
            }
            imageAndVideoList.clear()
            imageAndVideoList.add(all: getProp<ArrayList<String>>(doc, "links", ArrayList<String>()))
            let nodeView: NodeView = NodeView()
            nodeToNodeView(doc, nodeView, nodeView, markdownConfiguration.markdownTheme.isLinkStyle)
            return nodeView
        } catch (e: Exception) {
            return Option<NodeView>.None
        }
    }

    /**
     * 同步UI数据处理
     *
     * @param nodeView NodeView
     */
    func stringToNodesSync(nodeView: NodeView): Unit {
        let refreshNodeViewChildren = nodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = nodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            refreshDatas(dataSourceSize, refreshNodeViewChildren)
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                nodeViewDataSource.addData(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            refreshDatas(dataSourceSize, refreshNodeViewChildren)
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            refreshDatas(refreshNodeViewSize, refreshNodeViewChildren)
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                nodeViewDataSource.deleteData(i)
            }
        }
        lastViewIndex = nodeViewDataSource.totalCount() - 1 // 页面缓存的数据长度
    }

    /**
     * 异步UI数据处理
     *
     * @param nodeView NodeView
     */
    func stringToNodes(nodeView: NodeView): Unit {
        let refreshNodeViewChildren = nodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = nodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        let syncCounter: SyncCounter = SyncCounter(1)
        launch {
            if (refreshNodeViewSize > dataSourceSize) {
                // 新数据大于页面数据
                // 循环判断历史数据有没有做过修改
                refreshDatas(dataSourceSize, refreshNodeViewChildren)
                // 循环添加新数据
                for (i in dataSourceSize..refreshNodeViewSize) {
                    nodeViewDataSource.addData(refreshNodeViewChildren[i])
                }
            } else if (refreshNodeViewSize == dataSourceSize) {
                // 新数据等于页面数据
                refreshDatas(dataSourceSize, refreshNodeViewChildren)
            } else {
                // 新数据小于页面数据
                // 循环判断历史数据有没有做过修改
                refreshDatas(refreshNodeViewSize, refreshNodeViewChildren)
                // 循环删除多余的旧数据
                for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                    nodeViewDataSource.deleteData(i)
                }
            }
            lastViewIndex = nodeViewDataSource.totalCount() - 1 // 页面缓存的数据长度
            syncCounter.dec()
        }
        syncCounter.waitUntilZero()
    }

    /**
     * 循环判断历史数据有没有做过修改
     *
     * @param size 长度
     * @param refreshNodeViews 刷新的数据
     */
    func refreshDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = nodeViewDataSource.getData(i)
            let newBlockHash = refreshNodeView.nodeHash
            let oldBlockHash = dataSourceNode.nodeHash
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            // 唯一ID是否相同
            if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                nodeViewDataSource.replaceData(i, refreshNodeView)
            } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                nodeViewDataSource.replaceData(i, refreshNodeView)
            } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                if (!markdownConfiguration.markdownTheme.isSeparateCodeBlock) {
                    if (refreshNodeView.nodeType == "Paragraph") {
                        // 段落
                        let paragraphComponents = markdownCacheConfiguration.paragraphComponents
                        let cache = paragraphComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshParagraphData(refreshNodeView)
                        }
                    } else if (refreshNodeView.nodeType == "Heading" || refreshNodeView.nodeType == "IdHeading") {
                        // 标题/标题ID
                        let headingComponents = markdownCacheConfiguration.headingComponents
                        let cache = headingComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshHeadingData(refreshNodeView)
                        }
                    } else if (refreshNodeView.nodeType == "FencedCodeBlock") {
                        // 围栏代码块
                        let fencedCodeComponents = markdownCacheConfiguration.fencedCodeComponents
                        let cache = fencedCodeComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeView.nodeText, refreshNodeView.codeInfo(), refreshNodeView.nodeHash)
                        }
                    } else if (refreshNodeView.nodeType == "IndentedCodeBlock") {
                        // 缩进代码块
                        let indentedCodeComponents = markdownCacheConfiguration.indentedCodeComponents
                        let cache = indentedCodeComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeView.nodeText, Option<String>.None, refreshNodeView.nodeHash)
                        }
                    } else if (refreshNodeView.nodeType == "BulletList" || refreshNodeView.nodeType == "OrderedList") {
                        // 无序列表/有序列表
                        let listComponents = markdownCacheConfiguration.listComponents
                        let cache = listComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshListData(refreshNodeView)
                        }
                    } else if (refreshNodeView.nodeType == "BlockQuote") {
                        // 块引用
                        let quoteComponents = markdownCacheConfiguration.quoteComponents
                        let cache = quoteComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshQuoteData(refreshNodeView)
                        }
                    } else if (refreshNodeView.nodeType == "TableBlock") {
                        // 表格
                        let tableComponents = markdownCacheConfiguration.tableComponents
                        let cache = tableComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshTableBlockData(refreshNodeView)
                        }
                    } else if (refreshNodeView.nodeType == "FootnoteBlock") {
                        // 脚注
                        let footnoteComponent = markdownCacheConfiguration.footnoteComponent
                        let cache = footnoteComponent.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshFootnoteData(refreshNodeView)
                        }
                    } else if (refreshNodeView.nodeType == "DescList") {
                        // 定义列表
                        let descListComponent = markdownCacheConfiguration.descListComponent
                        let cache = descListComponent.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshDescListData(refreshNodeView)
                        }
                    } else {
                        // TODO 其他
                        nodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                } else {
                    if (refreshNodeView.nodeType == "FencedCodeBlock") {
                        // 围栏代码块
                        let codeComponents = markdownCacheConfiguration.codeComponents
                        let cache = codeComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeView.nodeText, refreshNodeView.codeInfo(), refreshNodeView.nodeHash)
                        }
                    } else if (refreshNodeView.nodeType == "IndentedCodeBlock") {
                        // 缩进代码块
                        let codeComponents = markdownCacheConfiguration.codeComponents
                        let cache = codeComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeView.nodeText, Option<String>.None, refreshNodeView.nodeHash)
                        }
                    } else {
                        // TODO 其他
                        nodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                }
            }
        }
    }

    /**
     * 数据是否输入结束
     */
    func inputEndedData(): Unit{

    }

    /**
     * markdown是否增量解析
     */
    func analysisData(): Unit{

    }

    /**
     * TOC列表点击事件回调
     */
    func tocListOnClick(index: Int64): Unit {
        if (let Some(v) <- indexTocHashMap.get(index)) {
            if (let Some(w) <- markdownConfiguration.tocIndexCallback) {
                w(v)
            }
        }
    }

    /**
     * 脚注点击回调
     */
    func footnoteCallback(noteid: String): Unit {
        if (let Some(v) <- indexFootnoteHashMap.get(noteid)) {
            if (let Some(w) <- markdownConfiguration.footnoteCallback) {
                w(v)
            }
        }
    }

    /**
     * 图片点击回调
     */
    func imageCallback(url: String): Unit {
        if (let Some(v) <- markdownConfiguration.imageCallback) {
            v(url, imageAndVideoList)
        }
    }

    /**
     * 视频点击回调
     */
    func videoCallback(url: String): Unit {
        if (let Some(v) <- markdownConfiguration.videoCallback) {
            v(url, imageAndVideoList)
        }
    }
}
