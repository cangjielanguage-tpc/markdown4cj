package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.hybrid_base.*
import markdown.components.*
import markdown.components.theme.*
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
class BigDataPage {
    @State
    var fileListStr: String = getGlobalString("fileList")
    @State
    var isExpanded1: Bool = false
    @State
    var isExpanded2: Bool = false
    @State
    var mdStr: String = ""
    @State
    var isInputEnded: Bool = true
    @State
    var incrementalAnalysis: Bool = false
    @State
    var selectedFileName: String = ""
    @State var cfg_isFull: String = "true"
    @State var cfg_incrementalAnalysis: String = "false"
    @State @Watch[onConfigChanged] var cfg_enableParseThrottle: String = "false"
    @State @Watch[onConfigChanged] var cfg_parseThrottleMs: String = "200"
    @State var cfg_time: String = "50"
    @State var cfg_textNumber: String = "10"
    @State @Watch[onConfigChanged] var cfg_isMarkdownParserSync: String = "false"
    @State @Watch[onConfigChanged] var cfg_isOnCopy: String = "false"
    @State @Watch[onConfigChanged] var cfg_blockMarginTop: String = "0"
    @State @Watch[onConfigChanged] var cfg_blockMarginRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_blockMarginBottom: String = "0"
    @State @Watch[onConfigChanged] var cfg_blockMarginLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_markdownBlockSpacing: String = "8"
    @State @Watch[onConfigChanged] var cfg_isLineBreak: String = "false"
    @State @Watch[onConfigChanged] var cfg_backgroundColor: String = "undefined"
    @State var cfg_openGestureSwipeTest: String = "false"
    @State @Watch[onConfigChanged] var cfg_openGestureSwipe: String = "false"
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
        updateConfig()
    }

    func onConfigChanged(): Unit {
        updateConfig()
    }

    func getFileList(): Array<String> {
        if (fileListStr == "") {
            return []
        }
        return fileListStr.split(",")
    }

    func loadFile(item: String) {
        let rawFilePath = getGlobalString("rawFilePath")
        let fullPath = rawFilePath + "/" + item
        callGlobalFunc("loadContent", fullPath)
        let fullContent = getGlobalString("markdownContent")
        selectedFileName = item
        let isFull = parseBool(cfg_isFull)
        let textNumber = parseInt64(cfg_textNumber)
        let timeMs = parseInt64(cfg_time)
        let incremental = parseBool(cfg_incrementalAnalysis)
        incrementalAnalysis = incremental
        arr = fullContent.toRuneArray()
        mdStr = ""
        isInputEnded = isFull
        if (isFull) {
            mdStr = fullContent
            estimatedHeightByNode = preMarkwonHeightByNode(fullContent, markdownConfiguration, markdownPlugin)
        } else {
            let number = textNumber
            let time = timeMs
            let total = arr.size
            spawn {
                for (i in 0..total : number) {
                    sleep(Duration.millisecond * time)
                    launch {
                        let size = if (total > i + number) {
                            i + number
                        } else {
                            total
                        }
                        mdStr += String(arr[i..size])
                        scroller.scrollEdge(Edge.Bottom)
                        if (size >= total) {
                            isInputEnded = true
                        }
                    }
                }
            }
        }
    }

    func updateConfig() {
        let theme = markdownConfiguration.getMarkdownTheme()
        let globalTheme = theme.getGlobalTheme()
        globalTheme.blockMarginTop = parseFloat64(cfg_blockMarginTop)
        globalTheme.blockMarginRight = parseFloat64(cfg_blockMarginRight)
        globalTheme.blockMarginBottom = parseFloat64(cfg_blockMarginBottom)
        globalTheme.blockMarginLeft = parseFloat64(cfg_blockMarginLeft)
        globalTheme.markdownBlockSpacing = parseInt64(cfg_markdownBlockSpacing)
        globalTheme.isLineBreak = parseBool(cfg_isLineBreak)
        globalTheme.isOnCopy = parseBool(cfg_isOnCopy)
        globalTheme.isMarkdownParserSync = parseBool(cfg_isMarkdownParserSync)
        globalTheme.openGestureSwipe = parseBool(cfg_openGestureSwipe)
        globalTheme.enableParseThrottle = parseBool(cfg_enableParseThrottle)
        globalTheme.parseThrottleMs = parseInt64(cfg_parseThrottleMs)
        if (cfg_backgroundColor != "undefined") {
            globalTheme.backgroundColor = parseColor(cfg_backgroundColor)
        }
    }

    public func build() {
        Column {
            Text("点击文件名加载:")
                .fontSize(14.0)
                .margin(top: 5.0)

            Scroll {
            Flex(FlexOptions(direction: FlexDirection.Row, wrap: FlexWrap.Wrap)) {
                ForEach(
                    getFileList(),
                    itemGeneratorFunc: {
                        item: String, _: Int64 =>
                            Text(item)
                                .fontSize(12.0)
                                .fontColor(0xFFFFFFFF)
                                .backgroundColor(0xFF2196F3)
                                .height(25.0)
                                .padding(5.0)
                                .borderRadius(5.0)
                                .maxLines(1)
                                .textOverflow(TextOverflow.Clip)
                                .margin(2.0)
                                .onClick {evt => loadFile(item)}
                    }
                )
            }
            .padding(5.0)
            .width(100.percent)
            .backgroundColor(0xFFEAEAEA)
            }
            .width(100.percent)
            .constraintSize(maxHeight: 200.0)
            .scrollable(ScrollDirection.Vertical)
            .scrollBar(BarState.Auto)

            Scroll {
                Column {

                    Column {
                        Row {
                            Text("通用样式配置")
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .fontWeight(FontWeight.Bold)
                                .layoutWeight(1)
                            Text(if (isExpanded1) { "▲" } else { "▼" })
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .padding(right: 20.0)
                                .onClick {
                                    evt => isExpanded1 = !isExpanded1
                                }
                        }
                        .width(100.percent)
                        .padding(5.0)
                        .margin(5.0)
                        .onClick {
                            evt => isExpanded1 = !isExpanded1
                        }

                        if (isExpanded1) {
                            Column {
                                ConfigTabSelector(title: "是否全量加载 - ", options: booleanList, defaultValue: "true", configKey: "", currentValue: cfg_isFull, onSelect: { v => cfg_isFull = v })
                                ConfigTabSelector(title: "是否增量解析 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_incrementalAnalysis, onSelect: { v => cfg_incrementalAnalysis = v })
                                ConfigTabSelector(title: "是否启用解析节流 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_enableParseThrottle, onSelect: { v => cfg_enableParseThrottle = v })
                                ConfigTabSelector(title: "解析节流间隔(ms) - ", options: timeList, defaultValue: "200", configKey: "", currentValue: cfg_parseThrottleMs, onSelect: { v => cfg_parseThrottleMs = v })
                                ConfigTabSelector(title: "增量加载间隔时间 - ", options: timeList, defaultValue: "50", configKey: "", currentValue: cfg_time, onSelect: { v => cfg_time = v })
                                ConfigTabSelector(title: "增量文本数量 - ", options: textNumberList, defaultValue: "10", configKey: "", currentValue: cfg_textNumber, onSelect: { v => cfg_textNumber = v })
                                ConfigTabSelector(title: "是否同步解析 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_isMarkdownParserSync, onSelect: { v => cfg_isMarkdownParserSync = v })
                                ConfigTabSelector(title: "长按复制粘贴 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_isOnCopy, onSelect: { v => cfg_isOnCopy = v })
                                ConfigTabSelector(title: "全局上外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_blockMarginTop, onSelect: { v => cfg_blockMarginTop = v })
                                ConfigTabSelector(title: "全局右外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_blockMarginRight, onSelect: { v => cfg_blockMarginRight = v })
                                ConfigTabSelector(title: "全局下外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_blockMarginBottom, onSelect: { v => cfg_blockMarginBottom = v })
                                ConfigTabSelector(title: "全局左外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_blockMarginLeft, onSelect: { v => cfg_blockMarginLeft = v })
                                ConfigTabSelector(title: "模块间间距 - ", options: marginList, defaultValue: "8", configKey: "", currentValue: cfg_markdownBlockSpacing, onSelect: { v => cfg_markdownBlockSpacing = v })
                                ConfigTabSelector(title: "软换行是否换行 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_isLineBreak, onSelect: { v => cfg_isLineBreak = v })
                                ConfigTabSelector(title: "背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_backgroundColor, onSelect: { v => cfg_backgroundColor = v })
                                ConfigTabSelector(title: "响应滑动测试 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_openGestureSwipeTest, onSelect: { v => cfg_openGestureSwipeTest = v })
                                ConfigTabSelector(title: "控件响应滑动 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_openGestureSwipe, onSelect: { v => cfg_openGestureSwipe = v })
                            }
                            .width(100.percent)
                            .padding(bottom: 5.0, left: 5.0, right: 5.0)
                            .margin(bottom: 5.0, left: 5.0, right: 5.0)
                        }
                    }
                    .width(100.percent)
                    .margin(5.0)
                    .borderRadius(5.0)
                    .backgroundColor(0xFF317AFF)


                    if (mdStr != "") {
                        Text("预览: " + selectedFileName)
                            .fontSize(14.0)
                            .fontColor(0xFF333333)
                            .margin(top: 10.0, left: 5.0)
                        Column {
                            Text("preMarkwonHeightByNode 估算: " + estimatedHeightByNode.toString() + " vp")
                                .fontSize(12.0)
                                .fontColor(0xFF666666)
                                .margin(top: 3.0, left: 5.0)
                            MarkdownComponent(
                                output: mdStr,
                                isInputEnded: isInputEnded,
                                incrementalAnalysis: incrementalAnalysis,
                                scroller: scroller,
                                markdownConfiguration: markdownConfiguration
                            )
                        }
                        .width(100.percent)
                        .padding(5.0)
                        .backgroundColor(0xFFFFFFFF)
                    }
                }
                .justifyContent(FlexAlign.Start)
            }
            .scrollable(ScrollDirection.Vertical)
            .align(Alignment.Top)
            .layoutWeight(1)
        }
        .width(100.percent)
        .layoutWeight(1)
        .backgroundColor(0xFFEAEAEA)
        .justifyContent(FlexAlign.Start)
    }
}