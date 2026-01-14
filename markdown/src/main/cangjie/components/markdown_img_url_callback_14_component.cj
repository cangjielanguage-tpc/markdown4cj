/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.arkui.state_macro_manage.*

/**
 * 普通网络/沙盒图片、设置图片预处理接口、API15以下
 */
@Component
public class MarkdownImgUrlCallback14Component {
    /**
     * markdown配置
     */
    var markdownConfigurationUrlCallback14: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destinationUrlCallback14: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var componentWidthUrlCallback14: Float64

    /**
     * 链接点击事件
     */
    var linkCallbackUrlCallback14: ?(String) -> Unit

    /**
     * 图片点击事件
     */
    var imageCallbackUrlCallback14: (String) -> Unit

    /**
     * 是否是链接
     */
    var isLinkUrlCallback14: Bool = false

    /**
     * 链接url
     */
    var linkUrlUrlCallback14: ?String = Option<String>.None

    /**
     * 图片加载
     */
    @State
    var imageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片宽度 - 单位px
     */
    @State
    var widthUrlCallback14: Float64 = 0.0

    /**
     * 图片高度 - 单位px
     */
    @State
    var heightUrlCallback14: Float64 = 0.0

    /**
     * 替换之后的图片宽度 - 单位px
     */
    @State
    var imageWidthUrlCallback14: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片高度 - 单位px
     */
    @State
    var imageHeightUrlCallback14: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片数据
     */
    @State
    var imagePixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 解析加载
     */
    @State
    var imageParseUrlCallback14: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var componentImageWidth: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        componentImageWidth = getUIContext().vp2px(componentWidthUrlCallback14.vp)().value
        imageCallPixelmap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        imagePixelMap?.release()
        imagePixelMap = Option<PixelMap>.None
    }

    func build() {
        if (true) {
            if (imageParseUrlCallback14 == 1) {
                imageCallBackComponent(imagePixelMap(), markdownConfigurationUrlCallback14.markdownTheme.imageMarginTop, markdownConfigurationUrlCallback14.markdownTheme.imageMarginBottom, markdownConfigurationUrlCallback14.markdownTheme.imageBorderRadius, markdownConfigurationUrlCallback14.markdownTheme.imageFixedRatioWidth, componentImageWidth, imageWidthUrlCallback14(), imageHeightUrlCallback14(), markdownConfigurationUrlCallback14.markdownTheme.imageMaximumWidth, markdownConfigurationUrlCallback14, isLinkUrlCallback14, imageCallbackUrlCallback14, linkCallbackUrlCallback14, linkUrlUrlCallback14, destinationUrlCallback14)
            } else {
                if (imageType != 2) {
                    ImageSpan(destinationUrlCallback14)
                        // 设置外边距属性
                        .margin(top: markdownConfigurationUrlCallback14.markdownTheme.imageMarginTop, bottom: markdownConfigurationUrlCallback14.markdownTheme.imageMarginBottom)
                        // 自定义图片圆角
                        .interopBorderRadius(markdownConfigurationUrlCallback14.markdownTheme.imageBorderRadius)
                        // 设置组件自身的宽度
                        .width(imageSpanWidth(markdownConfigurationUrlCallback14.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthUrlCallback14, markdownConfigurationUrlCallback14.markdownTheme.imageMaximumWidth))
                        // 设置组件自身的高度
                        .height(imageSpanHeight(markdownConfigurationUrlCallback14.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthUrlCallback14, heightUrlCallback14, markdownConfigurationUrlCallback14.markdownTheme.imageMaximumWidth))
                        // 设置组件的可见性
                        .visibility(visibilityImageSpanType(imageType))
                        // 设置图片的缩放类型
                        .objectFit(markdownConfigurationUrlCallback14.markdownTheme.imageFitType)
                        // 设置图片基于文本的对齐方式
                        .verticalAlign(ImageSpanAlignment.Center)
                        // 设置约束尺寸，组件布局时，进行尺寸范围限制
                        .constraintSize(maxWidth: 100.percent)
                        // 点击动作触发该方法调用
                        .onClick ({evt => imageSpanOnClick(isLinkUrlCallback14, imageCallbackUrlCallback14, linkCallbackUrlCallback14, linkUrlUrlCallback14, destinationUrlCallback14)})
                        // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                        .interopOnComplete {
                            imageLoadResult =>
                                let res = imageSpanComplete(imageLoadResult.height, imageLoadResult.width, componentImageWidth)
                                widthUrlCallback14 = res[0]
                                heightUrlCallback14 = res[1]
                                imageType = 1
                        }
                        // 图片加载出现异常时触发该回调
                        .interopOnError {
                            imageError => imageType = 2
                        }
                }
            }
            if (markdownConfigurationUrlCallback14.markdownTheme.imageResource.isSome() && imageType != 1 && imageParseUrlCallback14 != 1) {
                // 有占位图
                imagePlaceholderComponent(markdownConfigurationUrlCallback14.markdownTheme.imageResource(), markdownConfigurationUrlCallback14.markdownTheme.imageMarginTop, markdownConfigurationUrlCallback14.markdownTheme.imageMarginBottom, markdownConfigurationUrlCallback14.markdownTheme.imageFixedRatioWidth, markdownConfigurationUrlCallback14.markdownTheme.imageMaximumWidth, markdownConfigurationUrlCallback14.markdownTheme.imageBorderRadius, componentImageWidth)
            }
        }
    }

    func imageCallPixelmap() {
        spawn {
            let data: ?Array<UInt8> = markdownConfigurationUrlCallback14.imageCallbackCallback()(destinationUrlCallback14)
            if (data.isSome()) {
                var imageSource: ImageSource = createImageSource(data())
                let pixelMap1: PixelMap = imageSource.createPixelMap()
                var size = pixelMap1.getImageInfo().size
                let imageWidthUrlCallback14: Float64 = Float64(size.width)
                let imageHeightUrlCallback14: Float64 = Float64(size.height)
                imageSource.release()
                launch {
                    this.imageWidthUrlCallback14 = imageWidthUrlCallback14
                    this.imageHeightUrlCallback14 = imageHeightUrlCallback14
                    this.imagePixelMap = pixelMap1
                    if (this.imagePixelMap.isSome() && this.imageWidthUrlCallback14.isSome() && this.imageHeightUrlCallback14.isSome()) {
                        imageParseUrlCallback14 = 1
                    } else {
                        imageParseUrlCallback14 = 2
                    }
                }
            } else {
                launch {
                    imageParseUrlCallback14 = 2
                }
            }
        }
    }
}
