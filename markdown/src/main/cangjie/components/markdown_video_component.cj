package markdown.components

import ohos.state_macro_manage.*

/**
 * 视频控件
 */
@Component
public class MarkdownVideoComponent {
    var markdownTheme: MarkdownTheme // markdown样式
    var nodeView: NodeView // NodeView
    var videoCallback: (String) -> Unit // 视频点击事件
    var videoImageCallback: (String, (String, Float64, Int64) -> Unit) -> Unit // 视频的图片替换回调
    var videoReleaseCallback: ?(String) -> Unit // 视频发布的点击事件
    var videoDownloadCallback: ?(String) -> Unit // 视频下载的点击事件
    @State
    var imageVideoUrl: String = "" // 视频链接
    @State
    var imageUrl: String = "" // 回调得到的图片
    @State
    var aspectRatio: Float64 = 16.0 / 9.0 // 图片宽高比
    @State
    var time: String = "" // 视频时长

    protected override func aboutToAppear(): Unit {
        imageVideoUrl = nodeView.imageUrl()
        // 视频的图片替换回调
        videoImageCallback(
            imageVideoUrl,
            {
                imageUrl: String, aspectRatio: Float64, time: Int64 =>
                    this.imageUrl = imageUrl
                    this.aspectRatio = aspectRatio
                    this.time = formatTime(time)
            }
        )
    }

    func build() {
        Column() {
            Stack(Alignment.BottomEnd) {
                Stack(Alignment.Center) {
                    imgVideoComponent()
                }
                .width(100.percent)
                Text(time)
                    .fontFamily(markdownTheme.videoTheme.videoTimeTextFontFamily)
                    .fontSize(markdownTheme.videoTheme.videoTimeTextFontSize)
                    .fontWeight(markdownTheme.videoTheme.videoTimeTextFontWeight)
                    .fontStyle(markdownTheme.videoTheme.videoTimeTextFontStyle)
                    .fontColor(markdownTheme.videoTheme.videoTimeTextFontColor)
                    .lineHeight(markdownTheme.videoTheme.videoTimeTextLineHeight)
                    .margin(right: markdownTheme.videoTheme.videoTimeTextMarginRight, bottom: markdownTheme.videoTheme.videoTimeTextMarginBottom)
            }
            .width(100.percent)
            .onClick {
                evt => videoCallback(imageVideoUrl)
            }
            if (markdownTheme.videoTheme.videoBottomLayoutVisible) {
                imgVideoButtonComponent()
            }
        }
        .width(100.percent)
        .backgroundColor(markdownTheme.videoTheme.videoBackgroundColor)
        .padding(
            top: markdownTheme.videoTheme.videoPaddingTop,
            right: markdownTheme.videoTheme.videoPaddingRight,
            bottom: markdownTheme.videoTheme.videoPaddingBottom,
            left: markdownTheme.videoTheme.videoPaddingLeft
        )
    }

    /**
     * 视频图片
     */
    @Builder
    func imgVideoComponent() {
        if (imageUrl == "") {
            if (markdownTheme.videoTheme.videoPlaceholder.isSome()) {
                Image(markdownTheme.videoTheme.videoPlaceholder())
                    .width(100.percent)
                    .aspectRatio(aspectRatio)
                    .objectFit(markdownTheme.videoTheme.videoImageFitType)
                    .borderRadius(topLeft: markdownTheme.videoTheme.videoRadiusTopLeft, topRight: markdownTheme.videoTheme.videoRadiusTopRight, bottomLeft: markdownTheme.videoTheme.videoRadiusBottomLeft, bottomRight: markdownTheme.videoTheme.videoRadiusBottomRight)
                    .borderWidth(markdownTheme.videoTheme.videoBorderWidth)
                    .borderColor(markdownTheme.videoTheme.videoBorderColor)
                    .borderStyle(markdownTheme.videoTheme.videoBorderStyle)
            }
        } else {
            Image(imageUrl)
                .width(100.percent)
                .aspectRatio(aspectRatio)
                .objectFit(markdownTheme.videoTheme.videoImageFitType)
                .borderRadius(topLeft: markdownTheme.videoTheme.videoRadiusTopLeft, topRight: markdownTheme.videoTheme.videoRadiusTopRight, bottomLeft: markdownTheme.videoTheme.videoRadiusBottomLeft, bottomRight: markdownTheme.videoTheme.videoRadiusBottomRight)
                .borderWidth(markdownTheme.videoTheme.videoBorderWidth)
                .borderColor(markdownTheme.videoTheme.videoBorderColor)
                .borderStyle(markdownTheme.videoTheme.videoBorderStyle)
        }

        if (markdownTheme.videoTheme.videoPlayIcon.isSome()) {
            Image(markdownTheme.videoTheme.videoPlayIcon())
                .width(markdownTheme.videoTheme.videoPlayIconWidth)
                .height(markdownTheme.videoTheme.videoPlayIconHeight)
                .objectFit(markdownTheme.videoTheme.videoPlayIconFitType)
        }
    }

