package markdown.components

let COLOR_WHITE: Color = Color.WHITE
let COLOR_RED: Color = Color.RED
let COLOR_BLACK: Color = Color.BLACK
let COLOR_TRANSPARENT: Color = Color.TRANSPARENT
let COLOR_GRAY: Color = Color.GRAY
let COLOR_FF191919: Color = Color(0xFF191919)
let COLOR_FFEAEAEA: Color = Color(0xFFEAEAEA)
let COLOR_E6000000: Color = Color(0xE6000000)
let COLOR_FFF5F5F5: Color = Color(0xFFF5F5F5)
let COLOR_FFE0E0E0: Color = Color(0xFFE0E0E0)
let COLOR_33000000: Color = Color(0x33000000)
let COLOR_1A000000: Color = Color(0x1A000000)
let COLOR_80000000: Color = Color(0x80000000)
let COLOR_FF1E1E1E: Color = Color(0xFF1E1E1E)
let COLOR_FF2D2D2D: Color = Color(0xFF2D2D2D)
let COLOR_FF404040: Color = Color(0xFF404040)
let COLOR_FF252526: Color = Color(0xFF252526)
let COLOR_FF4A90E2: Color = Color(0xFF4A90E2)
let COLOR_FFA0A0A0: Color = Color(0xFFA0A0A0)
let COLOR_40000000: Color = Color(0x40000000)

let SECONDS_PER_HOUR: Int64 = 3600
let SECONDS_PER_MINUTE: Int64 = 60

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
 * 设置文本字体族
 *
 * @param nodeView NodeView
 * @param markdownTheme markdown样式
 * @return 文本字体族
 */
func spanFontFamily(nodeView: NodeView, markdownTheme: MarkdownTheme): String {
    if (nodeView.isSubNode && markdownTheme.subTheme.subTextFontFamily.isSome()) {
        return markdownTheme.subTheme.subTextFontFamily() // 下标
    }
    if (nodeView.isSupNode && markdownTheme.supTheme.supTextFontFamily.isSome()) {
        return markdownTheme.supTheme.supTextFontFamily() // 上标
    }
    if (nodeView.isInLineCode && markdownTheme.inlineCodeTheme.inlineCodeTextFontFamily.isSome()) {
        return markdownTheme.inlineCodeTheme.inlineCodeTextFontFamily() // 内联代码
    }
    if (nodeView.isStrongEmphasis && markdownTheme.boldTheme.boldTextFontFamily.isSome()) {
        return markdownTheme.boldTheme.boldTextFontFamily() // 加粗
    }
    if (nodeView.isEmphasis && markdownTheme.italicTheme.italicTextFontFamily.isSome()) {
        return markdownTheme.italicTheme.italicTextFontFamily() // 斜体
    }
    if (nodeView.isStrikethrough && markdownTheme.strikethroughTheme.strikethroughTextFontFamily.isSome()) {
        return markdownTheme.strikethroughTheme.strikethroughTextFontFamily() // 删除线
    }
    if (nodeView.isUnderlineNode && markdownTheme.htmlUnderlineTheme.htmlUnderlineTextFontFamily.isSome()) {
        return markdownTheme.htmlUnderlineTheme.htmlUnderlineTextFontFamily() // 下划线
    }
    if (nodeView.isLink && markdownTheme.linkTheme.linkTextFontFamily.isSome()) {
        return markdownTheme.linkTheme.linkTextFontFamily() // 链接
    }
    if (nodeView.isFootnote && markdownTheme.footnoteRefTheme.footnoteRefTextFontFamily.isSome()) {
        return markdownTheme.footnoteRefTheme.footnoteRefTextFontFamily() // 脚注引用
    }
    if (nodeView.isHeading) {
        return headingFontFamily(nodeView.headingLevel, markdownTheme) // 标题
    }
    if (nodeView.isTable) {
        if (nodeView.isTableHead) {
            return markdownTheme.tableTheme.tableTitleTextFontFamily // 表格标题
        }
        return markdownTheme.tableTheme.tableContentTextFontFamily // 表格内容
    }
    return markdownTheme.paragraphTheme.paragraphTextFontFamily // 段落
}

/**
 * 设置不同等级标题文本字体族
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题文本字体族
 */
func headingFontFamily(level: Int64, markdownTheme: MarkdownTheme): String {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1TextFontFamily // 一级标题
        case 2 => markdownTheme.headingTheme.heading2TextFontFamily // 二级标题
        case 3 => markdownTheme.headingTheme.heading3TextFontFamily // 三级标题
        case 4 => markdownTheme.headingTheme.heading4TextFontFamily // 四级标题
        case 5 => markdownTheme.headingTheme.heading5TextFontFamily // 五级标题
        case 6 => markdownTheme.headingTheme.heading6TextFontFamily // 六级标题
        case _ => markdownTheme.headingTheme.heading6TextFontFamily // 其他
    }
}

/**
 * 设置文本字体大小
 *
 * @param nodeView NodeView
 * @param markdownTheme markdown样式
 * @return 文本字体大小
 */
func spanFontSize(nodeView: NodeView, markdownTheme: MarkdownTheme): Float64 {
    if (nodeView.isSubNode) {
        return markdownTheme.subTheme.subTextFontSize // 下标
    }
    if (nodeView.isSupNode) {
        return markdownTheme.supTheme.supTextFontSize // 上标
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
    if (nodeView.isInLineCode && markdownTheme.inlineCodeTheme.inlineCodeTextFontSize.isSome()) {
        return markdownTheme.inlineCodeTheme.inlineCodeTextFontSize() // 内联代码
    }
    if (nodeView.isStrongEmphasis && markdownTheme.boldTheme.boldTextFontSize.isSome()) {
        return markdownTheme.boldTheme.boldTextFontSize() // 加粗
    }
    if (nodeView.isEmphasis && markdownTheme.italicTheme.italicTextFontSize.isSome()) {
        return markdownTheme.italicTheme.italicTextFontSize() // 斜体
    }
    if (nodeView.isStrikethrough && markdownTheme.strikethroughTheme.strikethroughTextFontSize.isSome()) {
        return markdownTheme.strikethroughTheme.strikethroughTextFontSize() // 删除线
    }
    if (nodeView.isUnderlineNode && markdownTheme.htmlUnderlineTheme.htmlUnderlineTextFontSize.isSome()) {
        return markdownTheme.htmlUnderlineTheme.htmlUnderlineTextFontSize() // 下划线
    }
    if (nodeView.isLink && markdownTheme.linkTheme.linkTextFontSize.isSome()) {
        return markdownTheme.linkTheme.linkTextFontSize() // 链接
    }
    if (nodeView.isFootnote && markdownTheme.footnoteRefTheme.footnoteRefTextFontSize.isSome()) {
        return markdownTheme.footnoteRefTheme.footnoteRefTextFontSize() // 脚注引用
    }
    if (nodeView.isHeading) {
        return headingTextSize(nodeView.headingLevel, markdownTheme) // 标题
    }
    if (nodeView.isTable) {
        if (nodeView.isTableHead) {
            return markdownTheme.tableTheme.tableTitleTextFontSize // 表格标题
        }
        return markdownTheme.tableTheme.tableContentTextFontSize // 表格内容
    }
    return markdownTheme.paragraphTheme.paragraphTextFontSize // 段落
}

/**
 * 设置不同等级标题文本字体大小
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题文本字体大小
 */
func headingTextSize(level: Int64, markdownTheme: MarkdownTheme): Float64 {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1TextFontSize // 一级标题
        case 2 => markdownTheme.headingTheme.heading2TextFontSize // 二级标题
        case 3 => markdownTheme.headingTheme.heading3TextFontSize // 三级标题
        case 4 => markdownTheme.headingTheme.heading4TextFontSize // 四级标题
        case 5 => markdownTheme.headingTheme.heading5TextFontSize // 五级标题
        case 6 => markdownTheme.headingTheme.heading6TextFontSize // 六级标题
        case _ => markdownTheme.headingTheme.heading6TextFontSize // 其他
    }
}

