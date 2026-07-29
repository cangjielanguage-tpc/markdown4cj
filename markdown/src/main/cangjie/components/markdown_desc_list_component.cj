package markdown.components

import ohos.state_macro_manage.*

/**
 * 定义列表控件
 */
@Component
public class MarkdownDescListComponent {
    @Prop
    var descListMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var descListNodeView: NodeView // 定义列表控件自身节点
    @Prop
    var descListComponentWidth: Float64 // 控件宽度 - 单位vp
    @BuilderParam
    var descListCustomParagraphLineBuilder: (NodeView, Int64) -> Unit // 自定义行内段落布局
    var descListTocListOnClick: (Int64) -> Unit // TOC列表点击事件
    var descListImageCallback: (String) -> Unit // 图片点击事件
    var descListFootnoteCallback: (String) -> Unit // 脚注点击事件
    @BuilderParam
    var blockImageCardComponent: (?String,?String, ?String) -> Unit  //自定义卡片布局块级图片
    @BuilderParam
    var inlineImageCardComponent: (?String,?String, ?String) -> Unit  //自定义卡片布局行内图片
    @BuilderParam
    var inlineLinkCardComponent: (?String, ?String) -> Unit  //自定义卡片布局行内链接
    var descListNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>()) // 定义列表控件子节点的懒加载数据源

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(descListNodeView.nodeHash, refreshDescListData)
        refreshDescListData(descListNodeView)
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(descListNodeView.nodeHash)
    }

    func build() {
        List() {
            LazyForEach(
                descListNodeViewDataSource,
                itemGeneratorFunc: {
                    nodeView: NodeView, idx: Int64 => if (nodeView.nodeType == "DescTerm") {
                        ListItem() {
                            MarkdownDescTermComponent(
                                descTermMarkdownConfiguration: descListMarkdownConfiguration,
                                descTermNodeView: nodeView,
                                descTermComponentWidth: descListComponentWidth,
                                descTermCustomParagraphLineBuilder: descListCustomParagraphLineBuilder,
                                descTermTocListOnClick: descListTocListOnClick,
                                descTermImageCallback: descListImageCallback,
                                descTermFootnoteCallback: descListFootnoteCallback,
                                blockImageCardComponent: blockImageCardComponent,
                                inlineImageCardComponent: inlineImageCardComponent,
                                inlineLinkCardComponent: inlineLinkCardComponent
                            )
                        }
                    } else if (nodeView.nodeType == "DescDef") {
                        ListItem() {
                            MarkdownDescDefComponent(
                                descDefMarkdownConfiguration: descListMarkdownConfiguration,
                                descDefNodeView: nodeView,
                                descDefComponentWidth: descListComponentWidth,
                                descDefCustomParagraphLineBuilder: descListCustomParagraphLineBuilder,
                                descDefTocListOnClick: descListTocListOnClick,
                                descDefImageCallback: descListImageCallback,
                                descDefFootnoteCallback: descListFootnoteCallback,
                                blockImageCardComponent: blockImageCardComponent,
                                inlineImageCardComponent: inlineImageCardComponent,
                                inlineLinkCardComponent: inlineLinkCardComponent
                            )
                        }
                        .margin(top: descDefItemSpacing(idx, descListMarkdownConfiguration.markdownTheme))
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
        .backgroundColor(definitionListBackgroundColor(descListMarkdownConfiguration.markdownTheme))
        .listDirection(Axis.Vertical)
        .alignListItem(ListItemAlign.Start)
        .padding(
            top: descListMarkdownConfiguration.markdownTheme.definitionListTheme.definitionListPaddingTop,
            right: descListMarkdownConfiguration.markdownTheme.definitionListTheme.definitionListPaddingRight,
            bottom: descListMarkdownConfiguration.markdownTheme.definitionListTheme.definitionListPaddingBottom,
            left: descListMarkdownConfiguration.markdownTheme.definitionListTheme.definitionListPaddingLeft
        )
        .margin(
            top: descListMarkdownConfiguration.markdownTheme.definitionListTheme.definitionListMarginTop,
            right: descListMarkdownConfiguration.markdownTheme.definitionListTheme.definitionListMarginRight,
            bottom: descListMarkdownConfiguration.markdownTheme.definitionListTheme.definitionListMarginBottom,
            left: descListMarkdownConfiguration.markdownTheme.definitionListTheme.definitionListMarginLeft
        )
    }

    /**
     * 定义列表解释控件数据刷新
     * 通过smartUpdateDataArray驱动UI更新，无需页面缓存。
     * keyGenerator含contentHash，hash变化时框架自动重建对应组件。
     *
     * @param descListNodeView 刷新的新数据
     */
    public func refreshDescListData(newNodeView: NodeView): Unit {
        this.descListNodeView = newNodeView
        let refreshNodeViewChildren = descListNodeView.children // 子节点数据
        if (refreshNodeViewChildren.size == 0) {
            descListNodeViewDataSource.clear()
            return
        }
        descListNodeViewDataSource.smartUpdateDataArray(refreshNodeViewChildren)
    }
}
