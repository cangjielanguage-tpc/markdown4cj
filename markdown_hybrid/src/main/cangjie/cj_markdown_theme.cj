package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownTheme {
    /**
     * 全局样式
     */
    var cjMarkdownGlobalTheme: CJMarkdownGlobalTheme = CJMarkdownGlobalTheme()

    /**
     * 链接文本样式
     */
    var cjMarkdownLinkTheme: CJMarkdownLinkTheme = CJMarkdownLinkTheme()

    /**
     * banner样式
     */
    var cjMarkdownBannerTheme: CJMarkdownBannerTheme = CJMarkdownBannerTheme()

    /**
     * 块引用样式
     */
    var cjMarkdownBlockQuoteTheme: CJMarkdownBlockQuoteTheme = CJMarkdownBlockQuoteTheme()

    /**
     * 有序列表样式
     */
    var cjMarkdownOrderedListTheme: CJMarkdownOrderedListTheme = CJMarkdownOrderedListTheme()

    /**
     * 无序/任务列表样式
     */
    var cjMarkdownBulletListTheme: CJMarkdownBulletListTheme = CJMarkdownBulletListTheme()

    /**
     * 代码块样式
     */
    var cjMarkdownCodeBlockTheme: CJMarkdownCodeBlockTheme = CJMarkdownCodeBlockTheme()

    /**
     * 内联代码样式
     */
    var cjMarkdownInlineCodeTheme: CJMarkdownInlineCodeTheme = CJMarkdownInlineCodeTheme()

    /**
     * 标题样式
     */
    var cjMarkdownHeadingTheme: CJMarkdownHeadingTheme = CJMarkdownHeadingTheme()

    /**
     * 段落样式
     */
    var cjMarkdownParagraphTheme: CJMarkdownParagraphTheme = CJMarkdownParagraphTheme()

    /**
     * 分割线样式
     */
    var cjMarkdownDividerTheme: CJMarkdownDividerTheme = CJMarkdownDividerTheme()

    /**
     * 数学公式样式
     */
    var cjMarkdownLatexMathTheme: CJMarkdownLatexMathTheme = CJMarkdownLatexMathTheme()

    /**
     * 音频样式
     */
    var cjMarkdownAudioTheme: CJMarkdownAudioTheme = CJMarkdownAudioTheme()

    /**
     * 加粗文本样式
     */
    var cjMarkdownBoldTheme: CJMarkdownBoldTheme = CJMarkdownBoldTheme()

    /**
     * 斜体文本样式
     */
    var cjMarkdownItalicTheme: CJMarkdownItalicTheme = CJMarkdownItalicTheme()

    /**
     * 删除线文本样式
     */
    var cjMarkdownStrikethroughTheme: CJMarkdownStrikethroughTheme = CJMarkdownStrikethroughTheme()

    /**
     * 脚注定义样式
     */
    var cjMarkdownFootnoteDefTheme: CJMarkdownFootnoteDefTheme = CJMarkdownFootnoteDefTheme()

    /**
     * 脚注引用样式
     */
    var cjMarkdownFootnoteRefTheme: CJMarkdownFootnoteRefTheme = CJMarkdownFootnoteRefTheme()

    /**
     * 视频样式
     */
    var cjMarkdownVideoTheme: CJMarkdownVideoTheme = CJMarkdownVideoTheme()

    /**
     * 图片样式
     */
    var cjMarkdownImageTheme: CJMarkdownImageTheme = CJMarkdownImageTheme()

    /**
     * 表格样式
     */
    var cjMarkdownTableTheme: CJMarkdownTableTheme = CJMarkdownTableTheme()

    /**
     * 定义列表样式
     */
    var cjMarkdownDefinitionListTheme: CJMarkdownDefinitionListTheme = CJMarkdownDefinitionListTheme()

    /**
     * 下标文本样式
     */
    var cjMarkdownSubTheme: CJMarkdownSubTheme = CJMarkdownSubTheme()

    /**
     * 上标文本样式
     */
    var cjMarkdownSupTheme: CJMarkdownSupTheme = CJMarkdownSupTheme()

    /**
     * 下划线样式
     */
    var cjMarkdownHtmlUnderlineTheme: CJMarkdownHtmlUnderlineTheme = CJMarkdownHtmlUnderlineTheme()

    /**
     * 高亮样式
     */
    var cjMarkdownHighlightTheme: CJMarkdownHighlightTheme = CJMarkdownHighlightTheme()

    public init() {}

    /**
     * 设置全局样式
     *
     * @param cjMarkdownGlobalTheme 全局样式
     */
    public func setCJMarkdownGlobalTheme(cjMarkdownGlobalTheme: CJMarkdownGlobalTheme): Unit {
        this.cjMarkdownGlobalTheme = cjMarkdownGlobalTheme
    }

    /**
     * 设置音频样式
     *
     * @param cjMarkdownAudioTheme 音频样式
     */
    public func setCJMarkdownAudioTheme(cjMarkdownAudioTheme: CJMarkdownAudioTheme): Unit {
        this.cjMarkdownAudioTheme = cjMarkdownAudioTheme
    }

    /**
     * 设置加粗文本样式
     *
     * @param cjMarkdownBoldTheme 加粗文本样式
     */
    public func setCJMarkdownBoldTheme(cjMarkdownBoldTheme: CJMarkdownBoldTheme): Unit {
        this.cjMarkdownBoldTheme = cjMarkdownBoldTheme
    }

    /**
     * 设置定义列表样式
     *
     * @param cjMarkdownDefinitionListTheme 定义列表样式
     */
    public func setCJMarkdownDefinitionListTheme(cjMarkdownDefinitionListTheme: CJMarkdownDefinitionListTheme): Unit {
        this.cjMarkdownDefinitionListTheme = cjMarkdownDefinitionListTheme
    }

    /**
     * 设置分割线样式
     *
     * @param cjMarkdownDividerTheme 分割线样式
     */
    public func setCJMarkdownDividerTheme(cjMarkdownDividerTheme: CJMarkdownDividerTheme): Unit {
        this.cjMarkdownDividerTheme = cjMarkdownDividerTheme
    }

    /**
     * 设置脚注定义样式
     *
     * @param cjMarkdownFootnoteDefTheme 脚注定义样式
     */
    public func setCJMarkdownFootnoteDefTheme(cjMarkdownFootnoteDefTheme: CJMarkdownFootnoteDefTheme): Unit {
        this.cjMarkdownFootnoteDefTheme = cjMarkdownFootnoteDefTheme
    }

    /**
     * 设置脚注引用样式
     *
     * @param cjMarkdownFootnoteRefTheme 脚注引用样式
     */
    public func setCJMarkdownFootnoteRefTheme(cjMarkdownFootnoteRefTheme: CJMarkdownFootnoteRefTheme): Unit {
        this.cjMarkdownFootnoteRefTheme = cjMarkdownFootnoteRefTheme
    }

    /**
     * 设置数学公式样式
     *
     * @param cjMarkdownLatexMathTheme 数学公式样式
     */
    public func setCJMarkdownLatexMathTheme(cjMarkdownLatexMathTheme: CJMarkdownLatexMathTheme): Unit {
        this.cjMarkdownLatexMathTheme = cjMarkdownLatexMathTheme
    }

    /**
     * 设置HTML下划线样式
     *
     * @param cjMarkdownHtmlUnderlineTheme HTML下划线样式
     */
    public func setCJMarkdownHtmlUnderlineTheme(cjMarkdownHtmlUnderlineTheme: CJMarkdownHtmlUnderlineTheme): Unit {
        this.cjMarkdownHtmlUnderlineTheme = cjMarkdownHtmlUnderlineTheme
    }

    /**
     * 设置高亮样式
     *
     * @param cjMarkdownHighlightTheme 高亮样式
     */
    public func setCJMarkdownHighlightTheme(cjMarkdownHighlightTheme: CJMarkdownHighlightTheme): Unit {
        this.cjMarkdownHighlightTheme = cjMarkdownHighlightTheme
    }

    /**
     * 设置斜体文本样式
     *
     * @param cjMarkdownItalicTheme 斜体文本样式
     */
    public func setCJMarkdownItalicTheme(cjMarkdownItalicTheme: CJMarkdownItalicTheme): Unit {
        this.cjMarkdownItalicTheme = cjMarkdownItalicTheme
    }

    /**
     * 设置删除线文本样式
     *
     * @param cjMarkdownStrikethroughTheme 删除线文本样式
     */
    public func setCJMarkdownStrikethroughTheme(cjMarkdownStrikethroughTheme: CJMarkdownStrikethroughTheme): Unit {
        this.cjMarkdownStrikethroughTheme = cjMarkdownStrikethroughTheme
    }

    /**
     * 设置下标文本样式
     *
     * @param cjMarkdownSubTheme 下标文本样式
     */
    public func setCJMarkdownSubTheme(cjMarkdownSubTheme: CJMarkdownSubTheme): Unit {
        this.cjMarkdownSubTheme = cjMarkdownSubTheme
    }

    /**
     * 设置上标文本样式
     *
     * @param cjMarkdownSupTheme 上标文本样式
     */
    public func setCJMarkdownSupTheme(cjMarkdownSupTheme: CJMarkdownSupTheme): Unit {
        this.cjMarkdownSupTheme = cjMarkdownSupTheme
    }

    /**
     * 设置内联代码样式
     *
     * @param cjMarkdownInlineCodeTheme 内联代码样式
     */
    public func setCJMarkdownInlineCodeTheme(cjMarkdownInlineCodeTheme: CJMarkdownInlineCodeTheme): Unit {
        this.cjMarkdownInlineCodeTheme = cjMarkdownInlineCodeTheme
    }

    /**
     * 设置链接文本样式
     *
     * @param cjMarkdownLinkTheme 链接文本样式
     */
    public func setCJMarkdownLinkTheme(cjMarkdownLinkTheme: CJMarkdownLinkTheme): Unit {
        this.cjMarkdownLinkTheme = cjMarkdownLinkTheme
    }

    /**
     * 设置有序列表样式
     *
     * @param cjMarkdownOrderedListTheme 有序列表样式
     */
    public func setCJMarkdownOrderedListTheme(cjMarkdownOrderedListTheme: CJMarkdownOrderedListTheme): Unit {
        this.cjMarkdownOrderedListTheme = cjMarkdownOrderedListTheme
    }

    /**
     * 设置无序/任务列表样式
     *
     * @param cjMarkdownBulletListTheme 无序列表样式
     */
    public func setCJMarkdownBulletListTheme(cjMarkdownBulletListTheme: CJMarkdownBulletListTheme): Unit {
        this.cjMarkdownBulletListTheme = cjMarkdownBulletListTheme
    }

    /**
     * 设置段落样式
     *
     * @param cjMarkdownParagraphTheme 段落样式
     */
    public func setCJMarkdownParagraphTheme(cjMarkdownParagraphTheme: CJMarkdownParagraphTheme): Unit {
        this.cjMarkdownParagraphTheme = cjMarkdownParagraphTheme
    }

    /**
     * 设置视频样式
     *
     * @param cjMarkdownVideoTheme 视频样式
     */
    public func setCJMarkdownVideoTheme(cjMarkdownVideoTheme: CJMarkdownVideoTheme): Unit {
        this.cjMarkdownVideoTheme = cjMarkdownVideoTheme
    }

    /**
     * 设置表格样式
     *
     * @param cjMarkdownTableTheme 表格样式
     */
    public func setCJMarkdownTableTheme(cjMarkdownTableTheme: CJMarkdownTableTheme): Unit {
        this.cjMarkdownTableTheme = cjMarkdownTableTheme
    }

    /**
     * 设置块引用样式
     *
     * @param cjMarkdownBlockQuoteTheme 块引用样式
     */
    public func setCJMarkdownBlockQuoteTheme(cjMarkdownBlockQuoteTheme: CJMarkdownBlockQuoteTheme): Unit {
        this.cjMarkdownBlockQuoteTheme = cjMarkdownBlockQuoteTheme
    }

    /**
     * 设置banner样式
     *
     * @param cjMarkdownBannerTheme banner样式
     */
    public func setCJMarkdownBannerTheme(cjMarkdownBannerTheme: CJMarkdownBannerTheme): Unit {
        this.cjMarkdownBannerTheme = cjMarkdownBannerTheme
    }

    /**
     * 设置图片样式
     *
     * @param cjMarkdownImageTheme 图片样式
     */
    public func setCJMarkdownImageTheme(cjMarkdownImageTheme: CJMarkdownImageTheme): Unit {
        this.cjMarkdownImageTheme = cjMarkdownImageTheme
    }

    /**
     * 设置标题样式
     *
     * @param cjMarkdownHeadingTheme 标题样式
     */
    public func setCJMarkdownHeadingTheme(cjMarkdownHeadingTheme: CJMarkdownHeadingTheme): Unit {
        this.cjMarkdownHeadingTheme = cjMarkdownHeadingTheme
    }

    /**
     * 设置代码块样式
     *
     * @param cjMarkdownCodeBlockTheme 代码块样式
     */
    public func setCJMarkdownCodeBlockTheme(cjMarkdownCodeBlockTheme: CJMarkdownCodeBlockTheme): Unit {
        this.cjMarkdownCodeBlockTheme = cjMarkdownCodeBlockTheme
    }
}
