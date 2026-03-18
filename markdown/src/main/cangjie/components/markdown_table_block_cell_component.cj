/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.state_macro_manage.*

/**
 * 表格Cell控件
 */
@Component
class MarkdownTableBlockCellComponent {
    /**
     * markdown配置
     */
    var tableBlockCellMarkdownConfiguration: MarkdownConfiguration

    /**
     * 表格Cell控件自身节点
     */
    @Prop
    var tableBlockCellNodeView: NodeView

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var tableBlockCellComponentWidth: Float64

    /**
     * 缓存的表格Cell控件数据
     */
    var tableBlockCellComponents: HashMap<Int64, MarkdownTableBlockCellComponent>

    /**
     * 自定义行内表格Cell控件
     */
    @BuilderParam
    var tableBlockCellCustomTableLineBuilder: (NodeView, Int64) -> Unit

    /**
     * 图片点击事件
     */
    var tableBlockCellImageCallback: (String) -> Unit

    /**
     * 脚注点击事件
     */
    var tableBlockCellFootnoteCallback: (String) -> Unit

    /**
     * 表格的第几行
     */
    var tableBlockCellRow: Int64

    /**
     * 表格的第几条
     */
    var tableBlockCellCell: Int64

    /**
     * 表格总共有几列
     */
    var tableBlockCellCellSize: Int64

    /**
     * 表格宽度列表
     */
    @Prop
    @Watch[refreshTextWidth]
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass>

    /**
     * 表格Cell最小宽度
     */
    @State
    var tableBlockCellMinCellWidth: Float64 = 0.0

    /**
     * 表格Cell子节点是否不为0
     */
    @State
    var isRefresh: Bool = false

