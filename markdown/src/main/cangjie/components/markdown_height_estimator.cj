package markdown.components

/**
 * 预计算 Markdown 渲染高度
 *
 * 直接调用调用方传入的 Markdown 解析器将文本解析为节点树，然后遍历节点树，
 * 根据每个节点的类型和主题样式中的 margin/padding/lineHeight 计算高度。
 *
 * - 直接使用 commonmark4cj 解析出的节点树（不走正则）
 * - setext 标题、ATX 标题都由解析器统一识别为 Heading 节点
 * - markdownPlugin 由调用方传入，确保与渲染时使用的插件链一致
 * - 所有块类型均计算 margin + padding + borderWidth + 内容高度
 * - BlockAD / CardNode / HtmlBlock 高度依赖外部渲染或不可见，返回 0
 */

/**
 * 预计算 Markdown 渲染高度（基于解析节点树和主题样式的估算）
 *
 * @param content Markdown文本
 * @param config Markdown配置（含主题样式）
 * @param markdownPlugin Markdown解析器实例（需与渲染组件使用的插件链一致）
 * @param componentWidth 控件宽度（vp），<=0 时自动取屏幕宽度（与 MarkdownComponent 初始化一致）
 * @return 估算高度（vp）
 */
public func preMarkwonHeightByNode(content: String, config: MarkdownConfiguration, markdownPlugin: Markdown, componentWidth!: Float64 = -1.0): Float64 {
    // 未显式传入宽度时，使用屏幕宽度（与 MarkdownComponent.aboutToAppear 中 componentWidth 初值一致）
    let outerWidth: Float64 = if (componentWidth > 0.0) {
        componentWidth
    } else {
        let sw: Int32 = getDefaultDisplaySync().width
        px2vp(Float64(sw).px).getOrThrow().value
    }
    let theme: MarkdownTheme = config.markdownTheme
    let global: GlobalTheme = theme.globalTheme
    let blockSpacing: Float64 = Float64(global.markdownBlockSpacing)
    // MarkdownComponent 渲染为带 .margin(blockMarginL/R/T/B) 的 List，其 onSizeChange 报告高度
    // 含外层上下 margin；文本约束宽度也需扣除左右 blockMargin，与 List 内部内容宽度一致
    let actualWidth: Float64 = outerWidth - global.blockMarginLeft - global.blockMarginRight

    let doc: CommonmarkNode = markdownPlugin.toMarkdown(content)
    var totalHeight: Float64 = 0.0
    var first: Bool = true
    var blockIdx: Int64 = 0
    for (block in doc.iterateChildren()) {
        match (block) {
            case _: HtmlBlock =>
                ()
            case _ =>
                let blockHeight = estimateBlockNodeHeight(block, theme, actualWidth, blockSpacing)
                if (!first) {
                    totalHeight += blockSpacing
                }
                first = false
                totalHeight += blockHeight
        }
        blockIdx++
    }
    totalHeight += global.blockMarginTop + global.blockMarginBottom
    return totalHeight
}

/**
 * 估算单个块节点的高度（按节点类型分发）
 *
 * @param node 节点
 * @param theme MarkdownTheme
 * @param componentWidth 控件宽度
 * @param blockSpacing 块间距
 * @return 块高度（vp）
 */
func estimateBlockNodeHeight(node: CommonmarkNode, theme: MarkdownTheme, componentWidth: Float64, blockSpacing: Float64): Float64 {
    match (node) {
        case h: Heading =>
            return calcHeadingHeight(h, theme, componentWidth)
        case p: Paragraph =>
            return estimateParagraphNodeHeight(p, theme, componentWidth)
        case fcb: FencedCodeBlock =>
            return estimateCodeBlockNodeHeight(fcb.getLiteral(), theme, fcb.getInfo(), true)
        case icb: IndentedCodeBlock =>
            return estimateCodeBlockNodeHeight(icb.getLiteral(), theme, "", false)
        case _: ThematicBreak =>
            return estimateDividerHeight(theme)
        case bq: BlockQuote =>
            return estimateBlockquoteNodeHeight(bq, theme, componentWidth, blockSpacing)
        case bl: BulletList =>
            return estimateListNodeHeight(bl, theme, componentWidth, blockSpacing, false)
        case ol: OrderedList =>
            return estimateListNodeHeight(ol, theme, componentWidth, blockSpacing, true)
        case tb: TableBlock =>
            return estimateTableNodeHeight(tb, theme)
        case fb: FootnoteBlock =>
            return estimateFootnoteBlockNodeHeight(fb, theme, componentWidth, blockSpacing)
        case dl: DescList =>
            return estimateDescListNodeHeight(dl, theme, componentWidth, blockSpacing)
        case _: DescTerm =>
            var h: Float64 = 0.0
            for (child in node.iterateChildren()) {
                h += estimateBlockNodeHeight(child, theme, componentWidth, blockSpacing)
            }
            return h
        case _: DescDef =>
            var h: Float64 = 0.0
            for (child in node.iterateChildren()) {
                h += estimateBlockNodeHeight(child, theme, componentWidth, blockSpacing)
            }
            return h
        case lmb: LatexMathBlock =>
            return estimateLatexMathBlockNodeHeight(lmb, theme, componentWidth)
        case clb: FencedCodeBlockListBlock =>
            return estimateCodeListBlockNodeHeight(clb, theme)
        case _: BlockAudio =>
            return estimateAudioBlockNodeHeight(theme)
        case _: BlockVideo =>
            return estimateVideoBlockNodeHeight(theme, componentWidth)
        case _: SlideBlock =>
            return estimateBannerNodeHeight(theme)
        case _: ImageSingleBlock =>
            return estimateImageSingleBlockNodeHeight(theme)
        case _: IgnoreBlockNode =>
            var h: Float64 = 0.0
            for (child in node.iterateChildren()) {
                h += estimateBlockNodeHeight(child, theme, componentWidth, blockSpacing)
            }
            return h
        case _ =>
            // BlockAD / CardNode / HtmlBlock 高度依赖外部渲染或不可见，返回0
            return 0.0
    }
}

func getBlockTopMargin(node: CommonmarkNode, theme: MarkdownTheme): Float64 {
    match (node) {
        case _: Paragraph => return theme.paragraphTheme.paragraphMarginTop
        case h: Heading =>
            match (Int64(h.getLevel())) {
                case 1 => return theme.headingTheme.heading1MarginTop
                case 2 => return theme.headingTheme.heading2MarginTop
                case 3 => return theme.headingTheme.heading3MarginTop
                case 4 => return theme.headingTheme.heading4MarginTop
                case 5 => return theme.headingTheme.heading5MarginTop
                case 6 => return theme.headingTheme.heading6MarginTop
                case _ => return 0.0
            }
        case _: OrderedList => return theme.orderedListTheme.orderedListMarginTop
        case _: BulletList => return theme.bulletListTheme.bulletListMarginTop
        case _: BlockQuote => return theme.blockQuoteTheme.blockQuoteMarginTop
        case _: FencedCodeBlock => return theme.codeBlockTheme.codeBlockMarginTop
        case _: IndentedCodeBlock => return theme.codeBlockTheme.codeBlockMarginTop
        case _: ThematicBreak => return theme.dividerTheme.dividerMarginTop
        case _ => return 0.0
    }
}

func getBlockBottomMargin(node: CommonmarkNode, theme: MarkdownTheme): Float64 {
    match (node) {
        case _: Paragraph => return theme.paragraphTheme.paragraphMarginBottom
        case h: Heading =>
            match (Int64(h.getLevel())) {
                case 1 => return theme.headingTheme.heading1MarginBottom
                case 2 => return theme.headingTheme.heading2MarginBottom
                case 3 => return theme.headingTheme.heading3MarginBottom
                case 4 => return theme.headingTheme.heading4MarginBottom
                case 5 => return theme.headingTheme.heading5MarginBottom
                case 6 => return theme.headingTheme.heading6MarginBottom
                case _ => return 0.0
            }
        case _: OrderedList => return theme.orderedListTheme.orderedListMarginBottom
        case _: BulletList => return theme.bulletListTheme.bulletListMarginBottom
        case _: BlockQuote => return theme.blockQuoteTheme.blockQuoteMarginBottom
        case _: FencedCodeBlock => return theme.codeBlockTheme.codeBlockMarginBottom
        case _: IndentedCodeBlock => return theme.codeBlockTheme.codeBlockMarginBottom
        case _: ThematicBreak => return theme.dividerTheme.dividerMarginBottom
        case _ => return 0.0
    }
}

