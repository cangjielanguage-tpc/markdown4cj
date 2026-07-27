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
class AudioPage {
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
    @State @Watch[onConfigChanged] var cfg_audioBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioBorderColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioTitleTextFontColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioButtonBackgroundColor: String = "undefined"

    @State @Watch[onConfigChanged] var cfg_audioMarginTop: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioMarginRight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioMarginBottom: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioMarginLeft: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioPaddingTop: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioPaddingRight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioPaddingBottom: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioPaddingLeft: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioRadiusTopLeft: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioRadiusTopRight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioRadiusBottomLeft: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioRadiusBottomRight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioBorderStyle: String = "Solid"
    @State @Watch[onConfigChanged] var cfg_audioBorderWidth: String = "0.5"
    @State @Watch[onConfigChanged] var cfg_audioShadowRadius: String = "12"
    @State @Watch[onConfigChanged] var cfg_audioShadowColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioShadowOffsetX: String = "0"
    @State @Watch[onConfigChanged] var cfg_audioShadowOffsetY: String = "2"
    @State @Watch[onConfigChanged] var cfg_audioIcon: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioIconWidth: String = "40"
    @State @Watch[onConfigChanged] var cfg_audioIconHeight: String = "40"
    @State @Watch[onConfigChanged] var cfg_audioIconRadiusTopLeft: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioIconRadiusTopRight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioIconRadiusBottomLeft: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioIconRadiusBottomRight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioIconFitType: String = "Contain"
    @State @Watch[onConfigChanged] var cfg_audioTitleToTypeSpacing: String = "2"
    @State @Watch[onConfigChanged] var cfg_audioTitleTextFontSize: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioTitleTextFontStyle: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioTitleTextFontWeight: String = "Normal"
    @State @Watch[onConfigChanged] var cfg_audioTitleTextFontFamily: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioTitleTextLineHeight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioTypeTextFontColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioTypeTextFontSize: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioTypeTextFontStyle: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioTypeTextFontWeight: String = "Normal"
    @State @Watch[onConfigChanged] var cfg_audioTypeTextFontFamily: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioTypeTextLineHeight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioButtonWidth: String = "84"
    @State @Watch[onConfigChanged] var cfg_audioButtonHeight: String = "32"
    @State @Watch[onConfigChanged] var cfg_audioButtonBorderStyle: String = "Solid"
    @State @Watch[onConfigChanged] var cfg_audioButtonBorderWidth: String = "0"
    @State @Watch[onConfigChanged] var cfg_audioButtonBorderColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioButtonRadiusTopLeft: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioButtonRadiusTopRight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioButtonRadiusBottomLeft: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioButtonRadiusBottomRight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioButtonText: String = "立即播放"
    @State @Watch[onConfigChanged] var cfg_audioButtonTextFontColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioButtonTextFontSize: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioButtonTextFontStyle: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioButtonTextFontWeight: String = "Normal"
    @State @Watch[onConfigChanged] var cfg_audioButtonTextFontFamily: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_audioButtonTextLineHeight: String = "undefined"
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

