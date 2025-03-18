/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

class ListItemAI1Data {
    var component: MarkdownAIListItem1Component
    var index: Int64
    var indexItem: Int64

    init(component: MarkdownAIListItem1Component, index: Int64, indexItem: Int64) {
        this.component = component
        this.index = index
        this.indexItem = indexItem
    }
}

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)、块引用自定义控件
 */
@Component
class MarkdownAIListItem1Component {
    /**
     * markdown配置
     */
    @Prop
    var markdownAIConfiguration: MarkdownAIConfiguration

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
    var indexItem: Int64

    /**
     * 缓存的数据
     */
    @Prop
    var markdownAICacheConfiguration: MarkdownAICacheConfiguration

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        refreshData(nodeView)
        markdownAICacheConfiguration.listItem1Components.append(ListItemAI1Data(this, index, indexItem))
    }

    protected override func aboutToDisappear(): Unit {
        markdownAICacheConfiguration
            .listItem1Components
            .removeIf(
                {
                    predicate => if (predicate.index == index
                        && predicate.indexItem == indexItem && predicate.component.nodeView.children.size == nodeView
                        .children
                        .size) {
                        true
                    } else {
                        false
                    }
                })
    }

    /**
     * 段落
     */
    @Builder
    func listParagraph2INCComponent(nodeViewParagraph: NodeView, markdownAIConfiguration: MarkdownAIConfiguration,
        componentWidth: Float64, idx: Int64) {
        MarkdownAIParagraph2Component(
            paragraphNodeView: nodeViewParagraph,
            markdownAIConfiguration: markdownAIConfiguration,
            marginTop: 0.0,
            marginBottom: 0.0,
            componentWidth: componentWidth,
            isFull: isFull,
            index: index,
            index2: idx,
            indexItem: indexItem,
            markdownAICacheConfiguration: markdownAICacheConfiguration
        )
    }

    /**
     * 标题
     */
    @Builder
    func listHeading2INCComponent(nodeViewHeading: NodeView, markdownAIConfiguration: MarkdownAIConfiguration,
        componentWidth: Float64, idx: Int64) {
        MarkdownAIHeading2Component(
            headingNodeView: nodeViewHeading,
            markdownAIConfiguration: markdownAIConfiguration,
            marginTop: 0.0,
            marginBottom: 0.0,
            componentWidth: componentWidth,
            isFull: isFull,
            index: index,
            index2: idx,
            indexItem: indexItem,
            markdownAICacheConfiguration: markdownAICacheConfiguration
        )
    }

    func build() {
        Column() {
            LazyForEach(
                nodeViewAIDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraph2INCComponent(
                            item,
                            markdownAIConfiguration,
                            componentWidth,
                            idx
                        )
                    } else if (item.node is Heading) {
                        // 标题
                        listHeading2INCComponent(
                            item,
                            markdownAIConfiguration,
                            componentWidth,
                            idx
                        )
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockINCComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None,
                            item,
                            markdownAIConfiguration
                        )
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockINCComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo(),
                            item,
                            markdownAIConfiguration
                        )
                    } else if (item.node is BulletList) {
                        // 无序列表
                        MarkdownAIList2Component(
                            nodeView: item,
                            markdownAIConfiguration: markdownAIConfiguration,
                            marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull,
                            index: index,
                            index2: idx,
                            indexItem: indexItem,
                            markdownAICacheConfiguration: markdownAICacheConfiguration
                        )
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        MarkdownAIList2Component(
                            nodeView: item,
                            markdownAIConfiguration: markdownAIConfiguration,
                            marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull,
                            index: index,
                            index2: idx,
                            indexItem: indexItem,
                            markdownAICacheConfiguration: markdownAICacheConfiguration
                        )
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        MarkdownAIQuote2Component(
                            nodeView: item,
                            markdownAIConfiguration: markdownAIConfiguration,
                            marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull,
                            index: index,
                            index2: idx,
                            indexItem: indexItem,
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
                    let index2: Int64 = nodeViewAIDataSource.totalCount() - 1
                    for (data in markdownAICacheConfiguration.list2Components) {
                        if (data.index == index && data.index2 == index2 && data.indexItem == indexItem) {
                            data.component.refreshData(nodeViews[nodeViews.size - 1])
                        }
                    }
                } else if ((nodeViews[nodeViews.size - 1].node is Heading &&
                    nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is Heading)) {
                    // 标题
                    let index2: Int64 = nodeViewAIDataSource.totalCount() - 1
                    for (data in markdownAICacheConfiguration.heading2Components) {
                        if (data.index == index && data.index2 == index2 && data.indexItem == indexItem) {
                            data.component.refreshData(nodeViews[nodeViews.size - 1])
                        }
                    }
                } else if ((nodeViews[nodeViews.size - 1].node is Paragraph &&
                    nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is Paragraph)) {
                    // 段落
                    let index2: Int64 = nodeViewAIDataSource.totalCount() - 1
                    for (data in markdownAICacheConfiguration.paragraph2Components) {
                        if (data.index == index && data.index2 == index2 && data.indexItem == indexItem) {
                            data.component.refreshData(nodeViews[nodeViews.size - 1])
                        }
                    }
                } else if ((nodeViews[nodeViews.size - 1].node is BlockQuote &&
                    nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is BlockQuote)) {
                    let index2: Int64 = nodeViewAIDataSource.totalCount() - 1
                    for (data in markdownAICacheConfiguration.quote2Components) {
                        if (data.index == index && data.index2 == index2 && data.indexItem == indexItem) {
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
