/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 带样式的本地图片、设置图片预处理接口
 */
@Component
public class MarkdownImgStyleRawFileCallbackComponent {
    /**
     * 图片链接
     */
    var destinationStyleRawFileCallback: String

    /**
     * markdown配置
     */
    var markdownConfigurationStyleRawFileCallback: MarkdownConfiguration

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidthStyleRawFileCallback: Float64

    /**
     * 图片样式
     */
    var picStyle: ArrayList<String>

    /**
     * 图片点击事件
     */
    var imageCallbackStyleRawFileCallback: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallbackStyleRawFileCallback: ?(String) -> Unit

    /**
     * 链接url
     */
    var linkUrlStyleRawFileCallback: ?String = Option<String>.None

    /**
     * 是否是链接
     */
    var isLinkStyleRawFileCallback: Bool = false

    /**
     * 图片加载完成
     */
    @State
    var imageType: Int64 = 0 // 0:开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片宽度 - 单位px
     */
    @State
    var widthStyleRawFileCallback: ?Float64 = Option<Float64>.None

    /**
     * 图片高度 - 单位px
     */
    @State
    var heightStyleRawFileCallback: ?Float64 = Option<Float64>.None

    /**
     * 图片数据
     */
    @State
    var imagePixelMap: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 替换之后的图片宽度 - 单位px
     */
    @State
    var imageWidthStyleRawFileCallback: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片高度 - 单位px
     */
    @State
    var imageHeightStyleRawFileCallback: ?Float64 = Option<Float64>.None

    /**
     * 替换之后的图片数据
     */
    @State
    var imagePixelMap1: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 解析加载完成
     */
    @State
    var imageParseStyleRawFileCallback: Int64 = 0 // 0:开始解析。1：解析成功完成。2：解析失败

