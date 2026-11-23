package markdown.components

import ohos.hilog.Hilog
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
        .interopBorderRadius(placeholderRadiusTopLeft, placeholderRadiusTopRight, placeholderRadiusBottomLeft, placeholderRadiusBottomRight)
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
 * 链接图标
 *
 * @param spanLinkNodeView NodeView
 * @param spanLinkIconMargin 图标左右边距
 * @param spanLinkIconVisible 图标是否可见
 * @param spanLinkLinkCallback 链接点击事件
 */
@Builder
func spanLinkIconComponent(
    spanLinkNodeView: NodeView,
    spanLinkIconMargin: Length,
    spanLinkIconVisible: Bool,
    spanLinkLinkCallback: ?(String) -> Unit
) {
    ImageSpan(spanLinkNodeView.linkIconPixelMap())
        .width(spanLinkNodeView.linkIconWidth.px)
        .height(spanLinkNodeView.linkIconHeight.px)
        .objectFit(ImageFit.Contain)
        .constraintSize(maxWidth: 100.percent)
        .verticalAlign(ImageSpanAlignment.CENTER)
        .visibility(isVisibility(spanLinkIconVisible))
        .margin(right: spanLinkIconMargin, left: spanLinkIconMargin)
        .onClick {
            evt => if (spanLinkLinkCallback.isSome()) {
                spanLinkLinkCallback()(spanLinkNodeView.linkUrl())
            }
        }
}

/**
 * 链接, TOC列表链接
 *
 * @param spanListNodeView NodeView
 * @param spanListMarkdownConfiguration markdown配置
 * @param spanListTocListOnClick TOC点击事件
 * @param spanListFootnoteCallback 脚注点击事件
 * @param isOneLink 是否只有一条链接数据
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
                // 圆角矩形图片链接
                if (spanListNodeView.linkIconPixelMap.isSome() && spanListNodeView.linkIconWidth > 0.0 && spanListNodeView.linkIconHeight > 0.0) {
                    spanLinkIconComponent(
                        spanListNodeView,
                        spanListMarkdownConfiguration.markdownTheme.linkTheme.linkRectIconMargin,
                        true,
                        spanListMarkdownConfiguration.linkCallback
                    )
                } else {
                    // 链接图标未加载完成时显示链接文本
                    markdownSpanComponent(
                        spanListMarkdownConfiguration,
                        spanListNodeView,
                        spanListTocListOnClick,
                        spanListFootnoteCallback,
                        false
                    )
                }
            } else if (spanListNodeView.nodeText.trimAscii().toRuneArray().size == 1) {
                // 圆形图片链接
                if (spanListNodeView.linkIconPixelMap.isSome() && spanListNodeView.linkIconWidth > 0.0 && spanListNodeView.linkIconHeight > 0.0) {
                    spanLinkIconComponent(
                        spanListNodeView,
                        spanListMarkdownConfiguration.markdownTheme.linkTheme.linkCircleIconMargin,
                        true,
                        spanListMarkdownConfiguration.linkCallback
                    )
                } else {
                    // 链接图标未加载完成时显示链接文本
                    markdownSpanComponent(
                        spanListMarkdownConfiguration,
                        spanListNodeView,
                        spanListTocListOnClick,
                        spanListFootnoteCallback,
                        false
                    )
                }
            }
        } else {
            if (spanListNodeView.nodeText.trimAscii().toRuneArray().size >= 1) {
                // 空心圆角矩形图片链接
                if (spanListNodeView.linkIconPixelMap.isSome() && spanListNodeView.linkIconWidth > 0.0 && spanListNodeView.linkIconHeight > 0.0) {
                    spanLinkIconComponent(
                        spanListNodeView,
                        spanListMarkdownConfiguration.markdownTheme.linkTheme.linkRectToolIconMargin,
                        urlSafeBase64Decode(spanListNodeView.linkUrl()) != "",
                        spanListMarkdownConfiguration.linkCallback
                    )
                } else {
                    // 链接图标未加载完成时显示链接文本
                    markdownSpanComponent(
                        spanListMarkdownConfiguration,
                        spanListNodeView,
                        spanListTocListOnClick,
                        spanListFootnoteCallback,
                        false
                    )
                }
            }
        }
    }
}

/**
 * 已解析PixelMap的行内图片
 *
 * @param spanImageNodeView NodeView
 * @param spanImageTheme markdown样式
 * @param spanImagePixelMapData 图片PixelMap
 * @param spanImageWidth 图片宽度 - 单位px
 * @param spanImageHeight 图片高度 - 单位px
 * @param spanImageLinkCallback 链接点击事件
 * @param spanImageImageCallback 图片点击事件
 */
