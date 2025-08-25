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

    /**
     * 是否全量加载 - true：全量加载，fasle：增量加载
     */
    var isFull: Bool

    var markdownCacheConfiguration: MarkdownCacheConfiguration

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * TOC列表点击事件回调
     */
    var tocListOnClick: (Int64) -> Unit

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
        markdownCacheConfiguration
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
                                    tocListOnClick: tocListOnClick,
                                    imageCallback: imageCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
                                    isListTo:true,
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
                                    isFull: isFull,
                                    isListTo:true,
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
                                    tocListOnClick: tocListOnClick,
                                    imageCallback: imageCallback,
                                    videoCallback: videoCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
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
                                    tocListOnClick: tocListOnClick,
                                    imageCallback: imageCallback,
                                    videoCallback: videoCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
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
                                    tocListOnClick: tocListOnClick,
                                    imageCallback: imageCallback,
                                    videoCallback: videoCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull,
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
                                    isFull: isFull,
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
                            } else if (item.node is ImageSingleBlock) {
                                // 单独图片block
                                if(item.children.size  > 0 && item.children[0].node is StyleImage){
                                    //  图片Style节点
                                    if((item.children[0].node as StyleImage)().getDestination().startsWith("./")){
                                        MarkdownImageStyleRawFileComponent(
                                            markdownConfiguration: markdownConfiguration,
                                            destination: (item.children[0].node as StyleImage)().getDestination(),
                                            picStyle: (item.children[0].node as StyleImage)().styles,
                                            componentWidth:versionAdaptation(componentWidth),
                                            imageCallback: imageCallback
                                        )
                                    }else{
                                        MarkdownImageStyleComponent(
                                            markdownConfiguration: markdownConfiguration,
                                            destination: (item.children[0].node as StyleImage)().getDestination(),
                                            picStyle: (item.children[0].node as StyleImage)().styles,
                                            componentWidth:versionAdaptation(componentWidth),
                                            imageCallback: imageCallback
                                        )
                                    }
                                }else if(item.children.size  > 0 && item.children[0].node is CommonmarkImage){
                                    if((item.children[0].node as CommonmarkImage)().getDestination().startsWith("./")){
                                        MarkdownImageRawFileComponent(
                                            markdownConfiguration: markdownConfiguration,
                                            destination: (item.children[0].node as CommonmarkImage)().getDestination(),
                                            componentWidth:versionAdaptation(componentWidth),
                                            imageCallback: imageCallback
                                        )
                                    }else{
                                        // 图片节点
                                        MarkdownImageComponent(
                                            destination: (item.children[0].node as CommonmarkImage)().getDestination(),
                                            imageCallback: imageCallback
                                        )
                                    }
                                }else{
                                    Text("")
                                }
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
        if (isFull) {
            // 全量加载
            nodeViewDataSource.clear()
            nodeViewDataSource.addDatas(refreshNodeViews)
        } else {
            // 增量加载
            if (refreshNodeViewSize == 0) {
                return
            }
            if (refreshNodeViewSize > dataSourceSize) {
                // 刷新数据的长度大于页面数据长度，需要添加数据
                if (dataSourceSize != 0) {
                    // 更新页面最后一条数据
                    nodeViewDataSource.replaceData(dataSourceSize - 1, refreshNodeViews[dataSourceSize - 1])
                }
                // 循环添加所有新增数据
                for (i in refreshNodeViewSize - dataSourceSize..0 : -1) {
                    nodeViewDataSource.addData(refreshNodeViews[refreshNodeViewSize - i])
                }
            } else if (refreshNodeViewSize == dataSourceSize) {
                // 刷新数据的长度等于页面数据长度，需要更新当前数据
                let index: Int64 = dataSourceSize - 1
                if ((refreshNodeViews[refreshNodeViewSize - 1].node is BulletList && nodeViewDataSource.getData(dataSourceSize - 1).node is BulletList) || (refreshNodeViews[refreshNodeViews.size - 1].node is OrderedList && nodeViewDataSource.getData(dataSourceSize - 1).node is OrderedList)) {
                    // 无序列表和有序列表
                    for (data in markdownCacheConfiguration.listComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children)
                        }
                    }
                } else if ((refreshNodeViews[refreshNodeViewSize - 1].node is IndentedCodeBlock && nodeViewDataSource.getData(dataSourceSize - 1).node is IndentedCodeBlock)) {
                    // 缩进代码
                    for (data in markdownCacheConfiguration.indentedCodeComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(getCodeInfo(refreshNodeViews[refreshNodeViewSize - 1])[0], getCodeInfo(refreshNodeViews[refreshNodeViewSize - 1])[1])
                        }
                    }
                } else if ((refreshNodeViews[refreshNodeViewSize - 1].node is FencedCodeBlock && nodeViewDataSource.getData(dataSourceSize - 1).node is FencedCodeBlock)) {
                    // 围栏代码
                    for (data in markdownCacheConfiguration.fencedCodeComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(getCodeInfo(refreshNodeViews[refreshNodeViewSize - 1])[0], getCodeInfo(refreshNodeViews[refreshNodeViewSize - 1])[1]())
                        }
                    }
                } else if (refreshNodeViews[refreshNodeViewSize - 1].node is Heading && nodeViewDataSource.getData(dataSourceSize - 1).node is Heading) {
                    // 标题
                    for (data in markdownCacheConfiguration.headingComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children, (refreshNodeViews[refreshNodeViewSize - 1].node as Heading)().getLevel())
                        }
                    }
                } else if (refreshNodeViews[refreshNodeViewSize - 1].node is Paragraph && nodeViewDataSource.getData(dataSourceSize - 1).node is Paragraph) {
                    // 段落
                    for (data in markdownCacheConfiguration.paragraphComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children)
                        }
                    }
                } else if (refreshNodeViews[refreshNodeViewSize - 1].node is TableBlock && nodeViewDataSource.getData(dataSourceSize - 1).node is TableBlock) {
                    // 表格
                    for (data in markdownCacheConfiguration.tableComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(tableList(refreshNodeViews[refreshNodeViewSize - 1].children))
                        }
                    }
                } else if (refreshNodeViews[refreshNodeViewSize - 1].node is BlockQuote && nodeViewDataSource.getData(dataSourceSize - 1).node is BlockQuote) {
                    // 块引用
                    for (data in markdownCacheConfiguration.quoteComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children)
                        }
                    }
                } else {
                    // 其他节点
                    nodeViewDataSource.replaceData(dataSourceSize - 1, refreshNodeViews[refreshNodeViewSize - 1])
                }
            } else {
                // 刷新数据小于页面数据长度，需要删除数据
                // 更新页面中间一条数据 - 刷新数据长度的最后一条数据
                nodeViewDataSource.replaceData(refreshNodeViewSize - 1, refreshNodeViews[refreshNodeViewSize - 1])
                // 循环删除所有多余数据
                for (i in dataSourceSize - refreshNodeViewSize..0 : -1) {
                    nodeViewDataSource.deleteData(dataSourceSize - i)
                }
            }
        }
        size = nodeViewDataSource.totalCount() // 更新列表长度
    }
}
