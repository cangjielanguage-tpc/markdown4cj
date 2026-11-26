package ohos_app_cangjie_entry

import ohos.state_macro_manage.*
import ohos.hybrid_base.*

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
    // 高度估算专用插件链：配置与渲染插件链一致，nodeId按内容哈希计算，与渲染结果一致
    // 主线程高度解析与worker渲染解析使用不同实例，避免并发共享插件内部状态导致解析树损坏闪退
    var markdownHeightPlugin: Markdown = Markdown
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
        estimatedHeightByNode = preMarkwonHeightByNode(mdStr, markdownConfiguration, markdownHeightPlugin, componentWidth: getMarkdownComponentWidth(paddingH: 5.0))
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
                        markdownConfiguration: markdownConfiguration,
                        markdownPlugin: markdownPlugin
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