@Builder
func spanImagePixelMapComponent(
    spanImageNodeView: NodeView,
    spanImageTheme: MarkdownTheme,
    spanImagePixelMapData: PixelMap,
    spanImageWidth: Float64,
    spanImageHeight: Float64,
    spanImageLinkCallback: ?(String) -> Unit,
    spanImageImageCallback: (String) -> Unit
) {
    ImageSpan(spanImagePixelMapData)
        .margin(top: spanImageTheme.imageTheme.imageMarginTop, right: spanImageTheme.imageTheme.imageMarginRight, bottom: spanImageTheme.imageTheme.imageMarginBottom, left: spanImageTheme.imageTheme.imageMarginLeft)
        .interopBorderRadius(spanImageNodeView.spanImageRadiusTopLeft, spanImageNodeView.spanImageRadiusTopRight, spanImageNodeView.spanImageRadiusBottomLeft, spanImageNodeView.spanImageRadiusBottomRight)
        .borderWidth(spanImageTheme.imageTheme.imageBorderWidth)
        .borderColor(spanImageTheme.imageTheme.imageBorderColor)
        .borderStyle(spanImageTheme.imageTheme.imageBorderStyle)
        .width(spanImageWidth.px)
        .height(spanImageHeight.px)
        .objectFit(spanImageTheme.imageTheme.imageFitType)
        .verticalAlign(ImageSpanAlignment.CENTER)
        .constraintSize(maxWidth: 100.percent)
        .onClick {
            evt => imageSpanOnClick(spanImageNodeView.isLink, spanImageImageCallback, spanImageLinkCallback, spanImageNodeView.linkUrl, spanImageNodeView.imageUrl())
        }
}

/**
 * 行内图片占位图
 *
 * @param spanImageNodeView NodeView
 * @param spanImageTheme markdown样式
 */
@Builder
func spanImagePlaceholderComponent(spanImageNodeView: NodeView, spanImageTheme: MarkdownTheme) {
    imageSpanPlaceholderComponent(
        spanImageTheme.imageTheme.imagePlaceholder(),
        spanImageTheme.imageTheme.imageMarginTop,
        spanImageTheme.imageTheme.imageMarginRight,
        spanImageTheme.imageTheme.imageMarginBottom,
        spanImageTheme.imageTheme.imageMarginLeft,
        spanImageNodeView.spanImagePlaceholderWidth,
        spanImageNodeView.spanImagePlaceholderHeight,
        spanImageNodeView.spanImageRadiusTopLeft,
        spanImageNodeView.spanImageRadiusTopRight,
        spanImageNodeView.spanImageRadiusBottomLeft,
        spanImageNodeView.spanImageRadiusBottomRight,
        spanImageTheme.imageTheme.imageBorderWidth,
        spanImageTheme.imageTheme.imageBorderColor,
        spanImageTheme.imageTheme.imageBorderStyle
    )
}

/**
 * url图片渲染宽度：主图加载完成后用实际宽度，未完成且占位图已解析时用占位图宽度
 *
 * @param spanImageNodeView NodeView
 * @return Float64 渲染宽度 - 单位px
 */
func spanImageUrlRenderWidth(spanImageNodeView: NodeView): Float64 {
    if (spanImageNodeView.spanImageAltPixelMap.isSome() && spanImageNodeView.spanImageLoadType != 1) {
        return spanImageNodeView.spanImagePlaceholderWidth
    }
    return spanImageNodeView.spanImageWidth
}

/**
 * url图片渲染高度：主图加载完成后用实际高度，未完成且占位图已解析时用占位图高度
 *
 * @param spanImageNodeView NodeView
 * @return Float64 渲染高度 - 单位px
 */
func spanImageUrlRenderHeight(spanImageNodeView: NodeView): Float64 {
    if (spanImageNodeView.spanImageAltPixelMap.isSome() && spanImageNodeView.spanImageLoadType != 1) {
        return spanImageNodeView.spanImagePlaceholderHeight
    }
    return spanImageNodeView.spanImageHeight
}

/**
 * url入参的行内图片
 *
 * @param spanImageNodeView NodeView
 * @param spanImageTheme markdown样式
 * @param spanImageLinkCallback 链接点击事件
 * @param spanImageImageCallback 图片点击事件
 * @param spanImageOnAsyncUpdated 异步结果写回后的刷新通知
 */
