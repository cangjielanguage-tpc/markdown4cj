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
    @Prop
    var markdownConfiguration: MarkdownConfiguration // markdown配置
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
    @BuilderParam
    var blockImageCardComponent: (?String,?String,?String) -> Unit = CustomBlockImageBuilder  //自定义卡片布局块级图片
    @BuilderParam
    var blockLinkCardComponent: (?String, ?String) -> Unit = CustomBlockLinkBuilder  //自定义卡片布局行内链接
    let screenWidth: Int32 = getDefaultDisplaySync().width // 屏幕宽度 - 单位px
    @State
    var componentWidth: Float64 = 0.0 // 控件宽度 - 单位vp
    @State
    var tableBlockComponentWidth: Float64 = 0.0 // 表格控件宽度 - 单位vp
    var indexFootnoteHashMap: HashMap<String, Int64> = HashMap<String, Int64>() // 脚注事件回调数据
    var indexTocHashMap: HashMap<Int64, Int64> = HashMap<Int64, Int64>() // toc事件回调数据
    let scroller: Scroller // list控制器
    let scrollerCode: Scroller = Scroller() // 单独代码块list控制器
    var incBase: ?IncreaseParserV2 = Option<IncreaseParserV2>.None // markdown解析器
    let parseReentrantMutex: Mutex = Mutex() // 锁
    let isRefreshData: AtomicBool = AtomicBool(true) // 刷新判定
    var nodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>()) // 懒加载数据源
    var imageAndVideoList: ArrayList<String> = ArrayList<String>() // 所有图片视频的url
    var oldOutput: String = "" // 上一次的输入内容
    let isThrottled: AtomicBool = AtomicBool(false) // 节流标志
    let hasPendingRefresh: AtomicBool = AtomicBool(false) // 节流期间有未处理的刷新请求
    let isAlive: AtomicBool = AtomicBool(true) // 组件存活标志（用于定时器回调守卫）
    var throttleTimer: ?Timer = None // 节流定时器
    @Provide["mdStickyHolder"]
    var stickyHolder: StickyScrollYHolder = StickyScrollYHolder() // 表格吸顶滚动Y持有者（@Provide供后代Table @Consume）
    @State
    var lastViewIndex: Int64 = 0 // 最后一条数据的位置

    protected override func aboutToAppear(): Unit {
        if (let Some(v) <- markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockIsDark) {
            if (v) {
                markdownConfiguration.markdownTheme.prismTheme = PrismThemeDarcula.create()
            } else {
                markdownConfiguration.markdownTheme.prismTheme = PrismThemeDefault.create()
            }
        }
        incBase = IncreaseParserV2(markdownPlugin) // 加载插件
        componentWidth = px2vp(Float64(screenWidth).px).getOrThrow().value // 默认控件宽度等于屏幕宽度
        tableBlockComponentWidth = componentWidth // 表格总宽度等于屏幕宽度
        // 表格吸顶初始化
        if (markdownConfiguration.markdownTheme.tableTheme.tableStickyHeader) {
            stickyHolder.setEnabled(true)
            stickyHolder.setScroller(scroller)
        }
        if (let Some(ctrl) <- markdownConfiguration.scrollController) {
            // 外层Scroll滚动模式（非固定高度场景）：页面通过controller传递relativeScrollY
            ctrl.setListener({ y: Float64 => stickyHolder.setY(y) })
        }
        refreshData() // 首次加载
        // 链接曝光初始化
        if (let Some(cb) <- markdownConfiguration.elementExposureCallback) {
            MarkdownLinkExposureRegistry.setExposureCallback(cb)
            MarkdownLinkExposureRegistry.setExposureThreshold(markdownConfiguration.exposureThreshold)
        }
    }

    protected override func aboutToDisappear(): Unit {
        isAlive.store(false)
        throttleTimer?.cancel()
        throttleTimer = None
        MarkdownRefreshRegistry.clear()
        MarkdownLinkExposureRegistry.clearData()
        MarkdownHighlightRegistry.clear()
        stickyHolder.clearListeners()
        if (let Some(ctrl) <- markdownConfiguration.scrollController) {
            ctrl.setListener(Option<(Float64) -> Unit>.None)
        }
    }

    /**
     * 是否启用元素曝光统计：仅当 elementExposureCallback 已设置时为 true
     */
    func isExposureEnabled(): Bool {
        return markdownConfiguration.elementExposureCallback.isSome()
    }

    func build() {
        if (!markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockIsSeparate) {
            List(scroller: scroller, space: markdownConfiguration.markdownTheme.globalTheme.markdownBlockSpacing) {
                baseMarkdownList()
            }
            .margin(top: markdownConfiguration.markdownTheme.globalTheme.blockMarginTop, right: markdownConfiguration.markdownTheme.globalTheme.blockMarginRight, bottom: markdownConfiguration.markdownTheme.globalTheme.blockMarginBottom, left: markdownConfiguration.markdownTheme.globalTheme.blockMarginLeft)
            .backgroundColor(markdownConfiguration.markdownTheme.globalTheme.backgroundColor)
            .listDirection(Axis.Vertical)
            .alignListItem(ListItemAlign.Start)
            .scrollBar(BarState.Off)
            .enableScrollInteraction(markdownConfiguration.markdownTheme.globalTheme.openGestureSwipe)
            .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))
            .onScroll({
                offset: Float64, state: ScrollState =>
                    // 内层List滚动模式（未提供scrollController时）：用List内部scrollY驱动吸顶
                    if (markdownConfiguration.markdownTheme.tableTheme.tableStickyHeader && markdownConfiguration.scrollController.isNone()) {
                        stickyHolder.setY(scroller.currentOffset().yOffset)
                    }
            })
            .interopOnSizeChange({
                old, new =>
                    if (componentWidth != new.width) {
                        componentWidth = new.width
                        tableBlockComponentWidth = new.width
                    }
            })
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
                                    nodeHash: item.nodeHash
                                )
                            }
                        } else {
                            ListItem() {
                                Text("")
                            }
                        }
                    },
                    keyGeneratorFunc: {
                        item: NodeView, idx: Int64 => "${idx}-${item.nodeHash}"
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
                            paragraphCustomParagraphLineBuilder: customParagraphLineBuilder,
                            paragraphTocListOnClick: tocListOnClick,
                            paragraphImageCallback: imageCallback,
                            paragraphFootnoteCallback: footnoteCallback,
                        )
                    }
                } else if (item.nodeType == "Heading" || item.nodeType == "IdHeading") {
                    // 标题/标题ID
                    ListItem() {
                        MarkdownHeadingComponent(
                            headingMarkdownConfiguration: markdownConfiguration,
                            headingNodeView: item,
                            headingComponentWidth: componentWidth,
                            headingCustomHeadingLineBuilder: customHeadingLineBuilder,
                            headingImageCallback: imageCallback,
                            headingFootnoteCallback: footnoteCallback,
                        )
                    }
                } else if (item.nodeType == "FencedCodeBlockListBlock") {
                    // 围栏代码块列表
                    ListItem() {
                        blockCodeBlockListComponent(
                            markdownConfiguration,
                            item,
                            toCodeList(item)
                        )
                    }
                } else if (item.nodeType == "FencedCodeBlock") {
                    // 围栏代码块
                    ListItem() {
                        MarkdownCodeFencedBlockComponent(
                            markdownConfiguration: markdownConfiguration,
                            codeText: item.nodeText,
                            info: item.codeInfo(),
                            nodeHash: item.nodeHash
                        )
                    }
                } else if (item.nodeType == "IndentedCodeBlock") {
                    // 缩进代码块
                    ListItem() {
                        MarkdownCodeIndentedBlockComponent(
                            markdownConfiguration: markdownConfiguration,
                            codeText: item.nodeText,
                            nodeHash: item.nodeHash
                        )
                    }
                } else if (item.nodeType == "BulletList") {
                    // 无序/任务列表
                    ListItem() {
                        MarkdownListComponent(
                            listMarkdownConfiguration: markdownConfiguration,
                            listNodeView: item,
                            listComponentWidth: componentWidth,
                            listTableBlockComponentWidth: tableBlockComponentWidth,
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
                            listDepth: 0,
                            blockImageCardComponent:blockImageCardComponent,
                            blockLinkCardComponent:blockLinkCardComponent
                        )
                    }
                } else if (item.nodeType == "OrderedList") {
                    // 有序列表
                    ListItem() {
                        MarkdownListComponent(
                            listMarkdownConfiguration: markdownConfiguration,
                            listNodeView: item,
                            listComponentWidth: componentWidth,
                            listTableBlockComponentWidth: tableBlockComponentWidth,
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
                            listDepth: 0,
                            blockImageCardComponent:blockImageCardComponent,
                            blockLinkCardComponent:blockLinkCardComponent
                        )
                    }
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
                            quoteFootnoteCallback: footnoteCallback,
                            quoteTocListOnClick: tocListOnClick,
                            quoteImageCallback: imageCallback,
                            quoteVideoCallback: videoCallback,
                            quoteDepth: 0,
                            blockImageCardComponent:blockImageCardComponent,
                            blockLinkCardComponent:blockLinkCardComponent
                        )
                    }
                } else if (item.nodeType == "LatexMathBlock") {
                    // 数学公式块
                    ListItem() {
                        if (item.isLatexMathBlockClose) {
                             MarkdownLatexMathBlockComponent(
                                 markdownTheme: markdownConfiguration.markdownTheme,
                                 latexMathBlockStr: item.nodeText,
                                 latexImageCallback: markdownConfiguration.latexImageCallback,
                                 latexStrCallback: markdownConfiguration.latexStrCallback,
                             )
                         } else if (markdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultText) {
                             Text(item.nodeText)
                                .fontFamily(markdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontFamily)
                                .fontSize(markdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontSize)
                                .fontWeight(markdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontWeight)
                                .fontStyle(markdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontStyle)
                                .fontColor(markdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontColor)
                                .padding(
                                    top: markdownConfiguration.markdownTheme.latexMathTheme.latexMathPaddingTop,
                                    right: markdownConfiguration.markdownTheme.latexMathTheme.latexMathPaddingRight,
                                    bottom: markdownConfiguration.markdownTheme.latexMathTheme.latexMathPaddingBottom,
                                    left: markdownConfiguration.markdownTheme.latexMathTheme.latexMathPaddingLeft
                                )
                                .margin(
                                    top: markdownConfiguration.markdownTheme.latexMathTheme.latexMathMarginTop,
                                    right: markdownConfiguration.markdownTheme.latexMathTheme.latexMathMarginRight,
                                    bottom: markdownConfiguration.markdownTheme.latexMathTheme.latexMathMarginBottom,
                                    left: markdownConfiguration.markdownTheme.latexMathTheme.latexMathMarginLeft
                                )
                         }
                    }
                } else if (item.nodeType == "TableBlock") {
                    // 表格
                    ListItem() {
                        MarkdownTableBlockComponent(
                            tableBlockMarkdownConfiguration: markdownConfiguration,
                            tableBlockNodeView: item,
                            tableBlockComponentWidth: tableBlockComponentWidth,
                            tableBlockCustomTableLineBuilder: customTableLineBuilder,
                            tableBlockImageCallback: imageCallback,
                            tableBlockFootnoteCallback: footnoteCallback,
                            tableBlockListItemIndex: Int32(idx),
                        )
                    }
                } else if (item.nodeType == "ThematicBreak") {
                    // 分割线
                    ListItem() {
                        MarkdownThematicBreakComponent(
                            markdownTheme: markdownConfiguration.markdownTheme
                        )
                    }
                } else if (item.nodeType == "FootnoteBlock") {
                    // 脚注
                    ListItem() {
                        MarkdownFootnoteComponent(
                            footnoteMarkdownConfiguration: markdownConfiguration,
                            footnoteNodeView: item,
                            footnoteComponentWidth: componentWidth,
                            footnoteCustomParagraphLineBuilder: customParagraphLineBuilder,
                            footnoteTocListOnClick: tocListOnClick,
                            footnoteImageCallback: imageCallback,
                            footnoteFootnoteCallback: footnoteCallback,
                        )
                    }
                } else if (item.nodeType == "DescList") {
                    // 定义列表
                    ListItem() {
                        MarkdownDescListComponent(
                            descListMarkdownConfiguration: markdownConfiguration,
                            descListNodeView: item,
                            descListComponentWidth: componentWidth,
                            descListCustomParagraphLineBuilder: customParagraphLineBuilder,
                            descListTocListOnClick: tocListOnClick,
                            descListImageCallback: imageCallback,
                            descListFootnoteCallback: footnoteCallback,
                        )
                    }
                } else if (item.nodeType == "SlideBlock") {
                    // 图片幻灯片
                    ListItem() {
                        MarkdownBannerComponent(
                            markdownTheme:markdownConfiguration.markdownTheme,
                            nodeView:item,
                            imageCallback:imageCallback
                        )
                    }
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
                } else if (item.nodeType == "BlockAudio") {
                    // 音频
                    ListItem() {
                        audioBuilder(
                            item,
                            markdownConfiguration.markdownTheme,
                            markdownConfiguration.audioCallback
                        )
                    }
                } else if (item.nodeType == "CustomCardImage") {
                    // 自定义卡片图片
                    ListItem() {
                        blockImageCardComponent(
                            item.imageAltText,
                            item.imageUrl,
                            item.imageTitle,
                        )
                    }
                } else if (item.nodeType == "CustomCardLink") {
                    // 自定义卡片链接
                    ListItem() {
                        blockLinkCardComponent(
                            item.linkUrl,
                            item.linkTitle,
                        )
                    }
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
                item: NodeView, idx: Int64 => if (item.nodeType == "LatexMathBlock") {
                    return "${idx}-${item.nodeHash}-${item.contentHash}"
                }
                if (item.nodeType == "TableBlock") {
                    return "${idx}-${item.nodeHash}-${markdownConfiguration.markdownTheme.tableTheme.tableStickyHeader}"
                }
                return "${idx}-${item.nodeHash}"
            }
        )
    }

    /**
     * 刷新数据
     * enableParseThrottle为true时，通过leading-edge节流控制解析频率
     * enableParseThrottle为false时，直接触发解析，由调用方自行控制节流
     */
    func refreshData(): Unit {
        if (!markdownConfiguration.markdownTheme.globalTheme.enableParseThrottle) {
            executeRefresh()
            return
        }
        if (isThrottled.load()) {
            hasPendingRefresh.store(true)
            return
        }
        isThrottled.store(true)
        hasPendingRefresh.store(false)
        executeRefresh()
        let throttleMs = markdownConfiguration.markdownTheme.globalTheme.parseThrottleMs
        if (throttleMs > 0) {
            throttleTimer = Timer.once(throttleMs * Duration.millisecond) {
                =>
                    throttleTimer = None
                    if (!isAlive.load()) {
                        return
                    }
                    isThrottled.store(false)
                    if (hasPendingRefresh.load()) {
                        launch { refreshData() }
                    }
            }
        } else {
            isThrottled.store(false)
        }
    }

    /**
     * 执行实际解析与数据更新
     * 通过smartUpdateDataArray驱动UI更新，无需页面缓存。
     * 根keyGenerator为"${idx}-${nodeHash}"（无contentHash），
     * contentHash变化时通过MarkdownRefreshRegistry就地刷新组件。
     * @Watch在LazyForEach的updateWithValueParams中不触发，
     * 因此依赖key变化触发组件重建（aboutToAppear→refreshXxxData）。
     * 异步解析期间若output再次变化（流式输出），解析完成后通过
     * oldOutput != output检查重新触发refreshData，确保不丢更新。
     */
    func executeRefresh(): Unit {
        if (markdownConfiguration.markdownTheme.globalTheme.isMarkdownParserSync) {
            // 同步解析
            let nodeview = mdparse()
            if (let Some(v) <- nodeview) {
                let refreshNodeViewChildren = v.children // 子节点数据
                if (refreshNodeViewChildren.size == 0) {
                    nodeViewDataSource.clear()
                    rebuildIndexes(ArrayList<NodeView>())
                    return
                }
                nodeViewDataSource.smartUpdateDataArray(refreshNodeViewChildren)
                rebuildIndexes(refreshNodeViewChildren)
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
                        let syncCounter: SyncCounter = SyncCounter(1)
                        launch {
                            if (refreshNodeViewChildren.size == 0) {
                                nodeViewDataSource.clear()
                                rebuildIndexes(ArrayList<NodeView>())
                            } else {
                                nodeViewDataSource.smartUpdateDataArray(refreshNodeViewChildren)
                                rebuildIndexes(refreshNodeViewChildren)
                            }
                            syncCounter.dec()
                        }
                        syncCounter.waitUntilZero()
                    }
                    isRefreshData.store(true)
                    // 流式输出保护：解析期间output若变化，重新触发解析
                    if (oldOutput != output) {
                        launch {
                            refreshData()
                        }
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
            nodeToNodeView(doc, nodeView, nodeView, markdownConfiguration, markdownConfiguration.markdownTheme.linkTheme.linkIsIcon)
            return nodeView
        } catch (e: Exception) {
            return Option<NodeView>.None
        }
    }

    /**
     * 重建TOC标题索引和脚注索引
     * 清空后从最新children重建，确保索引与数据源一致。
     *
     * @param children 子节点数据
     */
    func rebuildIndexes(children: ArrayList<NodeView>): Unit {
        indexTocHashMap.clear()
        indexFootnoteHashMap.clear()
        let highlightParagraphItems = ArrayList<String>()
        let size: Int64 = children.size
        for (i in 0..size) {
            if (children[i].nodeType == "Heading" || children[i].nodeType == "IdHeading") {
                indexTocHashMap.add(i, i)
                highlightParagraphItems.add("${children[i].nodeHash}")
            } else if (children[i].nodeType == "FootnoteBlock") {
                indexFootnoteHashMap.add(children[i].footnoteID.getOrThrow(), i)
            } else if (children[i].nodeType == "Paragraph" || children[i].nodeType == "TableBlock" || children[i].nodeType == "BlockQuote" || children[i].nodeType == "OrderedList" || children[i].nodeType == "BulletList") {
                highlightParagraphItems.add("${children[i].nodeHash}")
            }
        }
        markdownConfiguration.markdownHighlightParagraph.setAllParagraphItems(highlightParagraphItems)
        lastViewIndex = nodeViewDataSource.totalCount() - 1
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