/**
 * 文本片段（带字体粗细）
 *
 * 用于精确测量含加粗/斜体内联节点的文本高度。每段文本保留对应的 FontWeight，
 * 使测量时能对加粗段使用真实粗细（如 W700），而非统一用基础字重。
 */
struct TextSegment {
    public let text: String
    public let weight: FontWeight
    public let fontSize: Float64
    public let lineHeight: Float64
    public let fontStyle: FontStyle
    public init(text: String, weight: FontWeight, fontSize: Float64, lineHeight: Float64, fontStyle: FontStyle) {
        this.text = text
        this.weight = weight
        this.fontSize = fontSize
        this.lineHeight = lineHeight
        this.fontStyle = fontStyle
    }
}

/**
 * 递归收集节点树中的文本片段（含字体粗细和字号信息）
 *
 * StrongEmphasis（**加粗**）的子节点使用 boldWeight；
 * Emphasis（*斜体*）保持 currentWeight（斜体宽度与常规相近）。
 * FontNode（<font size=N>）的子节点使用其 size 属性作为字号；
 * SpanNode（<span style="font-size:Npx">）同理解析 font-size。
 *
 * @param node 节点
 * @param baseWeight 基础字体粗细（段落/标题/表格单元格的 fontWeight）
 * @param boldWeight 加粗字体粗细（boldTheme.boldTextFontWeight）
 * @param isLineBreak 软换行是否渲染为换行
 * @param baseFontSize 基础字号（段落/标题/表格单元格的 fontSize，FontNode/SpanNode 子节点会覆盖）
 * @return 文本片段列表
 */
func collectInlineSegments(node: CommonmarkNode, baseWeight: FontWeight, boldWeight: FontWeight, isLineBreak: Bool, baseFontSize: Float64, baseLineHeight: Float64, baseFontStyle: FontStyle, theme: MarkdownTheme): ArrayList<TextSegment> {
    let segments = ArrayList<TextSegment>()
    collectSegmentsRecursive(node, baseWeight, boldWeight, isLineBreak, baseFontSize, baseLineHeight, baseFontStyle, theme, segments)
    if (segments.size == 0) {
        segments.add(TextSegment("", baseWeight, baseFontSize, baseLineHeight, baseFontStyle))
    }
    return segments
}

func collectSegmentsRecursive(node: CommonmarkNode, currentWeight: FontWeight, boldWeight: FontWeight, isLineBreak: Bool, currentFontSize: Float64, currentLineHeight: Float64, currentFontStyle: FontStyle, theme: MarkdownTheme, segments: ArrayList<TextSegment>): Unit {
    for (child in node.iterateChildren()) {
        match (child) {
            case t: CommonmarkText =>
                segments.add(TextSegment(t.getLiteral(), currentWeight, currentFontSize, currentLineHeight, currentFontStyle))
            case c: Code =>
                let codeFs = if (let Some(v) <- theme.inlineCodeTheme.inlineCodeTextFontSize) { v } else { currentFontSize }
                let codeLh = if (let Some(v) <- theme.inlineCodeTheme.inlineCodeTextLineHeight) { v } else { currentLineHeight }
                let codeFst = if (let Some(v) <- theme.inlineCodeTheme.inlineCodeTextFontStyle) { v } else { currentFontStyle }
                segments.add(TextSegment(c.getLiteral(), currentWeight, codeFs, codeLh, codeFst))
            case _: SoftLineBreak =>
                segments.add(TextSegment(if (isLineBreak) { "\n" } else { " " }, currentWeight, currentFontSize, currentLineHeight, currentFontStyle))
            case _: HardLineBreak =>
                segments.add(TextSegment("\n", currentWeight, currentFontSize, currentLineHeight, currentFontStyle))
            case _: StrongEmphasis =>
                let boldFs = if (let Some(v) <- theme.boldTheme.boldTextFontSize) { v } else { currentFontSize }
                let boldLh = if (let Some(v) <- theme.boldTheme.boldTextLineHeight) { v } else { currentLineHeight }
                let boldFst = if (let Some(v) <- theme.boldTheme.boldTextFontStyle) { v } else { currentFontStyle }
                collectSegmentsRecursive(child, boldWeight, boldWeight, isLineBreak, boldFs, boldLh, boldFst, theme, segments)
            case _: Emphasis =>
                let italicFs = if (let Some(v) <- theme.italicTheme.italicTextFontSize) { v } else { currentFontSize }
                let italicLh = if (let Some(v) <- theme.italicTheme.italicTextLineHeight) { v } else { currentLineHeight }
                collectSegmentsRecursive(child, currentWeight, boldWeight, isLineBreak, italicFs, italicLh, FontStyle.Italic, theme, segments)
            case _: Strikethrough =>
                let strikeFs = if (let Some(v) <- theme.strikethroughTheme.strikethroughTextFontSize) { v } else { currentFontSize }
                let strikeLh = if (let Some(v) <- theme.strikethroughTheme.strikethroughTextLineHeight) { v } else { currentLineHeight }
                let strikeFst = if (let Some(v) <- theme.strikethroughTheme.strikethroughTextFontStyle) { v } else { currentFontStyle }
                collectSegmentsRecursive(child, currentWeight, boldWeight, isLineBreak, strikeFs, strikeLh, strikeFst, theme, segments)
            case _: HighlightNode =>
                let hlFs = if (let Some(v) <- theme.highlightTheme.highlightTextFontSize) { v } else { currentFontSize }
                let hlLh = if (let Some(v) <- theme.highlightTheme.highlightTextLineHeight) { v } else { currentLineHeight }
                let hlFst = if (let Some(v) <- theme.highlightTheme.highlightTextFontStyle) { v } else { currentFontStyle }
                collectSegmentsRecursive(child, currentWeight, boldWeight, isLineBreak, hlFs, hlLh, hlFst, theme, segments)
            case _: UnderlineNode =>
                let ulFs = if (let Some(v) <- theme.htmlUnderlineTheme.htmlUnderlineTextFontSize) { v } else { currentFontSize }
                let ulLh = if (let Some(v) <- theme.htmlUnderlineTheme.htmlUnderlineTextLineHeight) { v } else { currentLineHeight }
                let ulFst = if (let Some(v) <- theme.htmlUnderlineTheme.htmlUnderlineTextFontStyle) { v } else { currentFontStyle }
                collectSegmentsRecursive(child, currentWeight, boldWeight, isLineBreak, ulFs, ulLh, ulFst, theme, segments)
            case _: CommonmarkLink =>
                let linkFs = if (let Some(v) <- theme.linkTheme.linkTextFontSize) { v } else { currentFontSize }
                let linkLh = if (let Some(v) <- theme.linkTheme.linkTextLineHeight) { v } else { currentLineHeight }
                let linkFst = if (let Some(v) <- theme.linkTheme.linkTextFontStyle) { v } else { currentFontStyle }
                let linkWt = if (let Some(v) <- theme.linkTheme.linkTextFontWeight) { v } else { currentWeight }
                collectSegmentsRecursive(child, linkWt, boldWeight, isLineBreak, linkFs, linkLh, linkFst, theme, segments)
            case _: Footnote =>
                let fnFs = if (let Some(v) <- theme.footnoteRefTheme.footnoteRefTextFontSize) { v } else { currentFontSize }
                let fnLh = if (let Some(v) <- theme.footnoteRefTheme.footnoteRefTextLineHeight) { v } else { currentLineHeight }
                let fnFst = if (let Some(v) <- theme.footnoteRefTheme.footnoteRefTextFontStyle) { v } else { currentFontStyle }
                collectSegmentsRecursive(child, currentWeight, boldWeight, isLineBreak, fnFs, fnLh, fnFst, theme, segments)
            case _: SubNode =>
                let subFst = if (let Some(v) <- theme.subTheme.subTextFontStyle) { v } else { currentFontStyle }
                collectSegmentsRecursive(child, currentWeight, boldWeight, isLineBreak, theme.subTheme.subTextFontSize, currentLineHeight, subFst, theme, segments)
            case _: SupNode =>
                let supFst = if (let Some(v) <- theme.supTheme.supTextFontStyle) { v } else { currentFontStyle }
                collectSegmentsRecursive(child, currentWeight, boldWeight, isLineBreak, theme.supTheme.supTextFontSize, currentLineHeight, supFst, theme, segments)
            case _: FontNode =>
                var fontNodeFontSize: Float64 = currentFontSize
                try {
                    let fontNode: FontNode = (child as FontNode)()
                    let sizeString: ?String = fontNode.getSize()
                    if (sizeString.isSome()) {
                        let sizeInt64: Int64 = Int64.parse(sizeString())
                        fontNodeFontSize = Float64(sizeInt64)
                    }
                } catch (_: Exception) {
                }
                collectSegmentsRecursive(child, currentWeight, boldWeight, isLineBreak, fontNodeFontSize, currentLineHeight, currentFontStyle, theme, segments)
            case _: SpanNode =>
                var spanNodeFontSize: Float64 = currentFontSize
                try {
                    let spanNode: SpanNode = (child as SpanNode)()
                    let style: ?HashMap<String, String> = spanNode.getStyle()
                    if (let Some(v) <- style) {
                        let sizeStr: ?String = v.get("font-size")
                        if (let Some(n) <- sizeStr) {
                            let size: ?Float64 = sizeStringToSize(n)
                            if (let Some(m) <- size) {
                                spanNodeFontSize = m
                            }
                        }
                    }
                } catch (_: Exception) {
                }
                collectSegmentsRecursive(child, currentWeight, boldWeight, isLineBreak, spanNodeFontSize, currentLineHeight, currentFontStyle, theme, segments)
            case _ =>
                collectSegmentsRecursive(child, currentWeight, boldWeight, isLineBreak, currentFontSize, currentLineHeight, currentFontStyle, theme, segments)
        }
    }
}

