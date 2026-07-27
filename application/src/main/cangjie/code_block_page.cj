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
class CodeBlockPage {
    @State
    var fileListStr: String = getGlobalString("fileList")
    @State
    var isExpanded1: Bool = false
    @State
    var isExpanded2: Bool = false
    @State
    var isExpanded3: Bool = false
    @State
    var isExpanded4: Bool = false
    @State
    var isExpanded5: Bool = false
    @State
    var isExpanded6: Bool = false
    @State
    var isExpanded7: Bool = false
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
    @State @Watch[onConfigChanged] var cfg_codeBlockIsDark: String = "false"
    @State @Watch[onConfigChanged] var cfg_codeBlockBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockBorderColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockBorderWidth: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockCopyButtonIsShow: String = "true"
    @State @Watch[onConfigChanged] var cfg_codeBlockFullScreenButtonIsShow: String = "true"
    @State @Watch[onConfigChanged] var cfg_codeBlockLineNumberIsShow: String = "true"
    @State @Watch[onConfigChanged] var cfg_codeBlockTextFontSize: String = "undefined"

    @State @Watch[onConfigChanged] var cfg_codeBlockMarginTop: String = "0"
    @State @Watch[onConfigChanged] var cfg_codeBlockMarginRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_codeBlockMarginBottom: String = "0"
    @State @Watch[onConfigChanged] var cfg_codeBlockMarginLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_codeBlockPaddingTop: String = "0"
    @State @Watch[onConfigChanged] var cfg_codeBlockPaddingRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_codeBlockPaddingBottom: String = "0"
    @State @Watch[onConfigChanged] var cfg_codeBlockPaddingLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_codeBlockRadiusTopLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_codeBlockRadiusTopRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_codeBlockRadiusBottomLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_codeBlockRadiusBottomRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_codeBlockBorderStyle: String = "Solid"
    @State @Watch[onConfigChanged] var cfg_codeBlockTitleLayoutMarginBottom: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockTypeTextMarginLeft: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockTypeText: String = ""
    @State @Watch[onConfigChanged] var cfg_codeBlockTypeTextFontColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockTypeTextFontSize: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockTypeTextFontStyle: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockTypeTextFontWeight: String = "Normal"
    @State @Watch[onConfigChanged] var cfg_codeBlockTypeTextFontFamily: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockTypeTextLineHeight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockCopyFullScreenSpacing: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockCopyTextIsShow: String = "true"
    @State @Watch[onConfigChanged] var cfg_codeBlockCopyIcon: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockCopyIconWidth: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockCopyIconHeight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockCopyIconTextSpacing: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockCopyText: String = "复制代码"
    @State @Watch[onConfigChanged] var cfg_codeBlockCopyTextFontColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockCopyTextFontSize: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockCopyTextFontStyle: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockCopyTextFontWeight: String = "Normal"
    @State @Watch[onConfigChanged] var cfg_codeBlockCopyTextFontFamily: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockCopyTextLineHeight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockFullScreenTextIsShow: String = "true"
    @State @Watch[onConfigChanged] var cfg_codeBlockFullScreenIcon: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockFullScreenIconWidth: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockFullScreenIconHeight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockFullScreenIconTextSpacing: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockFullScreenText: String = "全屏代码"
    @State @Watch[onConfigChanged] var cfg_codeBlockFullScreenTextFontColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockFullScreenTextFontSize: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockFullScreenTextFontStyle: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockFullScreenTextFontWeight: String = "Normal"
    @State @Watch[onConfigChanged] var cfg_codeBlockFullScreenTextFontFamily: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockFullScreenTextLineHeight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockLineNumberTextPaddingLeft: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockLineNumberTextFontColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockLineNumberTextFontSize: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockLineNumberTextFontStyle: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockLineNumberTextFontWeight: String = "Normal"
    @State @Watch[onConfigChanged] var cfg_codeBlockLineNumberTextFontFamily: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockLineNumberTextLineHeight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockDividerColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockDividerStrokeWidth: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockLineNumberDividerSpacing: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockIsCodeFormat: String = "false"
    @State @Watch[onConfigChanged] var cfg_codeBlockUseTab: String = "false"
    @State @Watch[onConfigChanged] var cfg_codeBlockIndentWidth: String = "4"
    @State @Watch[onConfigChanged] var cfg_codeBlockParserSync: String = "false"
    @State @Watch[onConfigChanged] var cfg_codeBlockTextFontColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockTextFontStyle: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockTextFontFamily: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockTextLineHeight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockTextLetterSpacing: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockTextMarginRight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockTextMarginLeft: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_codeBlockTextFontWeight: String = "Normal"
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
            estimatedHeightByNode = preMarkwonHeightByNode(fullContent, markdownConfiguration, markdownPlugin, componentWidth: getMarkdownComponentWidth(paddingH: 5.0))
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

