/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown表格自定义控件
 */
@Component
class MarkdownTableBlockComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 表格节点
     */
    var nodeView: NodeView

    /**
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

    /**
     * 控件宽度
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
     * 缓存的表格
     */
    var tableComponents: HashMap<Int64, MarkdownTableBlockComponent>

    /**
     * 缓存的表格行
     */
    var tableRowComponents: HashMap<Int64, MarkdownTableBlockRowComponent>

    /**
     * 缓存的表格行内格子
     */
    var tableCellComponents: HashMap<Int64, MarkdownTableBlockCellComponent>

    /**
     * 懒加载数据源
     */
    var nodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    /**
     * 宽度列表
     */
    @State
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass> = ObservedArrayList<CellWidthArrayIndexedClass>()

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeView)
        // 缓存当前控件
        tableComponents.add(this.nodeView.nodeHash, this)
        cellSizeFunc()
    }

    func cellSizeFunc(){
        // 计算多少列
        var cellSize: Int64 = 0
        if (nodeViewDataSource.totalCount() > 0) {
            cellSize = nodeViewDataSource.getData(0).children.size
        }
        for (i in 0..cellSize) {
            cellWidthArrayIndexed.append(CellWidthArrayIndexedClass(minWidth: markdownConfiguration.markdownTheme.tableMinTextWidth, index: i))
        }
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        tableComponents.remove(this.nodeView.nodeHash)
    }

    func build() {
        Scroll() {
            List() {
                LazyForEach(
                    nodeViewDataSource,
                    itemGeneratorFunc: {
                        tableHeaderOrBody: NodeView, idRow: Int64 => ListItem() {
                            // 行信息
                            MarkdownTableBlockRowComponent(
                                markdownConfiguration: markdownConfiguration,
                                nodeView: tableHeaderOrBody,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                componentWidth: componentWidth,
                                idRow: idRow,
                                tableRowComponents: tableRowComponents,
                                tableCellComponents: tableCellComponents,
                                dataRowSize: nodeViewDataSource.totalCount(),
                                cellWidthArrayIndexed: cellWidthArrayIndexed
                            )
                        }
                    },
                    keyGeneratorFunc: {
                        item: NodeView, idx: Int64 => return "${idx}-${item.nodeHash}-${item.contentHash}"
                    }
                )
            }
            // 统一边框样式设置接口
            .border(width: markdownConfiguration.markdownTheme.tableBorderWidth.vp, color: markdownConfiguration.markdownTheme.tableBorderColor, style: BorderStyle.Solid, radius: markdownConfiguration.markdownTheme.tableRadius.vp)
            // 设置ListItem在List交叉轴方向的布局方式
            .alignListItem(ListItemAlign.Start)
        }
        // 设置滚动方向
        .scrollable(ScrollDirection.Horizontal)
        // 设置滚动条状态
        .scrollBar(BarState.Off)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
        // 设置内边距属性
        .padding(left: markdownConfiguration.markdownTheme.tableBorderWidth, right: markdownConfiguration.markdownTheme.tableBorderWidth)
    }

    /**
     * 数据刷新
     */
    public func refreshData(nodeView: NodeView): Unit {
        this.nodeView = nodeView
        let refreshNodeViews: ArrayList<NodeView> = tableList(nodeView.children)
        let refreshNodeViewSize: Int64 = refreshNodeViews.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = nodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        let cellSize = refreshNodeViews[0].children.size
        if(cellSize != cellWidthArrayIndexed.size){
            cellWidthArrayIndexed.clear()
            nodeViewDataSource.clear()
            nodeViewDataSource.addDatas(refreshNodeViews)
            cellSizeFunc()
            return
        }

        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..dataSourceSize) {
                let newBlockHash = refreshNodeViews[i].nodeHash
                let oldBlockHash = nodeViewDataSource.getData(i).nodeHash
                let newContentHash = refreshNodeViews[i].contentHash
                let oldContentHash = nodeViewDataSource.getData(i).contentHash
                // 唯一ID是否相同
                if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                    let cache = tableRowComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(refreshNodeViews[i])
                    }
                } else if (newBlockHash == oldBlockHash && newContentHash == oldContentHash) {
                }
            }
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                nodeViewDataSource.addData(refreshNodeViews[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            for (i in 0..dataSourceSize) {
                let newBlockHash = refreshNodeViews[i].nodeHash
                let oldBlockHash = nodeViewDataSource.getData(i).nodeHash
                let newContentHash = refreshNodeViews[i].contentHash
                let oldContentHash = nodeViewDataSource.getData(i).contentHash
                // 唯一ID是否相同
                if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                    let cache = tableRowComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(refreshNodeViews[i])
                    }
                } else if (newBlockHash == oldBlockHash && newContentHash == oldContentHash) {
                }
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..refreshNodeViewSize) {
                let newBlockHash = refreshNodeViews[i].nodeHash
                let oldBlockHash = nodeViewDataSource.getData(i).nodeHash
                let newContentHash = refreshNodeViews[i].contentHash
                let oldContentHash = nodeViewDataSource.getData(i).contentHash
                // 唯一ID是否相同
                if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                    let cache = tableRowComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshData(refreshNodeViews[i])
                    }
                } else if (newBlockHash == oldBlockHash && newContentHash == oldContentHash) {
                }
            }
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                nodeViewDataSource.deleteData(i)
            }
        }
    }
}
