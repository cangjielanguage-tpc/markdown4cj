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
    @State
    var useCustomCellLogic: Bool = false // 缓存：是否使用自定义Cell逻辑（TableCellPart/CustomCardImage/CustomCardLink），refreshTableBlockCellData时重算
    @State
    var cellHasExposure: Bool = false // 缓存：是否启用链接曝光统计（构建时决定，避免600个cell都注册onVisibleAreaChange/onAreaChange/id）
    // 链接曝光：URL列表缓存 + 当前可见状态（与MarkdownParagraphComponent同款）
    // 简化版：Text级别曝光，与屏幕 [0, screenH] 求交判定可见性
    var tableBlockCellExposureUrls: ArrayList<String> = ArrayList<String>()
    var tableBlockCellExposureVisible: Bool = false
    var tableBlockCellId: String = "" // Cell Text的唯一id
    var viewportReady: Bool = false // onAreaChange是否触发过
    var isAlive: Bool = true // 组件是否存活
    var exposureScheduled: Bool = false // 曝光评估是否已调度（防抖标志，避免onVisibleAreaChange多次阈值回调每次都spawn协程）

    @BuilderParam
    var blockImageCardComponent: (?String, ?String, ?String) -> Unit = CustomBlockImageBuilder  //自定义卡片布局块级图片
    @BuilderParam
    var blockLinkCardComponent: (?String, ?String, ?String) -> Unit = CustomBlockLinkBuilder  //自定义卡片布局行内链接

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(tableBlockCellNodeView.nodeHash, refreshTableBlockCellData)
        // 构建时一次性决定是否注册曝光相关回调（registry在MarkdownComponent.aboutToAppear已设置，子组件aboutToAppear时一定可见）
        // 默认未设置elementExposureCallback → cellHasExposure=false → 600个cell完全跳过id/onVisibleAreaChange/onAreaChange注册
        cellHasExposure = MarkdownLinkExposureRegistry.isExposureEnabled()
        refreshTableBlockCellData(tableBlockCellNodeView)
        // Cell Text的唯一id
        tableBlockCellId = "md-exp-${tableBlockCellNodeView.nodeHash}"
        // 链接曝光：仅提取URL列表缓存
        if (cellHasExposure) {
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
     * 优化：用exposureScheduled标志位避免在onVisibleAreaChange的7个阈值回调里各spawn一个协程，
     * 一帧内多次触发只调度一次评估（与段落组件语义一致：合并连续触发）
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
        if (exposureScheduled) {
            return
        }
        exposureScheduled = true
        spawn {
            sleep(Duration.millisecond * 16)
            launch {
                exposureScheduled = false
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

    //判断节点里有没有TableCellPart或者CustomCardImage或者CustomCardLink 如果没有走原来逻辑
    func isBlockLogic(nodeViewList: ObservedArrayList<NodeView>):Bool{
        for(i in nodeViewList.get()){
            if(i.nodeType == "TableCellPart" || i.nodeType == "CustomCardImage" || i.nodeType == "CustomCardLink"){
                return true
            }
        }
        return false
    }


    func build() {
        Column() {
            if(useCustomCellLogic){
                tableBlockCellCustomComponent()
            }else{
                tableBlockCellComponent()
            }
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
        .interopOnSizeChange({
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
     * 表格自定义内容
     */
    @Builder
    func tableBlockCellCustomComponent() {
            ForEach(
            tableBlockCellNodeViewList,
            itemGeneratorFunc: {
                spanListNodeView: NodeView, index: Int64 => if (spanListNodeView.nodeType == "CustomCardImage") {
                     // 自定义卡片图片
                            blockImageCardComponent(
                                spanListNodeView.imageAltText,
                                spanListNodeView.imageUrl,
                                spanListNodeView.imageTitle,
                            )
                } else if (spanListNodeView.nodeType == "CustomCardLink") {
                              blockLinkCardComponent(
                                spanListNodeView.nodeText,
                                spanListNodeView.linkUrl,
                                spanListNodeView.linkTitle

                            )
                } else if (spanListNodeView.nodeType == "TableCellPart") {
                            Text() {
                                if (isRefresh) {
                                    markdownSpanListComponent(
                                        ObservedArrayList(spanListNodeView.children),
                                        tableBlockCellMarkdownConfiguration,
                                        tableBlockCellComponentWidth,
                                        Option<(Int64) -> Unit>.None,
                                        tableBlockCellImageCallback,
                                        tableBlockCellFootnoteCallback
                                    )
                                }
                            }
                }
            },
            keyGeneratorFunc: {
                spanListNodeView: NodeView, idx: Int64 =>
                   return "${idx}-${spanListNodeView.nodeHash}-${spanListNodeView.contentHash}"
            }
        )
    }

    /**
     * 表格文字内容
     * 根据 cellHasExposure 选择是否注册曝光相关回调（id/onVisibleAreaChange/onAreaChange）。
     * 默认未设置 elementExposureCallback 时 cellHasExposure=false，跳过600个cell的
     * id注册 + 7阈值 × 600 = 4200 次阈值追踪 + 600次area change追踪，显著降低首屏开销。
     */
    @Builder
    func tableBlockCellComponent() {
        if (cellHasExposure) {
            tableBlockCellComponentWithExposure()
        } else {
            tableBlockCellComponentPlain()
        }
    }

    /**
     * 无曝光统计的Cell Text：仅基础属性，不注册id/onVisibleAreaChange/onAreaChange
     */
    @Builder
    func tableBlockCellComponentPlain() {
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
     * 启用曝光统计的Cell Text：在Plain基础上额外注册id/onVisibleAreaChange/onAreaChange
     */
    @Builder
    func tableBlockCellComponentWithExposure() {
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
                scheduleExposure()
            }
        )
        .onAreaChange({
            old, new =>
                viewportReady = true
                scheduleExposure()
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
                        // 链接, TOC列表链接
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
            useCustomCellLogic = false
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
        // 数据变更后重算是否走自定义Cell逻辑（含节点增删/类型变化），缓存到@State避免每次build都遍历列表
        let newUseCustomCellLogic = isBlockLogic(tableBlockCellNodeViewList)
        if (newUseCustomCellLogic != useCustomCellLogic) {
            useCustomCellLogic = newUseCustomCellLogic
        }
    }
}
