/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 文本信息
 */
@Component
public class MarkdownAISpanComponent {
    /**
     * 文本内容
     */
    var text: String

    /**
     * 文本的字体列表
     */
    var family: String

    /**
     * 文本尺寸
     */
    var size: Float64

    /**
     * 文本的字体粗细
     */
    var weight: FontWeight

    /**
     * 文本的字体样式
     */
    var style: FontStyle

    /**
     * 文本颜色
     */
    var color: Color

    /**
     * 文本字符间距
     */
    var letterSpacing: Float64

    /**
     * 装饰线样式
     */
    var decorationType: TextDecorationType

    /**
     * 装饰线颜色
     */
    var decorationColor: Color

    /**
     * 装饰线颜色
     */
    var linkString: Option<String>

    /**
     * 链接点击事件
     */
    var linkCallback: Option<(String) -> Unit>

    /**
     * 脚注ID
     */
    var noteid: Option<String>

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * 是否全量加载 - true：全量加载，fasle：增量加载
     */
    var isFull: Bool

    func build() {
        // 设置文本内容
        Span(text)
            // 设置文本的字体列表
            .fontFamily(family)
            // 设置文本尺寸
            .fontSize(size)
            // 设置文本的字体粗细
            .fontWeight(weight)
            // 设置文本的字体样式
            .fontStyle(style)
            // 设置文本颜色
            .fontColor(color)
            // 设置文本字符间距
            .letterSpacing(letterSpacing)
            // 设置文本装饰线样式及其颜色
            .decoration(decorationType: decorationType, color: decorationColor)
            // 点击动作触发该方法调用
            .onClick {
                evt => if (linkCallback.isSome() && linkString.isSome()) {
                    // 链接点击事件
                    linkCallback()(linkString())
                } else if (noteid.isSome() && isFull) {
                    // 脚注点击事件
                    fontCallback(noteid())
                }
            }
    }
}
