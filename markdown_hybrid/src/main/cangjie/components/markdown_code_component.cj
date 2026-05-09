package markdown.components

import ohos.state_macro_manage.*

/**
 * 单独代码块自定义控件
 */
@Component
class MarkdownCodeComponent {
    var markdownConfiguration: MarkdownConfiguration // markdown配置
    @State
    var codeText: String = "" // 代码内容
    @State
    var info: Option<String> = Option<String>.None // 代码类型
    @State
    var nodeHash: Int64 = 0 // hash
    var codeComponents: HashMap<Int64, MarkdownCodeComponent> // 缓存的单独代码块控件
    var codeTextComponents: HashMap<Int64, MarkdownCodeTextComponent> // 缓存的单独代码块文本列表控件
    @State
    var lineStrArray: StringDataSource = StringDataSource(ArrayList<String>()) // 代码列表
    @State
    var lineInt64Array: StringDataSource = StringDataSource(ArrayList<String>()) // 代码列表
    let scroller1: Scroller = Scroller() // list控制器
    let scroller2: Scroller = Scroller() // list控制器
    @State
    var reachBottom: Bool = true // 是否在布局末尾
    var chatTouch: Bool = false // 手指是否触摸

    protected override func aboutToAppear(): Unit {
        refreshData(codeText, info, nodeHash) // 初始化刷新数据
        codeComponents.add(nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = codeComponents.get(nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                codeComponents.remove(nodeHash)
            }
        } else {
            codeComponents.remove(nodeHash)
        }
    }

