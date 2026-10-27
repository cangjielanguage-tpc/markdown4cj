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
    var paragraphSelectedBackgroundColor: Color = COLOR_FF4A90E2 // 当前选中文本背景色
    @State
    var paragraphIsLongPressed: Bool = false // 当前是否处于长按状态
    @State
    var needHideMenu: Bool = false // 是否需要隐藏菜单，同时关闭划选文字效果
    var paragraphSelectionMenuTimer: ?Timer = None // 选区菜单自动隐藏定时器
    // 链接曝光：URL列表缓存 + 当前可见状态
    // onVisibleAreaChange(ratio阈值回调) 缓存 lastVisibleRatio + 触发 scheduleExposure，
    // onAreaChange 标记 viewportReady + 触发 scheduleExposure，
    // evaluateExposure 用 lastVisibleRatio 与 threshold 比较，判定 register/unregister。
    // 简化版：不做偏移/span级别，Text级别曝光。
    var paragraphExposureUrls: ArrayList<String> = ArrayList<String>() // 本段落的http链接URL列表（aboutToAppear时提取一次）
    var paragraphExposureVisible: Bool = false // 本段落当前是否处于"可见"状态（避免同一组件反复触发register）
    var paragraphId: String = "" // 段落Text的唯一id（aboutToAppear赋值）
    var viewportReady: Bool = false // onAreaChange是否触发过（尺寸已就绪）
    var isAlive: Bool = true // 组件是否存活
    var exposureScheduled: Bool = false // 曝光评估是否已调度（防抖标志，避免onVisibleAreaChange多次阈值回调每次都spawn协程）
    var lastVisibleRatio: Float64 = 0.0 // onVisibleAreaChange 最近一次回调的可见比例（0=完全不可见，1=完全可见，已考虑所有祖先裁剪）

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(paragraphNodeView.nodeHash, refreshParagraphData)
        refreshParagraphData(paragraphNodeView)
        // 段落Text的唯一id：用nodeHash保证流式复用同一节点时id稳定
        paragraphId = "md-exp-${paragraphNodeView.nodeHash}"
        // 链接曝光：仅提取URL列表缓存，不在此处register
        // 可见性由 evaluateExposure() 用 onVisibleAreaChange 缓存的 lastVisibleRatio 与 threshold 比较判定
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
     * 可见性判定：直接使用 onVisibleAreaChange 回调缓存的 lastVisibleRatio（已考虑所有祖先裁剪），
     * 无需手动用 componentUtils.getRectangleById 求交。
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
        if (exposureScheduled) {
            return
        }
        exposureScheduled = true
        // 防抖：16ms（~1帧）后执行评估，合并连续触发
        spawn {
            sleep(Duration.millisecond * 16)
            launch {
                exposureScheduled = false
                if (isAlive && viewportReady) {
                    evaluateExposure()
                }
            }
        }
    }

    /**
     * 曝光评估：直接使用 onVisibleAreaChange 缓存的 lastVisibleRatio 判定可见性
     * ratio 已考虑所有祖先裁剪（Scroll/List/屏幕），无需手动用 componentUtils 求交
     */
    func evaluateExposure(): Unit {
        let ratio = lastVisibleRatio
        let threshold = MarkdownLinkExposureRegistry.getExposureThreshold()
        let isVisible = ratio > 0.0 && ratio >= threshold
        if (isVisible && !paragraphExposureVisible) {
            paragraphExposureVisible = true
            MarkdownLinkExposureRegistry.register(paragraphNodeView.nodeHash, paragraphExposureUrls)
        } else if (!isVisible && paragraphExposureVisible) {
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
        let tmpText = paragraphTextContent.toRuneArray()
        return String(tmpText[start..safeEnd])
    }

    /**
     * 显示自定义选区菜单（复制按钮）
     * 由于仓颉 bindSelectionMenu 要求 Builder 无参，通过成员状态传递选中信息
     */
    @Builder
    func customSelectionMenu(): Unit {
        Row() {
            Text("复制")
                .fontSize(12.0)
                .fontColor(COLOR_FF1E1E1E)
                .onClick({ event: ClickEvent =>
                    copySelectedTextToClipboard(getSelectedTextContent())
                    paragraphSelectionStart = -1
                    paragraphSelectionEnd = -1
                })
        }
        .padding(10.0)
        .backgroundColor(COLOR_WHITE)
        .border(width: 1.0, color: COLOR_GRAY, radius: 5.0)
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
     * 获取长按但未触发选中弹窗时的段落的背景色
     * 优先使用 MarkdownHighlightParagraph 中的配置（经Registry静态中转，@Prop拷贝后实例脱钩），其次使用 ParagraphTheme 配置，最后使用默认浅灰色
     *
     * @return 段落的背景色
     */
    func getLongPressBeforeSelectedBackgroundColor(): Color {
        let theme = paragraphMarkdownConfiguration.markdownTheme.paragraphTheme
        if (MarkdownHighlightRegistry.selectedBackgroundColor.isSome()) { // 设置选中的背景色
            paragraphSelectedBackgroundColor = MarkdownHighlightRegistry.selectedBackgroundColor.getOrThrow()
        } else {
            paragraphSelectedBackgroundColor = COLOR_FF4A90E2 // 默认选中背景色
        }
        if (MarkdownHighlightRegistry.beforeSelectedBackgroundColor.isSome()) {
            return MarkdownHighlightRegistry.beforeSelectedBackgroundColor.getOrThrow()
        }
        if (theme.paragraphSelectedBackgroundColor.isSome()) {
            return theme.paragraphSelectedBackgroundColor.getOrThrow()
        }
        return Color(0xFFE0E0E0)
    }

    /**
     * 获取长按前段落默认背景色
     * 优先使用 MarkdownHighlightParagraph 中的配置（经Registry静态中转），其次使用 ParagraphTheme 配置，最后使用当前背景色
     *
     * @return 长按前段落默认背景色
     */
    func getLongPressBeforeBackgroundColor(): Color {
        let theme = paragraphMarkdownConfiguration.markdownTheme.paragraphTheme
        if (MarkdownHighlightRegistry.beforeSelectedBackgroundColor.isSome()) {
            return MarkdownHighlightRegistry.beforeSelectedBackgroundColor.getOrThrow()
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
        paragraphLongPressBackgroundColor = getLongPressBeforeSelectedBackgroundColor()
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
                        if (isRawFileImageUrl(paragraphNodeViewList[0].imageUrl.getOrThrow())) {
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
                                rawFileImageAlign: paragraphNodeViewList[0].imageAlign,
                                rawFileImageNode: paragraphNodeViewList[0]
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
                                urlImageAlign: paragraphNodeViewList[0].imageAlign,
                                urlImageNode: paragraphNodeViewList[0]
                            )
                        }
                    } else {
                        if (isRawFileImageUrl(paragraphNodeViewList[0].imageUrl.getOrThrow())) {
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
                                rawFileCallbackImageAlign: paragraphNodeViewList[0].imageAlign,
                                rawFileCallbackImageNode: paragraphNodeViewList[0]
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
                                urlCallbackImageAlign: paragraphNodeViewList[0].imageAlign,
                                urlCallbackImageNode: paragraphNodeViewList[0]
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
        ).transition(
 	       TransitionEffect.asymmetric(
 	         if(paragraphMarkdownConfiguration.markdownTheme.globalTheme.paragraphHeadingAnimationEnabled){
                TransitionEffect.opacity(0.0).animation(AnimateParam(duration:paragraphMarkdownConfiguration.markdownTheme.globalTheme.paragraphHeadingAnimationDuration))
 	         }else{ TransitionEffect.IDENTITY}
 	         ,
 	         TransitionEffect.IDENTITY
 	       ),
            { isExit: Bool =>
                // isExit=true：出现动画结束；false：消失动画结束。渲染管线UI线程回调，无需定时器模拟
                if (isExit && paragraphMarkdownConfiguration.markdownTheme.globalTheme.paragraphHeadingAnimationEnabled) {
                    if (let Some(cb) <- paragraphMarkdownConfiguration.paragraphHeadingAnimationEnd) {
                        cb()
                    }
                }
            }
 	     )
        .onAppear({ =>
            // 段落加载动画开始回调在组件显示时触发（转场启动时机，UI线程）
            if (paragraphMarkdownConfiguration.markdownTheme.globalTheme.paragraphHeadingAnimationEnabled) {
                if (let Some(cb) <- paragraphMarkdownConfiguration.paragraphHeadingAnimationStart) {
                    cb()
                }
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
        .copyOption(if (paragraphMarkdownConfiguration.markdownTheme.globalTheme.isOnCopy) {
            CopyOptions.LocalDevice
        } else {
            CopyOptions.None
        })
        .selection(paragraphSelectionStart, paragraphSelectionEnd)
        .interopSelectedBackgroundColor(paragraphSelectedBackgroundColor)
        .onTextSelectionChange({ start: Int32, end: Int32 =>
            paragraphSelectionStart = start
            paragraphSelectionEnd = end
            // 划选时取消长按背景，避免视觉冲突
            if (paragraphIsLongPressed) {
                paragraphIsLongPressed = false
                paragraphLongPressBackgroundColor = getParagraphBackground()
            }
        })
        .interopBindSelectionMenu(
            TextSpanType.TEXT,
            bind(customSelectionMenu, this),
            TextResponseType.LONG_PRESS,
            options: SelectionMenuOptions(
                onMenuShow: { selectionStart: Int64, selectionEnd: Int64 =>
                    needHideMenu = false
                },
                onMenuHide: { =>
                    needHideMenu = true
                    startDelay()
                }
            )
        )
        .interopBindSelectionMenu(
            TextSpanType.IMAGE,
            bind(nullSelectionMenu, this),
            TextResponseType.LONG_PRESS,
            options: SelectionMenuOptions(
                onMenuShow: { selectionStart: Int64, selectionEnd: Int64 =>
                    needHideMenu = false
                },
                onMenuHide: { =>
                    needHideMenu = true
                    startDelay()
                }
            )
        )
        .interopBindSelectionMenu(
            TextSpanType.MIXED,
            bind(customSelectionMenu, this),
            TextResponseType.LONG_PRESS,
            options: SelectionMenuOptions(
                onMenuShow: { selectionStart: Int64, selectionEnd: Int64 =>
                    needHideMenu = false
                },
                onMenuHide: { =>
                    needHideMenu = true
                    startDelay()
                }
            )
        )
        .parallelGesture(
            LongPressGesture(duration: 400)
                .onAction({ event: GestureEvent =>
                    handleParagraphLongPressStart()
                })
                .onActionEnd({ event: GestureEvent =>
                    handleParagraphLongPressEnd()
                    if (!paragraphMarkdownConfiguration.markdownTheme.globalTheme.isOnCopy) { // 不启用长按复制时使用自定义方法
                        triggerParagraphLongPressCallback()
                    }
                })
                .onActionCancel({ =>
                    handleParagraphLongPressCancel()
                })
        )
        // 链接曝光：Text 的唯一 id
        .id(paragraphId)
        // onVisibleAreaChange：缓存 ratio + 触发 scheduleExposure（ratio 即可见性指标，已考虑所有祖先裁剪）
        .onVisibleAreaChange(
            [0.0, 0.01, 0.1, 0.25, 0.5, 0.75, 1.0],
            { _: Bool, ratio: Float64 =>
                lastVisibleRatio = ratio
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
                        spanListImageCallback,
                        Option<(Float64) -> Unit>.None,
                        Option<Float64>.None
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
                // 图片节点：同URL时保留旧节点的尺寸缓存（对齐ArkUI oldImageSizes保留逻辑）
                carryOverImageSizeCache(oldNode, newNode)
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

    // 启动弹窗关闭判断延时
    func startDelay(): Unit {
        // 选区菜单3秒后自动隐藏
        if (paragraphSelectionMenuTimer.isSome()) {
            paragraphSelectionMenuTimer.getOrThrow().cancel()
        }
        paragraphSelectionMenuTimer = Timer.once(300 * Duration.millisecond, { =>
            if (needHideMenu) {
                launch {
                    paragraphSelectionStart = -1
                    paragraphSelectionEnd = -1
                    paragraphSelectionMenuTimer = None
                }
            }
        })
    }
}
