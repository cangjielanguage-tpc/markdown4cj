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
class TitlePage {
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
    var isExpanded8: Bool = false
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
    @State var cfg_heading1TextFontColor: String = "undefined"
    @State var cfg_heading1TextFontSize: String = "undefined"
    @State var cfg_heading1TextFontWeight: String = "Bold"
    @State var cfg_heading1TextFontFamily: String = "undefined"
    @State var cfg_heading1BackgroundColor: String = "undefined"
    @State var cfg_heading1UnderlineColor: String = "undefined"
    @State var cfg_heading1UnderlineHeight: String = "undefined"
    @State var cfg_heading1TextFontStyle: String = "undefined"
    @State var cfg_heading1TextLineHeight: String = "undefined"
    @State var cfg_heading1TextLetterSpacing: String = "undefined"
    @State var cfg_heading1UnderlineSpacing: String = "0"
    @State var cfg_heading1MarginTop: String = "0"
    @State var cfg_heading1MarginRight: String = "0"
    @State var cfg_heading1MarginBottom: String = "0"
    @State var cfg_heading1MarginLeft: String = "0"
    @State var cfg_heading1PaddingTop: String = "0"
    @State var cfg_heading1PaddingRight: String = "0"
    @State var cfg_heading1PaddingBottom: String = "0"
    @State var cfg_heading1PaddingLeft: String = "0"

    @State var cfg_heading2TextFontColor: String = "undefined"
    @State var cfg_heading2TextFontSize: String = "undefined"
    @State var cfg_heading2TextFontStyle: String = "undefined"
    @State var cfg_heading2TextFontWeight: String = "Normal"
    @State var cfg_heading2TextFontFamily: String = "undefined"
    @State var cfg_heading2TextLineHeight: String = "undefined"
    @State var cfg_heading2TextLetterSpacing: String = "undefined"
    @State var cfg_heading2BackgroundColor: String = "undefined"
    @State var cfg_heading2UnderlineColor: String = "undefined"
    @State var cfg_heading2UnderlineHeight: String = "0"
    @State var cfg_heading2UnderlineSpacing: String = "0"
    @State var cfg_heading2MarginTop: String = "0"
    @State var cfg_heading2MarginRight: String = "0"
    @State var cfg_heading2MarginBottom: String = "0"
    @State var cfg_heading2MarginLeft: String = "0"
    @State var cfg_heading2PaddingTop: String = "0"
    @State var cfg_heading2PaddingRight: String = "0"
    @State var cfg_heading2PaddingBottom: String = "0"
    @State var cfg_heading2PaddingLeft: String = "0"
    @State var cfg_heading3TextFontColor: String = "undefined"
    @State var cfg_heading3TextFontSize: String = "undefined"
    @State var cfg_heading3TextFontStyle: String = "undefined"
    @State var cfg_heading3TextFontWeight: String = "Normal"
    @State var cfg_heading3TextFontFamily: String = "undefined"
    @State var cfg_heading3TextLineHeight: String = "undefined"
    @State var cfg_heading3TextLetterSpacing: String = "undefined"
    @State var cfg_heading3BackgroundColor: String = "undefined"
    @State var cfg_heading3UnderlineColor: String = "undefined"
    @State var cfg_heading3UnderlineHeight: String = "0"
    @State var cfg_heading3UnderlineSpacing: String = "0"
    @State var cfg_heading3MarginTop: String = "0"
    @State var cfg_heading3MarginRight: String = "0"
    @State var cfg_heading3MarginBottom: String = "0"
    @State var cfg_heading3MarginLeft: String = "0"
    @State var cfg_heading3PaddingTop: String = "0"
    @State var cfg_heading3PaddingRight: String = "0"
    @State var cfg_heading3PaddingBottom: String = "0"
    @State var cfg_heading3PaddingLeft: String = "0"
    @State var cfg_heading4TextFontColor: String = "undefined"
    @State var cfg_heading4TextFontSize: String = "undefined"
    @State var cfg_heading4TextFontStyle: String = "undefined"
    @State var cfg_heading4TextFontWeight: String = "Normal"
    @State var cfg_heading4TextFontFamily: String = "undefined"
    @State var cfg_heading4TextLineHeight: String = "undefined"
    @State var cfg_heading4TextLetterSpacing: String = "undefined"
    @State var cfg_heading4BackgroundColor: String = "undefined"
    @State var cfg_heading4UnderlineColor: String = "undefined"
    @State var cfg_heading4UnderlineHeight: String = "0"
    @State var cfg_heading4UnderlineSpacing: String = "0"
    @State var cfg_heading4MarginTop: String = "0"
    @State var cfg_heading4MarginRight: String = "0"
    @State var cfg_heading4MarginBottom: String = "0"
    @State var cfg_heading4MarginLeft: String = "0"
    @State var cfg_heading4PaddingTop: String = "0"
    @State var cfg_heading4PaddingRight: String = "0"
    @State var cfg_heading4PaddingBottom: String = "0"
    @State var cfg_heading4PaddingLeft: String = "0"
    @State var cfg_heading5TextFontColor: String = "undefined"
    @State var cfg_heading5TextFontSize: String = "undefined"
    @State var cfg_heading5TextFontStyle: String = "undefined"
    @State var cfg_heading5TextFontWeight: String = "Normal"
    @State var cfg_heading5TextFontFamily: String = "undefined"
    @State var cfg_heading5TextLineHeight: String = "undefined"
    @State var cfg_heading5TextLetterSpacing: String = "undefined"
    @State var cfg_heading5BackgroundColor: String = "undefined"
    @State var cfg_heading5UnderlineColor: String = "undefined"
    @State var cfg_heading5UnderlineHeight: String = "0"
    @State var cfg_heading5UnderlineSpacing: String = "0"
    @State var cfg_heading5MarginTop: String = "0"
    @State var cfg_heading5MarginRight: String = "0"
    @State var cfg_heading5MarginBottom: String = "0"
    @State var cfg_heading5MarginLeft: String = "0"
    @State var cfg_heading5PaddingTop: String = "0"
    @State var cfg_heading5PaddingRight: String = "0"
    @State var cfg_heading5PaddingBottom: String = "0"
    @State var cfg_heading5PaddingLeft: String = "0"
    @State var cfg_heading6TextFontColor: String = "undefined"
    @State var cfg_heading6TextFontSize: String = "undefined"
    @State var cfg_heading6TextFontStyle: String = "undefined"
    @State var cfg_heading6TextFontWeight: String = "Normal"
    @State var cfg_heading6TextFontFamily: String = "undefined"
    @State var cfg_heading6TextLineHeight: String = "undefined"
    @State var cfg_heading6TextLetterSpacing: String = "undefined"
    @State var cfg_heading6BackgroundColor: String = "undefined"
    @State var cfg_heading6UnderlineColor: String = "undefined"
    @State var cfg_heading6UnderlineHeight: String = "0"
    @State var cfg_heading6UnderlineSpacing: String = "0"
    @State var cfg_heading6MarginTop: String = "0"
    @State var cfg_heading6MarginRight: String = "0"
    @State var cfg_heading6MarginBottom: String = "0"
    @State var cfg_heading6MarginLeft: String = "0"
    @State var cfg_heading6PaddingTop: String = "0"
    @State var cfg_heading6PaddingRight: String = "0"
    @State var cfg_heading6PaddingBottom: String = "0"
    @State var cfg_heading6PaddingLeft: String = "0"
    @State var cfg_showHighlight: String = "true"
    @State var cfg_beforeSelectedParagraphBackgroundColor: String = "undefined"
    @State var cfg_selectedParagraphBackgroundColor: String = "undefined"
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

