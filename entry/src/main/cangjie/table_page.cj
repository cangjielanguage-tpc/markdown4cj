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
import ohos.hilog.*

@HybridComponentEntry
@Component
class TablePage {
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
    var isExpanded9: Bool = false
    @State
    var isExpanded10: Bool = false
    @State
    var isExpanded11: Bool = false
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
    @State @Watch[onConfigChanged] var cfg_tableBorderColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableTitleTextFontColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableContentTextFontColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableTitleBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableContentOddRowBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableContentEvenRowBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableStickyHeader: String = "true"
    @State @Watch[onConfigChanged] var cfg_tableFirstColumnIsBold: String = "false"
    @State @Watch[onConfigChanged] var cfg_tableTitleTextFontSize: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableContentTextFontSize: String = "undefined"

    @State @Watch[onConfigChanged] var cfg_tableMarginTop: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableMarginRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableMarginBottom: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableMarginLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_tablePaddingTop: String = "0"
    @State @Watch[onConfigChanged] var cfg_tablePaddingRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_tablePaddingBottom: String = "0"
    @State @Watch[onConfigChanged] var cfg_tablePaddingLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableCellPaddingTop: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableCellPaddingRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableCellPaddingBottom: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableCellPaddingLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableBorderStyle: String = "Solid"
    @State @Watch[onConfigChanged] var cfg_tableBorderWidth: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableRadiusTopLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableRadiusTopRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableRadiusBottomLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableRadiusBottomRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableScrollBarState: String = "Off"
    @State @Watch[onConfigChanged] var cfg_tableScrollBarColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableMinCellWidth: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableMaxCellWidth: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableTitleTextFontStyle: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableTitleTextFontWeight: String = "Normal"
    @State @Watch[onConfigChanged] var cfg_tableTitleTextFontFamily: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableTitleTextLineHeight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableTitleTextLetterSpacing: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableContentTextFontStyle: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableContentTextFontWeight: String = "Normal"
    @State @Watch[onConfigChanged] var cfg_tableContentTextFontFamily: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableContentTextLineHeight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableContentTextLetterSpacing: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableHeadIsShow: String = "false"
    @State @Watch[onConfigChanged] var cfg_tableHeadTitleText: String = "比较"
    @State @Watch[onConfigChanged] var cfg_tableHeadTitleTextMarginLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableHeadCopyIcon: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableHeadCopyIconWidth: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableHeadCopyIconHeight: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableHeadCopyIconMarginRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_tableHeadTitleTextFontColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableHeadTitleTextFontSize: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableHeadTitleTextFontStyle: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableHeadTitleTextFontWeight: String = "Normal"
    @State @Watch[onConfigChanged] var cfg_tableHeadTitleTextFontFamily: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_tableHeadTitleTextLineHeight: String = "undefined"
    var arr: Array<Rune> = Array<Rune>()
    var scroller: Scroller = Scroller()
    var outerScroller: Scroller = Scroller() // 外层Scroll的Scroller（用于非固定高度模式下传递滚动Y给MarkdownComponent）
    let mdScrollController = MarkdownScrollController() // 外层滚动控制器（非固定高度模式下传递滚动Y给MarkdownComponent）
    var contentHeight: Float64 = 0.0 // Scroll内容高度（Column高度，用于clamp scrollY）
    var viewportHeight: Float64 = 0.0 // Scroll视口高度（用于clamp scrollY）
    var markdownStartY: Float64 = 0.0 // MarkdownComponent顶部在Scroll内容中的绝对Y（layout-time常量，= markdownContainerY + markdownOffsetY）
    var markdownContainerY: Float64 = 0.0 // 外层Column在Scroll内容中的Y（onAreaChange获取，layout-time常量）
    var markdownOffsetY: Float64 = 0.0 // MarkdownComponent包装Column相对外层Column的Y（含padding+预计算高度Text块，onAreaChange获取）
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