@Builder
func spanImageUrlLoadComponent(
    spanImageNodeView: NodeView,
    spanImageTheme: MarkdownTheme,
    spanImageLinkCallback: ?(String) -> Unit,
    spanImageImageCallback: (String) -> Unit,
    spanImageOnAsyncUpdated: () -> Unit
) {
    if (spanImageNodeView.spanImageAltPixelMap.isSome()) {
        // 占位图解析完成：主图加载前通过alt显示占位图
        ImageSpan(spanImageNodeView.imageUrl())
            .alt(spanImageNodeView.spanImageAltPixelMap())
            .margin(top: spanImageTheme.imageTheme.imageMarginTop, right: spanImageTheme.imageTheme.imageMarginRight, bottom: spanImageTheme.imageTheme.imageMarginBottom, left: spanImageTheme.imageTheme.imageMarginLeft)
            .interopBorderRadius(spanImageNodeView.spanImageRadiusTopLeft, spanImageNodeView.spanImageRadiusTopRight, spanImageNodeView.spanImageRadiusBottomLeft, spanImageNodeView.spanImageRadiusBottomRight)
            .borderWidth(spanImageTheme.imageTheme.imageBorderWidth)
            .borderColor(spanImageTheme.imageTheme.imageBorderColor)
            .borderStyle(spanImageTheme.imageTheme.imageBorderStyle)
            .width(spanImageUrlRenderWidth(spanImageNodeView).px)
            .height(spanImageUrlRenderHeight(spanImageNodeView).px)
            .objectFit(spanImageTheme.imageTheme.imageFitType)
            .verticalAlign(ImageSpanAlignment.CENTER)
            .constraintSize(maxWidth: 100.percent)
            .onClick {
                evt => imageSpanOnClick(spanImageNodeView.isLink, spanImageImageCallback, spanImageLinkCallback, spanImageNodeView.linkUrl, spanImageNodeView.imageUrl())
            }
            .onComplete {
                imageLoadResult =>
                    let res = imageWidthAndHeight(
                        spanImageNodeView.spanImageComponentWidth,
                        imageLoadResult.width,
                        imageLoadResult.height,
                        spanImageNodeView.spanImageThemeWidth,
                        spanImageNodeView.spanImageThemeHeight,
                        spanImageTheme.imageTheme.imageMaxWidth,
                        spanImageTheme.imageTheme.imageMaxHeight,
                        spanImageTheme.imageTheme.imageFixedRatioWidth,
                        spanImageTheme.imageTheme.imageMaximumWidth
                    )
                    var changed = false
                    if (spanImageNodeView.spanImageWidth != res[0] || spanImageNodeView.spanImageHeight != res[1]) {
                        spanImageNodeView.spanImageWidth = res[0]
                        spanImageNodeView.spanImageHeight = res[1]
                        changed = true
                    }
                    if (spanImageNodeView.spanImageLoadType != 1) {
                        spanImageNodeView.spanImageLoadType = 1
                        changed = true
                    }
                    if (changed) {
                        spanImageNodeView.spanRenderVersion += 1 // 版本号自增，使该节点item重建更新主图宽高
                        spanImageOnAsyncUpdated()
                    }
            }
            .onError {
                imageError => if (spanImageNodeView.spanImageLoadType != 2) {
                    spanImageNodeView.spanImageLoadType = 2
                    spanImageOnAsyncUpdated()
                }
            }
    } else {
        // 占位图未解析完成：主图直接渲染
        ImageSpan(spanImageNodeView.imageUrl())
            .margin(top: spanImageTheme.imageTheme.imageMarginTop, right: spanImageTheme.imageTheme.imageMarginRight, bottom: spanImageTheme.imageTheme.imageMarginBottom, left: spanImageTheme.imageTheme.imageMarginLeft)
            .interopBorderRadius(spanImageNodeView.spanImageRadiusTopLeft, spanImageNodeView.spanImageRadiusTopRight, spanImageNodeView.spanImageRadiusBottomLeft, spanImageNodeView.spanImageRadiusBottomRight)
            .borderWidth(spanImageTheme.imageTheme.imageBorderWidth)
            .borderColor(spanImageTheme.imageTheme.imageBorderColor)
            .borderStyle(spanImageTheme.imageTheme.imageBorderStyle)
            .width(spanImageUrlRenderWidth(spanImageNodeView).px)
            .height(spanImageUrlRenderHeight(spanImageNodeView).px)
            .objectFit(spanImageTheme.imageTheme.imageFitType)
            .verticalAlign(ImageSpanAlignment.CENTER)
            .constraintSize(maxWidth: 100.percent)
            .onClick {
                evt => imageSpanOnClick(spanImageNodeView.isLink, spanImageImageCallback, spanImageLinkCallback, spanImageNodeView.linkUrl, spanImageNodeView.imageUrl())
            }
            .onComplete {
                imageLoadResult =>
                    let res = imageWidthAndHeight(
                        spanImageNodeView.spanImageComponentWidth,
                        imageLoadResult.width,
                        imageLoadResult.height,
                        spanImageNodeView.spanImageThemeWidth,
                        spanImageNodeView.spanImageThemeHeight,
                        spanImageTheme.imageTheme.imageMaxWidth,
                        spanImageTheme.imageTheme.imageMaxHeight,
                        spanImageTheme.imageTheme.imageFixedRatioWidth,
                        spanImageTheme.imageTheme.imageMaximumWidth
                    )
                    var changed = false
                    if (spanImageNodeView.spanImageWidth != res[0] || spanImageNodeView.spanImageHeight != res[1]) {
                        spanImageNodeView.spanImageWidth = res[0]
                        spanImageNodeView.spanImageHeight = res[1]
                        changed = true
                    }
                    if (spanImageNodeView.spanImageLoadType != 1) {
                        spanImageNodeView.spanImageLoadType = 1
                        changed = true
                    }
                    if (changed) {
                        spanImageNodeView.spanRenderVersion += 1 // 版本号自增，使该节点item重建更新主图宽高
                        spanImageOnAsyncUpdated()
                    }
            }
            .onError {
                imageError => if (spanImageNodeView.spanImageLoadType != 2) {
                    spanImageNodeView.spanImageLoadType = 2
                    spanImageOnAsyncUpdated()
                }
            }
    }
}

