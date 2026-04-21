package markdown.components

import ohos.state_macro_manage.*

/**
 * 定义列表控件
 */
@Component
public class MarkdownDescListComponent {
    var descListMarkdownConfiguration: MarkdownConfiguration // markdown配置
    var descListNodeView: NodeView // 定义列表控件自身节点
    @Prop
    var descListComponentWidth: Float64 // 控件宽度 - 单位vp
    var descListMarkdownCacheConfiguration: MarkdownCacheConfiguration // 缓存的控件数据
    @BuilderParam
    var descListCustomParagraphLineBuilder: (NodeView, Int64) -> Unit // 自定义行内段落布局
    var descListTocListOnClick: (Int64) -> Unit // TOC列表点击事件
    var descListImageCallback: (String) -> Unit // 图片点击事件
    var descListFootnoteCallback: (String) -> Unit // 脚注点击事件
    var descListNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>()) // 定义列表控件子节点的懒加载数据源

    protected override func aboutToAppear(): Unit {
        refreshDescListData(descListNodeView) // 初始化刷新数据
        descListMarkdownCacheConfiguration.descListComponent.add(descListNodeView.nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = descListMarkdownCacheConfiguration.descListComponent.get(descListNodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                descListMarkdownCacheConfiguration.descListComponent.remove(descListNodeView.nodeHash)
            }
        } else {
            descListMarkdownCacheConfiguration.descListComponent.remove(descListNodeView.nodeHash)
        }
    }

    func build() {
        List() {
            LazyForEach(
                descListNodeViewDataSource,
                itemGeneratorFunc: {
                    descListNodeView: NodeView, idx: Int64 => if (descListNodeView.nodeType == "DescTerm") {
                        ListItem() {
                            MarkdownDescTermComponent(
                                descTermMarkdownConfiguration: descListMarkdownConfiguration,
                                descTermNodeView: descListNodeView,
                                descTermComponentWidth: descListComponentWidth,
                                descTermMarkdownCacheConfiguration: descListMarkdownCacheConfiguration,
                                descTermCustomParagraphLineBuilder: descListCustomParagraphLineBuilder,
                                descTermTocListOnClick: descListTocListOnClick,
                                descTermImageCallback: descListImageCallback,
                                descTermFootnoteCallback: descListFootnoteCallback
                            )
                        }
                    } else if (descListNodeView.nodeType == "DescDef") {
                        ListItem() {
                            MarkdownDescDefComponent(
                                descDefMarkdownConfiguration: descListMarkdownConfiguration,
                                descDefNodeView: descListNodeView,
                                descDefComponentWidth: descListComponentWidth,
                                descDefMarkdownCacheConfiguration: descListMarkdownCacheConfiguration,
                                descDefCustomParagraphLineBuilder: descListCustomParagraphLineBuilder,
                                descDefTocListOnClick: descListTocListOnClick,
                                descDefImageCallback: descListImageCallback,
                                descDefFootnoteCallback: descListFootnoteCallback
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
                    descListNodeView: NodeView, idx: Int64 => return "${idx}-${descListNodeView.nodeHash}-${descListNodeView.contentHash}"
                }
            )
        }
        .backgroundColor(definitionListBackgroundColor(descListMarkdownConfiguration.markdownTheme))
        .listDirection(Axis.Vertical)
        .alignListItem(ListItemAlign.Start)
        .width(100.percent)
        .padding(
            top: descListMarkdownConfiguration.markdownTheme.definitionListTheme.definitionListPaddingTop,
            right: descListMarkdownConfiguration.markdownTheme.definitionListTheme.definitionListPaddingRight,
            bottom: descListMarkdownConfiguration.markdownTheme.definitionListTheme.definitionListPaddingBottom,
            left: descListMarkdownConfiguration.markdownTheme.definitionListTheme.definitionListPaddingLeft
        )
    }

    /**
     * 定义列表解释控件数据刷新
     *
     * @param descListNodeView 刷新的新数据
     */
    public func refreshDescListData(descListNodeView: NodeView): Unit {
        this.descListNodeView = descListNodeView
        let refreshNodeViewChildren = descListNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = descListNodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            refreshDescListDatas(dataSourceSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                descListNodeViewDataSource.addData(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            refreshDescListDatas(dataSourceSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
        } else {
            // 新数据小于页面数据
            refreshDescListDatas(refreshNodeViewSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                descListNodeViewDataSource.deleteData(i)
            }
        }
    }

    /**
     * 循环判断历史数据有没有做过修改
     *
     * @param size 长度
     * @param refreshNodeViews 刷新的数据
     */
    func refreshDescListDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = descListNodeViewDataSource.getData(i)
            let newNodeHash = refreshNodeView.nodeHash
            let oldNodeHash = dataSourceNode.nodeHash
            if (newNodeHash != oldNodeHash) {
                // 自身节点唯一ID不相同需要刷新数据
                descListNodeViewDataSource.replaceData(i, refreshNodeView)
                continue
            }
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            if (newContentHash != oldContentHash) {
                // 子节点唯一ID不相同需要刷新子节点数据
                if (refreshNodeView.nodeType == "DescTerm") {
                    // 定义列表术语节点
                    let descTermComponents = descListMarkdownCacheConfiguration.descTermComponent
                    let cache = descTermComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshDescTermData(refreshNodeView)
                        descListNodeViewDataSource.update(i, refreshNodeView)
                    } else {
                        descListNodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                    continue
                }
                if (refreshNodeView.nodeType == "DescDef") {
                    // 定义列表解释节点
                    let descDefComponents = descListMarkdownCacheConfiguration.descDefComponent
                    let cache = descDefComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshDescDefData(refreshNodeView)
                        descListNodeViewDataSource.update(i, refreshNodeView)
                    } else {
                        descListNodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                    continue
                }
                // 其他节点
                descListNodeViewDataSource.replaceData(i, refreshNodeView)
            }
        }
    }
}
