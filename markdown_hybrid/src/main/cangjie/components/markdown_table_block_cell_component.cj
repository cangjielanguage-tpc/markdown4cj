package markdown.components

import ohos.state_macro_manage.*

/**
 * 表格Cell控件
 */
@Component
class MarkdownTableBlockCellComponent {
    var tableBlockCellMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var tableBlockCellNodeView: NodeView // 表格Cell控件自身节点
    @Prop
    var tableBlockCellComponentWidth: Float64 // 控件宽度 - 单位vp
    var tableBlockCellComponents: HashMap<Int64, MarkdownTableBlockCellComponent> // 缓存的表格Cell控件数据
    @BuilderParam
    var tableBlockCellCustomTableLineBuilder: (NodeView, Int64) -> Unit // 自定义行内表格Cell控件
    var tableBlockCellImageCallback: (String) -> Unit // 图片点击事件
    var tableBlockCellFootnoteCallback: (String) -> Unit // 脚注点击事件
    var tableBlockCellRow: Int64 // 表格的第几行
    var tableBlockCellCell: Int64 // 表格的第几条
    var tableBlockCellCellSize: Int64 // 表格总共有几列
    @Prop
    @Watch[refreshTextWidth]
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass> // 表格宽度列表
    @State
    var tableBlockCellMinCellWidth: Float64 = 0.0 // 表格Cell最小宽度
    @State
    var isRefresh: Bool = false // 表格Cell子节点是否不为0
    @State
    var spanRenderSerial: Int64 = 0 // Span异步资源刷新触发器（触发build重跑后ForEach按节点spanRenderVersion逐项diff，仅数据变化的item重建）
    @State
    var tableBlockCellNodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>() // 列表数据

