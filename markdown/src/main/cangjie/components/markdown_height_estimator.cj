package markdown.components

import std.math.ceil
import std.math.floor

/**
 * 预计算 Markdown 渲染高度
 *
 * 直接调用调用方传入的 Markdown 解析器将文本解析为节点树，然后遍历节点树，
 * 根据每个节点的类型和主题样式中的 margin/padding/lineHeight 计算高度。
 *
 * 与 ArkTS preMarkwonHeight/preMarkwonHeightByNode 的区别：
 * - 不再使用正则解析，而是直接使用 commonmark4cj 解析出的节点树
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
 * @param componentWidth 控件宽度（vp），默认360，用于估算文本行数
 * @return 估算高度（vp）
 */
public func preMarkwonHeight(content: String, config: MarkdownConfiguration, markdownPlugin: Markdown, componentWidth!: Float64 = 360.0): Float64 {
    let theme: MarkdownTheme = config.markdownTheme
    let global: GlobalTheme = theme.globalTheme
    let blockSpacing: Float64 = Float64(global.markdownBlockSpacing)

    let doc: CommonmarkNode = markdownPlugin.toMarkdown(content)
    var totalHeight: Float64 = 0.0
    var first: Bool = true
    for (block in doc.iterateChildren()) {
        if (!first) {
            totalHeight += blockSpacing
        }
        first = false
        totalHeight += estimateBlockNodeHeight(block, theme, componentWidth, blockSpacing)
    }

    totalHeight += global.blockMarginTop
    totalHeight += global.blockMarginBottom
    return totalHeight
}

/**
 * 预计算 Markdown 渲染高度（与 preMarkwonHeight 相同实现）
 *
 * 解析器已将 setext/ATX 标题统一识别为 Heading 节点，
 * 故此函数与 preMarkwonHeight 行为一致。
 *
 * @param content Markdown文本内容
 * @param config Markdown配置（含主题样式）
 * @param markdownPlugin Markdown解析器实例（需与渲染组件使用的插件链一致）
 * @param componentWidth 控件宽度（vp），默认360
 * @return 预计算高度（vp）
 */
