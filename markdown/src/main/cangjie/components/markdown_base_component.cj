package markdown.components

import ohos.state_macro_manage.*

@Builder
func CustomBlockImageBuilder(description: String, destination: String, title: String) { /* cjlint-ignore !G.FUN.02 */
    Text("")
}

@Builder
func CustomBlockLinkBuilder(description: String, destination: String, title: String) { /* cjlint-ignore !G.FUN.02 */
    Text("")
}

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
    item: NodeView
) {
    MarkdownCodeBlockListComponent(
        markdownConfiguration: markdownConfiguration,
        nodeView: item
    )
}

/**
 * 代码类型文本显示
 *
 * @param str 类型文本内容
 * @param markdownConfiguration markdown配置
 * @param isShow 是否显示（代码内容为空时隐藏，与ArkUI一致）
 */
@Builder
func codeBlockTextComponent(str: String, markdownConfiguration: MarkdownConfiguration, isShow: Bool) {
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
    .visibility(isVisibility(isShow))
}

/**
 * 代码块标题栏（类型文本 + 复制按钮 + 全屏按钮）
 * 与ArkUI CodeTitleComponent结构一致：类型文本(30%) + Blank + 复制按钮 + 间距 + 全屏按钮
 * 按钮始终创建，用visibility控制显隐
 *
 * @param codeText 代码内容
 * @param infoText 代码类型（空字符串时显示默认类型文本）
 * @param markdownConfiguration markdown配置
 * @param showTypeText 是否显示代码块类型文本（组合代码块列表已用Tab展示，传false避免重复）
 */
@Builder
func codeTitleComponent(codeText: String, infoText: String, markdownConfiguration: MarkdownConfiguration, showTypeText: Bool) {
    Row() {
        // 代码类型文本（showTypeText=false 或代码内容为空时隐藏）
        codeBlockTextComponent(if (infoText != "") {
            infoText
        } else {
            markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTypeText
        }, markdownConfiguration, showTypeText && codeText.trimAscii().size > 0)
        Blank()
            .layoutWeight(1)

        // 复制按钮（始终创建，用visibility控制显隐）
        Row() {
            if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIcon.isSome()) {
                Image(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIcon())
                    .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIconWidth)
                    .height(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIconHeight)
                    .objectFit(ImageFit.Contain)
            }

            Blank()
                .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIconTextSpacing)
                .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIcon.isSome() && markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyTextIsShow))

            // 复制文本（始终创建，用visibility控制显隐，与ArkUI一致）
            Text(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyText)
                .fontFamily(codeCopyTextFontFamily(markdownConfiguration.markdownTheme))
                .fontSize(codeCopyTextFontSize(markdownConfiguration.markdownTheme))
                .fontWeight(codeCopyTextFontWeight(markdownConfiguration.markdownTheme))
                .fontStyle(codeCopyTextFontStyle(markdownConfiguration.markdownTheme))
                .fontColor(codeCopyTextFontColor(markdownConfiguration.markdownTheme))
                .lineHeight(codeCopyTextLineHeight(markdownConfiguration.markdownTheme))
                .align(Alignment.End)
                .maxLines(1)
                .textOverflow(TextOverflow.Ellipsis)
                .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyTextIsShow))
        }
        .justifyContent(FlexAlign.End)
        .onClick {evt => codeCopyOnClick(codeText, markdownConfiguration.codeCopyCallback)}
        .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyButtonIsShow))

        Blank()
            .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyFullScreenSpacing)
            .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyButtonIsShow && markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenButtonIsShow))

        // 全屏按钮（始终创建，用visibility控制显隐）
        Row() {
            if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIcon.isSome()) {
                Image(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIcon())
                    .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIconWidth)
                    .height(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIconHeight)
                    .objectFit(ImageFit.Contain)
            }

            Blank()
                .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIconTextSpacing)
                .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIcon.isSome() && markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenTextIsShow))

            // 全屏文本（始终创建，用visibility控制显隐，与ArkUI一致）
            Text(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenText)
                .fontFamily(codeFullScreenTextFontFamily(markdownConfiguration.markdownTheme))
                .fontSize(codeFullScreenTextFontSize(markdownConfiguration.markdownTheme))
                .fontWeight(codeFullScreenTextFontWeight(markdownConfiguration.markdownTheme))
                .fontStyle(codeFullScreenTextFontStyle(markdownConfiguration.markdownTheme))
                .fontColor(codeFullScreenTextFontColor(markdownConfiguration.markdownTheme))
                .lineHeight(codeFullScreenTextLineHeight(markdownConfiguration.markdownTheme))
                .align(Alignment.End)
                .maxLines(1)
                .textOverflow(TextOverflow.Ellipsis)
                .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenTextIsShow))
        }
        .justifyContent(FlexAlign.End)
        .onClick {evt => codeFullScreenOnClick(codeText, if (infoText != "") {
            Some(infoText)
        } else {
            Option<String>.None
        }, markdownConfiguration.codeFullScreenCallback)}
        .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenButtonIsShow))
    }
    .margin(top: 8.0, right: 8.0, bottom: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTitleLayoutMarginBottom)
    .alignItems(VerticalAlign.Center)
}

/**
 * 链接, TOC列表链接
 * 链接图标由容器通过refreshSpanAsyncResources异步解析后写回NodeView，此处仅做纯声明式渲染
 * 图标未加载完成时回退显示链接文本
 */
