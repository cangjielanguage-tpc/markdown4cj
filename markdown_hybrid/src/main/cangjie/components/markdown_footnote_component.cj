/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.state_macro_manage.*

/**
 * 脚注控件
 */
@Component
public class MarkdownFootnoteComponent {
    /**
     * markdown配置
     */
    var footnoteMarkdownConfiguration: MarkdownConfiguration

    /**
     * 脚注控件自身节点
     */
    @Prop
    var footnoteNodeView: NodeView

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var footnoteComponentWidth: Float64

    /**
     * 缓存的控件数据
     */
    var footnoteMarkdownCacheConfiguration: MarkdownCacheConfiguration

    /**
     * 自定义行内段落控件
     */
    @BuilderParam
    var footnoteCustomParagraphLineBuilder: (NodeView, Int64) -> Unit

    /**
     * TOC列表点击事件
     */
    var footnoteTocListOnClick: (Int64) -> Unit

    /**
     * 图片点击事件
     */
    var footnoteImageCallback: (String) -> Unit

    /**
     * 脚注点击事件
     */
    var footnoteFootnoteCallback: (String) -> Unit

    /**
     * 脚注控件子节点的懒加载数据源
     */
    var footnoteNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        refreshFootnoteData(footnoteNodeView) // 初始化刷新数据
        footnoteMarkdownCacheConfiguration.footnoteComponent.add(footnoteNodeView.nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件缓存
        let value = footnoteMarkdownCacheConfiguration.footnoteComponent.get(footnoteNodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                footnoteMarkdownCacheConfiguration.footnoteComponent.remove(footnoteNodeView.nodeHash)
            }
        } else {
            footnoteMarkdownCacheConfiguration.footnoteComponent.remove(footnoteNodeView.nodeHash)
        }
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
                                paragraphComponents: footnoteMarkdownCacheConfiguration.paragraphComponents,
                                paragraphCustomParagraphLineBuilder: footnoteCustomParagraphLineBuilder,
                                paragraphTocListOnClick: footnoteTocListOnClick,
                                paragraphImageCallback: footnoteImageCallback,
                                paragraphFootnoteCallback: footnoteFootnoteCallback
                            )
                        }
                    } else {
                        ListItem() {
                            Text("")
                        }
                    }
                },
                keyGeneratorFunc: {
                    footnoteNodeView: NodeView, idx: Int64 => return "${idx}-${footnoteNodeView.nodeHash}-${footnoteNodeView.contentHash}"
                }
            )
        }
        .listDirection(Axis.Vertical)
        .alignListItem(ListItemAlign.Start)
    }

    /**
     * 定义列表解释控件数据刷新
     *
     * @param footnoteNodeView 刷新的新数据
     */
    public func refreshFootnoteData(footnoteNodeView: NodeView): Unit {
        let refreshNodeViewChildren = footnoteNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = footnoteNodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            refreshFootnoteDatas(dataSourceSize, refreshNodeViewChildren)
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                footnoteNodeViewDataSource.addData(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            refreshFootnoteDatas(dataSourceSize, refreshNodeViewChildren)
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            refreshFootnoteDatas(refreshNodeViewSize, refreshNodeViewChildren)
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                footnoteNodeViewDataSource.deleteData(i)
            }
        }
    }

    /**
     * 循环判断历史数据有没有做过修改
     *
     * @param size 长度
     * @param refreshNodeViews 刷新的数据
     */
    func refreshFootnoteDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = footnoteNodeViewDataSource.getData(i)
            let newBlockHash = refreshNodeView.nodeHash
            let oldBlockHash = dataSourceNode.nodeHash
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            // 唯一ID是否相同
            if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                footnoteNodeViewDataSource.replaceData(i, refreshNodeView)
            } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                footnoteNodeViewDataSource.replaceData(i, refreshNodeView)
            } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                if (refreshNodeView.nodeType == "Paragraph") {
                    // 段落
                    let paragraphComponents = footnoteMarkdownCacheConfiguration.paragraphComponents
                    let cache = paragraphComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshParagraphData(refreshNodeView)
                    }
                } else {
                    // 其他
                    footnoteNodeViewDataSource.replaceData(i, refreshNodeView)
                }
            }
        }
    }
}
