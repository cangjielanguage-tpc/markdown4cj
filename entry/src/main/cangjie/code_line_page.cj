package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.hybrid_base.*
import markdown.components.*
import markdown.components.theme.*

@HybridComponentEntry
@Component
class CodeLinePage {
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
    @State var cfg_inlineCodeTextFontColor: String = "undefined"
    @State var cfg_inlineCodeTextFontSize: String = "undefined"
    @State var cfg_inlineCodeTextBackgroundColor: String = "undefined"
    @State var cfg_inlineCodeTextFontWeight: String = "Normal"

    @State var cfg_inlineCodeTextFontFamily: String = "undefined"
    @State var cfg_inlineCodeTextLineHeight: String = "undefined"
    @State var cfg_inlineCodeTextLetterSpacing: String = "undefined"
    @State var cfg_inlineCodeTextBackgroundTopLeft: String = "0"
    @State var cfg_inlineCodeTextBackgroundTopRight: String = "0"
    @State var cfg_inlineCodeTextBackgroundBottomLeft: String = "0"
    @State var cfg_inlineCodeTextBackgroundBottomRight: String = "0"
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
        streamLoad(
            fullContent,
            isFull,
            textNumber,
            timeMs,
            { cumulative, ended =>
                mdStr = cumulative
                isInputEnded = ended
            }
        )
    }

    func buildConfig(): MarkdownConfiguration {
        let themeBuilder = MarkdownTheme.createDefaultBuilder()
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

        let inlineCodeTheme = InlineCodeTheme()
        if (cfg_inlineCodeTextFontColor != "undefined") {
            inlineCodeTheme.setInlineCodeTextFontColor(parseColor(cfg_inlineCodeTextFontColor))
        }
        if (cfg_inlineCodeTextFontSize != "undefined") {
            inlineCodeTheme.setInlineCodeTextFontSize(parseFloat64(cfg_inlineCodeTextFontSize))
        }
        if (cfg_inlineCodeTextBackgroundColor != "undefined") {
            inlineCodeTheme.setInlineCodeTextBackgroundColor(parseColor(cfg_inlineCodeTextBackgroundColor))
        }
        inlineCodeTheme.setInlineCodeTextFontWeight(parseFontWeight(cfg_inlineCodeTextFontWeight))
        if (cfg_inlineCodeTextFontFamily != "undefined") {
            inlineCodeTheme.setInlineCodeTextFontFamily(cfg_inlineCodeTextFontFamily)
        }
        if (cfg_inlineCodeTextLineHeight != "undefined") {
            inlineCodeTheme.setInlineCodeTextLineHeight(parseFloat64(cfg_inlineCodeTextLineHeight))
        }
        if (cfg_inlineCodeTextLetterSpacing != "undefined") {
            inlineCodeTheme.setInlineCodeTextLetterSpacing(parseFloat64(cfg_inlineCodeTextLetterSpacing))
        }
        inlineCodeTheme.setInlineCodeTextBackgroundRadius(topLeft: parseFloat64(cfg_inlineCodeTextBackgroundTopLeft), topRight: parseFloat64(cfg_inlineCodeTextBackgroundTopRight), bottomLeft: parseFloat64(cfg_inlineCodeTextBackgroundBottomLeft), bottomRight: parseFloat64(cfg_inlineCodeTextBackgroundBottomRight))
        themeBuilder.setInlineCodeTheme(inlineCodeTheme)
        let theme = themeBuilder.build()
        let configBuilder = MarkdownConfiguration.emptyBuilder()
        configBuilder.setMarkdownTheme(theme)
        return configBuilder.build()
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
                                ConfigTabSelector(title: "是否全量加载 - ", options: booleanList, defaultValue: "true", configKey: "", onSelect: { v => cfg_isFull = v })
                                ConfigTabSelector(title: "是否增量解析 - ", options: booleanList, defaultValue: "false", configKey: "", onSelect: { v => cfg_incrementalAnalysis = v })
                                ConfigTabSelector(title: "是否启用解析节流 - ", options: booleanList, defaultValue: "false", configKey: "", onSelect: { v => cfg_enableParseThrottle = v })
                                ConfigTabSelector(title: "解析节流间隔(ms) - ", options: timeList, defaultValue: "200", configKey: "", onSelect: { v => cfg_parseThrottleMs = v })
                                ConfigTabSelector(title: "增量加载间隔时间 - ", options: timeList, defaultValue: "50", configKey: "", onSelect: { v => cfg_time = v })
                                ConfigTabSelector(title: "增量文本数量 - ", options: textNumberList, defaultValue: "10", configKey: "", onSelect: { v => cfg_textNumber = v })
                                ConfigTabSelector(title: "是否同步解析 - ", options: booleanList, defaultValue: "false", configKey: "", onSelect: { v => cfg_isMarkdownParserSync = v })
                                ConfigTabSelector(title: "长按复制粘贴 - ", options: booleanList, defaultValue: "false", configKey: "", onSelect: { v => cfg_isOnCopy = v })
                                ConfigTabSelector(title: "全局上外边距 - ", options: marginList, defaultValue: "0", configKey: "", onSelect: { v => cfg_blockMarginTop = v })
                                ConfigTabSelector(title: "全局右外边距 - ", options: marginList, defaultValue: "0", configKey: "", onSelect: { v => cfg_blockMarginRight = v })
                                ConfigTabSelector(title: "全局下外边距 - ", options: marginList, defaultValue: "0", configKey: "", onSelect: { v => cfg_blockMarginBottom = v })
                                ConfigTabSelector(title: "全局左外边距 - ", options: marginList, defaultValue: "0", configKey: "", onSelect: { v => cfg_blockMarginLeft = v })
                                ConfigTabSelector(title: "模块间间距 - ", options: marginList, defaultValue: "8", configKey: "", onSelect: { v => cfg_markdownBlockSpacing = v })
                                ConfigTabSelector(title: "软换行是否换行 - ", options: booleanList, defaultValue: "false", configKey: "", onSelect: { v => cfg_isLineBreak = v })
                                ConfigTabSelector(title: "背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_backgroundColor = v })
                                ConfigTabSelector(title: "响应滑动测试 - ", options: booleanList, defaultValue: "false", configKey: "", onSelect: { v => cfg_openGestureSwipeTest = v })
                                ConfigTabSelector(title: "控件响应滑动 - ", options: booleanList, defaultValue: "false", configKey: "", onSelect: { v => cfg_openGestureSwipe = v })
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
                                ConfigTabSelector(title: "内联代码文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_inlineCodeTextFontColor = v })
                                ConfigTabSelector(title: "内联代码文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_inlineCodeTextFontSize = v })
                                ConfigTabSelector(title: "内联代码背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_inlineCodeTextBackgroundColor = v })
                                ConfigTabSelector(title: "内联代码字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", onSelect: { v => cfg_inlineCodeTextFontWeight = v })
                                ConfigTabSelector(title: "内联代码文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_inlineCodeTextFontFamily = v })
                                ConfigTabSelector(title: "内联代码文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_inlineCodeTextLineHeight = v })
                                ConfigTabSelector(title: "内联代码文本字符间距 - ", options: textWordSpaceList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_inlineCodeTextLetterSpacing = v })
                                ConfigTabSelector(title: "内联代码文本背景左上圆角 - ", options: radiusList, defaultValue: "0", configKey: "", onSelect: { v => cfg_inlineCodeTextBackgroundTopLeft = v })
                                ConfigTabSelector(title: "内联代码文本背景右上圆角 - ", options: radiusList, defaultValue: "0", configKey: "", onSelect: { v => cfg_inlineCodeTextBackgroundTopRight = v })
                                ConfigTabSelector(title: "内联代码文本背景左下圆角 - ", options: radiusList, defaultValue: "0", configKey: "", onSelect: { v => cfg_inlineCodeTextBackgroundBottomLeft = v })
                                ConfigTabSelector(title: "内联代码文本背景右下圆角 - ", options: radiusList, defaultValue: "0", configKey: "", onSelect: { v => cfg_inlineCodeTextBackgroundBottomRight = v })
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
                                scroller: Scroller(),
                                markdownConfiguration: buildConfig()
                            )
                        }
                        .width(100.percent)
                        .padding(5.0)
                        .backgroundColor(0xFFFFFFFF)
                    }
                }
                .padding(top: 10.0, bottom: 100.0)
                .justifyContent(FlexAlign.Start)
            }
            .scrollable(ScrollDirection.Vertical)
            .align(Alignment.Top)
            .layoutWeight(1)
        }
        .width(100.percent)
        .height(90.0.percent)
        .backgroundColor(0xFFEAEAEA)
        .justifyContent(FlexAlign.Start)
    }
}