package markdown.components

import ohos.state_macro_manage.*

/**
 * 段落控件
 */
@Component
class MarkdownParagraphComponent {
    var paragraphMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var paragraphNodeView: NodeView // 段落控件自身节点
    @Prop
    var paragraphComponentWidth: Float64 // 控件宽度 - 单位vp
    @BuilderParam
    var paragraphCustomParagraphLineBuilder: (NodeView, Int64) -> Unit // 自定义行内段落控件
    var paragraphTocListOnClick: (Int64) -> Unit // TOC列表点击事件
    var paragraphImageCallback: (String) -> Unit // 图片点击事件
    var paragraphFootnoteCallback: (String) -> Unit // 脚注点击事件
    @State
    var isRefresh: Bool = false // 标题子节点是否不为0
    @State
    var isOneLink: Bool = false // 是否只有一条链接数据
    @State
    var paragraphNodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>() // 列表数据

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(paragraphNodeView.nodeHash, refreshParagraphData)
        refreshParagraphData(paragraphNodeView)
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(paragraphNodeView.nodeHash)
    }

    func build() {
        Row() {
            Column() {
                if (!paragraphMarkdownConfiguration.markdownTheme.imageTheme.isImageMixedLayout && paragraphNodeViewList.size == 1 && (paragraphNodeViewList[0].nodeType == "Image" || paragraphNodeViewList[0].nodeType == "StyleImage" || paragraphNodeViewList[0].nodeType == "ImageHtmlNode")) {
                    if (paragraphMarkdownConfiguration.imageReplaceCallback.isNone()) {
                        if (paragraphNodeViewList[0].imageUrl().startsWith("./")) {
                            MarkdownImageRawFileComponent(
                                rawFileMarkdownTheme: paragraphMarkdownConfiguration.markdownTheme,
                                rawFileDestination: paragraphNodeViewList[0].imageUrl(),
                                rawFileComponentWidth: paragraphComponentWidth,
                                rawFileImageDownloadCallback: paragraphMarkdownConfiguration.imageDownloadCallback,
                                rawFileImageCallback: paragraphImageCallback,
                                rawFileLinkCallback: paragraphMarkdownConfiguration.linkCallback,
                                rawFileLink: paragraphNodeViewList[0].isLink,
                                rawFileLinkUrl: paragraphNodeViewList[0].linkUrl,
                                rawFileImageWidth: paragraphNodeViewList[0].imageWidth,
                                rawFileImageHeight: paragraphNodeViewList[0].imageHeight,
                                rawFileImageRadius: paragraphNodeViewList[0].imageRadius,
                                rawFileImageAlign: paragraphNodeViewList[0].imageAlign
                            )
                        } else {
                            MarkdownImageUrlComponent(
                                urlMarkdownTheme: paragraphMarkdownConfiguration.markdownTheme,
                                urlDestination: paragraphNodeViewList[0].imageUrl(),
                                urlComponentWidth: paragraphComponentWidth,
                                urlImageDownloadCallback: paragraphMarkdownConfiguration.imageDownloadCallback,
                                urlImageCallback: paragraphImageCallback,
                                urlLinkCallback: paragraphMarkdownConfiguration.linkCallback,
                                urlLink: paragraphNodeViewList[0].isLink,
                                urlLinkUrl: paragraphNodeViewList[0].linkUrl,
                                urlImageWidth: paragraphNodeViewList[0].imageWidth,
                                urlImageHeight: paragraphNodeViewList[0].imageHeight,
                                urlImageRadius: paragraphNodeViewList[0].imageRadius,
                                urlImageAlign: paragraphNodeViewList[0].imageAlign
                            )
                        }
                    } else {
                        if (paragraphNodeViewList[0].imageUrl().startsWith("./")) {
                            MarkdownImageCallbackRawFileComponent(
                                rawFileCallbackMarkdownTheme: paragraphMarkdownConfiguration.markdownTheme,
                                rawFileCallbackDestination: paragraphNodeViewList[0].imageUrl(),
                                rawFileCallbackComponentWidth: paragraphComponentWidth,
                                rawFileCallbackImageDownloadCallback: paragraphMarkdownConfiguration.imageDownloadCallback,
                                rawFileCallbackImageReplaceCallback: paragraphMarkdownConfiguration.imageReplaceCallback(),
                                rawFileCallbackImageCallback: paragraphImageCallback,
                                rawFileCallbackLinkCallback: paragraphMarkdownConfiguration.linkCallback,
                                rawFileCallbackLink: paragraphNodeViewList[0].isLink,
                                rawFileCallbackLinkUrl: paragraphNodeViewList[0].linkUrl,
                                rawFileCallbackImageWidth: paragraphNodeViewList[0].imageWidth,
                                rawFileCallbackImageHeight: paragraphNodeViewList[0].imageHeight,
                                rawFileCallbackImageRadius: paragraphNodeViewList[0].imageRadius,
                                rawFileCallbackImageAlign: paragraphNodeViewList[0].imageAlign
                            )
                        } else {
                            MarkdownImageCallbackUrlComponent(
                                urlCallbackMarkdownTheme: paragraphMarkdownConfiguration.markdownTheme,
                                urlCallbackDestination: paragraphNodeViewList[0].imageUrl(),
                                urlCallbackComponentWidth: paragraphComponentWidth,
                                urlCallbackImageDownloadCallback: paragraphMarkdownConfiguration.imageDownloadCallback,
                                urlCallbackImageReplaceCallback: paragraphMarkdownConfiguration.imageReplaceCallback(),
                                urlCallbackImageCallback: paragraphImageCallback,
                                urlCallbackLinkCallback: paragraphMarkdownConfiguration.linkCallback,
                                urlCallbackLink: paragraphNodeViewList[0].isLink,
                                urlCallbackLinkUrl: paragraphNodeViewList[0].linkUrl,
                                urlCallbackImageWidth: paragraphNodeViewList[0].imageWidth,
                                urlCallbackImageHeight: paragraphNodeViewList[0].imageHeight,
                                urlCallbackImageRadius: paragraphNodeViewList[0].imageRadius,
                                urlCallbackImageAlign: paragraphNodeViewList[0].imageAlign
                            )
                        }
                    }
                } else {
                    paragraphComponent()
                }
            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Center)
            .layoutWeight(1)
        }
        .backgroundColor(paragraphBackgroundColor(paragraphMarkdownConfiguration.markdownTheme, paragraphNodeView))
        .padding(
            top: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphPaddingTop,
            right: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphPaddingRight,
            bottom: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphPaddingBottom,
            left: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphPaddingLeft
        )
        .margin(
            top: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphMarginTop,
            right: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphMarginRight,
            bottom: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphMarginBottom,
            left: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphMarginLeft
        )
    }

    /**
     * 段落文字内容
     */
    @Builder
    func paragraphComponent() {
        Text() {
            if (paragraphNodeView.footnoteID.isSome()) {
                Span("[^${paragraphNodeView.footnoteID()}]: ")
                    .fontSize(paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphTextFontSize)
                    .fontWeight(paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphTextFontWeight)
                    .fontColor(paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphTextFontColor)
            }
            if (isRefresh) {
                markdownSpanListComponent(
                    paragraphNodeViewList,
                    paragraphMarkdownConfiguration,
                    paragraphComponentWidth,
                    paragraphTocListOnClick,
                    paragraphImageCallback,
                    paragraphFootnoteCallback
                )
            }
        }
        .textAlign(TextAlign.Start)
        .halfLeading(true)
        .copyOption(if (paragraphMarkdownConfiguration.markdownTheme.globalTheme.isOnCopy) {
            CopyOptions.LocalDevice
        } else {
            CopyOptions.None
        })
        .onCopy({
            str => if (let Some(v) <- paragraphMarkdownConfiguration.textCopyCallback) {
                v(str)
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
                        false
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
                    if (isOneLink) {
                        spanLinkComponent(
                            spanListNodeView,
                            spanListMarkdownConfiguration,
                            spanListTocListOnClick,
                            spanListFootnoteCallback,
                            true
                        )
                    } else {
                        spanLinkComponent(
                            spanListNodeView,
                            spanListMarkdownConfiguration,
                            spanListTocListOnClick,
                            spanListFootnoteCallback,
                            false
                        )
                    }
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
                    paragraphCustomParagraphLineBuilder(spanListNodeView, index)
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
     * 段落控件数据刷新
     * 数据驱动：逐个对比新旧数据hash，替换变化的项，新增/删除差额
     *
     * @param paragraphNodeView 刷新的新数据
     */
    public func refreshParagraphData(newNodeView: NodeView): Unit {
        this.paragraphNodeView = newNodeView
        let refreshNodeViewChildren = paragraphNodeView.children // 子节点数据
        if (refreshNodeViewChildren.size == 0) {
            paragraphNodeViewList.clear()
            return
        }
        isRefresh = true
        // 增量更新：对比重叠区间hash，替换变化的项
        let existingLen: Int64 = paragraphNodeViewList.size
        let newLen: Int64 = refreshNodeViewChildren.size
        let minLen = if (existingLen < newLen) { existingLen } else { newLen }
        for (i in 0..minLen) {
            let oldNode = paragraphNodeViewList[i]
            let newNode = refreshNodeViewChildren[i]
            if (oldNode.nodeHash != newNode.nodeHash || oldNode.contentHash != newNode.contentHash) {
                paragraphNodeViewList[i] = newNode
                if (newNode.nodeType == "LatexMathNode" && oldNode.nodeHash == newNode.nodeHash) {
                    MarkdownRefreshRegistry.refresh(newNode.nodeHash, newNode)
                }
            }
        }
        // 新增部分
        if (newLen > existingLen) {
            for (i in existingLen..newLen) {
                paragraphNodeViewList.append(refreshNodeViewChildren[i])
            }
        } else if (existingLen > newLen) {
            // 删除多余部分（从后往前删）
            for (i in existingLen - 1..=newLen : -1) {
                paragraphNodeViewList.remove(i)
            }
        }
        if (paragraphNodeViewList.size == 1 && (paragraphNodeViewList[0].nodeType == "Link" || paragraphNodeViewList[0].nodeType == "HeadLink")) {
            isOneLink = true
        } else {
            isOneLink = false
        }
    }
}
