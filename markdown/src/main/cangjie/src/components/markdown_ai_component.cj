/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.hilog.Hilog

/**
 * Markdown预览自定义控件
 */
@Component
public class MarkdownAIComponent {
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
    var markdownAIConfiguration: MarkdownAIConfiguration = MarkdownAIConfiguration.create()

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
    let markdownAICacheConfiguration: MarkdownAICacheConfiguration = MarkdownAICacheConfiguration()

    /**
     * 注脚事件回调数据
     */
    var indexHashMap: HashMap<String, Float64> = HashMap<String, Float64>()

    /**
     * list控制器
     */
    let scroller: Scroller = Scroller()

    /**
     * markdown插件
     */
    var markdownBase: ?Markdown = Option<Markdown>.None

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
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    /**
     * 所有图片视频的url
     */
    var imageAndVideoList: ArrayList<String> = ArrayList<String>()

    protected override func aboutToAppear(): Unit {
        markdownBase = Markdown
            .builder()
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
            .usePlugin(linkButton())
            // 脚注
            .usePlugin(FootnotePlugin.create())
            // 图片列表
            .usePlugin(ImageCollectPlugin.create())
            .build()
        incBase = IncreaseParser(markdownBase())
        // 控件宽度 = 屏幕宽度 - padding
        componentWidth = widthVpToPx(screenWidth, markdownAIConfiguration.markdownAITheme.imagePadding)
        // 首次加载
        refreshData()
    }

    func linkButton(): MarkdownPlugin {
        return if (markdownAIConfiguration.markdownAITheme.isLinkStyle) {
            LinkViewPlugin.create()
        } else {
            LinkifyPlugin.create()
        }
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        markdownAICacheConfiguration.clearAll()
    }

