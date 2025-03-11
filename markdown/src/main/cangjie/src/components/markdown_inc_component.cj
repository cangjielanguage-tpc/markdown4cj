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
public class MarkdownINCComponent {
    /**
     * 外部传入的Markdown文档
     */
    @Prop
    var mdStr: String

    /**
     * 外部传入的Markdown文档
     */
    @Prop
    @Watch[onChanged]
    var output: String

    @Prop
    var isFull: Bool

    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration = MarkdownConfiguration.create()

    /**
     * list控制器
     */
    let scroller: Scroller = Scroller()

    /**
     * 屏幕宽度 - 单位px
     */
    let screenWidth: Int32 = getDefaultDisplaySync().width

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewDataSource: NodeViewDataSourceINC = NodeViewDataSourceINC(ArrayList<NodeView>())

    var isFrist: Bool = true

    let markdownListConfiguration: MarkdownListConfiguration = MarkdownListConfiguration()

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

    protected override func aboutToAppear(): Unit {
        stringToNodes()
        isFrist = false
    }

    func build() {
        List(scroller: scroller) {
            LazyForEach(
                nodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Heading) {
                        // 标题
                        ListItem() {
                            MarkdownHeading1INCComponent(
                                headingNodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                componentWidth: widthVpToPx(screenWidth,
                                    markdownConfiguration.markdownTheme.imagePadding),
                                isFull: isFull,
                                index: idx,
                                markdownListConfiguration: markdownListConfiguration
                            )
                        }
                    } else if (item.node is Paragraph) {
                        // 段落
                        ListItem() {
                            MarkdownParagraph1INCComponent(
                                paragraphNodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                componentWidth: widthVpToPx(screenWidth,
                                    markdownConfiguration.markdownTheme.imagePadding),
                                isFull: isFull,
                                index: idx,
                                markdownListConfiguration: markdownListConfiguration
                            )
                        }
                    } else if (item.node is BulletList) {
                        // 无序列表（包含任务列表）
                        ListItem() {
                            MarkdownList1INCComponent(
                                nodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                componentWidth: widthVpToPx(screenWidth,
                                    markdownConfiguration.markdownTheme.imagePadding),
                                isFull: isFull,
                                index: idx,
                                markdownListConfiguration: markdownListConfiguration
                            )
                        }
                    } else if (item.node is OrderedList) {
                        // 有序列表（包含TOC目录列表）
                        ListItem() {
                            MarkdownList1INCComponent(
                                nodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                componentWidth: widthVpToPx(screenWidth,
                                    markdownConfiguration.markdownTheme.imagePadding),
                                isFull: isFull,
                                index: idx,
                                markdownListConfiguration: markdownListConfiguration
                            )
                        }
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        ListItem() {
                            MarkdownQuote1INCComponent(
                                nodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                componentWidth: widthVpToPx(screenWidth,
                                    markdownConfiguration.markdownTheme.imagePadding),
                                isFull: isFull,
                                index: idx,
                                markdownListConfiguration: markdownListConfiguration
                            )
                        }
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码块
                        ListItem() {
                            if (isFull) {
                                MarkdownCodeBlockComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
                                )
                            } else {
                                MarkdownCodeBlockINCComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                    codeItem: item,
                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
                                )
                            }
                        }
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码块
                        ListItem() {
                            if (isFull) {
                                MarkdownCodeBlockComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                    info: Option<String>.None,
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
                                )
                            } else {
                                MarkdownCodeBlockINCComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    codeItem: item,
                                    codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                    info: Option<String>.None,
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
                                )
                            }
                        }
                    } else if (item.node is TableBlock) {
                        // 表格
                        ListItem() {
                            MarkdownTableBlock1INCComponent(
                                nodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                componentWidth: widthVpToPx(screenWidth,
                                    markdownConfiguration.markdownTheme.imagePadding),
                                isFull: isFull,
                                index: idx,
                                markdownListConfiguration: markdownListConfiguration
                            )
                        }
                    } else if (item.node is ThematicBreak) {
                        // 分割线
                        ListItem() {
                            MarkdownThematicBreakINCComponent(
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
                            )
                        }
                    } else if (item.node is LatexMathBlock) {
                        // 单行的数学公式
                        ListItem() {
                            MarkdownLatexMathBlockINCComponent(
                                latexStr: (item.node as LatexMathBlock)().latex,
                                isClosed: (item.node as LatexMathBlock)().isClosed,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
                            )
                        }
                    } else {
                        // TODO 其他节点
                        ListItem() {
                            Text("")
                                // 设置外边距属性
                                .margin(top: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                bottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins)
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

    func onChanged(): Unit {
        if (!isFrist) {
            stringToNodes()
        }
    }

    /**
     * 将String转换成ArrayList<NodeView>，将解析的列表添加到懒加载的数据源中
     */
    func stringToNodes(): Unit {
        try {
            let markdown: Markdown = if (let Some(v) <- markdownConfiguration.markdownParser) {
                v
            } else {
                markdownBase
            }
            //            incBase.lazy = false
            incBase.parse(output) // 默认已开启lazy模式
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let nodeViews = incBase.docView.children
            if (isFull) {
                nodeViewDataSource.clear()
                nodeViewDataSource.addDatas(nodeViews)
            } else {
                if (nodeViews.size == 0) {
                    return
                }
                if (nodeViews.size > nodeViewDataSource.totalCount()) {
                    if (nodeViewDataSource.totalCount() != 0) {
                        nodeViewDataSource.replaceDate(nodeViewDataSource.totalCount() - 1,
                            nodeViews[nodeViewDataSource.totalCount() - 1])
                    }
                    for (i in nodeViews.size - nodeViewDataSource.totalCount()..0 : -1) {
                        nodeViewDataSource.addData(nodeViews[nodeViews.size - i])
                    }
                } else if (nodeViews.size == nodeViewDataSource.totalCount()) {
                    if ((nodeViews[nodeViews.size - 1].node is BulletList &&
                        nodeViewDataSource.getAllData()[nodeViewDataSource.totalCount() - 1].node is BulletList) || (nodeViews[nodeViews
                            .size - 1]
                        .node is OrderedList &&
                        nodeViewDataSource.getAllData()[nodeViewDataSource.totalCount() - 1].node is OrderedList)) {
                        // 有序列表和无序列表
                        let index: Int64 = nodeViewDataSource.totalCount() - 1
                        for (data in markdownListConfiguration.list1Components) {
                            if (data.index == index) {
                                data.component.refreshData(nodeViews[nodeViews.size - 1])
                            }
                        }
                    } else if ((nodeViews[nodeViews.size - 1].node is BlockQuote &&
                        nodeViewDataSource.getAllData()[nodeViewDataSource.totalCount() - 1].node is BlockQuote)) {
                        // 块引用
                        let index: Int64 = nodeViewDataSource.totalCount() - 1
                        for (data in markdownListConfiguration.quote1Components) {
                            if (data.index == index) {
                                data.component.refreshData(nodeViews[nodeViews.size - 1])
                            }
                        }
                    } else if ((nodeViews[nodeViews.size - 1].node is Heading &&
                        nodeViewDataSource.getAllData()[nodeViewDataSource.totalCount() - 1].node is Heading)) {
                        // 标题
                        let index: Int64 = nodeViewDataSource.totalCount() - 1
                        for (data in markdownListConfiguration.heading1Components) {
                            if (data.index == index) {
                                data.component.refreshData(nodeViews[nodeViews.size - 1])
                            }
                        }
                    } else if ((nodeViews[nodeViews.size - 1].node is Paragraph &&
                        nodeViewDataSource.getAllData()[nodeViewDataSource.totalCount() - 1].node is Paragraph)) {
                        // 段落
                        let index: Int64 = nodeViewDataSource.totalCount() - 1
                        for (data in markdownListConfiguration.paragraph1Components) {
                            if (data.index == index) {
                                data.component.refreshData(nodeViews[nodeViews.size - 1])
                            }
                        }
                    } else if ((nodeViews[nodeViews.size - 1].node is TableBlock &&
                        nodeViewDataSource.getAllData()[nodeViewDataSource.totalCount() - 1].node is TableBlock)) {
                        // 表格
                        let index: Int64 = nodeViewDataSource.totalCount() - 1
                        for (data in markdownListConfiguration.tableComponents) {
                            if (data.index == index) {
                                data.component.refreshData(nodeViews[nodeViews.size - 1])
                            }
                        }
                    } else {
                        nodeViewDataSource.replaceDate(nodeViewDataSource.totalCount() - 1, nodeViews[nodeViews.size - 1]
                        )
                    }
                } else {
                    nodeViewDataSource.replaceDate(nodeViews.size - 1, nodeViews[nodeViews.size - 1])
                    for (i in nodeViewDataSource.totalCount() - nodeViews.size..0 : -1) {
                        nodeViewDataSource.deleteData(nodeViewDataSource.totalCount() - i)
                    }
                }
            }
        } catch (e: Exception) {
            if (isFull) {
                let paragraph: Paragraph = Paragraph()
                let commonmarkText: CommonmarkText = CommonmarkText(mdStr)
                paragraph.appendChild(commonmarkText)
                let paragraphNodeView: NodeView = buildView(paragraph, true)
                let textNodeView: NodeView = buildView(commonmarkText, true)
                var arrayListNodeView: ArrayList<NodeView> = ArrayList<NodeView>()
                arrayListNodeView.append(paragraphNodeView)
                nodeViewDataSource.clear()
                nodeViewDataSource.addDatas(arrayListNodeView)
            }
        }
    }
}
