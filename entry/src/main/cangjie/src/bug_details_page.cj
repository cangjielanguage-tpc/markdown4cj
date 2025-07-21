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
 * Bug全量加载详情页面
 */
@Entry
@Component
class BugDetailsPage {
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
        // 设置链接的点击事件
        MarkdownConfigurationBuilder.setLinkCallback(linkCallback)
        // 设置图片的点击事件
        MarkdownConfigurationBuilder.setImageCallback(imageCallback)
        // 设置音频的点击事件
        MarkdownConfigurationBuilder.setAudioCallback(audioCallback)
        // 设置视频的点击事件
        MarkdownConfigurationBuilder.setVideoCallback(videoCallback)
        // 设置视频的图片替换回调
        MarkdownConfigurationBuilder.setVideoImageCallback(videoImageCallback)
        // 设置代码复制按钮的点击事件
        MarkdownConfigurationBuilder.setCodeCopyCallback(codeCopyCallback)
        // 设置代码全屏按钮的点击事件
        MarkdownConfigurationBuilder.setCodeFullScreenCallback(codeFullScreenCallback)
        // 设置数学公式图片点击事件
        MarkdownConfigurationBuilder.setLatexImageCallbackCallback(latexImageCallbackCallback)
        // 设置脚注跳转指定位置
        MarkdownConfigurationBuilder.setFootnoteCallback(footnoteCallback)
        return MarkdownConfigurationBuilder.build()
    }

    /**
     * 设置MarkdownTheme
     *
     * @return MarkdownTheme
     */
    func setMarkdownTheme(): MarkdownTheme {
        let markdownThemeBuilder: MarkdownThemeBuilder = MarkdownTheme.emptyBuilder()

        // 1、音频
        markdownThemeBuilder.setAudioIcon(@r(app.media.app_icon)) // 设置音频icon
        markdownThemeBuilder.setAudioButtonText("超长超长超长音频按钮文字音频按钮文字音频按钮文字音频按钮文字") //设置音频按钮文字内容
        markdownThemeBuilder.setAudioBorderColor(Color.GREEN) //设置音频边框颜色

        // 2、视频
        markdownThemeBuilder.setVideoImage(@r(app.media.place_holder)) // 设置视频默认占位图
        markdownThemeBuilder.setPlayCircleFillIcon(@r(app.media.play_circle_fill)) // 设置视频播放按钮默认图标

        return markdownThemeBuilder.build()
    }

    /**
     * 链接的点击事件
     *
     * @param url 链接url
     */
    func linkCallback(url: String): Unit {
        PromptAction.showToast(message: url)
        Hilog.error(1, "1", "------------------------LinkCallback:${url}")
    }

    /**
     * 图片的点击事件
     *
     * @param url 图片url
     * @param arr 图片和视频的url集合
     */
    func imageCallback(url: String, arr: ArrayList<String>): Unit {
        PromptAction.showToast(message: url)
        Hilog.error(1, "1", "------------------------LinkCallback:${url},arr:${arr}")
    }

    /**
     * 音频的点击事件
     *
     * @param url 音频url
     */
    func audioCallback(url: String): Unit {
        PromptAction.showToast(message: url)
        Hilog.error(1, "1", "------------------------LinkCallback:${url}")
    }

    /**
     * 视频的点击事件
     *
     * @param url 视频url
     * @param arr 图片和视频的url集合
     */
    func videoCallback(url: String, arr: ArrayList<String>): Unit {
        PromptAction.showToast(message: url)
        Hilog.error(1, "1", "------------------------videoCallback:${url},arr:${arr}")
    }

    /**
     * 视频的图片替换回调
     *
     * @param url 视频url
     * @param videoImageCallbackCallback 视频首帧图回调
     */
    func videoImageCallback(url: String, videoImageCallbackCallback: (String, Float64, Int64) -> Unit) {
        Hilog.error(1, "1", "------------------------videoImageCallback:${url}")
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

    /**
     * 代码全屏按钮的点击事件
     *
     * @param code 代码内容
     * @param infos 代码类型
     */
    func codeFullScreenCallback(code: String, infos: ?String): Unit {
        PromptAction.showToast(message: "${code}${infos}")
        Hilog.error(1, "1", "------------------------codeFullScreenCallback:${code}")
        Hilog.error(1, "1", "------------------------codeFullScreenCallback:${infos}")
    }

    /**
     * 数学公式图片点击事件
     *
     * @param data 数学公式图片数组内容
     * @param height 图片高度
     * @param width 图片宽度
     */
    func latexImageCallbackCallback(data: Array<UInt8>, height: Length, width: Length): Unit {
        Hilog.error(1, "1", "------------------------data:${data}")
        Hilog.error(1, "1", "------------------------height:${height.value}")
        Hilog.error(1, "1", "------------------------width:${width.value}")
    }

    /**
     * 脚注跳转指定位置
     *
     * @param f 指定位置
     */
    func footnoteCallback(f: ?Float64): Unit {
        scroller.scrollBy(xOffset: 0.0, yOffset: f.getOrThrow())
        Hilog.error(1, "2", "------------------------footnoteCallback:f:${f}")
    }
}

