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
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * 懒加载数据源
     */
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        markdownAICacheConfiguration.listItem3Components.append(this)
        // 清除缓存数据
        nodeViews.clear()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
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
                        ListItem() {
                        MarkdownAIParagraph4Component(
                            markdownAIConfiguration: markdownAIConfiguration,
                            nodeViews: item.children,
                            marginTop: 0.0,
                            marginBottom: 0.0,
                            fontCallback: fontCallback,
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
                        )}
                    } else if (item.node is Heading) {
                        // 标题
                        ListItem() {
                        MarkdownAIHeading4Component(
                            markdownAIConfiguration: markdownAIConfiguration,
                            nodeViews: item.children,
                            level: (item.node as Heading)().getLevel(),
                            marginTop: 0.0,
                            marginBottom: 0.0,
                            fontCallback: fontCallback,
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
                        )}
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        ListItem() {
                        MarkdownAIIndentedCodeBlockComponent(
                            markdownAIConfiguration: markdownAIConfiguration,
                            codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                            info: Option<String>.None,
                            codeItem: item,
                            marginTop: 0.0,
                            marginBottom: 0.0
                        )}
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        ListItem() {
                        MarkdownAIIndentedCodeBlockComponent(
                            markdownAIConfiguration: markdownAIConfiguration,
                            codeText: (item.node as FencedCodeBlock)().getLiteral(),
                            info: (item.node as FencedCodeBlock)().getInfo(),
                            codeItem: item,
                            marginTop: 0.0,
                            marginBottom: 0.0
                        )}
                    } else if (item.node is BulletList) {
                        // 无序列表
                        ListItem() {
                        MarkdownAIListComponent(
                            listNodeView: item,
                            markdownAIConfiguration: markdownAIConfiguration,
                            marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            fontCallback: fontCallback,
                            componentWidth: componentWidth,
                            isFull: isFull
                        )}
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        ListItem() {
                        MarkdownAIListComponent(
                            listNodeView: item,
                            markdownAIConfiguration: markdownAIConfiguration,
                            marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            fontCallback: fontCallback,
                            componentWidth: componentWidth,
                            isFull: isFull
                        )}
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        ListItem() {
                        MarkdownAIListComponent(
                            listNodeView: item,
                            markdownAIConfiguration: markdownAIConfiguration,
                            marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                            fontCallback: fontCallback,
                            componentWidth: componentWidth,
                            isFull: isFull
                        )}
                    } else if (item.node is TableBlock) {
                        // 表格
                        ListItem() {
                        MarkdownAITableBlockComponent(
                            tableNodeView: item,
                            markdownAIConfiguration: markdownAIConfiguration,
                            marginTop: 0.0,
                            marginBottom: 0.0,
                            fontCallback: fontCallback,
                            componentWidth: componentWidth,
                            isFull: isFull
                        )}
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        ListItem() {
                        if ((item.node as LatexMathBlock)().isClosed) {
                            // 结束显示数学公式
                            MarkdownAILatexMathBlockComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                latexStr: (item.node as LatexMathBlock)().latex,
                                marginTop: 0.0,
                                marginBottom: 0.0
                            )
                        } else {
                            // 没结束显示纯文本
                            Text((item.node as LatexMathBlock)().latex)
                        }
                        }
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

    /**
     * 数据刷新
     */
    public func refreshData(refreshNodeViews: ArrayList<NodeView>): Unit {
        let refreshNodeViewSize = refreshNodeViews.size // 刷新进来的数据长度
        let dataSourceSize = nodeViewAIDataSource.totalCount() // 页面缓存的数据长度
        if (isFull) {
            // 全量加载
            nodeViewAIDataSource.clear()
            nodeViewAIDataSource.addDatas(refreshNodeViews)
        } else {
            // 增量加载
            if (refreshNodeViewSize == 0) {
                return
            }
            if (refreshNodeViewSize > dataSourceSize) {
                // 刷新数据的长度大于页面数据长度，需要添加数据
                if (dataSourceSize != 0) {
                    // 更新页面最后一条数据
                    nodeViewAIDataSource.replaceData(dataSourceSize - 1, refreshNodeViews[dataSourceSize - 1])
                }
                // 循环添加所有新增数据
                for (i in refreshNodeViewSize - dataSourceSize..0 : -1) {
                    nodeViewAIDataSource.addData(refreshNodeViews[refreshNodeViewSize - i])
                }
            } else if (refreshNodeViewSize == dataSourceSize) {
                // 刷新数据的长度等于页面数据长度，需要更新当前数据
                let index4: Int64 = dataSourceSize - 1
                if (refreshNodeViews[refreshNodeViewSize - 1].node is Heading && nodeViewAIDataSource.getData(dataSourceSize - 1).node is Heading) {
                    // 标题
                    for (data in markdownAICacheConfiguration.heading4Components) {
                        if (data.index == index && data.index2 == index2 && data.index3 == index3 && data.index4 == index4 && data.indexItem == indexItem && data.indexItem2 == indexItem2 && data.indexItem3 == indexItem3) {
                            data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children, (refreshNodeViews[refreshNodeViewSize - 1].node as Heading)().getLevel())
                        }
                    }
                } else if (refreshNodeViews[refreshNodeViewSize - 1].node is Paragraph && nodeViewAIDataSource.getData(dataSourceSize - 1).node is Paragraph) {
                    // 段落
                    for (data in markdownAICacheConfiguration.paragraph4Components) {
                        if (data.index == index && data.index2 == index2 && data.index3 == index3 && data.index4 == index4 && data.indexItem == indexItem && data.indexItem2 == indexItem2 && data.indexItem3 == indexItem3) {
                            data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children)
                        }
                    }
                } else {
                    // 其他节点
                    nodeViewAIDataSource.replaceData(dataSourceSize - 1, refreshNodeViews[refreshNodeViewSize - 1] )
                }
            } else {
                // 刷新数据小于页面数据长度，需要删除数据
                // 更新页面中间一条数据 - 刷新数据长度的最后一条数据
                nodeViewAIDataSource.replaceData(refreshNodeViewSize - 1, refreshNodeViews[refreshNodeViewSize - 1])
                // 循环删除所有多余数据
                for (i in dataSourceSize - refreshNodeViewSize..0 : -1) {
                    nodeViewAIDataSource.deleteData(dataSourceSize - i)
                }
            }
        }
        size = nodeViewAIDataSource.totalCount() // 更新列表长度
    }
}
