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
class Test1CompletePage {

    var mdStr: String = ""

    var scroller: Scroller = Scroller()

    protected override func aboutToAppear(): Unit {
        mdStr = getFileContextStr("test1.md")
        scroller.scrollEdge(Edge.Bottom)
    }

    @State var reachBottom: Bool = true

    var chatTouch: Bool = false

    func build() {
        Column() {
            Scroll(scroller) {
                Column {
                    MarkdownAIComponent(output: mdStr, isFull: true, markdownAIConfiguration: setConfig())
                }
                .margin(right: 10, left: 10)
            }
            // 设置滚动方法
            .scrollable(ScrollDirection.Vertical)
//            .onAppear({=>
//
//                scrollChatIfAtBottom()
//            })
            .onScrollEdge({edge=>
                match (edge) {
                	case Edge.Bottom=> reachBottom = true
                        case _ =>()
                }
            })
//            // 列表到底末尾位置时触发
//            .onReachEnd { =>
//                reachBottom = true
//            }
//            // 列表滑动时触发
            .onScroll {offset =>
//                scroller.scrollTo(xOffset: 0.0, yOffset: scroller.currentOffset().yOffset)
                checkScroll(offset.yOffset)
            }
            // 触摸动作触发该事件
            .onTouch { evt =>
                chatOnTouch(evt)
            }
            .onAreaChange({v, w=>
               scrollChatIfAtBottom()
            })

        }
    }


    func scrollChatIfAtBottom() {
        if (reachBottom) {
            scroll2Bottom()
        }
    }

    func scroll2Bottom() {
        scroller.scrollEdge(Edge.Bottom)
    }

    func checkScroll(offset: Float64) {
        if (offset < -0.5 && chatTouch) {
            reachBottom = false
        }
    }

    func chatOnTouch(evt: TouchEvent) {
        if (let TouchType.Down <- evt.eventType) {
            chatTouch = true
        } else if (let TouchType.Up <- evt.eventType) {
            chatTouch = false
        }
    }

    func setConfig(): MarkdownAIConfiguration {
        let MarkdownAIConfigurationBuilder: MarkdownAIConfigurationBuilder = MarkdownAIConfiguration.emptyBuilder()
        MarkdownAIConfigurationBuilder.setMarkdownAITheme(setMarkdownAITheme())
//        MarkdownAIConfigurationBuilder.setImageCallback(imageCallback)
//        MarkdownAIConfigurationBuilder.setVideoCallback(videoCallback)
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
            // 设置一级二级标题下划线高度
            .setHeadingBreakHeight(0.0)
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
        scroller.scrollBy(xOffset: 0.0, yOffset: f.getOrThrow())
        Hilog.error(1, "2", "------------------------footnoteCallback:f:${f}")
    }

    func imageCallback(url: String) {
        PromptAction.showToast(message: url)
        AppLog.error("------------------------LinkCallback:${url}")
    }

    func videoCallback(url: String) {
        PromptAction.showToast(message: url)
        AppLog.error("------------------------videoCallback:${url}")
    }

    func videoImageCallback(url: String, videoImageCallbackCallback: (String) -> Unit) {
        if (url == "562986b1-46d8-48ef-bac6-82685bcedcd8") {
            videoImageCallbackCallback("https://pic.leetcode-cn.com/1614477066-YeEeWg-file_1614477068523")
        } else {
            videoImageCallbackCallback("https://pic.leetcode-cn.com/1614477067-itHyLr-file_1614477069388")
        }
        AppLog.error("------------------------videoImageCallback:${url}")
    }

    func linkCallback(url: String) {
        PromptAction.showToast(message: url)
        AppLog.error("------------------------LinkCallback:${url}")
    }

    func codeCopyCallback(url: String) {
        PromptAction.showToast(message: url)
        AppLog.error("------------------------codeCopyCallback:${url}")
    }

    func codeFullScreenCallback(url: String, infos: ?String) {
        PromptAction.showToast(message: "${url}${infos}")
        AppLog.error("------------------------codeFullScreenCallback:${url}")
        AppLog.error("------------------------codeFullScreenCallback:${infos}")
    }

    func latexImageCallbackCallback(data: Array<UInt8>, height: Length, width: Length) {
        AppLog.error("------------------------data:${data}")
        AppLog.error("------------------------height:${height.value}")
        AppLog.error("------------------------width:${width.value}")
    }
}