@Builder
func spanLinkComponent(
    spanListNodeView: NodeView,
    spanListMarkdownConfiguration: MarkdownConfiguration,
    spanListTocListOnClick: ?(Int64) -> Unit,
    spanListFootnoteCallback: (String) -> Unit,
    isOneLink: Bool
) {
    if (!spanListMarkdownConfiguration.markdownTheme.linkTheme.linkIsIcon || ((spanListNodeView.isBulletList || spanListNodeView.isOrderedList || spanListNodeView.isQuote || spanListNodeView.isDescList) && isOneLink && !spanListMarkdownConfiguration.markdownTheme.linkTheme.linkListIsIcon)) {
        // 纯文本场景：不渲染链接图标
        markdownSpanComponent(
            spanListMarkdownConfiguration,
            spanListNodeView,
            spanListTocListOnClick,
            spanListFootnoteCallback,
            false
        )
    } else if (let Some(linkUrl) <- spanListNodeView.linkUrl) {
        if (linkUrl.startsWith("http://") || linkUrl.startsWith("https://")) {
            if (spanListNodeView.nodeText.trimAscii().toRuneArray().size > 1) {
                // 圆角矩形图片格式链接
                if (spanListNodeView.linkIconPixelMap.isSome() && spanListNodeView.linkIconWidth > 0.0 && spanListNodeView.linkIconHeight > 0.0) {
                    spanLinkIconComponent(spanListNodeView, spanListMarkdownConfiguration, spanListMarkdownConfiguration.markdownTheme.linkTheme.linkRectIconMargin, linkUrl)
                } else {
                    // 图标未加载完成时回退显示链接文本
                    markdownSpanComponent(
                        spanListMarkdownConfiguration,
                        spanListNodeView,
                        spanListTocListOnClick,
                        spanListFootnoteCallback,
                        false
                    )
                }
            } else if (spanListNodeView.nodeText.trimAscii().toRuneArray().size == 1) {
                // 圆形图片格式链接
                if (spanListNodeView.linkIconPixelMap.isSome() && spanListNodeView.linkIconWidth > 0.0 && spanListNodeView.linkIconHeight > 0.0) {
                    spanLinkIconComponent(spanListNodeView, spanListMarkdownConfiguration, spanListMarkdownConfiguration.markdownTheme.linkTheme.linkCircleIconMargin, linkUrl)
                } else {
                    // 图标未加载完成时回退显示链接文本
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
                if (urlSafeBase64Decode(linkUrl) != "") {
                    // 空心圆角矩形图片格式链接
                    if (spanListNodeView.linkIconPixelMap.isSome() && spanListNodeView.linkIconWidth > 0.0 && spanListNodeView.linkIconHeight > 0.0) {
                        spanLinkIconComponent(spanListNodeView, spanListMarkdownConfiguration, spanListMarkdownConfiguration.markdownTheme.linkTheme.linkRectToolIconMargin, linkUrl)
                    } else {
                        // 图标未加载完成时回退显示链接文本
                        markdownSpanComponent(
                            spanListMarkdownConfiguration,
                            spanListNodeView,
                            spanListTocListOnClick,
                            spanListFootnoteCallback,
                            false
                        )
                    }
                }
                // 链接类型为空时保持现状：渲染空
            }
        }
    }
}

/**
 * 链接图标（圆角矩形 / 圆形 / 空心圆角矩形通用，图标数据来自NodeView异步写回）
 *
 * @param spanIconNodeView 链接节点
 * @param spanIconMarkdownConfiguration markdown配置
 * @param spanIconMargin 图标左右边距
 * @param spanIconUrl 链接
 */
@Builder
func spanLinkIconComponent(
    spanIconNodeView: NodeView,
    spanIconMarkdownConfiguration: MarkdownConfiguration,
    spanIconMargin: Length,
    spanIconUrl: String
) {
    ImageSpan(spanIconNodeView.linkIconPixelMap())
        .width(spanIconNodeView.linkIconWidth.px)
        .height(spanIconNodeView.linkIconHeight.px)
        .objectFit(ImageFit.Contain)
        .constraintSize(maxWidth: 100.percent)
        .verticalAlign(ImageSpanAlignment.CENTER)
        .margin(right: spanIconMargin, left: spanIconMargin)
        .onClick {
            evt => if (spanIconMarkdownConfiguration.linkCallback.isSome()) {
                spanIconMarkdownConfiguration.linkCallback.getOrThrow()(spanIconUrl)
            }
        }
}

/**
 * Image：图片节点， StyleImage：图片Style节点，ImageHtmlNode：HTML图片
 * 图片数据由容器通过refreshSpanAsyncResources异步解析后写回NodeView，此处仅做纯声明式渲染
 */
@Builder
func spanImageComponent(
    spanListNodeView: NodeView,
    spanListMarkdownConfiguration: MarkdownConfiguration,
    spanListComponentWidth: Float64,
    spanListImageCallback: (String) -> Unit,
    spanListImageWidthCallback: ?(Float64) -> Unit,
    spanListImageCellMaxWidth: ?Float64,
    spanListOnAsyncUpdated: () -> Unit
) {
    // 对齐ArkUI：imageUrl为空时不渲染图片（item.imageUrl !== undefined 判断），避免getOrThrow异常
    if (let Some(imageUrl) <- spanListNodeView.imageUrl) {
        if (spanListMarkdownConfiguration.imageReplaceCallback.isNone()) {
            // 没有图片替换回调接口
            if (isRawFileImageUrl(imageUrl)) {
                // 本地图片
                if (spanListNodeView.spanImageLoadType == 1 && spanListNodeView.spanImagePixelMap.isSome()) {
                    // 加载图片
                    spanImagePixelMapComponent(spanListNodeView, spanListMarkdownConfiguration, imageUrl, spanListImageCallback, spanListImageCellMaxWidth)
                } else if (spanListMarkdownConfiguration.markdownTheme.imageTheme.imagePlaceholder.isSome() && !spanImageIsInTableCell(spanListImageCellMaxWidth)) {
                    // 图片占位图（表格单元格场景不渲染：对齐ArkUI图片加载前宽度为0、占位图不撑宽单元格的语义）
                    imageSpanPlaceholderComponent(
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imagePlaceholder(),
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imageMarginTop,
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imageMarginRight,
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imageMarginBottom,
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imageMarginLeft,
                        spanListNodeView.spanImagePlaceholderWidth,
                        spanListNodeView.spanImagePlaceholderHeight,
                        spanListNodeView.spanImageRadiusTopLeft,
                        spanListNodeView.spanImageRadiusTopRight,
                        spanListNodeView.spanImageRadiusBottomLeft,
                        spanListNodeView.spanImageRadiusBottomRight,
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imageBorderWidth,
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imageBorderColor,
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imageBorderStyle
                    )
                }
            } else {
                // url
                spanImageUrlLoadComponent(spanListNodeView, spanListMarkdownConfiguration, imageUrl, spanListImageCallback, spanListImageCellMaxWidth, spanListComponentWidth, spanListImageWidthCallback, spanListOnAsyncUpdated)
            }
        } else {
            // 有图片替换回调接口
            if (spanListNodeView.imageReplacePixelMap.isSome()) {
                // 替换之后的图片
                spanImageReplaceComponent(spanListNodeView, spanListMarkdownConfiguration, imageUrl, spanListImageCallback, spanListImageCellMaxWidth)
            } else if (isRawFileImageUrl(imageUrl)) {
                // 本地图片
                if (spanListNodeView.spanImageLoadType == 1 && spanListNodeView.spanImagePixelMap.isSome()) {
                    // 加载图片
                    spanImagePixelMapComponent(spanListNodeView, spanListMarkdownConfiguration, imageUrl, spanListImageCallback, spanListImageCellMaxWidth)
                } else if (spanListMarkdownConfiguration.markdownTheme.imageTheme.imagePlaceholder.isSome() && !spanImageIsInTableCell(spanListImageCellMaxWidth)) {
                    // 图片占位图（表格单元格场景不渲染：对齐ArkUI图片加载前宽度为0、占位图不撑宽单元格的语义）
                    imageSpanPlaceholderComponent(
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imagePlaceholder(),
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imageMarginTop,
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imageMarginRight,
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imageMarginBottom,
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imageMarginLeft,
                        spanListNodeView.spanImagePlaceholderWidth,
                        spanListNodeView.spanImagePlaceholderHeight,
                        spanListNodeView.spanImageRadiusTopLeft,
                        spanListNodeView.spanImageRadiusTopRight,
                        spanListNodeView.spanImageRadiusBottomLeft,
                        spanListNodeView.spanImageRadiusBottomRight,
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imageBorderWidth,
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imageBorderColor,
                        spanListMarkdownConfiguration.markdownTheme.imageTheme.imageBorderStyle
                    )
                }
            } else {
                // url
                spanImageUrlLoadComponent(spanListNodeView, spanListMarkdownConfiguration, imageUrl, spanListImageCallback, spanListImageCellMaxWidth, spanListComponentWidth, spanListImageWidthCallback, spanListOnAsyncUpdated)
            }
        }
    }
}

/**
 * 行内图片（本地图解析完成）：渲染PixelMap
 *
 * @param spanPixelMapNodeView 图片节点
 * @param spanPixelMapMarkdownConfiguration markdown配置
 * @param spanPixelMapDestination 图片链接
 * @param spanPixelMapImageCallback 图片点击事件
 * @param spanPixelMapCellMaxWidth 表格单元格最大宽度 - 单位vp
 */
@Builder
func spanImagePixelMapComponent(
    spanPixelMapNodeView: NodeView,
    spanPixelMapMarkdownConfiguration: MarkdownConfiguration,
    spanPixelMapDestination: String,
    spanPixelMapImageCallback: (String) -> Unit,
    spanPixelMapCellMaxWidth: ?Float64
) {
    ImageSpan(spanPixelMapNodeView.spanImagePixelMap())
        .margin(top: spanPixelMapMarkdownConfiguration.markdownTheme.imageTheme.imageMarginTop, right: spanPixelMapMarkdownConfiguration.markdownTheme.imageTheme.imageMarginRight, bottom: spanPixelMapMarkdownConfiguration.markdownTheme.imageTheme.imageMarginBottom, left: spanPixelMapMarkdownConfiguration.markdownTheme.imageTheme.imageMarginLeft)
        .borderRadius(topLeft: spanPixelMapNodeView.spanImageRadiusTopLeft, topRight: spanPixelMapNodeView.spanImageRadiusTopRight, bottomLeft: spanPixelMapNodeView.spanImageRadiusBottomLeft, bottomRight: spanPixelMapNodeView.spanImageRadiusBottomRight)
        .borderWidth(spanPixelMapMarkdownConfiguration.markdownTheme.imageTheme.imageBorderWidth)
        .borderColor(spanPixelMapMarkdownConfiguration.markdownTheme.imageTheme.imageBorderColor)
        .borderStyle(spanPixelMapMarkdownConfiguration.markdownTheme.imageTheme.imageBorderStyle)
        .width(spanPixelMapNodeView.spanImageWidth.px)
        .height(spanPixelMapNodeView.spanImageHeight.px)
        .objectFit(spanPixelMapMarkdownConfiguration.markdownTheme.imageTheme.imageFitType)
        .verticalAlign(ImageSpanAlignment.CENTER)
        .constraintSize(maxWidth: imageSpanConstraintMaxWidth(spanPixelMapCellMaxWidth, spanPixelMapMarkdownConfiguration.markdownTheme.imageTheme.imageMaxWidth), maxHeight: imageMaxHeightLength(spanPixelMapMarkdownConfiguration.markdownTheme.imageTheme.imageMaxHeight))
        .onClick {
            evt => imageSpanOnClick(spanPixelMapNodeView.isLink, spanPixelMapImageCallback, spanPixelMapMarkdownConfiguration.linkCallback, spanPixelMapNodeView.linkUrl, spanPixelMapDestination)
        }
}

/**
 * 行内图片（替换图解析完成）：渲染替换后的PixelMap
 *
 * @param spanReplaceNodeView 图片节点
 * @param spanReplaceMarkdownConfiguration markdown配置
 * @param spanReplaceDestination 图片链接
 * @param spanReplaceImageCallback 图片点击事件
 * @param spanReplaceCellMaxWidth 表格单元格最大宽度 - 单位vp
 */
@Builder
func spanImageReplaceComponent(
    spanReplaceNodeView: NodeView,
    spanReplaceMarkdownConfiguration: MarkdownConfiguration,
    spanReplaceDestination: String,
    spanReplaceImageCallback: (String) -> Unit,
    spanReplaceCellMaxWidth: ?Float64
) {
    ImageSpan(spanReplaceNodeView.imageReplacePixelMap())
        .margin(top: spanReplaceMarkdownConfiguration.markdownTheme.imageTheme.imageMarginTop, right: spanReplaceMarkdownConfiguration.markdownTheme.imageTheme.imageMarginRight, bottom: spanReplaceMarkdownConfiguration.markdownTheme.imageTheme.imageMarginBottom, left: spanReplaceMarkdownConfiguration.markdownTheme.imageTheme.imageMarginLeft)
        .borderRadius(topLeft: spanReplaceNodeView.spanImageRadiusTopLeft, topRight: spanReplaceNodeView.spanImageRadiusTopRight, bottomLeft: spanReplaceNodeView.spanImageRadiusBottomLeft, bottomRight: spanReplaceNodeView.spanImageRadiusBottomRight)
        .borderWidth(spanReplaceMarkdownConfiguration.markdownTheme.imageTheme.imageBorderWidth)
        .borderColor(spanReplaceMarkdownConfiguration.markdownTheme.imageTheme.imageBorderColor)
        .borderStyle(spanReplaceMarkdownConfiguration.markdownTheme.imageTheme.imageBorderStyle)
        .width(spanReplaceNodeView.imageReplaceWidth().px)
        .height(spanReplaceNodeView.imageReplaceHeight().px)
        .objectFit(spanReplaceMarkdownConfiguration.markdownTheme.imageTheme.imageFitType)
        .verticalAlign(ImageSpanAlignment.CENTER)
        .constraintSize(maxWidth: imageSpanConstraintMaxWidth(spanReplaceCellMaxWidth, spanReplaceMarkdownConfiguration.markdownTheme.imageTheme.imageMaxWidth), maxHeight: imageMaxHeightLength(spanReplaceMarkdownConfiguration.markdownTheme.imageTheme.imageMaxHeight))
        .onClick {
            evt => imageSpanOnClick(spanReplaceNodeView.isLink, spanReplaceImageCallback, spanReplaceMarkdownConfiguration.linkCallback, spanReplaceNodeView.linkUrl, spanReplaceDestination)
        }
}

/**
 * url图片渲染宽度：主图加载完成后用实际宽度，未完成且占位图已解析时用占位图宽度
 */
func spanImageUrlRenderWidth(spanImageNodeView: NodeView): Float64 {
    if (spanImageNodeView.spanImageAltPixelMap.isSome() && spanImageNodeView.spanImageLoadType != 1) {
        return spanImageNodeView.spanImagePlaceholderWidth
    }
    return spanImageNodeView.spanImageWidth
}

/**
 * url图片渲染高度：主图加载完成后用实际高度，未完成且占位图已解析时用占位图高度
 */
func spanImageUrlRenderHeight(spanImageNodeView: NodeView): Float64 {
    if (spanImageNodeView.spanImageAltPixelMap.isSome() && spanImageNodeView.spanImageLoadType != 1) {
        return spanImageNodeView.spanImagePlaceholderHeight
    }
    return spanImageNodeView.spanImageHeight
}

/**
 * 行内图片（URL加载）：加载完成前用占位图作为alt渲染，加载完成事件写回NodeView并触发容器刷新
 *
 * @param spanUrlNodeView 图片节点
 * @param spanUrlMarkdownConfiguration markdown配置
 * @param spanUrlDestination 图片链接
 * @param spanUrlImageCallback 图片点击事件
 * @param spanUrlCellMaxWidth 表格单元格最大宽度 - 单位vp
 * @param spanUrlComponentWidth 控件宽度 - 单位vp
 * @param spanUrlWidthCallback 图片加载完成后实际显示宽度回调 - 单位vp
 * @param spanUrlOnAsyncUpdated 异步写回完成回调
 */
@Builder
func spanImageUrlLoadComponent(
    spanUrlNodeView: NodeView,
    spanUrlMarkdownConfiguration: MarkdownConfiguration,
    spanUrlDestination: String,
    spanUrlImageCallback: (String) -> Unit,
    spanUrlCellMaxWidth: ?Float64,
    spanUrlComponentWidth: Float64,
    spanUrlWidthCallback: ?(Float64) -> Unit,
    spanUrlOnAsyncUpdated: () -> Unit
) {
    if (spanUrlNodeView.spanImageAltPixelMap.isSome()) {
        // 图片加载完成前，用占位图作为alt渲染
        ImageSpan(spanUrlDestination)
            .alt(spanUrlNodeView.spanImageAltPixelMap())
            .margin(top: spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageMarginTop, right: spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageMarginRight, bottom: spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageMarginBottom, left: spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageMarginLeft)
            .borderRadius(topLeft: spanUrlNodeView.spanImageRadiusTopLeft, topRight: spanUrlNodeView.spanImageRadiusTopRight, bottomLeft: spanUrlNodeView.spanImageRadiusBottomLeft, bottomRight: spanUrlNodeView.spanImageRadiusBottomRight)
            .borderWidth(spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageBorderWidth)
            .borderColor(spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageBorderColor)
            .borderStyle(spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageBorderStyle)
            .width(spanImageUrlRenderWidth(spanUrlNodeView).px)
            .height(spanImageUrlRenderHeight(spanUrlNodeView).px)
            .objectFit(spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageFitType)
            .verticalAlign(ImageSpanAlignment.CENTER)
            .constraintSize(maxWidth: imageSpanConstraintMaxWidth(spanUrlCellMaxWidth, spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageMaxWidth), maxHeight: imageMaxHeightLength(spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageMaxHeight))
            .onClick {
                evt => imageSpanOnClick(spanUrlNodeView.isLink, spanUrlImageCallback, spanUrlMarkdownConfiguration.linkCallback, spanUrlNodeView.linkUrl, spanUrlDestination)
            }
            .onComplete {
                imageLoadResult =>
                spanImageOnLoadComplete(spanUrlNodeView, spanUrlMarkdownConfiguration.markdownTheme, spanImageOnCompleteBaseWidth(spanUrlCellMaxWidth, spanUrlComponentWidth, imageLoadResult.width), imageLoadResult.width, imageLoadResult.height, spanUrlWidthCallback, spanUrlOnAsyncUpdated)
            }
            .onError {
                imageError => if (spanUrlNodeView.spanImageLoadType != 2) {
                    spanUrlNodeView.spanImageLoadType = 2
                    spanUrlOnAsyncUpdated()
                }
            }
    } else if (spanUrlNodeView.spanImageLoadType != 2) {
        // 无占位图且加载失败（spanImageLoadType == 2）时不渲染：0x0 的失败 ImageSpan 会顶出一块空白框
        ImageSpan(spanUrlDestination)
            .margin(top: spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageMarginTop, right: spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageMarginRight, bottom: spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageMarginBottom, left: spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageMarginLeft)
            .borderRadius(topLeft: spanUrlNodeView.spanImageRadiusTopLeft, topRight: spanUrlNodeView.spanImageRadiusTopRight, bottomLeft: spanUrlNodeView.spanImageRadiusBottomLeft, bottomRight: spanUrlNodeView.spanImageRadiusBottomRight)
            .borderWidth(spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageBorderWidth)
            .borderColor(spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageBorderColor)
            .borderStyle(spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageBorderStyle)
            .width(spanImageUrlRenderWidth(spanUrlNodeView).px)
            .height(spanImageUrlRenderHeight(spanUrlNodeView).px)
            .objectFit(spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageFitType)
            .verticalAlign(ImageSpanAlignment.CENTER)
            .constraintSize(maxWidth: imageSpanConstraintMaxWidth(spanUrlCellMaxWidth, spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageMaxWidth), maxHeight: imageMaxHeightLength(spanUrlMarkdownConfiguration.markdownTheme.imageTheme.imageMaxHeight))
            .onClick {
                evt => imageSpanOnClick(spanUrlNodeView.isLink, spanUrlImageCallback, spanUrlMarkdownConfiguration.linkCallback, spanUrlNodeView.linkUrl, spanUrlDestination)
            }
            .onComplete {
                imageLoadResult =>
                spanImageOnLoadComplete(spanUrlNodeView, spanUrlMarkdownConfiguration.markdownTheme, spanImageOnCompleteBaseWidth(spanUrlCellMaxWidth, spanUrlComponentWidth, imageLoadResult.width), imageLoadResult.width, imageLoadResult.height, spanUrlWidthCallback, spanUrlOnAsyncUpdated)
            }
            .onError {
                imageError => if (spanUrlNodeView.spanImageLoadType != 2) {
                    spanUrlNodeView.spanImageLoadType = 2
                    spanUrlOnAsyncUpdated()
                }
            }
    }
}

/**
 * 行内数学公式：公式图片由容器通过refreshSpanAsyncResources异步解析后写回NodeView，此处仅做纯声明式渲染
 *
 * @param spanLatexNodeView 数学公式节点
 * @param spanLatexMarkdownConfiguration markdown配置
 */
@Builder
func spanLatexMathComponent(
    spanLatexNodeView: NodeView,
    spanLatexMarkdownConfiguration: MarkdownConfiguration
) {
    if (spanLatexNodeView.latexParserEnd) {
        if (spanLatexNodeView.latexPixelMap.isSome() && spanLatexNodeView.latexImageHeight > 0.0 && spanLatexNodeView.latexImageWidth > 0.0 && spanLatexNodeView.latexImageData.isSome()) {
            // 数学公式图片
            ImageSpan(spanLatexNodeView.latexPixelMap())
                .width(spanLatexNodeView.latexImageWidth.px)
                .height(spanLatexNodeView.latexImageHeight.px)
                .objectFit(ImageFit.Contain)
                .constraintSize(maxWidth: 100.percent)
                .verticalAlign(ImageSpanAlignment.CENTER)
                .onClick {
                    evt => if (spanLatexNodeView.isLink) {
                        if (spanLatexMarkdownConfiguration.linkCallback.isSome() && spanLatexNodeView.linkUrl.isSome()) {
                            spanLatexMarkdownConfiguration.linkCallback.getOrThrow()(spanLatexNodeView.linkUrl())
                        }
                    } else {
                        latexImageOnClick(spanLatexNodeView.latexImageData(), spanLatexNodeView.latexImageHeight.px, spanLatexNodeView.latexImageWidth.px, spanLatexMarkdownConfiguration.latexImageCallback)
                    }
                }
        } else {
            // 解析失败：按主题开关回退显示公式默认文本
            if (spanLatexMarkdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultText) {
                spanLatexDefaultTextComponent(spanLatexNodeView.nodeText, spanLatexMarkdownConfiguration.markdownTheme)
            }
        }
    } else {
        // 解析未结束：按主题开关显示公式默认文本
        if (spanLatexMarkdownConfiguration.markdownTheme.latexMathTheme.latexMathDefaultText) {
            spanLatexDefaultTextComponent(spanLatexNodeView.nodeText, spanLatexMarkdownConfiguration.markdownTheme)
        }
    }
}

/**
 * 数学公式默认文本（解析未结束或解析失败时的回退展示，受主题latexMathDefaultText开关控制）
 *
 * @param spanLatexDefaultStr 数学公式文本
 * @param spanLatexDefaultMarkdownTheme markdown样式
 */
@Builder
func spanLatexDefaultTextComponent(
    spanLatexDefaultStr: String,
    spanLatexDefaultMarkdownTheme: MarkdownTheme
) {
    Span(spanLatexDefaultStr)
        .fontFamily(spanLatexDefaultMarkdownTheme.latexMathTheme.latexMathDefaultTextFontFamily)
        .fontSize(spanLatexDefaultMarkdownTheme.latexMathTheme.latexMathDefaultTextFontSize)
        .fontWeight(spanLatexDefaultMarkdownTheme.latexMathTheme.latexMathDefaultTextFontWeight)
        .fontStyle(spanLatexDefaultMarkdownTheme.latexMathTheme.latexMathDefaultTextFontStyle)
        .fontColor(spanLatexDefaultMarkdownTheme.latexMathTheme.latexMathDefaultTextFontColor)
}

/**
 * 是否处于表格单元格场景（单元格最大宽度已传入且有效）
 */
func spanImageIsInTableCell(spanImageCellMaxWidth: ?Float64): Bool {
    if (let Some(cellMaxWidth) <- spanImageCellMaxWidth) {
        return cellMaxWidth > 0.0
    }
    return false
}

/**
 * 行内图片onComplete写回：宽度基准取值（单元格最大宽度 → 实时控件宽度 → 兜底图片自然宽度）
 *
 * @param spanBaseCellMaxWidth 表格单元格最大宽度 - 单位vp
 * @param spanBaseComponentWidth 控件宽度 - 单位vp
 * @param spanBaseNaturalWidth 图片自然宽度 - 单位px
 */
func spanImageOnCompleteBaseWidth(spanBaseCellMaxWidth: ?Float64, spanBaseComponentWidth: Float64, spanBaseNaturalWidth: Float64): Float64 {
    var spanBaseWidth = 0.0
    if (let Some(cellMaxWidth) <- spanBaseCellMaxWidth) {
        if (cellMaxWidth > 0.0) {
            spanBaseWidth = vp2px(cellMaxWidth.vp)().value
        }
    }
    if (spanBaseWidth <= 0.0 && spanBaseComponentWidth > 0.0) {
        spanBaseWidth = vp2px(spanBaseComponentWidth.vp)().value
    }
    if (spanBaseWidth <= 0.0) {
        spanBaseWidth = spanBaseNaturalWidth
    }
    return spanBaseWidth
}

/**
 * 行内图片onComplete写回：按宽度基准计算最终显示宽高，写回NodeView并触发容器刷新
 *
 * @param spanCompleteNodeView 图片节点
 * @param spanCompleteMarkdownTheme markdown样式
 * @param spanCompleteBaseWidth 宽度计算基准 - 单位px
 * @param spanCompleteNaturalWidth 图片自然宽度 - 单位px
 * @param spanCompleteNaturalHeight 图片自然高度 - 单位px
 * @param spanCompleteWidthCallback 图片加载完成后实际显示宽度回调 - 单位vp
 * @param spanCompleteOnAsyncUpdated 异步写回完成回调
 */
func spanImageOnLoadComplete(
    spanCompleteNodeView: NodeView,
    spanCompleteMarkdownTheme: MarkdownTheme,
    spanCompleteBaseWidth: Float64,
    spanCompleteNaturalWidth: Float64,
    spanCompleteNaturalHeight: Float64,
    spanCompleteWidthCallback: ?(Float64) -> Unit,
    spanCompleteOnAsyncUpdated: () -> Unit
): Unit {
    if (spanCompleteBaseWidth > 0.0) {
        let res = imageWidthAndHeight(
            spanCompleteBaseWidth,
            spanCompleteNaturalWidth,
            spanCompleteNaturalHeight,
            spanCompleteNodeView.spanImageThemeWidth,
            spanCompleteNodeView.spanImageThemeHeight,
            spanCompleteMarkdownTheme.imageTheme.imageMaxWidth,
            spanCompleteMarkdownTheme.imageTheme.imageMaxHeight,
            spanCompleteMarkdownTheme.imageTheme.imageFixedRatioWidth,
            spanCompleteMarkdownTheme.imageTheme.imageMaximumWidth
        )
        // 对齐ArkUI：仅计算结果有效时写回，避免异常结果覆盖已有宽高
        if (res[0] > 0.0 && res[1] > 0.0) {
            let changed = spanCompleteNodeView.spanImageLoadType != 1
            spanCompleteNodeView.spanImageWidth = res[0]
            spanCompleteNodeView.spanImageHeight = res[1]
            // 对齐ArkUI：原始尺寸与最终显示宽高写回节点缓存，供增量刷新复用
            cacheImageSizeToNode(spanCompleteNodeView, spanCompleteNaturalWidth, spanCompleteNaturalHeight, res[0], res[1])
            spanCompleteNodeView.spanImageLoadType = 1
            if (spanCompleteWidthCallback.isSome()) {
                spanCompleteWidthCallback.getOrThrow()(px2vp(res[0].px).getOrThrow().value)
            }
            if (changed) {
                spanCompleteNodeView.spanRenderVersion += 1
                spanCompleteOnAsyncUpdated()
            }
        }
    }
}

/**
 * 释放行内Span节点列表的PixelMap资源（节点被替换/移除或宿主销毁时调用）
 */
func releaseSpanListPixelMaps(spanListNodes: ObservedArrayList<NodeView>): Unit {
    for (i in 0..spanListNodes.size) {
        spanListNodes[i].releaseSpanPixelMaps()
    }
}

/**
 * 行内Span异步资源解析总入口（链接图标 / 行内数学公式 / 行内图片）
 * 在容器aboutToAppear与数据刷新时调用，解析结果写回NodeView后通过spanRenderVersion自增 + onAsyncUpdated回调触发容器重建
 *
 * @param spanListNodes 行内Span节点列表
 * @param spanListConfiguration markdown配置
 * @param spanListComponentWidth 控件宽度 - 单位vp
 * @param spanListIsOneLink 是否单链接场景（列表/引用内的单个链接不渲染图标）
 * @param spanListImageCallback 图片点击事件
 * @param spanListImageWidthCallback 图片加载完成后实际显示宽度回调 - 单位vp（表格列宽跟踪用）
 * @param spanListImageCellMaxWidth 表格单元格最大宽度 - 单位vp（表格场景传入，作为图片宽度计算基准与约束宽度）
 * @param spanListLatexWidthCallback 数学公式图片解析完成后实际显示宽度回调 - 单位vp（表格列宽跟踪用）
 * @param spanListOnAsyncUpdated 异步写回完成回调（容器据此触发刷新）
 */
func refreshSpanAsyncResources(
    spanListNodes: ObservedArrayList<NodeView>,
    spanListConfiguration: MarkdownConfiguration,
    spanListComponentWidth: Float64,
    spanListIsOneLink: Bool,
    spanListImageCallback: (String) -> Unit,
    spanListImageWidthCallback: ?(Float64) -> Unit,
    spanListImageCellMaxWidth: ?Float64,
    spanListLatexWidthCallback: ?(Float64) -> Unit,
    spanListOnAsyncUpdated: () -> Unit
): Unit {
    for (i in 0..spanListNodes.size) {
        let node = spanListNodes[i]
        if (node.nodeType == "Link" || node.nodeType == "HeadLink") {
            // 链接图标
            refreshSpanLinkIcon(node, spanListConfiguration, spanListIsOneLink, spanListOnAsyncUpdated)
        } else if (node.nodeType == "LatexMathNode") {
            // 行内数学公式
            refreshSpanLatexMath(node, spanListConfiguration, spanListComponentWidth, spanListLatexWidthCallback, spanListOnAsyncUpdated)
        } else if (node.nodeType == "Image" || node.nodeType == "StyleImage" || node.nodeType == "ImageHtmlNode") {
            // 行内图片
            refreshSpanImage(node, spanListConfiguration, spanListComponentWidth, spanListImageCallback, spanListImageWidthCallback, spanListImageCellMaxWidth, spanListOnAsyncUpdated)
        }
    }
}

/**
 * 链接图标解析（圆角矩形 / 圆形 / 空心圆角矩形），解析结果写回NodeView
 *
 * @param spanLinkIconNodeView 链接节点
 * @param spanLinkIconConfiguration markdown配置
 * @param spanLinkIconIsOneLink 是否单链接场景
 * @param spanLinkIconOnAsyncUpdated 异步写回完成回调
 */
func refreshSpanLinkIcon(
    spanLinkIconNodeView: NodeView,
    spanLinkIconConfiguration: MarkdownConfiguration,
    spanLinkIconIsOneLink: Bool,
    spanLinkIconOnAsyncUpdated: () -> Unit
): Unit {
    if (spanLinkIconNodeView.linkIconTried) {
        return
    }
    spanLinkIconNodeView.linkIconTried = true
    // 纯文本场景不解析链接图标（与spanLinkComponent渲染门控一致）
    if (!spanLinkIconConfiguration.markdownTheme.linkTheme.linkIsIcon || ((spanLinkIconNodeView.isBulletList || spanLinkIconNodeView.isOrderedList || spanLinkIconNodeView.isQuote || spanLinkIconNodeView.isDescList) && spanLinkIconIsOneLink && !spanLinkIconConfiguration.markdownTheme.linkTheme.linkListIsIcon)) {
        return
    }
    if (spanLinkIconNodeView.linkUrl.isNone()) {
        return
    }
    let linkIconUrl = spanLinkIconNodeView.linkUrl()
    let linkIconStrText = spanLinkIconNodeView.nodeText.trimAscii()
    let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
        pixelMap, height, width => launch {
            if (pixelMap.isSome() && height.isSome() && width.isSome()) {
                spanLinkIconNodeView.linkIconPixelMap?.Release()
                spanLinkIconNodeView.linkIconPixelMap = pixelMap
                spanLinkIconNodeView.linkIconHeight = height()
                spanLinkIconNodeView.linkIconWidth = width()
                spanLinkIconNodeView.spanRenderVersion += 1 // 版本号自增，使该节点item重建显示图标
                spanLinkIconOnAsyncUpdated()
            }
        }
    }
    if (linkIconUrl.startsWith("http://") || linkIconUrl.startsWith("https://")) {
        if (linkIconStrText.toRuneArray().size > 1) {
            // 圆角矩形图片格式链接
            let linkRectIconTextSize = vp2px(spanLinkIconConfiguration.markdownTheme.linkTheme.linkRectIconTextSize.vp)().value
            let linkRectIconHeight = vp2px(spanLinkIconConfiguration.markdownTheme.linkTheme.linkRectIconHeight.vp)().value
            let linkRectIconPadding = vp2px(spanLinkIconConfiguration.markdownTheme.linkTheme.linkRectIconPadding.vp)().value
            let linkRectIconRadius = vp2px(spanLinkIconConfiguration.markdownTheme.linkTheme.linkRectIconRadius.vp)().value
            let fut = MarkdownParseLinkUtil.linkStrToRectPixelMap(linkIconStrText, linkRectIconTextSize, linkRectIconHeight, linkRectIconPadding, linkRectIconRadius, spanLinkIconConfiguration, callback)
        } else if (linkIconStrText.toRuneArray().size == 1) {
            // 圆形图片格式链接
            let linkCircleIconTextSize = vp2px(spanLinkIconConfiguration.markdownTheme.linkTheme.linkCircleIconTextSize.vp)().value
            let linkCircleIconRadius = vp2px(spanLinkIconConfiguration.markdownTheme.linkTheme.linkCircleIconRadius.vp)().value
            let fut = MarkdownParseLinkUtil.linkStrToCirclePixelMap(linkIconStrText, linkCircleIconTextSize, linkCircleIconRadius, spanLinkIconConfiguration, callback)
        }
    } else {
        if (linkIconStrText.toRuneArray().size >= 1) {
            let strType = urlSafeBase64Decode(linkIconUrl)
            if (strType != "") {
                // 空心圆角矩形图片格式链接
                let linkRectToolIconTextSize = vp2px(spanLinkIconConfiguration.markdownTheme.linkTheme.linkRectToolIconTextSize.vp)().value
                let linkRectToolIconHeight = vp2px(spanLinkIconConfiguration.markdownTheme.linkTheme.linkRectToolIconHeight.vp)().value
                let linkRectToolIconPadding = vp2px(spanLinkIconConfiguration.markdownTheme.linkTheme.linkRectToolIconPadding.vp)().value
                let linkRectToolIconBorderWidth = vp2px(spanLinkIconConfiguration.markdownTheme.linkTheme.linkRectToolIconBorderWidth.vp)().value
                let linkRectToolIconDividingLineWidth = vp2px(spanLinkIconConfiguration.markdownTheme.linkTheme.linkRectToolIconDividingLineWidth.vp)().value
                let linkRectToolIconLineLeftPadding = vp2px(spanLinkIconConfiguration.markdownTheme.linkTheme.linkRectToolIconLineLeftPadding.vp)().value
                let linkRectToolIconLineRightPadding = vp2px(spanLinkIconConfiguration.markdownTheme.linkTheme.linkRectToolIconLineRightPadding.vp)().value
                let fut = MarkdownParseLinkUtil.linkStrToRectToolPixelMap(linkIconStrText, strType, linkRectToolIconTextSize, linkRectToolIconHeight, linkRectToolIconPadding, linkRectToolIconBorderWidth, linkRectToolIconDividingLineWidth, linkRectToolIconLineLeftPadding, linkRectToolIconLineRightPadding, spanLinkIconConfiguration, callback)
            }
        }
    }
}

