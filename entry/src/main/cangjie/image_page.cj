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
class ImagePage {
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
    @State var cfg_imageBorderColor: String = "undefined"
    @State var cfg_imageBorderWidth: String = "undefined"
    @State var cfg_imageFitType: String = "Contain"
    @State var cfg_imageAutoResize: String = "true"
    @State var cfg_imageMaximumWidth: String = "100"
    @State var cfg_imageDownloadButtonVisible: String = "true"

    @State var cfg_imageMarginTop: String = "0"
    @State var cfg_imageMarginRight: String = "0"
    @State var cfg_imageMarginBottom: String = "0"
    @State var cfg_imageMarginLeft: String = "0"
    @State var cfg_imageRadiusTopLeft: String = "0"
    @State var cfg_imageRadiusTopRight: String = "0"
    @State var cfg_imageRadiusBottomLeft: String = "0"
    @State var cfg_imageRadiusBottomRight: String = "0"
    @State var cfg_imageBorderStyle: String = "Solid"
    @State var cfg_imageMixedLayout: String = "false"
    @State var cfg_imageFixedRatioWidth: String = "0"
    @State var cfg_imageMaxHeight: String = "0"
    @State var cfg_imageHeight: String = "0"
    @State var cfg_imageMaxWidth: String = "0"
    @State var cfg_imageWidth: String = "0"
    @State var cfg_imageBottomLayoutMarginTop: String = "0"
    @State var cfg_imageDownloadButtonWidth: String = "144"
    @State var cfg_imageDownloadButtonHeight: String = "44"
    @State var cfg_imageDownloadButtonRadius: String = "0"
    @State var cfg_imageDownloadButtonIconTextGap: String = "6"
    @State var cfg_imageDownloadButtonIconWidth: String = "18"
    @State var cfg_imageDownloadButtonIconHeight: String = "18"
    @State var cfg_imageDownloadButtonBackgroundColor: String = "undefined"
    @State var cfg_imageDownloadButtonText: String = "下载"
    @State var cfg_imageDownloadButtonTextFontColor: String = "undefined"
    @State var cfg_imageDownloadButtonTextFontSize: String = "undefined"
    @State var cfg_imageDownloadButtonTextFontStyle: String = "undefined"
    @State var cfg_imageDownloadButtonTextFontWeight: String = "Normal"
    @State var cfg_imageDownloadButtonTextFontFamily: String = "undefined"
    @State var cfg_imageDownloadButtonTextLineHeight: String = "undefined"
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