/**
 * 将 FontWeight 枚举转为数值（用于 == / != 比较）
 *
 * Cangjie 枚举不支持 != 运算符，需转为可比较类型。
 */
func fontWeightValue(w: FontWeight): Int64 {
    match (w) {
        case FontWeight.W100 => 100
        case FontWeight.W200 => 200
        case FontWeight.W300 => 300
        case FontWeight.W400 => 400
        case FontWeight.W500 => 500
        case FontWeight.W600 => 600
        case FontWeight.W700 => 700
        case FontWeight.W800 => 800
        case FontWeight.W900 => 900
        case _ => 400
    }
}

func fontStyleValue(fs: FontStyle): Int64 {
    match (fs) {
        case FontStyle.Normal => 0
        case FontStyle.Italic => 1
        case _ => 0
    }
}

/**
 * 使用系统字体度量（ohos.measure）精确计算文本高度
 *
 * 对每行（\n 分隔）文本：
 * - 单一粗细行：调用 Measure.MeasureTextSize(constraintWidth) 获取精确换行高度
 * - 混合粗细行：逐段调用 Measure.MeasureText 获取宽度，按 componentWidth 计算换行行数
 *
 * 替代原固定系数方案（CJK≈fontSize, ASCII≈0.55×fontSize），使用系统真实字体度量，
 * 消除字符宽度系数误差与加粗宽度低估（原方案对加粗文本统一用 W400 系数 1.0，
 * 实际 W700 宽约 8%），提升含加粗文本的高度估算精度。
 *
 * @param segments 文本片段列表（含粗细信息）
 * @param fontSize 字号
 * @param lineHeight 行高
 * @param componentWidth 控件宽度
 * @param letterSpacing 字符间距
 * @return 内容高度（vp）
 */
func measureTextHeightBySegments(segments: ArrayList<TextSegment>, fontSize: Float64, lineHeight: Float64, componentWidth: Float64, letterSpacing: Float64): Float64 {
    // 无实际文本内容（空段落/空标题/空单元格）不占高度，与渲染端空 Text() 行为一致
    // 任务列表 - [ ] 空内容项的空段落会走到此分支，避免多算一个行高
    var hasText: Bool = false
    for (seg in segments) {
        if (seg.text.size > 0) {
            hasText = true
            break
        }
    }
    if (!hasText) {
        return 0.0
    }
    if (componentWidth <= 0.0) {
        return lineHeight
    }
    // 按 \n 将 segments 拆分为独立行
    let lines = ArrayList<ArrayList<TextSegment>>()
    var currentLine = ArrayList<TextSegment>()
    for (seg in segments) {
        let parts = seg.text.split("\n")
        for (i in 0..parts.size) {
            if (i > 0) {
                lines.add(currentLine)
                currentLine = ArrayList<TextSegment>()
            }
            if (parts[i].size > 0) {
                currentLine.add(TextSegment(parts[i], seg.weight, seg.fontSize, seg.lineHeight, seg.fontStyle))
            }
        }
    }
    lines.add(currentLine)

    var totalHeight: Float64 = 0.0
    for (lineSegs in lines) {
        if (lineSegs.size == 0) {
            totalHeight += lineHeight
            continue
        }
        // 检查是否所有片段粗细、字号和行高均相同（FontWeight 枚举不支持 !=，用 Int64 比较）
        var sameStyle = true
        let firstWeight = lineSegs[0].weight
        let firstWeightValue = fontWeightValue(firstWeight)
        let firstFontSize = lineSegs[0].fontSize
        let firstLineHeight = lineSegs[0].lineHeight
        let firstFontStyle = lineSegs[0].fontStyle
        for (seg in lineSegs) {
            if (fontWeightValue(seg.weight) != firstWeightValue || seg.fontSize != firstFontSize || seg.lineHeight != firstLineHeight || fontStyleValue(seg.fontStyle) != fontStyleValue(firstFontStyle)) {
                sameStyle = false
                break
            }
        }
        if (sameStyle) {
            var lineText = StringBuilder()
            for (seg in lineSegs) {
                lineText.append(seg.text)
            }
            let size = Measure.MeasureTextSize(MeasureOptions(
                textContent: lineText.toString(),
                fontWeight: firstWeight,
                fontSize: Some(firstFontSize.fp),
                lineHeight: Some(firstLineHeight.vp),
                constraintWidth: Some(componentWidth.vp),
                letterSpacing: Some(letterSpacing.vp),
                fontStyle: firstFontStyle
            ))
            let heightVp = px2vp(size.height.px).getOrThrow().value
            let h = if (heightVp > 0.0) { heightVp } else { firstLineHeight }
            totalHeight += h
        } else {
            // 混合粗细/字号/行高：逐段测宽度按 componentWidth 拆行
            // 每行取该行内片段 lineHeight 最大值（与渲染端 Text+Span 行内 max lineHeight 一致）
            var currentLineWidth: Float64 = 0.0
            var currentLineMaxLh: Float64 = 0.0
            var lineCount: Int64 = 0
            for (seg in lineSegs) {
                let widthPx = Measure.MeasureText(MeasureOptions(
                    textContent: seg.text,
                    fontWeight: seg.weight,
                    fontSize: Some(seg.fontSize.fp),
                    letterSpacing: Some(letterSpacing.vp),
                    fontStyle: seg.fontStyle
                ))
                let widthVp = px2vp(widthPx.px).getOrThrow().value
                if (widthVp > componentWidth) {
                    // 用 MeasureTextSize 获取精确高度（原生排版引擎处理 CJK 换行、标点禁则等）
                    // 替代 ceil(width/componentWidth) —— 后者假设每行填满，低估实际行数
                    let segSize = Measure.MeasureTextSize(MeasureOptions(
                        textContent: seg.text,
                        fontWeight: seg.weight,
                        fontSize: Some(seg.fontSize.fp),
                        lineHeight: Some(seg.lineHeight.vp),
                        constraintWidth: Some(componentWidth.vp),
                        letterSpacing: Some(letterSpacing.vp),
                        fontStyle: seg.fontStyle
                    ))
                    let segHeightVp = px2vp(segSize.height.px).getOrThrow().value
                    let ratio = segHeightVp / seg.lineHeight
                    let segLines: Float64 = if (segHeightVp > 0.0) {
                        if (ratio > floor(ratio) + 0.01) { ceil(ratio) } else { floor(ratio) }
                    } else {
                        1.0
                    }
                    if (currentLineWidth > 0.0) {
                        let partialLh = if (seg.lineHeight > currentLineMaxLh) { seg.lineHeight } else { currentLineMaxLh }
                        totalHeight += partialLh
                        lineCount++
                        totalHeight += (segLines - 1.0) * seg.lineHeight
                        lineCount += Int64(segLines - 1.0)
                        currentLineWidth = 0.0
                        currentLineMaxLh = 0.0
                    } else {
                        totalHeight += (segLines - 1.0) * seg.lineHeight
                        lineCount += Int64(segLines - 1.0)
                        currentLineWidth = 1.0
                        currentLineMaxLh = seg.lineHeight
                    }
                    continue
                }
                // 加入当前段会溢出：结算当前行，开新行
                if (currentLineWidth + widthVp > componentWidth && currentLineWidth > 0.0) {
                    totalHeight += currentLineMaxLh
                    lineCount++
                    currentLineWidth = 0.0
                    currentLineMaxLh = 0.0
                }
                currentLineWidth += widthVp
                if (seg.lineHeight > currentLineMaxLh) {
                    currentLineMaxLh = seg.lineHeight
                }
            }
            // 结算最后一行
            if (currentLineWidth > 0.0 || currentLineMaxLh > 0.0) {
                totalHeight += currentLineMaxLh
                lineCount++
            }
        }
    }
    return totalHeight
}

