package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.hybrid_base.*
import markdown.components.*
import ohos.concurrency.launch
import markdown.core.Markdown
import markdown.plugin.HtmlPlugin
import markdown.plugin.TaskListPlugin
import markdown.plugin.StrikethroughPlugin
import markdown.plugin.TablePlugin
import markdown.plugin.LatexMathPluginV2
import markdown.plugin.BlockAudioPlugin
import markdown.plugin.BlockVideoPlugin
import markdown.plugin.LinkifyPlugin
import markdown.plugin.ImageSlidePlugin
import markdown.plugin.ImageStylePlugin
import markdown.plugin.CodeListPlugin
import markdown.plugin.FootnotePlugin
import markdown.plugin.TocPlugin
import markdown.plugin.ImageCollectPlugin
import markdown.plugin.NodeIdPlugin

@HybridComponentEntry
@Component
class SwitchDataPage {
    @State
    var arr: Array<Rune> = Array<Rune>()
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
    @State
    var estimatedHeightByNode: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        markdownConfiguration.setMarkdownTheme(MarkdownTheme.createDefault())
        estimatedHeightByNode = preMarkwonHeightByNode(mdStr, markdownConfiguration, markdownPlugin)
    }
    var mdStr: String = getGlobalString("markdownContent")

    public func build() {
        Column {
            Scroll {
                Column {
                    Text("preMarkwonHeightByNode 估算: " + estimatedHeightByNode.toString() + " vp")
                        .fontSize(12.0)
                        .fontColor(0xFF666666)
                        .margin(top: 3.0, left: 5.0)
                    MarkdownComponent(
                        output: mdStr,
                        isInputEnded: true,
                        incrementalAnalysis: false,
                        scroller: scroller,
                        markdownConfiguration: markdownConfiguration
                    )
                }
            }
            .scrollable(ScrollDirection.Vertical)
            .align(Alignment.Top)
            .layoutWeight(1)
        }
        .width(100.percent)
        .height(100.percent)
        .justifyContent(FlexAlign.Start)
    }
}
