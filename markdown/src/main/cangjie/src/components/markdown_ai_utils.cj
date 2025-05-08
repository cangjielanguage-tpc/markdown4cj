/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

let COLOR_191919: Color = Color(0x191919)
let COLOR_0000FF: Color = Color(0x0000FF)
let COLOR_FF0000: Color = Color(0xFF0000)
let COLOR_000000: Color = Color(0x000000)
let COLOR_00000000: Color = Color(0x00000000)
let COLOR_FF000000: Color = Color(0xFF000000)
let COLOR_FFFFFF: Color = Color(0xFFFFFF)
let COLOR_FFFFFFFF: Color = Color(0xFFFFFFFF)
let COLOR_00FFFFFF: Color = Color(0x00FFFFFF)
let COLOR_E0E0E0: Color = Color(0xE0E0E0)
let COLOR_FFE0E0E0: Color = Color(0xFFE0E0E0)
let COLOR_333333: Color = Color(0x333333)
let null:NodeView = unsafe{zeroValue()}

func toCodeList(codeBlockListNodeView: NodeView): (ArrayList<String>, ArrayList<String>, ArrayList<String>) {
    var strText: ArrayList<String> = ArrayList<String>()
    var strInfoText: ArrayList<String> = ArrayList<String>()
    var strInfo: ArrayList<String> = ArrayList<String>()
    for (nodeView in codeBlockListNodeView.children) {
        if (nodeView.node is FencedCodeBlock) {
            strText.append((nodeView.node as FencedCodeBlock)().getLiteral())
            strInfoText.append((nodeView.node as FencedCodeBlock)().getInfo())
        }
    }
    if (codeBlockListNodeView.node is FencedCodeBlockListBlock) {
        strInfo = (codeBlockListNodeView.node as FencedCodeBlockListBlock)().tabs
    }
    return (strInfo, strText, strInfoText)
}

/**
 * 文本内容设置
 *
 * @param nodeView 文本内容的NodeView（Text、Code、HeadLink）
 * @return 返回需要显示的文本内容
 */
func spanText(nodeView: NodeView): String {
    if (nodeView.node is CommonmarkText) {
        // 普通文本
        return (nodeView.node as CommonmarkText)().getLiteral()
    } else if (nodeView.node is Code) {
        // 内联代码
        return " ${(nodeView.node as Code)().getLiteral()} "
    } else if (nodeView.node is HeadLink) {
        // TOC列表，title不可能为None
        return (nodeView.node as HeadLink)().getTitle()()
    } else if (nodeView.node is Footnote) {
        // 脚注
        return (nodeView.node as Footnote)().noteid
    } else {
        return ""
    }
}

/**
 * 字体样式列表设置
 *
 * @param isCode 是否是内联代码
 * @param markdownAITheme markdown基础样式
 * @param isTitle 是否是标题
 * @return 返回需要显示的字体样式
 */
func spanFontFamily(isCode: Bool, markdownAITheme: MarkdownAITheme, isTitle: Bool): String {
    if (isCode) {
        // 内联代码情况设置内联代码字体样式
        return markdownAITheme.codeTypeface
    } else {
        if (isTitle) {
            // 设置标题字体
            return markdownAITheme.headingTypeface
        } else {
            // 段落设置默认字体
            return "HarmonyOS Sans"
        }
    }
}

/**
 * 文字大小设置
 *
 * @param isCode 是否是内联代码
 * @param markdownAITheme markdown基础样式
 * @param isTitle 是否是标题
 * @param level 几级标题
 * @return 返回需要显示的字体大小
 */
func spanFontSize(nodeView: NodeView, isCode: Bool, markdownAITheme: MarkdownAITheme, isTitle: Bool, level: Int64): Float64 {
    if (nodeView.props.isSome() && nodeView.props().get("FontNode").isSome()) {
        try {
            let fontNode: FontNode = (nodeView.props().get("FontNode")() as FontNode)()
            let sizeString: ?String = fontNode.getSize()
            if (sizeString.isSome()) {
                let sizeInt64: Int64 = Int64.parse(sizeString())
                return Float64(sizeInt64)
            } else {
                return spanTextFontSize(nodeView, isCode, markdownAITheme, isTitle, level)
            }
        } catch (e: Exception) {
            return spanTextFontSize(nodeView, isCode, markdownAITheme, isTitle, level)
        }
    } else {
        return spanTextFontSize(nodeView, isCode, markdownAITheme, isTitle, level)
    }
}

