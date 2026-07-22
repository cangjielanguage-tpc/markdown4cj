package markdown.components

import ohos.state_macro_manage.*

/**
 * 表格Cell控件
 * 对齐ArkUI MarkdownTableCell.ets：@Consume tableColumnWidths/cellWidthTracker
 * onAreaChange写入tracker → onWidthUpdated回调 → applyColumnWidths → columnWidths重赋值 → @Consume触发Cell重渲染
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
    @BuilderParam
    var inlineImageCardComponent: (?String,?String, ?String) -> Unit  //自定义行内卡片布局
    @BuilderParam
    var inlineLinkCardComponent: (?String, ?String) -> Unit  //自定义行内链接卡片布局
    var tableBlockCellRow: Int64 // 表格的第几行
    var tableBlockCellCell: Int64 // 表格的第几条
    var tableBlockCellCellSize: Int64 // 表格总共有几列
    var tableBlockCellRowSize: Int64 // 表格总共有几行
    @Consume["tableColumnWidths"]
    var columnWidths: Array<Float64> // 各列宽度快照（@Consume从MarkdownTableBlockComponent同步）
    @Consume
    var cellWidthTracker: CellWidthTracker // 列宽跟踪器（非@Observed，onAreaChange只写不触发重渲染）
    @State
    var isRefresh: Bool = false // 表格Cell子节点是否不为0
    @State
    var tableBlockCellNodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>() // 列表数据
    // 链接曝光：URL列表缓存 + 当前可见状态（与MarkdownParagraphComponent同款）
    // 简化版：Text级别曝光，与屏幕 [0, screenH] 求交判定可见性
    var tableBlockCellExposureUrls: ArrayList<String> = ArrayList<String>()
    var tableBlockCellExposureVisible: Bool = false
    var tableBlockCellId: String = "" // Cell Text的唯一id
    var viewportReady: Bool = false // onAreaChange是否触发过
    var isAlive: Bool = true // 组件是否存活

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(tableBlockCellNodeView.nodeHash, refreshTableBlockCellData)
        refreshTableBlockCellData(tableBlockCellNodeView)
        // Cell Text的唯一id
        tableBlockCellId = "md-exp-${tableBlockCellNodeView.nodeHash}"
        // 链接曝光：仅提取URL列表缓存
        if (isExposureEnabled()) {
            tableBlockCellExposureUrls = MarkdownLinkExposureRegistry.extractHttpLinks(tableBlockCellNodeView)
        }
    }

    protected override func aboutToDisappear(): Unit {
        isAlive = false
        MarkdownRefreshRegistry.unregister(tableBlockCellNodeView.nodeHash)
        if (tableBlockCellExposureVisible) {
            MarkdownLinkExposureRegistry.unregister(tableBlockCellNodeView.nodeHash)
            tableBlockCellExposureVisible = false
        }
    }

    /**
     * 是否启用元素曝光统计：查 registry（不依赖 @Prop 的 MarkdownConfiguration.elementExposureCallback）
     */
    func isExposureEnabled(): Bool {
        return MarkdownLinkExposureRegistry.isExposureEnabled()
    }

    /**
     * 防抖触发曝光评估
     */
    func scheduleExposure(): Unit {
        if (!isAlive) {
            return
        }
        if (!isExposureEnabled()) {
            return
        }
        if (tableBlockCellExposureUrls.size == 0) {
            return
        }
        spawn {
            sleep(Duration.millisecond * 16)
            launch {
                if (isAlive && viewportReady) {
                    evaluateExposure()
                }
            }
        }
    }

    /**
     * 曝光评估：用 componentUtils 拿 Cell 全局 rect，与屏幕 [0, screenH] 求交，判定可见性
     * 简化版：Text级别曝光
     */
    func evaluateExposure(): Unit {
        var globalTop: Float64 = 0.0
        var globalBottom: Float64 = 0.0
        try {
            let info = ComponentUtils.getRectangleById(tableBlockCellId)
            globalTop = Float64(info.windowOffset.y)
            globalBottom = globalTop + Float64(info.size.height)
        } catch (_: Exception) {
            return
        }
        let screenHeight = Float64(getDefaultDisplaySync().height)
        let vpTop = 0.0
        let vpBottom = screenHeight
        let clipTop = if (vpTop > globalTop) { vpTop } else { globalTop }
        let clipBottom = if (vpBottom < globalBottom) { vpBottom } else { globalBottom }
        let visibleHeight = if (clipBottom > clipTop) { clipBottom - clipTop } else { 0.0 }
        let cellHeight = if (globalBottom > globalTop) { globalBottom - globalTop } else { 0.0 }
        let ratio = if (cellHeight > 0.0) { visibleHeight / cellHeight } else { 0.0 }
        let threshold = MarkdownLinkExposureRegistry.getExposureThreshold()
        if (ratio >= threshold && !tableBlockCellExposureVisible) {
            tableBlockCellExposureVisible = true
            MarkdownLinkExposureRegistry.register(tableBlockCellNodeView.nodeHash, tableBlockCellExposureUrls)
        } else if (ratio < threshold && tableBlockCellExposureVisible) {
            tableBlockCellExposureVisible = false
            MarkdownLinkExposureRegistry.unregister(tableBlockCellNodeView.nodeHash)
        }
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
        .constraintSize(minWidth: currentColumnWidth().vp, maxWidth: tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableMaxCellWidth.vp)
        .onAreaChange({
            old, new =>
                if (old.width == new.width) {
                    return
                }
                if (new.width > 0.0) {
                    cellWidthTracker.updateCellWidth(tableBlockCellRow, tableBlockCellCell, new.width)
                }
        })
    }

    /**
     * 从@Consume columnWidths读取当前列宽度
     * 建立响应式依赖：columnWidths重赋值时触发Cell重渲染
     */
    func currentColumnWidth(): Float64 {
        if (tableBlockCellCell >= 0 && tableBlockCellCell < Int64(columnWidths.size)) {
            return columnWidths[tableBlockCellCell]
        }
        return 0.0
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
        // 链接曝光：Text 的唯一 id
        .id(tableBlockCellId)
        .onVisibleAreaChange(
            [0.0, 0.01, 0.1, 0.25, 0.5, 0.75, 1.0],
            { _: Bool, _: Float64 =>
                if (isExposureEnabled()) {
                    scheduleExposure()
                }
            }
        )
        .onAreaChange({
            old, new =>
                if (isExposureEnabled()) {
                    viewportReady = true
                    scheduleExposure()
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
                    if(spanListNodeView.linkUrl.isSome() && spanListMarkdownConfiguration.isInLineLinkCustom.isSome()
                        && spanListMarkdownConfiguration.isInLineLinkCustom.getOrThrow()(spanListNodeView.linkUrl.getOrThrow())){
                        // 行内链接卡片组件
                        inlineLinkCardComponent(spanListNodeView.linkUrl(), spanListNodeView.linkTitle)
                    }else{
                        // 链接, TOC列表链接
                        spanLinkComponent(
                        spanListNodeView,
                        spanListMarkdownConfiguration,
                        spanListTocListOnClick,
                        spanListFootnoteCallback,
                        false
                        )
                    }
                } else if (spanListNodeView.nodeType == "Image" || spanListNodeView.nodeType == "StyleImage" || spanListNodeView.nodeType == "ImageHtmlNode") {
                    if(spanListNodeView.imageAltText.isSome() && spanListMarkdownConfiguration.isInLineImageCustom.isSome()
                        && spanListMarkdownConfiguration.isInLineImageCustom.getOrThrow()(spanListNodeView.imageAltText.getOrThrow())){
                        inlineImageCardComponent(spanListNodeView.imageAltText,spanListNodeView.imageUrl(), spanListNodeView.imageTitle())
                    }else{
                        spanImageComponent(
                        spanListNodeView,
                        spanListMarkdownConfiguration,
                        spanListComponentWidth,
                        spanListImageCallback
                        )
                    }
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
        return 0.0
    }

    /**
     * 表格底部边框宽度
     */
    func bottomWidths(): Float64 {
        return if (tableBlockCellRow == tableBlockCellRowSize - 1) {
            0.0
        } else {
            tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableBorderWidth
        }
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
