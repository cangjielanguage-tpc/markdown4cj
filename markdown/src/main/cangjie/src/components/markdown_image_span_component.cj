/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 网络图片、沙盒图片
 */
@Component
public class MarkdownImageSpanComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destination: String

    /**
     * 控件宽度 - 单位px
     */
    var componentWidth: Float64

    /**
     * 图片宽度 - 单位px
     */
    @State
    var width: Float64 = 0.0

    /**
     * 图片高度 - 单位px
     */
    @State
    var height: Float64 = 0.0

    func build() {
        ImageSpan(destination)
            // 设置组件自身的宽度
            .width(width.px)
            // 设置组件自身的高度
            .height(height.px)
            // 设置图片的缩放类型
            .objectFit(ImageFit.Contain)
            // 设置约束尺寸
            .constraintSize(maxWidth: 100.percent)
            // 点击动作触发该方法调用
            .onClick {
                evt => imageOnClick(destination, markdownConfiguration.imageCallback)
            }
            // 图片成功加载时触发该回调，返回成功加载的图片尺寸
            .onComplete(
                {
                    imageLoadResult =>
                    var aspectRatio: Float64 = imageLoadResult.height / imageLoadResult.width
                    width = if (componentWidth > imageLoadResult.width) {
                        imageLoadResult.width
                    } else {
                        componentWidth
                    }
                    height = width * aspectRatio
                }
            )
            // 图片加载出现异常时触发该回调
            .onError({
                imageError =>
            })
    }
}
