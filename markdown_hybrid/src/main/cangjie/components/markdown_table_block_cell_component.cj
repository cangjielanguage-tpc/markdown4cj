/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown表格自定义控件
 */
@Component
class MarkdownTableBlockCellComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 表格Cell节点
     */
    var nodeView: NodeView

    /**
     * 是否是标题
     */
    var isHeader: Bool

    /**
     * 对齐方式
     */
    var alignment: ?TableAlignment

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidth: Float64

    /**
     * 内容第几行
     */
    var idRow: Int64

    /**
     * 一行的第几条
     */
    var idxItem: Int64

    /**
     * 表格有几行
     */
    var dataRowSize: Int64

    /**
     * 表格有几列
     */
    var dataCellSize: Int64

    /**
     * 缓存的表格的Cell列表
     */
    var tableCellComponents: HashMap<Int64, MarkdownTableBlockCellComponent>

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    /**
     * 最小宽度
     */
    @State
    var minTextWidth: Float64 = 0.0

    /**
     * 宽度列表
     */
    @Prop
    @Watch[refreshTextWidth]
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass>

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeView)
        // 缓存当前控件
        tableCellComponents.add(this.nodeView.nodeHash, this)
        // 宽度刷新
        refreshTextWidth()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = tableCellComponents.get(this.nodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                tableCellComponents.remove(this.nodeView.nodeHash)
            }
        } else {
            tableCellComponents.remove(this.nodeView.nodeHash)
        }
    }

    func build() {
        Column() {
            tableBlockCellComponent()
        }
        // 设置 Column 子组件在水平方向上的对齐格式
        .alignItems(renderTableCellColumnAlign(alignment))
        // 设置 Column 子组件在垂直方向上的对齐格式
        .justifyContent(FlexAlign.Center)
        // 覆盖 Flex 布局容器中 alignItems 默认配置
        .alignSelf(ItemAlign.Stretch)
        // 设置内边距属性
        .padding(markdownConfiguration.markdownTheme.tableCellPadding)
        // 设置组件的背景色
        .backgroundColor(renderTableCellColor(isHeader, markdownConfiguration.markdownTheme, idRow))
        // 设置边框的宽度
        .borderWidth(EdgeWidths(left: leftWidths().vp, right: rightWidths().vp, top: topWidths().vp, bottom: bottomWidths().vp))
        // 设置元素的边框样式
        .borderStyle(BorderStyle.Solid)
        // 设置边框的颜色
        .borderColor(markdownConfiguration.markdownTheme.tableBorderColor)
        // 设置约束尺寸，组件布局时，进行尺寸范围限制
        .constraintSize(minWidth: minTextWidth.vp, maxWidth: markdownConfiguration.markdownTheme.tableMaxTextWidth.vp)
        // 组件区域变化时触发该回调
        .interopOnSizeChange(
            {
                old, new =>
                    if (old.width == new.width) {
                        return
                    }
                    let newWidth: Float64 = new.width
                    if (let Some(v) <- cellWidthArrayIndexed.get().get(idxItem)) {
                        if (v.index == idxItem && newWidth > v.minWidth) {
                            cellWidthArrayIndexed[idxItem] = CellWidthArrayIndexedClass(minWidth: newWidth, index: idxItem)
                        }
                    }
            }
        )
    }

    @Builder
    func tableBlockCellListComponent(item: NodeView) {
        if (item.node is CommonmarkText) {
            // 文本
            if (DeviceInfo.sdkApiVersion >= 19) {
                tableComponentText19(item, isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold), markdownConfiguration)
            } else {
                tableComponentText18(item, isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold), markdownConfiguration)
            }
        } else if (item.node is Footnote) {
            // 脚注
            if (DeviceInfo.sdkApiVersion >= 19) {
                tableComponentFootnote19(item, isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold), markdownConfiguration, fontCallback)
            } else {
                tableComponentFootnote18(item, isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold), markdownConfiguration, fontCallback)
            }
        } else if (item.node is Code) {
            // 内联代码
            inLineCodeSpanComponent(item, markdownConfiguration, isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold) || item.strongEmphasis, isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold), false, 2)
        } else if (item.node is HardLineBreak) {
            // 硬换行
            Span("\n")
        } else if (item.node is SoftLineBreak) {
            // 软换行
            Span(spanSoftLineBreak(markdownConfiguration.markdownTheme.isLineBreak))
        } else if (item.node is CommonmarkLink) {
            // 链接
            linkSpanComponent(false, false, 0, item, markdownConfiguration, componentWidth, imageCallback, isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold), false, 2, false)
        } else if (item.node is ImageHtmlNode) {
            // HTML图片
            htmlImageSpanComponent(item, markdownConfiguration, markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth, imageCallback)
        } else if (item.node is StyleImage) {
            //  图片Style节点
            styleImageSpanComponent(item, markdownConfiguration, markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth, imageCallback)
        } else if (item.node is CommonmarkImage) {
            // 图片节点
            coreImageSpanComponent(item, markdownConfiguration, markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth, imageCallback)
        } else if (item.node is LatexMathNode) {
            // 数学公式节点
            latexSpanComponent(item, markdownConfiguration, markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth)
        } else {
            // TODO 其他节点
            Span("")
        }
    }

    /**
     * 表格文字内容
     */
    @Builder
    func tableBlockCellComponent18() {
        Text() {
            ForEach(
                nodeViewList,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => tableBlockCellListComponent(item)
                },
                keyGeneratorFunc: {
                    item: NodeView, idx: Int64 => return "${idx}-${item.nodeHash}-${item.contentHash}"
                }
            )
        }
        // 设置行高
        .lineHeight(markdownConfiguration.markdownTheme.tableTextLineHeight)
        // 自定义设置组件是否支持文本可复制粘贴
        .interopCopyOption(if (markdownConfiguration.markdownTheme.isOnCopy) {
            true
        } else {
            false
        })
        // 自定义长按文本内部区域弹出剪贴板后，点击剪切板复制按钮，触发该事件
        .interopOnCopy({
            str => if (let Some(v) <- markdownConfiguration.textCopyCallback) {
                v(str)
            }
        })
    }

    /**
     * 表格文字内容
     */
    @Builder
    func tableBlockCellComponent19() {
        Text() {
            ForEach(
                nodeViewList,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => tableBlockCellListComponent(item)
                },
                keyGeneratorFunc: {
                    item: NodeView, idx: Int64 => return "${idx}-${item.nodeHash}-${item.contentHash}"
                }
            )
        }
        // 设置行高
        .lineHeight(markdownConfiguration.markdownTheme.tableTextLineHeight)
        // 支持设备内复制
        .copyOption(if (markdownConfiguration.markdownTheme.isOnCopy) {
            CopyOptions.LocalDevice
        } else {
            CopyOptions.None
        })
        // 长按文本内部区域弹出剪贴板后，点击剪切板复制按钮，触发该事件。目前文本复制仅支持文本。
        .onCopy({
            str => if (let Some(v) <- markdownConfiguration.textCopyCallback) {
                markdownConfiguration.textCopyCallback()(str)
            }
        })
    }

    /**
     * 表格文字内容
     */
    @Builder
    func tableBlockCellComponent() {
        if (DeviceInfo.sdkApiVersion >= 19) {
            tableBlockCellComponent19()
        } else {
            tableBlockCellComponent18()
        }
    }

    func leftWidths(): Float64 {
        return 0.0
    }

    func rightWidths(): Float64 {
        return if (idxItem == dataCellSize - 1) {
            0.0
        } else {
            markdownConfiguration.markdownTheme.tableBorderWidth
        }
    }

    func topWidths(): Float64 {
        return if (idRow == 0) {
            0.0
        } else {
            markdownConfiguration.markdownTheme.tableBorderWidth
        }
    }

    func bottomWidths(): Float64 {
        return 0.0
    }

    func refreshTextWidth(): Unit {
        if (let Some(v) <- cellWidthArrayIndexed.get().get(idxItem)) {
            if (v.index == idxItem && v.minWidth > minTextWidth) {
                minTextWidth = v.minWidth
            }
        } else {
            minTextWidth = markdownConfiguration.markdownTheme.tableMinTextWidth
        }
    }

    /**
     * 数据刷新
     */
    public func refreshData(nodeView: NodeView): Unit {
        this.nodeView = nodeView
        refreshnodeViewList(this.nodeView, nodeViewList, Option<HashMap<Int64,MarkdownTableBlockCellComponent>>.None)
    }
}

@Observed
class CellWidthArrayIndexedClass {
    @Publish
    var minWidth: Float64 = 0.0
    @Publish
    var index: Int64 = -1
}
