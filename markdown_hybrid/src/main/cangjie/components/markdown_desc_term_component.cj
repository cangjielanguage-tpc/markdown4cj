/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 定义列表术语
 */
@Component
public class MarkdownDescTermComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidth: Float64

    /**
     * 术语节点
     */
    var nodeView: NodeView

    /**
     * 缓存的数据
     */
    var markdownCacheConfiguration: MarkdownCacheConfiguration

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    /**
     * TOC列表点击事件回调
     */
    var tocListOnClick: (Int64) -> Unit

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * 懒加载数据源
     */
    var nodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    /**
     * 自定义行内段落布局
     */
    @BuilderParam
    var customParagraphLineBuilder: (NodeView, Int64) -> Unit

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeView)
        // 缓存当前控件
        markdownCacheConfiguration.descTermComponent.add(this.nodeView.nodeHash, this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = markdownCacheConfiguration.descTermComponent.get(this.nodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                markdownCacheConfiguration.descTermComponent.remove(this.nodeView.nodeHash)
            }
        } else {
            markdownCacheConfiguration.descTermComponent.remove(this.nodeView.nodeHash)
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
                            MarkdownParagraphComponent(markdownConfiguration: markdownConfiguration, nodeView: item, footnoteBlock: Option<FootnoteBlock>.None, fontCallback: fontCallback, tocListOnClick: tocListOnClick, imageCallback: imageCallback, componentWidth: componentWidth, isListTo: true, isDescList: true, paragraphComponents: markdownCacheConfiguration.paragraphComponents, customParagraphLineBuilder: customParagraphLineBuilder)
                        }
                    } else {
                        // TODO 其他节点
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
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
        // 术语和定义行之间间距
        .margin(bottom: markdownConfiguration.markdownTheme.descListTermAndDefMargins)
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
        refreshNodeViewDataSource(nodeView, refreshNodeViews, refreshNodeViewSize, dataSourceSize, nodeViewDataSource, "descterm", markdownCacheConfiguration, Option<HashMap<Int64, MarkdownTableBlockRowComponent>>.None)
    }
}
