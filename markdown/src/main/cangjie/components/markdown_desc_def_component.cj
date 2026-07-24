package markdown.components

import ohos.state_macro_manage.*

/**
 * 定义列表解释控件
 */
@Component
public class MarkdownDescDefComponent {
    @Prop
    var descDefMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var descDefNodeView: NodeView // 定义列表解释控件自身节点
    @Prop
    var descDefComponentWidth: Float64 // 控件宽度 - 单位vp
    @BuilderParam
    var descDefCustomParagraphLineBuilder: (NodeView, Int64) -> Unit // 自定义行内段落控件
    var descDefTocListOnClick: (Int64) -> Unit // TOC列表点击事件
    var descDefImageCallback: (String) -> Unit // 图片点击事件
    var descDefFootnoteCallback: (String) -> Unit // 脚注点击事件
    @BuilderParam
    var blockImageCardComponent: (?String,?String, ?String) -> Unit  //自定义卡片布局块级图片
    @BuilderParam
    var inlineImageCardComponent: (?String,?String, ?String) -> Unit  //自定义卡片布局行内图片
    @BuilderParam
    var inlineLinkCardComponent: (?String, ?String) -> Unit  //自定义卡片布局行内链接
    var descDefNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>()) // 定义列表解释控件子节点的懒加载数据源

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(descDefNodeView.nodeHash, refreshDescDefData)
        refreshDescDefData(descDefNodeView)
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(descDefNodeView.nodeHash)
    }

    func build() {
        List() {
            LazyForEach(
                descDefNodeViewDataSource,
                itemGeneratorFunc: {
                    descDefNodeView: NodeView, idx: Int64 => if (descDefNodeView.nodeType == "Paragraph") {
                        ListItem() {
                            MarkdownParagraphComponent(
                                paragraphMarkdownConfiguration: descDefMarkdownConfiguration,
                                paragraphNodeView: descDefNodeView,
                                paragraphComponentWidth: descDefComponentWidth,
                                paragraphCustomParagraphLineBuilder: descDefCustomParagraphLineBuilder,
                                paragraphTocListOnClick: descDefTocListOnClick,
                                paragraphImageCallback: descDefImageCallback,
                                paragraphFootnoteCallback: descDefFootnoteCallback,
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
                    descDefNodeView: NodeView, idx: Int64 => return "${idx}-${descDefNodeView.nodeHash}-${descDefNodeView.contentHash}"
                }
            )
        }
        .alignListItem(ListItemAlign.Start)
        .listDirection(Axis.Vertical)
        .margin(left: descDefMarkdownConfiguration.markdownTheme.definitionListTheme.definitionListDescriptionIndent)
    }

    /**
     * 定义列表解释控件数据刷新
     * 通过smartUpdateDataArray驱动UI更新，无需页面缓存。
     * keyGenerator含contentHash，hash变化时框架自动重建对应组件。
     *
     * @param descDefNodeView 刷新的新数据
     */
    public func refreshDescDefData(newNodeView: NodeView): Unit {
        this.descDefNodeView = newNodeView
        let refreshNodeViewChildren = descDefNodeView.children // 子节点数据
        if (refreshNodeViewChildren.size == 0) {
            descDefNodeViewDataSource.clear()
            return
        }
        descDefNodeViewDataSource.smartUpdateDataArray(refreshNodeViewChildren)
    }
}
