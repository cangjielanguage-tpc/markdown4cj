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
class LinkPage {
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
    @State @Watch[onConfigChanged] var cfg_linkIsIcon: String = "false"
    @State @Watch[onConfigChanged] var cfg_linkTextFontColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkTextFontSize: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkTextDecorationColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkTextBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkTextFontWeight: String = "Normal"
    @State @Watch[onConfigChanged] var cfg_linkTextFontFamily: String = "undefined"

    @State @Watch[onConfigChanged] var cfg_linkListIsIcon: String = "false"
    @State @Watch[onConfigChanged] var cfg_linkTextFontStyle: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkTextLineHeight: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkTextLetterSpacing: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkTextDecorationType: String = "None"
    @State @Watch[onConfigChanged] var cfg_linkTextDecorationStyle: String = "Solid"
    @State @Watch[onConfigChanged] var cfg_linkTextBackgroundRadiusTopLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkTextBackgroundRadiusTopRight: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkTextBackgroundRadiusBottomLeft: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkTextBackgroundRadiusBottomRight: String = "0"
    @State var cfg_isLoadLinkifyPlugin: String = "true"
    @State @Watch[onConfigChanged] var cfg_linkCircleIconBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkCircleIconButtonBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkCircleIconTextSize: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkCircleIconTextColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkCircleIconRadius: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkCircleIconMargin: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkRectIconBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkRectIconButtonBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkRectIconTextSize: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkRectIconTextColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkRectIconHeight: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkRectIconPadding: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkRectIconRadius: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkRectIconMargin: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkRectToolIconBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkRectToolIconButtonBackgroundColor: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkRectToolIconTextSize: String = "undefined"
    @State @Watch[onConfigChanged] var cfg_linkRectToolIconHeight: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkRectToolIconPadding: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkRectToolIconBorderWidth: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkRectToolIconDividingLineWidth: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkRectToolIconMargin: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkRectToolIconLineLeftPadding: String = "0"
    @State @Watch[onConfigChanged] var cfg_linkRectToolIconLineRightPadding: String = "0"
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