    /**
     * 视频发布下载按钮布局
     */
    @Builder
    func imgVideoButtonComponent() {
        Row(8) {
            if (markdownTheme.videoTheme.videoReleaseButtonVisible) {
                Row(markdownTheme.videoTheme.videoReleaseButtonIconTextGap) {
                    if (markdownTheme.videoTheme.videoReleaseButtonIcon.isSome()) {
                        Image(markdownTheme.videoTheme.videoReleaseButtonIcon())
                            .width(markdownTheme.videoTheme.videoReleaseButtonIconWidth)
                            .height(markdownTheme.videoTheme.videoReleaseButtonIconHeight)
                            .fillColor(markdownTheme.videoTheme.videoReleaseButtonTextFontColor)
                    }
                    Text(markdownTheme.videoTheme.videoReleaseButtonText)
                        .fontFamily(markdownTheme.videoTheme.videoReleaseButtonTextFontFamily)
                        .fontSize(markdownTheme.videoTheme.videoReleaseButtonTextFontSize)
                        .fontWeight(markdownTheme.videoTheme.videoReleaseButtonTextFontWeight)
                        .fontStyle(markdownTheme.videoTheme.videoReleaseButtonTextFontStyle)
                        .fontColor(markdownTheme.videoTheme.videoReleaseButtonTextFontColor)
                        .lineHeight(markdownTheme.videoTheme.videoReleaseButtonTextLineHeight)
                }
                .width(markdownTheme.videoTheme.videoReleaseButtonWidth)
                .height(markdownTheme.videoTheme.videoReleaseButtonHeight)
                .borderRadius(topLeft: markdownTheme.videoTheme.videoReleaseButtonRadiusTopLeft, topRight: markdownTheme.videoTheme.videoReleaseButtonRadiusTopRight, bottomLeft: markdownTheme.videoTheme.videoReleaseButtonRadiusBottomLeft, bottomRight: markdownTheme.videoTheme.videoReleaseButtonRadiusBottomRight)
                .backgroundColor(markdownTheme.videoTheme.videoReleaseButtonBackgroundColor)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .onClick {
                    evt => if (videoReleaseCallback.isSome()) {
                        videoReleaseCallback()(imageVideoUrl)
                    }
                }
            }
            if (markdownTheme.videoTheme.videoDownloadButtonVisible) {
                Row(markdownTheme.videoTheme.videoDownloadButtonIconTextGap) {
                    if (markdownTheme.videoTheme.videoDownloadButtonIcon.isSome()) {
                        Image(markdownTheme.videoTheme.videoDownloadButtonIcon())
                            .width(markdownTheme.videoTheme.videoDownloadButtonIconWidth)
                            .height(markdownTheme.videoTheme.videoDownloadButtonIconHeight)
                            .fillColor(markdownTheme.videoTheme.videoDownloadButtonTextFontColor)
                    }
                    Text(markdownTheme.videoTheme.videoDownloadButtonText)
                        .fontFamily(markdownTheme.videoTheme.videoDownloadButtonTextFontFamily)
                        .fontSize(markdownTheme.videoTheme.videoDownloadButtonTextFontSize)
                        .fontWeight(markdownTheme.videoTheme.videoDownloadButtonTextFontWeight)
                        .fontStyle(markdownTheme.videoTheme.videoDownloadButtonTextFontStyle)
                        .fontColor(markdownTheme.videoTheme.videoDownloadButtonTextFontColor)
                        .lineHeight(markdownTheme.videoTheme.videoDownloadButtonTextLineHeight)
                }
                .width(markdownTheme.videoTheme.videoDownloadButtonWidth)
                .height(markdownTheme.videoTheme.videoDownloadButtonHeight)
                .borderRadius(topLeft: markdownTheme.videoTheme.videoDownloadButtonRadiusTopLeft, topRight: markdownTheme.videoTheme.videoDownloadButtonRadiusTopRight, bottomLeft: markdownTheme.videoTheme.videoDownloadButtonRadiusBottomLeft, bottomRight: markdownTheme.videoTheme.videoDownloadButtonRadiusBottomRight)
                .backgroundColor(markdownTheme.videoTheme.videoDownloadButtonBackgroundColor)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .onClick {
                    evt => if (videoDownloadCallback.isSome()) {
                        videoDownloadCallback()(imageVideoUrl)
                    }
                }
            }
        }
        .width(100.percent)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .margin(top: markdownTheme.videoTheme.videoBottomLayoutMarginTop)
    }
}
