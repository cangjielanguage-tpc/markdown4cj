/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown围栏代码块自定义控件
 */
@Component
class MarkdownFencedCodeBlockComponent {
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
    var info: String = ""

    /**
     * hash
     */
    @State
    var nodeHash: Int64 = 0

    /**
     * hash
     */
    @State
    var isCodeNone: Bool = false

    /**
     * 高亮代码列表
     */
    @State
    var arrayList: ObservedArrayList<PrismNodesParseResUI> = ObservedArrayList<PrismNodesParseResUI>()

    /**
     * 缓存的围栏代码块控件列表
     */
    var fencedCodeComponents: HashMap<Int64, MarkdownFencedCodeBlockComponent>

    /**
     * 代码行数显示数据列表
     */
    @State
    var lineArray: ObservedArrayList<Int64> = ObservedArrayList<Int64>()

    /**
     * 代码高亮
     */
    var psh: ?PrismSyntaxHighlight = Option<PrismSyntaxHighlight>.None

    protected override func aboutToAppear(): Unit {
        psh = PrismSyntaxHighlight.create(prism, markdownConfiguration.markdownTheme.prismTheme)
        // 初始化刷新数据
        refreshData(codeText, info, nodeHash)
        // 缓存当前控件
        fencedCodeComponents.add(nodeHash, this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = fencedCodeComponents.get(nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                fencedCodeComponents.remove(nodeHash)
            }
        } else {
            fencedCodeComponents.remove(nodeHash)
        }
    }

