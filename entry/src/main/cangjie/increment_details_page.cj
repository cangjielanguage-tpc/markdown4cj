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
class IncrementDetailsPage {
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
                                scroller.scrollEdge(Edge.Bottom)
                            }
                        }
                    }
                }
            Scroll(scroller) {
                Column {
                    MarkdownComponent(
                        output: output,
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

        // 1、上下文
        markdownThemeBuilder.setAbilityContext(getGlobalAbilityContext()) // 设置上下文

        // 2、模块间距
        markdownThemeBuilder.setBlockTopAndBottomMargins(10.0) // 设置每个模块之间上下间距

        // 3、链接
        markdownThemeBuilder.setIsLinkStyle(true) // 设置链接是否是图片显示
        // 文本格式
        markdownThemeBuilder.setLinkColor(Color.RED) // 设置文本格式链接的文本颜色
        markdownThemeBuilder.setLinkSize(15.0) // 设置文本格式链接文字大小
        markdownThemeBuilder.setIsLinkUnderlined(false) // 设置是否显示文本格式链接下划线
        // 圆形图片
        markdownThemeBuilder.setLinkCircleImageRadius(16.0) // 设置圆形链接半径
        markdownThemeBuilder.setLinkCircleImageTextSize(10.0) // 设置圆形链接文字大小
        markdownThemeBuilder.setLinkCircleImageMargin(2.0) // 设置圆形链接左右边距
        markdownThemeBuilder.setLinkCircleImageBackGroupColor(Color.WHITE) // 设置圆形链接主题背景颜色
        markdownThemeBuilder.setLinkCircleImageButtonBackGroupColor(Color.BLACK) // 设置圆形链接控件背景颜色
        markdownThemeBuilder.setLinkCircleImageTextColor(Color.WHITE) // 设置圆形链接文字颜色
        // 圆角图片
        markdownThemeBuilder.setLinkRectImageRadius(16.0) // 设置圆角矩形链接圆角半径
        markdownThemeBuilder.setLinkRectImageMargin(2.0) // 设置圆角矩形链接左右边距
        markdownThemeBuilder.setLinkRectImageHeight(16.0) // 设置圆角矩形链接控件高度
        markdownThemeBuilder.setLinkRectImageTextSize(10.0) // 设置圆角矩形链接文字大小
        // 空心圆角图片
        markdownThemeBuilder.setLinkRectToolImageDividingLineWidth(1.0) // 设置空心圆角矩形链接分割线宽度
        markdownThemeBuilder.setLinkRectToolImageTextSize(11.0) // 设置空心圆角矩形链接文字大小
        markdownThemeBuilder.setLinkRectToolImageMargin(2.0) // 设置空心圆角矩形链接左右边距

        // 4、列表
        markdownThemeBuilder.setBlockOrderedAndBulletTopAndBottomMargins(0.0) // 设置列表子模块间距
        markdownThemeBuilder.setBlockQuoteTopAndBottomMargins(0.0) // // 设置块引用子模块间距
        // 块引用
        markdownThemeBuilder.setBlockQuoteColor(Color.RED) // 设置块引用左边线条颜色
        markdownThemeBuilder.setBlockQuoteBackGroupColor(Color.GRAY) // 设置块引用背景颜色
        // 有序列表
        markdownThemeBuilder.setOrderedListItemSize(15.0) // 设置有序列表项的字体大小
        markdownThemeBuilder.setOrderedListItemLineHeight(25.0) // 设置有序列表项文本行高
        // 无序列表
        markdownThemeBuilder.setBulletListItemColor(Color.GREEN) // 设置无序列表项的颜色
        markdownThemeBuilder.setBulletListItemLineHeight(22.0) // 设置无序列表项文本行高
        // 任务列表

        // 5、代码
        // 内联代码
        markdownThemeBuilder.setCodeTextColor(Color(0xFFFF5722)) // 设置内联代码文本颜色
        // 代码块
        markdownThemeBuilder.setCodeCopyIcon(@r(app.media.app_icon)) // 设置代码复制按钮默认图标
        markdownThemeBuilder.setCodeBlockRadius(0.0) //  设置代码块圆角
        // 组合代码
        // 单独代码块
        markdownThemeBuilder.setIsSeparateCodeBlock(false) // 设置是否单独代码块

        // 6、标题
        markdownThemeBuilder.setHeadingBreakHeight(0.0) // 设置H1、H2标题下分割线高度
        markdownThemeBuilder.setHeadingTextSizeMultipliers([15.0, 15.0, 15.0, 15.0, 15.0, 15.0]) // 设置标题文本大小数组
        markdownThemeBuilder.setHeadingTextColor(Color(0xFF222222)) // 设置标题字体颜色
        markdownThemeBuilder.setHeadingTextLineHeight1(25.0) // 设置一级标题文本行高
        markdownThemeBuilder.setHeadingTextLineHeight2(25.0) // 设置二级标题文本行高
        markdownThemeBuilder.setHeadingTextLineHeight3(25.0) // 设置三级标题文本行高
        markdownThemeBuilder.setHeadingTextLineHeight4(25.0) // 设置四级标题文本行高
        markdownThemeBuilder.setHeadingTextLineHeight5(25.0) // 设置五级标题文本行高
        markdownThemeBuilder.setHeadingTextLineHeight6(25.0) // 设置六级标题文本行高

        // 7、段落
        markdownThemeBuilder.setParagraphTextColor(Color(0xFF222222)) // 设置段落字体颜色
        markdownThemeBuilder.setParagraphTextSize(15.0) // 设置段落字体大小
        markdownThemeBuilder.setParagraphTextLineHeight(25.0) // 设置段落文本行高

        // 8、分割线
        markdownThemeBuilder.setThematicBreakColor(Color.BLUE) // 设置分割线颜色

        // 9、软换行
        markdownThemeBuilder.setIsLineBreak(true) // 设置软换行是否换行

        // 10、数学公式
        markdownThemeBuilder.setLatexMathBackGroupColor(Color(0xFFFBFBFB)) // 设置数学公式背景色
        markdownThemeBuilder.setLatexMathTextColor(Color.GREEN) // 设置数学公式字体颜色

        // 11、音频
        markdownThemeBuilder.setAudioIcon(@r(app.media.app_icon)) // 设置音频icon

        // 12、视频
        markdownThemeBuilder.setVideoImage(@r(app.media.place_holder)) // 设置视频默认占位图
        markdownThemeBuilder.setPlayCircleFillIcon(@r(app.media.play_circle_fill)) // 设置视频播放按钮默认图标

        // 13、图片Banner

        // 14、图片
        markdownThemeBuilder.setImageIsFixedAspectRatio(true)
//        markdownThemeBuilder.setImagePadding(20) //  设置图片宽度边距

        // 15、表格
        markdownThemeBuilder.setTableHeaderRowBackgroundColor(Color(0xFFF5F7FA)) // 设置表格头背景色
        markdownThemeBuilder.setTableOddRowBackgroundColor(Color(0xFFFAFAFA)) // 设置表格奇数行背景色
        markdownThemeBuilder.setTableEvenRowBackgroundColor(Color(0xFFFFFFFF)) // 设置表格偶数行背景色
        markdownThemeBuilder.setTableBorderWidth(2.0) // 设置表格边框宽度
        markdownThemeBuilder.setTableBorderColor(Color.RED) // 设置表格边框颜色

        // 16、代码高亮
        markdownThemeBuilder.setPrismTheme(PrismThemeDarkula.create()) // 设置markdown代码高亮样式

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
