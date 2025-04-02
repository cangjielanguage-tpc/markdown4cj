/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
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
public class MarkdownAIListComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

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
     * 控件宽度 - 单位px
     */
    var componentWidth: Float64

    var isFull: Bool

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * 懒加载数据源
     */
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    var isFrist: Bool = true

    protected override func aboutToAppear(): Unit {
        listNumberData()
    }

    func build() {
        if (listNodeView.node is BulletList) {
            // 无序列表
            bulletListComponent()
        } else if (listNodeView.node is OrderedList) {
            // 有序列表
            orderedListComponent()
        } else if (listNodeView.node is BlockQuote) {
            // 块引用
            blockQuoteComponent()
        } else {
            // 其他节点
        }
    }

    @Builder
    func bulletListComponent() {
        List() {
            LazyForEach(
                nodeViewAIDataSource,
                itemGeneratorFunc: {
                    bulletListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
                            if (bulletListItemComponent.node is TaskListItem) {
                                // 任务列表
                                listPrefixCheckboxINCComponent(bulletListItemComponent, markdownAIConfiguration)
                            } else if (bulletListItemComponent.node is CommonmarkListItem) {
                                // 普通无序列表
                                listPrefixTextINCComponent(bulletListItemComponent, false, markdownAIConfiguration)
                            }
                            Column() {
                                ForEach(
                                    bulletListItemComponent.children,
                                    itemGeneratorFunc: {
                                        item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                            // 段落
                                            MarkdownAIParagraphComponent(
                                                markdownAIConfiguration: markdownAIConfiguration,
                                                nodeViews: item.children,
                                                marginTop: 0.0,
                                                marginBottom: 0.0,
                                                fontCallback: fontCallback,
                                                componentWidth: componentWidth
                                            )
                                        } else if (item.node is Heading) {
                                            // 标题
                                            MarkdownAIHeadingComponent(
                                                markdownAIConfiguration: markdownAIConfiguration,
                                                nodeViews: item.children,
                                                level : (item.node as Heading)().getLevel(),
                                                marginTop: 0.0,
                                                marginBottom: 0.0,
                                                fontCallback: fontCallback,
                                                componentWidth: componentWidth
                                            )
                                        } else if (item.node is IndentedCodeBlock) {
                                            // 缩进代码
                                            if (isFull) {
                                                MarkdownAIFencedCodeBlockComponent(
                                                    markdownAIConfiguration: markdownAIConfiguration,
                                                    codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                                    info: Option<String>.None,
                                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
                                                )
                                            } else {
                                                MarkdownAIIndentedCodeBlockComponent(
                                                    markdownAIConfiguration: markdownAIConfiguration,
                                                    codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                                    info: Option<String>.None,
                                                    codeItem: item,
                                                    marginTop: 0.0,
                                                    marginBottom: 0.0
                                                )
                                            }
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            if (isFull) {
                                                MarkdownAIFencedCodeBlockComponent(
                                                    markdownAIConfiguration: markdownAIConfiguration,
                                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
                                                )
                                            } else {
                                                MarkdownAIIndentedCodeBlockComponent(
                                                    markdownAIConfiguration: markdownAIConfiguration,
                                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                                    codeItem: item,
                                                    marginTop: 0.0,
                                                    marginBottom: 0.0
                                                )
                                            }
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            MarkdownAIListComponent(
                                                listNodeView: item,
                                                markdownAIConfiguration: markdownAIConfiguration,
                                                marginTop: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                                marginBottom: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                                fontCallback: fontCallback,
                                                componentWidth: componentWidth,
                                                isFull: isFull
                                            )
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            MarkdownAIListComponent(
                                                listNodeView: item,
                                                markdownAIConfiguration: markdownAIConfiguration,
                                                marginTop: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                                marginBottom: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                                fontCallback: fontCallback,
                                                componentWidth: componentWidth,
                                                isFull: isFull
                                            )
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            MarkdownAIListComponent(
                                                listNodeView: item,
                                                markdownAIConfiguration: markdownAIConfiguration,
                                                marginTop: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                                marginBottom: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                                fontCallback: fontCallback,
                                                componentWidth: componentWidth,
                                                isFull: isFull
                                            )
                                        } else if (item.node is TableBlock) {
                                            // 表格
                                            MarkdownAITableBlockComponent(
                                                tableNodeView: item,
                                                markdownAIConfiguration: markdownAIConfiguration,
                                                marginTop: 0.0,
                                                marginBottom: 0.0,
                                                fontCallback: fontCallback,
                                                componentWidth: componentWidth,
                                                isFull: isFull
                                            )
                                        } else if (item.node is LatexMathBlock) {
                                            // 数学公式 - 单行
                                            if ((item.node as LatexMathBlock)().isClosed) {
                                                // 结束显示数学公式
                                                MarkdownAILatexMathBlockComponent(
                                                    markdownAIConfiguration: markdownAIConfiguration,
                                                    latexStr: (item.node as LatexMathBlock)().latex,
                                                    marginTop: 0.0,
                                                    marginBottom: 0.0
                                                )
                                            } else {
                                                // 没结束显示纯文本
                                                Text((item.node as LatexMathBlock)().latex)
                                            }
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
        }
        // 块内容前的起始边距
        .margin(top: marginTop, bottom: marginBottom)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func orderedListComponent() {
        List() {
            LazyForEach(
                nodeViewAIDataSource,
                itemGeneratorFunc: {
                    orderedListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
                            if (orderedListItemComponent.node is CommonmarkListItem) {
                                // 普通有序列表
                                listPrefixTextINCComponent(orderedListItemComponent, true, markdownAIConfiguration)
                            }
                            Column() {
                                ForEach(
                                    orderedListItemComponent.children,
                                    itemGeneratorFunc: {
                                        item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                                            // 段落
                                            MarkdownAIParagraphComponent(
                                                markdownAIConfiguration: markdownAIConfiguration,
                                                nodeViews: item.children,
                                                marginTop: 0.0,
                                                marginBottom: 0.0,
                                                fontCallback: fontCallback,
                                                componentWidth: componentWidth
                                            )
                                        } else if (item.node is Heading) {
                                            // 标题
                                            MarkdownAIHeadingComponent(
                                                markdownAIConfiguration: markdownAIConfiguration,
                                                nodeViews: item.children,
                                                level : (item.node as Heading)().getLevel(),
                                                marginTop: 0.0,
                                                marginBottom: 0.0,
                                                fontCallback: fontCallback,
                                                componentWidth: componentWidth
                                            )
                                        } else if (item.node is IndentedCodeBlock) {
                                            // 缩进代码
                                            if (isFull) {
                                                MarkdownAIFencedCodeBlockComponent(
                                                    markdownAIConfiguration: markdownAIConfiguration,
                                                    codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                                    info: Option<String>.None,
                                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
                                                )
                                            } else {
                                                MarkdownAIIndentedCodeBlockComponent(
                                                    markdownAIConfiguration: markdownAIConfiguration,
                                                    codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                                    info: Option<String>.None,
                                                    codeItem: item,
                                                    marginTop: 0.0,
                                                    marginBottom: 0.0
                                                )
                                            }
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            if (isFull) {
                                                MarkdownAIFencedCodeBlockComponent(
                                                    markdownAIConfiguration: markdownAIConfiguration,
                                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                                    marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                                    marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
                                                )
                                            } else {
                                                MarkdownAIIndentedCodeBlockComponent(
                                                    markdownAIConfiguration: markdownAIConfiguration,
                                                    codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                                    info: (item.node as FencedCodeBlock)().getInfo(),
                                                    codeItem: item,
                                                    marginTop: 0.0,
                                                    marginBottom: 0.0
                                                )
                                            }
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            MarkdownAIListComponent(
                                                listNodeView: item,
                                                markdownAIConfiguration: markdownAIConfiguration,
                                                marginTop: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                                marginBottom: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                                fontCallback: fontCallback,
                                                componentWidth: componentWidth,
                                                isFull: isFull
                                            )
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            MarkdownAIListComponent(
                                                listNodeView: item,
                                                markdownAIConfiguration: markdownAIConfiguration,
                                                marginTop: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                                marginBottom: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                                fontCallback: fontCallback,
                                                componentWidth: componentWidth,
                                                isFull: isFull
                                            )
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            MarkdownAIListComponent(
                                                listNodeView: item,
                                                markdownAIConfiguration: markdownAIConfiguration,
                                                marginTop: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                                marginBottom: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                                fontCallback: fontCallback,
                                                componentWidth: componentWidth,
                                                isFull: isFull
                                            )
                                        } else if (item.node is TableBlock) {
                                            // 表格
                                            MarkdownAITableBlockComponent(
                                                tableNodeView: item,
                                                markdownAIConfiguration: markdownAIConfiguration,
                                                marginTop: 0.0,
                                                marginBottom: 0.0,
                                                fontCallback: fontCallback,
                                                componentWidth: componentWidth,
                                                isFull: isFull
                                            )
                                        } else if (item.node is LatexMathBlock) {
                                            // 数学公式 - 单行
                                            if ((item.node as LatexMathBlock)().isClosed) {
                                                // 结束显示数学公式
                                                MarkdownAILatexMathBlockComponent(
                                                    markdownAIConfiguration: markdownAIConfiguration,
                                                    latexStr: (item.node as LatexMathBlock)().latex,
                                                    marginTop: 0.0,
                                                    marginBottom: 0.0
                                                )
                                            } else {
                                                // 没结束显示纯文本
                                                Text((item.node as LatexMathBlock)().latex)
                                            }
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
        }
        // 块内容前的起始边距
        .margin(top: marginTop, bottom: marginBottom)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func blockQuoteComponent() {
        List() {
            LazyForEach(
                nodeViewAIDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                MarkdownAIParagraphComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    marginTop: 0.0,
                                    marginBottom: 0.0,
                                    fontCallback: fontCallback,
                                    componentWidth: componentWidth
                                )
                            } else if (item.node is Heading) {
                                // 标题
                                MarkdownAIHeadingComponent(
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    nodeViews: item.children,
                                    level : (item.node as Heading)().getLevel(),
                                    marginTop: 0.0,
                                    marginBottom: 0.0,
                                    fontCallback: fontCallback,
                                    componentWidth: componentWidth
                                )
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                if (isFull) {
                                    MarkdownAIFencedCodeBlockComponent(
                                        markdownAIConfiguration: markdownAIConfiguration,
                                        codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                        info: Option<String>.None,
                                        marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                        marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
                                    )
                                } else {
                                    MarkdownAIIndentedCodeBlockComponent(
                                        markdownAIConfiguration: markdownAIConfiguration,
                                        codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                        info: Option<String>.None,
                                        codeItem: item,
                                        marginTop: 0.0,
                                        marginBottom: 0.0
                                    )
                                }
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                if (isFull) {
                                    MarkdownAIFencedCodeBlockComponent(
                                        markdownAIConfiguration: markdownAIConfiguration,
                                        codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                        info: (item.node as FencedCodeBlock)().getInfo(),
                                        marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                        marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins
                                    )
                                } else {
                                    MarkdownAIIndentedCodeBlockComponent(
                                        markdownAIConfiguration: markdownAIConfiguration,
                                        codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                        info: (item.node as FencedCodeBlock)().getInfo(),
                                        codeItem: item,
                                        marginTop: 0.0,
                                        marginBottom: 0.0
                                    )
                                }
                            } else if (item.node is BulletList) {
                                // 无序列表
                                MarkdownAIListComponent(
                                    listNodeView: item,
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    marginTop: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull
                                )
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                MarkdownAIListComponent(
                                    listNodeView: item,
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    marginTop: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull
                                )
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                MarkdownAIListComponent(
                                    listNodeView: item,
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    marginTop: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                    marginBottom: markdownAIConfiguration .markdownAITheme .blockTopAndBottomMargins,
                                    fontCallback: fontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull
                                )
                            } else if (item.node is TableBlock) {
                                // 表格
                                MarkdownAITableBlockComponent(
                                    tableNodeView: item,
                                    markdownAIConfiguration: markdownAIConfiguration,
                                    marginTop: 0.0,
                                    marginBottom: 0.0,
                                    fontCallback: fontCallback,
                                    componentWidth: componentWidth,
                                    isFull: isFull
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                if ((item.node as LatexMathBlock)().isClosed) {
                                    // 结束显示数学公式
                                    MarkdownAILatexMathBlockComponent(
                                        markdownAIConfiguration: markdownAIConfiguration,
                                        latexStr: (item.node as LatexMathBlock)().latex,
                                        marginTop: 0.0,
                                        marginBottom: 0.0
                                    )
                                } else {
                                    // 没结束显示纯文本
                                    Text((item.node as LatexMathBlock)().latex)
                                }
                            } else {
                                // TODO 其他节点
                            }
                        }
                        // 设置子组件在水平方向上的对齐格式。
                        .alignItems(HorizontalAlign.Start)
                        // 设置子组件在垂直方向上的对齐格式。
                        .justifyContent(FlexAlign.Start)
                        // 对子组件进行重新布局
                        .layoutWeight(1)
                    }
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
        }
        // 设置元素的边框颜色。
        .borderColor(markdownAIConfiguration.markdownAITheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownAIConfiguration.markdownAITheme.blockQuoteWidth.vp))
        // 文本内容前的起始边距
        .padding(left: 10.0, right: markdownAIConfiguration.markdownAITheme.blockMargin)
        // 块内容前的起始边距
        .margin(left: markdownAIConfiguration.markdownAITheme.blockMargin, top: marginTop, bottom: marginBottom)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    func onChanged(): Unit {
        if (!isFrist) {
            listNumberData()
        }
    }

    func listNumberData() {
        nodeViewAIDataSource.clear()
        nodeViewAIDataSource.addDatas(listNodeView.children)
    }
}