        let imageTheme = ImageTheme()
        if (cfg_imageBorderColor != "undefined") {
            imageTheme.setImageBorderColor(parseColor(cfg_imageBorderColor))
        }
        if (cfg_imageBorderWidth != "undefined") {
            imageTheme.setImageBorderWidth(parseFloat64(cfg_imageBorderWidth))
        }
        imageTheme.setImageFitType(parseImageFit(cfg_imageFitType))
        imageTheme.setImageAutoResize(parseBool(cfg_imageAutoResize))
        imageTheme.setImageMaximumWidth(parseFloat64(cfg_imageMaximumWidth))
        imageTheme.setImageDownloadButtonVisible(parseBool(cfg_imageDownloadButtonVisible))
        imageTheme.setImageBorderStyle(parseBorderStyle(cfg_imageBorderStyle))
        imageTheme.setIsImageMixedLayout(parseBool(cfg_imageMixedLayout))
        imageTheme.setImageFixedRatioWidth(parseFloat64(cfg_imageFixedRatioWidth))
        imageTheme.setImageMaxHeight(parseFloat64(cfg_imageMaxHeight))
        imageTheme.setImageHeight(parseFloat64(cfg_imageHeight))
        imageTheme.setImageMaxWidth(parseFloat64(cfg_imageMaxWidth))
        imageTheme.setImageWidth(parseFloat64(cfg_imageWidth))
        imageTheme.setImageBottomLayoutMarginTop(parseFloat64(cfg_imageBottomLayoutMarginTop))
        imageTheme.setImageDownloadButtonWidth(parseFloat64(cfg_imageDownloadButtonWidth))
        imageTheme.setImageDownloadButtonHeight(parseFloat64(cfg_imageDownloadButtonHeight))
        imageTheme.setImageDownloadButtonRadius(parseFloat64(cfg_imageDownloadButtonRadius))
        imageTheme.setImageDownloadButtonIconTextGap(parseFloat64(cfg_imageDownloadButtonIconTextGap))
        imageTheme.setImageDownloadButtonIconWidth(parseFloat64(cfg_imageDownloadButtonIconWidth))
        imageTheme.setImageDownloadButtonIconHeight(parseFloat64(cfg_imageDownloadButtonIconHeight))
        if (cfg_imageDownloadButtonBackgroundColor != "undefined") {
            imageTheme.setImageDownloadButtonBackgroundColor(parseColor(cfg_imageDownloadButtonBackgroundColor))
        }
        imageTheme.setImageDownloadButtonText(cfg_imageDownloadButtonText)
        if (cfg_imageDownloadButtonTextFontColor != "undefined") {
            imageTheme.setImageDownloadButtonTextFontColor(parseColor(cfg_imageDownloadButtonTextFontColor))
        }
        if (cfg_imageDownloadButtonTextFontSize != "undefined") {
            imageTheme.setImageDownloadButtonTextFontSize(parseFloat64(cfg_imageDownloadButtonTextFontSize))
        }
        if (cfg_imageDownloadButtonTextFontStyle != "undefined") {
            imageTheme.setImageDownloadButtonTextFontStyle(parseFontStyle(cfg_imageDownloadButtonTextFontStyle))
        }
        imageTheme.setImageDownloadButtonTextFontWeight(parseFontWeight(cfg_imageDownloadButtonTextFontWeight))
        if (cfg_imageDownloadButtonTextFontFamily != "undefined") {
            imageTheme.setImageDownloadButtonTextFontFamily(cfg_imageDownloadButtonTextFontFamily)
        }
        if (cfg_imageDownloadButtonTextLineHeight != "undefined") {
            imageTheme.setImageDownloadButtonTextLineHeight(parseFloat64(cfg_imageDownloadButtonTextLineHeight))
        }
        imageTheme.setMargin(top: parseFloat64(cfg_imageMarginTop), right: parseFloat64(cfg_imageMarginRight), bottom: parseFloat64(cfg_imageMarginBottom), left: parseFloat64(cfg_imageMarginLeft))
        imageTheme.setRadius(topLeft: parseFloat64(cfg_imageRadiusTopLeft), topRight: parseFloat64(cfg_imageRadiusTopRight), bottomLeft: parseFloat64(cfg_imageRadiusBottomLeft), bottomRight: parseFloat64(cfg_imageRadiusBottomRight))
        themeBuilder.setImageTheme(imageTheme)
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
                            Text("图片边距和边框")
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
                                ConfigTabSelector(title: "图片边框颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_imageBorderColor = v })
                                ConfigTabSelector(title: "图片边框宽度 - ", options: lineOrBorderWidthList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_imageBorderWidth = v })
                                ConfigTabSelector(title: "图片上外边距 - ", options: marginList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageMarginTop = v })
                                ConfigTabSelector(title: "图片右外边距 - ", options: marginList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageMarginRight = v })
                                ConfigTabSelector(title: "图片下外边距 - ", options: marginList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageMarginBottom = v })
                                ConfigTabSelector(title: "图片左外边距 - ", options: marginList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageMarginLeft = v })
                                ConfigTabSelector(title: "图片圆角左上圆角 - ", options: radiusList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageRadiusTopLeft = v })
                                ConfigTabSelector(title: "图片圆角右上圆角 - ", options: radiusList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageRadiusTopRight = v })
                                ConfigTabSelector(title: "图片圆角左下圆角 - ", options: radiusList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageRadiusBottomLeft = v })
                                ConfigTabSelector(title: "图片圆角右下圆角 - ", options: radiusList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageRadiusBottomRight = v })
                                ConfigTabSelector(title: "图片边框样式 - ", options: borderStyleList, defaultValue: "Solid", configKey: "", onSelect: { v => cfg_imageBorderStyle = v })
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
                            Text("图片设置和其他")
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
                                ConfigTabSelector(title: "图片适应方式 - ", options: imageFitList, defaultValue: "Contain", configKey: "", onSelect: { v => cfg_imageFitType = v })
                                ConfigTabSelector(title: "图片自动调整 - ", options: booleanList, defaultValue: "true", configKey: "", onSelect: { v => cfg_imageAutoResize = v })
                                ConfigTabSelector(title: "图片最大宽度 - ", options: widthOrHeightList, defaultValue: "100", configKey: "", onSelect: { v => cfg_imageMaximumWidth = v })
                                ConfigTabSelector(title: "图片是否混合布局 - ", options: booleanList, defaultValue: "false", configKey: "", onSelect: { v => cfg_imageMixedLayout = v })
                                ConfigTabSelector(title: "图片固定比例宽度 - ", options: widthOrHeightList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageFixedRatioWidth = v })
                                ConfigTabSelector(title: "图片最大高度 - ", options: widthOrHeightList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageMaxHeight = v })
                                ConfigTabSelector(title: "图片高度 - ", options: widthOrHeightList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageHeight = v })
                                ConfigTabSelector(title: "图片最大宽度 - ", options: widthOrHeightList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageMaxWidth = v })
                                ConfigTabSelector(title: "图片宽度 - ", options: widthOrHeightList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageWidth = v })
                                ConfigTabSelector(title: "图片底部布局距图片上边距 - ", options: marginList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageBottomLayoutMarginTop = v })
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
                            Text("图片下载按钮")
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
                                ConfigTabSelector(title: "图片下载按钮可见 - ", options: booleanList, defaultValue: "true", configKey: "", onSelect: { v => cfg_imageDownloadButtonVisible = v })
                                ConfigTabSelector(title: "图片下载按钮宽度 - ", options: widthOrHeightList, defaultValue: "144", configKey: "", onSelect: { v => cfg_imageDownloadButtonWidth = v })
                                ConfigTabSelector(title: "图片下载按钮高度 - ", options: widthOrHeightList, defaultValue: "44", configKey: "", onSelect: { v => cfg_imageDownloadButtonHeight = v })
                                ConfigTabSelector(title: "图片下载按钮圆角 - ", options: radiusList, defaultValue: "0", configKey: "", onSelect: { v => cfg_imageDownloadButtonRadius = v })
                                ConfigTabSelector(title: "图片下载按钮图标和文本间距 - ", options: spaceList, defaultValue: "6", configKey: "", onSelect: { v => cfg_imageDownloadButtonIconTextGap = v })
                                ConfigTabSelector(title: "图片下载按钮图标宽度 - ", options: widthOrHeightList, defaultValue: "18", configKey: "", onSelect: { v => cfg_imageDownloadButtonIconWidth = v })
                                ConfigTabSelector(title: "图片下载按钮图标高度 - ", options: widthOrHeightList, defaultValue: "18", configKey: "", onSelect: { v => cfg_imageDownloadButtonIconHeight = v })
                                ConfigTabSelector(title: "图片下载按钮背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_imageDownloadButtonBackgroundColor = v })
                                ConfigTabSelector(title: "图片下载按钮默认文本 - ", options: imageDownloadButtonTextList, defaultValue: "下载", configKey: "", onSelect: { v => cfg_imageDownloadButtonText = v })
                                ConfigTabSelector(title: "图片下载按钮文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_imageDownloadButtonTextFontColor = v })
                                ConfigTabSelector(title: "图片下载按钮文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_imageDownloadButtonTextFontSize = v })
                                ConfigTabSelector(title: "图片下载按钮文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_imageDownloadButtonTextFontStyle = v })
                                ConfigTabSelector(title: "图片下载按钮文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", onSelect: { v => cfg_imageDownloadButtonTextFontWeight = v })
                                ConfigTabSelector(title: "图片下载按钮文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_imageDownloadButtonTextFontFamily = v })
                                ConfigTabSelector(title: "图片下载按钮文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_imageDownloadButtonTextLineHeight = v })
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