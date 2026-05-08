package markdown

import ohos.state_macro_manage.*

@Component
class CJMarkdownComponent {
    /**
     * 外部传入的Markdown文档
     */
    @State
    @Watch[onChanged]
    var mdStr: String = ''

    /**
     * 外部传入的Markdown文档
     */
    @State
    @Watch[inputEndedData]
    var isInputEnded: Bool = true

    /**
     * markdown是否增量解析
     */
    @State
    @Watch[analysisData]
    var incrementalAnalysis: Bool = false

    /**
     * 配置
     */
    var cfg: ?CJMarkdownConfig

    /**
     * 插件
     */
    var plugin: ?CJMarkdownPlugin

    /**
     * 滑动控制器
     */
    var listscroller: ?CJMarkdownScroller

    protected func aboutToAppear(): Unit {
    }

    func build() {
        Column() {
            MarkdownComponent(
                output: mdStr,
                isInputEnded: isInputEnded,
                incrementalAnalysis: incrementalAnalysis,
                markdownConfiguration: setConfig(),
                markdownPlugin: setPlugin(),
                scroller: setScroller()
            )
        }
    }

    func onChanged(): Unit {
    }

    func inputEndedData(): Unit {
    }

    func analysisData(): Unit {
    }

    public func updateMarkDown(input: String, isInputEnded: Bool, incrementalAnalysis: Bool): Unit {
        this.mdStr = input
        this.isInputEnded = isInputEnded
        this.incrementalAnalysis = incrementalAnalysis
    }

    public func aboutToCJReuse(input: String): Unit {
        mdStr = input
    }

    public func aboutToCJRecycle(input: String): Unit {
        mdStr = input
    }

    func setPlugin():Markdown{
        let markdownBuilder:MarkdownBuilder = Markdown.builder()
        if(let Some(v) <- plugin){
            if(v.isBlockAudioPlugin){
                markdownBuilder.usePlugin(BlockAudioPlugin.create())
            }
            if(v.isBlockVideoPlugin){
                markdownBuilder.usePlugin(BlockVideoPlugin.create())
            }
            if(v.isCodeListPlugin){
                markdownBuilder.usePlugin(CodeListPlugin.create())
            }
            if(v.isHtmlPlugin){
                markdownBuilder.usePlugin(HtmlPlugin.create())
            }
            if(v.isTablePlugin){
                markdownBuilder.usePlugin(TablePlugin.create())
            }
            if(v.isTaskListPlugin){
                markdownBuilder.usePlugin(TaskListPlugin.create())
            }
            if(v.isStrikethroughPlugin){
                markdownBuilder.usePlugin(StrikethroughPlugin.create())
            }
            if(v.isLinkifyPlugin){
                markdownBuilder.usePlugin(LinkifyPlugin.create(v.regs))
            }
            if(v.isLinkViewPlugin){
                markdownBuilder.usePlugin(LinkViewPlugin.create())
            }
            if(v.isLatexMathPlugin){
                markdownBuilder.usePlugin(LatexMathPluginV2.create())
            }
            if(v.isImageStylePlugin){
                markdownBuilder.usePlugin(ImageStylePlugin.create())
            }
            if(v.isImageSlidePlugin){
                markdownBuilder.usePlugin(ImageSlidePlugin.create())
            }
            if(v.isImageTextMixPlugin){
                markdownBuilder.usePlugin(ImageTextMixPlugin.create())
            }
            if(v.isDescListPlugin){
                markdownBuilder.usePlugin(DescListPlugin.create())
            }
            if(v.isHeadIDPlugin){
                markdownBuilder.usePlugin(IdHeadingPlugin.create())
            }
            if(v.isTocPlugin){
                markdownBuilder.usePlugin(TocPlugin.create())
            }
            if(v.isFootnotePlugin){
                markdownBuilder.usePlugin(FootnotePlugin.create())
            }
            if(v.isImageCollectPlugin){
                markdownBuilder.usePlugin(ImageCollectPlugin.create())
            }
            if(v.isSubPlugin){
                markdownBuilder.usePlugin(SubPlugin.create())
            }
            if(v.isSupPlugin){
                markdownBuilder.usePlugin(SupPlugin.create())
            }
            if(v.isEmojiPlugin){
                markdownBuilder.usePlugin(EmojiPlugin.create(v.isEmojiLight))
            }
        }
        // 唯一ID标识插件
        markdownBuilder.usePlugin(NodeIdPlugin.create())
        markdownBuilder.includeSourceSpans(2) // BLOCKS_AND_INLINES
        return markdownBuilder.build()
    }

