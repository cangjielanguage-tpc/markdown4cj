/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown段落自定义页面
 */
@Component
class MarkdownParagraphComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 段落内容数据
     */
    var nodeViews: ArrayList<NodeView>

    /**
     * 定位需要的数组
     */
    var indexList: ArrayList<Int64> = ArrayList<Int64>()

    /**
     * 脚注
     */
    var footnoteBlock: Option<FootnoteBlock> = Option<FootnoteBlock>.None

    /**
     * 长度
     */
    var size: Int64 = -1

    /**
     * 上边距 - 单位vp
     */
    var marginTop: Float64

    /**
     * 下边距 - 单位vp
     */
    var marginBottom: Float64

    /**
     * 控件宽度 - 单位px
     */
    var componentWidth: Float64

    /**
     * 是否全量加载 - true：全量加载，fasle：增量加载
     */
    var isFull: Bool

    /**
     * 缓存的第一层段落控件列表
     */
    var paragraphComponents: ArrayList<MarkdownParagraphComponent>

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * TOC列表点击事件回调
     */
    let tocListOnClick: (Int64) -> Unit

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    /**
     * 块引用背景颜色
     */
    var blockQuoteBackGroupClor: Option<Color> = Option<Color>.None

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        paragraphComponents.add(this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        paragraphComponents.removeIf(
            {
                predicate => if (predicate.indexList == indexList && predicate.size == size) {
                    true
                } else {
                    false
                }
            })
    }

    func build() {
        Text() {
            if(footnoteBlock.isSome()){
                Span("[^${footnoteBlock().noteid}]: ")
                    // 设置文本尺寸
                    .fontSize(markdownConfiguration.markdownTheme.paragraphTextSize)
                    // 设置文本的字体粗细
                    .fontWeight(FontWeight.W400)
                    // 设置文本颜色
                    .fontColor(markdownConfiguration.markdownTheme.paragraphTextColor)
            }
            ForEach(
                nodeViewList,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        paragraphTextComponent(item, markdownConfiguration, fontCallback)
                    } else if (item.node is Footnote) {
                        // 脚注
                        paragraphFootnoteComponent(item, markdownConfiguration, fontCallback)
                    } else if (item.node is HeadLink) {
                        // TOC列表
                        paragraphTocComponent(item, markdownConfiguration,tocListOnClick)
                    } else if (item.node is Code) {
                        // 内联代码
                        paragraphCodeComponent(item, markdownConfiguration)
                    } else if (item.node is CommonmarkLink) {
                        // 链接
                        if((item.node as CommonmarkLink)().getDestination().startsWith("http://") || (item.node as CommonmarkLink)().getDestination().startsWith("https://")){
                            if(item.node.getFirstChild().isSome() &&  item.node.getFirstChild()() is CommonmarkText){
                                if ((item.node.getFirstChild()() as CommonmarkText)().getLiteral().trimAscii().toRuneArray().size > 1) {
                                    MarkdownLinkRectImageComponent(
                                        markdownConfiguration: markdownConfiguration,
                                        strText: (item.node.getFirstChild()() as CommonmarkText)().getLiteral().trimAscii(),
                                        strUrl: (item.node as CommonmarkLink)().getDestination(),
                                        backGroupColor: markdownbackGroupColor(blockQuoteBackGroupClor,markdownConfiguration.markdownTheme.linkRectImageBackGroupColor)
                                    )
                                } else {
                                    MarkdownLinkCircleImageComponent(
                                        markdownConfiguration: markdownConfiguration,
                                        strText: (item.node.getFirstChild()() as CommonmarkText)().getLiteral().trimAscii(),
                                        strUrl: (item.node as CommonmarkLink)().getDestination(),
                                        backGroupColor: markdownbackGroupColor(blockQuoteBackGroupClor,markdownConfiguration.markdownTheme.linkCircleImageBackGroupColor)
                                    )
                                }
                            }
                        } else {
                           if(item.node.getFirstChild().isSome() &&  item.node.getFirstChild()() is CommonmarkText){
                                MarkdownLinkRectToolImageComponent(
                                    markdownConfiguration: markdownConfiguration,
                                    strText: (item.node.getFirstChild()() as CommonmarkText)().getLiteral(),
                                    strUrl: (item.node as CommonmarkLink)().getDestination(),
                                    strType: urlSafeBase64Decode((item.node as CommonmarkLink)().getDestination()),
                                    backGroupColor: markdownbackGroupColor(blockQuoteBackGroupClor,markdownConfiguration.markdownTheme.linkRectToolImageBackGroupColor)
                                )
                           }
                        }
                    } else if (item.node is HardLineBreak) {
                        // 硬换行
                        Span("\n")
                    } else if (item.node is SoftLineBreak) {
                        // 软换行
                        Span(spanSoftLineBreak(markdownConfiguration.markdownTheme.isLineBreak))
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        MarkdownLatexImageSpanComponent(
                            markdownConfiguration: markdownConfiguration,
                            componentWidth: componentWidth,
                            strLatexMath: (item.node as LatexMathNode)().latex,
                            backGroupColor: markdownbackGroupColor(blockQuoteBackGroupClor,markdownConfiguration.markdownTheme.latexMathBackGroupColor)
                        )
                    } else if (item.node is ImageHtmlNode) {
                        // HTML图片
                        MarkdownHtmlImageSpanComponent(
                            markdownConfiguration: markdownConfiguration,
                            destination: (item.node as ImageHtmlNode)().getDestination(),
                            imageWidth: strToFloat64((item.node as ImageHtmlNode)().getWidth()),
                            imageHeight: strToFloat64((item.node as ImageHtmlNode)().getHeight()),
                                componentWidth:componentWidth
                        )
                    } else if (item.node is StyleImage) {
                        //  图片Style节点
                        if((item.node as StyleImage)().getDestination().startsWith("./")){
                            MarkdownImageStyleSpanRawFileComponent(
                                markdownConfiguration: markdownConfiguration,
                                destination: (item.node as StyleImage)().getDestination(),
                                picStyle: (item.node as StyleImage)().styles,
                                componentWidth:componentWidth
                            )
                        }else{
                            MarkdownImageStyleSpanComponent(
                                markdownConfiguration: markdownConfiguration,
                                destination: (item.node as StyleImage)().getDestination(),
                                picStyle: (item.node as StyleImage)().styles,
                                componentWidth:componentWidth
                            )
                        }
                    } else if (item.node is CommonmarkImage) {
                        // 图片节点
                        if((item.node as CommonmarkImage)().getDestination().startsWith("./")){
                            MarkdownImageSpanRawFileComponent(
                                markdownConfiguration: markdownConfiguration,
                                destination: (item.node as CommonmarkImage)().getDestination(),
                                componentWidth:componentWidth
                            )
                        }else{
                            MarkdownImageSpanComponent(
                                markdownConfiguration: markdownConfiguration,
                                destination: (item.node as CommonmarkImage)().getDestination(),
                                componentWidth:componentWidth
                            )
                        }
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                }
            )
        }
        // 设置多行文本的文本对齐方式
        .textAlign(TextAlign.Start)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置行高
        .lineHeight(markdownConfiguration.markdownTheme.paragraphTextLineheight)
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
                if (nodeViewListSize >= 2) {
                    if (refreshNodeViews[nodeViewListSize - 2].node.getNodeType() != nodeViewList[nodeViewListSize - 2].node.getNodeType()) {
                        nodeViewList[nodeViewListSize - 2] = refreshNodeViews[nodeViewListSize - 2]
                    }
                    if ((refreshNodeViews[nodeViewListSize - 2].node is CommonmarkText) && (nodeViewList[nodeViewListSize - 2].node is CommonmarkText)) {
                        if ((refreshNodeViews[nodeViewListSize - 2].node as CommonmarkText)().getLiteral() != (nodeViewList[nodeViewListSize - 2].node as CommonmarkText)().getLiteral()) {
                            nodeViewList[nodeViewListSize - 2] = refreshNodeViews[nodeViewListSize - 2]
                        }
                    }
                }
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
                // 有可能还需要刷新倒数第二条数据内容
                if (refreshNodeViewSize >= 2) {
                    if (refreshNodeViews[refreshNodeViewSize - 2].node.getNodeType() != nodeViewList[nodeViewListSize - 2].node.getNodeType()) {
                        nodeViewList[refreshNodeViewSize - 2] = refreshNodeViews[refreshNodeViewSize - 2]
                    }
                    if ((refreshNodeViews[refreshNodeViewSize - 2].node is CommonmarkText) && (nodeViewList[nodeViewListSize - 2].node is CommonmarkText)) {
                        if ((refreshNodeViews[refreshNodeViewSize - 2].node as CommonmarkText)().getLiteral() != (nodeViewList[nodeViewListSize - 2].node as CommonmarkText)().getLiteral()) {
                            nodeViewList[refreshNodeViewSize - 2] = refreshNodeViews[refreshNodeViewSize - 2]
                        }
                    }
                }
                // 刷新最后一条数据
                nodeViewList[nodeViewListSize - 1] = refreshNodeViews[refreshNodeViewSize - 1]
            } else {
                // 刷新数据小于页面数据长度，需要删除数据
                // 更新页面中间一条数据 - 刷新数据长度的最后一条数据
                if (refreshNodeViewSize >= 2) {
                    if (refreshNodeViews[refreshNodeViewSize - 2].node.getNodeType() != nodeViewList[refreshNodeViewSize - 2].node.getNodeType()) {
                        nodeViewList[refreshNodeViewSize - 2] = refreshNodeViews[refreshNodeViewSize - 2]
                    }
                    if ((refreshNodeViews[refreshNodeViewSize - 2].node is CommonmarkText) && (nodeViewList[refreshNodeViewSize - 2].node is CommonmarkText)) {
                        if ((refreshNodeViews[refreshNodeViewSize - 2].node as CommonmarkText)().getLiteral() != (nodeViewList[refreshNodeViewSize - 2].node as CommonmarkText)().getLiteral()) {
                            nodeViewList[refreshNodeViewSize - 2] = refreshNodeViews[refreshNodeViewSize - 2]
                        }
                    }
                }
                nodeViewList[refreshNodeViewSize - 1] = refreshNodeViews[refreshNodeViewSize - 1]
                // 循环删除所有多余数据
                for (i in 1..=(nodeViewListSize - refreshNodeViewSize)) {
                    nodeViewList.remove(nodeViewListSize - i)
                }
            }
        }
        size = nodeViewList.size // 更新列表长度
    }
}
