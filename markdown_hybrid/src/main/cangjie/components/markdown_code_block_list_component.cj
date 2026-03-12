/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown围栏代码列表切换自定义控件
 */
@Component
class MarkdownCodeBlockListComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * Node
     */
    var nodeView: NodeView

    /**
     * 代码类型列表标题
     */
    var strInfos: ArrayList<String>

    /**
     * 代码内容列表
     */
    var strText: ArrayList<String>

    /**
     * 代码真实类型列表
     */
    var strInfoText: ArrayList<String>

    /**
     * 选中Index
     */
    @State
    var idxSelect: Int64 = 0

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
     * 所有数据
     */
    @State
    var arrayLists: ArrayList<ArrayList<PrismNodesParseResUI>> = ArrayList<ArrayList<PrismNodesParseResUI>>()

    protected override func aboutToAppear(): Unit {
        stringCodeToResLists()
    }

    func build() {
        Column() {
            // 组合代码标题内容
            codeBlockTitleComponent()
            // 组合代码代码块内容
            codeBlockComponent()
        }
        // 设置组件自身的宽度
        .width(100.percent)
    }

    /**
     * 组合代码标题部分
     */
    @Builder
    func codeBlockTitleComponent() {
        Scroll() {
            Row() {
                ForEach(
                    strInfos,
                    itemGeneratorFunc: {
                        item: String, idx: Int64 =>
                        // 设置文本内容
                        Text(item)
                            // 设置文本颜色
                            .fontColor(listCodeTextColor(idxSelect, idx, markdownConfiguration))
                            // 设置组件的背景色
                            .backgroundColor(listCodeBackgroupColor(idxSelect, idx, markdownConfiguration))
                            // 设置文本的最大行数
                            .maxLines(1)
                            // 设置文本尺寸
                            .fontSize(if (idxSelect == idx) { markdownConfiguration.markdownTheme.codeListTitleSelectTextSize } else { markdownConfiguration.markdownTheme.codeListTitleTextSize })
                            // 设置内边距属性
                            .padding(left: 14, right: 14, top: 5, bottom: 5)
                            // 点击动作触发该方法调用
                            .onClick {evt =>
                                idxSelect = idx
                                lines = strText[idxSelect].lines().count()
                                lineArray.set(Array<Int64>(lines, repeat: 0))
                            }
                    }
                )
            }
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置滚动方法
        .scrollable(ScrollDirection.Horizontal)
        // 设置滚动条状态
        .scrollBar(BarState.Off)
        // 设置元素内容的对齐方式
        .align(Alignment.Start)
        // 设置外边距属性
        .margin(bottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins)
    }

    /**
     * 组合代码代码文本内容
     */
    @Builder
    func codeBlockTextComponent(items: ArrayList<PrismNodesParseResUI>, idx: Int64) {
        Text() {
            ForEach(
                items,
                itemGeneratorFunc: {
                    item: PrismNodesParseResUI, idx1: Int64 =>
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
        // 设置行高
        .lineHeight(markdownConfiguration.markdownTheme.codeBlockLineHeight)
        // 设置多行文本的文本对齐方式
        .textAlign(TextAlign.Start)
        // 设置内边距属性
        .padding(left: markdownConfiguration.markdownTheme.codeMultilineMargin, right: markdownConfiguration.markdownTheme.codeMultilineRightMargin)
        // 控制当前组件显示或隐藏
        .visibility(listCodeTextBool(idx, idxSelect))
    }

    /**
     * 组合代码代码文本列表内容
     */
    @Builder
    func codeBlockTextListComponent() {
        Column() {
            ForEach(
                arrayLists,
                itemGeneratorFunc: {
                    items: ArrayList<PrismNodesParseResUI>, idx: Int64 =>
                    // 组合代码代码内容
                    codeBlockTextComponent(items, idx)
                }
            )
        }
    }

    /**
     * 组合代码代码部分
     */
    @Builder
    func codeBlockCodeComponent() {
        Scroll() {
            // 组合代码代码列表内容
            codeBlockTextListComponent()
        }
        // 设置滚动方法
        .scrollable(ScrollDirection.Horizontal)
        // 设置滚动条状态
        .scrollBar(BarState.Off)
        // 设置元素内容的对齐方式
        .align(Alignment.Start)
        // 对子组件进行重新布局
        .layoutWeight(1)
        // 设置内边距属性
        .padding(bottom: 10, right: 50)
    }


    /**
     * 复制按钮和全屏按钮部分
     */
    @Builder
    func codeBlockButtonComponent() {
        Row() {
            if (strText[idxSelect].trimAscii().size > 0) {
                Row()
                    // 设置宽度
                    .width(30.percent)
                    // 设置子组件在水平方向上的对齐格式
                    .justifyContent(FlexAlign.Start)
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
                        .onClick {evt => codeCopyOnClick(strText[idxSelect], markdownConfiguration.codeCopyCallback)}
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
                            evt => codeFullScreenOnClick(strText[idxSelect], strInfoText[idxSelect], markdownConfiguration.codeFullScreenCallback)
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
     * 组合代码部分
     */
    @Builder
    func codeBlockComponent() {
        Column() {
            // 复制按钮和全屏按钮内容
            codeBlockButtonComponent()
            Row() {
                Column() {
                    ForEach(
                        lineArray,
                        itemGeneratorFunc: {
                            num: Int64, idx: Int64 => Text((idx + 1).toString())
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
                // 组合代码代码块内容
                codeBlockCodeComponent()
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
     * 代码数据高亮解析
     */
    func stringCodeToResLists() {
        let callback: (ArrayList<ArrayList<PrismNodesParseResUI>>) -> Unit = {
            prismNodesParseResLists => launch {
                arrayLists = prismNodesParseResLists
            }
        }
        lines = strText[idxSelect].lines().count()
        lineArray.set(Array<Int64>(lines, repeat: 0))
        stringToResLists(nodeView, markdownConfiguration, strText, callback)
    }
}
