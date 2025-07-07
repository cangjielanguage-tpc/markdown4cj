/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
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
class MarkdownListItemComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

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

    /**
     * 缓存的数据
     */
    var markdownCacheConfiguration: MarkdownCacheConfiguration

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * TOC列表点击事件回调
     */
    let tocListOnClick: (Int64) -> Unit

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewDataSource: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        markdownCacheConfiguration.listItemComponents.add(this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        markdownCacheConfiguration
            .listItemComponents
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
            ForEach(
                nodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        ListItem() {
                            MarkdownParagraphComponent(
                                markdownConfiguration: markdownConfiguration,
                                nodeViews: item.children,
                                marginTop: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                fontCallback: fontCallback,
                                tocListOnClick: tocListOnClick,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                indexList: indexAdd(indexList, idx),
                                paragraphComponents: markdownCacheConfiguration.paragraphComponents
                            )
                        }
                    } else if (item.node is Heading) {
                        // 标题
                        ListItem() {
                            MarkdownHeadingComponent(
                                markdownConfiguration: markdownConfiguration,
                                nodeViews: item.children,
                                level: (item.node as Heading)().getLevel(),
                                marginTop: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                fontCallback: fontCallback,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                indexList: indexAdd(indexList, idx),
                                headingComponents: markdownCacheConfiguration.headingComponents
                            )
                        }
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        ListItem() {
                            MarkdownIndentedCodeBlockComponent(
                                markdownConfiguration: markdownConfiguration,
                                codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                info: Option<String>.None,
                                marginTop: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                indexList: indexAdd(indexList, idx),
                                indentedCodeComponents: markdownCacheConfiguration.indentedCodeComponents
                            )
                        }
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        ListItem() {
                            MarkdownFencedCodeBlockComponent(
                                markdownConfiguration: markdownConfiguration,
                                codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                info: (item.node as FencedCodeBlock)().getInfo(),
                                marginTop: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                indexList: indexAdd(indexList, idx),
                                fencedCodeComponents: markdownCacheConfiguration.fencedCodeComponents
                            )
                        }
                    } else if (item.node is BulletList) {
                        // 无序列表
                        ListItem() {
                            MarkdownListComponent(
                                markdownConfiguration: markdownConfiguration,
                                nodeViews: item.children,
                                isOrdered: false,
                                marginTop: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                fontCallback: fontCallback,
                                tocListOnClick: tocListOnClick,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                indexList: indexAdd(indexList, idx),
                                markdownCacheConfiguration: markdownCacheConfiguration
                            )
                        }
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        ListItem() {
                            MarkdownListComponent(
                                markdownConfiguration: markdownConfiguration,
                                nodeViews: item.children,
                                isOrdered: true,
                                marginTop: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                fontCallback: fontCallback,
                                tocListOnClick: tocListOnClick,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                indexList: indexAdd(indexList, idx),
                                markdownCacheConfiguration: markdownCacheConfiguration
                            )
                        }
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        ListItem() {
                            MarkdownQuoteComponent(
                                markdownConfiguration: markdownConfiguration,
                                nodeViews: item.children,
                                marginTop: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                fontCallback: fontCallback,
                                tocListOnClick: tocListOnClick,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                indexList: indexAdd(indexList, idx),
                                markdownCacheConfiguration: markdownCacheConfiguration
                            )
                        }
                    } else if (item.node is TableBlock) {
                        // 表格
                        ListItem() {
                            MarkdownTableBlockComponent(
                                markdownConfiguration: markdownConfiguration,
                                nodeViews: tableList(item.children),
                                marginTop: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                fontCallback: fontCallback,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                indexList: indexAdd(indexList, idx),
                                tableComponents: markdownCacheConfiguration.tableComponents,
                                tableRowComponents: markdownCacheConfiguration.tableRowComponents,
                                tableCellComponents: markdownCacheConfiguration.tableCellComponents
                            )
                        }
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        ListItem() {
                            if ((item.node as LatexMathBlock)().isClosed) {
                                // 结束显示数学公式
                                MarkdownLatexMathBlockComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    latexStr: (item.node as LatexMathBlock)().latex,
                                    marginTop: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                )
                            } else {
                                // 没结束显示纯文本
                                Text((item.node as LatexMathBlock)().latex)
                            }
                        }
                    } else if (item.node is SlideBlock) {
                        // 图片幻灯片
                        ListItem() {
                            MarkdownImageBannerComponent(
                                slideBlockNodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                            )
                        }
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 组合代码
                        ListItem() {
                            MarkdownCodeBlockListComponent(
                                nodeView: item,
                                strInfos: toCodeList(item)[0],
                                strText: toCodeList(item)[1],
                                strInfoText: toCodeList(item)[2],
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                            )
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
        let dataSourceSize = nodeViewDataSource.size // 页面缓存的数据长度
        if (isFull) {
            // 全量加载
            nodeViewDataSource.clear()
            nodeViewDataSource.appendAll(refreshNodeViews)
        } else {
            // 增量加载
            if (refreshNodeViewSize == 0) {
                return
            }
            if (refreshNodeViewSize > dataSourceSize) {
                // 刷新数据的长度大于页面数据长度，需要添加数据
                if (dataSourceSize != 0) {
                    // 更新页面最后一条数据
                    nodeViewDataSource[dataSourceSize - 1] = refreshNodeViews[dataSourceSize - 1]
                }
                // 循环添加所有新增数据
                for (i in refreshNodeViewSize - dataSourceSize..0 : -1) {
                    nodeViewDataSource.append(refreshNodeViews[refreshNodeViewSize - i])
                }
            } else if (refreshNodeViewSize == dataSourceSize) {
                // 刷新数据的长度等于页面数据长度，需要更新当前数据
                let index: Int64 = dataSourceSize - 1
                if ((refreshNodeViews[refreshNodeViewSize - 1].node is BulletList && nodeViewDataSource[dataSourceSize - 1].node is BulletList) || (refreshNodeViews[refreshNodeViewSize - 1].node is OrderedList && nodeViewDataSource[dataSourceSize - 1].node is OrderedList)) {
                    // 有序列表和无序列表
                    for (data in markdownCacheConfiguration.listComponents) {
                        if(isListItem(indexList,data.indexList,index)){
                            data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children)
                        }
                    }
                } else if ((refreshNodeViews[refreshNodeViewSize - 1].node is IndentedCodeBlock && nodeViewDataSource[dataSourceSize - 1].node is IndentedCodeBlock)) {
                    // 缩进代码
                    for (data in markdownCacheConfiguration.indentedCodeComponents) {
                        if(isListItem(indexList,data.indexList,index)){
                            data.refreshData(getCodeInfo(refreshNodeViews[refreshNodeViewSize - 1])[0], getCodeInfo(refreshNodeViews[refreshNodeViewSize - 1])[1])
                        }
                    }
                } else if ((refreshNodeViews[refreshNodeViewSize - 1].node is FencedCodeBlock && nodeViewDataSource[dataSourceSize - 1].node is FencedCodeBlock)) {
                    // 围栏代码
                    for (data in markdownCacheConfiguration.fencedCodeComponents) {
                        if(isListItem(indexList,data.indexList,index)){
                            data.refreshData(getCodeInfo(refreshNodeViews[refreshNodeViewSize - 1])[0], getCodeInfo(refreshNodeViews[refreshNodeViewSize - 1])[1])
                        }
                    }
                } else if (refreshNodeViews[refreshNodeViewSize - 1].node is Heading && nodeViewDataSource[dataSourceSize - 1].node is Heading) {
                    // 标题
                    for (data in markdownCacheConfiguration.headingComponents) {
                        if(isListItem(indexList,data.indexList,index)){
                            data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children, (refreshNodeViews[refreshNodeViewSize - 1].node as Heading)().getLevel())
                        }
                    }
                } else if (refreshNodeViews[refreshNodeViewSize - 1].node is Paragraph && nodeViewDataSource[dataSourceSize - 1].node is Paragraph) {
                    // 段落
                    for (data in markdownCacheConfiguration.paragraphComponents) {
                        if(isListItem(indexList,data.indexList,index)){
                            data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children)
                        }
                    }
                } else if (refreshNodeViews[refreshNodeViewSize - 1].node is TableBlock && nodeViewDataSource[dataSourceSize - 1].node is TableBlock) {
                    // 表格
                    for (data in markdownCacheConfiguration.tableComponents) {
                        if(isListItem(indexList,data.indexList,index)){
                            data.refreshData(tableList(refreshNodeViews[refreshNodeViewSize - 1].children))
                        }
                    }
                } else if (refreshNodeViews[refreshNodeViewSize - 1].node is BlockQuote && nodeViewDataSource[dataSourceSize - 1].node is BlockQuote) {
                    // 块引用
                    for (data in markdownCacheConfiguration.quoteComponents) {
                        if(isListItem(indexList,data.indexList,index)){
                            data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children)
                        }
                    }
                } else {
                    // 其他节点
                    nodeViewDataSource[dataSourceSize - 1] = refreshNodeViews[refreshNodeViewSize - 1]
                }
            } else {
                // 刷新数据小于页面数据长度，需要删除数据
                // 更新页面中间一条数据 - 刷新数据长度的最后一条数据
                nodeViewDataSource[refreshNodeViewSize - 1] = refreshNodeViews[refreshNodeViewSize - 1]
                // 循环删除所有多余数据
                for (i in dataSourceSize - refreshNodeViewSize..0 : -1) {
                    nodeViewDataSource.remove(dataSourceSize - i)
                }
            }
        }
        size = nodeViewDataSource.size // 更新列表长度
    }
}
