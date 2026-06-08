package markdown.components

/**
 * Markdown用户可设置的样式
 */
public class MarkdownTheme {
    protected var globalTheme: GlobalTheme = GlobalTheme() // 全局样式
    protected var paragraphTheme: ParagraphTheme = ParagraphTheme() // 段落样式
    protected var headingTheme: HeadingTheme = HeadingTheme() // 标题样式
    protected var tableTheme: TableTheme = TableTheme() // 表格样式
    protected var dividerTheme: DividerTheme = DividerTheme() // 分割线样式
    protected var blockQuoteTheme: BlockQuoteTheme = BlockQuoteTheme() // 块引用样式
    protected var orderedListTheme: OrderedListTheme = OrderedListTheme() // 有序列表样式
    protected var bulletListTheme: BulletListTheme = BulletListTheme() // 无序/任务列表样式
    protected var definitionListTheme: DefinitionListTheme = DefinitionListTheme() // 定义列表样式
    protected var codeBlockTheme: CodeBlockTheme = CodeBlockTheme() // 代码块样式
    protected var audioTheme: AudioTheme = AudioTheme() // 音频样式
    protected var videoTheme: VideoTheme = VideoTheme() // 视频样式
    protected var bannerTheme: BannerTheme = BannerTheme() // banner样式
    protected var footnoteDefTheme: FootnoteDefTheme = FootnoteDefTheme() // 脚注定义样式
    protected var footnoteRefTheme: FootnoteRefTheme = FootnoteRefTheme() // 脚注引用样式
    protected var inlineCodeTheme: InlineCodeTheme = InlineCodeTheme() // 内联代码样式
    protected var boldTheme: BoldTheme = BoldTheme() // 加粗文本样式
    protected var latexMathTheme: LatexMathTheme = LatexMathTheme() // 数学公式样式
    protected var htmlUnderlineTheme: HtmlUnderlineTheme = HtmlUnderlineTheme() // HTML下划线文本样式
    protected var imageTheme: ImageTheme = ImageTheme() // 图片样式
    protected var italicTheme: ItalicTheme = ItalicTheme() // 斜体文本样式
    protected var linkTheme: LinkTheme = LinkTheme() // 链接文本样式
    protected var strikethroughTheme: StrikethroughTheme = StrikethroughTheme() // 删除线文本样式
    protected var highlightTheme: HighlightTheme = HighlightTheme() // 高亮样式
    protected var subTheme: SubTheme = SubTheme() // 下标文本样式
    protected var supTheme: SupTheme = SupTheme() // 上标文本样式
    protected var prismTheme: PrismTheme = PrismThemeDefault.create() // markdown代码高亮样式

    protected init(builder: MarkdownThemeBuilder) {
        this.globalTheme = builder.globalTheme
        this.paragraphTheme = builder.paragraphTheme
        this.headingTheme = builder.headingTheme
        this.tableTheme = builder.tableTheme
        this.dividerTheme = builder.dividerTheme
        this.blockQuoteTheme = builder.blockQuoteTheme
        this.orderedListTheme = builder.orderedListTheme
        this.bulletListTheme = builder.bulletListTheme
        this.definitionListTheme = builder.definitionListTheme
        this.codeBlockTheme = builder.codeBlockTheme
        this.audioTheme = builder.audioTheme
        this.videoTheme = builder.videoTheme
        this.bannerTheme = builder.bannerTheme
        this.footnoteDefTheme = builder.footnoteDefTheme
        this.footnoteRefTheme = builder.footnoteRefTheme
        this.inlineCodeTheme = builder.inlineCodeTheme
        this.boldTheme = builder.boldTheme
        this.latexMathTheme = builder.latexMathTheme
        this.htmlUnderlineTheme = builder.htmlUnderlineTheme
        this.imageTheme = builder.imageTheme
        this.italicTheme = builder.italicTheme
        this.linkTheme = builder.linkTheme
        this.strikethroughTheme = builder.strikethroughTheme
        this.highlightTheme = builder.highlightTheme
        this.subTheme = builder.subTheme
        this.supTheme = builder.supTheme
        this.prismTheme = builder.prismTheme
    }

    /**
     * 创建Theme对象
     *
     * @return MarkdownTheme 创建空的MarkdownTheme对象
     */
    public static func create(): MarkdownTheme {
        return emptyBuilder().build()
    }

    /**
     * 创建一个空的builder对象
     *
     * @return MarkdownThemeBuilder 创建空的MarkdownThemeBuilder对象
     */
    public static func emptyBuilder(): MarkdownThemeBuilder {
        return MarkdownThemeBuilder()
    }

    /**
     * 创建默认的Theme对象
     *
     * @return MarkdownTheme 创建默认的MarkdownTheme对象
     */
    public static func createDefaultBuilder(): MarkdownThemeBuilder {
        let markdownThemeBuilder: MarkdownThemeBuilder = MarkdownThemeBuilder()
        markdownThemeBuilder.setDefaultTheme()
        return markdownThemeBuilder
    }

    /**
     * 创建暗色的Theme对象
     *
     * @return MarkdownTheme 创建暗色的MarkdownTheme对象
     */
    public static func createDarculaBuilder(): MarkdownThemeBuilder {
        let markdownThemeBuilder: MarkdownThemeBuilder = MarkdownThemeBuilder()
        markdownThemeBuilder.setDarculaTheme()
        return markdownThemeBuilder
    }

    /**
     * 通过已有的Theme创建builder对象
     *
     * @param copyFrom MarkdownTheme对象
     * @return MarkdownThemeBuilder 创建MarkdownThemeBuilder对象
     */
    public static func builder(copyFrom: MarkdownTheme): MarkdownThemeBuilder {
        return MarkdownThemeBuilder(copyFrom)
    }
}

/**
 * MarkdownTheme Builder
 */
public class MarkdownThemeBuilder {
    var globalTheme: GlobalTheme = GlobalTheme() // 全局样式
    var paragraphTheme: ParagraphTheme = ParagraphTheme() // 段落样式
    var headingTheme: HeadingTheme = HeadingTheme() // 标题样式
    var tableTheme: TableTheme = TableTheme() // 表格样式
    var dividerTheme: DividerTheme = DividerTheme() // 分割线样式
    var blockQuoteTheme: BlockQuoteTheme = BlockQuoteTheme() // 块引用样式
    var orderedListTheme: OrderedListTheme = OrderedListTheme() // 有序列表样式
    var bulletListTheme: BulletListTheme = BulletListTheme() // 无序/任务列表样式
    var definitionListTheme: DefinitionListTheme = DefinitionListTheme() // 定义列表样式
    var codeBlockTheme: CodeBlockTheme = CodeBlockTheme() // 代码块样式
    var audioTheme: AudioTheme = AudioTheme() // 音频样式
    var videoTheme: VideoTheme = VideoTheme() // 视频样式
    var bannerTheme: BannerTheme = BannerTheme() // banner样式
    var footnoteDefTheme: FootnoteDefTheme = FootnoteDefTheme() // 脚注定义样式
    var footnoteRefTheme: FootnoteRefTheme = FootnoteRefTheme() // 脚注引用样式
    var inlineCodeTheme: InlineCodeTheme = InlineCodeTheme() // 内联代码样式
    var boldTheme: BoldTheme = BoldTheme() // 加粗文本样式
    var latexMathTheme: LatexMathTheme = LatexMathTheme() // 数学公式样式
    var htmlUnderlineTheme: HtmlUnderlineTheme = HtmlUnderlineTheme() // HTML下划线文本样式
    var imageTheme: ImageTheme = ImageTheme() // 图片样式
    var italicTheme: ItalicTheme = ItalicTheme() // 斜体文本样式
    var linkTheme: LinkTheme = LinkTheme() // 链接文本样式
    var strikethroughTheme: StrikethroughTheme = StrikethroughTheme() // 删除线文本样式
    var highlightTheme: HighlightTheme = HighlightTheme() // 高亮样式
    var subTheme: SubTheme = SubTheme() // 下标文本样式
    var supTheme: SupTheme = SupTheme() // 上标文本样式
    var prismTheme: PrismTheme = PrismThemeDefault.create() // markdown代码高亮样式

    init() {
    }

    init(theme: MarkdownTheme) {
        this.globalTheme = theme.globalTheme
        this.paragraphTheme = theme.paragraphTheme
        this.headingTheme = theme.headingTheme
        this.tableTheme = theme.tableTheme
        this.dividerTheme = theme.dividerTheme
        this.blockQuoteTheme = theme.blockQuoteTheme
        this.orderedListTheme = theme.orderedListTheme
        this.bulletListTheme = theme.bulletListTheme
        this.definitionListTheme = theme.definitionListTheme
        this.codeBlockTheme = theme.codeBlockTheme
        this.audioTheme = theme.audioTheme
        this.videoTheme = theme.videoTheme
        this.bannerTheme = theme.bannerTheme
        this.footnoteDefTheme = theme.footnoteDefTheme
        this.footnoteRefTheme = theme.footnoteRefTheme
        this.inlineCodeTheme = theme.inlineCodeTheme
        this.boldTheme = theme.boldTheme
        this.latexMathTheme = theme.latexMathTheme
        this.htmlUnderlineTheme = theme.htmlUnderlineTheme
        this.imageTheme = theme.imageTheme
        this.italicTheme = theme.italicTheme
        this.linkTheme = theme.linkTheme
        this.strikethroughTheme = theme.strikethroughTheme
        this.highlightTheme = theme.highlightTheme
        this.subTheme = theme.subTheme
        this.supTheme = theme.supTheme
        this.prismTheme = theme.prismTheme
    }

