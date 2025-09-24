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
import std.time.*
import ohos.hilog.Hilog

/**
 * markdown外层是list
 */
@Entry
@Component
class ListMarkdownPage {
    let mdStr0: String = getFileContextStr("001_测试用例/超大数据.md")
    let mdStr1: String = getFileContextStr("001_测试用例/002_标题.md")
    let mdStr4: String = getFileContextStr("001_测试用例/003_段落.md")
    let mdStr2: String = getFileContextStr("001_测试用例/004_分割线.md")
    let mdStr3: String = getFileContextStr("001_测试用例/005_表格.md")
    let mdStr5: String = getFileContextStr("001_测试用例/006_数学公式.md")

    let arr = [mdStr0, mdStr1, mdStr2, mdStr3, mdStr4, mdStr5]

    func build() {
        Column() {
            titleComponent(
                "列表嵌套markdown",
                true
            )
            List() {
                ForEach(
                    arr,
                    itemGeneratorFunc: {
                        str: String, index: Int64 => ListItem() {
                            Column() {
                                MarkdownComponent(output: str, markdownConfiguration: setConfig())
                            }
                            .height(500.percent)
                            // 边框颜色
                            .borderColor(Color.BLACK)
                            // 边框宽度
                            .borderWidth(1)
                            // 背景颜色
                            .backgroundColor(Color.WHITE)
                        }
                    }
                )
            }
            // 背景颜色
            .backgroundColor(Color.GRAY)
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
}
