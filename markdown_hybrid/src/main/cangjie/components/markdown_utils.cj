/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

let COLOR_191919: Color = Color(0x191919)
let COLOR_0000FF: Color = Color(0x0000FF)
let COLOR_FF0000: Color = Color(0xFF0000)
let COLOR_000000: Color = Color(0x000000)
let COLOR_FFEAEAEA: Color = Color(0xFFEAEAEA)
let COLOR_00000000: Color = Color(0x00000000)
let COLOR_FF000000: Color = Color(0xFF000000)
let COLOR_FFFFFF: Color = Color(0xFFFFFF)
let COLOR_FFFFFFFF: Color = Color(0xFFFFFFFF)
let COLOR_00FFFFFF: Color = Color(0x00FFFFFF)
let COLOR_E0E0E0: Color = Color(0xE0E0E0)
let COLOR_FFE0E0E0: Color = Color(0xFFE0E0E0)
let COLOR_333333: Color = Color(0x333333)
let COLOR_1A000000: Color = Color(0x1A000000)
let COLOR_33000000: Color = Color(0x33000000)
let COLOR_FF0000FF: Color = Color(0xFF0000FF)
let COLOR_FF191919: Color = Color(0xFF191919)
let COLOR_80000000: Color = Color(0x80000000)
let COLOR_01000000: Color = Color(0x01000000)
let COLOR_FF4B4F52: Color = Color(0xFF4B4F52)
let COLOR_FF2D2D2D: Color = Color(0xFF2D2D2D)
let COLOR_1AFFFFFF: Color = Color(0x1AFFFFFF)
let COLOR_33FFFFFF: Color = Color(0x33FFFFFF)
let COLOR_80FFFFFF: Color = Color(0x80FFFFFF)
let COLOR_E6000000: Color = Color(0xE6000000)
let COLOR_FFF5F5F5: Color = Color(0xFFF5F5F5)
let SECONDS_PER_HOUR: Int64 = 3600
let SECONDS_PER_MINUTE: Int64 = 60

/**
 * 上边距
 *
 * @param idx 第几条数据
 * @param nodeType 类型。0：标题，1：段落，2：分割线，3：其他
 * @param item nodeView对象
 * @return Float64 上边距
 */
func marginNodeTop(idx: Int64, item: NodeView, markdownTheme: MarkdownTheme): Float64 {
    if (idx == 0) {
        return markdownTheme.blockFirstTopMargin
    }
    if (item.nodeType == "Heading" || item.nodeType == "IdHeading") {
        // 标题
        if (item.children.size == 1 && (item.children[0].nodeType == "Image" || item.children[0].nodeType == "StyleImage" || item.children[0].nodeType == "ImageHtmlNode")) {
            return 0.0
        } else {
            return markdownTheme.headingTopMargins
        }
    }
    if (item.nodeType == "Paragraph") {
        // 段落
        if (item.children.size == 1 && (item.children[0].nodeType == "Image" || item.children[0].nodeType == "StyleImage" || item.children[0].nodeType == "ImageHtmlNode")) {
            return 0.0
        } else {
            return markdownTheme.paragraphTopMargins
        }
    }
    if (item.nodeType == "ThematicBreak") {
        // 分割线
        return markdownTheme.blockTopAndBottomMargins + markdownTheme.thematicBreakTopMargin
    }
    return markdownTheme.blockTopAndBottomMargins
}

/**
 * 下边距
 *
 * @param idx 第几条数据
 * @param nodeType 类型。0：标题，1：段落，2：分割线，3：其他
 * @param item nodeView对象
 * @return Float64 上边距
 */
func marginNodeBottom(idx: Int64, size: Int64, item: NodeView, markdownTheme: MarkdownTheme): Float64 {
    if (idx == size) {
        return markdownTheme.blockLastBottomMargin
    }
    if (item.nodeType == "Heading" || item.nodeType == "IdHeading") {
        // 标题
        if (item.children.size == 1 && (item.children[0].nodeType == "Image" || item.children[0].nodeType == "StyleImage" || item.children[0].nodeType == "ImageHtmlNode")) {
            return 0.0
        } else {
            return markdownTheme.headingTopMargins
        }
    }
    if (item.nodeType == "Paragraph") {
        // 段落
        if (item.children.size == 1 && (item.children[0].nodeType == "Image" || item.children[0].nodeType == "StyleImage" || item.children[0].nodeType == "ImageHtmlNode")) {
            return 0.0
        } else {
            return markdownTheme.paragraphTopMargins
        }
    }
    if (item.nodeType == "ThematicBreak") {
        // 分割线
        return markdownTheme.blockTopAndBottomMargins + markdownTheme.thematicBreakTopMargin
    }
    return markdownTheme.blockTopAndBottomMargins
}

/**
 * 点击事件
 *
 * @param markdownConfiguration MarkdownConfiguration
 * @param nodeView NodeView
 * @param tocListOnClick toc点击事件
 * @param footnoteCallback 脚注点击事件
 */
func spanOnClick(markdownConfiguration: MarkdownConfiguration, nodeView: NodeView, tocListOnClick: ?(Int64) -> Unit, footnoteCallback: (String) -> Unit): Unit {
    if (nodeView.footnoteID.isSome()) {
        footnoteCallback(nodeView.footnoteID()) // 脚注
        return
    }
    if (nodeView.headLinkIndex.isSome() && tocListOnClick.isSome()) {
        tocListOnClick()(nodeView.headLinkIndex()) // TOC/标题ID
        return
    }
    if (markdownConfiguration.linkCallback.isSome() && nodeView.linkUrl.isSome()) {
        markdownConfiguration.linkCallback()(nodeView.linkUrl()) // 链接
        return
    }
}

/**
 * 设置文本内容
 *
 * @param str 文本内容
 * @return (String, String)
 */
func spanEndText(str: String): (String, String) {
    if (str.size <= 0) {
        return ("", "")
    }
    var index = str.size - 1
    let arr = unsafe { str.rawData() }
    while (index >= 0) {
        if ((arr[index] >> 6) != 0b10) {
            break
        }
        index--
    }
    let start = str[..index]
    let end = str[index..]
    return (start, end)
}

/**
 * 设置字体样式列表
 *
 * @param nodeView NodeView
 * @param markdownTheme markdown样式
 * @return 字体样式列表
 */
func spanFontFamily(nodeView: NodeView, markdownTheme: MarkdownTheme): String {
    if (nodeView.isInLineCode) {
        return markdownTheme.codeTypeface // 内联代码
    }
    if (nodeView.isHeading) {
        return markdownTheme.headingTypeface // 标题
    }
    return markdownTheme.paragraphTypeface // 段落和其他
}