/**
 * 文字大小设置
 *
 * @param isCode 是否是内联代码
 * @param markdownAITheme markdown基础样式
 * @param isTitle 是否是标题
 * @param level 几级标题
 * @return 返回需要显示的字体大小
 */
func spanTextFontSize(nodeView: NodeView, isCode: Bool, markdownAITheme: MarkdownAITheme, isTitle: Bool, level: Int64): Float64 {
    if (isCode) {
        // 内联代码情况设置内联代码字体大小
        return markdownAITheme.codeTextSize
    } else {
        if(nodeView.link.isSome()){
            return markdownAITheme.linkSize
        } else {
            if (isTitle) {
                return markdownAITheme.headingTextSizeMultipliers[level - 1]
            } else {
                return markdownAITheme.paragraphTextSize
            }
        }
    }
}

/**
 * 文字粗细设置
 *
 * @param nodeView NodeView
 * @param isTitle 是否是标题
 * @return 返回需要显示的字体粗细
 */
func spanFontWeight(nodeView: NodeView, isTitle: Bool): FontWeight {
    if (isTitle) {
        // 所有标题默认加粗
        return FontWeight.W600
    } else {
        if (nodeView.strongEmphasis) {
            return FontWeight.W600
        } else {
            return FontWeight.W400
        }
    }
}

/**
 * 文字样式（斜体）设置
 *
 * @param nodeView NodeView
 * @return 返回需要显示的字体样式（斜体）
 */
func spanFontStyle(nodeView: NodeView): FontStyle {
    // 是否需要斜体
    return if (nodeView.emphasis) {
        FontStyle.Italic
    } else {
        FontStyle.Normal
    }
}

/**
 * 字体颜色设置 - 优先设置链接颜色，次要设置内联代码颜色
 *
 * @param nodeView NodeView
 * @param isCode 是否是内联代码
 * @param markdownAITheme markdown基础样式
 * @param isHeading 是否是标题
 * @return 返回需要显示的字体颜色
 */
func spanFontColor(nodeView: NodeView, isCode: Bool, markdownAITheme: MarkdownAITheme, isHeading: Bool): Color {
    if (nodeView.props.isSome() && nodeView.props().get("FontNode").isSome()) {
        try {
            let fontNode: FontNode = (nodeView.props().get("FontNode")() as FontNode)()
            let colorString: ?String = fontNode.getColor()
            if (colorString.isSome()) {
                let colorUInt32: UInt32 = UInt32.parse(colorString().replace("#", "0x"))
                return Color(colorUInt32)
            } else {
                return spanTextFontColor(nodeView, isCode, markdownAITheme, isHeading)
            }
        } catch (e: Exception) {
            return spanTextFontColor(nodeView, isCode, markdownAITheme, isHeading)
        }
    } else {
        return spanTextFontColor(nodeView, isCode, markdownAITheme, isHeading)
    }
}

/**
 * 字体颜色设置 - 优先设置链接颜色，次要设置内联代码颜色
 *
 * @param nodeView NodeView
 * @param isCode 是否是内联代码
 * @param markdownAITheme markdown基础样式
 * @param isHeading 是否是标题
 * @return 返回需要显示的字体颜色
 */
func spanTextFontColor(nodeView: NodeView, isCode: Bool, markdownAITheme: MarkdownAITheme, isHeading: Bool): Color {
    if (nodeView.link.isSome() || nodeView.node is HeadLink || nodeView.node is Footnote) {
        return markdownAITheme.linkColor
    } else {
        if (isCode) {
            return markdownAITheme.codeTextColor
        } else {
            if (isHeading) {
                return markdownAITheme.headingTextColor
            } else {
                return markdownAITheme.paragraphTextColor
            }
        }
    }
}

/**
 * 下划线中划线设置 - 链接设置下划线，删除设置中划线
 *
 * @param nodeView NodeView
 * @param markdownAITheme markdown基础样式
 * @return 返回需要显示的下划线中划线，返回需要显示的下划线中划线颜色
 */
