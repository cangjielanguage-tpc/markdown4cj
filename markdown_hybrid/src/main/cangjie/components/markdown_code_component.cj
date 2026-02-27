/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 单独代码块自定义控件
 */
@Component
class MarkdownCodeComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 代码内容
     */
    @State
    var codeText: String = ""

    /**
     * 代码类型
     */
    @State
    var info: Option<String> = Option<String>.None

    /**
     * hash
     */
    @State
    var nodeHash: Int64 = 0

    /**
     * 缓存的单独代码块控件
     */
    var codeComponents: HashMap<Int64, MarkdownCodeComponent>

    /**
     * 代码列表
     */
    @State
    var lineStrArray: StringDataSource = StringDataSource(ArrayList<String>())

    /**
     * 代码列表
     */
    @State
    var lineInt64Array: StringDataSource = StringDataSource(ArrayList<String>())

    /**
     * list控制器
     */
    let scroller1: Scroller = Scroller()

    /**
     * list控制器
     */
    let scroller2: Scroller = Scroller()

    /**
     * 是否在布局末尾
     */
    @State
    var reachBottom: Bool = true

    /**
     * 手指是否触摸
     */
    var chatTouch: Bool = false

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
                                    .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                    .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                                    .lineHeight(markdownConfiguration.markdownTheme.codeBlockLineHeight)
                                    .textAlign(TextAlign.End)
                                    .maxLines(1)
                                    .textOverflow(TextOverflow.Ellipsis)
                            }
                        },
                        keyGeneratorFunc: {
                            item: String, idx: Int64 => "${idx}-${item}"
                        }
                    )
                }
                .height(100.percent)
                .padding(left: 8, right: 8)
                .width(markdownConfiguration.markdownTheme.separateCodeBlockWidth)
                .borderWidth(EdgeWidths(right: markdownConfiguration.markdownTheme.thematicBreakHeight.vp))
                .borderStyle(BorderStyle.Solid)
                .borderColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
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
                                            info: info
                                        )
                                    }
                                },
                                keyGeneratorFunc: {
                                    item: String, idx: Int64 => "${idx}-${item}"
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
                    .height(100.percent)
                }
                .scrollable(ScrollDirection.Horizontal)
                .scrollBar(BarState.Off)
                .align(Alignment.Start)
                .width(100.percent)
                .height(100.percent)
                .nestedScroll(NestedScrollOptions(NestedScrollMode.PARENT_FIRST, NestedScrollMode.PARENT_FIRST))
            }
            .width(100.percent)
            .height(100.percent)
        }
        .width(100.percent)
        .height(100.percent)
        .padding(bottom: bottomSize())
        .borderRadius(markdownConfiguration.markdownTheme.codeBlockRadius)
        .backgroundColor(codeBackgroundColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
    }

    /**
     * 底部高度
     */
    func bottomSize(): Float64 {
        if (markdownConfiguration.markdownTheme.codeCopyIcon.isSome() || markdownConfiguration.markdownTheme.codeFullScreenIcon.isSome()) {
            return 50.0
        } else {
            return 20.0
        }
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
                            .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                            .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                            .margin(left: 8)
                            .maxLines(1)
                            .textOverflow(TextOverflow.Ellipsis)
                            .visibility(isVisibility(!markdownConfiguration.markdownTheme.isSeparateCodeBlock))
                    }
                    .width(30.percent)
                    .justifyContent(FlexAlign.Start)
                } else {
                    Row()
                        .width(30.percent)
                        .justifyContent(FlexAlign.Start)
                }
                Row() {
                    if (markdownConfiguration.markdownTheme.codeCopyIcon.isSome()) {
                        Row() {
                            Image(markdownConfiguration.markdownTheme.codeCopyIcon())
                                .width(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                .height(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                .objectFit(ImageFit.Contain)

                            Row()
                                .width(5)

                            if (markdownConfiguration.markdownTheme.codeBlockIconTextHide) {
                                Text("复制代码")
                                    .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                    .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                                    .align(Alignment.End)
                                    .maxLines(1)
                                    .textOverflow(TextOverflow.Ellipsis)
                                    .margin(right: 4)
                            }
                        }
                        .justifyContent(FlexAlign.End)
                        .onClick {evt => codeCopyOnClick(codeText, markdownConfiguration.codeCopyCallback)}
                    }

                    if (markdownConfiguration.markdownTheme.codeFullScreenIcon.isSome()) {
                        Row() {
                            Image(markdownConfiguration.markdownTheme.codeFullScreenIcon())
                                .width(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                .height(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                .margin(left: 4)
                                .objectFit(ImageFit.Contain)

                            Row()
                                .width(5)

                            if (markdownConfiguration.markdownTheme.codeBlockIconTextHide) {
                                Text("全屏代码")
                                    .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                    .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                                    .align(Alignment.End)
                                    .maxLines(1)
                                    .textOverflow(TextOverflow.Ellipsis)
                                    .margin(right: 4)
                            }
                        }
                        .justifyContent(FlexAlign.End)
                        .visibility(isVisibility(markdownConfiguration.markdownTheme.isCodeFullScreen))
                        .onClick {
                            evt => codeFullScreenOnClick(codeText, info, markdownConfiguration.codeFullScreenCallback)
                        }
                    }
                }
                .width(70.percent)
                .justifyContent(FlexAlign.End)
            }
        }
        .margin(top: 8.0, right: 8.0, bottom: markdownConfiguration.markdownTheme.codeBlockTypeTextPadding)
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
        let arr = ArrayList<String>()
        this.codeText.lines().forEach({
                s => arr.add(s)
            })
        let refreshNodeViewSize = arr.size // 刷新进来的数据长度
        let dataSourceSize = lineStrArray.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..dataSourceSize) {
                lineStrArray.replaceData(i, arr[i])
                lineInt64Array.replaceData(i, arr[i])
            }
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                lineStrArray.addData(arr[i])
                lineInt64Array.addData(arr[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            for (i in 0..refreshNodeViewSize) {
                lineStrArray.replaceData(i, arr[i])
                lineInt64Array.replaceData(i, arr[i])
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..refreshNodeViewSize) {
                lineStrArray.replaceData(i, arr[i])
                lineInt64Array.replaceData(i, arr[i])
            }
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                lineStrArray.deleteData(i)
                lineInt64Array.deleteData(i)
            }
        }
        if (markdownConfiguration.markdownTheme.separateCodeIsBottom) {
            scrollChatIfAtBottom()
        }
    }
}
