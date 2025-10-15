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
public class MarkdownQuoteComponent {
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

    var markdownCacheConfiguration: MarkdownCacheConfiguration

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    /**
     * 视频点击事件
     */
    var videoCallback: (String) -> Unit

    /**
     * 懒加载数据源
     */
    var nodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        markdownCacheConfiguration.quoteComponents.add(this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        markdownCacheConfiguration.quoteComponents.removeIf({
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
                nodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                MarkdownParagraphComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeViews: item.children,
                                    marginTop: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    imageMarginTop: markdownConfiguration.markdownTheme.imageMarginTop,
                                    imageMarginBottom: markdownConfiguration.markdownTheme.imageMarginBottom,
                                    fontCallback: fontCallback,
                                    imageCallback: imageCallback,
                                    componentWidth: componentWidth,
                                    isListTo: true,
                                    indexList: indexAdd(indexList, idx),
                                    paragraphComponents: markdownCacheConfiguration.paragraphComponents,
                                    blockQuoteBackGroupColor: markdownConfiguration.markdownTheme.blockQuoteBackGroupColor
                                )
                            } else if (item.node is Heading) {
                                // 标题
                                MarkdownHeadingComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeViews: item.children,
                                    level: (item.node as Heading)().getLevel(),
                                    marginTop: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    imageMarginTop: markdownConfiguration.markdownTheme.imageMarginTop,
                                    imageMarginBottom: markdownConfiguration.markdownTheme.imageMarginBottom,
                                    fontCallback: fontCallback,
                                    imageCallback: imageCallback,
                                    componentWidth: componentWidth,
                                    isListTo: true,
                                    indexList: indexAdd(indexList, idx),
                                    headingComponents: markdownCacheConfiguration.headingComponents,
                                    blockQuoteBackGroupColor: markdownConfiguration.markdownTheme.blockQuoteBackGroupColor
                                )
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                MarkdownIndentedCodeBlockComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                    info: Option<String>.None,
                                    marginTop: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    indexList: indexAdd(indexList, idx),
                                    indentedCodeComponents: markdownCacheConfiguration.indentedCodeComponents
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                MarkdownFencedCodeBlockComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                    marginTop: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    indexList: indexAdd(indexList, idx),
                                    fencedCodeComponents: markdownCacheConfiguration.fencedCodeComponents
                                )
                            } else if (item.node is BulletList) {
                                // 无序列表
                                MarkdownListComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeViews: item.children,
                                    isOrdered: false,
                                    marginTop: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    imageCallback: imageCallback,
                                    videoCallback: videoCallback,
                                    componentWidth: componentWidth,
                                    indexList: indexAdd(indexList, idx),
                                    markdownCacheConfiguration: markdownCacheConfiguration
                                )
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                MarkdownListComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeViews: item.children,
                                    isOrdered: true,
                                    marginTop: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    imageCallback: imageCallback,
                                    videoCallback: videoCallback,
                                    componentWidth: componentWidth,
                                    indexList: indexAdd(indexList, idx),
                                    markdownCacheConfiguration: markdownCacheConfiguration
                                )
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                MarkdownQuoteComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeViews: item.children,
                                    marginTop: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    imageCallback: imageCallback,
                                    videoCallback: videoCallback,
                                    componentWidth: componentWidth,
                                    indexList: indexAdd(indexList, idx),
                                    markdownCacheConfiguration: markdownCacheConfiguration
                                )
                            } else if (item.node is TableBlock) {
                                // 表格
                                MarkdownTableBlockComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeViews: tableList(item.children),
                                    marginTop: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    imageCallback: imageCallback,
                                    componentWidth: componentWidth,
                                    indexList: indexAdd(indexList, idx),
                                    tableComponents: markdownCacheConfiguration.tableComponents,
                                    tableRowComponents: markdownCacheConfiguration.tableRowComponents,
                                    tableCellComponents: markdownCacheConfiguration.tableCellComponents
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                if ((item.node as LatexMathBlock)().isClosed) {
                                    // 结束显示数学公式
                                    MarkdownLatexMathBlockComponent(
                                        markdownConfiguration: markdownConfiguration,
                                        latexStr: (item.node as LatexMathBlock)().latex,
                                        marginTop: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                        marginBottom: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins
                                    )
                                } else {
                                    // 没结束显示纯文本
                                    Text((item.node as LatexMathBlock)().latex)
                                }
                            } else if (item.node is BlockAudio) {
                                // 音频
                                MarkdownImageAudioComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeView: item,
                                    marginTop: markdownConfiguration.markdownTheme.audioMarginTop,
                                    marginBottom: markdownConfiguration.markdownTheme.audioMarginBottom
                                )
                            } else if (item.node is BlockVideo) {
                                // 视频
                                MarkdownImageVideoComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    nodeView: item,
                                    marginTop: markdownConfiguration.markdownTheme.videoMarginTop,
                                    marginBottom: markdownConfiguration.markdownTheme.videoMarginBottom,
                                    videoCallback: videoCallback
                                )
                            } else if (item.node is SlideBlock) {
                                // 图片幻灯片
                                MarkdownImageBannerComponent(
                                    slideBlockNodeView: item,
                                    markdownConfiguration: markdownConfiguration,
                                    imageCallback: imageCallback,
                                    marginTop: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                )
                            } else if (item.node is FencedCodeBlockListBlock) {
                                // 组合代码
                                MarkdownCodeBlockListComponent(
                                    nodeView: item,
                                    strInfos: toCodeList(item)[0],
                                    strText: toCodeList(item)[1],
                                    strInfoText: toCodeList(item)[2],
                                    markdownConfiguration: markdownConfiguration,
                                    marginTop: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockQuoteTopAndBottomMargins,
                                )
                            } else {
                                // TODO 其他节点
                                Text("")
                            }
                        }
                        // 设置子组件在水平方向上的对齐格式。
                        .alignItems(HorizontalAlign.Start)
                        // 设置子组件在垂直方向上的对齐格式。
                        .justifyContent(FlexAlign.Start)
                        // 对子组件进行重新布局
                        .layoutWeight(1)
                        // 外边距
                        .margin(right: markdownConfiguration.markdownTheme.blockQuoteRightMargin)
                    }
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                    // 背景色设置
                    .backgroundColor(markdownConfiguration.markdownTheme.blockQuoteBackGroupColor)
                    // 内边距
                    .padding(left: markdownConfiguration.markdownTheme.blockQuoteRightMargin)
                },
                keyGeneratorFunc: {
                    item: NodeView, idx: Int64 => return "${idx}-${getProp<Int64>(item, "nodeid", 0)}"
                }
            )
        }
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownConfiguration.markdownTheme.blockQuoteWidth.vp))
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockQuoteLeftMargin, top: marginTop, bottom: marginBottom)
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
        let dataSourceSize = nodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..dataSourceSize) {
                if (getProp<Int64>(refreshNodeViews[i], "nodeid", 0) != getProp<Int64>(nodeViewDataSource.getAllData()[i], "nodeid", 0)) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                }
            }
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                nodeViewDataSource.addData(refreshNodeViews[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            let index: Int64 = dataSourceSize - 1
            for (i in 0..index) {
                if (getProp<Int64>(refreshNodeViews[i], "nodeid", 0) != getProp<Int64>(nodeViewDataSource.getAllData()[i], "nodeid", 0)) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                }
            }
            if (refreshNodeViews[index].node.getNodeType() != nodeViewDataSource.getData(index).node.getNodeType()) {
                // 最后一条数据类型不相等
                nodeViewDataSource.replaceData(index, refreshNodeViews[index])
            } else {
                if ((refreshNodeViews[index].node is BulletList && nodeViewDataSource.getData(index).node is BulletList) || (refreshNodeViews[index].node is OrderedList && nodeViewDataSource.getData(index).node is OrderedList)) {
                    // 无序列表和有序列表
                    for (data in markdownCacheConfiguration.listComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(refreshNodeViews[index].children)
                        }
                    }
                } else if ((refreshNodeViews[index].node is IndentedCodeBlock && nodeViewDataSource.getData(index).node is IndentedCodeBlock)) {
                    // 缩进代码
                    for (data in markdownCacheConfiguration.indentedCodeComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(getCodeInfo(refreshNodeViews[index])[0], getCodeInfo(refreshNodeViews[index])[1])
                        }
                    }
                } else if ((refreshNodeViews[index].node is FencedCodeBlock && nodeViewDataSource.getData(index).node is FencedCodeBlock)) {
                    // 围栏代码
                    for (data in markdownCacheConfiguration.fencedCodeComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(getCodeInfo(refreshNodeViews[index])[0], getCodeInfo(refreshNodeViews[index])[1]())
                        }
                    }
                } else if (refreshNodeViews[index].node is Heading && nodeViewDataSource.getData(index).node is Heading) {
                    // 标题
                    for (data in markdownCacheConfiguration.headingComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(refreshNodeViews[index].children, (refreshNodeViews[index].node as Heading)().getLevel())
                        }
                    }
                } else if (refreshNodeViews[index].node is Paragraph && nodeViewDataSource.getData(index).node is Paragraph) {
                    // 段落
                    for (data in markdownCacheConfiguration.paragraphComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(refreshNodeViews[index].children)
                        }
                    }
                } else if (refreshNodeViews[index].node is TableBlock && nodeViewDataSource.getData(index).node is TableBlock) {
                    // 表格
                    for (data in markdownCacheConfiguration.tableComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(tableList(refreshNodeViews[index].children))
                        }
                    }
                } else if (refreshNodeViews[index].node is BlockQuote && nodeViewDataSource.getData(index).node is BlockQuote) {
                    // 块引用
                    for (data in markdownCacheConfiguration.quoteComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(refreshNodeViews[index].children)
                        }
                    }
                } else {
                    // 其他节点
                    nodeViewDataSource.replaceData(index, refreshNodeViews[index])
                }
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..refreshNodeViewSize) {
                if (getProp<Int64>(refreshNodeViews[i], "nodeid", 0) != getProp<Int64>(nodeViewDataSource.getAllData()[i], "nodeid", 0)) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                }
            }
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                nodeViewDataSource.deleteData(i)
            }
        }
        size = nodeViewDataSource.totalCount() // 更新列表长度
    }
}