/**
 * Image：图片节点， StyleImage：图片Style节点，ImageHtmlNode：HTML图片
 *
 * @param spanListNodeView NodeView
 * @param spanListMarkdownConfiguration markdown配置
 * @param spanListImageCallback 图片点击事件
 * @param spanOnAsyncUpdated 异步结果写回后的刷新通知
 */
@Builder
func spanImageComponent(
    spanListNodeView: NodeView,
    spanListMarkdownConfiguration: MarkdownConfiguration,
    spanListImageCallback: (String) -> Unit,
    spanOnAsyncUpdated: () -> Unit
) {
    if (spanListMarkdownConfiguration.imageReplaceCallback.isNone()) {
        // 没有图片替换回调接口
        if (spanListNodeView.imageUrl().startsWith("./")) {
            // 本地图片
            if (spanListNodeView.spanImageLoadType == 1) {
                // 加载图片
                spanImagePixelMapComponent(
                    spanListNodeView,
                    spanListMarkdownConfiguration.markdownTheme,
                    spanListNodeView.spanImagePixelMap(),
                    spanListNodeView.spanImageWidth,
                    spanListNodeView.spanImageHeight,
                    spanListMarkdownConfiguration.linkCallback,
                    spanListImageCallback
                )
            }
            if (spanListMarkdownConfiguration.markdownTheme.imageTheme.imagePlaceholder.isSome() && spanListNodeView.spanImageLoadType != 1) {
                // 图片占位图
                spanImagePlaceholderComponent(spanListNodeView, spanListMarkdownConfiguration.markdownTheme)
            }
        } else {
            // URL图片
            spanImageUrlLoadComponent(
                spanListNodeView,
                spanListMarkdownConfiguration.markdownTheme,
                spanListMarkdownConfiguration.linkCallback,
                spanListImageCallback,
                spanOnAsyncUpdated
            )
        }
    } else {
        // 有图片替换回调接口
        if (spanListNodeView.imageUrl().startsWith("./")) {
            // 本地图片
            if (spanListNodeView.imageReplacePixelMap.isSome()) {
                // 替换之后的图片
                spanImagePixelMapComponent(
                    spanListNodeView,
                    spanListMarkdownConfiguration.markdownTheme,
                    spanListNodeView.imageReplacePixelMap(),
                    spanListNodeView.imageReplaceWidth(),
                    spanListNodeView.imageReplaceHeight(),
                    spanListMarkdownConfiguration.linkCallback,
                    spanListImageCallback
                )
            } else {
                if (spanListNodeView.spanImageLoadType == 1) {
                    // 加载图片
                    spanImagePixelMapComponent(
                        spanListNodeView,
                        spanListMarkdownConfiguration.markdownTheme,
                        spanListNodeView.spanImagePixelMap(),
                        spanListNodeView.spanImageWidth,
                        spanListNodeView.spanImageHeight,
                        spanListMarkdownConfiguration.linkCallback,
                        spanListImageCallback
                    )
                }
                if (spanListMarkdownConfiguration.markdownTheme.imageTheme.imagePlaceholder.isSome() && spanListNodeView.spanImageLoadType != 1) {
                    // 图片占位图
                    spanImagePlaceholderComponent(spanListNodeView, spanListMarkdownConfiguration.markdownTheme)
                }
            }
        } else {
            if (spanListNodeView.imageReplacePixelMap.isSome()) {
                // 替换之后的图片
                spanImagePixelMapComponent(
                    spanListNodeView,
                    spanListMarkdownConfiguration.markdownTheme,
                    spanListNodeView.imageReplacePixelMap(),
                    spanListNodeView.imageReplaceWidth(),
                    spanListNodeView.imageReplaceHeight(),
                    spanListMarkdownConfiguration.linkCallback,
                    spanListImageCallback
                )
            } else {
                spanImageUrlLoadComponent(
                    spanListNodeView,
                    spanListMarkdownConfiguration.markdownTheme,
                    spanListMarkdownConfiguration.linkCallback,
                    spanListImageCallback,
                    spanOnAsyncUpdated
                )
            }
        }
    }
}

/**
 * 行内数学公式默认文本
 *
 * @param spanListNodeView NodeView
 * @param spanListMarkdownConfiguration markdown配置
 */
@Builder
func spanLatexDefaultTextComponent(spanListNodeView: NodeView, spanListMarkdownConfiguration: MarkdownConfiguration) {
    Span(spanListNodeView.nodeText)
        .fontFamily(spanListMarkdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontFamily)
        .fontSize(spanListMarkdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontSize)
        .fontWeight(spanListMarkdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontWeight)
        .fontStyle(spanListMarkdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontStyle)
        .fontColor(spanListMarkdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultTextFontColor)
}

/**
 * 行内数学公式
 *
 * @param spanListNodeView NodeView
 * @param spanListMarkdownConfiguration markdown配置
 */
