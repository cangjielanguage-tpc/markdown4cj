package ohos_app_cangjie_entry

import ohos.state_macro_manage.*
import ohos.hybrid_base.*
import ohos.hilog.*

/**
 * AI 聊天气泡组件（对齐 ArkTS AIChatBlock / AIChatLazyBlock）
 *
 * - who=Me：蓝色气泡靠右
 * - who=You：白色气泡靠左
 * - 短文本（≤60字符）用 Text 渲染，长文本用 MarkdownComponent 渲染
 *
 * 用于 AIChatDetailsPage（全量加载）和 AIChatLazyDetailsPage（懒加载）。
 */
@Component
class AIChatBlock {
    @Prop
    var output: String
    @Prop
    var who: Who
    @Prop
    var incrementalAnalysis: Bool
    var scroller: Scroller = Scroller()
    @State
    var markdownConfiguration: MarkdownConfiguration = MarkdownConfiguration.createEmpty()
    var markdownPlugin: Markdown = Markdown
        .builder()
        .usePlugin(HtmlPlugin.create())
        .usePlugin(TaskListPlugin.create())
        .usePlugin(StrikethroughPlugin.create())
        .usePlugin(TablePlugin.create())
        .usePlugin(LatexMathPluginV2.create())
        .usePlugin(BlockAudioPlugin.create())
        .usePlugin(BlockVideoPlugin.create())
        .usePlugin(LinkifyPlugin.create([]))
        .usePlugin(ImageSlidePlugin.create())
        .usePlugin(ImageStylePlugin.create())
        .usePlugin(CodeListPlugin.create())
        .usePlugin(FootnotePlugin.create())
        .usePlugin(TocPlugin.create())
        .usePlugin(ImageCollectPlugin.create())
        .usePlugin(NodeIdPlugin.create())
        .build()

    protected override func aboutToAppear(): Unit {
        let theme = MarkdownTheme.createDefault()
        theme.getGlobalTheme().isOnCopy = false
        theme.getGlobalTheme().isMarkdownParserSync = true
        markdownConfiguration.setMarkdownTheme(theme)
        markdownConfiguration.setLinkCallback(linkCallback)
        markdownConfiguration.setImageCallback(imageCallback)
        markdownConfiguration.setCodeCopyCallback(codeCopyCallback)
        markdownConfiguration.setCodeFullScreenCallback(codeFullScreenCallback)
    }

    func linkCallback(url: String): Unit {
        Hilog.error(1, "1", "---url:${url}")
    }

    func imageCallback(url: String, urlList: ArrayList<String>): Unit {
        Hilog.error(1, "1", "---url:${url},urlList:${urlList}")
    }

    func codeCopyCallback(code: String): Unit {
        Hilog.error(1, "1", "---code:${code}")
    }

    func codeFullScreenCallback(code: String, info: Option<String>): Unit {
        Hilog.error(1, "1", "---code:${code},info:${info}")
    }

    func isText(): Bool {
        return output.size <= 60
    }

    @Builder
    func messageContent(bgColor: UInt32, fontColor: UInt32) {
        Column {
            if (isText()) {
                Text(output)
                    .fontColor(fontColor)
                    .fontSize(15.0)
            } else {
                MarkdownComponent(
                    output: output,
                    isInputEnded: true,
                    incrementalAnalysis: incrementalAnalysis,
                    scroller: scroller,
                    markdownConfiguration: markdownConfiguration,
                    markdownPlugin: markdownPlugin
                )
            }
        }
        .constraintSize(maxWidth: 75.percent)
        .padding(
            left: 10.0,
            right: 10.0,
            top: if (isText()) {
                10.0
            } else {
                1.0
            },
            bottom: if (isText()) {
                10.0
            } else {
                0.0
            }
        )
        .backgroundColor(bgColor)
        .borderRadius(10.0)
    }

    public func build() {
        Column {
            if (who == Who.Me) {
                Row {
                    messageContent(0xFF4C96FF, 0xFFFFFFFF)
                }
                .justifyContent(FlexAlign.End)
                .alignItems(VerticalAlign.Top)
                .width(100.percent)
            } else {
                Row {
                    messageContent(0xFFFFFFFF, 0xFF000000)
                }
                .justifyContent(FlexAlign.Start)
                .alignItems(VerticalAlign.Top)
                .width(100.percent)
            }
        }
        .width(100.percent)
        .padding(left: 10.0, right: 10.0)
    }
}
