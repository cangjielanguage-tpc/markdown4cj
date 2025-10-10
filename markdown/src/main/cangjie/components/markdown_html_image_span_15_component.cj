/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * HTML图片
 */
@Component
public class MarkdownHtmlImageSpan15Component {
    /**
     * 图片内容
     */
    var destination: String

    /**
     * 图片宽度
     */
    var imageWidth: ?Float64

    /**
     * 图片高度
     */
    var imageHeight: ?Float64

    /**
     * 控件宽度 - 单位px
     */
    var componentWidth: Float64

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    /**
     * 图片上边距
     */
    var imageMarginTop: Float64 = 0.0

    /**
     * 图片下边距
     */
    var imageMarginBottom: Float64 = 0.0

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

    /**
     * 图片加载完成
     */
    @State
    var isCompleted: Bool = false

    /**
     * 图片加载异常
     */
    @State
    var isError: Bool = false

    /**
     * 图片默认占位图
     */
    var imagePlaceholder: ?String = None

    protected override func aboutToAppear(): Unit {
        componentWidth = px2vp(componentWidth.px).getOrThrow().value
    }

    func build() {
        if (!isCompleted && !isError) {
            if(imagePlaceholder.isSome()){
                ImageSpan(imagePlaceholder())
                    // 设置外边距属性
                    .margin(top: imageMarginTop, bottom: imageMarginBottom)
                    // 设置组件自身的宽度
                    .width(100.percent)
                    // 设置组件自身的高度
                    .height(px2vp(componentWidth.px).getOrThrow().value / (16.0 / 9.0))
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Cover)
            }
            ImageSpan(destination)
                // 是否隐藏
                .visibility(Visibility.None)
                // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                .interopOnComplete({
                    imageLoadResult => isCompleted = true
                })
                // 图片加载出现异常时触发该回调
                .interopOnError(
                    {
                        imageError =>
                        isError = true
                        isCompleted = true
                    }
                )
        } else if (isCompleted && !isError) {
            ImageSpan(destination)
                // 设置外边距属性
                .margin(top: imageMarginTop, bottom: imageMarginBottom)
                // 设置组件自身的宽度
                .width(100.percent)
                // 设置组件自身的高度
                .height(px2vp(componentWidth.px).getOrThrow().value / (16.0 / 9.0))
                // 设置图片的缩放类型
                .objectFit(ImageFit.Cover)
                // 点击动作触发该方法调用
                .onClick {
                    evt => imageOnClick(destination, imageCallback)
                }
                // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                .interopOnComplete({
                    imageLoadResult => isCompleted = true
                })
                // 图片加载出现异常时触发该回调
                .interopOnError({
                    imageError =>
                })
        } else {
            Span("")
        }
    }
}
