package markdown.components

import ohos.state_macro_manage.*

/**
 * 缩进代码块
 */
@Component
class MarkdownCodeIndentedBlockComponent {
    @Prop
    var markdownConfiguration: MarkdownConfiguration // markdown配置
    @State
    var codeText: String = "" // 代码内容
    @State
    var info: Option<String> = Option<String>.None // 代码类型
    @State
    var nodeHash: Int64 = 0 // hash
    @State
    var lineArray: ObservedArrayList<Int64> = ObservedArrayList<Int64>() // 代码行数显示数据列表（存1..N）

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(this.nodeHash, refreshData)
        refreshDataInternal()
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(this.nodeHash)
    }

    func build() {
        Column() {
            codeTitleComponent(codeText, if (info.isSome()) { info() } else { "" }, markdownConfiguration, true)
            Row() {
                Column() {
                    ForEach(
                        lineArray,
                        itemGeneratorFunc: {
                            item: Int64, idx: Int64 => Text(item.toString())
                                .fontFamily(codeLineNumberTextFontFamily(markdownConfiguration.markdownTheme))
                                .fontSize(codeLineNumberTextSize(markdownConfiguration.markdownTheme))
                                .fontWeight(codeLineNumberTextFontWeight(markdownConfiguration.markdownTheme))
                                .fontStyle(codeLineNumberTextFontStyle(markdownConfiguration.markdownTheme))
                                .fontColor(codeLineNumberTextColor(markdownConfiguration.markdownTheme))
                                .lineHeight(codeLineNumberTextLineHeight(markdownConfiguration.markdownTheme))
                                .maxLines(1)
                                .textOverflow(TextOverflow.Ellipsis)
                        },
                        keyGeneratorFunc: {
                            item: Int64, idx: Int64 => return "${item}"
                        }
                    )
                }
                .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberIsShow))
                .padding(right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberDividerSpacing, left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockLineNumberTextPaddingLeft)
                .borderWidth(EdgeWidths(right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockDividerStrokeWidth.vp))
                .borderColor(codeDividerColor(markdownConfiguration.markdownTheme))
                .borderStyle(BorderStyle.Solid)
                .alignItems(HorizontalAlign.End)
                codeBlockComponent()
            }
        }
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
        .margin(
            top: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginTop,
            right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginRight,
            bottom: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginBottom,
            left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockMarginLeft
        )
    }

    /**
     * 代码块部分
     */
    @Builder
    func codeBlockComponent() {
        Scroll() {
            // 代码文本内容
            Text(codeText)
                .fontFamily(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontFamily)
                .fontSize(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontSize)
                .fontWeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontWeight)
                .fontStyle(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextFontStyle)
                // issue #730：rawText 兜底样式与高亮路径保持一致，补挂 letterSpacing
                .letterSpacing(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLetterSpacing)
                .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme))
                .lineHeight(markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextLineHeight)
                .textAlign(TextAlign.Start)
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .align(Alignment.Start)
        .layoutWeight(1)
        .margin(left: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextMarginLeft, right: markdownConfiguration.markdownTheme.codeBlockTheme.codeBlockTextMarginRight)
    }

    /**
     * 数据刷新
     */
    public func refreshData(newNodeView: NodeView): Unit {
        this.codeText = newNodeView.nodeText
        this.info = newNodeView.codeInfo
        this.nodeHash = newNodeView.nodeHash
        refreshDataInternal()
    }

    public func refreshDataInternal(): Unit {
        let arr = this.codeText.split("\n") // 代码块数据分割
        let lines = arr.size
        // 行号数据存1..N（与ArkUI一致）
        lineArray.set(Array<Int64>(lines, {i: Int64 => i + 1}))
    }
}
