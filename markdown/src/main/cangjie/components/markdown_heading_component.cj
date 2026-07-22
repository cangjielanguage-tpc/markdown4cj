package markdown.components

import ohos.state_macro_manage.*

/**
 * 标题控件
 */
@Component
class MarkdownHeadingComponent {
    @Prop
    var headingMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var headingNodeView: NodeView // 标题控件自身节点
    @Prop
    var headingComponentWidth: Float64 // 控件宽度 - 单位vp
    @BuilderParam
    var headingCustomHeadingLineBuilder: (NodeView, Int64) -> Unit // 自定义行内标题控件
    var headingImageCallback: (String) -> Unit // 图片点击事件
    var headingFootnoteCallback: (String) -> Unit // 脚注点击事件
    @BuilderParam
    var blockImageCardComponent: (?String,?String, ?String) -> Unit  //自定义卡片布局块级图片
    @BuilderParam
    var inlineImageCardComponent: (?String,?String, ?String) -> Unit  //自定义卡片布局行内图片
    @BuilderParam
    var inlineLinkCardComponent: (?String, ?String) -> Unit  //自定义卡片布局行内链接
    @State
    var isRefresh: Bool = false // 标题子节点是否不为0
    @State
    var isOneLink: Bool = false // 是否只有一条链接数据
    @State
    var headingNodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>() // 列表数据
    @State
    var headingHighlightColor: Color = COLOR_TRANSPARENT // 标题高亮颜色
    @State
    var hasHeadingHighlight: Bool = false // 标题是否处于高亮状态
    // 链接曝光：URL列表缓存 + 当前可见状态（与MarkdownParagraphComponent同款）
    // 简化版：Text级别曝光，与屏幕 [0, screenH] 求交判定可见性
    var headingExposureUrls: ArrayList<String> = ArrayList<String>()
    var headingExposureVisible: Bool = false
    var headingId: String = "" // 标题Text的唯一id（componentUtils.getRectangleById 用）
    var viewportReady: Bool = false // onAreaChange是否触发过
    var isAlive: Bool = true // 组件是否存活

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(headingNodeView.nodeHash, refreshHeadingData)
        refreshHeadingData(headingNodeView)
        // 标题Text的唯一id
        headingId = "md-exp-${headingNodeView.nodeHash}"
        // 链接曝光：仅提取URL列表缓存
        if (isExposureEnabled()) {
            headingExposureUrls = MarkdownLinkExposureRegistry.extractHttpLinks(headingNodeView)
        }
        // 段落高亮注册
        MarkdownHighlightRegistry.register(headingNodeView.nodeHash, { color: ?Color =>
            if (let Some(c) <- color) {
                headingHighlightColor = c
                hasHeadingHighlight = true
            } else {
                hasHeadingHighlight = false
            }
        })
        // 段落加载动画回调
        if (headingMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphAnimationEnabled) {
            if (let Some(cb) <- headingMarkdownConfiguration.paragraphAnimationStart) {
                cb()
            }
            let duration = headingMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphAnimationDuration
            let endCb = headingMarkdownConfiguration.paragraphAnimationEnd
            Timer.once(Int64(duration) * Duration.millisecond, { =>
                if (let Some(cb) <- endCb) {
                    cb()
                }
            })
        }
    }

    protected override func aboutToDisappear(): Unit {
        isAlive = false
        MarkdownRefreshRegistry.unregister(headingNodeView.nodeHash)
        if (headingExposureVisible) {
            MarkdownLinkExposureRegistry.unregister(headingNodeView.nodeHash)
            headingExposureVisible = false
        }
        MarkdownHighlightRegistry.unregister(headingNodeView.nodeHash)
    }

    /**
     * 是否启用元素曝光统计：查 registry（不依赖 @Prop 的 MarkdownConfiguration.elementExposureCallback）
     */
    func isExposureEnabled(): Bool {
        return MarkdownLinkExposureRegistry.isExposureEnabled()
    }

    /**
     * 防抖触发曝光评估
     */
    func scheduleExposure(): Unit {
        if (!isAlive) {
            return
        }
        if (!isExposureEnabled()) {
            return
        }
        if (headingExposureUrls.size == 0) {
            return
        }
        spawn {
            sleep(Duration.millisecond * 16)
            launch {
                if (isAlive && viewportReady) {
                    evaluateExposure()
                }
            }
        }
    }

    /**
     * 曝光评估：用 componentUtils 拿标题全局 rect，与屏幕 [0, screenH] 求交，判定可见性
     * 简化版：Text级别曝光
     */
    func evaluateExposure(): Unit {
        var globalTop: Float64 = 0.0
        var globalBottom: Float64 = 0.0
        try {
            let info = ComponentUtils.getRectangleById(headingId)
            globalTop = Float64(info.windowOffset.y)
            globalBottom = globalTop + Float64(info.size.height)
        } catch (_: Exception) {
            return
        }
        let screenHeight = Float64(getDefaultDisplaySync().height)
        let vpTop = 0.0
        let vpBottom = screenHeight
        let clipTop = if (vpTop > globalTop) { vpTop } else { globalTop }
        let clipBottom = if (vpBottom < globalBottom) { vpBottom } else { globalBottom }
        let visibleHeight = if (clipBottom > clipTop) { clipBottom - clipTop } else { 0.0 }
        let headingHeight = if (globalBottom > globalTop) { globalBottom - globalTop } else { 0.0 }
        let ratio = if (headingHeight > 0.0) { visibleHeight / headingHeight } else { 0.0 }
        let threshold = MarkdownLinkExposureRegistry.getExposureThreshold()
        if (ratio >= threshold && !headingExposureVisible) {
            headingExposureVisible = true
            MarkdownLinkExposureRegistry.register(headingNodeView.nodeHash, headingExposureUrls)
        } else if (ratio < threshold && headingExposureVisible) {
            headingExposureVisible = false
            MarkdownLinkExposureRegistry.unregister(headingNodeView.nodeHash)
        }
    }

    /**
     * 获取标题背景色：高亮时用高亮色，否则用默认背景色
     */
    func getHeadingBackground(): Color {
        if (hasHeadingHighlight) {
            return headingHighlightColor
        }
        return headingBackgroundColor(headingNodeView.headingLevel, headingMarkdownConfiguration.markdownTheme, headingNodeView)
    }

    /**
     * 获取标题加载动画转场效果
     * 启用时使用渐显（OPACITY），禁用时使用IDENTITY（无效果）
     */
    func getTransitionEffect(): TransitionEffect {
        if (headingMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphAnimationEnabled) {
            return TransitionEffect.OPACITY.animation(AnimateParam(duration: headingMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphAnimationDuration))
        }
        return TransitionEffect.IDENTITY
    }

    func build() {
        Row() {
            Column() {
                if (headingNodeViewList.size == 1 && headingNodeViewList[0].nodeType == "Image"
                  && headingMarkdownConfiguration.isBlockImageCustom.isSome() && headingNodeViewList[0].imageAltText.isSome()
                  && headingMarkdownConfiguration.isBlockImageCustom.getOrThrow()(headingNodeViewList[0].imageAltText.getOrThrow())){
                    // card图片组件
                    blockImageCardComponent(headingNodeViewList[0].imageAltText,headingNodeViewList[0].imageUrl(),headingNodeViewList[0].imageTitle())
                } else if (!headingMarkdownConfiguration.markdownTheme.imageTheme.isImageMixedLayout && headingNodeViewList.size == 1 && (headingNodeViewList[0].nodeType == "Image" || headingNodeViewList[0].nodeType == "StyleImage" || headingNodeViewList[0].nodeType == "ImageHtmlNode")) {
                    if (headingMarkdownConfiguration.imageReplaceCallback.isNone()) {
                        if (headingNodeViewList[0].imageUrl.getOrThrow().startsWith("./")) {
                            MarkdownImageRawFileComponent(
                                rawFileMarkdownTheme: headingMarkdownConfiguration.markdownTheme,
                                rawFileDestination: headingNodeViewList[0].imageUrl.getOrThrow(),
                                rawFileComponentWidth: headingComponentWidth,
                                rawFileImageDownloadCallback: headingMarkdownConfiguration.imageDownloadCallback,
                                rawFileImageCallback: headingImageCallback,
                                rawFileLinkCallback: headingMarkdownConfiguration.linkCallback,
                                rawFileLink: headingNodeViewList[0].isLink,
                                rawFileLinkUrl: headingNodeViewList[0].linkUrl,
                                rawFileImageWidth: headingNodeViewList[0].imageWidth,
                                rawFileImageHeight: headingNodeViewList[0].imageHeight,
                                rawFileImageRadius: headingNodeViewList[0].imageRadius,
                                rawFileImageAlign: headingNodeViewList[0].imageAlign
                            )
                        } else {
                            MarkdownImageUrlComponent(
                                urlMarkdownTheme: headingMarkdownConfiguration.markdownTheme,
                                urlDestination: headingNodeViewList[0].imageUrl.getOrThrow(),
                                urlComponentWidth: headingComponentWidth,
                                urlImageDownloadCallback: headingMarkdownConfiguration.imageDownloadCallback,
                                urlImageCallback: headingImageCallback,
                                urlLinkCallback: headingMarkdownConfiguration.linkCallback,
                                urlLink: headingNodeViewList[0].isLink,
                                urlLinkUrl: headingNodeViewList[0].linkUrl,
                                urlImageWidth: headingNodeViewList[0].imageWidth,
                                urlImageHeight: headingNodeViewList[0].imageHeight,
                                urlImageRadius: headingNodeViewList[0].imageRadius,
                                urlImageAlign: headingNodeViewList[0].imageAlign
                            )
                        }
                    } else {
                        if (headingNodeViewList[0].imageUrl.getOrThrow().startsWith("./")) {
                            MarkdownImageCallbackRawFileComponent(
                                rawFileCallbackMarkdownTheme: headingMarkdownConfiguration.markdownTheme,
                                rawFileCallbackDestination: headingNodeViewList[0].imageUrl.getOrThrow(),
                                rawFileCallbackComponentWidth: headingComponentWidth,
                                rawFileCallbackImageDownloadCallback: headingMarkdownConfiguration.imageDownloadCallback,
                                rawFileCallbackImageReplaceCallback: headingMarkdownConfiguration.imageReplaceCallback.getOrThrow(),
                                rawFileCallbackImageCallback: headingImageCallback,
                                rawFileCallbackLinkCallback: headingMarkdownConfiguration.linkCallback,
                                rawFileCallbackLink: headingNodeViewList[0].isLink,
                                rawFileCallbackLinkUrl: headingNodeViewList[0].linkUrl,
                                rawFileCallbackImageWidth: headingNodeViewList[0].imageWidth,
                                rawFileCallbackImageHeight: headingNodeViewList[0].imageHeight,
                                rawFileCallbackImageRadius: headingNodeViewList[0].imageRadius,
                                rawFileCallbackImageAlign: headingNodeViewList[0].imageAlign
                            )
                        } else {
                            MarkdownImageCallbackUrlComponent(
                                urlCallbackMarkdownTheme: headingMarkdownConfiguration.markdownTheme,
                                urlCallbackDestination: headingNodeViewList[0].imageUrl.getOrThrow(),
                                urlCallbackComponentWidth: headingComponentWidth,
                                urlCallbackImageDownloadCallback: headingMarkdownConfiguration.imageDownloadCallback,
                                urlCallbackImageReplaceCallback: headingMarkdownConfiguration.imageReplaceCallback.getOrThrow(),
                                urlCallbackImageCallback: headingImageCallback,
                                urlCallbackLinkCallback: headingMarkdownConfiguration.linkCallback,
                                urlCallbackLink: headingNodeViewList[0].isLink,
                                urlCallbackLinkUrl: headingNodeViewList[0].linkUrl,
                                urlCallbackImageWidth: headingNodeViewList[0].imageWidth,
                                urlCallbackImageHeight: headingNodeViewList[0].imageHeight,
                                urlCallbackImageRadius: headingNodeViewList[0].imageRadius,
                                urlCallbackImageAlign: headingNodeViewList[0].imageAlign
                            )
                        }
                    }
                } else {
                    headingTitleComponent()
                }
                // 一级二级标题是否显示下划线
                if (headingNodeView.headingLevel == 1 && headingMarkdownConfiguration.markdownTheme.headingTheme.heading1UnderlineHeight > 0.0) {
                    Divider()
                        .color(headingMarkdownConfiguration.markdownTheme.headingTheme.heading1UnderlineColor)
                        .strokeWidth(headingMarkdownConfiguration.markdownTheme.headingTheme.heading1UnderlineHeight)
                        .margin(top: headingMarkdownConfiguration.markdownTheme.headingTheme.heading1UnderlineSpacing)
                } else if (headingNodeView.headingLevel == 2 && headingMarkdownConfiguration.markdownTheme.headingTheme.heading2UnderlineHeight > 0.0) {
                    Divider()
                        .color(headingMarkdownConfiguration.markdownTheme.headingTheme.heading2UnderlineColor)
                        .strokeWidth(headingMarkdownConfiguration.markdownTheme.headingTheme.heading2UnderlineHeight)
                        .margin(top: headingMarkdownConfiguration.markdownTheme.headingTheme.heading2UnderlineSpacing)
                }
            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Center)
            .layoutWeight(1)
        }
        .backgroundColor(getHeadingBackground())
        .padding(
            top: headingPaddingTop(headingNodeView.headingLevel, headingMarkdownConfiguration.markdownTheme),
            right: headingPaddingRight(headingNodeView.headingLevel, headingMarkdownConfiguration.markdownTheme),
            bottom: headingPaddingBottom(headingNodeView.headingLevel, headingMarkdownConfiguration.markdownTheme),
            left: headingPaddingLeft(headingNodeView.headingLevel, headingMarkdownConfiguration.markdownTheme)
        )
        .margin(
            top: headingMarginTop(headingNodeView.headingLevel, headingMarkdownConfiguration.markdownTheme),
            right: headingMarginRight(headingNodeView.headingLevel, headingMarkdownConfiguration.markdownTheme),
            bottom: headingMarginBottom(headingNodeView.headingLevel, headingMarkdownConfiguration.markdownTheme),
            left: headingMarginLeft(headingNodeView.headingLevel, headingMarkdownConfiguration.markdownTheme)
        )
        .transition(getTransitionEffect())
    }

    /**
     * 标题文字内容
     */
    @Builder
    func headingTitleComponent() {
        Text() {
            if (isRefresh) {
                markdownSpanListComponent(
                    headingNodeViewList,
                    headingMarkdownConfiguration,
                    headingComponentWidth,
                    Option<(Int64) -> Unit>.None,
                    headingImageCallback,
                    headingFootnoteCallback
                )
            }
        }
        .textAlign(TextAlign.Start)
        .halfLeading(true)
        .copyOption(if (headingMarkdownConfiguration.markdownTheme.globalTheme.isOnCopy) {
            CopyOptions.LocalDevice
        } else {
            CopyOptions.None
        })
        .onCopy({
            str => if (let Some(v) <- headingMarkdownConfiguration.textCopyCallback) {
                v(str)
            }
        })
        // 链接曝光：Text 的唯一 id
        .id(headingId)
        .onVisibleAreaChange(
            [0.0, 0.01, 0.1, 0.25, 0.5, 0.75, 1.0],
            { _: Bool, _: Float64 =>
                if (isExposureEnabled()) {
                    scheduleExposure()
                }
            }
        )
        .onAreaChange({
            old, new =>
                if (isExposureEnabled()) {
                    viewportReady = true
                    scheduleExposure()
                }
        })
    }

    /**
     * Span循环列表
     *
     * @param spanListNodeViewList NodeView列表
     * @param spanListMarkdownConfiguration markdown配置
     * @param spanListComponentWidth 最大宽度
     * @param spanListTocListOnClick TOC点击事件
     * @param spanListImageCallback 图片点击事件
     * @param spanListFootnoteCallback 脚注点击事件
     */
    @Builder
    func markdownSpanListComponent(
        spanListNodeViewList: ObservedArrayList<NodeView>,
        spanListMarkdownConfiguration: MarkdownConfiguration,
        spanListComponentWidth: Float64,
        spanListTocListOnClick: ?(Int64) -> Unit,
        spanListImageCallback: (String) -> Unit,
        spanListFootnoteCallback: (String) -> Unit
    ) {
        ForEach(
            spanListNodeViewList,
            itemGeneratorFunc: {
                spanListNodeView: NodeView, index: Int64 => if (spanListNodeView.nodeType == "Text" ||spanListNodeView.nodeType == "Code" || spanListNodeView.nodeType == "Footnote") {
                    // Text：普通文本，Code：内联代码，Footnote：脚注节点
                    markdownSpanComponent(
                        spanListMarkdownConfiguration,
                        spanListNodeView,
                        spanListTocListOnClick,
                        spanListFootnoteCallback,
                        false
                    )
                } else if (spanListNodeView.nodeType == "LatexMathNode") {
                    // 数学公式
                    MarkdownLatexMathInLineComponent(
                        markdownTheme: spanListMarkdownConfiguration.markdownTheme,
                        latexMathInLineStr: spanListNodeView.nodeText,
                        nodeHash: spanListNodeView.nodeHash,
                        latexMathInLineComponentWidth: spanListComponentWidth,
                        latexImageCallback: spanListMarkdownConfiguration.latexImageCallback,
                        latexStrCallback: spanListMarkdownConfiguration.latexStrCallback,
                        latexMathInLineLinkCallback: spanListMarkdownConfiguration.linkCallback,
                        latexMathInLineIsLink: spanListNodeView.isLink,
                        latexMathInLineLinkUrl: spanListNodeView.linkUrl
                    )
                } else if (spanListNodeView.nodeType == "SoftLineBreak") {
                    // 软换行
                    Span(spanSoftLineBreak(spanListMarkdownConfiguration.markdownTheme.globalTheme.isLineBreak))
                } else if (spanListNodeView.nodeType == "HardLineBreak") {
                    // 硬换行
                    Span("\n")
                } else if (spanListNodeView.nodeType == "Link" || spanListNodeView.nodeType == "HeadLink") {
                    // 链接, TOC列表链接
                    if(spanListNodeView.linkUrl.isSome() && spanListMarkdownConfiguration.isInLineLinkCustom.isSome()
                        && spanListMarkdownConfiguration.isInLineLinkCustom.getOrThrow()(spanListNodeView.linkUrl.getOrThrow())){
                        // 行内链接卡片组件
                        inlineLinkCardComponent(spanListNodeView.linkUrl(), spanListNodeView.linkTitle)
                    }else{
                        if (isOneLink) {
                            spanLinkComponent(
                                spanListNodeView,
                                spanListMarkdownConfiguration,
                                spanListTocListOnClick,
                                spanListFootnoteCallback,
                                true
                            )
                        } else {
                            spanLinkComponent(
                                spanListNodeView,
                                spanListMarkdownConfiguration,
                                spanListTocListOnClick,
                                spanListFootnoteCallback,
                                false
                            )
                        }
                    }
                } else if (spanListNodeView.nodeType == "Image" || spanListNodeView.nodeType == "StyleImage" || spanListNodeView.nodeType == "ImageHtmlNode") {
                    // Image：图片节点， StyleImage：图片Style节点，ImageHtmlNode：HTML图片
                    if(spanListNodeView.imageAltText.isSome() && spanListMarkdownConfiguration.isInLineImageCustom.isSome()
                        && spanListMarkdownConfiguration.isInLineImageCustom.getOrThrow()(spanListNodeView.imageAltText.getOrThrow())){
                        inlineImageCardComponent(spanListNodeView.imageAltText,spanListNodeView.imageUrl(), spanListNodeView.imageTitle())
                    }else{
                        spanImageComponent(
                        spanListNodeView,
                        spanListMarkdownConfiguration,
                        spanListComponentWidth,
                        spanListImageCallback
                        )
                    }
                } else {
                    // 其他节点
                    headingCustomHeadingLineBuilder(spanListNodeView, index)
                }
            },
            keyGeneratorFunc: {
                spanListNodeView: NodeView, idx: Int64 =>
                    if (spanListNodeView.nodeType == "LatexMathNode") {
                        return "${idx}-${spanListNodeView.nodeHash}"
                    }
                    return "${idx}-${spanListNodeView.nodeHash}-${spanListNodeView.contentHash}"
            }
        )
    }

    /**
     * 标题控件数据刷新
     *
     * @param headingNodeView 刷新的新数据
     */
    public func refreshHeadingData(newNodeView: NodeView): Unit {
        this.headingNodeView = newNodeView
        let refreshNodeViewChildren = headingNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let headingNodeViewListSize: Int64 = headingNodeViewList.size // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            headingNodeViewList.clear()
            return
        }
        if (refreshNodeViewSize > 0) {
            isRefresh = true
        }
        if (refreshNodeViewSize > headingNodeViewListSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..headingNodeViewListSize) {
                let refreshNodeView = refreshNodeViewChildren[i]
                let dataSourceNode = headingNodeViewList[i]
                let newNodeHash = refreshNodeView.nodeHash
                let oldNodeHash = dataSourceNode.nodeHash
                let newContentHash = refreshNodeView.contentHash
                let oldContentHash = dataSourceNode.contentHash
                if (newNodeHash != oldNodeHash || newContentHash != oldContentHash) {
                    // 自身节点唯一ID不相同需要刷新数据
                    // 子节点唯一ID不相同需要刷新子节点数据
                    headingNodeViewList[i] = refreshNodeView
                    if (refreshNodeView.nodeType == "LatexMathNode" && oldNodeHash == newNodeHash) {
                        MarkdownRefreshRegistry.refresh(refreshNodeView.nodeHash, refreshNodeView)
                    }
                }
            }
            // 循环添加新数据
            for (i in headingNodeViewListSize..refreshNodeViewSize) {
                headingNodeViewList.append(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == headingNodeViewListSize) {
            // 新数据等于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..headingNodeViewListSize) {
                let refreshNodeView = refreshNodeViewChildren[i]
                let dataSourceNode = headingNodeViewList[i]
                let newNodeHash = refreshNodeView.nodeHash
                let oldNodeHash = dataSourceNode.nodeHash
                let newContentHash = refreshNodeView.contentHash
                let oldContentHash = dataSourceNode.contentHash
                if (newNodeHash != oldNodeHash || newContentHash != oldContentHash) {
                    // 自身节点唯一ID不相同需要刷新数据
                    // 子节点唯一ID不相同需要刷新子节点数据
                    headingNodeViewList[i] = refreshNodeView
                    if (refreshNodeView.nodeType == "LatexMathNode" && oldNodeHash == newNodeHash) {
                        MarkdownRefreshRegistry.refresh(refreshNodeView.nodeHash, refreshNodeView)
                    }
                }
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..refreshNodeViewSize) {
                let refreshNodeView = refreshNodeViewChildren[i]
                let dataSourceNode = headingNodeViewList[i]
                let newNodeHash = refreshNodeView.nodeHash
                let oldNodeHash = dataSourceNode.nodeHash
                let newContentHash = refreshNodeView.contentHash
                let oldContentHash = dataSourceNode.contentHash
                if (newNodeHash != oldNodeHash || newContentHash != oldContentHash) {
                    // 自身节点唯一ID不相同需要刷新数据
                    // 子节点唯一ID不相同需要刷新子节点数据
                    headingNodeViewList[i] = refreshNodeView
                    if (refreshNodeView.nodeType == "LatexMathNode" && oldNodeHash == newNodeHash) {
                        MarkdownRefreshRegistry.refresh(refreshNodeView.nodeHash, refreshNodeView)
                    }
                }
            }
            // 循环删除多余的旧数据
            for (i in headingNodeViewListSize - 1..=refreshNodeViewSize : -1) {
                headingNodeViewList.remove(i)
            }
        }
        if (headingNodeViewList.size == 1 && (headingNodeViewList[0].nodeType == "Link" || headingNodeViewList[0].nodeType == "HeadLink")) {
            isOneLink = true
        } else {
            isOneLink = false
        }
    }
}
