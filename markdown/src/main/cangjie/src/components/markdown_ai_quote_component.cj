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
public class MarkdownAIQuoteComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 列表内容数据
     */
    var nodeViews: ArrayList<NodeView>

    /**
     * 定位需要的数组
     */
    var indexList: ArrayList<Int64> = ArrayList<Int64>()

    /**
     * 长度
     */
    var size: Int64 = -1

    /**
     * 上边距 - 单位vp
     */
    var marginTop: Float64

    /**
     * 下边距 - 单位vp
     */
    var marginBottom: Float64

    /**
     * 控件宽度 - 单位px
     */
    var componentWidth: Float64

    /**
     * 是否全量加载 - true：全量加载，fasle：增量加载
     */
    var isFull: Bool

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
        markdownAICacheConfiguration.quoteComponents.append(this)
        // 清除缓存数据
        nodeViews.clear()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        markdownAICacheConfiguration
            .quoteComponents
            .removeIf({
                predicate => if (predicate.indexList == indexList && predicate.size == size) {
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
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                MarkdownAIParagraphComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    marginTop: 0.0,
                                    marginBottom: 0.0,
                                    fontCallback: fontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
                                    indexList: indexAdd(indexList, idx),
                                    paragraphComponents: markdownAICacheConfiguration.paragraphComponents
                                )
                            } else if (item.node is Heading) {
                                // 标题
                                MarkdownAIHeadingComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    level: (item.node as Heading)().getLevel(),
                                    marginTop: 0.0,
                                    marginBottom: 0.0,
                                    fontCallback: fontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
                                    indexList: indexAdd(indexList, idx),
                                    headingComponents: markdownAICacheConfiguration.headingComponents
                                )
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                MarkdownAIIndentedCodeBlockComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                    info: Option<String>.None,
                                    marginTop: 0.0,
                                    marginBottom: 0.0,
                                    indexList: indexAdd(indexList, idx),
                                    indentedCodeComponents: markdownAICacheConfiguration.indentedCodeComponents
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                MarkdownAIFencedCodeBlockComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                    marginTop: 0.0,
                                    marginBottom: 0.0,
                                    indexList: indexAdd(indexList, idx),
                                    fencedCodeComponents: markdownAICacheConfiguration.fencedCodeComponents
                                )
                            } else if (item.node is BulletList) {
                                // 无序列表
                                MarkdownAIListComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    isOrdered: false,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
                                    indexList: indexAdd(indexList, idx),
                                    markdownAICacheConfiguration: markdownAICacheConfiguration
                                )
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                MarkdownAIListComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    isOrdered: true,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
                                    indexList: indexAdd(indexList, idx),
                                    markdownAICacheConfiguration: markdownAICacheConfiguration
                                )
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                MarkdownAIQuoteComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
                                    indexList: indexAdd(indexList, idx),
                                    markdownAICacheConfiguration: markdownAICacheConfiguration
                                )
                            } else if (item.node is TableBlock) {
                                // 表格
                                MarkdownAITableBlockComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: tableList(item.children),
                                    marginTop: 0.0,
                                    marginBottom: 0.0,
                                    fontCallback: fontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
                                    indexList: indexAdd(indexList, idx),
                                    tableComponents: markdownAICacheConfiguration.tableComponents,
                                    tableRowComponents: markdownAICacheConfiguration.tableRowComponents,
                                    tableCellComponents: markdownAICacheConfiguration.tableCellComponents
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
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
                            } else {
                                // TODO 其他节点
                            }
                        }
                        // 设置子组件在水平方向上的对齐格式。
                        .alignItems(HorizontalAlign.Start)
                        // 设置子组件在垂直方向上的对齐格式。
                        .justifyContent(FlexAlign.Start)
                        // 对子组件进行重新布局
                        .layoutWeight(1)
                    }
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                    // 背景色设置
                    .backgroundColor(markdownAIConfiguration.markdownAITheme.blockQuoteBackGroupClor)
                    // 内边距
                    .padding(left: markdownAIConfiguration.markdownAITheme.blockMargin)
                }
            )
        }
        // 设置元素的边框颜色。
        .borderColor(markdownAIConfiguration.markdownAITheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownAIConfiguration.markdownAITheme.blockQuoteWidth.vp))
        // 块内容前的起始边距
        .margin(left: markdownAIConfiguration.markdownAITheme.blockMargin, top: marginTop, bottom: marginBottom)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
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
                let index: Int64 = dataSourceSize - 1
                if ((refreshNodeViews[refreshNodeViewSize - 1].node is BulletList && nodeViewAIDataSource.getData(dataSourceSize - 1).node is BulletList) || (refreshNodeViews[refreshNodeViews.size - 1].node is OrderedList && nodeViewAIDataSource.getData(dataSourceSize - 1).node is OrderedList)) {
                    // 无序列表和有序列表
                    for (data in markdownAICacheConfiguration.listComponents) {
                        if(isListItem(indexList,data.indexList,index)){
                            data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children)
                        }
                    }
                } else if ((refreshNodeViews[refreshNodeViewSize - 1].node is IndentedCodeBlock && nodeViewAIDataSource.getData(dataSourceSize - 1).node is IndentedCodeBlock)) {
                    // 缩进代码
                    for (data in markdownAICacheConfiguration.indentedCodeComponents) {
                        if(isListItem(indexList,data.indexList,index)){
                            data.refreshData(getCodeInfo(refreshNodeViews[refreshNodeViewSize - 1])[0], getCodeInfo(refreshNodeViews[refreshNodeViewSize - 1])[1])
                        }
                    }
                } else if ((refreshNodeViews[refreshNodeViewSize - 1].node is FencedCodeBlock && nodeViewAIDataSource.getData(dataSourceSize - 1).node is FencedCodeBlock)) {
                    // 围栏代码
                    for (data in markdownAICacheConfiguration.indentedCodeComponents) {
                        if(isListItem(indexList,data.indexList,index)){
                            data.refreshData(getCodeInfo(refreshNodeViews[refreshNodeViewSize - 1])[0], getCodeInfo(refreshNodeViews[refreshNodeViewSize - 1])[1])
                        }
                    }
                } else if (refreshNodeViews[refreshNodeViewSize - 1].node is Heading && nodeViewAIDataSource.getData(dataSourceSize - 1).node is Heading) {
                    // 标题
                    for (data in markdownAICacheConfiguration.headingComponents) {
                        if(isListItem(indexList,data.indexList,index)){
                            data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children, (refreshNodeViews[refreshNodeViewSize - 1].node as Heading)().getLevel())
                        }
                    }
                } else if (refreshNodeViews[refreshNodeViewSize - 1].node is Paragraph && nodeViewAIDataSource.getData(dataSourceSize - 1).node is Paragraph) {
                    // 段落
                    for (data in markdownAICacheConfiguration.paragraphComponents) {
                        if(isListItem(indexList,data.indexList,index)){
                            data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children)
                        }
                    }
                } else if (refreshNodeViews[refreshNodeViewSize - 1].node is TableBlock && nodeViewAIDataSource.getData(dataSourceSize - 1).node is TableBlock) {
                    // 表格
                    for (data in markdownAICacheConfiguration.tableComponents) {
                        if(isListItem(indexList,data.indexList,index)){
                            data.refreshData(tableList(refreshNodeViews[refreshNodeViewSize - 1].children))
                        }
                    }
                } else if (refreshNodeViews[refreshNodeViewSize - 1].node is BlockQuote && nodeViewAIDataSource.getData(dataSourceSize - 1).node is BlockQuote) {
                    // 块引用
                    for (data in markdownAICacheConfiguration.quoteComponents) {
                        if(isListItem(indexList,data.indexList,index)){
                            data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children)
                        }
                    }
                } else {
                    // 其他节点
                    nodeViewAIDataSource.replaceData(dataSourceSize - 1, refreshNodeViews[refreshNodeViewSize - 1])
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
