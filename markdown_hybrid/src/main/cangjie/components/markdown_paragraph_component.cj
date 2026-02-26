/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 段落控件
 */
@Component
class MarkdownParagraphComponent {
    /**
     * markdown配置
     */
    var paragraphMarkdownConfiguration: MarkdownConfiguration

    /**
     * 段落控件自身节点
     */
    @Prop
    var paragraphNodeView: NodeView

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var paragraphComponentWidth: Float64

    /**
     * 缓存的段落控件数据
     */
    var paragraphComponents: HashMap<Int64, MarkdownParagraphComponent>

    /**
     * 自定义行内段落控件
     */
    @BuilderParam
    var paragraphCustomParagraphLineBuilder: (NodeView, Int64) -> Unit

    /**
     * TOC列表点击事件
     */
    var paragraphTocListOnClick: (Int64) -> Unit

    /**
     * 图片点击事件
     */
    var paragraphImageCallback: (String) -> Unit

    /**
     * 脚注点击事件
     */
    var paragraphFootnoteCallback: (String) -> Unit

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
    var paragraphNodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

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
            if (paragraphNodeViewList.size == 1 && !paragraphMarkdownConfiguration.markdownTheme.isImageMixedLayout && (paragraphNodeViewList[0].nodeType == "Image" || paragraphNodeViewList[0].nodeType == "StyleImage" || paragraphNodeViewList[0].nodeType == "ImageHtmlNode")) {
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
                    .fontSize(paragraphMarkdownConfiguration.markdownTheme.paragraphTextSize)
                    .fontWeight(FontWeight.W400)
                    .fontColor(paragraphMarkdownConfiguration.markdownTheme.paragraphTextColor)
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
        .interopCopyOption(if (paragraphMarkdownConfiguration.markdownTheme.isOnCopy) {
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
                    .fontSize(paragraphMarkdownConfiguration.markdownTheme.paragraphTextSize)
                    .fontWeight(FontWeight.W400)
                    .fontColor(paragraphMarkdownConfiguration.markdownTheme.paragraphTextColor)
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
        .copyOption(if (paragraphMarkdownConfiguration.markdownTheme.isOnCopy) {
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
                        spanListFootnoteCallback
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
                            spanListFootnoteCallback
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
            return
        }
        if (refreshNodeViewSize > 0) {
            isRefresh = true
        }
        if (refreshNodeViewSize > paragraphNodeViewListSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            refreshParagraphDatas(paragraphNodeViewListSize, refreshNodeViewChildren)
            // 循环添加新数据
            for (i in paragraphNodeViewListSize..refreshNodeViewSize) {
                paragraphNodeViewList.append(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == paragraphNodeViewListSize) {
            // 新数据等于页面数据
            refreshParagraphDatas(paragraphNodeViewListSize, refreshNodeViewChildren)
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            refreshParagraphDatas(refreshNodeViewSize, refreshNodeViewChildren)
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
            let newBlockHash = refreshNodeView.nodeHash
            let oldBlockHash = dataSourceNode.nodeHash
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            // 唯一ID是否相同
            if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                paragraphNodeViewList[i] = refreshNodeView
            } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                paragraphNodeViewList[i] = refreshNodeView
            } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                paragraphNodeViewList[i] = refreshNodeView
            }
        }
    }
}
