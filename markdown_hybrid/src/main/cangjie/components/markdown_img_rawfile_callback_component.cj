/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.arkui.state_macro_manage.*

/**
 * 普通本地图片、设置图片预处理接口
 */
@Component
public class MarkdownImgRawFileCallbackComponent {
    /**
     * markdown配置
     */
    var markdownConfigurationRawFileCallback: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destinationRawFileCallback: String

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidthRawFileCallback: Float64

    /**
     * 图片点击事件
     */
    var imageCallbackRawFileCallback: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallbackRawFileCallback: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var isLinkRawFileCallback: Bool = false

    /**
     * 链接url
     */
    var linkUrlRawFileCallback: ?String = Option<String>.None

    /**
     * 图片加载完成
     */
    @State
    var imageType: Int64 = 0 // 0:开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片宽度 - 单位px
     */
    @State
    var widthRawFileCallback: ?Float64 = Option<Float64>.None

    /**
     * 图片高度 - 单位px
     */
    @State
    var heightRawFileCallback: ?Float64 = Option<Float64>.None

    /**
     * 图片数据
     */
    @State
    var imagePixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 替换之后的图片宽度 - 单位px
     */
    @State
    var imageWidthRawFileCallback: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片高度 - 单位px
     */
    @State
    var imageHeightRawFileCallback: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片数据
     */
    @State
    var imagePixelMap1: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 解析加载完成
     */
    @State
    var imageParse: Int64 = 0 // 0:开始解析。1：解析成功完成。2：解析失败

    /**
     * 控件宽度 - 单位px
     */
    @State
    var componentImageWidth: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        componentImageWidth = getUIContext().vp2px(componentWidthRawFileCallback.vp)().value
        imageCallPixelmap()
        localRowImageToPixelMap()
    }

    protected override func aboutToDisappear(): Unit {
        imagePixelMap1?.release()
        imagePixelMap1 = Option<PixelMap>.None
        imagePixelMap?.release()
        imagePixelMap = Option<PixelMap>.None
    }

    func build() {
        if (true) {
            if (imageParse == 1) {
                imageCallBackComponent(imagePixelMap1(), markdownConfigurationRawFileCallback.markdownTheme.imageMarginTop, markdownConfigurationRawFileCallback.markdownTheme.imageMarginBottom, markdownConfigurationRawFileCallback.markdownTheme.imageBorderRadius, markdownConfigurationRawFileCallback.markdownTheme.imageFixedRatioWidth, componentImageWidth, imageWidthRawFileCallback(), imageHeightRawFileCallback(), markdownConfigurationRawFileCallback.markdownTheme.imageMaximumWidth, markdownConfigurationRawFileCallback, isLinkRawFileCallback, imageCallbackRawFileCallback, linkCallbackRawFileCallback, linkUrlRawFileCallback, destinationRawFileCallback)
            } else {
                if (imageType == 1) {
                    ImageSpan(imagePixelMap())
                        // 设置外边距属性
                        .margin(top: markdownConfigurationRawFileCallback.markdownTheme.imageMarginTop, bottom: markdownConfigurationRawFileCallback.markdownTheme.imageMarginBottom)
                        // 自定义图片圆角
                        .interopBorderRadius(markdownConfigurationRawFileCallback.markdownTheme.imageBorderRadius)
                        // 设置组件自身的宽度
                        .width(imageSpanWidth(markdownConfigurationRawFileCallback.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthRawFileCallback(), markdownConfigurationRawFileCallback.markdownTheme.imageMaximumWidth))
                        // 设置组件自身的高度
                        .height(imageSpanHeight(markdownConfigurationRawFileCallback.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthRawFileCallback(), heightRawFileCallback(), markdownConfigurationRawFileCallback.markdownTheme.imageMaximumWidth))
                        // 设置图片的缩放类型
                        .objectFit(markdownConfigurationRawFileCallback.markdownTheme.imageFitType)
                        // 设置图片基于文本的对齐方式
                        .verticalAlign(ImageSpanAlignment.Center)
                        // 设置约束尺寸，组件布局时，进行尺寸范围限制
                        .constraintSize(maxWidth: 100.percent)
                        // 点击动作触发该方法调用
                        .onClick ({evt => imageSpanOnClick(isLinkRawFileCallback, imageCallbackRawFileCallback, linkCallbackRawFileCallback, linkUrlRawFileCallback, destinationRawFileCallback)})
                }
            }
            if (markdownConfigurationRawFileCallback.markdownTheme.imageResource.isSome() && imageType != 1 && imageParse != 1) {
                // 有占位图
                imagePlaceholderComponent(markdownConfigurationRawFileCallback.markdownTheme.imageResource(), markdownConfigurationRawFileCallback.markdownTheme.imageMarginTop, markdownConfigurationRawFileCallback.markdownTheme.imageMarginBottom, markdownConfigurationRawFileCallback.markdownTheme.imageFixedRatioWidth, markdownConfigurationRawFileCallback.markdownTheme.imageMaximumWidth, markdownConfigurationRawFileCallback.markdownTheme.imageBorderRadius, componentImageWidth)
            }
        }
    }

    func imageCallPixelmap() {
        spawn {
            let data: ?Array<UInt8> = markdownConfigurationRawFileCallback.imageCallbackCallback()(destinationRawFileCallback)
            if (data.isSome()) {
                var imageSource: ImageSource = createImageSource(data())
                let pixelMap1: PixelMap = imageSource.createPixelMap()
                var sizeRawFileCallback = pixelMap1.getImageInfo().size
                let imageWidthRawFileCallback: Float64 = Float64(sizeRawFileCallback.width)
                let imageHeightRawFileCallback: Float64 = Float64(sizeRawFileCallback.height)
                imageSource.release()
                launch {
                    this.imageWidthRawFileCallback = imageWidthRawFileCallback
                    this.imageHeightRawFileCallback = imageHeightRawFileCallback
                    this.imagePixelMap1 = pixelMap1
                    if (this.imagePixelMap1.isSome() && this.imageWidthRawFileCallback.isSome() && this.imageHeightRawFileCallback.isSome()) {
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

    /**
     * 图片数据处理 - 本地rawfile图片
     */
    func localRowImageToPixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            pixelMap, widthRawFileCallback, heightRawFileCallback => launch {
                this.imagePixelMap = pixelMap
                this.widthRawFileCallback = widthRawFileCallback
                this.heightRawFileCallback = heightRawFileCallback
                if (this.imagePixelMap.isSome() && this.widthRawFileCallback.isSome() && this.heightRawFileCallback.isSome()) {
                    imageType = 1
                } else {
                    imageType = 2
                }
            }
        }
        let fut = rawfileToPixelmap(destinationRawFileCallback, markdownConfigurationRawFileCallback.markdownTheme.context, componentImageWidth, callback)
    }
}
