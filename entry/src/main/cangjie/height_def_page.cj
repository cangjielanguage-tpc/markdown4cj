package ohos_app_cangjie_entry

import ohos.state_macro_manage.*
import ohos.hybrid_base.*

@HybridComponentEntry
@Component
class HeightDefPage {
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
    @State @Watch[onConfigChanged] var cfg_isOnCopy: String = "true"
    @State @Watch[onConfigChanged] var cfg_blockMarginTop: String = "0"
    @State @Watch[onConfigChanged] var cfg_blockMarginRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_blockMarginBottom: String = "0"
    @State @Watch[onConfigChanged] var cfg_blockMarginLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_markdownBlockSpacing: String = "8"
    @State @Watch[onConfigChanged] var cfg_isLineBreak: String = "false"
    @State @Watch[onConfigChanged] var cfg_backgroundColor: String = "#00000000"
    @State var cfg_openGestureSwipeTest: String = "false"
    @State @Watch[onConfigChanged] var cfg_openGestureSwipe: String = "false"

    @State @Watch[onConfigChanged] var cfg_definitionListBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_definitionListMarginTop: String = "0"
    @State @Watch[onConfigChanged] var cfg_definitionListMarginRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_definitionListMarginBottom: String = "0"
    @State @Watch[onConfigChanged] var cfg_definitionListMarginLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_definitionListPaddingTop: String = "0"
    @State @Watch[onConfigChanged] var cfg_definitionListPaddingRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_definitionListPaddingBottom: String = "0"
    @State @Watch[onConfigChanged] var cfg_definitionListPaddingLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_definitionListTermToDescriptionSpacing: String = "8"
    @State @Watch[onConfigChanged] var cfg_definitionListTermTextFontWeight: String = "Semibold"
    @State @Watch[onConfigChanged] var cfg_definitionListTermTextFontStyle: String = "Italic"
    @State @Watch[onConfigChanged] var cfg_definitionListDescriptionItemSpacing: String = "8"
    @State @Watch[onConfigChanged] var cfg_definitionListDescriptionIndent: String = "8"
    var arr: Array<Rune> = Array<Rune>()
    var scroller: Scroller = Scroller()
    var loadGeneration: Int64 = 0 // 流式加载世代计数：切换文件时使旧的流式循环失效，防止旧内容追加到新文件内容上
    @State
    var markdownConfiguration: MarkdownConfiguration = MarkdownConfiguration.createEmpty()
    var markdownPlugin: Markdown = setAllPlugin()
    // 高度估算专用插件链：主线程高度解析与worker渲染解析使用不同实例，避免并发共享插件内部状态导致解析树损坏闪退
    var markdownHeightPlugin: Markdown = setAllPlugin()
    @State
    var estimatedHeightByNode: Float64 = 0.0
    @State
    var actualHeight: Float64 = 0.0
    @State
    var precomputeWidthUsed: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        let markdownTheme:MarkdownTheme = MarkdownTheme()
        markdownConfiguration.setMarkdownTheme(markdownTheme)
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
        isInputEnded = isFull
        // 世代计数：无论哪种模式都使进行中的流式循环失效，防止旧文件内容继续追加
        loadGeneration += 1
        if (isFull) {
            mdStr = fullContent
            let pw = getMarkdownComponentWidth(paddingH: 5.0)
            precomputeWidthUsed = pw
            estimatedHeightByNode = preMarkwonHeightByNode(fullContent, markdownConfiguration, markdownHeightPlugin, componentWidth: pw)
        } else {
            mdStr = ""
            let number = textNumber
            let time = timeMs
            let total = arr.size
            let generation = loadGeneration
            spawn {
                for (i in 0..total : number) {
                    if (generation != loadGeneration) {
                        break // 文件已切换，终止旧的流式追加
                    }
                    sleep(Duration.millisecond * time)
                    launch {
                        if (generation != loadGeneration) {
                            return // 文件已切换，丢弃过期的追加任务
                        }
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
//        let theme = markdownConfiguration.getMarkdownTheme()
//        let globalTheme = theme.getGlobalTheme()
//        globalTheme.blockMarginTop = parseFloat64(cfg_blockMarginTop)
//        globalTheme.blockMarginRight = parseFloat64(cfg_blockMarginRight)
//        globalTheme.blockMarginBottom = parseFloat64(cfg_blockMarginBottom)
//        globalTheme.blockMarginLeft = parseFloat64(cfg_blockMarginLeft)
//        globalTheme.markdownBlockSpacing = parseInt64(cfg_markdownBlockSpacing)
//        globalTheme.isLineBreak = parseBool(cfg_isLineBreak)
//        globalTheme.isOnCopy = parseBool(cfg_isOnCopy)
//        globalTheme.isMarkdownParserSync = parseBool(cfg_isMarkdownParserSync)
//        globalTheme.openGestureSwipe = parseBool(cfg_openGestureSwipe)
//        globalTheme.enableParseThrottle = parseBool(cfg_enableParseThrottle)
//        globalTheme.parseThrottleMs = parseInt64(cfg_parseThrottleMs)
//        if (cfg_backgroundColor != "undefined") {
//            globalTheme.backgroundColor = parseColor(cfg_backgroundColor)
//        }
//
//        let definitionListTheme = theme.getDefinitionListTheme()
//        if (cfg_definitionListBackgroundColor != "undefined") {
//            definitionListTheme.setDefinitionListBackgroundColor(parseColor(cfg_definitionListBackgroundColor))
//        }
//        definitionListTheme.setDefinitionListTermToDescriptionSpacing(parseFloat64(cfg_definitionListTermToDescriptionSpacing))
//        definitionListTheme.setDefinitionListTermTextFontWeight(parseFontWeight(cfg_definitionListTermTextFontWeight))
//        definitionListTheme.setDefinitionListTermTextFontStyle(parseFontStyle(cfg_definitionListTermTextFontStyle))
//        definitionListTheme.setDefinitionListDescriptionItemSpacing(parseFloat64(cfg_definitionListDescriptionItemSpacing))
//        definitionListTheme.setDefinitionListDescriptionIndent(parseFloat64(cfg_definitionListDescriptionIndent))
//        definitionListTheme.setDefinitionListPadding(top: parseFloat64(cfg_definitionListPaddingTop), right: parseFloat64(cfg_definitionListPaddingRight), bottom: parseFloat64(cfg_definitionListPaddingBottom), left: parseFloat64(cfg_definitionListPaddingLeft))
//        definitionListTheme.setDefinitionListMargin(top: parseFloat64(cfg_definitionListMarginTop), right: parseFloat64(cfg_definitionListMarginRight), bottom: parseFloat64(cfg_definitionListMarginBottom), left: parseFloat64(cfg_definitionListMarginLeft))
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
            Text("预览: " + selectedFileName)
                .fontSize(14.0)
                .fontColor(0xFF333333)
                .margin(top: 10.0, left: 5.0)
            Text("preMarkwonHeightByNode 估算: " + estimatedHeightByNode.toString() + " vp")
                .fontSize(12.0)
                .fontColor(0xFF666666)
                .margin(top: 3.0, left: 5.0)
            Text("MarkdownComponent 实际: " + actualHeight.toString() + " vp")
                .fontSize(12.0)
                .fontColor(0xFF666666)
                .margin(top: 3.0, left: 5.0)

            Scroll {
                if (mdStr != "") {
                    Column {
                        MarkdownComponent(
                            output: mdStr,
                            isInputEnded: isInputEnded,
                            incrementalAnalysis: incrementalAnalysis,
                            scroller: scroller,
                            markdownConfiguration: markdownConfiguration,
                            markdownPlugin: markdownPlugin
                        )
                    }
                    .onAreaChange({ old, new =>
                        actualHeight = new.height - 10.0
                        let actualContentWidth = new.width - 10.0
                        if (estimatedHeightByNode > 0.0 && actualContentWidth > 0.0) {
                            let diff = actualContentWidth - precomputeWidthUsed
                            if (diff > 0.5 || diff < -0.5) {
                                estimatedHeightByNode = preMarkwonHeightByNode(mdStr, markdownConfiguration, markdownHeightPlugin, componentWidth: actualContentWidth)
                                precomputeWidthUsed = actualContentWidth
                            }
                        }
                    })
                    .width(100.percent)
                    .padding(5.0)
                    .backgroundColor(0xFFFFFFFF)
                    .justifyContent(FlexAlign.Start)
                }
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
