package markdown.components

import ohos.state_macro_manage.*

protected let prism: Prism = Prism(GrammarLocatorGrammarUtils())

/**
 * Markdown预览自定义控件
 */
@Component
public class MarkdownComponent {
    @Prop
    @Watch[refreshData]
    var output: String // 外部传入的Markdown文档
    @Prop
    @Watch[inputEndedData]
    var isInputEnded: Bool // 流式输入是否输入结束(true:结束输入,false:持续输入)
    @Prop
    @Watch[analysisData]
    var incrementalAnalysis: Bool // markdown是否增量解析(true:增量解析,false:全量解析)
    var markdownConfiguration: MarkdownConfiguration = MarkdownConfiguration.create() // markdown配置
    var markdownPlugin: Markdown = Markdown
        .builder()
        .usePlugin(HtmlPlugin.create()) // HTML插件
        .usePlugin(TaskListPlugin.create()) // 任务列表插件
        .usePlugin(StrikethroughPlugin.create()) // 删除线插件
        .usePlugin(TablePlugin.create()) // 表格插件
        .usePlugin(LatexMathPluginV2.create()) // 数学公式插件
        .usePlugin(BlockAudioPlugin.create()) // 音频插件
        .usePlugin(BlockVideoPlugin.create()) // 视频插件
        .usePlugin(LinkifyPlugin.create([])) // 自动链接插件
        .usePlugin(ImageSlidePlugin.create()) // 幻灯片插件
        .usePlugin(ImageStylePlugin.create()) // ImageStyle插件
        .usePlugin(CodeListPlugin.create()) // 代码列表标签插件
        .usePlugin(FootnotePlugin.create()) // 脚注插件
        .usePlugin(TocPlugin.create()) // TOC插件
        .usePlugin(ImageCollectPlugin.create()) // 图片列表插件
        .usePlugin(NodeIdPlugin.create()) // 唯一ID标识插件
        .includeSourceSpans(2) // BLOCKS_AND_INLINES
        .build() // markdown插件
    @BuilderParam
    var adBuilder: (NodeView) -> Unit = ADBuilder // 自定义广告块结构布局
    @BuilderParam
    var videoBuilder: (NodeView, MarkdownTheme, (String) -> Unit, (String, (String, Float64, Int64) -> Unit) -> Unit, ?(String) -> Unit, ?(String) -> Unit) -> Unit = VideoBuilder // 自定义视频块结构布局
    @BuilderParam
    var audioBuilder: (NodeView, MarkdownTheme, ?(String) -> Unit) -> Unit = AudioBuilder // 自定义音频块结构布局
    @BuilderParam
    var customBlockBuilder: (NodeView, Int64) -> Unit = CustomBlockBuilder // 自定义块结构布局
    @BuilderParam
    var customHeadingLineBuilder: (NodeView, Int64) -> Unit = CustomHeadingLineBuilder // 自定义行内标题布局
    @BuilderParam
    var customParagraphLineBuilder: (NodeView, Int64) -> Unit = CustomParagraphLineBuilder // 自定义行内段落布局
    @BuilderParam
    var customTableLineBuilder: (NodeView, Int64) -> Unit = CustomTableLineBuilder // 自定义行内表格布局
    let screenWidth: Int32 = getDefaultDisplaySync().width // 屏幕宽度 - 单位px
    @State
    var componentWidth: Float64 = 0.0 // 控件宽度 - 单位vp
    @State
    var tableBlockComponentWidth: Float64 = 0.0 // 表格控件宽度 - 单位vp
    let markdownCacheConfiguration: MarkdownCacheConfiguration = MarkdownCacheConfiguration() // 缓存的数据
    var indexFootnoteHashMap: HashMap<String, Int64> = HashMap<String, Int64>() // 注脚事件回调数据
    var indexTocHashMap: HashMap<Int64, Int64> = HashMap<Int64, Int64>() // toc事件回调数据
    let scroller: Scroller // list控制器
    let scrollerCode: Scroller = Scroller() // 单独代码块list控制器
    var incBase: ?IncreaseParserV2 = Option<IncreaseParserV2>.None // markdown解析器
    let parseReentrantMutex: Mutex = Mutex() // 锁
    let isRefreshData: AtomicBool = AtomicBool(true) // 刷新判定
    var nodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>()) // 懒加载数据源
    var imageAndVideoList: ArrayList<String> = ArrayList<String>() // 所有图片视频的url
    var oldOutput: String = "" // 上一次的输入内容
    @State
    var lastViewIndex: Int64 = 0 // 最后一条数据的位置

    protected override func aboutToAppear(): Unit {
        tableBlockComponentWidth = markdownConfiguration.markdownTheme.tableTheme.tableMaxCellWidth - markdownConfiguration.markdownTheme.tableTheme.tableCellPaddingLeft - markdownConfiguration.markdownTheme.tableTheme.tableCellPaddingRight - 2.0 * markdownConfiguration.markdownTheme.tableTheme.tableBorderWidth // 表格每个格子最大宽度
        incBase = IncreaseParserV2(markdownPlugin) // 加载插件
        componentWidth = px2vp(Float64(screenWidth).px).getOrThrow().value // 默认控件宽度等于屏幕宽度
        refreshData() // 首次加载
    }

    protected override func aboutToDisappear(): Unit {
        markdownCacheConfiguration.clearAll() // 清除缓存数据
    }

    func build() {
        if (!markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockIsSeparate) {
            if (DeviceInfo.sdkApiVersion >= 19) {
                List(scroller: scroller, space: markdownConfiguration.markdownTheme.globalTheme.markdownBlockSpacing) {
                    baseMarkdownList()
                }
                .margin(top: markdownConfiguration.markdownTheme.globalTheme.blockMarginTop, right: markdownConfiguration.markdownTheme.globalTheme.blockMarginRight, bottom: markdownConfiguration.markdownTheme.globalTheme.blockMarginBottom, left: markdownConfiguration.markdownTheme.globalTheme.blockMarginLeft)
                .backgroundColor(markdownConfiguration.markdownTheme.globalTheme.backgroundColor)
                .listDirection(Axis.Vertical)
                .alignListItem(ListItemAlign.Start)
                .scrollBar(BarState.Off)
                .enableScrollInteraction(markdownConfiguration.markdownTheme.globalTheme.openGestureSwipe)
                .interopOnSizeChange {
                    old, new => if (componentWidth != new.width) {
                        componentWidth = new.width
                    }
                }
            } else {
                List(scroller: scroller, space: markdownConfiguration.markdownTheme.globalTheme.markdownBlockSpacing) {
                    baseMarkdownList()
                }
                .margin(top: markdownConfiguration.markdownTheme.globalTheme.blockMarginTop, right: markdownConfiguration.markdownTheme.globalTheme.blockMarginRight, bottom: markdownConfiguration.markdownTheme.globalTheme.blockMarginBottom, left: markdownConfiguration.markdownTheme.globalTheme.blockMarginLeft)
                .backgroundColor(markdownConfiguration.markdownTheme.globalTheme.backgroundColor)
                .listDirection(Axis.Vertical)
                .alignListItem(ListItemAlign.Start)
                .scrollBar(BarState.Off)
                .interopEnableScrollInteraction(markdownConfiguration.markdownTheme.globalTheme.openGestureSwipe)
                .interopOnSizeChange {
                    old, new => if (componentWidth != new.width) {
                        componentWidth = new.width
                    }
                }
            }
        } else {
            List(scroller: scrollerCode, space: markdownConfiguration.markdownTheme.globalTheme.markdownBlockSpacing) {
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

    @Builder
    func baseMarkdownList() {
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
                    .margin(
                        top: markdownConfiguration.markdownTheme.paragraphTheme.paragraphMarginTop,
                        right: markdownConfiguration.markdownTheme.paragraphTheme.paragraphMarginRight,
                        bottom: markdownConfiguration.markdownTheme.paragraphTheme.paragraphMarginBottom,
                        left: markdownConfiguration.markdownTheme.paragraphTheme.paragraphMarginLeft
                    )
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
                    .margin(
                        top: headingMarginTop(item.headingLevel, markdownConfiguration.markdownTheme),
                        right: headingMarginRight(item.headingLevel, markdownConfiguration.markdownTheme),
                        bottom: headingMarginBottom(item.headingLevel, markdownConfiguration.markdownTheme),
                        left: headingMarginLeft(item.headingLevel, markdownConfiguration.markdownTheme)
                    )
                } else if (item.nodeType == "FencedCodeBlockListBlock") {
                    // 围栏代码块列表
                    ListItem() {
                        blockCodeBlockListComponent(
                            markdownConfiguration,
                            item,
                            toCodeList(item)
                        )
                    }
                    .margin(
                        top: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginTop,
                        right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginRight,
                        bottom: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginBottom,
                        left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginLeft
                    )
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
                    .margin(
                        top: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginTop,
                        right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginRight,
                        bottom: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginBottom,
                        left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginLeft
                    )
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
                    .margin(
                        top: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginTop,
                        right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginRight,
                        bottom: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginBottom,
                        left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginLeft
                    )
                } else if (item.nodeType == "BulletList") {
                    // 无序/任务列表
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
                            listDepth: 0
                        )
                    }
                    .margin(
                        top: markdownConfiguration.markdownTheme.bulletListTheme.bulletListMarginTop,
                        right: markdownConfiguration.markdownTheme.bulletListTheme.bulletListMarginRight,
                        bottom: markdownConfiguration.markdownTheme.bulletListTheme.bulletListMarginBottom,
                        left: markdownConfiguration.markdownTheme.bulletListTheme.bulletListMarginLeft
                    )
                } else if (item.nodeType == "OrderedList") {
                    // 有序列表
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
                            listDepth: 0
                        )
                    }
                    .margin(
                        top: markdownConfiguration.markdownTheme.orderedListTheme.orderedListMarginTop,
                        right: markdownConfiguration.markdownTheme.orderedListTheme.orderedListMarginRight,
                        bottom: markdownConfiguration.markdownTheme.orderedListTheme.orderedListMarginBottom,
                        left: markdownConfiguration.markdownTheme.orderedListTheme.orderedListMarginLeft
                    )
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
                            quoteDepth: 0
                        )
                    }
                    .margin(
                        top: markdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteMarginTop,
                        right: markdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteMarginRight,
                        bottom: markdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteMarginBottom,
                        left: markdownConfiguration.markdownTheme.blockQuoteTheme.blockQuoteMarginLeft
                    )
                } else if (item.nodeType == "LatexMathBlock") {
                    // 数学公式块
                    ListItem() {
                        if (item.isLatexMathBlockClose) {
                             MarkdownLatexMathBlockComponent(
                                 markdownTheme:markdownConfiguration.markdownTheme,
                                 latexMathBlockStr:item.nodeText,
                                 latexImageCallback:markdownConfiguration.latexImageCallback,
                                 latexStrCallback:markdownConfiguration.latexStrCallback,
                             )
                         } else if (markdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultText) {
                             Text(item.nodeText)
                                .fontFamily(markdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontFamily)
                                .fontSize(markdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontSize)
                                .fontWeight(markdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontWeight)
                                .fontStyle(markdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontStyle)
                                .fontColor(markdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontColor)
                         }
                    }
                    .margin(
                        top: markdownConfiguration.markdownTheme.latexMathTheme.latexMathMarginTop,
                        right: markdownConfiguration.markdownTheme.latexMathTheme.latexMathMarginRight,
                        bottom: markdownConfiguration.markdownTheme.latexMathTheme.latexMathMarginBottom,
                        left: markdownConfiguration.markdownTheme.latexMathTheme.latexMathMarginLeft
                    )
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
                    .margin(
                        top: markdownConfiguration.markdownTheme.tableTheme.tableMarginTop,
                        right: markdownConfiguration.markdownTheme.tableTheme.tableMarginRight,
                        bottom: markdownConfiguration.markdownTheme.tableTheme.tableMarginBottom,
                        left: markdownConfiguration.markdownTheme.tableTheme.tableMarginLeft
                    )
                } else if (item.nodeType == "ThematicBreak") {
                    // 分割线
                    ListItem() {
                        MarkdownThematicBreakComponent(
                            markdownTheme: markdownConfiguration.markdownTheme
                        )
                    }
                    .margin(
                        top: markdownConfiguration.markdownTheme.dividerTheme.dividerMarginTop,
                        right: markdownConfiguration.markdownTheme.dividerTheme.dividerMarginRight,
                        bottom: markdownConfiguration.markdownTheme.dividerTheme.dividerMarginBottom,
                        left: markdownConfiguration.markdownTheme.dividerTheme.dividerMarginLeft
                    )
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
                    .margin(
                        top: markdownConfiguration.markdownTheme.footnoteDefTheme.footnoteDefMarginTop,
                        right: markdownConfiguration.markdownTheme.footnoteDefTheme.footnoteDefMarginRight,
                        bottom: markdownConfiguration.markdownTheme.footnoteDefTheme.footnoteDefMarginBottom,
                        left: markdownConfiguration.markdownTheme.footnoteDefTheme.footnoteDefMarginLeft
                    )
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
                    .margin(
                        top: markdownConfiguration.markdownTheme.definitionListTheme.definitionListMarginTop,
                        right: markdownConfiguration.markdownTheme.definitionListTheme.definitionListMarginRight,
                        bottom: markdownConfiguration.markdownTheme.definitionListTheme.definitionListMarginBottom,
                        left: markdownConfiguration.markdownTheme.definitionListTheme.definitionListMarginLeft
                    )
                } else if (item.nodeType == "SlideBlock") {
                    // 图片幻灯片
                    ListItem() {
                        MarkdownBannerComponent(
                            markdownTheme:markdownConfiguration.markdownTheme,
                            nodeView:item,
                            imageCallback:imageCallback
                        )
                    }
                    .margin(
                        top: markdownConfiguration.markdownTheme.bannerTheme.bannerMarginTop,
                        right: markdownConfiguration.markdownTheme.bannerTheme.bannerMarginRight,
                        bottom: markdownConfiguration.markdownTheme.bannerTheme.bannerMarginBottom,
                        left: markdownConfiguration.markdownTheme.bannerTheme.bannerMarginLeft
                    )
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
                    .margin(
                        top: markdownConfiguration.markdownTheme.videoTheme.videoMarginTop,
                        right: markdownConfiguration.markdownTheme.videoTheme.videoMarginRight,
                        bottom: markdownConfiguration.markdownTheme.videoTheme.videoMarginBottom,
                        left: markdownConfiguration.markdownTheme.videoTheme.videoMarginLeft
                    )
                } else if (item.nodeType == "BlockAudio") {
                    // 音频
                    ListItem() {
                        audioBuilder(
                            item,
                            markdownConfiguration.markdownTheme,
                            markdownConfiguration.audioCallback
                        )
                    }
                    .margin(
                        top: markdownConfiguration.markdownTheme.audioTheme.audioMarginTop,
                        right: markdownConfiguration.markdownTheme.audioTheme.audioMarginRight,
                        bottom: markdownConfiguration.markdownTheme.audioTheme.audioMarginBottom,
                        left: markdownConfiguration.markdownTheme.audioTheme.audioMarginLeft
                    )
                } else if (item.nodeType == "BlockAD") {
                    // 广告
                    ListItem() {
                        adBuilder(
                            item
                        )
                    }
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
                } else {
                    // 其他
                    ListItem() {
                        customBlockBuilder(
                            item,
                            idx
                        )
                    }
                }
            },
            keyGeneratorFunc: {
                item: NodeView, idx: Int64 => "${idx}-${item.nodeHash}-${item.contentHash}"
            }
        )
    }

    /**
     * 刷新数据
     */
    func refreshData(): Unit {
        if (markdownConfiguration.markdownTheme.globalTheme.isMarkdownParserSync) {
            // 同步解析
            let nodeview = mdparse()
            if (let Some(v) <- nodeview) {
                let refreshNodeViewChildren = v.children // 子节点数据
                let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
                let dataSourceSize: Int64 = nodeViewDataSource.totalCount() // 页面缓存的数据长度
                if (refreshNodeViewSize == 0) {
                    nodeViewDataSource.clear()
                    return
                }
                stringToNodes(refreshNodeViewChildren, refreshNodeViewSize, dataSourceSize)
            }
            return
        }
        // 异步解析
        if (isRefreshData.load()) {
            spawn {
                // 异步解析，加锁
                synchronized(parseReentrantMutex) {
                    isRefreshData.store(false)
                    let nodeview = mdparse()
                    if (let Some(v) <- nodeview) {
                        let refreshNodeViewChildren = v.children // 子节点数据
                        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
                        let dataSourceSize: Int64 = nodeViewDataSource.totalCount() // 页面缓存的数据长度
                        if (refreshNodeViewSize == 0) {
                            nodeViewDataSource.clear()
                            isRefreshData.store(true)
                            return
                        }
                        let syncCounter: SyncCounter = SyncCounter(1)
                        launch {
                            stringToNodes(refreshNodeViewChildren, refreshNodeViewSize, dataSourceSize)
                            syncCounter.dec()
                        }
                        syncCounter.waitUntilZero()
                    }
                    isRefreshData.store(true)
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
                incBase().parseIncremental(output)
            } else {
                // 全量解析
                markdownPlugin.toMarkdown(output)
            }
            oldOutput = output
            if (let Some(v) <- markdownConfiguration.nodeString) {
                v(NodeViewStringBuilder(doc))
            }
            imageAndVideoList.clear()
            imageAndVideoList.add(all: getProp<HashSet<String>>(doc, "links", HashSet<String>()).toArray())
            let nodeView: NodeView = NodeView()
            nodeToNodeView(doc, nodeView, nodeView, markdownConfiguration.markdownTheme.linkTheme.linkIsIcon)
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
    func stringToNodes(refreshNodeViewChildren: ArrayList<NodeView>, refreshNodeViewSize: Int64, dataSourceSize: Int64): Unit {
       if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            refreshDatas(dataSourceSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                if (refreshNodeViewChildren[i].nodeType == "Heading" || refreshNodeViewChildren[i].nodeType == "IdHeading") {
                    indexTocHashMap.add(i, i)
                } else if (refreshNodeViewChildren[i].nodeType == "FootnoteBlock") {
                    indexFootnoteHashMap.add(refreshNodeViewChildren[i].footnoteID(), i)
                }
                nodeViewDataSource.addData(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            refreshDatas(dataSourceSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
        } else {
            // 新数据小于页面数据
            refreshDatas(refreshNodeViewSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                nodeViewDataSource.deleteData(i)
            }
        }
        lastViewIndex = nodeViewDataSource.totalCount() - 1 // 页面缓存的数据长度
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
            if (refreshNodeView.nodeType == "Heading" || refreshNodeView.nodeType == "IdHeading") {
                indexTocHashMap.add(i, i)
            } else if (refreshNodeView.nodeType == "FootnoteBlock") {
                indexFootnoteHashMap.add(refreshNodeView.footnoteID(), i)
            }
            let newNodeHash = refreshNodeView.nodeHash
            let oldNodeHash = dataSourceNode.nodeHash
            if (newNodeHash != oldNodeHash) {
                // 自身节点唯一ID不相同需要刷新数据
                nodeViewDataSource.replaceData(i, refreshNodeView)
                continue
            }
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            if (newContentHash != oldContentHash) {
                // 子节点唯一ID不相同需要刷新子节点数据
                if (!markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockIsSeparate) {
                    // 非单独代码块
                    if (refreshNodeView.nodeType == "Paragraph") {
                        // 段落节点
                        let paragraphComponents = markdownCacheConfiguration.paragraphComponents
                        let cache = paragraphComponents.get(newNodeHash)
                        if (let Some(v) <- cache) {
                            v.refreshParagraphData(refreshNodeView)
                            nodeViewDataSource.update(i, refreshNodeView)
                        } else {
                            nodeViewDataSource.replaceData(i, refreshNodeView)
                        }
                        continue
                    }
                    if (refreshNodeView.nodeType == "Heading" || refreshNodeView.nodeType == "IdHeading") {
                        // 标题/标题ID节点
                        let headingComponents = markdownCacheConfiguration.headingComponents
                        let cache = headingComponents.get(newNodeHash)
                        if (let Some(v) <- cache) {
                            v.refreshHeadingData(refreshNodeView)
                            nodeViewDataSource.update(i, refreshNodeView)
                        } else {
                            nodeViewDataSource.replaceData(i, refreshNodeView)
                        }
                        continue
                    }
                    if (refreshNodeView.nodeType == "FencedCodeBlock") {
                        // 围栏代码块节点
                        let fencedCodeComponents = markdownCacheConfiguration.fencedCodeComponents
                        let cache = fencedCodeComponents.get(newNodeHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeView.nodeText, refreshNodeView.codeInfo(), refreshNodeView.nodeHash)
                            nodeViewDataSource.update(i, refreshNodeView)
                        } else {
                            nodeViewDataSource.replaceData(i, refreshNodeView)
                        }
                        continue
                    }
                    if (refreshNodeView.nodeType == "IndentedCodeBlock") {
                        // 缩进代码块节点
                        let indentedCodeComponents = markdownCacheConfiguration.indentedCodeComponents
                        let cache = indentedCodeComponents.get(newNodeHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeView.nodeText, Option<String>.None, refreshNodeView.nodeHash)
                            nodeViewDataSource.update(i, refreshNodeView)
                        } else {
                            nodeViewDataSource.replaceData(i, refreshNodeView)
                        }
                        continue
                    }
                    if (refreshNodeView.nodeType == "BulletList" || refreshNodeView.nodeType == "OrderedList") {
                        // 无序列表/有序列表节点
                        let listComponents = markdownCacheConfiguration.listComponents
                        let cache = listComponents.get(newNodeHash)
                        if (let Some(v) <- cache) {
                            v.refreshListData(refreshNodeView)
                            nodeViewDataSource.update(i, refreshNodeView)
                        } else {
                            nodeViewDataSource.replaceData(i, refreshNodeView)
                        }
                        continue
                    }
                    if (refreshNodeView.nodeType == "BlockQuote") {
                        // 块引用节点
                        let quoteComponents = markdownCacheConfiguration.quoteComponents
                        let cache = quoteComponents.get(newNodeHash)
                        if (let Some(v) <- cache) {
                            v.refreshQuoteData(refreshNodeView)
                            nodeViewDataSource.update(i, refreshNodeView)
                        } else {
                            nodeViewDataSource.replaceData(i, refreshNodeView)
                        }
                        continue
                    }
                    if (refreshNodeView.nodeType == "TableBlock") {
                        // 表格节点
                        let tableComponents = markdownCacheConfiguration.tableComponents
                        let cache = tableComponents.get(newNodeHash)
                        if (let Some(v) <- cache) {
                            v.refreshTableBlockData(refreshNodeView)
                            nodeViewDataSource.update(i, refreshNodeView)
                        } else {
                            nodeViewDataSource.replaceData(i, refreshNodeView)
                        }
                        continue
                    }
                    if (refreshNodeView.nodeType == "FootnoteBlock") {
                        // 脚注节点
                        let footnoteComponent = markdownCacheConfiguration.footnoteComponent
                        let cache = footnoteComponent.get(newNodeHash)
                        if (let Some(v) <- cache) {
                            v.refreshFootnoteData(refreshNodeView)
                            nodeViewDataSource.update(i, refreshNodeView)
                        } else {
                            nodeViewDataSource.replaceData(i, refreshNodeView)
                        }
                        continue
                    }
                    if (refreshNodeView.nodeType == "DescList") {
                        // 定义列表节点
                        let descListComponent = markdownCacheConfiguration.descListComponent
                        let cache = descListComponent.get(newNodeHash)
                        if (let Some(v) <- cache) {
                            v.refreshDescListData(refreshNodeView)
                            nodeViewDataSource.update(i, refreshNodeView)
                        } else {
                            nodeViewDataSource.replaceData(i, refreshNodeView)
                        }
                        continue
                    }
                    // 其他节点
                    nodeViewDataSource.replaceData(i, refreshNodeView)
                } else {
                    // 单独代码块
                    if (refreshNodeView.nodeType == "FencedCodeBlock") {
                        // 围栏代码块节点
                        let codeComponents = markdownCacheConfiguration.codeComponents
                        let cache = codeComponents.get(newNodeHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeView.nodeText, refreshNodeView.codeInfo(), refreshNodeView.nodeHash)
                            nodeViewDataSource.update(i, refreshNodeView)
                        } else {
                            nodeViewDataSource.replaceData(i, refreshNodeView)
                        }
                        continue
                    }
                    if (refreshNodeView.nodeType == "IndentedCodeBlock") {
                        // 缩进代码块节点
                        let codeComponents = markdownCacheConfiguration.codeComponents
                        let cache = codeComponents.get(newNodeHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeView.nodeText, Option<String>.None, refreshNodeView.nodeHash)
                            nodeViewDataSource.update(i, refreshNodeView)
                        } else {
                            nodeViewDataSource.replaceData(i, refreshNodeView)
                        }
                        continue
                    }
                    // 其他节点
                    nodeViewDataSource.replaceData(i, refreshNodeView)
                }
            }
        }
    }

    /**
     * 数据是否输入结束
     */
    func inputEndedData(): Unit {
    }

    /**
     * markdown是否增量解析
     */
    func analysisData(): Unit {

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
