/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.state_macro_manage.*

/**
 * 标题控件
 */
@Component
class MarkdownHeadingComponent {
    /**
     * markdown配置
     */
    var headingMarkdownConfiguration: MarkdownConfiguration

    /**
     * 标题控件自身节点
     */
    @Prop
    var headingNodeView: NodeView

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var headingComponentWidth: Float64

    /**
     * 缓存的标题控件数据
     */
    var headingComponents: HashMap<Int64, MarkdownHeadingComponent>

    /**
     * 自定义行内标题控件
     */
    @BuilderParam
    var headingCustomHeadingLineBuilder: (NodeView, Int64) -> Unit

    /**
     * 图片点击事件
     */
    var headingImageCallback: (String) -> Unit

    /**
     * 脚注点击事件
     */
    var headingFootnoteCallback: (String) -> Unit

    /**
     * 标题子节点是否不为0
     */
    @State
    var isRefresh: Bool = false

    /**
     * 是否只有一条链接数据
     */
    @State
    var isOneLink: Bool = false

    /**
     * 列表数据
     */
    @State
    var headingNodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    protected override func aboutToAppear(): Unit {
        refreshHeadingData(headingNodeView) // 初始化刷新数据
        headingComponents.add(headingNodeView.nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = headingComponents.get(headingNodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                headingComponents.remove(headingNodeView.nodeHash)
            }
        } else {
            headingComponents.remove(headingNodeView.nodeHash)
        }
    }

