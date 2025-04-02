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
    var isFull: Bool

    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration = MarkdownAIConfiguration.create()

    /**
     * 屏幕宽度 - 单位px
     */
    let screenWidth: Int32 = getDefaultDisplaySync().width

    /**
     * 控件宽度 - 单位px，（控件宽度 = 屏幕宽度 - padding）
     */
    var componentWidth: Float64 = 0.0

    /**
     * 缓存的数据
     */
    let markdownAICacheConfiguration: MarkdownAICacheConfiguration = MarkdownAICacheConfiguration()

    /**
     * 注脚事件回调数据
     */
    var indexHashMap: HashMap<String, Int64> = HashMap<String, Int64>()

    /**
     * list控制器
     */
    let scroller: Scroller = Scroller()

    /**
     * markdown插件
     */
    let markdownBase: Markdown = Markdown
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
        .usePlugin(LatexMathPlugin.create())
        // 链接
        .usePlugin(LinkifyPlugin.create())
        // 脚注
        .usePlugin(FootnotePlugin.create())
        .build()

    /**
     * markdown解析器
     */
    let incBase: IncreaseParser = IncreaseParser(markdownBase)

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

    protected override func aboutToAppear(): Unit {
        // 控件宽度 = 屏幕宽度 - padding
        componentWidth = widthVpToPx(screenWidth, markdownAIConfiguration.markdownAITheme.imagePadding)
        // 首次加载
        stringToNodes()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        markdownAICacheConfiguration.clearAll()
    }

    func build() {
        List(scroller: scroller) {
            LazyForEach(
                nodeViewAIDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Heading) {
                        // 标题
                        ListItem() {
                            if (isFull) {
                                MarkdownAIHeadingComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    level: (item.node as Heading)().getLevel(),
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: FontCallback,
                                    componentWidth: componentWidth
                                )
                            } else {
                                MarkdownAIHeading1Component(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    level: (item.node as Heading)().getLevel(),
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: FontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
                                    index: idx,
                                    heading1Components: markdownAICacheConfiguration.heading1Components
                                )
                            }
                        }
                    } else if (item.node is Paragraph) {
                        // 段落
                        ListItem() {
                            if (isFull) {
                                MarkdownAIParagraphComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    footnoteBlock: Option<FootnoteBlock>.None,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: FontCallback,
                                    componentWidth: componentWidth
                                )
                            } else {
                                MarkdownAIParagraph1Component(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    footnoteBlock: Option<FootnoteBlock>.None,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: FontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
                                    index: idx,
                                    paragraph1Components: markdownAICacheConfiguration.paragraph1Components
                                )
                            }
                        }
                    } else if (item.node is BulletList) {
                        // 无序列表（包含任务列表）
                        ListItem() {
                            if (isFull) {
                                MarkdownAIListComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    listNodeView: item,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: FontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull
                                )
                            } else {
                                MarkdownAIList1Component(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    isOrdered: false,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: FontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
                                    index: idx,
                                    markdownAICacheConfiguration: markdownAICacheConfiguration
                                )
                            }
                        }
                    } else if (item.node is OrderedList) {
                        // 有序列表（包含TOC目录列表）
                        ListItem() {
                            if (isFull) {
                                MarkdownAIListComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    listNodeView: item,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: FontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull
                                )
                            } else {
                                MarkdownAIList1Component(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    isOrdered: true,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: FontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
                                    index: idx,
                                    markdownAICacheConfiguration: markdownAICacheConfiguration
                                )
                            }
                        }
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        ListItem() {
                            if (isFull) {
                                MarkdownAIListComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    listNodeView: item,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: FontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull
                                )
                            } else {
                                MarkdownAIQuote1Component(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: FontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
                                    index: idx,
                                    markdownAICacheConfiguration: markdownAICacheConfiguration
                                )
                            }
                        }
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码块
                        ListItem() {
                            if (isFull) {
                                MarkdownAIFencedCodeBlockComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
                                )
                            } else {
                                MarkdownAIIndentedCodeBlock1Component(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    isFull: isFull,
                                    index: idx,
                                    indentedCode1Components: markdownAICacheConfiguration.indentedCode1Components
                                )
                            }
                        }
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码块
                        ListItem() {
                            if (isFull) {
                                MarkdownAIFencedCodeBlockComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                    info: Option<String>.None,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
                                )
                            } else {
                                MarkdownAIIndentedCodeBlock1Component(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                    info: Option<String>.None,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    isFull: isFull,
                                    index: idx,
                                    indentedCode1Components: markdownAICacheConfiguration.indentedCode1Components
                                )
                            }
                        }
                    } else if (item.node is TableBlock) {
                        // 表格
                        ListItem() {
                            if (isFull) {
                                MarkdownAITableBlockComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    tableNodeView: item,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: FontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull
                                )
                            } else {
                                MarkdownAITableBlock1Component(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: tableList(item.children),
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: FontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
                                    index: idx,
                                    table1Components: markdownAICacheConfiguration.table1Components,
                                    tableRow1Components: markdownAICacheConfiguration.tableRow1Components,
                                    tableCell1Components: markdownAICacheConfiguration.tableCell1Components
                                )
                            }
                        }
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
                                if (isFull && addMap(idx, (item.node as FootnoteBlock)().noteid)) {
                                    MarkdownAIParagraphComponent(
                                        markdownAIConfiguration: markdownAIConfiguration,
                                        nodeViews: item.children[0].children,
                                        footnoteBlock: (item.node as FootnoteBlock)(),
                                        marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                        marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                        fontCallback: FontCallback,
                                        componentWidth: componentWidth
                                    )
                                } else {
                                    MarkdownAIParagraph1Component(
                                        markdownAIConfiguration: markdownAIConfiguration,
                                        nodeViews: item.children[0].children,
                                        footnoteBlock: (item.node as FootnoteBlock)(),
                                        marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                        marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                        fontCallback: FontCallback,
                                        componentWidth: componentWidth,
                                        isFull: isFull,
                                        index: idx,
                                        paragraph1Components: markdownAICacheConfiguration.paragraph1Components
                                    )
                                }
                            } else {
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
        // 设置组件自身的宽度
        .width(100.percent)
    }

    func addMap(index:Int64,noteid:String):Bool{
        indexHashMap.put(noteid, index)
        return true
    }

    /**
     * 刷新数据
     */
    func refreshData(): Unit {
        // 上一步解析完成才继续解析
        if (isRefreshData.load()) {
            let fut: Future<Unit> = spawn {
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
            incBase.input = output
            incBase.parse()
            let nodeViews = incBase.docView.children
            let nodeViewsSize = nodeViews.size // 刷新进来的数据长度
            let nodeViewListSize = nodeViewAIDataSource.totalCount() // 页面缓存的数据长度
            if (isFull) {
                // 全量加载
                launch {
                    nodeViewAIDataSource.clear()
                    nodeViewAIDataSource.addDatas(nodeViews)
                }
            } else {
                // 增量加载
                launch {
                    if (nodeViewsSize == 0) {
                        return
                    }
                    // 清除缓存引用
                    if (nodeViewsSize > nodeViewListSize) {
                        for (i in 0..nodeViewListSize - 1) {
                            releaseNodeRelation(nodeViewAIDataSource.getData(i))
                        }
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
                        if ((nodeViews[nodeViewsSize - 1].node is BulletList && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is BulletList) || (nodeViews[nodeViewsSize - 1].node is OrderedList && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is OrderedList)) {
                            // 有序列表和无序列表
                            for (data in markdownAICacheConfiguration.list1Components) {
                                if (data.index == index) {
                                    data.refreshData(nodeViews[nodeViewsSize - 1].children)
                                }
                            }
                        } else if ((nodeViews[nodeViewsSize - 1].node is BlockQuote && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is BlockQuote)) {
                            // 块引用
                            for (data in markdownAICacheConfiguration.quote1Components) {
                                if (data.index == index) {
                                    data.refreshData(nodeViews[nodeViewsSize - 1].children)
                                }
                            }
                        } else if ((nodeViews[nodeViewsSize - 1].node is Heading && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is Heading)) {
                            // 标题
                            for (data in markdownAICacheConfiguration.heading1Components) {
                                if (data.index == index) {
                                    data.refreshData(nodeViews[nodeViewsSize - 1].children, (nodeViews[nodeViewsSize - 1].node as Heading)().getLevel())
                                }
                            }
                        } else if ((nodeViews[nodeViewsSize - 1].node is Paragraph && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is Paragraph)) {
                            // 段落
                            for (data in markdownAICacheConfiguration.paragraph1Components) {
                                if (data.index == index) {
                                    data.refreshData(nodeViews[nodeViewsSize - 1].children)
                                }
                            }
                        } else if ((nodeViews[nodeViewsSize - 1].node is TableBlock && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is TableBlock)) {
                            // 表格
                            for (data in markdownAICacheConfiguration.table1Components) {
                                if (data.index == index) {
                                    data.refreshData(tableList(nodeViews[nodeViewsSize - 1].children))
                                }
                            }
                        } else if ((nodeViews[nodeViewsSize - 1].node is FencedCodeBlock && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is FencedCodeBlock) || (nodeViews[nodeViewsSize - 1].node is IndentedCodeBlock && nodeViewAIDataSource.getData(nodeViewListSize - 1).node is IndentedCodeBlock)) {
                            // 围栏代码和缩进代码
                            for (data in markdownAICacheConfiguration.indentedCode1Components) {
                                if (data.index == index) {
                                    data.refreshData(getCodeInfo(nodeViews[nodeViewsSize - 1])[0], getCodeInfo(nodeViews[nodeViewsSize - 1])[1])
                                }
                            }
                        } else {
                            // 其他节点
                            nodeViewAIDataSource.replaceData(nodeViewListSize - 1, nodeViews[nodeViewsSize - 1])
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
                }
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
                launch {
                    nodeViewAIDataSource.clear()
                    nodeViewAIDataSource.addDatas(arrayListNodeView)
                }
            }
        }
    }

    /**
     * 注脚点击回调
     */
    func FontCallback(noteid: String): Unit {
        if (let Some(v) <- indexHashMap.get(noteid)) {
            scroller.scrollToIndex(Int32(v))
        }
    }
}