    /**
     * 控件宽度 - 单位px
     */
    @State
    var componentImageWidth: Float64 = 0.0

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
        componentImageWidth = vp2px(componentWidthStyleRawFileCallback.vp)().value
        imageCallPixelmap()
        localRowImageStyleToPixelMap()
    }

    protected override func aboutToDisappear(): Unit {
        imagePixelMap?.Release()
        imagePixelMap = Option<PixelMap>.None
        imagePixelMap1?.Release()
        imagePixelMap1 = Option<PixelMap>.None
    }

    func build() {
        if (true) {
            if (imageParseStyleRawFileCallback == 1) {
                imageCallBackComponent(imagePixelMap1(), markdownConfigurationStyleRawFileCallback.markdownTheme.imageMarginTop, markdownConfigurationStyleRawFileCallback.markdownTheme.imageMarginBottom, markdownConfigurationStyleRawFileCallback.markdownTheme.imageBorderRadius, markdownConfigurationStyleRawFileCallback.markdownTheme.imageFixedRatioWidth, componentImageWidth, imageWidthStyleRawFileCallback(), imageHeightStyleRawFileCallback(), markdownConfigurationStyleRawFileCallback.markdownTheme.imageMaximumWidth, markdownConfigurationStyleRawFileCallback, isLinkStyleRawFileCallback, imageCallbackStyleRawFileCallback, linkCallbackStyleRawFileCallback, linkUrlStyleRawFileCallback, destinationStyleRawFileCallback)
            } else {
                if (imageType == 1) {
                    ImageSpan(imagePixelMap())
                        // 设置外边距属性
                        .margin(top: markdownConfigurationStyleRawFileCallback.markdownTheme.imageMarginTop, bottom: markdownConfigurationStyleRawFileCallback.markdownTheme.imageMarginBottom)
                        // 自定义图片圆角
                        .interopBorderRadius(imageSpanBorderRadius(radius, markdownConfigurationStyleRawFileCallback.markdownTheme.imageBorderRadius))
                        // 设置组件自身的宽度
                        .width(imageSpanWidth(markdownConfigurationStyleRawFileCallback.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthStyleRawFileCallback(), markdownConfigurationStyleRawFileCallback.markdownTheme.imageMaximumWidth))
                        // 设置组件自身的高度
                        .height(imageSpanHeight(markdownConfigurationStyleRawFileCallback.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthStyleRawFileCallback(), heightStyleRawFileCallback(), markdownConfigurationStyleRawFileCallback.markdownTheme.imageMaximumWidth))
                        // 设置图片的缩放类型
                        .objectFit(markdownConfigurationStyleRawFileCallback.markdownTheme.imageFitType)
                        // 设置图片基于文本的对齐方式
                        .verticalAlign(ImageSpanAlignment.CENTER)
                        // 设置约束尺寸，组件布局时，进行尺寸范围限制
                        .constraintSize(maxWidth: 100.percent)
                        // 点击动作触发该方法调用
                        .onClick {evt => imageSpanOnClick(isLinkStyleRawFileCallback, imageCallbackStyleRawFileCallback, linkCallbackStyleRawFileCallback, linkUrlStyleRawFileCallback, destinationStyleRawFileCallback)}
                }
            }
            if (markdownConfigurationStyleRawFileCallback.markdownTheme.imageResource.isSome() && imageType != 1 && imageParseStyleRawFileCallback != 1) {
                // 有占位图
                imagePlaceholderComponent(markdownConfigurationStyleRawFileCallback.markdownTheme.imageResource(), markdownConfigurationStyleRawFileCallback.markdownTheme.imageMarginTop, markdownConfigurationStyleRawFileCallback.markdownTheme.imageMarginBottom, markdownConfigurationStyleRawFileCallback.markdownTheme.imageFixedRatioWidth, markdownConfigurationStyleRawFileCallback.markdownTheme.imageMaximumWidth, if (radius.isSome()) { length2Float(radius()) } else { markdownConfigurationStyleRawFileCallback.markdownTheme.imageBorderRadius }, componentImageWidth)
            }
        }
    }

    func imageCallPixelmap() {
        spawn {
            let data: ?Array<UInt8> = markdownConfigurationStyleRawFileCallback.imageCallbackCallback()(destinationStyleRawFileCallback)
            if (data.isSome()) {
                var imageSource: ImageSource = createImageSource(data())
                let pixelMap1: PixelMap = imageSource.createPixelMap()
                var size: Size = pixelMap1.getImageInfo().size
                let imageWidthStyleRawFileCallback: Float64 = Float64(size.width)
                let imageHeightStyleRawFileCallback: Float64 = Float64(size.height)
                imageSource.Release()
                launch {
                    this.imageWidthStyleRawFileCallback = imageWidthStyleRawFileCallback
                    this.imageHeightStyleRawFileCallback = imageHeightStyleRawFileCallback
                    this.imagePixelMap1 = pixelMap1
                    if (this.imagePixelMap1.isSome() && this.imageWidthStyleRawFileCallback.isSome() && this.imageHeightStyleRawFileCallback.isSome()) {
                        imageParseStyleRawFileCallback = 1
                    } else {
                        imageParseStyleRawFileCallback = 2
                    }
                }
            } else {
                launch {
                    imageParseStyleRawFileCallback = 2
                }
            }
        }
    }

    /**
     *
     */
    func localRowImageStyleToPixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            pixelMap, widthStyleRawFileCallback, heightStyleRawFileCallback => launch {
                this.imagePixelMap = pixelMap
                this.heightStyleRawFileCallback = heightStyleRawFileCallback
                this.widthStyleRawFileCallback = widthStyleRawFileCallback
                if (this.imagePixelMap.isSome() && this.widthStyleRawFileCallback.isSome() && this.heightStyleRawFileCallback.isSome()) {
                    imageType = 1
                } else {
                    imageType = 2
                }
            }
        }
        let picStyleObjStyleRawFileCallback: PicStyleObj = parsePicStyle(picStyle, componentImageWidth)
        if (picStyleObjStyleRawFileCallback.borderRadius.isSome()) {
            radius = picStyleObjStyleRawFileCallback.borderRadius()
        }
        align = picStyleObjStyleRawFileCallback.align
        let picStyleObjHeight: ?Float64 = length2Float64(picStyleObjStyleRawFileCallback.height, componentImageWidth)
        let picStyleObjWidth: ?Float64 = length2Float64(picStyleObjStyleRawFileCallback.width, componentImageWidth)
        let fut = rawfileToPixelmapStyle(destinationStyleRawFileCallback, markdownConfigurationStyleRawFileCallback.markdownTheme.abilityContext, markdownConfigurationStyleRawFileCallback.markdownTheme.stageContext, componentImageWidth, picStyleObjWidth, picStyleObjHeight, callback)
    }
}
