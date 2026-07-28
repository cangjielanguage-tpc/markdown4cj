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
class ListPage {
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
    @State @Watch[onConfigChanged] var cfg_orderedListMarkerTextFontColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_orderedListMarkerTextFontSize: String = "undefined"

    @State @Watch[onConfigChanged] var cfg_orderedListBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_orderedListMarginTop: String = "0"
    @State @Watch[onConfigChanged] var cfg_orderedListMarginRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_orderedListMarginBottom: String = "0"
    @State @Watch[onConfigChanged] var cfg_orderedListMarginLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_orderedListPaddingTop: String = "0"
    @State @Watch[onConfigChanged] var cfg_orderedListPaddingRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_orderedListPaddingBottom: String = "0"
    @State @Watch[onConfigChanged] var cfg_orderedListPaddingLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_orderedListChildSpacing: String = "0"
    @State @Watch[onConfigChanged] var cfg_orderedListChildChildSpacing: String = "0"
    @State @Watch[onConfigChanged] var cfg_orderedListMarkerSpacing: String = "0"
    @State @Watch[onConfigChanged] var cfg_orderedListMarkerTextFontStyle: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_orderedListMarkerTextFontWeight: String = "Normal"
    @State @Watch[onConfigChanged] var cfg_orderedListMarkerTextFontFamily: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_orderedListMarkerTextLineHeight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_bulletListBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_bulletListMarginTop: String = "0"
    @State @Watch[onConfigChanged] var cfg_bulletListMarginRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_bulletListMarginBottom: String = "0"
    @State @Watch[onConfigChanged] var cfg_bulletListMarginLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_bulletListPaddingTop: String = "0"
    @State @Watch[onConfigChanged] var cfg_bulletListPaddingRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_bulletListPaddingBottom: String = "0"
    @State @Watch[onConfigChanged] var cfg_bulletListPaddingLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_bulletListChildSpacing: String = "0"
    @State @Watch[onConfigChanged] var cfg_bulletListChildChildSpacing: String = "0"
    @State @Watch[onConfigChanged] var cfg_bulletListBulletSpacing: String = "0"
    @State @Watch[onConfigChanged] var cfg_bulletListBulletIsCircle: String = "false"
    @State @Watch[onConfigChanged] var cfg_bulletListBulletTextFontColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_bulletListBulletTextFontSize: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_bulletListBulletTextFontStyle: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_bulletListBulletTextFontWeight: String = "Normal"
    @State @Watch[onConfigChanged] var cfg_bulletListBulletTextFontFamily: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_bulletListBulletTextLineHeight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_bulletListCheckboxSpacing: String = "0"
    @State @Watch[onConfigChanged] var cfg_bulletListCheckboxWidth: String = "0"
    @State @Watch[onConfigChanged] var cfg_bulletListCheckboxHeight: String = "0"
    @State @Watch[onConfigChanged] var cfg_bulletListCheckboxSelectedColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_bulletListCheckboxShape: String = "ROUNDED_SQUARE"
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
        isInputEnded = isFull
        if (isFull) {
            mdStr = fullContent
            estimatedHeightByNode = preMarkwonHeightByNode(fullContent, markdownConfiguration, markdownPlugin, componentWidth: getMarkdownComponentWidth(paddingH: 5.0))
        } else {
            mdStr = ""
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

        let orderedListTheme = theme.getOrderedListTheme()
        if (cfg_orderedListMarkerTextFontColor != "undefined") {
            orderedListTheme.setOrderedListMarkerTextFontColor(parseColor(cfg_orderedListMarkerTextFontColor))
        }
        if (cfg_orderedListMarkerTextFontSize != "undefined") {
            orderedListTheme.setOrderedListMarkerTextFontSize(parseFloat64(cfg_orderedListMarkerTextFontSize))
        }
        if (cfg_orderedListBackgroundColor != "undefined") {
            orderedListTheme.setOrderedListBackgroundColor(parseColor(cfg_orderedListBackgroundColor))
        }
        orderedListTheme.setOrderedListChildSpacing(parseInt64(cfg_orderedListChildSpacing))
        orderedListTheme.setOrderedListChildChildSpacing(parseInt64(cfg_orderedListChildChildSpacing))
        orderedListTheme.setOrderedListMarkerSpacing(parseFloat64(cfg_orderedListMarkerSpacing))
        if (cfg_orderedListMarkerTextFontStyle != "undefined") {
            orderedListTheme.setOrderedListMarkerTextFontStyle(parseFontStyle(cfg_orderedListMarkerTextFontStyle))
        }
        orderedListTheme.setOrderedListMarkerTextFontWeight(parseFontWeight(cfg_orderedListMarkerTextFontWeight))
        if (cfg_orderedListMarkerTextFontFamily != "undefined") {
            orderedListTheme.setOrderedListMarkerTextFontFamily(cfg_orderedListMarkerTextFontFamily)
        }
        if (cfg_orderedListMarkerTextLineHeight != "undefined") {
            orderedListTheme.setOrderedListMarkerTextLineHeight(parseFloat64(cfg_orderedListMarkerTextLineHeight))
        }
        orderedListTheme.setOrderedListMargin(top: parseFloat64(cfg_orderedListMarginTop), right: parseFloat64(cfg_orderedListMarginRight), bottom: parseFloat64(cfg_orderedListMarginBottom), left: parseFloat64(cfg_orderedListMarginLeft))
        orderedListTheme.setOrderedListPadding(top: parseFloat64(cfg_orderedListPaddingTop), right: parseFloat64(cfg_orderedListPaddingRight), bottom: parseFloat64(cfg_orderedListPaddingBottom), left: parseFloat64(cfg_orderedListPaddingLeft))

        let bulletListTheme = theme.getBulletListTheme()
        if (cfg_bulletListBackgroundColor != "undefined") {
            bulletListTheme.setBulletListBackgroundColor(parseColor(cfg_bulletListBackgroundColor))
        }
        bulletListTheme.setBulletListChildSpacing(parseInt64(cfg_bulletListChildSpacing))
        bulletListTheme.setBulletListChildChildSpacing(parseInt64(cfg_bulletListChildChildSpacing))
        bulletListTheme.setBulletListBulletSpacing(parseFloat64(cfg_bulletListBulletSpacing))
        bulletListTheme.setBulletListBulletIsCircle(parseBool(cfg_bulletListBulletIsCircle))
        if (cfg_bulletListBulletTextFontColor != "undefined") {
            bulletListTheme.setBulletListBulletTextFontColor(parseColor(cfg_bulletListBulletTextFontColor))
        }
        if (cfg_bulletListBulletTextFontSize != "undefined") {
            bulletListTheme.setBulletListBulletTextFontSize(parseFloat64(cfg_bulletListBulletTextFontSize))
        }
        if (cfg_bulletListBulletTextFontStyle != "undefined") {
            bulletListTheme.setBulletListBulletTextFontStyle(parseFontStyle(cfg_bulletListBulletTextFontStyle))
        }
        bulletListTheme.setBulletListBulletTextFontWeight(parseFontWeight(cfg_bulletListBulletTextFontWeight))
        if (cfg_bulletListBulletTextFontFamily != "undefined") {
            bulletListTheme.setBulletListBulletTextFontFamily(cfg_bulletListBulletTextFontFamily)
        }
        if (cfg_bulletListBulletTextLineHeight != "undefined") {
            bulletListTheme.setBulletListBulletTextLineHeight(parseFloat64(cfg_bulletListBulletTextLineHeight))
        }
        bulletListTheme.setBulletListCheckboxSpacing(parseFloat64(cfg_bulletListCheckboxSpacing))
        bulletListTheme.setBulletListCheckboxWidth(parseFloat64(cfg_bulletListCheckboxWidth))
        bulletListTheme.setBulletListCheckboxHeight(parseFloat64(cfg_bulletListCheckboxHeight))
        if (cfg_bulletListCheckboxSelectedColor != "undefined") {
            bulletListTheme.setBulletListCheckboxSelectedColor(parseColor(cfg_bulletListCheckboxSelectedColor))
        }
        bulletListTheme.setBulletListCheckboxShape(parseCheckBoxShape(cfg_bulletListCheckboxShape))
        bulletListTheme.setBulletListMargin(top: parseFloat64(cfg_bulletListMarginTop), right: parseFloat64(cfg_bulletListMarginRight), bottom: parseFloat64(cfg_bulletListMarginBottom), left: parseFloat64(cfg_bulletListMarginLeft))
        bulletListTheme.setBulletListPadding(top: parseFloat64(cfg_bulletListPaddingTop), right: parseFloat64(cfg_bulletListPaddingRight), bottom: parseFloat64(cfg_bulletListPaddingBottom), left: parseFloat64(cfg_bulletListPaddingLeft))
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
                            Text("有序列表设置")
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
                                ConfigTabSelector(title: "有序列表标记文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_orderedListMarkerTextFontColor, onSelect: { v => cfg_orderedListMarkerTextFontColor = v })
                                ConfigTabSelector(title: "有序列表标记文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_orderedListMarkerTextFontSize, onSelect: { v => cfg_orderedListMarkerTextFontSize = v })
                                ConfigTabSelector(title: "有序列表背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_orderedListBackgroundColor, onSelect: { v => cfg_orderedListBackgroundColor = v })
                                ConfigTabSelector(title: "有序列表上外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_orderedListMarginTop, onSelect: { v => cfg_orderedListMarginTop = v })
                                ConfigTabSelector(title: "有序列表右外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_orderedListMarginRight, onSelect: { v => cfg_orderedListMarginRight = v })
                                ConfigTabSelector(title: "有序列表下外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_orderedListMarginBottom, onSelect: { v => cfg_orderedListMarginBottom = v })
                                ConfigTabSelector(title: "有序列表左外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_orderedListMarginLeft, onSelect: { v => cfg_orderedListMarginLeft = v })
                                ConfigTabSelector(title: "有序列表上内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_orderedListPaddingTop, onSelect: { v => cfg_orderedListPaddingTop = v })
                                ConfigTabSelector(title: "有序列表右内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_orderedListPaddingRight, onSelect: { v => cfg_orderedListPaddingRight = v })
                                ConfigTabSelector(title: "有序列表下内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_orderedListPaddingBottom, onSelect: { v => cfg_orderedListPaddingBottom = v })
                                ConfigTabSelector(title: "有序列表左内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_orderedListPaddingLeft, onSelect: { v => cfg_orderedListPaddingLeft = v })
                                ConfigTabSelector(title: "有序列表子项间距 - ", options: spaceList, defaultValue: "0", configKey: "", currentValue: cfg_orderedListChildSpacing, onSelect: { v => cfg_orderedListChildSpacing = v })
                                ConfigTabSelector(title: "有序列表子子项间距 - ", options: spaceList, defaultValue: "0", configKey: "", currentValue: cfg_orderedListChildChildSpacing, onSelect: { v => cfg_orderedListChildChildSpacing = v })
                                ConfigTabSelector(title: "有序列表标记间距 - ", options: spaceList, defaultValue: "0", configKey: "", currentValue: cfg_orderedListMarkerSpacing, onSelect: { v => cfg_orderedListMarkerSpacing = v })
                                ConfigTabSelector(title: "有序列表标记文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_orderedListMarkerTextFontStyle, onSelect: { v => cfg_orderedListMarkerTextFontStyle = v })
                                ConfigTabSelector(title: "有序列表标记文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_orderedListMarkerTextFontWeight, onSelect: { v => cfg_orderedListMarkerTextFontWeight = v })
                                ConfigTabSelector(title: "有序列表标记文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_orderedListMarkerTextFontFamily, onSelect: { v => cfg_orderedListMarkerTextFontFamily = v })
                                ConfigTabSelector(title: "有序列表标记文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_orderedListMarkerTextLineHeight, onSelect: { v => cfg_orderedListMarkerTextLineHeight = v })
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
                            Text("无序和任务列表通用设置")
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
                                ConfigTabSelector(title: "无序列表背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_bulletListBackgroundColor, onSelect: { v => cfg_bulletListBackgroundColor = v })
                                ConfigTabSelector(title: "无序列表上外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_bulletListMarginTop, onSelect: { v => cfg_bulletListMarginTop = v })
                                ConfigTabSelector(title: "无序列表右外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_bulletListMarginRight, onSelect: { v => cfg_bulletListMarginRight = v })
                                ConfigTabSelector(title: "无序列表下外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_bulletListMarginBottom, onSelect: { v => cfg_bulletListMarginBottom = v })
                                ConfigTabSelector(title: "无序列表左外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_bulletListMarginLeft, onSelect: { v => cfg_bulletListMarginLeft = v })
                                ConfigTabSelector(title: "无序列表上内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_bulletListPaddingTop, onSelect: { v => cfg_bulletListPaddingTop = v })
                                ConfigTabSelector(title: "无序列表右内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_bulletListPaddingRight, onSelect: { v => cfg_bulletListPaddingRight = v })
                                ConfigTabSelector(title: "无序列表下内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_bulletListPaddingBottom, onSelect: { v => cfg_bulletListPaddingBottom = v })
                                ConfigTabSelector(title: "无序列表左内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_bulletListPaddingLeft, onSelect: { v => cfg_bulletListPaddingLeft = v })
                                ConfigTabSelector(title: "无序列表子项间距 - ", options: spaceList, defaultValue: "0", configKey: "", currentValue: cfg_bulletListChildSpacing, onSelect: { v => cfg_bulletListChildSpacing = v })
                                ConfigTabSelector(title: "无序列表子子项间距 - ", options: spaceList, defaultValue: "0", configKey: "", currentValue: cfg_bulletListChildChildSpacing, onSelect: { v => cfg_bulletListChildChildSpacing = v })
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
                            Text("无序列表设置")
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
                                ConfigTabSelector(title: "无序列表项目符号间距 - ", options: spaceList, defaultValue: "0", configKey: "", currentValue: cfg_bulletListBulletSpacing, onSelect: { v => cfg_bulletListBulletSpacing = v })
                                ConfigTabSelector(title: "无序列表项目符号是否圆形 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_bulletListBulletIsCircle, onSelect: { v => cfg_bulletListBulletIsCircle = v })
                                ConfigTabSelector(title: "无序列表项目符号文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_bulletListBulletTextFontColor, onSelect: { v => cfg_bulletListBulletTextFontColor = v })
                                ConfigTabSelector(title: "无序列表项目符号文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_bulletListBulletTextFontSize, onSelect: { v => cfg_bulletListBulletTextFontSize = v })
                                ConfigTabSelector(title: "无序列表项目符号文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_bulletListBulletTextFontStyle, onSelect: { v => cfg_bulletListBulletTextFontStyle = v })
                                ConfigTabSelector(title: "无序列表项目符号文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_bulletListBulletTextFontWeight, onSelect: { v => cfg_bulletListBulletTextFontWeight = v })
                                ConfigTabSelector(title: "无序列表项目符号文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_bulletListBulletTextFontFamily, onSelect: { v => cfg_bulletListBulletTextFontFamily = v })
                                ConfigTabSelector(title: "无序列表项目符号文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_bulletListBulletTextLineHeight, onSelect: { v => cfg_bulletListBulletTextLineHeight = v })
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
                            Text("任务列表设置")
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
                                ConfigTabSelector(title: "无序列表复选框间距 - ", options: spaceList, defaultValue: "0", configKey: "", currentValue: cfg_bulletListCheckboxSpacing, onSelect: { v => cfg_bulletListCheckboxSpacing = v })
                                ConfigTabSelector(title: "无序列表复选框宽度 - ", options: widthOrHeightList, defaultValue: "0", configKey: "", currentValue: cfg_bulletListCheckboxWidth, onSelect: { v => cfg_bulletListCheckboxWidth = v })
                                ConfigTabSelector(title: "无序列表复选框高度 - ", options: widthOrHeightList, defaultValue: "0", configKey: "", currentValue: cfg_bulletListCheckboxHeight, onSelect: { v => cfg_bulletListCheckboxHeight = v })
                                ConfigTabSelector(title: "无序列表复选框选中颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_bulletListCheckboxSelectedColor, onSelect: { v => cfg_bulletListCheckboxSelectedColor = v })
                                ConfigTabSelector(title: "无序列表复选框形状 - ", options: checkBoxShapeList, defaultValue: "ROUNDED_SQUARE", configKey: "", currentValue: cfg_bulletListCheckboxShape, onSelect: { v => cfg_bulletListCheckboxShape = v })
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