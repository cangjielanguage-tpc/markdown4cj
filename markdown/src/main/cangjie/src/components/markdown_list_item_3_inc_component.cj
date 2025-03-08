/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.eventhub.*

let listItem3Components: ArrayList<ListItem3IncData> = ArrayList<ListItem3IncData>()

class ListItem3IncData {
    var component: MarkdownListItem3INCComponent
    var index: Int64
    var index2: Int64
    var index3: Int64
    var indexItem: Int64
    var indexItem2: Int64
    var indexItem3: Int64

    init(component: MarkdownListItem3INCComponent, index: Int64, index2: Int64, index3: Int64, indexItem: Int64,
        indexItem2: Int64, indexItem3: Int64) {
        this.component = component
        this.index = index
        this.index2 = index2
        this.index3 = index3
        this.indexItem = indexItem
        this.indexItem2 = indexItem2
        this.indexItem3 = indexItem3
    }
}

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)、块引用自定义控件
 */
@Component
class MarkdownListItem3INCComponent {
    /**
     * markdown配置
     */
    @Prop
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 列表listNodeView
     */
    @Prop
    var nodeView: NodeView

    /**
     * 外边距 - 上面
     */
    @Prop
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    @Prop
    var marginBottom: Float64

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidth: Float64

    /**
     * 是否全量加载
     */
    @Prop
    var isFull: Bool

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var index: Int64

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var index2: Int64

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var index3: Int64

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var indexItem: Int64

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var indexItem2: Int64

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var indexItem3: Int64

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewDataSource: NodeViewDataSourceINC = NodeViewDataSourceINC(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        refreshData(nodeView)
        listItem3Components.append(ListItem3IncData(this, index, index2, index3, indexItem, indexItem2, indexItem3))
    }

    protected override func aboutToDisappear(): Unit {
        listItem3Components.removeIf(
            {
                predicate => if (predicate.index == index && predicate.index2 == index2
                    && predicate.index3 == index3 && predicate.indexItem == indexItem
                    && predicate.indexItem2 == indexItem2 && predicate.indexItem3 == indexItem3 && predicate.component.nodeView.children.size == nodeView.children.size) {
                    true
                } else {
                    false
                }
            })
    }

    func build() {
        Column() {
            LazyForEach(
                nodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraphINCComponent(
                            item,
                            markdownConfiguration,
                            componentWidth
                        )
                    } else if (item.node is Heading) {
                        // 标题
                        listHeadingINCComponent(
                            item,
                            markdownConfiguration,
                            componentWidth
                        )
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockINCComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None,
                            item,
                            markdownConfiguration
                        )
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockINCComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo(),
                            item,
                            markdownConfiguration
                        )
                    } else if (item.node is BulletList) {
                        // 无序列表
                        MarkdownListINCComponent(
                            listNodeView: item,
                            markdownConfiguration: markdownConfiguration,
                            marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                            marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull
                        )
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        MarkdownListINCComponent(
                            listNodeView: item,
                            markdownConfiguration: markdownConfiguration,
                            marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                            marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull
                        )
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        MarkdownListINCComponent(
                            listNodeView: item,
                            markdownConfiguration: markdownConfiguration,
                            marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                            marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull
                        )
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockINCComponent(
                            item,
                            markdownConfiguration,
                            componentWidth,
                            isFull
                        )
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockINCComponent(
                            (item.node as LatexMathBlock)().latex,
                            (item.node as LatexMathBlock)().isClosed,
                            markdownConfiguration
                        )
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
            // 设置子组件在水平方向上的对齐格式。
            .alignItems(HorizontalAlign.Start)
            // 设置子组件在垂直方向上的对齐格式。
            .justifyContent(FlexAlign.Start)
            // 对子组件进行重新布局
            .layoutWeight(1)
    }

    public func refreshData(nodeView: NodeView): Unit {
        let nodeViews = nodeView.children
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
                nodeViewDataSource.replaceDate(nodeViewDataSource.totalCount() - 1, nodeViews[nodeViews.size - 1])
            } else {
                nodeViewDataSource.replaceDate(nodeViews.size - 1, nodeViews[nodeViews.size - 1])
                for (i in nodeViewDataSource.totalCount() - nodeViews.size..0 : -1) {
                    nodeViewDataSource.deleteData(nodeViewDataSource.totalCount() - i)
                }
            }
        }
    }
}
