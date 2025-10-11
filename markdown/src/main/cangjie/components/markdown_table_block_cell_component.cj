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
     * 表格内容数据
     */
    var nodeViews: ArrayList<NodeView>

    /**
     * 定位需要的数组
     */
    var indexList: ArrayList<Int64> = ArrayList<Int64>()

    /**
     * 长度
     */
    var size: Int64 = -1

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
    var tableCellComponents: ArrayList<MarkdownTableBlockCellComponent>

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
     *
     */
    @State
    var minTextWidth: Float64 = 0.0

    /**
     *
     */
    @State
    var minTextHeight: Float64 = 0.0

    @Link
    @Watch[refreshTextHeight]
    var maxHeight: Float64

    @Prop
    @Watch[refreshTextWidth]
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass>

    func refreshTextWidth(): Unit {
        if (let Some(v) <- cellWidthArrayIndexed.get().get(idxItem)) {
            if (v.index == idxItem && v.minWidth > minTextWidth) {
                minTextWidth = v.minWidth
            }
        } else {
            minTextWidth = markdownConfiguration.markdownTheme.tableMinTextWidth
        }
    }

    func refreshTextHeight(): Unit {
        minTextHeight = maxHeight
    }

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        tableCellComponents.add(this)
        if (let Some(v) <- cellWidthArrayIndexed.get().get(idxItem)) {
            if (v.index == idxItem && v.minWidth > minTextWidth) {
                minTextWidth = v.minWidth
            }
        } else {
            minTextWidth = markdownConfiguration.markdownTheme.tableMinTextWidth
        }
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        tableCellComponents.removeIf({
            predicate => if (predicate.indexList == indexList && predicate.size == size) {
                true
            } else {
                false
            }
        })
    }

    func build() {
        Column() {
            tableBlockCellComponent()
        }
        // 设置 Column 子组件在水平方向上的对齐格式
        .alignItems(renderTableCellColumnAlign(alignment))
        // 设置 Column 子组件在垂直方向上的对齐格式
        .justifyContent(FlexAlign.Center)
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
        .constraintSize(minWidth: minTextWidth.vp, maxWidth: markdownConfiguration.markdownTheme.tableMaxTextWidth.vp, minHeight: minTextHeight.vp)
        // 组件区域变化时触发该回调
        .onAreaChange(
            {
                old, new =>
                    let newHeight: Float64 = new.height
                    if (maxHeight < newHeight) {
                        maxHeight = newHeight
                    } else {
                        maxHeight = minTextHeight
                    }
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

    /**
     * 表格文字内容
     */
    @Builder
    func tableBlockCellComponent18() {
        Text() {
            ForEach(
                nodeViewList,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        tableComponentText(
                            item,
                            isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold),
                            markdownConfiguration
                        )
                    } else if (item.node is Footnote) {
                        // 脚注
                        tableComponentFootnote(
                            item,
                            isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold),
                            markdownConfiguration,
                            fontCallback
                        )
                    } else if (item.node is Code) {
                        // 内联代码
                        if (markdownConfiguration.markdownTheme.isCodeStyle) {
                            MarkdownCodeLineImageSpanComponent(
                                markdownConfiguration: markdownConfiguration,
                                strCode: (item.node as Code)().getLiteral(),
                                strUrl: linkUrl(item),
                                maxWidth: (markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp,
                                isFakeBoldText: isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold) || item.strongEmphasis
                            )
                        } else {
                            tableComponentCode(
                                item,
                                isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold),
                                markdownConfiguration
                            )
                        }
                    } else if (item.node is HardLineBreak) {
                        // 硬换行
                        Span("\n")
                    } else if (item.node is SoftLineBreak) {
                        // 软换行
                        Span(spanSoftLineBreak(markdownConfiguration.markdownTheme.isLineBreak))
                    } else if (item.node is CommonmarkLink) {
                        // 链接
                        if (!markdownConfiguration.markdownTheme.isLinkStyle) {
                            if (getLinkString(item).isSome()) {
                                tableLinkComponent(
                                    item,
                                    isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold),
                                    getLinkString(item)(),
                                    markdownConfiguration
                                )
                            } else {
                                Span("")
                            }
                        } else {
                            if ((item.node as CommonmarkLink)().getDestination().startsWith("http://") || (item.node as CommonmarkLink)().getDestination().startsWith("https://")) {
                                if (getLinkString(item).isSome()) {
                                    if (getLinkString(item)().trimAscii().toRuneArray().size > 1) {
                                        MarkdownLinkRectImageComponent(
                                            markdownConfiguration: markdownConfiguration,
                                            strText: getLinkString(item)().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: renderTableCellColor(isHeader, markdownConfiguration.markdownTheme, idRow),
                                            maxWidth: (markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp
                                        )
                                    } else {
                                        MarkdownLinkCircleImageComponent(
                                            markdownConfiguration: markdownConfiguration,
                                            strText: getLinkString(item)().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: renderTableCellColor(isHeader, markdownConfiguration.markdownTheme, idRow),
                                            maxWidth: (markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp
                                        )
                                    }
                                } else {
                                    Span("")
                                }
                            } else {
                                if (getLinkString(item).isSome()) {
                                    MarkdownLinkRectToolImageComponent(
                                        markdownConfiguration: markdownConfiguration,
                                        strText: getLinkString(item)(),
                                        strUrl: (item.node as CommonmarkLink)().getDestination(),
                                        strType: urlSafeBase64Decode((item.node as CommonmarkLink)().getDestination()),
                                        backGroupColor: renderTableCellColor(isHeader, markdownConfiguration.markdownTheme, idRow),
                                        maxWidth: (markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp
                                    )
                                } else {
                                    Span("")
                                }
                            }
                        }
                    } else if (item.node is CommonmarkImage) {
                        // 图片节点
                        if (markdownConfiguration.imageCallbackCallback.isNone()) {
                            if (DeviceInfo.sdkApiVersion >= 15) {
                                MarkdownImageSpanComponent(
                                    destination: (item.node as CommonmarkImage)().getDestination(),
                                    imagePlaceholder: markdownConfiguration.markdownTheme.imagePlaceholder,
                                    componentWidth: vp2px((markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp).getOrThrow().value,
                                    imageMarginTop: 0.0,
                                    imageMarginBottom: 0.0,
                                    imageCallback: imageCallback,
                                    linkCallback: markdownConfiguration.linkCallback,
                                    isLink: item.link.isSome(),
                                    linkUrl: if (item.link.isSome()) { item.link().getDestination() } else { Option<String>.None },
                                    imageBorderRadius: markdownConfiguration.markdownTheme.imageBorderRadius
                                )
                            } else {
                                MarkdownImageSpan15Component(
                                    destination: (item.node as CommonmarkImage)().getDestination(),
                                    imagePlaceholder: markdownConfiguration.markdownTheme.imagePlaceholder,
                                    componentWidth: vp2px((markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp).getOrThrow().value,
                                    imageMarginTop: 0.0,
                                    imageMarginBottom: 0.0,
                                    imageCallback: imageCallback,
                                    linkCallback: markdownConfiguration.linkCallback,
                                    isLink: item.link.isSome(),
                                    linkUrl: if (item.link.isSome()) { item.link().getDestination() } else { Option<String>.None },
                                    imageBorderRadius: markdownConfiguration.markdownTheme.imageBorderRadius
                                )
                            }
                        } else {
                            MarkdownImagePixelmapSpanComponent(
                                destination: (item.node as CommonmarkImage)().getDestination(),
                                imagePlaceholder: markdownConfiguration.markdownTheme.imagePlaceholder,
                                componentWidth: vp2px((markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp).getOrThrow().value,
                                imageMarginTop: 0.0,
                                imageMarginBottom: 0.0,
                                imageCallback: imageCallback,
                                linkCallback: markdownConfiguration.linkCallback,
                                isLink: item.link.isSome(),
                                linkUrl: if (item.link.isSome()) { item.link().getDestination() } else { Option<String>.None },
                                imageCallbackCallback: markdownConfiguration.imageCallbackCallback(),
                                imageBorderRadius: markdownConfiguration.markdownTheme.imageBorderRadius
                            )
                        }
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        MarkdownLatexImageSpanComponent(
                            markdownConfiguration: markdownConfiguration,
                            componentWidth: componentWidth,
                            strLatexMath: (item.node as LatexMathNode)().latex,
                            backGroupColor: renderTableCellColor(isHeader, markdownConfiguration.markdownTheme, idRow),
                            maxWidth: (markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp,
                            linkCallback: markdownConfiguration.linkCallback,
                            isLink: item.link.isSome(),
                            linkUrl: if (item.link.isSome()) { item.link().getDestination() } else { Option<String>.None }
                        )
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                },
                keyGeneratorFunc: {
                    item: NodeView, idx: Int64 => return "${idx}-${getProp<Int64>(item, "nodeid", 0)}"
                }
            )
        }
        // 设置行高
        .lineHeight(markdownConfiguration.markdownTheme.tableTextLineHeight)
        // 自定义设置组件是否支持文本可复制粘贴
        .interopCopyOption(if (markdownConfiguration.markdownTheme.isOnCopy) { true } else { false })
        // 自定义长按文本内部区域弹出剪贴板后，点击剪切板复制按钮，触发该事件
        .interopOnCopy({
            str => if (markdownConfiguration.textCopyCallback.isSome()) {
                markdownConfiguration.textCopyCallback()(str)
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
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        tableComponentText(
                            item,
                            isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold),
                            markdownConfiguration
                        )
                    } else if (item.node is Footnote) {
                        // 脚注
                        tableComponentFootnote(
                            item,
                            isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold),
                            markdownConfiguration,
                            fontCallback
                        )
                    } else if (item.node is Code) {
                        // 内联代码
                        if (markdownConfiguration.markdownTheme.isCodeStyle) {
                            MarkdownCodeLineImageSpanComponent(
                                markdownConfiguration: markdownConfiguration,
                                strCode: (item.node as Code)().getLiteral(),
                                strUrl: linkUrl(item),
                                maxWidth: (markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp,
                                isFakeBoldText: isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold) || item.strongEmphasis
                            )
                        } else {
                            tableComponentCode(
                                item,
                                isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold),
                                markdownConfiguration
                            )
                        }
                    } else if (item.node is HardLineBreak) {
                        // 硬换行
                        Span("\n")
                    } else if (item.node is SoftLineBreak) {
                        // 软换行
                        Span(spanSoftLineBreak(markdownConfiguration.markdownTheme.isLineBreak))
                    } else if (item.node is CommonmarkLink) {
                        // 链接
                        if (!markdownConfiguration.markdownTheme.isLinkStyle) {
                            if (getLinkString(item).isSome()) {
                                tableLinkComponent(
                                    item,
                                    isHeader || (idxItem == 0 && markdownConfiguration.markdownTheme.tableFirstColumnBold),
                                    getLinkString(item)(),
                                    markdownConfiguration
                                )
                            } else {
                                Span("")
                            }
                        } else {
                            if ((item.node as CommonmarkLink)().getDestination().startsWith("http://") || (item.node as CommonmarkLink)().getDestination().startsWith("https://")) {
                                if (getLinkString(item).isSome()) {
                                    if (getLinkString(item)().trimAscii().toRuneArray().size > 1) {
                                        MarkdownLinkRectImageComponent(
                                            markdownConfiguration: markdownConfiguration,
                                            strText: getLinkString(item)().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: renderTableCellColor(isHeader, markdownConfiguration.markdownTheme, idRow),
                                            maxWidth: (markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp
                                        )
                                    } else {
                                        MarkdownLinkCircleImageComponent(
                                            markdownConfiguration: markdownConfiguration,
                                            strText: getLinkString(item)().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: renderTableCellColor(isHeader, markdownConfiguration.markdownTheme, idRow),
                                            maxWidth: (markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp
                                        )
                                    }
                                } else {
                                    Span("")
                                }
                            } else {
                                if (getLinkString(item).isSome()) {
                                    MarkdownLinkRectToolImageComponent(
                                        markdownConfiguration: markdownConfiguration,
                                        strText: getLinkString(item)(),
                                        strUrl: (item.node as CommonmarkLink)().getDestination(),
                                        strType: urlSafeBase64Decode((item.node as CommonmarkLink)().getDestination()),
                                        backGroupColor: renderTableCellColor(isHeader, markdownConfiguration.markdownTheme, idRow),
                                        maxWidth: (markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp
                                    )
                                } else {
                                    Span("")
                                }
                            }
                        }
                    } else if (item.node is CommonmarkImage) {
                        // 图片节点
                        if (markdownConfiguration.imageCallbackCallback.isNone()) {
                            MarkdownImageSpanComponent(
                                destination: (item.node as CommonmarkImage)().getDestination(),
                                imagePlaceholder: markdownConfiguration.markdownTheme.imagePlaceholder,
                                componentWidth: vp2px((markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp).getOrThrow().value,
                                imageMarginTop: 0.0,
                                imageMarginBottom: 0.0,
                                imageCallback: imageCallback,
                                linkCallback: markdownConfiguration.linkCallback,
                                isLink: item.link.isSome(),
                                linkUrl: if (item.link.isSome()) { item.link().getDestination() } else { Option<String>.None },
                                imageBorderRadius: markdownConfiguration.markdownTheme.imageBorderRadius
                            )
                        } else {
                            MarkdownImagePixelmapSpanComponent(
                                destination: (item.node as CommonmarkImage)().getDestination(),
                                imagePlaceholder: markdownConfiguration.markdownTheme.imagePlaceholder,
                                componentWidth: vp2px((markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp).getOrThrow().value,
                                imageMarginTop: 0.0,
                                imageMarginBottom: 0.0,
                                imageCallback: imageCallback,
                                linkCallback: markdownConfiguration.linkCallback,
                                isLink: item.link.isSome(),
                                linkUrl: if (item.link.isSome()) { item.link().getDestination() } else { Option<String>.None },
                                imageCallbackCallback: markdownConfiguration.imageCallbackCallback(),
                                imageBorderRadius: markdownConfiguration.markdownTheme.imageBorderRadius
                            )
                        }
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        MarkdownLatexImageSpanComponent(
                            markdownConfiguration: markdownConfiguration,
                            componentWidth: componentWidth,
                            strLatexMath: (item.node as LatexMathNode)().latex,
                            backGroupColor: renderTableCellColor(isHeader, markdownConfiguration.markdownTheme, idRow),
                            maxWidth: (markdownConfiguration.markdownTheme.tableMaxTextWidth - 2.0 * markdownConfiguration.markdownTheme.tableCellPadding - 2.0 * markdownConfiguration.markdownTheme.tableBorderWidth).vp,
                            linkCallback: markdownConfiguration.linkCallback,
                            isLink: item.link.isSome(),
                            linkUrl: if (item.link.isSome()) { item.link().getDestination() } else { Option<String>.None }
                        )
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                },
                keyGeneratorFunc: {
                    item: NodeView, idx: Int64 => return "${idx}-${getProp<Int64>(item, "nodeid", 0)}"
                }
            )
        }
        // 设置行高
        .lineHeight(markdownConfiguration.markdownTheme.tableTextLineHeight)
        // 支持设备内复制
        .copyOption(if (markdownConfiguration.markdownTheme.isOnCopy) { CopyOptions.LocalDevice } else { CopyOptions.None })
        // 长按文本内部区域弹出剪贴板后，点击剪切板复制按钮，触发该事件。目前文本复制仅支持文本。
        .onCopy({
            str => if (markdownConfiguration.textCopyCallback.isSome()) {
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

    /**
     * 数据刷新
     */
    public func refreshData(refreshNodeViews: ArrayList<NodeView>): Unit {
        let refreshNodeViewSize: Int64 = refreshNodeViews.size // 刷新进来的数据长度
        let nodeViewListSize: Int64 = nodeViewList.size // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > nodeViewListSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..nodeViewListSize) {
                if (getProp<Int64>(refreshNodeViews[i], "nodeid", 0) != getProp<Int64>(nodeViewList[i], "nodeid", 0)) {
                    nodeViewList[i] = refreshNodeViews[i]
                }
            }
            // 循环添加新数据
            for (i in nodeViewListSize..refreshNodeViewSize) {
                nodeViewList.append(refreshNodeViews[i])
            }
        } else if (refreshNodeViewSize == nodeViewListSize) {
            // 新数据等于页面数据
            for (i in 0..nodeViewListSize) {
                if (getProp<Int64>(refreshNodeViews[i], "nodeid", 0) != getProp<Int64>(nodeViewList[i], "nodeid", 0)) {
                    nodeViewList[i] = refreshNodeViews[i]
                }
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..refreshNodeViewSize) {
                if (getProp<Int64>(refreshNodeViews[i], "nodeid", 0) != getProp<Int64>(nodeViewList[i], "nodeid", 0)) {
                    nodeViewList[i] = refreshNodeViews[i]
                }
            }
            // 循环删除多余的旧数据
            for (i in nodeViewListSize - 1..=refreshNodeViewSize : -1) {
                nodeViewList.remove(i)
            }
        }
        size = nodeViewList.size // 更新列表长度
    }

    func leftWidths(): Float64 {
        return if (idxItem == 0) {
            0.0
        } else {
            markdownConfiguration.markdownTheme.tableBorderWidth / 2.0
        }
    }

    func rightWidths(): Float64 {
        return if (idxItem == dataCellSize - 1) {
            0.0
        } else {
            markdownConfiguration.markdownTheme.tableBorderWidth / 2.0
        }
    }

    func topWidths(): Float64 {
        return if (idRow == 0) {
            0.0
        } else {
            markdownConfiguration.markdownTheme.tableBorderWidth / 2.0
        }
    }

    func bottomWidths(): Float64 {
        return if (idRow == dataRowSize - 1) {
            0.0
        } else {
            markdownConfiguration.markdownTheme.tableBorderWidth / 2.0
        }
    }
}

@Observed
class CellWidthArrayIndexedClass {
    @Publish
    var minWidth: Float64 = 0.0
    @Publish
    var index: Int64 = -1
}