@Builder
func spanLatexMathComponent(spanListNodeView: NodeView, spanListMarkdownConfiguration: MarkdownConfiguration) {
    if (spanListNodeView.latexParserEnd) {
        if (spanListNodeView.latexPixelMap.isSome() && spanListNodeView.latexImageHeight > 0.0 && spanListNodeView.latexImageWidth > 0.0 && spanListNodeView.latexImageData.isSome()) {
            // 数学公式图片
            ImageSpan(spanListNodeView.latexPixelMap())
                .width(spanListNodeView.latexImageWidth.px)
                .height(spanListNodeView.latexImageHeight.px)
                .objectFit(ImageFit.Contain)
                .constraintSize(maxWidth: 100.percent)
                .verticalAlign(ImageSpanAlignment.CENTER)
                .onClick {
                    evt => if (spanListNodeView.isLink) {
                        if (spanListMarkdownConfiguration.linkCallback.isSome() && spanListNodeView.linkUrl.isSome()) {
                            spanListMarkdownConfiguration.linkCallback()(spanListNodeView.linkUrl())
                        }
                    } else {
                        latexImageOnClick(spanListNodeView.latexImageData(), spanListNodeView.latexImageHeight.px, spanListNodeView.latexImageWidth.px, spanListMarkdownConfiguration.latexImageCallback)
                    }
                }
        } else {
            // 解析失败显示公式默认文本
            spanLatexDefaultTextComponent(spanListNodeView, spanListMarkdownConfiguration)
        }
    } else {
        if (spanListMarkdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultText) {
            // 解析中显示公式默认文本
            spanLatexDefaultTextComponent(spanListNodeView, spanListMarkdownConfiguration)
        }
    }
}

/**
 * 释放Span列表中各节点持有的行内异步PixelMap（UI销毁或数据替换时调用）
 *
 * @param spanListNodeViewList NodeView列表
 */
func releaseSpanListPixelMaps(spanListNodeViewList: ObservedArrayList<NodeView>): Unit {
    for (i in 0..spanListNodeViewList.size) {
        spanListNodeViewList[i].releaseSpanPixelMaps()
    }
}

/**
 * 行内Span异步资源解析：由Text容器组件统一发起，解析结果写回NodeView后通知刷新
 * 参照ArkTS MarkdownParagraph.ets的容器统一解析模式
 *
 * @param spanListNodeViewList NodeView列表
 * @param spanListMarkdownConfiguration markdown配置
 * @param spanListComponentWidth 最大宽度 - 单位vp
 * @param spanListIsOneLink 是否只有一条链接数据
 * @param spanOnAsyncUpdated 异步结果写回后的刷新通知
 */
func refreshSpanAsyncResources(
    spanListNodeViewList: ObservedArrayList<NodeView>,
    spanListMarkdownConfiguration: MarkdownConfiguration,
    spanListComponentWidth: Float64,
    spanListIsOneLink: Bool,
    spanOnAsyncUpdated: () -> Unit
): Unit {
    for (i in 0..spanListNodeViewList.size) {
        let spanListNodeView = spanListNodeViewList[i]
        Hilog.error(1, "MDDBG", "spanRes idx=${i} type=${spanListNodeView.nodeType}")
        if (spanListNodeView.nodeType == "Link" || spanListNodeView.nodeType == "HeadLink") {
            // 链接, TOC列表链接
            refreshSpanLinkIcon(spanListNodeView, spanListMarkdownConfiguration, spanListIsOneLink, spanOnAsyncUpdated)
        } else if (spanListNodeView.nodeType == "LatexMathNode") {
            // 数学公式
            refreshSpanLatexMath(spanListNodeView, spanListMarkdownConfiguration, spanListComponentWidth, spanOnAsyncUpdated)
        } else if (spanListNodeView.nodeType == "Image" || spanListNodeView.nodeType == "StyleImage" || spanListNodeView.nodeType == "ImageHtmlNode") {
            // Image：图片节点， StyleImage：图片Style节点，ImageHtmlNode：HTML图片
            refreshSpanImage(spanListNodeView, spanListMarkdownConfiguration, spanListComponentWidth, spanOnAsyncUpdated)
        }
    }
}

/**
 * 链接图标解析：纯文本链接无图标不解析
 *
 * @param spanLinkNodeView NodeView
 * @param spanLinkMarkdownConfiguration markdown配置
 * @param spanLinkIsOneLink 是否只有一条链接数据
 * @param spanLinkOnAsyncUpdated 异步结果写回后的刷新通知
 */
