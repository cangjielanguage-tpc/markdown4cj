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
 * 增量加载详情页面
 */
@Entry
@Component
class CodeIncrementDetailsPage {
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
     * 流式markdown文本
     */
    @State
    var output: String = ""

    /**
     * 一次加载文本个数
     */
    @State
    var number: Int64 = 10

    /**
     * 延时时间
     */
    @State
    var sleepTime: Int64 = 100

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
            titleComponent(
                params,
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
                            let arr: Array<Rune> = mdStr.toRuneArray()
                            for (i in 0..arr.size : number) {
                                sleep(Duration.millisecond * sleepTime)
                                launch {
                                    let size = if (arr.size > i + number) {
                                        i + number
                                    } else {
                                        arr.size
                                    }
                                    output += String(arr[i..size])
                                }
                            }
                        }
                }
            Scroll(scroller) {
                Column {
                    MarkdownComponent(
                        output: output,
                        isFull: false,
                        markdownConfiguration: setConfig()
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

    /**
     * 设置MarkdownConfiguration
     *
     * @return MarkdownConfiguration
     */
    func setConfig(): MarkdownConfiguration {
        let MarkdownConfigurationBuilder: MarkdownConfigurationBuilder = MarkdownConfiguration.emptyBuilder()
        // 设置markdown默认样式
        MarkdownConfigurationBuilder.setMarkdownTheme(setMarkdownTheme())
        // 设置代码复制按钮的点击事件
        MarkdownConfigurationBuilder.setCodeCopyCallback(codeCopyCallback)
        return MarkdownConfigurationBuilder.build()
    }

    /**
     * 设置MarkdownTheme
     *
     * @return MarkdownTheme
     */
    func setMarkdownTheme(): MarkdownTheme {
        let markdownThemeBuilder: MarkdownThemeBuilder = MarkdownTheme.emptyBuilder()

        // 单独代码块
        markdownThemeBuilder.setIsSeparateCodeBlock(true) // 设置是否单独代码块
        markdownThemeBuilder.setCodeCopyIcon(@r(app.media.app_icon)) // 设置代码复制按钮默认图标

        return markdownThemeBuilder.build()
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
