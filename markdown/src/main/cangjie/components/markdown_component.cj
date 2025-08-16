/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

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
     * 是否全量加载 - true：全量加载，fasle：增量加载
     */
    @Prop
    var isFull: Bool

    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration = MarkdownConfiguration.create()

    /**
     * markdown插件
     */
    var markdownBase: Markdown = Markdown.builder()
            // HTML插件
            .usePlugin(HtmlPlugin.create())
            // 任务列表插件
            .usePlugin(TaskListPlugin.create())
            // 删除线插件
            .usePlugin(StrikethroughPlugin.create())
            // 表格插件
            .usePlugin(TablePlugin.create())
            // 数学公式
            .usePlugin(LatexMathPluginV2.create())
            // 音频
            .usePlugin(BlockAudioPlugin.create())
            // 视频
            .usePlugin(BlockVideoPlugin.create())
            // 链接
            .usePlugin(LinkifyPlugin.create())
            // 脚注
            .usePlugin(FootnotePlugin.create())
            // 幻灯片
            .usePlugin(ImageSlidePlugin.create())
            // ImageStyle插件
            .usePlugin(ImageStylePlugin.create())
            // 代码列表标签
            .usePlugin(CodeListPlugin.create())
            // 图片列表
            .usePlugin(ImageCollectPlugin.create())
            // TOC列表插件
            .usePlugin(TocPlugin.create())
            .build()

    /**
     * 定位需要的数组
     */
    var indexList: ArrayList<Int64> = ArrayList<Int64>()

    /**
     * 屏幕宽度 - 单位px
     */
    let screenWidth: Int32 = getDefaultDisplaySync().width

    /**
     * 控件宽度 - 单位px，（控件宽度 = 屏幕宽度 - padding）
     */
    @State
    var componentWidth: Float64 = 0.0

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
    let parseReentrantMutex: ReentrantMutex = ReentrantMutex()

    /**
     * 刷新判定
     */
    let isRefreshData: AtomicBool = AtomicBool(true)

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    /**
     * 所有图片视频的url
     */
    var imageAndVideoList: ArrayList<String> = ArrayList<String>()

    protected override func aboutToAppear(): Unit {
        if(markdownConfiguration.markdownParser.isSome()){
            markdownBase = markdownConfiguration.markdownParser()
            incBase = IncreaseParser(markdownBase)
        }
        incBase = IncreaseParser(markdownBase)
        // 控件宽度 = 屏幕宽度
        componentWidth = Float64(screenWidth)
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
                        item: NodeView, idx: Int64 => if (item.node is Heading) {
                            // 标题
                            ListItem() {
                                MarkdownHeadingComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeViews: item.children,
                                    level: (item.node as Heading)().getLevel(),
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    imageCallback: imageCallback,
                                    componentWidth: versionAdaptation(componentWidth),
                                    imageMarginTop: markdownConfiguration.markdownTheme.imageMarginTop,
                                    imageMarginBottom: markdownConfiguration.markdownTheme.imageMarginBottom,
                                    isFull: isFull,
                                    isListTo:false,
                                    indexList: indexAdd(indexList, idx),
                                    headingComponents: markdownCacheConfiguration.headingComponents
                                )
                            }
                            // 组件区域变化时触发该回调
                            .onAreaChange {oldValue, newValue => indexTocHashMap.add(idx, newValue.globalPosition.y)}
                        } else if (item.node is Paragraph) {
                            // 段落
                            ListItem() {
                                MarkdownParagraphComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeViews: item.children,
                                    footnoteBlock: Option<FootnoteBlock>.None,
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    tocListOnClick: tocListOnClick,
                                    imageCallback: imageCallback,
                                    componentWidth: versionAdaptation(componentWidth),
                                    imageMarginTop: markdownConfiguration.markdownTheme.imageMarginTop,
                                    imageMarginBottom: markdownConfiguration.markdownTheme.imageMarginBottom,
                                    isFull: isFull,
                                    isListTo:false,
                                    indexList: indexAdd(indexList, idx),
                                    paragraphComponents: markdownCacheConfiguration.paragraphComponents
                                )
                            }
                        } else if (item.node is BulletList) {
                            // 无序列表（包含任务列表）
                            ListItem() {
                                MarkdownListComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeViews: item.children,
                                    isOrdered: false,
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    tocListOnClick: tocListOnClick,
                                    imageCallback: imageCallback,
                                    videoCallback: videoCallback,
                                    componentWidth: versionAdaptation(componentWidth),
                                    isFull: isFull,
                                    indexList: indexAdd(indexList, idx),
                                    markdownCacheConfiguration: markdownCacheConfiguration
                                )
                            }
                        } else if (item.node is OrderedList) {
                            // 有序列表
                            ListItem() {
                                MarkdownListComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeViews: item.children,
                                    isOrdered: true,
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    tocListOnClick: tocListOnClick,
                                    imageCallback: imageCallback,
                                    videoCallback: videoCallback,
                                    componentWidth: versionAdaptation(componentWidth),
                                    isFull: isFull,
                                    indexList: indexAdd(indexList, idx),
                                    markdownCacheConfiguration: markdownCacheConfiguration
                                )
                            }
                        } else if (item.node is BlockQuote) {
                            // 块引用
                            ListItem() {
                                MarkdownQuoteComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeViews: item.children,
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    tocListOnClick: tocListOnClick,
                                    imageCallback: imageCallback,
                                    videoCallback: videoCallback,
                                    componentWidth: versionAdaptation(componentWidth),
                                    isFull: isFull,
                                    indexList: indexAdd(indexList, idx),
                                    markdownCacheConfiguration: markdownCacheConfiguration
                                )
                            }
                        } else if (item.node is FencedCodeBlock) {
                            // 围栏代码块
                            ListItem() {
                                MarkdownFencedCodeBlockComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    indexList: indexAdd(indexList, idx),
                                    fencedCodeComponents: markdownCacheConfiguration.fencedCodeComponents
                                )
                            }
                        } else if (item.node is IndentedCodeBlock) {
                            // 缩进代码块
                            ListItem() {
                                MarkdownIndentedCodeBlockComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                    info: Option<String>.None,
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    indexList: indexAdd(indexList, idx),
                                    indentedCodeComponents: markdownCacheConfiguration.indentedCodeComponents
                                )
                            }
                        } else if (item.node is TableBlock) {
                            // 表格
                            MarkdownTableBlockComponent(
                                markdownConfiguration: markdownConfiguration,
                                nodeViews: tableList(item.children),
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                componentWidth: versionAdaptation(componentWidth),
                                isFull: isFull,
                                indexList: indexAdd(indexList, idx),
                                tableComponents: markdownCacheConfiguration.tableComponents,
                                tableRowComponents: markdownCacheConfiguration.tableRowComponents,
                                tableCellComponents: markdownCacheConfiguration.tableCellComponents
                            )
                        } else if (item.node is ThematicBreak) {
                            // 分割线
                            ListItem() {
                                MarkdownThematicBreakComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins + markdownConfiguration.markdownTheme.thematicBreakTopMargin,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins + markdownConfiguration.markdownTheme.thematicBreakBottomMargin
                                )
                            }
                        } else if (item.node is BlockAudio) {
                            // 音频
                            ListItem() {
                                MarkdownImageAudioComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeView: item,
                                    marginTop: markdownConfiguration.markdownTheme.audioMarginTop,
                                    marginBottom: markdownConfiguration.markdownTheme.audioMarginBottom
                                )
                            }
                        } else if (item.node is BlockVideo) {
                            // 视频
                            ListItem() {
                                MarkdownImageVideoComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeView: item,
                                    marginTop: markdownConfiguration.markdownTheme.videoMarginTop,
                                    marginBottom: markdownConfiguration.markdownTheme.videoMarginBottom,
                                    videoCallback: videoCallback
                                )
                            }
                        } else if (item.node is LatexMathBlock) {
                            // 单行的数学公式
                            ListItem() {
                                if ((item.node as LatexMathBlock)().isClosed) {
                                    // 结束显示数学公式
                                    MarkdownLatexMathBlockComponent(
                                        markdownConfiguration: markdownConfiguration,
                                        latexStr: (item.node as LatexMathBlock)().latex,
                                        marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                        marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
                                    )
                                } else {
                                    // 没结束显示纯文本
                                    Text((item.node as LatexMathBlock)().latex)
                                }
                            }
                        } else if (item.node is FootnoteBlock) {
                            // 脚注内容
                            ListItem() {
                                if (item.children.size > 0 && item.children[0].node is Paragraph) {
                                    MarkdownParagraphComponent(
                                        markdownConfiguration: markdownConfiguration,
                                        nodeViews: item.children[0].children,
                                        footnoteBlock: (item.node as FootnoteBlock)(),
                                        marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                        marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                        fontCallback: fontCallback,
                                        tocListOnClick: tocListOnClick,
                                        imageCallback: imageCallback,
                                        componentWidth: versionAdaptation(componentWidth),
                                        isFull: isFull,
                                        isListTo:false,
                                        indexList: indexAdd(indexList, idx),
                                        paragraphComponents: markdownCacheConfiguration.paragraphComponents
                                    )
                                } else {
                                    Text("")
                                }
                            }
                            // 组件区域变化时触发该回调
                            .onAreaChange {
                                oldValue, newValue => if (isFull) {
                                    indexFootnoteHashMap.add((item.node as FootnoteBlock)().noteid, newValue.globalPosition.y)
                                }
                            }
                        } else if (item.node is SlideBlock) {
                            // 图片幻灯片
                            ListItem() {
                                MarkdownImageBannerComponent(
                                    slideBlockNodeView: item,
                                    markdownConfiguration: markdownConfiguration,
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    imageCallback: imageCallback
                                )
                            }
                        } else if (item.node is FencedCodeBlockListBlock) {
                            // 组合代码
                            ListItem() {
                                MarkdownCodeBlockListComponent(
                                    nodeView: item,
                                    strInfos: toCodeList(item)[0],
                                    strText: toCodeList(item)[1],
                                    strInfoText: toCodeList(item)[2],
                                    markdownConfiguration: markdownConfiguration,
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
                                )
                            }
                        } else if (item.node is ImageSingleBlock) {
                            // 单独图片block
                            ListItem() {
                                if(item.children.size  > 0 && item.children[0].node is CommonmarkImage){
                                    Image((item.children[0].node as CommonmarkImage)().getDestination())
                                        // 设置约束尺寸
                                        .constraintSize(maxWidth: 100.percent)
                                        // 设置图片的缩放类型
                                        .objectFit(ImageFit.Contain)
                                        // 点击动作触发该方法调用
                                        .onClick {
                                            evt => imageOnClick((item.children[0].node as CommonmarkImage)().getDestination(), imageCallback)
                                        }
                                }else{
                                    Text("")
                                }
                            }
                        } else {
                            // TODO 其他节点
                            ListItem() {
                                Text("")
                            }
                        }
                    }
                )
            }
            // 设置List组件排列方向
            .listDirection(Axis.Vertical)
            // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
            .alignListItem(ListItemAlign.Start)
            // 组件区域变化事件
            .onAreaChange {
                old, new =>
                    if(componentWidth != new.width){
                        componentWidth = new.width
                    }
            }
            // 设置向前向后两个方向上的嵌套滚动模式，实现与父组件的滚动联动。
            .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))
        } else {
            List(scroller: scroller) {
                LazyForEach(
                    nodeViewDataSource,
                    itemGeneratorFunc: {
                        item: NodeView, idx: Int64 => if (idx == 0 && item.node is FencedCodeBlock) {
                            ListItem(){
                                MarkdownCodeComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                    indexList: indexAdd(indexList, idx),
                                    isFull: isFull,
                                    codeComponents: markdownCacheConfiguration.codeComponents,
                                    codeTextComponents: markdownCacheConfiguration.codeTextComponents
                                )
                            }
                        } else if (idx == 0 && item.node is IndentedCodeBlock) {
                            ListItem(){
                                MarkdownCodeComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                    info: Option<String>.None,
                                    indexList: indexAdd(indexList, idx),
                                    isFull: isFull,
                                    codeComponents: markdownCacheConfiguration.codeComponents,
                                    codeTextComponents: markdownCacheConfiguration.codeTextComponents
                                )
                            }
                        } else {
                            ListItem(){
                                Text("")
                            }
                        }
                    }
                )
            }
            // 嵌套滚动选项。设置向前向后两个方向上的嵌套滚动模式，实现与父组件的滚动联动。
            .nestedScroll(NestedScrollOptions(NestedScrollMode.PARENT_FIRST, NestedScrollMode.PARENT_FIRST))
        }
    }

    /**
     * 刷新数据
     */
    func refreshData(): Unit {
        // 上一步解析完成才继续解析
        if (isRefreshData.load()) {
            spawn {
                // 异步解析，加锁
                synchronized(parseReentrantMutex) {
                    isRefreshData.store(false)
                    stringToNodes()
                    isRefreshData.store(true)
                }
            }
        }
    }

    /**
     * 将String转换成ArrayList<NodeView>，将解析的列表添加到懒加载的数据源中
     */
    func stringToNodes(): Unit {
        try {
            incBase().input = output
            incBase().parse()
            let doc: NodeView = incBase().docView
            let nodeViews: ArrayList<NodeView> = doc.children
            let nodeViewsSize: Int64 = nodeViews.size // 刷新进来的数据长度
            let nodeViewListSize: Int64 = nodeViewDataSource.totalCount() // 页面缓存的数据长度
            imageAndVideoList.clear()
            imageAndVideoList.add(all: getProp<ArrayList<String>>(doc, "links", ArrayList<String>()))
            if (isFull) {
                // 全量加载
                let syncCounter:SyncCounter = SyncCounter(1)
                launch {
                    nodeViewDataSource.clear()
                    nodeViewDataSource.addDatas(nodeViews)
                    syncCounter.dec()
                }
                syncCounter.waitUntilZero()
            } else {
                // 增量加载
                let syncCounter:SyncCounter = SyncCounter(1)
                launch {
                    if (nodeViewsSize == 0) {
                        syncCounter.dec()
                        return
                    }
                    if (nodeViewsSize > nodeViewListSize) {
                        // 刷新数据的长度大于页面数据长度，需要添加数据
                        // 清除缓存数据
                        markdownCacheConfiguration.clearAll()
                        if (nodeViewListSize != 0) {
                            // 更新页面最后一条数据
                            nodeViewDataSource.replaceData(nodeViewListSize - 1, nodeViews[nodeViewListSize - 1])
                        }
                        // 循环添加所有新增数据
                        for (i in nodeViewsSize - nodeViewListSize..0 : -1) {
                            nodeViewDataSource.addData(nodeViews[nodeViewsSize - i])
                        }
                    } else if (nodeViewsSize == nodeViewListSize) {
                        // 刷新数据的长度等于页面数据长度，需要更新当前数据
                        let index: Int64 = nodeViewListSize - 1
                        if (!markdownConfiguration.markdownTheme.isSeparateCodeBlock) {
                            if ((nodeViews[nodeViewsSize - 1].node is BulletList && nodeViewDataSource.getData(nodeViewListSize - 1).node is BulletList) || (nodeViews[nodeViewsSize - 1].node is OrderedList && nodeViewDataSource.getData(nodeViewListSize - 1).node is OrderedList)) {
                                // 有序列表和无序列表
                                for (data in markdownCacheConfiguration.listComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(nodeViews[nodeViewsSize - 1].children)
                                    }
                                }
                            } else if ((nodeViews[nodeViewsSize - 1].node is BlockQuote && nodeViewDataSource.getData(nodeViewListSize - 1).node is BlockQuote)) {
                                // 块引用
                                for (data in markdownCacheConfiguration.quoteComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(nodeViews[nodeViewsSize - 1].children)
                                    }
                                }
                            } else if ((nodeViews[nodeViewsSize - 1].node is Heading && nodeViewDataSource.getData(nodeViewListSize - 1).node is Heading)) {
                                // 标题
                                for (data in markdownCacheConfiguration.headingComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(nodeViews[nodeViewsSize - 1].children, (nodeViews[nodeViewsSize - 1].node as Heading)().getLevel())
                                    }
                                }
                            } else if ((nodeViews[nodeViewsSize - 1].node is Paragraph && nodeViewDataSource.getData(nodeViewListSize - 1).node is Paragraph)) {
                                // 段落
                                for (data in markdownCacheConfiguration.paragraphComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(nodeViews[nodeViewsSize - 1].children)
                                    }
                                }
                            } else if ((nodeViews[nodeViewsSize - 1].node is TableBlock && nodeViewDataSource.getData(nodeViewListSize - 1).node is TableBlock)) {
                                // 表格
                                for (data in markdownCacheConfiguration.tableComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(tableList(nodeViews[nodeViewsSize - 1].children))
                                    }
                                }
                            } else if ((nodeViews[nodeViewsSize - 1].node is IndentedCodeBlock && nodeViewDataSource.getData(nodeViewListSize - 1).node is IndentedCodeBlock)) {
                                // 缩进代码
                                for (data in markdownCacheConfiguration.indentedCodeComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(getCodeInfo(nodeViews[nodeViewsSize - 1])[0], getCodeInfo(nodeViews[nodeViewsSize - 1])[1])
                                    }
                                }
                            } else if ((nodeViews[nodeViewsSize - 1].node is FencedCodeBlock && nodeViewDataSource.getData(nodeViewListSize - 1).node is FencedCodeBlock)) {
                                // 围栏代码
                                for (data in markdownCacheConfiguration.fencedCodeComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(getCodeInfo(nodeViews[nodeViewsSize - 1])[0], getCodeInfo(nodeViews[nodeViewsSize - 1])[1]())
                                    }
                                }
                            } else {
                                // 其他节点
                                nodeViewDataSource.replaceData(nodeViewListSize - 1, nodeViews[nodeViewsSize - 1])
                            }
                        } else {
                            if ((nodeViews[nodeViewsSize - 1].node is IndentedCodeBlock && nodeViewDataSource.getData(nodeViewListSize - 1).node is IndentedCodeBlock)) {
                                // 缩进代码
                                for (data in markdownCacheConfiguration.codeComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(getCodeInfo(nodeViews[nodeViewsSize - 1])[0], getCodeInfo(nodeViews[nodeViewsSize - 1])[1])
                                    }
                                }
                            } else if ((nodeViews[nodeViewsSize - 1].node is FencedCodeBlock && nodeViewDataSource.getData(nodeViewListSize - 1).node is FencedCodeBlock)) {
                                // 围栏代码
                                for (data in markdownCacheConfiguration.codeComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(getCodeInfo(nodeViews[nodeViewsSize - 1])[0], getCodeInfo(nodeViews[nodeViewsSize - 1])[1])
                                    }
                                }
                            } else {
                                // 其他节点
                                nodeViewDataSource.replaceData(nodeViewListSize - 1, nodeViews[nodeViewsSize - 1])
                            }
                        }
                    } else {
                        // 刷新数据小于页面数据长度，需要删除数据
                        // 清除缓存数据
                        markdownCacheConfiguration.clearAll()
                        // 更新页面中间一条数据 - 刷新数据长度的最后一条数据
                        nodeViewDataSource.replaceData(nodeViewsSize - 1, nodeViews[nodeViewsSize - 1])
                        // 循环删除所有多余数据
                        for (i in nodeViewListSize - nodeViewsSize..0 : -1) {
                            nodeViewDataSource.deleteData(nodeViewListSize - i)
                        }
                    }
                    syncCounter.dec()
                }
                syncCounter.waitUntilZero()
            }
        } catch (e: Exception) {
            // 解析异常，全量展示纯文本，增量不做处理
            if (isFull) {
                let paragraph: Paragraph = Paragraph()
                let commonmarkText: CommonmarkText = CommonmarkText(output)
                paragraph.appendChild(commonmarkText)
                let paragraphNodeView: NodeView = buildView(paragraph, true)
                let textNodeView: NodeView = buildView(commonmarkText, true)
                let arrayListNodeView: ArrayList<NodeView> = ArrayList<NodeView>()
                arrayListNodeView.add(paragraphNodeView)
                let syncCounter:SyncCounter = SyncCounter(1)
                launch {
                    nodeViewDataSource.clear()
                    nodeViewDataSource.addDatas(arrayListNodeView)
                    syncCounter.dec()
                }
                syncCounter.waitUntilZero()
            }
        }
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
    func fontCallback(noteid: String): Unit {
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