/**
 * 行内数学公式解析，解析结果写回NodeView
 *
 * @param spanLatexAsyncNodeView 数学公式节点
 * @param spanLatexAsyncConfiguration markdown配置
 * @param spanLatexAsyncComponentWidth 控件宽度 - 单位vp
 * @param spanLatexAsyncWidthCallback 数学公式图片解析完成后实际显示宽度回调 - 单位vp（表格列宽跟踪用）
 * @param spanLatexAsyncOnAsyncUpdated 异步写回完成回调
 */
func refreshSpanLatexMath(
    spanLatexAsyncNodeView: NodeView,
    spanLatexAsyncConfiguration: MarkdownConfiguration,
    spanLatexAsyncComponentWidth: Float64,
    spanLatexAsyncWidthCallback: ?(Float64) -> Unit,
    spanLatexAsyncOnAsyncUpdated: () -> Unit
): Unit {
    if (spanLatexAsyncNodeView.latexTried) {
        return
    }
    spanLatexAsyncNodeView.latexTried = true
    let latexMathTextSize = fp2px(spanLatexAsyncConfiguration.markdownTheme.latexMathTheme.latexMathTextSize.fp)().value
    let componentWidth = vp2px(spanLatexAsyncComponentWidth.vp)().value
    let latexCallback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit = {
        pixelMap, height, width, arr => launch {
            if (pixelMap.isSome() && height.isSome() && width.isSome()) {
                spanLatexAsyncNodeView.latexPixelMap?.Release()
                spanLatexAsyncNodeView.latexPixelMap = pixelMap
                spanLatexAsyncNodeView.latexImageHeight = height()
                spanLatexAsyncNodeView.latexImageWidth = width()
                // 数学公式图片解析完成后，回调实际显示宽度（vp），供表格列宽跟踪使用
                // 宽度上限受tableMaxCellWidth约束，与单元格的maxWidth约束一致
                if (spanLatexAsyncWidthCallback.isSome()) {
                    var wVp = px2vp(width().px).getOrThrow().value
                    let maxW = spanLatexAsyncConfiguration.markdownTheme.tableTheme.tableMaxCellWidth
                    if (wVp > maxW) {
                        wVp = maxW
                    }
                    spanLatexAsyncWidthCallback.getOrThrow()(wVp)
                }
            }
            spanLatexAsyncNodeView.latexImageData = arr
            spanLatexAsyncNodeView.latexParserEnd = true
            spanLatexAsyncNodeView.spanRenderVersion += 1 // 版本号自增，使该节点item重建显示公式或默认文本
            spanLatexAsyncOnAsyncUpdated()
        }
    }
    // 将数学公式文本解析成图片
    let fut = MarkdownParseLatexUtil.latexMathStrToPixelMapRow(spanLatexAsyncNodeView.nodeText, spanLatexAsyncConfiguration.markdownTheme, latexMathTextSize, componentWidth, spanLatexAsyncConfiguration.latexStrCallback, latexCallback)
}