    protected override func aboutToAppear(): Unit {
        refreshTableBlockCellData(tableBlockCellNodeView) // 初始化刷新数据
        tableBlockCellComponents.add(tableBlockCellNodeView.nodeHash, this) // 缓存当前控件
        refreshTextWidth() // 宽度刷新
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = tableBlockCellComponents.get(tableBlockCellNodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                tableBlockCellComponents.remove(tableBlockCellNodeView.nodeHash)
            }
        } else {
            tableBlockCellComponents.remove(tableBlockCellNodeView.nodeHash)
        }
        // 释放列表中各节点持有的行内Span异步PixelMap
        releaseSpanListPixelMaps(tableBlockCellNodeViewList)
    }

    func build() {
        Column() {
            tableBlockCellComponent()
        }
        .alignItems(tableBlockCellNodeView.tableAlignment)
        .justifyContent(FlexAlign.Center)
        .alignSelf(ItemAlign.Stretch)
        .padding(top: tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableCellPaddingTop, right: tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableCellPaddingRight, bottom: tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableCellPaddingBottom, left:tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableCellPaddingLeft)
        .backgroundColor(renderTableCellColor(tableBlockCellNodeView, tableBlockCellMarkdownConfiguration.markdownTheme, tableBlockCellRow))
        .borderWidth(EdgeWidths(left: leftWidths().vp, right: rightWidths().vp, top: topWidths().vp, bottom: bottomWidths().vp))
        .borderStyle(tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableBorderStyle)
        .borderColor(tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableBorderColor)
        .constraintSize(minWidth: tableBlockCellMinCellWidth.vp, maxWidth: tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableMaxCellWidth.vp)
        .interopOnSizeChange(
            {
                old, new =>
                    if (old.width == new.width) {
                        return
                    }
                    let newWidth: Float64 = new.width
                    if (let Some(v) <- cellWidthArrayIndexed.get().get(tableBlockCellCell)) {
                        if (v.index == tableBlockCellCell && newWidth > v.minWidth) {
                            cellWidthArrayIndexed[tableBlockCellCell] = CellWidthArrayIndexedClass(minWidth: newWidth, index: tableBlockCellCell)
                        }
                    }
            }
        )
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

    /**
     * 表格文字内容
     */
    @Builder
    func tableBlockCellComponent18() {
        Text() {
            if (isRefresh) {
                markdownSpanListComponent(
                    tableBlockCellNodeViewList,
                    tableBlockCellMarkdownConfiguration,
                    Option<(Int64) -> Unit>.None,
                    tableBlockCellImageCallback,
                    tableBlockCellFootnoteCallback
                )
            }
        }
        .interopHalfLeading(true)
        .interopCopyOption(if (tableBlockCellMarkdownConfiguration.markdownTheme.globalTheme.isOnCopy) {
            true
        } else {
            false
        })
        .interopOnCopy({
            str => if (let Some(v) <- tableBlockCellMarkdownConfiguration.textCopyCallback) {
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
            if (isRefresh) {
                markdownSpanListComponent(
                    tableBlockCellNodeViewList,
                    tableBlockCellMarkdownConfiguration,
                    Option<(Int64) -> Unit>.None,
                    tableBlockCellImageCallback,
                    tableBlockCellFootnoteCallback
                )
            }
        }
        .halfLeading(true)
        .copyOption(if (tableBlockCellMarkdownConfiguration.markdownTheme.globalTheme.isOnCopy) {
            CopyOptions.LocalDevice
        } else {
            CopyOptions.None
        })
        .onCopy({
            str => if (let Some(v) <- tableBlockCellMarkdownConfiguration.textCopyCallback) {
                tableBlockCellMarkdownConfiguration.textCopyCallback()(str)
            }
        })
    }

    /**
     * Span循环列表
     *
     * @param spanListNodeViewList NodeView列表
     * @param spanListMarkdownConfiguration markdown配置
     * @param spanListTocListOnClick TOC点击事件
     * @param spanListImageCallback 图片点击事件
     * @param spanListFootnoteCallback 脚注点击事件
     */
    @Builder
    func markdownSpanListComponent(
        spanListNodeViewList: ObservedArrayList<NodeView>,
        spanListMarkdownConfiguration: MarkdownConfiguration,
        spanListTocListOnClick: ?(Int64) -> Unit,
        spanListImageCallback: (String) -> Unit,
        spanListFootnoteCallback: (String) -> Unit
    ) {
        ForEach(
            spanListNodeViewList,
            itemGeneratorFunc: {
                spanListNodeView: NodeView, index: Int64 => if (spanListNodeView.nodeType == "Text" || spanListNodeView.nodeType == "Code" || spanListNodeView.nodeType == "Footnote") {
                    // Text：普通文本，Code：内联代码，Footnote：脚注节点
                    markdownSpanComponent(
                        spanListMarkdownConfiguration,
                        spanListNodeView,
                        spanListTocListOnClick,
                        spanListFootnoteCallback,
                        tableBlockCellCell == 0 && spanListMarkdownConfiguration.markdownTheme.tableTheme.tableFirstColumnIsBold
                    )
                } else if (spanListNodeView.nodeType == "LatexMathNode") {
                    // 数学公式
                    spanLatexMathComponent(spanListNodeView, spanListMarkdownConfiguration)
                } else if (spanListNodeView.nodeType == "SoftLineBreak") {
                    // 软换行
                    Span(spanSoftLineBreak(spanListMarkdownConfiguration.markdownTheme.globalTheme.isLineBreak))
                } else if (spanListNodeView.nodeType == "HardLineBreak") {
                    // 硬换行
                    Span("\n")
                } else if (spanListNodeView.nodeType == "Link" || spanListNodeView.nodeType == "HeadLink") {
                    // 链接, TOC列表链接
                    spanLinkComponent(
                        spanListNodeView,
                        spanListMarkdownConfiguration,
                        spanListTocListOnClick,
                        spanListFootnoteCallback,
                        false
                    )
                } else if (spanListNodeView.nodeType == "Image" || spanListNodeView.nodeType == "StyleImage" || spanListNodeView.nodeType == "ImageHtmlNode") {
                    // Image：图片节点， StyleImage：图片Style节点，ImageHtmlNode：HTML图片
                    spanImageComponent(
                        spanListNodeView,
                        spanListMarkdownConfiguration,
                        spanListImageCallback,
                        {
                            => refreshSpanDatasAfterAsync()
                        }
                    )
                } else {
                    // 其他节点
                    tableBlockCellCustomTableLineBuilder(spanListNodeView, index)
                }
            },
            keyGeneratorFunc: {
                spanListNodeView: NodeView, idx: Int64 => return "${idx}-${spanListNodeView.nodeHash}-${spanListNodeView.contentHash}-${spanListNodeView.spanRenderVersion}"
            }
        )
    }

    /**
     * 表格左部边框宽度
     *
     * @return Float64 表格左部边框宽度
     */
    func leftWidths(): Float64 {
        return 0.0
    }

    /**
     * 表格右部边框宽度
     *
     * @return Float64 表格右部边框宽度
     */
    func rightWidths(): Float64 {
        return if (tableBlockCellCell == tableBlockCellCellSize - 1) {
            0.0
        } else {
            tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableBorderWidth
        }
    }

    /**
     * 表格顶部边框宽度
     *
     * @return Float64 表格顶部边框宽度
     */
    func topWidths(): Float64 {
        return if (tableBlockCellRow == 0) {
            0.0
        } else {
            tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableBorderWidth
        }
    }

    /**
     * 表格底部边框宽度
     *
     * @return Float64 表格底部边框宽度
     */
    func bottomWidths(): Float64 {
        return 0.0
    }

    /**
     * 表格最小宽度刷新
     */
    func refreshTextWidth(): Unit {
        if (let Some(v) <- cellWidthArrayIndexed.get().get(tableBlockCellCell)) {
            if (v.index == tableBlockCellCell && v.minWidth > tableBlockCellMinCellWidth) {
                tableBlockCellMinCellWidth = v.minWidth
            }
        } else {
            tableBlockCellMinCellWidth = tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableMinCellWidth
        }
    }

    /**
     * 表格Cell控件数据刷新
     *
     * @param tableBlockCellNodeView 刷新的新数据
     */
    public func refreshTableBlockCellData(tableBlockCellNodeView: NodeView): Unit {
        this.tableBlockCellNodeView = tableBlockCellNodeView
        let refreshNodeViewChildren = tableBlockCellNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let tableBlockCellNodeViewListSize: Int64 = tableBlockCellNodeViewList.size // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            releaseSpanListPixelMaps(tableBlockCellNodeViewList)
            tableBlockCellNodeViewList.clear()
            return
        }
        if (refreshNodeViewSize > 0) {
            isRefresh = true
        }
        if (refreshNodeViewSize > tableBlockCellNodeViewListSize) {
            // 新数据大于页面数据
            refreshTableBlockCellDatas(tableBlockCellNodeViewListSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环添加新数据
            for (i in tableBlockCellNodeViewListSize..refreshNodeViewSize) {
                tableBlockCellNodeViewList.append(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == tableBlockCellNodeViewListSize) {
            // 新数据等于页面数据
            refreshTableBlockCellDatas(tableBlockCellNodeViewListSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
        } else {
            // 新数据小于页面数据
            refreshTableBlockCellDatas(refreshNodeViewSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环删除多余的旧数据
            for (i in tableBlockCellNodeViewListSize - 1..=refreshNodeViewSize : -1) {
                tableBlockCellNodeViewList[i].releaseSpanPixelMaps()
                tableBlockCellNodeViewList.remove(i)
            }
        }
        // 刷新行内Span异步资源（链接图标、数学公式、行内图片），结果写回后通过spanRenderSerial触发build重跑，由ForEach按节点spanRenderVersion逐项diff仅重建数据变化的item
        refreshSpanAsyncResources(tableBlockCellNodeViewList, tableBlockCellMarkdownConfiguration, tableBlockCellComponentWidth, false, {
            => refreshSpanDatasAfterAsync()
        })
    }

    /**
     * Span异步资源写回后的刷新（重新赋值数据源触发ForEach全量diff，spanRenderVersion仅变化的item重建）
     */
    protected func refreshSpanDatasAfterAsync(): Unit {
        spanRenderSerial += 1
        let oldList = tableBlockCellNodeViewList
        let newList = ObservedArrayList<NodeView>()
        for (i in 0..oldList.size) {
            newList.append(oldList[i])
        }
        tableBlockCellNodeViewList = newList
    }

    /**
     * 循环判断历史数据有没有做过修改
     *
     * @param size 长度
     * @param refreshNodeViews 刷新的数据
     */
    func refreshTableBlockCellDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = tableBlockCellNodeViewList[i]
            let newNodeHash = refreshNodeView.nodeHash
            let oldNodeHash = dataSourceNode.nodeHash
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            if (newNodeHash != oldNodeHash || newContentHash != oldContentHash) {
                // 自身节点唯一ID不相同需要刷新数据
                // 子节点唯一ID不相同需要刷新子节点数据
                dataSourceNode.releaseSpanPixelMaps() // 释放被替换节点持有的行内异步PixelMap
                tableBlockCellNodeViewList[i] = refreshNodeView
            }
        }
    }
}