/**
 * 设置文本的字体粗细
 *
 * @param nodeView NodeView
 * @param isTableFirst 表格第一列是否加粗
 * @param markdownTheme markdown样式
 * @return 文本的字体粗细
 */
func spanFontWeight(nodeView: NodeView, isTableFirst: Bool, markdownTheme: MarkdownTheme): FontWeight {
    if (nodeView.isSpanNode) {
        if (let Some(v) <- nodeView.spanNodeWeight) {
            return v // SpanNode
        }
    }
    if (nodeView.isSubNode && markdownTheme.subTheme.subTextFontWeight.isSome()) {
        return markdownTheme.subTheme.subTextFontWeight() // 下标
    }
    if (nodeView.isSupNode && markdownTheme.supTheme.supTextFontWeight.isSome()) {
        return markdownTheme.supTheme.supTextFontWeight() // 上标
    }
    if (nodeView.isInLineCode && markdownTheme.inlineCodeTheme.inlineCodeTextFontWeight.isSome()) {
        return markdownTheme.inlineCodeTheme.inlineCodeTextFontWeight() // 内联代码
    }
    if (nodeView.isStrongEmphasis) {
        return markdownTheme.boldTheme.boldTextFontWeight // 加粗
    }
    if (nodeView.isEmphasis && markdownTheme.italicTheme.italicTextFontWeight.isSome()) {
        return markdownTheme.italicTheme.italicTextFontWeight() // 斜体
    }
    if (nodeView.isStrikethrough && markdownTheme.strikethroughTheme.strikethroughTextFontWeight.isSome()) {
        return markdownTheme.strikethroughTheme.strikethroughTextFontWeight() // 删除线
    }
    if (nodeView.isUnderlineNode && markdownTheme.htmlUnderlineTheme.htmlUnderlineTextFontWeight.isSome()) {
        return markdownTheme.htmlUnderlineTheme.htmlUnderlineTextFontWeight() // 下划线
    }
    if (nodeView.isLink && markdownTheme.linkTheme.linkTextFontWeight.isSome()) {
        return markdownTheme.linkTheme.linkTextFontWeight() // 链接
    }
    if (nodeView.isFootnote && markdownTheme.footnoteRefTheme.footnoteRefTextFontWeight.isSome()) {
        return markdownTheme.footnoteRefTheme.footnoteRefTextFontWeight() // 脚注引用
    }
    if (nodeView.isHeading) {
        return headingFontWeight(nodeView.headingLevel, markdownTheme) // 标题
    }
    if (nodeView.isTable) {
        if (nodeView.isTableHead || isTableFirst) {
            return markdownTheme.tableTheme.tableTitleTextFontWeight // 表格标题
        }
        return markdownTheme.tableTheme.tableContentTextFontWeight // 表格内容
    }
    if (nodeView.isDescTerm) {
        return markdownTheme.definitionListTheme.definitionListTermTextFontWeight // 定义列表术语
    }
    return markdownTheme.paragraphTheme.paragraphTextFontWeight // 段落
}

/**
 * 设置不同等级标题文本的字体粗细
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题文本的字体粗细
 */
func headingFontWeight(level: Int64, markdownTheme: MarkdownTheme): FontWeight {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1TextFontWeight // 一级标题
        case 2 => markdownTheme.headingTheme.heading2TextFontWeight // 二级标题
        case 3 => markdownTheme.headingTheme.heading3TextFontWeight // 三级标题
        case 4 => markdownTheme.headingTheme.heading4TextFontWeight // 四级标题
        case 5 => markdownTheme.headingTheme.heading5TextFontWeight // 五级标题
        case 6 => markdownTheme.headingTheme.heading6TextFontWeight // 六级标题
        case _ => markdownTheme.headingTheme.heading6TextFontWeight // 其他
    }
}

/**
 * 设置文本字体样式
 *
 * @param nodeView NodeView
 * @param markdownTheme markdown样式
 * @return 文本字体样式
 */
func spanFontStyle(nodeView: NodeView, markdownTheme: MarkdownTheme): FontStyle {
    if (nodeView.isSubNode && markdownTheme.subTheme.subTextFontStyle.isSome()) {
        return markdownTheme.subTheme.subTextFontStyle() // 下标
    }
    if (nodeView.isSupNode && markdownTheme.supTheme.supTextFontStyle.isSome()) {
        return markdownTheme.supTheme.supTextFontStyle() // 上标
    }
    if (nodeView.isInLineCode && markdownTheme.inlineCodeTheme.inlineCodeTextFontStyle.isSome()) {
        return markdownTheme.inlineCodeTheme.inlineCodeTextFontStyle() // 内联代码
    }
    if (nodeView.isStrongEmphasis && markdownTheme.boldTheme.boldTextFontStyle.isSome()) {
        return markdownTheme.boldTheme.boldTextFontStyle() // 加粗
    }
    if (nodeView.isEmphasis) {
        return FontStyle.Italic // 斜体
    }
    if (nodeView.isStrikethrough && markdownTheme.strikethroughTheme.strikethroughTextFontStyle.isSome()) {
        return markdownTheme.strikethroughTheme.strikethroughTextFontStyle() // 删除线
    }
    if (nodeView.isUnderlineNode && markdownTheme.htmlUnderlineTheme.htmlUnderlineTextFontStyle.isSome()) {
        return markdownTheme.htmlUnderlineTheme.htmlUnderlineTextFontStyle() // 下划线
    }
    if (nodeView.isLink && markdownTheme.linkTheme.linkTextFontStyle.isSome()) {
        return markdownTheme.linkTheme.linkTextFontStyle() // 链接
    }
    if (nodeView.isFootnote && markdownTheme.footnoteRefTheme.footnoteRefTextFontStyle.isSome()) {
        return markdownTheme.footnoteRefTheme.footnoteRefTextFontStyle() // 脚注引用
    }
    if (nodeView.isHeading) {
        return headingFontStyle(nodeView.headingLevel, markdownTheme) // 标题
    }
    if (nodeView.isTable) {
        if (nodeView.isTableHead) {
            return markdownTheme.tableTheme.tableTitleTextFontStyle // 表格标题
        }
        return markdownTheme.tableTheme.tableContentTextFontStyle // 表格内容
    }
    if (nodeView.isDescTerm) {
        return markdownTheme.definitionListTheme.definitionListTermTextFontStyle // 定义列表术语
    }
    return markdownTheme.paragraphTheme.paragraphTextFontStyle // 段落
}

/**
 * 设置不同等级标题文本字体样式
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题文本字体样式
 */
