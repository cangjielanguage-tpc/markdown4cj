/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

class TableIncData {
    var component: MarkdownTableBlock1INCComponent
    var index: Int64

    init(component: MarkdownTableBlock1INCComponent, index: Int64) {
        this.component = component
        this.index = index
    }
}

/**
 * Markdown表格自定义控件
 */
@Component
class MarkdownTableBlock1INCComponent {
    /**
     * markdown配置
     */
    @Prop
    var markdownConfiguration: MarkdownConfiguration

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
    var markdownListConfiguration: MarkdownListConfiguration

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
    var nodeViewDataSource: NodeViewDataSourceINC = NodeViewDataSourceINC(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        refreshData(nodeView)
        markdownListConfiguration.tableComponents.append(TableIncData(this, index))
    }

    protected override func aboutToDisappear(): Unit {
        markdownListConfiguration
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
        Column() {
            renderTableHeaderOrBody()
        }
            // 设置元素内容的对齐方式
            .align(Alignment.Start)
            // 设置元素水平方向的布局
            .direction(Direction.Ltr)
            // 设置外边距属性
            .margin(top: marginTop, bottom: marginBottom)
            // 设置组件自身的宽度
            .width(100.percent)
    }

    @Builder
    func renderTableHeaderOrBody() {
        List() {
            LazyForEach(
                nodeViewDataSource,
                itemGeneratorFunc: {
                    tableNodeView: NodeView, idRow: Int64 => ListItem() {
                        // 行信息
                        renderTableRow(tableNodeView, idRow)
                    }
                }
            )
        }
            // 统一边框样式设置接口
            .border(width: Length(markdownConfiguration.tableTheme.tableBorderWidth / 2.0),
            color: markdownConfiguration.tableTheme.tableBorderColor, style: BorderStyle.Solid)
    }

    /**
     * 文本
     */
    @Builder
    func tableComponentText(nodeView: NodeView, isHeader: Bool) {
        // 设置文本内容
        Span(spanText(nodeView))
            // 设置文本的字体列表
            .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
            // 设置文本尺寸
            .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
            // 设置文本的字体粗细
            .fontWeight(spanFontWeight(nodeView, isHeader))
            // 设置文本的字体样式
            .fontStyle(spanFontStyle(nodeView))
            // 设置文本颜色
            .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
            // 设置文本字符间距
            .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
            // 设置文本装饰线样式及其颜色
            .decoration(
                decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0],
                color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1]
            )
            // 点击动作触发该方法调用
            .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
    }

    /**
     * 内联代码
     */
    @Builder
    func tableComponentCode(nodeView: NodeView, isHeader: Bool) {
        // 设置文本内容
        Span(spanText(nodeView))
            // 设置文本的字体列表
            .fontFamily(spanFontFamily(true, markdownConfiguration.markdownTheme, false))
            // 设置文本尺寸
            .fontSize(spanFontSize(nodeView, true, markdownConfiguration.markdownTheme, false, 0))
            // 设置文本的字体粗细
            .fontWeight(spanFontWeight(nodeView, isHeader))
            // 设置文本的字体样式
            .fontStyle(spanFontStyle(nodeView))
            // 设置文本颜色
            .fontColor(spanFontColor(nodeView, true, markdownConfiguration.markdownTheme, false))
            // 设置文本字符间距
            .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
            // 设置文本装饰线样式及其颜色
            .decoration(
                decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0],
                color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1]
            )
            // 点击动作触发该方法调用
            .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
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
                            .constraintSize(maxWidth: Length(100, unitType: LengthType.percent))
                            // 点击动作触发该方法调用
                            .onClick {
                                evt => latexImageOnClick(item.arrayUint8(), item.height().px, item.width().px,
                                    markdownConfiguration.latexImageCallback)
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
                tableCell.children.toArray(),
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        if ((tableCell.node as TableCell)().isHeader()) {
                            tableComponentText(item, true)
                        } else {
                            tableComponentText(item, false)
                        }
                    } else if (item.node is Code) {
                        // 内联代码
                        if ((tableCell.node as TableCell)().isHeader()) {
                            tableComponentCode(item, true)
                        } else {
                            tableComponentCode(item, false)
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
            .padding(markdownConfiguration.tableTheme.tableCellPadding)
            // 设置组件的背景色
            .backgroundColor(
                renderTableCellColor(
                    (tableCell.node as TableCell)(),
                    markdownConfiguration.tableTheme,
                    idRow
                )
            )
            // 统一边框样式设置接口
            .border(width: Length(markdownConfiguration.tableTheme.tableBorderWidth / 2.0),
                color: markdownConfiguration.tableTheme.tableBorderColor, style: BorderStyle.Solid)
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
        let nodeViews = ArrayList<NodeView>()
        for (nodeView in list) {
            if (nodeView.node is TableBody || nodeView.node is TableHead) {
                for (nodeViewChildren in nodeView.children) {
                    nodeViews.append(nodeViewChildren)
                }
            } else if (nodeView.node is TableRow) {
                nodeViews.append(nodeView)
            }
        }
        if (isFull) {
            nodeViewDataSource.clear()
            nodeViewDataSource.addDatas(nodeViews)
        } else {
            if (nodeViews.size == 0) {
                return
            }
            if (nodeViews.size > nodeViewDataSource.totalCount()) {
                if (nodeViewDataSource.totalCount() != 0) {
                    nodeViewDataSource.replaceDate(nodeViewDataSource.totalCount() - 1,
                        nodeViews[nodeViewDataSource.totalCount() - 1])
                }
                for (i in nodeViews.size - nodeViewDataSource.totalCount()..0 : -1) {
                    nodeViewDataSource.addData(nodeViews[nodeViews.size - i])
                }
            } else if (nodeViews.size == nodeViewDataSource.totalCount()) {
                nodeViewDataSource.replaceDate(nodeViewDataSource.totalCount() - 1, nodeViews[nodeViews.size - 1])
            } else {
                nodeViewDataSource.replaceDate(nodeViews.size - 1, nodeViews[nodeViews.size - 1])
                for (i in nodeViewDataSource.totalCount() - nodeViews.size..0 : -1) {
                    nodeViewDataSource.deleteData(nodeViewDataSource.totalCount() - i)
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
            markdownConfiguration.markdownTheme.resPath, markdownConfiguration, componentWidth, callback)
        futs.append(fut)
        return idx
    }
}
