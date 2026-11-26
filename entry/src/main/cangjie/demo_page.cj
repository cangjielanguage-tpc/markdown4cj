package ohos_app_cangjie_entry

import ohos.state_macro_manage.*
import ohos.hybrid_base.*

@HybridComponentEntry
@Component
class Demo_page {
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
    var mdStr: String = """
### 标题1

# 1级标题

### 标题2

## 2级标题

### 标题3

### 3级标题

### 标题4

#### 4级标题

### 标题5

##### 5级标题

### 标题6

###### 6级标题

### 标题7

### 正常标题

### 标题8

Heading level 1
===============

### 标题9

Heading level 2
---------------

### 标题10

Heading level 1
=

### 标题11

Heading level 2
-

"""

    public func build() {
        Scroll() {
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
        // 设置滚动方法
        .scrollable(ScrollDirection.Vertical)
    }
}