    /**
     * 设置浅色主题整体样式
     *
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setDefaultTheme(): MarkdownThemeBuilder {
        // 浅色主题 - 只切换颜色属性

        // 全局主题
        this.globalTheme.setBackgroundColor(COLOR_TRANSPARENT) // markdown全局背景颜色

        // 段落主题
        this.paragraphTheme.setParagraphTextFontColor(COLOR_FF191919) // 段落文本颜色

        // 标题主题
        this.headingTheme.setTextFontColorForAllHeading(COLOR_FF191919) // 标题文本颜色
            .setUnderlineColorForAllHeading(COLOR_FF191919) // 标题下划线颜色

        // 表格主题
        this.tableTheme.setTableBorderColor(COLOR_BLACK) // 表格边框颜色
            .setTableTitleTextFontColor(COLOR_FF191919) // 表格标题文本颜色
            .setTableContentTextFontColor(COLOR_FF191919) // 表格内容文本颜色
            .setTableTitleBackgroundColor(COLOR_WHITE) // 表格标题背景颜色
            .setTableContentOddRowBackgroundColor(COLOR_FFE0E0E0) // 表格内容奇数行背景颜色
            .setTableContentEvenRowBackgroundColor(COLOR_WHITE) // 表格内容偶数行背景颜色
            .setTableScrollBarColor(COLOR_FF191919) // 表格滚动条颜色

        // 分隔线主题
        this.dividerTheme.setDividerColor(COLOR_FF191919) // 分隔线颜色

        // 引用块主题
        this.blockQuoteTheme.setBlockQuoteLeftBorderColor(COLOR_FF191919) // 引用块左侧边框颜色
            .setBlockQuoteBackgroundColor(COLOR_FFEAEAEA) // 引用块背景颜色

        // 有序列表主题
        this.orderedListTheme.setOrderedListMarkerTextFontColor(COLOR_FF191919) // 有序列表标记文本颜色

        // 无序列表主题
        this.bulletListTheme.setBulletListBulletTextFontColor(COLOR_FF191919) // 无序列表标记文本颜色
            .setBulletListCheckboxSelectedColor(COLOR_GRAY) // 无序列表复选框选中颜色

        // 代码块主题
        this.codeBlockTheme.setCodeBlockBorderColor(COLOR_TRANSPARENT) // 代码块边框颜色
            .setCodeBlockListTitleSelectTextColor(COLOR_RED) // 列表标题选中文本颜色
            .setCodeBlockListTitleUnselectTextColor(COLOR_BLACK) // 列表标题未选中文本颜色
            .setCodeBlockListTitleSelectBackgroundColor(COLOR_GRAY) // 列表标题选中背景颜色
            .setCodeBlockListTitleUnselectBackgroundColor(COLOR_TRANSPARENT) // 列表标题未选背景颜色

        // 音频主题
        this.audioTheme.setAudioBackgroundColor(COLOR_TRANSPARENT) // 音频背景颜色
            .setAudioBorderColor(COLOR_33000000) // 音频边框颜色
            .setAudioShadowColor(COLOR_1A000000) // 音频阴影颜色
            .setAudioTitleTextFontColor(COLOR_BLACK) // 音频标题文本颜色
            .setAudioTypeTextFontColor(COLOR_80000000) // 音频类型文本颜色
            .setAudioButtonBackgroundColor(COLOR_BLACK) // 音频按钮背景颜色
            .setAudioButtonBorderColor(COLOR_TRANSPARENT) // 音频按钮边框颜色
            .setAudioButtonTextFontColor(COLOR_WHITE) // 音频按钮文本颜色

        // 视频主题
        this.videoTheme.setVideoBackgroundColor(COLOR_TRANSPARENT) // 视频背景颜色
            .setVideoBorderColor(COLOR_TRANSPARENT) // 视频边框颜色
            .setVideoTimeTextFontColor(COLOR_WHITE) // 视频时间文本颜色
            .setVideoReleaseButtonBackgroundColor(COLOR_FFF5F5F5) // 视频发布按钮背景颜色
            .setVideoReleaseButtonTextFontColor(COLOR_E6000000) // 视频发布按钮文本颜色
            .setVideoDownloadButtonBackgroundColor(COLOR_FFF5F5F5) // 视频下载按钮背景颜色
            .setVideoDownloadButtonTextFontColor(COLOR_E6000000) // 视频下载按钮文本颜色

        // 脚注引用主题
        this.footnoteRefTheme.setFootnoteRefTextFontColor(COLOR_RED) // 脚注引用文本颜色
            .setFootnoteRefTextDecorationColor(COLOR_RED) // 脚注引用文本下划线颜色
            .setFootnoteRefTextBackgroundColor(COLOR_TRANSPARENT) // 脚注引用文本背景颜色

        // 行内代码主题
        this.inlineCodeTheme.setInlineCodeTextBackgroundColor(COLOR_FFEAEAEA) // 行内代码文本背景颜色

        // LaTeX数学公式主题
        this.latexMathTheme.setLatexMathDefaultTextFontColor(COLOR_RED) // 数学公式未加载状态文本颜色
            .setLatexMathBackgroundColor(COLOR_TRANSPARENT) // 数学公式背景颜色
            .setLatexMathTextColor(COLOR_BLACK) // 数学公式文本颜色

        // HTML下划线主题
        this.htmlUnderlineTheme.setHtmlUnderlineTextDecorationColor(COLOR_FF191919) // HTML下划线文本下划线颜色

        // 图片主题
        this.imageTheme.setImageBorderColor(COLOR_BLACK) // 图片边框颜色
            .setImageDownloadButtonBackgroundColor(COLOR_FFF5F5F5) // 图片下载按钮背景颜色
            .setImageDownloadButtonTextFontColor(COLOR_E6000000) // 图片下载按钮文本颜色

        // 链接主题
        this.linkTheme.setLinkTextFontColor(COLOR_RED) // 链接文本颜色
            .setLinkTextDecorationColor(COLOR_RED) // 链接文本下划线颜色
            .setLinkTextBackgroundColor(COLOR_TRANSPARENT) // 链接文本背景颜色
            .setLinkCircleIconBackgroundColor(COLOR_TRANSPARENT) // 链接圆形图标背景颜色
            .setLinkCircleIconButtonBackgroundColor(COLOR_BLACK) // 链接圆形图标按钮背景颜色
            .setLinkCircleIconTextColor(COLOR_WHITE) // 链接圆形图标按钮文本颜色
            .setLinkRectIconBackgroundColor(COLOR_TRANSPARENT) // 链接方形图标背景颜色
            .setLinkRectIconButtonBackgroundColor(COLOR_BLACK) // 链接方形图标按钮背景颜色
            .setLinkRectIconTextColor(COLOR_WHITE) // 链接方形图标按钮文本颜色
            .setLinkRectToolIconBackgroundColor(COLOR_TRANSPARENT) // 链接方形图标工具按钮背景颜色
            .setLinkRectToolIconButtonBackgroundColor(COLOR_WHITE) // 链接方形图标工具按钮背景颜色

        // 删除线主题
        this.strikethroughTheme.setStrikethroughTextDecorationColor(COLOR_FF191919) // 删除线文本下划线颜色

        // 高亮主题
        this.highlightTheme.setHighlightTextBackgroundColor(COLOR_FFFFF59D) // 高亮文本背景颜色

        // 代码高亮主题
        this.prismTheme = PrismThemeDefault.create() // 代码高亮主题

        return this
    }

    /**
     * 设置深色主题整体样式
     *
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setDarculaTheme(): MarkdownThemeBuilder {
        // 深色主题设计

        // 全局主题
        this.globalTheme.setBackgroundColor(COLOR_TRANSPARENT) // markdown全局背景颜色

        // 段落主题
        this.paragraphTheme.setParagraphTextFontColor(COLOR_FFE0E0E0) // 段落文本颜色

        // 标题主题
        this.headingTheme.setTextFontColorForAllHeading(COLOR_FFE0E0E0) // 标题文本颜色
            .setUnderlineColorForAllHeading(COLOR_FFE0E0E0) // 标题下划线颜色

        // 表格主题
        this.tableTheme.setTableBorderColor(COLOR_FF404040) // 表格边框颜色
            .setTableTitleTextFontColor(COLOR_FFE0E0E0) // 表格标题文本颜色
            .setTableContentTextFontColor(COLOR_FFE0E0E0) // 表格内容文本颜色
            .setTableTitleBackgroundColor(COLOR_FF2D2D2D) // 表格标题背景颜色
            .setTableContentOddRowBackgroundColor(COLOR_FF1E1E1E) // 表格内容奇数行背景颜色
            .setTableContentEvenRowBackgroundColor(COLOR_FF2D2D2D) // 表格内容偶数行背景颜色
            .setTableScrollBarColor(COLOR_FFE0E0E0) // 表格滚动条颜色

        // 分隔线主题
        this.dividerTheme.setDividerColor(COLOR_FFE0E0E0) // 分隔线颜色

        // 引用块主题
        this.blockQuoteTheme.setBlockQuoteLeftBorderColor(COLOR_FFE0E0E0) // 引用块左侧边框颜色
            .setBlockQuoteBackgroundColor(COLOR_FF252526) // 引用块背景颜色

        // 有序列表主题
        this.orderedListTheme.setOrderedListMarkerTextFontColor(COLOR_FFE0E0E0) // 有序列表标记文本颜色

        // 无序列表主题
        this.bulletListTheme.setBulletListBulletTextFontColor(COLOR_FFE0E0E0) // 无序列表标记文本颜色
            .setBulletListCheckboxSelectedColor(COLOR_FF4A90E2) // 无序列表复选框选中颜色

        // 代码块主题
        this.codeBlockTheme.setCodeBlockBorderColor(COLOR_TRANSPARENT) // 代码块边框颜色
            .setCodeBlockListTitleSelectTextColor(COLOR_FF4A90E2) // 列表标题选中文本颜色
            .setCodeBlockListTitleUnselectTextColor(COLOR_FFE0E0E0) // 列表标题未选中文本颜色
            .setCodeBlockListTitleSelectBackgroundColor(COLOR_FF2D2D2D) // 列表标题选中背景颜色
            .setCodeBlockListTitleUnselectBackgroundColor(COLOR_TRANSPARENT) // 列表标题未选背景颜色

        // 音频主题
        this.audioTheme.setAudioBackgroundColor(COLOR_FF1E1E1E) // 音频背景颜色
            .setAudioBorderColor(COLOR_FF404040) // 音频边框颜色
            .setAudioShadowColor(COLOR_40000000) // 音频阴影颜色
            .setAudioTitleTextFontColor(COLOR_FFE0E0E0) // 音频标题文本颜色
            .setAudioTypeTextFontColor(COLOR_FFA0A0A0) // 音频类型文本颜色
            .setAudioButtonBackgroundColor(COLOR_FF2D2D2D) // 音频按钮背景颜色
            .setAudioButtonBorderColor(COLOR_FF404040) // 音频按钮边框颜色
            .setAudioButtonTextFontColor(COLOR_FFE0E0E0) // 音频按钮文本颜色

        // 视频主题
        this.videoTheme.setVideoBackgroundColor(COLOR_FF1E1E1E) // 视频背景颜色
            .setVideoBorderColor(COLOR_FF404040) // 视频边框颜色
            .setVideoTimeTextFontColor(COLOR_FFE0E0E0) // 视频时间文本颜色
            .setVideoReleaseButtonBackgroundColor(COLOR_FF2D2D2D) // 视频释放按钮背景颜色
            .setVideoReleaseButtonTextFontColor(COLOR_FFE0E0E0) // 视频释放按钮文本颜色
            .setVideoDownloadButtonBackgroundColor(COLOR_FF2D2D2D) // 视频下载按钮背景颜色
            .setVideoDownloadButtonTextFontColor(COLOR_FFE0E0E0) // 视频下载按钮文本颜色

        // 脚注引用主题
        this.footnoteRefTheme.setFootnoteRefTextFontColor(COLOR_FF4A90E2) // 脚注引用文本颜色
            .setFootnoteRefTextDecorationColor(COLOR_FF4A90E2) // 脚注引用文本下划线颜色
            .setFootnoteRefTextBackgroundColor(COLOR_FF1E1E1E) // 脚注引用文本背景颜色

        // 行内代码主题
        this.inlineCodeTheme.setInlineCodeTextBackgroundColor(COLOR_FF252526) // 行内代码背景颜色

        // LaTeX数学公式主题
        this.latexMathTheme.setLatexMathDefaultTextFontColor(COLOR_FF4A90E2) // 数学公式未加载状态文本颜色
            .setLatexMathBackgroundColor(COLOR_TRANSPARENT) // 数学公式背景颜色
            .setLatexMathTextColor(COLOR_FFE0E0E0) // 数学公式文本颜色

        // HTML下划线主题
        this.htmlUnderlineTheme.setHtmlUnderlineTextDecorationColor(COLOR_FFE0E0E0) // HTML下划线文本下划线颜色

        // 图片主题
        this.imageTheme.setImageBorderColor(COLOR_FF404040) // 图片边框颜色
            .setImageDownloadButtonBackgroundColor(COLOR_FF2D2D2D) // 图片下载按钮背景颜色
            .setImageDownloadButtonTextFontColor(COLOR_FFE0E0E0) // 图片下载按钮文本颜色

        // 链接主题
        this.linkTheme.setLinkTextFontColor(COLOR_FF4A90E2) // 链接文本颜色
            .setLinkTextDecorationColor(COLOR_FF4A90E2) // 链接文本下划线颜色
            .setLinkTextBackgroundColor(COLOR_TRANSPARENT) // 链接文本背景颜色
            .setLinkCircleIconBackgroundColor(COLOR_TRANSPARENT) // 链接圆形图标背景颜色
            .setLinkCircleIconButtonBackgroundColor(COLOR_FF2D2D2D) // 链接圆形图标按钮背景颜色
            .setLinkCircleIconTextColor(COLOR_FFE0E0E0) // 链接圆形图标按钮文本颜色
            .setLinkRectIconBackgroundColor(COLOR_TRANSPARENT) // 链接方形图标背景颜色
            .setLinkRectIconButtonBackgroundColor(COLOR_FF2D2D2D) // 链接方形图标按钮背景颜色
            .setLinkRectIconTextColor(COLOR_FFE0E0E0) // 链接方形图标按钮文本颜色
            .setLinkRectToolIconBackgroundColor(COLOR_TRANSPARENT) // 链接方形图标工具按钮背景颜色
            .setLinkRectToolIconButtonBackgroundColor(COLOR_FF2D2D2D) // 链接方形图标工具图标按钮背景颜色

        // 删除线主题
        this.strikethroughTheme.setStrikethroughTextDecorationColor(COLOR_FF404040) // 删除线文本装饰线颜色

        // 高亮主题
        this.highlightTheme.setHighlightTextBackgroundColor(COLOR_FF6E6000) // 高亮文本背景颜色

        // 代码高亮主题
        this.prismTheme = PrismThemeDarcula.create() // 代码高亮主题

        return this
    }

    /**
     * 设置全局样式
     *
     * @param globalTheme 全局样式 - 默认GlobalTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setGlobalTheme(globalTheme: GlobalTheme): MarkdownThemeBuilder {
        this.globalTheme = globalTheme
        return this
    }

    /**
     * 设置段落样式
     *
     * @param paragraphTheme 段落样式 - 默认ParagraphTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTheme(paragraphTheme: ParagraphTheme): MarkdownThemeBuilder {
        this.paragraphTheme = paragraphTheme
        return this
    }

    /**
     * 设置标题样式
     *
     * @param headingTheme 标题样式 - 默认HeadingTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTheme(headingTheme: HeadingTheme): MarkdownThemeBuilder {
        this.headingTheme = headingTheme
        return this
    }

    /**
     * 设置表格样式
     *
     * @param tableTheme 表格样式 - 默认TableTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableTheme(tableTheme: TableTheme): MarkdownThemeBuilder {
        this.tableTheme = tableTheme
        return this
    }

    /**
     * 设置分割线样式
     *
     * @param dividerTheme 分割线样式 - 默认DividerTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setDividerTheme(dividerTheme: DividerTheme): MarkdownThemeBuilder {
        this.dividerTheme = dividerTheme
        return this
    }

    /**
     * 设置块引用样式
     *
     * @param blockQuoteTheme 块引用样式 - 默认BlockQuoteTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockQuoteTheme(blockQuoteTheme: BlockQuoteTheme): MarkdownThemeBuilder {
        this.blockQuoteTheme = blockQuoteTheme
        return this
    }

    /**
     * 设置有序列表样式
     *
     * @param orderedListTheme 有序列表样式 - 默认OrderedListTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setOrderedListTheme(orderedListTheme: OrderedListTheme): MarkdownThemeBuilder {
        this.orderedListTheme = orderedListTheme
        return this
    }

    /**
     * 设置无序/任务列表样式
     *
     * @param bulletListTheme 无序/任务列表样式 - 默认BulletListTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBulletListTheme(bulletListTheme: BulletListTheme): MarkdownThemeBuilder {
        this.bulletListTheme = bulletListTheme
        return this
    }

    /**
     * 设置定义列表样式
     *
     * @param definitionListTheme 定义列表样式 - 默认DefinitionListTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setDefinitionListTheme(definitionListTheme: DefinitionListTheme): MarkdownThemeBuilder {
        this.definitionListTheme = definitionListTheme
        return this
    }

    /**
     * 设置代码块样式
     *
     * @param codeBlockTheme 代码块样式 - 默认CodeBlockTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTheme(codeBlockTheme: CodeBlockTheme): MarkdownThemeBuilder {
        this.codeBlockTheme = codeBlockTheme
        return this
    }

    /**
     * 设置音频样式
     *
     * @param audioTheme 音频样式 - 默认AudioTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioTheme(audioTheme: AudioTheme): MarkdownThemeBuilder {
        this.audioTheme = audioTheme
        return this
    }

    /**
     * 设置视频样式
     *
     * @param videoTheme 视频样式 - 默认VideoTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoTheme(videoTheme: VideoTheme): MarkdownThemeBuilder {
        this.videoTheme = videoTheme
        return this
    }

    /**
     * 设置banner样式
     *
     * @param bannerTheme banner样式 - 默认BannerTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBannerTheme(bannerTheme: BannerTheme): MarkdownThemeBuilder {
        this.bannerTheme = bannerTheme
        return this
    }

    /**
     * 设置脚注定义样式
     *
     * @param footnoteDefTheme 脚注定义样式 - 默认FootnoteDefTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setFootnoteDefTheme(footnoteDefTheme: FootnoteDefTheme): MarkdownThemeBuilder {
        this.footnoteDefTheme = footnoteDefTheme
        return this
    }

    /**
     * 设置脚注引用样式
     *
     * @param footnoteRefTheme 脚注引用样式 - 默认FootnoteRefTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setFootnoteRefTheme(footnoteRefTheme: FootnoteRefTheme): MarkdownThemeBuilder {
        this.footnoteRefTheme = footnoteRefTheme
        return this
    }

    /**
     * 设置内联代码样式
     *
     * @param inlineCodeTheme 内联代码样式 - 默认InlineCodeTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setInlineCodeTheme(inlineCodeTheme: InlineCodeTheme): MarkdownThemeBuilder {
        this.inlineCodeTheme = inlineCodeTheme
        return this
    }

    /**
     * 设置加粗文本样式
     *
     * @param boldTheme 加粗文本样式 - 默认BoldTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBoldTheme(boldTheme: BoldTheme): MarkdownThemeBuilder {
        this.boldTheme = boldTheme
        return this
    }

    /**
     * 设置数学公式样式
     *
     * @param latexMathTheme 数学公式样式 - 默认FormulaTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathTheme(latexMathTheme: LatexMathTheme): MarkdownThemeBuilder {
        this.latexMathTheme = latexMathTheme
        return this
    }

    /**
     * 设置HTML下划线文本样式
     *
     * @param htmlUnderlineTheme HTML下划线文本样式 - 默认HtmlUnderlineTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHtmlUnderlineTheme(htmlUnderlineTheme: HtmlUnderlineTheme): MarkdownThemeBuilder {
        this.htmlUnderlineTheme = htmlUnderlineTheme
        return this
    }

    /**
     * 设置图片样式
     *
     * @param imageTheme 图片样式 - 默认ImageTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageTheme(imageTheme: ImageTheme): MarkdownThemeBuilder {
        this.imageTheme = imageTheme
        return this
    }

    /**
     * 设置斜体文本样式
     *
     * @param italicTheme 斜体文本样式 - 默认ItalicTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setItalicTheme(italicTheme: ItalicTheme): MarkdownThemeBuilder {
        this.italicTheme = italicTheme
        return this
    }

    /**
     * 设置链接文本样式
     *
     * @param linkTheme 链接文本样式 - 默认LinkTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkTheme(linkTheme: LinkTheme): MarkdownThemeBuilder {
        this.linkTheme = linkTheme
        return this
    }

    /**
     * 设置删除线文本样式
     *
     * @param strikethroughTheme 删除线文本样式 - 默认StrikethroughTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setStrikethroughTheme(strikethroughTheme: StrikethroughTheme): MarkdownThemeBuilder {
        this.strikethroughTheme = strikethroughTheme
        return this
    }

    /**
     * 设置高亮样式
     *
     * @param highlightTheme 高亮样式 - 默认HighlightTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHighlightTheme(highlightTheme: HighlightTheme): MarkdownThemeBuilder {
        this.highlightTheme = highlightTheme
        return this
    }

    /**
     * 设置下标文本样式
     *
     * @param subTheme 下标文本样式 - 默认SubTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setSubTheme(subTheme: SubTheme): MarkdownThemeBuilder {
        this.subTheme = subTheme
        return this
    }

    /**
     * 设置上标文本样式
     *
     * @param supTheme 上标文本样式 - 默认SupTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setSupTheme(supTheme: SupTheme): MarkdownThemeBuilder {
        this.supTheme = supTheme
        return this
    }

    /**
     * 设置markdown代码高亮样式
     *
     * @param PrismTheme markdown代码高亮样式 - 默认PrismThemeDefault.create()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setPrismTheme(prismTheme: PrismTheme): MarkdownThemeBuilder {
        this.prismTheme = prismTheme
        return this
    }

    /**
     * 设置markdown上下文 - 互操作
     *
     * @param stageContext markdown上下文 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用GlobalTheme.setStageContext方法代替", since: "1.4.0"]
    public func setStageContext(stageContext: StageContext): MarkdownThemeBuilder {
        this.globalTheme.stageContext = stageContext
        return this
    }

    /**
     * 设置markdown上下文 - 仓颉
     *
     * @param uiAbilityContext markdown上下文 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用GlobalTheme.setUiAbilityContext方法代替", since: "1.4.0"]
    public func setUIAbilityContext(uiAbilityContext: UIAbilityContext): MarkdownThemeBuilder {
        this.globalTheme.uiAbilityContext = uiAbilityContext
        return this
    }

    /**
     * 设置markdown是否同步解析
     *
     * @param isMarkdownParserSync markdown是否同步解析 - 默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用GlobalTheme.setIsMarkdownParserSync方法代替", since: "1.4.0"]
    public func setIsMarkdownParserSync(isMarkdownParserSync: Bool): MarkdownThemeBuilder {
        this.globalTheme.isMarkdownParserSync = isMarkdownParserSync
        return this
    }

    /**
     * 设置是否打开长按复制粘贴
     *
     * @param isOnCopy 是否打开长按复制粘贴 - 默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用GlobalTheme.setIsOnCopy方法代替", since: "1.4.0"]
    public func setIsOnCopy(isOnCopy: Bool): MarkdownThemeBuilder {
        this.globalTheme.isOnCopy = isOnCopy
        return this
    }

    /**
     * 设置markdown第一个模块上边距
     *
     * @param blockFirstTopMargin markdown第一个模块上边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用GlobalTheme.setMargin方法代替", since: "1.4.0"]
    public func setBlockFirstTopMargin(blockFirstTopMargin: Float64): MarkdownThemeBuilder {
        this.globalTheme.blockMarginTop = blockFirstTopMargin
        return this
    }

    /**
     * 设置markdown最后一个模块下边距
     *
     * @param blockLastBottomMargin markdown最后一个模块下边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用GlobalTheme.setMargin方法代替", since: "1.4.0"]
    public func setBlockLastBottomMargin(blockLastBottomMargin: Float64): MarkdownThemeBuilder {
        this.globalTheme.blockMarginBottom = blockLastBottomMargin
        return this
    }

    /**
     * 设置模块间上下间距
     *
     * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用GlobalTheme.setMarkdownBlockSpacing方法代替", since: "1.4.0"]
    public func setBlockTopAndBottomMargins(blockTopAndBottomMargins: Float64): MarkdownThemeBuilder {
        this.globalTheme.markdownBlockSpacing = Int64(blockTopAndBottomMargins)
        return this
    }

    /**
     * 设置软换行是否换行
     *
     * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用GlobalTheme.setIsLineBreak方法代替", since: "1.4.0"]
    public func setIsLineBreak(isLineBreak: Bool): MarkdownThemeBuilder {
        this.globalTheme.isLineBreak = isLineBreak
        return this
    }

    /**
     * 设置markdown是否支持滚动手势
     *
     * @param openGestureSwipe true-支持滚动手势，false-不支持滚动手势，默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用GlobalTheme.setOpenGestureSwipe方法代替", since: "1.4.0"]
    public func setOpenGestureSwipe(openGestureSwipe: Bool): MarkdownThemeBuilder {
        this.globalTheme.openGestureSwipe = openGestureSwipe
        return this
    }

    /**
     * 设置链接是否是图片显示
     *
     * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkIsIcon方法代替", since: "1.4.0"]
    public func setIsLinkStyle(isLinkStyle: Bool): MarkdownThemeBuilder {
        this.linkTheme.linkIsIcon = isLinkStyle
        return this
    }

    /**
     * 设置列表中的单行链接是否是图片显示
     *
     * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true:图片显示;false:文本显示。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkListIsIcon方法代替", since: "1.4.0"]
    public func setIsListLinkStyle(isListLinkStyle: Bool): MarkdownThemeBuilder {
        this.linkTheme.linkListIsIcon = isListLinkStyle
        return this
    }

    /**
     * 设置文本格式链接文本颜色
     *
     * @param linkColor 文本格式链接文本颜色 - 默认Color.RED
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkTextFontColor方法代替", since: "1.4.0"]
    public func setLinkColor(linkColor: Color): MarkdownThemeBuilder {
        this.linkTheme.linkTextFontColor = linkColor
        return this
    }

    /**
     * 设置是否按照链接文本字体大小显示文本
     *
     * @param isLinkSize 是否按照链接文本字体大小显示文本 - true:显示链接字体文本大小;false:跟随标题段落大小显示。默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkTextFontSize方法代替", since: "1.4.0"]
    public func setIsLinkSize(isLinkSize: Bool): MarkdownThemeBuilder {
        if (isLinkSize) {
            if (this.linkTheme.linkTextFontSize.isNone()) {
                this.linkTheme.linkTextFontSize = 14.0
            }
        } else {
            this.linkTheme.linkTextFontSize = None
        }
        return this
    }

    /**
     * 设置文本格式链接文本大小
     *
     * @param linkSize 文本格式链接文本大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkTextFontSize方法代替", since: "1.4.0"]
    public func setLinkSize(linkSize: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkTextFontSize = linkSize
        return this
    }

    /**
     * 设置文本格式链接文本行高
     *
     * @param linkLineHeight 文本格式链接文本行高
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkTextLineHeight方法代替", since: "1.4.0"]
    public func setLinkLineHeight(linkLineHeight: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkTextLineHeight = linkLineHeight
        return this
    }

    /**
     * 设置文本格式链接背景颜色
     *
     * @param linkBackgroundColor 文本格式链接背景颜色 - 默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkTextBackgroundColor方法代替", since: "1.4.0"]
    public func setLinkBackgroundColor(linkBackgroundColor: Color): MarkdownThemeBuilder {
        this.linkTheme.linkTextBackgroundColor = linkBackgroundColor
        return this
    }

    /**
     * 设置文本格式是否显示链接下划线
     *
     * @param isLinkUnderlined 文本格式是否显示链接下划线 - true:显示下划线;false:不显示下划线。默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkTextDecorationType方法代替", since: "1.4.0"]
    public func setIsLinkUnderlined(isLinkUnderlined: Bool): MarkdownThemeBuilder {
        if (!isLinkUnderlined) {
            this.linkTheme.linkTextDecorationType = TextDecorationType.None
        }
        return this
    }

    /**
     * 设置圆形图片格式链接主题背景颜色
     *
     * @param linkCircleImageBackgroundColor 圆形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkCircleIconBackgroundColor方法代替", since: "1.4.0"]
    public func setLinkCircleImageBackgroundColor(linkCircleImageBackgroundColor: Color): MarkdownThemeBuilder {
        this.linkTheme.linkCircleIconBackgroundColor = linkCircleImageBackgroundColor
        return this
    }

    /**
     * 设置圆形图片格式链接控件背景颜色
     *
     * @param linkCircleImageButtonBackgroundColor 圆形图片格式链接控件背景颜色 - 默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkCircleIconButtonBackgroundColor方法代替", since: "1.4.0"]
    public func setLinkCircleImageButtonBackgroundColor(linkCircleImageButtonBackgroundColor: Color): MarkdownThemeBuilder {
        this.linkTheme.linkCircleIconButtonBackgroundColor = linkCircleImageButtonBackgroundColor
        return this
    }

    /**
     * 设置圆形图片格式链接文本大小
     *
     * @param linkCircleImageTextSize 圆形图片格式链接文本大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkCircleIconTextSize方法代替", since: "1.4.0"]
    public func setLinkCircleImageTextSize(linkCircleImageTextSize: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkCircleIconTextSize = linkCircleImageTextSize
        return this
    }

    /**
     * 设置圆形图片格式链接文本颜色
     *
     * @param linkCircleImageTextColor 圆形图片格式链接文本颜色 - 默认Color.WHITE
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkCircleIconTextColor方法代替", since: "1.4.0"]
    public func setLinkCircleImageTextColor(linkCircleImageTextColor: Color): MarkdownThemeBuilder {
        this.linkTheme.linkCircleIconTextColor = linkCircleImageTextColor
        return this
    }

    /**
     * 设置圆形图片格式链接半径
     *
     * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkCircleIconRadius方法代替", since: "1.4.0"]
    public func setLinkCircleImageRadius(linkCircleImageRadius: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkCircleIconRadius = linkCircleImageRadius
        return this
    }

    /**
     * 设置圆形图片格式链接左右外边距
     *
     * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkCircleIconMargin方法代替", since: "1.4.0"]
    public func setLinkCircleImageMargin(linkCircleImageMargin: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkCircleIconMargin = linkCircleImageMargin
        return this
    }

    /**
     * 设置圆角矩形图片格式链接主题背景颜色
     *
     * @param linkRectImageBackgroundColor 圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectIconBackgroundColor方法代替", since: "1.4.0"]
    public func setLinkRectImageBackgroundColor(linkRectImageBackgroundColor: Color): MarkdownThemeBuilder {
        this.linkTheme.linkRectIconBackgroundColor = linkRectImageBackgroundColor
        return this
    }

    /**
     * 设置圆角矩形图片格式链接控件背景颜色
     *
     * @param linkRectImageButtonBackgroundColor 圆角矩形图片格式链接控件背景颜色 - 默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectIconButtonBackgroundColor方法代替", since: "1.4.0"]
    public func setLinkRectImageButtonBackgroundColor(linkRectImageButtonBackgroundColor: Color): MarkdownThemeBuilder {
        this.linkTheme.linkRectIconButtonBackgroundColor = linkRectImageButtonBackgroundColor
        return this
    }

    /**
     * 圆角矩形图片格式链接文本大小
     *
     * @param linkRectImageTextSize 圆角矩形图片格式链接文本大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectIconTextSize方法代替", since: "1.4.0"]
    public func setLinkRectImageTextSize(linkRectImageTextSize: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkRectIconTextSize = linkRectImageTextSize
        return this
    }

    /**
     * 设置圆角矩形图片格式链接文本颜色
     *
     * @param linkRectImageTextColor 圆角矩形图片格式链接文本颜色 - 默认Color.WHITE
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectIconTextColor方法代替", since: "1.4.0"]
    public func setLinkRectImageTextColor(linkRectImageTextColor: Color): MarkdownThemeBuilder {
        this.linkTheme.linkRectIconTextColor = linkRectImageTextColor
        return this
    }

    /**
     * 圆角矩形图片格式链接控件高度
     *
     * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectIconHeight方法代替", since: "1.4.0"]
    public func setLinkRectImageHeight(linkRectImageHeight: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkRectIconHeight = linkRectImageHeight
        return this
    }

    /**
     * 圆角矩形图片格式链接左右内边距
     *
     * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectIconPadding方法代替", since: "1.4.0"]
    public func setLinkRectImagePadding(linkRectImagePadding: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkRectIconPadding = linkRectImagePadding
        return this
    }

    /**
     * 圆角矩形图片格式链接圆角半径
     *
     * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectIconRadius方法代替", since: "1.4.0"]
    public func setLinkRectImageRadius(linkRectImageRadius: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkRectIconRadius = linkRectImageRadius
        return this
    }

    /**
     * 圆角矩形图片格式链接左右外边距
     *
     * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectIconMargin方法代替", since: "1.4.0"]
    public func setLinkRectImageMargin(linkRectImageMargin: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkRectIconMargin = linkRectImageMargin
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接主题背景颜色
     *
     * @param linkRectToolImageBackgroundColor 空心圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectToolIconBackgroundColor方法代替", since: "1.4.0"]
    public func setLinkRectToolImageBackgroundColor(linkRectToolImageBackgroundColor: Color): MarkdownThemeBuilder {
        this.linkTheme.linkRectToolIconBackgroundColor = linkRectToolImageBackgroundColor
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接控件背景颜色
     *
     * @param linkRectToolImageButtonBackgroundColor 空心圆角矩形图片格式链接控件背景颜色 - 默认Color.WHITE
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectToolIconButtonBackgroundColor方法代替", since: "1.4.0"]
    public func setLinkRectToolImageButtonBackgroundColor(linkRectToolImageButtonBackgroundColor: Color): MarkdownThemeBuilder {
        this.linkTheme.linkRectToolIconButtonBackgroundColor = linkRectToolImageButtonBackgroundColor
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接文本大小
     *
     * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文本大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectToolIconTextSize方法代替", since: "1.4.0"]
    public func setLinkRectToolImageTextSize(linkRectToolImageTextSize: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkRectToolIconTextSize = linkRectToolImageTextSize
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接控件高度
     *
     * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectToolIconHeight方法代替", since: "1.4.0"]
    public func setLinkRectToolImageHeight(linkRectToolImageHeight: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkRectToolIconHeight = linkRectToolImageHeight
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接左右内边距
     *
     * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectToolIconPadding方法代替", since: "1.4.0"]
    public func setLinkRectToolImagePadding(linkRectToolImagePadding: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkRectToolIconPadding = linkRectToolImagePadding
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接边框宽度
     *
     * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectToolIconBorderWidth方法代替", since: "1.4.0"]
    public func setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkRectToolIconBorderWidth = linkRectToolImageBorderWidth
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接分割线宽度
     *
     * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectToolIconDividingLineWidth方法代替", since: "1.4.0"]
    public func setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkRectToolIconDividingLineWidth = linkRectToolImageDividingLineWidth
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接左右外边距
     *
     * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectToolIconMargin方法代替", since: "1.4.0"]
    public func setLinkRectToolImageMargin(linkRectToolImageMargin: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkRectToolIconMargin = linkRectToolImageMargin
        return this
    }

    /**
     * 设置空心圆角矩形图片格式分割线和文本左边距
     *
     * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectToolIconLineLeftPadding方法代替", since: "1.4.0"]
    public func setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkRectToolIconLineLeftPadding = linkRectToolImageLineLeftPadding
        return this
    }

    /**
     * 设置空心圆角矩形图片格式分割线和文本右边距
     *
     * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LinkTheme.setLinkRectToolIconLineRightPadding方法代替", since: "1.4.0"]
    public func setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: Float64): MarkdownThemeBuilder {
        this.linkTheme.linkRectToolIconLineRightPadding = linkRectToolImageLineRightPadding
        return this
    }

    /**
     * 设置块引用左边距
     *
     * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用BlockQuoteTheme.setBlockQuoteMargin方法代替", since: "1.4.0"]
    public func setBlockQuoteLeftMargin(blockQuoteLeftMargin: Float64): MarkdownThemeBuilder {
        this.blockQuoteTheme.blockQuoteMarginLeft = blockQuoteLeftMargin
        return this
    }

    /**
     * 设置块引用右边距
     *
     * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用BlockQuoteTheme.setBlockQuoteMargin方法代替", since: "1.4.0"]
    public func setBlockQuoteRightMargin(blockQuoteRightMargin: Float64): MarkdownThemeBuilder {
        this.blockQuoteTheme.blockQuoteMarginRight = blockQuoteRightMargin
        return this
    }

    /**
     * 设置块引用左边线条宽度
     *
     * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用BlockQuoteTheme.setBlockQuoteLeftBorderWidth方法代替", since: "1.4.0"]
    public func setBlockQuoteWidth(blockQuoteWidth: Float64): MarkdownThemeBuilder {
        this.blockQuoteTheme.blockQuoteLeftBorderWidth = blockQuoteWidth
        return this
    }

    /**
     * 设置块引用左边线条颜色
     *
     * @param blockQuoteColor 块引用左边线条颜色 - 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用BlockQuoteTheme.setBlockQuoteLeftBorderColor方法代替", since: "1.4.0"]
    public func setBlockQuoteColor(blockQuoteColor: Color): MarkdownThemeBuilder {
        this.blockQuoteTheme.blockQuoteLeftBorderColor = blockQuoteColor
        return this
    }

    /**
     * 设置块引用背景颜色
     *
     * @param blockQuoteBackgroundColor 块引用背景颜色 - 默认0xFFEAEAEA
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用BlockQuoteTheme.setBlockQuoteBackgroundColor方法代替", since: "1.4.0"]
    public func setBlockQuoteBackgroundColor(blockQuoteBackgroundColor: Color): MarkdownThemeBuilder {
        this.blockQuoteTheme.blockQuoteBackgroundColor = blockQuoteBackgroundColor
        return this
    }

    /**
     * 设置块引用子模块上下间距
     *
     * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用BlockQuoteTheme.setBlockQuoteChildSpacing方法代替", since: "1.4.0"]
    public func setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: Float64): MarkdownThemeBuilder {
        this.blockQuoteTheme.blockQuoteChildSpacing = Int64(blockQuoteTopAndBottomMargins)
        return this
    }

    /**
     * 设置有序列表、无序列表、任务列表子模块上下间距
     *
     * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用OrderedListTheme.setOrderedListChildSpacing和BulletListTheme.setBulletListChildSpacing方法代替", since: "1.4.0"]
    public func setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: Float64): MarkdownThemeBuilder {
        this.orderedListTheme.orderedListChildSpacing = Int64(blockOrderedAndBulletTopAndBottomMargins)
        this.bulletListTheme.bulletListChildSpacing = Int64(blockOrderedAndBulletTopAndBottomMargins)
        return this
    }

    /**
     * 设置有序列表、无序列表、任务列表左边距
     *
     * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用OrderedListTheme.setOrderedListMargin和BulletListTheme.setBulletListMargin方法代替", since: "1.4.0"]
    public func setBlockLeftMargin(blockLeftMargin: Float64): MarkdownThemeBuilder {
        this.orderedListTheme.orderedListMarginLeft = blockLeftMargin
        this.bulletListTheme.bulletListMarginLeft = blockLeftMargin
        return this
    }

    /**
     * 设置有序列表、无序列表、任务列表右边距
     *
     * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用OrderedListTheme.setOrderedListMargin和BulletListTheme.setBulletListMargin方法代替", since: "1.4.0"]
    public func setBlockRightMargin(blockRightMargin: Float64): MarkdownThemeBuilder {
        this.orderedListTheme.orderedListMarginRight = blockRightMargin
        this.bulletListTheme.bulletListMarginRight = blockRightMargin
        return this
    }

    /**
     * 设置有序列表前缀文本是否加粗
     *
     * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true:加粗;false:不加粗。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用OrderedListTheme.setOrderedListMarkerTextFontWeight方法代替", since: "1.4.0"]
    public func setOrderedListItemPrefixBold(orderedListItemPrefixBold: Bool): MarkdownThemeBuilder {
        if (orderedListItemPrefixBold) {
            this.orderedListTheme.orderedListMarkerTextFontWeight = FontWeight.W600
        }
        return this
    }

    /**
     * 设置有序列表前缀文本颜色
     *
     * @param orderedListItemColor 有序列表前缀文本颜色 - 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用OrderedListTheme.setOrderedListMarkerTextFontColor方法代替", since: "1.4.0"]
    public func setOrderedListItemColor(orderedListItemColor: Color): MarkdownThemeBuilder {
        this.orderedListTheme.orderedListMarkerTextFontColor = orderedListItemColor
        return this
    }

    /**
     * 设置有序列表前缀文本大小
     *
     * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用OrderedListTheme.setOrderedListMarkerTextFontSize方法代替", since: "1.4.0"]
    public func setOrderedListItemSize(orderedListItemSize: Float64): MarkdownThemeBuilder {
        this.orderedListTheme.orderedListMarkerTextFontSize = orderedListItemSize
        return this
    }

    /**
     * 设置有序列表前缀文本行高
     *
     * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用OrderedListTheme.setOrderedListMarkerTextLineHeight方法代替", since: "1.4.0"]
    public func setOrderedListItemLineHeight(orderedListItemLineHeight: Float64): MarkdownThemeBuilder {
        this.orderedListTheme.orderedListMarkerTextLineHeight = orderedListItemLineHeight
        return this
    }

    /**
     * 设置无序列表前缀是否为实心圆型
     *
     * @param bulletListItemCircle 无序列表前缀是否为实心圆型 - 默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用BulletListTheme.setBulletListBulletIsCircle方法代替", since: "1.4.0"]
    public func setBulletListItemCircle(bulletListItemCircle: Bool): MarkdownThemeBuilder {
        this.bulletListTheme.bulletListBulletIsCircle = bulletListItemCircle
        return this
    }

    /**
     * 设置无序列表前缀文本颜色
     *
     * @param bulletListItemColor 无序列表前缀文本颜色 - 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用BulletListTheme.setBulletListBulletTextFontColor方法代替", since: "1.4.0"]
    public func setBulletListItemColor(bulletListItemColor: Color): MarkdownThemeBuilder {
        this.bulletListTheme.bulletListBulletTextFontColor = bulletListItemColor
        return this
    }

    /**
     * 设置无序列表前缀文本大小
     *
     * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用BulletListTheme.setBulletListBulletTextFontSize方法代替", since: "1.4.0"]
    public func setBulletListItemSize(bulletListItemSize: Float64): MarkdownThemeBuilder {
        this.bulletListTheme.bulletListBulletTextFontSize = bulletListItemSize
        return this
    }

    /**
     * 设置无序列表前缀文本行高
     *
     * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用BulletListTheme.setBulletListBulletTextLineHeight方法代替", since: "1.4.0"]
    public func setBulletListItemLineHeight(bulletListItemLineHeight: Float64): MarkdownThemeBuilder {
        this.bulletListTheme.bulletListBulletTextLineHeight = bulletListItemLineHeight
        return this
    }

    /**
     * 设置任务列表选择框宽高
     *
     * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用BulletListTheme.setBulletListCheckboxWidth和setBulletListCheckboxHeight方法代替", since: "1.4.0"]
    public func setTaskListItemLength(taskListItemLength: Float64): MarkdownThemeBuilder {
        this.bulletListTheme.bulletListCheckboxWidth = taskListItemLength
        this.bulletListTheme.bulletListCheckboxHeight = taskListItemLength
        return this
    }

    /**
     * 设置内联代码文本颜色
     *
     * @param codeTextColor 内联代码文本颜色 - 默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用InlineCodeTheme.setInlineCodeTextFontColor方法代替", since: "1.4.0"]
    public func setCodeTextColor(codeTextColor: Color): MarkdownThemeBuilder {
        this.inlineCodeTheme.inlineCodeTextFontColor = codeTextColor
        return this
    }

    /**
     * 设置内联代码背景颜色
     *
     * @param codeBackgroundColor 内联代码背景颜色 - 默认0xFFEAEAEA
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用InlineCodeTheme.setInlineCodeTextBackgroundColor方法代替", since: "1.4.0"]
    public func setCodeBackgroundColor(codeBackgroundColor: Color): MarkdownThemeBuilder {
        this.inlineCodeTheme.inlineCodeTextBackgroundColor = codeBackgroundColor
        return this
    }

    /**
     * 设置内联代码文本大小
     *
     * @param codeTextSize 内联代码文本大小 - 默认13.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用InlineCodeTheme.setInlineCodeTextFontSize方法代替", since: "1.4.0"]
    public func setCodeTextSize(codeTextSize: Float64): MarkdownThemeBuilder {
        this.inlineCodeTheme.inlineCodeTextFontSize = codeTextSize
        return this
    }

    /**
     * 设置内联代码文本字体
     *
     * @param codeTypeface 内联代码文本字体 - 默认"HarmonyOS Sans"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用InlineCodeTheme.setInlineCodeTextFontFamily方法代替", since: "1.4.0"]
    public func setCodeTypeface(codeTypeface: String): MarkdownThemeBuilder {
       this.inlineCodeTheme.inlineCodeTextFontFamily = codeTypeface
        return this
    }

    /**
     * 设置是否格式化代码块内容
     *
     * @param isCodeFormat 是否格式化代码块内容 - true:格式化代码块;false:不格式化代码块。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockIsCodeFormat方法代替", since: "1.4.0"]
    public func setIsCodeFormat(isCodeFormat: Bool): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockIsCodeFormat = isCodeFormat
        return this
    }

    /**
     * 设置codeformat是否用制表符
     *
     * @param useTab true-使用,false-不使用,默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockUseTab方法代替", since: "1.4.0"]
    public func setUseTab(useTab: Bool): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockUseTab = useTab
        return this
    }

    /**
     * 设置codeformat空格缩进数量
     *
     * @param indentWidth 空格缩进数量,默认4空格
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockIndentWidth方法代替", since: "1.4.0"]
    public func setIndentWidth(indentWidth: Int64): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockIndentWidth = indentWidth
        return this
    }

    /**
     * 设置围栏代码块代码高亮是否同步解析
     *
     * @param isCodeBlockParserSync 围栏代码块代码高亮是否同步解析 - 默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockParserSync方法代替", since: "1.4.0"]
    public func setIsCodeBlockParserSync(isCodeBlockParserSync: Bool): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockParserSync = isCodeBlockParserSync
        return this
    }

    /**
     * 设置代码块代码类型文本颜色
     *
     * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockTypeTextFontColor方法代替", since: "1.4.0"]
    public func setCodeBlockTypeTextColor(codeBlockTypeTextColor: Color): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockTypeTextFontColor = codeBlockTypeTextColor
        return this
    }

    /**
     * 设置代码块代码类型文本
     *
     * @param codeBlockTypeTextStr 代码块代码类型文本 - 默认""
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockTypeText方法代替", since: "1.4.0"]
    public func setCodeBlockTypeTextStr(codeBlockTypeTextStr: String): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockTypeText = codeBlockTypeTextStr
        return this
    }

    /**
     * 设置代码类型和代码块距离
     *
     * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockTitleLayoutMarginBottom方法代替", since: "1.4.0"]
    public func setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: Float64): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockTitleLayoutMarginBottom = codeBlockTypeTextPadding
        return this
    }

    /**
     * 设置代码块复制、全屏图片文本是否显示
     *
     * @param codeBlockIconTextHide 代码块复制、全屏图片文本是否显示 - true:显示;false:不显示。默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockCopyTextIsShow和setCodeBlockFullScreenTextIsShow方法代替", since: "1.4.0"]
    public func setCodeBlockIconTextHide(codeBlockIconTextHide: Bool): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockCopyTextIsShow = codeBlockIconTextHide
        this.codeBlockTheme.codeBlockFullScreenTextIsShow = codeBlockIconTextHide
        return this
    }

    /**
     * 设置代码块代码行号是否显示
     *
     * @param codeBlockLineNumberHide 代码块代码行号是否显示 - true:显示;false:不显示。默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockLineNumberIsShow方法代替", since: "1.4.0"]
    public func setCodeBlockLineNumberHide(codeBlockLineNumberHide: Bool): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockLineNumberIsShow = codeBlockLineNumberHide
        return this
    }

    /**
     * 设置代码块背景颜色
     *
     * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockBackgroundColor方法代替", since: "1.4.0"]
    public func setCodeBlockBackgroundColor(codeBlockBackgroundColor: Color): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockBackgroundColor = codeBlockBackgroundColor
        return this
    }

    /**
     * 设置代码块左边距
     *
     * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setPadding方法代替", since: "1.4.0"]
    public func setCodeMultilineMargin(codeMultilineMargin: Float64): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockPaddingLeft = codeMultilineMargin
        return this
    }

    /**
     * 设置代码块右边距
     *
     * @param codeMultilineRightMargin 代码块右边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setPadding方法代替", since: "1.4.0"]
    public func setCodeMultilineRightMargin(codeMultilineRightMargin: Float64): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockPaddingRight = codeMultilineRightMargin
        return this
    }

    /**
     * 设置代码块代码文本颜色
     *
     * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockTextFontColor方法代替", since: "1.4.0"]
    public func setCodeBlockTextColor(codeBlockTextColor: Color): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockTextFontColor = codeBlockTextColor
        return this
    }

    /**
     * 设置代码块字体
     *
     * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockTextFontFamily方法代替", since: "1.4.0"]
    public func setCodeBlockTypeface(codeBlockTypeface: String): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockTextFontFamily = codeBlockTypeface
        return this
    }

    /**
     * 设置代码块代码文本大小
     *
     * @param codeBlockTextSize 代码块代码文本大小 -  默认13.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockTextFontSize方法代替", since: "1.4.0"]
    public func setCodeBlockTextSize(codeBlockTextSize: Float64): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockTextFontSize = codeBlockTextSize
        return this
    }

    /**
     * 设置代码块代码文本行高
     *
     * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockTextLineHeight方法代替", since: "1.4.0"]
    public func setCodeBlockLineHeight(codeBlockLineHeight: Float64): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockTextLineHeight = codeBlockLineHeight
        return this
    }

    /**
     * 设置代码块控件圆角大小
     *
     * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockRadius方法代替", since: "1.4.0"]
    public func setCodeBlockRadius(codeBlockRadius: Float64): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockRadiusTopLeft = codeBlockRadius
        this.codeBlockTheme.codeBlockRadiusTopRight = codeBlockRadius
        this.codeBlockTheme.codeBlockRadiusBottomLeft = codeBlockRadius
        this.codeBlockTheme.codeBlockRadiusBottomRight = codeBlockRadius
        return this
    }

    /**
     * 设置代码块代码全屏按钮是否显示
     *
     * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true:显示;false:不显示。默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockFullScreenButtonIsShow方法代替", since: "1.4.0"]
    public func setIsCodeFullScreen(isCodeFullScreen: Bool): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockFullScreenButtonIsShow = isCodeFullScreen
        return this
    }

    /**
     * 设置代码块代码全屏、代码复制按钮宽高
     *
     * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme相关set方法代替", since: "1.4.0"]
    public func setIconWidthAndHeight(iconWidthAndHeight: Float64): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockCopyIconWidth = iconWidthAndHeight
        this.codeBlockTheme.codeBlockCopyIconHeight = iconWidthAndHeight
        this.codeBlockTheme.codeBlockFullScreenIconWidth = iconWidthAndHeight
        this.codeBlockTheme.codeBlockFullScreenIconHeight = iconWidthAndHeight
        return this
    }

    /**
     * 设置代码块代码全屏按钮默认图标
     *
     * @param codeFullScreenIcon 代码块代码全屏按钮默认图标 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockFullScreenIcon方法代替", since: "1.4.0"]
    public func setCodeFullScreenIcon(codeFullScreenIcon: AppResource): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockFullScreenIcon = codeFullScreenIcon
        return this
    }

    /**
     * 设置代码块代码复制按钮默认图标
     *
     * @param codeCopyIcon 代码块代码复制按钮默认图标 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockCopyIcon方法代替", since: "1.4.0"]
    public func setCodeCopyIcon(codeCopyIcon: AppResource): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockCopyIcon = codeCopyIcon
        return this
    }

    /**
     * 设置组合代码未选中标题字体大小
     *
     * @param codeListTitleTextSize 组合代码未选中标题字体大小 - 默认13.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockListTitleTextSize方法代替", since: "1.4.0"]
    public func setCodeListTitleTextSize(codeListTitleTextSize: Float64): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockListTitleTextSize = codeListTitleTextSize
        return this
    }

    /**
     * 设置组合代码选中标题字体大小
     *
     * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockListTitleSelectTextSize方法代替", since: "1.4.0"]
    public func setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: Float64): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockListTitleSelectTextSize = codeListTitleSelectTextSize
        return this
    }

    /**
     * 设置组合代码选中标题文本颜色
     *
     * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认Color.RED
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockListTitleSelectTextColor方法代替", since: "1.4.0"]
    public func setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: Color): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockListTitleSelectTextColor = codeListTitleSelectTextColor
        return this
    }

    /**
     * 设置组合代码未选中标题文本颜色
     *
     * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockListTitleUnselectTextColor方法代替", since: "1.4.0"]
    public func setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: Color): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockListTitleUnselectTextColor = codeListTitleUnSelectTextColor
        return this
    }

    /**
     * 设置组合代码选中标题背景颜色
     *
     * @param codeListTitleSelectBackgroundColor 组合代码选中标题背景颜色 - 默认Color.GRAY
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockListTitleSelectBackgroundColor方法代替", since: "1.4.0"]
    public func setCodeListTitleSelectBackgroundColor(codeListTitleSelectBackgroundColor: Color): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockListTitleSelectBackgroundColor = codeListTitleSelectBackgroundColor
        return this
    }

    /**
     * 设置组合代码未选中标题背景颜色
     *
     * @param codeListTitleUnSelectBackgroundColor 组合代码未选中标题背景颜色 - 默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockListTitleUnselectBackgroundColor方法代替", since: "1.4.0"]
    public func setCodeListTitleUnSelectBackgroundColor(codeListTitleUnSelectBackgroundColor: Color): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockListTitleUnselectBackgroundColor = codeListTitleUnSelectBackgroundColor
        return this
    }

    /**
     * 设置是否单独代码块显示
     *
     * @param isSeparateCodeBlock 是否单独代码块显示 - true:显示;false:不显示。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockIsSeparate方法代替", since: "1.4.0"]
    public func setIsSeparateCodeBlock(isSeparateCodeBlock: Bool): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockIsSeparate = isSeparateCodeBlock
        return this
    }

    /**
     * 设置单独代码块行号宽度
     *
     * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockSeparateWidth方法代替", since: "1.4.0"]
    public func setSeparateCodeBlockWidth(separateCodeBlockWidth: Float64): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockSeparateWidth = separateCodeBlockWidth
        return this
    }

    /**
     * 设置单独代码块是否居底显示
     *
     * @param separateCodeIsBottom 单独代码块是否居底显示 - 默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用CodeBlockTheme.setCodeBlockSeparateIsBottom方法代替", since: "1.4.0"]
    public func setSeparateCodeIsBottom(separateCodeIsBottom: Bool): MarkdownThemeBuilder {
        this.codeBlockTheme.codeBlockSeparateIsBottom = separateCodeIsBottom
        return this
    }

    /**
     * 设置H1、H2标题下分割线高度
     *
     * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setUnderlineHeightForAllHeading方法代替", since: "1.4.0"]
    public func setHeadingBreakHeight(headingBreakHeight: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading1UnderlineHeight = headingBreakHeight
        this.headingTheme.heading2UnderlineHeight = headingBreakHeight
        return this
    }

    /**
     * 设置标题文本字体
     *
     * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextFontFamilyForAllHeading方法代替", since: "1.4.0"]
    public func setHeadingTypeface(headingTypeface: String): MarkdownThemeBuilder {
        this.headingTheme.heading1TextFontFamily = headingTypeface
        this.headingTheme.heading2TextFontFamily = headingTypeface
        this.headingTheme.heading3TextFontFamily = headingTypeface
        this.headingTheme.heading4TextFontFamily = headingTypeface
        this.headingTheme.heading5TextFontFamily = headingTypeface
        this.headingTheme.heading6TextFontFamily = headingTypeface
        return this
    }

    /**
     * 设置标题模块上间距
     *
     * @param headingTopMargins 标题模块上间距 - 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setMarginForAllHeading或setMarginForEachHeading方法代替", since: "1.4.0"]
    public func setHeadingTopMargins(headingTopMargins: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading1MarginTop = headingTopMargins
        this.headingTheme.heading2MarginTop = headingTopMargins
        this.headingTheme.heading3MarginTop = headingTopMargins
        this.headingTheme.heading4MarginTop = headingTopMargins
        this.headingTheme.heading5MarginTop = headingTopMargins
        this.headingTheme.heading6MarginTop = headingTopMargins
        return this
    }

    /**
     * 设置标题模块下间距
     *
     * @param headingBottomMargins 标题模块下间距 - 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setMarginForAllHeading或setMarginForEachHeading方法代替", since: "1.4.0"]
    public func setHeadingBottomMargins(headingBottomMargins: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading1MarginBottom = headingBottomMargins
        this.headingTheme.heading2MarginBottom = headingBottomMargins
        this.headingTheme.heading3MarginBottom = headingBottomMargins
        this.headingTheme.heading4MarginBottom = headingBottomMargins
        this.headingTheme.heading5MarginBottom = headingBottomMargins
        this.headingTheme.heading6MarginBottom = headingBottomMargins
        return this
    }

    /**
     * 设置标题文本大小数组
     *
     * @param headingTextSizeMultipliers 标题文本大小数组 - 默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextFontSizeForEachHeading方法代替", since: "1.4.0"]
    public func setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<Float64>): MarkdownThemeBuilder {
        this.headingTheme.heading1TextFontSize = headingTextSizeMultipliers[0]
        this.headingTheme.heading2TextFontSize = headingTextSizeMultipliers[1]
        this.headingTheme.heading3TextFontSize = headingTextSizeMultipliers[2]
        this.headingTheme.heading4TextFontSize = headingTextSizeMultipliers[3]
        this.headingTheme.heading5TextFontSize = headingTextSizeMultipliers[4]
        this.headingTheme.heading6TextFontSize = headingTextSizeMultipliers[5]
        return this
    }

    /**
     * 设置一级标题文本大小
     *
     * @param headingTextSize1 一级标题文本大小 - 默认20.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextFontSizeForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextSize1(headingTextSize1: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading1TextFontSize = headingTextSize1
        return this
    }

    /**
     * 设置二级标题文本大小
     *
     * @param headingTextSize2 二级标题文本大小 - 默认17.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextFontSizeForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextSize2(headingTextSize2: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading2TextFontSize = headingTextSize2
        return this
    }

    /**
     * 设置三级标题文本大小
     *
     * @param headingTextSize3 三级标题文本大小 - 默认16.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextFontSizeForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextSize3(headingTextSize3: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading3TextFontSize = headingTextSize3
        return this
    }

    /**
     * 设置四级标题文本大小
     *
     * @param headingTextSize4 四级标题文本大小 - 默认15.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextFontSizeForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextSize4(headingTextSize4: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading4TextFontSize = headingTextSize4
        return this
    }

    /**
     * 设置五级标题文本大小
     *
     * @param headingTextSize5 五级标题文本大小 - 默认15.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextFontSizeForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextSize5(headingTextSize5: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading5TextFontSize = headingTextSize5
        return this
    }

    /**
     * 设置六级标题文本大小
     *
     * @param headingTextSize6 六级标题文本大小 - 默认13.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextFontSizeForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextSize6(headingTextSize6: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading6TextFontSize = headingTextSize6
        return this
    }

    /**
     * 设置标题文本颜色
     *
     * @param headingTextColor 标题文本颜色 - 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextFontColorForAllHeading方法代替", since: "1.4.0"]
    public func setHeadingTextColor(headingTextColor: Color): MarkdownThemeBuilder {
        this.headingTheme.heading1TextFontColor = headingTextColor
        this.headingTheme.heading2TextFontColor = headingTextColor
        this.headingTheme.heading3TextFontColor = headingTextColor
        this.headingTheme.heading4TextFontColor = headingTextColor
        this.headingTheme.heading5TextFontColor = headingTextColor
        this.headingTheme.heading6TextFontColor = headingTextColor
        return this
    }

    /**
     * 设置H1、H2标题下分割线颜色
     *
     * @param headingBreakColor H1、H2标题下分割线颜色 - 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setUnderlineColorForAllHeading方法代替", since: "1.4.0"]
    public func setHeadingBreakColor(headingBreakColor: Color): MarkdownThemeBuilder {
        this.headingTheme.heading1UnderlineColor = headingBreakColor
        this.headingTheme.heading2UnderlineColor = headingBreakColor
        return this
    }

    /**
     * 设置一级标题文本颜色
     *
     * @param headingTextColor1 一级标题文本颜色
     */
    @Deprecated["用HeadingTheme.setTextFontColorForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextColor1(headingTextColor1: Color): MarkdownThemeBuilder {
        this.headingTheme.heading1TextFontColor = headingTextColor1
        return this
    }

