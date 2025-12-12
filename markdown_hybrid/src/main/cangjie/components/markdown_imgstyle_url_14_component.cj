/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 带样式的网络/沙盒图片、未设置图片预处理接口、API15以下
 */
@Component
public class MarkdownImgStyleUrl14Component {
    /**
     * markdown配置
     */
    var markdownConfigurationStyleUrl14: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destinationStyleUrl14: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var componentWidthStyleUrl14: Float64

    /**
     * 图片样式
     */
    var picStyle: ArrayList<String>

    /**
     * 图片点击事件
     */
    var imageCallbackStyleUrl14: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallbackStyleUrl14: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var isLinkStyleUrl14: Bool = false

    /**
     * 链接url
     */
    var linkUrlStyleUrl14: ?String = Option<String>.None

    /**
     * 图片加载
     */
    @State
    var imageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片宽度 - 单位px
     */
    @State
    var widthStyleUrl14: Float64 = 0.0

    /**
     * 图片高度 - 单位px
     */
    @State
    var heightStyleUrl14: Float64 = 0.0

    /**
     *
     */
    @State
    var picStyleObjWidth: ?Float64 = Option<Float64>.None

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
    var picStyleObjHeight: ?Float64 = Option<Float64>.None

    /**
     * 对齐方式 - 暂未支持
     */
    @State
    var align: FlexAlign = FlexAlign.Start

    protected override func aboutToAppear(): Unit {
        componentImageWidth = vp2px(componentWidthStyleUrl14.vp)().value
        let picStyleObjStyleUrl14: PicStyleObj = parsePicStyle(picStyle, componentImageWidth)
        if (picStyleObjStyleUrl14.borderRadius.isSome()) {
            radius = picStyleObjStyleUrl14.borderRadius()
        }
        align = picStyleObjStyleUrl14.align
        picStyleObjWidth = length2Float64(picStyleObjStyleUrl14.width, componentImageWidth)
        picStyleObjHeight = length2Float64(picStyleObjStyleUrl14.height, componentImageWidth)
    }

    func build() {
        if (true) {
            if (imageType != 2) {
                ImageSpan(destinationStyleUrl14)
                    // 设置外边距属性
                    .margin(top: markdownConfigurationStyleUrl14.markdownTheme.imageMarginTop, bottom: markdownConfigurationStyleUrl14.markdownTheme.imageMarginBottom)
                    // 自定义图片圆角
                    .interopBorderRadius(imageSpanBorderRadius(radius, markdownConfigurationStyleUrl14.markdownTheme.imageBorderRadius))
                    // 设置组件自身的宽度
                    .width(imageSpanWidth(markdownConfigurationStyleUrl14.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthStyleUrl14, markdownConfigurationStyleUrl14.markdownTheme.imageMaximumWidth))
                    // 设置组件自身的高度
                    .height(imageSpanHeight(markdownConfigurationStyleUrl14.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthStyleUrl14, heightStyleUrl14, markdownConfigurationStyleUrl14.markdownTheme.imageMaximumWidth))
                    // 设置组件的可见性
                    .visibility(visibilityImageSpanType(imageType))
                    // 设置图片的缩放类型
                    .objectFit(markdownConfigurationStyleUrl14.markdownTheme.imageFitType)
                    // 设置图片基于文本的对齐方式
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    // 设置约束尺寸，组件布局时，进行尺寸范围限制
                    .constraintSize(maxWidth: 100.percent)
                    // 点击动作触发该方法调用
                    .onClick {evt => imageSpanOnClick(isLinkStyleUrl14, imageCallbackStyleUrl14, linkCallbackStyleUrl14, linkUrlStyleUrl14, destinationStyleUrl14)}
                    // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                    .interopOnComplete {
                        imageLoadResult =>
                            let res = imageWidthHeight(picStyleObjWidth, picStyleObjHeight, componentImageWidth, imageLoadResult.height, imageLoadResult.width)
                            widthStyleUrl14 = res[0]
                            heightStyleUrl14 = res[1]
                            imageType = 1
                    }
                    // 图片加载出现异常时触发该回调
                    .interopOnError {
                        imageError => imageType = 2
                    }
            }
            if (markdownConfigurationStyleUrl14.markdownTheme.imageResource.isSome() && imageType != 1) {
                // 有占位图
                imagePlaceholderComponent(markdownConfigurationStyleUrl14.markdownTheme.imageResource(), markdownConfigurationStyleUrl14.markdownTheme.imageMarginTop, markdownConfigurationStyleUrl14.markdownTheme.imageMarginBottom, markdownConfigurationStyleUrl14.markdownTheme.imageFixedRatioWidth, markdownConfigurationStyleUrl14.markdownTheme.imageMaximumWidth, if (radius.isSome()) { length2Float(radius()) } else { markdownConfigurationStyleUrl14.markdownTheme.imageBorderRadius }, componentImageWidth)
            }
        }
    }
}
