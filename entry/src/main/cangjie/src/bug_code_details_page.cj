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
 * 单独代码块bug全量加载详情页面
 */
@Entry
@Component
class BugCodeDetailsPage {
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
            titleComponent(
                params,
                true
            )
            Scroll(scroller) {
                Column {
                    MarkdownComponent(
                        output: mdStr,
                        isFull: true,
                        markdownConfiguration: setConfig()
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
     * 设置MarkdownConfiguration
     *
     * @return MarkdownConfiguration
     */
    func setConfig(): MarkdownConfiguration {
        let MarkdownConfigurationBuilder: MarkdownConfigurationBuilder = MarkdownConfiguration.emptyBuilder()
        // 设置markdown默认样式
        MarkdownConfigurationBuilder.setMarkdownTheme(setMarkdownTheme())
        return MarkdownConfigurationBuilder.build()
    }

    /**
     * 设置MarkdownTheme
     *
     * @return MarkdownTheme
     */
    func setMarkdownTheme(): MarkdownTheme {
        let markdownThemeBuilder: MarkdownThemeBuilder = MarkdownTheme.emptyBuilder()

        // 1、代码
        markdownThemeBuilder.setIsSeparateCodeBlock(true) //设置是否单独代码块

        return markdownThemeBuilder.build()
    }
}

