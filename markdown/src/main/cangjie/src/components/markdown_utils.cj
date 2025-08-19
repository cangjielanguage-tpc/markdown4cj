/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

func toCodeList(codeBlockListNodeView: NodeView): (ArrayList<String>, ArrayList<String>, ArrayList<String>) {
    var strText: ArrayList<String> = ArrayList<String>()
    var strInfoText: ArrayList<String> = ArrayList<String>()
    var strInfo: ArrayList<String> = ArrayList<String>()
    for (nodeView in codeBlockListNodeView.children) {
        if (nodeView.node is FencedCodeBlock) {
            strText.add((nodeView.node as FencedCodeBlock)().getLiteral())
            strInfoText.add((nodeView.node as FencedCodeBlock)().getInfo())
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
    } else {
        return ""
    }
}

/**
 * 字体样式列表设置
 *
 * @param isCode 是否是内联代码
 * @param markdownTheme markdown基础样式
 * @param isTitle 是否是标题
 * @return 返回需要显示的字体样式
 */
func spanFontFamily(isCode: Bool, markdownTheme: MarkdownTheme, isTitle: Bool): String {
    if (isCode) {
        // 内联代码情况设置内联代码字体样式
        return markdownTheme.codeTypeface
    } else {
        if (isTitle) {
            // 设置标题字体
            return markdownTheme.headingTypeface
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
 * @param markdownTheme markdown基础样式
 * @param isTitle 是否是标题
 * @param level 几级标题
 * @return 返回需要显示的字体大小
 */
func spanFontSize(isCode: Bool, markdownTheme: MarkdownTheme, isTitle: Bool, level: Int64): Float64 {
    if (isCode) {
        // 内联代码情况设置内联代码字体大小
        return markdownTheme.codeTextSize
    } else {
        if (isTitle) {
            return markdownTheme.headingTextSizeMultipliers[level - 1]
        } else {
            return markdownTheme.paragraphTextSize
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
        return FontWeight.W900
    } else {
        if (nodeView.strongEmphasis.isSome()) {
            return FontWeight.W900
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
    return if (nodeView.emphasis.isSome()) {
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
 * @param markdownTheme markdown基础样式
 * @param isHeading 是否是标题
 * @return 返回需要显示的字体颜色
 */
func spanFontColor(nodeView: NodeView, isCode: Bool, markdownTheme: MarkdownTheme, isHeading: Bool): Color {
    if (nodeView.link.isSome() || nodeView.node is HeadLink) {
        return markdownTheme.linkColor
    } else {
        if (isCode) {
            return markdownTheme.codeTextColor
        } else {
            if (isHeading) {
                return markdownTheme.headingTextColor
            } else {
                return markdownTheme.paragraphTextColor
            }
        }
    }
}

/**
 * 下划线中划线设置 - 链接设置下划线，删除设置中划线
 *
 * @param nodeView NodeView
 * @param markdownTheme markdown基础样式
 * @return 返回需要显示的下划线中划线，返回需要显示的下划线中划线颜色
 */
func spanDecoration(nodeView: NodeView, markdownTheme: MarkdownTheme): (TextDecorationType, Color) {
    // 是否是链接并且样式是否设置下划线
    if (nodeView.link.isSome() && markdownTheme.isLinkUnderlined) {
        // 是否是删除线
        if (nodeView.props.isSome() && nodeView.props().get("strikethrough").isSome()) {
            // TODO 需要同时设置下划线和中划线
            return (TextDecorationType.LineThrough, Color(0x191919))
        }
        return (TextDecorationType.Underline, markdownTheme.linkColor)
    } else {
        // 是否是删除线
        if (nodeView.props.isSome() && nodeView.props().get("strikethrough").isSome()) {
            return (TextDecorationType.LineThrough, Color(0x191919))
        }
        return (TextDecorationType.None, Color(0x191919))
    }
}

/**
 * TODO 内联代码背景色设置
 *
 * @param isCode 是否是内联代码
 * @param markdownTheme markdown基础样式
 * @return 返回需要显示的背景颜色
 */
func spanBackgroundColor(isCode: Bool, markdownTheme: MarkdownTheme): Color {
    // 内联代码情况需要设置背景色
    return if (isCode) {
        markdownTheme.codeBackgroundColor
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
        return markdownConfiguration.markdownTheme.codeListTitleSelectBackgroupColor
    } else {
        return markdownConfiguration.markdownTheme.codeListTitleUnSelectBackgroupColor
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
func codeTextColor(item: PrismNodesParseRes, markdownTheme: MarkdownTheme, prismTheme: PrismTheme): Color {
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
    return solidDots;
}

/**
 * 空心圆形
 *
 * @return 空心圆形UniCode码
 */
func hollowCircleToUnicode(): Rune {
    // ○
    let hollowCircle: Rune = '\u{25CB}'
    return hollowCircle;
}

/**
 * 实心正方形
 *
 * @return 实心正方形UniCode码
 */
func solidSquareToUnicode(): Rune {
    // ■
    let solidSquare: Rune = '\u{25A0}'
    return solidSquare;
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
func renderTableCellColor(tableCell: TableCell, tableTheme: TableTheme, rowCount: Int64): Color {
    var row: Int64 = rowCount
    if (tableCell.isHeader()) {
        return tableTheme.tableHeaderRowBackgroundColor
    }
    if (row % 2 == 0) {
        return tableTheme.tableOddRowBackgroundColor
    }
    return tableTheme.tableEvenRowBackgroundColor
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
        return 0.px
    }
}

/**
 * 对每张图片的 style 进行解析
 *
 * @param picStyle 图片样式集合
 * @param markdownConfiguration markdownConfiguration
 * @param componentWidth 父布局控件宽度 - 单位vp
 * @return PicStyleObj对象
 */
func parsePicStyle(picStyle: ArrayList<String>, markdownConfiguration: MarkdownConfiguration, componentWidthPx: Float64): PicStyleObj {
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
                    let picStyleObjWidth: Length = Int64.parse(value).vp
                    picStyleObj.width = if (picStyleObjWidth.value > componentWidth) {
                        componentWidth.vp
                    } else {
                        picStyleObjWidth
                    }
                }
                if (value[value.size - 2..] == "px") {
                    let picStyleObjWidth: Length = Int64.parse(value[..value.size - 2]).px
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
                        picStyleObj.width = opt.percent
                    }
                } else {
                    let picStyleObjWidth: Length = Int64.parse(value).vp
                    picStyleObj.width = if (picStyleObjWidth.value > componentWidth) {
                        componentWidth.vp
                    } else {
                        picStyleObjWidth
                    }
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
                    case "left" => picStyleObj.align = FlexAlign.Start
                    case "center" => picStyleObj.align = FlexAlign.Center
                    case "right" => picStyleObj.align = FlexAlign.End
                    case _ => ()
                }
            } else if (style.size > 15 && style[..15] == ":border-radius=") {
                let value = style[15..style.size - 2]
                picStyleObj.borderRadius = Int64.parse(value).px
            } else if (style[..7] == ":style=") {
                for (s in style[7..].split(";")) {
                    picStyle.add(":${s.replace(":","=")}")
                }
            }
        } catch (e: Exception) {}
    }
    return picStyleObj
}

/**
 * 释放PixelMap
 */
func delPixelMap(listPixelMap: ArrayList<?PixelMap>) {
    for (item in listPixelMap) {
        delPixelMap(item)
    }
    listPixelMap.clear()
}

/**
 * 释放PixelMap
 */
func delPixelMap(listPixelMap: ?PixelMap) {
    spawn {
        if (listPixelMap.isSome()) {
            listPixelMap().Release()
        }
    }
}

/**
 * 取消线程
 */
func threadFutureCancel(futs: ArrayList<?Future<Unit>>) {
    for (fut in futs) {
        threadFutureCancel(fut)
    }
}

/**
 * 取消线程
 */
func threadFutureCancel(fut: ?Future<Unit>) {
    spawn {
        if (fut.isSome()) {
            fut().cancel()
        }
    }
}

func pxToVp(pxFloat64: Float64) :Float64{
    return px2vp(pxFloat64.px)().value
}
