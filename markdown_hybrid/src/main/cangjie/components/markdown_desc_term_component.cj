/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.state_macro_manage.*

/**
 * 定义列表术语控件
 */
@Component
public class MarkdownDescTermComponent {
    /**
     * markdown配置
     */
    var descTermMarkdownConfiguration: MarkdownConfiguration

    /**
     * 定义列表术语控件自身节点
     */
    var descTermNodeView: NodeView

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var descTermComponentWidth: Float64

    /**
     * 缓存的控件数据
     */
    var descTermMarkdownCacheConfiguration: MarkdownCacheConfiguration

    /**
     * 自定义行内段落布局
     */
    @BuilderParam
    var descTermCustomParagraphLineBuilder: (NodeView, Int64) -> Unit

    /**
     * TOC列表点击事件
     */
    var descTermTocListOnClick: (Int64) -> Unit

    /**
     * 图片点击事件
     */
    var descTermImageCallback: (String) -> Unit

    /**
     * 脚注点击事件
     */
    var descTermFootnoteCallback: (String) -> Unit

    /**
     * 定义列表术语控件子节点的懒加载数据源
     */
    var descTermNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    /**
     * 最后一条数据的位置
     */
    @State
    var lastViewIndex: Int64 = 0

    protected override func aboutToAppear(): Unit {
        refreshDescTermData(descTermNodeView, descTermNodeView.isEndData) // 初始化刷新数据
        descTermMarkdownCacheConfiguration.descTermComponent.add(descTermNodeView.nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = descTermMarkdownCacheConfiguration.descTermComponent.get(descTermNodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                descTermMarkdownCacheConfiguration.descTermComponent.remove(descTermNodeView.nodeHash)
            }
        } else {
            descTermMarkdownCacheConfiguration.descTermComponent.remove(descTermNodeView.nodeHash)
        }
    }

    func build() {
        List() {
            LazyForEach(
                descTermNodeViewDataSource,
                itemGeneratorFunc: {
                    descTermNodeView: NodeView, idx: Int64 => if (descTermNodeView.nodeType == "Paragraph") {
                        ListItem() {
                            MarkdownParagraphComponent(
                                paragraphMarkdownConfiguration: descTermMarkdownConfiguration,
                                paragraphNodeView: descTermNodeView,
                                paragraphComponentWidth: descTermComponentWidth,
                                paragraphComponents: descTermMarkdownCacheConfiguration.paragraphComponents,
                                paragraphCustomParagraphLineBuilder: descTermCustomParagraphLineBuilder,
                                paragraphTocListOnClick: descTermTocListOnClick,
                                paragraphImageCallback: descTermImageCallback,
                                paragraphFootnoteCallback: descTermFootnoteCallback
                            )
                        }
                    } else {
                        ListItem() {
                            Text("")
                        }
                    }
                },
                keyGeneratorFunc: {
                    descTermNodeView: NodeView, idx: Int64 => return "${idx}-${descTermNodeView.nodeHash}-${descTermNodeView.contentHash}-${descTermNodeView.canRefresh}"
                }
            )
        }
        .listDirection(Axis.Vertical)
        .alignListItem(ListItemAlign.Start)
        .margin(bottom: descTermMarkdownConfiguration.markdownTheme.descListTermAndDefMargins)
    }

    /**
     * 定义列表解释控件数据刷新
     *
     * @param descTermNodeView 刷新的新数据
     */
    public func refreshDescTermData(descTermNodeView: NodeView, isEnd: Bool): Unit {
        let refreshNodeViewChildren = descTermNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = descTermNodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            refreshDescTermDatas(dataSourceSize, refreshNodeViewChildren, false) // 循环判断历史数据有没有做过修改
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                if (isEnd && (i == refreshNodeViewSize - 1)) {
                    refreshNodeViewChildren[i].isEndData = true
                }
                descTermNodeViewDataSource.addData(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            refreshDescTermDatas(dataSourceSize, refreshNodeViewChildren, isEnd) // 循环判断历史数据有没有做过修改
        } else {
            // 新数据小于页面数据
            refreshDescTermDatas(refreshNodeViewSize, refreshNodeViewChildren, isEnd) // 循环判断历史数据有没有做过修改
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                descTermNodeViewDataSource.deleteData(i)
            }
        }
        lastViewIndex = descTermNodeViewDataSource.totalCount() - 1
    }

    /**
     * 循环判断历史数据有没有做过修改
     *
     * @param size 长度
     * @param refreshNodeViews 刷新的数据
     */
    func refreshDescTermDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>, isEnd: Bool): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = descTermNodeViewDataSource.getData(i)
            let newNodeHash = refreshNodeView.nodeHash
            let oldNodeHash = dataSourceNode.nodeHash
            // 当前层的倒数第二条数据，因为可能一行多个
            let isSecondToLast: Bool = (i == lastViewIndex - 1)
            if (isEnd) {
                refreshNodeView.isEndData = (i == lastViewIndex && !isSecondToLast)
            } else {
                refreshNodeView.isEndData = false
            }
            if (newNodeHash != oldNodeHash) {
                // 自身节点唯一ID不相同需要刷新数据
                descTermNodeViewDataSource.replaceData(i, refreshNodeView)
                continue
            }
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            if (newContentHash != oldContentHash) {
                // 子节点唯一ID不相同需要刷新子节点数据
                if (refreshNodeView.nodeType == "Paragraph") {
                    // 段落节点
                    let paragraphComponents = descTermMarkdownCacheConfiguration.paragraphComponents
                    let cache = paragraphComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshParagraphData(refreshNodeView, isSecondToLast || isEnd)
                    }
                    continue
                }
                // 其他节点
                descTermNodeViewDataSource.replaceData(i, refreshNodeView)
                continue
            }
            if (dataSourceNode.canRefresh) {
                refreshNodeView.isEndData = false
                refreshNodeView.canRefresh = false
                if (refreshNodeView.nodeType == "Paragraph") {
                    // 段落节点
                    let paragraphComponents = descTermMarkdownCacheConfiguration.paragraphComponents
                    let cache = paragraphComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshParagraphData(refreshNodeView, isSecondToLast || isEnd)
                    }
                    continue
                }
                // 其他节点
                descTermNodeViewDataSource.replaceData(i, refreshNodeView)
            }
        }
    }
}
