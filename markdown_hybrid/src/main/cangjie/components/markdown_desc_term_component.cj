/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
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

    protected override func aboutToAppear(): Unit {
        refreshDescTermData(descTermNodeView) // 初始化刷新数据
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
                    descTermNodeView: NodeView, idx: Int64 => return "${idx}-${descTermNodeView.nodeHash}-${descTermNodeView.contentHash}"
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
    public func refreshDescTermData(descTermNodeView: NodeView): Unit {
        let refreshNodeViewChildren = descTermNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = descTermNodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            refreshDescTermDatas(dataSourceSize, refreshNodeViewChildren)
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                descTermNodeViewDataSource.addData(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            refreshDescTermDatas(dataSourceSize, refreshNodeViewChildren)
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            refreshDescTermDatas(refreshNodeViewSize, refreshNodeViewChildren)
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                descTermNodeViewDataSource.deleteData(i)
            }
        }
    }

    /**
     * 循环判断历史数据有没有做过修改
     *
     * @param size 长度
     * @param refreshNodeViews 刷新的数据
     */
    func refreshDescTermDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = descTermNodeViewDataSource.getData(i)
            let newBlockHash = refreshNodeView.nodeHash
            let oldBlockHash = dataSourceNode.nodeHash
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            // 唯一ID是否相同
            if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                descTermNodeViewDataSource.replaceData(i, refreshNodeView)
            } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                descTermNodeViewDataSource.replaceData(i, refreshNodeView)
            } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                if (refreshNodeView.nodeType == "Paragraph") {
                    // 段落
                    let paragraphComponents = descTermMarkdownCacheConfiguration.paragraphComponents
                    let cache = paragraphComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshParagraphData(refreshNodeView)
                    }
                } else {
                    // 其他
                    descTermNodeViewDataSource.replaceData(i, refreshNodeView)
                }
            }
        }
    }
}
