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
public class MarkdownAIImageVideoComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 视频频内容
     */
    var nodeView: NodeView

    /**
     * 上边距 - 单位vp
     */
    var marginTop: Float64

    /**
     * 下边距 - 单位vp
     */
    var marginBottom: Float64

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
        markdownAIConfiguration.videoImageCallback(
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
        Stack(Alignment.BottomEnd) {
            Stack(Alignment.Center) {
                imgVideoComponent()
            }
            // 设置组件自身的宽度
            .width(100.percent)

            Text(time)
                // 设置文本颜色
                .fontColor(markdownAIConfiguration.markdownAITheme.videoTimeTextColor)
                // 设置文本尺寸
                .fontSize(markdownAIConfiguration.markdownAITheme.videoTimeTextSize)
                // 设置外边距属性
                .margin(right: markdownAIConfiguration.markdownAITheme.videoTimeTextMarginRight, bottom: markdownAIConfiguration.markdownAITheme.videoTimeTextMarginBottom)
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
        // 点击动作触发该方法调用
        .onClick {evt => videoOnClick(imageVideoUrl, videoCallback)}
    }

    /**
     * 视频
     */
    @Builder
    func imgVideoComponent() {
        if (imageUrl == "") {
            if (markdownAIConfiguration.markdownAITheme.videoImage.isSome()) {
                // 设置图片的数据源
                Image(markdownAIConfiguration.markdownAITheme.videoImage())
                    // 设置组件自身的宽度
                    .width(100.percent)
                    .aspectRatio(aspectRatio)
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Cover)
                    // 设置圆角
                    .borderRadius(markdownAIConfiguration.markdownAITheme.videoBorderRadius)
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
                .borderRadius(markdownAIConfiguration.markdownAITheme.videoBorderRadius)
        }

        // 视频播放按钮
        if (markdownAIConfiguration.markdownAITheme.playCircleFillIcon.isSome()) {
            // 设置图片的数据源
            Image(markdownAIConfiguration.markdownAITheme.playCircleFillIcon())
                // 设置组件自身的宽度
                .width(60)
                // 设置组件自身的高度
                .height(60)
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
        }
    }
}
