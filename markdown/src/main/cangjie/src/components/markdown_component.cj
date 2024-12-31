/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown预览自定义控件
 */
@Component
public class MarkdownComponent {
    /**
     * 外部传入的Markdown文档
     */
    var mdStr: String = ""

    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration = MarkdownConfiguration.create()

    /**
     * toc事件回调数据
     */
    var indexHashMap: HashMap<Int64, Float64> = HashMap<Int64, Float64>()

    /**
     * list控制器
     */
    let scroller: Scroller = Scroller()

    /**
     * 屏幕宽度 - 单位px
     */
    let screenWidth: Int32 = getDefaultDisplaySync().width

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    func build() {
        List(scroller: scroller) {
            LazyForEach(
                nodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Heading) {
                        // 标题
                        ListItem() {
                            MarkdownHeadingComponent(
                                headingNodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                componentWidth: widthVpToPx(screenWidth, markdownConfiguration.markdownTheme.imagePadding)
                            )
                        }
                        // 组件区域变化时触发该回调
                        .onAreaChange {oldValue, newValue => indexHashMap.put(idx, newValue.position.y)}
                    } else if (item.node is Paragraph) {
                        // 段落
                        ListItem() {
                            MarkdownParagraphComponent(
                                paragraphNodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                tocListOnClick: TocListOnClick,
                                componentWidth: widthVpToPx(screenWidth, markdownConfiguration.markdownTheme.imagePadding)
                            )
                        }
                    } else if (item.node is BulletList) {
                        // 无序列表（包含任务列表）
                        ListItem() {
                            MarkdownListComponent(
                                listNodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                tocListOnClick: TocListOnClick,
                                componentWidth: widthVpToPx(screenWidth, markdownConfiguration.markdownTheme.imagePadding)
                            )
                        }
                    } else if (item.node is OrderedList) {
                        // 有序列表（包含TOC目录列表）
                        ListItem() {
                            MarkdownListComponent(
                                listNodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                tocListOnClick: TocListOnClick,
                                componentWidth: widthVpToPx(screenWidth, markdownConfiguration.markdownTheme.imagePadding)
                            )
                        }
                    } else if (item.node is BlockQuote) {
                        // 块引用
                        ListItem() {
                            MarkdownListComponent(
                                listNodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                tocListOnClick: TocListOnClick,
                                componentWidth: widthVpToPx(screenWidth, markdownConfiguration.markdownTheme.imagePadding)
                            )
                        }
                    } else if (item.node is FencedCodeBlock) {
                        // 围栏代码块
                        ListItem() {
                            MarkdownCodeBlockComponent(
                                markdownConfiguration: markdownConfiguration,
                                codeText: (item.node as FencedCodeBlock)().getLiteral(),
                                info: (item.node as FencedCodeBlock)().getInfo(),
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
                            )
                        }
                    } else if (item.node is IndentedCodeBlock) {
                        // 缩进代码块
                        ListItem() {
                            MarkdownCodeBlockComponent(
                                markdownConfiguration: markdownConfiguration,
                                codeText: (item.node as IndentedCodeBlock)().getLiteral(),
                                info: Option<String>.None,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
                            )
                        }
                    } else if (item.node is TableBlock) {
                        // 表格
                        ListItem() {
                            MarkdownTableBlockComponent(
                                tableNodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                componentWidth: widthVpToPx(screenWidth, markdownConfiguration.markdownTheme.imagePadding)
                            )
                        }
                    } else if (item.node is ThematicBreak) {
                        // 分割线
                        ListItem() {
                            MarkdownThematicBreakComponent(
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
                            )
                        }
                    } else if (item.node is SlideBlock) {
                        // 图片幻灯片
                        ListItem() {
                            MarkdownImageBannerComponent(
                                slideBlockNodeView: item,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
                            )
                        }
                    } else if (item.node is FencedCodeBlockListBlock) {
                        // 组合代码
                        ListItem() {
                            MarkdownCodeBlockListComponent(
                                nodeView: item,
                                strInfos: toCodeList(item)[0],
                                strText: toCodeList(item)[1],
                                strInfoText: toCodeList(item)[2],
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
                            )
                        }
                    } else if (item.node is HtmlBlock) {
                        // HTML标签
                        ListItem() {
                            MarkdownHtmlBlockComponent(htmlBlockView: (item.node as HtmlBlock)())
                        }
                    } else if (item.node is LatexMathBlock) {
                        // 单行的数学公式
                        ListItem() {
                            MarkdownLatexMathBlockComponent(
                                latexStr: (item.node as LatexMathBlock)().latex,
                                markdownConfiguration: markdownConfiguration,
                                marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
                            )
                        }
                    } else if (item.node is LinkReferenceDefinition) {
                        // 链接引用定义
                        ListItem() {
                            Text("")
                                // 设置外边距属性
                                .margin(top: markdownConfiguration.markdownTheme.blockTopAndBottomMargins, bottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins)
                        }
                    } else {
                        // TODO 其他节点
                        ListItem() {
                            Text("")
                                // 设置外边距属性
                                .margin(top: markdownConfiguration.markdownTheme.blockTopAndBottomMargins, bottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins)
                        }
                    }
                }
            )
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
        // 设置组件自身的宽度
        .width(100.percent)
        // 组件挂载显示时触发此回调
        .onAppear {=> stringToNodes()}
    }

    /**
     * 将String转换成ArrayList<NodeView>，将解析的列表添加到懒加载的数据源中
     */
    func stringToNodes() {
        let callback: (ArrayList<NodeView>) -> Unit = {
            nodeViews => launch {
                nodeViewDataSource.clear()
                nodeViewDataSource.addDatas(nodeViews)
            }
        }
        stringToNodesUtils(mdStr, markdownConfiguration, callback)
    }

    /**
     * TOC列表点击事件回调
     */
    func TocListOnClick(index: Int64): Unit {
        match (markdownConfiguration.tocIndexCallback) {
            case Some(v) => v(indexHashMap.get(index))
            case _ => ()
        }
    }
}
