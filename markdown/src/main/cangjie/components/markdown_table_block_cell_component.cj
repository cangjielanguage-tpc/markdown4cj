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
    var tableBlockCellNodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>() // 列表数据

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(tableBlockCellNodeView.nodeHash, refreshTableBlockCellData)
        refreshTableBlockCellData(tableBlockCellNodeView) // 初始化刷新数据
        refreshTextWidth() // 宽度刷新
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(tableBlockCellNodeView.nodeHash)
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
        Text() {
            if (isRefresh) {
                markdownSpanListComponent(
                    tableBlockCellNodeViewList,
                    tableBlockCellMarkdownConfiguration,
                    tableBlockCellComponentWidth,
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
     * @param spanListComponentWidth 最大宽度
     * @param spanListTocListOnClick TOC点击事件
     * @param spanListImageCallback 图片点击事件
     * @param spanListFootnoteCallback 脚注点击事件
     */
    @Builder
    func markdownSpanListComponent(
        spanListNodeViewList: ObservedArrayList<NodeView>,
        spanListMarkdownConfiguration: MarkdownConfiguration,
        spanListComponentWidth: Float64,
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
                    MarkdownLatexMathInLineComponent(
                        markdownTheme: spanListMarkdownConfiguration.markdownTheme,
                        latexMathInLineStr: spanListNodeView.nodeText,
                        nodeHash: spanListNodeView.nodeHash,
                        latexMathInLineComponentWidth: spanListComponentWidth,
                        latexImageCallback: spanListMarkdownConfiguration.latexImageCallback,
                        latexStrCallback: spanListMarkdownConfiguration.latexStrCallback,
                        latexMathInLineLinkCallback: spanListMarkdownConfiguration.linkCallback,
                        latexMathInLineIsLink: spanListNodeView.isLink,
                        latexMathInLineLinkUrl: spanListNodeView.linkUrl
                    )
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
                        spanListComponentWidth,
                        spanListImageCallback
                    )
                } else {
                    // 其他节点
                    tableBlockCellCustomTableLineBuilder(spanListNodeView, index)
                }
            },
            keyGeneratorFunc: {
                spanListNodeView: NodeView, idx: Int64 =>
                    if (spanListNodeView.nodeType == "LatexMathNode") {
                        return "${idx}-${spanListNodeView.nodeHash}"
                    }
                    return "${idx}-${spanListNodeView.nodeHash}-${spanListNodeView.contentHash}"
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
    public func refreshTableBlockCellData(newNodeView: NodeView): Unit {
        this.tableBlockCellNodeView = newNodeView
        let refreshNodeViewChildren = tableBlockCellNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let tableBlockCellNodeViewListSize: Int64 = tableBlockCellNodeViewList.size // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            tableBlockCellNodeViewList.clear()
            return
        }
        if (refreshNodeViewSize > 0) {
            isRefresh = true
        }
        // 对比重叠区间，hash变化时替换数据
        let minLen = if (refreshNodeViewSize < tableBlockCellNodeViewListSize) { refreshNodeViewSize } else { tableBlockCellNodeViewListSize }
        for (i in 0..minLen) {
            let oldNode = tableBlockCellNodeViewList[i]
            let newNode = refreshNodeViewChildren[i]
            if (oldNode.nodeHash != newNode.nodeHash || oldNode.contentHash != newNode.contentHash) {
                // 自身节点唯一ID不相同需要刷新数据
                // 子节点唯一ID不相同需要刷新子节点数据
                tableBlockCellNodeViewList[i] = newNode
                if (newNode.nodeType == "LatexMathNode" && oldNode.nodeHash == newNode.nodeHash) {
                    MarkdownRefreshRegistry.refresh(newNode.nodeHash, newNode)
                }
            }
        }
        // 新增部分
        if (refreshNodeViewSize > tableBlockCellNodeViewListSize) {
            for (i in tableBlockCellNodeViewListSize..refreshNodeViewSize) {
                tableBlockCellNodeViewList.append(refreshNodeViewChildren[i])
            }
        } else if (tableBlockCellNodeViewListSize > refreshNodeViewSize) {
            // 删除多余部分（从后往前删，避免索引移位）
            for (i in tableBlockCellNodeViewListSize - 1..=refreshNodeViewSize : -1) {
                tableBlockCellNodeViewList.remove(i)
            }
        }
    }
}