    /**
     * 设置H1标题下分割线颜色
     *
     * @param headingBreakColor H1标题下分割线颜色 - 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setUnderlineColorForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingBreakColor1(headingBreakColor1: Color): MarkdownThemeBuilder {
        this.headingTheme.heading1UnderlineColor = headingBreakColor1
        return this
    }

    /**
     * 设置二级标题文本颜色
     *
     * @param headingTextColor2 二级标题文本颜色
     */
    @Deprecated["用HeadingTheme.setTextFontColorForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextColor2(headingTextColor2: Color): MarkdownThemeBuilder {
        this.headingTheme.heading2TextFontColor = headingTextColor2
        return this
    }

    /**
     * 设置H2标题下分割线颜色
     *
     * @param headingBreakColor2 H2标题下分割线颜色 - 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setUnderlineColorForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingBreakColor2(headingBreakColor2: Color): MarkdownThemeBuilder {
        this.headingTheme.heading2UnderlineColor = headingBreakColor2
        return this
    }

    /**
     * 设置三级标题文本颜色
     *
     * @param headingTextColor3 三级标题文本颜色
     */
    @Deprecated["用HeadingTheme.setTextFontColorForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextColor3(headingTextColor3: Color): MarkdownThemeBuilder {
        this.headingTheme.heading3TextFontColor = headingTextColor3
        return this
    }

