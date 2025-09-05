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
public class MarkdownAIImageSpanComponent {
    /**
     * 图片链接
     */
    var destination: String

    /**
     * 控件宽度 - 单位px
     */
    @Prop
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

    /**
     * 图片上边距
     */
    var imageMarginTop: Float64 = 0.0

    /**
     * 图片下边距
     */
    var imageMarginBottom: Float64 = 0.0

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallback: ?(String) -> Unit

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

    var isLink: Bool = false

    var linkUrl: ?String = Option<String>.None

    func build() {
        if (!isCompleted && !isError) {
            if (imagePlaceholder.isSome()) {
                ImageSpan(imagePlaceholder())
                    // 设置外边距属性
                    .margin(top: imageMarginTop, bottom: imageMarginBottom)
                    // 设置组件自身的宽度
                    .width(100.percent)
                    // 设置组件自身的高度
                    .height(px2vp(componentWidth.px).getOrThrow().value / (16.0 / 9.0))
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Cover)
            } else {
                Span("")
            }
            ImageSpan(destination)
                // 是否隐藏
                .visibility(Visibility.None)
                // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                .onComplete({
                    imageLoadResult => isCompleted = true
                })
                // 图片加载出现异常时触发该回调
                .onError(
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
                .width(componentWidth.px)
                // 设置组件自身的高度
                .height(px2vp(componentWidth.px).getOrThrow().value / (16.0 / 9.0))
                // 设置图片的缩放类型
                .objectFit(ImageFit.Cover)
                // 点击动作触发该方法调用
                .onClick {
                    evt =>
                    if(isLink){
                        if(linkCallback.isSome() && linkUrl.isSome()){
                            linkCallback()(linkUrl())
                        }
                    } else {
                        imageOnClick(destination, imageCallback)
                    }
                }
                // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                .onComplete({
                    imageLoadResult => isCompleted = true
                })
                // 图片加载出现异常时触发该回调
                .onError({
                    imageError =>
                })
        } else {
            Span("")
        }
    }
}
