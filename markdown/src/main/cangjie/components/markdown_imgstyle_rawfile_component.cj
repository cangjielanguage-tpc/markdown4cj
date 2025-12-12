/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 带样式的本地图片、未设置图片预处理接口
 */
@Component
public class MarkdownImgStyleRawFileComponent {
    /**
     * markdown配置
     */
    var markdownConfigurationStyleRawFile: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destinationStyleRawFile: String

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidthStyleRawFile: Float64

    /**
     * 图片样式
     */
    var picStyle: ArrayList<String>

    /**
     * 图片点击事件
     */
    var imageCallbackStyleRawFile: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallbackStyleRawFile: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var isLinkStyleRawFile: Bool = false

    /**
     * 链接url
     */
    var linkUrlStyleRawFile: ?String = Option<String>.None

    /**
     * 图片加载完成
     */
    @State
    var imageType: Int64 = 0 // 0:开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片宽度 - 单位px
     */
    @State
    var widthStyleRawFile: ?Float64 = Option<Float64>.None

    /**
     * 图片高度 - 单位px
     */
    @State
    var heightStyleRawFile: ?Float64 = Option<Float64>.None

    /**
     * 图片数据
     */
    @State
    var imagePixelMap: Option<PixelMap> = Option<PixelMap>.None

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
        componentImageWidth = vp2px(componentWidthStyleRawFile.vp)().value
        localRowImageStyleToPixelMap()
    }

    protected override func aboutToDisappear(): Unit {
        imagePixelMap?.Release()
        imagePixelMap = Option<PixelMap>.None
    }

    func build() {
        if (true) {
            if (imageType == 1) {
                ImageSpan(imagePixelMap())
                    // 设置外边距属性
                    .margin(top: markdownConfigurationStyleRawFile.markdownTheme.imageMarginTop, bottom: markdownConfigurationStyleRawFile.markdownTheme.imageMarginBottom)
                    // 自定义图片圆角
                    .interopBorderRadius(imageSpanBorderRadius(radius, markdownConfigurationStyleRawFile.markdownTheme.imageBorderRadius))
                    // 设置组件自身的宽度
                    .width(imageSpanWidth(markdownConfigurationStyleRawFile.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthStyleRawFile(), markdownConfigurationStyleRawFile.markdownTheme.imageMaximumWidth))
                    // 设置组件自身的高度
                    .height(imageSpanHeight(markdownConfigurationStyleRawFile.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthStyleRawFile(), heightStyleRawFile(), markdownConfigurationStyleRawFile.markdownTheme.imageMaximumWidth))
                    // 设置图片的缩放类型
                    .objectFit(markdownConfigurationStyleRawFile.markdownTheme.imageFitType)
                    // 设置图片基于文本的对齐方式
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    // 设置约束尺寸，组件布局时，进行尺寸范围限制
                    .constraintSize(maxWidth: 100.percent)
                    // 点击动作触发该方法调用
                    .onClick {evt => imageSpanOnClick(isLinkStyleRawFile, imageCallbackStyleRawFile, linkCallbackStyleRawFile, linkUrlStyleRawFile, destinationStyleRawFile)}
            }
            if (markdownConfigurationStyleRawFile.markdownTheme.imageResource.isSome() && imageType != 1) {
                // 有占位图
                imagePlaceholderComponent(markdownConfigurationStyleRawFile.markdownTheme.imageResource(), markdownConfigurationStyleRawFile.markdownTheme.imageMarginTop, markdownConfigurationStyleRawFile.markdownTheme.imageMarginBottom, markdownConfigurationStyleRawFile.markdownTheme.imageFixedRatioWidth, markdownConfigurationStyleRawFile.markdownTheme.imageMaximumWidth, if (radius.isSome()) { length2Float(radius()) } else { markdownConfigurationStyleRawFile.markdownTheme.imageBorderRadius }, componentImageWidth)
            }
        }
    }

    /**
     *
     */
    func localRowImageStyleToPixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            pixelMap, widthStyleRawFile, heightStyleRawFile => launch {
                this.heightStyleRawFile = heightStyleRawFile
                this.imagePixelMap = pixelMap
                this.widthStyleRawFile = widthStyleRawFile
                if (this.imagePixelMap.isSome() && this.widthStyleRawFile.isSome() && this.heightStyleRawFile.isSome()) {
                    imageType = 1
                } else {
                    imageType = 2
                }
            }
        }
        let picStyleObj: PicStyleObj = parsePicStyle(picStyle, componentImageWidth)
        if (picStyleObj.borderRadius.isSome()) {
            radius = picStyleObj.borderRadius()
        }
        align = picStyleObj.align
        let picStyleObjHeight: ?Float64 = length2Float64(picStyleObj.height, componentImageWidth)
        let picStyleObjWidth: ?Float64 = length2Float64(picStyleObj.width, componentImageWidth)
        let fut = rawfileToPixelmapStyle(destinationStyleRawFile, markdownConfigurationStyleRawFile.markdownTheme.abilityContext, markdownConfigurationStyleRawFile.markdownTheme.stageContext, componentImageWidth, picStyleObjWidth, picStyleObjHeight, callback)
    }
}
