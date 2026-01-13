/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)、块引用自定义控件
 */
@Component
public class MarkdownListComponent {
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
     * 控件宽度 - 单位px
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
        if (listNodeView.node is BulletList) {
            // 无序列表
            bulletListComponent(listNumberData(listNodeView), listNodeView)
        } else if (listNodeView.node is OrderedList) {
            // 有序列表
            orderedListComponent(listNumberData(listNodeView), listNodeView)
        } else if (listNodeView.node is BlockQuote) {
            // 块引用
            blockQuoteComponent(listNumberData(listNodeView), listNodeView)
        } else {
            // 其他节点
        }
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
            .shape(CheckBoxShape.RoundedSquare)
            // 设置外边距属性
            .margin(left: markdownConfiguration.markdownTheme.blockMargin, right: 10.0)
    }

    /**
     * 段落
     */
    @Builder
    func listParagraphComponent(nodeView: NodeView) {
        MarkdownParagraphComponent(paragraphNodeView: nodeView, markdownConfiguration: markdownConfiguration,
            marginTop: 0.0, marginBottom: 0.0, tocListOnClick: tocListOnClick, componentWidth: componentWidth)
    }

    /**
     * 标题
     */
    @Builder
    func listHeadingComponent(nodeView: NodeView) {
        MarkdownHeadingComponent(headingNodeView: nodeView, markdownConfiguration: markdownConfiguration, marginTop: 0.0,
            marginBottom: 0.0, componentWidth: componentWidth)
    }

    /**
     * 围栏代码、缩进代码
     */
    @Builder
    func listCodeBlockComponent(codeText: String, infos: ?String) {
        MarkdownCodeBlockComponent(markdownConfiguration: markdownConfiguration, codeText: codeText, info: infos,
            marginTop: 0.0, marginBottom: 0.0)
    }

    /**
     * 表格
     */
    @Builder
    func listTableBlockComponent(tableNodeView: NodeView) {
        MarkdownTableBlockComponent(tableNodeView: tableNodeView, markdownConfiguration: markdownConfiguration,
            marginTop: 0.0, marginBottom: 0.0, componentWidth: componentWidth)
    }

    /**
     * 图片banner
     */
    @Builder
    func listSlideBlockComponent(slideBlockNodeView: NodeView) {
        MarkdownImageBannerComponent(slideBlockNodeView: slideBlockNodeView,
            markdownConfiguration: markdownConfiguration, marginTop: 0.0, marginBottom: 0.0)
    }

    /**
     * 组合代码
     */
    @Builder
    func listCodeBlockListComponent(nodeView: NodeView, strInfos: ArrayList<String>, strText: ArrayList<String>,
        strInfoText: ArrayList<String>) {
        MarkdownCodeBlockListComponent(nodeView: nodeView, strInfos: strInfos, strText: strText,
            markdownConfiguration: markdownConfiguration, strInfoText: strInfoText, marginTop: 0.0, marginBottom: 0.0)
    }

    /**
     * 单行的数学公式
     */
    @Builder
    func listLatexMathBlockComponent(latexStr: String) {
        MarkdownLatexMathBlockComponent(latexStr: latexStr, markdownConfiguration: markdownConfiguration, marginTop: 0.0,
            marginBottom: 0.0)
    }

    @Builder
    func listEndComponent() {
        // 12层
        Column() {
            // TODO: 列表嵌套层级最多12层
        }
    }

    @Builder
    func listButtonComponent(nodeView: NodeView) {
        Button(markdownConfiguration.markdownTheme.buttonTextStr)
            // 高度
            .height(markdownConfiguration.markdownTheme.buttonTextHeight)
            // 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .layoutWeight(1)
            // 圆角
            .shape(ButtonType.Capsule)
            // 文本颜色
            .fontColor(markdownConfiguration.markdownTheme.buttonTextColor)
            // 背景颜色
            .backgroundColor(markdownConfiguration.markdownTheme.buttonTextBackgroupColor)
            // 外边距
            .margin(top: markdownConfiguration.markdownTheme.buttonTextMargin, bottom: markdownConfiguration.markdownTheme.buttonTextMargin)
            // 内容对齐方式
            .align(Alignment.Center)
            // 字体大小
            .fontSize(markdownConfiguration.markdownTheme.buttonTextSize)
            // 宽度
            .width(100.percent)
            // 点击动作触发该方法调用
            .onClick ({evt => listBigDataOnClick(nodeView, marginTop, marginBottom, componentWidth, markdownConfiguration.listBigDataCallback)})
    }

    @Builder
    func bulletListComponent12(dataList: (Int64, NodeViewDataSource), bulletListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    bulletListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(bulletListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func orderedListComponent12(dataList: (Int64, NodeViewDataSource), orderedListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    orderedListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(orderedListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func blockQuoteComponent12(dataList: (Int64, NodeViewDataSource), blockQuoteNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                listParagraphComponent(item)
                            } else if (item.node is Heading) {
                                // 标题
                                listHeadingComponent(item)
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                listCodeBlockComponent(
                                    (item.node as IndentedCodeBlock)().getLiteral(),
                                    Option<String>.None
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                listCodeBlockComponent(
                                    (item.node as FencedCodeBlock)().getLiteral(),
                                    (item.node as FencedCodeBlock)().getInfo()
                                )
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
                                    toCodeList(item)[2]
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
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
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(blockQuoteNodeView)
                }
            }
        }
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownConfiguration.markdownTheme.blockQuoteWidth))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func bulletListComponent11(dataList: (Int64, NodeViewDataSource), bulletListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    bulletListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent12(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent12(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent12(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(bulletListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func orderedListComponent11(dataList: (Int64, NodeViewDataSource), orderedListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    orderedListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent12(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent12(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent12(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(orderedListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func blockQuoteComponent11(dataList: (Int64, NodeViewDataSource), blockQuoteNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                listParagraphComponent(item)
                            } else if (item.node is Heading) {
                                // 标题
                                listHeadingComponent(item)
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                listCodeBlockComponent(
                                    (item.node as IndentedCodeBlock)().getLiteral(),
                                    Option<String>.None
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                listCodeBlockComponent(
                                    (item.node as FencedCodeBlock)().getLiteral(),
                                    (item.node as FencedCodeBlock)().getInfo()
                                )
                            } else if (item.node is BulletList) {
                                // 无序列表
                                bulletListComponent12(listNumberData(item), item)
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                orderedListComponent12(listNumberData(item), item)
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                blockQuoteComponent12(listNumberData(item), item)
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
                                    toCodeList(item)[2]
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
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
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(blockQuoteNodeView)
                }
            }
        }
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownConfiguration.markdownTheme.blockQuoteWidth))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func bulletListComponent10(dataList: (Int64, NodeViewDataSource), bulletListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    bulletListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent11(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent11(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent11(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(bulletListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func orderedListComponent10(dataList: (Int64, NodeViewDataSource), orderedListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    orderedListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent11(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent11(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent11(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(orderedListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func blockQuoteComponent10(dataList: (Int64, NodeViewDataSource), blockQuoteNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                listParagraphComponent(item)
                            } else if (item.node is Heading) {
                                // 标题
                                listHeadingComponent(item)
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                listCodeBlockComponent(
                                    (item.node as IndentedCodeBlock)().getLiteral(),
                                    Option<String>.None
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                listCodeBlockComponent(
                                    (item.node as FencedCodeBlock)().getLiteral(),
                                    (item.node as FencedCodeBlock)().getInfo()
                                )
                            } else if (item.node is BulletList) {
                                // 无序列表
                                bulletListComponent11(listNumberData(item), item)
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                orderedListComponent11(listNumberData(item), item)
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                blockQuoteComponent11(listNumberData(item), item)
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
                                    toCodeList(item)[2]
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
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
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(blockQuoteNodeView)
                }
            }
        }
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownConfiguration.markdownTheme.blockQuoteWidth))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func bulletListComponent9(dataList: (Int64, NodeViewDataSource), bulletListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    bulletListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent10(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent10(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent10(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(bulletListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func orderedListComponent9(dataList: (Int64, NodeViewDataSource), orderedListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    orderedListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent10(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent10(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent10(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(orderedListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func blockQuoteComponent9(dataList: (Int64, NodeViewDataSource), blockQuoteNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                listParagraphComponent(item)
                            } else if (item.node is Heading) {
                                // 标题
                                listHeadingComponent(item)
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                listCodeBlockComponent(
                                    (item.node as IndentedCodeBlock)().getLiteral(),
                                    Option<String>.None
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                listCodeBlockComponent(
                                    (item.node as FencedCodeBlock)().getLiteral(),
                                    (item.node as FencedCodeBlock)().getInfo()
                                )
                            } else if (item.node is BulletList) {
                                // 无序列表
                                bulletListComponent10(listNumberData(item), item)
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                orderedListComponent10(listNumberData(item), item)
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                blockQuoteComponent10(listNumberData(item), item)
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
                                    toCodeList(item)[2]
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
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
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(blockQuoteNodeView)
                }
            }
        }
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownConfiguration.markdownTheme.blockQuoteWidth))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func bulletListComponent8(dataList: (Int64, NodeViewDataSource), bulletListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    bulletListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent9(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent9(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent9(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(bulletListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func orderedListComponent8(dataList: (Int64, NodeViewDataSource), orderedListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    orderedListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent9(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent9(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent9(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(orderedListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func blockQuoteComponent8(dataList: (Int64, NodeViewDataSource), blockQuoteNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                listParagraphComponent(item)
                            } else if (item.node is Heading) {
                                // 标题
                                listHeadingComponent(item)
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                listCodeBlockComponent(
                                    (item.node as IndentedCodeBlock)().getLiteral(),
                                    Option<String>.None
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                listCodeBlockComponent(
                                    (item.node as FencedCodeBlock)().getLiteral(),
                                    (item.node as FencedCodeBlock)().getInfo()
                                )
                            } else if (item.node is BulletList) {
                                // 无序列表
                                bulletListComponent9(listNumberData(item), item)
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                orderedListComponent9(listNumberData(item), item)
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                blockQuoteComponent9(listNumberData(item), item)
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
                                    toCodeList(item)[2]
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
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
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(blockQuoteNodeView)
                }
            }
        }
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownConfiguration.markdownTheme.blockQuoteWidth))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func bulletListComponent7(dataList: (Int64, NodeViewDataSource), bulletListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    bulletListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent8(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent8(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent8(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(bulletListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func orderedListComponent7(dataList: (Int64, NodeViewDataSource), orderedListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    orderedListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent8(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent8(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent8(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(orderedListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func blockQuoteComponent7(dataList: (Int64, NodeViewDataSource), blockQuoteNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                listParagraphComponent(item)
                            } else if (item.node is Heading) {
                                // 标题
                                listHeadingComponent(item)
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                listCodeBlockComponent(
                                    (item.node as IndentedCodeBlock)().getLiteral(),
                                    Option<String>.None
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                listCodeBlockComponent(
                                    (item.node as FencedCodeBlock)().getLiteral(),
                                    (item.node as FencedCodeBlock)().getInfo()
                                )
                            } else if (item.node is BulletList) {
                                // 无序列表
                                bulletListComponent8(listNumberData(item), item)
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                orderedListComponent8(listNumberData(item), item)
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                blockQuoteComponent8(listNumberData(item), item)
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
                                    toCodeList(item)[2]
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
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
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(blockQuoteNodeView)
                }
            }
        }
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownConfiguration.markdownTheme.blockQuoteWidth))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func bulletListComponent6(dataList: (Int64, NodeViewDataSource), bulletListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    bulletListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent7(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent7(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent7(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(bulletListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func orderedListComponent6(dataList: (Int64, NodeViewDataSource), orderedListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    orderedListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent7(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent7(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent7(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(orderedListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func blockQuoteComponent6(dataList: (Int64, NodeViewDataSource), blockQuoteNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                listParagraphComponent(item)
                            } else if (item.node is Heading) {
                                // 标题
                                listHeadingComponent(item)
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                listCodeBlockComponent(
                                    (item.node as IndentedCodeBlock)().getLiteral(),
                                    Option<String>.None
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                listCodeBlockComponent(
                                    (item.node as FencedCodeBlock)().getLiteral(),
                                    (item.node as FencedCodeBlock)().getInfo()
                                )
                            } else if (item.node is BulletList) {
                                // 无序列表
                                bulletListComponent7(listNumberData(item), item)
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                orderedListComponent7(listNumberData(item), item)
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                blockQuoteComponent7(listNumberData(item), item)
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
                                    toCodeList(item)[2]
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
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
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(blockQuoteNodeView)
                }
            }
        }
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownConfiguration.markdownTheme.blockQuoteWidth))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func bulletListComponent5(dataList: (Int64, NodeViewDataSource), bulletListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    bulletListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent6(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent6(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent6(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(bulletListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func orderedListComponent5(dataList: (Int64, NodeViewDataSource), orderedListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    orderedListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent6(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent6(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent6(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(orderedListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func blockQuoteComponent5(dataList: (Int64, NodeViewDataSource), blockQuoteNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                listParagraphComponent(item)
                            } else if (item.node is Heading) {
                                // 标题
                                listHeadingComponent(item)
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                listCodeBlockComponent(
                                    (item.node as IndentedCodeBlock)().getLiteral(),
                                    Option<String>.None
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                listCodeBlockComponent(
                                    (item.node as FencedCodeBlock)().getLiteral(),
                                    (item.node as FencedCodeBlock)().getInfo()
                                )
                            } else if (item.node is BulletList) {
                                // 无序列表
                                bulletListComponent6(listNumberData(item), item)
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                orderedListComponent6(listNumberData(item), item)
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                blockQuoteComponent6(listNumberData(item), item)
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
                                    toCodeList(item)[2]
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
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
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(blockQuoteNodeView)
                }
            }
        }
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownConfiguration.markdownTheme.blockQuoteWidth))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func bulletListComponent4(dataList: (Int64, NodeViewDataSource), bulletListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    bulletListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent5(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent5(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent5(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(bulletListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func orderedListComponent4(dataList: (Int64, NodeViewDataSource), orderedListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    orderedListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent5(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent5(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent5(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(orderedListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func blockQuoteComponent4(dataList: (Int64, NodeViewDataSource), blockQuoteNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                listParagraphComponent(item)
                            } else if (item.node is Heading) {
                                // 标题
                                listHeadingComponent(item)
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                listCodeBlockComponent(
                                    (item.node as IndentedCodeBlock)().getLiteral(),
                                    Option<String>.None
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                listCodeBlockComponent(
                                    (item.node as FencedCodeBlock)().getLiteral(),
                                    (item.node as FencedCodeBlock)().getInfo()
                                )
                            } else if (item.node is BulletList) {
                                // 无序列表
                                bulletListComponent5(listNumberData(item), item)
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                orderedListComponent5(listNumberData(item), item)
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                blockQuoteComponent5(listNumberData(item), item)
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
                                    toCodeList(item)[2]
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
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
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(blockQuoteNodeView)
                }
            }
        }
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownConfiguration.markdownTheme.blockQuoteWidth))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func bulletListComponent3(dataList: (Int64, NodeViewDataSource), bulletListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    bulletListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent4(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent4(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent4(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(bulletListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func orderedListComponent3(dataList: (Int64, NodeViewDataSource), orderedListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    orderedListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent4(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent4(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent4(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(orderedListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func blockQuoteComponent3(dataList: (Int64, NodeViewDataSource), blockQuoteNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                listParagraphComponent(item)
                            } else if (item.node is Heading) {
                                // 标题
                                listHeadingComponent(item)
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                listCodeBlockComponent(
                                    (item.node as IndentedCodeBlock)().getLiteral(),
                                    Option<String>.None
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                listCodeBlockComponent(
                                    (item.node as FencedCodeBlock)().getLiteral(),
                                    (item.node as FencedCodeBlock)().getInfo()
                                )
                            } else if (item.node is BulletList) {
                                // 无序列表
                                bulletListComponent4(listNumberData(item), item)
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                orderedListComponent4(listNumberData(item), item)
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                blockQuoteComponent4(listNumberData(item), item)
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
                                    toCodeList(item)[2]
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
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
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(blockQuoteNodeView)
                }
            }
        }
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownConfiguration.markdownTheme.blockQuoteWidth))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func bulletListComponent2(dataList: (Int64, NodeViewDataSource), bulletListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    bulletListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent3(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent3(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent3(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(bulletListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func orderedListComponent2(dataList: (Int64, NodeViewDataSource), orderedListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    orderedListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent3(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent3(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent3(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(orderedListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func blockQuoteComponent2(dataList: (Int64, NodeViewDataSource), blockQuoteNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                listParagraphComponent(item)
                            } else if (item.node is Heading) {
                                // 标题
                                listHeadingComponent(item)
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                listCodeBlockComponent(
                                    (item.node as IndentedCodeBlock)().getLiteral(),
                                    Option<String>.None
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                listCodeBlockComponent(
                                    (item.node as FencedCodeBlock)().getLiteral(),
                                    (item.node as FencedCodeBlock)().getInfo()
                                )
                            } else if (item.node is BulletList) {
                                // 无序列表
                                bulletListComponent3(listNumberData(item), item)
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                orderedListComponent3(listNumberData(item), item)
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                blockQuoteComponent3(listNumberData(item), item)
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
                                    toCodeList(item)[2]
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
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
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(blockQuoteNodeView)
                }
            }
        }
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownConfiguration.markdownTheme.blockQuoteWidth))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func bulletListComponent1(dataList: (Int64, NodeViewDataSource), bulletListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    bulletListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent2(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent2(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent2(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(bulletListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func orderedListComponent1(dataList: (Int64, NodeViewDataSource), orderedListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    orderedListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent2(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent2(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent2(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(orderedListNodeView)
                }
            }
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func blockQuoteComponent1(dataList: (Int64, NodeViewDataSource), blockQuoteNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                listParagraphComponent(item)
                            } else if (item.node is Heading) {
                                // 标题
                                listHeadingComponent(item)
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                listCodeBlockComponent(
                                    (item.node as IndentedCodeBlock)().getLiteral(),
                                    Option<String>.None
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                listCodeBlockComponent(
                                    (item.node as FencedCodeBlock)().getLiteral(),
                                    (item.node as FencedCodeBlock)().getInfo()
                                )
                            } else if (item.node is BulletList) {
                                // 无序列表
                                bulletListComponent2(listNumberData(item), item)
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                orderedListComponent2(listNumberData(item), item)
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                blockQuoteComponent2(listNumberData(item), item)
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
                                    toCodeList(item)[2]
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
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
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(blockQuoteNodeView)
                }
            }
        }
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownConfiguration.markdownTheme.blockQuoteWidth))
        // 文本内容前的起始边距
        .padding(left: 10.0)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    @Builder
    func bulletListComponent(dataList: (Int64, NodeViewDataSource), bulletListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    bulletListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent1(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent1(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent1(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(bulletListNodeView)
                }
            }
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
    func orderedListComponent(dataList: (Int64, NodeViewDataSource), orderedListNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    orderedListItemComponent: NodeView, idx: Int64 => ListItem() {
                        Row() {
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
                                                Option<String>.None
                                            )
                                        } else if (item.node is FencedCodeBlock) {
                                            // 围栏代码
                                            listCodeBlockComponent(
                                                (item.node as FencedCodeBlock)().getLiteral(),
                                                (item.node as FencedCodeBlock)().getInfo()
                                            )
                                        } else if (item.node is BulletList) {
                                            // 无序列表
                                            bulletListComponent1(listNumberData(item), item)
                                        } else if (item.node is OrderedList) {
                                            // 有序列表
                                            orderedListComponent1(listNumberData(item), item)
                                        } else if (item.node is BlockQuote) {
                                            // 块引用
                                            blockQuoteComponent1(listNumberData(item), item)
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
                                                toCodeList(item)[2]
                                            )
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
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                }
            )
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(orderedListNodeView)
                }
            }
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
    func blockQuoteComponent(dataList: (Int64, NodeViewDataSource), blockQuoteNodeView: NodeView) {
        List() {
            LazyForEach(
                dataList[1],
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Column() {
                            if (item.node is Paragraph) {
                                // 段落
                                listParagraphComponent(item)
                            } else if (item.node is Heading) {
                                // 标题
                                listHeadingComponent(item)
                            } else if (item.node is IndentedCodeBlock) {
                                // 缩进代码
                                listCodeBlockComponent(
                                    (item.node as IndentedCodeBlock)().getLiteral(),
                                    Option<String>.None
                                )
                            } else if (item.node is FencedCodeBlock) {
                                // 围栏代码
                                listCodeBlockComponent(
                                    (item.node as FencedCodeBlock)().getLiteral(),
                                    (item.node as FencedCodeBlock)().getInfo()
                                )
                            } else if (item.node is BulletList) {
                                // 无序列表
                                bulletListComponent1(listNumberData(item), item)
                            } else if (item.node is OrderedList) {
                                // 有序列表
                                orderedListComponent1(listNumberData(item), item)
                            } else if (item.node is BlockQuote) {
                                // 块引用
                                blockQuoteComponent1(listNumberData(item), item)
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
                                    toCodeList(item)[2]
                                )
                            } else if (item.node is LatexMathBlock) {
                                // 数学公式 - 单行
                                listLatexMathBlockComponent((item.node as LatexMathBlock)().latex)
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
            if (dataList[0] != 0) {
                ListItem() {
                    listButtonComponent(blockQuoteNodeView)
                }
            }
        }
        // 设置元素的边框颜色。
        .borderColor(markdownConfiguration.markdownTheme.blockQuoteColor)
        // 设置元素的边框宽度(单位为vp)。
        .borderWidth(EdgeWidths(left: markdownConfiguration.markdownTheme.blockQuoteWidth))
        // 文本内容前的起始边距
        .padding(left: 10.0, right: markdownConfiguration.markdownTheme.blockMargin)
        // 块内容前的起始边距
        .margin(left: markdownConfiguration.markdownTheme.blockMargin, top: marginTop, bottom: marginBottom)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    func listNumberData(nodeView: NodeView): (Int64, NodeViewDataSource) {
        let bulletListDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())
        if (nodeView.children.size <= markdownConfiguration.markdownTheme.listNumber) {
            bulletListDataSource.clear()
            bulletListDataSource.addDatas(nodeView.children)
            return (0, bulletListDataSource)
        } else {
            bulletListDataSource.clear()
            bulletListDataSource.addDatas(nodeView.children[0..markdownConfiguration.markdownTheme.listNumber])
            return (1, bulletListDataSource)
        }
    }
}