/**
 * 设置文字字体大小
 *
 * @param nodeView NodeView
 * @param markdownTheme markdown样式
 * @return 文字字体大小
 */
func spanFontSize(nodeView: NodeView, markdownTheme: MarkdownTheme): Float64 {
    if (nodeView.isSubNode) {
        return markdownTheme.subTextSize // 下标
    }
    if (nodeView.isSupNode) {
        return markdownTheme.supTextSize // 上标
    }
    if (nodeView.isFontNode) {
        if (let Some(v) <- nodeView.fontNodeSize) {
            return v // FontNode
        }
    }
    if (nodeView.isSpanNode) {
        if (let Some(v) <- nodeView.spanNodeSize) {
            return v // SpanNode
        }
    }
    if (nodeView.isInLineCode) {
        return markdownTheme.codeTextSize // 内联代码
    }
    if (nodeView.isLink && markdownTheme.isLinkSize) {
        return markdownTheme.linkSize // 链接
    }
    if (nodeView.isHeading) {
        return headingTextSize(nodeView.headingLevel, markdownTheme) // 标题
    }
    if (nodeView.isTable && nodeView.isTableHead) {
        return markdownTheme.tableTitleTextSize // 表格头
    }
    if (nodeView.isTable) {
        return markdownTheme.tableContentTextSize // 表格内容
    }
    return markdownTheme.paragraphTextSize // 段落和其他
}

/**
 * 设置不同等级标题文本大小
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题文本大小
 */
func headingTextSize(level: Int64, markdownTheme: MarkdownTheme): Float64 {
    return match (level) {
        case 1 => markdownTheme.headingTextSize1
        case 2 => markdownTheme.headingTextSize2
        case 3 => markdownTheme.headingTextSize3
        case 4 => markdownTheme.headingTextSize4
        case 5 => markdownTheme.headingTextSize5
        case 6 => markdownTheme.headingTextSize6
        case _ => markdownTheme.headingTextSize6
    }
}

/**
 * 设置文字样式加粗
 *
 * @param spanNode SpanNode
 * @param isTitle 是否标题中
 * @param isDescTerm 是否在定义列表术语中
 * @param isStrongEmphasis 是否在加粗中
 * @return 文字样式加粗
 */
func spanFontWeight(nodeView: NodeView, isTableFirst: Bool): FontWeight {
    if (nodeView.isSpanNode) {
        if (let Some(v) <- nodeView.spanNodeWeight) {
            return v // SpanNode
        }
    }
    if (nodeView.isHeading || nodeView.isDescTerm || nodeView.isStrongEmphasis || (nodeView.isTable && nodeView.isTableHead) || isTableFirst) {
        return FontWeight.W600 // 标题/定义列表术语/加粗/表格头/表格第一列文本
    }
    return FontWeight.W400 // 其他
}

/**
 * 设置文字样式斜体
 *
 * @param isDescTerm 是否在定义列表术语中
 * @param isEmphasis 是否在斜体中
 * @return 文字样式斜体
 */
func spanFontStyle(nodeView: NodeView): FontStyle {
    if (nodeView.isDescTerm || nodeView.isEmphasis) {
        return FontStyle.Italic // 定义列表术语/斜体
    }
    return FontStyle.Normal // 其他
}

/**
 * 设置文本字体颜色
 *
 * @param isSubNode 是否在下标中
 * @param isSupNode 是否在上标中
 * @param fontNode 是否在FontNode中
 * @param spanNode 是否在SpanNode中
 * @param isCode 是否在内联代码中
 * @param isLink 是否在连接中，并且显示链接自己的字体大小
 * @param isTitle 是否在标题中
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 文本字体颜色
 */
func spanFontColor(nodeView: NodeView, markdownTheme: MarkdownTheme): Color {
    if (nodeView.isSubNode) {
        return markdownTheme.subTextColor // 下标
    }
    if (nodeView.isSupNode) {
        return markdownTheme.supTextColor // 上标
    }
    if (nodeView.isFontNode) {
        if (let Some(v) <- nodeView.fontNodeColor) {
            return v // FontNode
        }
    }
    if (nodeView.isSpanNode) {
        if (let Some(v) <- nodeView.spanNodeColor) {
            return v // SpanNode
        }
    }
    if (nodeView.isLink || nodeView.isFootnote) {
        return markdownTheme.linkColor // 链接, 脚注
    }
    if (nodeView.isInLineCode) {
        return markdownTheme.codeTextColor // 内联代码
    }
    if (nodeView.isHeading) {
        return headColor(nodeView.headingLevel, markdownTheme) // 标题
    }
    if (nodeView.isTable && nodeView.isTableHead) {
        return markdownTheme.tableTitleTextColor // 表格头
    }
    if (nodeView.isTable) {
        return markdownTheme.tableContentTextColor // 表格内容
    }
    return markdownTheme.paragraphTextColor // 段落和其他
}

/**
 * 设置不同等级标题颜色
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题颜色
 */
func headColor(level: Int64, markdownTheme: MarkdownTheme): Color {
    return match (level) {
        case 1 => markdownTheme.headingTextColor1
        case 2 => markdownTheme.headingTextColor2
        case 3 => markdownTheme.headingTextColor3
        case 4 => markdownTheme.headingTextColor4
        case 5 => markdownTheme.headingTextColor5
        case 6 => markdownTheme.headingTextColor6
        case _ => markdownTheme.headingTextColor6
    }
}

/**
 * 设置文本字符间距
 *
 * @param isHeading 是否在标题中
 * @param markdownTheme markdown样式
 * @return 文本基线的偏移量
 */
func spanLetterSpacing(nodeView: NodeView, markdownTheme: MarkdownTheme): Float64 {
    if (nodeView.isHeading) {
        return markdownTheme.headingTextWordSpace // 标题
    }
    return markdownTheme.paragraphTextWordSpace // 段落和其他
}

/**
 * 设置文本下划线中划线
 *
 * @param isUnderlineNode 是否在下划线中
 * @param isStrikethrough 是否在删除线中
 * @param isLink 是否在链接中
 * @param markdownTheme markdown样式
 * @return 文本下划线中划线
 */
func spanDecoration(nodeView: NodeView, markdownTheme: MarkdownTheme): (TextDecorationType, Color, Int32) {
    if (nodeView.isUnderlineNode) {
        return (TextDecorationType.Underline, markdownTheme.underlineColor, markdownTheme.underlineStyle) // 下划线
    }
    if (nodeView.isStrikethrough) {
        return (TextDecorationType.LineThrough, markdownTheme.strikethroughColor, markdownTheme.strikethroughStyle) // 删除线
    }
    if (nodeView.isLink || nodeView.isFootnote) {
        return (TextDecorationType.Underline, markdownTheme.linkColor, 0) // 链接, 脚注
    }
    return (TextDecorationType.None, Color.TRANSPARENT, 0) // 其他
}

