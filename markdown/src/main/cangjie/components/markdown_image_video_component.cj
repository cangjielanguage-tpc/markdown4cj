/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 视频
 */
@Component
public class MarkdownImageVideoComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 视频频内容
     */
    var nodeView: NodeView

    /**
     * 视频点击事件
     */
    var videoCallback: (String) -> Unit

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
        let nodeViews: ArrayList<NodeView> = nodeView.children
        for (node in nodeViews) {
            if (node.node is CommonmarkImage) {
                imageVideoUrl = (node.node as CommonmarkImage)().getDestination()
            }
        }
        markdownConfiguration.videoImageCallback(
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
                // 设置组件自身的宽度
                .width(100.percent)

                Text(time)
                    // 设置文本颜色
                    .fontColor(markdownConfiguration.markdownTheme.videoTimeTextColor)
                    // 设置文本尺寸
                    .fontSize(markdownConfiguration.markdownTheme.videoTimeTextSize)
                    // 设置外边距属性
                    .margin(right: markdownConfiguration.markdownTheme.videoTimeTextMarginRight, bottom: markdownConfiguration.markdownTheme.videoTimeTextMarginBottom)
            }
            // 设置组件自身的宽度
            .width(100.percent)
            // 点击动作触发该方法调用
            .onClick {evt => videoOnClick(imageVideoUrl, videoCallback)}
            imgVideoButtonComponent()
        }
    }

    @Builder
    func imgVideoButtonComponent() {
        Row(8) {
            Row(6) {
                if (markdownConfiguration.markdownTheme.videoReleaseImage.isSome()) {
                    Image(markdownConfiguration.markdownTheme.videoReleaseImage())
                        .width(markdownConfiguration.markdownTheme.videoReleaseImageWidthHeight)
                        .height(markdownConfiguration.markdownTheme.videoReleaseImageWidthHeight)
                        .fillColor(markdownConfiguration.markdownTheme.videoReleaseTexColor) // 强制设为黑色，避免看不清
                }
                Text(markdownConfiguration.markdownTheme.videoReleaseText)
                    .fontSize(markdownConfiguration.markdownTheme.videoReleaseTexSize)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(markdownConfiguration.markdownTheme.videoReleaseTexColor)
            }
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .width(markdownConfiguration.markdownTheme.videoReleaseWidth)
            .height(markdownConfiguration.markdownTheme.videoReleaseHeight)
            .borderRadius(markdownConfiguration.markdownTheme.videoReleaseRadius)
            .backgroundColor(markdownConfiguration.markdownTheme.videoReleaseBackgroundColor)
            // 点击动作触发该方法调用
            .onClick {evt =>
                if (markdownConfiguration.videoReleaseCallback.isSome()) {
                    markdownConfiguration.videoReleaseCallback()(imageVideoUrl)
                }
            }
            Row(6) {
                if (markdownConfiguration.markdownTheme.videoDownloadImage.isSome()) {
                    Image(markdownConfiguration.markdownTheme.videoDownloadImage())
                        .width(markdownConfiguration.markdownTheme.videoDownloadImageWidthHeight)
                        .height(markdownConfiguration.markdownTheme.videoDownloadImageWidthHeight)
                        .fillColor(markdownConfiguration.markdownTheme.videoDownloadTexColor)
                }

                Text(markdownConfiguration.markdownTheme.videoDownloadText)
                    .fontSize(markdownConfiguration.markdownTheme.videoDownloadTexSize)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(markdownConfiguration.markdownTheme.videoDownloadTexColor)
            }
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .width(markdownConfiguration.markdownTheme.videoDownloadWidth)
            .height(markdownConfiguration.markdownTheme.videoDownloadHeight)
            .borderRadius(markdownConfiguration.markdownTheme.videoDownloadRadius)
            .backgroundColor(markdownConfiguration.markdownTheme.videoDownloadBackgroundColor)
            // 点击动作触发该方法调用
            .onClick {evt =>
                if (markdownConfiguration.videoDownloadCallback.isSome()) {
                    markdownConfiguration.videoDownloadCallback()(imageVideoUrl)
                }
            }
        }
        .margin(top: 14)
    }

    /**
     * 视频
     */
    @Builder
    func imgVideoComponent() {
        if (imageUrl == "") {
            if (markdownConfiguration.markdownTheme.videoImage.isSome()) {
                // 设置图片的数据源
                Image(markdownConfiguration.markdownTheme.videoImage())
                    // 设置组件自身的宽度
                    .width(100.percent)
                    .aspectRatio(aspectRatio)
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Cover)
                    // 设置圆角
                    .borderRadius(markdownConfiguration.markdownTheme.videoBorderRadius)
            }
        } else {
            // 设置图片的数据源
            Image(imageUrl)
                // 设置组件自身的宽度
                .width(100.percent)
                // 指定当前组件的宽高比
                .aspectRatio(aspectRatio)
                // 设置图片的缩放类型
                .objectFit(ImageFit.Cover)
                // 设置圆角
                .borderRadius(markdownConfiguration.markdownTheme.videoBorderRadius)
        }

        // 视频播放按钮
        if (markdownConfiguration.markdownTheme.playCircleFillIcon.isSome()) {
            // 设置图片的数据源
            Image(markdownConfiguration.markdownTheme.playCircleFillIcon())
                // 设置组件自身的宽度
                .width(60)
                // 设置组件自身的高度
                .height(60)
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
        }
    }
}