/**
 * 计算标题块高度（含 margin/padding/underline）
 *
 * 标题渲染为 Text 组件，长文本会自动换行。原实现固定取一行 headingNTextLineHeight，
 * 对长标题（如含超长内联代码的标题）严重低估。现按各等级字号/行高/字间距/字重
 * 估算文本换行行数，与 estimateParagraphNodeHeight 一致。
 *
 * @param node Heading节点（含 IdHeading）
 * @param theme MarkdownTheme（含标题主题及内联样式主题）
 * @param componentWidth 控件宽度
 * @return 块高度（vp）
 */
func calcHeadingHeight(node: Heading, theme: MarkdownTheme, componentWidth: Float64): Float64 {
    let ht = theme.headingTheme
    let isLineBreak = theme.globalTheme.isLineBreak
    let boldWeight = theme.boldTheme.boldTextFontWeight
    let level: Int64 = Int64(node.getLevel())
    match (level) {
        case 1 =>
            // 文本约束宽度需扣除一级标题自身左右 margin + padding，与渲染端 Row.margin/padding 后的 Text 可用宽度一致
            let textWidth: Float64 = componentWidth - ht.heading1MarginLeft - ht.heading1MarginRight -
                ht.heading1PaddingLeft - ht.heading1PaddingRight
            let contentHeight = measureTextHeightBySegments(collectInlineSegments(node, ht.heading1TextFontWeight, boldWeight, isLineBreak, ht.heading1TextFontSize, ht.heading1TextLineHeight, ht.heading1TextFontStyle, theme), ht.heading1TextFontSize, ht.heading1TextLineHeight, textWidth, ht.heading1TextLetterSpacing)
            return ht.heading1MarginTop + ht.heading1PaddingTop + contentHeight +
                ht.heading1UnderlineHeight + ht.heading1UnderlineSpacing +
                ht.heading1PaddingBottom + ht.heading1MarginBottom
        case 2 =>
            let textWidth: Float64 = componentWidth - ht.heading2MarginLeft - ht.heading2MarginRight -
                ht.heading2PaddingLeft - ht.heading2PaddingRight
            let contentHeight = measureTextHeightBySegments(collectInlineSegments(node, ht.heading2TextFontWeight, boldWeight, isLineBreak, ht.heading2TextFontSize, ht.heading2TextLineHeight, ht.heading2TextFontStyle, theme), ht.heading2TextFontSize, ht.heading2TextLineHeight, textWidth, ht.heading2TextLetterSpacing)
            return ht.heading2MarginTop + ht.heading2PaddingTop + contentHeight +
                ht.heading2UnderlineHeight + ht.heading2UnderlineSpacing +
                ht.heading2PaddingBottom + ht.heading2MarginBottom
        case 3 =>
            let textWidth: Float64 = componentWidth - ht.heading3MarginLeft - ht.heading3MarginRight -
                ht.heading3PaddingLeft - ht.heading3PaddingRight
            let contentHeight = measureTextHeightBySegments(collectInlineSegments(node, ht.heading3TextFontWeight, boldWeight, isLineBreak, ht.heading3TextFontSize, ht.heading3TextLineHeight, ht.heading3TextFontStyle, theme), ht.heading3TextFontSize, ht.heading3TextLineHeight, textWidth, ht.heading3TextLetterSpacing)
            return ht.heading3MarginTop + ht.heading3PaddingTop + contentHeight +
                ht.heading3PaddingBottom + ht.heading3MarginBottom
        case 4 =>
            let textWidth: Float64 = componentWidth - ht.heading4MarginLeft - ht.heading4MarginRight -
                ht.heading4PaddingLeft - ht.heading4PaddingRight
            let contentHeight = measureTextHeightBySegments(collectInlineSegments(node, ht.heading4TextFontWeight, boldWeight, isLineBreak, ht.heading4TextFontSize, ht.heading4TextLineHeight, ht.heading4TextFontStyle, theme), ht.heading4TextFontSize, ht.heading4TextLineHeight, textWidth, ht.heading4TextLetterSpacing)
            return ht.heading4MarginTop + ht.heading4PaddingTop + contentHeight +
                ht.heading4PaddingBottom + ht.heading4MarginBottom
        case 5 =>
            let textWidth: Float64 = componentWidth - ht.heading5MarginLeft - ht.heading5MarginRight -
                ht.heading5PaddingLeft - ht.heading5PaddingRight
            let contentHeight = measureTextHeightBySegments(collectInlineSegments(node, ht.heading5TextFontWeight, boldWeight, isLineBreak, ht.heading5TextFontSize, ht.heading5TextLineHeight, ht.heading5TextFontStyle, theme), ht.heading5TextFontSize, ht.heading5TextLineHeight, textWidth, ht.heading5TextLetterSpacing)
            return ht.heading5MarginTop + ht.heading5PaddingTop + contentHeight +
                ht.heading5PaddingBottom + ht.heading5MarginBottom
        case 6 =>
            let textWidth: Float64 = componentWidth - ht.heading6MarginLeft - ht.heading6MarginRight -
                ht.heading6PaddingLeft - ht.heading6PaddingRight
            let contentHeight = measureTextHeightBySegments(collectInlineSegments(node, ht.heading6TextFontWeight, boldWeight, isLineBreak, ht.heading6TextFontSize, ht.heading6TextLineHeight, ht.heading6TextFontStyle, theme), ht.heading6TextFontSize, ht.heading6TextLineHeight, textWidth, ht.heading6TextLetterSpacing)
            return ht.heading6MarginTop + ht.heading6PaddingTop + contentHeight +
                ht.heading6PaddingBottom + ht.heading6MarginBottom
        case _ =>
            return 0.0
    }
}

/**
 * 获取 MarkdownComponent 实际渲染宽度（屏幕宽度 - 左右父容器 padding）
 *
 * 调用方应在父容器有 padding 时传入对应值（左右 padding 之和），让预计算宽度
 * 与 MarkdownComponent 实际渲染宽度一致。例如 paragraph_page 中 Column.padding(5.0)
 * 左右共 10 vp，调用方应传 paddingH: 5.0。
 *
 * @param paddingH 父容器左右单边 padding（vp），默认0
 * @return MarkdownComponent 实际宽度（vp）
 */
public func getMarkdownComponentWidth(paddingH!: Float64 = 0.0): Float64 {
    let sw: Int32 = getDefaultDisplaySync().width
    let screenWidthVp: Float64 = px2vp(Float64(sw).px).getOrThrow().value
    return screenWidthVp - paddingH * 2.0
}

/**
 * 估算段落节点高度
 *
 * 使用系统字体度量（ohos.measure）精确计算文本换行高度，支持含加粗/斜体
 * 内联节点的段落。单一粗细行用 MeasureTextSize(constraintWidth) 获取精确
 * 换行高度；混合粗细行逐段 MeasureText 求宽度再按 componentWidth 计算行数。
 *
 * @param p Paragraph节点
 * @param theme MarkdownTheme
 * @param componentWidth 控件宽度
 * @return 块高度（vp）
 */
