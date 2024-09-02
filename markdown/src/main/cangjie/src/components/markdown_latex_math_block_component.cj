/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown数学公式自定义控件
 */
@Component
class MarkdownLatexMathBlockComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

    /**
     * 数学公式文本
     */
    var latexStr: String

    /**
     * 数学公式PixelMap
     */
    @State
    var latexPixelMap: ?PixelMap = Option<PixelMap>.None

    /**
     * 数学公式高度
     */
    @State
    var latexHeight: ?Float64 = Option<Float64>.None

    /**
     * 数学公式宽度
     */
    @State
    var latexWidth: ?Float64 = Option<Float64>.None

    /**
     * 线程
     */
    @State
    var fut: ?Future<Unit> = Option<Future<Unit>>.None

    /**
     * 数学公式列表数据
     */
    var latexData: ?Array<UInt8> = Option<Array<UInt8>>.None

    func build() {
        Column() {
            latexMathTextComponent()
        }
        // 设置外边距属性
        .margin(top: markdownConfiguration.markdownTheme.blockTopAndBottomMargins, bottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins)
        // 组件挂载显示时触发此回调
        .onAppear {=> latexMathStrToPixelMap()}
        // 组件卸载消失时触发此回调
        .onDisAppear({=>
            threadFutureCancel(fut)
            delPixelMap(latexPixelMap)
        })
    }

    /**
     * 数学公式解析成功
     */
    @Builder
    func latexMathBlockComponent() {
        Scroll() {
            // 设置图片的数据源
            Image(latexPixelMap())
                // 设置组件自身的高度
                .height(pxToVp(latexHeight()))
                // 设置组件自身的宽度
                .width(pxToVp(latexWidth()))
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 点击动作触发该方法调用
                .onClick {evt => latexImageOnClick(latexData(), latexHeight().px, latexWidth().px, markdownConfiguration.latexImageCallback)}
        }
        // 设置滚动方法
        .scrollable(ScrollDirection.Horizontal)
        // 设置滚动条状态
        .scrollBar(BarState.Off)
    }

    /**
     * 数学公式
     */
    @Builder
    func latexMathTextComponent() {
        if (latexPixelMap.isSome() && latexHeight.isSome() && latexWidth.isSome() && latexData.isSome()) {
            latexMathBlockComponent()
        }
    }

    /**
     * 数学公式解析
     */
    func latexMathStrToPixelMap() {
        let callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit = {
            pixelMap, height, width, arr => launch {
                latexPixelMap = pixelMap
                latexHeight = height
                latexWidth = width
                latexData = arr
            }
        }
        fut = MarkdownParseLatexUtil.latexMathStrToPixelMap(latexStr, markdownConfiguration.markdownTheme.resPath,
            markdownConfiguration, callback)
    }
}
