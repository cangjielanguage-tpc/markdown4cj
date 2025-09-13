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
class MarkdownAIListItemComponent {
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

    /**
     * 缓存的数据
     */
    var markdownAICacheConfiguration: MarkdownAICacheConfiguration

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
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        markdownAICacheConfiguration.listItemComponents.append(this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        markdownAICacheConfiguration
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
            LazyForEach(
                nodeViewAIDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        ListItem() {
                            MarkdownAIParagraphComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                nodeViews: item.children,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                imageMarginTop: markdownAIConfiguration.markdownAITheme.imageMarginTop,
                                imageMarginBottom: markdownAIConfiguration.markdownAITheme.imageMarginBottom,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                componentWidth: componentWidth,
                                isListTo:true,
                                isFull: isFull,
                                indexList: indexAdd(indexList, idx),
                                paragraphComponents: markdownAICacheConfiguration.paragraphComponents
                            )
                        }
                    } else if (item.node is Heading) {
                        // 标题
                        ListItem() {
                            MarkdownAIHeadingComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                nodeViews: item.children,
                                level: (item.node as Heading)().getLevel(),
                                marginTop: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                imageMarginTop: markdownAIConfiguration.markdownAITheme.imageMarginTop,
                                imageMarginBottom: markdownAIConfiguration.markdownAITheme.imageMarginBottom,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                componentWidth: componentWidth,
                                isListTo:true,
                                isFull: isFull,
                                indexList: indexAdd(indexList, idx),
                                headingComponents: markdownAICacheConfiguration.headingComponents
                            )
                        }
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        ListItem() {
                            MarkdownAIIndentedCodeBlockComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                info: Option<String>.None,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                indexList: indexAdd(indexList, idx),
                                indentedCodeComponents: markdownAICacheConfiguration.indentedCodeComponents
                            )
                        }
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        ListItem() {
                            MarkdownAIFencedCodeBlockComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                info: (item.node as FencedCodeBlock)().getInfo(),
                                marginTop: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                indexList: indexAdd(indexList, idx),
                                fencedCodeComponents: markdownAICacheConfiguration.fencedCodeComponents
                            )
                        }
                    } else if (item.node is BulletList) {
                        // 无序列表
                        ListItem() {
                            MarkdownAIListComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                nodeViews: item.children,
                                isOrdered: false,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                videoCallback: videoCallback,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                indexList: indexAdd(indexList, idx),
                                markdownAICacheConfiguration: markdownAICacheConfiguration
                            )
                        }
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        ListItem() {
                            MarkdownAIListComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                nodeViews: item.children,
                                isOrdered: true,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                videoCallback: videoCallback,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                indexList: indexAdd(indexList, idx),
                                markdownAICacheConfiguration: markdownAICacheConfiguration
                            )
                        }
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        ListItem() {
                            MarkdownAIQuoteComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                nodeViews: item.children,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                videoCallback: videoCallback,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                indexList: indexAdd(indexList, idx),
                                markdownAICacheConfiguration: markdownAICacheConfiguration
                            )
                        }
                    } else if (item.node is TableBlock) {
                        // 表格
                        ListItem() {
                            MarkdownAITableBlockComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                nodeViews: tableList(item.children),
                                marginTop: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                componentWidth: componentWidth,
                                isFull: isFull,
                                indexList: indexAdd(indexList, idx),
                                tableComponents: markdownAICacheConfiguration.tableComponents,
                                tableRowComponents: markdownAICacheConfiguration.tableRowComponents,
                                tableCellComponents: markdownAICacheConfiguration.tableCellComponents
                            )
                        }
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        ListItem() {
                            if ((item.node as LatexMathBlock)().isClosed) {
                                // 结束显示数学公式
                                MarkdownAILatexMathBlockComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    latexStr: (item.node as LatexMathBlock)().latex,
                                    marginTop: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockOrderedAndBulletTopAndBottomMargins
                                )
                            } else {
                                // 没结束显示纯文本
                                Text((item.node as LatexMathBlock)().latex)
                            }
                        }
                    } else if (item.node is BlockAudio) {
                        // 音频
                        ListItem() {
                            MarkdownAIImageAudioComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                nodeView: item,
                                marginTop: markdownAIConfiguration.markdownAITheme.audioMarginTop,
                                marginBottom: markdownAIConfiguration.markdownAITheme.audioMarginBottom
                            )
                        }
                    } else if (item.node is BlockVideo) {
                        // 视频
                        ListItem() {
                            MarkdownAIImageVideoComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                nodeView: item,
                                marginTop: markdownAIConfiguration.markdownAITheme.videoMarginTop,
                                marginBottom: markdownAIConfiguration.markdownAITheme.videoMarginBottom,
                                videoCallback: videoCallback
                            )
                        }
                    } else {
                        // TODO 其他节点
                        ListItem() {
                            Text("")
                        }
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
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for(i in 0..dataSourceSize){
                if(getProp<Int64>(refreshNodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewAIDataSource.getAllData()[i],"nodeid",0)){
                    nodeViewAIDataSource.replaceData(i, refreshNodeViews[i])
                }
            }
            // 循环添加新数据
            for(i in dataSourceSize..refreshNodeViewSize){
                nodeViewAIDataSource.addData(refreshNodeViews[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            let index: Int64 = dataSourceSize - 1
            for(i in 0..index){
                if(getProp<Int64>(refreshNodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewAIDataSource.getAllData()[i],"nodeid",0)){
                    nodeViewAIDataSource.replaceData(i, refreshNodeViews[i])
                }
            }
            if(refreshNodeViews[index].node.getNodeType() != nodeViewAIDataSource.getData(index).node.getNodeType()){
                // 最后一条数据类型不相等
                nodeViewAIDataSource.replaceData(index, refreshNodeViews[index])
            } else {
                if ((refreshNodeViews[index].node is BulletList && nodeViewAIDataSource.getData(index).node is BulletList) || (refreshNodeViews[index].node is OrderedList && nodeViewAIDataSource.getData(index).node is OrderedList)) {
                    // 有序列表和无序列表
                    for (data in markdownAICacheConfiguration.listComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(refreshNodeViews[index].children)
                        }
                    }
                } else if ((refreshNodeViews[index].node is IndentedCodeBlock && nodeViewAIDataSource.getData(dataSourceSize - 1).node is IndentedCodeBlock)) {
                    // 缩进代码
                    for (data in markdownAICacheConfiguration.indentedCodeComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(getCodeInfo(refreshNodeViews[index])[0], getCodeInfo(refreshNodeViews[index])[1])
                        }
                    }
                } else if ((refreshNodeViews[index].node is FencedCodeBlock && nodeViewAIDataSource.getData(index).node is FencedCodeBlock)) {
                    // 围栏代码
                    for (data in markdownAICacheConfiguration.fencedCodeComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(getCodeInfo(refreshNodeViews[index])[0], getCodeInfo(refreshNodeViews[index])[1]())
                        }
                    }
                } else if (refreshNodeViews[index].node is Heading && nodeViewAIDataSource.getData(index).node is Heading) {
                    // 标题
                    for (data in markdownAICacheConfiguration.headingComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(refreshNodeViews[index].children, (refreshNodeViews[index].node as Heading)().getLevel())
                        }
                    }
                } else if (refreshNodeViews[index].node is Paragraph && nodeViewAIDataSource.getData(index).node is Paragraph) {
                    // 段落
                    for (data in markdownAICacheConfiguration.paragraphComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(refreshNodeViews[index].children)
                        }
                    }
                } else if (refreshNodeViews[index].node is TableBlock && nodeViewAIDataSource.getData(index).node is TableBlock) {
                    // 表格
                    for (data in markdownAICacheConfiguration.tableComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(tableList(refreshNodeViews[index].children))
                        }
                    }
                } else if (refreshNodeViews[index].node is BlockQuote && nodeViewAIDataSource.getData(index).node is BlockQuote) {
                    // 块引用
                    for (data in markdownAICacheConfiguration.quoteComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(refreshNodeViews[index].children)
                        }
                    }
                } else {
                    // 其他节点
                    nodeViewAIDataSource.replaceData(index, refreshNodeViews[index])
                }
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for(i in 0..refreshNodeViewSize){
                if(getProp<Int64>(refreshNodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewAIDataSource.getAllData()[i],"nodeid",0)){
                    nodeViewAIDataSource.replaceData(i, refreshNodeViews[i])
                }
            }
            // 循环删除多余的旧数据
            for(i in dataSourceSize - 1..=refreshNodeViewSize : -1){
                nodeViewAIDataSource.deleteData(i)
            }
        }
        size = nodeViewAIDataSource.totalCount() // 更新列表长度
    }
}