func estimateParagraphNodeHeight(p: Paragraph, theme: MarkdownTheme, componentWidth: Float64): Float64 {
    let pt: ParagraphTheme = theme.paragraphTheme
    let fontSize: Float64 = pt.paragraphTextFontSize
    let lineHeight: Float64 = pt.paragraphTextLineHeight
    let letterSpacing: Float64 = pt.paragraphTextLetterSpacing
    let segments = collectInlineSegments(p, pt.paragraphTextFontWeight, theme.boldTheme.boldTextFontWeight, theme.globalTheme.isLineBreak, pt.paragraphTextFontSize, pt.paragraphTextLineHeight, pt.paragraphTextFontStyle, theme)
    let textWidth: Float64 = componentWidth - pt.paragraphMarginLeft - pt.paragraphMarginRight -
        pt.paragraphPaddingLeft - pt.paragraphPaddingRight
    let contentHeight: Float64 = measureTextHeightBySegments(segments, fontSize, lineHeight, textWidth, letterSpacing)
    let result: Float64 = pt.paragraphMarginTop + pt.paragraphPaddingTop + contentHeight +
        pt.paragraphPaddingBottom + pt.paragraphMarginBottom
    return result
}

/**
 * 估算代码块按钮栏高度（代码类型文本 + 复制按钮 + 全屏按钮）
 *
 * 渲染端 codeBlockButtonComponent 为 Row(alignItems=Center)，外层 margin:
 * top=8.0, bottom=codeBlockTitleLayoutMarginBottom。内容高度取各子元素最大值：
 * - 代码类型文本（codeTypeTextLineHeight，仅当代码非空时显示）
 * - 复制按钮（codeBlockCopyIconHeight 或 codeCopyTextLineHeight）
 * - 全屏按钮（codeBlockFullScreenIconHeight 或 codeFullScreenTextLineHeight）
 *
 * @param theme MarkdownTheme
 * @return 按钮栏总高度（vp，含 margin）
 */
func estimateCodeButtonBarHeight(theme: MarkdownTheme): Float64 {
    let ct: CodeBlockTheme = theme.codeBlockTheme
    // 代码类型文本行高（始终显示，当 isCodeNone=true）
    var contentHeight: Float64 = codeTypeTextLineHeight(theme)
    // 复制按钮高度
    if (ct.codeBlockCopyButtonIsShow) {
        var copyBtnHeight: Float64 = 0.0
        if (ct.codeBlockCopyIcon.isSome()) {
            copyBtnHeight = ct.codeBlockCopyIconHeight
        }
        if (ct.codeBlockCopyTextIsShow) {
            let h: Float64 = codeCopyTextLineHeight(theme)
            if (h > copyBtnHeight) {
                copyBtnHeight = h
            }
        }
        if (copyBtnHeight > contentHeight) {
            contentHeight = copyBtnHeight
        }
    }
    // 全屏按钮高度
    if (ct.codeBlockFullScreenButtonIsShow) {
        var fsBtnHeight: Float64 = 0.0
        if (ct.codeBlockFullScreenIcon.isSome()) {
            fsBtnHeight = ct.codeBlockFullScreenIconHeight
        }
        if (ct.codeBlockFullScreenTextIsShow) {
            let h: Float64 = codeFullScreenTextLineHeight(theme)
            if (h > fsBtnHeight) {
                fsBtnHeight = h
            }
        }
        if (fsBtnHeight > contentHeight) {
            contentHeight = fsBtnHeight
        }
    }
    return 8.0 + contentHeight + ct.codeBlockTitleLayoutMarginBottom
}

/**
 * 估算代码块节点高度
 *
 * @param literal 代码内容
 * @param theme MarkdownTheme
 * @return 块高度（vp）
 */
func estimateCodeBlockNodeHeight(literal: String, theme: MarkdownTheme, info: String, isFenced: Bool): Float64 {
    let ct: CodeBlockTheme = theme.codeBlockTheme
    var codeTextStr = literal
    if (isFenced && ct.codeBlockIsCodeFormat) {
        let formatConfig = FormatConfig(useTab: ct.codeBlockUseTab, indentWidth: ct.codeBlockIndentWidth)
        try {
            codeTextStr = codeFormat(info, literal, formatConfig)
        } catch (_: Exception) {
            codeTextStr = literal
        }
    }
    let normalized: String = codeTextStr.removeSuffix("\n")
    let codeLines: Array<String> = normalized.split("\n")
    var lines: Int64 = Int64(codeLines.size)
    if (lines < 1) {
        lines = 1
    }
    let lineHeight: Float64 = ct.codeBlockTextLineHeight
    let codeContentHeight: Float64 = Float64(lines) * lineHeight
    let buttonBarHeight: Float64 = if (normalized.trimAscii().size > 0) {
        estimateCodeButtonBarHeight(theme)
    } else {
        0.0
    }
    let total: Float64 = ct.codeBlockMarginTop + ct.codeBlockPaddingTop + ct.codeBlockBorderWidth * 2.0 + buttonBarHeight + codeContentHeight +
        ct.codeBlockPaddingBottom + ct.codeBlockMarginBottom
    return total
}

/**
 * 估算块引用节点高度（递归遍历子块）
 *
 * @param bq BlockQuote节点
 * @param theme MarkdownTheme
 * @param componentWidth 控件宽度
 * @param blockSpacing 块间距（外层，未使用，内部使用 blockQuoteChildSpacing）
 * @return 块高度（vp）
 */
func estimateBlockquoteNodeHeight(bq: BlockQuote, theme: MarkdownTheme, componentWidth: Float64, blockSpacing: Float64): Float64 {
    let bqt: BlockQuoteTheme = theme.blockQuoteTheme
    let innerBlockSpacing: Float64 = Float64(bqt.blockQuoteChildSpacing)
    let innerWidth: Float64 = componentWidth - bqt.blockQuotePaddingLeft - bqt.blockQuotePaddingRight - bqt.blockQuoteLeftBorderWidth
    let children = ArrayList<CommonmarkNode>()
    for (child in bq.iterateChildren()) {
        match (child) {
            case _: HtmlBlock =>
                ()
            case _ =>
                children.add(child)
        }
    }
    var innerHeight: Float64 = 0.0
    let childCount = children.size
    for (i in 0..childCount) {
        let child = children[i]
        var childHeight = estimateBlockNodeHeight(child, theme, innerWidth, innerBlockSpacing)
        if (i == 0) {
            childHeight -= getBlockTopMargin(child, theme)
        }
        if (i == childCount - 1) {
            childHeight -= getBlockBottomMargin(child, theme)
        }
        if (i > 0) {
            innerHeight += innerBlockSpacing
        }
        innerHeight += childHeight
    }
    return bqt.blockQuoteMarginTop + bqt.blockQuotePaddingTop + innerHeight +
        bqt.blockQuotePaddingBottom + bqt.blockQuoteMarginBottom
}

/**
 * 估算列表节点高度（递归处理嵌套列表）
 *
 * 渲染时 MarkdownListComponent 为 List(space: childSpacing)，每个 ListItem 节点渲染为
 * 一行 Row(前缀 + MarkdownListItemComponent)。MarkdownListItemComponent 又是
 * List(space: childChildSpacing)，遍历 ListItem 子节点逐项渲染：Paragraph 直接渲染，
 * BulletList/OrderedList 递归进入 MarkdownListComponent。
 *
 * 因此估算时需对每个 ListItem 递归计算其子节点高度（含嵌套子列表），
 * 行高取前缀高度与内容高度的最大值。原实现仅按顶层条目数 × 行高估算，
 * 无法处理嵌套列表，导致嵌套用例严重低估（如 35 行嵌套用例估算 88 实际 770）。
 *
 * @param node 列表节点（BulletList/OrderedList）
 * @param theme MarkdownTheme
 * @param componentWidth 控件宽度
 * @param blockSpacing 块间距（未使用，列表内部使用 childSpacing/childChildSpacing）
 * @param isOrdered 是否有序列表
 * @return 块高度（vp）
 */