func refreshSpanLinkIcon(
    spanLinkNodeView: NodeView,
    spanLinkMarkdownConfiguration: MarkdownConfiguration,
    spanLinkIsOneLink: Bool,
    spanLinkOnAsyncUpdated: () -> Unit
): Unit {
    if (spanLinkNodeView.linkIconTried) {
        return
    }
    let linkTheme = spanLinkMarkdownConfiguration.markdownTheme.linkTheme
    if ((spanLinkNodeView.isBulletList || spanLinkNodeView.isOrderedList || spanLinkNodeView.isQuote || spanLinkNodeView.isDescList) && spanLinkIsOneLink && !linkTheme.linkListIsIcon) {
        // 纯文本链接无图标
        return
    }
    spanLinkNodeView.linkIconTried = true
    let linkIconCallback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
        pixelMap, height, width => launch {
            if (pixelMap.isSome() && height.isSome() && width.isSome()) {
                spanLinkNodeView.linkIconPixelMap?.Release()
                spanLinkNodeView.linkIconPixelMap = pixelMap
                spanLinkNodeView.linkIconHeight = height()
                spanLinkNodeView.linkIconWidth = width()
                spanLinkNodeView.spanRenderVersion += 1 // 版本号自增，使该节点item重建显示图标
                spanLinkOnAsyncUpdated()
            }
        }
    }
    if (spanLinkNodeView.linkUrl().startsWith("http://") || spanLinkNodeView.linkUrl().startsWith("https://")) {
        if (spanLinkNodeView.nodeText.trimAscii().toRuneArray().size > 1) {
            // 圆角矩形图片链接
            let linkRectIconTextSize = vp2px(linkTheme.linkRectIconTextSize.vp)().value
            let linkRectIconHeight = vp2px(linkTheme.linkRectIconHeight.vp)().value
            let linkRectIconPadding = vp2px(linkTheme.linkRectIconPadding.vp)().value
            let linkRectIconRadius = vp2px(linkTheme.linkRectIconRadius.vp)().value
            MarkdownParseLinkUtil.linkStrToRectPixelMap(spanLinkNodeView.nodeText.trimAscii(), linkRectIconTextSize, linkRectIconHeight, linkRectIconPadding, linkRectIconRadius, spanLinkMarkdownConfiguration, linkIconCallback)
        } else if (spanLinkNodeView.nodeText.trimAscii().toRuneArray().size == 1) {
            // 圆形图片链接
            let linkCircleIconTextSize = vp2px(linkTheme.linkCircleIconTextSize.vp)().value
            let linkCircleIconRadius = vp2px(linkTheme.linkCircleIconRadius.vp)().value
            MarkdownParseLinkUtil.linkStrToCirclePixelMap(spanLinkNodeView.nodeText.trimAscii(), linkCircleIconTextSize, linkCircleIconRadius, spanLinkMarkdownConfiguration, linkIconCallback)
        }
    } else {
        if (spanLinkNodeView.nodeText.trimAscii().toRuneArray().size >= 1) {
            // 空心圆角矩形图片链接
            let linkRectToolIconTextSize = vp2px(linkTheme.linkRectToolIconTextSize.vp)().value
            let linkRectToolIconHeight = vp2px(linkTheme.linkRectToolIconHeight.vp)().value
            let linkRectToolIconPadding = vp2px(linkTheme.linkRectToolIconPadding.vp)().value
            let linkRectToolIconBorderWidth = vp2px(linkTheme.linkRectToolIconBorderWidth.vp)().value
            let linkRectToolIconDividingLineWidth = vp2px(linkTheme.linkRectToolIconDividingLineWidth.vp)().value
            let linkRectToolIconLineLeftPadding = vp2px(linkTheme.linkRectToolIconLineLeftPadding.vp)().value
            let linkRectToolIconLineRightPadding = vp2px(linkTheme.linkRectToolIconLineRightPadding.vp)().value
            MarkdownParseLinkUtil.linkStrToRectToolPixelMap(spanLinkNodeView.nodeText.trimAscii(), urlSafeBase64Decode(spanLinkNodeView.linkUrl()), linkRectToolIconTextSize, linkRectToolIconHeight, linkRectToolIconPadding, linkRectToolIconBorderWidth, linkRectToolIconDividingLineWidth, linkRectToolIconLineLeftPadding, linkRectToolIconLineRightPadding, spanLinkMarkdownConfiguration, linkIconCallback)
        }
    }
}

/**
 * 行内数学公式解析
 *
 * @param spanLatexNodeView NodeView
 * @param spanLatexMarkdownConfiguration markdown配置
 * @param spanLatexComponentWidth 最大宽度 - 单位vp
 * @param spanLatexOnAsyncUpdated 异步结果写回后的刷新通知
 */