/**
 * 设置文本背景色
 *
 * @param isCode 是否在内联代码中
 * @param isLink 是否在链接中
 * @param markdownTheme markdown样式
 * @return 文本背景色
 */
func spanBackgroundColor(nodeView: NodeView, markdownTheme: MarkdownTheme): Color {
    if (nodeView.isInLineCode) {
        return markdownTheme.codeBackgroundColor // 内联代码
    }
    if (nodeView.isLink) {
        return markdownTheme.linkBackGroupColor // 链接
    }
    return Color.TRANSPARENT // 其他
}

/**
 * 设置文本基线的偏移量
 *
 * @param isSubNode 是否在下标中
 * @param isSupNode 是否在上标中
 * @param markdownTheme markdown样式
 * @return 文本基线的偏移量
 */
func spanBaselineOffset(nodeView: NodeView, markdownTheme: MarkdownTheme): Float64 {
    if (nodeView.isSubNode) {
        return markdownTheme.subOffsetDist // 下标
    }
    if (nodeView.isSupNode) {
        return markdownTheme.supOffsetDist // 上标
    }
    return 0.0 // 其他
}

/**
 * 设置文本行高
 *
 * @param isHeading 是否在标题中
 * @param level 标题等级
 * @param isTable 是否在表格中
 * @param markdownTheme markdown样式
 * @return 文本行高
 */
func spanLineHeight(nodeView: NodeView, markdownTheme: MarkdownTheme): Float64 {
    if (nodeView.isHeading) {
        return headLineHeight(nodeView.headingLevel, markdownTheme) // 标题
    }
    if (nodeView.isTable && nodeView.isTableHead) {
        return markdownTheme.tableTitleLineHeight // 表格头
    }
    if (nodeView.isTable) {
        return markdownTheme.tableTextLineHeight // 表格
    }
    if (nodeView.isLink) {
        return markdownTheme.linkLineHeight // 链接
    }
    return markdownTheme.paragraphTextLineHeight // 段落和其他
}

/**
 * 设置标题行高
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题行高
 */
func headLineHeight(level: Int64, markdownTheme: MarkdownTheme): Float64 {
    return match (level) {
        case 1 => markdownTheme.headingTextLineHeight1
        case 2 => markdownTheme.headingTextLineHeight2
        case 3 => markdownTheme.headingTextLineHeight3
        case 4 => markdownTheme.headingTextLineHeight4
        case 5 => markdownTheme.headingTextLineHeight5
        case 6 => markdownTheme.headingTextLineHeight6
        case _ => markdownTheme.headingTextLineHeight6
    }
}

/**
 * 判断软换行是否换行
 *
 * @param isLineBreak 软换行是否需要换行
 * @return 返回需要换行或者空格的内容
 */
func spanSoftLineBreak(isLineBreak: Bool): String {
    if (isLineBreak) {
        return "\n"
    } else {
        return " "
    }
}

/**
 * 组合代码解析
 *
 * @param codeBlockListNodeView NodeView
 * @return 返回代码类型列表、代码内容列表、代码真实类型列表
 */
func toCodeList(codeBlockListNodeView: NodeView): (ArrayList<String>, ArrayList<String>, ArrayList<String>) {
    var strText: ArrayList<String> = ArrayList<String>()
    var strInfoText: ArrayList<String> = ArrayList<String>()
    var strInfo: ArrayList<String> = ArrayList<String>()
    for (nodeView in codeBlockListNodeView.children) {
        if (nodeView.nodeType == "FencedCodeBlock") {
            strText.add(nodeView.nodeText)
            strInfoText.add(nodeView.codeInfo.getOrThrow())
        }
    }
    if (codeBlockListNodeView.nodeType == "FencedCodeBlockListBlock") {
        strInfo = codeBlockListNodeView.codeListTab.getOrThrow()
    }
    return (strInfo, strText, strInfoText)
}

/**
 * 前缀显示文本内容
 *
 * @param item NodeView
 * @param isBullet 是否是无序列表
 * @param markdownConfiguration MarkdownConfiguration
 * @return 返回前缀文本内容
 */
func listPrefixStr(item: NodeView, listDepth: Int64, isBullet: Bool, markdownTheme: MarkdownTheme): String {
    if (isBullet) {
        // 有序列表
        return "${item.orderedListNumber}."
    }
    if (markdownTheme.bulletListItemCircle) {
        return "${solidCircleToUnicode()}"
    }
    if (listDepth == 0) {
        return "${solidCircleToUnicode()}"
    }
    if (listDepth == 1) {
        return "${hollowCircleToUnicode()}"
    }
    return "${solidSquareToUnicode()}"
}

/**
 * 实心圆形
 *
 * @return 实心圆形UniCode码
 */
func solidCircleToUnicode(): Rune {
    // ●
    let solidDots: Rune = '\u{25CF}'
    return solidDots
}

/**
 * 空心圆形
 *
 * @return 空心圆形UniCode码
 */
func hollowCircleToUnicode(): Rune {
    // ○
    let hollowCircle: Rune = '\u{25CB}'
    return hollowCircle
}

/**
 * 实心正方形
 *
 * @return 实心正方形UniCode码
 */
func solidSquareToUnicode(): Rune {
    // ■
    let solidSquare: Rune = '\u{25A0}'
    return solidSquare
}

/**
 * 前缀显示文本内容颜色
 *
 * @param markdownTheme MarkdownTheme
 * @param isBullet 是否是无序列表
 * @return 返回前缀文本内容颜色
 */
func listPrefixColor(markdownTheme: MarkdownTheme, isBullet: Bool): Color {
    if (isBullet) {
        // 有序列表
        return markdownTheme.orderedListItemColor
    } else {
        // 无序列表
        return markdownTheme.bulletListItemColor
    }
}

/**
 * 前缀显示文本内容大小
 *
 * @param markdownTheme MarkdownTheme
 * @param isBullet 是否是无序列表
 * @return 返回前缀文本内容大小
 */
func listPrefixSize(markdownTheme: MarkdownTheme, isBullet: Bool): Float64 {
    if (isBullet) {
        // 有序列表
        return markdownTheme.orderedListItemSize
    } else {
        // 无序列表
        return markdownTheme.bulletListItemSize
    }
}

/**
 * 有序/无序列表前缀显示文本行高
 *
 * @param isBullet 是否是无序列表
 * @param markdownConfiguration MarkdownConfiguration
 * @return 返回前缀文本行高
 */
