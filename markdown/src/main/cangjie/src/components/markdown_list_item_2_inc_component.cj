/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.eventhub.*

class ListItem2IncData {
    var component: MarkdownListItem2INCComponent
    var index: Int64
    var index2: Int64
    var indexItem: Int64
    var indexItem2: Int64

    init(component: MarkdownListItem2INCComponent, index: Int64, index2: Int64, indexItem: Int64, indexItem2: Int64) {
        this.component = component
        this.index = index
        this.index2 = index2
        this.indexItem = indexItem
        this.indexItem2 = indexItem2
    }
}

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)、块引用自定义控件
 */
@Component
class MarkdownListItem2INCComponent {
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
    var indexItem: Int64

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var indexItem2: Int64

    @Prop
    var markdownListConfiguration: MarkdownListConfiguration

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewDataSource: NodeViewDataSourceINC = NodeViewDataSourceINC(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        refreshData(nodeView)
        markdownListConfiguration.listItem2Components.append(ListItem2IncData(this, index, index2, indexItem, indexItem2
        ))
    }

    protected override func aboutToDisappear(): Unit {
        markdownListConfiguration
            .listItem2Components
            .removeIf(
                {
                    predicate => if (predicate.index == index && predicate.index2 == index2
                        && predicate.indexItem == indexItem
                        && predicate.indexItem2 == indexItem2 && predicate.component.nodeView.children.size == nodeView
                        .children
                        .size) {
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
                        MarkdownList3INCComponent(
                            nodeView: item,
                            markdownConfiguration: markdownConfiguration,
                            marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                            marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull,
                            index: index,
                            index2: index2,
                            index3: idx,
                            indexItem: indexItem,
                            indexItem2: indexItem2,
                            markdownListConfiguration: markdownListConfiguration
                        )
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        MarkdownList3INCComponent(
                            nodeView: item,
                            markdownConfiguration: markdownConfiguration,
                            marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                            marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull,
                            index: index,
                            index2: index2,
                            index3: idx,
                            indexItem: indexItem,
                            indexItem2: indexItem2,
                            markdownListConfiguration: markdownListConfiguration
                        )
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        MarkdownQuote3INCComponent(
                            nodeView: item,
                            markdownConfiguration: markdownConfiguration,
                            marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                            marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull,
                            index: index,
                            index2: index2,
                            index3: idx,
                            indexItem: indexItem,
                            indexItem2: indexItem2,
                            markdownListConfiguration: markdownListConfiguration
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
                if ((nodeViews[nodeViews.size - 1].node is BulletList &&
                    nodeViewDataSource.getAllData()[nodeViewDataSource.totalCount() - 1].node is BulletList) || (nodeViews[nodeViews
                        .size - 1]
                    .node is OrderedList &&
                    nodeViewDataSource.getAllData()[nodeViewDataSource.totalCount() - 1].node is OrderedList)) {
                    let index3: Int64 = nodeViewDataSource.totalCount() - 1
                    for (data in markdownListConfiguration.list3Components) {
                        if (data.index == index && data.index2 == index2 && data.index3 == index3 && data.indexItem ==
                            indexItem && data.indexItem2 == indexItem2) {
                            data.component.refreshData(nodeViews[nodeViews.size - 1])
                        }
                    }
                } else if ((nodeViews[nodeViews.size - 1].node is BlockQuote &&
                    nodeViewDataSource.getAllData()[nodeViewDataSource.totalCount() - 1].node is BlockQuote)) {
                    let index3: Int64 = nodeViewDataSource.totalCount() - 1
                    for (data in markdownListConfiguration.quote3Components) {
                        if (data.index == index && data.index2 == index2 && data.index3 == index3 && data.indexItem ==
                            indexItem && data.indexItem2 == indexItem2) {
                            data.component.refreshData(nodeViews[nodeViews.size - 1])
                        }
                    }
                } else {
                    nodeViewDataSource.replaceDate(nodeViewDataSource.totalCount() - 1, nodeViews[nodeViews.size - 1])
                }
            } else {
                nodeViewDataSource.replaceDate(nodeViews.size - 1, nodeViews[nodeViews.size - 1])
                for (i in nodeViewDataSource.totalCount() - nodeViews.size..0 : -1) {
                    nodeViewDataSource.deleteData(nodeViewDataSource.totalCount() - i)
                }
            }
        }
    }
}
