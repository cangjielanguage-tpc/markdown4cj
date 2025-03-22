/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

class ListItemAI2Data {
    var component: MarkdownAIListItem2Component
    var index: Int64
    var index2: Int64
    var indexItem: Int64
    var indexItem2: Int64

    init(component: MarkdownAIListItem2Component, index: Int64, index2: Int64, indexItem: Int64, indexItem2: Int64) {
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
class MarkdownAIListItem2Component {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 列表listNodeView
     */
    var nodeView: NodeView

    /**
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

    /**
     * 控件宽度 - 单位px
     */
    var componentWidth: Float64

    /**
     * 是否全量加载
     */
    var isFull: Bool

    /**
     * 标识符，第几条块引用
     */
    var index: Int64

    /**
     * 标识符，第几条块引用
     */
    var index2: Int64

    /**
     * 标识符，第几条块引用
     */
    var indexItem: Int64

    /**
     * 标识符，第几条块引用
     */
    var indexItem2: Int64

    /**
     * 缓存的数据
     */
    var markdownAICacheConfiguration: MarkdownAICacheConfiguration

    /**
     * 懒加载数据源
     */
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        refreshData(nodeView)
        markdownAICacheConfiguration
            .listItem2Components
            .append(ListItemAI2Data(this, index, index2, indexItem, indexItem2))
    }

    protected override func aboutToDisappear(): Unit {
        markdownAICacheConfiguration
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
        List() {
            LazyForEach(
                nodeViewAIDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        MarkdownAIParagraph3Component(
                            markdownAIConfiguration: markdownAIConfiguration,
                            nodeViews: item.children,
                            marginTop: 0.0,
                            marginBottom: 0.0,
                            componentWidth: componentWidth,
                            isFull: isFull,
                            index: index,
                            index2: index2,
                            index3: idx,
                            indexItem: indexItem,
                            indexItem2: indexItem2,
                            paragraph3Components: markdownAICacheConfiguration.paragraph3Components
                        )
                    } else if (item.node is Heading) {
                        // 标题
                        MarkdownAIHeading3Component(
                            markdownAIConfiguration: markdownAIConfiguration,
                            nodeViews: item.children,
                            level : (item.node as Heading)().getLevel(),
                            marginTop: 0.0,
                            marginBottom: 0.0,
                            componentWidth: componentWidth,
                            isFull: isFull,
                            index: index,
                            index2: index2,
                            index3: idx,
                            indexItem: indexItem,
                            indexItem2: indexItem2,
                            heading3Components: markdownAICacheConfiguration.heading3Components
                        )
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockINCComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None,
                            item,
                            markdownAIConfiguration,
                            isFull
                        )
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockINCComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo(),
                            item,
                            markdownAIConfiguration,
                            isFull
                        )
                    } else if (item.node is BulletList) {
                        // 无序列表
                        MarkdownAIList3Component(
                            nodeView: item,
                            markdownAIConfiguration: markdownAIConfiguration,
                            marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull,
                            index: index,
                            index2: index2,
                            index3: idx,
                            indexItem: indexItem,
                            indexItem2: indexItem2,
                            markdownAICacheConfiguration: markdownAICacheConfiguration
                        )
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        MarkdownAIList3Component(
                            nodeView: item,
                            markdownAIConfiguration: markdownAIConfiguration,
                            marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull,
                            index: index,
                            index2: index2,
                            index3: idx,
                            indexItem: indexItem,
                            indexItem2: indexItem2,
                            markdownAICacheConfiguration: markdownAICacheConfiguration
                        )
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        MarkdownAIQuote3Component(
                            nodeView: item,
                            markdownAIConfiguration: markdownAIConfiguration,
                            marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull,
                            index: index,
                            index2: index2,
                            index3: idx,
                            indexItem: indexItem,
                            indexItem2: indexItem2,
                            markdownAICacheConfiguration: markdownAICacheConfiguration
                        )
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockINCComponent(
                            item,
                            markdownAIConfiguration,
                            componentWidth,
                            isFull
                        )
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockINCComponent(
                            (item.node as LatexMathBlock)().latex,
                            (item.node as LatexMathBlock)().isClosed,
                            markdownAIConfiguration
                        )
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
        // 对子组件进行重新布局
        .layoutWeight(1)
    }

    public func refreshData(nodeView: NodeView): Unit {
        let nodeViews = nodeView.children
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
                    let index3: Int64 = nodeViewAIDataSource.totalCount() - 1
                    for (data in markdownAICacheConfiguration.list3Components) {
                        if (data.index == index && data.index2 == index2 && data.index3 == index3 && data.indexItem ==
                            indexItem && data.indexItem2 == indexItem2) {
                            data.component.refreshData(nodeViews[nodeViews.size - 1])
                        }
                    }
                } else if ((nodeViews[nodeViews.size - 1].node is Heading &&
                    nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is Heading)) {
                    // 标题
                    let index3: Int64 = nodeViewAIDataSource.totalCount() - 1
                    for (data in markdownAICacheConfiguration.heading3Components) {
                        if (data.index == index && data.index2 == index2 && data.index3 == index3 && data.indexItem ==
                            indexItem && data.indexItem2 == indexItem2) {
                            data.refreshData(nodeViews[nodeViews.size - 1].children)
                        }
                    }
                } else if ((nodeViews[nodeViews.size - 1].node is Paragraph &&
                    nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is Paragraph)) {
                    // 段落
                    let index3: Int64 = nodeViewAIDataSource.totalCount() - 1
                    for (data in markdownAICacheConfiguration.paragraph3Components) {
                        if (data.index == index && data.index2 == index2 && data.index3 == index3 && data.indexItem ==
                            indexItem && data.indexItem2 == indexItem2) {
                            data.refreshData(nodeViews[nodeViews.size - 1].children)
                        }
                    }
                } else if ((nodeViews[nodeViews.size - 1].node is BlockQuote &&
                    nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is BlockQuote)) {
                    let index3: Int64 = nodeViewAIDataSource.totalCount() - 1
                    for (data in markdownAICacheConfiguration.quote3Components) {
                        if (data.index == index && data.index2 == index2 && data.index3 == index3 && data.indexItem ==
                            indexItem && data.indexItem2 == indexItem2) {
                            data.component.refreshData(nodeViews[nodeViews.size - 1])
                        }
                    }
                } else {
                    nodeViewAIDataSource.replaceDate(nodeViewAIDataSource.totalCount() - 1, nodeViews[nodeViews.size - 1]
                    )
                }
            } else {
                nodeViewAIDataSource.replaceDate(nodeViews.size - 1, nodeViews[nodeViews.size - 1])
                for (i in nodeViewAIDataSource.totalCount() - nodeViews.size..0 : -1) {
                    nodeViewAIDataSource.deleteData(nodeViewAIDataSource.totalCount() - i)
                }
            }
        }
    }
}
