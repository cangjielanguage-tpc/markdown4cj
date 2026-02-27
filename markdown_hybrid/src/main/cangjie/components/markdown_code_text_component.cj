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
class MarkdownCodeTextComponent {
    /**
     * markdown配置
     */
    var markdownTheme: MarkdownTheme

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
     * 高亮代码列表
     */
    @State
    var arrayList: ObservedArrayList<PrismNodesParseResUI> = ObservedArrayList<PrismNodesParseResUI>()

    /**
     * 代码高亮
     */
    var psh: ?PrismSyntaxHighlight = Option<PrismSyntaxHighlight>.None

    protected override func aboutToAppear(): Unit {
        psh = PrismSyntaxHighlight.create(prism, markdownTheme.prismTheme)
        refreshData(codeText, info) // 初始化刷新数据
    }

    func build() {
        Text() {
            ForEach(
                arrayList,
                itemGeneratorFunc: {
                    item: PrismNodesParseResUI, idx: Int64 => Span(item.getText())
                        .fontColor(codeTextColor(item, markdownTheme, markdownTheme.prismTheme))
                        .letterSpacing(markdownTheme.paragraphTextWordSpace)
                },
                keyGeneratorFunc: {
                    item: PrismNodesParseResUI, idx: Int64 => "${idx}-${item.getText()}"
                }
            )
        }
        .fontSize(markdownTheme.codeBlockTextSize)
        .fontFamily(markdownTheme.codeBlockTypeface)
        .textAlign(TextAlign.Start)
        .maxLines(1)
        .textOverflow(TextOverflow.Ellipsis)
        .padding(left: markdownTheme.codeMultilineMargin, right: markdownTheme.codeMultilineMargin + markdownTheme.separateCodeBlockWidth)
        .lineHeight(markdownTheme.codeBlockLineHeight)
    }

    /**
     * 数据刷新
     */
    func refreshData(codeText: String, info: Option<String>): Unit {
        this.codeText = codeText
        this.info = info
        var prismNodesParseResList: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
        try {
            prismNodesParseResList = psh().highlight(this.info, this.codeText.trimEnd("\n"))
        } catch (e: Exception) {
            let prismNodesParseRes: PrismNodesParseResUI = PrismNodesParseResUI(types: "", text: this.codeText, alias: Option<String>.None, color: Option<Color>.None)
            prismNodesParseResList.add(prismNodesParseRes)
        }
        arrayList.clear()
        arrayList.appendAll(prismNodesParseResList)
    }
}
