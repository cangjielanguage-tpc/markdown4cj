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
let COLOR_FFF5F2F0: Color = Color(0xFFF5F2F0)
let COLOR_FFE0E0E0: Color = Color(0xFFE0E0E0)
let COLOR_33000000: Color = Color(0x33000000)
let COLOR_1A000000: Color = Color(0x1A000000)
let COLOR_80000000: Color = Color(0x80000000)
let COLOR_FF1E1E1E: Color = Color(0xFF1E1E1E)
let COLOR_FF2D2D2D: Color = Color(0xFF2D2D2D)
let COLOR_FF404040: Color = Color(0xFF404040)
let COLOR_FF252526: Color = Color(0xFF252526)
let COLOR_FF4A90E2: Color = Color(0xFF4A90E2)
let COLOR_FF808080: Color = Color(0xFF808080)
let COLOR_60000000: Color = Color(0x60000000)
let COLOR_FFA0A0A0: Color = Color(0xFFA0A0A0)
let COLOR_40000000: Color = Color(0x40000000)
let COLOR_FFFFF59D: Color = Color(0xFFFFF59D)
let COLOR_FF6E6000: Color = Color(0xFF6E6000)

let SECONDS_PER_HOUR: Int64 = 3600
let SECONDS_PER_MINUTE: Int64 = 60

/**
 * 判断图片链接是否为本地rawfile相对路径
 * ./开头：相对md文件所在目录
 * ../开头：相对md文件所在目录的上级目录
 *
 * @param url 图片链接
 * @return 是否为本地相对路径
 */