func listPrefixLineHeight(isBullet: Bool, markdownTheme: MarkdownTheme): Float64 {
    if (isBullet) {
        // 有序列表
        return markdownTheme.orderedListItemLineHeight
    } else {
        return markdownTheme.bulletListItemLineHeight
    }
}

/**
 * 将Length转换成PX格式的Float64
 *
 * @param length Length
 * @param componentImageWidth 控件宽度
 * @return Option<Float64> PX格式的Float64
 */
func length2FloatPx(length: Option<Length>, componentImageWidth: Float64): Option<Float64> {
    if (let Some(v) <- length) {
        return match (v.unitType) {
            case LengthType.vp(w) => vp2px(w.vp)().value
            case LengthType.px(w) => w
            case LengthType.percent(w) => componentImageWidth * w
            case _ => Option<Float64>.None
        }
    } else {
        return Option<Float64>.None
    }
}

/**
 * 处理图片的宽高
 *
 * @param componentImageWidth 控件宽度
 * @param imageResWidth 图片真实宽度
 * @param imageResHeight 图片真实高度
 * @param imageWidth 图片设置宽度
 * @param imageHeight 图片设置高度
 * @param imageMaxWidth 图片设置宽度
 * @param imageFixedRatioWidth 图片基于父布局宽度缩放百分比
 * @param imageMaximumWidth 图片基于自身宽度缩放百分比
 * @return (Float64, Float64) 图片的宽高单位是PX
 */
func imageWidthAndHeight(
    componentImageWidth: Float64,
    imageResWidth: Float64,
    imageResHeight: Float64,
    imageWidth: Option<Length>,
    imageHeight: Option<Length>,
    imageMaxWidth: ?Float64,
    imageMaxHeight: ?Float64,
    imageFixedRatioWidth: Option<Float64>,
    imageMaximumWidth: Float64
): (Float64, Float64) {
    var width: Float64 = 0.0
    var height: Float64 = 0.0
    let componentImageWidthNew = if (let Some(v) <- imageMaxWidth) {
        let imageMaxWidthNew = vp2px(v.vp)().value
        if (imageMaxWidthNew < componentImageWidth) {
            imageMaxWidthNew
        } else {
            componentImageWidth
        }
    } else {
        componentImageWidth
    }
    let aspectRatio: Float64 = imageResHeight / imageResWidth // 原图宽高比
    let imageWidthPx: ?Float64 = length2FloatPx(imageWidth, componentImageWidth)
    let imageHeightPx: ?Float64 = length2FloatPx(imageHeight, componentImageWidth)
    if (imageWidthPx.isSome() && imageHeightPx.isSome()) {
        let aspectRatioNew: Float64 = imageHeightPx() / imageWidthPx()
        var widthNew = if (imageFixedRatioWidth.isSome()) {
            componentImageWidth * imageFixedRatioWidth()
        } else {
            imageWidthPx() * imageMaximumWidth
        }
        widthNew = if (componentImageWidthNew > widthNew) {
            widthNew
        } else {
            componentImageWidthNew
        }
        var heightNew: Float64 = widthNew * aspectRatioNew
        if (imageMaxHeight.isSome()) {
            let imageMaxHeightPX = vp2px(imageMaxHeight().vp)().value
            if (heightNew < imageMaxHeightPX) {
                width = widthNew
                height = heightNew
            } else {
                let aspectRatioHeightNew = imageMaxHeightPX / heightNew
                width = widthNew * aspectRatioHeightNew
                height = imageMaxHeightPX
            }
        } else {
            width = widthNew
            height = heightNew
        }
    } else if (imageWidthPx.isSome() && imageHeightPx.isNone()) {
        var widthNew = if (imageFixedRatioWidth.isSome()) {
            componentImageWidth * imageFixedRatioWidth()
        } else {
            imageWidthPx() * imageMaximumWidth
        }
        widthNew = if (componentImageWidthNew > widthNew) {
            widthNew
        } else {
            componentImageWidthNew
        }
        var heightNew: Float64 = widthNew * aspectRatio
        if (imageMaxHeight.isSome()) {
            let imageMaxHeightPX = vp2px(imageMaxHeight().vp)().value
            if (heightNew < imageMaxHeightPX) {
                width = widthNew
                height = heightNew
            } else {
                let aspectRatioHeightNew = imageMaxHeightPX / heightNew
                width = widthNew * aspectRatioHeightNew
                height = imageMaxHeightPX
            }
        } else {
            width = widthNew
            height = heightNew
        }
    } else if (imageWidthPx.isNone() && imageHeightPx.isSome()) {
        var widthNew = if (imageFixedRatioWidth.isSome()) {
            componentImageWidth * imageFixedRatioWidth()
        } else {
            imageHeightPx() / aspectRatio * imageMaximumWidth
        }
        widthNew = if (componentImageWidthNew > widthNew) {
            widthNew
        } else {
            componentImageWidthNew
        }
        var heightNew: Float64 = widthNew * aspectRatio
        if (imageMaxHeight.isSome()) {
            let imageMaxHeightPX = vp2px(imageMaxHeight().vp)().value
            if (heightNew < imageMaxHeightPX) {
                width = widthNew
                height = heightNew
            } else {
                let aspectRatioHeightNew = imageMaxHeightPX / heightNew
                width = widthNew * aspectRatioHeightNew
                height = imageMaxHeightPX
            }
        } else {
            width = widthNew
            height = heightNew
        }
    } else {
        var widthNew = if (imageFixedRatioWidth.isSome()) {
            componentImageWidth * imageFixedRatioWidth()
        } else {
            imageResWidth * imageMaximumWidth
        }
        widthNew = if (componentImageWidthNew > widthNew) {
            widthNew
        } else {
            componentImageWidthNew
        }
        var heightNew: Float64 = widthNew * aspectRatio
        if (imageMaxHeight.isSome()) {
            let imageMaxHeightPX = vp2px(imageMaxHeight().vp)().value
            if (heightNew < imageMaxHeightPX) {
                width = widthNew
                height = heightNew
            } else {
                let aspectRatioHeightNew = imageMaxHeightPX / heightNew
                width = widthNew * aspectRatioHeightNew
                height = imageMaxHeightPX
            }
        } else {
            width = widthNew
            height = heightNew
        }
    }
    return (width, height)
}

/**
 * 获取链接文本
 *
 * @param stringClass 文本对象
 * @param commonmarkNode nodeView
 * @return 链接文本
 */