func headingFontStyle(level: Int64, markdownTheme: MarkdownTheme): FontStyle {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1TextFontStyle // 一级标题
        case 2 => markdownTheme.headingTheme.heading2TextFontStyle // 二级标题
        case 3 => markdownTheme.headingTheme.heading3TextFontStyle // 三级标题
        case 4 => markdownTheme.headingTheme.heading4TextFontStyle // 四级标题
        case 5 => markdownTheme.headingTheme.heading5TextFontStyle // 五级标题
        case 6 => markdownTheme.headingTheme.heading6TextFontStyle // 六级标题
        case _ => markdownTheme.headingTheme.heading6TextFontStyle // 其他
    }
}

/**
 * 设置文本字体颜色
 *
 * @param nodeView NodeView
 * @param markdownTheme markdown样式
 * @return 文本字体颜色
 */
func spanFontColor(nodeView: NodeView, markdownTheme: MarkdownTheme): Color {
    if (nodeView.isSubNode && markdownTheme.subTheme.subTextFontColor.isSome()) {
        return markdownTheme.subTheme.subTextFontColor() // 下标
    }
    if (nodeView.isSupNode && markdownTheme.supTheme.supTextFontColor.isSome()) {
        return markdownTheme.supTheme.supTextFontColor() // 上标
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
    if (nodeView.isInLineCode && markdownTheme.inlineCodeTheme.inlineCodeTextFontColor.isSome()) {
        return markdownTheme.inlineCodeTheme.inlineCodeTextFontColor() // 内联代码
    }
    if (nodeView.isStrongEmphasis && markdownTheme.boldTheme.boldTextFontColor.isSome()) {
        return markdownTheme.boldTheme.boldTextFontColor() // 加粗
    }
    if (nodeView.isEmphasis && markdownTheme.italicTheme.italicTextFontColor.isSome()) {
        return markdownTheme.italicTheme.italicTextFontColor() // 斜体
    }
    if (nodeView.isStrikethrough && markdownTheme.strikethroughTheme.strikethroughTextFontColor.isSome()) {
        return markdownTheme.strikethroughTheme.strikethroughTextFontColor() // 删除线
    }
    if (nodeView.isUnderlineNode && markdownTheme.htmlUnderlineTheme.htmlUnderlineTextFontColor.isSome()) {
        return markdownTheme.htmlUnderlineTheme.htmlUnderlineTextFontColor() // 下划线
    }
    if (nodeView.isLink) {
        return markdownTheme.linkTheme.linkTextFontColor // 链接
    }
    if (nodeView.isFootnote) {
        return markdownTheme.footnoteRefTheme.footnoteRefTextFontColor // 脚注引用
    }
    if (nodeView.isHeading) {
        return headColor(nodeView.headingLevel, markdownTheme) // 标题
    }
    if (nodeView.isTable) {
        if (nodeView.isTableHead) {
            return markdownTheme.tableTheme.tableTitleTextFontColor // 表格标题
        }
        return markdownTheme.tableTheme.tableContentTextFontColor // 表格内容
    }
    return markdownTheme.paragraphTheme.paragraphTextFontColor // 段落和其他
}

/**
 * 设置不同等级标题文本字体颜色
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题文本字体颜色
 */
func headColor(level: Int64, markdownTheme: MarkdownTheme): Color {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1TextFontColor // 一级标题
        case 2 => markdownTheme.headingTheme.heading2TextFontColor // 二级标题
        case 3 => markdownTheme.headingTheme.heading3TextFontColor // 三级标题
        case 4 => markdownTheme.headingTheme.heading4TextFontColor // 四级标题
        case 5 => markdownTheme.headingTheme.heading5TextFontColor // 五级标题
        case 6 => markdownTheme.headingTheme.heading6TextFontColor // 六级标题
        case _ => markdownTheme.headingTheme.heading6TextFontColor // 其他
    }
}

/**
 * 设置文本字符间距
 *
 * @param nodeView NodeView
 * @param markdownTheme markdown样式
 * @return 文本字符间距
 */
func spanLetterSpacing(nodeView: NodeView, markdownTheme: MarkdownTheme): Float64 {
    if (nodeView.isSubNode && markdownTheme.subTheme.subTextLetterSpacing.isSome()) {
        return markdownTheme.subTheme.subTextLetterSpacing() // 下标
    }
    if (nodeView.isSupNode && markdownTheme.supTheme.supTextLetterSpacing.isSome()) {
        return markdownTheme.supTheme.supTextLetterSpacing() // 上标
    }
    if (nodeView.isInLineCode && markdownTheme.inlineCodeTheme.inlineCodeTextLetterSpacing.isSome()) {
        return markdownTheme.inlineCodeTheme.inlineCodeTextLetterSpacing() // 内联代码
    }
    if (nodeView.isStrongEmphasis && markdownTheme.boldTheme.boldTextLetterSpacing.isSome()) {
        return markdownTheme.boldTheme.boldTextLetterSpacing() // 加粗
    }
    if (nodeView.isEmphasis && markdownTheme.italicTheme.italicTextLetterSpacing.isSome()) {
        return markdownTheme.italicTheme.italicTextLetterSpacing() // 斜体
    }
    if (nodeView.isStrikethrough && markdownTheme.strikethroughTheme.strikethroughTextLetterSpacing.isSome()) {
        return markdownTheme.strikethroughTheme.strikethroughTextLetterSpacing() // 删除线
    }
    if (nodeView.isUnderlineNode && markdownTheme.htmlUnderlineTheme.htmlUnderlineTextLetterSpacing.isSome()) {
        return markdownTheme.htmlUnderlineTheme.htmlUnderlineTextLetterSpacing() // 下划线
    }
    if (nodeView.isLink && markdownTheme.linkTheme.linkTextLetterSpacing.isSome()) {
        return markdownTheme.linkTheme.linkTextLetterSpacing() // 链接
    }
    if (nodeView.isFootnote && markdownTheme.footnoteRefTheme.footnoteRefTextLetterSpacing.isSome()) {
        return markdownTheme.footnoteRefTheme.footnoteRefTextLetterSpacing() // 脚注引用
    }
    if (nodeView.isHeading) {
        return headLetterSpacing(nodeView.headingLevel, markdownTheme) // 标题
    }
    if (nodeView.isTable) {
        if (nodeView.isTableHead) {
            return markdownTheme.tableTheme.tableTitleTextLetterSpacing // 表格标题
        }
        return markdownTheme.tableTheme.tableContentTextLetterSpacing // 表格内容
    }
    return markdownTheme.paragraphTheme.paragraphTextLetterSpacing // 段落
}

/**
 * 设置不同等级标题文本字符间距
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 文本字符间距
 */
func headLetterSpacing(level: Int64, markdownTheme: MarkdownTheme): Float64 {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1TextLetterSpacing // 一级标题
        case 2 => markdownTheme.headingTheme.heading2TextLetterSpacing // 二级标题
        case 3 => markdownTheme.headingTheme.heading3TextLetterSpacing // 三级标题
        case 4 => markdownTheme.headingTheme.heading4TextLetterSpacing // 四级标题
        case 5 => markdownTheme.headingTheme.heading5TextLetterSpacing // 五级标题
        case 6 => markdownTheme.headingTheme.heading6TextLetterSpacing // 六级标题
        case _ => markdownTheme.headingTheme.heading6TextLetterSpacing // 其他
    }
}

/**
 * 设置文本装饰线样式及其颜色
 *
 * @param nodeView NodeView
 * @param markdownTheme markdown样式
 * @return 文本装饰线样式及其颜色
 */