func estimateListNodeHeight(node: CommonmarkNode, theme: MarkdownTheme, componentWidth: Float64, blockSpacing: Float64, isOrdered: Bool): Float64 {
    let orderedTheme: OrderedListTheme = theme.orderedListTheme
    let bulletTheme: BulletListTheme = theme.bulletListTheme
    let childSpacing: Float64 = if (isOrdered) {
        Float64(orderedTheme.orderedListChildSpacing)
    } else {
        Float64(bulletTheme.bulletListChildSpacing)
    }
    let childChildSpacing: Float64 = if (isOrdered) {
        Float64(orderedTheme.orderedListChildChildSpacing)
    } else {
        Float64(bulletTheme.bulletListChildChildSpacing)
    }
    let paragraphLineHeight: Float64 = theme.paragraphTheme.paragraphTextLineHeight
    // 检测是否为任务列表（BulletList 子节点为 TaskListItem）
    // BulletList 子节点要么全是普通 ListItem，要么全是 TaskListItem，检查首个子节点即可
    var isTaskList: Bool = false
    if (!isOrdered) {
        for (child in node.iterateChildren()) {
            isTaskList = child is TaskListItem
            break
        }
    }
    // 前缀高度：无序/任务列表分别使用对应前缀高度；与内容高度取最大值
    // 普通无序列表用符号文本行高，任务列表用复选框高度（与渲染端 Checkbox().height 一致）
    let prefixHeight: Float64 = if (isOrdered) {
        orderedTheme.orderedListMarkerTextLineHeight
    } else if (isTaskList) {
        bulletTheme.bulletListCheckboxHeight
    } else {
        bulletTheme.bulletListBulletTextLineHeight
    }
    // 前缀宽度：列表符号/序号文本宽度 + 间距，需从内容宽度中扣除
    // 任务列表前缀为复选框：复选框宽度 + 复选框与内容间距（与渲染端 Checkbox 的 width + right margin 一致）
    let prefixWidth: Float64 = if (isOrdered) {
        let markerWidthPx = Measure.MeasureText(MeasureOptions(
            textContent: "1.",
            fontSize: Some(orderedTheme.orderedListMarkerTextFontSize.fp),
            fontWeight: orderedTheme.orderedListMarkerTextFontWeight,
            fontStyle: orderedTheme.orderedListMarkerTextFontStyle
        ))
        px2vp(markerWidthPx.px).getOrThrow().value + orderedTheme.orderedListMarkerSpacing
    } else if (isTaskList) {
        bulletTheme.bulletListCheckboxWidth + bulletTheme.bulletListCheckboxSpacing
    } else {
        let bulletWidthPx = Measure.MeasureText(MeasureOptions(
            textContent: "\u{25CF}",
            fontSize: Some(bulletTheme.bulletListBulletTextFontSize.fp),
            fontWeight: bulletTheme.bulletListBulletTextFontWeight,
            fontStyle: bulletTheme.bulletListBulletTextFontStyle
        ))
        px2vp(bulletWidthPx.px).getOrThrow().value + bulletTheme.bulletListBulletSpacing
    }
    // 内容宽度 = 控件宽度 - 前缀宽度 - 列表左右内边距
    let listPaddingH: Float64 = if (isOrdered) {
        orderedTheme.orderedListPaddingLeft + orderedTheme.orderedListPaddingRight
    } else {
        bulletTheme.bulletListPaddingLeft + bulletTheme.bulletListPaddingRight
    }
    let contentWidth: Float64 = componentWidth - prefixWidth - listPaddingH
    let effectiveContentWidth: Float64 = if (contentWidth > 1.0) { contentWidth } else { 1.0 }
    let marginTop: Float64 = if (isOrdered) {
        orderedTheme.orderedListMarginTop
    } else {
        bulletTheme.bulletListMarginTop
    }
    let marginBottom: Float64 = if (isOrdered) {
        orderedTheme.orderedListMarginBottom
    } else {
        bulletTheme.bulletListMarginBottom
    }
    let paddingTop: Float64 = if (isOrdered) {
        orderedTheme.orderedListPaddingTop
    } else {
        bulletTheme.bulletListPaddingTop
    }
    let paddingBottom: Float64 = if (isOrdered) {
        orderedTheme.orderedListPaddingBottom
    } else {
        bulletTheme.bulletListPaddingBottom
    }

    var innerHeight: Float64 = 0.0
    var first: Bool = true
    var itemIndex: Int64 = 0
    for (child in node.iterateChildren()) {
        if (child is CommonmarkListItem) {
            if (!first) {
                innerHeight += childSpacing
            }
            first = false
            let itemHeight = estimateListItemContentHeight(child, theme, effectiveContentWidth, childChildSpacing, paragraphLineHeight, prefixHeight)
            innerHeight += itemHeight
            itemIndex++
        }
    }
    let listTotal = marginTop + paddingTop + innerHeight + paddingBottom + marginBottom
    return listTotal
}

/**
 * 估算单个列表项的内容高度
 *
 * 列表项渲染为 Row(前缀 + MarkdownListItemComponent)，行高取前缀高度与内容高度最大值。
 * MarkdownListItemComponent 为 List(space: childChildSpacing)，遍历 ListItem 子节点逐项渲染：
 * - Paragraph 子节点 → 段落高度（含其 margin/padding，与渲染一致）
 * - BulletList/OrderedList 子节点 → 递归 estimateListNodeHeight
 * - 其他块子节点 → estimateBlockNodeHeight
 * 内容为空时至少计入前缀高度（避免空列表项高度为 0）。
 *
 * @param item ListItem节点
 * @param theme MarkdownTheme
 * @param componentWidth 控件宽度
 * @param childChildSpacing 列表项子模块上下间距
 * @param paragraphLineHeight 段落文本行高（未使用，保留以明确语义）
 * @param prefixHeight 前缀（列表符号/序号）高度
 * @return 列表项高度（vp）
 */
func estimateListItemContentHeight(item: CommonmarkNode, theme: MarkdownTheme, componentWidth: Float64, childChildSpacing: Float64, paragraphLineHeight: Float64, prefixHeight: Float64): Float64 {
    var contentHeight: Float64 = 0.0
    let children = ArrayList<CommonmarkNode>()
    for (child in item.iterateChildren()) {
        children.add(child)
    }
    let childCount = children.size
    for (i in 0..childCount) {
        let child = children[i]
        var childHeight = estimateBlockNodeHeight(child, theme, componentWidth, childChildSpacing)
        if (i == 0) {
            childHeight -= getBlockTopMargin(child, theme)
        }
        if (i == childCount - 1) {
            childHeight -= getBlockBottomMargin(child, theme)
        }
        if (i > 0) {
            contentHeight += childChildSpacing
        }
        contentHeight += childHeight
    }
    let rowHeight: Float64 = if (contentHeight > prefixHeight) { contentHeight } else { prefixHeight }
    return rowHeight
}

/**
 * 估算表格节点高度
 *
 * @param tb TableBlock节点
 * @param theme MarkdownTheme
 * @return 块高度（vp）
 */
func estimateTableNodeHeight(tb: TableBlock, theme: MarkdownTheme): Float64 {
    let tt: TableTheme = theme.tableTheme
    let cellPaddingTop: Float64 = tt.tableCellPaddingTop
    let cellPaddingBottom: Float64 = tt.tableCellPaddingBottom
    let cellPaddingLeft: Float64 = tt.tableCellPaddingLeft
    let cellPaddingRight: Float64 = tt.tableCellPaddingRight
    let borderWidth: Float64 = tt.tableBorderWidth
    let cellContentWidth: Float64 = if (tt.tableMaxCellWidth > cellPaddingLeft + cellPaddingRight) {
        tt.tableMaxCellWidth - cellPaddingLeft - cellPaddingRight
    } else {
        1.0
    }
    let titleHeight: Float64 = if (tt.tableHeadIsShow) {
        cellPaddingTop + tt.tableTitleTextLineHeight + cellPaddingBottom + borderWidth
    } else {
        0.0
    }
    var totalRows: Int64 = 0
    var contentHeight: Float64 = 0.0
    for (child in tb.iterateChildren()) {
        match (child) {
            case _: TableHead =>
                for (row in child.iterateChildren()) {
                    if (row is TableRow) {
                        totalRows++
                        contentHeight += estimateTableRowContentHeight(row, tt, true, cellContentWidth, cellPaddingTop, cellPaddingBottom, theme)
                    }
                }
            case _: TableBody =>
                for (row in child.iterateChildren()) {
                    if (row is TableRow) {
                        totalRows++
                        contentHeight += estimateTableRowContentHeight(row, tt, false, cellContentWidth, cellPaddingTop, cellPaddingBottom, theme)
                    }
                }
            case _ => ()
        }
    }
    if (totalRows == 0) {
        totalRows = 1
        contentHeight = tt.tableTitleTextLineHeight + cellPaddingTop + cellPaddingBottom
    }
    let rowBorders: Float64 = if (totalRows > 1) { Float64(totalRows - 1) * borderWidth } else { 0.0 }
    let outerBorderHeight: Float64 = borderWidth * 2.0
    return tt.tableMarginTop + tt.tablePaddingTop + titleHeight + contentHeight + rowBorders + outerBorderHeight +
        tt.tablePaddingBottom + tt.tableMarginBottom
}