func refreshSpanLatexMath(
    spanLatexNodeView: NodeView,
    spanLatexMarkdownConfiguration: MarkdownConfiguration,
    spanLatexComponentWidth: Float64,
    spanLatexOnAsyncUpdated: () -> Unit
): Unit {
    if (spanLatexNodeView.latexTried) {
        return
    }
    spanLatexNodeView.latexTried = true
    let latexMathTextSize = fp2px(spanLatexMarkdownConfiguration.markdownTheme.latexMathTheme.latexMathTextSize.fp)().value
    let latexComponentWidth = vp2px(spanLatexComponentWidth.vp)().value
    Hilog.error(1, "MDDBG", "latexParse start text=${spanLatexNodeView.nodeText} w=${latexComponentWidth}")
    let latexCallback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit = {
        pixelMap, height, width, arr => launch {
            Hilog.error(1, "MDDBG", "latexParse done pm=${pixelMap.isSome()} w=${width} h=${height}")
            if (pixelMap.isSome() && height.isSome() && width.isSome()) {
                spanLatexNodeView.latexPixelMap?.Release()
                spanLatexNodeView.latexPixelMap = pixelMap
                spanLatexNodeView.latexImageHeight = height()
                spanLatexNodeView.latexImageWidth = width()
            }
            spanLatexNodeView.latexImageData = arr
            spanLatexNodeView.latexParserEnd = true
            spanLatexNodeView.spanRenderVersion += 1 // 版本号自增，使该节点item重建显示公式或默认文本
            spanLatexOnAsyncUpdated()
        }
    }
    MarkdownParseLatexUtil.latexMathStrToPixelMapRow(spanLatexNodeView.nodeText, spanLatexMarkdownConfiguration.markdownTheme, latexMathTextSize, latexComponentWidth, spanLatexMarkdownConfiguration.latexStrCallback, latexCallback)
}

/**
 * 行内图片静态渲染参数与解析
 *
 * @param spanImageNodeView NodeView
 * @param spanImageMarkdownConfiguration markdown配置
 * @param spanImageComponentWidth 最大宽度 - 单位vp
 * @param spanImageOnAsyncUpdated 异步结果写回后的刷新通知
 */
