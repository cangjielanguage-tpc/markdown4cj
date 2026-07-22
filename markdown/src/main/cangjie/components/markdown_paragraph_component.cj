package markdown.components

import ohos.state_macro_manage.*

/**
 * 段落控件
 */
@Component
class MarkdownParagraphComponent {
    @Prop
    var paragraphMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var paragraphNodeView: NodeView // 段落控件自身节点
    @Prop
    var paragraphComponentWidth: Float64 // 控件宽度 - 单位vp
    @BuilderParam
    var paragraphCustomParagraphLineBuilder: (NodeView, Int64) -> Unit // 自定义行内段落控件
    var paragraphTocListOnClick: (Int64) -> Unit // TOC列表点击事件
    var paragraphImageCallback: (String) -> Unit // 图片点击事件
    var paragraphFootnoteCallback: (String) -> Unit // 脚注点击事件
    @State
    var isRefresh: Bool = false // 标题子节点是否不为0
    @State
    var isOneLink: Bool = false // 是否只有一条链接数据
    @State
    var paragraphNodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>() // 列表数据
    @State
    var paragraphHighlightColor: Color = COLOR_TRANSPARENT // 段落高亮颜色
    @State
    var hasParagraphHighlight: Bool = false // 段落是否处于高亮状态
    @State
    var paragraphTextContent: String = "" // 段落纯文本内容（用于长按回调与划选复制）
    @State
    var paragraphSelectionStart: Int32 = -1 // 段落文本划选起始位置，-1表示未划选
    @State
    var paragraphSelectionEnd: Int32 = -1 // 段落文本划选结束位置，-1表示未划选
    @State
    var paragraphLongPressBackgroundColor: Color = COLOR_TRANSPARENT // 当前长按背景色
    @State
    var paragraphIsLongPressed: Bool = false // 当前是否处于长按状态
    var paragraphSelectionMenuTimer: ?Timer = None // 选区菜单自动隐藏定时器
    // 链接曝光：URL列表缓存 + 当前可见状态
    // 对齐 ArkUI MarkdownParagraph.ets：用 onVisibleAreaChange(触发scheduleExposure) + onAreaChange(标记ready) +
    // componentUtils.getRectangleById(拿段落全局rect) 与屏幕高度 [0, screenH] 求交判定可见性。
    // 简化版：不做偏移/span级别，Text级别曝光。
    var paragraphExposureUrls: ArrayList<String> = ArrayList<String>() // 本段落的http链接URL列表（aboutToAppear时提取一次）
    var paragraphExposureVisible: Bool = false // 本段落当前是否处于"可见"状态（避免同一组件反复触发register）
    var paragraphId: String = "" // 段落Text的唯一id（componentUtils.getRectangleById 用，aboutToAppear赋值）
    var viewportReady: Bool = false // onAreaChange是否触发过（尺寸已就绪）
    var isAlive: Bool = true // 组件是否存活

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(paragraphNodeView.nodeHash, refreshParagraphData)
        refreshParagraphData(paragraphNodeView)
        // 段落Text的唯一id：用nodeHash保证流式复用同一节点时id稳定
        paragraphId = "md-exp-${paragraphNodeView.nodeHash}"
        // 链接曝光：仅提取URL列表缓存，不在此处register
        // 可见性由 scheduleExposure() 用 componentUtils.getRectangleById 与屏幕 [0, screenH] 求交判定
        if (isExposureEnabled()) {
            paragraphExposureUrls = MarkdownLinkExposureRegistry.extractHttpLinks(paragraphNodeView)
        }
        // 段落高亮注册
        MarkdownHighlightRegistry.register(paragraphNodeView.nodeHash, { color: ?Color =>
            if (let Some(c) <- color) {
                paragraphHighlightColor = c
                hasParagraphHighlight = true
            } else {
                hasParagraphHighlight = false
            }
        })
    }

    protected override func aboutToDisappear(): Unit {
        isAlive = false
        MarkdownRefreshRegistry.unregister(paragraphNodeView.nodeHash)
        // 组件销毁时若仍处于可见状态，补 unregister 保证显示/消失成对
        if (paragraphExposureVisible) {
            MarkdownLinkExposureRegistry.unregister(paragraphNodeView.nodeHash)
            paragraphExposureVisible = false
        }
        MarkdownHighlightRegistry.unregister(paragraphNodeView.nodeHash)
        // 组件销毁时清理选区菜单隐藏定时器
        if (paragraphSelectionMenuTimer.isSome()) {
            paragraphSelectionMenuTimer.getOrThrow().cancel()
            paragraphSelectionMenuTimer = None
        }
    }

    /**
     * 是否启用元素曝光统计：查 registry（不依赖 @Prop 的 MarkdownConfiguration.elementExposureCallback）
     */
    func isExposureEnabled(): Bool {
        return MarkdownLinkExposureRegistry.isExposureEnabled()
    }

    /**
     * 防抖触发曝光评估。合并连续的 onAreaChange/onVisibleAreaChange 触发。
     * 评估后对「本次显示」的链接回调 visible=true，「本次消失」的回调 visible=false。
     *
     * 视口：componentUtils.getRectangleById(paragraphId) 拿段落全局 rect（px），
     * 与屏幕 [0, screenH] 求交得段落在屏可见区。
     */
    func scheduleExposure(): Unit {
        if (!isAlive) {
            return
        }
        if (!isExposureEnabled()) {
            return
        }
        if (paragraphExposureUrls.size == 0) {
            return
        }
        // 防抖：16ms（~1帧）后执行评估，合并连续触发
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
     * 曝光评估：用 componentUtils 拿段落全局 rect，与屏幕 [0, screenH] 求交，判定可见性
     * 简化版：不做偏移/span级别，Text级别曝光。
     */
    func evaluateExposure(): Unit {
        var globalTop: Float64 = 0.0
        var globalBottom: Float64 = 0.0
        try {
            let info = ComponentUtils.getRectangleById(paragraphId)
            globalTop = Float64(info.windowOffset.y)
            globalBottom = globalTop + Float64(info.size.height)
        } catch (_: Exception) {
            return
        }
        // 简化：直接用整屏 [0, screenH] 作为可见窗口
        let screenHeight = Float64(getDefaultDisplaySync().height)
        let vpTop = 0.0
        let vpBottom = screenHeight
        // 段落 rect 与可见窗口求交
        let clipTop = if (vpTop > globalTop) { vpTop } else { globalTop }
        let clipBottom = if (vpBottom < globalBottom) { vpBottom } else { globalBottom }
        let visibleHeight = if (clipBottom > clipTop) { clipBottom - clipTop } else { 0.0 }
        let paragraphHeight = if (globalBottom > globalTop) { globalBottom - globalTop } else { 0.0 }
        let ratio = if (paragraphHeight > 0.0) { visibleHeight / paragraphHeight } else { 0.0 }
        let threshold = MarkdownLinkExposureRegistry.getExposureThreshold()
        if (ratio >= threshold && !paragraphExposureVisible) {
            paragraphExposureVisible = true
            MarkdownLinkExposureRegistry.register(paragraphNodeView.nodeHash, paragraphExposureUrls)
        } else if (ratio < threshold && paragraphExposureVisible) {
            paragraphExposureVisible = false
            MarkdownLinkExposureRegistry.unregister(paragraphNodeView.nodeHash)
        }
    }

    /**
     * 获取段落背景色：高亮时用高亮色，长按选中时用长按色，否则用默认背景色
     */
    func getParagraphBackground(): Color {
        if (paragraphIsLongPressed) {
            return paragraphLongPressBackgroundColor
        }
        if (hasParagraphHighlight) {
            return paragraphHighlightColor
        }
        return paragraphBackgroundColor(paragraphMarkdownConfiguration.markdownTheme, paragraphNodeView)
    }

    /**
     * 获取段落加载动画转场效果
     * 启用时进入渐显（OPACITY），退出无效果，保证流式输出历史UI稳定
     */
    func getTransitionEffect(): TransitionEffect {
        if (paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphAnimationEnabled) {
            let duration = paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphAnimationDuration
            let appearEffect = TransitionEffect.opacity(0.0).animation(AnimateParam(duration: duration))
            return TransitionEffect.asymmetric(appearEffect, TransitionEffect.IDENTITY)
        }
        return TransitionEffect.IDENTITY
    }

    /**
     * 获取段落纯文本内容
     * 递归拼接段落内文本、链接标题、换行等，用于长按回调与划选复制
     *
     * @param node 段落节点
     * @return 段落纯文本内容
     */
    func getParagraphTextContent(node: NodeView): String {
        var result = StringBuilder()
        if (node.footnoteID.isSome()) {
            result.append("[^")
            result.append(node.footnoteID.getOrThrow())
            result.append("]: ")
        }
        for (child in node.children) {
            appendNodeTextContent(child, result)
        }
        return result.toString()
    }

    /**
     * 递归拼接单个节点的纯文本内容
     *
     * @param node 当前节点
     * @param builder 字符串构建器
     */
    func appendNodeTextContent(node: NodeView, builder: StringBuilder): Unit {
        let nodeType = node.nodeType
        if (nodeType == "Text" || nodeType == "Code" || nodeType == "Footnote") {
            builder.append(node.nodeText)
        } else if (nodeType == "SoftLineBreak") {
            builder.append("\n")
        } else if (nodeType == "HardLineBreak") {
            builder.append("\n")
        } else if (nodeType == "Link" || nodeType == "HeadLink") {
            if (node.linkTitle.isSome()) {
                builder.append(node.linkTitle.getOrThrow())
            } else {
                for (child in node.children) {
                    appendNodeTextContent(child, builder)
                }
            }
        } else if (node.children.size > 0) {
            for (child in node.children) {
                appendNodeTextContent(child, builder)
            }
        }
    }

    /**
     * 将选中的文本写入系统剪贴板并显示提示
     *
     * @param selectedText 选中的文本
     */
    func copySelectedTextToClipboard(selectedText: String): Unit {
        if (selectedText.isEmpty()) {
            return
        }
        let pasteboardData = createData(MIMETYPE_TEXT_PLAIN, selectedText)
        getSystemPasteboard().setData(pasteboardData)
        PromptAction.showToast(message: "复制成功", duration: 2000)
        if (let Some(cb) <- paragraphMarkdownConfiguration.textCopyCallback) {
            cb(selectedText)
        }
    }

    /**
     * 获取选中的文本内容
     *
     * @return 选中的文本内容
     */
    func getSelectedTextContent(): String {
        if (paragraphSelectionStart < 0 || paragraphSelectionEnd < 0 || paragraphSelectionStart >= paragraphSelectionEnd) {
            return ""
        }
        let start = Int64(paragraphSelectionStart)
        let end = Int64(paragraphSelectionEnd)
        let contentLength = paragraphTextContent.size
        if (start >= contentLength) {
            return ""
        }
        let safeEnd = if (end > contentLength) { contentLength } else { end }
        return paragraphTextContent[start..safeEnd]
    }

    /**
     * 显示自定义选区菜单（复制按钮）
     * 由于仓颉 bindSelectionMenu 要求 Builder 无参，通过成员状态传递选中信息
     */
    @Builder
    func customSelectionMenu(): Unit {
        Column() {
            Text("复制")
                .fontSize(14.0)
                .fontColor(COLOR_WHITE)
                .padding(12.0)
                .backgroundColor(COLOR_FF4A90E2)
                .borderRadius(8.0)
                .onClick({ event: ClickEvent =>
                    copySelectedTextToClipboard(getSelectedTextContent())
                    paragraphSelectionStart = -1
                    paragraphSelectionEnd = -1
                })
        }
        .padding(8.0)
        .backgroundColor(COLOR_FFF5F2F0)
        .borderRadius(12.0)
    }

    /**
     * 空选区菜单，用于不需要显示菜单的场景
     */
    @Builder
    func nullSelectionMenu(): Unit {
        Column() {
        }
        .width(0.0)
        .height(0.0)
    }

    /**
     * 获取长按选中段落的背景色
     * 优先使用 MarkdownHighlightParagraph 中的配置，其次使用 ParagraphTheme 配置，最后使用默认浅灰色
     *
     * @return 长按选中段落的背景色
     */
    func getLongPressSelectedBackgroundColor(): Color {
        let theme = paragraphMarkdownConfiguration.markdownTheme.paragraphTheme
        let highlightParagraph = paragraphMarkdownConfiguration.markdownHighlightParagraph
        if (highlightParagraph.selectedParagraphBackgroundColor.isSome()) {
            return highlightParagraph.selectedParagraphBackgroundColor.getOrThrow()
        }
        if (theme.paragraphSelectedBackgroundColor.isSome()) {
            return theme.paragraphSelectedBackgroundColor.getOrThrow()
        }
        return Color(0xFFE0E0E0)
    }

    /**
     * 获取长按前段落默认背景色
     * 优先使用 MarkdownHighlightParagraph 中的配置，其次使用 ParagraphTheme 配置，最后使用当前背景色
     *
     * @return 长按前段落默认背景色
     */
    func getLongPressBeforeBackgroundColor(): Color {
        let theme = paragraphMarkdownConfiguration.markdownTheme.paragraphTheme
        let highlightParagraph = paragraphMarkdownConfiguration.markdownHighlightParagraph
        if (highlightParagraph.beforeSelectedParagraphBackgroundColor.isSome()) {
            return highlightParagraph.beforeSelectedParagraphBackgroundColor.getOrThrow()
        }
        if (theme.paragraphBeforeSelectedBackgroundColor.isSome()) {
            return theme.paragraphBeforeSelectedBackgroundColor.getOrThrow()
        }
        return getParagraphBackground()
    }

    /**
     * 处理长按段落开始
     * 按下时设置为长按背景色
     */
    func handleParagraphLongPressStart(): Unit {
        paragraphLongPressBackgroundColor = getLongPressSelectedBackgroundColor()
        paragraphIsLongPressed = true
    }

    /**
     * 处理长按段落结束
     * 先标记为非长按状态，再获取默认背景色，避免获取到长按背景色
     */
    func handleParagraphLongPressEnd(): Unit {
        paragraphIsLongPressed = false
        paragraphLongPressBackgroundColor = getLongPressBeforeBackgroundColor()
    }

    /**
     * 处理长按段落取消
     * 先标记为非长按状态，再获取默认背景色，避免获取到长按背景色
     */
    func handleParagraphLongPressCancel(): Unit {
        paragraphIsLongPressed = false
        paragraphLongPressBackgroundColor = getLongPressBeforeBackgroundColor()
    }

    /**
     * 触发段落长按回调
     * 优先回调外部自定义长按，未设置时无操作
     */
    func triggerParagraphLongPressCallback(): Unit {
        if (let Some(cb) <- paragraphMarkdownConfiguration.customLongPressCallback) {
            cb(paragraphTextContent)
        }
    }

    func build() {
        Row() {
            Column() {
                if (!paragraphMarkdownConfiguration.markdownTheme.imageTheme.isImageMixedLayout && paragraphNodeViewList.size == 1 && (paragraphNodeViewList[0].nodeType == "Image" || paragraphNodeViewList[0].nodeType == "StyleImage" || paragraphNodeViewList[0].nodeType == "ImageHtmlNode")) {
                    if (paragraphMarkdownConfiguration.imageReplaceCallback.isNone()) {
                        if (paragraphNodeViewList[0].imageUrl.getOrThrow().startsWith("./")) {
                            MarkdownImageRawFileComponent(
                                rawFileMarkdownTheme: paragraphMarkdownConfiguration.markdownTheme,
                                rawFileDestination: paragraphNodeViewList[0].imageUrl.getOrThrow(),
                                rawFileComponentWidth: paragraphComponentWidth,
                                rawFileImageDownloadCallback: paragraphMarkdownConfiguration.imageDownloadCallback,
                                rawFileImageCallback: paragraphImageCallback,
                                rawFileLinkCallback: paragraphMarkdownConfiguration.linkCallback,
                                rawFileLink: paragraphNodeViewList[0].isLink,
                                rawFileLinkUrl: paragraphNodeViewList[0].linkUrl,
                                rawFileImageWidth: paragraphNodeViewList[0].imageWidth,
                                rawFileImageHeight: paragraphNodeViewList[0].imageHeight,
                                rawFileImageRadius: paragraphNodeViewList[0].imageRadius,
                                rawFileImageAlign: paragraphNodeViewList[0].imageAlign
                            )
                        } else {
                            MarkdownImageUrlComponent(
                                urlMarkdownTheme: paragraphMarkdownConfiguration.markdownTheme,
                                urlDestination: paragraphNodeViewList[0].imageUrl.getOrThrow(),
                                urlComponentWidth: paragraphComponentWidth,
                                urlImageDownloadCallback: paragraphMarkdownConfiguration.imageDownloadCallback,
                                urlImageCallback: paragraphImageCallback,
                                urlLinkCallback: paragraphMarkdownConfiguration.linkCallback,
                                urlLink: paragraphNodeViewList[0].isLink,
                                urlLinkUrl: paragraphNodeViewList[0].linkUrl,
                                urlImageWidth: paragraphNodeViewList[0].imageWidth,
                                urlImageHeight: paragraphNodeViewList[0].imageHeight,
                                urlImageRadius: paragraphNodeViewList[0].imageRadius,
                                urlImageAlign: paragraphNodeViewList[0].imageAlign
                            )
                        }
                    } else {
                        if (paragraphNodeViewList[0].imageUrl.getOrThrow().startsWith("./")) {
                            MarkdownImageCallbackRawFileComponent(
                                rawFileCallbackMarkdownTheme: paragraphMarkdownConfiguration.markdownTheme,
                                rawFileCallbackDestination: paragraphNodeViewList[0].imageUrl.getOrThrow(),
                                rawFileCallbackComponentWidth: paragraphComponentWidth,
                                rawFileCallbackImageDownloadCallback: paragraphMarkdownConfiguration.imageDownloadCallback,
                                rawFileCallbackImageReplaceCallback: paragraphMarkdownConfiguration.imageReplaceCallback.getOrThrow(),
                                rawFileCallbackImageCallback: paragraphImageCallback,
                                rawFileCallbackLinkCallback: paragraphMarkdownConfiguration.linkCallback,
                                rawFileCallbackLink: paragraphNodeViewList[0].isLink,
                                rawFileCallbackLinkUrl: paragraphNodeViewList[0].linkUrl,
                                rawFileCallbackImageWidth: paragraphNodeViewList[0].imageWidth,
                                rawFileCallbackImageHeight: paragraphNodeViewList[0].imageHeight,
                                rawFileCallbackImageRadius: paragraphNodeViewList[0].imageRadius,
                                rawFileCallbackImageAlign: paragraphNodeViewList[0].imageAlign
                            )
                        } else {
                            MarkdownImageCallbackUrlComponent(
                                urlCallbackMarkdownTheme: paragraphMarkdownConfiguration.markdownTheme,
                                urlCallbackDestination: paragraphNodeViewList[0].imageUrl.getOrThrow(),
                                urlCallbackComponentWidth: paragraphComponentWidth,
                                urlCallbackImageDownloadCallback: paragraphMarkdownConfiguration.imageDownloadCallback,
                                urlCallbackImageReplaceCallback: paragraphMarkdownConfiguration.imageReplaceCallback.getOrThrow(),
                                urlCallbackImageCallback: paragraphImageCallback,
                                urlCallbackLinkCallback: paragraphMarkdownConfiguration.linkCallback,
                                urlCallbackLink: paragraphNodeViewList[0].isLink,
                                urlCallbackLinkUrl: paragraphNodeViewList[0].linkUrl,
                                urlCallbackImageWidth: paragraphNodeViewList[0].imageWidth,
                                urlCallbackImageHeight: paragraphNodeViewList[0].imageHeight,
                                urlCallbackImageRadius: paragraphNodeViewList[0].imageRadius,
                                urlCallbackImageAlign: paragraphNodeViewList[0].imageAlign
                            )
                        }
                    }
                } else {
                    paragraphComponent()
                }
            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Center)
            .layoutWeight(1)
        }
        .backgroundColor(getParagraphBackground())
        .padding(
            top: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphPaddingTop,
            right: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphPaddingRight,
            bottom: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphPaddingBottom,
            left: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphPaddingLeft
        )
        .margin(
            top: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphMarginTop,
            right: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphMarginRight,
            bottom: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphMarginBottom,
            left: paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphMarginLeft
        )
        .transition(getTransitionEffect())
        .onAppear({ =>
            // 段落加载动画开始回调在组件显示时触发
            if (paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphAnimationEnabled) {
                if (let Some(cb) <- paragraphMarkdownConfiguration.paragraphAnimationStart) {
                    cb()
                }
                let duration = paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphAnimationDuration
                let endCb = paragraphMarkdownConfiguration.paragraphAnimationEnd
                Timer.once(Int64(duration) * Duration.millisecond, { =>
                    if (let Some(cb) <- endCb) {
                        cb()
                    }
                })
            }
        })
    }

    /**
     * 段落文字内容
     */
    @Builder
    func paragraphComponent() {
        Text() {
            if (paragraphNodeView.footnoteID.isSome()) {
                Span("[^${paragraphNodeView.footnoteID.getOrThrow()}]: ")
                    .fontSize(paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphTextFontSize)
                    .fontWeight(paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphTextFontWeight)
                    .fontColor(paragraphMarkdownConfiguration.markdownTheme.paragraphTheme.paragraphTextFontColor)
            }
            if (isRefresh) {
                markdownSpanListComponent(
                    paragraphNodeViewList,
                    paragraphMarkdownConfiguration,
                    paragraphComponentWidth,
                    paragraphTocListOnClick,
                    paragraphImageCallback,
                    paragraphFootnoteCallback
                )
            }
        }
        .textAlign(TextAlign.Start)
        .halfLeading(true)
        .copyOption(if (paragraphMarkdownConfiguration.markdownTheme.globalTheme.isOnCopy) {
            CopyOptions.LocalDevice
        } else {
            CopyOptions.None
        })
        .selection(paragraphSelectionStart, paragraphSelectionEnd)
        .onTextSelectionChange({ start: Int32, end: Int32 =>
            paragraphSelectionStart = start
            paragraphSelectionEnd = end
            // 划选时取消长按背景，避免视觉冲突
            if (paragraphIsLongPressed) {
                paragraphIsLongPressed = false
                paragraphLongPressBackgroundColor = getParagraphBackground()
            }
        })
        .bindSelectionMenu(
            TextSpanType.TEXT,
            bind(customSelectionMenu, this),
            TextResponseType.RIGHT_CLICK,
            onAppear: { selectionStart: Int32, selectionEnd: Int32 =>
                paragraphSelectionStart = selectionStart
                paragraphSelectionEnd = selectionEnd
                // 选区菜单3秒后自动隐藏
                if (paragraphSelectionMenuTimer.isSome()) {
                    paragraphSelectionMenuTimer.getOrThrow().cancel()
                }
                paragraphSelectionMenuTimer = Timer.once(Int64(3000) * Duration.millisecond, { =>
                    paragraphSelectionStart = -1
                    paragraphSelectionEnd = -1
                    paragraphSelectionMenuTimer = None
                })
            },
            onDisappear: { =>
                // 菜单隐藏时清理定时器与选区状态
                if (paragraphSelectionMenuTimer.isSome()) {
                    paragraphSelectionMenuTimer.getOrThrow().cancel()
                    paragraphSelectionMenuTimer = None
                }
                paragraphSelectionStart = -1
                paragraphSelectionEnd = -1
            }
        )
        .bindSelectionMenu(
            TextSpanType.IMAGE,
            bind(nullSelectionMenu, this),
            TextResponseType.RIGHT_CLICK,
            onAppear: { selectionStart: Int32, selectionEnd: Int32 =>
                paragraphSelectionStart = selectionStart
                paragraphSelectionEnd = selectionEnd
            },
            onDisappear: { =>
                paragraphSelectionStart = -1
                paragraphSelectionEnd = -1
            }
        )
        .bindSelectionMenu(
            TextSpanType.MIXED,
            bind(customSelectionMenu, this),
            TextResponseType.RIGHT_CLICK,
            onAppear: { selectionStart: Int32, selectionEnd: Int32 =>
                paragraphSelectionStart = selectionStart
                paragraphSelectionEnd = selectionEnd
                // 选区菜单3秒后自动隐藏
                if (paragraphSelectionMenuTimer.isSome()) {
                    paragraphSelectionMenuTimer.getOrThrow().cancel()
                }
                paragraphSelectionMenuTimer = Timer.once(Int64(3000) * Duration.millisecond, { =>
                    paragraphSelectionStart = -1
                    paragraphSelectionEnd = -1
                    paragraphSelectionMenuTimer = None
                })
            },
            onDisappear: { =>
                paragraphSelectionStart = -1
                paragraphSelectionEnd = -1
            }
        )
        .parallelGesture(
            LongPressGesture()
                .onAction({ event: GestureEvent =>
                    handleParagraphLongPressStart()
                })
                .onActionEnd({ event: GestureEvent =>
                    handleParagraphLongPressEnd()
                    triggerParagraphLongPressCallback()
                })
                .onActionCancel({ =>
                    handleParagraphLongPressCancel()
                })
        )
        .onCopy({
            str => if (let Some(v) <- paragraphMarkdownConfiguration.textCopyCallback) {
                v(str)
            }
        })
        // 链接曝光：Text 的唯一 id（componentUtils.getRectangleById 用）
        .id(paragraphId)
        // onVisibleAreaChange：ratio 阈值变化时触发 scheduleExposure（仅作触发用，真正可见性由 rect 求交判定）
        .onVisibleAreaChange(
            [0.0, 0.01, 0.1, 0.25, 0.5, 0.75, 1.0],
            { _: Bool, _: Float64 =>
                if (isExposureEnabled()) {
                    scheduleExposure()
                }
            }
        )
        // onAreaChange：标记 viewportReady，触发 scheduleExposure
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
                spanListNodeView: NodeView, index: Int64 => if (spanListNodeView.nodeType == "Text" || spanListNodeView.nodeType == "Code" || spanListNodeView.nodeType == "Footnote") {
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
                } else if (spanListNodeView.nodeType == "Image" || spanListNodeView.nodeType == "StyleImage" || spanListNodeView.nodeType == "ImageHtmlNode") {
                    // Image：图片节点， StyleImage：图片Style节点，ImageHtmlNode：HTML图片
                    spanImageComponent(
                        spanListNodeView,
                        spanListMarkdownConfiguration,
                        spanListComponentWidth,
                        spanListImageCallback
                    )
                } else {
                    // 其他节点
                    paragraphCustomParagraphLineBuilder(spanListNodeView, index)
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
     * 段落控件数据刷新
     * 数据驱动：逐个对比新旧数据hash，替换变化的项，新增/删除差额
     *
     * @param paragraphNodeView 刷新的新数据
     */
    public func refreshParagraphData(newNodeView: NodeView): Unit {
        this.paragraphNodeView = newNodeView
        let refreshNodeViewChildren = paragraphNodeView.children // 子节点数据
        if (refreshNodeViewChildren.size == 0) {
            paragraphNodeViewList.clear()
            return
        }
        isRefresh = true
        // 增量更新：对比重叠区间hash，替换变化的项
        let existingLen: Int64 = paragraphNodeViewList.size
        let newLen: Int64 = refreshNodeViewChildren.size
        let minLen = if (existingLen < newLen) { existingLen } else { newLen }
        for (i in 0..minLen) {
            let oldNode = paragraphNodeViewList[i]
            let newNode = refreshNodeViewChildren[i]
            if (oldNode.nodeHash != newNode.nodeHash || oldNode.contentHash != newNode.contentHash) {
                paragraphNodeViewList[i] = newNode
                if (newNode.nodeType == "LatexMathNode" && oldNode.nodeHash == newNode.nodeHash) {
                    MarkdownRefreshRegistry.refresh(newNode.nodeHash, newNode)
                }
            }
        }
        // 新增部分
        if (newLen > existingLen) {
            for (i in existingLen..newLen) {
                paragraphNodeViewList.append(refreshNodeViewChildren[i])
            }
        } else if (existingLen > newLen) {
            // 删除多余部分（从后往前删）
            for (i in existingLen - 1..=newLen : -1) {
                paragraphNodeViewList.remove(i)
            }
        }
        if (paragraphNodeViewList.size == 1 && (paragraphNodeViewList[0].nodeType == "Link" || paragraphNodeViewList[0].nodeType == "HeadLink")) {
            isOneLink = true
        } else {
            isOneLink = false
        }
        // 更新段落纯文本内容，供长按回调与划选复制使用
        paragraphTextContent = getParagraphTextContent(paragraphNodeView)
    }
}
