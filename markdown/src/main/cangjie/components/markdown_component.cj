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
            // 脚注插件
            .usePlugin(FootnotePlugin.create())
            // TOC插件
            .usePlugin(TocPlugin.create())
            // 图片列表插件
            .usePlugin(ImageCollectPlugin.create())
            // 唯一ID标识插件
            .usePlugin(BlockIdPlugin.create())
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
                                MarkdownHeadingComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeViews: item.children,
                                    level: (item.node as Heading)().getLevel(),
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    imageCallback: imageCallback,
                                    componentWidth: vp2px(componentWidth.vp).getOrThrow().value,
                                    imageMarginTop: markdownConfiguration.markdownTheme.imageMarginTop,
                                    imageMarginBottom: markdownConfiguration.markdownTheme.imageMarginBottom,
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
                                    componentWidth: vp2px(componentWidth.vp).getOrThrow().value,
                                    imageMarginTop: markdownConfiguration.markdownTheme.imageMarginTop,
                                    imageMarginBottom: markdownConfiguration.markdownTheme.imageMarginBottom,
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
                                    componentWidth: vp2px(componentWidth.vp).getOrThrow().value,
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
                                    componentWidth: vp2px(componentWidth.vp).getOrThrow().value,
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
                                    componentWidth: vp2px(componentWidth.vp).getOrThrow().value,
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
                                componentWidth: vp2px(componentWidth.vp).getOrThrow().value,
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
                                audioBuilder(item, markdownConfiguration)
                            }
                        } else if (item.node is BlockVideo) {
                            // 视频
                            ListItem() {
                                videoBuilder(item, markdownConfiguration, videoCallback)
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
                                        componentWidth: vp2px(componentWidth.vp).getOrThrow().value,
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
                                oldValue, newValue => indexFootnoteHashMap.add((item.node as FootnoteBlock)().noteid, newValue.globalPosition.y)
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
                        } else if (item.node is BlockAD) {
                            // 广告
                            ListItem() {
                                adBuilder(item)
                            }
                        } else {
                            // TODO 其他节点
                            ListItem() {
                                Text("")
                            }
                        }
                    },
                    keyGeneratorFunc:{
                         item: NodeView, idx: Int64 => return "${idx}-${getProp<Int64>(item,"nodeid",0)}"
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

            let syncCounter:SyncCounter = SyncCounter(1)
            launch {
                if (nodeViewsSize == 0) {
                    syncCounter.dec()
                    return
                }
                if (nodeViewsSize > nodeViewListSize) {
                    // 新数据大于页面数据
                    markdownCacheConfiguration.clearAll() // 清除缓存数据
                    // 循环判断历史数据有没有做过修改
                    for(i in 0..nodeViewListSize){
                        if(getProp<Int64>(nodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewDataSource.getAllData()[i],"nodeid",0)){
                            nodeViewDataSource.replaceData(i, nodeViews[i])
                        }
                    }
                    // 循环添加新数据
                    for(i in nodeViewListSize..nodeViewsSize){
                        nodeViewDataSource.addData(nodeViews[i])
                    }
                } else if (nodeViewsSize == nodeViewListSize) {
                    // 新数据等于页面数据
                    let index: Int64 = nodeViewListSize - 1
                    for(i in 0..index){
                        if(getProp<Int64>(nodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewDataSource.getAllData()[i],"nodeid",0)){
                            nodeViewDataSource.replaceData(i, nodeViews[i])
                        }
                    }
                    if(nodeViews[index].node.getNodeType() != nodeViewDataSource.getData(index).node.getNodeType()){
                        // 最后一条数据类型不相等
                        nodeViewDataSource.replaceData(index, nodeViews[index])
                    } else {
                        // 最后一条数据类型相等
                        if (!markdownConfiguration.markdownTheme.isSeparateCodeBlock) {
                            if ((nodeViews[index].node is BulletList && nodeViewDataSource.getData(index).node is BulletList) || (nodeViews[index].node is OrderedList && nodeViewDataSource.getData(index).node is OrderedList)) {
                                // 有序列表和无序列表
                                for (data in markdownCacheConfiguration.listComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(nodeViews[index].children)
                                    }
                                }
                            } else if ((nodeViews[index].node is BlockQuote && nodeViewDataSource.getData(index).node is BlockQuote)) {
                                // 块引用
                                for (data in markdownCacheConfiguration.quoteComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(nodeViews[index].children)
                                    }
                                }
                            } else if ((nodeViews[index].node is Heading && nodeViewDataSource.getData(index).node is Heading)) {
                                // 标题
                                for (data in markdownCacheConfiguration.headingComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(nodeViews[index].children, (nodeViews[index].node as Heading)().getLevel())
                                    }
                                }
                            } else if ((nodeViews[index].node is Paragraph && nodeViewDataSource.getData(index).node is Paragraph)) {
                                // 段落
                                for (data in markdownCacheConfiguration.paragraphComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(nodeViews[index].children)
                                    }
                                }
                            } else if ((nodeViews[index].node is TableBlock && nodeViewDataSource.getData(index).node is TableBlock)) {
                                // 表格
                                for (data in markdownCacheConfiguration.tableComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(tableList(nodeViews[index].children))
                                    }
                                }
                            } else if ((nodeViews[index].node is IndentedCodeBlock && nodeViewDataSource.getData(index).node is IndentedCodeBlock)) {
                                // 缩进代码
                                for (data in markdownCacheConfiguration.indentedCodeComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(getCodeInfo(nodeViews[index])[0], getCodeInfo(nodeViews[index])[1])
                                    }
                                }
                            } else if ((nodeViews[index].node is FencedCodeBlock && nodeViewDataSource.getData(index).node is FencedCodeBlock)) {
                                // 围栏代码
                                for (data in markdownCacheConfiguration.fencedCodeComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(getCodeInfo(nodeViews[index])[0], getCodeInfo(nodeViews[index])[1]())
                                    }
                                }
                            } else {
                                // 其他节点
                                nodeViewDataSource.replaceData(index, nodeViews[index])
                            }
                        } else {
                            if ((nodeViews[index].node is IndentedCodeBlock && nodeViewDataSource.getData(index).node is IndentedCodeBlock)) {
                                // 缩进代码
                                for (data in markdownCacheConfiguration.codeComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(getCodeInfo(nodeViews[index])[0], getCodeInfo(nodeViews[index])[1])
                                    }
                                }
                            } else if ((nodeViews[index].node is FencedCodeBlock && nodeViewDataSource.getData(index).node is FencedCodeBlock)) {
                                // 围栏代码
                                for (data in markdownCacheConfiguration.codeComponents) {
                                    if (isListItem(indexList, data.indexList, index)) {
                                        data.refreshData(getCodeInfo(nodeViews[index])[0], getCodeInfo(nodeViews[index])[1])
                                    }
                                }
                            } else {
                                // 其他节点
                                nodeViewDataSource.replaceData(index, nodeViews[index])
                            }
                        }
                    }
                } else {
                    // 新数据小于页面数据
                    markdownCacheConfiguration.clearAll() // 清除缓存数据
                    // 循环判断历史数据有没有做过修改
                    for(i in 0..nodeViewsSize){
                        if(getProp<Int64>(nodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewDataSource.getAllData()[i],"nodeid",0)){
                            nodeViewDataSource.replaceData(i, nodeViews[i])
                        }
                    }
                    // 循环删除多余的旧数据
                    for(i in nodeViewListSize - 1..=nodeViewsSize : -1){
                        nodeViewDataSource.deleteData(i)
                    }
                }
                syncCounter.dec()
            }
            syncCounter.waitUntilZero()
        } catch (e: Exception) {
            // 解析异常，全量展示纯文本，增量不做处理
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
func ADBuilder(item: NodeView){
    Text("")
}

@Builder
func VideoBuilder(item: NodeView, markdownConfiguration: MarkdownConfiguration, videoCallback: (String) -> Unit){
    MarkdownImageVideoComponent(
        markdownConfiguration: markdownConfiguration,
        nodeView: item,
        marginTop: markdownConfiguration.markdownTheme.videoMarginTop,
        marginBottom: markdownConfiguration.markdownTheme.videoMarginBottom,
        videoCallback: videoCallback
    )
}

@Builder
func AudioBuilder(item: NodeView, markdownConfiguration: MarkdownConfiguration){
    MarkdownImageAudioComponent(
        markdownConfiguration: markdownConfiguration,
        nodeView: item,
        marginTop: markdownConfiguration.markdownTheme.audioMarginTop,
        marginBottom: markdownConfiguration.markdownTheme.audioMarginBottom
    )
}
