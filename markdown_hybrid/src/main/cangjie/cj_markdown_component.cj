package markdown_hybrid

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
    var listScroller: ?CJMarkdownScroller

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

    func setPlugin(): Markdown {
        let markdownBuilder: MarkdownBuilder = Markdown.builder()
        if (let Some(v) <- plugin) {
            if (v.isBlockAudioPlugin) {
                markdownBuilder.usePlugin(BlockAudioPlugin.create())
            }
            if (v.isBlockVideoPlugin) {
                markdownBuilder.usePlugin(BlockVideoPlugin.create())
            }
            if (v.isCodeListPlugin) {
                markdownBuilder.usePlugin(CodeListPlugin.create())
            }
            if (v.isHtmlPlugin) {
                markdownBuilder.usePlugin(HtmlPlugin.create())
            }
            if (v.isTablePlugin) {
                markdownBuilder.usePlugin(TablePlugin.create())
            }
            if (v.isTaskListPlugin) {
                markdownBuilder.usePlugin(TaskListPlugin.create())
            }
            if (v.isStrikethroughPlugin) {
                markdownBuilder.usePlugin(StrikethroughPlugin.create())
            }
            if (v.isLinkifyPlugin) {
                markdownBuilder.usePlugin(LinkifyPlugin.create(v.regs))
            }
            if (v.isLinkViewPlugin) {
                markdownBuilder.usePlugin(LinkViewPlugin.create())
            }
            if (v.isLatexMathPlugin) {
                markdownBuilder.usePlugin(LatexMathPluginV2.create())
            }
            if (v.isImageStylePlugin) {
                markdownBuilder.usePlugin(ImageStylePlugin.create())
            }
            if (v.isImageSlidePlugin) {
                markdownBuilder.usePlugin(ImageSlidePlugin.create())
            }
            if (v.isImageTextMixPlugin) {
                markdownBuilder.usePlugin(ImageTextMixPlugin.create())
            }
            if (v.isDescListPlugin) {
                markdownBuilder.usePlugin(DescListPlugin.create())
            }
            if (v.isHeadIDPlugin) {
                markdownBuilder.usePlugin(IdHeadingPlugin.create())
            }
            if (v.isTocPlugin) {
                markdownBuilder.usePlugin(TocPlugin.create())
            }
            if (v.isFootnotePlugin) {
                markdownBuilder.usePlugin(FootnotePlugin.create())
            }
            if (v.isImageCollectPlugin) {
                markdownBuilder.usePlugin(ImageCollectPlugin.create())
            }
            if (v.isSubPlugin) {
                markdownBuilder.usePlugin(SubPlugin.create())
            }
            if (v.isSupPlugin) {
                markdownBuilder.usePlugin(SupPlugin.create())
            }
            if (v.isEmojiPlugin) {
                markdownBuilder.usePlugin(EmojiPlugin.create(v.isEmojiLight))
            }
            if (v.isHighlightPlugin) {
                markdownBuilder.usePlugin(HighlightDelimeterPlugin.create())
            }
            if (v.isWhitelistPlugin) {
                markdownBuilder.usePlugin(WhitelistLooseDelimiterPlugin.create(v.mode))
            }
            // 自定义卡片插件（图片/链接满足回调条件时渲染为自定义卡片）
            if (v.isBlockCustomCardPlugin || v.blockImageCard.isSome() || v.blockLinkCard.isSome()) {
                var blockImage: ?(CardBean) -> Bool = None
                var blockLink: ?(CardBean) -> Bool = None
                if (let Some(cb) <- v.blockImageCard) {
                    blockImage = { bean: CardBean =>
                        cb(bean.getDescription() ?? (bean.getDestination() ?? ""),
                            bean.getDestination() ?? "",
                            bean.getTitle() ?? "")
                    }
                }
                if (let Some(cb) <- v.blockLinkCard) {
                    blockLink = { bean: CardBean =>
                        cb(bean.getDescription() ?? (bean.getDestination() ?? ""),
                            bean.getDestination() ?? "",
                            bean.getTitle() ?? "")
                    }
                }
                markdownBuilder.usePlugin(BlockCustomCardPlugin.create(blockImage: blockImage, blockLink: blockLink))
            }
        }
        markdownBuilder.usePlugin(NodeIdPlugin.create()) // 唯一ID标识插件
        // 自定义块级卡片（图片/链接满足回调条件时渲染为自定义卡片）
        if (let Some(w) <- cfg) {
            var blockImage: ?(CardBean) -> Bool = None
            var blockLink: ?(CardBean) -> Bool = None
            // 兼容旧接口：满足自定义块级图片的条件（图片alt/description）
            if (let Some(v) <- w.isBlockImageCustom) {
                blockImage = { bean: CardBean => v(bean.getDescription() ?? (bean.getDestination() ?? "")) }
            }
            // 新接口：自定义卡片插件（desc, url, title 三参回调）
            if (w.isBlockCustomCardPlugin || w.blockImageCard.isSome() || w.blockLinkCard.isSome()) {
                if (let Some(v) <- w.blockImageCard) {
                    blockImage = { bean: CardBean =>
                        v(bean.getDescription() ?? (bean.getDestination() ?? ""),
                            bean.getDestination() ?? "",
                            bean.getTitle() ?? "")
                    }
                }
                if (let Some(v) <- w.blockLinkCard) {
                    blockLink = { bean: CardBean =>
                        v(bean.getDescription() ?? (bean.getDestination() ?? ""),
                            bean.getDestination() ?? "",
                            bean.getTitle() ?? "")
                    }
                }
            }
            if (blockImage.isSome() || blockLink.isSome()) {
                markdownBuilder.usePlugin(BlockCustomCardPlugin.create(blockImage: blockImage, blockLink: blockLink))
            }
        }
        if (incrementalAnalysis) {
            markdownBuilder.includeSourceSpans(2) // BLOCKS_AND_INLINES
        }
        return markdownBuilder.build()
    }

    func setConfig(): MarkdownConfiguration {
        let markdownConfiguration: MarkdownConfiguration = MarkdownConfiguration.create()
        if (let Some(v) <- arkImgPreprocessFunc) {
            markdownConfiguration.setImageCallbackCallback(v) // 设置图片替换事件
        }
        if (let Some(w) <- cfg) {
            markdownConfiguration.setMarkdownTheme(setTheme()) // 设置markdown默认样式
            if (let Some(v) <- w.linkCallback) {
                markdownConfiguration.setLinkCallback(v) // 设置链接的点击事件
            }
            if (let Some(v) <- w.textCopyCallback) {
                markdownConfiguration.setTextCopyCallback(v) // 设置文本复制的点击事件
            }
            if (let Some(v) <- w.imageCallback) {
                markdownConfiguration.setImageCallback(v) // 设置图片的点击事件
            }
            if (let Some(v) <- w.imageDownloadCallback) {
                markdownConfiguration.setImageDownloadCallback(v) // 图片下载的点击事件
            }
            if (let Some(v) <- w.audioCallback) {
                markdownConfiguration.setAudioCallback(v) // 设置音频的点击事件
            }
            if (let Some(v) <- w.videoCallback) {
                markdownConfiguration.setVideoCallback(v) // 设置视频的点击事件
            }
            if (let Some(v) <- w.videoImageCallback) {
                markdownConfiguration.setVideoImageCallback(v) // 设置视频的图片替换回调
            }
            if (let Some(v) <- w.videoReleaseCallback) {
                markdownConfiguration.setVideoReleaseCallback(v) // 设置视频发布的点击事件
            }
            if (let Some(v) <- w.videoDownloadCallback) {
                markdownConfiguration.setVideoDownloadCallback(v) // 设置视频下载的点击事件
            }
            if (let Some(v) <- w.codeCopyCallback) {
                markdownConfiguration.setCodeCopyCallback(v) // 设置代码复制按钮的点击事件
            }
            if (let Some(v) <- w.codeFullScreenCallback) {
                markdownConfiguration.setCodeFullScreenCallback(v) // 设置代码全屏按钮的点击事件
            }
            if (let Some(v) <- w.latexImageCallback) {
                markdownConfiguration.setLatexImageCallbackCallback(v) // 设置数学公式图片点击事件
            }
            if (let Some(v) <- w.latexStrCallback) {
                markdownConfiguration.setLatexStrCallback(v) // 设置数学公式数据处理事件
            }
            if (let Some(v) <- w.tocIndexCallback) {
                markdownConfiguration.setTocIndexCallback(v) // 设置TOC跳转指定位置
            }
            if (let Some(v) <- w.footnoteCallback) {
                markdownConfiguration.setFootnoteCallback(v) // 设置脚注跳转指定位置
            }
            if (let Some(v) <- w.nodeString) {
                markdownConfiguration.setNodeString(v) // 设置全局文本对象
            }
            if (let Some(v) <- w.tableCopyCallback) {
                markdownConfiguration.setTableCopyCallback(v) // 设置表格复制按钮的点击事件
            }
            if (let Some(v) <- w.elementExposureCallback) {
                // 设置元素曝光回调 - 将底层事件转换为互操作事件
                markdownConfiguration.setElementExposureCallback({ event: MarkdownExposureEvent =>
                    let cjEvent = CJMarkdownExposureEvent()
                    cjEvent.eventType = event.eventType
                    cjEvent.visible = event.visible
                    cjEvent.data = event.data
                    v(cjEvent)
                })
            }
            markdownConfiguration.setExposureThreshold(w.exposureThreshold) // 曝光可见阈值
            markdownConfiguration.setMarkdownHighlightParagraph(w.cjMarkdownHighlightParagraph.highlightParagraph) // 段落高亮配置
            if (let Some(v) <- w.cjScrollController) {
                markdownConfiguration.setScrollController(v.scrollController) // 外层滚动控制器
            }
            if (let Some(v) <- w.paragraphHeadingAnimationStart) {
                markdownConfiguration.setParagraphHeadingAnimationStart(v) // 段落动画开始回调
            }
            if (let Some(v) <- w.paragraphHeadingAnimationEnd) {
                markdownConfiguration.setParagraphHeadingAnimationEnd(v) // 段落动画结束回调
            }
            if (let Some(v) <- w.customLongPressCallback) {
                markdownConfiguration.setCustomLongPressCallback(v) // 段落长按回调
            }
        }
        return markdownConfiguration
    }

    func setScroller(): Scroller {
        if (let Some(scroller) <- listScroller) {
            return scroller.scroller
        } else {
            return Scroller()
        }
    }

    func setTheme(): MarkdownTheme {
        let markdownTheme: MarkdownTheme = MarkdownTheme.create()
        if (let Some(w) <- cfg) {
            if (let Some(v) <- w.cjMarkdownTheme.cjMarkdownCodeBlockTheme.codeBlockIsDark) {
                // 设置markdown代码高亮样式
                if (v) {
                    markdownTheme.setPrismTheme(PrismThemeDarcula.create()) // 深色
                } else {
                    markdownTheme.setPrismTheme(PrismThemeDefault.create()) // 浅色
                }
            }
            markdownTheme.setGlobalTheme(setGlobalTheme(w.cjMarkdownTheme.cjMarkdownGlobalTheme)) // 全局样式
            markdownTheme.setParagraphTheme(setParagraphTheme(w.cjMarkdownTheme.cjMarkdownParagraphTheme)) // 段落样式
            markdownTheme.setHeadingTheme(setHeadingTheme(w.cjMarkdownTheme.cjMarkdownHeadingTheme)) // 标题样式
            markdownTheme.setTableTheme(setTableTheme(w.cjMarkdownTheme.cjMarkdownTableTheme)) // 表格样式
            markdownTheme.setDividerTheme(setDividerTheme(w.cjMarkdownTheme.cjMarkdownDividerTheme)) // 分割线样式
            markdownTheme.setBlockQuoteTheme(setBlockQuoteTheme(w.cjMarkdownTheme.cjMarkdownBlockQuoteTheme)) // 块引用样式
            markdownTheme.setOrderedListTheme(setOrderedListTheme(w.cjMarkdownTheme.cjMarkdownOrderedListTheme)) // 有序列表样式
            markdownTheme.setBulletListTheme(setBulletListTheme(w.cjMarkdownTheme.cjMarkdownBulletListTheme)) // 无序/任务列表样式
            markdownTheme.setDefinitionListTheme(setDefinitionListTheme(w.cjMarkdownTheme.cjMarkdownDefinitionListTheme)) // 定义列表样式
            markdownTheme.setCodeBlockTheme(setCodeBlockTheme(w.cjMarkdownTheme.cjMarkdownCodeBlockTheme)) // 代码块样式
            markdownTheme.setAudioTheme(setAudioTheme(w.cjMarkdownTheme.cjMarkdownAudioTheme)) // 音频样式
            markdownTheme.setVideoTheme(setVideoTheme(w.cjMarkdownTheme.cjMarkdownVideoTheme)) // 视频样式
            markdownTheme.setBannerTheme(setBannerTheme(w.cjMarkdownTheme.cjMarkdownBannerTheme)) // banner样式
            markdownTheme.setFootnoteDefTheme(setFootnoteDefTheme(w.cjMarkdownTheme.cjMarkdownFootnoteDefTheme)) // 脚注定义样式
            markdownTheme.setFootnoteRefTheme(setFootnoteRefTheme(w.cjMarkdownTheme.cjMarkdownFootnoteRefTheme)) // 脚注引用样式
            markdownTheme.setInlineCodeTheme(setInlineCodeTheme(w.cjMarkdownTheme.cjMarkdownInlineCodeTheme)) // 内联代码样式
            markdownTheme.setBoldTheme(setBoldTheme(w.cjMarkdownTheme.cjMarkdownBoldTheme)) // 加粗文本样式
            markdownTheme.setLatexMathTheme(setLatexMathTheme(w.cjMarkdownTheme.cjMarkdownLatexMathTheme)) // 数学公式样式
            markdownTheme.setHtmlUnderlineTheme(setHtmlUnderlineTheme(w.cjMarkdownTheme.cjMarkdownHtmlUnderlineTheme)) // HTML下划线文本样式
            markdownTheme.setImageTheme(setImageTheme(w.cjMarkdownTheme.cjMarkdownImageTheme)) // 图片样式
            markdownTheme.setItalicTheme(setItalicTheme(w.cjMarkdownTheme.cjMarkdownItalicTheme)) // 斜体文本样式
            markdownTheme.setLinkTheme(setLinkTheme(w.cjMarkdownTheme.cjMarkdownLinkTheme)) // 链接文本样式
            markdownTheme.setStrikethroughTheme(setStrikethroughTheme(w.cjMarkdownTheme.cjMarkdownStrikethroughTheme)) // 删除线文本样式
            markdownTheme.setSubTheme(setSubTheme(w.cjMarkdownTheme.cjMarkdownSubTheme)) // 下标文本样式
            markdownTheme.setSupTheme(setSupTheme(w.cjMarkdownTheme.cjMarkdownSupTheme)) // 上标文本样式
        }
        return markdownTheme
    }

}
