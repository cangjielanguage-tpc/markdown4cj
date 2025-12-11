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
     * 列表节点
     */
    var nodeView: NodeView

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
     * 高亮代码列表
     */
    @State
    var arrayList: ObservedArrayList<PrismNodesParseRes> = ObservedArrayList<PrismNodesParseRes>()

    /**
     * 缓存的围栏代码块控件列表
     */
    var fencedCodeComponents: HashMap<Int64, MarkdownFencedCodeBlockComponent>

    /**
     * 代码行数显示数据列表
     */
    @State
    var lineArray: ObservedArrayList<Int64> = ObservedArrayList<Int64>()

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeView)
        // 缓存当前控件
        fencedCodeComponents.add(this.nodeView.nodeHash, this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = fencedCodeComponents.get(this.nodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                fencedCodeComponents.remove(this.nodeView.nodeHash)
            }
        } else {
            fencedCodeComponents.remove(this.nodeView.nodeHash)
        }
    }

    func build() {
        Column() {
            codeBlockButtonComponent()
            Row() {
                codeNumberComponent(lineArray, markdownConfiguration)
                codeBlockComponent()
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
                },
                keyGeneratorFunc: {
                    item: PrismNodesParseRes, idx: Int64 => return "${idx}-${item.getText()}"
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
                codeImageComponent(markdownConfiguration, codeText, Option<String>.None, info, 1)
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
    public func refreshData(nodeView: NodeView): Unit {
        this.nodeView = nodeView
        let data = getCodeInfo(nodeView)
        this.info = data[1]()
        this.codeText = data[0]
        let lines = codeText.lines().count()
        refreshLines(lines)
        stringCodeToResList(this.codeText)
    }

    /**
     * 行号刷新
     */
    func refreshLines(lines: Int64): Unit {
        let lineList = Array<Int64>(lines, repeat: 0)
        let newSize = lines
        let oldSize = lineArray.size
        if(newSize == oldSize){
        } else if(newSize > oldSize){
            // 循环添加新数据
            for (i in oldSize..newSize) {
                lineArray.append(lineList[i])
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
        let callback: (ArrayList<PrismNodesParseRes>) -> Unit = {
            prismNodesParseResLists => launch {
                let newSize = prismNodesParseResLists.size
                let oldSize = arrayList.size
                if(newSize == oldSize){
                    for(i in 0..oldSize){
                        arrayList[i] =  prismNodesParseResLists[i]
                    }
                } else if(newSize > oldSize){
                    for (i in 0..oldSize) {
                        arrayList[i] =  prismNodesParseResLists[i]
                    }
                    for (i in oldSize..newSize) {
                        arrayList.append(prismNodesParseResLists[i])
                    }
                } else {
                    for (i in 0..newSize) {
                        arrayList[i] =  prismNodesParseResLists[i]
                    }
                    // 循环删除多余的旧数据
                    for (i in oldSize - 1..=newSize : -1) {
                        arrayList.remove(i)
                    }
                }
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