func spanDecoration(nodeView: NodeView, markdownTheme: MarkdownTheme): (TextDecorationType, Color, Int32) {
    if (nodeView.isStrikethrough) {
        return (TextDecorationType.LineThrough, markdownTheme.strikethroughTheme.strikethroughTextDecorationColor, markdownTheme.strikethroughTheme.strikethroughTextDecorationStyle.toInt32()) // 删除线
    }
    if (nodeView.isUnderlineNode) {
        return (TextDecorationType.Underline, markdownTheme.htmlUnderlineTheme.htmlUnderlineTextDecorationColor, markdownTheme.htmlUnderlineTheme.htmlUnderlineTextDecorationStyle.toInt32()) // 下划线
    }
    if (nodeView.isLink) {
        return (markdownTheme.linkTheme.linkTextDecorationType, markdownTheme.linkTheme.linkTextDecorationColor, markdownTheme.linkTheme.linkTextDecorationStyle.toInt32()) // 链接
    }
    if (nodeView.isFootnote) {
        return (markdownTheme.footnoteRefTheme.footnoteRefTextDecorationType, markdownTheme.footnoteRefTheme.footnoteRefTextDecorationColor, markdownTheme.footnoteRefTheme.footnoteRefTextDecorationStyle.toInt32()) // 脚注引用
    }
    return (TextDecorationType.None, COLOR_TRANSPARENT, 0) // 其他
}

/**
 * 设置文本背景颜色及圆角
 *
 * @param nodeView NodeView
 * @param markdownTheme markdown样式
 * @return 文本背景颜色及圆角
 */
func spanBackgroundColor18(nodeView: NodeView, markdownTheme: MarkdownTheme): (Color, Float64, Float64, Float64, Float64) {
    if (nodeView.isInLineCode) {
        return (markdownTheme.inlineCodeTheme.inlineCodeTextBackgroundColor, markdownTheme.inlineCodeTheme.inlineCodeTextBackgroundRadiusTopLeft, markdownTheme.inlineCodeTheme.inlineCodeTextBackgroundRadiusTopRight, markdownTheme.inlineCodeTheme.inlineCodeTextBackgroundRadiusBottomLeft, markdownTheme.inlineCodeTheme.inlineCodeTextBackgroundRadiusBottomRight) // 内联代码
    }
    if (nodeView.isLink) {
        return (markdownTheme.linkTheme.linkTextBackgroundColor, markdownTheme.linkTheme.linkTextBackgroundRadiusTopLeft, markdownTheme.linkTheme.linkTextBackgroundRadiusTopRight, markdownTheme.linkTheme.linkTextBackgroundRadiusBottomLeft, markdownTheme.linkTheme.linkTextBackgroundRadiusBottomRight) // 链接
    }
    if (nodeView.isFootnote) {
        return (markdownTheme.footnoteRefTheme.footnoteRefTextBackgroundColor, markdownTheme.footnoteRefTheme.footnoteRefTextBackgroundRadiusTopLeft, markdownTheme.footnoteRefTheme.footnoteRefTextBackgroundRadiusTopRight, markdownTheme.footnoteRefTheme.footnoteRefTextBackgroundRadiusBottomLeft, markdownTheme.footnoteRefTheme.footnoteRefTextBackgroundRadiusBottomRight) // 脚注引用
    }
    return (COLOR_TRANSPARENT, 0.0, 0.0, 0.0, 0.0) // 其他
}

/**
 * 设置文本背景颜色及圆角
 *
 * @param nodeView NodeView
 * @param markdownTheme markdown样式
 * @return 文本背景颜色及圆角
 */
func spanBackgroundColor19(nodeView: NodeView, markdownTheme: MarkdownTheme): TextBackgroundStyle {
    if (nodeView.isInLineCode) {
        return TextBackgroundStyle(color: markdownTheme.inlineCodeTheme.inlineCodeTextBackgroundColor, radiusBorder: BorderRadiuses(topLeft: markdownTheme.inlineCodeTheme.inlineCodeTextBackgroundRadiusTopLeft.vp, topRight: markdownTheme.inlineCodeTheme.inlineCodeTextBackgroundRadiusTopRight.vp, bottomLeft: markdownTheme.inlineCodeTheme.inlineCodeTextBackgroundRadiusBottomLeft.vp, bottomRight: markdownTheme.inlineCodeTheme.inlineCodeTextBackgroundRadiusBottomRight.vp)) // 内联代码
    }
    if (nodeView.isLink) {
        return TextBackgroundStyle(color: markdownTheme.linkTheme.linkTextBackgroundColor, radiusBorder: BorderRadiuses(topLeft: markdownTheme.linkTheme.linkTextBackgroundRadiusTopLeft.vp, topRight: markdownTheme.linkTheme.linkTextBackgroundRadiusTopRight.vp, bottomLeft: markdownTheme.linkTheme.linkTextBackgroundRadiusBottomLeft.vp, bottomRight: markdownTheme.linkTheme.linkTextBackgroundRadiusBottomRight.vp)) // 链接
    }
    if (nodeView.isFootnote) {
        return TextBackgroundStyle(color: markdownTheme.footnoteRefTheme.footnoteRefTextBackgroundColor, radiusBorder: BorderRadiuses(topLeft: markdownTheme.footnoteRefTheme.footnoteRefTextBackgroundRadiusTopLeft.vp, topRight: markdownTheme.footnoteRefTheme.footnoteRefTextBackgroundRadiusTopRight.vp, bottomLeft: markdownTheme.footnoteRefTheme.footnoteRefTextBackgroundRadiusBottomLeft.vp, bottomRight: markdownTheme.footnoteRefTheme.footnoteRefTextBackgroundRadiusBottomRight.vp)) // 脚注引用
    }
    return TextBackgroundStyle(color: COLOR_TRANSPARENT, radiusBorder: BorderRadiuses(topLeft: 0.0.vp, topRight: 0.0.vp, bottomLeft: 0.0.vp, bottomRight: 0.0.vp)) // 其他
}

/**
 * 设置文本基线的偏移量
 *
 * @param nodeView NodeView
 * @param markdownTheme markdown样式
 * @return 文本基线的偏移量
 */
func spanBaselineOffset(nodeView: NodeView, markdownTheme: MarkdownTheme): Float64 {
    if (nodeView.isSubNode) {
        return markdownTheme.subTheme.subTextBaselineOffset // 下标
    }
    if (nodeView.isSupNode) {
        return markdownTheme.supTheme.supTextBaselineOffset // 上标
    }
    return 0.0 // 其他
}

/**
 * 设置文本行高
 *
 * @param nodeView NodeView
 * @param markdownTheme markdown样式
 * @return 文本行高
 */
