/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 普通网络/沙盒图片、设置图片预处理接口、API15及以上
 */
@Component
public class MarkdownImgUrlCallback15Component {
    /**
     * markdown配置
     */
    var markdownConfigurationUrlCallback15: MarkdownConfiguration

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var componentWidthUrlCallback15: Float64

    /**
     * 图片链接
     */
    var destinationUrlCallback15: String

    /**
     * 图片点击事件
     */
    var imageCallbackUrlCallback15: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallbackUrlCallback15: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var isLinkUrlCallback15: Bool = false

    /**
     * 链接url
     */
    var linkUrlUrlCallback15: ?String = Option<String>.None

    /**
     * 图片加载
     */
    @State
    var imageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片高度 - 单位px
     */
    @State
    var heightUrlCallback15: Float64 = 0.0

    /**
     * 图片宽度 - 单位px
     */
    @State
    var widthUrlCallback15: Float64 = 0.0

    /**
     * 替换之后的图片宽度 - 单位px
     */
    @State
    var imageWidthUrlCallback15: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片高度 - 单位px
     */
    @State
    var imageHeightUrlCallback15: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片数据
     */
    @State
    var imagePixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 解析加载
     */
    @State
    var imageParse: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var componentImageWidth: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        componentImageWidth = vp2px(componentWidthUrlCallback15.vp)().value
        imageCallPixelmap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        imagePixelMap?.Release()
        imagePixelMap = Option<PixelMap>.None
    }

    func build() {
        if (true) {
            if (imageParse == 1) {
                imageCallBackComponent(imagePixelMap(), markdownConfigurationUrlCallback15.markdownTheme.imageMarginTop, markdownConfigurationUrlCallback15.markdownTheme.imageMarginBottom, markdownConfigurationUrlCallback15.markdownTheme.imageBorderRadius, markdownConfigurationUrlCallback15.markdownTheme.imageFixedRatioWidth, componentImageWidth, imageWidthUrlCallback15(), imageHeightUrlCallback15(), markdownConfigurationUrlCallback15.markdownTheme.imageMaximumWidth, markdownConfigurationUrlCallback15, isLinkUrlCallback15, imageCallbackUrlCallback15, linkCallbackUrlCallback15, linkUrlUrlCallback15, destinationUrlCallback15)
            } else {
                if (imageType != 2) {
                    ImageSpan(destinationUrlCallback15)
                        // 设置外边距属性
                        .margin(top: markdownConfigurationUrlCallback15.markdownTheme.imageMarginTop, bottom: markdownConfigurationUrlCallback15.markdownTheme.imageMarginBottom)
                        // 自定义图片圆角
                        .interopBorderRadius(markdownConfigurationUrlCallback15.markdownTheme.imageBorderRadius)
                        // 设置组件自身的宽度
                        .width(imageSpanWidth(markdownConfigurationUrlCallback15.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthUrlCallback15, markdownConfigurationUrlCallback15.markdownTheme.imageMaximumWidth))
                        // 设置组件自身的高度
                        .height(imageSpanHeight(markdownConfigurationUrlCallback15.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthUrlCallback15, heightUrlCallback15, markdownConfigurationUrlCallback15.markdownTheme.imageMaximumWidth))
                        // 设置组件的可见性
                        .visibility(visibilityImageSpanType(imageType))
                        // 设置图片的缩放类型
                        .objectFit(markdownConfigurationUrlCallback15.markdownTheme.imageFitType)
                        // 设置图片基于文本的对齐方式
                        .verticalAlign(ImageSpanAlignment.CENTER)
                        // 设置约束尺寸，组件布局时，进行尺寸范围限制
                        .constraintSize(maxWidth: 100.percent)
                        // 点击动作触发该方法调用
                        .onClick {evt => imageSpanOnClick(isLinkUrlCallback15, imageCallbackUrlCallback15, linkCallbackUrlCallback15, linkUrlUrlCallback15, destinationUrlCallback15)}
                        // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                        .onComplete {
                            imageLoadResult =>
                                let res = imageSpanComplete(imageLoadResult.height, imageLoadResult.width, componentImageWidth)
                                widthUrlCallback15 = res[0]
                                heightUrlCallback15 = res[1]
                                imageType = 1
                        }
                        // 图片加载出现异常时触发该回调
                        .onError {
                            imageError => imageType = 2
                        }
                }
            }
            if (markdownConfigurationUrlCallback15.markdownTheme.imageResource.isSome() && imageType != 1 && imageParse != 1) {
                // 有占位图
                imagePlaceholderComponent(markdownConfigurationUrlCallback15.markdownTheme.imageResource(), markdownConfigurationUrlCallback15.markdownTheme.imageMarginTop, markdownConfigurationUrlCallback15.markdownTheme.imageMarginBottom, markdownConfigurationUrlCallback15.markdownTheme.imageFixedRatioWidth, markdownConfigurationUrlCallback15.markdownTheme.imageMaximumWidth, markdownConfigurationUrlCallback15.markdownTheme.imageBorderRadius, componentImageWidth)
            }
        }
    }

    func imageCallPixelmap() {
        spawn {
            let data: ?Array<UInt8> = markdownConfigurationUrlCallback15.imageCallbackCallback()(destinationUrlCallback15)
            if (data.isSome()) {
                var imageSource: ImageSource = createImageSource(data())
                let pixelMap1: PixelMap = imageSource.createPixelMap()
                var size: Size = pixelMap1.getImageInfo().size
                let imageWidthUrlCallback15: Float64 = Float64(size.width)
                let imageHeightUrlCallback15: Float64 = Float64(size.height)
                imageSource.Release()
                launch {
                    this.imageWidthUrlCallback15 = imageWidthUrlCallback15
                    this.imageHeightUrlCallback15 = imageHeightUrlCallback15
                    this.imagePixelMap = pixelMap1
                    if (this.imagePixelMap.isSome() && this.imageWidthUrlCallback15.isSome() && this.imageHeightUrlCallback15.isSome()) {
                        imageParse = 1
                    } else {
                        imageParse = 2
                    }
                }
            } else {
                launch {
                    imageParse = 2
                }
            }
        }
    }
}
