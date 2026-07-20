package markdown.components

import ohos.state_macro_manage.*
import ohos.component_utils.*

/**
 * 表格Cell控件
 */
@Component
class MarkdownTableBlockCellComponent {
    @Prop
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
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass> // 表格宽度列表（共享引用，@Observed+@Publish自动响应式）
    @State
    var isRefresh: Bool = false // 表格Cell子节点是否不为0
    @State
    var tableBlockCellNodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>() // 列表数据

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(tableBlockCellNodeView.nodeHash, refreshTableBlockCellData)
        refreshTableBlockCellData(tableBlockCellNodeView) // 初始化刷新数据
        // 链接曝光注册（与段落组件保持一致）
        if (tableBlockCellMarkdownConfiguration.elementExposureCallback.isSome()) {
            let urls = MarkdownLinkExposureRegistry.extractHttpLinks(tableBlockCellNodeView)
            MarkdownLinkExposureRegistry.register(tableBlockCellNodeView.nodeHash, urls)
        }
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(tableBlockCellNodeView.nodeHash)
        MarkdownLinkExposureRegistry.unregister(tableBlockCellNodeView.nodeHash)
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
        .constraintSize(minWidth: currentMinWidth().vp, maxWidth: tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableMaxCellWidth.vp)
        .interopOnSizeChange({
            old, new =>
                if (old.width == new.width) {
                    return
                }
                let newWidth: Float64 = new.width
                if (let Some(v) <- cellWidthArrayIndexed.get().get(tableBlockCellCell)) {
                    if (v.index == tableBlockCellCell && newWidth > v.minWidth) {
                        // 直接修改 @Publish 属性，通知所有观察该属性的组件重渲染
                        v.minWidth = newWidth
                    }
                }
        })
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
        .textAlign(TextAlign.Start)
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
                    markdownSpanComponent(
                        spanListMarkdownConfiguration,
                        spanListNodeView,
                        spanListTocListOnClick,
                        spanListFootnoteCallback,
                        tableBlockCellCell == 0 && spanListMarkdownConfiguration.markdownTheme.tableTheme.tableFirstColumnIsBold
                    )
                } else if (spanListNodeView.nodeType == "LatexMathNode") {
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
                    Span(spanSoftLineBreak(spanListMarkdownConfiguration.markdownTheme.globalTheme.isLineBreak))
                } else if (spanListNodeView.nodeType == "HardLineBreak") {
                    Span("\n")
                } else if (spanListNodeView.nodeType == "Link" || spanListNodeView.nodeType == "HeadLink") {
                    spanLinkComponent(
                        spanListNodeView,
                        spanListMarkdownConfiguration,
                        spanListTocListOnClick,
                        spanListFootnoteCallback,
                        false
                    )
                } else if (spanListNodeView.nodeType == "Image" || spanListNodeView.nodeType == "StyleImage" || spanListNodeView.nodeType == "ImageHtmlNode") {
                    spanImageComponent(
                        spanListNodeView,
                        spanListMarkdownConfiguration,
                        spanListComponentWidth,
                        spanListImageCallback
                    )
                } else {
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
     */
    func leftWidths(): Float64 {
        return 0.0
    }

    /**
     * 表格右部边框宽度
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
     */
    func bottomWidths(): Float64 {
        return 0.0
    }

    /**
     * 获取当前Cell的最小宽度
     * 直接读取 @Publish minWidth 属性，建立响应式依赖
     * 当其他Cell更新同一列的minWidth时，本Cell会自动重渲染
     *
     * @return Float64 最小宽度（vp）
     */
    func currentMinWidth(): Float64 {
        if (let Some(v) <- cellWidthArrayIndexed.get().get(tableBlockCellCell)) {
            return v.minWidth
        }
        return tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableMinCellWidth
    }

    /**
     * 表格Cell控件数据刷新
     */
    public func refreshTableBlockCellData(newNodeView: NodeView): Unit {
        this.tableBlockCellNodeView = newNodeView
        let refreshNodeViewChildren = tableBlockCellNodeView.children
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size
        let tableBlockCellNodeViewListSize: Int64 = tableBlockCellNodeViewList.size
        if (refreshNodeViewSize == 0) {
            tableBlockCellNodeViewList.clear()
            return
        }
        if (refreshNodeViewSize > 0) {
            isRefresh = true
        }
        let minLen = if (refreshNodeViewSize < tableBlockCellNodeViewListSize) { refreshNodeViewSize } else { tableBlockCellNodeViewListSize }
        for (i in 0..minLen) {
            let oldNode = tableBlockCellNodeViewList[i]
            let newNode = refreshNodeViewChildren[i]
            if (oldNode.nodeHash != newNode.nodeHash || oldNode.contentHash != newNode.contentHash) {
                tableBlockCellNodeViewList[i] = newNode
                if (newNode.nodeType == "LatexMathNode" && oldNode.nodeHash == newNode.nodeHash) {
                    MarkdownRefreshRegistry.refresh(newNode.nodeHash, newNode)
                }
            }
        }
        if (refreshNodeViewSize > tableBlockCellNodeViewListSize) {
            for (i in tableBlockCellNodeViewListSize..refreshNodeViewSize) {
                tableBlockCellNodeViewList.append(refreshNodeViewChildren[i])
            }
        } else if (tableBlockCellNodeViewListSize > refreshNodeViewSize) {
            for (i in tableBlockCellNodeViewListSize - 1..=refreshNodeViewSize : -1) {
                tableBlockCellNodeViewList.remove(i)
            }
        }
    }
}