    func build() {
        Column() {
            codeBlockButtonComponent()
            Row() {
                List(scroller: scroller1) {
                    LazyForEach(
                        lineInt64Array,
                        itemGeneratorFunc: {
                            item: String, idx: Int64 => ListItem() {
                                Text((idx + 1).toString())
                                    .fontFamily(codeLineNumberTextFontFamily(markdownConfiguration.markdownTheme))
                                    .fontSize(codeLineNumberTextSize(markdownConfiguration.markdownTheme))
                                    .fontWeight(codeLineNumberTextFontWeight(markdownConfiguration.markdownTheme))
                                    .fontStyle(codeLineNumberTextFontStyle(markdownConfiguration.markdownTheme))
                                    .fontColor(codeLineNumberTextColor(markdownConfiguration.markdownTheme))
                                    .lineHeight(codeLineNumberTextLineHeight(markdownConfiguration.markdownTheme))
                                    .maxLines(1)
                                    .textOverflow(TextOverflow.Ellipsis)
                                    .textAlign(TextAlign.End)
                            }
                        },
                        keyGeneratorFunc: {
                            item: String, idx: Int64 => "${idx}"
                        }
                    )
                }
                .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockSeparateWidth)
                .padding(right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberDividerSpacing, left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberTextPaddingLeft)
                .borderWidth(EdgeWidths(right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockDividerStrokeWidth.vp))
                .borderColor(codeDividerColor(markdownConfiguration.markdownTheme))
                .height(100.percent)
                .borderStyle(BorderStyle.Solid)
                .scrollBar(BarState.Off)
                .alignListItem(ListItemAlign.End)
                .enabled(false)
                .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))
                Scroll() {
                    Column() {
                        List(scroller: scroller2) {
                            LazyForEach(
                                lineStrArray,
                                itemGeneratorFunc: {
                                    item: String, idx: Int64 => ListItem() {
                                        MarkdownCodeTextComponent(
                                            markdownTheme: markdownConfiguration.markdownTheme,
                                            codeText: item,
                                            info: info,
                                            codeTextComponents: codeTextComponents,
                                            index: idx
                                        )
                                    }
                                },
                                keyGeneratorFunc: {
                                    item: String, idx: Int64 => "${idx}"
                                }
                            )
                        }
                        .height(100.percent)
                        .scrollBar(BarState.Off)
                        .edgeEffect(EdgeEffect.None)
                        .onReachEnd {
                            => reachBottom = true
                        }
                        .onScroll {
                            offset, _ =>
                                scroller1.scrollTo(xOffset: 0.0, yOffset: scroller2.currentOffset().yOffset)
                                checkScroll(offset)
                        }
                        .onTouch {
                            evt => chatOnTouch(evt)
                        }
                        .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))
                    }
                    .layoutWeight(1)
                }
                .scrollable(ScrollDirection.Horizontal)
                .scrollBar(BarState.Off)
                .align(Alignment.Start)
                .width(100.percent)
                .height(100.percent)
                .nestedScroll(NestedScrollOptions(NestedScrollMode.PARENT_FIRST, NestedScrollMode.PARENT_FIRST))
                .margin(left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextMarginLeft, right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextMarginRight)
            }
            .layoutWeight(1)
            .width(100.percent)
        }
        .width(100.percent)
        .height(100.percent)
        .borderRadius(topLeft: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockRadiusTopLeft, topRight: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockRadiusTopRight, bottomLeft: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockRadiusBottomLeft, bottomRight: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockRadiusBottomRight)
        .borderColor(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockBorderColor)
        .borderWidth(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockBorderWidth)
        .borderStyle(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockBorderStyle)
        .backgroundColor(codeBackgroundColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
        .padding(
            top: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockPaddingTop,
            right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockPaddingRight,
            bottom: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockPaddingBottom,
            left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockPaddingLeft
        )
    }

    /**
     * 复制按钮和全屏按钮部分
     */
    @Builder
    func codeBlockButtonComponent() {
        Row() {
            if (codeText.trimAscii().size > 0) {
                // 设置图片的数据源
                if (let Some(i) <- info) {
                    Row() {
                        Text(i)
                        .fontFamily(codeTypeTextFontFamily(markdownConfiguration.markdownTheme))
                        .fontSize(codeTypeTextFontSize(markdownConfiguration.markdownTheme))
                        .fontWeight(codeTypeTextFontWeight(markdownConfiguration.markdownTheme))
                        .fontStyle(codeTypeTextFontStyle(markdownConfiguration.markdownTheme))
                        .fontColor(codeTypeTextFontColor(markdownConfiguration.markdownTheme))
                        .lineHeight(codeTypeTextLineHeight(markdownConfiguration.markdownTheme))
                        .margin(left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTypeTextMarginLeft)
                        .textOverflow(TextOverflow.Ellipsis)
                        .maxLines(1)
                    }
                    .width(30.percent)
                    .justifyContent(FlexAlign.Start)
                } else {
                    Row()
                        .width(30.percent)
                        .justifyContent(FlexAlign.Start)
                }
                Row() {
                    if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyButtonIsShow) {
                        Row() {
                            if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIcon.isSome()) {
                                Image(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIcon())
                                    .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIconWidth)
                                    .height(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIconHeight)
                                    .objectFit(ImageFit.Contain)
                            }

                            Blank()
                                .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyIconTextSpacing)

                            if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyTextIsShow) {
                                Text(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyText)
                                    .fontFamily(codeCopyTextFontFamily(markdownConfiguration.markdownTheme))
                                    .fontSize(codeCopyTextFontSize(markdownConfiguration.markdownTheme))
                                    .fontWeight(codeCopyTextFontWeight(markdownConfiguration.markdownTheme))
                                    .fontStyle(codeCopyTextFontStyle(markdownConfiguration.markdownTheme))
                                    .fontColor(codeCopyTextFontColor(markdownConfiguration.markdownTheme))
                                    .lineHeight(codeCopyTextLineHeight(markdownConfiguration.markdownTheme))
                                    .align(Alignment.End)
                                    .maxLines(1)
                                    .textOverflow(TextOverflow.Ellipsis)
                            }
                        }
                        .justifyContent(FlexAlign.End)
                        .onClick {evt => codeCopyOnClick(codeText, markdownConfiguration.codeCopyCallback)}
                    }

                    Blank()
                        .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockCopyFullScreenSpacing)

                    if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenButtonIsShow) {
                        Row() {
                            if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIcon.isSome()) {
                                Image(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIcon())
                                    .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIconWidth)
                                    .height(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIconHeight)
                                    .margin(left: 4)
                                    .objectFit(ImageFit.Contain)
                            }

                            Blank()
                                .width(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenIconTextSpacing)

                            if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenTextIsShow) {
                                Text(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockFullScreenText)
                                    .fontFamily(codeFullScreenTextFontFamily(markdownConfiguration.markdownTheme))
                                    .fontSize(codeFullScreenTextFontSize(markdownConfiguration.markdownTheme))
                                    .fontWeight(codeFullScreenTextFontWeight(markdownConfiguration.markdownTheme))
                                    .fontStyle(codeFullScreenTextFontStyle(markdownConfiguration.markdownTheme))
                                    .fontColor(codeFullScreenTextFontColor(markdownConfiguration.markdownTheme))
                                    .lineHeight(codeFullScreenTextLineHeight(markdownConfiguration.markdownTheme))
                                    .align(Alignment.End)
                                    .maxLines(1)
                                    .textOverflow(TextOverflow.Ellipsis)
                            }
                        }
                        .justifyContent(FlexAlign.End)
                        .onClick {
                            evt => codeFullScreenOnClick(codeText, info, markdownConfiguration.codeFullScreenCallback)
                        }
                    }
                }
                .width(70.percent)
                .justifyContent(FlexAlign.End)
            }
        }
        .margin(top: 8.0, right: 8.0, bottom: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTitleLayoutMarginBottom)
        .alignItems(VerticalAlign.Center)
    }

    /**
     * 是否滑动到底部
     */
    func scrollChatIfAtBottom() {
        if (reachBottom) {
            scroll2Bottom()
        }
    }

    /**
     * 滑动到底部
     */
    func scroll2Bottom() {
        scroller2.scrollEdge(Edge.Bottom)
    }

    /**
     * 判断滑动距离和是否手指触摸
     */
    func checkScroll(offset: Float64) {
        if (offset < -0.5 && chatTouch) {
            reachBottom = false
        }
    }

    /**
     * 手指触摸判断
     */
    func chatOnTouch(evt: TouchEvent) {
        if (let TouchType.Down <- evt.eventType) {
            chatTouch = true
        } else if (let TouchType.Up <- evt.eventType) {
            chatTouch = false
        }
    }

    /**
     * 数据刷新
     */
    public func refreshData(codeText: String, info: Option<String>, nodeHash: Int64): Unit {
        this.codeText = codeText
        this.info = info
        this.nodeHash = nodeHash
        let arr = this.codeText.split("\n") // 代码块数据分割
        let refreshNodeViewSize = arr.size // 刷新进来的数据长度
        let dataSourceSize = lineStrArray.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            lineStrArray.clear()
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..dataSourceSize) {
                if(lineStrArray.getData(i) != arr[i]){
                    // 最后一条数据通过页面缓存刷新
                    lineStrArray.replaceData(i, arr[i])
                    lineInt64Array.replaceData(i, arr[i])
                    let cache = codeTextComponents.get(i)
                    if (let Some(v) <- cache) {
                        v.refreshData(arr[i], info)
                    }
                }
            }
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                lineStrArray.addData(arr[i])
                lineInt64Array.addData(arr[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            let indexItem: Int64 = dataSourceSize
            for (i in 0..indexItem) {
                if(lineStrArray.getData(i) != arr[i]){
                    // 最后一条数据通过页面缓存刷新
                    lineStrArray.replaceData(i, arr[i])
                    lineInt64Array.replaceData(i, arr[i])
                    let cache = codeTextComponents.get(i)
                    if (let Some(v) <- cache) {
                        v.refreshData(arr[i], info)
                    }
                }
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..refreshNodeViewSize) {
                if(lineStrArray.getData(i) != arr[i]){
                    // 最后一条数据通过页面缓存刷新
                    lineStrArray.replaceData(i, arr[i])
                    lineInt64Array.replaceData(i, arr[i])
                    let cache = codeTextComponents.get(i)
                    if (let Some(v) <- cache) {
                        v.refreshData(arr[i], info)
                    }
                }
            }
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                lineStrArray.deleteData(i)
                lineInt64Array.deleteData(i)
            }
        }
        // 列表是否置底
        if (markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockSeparateIsBottom) {
            scrollChatIfAtBottom()
        }
    }
}