public func preMarkwonHeightByNode(content: String, config: MarkdownConfiguration, markdownPlugin: Markdown, componentWidth!: Float64 = 360.0): Float64 {
    return preMarkwonHeight(content, config, markdownPlugin, componentWidth: componentWidth)
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
            return calcHeadingHeight(Int64(h.getLevel()), theme.headingTheme)
        case p: Paragraph =>
            return estimateParagraphNodeHeight(p, theme, componentWidth)
        case fcb: FencedCodeBlock =>
            return estimateCodeBlockNodeHeight(fcb.getLiteral(), theme)
        case icb: IndentedCodeBlock =>
            return estimateCodeBlockNodeHeight(icb.getLiteral(), theme)
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
            return estimateLatexMathBlockNodeHeight(lmb, theme)
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

/**
 * 递归收集节点树中的可见文本（Text/Code 字面量）
 *
 * SoftLineBreak 根据 isLineBreak 区分：
 * - true  → '\n'（软换行渲染为换行）
 * - false → ' ' （软换行渲染为空格，不换行）
 * HardLineBreak 始终为 '\n'
 *
 * @param node 节点
 * @param isLineBreak 软换行是否渲染为换行
 * @return 纯文本
 */
func collectInlineText(node: CommonmarkNode, isLineBreak: Bool): String {
    let sb = StringBuilder()
    for (child in node.iterateChildren()) {
        match (child) {
            case t: CommonmarkText => sb.append(t.getLiteral())
            case c: Code => sb.append(c.getLiteral())
            case _: SoftLineBreak => sb.append(if (isLineBreak) { '\n' } else { ' ' })
            case _: HardLineBreak => sb.append('\n')
            case _ => sb.append(collectInlineText(child, isLineBreak))
        }
    }
    return sb.toString()
}

/**
 * 计算标题块高度（含 margin/padding/underline）
 *
 * @param level 标题等级 1-6
 * @param ht HeadingTheme
 * @return 块高度（vp）
 */
func calcHeadingHeight(level: Int64, ht: HeadingTheme): Float64 {
    match (level) {
        case 1 =>
            return ht.heading1MarginTop + ht.heading1PaddingTop + ht.heading1TextLineHeight +
                ht.heading1UnderlineHeight + ht.heading1UnderlineSpacing +
                ht.heading1PaddingBottom + ht.heading1MarginBottom
        case 2 =>
            return ht.heading2MarginTop + ht.heading2PaddingTop + ht.heading2TextLineHeight +
                ht.heading2UnderlineHeight + ht.heading2UnderlineSpacing +
                ht.heading2PaddingBottom + ht.heading2MarginBottom
        case 3 =>
            return ht.heading3MarginTop + ht.heading3PaddingTop + ht.heading3TextLineHeight +
                ht.heading3PaddingBottom + ht.heading3MarginBottom
        case 4 =>
            return ht.heading4MarginTop + ht.heading4PaddingTop + ht.heading4TextLineHeight +
                ht.heading4PaddingBottom + ht.heading4MarginBottom
        case 5 =>
            return ht.heading5MarginTop + ht.heading5PaddingTop + ht.heading5TextLineHeight +
                ht.heading5PaddingBottom + ht.heading5MarginBottom
        case 6 =>
            return ht.heading6MarginTop + ht.heading6PaddingTop + ht.heading6TextLineHeight +
                ht.heading6PaddingBottom + ht.heading6MarginBottom
        case _ =>
            return 0.0
    }
}

/**
 * 估算段落节点高度
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
    let text: String = collectInlineText(p, theme.globalTheme.isLineBreak)
    let avgCharWidth: Float64 = if (fontSize * 0.8 > 1.0) { fontSize * 0.8 } else { 1.0 }
    let charsPerLine: Float64 = if (floor(componentWidth / avgCharWidth) > 1.0) { floor(componentWidth / avgCharWidth) } else { 1.0 }
    let lineCount: Float64 = estimateTextLineCount(text, charsPerLine)
    let contentHeight: Float64 = lineCount * lineHeight
    return pt.paragraphMarginTop + pt.paragraphPaddingTop + contentHeight +
        pt.paragraphPaddingBottom + pt.paragraphMarginBottom
}

/**
 * 估算文本换行后的行数（按字符宽度估算）
 *
 * @param text 文本
 * @param charsPerLine 每行字符数
 * @return 总行数
 */
func estimateTextLineCount(text: String, charsPerLine: Float64): Float64 {
    let lines: Array<String> = text.split("\n")
    var totalLines: Float64 = 0.0
    for (line in lines) {
        let charCount: Int64 = line.toRuneArray().size
        let cnt: Float64 = if (charCount == 0) {
            1.0
        } else {
            let raw: Float64 = ceil(Float64(charCount) / charsPerLine)
            if (raw > 1.0) { raw } else { 1.0 }
        }
        totalLines += cnt
    }
    return totalLines
}

/**
 * 估算代码块节点高度
 *
 * @param literal 代码内容
 * @param theme MarkdownTheme
 * @return 块高度（vp）
 */
func estimateCodeBlockNodeHeight(literal: String, theme: MarkdownTheme): Float64 {
    let ct: CodeBlockTheme = theme.codeBlockTheme
    let codeLines: Array<String> = literal.split("\n")
    var lines: Int64 = Int64(codeLines.size)
    if (lines < 1) {
        lines = 1
    }
    let lineHeight: Float64 = ct.codeBlockTextLineHeight
    let codeContentHeight: Float64 = Float64(lines) * lineHeight
    return ct.codeBlockMarginTop + ct.codeBlockPaddingTop + ct.codeBlockBorderWidth * 2.0 + codeContentHeight +
        ct.codeBlockPaddingBottom + ct.codeBlockMarginBottom
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
    var innerHeight: Float64 = 0.0
    var first: Bool = true
    for (child in bq.iterateChildren()) {
        if (!first) {
            innerHeight += innerBlockSpacing
        }
        first = false
        innerHeight += estimateBlockNodeHeight(child, theme, componentWidth, innerBlockSpacing)
    }
    return bqt.blockQuoteMarginTop + bqt.blockQuotePaddingTop + innerHeight +
        bqt.blockQuotePaddingBottom + bqt.blockQuoteMarginBottom
}

/**
 * 估算列表节点高度
 *
 * @param node 列表节点（BulletList/OrderedList）
 * @param theme MarkdownTheme
 * @param componentWidth 控件宽度
 * @param blockSpacing 块间距
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
    let lineHeight: Float64 = theme.paragraphTheme.paragraphTextLineHeight
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

    var itemCount: Int64 = 0
    for (child in node.iterateChildren()) {
        if (child is CommonmarkListItem) {
            itemCount++
        }
    }
    if (itemCount < 1) {
        itemCount = 1
    }
    let extraSpacing: Float64 = if (itemCount > 1) { Float64(itemCount - 1) * childSpacing } else { 0.0 }
    let innerHeight: Float64 = Float64(itemCount) * lineHeight + extraSpacing
    return marginTop + paddingTop + innerHeight + paddingBottom + marginBottom
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
    var headerRowCount: Int64 = 0
    var bodyRowCount: Int64 = 0
    for (child in tb.iterateChildren()) {
        match (child) {
            case _: TableHead =>
                for (row in child.iterateChildren()) {
                    if (row is TableRow) {
                        headerRowCount++
                    }
                }
            case _: TableBody =>
                for (row in child.iterateChildren()) {
                    if (row is TableRow) {
                        bodyRowCount++
                    }
                }
            case _ => ()
        }
    }
    if (headerRowCount == 0 && bodyRowCount == 0) {
        headerRowCount = 1
    }
    let cellPaddingTop: Float64 = tt.tableCellPaddingTop
    let cellPaddingBottom: Float64 = tt.tableCellPaddingBottom
    let borderWidth: Float64 = tt.tableBorderWidth
    let headerRowHeight: Float64 = cellPaddingTop + tt.tableTitleTextLineHeight + cellPaddingBottom + borderWidth
    let bodyRowHeight: Float64 = cellPaddingTop + tt.tableContentTextLineHeight + cellPaddingBottom + borderWidth
    let contentHeight: Float64 = Float64(headerRowCount) * headerRowHeight + Float64(bodyRowCount) * bodyRowHeight
    return tt.tableMarginTop + tt.tablePaddingTop + contentHeight +
        tt.tablePaddingBottom + tt.tableMarginBottom
}

/**
 * 估算分割线块高度
 *
 * @param theme MarkdownTheme
 * @return 块高度（vp）
 */
func estimateDividerHeight(theme: MarkdownTheme): Float64 {
    let dt: DividerTheme = theme.dividerTheme
    return dt.dividerMarginTop + dt.dividerPaddingTop + dt.dividerStrokeWidth +
        dt.dividerPaddingBottom + dt.dividerMarginBottom
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
 * 若 latexMathDefaultText 为 true，则未加载时显示原始 latex 文本，
 * 按文本行数 × 字号估算；否则高度依赖运行时渲染的图片尺寸，返回 0。
 *
 * @param lmb LatexMathBlock节点
 * @param theme MarkdownTheme
 * @return 块高度（vp）
 */
func estimateLatexMathBlockNodeHeight(lmb: LatexMathBlock, theme: MarkdownTheme): Float64 {
    let lmt: LatexMathTheme = theme.latexMathTheme
    if (!lmt.latexMathDefaultText) {
        return 0.0
    }
    let latex: String = lmb.latex
    let fontSize: Float64 = lmt.latexMathDefaultTextFontSize
    let lines: Array<String> = latex.split("\n")
    var lineCount: Int64 = Int64(lines.size)
    if (lineCount < 1) {
        lineCount = 1
    }
    let contentHeight: Float64 = Float64(lineCount) * fontSize
    return lmt.latexMathMarginTop + lmt.latexMathPaddingTop + contentHeight +
        lmt.latexMathPaddingBottom + lmt.latexMathMarginBottom
}

/**
 * 估算组合代码块节点高度
 *
 * FencedCodeBlockListBlock 是多个 FencedCodeBlock 组合而成的标签页式代码块。
 * 内容区高度取所有子代码块中最大者（标签页容器需容纳最大内容），
 * 标签栏高度按 codeBlockListTitleTextSize 近似估算。
 *
 * @param clb FencedCodeBlockListBlock节点
 * @param theme MarkdownTheme
 * @return 块高度（vp）
 */
func estimateCodeListBlockNodeHeight(clb: FencedCodeBlockListBlock, theme: MarkdownTheme): Float64 {
    let ct: CodeBlockTheme = theme.codeBlockTheme
    var maxCodeHeight: Float64 = 0.0
    for (child in clb.iterateChildren()) {
        match (child) {
            case fcb: FencedCodeBlock =>
                let h: Float64 = estimateCodeBlockNodeHeight(fcb.getLiteral(), theme)
                if (h > maxCodeHeight) {
                    maxCodeHeight = h
                }
            case _ => ()
        }
    }
    if (maxCodeHeight == 0.0) {
        maxCodeHeight = ct.codeBlockTextLineHeight
    }
    // 标签栏近似高度（按标题字号 + 内外边距近似），不重复计入代码块自身的外部 margin
    let tabBarHeight: Float64 = ct.codeBlockListTitleSelectTextSize
    // 减去单个代码块已计入的 codeBlockMarginTop/Bottom，避免叠加
    let innerCodeHeight: Float64 = maxCodeHeight - ct.codeBlockMarginTop - ct.codeBlockMarginBottom
    let innerHeight: Float64 = if (innerCodeHeight > 0.0) { innerCodeHeight } else { maxCodeHeight }
    return ct.codeBlockMarginTop + ct.codeBlockPaddingTop + ct.codeBlockBorderWidth * 2.0 + tabBarHeight + innerHeight +
        ct.codeBlockPaddingBottom + ct.codeBlockMarginBottom
}

/**
 * 估算音频块节点高度
 *
 * 音频组件为 Row(图标 + 标题/类型文本列 + 播放按钮)，内容高度取三者最大值。
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
 * 视频图片宽度撑满父布局（100.percent），按默认 16:9 宽高比估算图片高度。
 * 若 videoBottomLayoutVisible，另加底部按钮行高度。
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
        let btnHeight: Float64 = if (vt.videoReleaseButtonHeight > vt.videoDownloadButtonHeight) {
            vt.videoReleaseButtonHeight
        } else {
            vt.videoDownloadButtonHeight
        }
        bottomLayoutHeight = vt.videoBottomLayoutMarginTop + btnHeight
    }
    return vt.videoMarginTop + vt.videoPaddingTop + vt.videoBorderWidth * 2.0 + imageHeight + bottomLayoutHeight +
        vt.videoPaddingBottom + vt.videoMarginBottom
}

/**
 * 估算幻灯片（Banner）块节点高度
 *
 * SlideBlock 是图片轮播容器，图片高度依赖运行时资源尺寸。
 * 若 imageTheme.imageHeight 已设置则使用，否则内容高度按 0 处理。
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
 * ImageSingleBlock 是整块图片，图片高度依赖运行时资源尺寸。
 * 若 imageTheme.imageHeight 已设置则使用，否则内容高度按 0 处理。
 *
 * @param theme MarkdownTheme
 * @return 块高度（vp）
 */
func estimateImageSingleBlockNodeHeight(theme: MarkdownTheme): Float64 {
    let it: ImageTheme = theme.imageTheme
    let contentHeight: Float64 = if (it.imageHeight.isSome()) { it.imageHeight.getOrThrow() } else { 0.0 }
    return it.imageMarginTop + it.imageBorderWidth * 2.0 + contentHeight + it.imageMarginBottom
}
