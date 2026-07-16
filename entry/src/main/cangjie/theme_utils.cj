package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import std.sync.Timer
import ohos.concurrency.launch
import markdown.components.*
import markdown.components.theme.*

func parseColor(s: String): Color {
    match (s) {
        case "undefined" => Color.TRANSPARENT
        case "#FF000000" => Color.BLACK
        case "#FFFFFFFF" => Color.WHITE
        case "#FFFF0000" => Color.RED
        case "#FF00FF00" => Color(0xFF00FF00)
        case "#FF0000FF" => Color(0xFF0000FF)
        case "#FF808080" => Color(0xFF808080)
        case "#FFFA8072" => Color(0xFFFA8072)
        case "#FFFFD700" => Color(0xFFFFD700)
        case "#FFEE82EE" => Color(0xFFEE82EE)
        case "#FF7EC0EE" => Color(0xFF7EC0EE)
        case "#00000000" => Color.TRANSPARENT
        case _ => Color.TRANSPARENT
    }
}

func parseFloat64(s: String): Float64 {
    match (s) {
        case "0" => 0.0
        case "0.5" => 0.5
        case "1" => 1.0
        case "2" => 2.0
        case "3" => 3.0
        case "4" => 4.0
        case "5" => 5.0
        case "6" => 6.0
        case "8" => 8.0
        case "10" => 10.0
        case "12" => 12.0
        case "14" => 14.0
        case "15" => 15.0
        case "16" => 16.0
        case "20" => 20.0
        case "24" => 24.0
        case "25" => 25.0
        case "30" => 30.0
        case "36" => 36.0
        case "40" => 40.0
        case "50" => 50.0
        case "80" => 80.0
        case "100" => 100.0
        case "150" => 150.0
        case "300" => 300.0
        case "500" => 500.0
        case "-6" => -6.0
        case "-4" => -4.0
        case "-2" => -2.0
        case _ => 0.0
    }
}

func parseInt64(s: String): Int64 {
    match (s) {
        case "0" => 0
        case "1" => 1
        case "2" => 2
        case "5" => 5
        case "8" => 8
        case "10" => 10
        case "15" => 15
        case "20" => 20
        case "50" => 50
        case "100" => 100
        case "200" => 200
        case "500" => 500
        case _ => 0
    }
}

func parseBool(s: String): Bool {
    s == "true"
}

func parseFontWeight(s: String): FontWeight {
    match (s) {
        case "Lighter" => FontWeight.W100
        case "Normal" => FontWeight.W400
        case "Regular" => FontWeight.W400
        case "Medium" => FontWeight.W500
        case "Bold" => FontWeight.W700
        case "Bolder" => FontWeight.W900
        case _ => FontWeight.W400
    }
}

func parseFontStyle(s: String): FontStyle {
    match (s) {
        case "Normal" => FontStyle.Normal
        case "Italic" => FontStyle.Italic
        case _ => FontStyle.Normal
    }
}

func parseBorderStyle(s: String): BorderStyle {
    match (s) {
        case "Solid" => BorderStyle.Solid
        case "Dashed" => BorderStyle.Dashed
        case "Dotted" => BorderStyle.Dotted
        case _ => BorderStyle.Solid
    }
}

func parseLineCapStyle(s: String): LineCapStyle {
    match (s) {
        case "Butt" => LineCapStyle.Butt
        case "Round" => LineCapStyle.Round
        case "Square" => LineCapStyle.Square
        case _ => LineCapStyle.Butt
    }
}

func parseImageFit(s: String): ImageFit {
    match (s) {
        case "Contain" => ImageFit.Contain
        case "Cover" => ImageFit.Cover
        case "Auto" => ImageFit.Auto
        case "Fill" => ImageFit.Fill
        case "None" => ImageFit.None
        case "ScaleDown" => ImageFit.ScaleDown
        case _ => ImageFit.Contain
    }
}

func parseTextDecorationType(s: String): TextDecorationType {
    match (s) {
        case "None" => TextDecorationType.None
        case "Underline" => TextDecorationType.Underline
        case "Overline" => TextDecorationType.Overline
        case "LineThrough" => TextDecorationType.LineThrough
        case _ => TextDecorationType.None
    }
}

func parseTextDecorationStyle(s: String): MarkdownTextDecorationStyle {
    match (s) {
        case "SOLID" => MarkdownTextDecorationStyle.SOLID
        case "DOUBLE" => MarkdownTextDecorationStyle.DOUBLE
        case "DOTTED" => MarkdownTextDecorationStyle.DOTTED
        case "DASHED" => MarkdownTextDecorationStyle.DASHED
        case "WAVY" => MarkdownTextDecorationStyle.WAVY
        case _ => MarkdownTextDecorationStyle.SOLID
    }
}

func parseBarState(s: String): BarState {
    match (s) {
        case "Off" => BarState.Off
        case "On" => BarState.On
        case "Auto" => BarState.Auto
        case _ => BarState.Off
    }
}

