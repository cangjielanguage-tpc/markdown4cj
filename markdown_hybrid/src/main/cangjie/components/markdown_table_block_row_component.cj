/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 表格Row控件
 */
@Component
class MarkdownTableBlockRowComponent {
    /**
     * markdown配置
     */
    var tableBlockRowMarkdownConfiguration: MarkdownConfiguration

    /**
     * 表格Row控件自身节点
     */
    @Prop
    var tableBlockRowNodeView: NodeView

    /**
     * 控件宽度 - 单位vp
     */
    @Prop
    var tableBlockRowComponentWidth: Float64

    /**
     * 缓存的表格Row控件数据
     */
    var tableBlockRowComponents: HashMap<Int64, MarkdownTableBlockRowComponent>

    /**
     * 缓存的表格Cell控件数据
     */
    var tableBlockCellComponents: HashMap<Int64, MarkdownTableBlockCellComponent>

    /**
     * 自定义行内表格Cell控件
     */
    @BuilderParam
    var tableBlockRowCustomTableLineBuilder: (NodeView, Int64) -> Unit

    /**
     * 图片点击事件
     */
    var tableBlockRowImageCallback: (String) -> Unit

    /**
     * 脚注点击事件
     */
    var tableBlockRowFootnoteCallback: (String) -> Unit

    /**
     * 表格的第几行
     */
    var tableBlockRowRow: Int64

    /**
     * 表格总共有几列
     */
    var tableBlockRowCellSize: Int64

    /**
     * 表格宽度列表
     */
    @Prop
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass>

    /**
     * 数据源
     */
    @State
    var tableBlockRowNodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    protected override func aboutToAppear(): Unit {
        refreshTableBlockRowData(tableBlockRowNodeView) // 初始化刷新数据
        tableBlockRowComponents.add(tableBlockRowNodeView.nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = tableBlockRowComponents.get(tableBlockRowNodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                tableBlockRowComponents.remove(tableBlockRowNodeView.nodeHash)
            }
        } else {
            tableBlockRowComponents.remove(tableBlockRowNodeView.nodeHash)
        }
    }

    func build() {
        Row() {
            ForEach(
                tableBlockRowNodeViewList,
                itemGeneratorFunc: {
                    nodeview: NodeView, idx: Int64 => if (nodeview.nodeType == "TableCell") {
                        // 表格Cell节点
                        MarkdownTableBlockCellComponent(
                            tableBlockCellMarkdownConfiguration: tableBlockRowMarkdownConfiguration,
                            tableBlockCellNodeView: nodeview,
                            tableBlockCellComponentWidth: tableBlockRowComponentWidth,
                            tableBlockCellComponents: tableBlockCellComponents,
                            tableBlockCellCustomTableLineBuilder: tableBlockRowCustomTableLineBuilder,
                            tableBlockCellImageCallback: tableBlockRowImageCallback,
                            tableBlockCellFootnoteCallback: tableBlockRowFootnoteCallback,
                            tableBlockCellRow: tableBlockRowRow,
                            tableBlockCellCell: idx,
                            tableBlockCellCellSize: tableBlockRowCellSize,
                            cellWidthArrayIndexed: cellWidthArrayIndexed,
                        )
                    } else {
                        // 其他节点
                        Text("")
                    }
                },
                keyGeneratorFunc: {
                    tableBlockRowNodeView: NodeView, idx: Int64 => return "${idx}-${tableBlockRowNodeView.nodeHash}-${tableBlockRowNodeView.contentHash}"
                }
            )
        }
    }

    /**
     * 表格Row控件数据刷新
     *
     * @param tableBlockRowNodeView 刷新的新数据
     */
    public func refreshTableBlockRowData(tableBlockRowNodeView: NodeView): Unit {
        this.tableBlockRowNodeView = tableBlockRowNodeView
        let refreshNodeViewChildren = tableBlockRowNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let tableBlockRowNodeViewListSize: Int64 = tableBlockRowNodeViewList.size // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > tableBlockRowNodeViewListSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            refreshTableBlockRowDatas(tableBlockRowNodeViewListSize, refreshNodeViewChildren)
            // 循环添加新数据
            for (i in tableBlockRowNodeViewListSize..refreshNodeViewSize) {
                tableBlockRowNodeViewList.append(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == tableBlockRowNodeViewListSize) {
            // 新数据等于页面数据
            refreshTableBlockRowDatas(tableBlockRowNodeViewListSize, refreshNodeViewChildren)
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            refreshTableBlockRowDatas(refreshNodeViewSize, refreshNodeViewChildren)
            // 循环删除多余的旧数据
            for (i in tableBlockRowNodeViewListSize - 1..=refreshNodeViewSize : -1) {
                tableBlockRowNodeViewList.remove(i)
            }
        }
    }

    /**
     * 循环判断历史数据有没有做过修改
     *
     * @param size 长度
     * @param refreshNodeViews 刷新的数据
     */
    func refreshTableBlockRowDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = tableBlockRowNodeViewList[i]
            let newBlockHash = refreshNodeView.nodeHash
            let oldBlockHash = dataSourceNode.nodeHash
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            // 唯一ID是否相同
            if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                tableBlockRowNodeViewList[i] = refreshNodeView
            } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                tableBlockRowNodeViewList[i] = refreshNodeView
            } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                if (refreshNodeView.nodeType == "TableCell") {
                    // Cell
                    let cache = tableBlockCellComponents.get(newBlockHash)
                    if (let Some(v) <- cache) {
                        v.refreshTableBlockCellData(refreshNodeView)
                    }
                } else {
                    // 其他
                    tableBlockRowNodeViewList[i] = refreshNodeView
                }
            }
        }
    }
}
