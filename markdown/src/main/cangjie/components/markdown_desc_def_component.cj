package markdown.components

import ohos.state_macro_manage.*

/**
 * 定义列表解释控件
 */
@Component
public class MarkdownDescDefComponent {
    /**
     * markdown配置
     */
    var descDefMarkdownConfiguration: MarkdownConfiguration

    /**
     * 定义列表解释控件自身节点
     */
    var descDefNodeView: NodeView

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var descDefComponentWidth: Float64

    /**
     * 缓存的控件数据
     */
    var descDefMarkdownCacheConfiguration: MarkdownCacheConfiguration

    /**
     * 自定义行内段落控件
     */
    @BuilderParam
    var descDefCustomParagraphLineBuilder: (NodeView, Int64) -> Unit

    /**
     * TOC列表点击事件
     */
    var descDefTocListOnClick: (Int64) -> Unit

    /**
     * 图片点击事件
     */
    var descDefImageCallback: (String) -> Unit

    /**
     * 脚注点击事件
     */
    var descDefFootnoteCallback: (String) -> Unit

    /**
     * 定义列表解释控件子节点的懒加载数据源
     */
    var descDefNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        refreshDescDefData(descDefNodeView) // 初始化刷新数据
        descDefMarkdownCacheConfiguration.descDefComponent.add(descDefNodeView.nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = descDefMarkdownCacheConfiguration.descDefComponent.get(descDefNodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                descDefMarkdownCacheConfiguration.descDefComponent.remove(descDefNodeView.nodeHash)
            }
        } else {
            descDefMarkdownCacheConfiguration.descDefComponent.remove(descDefNodeView.nodeHash)
        }
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
                                paragraphComponents: descDefMarkdownCacheConfiguration.paragraphComponents,
                                paragraphCustomParagraphLineBuilder: descDefCustomParagraphLineBuilder,
                                paragraphTocListOnClick: descDefTocListOnClick,
                                paragraphImageCallback: descDefImageCallback,
                                paragraphFootnoteCallback: descDefFootnoteCallback
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
        .margin(left: descDefMarkdownConfiguration.markdownTheme.descListDefIndentation, bottom: descDefMarkdownConfiguration.markdownTheme.descListDefMargins, top: descDefMarkdownConfiguration.markdownTheme.descListDefMargins)
    }

    /**
     * 定义列表解释控件数据刷新
     *
     * @param descDefNodeView 刷新的新数据
     */
    public func refreshDescDefData(descDefNodeView: NodeView): Unit {
        this.descDefNodeView = descDefNodeView
        let refreshNodeViewChildren = descDefNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = descDefNodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            refreshDescDefDatas(dataSourceSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                descDefNodeViewDataSource.addData(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            refreshDescDefDatas(dataSourceSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
        } else {
            // 新数据小于页面数据
            refreshDescDefDatas(refreshNodeViewSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                descDefNodeViewDataSource.deleteData(i)
            }
        }
    }

    /**
     * 循环判断历史数据有没有做过修改
     *
     * @param size 长度
     * @param refreshNodeViews 刷新的数据
     */
    func refreshDescDefDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = descDefNodeViewDataSource.getData(i)
            let newNodeHash = refreshNodeView.nodeHash
            let oldNodeHash = dataSourceNode.nodeHash
            if (newNodeHash != oldNodeHash) {
                // 自身节点唯一ID不相同需要刷新数据
                descDefNodeViewDataSource.replaceData(i, refreshNodeView)
                continue
            }
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            if (newContentHash != oldContentHash) {
                // 子节点唯一ID不相同需要刷新子节点数据
                if (refreshNodeView.nodeType == "Paragraph") {
                    // 段落节点
                    let paragraphComponents = descDefMarkdownCacheConfiguration.paragraphComponents
                    let cache = paragraphComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshParagraphData(refreshNodeView)
                        descDefNodeViewDataSource.update(i, refreshNodeView)
                    } else {
                        descDefNodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                    continue
                }
                // 其他节点
                descDefNodeViewDataSource.replaceData(i, refreshNodeView)
            }
        }
    }
}