func spanLineHeight(nodeView: NodeView, markdownTheme: MarkdownTheme): Float64 {
    if (nodeView.isInLineCode && markdownTheme.inlineCodeTheme.inlineCodeTextLineHeight.isSome()) {
        return markdownTheme.inlineCodeTheme.inlineCodeTextLineHeight() // 内联代码
    }
    if (nodeView.isStrongEmphasis && markdownTheme.boldTheme.boldTextLineHeight.isSome()) {
        return markdownTheme.boldTheme.boldTextLineHeight() // 加粗
    }
    if (nodeView.isEmphasis && markdownTheme.italicTheme.italicTextLineHeight.isSome()) {
        return markdownTheme.italicTheme.italicTextLineHeight() // 斜体
    }
    if (nodeView.isStrikethrough && markdownTheme.strikethroughTheme.strikethroughTextLineHeight.isSome()) {
        return markdownTheme.strikethroughTheme.strikethroughTextLineHeight() // 删除线
    }
    if (nodeView.isUnderlineNode && markdownTheme.htmlUnderlineTheme.htmlUnderlineTextLineHeight.isSome()) {
        return markdownTheme.htmlUnderlineTheme.htmlUnderlineTextLineHeight() // 下划线
    }
    if (nodeView.isLink && markdownTheme.linkTheme.linkTextLineHeight.isSome()) {
        return markdownTheme.linkTheme.linkTextLineHeight() // 链接
    }
    if (nodeView.isFootnote && markdownTheme.footnoteRefTheme.footnoteRefTextLineHeight.isSome()) {
        return markdownTheme.footnoteRefTheme.footnoteRefTextLineHeight() // 脚注引用
    }
    if (nodeView.isHeading) {
        return headLineHeight(nodeView.headingLevel, markdownTheme) // 标题
    }
    if (nodeView.isTable) {
        if (nodeView.isTableHead) {
            return markdownTheme.tableTheme.tableTitleTextLineHeight // 表格标题
        }
        return markdownTheme.tableTheme.tableContentTextLineHeight // 表格内容
    }
    return markdownTheme.paragraphTheme.paragraphTextLineHeight // 段落
}

/**
 * 设置标题文本行高
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题文本行高
 */
func headLineHeight(level: Int64, markdownTheme: MarkdownTheme): Float64 {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1TextLineHeight // 一级标题
        case 2 => markdownTheme.headingTheme.heading2TextLineHeight // 二级标题
        case 3 => markdownTheme.headingTheme.heading3TextLineHeight // 三级标题
        case 4 => markdownTheme.headingTheme.heading4TextLineHeight // 四级标题
        case 5 => markdownTheme.headingTheme.heading5TextLineHeight // 五级标题
        case 6 => markdownTheme.headingTheme.heading6TextLineHeight // 六级标题
        case _ => markdownTheme.headingTheme.heading6TextLineHeight // 其他
    }
}

/**
 * 设置不同等级标题上外边距
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题上外边距
 */
func headingMarginTop(level: Int64, markdownTheme: MarkdownTheme): Float64 {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1MarginTop // 一级标题
        case 2 => markdownTheme.headingTheme.heading2MarginTop // 二级标题
        case 3 => markdownTheme.headingTheme.heading3MarginTop // 三级标题
        case 4 => markdownTheme.headingTheme.heading4MarginTop // 四级标题
        case 5 => markdownTheme.headingTheme.heading5MarginTop // 五级标题
        case 6 => markdownTheme.headingTheme.heading6MarginTop // 六级标题
        case _ => markdownTheme.headingTheme.heading6MarginTop // 其他
    }
}

/**
 * 设置不同等级标题右外边距
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题右外边距
 */
func headingMarginRight(level: Int64, markdownTheme: MarkdownTheme): Float64 {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1MarginRight // 一级标题
        case 2 => markdownTheme.headingTheme.heading2MarginRight // 二级标题
        case 3 => markdownTheme.headingTheme.heading3MarginRight // 三级标题
        case 4 => markdownTheme.headingTheme.heading4MarginRight // 四级标题
        case 5 => markdownTheme.headingTheme.heading5MarginRight // 五级标题
        case 6 => markdownTheme.headingTheme.heading6MarginRight // 六级标题
        case _ => markdownTheme.headingTheme.heading6MarginRight // 其他
    }
}

/**
 * 设置不同等级标题下外边距
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题下外边距
 */
func headingMarginBottom(level: Int64, markdownTheme: MarkdownTheme): Float64 {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1MarginBottom // 一级标题
        case 2 => markdownTheme.headingTheme.heading2MarginBottom // 二级标题
        case 3 => markdownTheme.headingTheme.heading3MarginBottom // 三级标题
        case 4 => markdownTheme.headingTheme.heading4MarginBottom // 四级标题
        case 5 => markdownTheme.headingTheme.heading5MarginBottom // 五级标题
        case 6 => markdownTheme.headingTheme.heading6MarginBottom // 六级标题
        case _ => markdownTheme.headingTheme.heading6MarginBottom // 其他
    }
}

/**
 * 设置不同等级标题左外边距
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题左外边距
 */
func headingMarginLeft(level: Int64, markdownTheme: MarkdownTheme): Float64 {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1MarginLeft // 一级标题
        case 2 => markdownTheme.headingTheme.heading2MarginLeft // 二级标题
        case 3 => markdownTheme.headingTheme.heading3MarginLeft // 三级标题
        case 4 => markdownTheme.headingTheme.heading4MarginLeft // 四级标题
        case 5 => markdownTheme.headingTheme.heading5MarginLeft // 五级标题
        case 6 => markdownTheme.headingTheme.heading6MarginLeft // 六级标题
        case _ => markdownTheme.headingTheme.heading6MarginLeft // 其他
    }
}

/**
 * 设置不同等级标题上内边距
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题上内边距
 */
func headingPaddingTop(level: Int64, markdownTheme: MarkdownTheme): Float64 {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1PaddingTop // 一级标题
        case 2 => markdownTheme.headingTheme.heading2PaddingTop // 二级标题
        case 3 => markdownTheme.headingTheme.heading3PaddingTop // 三级标题
        case 4 => markdownTheme.headingTheme.heading4PaddingTop // 四级标题
        case 5 => markdownTheme.headingTheme.heading5PaddingTop // 五级标题
        case 6 => markdownTheme.headingTheme.heading6PaddingTop // 六级标题
        case _ => markdownTheme.headingTheme.heading6PaddingTop // 其他
    }
}

/**
 * 设置不同等级标题右内边距
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题右内边距
 */
func headingPaddingRight(level: Int64, markdownTheme: MarkdownTheme): Float64 {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1PaddingRight // 一级标题
        case 2 => markdownTheme.headingTheme.heading2PaddingRight // 二级标题
        case 3 => markdownTheme.headingTheme.heading3PaddingRight // 三级标题
        case 4 => markdownTheme.headingTheme.heading4PaddingRight // 四级标题
        case 5 => markdownTheme.headingTheme.heading5PaddingRight // 五级标题
        case 6 => markdownTheme.headingTheme.heading6PaddingRight // 六级标题
        case _ => markdownTheme.headingTheme.heading6PaddingRight // 其他
    }
}

/**
 * 设置不同等级标题下内边距
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题标题下内边距
 */
func headingPaddingBottom(level: Int64, markdownTheme: MarkdownTheme): Float64 {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1PaddingBottom // 一级标题
        case 2 => markdownTheme.headingTheme.heading2PaddingBottom // 二级标题
        case 3 => markdownTheme.headingTheme.heading3PaddingBottom // 三级标题
        case 4 => markdownTheme.headingTheme.heading4PaddingBottom // 四级标题
        case 5 => markdownTheme.headingTheme.heading5PaddingBottom // 五级标题
        case 6 => markdownTheme.headingTheme.heading6PaddingBottom // 六级标题
        case _ => markdownTheme.headingTheme.heading6PaddingBottom // 其他
    }
}

/**
 * 设置不同等级标题左内边距
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @return 标题左内边距
 */
func headingPaddingLeft(level: Int64, markdownTheme: MarkdownTheme): Float64 {
    return match (level) {
        case 1 => markdownTheme.headingTheme.heading1PaddingLeft // 一级标题
        case 2 => markdownTheme.headingTheme.heading2PaddingLeft // 二级标题
        case 3 => markdownTheme.headingTheme.heading3PaddingLeft // 三级标题
        case 4 => markdownTheme.headingTheme.heading4PaddingLeft // 四级标题
        case 5 => markdownTheme.headingTheme.heading5PaddingLeft // 五级标题
        case 6 => markdownTheme.headingTheme.heading6PaddingLeft // 六级标题
        case _ => markdownTheme.headingTheme.heading6PaddingLeft // 其他
    }
}