func isRawFileImageUrl(url: String): Bool {
    return url.startsWith("./") || url.startsWith("../")
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
 * 点击事件
 *
 * @param markdownConfiguration MarkdownConfiguration
 * @param nodeView NodeView
 * @param tocListOnClick toc点击事件
 * @param footnoteCallback 脚注点击事件
 */
func spanOnClick(markdownConfiguration: MarkdownConfiguration, nodeView: NodeView, tocListOnClick: ?(Int64) -> Unit, footnoteCallback: (String) -> Unit): Unit {
    if (nodeView.footnoteID.isSome()) {
        footnoteCallback(nodeView.footnoteID.getOrThrow()) // 脚注
        return
    }
    if (nodeView.headLinkIndex.isSome() && tocListOnClick.isSome()) {
        tocListOnClick.getOrThrow()(nodeView.headLinkIndex.getOrThrow()) // TOC/标题ID
        return
    }
    if (markdownConfiguration.linkCallback.isSome() && nodeView.linkUrl.isSome()) {
        markdownConfiguration.linkCallback.getOrThrow()(nodeView.linkUrl.getOrThrow()) // 链接
        return
    }
}

/**
 * 设置文本字体族
 * 参考 markdown_list_component.cj 的 textColor 模式：接收原始值，不持有主题引用
 * 由调用方在 @Builder 修饰链内直接访问 @Publish 叶子属性传入
 *
 * @param nodeView NodeView
 * @param subFamily 下标文本字体
 * @param supFamily 上标文本字体
 * @param codeFamily 内联代码文本字体
 * @param boldFamily 加粗文本字体
 * @param italicFamily 斜体文本字体
 * @param strikeFamily 删除线文本字体
 * @param highlightFamily 高亮文本字体
 * @param underlineFamily 下划线文本字体
 * @param linkFamily 链接文本字体
 * @param footnoteFamily 脚注引用文本字体
 * @param h1 一级标题文本字体
 * @param h2 二级标题文本字体
 * @param h3 三级标题文本字体
 * @param h4 四级标题文本字体
 * @param h5 五级标题文本字体
 * @param h6 六级标题文本字体
 * @param tableTitle 表格标题文本字体
 * @param tableContent 表格内容文本字体
 * @param paragraph 段落文本字体
 * @return 文本字体族
 */
func spanFontFamily(
    nodeView: NodeView,
    subFamily: ?String, supFamily: ?String, codeFamily: ?String,
    boldFamily: ?String, italicFamily: ?String, strikeFamily: ?String,
    highlightFamily: ?String, underlineFamily: ?String, linkFamily: ?String,
    footnoteFamily: ?String,
    h1: String, h2: String, h3: String, h4: String, h5: String, h6: String,
    tableTitle: String, tableContent: String, paragraph: String
): String {
    if (nodeView.isSubNode && subFamily.isSome()) {
        return subFamily() // 下标
    }
    if (nodeView.isSupNode && supFamily.isSome()) {
        return supFamily() // 上标
    }
    if (nodeView.isInLineCode && codeFamily.isSome()) {
        return codeFamily() // 内联代码
    }
    if (nodeView.isStrongEmphasis && boldFamily.isSome()) {
        return boldFamily() // 加粗
    }
    if (nodeView.isEmphasis && italicFamily.isSome()) {
        return italicFamily() // 斜体
    }
    if (nodeView.isStrikethrough && strikeFamily.isSome()) {
        return strikeFamily() // 删除线
    }
    if (nodeView.isHighlight && highlightFamily.isSome()) {
        return highlightFamily() // 高亮
    }
    if (nodeView.isUnderlineNode && underlineFamily.isSome()) {
        return underlineFamily() // 下划线
    }
    if (nodeView.isLink && linkFamily.isSome()) {
        return linkFamily() // 链接
    }
    if (nodeView.isFootnote && footnoteFamily.isSome()) {
        return footnoteFamily() // 脚注引用
    }
    if (nodeView.isHeading) {
        return match (nodeView.headingLevel) {
            case 1 => h1 // 一级标题
            case 2 => h2 // 二级标题
            case 3 => h3 // 三级标题
            case 4 => h4 // 四级标题
            case 5 => h5 // 五级标题
            case 6 => h6 // 六级标题
            case _ => h6 // 其他
        }
    }
    if (nodeView.isTable) {
        if (nodeView.isTableHead) {
            return tableTitle // 表格标题
        }
        return tableContent // 表格内容
    }
    return paragraph // 段落
}

/**
 * 设置文本字体大小
 * 参考 markdown_list_component.cj 的 textColor 模式：接收原始值，不持有主题引用
 * 由调用方在 @Builder 修饰链内直接访问 @Publish 叶子属性传入
 *
 * @param nodeView NodeView
 * @param subSize 下标文本尺寸
 * @param supSize 上标文本尺寸
 * @param codeSize 内联代码文本尺寸
 * @param boldSize 加粗文本尺寸
 * @param italicSize 斜体文本尺寸
 * @param strikeSize 删除线文本尺寸
 * @param highlightSize 高亮文本尺寸
 * @param underlineSize 下划线文本尺寸
 * @param linkSize 链接文本尺寸
 * @param footnoteSize 脚注引用文本尺寸
 * @param h1 一级标题文本尺寸
 * @param h2 二级标题文本尺寸
 * @param h3 三级标题文本尺寸
 * @param h4 四级标题文本尺寸
 * @param h5 五级标题文本尺寸
 * @param h6 六级标题文本尺寸
 * @param tableTitle 表格标题文本尺寸
 * @param tableContent 表格内容文本尺寸
 * @param paragraph 段落文本尺寸
 * @return 文本字体大小
 */
func spanFontSize(
    nodeView: NodeView,
    subSize: Float64, supSize: Float64, codeSize: ?Float64,
    boldSize: ?Float64, italicSize: ?Float64, strikeSize: ?Float64,
    highlightSize: ?Float64, underlineSize: ?Float64, linkSize: ?Float64,
    footnoteSize: ?Float64,
    h1: Float64, h2: Float64, h3: Float64, h4: Float64, h5: Float64, h6: Float64,
    tableTitle: Float64, tableContent: Float64, paragraph: Float64
): Float64 {
    if (nodeView.isSubNode) {
        return subSize // 下标
    }
    if (nodeView.isSupNode) {
        return supSize // 上标
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
    if (nodeView.isInLineCode && codeSize.isSome()) {
        return codeSize() // 内联代码
    }
    if (nodeView.isStrongEmphasis && boldSize.isSome()) {
        return boldSize() // 加粗
    }
    if (nodeView.isEmphasis && italicSize.isSome()) {
        return italicSize() // 斜体
    }
    if (nodeView.isStrikethrough && strikeSize.isSome()) {
        return strikeSize() // 删除线
    }
    if (nodeView.isHighlight && highlightSize.isSome()) {
        return highlightSize() // 高亮
    }
    if (nodeView.isUnderlineNode && underlineSize.isSome()) {
        return underlineSize() // 下划线
    }
    if (nodeView.isLink && linkSize.isSome()) {
        return linkSize() // 链接
    }
    if (nodeView.isFootnote && footnoteSize.isSome()) {
        return footnoteSize() // 脚注引用
    }
    if (nodeView.isHeading) {
        return match (nodeView.headingLevel) {
            case 1 => h1 // 一级标题
            case 2 => h2 // 二级标题
            case 3 => h3 // 三级标题
            case 4 => h4 // 四级标题
            case 5 => h5 // 五级标题
            case 6 => h6 // 六级标题
            case _ => h6 // 其他
        }
    }
    if (nodeView.isTable) {
        if (nodeView.isTableHead) {
            return tableTitle // 表格标题
        }
        return tableContent // 表格内容
    }
    return paragraph // 段落
}

/**
 * 设置文本的字体粗细
 * 参考 markdown_list_component.cj 的 textColor 模式：接收原始值，不持有主题引用
 * 由调用方在 @Builder 修饰链内直接访问 @Publish 叶子属性传入
 *
 * @param nodeView NodeView
 * @param isTableFirst 表格第一列是否加粗
 * @param subWeight 下标文本字体粗细
 * @param supWeight 上标文本字体粗细
 * @param codeWeight 内联代码文本字体粗细
 * @param boldWeight 加粗文本字体粗细
 * @param italicWeight 斜体文本字体粗细
 * @param strikeWeight 删除线文本字体粗细
 * @param highlightWeight 高亮文本字体粗细
 * @param underlineWeight 下划线文本字体粗细
 * @param linkWeight 链接文本字体粗细
 * @param footnoteWeight 脚注引用文本字体粗细
 * @param h1 一级标题文本字体粗细
 * @param h2 二级标题文本字体粗细
 * @param h3 三级标题文本字体粗细
 * @param h4 四级标题文本字体粗细
 * @param h5 五级标题文本字体粗细
 * @param h6 六级标题文本字体粗细
 * @param tableTitle 表格标题文本字体粗细
 * @param tableContent 表格内容文本字体粗细
 * @param descTerm 定义列表术语文本字体粗细
 * @param paragraph 段落文本字体粗细
 * @return 文本的字体粗细
 */
func spanFontWeight(
    nodeView: NodeView, isTableFirst: Bool,
    subWeight: ?FontWeight, supWeight: ?FontWeight, codeWeight: ?FontWeight,
    boldWeight: FontWeight, italicWeight: ?FontWeight, strikeWeight: ?FontWeight,
    highlightWeight: ?FontWeight, underlineWeight: ?FontWeight, linkWeight: ?FontWeight,
    footnoteWeight: ?FontWeight,
    h1: FontWeight, h2: FontWeight, h3: FontWeight, h4: FontWeight, h5: FontWeight, h6: FontWeight,
    tableTitle: FontWeight, tableContent: FontWeight, descTerm: FontWeight, paragraph: FontWeight
): FontWeight {
    if (nodeView.isSpanNode) {
        if (let Some(v) <- nodeView.spanNodeWeight) {
            return v // SpanNode
        }
    }
    if (nodeView.isSubNode && subWeight.isSome()) {
        return subWeight() // 下标
    }
    if (nodeView.isSupNode && supWeight.isSome()) {
        return supWeight() // 上标
    }
    if (nodeView.isInLineCode && codeWeight.isSome()) {
        return codeWeight() // 内联代码
    }
    if (nodeView.isStrongEmphasis) {
        return boldWeight // 加粗
    }
    if (nodeView.isEmphasis && italicWeight.isSome()) {
        return italicWeight() // 斜体
    }
    if (nodeView.isStrikethrough && strikeWeight.isSome()) {
        return strikeWeight() // 删除线
    }
    if (nodeView.isHighlight && highlightWeight.isSome()) {
        return highlightWeight() // 高亮
    }
    if (nodeView.isUnderlineNode && underlineWeight.isSome()) {
        return underlineWeight() // 下划线
    }
    if (nodeView.isLink && linkWeight.isSome()) {
        return linkWeight() // 链接
    }
    if (nodeView.isFootnote && footnoteWeight.isSome()) {
        return footnoteWeight() // 脚注引用
    }
    if (nodeView.isHeading) {
        return match (nodeView.headingLevel) {
            case 1 => h1 // 一级标题
            case 2 => h2 // 二级标题
            case 3 => h3 // 三级标题
            case 4 => h4 // 四级标题
            case 5 => h5 // 五级标题
            case 6 => h6 // 六级标题
            case _ => h6 // 其他
        }
    }
    if (nodeView.isTable) {
        if (nodeView.isTableHead || isTableFirst) {
            return tableTitle // 表格标题
        }
        return tableContent // 表格内容
    }
    if (nodeView.isDescTerm) {
        return descTerm // 定义列表术语
    }
    return paragraph // 段落
}

/**
 * 设置文本字体样式
 * 参考 markdown_list_component.cj 的 textColor 模式：接收原始值，不持有主题引用
 * 由调用方在 @Builder 修饰链内直接访问 @Publish 叶子属性传入
 *
 * @param nodeView NodeView
 * @param subStyle 下标文本字体样式
 * @param supStyle 上标文本字体样式
 * @param codeStyle 内联代码文本字体样式
 * @param boldStyle 加粗文本字体样式
 * @param strikeStyle 删除线文本字体样式
 * @param highlightStyle 高亮文本字体样式
 * @param underlineStyle 下划线文本字体样式
 * @param linkStyle 链接文本字体样式
 * @param footnoteStyle 脚注引用文本字体样式
 * @param h1 一级标题文本字体样式
 * @param h2 二级标题文本字体样式
 * @param h3 三级标题文本字体样式
 * @param h4 四级标题文本字体样式
 * @param h5 五级标题文本字体样式
 * @param h6 六级标题文本字体样式
 * @param tableTitle 表格标题文本字体样式
 * @param tableContent 表格内容文本字体样式
 * @param descTerm 定义列表术语文本字体样式
 * @param paragraph 段落文本字体样式
 * @return 文本字体样式
 */
func spanFontStyle(
    nodeView: NodeView,
    subStyle: ?FontStyle, supStyle: ?FontStyle, codeStyle: ?FontStyle,
    boldStyle: ?FontStyle, strikeStyle: ?FontStyle, highlightStyle: ?FontStyle,
    underlineStyle: ?FontStyle, linkStyle: ?FontStyle, footnoteStyle: ?FontStyle,
    h1: FontStyle, h2: FontStyle, h3: FontStyle, h4: FontStyle, h5: FontStyle, h6: FontStyle,
    tableTitle: FontStyle, tableContent: FontStyle, descTerm: FontStyle, paragraph: FontStyle
): FontStyle {
    if (nodeView.isSubNode && subStyle.isSome()) {
        return subStyle() // 下标
    }
    if (nodeView.isSupNode && supStyle.isSome()) {
        return supStyle() // 上标
    }
    if (nodeView.isInLineCode && codeStyle.isSome()) {
        return codeStyle() // 内联代码
    }
    if (nodeView.isStrongEmphasis && boldStyle.isSome()) {
        return boldStyle() // 加粗
    }
    if (nodeView.isEmphasis) {
        return FontStyle.Italic // 斜体
    }
    if (nodeView.isStrikethrough && strikeStyle.isSome()) {
        return strikeStyle() // 删除线
    }
    if (nodeView.isHighlight && highlightStyle.isSome()) {
        return highlightStyle() // 高亮
    }
    if (nodeView.isUnderlineNode && underlineStyle.isSome()) {
        return underlineStyle() // 下划线
    }
    if (nodeView.isLink && linkStyle.isSome()) {
        return linkStyle() // 链接
    }
    if (nodeView.isFootnote && footnoteStyle.isSome()) {
        return footnoteStyle() // 脚注引用
    }
    if (nodeView.isHeading) {
        return match (nodeView.headingLevel) {
            case 1 => h1 // 一级标题
            case 2 => h2 // 二级标题
            case 3 => h3 // 三级标题
            case 4 => h4 // 四级标题
            case 5 => h5 // 五级标题
            case 6 => h6 // 六级标题
            case _ => h6 // 其他
        }
    }
    if (nodeView.isTable) {
        if (nodeView.isTableHead) {
            return tableTitle // 表格标题
        }
        return tableContent // 表格内容
    }
    if (nodeView.isDescTerm) {
        return descTerm // 定义列表术语
    }
    return paragraph // 段落
}

/**
 * 设置文本字体颜色
 * 参考 markdown_list_component.cj 的 textColor 模式：接收原始值，不持有主题引用
 * 由调用方在 @Builder 修饰链内直接访问 @Publish 叶子属性传入
 *
 * @param nodeView NodeView
 * @param subColor 下标文本颜色
 * @param supColor 上标文本颜色
 * @param codeColor 内联代码文本颜色
 * @param boldColor 加粗文本颜色
 * @param italicColor 斜体文本颜色
 * @param strikeColor 删除线文本颜色
 * @param highlightColor 高亮文本颜色
 * @param underlineColor 下划线文本颜色
 * @param linkColor 链接文本颜色
 * @param footnoteColor 脚注引用文本颜色
 * @param h1 一级标题文本颜色
 * @param h2 二级标题文本颜色
 * @param h3 三级标题文本颜色
 * @param h4 四级标题文本颜色
 * @param h5 五级标题文本颜色
 * @param h6 六级标题文本颜色
 * @param tableTitle 表格标题文本颜色
 * @param tableContent 表格内容文本颜色
 * @param paragraph 段落文本颜色
 * @return 文本字体颜色
 */
func spanFontColor(
    nodeView: NodeView,
    subColor: ?Color, supColor: ?Color, codeColor: ?Color,
    boldColor: ?Color, italicColor: ?Color, strikeColor: ?Color,
    highlightColor: ?Color, underlineColor: ?Color, linkColor: Color, footnoteColor: Color,
    h1: Color, h2: Color, h3: Color, h4: Color, h5: Color, h6: Color,
    tableTitle: Color, tableContent: Color, paragraph: Color
): Color {
    if (nodeView.isSubNode && subColor.isSome()) {
        return subColor() // 下标
    }
    if (nodeView.isSupNode && supColor.isSome()) {
        return supColor() // 上标
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
    if (nodeView.isInLineCode && codeColor.isSome()) {
        return codeColor() // 内联代码
    }
    if (nodeView.isStrongEmphasis && boldColor.isSome()) {
        return boldColor() // 加粗
    }
    if (nodeView.isEmphasis && italicColor.isSome()) {
        return italicColor() // 斜体
    }
    if (nodeView.isStrikethrough && strikeColor.isSome()) {
        return strikeColor() // 删除线
    }
    if (nodeView.isHighlight && highlightColor.isSome()) {
        return highlightColor() // 高亮
    }
    if (nodeView.isUnderlineNode && underlineColor.isSome()) {
        return underlineColor() // 下划线
    }
    if (nodeView.isLink) {
        return linkColor // 链接
    }
    if (nodeView.isFootnote) {
        return footnoteColor // 脚注引用
    }
    if (nodeView.isHeading) {
        return match (nodeView.headingLevel) {
            case 1 => h1 // 一级标题
            case 2 => h2 // 二级标题
            case 3 => h3 // 三级标题
            case 4 => h4 // 四级标题
            case 5 => h5 // 五级标题
            case 6 => h6 // 六级标题
            case _ => h6 // 其他
        }
    }
    if (nodeView.isTable) {
        if (nodeView.isTableHead) {
            return tableTitle // 表格标题
        }
        return tableContent // 表格内容
    }
    return paragraph // 段落和其他
}

/**
 * 设置文本字符间距
 * 参考 markdown_list_component.cj 的 textColor 模式：接收原始值，不持有主题引用
 * 由调用方在 @Builder 修饰链内直接访问 @Publish 叶子属性传入
 *
 * @param nodeView NodeView
 * @param subSpacing 下标文本字符间距
 * @param supSpacing 上标文本字符间距
 * @param codeSpacing 内联代码文本字符间距
 * @param boldSpacing 加粗文本字符间距
 * @param italicSpacing 斜体文本字符间距
 * @param strikeSpacing 删除线文本字符间距
 * @param highlightSpacing 高亮文本字符间距
 * @param underlineSpacing 下划线文本字符间距
 * @param linkSpacing 链接文本字符间距
 * @param footnoteSpacing 脚注引用文本字符间距
 * @param h1 一级标题文本字符间距
 * @param h2 二级标题文本字符间距
 * @param h3 三级标题文本字符间距
 * @param h4 四级标题文本字符间距
 * @param h5 五级标题文本字符间距
 * @param h6 六级标题文本字符间距
 * @param tableTitle 表格标题文本字符间距
 * @param tableContent 表格内容文本字符间距
 * @param paragraph 段落文本字符间距
 * @return 文本字符间距
 */
func spanLetterSpacing(
    nodeView: NodeView,
    subSpacing: ?Float64, supSpacing: ?Float64, codeSpacing: ?Float64,
    boldSpacing: ?Float64, italicSpacing: ?Float64, strikeSpacing: ?Float64,
    highlightSpacing: ?Float64, underlineSpacing: ?Float64, linkSpacing: ?Float64,
    footnoteSpacing: ?Float64,
    h1: Float64, h2: Float64, h3: Float64, h4: Float64, h5: Float64, h6: Float64,
    tableTitle: Float64, tableContent: Float64, paragraph: Float64
): Float64 {
    if (nodeView.isSubNode && subSpacing.isSome()) {
        return subSpacing() // 下标
    }
    if (nodeView.isSupNode && supSpacing.isSome()) {
        return supSpacing() // 上标
    }
    if (nodeView.isInLineCode && codeSpacing.isSome()) {
        return codeSpacing() // 内联代码
    }
    if (nodeView.isStrongEmphasis && boldSpacing.isSome()) {
        return boldSpacing() // 加粗
    }
    if (nodeView.isEmphasis && italicSpacing.isSome()) {
        return italicSpacing() // 斜体
    }
    if (nodeView.isStrikethrough && strikeSpacing.isSome()) {
        return strikeSpacing() // 删除线
    }
    if (nodeView.isHighlight && highlightSpacing.isSome()) {
        return highlightSpacing() // 高亮
    }
    if (nodeView.isUnderlineNode && underlineSpacing.isSome()) {
        return underlineSpacing() // 下划线
    }
    if (nodeView.isLink && linkSpacing.isSome()) {
        return linkSpacing() // 链接
    }
    if (nodeView.isFootnote && footnoteSpacing.isSome()) {
        return footnoteSpacing() // 脚注引用
    }
    if (nodeView.isHeading) {
        return match (nodeView.headingLevel) {
            case 1 => h1 // 一级标题
            case 2 => h2 // 二级标题
            case 3 => h3 // 三级标题
            case 4 => h4 // 四级标题
            case 5 => h5 // 五级标题
            case 6 => h6 // 六级标题
            case _ => h6 // 其他
        }
    }
    if (nodeView.isTable) {
        if (nodeView.isTableHead) {
            return tableTitle // 表格标题
        }
        return tableContent // 表格内容
    }
    return paragraph // 段落
}

/**
 * 设置文本装饰线样式及其颜色
 * 参考 markdown_list_component.cj 的 textColor 模式：接收原始值，不持有主题引用
 * 由调用方在 @Builder 修饰链内直接访问 @Publish 叶子属性传入
 * 删除线/下划线的装饰线类型在主题中未定义，沿用旧实现的硬编码值
 *
 * @param nodeView NodeView
 * @param strikeDecColor 删除线装饰颜色
 * @param strikeDecStyle 删除线装饰样式
 * @param underlineDecColor 下划线装饰颜色
 * @param underlineDecStyle 下划线装饰样式
 * @param linkDecType 链接装饰类型
 * @param linkDecColor 链接装饰颜色
 * @param linkDecStyle 链接装饰样式
 * @param footnoteDecType 脚注引用装饰类型
 * @param footnoteDecColor 脚注引用装饰颜色
 * @param footnoteDecStyle 脚注引用装饰样式
 * @return 文本装饰线样式及其颜色
 */
func spanDecoration(
    nodeView: NodeView,
    strikeDecColor: Color, strikeDecStyle: MarkdownTextDecorationStyle,
    underlineDecColor: Color, underlineDecStyle: MarkdownTextDecorationStyle,
    linkDecType: TextDecorationType, linkDecColor: Color, linkDecStyle: MarkdownTextDecorationStyle,
    footnoteDecType: TextDecorationType, footnoteDecColor: Color, footnoteDecStyle: MarkdownTextDecorationStyle
): (TextDecorationType, Color, Int32) {
    if (nodeView.isStrikethrough) {
        return (TextDecorationType.LineThrough, strikeDecColor, strikeDecStyle.toInt32()) // 删除线
    }
    if (nodeView.isUnderlineNode) {
        return (TextDecorationType.Underline, underlineDecColor, underlineDecStyle.toInt32()) // 下划线
    }
    if (nodeView.isLink) {
        return (linkDecType, linkDecColor, linkDecStyle.toInt32()) // 链接
    }
    if (nodeView.isFootnote) {
        return (footnoteDecType, footnoteDecColor, footnoteDecStyle.toInt32()) // 脚注引用
    }
    return (TextDecorationType.None, COLOR_TRANSPARENT, 0) // 其他
}

/**
 * 设置文本背景颜色及圆角
 * 参考 markdown_list_component.cj 的 textColor 模式：接收原始值，不持有主题引用
 * 由调用方在 @Builder 修饰链内直接访问 @Publish 叶子属性传入
 *
 * @param nodeView NodeView
 * @param codeBg 内联代码背景颜色
 * @param codeRtl 内联代码左上圆角
 * @param codeRtr 内联代码右上圆角
 * @param codeRbl 内联代码左下圆角
 * @param codeRbr 内联代码右下圆角
 * @param highlightBg 高亮背景颜色
 * @param highlightRtl 高亮左上圆角
 * @param highlightRtr 高亮右上圆角
 * @param highlightRbl 高亮左下圆角
 * @param highlightRbr 高亮右下圆角
 * @param linkBg 链接背景颜色
 * @param linkRtl 链接左上圆角
 * @param linkRtr 链接右上圆角
 * @param linkRbl 链接左下圆角
 * @param linkRbr 链接右下圆角
 * @param footnoteBg 脚注引用背景颜色
 * @param footnoteRtl 脚注引用左上圆角
 * @param footnoteRtr 脚注引用右上圆角
 * @param footnoteRbl 脚注引用左下圆角
 * @param footnoteRbr 脚注引用右下圆角
 * @return 文本背景颜色及圆角
 */
func spanBackgroundColor(
    nodeView: NodeView,
    codeBg: Color, codeRtl: Float64, codeRtr: Float64, codeRbl: Float64, codeRbr: Float64,
    highlightBg: Color, highlightRtl: Float64, highlightRtr: Float64, highlightRbl: Float64, highlightRbr: Float64,
    linkBg: Color, linkRtl: Float64, linkRtr: Float64, linkRbl: Float64, linkRbr: Float64,
    footnoteBg: Color, footnoteRtl: Float64, footnoteRtr: Float64, footnoteRbl: Float64, footnoteRbr: Float64
): TextBackgroundStyle {
    if (nodeView.isInLineCode) {
        return TextBackgroundStyle(color: codeBg, radiusBorder: BorderRadiuses(topLeft: codeRtl.vp, topRight: codeRtr.vp, bottomLeft: codeRbl.vp, bottomRight: codeRbr.vp)) // 内联代码
    }
    if (nodeView.isHighlight) {
        return TextBackgroundStyle(color: highlightBg, radiusBorder: BorderRadiuses(topLeft: highlightRtl.vp, topRight: highlightRtr.vp, bottomLeft: highlightRbl.vp, bottomRight: highlightRbr.vp)) // 高亮
    }
    if (nodeView.isLink) {
        return TextBackgroundStyle(color: linkBg, radiusBorder: BorderRadiuses(topLeft: linkRtl.vp, topRight: linkRtr.vp, bottomLeft: linkRbl.vp, bottomRight: linkRbr.vp)) // 链接
    }
    if (nodeView.isFootnote) {
        return TextBackgroundStyle(color: footnoteBg, radiusBorder: BorderRadiuses(topLeft: footnoteRtl.vp, topRight: footnoteRtr.vp, bottomLeft: footnoteRbl.vp, bottomRight: footnoteRbr.vp)) // 脚注引用
    }
    return TextBackgroundStyle(color: COLOR_TRANSPARENT, radiusBorder: BorderRadiuses(topLeft: 0.0.vp, topRight: 0.0.vp, bottomLeft: 0.0.vp, bottomRight: 0.0.vp)) // 其他
}

/**
 * 设置文本基线的偏移量
 * 参考 markdown_list_component.cj 的 textColor 模式：接收原始值，不持有主题引用
 * 由调用方在 @Builder 修饰链内直接访问 @Publish 叶子属性传入
 *
 * @param nodeView NodeView
 * @param subOffset 下标基线偏移量
 * @param supOffset 上标基线偏移量
 * @return 文本基线的偏移量
 */
func spanBaselineOffset(nodeView: NodeView, subOffset: Float64, supOffset: Float64): Float64 {
    if (nodeView.isSubNode) {
        return subOffset // 下标
    }
    if (nodeView.isSupNode) {
        return supOffset // 上标
    }
    return 0.0 // 其他
}

/**
 * 设置文本行高
 * 参考 markdown_list_component.cj 的 textColor 模式：接收原始值，不持有主题引用
 * 由调用方在 @Builder 修饰链内直接访问 @Publish 叶子属性传入
 *
 * @param nodeView NodeView
 * @param codeLh 内联代码行高
 * @param boldLh 加粗行高
 * @param italicLh 斜体行高
 * @param strikeLh 删除线行高
 * @param highlightLh 高亮行高
 * @param underlineLh 下划线行高
 * @param linkLh 链接行高
 * @param footnoteLh 脚注引用行高
 * @param h1 一级标题行高
 * @param h2 二级标题行高
 * @param h3 三级标题行高
 * @param h4 四级标题行高
 * @param h5 五级标题行高
 * @param h6 六级标题行高
 * @param tableTitle 表格标题行高
 * @param tableContent 表格内容行高
 * @param paragraph 段落行高
 * @return 文本行高
 */
func spanLineHeight(
    nodeView: NodeView,
    codeLh: ?Float64, boldLh: ?Float64, italicLh: ?Float64, strikeLh: ?Float64,
    highlightLh: ?Float64, underlineLh: ?Float64, linkLh: ?Float64, footnoteLh: ?Float64,
    h1: Float64, h2: Float64, h3: Float64, h4: Float64, h5: Float64, h6: Float64,
    tableTitle: Float64, tableContent: Float64, paragraph: Float64
): Float64 {
    if (nodeView.isInLineCode && codeLh.isSome()) {
        return codeLh() // 内联代码
    }
    if (nodeView.isStrongEmphasis && boldLh.isSome()) {
        return boldLh() // 加粗
    }
    if (nodeView.isEmphasis && italicLh.isSome()) {
        return italicLh() // 斜体
    }
    if (nodeView.isStrikethrough && strikeLh.isSome()) {
        return strikeLh() // 删除线
    }
    if (nodeView.isHighlight && highlightLh.isSome()) {
        return highlightLh() // 高亮
    }
    if (nodeView.isUnderlineNode && underlineLh.isSome()) {
        return underlineLh() // 下划线
    }
    if (nodeView.isLink && linkLh.isSome()) {
        return linkLh() // 链接
    }
    if (nodeView.isFootnote && footnoteLh.isSome()) {
        return footnoteLh() // 脚注引用
    }
    if (nodeView.isHeading) {
        return match (nodeView.headingLevel) {
            case 1 => h1 // 一级标题
            case 2 => h2 // 二级标题
            case 3 => h3 // 三级标题
            case 4 => h4 // 四级标题
            case 5 => h5 // 五级标题
            case 6 => h6 // 六级标题
            case _ => h6 // 其他
        }
    }
    if (nodeView.isTable) {
        if (nodeView.isTableHead) {
            return tableTitle // 表格标题
        }
        return tableContent // 表格内容
    }
    return paragraph // 段落
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
 * 设置有序/无序/任务列表上外边距
 *
 * @param isOrdered 是否是有序列表
 * @param markdownTheme MarkdownTheme
 * @return 上外边距
 */
func listMarginTop(isOrdered: Bool, markdownTheme: MarkdownTheme): Float64 {
    if (isOrdered) {
        return markdownTheme.orderedListTheme.orderedListMarginTop // 有序列表
    }
    return markdownTheme.bulletListTheme.bulletListMarginTop // 无序列表
}

/**
 * 设置有序/无序/任务列表右外边距
 *
 * @param isOrdered 是否是有序列表
 * @param markdownTheme MarkdownTheme
 * @return 右外边距
 */
func listMarginRight(isOrdered: Bool, markdownTheme: MarkdownTheme): Float64 {
    if (isOrdered) {
        return markdownTheme.orderedListTheme.orderedListMarginRight // 有序列表
    }
    return markdownTheme.bulletListTheme.bulletListMarginRight // 无序列表
}

/**
 * 设置有序/无序/任务列表下外边距
 *
 * @param isOrdered 是否是有序列表
 * @param markdownTheme MarkdownTheme
 * @return 下外边距
 */
func listMarginBottom(isOrdered: Bool, markdownTheme: MarkdownTheme): Float64 {
    if (isOrdered) {
        return markdownTheme.orderedListTheme.orderedListMarginBottom// 有序列表
    }
    return markdownTheme.bulletListTheme.bulletListMarginBottom // 无序列表
}

/**
 * 设置有序/无序/任务列表左外边距
 *
 * @param isOrdered 是否是有序列表
 * @param markdownTheme MarkdownTheme
 * @return 左外边距
 */
func listMarginLeft(isOrdered: Bool, markdownTheme: MarkdownTheme): Float64 {
    if (isOrdered) {
        return markdownTheme.orderedListTheme.orderedListMarginLeft // 有序列表
    }
    return markdownTheme.bulletListTheme.bulletListMarginLeft // 无序列表
}

/**
 * 设置有序/无序/任务列表上内边距
 *
 * @param isOrdered 是否是有序列表
 * @param markdownTheme MarkdownTheme
 * @return 上内边距
 */
func listPaddingTop(isOrdered: Bool, markdownTheme: MarkdownTheme): Float64 {
    if (isOrdered) {
        return markdownTheme.orderedListTheme.orderedListPaddingTop // 有序列表
    }
    return markdownTheme.bulletListTheme.bulletListPaddingTop // 无序列表
}

/**
 * 设置有序/无序/任务列表右内边距
 *
 * @param isOrdered 是否是有序列表
 * @param markdownTheme MarkdownTheme
 * @return 右内边距
 */
func listPaddingRight(isOrdered: Bool, markdownTheme: MarkdownTheme): Float64 {
    if (isOrdered) {
        return markdownTheme.orderedListTheme.orderedListPaddingRight // 有序列表
    }
    return markdownTheme.bulletListTheme.bulletListPaddingRight // 无序列表
}

/**
 * 设置有序/无序/任务列表下内边距
 *
 * @param isOrdered 是否是有序列表
 * @param markdownTheme MarkdownTheme
 * @return 下内边距
 */
func listPaddingBottom(isOrdered: Bool, markdownTheme: MarkdownTheme): Float64 {
    if (isOrdered) {
        return markdownTheme.orderedListTheme.orderedListPaddingBottom// 有序列表
    }
    return markdownTheme.bulletListTheme.bulletListPaddingBottom // 无序列表
}

/**
 * 设置有序/无序/任务列表左内边距
 *
 * @param isOrdered 是否是有序列表
 * @param markdownTheme MarkdownTheme
 * @return 左内边距
 */
func listPaddingLeft(isOrdered: Bool, markdownTheme: MarkdownTheme): Float64 {
    if (isOrdered) {
        return markdownTheme.orderedListTheme.orderedListPaddingLeft // 有序列表
    }
    return markdownTheme.bulletListTheme.bulletListPaddingLeft // 无序列表
}

/**
 * 设置有序/无序/任务列表背景颜色
 *
 * @param isOrdered 是否是有序列表
 * @param markdownTheme MarkdownTheme
 * @param nodeView NodeView
 * @return 有序/无序/任务列表背景颜色
 */
func listBackgroundColor(isOrdered: Bool, markdownTheme: MarkdownTheme, nodeView: NodeView): Color {
    if (nodeView.isQuote) {
        return markdownTheme.blockQuoteTheme.blockQuoteBackgroundColor // 块引用中的列表
    }
    if (isOrdered) {
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
 * 设置有序/无序列表子模块中子模块上下间距
 *
 * @param isOrdered 是否是有序列表
 * @param markdownTheme markdown样式
 * @return 列表子模块上下间距
 */
func listChildChildSpacing(isOrdered: Bool, markdownTheme: MarkdownTheme): Int64 {
    if (isOrdered) {
        return markdownTheme.orderedListTheme.orderedListChildChildSpacing
    }
    return markdownTheme.bulletListTheme.bulletListChildChildSpacing
}

/**
 * 有序/无序前缀文本内容
 *
 * @param item NodeView
 * @param listDepth 列表深度
 * @param isBullet 是否是有序列表
 * @param markdownTheme markdown样式
 * @param idx 列表项索引
 * @return 前缀文本内容
 */
func listPrefixStr(item: NodeView, listDepth: Int64, isBullet: Bool, markdownTheme: MarkdownTheme, idx: Int64): String {
    if (isBullet) {
        // 有序列表，序号缺失时兜底为索引+1
        if (item.orderedListNumber > 0) {
            return "${item.orderedListNumber}."
        }
        return "${idx + 1}."
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
func renderTableCellColor(nodeView: NodeView, markdownTheme: MarkdownTheme, rowCount: Int64): Color {
    if (nodeView.isQuote) {
        return markdownTheme.blockQuoteTheme.blockQuoteBackgroundColor // 引用
    }
    if (nodeView.isTableHead) {
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
            let trimmed = v.trimAscii()
            if (trimmed.isEmpty()) {
                return f
            }
            if (trimmed.size > 2 && trimmed.toAsciiLower()[trimmed.size - 2..] == "px") {
                // "100px"按px并换算成vp
                let num = Float64.parse(trimmed[..trimmed.size - 2])
                f = px2vp(num.px).getOrThrow().value.vp
            } else {
                // "100"按vp
                f = Float64.parse(trimmed).vp
            }
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
 * 计算ImageSpan初始宽度
 * 对齐ArkTS: .width(item.imageWidth ?? (componentWidth > 0 ? componentWidth * imageMaximumWidth : undefined))
 *
 * @param imageWidth 节点配置的图片宽度
 * @param componentWidth 组件宽度
 * @param imageMaximumWidth 主题配置的最大宽度比例
 * @return Length 初始宽度
 */
func spanImageInitWidth(imageWidth: Option<Length>, componentWidth: Float64, imageMaximumWidth: Float64): Option<Length> {
    if (let Some(v) <- imageWidth) {
        return Some(v)
    }
    if (componentWidth > 0.0) {
        return Some((componentWidth * imageMaximumWidth).vp)
    }
    return Option<Length>.None
}

/**
 * 计算图片初始高度
 * 如果节点指定了图片高度，使用节点高度；否则使用主题配置的高度
 *
 * @param imageHeight 节点配置的图片高度
 * @param themeHeight 主题配置的图片高度
 * @return Length 初始高度
 */
func spanImageInitHeight(imageHeight: Option<Length>, themeHeight: ?Float64): Option<Length> {
    if (let Some(v) <- imageHeight) {
        return Some(v)
    }
    if (let Some(h) <- themeHeight) {
        if (h > 0.0) {
            return Some(h.vp)
        }
    }
    return Option<Length>.None
}

/**
 * 计算图片单个圆角值
 * 对齐ArkTS: item.imageRadius ?? themeRadius
 *
 * @param imageRadius 节点配置的图片圆角
 * @param themeRadius 主题配置的圆角
 * @return Float64 圆角值
 */
func spanImageRadiusValue(imageRadius: Option<Length>, themeRadius: Float64): Float64 {
    if (let Some(v) <- imageRadius) {
        return length2Float(v)
    }
    return themeRadius
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
 * 图片的约束最大宽度（对齐ArkUI：maxWidth: imageMaxWidth ?? '100%'）
 *
 * @param cellMaxWidth 表格单元格最大宽度（优先级最高） - 单位vp
 * @param themeMaxWidth 主题配置的最大图片宽度（单元格无约束时兜底，对齐ArkUI imageTheme.imageMaxWidth） - 单位vp
 * @return Length 依次取单元格最大宽度、主题最大宽度，均无则返回100%
 */
func imageSpanConstraintMaxWidth(cellMaxWidth: ?Float64, themeMaxWidth: ?Float64): Length {
    if (let Some(w) <- cellMaxWidth) {
        if (w > 0.0) {
            return w.vp
        }
    }
    if (let Some(w) <- themeMaxWidth) {
        if (w > 0.0) {
            return w.vp
        }
    }
    return 100.percent
}

/**
 * 图片最大高度约束（对齐ArkUI constraintSize({maxHeight: imageMaxHeight})）
 * 仓颉constraintSize的maxHeight为非可选Length，主题未设置imageMaxHeight时
 * 返回极大值等效于不约束（与ArkUI undefined行为一致，图片总有显式高度，该值不生效）
 *
 * @param maxHeight 主题图片最大高度 - 单位vp
 * @return 约束高度；未设置时返回极大值（等效不约束）
 */
func imageMaxHeightLength(maxHeight: ?Float64): Length {
    if (let Some(h) <- maxHeight) {
        if (h > 0.0) {
            return h.vp
        }
    }
    return 1000000.0.vp
}

/**
 * 块级图片最终显示宽度（对齐ArkUI .width(item.imageWidth ?? componentWidth * imageMaximumWidth)）
 * 优先级：已计算的显示宽度（px）→ 父容器宽度×imageMaximumWidth（父布局百分比）→ 父布局100%
 *
 * @param displayPx 已计算的显示宽度 - 单位px
 * @param componentVp 控件宽度 - 单位vp
 * @param maximumWidth 图片最大宽度比例
 * @return 宽度Length
 */
func imageBlockDisplayWidth(displayPx: Float64, componentVp: Float64, maximumWidth: Float64): Length {
    if (displayPx > 0.0) {
        return displayPx.px
    }
    if (componentVp > 0.0) {
        return (componentVp * maximumWidth).vp
    }
    return 100.percent
}

/**
 * 用节点缓存的图片原始尺寸重算最终显示宽高（对齐ArkUI recalculateImageDimensions）
 * 增量刷新时图片URL不变→组件重建后onComplete不回调，需用缓存的原始尺寸重新计算
 *
 * @param componentImageWidth 控件最大宽度 - 单位px
 * @param imageNode 图片节点（携带 imageNaturalWidth/Height 缓存）
 * @return [宽度px, 高度px]；无缓存或不可计算时返回空数组
 */
func recalcImageSizeFromCache(
    componentImageWidth: Float64,
    imageNode: NodeView,
    themeWidth: Option<Float64>,
    themeHeight: Option<Float64>,
    markdownTheme: MarkdownTheme
): Array<Float64> {
    if (let Some(naturalWidth) <- imageNode.imageNaturalWidth) {
        if (let Some(naturalHeight) <- imageNode.imageNaturalHeight) {
            if (naturalWidth > 0.0 && naturalHeight > 0.0 && componentImageWidth > 0.0) {
                let res = imageWidthAndHeight(
                    componentImageWidth,
                    naturalWidth,
                    naturalHeight,
                    themeWidth,
                    themeHeight,
                    markdownTheme.imageTheme.imageMaxWidth,
                    markdownTheme.imageTheme.imageMaxHeight,
                    markdownTheme.imageTheme.imageFixedRatioWidth,
                    markdownTheme.imageTheme.imageMaximumWidth
                )
                if (res[0] > 0.0 && res[1] > 0.0) {
                    // imageWidthAndHeight返回元组，转换为数组返回
                    return [res[0], res[1]]
                }
            }
        }
    }
    return Array<Float64>()
}

/**
 * 图片加载完成后把原始尺寸与最终显示宽高写回节点缓存（对齐ArkUI：item.imageNaturalWidth/Height 及最终宽高写回）
 *
 * @param imageNode 图片节点
 * @param naturalWidth 图片原始宽度 - 单位px
 * @param naturalHeight 图片原始高度 - 单位px
 * @param displayWidth 最终显示宽度 - 单位px
 * @param displayHeight 最终显示高度 - 单位px
 */
func cacheImageSizeToNode(
    imageNode: NodeView,
    naturalWidth: Float64,
    naturalHeight: Float64,
    displayWidth: Float64,
    displayHeight: Float64
): Unit {
    imageNode.imageNaturalWidth = Some(naturalWidth)
    imageNode.imageNaturalHeight = Some(naturalHeight)
    imageNode.imageDisplayWidth = Some(displayWidth)
    imageNode.imageDisplayHeight = Some(displayHeight)
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
    if (!(imageResWidth > 0.0) || !(imageResHeight > 0.0)) {
        return (0.0, 0.0)
    }
    let aspectRatio: Float64 = imageResHeight / imageResWidth // 原图宽高比

    // 根据传入的 imageWidthPx/imageHeightPx 组合确定 baseWidth 和 aspectRatioNew
    // 4 个分支仅在这两个变量上有差异，其余计算逻辑完全相同（消除原 4x 重复）
    var baseWidth: Float64 = 0.0
    var aspectRatioNew: Float64 = aspectRatio
    if (imageWidthPx.isSome() && imageHeightPx.isSome()) {
        baseWidth = imageWidthPx()
        aspectRatioNew = if (imageWidthPx() > 0.0) {
            imageHeightPx() / imageWidthPx()
        } else {
            aspectRatio
        }
    } else if (imageWidthPx.isSome()) {
        baseWidth = imageWidthPx()
    } else if (imageHeightPx.isSome()) {
        baseWidth = imageHeightPx() / aspectRatio
    } else {
        baseWidth = imageResWidth
    }

    // 共享的 widthNew / heightNew / imageMaxHeight 约束计算
    var widthNew = if (imageFixedRatioWidth.isSome()) {
        componentImageWidth * imageFixedRatioWidth()
    } else {
        let baseClamped = if (baseWidth < componentImageWidthNew) {
            baseWidth
        } else {
            componentImageWidthNew
        }
        baseClamped * imageMaximumWidth
    }
    widthNew = if (widthNew < componentImageWidthNew) {
        widthNew
    } else {
        componentImageWidthNew
    }
    let heightNew: Float64 = widthNew * aspectRatioNew
    if (imageMaxHeight.isSome()) {
        let imageMaxHeightPX = vp2px(imageMaxHeight().vp)().value
        if (heightNew < imageMaxHeightPX) {
            width = widthNew
            height = heightNew
        } else if (heightNew > 0.0) {
            let aspectRatioHeightNew = imageMaxHeightPX / heightNew
            width = widthNew * aspectRatioHeightNew
            height = imageMaxHeightPX
        } else {
            width = 0.0
            height = 0.0
        }
    } else {
        width = widthNew
        height = heightNew
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
 * 行号数组拼接为多行文本（对齐ArkUI lineArray.join('\n')）
 *
 * @param lineArray 行号数组（存1..N）
 * @return 以\n分隔的行号文本
 */
func joinLineNumbers(lineArray: Array<Int64>): String {
    let sb = StringBuilder()
    for (i in 0..lineArray.size) {
        if (i > 0) {
            sb.append("\n")
        }
        sb.append(lineArray[i].toString())
    }
    return sb.toString()
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
 * 判断字符串是否仅由十六进制字符组成（0-9、a-f，小写）
 *
 * @param s 输入字符串
 * @return true表示全是十六进制字符
 */
func isHexString(s: String): Bool {
    for (b in s.toArray()) {
        let isDigit = b >= 48 && b <= 57 // 0-9
        let isLowerHex = b >= 97 && b <= 102 // a-f
        if (!isDigit && !isLowerHex) {
            return false
        }
    }
    return true
}

/**
 * 将小写十六进制字符串解析为UInt32数值
 *
 * @param s 十六进制字符串（如 "ff0000"）
 * @return 对应数值（非法字符返回None）
 */
func hexStringToUInt32(s: String): ?UInt32 {
    var result: UInt32 = 0
    for (b in s.toArray()) {
        var v: UInt32
        if (b >= 48 && b <= 57) { // 0-9
            v = UInt32(b) - 48
        } else if (b >= 97 && b <= 102) { // a-f
            v = UInt32(b) - 87
        } else {
            return Option<UInt32>.None
        }
        // 移位+或替代乘加：规避仓颉整型乘法运行时溢出检查
        result = (result << 4) | v
    }
    return Some(result)
}

/**
 * 将#RGB扩展为#RRGGBB
 *
 * @param hex 3位十六进制颜色（如 "f00"）
 * @return 6位十六进制颜色（如 "ff0000"）
 */
func expandHex3(hex: String): String {
    let sb = StringBuilder()
    var i: Int64 = 0
    while (i < hex.size) {
        // 仓颉直接迭代 String 得到的是字节值(UInt8)，append 会追加数值的十进制文本；
        // 必须按字节索引切片取单字符子串，保证字符级翻倍
        let ch = hex[i..i + 1]
        sb.append(ch)
        sb.append(ch)
        i++
    }
    return sb.toString()
}

/**
 * HTML类型Span标签color属性转换Color对象
 * 支持格式：颜色名（如 "red"）、#RRGGBB、#AARRGGBB、#RGB、0xARGB、纯十进制数字
 *
 * @param colorString color属性
 * @return Color对象
 */
func colorStringToColor(colorString: String): ?Color {
    let colorStr = colorString.toAsciiLower().trimAscii()
    if (colorStr.size == 0) {
        return Option<Color>.None
    }
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
        // HarmonyOS Color枚举
        case "transparent" => Color(0x00000000)
        case _ => Option<Color>.None
    }
    if (color.isSome()) {
        return color
    }
    // 0xARGB 格式（如 "0xFFFF0000"）
    if (colorStr.startsWith("0x")) {
        let value = hexStringToUInt32(colorStr[2..])
        if (let Some(v) <- value) {
            return Color(v)
        }
        return Option<Color>.None
    }
    // #RRGGBB 或 #AARRGGBB 格式（如 "#FF0000"、"#FFFF0000"）
    if (colorStr.startsWith("#")) {
        let hex = colorStr[1..]
        if (isHexString(hex)) {
            // alpha掩码：编译期直接确定为UInt32字面量，规避UInt32(Int64)运行时转换在仓颉侧抛异常、
            // 被上层try-catch吞掉后颜色回落默认黑色的问题（8位分支Color(v)直用不受影响）
            let alphaMask: UInt32 = 0xFF000000
            if (hex.size == 6) {
                // #RRGGBB 补 FF alpha
                let rgb = hexStringToUInt32(hex)
                if (let Some(v) <- rgb) {
                    return Color(alphaMask | v)
                }
            } else if (hex.size == 8) {
                // #AARRGGBB
                let argb = hexStringToUInt32(hex)
                if (let Some(v) <- argb) {
                    return Color(v)
                }
            } else if (hex.size == 3) {
                // #RGB 扩展为 #RRGGBB
                let rgb = hexStringToUInt32(expandHex3(hex))
                if (let Some(v) <- rgb) {
                    return Color(alphaMask | v)
                }
            }
        }
        return Option<Color>.None
    }
    // 纯数字（如 "123"）按十进制处理
    try {
        let num = UInt32.parse(colorStr)
        return Color(num)
    } catch (_: Exception) {
        // 非纯数字，忽略
    }
    return Option<Color>.None
}
