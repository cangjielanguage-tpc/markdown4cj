/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

class ListItemAI3Data {
    var component: MarkdownAIListItem3Component
    var index: Int64
    var index2: Int64
    var index3: Int64
    var indexItem: Int64
    var indexItem2: Int64
    var indexItem3: Int64

    init(component: MarkdownAIListItem3Component, index: Int64, index2: Int64, index3: Int64, indexItem: Int64,
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
class MarkdownAIListItem3Component {
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
        markdownAICacheConfiguration
            .listItem3Components
            .append(ListItemAI3Data(this, index, index2, index3, indexItem, indexItem2, indexItem3))
    }

    protected override func aboutToDisappear(): Unit {
        markdownAICacheConfiguration
            .listItem3Components
            .removeIf(
                {
                    predicate => if (predicate.index == index && predicate.index2 == index2
                        && predicate.index3 == index3 && predicate.indexItem == indexItem
                        && predicate.indexItem2 == indexItem2 && predicate.indexItem3 == indexItem3 &&
                        predicate.component.nodeView.children.size == nodeView.children.size) {
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
    func listParagraph4INCComponent(nodeViewParagraph: NodeView, markdownAIConfiguration: MarkdownAIConfiguration,
        componentWidth: Float64, idx: Int64) {
        MarkdownAIParagraph4Component(
            paragraphNodeView: nodeViewParagraph,
            markdownAIConfiguration: markdownAIConfiguration,
            marginTop: 0.0,
            marginBottom: 0.0,
            componentWidth: componentWidth,
            isFull: isFull,
            index: index,
            index2: index2,
            index3: index3,
            index4: idx,
            indexItem: indexItem,
            indexItem2: indexItem2,
            indexItem3: indexItem3,
            markdownAICacheConfiguration: markdownAICacheConfiguration
        )
    }

    /**
     * 标题
     */
    @Builder
    func listHeading4INCComponent(nodeViewHeading: NodeView, markdownAIConfiguration: MarkdownAIConfiguration,
        componentWidth: Float64, idx: Int64) {
        MarkdownAIHeading4Component(
            headingNodeView: nodeViewHeading,
            markdownAIConfiguration: markdownAIConfiguration,
            marginTop: 0.0,
            marginBottom: 0.0,
            componentWidth: componentWidth,
            isFull: isFull,
            index: index,
            index2: index2,
            index3: index3,
            index4: idx,
            indexItem: indexItem,
            indexItem2: indexItem2,
            indexItem3: indexItem3,
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
                        listParagraph4INCComponent(
                            item,
                            markdownAIConfiguration,
                            componentWidth,
                            idx
                        )
                    } else if (item.node is Heading) {
                        // 标题
                        listHeading4INCComponent(
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
                        MarkdownAIListComponent(
                            listNodeView: item,
                            markdownAIConfiguration: markdownAIConfiguration,
                            marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull
                        )
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        MarkdownAIListComponent(
                            listNodeView: item,
                            markdownAIConfiguration: markdownAIConfiguration,
                            marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull
                        )
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        MarkdownAIListComponent(
                            listNodeView: item,
                            markdownAIConfiguration: markdownAIConfiguration,
                            marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            componentWidth: componentWidth,
                            isFull: isFull
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
                if ((nodeViews[nodeViews.size - 1].node is Heading &&
                    nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is Heading)) {
                    // 标题
                    let index4: Int64 = nodeViewAIDataSource.totalCount() - 1
                    for (data in markdownAICacheConfiguration.heading4Components) {
                        if (data.index == index && data.index2 == index2 && data.index3 == index3 && data.index4 == index4 && data.indexItem ==
                            indexItem && data.indexItem2 == indexItem2 && data.indexItem3 == indexItem3) {
                            data.component.refreshData(nodeViews[nodeViews.size - 1])
                        }
                    }
                } else if ((nodeViews[nodeViews.size - 1].node is Paragraph &&
                    nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is Paragraph)) {
                    // 段落
                    let index4: Int64 = nodeViewAIDataSource.totalCount() - 1
                    for (data in markdownAICacheConfiguration.paragraph4Components) {
                        if (data.index == index && data.index2 == index2 && data.index3 == index3 && data.index4 == index4 && data.indexItem ==
                            indexItem && data.indexItem2 == indexItem2 && data.indexItem3 == indexItem3) {
                            data.component.refreshData(nodeViews[nodeViews.size - 1])
                        }
                    }
                }else{
                   nodeViewAIDataSource.replaceDate(nodeViewAIDataSource.totalCount() - 1, nodeViews[nodeViews.size - 1])
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
