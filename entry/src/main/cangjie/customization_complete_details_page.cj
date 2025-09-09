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
 * 定制化全量加载详情页面
 */
@Entry
@Component
class CustomizationCompleteDetailsPage {
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

    func setConfig(): MarkdownAIConfiguration {
//        AppLog.error("CJMarkDown fontSize " + (if (let Some(v) <- fontSize) {v} else {15.0}).toString())
//        AppLog.error("CJMarkDown fontColor " + (if (let Some(v) <- fontColor) {v} else {UInt32(0xFF222222)}).toString())
//        AppLog.error("CJMarkDown lineHeight " + (if (let Some(v) <- lineHeight) {v} else { 0.0 }).toString())
//        AppLog.error("CJMarkDown lineStyle " + (if (let Some(v) <- linkStyle) {v} else { "button" }).toString())
//        AppLog.error("CJMarkDown copyIcon " + (if (let Some(v) <- copyIcon) {v.id} else { 404 }).toString())
        let markdownConfigurationBuilder: MarkdownAIConfigurationBuilder = MarkdownAIConfiguration.emptyBuilder()
        markdownConfigurationBuilder.setMarkdownAITheme(setMarkdownAITheme())
        markdownConfigurationBuilder.setImageCallback(imageCallback)
        markdownConfigurationBuilder.setImageCallbackCallback(imageCallbackCallback)
        markdownConfigurationBuilder.setVideoCallback(videoCallback)
        markdownConfigurationBuilder.setVideoImageCallback(videoImageCallback)
        markdownConfigurationBuilder.setLinkCallback(linkCallback)
        markdownConfigurationBuilder.setCodeCopyCallback(codeCopyCallback)
        markdownConfigurationBuilder.setCodeFullScreenCallback(codeFullScreenCallback)
        markdownConfigurationBuilder.setLatexImageCallbackCallback(latexImageCallbackCallback)
        return markdownConfigurationBuilder.build()
    }

