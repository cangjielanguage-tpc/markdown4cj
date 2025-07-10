/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
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
 * 全量数据全量加载
 */
@Entry
@Component
class BigDataCompletePage {
    var mdStr: String = ""

    var scroller: Scroller = Scroller()

    @State
    var scrollBottom = false

    @State
    var scrollTop = false

    protected override func aboutToAppear(): Unit {
        mdStr = getFileContextStr("big_data.md")
    }

    func build() {
        Column() {
            Text("点击跳转顶部")
                // 点击事件
                .onClick({
                    e => scrollBottom = true
                })
            Text("点击跳转底部")
                // 点击事件
                .onClick({
                    e => scrollTop = true
                })
            Scroll(scroller) {
                Column {
                    MarkdownAIComponent(output: mdStr, isFull: true, markdownAIConfiguration: setConfig())
                }
                .margin(right: 10, left: 10)
            }
            // 设置滚动方法
            .scrollable(ScrollDirection.Vertical)
        }
    }

    func setConfig(): MarkdownAIConfiguration {
        let MarkdownAIConfigurationBuilder: MarkdownAIConfigurationBuilder = MarkdownAIConfiguration.emptyBuilder()
        // 设置markdown样式
        MarkdownAIConfigurationBuilder.setMarkdownAITheme(setMarkdownAITheme())
        // 设置图片点击事件
        MarkdownAIConfigurationBuilder.setImageCallback(imageCallback)
        // 设置视频点击事件
        MarkdownAIConfigurationBuilder.setVideoCallback(videoCallback)
        // 设置视频首帧图片回调事件
        MarkdownAIConfigurationBuilder.setVideoImageCallback(videoImageCallback)
        // 链接点击事件
        MarkdownAIConfigurationBuilder.setLinkCallback(linkCallback)
        // 代码复制点击事件
        MarkdownAIConfigurationBuilder.setCodeCopyCallback(codeCopyCallback)
        // 代码全屏点击事件
        MarkdownAIConfigurationBuilder.setCodeFullScreenCallback(codeFullScreenCallback)
        // 数学公式图片点击事件
        MarkdownAIConfigurationBuilder.setLatexImageCallbackCallback(latexImageCallbackCallback)
        // 脚注点击事件
        MarkdownAIConfigurationBuilder.setFootnoteCallback(footnoteCallback)
        return MarkdownAIConfigurationBuilder.build()
    }

    func setMarkdownAITheme(): MarkdownAITheme {
        let MarkdownAITheme: MarkdownAITheme = MarkdownAITheme
            .emptyBuilder()
            // 上下文设置
            .setAbilityContext(getGlobalAbilityContext()) // 上下文
            // 链接相关设置
            .setLinkColor(Color(0xFF000000)) // 链接文字状态下文本颜色
            .setIsLinkStyle(true) // 链接样式 button 或 文字
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
            // 代码相关设置
            .setCodeCopyIcon(@r(app.media.app_icon)) // 代码复制按钮默认图
            .setCodeTextColor(Color(0xFFFF5722)) // 内联代码字体颜色
            // 标题相关设置
            .setHeadingBreakHeight(0.0) // 设置一级二级标题下划线高度
            .setHeadingTextSizeMultipliers([15.0, 15.0, 15.0, 15.0, 15.0, 15.0]) // 1-6级标题文本大小
            .setHeadingTextColor(Color(0xFF222222)) // 标题字体颜色
            // 段落相关设置
            .setParagraphTextColor(Color(0xFF222222)) // 段落字体颜色
            .setParagraphTextSize(15.0) // 段落字体大小
            .setParagraphTextLineheight(25.0) // 段落行高
            // 数学公式相关设置
            .setLatexMathBackGroupColor(Color(0xFFFBFBFB)) // 数学公式背景颜色
            // 视频相关设置
            .setVideoImage(@r(app.media.place_holder)) // 视频占位图
            .setPlayCircleFillIcon(@r(app.media.play_circle_fill)) // 视频播放按钮占位图
            // 音频相关设置
            .setAudioIcon(@r(app.media.app_icon)) // 音频icon
            // 表格相关设置
            .setTableHeaderRowBackgroundColor(Color(0xFFF5F7FA)) // 表格头背景色
            .setTableOddRowBackgroundColor(Color(0xFFFAFAFA)) // 表格奇数行背景色
            .setTableEvenRowBackgroundColor(Color(0xFFFFFFFF)) // 表格偶数行背景色
            .setTableBorderWidth(2.0) // 表格边框宽度
            .setTableBorderColor(Color.RED) // 表格边框颜色
            // 图片相关设置
            .setImagePadding(20) // 图片宽度边距 - 计算屏幕宽度需要减去padding的宽度
            .build()
        return MarkdownAITheme
    }

    /**
     * 脚注点击事件
     *
     * @param f 需要跳转的偏移量
     */
    func footnoteCallback(f: ?Float64) {
        scroller.scrollBy(xOffset: 0.0, yOffset: f.getOrThrow())
        Hilog.error(1, "2", "------------------------footnoteCallback:f:${f}")
    }

    /**
     * 图片点击事件
     *
     * @param url 图片url
     * @param arr 图片视频url集合
     */
    func imageCallback(url: String, arr: ArrayList<String>) {
        PromptAction.showToast(message: url)
        Hilog.error(1, "1", "------------------------LinkCallback:${url},arr:${arr}")
    }

    /**
     * 视频点击事件
     *
     * @param url 视频url
     * @param arr 图片视频url集合
     */
    func videoCallback(url: String, arr: ArrayList<String>) {
        PromptAction.showToast(message: url)
        Hilog.error(1, "1", "------------------------videoCallback:${url},arr:${arr}")
    }

    /**
     *
     *
     * @param f StringBuilder
     */
    func videoImageCallback(url: String, videoImageCallbackCallback: (String, Float64, Int64) -> Unit) {
//        Hilog.error(1, "1", "------------------------videoImageCallback:${url}")
    }

    /**
     *
     *
     * @param f StringBuilder
     */
    func linkCallback(url: String) {
        PromptAction.showToast(message: url)
        Hilog.error(1, "1", "------------------------LinkCallback:${url}")
    }

    /**
     *
     *
     * @param f StringBuilder
     */
    func codeCopyCallback(url: String) {
        PromptAction.showToast(message: url)
        Hilog.error(1, "1", "------------------------codeCopyCallback:${url}")
    }

    /**
     *
     *
     * @param f StringBuilder
     */
    func codeFullScreenCallback(url: String, infos: ?String) {
        PromptAction.showToast(message: "${url}${infos}")
        Hilog.error(1, "1", "------------------------codeFullScreenCallback:${url}")
        Hilog.error(1, "1", "------------------------codeFullScreenCallback:${infos}")
    }

    /**
     *
     *
     * @param f StringBuilder
     */
    func latexImageCallbackCallback(data: Array<UInt8>, height: Length, width: Length) {
        Hilog.error(1, "1", "------------------------data:${data}")
        Hilog.error(1, "1", "------------------------height:${height.value}")
        Hilog.error(1, "1", "------------------------width:${width.value}")
    }
}
