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
     * 定位需要的数组
     */
    var indexList: ArrayList<Int64> = ArrayList<Int64>()

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
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

    /**
     * 高亮代码列表
     */
    @State
    var arrayList: ObservedArrayList<PrismNodesParseRes> = ObservedArrayList<PrismNodesParseRes>()

    /**
     * 缓存的第一层代码块控件列表
     */
    var fencedCodeComponents: ArrayList<MarkdownFencedCodeBlockComponent>

    /**
     * 代码行数
     */
    @State
    @Watch[refreshLines]
    var lines: Int64 = 0

    /**
     * 代码行数显示数据列表
     */
    @State
    var lineArray: ObservedArrayList<Int64> = ObservedArrayList<Int64>()

    protected override func aboutToAppear(): Unit {
        refreshData(codeText, info)
        fencedCodeComponents.add(this)
    }

    protected override func aboutToDisappear(): Unit {
        fencedCodeComponents.removeIf(
            {
                predicate => if (predicate.indexList == indexList && predicate.codeText == codeText) {
                    true
                } else {
                    false
                }
            })
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
                codeBlockComponent()
            }
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
        // 设置圆角
        .borderRadius(markdownConfiguration.markdownTheme.codeBlockRadius)
        // 设置背景色
        .backgroundColor(codeBackgroundColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
    }

    /**
     * 代码文本内容
     */
    @Builder
    func codeBlockTextComponent() {
        Text() {
            ForEach(
                arrayList,
                itemGeneratorFunc: {
                    item: PrismNodesParseRes, idx: Int64 =>
                    // 设置文本内容
                    Span(item.getText())
                        // 设置文本颜色
                        .fontColor(codeTextColor(item, markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                        // 设置文本字符间距
                        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
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
        .padding(left: markdownConfiguration.markdownTheme.codeMultilineMargin)
        // 设置行高
        .lineHeight(markdownConfiguration.markdownTheme.codeBlockLineHeight)
    }

    /**
     * 代码块部分
     */
    @Builder
    func codeBlockComponent() {
        Scroll() {
            // 代码文本内容
            codeBlockTextComponent()
        }
        // 设置滚动方法
        .scrollable(ScrollDirection.Horizontal)
        // 设置滚动条状态
        .scrollBar(BarState.Off)
        // 设置元素内容的对齐方式
        .align(Alignment.Start)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置内边距属性
        .padding(bottom: 10)
    }

    /**
     * 复制按钮和全屏按钮部分
     */
    @Builder
    func codeBlockButtonComponent() {
        Row() {
            if (codeText.trimAscii().size > 0) {
                // 设置图片的数据源
                if (info != "") {
                    Row() {
                        Text(info)
                            // 设置字体颜色
                            .fontColor(indentedCodeodeBlockTypeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                            // 设置字体大小
                            .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                            // 设置文本的最大行数
                            .maxLines(1)
                            // 设置文本超长时的显示方式
                            .textOverflow(TextOverflow.Ellipsis)
                            // 设置外边距
                            .margin(left: 8)
                    }
                    // 设置宽度
                    .width(30.percent)
                    // 设置子组件在水平方向上的对齐格式
                    .justifyContent(FlexAlign.Start)
                } else {
                    Row() {
                        Text(markdownConfiguration.markdownTheme.codeBlockTypeTextStr)
                            // 设置字体颜色
                            .fontColor(indentedCodeodeBlockTypeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                            // 设置字体大小
                            .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                            // 设置文本的最大行数
                            .maxLines(1)
                            // 设置文本超长时的显示方式
                            .textOverflow(TextOverflow.Ellipsis)
                            // 设置外边距
                            .margin(left: 8)
                    }
                    // 设置宽度
                    .width(30.percent)
                    // 设置子组件在水平方向上的对齐格式
                    .justifyContent(FlexAlign.Start)
                }

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

                            if(markdownConfiguration.markdownTheme.codeBlockIconTextHide){
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

                            if(markdownConfiguration.markdownTheme.codeBlockIconTextHide){
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

    func refreshLines(): Unit {
        lineArray.set(Array<Int64>(lines, repeat: 0))
    }

    /**
     * 数据刷新
     */
    public func refreshData(str: String, tp: String): Unit {
        info = tp
        codeText = str
        lines = codeText.lines().count()
        lineArray.set(Array<Int64>(lines, repeat: 0))
        stringCodeToResList(str)
    }

    /**
     * 代码数据高亮解析
     */
    func stringCodeToResList(str: String) {
        let callback: (ArrayList<PrismNodesParseRes>) -> Unit = {
            prismNodesParseResLists => launch {
                arrayList.clear()
                arrayList.appendAll(prismNodesParseResLists)
            }
        }
        stringToResList(str, info, markdownConfiguration.markdownTheme.prismTheme, callback)
    }

    /**
     * 通过异步的方式将代码转换成带有颜色的列表 - 围栏代码、缩进代码
     *
     * @param code 传入代码内容
     * @param info 传入代码类型
     * @param prismTheme 传入的高亮样式
     * @param callback PrismNodesParseRes列表回调接口
     */
    func stringToResList(code: String, info: ?String, prismTheme: PrismTheme, callback: (ArrayList<PrismNodesParseRes>) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var prismNodesParseResList: ArrayList<PrismNodesParseRes> = ArrayList<PrismNodesParseRes>()
            try {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var prism: Prism = Prism(GrammarLocatorGrammarUtils())
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var psh: PrismSyntaxHighlight = PrismSyntaxHighlight.create(prism, prismTheme)
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                prismNodesParseResList = psh.highlight(info, code.trimEnd("\n"))
            } catch (e: Exception) {
                let prismNodesParseRes: PrismNodesParseRes = PrismNodesParseRes("", code, Option<String>.None, Option<Color>.None)
                prismNodesParseResList.add(prismNodesParseRes)
            } finally {
                try {
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    callback(prismNodesParseResList)
                } catch (_) {
                }
            }
        }
        return fut
    }
}
