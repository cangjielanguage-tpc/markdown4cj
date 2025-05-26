/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown视频自定义页面
 */
@Component
class MarkdownVideoComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 视频节点
     */
    var imgVideo: ImgVideo

    /**
     * 回调得到的图片
     */
    @State
    var imageUrl: String = ""

    func build() {
        Stack(Alignment.Center) {
            imgVideoComponent()
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 点击动作触发该方法调用
        .onClick {evt => videoOnClick(imgVideo.getDestination(), markdownConfiguration.videoCallback)}
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
                    // 指定当前组件的宽高比
                    .aspectRatio(16.0 / 9.0)
                    // 控制当前组件显示或隐藏
                    .visibility(isVisibility(imageUrl == ""))
                    // 组件挂载显示时触发此回调
                    .onAppear({=> markdownConfiguration.videoImageCallback(imgVideo.getDestination(), {cover: String => imageUrl = cover})})
            } else {
                // 设置图片的数据源
                Image("")
                    // 设置组件自身的宽度
                    .width(100.percent)
                    // 指定当前组件的宽高比
                    .aspectRatio(16.0 / 9.0)
                    // 控制当前组件显示或隐藏
                    .visibility(isVisibility(imageUrl == ""))
                    // 组件挂载显示时触发此回调
                    .onAppear({=> markdownConfiguration.videoImageCallback(imgVideo.getDestination(), {cover: String => imageUrl = cover})})
            }
        } else {
            // 设置图片的数据源
            Image(imageUrl)
                // 设置组件自身的宽度
                .width(100.percent)
                // 指定当前组件的宽高比
                .aspectRatio(16.0 / 9.0)
                // 控制当前组件显示或隐藏
                .visibility(isVisibility(imageUrl != ""))
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