    func setConfig(): MarkdownConfiguration {
        let markdownConfigurationBuilder: MarkdownConfigurationBuilder = MarkdownConfiguration.emptyBuilder()
        if (let Some(v) <- arkImgPreprocessFunc) {
            markdownConfigurationBuilder.setImageCallbackCallback(v) // 设置图片替换事件
        }
        if(let Some(w) <- cfg){
            markdownConfigurationBuilder.setMarkdownTheme(setTheme()) // 设置markdown默认样式
            if (let Some(v) <- w.linkCallback) {
                markdownConfigurationBuilder.setLinkCallback(v) // 设置链接的点击事件
            }
            if (let Some(v) <- w.textCopyCallback) {
                markdownConfigurationBuilder.setTextCopyCallback(v) // 设置文本复制的点击事件
            }
            if (let Some(v) <- w.imageCallback) {
                markdownConfigurationBuilder.setImageCallback(v) // 设置图片的点击事件
            }
            if (let Some(v) <- w.imageDownloadCallback) {
                markdownConfigurationBuilder.setImageDownloadCallback(v) // 图片下载的点击事件
            }
            if (let Some(v) <- w.audioCallback) {
                markdownConfigurationBuilder.setAudioCallback(v) // 设置音频的点击事件
            }
            if (let Some(v) <- w.videoCallback) {
                markdownConfigurationBuilder.setVideoCallback(v) // 设置视频的点击事件
            }
            if (let Some(v) <- w.videoImageCallback) {
                markdownConfigurationBuilder.setVideoImageCallback(v) // 设置视频的图片替换回调
            }
            if (let Some(v) <- w.videoReleaseCallback) {
                markdownConfigurationBuilder.setVideoReleaseCallback(v) // 设置视频发布的点击事件
            }
            if (let Some(v) <- w.videoDownloadCallback) {
                markdownConfigurationBuilder.setVideoDownloadCallback(v) // 设置视频下载的点击事件
            }
            if (let Some(v) <- w.codeCopyCallback) {
                markdownConfigurationBuilder.setCodeCopyCallback(v) // 设置代码复制按钮的点击事件
            }
            if (let Some(v) <- w.codeFullScreenCallback) {
                markdownConfigurationBuilder.setCodeFullScreenCallback(v) // 设置代码全屏按钮的点击事件
            }
            if (let Some(v) <- w.latexImageCallback) {
                markdownConfigurationBuilder.setLatexImageCallbackCallback(v) // 设置数学公式图片点击事件
            }
            if (let Some(v) <- w.latexStrCallback) {
                markdownConfigurationBuilder.setLatexStrCallback(v) // 设置数学公式数据处理事件
            }
            if (let Some(v) <- w.tocIndexCallback) {
                markdownConfigurationBuilder.setTocIndexCallback(v) // 设置TOC跳转指定位置
            }
            if (let Some(v) <- w.footnoteCallback) {
                markdownConfigurationBuilder.setFootnoteCallback(v) // 设置脚注跳转指定位置
            }
            if (let Some(v) <- w.nodeString) {
                markdownConfigurationBuilder.setNodeString(v) //
            }
        }
        let markdownConfiguration: MarkdownConfiguration = markdownConfigurationBuilder.build()
        return markdownConfiguration
    }

    func setScroller(): Scroller {
        if (let Some(scroller) <- listscroller) {
            return scroller.scroller
        } else {
            return Scroller()
        }
    }

