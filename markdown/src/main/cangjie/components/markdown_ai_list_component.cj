/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)、块引用自定义控件
 */
@Component
public class MarkdownAIListComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 列表内容数据
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
     * 是无序列表还是有序列表 - true：无序列表，fasle：有序列表
     */
    var isOrdered: Bool

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
     * 视频点击事件
     */
    var videoCallback: (String) -> Unit

    /**
     * 缓存的数据
     */
    var markdownAICacheConfiguration: MarkdownAICacheConfiguration

    /**
     * 懒加载数据源
     */
    var nodeViewAIDataSource: NodeViewAIDataSource = NodeViewAIDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        markdownAICacheConfiguration.listComponents.add(this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        markdownAICacheConfiguration
            .listComponents
            .removeIf({
                predicate => if (predicate.indexList == indexList && predicate.size == size) {
                    true
                } else {
                    false
                }
            })
    }

    func build() {
        List() {
            LazyForEach(
                nodeViewAIDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        Row() {
                            if (isOrdered) {
                                if (item.node is CommonmarkListItem) {
                                    // 普通有序列表
                                    listPrefixTextINCComponent(item, true, markdownAIConfiguration)
                                }
                            } else {
                                if (item.node is TaskListItem) {
                                    // 任务列表
                                    listPrefixCheckboxINCComponent(item, markdownAIConfiguration)
                                } else if (item.node is CommonmarkListItem) {
                                    // 普通无序列表
                                    listPrefixTextINCComponent(item, false, markdownAIConfiguration)
                                }
                            }
                            MarkdownAIListItemComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                nodeViews: item.children,
                                marginTop: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                marginBottom: markdownAIConfiguration.markdownAITheme.blockTopAndBottomMargins,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                videoCallback: videoCallback,
                                componentWidth: componentWidth,
                                indexList: indexAdd(indexList, idx),
                                markdownAICacheConfiguration: markdownAICacheConfiguration
                            )
                        }
                        // 在垂直方向上子组件的对齐格式。
                        .alignItems(VerticalAlign.Top)
                        // 设置子组件在水平方向上的对齐格式。
                        .justifyContent(FlexAlign.Start)
                    }
                    // 对子组件进行重新布局
                    .layoutWeight(1)
                },
                keyGeneratorFunc:{
                     item: NodeView, idx: Int64 => return "${idx}-${getProp<Int64>(item,"nodeid",0)}"
                }
            )
        }
        // 块内容前的起始边距
        .margin(top: marginTop, bottom: marginBottom)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
    }

    /**
     * 数据刷新
     */
    public func refreshData(refreshNodeViews: ArrayList<NodeView>): Unit {
        let refreshNodeViewSize: Int64 = refreshNodeViews.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = nodeViewAIDataSource.totalCount() // 页面缓存的数据长度
        // 增量加载
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for(i in 0..dataSourceSize){
                if(getProp<Int64>(refreshNodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewAIDataSource.getAllData()[i],"nodeid",0)){
                    nodeViewAIDataSource.replaceData(i, refreshNodeViews[i])
                }
            }
            // 循环添加新数据
            for(i in dataSourceSize..refreshNodeViewSize){
                nodeViewAIDataSource.addData(refreshNodeViews[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            let indexItem: Int64 = dataSourceSize - 1
            for(i in 0..indexItem){
                if(getProp<Int64>(refreshNodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewAIDataSource.getAllData()[i],"nodeid",0)){
                    nodeViewAIDataSource.replaceData(i, refreshNodeViews[i])
                }
            }
            for (data in markdownAICacheConfiguration.listItemComponents) {
                if (isListItem(indexList, data.indexList, indexItem)) {
                    data.refreshData(refreshNodeViews[refreshNodeViewSize - 1].children)
                }
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for(i in 0..refreshNodeViewSize){
                if(getProp<Int64>(refreshNodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewAIDataSource.getAllData()[i],"nodeid",0)){
                    nodeViewAIDataSource.replaceData(i, refreshNodeViews[i])
                }
            }
            // 循环删除多余的旧数据
            for(i in dataSourceSize - 1..=refreshNodeViewSize : -1){
                nodeViewAIDataSource.deleteData(i)
            }
        }
        size = nodeViewAIDataSource.totalCount() // 更新列表长度
    }
}