func parseCheckBoxShape(s: String): CheckBoxShape {
    match (s) {
        case "CIRCLE" => CheckBoxShape.CIRCLE
        case "ROUNDED_SQUARE" => CheckBoxShape.ROUNDED_SQUARE
        case _ => CheckBoxShape.ROUNDED_SQUARE
    }
}

func parseLatexMathColorFormat(s: String): LatexMathColorFormat {
    match (s) {
        case "COLOR_FORMAT_RGB_565" => LatexMathColorFormat.COLOR_FORMAT_RGB_565
        case "COLOR_FORMAT_BGRA_8888" => LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
        case _ => LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
    }
}

func getConfig(key: String, defaultValue: String): String {
    let v = getGlobalString(key)
    if (v == "") {
        return defaultValue
    }
    return v
}

func createGeneralConfig(): MarkdownConfiguration {
    let themeBuilder = MarkdownTheme.createDefaultBuilder()
    let globalTheme = GlobalTheme()
    globalTheme.blockMarginTop = parseFloat64(getConfig("config_blockMarginTop", "0"))
    globalTheme.blockMarginRight = parseFloat64(getConfig("config_blockMarginRight", "0"))
    globalTheme.blockMarginBottom = parseFloat64(getConfig("config_blockMarginBottom", "0"))
    globalTheme.blockMarginLeft = parseFloat64(getConfig("config_blockMarginLeft", "0"))
    globalTheme.markdownBlockSpacing = parseInt64(getConfig("config_markdownBlockSpacing", "8"))
    globalTheme.isLineBreak = parseBool(getConfig("config_isLineBreak", "false"))
    globalTheme.isOnCopy = parseBool(getConfig("config_isOnCopy", "false"))
    globalTheme.isMarkdownParserSync = parseBool(getConfig("config_isMarkdownParserSync", "false"))
    globalTheme.openGestureSwipe = parseBool(getConfig("config_openGestureSwipe", "false"))
    globalTheme.enableParseThrottle = parseBool(getConfig("config_enableParseThrottle", "false"))
    globalTheme.parseThrottleMs = parseInt64(getConfig("config_parseThrottleMs", "200"))
    let bgColor = getConfig("config_backgroundColor", "undefined")
    if (bgColor != "undefined") {
        globalTheme.backgroundColor = parseColor(bgColor)
    }
    themeBuilder.setGlobalTheme(globalTheme)
    let theme = themeBuilder.build()
    let configBuilder = MarkdownConfiguration.emptyBuilder()
    configBuilder.setMarkdownTheme(theme)
    return configBuilder.build()
}

/**
 * 从指定路径加载 rawfile 文本内容（通过互操作 globalThis.loadContent）
 * @param fullPath rawfile 路径
 * @return 文件文本内容
 */
func loadRawfileText(fullPath: String): String {
    callGlobalFunc("loadContent", fullPath)
    return getGlobalString("markdownContent")
}

/**
 * 增量流式输出辅助函数
 * 根据全量/增量配置选择加载方式：
 *   - isFull=true: 一次性返回全部内容
 *   - isFull=false: 通过回调分块回传，模拟流式输出
 *
 * @param fullContent 完整文本
 * @param isFull 是否全量加载
 * @param textNumber 每次增量文本数量
 * @param timeMs 增量加载间隔时间(ms)
 * @param onChunk 每次增量的回调(累计内容, 是否结束)
 */
public func streamLoad(
    fullContent: String,
    isFull: Bool,
    textNumber: Int64,
    timeMs: Int64,
    onChunk: (String, Bool) -> Unit
): Unit {
    if (isFull) {
        onChunk(fullContent, true)
        return
    }
    if (fullContent.size == 0) {
        onChunk("", true)
        return
    }
    streamStep(fullContent, 0, textNumber, timeMs, onChunk)
}

/**
 * 流式加载单步推进（递归通过 Timer.once 调度）
 *
 * @param fullContent 完整文本
 * @param index 当前累计输出位置
 * @param textNumber 每次增量文本数量
 * @param timeMs 增量加载间隔时间(ms)
 * @param onChunk 每次增量的回调(累计内容, 是否结束)
 */
public func streamStep(
    fullContent: String,
    index: Int64,
    textNumber: Int64,
    timeMs: Int64,
    onChunk: (String, Bool) -> Unit
): Unit {
    let total = fullContent.size
    var next = index + textNumber
    if (next > total) {
        next = total
    }
    let cumulative = fullContent[0..next]
    let ended = (next >= total)
    onChunk(cumulative, ended)
    if (!ended) {
        let nextStep = next
        Timer.once(timeMs * Duration.millisecond) { =>
            launch {
                streamStep(fullContent, nextStep, textNumber, timeMs, onChunk)
            }
        }
    }
}