/**
 * 设置不同等级标题背景颜色
 *
 * @param level 标题等级
 * @param markdownTheme markdown样式
 * @param nodeView NodeView
 * @return 标题背景颜色
 */
func headingBackgroundColor(level: Int64, markdownTheme: MarkdownTheme, nodeView: NodeView): Color {
    if (nodeView.isQuote) {
        return markdownTheme.blockQuoteTheme.blockQuoteBackgroundColor // 块引用中的标题
    }
    match (level) {
        case 1 =>
            if (let Some(v) <- markdownTheme.headingTheme.heading1BackgroundColor) {
                return v // 一级标题
            }
        case 2 =>
            if (let Some(v) <- markdownTheme.headingTheme.heading2BackgroundColor) {
                return v // 二级标题
            }
        case 3 =>
            if (let Some(v) <- markdownTheme.headingTheme.heading3BackgroundColor) {
                return v // 三级标题
            }
        case 4 =>
            if (let Some(v) <- markdownTheme.headingTheme.heading4BackgroundColor) {
                return v // 四级标题
            }
        case 5 =>
            if (let Some(v) <- markdownTheme.headingTheme.heading5BackgroundColor) {
                return v // 五级标题
            }
        case 6 =>
            if (let Some(v) <- markdownTheme.headingTheme.heading6BackgroundColor) {
                return v // 六级标题
            }
        case _ => return markdownTheme.globalTheme.backgroundColor // 其他
    }
    return markdownTheme.globalTheme.backgroundColor
}

/**
 * 设置段落背景颜色
 *
 * @param markdownTheme MarkdownTheme
 * @param nodeView NodeView
 * @return 段落背景颜色
 */
func paragraphBackgroundColor(markdownTheme: MarkdownTheme, nodeView: NodeView): Color {
    if (nodeView.isQuote) {
        return markdownTheme.blockQuoteTheme.blockQuoteBackgroundColor // 块引用中的段落
    }
    if (let Some(v) <- markdownTheme.paragraphTheme.paragraphBackgroundColor) {
        return v // 段落
    }
    return markdownTheme.globalTheme.backgroundColor
}

/**
 * 设置有序/无序/任务列表背景颜色
 *
 * @param isBullet 是否是无序列表
 * @param markdownTheme MarkdownTheme
 * @param nodeView NodeView
 * @return 有序/无序/任务列表背景颜色
 */
func listBackgroundColor(isBullet: Bool, markdownTheme: MarkdownTheme, nodeView: NodeView): Color {
    if (nodeView.isQuote) {
        return markdownTheme.blockQuoteTheme.blockQuoteBackgroundColor // 块引用中的列表
    }
    if (isBullet) {
        if (let Some(v) <- markdownTheme.orderedListTheme.orderedListBackgroundColor) {
            return v // 有序列表
        }
    } else {
        if (let Some(v) <- markdownTheme.bulletListTheme.bulletListBackgroundColor) {
            return v // 无序列表
        }
    }
    return markdownTheme.globalTheme.backgroundColor
}

/**
 * 设置有序/无序/任务列表子模块上下间距
 *
 * @param markdownTheme markdown样式
 * @param nodeView NodeView
 * @return 列表子模块上下间距
 */
func listChildSpacing(markdownTheme: MarkdownTheme, nodeView: NodeView): Int64 {
    if (nodeView.nodeType == "BulletList") {
        return markdownTheme.bulletListTheme.bulletListChildSpacing
    } else if (nodeView.nodeType == "OrderedList") {
        return markdownTheme.orderedListTheme.orderedListChildSpacing
    }
    return 0
}

/**
 * 设置有序/无序/任务列表子模块中子模块上下间距
 *
 * @param markdownTheme markdown样式
 * @param nodeView NodeView
 * @return 列表子模块上下间距
 */
func listChildChildSpacing(markdownTheme: MarkdownTheme, nodeView: NodeView): Int64 {
    if (nodeView.isBulletList) {
        return markdownTheme.bulletListTheme.bulletListChildChildSpacing
    } else if (nodeView.isOrderedList) {
        return markdownTheme.orderedListTheme.orderedListChildChildSpacing
    }
    return 0
}

/**
 * 有序/无序前缀文本内容
 *
 * @param item NodeView
 * @param listDepth 列表深度
 * @param isBullet 是否是无序列表
 * @param markdownTheme markdown样式
 * @return 前缀文本内容
 */
