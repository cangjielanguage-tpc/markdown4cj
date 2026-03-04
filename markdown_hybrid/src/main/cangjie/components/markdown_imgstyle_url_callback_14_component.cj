/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 带样式的网络/沙盒图片、设置图片预处理接口、API15以下
 */
@Component
public class MarkdownImgStyleUrlCallback14Component {
    /**
     * markdown配置
     */
    var markdownConfigurationStyleUrlCallback14: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destinationStyleUrlCallback14: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var componentWidthStyleUrlCallback14: Float64

    /**
     * 图片样式
     */
    var picStyle: ArrayList<String>

    /**
     * 图片点击事件
     */
    var imageCallbackStyleUrlCallback14: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallbackStyleUrlCallback14: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var isLinkStyleUrlCallback14: Bool = false

    /**
     * 链接url
     */
    var linkUrlStyleUrlCallback14: ?String = Option<String>.None

    /**
     * 图片加载
     */
    @State
    var imageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片宽度 - 单位px
     */
    @State
    var widthStyleUrlCallback14: Float64 = 0.0

    /**
     * 图片高度 - 单位px
     */
    @State
    var heightStyleUrlCallback14: Float64 = 0.0

    /**
     * 替换之后的图片宽度 - 单位px
     */
    @State
    var imageWidthStyleUrlCallback14: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片高度 - 单位px
     */
    @State
    var imageHeightStyleUrlCallback14: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片数据
     */
    @State
    var imagePixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 解析加载
     */
    @State
    var imageParseStyleUrlCallback14: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var componentImageWidth: Float64 = 0.0

    /**
     *
     */
    @State
    var picStyleObjWidth: ?Length = Option<Length>.None

    /**
     *
     */
    @State
    var picStyleObjHeight: ?Length = Option<Length>.None

    /**
     * 图片圆角
     */
    @State
    var radius: Option<Length> = Option<Length>.None

    /**
     * 对齐方式 - 暂未支持
     */
    @State
    var align: FlexAlign = FlexAlign.Start

    protected override func aboutToAppear(): Unit {
        componentImageWidth = vp2px(componentWidthStyleUrlCallback14.vp)().value
        let picStyleObjStyleUrlCallback14: PicStyleObj = parsePicStyle(picStyle, componentImageWidth)
        if (picStyleObjStyleUrlCallback14.borderRadius.isSome()) {
            radius = picStyleObjStyleUrlCallback14.borderRadius()
        }
        align = picStyleObjStyleUrlCallback14.align
        picStyleObjWidth = picStyleObjStyleUrlCallback14.width
        picStyleObjHeight = picStyleObjStyleUrlCallback14.height
        imageCallPixelmap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        imagePixelMap?.Release()
        imagePixelMap = Option<PixelMap>.None
    }