func estimateTableRowContentHeight(row: CommonmarkNode, tt: TableTheme, isHeader: Bool, cellContentWidth: Float64, cellPaddingTop: Float64, cellPaddingBottom: Float64, theme: MarkdownTheme): Float64 {
    let isLineBreak = theme.globalTheme.isLineBreak
    let boldWeight = theme.boldTheme.boldTextFontWeight
    let fontSize: Float64 = if (isHeader) { tt.tableTitleTextFontSize } else { tt.tableContentTextFontSize }
    let lineHeight: Float64 = if (isHeader) { tt.tableTitleTextLineHeight } else { tt.tableContentTextLineHeight }
    let fontWeight: FontWeight = if (isHeader) { tt.tableTitleTextFontWeight } else { tt.tableContentTextFontWeight }
    let letterSpacing: Float64 = if (isHeader) { tt.tableTitleTextLetterSpacing } else { tt.tableContentTextLetterSpacing }
    let fontStyle: FontStyle = if (isHeader) { tt.tableTitleTextFontStyle } else { tt.tableContentTextFontStyle }
    var maxLines: Float64 = 1.0
    for (cell in row.iterateChildren()) {
        if (cell is TableCell) {
            let segments = collectInlineSegments(cell, fontWeight, boldWeight, isLineBreak, fontSize, lineHeight, fontStyle, theme)
            let textHeight: Float64 = measureTextHeightBySegments(segments, fontSize, lineHeight, cellContentWidth, letterSpacing)
            let lines: Float64 = textHeight / lineHeight
            if (lines > maxLines) {
                maxLines = lines
            }
        }
    }
    return maxLines * lineHeight + cellPaddingTop + cellPaddingBottom
}

/**
 * 估算分割线块高度
 *
 * @param theme MarkdownTheme
 * @return 块高度（vp）
 */
func estimateDividerHeight(theme: MarkdownTheme): Float64 {
    let dt: DividerTheme = theme.dividerTheme
    let h = dt.dividerMarginTop + dt.dividerPaddingTop + dt.dividerStrokeWidth +
        dt.dividerPaddingBottom + dt.dividerMarginBottom
    return h
}

/**
 * 估算脚注块节点高度
 *
 * FootnoteBlock 内部包含一个 Paragraph 子节点（脚注文本）。
 *
 * @param fb FootnoteBlock节点
 * @param theme MarkdownTheme
 * @param componentWidth 控件宽度
 * @param blockSpacing 块间距（未使用，FootnoteBlock仅单个段落子节点）
 * @return 块高度（vp）
 */
func estimateFootnoteBlockNodeHeight(fb: FootnoteBlock, theme: MarkdownTheme, componentWidth: Float64, blockSpacing: Float64): Float64 {
    let fdt: FootnoteDefTheme = theme.footnoteDefTheme
    var innerHeight: Float64 = 0.0
    var first: Bool = true
    for (child in fb.iterateChildren()) {
        if (!first) {
            innerHeight += blockSpacing
        }
        first = false
        innerHeight += estimateBlockNodeHeight(child, theme, componentWidth, blockSpacing)
    }
    return fdt.footnoteDefMarginTop + fdt.footnoteDefPaddingTop + innerHeight +
        fdt.footnoteDefPaddingBottom + fdt.footnoteDefMarginBottom
}

/**
 * 估算定义列表节点高度
 *
 * DescList 内部包含 DescTerm 和 DescDef 子节点，每个子节点包含一个 Paragraph。
 * DescTerm 与紧随其后的 DescDef 之间使用 definitionListTermToDescriptionSpacing，
 * 连续 DescDef 之间使用 definitionListDescriptionItemSpacing。
 *
 * @param dl DescList节点
 * @param theme MarkdownTheme
 * @param componentWidth 控件宽度
 * @param blockSpacing 块间距（未使用，由 DefinitionListTheme 提供专属间距）
 * @return 块高度（vp）
 */
func estimateDescListNodeHeight(dl: DescList, theme: MarkdownTheme, componentWidth: Float64, blockSpacing: Float64): Float64 {
    let dlt: DefinitionListTheme = theme.definitionListTheme
    let termSpacing: Float64 = dlt.definitionListTermToDescriptionSpacing
    let defSpacing: Float64 = dlt.definitionListDescriptionItemSpacing
    var innerHeight: Float64 = 0.0
    var prevIsTerm: Bool = false
    var prevIsDef: Bool = false
    var first: Bool = true
    for (child in dl.iterateChildren()) {
        let childHeight: Float64 = estimateBlockNodeHeight(child, theme, componentWidth, blockSpacing)
        if (!first) {
            if (child is DescTerm) {
                innerHeight += defSpacing
            } else if (child is DescDef) {
                if (prevIsTerm) {
                    innerHeight += termSpacing
                } else {
                    innerHeight += defSpacing
                }
            } else {
                innerHeight += termSpacing
            }
        }
        first = false
        prevIsTerm = child is DescTerm
        prevIsDef = child is DescDef
        innerHeight += childHeight
    }
    return dlt.definitionListMarginTop + dlt.definitionListPaddingTop + innerHeight +
        dlt.definitionListPaddingBottom + dlt.definitionListMarginBottom
}

/**
 * 估算块级数学公式节点高度
 *
 * 渲染端有两种状态：
 * 1. isLatexMathBlockClose=false 且 latexMathDefaultText=true：直接显示原始 latex 文本（Text 组件）
 * 2. isLatexMathBlockClose=true：使用 MarkdownLatexMathBlockComponent，初始也显示文本，
 *    解析完成后替换为图片（图片高度运行时确定，无法预计算）
 *
 * 两种状态下初始显示的都是文本，因此按文本高度估算。
 * 原实现用 lineCount × fontSize 估算，未考虑实际行高（通常为 fontSize × 1.2+）
 * 和文本换行。现改用 Measure.MeasureTextSize 获取精确高度。
 *
 * @param lmb LatexMathBlock节点
 * @param theme MarkdownTheme
 * @param componentWidth 控件宽度
 * @return 块高度（vp）
 */
func estimateLatexMathBlockNodeHeight(lmb: LatexMathBlock, theme: MarkdownTheme, componentWidth: Float64): Float64 {
    let lmt: LatexMathTheme = theme.latexMathTheme
    if (!lmt.latexMathDefaultText) {
        return 0.0
    }
    let latex: String = lmb.latex
    // 约束宽度 = 控件宽度 - 左右内边距 - 左右外边距
    let constraintWidth: Float64 = componentWidth - lmt.latexMathPaddingLeft - lmt.latexMathPaddingRight -
        lmt.latexMathMarginLeft - lmt.latexMathMarginRight
    let effectiveConstraint: Float64 = if (constraintWidth > 0.0) { constraintWidth } else { componentWidth }
    let size = Measure.MeasureTextSize(MeasureOptions(
        textContent: latex,
        fontSize: Some(lmt.latexMathDefaultTextFontSize.fp),
        fontWeight: lmt.latexMathDefaultTextFontWeight,
        fontStyle: lmt.latexMathDefaultTextFontStyle,
        constraintWidth: Some(effectiveConstraint.vp)
    ))
    let contentHeight: Float64 = px2vp(size.height.px).getOrThrow().value
    let effectiveContentHeight: Float64 = if (contentHeight > 0.0) { contentHeight } else {
        // 回退：按行数 × fontSize 估算
        let lines: Array<String> = latex.split("\n")
        var lineCount: Int64 = Int64(lines.size)
        if (lineCount < 1) {
            lineCount = 1
        }
        Float64(lineCount) * lmt.latexMathDefaultTextFontSize
    }
    return lmt.latexMathMarginTop + lmt.latexMathPaddingTop + effectiveContentHeight +
        lmt.latexMathPaddingBottom + lmt.latexMathMarginBottom
}

