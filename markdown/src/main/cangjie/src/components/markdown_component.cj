/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 全局锁
 */
let latexReentrantMutex: ReentrantMutex = ReentrantMutex()

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
     * NodeView列表
     */
    @State
    var nodeViews: ArrayList<NodeView> = ArrayList<NodeView>()

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

    func build() {
        Column() {
            List(scroller: scroller) {
                ForEach(
                    nodeViews,
                    itemGeneratorFunc: {
                        item: NodeView, idx: Int64 => if (item.node is Heading) {
                            // 标题
                            ListItem() {
                                MarkdownHeadingComponent(
                                    headingNodeView: item,
                                    markdownConfiguration: markdownConfiguration,
                                    marginTop: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins,
                                    componentWidth: widthPxToVp(screenWidth, markdownConfiguration.markdownTheme.imagePadding)
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
                                    componentWidth: widthPxToVp(screenWidth, markdownConfiguration.markdownTheme.imagePadding)
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
                                    componentWidth: widthPxToVp(screenWidth, markdownConfiguration.markdownTheme.imagePadding)
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
                                    componentWidth: widthPxToVp(screenWidth, markdownConfiguration.markdownTheme.imagePadding)
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
                                    componentWidth: widthPxToVp(screenWidth, markdownConfiguration.markdownTheme.imagePadding)
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
                                    marginBottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins
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
                                    // arrayLists: stringToResLists(item, markdownConfiguration)[0],
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
                        } else {
                            // TODO 其他节点
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
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 组件挂载显示时触发此回调
        .onAppear{=> stringToNodes()}
    }

    /**
     * 将String转换成ArrayList<NodeView>
     * 1、将String转换成Node
     * 2、将Node转换成ArrayList<NodeView>
     *
     * @param input 传入markdown数据内容
     */
    func stringToNodes(){
        spawn {
            try {
                let markdown: Markdown = Markdown.builder()
                    // 任务列表插件
                    .usePlugin(TaskListPlugin.create())
                    // TOC列表插件
                    .usePlugin(TocPlugin.create())
                    // 删除线插件
                    .usePlugin(StrikethroughPlugin.create())
                    // 表格插件
                    .usePlugin(TablePlugin.create())
                    // 幻灯片、视频、ImageStyle插件
                    .usePlugin(ImagePlugin.create())
                    // 代码标签
                    .usePlugin(CodeListPlugin.create())
                    // 数学公式
                    .usePlugin(LatexMathPlugin.create())
                    .build()
                let node: CommonmarkNode = markdown.parse(mdStr)
                let nodeView: NodeView = markdown.render(node)
                launch {
                    nodeViews = nodeView.children
                }
            } catch (e: Exception) {
                let arrayListNodeView: ArrayList<NodeView> = ArrayList<NodeView>()
                let paragraph: Paragraph  = Paragraph()
                let commonmarkText: CommonmarkText = CommonmarkText(mdStr)
                paragraph.appendChild(commonmarkText)
                let nodeView: NodeView = NodeView(paragraph)
                arrayListNodeView.append(nodeView)
                launch {
                    nodeViews = arrayListNodeView
                }
            }
        }
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
