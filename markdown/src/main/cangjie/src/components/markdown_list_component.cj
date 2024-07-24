/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)、块引用自定义控件
 */
@Component
class MarkdownListComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 列表listNodeView
     */
    var listNodeView: NodeView

    /**
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

    /**
     * 控件宽度 - 单位vp
     */
    var componentWidth: Float64

    /**
     * TOC列表点击事件回调
     */
    var tocListOnClick: (Int64) -> Unit

    /**
     * 选中Index
     */
    @State
    var idxSelect: Int64 = 0

    func build() {
        Column() {
            if (listNodeView.node is BulletList) {
                // 无序列表
                bulletListComponent(listNodeView)
            } else if (listNodeView.node is OrderedList) {
                // 有序列表
                orderedListComponent(listNodeView)
            } else if (listNodeView.node is BlockQuote) {
                // 块引用
                blockQuoteComponent(listNodeView)
            } else {
                // 其他节点
            }
        }
        // 设置元素水平方向的布局
        .direction(Direction.Ltr)
        // 设置子组件在水平方向上的对齐格式
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式
        .justifyContent(FlexAlign.Start)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
        // 设置组件自身的宽度
        .width(100.percent)
    }

    /**
     * 无序列表和有序列表的前缀文本
     */
    @Builder
    func listPrefixText(item: NodeView, isBullet: Bool) {
        // 设置文本内容
        Text(listPrefixStr(item, isBullet))
            // 设置文本颜色
            .fontColor(listPrefixColor(markdownConfiguration.markdownTheme, isBullet))
            // 设置文本尺寸
            .fontSize(listPrefixSize(markdownConfiguration.markdownTheme, isBullet))
            // 设置内边距属性
            .padding(left: markdownConfiguration.markdownTheme.blockMargin, right: 10.0)
    }

    /**
     * 任务列表的前缀多选框
     */
    @Builder
    func listPrefixCheckbox(item: NodeView) {
        Checkbox()
            // 设置组件自身的高度
            .height(markdownConfiguration.markdownTheme.taskListItemLength)
            // 设置组件自身的宽度
            .width(markdownConfiguration.markdownTheme.taskListItemLength)
            // 设置按钮形状样式
            .select(taskSelect(item))
            // 值为 true 表示组件可用，可响应点击等操作；值为 false 时，不响应点击等操作
            .enabled(false)
            // 切换CheckBox组件形状
            .shape(CheckBoxShape.ROUNDED_SQUARE)
            // 设置外边距属性
            .margin(left: markdownConfiguration.markdownTheme.blockMargin, right: 10.0)
    }

    /**
     * 段落
     */
    @Builder
    func listParagraphComponent(nodeView: NodeView) {
        MarkdownParagraphComponent(paragraphNodeView: nodeView, markdownConfiguration: markdownConfiguration, marginTop: 0.0, marginBottom: 0.0, tocListOnClick: tocListOnClick, componentWidth: componentWidth)
    }

    /**
     * 标题
     */
    @Builder
    func listHeadingComponent(nodeView: NodeView) {
        MarkdownHeadingComponent(headingNodeView: nodeView, markdownConfiguration: markdownConfiguration, marginTop: 0.0, marginBottom: 0.0, componentWidth: componentWidth)
    }

    /**
     * 围栏代码、缩进代码
     */
    @Builder
    func listCodeBlockComponent(codeText: String, infos: ?String) {
        MarkdownCodeBlockComponent(markdownConfiguration: markdownConfiguration, codeText: codeText, info: infos, marginTop: 0.0, marginBottom: 0.0)
    }

    /**
     * 表格
     */
    @Builder
    func listTableBlockComponent(tableNodeView: NodeView) {
        MarkdownTableBlockComponent(tableNodeView: tableNodeView, markdownConfiguration: markdownConfiguration, marginTop: 0.0, marginBottom: 0.0)
    }

    /**
     * 图片banner
     */
    @Builder
    func listSlideBlockComponent(slideBlockNodeView: NodeView) {
        MarkdownImageBannerComponent(slideBlockNodeView: slideBlockNodeView, markdownConfiguration: markdownConfiguration, marginTop: 0.0, marginBottom: 0.0)
    }

    /**
     * 组合代码
     */
    @Builder
    func listCodeBlockListComponent(nodeView:NodeView, strInfos: ArrayList<String>, strText: ArrayList<String>, strInfoText: ArrayList<String>) {
        MarkdownCodeBlockListComponent(nodeView: nodeView, strInfos: strInfos, strText: strText, markdownConfiguration: markdownConfiguration, strInfoText: strInfoText, marginTop: 0.0, marginBottom: 0.0)
    }

    /**
     * 单行的数学公式
     */
    @Builder
    func listLatexMathBlockComponent(latexStr: String) {
        MarkdownLatexMathBlockComponent(latexStr: latexStr, markdownConfiguration: markdownConfiguration, marginTop: 0.0, marginBottom: 0.0)
    }

    @Builder
    func listEndComponent() {
        // 12层
        Column() {
            // TODO: 列表嵌套层级最多12层
        }
    }

    @Builder
    func bulletListComponent12(bulletListNodeView: NodeView) {
        ForEach(
            bulletListNodeView.children,
            itemGeneratorFunc: {
                bulletListItemComponent: NodeView, idx: Int64 => Row() {
                    if (bulletListItemComponent.node is TaskListItem) {
                        // 任务列表
                        listPrefixCheckbox(bulletListItemComponent)
                    } else if (bulletListItemComponent.node is CommonmarkListItem) {
                        // 普通无序列表
                        listPrefixText(bulletListItemComponent, false)
                    }
                    Column() {
                        ForEach(
                            bulletListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    listEndComponent()
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    listEndComponent()
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    listEndComponent()
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func orderedListComponent12(orderedListNodeView: NodeView) {
        ForEach(
            orderedListNodeView.children,
            itemGeneratorFunc: {
                orderedListItemComponent: NodeView, idx: Int64 => Row() {
                    if (orderedListItemComponent.node is CommonmarkListItem) {
                        // 普通有序列表
                        listPrefixText(orderedListItemComponent, true)
                    }
                    Column() {
                        ForEach(
                            orderedListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    listEndComponent()
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    listEndComponent()
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    listEndComponent()
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func blockQuoteComponent12(blockQuoteNodeView: NodeView) {
        Column() {
            ForEach(
                blockQuoteNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraphComponent(item)
                    } else if (item.node is Heading) {
                        // 标题
                        listHeadingComponent(item)
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None)
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo())
                    } else if (item.node is BulletList) {
                        // 无序列表
                        listEndComponent()
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        listEndComponent()
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        listEndComponent()
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockComponent(item)
                    } else if (item.node is SlideBlock) {
                        // 图片banner
                        listSlideBlockComponent(item)
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 代码列表
                        listCodeBlockListComponent(
                            item,
                            toCodeList(item)[0],
                            toCodeList(item)[1],
                            toCodeList(item)[2])
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
        // 设置子组件在水平方向上的对齐格式。
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式。
        .justifyContent(FlexAlign.Start)
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: Length(markdownConfiguration.markdownTheme.blockQuoteWidth)))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
    }

    @Builder
    func bulletListComponent11(bulletListNodeView: NodeView) {
        ForEach(
            bulletListNodeView.children,
            itemGeneratorFunc: {
                bulletListItemComponent: NodeView, idx: Int64 => Row() {
                    if (bulletListItemComponent.node is TaskListItem) {
                        // 任务列表
                        listPrefixCheckbox(bulletListItemComponent)
                    } else if (bulletListItemComponent.node is CommonmarkListItem) {
                        // 普通无序列表
                        listPrefixText(bulletListItemComponent, false)
                    }
                    Column() {
                        ForEach(
                            bulletListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent12(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent12(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent12(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func orderedListComponent11(orderedListNodeView: NodeView) {
        ForEach(
            orderedListNodeView.children,
            itemGeneratorFunc: {
                orderedListItemComponent: NodeView, idx: Int64 => Row() {
                    if (orderedListItemComponent.node is CommonmarkListItem) {
                        // 普通有序列表
                        listPrefixText(orderedListItemComponent, true)
                    }
                    Column() {
                        ForEach(
                            orderedListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent12(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent12(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent12(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func blockQuoteComponent11(blockQuoteNodeView: NodeView) {
        Column() {
            ForEach(
                blockQuoteNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraphComponent(item)
                    } else if (item.node is Heading) {
                        // 标题
                        listHeadingComponent(item)
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None)
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo())
                    } else if (item.node is BulletList) {
                        // 无序列表
                        bulletListComponent12(item)
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        orderedListComponent12(item)
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        blockQuoteComponent12(item)
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockComponent(item)
                    } else if (item.node is SlideBlock) {
                        // 图片banner
                        listSlideBlockComponent(item)
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 代码列表
                        listCodeBlockListComponent(
                            item,
                            toCodeList(item)[0],
                            toCodeList(item)[1],
                            toCodeList(item)[2])
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
        // 设置子组件在水平方向上的对齐格式。
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式。
        .justifyContent(FlexAlign.Start)
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: Length(markdownConfiguration.markdownTheme.blockQuoteWidth)))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
    }

    @Builder
    func bulletListComponent10(bulletListNodeView: NodeView) {
        ForEach(
            bulletListNodeView.children,
            itemGeneratorFunc: {
                bulletListItemComponent: NodeView, idx: Int64 => Row() {
                    if (bulletListItemComponent.node is TaskListItem) {
                        // 任务列表
                        listPrefixCheckbox(bulletListItemComponent)
                    } else if (bulletListItemComponent.node is CommonmarkListItem) {
                        // 普通无序列表
                        listPrefixText(bulletListItemComponent, false)
                    }
                    Column() {
                        ForEach(
                            bulletListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent11(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent11(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent11(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func orderedListComponent10(orderedListNodeView: NodeView) {
        ForEach(
            orderedListNodeView.children,
            itemGeneratorFunc: {
                orderedListItemComponent: NodeView, idx: Int64 => Row() {
                    if (orderedListItemComponent.node is CommonmarkListItem) {
                        // 普通有序列表
                        listPrefixText(orderedListItemComponent, true)
                    }
                    Column() {
                        ForEach(
                            orderedListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent11(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent11(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent11(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func blockQuoteComponent10(blockQuoteNodeView: NodeView) {
        Column() {
            ForEach(
                blockQuoteNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraphComponent(item)
                    } else if (item.node is Heading) {
                        // 标题
                        listHeadingComponent(item)
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None)
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo())
                    } else if (item.node is BulletList) {
                        // 无序列表
                        bulletListComponent11(item)
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        orderedListComponent11(item)
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        blockQuoteComponent11(item)
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockComponent(item)
                    } else if (item.node is SlideBlock) {
                        // 图片banner
                        listSlideBlockComponent(item)
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 代码列表
                        listCodeBlockListComponent(
                            item,
                            toCodeList(item)[0],
                            toCodeList(item)[1],
                            toCodeList(item)[2])
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
        // 设置子组件在水平方向上的对齐格式。
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式。
        .justifyContent(FlexAlign.Start)
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: Length(markdownConfiguration.markdownTheme.blockQuoteWidth)))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
    }

    @Builder
    func bulletListComponent9(bulletListNodeView: NodeView) {
        ForEach(
            bulletListNodeView.children,
            itemGeneratorFunc: {
                bulletListItemComponent: NodeView, idx: Int64 => Row() {
                    if (bulletListItemComponent.node is TaskListItem) {
                        // 任务列表
                        listPrefixCheckbox(bulletListItemComponent)
                    } else if (bulletListItemComponent.node is CommonmarkListItem) {
                        // 普通无序列表
                        listPrefixText(bulletListItemComponent, false)
                    }
                    Column() {
                        ForEach(
                            bulletListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent10(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent10(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent10(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func orderedListComponent9(orderedListNodeView: NodeView) {
        ForEach(
            orderedListNodeView.children,
            itemGeneratorFunc: {
                orderedListItemComponent: NodeView, idx: Int64 => Row() {
                    if (orderedListItemComponent.node is CommonmarkListItem) {
                        // 普通有序列表
                        listPrefixText(orderedListItemComponent, true)
                    }
                    Column() {
                        ForEach(
                            orderedListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent10(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent10(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent10(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func blockQuoteComponent9(blockQuoteNodeView: NodeView) {
        Column() {
            ForEach(
                blockQuoteNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraphComponent(item)
                    } else if (item.node is Heading) {
                        // 标题
                        listHeadingComponent(item)
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None)
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo())
                    } else if (item.node is BulletList) {
                        // 无序列表
                        bulletListComponent10(item)
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        orderedListComponent10(item)
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        blockQuoteComponent10(item)
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockComponent(item)
                    } else if (item.node is SlideBlock) {
                        // 图片banner
                        listSlideBlockComponent(item)
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 代码列表
                        listCodeBlockListComponent(
                            item,
                            toCodeList(item)[0],
                            toCodeList(item)[1],
                            toCodeList(item)[2])
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
        // 设置子组件在水平方向上的对齐格式。
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式。
        .justifyContent(FlexAlign.Start)
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: Length(markdownConfiguration.markdownTheme.blockQuoteWidth)))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
    }

    @Builder
    func bulletListComponent8(bulletListNodeView: NodeView) {
        ForEach(
            bulletListNodeView.children,
            itemGeneratorFunc: {
                bulletListItemComponent: NodeView, idx: Int64 => Row() {
                    if (bulletListItemComponent.node is TaskListItem) {
                        // 任务列表
                        listPrefixCheckbox(bulletListItemComponent)
                    } else if (bulletListItemComponent.node is CommonmarkListItem) {
                        // 普通无序列表
                        listPrefixText(bulletListItemComponent, false)
                    }
                    Column() {
                        ForEach(
                            bulletListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent9(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent9(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent9(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func orderedListComponent8(orderedListNodeView: NodeView) {
        ForEach(
            orderedListNodeView.children,
            itemGeneratorFunc: {
                orderedListItemComponent: NodeView, idx: Int64 => Row() {
                    if (orderedListItemComponent.node is CommonmarkListItem) {
                        // 普通有序列表
                        listPrefixText(orderedListItemComponent, true)
                    }
                    Column() {
                        ForEach(
                            orderedListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent9(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent9(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent9(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func blockQuoteComponent8(blockQuoteNodeView: NodeView) {
        Column() {
            ForEach(
                blockQuoteNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraphComponent(item)
                    } else if (item.node is Heading) {
                        // 标题
                        listHeadingComponent(item)
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None)
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo())
                    } else if (item.node is BulletList) {
                        // 无序列表
                        bulletListComponent9(item)
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        orderedListComponent9(item)
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        blockQuoteComponent9(item)
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockComponent(item)
                    } else if (item.node is SlideBlock) {
                        // 图片banner
                        listSlideBlockComponent(item)
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 代码列表
                        listCodeBlockListComponent(
                            item,
                            toCodeList(item)[0],
                            toCodeList(item)[1],
                            toCodeList(item)[2])
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
        // 设置子组件在水平方向上的对齐格式。
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式。
        .justifyContent(FlexAlign.Start)
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: Length(markdownConfiguration.markdownTheme.blockQuoteWidth)))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
    }

    @Builder
    func bulletListComponent7(bulletListNodeView: NodeView) {
        ForEach(
            bulletListNodeView.children,
            itemGeneratorFunc: {
                bulletListItemComponent: NodeView, idx: Int64 => Row() {
                    if (bulletListItemComponent.node is TaskListItem) {
                        // 任务列表
                        listPrefixCheckbox(bulletListItemComponent)
                    } else if (bulletListItemComponent.node is CommonmarkListItem) {
                        // 普通无序列表
                        listPrefixText(bulletListItemComponent, false)
                    }
                    Column() {
                        ForEach(
                            bulletListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent8(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent8(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent8(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func orderedListComponent7(orderedListNodeView: NodeView) {
        ForEach(
            orderedListNodeView.children,
            itemGeneratorFunc: {
                orderedListItemComponent: NodeView, idx: Int64 => Row() {
                    if (orderedListItemComponent.node is CommonmarkListItem) {
                        // 普通有序列表
                        listPrefixText(orderedListItemComponent, true)
                    }
                    Column() {
                        ForEach(
                            orderedListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent8(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent8(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent8(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func blockQuoteComponent7(blockQuoteNodeView: NodeView) {
        Column() {
            ForEach(
                blockQuoteNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraphComponent(item)
                    } else if (item.node is Heading) {
                        // 标题
                        listHeadingComponent(item)
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None)
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo())
                    } else if (item.node is BulletList) {
                        // 无序列表
                        bulletListComponent8(item)
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        orderedListComponent8(item)
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        blockQuoteComponent8(item)
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockComponent(item)
                    } else if (item.node is SlideBlock) {
                        // 图片banner
                        listSlideBlockComponent(item)
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 代码列表
                        listCodeBlockListComponent(
                            item,
                            toCodeList(item)[0],
                            toCodeList(item)[1],
                            toCodeList(item)[2])
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
        // 设置子组件在水平方向上的对齐格式。
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式。
        .justifyContent(FlexAlign.Start)
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: Length(markdownConfiguration.markdownTheme.blockQuoteWidth)))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
    }

    @Builder
    func bulletListComponent6(bulletListNodeView: NodeView) {
        ForEach(
            bulletListNodeView.children,
            itemGeneratorFunc: {
                bulletListItemComponent: NodeView, idx: Int64 => Row() {
                    if (bulletListItemComponent.node is TaskListItem) {
                        // 任务列表
                        listPrefixCheckbox(bulletListItemComponent)
                    } else if (bulletListItemComponent.node is CommonmarkListItem) {
                        // 普通无序列表
                        listPrefixText(bulletListItemComponent, false)
                    }
                    Column() {
                        ForEach(
                            bulletListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent7(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent7(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent7(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func orderedListComponent6(orderedListNodeView: NodeView) {
        ForEach(
            orderedListNodeView.children,
            itemGeneratorFunc: {
                orderedListItemComponent: NodeView, idx: Int64 => Row() {
                    if (orderedListItemComponent.node is CommonmarkListItem) {
                        // 普通有序列表
                        listPrefixText(orderedListItemComponent, true)
                    }
                    Column() {
                        ForEach(
                            orderedListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent7(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent7(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent7(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func blockQuoteComponent6(blockQuoteNodeView: NodeView) {
        Column() {
            ForEach(
                blockQuoteNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraphComponent(item)
                    } else if (item.node is Heading) {
                        // 标题
                        listHeadingComponent(item)
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None)
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo())
                    } else if (item.node is BulletList) {
                        // 无序列表
                        bulletListComponent7(item)
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        orderedListComponent7(item)
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        blockQuoteComponent7(item)
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockComponent(item)
                    } else if (item.node is SlideBlock) {
                        // 图片banner
                        listSlideBlockComponent(item)
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 代码列表
                        listCodeBlockListComponent(
                            item,
                            toCodeList(item)[0],
                            toCodeList(item)[1],
                            toCodeList(item)[2])
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
        // 设置子组件在水平方向上的对齐格式。
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式。
        .justifyContent(FlexAlign.Start)
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: Length(markdownConfiguration.markdownTheme.blockQuoteWidth)))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
    }

    @Builder
    func bulletListComponent5(bulletListNodeView: NodeView) {
        ForEach(
            bulletListNodeView.children,
            itemGeneratorFunc: {
                bulletListItemComponent: NodeView, idx: Int64 => Row() {
                    if (bulletListItemComponent.node is TaskListItem) {
                        // 任务列表
                        listPrefixCheckbox(bulletListItemComponent)
                    } else if (bulletListItemComponent.node is CommonmarkListItem) {
                        // 普通无序列表
                        listPrefixText(bulletListItemComponent, false)
                    }
                    Column() {
                        ForEach(
                            bulletListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent6(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent6(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent6(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func orderedListComponent5(orderedListNodeView: NodeView) {
        ForEach(
            orderedListNodeView.children,
            itemGeneratorFunc: {
                orderedListItemComponent: NodeView, idx: Int64 => Row() {
                    if (orderedListItemComponent.node is CommonmarkListItem) {
                        // 普通有序列表
                        listPrefixText(orderedListItemComponent, true)
                    }
                    Column() {
                        ForEach(
                            orderedListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent6(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent6(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent6(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func blockQuoteComponent5(blockQuoteNodeView: NodeView) {
        Column() {
            ForEach(
                blockQuoteNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraphComponent(item)
                    } else if (item.node is Heading) {
                        // 标题
                        listHeadingComponent(item)
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None)
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo())
                    } else if (item.node is BulletList) {
                        // 无序列表
                        bulletListComponent6(item)
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        orderedListComponent6(item)
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        blockQuoteComponent6(item)
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockComponent(item)
                    } else if (item.node is SlideBlock) {
                        // 图片banner
                        listSlideBlockComponent(item)
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 代码列表
                        listCodeBlockListComponent(
                            item,
                            toCodeList(item)[0],
                            toCodeList(item)[1],
                            toCodeList(item)[2])
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
        // 设置子组件在水平方向上的对齐格式。
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式。
        .justifyContent(FlexAlign.Start)
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: Length(markdownConfiguration.markdownTheme.blockQuoteWidth)))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
    }

    @Builder
    func bulletListComponent4(bulletListNodeView: NodeView) {
        ForEach(
            bulletListNodeView.children,
            itemGeneratorFunc: {
                bulletListItemComponent: NodeView, idx: Int64 => Row() {
                    if (bulletListItemComponent.node is TaskListItem) {
                        // 任务列表
                        listPrefixCheckbox(bulletListItemComponent)
                    } else if (bulletListItemComponent.node is CommonmarkListItem) {
                        // 普通无序列表
                        listPrefixText(bulletListItemComponent, false)
                    }
                    Column() {
                        ForEach(
                            bulletListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent5(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent5(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent5(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func orderedListComponent4(orderedListNodeView: NodeView) {
        ForEach(
            orderedListNodeView.children,
            itemGeneratorFunc: {
                orderedListItemComponent: NodeView, idx: Int64 => Row() {
                    if (orderedListItemComponent.node is CommonmarkListItem) {
                        // 普通有序列表
                        listPrefixText(orderedListItemComponent, true)
                    }
                    Column() {
                        ForEach(
                            orderedListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent5(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent5(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent5(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func blockQuoteComponent4(blockQuoteNodeView: NodeView) {
        Column() {
            ForEach(
                blockQuoteNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraphComponent(item)
                    } else if (item.node is Heading) {
                        // 标题
                        listHeadingComponent(item)
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None)
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo())
                    } else if (item.node is BulletList) {
                        // 无序列表
                        bulletListComponent5(item)
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        orderedListComponent5(item)
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        blockQuoteComponent5(item)
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockComponent(item)
                    } else if (item.node is SlideBlock) {
                        // 图片banner
                        listSlideBlockComponent(item)
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 代码列表
                        listCodeBlockListComponent(
                            item,
                            toCodeList(item)[0],
                            toCodeList(item)[1],
                            toCodeList(item)[2])
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
        // 设置子组件在水平方向上的对齐格式。
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式。
        .justifyContent(FlexAlign.Start)
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: Length(markdownConfiguration.markdownTheme.blockQuoteWidth)))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
    }

    @Builder
    func bulletListComponent3(bulletListNodeView: NodeView) {
        ForEach(
            bulletListNodeView.children,
            itemGeneratorFunc: {
                bulletListItemComponent: NodeView, idx: Int64 => Row() {
                    if (bulletListItemComponent.node is TaskListItem) {
                        // 任务列表
                        listPrefixCheckbox(bulletListItemComponent)
                    } else if (bulletListItemComponent.node is CommonmarkListItem) {
                        // 普通无序列表
                        listPrefixText(bulletListItemComponent, false)
                    }
                    Column() {
                        ForEach(
                            bulletListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent4(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent4(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent4(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func orderedListComponent3(orderedListNodeView: NodeView) {
        ForEach(
            orderedListNodeView.children,
            itemGeneratorFunc: {
                orderedListItemComponent: NodeView, idx: Int64 => Row() {
                    if (orderedListItemComponent.node is CommonmarkListItem) {
                        // 普通有序列表
                        listPrefixText(orderedListItemComponent, true)
                    }
                    Column() {
                        ForEach(
                            orderedListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent4(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent4(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent4(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func blockQuoteComponent3(blockQuoteNodeView: NodeView) {
        Column() {
            ForEach(
                blockQuoteNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraphComponent(item)
                    } else if (item.node is Heading) {
                        // 标题
                        listHeadingComponent(item)
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None)
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo())
                    } else if (item.node is BulletList) {
                        // 无序列表
                        bulletListComponent4(item)
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        orderedListComponent4(item)
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        blockQuoteComponent4(item)
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockComponent(item)
                    } else if (item.node is SlideBlock) {
                        // 图片banner
                        listSlideBlockComponent(item)
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 代码列表
                        listCodeBlockListComponent(
                            item,
                            toCodeList(item)[0],
                            toCodeList(item)[1],
                            toCodeList(item)[2])
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
        // 设置子组件在水平方向上的对齐格式。
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式。
        .justifyContent(FlexAlign.Start)
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: Length(markdownConfiguration.markdownTheme.blockQuoteWidth)))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
    }

    @Builder
    func bulletListComponent2(bulletListNodeView: NodeView) {
        ForEach(
            bulletListNodeView.children,
            itemGeneratorFunc: {
                bulletListItemComponent: NodeView, idx: Int64 => Row() {
                    if (bulletListItemComponent.node is TaskListItem) {
                        // 任务列表
                        listPrefixCheckbox(bulletListItemComponent)
                    } else if (bulletListItemComponent.node is CommonmarkListItem) {
                        // 普通无序列表
                        listPrefixText(bulletListItemComponent, false)
                    }
                    Column() {
                        ForEach(
                            bulletListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent3(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent3(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent3(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func orderedListComponent2(orderedListNodeView: NodeView) {
        ForEach(
            orderedListNodeView.children,
            itemGeneratorFunc: {
                orderedListItemComponent: NodeView, idx: Int64 => Row() {
                    if (orderedListItemComponent.node is CommonmarkListItem) {
                        // 普通有序列表
                        listPrefixText(orderedListItemComponent, true)
                    }
                    Column() {
                        ForEach(
                            orderedListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent3(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent3(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent3(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func blockQuoteComponent2(blockQuoteNodeView: NodeView) {
        Column() {
            ForEach(
                blockQuoteNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraphComponent(item)
                    } else if (item.node is Heading) {
                        // 标题
                        listHeadingComponent(item)
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None)
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo())
                    } else if (item.node is BulletList) {
                        // 无序列表
                        bulletListComponent3(item)
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        orderedListComponent3(item)
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        blockQuoteComponent3(item)
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockComponent(item)
                    } else if (item.node is SlideBlock) {
                        // 图片banner
                        listSlideBlockComponent(item)
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 代码列表
                        listCodeBlockListComponent(
                            item,
                            toCodeList(item)[0],
                            toCodeList(item)[1],
                            toCodeList(item)[2])
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
        // 设置子组件在水平方向上的对齐格式。
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式。
        .justifyContent(FlexAlign.Start)
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: Length(markdownConfiguration.markdownTheme.blockQuoteWidth)))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
    }

    @Builder
    func bulletListComponent1(bulletListNodeView: NodeView) {
        ForEach(
            bulletListNodeView.children,
            itemGeneratorFunc: {
                bulletListItemComponent: NodeView, idx: Int64 => Row() {
                    if (bulletListItemComponent.node is TaskListItem) {
                        // 任务列表
                        listPrefixCheckbox(bulletListItemComponent)
                    } else if (bulletListItemComponent.node is CommonmarkListItem) {
                        // 普通无序列表
                        listPrefixText(bulletListItemComponent, false)
                    }
                    Column() {
                        ForEach(
                            bulletListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent2(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent2(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent2(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func orderedListComponent1(orderedListNodeView: NodeView) {
        ForEach(
            orderedListNodeView.children,
            itemGeneratorFunc: {
                orderedListItemComponent: NodeView, idx: Int64 => Row() {
                    if (orderedListItemComponent.node is CommonmarkListItem) {
                        // 普通有序列表
                        listPrefixText(orderedListItemComponent, true)
                    }
                    Column() {
                        ForEach(
                            orderedListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent2(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent2(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent2(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func blockQuoteComponent1(blockQuoteNodeView: NodeView) {
        Column() {
            ForEach(
                blockQuoteNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraphComponent(item)
                    } else if (item.node is Heading) {
                        // 标题
                        listHeadingComponent(item)
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None)
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockComponent(
                            (item.node as FencedCodeBlock)().getLiteral(),
                            (item.node as FencedCodeBlock)().getInfo())
                    } else if (item.node is BulletList) {
                        // 无序列表
                        bulletListComponent2(item)
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        orderedListComponent2(item)
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        blockQuoteComponent2(item)
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockComponent(item)
                    } else if (item.node is SlideBlock) {
                        // 图片banner
                        listSlideBlockComponent(item)
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 代码列表
                        listCodeBlockListComponent(
                            item,
                            toCodeList(item)[0],
                            toCodeList(item)[1],
                            toCodeList(item)[2])
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
        // 设置子组件在水平方向上的对齐格式。
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式。
        .justifyContent(FlexAlign.Start)
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: Length(markdownConfiguration.markdownTheme.blockQuoteWidth)))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
    }

    @Builder
    func bulletListComponent(bulletListNodeView: NodeView) {
        ForEach(
            bulletListNodeView.children,
            itemGeneratorFunc: {
                bulletListItemComponent: NodeView, idx: Int64 => Row() {
                    if (bulletListItemComponent.node is TaskListItem) {
                        // 任务列表
                        listPrefixCheckbox(bulletListItemComponent)
                    } else if (bulletListItemComponent.node is CommonmarkListItem) {
                        // 普通无序列表
                        listPrefixText(bulletListItemComponent, false)
                    }
                    Column() {
                        ForEach(
                            bulletListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent1(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent1(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent1(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func orderedListComponent(orderedListNodeView: NodeView) {
        ForEach(
            orderedListNodeView.children,
            itemGeneratorFunc: {
                orderedListItemComponent: NodeView, idx: Int64 => Row() {
                    if (orderedListItemComponent.node is CommonmarkListItem) {
                        // 普通有序列表
                        listPrefixText(orderedListItemComponent, true)
                    }
                    Column() {
                        ForEach(
                            orderedListItemComponent.children,
                            itemGeneratorFunc: {
                                item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                    // 段落
                                    listParagraphComponent(item)
                                } else if (item.node is Heading) {
                                    // 标题
                                    listHeadingComponent(item)
                                } else if (item.node is IndentedCodeBlock) {
                                    // 缩进代码
                                    listCodeBlockComponent(
                                        (item.node as IndentedCodeBlock)().getLiteral(),
                                        Option<String>.None)
                                } else if (item.node is FencedCodeBlock) {
                                    // 围栏代码
                                    listCodeBlockComponent(
                                        (item.node as FencedCodeBlock)().getLiteral(),
                                        (item.node as FencedCodeBlock)().getInfo())
                                } else if (item.node is BulletList) {
                                    // 无序列表
                                    bulletListComponent1(item)
                                } else if (item.node is OrderedList) {
                                    // 有序列表
                                    orderedListComponent1(item)
                                } else if (item.node is BlockQuote) {
                                    // 块引用
                                    blockQuoteComponent1(item)
                                } else if (item.node is TableBlock) {
                                    // 表格
                                    listTableBlockComponent(item)
                                } else if (item.node is SlideBlock) {
                                    // 图片banner
                                    listSlideBlockComponent(item)
                                } else if (item.node is FencedCodeBlockListBlock) {
                                    // 代码列表
                                    listCodeBlockListComponent(
                                        item,
                                        toCodeList(item)[0],
                                        toCodeList(item)[1],
                                        toCodeList(item)[2])
                                } else if (item.node is LatexMathBlock) {
                                    // 数学公式 - 单行
                                    listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                                } else {
                                    // TODO 其他节点
                                }
                            }
                        )
                    }
                    // 设置子组件在水平方向上的对齐格式。
                    .alignItems(HorizontalAlign.Start)
                    // 设置子组件在垂直方向上的对齐格式。
                    .justifyContent(FlexAlign.Start)
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
                // 在垂直方向上子组件的对齐格式。
                .alignItems(VerticalAlign.Top)
                // 设置子组件在水平方向上的对齐格式。
                .justifyContent(FlexAlign.Start)
            }
        )
    }

    @Builder
    func blockQuoteComponent(blockQuoteNodeView: NodeView) {
        Column() {
            ForEach(
                blockQuoteNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        listParagraphComponent(item)
                    } else if (item.node is Heading) {
                        // 标题
                        listHeadingComponent(item)
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码
                        listCodeBlockComponent(
                            (item.node as IndentedCodeBlock)().getLiteral(),
                            Option<String>.None)
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码
                        listCodeBlockComponent(
                            (item.node as FencedCodeBlock)().getLiteral(), 
                            (item.node as FencedCodeBlock)().getInfo())
                    } else if (item.node is BulletList) {
                        // 无序列表
                        bulletListComponent1(item)
                    } else if (item.node is OrderedList) {
                        // 有序列表
                        orderedListComponent1(item)
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        blockQuoteComponent1(item)
                    } else if (item.node is TableBlock) {
                        // 表格
                        listTableBlockComponent(item)
                    } else if (item.node is SlideBlock) {
                        // 图片banner
                        listSlideBlockComponent(item)
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 代码列表
                        listCodeBlockListComponent(
                            item,
                            toCodeList(item)[0],
                            toCodeList(item)[1],
                            toCodeList(item)[2])
                    } else if (item.node is LatexMathBlock) {
                        // 数学公式 - 单行
                        listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
                    } else {
                        // TODO 其他节点
                    }
                }
            )
        }
        // 设置子组件在水平方向上的对齐格式。
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式。
        .justifyContent(FlexAlign.Start)
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: Length(markdownConfiguration.markdownTheme.blockQuoteWidth)))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
    }
}