/**
 * 行内图片解析（本地图 / 占位图 / 替换图），解析结果写回NodeView
 * URL图片的最终宽高在ImageSpan的onComplete事件中写回（spanImageOnLoadComplete）
 *
 * @param spanImageAsyncNodeView 图片节点
 * @param spanImageAsyncConfiguration markdown配置
 * @param spanImageAsyncComponentWidth 控件宽度 - 单位vp
 * @param spanImageAsyncImageCallback 图片点击事件
 * @param spanImageAsyncWidthCallback 图片加载完成后实际显示宽度回调 - 单位vp（表格列宽跟踪用）
 * @param spanImageAsyncCellMaxWidth 表格单元格最大宽度 - 单位vp
 * @param spanImageAsyncOnAsyncUpdated 异步写回完成回调
 */
func refreshSpanImage(
    spanImageAsyncNodeView: NodeView,
    spanImageAsyncConfiguration: MarkdownConfiguration,
    spanImageAsyncComponentWidth: Float64,
    spanImageAsyncImageCallback: (String) -> Unit,
    spanImageAsyncWidthCallback: ?(Float64) -> Unit,
    spanImageAsyncCellMaxWidth: ?Float64,
    spanImageAsyncOnAsyncUpdated: () -> Unit
): Unit {
    if (spanImageAsyncNodeView.imageUrl.isNone()) {
        return
    }
    let spanImageAsyncDestination = spanImageAsyncNodeView.imageUrl()
    // 首次初始化静态渲染参数（组件宽度、圆角、主题宽高、占位图尺寸、缓存宽高）
    if (spanImageAsyncNodeView.spanImageComponentWidth == 0.0) {
        var componentImageWidth = vp2px(spanImageAsyncComponentWidth.vp)().value
        // 表格单元格场景：以单元格最大宽度为图片宽度计算基准（对齐ArkUI tableMaxCellWidth优先逻辑）
        if (let Some(cellMaxWidth) <- spanImageAsyncCellMaxWidth) {
            if (cellMaxWidth > 0.0) {
                componentImageWidth = vp2px(cellMaxWidth.vp)().value
            }
        }
        spanImageAsyncNodeView.spanImageComponentWidth = componentImageWidth
        // 图片圆角
        let radius = imageSpanBorderRadius(spanImageAsyncNodeView.imageRadius, spanImageAsyncConfiguration.markdownTheme.imageTheme.imageRadiusTopLeft, spanImageAsyncConfiguration.markdownTheme.imageTheme.imageRadiusTopRight, spanImageAsyncConfiguration.markdownTheme.imageTheme.imageRadiusBottomLeft, spanImageAsyncConfiguration.markdownTheme.imageTheme.imageRadiusBottomRight)
        spanImageAsyncNodeView.spanImageRadiusTopLeft = radius[0]
        spanImageAsyncNodeView.spanImageRadiusTopRight = radius[1]
        spanImageAsyncNodeView.spanImageRadiusBottomLeft = radius[2]
        spanImageAsyncNodeView.spanImageRadiusBottomRight = radius[3]
        // 图片设置宽度/高度
        spanImageAsyncNodeView.spanImageThemeWidth = widthHeightLength2FloatPx(spanImageAsyncNodeView.imageWidth, spanImageAsyncConfiguration.markdownTheme.imageTheme.imageWidth, componentImageWidth)
        spanImageAsyncNodeView.spanImageThemeHeight = widthHeightLength2FloatPx(spanImageAsyncNodeView.imageHeight, spanImageAsyncConfiguration.markdownTheme.imageTheme.imageHeight, componentImageWidth)
        // 图片占位图宽度
        spanImageAsyncNodeView.spanImagePlaceholderWidth = if (spanImageAsyncConfiguration.markdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            componentImageWidth * spanImageAsyncConfiguration.markdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            componentImageWidth * spanImageAsyncConfiguration.markdownTheme.imageTheme.imageMaximumWidth
        }
        // 图片占位图高度
        spanImageAsyncNodeView.spanImagePlaceholderHeight = if (spanImageAsyncConfiguration.markdownTheme.imageTheme.imageFixedRatioWidth.isSome()) {
            componentImageWidth * 9.0 / 16.0 * spanImageAsyncConfiguration.markdownTheme.imageTheme.imageFixedRatioWidth()
        } else {
            componentImageWidth * 9.0 / 16.0 * spanImageAsyncConfiguration.markdownTheme.imageTheme.imageMaximumWidth
        }
        // 对齐ArkUI：用节点缓存重算/复用最终显示宽高（增量刷新时onComplete不回调）
        let cachedSize = recalcImageSizeFromCache(componentImageWidth, spanImageAsyncNodeView, spanImageAsyncNodeView.spanImageThemeWidth, spanImageAsyncNodeView.spanImageThemeHeight, spanImageAsyncConfiguration.markdownTheme)
        if (cachedSize.size == 2) {
            spanImageAsyncNodeView.spanImageWidth = cachedSize[0]
            spanImageAsyncNodeView.spanImageHeight = cachedSize[1]
        } else if (spanImageAsyncConfiguration.imageReplaceCallback.isSome()) {
            // 回调模式无缓存时使用占位图尺寸作为初始宽高
            spanImageAsyncNodeView.spanImageWidth = spanImageAsyncNodeView.spanImagePlaceholderWidth
            spanImageAsyncNodeView.spanImageHeight = spanImageAsyncNodeView.spanImagePlaceholderHeight
        } else {
            // 兜底：直接复用节点缓存的最终显示宽高
            if (let Some(cacheWidth) <- spanImageAsyncNodeView.imageDisplayWidth) {
                spanImageAsyncNodeView.spanImageWidth = cacheWidth
            }
            if (let Some(cacheHeight) <- spanImageAsyncNodeView.imageDisplayHeight) {
                spanImageAsyncNodeView.spanImageHeight = cacheHeight
            }
        }
    }
    let isCallbackMode = spanImageAsyncConfiguration.imageReplaceCallback.isSome()
    if (isRawFileImageUrl(spanImageAsyncDestination) && !spanImageAsyncNodeView.spanImageTried) {
        // 本地图片解析
        spanImageAsyncNodeView.spanImageTried = true
        let rawFileCallback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            pixelMap, imageResWidth, imageResHeight => launch {
                if (pixelMap.isSome() && imageResWidth.isSome() && imageResHeight.isSome()) {
                    spanImageAsyncNodeView.spanImagePixelMap?.Release()
                    spanImageAsyncNodeView.spanImagePixelMap = pixelMap
                    let res = imageWidthAndHeight(
                        spanImageOnCompleteBaseWidth(spanImageAsyncCellMaxWidth, spanImageAsyncComponentWidth, imageResWidth()),
                        imageResWidth(),
                        imageResHeight(),
                        spanImageAsyncNodeView.spanImageThemeWidth,
                        spanImageAsyncNodeView.spanImageThemeHeight,
                        spanImageAsyncConfiguration.markdownTheme.imageTheme.imageMaxWidth,
                        spanImageAsyncConfiguration.markdownTheme.imageTheme.imageMaxHeight,
                        spanImageAsyncConfiguration.markdownTheme.imageTheme.imageFixedRatioWidth,
                        spanImageAsyncConfiguration.markdownTheme.imageTheme.imageMaximumWidth
                    )
                    spanImageAsyncNodeView.spanImageWidth = res[0]
                    spanImageAsyncNodeView.spanImageHeight = res[1]
                    // 原始尺寸与最终显示宽高写回节点缓存，供增量刷新复用
                    cacheImageSizeToNode(spanImageAsyncNodeView, imageResWidth(), imageResHeight(), res[0], res[1])
                    spanImageAsyncNodeView.spanImageLoadType = 1
                    if (spanImageAsyncWidthCallback.isSome()) {
                        spanImageAsyncWidthCallback.getOrThrow()(px2vp(res[0].px).getOrThrow().value)
                    }
                } else {
                    spanImageAsyncNodeView.spanImageLoadType = 2
                }
                spanImageAsyncNodeView.spanRenderVersion += 1 // 版本号自增，使该节点item重建显示本地图片
                spanImageAsyncOnAsyncUpdated()
            }
        }
        let fut = MarkdownParseImageUtil.rawfileToPixelmap(spanImageAsyncDestination, spanImageAsyncConfiguration.markdownTheme.globalTheme.uiAbilityContext, spanImageAsyncConfiguration.markdownTheme.globalTheme.stageContext, rawFileCallback)
    }
    // URL图片占位图解析（加载完成前用占位图作为alt渲染）
    if (!isRawFileImageUrl(spanImageAsyncDestination) && spanImageAsyncConfiguration.markdownTheme.imageTheme.imagePlaceholder.isSome() && !spanImageAsyncNodeView.spanImageAltTried) {
        // URL图片占位图解析
        spanImageAsyncNodeView.spanImageAltTried = true
        let altCallback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            altPixelMap, altWidth, altHeight => launch {
                if (altPixelMap.isSome() && altWidth.isSome() && altHeight.isSome()) {
                    let res = imageWidthAndHeight(
                        spanImageOnCompleteBaseWidth(spanImageAsyncCellMaxWidth, spanImageAsyncComponentWidth, altWidth()),
                        altWidth(),
                        altHeight(),
                        spanImageAsyncNodeView.spanImageThemeWidth,
                        spanImageAsyncNodeView.spanImageThemeHeight,
                        spanImageAsyncConfiguration.markdownTheme.imageTheme.imageMaxWidth,
                        spanImageAsyncConfiguration.markdownTheme.imageTheme.imageMaxHeight,
                        spanImageAsyncConfiguration.markdownTheme.imageTheme.imageFixedRatioWidth,
                        spanImageAsyncConfiguration.markdownTheme.imageTheme.imageMaximumWidth
                    )
                    // 主图未加载完成且（回调模式）替换图未完成时才使用占位图
                    var canUseAlt = spanImageAsyncNodeView.spanImageLoadType != 1
                    if (isCallbackMode) {
                        canUseAlt = canUseAlt && spanImageAsyncNodeView.imageReplacePixelMap.isNone()
                    }
                    if (canUseAlt) {
                        let changed = spanImageAsyncNodeView.spanImageAltPixelMap.isNone() || spanImageAsyncNodeView.spanImagePlaceholderWidth != res[0] || spanImageAsyncNodeView.spanImagePlaceholderHeight != res[1]
                        spanImageAsyncNodeView.spanImageAltPixelMap?.Release()
                        spanImageAsyncNodeView.spanImageAltPixelMap = altPixelMap
                        spanImageAsyncNodeView.spanImagePlaceholderWidth = res[0]
                        spanImageAsyncNodeView.spanImagePlaceholderHeight = res[1]
                        if (changed) {
                            spanImageAsyncNodeView.spanRenderVersion += 1
                            spanImageAsyncOnAsyncUpdated()
                        }
                    }
                }
            }
        }
        let fut = MarkdownParseImageUtil.resourceToPixelmap(spanImageAsyncConfiguration.markdownTheme.imageTheme.imagePlaceholder(), spanImageAsyncConfiguration.markdownTheme.globalTheme.uiAbilityContext, spanImageAsyncConfiguration.markdownTheme.globalTheme.stageContext, altCallback)
    }
    // 替换图解析（配置了图片替换回调时）
    if (isCallbackMode && !spanImageAsyncNodeView.imageReplaceTried) {
        // 替换图片解析
        spanImageAsyncNodeView.imageReplaceTried = true
        let replaceCallback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            replacePixelMap, replaceResWidth, replaceResHeight => launch {
                if (replacePixelMap.isSome() && replaceResWidth.isSome() && replaceResHeight.isSome()) {
                    let res = imageWidthAndHeight(
                        spanImageOnCompleteBaseWidth(spanImageAsyncCellMaxWidth, spanImageAsyncComponentWidth, replaceResWidth()),
                        replaceResWidth(),
                        replaceResHeight(),
                        spanImageAsyncNodeView.spanImageThemeWidth,
                        spanImageAsyncNodeView.spanImageThemeHeight,
                        spanImageAsyncConfiguration.markdownTheme.imageTheme.imageMaxWidth,
                        spanImageAsyncConfiguration.markdownTheme.imageTheme.imageMaxHeight,
                        spanImageAsyncConfiguration.markdownTheme.imageTheme.imageFixedRatioWidth,
                        spanImageAsyncConfiguration.markdownTheme.imageTheme.imageMaximumWidth
                    )
                    if (res[0] > 0.0 && res[1] > 0.0) {
                    spanImageAsyncNodeView.imageReplacePixelMap?.Release()
                    spanImageAsyncNodeView.imageReplacePixelMap = replacePixelMap
                    spanImageAsyncNodeView.imageReplaceWidth = Some(res[0])
                    spanImageAsyncNodeView.imageReplaceHeight = Some(res[1])
                    if (!isRawFileImageUrl(spanImageAsyncDestination)) {
                        // URL替换图写回节点尺寸缓存（本地图替换图不写回，避免污染原始图片缓存）
                        cacheImageSizeToNode(spanImageAsyncNodeView, replaceResWidth(), replaceResHeight(), res[0], res[1])
                    }
                    if (spanImageAsyncWidthCallback.isSome()) {
                        spanImageAsyncWidthCallback.getOrThrow()(px2vp(res[0].px).getOrThrow().value)
                    }
                    spanImageAsyncNodeView.spanRenderVersion += 1 // 版本号自增，使该节点item重建显示替换图片
                    spanImageAsyncOnAsyncUpdated()
                    } else {
                        // 尺寸无效（宽度基准未就绪）：不缓存结果，重置解析标记，待下次刷新重试
                        spanImageAsyncNodeView.imageReplaceTried = false
                    }
                }
            }
        }
        let fut = MarkdownParseImageUtil.callbackToPixelmap(spanImageAsyncDestination, spanImageAsyncConfiguration.imageReplaceCallback.getOrThrow(), replaceCallback)
    }
}
