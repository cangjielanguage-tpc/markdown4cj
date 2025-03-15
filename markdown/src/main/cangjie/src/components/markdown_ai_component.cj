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
     * 是否全量文档
     */
    @Prop
    var isFull: Bool

    //    /**
    //     * 增量数据是否结束
    //     */
    //    @Prop
    //    @Watch[refreshData]
    //    var isClosed: Bool

    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration = MarkdownAIConfiguration.create()

    /**
     * list控制器
     */
    let scroller: Scroller = Scroller()

    /**
     * 屏幕宽度 - 单位px
     */
    let screenWidth: Int32 = getDefaultDisplaySync().width

    /**
     * 屏幕宽度 - 单位px
     */
    var componentWidth: Float64 = 0.0

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    /**
     * 缓存的数据
     */
    let markdownAICacheConfiguration: MarkdownAICacheConfiguration = MarkdownAICacheConfiguration()

    var markdownBase: Markdown = Markdown
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

    var incBase: IncreaseParser1 = IncreaseParser1(markdownBase)

    /**
     * 锁
     */
    let parseReentrantMutex: ReentrantMutex = ReentrantMutex()

    /**
     * 刷新判定
     */
    let isRefreshData: AtomicBool = AtomicBool(true)

    protected override func aboutToAppear(): Unit {
        componentWidth = widthVpToPx(screenWidth, markdownAIConfiguration.markdownAITheme.imagePadding)
        stringToNodes()
    }

    func build() {
        List(scroller: scroller) {
            LazyForEach(
                nodeViewAIDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Heading) {
                        // 标题
                        ListItem() {
                            MarkdownAIHeading1Component(
                                headingNodeView: item,
                                markdownAIConfiguration: markdownAIConfiguration,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                index: idx,
                                markdownAICacheConfiguration: markdownAICacheConfiguration
                            )
                        }
                    } else if (item.node is Paragraph) {
                        // 段落
                        ListItem() {
                            MarkdownAIParagraph1Component(
                                paragraphNodeView: item,
                                markdownAIConfiguration: markdownAIConfiguration,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                index: idx,
                                markdownAICacheConfiguration: markdownAICacheConfiguration
                            )
                        }
                    } else if (item.node is BulletList) {
                        // 无序列表（包含任务列表）
                        ListItem() {
                            MarkdownAIList1Component(
                                nodeView: item,
                                markdownAIConfiguration: markdownAIConfiguration,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                index: idx,
                                markdownAICacheConfiguration: markdownAICacheConfiguration
                            )
                        }
                    } else if (item.node is OrderedList) {
                        // 有序列表（包含TOC目录列表）
                        ListItem() {
                            MarkdownAIList1Component(
                                nodeView: item,
                                markdownAIConfiguration: markdownAIConfiguration,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                index: idx,
                                markdownAICacheConfiguration: markdownAICacheConfiguration
                            )
                        }
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        ListItem() {
                            MarkdownAIQuote1Component(
                                nodeView: item,
                                markdownAIConfiguration: markdownAIConfiguration,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                index: idx,
                                markdownAICacheConfiguration: markdownAICacheConfiguration
                            )
                        }
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码块
                        ListItem() {
                            if (isFull) {
                                MarkdownAIFencedCodeBlockComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                    codeItem: item,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
                                )
                            } else {
                                MarkdownAIIndentedCodeBlockComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                    codeItem: item,
                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
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
                                    codeItem: item,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
                                )
                            } else {
                                MarkdownAIIndentedCodeBlockComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    codeItem: item,
                                    codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                    info: Option<String>.None,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
                                )
                            }
                        }
                    } else if (item.node is TableBlock) {
                        // 表格
                        ListItem() {
                            MarkdownAITableBlock1Component(
                                nodeView: item,
                                markdownAIConfiguration: markdownAIConfiguration,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                index: idx,
                                markdownAICacheConfiguration: markdownAICacheConfiguration
                            )
                        }
                    } else if (item.node is ThematicBreak) {
                        // 分割线
                        ListItem() {
                            MarkdownAIThematicBreakComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
                            )
                        }
                    } else if (item.node is LatexMathBlock) {
                        // 单行的数学公式
                        ListItem() {
                            MarkdownAILatexMathBlockComponent(
                                latexStr: (item.node as LatexMathBlock)().latex,
                                isClosed: (item.node as LatexMathBlock)().isClosed,
                                markdownAIConfiguration: markdownAIConfiguration,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
                            )
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
            incBase.parse(output)
            let nodeViews = incBase.docView.children
            if (isFull) {
                nodeViewAIDataSource.clear()
                nodeViewAIDataSource.addDatas(nodeViews)
            } else {
                if (nodeViews.size == 0) {
                    return
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
                        nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is BulletList) || (nodeViews[nodeViews
                            .size - 1]
                        .node is OrderedList &&
                        nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is OrderedList)) {
                        // 有序列表和无序列表
                        let index: Int64 = nodeViewAIDataSource.totalCount() - 1
                        for (data in markdownAICacheConfiguration.list1Components) {
                            if (data.index == index) {
                                data.component.refreshData(nodeViews[nodeViews.size - 1])
                            }
                        }
                    } else if ((nodeViews[nodeViews.size - 1].node is BlockQuote &&
                        nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is BlockQuote)) {
                        // 块引用
                        let index: Int64 = nodeViewAIDataSource.totalCount() - 1
                        for (data in markdownAICacheConfiguration.quote1Components) {
                            if (data.index == index) {
                                data.component.refreshData(nodeViews[nodeViews.size - 1])
                            }
                        }
                    } else if ((nodeViews[nodeViews.size - 1].node is Heading &&
                        nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is Heading)) {
                        // 标题
                        let index: Int64 = nodeViewAIDataSource.totalCount() - 1
                        for (data in markdownAICacheConfiguration.heading1Components) {
                            if (data.index == index) {
                                data.component.refreshData(nodeViews[nodeViews.size - 1])
                            }
                        }
                    } else if ((nodeViews[nodeViews.size - 1].node is Paragraph &&
                        nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is Paragraph)) {
                        // 段落
                        let index: Int64 = nodeViewAIDataSource.totalCount() - 1
                        for (data in markdownAICacheConfiguration.paragraph1Components) {
                            if (data.index == index) {
                                data.component.refreshData(nodeViews[nodeViews.size - 1])
                            }
                        }
                    } else if ((nodeViews[nodeViews.size - 1].node is TableBlock &&
                        nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is TableBlock)) {
                        // 表格
                        let index: Int64 = nodeViewAIDataSource.totalCount() - 1
                        for (data in markdownAICacheConfiguration.tableComponents) {
                            if (data.index == index) {
                                data.component.refreshData(nodeViews[nodeViews.size - 1])
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
        } catch (e: Exception) {
            if (isFull) {
                let paragraph: Paragraph = Paragraph()
                let commonmarkText: CommonmarkText = CommonmarkText(output)
                paragraph.appendChild(commonmarkText)
                let paragraphNodeView: NodeView = buildView(paragraph, true)
                let textNodeView: NodeView = buildView(commonmarkText, true)
                var arrayListNodeView: ArrayList<NodeView> = ArrayList<NodeView>()
                arrayListNodeView.append(paragraphNodeView)
                nodeViewAIDataSource.clear()
                nodeViewAIDataSource.addDatas(arrayListNodeView)
            }
        }
    }
}