        let tableTheme = theme.getTableTheme()
        if (cfg_tableBorderColor != "undefined") {
            tableTheme.setTableBorderColor(parseColor(cfg_tableBorderColor))
        }
        if (cfg_tableTitleTextFontColor != "undefined") {
            tableTheme.setTableTitleTextFontColor(parseColor(cfg_tableTitleTextFontColor))
        }
        if (cfg_tableContentTextFontColor != "undefined") {
            tableTheme.setTableContentTextFontColor(parseColor(cfg_tableContentTextFontColor))
        }
        if (cfg_tableTitleBackgroundColor != "undefined") {
            tableTheme.setTableTitleBackgroundColor(parseColor(cfg_tableTitleBackgroundColor))
        }
        if (cfg_tableContentOddRowBackgroundColor != "undefined") {
            tableTheme.setTableContentOddRowBackgroundColor(parseColor(cfg_tableContentOddRowBackgroundColor))
        }
        if (cfg_tableContentEvenRowBackgroundColor != "undefined") {
            tableTheme.setTableContentEvenRowBackgroundColor(parseColor(cfg_tableContentEvenRowBackgroundColor))
        }
        tableTheme.setTableStickyHeader(parseBool(cfg_tableStickyHeader))
        tableTheme.setTableFirstColumnIsBold(parseBool(cfg_tableFirstColumnIsBold))
        if (cfg_tableTitleTextFontSize != "undefined") {
            tableTheme.setTableTitleTextFontSize(parseFloat64(cfg_tableTitleTextFontSize))
        }
        if (cfg_tableContentTextFontSize != "undefined") {
            tableTheme.setTableContentTextFontSize(parseFloat64(cfg_tableContentTextFontSize))
        }
        tableTheme.setTableBorderStyle(parseBorderStyle(cfg_tableBorderStyle))
        let tableBorderWidth = parseFloat64(cfg_tableBorderWidth)
        if (tableBorderWidth > 0.0) {
            tableTheme.setTableBorderWidth(tableBorderWidth)
        }
        tableTheme.setTableScrollBarState(parseBarState(cfg_tableScrollBarState))
        if (cfg_tableScrollBarColor != "undefined") {
            tableTheme.setTableScrollBarColor(parseColor(cfg_tableScrollBarColor))
        }
        let minCellWidth = parseFloat64(cfg_tableMinCellWidth)
        if (minCellWidth > 0.0) {
            tableTheme.setTableMinCellWidth(minCellWidth)
        }
        let maxCellWidth = parseFloat64(cfg_tableMaxCellWidth)
        if (maxCellWidth > 0.0) {
            tableTheme.setTableMaxCellWidth(maxCellWidth)
        }
        if (cfg_tableTitleTextFontStyle != "undefined") {
            tableTheme.setTableTitleTextFontStyle(parseFontStyle(cfg_tableTitleTextFontStyle))
        }
        tableTheme.setTableTitleTextFontWeight(parseFontWeight(cfg_tableTitleTextFontWeight))
        if (cfg_tableTitleTextFontFamily != "undefined") {
            tableTheme.setTableTitleTextFontFamily(cfg_tableTitleTextFontFamily)
        }
        if (cfg_tableTitleTextLineHeight != "undefined") {
            tableTheme.setTableTitleTextLineHeight(parseFloat64(cfg_tableTitleTextLineHeight))
        }
        if (cfg_tableTitleTextLetterSpacing != "undefined") {
            tableTheme.setTableTitleTextLetterSpacing(parseFloat64(cfg_tableTitleTextLetterSpacing))
        }
        if (cfg_tableContentTextFontStyle != "undefined") {
            tableTheme.setTableContentTextFontStyle(parseFontStyle(cfg_tableContentTextFontStyle))
        }
        tableTheme.setTableContentTextFontWeight(parseFontWeight(cfg_tableContentTextFontWeight))
        if (cfg_tableContentTextFontFamily != "undefined") {
            tableTheme.setTableContentTextFontFamily(cfg_tableContentTextFontFamily)
        }
        if (cfg_tableContentTextLineHeight != "undefined") {
            tableTheme.setTableContentTextLineHeight(parseFloat64(cfg_tableContentTextLineHeight))
        }
        if (cfg_tableContentTextLetterSpacing != "undefined") {
            tableTheme.setTableContentTextLetterSpacing(parseFloat64(cfg_tableContentTextLetterSpacing))
        }
        tableTheme.setTableHeadIsShow(parseBool(cfg_tableHeadIsShow))
        tableTheme.setTableHeadTitleText(cfg_tableHeadTitleText)
        tableTheme.setTableHeadTitleTextMarginLeft(parseFloat64(cfg_tableHeadTitleTextMarginLeft))
        if (let Some(v) <- parseAppResource(cfg_tableHeadCopyIcon)) {
            tableTheme.setTableHeadCopyIcon(v)
        }
        tableTheme.setTableHeadCopyIconWidth(parseFloat64(cfg_tableHeadCopyIconWidth))
        tableTheme.setTableHeadCopyIconHeight(parseFloat64(cfg_tableHeadCopyIconHeight))
        tableTheme.setTableHeadCopyIconMarginRight(parseFloat64(cfg_tableHeadCopyIconMarginRight))
        if (cfg_tableHeadTitleTextFontColor != "undefined") {
            tableTheme.setTableHeadTitleTextFontColor(parseColor(cfg_tableHeadTitleTextFontColor))
        }
        if (cfg_tableHeadTitleTextFontSize != "undefined") {
            tableTheme.setTableHeadTitleTextFontSize(parseFloat64(cfg_tableHeadTitleTextFontSize))
        }
        if (cfg_tableHeadTitleTextFontStyle != "undefined") {
            tableTheme.setTableHeadTitleTextFontStyle(parseFontStyle(cfg_tableHeadTitleTextFontStyle))
        }
        tableTheme.setTableHeadTitleTextFontWeight(parseFontWeight(cfg_tableHeadTitleTextFontWeight))
        if (cfg_tableHeadTitleTextFontFamily != "undefined") {
            tableTheme.setTableHeadTitleTextFontFamily(cfg_tableHeadTitleTextFontFamily)
        }
        if (cfg_tableHeadTitleTextLineHeight != "undefined") {
            tableTheme.setTableHeadTitleTextLineHeight(parseFloat64(cfg_tableHeadTitleTextLineHeight))
        }
        let tableRadiusTopLeft = parseFloat64(cfg_tableRadiusTopLeft)
        let tableRadiusTopRight = parseFloat64(cfg_tableRadiusTopRight)
        let tableRadiusBottomLeft = parseFloat64(cfg_tableRadiusBottomLeft)
        let tableRadiusBottomRight = parseFloat64(cfg_tableRadiusBottomRight)
        // 当值为0时不设置，使用TableTheme默认值5.0
        if (tableRadiusTopLeft > 0.0 || tableRadiusTopRight > 0.0 || tableRadiusBottomLeft > 0.0 || tableRadiusBottomRight > 0.0) {
            tableTheme.setTableRadius(topLeft: tableRadiusTopLeft, topRight: tableRadiusTopRight, bottomLeft: tableRadiusBottomLeft, bottomRight: tableRadiusBottomRight)
        }
        tableTheme.setTablePadding(top: parseFloat64(cfg_tablePaddingTop), right: parseFloat64(cfg_tablePaddingRight), bottom: parseFloat64(cfg_tablePaddingBottom), left: parseFloat64(cfg_tablePaddingLeft))
        tableTheme.setTableCellPadding(top: parseFloat64(cfg_tableCellPaddingTop), right: parseFloat64(cfg_tableCellPaddingRight), bottom: parseFloat64(cfg_tableCellPaddingBottom), left: parseFloat64(cfg_tableCellPaddingLeft))
        tableTheme.setTableMargin(top: parseFloat64(cfg_tableMarginTop), right: parseFloat64(cfg_tableMarginRight), bottom: parseFloat64(cfg_tableMarginBottom), left: parseFloat64(cfg_tableMarginLeft))

