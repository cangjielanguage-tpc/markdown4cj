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
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destination: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var componentWidth: Float64

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallback: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var isLink: Bool = false

    /**
     * 链接url
     */
    var linkUrl: ?String = Option<String>.None

    /**
     * 图片加载
     */
    @State
    var imageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

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
     * 替换之后的图片宽度 - 单位px
     */
    @State
    var imageWidth: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片高度 - 单位px
     */
    @State
    var imageHeight: ?Float64 = Option<Float64>.None

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
     * 图片上边距
     */
    @State
    var imageMarginTop: Float64 = 10.0

    /**
     * 图片下边距
     */
    @State
    var imageMarginBottom: Float64 = 10.0

    /**
     * 图片圆角大小
     */
    @State
    var imageBorderRadius: Float64 = 0.0

    /**
     * 基于外层控件宽度大小对图片进行百分比缩放比例
     */
    @State
    var imageFixedRatioWidth: Option<Float64> = Option<Float64>.None

    /**
     * 基于图片自身宽度大小对图片进行百分比缩放比例
     */
    @State
    var imageMaximumWidth: Float64 = 1.0

    /**
     * 图片占位图
     */
    @State
    var imageResource: Option<AppResource> = Option<AppResource>.None

    /**
     * 是否有图片占位图
     */
    @State
    var isImageResource: Bool = false

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var componentImageWidth: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        imageMarginTop = markdownConfiguration.markdownTheme.imageMarginTop
        imageMarginBottom = markdownConfiguration.markdownTheme.imageMarginBottom
        imageBorderRadius = markdownConfiguration.markdownTheme.imageBorderRadius
        imageFixedRatioWidth = markdownConfiguration.markdownTheme.imageFixedRatioWidth
        imageMaximumWidth = markdownConfiguration.markdownTheme.imageMaximumWidth
        imageResource = markdownConfiguration.markdownTheme.imageResource
        if (imageResource.isSome()) {
            isImageResource = true
        } else {
            isImageResource = false
        }
        componentImageWidth = vp2px(componentWidth.vp)().value
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
                ImageSpan(imagePixelMap())
                    // 设置外边距属性
                    .margin(top: imageMarginTop, bottom: imageMarginBottom)
                    // 自定义图片圆角
                    .interopBorderRadius(imageBorderRadius)
                    // 设置组件自身的宽度
                    .width(imageSpanWidth(imageFixedRatioWidth, componentImageWidth, imageWidth(), imageMaximumWidth))
                    // 设置组件自身的高度
                    .height(imageSpanHeight(imageFixedRatioWidth, componentImageWidth, imageWidth(), imageHeight(), imageMaximumWidth))
                    // 设置图片的缩放类型
                    .objectFit(markdownConfiguration.markdownTheme.imageFitType)
                    // 设置图片基于文本的对齐方式
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    // 点击动作触发该方法调用
                    .onClick {evt => imageSpanOnClick(isLink, imageCallback, linkCallback, linkUrl, destination)}
            } else {
                if (imageType != 2) {
                    ImageSpan(destination)
                        // 设置外边距属性
                        .margin(top: imageMarginTop, bottom: imageMarginBottom)
                        // 自定义图片圆角
                        .interopBorderRadius(imageBorderRadius)
                        // 设置组件自身的宽度
                        .width(imageSpanWidth(imageFixedRatioWidth, componentImageWidth, width, imageMaximumWidth))
                        // 设置组件自身的高度
                        .height(imageSpanHeight(imageFixedRatioWidth, componentImageWidth, width, height, imageMaximumWidth))
                        // 设置组件的可见性
                        .visibility(visibilityImageSpanType(imageType))
                        // 设置图片的缩放类型
                        .objectFit(markdownConfiguration.markdownTheme.imageFitType)
                        // 设置图片基于文本的对齐方式
                        .verticalAlign(ImageSpanAlignment.CENTER)
                        // 设置约束尺寸，组件布局时，进行尺寸范围限制
                        .constraintSize(maxWidth: 100.percent)
                        // 点击动作触发该方法调用
                        .onClick {evt => imageSpanOnClick(isLink, imageCallback, linkCallback, linkUrl, destination)}
                        // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                        .onComplete {
                            imageLoadResult =>
                                let res = imageSpanComplete(imageLoadResult.height, imageLoadResult.width, componentImageWidth)
                                width = res[0]
                                height = res[1]
                                imageType = 1
                        }
                        // 图片加载出现异常时触发该回调
                        .onError {
                            imageError => imageType = 2
                        }
                }
            }
            if (isImageResource && imageType != 1 && imageParse != 1) {
                // 有占位图
                imagePlaceholderComponent(imageResource(), imageMarginTop, imageMarginBottom, imageFixedRatioWidth, imageMaximumWidth, imageBorderRadius, componentImageWidth)
            }
        }
    }

    func imageCallPixelmap() {
        spawn {
            let data: ?Array<UInt8> = markdownConfiguration.imageCallbackCallback()(destination)
            if (data.isSome()) {
                var imageSource: ImageSource = createImageSource(data())
                let pixelMap1: PixelMap = imageSource.createPixelMap()
                var size: Size = pixelMap1.getImageInfo().size
                let imageWidth1: Float64 = Float64(size.width)
                let imageHeight1: Float64 = Float64(size.height)
                imageSource.Release()
                launch {
                    this.imageWidth = imageWidth1
                    this.imageHeight = imageHeight1
                    this.imagePixelMap = pixelMap1
                    if (this.imagePixelMap.isSome() && this.imageWidth.isSome() && this.imageHeight.isSome()) {
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
