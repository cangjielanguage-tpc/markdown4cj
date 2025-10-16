/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 不图文混排、网络和沙盒图片、固定宽高比例、做图片预处理
 */
@Component
public class MarkdownImgPixelmapRatioComponent {
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
     * 链接点击事件
     */
    var linkCallback: ?(String) -> Unit

    /**
     * 图片默认占位图
     */
    var imagePlaceholder: ?String = None

    /**
     * 是否是连接中的图片
     */
    var isLink: Bool = false

    /**
     * 链接点击事件
     */
    var linkUrl: ?String = Option<String>.None

    /**
     * 图片预处理回调事件
     */
    var imageCallbackCallback: (String) -> ?Array<UInt8>

    /**
     * 图片宽度 - 单位px
     */
    @State
    var imageWidth: ?Float64 = Option<Float64>.None

    /**
     * 图片高度 - 单位px
     */
    @State
    var imageHeight: ?Float64 = Option<Float64>.None

    /**
     * 图片数据
     */
    @State
    var imagePixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 解析是否结束
     */
    @State
    var isBool: Bool = false

    /**
     * 图片圆角
     */
    var imageBorderRadius: Float64 = 0.0

    /**
     * 图片固定宽高比
     */
    var imageAspectRatioSize: Float64 = 16.0 / 9.0

    /**
     * 图片最大宽度百分比
     */
    var imageMaximumWidth: Float64 = 1.0

    /**
     * 图片是否压缩
     */
    var isAutoResize: Bool = true

    protected override func aboutToAppear(): Unit {
        imageCallPixelmap()
        componentWidth = px2vp(componentWidth.px)
            .getOrThrow()
            .value
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        imagePixelMap?.Release()
    }

    func build() {
        if (true) {
            Image(destination)
                // 设置外边距属性
                .margin(top: imageMarginTop, bottom: imageMarginBottom)
                // 自定义图片圆角
                .borderRadius(imageBorderRadius)
                // 设置组件的可见性
                .visibility(
                    if (!(isBool && imagePixelMap.isSome() && imageWidth.isSome() && imageHeight.isSome())) {
                        Visibility.Visible
                    } else {
                        Visibility.None
                    })
                // 设置组件自身的宽度
                .width(componentWidth * imageMaximumWidth)
                // 设置组件自身的高度
                .height(componentWidth / imageAspectRatioSize * imageMaximumWidth)
                // 设置图片解码过程中是否对图源自动缩放
                .autoResize(isAutoResize)
                // 设置图片的缩放类型
                .objectFit(ImageFit.Cover)
                // 点击动作触发该方法调用
                .onClick {
                    evt => if (isLink) {
                        if (linkCallback.isSome() && linkUrl.isSome()) {
                            linkCallback()(linkUrl())
                        }
                    } else {
                        imageOnClick(destination, imageCallback)
                    }
                }
            if (isBool && imagePixelMap.isSome() && imageWidth.isSome() && imageHeight.isSome()) {
                Image(imagePixelMap())
                    // 设置外边距属性
                    .margin(top: imageMarginTop, bottom: imageMarginBottom)
                    // 自定义图片圆角
                    .borderRadius(imageBorderRadius)
                    // 设置组件自身的宽度
                    .width((imageWidth() * imageMaximumWidth).px)
                    // 设置组件自身的高度
                    .height((imageHeight() * imageMaximumWidth).px)
                    // 设置图片解码过程中是否对图源自动缩放
                    .autoResize(isAutoResize)
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Contain)
                    // 点击动作触发该方法调用
                    .onClick {
                        evt => if (isLink) {
                            if (linkCallback.isSome() && linkUrl.isSome()) {
                                linkCallback()(linkUrl())
                            }
                        } else {
                            imageOnClick(destination, imageCallback)
                        }
                    }
            }
        }
    }

    func imageCallPixelmap() {
        spawn {
            let data: ?Array<UInt8> = imageCallbackCallback(destination)
            launch {
                isBool = true
            }
            if (data.isSome()) {
                var imageSource: ImageSource = createImageSource(data())
                let pixelMap1: PixelMap = imageSource.createPixelMap()
                var size: Size = pixelMap1.getImageInfo().size
                let imageWidth1: Float64 = Float64(size.width)
                let imageHeight1: Float64 = Float64(size.height)
                imageSource.Release()
                launch {
                    imageWidth = imageWidth1
                    imageHeight = imageHeight1
                    imagePixelMap = pixelMap1
                }
            }
        }
    }
}