    func build() {
        if (true) {
            if (imageParseStyleUrlCallback14 == 1) {
                imageCallBackComponent(imagePixelMap(), markdownConfigurationStyleUrlCallback14.markdownTheme.imageMarginTop, markdownConfigurationStyleUrlCallback14.markdownTheme.imageMarginBottom, markdownConfigurationStyleUrlCallback14.markdownTheme.imageBorderRadius, markdownConfigurationStyleUrlCallback14.markdownTheme.imageFixedRatioWidth, componentImageWidth, imageWidthStyleUrlCallback14(), imageHeightStyleUrlCallback14(), markdownConfigurationStyleUrlCallback14.markdownTheme.imageMaximumWidth, markdownConfigurationStyleUrlCallback14, isLinkStyleUrlCallback14, imageCallbackStyleUrlCallback14, linkCallbackStyleUrlCallback14, linkUrlStyleUrlCallback14, destinationStyleUrlCallback14)
            } else {
                if (imageType != 2) {
                    ImageSpan(destinationStyleUrlCallback14)
                        // 设置外边距属性
                        .margin(top: markdownConfigurationStyleUrlCallback14.markdownTheme.imageMarginTop, bottom: markdownConfigurationStyleUrlCallback14.markdownTheme.imageMarginBottom)
                        // 自定义图片圆角
                        .interopBorderRadius(imageSpanBorderRadius(radius, markdownConfigurationStyleUrlCallback14.markdownTheme.imageBorderRadius))
                        // 设置组件自身的宽度
                        .width(widthStyleUrlCallback14.px)
                        // 设置组件自身的高度
                        .height(heightStyleUrlCallback14.px)
                        // 设置组件的可见性
                        .visibility(visibilityImageSpanType(imageType))
                        // 设置图片的缩放类型
                        .objectFit(markdownConfigurationStyleUrlCallback14.markdownTheme.imageFitType)
                        // 设置图片基于文本的对齐方式
                        .verticalAlign(ImageSpanAlignment.CENTER)
                        // 设置约束尺寸，组件布局时，进行尺寸范围限制
                        .constraintSize(maxWidth: 100.percent)
                        // 点击动作触发该方法调用
                        .onClick {evt => imageSpanOnClick(isLinkStyleUrlCallback14, imageCallbackStyleUrlCallback14, linkCallbackStyleUrlCallback14, linkUrlStyleUrlCallback14, destinationStyleUrlCallback14)}
                        // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                        .interopOnComplete {
                            imageLoadResult =>
                                let res = imageWidthAndHeight(
                                    componentImageWidth,
                                    imageLoadResult.width,
                                    imageLoadResult.height,
                                    picStyleObjWidth,
                                    picStyleObjHeight,
                                    markdownConfigurationStyleUrlCallback14.markdownTheme.imageMaxHeight,
                                    markdownConfigurationStyleUrlCallback14.markdownTheme.imageFixedRatioWidth,
                                    markdownConfigurationStyleUrlCallback14.markdownTheme.imageMaximumWidth
                                )
                                widthStyleUrlCallback14 = res[0]
                                heightStyleUrlCallback14 = res[1]
                                imageType = 1
                        }
                        // 图片加载出现异常时触发该回调
                        .interopOnError {
                            imageError => imageType = 2
                        }
                }
            }
            if (markdownConfigurationStyleUrlCallback14.markdownTheme.imageResource.isSome() && imageType != 1 && imageParseStyleUrlCallback14 != 1) {
                // 有占位图
                imagePlaceholderComponent(markdownConfigurationStyleUrlCallback14.markdownTheme.imageResource(), markdownConfigurationStyleUrlCallback14.markdownTheme.imageMarginTop, markdownConfigurationStyleUrlCallback14.markdownTheme.imageMarginBottom, markdownConfigurationStyleUrlCallback14.markdownTheme.imageFixedRatioWidth, markdownConfigurationStyleUrlCallback14.markdownTheme.imageMaximumWidth, if (radius.isSome()) { length2Float(radius()) } else { markdownConfigurationStyleUrlCallback14.markdownTheme.imageBorderRadius }, componentImageWidth)
            }
        }
    }

    func imageCallPixelmap() {
        spawn {
            let data: ?Array<UInt8> = markdownConfigurationStyleUrlCallback14.imageCallbackCallback()(destinationStyleUrlCallback14)
            if (data.isSome()) {
                var imageSource: ImageSource = createImageSource(data())
                let pixelMap1: PixelMap = imageSource.createPixelMap()
                var size: Size = pixelMap1.getImageInfo().size
                let imageWidthStyleUrlCallback14: Float64 = Float64(size.width)
                let imageHeightStyleUrlCallback14: Float64 = Float64(size.height)
                imageSource.Release()
                launch {
                    this.imageWidthStyleUrlCallback14 = imageWidthStyleUrlCallback14
                    this.imageHeightStyleUrlCallback14 = imageHeightStyleUrlCallback14
                    this.imagePixelMap = pixelMap1
                    if (this.imagePixelMap.isSome() && this.imageWidthStyleUrlCallback14.isSome() && this.imageHeightStyleUrlCallback14.isSome()) {
                        imageParseStyleUrlCallback14 = 1
                    } else {
                        imageParseStyleUrlCallback14 = 2
                    }
                }
            } else {
                launch {
                    imageParseStyleUrlCallback14 = 2
                }
            }
        }
    }
}