func getLinkString(stringClass: StringClass, commonmarkNode: CommonmarkNode): String {
    commonmarkNode.iterateChildren().forEach(
            {
                commonmarkChildrenNode: CommonmarkNode =>
                    let nodeType = commonmarkChildrenNode.getNodeType()
                    if (nodeType == "Text") {
                        stringClass.addString((commonmarkChildrenNode as CommonmarkText)().getLiteral())
                    } else if (nodeType == "Code") {
                        stringClass.addString((commonmarkChildrenNode as Code)().getLiteral())
                    } else if (nodeType == "Footnote") {
                        stringClass.addString((commonmarkChildrenNode as Footnote)().noteid)
                    } else if (nodeType == "LatexMathNode") {
                        stringClass.addString((commonmarkChildrenNode as LatexMathNode)().latex)
                    } else {
                        stringClass.addString(getLinkString(stringClass, commonmarkChildrenNode))
                    }
            }
        )
    return stringClass.str
}

/**
 * 对每张图片的 style 进行解析
 *
 * @param picStyle 图片样式集合
 * @return PicStyleObj对象
 */
func parsePicStyle(picStyle: ArrayList<String>): PicStyleObj {
    let picStyleObj: PicStyleObj = PicStyleObj()
    if (picStyle.isEmpty()) {
        return picStyleObj
    }
    var index = 0
    while (index < picStyle.size) {
        try {
            let str = picStyle[index]
            index++
            if (str.size < 7) {
                continue
            }
            let style = str.replace(" ", "").replace("\"", "").toAsciiLower()
            if (style[..7] == ":width=") {
                let value = style[7..]
                if (value.size <= 1) {
                    let picStyleObjWidth: Length = Int64.parse(value).vp
                    picStyleObj.width = picStyleObjWidth
                }
                if (value[value.size - 2..] == "px") {
                    let picStyleObjWidth: Length = Int64.parse(value[..value.size - 2]).px
                    picStyleObj.width = picStyleObjWidth
                } else if (value[value.size - 1..] == "%") {
                    let opt = Int64.parse(value[..value.size - 1])
                    if (opt <= 100) {
                        picStyleObj.width = opt.percent
                    }
                } else {
                    let picStyleObjWidth: Length = Int64.parse(value).vp
                    picStyleObj.width = picStyleObjWidth
                }
            } else if (style[..8] == ":height=") {
                let value = style[8..]
                if (value.size <= 1) {
                    picStyleObj.height = Int64.parse(value).vp
                }
                if (value[value.size - 2..] == "px") {
                    picStyleObj.height = Int64.parse(value[..value.size - 2]).px
                } else if (value[value.size - 1..] == "%") {
                    let opt = Int64.parse(value[..value.size - 1])
                    if (opt <= 100) {
                        picStyleObj.height = opt.percent
                    }
                } else {
                    picStyleObj.height = Int64.parse(value).vp
                }
            } else if (style[..7] == ":align=") {
                let value = style[7..]
                match (value) {
                    case "left" => picStyleObj.align = HorizontalAlign.Start
                    case "center" => picStyleObj.align = HorizontalAlign.Center
                    case "right" => picStyleObj.align = HorizontalAlign.End
                    case _ => ()
                }
            } else if (style.size > 15 && style[..15] == ":border-radius=") {
                let value = style[15..]
                if (value[value.size - 2..] == "px") {
                    picStyleObj.borderRadius = Int64.parse(value[..value.size - 2]).px
                } else {
                    picStyleObj.borderRadius = Int64.parse(value).vp
                }
            } else if (style[..7] == ":style=") {
                for (s in style[7..].split(";")) {
                    picStyle.add(":${s.replace(":", "=")}")
                }
            }
        } catch (e: Exception) {}
    }
    return picStyleObj
}

/**
 * 判断控件的显示和隐藏
 *
 * @param isVisibility 显示和隐藏
 * @return 显示和隐藏
 */
func isVisibility(isVisibility: Bool): Visibility {
    if (isVisibility) {
        return Visibility.Visible
    } else {
        return Visibility.None
    }
}

/**
 * 代码列表标签文本颜色，切换显示
 *
 * @param idxSelect 选中的第几条
 * @param idx 点击第几条
 * @param markdownConfiguration MarkdownConfiguration
 * @return 切换之后的文本颜色
 */
func listCodeTextColor(idxSelect: Int64, idx: Int64, markdownConfiguration: MarkdownConfiguration): Color {
    if (idxSelect == idx) {
        return markdownConfiguration.markdownTheme.codeListTitleSelectTextColor
    } else {
        return markdownConfiguration.markdownTheme.codeListTitleUnSelectTextColor
    }
}

/**
 * 代码列表标签背景颜色，切换显示
 *
 * @param idxSelect 选中的第几条
 * @param idx 点击第几条
 * @param markdownConfiguration MarkdownConfiguration
 * @return 切换之后的文本颜色
 */
func listCodeBackgroupColor(idxSelect: Int64, idx: Int64, markdownConfiguration: MarkdownConfiguration): Color {
    if (idxSelect == idx) {
        return markdownConfiguration.markdownTheme.codeListTitleSelectBackGroupColor
    } else {
        return markdownConfiguration.markdownTheme.codeListTitleUnSelectBackGroupColor
    }
}

/**
 * 显示哪条代码
 *
 * @param idxSelect 选中的第几条
 * @param idx 点击第几条
 * @return 显影控制
 */
func listCodeTextBool(idxSelect: Int64, idx: Int64): Visibility {
    if (idxSelect == idx) {
        return Visibility.Visible
    } else {
        return Visibility.None
    }
}

/**
 * 代码块背景颜色
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码块背景颜色（围栏代码、缩进代码、围栏代码列表）
 */
func codeBackgroundColor(markdownTheme: MarkdownTheme, prismTheme: PrismTheme): Color {
    if (markdownTheme.codeBlockBackgroundColor.isSome()) {
        return markdownTheme.codeBlockBackgroundColor()
    } else {
        return prismTheme.background()
    }
}

/**
 * 代码块文字颜色 -- 代码高亮
 *
 * @param item PrismNodesParseRes
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 文字颜色
 */
func codeTextColor(item: PrismNodesParseResUI, markdownTheme: MarkdownTheme, prismTheme: PrismTheme): Color {
    let color: ?Color = item.getColor()
    if (color.isSome()) {
        return color()
    } else {
        if (markdownTheme.codeBlockTextColor.isSome()) {
            return markdownTheme.codeBlockTextColor()
        } else {
            return prismTheme.textColor()
        }
    }
}

/**
 * 代码块文字颜色
 *
 * @param item PrismNodesParseRes
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 文字颜色
 */
func indentedCodeTextColor(markdownTheme: MarkdownTheme, prismTheme: PrismTheme): Color {
    if (markdownTheme.codeBlockTextColor.isSome()) {
        return markdownTheme.codeBlockTextColor()
    } else {
        return prismTheme.textColor()
    }
}

