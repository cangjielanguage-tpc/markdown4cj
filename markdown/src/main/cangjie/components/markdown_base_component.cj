package markdown.components

import ohos.state_macro_manage.*

/**
 * 广告布局
 *
 * @param nodeView NodeView
 */
@Builder
func ADBuilder(nodeView: NodeView) { /* cjlint-ignore !G.FUN.02 */
    Text("")
}

/**
 * 视频布局
 *
 * @param nodeView NodeView
 * @param markdownTheme MarkdownTheme
 * @param videoCallback 视频点击事件
 * @param videoImageCallback 视频的图片替换回调
 * @param videoReleaseCallback 视频发布的点击事件
 * @param videoDownloadCallback 视频下载的点击事件
 */
@Builder
func VideoBuilder(nodeView: NodeView, markdownTheme: MarkdownTheme, videoCallback: (String) -> Unit, videoImageCallback: (String, (String, Float64, Int64) -> Unit) -> Unit, videoReleaseCallback: ?(String) -> Unit, videoDownloadCallback: ?(String) -> Unit) {
    MarkdownVideoComponent(
        markdownTheme: markdownTheme,
        nodeView: nodeView,
        videoCallback: videoCallback,
        videoImageCallback: videoImageCallback,
        videoReleaseCallback: videoReleaseCallback,
        videoDownloadCallback: videoDownloadCallback
    )
}

/**
 * 音频布局
 *
 * @param nodeView NodeView
 * @param markdownTheme MarkdownTheme
 * @param audioCallback 音频的点击事件
 */
@Builder
func AudioBuilder(nodeView: NodeView, markdownTheme: MarkdownTheme, audioCallback: ?(String) -> Unit) {
    MarkdownAudioComponent(
        markdownTheme: markdownTheme,
        nodeView: nodeView,
        audioCallback: audioCallback
    )
}

/**
 * 自定义块结构布局
 *
 * @param nodeView NodeView
 * @param idx 数组下标
 */
@Builder
func CustomBlockBuilder(nodeView: NodeView, idx: Int64) { /* cjlint-ignore !G.FUN.02 */
    Text("")
}

/**
 * 自定义标题内部布局
 *
 * @param nodeView NodeView
 * @param idx 数组下标
 */
@Builder
func CustomHeadingLineBuilder(nodeView: NodeView, idx: Int64) { /* cjlint-ignore !G.FUN.02 */
    Span("")
}

/**
 * 自定义段落内部布局
 *
 * @param nodeView NodeView
 * @param idx 数组下标
 */
@Builder
func CustomParagraphLineBuilder(nodeView: NodeView, idx: Int64) { /* cjlint-ignore !G.FUN.02 */
    Span("")
}

/**
 * 自定义表格内部布局
 *
 * @param nodeView NodeView
 * @param idx 数组下标
 */
@Builder
func CustomTableLineBuilder(nodeView: NodeView, idx: Int64) { /* cjlint-ignore !G.FUN.02 */
    Span("")
}

/**
 * 图片占位图
 *
 * @param imageResource 占位图图片
 * @param imageMarginTop 占位图上边距
 * @param imageMarginBottom 占位图下边距
 * @param placeholderWidth 占位图宽度
 * @param placeholderHeight 占位图高度
 * @param placeholderRadius 占位图圆角
 */
@Builder
func imageSpanPlaceholderComponent(
    imageResource: AppResource,
    imageMarginTop: Float64,
    imageMarginRight: Float64,
    imageMarginBottom: Float64,
    imageMarginLeft: Float64,
    placeholderWidth: Float64,
    placeholderHeight: Float64,
    placeholderRadiusTopLeft: Float64,
    placeholderRadiusTopRight: Float64,
    placeholderRadiusBottomLeft: Float64,
    placeholderRadiusBottomRight: Float64,
    imageBorderWidth: Float64,
    imageBorderColor: Color,
    imageBorderStyle: BorderStyle
) {
    ImageSpan(imageResource)
        .margin(top: imageMarginTop, right: imageMarginRight, bottom: imageMarginBottom, left: imageMarginLeft)
        .borderRadius(topLeft: placeholderRadiusTopLeft, topRight: placeholderRadiusTopRight, bottomLeft: placeholderRadiusBottomLeft, bottomRight: placeholderRadiusBottomRight)
        .borderWidth(imageBorderWidth)
        .borderColor(imageBorderColor)
        .borderStyle(imageBorderStyle)
        .width(placeholderWidth.px)
        .height(placeholderHeight.px)
        .objectFit(ImageFit.Cover)
        .verticalAlign(ImageSpanAlignment.CENTER)
        .constraintSize(maxWidth: 100.percent)
}

/**
 * 图片占位图
 *
 * @param imageResource 占位图图片
 * @param placeholderWidth 图片宽度
 * @param placeholderHeight 图片高度
 * @param placeholderRadiusTopLeft 图片左上圆角
 * @param placeholderRadiusTopRight 图片右上圆角
 * @param placeholderRadiusBottomLeft 图片左下圆角
 * @param placeholderRadiusBottomRight 图片右下圆角
 * @param imageBorderWidth 占位图边框宽度
 * @param imageBorderColor 占位图边框颜色
 * @param imageBorderStyle 占位图边框样式
 */