    func setTheme(): MarkdownTheme {
        let markdownThemeBuilder: MarkdownThemeBuilder = MarkdownTheme.emptyBuilder()
        if(let Some(w) <- cfg){
            if (let Some(v) <- w.cjMarkdownTheme.cjMarkdownCodeBlockTheme.codeBlockIsDark) {
                // 设置markdown代码高亮样式
                if(v){
                    markdownThemeBuilder.setPrismTheme(PrismThemeDarcula.create()) // 深色
                }else{
                    markdownThemeBuilder.setPrismTheme(PrismThemeDefault.create()) // 浅色
                }
            }
            markdownThemeBuilder.setGlobalTheme(setGlobalTheme(w.cjMarkdownTheme.cjMarkdownGlobalTheme)) // 全局样式
            markdownThemeBuilder.setParagraphTheme(setParagraphTheme(w.cjMarkdownTheme.cjMarkdownParagraphTheme)) // 段落样式
            markdownThemeBuilder.setHeadingTheme(setHeadingTheme(w.cjMarkdownTheme.cjMarkdownHeadingTheme)) // 标题样式
            markdownThemeBuilder.setTableTheme(setTableTheme(w.cjMarkdownTheme.cjMarkdownTableTheme)) // 表格样式
            markdownThemeBuilder.setDividerTheme(setDividerTheme(w.cjMarkdownTheme.cjMarkdownDividerTheme)) // 分割线样式
            markdownThemeBuilder.setBlockQuoteTheme(setBlockQuoteTheme(w.cjMarkdownTheme.cjMarkdownBlockQuoteTheme)) // 块引用样式
            markdownThemeBuilder.setOrderedListTheme(setOrderedListTheme(w.cjMarkdownTheme.cjMarkdownOrderedListTheme)) // 有序列表样式
            markdownThemeBuilder.setBulletListTheme(setBulletListTheme(w.cjMarkdownTheme.cjMarkdownBulletListTheme)) // 无序/任务列表样式
            markdownThemeBuilder.setDefinitionListTheme(setDefinitionListTheme(w.cjMarkdownTheme.cjMarkdownDefinitionListTheme)) // 定义列表样式
            markdownThemeBuilder.setCodeBlockTheme(setCodeBlockTheme(w.cjMarkdownTheme.cjMarkdownCodeBlockTheme)) // 代码块样式
            markdownThemeBuilder.setAudioTheme(setAudioTheme(w.cjMarkdownTheme.cjMarkdownAudioTheme)) // 音频样式
            markdownThemeBuilder.setVideoTheme(setVideoTheme(w.cjMarkdownTheme.cjMarkdownVideoTheme)) // 视频样式
            markdownThemeBuilder.setBannerTheme(setBannerTheme(w.cjMarkdownTheme.cjMarkdownBannerTheme)) // banner样式
            markdownThemeBuilder.setFootnoteDefTheme(setFootnoteDefTheme(w.cjMarkdownTheme.cjMarkdownFootnoteDefTheme)) // 脚注定义样式
            markdownThemeBuilder.setFootnoteRefTheme(setFootnoteRefTheme(w.cjMarkdownTheme.cjMarkdownFootnoteRefTheme)) // 脚注引用样式
            markdownThemeBuilder.setInlineCodeTheme(setInlineCodeTheme(w.cjMarkdownTheme.cjMarkdownInlineCodeTheme)) // 内联代码样式
            markdownThemeBuilder.setBoldTheme(setBoldTheme(w.cjMarkdownTheme.cjMarkdownBoldTheme)) // 加粗文本样式
            markdownThemeBuilder.setLatexMathTheme(setLatexMathTheme(w.cjMarkdownTheme.cjMarkdownLatexMathTheme)) // 数学公式样式
            markdownThemeBuilder.setHtmlUnderlineTheme(setHtmlUnderlineTheme(w.cjMarkdownTheme.cjMarkdownHtmlUnderlineTheme)) // HTML下划线文本样式
            markdownThemeBuilder.setImageTheme(setImageTheme(w.cjMarkdownTheme.cjMarkdownImageTheme)) // 图片样式
            markdownThemeBuilder.setItalicTheme(setItalicTheme(w.cjMarkdownTheme.cjMarkdownItalicTheme)) // 斜体文本样式
            markdownThemeBuilder.setLinkTheme(setLinkTheme(w.cjMarkdownTheme.cjMarkdownLinkTheme))// 链接文本样式
            markdownThemeBuilder.setStrikethroughTheme(setStrikethroughTheme(w.cjMarkdownTheme.cjMarkdownStrikethroughTheme)) // 删除线文本样式
            markdownThemeBuilder.setSubTheme(setSubTheme(w.cjMarkdownTheme.cjMarkdownSubTheme)) // 下标文本样式
            markdownThemeBuilder.setSupTheme(setSupTheme(w.cjMarkdownTheme.cjMarkdownSupTheme)) // 上标文本样式
        }
        let markdownTheme: MarkdownTheme = markdownThemeBuilder.build()
        return markdownTheme
    }

}
