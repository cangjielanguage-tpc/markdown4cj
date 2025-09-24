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
     * 表格内容数据
     */
    var nodeViews: ArrayList<NodeView>

    /**
     * 定位需要的数组
     */
    var indexList: ArrayList<Int64> = ArrayList<Int64>()

    /**
     * 长度
     */
    var size: Int64 = -1

    /**
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

    /**
     * 控件宽度 - 单位px
     */
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
     * 表格
     */
    var tableComponents: ArrayList<MarkdownTableBlockComponent>

    /**
     * 表格行
     */
    var tableRowComponents: ArrayList<MarkdownTableBlockRowComponent>

    /**
     * 表格行内格子
     */
    var tableCellComponents: ArrayList<MarkdownTableBlockCellComponent>

    /**
     * 懒加载数据源
     */
    var nodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    @State
    var cellWidthArrayIndexed: ObservedArrayList<CellWidthArrayIndexedClass> = ObservedArrayList<CellWidthArrayIndexedClass>()

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        tableComponents.add(this)
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
        tableComponents.removeIf(
            {
                predicate => if (predicate.indexList == indexList && predicate.size == size) {
                    true
                } else {
                    false
                }
            })
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
                                nodeViews: tableHeaderOrBody.children,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                componentWidth: componentWidth,
                                idRow: idRow,
                                indexList: indexAdd(indexList, idRow),
                                tableRowComponents: tableRowComponents,
                                tableCellComponents: tableCellComponents,
                                dataRowSize: nodeViewDataSource.totalCount(),
                                cellWidthArrayIndexed: cellWidthArrayIndexed
                            )
                        }
                    },
                    keyGeneratorFunc:{
                         item: NodeView, idx: Int64 => return "${idx}-${getProp<Int64>(item,"nodeid",0)}"
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
    public func refreshData(refreshNodeViews: ArrayList<NodeView>): Unit {
        let refreshNodeViewSize = refreshNodeViews.size // 刷新进来的数据长度
        let dataSourceSize = nodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for(i in 0..dataSourceSize){
                if(getProp<Int64>(refreshNodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewDataSource.getAllData()[i],"nodeid",0)){
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                }
            }
            // 循环添加新数据
            for(i in dataSourceSize..refreshNodeViewSize){
                nodeViewDataSource.addData(refreshNodeViews[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            let indexRow: Int64 = dataSourceSize - 1
            for(i in 0..indexRow){
                if(getProp<Int64>(refreshNodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewDataSource.getAllData()[i],"nodeid",0)){
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                }
            }
            for (data in tableRowComponents) {
                if (isListItem(indexList, data.indexList, indexRow)) {
                    data.refreshData(refreshNodeViews[indexRow].children)
                }
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for(i in 0..refreshNodeViewSize){
                if(getProp<Int64>(refreshNodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewDataSource.getAllData()[i],"nodeid",0)){
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                }
            }
            // 循环删除多余的旧数据
            for(i in dataSourceSize - 1..=refreshNodeViewSize : -1){
                nodeViewDataSource.deleteData(i)
            }
        }
        size = nodeViewDataSource.totalCount() // 更新列表长度
    }
}
