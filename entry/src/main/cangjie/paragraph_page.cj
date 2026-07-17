package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.hybrid_base.*
import markdown.components.*
import markdown.components.theme.*
import ohos.concurrency.launch

@HybridComponentEntry
@Component
class ParagraphPage {
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
    @State var cfg_enableParseThrottle: String = "false"
    @State var cfg_parseThrottleMs: String = "200"
    @State var cfg_time: String = "50"
    @State var cfg_textNumber: String = "10"
    @State var cfg_isMarkdownParserSync: String = "false"
    @State var cfg_isOnCopy: String = "false"
    @State var cfg_blockMarginTop: String = "0"
    @State var cfg_blockMarginRight: String = "0"
    @State var cfg_blockMarginBottom: String = "0"
    @State var cfg_blockMarginLeft: String = "0"
    @State var cfg_markdownBlockSpacing: String = "8"
    @State var cfg_isLineBreak: String = "false"
    @State var cfg_backgroundColor: String = "undefined"
    @State var cfg_openGestureSwipeTest: String = "false"
    @State var cfg_openGestureSwipe: String = "false"
    @State var cfg_paragraphTextFontColor: String = "undefined"
    @State var cfg_paragraphTextFontSize: String = "undefined"
    @State var cfg_paragraphTextFontStyle: String = "Normal"
    @State var cfg_paragraphTextFontWeight: String = "Normal"
    @State var cfg_paragraphTextFontFamily: String = "undefined"
    @State var cfg_paragraphTextLineHeight: String = "undefined"
    @State var cfg_paragraphTextLetterSpacing: String = "undefined"
    @State var cfg_paragraphBackgroundColor: String = "undefined"
    @State var cfg_paragraphMarginTop: String = "0"
    @State var cfg_paragraphMarginRight: String = "0"
    @State var cfg_paragraphMarginBottom: String = "0"
    @State var cfg_paragraphMarginLeft: String = "0"
    @State var cfg_paragraphPaddingTop: String = "0"
    @State var cfg_paragraphPaddingRight: String = "0"
    @State var cfg_paragraphPaddingBottom: String = "0"
    @State var cfg_paragraphPaddingLeft: String = "0"
    @State var cfg_showHighlight: String = "true"
    @State var cfg_beforeSelectedParagraphBackgroundColor: String = "undefined"
    @State var cfg_selectedParagraphBackgroundColor: String = "undefined"
    @State var cfg_paragraphAnimationEnabled: String = "false"
    @State var cfg_paragraphAnimationDuration: String = "0"
    var arr: Array<Rune> = Array<Rune>()
    var scroller: Scroller = Scroller()

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

    func buildConfig(): MarkdownConfiguration {
        let themeBuilder = MarkdownTheme.createDefault()
        let globalTheme = GlobalTheme()
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
        themeBuilder.setGlobalTheme(globalTheme)

        let paragraphTheme = ParagraphTheme()
        if (cfg_paragraphTextFontColor != "undefined") {
            paragraphTheme.setParagraphTextFontColor(parseColor(cfg_paragraphTextFontColor))
        }
        if (cfg_paragraphTextFontSize != "undefined") {
            paragraphTheme.setParagraphTextFontSize(parseFloat64(cfg_paragraphTextFontSize))
        }
        paragraphTheme.setParagraphTextFontStyle(parseFontStyle(cfg_paragraphTextFontStyle))
        paragraphTheme.setParagraphTextFontWeight(parseFontWeight(cfg_paragraphTextFontWeight))
        if (cfg_paragraphTextFontFamily != "undefined") {
            paragraphTheme.setParagraphTextFontFamily(cfg_paragraphTextFontFamily)
        }
        if (cfg_paragraphTextLineHeight != "undefined") {
            paragraphTheme.setParagraphTextLineHeight(parseFloat64(cfg_paragraphTextLineHeight))
        }
        if (cfg_paragraphTextLetterSpacing != "undefined") {
            paragraphTheme.setParagraphTextLetterSpacing(parseFloat64(cfg_paragraphTextLetterSpacing))
        }
        if (cfg_paragraphBackgroundColor != "undefined") {
            paragraphTheme.setParagraphBackgroundColor(parseColor(cfg_paragraphBackgroundColor))
        }
        paragraphTheme.setParagraphMargin(top: parseFloat64(cfg_paragraphMarginTop), right: parseFloat64(cfg_paragraphMarginRight), bottom: parseFloat64(cfg_paragraphMarginBottom), left: parseFloat64(cfg_paragraphMarginLeft))
        paragraphTheme.setParagraphPadding(top: parseFloat64(cfg_paragraphPaddingTop), right: parseFloat64(cfg_paragraphPaddingRight), bottom: parseFloat64(cfg_paragraphPaddingBottom), left: parseFloat64(cfg_paragraphPaddingLeft))
        paragraphTheme.setParagraphAnimationEnabled(parseBool(cfg_paragraphAnimationEnabled))
        paragraphTheme.setParagraphAnimationDuration(Int32(parseInt64(cfg_paragraphAnimationDuration)))
        themeBuilder.setParagraphTheme(paragraphTheme)
        let theme = themeBuilder
        let configBuilder = MarkdownConfiguration.createEmpty()
        configBuilder.setMarkdownTheme(theme)
        return configBuilder
    }