/**
 * 渲染 tableCell 的颜色
 *
 * @param tableCell TableCell
 * @param tableTheme 表格样式
 * @param rowCount 第几行
 * @return 一行的背景颜色
 */
func renderTableCellColor(tableCell: TableCell, markdownTheme: MarkdownTheme, rowCount: Int64): Color {
    if (tableCell.isHeader()) {
        return markdownTheme.tableHeaderRowBackgroundColor
    }
    if (rowCount % 2 == 0) {
        return markdownTheme.tableOddRowBackgroundColor
    }
    return markdownTheme.tableEvenRowBackgroundColor
}

/**
 * 渲染 tableCell 的颜色
 *
 * @param tableCell TableCell
 * @param tableTheme 表格样式
 * @param rowCount 第几行
 * @return 一行的背景颜色
 */
func renderTableCellColor(isHeader: Bool, markdownTheme: MarkdownTheme, rowCount: Int64): Color {
    if (isHeader) {
        return markdownTheme.tableHeaderRowBackgroundColor
    }
    if (rowCount % 2 == 0) {
        return markdownTheme.tableOddRowBackgroundColor
    }
    return markdownTheme.tableEvenRowBackgroundColor
}

/**
 * 获取 tableCell 的对其方式
 *
 * @param tableCell TableCell
 * @return 对其方式
 */
func renderTableCellAlign(alignment: ?TableAlignment): TextAlign {
    if (let Some(v) <- alignment) {
        match (v) {
            case LEFT => return TextAlign.Start
            case CENTER => return TextAlign.Center
            case RIGHT => return TextAlign.End
        }
    }
    return TextAlign.Start
}

/**
 * 获取 tableCell 的对其方式
 *
 * @param tableCell TableCell
 * @return 对其方式
 */
func renderTableCellColumnAlign(alignment: ?TableAlignment): HorizontalAlign {
    if (let Some(v) <- alignment) {
        match (v) {
            case LEFT => return HorizontalAlign.Start
            case CENTER => return HorizontalAlign.Center
            case RIGHT => return HorizontalAlign.End
        }
    }
    return HorizontalAlign.Start
}

/**
 * 获取 tableCell 的对其方式
 *
 * @param tableCell TableCell
 * @return 对其方式
 */
func renderTableCellAlign(tableCell: TableCell): TextAlign {
    if (let Some(alignment) <- tableCell.getAlignment()) {
        match (alignment) {
            case LEFT => return TextAlign.Start
            case CENTER => return TextAlign.Center
            case RIGHT => return TextAlign.End
        }
    }
    return TextAlign.Start
}

/**
 * 对于表格数据进行处理 - 整合处理
 *
 * @param nodeViews ArrayList<NodeView>
 * @return ArrayList<NodeView>
 */
func tableList(nodeViews: ArrayList<CommonmarkNode>): ArrayList<CommonmarkNode> {
    let tableNodeViews = ArrayList<CommonmarkNode>()
    for (nodeView in nodeViews) {
        if (nodeView is TableBody || nodeView is TableHead) {
            tableNodeViews.add(all: nodeView.listChildren())
        } else if (nodeView is TableRow) {
            tableNodeViews.add(nodeView)
        }
    }
    return tableNodeViews
}

/**
 * 将Length转换成Float64
 *
 * @param length ?Length
 * @param componentWidth 控件宽度
 * @return ?Float64
 */
func length2Float(length: Length): Float64 {
    return match (length.unitType) {
        case LengthType.vp(v) => v.value
        case LengthType.px(v) => px2vp(v.px)().value
        case _ => 0.0
    }
}

/**
 * 将Length转换成Float64
 *
 * @param length ?Length
 * @param componentWidth 控件宽度
 * @return ?Float64
 */
func length2Float64(length: ?Length, componentWidth: Float64): ?Float64 {
    if (let Some(v) <- length) {
        return match (v.unitType) {
            case LengthType.vp(v) => vp2px(v)().value
            case LengthType.px(v) => v.value
            case LengthType.percent(v) => v.value * componentWidth
            case _ => v.value
        }
    } else {
        return None
    }
}


/**
 * 将布局位置添加进列表
 *
 * @param indexList 列表
 * @param index 位置
 * @return ArrayList<Int64>
 */
func indexAdd(indexList: ArrayList<Int64>, index: Int64): ArrayList<Int64> {
    let indexListNew: ArrayList<Int64> = ArrayList<Int64>()
    indexListNew.add(all: indexList)
    indexListNew.add(index)
    return indexListNew
}

/**
 * 是否是当前数据
 *
 * @param indexListOne 第一个列表
 * @param indexListTwo 第二个列表
 * @param index 当前位置
 * @return Bool
 */
func isListItem(indexListOne: ArrayList<Int64>, indexListTwo: ArrayList<Int64>, index: Int64): Bool {
    if (indexListTwo.size <= 0) {
        return false
    }
    if (indexListOne.size + 1 != indexListTwo.size || indexListTwo[indexListTwo.size - 1] != index) {
        return false
    }
    var isBool: Bool = true
    for (i in 0..indexListOne.size) {
        if (indexListOne[i] != indexListTwo[i]) {
            isBool = false
        }
    }
    return isBool
}

/**
 * 解析链接文本
 *
 * @param v 加密的链接文本
 * @return String
 */
func urlSafeBase64Decode(v: String): String {
    var vNew = v.replace("_", "/").replace("-", "+")
    var arr: ?Array<Byte> = fromBase64String(vNew)
    if (arr.isNone()) {
        return ""
    }
    var arrStr: String = String.fromUtf8(arr.getOrThrow())
    var regex: Regex = Regex("file-name=([^&]+)")
    var matcher: Matcher = Matcher(regex, arrStr)
    var matchData: ?MatchData = matcher.find()
    match (matchData) {
        case Some(v) =>
            var str: String = v.matchString()
            var arrSplit: Array<String> = URL.parse(str).toString().split('.')
            if (arrSplit.size > 1) {
                return arrSplit[arrSplit.size - 1].toAsciiUpper()
            } else {
                return ""
            }
        case None => return ""
    }
    return ""
}

/**
 * 将String转换成Float64
 *
 * @param str String
 * @return ?Float64
 */
func strToLength(str: ?String): ?Length {
    var f: ?Length = Option<Length>.None
    if (let Some(v) <- str) {
        try {
            f = Float64.parse(v).vp
        } catch (e: IllegalArgumentException) {
        }
    }
    return f
}

/**
 * 将String转换成Float64
 *
 * @param str String
 * @return ?Float64
 */
