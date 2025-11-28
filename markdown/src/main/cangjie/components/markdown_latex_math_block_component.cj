/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown数学公式自定义控件 - 单行
 */
@Component
class MarkdownLatexMathBlockComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 数学公式节点
     */
    var nodeView: NodeView

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
     * 数学公式列表数据
     */
    var latexData: ?Array<UInt8> = Option<Array<UInt8>>.None

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
     * 解析是否结束
     */
    @State
    var isBool: Bool = false

    protected override func aboutToAppear(): Unit {
        refreshData(nodeView)
    }

    protected override func aboutToDisappear(): Unit {
        latexPixelMap?.Release()
        latexPixelMap = Option<PixelMap>.None
        latexData = Option<Array<UInt8>>.None
    }

    func build() {
        if (isBool) {
            if (latexPixelMap.isSome() && latexHeight.isSome() && latexWidth.isSome() && latexData.isSome()) {
                Scroll() {
                    // 设置图片的数据源
                    Image(latexPixelMap())
                        // 设置组件自身的高度
                        .height(latexHeight().px)
                        // 设置组件自身的宽度
                        .width(latexWidth().px)
                        // 设置图片的缩放类型
                        .objectFit(ImageFit.Contain)
                        // 点击动作触发该方法调用
                        .onClick {
                            evt => latexImageOnClick(latexData(), latexHeight().px, latexWidth().px, markdownConfiguration.latexImageCallback)
                        }
                }
                // 设置滚动方法
                .scrollable(ScrollDirection.Horizontal)
                // 宽度
                .width(100.percent)
                // 设置滚动条状态
                .scrollBar(BarState.Off)
                // 设置外边距属性
                .margin(top: marginTop, bottom: marginBottom)
                // 设置 Column 子组件在水平方向上的对齐格式
                .align(isAlignItems(markdownConfiguration.markdownTheme.latexMathBlockCenter))
            } else {
                Text(latexStr)
                    .fontColor(Color.RED)
            }
        } else {
            if (markdownConfiguration.markdownTheme.latexDefaultText) {
                Text(latexStr)
                    .fontColor(Color.RED)
            }
        }
    }

    /**
     * 数据刷新
     */
    public func refreshData(nodeView:NodeView){
        this.nodeView = nodeView
        latexMathStrToPixelMap()
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
                isBool = true
            }
        }
        MarkdownParseLatexUtil.latexMathStrToPixelMap(latexStr, markdownConfiguration, callback)
    }
}
