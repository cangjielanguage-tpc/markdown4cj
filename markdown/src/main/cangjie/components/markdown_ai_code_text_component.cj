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
class MarkdownAICodeTextComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

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
     * 定位需要的数组
     */
    var indexList: ArrayList<Int64> = ArrayList<Int64>()

    /**
     * 第几条
     */
    @State
    var idx: Int64 = 0

    /**
     * 高亮代码列表
     */
    @State
    var arrayList: ObservedArrayList<PrismNodesParseRes> = ObservedArrayList<PrismNodesParseRes>()

    var aiCodeTextComponents: ArrayList<MarkdownAICodeTextComponent>

    protected override func aboutToAppear(): Unit {
        refreshData(codeText, info)
        aiCodeTextComponents.add(this)
    }

    protected override func aboutToDisappear(): Unit {
        aiCodeTextComponents.removeIf(
            {
                predicate => if (predicate.indexList == indexList && predicate.codeText == codeText) {
                    true
                } else {
                    false
                }
            })
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
                .fontColor(Color.TRANSPARENT)
                // 设置行高
                .lineHeight(markdownAIConfiguration.markdownAITheme.codeBlockLineHeight)
                // 设置文本尺寸
                .fontSize(markdownAIConfiguration.markdownAITheme.codeBlockTextSize)
                // 设置文本的字体列表
                .fontFamily(markdownAIConfiguration.markdownAITheme.codeBlockTypeface)
                // 设置多行文本的文本对齐方式
                .textAlign(TextAlign.Start)
            Text() {
                ForEach(
                    arrayList,
                    itemGeneratorFunc: {
                        item: PrismNodesParseRes, idx: Int64 =>
                        // 设置文本内容
                        Span(item.getText())
                            // 设置文本颜色
                            .fontColor(codeTextColor(item, markdownAIConfiguration.markdownAITheme, markdownAIConfiguration.markdownAITheme.prismTheme))
                            // 设置文本字符间距
                            .letterSpacing(markdownAIConfiguration.markdownAITheme.paragraphTextWordSpace)
                    }
                )
            }
            // 设置文本尺寸
            .fontSize(markdownAIConfiguration.markdownAITheme.codeBlockTextSize)
            // 设置文本的字体列表
            .fontFamily(markdownAIConfiguration.markdownAITheme.codeBlockTypeface)
            // 设置多行文本的文本对齐方式
            .textAlign(TextAlign.Start)
            // 设置文本的最大行数
            .maxLines(1)
            // 设置文本超长时的显示方式
            .textOverflow(TextOverflow.Ellipsis)
            // 设置内边距属性
            .padding(left: markdownAIConfiguration.markdownAITheme.codeMultilineMargin, right: markdownAIConfiguration.markdownAITheme.codeMultilineMargin + markdownAIConfiguration.markdownAITheme.separateCodeBlockWidth)
            // 设置行高
            .lineHeight(markdownAIConfiguration.markdownAITheme.codeBlockLineHeight)
        }
    }

    func refreshData(codeText: String, info: Option<String>): Unit {
        this.codeText = codeText
        this.info = info
        let callback: (ArrayList<PrismNodesParseRes>) -> Unit = {
            prismNodesParseResLists => launch {
                arrayList.clear()
                arrayList.appendAll(prismNodesParseResLists)
            }
        }
        stringToResList(codeText, info, markdownAIConfiguration.markdownAITheme.prismTheme, callback)
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