func spanDecoration(nodeView: NodeView, markdownAITheme: MarkdownAITheme): (TextDecorationType, Color) {
    // 是否是链接并且样式是否设置下划线
    if ((nodeView.link.isSome() || nodeView.node is Footnote) && markdownAITheme.isLinkUnderlined) {
        // 是否是删除线
        if (nodeView.props.isSome() && nodeView.props().get("strikethrough").isSome()) {
            // TODO 需要同时设置下划线和中划线
            return (TextDecorationType.LineThrough, COLOR_191919)
        }
        return (TextDecorationType.Underline, markdownAITheme.linkColor)
    } else {
        // 是否是删除线
        if (nodeView.props.isSome() && nodeView.props().get("strikethrough").isSome()) {
            return (TextDecorationType.LineThrough, COLOR_191919)
        }
        return (TextDecorationType.None, COLOR_191919)
    }
}

/**
 * TODO 内联代码背景色设置
 *
 * @param isCode 是否是内联代码
 * @param markdownAITheme markdown基础样式
 * @return 返回需要显示的背景颜色
 */
func spanBackgroundColor(isCode: Bool, markdownAITheme: MarkdownAITheme): Color {
    // 内联代码情况需要设置背景色
    return if (isCode) {
        markdownAITheme.codeBackgroundColor
    } else {
        Color.WHITE
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
 * @param markdownAIConfiguration MarkdownAIConfiguration
 * @return 切换之后的文本颜色
 */
func listCodeTextColor(idxSelect: Int64, idx: Int64, markdownAIConfiguration: MarkdownAIConfiguration): Color {
    if (idxSelect == idx) {
        return markdownAIConfiguration.markdownAITheme.codeListTitleSelectTextColor
    } else {
        return markdownAIConfiguration.markdownAITheme.codeListTitleUnSelectTextColor
    }
}

/**
 * 代码列表标签背景颜色，切换显示
 *
 * @param idxSelect 选中的第几条
 * @param idx 点击第几条
 * @param markdownAIConfiguration MarkdownAIConfiguration
 * @return 切换之后的文本颜色
 */
func listCodeBackgroupColor(idxSelect: Int64, idx: Int64, markdownAIConfiguration: MarkdownAIConfiguration): Color {
    if (idxSelect == idx) {
        return markdownAIConfiguration.markdownAITheme.codeListTitleSelectBackgroupColor
    } else {
        return markdownAIConfiguration.markdownAITheme.codeListTitleUnSelectBackgroupColor
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
 * @param markdownAITheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码块背景颜色（围栏代码、缩进代码、围栏代码列表）
 */
func codeBackgroundColor(markdownAITheme: MarkdownAITheme, prismTheme: PrismTheme): Color {
    if (markdownAITheme.codeBlockBackgroundColor.isSome()) {
        return markdownAITheme.codeBlockBackgroundColor()
    } else {
        return prismTheme.background()
    }
}

/**
 * 代码块文字颜色 -- 代码高亮
 *
 * @param item PrismNodesParseRes
 * @param markdownAITheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 文字颜色
 */
func codeTextColor(item: PrismNodesParseRes, markdownAITheme: MarkdownAITheme, prismTheme: PrismTheme): Color {
    let color: ?Color = item.getColor()
    if (color.isSome()) {
        return color()
    } else {
        if (markdownAITheme.codeBlockTextColor.isSome()) {
            return markdownAITheme.codeBlockTextColor()
        } else {
            return prismTheme.textColor()
        }
    }
}

/**
 * 代码块文字颜色
 *
 * @param item PrismNodesParseRes
 * @param markdownAITheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 文字颜色
 */
func indentedCodeTextColor(markdownAITheme: MarkdownAITheme, prismTheme: PrismTheme): Color {
    if (markdownAITheme.codeBlockTextColor.isSome()) {
        return markdownAITheme.codeBlockTextColor()
    } else {
        return prismTheme.textColor()
    }
}

/**
 * 获取第一层控件宽度（屏幕宽度 - padding宽度）
 *
 * @param screenWidth 屏幕宽度 - 单位px
 * @param imagePadding padding宽度 - 单位vp
 * @return 第一层控件宽度 - 单位vp
 */
func widthPxToVp(screenWidth: Int32, imagePadding: Int64): Float64 {
    let length: ?Length = px2vp(Int64(screenWidth).px)
    let width: Float64 = if (let Some(v) <- length) {
        v.value - Float64(imagePadding)
    } else {
        0.0
    }
    return width
}

/**
 * 获取第一层控件宽度（屏幕宽度 - padding宽度）
 *
 * @param screenWidth 屏幕宽度 - 单位px
 * @param imagePadding padding宽度 - 单位vp
 * @return 第一层控件宽度 - 单位px
 */
func widthVpToPx(screenWidth: Int32, imagePadding: Int64): Float64 {
    let lengthPadding: ?Length = vp2px(imagePadding.vp)
    let lengthScreen: Length = Int64(screenWidth).px
    let width: Float64 = if (let Some(v) <- lengthPadding) {
        lengthScreen.value - v.value
    } else {
        0.0
    }
    return width
}

/**
 * 前缀显示文本内容
 *
 * @param item NodeView
 * @param isBullet 是否是无序列表
 * @return 返回前缀文本内容
 */
func listPrefixLineHeight(isBullet: Bool): Float64 {
    if (isBullet) {
        // 有序列表
        return 22.0
    } else {
        return 18.0
    }
}

/**
 * 前缀显示文本内容
 *
 * @param item NodeView
 * @param isBullet 是否是无序列表
 * @return 返回前缀文本内容
 */
func listPrefixStr(item: NodeView, isBullet: Bool): String {
    if (isBullet) {
        // 有序列表
        return "${item.order}."
    } else {
        // 无序列表
        if (listOverallDepth(item) == 0) {
            return "${solidCircleToUnicode()}"
        } else if (listOverallDepth(item) == 1) {
            return "${hollowCircleToUnicode()}"
        } else {
            return "${solidSquareToUnicode()}"
        }
    }
}

/**
 * 前缀显示文本内容颜色
 *
 * @param markdownAITheme MarkdownAITheme
 * @param isBullet 是否是无序列表
 * @return 返回前缀文本内容颜色
 */
func listPrefixColor(markdownAITheme: MarkdownAITheme, isBullet: Bool): Color {
    if (isBullet) {
        // 有序列表
        return markdownAITheme.orderedListItemColor
    } else {
        // 无序列表
        return markdownAITheme.bulletListItemColor
    }
}

/**
 * 前缀显示文本内容大小
 *
 * @param markdownAITheme MarkdownAITheme
 * @param isBullet 是否是无序列表
 * @return 返回前缀文本内容大小
 */
func listPrefixSize(markdownAITheme: MarkdownAITheme, isBullet: Bool): Float64 {
    if (isBullet) {
        // 有序列表
        return markdownAITheme.orderedListItemSize
    } else {
        // 无序列表
        return markdownAITheme.bulletListItemSize
    }
}

/**
 * 整体深度,有序列表深度（TOC列表深度） + 无序列表深度 - 任务列表深度
 *
 * @param item NodeView
 * @return 返回深度
 */
func listOverallDepth(item: NodeView): Int64 {
    // 任务列表深度,0开始，有值代表有深度需要加一
    let taskDepth: Int64 = if (let Some(Some(v: Int)) <- item.props?.get(TaskListItem.TASK_DEPTH)) {
        v + 1
    } else {
        0
    }
    // 有序列表深度
    let depth = if (item.depth != -1) {
        item.depth
    } else {
        0
    }
    // 无序列表深度
    let bulletListDepth = if (item.bulletListDepth != -1) {
        item.bulletListDepth
    } else {
        0
    }
    return depth + bulletListDepth - taskDepth
}

/**
 * 任务列表选择框是否选中
 *
 * @param item NodeView
 * @return 是否被选中
 */
func taskSelect(item: NodeView): Bool {
    if (item.node is TaskListItem) {
        return (item.node as TaskListItem)().isDone()
    } else {
        return false
    }
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
 * 解析 tableBlockView 行数，返回当前网格布局行的数量
 *
 * @param tableBlockView NodeView
 * @return 列数
 */
func parseRowCount(tableBlockView: NodeView): String {
    let rowCount: Int64 = (tableBlockView.props().get("rowCount")() as Int64)()
    let rowCountBuilder: StringBuilder = StringBuilder()
    for (i in 0..rowCount) {
        rowCountBuilder.append("1fr")
        if (i != rowCount - 1) {
            rowCountBuilder.append(" ")
        }
    }
    return rowCountBuilder.toString()
}

/**
 * 解析 tableBlockView 列数，返回当前网格布局列的数量
 */
func parseColumnCount(tableBlockView: NodeView): String {
    let columnCount: Int64 = (tableBlockView.props().get("columnCount")() as Int64)()
    let columnCountBuilder: StringBuilder = StringBuilder()
    for (i in 0..columnCount) {
        columnCountBuilder.append("1fr")
        if (i != columnCount - 1) {
            columnCountBuilder.append(" ")
        }
    }
    return columnCountBuilder.toString()
}

/**
 * 渲染 tableCell 的颜色
 *
 * @param tableCell TableCell
 * @param tableTheme 表格样式
 * @param rowCount 第几行
 * @return 一行的背景颜色
 */
func renderTableCellColor(tableCell: TableCell, markdownAITheme: MarkdownAITheme, rowCount: Int64): Color {
    if (tableCell.isHeader()) {
        return markdownAITheme.tableHeaderRowBackgroundColor
    }
    if (rowCount % 2 == 0) {
        return markdownAITheme.tableOddRowBackgroundColor
    }
    return markdownAITheme.tableEvenRowBackgroundColor
}

/**
 * 渲染 tableCell 的颜色
 *
 * @param tableCell TableCell
 * @param tableTheme 表格样式
 * @param rowCount 第几行
 * @return 一行的背景颜色
 */
func renderTableCellColor(isHeader: Bool, markdownAITheme: MarkdownAITheme, rowCount: Int64): Color {
    if (isHeader) {
        return markdownAITheme.tableHeaderRowBackgroundColor
    }
    if (rowCount % 2 == 0) {
        return markdownAITheme.tableOddRowBackgroundColor
    }
    return markdownAITheme.tableEvenRowBackgroundColor
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
 * 图片圆角大小
 *
 * @param borderRadius 圆角大小
 * @return 圆角大小
 */
func styleImageRadius(borderRadius: ?Length): Length {
    if (borderRadius.isSome()) {
        return borderRadius()
    } else {
        return Length(0, unitType: LengthType.px)
    }
}

/**
 * 对每张图片的 style 进行解析
 *
 * @param picStyle 图片样式集合
 * @param markdownAIConfiguration markdownAIConfiguration
 * @param componentWidth 父布局控件宽度 - 单位vp
 * @return PicStyleObj对象
 */
func parsePicStyle(picStyle: ArrayList<String>, markdownAIConfiguration: MarkdownAIConfiguration,
    componentWidthPx: Float64): PicStyleObj {
    let picStyleObj: PicStyleObj = PicStyleObj()
    if (picStyle.isEmpty()) {
        return picStyleObj
    }
    let componentWidth = px2vp(componentWidthPx.px)().value
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
                    let picStyleObjWidth: Length = Length(Int64.parse(value), unitType: LengthType.vp)
                    picStyleObj.width = if (picStyleObjWidth.value > componentWidth) {
                        componentWidth.vp
                    } else {
                        picStyleObjWidth
                    }
                }
                if (value[value.size - 2..] == "px") {
                    let picStyleObjWidth: Length = Length(Int64.parse(value[..value.size - 2]), unitType: LengthType.px)
                    let componentWidthLength: ?Length = vp2px(componentWidth.vp)
                    if (let Some(v) <- componentWidthLength) {
                        picStyleObj.width = if (picStyleObjWidth.value > v.value) {
                            v
                        } else {
                            picStyleObjWidth
                        }
                    } else {
                        picStyleObj.width = picStyleObjWidth
                    }
                } else if (value[value.size - 1..] == "%") {
                    let opt = Int64.parse(value[..value.size - 1])
                    if (opt <= 100) {
                        picStyleObj.width = Length(opt, unitType: LengthType.percent)
                    }
                } else {
                    let picStyleObjWidth: Length = Length(Int64.parse(value), unitType: LengthType.vp)
                    picStyleObj.width = if (picStyleObjWidth.value > componentWidth) {
                        componentWidth.vp
                    } else {
                        picStyleObjWidth
                    }
                }
            } else if (style[..8] == ":height=") {
                let value = style[8..]
                if (value.size <= 1) {
                    picStyleObj.height = Length(Int64.parse(value), unitType: LengthType.vp)
                }
                if (value[value.size - 2..] == "px") {
                    picStyleObj.height = Length(Int64.parse(value[..value.size - 2]), unitType: LengthType.px)
                } else if (value[value.size - 1..] == "%") {
                    let opt = Int64.parse(value[..value.size - 1])
                    if (opt <= 100) {
                        picStyleObj.height = Length(opt, unitType: LengthType.percent)
                    }
                } else {
                    picStyleObj.height = Length(Int64.parse(value), unitType: LengthType.vp)
                }
            } else if (style[..7] == ":align=") {
                let value = style[7..]
                match (value) {
                    case "left" => picStyleObj.align = FlexAlign.Start
                    case "center" => picStyleObj.align = FlexAlign.Center
                    case "right" => picStyleObj.align = FlexAlign.End
                    case _ => ()
                }
            } else if (style.size > 15 && style[..15] == ":border-radius=") {
                let value = style[15..style.size - 2]
                picStyleObj.borderRadius = Length(Int64.parse(value), unitType: LengthType.px)
            } else if (style[..7] == ":style=") {
                for (s in style[7..].split("")) {
                    picStyle.append(":${s.replace(":","=")}")
                }
            }
        } catch (e: Exception) {}
    }
    return picStyleObj
}

/**
 * 获取代码内容和代码类型
 *
 * @param nodeView NodeView
 * @return 代码内容和代码类型
 */
func getCodeInfo(nodeView: NodeView): (String, ?String) {
    return if (nodeView.node is FencedCodeBlock) {
        ((nodeView.node as FencedCodeBlock)().getLiteral(), (nodeView.node as FencedCodeBlock)().getInfo())
    } else if (nodeView.node is IndentedCodeBlock) {
        ((nodeView.node as IndentedCodeBlock)().getLiteral(), None)
    } else {
        ("", None)
    }
}

/**
 * 对于表格数据进行处理 - 整合处理
 *
 * @param nodeViews ArrayList<NodeView>
 * @return ArrayList<NodeView>
 */
func tableList(nodeViews: ArrayList<NodeView>):ArrayList<NodeView>{
    let tableNodeViews = ArrayList<NodeView>()
    for (nodeView in nodeViews) {
        if (nodeView.node is TableBody || nodeView.node is TableHead) {
            tableNodeViews.appendAll(nodeView.children)
        } else if (nodeView.node is TableRow) {
            tableNodeViews.append(nodeView)
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
func length2Float64(length: ?Length, componentWidth: Float64): ?Float64 {
    if (let Some(v) <- length) {
        return match (v.unitType) {
            case LengthType.vp => vp2px(v)().value
            case LengthType.px => v.value
            case LengthType.percent => (v.value / 1.0) * componentWidth
            case _ => v.value
        }
    } else {
        return None
    }
}

func getProp<T>(item: NodeView, key: String, default: T): T {
    match (item.props?.get(key)) {
        case Some(Some(v: T)) => v
        case v => default
    }
}

func indexAdd(indexList: ArrayList<Int64>,index:Int64):ArrayList<Int64>{
    let indexListNew: ArrayList<Int64> = ArrayList<Int64>()
    indexListNew.appendAll(indexList)
    indexListNew.append(index)
    return indexListNew
}

func isListItem(indexListOne: ArrayList<Int64>,indexListTwo: ArrayList<Int64>,index:Int64):Bool{
    if(indexListTwo.size <= 0){
        return false
    }
    if(indexListOne.size + 1 != indexListTwo.size || indexListTwo[indexListTwo.size-1] != index){
        return false
    }
    var isBool:Bool = true
    for(i in 0..indexListOne.size){
        if(indexListOne[i] != indexListTwo[i]){
            isBool = false
        }
    }
    return isBool
}

func urlSafeBase64Decode(v: String):String {
    var vNew = v.replace("_", "/").replace("-", "+")
    var arr:?Array<Byte> = fromBase64String(vNew)
    if(arr.isNone()){
        return ""
    }
    var arrStr:String = String.fromUtf8(arr.getOrThrow())
    var regex: Regex = Regex("file-name=([^&]+)");
    var matcher: Matcher = Matcher(regex, arrStr);
    var matchData: ?MatchData = matcher.find()
    match (matchData) {
    	case Some(v) =>
            var str: String = v.matchStr()
            var arrSplit:Array<String> = URL.parse(str).toString().split('.')
            if(arrSplit.size>1){
                return arrSplit[0].toAsciiUpper()
            }else{
                return ""
            }
        case None => return ""
    }
    return ""
}