    /**
     * 列表数据
     */
    @State
    var tableBlockCellNodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

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
    }

    func build() {
        Column() {
            tableBlockCellComponent()
        }
        .alignItems(tableBlockCellNodeView.tableAlignment)
        .justifyContent(FlexAlign.Center)
        .alignSelf(ItemAlign.Stretch)
        .padding(tableBlockCellMarkdownConfiguration.markdownTheme.tableCellPadding)
        .backgroundColor(renderTableCellColor(tableBlockCellNodeView.isTableHead, tableBlockCellMarkdownConfiguration.markdownTheme, tableBlockCellRow))
        .borderWidth(EdgeWidths(left: leftWidths().vp, right: rightWidths().vp, top: topWidths().vp, bottom: bottomWidths().vp))
        .borderStyle(BorderStyle.Solid)
        .borderColor(tableBlockCellMarkdownConfiguration.markdownTheme.tableBorderColor)
        .constraintSize(minWidth: tableBlockCellMinCellWidth.vp, maxWidth: tableBlockCellMarkdownConfiguration.markdownTheme.tableMaxTextWidth.vp)
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
                    tableBlockCellComponentWidth,
                    Option<(Int64) -> Unit>.None,
                    tableBlockCellImageCallback,
                    tableBlockCellFootnoteCallback
                )
            }
        }
        .interopHalfLeading(true)
        .interopCopyOption(if (tableBlockCellMarkdownConfiguration.markdownTheme.isOnCopy) {
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
                    tableBlockCellComponentWidth,
                    Option<(Int64) -> Unit>.None,
                    tableBlockCellImageCallback,
                    tableBlockCellFootnoteCallback
                )
            }
        }
        .halfLeading(true)
        .copyOption(if (tableBlockCellMarkdownConfiguration.markdownTheme.isOnCopy) {
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
                        tableBlockCellCell == 0 && spanListMarkdownConfiguration.markdownTheme.tableFirstColumnBold
                    )
                } else if (spanListNodeView.nodeType == "LatexMathNode") {
                    // 数学公式
                    MarkdownLatexMathInLineComponent(
                        markdownTheme: spanListMarkdownConfiguration.markdownTheme,
                        latexMathInLineStr: spanListNodeView.nodeText,
                        latexMathInLineComponentWidth: spanListComponentWidth,
                        latexImageCallback: spanListMarkdownConfiguration.latexImageCallback,
                        latexStrCallback: spanListMarkdownConfiguration.latexStrCallback,
                        latexMathInLineLinkCallback: spanListMarkdownConfiguration.linkCallback,
                        latexMathInLineIsLink: spanListNodeView.isLink,
                        latexMathInLineLinkUrl: spanListNodeView.linkUrl
                    )
                } else if (spanListNodeView.nodeType == "SoftLineBreak") {
                    // 软换行
                    Span(spanSoftLineBreak(spanListMarkdownConfiguration.markdownTheme.isLineBreak))
                } else if (spanListNodeView.nodeType == "HardLineBreak") {
                    // 硬换行
                    Span("\n")
                } else if (spanListNodeView.nodeType == "Link" || spanListNodeView.nodeType == "HeadLink") {
                    // 链接, TOC列表链接
                    if (spanListNodeView.linkUrl().startsWith("http://") || spanListNodeView.linkUrl().startsWith("https://")) {
                        if (spanListNodeView.nodeText.trimAscii().toRuneArray().size > 1) {
                            MarkdownLinkRectImageComponent(
                                markdownConfiguration: spanListMarkdownConfiguration,
                                strText: spanListNodeView.nodeText.trimAscii(),
                                strUrl: spanListNodeView.linkUrl()
                            )
                        } else if (spanListNodeView.nodeText.trimAscii().toRuneArray().size == 1) {
                            MarkdownLinkCircleImageComponent(
                                markdownConfiguration: spanListMarkdownConfiguration,
                                strText: spanListNodeView.nodeText.trimAscii(),
                                strUrl: spanListNodeView.linkUrl()
                            )
                        }
                    } else {
                        if (spanListNodeView.nodeText.trimAscii().toRuneArray().size >= 1) {
                            MarkdownLinkRectToolImageComponent(
                                markdownConfiguration: spanListMarkdownConfiguration,
                                strText: spanListNodeView.nodeText.trimAscii(),
                                strUrl: spanListNodeView.linkUrl(),
                                strType: urlSafeBase64Decode(spanListNodeView.linkUrl())
                            )
                        }
                    }
                } else if (spanListNodeView.nodeType == "Image" || spanListNodeView.nodeType == "StyleImage" || spanListNodeView.nodeType == "ImageHtmlNode") {
                    // Image：图片节点， StyleImage：图片Style节点，ImageHtmlNode：HTML图片
                    if (spanListMarkdownConfiguration.imageCallbackCallback.isNone()) {
                        // 没有图片替换回调接口
                        if (spanListNodeView.imageUrl().startsWith("./")) {
                            // 本地图片
                            MarkdownSpanImageRawFileComponent(
                                rawFileMarkdownTheme: spanListMarkdownConfiguration.markdownTheme,
                                rawFileDestination: spanListNodeView.imageUrl(),
                                rawFileComponentWidth: spanListComponentWidth,
                                rawFileImageCallback: spanListImageCallback,
                                rawFileLinkCallback: spanListMarkdownConfiguration.linkCallback,
                                rawFileLink: spanListNodeView.isLink,
                                rawFileLinkUrl: spanListNodeView.linkUrl,
                                rawFileImageWidth: spanListNodeView.imageWidth,
                                rawFileImageHeight: spanListNodeView.imageHeight,
                                rawFileImageRadius: spanListNodeView.imageRadius,
                                rawFileImageAlign: spanListNodeView.imageAlign
                            )
                        } else {
                            if (DeviceInfo.sdkApiVersion >= 15) {
                                // API大于等于15
                                MarkdownSpanImageUrl15Component(
                                    url15MarkdownTheme: spanListMarkdownConfiguration.markdownTheme,
                                    url15Destination: spanListNodeView.imageUrl(),
                                    url15ComponentWidth: spanListComponentWidth,
                                    url15ImageCallback: spanListImageCallback,
                                    url15LinkCallback: spanListMarkdownConfiguration.linkCallback,
                                    url15Link: spanListNodeView.isLink,
                                    url15LinkUrl: spanListNodeView.linkUrl,
                                    url15ImageWidth: spanListNodeView.imageWidth,
                                    url15ImageHeight: spanListNodeView.imageHeight,
                                    url15ImageRadius: spanListNodeView.imageRadius,
                                    url15ImageAlign: spanListNodeView.imageAlign
                                )
                            } else {
                                // API小于15
                                MarkdownSpanImageUrl14Component(
                                    url14MarkdownTheme: spanListMarkdownConfiguration.markdownTheme,
                                    url14Destination: spanListNodeView.imageUrl(),
                                    url14ComponentWidth: spanListComponentWidth,
                                    url14ImageCallback: spanListImageCallback,
                                    url14LinkCallback: spanListMarkdownConfiguration.linkCallback,
                                    url14Link: spanListNodeView.isLink,
                                    url14LinkUrl: spanListNodeView.linkUrl,
                                    url14ImageWidth: spanListNodeView.imageWidth,
                                    url14ImageHeight: spanListNodeView.imageHeight,
                                    url14ImageRadius: spanListNodeView.imageRadius,
                                    url14ImageAlign: spanListNodeView.imageAlign
                                )
                            }
                        }
                    } else {
                        // 有图片替换回调接口
                        if (spanListNodeView.imageUrl().startsWith("./")) {
                            // 本地图片
                            MarkdownSpanImageCallbackRawFileComponent(
                                rawFileCallbackMarkdownTheme: spanListMarkdownConfiguration.markdownTheme,
                                rawFileCallbackDestination: spanListNodeView.imageUrl(),
                                rawFileCallbackComponentWidth: spanListComponentWidth,
                                rawFileCallbackImageCallbackCallback: spanListMarkdownConfiguration.imageCallbackCallback(),
                                rawFileCallbackImageCallback: spanListImageCallback,
                                rawFileCallbackLinkCallback: spanListMarkdownConfiguration.linkCallback,
                                rawFileCallbackLink: spanListNodeView.isLink,
                                rawFileCallbackLinkUrl: spanListNodeView.linkUrl,
                                rawFileCallbackImageWidth: spanListNodeView.imageWidth,
                                rawFileCallbackImageHeight: spanListNodeView.imageHeight,
                                rawFileCallbackImageRadius: spanListNodeView.imageRadius,
                                rawFileCallbackImageAlign: spanListNodeView.imageAlign
                            )
                        } else {
                            if (DeviceInfo.sdkApiVersion >= 15) {
                                // API大于等于15
                                MarkdownSpanImageCallbackUrl15Component(
                                    url15CallbackMarkdownTheme: spanListMarkdownConfiguration.markdownTheme,
                                    url15CallbackDestination: spanListNodeView.imageUrl(),
                                    url15CallbackComponentWidth: spanListComponentWidth,
                                    url15CallbackImageCallbackCallback: spanListMarkdownConfiguration.imageCallbackCallback(),
                                    url15CallbackImageCallback: spanListImageCallback,
                                    url15CallbackLinkCallback: spanListMarkdownConfiguration.linkCallback,
                                    url15CallbackLink: spanListNodeView.isLink,
                                    url15CallbackLinkUrl: spanListNodeView.linkUrl,
                                    url15CallbackImageWidth: spanListNodeView.imageWidth,
                                    url15CallbackImageHeight: spanListNodeView.imageHeight,
                                    url15CallbackImageRadius: spanListNodeView.imageRadius,
                                    url15CallbackImageAlign: spanListNodeView.imageAlign
                                )
                            } else {
                                // API小于15
                                MarkdownSpanImageCallbackUrl14Component(
                                    url14CallbackMarkdownTheme: spanListMarkdownConfiguration.markdownTheme,
                                    url14CallbackDestination: spanListNodeView.imageUrl(),
                                    url14CallbackComponentWidth: spanListComponentWidth,
                                    url14CallbackImageCallbackCallback: spanListMarkdownConfiguration.imageCallbackCallback(),
                                    url14CallbackImageCallback: spanListImageCallback,
                                    url14CallbackLinkCallback: spanListMarkdownConfiguration.linkCallback,
                                    url14CallbackLink: spanListNodeView.isLink,
                                    url14CallbackLinkUrl: spanListNodeView.linkUrl,
                                    url14CallbackImageWidth: spanListNodeView.imageWidth,
                                    url14CallbackImageHeight: spanListNodeView.imageHeight,
                                    url14CallbackImageRadius: spanListNodeView.imageRadius,
                                    url14CallbackImageAlign: spanListNodeView.imageAlign
                                )
                            }
                        }
                    }
                } else {
                    // 其他节点
                    tableBlockCellCustomTableLineBuilder(spanListNodeView, index)
                }
            },
            keyGeneratorFunc: {
                spanListNodeView: NodeView, idx: Int64 => return "${idx}-${spanListNodeView.nodeHash}-${spanListNodeView.contentHash}"
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
            tableBlockCellMarkdownConfiguration.markdownTheme.tableBorderWidth
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
            tableBlockCellMarkdownConfiguration.markdownTheme.tableBorderWidth
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
            tableBlockCellMinCellWidth = tableBlockCellMarkdownConfiguration.markdownTheme.tableMinTextWidth
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
            return
        }
        if (refreshNodeViewSize > 0) {
            isRefresh = true
        }
        if (refreshNodeViewSize > tableBlockCellNodeViewListSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            refreshTableBlockCellDatas(tableBlockCellNodeViewListSize, refreshNodeViewChildren)
            // 循环添加新数据
            for (i in tableBlockCellNodeViewListSize..refreshNodeViewSize) {
                tableBlockCellNodeViewList.append(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == tableBlockCellNodeViewListSize) {
            // 新数据等于页面数据
            refreshTableBlockCellDatas(tableBlockCellNodeViewListSize, refreshNodeViewChildren)
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            refreshTableBlockCellDatas(refreshNodeViewSize, refreshNodeViewChildren)
            // 循环删除多余的旧数据
            for (i in tableBlockCellNodeViewListSize - 1..=refreshNodeViewSize : -1) {
                tableBlockCellNodeViewList.remove(i)
            }
        }
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
            let newBlockHash = refreshNodeView.nodeHash
            let oldBlockHash = dataSourceNode.nodeHash
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            // 唯一ID是否相同
            if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                tableBlockCellNodeViewList[i] = refreshNodeView
            } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                tableBlockCellNodeViewList[i] = refreshNodeView
            } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                tableBlockCellNodeViewList[i] = refreshNodeView
            }
        }
    }
}
