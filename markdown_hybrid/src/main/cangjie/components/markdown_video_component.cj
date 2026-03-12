/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2026. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 视频控件
 */
@Component
public class MarkdownVideoComponent {
    /**
     * markdown样式
     */
    var markdownTheme: MarkdownTheme

    /**
     * NodeView
     */
    var nodeView: NodeView

    /**
     * 视频点击事件
     */
    var videoCallback: (String) -> Unit

    /**
     * 视频的图片替换回调
     */
    var videoImageCallback: (String, (String, Float64, Int64) -> Unit) -> Unit

    /**
     * 视频发布的点击事件
     */
    var videoReleaseCallback: ?(String) -> Unit

    /**
     * 视频下载的点击事件
     */
    var videoDownloadCallback: ?(String) -> Unit

    /**
     * 视频链接
     */
    @State
    var imageVideoUrl: String = ""

    /**
     * 回调得到的图片
     */
    @State
    var imageUrl: String = ""

    /**
     * 图片宽高比
     */
    @State
    var aspectRatio: Float64 = 16.0 / 9.0

    /**
     * 视频时长
     */
    @State
    var time: String = ""

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
                    .fontColor(markdownTheme.videoTimeTextColor)
                    .fontSize(markdownTheme.videoTimeTextSize)
                    .margin(right: markdownTheme.videoTimeTextMarginRight, bottom: markdownTheme.videoTimeTextMarginBottom)
            }
            .width(100.percent)
            .onClick {
                evt => videoCallback(imageVideoUrl)
            }
            if (markdownTheme.isVideoBottomLayout) {
                imgVideoButtonComponent()
            }
        }
    }

    /**
     * 视频图片
     */
    @Builder
    func imgVideoComponent() {
        if (imageUrl == "") {
            if (markdownTheme.videoImage.isSome()) {
                Image(markdownTheme.videoImage())
                    .width(100.percent)
                    .aspectRatio(aspectRatio)
                    .objectFit(ImageFit.Cover)
                    .borderRadius(markdownTheme.videoBorderRadius)
            }
        } else {
            Image(imageUrl)
                .width(100.percent)
                .aspectRatio(aspectRatio)
                .objectFit(ImageFit.Cover)
                .borderRadius(markdownTheme.videoBorderRadius)
        }

        if (markdownTheme.playCircleFillIcon.isSome()) {
            Image(markdownTheme.playCircleFillIcon())
                .width(60)
                .height(60)
                .objectFit(ImageFit.Contain)
        }
    }

    /**
     * 视频发布下载按钮布局
     */
    @Builder
    func imgVideoButtonComponent() {
        Row(8) {
            Row(6) {
                if (markdownTheme.videoReleaseImage.isSome()) {
                    Image(markdownTheme.videoReleaseImage())
                        .width(markdownTheme.videoReleaseImageWidthHeight)
                        .height(markdownTheme.videoReleaseImageWidthHeight)
                        .fillColor(markdownTheme.videoReleaseTexColor)
                }
                Text(markdownTheme.videoReleaseText)
                    .fontSize(markdownTheme.videoReleaseTexSize)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(markdownTheme.videoReleaseTexColor)
            }
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .width(markdownTheme.videoReleaseWidth)
            .height(markdownTheme.videoReleaseHeight)
            .borderRadius(markdownTheme.videoReleaseRadius)
            .backgroundColor(markdownTheme.videoReleaseBackgroundColor)
            .onClick {
                evt => if (videoReleaseCallback.isSome()) {
                    videoReleaseCallback()(imageVideoUrl)
                }
            }
            Row(6) {
                if (markdownTheme.videoDownloadImage.isSome()) {
                    Image(markdownTheme.videoDownloadImage())
                        .width(markdownTheme.videoDownloadImageWidthHeight)
                        .height(markdownTheme.videoDownloadImageWidthHeight)
                        .fillColor(markdownTheme.videoDownloadTexColor)
                }
                Text(markdownTheme.videoDownloadText)
                    .fontSize(markdownTheme.videoDownloadTexSize)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(markdownTheme.videoDownloadTexColor)
            }
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .width(markdownTheme.videoDownloadWidth)
            .height(markdownTheme.videoDownloadHeight)
            .borderRadius(markdownTheme.videoDownloadRadius)
            .backgroundColor(markdownTheme.videoDownloadBackgroundColor)
            .onClick {
                evt => if (videoDownloadCallback.isSome()) {
                    videoDownloadCallback()(imageVideoUrl)
                }
            }
        }
        .margin(top: 14)
    }
}
