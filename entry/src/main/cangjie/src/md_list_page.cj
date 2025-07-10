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
import std.sync.sleep
import std.time.*
import ohos.hilog.Hilog

/**
 * markdown外层是list
 */
@Entry
@Component
class MDListPage {
    let mdStr0: String = getFileContextStr("all.md")
    let mdStr1: String = getFileContextStr("audio_video.md")
    let mdStr4: String = getFileContextStr("big_data.md")
    let mdStr2: String = getFileContextStr("latex.md")
    let mdStr3: String = getFileContextStr("table.md")
    let mdStr5: String = getFileContextStr("title.md")

    let arr = [mdStr0, mdStr1, mdStr2, mdStr3, mdStr4, mdStr5]

    func build() {
        List() {
            ForEach(
                arr,
                itemGeneratorFunc: {
                    str: String, index: Int64 =>
                        ListItem(){
                            Column(){
                                MarkdownAIComponent(output: str, isFull: true, markdownAIConfiguration: setConfig())
                            }
//                            .margin(20)
                            .borderColor(Color.BLACK)
                            .borderWidth(1)
                            .backgroundColor(Color.WHITE)
                        }
                }
            )
        }
        .backgroundColor(Color.GRAY)
    }

    func setConfig(): MarkdownAIConfiguration {
        let MarkdownAIConfigurationBuilder: MarkdownAIConfigurationBuilder = MarkdownAIConfiguration.emptyBuilder()
        MarkdownAIConfigurationBuilder.setMarkdownAITheme(setMarkdownAITheme())
        MarkdownAIConfigurationBuilder.setImageCallback(imageCallback)
        MarkdownAIConfigurationBuilder.setAudioCallback(audioCallback)
        MarkdownAIConfigurationBuilder.setVideoCallback(videoCallback)
        MarkdownAIConfigurationBuilder.setVideoImageCallback(videoImageCallback)
        MarkdownAIConfigurationBuilder.setLinkCallback(linkCallback)
        MarkdownAIConfigurationBuilder.setCodeCopyCallback(codeCopyCallback)
        MarkdownAIConfigurationBuilder.setCodeFullScreenCallback(codeFullScreenCallback)
        MarkdownAIConfigurationBuilder.setLatexImageCallbackCallback(latexImageCallbackCallback)
        MarkdownAIConfigurationBuilder.setFootnoteCallback(footnoteCallback)
        return MarkdownAIConfigurationBuilder.build()
    }

    func setMarkdownAITheme(): MarkdownAITheme {
        let MarkdownAITheme: MarkdownAITheme = MarkdownAITheme
            .emptyBuilder()
            // 代码复制按钮默认图
            .setCodeCopyIcon(@r(app.media.app_icon))
            // 音频icon
            .setAudioIcon(@r(app.media.app_icon))
            // 视频占位图
            .setVideoImage(@r(app.media.place_holder))
            // 视频占位图
            .setPlayCircleFillIcon(@r(app.media.play_circle_fill))
            // 设置一级二级标题下划线高度
            .setHeadingBreakHeight(0.0)
            // 标题字体大小
            .setHeadingTextSizeMultipliers([15.0, 15.0, 15.0, 15.0, 15.0, 15.0]) // fp
            // 字体颜色
            .setParagraphTextColor(Color(0xFF222222))
            // 字体大小
            .setParagraphTextSize(15.0)
            // 行高
            .setParagraphTextLineheight(25.0)
            // 内联代码颜色
            .setCodeTextColor(Color(0xFFFF5722))
            // 标题
            .setHeadingTextColor(Color(0xFF222222))
            // 链接颜色
            .setLinkColor(Color(0xFF000000))
            // 数学公式
            .setLatexMathBackGroupColor(Color(0xFFFBFBFB))
            // 表格
            .setTableHeaderRowBackgroundColor(Color(0xFFF5F7FA))
            .setTableOddRowBackgroundColor(Color(0xFFFAFAFA))
            .setTableEvenRowBackgroundColor(Color(0xFFFFFFFF))
            .setTableBorderWidth(2.0)
            .setTableBorderColor(Color.RED)
            // 设置上下文
            .setAbilityContext(getGlobalAbilityContext())
            // 链接样式 button 或 文字
            .setIsLinkStyle(true)
            // 链接相关样式
            .setLinkCircleImageRadius(16.0)
            .setLinkCircleImageTextSize(10.0)
            .setLinkCircleImageMargin(2.0)
            .setLinkCircleImageBackGroupColor(Color.WHITE)
            .setLinkCircleImageButtonBackGroupColor(Color.BLACK)
            .setLinkCircleImageTextColor(Color.WHITE)
            .setLinkRectImageRadius(16.0)
            .setLinkRectImageMargin(2.0)
            .setLinkRectImageHeight(16.0)
            .setLinkRectImageTextSize(10.0)
            .setLinkRectToolImageDividingLineWidth(1.0)
            .setLinkRectToolImageTextSize(11.0)
            .setLinkRectToolImageMargin(2.0)
            .setImagePadding(20)
            .build()
        return MarkdownAITheme
    }

    func footnoteCallback(f: ?Float64) {
        //scroller.scrollBy(xOffset: 0.0, yOffset: f.getOrThrow())
        Hilog.error(1, "2", "------------------------footnoteCallback:f:${f}")
    }

    func imageCallback(url: String,arr:ArrayList<String>) {
        PromptAction.showToast(message: url)
        Hilog.error(1,"1","------------------------LinkCallback:${url},arr:${arr}")
    }

    func audioCallback(url: String) {
        PromptAction.showToast(message: url)
        Hilog.error(1,"1","------------------------LinkCallback:${url}")
    }

    func videoCallback(url: String,arr:ArrayList<String>) {
        PromptAction.showToast(message: url)
        Hilog.error(1,"1","------------------------videoCallback:${url},arr:${arr}")
    }

    func videoImageCallback(url: String, videoImageCallbackCallback: (String,Float64,Int64) -> Unit) {
        if (url == "562986b1-46d8-48ef-bac6-82685bcedcd8") {
            videoImageCallbackCallback("",16.0/9.0,100)
        } else {
            videoImageCallbackCallback("",16.0/9.0,100)
        }
        Hilog.error(1,"1","------------------------videoImageCallback:${url}")
    }

    func linkCallback(url: String) {
        PromptAction.showToast(message: url)
        Hilog.error(1,"1","------------------------LinkCallback:${url}")
    }

    func codeCopyCallback(url: String) {
        PromptAction.showToast(message: url)
        Hilog.error(1,"1","------------------------codeCopyCallback:${url}")
    }

    func codeFullScreenCallback(url: String, infos: ?String) {
        PromptAction.showToast(message: "${url}${infos}")
        Hilog.error(1,"1","------------------------codeFullScreenCallback:${url}")
        Hilog.error(1,"1","------------------------codeFullScreenCallback:${infos}")
    }

    func latexImageCallbackCallback(data: Array<UInt8>, height: Length, width: Length) {
        Hilog.error(1,"1","------------------------data:${data}")
        Hilog.error(1,"1","------------------------height:${height.value}")
        Hilog.error(1,"1","------------------------width:${width.value}")
    }
}