    func build() {
        Column() {
            if (headingNodeViewList.size == 1 && !headingMarkdownConfiguration.markdownTheme.isImageMixedLayout && (headingNodeViewList[0].nodeType == "Image" || headingNodeViewList[0].nodeType == "StyleImage" || headingNodeViewList[0].nodeType == "ImageHtmlNode")) {
                if (headingMarkdownConfiguration.imageCallbackCallback.isNone()) {
                    if (headingNodeViewList[0].imageUrl().startsWith("./")) {
                        MarkdownImageRawFileComponent(
                            rawFileMarkdownTheme: headingMarkdownConfiguration.markdownTheme,
                            rawFileDestination: headingNodeViewList[0].imageUrl(),
                            rawFileComponentWidth: headingComponentWidth,
                            rawFileImageDownloadCallback: headingMarkdownConfiguration.imageDownloadCallback,
                            rawFileImageCallback: headingImageCallback,
                            rawFileLinkCallback: headingMarkdownConfiguration.linkCallback,
                            rawFileLink: headingNodeViewList[0].isLink,
                            rawFileLinkUrl: headingNodeViewList[0].linkUrl,
                            rawFileImageWidth: headingNodeViewList[0].imageWidth,
                            rawFileImageHeight: headingNodeViewList[0].imageHeight,
                            rawFileImageRadius: headingNodeViewList[0].imageRadius,
                            rawFileImageAlign: headingNodeViewList[0].imageAlign
                        )
                    } else {
                        MarkdownImageUrlComponent(
                            urlMarkdownTheme: headingMarkdownConfiguration.markdownTheme,
                            urlDestination: headingNodeViewList[0].imageUrl(),
                            urlComponentWidth: headingComponentWidth,
                            urlImageDownloadCallback: headingMarkdownConfiguration.imageDownloadCallback,
                            urlImageCallback: headingImageCallback,
                            urlLinkCallback: headingMarkdownConfiguration.linkCallback,
                            urlLink: headingNodeViewList[0].isLink,
                            urlLinkUrl: headingNodeViewList[0].linkUrl,
                            urlImageWidth: headingNodeViewList[0].imageWidth,
                            urlImageHeight: headingNodeViewList[0].imageHeight,
                            urlImageRadius: headingNodeViewList[0].imageRadius,
                            urlImageAlign: headingNodeViewList[0].imageAlign
                        )
                    }
                } else {
                    if (headingNodeViewList[0].imageUrl().startsWith("./")) {
                        MarkdownImageCallbackRawFileComponent(
                            rawFileCallbackMarkdownTheme: headingMarkdownConfiguration.markdownTheme,
                            rawFileCallbackDestination: headingNodeViewList[0].imageUrl(),
                            rawFileCallbackComponentWidth: headingComponentWidth,
                            rawFileCallbackImageDownloadCallback: headingMarkdownConfiguration.imageDownloadCallback,
                            rawFileCallbackImageCallbackCallback: headingMarkdownConfiguration.imageCallbackCallback(),
                            rawFileCallbackImageCallback: headingImageCallback,
                            rawFileCallbackLinkCallback: headingMarkdownConfiguration.linkCallback,
                            rawFileCallbackLink: headingNodeViewList[0].isLink,
                            rawFileCallbackLinkUrl: headingNodeViewList[0].linkUrl,
                            rawFileCallbackImageWidth: headingNodeViewList[0].imageWidth,
                            rawFileCallbackImageHeight: headingNodeViewList[0].imageHeight,
                            rawFileCallbackImageRadius: headingNodeViewList[0].imageRadius,
                            rawFileCallbackImageAlign: headingNodeViewList[0].imageAlign
                        )
                    } else {
                        MarkdownImageCallbackUrlComponent(
                            urlCallbackMarkdownTheme: headingMarkdownConfiguration.markdownTheme,
                            urlCallbackDestination: headingNodeViewList[0].imageUrl(),
                            urlCallbackComponentWidth: headingComponentWidth,
                            urlCallbackImageDownloadCallback: headingMarkdownConfiguration.imageDownloadCallback,
                            urlCallbackImageCallbackCallback: headingMarkdownConfiguration.imageCallbackCallback(),
                            urlCallbackImageCallback: headingImageCallback,
                            urlCallbackLinkCallback: headingMarkdownConfiguration.linkCallback,
                            urlCallbackLink: headingNodeViewList[0].isLink,
                            urlCallbackLinkUrl: headingNodeViewList[0].linkUrl,
                            urlCallbackImageWidth: headingNodeViewList[0].imageWidth,
                            urlCallbackImageHeight: headingNodeViewList[0].imageHeight,
                            urlCallbackImageRadius: headingNodeViewList[0].imageRadius,
                            urlCallbackImageAlign: headingNodeViewList[0].imageAlign
                        )
                    }
                }
            } else {
                headingTitleComponent()
            }
            // 一级二级标题是否显示下划线
            if ((headingNodeView.headingLevel == 1) && headingMarkdownConfiguration.markdownTheme.headingBreakHeight > 0.0) {
                Divider()
                    .color(headingMarkdownConfiguration.markdownTheme.headingBreakColor1)
                    .strokeWidth(headingMarkdownConfiguration.markdownTheme.headingBreakHeight)
            } else if ((headingNodeView.headingLevel == 2) && headingMarkdownConfiguration.markdownTheme.headingBreakHeight > 0.0) {
                Divider()
                    .color(headingMarkdownConfiguration.markdownTheme.headingBreakColor2)
                    .strokeWidth(headingMarkdownConfiguration.markdownTheme.headingBreakHeight)
            }
        }
        .width(100.percent)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
    }

    /**
     * 标题文字内容
     */
    @Builder
    func headingTitleComponent() {
        if (DeviceInfo.sdkApiVersion >= 19) {
            headingTitleComponent19()
        } else {
            headingTitleComponent18()
        }
    }

    /**
     * 标题文字内容
     */
    @Builder
    func headingTitleComponent18() {
        Text() {
            if (isRefresh) {
                markdownSpanListComponent(
                    headingNodeViewList,
                    headingMarkdownConfiguration,
                    headingComponentWidth,
                    Option<(Int64) -> Unit>.None,
                    headingImageCallback,
                    headingFootnoteCallback
                )
            }
        }
        .textAlign(TextAlign.Start)
        .interopHalfLeading(true)
        .interopCopyOption(if (headingMarkdownConfiguration.markdownTheme.isOnCopy) {
            true
        } else {
            false
        })
        .interopOnCopy({
            str => if (let Some(v) <- headingMarkdownConfiguration.textCopyCallback) {
                v(str)
            }
        })
    }