        let codeBlockTheme = theme.getCodeBlockTheme()
        codeBlockTheme.setCodeBlockIsDark(parseBool(cfg_codeBlockIsDark))
        if (cfg_codeBlockBackgroundColor != "undefined") {
            codeBlockTheme.setCodeBlockBackgroundColor(parseColor(cfg_codeBlockBackgroundColor))
        }
        if (cfg_codeBlockBorderColor != "undefined") {
            codeBlockTheme.setCodeBlockBorderColor(parseColor(cfg_codeBlockBorderColor))
        }
        if (cfg_codeBlockBorderWidth != "undefined") {
            codeBlockTheme.setCodeBlockBorderWidth(parseFloat64(cfg_codeBlockBorderWidth))
        }
        codeBlockTheme.setCodeBlockCopyButtonIsShow(parseBool(cfg_codeBlockCopyButtonIsShow))
        codeBlockTheme.setCodeBlockFullScreenButtonIsShow(parseBool(cfg_codeBlockFullScreenButtonIsShow))
        codeBlockTheme.setCodeBlockLineNumberIsShow(parseBool(cfg_codeBlockLineNumberIsShow))
        if (cfg_codeBlockTextFontSize != "undefined") {
            codeBlockTheme.setCodeBlockTextFontSize(parseFloat64(cfg_codeBlockTextFontSize))
        }
        codeBlockTheme.setCodeBlockBorderStyle(parseBorderStyle(cfg_codeBlockBorderStyle))
        if (cfg_codeBlockTitleLayoutMarginBottom != "undefined") {
            codeBlockTheme.setCodeBlockTitleLayoutMarginBottom(parseFloat64(cfg_codeBlockTitleLayoutMarginBottom))
        }
        if (cfg_codeBlockTypeTextMarginLeft != "undefined") {
            codeBlockTheme.setCodeBlockTypeTextMarginLeft(parseFloat64(cfg_codeBlockTypeTextMarginLeft))
        }
        codeBlockTheme.setCodeBlockTypeText(cfg_codeBlockTypeText)
        if (cfg_codeBlockTypeTextFontColor != "undefined") {
            codeBlockTheme.setCodeBlockTypeTextFontColor(parseColor(cfg_codeBlockTypeTextFontColor))
        }
        if (cfg_codeBlockTypeTextFontSize != "undefined") {
            codeBlockTheme.setCodeBlockTypeTextFontSize(parseFloat64(cfg_codeBlockTypeTextFontSize))
        }
        if (cfg_codeBlockTypeTextFontStyle != "undefined") {
            codeBlockTheme.setCodeBlockTypeTextFontStyle(parseFontStyle(cfg_codeBlockTypeTextFontStyle))
        }
        codeBlockTheme.setCodeBlockTypeTextFontWeight(parseFontWeight(cfg_codeBlockTypeTextFontWeight))
        if (cfg_codeBlockTypeTextFontFamily != "undefined") {
            codeBlockTheme.setCodeBlockTypeTextFontFamily(cfg_codeBlockTypeTextFontFamily)
        }
        if (cfg_codeBlockTypeTextLineHeight != "undefined") {
            codeBlockTheme.setCodeBlockTypeTextLineHeight(parseFloat64(cfg_codeBlockTypeTextLineHeight))
        }
        if (cfg_codeBlockCopyFullScreenSpacing != "undefined") {
            codeBlockTheme.setCodeBlockCopyFullScreenSpacing(parseFloat64(cfg_codeBlockCopyFullScreenSpacing))
        }
        codeBlockTheme.setCodeBlockCopyTextIsShow(parseBool(cfg_codeBlockCopyTextIsShow))
        if (let Some(v) <- parseAppResource(cfg_codeBlockCopyIcon)) {
            codeBlockTheme.setCodeBlockCopyIcon(v)
        }
        if (cfg_codeBlockCopyIconWidth != "undefined") {
            codeBlockTheme.setCodeBlockCopyIconWidth(parseFloat64(cfg_codeBlockCopyIconWidth))
        }
        if (cfg_codeBlockCopyIconHeight != "undefined") {
            codeBlockTheme.setCodeBlockCopyIconHeight(parseFloat64(cfg_codeBlockCopyIconHeight))
        }
        if (cfg_codeBlockCopyIconTextSpacing != "undefined") {
            codeBlockTheme.setCodeBlockCopyIconTextSpacing(parseFloat64(cfg_codeBlockCopyIconTextSpacing))
        }
        codeBlockTheme.setCodeBlockCopyText(cfg_codeBlockCopyText)
        if (cfg_codeBlockCopyTextFontColor != "undefined") {
            codeBlockTheme.setCodeBlockCopyTextFontColor(parseColor(cfg_codeBlockCopyTextFontColor))
        }
        if (cfg_codeBlockCopyTextFontSize != "undefined") {
            codeBlockTheme.setCodeBlockCopyTextFontSize(parseFloat64(cfg_codeBlockCopyTextFontSize))
        }
        if (cfg_codeBlockCopyTextFontStyle != "undefined") {
            codeBlockTheme.setCodeBlockCopyTextFontStyle(parseFontStyle(cfg_codeBlockCopyTextFontStyle))
        }
        codeBlockTheme.setCodeBlockCopyTextFontWeight(parseFontWeight(cfg_codeBlockCopyTextFontWeight))
        if (cfg_codeBlockCopyTextFontFamily != "undefined") {
            codeBlockTheme.setCodeBlockCopyTextFontFamily(cfg_codeBlockCopyTextFontFamily)
        }
        if (cfg_codeBlockCopyTextLineHeight != "undefined") {
            codeBlockTheme.setCodeBlockCopyTextLineHeight(parseFloat64(cfg_codeBlockCopyTextLineHeight))
        }
        codeBlockTheme.setCodeBlockFullScreenTextIsShow(parseBool(cfg_codeBlockFullScreenTextIsShow))
        if (let Some(v) <- parseAppResource(cfg_codeBlockFullScreenIcon)) {
            codeBlockTheme.setCodeBlockFullScreenIcon(v)
        }
        if (cfg_codeBlockFullScreenIconWidth != "undefined") {
            codeBlockTheme.setCodeBlockFullScreenIconWidth(parseFloat64(cfg_codeBlockFullScreenIconWidth))
        }
        if (cfg_codeBlockFullScreenIconHeight != "undefined") {
            codeBlockTheme.setCodeBlockFullScreenIconHeight(parseFloat64(cfg_codeBlockFullScreenIconHeight))
        }
        if (cfg_codeBlockFullScreenIconTextSpacing != "undefined") {
            codeBlockTheme.setCodeBlockFullScreenIconTextSpacing(parseFloat64(cfg_codeBlockFullScreenIconTextSpacing))
        }
        codeBlockTheme.setCodeBlockFullScreenText(cfg_codeBlockFullScreenText)
        if (cfg_codeBlockFullScreenTextFontColor != "undefined") {
            codeBlockTheme.setCodeBlockFullScreenTextFontColor(parseColor(cfg_codeBlockFullScreenTextFontColor))
        }
        if (cfg_codeBlockFullScreenTextFontSize != "undefined") {
            codeBlockTheme.setCodeBlockFullScreenTextFontSize(parseFloat64(cfg_codeBlockFullScreenTextFontSize))
        }
        if (cfg_codeBlockFullScreenTextFontStyle != "undefined") {
            codeBlockTheme.setCodeBlockFullScreenTextFontStyle(parseFontStyle(cfg_codeBlockFullScreenTextFontStyle))
        }
        codeBlockTheme.setCodeBlockFullScreenTextFontWeight(parseFontWeight(cfg_codeBlockFullScreenTextFontWeight))
        if (cfg_codeBlockFullScreenTextFontFamily != "undefined") {
            codeBlockTheme.setCodeBlockFullScreenTextFontFamily(cfg_codeBlockFullScreenTextFontFamily)
        }
        if (cfg_codeBlockFullScreenTextLineHeight != "undefined") {
            codeBlockTheme.setCodeBlockFullScreenTextLineHeight(parseFloat64(cfg_codeBlockFullScreenTextLineHeight))
        }
        if (cfg_codeBlockLineNumberTextPaddingLeft != "undefined") {
            codeBlockTheme.setCodeBlockLineNumberTextPaddingLeft(parseFloat64(cfg_codeBlockLineNumberTextPaddingLeft))
        }
        if (cfg_codeBlockLineNumberTextFontColor != "undefined") {
            codeBlockTheme.setCodeBlockLineNumberTextFontColor(parseColor(cfg_codeBlockLineNumberTextFontColor))
        }
        if (cfg_codeBlockLineNumberTextFontSize != "undefined") {
            codeBlockTheme.setCodeBlockLineNumberTextFontSize(parseFloat64(cfg_codeBlockLineNumberTextFontSize))
        }
        if (cfg_codeBlockLineNumberTextFontStyle != "undefined") {
            codeBlockTheme.setCodeBlockLineNumberTextFontStyle(parseFontStyle(cfg_codeBlockLineNumberTextFontStyle))
        }
        codeBlockTheme.setCodeBlockLineNumberTextFontWeight(parseFontWeight(cfg_codeBlockLineNumberTextFontWeight))
        if (cfg_codeBlockLineNumberTextFontFamily != "undefined") {
            codeBlockTheme.setCodeBlockLineNumberTextFontFamily(cfg_codeBlockLineNumberTextFontFamily)
        }
        if (cfg_codeBlockLineNumberTextLineHeight != "undefined") {
            codeBlockTheme.setCodeBlockLineNumberTextLineHeight(parseFloat64(cfg_codeBlockLineNumberTextLineHeight))
        }
        if (cfg_codeBlockDividerColor != "undefined") {
            codeBlockTheme.setCodeBlockDividerColor(parseColor(cfg_codeBlockDividerColor))
        }
        if (cfg_codeBlockDividerStrokeWidth != "undefined") {
            codeBlockTheme.setCodeBlockDividerStrokeWidth(parseFloat64(cfg_codeBlockDividerStrokeWidth))
        }
        if (cfg_codeBlockLineNumberDividerSpacing != "undefined") {
            codeBlockTheme.setCodeBlockLineNumberDividerSpacing(parseFloat64(cfg_codeBlockLineNumberDividerSpacing))
        }
        codeBlockTheme.setCodeBlockIsCodeFormat(parseBool(cfg_codeBlockIsCodeFormat))
        codeBlockTheme.setCodeBlockUseTab(parseBool(cfg_codeBlockUseTab))
        codeBlockTheme.setCodeBlockIndentWidth(parseInt64(cfg_codeBlockIndentWidth))
        codeBlockTheme.setCodeBlockParserSync(parseBool(cfg_codeBlockParserSync))
        if (cfg_codeBlockTextFontColor != "undefined") {
            codeBlockTheme.setCodeBlockTextFontColor(parseColor(cfg_codeBlockTextFontColor))
        }
        if (cfg_codeBlockTextFontStyle != "undefined") {
            codeBlockTheme.setCodeBlockTextFontStyle(parseFontStyle(cfg_codeBlockTextFontStyle))
        }
        if (cfg_codeBlockTextFontFamily != "undefined") {
            codeBlockTheme.setCodeBlockTextFontFamily(cfg_codeBlockTextFontFamily)
        }
        if (cfg_codeBlockTextLineHeight != "undefined") {
            codeBlockTheme.setCodeBlockTextLineHeight(parseFloat64(cfg_codeBlockTextLineHeight))
        }
        if (cfg_codeBlockTextLetterSpacing != "undefined") {
            codeBlockTheme.setCodeBlockTextLetterSpacing(parseFloat64(cfg_codeBlockTextLetterSpacing))
        }
        if (cfg_codeBlockTextMarginRight != "undefined") {
            codeBlockTheme.setCodeBlockTextMarginRight(parseFloat64(cfg_codeBlockTextMarginRight))
        }
        if (cfg_codeBlockTextMarginLeft != "undefined") {
            codeBlockTheme.setCodeBlockTextMarginLeft(parseFloat64(cfg_codeBlockTextMarginLeft))
        }
        codeBlockTheme.setCodeBlockMargin(top: parseFloat64(cfg_codeBlockMarginTop), right: parseFloat64(cfg_codeBlockMarginRight), bottom: parseFloat64(cfg_codeBlockMarginBottom), left: parseFloat64(cfg_codeBlockMarginLeft))
        codeBlockTheme.setCodeBlockRadius(topLeft: parseFloat64(cfg_codeBlockRadiusTopLeft), topRight: parseFloat64(cfg_codeBlockRadiusTopRight), bottomLeft: parseFloat64(cfg_codeBlockRadiusBottomLeft), bottomRight: parseFloat64(cfg_codeBlockRadiusBottomRight))
        codeBlockTheme.setCodeBlockPadding(top: parseFloat64(cfg_codeBlockPaddingTop), right: parseFloat64(cfg_codeBlockPaddingRight), bottom: parseFloat64(cfg_codeBlockPaddingBottom), left: parseFloat64(cfg_codeBlockPaddingLeft))
        codeBlockTheme.setCodeBlockTextFontWeight(parseFontWeight(cfg_codeBlockTextFontWeight))
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