        let linkTheme = theme.getLinkTheme()
        linkTheme.setLinkIsIcon(parseBool(cfg_linkIsIcon))
        if (cfg_linkTextFontColor != "undefined") {
            linkTheme.setLinkTextFontColor(parseColor(cfg_linkTextFontColor))
        }
        if (cfg_linkTextFontSize != "undefined") {
            linkTheme.setLinkTextFontSize(parseFloat64(cfg_linkTextFontSize))
        }
        if (cfg_linkTextDecorationColor != "undefined") {
            linkTheme.setLinkTextDecorationColor(parseColor(cfg_linkTextDecorationColor))
        }
        if (cfg_linkTextBackgroundColor != "undefined") {
            linkTheme.setLinkTextBackgroundColor(parseColor(cfg_linkTextBackgroundColor))
        }
        linkTheme.setLinkTextFontWeight(parseFontWeight(cfg_linkTextFontWeight))
        if (cfg_linkTextFontFamily != "undefined") {
            linkTheme.setLinkTextFontFamily(cfg_linkTextFontFamily)
        }
        linkTheme.setLinkListIsIcon(parseBool(cfg_linkListIsIcon))
        if (cfg_linkTextFontStyle != "undefined") {
            linkTheme.setLinkTextFontStyle(parseFontStyle(cfg_linkTextFontStyle))
        }
        if (cfg_linkTextLineHeight != "undefined") {
            linkTheme.setLinkTextLineHeight(parseFloat64(cfg_linkTextLineHeight))
        }
        if (cfg_linkTextLetterSpacing != "undefined") {
            linkTheme.setLinkTextLetterSpacing(parseFloat64(cfg_linkTextLetterSpacing))
        }
        linkTheme.setLinkTextDecorationType(parseTextDecorationType(cfg_linkTextDecorationType))
        linkTheme.setLinkTextDecorationStyle(parseTextDecorationStyle(cfg_linkTextDecorationStyle))
        linkTheme.setLinkTextBackgroundRadius(topLeft: parseFloat64(cfg_linkTextBackgroundRadiusTopLeft), topRight: parseFloat64(cfg_linkTextBackgroundRadiusTopRight), bottomLeft: parseFloat64(cfg_linkTextBackgroundRadiusBottomLeft), bottomRight: parseFloat64(cfg_linkTextBackgroundRadiusBottomRight))
        if (cfg_linkCircleIconBackgroundColor != "undefined") {
            linkTheme.setLinkCircleIconBackgroundColor(parseColor(cfg_linkCircleIconBackgroundColor))
        }
        if (cfg_linkCircleIconButtonBackgroundColor != "undefined") {
            linkTheme.setLinkCircleIconButtonBackgroundColor(parseColor(cfg_linkCircleIconButtonBackgroundColor))
        }
        if (cfg_linkCircleIconTextSize != "undefined") {
            linkTheme.setLinkCircleIconTextSize(parseFloat64(cfg_linkCircleIconTextSize))
        }
        if (cfg_linkCircleIconTextColor != "undefined") {
            linkTheme.setLinkCircleIconTextColor(parseColor(cfg_linkCircleIconTextColor))
        }
        linkTheme.setLinkCircleIconRadius(parseFloat64(cfg_linkCircleIconRadius))
        linkTheme.setLinkCircleIconMargin(parseFloat64(cfg_linkCircleIconMargin))
        if (cfg_linkRectIconBackgroundColor != "undefined") {
            linkTheme.setLinkRectIconBackgroundColor(parseColor(cfg_linkRectIconBackgroundColor))
        }
        if (cfg_linkRectIconButtonBackgroundColor != "undefined") {
            linkTheme.setLinkRectIconButtonBackgroundColor(parseColor(cfg_linkRectIconButtonBackgroundColor))
        }
        if (cfg_linkRectIconTextSize != "undefined") {
            linkTheme.setLinkRectIconTextSize(parseFloat64(cfg_linkRectIconTextSize))
        }
        if (cfg_linkRectIconTextColor != "undefined") {
            linkTheme.setLinkRectIconTextColor(parseColor(cfg_linkRectIconTextColor))
        }
        linkTheme.setLinkRectIconHeight(parseFloat64(cfg_linkRectIconHeight))
        linkTheme.setLinkRectIconPadding(parseFloat64(cfg_linkRectIconPadding))
        linkTheme.setLinkRectIconRadius(parseFloat64(cfg_linkRectIconRadius))
        linkTheme.setLinkRectIconMargin(parseFloat64(cfg_linkRectIconMargin))
        if (cfg_linkRectToolIconBackgroundColor != "undefined") {
            linkTheme.setLinkRectToolIconBackgroundColor(parseColor(cfg_linkRectToolIconBackgroundColor))
        }
        if (cfg_linkRectToolIconButtonBackgroundColor != "undefined") {
            linkTheme.setLinkRectToolIconButtonBackgroundColor(parseColor(cfg_linkRectToolIconButtonBackgroundColor))
        }
        if (cfg_linkRectToolIconTextSize != "undefined") {
            linkTheme.setLinkRectToolIconTextSize(parseFloat64(cfg_linkRectToolIconTextSize))
        }
        linkTheme.setLinkRectToolIconHeight(parseFloat64(cfg_linkRectToolIconHeight))
        linkTheme.setLinkRectToolIconPadding(parseFloat64(cfg_linkRectToolIconPadding))
        linkTheme.setLinkRectToolIconBorderWidth(parseFloat64(cfg_linkRectToolIconBorderWidth))
        linkTheme.setLinkRectToolIconDividingLineWidth(parseFloat64(cfg_linkRectToolIconDividingLineWidth))
        linkTheme.setLinkRectToolIconMargin(parseFloat64(cfg_linkRectToolIconMargin))
        linkTheme.setLinkRectToolIconLineLeftPadding(parseFloat64(cfg_linkRectToolIconLineLeftPadding))
        linkTheme.setLinkRectToolIconLineRightPadding(parseFloat64(cfg_linkRectToolIconLineRightPadding))
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
                            Text("圆形图片和其他设置")
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
                                ConfigTabSelector(title: "链接是否图片显示 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_linkIsIcon, onSelect: { v => cfg_linkIsIcon = v })
                                ConfigTabSelector(title: "链接列表是否图标 - ", options: booleanList, defaultValue: "false", configKey: "", currentValue: cfg_linkListIsIcon, onSelect: { v => cfg_linkListIsIcon = v })
                                ConfigTabSelector(title: "是否加载链接自动解析插件 - ", options: booleanList, defaultValue: "true", configKey: "", currentValue: cfg_isLoadLinkifyPlugin, onSelect: { v => cfg_isLoadLinkifyPlugin = v })
                                ConfigTabSelector(title: "链接圆形图标背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkCircleIconBackgroundColor, onSelect: { v => cfg_linkCircleIconBackgroundColor = v })
                                ConfigTabSelector(title: "链接圆形图标按钮背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkCircleIconButtonBackgroundColor, onSelect: { v => cfg_linkCircleIconButtonBackgroundColor = v })
                                ConfigTabSelector(title: "链接圆形图标文本大小 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkCircleIconTextSize, onSelect: { v => cfg_linkCircleIconTextSize = v })
                                ConfigTabSelector(title: "链接圆形图标文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkCircleIconTextColor, onSelect: { v => cfg_linkCircleIconTextColor = v })
                                ConfigTabSelector(title: "链接圆形图标圆角 - ", options: radiusList, defaultValue: "0", configKey: "", currentValue: cfg_linkCircleIconRadius, onSelect: { v => cfg_linkCircleIconRadius = v })
                                ConfigTabSelector(title: "链接圆形图标外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_linkCircleIconMargin, onSelect: { v => cfg_linkCircleIconMargin = v })
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
                            Text("圆角矩形设置")
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
                                ConfigTabSelector(title: "链接矩形图标背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkRectIconBackgroundColor, onSelect: { v => cfg_linkRectIconBackgroundColor = v })
                                ConfigTabSelector(title: "链接矩形图标按钮背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkRectIconButtonBackgroundColor, onSelect: { v => cfg_linkRectIconButtonBackgroundColor = v })
                                ConfigTabSelector(title: "链接矩形图标文本大小 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkRectIconTextSize, onSelect: { v => cfg_linkRectIconTextSize = v })
                                ConfigTabSelector(title: "链接矩形图标文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkRectIconTextColor, onSelect: { v => cfg_linkRectIconTextColor = v })
                                ConfigTabSelector(title: "链接矩形图标高度 - ", options: widthOrHeightList, defaultValue: "0", configKey: "", currentValue: cfg_linkRectIconHeight, onSelect: { v => cfg_linkRectIconHeight = v })
                                ConfigTabSelector(title: "链接矩形图标内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_linkRectIconPadding, onSelect: { v => cfg_linkRectIconPadding = v })
                                ConfigTabSelector(title: "链接矩形图标圆角 - ", options: radiusList, defaultValue: "0", configKey: "", currentValue: cfg_linkRectIconRadius, onSelect: { v => cfg_linkRectIconRadius = v })
                                ConfigTabSelector(title: "链接矩形图标外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_linkRectIconMargin, onSelect: { v => cfg_linkRectIconMargin = v })
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
                            Text("空心圆角矩形设置")
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
                                ConfigTabSelector(title: "链接矩形工具图标背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkRectToolIconBackgroundColor, onSelect: { v => cfg_linkRectToolIconBackgroundColor = v })
                                ConfigTabSelector(title: "链接矩形工具图标按钮背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkRectToolIconButtonBackgroundColor, onSelect: { v => cfg_linkRectToolIconButtonBackgroundColor = v })
                                ConfigTabSelector(title: "链接矩形工具图标文本大小 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkRectToolIconTextSize, onSelect: { v => cfg_linkRectToolIconTextSize = v })
                                ConfigTabSelector(title: "链接矩形工具图标高度 - ", options: widthOrHeightList, defaultValue: "0", configKey: "", currentValue: cfg_linkRectToolIconHeight, onSelect: { v => cfg_linkRectToolIconHeight = v })
                                ConfigTabSelector(title: "链接矩形工具图标内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_linkRectToolIconPadding, onSelect: { v => cfg_linkRectToolIconPadding = v })
                                ConfigTabSelector(title: "链接矩形工具图标边框宽度 - ", options: lineOrBorderWidthList, defaultValue: "0", configKey: "", currentValue: cfg_linkRectToolIconBorderWidth, onSelect: { v => cfg_linkRectToolIconBorderWidth = v })
                                ConfigTabSelector(title: "链接矩形工具图标分割线宽度 - ", options: lineOrBorderWidthList, defaultValue: "0", configKey: "", currentValue: cfg_linkRectToolIconDividingLineWidth, onSelect: { v => cfg_linkRectToolIconDividingLineWidth = v })
                                ConfigTabSelector(title: "链接矩形工具图标外边距 - ", options: marginList, defaultValue: "0", configKey: "", currentValue: cfg_linkRectToolIconMargin, onSelect: { v => cfg_linkRectToolIconMargin = v })
                                ConfigTabSelector(title: "链接矩形工具图标线条左内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_linkRectToolIconLineLeftPadding, onSelect: { v => cfg_linkRectToolIconLineLeftPadding = v })
                                ConfigTabSelector(title: "链接矩形工具图标线条右内边距 - ", options: paddingList, defaultValue: "0", configKey: "", currentValue: cfg_linkRectToolIconLineRightPadding, onSelect: { v => cfg_linkRectToolIconLineRightPadding = v })
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
                            Text("链接文本设置")
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
                                ConfigTabSelector(title: "链接文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkTextFontColor, onSelect: { v => cfg_linkTextFontColor = v })
                                ConfigTabSelector(title: "链接文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkTextFontSize, onSelect: { v => cfg_linkTextFontSize = v })
                                ConfigTabSelector(title: "链接下划线颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkTextDecorationColor, onSelect: { v => cfg_linkTextDecorationColor = v })
                                ConfigTabSelector(title: "链接背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkTextBackgroundColor, onSelect: { v => cfg_linkTextBackgroundColor = v })
                                ConfigTabSelector(title: "链接字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", currentValue: cfg_linkTextFontWeight, onSelect: { v => cfg_linkTextFontWeight = v })
                                ConfigTabSelector(title: "链接字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkTextFontFamily, onSelect: { v => cfg_linkTextFontFamily = v })
                                ConfigTabSelector(title: "链接文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkTextFontStyle, onSelect: { v => cfg_linkTextFontStyle = v })
                                ConfigTabSelector(title: "链接文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkTextLineHeight, onSelect: { v => cfg_linkTextLineHeight = v })
                                ConfigTabSelector(title: "链接文本字符间距 - ", options: textWordSpaceList, defaultValue: "undefined", configKey: "", currentValue: cfg_linkTextLetterSpacing, onSelect: { v => cfg_linkTextLetterSpacing = v })
                                ConfigTabSelector(title: "链接文本装饰类型 - ", options: textDecorationTypeList, defaultValue: "None", configKey: "", currentValue: cfg_linkTextDecorationType, onSelect: { v => cfg_linkTextDecorationType = v })
                                ConfigTabSelector(title: "链接文本装饰样式 - ", options: textDecorationStyleList, defaultValue: "Solid", configKey: "", currentValue: cfg_linkTextDecorationStyle, onSelect: { v => cfg_linkTextDecorationStyle = v })
                                ConfigTabSelector(title: "链接文本背景左上圆角 - ", options: radiusList, defaultValue: "0", configKey: "", currentValue: cfg_linkTextBackgroundRadiusTopLeft, onSelect: { v => cfg_linkTextBackgroundRadiusTopLeft = v })
                                ConfigTabSelector(title: "链接文本背景右上圆角 - ", options: radiusList, defaultValue: "0", configKey: "", currentValue: cfg_linkTextBackgroundRadiusTopRight, onSelect: { v => cfg_linkTextBackgroundRadiusTopRight = v })
                                ConfigTabSelector(title: "链接文本背景左下圆角 - ", options: radiusList, defaultValue: "0", configKey: "", currentValue: cfg_linkTextBackgroundRadiusBottomLeft, onSelect: { v => cfg_linkTextBackgroundRadiusBottomLeft = v })
                                ConfigTabSelector(title: "链接文本背景右下圆角 - ", options: radiusList, defaultValue: "0", configKey: "", currentValue: cfg_linkTextBackgroundRadiusBottomRight, onSelect: { v => cfg_linkTextBackgroundRadiusBottomRight = v })
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