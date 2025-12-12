/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * HTML图片
 */
@Component
public class MarkdownImgHtml14Component {
    /**
     * markdown配置
     */
    var markdownConfigurationHtml14: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destinationHtml14: String

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var componentWidthHtml14: Float64

    /**
     * 图片点击事件
     */
    var imageCallbackHtml14: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallbackHtml14: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var isLinkHtml14: Bool = false

    /**
     * 链接url
     */
    var linkUrlHtml14: ?String = Option<String>.None

    /**
     * 图片宽度
     */
    var imageWidthHtml14: ?Float64

    /**
     * 图片高度
     */
    var imageHeightHtml14: ?Float64

    /**
     * 图片加载
     */
    @State
    var imageType: Int64 = 0 // 0：开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片高度 - 单位px
     */
    @State
    var heightHtml14: Float64 = 0.0

    /**
     * 图片宽度 - 单位px
     */
    @State
    var widthHtml14: Float64 = 0.0

    /**
     * 图片最大宽度 - 单位px
     */
    @State
    var componentImageWidth: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        componentImageWidth = vp2px(componentWidthHtml14.vp)().value
    }

    func build() {
        if (true) {
            if (imageType != 2) {
                ImageSpan(destinationHtml14)
                    // 自定义图片圆角
                    .interopBorderRadius(markdownConfigurationHtml14.markdownTheme.imageBorderRadius)
                    // 设置外边距属性
                    .margin(top: markdownConfigurationHtml14.markdownTheme.imageMarginTop, bottom: markdownConfigurationHtml14.markdownTheme.imageMarginBottom)
                    // 设置组件自身的宽度
                    .width(imageSpanWidth(markdownConfigurationHtml14.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthHtml14, markdownConfigurationHtml14.markdownTheme.imageMaximumWidth))
                    // 设置组件自身的高度
                    .height(imageSpanHeight(markdownConfigurationHtml14.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthHtml14, heightHtml14, markdownConfigurationHtml14.markdownTheme.imageMaximumWidth))
                    // 设置图片的缩放类型
                    .objectFit(markdownConfigurationHtml14.markdownTheme.imageFitType)
                    // 设置组件的可见性
                    .visibility(visibilityImageSpanType(imageType))
                    // 设置约束尺寸，组件布局时，进行尺寸范围限制
                    .constraintSize(maxWidth: 100.percent)
                    // 设置图片基于文本的对齐方式
                    .verticalAlign(ImageSpanAlignment.CENTER)
                    // 点击动作触发该方法调用
                    .onClick {evt => imageSpanOnClick(isLinkHtml14, imageCallbackHtml14, linkCallbackHtml14, linkUrlHtml14, destinationHtml14)}
                    // 图片成功加载时触发该回调，返回成功加载的图片尺寸
                    .interopOnComplete {
                        imageLoadResult =>
                            let res = imageSpanHtmlComplete(imageLoadResult.height, imageLoadResult.width, componentImageWidth, imageWidthHtml14, imageHeightHtml14)
                            heightHtml14 = res[1]
                            widthHtml14 = res[0]
                            imageType = 1
                    }
                    // 图片加载出现异常时触发该回调
                    .interopOnError {
                        imageError => imageType = 2
                    }
            }
            if (markdownConfigurationHtml14.markdownTheme.imageResource.isSome() && imageType != 1) {
                // 有占位图
                imagePlaceholderComponent(markdownConfigurationHtml14.markdownTheme.imageResource(), markdownConfigurationHtml14.markdownTheme.imageMarginTop, markdownConfigurationHtml14.markdownTheme.imageMarginBottom, markdownConfigurationHtml14.markdownTheme.imageFixedRatioWidth, markdownConfigurationHtml14.markdownTheme.imageMaximumWidth, markdownConfigurationHtml14.markdownTheme.imageBorderRadius, componentImageWidth)
            }
        }
    }
}
