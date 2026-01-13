/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.arkui.state_macro_manage.*

/**
 * 定义列表解释
 */
@Component
public class MarkdownDescDefComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 定义列表解释节点
     */
    var nodeView: NodeView

    /**
     * 缓存的数据
     */
    var markdownCacheConfiguration: MarkdownCacheConfiguration

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidth: Float64

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    /**
     * TOC列表点击事件回调
     */
    var tocListOnClick: (Int64) -> Unit

    /**
     * 懒加载数据源
     */
    var nodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeView)
        // 缓存当前控件
        markdownCacheConfiguration.descDefComponent.add(this.nodeView.nodeHash, this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = markdownCacheConfiguration.descDefComponent.get(this.nodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                markdownCacheConfiguration.descDefComponent.remove(this.nodeView.nodeHash)
            }
        } else {
            markdownCacheConfiguration.descDefComponent.remove(this.nodeView.nodeHash)
        }
    }

    func build() {
        List() {
            LazyForEach(
                nodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        ListItem() {
                            blockParagraphComponent(markdownConfiguration, item, Option<FootnoteBlock>.None, fontCallback, tocListOnClick, imageCallback, componentWidth, true, false, markdownCacheConfiguration.paragraphComponents)
                        }
                    } else {
                        // TODO 其他节点
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
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // 左边距
        .margin(left: markdownConfiguration.markdownTheme.descListDefIndentation, bottom: markdownConfiguration.markdownTheme.descListDefMargins, top: markdownConfiguration.markdownTheme.descListDefMargins)
    }

    /**
     * 数据刷新
     */
    public func refreshData(nodeView: NodeView): Unit {
        this.nodeView = nodeView
        let refreshNodeViews = nodeView.children
        let refreshNodeViewSize: Int64 = refreshNodeViews.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = nodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        refreshNodeViewDataSource(nodeView, refreshNodeViews, refreshNodeViewSize, dataSourceSize, nodeViewDataSource, "descdef", markdownCacheConfiguration, Option<HashMap<Int64, MarkdownTableBlockRowComponent>>.None)
    }
}