/**
 * 估算组合代码块节点高度
 *
 * FencedCodeBlockListBlock 是多个 FencedCodeBlock 组合而成的标签页式代码块。
 * 渲染端 MarkdownCodeBlockListComponent 结构为：
 *   Row > Column(margin, padding) {
 *     codeBlockTitleComponent (标签栏, margin(bottom: codeBlockTitleLayoutMarginBottom))
 *     codeBlockComponent: Column(border) {
 *       codeBlockButtonComponent (按钮栏, margin(top:8, bottom: codeBlockTitleLayoutMarginBottom))
 *       Row(行号 + 代码文本)
 *     }
 *   }
 * 内容区高度取所有子代码块中最大者（标签页容器需容纳最大内容）。
 * 注意：组合代码块有自己的标签栏 + 按钮栏，不再复用 estimateCodeBlockNodeHeight
 * （后者包含 margin/padding/border，会导致重复计入）。
 *
 * @param clb FencedCodeBlockListBlock节点
 * @param theme MarkdownTheme
 * @return 块高度（vp）
 */
func estimateCodeListBlockNodeHeight(clb: FencedCodeBlockListBlock, theme: MarkdownTheme): Float64 {
    let ct: CodeBlockTheme = theme.codeBlockTheme
    let lineHeight: Float64 = ct.codeBlockTextLineHeight
    var maxCodeContentHeight: Float64 = 0.0
    var hasNonEmptyCode: Bool = false
    for (child in clb.iterateChildren()) {
        match (child) {
            case fcb: FencedCodeBlock =>
                // 与渲染端一致移除末尾换行
                let normalized: String = fcb.getLiteral().removeSuffix("\n")
                if (normalized.trimAscii().size > 0) {
                    hasNonEmptyCode = true
                }
                let codeLines: Array<String> = normalized.split("\n")
                var lines: Int64 = Int64(codeLines.size)
                if (lines < 1) {
                    lines = 1
                }
                let h: Float64 = Float64(lines) * lineHeight
                if (h > maxCodeContentHeight) {
                    maxCodeContentHeight = h
                }
            case _ => ()
        }
    }
    if (maxCodeContentHeight == 0.0) {
        maxCodeContentHeight = lineHeight
    }
    // 标签栏高度（标题字号近似 + 内边距 top/bottom 各 5）+ 底部 margin
    let tabBarHeight: Float64 = ct.codeBlockListTitleSelectTextSize + 10.0 + ct.codeBlockTitleLayoutMarginBottom
    // 按钮栏高度（仅当代码非空时显示）
    let buttonBarHeight: Float64 = if (hasNonEmptyCode) { estimateCodeButtonBarHeight(theme) } else { 0.0 }
    return ct.codeBlockMarginTop + ct.codeBlockPaddingTop + ct.codeBlockBorderWidth * 2.0 + tabBarHeight + buttonBarHeight + maxCodeContentHeight +
        ct.codeBlockPaddingBottom + ct.codeBlockMarginBottom
}

/**
 * 估算音频块节点高度
 *
 * 渲染端 MarkdownAudioComponent 结构为：
 *   Row(borderWidth, padding, margin, shadow, borderRadius) > Row(10) {
 *     图标(iconWidth × iconHeight) / Blank(占位)
 *     Column(titleToTypeSpacing) { Text(title, maxLines=1) + Text(type, maxLines=1) }
 *     Text(button, width × height, maxLines=1)
 *   }.width(100%)
 *
 * 内容高度 = max(iconHeight, titleTextLineHeight + titleToTypeSpacing + typeTextLineHeight, buttonHeight)
 * 所有文本设 maxLines=1 不会换行，高度固定。
 * shadow 不影响布局高度。
 *
 * @param theme MarkdownTheme
 * @return 块高度（vp）
 */
func estimateAudioBlockNodeHeight(theme: MarkdownTheme): Float64 {
    let at: AudioTheme = theme.audioTheme
    let textColHeight: Float64 = at.audioTitleTextLineHeight + at.audioTitleToTypeSpacing + at.audioTypeTextLineHeight
    let contentHeight: Float64 = if (at.audioIconHeight > textColHeight) {
        if (at.audioIconHeight > at.audioButtonHeight) { at.audioIconHeight } else { at.audioButtonHeight }
    } else {
        if (textColHeight > at.audioButtonHeight) { textColHeight } else { at.audioButtonHeight }
    }
    return at.audioMarginTop + at.audioPaddingTop + at.audioBorderWidth * 2.0 + contentHeight +
        at.audioPaddingBottom + at.audioMarginBottom
}

/**
 * 估算视频块节点高度
 *
 * 渲染端 MarkdownVideoComponent 结构为：
 *   Row(padding, margin) > Column(layoutWeight=1) {
 *     Stack { Image(width=100%, aspectRatio=16:9, borderWidth) + Text(time) }
 *     if (videoBottomLayoutVisible) { Row(margin top) { 发布/下载按钮 } }
 *   }
 *
 * 视频图片宽度撑满父布局（100.percent），按默认 16:9 宽高比估算图片高度。
 * 注意：videoBorderWidth 在 Image 上（非外层容器），border-box 模型下已包含在
 * aspectRatio 计算的高度内，不应额外添加。
 * 若 videoBottomLayoutVisible，另加底部按钮行高度（考虑各按钮独立可见性）。
 *
 * @param theme MarkdownTheme
 * @param componentWidth 控件宽度
 * @return 块高度（vp）
 */
func estimateVideoBlockNodeHeight(theme: MarkdownTheme, componentWidth: Float64): Float64 {
    let vt: VideoTheme = theme.videoTheme
    let effectiveWidth: Float64 = componentWidth - vt.videoPaddingLeft - vt.videoPaddingRight
    let imageHeight: Float64 = effectiveWidth * (9.0 / 16.0)
    var bottomLayoutHeight: Float64 = 0.0
    if (vt.videoBottomLayoutVisible) {
        // 按各按钮独立可见性计算高度（取可见按钮中最大者）
        var btnHeight: Float64 = 0.0
        if (vt.videoReleaseButtonVisible) {
            btnHeight = vt.videoReleaseButtonHeight
        }
        if (vt.videoDownloadButtonVisible) {
            if (vt.videoDownloadButtonHeight > btnHeight) {
                btnHeight = vt.videoDownloadButtonHeight
            }
        }
        bottomLayoutHeight = vt.videoBottomLayoutMarginTop + btnHeight
    }
    // videoBorderWidth 在 Image 上（border-box），不额外添加
    return vt.videoMarginTop + vt.videoPaddingTop + imageHeight + bottomLayoutHeight +
        vt.videoPaddingBottom + vt.videoMarginBottom
}

/**
 * 估算幻灯片（Banner）块节点高度
 *
 * 渲染端 MarkdownBannerComponent 结构为：
 *   Row(padding, margin) > Swiper(layoutWeight=1) {
 *     ForEach { Image(objectFit=Contain, autoResize) }
 *   }
 *
 * 图片无显式 width/height，高度依赖运行时图片资源尺寸，无法预计算。
 * 若 imageTheme.imageHeight 已设置则使用，否则内容高度按 0 处理
 * （实际渲染后高度会随图片加载变化，可能触发重新布局）。
 *
 * @param theme MarkdownTheme
 * @return 块高度（vp）
 */
func estimateBannerNodeHeight(theme: MarkdownTheme): Float64 {
    let bt: BannerTheme = theme.bannerTheme
    let it: ImageTheme = theme.imageTheme
    let contentHeight: Float64 = if (it.imageHeight.isSome()) { it.imageHeight.getOrThrow() } else { 0.0 }
    return bt.bannerMarginTop + bt.bannerPaddingTop + contentHeight +
        bt.bannerPaddingBottom + bt.bannerMarginBottom
}

/**
 * 估算单图块节点高度
 *
 * ImageSingleBlock 由 ImageSinglePlugin 将仅含单张图片的段落提升为块级。
 * 渲染端 node_view.cj 中 ImageSingleBlock 标记为 "无需处理"（未创建 NodeView），
 * 因此该块不参与渲染，高度返回 0。
 *
 * @param theme MarkdownTheme
 * @return 块高度（vp）
 */
func estimateImageSingleBlockNodeHeight(theme: MarkdownTheme): Float64 {
    return 0.0
}