        let headingTheme = HeadingTheme()
        if (cfg_heading1TextFontColor != "undefined") {
            headingTheme.setTextFontColorForDesignateHeading(1, parseColor(cfg_heading1TextFontColor))
        }
        if (cfg_heading1TextFontSize != "undefined") {
            headingTheme.setTextFontSizeForDesignateHeading(1, parseFloat64(cfg_heading1TextFontSize))
        }
        headingTheme.setTextFontWeightForDesignateHeading(1, parseFontWeight(cfg_heading1TextFontWeight))
        if (cfg_heading1TextFontFamily != "undefined") {
            headingTheme.setTextFontFamilyForDesignateHeading(1, cfg_heading1TextFontFamily)
        }
        if (cfg_heading1BackgroundColor != "undefined") {
            headingTheme.setBackgroundColorForDesignateHeading(1, parseColor(cfg_heading1BackgroundColor))
        }
        if (cfg_heading1UnderlineColor != "undefined") {
            headingTheme.setUnderlineColorForDesignateHeading(1, parseColor(cfg_heading1UnderlineColor))
        }
        if (cfg_heading1UnderlineHeight != "undefined") {
            headingTheme.setUnderlineHeightForDesignateHeading(1, parseFloat64(cfg_heading1UnderlineHeight))
        }
        if (cfg_heading1TextFontStyle != "undefined") {
            headingTheme.setTextFontStyleForDesignateHeading(1, parseFontStyle(cfg_heading1TextFontStyle))
        }
        if (cfg_heading1TextLineHeight != "undefined") {
            headingTheme.setTextLineHeightForDesignateHeading(1, parseFloat64(cfg_heading1TextLineHeight))
        }
        if (cfg_heading1TextLetterSpacing != "undefined") {
            headingTheme.setTextLetterSpacingForDesignateHeading(1, parseFloat64(cfg_heading1TextLetterSpacing))
        }
        headingTheme.setUnderlineSpacingForDesignateHeading(1, parseFloat64(cfg_heading1UnderlineSpacing))
        if (cfg_heading2TextFontColor != "undefined") {
            headingTheme.setTextFontColorForDesignateHeading(2, parseColor(cfg_heading2TextFontColor))
        }
        if (cfg_heading2TextFontSize != "undefined") {
            headingTheme.setTextFontSizeForDesignateHeading(2, parseFloat64(cfg_heading2TextFontSize))
        }
        if (cfg_heading2TextFontStyle != "undefined") {
            headingTheme.setTextFontStyleForDesignateHeading(2, parseFontStyle(cfg_heading2TextFontStyle))
        }
        headingTheme.setTextFontWeightForDesignateHeading(2, parseFontWeight(cfg_heading2TextFontWeight))
        if (cfg_heading2TextFontFamily != "undefined") {
            headingTheme.setTextFontFamilyForDesignateHeading(2, cfg_heading2TextFontFamily)
        }
        if (cfg_heading2TextLineHeight != "undefined") {
            headingTheme.setTextLineHeightForDesignateHeading(2, parseFloat64(cfg_heading2TextLineHeight))
        }
        if (cfg_heading2TextLetterSpacing != "undefined") {
            headingTheme.setTextLetterSpacingForDesignateHeading(2, parseFloat64(cfg_heading2TextLetterSpacing))
        }
        if (cfg_heading2BackgroundColor != "undefined") {
            headingTheme.setBackgroundColorForDesignateHeading(2, parseColor(cfg_heading2BackgroundColor))
        }
        if (cfg_heading2UnderlineColor != "undefined") {
            headingTheme.setUnderlineColorForDesignateHeading(2, parseColor(cfg_heading2UnderlineColor))
        }
        headingTheme.setUnderlineHeightForDesignateHeading(2, parseFloat64(cfg_heading2UnderlineHeight))
        headingTheme.setUnderlineSpacingForDesignateHeading(2, parseFloat64(cfg_heading2UnderlineSpacing))
        if (cfg_heading3TextFontColor != "undefined") {
            headingTheme.setTextFontColorForDesignateHeading(3, parseColor(cfg_heading3TextFontColor))
        }
        if (cfg_heading3TextFontSize != "undefined") {
            headingTheme.setTextFontSizeForDesignateHeading(3, parseFloat64(cfg_heading3TextFontSize))
        }
        if (cfg_heading3TextFontStyle != "undefined") {
            headingTheme.setTextFontStyleForDesignateHeading(3, parseFontStyle(cfg_heading3TextFontStyle))
        }
        headingTheme.setTextFontWeightForDesignateHeading(3, parseFontWeight(cfg_heading3TextFontWeight))
        if (cfg_heading3TextFontFamily != "undefined") {
            headingTheme.setTextFontFamilyForDesignateHeading(3, cfg_heading3TextFontFamily)
        }
        if (cfg_heading3TextLineHeight != "undefined") {
            headingTheme.setTextLineHeightForDesignateHeading(3, parseFloat64(cfg_heading3TextLineHeight))
        }
        if (cfg_heading3TextLetterSpacing != "undefined") {
            headingTheme.setTextLetterSpacingForDesignateHeading(3, parseFloat64(cfg_heading3TextLetterSpacing))
        }
        if (cfg_heading3BackgroundColor != "undefined") {
            headingTheme.setBackgroundColorForDesignateHeading(3, parseColor(cfg_heading3BackgroundColor))
        }
        if (cfg_heading3UnderlineColor != "undefined") {
            headingTheme.setUnderlineColorForDesignateHeading(3, parseColor(cfg_heading3UnderlineColor))
        }
        headingTheme.setUnderlineHeightForDesignateHeading(3, parseFloat64(cfg_heading3UnderlineHeight))
        headingTheme.setUnderlineSpacingForDesignateHeading(3, parseFloat64(cfg_heading3UnderlineSpacing))
        if (cfg_heading4TextFontColor != "undefined") {
            headingTheme.setTextFontColorForDesignateHeading(4, parseColor(cfg_heading4TextFontColor))
        }
        if (cfg_heading4TextFontSize != "undefined") {
            headingTheme.setTextFontSizeForDesignateHeading(4, parseFloat64(cfg_heading4TextFontSize))
        }
        if (cfg_heading4TextFontStyle != "undefined") {
            headingTheme.setTextFontStyleForDesignateHeading(4, parseFontStyle(cfg_heading4TextFontStyle))
        }
        headingTheme.setTextFontWeightForDesignateHeading(4, parseFontWeight(cfg_heading4TextFontWeight))
        if (cfg_heading4TextFontFamily != "undefined") {
            headingTheme.setTextFontFamilyForDesignateHeading(4, cfg_heading4TextFontFamily)
        }
        if (cfg_heading4TextLineHeight != "undefined") {
            headingTheme.setTextLineHeightForDesignateHeading(4, parseFloat64(cfg_heading4TextLineHeight))
        }
        if (cfg_heading4TextLetterSpacing != "undefined") {
            headingTheme.setTextLetterSpacingForDesignateHeading(4, parseFloat64(cfg_heading4TextLetterSpacing))
        }
        if (cfg_heading4BackgroundColor != "undefined") {
            headingTheme.setBackgroundColorForDesignateHeading(4, parseColor(cfg_heading4BackgroundColor))
        }
        if (cfg_heading4UnderlineColor != "undefined") {
            headingTheme.setUnderlineColorForDesignateHeading(4, parseColor(cfg_heading4UnderlineColor))
        }
        headingTheme.setUnderlineHeightForDesignateHeading(4, parseFloat64(cfg_heading4UnderlineHeight))
        headingTheme.setUnderlineSpacingForDesignateHeading(4, parseFloat64(cfg_heading4UnderlineSpacing))
        if (cfg_heading5TextFontColor != "undefined") {
            headingTheme.setTextFontColorForDesignateHeading(5, parseColor(cfg_heading5TextFontColor))
        }
        if (cfg_heading5TextFontSize != "undefined") {
            headingTheme.setTextFontSizeForDesignateHeading(5, parseFloat64(cfg_heading5TextFontSize))
        }
        if (cfg_heading5TextFontStyle != "undefined") {
            headingTheme.setTextFontStyleForDesignateHeading(5, parseFontStyle(cfg_heading5TextFontStyle))
        }
        headingTheme.setTextFontWeightForDesignateHeading(5, parseFontWeight(cfg_heading5TextFontWeight))
        if (cfg_heading5TextFontFamily != "undefined") {
            headingTheme.setTextFontFamilyForDesignateHeading(5, cfg_heading5TextFontFamily)
        }
        if (cfg_heading5TextLineHeight != "undefined") {
            headingTheme.setTextLineHeightForDesignateHeading(5, parseFloat64(cfg_heading5TextLineHeight))
        }
        if (cfg_heading5TextLetterSpacing != "undefined") {
            headingTheme.setTextLetterSpacingForDesignateHeading(5, parseFloat64(cfg_heading5TextLetterSpacing))
        }
        if (cfg_heading5BackgroundColor != "undefined") {
            headingTheme.setBackgroundColorForDesignateHeading(5, parseColor(cfg_heading5BackgroundColor))
        }
        if (cfg_heading5UnderlineColor != "undefined") {
            headingTheme.setUnderlineColorForDesignateHeading(5, parseColor(cfg_heading5UnderlineColor))
        }
        headingTheme.setUnderlineHeightForDesignateHeading(5, parseFloat64(cfg_heading5UnderlineHeight))
        headingTheme.setUnderlineSpacingForDesignateHeading(5, parseFloat64(cfg_heading5UnderlineSpacing))
        if (cfg_heading6TextFontColor != "undefined") {
            headingTheme.setTextFontColorForDesignateHeading(6, parseColor(cfg_heading6TextFontColor))
        }
        if (cfg_heading6TextFontSize != "undefined") {
            headingTheme.setTextFontSizeForDesignateHeading(6, parseFloat64(cfg_heading6TextFontSize))
        }
        if (cfg_heading6TextFontStyle != "undefined") {
            headingTheme.setTextFontStyleForDesignateHeading(6, parseFontStyle(cfg_heading6TextFontStyle))
        }
        headingTheme.setTextFontWeightForDesignateHeading(6, parseFontWeight(cfg_heading6TextFontWeight))
        if (cfg_heading6TextFontFamily != "undefined") {
            headingTheme.setTextFontFamilyForDesignateHeading(6, cfg_heading6TextFontFamily)
        }
        if (cfg_heading6TextLineHeight != "undefined") {
            headingTheme.setTextLineHeightForDesignateHeading(6, parseFloat64(cfg_heading6TextLineHeight))
        }
        if (cfg_heading6TextLetterSpacing != "undefined") {
            headingTheme.setTextLetterSpacingForDesignateHeading(6, parseFloat64(cfg_heading6TextLetterSpacing))
        }
        if (cfg_heading6BackgroundColor != "undefined") {
            headingTheme.setBackgroundColorForDesignateHeading(6, parseColor(cfg_heading6BackgroundColor))
        }
        if (cfg_heading6UnderlineColor != "undefined") {
            headingTheme.setUnderlineColorForDesignateHeading(6, parseColor(cfg_heading6UnderlineColor))
        }
        headingTheme.setUnderlineHeightForDesignateHeading(6, parseFloat64(cfg_heading6UnderlineHeight))
        headingTheme.setUnderlineSpacingForDesignateHeading(6, parseFloat64(cfg_heading6UnderlineSpacing))
        headingTheme.setPaddingForDesignateHeading(1, top: parseFloat64(cfg_heading1PaddingTop), right: parseFloat64(cfg_heading1PaddingRight), bottom: parseFloat64(cfg_heading1PaddingBottom), left: parseFloat64(cfg_heading1PaddingLeft))
        headingTheme.setPaddingForDesignateHeading(2, top: parseFloat64(cfg_heading2PaddingTop), right: parseFloat64(cfg_heading2PaddingRight), bottom: parseFloat64(cfg_heading2PaddingBottom), left: parseFloat64(cfg_heading2PaddingLeft))
        headingTheme.setPaddingForDesignateHeading(3, top: parseFloat64(cfg_heading3PaddingTop), right: parseFloat64(cfg_heading3PaddingRight), bottom: parseFloat64(cfg_heading3PaddingBottom), left: parseFloat64(cfg_heading3PaddingLeft))
        headingTheme.setPaddingForDesignateHeading(4, top: parseFloat64(cfg_heading4PaddingTop), right: parseFloat64(cfg_heading4PaddingRight), bottom: parseFloat64(cfg_heading4PaddingBottom), left: parseFloat64(cfg_heading4PaddingLeft))
        headingTheme.setPaddingForDesignateHeading(5, top: parseFloat64(cfg_heading5PaddingTop), right: parseFloat64(cfg_heading5PaddingRight), bottom: parseFloat64(cfg_heading5PaddingBottom), left: parseFloat64(cfg_heading5PaddingLeft))
        headingTheme.setPaddingForDesignateHeading(6, top: parseFloat64(cfg_heading6PaddingTop), right: parseFloat64(cfg_heading6PaddingRight), bottom: parseFloat64(cfg_heading6PaddingBottom), left: parseFloat64(cfg_heading6PaddingLeft))
        headingTheme.setMarginForDesignateHeading(1, top: parseFloat64(cfg_heading1MarginTop), right: parseFloat64(cfg_heading1MarginRight), bottom: parseFloat64(cfg_heading1MarginBottom), left: parseFloat64(cfg_heading1MarginLeft))
        headingTheme.setMarginForDesignateHeading(2, top: parseFloat64(cfg_heading2MarginTop), right: parseFloat64(cfg_heading2MarginRight), bottom: parseFloat64(cfg_heading2MarginBottom), left: parseFloat64(cfg_heading2MarginLeft))
        headingTheme.setMarginForDesignateHeading(3, top: parseFloat64(cfg_heading3MarginTop), right: parseFloat64(cfg_heading3MarginRight), bottom: parseFloat64(cfg_heading3MarginBottom), left: parseFloat64(cfg_heading3MarginLeft))
        headingTheme.setMarginForDesignateHeading(4, top: parseFloat64(cfg_heading4MarginTop), right: parseFloat64(cfg_heading4MarginRight), bottom: parseFloat64(cfg_heading4MarginBottom), left: parseFloat64(cfg_heading4MarginLeft))
        headingTheme.setMarginForDesignateHeading(5, top: parseFloat64(cfg_heading5MarginTop), right: parseFloat64(cfg_heading5MarginRight), bottom: parseFloat64(cfg_heading5MarginBottom), left: parseFloat64(cfg_heading5MarginLeft))
        headingTheme.setMarginForDesignateHeading(6, top: parseFloat64(cfg_heading6MarginTop), right: parseFloat64(cfg_heading6MarginRight), bottom: parseFloat64(cfg_heading6MarginBottom), left: parseFloat64(cfg_heading6MarginLeft))
        themeBuilder.setHeadingTheme(headingTheme)
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
                            Text("一级标题")
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
                                ConfigTabSelector(title: "H1标题文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading1TextFontColor, onSelect: { v => cfg_heading1TextFontColor = v })
                                ConfigTabSelector(title: "H1标题文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading1TextFontSize, onSelect: { v => cfg_heading1TextFontSize = v })
                                ConfigTabSelector(title: "H1标题文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading1TextFontStyle, onSelect: { v => cfg_heading1TextFontStyle = v })
                                ConfigTabSelector(title: "H1标题字体粗细 - ", options: fontWeightList, defaultValue: "Bold", configKey: "", currentValue: cfg_heading1TextFontWeight, onSelect: { v => cfg_heading1TextFontWeight = v })
                                ConfigTabSelector(title: "H1标题字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading1TextFontFamily, onSelect: { v => cfg_heading1TextFontFamily = v })
                                ConfigTabSelector(title: "H1标题文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading1TextLineHeight, onSelect: { v => cfg_heading1TextLineHeight = v })
                                ConfigTabSelector(title: "H1标题文本字符间距 - ", options: textWordSpaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading1TextLetterSpacing, onSelect: { v => cfg_heading1TextLetterSpacing = v })
                                ConfigTabSelector(title: "H1标题背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading1BackgroundColor, onSelect: { v => cfg_heading1BackgroundColor = v })
                                ConfigTabSelector(title: "H1标题下划线颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading1UnderlineColor, onSelect: { v => cfg_heading1UnderlineColor = v })
                                ConfigTabSelector(title: "H1标题下划线高度 - ", options: lineOrBorderWidthList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading1UnderlineHeight, onSelect: { v => cfg_heading1UnderlineHeight = v })
                                ConfigTabSelector(title: "H1标题距离标题文本间距 - ", options: spaceList, defaultValue: "0", configKey: "", currentValue: cfg_heading1UnderlineSpacing, onSelect: { v => cfg_heading1UnderlineSpacing = v })
                                ConfigTabSelector(title: "H1标题上外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading1MarginTop, onSelect: { v => cfg_heading1MarginTop = v })
                                ConfigTabSelector(title: "H1标题右外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading1MarginRight, onSelect: { v => cfg_heading1MarginRight = v })
                                ConfigTabSelector(title: "H1标题下外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading1MarginBottom, onSelect: { v => cfg_heading1MarginBottom = v })
                                ConfigTabSelector(title: "H1标题左外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading1MarginLeft, onSelect: { v => cfg_heading1MarginLeft = v })
                                ConfigTabSelector(title: "H1标题上内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading1PaddingTop, onSelect: { v => cfg_heading1PaddingTop = v })
                                ConfigTabSelector(title: "H1标题右内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading1PaddingRight, onSelect: { v => cfg_heading1PaddingRight = v })
                                ConfigTabSelector(title: "H1标题下内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading1PaddingBottom, onSelect: { v => cfg_heading1PaddingBottom = v })
                                ConfigTabSelector(title: "H1标题左内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading1PaddingLeft, onSelect: { v => cfg_heading1PaddingLeft = v })
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
                            Text("二级标题")
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
                                ConfigTabSelector(title: "H2文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading2TextFontColor, onSelect: { v => cfg_heading2TextFontColor = v })
                                ConfigTabSelector(title: "H2文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading2TextFontSize, onSelect: { v => cfg_heading2TextFontSize = v })
                                ConfigTabSelector(title: "H2文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading2TextFontStyle, onSelect: { v => cfg_heading2TextFontStyle = v })
                                ConfigTabSelector(title: "H2文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_heading2TextFontWeight, onSelect: { v => cfg_heading2TextFontWeight = v })
                                ConfigTabSelector(title: "H2文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading2TextFontFamily, onSelect: { v => cfg_heading2TextFontFamily = v })
                                ConfigTabSelector(title: "H2文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading2TextLineHeight, onSelect: { v => cfg_heading2TextLineHeight = v })
                                ConfigTabSelector(title: "H2文本字符间距 - ", options: textWordSpaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading2TextLetterSpacing, onSelect: { v => cfg_heading2TextLetterSpacing = v })
                                ConfigTabSelector(title: "H2背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading2BackgroundColor, onSelect: { v => cfg_heading2BackgroundColor = v })
                                ConfigTabSelector(title: "H2下划线颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading2UnderlineColor, onSelect: { v => cfg_heading2UnderlineColor = v })
                                ConfigTabSelector(title: "H2下划线高度 - ", options: lineOrBorderWidthList, defaultValue: "0", configKey: "", currentValue: cfg_heading2UnderlineHeight, onSelect: { v => cfg_heading2UnderlineHeight = v })
                                ConfigTabSelector(title: "H2下划线间距 - ", options: spaceList, defaultValue: "0", configKey: "", currentValue: cfg_heading2UnderlineSpacing, onSelect: { v => cfg_heading2UnderlineSpacing = v })
                                ConfigTabSelector(title: "H2上外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading2MarginTop, onSelect: { v => cfg_heading2MarginTop = v })
                                ConfigTabSelector(title: "H2右外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading2MarginRight, onSelect: { v => cfg_heading2MarginRight = v })
                                ConfigTabSelector(title: "H2下外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading2MarginBottom, onSelect: { v => cfg_heading2MarginBottom = v })
                                ConfigTabSelector(title: "H2左外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading2MarginLeft, onSelect: { v => cfg_heading2MarginLeft = v })
                                ConfigTabSelector(title: "H2上内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading2PaddingTop, onSelect: { v => cfg_heading2PaddingTop = v })
                                ConfigTabSelector(title: "H2右内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading2PaddingRight, onSelect: { v => cfg_heading2PaddingRight = v })
                                ConfigTabSelector(title: "H2下内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading2PaddingBottom, onSelect: { v => cfg_heading2PaddingBottom = v })
                                ConfigTabSelector(title: "H2左内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading2PaddingLeft, onSelect: { v => cfg_heading2PaddingLeft = v })
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
                            Text("三级标题")
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
                                ConfigTabSelector(title: "H3文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading3TextFontColor, onSelect: { v => cfg_heading3TextFontColor = v })
                                ConfigTabSelector(title: "H3文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading3TextFontSize, onSelect: { v => cfg_heading3TextFontSize = v })
                                ConfigTabSelector(title: "H3文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading3TextFontStyle, onSelect: { v => cfg_heading3TextFontStyle = v })
                                ConfigTabSelector(title: "H3文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_heading3TextFontWeight, onSelect: { v => cfg_heading3TextFontWeight = v })
                                ConfigTabSelector(title: "H3文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading3TextFontFamily, onSelect: { v => cfg_heading3TextFontFamily = v })
                                ConfigTabSelector(title: "H3文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading3TextLineHeight, onSelect: { v => cfg_heading3TextLineHeight = v })
                                ConfigTabSelector(title: "H3文本字符间距 - ", options: textWordSpaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading3TextLetterSpacing, onSelect: { v => cfg_heading3TextLetterSpacing = v })
                                ConfigTabSelector(title: "H3背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading3BackgroundColor, onSelect: { v => cfg_heading3BackgroundColor = v })
                                ConfigTabSelector(title: "H3下划线颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading3UnderlineColor, onSelect: { v => cfg_heading3UnderlineColor = v })
                                ConfigTabSelector(title: "H3下划线高度 - ", options: lineOrBorderWidthList, defaultValue: "0", configKey: "", currentValue: cfg_heading3UnderlineHeight, onSelect: { v => cfg_heading3UnderlineHeight = v })
                                ConfigTabSelector(title: "H3下划线间距 - ", options: spaceList, defaultValue: "0", configKey: "", currentValue: cfg_heading3UnderlineSpacing, onSelect: { v => cfg_heading3UnderlineSpacing = v })
                                ConfigTabSelector(title: "H3上外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading3MarginTop, onSelect: { v => cfg_heading3MarginTop = v })
                                ConfigTabSelector(title: "H3右外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading3MarginRight, onSelect: { v => cfg_heading3MarginRight = v })
                                ConfigTabSelector(title: "H3下外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading3MarginBottom, onSelect: { v => cfg_heading3MarginBottom = v })
                                ConfigTabSelector(title: "H3左外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading3MarginLeft, onSelect: { v => cfg_heading3MarginLeft = v })
                                ConfigTabSelector(title: "H3上内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading3PaddingTop, onSelect: { v => cfg_heading3PaddingTop = v })
                                ConfigTabSelector(title: "H3右内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading3PaddingRight, onSelect: { v => cfg_heading3PaddingRight = v })
                                ConfigTabSelector(title: "H3下内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading3PaddingBottom, onSelect: { v => cfg_heading3PaddingBottom = v })
                                ConfigTabSelector(title: "H3左内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading3PaddingLeft, onSelect: { v => cfg_heading3PaddingLeft = v })
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
                            Text("四级标题")
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
                                ConfigTabSelector(title: "H4文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading4TextFontColor, onSelect: { v => cfg_heading4TextFontColor = v })
                                ConfigTabSelector(title: "H4文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading4TextFontSize, onSelect: { v => cfg_heading4TextFontSize = v })
                                ConfigTabSelector(title: "H4文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading4TextFontStyle, onSelect: { v => cfg_heading4TextFontStyle = v })
                                ConfigTabSelector(title: "H4文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_heading4TextFontWeight, onSelect: { v => cfg_heading4TextFontWeight = v })
                                ConfigTabSelector(title: "H4文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading4TextFontFamily, onSelect: { v => cfg_heading4TextFontFamily = v })
                                ConfigTabSelector(title: "H4文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading4TextLineHeight, onSelect: { v => cfg_heading4TextLineHeight = v })
                                ConfigTabSelector(title: "H4文本字符间距 - ", options: textWordSpaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading4TextLetterSpacing, onSelect: { v => cfg_heading4TextLetterSpacing = v })
                                ConfigTabSelector(title: "H4背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading4BackgroundColor, onSelect: { v => cfg_heading4BackgroundColor = v })
                                ConfigTabSelector(title: "H4下划线颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading4UnderlineColor, onSelect: { v => cfg_heading4UnderlineColor = v })
                                ConfigTabSelector(title: "H4下划线高度 - ", options: lineOrBorderWidthList, defaultValue: "0", configKey: "", currentValue: cfg_heading4UnderlineHeight, onSelect: { v => cfg_heading4UnderlineHeight = v })
                                ConfigTabSelector(title: "H4下划线间距 - ", options: spaceList, defaultValue: "0", configKey: "", currentValue: cfg_heading4UnderlineSpacing, onSelect: { v => cfg_heading4UnderlineSpacing = v })
                                ConfigTabSelector(title: "H4上外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading4MarginTop, onSelect: { v => cfg_heading4MarginTop = v })
                                ConfigTabSelector(title: "H4右外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading4MarginRight, onSelect: { v => cfg_heading4MarginRight = v })
                                ConfigTabSelector(title: "H4下外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading4MarginBottom, onSelect: { v => cfg_heading4MarginBottom = v })
                                ConfigTabSelector(title: "H4左外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading4MarginLeft, onSelect: { v => cfg_heading4MarginLeft = v })
                                ConfigTabSelector(title: "H4上内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading4PaddingTop, onSelect: { v => cfg_heading4PaddingTop = v })
                                ConfigTabSelector(title: "H4右内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading4PaddingRight, onSelect: { v => cfg_heading4PaddingRight = v })
                                ConfigTabSelector(title: "H4下内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading4PaddingBottom, onSelect: { v => cfg_heading4PaddingBottom = v })
                                ConfigTabSelector(title: "H4左内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading4PaddingLeft, onSelect: { v => cfg_heading4PaddingLeft = v })
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
                            Text("五级标题")
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
                                ConfigTabSelector(title: "H5文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading5TextFontColor, onSelect: { v => cfg_heading5TextFontColor = v })
                                ConfigTabSelector(title: "H5文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading5TextFontSize, onSelect: { v => cfg_heading5TextFontSize = v })
                                ConfigTabSelector(title: "H5文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading5TextFontStyle, onSelect: { v => cfg_heading5TextFontStyle = v })
                                ConfigTabSelector(title: "H5文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_heading5TextFontWeight, onSelect: { v => cfg_heading5TextFontWeight = v })
                                ConfigTabSelector(title: "H5文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading5TextFontFamily, onSelect: { v => cfg_heading5TextFontFamily = v })
                                ConfigTabSelector(title: "H5文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading5TextLineHeight, onSelect: { v => cfg_heading5TextLineHeight = v })
                                ConfigTabSelector(title: "H5文本字符间距 - ", options: textWordSpaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading5TextLetterSpacing, onSelect: { v => cfg_heading5TextLetterSpacing = v })
                                ConfigTabSelector(title: "H5背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading5BackgroundColor, onSelect: { v => cfg_heading5BackgroundColor = v })
                                ConfigTabSelector(title: "H5下划线颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading5UnderlineColor, onSelect: { v => cfg_heading5UnderlineColor = v })
                                ConfigTabSelector(title: "H5下划线高度 - ", options: lineOrBorderWidthList, defaultValue: "0", configKey: "", currentValue: cfg_heading5UnderlineHeight, onSelect: { v => cfg_heading5UnderlineHeight = v })
                                ConfigTabSelector(title: "H5下划线间距 - ", options: spaceList, defaultValue: "0", configKey: "", currentValue: cfg_heading5UnderlineSpacing, onSelect: { v => cfg_heading5UnderlineSpacing = v })
                                ConfigTabSelector(title: "H5上外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading5MarginTop, onSelect: { v => cfg_heading5MarginTop = v })
                                ConfigTabSelector(title: "H5右外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading5MarginRight, onSelect: { v => cfg_heading5MarginRight = v })
                                ConfigTabSelector(title: "H5下外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading5MarginBottom, onSelect: { v => cfg_heading5MarginBottom = v })
                                ConfigTabSelector(title: "H5左外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading5MarginLeft, onSelect: { v => cfg_heading5MarginLeft = v })
                                ConfigTabSelector(title: "H5上内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading5PaddingTop, onSelect: { v => cfg_heading5PaddingTop = v })
                                ConfigTabSelector(title: "H5右内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading5PaddingRight, onSelect: { v => cfg_heading5PaddingRight = v })
                                ConfigTabSelector(title: "H5下内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading5PaddingBottom, onSelect: { v => cfg_heading5PaddingBottom = v })
                                ConfigTabSelector(title: "H5左内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading5PaddingLeft, onSelect: { v => cfg_heading5PaddingLeft = v })
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
                            Text("六级标题")
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
                                ConfigTabSelector(title: "H6文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading6TextFontColor, onSelect: { v => cfg_heading6TextFontColor = v })
                                ConfigTabSelector(title: "H6文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading6TextFontSize, onSelect: { v => cfg_heading6TextFontSize = v })
                                ConfigTabSelector(title: "H6文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading6TextFontStyle, onSelect: { v => cfg_heading6TextFontStyle = v })
                                ConfigTabSelector(title: "H6文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_heading6TextFontWeight, onSelect: { v => cfg_heading6TextFontWeight = v })
                                ConfigTabSelector(title: "H6文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading6TextFontFamily, onSelect: { v => cfg_heading6TextFontFamily = v })
                                ConfigTabSelector(title: "H6文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading6TextLineHeight, onSelect: { v => cfg_heading6TextLineHeight = v })
                                ConfigTabSelector(title: "H6文本字符间距 - ", options: textWordSpaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading6TextLetterSpacing, onSelect: { v => cfg_heading6TextLetterSpacing = v })
                                ConfigTabSelector(title: "H6背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading6BackgroundColor, onSelect: { v => cfg_heading6BackgroundColor = v })
                                ConfigTabSelector(title: "H6下划线颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_heading6UnderlineColor, onSelect: { v => cfg_heading6UnderlineColor = v })
                                ConfigTabSelector(title: "H6下划线高度 - ", options: lineOrBorderWidthList, defaultValue: "0", configKey: "", currentValue: cfg_heading6UnderlineHeight, onSelect: { v => cfg_heading6UnderlineHeight = v })
                                ConfigTabSelector(title: "H6下划线间距 - ", options: spaceList, defaultValue: "0", configKey: "", currentValue: cfg_heading6UnderlineSpacing, onSelect: { v => cfg_heading6UnderlineSpacing = v })
                                ConfigTabSelector(title: "H6上外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading6MarginTop, onSelect: { v => cfg_heading6MarginTop = v })
                                ConfigTabSelector(title: "H6右外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading6MarginRight, onSelect: { v => cfg_heading6MarginRight = v })
                                ConfigTabSelector(title: "H6下外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading6MarginBottom, onSelect: { v => cfg_heading6MarginBottom = v })
                                ConfigTabSelector(title: "H6左外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_heading6MarginLeft, onSelect: { v => cfg_heading6MarginLeft = v })
                                ConfigTabSelector(title: "H6上内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading6PaddingTop, onSelect: { v => cfg_heading6PaddingTop = v })
                                ConfigTabSelector(title: "H6右内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading6PaddingRight, onSelect: { v => cfg_heading6PaddingRight = v })
                                ConfigTabSelector(title: "H6下内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading6PaddingBottom, onSelect: { v => cfg_heading6PaddingBottom = v })
                                ConfigTabSelector(title: "H6左内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_heading6PaddingLeft, onSelect: { v => cfg_heading6PaddingLeft = v })
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
                            Text("特殊设置")
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .fontWeight(FontWeight.Bold)
                                .layoutWeight(1)
                            Text(if (isExpanded8) { "▲" } else { "▼" })
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .padding(right: 20.0)
                                .onClick {
                                    evt => isExpanded8 = !isExpanded8
                                }
                        }
                        .width(100.percent)
                        .padding(5.0)
                        .margin(5.0)
                        .onClick {
                            evt => isExpanded8 = !isExpanded8
                        }

                        if (isExpanded8) {
                            Column {
                                ConfigTabSelector(title: "是否开启标题段落高亮显示 - ", options: booleanList, defaultValue: "true", configKey: "", currentValue: cfg_showHighlight, onSelect: { v => cfg_showHighlight = v })
                                ConfigTabSelector(title: "当前长按未触发弹窗时段落前的背景色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_beforeSelectedParagraphBackgroundColor, onSelect: { v => cfg_beforeSelectedParagraphBackgroundColor = v })
                                ConfigTabSelector(title: "当前长按放手后选中文字的背景色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_selectedParagraphBackgroundColor, onSelect: { v => cfg_selectedParagraphBackgroundColor = v })
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