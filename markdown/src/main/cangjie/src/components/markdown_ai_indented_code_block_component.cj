/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown缩进代码块自定义控件
 */
@Component
class MarkdownAIIndentedCodeBlockComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 代码内容
     */
    var codeText: String

    /**
     * 代码类型
     */
    var info: ?String

    /**
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

    /**
     * 代码块NodeView
     */
    var codeItem: NodeView

    func build() {
        Stack(Alignment.TopEnd) {
            // 代码块部分
            codeBlockComponent()
            // 复制按钮全屏按钮部分
            if (getProp<Bool>(codeItem, "closed", true)) {
                codeBlockButtonComponent()
            }
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
    }

    /**
     * 代码文本内容
     */
    @Builder
    func codeBlockTextComponent() {
        Text(codeText)
            // 设置文本颜色
            .fontColor(indentedCodeTextColor(markdownAIConfiguration.markdownAITheme, markdownAIConfiguration.markdownAITheme.prismTheme))
            // 设置文本尺寸
            .fontSize(markdownAIConfiguration.markdownAITheme.codeBlockTextSize)
            // 设置文本的字体列表
            .fontFamily(markdownAIConfiguration.markdownAITheme.codeBlockTypeface)
            // 设置多行文本的文本对齐方式
            .textAlign(TextAlign.Start)
            // 设置内边距属性
            .padding(left: markdownAIConfiguration.markdownAITheme.codeMultilineMargin)
    }

    /**
     * 代码块部分
     */
    @Builder
    func codeBlockComponent() {
        Scroll() {
            // 代码文本内容
            codeBlockTextComponent()
        }
        // 设置组件的背景色
        .backgroundColor(codeBackgroundColor(markdownAIConfiguration.markdownAITheme, markdownAIConfiguration.markdownAITheme.prismTheme))
        // 设置滚动方法
        .scrollable(ScrollDirection.Horizontal)
        // 设置滚动条状态
        .scrollBar(BarState.Off)
        // 设置元素内容的对齐方式
        .align(Alignment.Start)
        // 设置元素水平方向的布局
        .direction(Direction.Ltr)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置内边距属性
        .padding(top: 10, bottom: 10)
    }

    /**
     * 复制按钮和全屏按钮部分
     */
    @Builder
    func codeBlockButtonComponent() {
        Row() {
            // 复制按钮
            if (markdownAIConfiguration.markdownAITheme.codeCopyIcon.isSome() && codeText.trimAscii().size > 0) {
                // 设置图片的数据源
                Image(markdownAIConfiguration.markdownAITheme.codeCopyIcon())
                    // 设置组件自身的宽度
                    .width(markdownAIConfiguration.markdownAITheme.iconWidthAndHeight)
                    // 设置组件自身的高度
                    .height(markdownAIConfiguration.markdownAITheme.iconWidthAndHeight)
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Contain)
                    // 点击动作触发该方法调用
                    .onClick {evt => codeCopyOnClick(codeText, markdownAIConfiguration.codeCopyCallback)}
            }
            // 全屏按钮
            if (markdownAIConfiguration.markdownAITheme.codeFullScreenIcon.isSome() && codeText.trimAscii().size > 0) {
                // 设置图片的数据源
                Image(markdownAIConfiguration.markdownAITheme.codeFullScreenIcon())
                    // 设置组件自身的宽度
                    .width(markdownAIConfiguration.markdownAITheme.iconWidthAndHeight)
                    // 设置组件自身的高度
                    .height(markdownAIConfiguration.markdownAITheme.iconWidthAndHeight)
                    // 设置外边距属性
                    .margin(left: 8)
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Contain)
                    // 控制当前组件显示或隐藏
                    .visibility(isVisibility(markdownAIConfiguration.markdownAITheme.isCodeFullScreen))
                    // 点击动作触发该方法调用
                    .onClick {evt => codeFullScreenOnClick(codeText, info, markdownAIConfiguration.codeFullScreenCallback)}
            }
        }
        // 设置外边距属性
        .margin(top: 8, right: 8)
    }
}
