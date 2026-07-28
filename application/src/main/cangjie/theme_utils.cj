package ohos_app_cangjie_entry


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
        case "1000" => 1000
        case "2000" => 2000
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

/**
 * 从指定路径加载 rawfile 文本内容（通过互操作 globalThis.loadContent）
 * @param fullPath rawfile 路径
 * @return 文件文本内容
 */
func loadRawfileText(fullPath: String): String {
    callGlobalFunc("loadContent", fullPath)
    return getGlobalString("markdownContent")
}

func parseAppResource(s: String): ?AppResource {
    if (s == "undefined") {
        return None
    }
    try {
        let ctx = getCtx()
        let global = ctx.global
        if (global.hasProperty("appResources")) {
            let resMap = global["appResources"].asObject(ctx)
            if (resMap.hasProperty(s)) {
                let value = resMap[s]
                if (value.isUndefined()) {
                    return None
                }
                let obj = value.asObject()
                return AppResource(
                    String.fromJSValue(ctx, obj["bundleName"]),
                    String.fromJSValue(ctx, obj["moduleName"]),
                    Int32.fromJSValue(ctx, obj["id"]),
                    params: [],
                    resType: Int32.fromJSValue(ctx, obj["type"]),
                )
            }
        }
    } catch (e: Exception) {
    }
    return None
}