    func build() {
        Column() {
            codeBlockButtonComponent()
            Row() {
                Column() {
                    ForEach(
                        lineArray,
                        itemGeneratorFunc: {
                            item: Int64, idx: Int64 => Text((idx + 1).toString())
                                // 设置文本颜色
                                .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                // 设置文本尺寸
                                .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                                // 设置行高
                                .lineHeight(markdownConfiguration.markdownTheme.codeBlockLineHeight)
                                // 设置文本的最大行数
                                .maxLines(1)
                                // 设置文本超长时的显示方式
                                .textOverflow(TextOverflow.Ellipsis)
                        },
                        keyGeneratorFunc: {
                            item: Int64, idx: Int64 => return "${idx}-${item}"
                        }
                    )
                }
                // 设置外边距属性
                .margin(bottom: 10)
                // 设置内边距属性
                .padding(left: 8, right: 8)
                // 设置 Column 子组件在水平方向上的对齐格式
                .alignItems(HorizontalAlign.End)
                // 设置边框的宽度
                .borderWidth(EdgeWidths(right: markdownConfiguration.markdownTheme.thematicBreakHeight.vp))
                // 设置元素的边框样式
                .borderStyle(BorderStyle.Solid)
                // 设置边框的颜色
                .borderColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                // 控件显示和隐藏
                .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockLineNumberHide))
                Scroll() {
                    Column() {
                        Text() {
                            ForEach(
                                arrayList,
                                itemGeneratorFunc: {
                                    item: PrismNodesParseResUI, idx: Int64 =>
                                    // 设置文本内容
                                    Span(item.getText())
                                        // 设置文本颜色
                                        .fontColor(codeTextColor(item, markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                        // 设置文本字符间距
                                        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
                                },
                                keyGeneratorFunc: {
                                    item: PrismNodesParseResUI, idx: Int64 => return "${idx}-${item.getText()}"
                                }
                            )
                        }
                        // 设置文本尺寸
                        .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                        // 设置文本的字体列表
                        .fontFamily(markdownConfiguration.markdownTheme.codeBlockTypeface)
                        // 设置多行文本的文本对齐方式
                        .textAlign(TextAlign.Start)
                        // 设置内边距属性
                        .padding(left: markdownConfiguration.markdownTheme.codeMultilineMargin, right: markdownConfiguration.markdownTheme.codeMultilineRightMargin)
                        // 设置行高
                        .lineHeight(markdownConfiguration.markdownTheme.codeBlockLineHeight)
                    }
                }
                // 设置滚动方法
                .scrollable(ScrollDirection.Horizontal)
                // 设置滚动条状态
                .scrollBar(BarState.Off)
                // 对子组件进行重新布局
                .layoutWeight(1)
                // 设置元素内容的对齐方式
                .align(Alignment.Start)
                // 设置内边距属性
                .padding(bottom: 10)
            }
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置圆角
        .borderRadius(markdownConfiguration.markdownTheme.codeBlockRadius)
        // 设置背景色
        .backgroundColor(codeBackgroundColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
    }

    /**
     * 复制按钮和全屏按钮部分
     */
    @Builder
    func codeBlockButtonComponent() {
        Row() {
            if (isCodeNone) {
                // 设置图片的数据源
                codeBlockTextComponent(if (info != "") { info } else { markdownConfiguration.markdownTheme.codeBlockTypeTextStr }, markdownConfiguration)
                Row() {
                    if (markdownConfiguration.markdownTheme.codeCopyIcon.isSome()) {
                        Row() {
                            Image(markdownConfiguration.markdownTheme.codeCopyIcon())
                                // 设置组件自身的宽度
                                .width(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                // 设置组件自身的高度
                                .height(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                // 设置图片的缩放类型
                                .objectFit(ImageFit.Contain)

                            Row()
                                // 设置宽度
                                .width(5)

                            if (markdownConfiguration.markdownTheme.codeBlockIconTextHide) {
                                Text("复制代码")
                                    // 设置字体颜色
                                    .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                    // 设置字体大小
                                    .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                                    // 设置容器元素绘制区域内的子元素的对齐方式
                                    .align(Alignment.End)
                                    // 设置文本的最大行数
                                    .maxLines(1)
                                    // 设置文本超长时的显示方式
                                    .textOverflow(TextOverflow.Ellipsis)
                                    // 设置外边距
                                    .margin(right: 4)
                            }
                        }
                        // 设置子组件在水平方向上的对齐格式
                        .justifyContent(FlexAlign.End)
                        // 点击动作触发该方法调用
                        .onClick {evt => codeCopyOnClick(codeText, markdownConfiguration.codeCopyCallback)}
                    }

                    if (markdownConfiguration.markdownTheme.codeFullScreenIcon.isSome()) {
                        Row() {
                            Image(markdownConfiguration.markdownTheme.codeFullScreenIcon())
                                // 设置组件自身的宽度
                                .width(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                // 设置组件自身的高度
                                .height(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                // 设置外边距属性
                                .margin(left: 4)
                                // 设置图片的缩放类型
                                .objectFit(ImageFit.Contain)

                            Row()
                                // 设置宽度
                                .width(5)

                            if (markdownConfiguration.markdownTheme.codeBlockIconTextHide) {
                                Text("全屏代码")
                                    // 设置字体颜色
                                    .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                    // 设置字体大小
                                    .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                                    // 设置容器元素绘制区域内的子元素的对齐方式
                                    .align(Alignment.End)
                                    // 设置文本的最大行数
                                    .maxLines(1)
                                    // 设置文本超长时的显示方式
                                    .textOverflow(TextOverflow.Ellipsis)
                                    // 设置外边距
                                    .margin(right: 4)
                            }
                        }
                        // 设置子组件在水平方向上的对齐格式
                        .justifyContent(FlexAlign.End)
                        // 控制当前组件显示或隐藏
                        .visibility(isVisibility(markdownConfiguration.markdownTheme.isCodeFullScreen))
                        // 点击动作触发该方法调用
                        .onClick {
                            evt => codeFullScreenOnClick(codeText, info, markdownConfiguration.codeFullScreenCallback)
                        }
                    }
                }
                // 设置宽度
                .width(70.percent)
                // 设置子组件在水平方向上的对齐格式
                .justifyContent(FlexAlign.End)
            }
        }
        // 设置外边距属性
        .margin(top: 8.0, right: 8.0, bottom: markdownConfiguration.markdownTheme.codeBlockTypeTextPadding)
        // 设置子组件在垂直方向上的对齐格式
        .alignItems(VerticalAlign.Center)
    }

    /**
     * 数据刷新
     */
    public func refreshData(codeText: String, info: String, nodeHash: Int64): Unit {
        this.codeText = codeText
        this.isCodeNone = this.codeText.trimAscii().size > 0
        this.info = info
        this.nodeHash = nodeHash
        if (markdownConfiguration.markdownTheme.isCodeBlockParserSync) {
            stringCodeToResListSync(this.codeText)
        } else {
            stringCodeToResList(this.codeText)
        }
    }

    /**
     * 代码数据高亮解析
     */
    func stringCodeToResListSync(code: String) {
        let codeText = if (markdownConfiguration.markdownTheme.isCodeFormat) {
            codeFormat(info, code, FormatConfig())
        } else {
            code
        }
        let lines = codeText.lines().count()
        refreshLines(lines)
        var prismNodesParseResUIList: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
        try {
            prismNodesParseResUIList = psh().highlight(info, codeText.trimEnd("\n"))
        } catch (e: Exception) {
            let prismNodesParseResUI: PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: codeText, alias: Option<String>.None, color: Option<Color>.None)
            prismNodesParseResUIList.add(prismNodesParseResUI)
        }
        let newSize = prismNodesParseResUIList.size
        let oldSize = arrayList.size
        if (newSize == oldSize) {
            for (i in 0..oldSize) {
                if (arrayList[i].getText() != prismNodesParseResUIList[i].getText()) {
                    arrayList[i] = prismNodesParseResUIList[i]
                }
            }
        } else if (newSize > oldSize) {
            for (i in 0..oldSize) {
                if (arrayList[i].getText() != prismNodesParseResUIList[i].getText()) {
                    arrayList[i] = prismNodesParseResUIList[i]
                }
            }
            for (i in oldSize..newSize) {
                arrayList.append(prismNodesParseResUIList[i])
            }
        } else {
            for (i in 0..newSize) {
                if (arrayList[i].getText() != prismNodesParseResUIList[i].getText()) {
                    arrayList[i] = prismNodesParseResUIList[i]
                }
            }
            // 循环删除多余的旧数据
            for (i in oldSize - 1..=newSize : -1) {
                arrayList.remove(i)
            }
        }
    }

    /**
     * 行号刷新
     */
    func refreshLines(lines: Int64): Unit {
        let newSize = lines
        let oldSize = lineArray.size
        if (newSize == oldSize) {
        } else if (newSize > oldSize) {
            // 循环添加新数据
            for (i in oldSize..newSize) {
                lineArray.append(oldSize + i)
            }
        } else {
            // 循环删除多余的旧数据
            for (i in oldSize - 1..=newSize : -1) {
                lineArray.remove(i)
            }
        }
    }

    /**
     * 代码数据高亮解析
     */
    func stringCodeToResList(str: String) {
        let callback: (ArrayList<PrismNodesParseResUI>, Int64) -> Unit = {
            prismNodesParseResLists, lines => launch {
                refreshLines(lines)
                let newSize = prismNodesParseResLists.size
                let oldSize = arrayList.size
                if (newSize == oldSize) {
                    for (i in 0..oldSize) {
                        if (arrayList[i].getText() != prismNodesParseResLists[i].getText()) {
                            arrayList[i] = prismNodesParseResLists[i]
                        }
                    }
                } else if (newSize > oldSize) {
                    for (i in 0..oldSize) {
                        if (arrayList[i].getText() != prismNodesParseResLists[i].getText()) {
                            arrayList[i] = prismNodesParseResLists[i]
                        }
                    }
                    for (i in oldSize..newSize) {
                        arrayList.append(prismNodesParseResLists[i])
                    }
                } else {
                    for (i in 0..newSize) {
                        if (arrayList[i].getText() != prismNodesParseResLists[i].getText()) {
                            arrayList[i] = prismNodesParseResLists[i]
                        }
                    }
                    // 循环删除多余的旧数据
                    for (i in oldSize - 1..=newSize : -1) {
                        arrayList.remove(i)
                    }
                }
            }
        }
        stringToResList(str, info, callback)
    }

    /**
     * 通过异步的方式将代码转换成带有颜色的列表 - 围栏代码、缩进代码
     *
     * @param code 传入代码内容
     * @param info 传入代码类型
     * @param callback PrismNodesParseRes列表回调接口
     */
    func stringToResList(code: String, info: ?String, callback: (ArrayList<PrismNodesParseResUI>, Int64) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            let codeText = if (markdownConfiguration.markdownTheme.isCodeFormat) {
                codeFormat(info, code, FormatConfig())
            } else {
                code
            }
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let lines = codeText.lines().count()
            var prismNodesParseResUIList: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
            try {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                prismNodesParseResUIList = psh().highlight(info, codeText.trimEnd("\n"))
                callback(prismNodesParseResUIList, lines)
            } catch (e: Exception) {
                let prismNodesParseResUI: PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: codeText, alias: Option<String>.None, color: Option<Color>.None)
                prismNodesParseResUIList.add(prismNodesParseResUI)
                callback(prismNodesParseResUIList, lines)
            }
        }
        return fut
    }
}