    func setMarkdownAITheme(): MarkdownAITheme {
        let markdownTheme: MarkdownAITheme = MarkdownAITheme
            .emptyBuilder()

             .setIsLinkSize(false)
             //设置每个模块之间上下间距
             .setBlockTopAndBottomMargins(6.0)

             // 设置段落字体颜色
//            .setParagraphTextColor(if (let Some(v) <- fontColor) {Color(v)} else {Color(0xFF000000)})
            .setParagraphTextColor(Color(0xFF000000))
             // 设置段落字体大小
//            .setParagraphTextSize(if (let Some(v) <- fontSize) {v} else {16.0})
             // 设置段落字体大小
            .setParagraphTextSize(16.0)
             // 设置段落文本行高
//            .setParagraphTextLineHeight(if (let Some(v) <- lineHeight) {v} else {22.0})
            .setParagraphTextLineHeight(22.0)
            // 设置段落文本字间距
            .setParagraphTextWordSpace(0.5)

            // 设置一级二级标题下划线高度
            .setHeadingBreakHeight(0.0)
            // 设置标题字体大小
            .setHeadingTextSizeMultipliers([20.0, 18.0, 17.0, 16.0, 15.0, 14.0]) // fp
            // 标题颜色
            .setHeadingTextColor(Color(0xFF000000))

            //块引用左边距
            .setBlockQuoteLeftMargin(3.0)
            //块引用竖线和文字的间隔
            .setBlockQuoteRightMargin(10.0)
            //设置块引用左边线条宽度
            .setBlockQuoteWidth(3.0)
             //设置块引用左边线条颜色
            .setBlockQuoteColor(Color(0xFFE7E7E9))


             //设置有序列表项的字体大小(实际是开头序号大小)
            .setOrderedListItemSize(16.0)
             // 有序列表是否加粗
            .setOrderedListItemPrefixBold(true)
            //设置无序列表项的字体大小（实际是左边小圆点的大小）
            .setBulletListItemSize(8.0)
            //设置无序列表项行高(配合无序列表字体大小可以让圆点居中)
            .setBulletListItemLineHeight(20.0)


            //设置链接颜色
            .setLinkColor(Color(0xFF1B539A))
            //设置是否显示链接下划线
            .setIsLinkUnderlined(false)
            //设置链接文字大小
            .setLinkSize(16.0)

            //分割线颜色
            .setThematicBreakColor(Color(0xFFE7E7E9))
            //分割线上部外边距
            .setThematicBreakTopMargin(10.0)
            //分割线下部外边距
            .setThematicBreakBottomMargin(10.0)

            //设置表格内容内边距 - 单位vp
            .setTableCellPadding(6.0)
            //设置表格边框颜色
            .setTableBorderColor(Color(0xFFE6E7E8))
            //设置表格最大宽度，宽度超过屏幕可以左右滑动
            .setTableMaxTextWidth(100.0)
            //设置表格最小宽度，宽度超过屏幕可以左右滑动
            .setTableMinTextWidth(100.0)
            //表格第一列字体加粗
            .setTableFirstColumnBold(true)
            //设置表格奇数行背景色
            .setTableOddRowBackgroundColor(Color.TRANSPARENT)
            //设置表格偶数行背景色
            .setTableEvenRowBackgroundColor(Color.TRANSPARENT)

            //设置内联代码文本颜色
            .setCodeTextColor(Color(0xFF000000))
            //设置内联代码背景颜色，需要内联代码图片显示选项
            .setIsCodeStyle(true)
            .setCodeBackgroundColor(Color(0xFFF2F3F4))
            //设置内联代码文本大小
            .setCodeTextSize(16.0)

            //设置代码块系列（缩进代码、围栏代码、组合代码）文本大小
            .setCodeBlockTextSize(14.0)
            //设置代码块系列（缩进代码、围栏代码、组合代码）文本颜色
            .setCodeBlockTextColor(Color(0xFF000000))
            //设置代码块系列（缩进代码、围栏代码、组合代码）背景颜色
            .setCodeBlockBackgroundColor(Color(0xFFF2F3F4))
            //代码块语言类型文本颜色
            .setCodeBlockTypeTextColor(Color(0xFF686c72))
            // 代码复制按钮默认图
//            .setCodeCopyIcon(if (let Some(v) <- copyIcon) {v} else {@r(app.media.startIcon)})
            // 代码复制按钮默认图
            .setCodeCopyIcon(@r(app.media.startIcon))
            // 代码复制按钮隐藏
            .setCodeBlockIconTextHide(false)
            //设置代码全屏按钮和代码复制按钮宽高
            .setIconWidthAndHeight(15.0)
            //设置代码块系列（缩进代码、围栏代码、组合代码）圆角
            .setCodeBlockRadius(6.0)
            //代码块行号是否显示
            .setCodeBlockLineNumberHide(false)
            // 块结构公式居中
            .setLatexMathBlockCenter(true)
            // 公式资源路径
//            .setLatexMathResStr("/data/storage/el1/bundle/entry/resources/resfile/res")
            //代码块代码类型默认文本
//            .setCodeBlockTypeTextStr(if (let Some(v) <- defaultCodeTitle) {v} else { "" })
            //代码块代码类型默认文本
            .setCodeBlockTypeTextStr("")
            //代码类型和代码块距离
            .setCodeBlockTypeTextPadding(10.0)

////            // 代码块背景色
//            .setCodeBlockBackgroundColor(Color(0xFF282C35))
//            .setCodeBlockTextColor(Color(0xFFF5F5F5))
//            // 数学公式
//            .setLatexMathBackGroupColor(Color(0xFFFBFBFB))
//            // 设置上下文
//            .setStageContext(GlobalContext.getContext().getOrThrow())
//            // 链接样式 button 或 文字
//            .setIsLinkStyle(if (let Some(v) <- linkStyle) { if (v == "button") { true } else { false }} else { true })
//            // 链接相关样式
//            .setLinkCircleImageRadius(16.0)
//            .setLinkCircleImageTextSize(10.0)
//            .setLinkCircleImageMargin(2.0)
//            .setLinkRectImageRadius(16.0)
//            .setLinkRectImageMargin(2.0)
//            .setLinkRectImageHeight(16.0)
//            .setLinkRectImageTextSize(10.0)
//            .setLinkRectToolImageDividingLineWidth(1.0)
//            .setLinkRectToolImageTextSize(11.0)
//            .setLinkRectToolImageMargin(2.0)
            .build()
        return markdownTheme
    }

    func imageCallback(url: String, urls: ArrayList<String>) {
        Hilog.error(1,"1","------------------------imageCallback:${url}")
    }

    func videoCallback(url: String, urls: ArrayList<String>) {
        Hilog.error(1,"1","------------------------videoCallback:${url}")
    }

    func videoImageCallback(url: String, videoImageCallbackCallback: (String, Float64, Int64) -> Unit) {
        Hilog.error(1,"1","------------------------videoImageCallback:${url}")
    }

    func imageCallbackCallback(url: String):?Array<UInt8> {
        var arrayUInt8: Array<UInt8> =  ResourceManager.getResourceManager(getStageContext(getGlobalAbilityContext())).getRawFileContent("startIcon.png")
        return arrayUInt8
    }

    func linkCallback(url: String) {
        Hilog.error(1,"1","------------------------LinkCallback:${url}")
    }

    func codeCopyCallback(url: String) {
        Hilog.error(1,"1","------------------------codeCopyCallback:${url}")
    }

    func codeFullScreenCallback(url: String, infos: ?String) {
        Hilog.error(1,"1","------------------------codeFullScreenCallback:${url} ${infos}")
    }

    func latexImageCallbackCallback(data: Array<UInt8>, height: Length, width: Length) {
        Hilog.error(1,"1","------------------------latexImageCallbackCallback:${data.size} ${height.value} ${width.value}")
    }
}