        let audioTheme = theme.getAudioTheme()
        if (cfg_audioBackgroundColor != "undefined") {
            audioTheme.setAudioBackgroundColor(parseColor(cfg_audioBackgroundColor))
        }
        if (cfg_audioBorderColor != "undefined") {
            audioTheme.setAudioBorderColor(parseColor(cfg_audioBorderColor))
        }
        if (cfg_audioTitleTextFontColor != "undefined") {
            audioTheme.setAudioTitleTextFontColor(parseColor(cfg_audioTitleTextFontColor))
        }
        if (cfg_audioButtonBackgroundColor != "undefined") {
            audioTheme.setAudioButtonBackgroundColor(parseColor(cfg_audioButtonBackgroundColor))
        }
        audioTheme.setAudioBorderStyle(parseBorderStyle(cfg_audioBorderStyle))
        audioTheme.setAudioBorderWidth(parseFloat64(cfg_audioBorderWidth))
        audioTheme.setAudioShadowRadius(parseFloat64(cfg_audioShadowRadius))
        if (cfg_audioShadowColor != "undefined") {
            audioTheme.setAudioShadowColor(parseColor(cfg_audioShadowColor))
        }
        audioTheme.setAudioShadowOffsetX(parseFloat64(cfg_audioShadowOffsetX))
        audioTheme.setAudioShadowOffsetY(parseFloat64(cfg_audioShadowOffsetY))
        if (let Some(v) <- parseAppResource(cfg_audioIcon)) {
            audioTheme.setAudioIcon(v)
        }
        audioTheme.setAudioIconWidth(parseFloat64(cfg_audioIconWidth))
        audioTheme.setAudioIconHeight(parseFloat64(cfg_audioIconHeight))
        audioTheme.setAudioIconFitType(parseImageFit(cfg_audioIconFitType))
        audioTheme.setAudioTitleToTypeSpacing(parseFloat64(cfg_audioTitleToTypeSpacing))
        if (cfg_audioTitleTextFontSize != "undefined") {
            audioTheme.setAudioTitleTextFontSize(parseFloat64(cfg_audioTitleTextFontSize))
        }
        if (cfg_audioTitleTextFontStyle != "undefined") {
            audioTheme.setAudioTitleTextFontStyle(parseFontStyle(cfg_audioTitleTextFontStyle))
        }
        audioTheme.setAudioTitleTextFontWeight(parseFontWeight(cfg_audioTitleTextFontWeight))
        if (cfg_audioTitleTextFontFamily != "undefined") {
            audioTheme.setAudioTitleTextFontFamily(cfg_audioTitleTextFontFamily)
        }
        if (cfg_audioTitleTextLineHeight != "undefined") {
            audioTheme.setAudioTitleTextLineHeight(parseFloat64(cfg_audioTitleTextLineHeight))
        }
        if (cfg_audioTypeTextFontColor != "undefined") {
            audioTheme.setAudioTypeTextFontColor(parseColor(cfg_audioTypeTextFontColor))
        }
        if (cfg_audioTypeTextFontSize != "undefined") {
            audioTheme.setAudioTypeTextFontSize(parseFloat64(cfg_audioTypeTextFontSize))
        }
        if (cfg_audioTypeTextFontStyle != "undefined") {
            audioTheme.setAudioTypeTextFontStyle(parseFontStyle(cfg_audioTypeTextFontStyle))
        }
        audioTheme.setAudioTypeTextFontWeight(parseFontWeight(cfg_audioTypeTextFontWeight))
        if (cfg_audioTypeTextFontFamily != "undefined") {
            audioTheme.setAudioTypeTextFontFamily(cfg_audioTypeTextFontFamily)
        }
        if (cfg_audioTypeTextLineHeight != "undefined") {
            audioTheme.setAudioTypeTextLineHeight(parseFloat64(cfg_audioTypeTextLineHeight))
        }
        audioTheme.setAudioButtonWidth(parseFloat64(cfg_audioButtonWidth))
        audioTheme.setAudioButtonHeight(parseFloat64(cfg_audioButtonHeight))
        audioTheme.setAudioButtonBorderStyle(parseBorderStyle(cfg_audioButtonBorderStyle))
        audioTheme.setAudioButtonBorderWidth(parseFloat64(cfg_audioButtonBorderWidth))
        if (cfg_audioButtonBorderColor != "undefined") {
            audioTheme.setAudioButtonBorderColor(parseColor(cfg_audioButtonBorderColor))
        }
        audioTheme.setAudioButtonText(cfg_audioButtonText)
        if (cfg_audioButtonTextFontColor != "undefined") {
            audioTheme.setAudioButtonTextFontColor(parseColor(cfg_audioButtonTextFontColor))
        }
        if (cfg_audioButtonTextFontSize != "undefined") {
            audioTheme.setAudioButtonTextFontSize(parseFloat64(cfg_audioButtonTextFontSize))
        }
        if (cfg_audioButtonTextFontStyle != "undefined") {
            audioTheme.setAudioButtonTextFontStyle(parseFontStyle(cfg_audioButtonTextFontStyle))
        }
        audioTheme.setAudioButtonTextFontWeight(parseFontWeight(cfg_audioButtonTextFontWeight))
        if (cfg_audioButtonTextFontFamily != "undefined") {
            audioTheme.setAudioButtonTextFontFamily(cfg_audioButtonTextFontFamily)
        }
        if (cfg_audioButtonTextLineHeight != "undefined") {
            audioTheme.setAudioButtonTextLineHeight(parseFloat64(cfg_audioButtonTextLineHeight))
        }
        audioTheme.setAudioIconRadius(topLeft: parseFloat64(cfg_audioIconRadiusTopLeft), topRight: parseFloat64(cfg_audioIconRadiusTopRight), bottomLeft: parseFloat64(cfg_audioIconRadiusBottomLeft), bottomRight: parseFloat64(cfg_audioIconRadiusBottomRight))
        audioTheme.setAudioPadding(top: parseFloat64(cfg_audioPaddingTop), right: parseFloat64(cfg_audioPaddingRight), bottom: parseFloat64(cfg_audioPaddingBottom), left: parseFloat64(cfg_audioPaddingLeft))
        audioTheme.setAudioMargin(top: parseFloat64(cfg_audioMarginTop), right: parseFloat64(cfg_audioMarginRight), bottom: parseFloat64(cfg_audioMarginBottom), left: parseFloat64(cfg_audioMarginLeft))
        audioTheme.setAudioBorderRadius(topLeft: parseFloat64(cfg_audioRadiusTopLeft), topRight: parseFloat64(cfg_audioRadiusTopRight), bottomLeft: parseFloat64(cfg_audioRadiusBottomLeft), bottomRight: parseFloat64(cfg_audioRadiusBottomRight))
        audioTheme.setAudioButtonRadius(topLeft: parseFloat64(cfg_audioButtonRadiusTopLeft), topRight: parseFloat64(cfg_audioButtonRadiusTopRight), bottomLeft: parseFloat64(cfg_audioButtonRadiusBottomLeft), bottomRight: parseFloat64(cfg_audioButtonRadiusBottomRight))
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
                            Text("音频边距和边框")
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
                                ConfigTabSelector(title: "音频背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioBackgroundColor, onSelect: { v => cfg_audioBackgroundColor = v })
                                ConfigTabSelector(title: "音频边框颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioBorderColor, onSelect: { v => cfg_audioBorderColor = v })
                                ConfigTabSelector(title: "音频上外边距 - ", options: marginList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioMarginTop, onSelect: { v => cfg_audioMarginTop = v })
                                ConfigTabSelector(title: "音频右外边距 - ", options: marginList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioMarginRight, onSelect: { v => cfg_audioMarginRight = v })
                                ConfigTabSelector(title: "音频下外边距 - ", options: marginList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioMarginBottom, onSelect: { v => cfg_audioMarginBottom = v })
                                ConfigTabSelector(title: "音频左外边距 - ", options: marginList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioMarginLeft, onSelect: { v => cfg_audioMarginLeft = v })
                                ConfigTabSelector(title: "音频上内边距 - ", options: paddingList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioPaddingTop, onSelect: { v => cfg_audioPaddingTop = v })
                                ConfigTabSelector(title: "音频右内边距 - ", options: paddingList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioPaddingRight, onSelect: { v => cfg_audioPaddingRight = v })
                                ConfigTabSelector(title: "音频下内边距 - ", options: paddingList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioPaddingBottom, onSelect: { v => cfg_audioPaddingBottom = v })
                                ConfigTabSelector(title: "音频左内边距 - ", options: paddingList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioPaddingLeft, onSelect: { v => cfg_audioPaddingLeft = v })
                                ConfigTabSelector(title: "音频边框左上圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioRadiusTopLeft, onSelect: { v => cfg_audioRadiusTopLeft = v })
                                ConfigTabSelector(title: "音频边框右上圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioRadiusTopRight, onSelect: { v => cfg_audioRadiusTopRight = v })
                                ConfigTabSelector(title: "音频边框左下圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioRadiusBottomLeft, onSelect: { v => cfg_audioRadiusBottomLeft = v })
                                ConfigTabSelector(title: "音频边框右下圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioRadiusBottomRight, onSelect: { v => cfg_audioRadiusBottomRight = v })
                                ConfigTabSelector(title: "音频边框样式 - ", options: borderStyleList, defaultValue: "Solid", configKey: "", currentValue: cfg_audioBorderStyle, onSelect: { v => cfg_audioBorderStyle = v })
                                ConfigTabSelector(title: "音频边框宽度 - ", options: lineOrBorderWidthList, defaultValue: "0.5", configKey: "", currentValue: cfg_audioBorderWidth, onSelect: { v => cfg_audioBorderWidth = v })
                                ConfigTabSelector(title: "音频阴影模糊半径 - ", options: radiusList, defaultValue: "12", configKey: "", currentValue: cfg_audioShadowRadius, onSelect: { v => cfg_audioShadowRadius = v })
                                ConfigTabSelector(title: "音频阴影颜色值 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioShadowColor, onSelect: { v => cfg_audioShadowColor = v })
                                ConfigTabSelector(title: "音频阴影X轴偏移量 - ", options: offsetList, defaultValue: "0", configKey: "", currentValue: cfg_audioShadowOffsetX, onSelect: { v => cfg_audioShadowOffsetX = v })
                                ConfigTabSelector(title: "音频阴影Y轴偏移量 - ", options: offsetList, defaultValue: "2", configKey: "", currentValue: cfg_audioShadowOffsetY, onSelect: { v => cfg_audioShadowOffsetY = v })
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
                            Text("音频图标和其他")
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
                                ConfigTabSelector(title: "音频图标 - ", options: iconList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioIcon, onSelect: { v => cfg_audioIcon = v })
                                ConfigTabSelector(title: "音频图标宽度 - ", options: widthOrHeightList, defaultValue: "40", configKey: "", currentValue: cfg_audioIconWidth, onSelect: { v => cfg_audioIconWidth = v })
                                ConfigTabSelector(title: "音频图标高度 - ", options: widthOrHeightList, defaultValue: "40", configKey: "", currentValue: cfg_audioIconHeight, onSelect: { v => cfg_audioIconHeight = v })
                                ConfigTabSelector(title: "音频图标左上圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioIconRadiusTopLeft, onSelect: { v => cfg_audioIconRadiusTopLeft = v })
                                ConfigTabSelector(title: "音频图标右上圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioIconRadiusTopRight, onSelect: { v => cfg_audioIconRadiusTopRight = v })
                                ConfigTabSelector(title: "音频图标左下圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioIconRadiusBottomLeft, onSelect: { v => cfg_audioIconRadiusBottomLeft = v })
                                ConfigTabSelector(title: "音频图标右下圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioIconRadiusBottomRight, onSelect: { v => cfg_audioIconRadiusBottomRight = v })
                                ConfigTabSelector(title: "音频图标缩放类型 - ", options: imageFitList, defaultValue: "Contain", configKey: "", currentValue: cfg_audioIconFitType, onSelect: { v => cfg_audioIconFitType = v })
                                ConfigTabSelector(title: "音频标题文本和类型文本间距 - ", options: spaceList, defaultValue: "2", configKey: "", currentValue: cfg_audioTitleToTypeSpacing, onSelect: { v => cfg_audioTitleToTypeSpacing = v })
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
                            Text("音频按钮")
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
                                ConfigTabSelector(title: "音频按钮背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioButtonBackgroundColor, onSelect: { v => cfg_audioButtonBackgroundColor = v })
                                ConfigTabSelector(title: "音频按钮宽度 - ", options: widthOrHeightList, defaultValue: "84", configKey: "", currentValue: cfg_audioButtonWidth, onSelect: { v => cfg_audioButtonWidth = v })
                                ConfigTabSelector(title: "音频按钮高度 - ", options: widthOrHeightList, defaultValue: "32", configKey: "", currentValue: cfg_audioButtonHeight, onSelect: { v => cfg_audioButtonHeight = v })
                                ConfigTabSelector(title: "音频按钮边框样式 - ", options: borderStyleList, defaultValue: "Solid", configKey: "", currentValue: cfg_audioButtonBorderStyle, onSelect: { v => cfg_audioButtonBorderStyle = v })
                                ConfigTabSelector(title: "音频按钮边框宽度 - ", options: lineOrBorderWidthList, defaultValue: "0", configKey: "", currentValue: cfg_audioButtonBorderWidth, onSelect: { v => cfg_audioButtonBorderWidth = v })
                                ConfigTabSelector(title: "音频按钮边框颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioButtonBorderColor, onSelect: { v => cfg_audioButtonBorderColor = v })
                                ConfigTabSelector(title: "音频按钮边框左上圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioButtonRadiusTopLeft, onSelect: { v => cfg_audioButtonRadiusTopLeft = v })
                                ConfigTabSelector(title: "音频按钮边框右上圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioButtonRadiusTopRight, onSelect: { v => cfg_audioButtonRadiusTopRight = v })
                                ConfigTabSelector(title: "音频按钮边框左下圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioButtonRadiusBottomLeft, onSelect: { v => cfg_audioButtonRadiusBottomLeft = v })
                                ConfigTabSelector(title: "音频按钮边框右下圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioButtonRadiusBottomRight, onSelect: { v => cfg_audioButtonRadiusBottomRight = v })
                                ConfigTabSelector(title: "音频按钮默认文本内容 - ", options: audioButtonTextList, defaultValue: "立即播放", configKey: "", currentValue: cfg_audioButtonText, onSelect: { v => cfg_audioButtonText = v })
                                ConfigTabSelector(title: "音频按钮文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioButtonTextFontColor, onSelect: { v => cfg_audioButtonTextFontColor = v })
                                ConfigTabSelector(title: "音频按钮文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioButtonTextFontSize, onSelect: { v => cfg_audioButtonTextFontSize = v })
                                ConfigTabSelector(title: "音频按钮文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioButtonTextFontStyle, onSelect: { v => cfg_audioButtonTextFontStyle = v })
                                ConfigTabSelector(title: "音频按钮文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_audioButtonTextFontWeight, onSelect: { v => cfg_audioButtonTextFontWeight = v })
                                ConfigTabSelector(title: "音频按钮文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioButtonTextFontFamily, onSelect: { v => cfg_audioButtonTextFontFamily = v })
                                ConfigTabSelector(title: "音频按钮文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioButtonTextLineHeight, onSelect: { v => cfg_audioButtonTextLineHeight = v })
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
                            Text("音频标题和类型文本")
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
                                ConfigTabSelector(title: "音频标题文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioTitleTextFontColor, onSelect: { v => cfg_audioTitleTextFontColor = v })
                                ConfigTabSelector(title: "音频标题文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioTitleTextFontSize, onSelect: { v => cfg_audioTitleTextFontSize = v })
                                ConfigTabSelector(title: "音频标题文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioTitleTextFontStyle, onSelect: { v => cfg_audioTitleTextFontStyle = v })
                                ConfigTabSelector(title: "音频标题文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_audioTitleTextFontWeight, onSelect: { v => cfg_audioTitleTextFontWeight = v })
                                ConfigTabSelector(title: "音频标题文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioTitleTextFontFamily, onSelect: { v => cfg_audioTitleTextFontFamily = v })
                                ConfigTabSelector(title: "音频标题文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioTitleTextLineHeight, onSelect: { v => cfg_audioTitleTextLineHeight = v })
                                ConfigTabSelector(title: "音频类型文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioTypeTextFontColor, onSelect: { v => cfg_audioTypeTextFontColor = v })
                                ConfigTabSelector(title: "音频类型文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioTypeTextFontSize, onSelect: { v => cfg_audioTypeTextFontSize = v })
                                ConfigTabSelector(title: "音频类型文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioTypeTextFontStyle, onSelect: { v => cfg_audioTypeTextFontStyle = v })
                                ConfigTabSelector(title: "音频类型文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_audioTypeTextFontWeight, onSelect: { v => cfg_audioTypeTextFontWeight = v })
                                ConfigTabSelector(title: "音频类型文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioTypeTextFontFamily, onSelect: { v => cfg_audioTypeTextFontFamily = v })
                                ConfigTabSelector(title: "音频类型文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_audioTypeTextLineHeight, onSelect: { v => cfg_audioTypeTextLineHeight = v })
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
                                markdownConfiguration: markdownConfiguration,
                                markdownPlugin: markdownPlugin
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