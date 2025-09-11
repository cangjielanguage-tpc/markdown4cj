/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.hilog.Hilog

/**
 * Markdown表格自定义控件
 */
@Component
class MarkdownAITableBlockCellComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

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
     * 是否全量加载
     */
    var isFull: Bool

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
    var tableCellComponents: ArrayList<MarkdownAITableBlockCellComponent>

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

    @Prop
    @Watch[refreshTextWidth]
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass>

    func refreshTextWidth(): Unit {
        if (let Some(v) <- cellWidthArrayIndexed.get().get(idxItem)) {
            if (v.index == idxItem && v.minWidth > minTextWidth) {
                minTextWidth = v.minWidth
            }
        } else {
            minTextWidth = markdownAIConfiguration.markdownAITheme.tableMinTextWidth
        }
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
            minTextWidth = markdownAIConfiguration.markdownAITheme.tableMinTextWidth
        }
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        tableCellComponents.removeIf(
            {
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
        // 覆盖 Flex 布局容器中 alignItems 默认配置
        .alignSelf(ItemAlign.Stretch)
        // 设置内边距属性
        .padding(markdownAIConfiguration.markdownAITheme.tableCellPadding)
        // 设置组件的背景色
        .backgroundColor(renderTableCellColor(isHeader, markdownAIConfiguration.markdownAITheme, idRow))
        // 设置边框的宽度
        .borderWidth(EdgeWidths(left: leftWidths().vp, right: rightWidths().vp, top: topWidths().vp, bottom: bottomWidths().vp))
        // 设置元素的边框样式
        .borderStyle(BorderStyle.Solid)
        // 设置边框的颜色
        .borderColor(markdownAIConfiguration.markdownAITheme.tableBorderColor)
        // 设置约束尺寸，组件布局时，进行尺寸范围限制
        .constraintSize(minWidth: minTextWidth.vp, maxWidth: markdownAIConfiguration.markdownAITheme.tableMaxTextWidth.vp)
        // 组件区域变化时触发该回调
        .onAreaChange(
            {
                old, new =>
                if (old.width == new.width) {
                    return
                }
                let oldWidth: Float64 = old.width
                let newWidth: Float64 = new.width
                let max: Float64 = if (newWidth > oldWidth) {
                    newWidth
                } else {
                    oldWidth
                }
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
                            isHeader || (idxItem == 0 && markdownAIConfiguration.markdownAITheme.tableFirstColumnBold),
                            markdownAIConfiguration
                        )
                    } else if (item.node is Footnote) {
                        // 脚注
                        tableComponentFootnote(
                            item,
                            isHeader || (idxItem == 0 && markdownAIConfiguration.markdownAITheme.tableFirstColumnBold),
                            markdownAIConfiguration,
                            fontCallback
                        )
                    } else if (item.node is Code) {
                        // 内联代码
                        if (markdownAIConfiguration.markdownAITheme.isCodeStyle) {
                            MarkdownAICodeLineImageSpanComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                strCode: (item.node as Code)().getLiteral(),
                                strUrl: linkUrl(item),
                                maxWidth: (markdownAIConfiguration.markdownAITheme.tableMaxTextWidth - 2.0 * markdownAIConfiguration.markdownAITheme.tableCellPadding - 2.0 * markdownAIConfiguration.markdownAITheme.tableBorderWidth).vp,
                                isFakeBoldText: isHeader || (idxItem == 0 && markdownAIConfiguration.markdownAITheme.tableFirstColumnBold) || item.strongEmphasis
                            )
                        } else {
                            tableComponentCode(
                                item,
                                isHeader || (idxItem == 0 && markdownAIConfiguration.markdownAITheme.tableFirstColumnBold),
                                markdownAIConfiguration
                            )
                        }
                    } else if (item.node is HardLineBreak) {
                        // 硬换行
                        Span("\n")
                    } else if (item.node is SoftLineBreak) {
                        // 软换行
                        Span(spanSoftLineBreak(markdownAIConfiguration.markdownAITheme.isLineBreak))
                    } else if (item.node is CommonmarkLink) {
                        // 链接
                        if (!markdownAIConfiguration.markdownAITheme.isListLinkStyle) {
                            if(getLinkString(item).isSome()){
                                tableLinkComponent(
                                    item,
                                    isHeader || (idxItem == 0 && markdownAIConfiguration.markdownAITheme.tableFirstColumnBold),
                                    getLinkString(item)(),
                                    markdownAIConfiguration
                                )
                            }else{
                                Span("")
                            }
                        } else {
                            if ((item.node as CommonmarkLink)().getDestination().startsWith("http://") || (item.node as CommonmarkLink)().getDestination().startsWith("https://")) {
                                if (item.node.getFirstChild().isSome() && item.node.getFirstChild()() is CommonmarkText) {
                                    if ((item.node.getFirstChild()() as CommonmarkText)().getLiteral().trimAscii().toRuneArray().size > 1) {
                                        MarkdownAILinkRectImageComponent(
                                            markdownAIConfiguration: markdownAIConfiguration,
                                            strText: (item.node.getFirstChild()() as CommonmarkText)().getLiteral().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: renderTableCellColor(isHeader, markdownAIConfiguration.markdownAITheme, idRow),
                                            maxWidth: (markdownAIConfiguration.markdownAITheme.tableMaxTextWidth - 2.0 * markdownAIConfiguration.markdownAITheme.tableCellPadding - 2.0 * markdownAIConfiguration.markdownAITheme.tableBorderWidth).vp
                                        )
                                    } else {
                                        MarkdownAILinkCircleImageComponent(
                                            markdownAIConfiguration: markdownAIConfiguration,
                                            strText: (item.node.getFirstChild()() as CommonmarkText)().getLiteral().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: renderTableCellColor(isHeader,markdownAIConfiguration.markdownAITheme, idRow),
                                            maxWidth: (markdownAIConfiguration.markdownAITheme.tableMaxTextWidth - 2.0 * markdownAIConfiguration.markdownAITheme.tableCellPadding - 2.0 * markdownAIConfiguration.markdownAITheme.tableBorderWidth).vp
                                        )
                                    }
                                }
                            } else {
                                if (item.node.getFirstChild().isSome() && item.node.getFirstChild()() is CommonmarkText) {
                                    MarkdownAILinkRectToolImageComponent(
                                        markdownAIConfiguration: markdownAIConfiguration,
                                        strText: (item.node.getFirstChild()() as CommonmarkText)().getLiteral(),
                                        strUrl: (item.node as CommonmarkLink)().getDestination(),
                                        strType: urlSafeBase64Decode((item.node as CommonmarkLink)().getDestination()),
                                        backGroupColor: renderTableCellColor(isHeader, markdownAIConfiguration.markdownAITheme, idRow),
                                        maxWidth: (markdownAIConfiguration.markdownAITheme.tableMaxTextWidth - 2.0 * markdownAIConfiguration.markdownAITheme.tableCellPadding - 2.0 * markdownAIConfiguration.markdownAITheme.tableBorderWidth).vp
                                    )
                                }
                            }
                        }
                    } else if (item.node is CommonmarkImage) {
                        // 图片节点
                        MarkdownAIImagePixelmapSpanComponent(
                            destination: (item.node as CommonmarkImage)().getDestination(),
                            imagePlaceholder: markdownAIConfiguration.markdownAITheme.imagePlaceholder,
                            componentWidth: (markdownAIConfiguration.markdownAITheme.tableMaxTextWidth - 2.0 * markdownAIConfiguration.markdownAITheme.tableCellPadding - 2.0 * markdownAIConfiguration.markdownAITheme.tableBorderWidth),
                            imageMarginTop: 0.0,
                            imageMarginBottom: 0.0,
                            imageCallback: imageCallback,
                            linkCallback: markdownAIConfiguration.linkCallback,
                            isLink: item.link.isSome(),
                            linkUrl: if (item.link.isSome()) {item.link().getDestination()} else {Option<String>.None},
                            imageCallbackCallback : markdownAIConfiguration.imageCallbackCallback
                        )
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        MarkdownAILatexImageSpanComponent(
                            markdownAIConfiguration: markdownAIConfiguration,
                            componentWidth: componentWidth,
                            strLatexMath: (item.node as LatexMathNode)().latex,
                            backGroupColor: renderTableCellColor(isHeader, markdownAIConfiguration.markdownAITheme, idRow),
                            maxWidth: (markdownAIConfiguration.markdownAITheme.tableMaxTextWidth - 2.0 * markdownAIConfiguration.markdownAITheme.tableCellPadding - 2.0 * markdownAIConfiguration.markdownAITheme.tableBorderWidth).vp
                        )
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                }
            )
        }
        // 设置行高
        .lineHeight(markdownAIConfiguration.markdownAITheme.tableTextLineHeight)
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
                            isHeader || (idxItem == 0 && markdownAIConfiguration.markdownAITheme.tableFirstColumnBold),
                            markdownAIConfiguration
                        )
                    } else if (item.node is Footnote) {
                        // 脚注
                        tableComponentFootnote(
                            item,
                            isHeader || (idxItem == 0 && markdownAIConfiguration.markdownAITheme.tableFirstColumnBold),
                            markdownAIConfiguration,
                            fontCallback
                        )
                    } else if (item.node is Code) {
                        // 内联代码
                        if (markdownAIConfiguration.markdownAITheme.isCodeStyle) {
                            MarkdownAICodeLineImageSpanComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                strCode: (item.node as Code)().getLiteral(),
                                strUrl: linkUrl(item),
                                maxWidth: (markdownAIConfiguration.markdownAITheme.tableMaxTextWidth - 2.0 * markdownAIConfiguration.markdownAITheme.tableCellPadding - 2.0 * markdownAIConfiguration.markdownAITheme.tableBorderWidth).vp,
                                isFakeBoldText: isHeader || (idxItem == 0 && markdownAIConfiguration.markdownAITheme.tableFirstColumnBold) || item.strongEmphasis
                            )
                        } else {
                            tableComponentCode(
                                item,
                                isHeader || (idxItem == 0 && markdownAIConfiguration.markdownAITheme.tableFirstColumnBold),
                                markdownAIConfiguration
                            )
                        }
                    } else if (item.node is HardLineBreak) {
                        // 硬换行
                        Span("\n")
                    } else if (item.node is SoftLineBreak) {
                        // 软换行
                        Span(spanSoftLineBreak(markdownAIConfiguration.markdownAITheme.isLineBreak))
                    } else if (item.node is CommonmarkLink) {
                        // 链接
                        if (!markdownAIConfiguration.markdownAITheme.isListLinkStyle) {
                            if(getLinkString(item).isSome()){
                                tableLinkComponent(
                                    item,
                                    isHeader || (idxItem == 0 && markdownAIConfiguration.markdownAITheme.tableFirstColumnBold),
                                    getLinkString(item)(),
                                    markdownAIConfiguration
                                )
                            }else{
                                Span("")
                            }
                        } else {
                            if ((item.node as CommonmarkLink)().getDestination().startsWith("http://") || (item.node as CommonmarkLink)().getDestination().startsWith("https://")) {
                                if (item.node.getFirstChild().isSome() && item.node.getFirstChild()() is CommonmarkText) {
                                    if ((item.node.getFirstChild()() as CommonmarkText)().getLiteral().trimAscii().toRuneArray().size > 1) {
                                        MarkdownAILinkRectImageComponent(
                                            markdownAIConfiguration: markdownAIConfiguration,
                                            strText: (item.node.getFirstChild()() as CommonmarkText)().getLiteral().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: renderTableCellColor(isHeader, markdownAIConfiguration.markdownAITheme, idRow),
                                            maxWidth: (markdownAIConfiguration.markdownAITheme.tableMaxTextWidth - 2.0 * markdownAIConfiguration.markdownAITheme.tableCellPadding - 2.0 * markdownAIConfiguration.markdownAITheme.tableBorderWidth).vp
                                        )
                                    } else {
                                        MarkdownAILinkCircleImageComponent(
                                            markdownAIConfiguration: markdownAIConfiguration,
                                            strText: (item.node.getFirstChild()() as CommonmarkText)().getLiteral().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: renderTableCellColor(isHeader,markdownAIConfiguration.markdownAITheme, idRow),
                                            maxWidth: (markdownAIConfiguration.markdownAITheme.tableMaxTextWidth - 2.0 * markdownAIConfiguration.markdownAITheme.tableCellPadding - 2.0 * markdownAIConfiguration.markdownAITheme.tableBorderWidth).vp
                                        )
                                    }
                                }
                            } else {
                                if (item.node.getFirstChild().isSome() && item.node.getFirstChild()() is CommonmarkText) {
                                    MarkdownAILinkRectToolImageComponent(
                                        markdownAIConfiguration: markdownAIConfiguration,
                                        strText: (item.node.getFirstChild()() as CommonmarkText)().getLiteral(),
                                        strUrl: (item.node as CommonmarkLink)().getDestination(),
                                        strType: urlSafeBase64Decode((item.node as CommonmarkLink)().getDestination()),
                                        backGroupColor: renderTableCellColor(isHeader, markdownAIConfiguration.markdownAITheme, idRow),
                                        maxWidth: (markdownAIConfiguration.markdownAITheme.tableMaxTextWidth - 2.0 * markdownAIConfiguration.markdownAITheme.tableCellPadding - 2.0 * markdownAIConfiguration.markdownAITheme.tableBorderWidth).vp
                                    )
                                }
                            }
                        }
                    } else if (item.node is CommonmarkImage) {
                        // 图片节点
                        MarkdownAIImagePixelmapSpanComponent(
                            destination: (item.node as CommonmarkImage)().getDestination(),
                            imagePlaceholder: markdownAIConfiguration.markdownAITheme.imagePlaceholder,
                            componentWidth: (markdownAIConfiguration.markdownAITheme.tableMaxTextWidth - 2.0 * markdownAIConfiguration.markdownAITheme.tableCellPadding - 2.0 * markdownAIConfiguration.markdownAITheme.tableBorderWidth),
                            imageMarginTop: 0.0,
                            imageMarginBottom: 0.0,
                            imageCallback: imageCallback,
                            linkCallback: markdownAIConfiguration.linkCallback,
                            isLink: item.link.isSome(),
                            linkUrl: if (item.link.isSome()) {item.link().getDestination()} else {Option<String>.None},
                            imageCallbackCallback : markdownAIConfiguration.imageCallbackCallback
                        )
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        MarkdownAILatexImageSpanComponent(
                            markdownAIConfiguration: markdownAIConfiguration,
                            componentWidth: componentWidth,
                            strLatexMath: (item.node as LatexMathNode)().latex,
                            backGroupColor: renderTableCellColor(isHeader, markdownAIConfiguration.markdownAITheme, idRow),
                            maxWidth: (markdownAIConfiguration.markdownAITheme.tableMaxTextWidth - 2.0 * markdownAIConfiguration.markdownAITheme.tableCellPadding - 2.0 * markdownAIConfiguration.markdownAITheme.tableBorderWidth).vp
                        )
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                }
            )
        }
        // 设置行高
        .lineHeight(markdownAIConfiguration.markdownAITheme.tableTextLineHeight)
        // 支持设备内复制
        .copyOption(CopyOptions.LocalDevice)
        // 长按文本内部区域弹出剪贴板后，点击剪切板复制按钮，触发该事件。目前文本复制仅支持文本。
        .onCopy({
            str =>
                if(markdownAIConfiguration.textCopyCallback.isSome()){
                   markdownAIConfiguration.textCopyCallback()(str)
                }
        })
    }

    /**
     * 表格文字内容
     */
    @Builder
    func tableBlockCellComponent() {
        if(DeviceInfo.sdkApiVersion >=19){
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
        if (isFull) {
            // 全量加载
            nodeViewList.clear()
            nodeViewList.appendAll(refreshNodeViews)
        } else {
            // 增量加载
            if (refreshNodeViewSize == 0) {
                return
            }
            if (refreshNodeViewSize > nodeViewListSize) {
                // 刷新数据的长度大于页面数据长度，需要添加数据
                if (nodeViewListSize != 0) {
                    // 更新页面最后一条数据
                    nodeViewList[nodeViewListSize - 1] = refreshNodeViews[nodeViewListSize - 1]
                }
                // 循环添加所有新增数据
                for (i in refreshNodeViewSize - nodeViewListSize..0 : -1) {
                    nodeViewList.append(refreshNodeViews[refreshNodeViewSize - i])
                }
            } else if (refreshNodeViewSize == nodeViewListSize) {
                // 刷新数据的长度等于页面数据长度，需要更新当前数据
                nodeViewList[nodeViewListSize - 1] = refreshNodeViews[refreshNodeViewSize - 1]
            } else {
                // 刷新数据小于页面数据长度，需要删除数据
                // 更新页面中间一条数据 - 刷新数据长度的最后一条数据
                nodeViewList[refreshNodeViewSize - 1] = refreshNodeViews[refreshNodeViewSize - 1]
                // 循环删除所有多余数据
                for (i in 1..=(nodeViewListSize - refreshNodeViewSize)) {
                    nodeViewList.remove(nodeViewListSize - i)
                }
            }
        }
        size = nodeViewList.size // 更新列表长度
    }

    func leftWidths(): Float64 {
        return if (idxItem == 0) {
            0.0
        } else {
            markdownAIConfiguration.markdownAITheme.tableBorderWidth / 2.0
        }
    }

    func rightWidths(): Float64 {
        return if (idxItem == dataCellSize - 1) {
            0.0
        } else {
            markdownAIConfiguration.markdownAITheme.tableBorderWidth / 2.0
        }
    }

    func topWidths(): Float64 {
        return if (idRow == 0) {
            0.0
        } else {
            markdownAIConfiguration.markdownAITheme.tableBorderWidth / 2.0
        }
    }

    func bottomWidths(): Float64 {
        return if (idRow == dataRowSize - 1) {
            0.0
        } else {
            markdownAIConfiguration.markdownAITheme.tableBorderWidth / 2.0
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