    public func build() {
        Column {
            Text("点击文件名加载:")
                .fontSize(14.0)
                .margin(top: 5.0)

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
                            Text("专有样式配置")
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
                                ConfigTabSelector(title: "段落文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_paragraphTextFontColor, onSelect: { v => cfg_paragraphTextFontColor = v })
                                ConfigTabSelector(title: "段落文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_paragraphTextFontSize, onSelect: { v => cfg_paragraphTextFontSize = v })
                                ConfigTabSelector(title: "段落文本字体样式 - ", options: fontStyleList, defaultValue: "Normal", configKey: "", currentValue: cfg_paragraphTextFontStyle, onSelect: { v => cfg_paragraphTextFontStyle = v })
                                ConfigTabSelector(title: "段落文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_paragraphTextFontWeight, onSelect: { v => cfg_paragraphTextFontWeight = v })
                                ConfigTabSelector(title: "段落文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_paragraphTextFontFamily, onSelect: { v => cfg_paragraphTextFontFamily = v })
                                ConfigTabSelector(title: "段落文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_paragraphTextLineHeight, onSelect: { v => cfg_paragraphTextLineHeight = v })
                                ConfigTabSelector(title: "段落文本字符间距 - ", options: textWordSpaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_paragraphTextLetterSpacing, onSelect: { v => cfg_paragraphTextLetterSpacing = v })
                                ConfigTabSelector(title: "段落背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_paragraphBackgroundColor, onSelect: { v => cfg_paragraphBackgroundColor = v })
                                ConfigTabSelector(title: "段落上外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_paragraphMarginTop, onSelect: { v => cfg_paragraphMarginTop = v })
                                ConfigTabSelector(title: "段落右外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_paragraphMarginRight, onSelect: { v => cfg_paragraphMarginRight = v })
                                ConfigTabSelector(title: "段落下外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_paragraphMarginBottom, onSelect: { v => cfg_paragraphMarginBottom = v })
                                ConfigTabSelector(title: "段落左外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_paragraphMarginLeft, onSelect: { v => cfg_paragraphMarginLeft = v })
                                ConfigTabSelector(title: "段落上内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_paragraphPaddingTop, onSelect: { v => cfg_paragraphPaddingTop = v })
                                ConfigTabSelector(title: "段落右内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_paragraphPaddingRight, onSelect: { v => cfg_paragraphPaddingRight = v })
                                ConfigTabSelector(title: "段落下内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_paragraphPaddingBottom, onSelect: { v => cfg_paragraphPaddingBottom = v })
                                ConfigTabSelector(title: "段落左内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_paragraphPaddingLeft, onSelect: { v => cfg_paragraphPaddingLeft = v })
                                ConfigTabSelector(title: "是否开启标题段落高亮显示 - ", options: booleanList, defaultValue: "true", configKey: "", currentValue: cfg_showHighlight, onSelect: { v => cfg_showHighlight = v })
                                ConfigTabSelector(title: "当前长按未触发弹窗时段落前的背景色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_beforeSelectedParagraphBackgroundColor, onSelect: { v => cfg_beforeSelectedParagraphBackgroundColor = v })
                                ConfigTabSelector(title: "当前长按放手后选中文字的背景色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_selectedParagraphBackgroundColor, onSelect: { v => cfg_selectedParagraphBackgroundColor = v })
                                ConfigTabSelector(title: "段落加载动画启用 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_paragraphAnimationEnabled, onSelect: { v => cfg_paragraphAnimationEnabled = v })
                                ConfigTabSelector(title: "段落加载动画时长(ms) - ", options: timeList, defaultValue: "0", configKey: "", currentValue: cfg_paragraphAnimationDuration, onSelect: { v => cfg_paragraphAnimationDuration = v })
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
                            MarkdownComponent(
                                output: mdStr,
                                isInputEnded: isInputEnded,
                                incrementalAnalysis: incrementalAnalysis,
                                scroller: scroller,
                                markdownConfiguration: buildConfig()
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