func listPrefixStr(item: NodeView, listDepth: Int64, isBullet: Bool, markdownTheme: MarkdownTheme): String {
    if (isBullet) {
        // 有序列表
        return "${item.orderedListNumber}."
    }
    if (markdownTheme.bulletListTheme.bulletListBulletIsCircle) {
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
 * 有序/无序列表前缀文本颜色
 *
 * @param isBullet 是否是无序列表
 * @param markdownTheme markdown样式
 * @return 前缀文本颜色
 */
func listPrefixColor(isBullet: Bool, markdownTheme: MarkdownTheme): Color {
    if (isBullet) {
        return markdownTheme.orderedListTheme.orderedListMarkerTextFontColor // 有序列表
    } else {
        return markdownTheme.bulletListTheme.bulletListBulletTextFontColor // 无序列表
    }
}

/**
 * 有序/无序列表前缀文本尺寸
 *
 * @param isBullet 是否是无序列表
 * @param markdownTheme markdown样式
 * @return 前缀文本尺寸
 */
func listPrefixSize(isBullet: Bool, markdownTheme: MarkdownTheme): Float64 {
    if (isBullet) {
        return markdownTheme.orderedListTheme.orderedListMarkerTextFontSize // 有序列表
    } else {
        return markdownTheme.bulletListTheme.bulletListBulletTextFontSize // 无序列表
    }
}

/**
 * 有序/无序列表前缀文本字体样式
 *
 * @param isBullet 是否是无序列表
 * @param markdownTheme markdown样式
 * @return 前缀文本字体样式
 */
func listPrefixFontStyle(isBullet: Bool, markdownTheme: MarkdownTheme): FontStyle {
    if (isBullet) {
        return markdownTheme.orderedListTheme.orderedListMarkerTextFontStyle // 有序列表
    } else {
        return markdownTheme.bulletListTheme.bulletListBulletTextFontStyle // 无序列表
    }
}

/**
 * 有序/无序列表前缀文本字体粗细
 *
 * @param isBullet 是否是无序列表
 * @param markdownTheme markdown样式
 * @return 前缀文本字体粗细
 */
func listPrefixFontWeight(isBullet: Bool, markdownTheme: MarkdownTheme): FontWeight {
    if (isBullet) {
        return markdownTheme.orderedListTheme.orderedListMarkerTextFontWeight // 有序列表
    } else {
        return markdownTheme.bulletListTheme.bulletListBulletTextFontWeight // 无序列表
    }
}

/**
 * 有序/无序列表前缀文本字体
 *
 * @param isBullet 是否是无序列表
 * @param markdownTheme markdown样式
 * @return 前缀文本字体
 */
func listPrefixFontFamily(isBullet: Bool, markdownTheme: MarkdownTheme): String {
    if (isBullet) {
        return markdownTheme.orderedListTheme.orderedListMarkerTextFontFamily // 有序列表
    } else {
        return markdownTheme.bulletListTheme.bulletListBulletTextFontFamily // 无序列表
    }
}

/**
 * 有序/无序列表前缀文本行高
 *
 * @param isBullet 是否是无序列表
 * @param markdownTheme markdown样式
 * @return 前缀文本行高
 */
func listPrefixLineHeight(isBullet: Bool, markdownTheme: MarkdownTheme): Float64 {
    if (isBullet) {
        return markdownTheme.orderedListTheme.orderedListMarkerTextLineHeight // 有序列表
    } else {
        return markdownTheme.bulletListTheme.bulletListBulletTextLineHeight // 无序列表
    }
}

/**
 * 有序列表列表编号和列表内容间距/无序列表列表符号和列表内容间距
 *
 * @param isBullet 是否是无序列表
 * @param markdownTheme markdown样式
 * @return 间距
 */
func listPrefixSpacing(isBullet: Bool, markdownTheme: MarkdownTheme): Float64 {
    if (isBullet) {
        return markdownTheme.orderedListTheme.orderedListMarkerSpacing // 有序列表
    } else {
        return markdownTheme.bulletListTheme.bulletListBulletSpacing // 无序列表
    }
}

/**
 * 设置定义列表定义行间距
 *
 * @param idx 第几条定义行
 * @param markdownTheme MarkdownTheme
 * @return 定义行间距
 */
func descDefItemSpacing(idx: Int64, markdownTheme: MarkdownTheme): Float64 {
    if (idx == 1) {
        return 0.0
    }
    return markdownTheme.definitionListTheme.definitionListDescriptionItemSpacing
}

/**
 * 设置定义列表背景颜色
 *
 * @param markdownTheme MarkdownTheme
 * @return 定义列表背景颜色
 */
func definitionListBackgroundColor(markdownTheme: MarkdownTheme): Color {
    if (let Some(v) <- markdownTheme.definitionListTheme.definitionListBackgroundColor) {
        return v // 定义列表
    }
    return markdownTheme.globalTheme.backgroundColor
}

/**
 * 表格格子背景颜色
 *
 * @param isHeader 是否是标题
 * @param markdownTheme markdown样式
 * @param rowCount 第几行
 * @return 表格格子背景颜色
 */
func renderTableCellColor(isHeader: Bool, markdownTheme: MarkdownTheme, rowCount: Int64): Color {
    if (isHeader) {
        return markdownTheme.tableTheme.tableTitleBackgroundColor // 表格标题
    }
    if (rowCount % 2 == 0) {
        return markdownTheme.tableTheme.tableContentEvenRowBackgroundColor // 表格内容奇数行
    }
    return markdownTheme.tableTheme.tableContentOddRowBackgroundColor // 表格内容偶数行
}

/**
 * 表格格子对齐方式
 *
 * @param alignment TableAlignment
 * @return 对齐方式
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
 * 设置脚注背景颜色
 *
 * @param markdownTheme MarkdownTheme
 * @param nodeView NodeView
 * @return 脚注背景颜色
 */
func footnoteBackgroundColor(markdownTheme: MarkdownTheme, nodeView: NodeView): Color {
    if (nodeView.isQuote) {
        return markdownTheme.blockQuoteTheme.blockQuoteBackgroundColor // 块引用中的列表
    }
    if (let Some(v) <- markdownTheme.footnoteDefTheme.footnoteDefBackgroundColor) {
        return v // 脚注
    }
    return markdownTheme.globalTheme.backgroundColor
}

/**
 * 设置块结构数学公式对齐方式
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
    var matchData: ?MatchData = regex.find(arrStr)
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
 * 计算图片圆角
 *
 * @param radius 图片圆角
 * @param imageBorderRadius 左上圆角
 * @param imageBorderRadius 右上圆角
 * @param imageBorderRadius 左下圆角
 * @param imageBorderRadius 右下圆角
 * @return (左上圆角, 右上圆角, 左下圆角, 右下圆角)
 */
func imageSpanBorderRadius(radius: Option<Length>, imageBorderRadiusTopLeft: Float64, imageBorderRadiusTopRight: Float64, imageBorderRadiusBottomLeft: Float64, imageBorderRadiusBottomRight: Float64): (Float64, Float64, Float64, Float64) {
    if (let Some(v) <- radius) {
        let r = length2Float(v)
        return (r, r, r, r)
    }
    return (imageBorderRadiusTopLeft, imageBorderRadiusTopRight, imageBorderRadiusBottomLeft, imageBorderRadiusBottomRight)
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
    imageWidthPx: Option<Float64>,
    imageHeightPx: Option<Float64>,
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
 * 图片宽高计算
 *
 * @param length Length
 * @param imageWidthHeight 图片设置的宽高
 * @param componentImageWidth 控件宽度
 * @return Option<Float64> PX格式的Float64
 */
func widthHeightLength2FloatPx(length: Option<Length>, imageWidthHeight: Option<Float64>, componentImageWidth: Float64): Option<Float64> {
    if (let Some(v) <- length) {
        match (v.unitType) {
            case LengthType.vp(w) => return vp2px(w.vp)().value
            case LengthType.px(w) => return w
            case LengthType.percent(w) => return componentImageWidth * w
            case _ => ()
        }
    }
    if (let Some(v) <- imageWidthHeight) {
        return vp2px(v.vp)().value
    }
    return Option<Float64>.None
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
 * 代码块背景颜色
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码块背景颜色（围栏代码、缩进代码、围栏代码列表、单独代码块）
 */
func codeBackgroundColor(markdownTheme: MarkdownTheme, prismTheme: PrismTheme): Color {
    if (let Some(color) <- markdownTheme.codeBlockTheme.codeBlockBackgroundColor) {
        return color
    }
    return prismTheme.background()
}

/**
 * 代码块代码默认文本字体颜色 -- 代码高亮
 *
 * @param item PrismNodesParseResUI
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 文本字体颜色
 */
func codeTextColor(item: PrismNodesParseResUI, markdownTheme: MarkdownTheme): Color {
    let color: ?Color = item.getColor()
    if (let Some(v) <- color) {
        return v
    }
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockTextFontColor) {
        return v
    }
    return markdownTheme.prismTheme.textColor()
}

/**
 * 代码块代码默认文本字体颜色
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 文本字体颜色
 */
func indentedCodeTextColor(markdownTheme: MarkdownTheme): Color {
    if (let Some(color) <- markdownTheme.codeBlockTheme.codeBlockTextFontColor) {
        return color
    }
    return markdownTheme.prismTheme.textColor()
}

/**
 * 代码块代码行号文本颜色
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 行号文本颜色
 */
func codeLineNumberTextColor(markdownTheme: MarkdownTheme): Color {
    if (let Some(color) <- markdownTheme.codeBlockTheme.codeBlockLineNumberTextFontColor) {
        return color
    }
    if (let Some(color) <- markdownTheme.codeBlockTheme.codeBlockTextFontColor) {
        return color
    }
    return markdownTheme.prismTheme.textColor()
}

/**
 * 代码块代码行号文本尺寸
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 行号文本尺寸
 */
func codeLineNumberTextSize(markdownTheme: MarkdownTheme): Float64 {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockLineNumberTextFontSize) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontSize
}

/**
 * 代码块代码行号文本字体样式
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 行号文本字体样式
 */
func codeLineNumberTextFontStyle(markdownTheme: MarkdownTheme): FontStyle {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockLineNumberTextFontStyle) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontStyle
}

/**
 * 代码块代码行号文本字体粗细
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 行号文本字体粗细
 */
func codeLineNumberTextFontWeight(markdownTheme: MarkdownTheme): FontWeight {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockLineNumberTextFontWeight) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontWeight
}

