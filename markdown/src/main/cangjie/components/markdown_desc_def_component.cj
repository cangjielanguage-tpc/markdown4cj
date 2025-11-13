/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

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
     * 上边距 - 单位vp
     */
    var marginTop: Float64

    /**
     * 下边距 - 单位vp
     */
    var marginBottom: Float64

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidth: Float64

    var markdownCacheConfiguration: MarkdownCacheConfiguration

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * TOC列表点击事件回调
     */
    var tocListOnClick: (Int64) -> Unit

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    /**
     * 懒加载数据源
     */
    var nodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        markdownCacheConfiguration.descDefComponent.add(this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        markdownCacheConfiguration.descDefComponent.removeIf({
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
                nodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is Paragraph) {
                        // 段落
                        ListItem() {
                            MarkdownParagraphComponent(
                                markdownConfiguration: markdownConfiguration,
                                nodeViews: item.children,
                                marginTop: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                marginBottom: markdownConfiguration.markdownTheme.blockOrderedAndBulletTopAndBottomMargins,
                                imageMarginTop: markdownConfiguration.markdownTheme.imageMarginTop,
                                imageMarginBottom: markdownConfiguration.markdownTheme.imageMarginBottom,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                tocListOnClick: tocListOnClick,
                                componentWidth: componentWidth,
                                isListTo:true,
                                indexList: indexAdd(indexList, idx),
                                paragraphComponents: markdownCacheConfiguration.paragraphComponents
                            )
                        }
                    } else {
                        // TODO 其他节点
                        ListItem() {
                            Text("")
                        }
                    }
                }
            )
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
        // 左边距
        .margin(left: markdownConfiguration.markdownTheme.descListDefIndentation)
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
            let index: Int64 = dataSourceSize - 1
            for(i in 0..index){
                if(getProp<Int64>(refreshNodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewDataSource.getAllData()[i],"nodeid",0)){
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                }
            }
            if(refreshNodeViews[index].node.getNodeType() != nodeViewDataSource.getData(index).node.getNodeType()){
                // 最后一条数据类型不相等
                nodeViewDataSource.replaceData(index, refreshNodeViews[index])
            } else {
                if (refreshNodeViews[index].node is Paragraph && nodeViewDataSource.getData(index).node is Paragraph) {
                    // 段落
                    for (data in markdownCacheConfiguration.paragraphComponents) {
                        if (isListItem(indexList, data.indexList, index)) {
                            data.refreshData(refreshNodeViews[index].children)
                        }
                    }
                } else {
                    // 其他节点
                    nodeViewDataSource.replaceData(index, refreshNodeViews[index])
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
