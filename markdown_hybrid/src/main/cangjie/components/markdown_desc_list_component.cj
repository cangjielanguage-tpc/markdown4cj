/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 定义列表控件
 */
@Component
public class MarkdownDescListComponent {
    /**
     * markdown配置
     */
    var descListMarkdownConfiguration: MarkdownConfiguration

    /**
     * 定义列表控件自身节点
     */
    var descListNodeView: NodeView

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var descListComponentWidth: Float64

    /**
     * 缓存的控件数据
     */
    var descListMarkdownCacheConfiguration: MarkdownCacheConfiguration

    /**
     * 自定义行内段落布局
     */
    @BuilderParam
    var descListCustomParagraphLineBuilder: (NodeView, Int64) -> Unit

    /**
     * TOC列表点击事件
     */
    var descListTocListOnClick: (Int64) -> Unit

    /**
     * 图片点击事件
     */
    var descListImageCallback: (String) -> Unit

    /**
     * 脚注点击事件
     */
    var descListFootnoteCallback: (String) -> Unit

    /**
     * 定义列表控件子节点的懒加载数据源
     */
    var descListNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    /**
     * 最后一条数据的位置
     */
    @State
    var lastViewIndex: Int64 = 0

    protected override func aboutToAppear(): Unit {
        refreshDescListData(descListNodeView, descListNodeView.isEndData) // 初始化刷新数据
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
                    } else {
                        ListItem() {
                            Text("")
                        }
                    }
                },
                keyGeneratorFunc: {
                    descListNodeView: NodeView, idx: Int64 => return "${idx}-${descListNodeView.nodeHash}-${descListNodeView.contentHash}-${descListNodeView.canRefresh}"
                }
            )
        }
        .listDirection(Axis.Vertical)
        .alignListItem(ListItemAlign.Start)
        .width(100.percent)
    }

    /**
     * 定义列表解释控件数据刷新
     *
     * @param descListNodeView 刷新的新数据
     */
    public func refreshDescListData(descListNodeView: NodeView, isEnd: Bool): Unit {
        let refreshNodeViewChildren = descListNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = descListNodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            refreshDescListDatas(dataSourceSize, refreshNodeViewChildren, false)
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                if (isEnd && (i == refreshNodeViewSize - 1)) {
                    refreshNodeViewChildren[i].isEndData = true
                }
                descListNodeViewDataSource.addData(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            refreshDescListDatas(dataSourceSize, refreshNodeViewChildren, isEnd)
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            refreshDescListDatas(refreshNodeViewSize, refreshNodeViewChildren, isEnd)
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                descListNodeViewDataSource.deleteData(i)
            }
        }
        lastViewIndex = descListNodeViewDataSource.totalCount() - 1
    }

    /**
     * 循环判断历史数据有没有做过修改
     *
     * @param size 长度
     * @param refreshNodeViews 刷新的数据
     */
    func refreshDescListDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>, isEnd: Bool): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = descListNodeViewDataSource.getData(i)
            let newBlockHash = refreshNodeView.nodeHash
            let oldBlockHash = dataSourceNode.nodeHash
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            // 当前层的倒数第二条数据，因为可能一行多个
            let isSecondToLast: Bool = (i == lastViewIndex - 1)
            if (isEnd) {
                refreshNodeView.isEndData = (i == lastViewIndex && !isSecondToLast)
            } else {
                refreshNodeView.isEndData = false
            }
            // 唯一ID是否相同
            if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                descListNodeViewDataSource.replaceData(i, refreshNodeView)
            } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                descListNodeViewDataSource.replaceData(i, refreshNodeView)
            } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                if (refreshNodeView.nodeType == "DescTerm") {
                    // 定义列表术语
                    let descTermComponents = descListMarkdownCacheConfiguration.descTermComponent
                    let cache = descTermComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshDescTermData(refreshNodeView, isSecondToLast || isEnd)
                    }
                } else if (refreshNodeView.nodeType == "DescDef") {
                    // 定义列表解释
                    let descDefComponents = descListMarkdownCacheConfiguration.descDefComponent
                    let cache = descDefComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshDescDefData(refreshNodeView, isSecondToLast || isEnd)
                    }
                } else {
                    // 其他
                    descListNodeViewDataSource.replaceData(i, refreshNodeView)
                }
            } else if (newBlockHash == oldBlockHash && newContentHash == oldContentHash && dataSourceNode.canRefresh) {
                refreshNodeView.isEndData = false
                refreshNodeView.canRefresh = false
                if (refreshNodeView.nodeType == "DescTerm") {
                    // 定义列表术语
                    let descTermComponents = descListMarkdownCacheConfiguration.descTermComponent
                    let cache = descTermComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshDescTermData(refreshNodeView, isSecondToLast || isEnd)
                    }
                } else if (refreshNodeView.nodeType == "DescDef") {
                    // 定义列表解释
                    let descDefComponents = descListMarkdownCacheConfiguration.descDefComponent
                    let cache = descDefComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshDescDefData(refreshNodeView, isSecondToLast || isEnd)
                    }
                } else {
                    // 其他
                    descListNodeViewDataSource.replaceData(i, refreshNodeView)
                }
            }
        }
    }
}
