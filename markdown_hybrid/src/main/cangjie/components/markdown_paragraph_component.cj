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
    var paragraphComponents: HashMap<Int64, MarkdownParagraphComponent> // 缓存的段落控件数据
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
        refreshParagraphData(paragraphNodeView) // 初始化刷新数据
        paragraphComponents.add(paragraphNodeView.nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = paragraphComponents.get(paragraphNodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                paragraphComponents.remove(paragraphNodeView.nodeHash)
            }
        } else {
            paragraphComponents.remove(paragraphNodeView.nodeHash)
        }
    }

    func build() {
        Column() {
            if (!paragraphMarkdownConfiguration.markdownTheme.imageTheme.isImageMixedLayout && paragraphNodeViewList.size == 1 && (paragraphNodeViewList[0].nodeType == "Image" || paragraphNodeViewList[0].nodeType == "StyleImage" || paragraphNodeViewList[0].nodeType == "ImageHtmlNode")) {
                if (paragraphMarkdownConfiguration.imageCallbackCallback.isNone()) {
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
                            rawFileCallbackImageCallbackCallback: paragraphMarkdownConfiguration.imageCallbackCallback(),
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
                            urlCallbackImageCallbackCallback: paragraphMarkdownConfiguration.imageCallbackCallback(),
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
        .width(100.percent)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
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
        if (DeviceInfo.sdkApiVersion >= 19) {
            paragraphComponent19()
        } else {
            paragraphComponent18()
        }
    }

    /**
     * 段落文字内容
     */
    @Builder
    func paragraphComponent18() {
        Text() {
            if (paragraphNodeView.footnoteID.isSome()) {
                Span("[^${paragraphNodeView.footnoteID()}]: ")
                    .fontFamily(paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphTextFontFamily)
                    .fontSize(paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphTextFontSize)
                    .fontWeight(paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphTextFontWeight)
                    .fontStyle(paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphTextFontStyle)
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
        .interopHalfLeading(true)
        .interopCopyOption(if (paragraphMarkdownConfiguration.markdownTheme.globalTheme.isOnCopy) {
            true
        } else {
            false
        })
        .interopOnCopy({
            str => if (let Some(v) <- paragraphMarkdownConfiguration.textCopyCallback) {
                v(str)
            }
        })
    }

    /**
     * 段落文字内容
     */
    @Builder
    func paragraphComponent19() {
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
                spanListNodeView: NodeView, idx: Int64 => return "${idx}-${spanListNodeView.nodeHash}-${spanListNodeView.contentHash}"
            }
        )
    }

    /**
     * 段落控件数据刷新
     *
     * @param paragraphNodeView 刷新的新数据
     */
    public func refreshParagraphData(paragraphNodeView: NodeView): Unit {
        this.paragraphNodeView = paragraphNodeView
        let refreshNodeViewChildren = paragraphNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let paragraphNodeViewListSize: Int64 = paragraphNodeViewList.size // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            paragraphNodeViewList.clear()
            return
        }
        if (refreshNodeViewSize > 0) {
            isRefresh = true
        }
        if (refreshNodeViewSize > paragraphNodeViewListSize) {
            // 新数据大于页面数据
            refreshParagraphDatas(paragraphNodeViewListSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环添加新数据
            for (i in paragraphNodeViewListSize..refreshNodeViewSize) {
                paragraphNodeViewList.append(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == paragraphNodeViewListSize) {
            // 新数据等于页面数据
            refreshParagraphDatas(paragraphNodeViewListSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
        } else {
            // 新数据小于页面数据
            refreshParagraphDatas(refreshNodeViewSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环删除多余的旧数据
            for (i in paragraphNodeViewListSize - 1..=refreshNodeViewSize : -1) {
                paragraphNodeViewList.remove(i)
            }
        }
        if (paragraphNodeViewList.size == 1 && (paragraphNodeViewList[0].nodeType == "Link" || paragraphNodeViewList[0].nodeType == "HeadLink")) {
            isOneLink = true
        } else {
            isOneLink = false
        }
    }

    /**
     * 循环判断历史数据有没有做过修改
     *
     * @param size 长度
     * @param refreshNodeViews 刷新的数据
     */
    func refreshParagraphDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = paragraphNodeViewList[i]
            let newNodeHash = refreshNodeView.nodeHash
            let oldNodeHash = dataSourceNode.nodeHash
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            if (newNodeHash != oldNodeHash || newContentHash != oldContentHash) {
                // 自身节点唯一ID不相同需要刷新数据
                // 子节点唯一ID不相同需要刷新子节点数据
                paragraphNodeViewList[i] = refreshNodeView
            }
        }
    }
}
