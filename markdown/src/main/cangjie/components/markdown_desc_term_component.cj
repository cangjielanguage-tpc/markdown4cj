package markdown.components

import ohos.state_macro_manage.*

/**
 * 定义列表术语控件
 */
@Component
public class MarkdownDescTermComponent {
    @Prop
    var descTermMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var descTermNodeView: NodeView // 定义列表术语控件自身节点
    @Prop
    var descTermComponentWidth: Float64 // 控件宽度 - 单位vp
    @BuilderParam
    var descTermCustomParagraphLineBuilder: (NodeView, Int64) -> Unit // 自定义行内段落布局
    var descTermTocListOnClick: (Int64) -> Unit // TOC列表点击事件
    var descTermImageCallback: (String) -> Unit // 图片点击事件
    var descTermFootnoteCallback: (String) -> Unit // 脚注点击事件
    var descTermNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>()) // 定义列表术语控件子节点的懒加载数据源

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(descTermNodeView.nodeHash, refreshDescTermData)
        refreshDescTermData(descTermNodeView)
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(descTermNodeView.nodeHash)
    }

    func build() {
        List() {
            LazyForEach(
                descTermNodeViewDataSource,
                itemGeneratorFunc: {
                    nodeView: NodeView, idx: Int64 => if (nodeView.nodeType == "Paragraph") {
                        ListItem() {
                            MarkdownParagraphComponent(
                                paragraphMarkdownConfiguration: descTermMarkdownConfiguration,
                                paragraphNodeView: nodeView,
                                paragraphComponentWidth: descTermComponentWidth,
                                paragraphCustomParagraphLineBuilder: descTermCustomParagraphLineBuilder,
                                paragraphTocListOnClick: descTermTocListOnClick,
                                paragraphImageCallback: descTermImageCallback,
                                paragraphFootnoteCallback: descTermFootnoteCallback,
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
        .listDirection(Axis.Vertical)
        .alignListItem(ListItemAlign.Start)
        .margin(bottom: descTermMarkdownConfiguration.markdownTheme.definitionListTheme.definitionListTermToDescriptionSpacing)
    }

    /**
     * 定义列表解释控件数据刷新
     * 通过smartUpdateDataArray驱动UI更新，无需页面缓存。
     * keyGenerator含contentHash，hash变化时框架自动重建对应组件。
     *
     * @param descTermNodeView 刷新的新数据
     */
    public func refreshDescTermData(newNodeView: NodeView): Unit {
        this.descTermNodeView = newNodeView
        let refreshNodeViewChildren = descTermNodeView.children // 子节点数据
        if (refreshNodeViewChildren.size == 0) {
            descTermNodeViewDataSource.clear()
            return
        }
        descTermNodeViewDataSource.smartUpdateDataArray(refreshNodeViewChildren)
    }
}
