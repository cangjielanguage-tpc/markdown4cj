/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 带样式的网络/沙盒图片、设置图片预处理接口、API15及以上
 */
@Component
public class MarkdownImgStyleUrlCallback15Component {
    /**
     * markdown配置
     */
    var markdownConfigurationStyleUrlCallback15: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destinationStyleUrlCallback15: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var componentWidthStyleUrlCallback15: Float64

    /**
     * 图片样式
     */
    var picStyle: ArrayList<String>

    /**
     * 图片点击事件
     */
    var imageCallbackStyleUrlCallback15: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallbackStyleUrlCallback15: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var isLinkStyleUrlCallback15: Bool = false

    /**
     * 链接url
     */
    var linkUrlStyleUrlCallback15: ?String = Option<String>.None

    /**
     * 图片加载
     */
    @State
    var imageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片宽度 - 单位px
     */
    @State
    var widthStyleUrlCallback15: Float64 = 0.0

    /**
     * 图片高度 - 单位px
     */
    @State
    var heightStyleUrlCallback15: Float64 = 0.0

    /**
     * 替换之后的图片宽度 - 单位px
     */
    @State
    var imageWidthStyleUrlCallback15: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片高度 - 单位px
     */
    @State
    var imageHeightStyleUrlCallback15: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片数据
     */
    @State
    var imagePixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 解析加载
     */
    @State
    var imageParseStyleUrlCallback15: Int64 = 0 // 0：开始解析。1：解析成功完成。2：解析失败

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var componentImageWidth: Float64 = 0.0

    /**
     * 图片圆角
     */
    @State
    var radius: Option<Length> = Option<Length>.None

    /**
     *
     */
    @State
    var picStyleObjWidth: ?Float64 = Option<Float64>.None

    /**
     *
     */
    @State
    var picStyleObjHeight: ?Float64 = Option<Float64>.None

    /**
     * 对齐方式 - 暂未支持
     */
    @State
    var align: FlexAlign = FlexAlign.Start

    protected override func aboutToAppear(): Unit {
        componentImageWidth = vp2px(componentWidthStyleUrlCallback15.vp)().value
        let picStyleObjStyleUrlCallback15: PicStyleObj = parsePicStyle(picStyle, componentImageWidth)
        if (picStyleObjStyleUrlCallback15.borderRadius.isSome()) {
            radius = picStyleObjStyleUrlCallback15.borderRadius()
        }
        align = picStyleObjStyleUrlCallback15.align
        picStyleObjWidth = length2Float64(picStyleObjStyleUrlCallback15.width, componentImageWidth)
        picStyleObjHeight = length2Float64(picStyleObjStyleUrlCallback15.height, componentImageWidth)
        imageCallPixelmap()
    }

    protected override func aboutToDisappear(): Unit {
        // 清除缓存数据
        imagePixelMap?.Release()
        imagePixelMap = Option<PixelMap>.None
    }

