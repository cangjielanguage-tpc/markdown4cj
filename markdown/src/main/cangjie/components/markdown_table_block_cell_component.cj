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
    // onVisibleAreaChange 缓存 ratio + scheduleExposure，evaluateExposure 用 ratio 判定可见性
    var tableBlockCellExposureUrls: ArrayList<String> = ArrayList<String>()
    var tableBlockCellExposureVisible: Bool = false
    var tableBlockCellId: String = "" // Cell Text的唯一id
    var viewportReady: Bool = false // onAreaChange是否触发过
    var isAlive: Bool = true // 组件是否存活
    var exposureScheduled: Bool = false // 曝光评估是否已调度（防抖标志，避免onVisibleAreaChange多次阈值回调每次都spawn协程）
    var lastVisibleRatio: Float64 = 0.0 // onVisibleAreaChange 最近一次回调的可见比例（0=完全不可见，1=完全可见，已考虑所有祖先裁剪）
    var prevTextLength: Int64 = 0 // 上次刷新时的子节点文本总长度（内容缩短检测用）
    @State
    var spanRenderSerial: Int64 = 0 // Span异步资源刷新触发器（触发build重跑后ForEach按节点spanRenderVersion逐项diff，仅数据变化的item重建）

    @BuilderParam
    var blockImageCardComponent: (String, String, String) -> Unit = CustomBlockImageBuilder  //自定义卡片布局块级图片
    @BuilderParam
    var blockLinkCardComponent: (String, String, String) -> Unit = CustomBlockLinkBuilder  //自定义卡片布局行内链接

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
        // 释放span异步资源（链接图标/行内图片/行内公式的PixelMap，含TableCellPart嵌套span）
        releaseTableCellSpanPixelMaps(tableBlockCellNodeViewList)
        MarkdownRefreshRegistry.unregister(tableBlockCellNodeView.nodeHash)
        if (tableBlockCellExposureVisible) {
            MarkdownLinkExposureRegistry.unregister(tableBlockCellNodeView.nodeHash)
            tableBlockCellExposureVisible = false
        }
    }

    /**
     * span异步资源写回后的刷新（重新赋值数据源触发ForEach全量diff，spanRenderVersion仅变化的item重建）
     */
    func onSpanAsyncUpdated(): Unit {
        spanRenderSerial += 1
        let oldList = tableBlockCellNodeViewList
        let newList = ObservedArrayList<NodeView>()
        for (i in 0..oldList.size) {
            newList.append(oldList[i])
        }
        tableBlockCellNodeViewList = newList
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
     * 曝光评估：直接使用 onVisibleAreaChange 缓存的 lastVisibleRatio 判定可见性
     * ratio 已考虑所有祖先裁剪（Scroll/List/屏幕），无需手动用 componentUtils 求交
     */
    func evaluateExposure(): Unit {
        let ratio = lastVisibleRatio
        let threshold = MarkdownLinkExposureRegistry.getExposureThreshold()
        let isVisible = ratio > 0.0 && ratio >= threshold
        if (isVisible && !tableBlockCellExposureVisible) {
            tableBlockCellExposureVisible = true
            MarkdownLinkExposureRegistry.register(tableBlockCellNodeView.nodeHash, tableBlockCellExposureUrls)
        } else if (!isVisible && tableBlockCellExposureVisible) {
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
                    // minWidth=max(columnWidths[col], tableMinCellWidth)，与cell的minWidth约束一致
                    var minWidth = currentColumnWidth()
                    let minCellWidth = tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableMinCellWidth
                    if (minWidth < minCellWidth) {
                        minWidth = minCellWidth
                    }
                    cellWidthTracker.updateCellWidth(tableBlockCellRow, tableBlockCellCell, new.width, minWidth)
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
     * 单元格内容区可用宽度上限 - 单位vp
     * tableMaxCellWidth扣除左右内边距，作为行内图片/数学公式ImageSpan的缩放基准与约束宽度，
     * 防止按外宽渲染时被单元格内边距裁剪；扣除后非正时退回tableMaxCellWidth兜底
     */
    func spanCellContentMaxWidth(): Float64 {
        let tableTheme = tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme
        let contentMaxWidth = tableTheme.tableMaxCellWidth - tableTheme.tableCellPaddingLeft - tableTheme.tableCellPaddingRight
        return if (contentMaxWidth > 0.0) {
            contentMaxWidth
        } else {
            tableTheme.tableMaxCellWidth
        }
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
                                getStrFromOptStr(spanListNodeView.imageAltText),
                                getStrFromOptStr(spanListNodeView.imageUrl),
                                getStrFromOptStr(spanListNodeView.imageTitle)
                            )
                } else if (spanListNodeView.nodeType == "CustomCardLink") {
                              blockLinkCardComponent(
                                spanListNodeView.nodeText,
                                getStrFromOptStr(spanListNodeView.linkUrl),
                                getStrFromOptStr(spanListNodeView.linkTitle)
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
                    // TableCellPart嵌套span写回后聚合版本变化，驱动item重建（CustomCard无children恒为0）
                    "${idx}-${spanListNodeView.nodeHash}-${spanListNodeView.contentHash}-${spanNestedRenderVersion(spanListNodeView)}"
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
            { _: Bool, ratio: Float64 =>
                lastVisibleRatio = ratio
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
                    // 数学公式（单元格最大宽度约束：公式图片超宽时等比缩小，防止溢出单元格）
                    spanLatexMathComponent(
                        spanListNodeView,
                        spanListMarkdownConfiguration,
                        Option<Float64>.Some(spanCellContentMaxWidth()),
                        spanListComponentWidth
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
                        spanListImageCallback,
                        // 图片加载完成后记录imageFallback，防止列宽收缩到图片宽度以下
                        Option<(Float64) -> Unit>.Some({ width: Float64 =>
                            cellWidthTracker.setFallback(tableBlockCellRow, tableBlockCellCell, width)
                        }),
                        // 表格场景：以单元格内容区可用宽度（spanCellContentMaxWidth，与spanLatexMathComponent口径一致）
                        // 为图片宽度计算基准与约束宽度，防止图片宽度超出单元格内容区被裁剪
                        spanCellContentMaxWidth(),
                        onSpanAsyncUpdated
                    )
                } else {
                    tableBlockCellCustomTableLineBuilder(spanListNodeView, index)
                }
            },
            keyGeneratorFunc: {
                spanListNodeView: NodeView, idx: Int64 =>
                    // contentHash变化触发item重建（新节点重新解析），spanRenderVersion变化触发异步资源写回后的重建
                    "${idx}-${spanListNodeView.nodeHash}-${spanListNodeView.contentHash}-${spanListNodeView.spanRenderVersion}"
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
            releaseTableCellSpanPixelMaps(tableBlockCellNodeViewList)
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
                // 图片节点：同URL时保留旧节点的尺寸缓存（对齐ArkUI oldImageSizes保留逻辑）
                carryOverImageSizeCache(oldNode, newNode)
                // 释放旧节点的span异步资源（含TableCellPart嵌套span）
                releaseCellNodeSpanPixelMaps(oldNode)
                tableBlockCellNodeViewList[i] = newNode
            }
        }
        if (refreshNodeViewSize > tableBlockCellNodeViewListSize) {
            for (i in tableBlockCellNodeViewListSize..refreshNodeViewSize) {
                tableBlockCellNodeViewList.append(refreshNodeViewChildren[i])
            }
        } else if (tableBlockCellNodeViewListSize > refreshNodeViewSize) {
            for (i in tableBlockCellNodeViewListSize - 1..=refreshNodeViewSize : -1) {
                // 释放被删节点的span异步资源（含TableCellPart嵌套span）
                releaseCellNodeSpanPixelMaps(tableBlockCellNodeViewList[i])
                tableBlockCellNodeViewList.remove(i)
            }
        }
        // 内容缩短检测：流式输出时原始markdown文本很长，渲染补全后变短。
        // minWidth卡在旧值→onSizeChange不触发→tracker有stale值→列宽不收缩。
        // 比较文本总长度，缩短时清除列宽测量值→cell收缩→onSizeChange→重测→列收缩。
        var totalTextLength: Int64 = 0
        for (item in refreshNodeViewChildren) {
            totalTextLength += Int64(item.nodeText.size)
        }
        if (totalTextLength < prevTextLength) {
            cellWidthTracker.clearCellWidth(tableBlockCellRow, tableBlockCellCell)
        }
        prevTextLength = totalTextLength
        // 数据变更后重算是否走自定义Cell逻辑（含节点增删/类型变化），缓存到@State避免每次build都遍历列表
        let newUseCustomCellLogic = isBlockLogic(tableBlockCellNodeViewList)
        if (newUseCustomCellLogic != useCustomCellLogic) {
            useCustomCellLogic = newUseCustomCellLogic
        }
        // span异步资源（链接图标/行内图片/行内公式）统一由容器发起解析，写回NodeView后通过onSpanAsyncUpdated触发刷新
        // 表格场景传列宽跟踪回调与cellMaxWidth（对齐ArkUI tableMaxCellWidth优先逻辑）
        let imageWidthCallback: ?(Float64) -> Unit = Option<(Float64) -> Unit>.Some({ width: Float64 =>
            // 图片加载完成后记录imageFallback，防止列宽收缩到图片宽度以下
            cellWidthTracker.setFallback(tableBlockCellRow, tableBlockCellCell, width)
        })
        let latexWidthCallback: ?(Float64) -> Unit = Option<(Float64) -> Unit>.Some({ width: Float64 =>
            // LaTeX图片解析完成后：先清除该单元格的列宽记录，再记录imageFallback
            // 防止列宽在旧测量值与图片宽度之间抖动
            cellWidthTracker.clearCellWidth(tableBlockCellRow, tableBlockCellCell)
            cellWidthTracker.setFallback(tableBlockCellRow, tableBlockCellCell, width)
        })
        if (useCustomCellLogic) {
            // 自定义Cell（TableCellPart）：span节点嵌套在TableCellPart的children里
            for (i in 0..tableBlockCellNodeViewList.size) {
                let node = tableBlockCellNodeViewList[i]
                if (node.nodeType == "TableCellPart") {
                    refreshSpanAsyncResources(
                        ObservedArrayList(node.children),
                        tableBlockCellMarkdownConfiguration,
                        tableBlockCellComponentWidth,
                        false,
                        tableBlockCellImageCallback,
                        imageWidthCallback,
                        tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableMaxCellWidth,
                        latexWidthCallback,
                        onSpanAsyncUpdated
                    )
                }
            }
        } else {
            refreshSpanAsyncResources(
                tableBlockCellNodeViewList,
                tableBlockCellMarkdownConfiguration,
                tableBlockCellComponentWidth,
                false,
                tableBlockCellImageCallback,
                imageWidthCallback,
                tableBlockCellMarkdownConfiguration.markdownTheme.tableTheme.tableMaxCellWidth,
                latexWidthCallback,
                onSpanAsyncUpdated
            )
        }
    }
}

