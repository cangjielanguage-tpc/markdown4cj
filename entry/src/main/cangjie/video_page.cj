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
class VideoPage {
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
    @State var cfg_videoBackgroundColor: String = "undefined"
    @State var cfg_videoBorderColor: String = "undefined"
    @State var cfg_videoTimeTextFontColor: String = "undefined"

    @State var cfg_videoMarginTop: String = "undefined"
    @State var cfg_videoMarginRight: String = "undefined"
    @State var cfg_videoMarginBottom: String = "undefined"
    @State var cfg_videoMarginLeft: String = "undefined"
    @State var cfg_videoPaddingTop: String = "undefined"
    @State var cfg_videoPaddingRight: String = "undefined"
    @State var cfg_videoPaddingBottom: String = "undefined"
    @State var cfg_videoPaddingLeft: String = "undefined"
    @State var cfg_videoRadiusTopLeft: String = "undefined"
    @State var cfg_videoRadiusTopRight: String = "undefined"
    @State var cfg_videoRadiusBottomLeft: String = "undefined"
    @State var cfg_videoRadiusBottomRight: String = "undefined"
    @State var cfg_videoBorderStyle: String = "Solid"
    @State var cfg_videoBorderWidth: String = "0"
    @State var cfg_videoImageFitType: String = "Cover"
    @State var cfg_videoPlayIconWidth: String = "60"
    @State var cfg_videoPlayIconHeight: String = "60"
    @State var cfg_videoPlayIconFitType: String = "Contain"
    @State var cfg_videoTimeTextFontSize: String = "undefined"
    @State var cfg_videoTimeTextFontStyle: String = "undefined"
    @State var cfg_videoTimeTextFontWeight: String = "Normal"
    @State var cfg_videoTimeTextFontFamily: String = "undefined"
    @State var cfg_videoTimeTextLineHeight: String = "undefined"
    @State var cfg_videoTimeTextMarginRight: String = "10"
    @State var cfg_videoTimeTextMarginBottom: String = "10"
    @State var cfg_videoBottomLayoutVisible: String = "false"
    @State var cfg_videoBottomLayoutMarginTop: String = "14"
    @State var cfg_videoReleaseButtonVisible: String = "true"
    @State var cfg_videoReleaseButtonBackgroundColor: String = "undefined"
    @State var cfg_videoReleaseButtonWidth: String = "144"
    @State var cfg_videoReleaseButtonHeight: String = "44"
    @State var cfg_videoReleaseButtonRadiusTopLeft: String = "undefined"
    @State var cfg_videoReleaseButtonRadiusTopRight: String = "undefined"
    @State var cfg_videoReleaseButtonRadiusBottomLeft: String = "undefined"
    @State var cfg_videoReleaseButtonRadiusBottomRight: String = "undefined"
    @State var cfg_videoReleaseButtonIconTextGap: String = "6"
    @State var cfg_videoReleaseButtonIconWidth: String = "18"
    @State var cfg_videoReleaseButtonIconHeight: String = "18"
    @State var cfg_videoReleaseButtonText: String = "发布视频"
    @State var cfg_videoReleaseButtonTextFontColor: String = "undefined"
    @State var cfg_videoReleaseButtonTextFontSize: String = "undefined"
    @State var cfg_videoReleaseButtonTextFontStyle: String = "undefined"
    @State var cfg_videoReleaseButtonTextFontWeight: String = "Normal"
    @State var cfg_videoReleaseButtonTextFontFamily: String = "undefined"
    @State var cfg_videoReleaseButtonTextLineHeight: String = "undefined"
    @State var cfg_videoDownloadButtonVisible: String = "true"
    @State var cfg_videoDownloadButtonBackgroundColor: String = "undefined"
    @State var cfg_videoDownloadButtonWidth: String = "144"
    @State var cfg_videoDownloadButtonHeight: String = "44"
    @State var cfg_videoDownloadButtonRadiusTopLeft: String = "undefined"
    @State var cfg_videoDownloadButtonRadiusTopRight: String = "undefined"
    @State var cfg_videoDownloadButtonRadiusBottomLeft: String = "undefined"
    @State var cfg_videoDownloadButtonRadiusBottomRight: String = "undefined"
    @State var cfg_videoDownloadButtonIconTextGap: String = "6"
    @State var cfg_videoDownloadButtonIconWidth: String = "18"
    @State var cfg_videoDownloadButtonIconHeight: String = "18"
    @State var cfg_videoDownloadButtonText: String = "下载视频"
    @State var cfg_videoDownloadButtonTextFontColor: String = "undefined"
    @State var cfg_videoDownloadButtonTextFontSize: String = "undefined"
    @State var cfg_videoDownloadButtonTextFontStyle: String = "undefined"
    @State var cfg_videoDownloadButtonTextFontWeight: String = "Normal"
    @State var cfg_videoDownloadButtonTextFontFamily: String = "undefined"
    @State var cfg_videoDownloadButtonTextLineHeight: String = "undefined"
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

