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
     * 懒加载数据源
     */
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    /**
     * 缓存的数据
     */
    let markdownAICacheConfiguration: MarkdownAICacheConfiguration = MarkdownAICacheConfiguration()

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

    protected override func aboutToAppear(): Unit {
        // 控件宽度 = 屏幕宽度 - padding
        componentWidth = widthVpToPx(screenWidth, markdownAIConfiguration.markdownAITheme.imagePadding)
        stringToNodes()
    }

    func build() {
        List() {
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
                                    level : (item.node as Heading)().getLevel(),
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    componentWidth: componentWidth
                                )
                            } else {
                                MarkdownAIHeading1Component(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    level : (item.node as Heading)().getLevel(),
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
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
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    componentWidth: componentWidth
                                )
                            } else {
                                MarkdownAIParagraph1Component(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
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
                                    listNodeView: item,
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
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
                                    listNodeView: item,
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
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
                                    listNodeView: item,
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    componentWidth: componentWidth,
                                    isFull: isFull
                                )
                            } else {
                                MarkdownAIQuote1Component(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
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
                                    tableNodeView: item,
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    componentWidth: componentWidth,
                                    isFull: isFull
                                )
                                baseTableBlockComponent(markdownAIConfiguration,item,markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,componentWidth,isFull)
                            } else {
                                MarkdownAITableBlock1Component(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: tableList(item.children),
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
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
                            baseThematicBreakComponent(markdownAIConfiguration)
                        }
                    } else if (item.node is LatexMathBlock) {
                        // 单行的数学公式
                        ListItem() {
                            baseLatexMathBlockComponent(markdownAIConfiguration,(item.node as LatexMathBlock)().latex, (item.node as LatexMathBlock)().isClosed,  markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins, markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins)
                        }
                    } else {
                        // TODO 其他节点
                        ListItem() {
                            Text("")
                                // 设置外边距属性
                                .margin(top: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                bottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins)
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

    func refreshData(): Unit {
        if (isRefreshData.load()) {
            let fut: Future<Unit> = spawn {
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
            if (isFull) {
                launch {
                    nodeViewAIDataSource.clear()
                    nodeViewAIDataSource.addDatas(nodeViews)
                }
            } else {
                launch {
                    if (nodeViews.size == 0) {
                        return
                    }
                    let nodeViewsSize= nodeViews.size
                    let uiSzie = nodeViewAIDataSource.totalCount()
                    if(nodeViews.size > nodeViewAIDataSource.totalCount()){
                        for(i in 0..nodeViewAIDataSource.totalCount()-1){
                            releaseNodeRelation(nodeViewAIDataSource.getData(i))
                        }
                    }

                    if (nodeViews.size > nodeViewAIDataSource.totalCount()) {
                        if (nodeViewAIDataSource.totalCount() != 0) {
                            nodeViewAIDataSource.replaceDate(nodeViewAIDataSource.totalCount() - 1,
                                nodeViews[nodeViewAIDataSource.totalCount() - 1])
                        }
                        for (i in nodeViews.size - nodeViewAIDataSource.totalCount()..0 : -1) {
                            nodeViewAIDataSource.addData(nodeViews[nodeViews.size - i])
                        }
                    } else if (nodeViews.size == nodeViewAIDataSource.totalCount()) {
                        if ((nodeViews[nodeViews.size - 1].node is BulletList &&
                            nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is BulletList) ||
                            (nodeViews[nodeViews.size - 1].node is OrderedList &&
                            nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is OrderedList)) {
                            // 有序列表和无序列表
                            let index: Int64 = nodeViewAIDataSource.totalCount() - 1
                            for (data in markdownAICacheConfiguration.list1Components) {
                                if (data.index == index) {
                                    data.refreshData(nodeViews[nodeViews.size - 1].children)
                                }
                            }
                        } else if ((nodeViews[nodeViews.size - 1].node is BlockQuote &&
                            nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is BlockQuote)) {
                            // 块引用
                            let index: Int64 = nodeViewAIDataSource.totalCount() - 1
                            for (data in markdownAICacheConfiguration.quote1Components) {
                                if (data.index == index) {
                                    data.refreshData(nodeViews[nodeViews.size - 1].children)
                                }
                            }
                        } else if ((nodeViews[nodeViews.size - 1].node is Heading &&
                            nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is Heading)) {
                            // 标题
                            let index: Int64 = nodeViewAIDataSource.totalCount() - 1
                            for (data in markdownAICacheConfiguration.heading1Components) {
                                if (data.index == index) {
                                    data.refreshData(nodeViews[nodeViews.size - 1].children, (nodeViews[nodeViews.size - 1].node as Heading)().getLevel())
                                }
                            }
                        } else if ((nodeViews[nodeViews.size - 1].node is Paragraph &&
                            nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is Paragraph)) {
                            // 段落
                            let index: Int64 = nodeViewAIDataSource.totalCount() - 1
                            for (data in markdownAICacheConfiguration.paragraph1Components) {
                                if (data.index == index) {
                                    data.refreshData(nodeViews[nodeViews.size - 1].children)
                                }
                            }
                        } else if ((nodeViews[nodeViews.size - 1].node is TableBlock &&
                            nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is TableBlock)) {
                            // 表格
                            let index: Int64 = nodeViewAIDataSource.totalCount() - 1
                            for (data in markdownAICacheConfiguration.table1Components) {
                                if (data.index == index) {
                                    data.refreshData(tableList(nodeViews[nodeViews.size - 1].children))
                                }
                            }
                        } else if ((nodeViews[nodeViews.size - 1].node is FencedCodeBlock &&
                            nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is FencedCodeBlock) ||
                            (nodeViews[nodeViews.size - 1].node is IndentedCodeBlock &&
                            nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is IndentedCodeBlock)) {
                            // 围栏代码和缩进代码
                            let index: Int64 = nodeViewAIDataSource.totalCount() - 1
                            for (data in markdownAICacheConfiguration.indentedCode1Components) {
                                if (data.index == index) {
                                    data.refreshData(getCodeInfo(nodeViews[nodeViews.size - 1])[0],
                                            getCodeInfo(nodeViews[nodeViews.size - 1])[1])
                                }
                            }
                        } else {
                            nodeViewAIDataSource.replaceDate(nodeViewAIDataSource.totalCount() - 1,
                                nodeViews[nodeViews.size - 1])
                        }
                    } else {
                        nodeViewAIDataSource.replaceDate(nodeViews.size - 1, nodeViews[nodeViews.size - 1])
                        for (i in nodeViewAIDataSource.totalCount() - nodeViews.size..0 : -1) {
                            nodeViewAIDataSource.deleteData(nodeViewAIDataSource.totalCount() - i)
                        }
                    }
                }
            }
        } catch (e: Exception) {
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
}
