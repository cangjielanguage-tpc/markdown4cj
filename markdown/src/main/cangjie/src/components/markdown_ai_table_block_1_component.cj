/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

class TableAIData {
    var component: MarkdownAITableBlock1Component
    var index: Int64

    init(component: MarkdownAITableBlock1Component, index: Int64) {
        this.component = component
        this.index = index
    }
}

/**
 * Markdown表格自定义控件
 */
@Component
class MarkdownAITableBlock1Component {
    /**
     * markdown配置
     */
    @Prop
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 表格tableNodeView
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
     * 标识符，第几条表格
     */
    @Prop
    var index: Int64

    @Prop
    var markdownAICacheConfiguration: MarkdownAICacheConfiguration

    /**
     * 异步加载的图片数据
     */
    @State
    var arrayListPixelMap: ObservedArrayList<ImageData> = ObservedArrayList<ImageData>()

    /**
     * 缓存的图片列表
     */
    var listPixelMap: ArrayList<?PixelMap> = ArrayList<?PixelMap>()

    /**
     * 线程列表
     */
    var futs: ArrayList<?Future<Unit>> = ArrayList<?Future<Unit>>()

    /**
     * 懒加载数据源
     */
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    /**
     * 列表数据
     */
    let nodeViews: ArrayList<NodeView> = ArrayList<NodeView>()

    protected override func aboutToAppear(): Unit {
        refreshData(nodeView)
        markdownAICacheConfiguration.tableComponents.append(TableAIData(this, index))
    }

    protected override func aboutToDisappear(): Unit {
        markdownAICacheConfiguration
            .tableComponents
            .removeIf({
                predicate => if (predicate.index == index) {
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
                    tableNodeView: NodeView, idRow: Int64 => ListItem() {
                        // 行信息
                        renderTableRow(tableNodeView, idRow)
                    }
                }
            )
        }
        // 设置元素内容的对齐方式
        .align(Alignment.Start)
        // 设置元素水平方向的布局
        .direction(Direction.Ltr)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
        // 设置组件自身的宽度
        .width(100.percent)
        // 统一边框样式设置接口
        .border(width: (markdownAIConfiguration.markdownAITheme.tableBorderWidth / 2.0).vp,
        color: markdownAIConfiguration.markdownAITheme.tableBorderColor, style: BorderStyle.Solid)
    }

    /**
     * 行内数学公式
     */
    @Builder
    func tableComponentLatexMath(ret: Int64, retRow: Int64, retCol: Int64) {
        ForEach(
            arrayListPixelMap,
            itemGeneratorFunc: {
                item: ImageData, idx: Int64 => if (item.retRow == retRow && item.retCol == retCol && item.ret == ret) {
                    if (isLatexImagePixelMap(item, listPixelMap)) {
                        ImageSpan(item.pixelMap())
                            // 设置组件自身的高度
                            .height(pxToVp(item.height()))
                            // 设置组件自身的宽度
                            .width(pxToVp(item.width()))
                            // 设置图片的缩放类型
                            .objectFit(ImageFit.Contain)
                            // 设置约束尺寸
                            .constraintSize(maxWidth: 100.percent)
                            // 点击动作触发该方法调用
                            .onClick {
                                evt => latexImageOnClick(item.arrayUint8(), item.height().px, item.width().px,
                                    markdownAIConfiguration.latexImageCallback)
                            }
                    }
                }
            }
        )
    }

    /**
     * 表格内容信息
     */
    @Builder
    func renderTableCell(tableCell: NodeView, idRow: Int64, idCol: Int64) {
        Text() {
            ForEach(
                tableCell.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        if ((tableCell.node as TableCell)().isHeader()) {
                            tableComponentText(item, true, markdownAIConfiguration)
                        } else {
                            tableComponentText(item, false, markdownAIConfiguration)
                        }
                    } else if (item.node is Code) {
                        // 内联代码
                        if ((tableCell.node as TableCell)().isHeader()) {
                            tableComponentCode(item, true, markdownAIConfiguration)
                        } else {
                            tableComponentCode(item, false, markdownAIConfiguration)
                        }
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        tableComponentLatexMath(
                            latexMathImagePixelmap((item.node as LatexMathNode)().latex, idx, idRow, idCol),
                            idRow,
                            idCol
                        )
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                }
            )
        }
        // 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
        .layoutWeight(1)
        // 设置父容器的剩余空间分配给此属性所在组件的比例
        .flexGrow(1)
        // Flex 容器压缩尺寸分配给此属性所在组件的比例
        .flexShrink(1)
        // 覆盖 Flex 布局容器中 alignItems 默认配置
        .alignSelf(ItemAlign.Stretch)
        // 设置多行文本的文本对齐方式
        .textAlign(renderTableCellAlign((tableCell.node as TableCell)()))
        // 设置内边距属性
        .padding(markdownAIConfiguration.markdownAITheme.tableCellPadding)
        // 设置组件的背景色
        .backgroundColor(
            renderTableCellColor((tableCell.node as TableCell)(), markdownAIConfiguration.markdownAITheme, idRow))
        // 统一边框样式设置接口
        .border(width: (markdownAIConfiguration.markdownAITheme.tableBorderWidth / 2.0).vp,
            color: markdownAIConfiguration.markdownAITheme.tableBorderColor, style: BorderStyle.Solid)
        // 组件卸载消失时触发此回调
        .onDisAppear(
            {
                =>
                threadFutureCancel(futs)
                delPixelMap(listPixelMap)
            }
        )
    }

    /**
     * 表格行信息
     */
    @Builder
    func renderTableRow(tableRow: NodeView, idRow: Int64) {
        Row() {
            ForEach(
                tableRow.children,
                itemGeneratorFunc: {
                    item: NodeView, idxItem: Int64 => if (item.node is TableCell) {
                        renderTableCell(item, idRow, idxItem)
                    }
                }
            )
        }
        // 设置组件自身的宽度
        .width(100.percent)
    }

    public func refreshData(nodeView: NodeView): Unit {
        let list = nodeView.children
        nodeViews.clear()
        for (nodeView in list) {
            if (nodeView.node is TableBody || nodeView.node is TableHead) {
                nodeViews.appendAll(nodeView.children)
            } else if (nodeView.node is TableRow) {
                nodeViews.append(nodeView)
            }
        }
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
                nodeViewAIDataSource.replaceDate(nodeViewAIDataSource.totalCount() - 1, nodeViews[nodeViews.size - 1])
            } else {
                nodeViewAIDataSource.replaceDate(nodeViews.size - 1, nodeViews[nodeViews.size - 1])
                for (i in nodeViewAIDataSource.totalCount() - nodeViews.size..0 : -1) {
                    nodeViewAIDataSource.deleteData(nodeViewAIDataSource.totalCount() - i)
                }
            }
        }
    }

    /**
     * 数学公式数据处理 - 行内数学公式
     */
    func latexMathImagePixelmap(strLatexMath: String, idx: Int64, idRow: Int64, idCol: Int64): Int64 {
        let callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit = {
            pixelMap, height, width, arr => launch {
                arrayListPixelMap.append(
                    ImageData(ret: idx, retRow: idRow, retCol: idCol, pixelMap: pixelMap, height: height, width: width,
                        arrayUint8: arr))
            }
        }
        let fut = MarkdownParseLatexUtil.latexMathStrToPixelMapRow(strLatexMath,
            markdownAIConfiguration.markdownAITheme.resPath, markdownAIConfiguration, componentWidth, callback)
        futs.append(fut)
        return idx
    }
}