        let videoTheme = VideoTheme()
        if (cfg_videoBackgroundColor != "undefined") {
            videoTheme.setVideoBackgroundColor(parseColor(cfg_videoBackgroundColor))
        }
        if (cfg_videoBorderColor != "undefined") {
            videoTheme.setVideoBorderColor(parseColor(cfg_videoBorderColor))
        }
        if (cfg_videoTimeTextFontColor != "undefined") {
            videoTheme.setVideoTimeTextFontColor(parseColor(cfg_videoTimeTextFontColor))
        }
        videoTheme.setVideoBorderStyle(parseBorderStyle(cfg_videoBorderStyle))
        videoTheme.setVideoBorderWidth(parseFloat64(cfg_videoBorderWidth))
        videoTheme.setVideoImageFitType(parseImageFit(cfg_videoImageFitType))
        videoTheme.setVideoPlayIconWidth(parseFloat64(cfg_videoPlayIconWidth))
        videoTheme.setVideoPlayIconHeight(parseFloat64(cfg_videoPlayIconHeight))
        videoTheme.setVideoPlayIconFitType(parseImageFit(cfg_videoPlayIconFitType))
        if (cfg_videoTimeTextFontSize != "undefined") {
            videoTheme.setVideoTimeTextFontSize(parseFloat64(cfg_videoTimeTextFontSize))
        }
        if (cfg_videoTimeTextFontStyle != "undefined") {
            videoTheme.setVideoTimeTextFontStyle(parseFontStyle(cfg_videoTimeTextFontStyle))
        }
        videoTheme.setVideoTimeTextFontWeight(parseFontWeight(cfg_videoTimeTextFontWeight))
        if (cfg_videoTimeTextFontFamily != "undefined") {
            videoTheme.setVideoTimeTextFontFamily(cfg_videoTimeTextFontFamily)
        }
        if (cfg_videoTimeTextLineHeight != "undefined") {
            videoTheme.setVideoTimeTextLineHeight(parseFloat64(cfg_videoTimeTextLineHeight))
        }
        videoTheme.setVideoTimeTextMarginRight(parseFloat64(cfg_videoTimeTextMarginRight))
        videoTheme.setVideoTimeTextMarginBottom(parseFloat64(cfg_videoTimeTextMarginBottom))
        videoTheme.setVideoBottomLayoutVisible(parseBool(cfg_videoBottomLayoutVisible))
        videoTheme.setVideoBottomLayoutMarginTop(parseFloat64(cfg_videoBottomLayoutMarginTop))
        videoTheme.setVideoReleaseButtonVisible(parseBool(cfg_videoReleaseButtonVisible))
        if (cfg_videoReleaseButtonBackgroundColor != "undefined") {
            videoTheme.setVideoReleaseButtonBackgroundColor(parseColor(cfg_videoReleaseButtonBackgroundColor))
        }
        videoTheme.setVideoReleaseButtonWidth(parseFloat64(cfg_videoReleaseButtonWidth))
        videoTheme.setVideoReleaseButtonHeight(parseFloat64(cfg_videoReleaseButtonHeight))
        videoTheme.setVideoReleaseButtonIconTextGap(parseFloat64(cfg_videoReleaseButtonIconTextGap))
        videoTheme.setVideoReleaseButtonIconWidth(parseFloat64(cfg_videoReleaseButtonIconWidth))
        videoTheme.setVideoReleaseButtonIconHeight(parseFloat64(cfg_videoReleaseButtonIconHeight))
        videoTheme.setVideoReleaseButtonText(cfg_videoReleaseButtonText)
        if (cfg_videoReleaseButtonTextFontColor != "undefined") {
            videoTheme.setVideoReleaseButtonTextFontColor(parseColor(cfg_videoReleaseButtonTextFontColor))
        }
        if (cfg_videoReleaseButtonTextFontSize != "undefined") {
            videoTheme.setVideoReleaseButtonTextFontSize(parseFloat64(cfg_videoReleaseButtonTextFontSize))
        }
        if (cfg_videoReleaseButtonTextFontStyle != "undefined") {
            videoTheme.setVideoReleaseButtonTextFontStyle(parseFontStyle(cfg_videoReleaseButtonTextFontStyle))
        }
        videoTheme.setVideoReleaseButtonTextFontWeight(parseFontWeight(cfg_videoReleaseButtonTextFontWeight))
        if (cfg_videoReleaseButtonTextFontFamily != "undefined") {
            videoTheme.setVideoReleaseButtonTextFontFamily(cfg_videoReleaseButtonTextFontFamily)
        }
        if (cfg_videoReleaseButtonTextLineHeight != "undefined") {
            videoTheme.setVideoReleaseButtonTextLineHeight(parseFloat64(cfg_videoReleaseButtonTextLineHeight))
        }
        videoTheme.setVideoDownloadButtonVisible(parseBool(cfg_videoDownloadButtonVisible))
        if (cfg_videoDownloadButtonBackgroundColor != "undefined") {
            videoTheme.setVideoDownloadButtonBackgroundColor(parseColor(cfg_videoDownloadButtonBackgroundColor))
        }
        videoTheme.setVideoDownloadButtonWidth(parseFloat64(cfg_videoDownloadButtonWidth))
        videoTheme.setVideoDownloadButtonHeight(parseFloat64(cfg_videoDownloadButtonHeight))
        videoTheme.setVideoDownloadButtonIconTextGap(parseFloat64(cfg_videoDownloadButtonIconTextGap))
        videoTheme.setVideoDownloadButtonIconWidth(parseFloat64(cfg_videoDownloadButtonIconWidth))
        videoTheme.setVideoDownloadButtonIconHeight(parseFloat64(cfg_videoDownloadButtonIconHeight))
        videoTheme.setVideoDownloadButtonText(cfg_videoDownloadButtonText)
        if (cfg_videoDownloadButtonTextFontColor != "undefined") {
            videoTheme.setVideoDownloadButtonTextFontColor(parseColor(cfg_videoDownloadButtonTextFontColor))
        }
        if (cfg_videoDownloadButtonTextFontSize != "undefined") {
            videoTheme.setVideoDownloadButtonTextFontSize(parseFloat64(cfg_videoDownloadButtonTextFontSize))
        }
        if (cfg_videoDownloadButtonTextFontStyle != "undefined") {
            videoTheme.setVideoDownloadButtonTextFontStyle(parseFontStyle(cfg_videoDownloadButtonTextFontStyle))
        }
        videoTheme.setVideoDownloadButtonTextFontWeight(parseFontWeight(cfg_videoDownloadButtonTextFontWeight))
        if (cfg_videoDownloadButtonTextFontFamily != "undefined") {
            videoTheme.setVideoDownloadButtonTextFontFamily(cfg_videoDownloadButtonTextFontFamily)
        }
        if (cfg_videoDownloadButtonTextLineHeight != "undefined") {
            videoTheme.setVideoDownloadButtonTextLineHeight(parseFloat64(cfg_videoDownloadButtonTextLineHeight))
        }
        videoTheme.setVideoPadding(top: parseFloat64(cfg_videoPaddingTop), right: parseFloat64(cfg_videoPaddingRight), bottom: parseFloat64(cfg_videoPaddingBottom), left: parseFloat64(cfg_videoPaddingLeft))
        videoTheme.setVideoReleaseButtonRadius(topLeft: parseFloat64(cfg_videoReleaseButtonRadiusTopLeft), topRight: parseFloat64(cfg_videoReleaseButtonRadiusTopRight), bottomLeft: parseFloat64(cfg_videoReleaseButtonRadiusBottomLeft), bottomRight: parseFloat64(cfg_videoReleaseButtonRadiusBottomRight))
        videoTheme.setVideoRadius(topLeft: parseFloat64(cfg_videoRadiusTopLeft), topRight: parseFloat64(cfg_videoRadiusTopRight), bottomLeft: parseFloat64(cfg_videoRadiusBottomLeft), bottomRight: parseFloat64(cfg_videoRadiusBottomRight))
        videoTheme.setVideoDownloadButtonRadius(topLeft: parseFloat64(cfg_videoDownloadButtonRadiusTopLeft), topRight: parseFloat64(cfg_videoDownloadButtonRadiusTopRight), bottomLeft: parseFloat64(cfg_videoDownloadButtonRadiusBottomLeft), bottomRight: parseFloat64(cfg_videoDownloadButtonRadiusBottomRight))
        videoTheme.setVideoMargin(top: parseFloat64(cfg_videoMarginTop), right: parseFloat64(cfg_videoMarginRight), bottom: parseFloat64(cfg_videoMarginBottom), left: parseFloat64(cfg_videoMarginLeft))
        themeBuilder.setVideoTheme(videoTheme)
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
                                ConfigTabSelector(title: "视频背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoBackgroundColor = v })
                                ConfigTabSelector(title: "视频边框颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoBorderColor = v })
                                ConfigTabSelector(title: "视频时间文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoTimeTextFontColor = v })
                                ConfigTabSelector(title: "视频上外边距 - ", options: marginList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoMarginTop = v })
                                ConfigTabSelector(title: "视频右外边距 - ", options: marginList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoMarginRight = v })
                                ConfigTabSelector(title: "视频下外边距 - ", options: marginList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoMarginBottom = v })
                                ConfigTabSelector(title: "视频左外边距 - ", options: marginList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoMarginLeft = v })
                                ConfigTabSelector(title: "视频上内边距 - ", options: paddingList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoPaddingTop = v })
                                ConfigTabSelector(title: "视频右内边距 - ", options: paddingList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoPaddingRight = v })
                                ConfigTabSelector(title: "视频下内边距 - ", options: paddingList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoPaddingBottom = v })
                                ConfigTabSelector(title: "视频左内边距 - ", options: paddingList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoPaddingLeft = v })
                                ConfigTabSelector(title: "视频边框左上圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoRadiusTopLeft = v })
                                ConfigTabSelector(title: "视频边框右上圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoRadiusTopRight = v })
                                ConfigTabSelector(title: "视频边框左下圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoRadiusBottomLeft = v })
                                ConfigTabSelector(title: "视频边框右下圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoRadiusBottomRight = v })
                                ConfigTabSelector(title: "视频边框样式 - ", options: borderStyleList, defaultValue: "Solid", configKey: "", onSelect: { v => cfg_videoBorderStyle = v })
                                ConfigTabSelector(title: "视频边框宽度 - ", options: lineOrBorderWidthList, defaultValue: "0", configKey: "", onSelect: { v => cfg_videoBorderWidth = v })
                                ConfigTabSelector(title: "视频图片缩放类型 - ", options: imageFitList, defaultValue: "Cover", configKey: "", onSelect: { v => cfg_videoImageFitType = v })
                                ConfigTabSelector(title: "播放按钮图标宽度 - ", options: widthOrHeightList, defaultValue: "60", configKey: "", onSelect: { v => cfg_videoPlayIconWidth = v })
                                ConfigTabSelector(title: "播放按钮图标高度 - ", options: widthOrHeightList, defaultValue: "60", configKey: "", onSelect: { v => cfg_videoPlayIconHeight = v })
                                ConfigTabSelector(title: "播放按钮图标缩放类型 - ", options: imageFitList, defaultValue: "Contain", configKey: "", onSelect: { v => cfg_videoPlayIconFitType = v })
                                ConfigTabSelector(title: "视频时间文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoTimeTextFontSize = v })
                                ConfigTabSelector(title: "视频时间文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoTimeTextFontStyle = v })
                                ConfigTabSelector(title: "视频时间文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", onSelect: { v => cfg_videoTimeTextFontWeight = v })
                                ConfigTabSelector(title: "视频时间文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoTimeTextFontFamily = v })
                                ConfigTabSelector(title: "视频时间文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoTimeTextLineHeight = v })
                                ConfigTabSelector(title: "视频时间文本居右边距 - ", options: marginList, defaultValue: "10", configKey: "", onSelect: { v => cfg_videoTimeTextMarginRight = v })
                                ConfigTabSelector(title: "视频时间文本居底边距 - ", options: marginList, defaultValue: "10", configKey: "", onSelect: { v => cfg_videoTimeTextMarginBottom = v })
                                ConfigTabSelector(title: "底部布局是否显示 - ", options: booleanList, defaultValue: "false", configKey: "", onSelect: { v => cfg_videoBottomLayoutVisible = v })
                                ConfigTabSelector(title: "底部布局距离视频上边距 - ", options: marginList, defaultValue: "14", configKey: "", onSelect: { v => cfg_videoBottomLayoutMarginTop = v })
                                ConfigTabSelector(title: "视频发布按钮是否显示 - ", options: booleanList, defaultValue: "true", configKey: "", onSelect: { v => cfg_videoReleaseButtonVisible = v })
                                ConfigTabSelector(title: "视频发布按钮背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoReleaseButtonBackgroundColor = v })
                                ConfigTabSelector(title: "视频发布按钮宽度 - ", options: widthOrHeightList, defaultValue: "144", configKey: "", onSelect: { v => cfg_videoReleaseButtonWidth = v })
                                ConfigTabSelector(title: "视频发布按钮高度 - ", options: widthOrHeightList, defaultValue: "44", configKey: "", onSelect: { v => cfg_videoReleaseButtonHeight = v })
                                ConfigTabSelector(title: "视频发布按钮左上圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoReleaseButtonRadiusTopLeft = v })
                                ConfigTabSelector(title: "视频发布按钮右上圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoReleaseButtonRadiusTopRight = v })
                                ConfigTabSelector(title: "视频发布按钮左下圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoReleaseButtonRadiusBottomLeft = v })
                                ConfigTabSelector(title: "视频发布按钮右下圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoReleaseButtonRadiusBottomRight = v })
                                ConfigTabSelector(title: "视频发布按钮图标和文本间距 - ", options: spaceList, defaultValue: "6", configKey: "", onSelect: { v => cfg_videoReleaseButtonIconTextGap = v })
                                ConfigTabSelector(title: "视频发布按钮图标宽度 - ", options: widthOrHeightList, defaultValue: "18", configKey: "", onSelect: { v => cfg_videoReleaseButtonIconWidth = v })
                                ConfigTabSelector(title: "视频发布按钮图标高度 - ", options: widthOrHeightList, defaultValue: "18", configKey: "", onSelect: { v => cfg_videoReleaseButtonIconHeight = v })
                                ConfigTabSelector(title: "视频发布按钮默认文本内容 - ", options: videoReleaseButtonTextList, defaultValue: "发布视频", configKey: "", onSelect: { v => cfg_videoReleaseButtonText = v })
                                ConfigTabSelector(title: "视频发布按钮文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoReleaseButtonTextFontColor = v })
                                ConfigTabSelector(title: "视频发布按钮文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoReleaseButtonTextFontSize = v })
                                ConfigTabSelector(title: "视频发布按钮文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoReleaseButtonTextFontStyle = v })
                                ConfigTabSelector(title: "视频发布按钮文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", onSelect: { v => cfg_videoReleaseButtonTextFontWeight = v })
                                ConfigTabSelector(title: "视频发布按钮文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoReleaseButtonTextFontFamily = v })
                                ConfigTabSelector(title: "视频发布按钮文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoReleaseButtonTextLineHeight = v })
                                ConfigTabSelector(title: "视频下载按钮是否显示 - ", options: booleanList, defaultValue: "true", configKey: "", onSelect: { v => cfg_videoDownloadButtonVisible = v })
                                ConfigTabSelector(title: "视频下载按钮背景颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoDownloadButtonBackgroundColor = v })
                                ConfigTabSelector(title: "视频下载按钮宽度 - ", options: widthOrHeightList, defaultValue: "144", configKey: "", onSelect: { v => cfg_videoDownloadButtonWidth = v })
                                ConfigTabSelector(title: "视频下载按钮高度 - ", options: widthOrHeightList, defaultValue: "44", configKey: "", onSelect: { v => cfg_videoDownloadButtonHeight = v })
                                ConfigTabSelector(title: "视频下载按钮左上圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoDownloadButtonRadiusTopLeft = v })
                                ConfigTabSelector(title: "视频下载按钮右上圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoDownloadButtonRadiusTopRight = v })
                                ConfigTabSelector(title: "视频下载按钮左下圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoDownloadButtonRadiusBottomLeft = v })
                                ConfigTabSelector(title: "视频下载按钮右下圆角 - ", options: radiusList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoDownloadButtonRadiusBottomRight = v })
                                ConfigTabSelector(title: "视频下载按钮图标和文本间距 - ", options: spaceList, defaultValue: "6", configKey: "", onSelect: { v => cfg_videoDownloadButtonIconTextGap = v })
                                ConfigTabSelector(title: "视频下载按钮图标宽度 - ", options: widthOrHeightList, defaultValue: "18", configKey: "", onSelect: { v => cfg_videoDownloadButtonIconWidth = v })
                                ConfigTabSelector(title: "视频下载按钮图标高度 - ", options: widthOrHeightList, defaultValue: "18", configKey: "", onSelect: { v => cfg_videoDownloadButtonIconHeight = v })
                                ConfigTabSelector(title: "视频下载按钮默认文本内容 - ", options: videoDownloadButtonTextList, defaultValue: "下载视频", configKey: "", onSelect: { v => cfg_videoDownloadButtonText = v })
                                ConfigTabSelector(title: "视频下载按钮文本颜色 - ", options: colorList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoDownloadButtonTextFontColor = v })
                                ConfigTabSelector(title: "视频下载按钮文本尺寸 - ", options: textSizeList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoDownloadButtonTextFontSize = v })
                                ConfigTabSelector(title: "视频下载按钮文本字体样式 - ", options: fontStyleList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoDownloadButtonTextFontStyle = v })
                                ConfigTabSelector(title: "视频下载按钮文本字体粗细 - ", options: fontWeightList, defaultValue: "Normal", configKey: "", onSelect: { v => cfg_videoDownloadButtonTextFontWeight = v })
                                ConfigTabSelector(title: "视频下载按钮文本字体 - ", options: textTypefaceList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoDownloadButtonTextFontFamily = v })
                                ConfigTabSelector(title: "视频下载按钮文本行高 - ", options: textLineHeightList, defaultValue: "undefined", configKey: "", onSelect: { v => cfg_videoDownloadButtonTextLineHeight = v })
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