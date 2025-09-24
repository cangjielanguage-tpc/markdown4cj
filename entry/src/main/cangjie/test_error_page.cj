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
 *
 */
@Entry
@Component
class TestErrorPage {
    var mdStr: String = ###"$$\begin{align*}
\tan \theta &= \frac{1}{2 - \sqrt{3}} \cdot \frac{2 + \sqrt{3}}{2 + \sqrt{3}} \
&= \frac{2 + \sqrt{3}}{(2 - \sqrt{3})(2 + \sqrt{3})} \
\end{align*}$$"###

    /**
     * markdown文本
     */
    var mdStr0: String = ###"
$$
\
$$
"###
    var mdStr1: String = ###"
$$
\b
$$
"###
    var mdStr2: String = ###"
$$
\be
$$
"###
    var mdStr3: String = ###"
$$
\beg
$$
"###
    var mdStr4: String = ###"
$$
\begi
$$
"###
    var mdStr5: String = ###"
$$
\begin
$$
"###
    var mdStr6: String = ###"
$$
\begin{
$$
"###
    var mdStr7: String = ###"
$$
\begin{a
$$
"###
    var mdStr8: String = ###"
$$
\begin{al
$$
"###
    var mdStr9: String = ###"
$$
\begin{ali
$$
"###
    var mdStr10: String = ###"
$$
\begin{alig
$$
"###
    var mdStr11: String = ###"
$$
\begin{align
$$
"###
    var mdStr12: String = ###"
$$
\begin{align*
$$
"###
    var mdStr13: String = ###"
$$
\begin{align*}
$$
"###
    var mdStr14: String = ###"
$$
\begin{align*}

$$
"###
    var mdStr15: String = ###"
$$
\begin{align*}
\
$$
"###
    var mdStr16: String = ###"
$$
\begin{align*}
\t
$$
"###
    var mdStr17: String = ###"
$$
\begin{align*}
\ta
$$
"###
    var mdStr18: String = ###"
$$
\begin{align*}
\tan
$$
"###
    var mdStr19: String = ###"
$$
\begin{align*}
\tan
$$
"###
    var mdStr20: String = ###"
$$
\begin{align*}
\tan \
$$
"###
    var mdStr21: String = ###"
$$
\begin{align*}
\tan \t
$$
"###
    var mdStr22: String = ###"
$$
\begin{align*}
\tan \th
$$
"###
    var mdStr23: String = ###"
$$
\begin{align*}
\tan \the
$$
"###
    var mdStr24: String = ###"
$$
\begin{align*}
\tan \thet
$$
"###
    var mdStr25: String = ###"
$$
\begin{align*}
\tan \theta
$$
"###
    var mdStr26: String = ###"
$$
\begin{align*}
\tan \theta
$$
"###
    var mdStr27: String = ###"
$$
\begin{align*}
\tan \theta &
$$
"###
    var mdStr28: String = ###"
$$
\begin{align*}
\tan \theta &=
$$
"###
    var mdStr29: String = ###"
$$
\begin{align*}
\tan \theta &=
$$
"###
    var mdStr30: String = ###"
$$
\begin{align*}
\tan \theta &= \
$$
"###
    var mdStr31: String = ###"
$$
\begin{align*}
\tan \theta &= \f
$$
"###
    var mdStr32: String = ###"
$$
\begin{align*}
\tan \theta &= \fr
$$
"###
    var mdStr33: String = ###"
$$
\begin{align*}
\tan \theta &= \fra
$$
"###
    var mdStr34: String = ###"
$$
\begin{align*}
\tan \theta &= \frac
$$
"###
    var mdStr35: String = ###"
$$
\begin{align*}
\tan \theta &= \frac{
$$
"###
    var mdStr36: String = ###"
$$
\begin{align*}
\tan \theta &= \frac{1
$$
"###

    /**
     * 文件名
     */
    var list: Array<String> = [mdStr0, mdStr1, mdStr2, mdStr3, mdStr4, mdStr5, mdStr6, mdStr7, mdStr8, mdStr9, mdStr10,
        mdStr11, mdStr12, mdStr13, mdStr14, mdStr15, mdStr16, mdStr17, mdStr18, mdStr19, mdStr20, mdStr21, mdStr22,
        mdStr23, mdStr24, mdStr25, mdStr26, mdStr27, mdStr28, mdStr29, mdStr30, mdStr31, mdStr32, mdStr33, mdStr34,
        mdStr35, mdStr36]

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
                "11、连续输入数学公式闪退",
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
                        for (str in list) {
                            sleep(Duration.millisecond * sleepTime)
                            launch {
                                output = str
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