func strToFloat64(str: ?String): ?Float64 {
    var f: ?Float64 = Option<Float64>.None
    if (let Some(v) <- str) {
        try {
            f = Float64.parse(v)
        } catch (e: IllegalArgumentException) {
        }
    }
    return f
}

/**
 * 将秒转换成时分秒并以HH:MM:SS 格式输出
 *
 * @param totalSeconds 秒数
 * @return 返回时分秒文本
 */
func formatTime(totalSeconds: Int64): String {
    if (totalSeconds <= 0) {
        return "00:00:00"
    }
    var hours: Int64 = totalSeconds / SECONDS_PER_HOUR // 时
    var remainingSeconds: Int64 = totalSeconds % SECONDS_PER_HOUR
    var minutes: Int64 = remainingSeconds / SECONDS_PER_MINUTE // 分
    var seconds: Int64 = remainingSeconds % SECONDS_PER_MINUTE // 秒
    let sb: StringBuilder = StringBuilder(8) // 预分配足够长度
    appendTwoDigits(sb, hours).append(':')
    appendTwoDigits(sb, minutes).append(':')
    appendTwoDigits(sb, seconds)
    return sb.toString()
}

/**
 * 将小于10的时分秒补齐十位
 *
 * @param sb StringBuilder
 * @param value 需要添加数据的数字
 * @return 返回StringBuilder
 */
func appendTwoDigits(sb: StringBuilder, value: Int64): StringBuilder {
    if (value < 10) {
        sb.append('0')
    }
    sb.append(value)
    return sb
}

/**
 * 文本是否加粗
 *
 * @param b 布尔值
 * @return FontWeight
 */
func isFontWeight(b: Bool): FontWeight {
    if (b) {
        FontWeight.W600
    } else {
        FontWeight.W400
    }
}

/**
 * 设置对齐方式
 *
 * @param b 布尔值
 * @return Alignment
 */
func isAlignItems(b: Bool): Alignment {
    if (b) {
        Alignment.Center
    } else {
        Alignment.Start
    }
}

/**
 * 设置代码类型文本颜色
 *
 * @param markdownTheme MarkdownTheme
 * @param prismTheme PrismTheme
 * @return 代码类型文本颜色
 */
func indentedCodeodeBlockTypeTextColor(markdownTheme: MarkdownTheme, prismTheme: PrismTheme): Color {
    if (markdownTheme.codeBlockTypeTextColor.isSome()) {
        return markdownTheme.codeBlockTypeTextColor()
    }
    if (markdownTheme.codeBlockTextColor.isSome()) {
        return markdownTheme.codeBlockTextColor()
    }
    return prismTheme.textColor()
}

/**
 * HTML类型Span标签font-size属性转换数值
 *
 * @param weightString font-size属性值
 * @return 对应的数值（相对值返回null）
 */
func sizeStringToSize(sizeString: String): ?Float64 {
    let sizeStr = sizeString.toAsciiLower().trimAscii()
    var size: ?Float64 = match (sizeStr) {
        case "xx-small" => 9.0
        case "x-small" => 10.0
        case "small" => 13.0
        case "medium" => 16.0
        case "large" => 18.0
        case "x-large" => 24.0
        case "xx-large" => 32.0
        case "xxx-large" => 36.0
        case _ =>
            if (sizeStr.size > 2 && sizeStr[sizeStr.size - 2..] == "px") {
                Float64.parse(sizeStr[..sizeStr.size - 2])
            } else {
                Float64.parse(sizeStr)
            }
    }
    return size
}

/**
 * HTML类型Span标签font-weight属性转换数值
 *
 * @param weightString font-weight属性值
 * @return 对应的数值（相对值返回null）
 */
func fontWeightToValue(weightString: String): ?FontWeight {
    let weightStr = weightString.toAsciiLower().trimAscii()
    var weight: ?FontWeight = match (weightStr) {
        // 关键字（对应固定数值）
        case "normal" => FontWeight.Normal
        case "bold" => FontWeight.Bold

        // 数值型（100-900，整百数）
        case "100" => FontWeight.W100
        case "200" => FontWeight.W200
        case "300" => FontWeight.W300
        case "400" => FontWeight.W400 // 等同于normal
        case "500" => FontWeight.W500
        case "600" => FontWeight.W600
        case "700" => FontWeight.W700 // 等同于bold
        case "800" => FontWeight.W800
        case "900" => FontWeight.W900
        // 未匹配的情况
        case _ => Option<FontWeight>.None
    }
    return weight
}

/**
 * HTML类型Span标签color属性转换Color对象
 *
 * @param colorString color属性
 * @return Color对象
 */