/**
 * 代码块代码行号文本字体
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 行号文本字体
 */
func codeLineNumberTextFontFamily(markdownTheme: MarkdownTheme): String {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockLineNumberTextFontFamily) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontFamily
}

/**
 * 代码块代码行号文本行高
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 行号文本行高
 */
func codeLineNumberTextLineHeight(markdownTheme: MarkdownTheme): Float64 {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockLineNumberTextLineHeight) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextLineHeight
}

/**
 * 代码块分割线颜色
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 行号文本颜色
 */
func codeDividerColor(markdownTheme: MarkdownTheme): Color {
    if (let Some(color) <- markdownTheme.codeBlockTheme.codeBlockDividerColor) {
        return color
    }
    if (let Some(color) <- markdownTheme.codeBlockTheme.codeBlockTextFontColor) {
        return color
    }
    return markdownTheme.prismTheme.textColor()
}

/**
 * 代码块代码类型文本颜色
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码类型文本颜色
 */
func codeTypeTextFontColor(markdownTheme: MarkdownTheme): Color {
    if (let Some(color) <- markdownTheme.codeBlockTheme.codeBlockTypeTextFontColor) {
        return color
    }
    if (let Some(color) <- markdownTheme.codeBlockTheme.codeBlockTextFontColor) {
        return color
    }
    return markdownTheme.prismTheme.textColor()
}

/**
 * 代码块代码类型文本尺寸
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码类型文本尺寸
 */
func codeTypeTextFontSize(markdownTheme: MarkdownTheme): Float64 {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockTypeTextFontSize) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontSize
}

/**
 * 代码块代码类型文本字体样式
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码类型文本字体样式
 */
func codeTypeTextFontStyle(markdownTheme: MarkdownTheme): FontStyle {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockTypeTextFontStyle) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontStyle
}

/**
 * 代码块代码类型文本字体粗细
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码类型文本字体粗细
 */
func codeTypeTextFontWeight(markdownTheme: MarkdownTheme): FontWeight {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockTypeTextFontWeight) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontWeight
}

/**
 * 代码块代码类型文本字体
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码类型文本字体
 */
func codeTypeTextFontFamily(markdownTheme: MarkdownTheme): String {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockTypeTextFontFamily) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontFamily
}

/**
 * 代码块代码类型文本行高
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码类型文本行高
 */
func codeTypeTextLineHeight(markdownTheme: MarkdownTheme): Float64 {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockTypeTextLineHeight) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextLineHeight
}

/**
 * 代码块代码复制文本颜色
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码复制文本颜色
 */
func codeCopyTextFontColor(markdownTheme: MarkdownTheme): Color {
    if (let Some(color) <- markdownTheme.codeBlockTheme.codeBlockCopyTextFontColor) {
        return color
    }
    if (let Some(color) <- markdownTheme.codeBlockTheme.codeBlockTextFontColor) {
        return color
    }
    return markdownTheme.prismTheme.textColor()
}

/**
 * 代码块代码复制文本尺寸
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码复制文本尺寸
 */
func codeCopyTextFontSize(markdownTheme: MarkdownTheme): Float64 {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockCopyTextFontSize) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontSize
}

/**
 * 代码块代码复制文本字体样式
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码复制文本字体样式
 */
func codeCopyTextFontStyle(markdownTheme: MarkdownTheme): FontStyle {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockCopyTextFontStyle) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontStyle
}

/**
 * 代码块代码复制文本字体粗细
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码复制文本字体粗细
 */
func codeCopyTextFontWeight(markdownTheme: MarkdownTheme): FontWeight {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockCopyTextFontWeight) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontWeight
}

/**
 * 代码块代码复制文本字体
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码复制文本字体
 */
func codeCopyTextFontFamily(markdownTheme: MarkdownTheme): String {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockCopyTextFontFamily) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontFamily
}

/**
 * 代码块代码复制文本行高
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码复制文本行高
 */
func codeCopyTextLineHeight(markdownTheme: MarkdownTheme): Float64 {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockCopyTextLineHeight) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextLineHeight
}

/**
 * 代码块代码全屏文本颜色
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码全屏文本颜色
 */
func codeFullScreenTextFontColor(markdownTheme: MarkdownTheme): Color {
    if (let Some(color) <- markdownTheme.codeBlockTheme.codeBlockFullScreenTextFontColor) {
        return color
    }
    if (let Some(color) <- markdownTheme.codeBlockTheme.codeBlockTextFontColor) {
        return color
    }
    return markdownTheme.prismTheme.textColor()
}

/**
 * 代码块代码全屏文本尺寸
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码全屏文本尺寸
 */
func codeFullScreenTextFontSize(markdownTheme: MarkdownTheme): Float64 {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockFullScreenTextFontSize) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontSize
}

/**
 * 代码块代码全屏文本字体样式
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码全屏文本字体样式
 */
func codeFullScreenTextFontStyle(markdownTheme: MarkdownTheme): FontStyle {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockFullScreenTextFontStyle) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontStyle
}

/**
 * 代码块代码全屏文本字体粗细
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码全屏文本字体粗细
 */
func codeFullScreenTextFontWeight(markdownTheme: MarkdownTheme): FontWeight {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockFullScreenTextFontWeight) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontWeight
}

/**
 * 代码块代码全屏文本字体
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码全屏文本字体
 */
func codeFullScreenTextFontFamily(markdownTheme: MarkdownTheme): String {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockFullScreenTextFontFamily) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextFontFamily
}

/**
 * 代码块代码全屏文本行高
 *
 * @param markdownTheme markdown基础样式
 * @param prismTheme 代码高亮样式
 * @return 代码全屏文本行高
 */
func codeFullScreenTextLineHeight(markdownTheme: MarkdownTheme): Float64 {
    if (let Some(v) <- markdownTheme.codeBlockTheme.codeBlockFullScreenTextLineHeight) {
        return v
    }
    return markdownTheme.codeBlockTheme.codeBlockTextLineHeight
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
        return markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockListTitleSelectTextColor
    } else {
        return markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockListTitleUnselectTextColor
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
func listCodeBackgroundColor(idxSelect: Int64, idx: Int64, markdownConfiguration: MarkdownConfiguration): Color {
    if (idxSelect == idx) {
        return markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockListTitleSelectBackgroundColor
    } else {
        return markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockListTitleUnselectBackgroundColor
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
 * 设置代码类型文本颜色
 *
 * @param markdownTheme MarkdownTheme
 * @param prismTheme PrismTheme
 * @return 代码类型文本颜色
 */
func indentedCodeodeBlockTypeTextColor(markdownTheme: MarkdownTheme, prismTheme: PrismTheme): Color {
    if (markdownTheme.codeBlockTheme.codeBlockTypeTextFontColor.isSome()) {
        return markdownTheme.codeBlockTheme.codeBlockTypeTextFontColor()
    }
    if (markdownTheme.codeBlockTheme.codeBlockTextFontColor.isSome()) {
        return markdownTheme.codeBlockTheme.codeBlockTextFontColor()
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
