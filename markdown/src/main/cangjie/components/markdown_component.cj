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
        .build()

    /**
     * 广告布局
     */
    @BuilderParam
    var adBuilder: (NodeView) -> Unit = ADBuilder

    /**
     * 视频布局
     */
    @BuilderParam
    var videoBuilder: (NodeView, MarkdownConfiguration, (String) -> Unit) -> Unit = VideoBuilder

    /**
     * 音频布局
     */
    @BuilderParam
    var audioBuilder: (NodeView, MarkdownConfiguration) -> Unit = AudioBuilder

    /**
     * 定位需要的数组
     */
    var indexList: ArrayList<Int64> = ArrayList<Int64>()

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

    @State
    var lastViewIndex: Int64 = 0

    protected override func aboutToAppear(): Unit {
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
                        item: NodeView, idx: Int64 => if (item.node is Heading) {
                            // 标题
                            ListItem() {
                                blockHeadingComponent(markdownConfiguration, item, fontCallback, imageCallback, componentWidth, false, markdownCacheConfiguration.headingComponents)
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 0, item), bottom: marginNodeBottom(idx, lastViewIndex, 0, item))
                            // 组件区域变化时触发该回调
                            .onAreaChange {oldValue, newValue => indexTocHashMap.add(idx, newValue.globalPosition.y)}
                        } else if (item.node is Paragraph) {
                            // 段落
                            ListItem() {
                                blockParagraphComponent(markdownConfiguration, item, Option<FootnoteBlock>.None, fontCallback, tocListOnClick, imageCallback, componentWidth, false, false, markdownCacheConfiguration.paragraphComponents)
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 1, item), bottom: marginNodeBottom(idx, lastViewIndex, 1, item))
                        } else if (item.node is BulletList) {
                            // 无序列表（包含任务列表）
                            ListItem() {
                                MarkdownListComponent(markdownConfiguration: markdownConfiguration, nodeView: item, adBuilder: adBuilder, videoBuilder: videoBuilder, audioBuilder: audioBuilder, isOrdered: false, fontCallback: fontCallback, tocListOnClick: tocListOnClick, imageCallback: imageCallback, videoCallback: videoCallback, componentWidth: componentWidth, markdownCacheConfiguration: markdownCacheConfiguration, indexFootnoteHashMap: indexFootnoteHashMap)
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 3, item), bottom: marginNodeBottom(idx, lastViewIndex, 3, item))
                        } else if (item.node is OrderedList) {
                            // 有序列表
                            ListItem() {
                                MarkdownListComponent(markdownConfiguration: markdownConfiguration, nodeView: item, adBuilder: adBuilder, videoBuilder: videoBuilder, audioBuilder: audioBuilder, isOrdered: true, fontCallback: fontCallback, tocListOnClick: tocListOnClick, imageCallback: imageCallback, videoCallback: videoCallback, componentWidth: componentWidth, markdownCacheConfiguration: markdownCacheConfiguration, indexFootnoteHashMap: indexFootnoteHashMap)
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 3, item), bottom: marginNodeBottom(idx, lastViewIndex, 3, item))
                        } else if (item.node is BlockQuote) {
                            // 块引用
                            ListItem() {
                                MarkdownQuoteComponent(markdownConfiguration: markdownConfiguration, nodeView: item, adBuilder: adBuilder, videoBuilder: videoBuilder, audioBuilder: audioBuilder, fontCallback: fontCallback, tocListOnClick: tocListOnClick, imageCallback: imageCallback, videoCallback: videoCallback, componentWidth: componentWidth, markdownCacheConfiguration: markdownCacheConfiguration, indexFootnoteHashMap: indexFootnoteHashMap)
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 3, item), bottom: marginNodeBottom(idx, lastViewIndex, 3, item))
                        } else if (item.node is FencedCodeBlock) {
                            // 围栏代码块
                            ListItem() {
                                blockFencedCodeComponent(markdownConfiguration, item, markdownCacheConfiguration.fencedCodeComponents)
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 3, item), bottom: marginNodeBottom(idx, lastViewIndex, 3, item))
                        } else if (item.node is IndentedCodeBlock) {
                            // 缩进代码块
                            ListItem() {
                                blockIndentedCodeComponent(markdownConfiguration, item, markdownCacheConfiguration.indentedCodeComponents)
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 3, item), bottom: marginNodeBottom(idx, lastViewIndex, 3, item))
                        } else if (item.node is TableBlock) {
                            // 表格
                            ListItem() {
                                blockTableComponent(markdownConfiguration, item, fontCallback, imageCallback, componentWidth, markdownCacheConfiguration.tableComponents, markdownCacheConfiguration.tableRowComponents, markdownCacheConfiguration.tableCellComponents)
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 3, item), bottom: marginNodeBottom(idx, lastViewIndex, 3, item))
                        } else if (item.node is ThematicBreak) {
                            // 分割线
                            ListItem() {
                                MarkdownThematicBreakComponent(markdownConfiguration: markdownConfiguration)
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 2, item), bottom: marginNodeBottom(idx, lastViewIndex, 2, item))
                        } else if (item.node is DescList) {
                            // 定义列表
                            ListItem() {
                                MarkdownDescListComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeView: item,
                                    fontCallback: fontCallback,
                                    tocListOnClick: tocListOnClick,
                                    imageCallback: imageCallback,
                                    componentWidth: componentWidth,
                                    markdownCacheConfiguration: markdownCacheConfiguration
                                )
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 3, item), bottom: marginNodeBottom(idx, lastViewIndex, 3, item))
                        } else if (item.node is BlockAudio) {
                            // 音频
                            ListItem() {
                                audioBuilder(item, markdownConfiguration)
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 3, item), bottom: marginNodeBottom(idx, lastViewIndex, 3, item))
                        } else if (item.node is BlockVideo) {
                            // 视频
                            ListItem() {
                                videoBuilder(item, markdownConfiguration, videoCallback)
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 3, item), bottom: marginNodeBottom(idx, lastViewIndex, 3, item))
                        } else if (item.node is LatexMathBlock) {
                            // 单行的数学公式
                            ListItem() {
                                blockLatextComponent(markdownConfiguration, item)
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 3, item), bottom: marginNodeBottom(idx, lastViewIndex, 3, item))
                        } else if (item.node is FootnoteBlock) {
                            // 脚注内容
                            ListItem() {
                                MarkdownFootnoteComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeView: item,
                                    fontCallback: fontCallback,
                                    tocListOnClick: tocListOnClick,
                                    imageCallback: imageCallback,
                                    componentWidth: componentWidth,
                                    markdownCacheConfiguration: markdownCacheConfiguration
                                )
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 3, item), bottom: marginNodeBottom(idx, lastViewIndex, 3, item))
                            // 组件区域变化时触发该回调
                            .onAreaChange {
                                oldValue, newValue => indexFootnoteHashMap.add((item.node as FootnoteBlock)().noteid, newValue.globalPosition.y)
                            }
                        } else if (item.node is SlideBlock) {
                            // 图片幻灯片
                            ListItem() {
                                blockImageBannerComponent(markdownConfiguration, item, imageCallback)
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 3, item), bottom: marginNodeBottom(idx, lastViewIndex, 3, item))
                        } else if (item.node is FencedCodeBlockListBlock) {
                            // 组合代码
                            ListItem() {
                                blockCodeBlockListComponent(markdownConfiguration, item, toCodeList(item))
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 3, item), bottom: marginNodeBottom(idx, lastViewIndex, 3, item))
                        } else if (item.node is BlockAD) {
                            // 广告
                            ListItem() {
                                adBuilder(item)
                            }
                            // 设置外边距属性
                            .margin(top: marginNodeTop(idx, 3, item), bottom: marginNodeBottom(idx, lastViewIndex, 3, item))
                        } else {
                            // TODO 其他节点
                            ListItem() {
                                Text("")
                            }
                        }
                    },
                    keyGeneratorFunc: {
                        item: NodeView, idx: Int64 => return "${idx}-${item.nodeHash}-${item.contentHash}"
                    }
                )
            }
            // 设置List组件排列方向
            .listDirection(Axis.Vertical)
            // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
            .alignListItem(ListItemAlign.Start)
            // 组件区域变化事件
            .onAreaChange {
                old, new => if (componentWidth != new.width) {
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
                        item: NodeView, idx: Int64 => if (idx == 0 && (item.node is FencedCodeBlock || item.node is IndentedCodeBlock)) {
                            ListItem() {
                                MarkdownCodeComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeView: item,
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
                        item: NodeView, idx: Int64 => return "${idx}-${item.nodeHash}-${item.contentHash}"
                    }
                )
            }
            // 嵌套滚动选项。设置向前向后两个方向上的嵌套滚动模式，实现与父组件的滚动联动。
            .nestedScroll(NestedScrollOptions(NestedScrollMode.PARENT_FIRST, NestedScrollMode.PARENT_FIRST))
        }
    }

    /**
     * 上边距
     *
     * @param idx 第几条数据
     * @param nodeType 类型。0：标题，1：段落，2：分割线，3：其他
     * @param item nodeView对象
     * @return Float64 上边距
     */
    func marginNodeTop(idx: Int64, nodeType: Int64, item: NodeView): Float64 {
        return if (idx == 0) {
            markdownConfiguration.markdownTheme.blockFirstTopMargin
        } else {
            if (nodeType == 0) {
                if (item.children.size == 1 && item.children[0].node is CommonmarkImage) {
                    0.0
                } else {
                    markdownConfiguration.markdownTheme.headingTopMargins
                }
            } else if (nodeType == 1) {
                if (item.children.size == 1 && item.children[0].node is CommonmarkImage) {
                    0.0
                } else {
                    markdownConfiguration.markdownTheme.paragraphTopMargins
                }
            } else if (nodeType == 2) {
                markdownConfiguration.markdownTheme.blockTopAndBottomMargins + markdownConfiguration.markdownTheme.thematicBreakTopMargin
            } else {
                markdownConfiguration.markdownTheme.blockTopAndBottomMargins
            }
        }
    }

    /**
     * 下边距
     *
     * @param idx 第几条数据
     * @param nodeType 类型。0：标题，1：段落，2：分割线，3：其他
     * @param item nodeView对象
     * @return Float64 下边距
     */
    func marginNodeBottom(idx: Int64, lastViewIndex: Int64, nodeType: Int64, item: NodeView): Float64 {
        return if (idx == lastViewIndex) {
            markdownConfiguration.markdownTheme.blockLastBottomMargin
        } else {
            if (nodeType == 0) {
                if (item.children.size == 1 && item.children[0].node is CommonmarkImage) {
                    0.0
                } else {
                    markdownConfiguration.markdownTheme.headingBottomMargins
                }
            } else if (nodeType == 1) {
                if (item.children.size == 1 && item.children[0].node is CommonmarkImage) {
                    0.0
                } else {
                    markdownConfiguration.markdownTheme.paragraphBottomMargins
                }
            } else if (nodeType == 2) {
                markdownConfiguration.markdownTheme.blockTopAndBottomMargins + markdownConfiguration.markdownTheme.thematicBreakBottomMargin
            } else {
                markdownConfiguration.markdownTheme.blockTopAndBottomMargins
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
            let doc = incBase().docView
            if (let Some(v) <- markdownConfiguration.nodeString) {
                v(NodeViewStringBuilder(doc))
            }
            let refreshNodeViews: ArrayList<NodeView> = doc.children
            let refreshNodeViewSize: Int64 = refreshNodeViews.size // 刷新进来的数据长度
            let dataSourceSize: Int64 = nodeViewDataSource.totalCount() // 页面缓存的数据长度
            imageAndVideoList.clear()
            imageAndVideoList.add(all: getProp<ArrayList<String>>(doc, "links", ArrayList<String>()))

            let syncCounter: SyncCounter = SyncCounter(1)
            launch {
                if (refreshNodeViewSize == 0) {
                    syncCounter.dec()
                    return
                }
                if (refreshNodeViewSize > dataSourceSize) {
                    // 新数据大于页面数据
                    // 循环判断历史数据有没有做过修改
                    for (i in 0..dataSourceSize) {
                        updateNodeViewData(i, refreshNodeViews[i], refreshNodeViewSize > dataSourceSize)
                    }
                    // 循环添加新数据
                    for (i in dataSourceSize..refreshNodeViewSize) {
                        nodeViewDataSource.addData(refreshNodeViews[i])
                    }
                } else if (refreshNodeViewSize == dataSourceSize) {
                    // 新数据等于页面数据
                    for (i in 0..dataSourceSize) {
                        updateNodeViewData(i, refreshNodeViews[i], refreshNodeViewSize == dataSourceSize)
                    }
                } else {
                    // 新数据小于页面数据
                    // 循环判断历史数据有没有做过修改
                    for (i in 0..refreshNodeViewSize) {
                        updateNodeViewData(i, refreshNodeViews[i], refreshNodeViewSize < dataSourceSize)
                    }
                    // 循环删除多余的旧数据
                    for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                        nodeViewDataSource.deleteData(i)
                    }
                }
                lastViewIndex = nodeViewDataSource.totalCount() - 1 // 页面缓存的数据长度
                syncCounter.dec()
            }
            syncCounter.waitUntilZero()
        } catch (e: Exception) {
        }
    }

    /**
     * 更新NodeView数据（抽取三个分支中重复的核心判断逻辑）
     * @param index 数据索引
     * @param newNodeView 新的NodeView数据
     * @param isLessThan 是否是新数据小于页面数据的场景（用于扩展DescList判断）
     */
    private func updateNodeViewData(index: Int64, newNodeView: NodeView, isLessThan: Bool): Unit {
        let newBlockHash = newNodeView.nodeHash
        let oldBlockHash = nodeViewDataSource.getData(index).nodeHash
        let newContentHash = newNodeView.contentHash
        let oldContentHash = nodeViewDataSource.getData(index).contentHash
        // 唯一ID是否相同
        if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
            nodeViewDataSource.replaceData(index, newNodeView)
        } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
            nodeViewDataSource.replaceData(index, newNodeView)
        } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
            if (!markdownConfiguration.markdownTheme.isSeparateCodeBlock) {
                if (newNodeView.node is BulletList || newNodeView.node is OrderedList) {
                    // 有序列表和无序列表
                    let cache = markdownCacheConfiguration.listComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(newNodeView)
                    }
                } else if (newNodeView.node is IndentedCodeBlock) {
                    // 缩进代码
                    let cache = markdownCacheConfiguration.indentedCodeComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(newNodeView)
                    }
                } else if (newNodeView.node is FencedCodeBlock) {
                    // 围栏代码
                    let cache = markdownCacheConfiguration.fencedCodeComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(getCodeInfo(newNodeView)[0], getCodeInfo(newNodeView)[1](), newNodeView.nodeHash)
                    }
                } else if (newNodeView.node is Heading) {
                    // 标题
                    let cache = markdownCacheConfiguration.headingComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(newNodeView)
                    }
                } else if (newNodeView.node is Paragraph) {
                    // 段落
                    let cache = markdownCacheConfiguration.paragraphComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(newNodeView)
                    }
                } else if (newNodeView.node is TableBlock) {
                    // 表格
                    let cache = markdownCacheConfiguration.tableComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(newNodeView)
                    }
                } else if (newNodeView.node is BlockQuote) {
                    // 块引用
                    let cache = markdownCacheConfiguration.quoteComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(newNodeView)
                    }
                } else if (newNodeView.node is FootnoteBlock) {
                    // 脚注
                    let cache = markdownCacheConfiguration.footnoteComponent.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(newNodeView)
                    }
                } else if (isLessThan && newNodeView.node is DescList) {
                    // 定义列表（仅新数据小于页面数据时判断）
                    let cache = markdownCacheConfiguration.descListComponent.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(newNodeView)
                    }
                } else {
                    nodeViewDataSource.replaceData(index, newNodeView)
                }
            } else {
                if (newNodeView.node is IndentedCodeBlock) {
                    // 缩进代码
                    let cache = markdownCacheConfiguration.codeComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(newNodeView)
                    }
                } else if (newNodeView.node is FencedCodeBlock) {
                    // 围栏代码
                    let cache = markdownCacheConfiguration.codeComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(newNodeView)
                    }
                } else {
                    // 其他节点
                    nodeViewDataSource.replaceData(index, newNodeView)
                }
            }
        } else if (newBlockHash == oldBlockHash && newContentHash == oldContentHash) {
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

@Builder
func ADBuilder(item: NodeView) {
    Text("")
}

@Builder
func VideoBuilder(item: NodeView, markdownConfiguration: MarkdownConfiguration, videoCallback: (String) -> Unit) {
    MarkdownImageVideoComponent(
        markdownConfiguration: markdownConfiguration,
        nodeView: item,
        videoCallback: videoCallback
    )
}

@Builder
func AudioBuilder(item: NodeView, markdownConfiguration: MarkdownConfiguration) {
    MarkdownImageAudioComponent(
        markdownConfiguration: markdownConfiguration,
        nodeView: item
    )
}
