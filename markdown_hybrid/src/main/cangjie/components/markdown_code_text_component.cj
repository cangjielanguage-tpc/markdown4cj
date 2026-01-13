/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.arkui.state_macro_manage.*

/**
 * 单独代码块自定义控件
 */
@Component
class MarkdownCodeTextComponent {
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
     * 第几条
     */
    @State
    var idx: Int64 = 0

    /**
     * 高亮代码列表
     */
    @State
    var arrayList: ObservedArrayList<PrismNodesParseResUI> = ObservedArrayList<PrismNodesParseResUI>()

    /**
     * 缓存的单独代码块控件
     */
    var codeTextComponents: HashMap<Int64, MarkdownCodeTextComponent>

    /**
     * 代码高亮
     */
    var psh: ?PrismSyntaxHighlight = Option<PrismSyntaxHighlight>.None

    protected override func aboutToAppear(): Unit {
        psh = PrismSyntaxHighlight.create(prism, markdownConfiguration.markdownTheme.prismTheme)
        // 初始化刷新数据
        refreshData(codeText, info)
        // 缓存当前控件
        codeTextComponents.add(idx, this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        codeTextComponents.remove(idx)
    }

    func build() {
        Row() {
            Text((idx + 1).toString())
                // 设置文本的最大行数
                .maxLines(1)
                // 设置文本超长时的显示方式
                .textOverflow(TextOverflow.Ellipsis)
                // 设置组件自身的宽度
                .width(2)
                // 设置文本颜色
                .fontColor(Color.Transparent)
                // 设置行高
                .lineHeight(markdownConfiguration.markdownTheme.codeBlockLineHeight)
                // 设置文本尺寸
                .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                // 设置文本的字体列表
                .fontFamily(markdownConfiguration.markdownTheme.codeBlockTypeface)
                // 设置多行文本的文本对齐方式
                .textAlign(TextAlign.Start)
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
                    }
                )
            }
            // 设置文本尺寸
            .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
            // 设置文本的字体列表
            .fontFamily(markdownConfiguration.markdownTheme.codeBlockTypeface)
            // 设置多行文本的文本对齐方式
            .textAlign(TextAlign.Start)
            // 设置文本的最大行数
            .maxLines(1)
            // 设置文本超长时的显示方式
            .textOverflow(TextOverflow.Ellipsis)
            // 设置内边距属性
            .padding(left: markdownConfiguration.markdownTheme.codeMultilineMargin, right: markdownConfiguration.markdownTheme.codeMultilineMargin + markdownConfiguration.markdownTheme.separateCodeBlockWidth)
            // 设置行高
            .lineHeight(markdownConfiguration.markdownTheme.codeBlockLineHeight)
        }
    }

    func refreshData(codeText: String, info: Option<String>): Unit {
        this.codeText = codeText
        this.info = info
        let callback: (ArrayList<PrismNodesParseResUI>) -> Unit = {
            prismNodesParseResLists => launch {
                arrayList.clear()
                arrayList.appendAll(prismNodesParseResLists)
            }
        }
        stringToResList(codeText, info, markdownConfiguration.markdownTheme.prismTheme, callback)
    }

    /**
     * 通过异步的方式将代码转换成带有颜色的列表 - 围栏代码、缩进代码
     *
     * @param code 传入代码内容
     * @param info 传入代码类型
     * @param prismTheme 传入的高亮样式
     * @param callback PrismNodesParseRes列表回调接口
     */
    func stringToResList(code: String, info: ?String, prismTheme: PrismTheme, callback: (ArrayList<PrismNodesParseResUI>) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var prismNodesParseResList: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
            try {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                prismNodesParseResList = psh().highlight(info, code.trimEnd("\n"))
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                callback(prismNodesParseResList)
            } catch (e: Exception) {
                let prismNodesParseRes: PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: code, alias: Option<String>.None, color: Option<Color>.None)
                prismNodesParseResList.add(prismNodesParseRes)
                callback(prismNodesParseResList)
            }
        }
        return fut
    }
}