func colorStringToColor(colorString: String): ?Color {
    let colorStr = colorString.toAsciiLower().trimAscii()
    var color: ?Color = match (colorStr) {
        // 通用16种颜色（CSS基础色）
        case "black" => Color(0xFF000000)
        case "silver" => Color(0xFFC0C0C0)
        case "gray" => Color(0xFF808080)
        case "white" => Color(0xFFFFFFFF)
        case "maroon" => Color(0xFF800000)
        case "red" => Color(0xFFFF0000)
        case "purple" => Color(0xFF800080)
        case "fuchsia" => Color(0xFFFF00FF)
        case "green" => Color(0xFF008000)
        case "lime" => Color(0xFF00FF00)
        case "olive" => Color(0xFF808000)
        case "yellow" => Color(0xFFFFFF00)
        case "navy" => Color(0xFF000080)
        case "blue" => Color(0xFF0000FF)
        case "teal" => Color(0xFF008080)
        case "aqua" => Color(0xFF00FFFF)

        // 扩展颜色（W3C标准扩展色，已去重）
        case "aliceblue" => Color(0xFFF0F8FF)
        case "antiquewhite" => Color(0xFFFAEBD7)
        case "aquamarine" => Color(0xFF7FFFD4)
        case "azure" => Color(0xFFF0FFFF)
        case "beige" => Color(0xFFF5F5DC)
        case "bisque" => Color(0xFFFFE4C4)
        case "blueviolet" => Color(0xFF8A2BE2)
        case "brown" => Color(0xFFA52A2A)
        case "burlywood" => Color(0xFFDEB887)
        case "cadetblue" => Color(0xFF5F9EA0)
        case "chartreuse" => Color(0xFF7FFF00)
        case "chocolate" => Color(0xFFD2691E)
        case "coral" => Color(0xFFFF7F50)
        case "cornflowerblue" => Color(0xFF6495ED)
        case "cornsilk" => Color(0xFFFFF8DC)
        case "crimson" => Color(0xFFDC143C)
        case "cyan" => Color(0xFF00FFFF) // 与aqua等效
        case "darkblue" => Color(0xFF00008B)
        case "darkcyan" => Color(0xFF008B8B)
        case "darkgoldenrod" => Color(0xFFB8860B)
        case "darkgray" => Color(0xFFA9A9A9)
        case "darkgreen" => Color(0xFF006400)
        case "darkkhaki" => Color(0xFFBDB76B)
        case "darkmagenta" => Color(0xFF8B008B)
        case "darkolivegreen" => Color(0xFF556B2F)
        case "darkorange" => Color(0xFFFF8C00)
        case "darkorchid" => Color(0xFF9932CC)
        case "darkred" => Color(0xFF8B0000)
        case "darksalmon" => Color(0xFFE9967A)
        case "darkseagreen" => Color(0xFF8FBC8F)
        case "darkslateblue" => Color(0xFF483D8B)
        case "darkslategray" => Color(0xFF2F4F4F)
        case "darkturquoise" => Color(0xFF00CED1)
        case "darkviolet" => Color(0xFF9400D3)
        case "deeppink" => Color(0xFFFF1493)
        case "deepskyblue" => Color(0xFF00BFFF)
        case "dimgray" => Color(0xFF696969)
        case "dodgerblue" => Color(0xFF1E90FF)
        case "firebrick" => Color(0xFFB22222)
        case "floralwhite" => Color(0xFFFFFAF0)
        case "forestgreen" => Color(0xFF228B22)
        case "gainsboro" => Color(0xFFDCDCDC)
        case "ghostwhite" => Color(0xFFF8F8FF)
        case "gold" => Color(0xFFFFD700)
        case "goldenrod" => Color(0xFFDAA520)
        case "greenyellow" => Color(0xFFADFF2F)
        case "honeydew" => Color(0xFFF0FFF0)
        case "hotpink" => Color(0xFFFF69B4)
        case "indianred" => Color(0xFFCD5C5C)
        case "indigo" => Color(0xFF4B0082)
        case "ivory" => Color(0xFFFFFFF0)
        case "khaki" => Color(0xFFF0E68C)
        case "lavender" => Color(0xFFE6E6FA)
        case "lavenderblush" => Color(0xFFFFF0F5)
        case "lawngreen" => Color(0xFF7CFC00)
        case "lemonchiffon" => Color(0xFFFFFACD)
        case "lightblue" => Color(0xFFADD8E6)
        case "lightcoral" => Color(0xFFF08080)
        case "lightcyan" => Color(0xFFE0FFFF)
        case "lightgoldenrodyellow" => Color(0xFFFAFAD2)
        case "lightgray" => Color(0xFFD3D3D3)
        case "lightgreen" => Color(0xFF90EE90)
        case "lightpink" => Color(0xFFFFB6C1)
        case "lightsalmon" => Color(0xFFFFA07A)
        case "lightseagreen" => Color(0xFF20B2AA)
        case "lightskyblue" => Color(0xFF87CEFA)
        case "lightslategray" => Color(0xFF778899)
        case "lightsteelblue" => Color(0xFFB0C4DE)
        case "lightyellow" => Color(0xFFFFFFE0)
        case "limegreen" => Color(0xFF32CD32)
        case "linen" => Color(0xFFFAF0E6)
        case "magenta" => Color(0xFFFF00FF) // 与fuchsia等效
        case "mediumaquamarine" => Color(0xFF66CDAA)
        case "mediumblue" => Color(0xFF0000CD)
        case "mediumorchid" => Color(0xFFBA55D3)
        case "mediumpurple" => Color(0xFF9370DB)
        case "mediumseagreen" => Color(0xFF3CB371)
        case "mediumslateblue" => Color(0xFF7B68EE)
        case "mediumspringgreen" => Color(0xFF00FA9A)
        case "mediumturquoise" => Color(0xFF48D1CC)
        case "mediumvioletred" => Color(0xFFC71585)
        case "midnightblue" => Color(0xFF191970)
        case "mintcream" => Color(0xFFF5FFFA)
        case "mistyrose" => Color(0xFFFFE4E1)
        case "moccasin" => Color(0xFFFFE4B5)
        case "navajowhite" => Color(0xFFFFDEAD)
        case "oldlace" => Color(0xFFFDF5E6)
        case "olivedrab" => Color(0xFF6B8E23)
        case "orange" => Color(0xFFFFA500)
        case "orangered" => Color(0xFFFF4500)
        case "orchid" => Color(0xFFDA70D6)
        case "palegoldenrod" => Color(0xFFEEE8AA)
        case "palegreen" => Color(0xFF98FB98)
        case "paleturquoise" => Color(0xFFAFEEEE)
        case "palevioletred" => Color(0xFFDB7093)
        case "papayawhip" => Color(0xFFFFEFD5)
        case "peachpuff" => Color(0xFFFFDAB9)
        case "peru" => Color(0xFFCD853F)
        case "pink" => Color(0xFFFFC0CB)
        case "plum" => Color(0xFFDDA0DD)
        case "powderblue" => Color(0xFFB0E0E6)
        case "rosybrown" => Color(0xFFBC8F8F)
        case "royalblue" => Color(0xFF4169E1)
        case "saddlebrown" => Color(0xFF8B4513)
        case "salmon" => Color(0xFFFA8072)
        case "sandybrown" => Color(0xFFF4A460)
        case "seagreen" => Color(0xFF2E8B57)
        case "seashell" => Color(0xFFFFF5EE)
        case "sienna" => Color(0xFFA0522D)
        case "skyblue" => Color(0xFF87CEEB)
        case "slateblue" => Color(0xFF6A5ACD)
        case "slategray" => Color(0xFF708090)
        case "snow" => Color(0xFFFFFAFA)
        case "springgreen" => Color(0xFF00FF7F)
        case "steelblue" => Color(0xFF4682B4)
        case "tan" => Color(0xFFD2B48C)
        case "thistle" => Color(0xFFD8BFD8)
        case "tomato" => Color(0xFFFF6347)
        case "turquoise" => Color(0xFF40E0D0)
        case "violet" => Color(0xFFEE82EE)
        case "wheat" => Color(0xFFF5DEB3)
        case "whitesmoke" => Color(0xFFF5F5F5)
        case "yellowgreen" => Color(0xFF9ACD32)
        case _ => Option<Color>.None
    }
    return color
}

/**
 * 计算图片圆角
 *
 * @param radius 图片圆角
 * @param imageBorderRadius 图片圆角
 * @return Float64 图片圆角
 */
func imageSpanBorderRadius(radius: Option<Length>, imageBorderRadius: Float64): Float64 {
    return if (radius.isSome()) {
        length2Float(radius())
    } else {
        imageBorderRadius
    }
}
