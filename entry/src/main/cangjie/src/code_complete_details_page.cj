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
 * 全量加载详情页面
 */
@Entry
@Component
class CodeCompleteDetailsPage {
    /**
     * markdown文本
     */
    @State
    var mdStr = ""

    /**
     * 文件名
     */
    @State
    var params = ""

    /**
     * 滑动控制器
     */
    var scroller: Scroller = Scroller()

    /**
     * rawfile文件夹列表
     */
    @State
    var folderList: ObservedArrayList<String> = ObservedArrayList<String>()

    protected override func aboutToAppear(): Unit {
        params = (Router.getParams().getOrThrow() as String).getOrThrow()
        mdStr = getFileContextStr(params)
    }

    func build() {
        Column() {
            Text("")
                // 高度
                .height(50)
                // 宽度
                .width(100.percent)
                // 背景颜色
                .backgroundColor(0xFF0000)
            Text("${params}")
                // 高度
                .height(40)
                // 宽度
                .width(100.percent)
                // 文本颜色
                .fontColor(0xFFFFFF)
                // 背景颜色
                .backgroundColor(0xFF0000)
                // 设置容器元素绘制区域内的子元素的对齐方式
                .align(Alignment.Center)
                // 设置文本段落在水平方向的对齐方式
                .textAlign(TextAlign.Center)
                // 字体大小
                .fontSize(16)
                // 外边距
                .margin(bottom: 10)
            Scroll(scroller) {
                Column {
                    MarkdownAIComponent(
                        output: mdStr,
                        isFull: true,
                        markdownAIConfiguration: setConfig()
                    )
                }
            }
            // 外边距
            .margin(right: 10, left: 10)
            // 内边距
            .padding(bottom: 100)
            // 设置滚动方法
            .scrollable(ScrollDirection.Vertical)
        }
    }

    /**
     * 设置MarkdownAIConfiguration
     *
     * @return MarkdownAIConfiguration
     */
    func setConfig(): MarkdownAIConfiguration {
        let MarkdownAIConfigurationBuilder: MarkdownAIConfigurationBuilder = MarkdownAIConfiguration.emptyBuilder()
        // 设置markdown默认样式
        MarkdownAIConfigurationBuilder.setMarkdownAITheme(setMarkdownAITheme())
        // 设置代码复制按钮的点击事件
        MarkdownAIConfigurationBuilder.setCodeCopyCallback(codeCopyCallback)
        return MarkdownAIConfigurationBuilder.build()
    }

    /**
     * 设置MarkdownAITheme
     *
     * @return MarkdownAITheme
     */
    func setMarkdownAITheme(): MarkdownAITheme {
        let markdownAIThemeBuilder: MarkdownAIThemeBuilder = MarkdownAITheme.emptyBuilder()

        // 单独代码块
        markdownAIThemeBuilder.setIsSeparateCodeBlock(true) // 设置是否单独代码块
        markdownAIThemeBuilder.setCodeCopyIcon(@r(app.media.app_icon)) // 设置代码复制按钮默认图标

        return markdownAIThemeBuilder.build()
    }

    /**
     * 代码复制按钮的点击事件
     *
     * @param code 代码内容
     */
    func codeCopyCallback(code: String): Unit {
        PromptAction.showToast(message: code)
        Hilog.error(1, "1", "------------------------codeCopyCallback:${code}")
    }
}