    /**
     * 设置四级标题文本颜色
     *
     * @param headingTextColor4 四级标题文本颜色
     */
    @Deprecated["用HeadingTheme.setTextFontColorForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextColor4(headingTextColor4: Color): MarkdownThemeBuilder {
        this.headingTheme.heading4TextFontColor = headingTextColor4
        return this
    }

    /**
     * 设置五级标题文本颜色
     *
     * @param headingTextColor5 五级标题文本颜色
     */
    @Deprecated["用HeadingTheme.setTextFontColorForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextColor5(headingTextColor5: Color): MarkdownThemeBuilder {
        this.headingTheme.heading5TextFontColor = headingTextColor5
        return this
    }

    /**
     * 设置六级标题文本颜色
     *
     * @param headingTextColor6 六级标题文本颜色
     */
    @Deprecated["用HeadingTheme.setTextFontColorForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextColor6(headingTextColor6: Color): MarkdownThemeBuilder {
        this.headingTheme.heading6TextFontColor = headingTextColor6
        return this
    }

    /**
     * 设置标题文本字间距
     *
     * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextLetterSpacingForAllHeading方法代替", since: "1.4.0"]
    public func setHeadingTextWordSpace(headingTextWordSpace: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading1TextLetterSpacing = headingTextWordSpace
        this.headingTheme.heading2TextLetterSpacing = headingTextWordSpace
        this.headingTheme.heading3TextLetterSpacing = headingTextWordSpace
        this.headingTheme.heading4TextLetterSpacing = headingTextWordSpace
        this.headingTheme.heading5TextLetterSpacing = headingTextWordSpace
        this.headingTheme.heading6TextLetterSpacing = headingTextWordSpace
        return this
    }

    /**
     * 设置一级标题文本行高
     *
     * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextLineHeightForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextLineHeight1(headingTextLineHeight1: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading1TextLineHeight = headingTextLineHeight1
        return this
    }

    /**
     * 设置二级标题文本行高
     *
     * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextLineHeightForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextLineHeight2(headingTextLineHeight2: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading2TextLineHeight = headingTextLineHeight2
        return this
    }

    /**
     * 设置三级标题文本行高
     *
     * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextLineHeightForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextLineHeight3(headingTextLineHeight3: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading3TextLineHeight = headingTextLineHeight3
        return this
    }

    /**
     * 设置四级标题文本行高
     *
     * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextLineHeightForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextLineHeight4(headingTextLineHeight4: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading4TextLineHeight = headingTextLineHeight4
        return this
    }

    /**
     * 设置五级标题文本行高
     *
     * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextLineHeightForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextLineHeight5(headingTextLineHeight5: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading5TextLineHeight = headingTextLineHeight5
        return this
    }

    /**
     * 设置六级标题文本行高
     *
     * @param headingTextLineHeight1 六级标题文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HeadingTheme.setTextLineHeightForDesignateHeading方法代替", since: "1.4.0"]
    public func setHeadingTextLineHeight6(headingTextLineHeight6: Float64): MarkdownThemeBuilder {
        this.headingTheme.heading6TextLineHeight = headingTextLineHeight6
        return this
    }

    /**
     * 设置段落模块上间距
     *
     * @param paragraphTopMargins 段落模块上间距 - 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ParagraphTheme.setParagraphMargin方法代替", since: "1.4.0"]
    public func setParagraphTopMargins(paragraphTopMargins: Float64): MarkdownThemeBuilder {
        this.paragraphTheme.paragraphMarginTop = paragraphTopMargins
        return this
    }

    /**
     * 设置段落模块下间距
     *
     * @param paragraphBottomMargins 段落模块下间距 - 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ParagraphTheme.setParagraphMargin方法代替", since: "1.4.0"]
    public func setParagraphBottomMargins(paragraphBottomMargins: Float64): MarkdownThemeBuilder {
        this.paragraphTheme.paragraphMarginBottom = paragraphBottomMargins
        return this
    }

    /**
     * 设置段落文本大小
     *
     * @param paragraphTextSize 段落文本大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ParagraphTheme.setParagraphTextFontSize方法代替", since: "1.4.0"]
    public func setParagraphTextSize(paragraphTextSize: Float64): MarkdownThemeBuilder {
        this.paragraphTheme.paragraphTextFontSize = paragraphTextSize
        return this
    }

    /**
     * 设置段落文本颜色
     *
     * @param paragraphTextColor 段落文本颜色 - 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ParagraphTheme.setParagraphTextFontColor方法代替", since: "1.4.0"]
    public func setParagraphTextColor(paragraphTextColor: Color): MarkdownThemeBuilder {
        this.paragraphTheme.paragraphTextFontColor = paragraphTextColor
        return this
    }

    /**
     * 设置段落文本字间距
     *
     * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ParagraphTheme.setParagraphTextLetterSpacing方法代替", since: "1.4.0"]
    public func setParagraphTextWordSpace(paragraphTextWordSpace: Float64): MarkdownThemeBuilder {
        this.paragraphTheme.paragraphTextLetterSpacing = paragraphTextWordSpace
        return this
    }

    /**
     * 设置段落文本行高
     *
     * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ParagraphTheme.setParagraphTextLineHeight方法代替", since: "1.4.0"]
    public func setParagraphTextLineHeight(paragraphTextLineHeight: Float64): MarkdownThemeBuilder {
        this.paragraphTheme.paragraphTextLineHeight = paragraphTextLineHeight
        return this
    }

    /**
     * 设置段落文本字体
     *
     * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ParagraphTheme.setParagraphTextFontFamily方法代替", since: "1.4.0"]
    public func setParagraphTypeface(paragraphTypeface: String): MarkdownThemeBuilder {
        this.paragraphTheme.paragraphTextFontFamily = paragraphTypeface
        return this
    }

    /**
     * 设置分割线颜色
     *
     * @param thematicBreakColor 分割线颜色 - 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用DividerTheme.setDividerColor方法代替", since: "1.4.0"]
    public func setThematicBreakColor(thematicBreakColor: Color): MarkdownThemeBuilder {
        this.dividerTheme.dividerColor = thematicBreakColor
        return this
    }

    /**
     * 设置分割线高度
     *
     * @param thematicBreakHeight 分割线高度 - 默认0.5vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用DividerTheme.setDividerStrokeWidth方法代替", since: "1.4.0"]
    public func setThematicBreakHeight(thematicBreakHeight: Float64): MarkdownThemeBuilder {
        this.dividerTheme.dividerStrokeWidth = thematicBreakHeight
        return this
    }

    /**
     * 设置分割线上部外边距
     *
     * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用DividerTheme.setDividerMargin方法代替", since: "1.4.0"]
    public func setThematicBreakTopMargin(thematicBreakTopMargin: Float64): MarkdownThemeBuilder {
        this.dividerTheme.dividerMarginTop = thematicBreakTopMargin
        return this
    }

    /**
     * 设置分割线下部外边距
     *
     * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用DividerTheme.setDividerMargin方法代替", since: "1.4.0"]
    public func setThematicBreakBottomMargin(thematicBreakBottomMargin: Float64): MarkdownThemeBuilder {
        this.dividerTheme.dividerMarginBottom = thematicBreakBottomMargin
        return this
    }

    /**
     * 设置数学公式未加载状态是否显示文本
     *
     * @param latexDefaultText 数学公式未加载状态是否显示文本 - 默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LatexMathTheme.setLatexMathDefaultText方法代替", since: "1.4.0"]
    public func setLatexDefaultText(latexDefaultText: Bool): MarkdownThemeBuilder {
        this.latexMathTheme.latexMathDefaultText = latexDefaultText
        return this
    }

    /**
     * 设置数学公式文本大小
     *
     * @param latexMathTextSize 数学公式文本大小 - 默认16.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LatexMathTheme.setLatexMathTextSize方法代替", since: "1.4.0"]
    public func setLatexMathTextSize(latexMathTextSize: Float64): MarkdownThemeBuilder {
        this.latexMathTheme.latexMathTextSize = latexMathTextSize
        return this
    }

    /**
     * 设置数学公式背景色
     *
     * @param latexMathBackgroundColor 数学公式背景色 - 默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LatexMathTheme.setLatexMathBackgroundColor方法代替", since: "1.4.0"]
    public func setLatexMathBackgroundColor(latexMathBackgroundColor: Color): MarkdownThemeBuilder {
        this.latexMathTheme.latexMathBackgroundColor = latexMathBackgroundColor
        return this
    }

    /**
     * 设置数学公式文本颜色
     *
     * @param latexMathTextColor 数学公式文本颜色 - 默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LatexMathTheme.setLatexMathTextColor方法代替", since: "1.4.0"]
    public func setLatexMathTextColor(latexMathTextColor: Color): MarkdownThemeBuilder {
        this.latexMathTheme.latexMathTextColor = latexMathTextColor
        return this
    }

    /**
     * 设置数学公式生成图片格式
     *
     * @param latexMathColorFormat 数学公式生成图片格式 - 默认LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LatexMathTheme.setLatexMathColorFormat方法代替", since: "1.4.0"]
    public func setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): MarkdownThemeBuilder {
        this.latexMathTheme.latexMathColorFormat = latexMathColorFormat
        return this
    }

    /**
     * 设置块结构的数学公式是否居中
     *
     * @param latexMathBlockCenter 块结构的数学公式是否居中 - true:居中;false:不居中。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LatexMathTheme.setLatexMathBlockCenter方法代替", since: "1.4.0"]
    public func setLatexMathBlockCenter(latexMathBlockCenter: Bool): MarkdownThemeBuilder {
        this.latexMathTheme.latexMathBlockCenter = latexMathBlockCenter
        return this
    }

    /**
     * 设置数学公式字体路径
     *
     * @param latexMathResStr 数学公式字体路径 默认 "/data/storage/el1/bundle/entry/resources/resfile/res"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用LatexMathTheme.setLatexMathResPath方法代替", since: "1.4.0"]
    public func setLatexMathResStr(latexMathResStr: String): MarkdownThemeBuilder {
        this.latexMathTheme.latexMathResPath = latexMathResStr
        return this
    }

    /**
     * 设置音频图标
     *
     * @param audioIcon 音频图标 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioIcon方法代替", since: "1.4.0"]
    public func setAudioIcon(audioIcon: AppResource): MarkdownThemeBuilder {
        this.audioTheme.audioIcon = audioIcon
        return this
    }

    /**
     * 设置音频阴影颜色值
     *
     * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioShadowColor方法代替", since: "1.4.0"]
    public func setAudioShadowColor(audioShadowColor: Color): MarkdownThemeBuilder {
        this.audioTheme.audioShadowColor = audioShadowColor
        return this
    }

    /**
     * 设置音频边框颜色
     *
     * @param audioBorderColor 音频边框颜色 - 默认0x33000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioBorderColor方法代替", since: "1.4.0"]
    public func setAudioBorderColor(audioBorderColor: Color): MarkdownThemeBuilder {
        this.audioTheme.audioBorderColor = audioBorderColor
        return this
    }

    /**
     * 设置音频边框粗细
     *
     * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioBorderWidth方法代替", since: "1.4.0"]
    public func setAudioBorderWidth(audioBorderWidth: Float64): MarkdownThemeBuilder {
        this.audioTheme.audioBorderWidth = audioBorderWidth
        return this
    }

    /**
     * 设置音频边框圆角
     *
     * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioRadius方法代替", since: "1.4.0"]
    public func setAudioBorderRadius(audioBorderRadius: Float64): MarkdownThemeBuilder {
        this.audioTheme.audioRadiusTopLeft = audioBorderRadius
        this.audioTheme.audioRadiusTopRight = audioBorderRadius
        this.audioTheme.audioRadiusBottomLeft = audioBorderRadius
        this.audioTheme.audioRadiusBottomRight = audioBorderRadius
        return this
    }

    /**
     * 设置音频按钮背景颜色
     *
     * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioButtonBackgroundColor方法代替", since: "1.4.0"]
    public func setAudioButtonBackgroundColor(audioButtonBackgroundColor: Color): MarkdownThemeBuilder {
        this.audioTheme.audioButtonBackgroundColor = audioButtonBackgroundColor
        return this
    }

    /**
     * 设置音频按钮文本颜色
     *
     * @param audioButtonTextColor 音频按钮文本颜色 - 默认Color.WHITE
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioButtonTextFontColor方法代替", since: "1.4.0"]
    public func setAudioButtonTextColor(audioButtonTextColor: Color): MarkdownThemeBuilder {
        this.audioTheme.audioButtonTextFontColor = audioButtonTextColor
        return this
    }

    /**
     * 设置音频按钮文本大小
     *
     * @param audioButtonTextSize 音频按钮文本大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioButtonTextFontSize方法代替", since: "1.4.0"]
    public func setAudioButtonTextSize(audioButtonTextSize: Float64): MarkdownThemeBuilder {
        this.audioTheme.audioButtonTextFontSize = audioButtonTextSize
        return this
    }

    /**
     * 设置音频按钮文本内容
     *
     * @param audioButtonText 音频按钮文本内容 - 默认"立即播放"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioButtonText方法代替", since: "1.4.0"]
    public func setAudioButtonText(audioButtonText: String): MarkdownThemeBuilder {
        this.audioTheme.audioButtonText = audioButtonText
        return this
    }

    /**
     * 设置音频按钮圆角
     *
     * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioButtonRadius方法代替", since: "1.4.0"]
    public func setAudioButtonBorderRadius(audioButtonBorderRadius: Float64): MarkdownThemeBuilder {
        this.audioTheme.audioButtonRadiusTopLeft = audioButtonBorderRadius
        this.audioTheme.audioButtonRadiusTopRight = audioButtonBorderRadius
        this.audioTheme.audioButtonRadiusBottomLeft = audioButtonBorderRadius
        this.audioTheme.audioButtonRadiusBottomRight = audioButtonBorderRadius
        return this
    }

    /**
     * 设置音频标题文本大小
     *
     * @param audioTitleTextSize 音频标题文本大小 - 默认15.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioTitleTextFontSize方法代替", since: "1.4.0"]
    public func setAudioTitleTextSize(audioTitleTextSize: Float64): MarkdownThemeBuilder {
        this.audioTheme.audioTitleTextFontSize = audioTitleTextSize
        return this
    }

    /**
     * 设置音频标题文本颜色
     *
     * @param audioTitleTextColor 音频标题文本颜色 - 默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioTitleTextFontColor方法代替", since: "1.4.0"]
    public func setAudioTitleTextColor(audioTitleTextColor: Color): MarkdownThemeBuilder {
        this.audioTheme.audioTitleTextFontColor = audioTitleTextColor
        return this
    }

    /**
     * 设置音频标题文本行高
     *
     * @param audioTitleTextLineHeight 音频标题文本行高 - 默认20.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioTitleTextLineHeight方法代替", since: "1.4.0"]
    public func setAudioTitleTextLineHeight(audioTitleTextLineHeight: Float64): MarkdownThemeBuilder {
        this.audioTheme.audioTitleTextLineHeight = audioTitleTextLineHeight
        return this
    }

    /**
     * 设置音频类型文本大小
     *
     * @param audioTypeTextSize 音频类型文本大小 - 默认11.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioTypeTextFontSize方法代替", since: "1.4.0"]
    public func setAudioTypeTextSize(audioTypeTextSize: Float64): MarkdownThemeBuilder {
        this.audioTheme.audioTypeTextFontSize = audioTypeTextSize
        return this
    }

    /**
     * 设置音频类型文本颜色
     *
     * @param audioTypeTextColor 音频类型文本颜色 - 默认0x80000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioTypeTextFontColor方法代替", since: "1.4.0"]
    public func setAudioTypeTextColor(audioTypeTextColor: Color): MarkdownThemeBuilder {
        this.audioTheme.audioTypeTextFontColor = audioTypeTextColor
        return this
    }

    /**
     * 设置音频类型文本行高
     *
     * @param audioTypeTextLineHeight 音频类型文本行高 - 默认15.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioTypeTextLineHeight方法代替", since: "1.4.0"]
    public func setAudioTypeTextLineHeight(audioTypeTextLineHeight: Float64): MarkdownThemeBuilder {
        this.audioTheme.audioTypeTextLineHeight = audioTypeTextLineHeight
        return this
    }

    /**
     * 设置音频上边距
     *
     * @param audioMarginTop 音频上边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioMargin方法代替", since: "1.4.0"]
    public func setAudioMarginTop(audioMarginTop: Float64): MarkdownThemeBuilder {
        this.audioTheme.audioMarginTop = audioMarginTop
        return this
    }

    /**
     * 设置音频下边距
     *
     * @param audioMarginBottom 音频下边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用AudioTheme.setAudioMargin方法代替", since: "1.4.0"]
    public func setAudioMarginBottom(audioMarginBottom: Float64): MarkdownThemeBuilder {
        this.audioTheme.audioMarginBottom = audioMarginBottom
        return this
    }

    /**
     * 设置视频默认占位图
     *
     * @param videoImage 视频默认占位图 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoPlaceholder方法代替", since: "1.4.0"]
    public func setVideoImage(videoImage: AppResource): MarkdownThemeBuilder {
        this.videoTheme.videoPlaceholder = videoImage
        return this
    }

    /**
     * 设置视频播放按钮默认图标
     *
     * @param playCircleFillIcon 视频播放按钮默认图标 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoPlayIcon方法代替", since: "1.4.0"]
    public func setPlayCircleFillIcon(playCircleFillIcon: AppResource): MarkdownThemeBuilder {
        this.videoTheme.videoPlayIcon = playCircleFillIcon
        return this
    }

    /**
     * 设置视频发布默认图标
     *
     * @param videoReleaseImage 视频发布默认图标 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoReleaseButtonIcon方法代替", since: "1.4.0"]
    public func setVideoReleaseImage(videoReleaseImage: AppResource): MarkdownThemeBuilder {
        this.videoTheme.videoReleaseButtonIcon = videoReleaseImage
        return this
    }

    /**
     * 设置视频下载默认图标
     *
     * @param videoDownloadImage 视频下载默认图标 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoDownloadButtonIcon方法代替", since: "1.4.0"]
    public func setVideoDownloadImage(videoDownloadImage: AppResource): MarkdownThemeBuilder {
        this.videoTheme.videoDownloadButtonIcon = videoDownloadImage
        return this
    }

    /**
     * 设置视频圆角
     *
     * @param videoBorderRadius 视频圆角 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoRadius方法代替", since: "1.4.0"]
    public func setVideoBorderRadius(videoBorderRadius: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoRadiusTopLeft = videoBorderRadius
        this.videoTheme.videoRadiusTopRight = videoBorderRadius
        this.videoTheme.videoRadiusBottomLeft = videoBorderRadius
        this.videoTheme.videoRadiusBottomRight = videoBorderRadius
        return this
    }

    /**
     * 设置视频时间文本颜色
     *
     * @param videoTimeTextColor 视频时间文本颜色 - 默认Color.WHITE
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoTimeTextFontColor方法代替", since: "1.4.0"]
    public func setVideoTimeTextColor(videoTimeTextColor: Color): MarkdownThemeBuilder {
        this.videoTheme.videoTimeTextFontColor = videoTimeTextColor
        return this
    }

    /**
     * 设置视频时间文本大小
     *
     * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoTimeTextFontSize方法代替", since: "1.4.0"]
    public func setVideoTimeTextSize(videoTimeTextSize: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoTimeTextFontSize = videoTimeTextSize
        return this
    }

    /**
     * 设置视频时间文本居右边距
     *
     * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoTimeTextMarginRight方法代替", since: "1.4.0"]
    public func setVideoTimeTextMarginRight(videoTimeTextMarginRight: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoTimeTextMarginRight = videoTimeTextMarginRight
        return this
    }

    /**
     * 设置视频时间文本居底边距
     *
     * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoTimeTextMarginBottom方法代替", since: "1.4.0"]
    public func setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoTimeTextMarginBottom = videoTimeTextMarginBottom
        return this
    }

    /**
     * 设置视频上边距
     *
     * @param videoMarginTop 视频上边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoMargin方法代替", since: "1.4.0"]
    public func setVideoMarginTop(videoMarginTop: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoMarginTop = videoMarginTop
        return this
    }

    /**
     * 设置视频下边距
     *
     * @param videoMarginBottom 视频下边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoMargin方法代替", since: "1.4.0"]
    public func setVideoMarginBottom(videoMarginBottom: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoMarginBottom = videoMarginBottom
        return this
    }

    /**
     * 设置视频发布/下载按钮布局是否显示
     *
     * @param isVideoBottomLayout 视频发布/下载按钮布局是否显示 - 默false不显示
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoBottomLayoutVisible方法代替", since: "1.4.0"]
    public func setIsVideoBottomLayout(isVideoBottomLayout: Bool): MarkdownThemeBuilder {
        this.videoTheme.videoBottomLayoutVisible = isVideoBottomLayout
        return this
    }

    /**
     * 设置视频发布按钮图片宽度和高度
     *
     * @param videoReleaseImageWidthHeight 视频发布按钮图片宽度和高度 - 默认18.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme相关set方法代替", since: "1.4.0"]
    public func setVideoReleaseImageWidthHeight(videoReleaseImageWidthHeight: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoReleaseButtonIconWidth = videoReleaseImageWidthHeight
        this.videoTheme.videoReleaseButtonIconHeight = videoReleaseImageWidthHeight
        return this
    }

    /**
     * 设置视频发布按钮宽度
     *
     * @param videoReleaseWidth 视频发布按钮宽度 - 默认144.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoReleaseButtonWidth方法代替", since: "1.4.0"]
    public func setVideoReleaseWidth(videoReleaseWidth: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoReleaseButtonWidth = videoReleaseWidth
        return this
    }

    /**
     * 设置视频发布按钮高度
     *
     * @param videoReleaseHeight 视频发布按钮高度 - 默认44.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoReleaseButtonHeight方法代替", since: "1.4.0"]
    public func setVideoReleaseHeight(videoReleaseHeight: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoReleaseButtonHeight = videoReleaseHeight
        return this
    }

    /**
     * 设置视频发布按钮圆角
     *
     * @param videoReleaseRadius 视频发布按钮圆角 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoReleaseButtonRadius方法代替", since: "1.4.0"]
    public func setVideoReleaseRadius(videoReleaseRadius: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoReleaseButtonRadiusTopLeft = videoReleaseRadius
        this.videoTheme.videoReleaseButtonRadiusTopRight = videoReleaseRadius
        this.videoTheme.videoReleaseButtonRadiusBottomLeft = videoReleaseRadius
        this.videoTheme.videoReleaseButtonRadiusBottomRight = videoReleaseRadius
        return this
    }

    /**
     * 设置视频发布按钮文本内容
     *
     * @param videoReleaseText 视频发布按钮文本内容 - 默认"发布视频"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoReleaseButtonText方法代替", since: "1.4.0"]
    public func setVideoReleaseText(videoReleaseText: String): MarkdownThemeBuilder {
        this.videoTheme.videoReleaseButtonText = videoReleaseText
        return this
    }

    /**
     * 设置视频发布按钮文本大小
     *
     * @param videoReleaseTextSize 视频发布按钮文本大小 - 默认16.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoReleaseButtonTextFontSize方法代替", since: "1.4.0"]
    public func setVideoReleaseTextSize(videoReleaseTextSize: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoReleaseButtonTextFontSize = videoReleaseTextSize
        return this
    }

    /**
     * 设置视频发布按钮文本颜色
     *
     * @param videoReleaseTextColor 视频发布按钮文本颜色 - 默认0xE6000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoReleaseButtonTextFontColor方法代替", since: "1.4.0"]
    public func setVideoReleaseTextColor(videoReleaseTextColor: Color): MarkdownThemeBuilder {
        this.videoTheme.videoReleaseButtonTextFontColor = videoReleaseTextColor
        return this
    }

    /**
     * 设置视频发布按钮背景颜色
     *
     * @param videoReleaseBackgroundColor 视频发布按钮背景颜色 - 默认0xFFF5F5F5
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoReleaseButtonBackgroundColor方法代替", since: "1.4.0"]
    public func setVideoReleaseBackgroundColor(videoReleaseBackgroundColor: Color): MarkdownThemeBuilder {
        this.videoTheme.videoReleaseButtonBackgroundColor = videoReleaseBackgroundColor
        return this
    }

    /**
     * 设置视频下载按钮图片宽度和高度
     *
     * @param videoDownloadImageWidthHeight 视频下载按钮图片宽度和高度 - 默认18.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme相关set方法代替", since: "1.4.0"]
    public func setVideoDownloadImageWidthHeight(videoDownloadImageWidthHeight: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoDownloadButtonIconWidth = videoDownloadImageWidthHeight
        this.videoTheme.videoDownloadButtonIconHeight = videoDownloadImageWidthHeight
        return this
    }

    /**
     * 设置视频下载按钮宽度
     *
     * @param videoDownloadWidth 视频下载按钮宽度 - 默认144.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoDownloadButtonWidth方法代替", since: "1.4.0"]
    public func setVideoDownloadWidth(videoDownloadWidth: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoDownloadButtonWidth = videoDownloadWidth
        return this
    }

    /**
     * 设置视频下载按钮高度
     *
     * @param videoDownloadHeight 视频下载按钮高度 - 默认44.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoDownloadButtonHeight方法代替", since: "1.4.0"]
    public func setVideoDownloadHeight(videoDownloadHeight: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoDownloadButtonHeight = videoDownloadHeight
        return this
    }

    /**
     * 设置视频下载按钮圆角
     *
     * @param videoDownloadRadius 视频下载按钮圆角 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoDownloadButtonRadius方法代替", since: "1.4.0"]
    public func setVideoDownloadRadius(videoDownloadRadius: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoDownloadButtonRadiusTopLeft = videoDownloadRadius
        this.videoTheme.videoDownloadButtonRadiusTopRight = videoDownloadRadius
        this.videoTheme.videoDownloadButtonRadiusBottomLeft = videoDownloadRadius
        this.videoTheme.videoDownloadButtonRadiusBottomRight = videoDownloadRadius
        return this
    }

    /**
     * 设置视频下载按钮文本内容
     *
     * @param videoDownloadText 视频下载按钮文本内容 - 默认"下载视频"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoDownloadButtonText方法代替", since: "1.4.0"]
    public func setVideoDownloadText(videoDownloadText: String): MarkdownThemeBuilder {
        this.videoTheme.videoDownloadButtonText = videoDownloadText
        return this
    }

    /**
     * 设置视频下载按钮文本大小
     *
     * @param videoDownloadTextSize 视频下载按钮文本大小 - 默认16.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoDownloadButtonTextFontSize方法代替", since: "1.4.0"]
    public func setVideoDownloadTextSize(videoDownloadTextSize: Float64): MarkdownThemeBuilder {
        this.videoTheme.videoDownloadButtonTextFontSize = videoDownloadTextSize
        return this
    }

    /**
     * 设置视频下载按钮文本颜色
     *
     * @param videoDownloadTextColor 视频下载按钮文本颜色 - 默认0xE6000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoDownloadButtonTextFontColor方法代替", since: "1.4.0"]
    public func setVideoDownloadTextColor(videoDownloadTextColor: Color): MarkdownThemeBuilder {
        this.videoTheme.videoDownloadButtonTextFontColor = videoDownloadTextColor
        return this
    }

    /**
     * 设置视频下载按钮背景颜色
     *
     * @param videoDownloadBackgroundColor 视频下载按钮背景颜色 - 默认0xFFF5F5F5
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用VideoTheme.setVideoDownloadButtonBackgroundColor方法代替", since: "1.4.0"]
    public func setVideoDownloadBackgroundColor(videoDownloadBackgroundColor: Color): MarkdownThemeBuilder {
        this.videoTheme.videoDownloadButtonBackgroundColor = videoDownloadBackgroundColor
        return this
    }

    /**
     * 设置图片banner默认占位图
     *
     * @param bannerImage 图片banner占位图 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用BannerTheme.setBannerPlaceholder方法代替", since: "1.4.0"]
    public func setBannerImage(bannerImage: AppResource): MarkdownThemeBuilder {
        this.bannerTheme.bannerPlaceholder = bannerImage
        return this
    }

    /**
     * 设置图片基于自身宽度缩放百分比
     *
     * @param imageMaximumWidth 图片基于自身宽度缩放百分比 - 默认1.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageMaximumWidth方法代替", since: "1.4.0"]
    public func setImageMaximumWidth(imageMaximumWidth: Float64): MarkdownThemeBuilder {
        this.imageTheme.imageMaximumWidth = imageMaximumWidth
        return this
    }

    /**
     * 设置图片基于父布局宽度缩放百分比
     *
     * @param imageFixedRatioWidth 图片基于父布局宽度缩放百分比 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageFixedRatioWidth方法代替", since: "1.4.0"]
    public func setImageFixedRatioWidth(imageFixedRatioWidth: Float64): MarkdownThemeBuilder {
        this.imageTheme.imageFixedRatioWidth = imageFixedRatioWidth
        return this
    }

    /**
     * 设置图片最大高度
     *
     * @param imageMaxHeight 图片最大高度 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageMaxHeight方法代替", since: "1.4.0"]
    public func setImageMaxHeight(imageMaxHeight: Float64): MarkdownThemeBuilder {
        this.imageTheme.imageMaxHeight = imageMaxHeight
        return this
    }

    /**
     * 设置图片最大宽度
     *
     * @param imageMaxWidth 图片最大宽度 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageMaxWidth方法代替", since: "1.4.0"]
    public func setImageMaxWidth(imageMaxWidth: Float64): MarkdownThemeBuilder {
        this.imageTheme.imageMaxWidth = imageMaxWidth
        return this
    }

    /**
     * 设置图片圆角
     *
     * @param imageBorderRadius 图片圆角 - 默认0.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setRadius方法代替", since: "1.4.0"]
    public func setImageBorderRadius(imageBorderRadius: Float64): MarkdownThemeBuilder {
        this.imageTheme.imageRadiusTopLeft = imageBorderRadius
        this.imageTheme.imageRadiusTopRight = imageBorderRadius
        this.imageTheme.imageRadiusBottomLeft = imageBorderRadius
        this.imageTheme.imageRadiusBottomRight = imageBorderRadius
        return this
    }

    /**
     * 设置图片边框宽度
     *
     * @param imageBorderWidth 图片边框宽度 - 默认0.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageBorderWidth方法代替", since: "1.4.0"]
    public func setImageBorderWidth(imageBorderWidth: Float64): MarkdownThemeBuilder {
        this.imageTheme.imageBorderWidth = imageBorderWidth
        return this
    }

    /**
     * 设置图片边框颜色
     *
     * @param imageBorderColor 图片边框颜色 - 默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageBorderColor方法代替", since: "1.4.0"]
    public func setImageBorderColor(imageBorderColor: Color): MarkdownThemeBuilder {
        this.imageTheme.imageBorderColor = imageBorderColor
        return this
    }

    /**
     * 设置图片缩放类型
     *
     * @param imageFitType 图片缩放类型 - 默认ImageFit.Contain
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageFitType方法代替", since: "1.4.0"]
    public func setImageFitType(imageFitType: ImageFit): MarkdownThemeBuilder {
        this.imageTheme.imageFitType = imageFitType
        return this
    }

    /**
     * 设置图片默认占位图
     *
     * @param imageResource 图片默认占位图 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImagePlaceholder方法代替", since: "1.4.0"]
    public func setImageResource(imageResource: AppResource): MarkdownThemeBuilder {
        this.imageTheme.imagePlaceholder = imageResource
        return this
    }

    /**
     * 设置网络图片是否压缩
     *
     * @param isAutoResize 网络图片是否压缩 - true:压缩;false:不压缩。默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageAutoResize方法代替", since: "1.4.0"]
    public func setIsAutoResize(isAutoResize: Bool): MarkdownThemeBuilder {
        this.imageTheme.imageAutoResize = isAutoResize
        return this
    }

    /**
     * 设置图片上边距
     *
     * @param imageMarginTop 图片上边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setMargin方法代替", since: "1.4.0"]
    public func setImageMarginTop(imageMarginTop: Float64): MarkdownThemeBuilder {
        this.imageTheme.imageMarginTop = imageMarginTop
        return this
    }

    /**
     * 设置图片下边距
     *
     * @param imageMarginBottom 图片下边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setMargin方法代替", since: "1.4.0"]
    public func setImageMarginBottom(imageMarginBottom: Float64): MarkdownThemeBuilder {
        this.imageTheme.imageMarginBottom = imageMarginBottom
        return this
    }

    /**
     * 设置图片是否有下载按钮
     *
     * @param isImageDownload 图片是否有下载按钮 - 默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageDownloadButtonVisible方法代替", since: "1.4.0"]
    public func setIsImageDownload(isImageDownload: Bool): MarkdownThemeBuilder {
        this.imageTheme.imageDownloadButtonVisible = isImageDownload
        return this
    }

    /**
     * 设置是否图文混排
     *
     * @param isImageMixedLayout 是否图文混排 - 默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setIsImageMixedLayout方法代替", since: "1.4.0"]
    public func setIsImageMixedLayout(isImageMixedLayout: Bool): MarkdownThemeBuilder {
        this.imageTheme.isImageMixedLayout = isImageMixedLayout
        return this
    }

    /**
     * 设置图片下载默认图标
     *
     * @param imageDownloadImage 图片下载默认图标 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageDownloadButtonIcon方法代替", since: "1.4.0"]
    public func setImageDownloadImage(imageDownloadImage: AppResource): MarkdownThemeBuilder {
        this.imageTheme.imageDownloadButtonIcon = imageDownloadImage
        return this
    }

    /**
     * 设置图片下载按钮图片宽度和高度
     *
     * @param imageDownloadImageWidthHeight 图片下载按钮图片宽度和高度 - 默认18.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme相关set方法代替", since: "1.4.0"]
    public func setImageDownloadImageWidthHeight(imageDownloadImageWidthHeight: Float64): MarkdownThemeBuilder {
        this.imageTheme.imageDownloadButtonIconWidth = imageDownloadImageWidthHeight
        this.imageTheme.imageDownloadButtonIconHeight = imageDownloadImageWidthHeight
        return this
    }

    /**
     * 设置图片下载按钮宽度
     *
     * @param imageDownloadWidth 图片下载按钮宽度 - 默认296.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageDownloadButtonWidth方法代替", since: "1.4.0"]
    public func setImageDownloadWidth(imageDownloadWidth: Float64): MarkdownThemeBuilder {
        this.imageTheme.imageDownloadButtonWidth = imageDownloadWidth
        return this
    }

    /**
     * 设置图片下载按钮高度
     *
     * @param imageDownloadHeight 图片下载按钮高度 - 默认44.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageDownloadButtonHeight方法代替", since: "1.4.0"]
    public func setImageDownloadHeight(imageDownloadHeight: Float64): MarkdownThemeBuilder {
        this.imageTheme.imageDownloadButtonHeight = imageDownloadHeight
        return this
    }

    /**
     * 设置图片下载按钮圆角
     *
     * @param imageDownloadRadius 图片下载按钮圆角 - 默认22.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageDownloadButtonRadius方法代替", since: "1.4.0"]
    public func setImageDownloadRadius(imageDownloadRadius: Float64): MarkdownThemeBuilder {
        this.imageTheme.imageDownloadButtonRadiusTopLeft = imageDownloadRadius
        this.imageTheme.imageDownloadButtonRadiusTopRight = imageDownloadRadius
        this.imageTheme.imageDownloadButtonRadiusBottomLeft = imageDownloadRadius
        this.imageTheme.imageDownloadButtonRadiusBottomRight = imageDownloadRadius
        return this
    }

    /**
     * 设置图片下载按钮文本内容
     *
     * @param imageDownloadText 图片下载按钮文本内容 - 默认"下载图片"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageDownloadButtonText方法代替", since: "1.4.0"]
    public func setImageDownloadText(imageDownloadText: String): MarkdownThemeBuilder {
        this.imageTheme.imageDownloadButtonText = imageDownloadText
        return this
    }

    /**
     * 设置图片下载按钮文本大小
     *
     * @param imageDownloadTextSize 图片下载按钮文本大小 - 默认16.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageDownloadButtonTextFontSize方法代替", since: "1.4.0"]
    public func setImageDownloadTextSize(imageDownloadTextSize: Float64): MarkdownThemeBuilder {
        this.imageTheme.imageDownloadButtonTextFontSize = imageDownloadTextSize
        return this
    }

    /**
     * 设置图片下载按钮文本颜色
     *
     * @param imageDownloadTextColor 图片下载按钮文本颜色 - 默认0xE6000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageDownloadButtonTextFontColor方法代替", since: "1.4.0"]
    public func setImageDownloadTextColor(imageDownloadTextColor: Color): MarkdownThemeBuilder {
        this.imageTheme.imageDownloadButtonTextFontColor = imageDownloadTextColor
        return this
    }

    /**
     * 设置图片下载按钮背景颜色
     *
     * @param imageDownloadBackgroundColor 图片下载按钮背景颜色 - 默认0xFFF5F5F5
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用ImageTheme.setImageDownloadButtonBackgroundColor方法代替", since: "1.4.0"]
    public func setImageDownloadBackgroundColor(imageDownloadBackgroundColor: Color): MarkdownThemeBuilder {
        this.imageTheme.imageDownloadButtonBackgroundColor = imageDownloadBackgroundColor
        return this
    }

    /**
     * 设置表格内容内边距
     *
     * @param tableCellPadding 表格内容内边距 - 默认4.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableCellPadding方法代替", since: "1.4.0"]
    public func setTableCellPadding(tableCellPadding: Float64): MarkdownThemeBuilder {
        this.tableTheme.tableCellPaddingTop = tableCellPadding
        this.tableTheme.tableCellPaddingRight = tableCellPadding
        this.tableTheme.tableCellPaddingBottom = tableCellPadding
        this.tableTheme.tableCellPaddingLeft = tableCellPadding
        return this
    }

    /**
     * 设置表格边框颜色
     *
     * @param tableBorderColor 表格边框颜色 - 默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableBorderColor方法代替", since: "1.4.0"]
    public func setTableBorderColor(tableBorderColor: Color): MarkdownThemeBuilder {
        this.tableTheme.tableBorderColor = tableBorderColor
        return this
    }

    /**
     * 设置表格边框宽度
     *
     * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableBorderWidth方法代替", since: "1.4.0"]
    public func setTableBorderWidth(tableBorderWidth: Float64): MarkdownThemeBuilder {
        this.tableTheme.tableBorderWidth = tableBorderWidth
        return this
    }

    /**
     * 设置表格奇数行背景色
     *
     * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认Color.WHITE
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableContentOddRowBackgroundColor方法代替", since: "1.4.0"]
    public func setTableOddRowBackgroundColor(tableOddRowBackgroundColor: Color): MarkdownThemeBuilder {
        this.tableTheme.tableContentOddRowBackgroundColor = tableOddRowBackgroundColor
        return this
    }

    /**
     * 设置表格偶数行背景色
     *
     * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0xFFE0E0E0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableContentEvenRowBackgroundColor方法代替", since: "1.4.0"]
    public func setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: Color): MarkdownThemeBuilder {
        this.tableTheme.tableContentEvenRowBackgroundColor = tableEvenRowBackgroundColor
        return this
    }

    /**
     * 设置表格标题背景色
     *
     * @param tableHeaderRowBackgroundColor 表格标题背景色 - 默认Color.WHITE
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableTitleBackgroundColor方法代替", since: "1.4.0"]
    public func setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: Color): MarkdownThemeBuilder {
        this.tableTheme.tableTitleBackgroundColor = tableHeaderRowBackgroundColor
        return this
    }

    /**
     * 设置表格标题文本颜色
     *
     * @param tableTitleTextColor 表格标题文本颜色 - 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableTitleTextFontColor方法代替", since: "1.4.0"]
    public func setTableTitleTextColor(tableTitleTextColor: Color): MarkdownThemeBuilder {
        this.tableTheme.tableTitleTextFontColor = tableTitleTextColor
        return this
    }

    /**
     * 设置表格标题文本大小
     *
     * @param tableTitleTextSize 表格标题文本大小 - 默认14.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableTitleTextFontSize方法代替", since: "1.4.0"]
    public func setTableTitleTextSize(tableTitleTextSize: Float64): MarkdownThemeBuilder {
        this.tableTheme.tableTitleTextFontSize = tableTitleTextSize
        return this
    }

    /**
     * 设置表格文本行高
     *
     * @param tableTextLineHeight 表格内容文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableTitleTextLineHeight和setTableContentTextLineHeight方法代替", since: "1.4.0"]
    public func setTableTextLineHeight(tableTextLineHeight: Float64): MarkdownThemeBuilder {
        this.tableTheme.tableTitleTextLineHeight = tableTextLineHeight
        this.tableTheme.tableContentTextLineHeight = tableTextLineHeight
        return this
    }

    /**
     * 设置表格标题文本行高
     *
     * @param tableTitleLineHeight 表格标题文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableTitleTextLineHeight方法代替", since: "1.4.0"]
    public func setTableTitleLineHeight(tableTitleLineHeight: Float64): MarkdownThemeBuilder {
        this.tableTheme.tableTitleTextLineHeight = tableTitleLineHeight
        return this
    }

    /**
     * 设置表格内容文本颜色
     *
     * @param tableContentTextColor 表格内容文本颜色 - 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableContentTextFontColor方法代替", since: "1.4.0"]
    public func setTableContentTextColor(tableContentTextColor: Color): MarkdownThemeBuilder {
        this.tableTheme.tableContentTextFontColor = tableContentTextColor
        return this
    }

    /**
     * 设置表格内容文本大小
     *
     * @param tableContentTextSize 表格内容文本大小 - 默认14.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableContentTextFontSize方法代替", since: "1.4.0"]
    public func setTableContentTextSize(tableContentTextSize: Float64): MarkdownThemeBuilder {
        this.tableTheme.tableContentTextFontSize = tableContentTextSize
        return this
    }

    /**
     * 设置表格内容文本行高
     *
     * @param tableTextLineHeight 表格内容文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableContentTextLineHeight方法代替", since: "1.4.0"]
    public func setTableContentTextLineHeight(tableTextLineHeight: Float64): MarkdownThemeBuilder {
        this.tableTheme.tableContentTextLineHeight = tableTextLineHeight
        return this
    }

    /**
     * 设置表格圆角
     *
     * @param tableRadius 表格圆角 - 默认5.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableRadius方法代替", since: "1.4.0"]
    public func setTableRadius(tableRadius: Float64): MarkdownThemeBuilder {
        this.tableTheme.tableRadiusTopLeft = tableRadius
        this.tableTheme.tableRadiusTopRight = tableRadius
        this.tableTheme.tableRadiusBottomLeft = tableRadius
        this.tableTheme.tableRadiusBottomRight = tableRadius
        return this
    }

    /**
     * 设置表格最小宽度
     *
     * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableMinCellWidth方法代替", since: "1.4.0"]
    public func setTableMinTextWidth(tableMinTextWidth: Float64): MarkdownThemeBuilder {
        this.tableTheme.tableMinCellWidth = tableMinTextWidth
        return this
    }

    /**
     * 设置表格最大宽度
     *
     * @param tableMaxTextWidth 表格最大宽度- 默认300.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableMaxCellWidth方法代替", since: "1.4.0"]
    public func setTableMaxTextWidth(tableMaxTextWidth: Float64): MarkdownThemeBuilder {
        this.tableTheme.tableMaxCellWidth = tableMaxTextWidth
        return this
    }

    /**
     * 设置表格第一列是否加粗
     *
     * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableFirstColumnIsBold方法代替", since: "1.4.0"]
    public func setTableFirstColumnBold(tableFirstColumnBold: Bool): MarkdownThemeBuilder {
        this.tableTheme.tableFirstColumnIsBold = tableFirstColumnBold
        return this
    }

    /**
     * 设置表格是否显示滚动条
     *
     * @param tableScrollBarShow 表格是否显示滚动条 - true：显示；false：不显示。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableScrollBarState方法代替", since: "1.4.0"]
    public func setTableScrollBarShow(tableScrollBarShow: Bool): MarkdownThemeBuilder {
        if (tableScrollBarShow) {
            this.tableTheme.tableScrollBarState = BarState.On
        } else {
            this.tableTheme.tableScrollBarState = BarState.Off
        }
        return this
    }

    /**
     * 设置表格滚动条颜色
     *
     * @param tableFirstColumnBold 表格滚动条颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用TableTheme.setTableScrollBarColor方法代替", since: "1.4.0"]
    public func setTableScrollBarColor(tableScrollBarColor: Color): MarkdownThemeBuilder {
        this.tableTheme.tableScrollBarColor = tableScrollBarColor
        return this
    }

    /**
     * 设置删除线颜色
     *
     * @param strikethroughColor 删除线颜色 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用StrikethroughTheme.setStrikethroughTextDecorationColor方法代替", since: "1.4.0"]
    public func setStrikethroughColor(strikethroughColor: Color): MarkdownThemeBuilder {
        this.strikethroughTheme.strikethroughTextDecorationColor = strikethroughColor
        return this
    }

    /**
     * 设置删除线样式
     *
     * @param strikethroughStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用StrikethroughTheme.setStrikethroughTextDecorationStyle方法代替", since: "1.4.0"]
    public func setStrikethroughStyle(strikethroughStyle: Int32): MarkdownThemeBuilder {
        match (strikethroughStyle) {
            case 0 => this.strikethroughTheme.strikethroughTextDecorationStyle = MarkdownTextDecorationStyle.SOLID
            case 1 => this.strikethroughTheme.strikethroughTextDecorationStyle = MarkdownTextDecorationStyle.DOUBLE
            case 2 => this.strikethroughTheme.strikethroughTextDecorationStyle = MarkdownTextDecorationStyle.DOTTED
            case 3 => this.strikethroughTheme.strikethroughTextDecorationStyle = MarkdownTextDecorationStyle.DASHED
            case 4 => this.strikethroughTheme.strikethroughTextDecorationStyle = MarkdownTextDecorationStyle.WAVY
            case _ => this.strikethroughTheme.strikethroughTextDecorationStyle = MarkdownTextDecorationStyle.SOLID
        }
        return this
    }

    /**
     * 设置定义列表术语和定义行之间间距
     *
     * @param descListTermAndDefMargins 定义列表术语和定义行之间间距 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用DefinitionListTheme.setDefinitionListTermToDescriptionSpacing方法代替", since: "1.4.0"]
    public func setDescListTermAndDefMargins(descListTermAndDefMargins: Float64): MarkdownThemeBuilder {
        this.definitionListTheme.definitionListTermToDescriptionSpacing = descListTermAndDefMargins
        return this
    }

    /**
     * 设置定义列表定义行缩进
     *
     * @param descListDefIndentation 定义列表定义行缩进 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用DefinitionListTheme.setDefinitionListDescriptionIndent方法代替", since: "1.4.0"]
    public func setDescListDefIndentation(descListDefIndentation: Float64): MarkdownThemeBuilder {
        this.definitionListTheme.definitionListDescriptionIndent = descListDefIndentation
        return this
    }

    /**
     * 设置定义列表定义行间距
     *
     * @param descListDefMargins 定义列表定义行间距 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用DefinitionListTheme.setDefinitionListDescriptionItemSpacing方法代替", since: "1.4.0"]
    public func setDescListDefMargins(descListDefMargins: Float64): MarkdownThemeBuilder {
        this.definitionListTheme.definitionListDescriptionItemSpacing = descListDefMargins
        return this
    }

    /**
     * 设置下标字体颜色
     *
     * @param subTextColor 下标字体颜色 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用SubTheme.setSubTextFontColor方法代替", since: "1.4.0"]
    public func setSubTextColor(subTextColor: Color): MarkdownThemeBuilder {
        this.subTheme.subTextFontColor = subTextColor
        return this
    }

    /**
     * 设置下标字体大小
     *
     * @param subTextSize 下标字体大小 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用SubTheme.setSubTextFontSize方法代替", since: "1.4.0"]
    public func setSubTextSize(subTextSize: Float64): MarkdownThemeBuilder {
        this.subTheme.subTextFontSize = subTextSize
        return this
    }

    /**
     * 设置下标偏移距离
     *
     * @param subOffsetDist 下标偏移距离 默认0.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用SubTheme.setSubTextBaselineOffset方法代替", since: "1.4.0"]
    public func setSubOffsetDist(subOffsetDist: Float64): MarkdownThemeBuilder {
        this.subTheme.subTextBaselineOffset = subOffsetDist
        return this
    }

    /**
     * 设置上标字体颜色
     *
     * @param supTextColor 上标字体颜色 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用SupTheme.setSupTextFontColor方法代替", since: "1.4.0"]
    public func setSupTextColor(supTextColor: Color): MarkdownThemeBuilder {
        this.supTheme.supTextFontColor = supTextColor
        return this
    }

    /**
     * 设置上标字体大小
     *
     * @param supTextSize 上标字体大小 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用SupTheme.setSupTextFontSize方法代替", since: "1.4.0"]
    public func setSupTextSize(supTextSize: Float64): MarkdownThemeBuilder {
        this.supTheme.supTextFontSize = supTextSize
        return this
    }

    /**
     * 设置上标偏移距离
     *
     * @param supOffsetDist 上标偏移距离 默认6.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用SupTheme.setSupTextBaselineOffset方法代替", since: "1.4.0"]
    public func setSupOffsetDist(supOffsetDist: Float64): MarkdownThemeBuilder {
        this.supTheme.supTextBaselineOffset = supOffsetDist
        return this
    }

    /**
     * 设置下划线颜色
     *
     * @param underlineColor 下划线颜色 默认0xFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HtmlUnderlineTheme.setHtmlUnderlineTextDecorationColor方法代替", since: "1.4.0"]
    public func setUnderlineColor(underlineColor: Color): MarkdownThemeBuilder {
        this.htmlUnderlineTheme.htmlUnderlineTextDecorationColor = underlineColor
        return this
    }

    /**
     * 设置下划线样式
     *
     * @param underlineStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    @Deprecated["用HtmlUnderlineTheme.setHtmlUnderlineTextDecorationStyle方法代替", since: "1.4.0"]
    public func setUnderlineStyle(underlineStyle: Int32): MarkdownThemeBuilder {
        match (underlineStyle) {
            case 0 => this.htmlUnderlineTheme.htmlUnderlineTextDecorationStyle = MarkdownTextDecorationStyle.SOLID
            case 1 => this.htmlUnderlineTheme.htmlUnderlineTextDecorationStyle = MarkdownTextDecorationStyle.DOUBLE
            case 2 => this.htmlUnderlineTheme.htmlUnderlineTextDecorationStyle = MarkdownTextDecorationStyle.DOTTED
            case 3 => this.htmlUnderlineTheme.htmlUnderlineTextDecorationStyle = MarkdownTextDecorationStyle.DASHED
            case 4 => this.htmlUnderlineTheme.htmlUnderlineTextDecorationStyle = MarkdownTextDecorationStyle.WAVY
            case _ => this.htmlUnderlineTheme.htmlUnderlineTextDecorationStyle = MarkdownTextDecorationStyle.SOLID
        }
        return this
    }

    /**
     * 返回Theme对象
     *
     * @return MarkdownTheme MarkdownTheme对象
     */
    public func build(): MarkdownTheme {
        return MarkdownTheme(this)
    }
}