    func build() {
        if (true) {
            if (imageParseStyleUrlCallback15 == 1) {
                imageCallBackComponent(imagePixelMap(), markdownConfigurationStyleUrlCallback15.markdownTheme.imageMarginTop, markdownConfigurationStyleUrlCallback15.markdownTheme.imageMarginBottom, markdownConfigurationStyleUrlCallback15.markdownTheme.imageBorderRadius, markdownConfigurationStyleUrlCallback15.markdownTheme.imageFixedRatioWidth, componentImageWidth, imageWidthStyleUrlCallback15(), imageHeightStyleUrlCallback15(), markdownConfigurationStyleUrlCallback15.markdownTheme.imageMaximumWidth, markdownConfigurationStyleUrlCallback15, isLinkStyleUrlCallback15, imageCallbackStyleUrlCallback15, linkCallbackStyleUrlCallback15, linkUrlStyleUrlCallback15, destinationStyleUrlCallback15)
            } else {
                if (imageType != 2) {
                    ImageSpan(destinationStyleUrlCallback15)
                        // 设置外边距属性
                        .margin(top: markdownConfigurationStyleUrlCallback15.markdownTheme.imageMarginTop, bottom: markdownConfigurationStyleUrlCallback15.markdownTheme.imageMarginBottom)
                        // 自定义图片圆角
                        .interopBorderRadius(imageSpanBorderRadius(radius, markdownConfigurationStyleUrlCallback15.markdownTheme.imageBorderRadius))
                        // 设置组件自身的宽度
                        .width(imageSpanWidth(markdownConfigurationStyleUrlCallback15.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthStyleUrlCallback15, markdownConfigurationStyleUrlCallback15.markdownTheme.imageMaximumWidth))
                        // 设置组件自身的高度
                        .height(imageSpanHeight(markdownConfigurationStyleUrlCallback15.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthStyleUrlCallback15, heightStyleUrlCallback15, markdownConfigurationStyleUrlCallback15.markdownTheme.imageMaximumWidth))
                        // 设置组件的可见性
                        .visibility(visibilityImageSpanType(imageType))
                        // 设置图片的缩放类型
                        .objectFit(markdownConfigurationStyleUrlCallback15.markdownTheme.imageFitType)
                        // 设置图片基于文本的对齐方式
                        .verticalAlign(ImageSpanAlignment.CENTER)
                        // 设置约束尺寸，组件布局时，进行尺寸范围限制
                        .constraintSize(maxWidth: 100.percent)
                        // 点击动作触发该方法调用
                        .onClick {evt => imageSpanOnClick(isLinkStyleUrlCallback15, imageCallbackStyleUrlCallback15, linkCallbackStyleUrlCallback15, linkUrlStyleUrlCallback15, destinationStyleUrlCallback15)}
                        // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                        .onComplete {
                            imageLoadResult =>
                                let res = imageWidthHeight(picStyleObjWidth, picStyleObjHeight, componentImageWidth, imageLoadResult.height, imageLoadResult.width)
                                widthStyleUrlCallback15 = res[0]
                                heightStyleUrlCallback15 = res[1]
                                imageType = 1
                        }
                        // 图片加载出现异常时触发该回调
                        .onError {
                            imageError => imageType = 2
                        }
                }
            }
            if (markdownConfigurationStyleUrlCallback15.markdownTheme.imageResource.isSome() && imageType != 1 && imageParseStyleUrlCallback15 != 1) {
                // 有占位图
                imagePlaceholderComponent(markdownConfigurationStyleUrlCallback15.markdownTheme.imageResource(), markdownConfigurationStyleUrlCallback15.markdownTheme.imageMarginTop, markdownConfigurationStyleUrlCallback15.markdownTheme.imageMarginBottom, markdownConfigurationStyleUrlCallback15.markdownTheme.imageFixedRatioWidth, markdownConfigurationStyleUrlCallback15.markdownTheme.imageMaximumWidth, if (radius.isSome()) { length2Float(radius()) } else { markdownConfigurationStyleUrlCallback15.markdownTheme.imageBorderRadius }, componentImageWidth)
            }
        }
    }

    func imageCallPixelmap() {
        spawn {
            let data: ?Array<UInt8> = markdownConfigurationStyleUrlCallback15.imageCallbackCallback()(destinationStyleUrlCallback15)
            if (data.isSome()) {
                var imageSource: ImageSource = createImageSource(data())
                let pixelMap1: PixelMap = imageSource.createPixelMap()
                var size: Size = pixelMap1.getImageInfo().size
                let imageHeightStyleUrlCallback15: Float64 = Float64(size.height)
                let imageWidthStyleUrlCallback15: Float64 = Float64(size.width)
                imageSource.Release()
                launch {
                    this.imageHeightStyleUrlCallback15 = imageHeightStyleUrlCallback15
                    this.imageWidthStyleUrlCallback15 = imageWidthStyleUrlCallback15
                    this.imagePixelMap = pixelMap1
                    if (this.imagePixelMap.isSome() && this.imageWidthStyleUrlCallback15.isSome() && this.imageHeightStyleUrlCallback15.isSome()) {
                        imageParseStyleUrlCallback15 = 1
                    } else {
                        imageParseStyleUrlCallback15 = 2
                    }
                }
            } else {
                launch {
                    imageParseStyleUrlCallback15 = 2
                }
            }
        }
    }
}