    /**
     * 标题文字内容
     */
    @Builder
    func headingTitleComponent19() {
        Text() {
            if (isRefresh) {
                markdownSpanListComponent(
                    headingNodeViewList,
                    headingMarkdownConfiguration,
                    headingComponentWidth,
                    Option<(Int64) -> Unit>.None,
                    headingImageCallback,
                    headingFootnoteCallback
                )
            }
        }
        .textAlign(TextAlign.Start)
        .halfLeading(true)
        .copyOption(if (headingMarkdownConfiguration.markdownTheme.isOnCopy) {
            CopyOptions.LocalDevice
        } else {
            CopyOptions.None
        })
        .onCopy({
            str => if (let Some(v) <- headingMarkdownConfiguration.textCopyCallback) {
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
                spanListNodeView: NodeView, index: Int64 => if (spanListNodeView.nodeType == "Text" ||spanListNodeView.nodeType == "Code" || spanListNodeView.nodeType == "Footnote") {
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
                    Span(spanSoftLineBreak(spanListMarkdownConfiguration.markdownTheme.isLineBreak))
                } else if (spanListNodeView.nodeType == "HardLineBreak") {
                    // 硬换行
                    Span("\n")
                } else if (spanListNodeView.nodeType == "Link" || spanListNodeView.nodeType == "HeadLink") {
                    // 链接, TOC列表链接
                    if ((spanListNodeView.isBulletList || spanListNodeView.isOrderedList || spanListNodeView.isQuote || spanListNodeView.isDescList) && isOneLink && !spanListMarkdownConfiguration.markdownTheme.isListLinkStyle) {
                        markdownSpanComponent(
                            spanListMarkdownConfiguration,
                            spanListNodeView,
                            spanListTocListOnClick,
                            spanListFootnoteCallback,
                            false
                        )
                    } else {
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
                    headingCustomHeadingLineBuilder(spanListNodeView, index)
                }
            },
            keyGeneratorFunc: {
                spanListNodeView: NodeView, idx: Int64 => return "${idx}-${spanListNodeView.nodeHash}-${spanListNodeView.contentHash}"
            }
        )
    }

    /**
     * 标题控件数据刷新
     *
     * @param headingNodeView 刷新的新数据
     */
    public func refreshHeadingData(headingNodeView: NodeView): Unit {
        this.headingNodeView = headingNodeView
        let refreshNodeViewChildren = headingNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let headingNodeViewListSize: Int64 = headingNodeViewList.size // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > 0) {
            isRefresh = true
        }
        if (refreshNodeViewSize > headingNodeViewListSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            refreshHeadingDatas(headingNodeViewListSize, refreshNodeViewChildren)
            // 循环添加新数据
            for (i in headingNodeViewListSize..refreshNodeViewSize) {
                headingNodeViewList.append(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == headingNodeViewListSize) {
            // 新数据等于页面数据
            refreshHeadingDatas(headingNodeViewListSize, refreshNodeViewChildren)
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            refreshHeadingDatas(refreshNodeViewSize, refreshNodeViewChildren)
            // 循环删除多余的旧数据
            for (i in headingNodeViewListSize - 1..=refreshNodeViewSize : -1) {
                headingNodeViewList.remove(i)
            }
        }
        if (headingNodeViewList.size == 1 && (headingNodeViewList[0].nodeType == "Link" || headingNodeViewList[0].nodeType == "HeadLink")) {
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
    func refreshHeadingDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = headingNodeViewList[i]
            let newBlockHash = refreshNodeView.nodeHash
            let oldBlockHash = dataSourceNode.nodeHash
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            // 唯一ID是否相同
            if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                headingNodeViewList[i] = refreshNodeView
            } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                headingNodeViewList[i] = refreshNodeView
            } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                headingNodeViewList[i] = refreshNodeView
            }
        }
    }
}