        markdownConfiguration.setTableCopyCallback(tableString)
        // 非固定高度模式下，传递外层滚动控制器给MarkdownComponent，用于表格吸顶
        if (!parseBool(cfg_openGestureSwipe)) {
            markdownConfiguration.setScrollController(mdScrollController)
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

            Scroll(outerScroller) {
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
                            Text("边距设置")
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
                                ConfigTabSelector(title: "表格上外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_tableMarginTop, onSelect: { v => cfg_tableMarginTop = v })
                                ConfigTabSelector(title: "表格右外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_tableMarginRight, onSelect: { v => cfg_tableMarginRight = v })
                                ConfigTabSelector(title: "表格下外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_tableMarginBottom, onSelect: { v => cfg_tableMarginBottom = v })
                                ConfigTabSelector(title: "表格左外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_tableMarginLeft, onSelect: { v => cfg_tableMarginLeft = v })
                                ConfigTabSelector(title: "表格上内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_tablePaddingTop, onSelect: { v => cfg_tablePaddingTop = v })
                                ConfigTabSelector(title: "表格右内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_tablePaddingRight, onSelect: { v => cfg_tablePaddingRight = v })
                                ConfigTabSelector(title: "表格下内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_tablePaddingBottom, onSelect: { v => cfg_tablePaddingBottom = v })
                                ConfigTabSelector(title: "表格左内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_tablePaddingLeft, onSelect: { v => cfg_tablePaddingLeft = v })
                                ConfigTabSelector(title: "表格单元格上外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_tableCellPaddingTop, onSelect: { v => cfg_tableCellPaddingTop = v })
                                ConfigTabSelector(title: "表格单元格右外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_tableCellPaddingRight, onSelect: { v => cfg_tableCellPaddingRight = v })
                                ConfigTabSelector(title: "表格单元格下外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_tableCellPaddingBottom, onSelect: { v => cfg_tableCellPaddingBottom = v })
                                ConfigTabSelector(title: "表格单元格左外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_tableCellPaddingLeft, onSelect: { v => cfg_tableCellPaddingLeft = v })
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
                            Text("边框设置")
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
                                ConfigTabSelector(title: "表格边框颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableBorderColor, onSelect: { v => cfg_tableBorderColor = v })
                                ConfigTabSelector(title: "表格边框样式 - ", options: borderStyleList, defaultValue: "Solid", configKey: "", currentValue: cfg_tableBorderStyle, onSelect: { v => cfg_tableBorderStyle = v })
                                ConfigTabSelector(title: "表格边框宽度 - ", options: lineOrBorderWidthList, defaultValue: "0", configKey: "", currentValue: cfg_tableBorderWidth, onSelect: { v => cfg_tableBorderWidth = v })
                                ConfigTabSelector(title: "表格圆角左上圆角 - ", options: radiusList, defaultValue: "0", configKey: "", currentValue: cfg_tableRadiusTopLeft, onSelect: { v => cfg_tableRadiusTopLeft = v })
                                ConfigTabSelector(title: "表格圆角右上圆角 - ", options: radiusList, defaultValue: "0", configKey: "", currentValue: cfg_tableRadiusTopRight, onSelect: { v => cfg_tableRadiusTopRight = v })
                                ConfigTabSelector(title: "表格圆角左下圆角 - ", options: radiusList, defaultValue: "0", configKey: "", currentValue: cfg_tableRadiusBottomLeft, onSelect: { v => cfg_tableRadiusBottomLeft = v })
                                ConfigTabSelector(title: "表格圆角右下圆角 - ", options: radiusList, defaultValue: "0", configKey: "", currentValue: cfg_tableRadiusBottomRight, onSelect: { v => cfg_tableRadiusBottomRight = v })
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
                            Text("滚动条和其他设置")
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
                                ConfigTabSelector(title: "表格首列加粗 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_tableFirstColumnIsBold, onSelect: { v => cfg_tableFirstColumnIsBold = v })
                                ConfigTabSelector(title: "表格滚动条状态 - ", options: barStateList, defaultValue: "Off", configKey: "", currentValue: cfg_tableScrollBarState, onSelect: { v => cfg_tableScrollBarState = v })
                                ConfigTabSelector(title: "表格滚动条颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableScrollBarColor, onSelect: { v => cfg_tableScrollBarColor = v })
                                ConfigTabSelector(title: "表格最小单元格宽度 - ", options: widthOrHeightList, defaultValue: "0", configKey: "", currentValue: cfg_tableMinCellWidth, onSelect: { v => cfg_tableMinCellWidth = v })
                                ConfigTabSelector(title: "表格最大单元格宽度 - ", options: widthOrHeightList, defaultValue: "0", configKey: "", currentValue: cfg_tableMaxCellWidth, onSelect: { v => cfg_tableMaxCellWidth = v })
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
                            Text("标题文本设置")
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
                                ConfigTabSelector(title: "表格标题文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableTitleTextFontColor, onSelect: { v => cfg_tableTitleTextFontColor = v })
                                ConfigTabSelector(title: "表格标题文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableTitleTextFontSize, onSelect: { v => cfg_tableTitleTextFontSize = v })
                                ConfigTabSelector(title: "表格标题文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableTitleTextFontStyle, onSelect: { v => cfg_tableTitleTextFontStyle = v })
                                ConfigTabSelector(title: "表格标题文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_tableTitleTextFontWeight, onSelect: { v => cfg_tableTitleTextFontWeight = v })
                                ConfigTabSelector(title: "表格标题文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableTitleTextFontFamily, onSelect: { v => cfg_tableTitleTextFontFamily = v })
                                ConfigTabSelector(title: "表格标题文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableTitleTextLineHeight, onSelect: { v => cfg_tableTitleTextLineHeight = v })
                                ConfigTabSelector(title: "表格标题文本字符间距 - ", options: textWordSpaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableTitleTextLetterSpacing, onSelect: { v => cfg_tableTitleTextLetterSpacing = v })
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
                            Text("内容文本设置")
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
                                ConfigTabSelector(title: "表格内容文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableContentTextFontColor, onSelect: { v => cfg_tableContentTextFontColor = v })
                                ConfigTabSelector(title: "表格内容文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableContentTextFontSize, onSelect: { v => cfg_tableContentTextFontSize = v })
                                ConfigTabSelector(title: "表格内容文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableContentTextFontStyle, onSelect: { v => cfg_tableContentTextFontStyle = v })
                                ConfigTabSelector(title: "表格内容文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_tableContentTextFontWeight, onSelect: { v => cfg_tableContentTextFontWeight = v })
                                ConfigTabSelector(title: "表格内容文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableContentTextFontFamily, onSelect: { v => cfg_tableContentTextFontFamily = v })
                                ConfigTabSelector(title: "表格内容文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableContentTextLineHeight, onSelect: { v => cfg_tableContentTextLineHeight = v })
                                ConfigTabSelector(title: "表格内容文本字符间距 - ", options: textWordSpaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableContentTextLetterSpacing, onSelect: { v => cfg_tableContentTextLetterSpacing = v })
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
                            Text("吸顶设置")
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
                                ConfigTabSelector(title: "表格表头吸顶 - ", options: booleanList, defaultValue: "true", configKey: "", currentValue: cfg_tableStickyHeader, onSelect: { v => cfg_tableStickyHeader = v })
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
                            Text("表格复制栏设置")
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
                                ConfigTabSelector(title: "表格头部是否显示 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_tableHeadIsShow, onSelect: { v => cfg_tableHeadIsShow = v })
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
                            Text("表头标题文本设置")
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .fontWeight(FontWeight.Bold)
                                .layoutWeight(1)
                            Text(if (isExpanded9) { "▲" } else { "▼" })
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .padding(right: 20.0)
                                .onClick {
                                    evt => isExpanded9 = !isExpanded9
                                }
                        }
                        .width(100.percent)
                        .padding(5.0)
                        .margin(5.0)
                        .onClick {
                            evt => isExpanded9 = !isExpanded9
                        }

                        if (isExpanded9) {
                            Column {
                                ConfigTabSelector(title: "表格头部标题文本 - ", options: tableHeadTitleTextList, defaultValue: "比较", configKey: "", currentValue: cfg_tableHeadTitleText, onSelect: { v => cfg_tableHeadTitleText = v })
                                ConfigTabSelector(title: "表格头部标题文本左外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_tableHeadTitleTextMarginLeft, onSelect: { v => cfg_tableHeadTitleTextMarginLeft = v })
                                ConfigTabSelector(title: "表头标题文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableHeadTitleTextFontColor, onSelect: { v => cfg_tableHeadTitleTextFontColor = v })
                                ConfigTabSelector(title: "表头标题文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableHeadTitleTextFontSize, onSelect: { v => cfg_tableHeadTitleTextFontSize = v })
                                ConfigTabSelector(title: "表头标题文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableHeadTitleTextFontStyle, onSelect: { v => cfg_tableHeadTitleTextFontStyle = v })
                                ConfigTabSelector(title: "表头标题文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_tableHeadTitleTextFontWeight, onSelect: { v => cfg_tableHeadTitleTextFontWeight = v })
                                ConfigTabSelector(title: "表头标题文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableHeadTitleTextFontFamily, onSelect: { v => cfg_tableHeadTitleTextFontFamily = v })
                                ConfigTabSelector(title: "表头标题文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableHeadTitleTextLineHeight, onSelect: { v => cfg_tableHeadTitleTextLineHeight = v })
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
                            Text("表头复制文本设置")
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .fontWeight(FontWeight.Bold)
                                .layoutWeight(1)
                            Text(if (isExpanded10) { "▲" } else { "▼" })
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .padding(right: 20.0)
                                .onClick {
                                    evt => isExpanded10 = !isExpanded10
                                }
                        }
                        .width(100.percent)
                        .padding(5.0)
                        .margin(5.0)
                        .onClick {
                            evt => isExpanded10 = !isExpanded10
                        }

                        if (isExpanded10) {
                            Column {
                                ConfigTabSelector(title: "表格头复制图标 - ", options: iconShortList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableHeadCopyIcon, onSelect: { v => cfg_tableHeadCopyIcon = v })
                                ConfigTabSelector(title: "表格头部复制图标宽度 - ", options: widthOrHeightList, defaultValue: "0", configKey: "", currentValue: cfg_tableHeadCopyIconWidth, onSelect: { v => cfg_tableHeadCopyIconWidth = v })
                                ConfigTabSelector(title: "表格头部复制图标高度 - ", options: widthOrHeightList, defaultValue: "0", configKey: "", currentValue: cfg_tableHeadCopyIconHeight, onSelect: { v => cfg_tableHeadCopyIconHeight = v })
                                ConfigTabSelector(title: "表格头部复制图标右外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_tableHeadCopyIconMarginRight, onSelect: { v => cfg_tableHeadCopyIconMarginRight = v })
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
                            Text("背景设置")
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .fontWeight(FontWeight.Bold)
                                .layoutWeight(1)
                            Text(if (isExpanded11) { "▲" } else { "▼" })
                                .fontSize(16.0)
                                .fontColor(0xFFF5F5F5)
                                .padding(right: 20.0)
                                .onClick {
                                    evt => isExpanded11 = !isExpanded11
                                }
                        }
                        .width(100.percent)
                        .padding(5.0)
                        .margin(5.0)
                        .onClick {
                            evt => isExpanded11 = !isExpanded11
                        }

                        if (isExpanded11) {
                            Column {
                                ConfigTabSelector(title: "表格标题背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableTitleBackgroundColor, onSelect: { v => cfg_tableTitleBackgroundColor = v })
                                ConfigTabSelector(title: "表格奇数行背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableContentOddRowBackgroundColor, onSelect: { v => cfg_tableContentOddRowBackgroundColor = v })
                                ConfigTabSelector(title: "表格偶数行背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_tableContentEvenRowBackgroundColor, onSelect: { v => cfg_tableContentEvenRowBackgroundColor = v })
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
                        if (parseBool(cfg_openGestureSwipe)){
                            Column {
                                Text("preMarkwonHeightByNode 估算: " + estimatedHeightByNode.toString() + " vp")
                                    .fontSize(12.0)
                                    .fontColor(0xFF666666)
                                    .margin(top: 3.0, left: 5.0)
                                Column {
                                    MarkdownComponent(
                                        output: mdStr,
                                        isInputEnded: isInputEnded,
                                        incrementalAnalysis: incrementalAnalysis,
                                        scroller: scroller,
                                        markdownConfiguration: markdownConfiguration
                                    )
                                }
                                .width(100.percent)
                                .onAreaChange({
                                    old, new =>
                                        // wrapper相对外层Column的Y（已含padding+预计算高度Text块）
                                        markdownOffsetY = new.position.y
                                        markdownStartY = markdownContainerY + markdownOffsetY
                                        println("[STICKY-AREA] fixed-height wrapper position.y=${new.position.y} markdownStartY=${markdownStartY}")
                                })
                            }
                            .width(100.percent)
                            .height(600.0)
                            .padding(5.0)
                            .backgroundColor(0xFFFFFFFF)
                            .onAreaChange({
                                old, new =>
                                    // 外层Column在Scroll内容中的绝对Y
                                    markdownContainerY = new.position.y
                                    markdownStartY = markdownContainerY + markdownOffsetY
                                    println("[STICKY-AREA] fixed-height outer position.y=${new.position.y} markdownStartY=${markdownStartY}")
                            })
                        } else {
                            Column {
                                Text("preMarkwonHeightByNode 估算: " + estimatedHeightByNode.toString() + " vp")
                                    .fontSize(12.0)
                                    .fontColor(0xFF666666)
                                    .margin(top: 3.0, left: 5.0)
                                Column {
                                    MarkdownComponent(
                                        output: mdStr,
                                        isInputEnded: isInputEnded,
                                        incrementalAnalysis: incrementalAnalysis,
                                        scroller: scroller,
                                        markdownConfiguration: markdownConfiguration
                                    )
                                }
                                .width(100.percent)
                                .onAreaChange({
                                    old, new =>
                                        markdownOffsetY = new.position.y
                                        markdownStartY = markdownContainerY + markdownOffsetY
                                        println("[STICKY-AREA] non-fixed-height wrapper position.y=${new.position.y} markdownStartY=${markdownStartY}")
                                })
                            }
                            .width(100.percent)
                            .padding(5.0)
                            .backgroundColor(0xFFFFFFFF)
                            .onAreaChange({
                                old, new =>
                                    markdownContainerY = new.position.y
                                    markdownStartY = markdownContainerY + markdownOffsetY
                                    println("[STICKY-AREA] non-fixed-height outer position.y=${new.position.y} markdownStartY=${markdownStartY}")
                            })
                        }
                    }
                }
                .justifyContent(FlexAlign.Start)
                .onAreaChange({
                    old, new =>
                        contentHeight = new.height
                })
            }
            .scrollable(ScrollDirection.Vertical)
            .align(Alignment.Top)
            .edgeEffect(EdgeEffect.None)
            .layoutWeight(1)
            .onAreaChange({
                old, new =>
                    viewportHeight = new.height
            })
            .onScrollFrameBegin({
                offset: Float64, state: ScrollState =>
                    var newY = outerScroller.currentOffset().yOffset + offset
                    if (newY < 0.0) {
                        newY = 0.0
                    }
                    let maxScrollY = if (contentHeight > viewportHeight) {
                        contentHeight - viewportHeight
                    } else {
                        0.0
                    }
                    if (maxScrollY > 0.0 && newY > maxScrollY) {
                        newY = maxScrollY
                    }
                    // 传递relativeScrollY = scrollY - markdownStartY
                    // （markdown起点已滚出视口顶部的距离；<0表示markdown尚未到达视口顶部）
                    let relScrollY = newY - markdownStartY
                    if (relScrollY > 0.0) {
                        println("[STICKY-PAGE] newY=${newY} markdownStartY=${markdownStartY} relScrollY=${relScrollY}")
                    }
                    mdScrollController.notifyScrollY(relScrollY)
                    offset
            })
        }
        .width(100.percent)
        .layoutWeight(1)
        .backgroundColor(0xFFEAEAEA)
        .justifyContent(FlexAlign.Start)
    }

    func tableString(str: String): Unit {
        Hilog.error(1, "1", "---------str:${str}")
    }
}