    func build() {
        if (!markdownAIConfiguration.markdownAITheme.isSeparateCodeBlock) {
            List(scroller: scroller) {
                LazyForEach(
                    nodeViewAIDataSource,
                    itemGeneratorFunc: {
                        item: NodeView, idx: Int64 => if (item.node is Heading) {
                            // 标题
                            ListItem() {
                                MarkdownAIHeadingComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    level: (item.node as Heading)().getLevel(),
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    imageCallback: imageCallback,
                                    componentWidth: px2vp(componentWidth.px).getOrThrow().value,
                                    imageMarginTop: markdownAIConfiguration.markdownAITheme.imageMarginTop,
                                    imageMarginBottom: markdownAIConfiguration.markdownAITheme.imageMarginBottom,
                                    isFull: isFull,
                                    indexList: indexAdd(indexList, idx),
                                    headingComponents: markdownAICacheConfiguration.headingComponents
                                )
                            }
                        } else if (item.node is Paragraph) {
                            // 段落
                            ListItem() {
                                MarkdownAIParagraphComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    footnoteBlock: Option<FootnoteBlock>.None,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    imageCallback: imageCallback,
                                    componentWidth: px2vp(componentWidth.px).getOrThrow().value,
                                    imageMarginTop: markdownAIConfiguration.markdownAITheme.imageMarginTop,
                                    imageMarginBottom: markdownAIConfiguration.markdownAITheme.imageMarginBottom,
                                    isFull: isFull,
                                    indexList: indexAdd(indexList, idx),
                                    paragraphComponents: markdownAICacheConfiguration.paragraphComponents
                                )
                            }
                        } else if (item.node is BulletList) {
                            // 无序列表（包含任务列表）
                            ListItem() {
                                MarkdownAIListComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    isOrdered: false,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    imageCallback: imageCallback,
                                    videoCallback: videoCallback,
                                    componentWidth: px2vp(componentWidth.px).getOrThrow().value,
                                    isFull: isFull,
                                    indexList: indexAdd(indexList, idx),
                                    markdownAICacheConfiguration: markdownAICacheConfiguration
                                )
                            }
                        } else if (item.node is OrderedList) {
                            // 有序列表
                            ListItem() {
                                MarkdownAIListComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    isOrdered: true,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    imageCallback: imageCallback,
                                    videoCallback: videoCallback,
                                    componentWidth: px2vp(componentWidth.px).getOrThrow().value,
                                    isFull: isFull,
                                    indexList: indexAdd(indexList, idx),
                                    markdownAICacheConfiguration: markdownAICacheConfiguration
                                )
                            }
                        } else if (item.node is BlockQuote) {
                            // 块引用
                            ListItem() {
                                MarkdownAIQuoteComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    imageCallback: imageCallback,
                                    videoCallback: videoCallback,
                                    componentWidth: px2vp(componentWidth.px).getOrThrow().value,
                                    isFull: isFull,
                                    indexList: indexAdd(indexList, idx),
                                    markdownAICacheConfiguration: markdownAICacheConfiguration
                                )
                            }
                        } else if (item.node is FencedCodeBlock) {
                            // 围栏代码块
                            ListItem() {
                                MarkdownAIFencedCodeBlockComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    indexList: indexAdd(indexList, idx),
                                    fencedCodeComponents: markdownAICacheConfiguration.fencedCodeComponents
                                )
                            }
                        } else if (item.node is IndentedCodeBlock) {
                            // 缩进代码块
                            ListItem() {
                                MarkdownAIIndentedCodeBlockComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                    info: Option<String>.None,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    indexList: indexAdd(indexList, idx),
                                    indentedCodeComponents: markdownAICacheConfiguration.indentedCodeComponents
                                )
                            }
                        } else if (item.node is TableBlock) {
                            // 表格
                            MarkdownAITableBlockComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                nodeViews: tableList(item.children),
                                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                componentWidth: px2vp(componentWidth.px).getOrThrow().value,
                                isFull: isFull,
                                indexList: indexAdd(indexList, idx),
                                tableComponents: markdownAICacheConfiguration.tableComponents,
                                tableRowComponents: markdownAICacheConfiguration.tableRowComponents,
                                tableCellComponents: markdownAICacheConfiguration.tableCellComponents
                            )
                        } else if (item.node is ThematicBreak) {
                            // 分割线
                            ListItem() {
                                Divider()
                                    // 设置分割线颜色
                                    .color(markdownAIConfiguration.markdownAITheme.thematicBreakColor)
                                    // 设置分割线宽度
                                    .strokeWidth(markdownAIConfiguration.markdownAITheme.thematicBreakHeight)
                                    // 设置外边距属性
                                    .margin(top: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins, bottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins)
                            }
                        } else if (item.node is BlockAudio) {
                            // 音频
                            ListItem() {
                                MarkdownAIImageAudioComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeView: item,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
                                )
                            }
                        } else if (item.node is BlockVideo) {
                            // 视频
                            ListItem() {
                                MarkdownAIImageVideoComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeView: item,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    videoCallback: videoCallback
                                )
                            }
                        } else if (item.node is LatexMathBlock) {
                            // 单行的数学公式
                            ListItem() {
                                if ((item.node as LatexMathBlock)().isClosed) {
                                    // 结束显示数学公式
                                    MarkdownAILatexMathBlockComponent(
                                        markdownAIConfiguration: markdownAIConfiguration,
                                        latexStr: (item.node as LatexMathBlock)().latex,
                                        marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                        marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
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
                                    MarkdownAIParagraphComponent(
                                        markdownAIConfiguration: markdownAIConfiguration,
                                        nodeViews: item.children[0].children,
                                        footnoteBlock: (item.node as FootnoteBlock)(),
                                        marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                        marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                        fontCallback: fontCallback,
                                        imageCallback: imageCallback,
                                        componentWidth: px2vp(componentWidth.px).getOrThrow().value,
                                        isFull: isFull,
                                        indexList: indexAdd(indexList, idx),
                                        paragraphComponents: markdownAICacheConfiguration.paragraphComponents
                                    )
                                } else {
                                    Text("")
                                }
                            }
                            // 组件区域变化时触发该回调
                            .onAreaChange {
                                oldValue, newValue => if (isFull) {
                                    indexHashMap.put((item.node as FootnoteBlock)().noteid, newValue.globalPosition.y)
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
            // 设置组件自身的宽度
            .width(100.percent)
            // 组件区域变化事件
            .onAreaChange {
                old, new =>
                    if(componentWidth != new.width){
                        Hilog.error(1,"1","----------------px2vp(new.width.px).getOrThrow().value:${px2vp(new.width.px).getOrThrow().value}")
                        componentWidth = new.width
                    }
            }
        } else {
            List(scroller: scroller) {
                LazyForEach(
                    nodeViewAIDataSource,
                    itemGeneratorFunc: {
                        item: NodeView, idx: Int64 => if (item.node is FencedCodeBlock) {
                            MarkdownAICodeComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                info: (item.node as FencedCodeBlock)().getInfo(),
                                indexList: indexAdd(indexList, idx),
                                isFull: isFull,
                                aiCodeComponents: markdownAICacheConfiguration.aiCodeComponents,
                                aiCodeTextComponents: markdownAICacheConfiguration.aiCodeTextComponents
                            )
                        } else if (item.node is IndentedCodeBlock) {
                            MarkdownAICodeComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                info: Option<String>.None,
                                indexList: indexAdd(indexList, idx),
                                isFull: isFull,
                                aiCodeComponents: markdownAICacheConfiguration.aiCodeComponents,
                                aiCodeTextComponents: markdownAICacheConfiguration.aiCodeTextComponents
                            )
                        }
                    }
                )
            }
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
            let nodeViewListSize: Int64 = nodeViewAIDataSource.totalCount() // 页面缓存的数据长度
            imageAndVideoList.clear()
            imageAndVideoList.appendAll(getProp<ArrayList<String>>(doc, "links", ArrayList<String>()))
            if (isFull) {
                // 全量加载
                let syncCounter:SyncCounter = SyncCounter(1)
                launch {
                    nodeViewAIDataSource.clear()
                    nodeViewAIDataSource.addDatas(nodeViews)
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
                        markdownAICacheConfiguration.clearAll()
                        if (nodeViewListSize != 0) {
                            // 更新页面最后一条数据
                            nodeViewAIDataSource.replaceData(nodeViewListSize - 1, nodeViews[nodeViewListSize - 1])
                        }
                        // 循环添加所有新增数据
                        for (i in nodeViewsSize - nodeViewListSize..0 : -1) {
                            nodeViewAIDataSource.addData(nodeViews[nodeViewsSize - i])
                        }
                    } else if (nodeViewsSize == nodeViewListSize) {
                        // 刷新数据的长度等于页面数据长度，需要更新当前数据
                        let index: Int64 = nodeViewListSize - 1
                        if (!markdownAIConfiguration.markdownAITheme.isSeparateCodeBlock) {
                            if ((nodeViews[nodeViewsSize - 1].node is BulletList && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is BulletList) || (nodeViews[nodeViewsSize - 1].node is OrderedList && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is OrderedList)) {
                                // 有序列表和无序列表
                                for (data in markdownAICacheConfiguration.listComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(nodeViews[nodeViewsSize - 1].children)
                                    }
                                }
                            } else if ((nodeViews[nodeViewsSize - 1].node is BlockQuote && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is BlockQuote)) {
                                // 块引用
                                for (data in markdownAICacheConfiguration.quoteComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(nodeViews[nodeViewsSize - 1].children)
                                    }
                                }
                            } else if ((nodeViews[nodeViewsSize - 1].node is Heading && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is Heading)) {
                                // 标题
                                for (data in markdownAICacheConfiguration.headingComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(nodeViews[nodeViewsSize - 1].children, (nodeViews[nodeViewsSize - 1].node as Heading)().getLevel())
                                    }
                                }
                            } else if ((nodeViews[nodeViewsSize - 1].node is Paragraph && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is Paragraph)) {
                                // 段落
                                for (data in markdownAICacheConfiguration.paragraphComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(nodeViews[nodeViewsSize - 1].children)
                                    }
                                }
                            } else if ((nodeViews[nodeViewsSize - 1].node is TableBlock && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is TableBlock)) {
                                // 表格
                                for (data in markdownAICacheConfiguration.tableComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(tableList(nodeViews[nodeViewsSize - 1].children))
                                    }
                                }
                            } else if ((nodeViews[nodeViewsSize - 1].node is IndentedCodeBlock && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is IndentedCodeBlock)) {
                                // 缩进代码
                                for (data in markdownAICacheConfiguration.indentedCodeComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(getCodeInfo(nodeViews[nodeViewsSize - 1])[0], getCodeInfo(nodeViews[nodeViewsSize - 1])[1])
                                    }
                                }
                            } else if ((nodeViews[nodeViewsSize - 1].node is FencedCodeBlock && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is FencedCodeBlock)) {
                                // 围栏代码
                                for (data in markdownAICacheConfiguration.fencedCodeComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(getCodeInfo(nodeViews[nodeViewsSize - 1])[0], getCodeInfo(nodeViews[nodeViewsSize - 1])[1])
                                    }
                                }
                            } else {
                                // 其他节点
                                nodeViewAIDataSource.replaceData(nodeViewListSize - 1, nodeViews[nodeViewsSize - 1])
                            }
                        } else {
                            if ((nodeViews[nodeViewsSize - 1].node is IndentedCodeBlock && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is IndentedCodeBlock)) {
                                // 缩进代码
                                for (data in markdownAICacheConfiguration.aiCodeComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(getCodeInfo(nodeViews[nodeViewsSize - 1])[0], getCodeInfo(nodeViews[nodeViewsSize - 1])[1])
                                    }
                                }
                            } else if ((nodeViews[nodeViewsSize - 1].node is FencedCodeBlock && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is FencedCodeBlock)) {
                                // 围栏代码
                                for (data in markdownAICacheConfiguration.aiCodeComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(getCodeInfo(nodeViews[nodeViewsSize - 1])[0], getCodeInfo(nodeViews[nodeViewsSize - 1])[1])
                                    }
                                }
                            } else {
                                // 其他节点
                                nodeViewAIDataSource.replaceData(nodeViewListSize - 1, nodeViews[nodeViewsSize - 1])
                            }
                        }
                    } else {
                        // 刷新数据小于页面数据长度，需要删除数据
                        // 清除缓存数据
                        markdownAICacheConfiguration.clearAll()
                        // 更新页面中间一条数据 - 刷新数据长度的最后一条数据
                        nodeViewAIDataSource.replaceData(nodeViewsSize - 1, nodeViews[nodeViewsSize - 1])
                        // 循环删除所有多余数据
                        for (i in nodeViewListSize - nodeViewsSize..0 : -1) {
                            nodeViewAIDataSource.deleteData(nodeViewListSize - i)
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
                arrayListNodeView.append(paragraphNodeView)
                let syncCounter:SyncCounter = SyncCounter(1)
                launch {
                    nodeViewAIDataSource.clear()
                    nodeViewAIDataSource.addDatas(arrayListNodeView)
                    syncCounter.dec()
                }
                syncCounter.waitUntilZero()
            }
        }
    }

    /**
     * 脚注点击回调
     */
    func fontCallback(noteid: String): Unit {
        if (let Some(v) <- indexHashMap.get(noteid)) {
            if (let Some(w) <- markdownAIConfiguration.footnoteCallback) {
                w(v)
            }
        }
    }

    /**
     * 图片点击回调
     */
    func imageCallback(url: String): Unit {
        if (let Some(v) <- markdownAIConfiguration.imageCallback) {
            v(url, imageAndVideoList)
        }
    }

    /**
     * 视频点击回调
     */
    func videoCallback(url: String): Unit {
        if (let Some(v) <- markdownAIConfiguration.videoCallback) {
            v(url, imageAndVideoList)
        }
    }
}