func refreshSpanImage(
    spanImageNodeView: NodeView,
    spanImageMarkdownConfiguration: MarkdownConfiguration,
    spanImageComponentWidthVp: Float64,
    spanImageOnAsyncUpdated: () -> Unit
): Unit {
    let imageTheme = spanImageMarkdownConfiguration.markdownTheme.imageTheme
    // 静态渲染参数仅首次写入（占位图尺寸可能被占位图解析结果修正）
    if (spanImageNodeView.spanImageComponentWidth == 0.0) {
        spanImageNodeView.spanImageComponentWidth = vp2px(spanImageComponentWidthVp.vp)().value
        let radius = imageSpanBorderRadius(spanImageNodeView.imageRadius, imageTheme.imageRadiusTopLeft, imageTheme.imageRadiusTopRight, imageTheme.imageRadiusBottomLeft, imageTheme.imageRadiusBottomRight)
        spanImageNodeView.spanImageRadiusTopLeft = radius[0]
        spanImageNodeView.spanImageRadiusTopRight = radius[1]
        spanImageNodeView.spanImageRadiusBottomLeft = radius[2]
        spanImageNodeView.spanImageRadiusBottomRight = radius[3]
        spanImageNodeView.spanImageThemeWidth = widthHeightLength2FloatPx(spanImageNodeView.imageWidth, imageTheme.imageWidth, spanImageNodeView.spanImageComponentWidth)
        spanImageNodeView.spanImageThemeHeight = widthHeightLength2FloatPx(spanImageNodeView.imageHeight, imageTheme.imageHeight, spanImageNodeView.spanImageComponentWidth)
        // 图片占位图宽度
        spanImageNodeView.spanImagePlaceholderWidth = if (imageTheme.imageFixedRatioWidth.isSome()) {
            spanImageNodeView.spanImageComponentWidth * imageTheme.imageFixedRatioWidth()
        } else {
            spanImageNodeView.spanImageComponentWidth * imageTheme.imageMaximumWidth
        }
        // 图片占位图高度
        spanImageNodeView.spanImagePlaceholderHeight = if (imageTheme.imageFixedRatioWidth.isSome()) {
            spanImageNodeView.spanImageComponentWidth * 9.0 / 16.0 * imageTheme.imageFixedRatioWidth()
        } else {
            spanImageNodeView.spanImageComponentWidth * 9.0 / 16.0 * imageTheme.imageMaximumWidth
        }
    }
    let isLocalImage = spanImageNodeView.imageUrl().startsWith("./")
    let isCallbackImage = spanImageMarkdownConfiguration.imageReplaceCallback.isSome()
    Hilog.error(1, "MDDBG", "imgParse start url=${spanImageNodeView.imageUrl()} local=${isLocalImage} cb=${isCallbackImage} loadType=${spanImageNodeView.spanImageLoadType} w=${spanImageNodeView.spanImageWidth} phW=${spanImageNodeView.spanImagePlaceholderWidth}")
    if (isCallbackImage && !isLocalImage && spanImageNodeView.spanImageWidth == 0.0) {
        // 回调模式URL图片初始渲染尺寸为占位图尺寸
        spanImageNodeView.spanImageWidth = spanImageNodeView.spanImagePlaceholderWidth
        spanImageNodeView.spanImageHeight = spanImageNodeView.spanImagePlaceholderHeight
    }
    if (isCallbackImage && !spanImageNodeView.imageReplaceTried) {
        // 替换图片解析
        spanImageNodeView.imageReplaceTried = true
        let replaceCallback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            imagePixelMap, imageResWidth, imageResHeight => launch {
                if (imagePixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    let res = imageWidthAndHeight(
                        spanImageNodeView.spanImageComponentWidth,
                        imageResWidth(),
                        imageResHeight(),
                        spanImageNodeView.spanImageThemeWidth,
                        spanImageNodeView.spanImageThemeHeight,
                        imageTheme.imageMaxWidth,
                        imageTheme.imageMaxHeight,
                        imageTheme.imageFixedRatioWidth,
                        imageTheme.imageMaximumWidth
                    )
                    spanImageNodeView.imageReplacePixelMap?.Release()
                    spanImageNodeView.imageReplacePixelMap = imagePixelMap
                    spanImageNodeView.imageReplaceWidth = res[0]
                    spanImageNodeView.imageReplaceHeight = res[1]
                    spanImageNodeView.spanRenderVersion += 1 // 版本号自增，使该节点item重建显示替换图片
                    spanImageOnAsyncUpdated()
                }
            }
        }
        MarkdownParseImageUtil.callbackToPixelmap(spanImageNodeView.imageUrl(), spanImageMarkdownConfiguration.imageReplaceCallback(), replaceCallback)
    }
    if (isLocalImage && !spanImageNodeView.spanImageTried) {
        // 本地图片解析
        spanImageNodeView.spanImageTried = true
        let rawFileCallback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            imagePixelMap, imageResWidth, imageResHeight => launch {
                if (imagePixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    let res = imageWidthAndHeight(
                        spanImageNodeView.spanImageComponentWidth,
                        imageResWidth(),
                        imageResHeight(),
                        spanImageNodeView.spanImageThemeWidth,
                        spanImageNodeView.spanImageThemeHeight,
                        imageTheme.imageMaxWidth,
                        imageTheme.imageMaxHeight,
                        imageTheme.imageFixedRatioWidth,
                        imageTheme.imageMaximumWidth
                    )
                    spanImageNodeView.spanImagePixelMap?.Release()
                    spanImageNodeView.spanImagePixelMap = imagePixelMap
                    spanImageNodeView.spanImageWidth = res[0]
                    spanImageNodeView.spanImageHeight = res[1]
                    spanImageNodeView.spanImageLoadType = 1
                } else {
                    spanImageNodeView.spanImageLoadType = 2
                }
                spanImageNodeView.spanRenderVersion += 1 // 版本号自增，使该节点item重建显示本地图片
                spanImageOnAsyncUpdated()
            }
        }
        MarkdownParseImageUtil.rawfileToPixelmap(spanImageNodeView.imageUrl(), spanImageMarkdownConfiguration.markdownTheme.globalTheme.uiAbilityContext, spanImageMarkdownConfiguration.markdownTheme.globalTheme.stageContext, rawFileCallback)
    }
    if (!isLocalImage && imageTheme.imagePlaceholder.isSome() && !spanImageNodeView.spanImageAltTried) {
        // URL图片占位图解析
        spanImageNodeView.spanImageAltTried = true
        let altCallback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            imageResPixelMap, imageResWidth, imageResHeight => launch {
                var changed = false
                if (imageResPixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    let res = imageWidthAndHeight(
                        spanImageNodeView.spanImageComponentWidth,
                        imageResWidth(),
                        imageResHeight(),
                        spanImageNodeView.spanImageThemeWidth,
                        spanImageNodeView.spanImageThemeHeight,
                        imageTheme.imageMaxWidth,
                        imageTheme.imageMaxHeight,
                        imageTheme.imageFixedRatioWidth,
                        imageTheme.imageMaximumWidth
                    )
                    // 对齐原组件：主图未加载完成且（回调模式）替换图未完成时才使用占位图
                    var canUseAlt = spanImageNodeView.spanImageLoadType != 1
                    if (spanImageMarkdownConfiguration.imageReplaceCallback.isSome()) {
                        canUseAlt = canUseAlt && spanImageNodeView.imageReplacePixelMap.isNone()
                    }
                    if (canUseAlt) {
                        if (spanImageNodeView.spanImageAltPixelMap.isNone()) {
                            changed = true
                        }
                        spanImageNodeView.spanImageAltPixelMap?.Release()
                        spanImageNodeView.spanImageAltPixelMap = imageResPixelMap
                        if (spanImageNodeView.spanImagePlaceholderWidth != res[0] || spanImageNodeView.spanImagePlaceholderHeight != res[1]) {
                            spanImageNodeView.spanImagePlaceholderWidth = res[0]
                            spanImageNodeView.spanImagePlaceholderHeight = res[1]
                            changed = true
                        }
                    }
                }
                if (changed) {
                    spanImageNodeView.spanRenderVersion += 1 // 版本号自增，使该节点item重建显示占位图
                    spanImageOnAsyncUpdated()
                }
            }
        }
        MarkdownParseImageUtil.resourceToPixelmap(imageTheme.imagePlaceholder(), spanImageMarkdownConfiguration.markdownTheme.globalTheme.uiAbilityContext, spanImageMarkdownConfiguration.markdownTheme.globalTheme.stageContext, altCallback)
    }
}
