/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.concurrency.*
import markdown.components.*
import std.sync.*
import std.time.*
import ohos.hilog.*

/**
 * 连续输入数学公式
 */
@Entry
@Component
class ContinuousInputFormulasPage {
    var mdStr: String = ###"$$\begin{align*}
\tan \theta &= \frac{1}{2 - \sqrt{3}} \cdot \frac{2 + \sqrt{3}}{2 + \sqrt{3}} \
&= \frac{2 + \sqrt{3}}{(2 - \sqrt{3})(2 + \sqrt{3})} \
\end{align*}$$"###

    /**
     * 流式markdown文本
     */
    @State
    var output: String = ""

    /**
     * 一次加载文本个数
     */
    @State
    var number: Int64 = 1

    /**
     * 延时时间
     */
    @State
    var sleepTime: Int64 = 50

    /**
     * 滑动控制器
     */
    var scroller: Scroller = Scroller()

    func build() {
        Column() {
            titleComponent(
                "9、连续输入数学公式闪退",
                true
            )
            Button("点击加载markdown")
                // 高度
                .height(40)
                // 宽度
                .width(100.percent)
                // 圆角
                .shape(ShapeType.Capsule)
                // 文本颜色
                .fontColor(0xFFFFFF)
                // 背景颜色
                .backgroundColor(0xFF0000)
                // 外边距
                .margin(top: 5, bottom: 5, right: 40, left: 40)
                // 内容对齐方式
                .align(Alignment.Center)
                // 字体大小
                .fontSize(16)
                // 点击动作触发该方法调用
                .onClick {
                    => spawn {
                        for (i in 0..mdStr.size) {
                            sleep(Duration.millisecond * sleepTime)
                            launch {
                                output = mdStr[0..i] + "$$"
                            }
                        }
                    }
                }
            Scroll(scroller) {
                Column {
                    MarkdownComponent(
                        output: output
                    )
                }
            }
            // 左右外边距
            .margin(right: 10, left: 10)
            // 内边距
            .padding(bottom: 150)
            // 设置滚动方法
            .scrollable(ScrollDirection.Vertical)
        }
    }
}