/**
 * 计算Cell节点的嵌套span异步资源版本聚合值（TableCellPart场景）
 * 任一嵌套span写回后聚合值变化，驱动外层ForEach item重建（CustomCard无children恒为0）
 */
func spanNestedRenderVersion(cellNode: NodeView): Int64 {
    var version: Int64 = 0
    for (i in 0..cellNode.children.size) {
        version += cellNode.children[i].spanRenderVersion
    }
    return version
}

/**
 * 释放单个Cell节点的span异步资源（链接图标/行内图片/行内公式的PixelMap，含TableCellPart嵌套span）
 */
func releaseCellNodeSpanPixelMaps(cellNode: NodeView): Unit {
    cellNode.releaseSpanPixelMaps()
    if (cellNode.nodeType == "TableCellPart") {
        for (j in 0..cellNode.children.size) {
            cellNode.children[j].releaseSpanPixelMaps()
        }
    }
}

/**
 * 表格Cell场景批量释放span异步资源（链接图标/行内图片/行内公式的PixelMap，含TableCellPart嵌套span）
 */
func releaseTableCellSpanPixelMaps(cellNodes: ObservedArrayList<NodeView>): Unit {
    for (i in 0..cellNodes.size) {
        releaseCellNodeSpanPixelMaps(cellNodes[i])
    }
}
