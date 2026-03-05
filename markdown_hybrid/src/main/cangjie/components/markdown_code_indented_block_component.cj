/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 缩进代码块
 */
@Component
class MarkdownCodeIndentedBlockComponent {
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
     * 缓存的缩进代码块控件列表
     */
    var indentedCodeComponents: HashMap<Int64, MarkdownCodeIndentedBlockComponent>

    /**
     * 代码行数
     */
    @State
    var lines: Int64 = 0

    /**
     * 代码行数显示数据列表
     */
    @State
    var lineArray: ObservedArrayList<Int64> = ObservedArrayList<Int64>()

    /**
     * 只记录本层级的最后一个字符，本层所有数据都在同一个text组件
     */
    @State
    var isEndByParent: Bool = false

    protected override func aboutToAppear(): Unit {
        refreshData(codeText, info, nodeHash, isEndByParent) // 初始化刷新数据
        indentedCodeComponents.add(nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = indentedCodeComponents.get(nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                indentedCodeComponents.remove(nodeHash)
            }
        } else {
            indentedCodeComponents.remove(nodeHash)
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
                                .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                                .lineHeight(markdownConfiguration.markdownTheme.codeBlockLineHeight)
                                .maxLines(1)
                                .textOverflow(TextOverflow.Ellipsis)
                        },
                        keyGeneratorFunc: {
                            item: Int64, idx: Int64 => return "${idx}-${item}"
                        }
                    )
                }
                .margin(bottom: 10)
                .padding(left: 8, right: 8)
                .alignItems(HorizontalAlign.End)
                .borderWidth(EdgeWidths(right: markdownConfiguration.markdownTheme.thematicBreakHeight.vp))
                .borderStyle(BorderStyle.Solid)
                .borderColor(indentedCodeTextColor(markdownConfiguration.markdownTheme,markdownConfiguration.markdownTheme.prismTheme))
                .visibility(isVisibility(markdownConfiguration.markdownTheme.codeBlockLineNumberHide))
                codeBlockComponent()
            }
        }
        .width(100.percent)
        .borderRadius(markdownConfiguration.markdownTheme.codeBlockRadius)
        .backgroundColor(codeBackgroundColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
    }

    /**
     * 代码块部分
     */
    @Builder
    func codeBlockComponent() {
        Scroll() {
            if (isEndByParent) {
                Text() {
                    Span(spanEndText(codeText.trimEnd("\n"))[0])
                        .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
                    // 最后一个字符
                    Span(spanEndText(codeText.trimEnd("\n"))[1])
                        .fontColor(markdownConfiguration.markdownTheme.typeWriterColor)
                        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
                }
                .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                .fontFamily(markdownConfiguration.markdownTheme.codeBlockTypeface)
                .textAlign(TextAlign.Start)
                .padding(left: markdownConfiguration.markdownTheme.codeMultilineMargin, right: markdownConfiguration.markdownTheme.codeMultilineRightMargin)
                .lineHeight(markdownConfiguration.markdownTheme.codeBlockLineHeight)

            } else {
                // 代码文本内容
                Text(codeText)
                    .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                    .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                    .fontFamily(markdownConfiguration.markdownTheme.codeBlockTypeface)
                    .textAlign(TextAlign.Start)
                    .padding(left: markdownConfiguration.markdownTheme.codeMultilineMargin, right: markdownConfiguration.markdownTheme.codeMultilineRightMargin)
                    .lineHeight(markdownConfiguration.markdownTheme.codeBlockLineHeight)
            }
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .align(Alignment.Start)
        .layoutWeight(1)
        .padding(bottom: 10)
    }

    /**
     * 复制按钮和全屏按钮部分
     */
    @Builder
    func codeBlockButtonComponent() {
        Row() {
            if (codeText.trimAscii().size > 0) {
                codeBlockTextComponent(if (info.isSome()) {
                    info()
                } else {
                    markdownConfiguration.markdownTheme.codeBlockTypeTextStr
                }, markdownConfiguration)
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
            } else {
                Row()
                    .width(70.percent)
                    .justifyContent(FlexAlign.Start)
            }
        }
        .margin(top: 8.0, right: 8.0, bottom: markdownConfiguration.markdownTheme.codeBlockTypeTextPadding)
        .alignItems(VerticalAlign.Center)
    }

    /**
     * 数据刷新
     */
    public func refreshData(codeText: String, info: Option<String>, nodeHash: Int64, isEnd: Bool): Unit {
        if (!isEnd) {
            isEndByParent = false
        }
        this.info = info
        this.codeText = codeText
        this.nodeHash = nodeHash
        let arr = this.codeText.split("\n") // 代码块数据分割
        lines = arr.size
        lineArray.set(Array<Int64>(lines, repeat: 0))
    }
}