@Builder
func imagePlaceholderComponent(
    imageResource: AppResource,
    placeholderWidth: Float64,
    placeholderHeight: Float64,
    placeholderRadiusTopLeft: Float64,
    placeholderRadiusTopRight: Float64,
    placeholderRadiusBottomLeft: Float64,
    placeholderRadiusBottomRight: Float64,
    imageBorderWidth: Float64,
    imageBorderColor: Color,
    imageBorderStyle: BorderStyle
) {
    Image(imageResource)
        .borderRadius(topLeft: placeholderRadiusTopLeft, topRight: placeholderRadiusTopRight, bottomLeft: placeholderRadiusBottomLeft, bottomRight: placeholderRadiusBottomRight)
        .borderWidth(imageBorderWidth)
        .borderColor(imageBorderColor)
        .borderStyle(imageBorderStyle)
        .width(placeholderWidth.px)
        .height(placeholderHeight.px)
        .objectFit(ImageFit.Cover)
        .constraintSize(maxWidth: 100.percent)
}

/**
 * 组合代码
 */
@Builder
func blockCodeBlockListComponent(
    markdownConfiguration: MarkdownConfiguration,
    item: NodeView,
    res: (ArrayList<String>, ArrayList<String>, ArrayList<String>)
) {
    MarkdownCodeBlockListComponent(
        markdownConfiguration: markdownConfiguration,
        nodeView: item,
        strInfos: res[0],
        strText: res[1],
        strInfoText: res[2]
    )
}

/**
 * 行号文本显示
 */
@Builder
func codeBlockTextComponent(str: String, markdownConfiguration: MarkdownConfiguration) {
    Row() {
        Text(str)
            .fontFamily(codeTypeTextFontFamily(markdownConfiguration.markdownTheme))
            .fontSize(codeTypeTextFontSize(markdownConfiguration.markdownTheme))
            .fontWeight(codeTypeTextFontWeight(markdownConfiguration.markdownTheme))
            .fontStyle(codeTypeTextFontStyle(markdownConfiguration.markdownTheme))
            .fontColor(codeTypeTextFontColor(markdownConfiguration.markdownTheme))
            .lineHeight(codeTypeTextLineHeight(markdownConfiguration.markdownTheme))
            .textOverflow(TextOverflow.Ellipsis)
            .maxLines(1)
    }
    .width(30.percent)
    .justifyContent(FlexAlign.Start)
    .margin(left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTypeTextMarginLeft)
}

/**
 * 链接, TOC列表链接
 */
@Builder
func spanLinkComponent(
    spanListNodeView: NodeView,
    spanListMarkdownConfiguration: MarkdownConfiguration,
    spanListTocListOnClick: ?(Int64) -> Unit,
    spanListFootnoteCallback: (String) -> Unit,
    isOneLink: Bool
) {
    if ((spanListNodeView.isBulletList || spanListNodeView.isOrderedList || spanListNodeView.isQuote || spanListNodeView.isDescList) && isOneLink && !spanListMarkdownConfiguration.markdownTheme.linkTheme.linkListIsIcon) {
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
}

/**
 * Image：图片节点， StyleImage：图片Style节点，ImageHtmlNode：HTML图片
 */
@Builder
func spanImageComponent(
    spanListNodeView: NodeView,
    spanListMarkdownConfiguration: MarkdownConfiguration,
    spanListComponentWidth: Float64,
    spanListImageCallback: (String) -> Unit
) {
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
            // url
            MarkdownSpanImageUrlComponent(
                urlMarkdownTheme: spanListMarkdownConfiguration.markdownTheme,
                urlDestination: spanListNodeView.imageUrl(),
                urlComponentWidth: spanListComponentWidth,
                urlImageCallback: spanListImageCallback,
                urlLinkCallback: spanListMarkdownConfiguration.linkCallback,
                urlLink: spanListNodeView.isLink,
                urlLinkUrl: spanListNodeView.linkUrl,
                urlImageWidth: spanListNodeView.imageWidth,
                urlImageHeight: spanListNodeView.imageHeight,
                urlImageRadius: spanListNodeView.imageRadius,
                urlImageAlign: spanListNodeView.imageAlign
            )
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
            // url
            MarkdownSpanImageCallbackUrlComponent(
                urlCallbackMarkdownTheme: spanListMarkdownConfiguration.markdownTheme,
                urlCallbackDestination: spanListNodeView.imageUrl(),
                urlCallbackComponentWidth: spanListComponentWidth,
                urlCallbackImageCallbackCallback: spanListMarkdownConfiguration.imageCallbackCallback(),
                urlCallbackImageCallback: spanListImageCallback,
                urlCallbackLinkCallback: spanListMarkdownConfiguration.linkCallback,
                urlCallbackLink: spanListNodeView.isLink,
                urlCallbackLinkUrl: spanListNodeView.linkUrl,
                urlCallbackImageWidth: spanListNodeView.imageWidth,
                urlCallbackImageHeight: spanListNodeView.imageHeight,
                urlCallbackImageRadius: spanListNodeView.imageRadius,
                urlCallbackImageAlign: spanListNodeView.imageAlign
            )
        }
    }
}
