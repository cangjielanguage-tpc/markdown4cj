package markdown.components

import ohos.state_macro_manage.*

/**
 * 脚注控件
 */
@Component
public class MarkdownFootnoteComponent {
    @Prop
    var footnoteMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var footnoteNodeView: NodeView // 脚注控件自身节点
    @Prop
    var footnoteComponentWidth: Float64 // 控件宽度 - 单位vp
    @BuilderParam
    var footnoteCustomParagraphLineBuilder: (NodeView, Int64) -> Unit // 自定义行内段落控件
    var footnoteTocListOnClick: (Int64) -> Unit // TOC列表点击事件
    var footnoteImageCallback: (String) -> Unit // 图片点击事件
    var footnoteFootnoteCallback: (String) -> Unit // 脚注点击事件
    @BuilderParam
    var blockImageCardComponent: (?String,?String, ?String) -> Unit  //自定义卡片布局块级图片
    @BuilderParam
    var inlineImageCardComponent: (?String, ?String, ?String) -> Unit  //自定义卡片布局行内图片
    @BuilderParam
    var inlineLinkCardComponent: (?String, ?String) -> Unit  //自定义卡片布局行内链接
    var footnoteNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>()) // 脚注控件子节点的懒加载数据源

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(footnoteNodeView.nodeHash, refreshFootnoteData)
        refreshFootnoteData(footnoteNodeView)
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(footnoteNodeView.nodeHash)
    }

    func build() {
        List() {
            LazyForEach(
                footnoteNodeViewDataSource,
                itemGeneratorFunc: {
                    nodeView: NodeView, idx: Int64 => if (nodeView.nodeType == "Paragraph") {
                        ListItem() {
                            MarkdownParagraphComponent(
                                paragraphMarkdownConfiguration: footnoteMarkdownConfiguration,
                                paragraphNodeView: nodeView,
                                paragraphComponentWidth: footnoteComponentWidth,
                                paragraphCustomParagraphLineBuilder: footnoteCustomParagraphLineBuilder,
                                paragraphTocListOnClick: footnoteTocListOnClick,
                                paragraphImageCallback: footnoteImageCallback,
                                paragraphFootnoteCallback: footnoteFootnoteCallback,
                                blockImageCardComponent: blockImageCardComponent,
                                inlineImageCardComponent: inlineImageCardComponent,
                                inlineLinkCardComponent: inlineLinkCardComponent
                            )
                        }
                    } else {
                        ListItem() {
                            Text("")
                        }
                    }
                },
                keyGeneratorFunc: {
                    nodeView: NodeView, idx: Int64 => return "${idx}-${nodeView.nodeHash}-${nodeView.contentHash}"
                }
            )
        }
        .backgroundColor(footnoteBackgroundColor(footnoteMarkdownConfiguration.markdownTheme, footnoteNodeView))
        .listDirection(Axis.Vertical)
        .alignListItem(ListItemAlign.Start)
        .padding(
            top: footnoteMarkdownConfiguration.markdownTheme.footnoteDefTheme.footnoteDefPaddingTop,
            right: footnoteMarkdownConfiguration.markdownTheme.footnoteDefTheme.footnoteDefPaddingRight,
            bottom: footnoteMarkdownConfiguration.markdownTheme.footnoteDefTheme.footnoteDefPaddingBottom,
            left: footnoteMarkdownConfiguration.markdownTheme.footnoteDefTheme.footnoteDefPaddingLeft
        )
        .margin(
            top: footnoteMarkdownConfiguration.markdownTheme.footnoteDefTheme.footnoteDefMarginTop,
            right: footnoteMarkdownConfiguration.markdownTheme.footnoteDefTheme.footnoteDefMarginRight,
            bottom: footnoteMarkdownConfiguration.markdownTheme.footnoteDefTheme.footnoteDefMarginBottom,
            left: footnoteMarkdownConfiguration.markdownTheme.footnoteDefTheme.footnoteDefMarginLeft
        )
    }

    /**
     * 定义列表解释控件数据刷新
     * 通过smartUpdateDataArray驱动UI更新，无需页面缓存。
     * keyGenerator含contentHash，hash变化时框架自动重建对应组件。
     *
     * @param footnoteNodeView 刷新的新数据
     */
    public func refreshFootnoteData(newNodeView: NodeView): Unit {
        this.footnoteNodeView = newNodeView
        let refreshNodeViewChildren = footnoteNodeView.children // 子节点数据
        if (refreshNodeViewChildren.size == 0) {
            footnoteNodeViewDataSource.clear()
            return
        }
        footnoteNodeViewDataSource.smartUpdateDataArray(refreshNodeViewChildren)
    }
}
