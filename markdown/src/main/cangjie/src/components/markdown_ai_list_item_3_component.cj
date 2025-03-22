/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)、块引用自定义控件
 */
@Component
class MarkdownAIListItem3Component {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 列表内容数据
     */
    var nodeViews: ArrayList<NodeView>

    /**
     * 长度
     */
    var size: Int64 = -1

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
    var index3: Int64

    /**
     * 标识符，第几条块引用
     */
    var indexItem: Int64

    /**
     * 标识符，第几条块引用
     */
    var indexItem2: Int64

    /**
     * 标识符，第几条块引用
     */
    var indexItem3: Int64

    /**
     * 缓存的数据
     */
    var markdownAICacheConfiguration: MarkdownAICacheConfiguration

    /**
     * 懒加载数据源
     */
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        size = nodeViews.size
        refreshData(nodeViews)
        markdownAICacheConfiguration.listItem3Components.append(this)
    }

    protected override func aboutToDisappear(): Unit {
        markdownAICacheConfiguration
            .listItem3Components
            .removeIf(
                {
                    predicate => if (predicate.index == index && predicate.index2 == index2
                        && predicate.index3 == index3 && predicate.indexItem == indexItem
                        && predicate.indexItem2 == indexItem2 && predicate.indexItem3 == indexItem3 &&
                        predicate.size == size) {
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
                        MarkdownAIParagraph4Component(
                            markdownAIConfiguration: markdownAIConfiguration,
                            nodeViews: item.children,
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
                            paragraph4Components: markdownAICacheConfiguration.paragraph4Components
                        )
                    } else if (item.node is Heading) {
                        // 标题
                        MarkdownAIHeading4Component(
                            markdownAIConfiguration: markdownAIConfiguration,
                            nodeViews: item.children,
                            level: (item.node as Heading)().getLevel(),
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
                            heading4Components: markdownAICacheConfiguration.heading4Components
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
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
        // 对子组件进行重新布局
        .layoutWeight(1)
    }

    public func refreshData(nodeViews: ArrayList<NodeView>): Unit {
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
                        if (data.index == index && data.index2 == index2 && data.index3 == index3 && data.index4 ==
                            index4 && data.indexItem == indexItem && data.indexItem2 == indexItem2 && data.indexItem3 ==
                            indexItem3) {
                            data.refreshData(nodeViews[nodeViews.size - 1].children, (nodeViews[nodeViews.size - 1].node as Heading)().getLevel())
                        }
                    }
                } else if ((nodeViews[nodeViews.size - 1].node is Paragraph &&
                    nodeViewAIDataSource.getAllData()[nodeViewAIDataSource.totalCount() - 1].node is Paragraph)) {
                    // 段落
                    let index4: Int64 = nodeViewAIDataSource.totalCount() - 1
                    for (data in markdownAICacheConfiguration.paragraph4Components) {
                        if (data.index == index && data.index2 == index2 && data.index3 == index3 && data.index4 ==
                            index4 && data.indexItem == indexItem && data.indexItem2 == indexItem2 && data.indexItem3 ==
                            indexItem3) {
                            data.refreshData(nodeViews[nodeViews.size - 1].children)
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
