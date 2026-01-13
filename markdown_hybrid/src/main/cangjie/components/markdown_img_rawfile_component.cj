/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.arkui.state_macro_manage.*

/**
 * 普通本地图片、未设置图片预处理接口
 */
@Component
public class MarkdownImgRawFileComponent {
    /**
     * markdown配置
     */
    var markdownConfigurationRawFile: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destinationRawFile: String

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidthRawFile: Float64

    /**
     * 图片点击事件
     */
    var imageCallbackRawFile: (String) -> Unit

    /**
     * 链接点击事件
     */
    var linkCallbackRawFile: ?(String) -> Unit

    /**
     * 是否是链接
     */
    var isLinkRawFile: Bool = false

    /**
     * 链接url
     */
    var linkUrlRawFile: ?String = Option<String>.None

    /**
     * 图片加载完成
     */
    @State
    var imageType: Int64 = 0 // 0:开始加载。1：加载成功完成。2：加载失败

    /**
     * 图片宽度 - 单位px
     */
    @State
    var widthRawFile: ?Float64 = Option<Float64>.None

    /**
     * 图片高度 - 单位px
     */
    @State
    var heightRawFile: ?Float64 = Option<Float64>.None

    /**
     * 图片数据
     */
    @State
    var imagePixelMapRawFile: Option<PixelMap> = Option<PixelMap>.None

    /**
     * 控件宽度 - 单位px
     */
    @State
    var componentImageWidth: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        componentImageWidth = getUIContext().vp2px(componentWidthRawFile.vp)().value
        localRowImageToPixelMap()
    }

    protected override func aboutToDisappear(): Unit {
        imagePixelMapRawFile?.release()
        imagePixelMapRawFile = Option<PixelMap>.None
    }

    func build() {
        if (true) {
            if (imageType == 1) {
                ImageSpan(imagePixelMapRawFile())
                    // 设置外边距属性
                    .margin(top: markdownConfigurationRawFile.markdownTheme.imageMarginTop, bottom: markdownConfigurationRawFile.markdownTheme.imageMarginBottom)
                    // 自定义图片圆角
                    .interopBorderRadius(markdownConfigurationRawFile.markdownTheme.imageBorderRadius)
                    // 设置组件自身的宽度
                    .width(imageSpanWidth(markdownConfigurationRawFile.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthRawFile(), markdownConfigurationRawFile.markdownTheme.imageMaximumWidth))
                    // 设置组件自身的高度
                    .height(imageSpanHeight(markdownConfigurationRawFile.markdownTheme.imageFixedRatioWidth, componentImageWidth, widthRawFile(), heightRawFile(), markdownConfigurationRawFile.markdownTheme.imageMaximumWidth))
                    // 设置图片的缩放类型
                    .objectFit(markdownConfigurationRawFile.markdownTheme.imageFitType)
                    // 设置图片基于文本的对齐方式
                    .verticalAlign(ImageSpanAlignment.Center)
                    // 设置约束尺寸，组件布局时，进行尺寸范围限制
                    .constraintSize(maxWidth: 100.percent)
                    // 点击动作触发该方法调用
                    .onClick ({evt => imageSpanOnClick(isLinkRawFile, imageCallbackRawFile, linkCallbackRawFile, linkUrlRawFile, destinationRawFile)})
            }
            if (markdownConfigurationRawFile.markdownTheme.imageResource.isSome() && imageType != 1) {
                // 有占位图
                imagePlaceholderComponent(markdownConfigurationRawFile.markdownTheme.imageResource(), markdownConfigurationRawFile.markdownTheme.imageMarginTop, markdownConfigurationRawFile.markdownTheme.imageMarginBottom, markdownConfigurationRawFile.markdownTheme.imageFixedRatioWidth, markdownConfigurationRawFile.markdownTheme.imageMaximumWidth, markdownConfigurationRawFile.markdownTheme.imageBorderRadius, componentImageWidth)
            }
        }
    }

    /**
     * 图片数据处理 - 本地rawfile图片
     */
    func localRowImageToPixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            pixelMap, widthRawFile, heightRawFile => launch {
                this.imagePixelMapRawFile = pixelMap
                this.widthRawFile = widthRawFile
                this.heightRawFile = heightRawFile
                if (this.imagePixelMapRawFile.isSome() && this.widthRawFile.isSome() && this.heightRawFile.isSome()) {
                    imageType = 1
                } else {
                    imageType = 2
                }
            }
        }
        let fut = rawfileToPixelmap(destinationRawFile, markdownConfigurationRawFile.markdownTheme.context, componentImageWidth, callback)
    }
}
