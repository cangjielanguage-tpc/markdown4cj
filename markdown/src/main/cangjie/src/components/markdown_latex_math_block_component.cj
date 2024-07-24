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
     * 数学公式列表数据
     */
    var latexData: ?Array<UInt8> = Option<Array<UInt8>>.None

    func build() {
        Column(){
            latexMathTextComponent(latexMathStrToPixelMap())
        }
        // 设置外边距属性
        .margin(top: markdownConfiguration.markdownTheme.blockTopAndBottomMargins, bottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins)
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
                .height(latexHeight())
                // 设置组件自身的宽度
                .width(latexWidth())
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 组件卸载消失时触发此回调
                .onDisAppear({=> latexPixelMap().Release()})
                // 点击动作触发该方法调用
                .onClick {evt => latexImageOnClick(latexData(), latexHeight().vp, latexWidth().vp, markdownConfiguration.latexImageCallback)}
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
    func latexMathTextComponent(error :Int64) {
        if (latexPixelMap.isSome() && latexHeight.isSome() && latexWidth.isSome()) {
            latexMathBlockComponent()
        }
    }

    /**
    * 数学公式文本转换成数学公式图片
    */
    func latexMathStrToPixelMap() : Int64{
        let strLatexMath = markdownConfiguration.latexStrCallback(latexStr)
        spawn {
            let allData = latexMathStrToPixelMap(strLatexMath, markdownConfiguration.markdownTheme.resPath, markdownConfiguration)
            let pixelMap = allData[0]
            let lengthHeightLength = if (let Some(v) <- allData[1]) {
                if (let Some(m) <- px2vp(v)) {
                    m.value
                } else {
                    0.0
                }
            } else {
                0.0
            }
            let lengthWidthLength = if (let Some(v) <- allData[2]) {
                if (let Some(m) <- px2vp(v)) {
                    m.value
                } else {
                    0.0
                }
            } else {
                0.0
            }
            let arr = allData[3]
            launch{=>
                latexPixelMap = pixelMap
                latexHeight = lengthHeightLength
                latexWidth = lengthWidthLength
                latexData = arr
            }
        }
        return 0
    }
}