                    Column {
                        Row {
                            Text("边距和边框")
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .fontWeight(FontWeight.Bold)
                                .layoutWeight(1)
                            Text(if (isExpanded2) { "▲" } else { "▼" })
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .padding(right: 20.0)
                                .onClick {
                                    evt => isExpanded2 = !isExpanded2
                                }
                        }
                        .width(100.percent)
                        .padding(5.0)
                        .margin(5.0)
                        .onClick {
                            evt => isExpanded2 = !isExpanded2
                        }

                        if (isExpanded2) {
                            Column {
                                ConfigTabSelector(title: "代码块背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockBackgroundColor, onSelect: { v => cfg_codeBlockBackgroundColor = v })
                                ConfigTabSelector(title: "代码块边框颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockBorderColor, onSelect: { v => cfg_codeBlockBorderColor = v })
                                ConfigTabSelector(title: "代码块边框宽度 - ", options: lineOrBorderWidthList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockBorderWidth, onSelect: { v => cfg_codeBlockBorderWidth = v })
                                ConfigTabSelector(title: "代码块上外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_codeBlockMarginTop, onSelect: { v => cfg_codeBlockMarginTop = v })
                                ConfigTabSelector(title: "代码块右外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_codeBlockMarginRight, onSelect: { v => cfg_codeBlockMarginRight = v })
                                ConfigTabSelector(title: "代码块下外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_codeBlockMarginBottom, onSelect: { v => cfg_codeBlockMarginBottom = v })
                                ConfigTabSelector(title: "代码块左外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_codeBlockMarginLeft, onSelect: { v => cfg_codeBlockMarginLeft = v })
                                ConfigTabSelector(title: "代码块上内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_codeBlockPaddingTop, onSelect: { v => cfg_codeBlockPaddingTop = v })
                                ConfigTabSelector(title: "代码块右内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_codeBlockPaddingRight, onSelect: { v => cfg_codeBlockPaddingRight = v })
                                ConfigTabSelector(title: "代码块下内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_codeBlockPaddingBottom, onSelect: { v => cfg_codeBlockPaddingBottom = v })
                                ConfigTabSelector(title: "代码块左内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_codeBlockPaddingLeft, onSelect: { v => cfg_codeBlockPaddingLeft = v })
                                ConfigTabSelector(title: "代码块边框左上圆角 - ", options: radiusList, defaultValue: "0", configKey: "", currentValue: cfg_codeBlockRadiusTopLeft, onSelect: { v => cfg_codeBlockRadiusTopLeft = v })
                                ConfigTabSelector(title: "代码块边框右上圆角 - ", options: radiusList, defaultValue: "0", configKey: "", currentValue: cfg_codeBlockRadiusTopRight, onSelect: { v => cfg_codeBlockRadiusTopRight = v })
                                ConfigTabSelector(title: "代码块边框左下圆角 - ", options: radiusList, defaultValue: "0", configKey: "", currentValue: cfg_codeBlockRadiusBottomLeft, onSelect: { v => cfg_codeBlockRadiusBottomLeft = v })
                                ConfigTabSelector(title: "代码块边框右下圆角 - ", options: radiusList, defaultValue: "0", configKey: "", currentValue: cfg_codeBlockRadiusBottomRight, onSelect: { v => cfg_codeBlockRadiusBottomRight = v })
                                ConfigTabSelector(title: "代码块边框样式 - ", options: borderStyleList, defaultValue: "Solid", configKey: "", currentValue: cfg_codeBlockBorderStyle, onSelect: { v => cfg_codeBlockBorderStyle = v })
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

                    Column {
                        Row {
                            Text("类型文本")
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .fontWeight(FontWeight.Bold)
                                .layoutWeight(1)
                            Text(if (isExpanded3) { "▲" } else { "▼" })
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .padding(right: 20.0)
                                .onClick {
                                    evt => isExpanded3 = !isExpanded3
                                }
                        }
                        .width(100.percent)
                        .padding(5.0)
                        .margin(5.0)
                        .onClick {
                            evt => isExpanded3 = !isExpanded3
                        }

                        if (isExpanded3) {
                            Column {
                                ConfigTabSelector(title: "代码块类型和代码块内容间距 - ", options: marginList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTitleLayoutMarginBottom, onSelect: { v => cfg_codeBlockTitleLayoutMarginBottom = v })
                                ConfigTabSelector(title: "代码块类型左边距 - ", options: marginList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTypeTextMarginLeft, onSelect: { v => cfg_codeBlockTypeTextMarginLeft = v })
                                ConfigTabSelector(title: "代码块没有代码类型时默认显示文本 - ", options: codeBlockTypeTextList, defaultValue: "", configKey: "", currentValue: cfg_codeBlockTypeText, onSelect: { v => cfg_codeBlockTypeText = v })
                                ConfigTabSelector(title: "代码块类型文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTypeTextFontColor, onSelect: { v => cfg_codeBlockTypeTextFontColor = v })
                                ConfigTabSelector(title: "代码块类型文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTypeTextFontSize, onSelect: { v => cfg_codeBlockTypeTextFontSize = v })
                                ConfigTabSelector(title: "代码块类型文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTypeTextFontStyle, onSelect: { v => cfg_codeBlockTypeTextFontStyle = v })
                                ConfigTabSelector(title: "代码块类型文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_codeBlockTypeTextFontWeight, onSelect: { v => cfg_codeBlockTypeTextFontWeight = v })
                                ConfigTabSelector(title: "代码块类型文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTypeTextFontFamily, onSelect: { v => cfg_codeBlockTypeTextFontFamily = v })
                                ConfigTabSelector(title: "代码块类型文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTypeTextLineHeight, onSelect: { v => cfg_codeBlockTypeTextLineHeight = v })
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

                    Column {
                        Row {
                            Text("复制相关")
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .fontWeight(FontWeight.Bold)
                                .layoutWeight(1)
                            Text(if (isExpanded4) { "▲" } else { "▼" })
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .padding(right: 20.0)
                                .onClick {
                                    evt => isExpanded4 = !isExpanded4
                                }
                        }
                        .width(100.percent)
                        .padding(5.0)
                        .margin(5.0)
                        .onClick {
                            evt => isExpanded4 = !isExpanded4
                        }

                        if (isExpanded4) {
                            Column {
                                ConfigTabSelector(title: "代码块复制按钮可见 - ", options: booleanList, defaultValue: "true", configKey: "", currentValue: cfg_codeBlockCopyButtonIsShow, onSelect: { v => cfg_codeBlockCopyButtonIsShow = v })
                                ConfigTabSelector(title: "代码块代码复制和代码全屏间距 - ", options: spaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockCopyFullScreenSpacing, onSelect: { v => cfg_codeBlockCopyFullScreenSpacing = v })
                                ConfigTabSelector(title: "代码块代码复制文本是否显示 - ", options: booleanList, defaultValue: "true", configKey: "", currentValue: cfg_codeBlockCopyTextIsShow, onSelect: { v => cfg_codeBlockCopyTextIsShow = v })
                                ConfigTabSelector(title: "代码块代码复制按钮默认图标 - ", options: iconShortList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockCopyIcon, onSelect: { v => cfg_codeBlockCopyIcon = v })
                                ConfigTabSelector(title: "代码块代码复制图标宽度 - ", options: widthOrHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockCopyIconWidth, onSelect: { v => cfg_codeBlockCopyIconWidth = v })
                                ConfigTabSelector(title: "代码块代码复制图标高度 - ", options: widthOrHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockCopyIconHeight, onSelect: { v => cfg_codeBlockCopyIconHeight = v })
                                ConfigTabSelector(title: "代码块代码复制图标和文本间距 - ", options: spaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockCopyIconTextSpacing, onSelect: { v => cfg_codeBlockCopyIconTextSpacing = v })
                                ConfigTabSelector(title: "代码块代码复制默认文本内容 - ", options: codeBlockCopyTextList, defaultValue: "复制代码", configKey: "", currentValue: cfg_codeBlockCopyText, onSelect: { v => cfg_codeBlockCopyText = v })
                                ConfigTabSelector(title: "代码块代码复制文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockCopyTextFontColor, onSelect: { v => cfg_codeBlockCopyTextFontColor = v })
                                ConfigTabSelector(title: "代码块代码复制文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockCopyTextFontSize, onSelect: { v => cfg_codeBlockCopyTextFontSize = v })
                                ConfigTabSelector(title: "代码块代码复制文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockCopyTextFontStyle, onSelect: { v => cfg_codeBlockCopyTextFontStyle = v })
                                ConfigTabSelector(title: "代码块代码复制文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_codeBlockCopyTextFontWeight, onSelect: { v => cfg_codeBlockCopyTextFontWeight = v })
                                ConfigTabSelector(title: "代码块代码复制文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockCopyTextFontFamily, onSelect: { v => cfg_codeBlockCopyTextFontFamily = v })
                                ConfigTabSelector(title: "代码块代码复制文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockCopyTextLineHeight, onSelect: { v => cfg_codeBlockCopyTextLineHeight = v })
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

                    Column {
                        Row {
                            Text("全屏相关")
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .fontWeight(FontWeight.Bold)
                                .layoutWeight(1)
                            Text(if (isExpanded5) { "▲" } else { "▼" })
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .padding(right: 20.0)
                                .onClick {
                                    evt => isExpanded5 = !isExpanded5
                                }
                        }
                        .width(100.percent)
                        .padding(5.0)
                        .margin(5.0)
                        .onClick {
                            evt => isExpanded5 = !isExpanded5
                        }

                        if (isExpanded5) {
                            Column {
                                ConfigTabSelector(title: "代码块全屏按钮可见 - ", options: booleanList, defaultValue: "true", configKey: "", currentValue: cfg_codeBlockFullScreenButtonIsShow, onSelect: { v => cfg_codeBlockFullScreenButtonIsShow = v })
                                ConfigTabSelector(title: "代码块代码全屏文本是否显示 - ", options: booleanList, defaultValue: "true", configKey: "", currentValue: cfg_codeBlockFullScreenTextIsShow, onSelect: { v => cfg_codeBlockFullScreenTextIsShow = v })
                                ConfigTabSelector(title: "代码块代码全屏按钮默认图标 - ", options: iconShortList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockFullScreenIcon, onSelect: { v => cfg_codeBlockFullScreenIcon = v })
                                ConfigTabSelector(title: "代码块代码全屏图标宽度 - ", options: widthOrHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockFullScreenIconWidth, onSelect: { v => cfg_codeBlockFullScreenIconWidth = v })
                                ConfigTabSelector(title: "代码块代码全屏图标高度 - ", options: widthOrHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockFullScreenIconHeight, onSelect: { v => cfg_codeBlockFullScreenIconHeight = v })
                                ConfigTabSelector(title: "代码块代码全屏图标和文本间距 - ", options: spaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockFullScreenIconTextSpacing, onSelect: { v => cfg_codeBlockFullScreenIconTextSpacing = v })
                                ConfigTabSelector(title: "代码块代码全屏默认文本内容 - ", options: codeBlockFullScreenTextList, defaultValue: "全屏代码", configKey: "", currentValue: cfg_codeBlockFullScreenText, onSelect: { v => cfg_codeBlockFullScreenText = v })
                                ConfigTabSelector(title: "代码块代码全屏文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockFullScreenTextFontColor, onSelect: { v => cfg_codeBlockFullScreenTextFontColor = v })
                                ConfigTabSelector(title: "代码块代码全屏文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockFullScreenTextFontSize, onSelect: { v => cfg_codeBlockFullScreenTextFontSize = v })
                                ConfigTabSelector(title: "代码块代码全屏文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockFullScreenTextFontStyle, onSelect: { v => cfg_codeBlockFullScreenTextFontStyle = v })
                                ConfigTabSelector(title: "代码块代码全屏文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_codeBlockFullScreenTextFontWeight, onSelect: { v => cfg_codeBlockFullScreenTextFontWeight = v })
                                ConfigTabSelector(title: "代码块代码全屏文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockFullScreenTextFontFamily, onSelect: { v => cfg_codeBlockFullScreenTextFontFamily = v })
                                ConfigTabSelector(title: "代码块代码全屏文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockFullScreenTextLineHeight, onSelect: { v => cfg_codeBlockFullScreenTextLineHeight = v })
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

                    Column {
                        Row {
                            Text("代码块行号")
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .fontWeight(FontWeight.Bold)
                                .layoutWeight(1)
                            Text(if (isExpanded6) { "▲" } else { "▼" })
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .padding(right: 20.0)
                                .onClick {
                                    evt => isExpanded6 = !isExpanded6
                                }
                        }
                        .width(100.percent)
                        .padding(5.0)
                        .margin(5.0)
                        .onClick {
                            evt => isExpanded6 = !isExpanded6
                        }

                        if (isExpanded6) {
                            Column {
                                ConfigTabSelector(title: "代码块行号可见 - ", options: booleanList, defaultValue: "true", configKey: "", currentValue: cfg_codeBlockLineNumberIsShow, onSelect: { v => cfg_codeBlockLineNumberIsShow = v })
                                ConfigTabSelector(title: "代码块代码行号左内边距 - ", options: spaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockLineNumberTextPaddingLeft, onSelect: { v => cfg_codeBlockLineNumberTextPaddingLeft = v })
                                ConfigTabSelector(title: "代码块代码行号文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockLineNumberTextFontColor, onSelect: { v => cfg_codeBlockLineNumberTextFontColor = v })
                                ConfigTabSelector(title: "代码块代码行号文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockLineNumberTextFontSize, onSelect: { v => cfg_codeBlockLineNumberTextFontSize = v })
                                ConfigTabSelector(title: "代码块代码行号文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockLineNumberTextFontStyle, onSelect: { v => cfg_codeBlockLineNumberTextFontStyle = v })
                                ConfigTabSelector(title: "代码块代码行号文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_codeBlockLineNumberTextFontWeight, onSelect: { v => cfg_codeBlockLineNumberTextFontWeight = v })
                                ConfigTabSelector(title: "代码块代码行号文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockLineNumberTextFontFamily, onSelect: { v => cfg_codeBlockLineNumberTextFontFamily = v })
                                ConfigTabSelector(title: "代码块代码行号文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockLineNumberTextLineHeight, onSelect: { v => cfg_codeBlockLineNumberTextLineHeight = v })
                                ConfigTabSelector(title: "代码块代码行号和代码块中间分割线颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockDividerColor, onSelect: { v => cfg_codeBlockDividerColor = v })
                                ConfigTabSelector(title: "代码块代码行号和代码块中间分割线宽度 - ", options: lineOrBorderWidthList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockDividerStrokeWidth, onSelect: { v => cfg_codeBlockDividerStrokeWidth = v })
                                ConfigTabSelector(title: "代码块代码行号和分割线间距 - ", options: spaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockLineNumberDividerSpacing, onSelect: { v => cfg_codeBlockLineNumberDividerSpacing = v })
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

                    Column {
                        Row {
                            Text("代码块文本")
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .fontWeight(FontWeight.Bold)
                                .layoutWeight(1)
                            Text(if (isExpanded7) { "▲" } else { "▼" })
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .padding(right: 20.0)
                                .onClick {
                                    evt => isExpanded7 = !isExpanded7
                                }
                        }
                        .width(100.percent)
                        .padding(5.0)
                        .margin(5.0)
                        .onClick {
                            evt => isExpanded7 = !isExpanded7
                        }

                        if (isExpanded7) {
                            Column {
                                ConfigTabSelector(title: "代码块暗色主题 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_codeBlockIsDark, onSelect: { v => cfg_codeBlockIsDark = v })
                                ConfigTabSelector(title: "代码块文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTextFontSize, onSelect: { v => cfg_codeBlockTextFontSize = v })
                                ConfigTabSelector(title: "是否格式化围栏代码块内容 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_codeBlockIsCodeFormat, onSelect: { v => cfg_codeBlockIsCodeFormat = v })
                                ConfigTabSelector(title: "codeformat是否用制表符 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_codeBlockUseTab, onSelect: { v => cfg_codeBlockUseTab = v })
                                ConfigTabSelector(title: "codeformat空格缩进数量 - ", options: codeBlockIndentWidthList, defaultValue: "4", configKey: "", currentValue: cfg_codeBlockIndentWidth, onSelect: { v => cfg_codeBlockIndentWidth = v })
                                ConfigTabSelector(title: "围栏代码块代码高亮是否同步解析 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_codeBlockParserSync, onSelect: { v => cfg_codeBlockParserSync = v })
                                ConfigTabSelector(title: "代码块文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTextFontColor, onSelect: { v => cfg_codeBlockTextFontColor = v })
                                ConfigTabSelector(title: "代码块文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTextFontStyle, onSelect: { v => cfg_codeBlockTextFontStyle = v })
                                ConfigTabSelector(title: "代码块文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTextFontFamily, onSelect: { v => cfg_codeBlockTextFontFamily = v })
                                ConfigTabSelector(title: "代码块文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTextLineHeight, onSelect: { v => cfg_codeBlockTextLineHeight = v })
                                ConfigTabSelector(title: "代码块文本字符间距 - ", options: textWordSpaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTextLetterSpacing, onSelect: { v => cfg_codeBlockTextLetterSpacing = v })
                                ConfigTabSelector(title: "代码块代码文本右外边距 - ", options: marginList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTextMarginRight, onSelect: { v => cfg_codeBlockTextMarginRight = v })
                                ConfigTabSelector(title: "代码块代码文本左外边距 - ", options: marginList, defaultValue: "undefined", configKey: "", currentValue: cfg_codeBlockTextMarginLeft, onSelect: { v => cfg_codeBlockTextMarginLeft = v })
                                ConfigTabSelector(title: "代码块文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_codeBlockTextFontWeight, onSelect: { v => cfg_codeBlockTextFontWeight = v })
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