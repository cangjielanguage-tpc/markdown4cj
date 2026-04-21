package markdown.components

import ohos.state_macro_manage.*

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)自定义控件
 */
@Component
public class MarkdownListComponent {
    var listMarkdownConfiguration: MarkdownConfiguration // markdown配置
    var listNodeView: NodeView // 列表节点
    @Prop
    var listComponentWidth: Float64 // 控件宽度 - 单位vp
    @Prop
    var listTableBlockComponentWidth: Float64 // 表格控件宽度 - 单位vp
    var listMarkdownCacheConfiguration: MarkdownCacheConfiguration // 缓存的数据
    var isOrdered: Bool // 是无序列表还是有序列表 - true：有序列表，fasle：无序列表
    @BuilderParam
    var listAdBuilder: (NodeView) -> Unit // 广告布局
    @BuilderParam
    var listVideoBuilder: (NodeView, MarkdownTheme, (String) -> Unit, (String, (String, Float64, Int64) -> Unit) -> Unit, ?(String) -> Unit, ?(String) -> Unit) -> Unit // 视频布局
    @BuilderParam
    var listAudioBuilder: (NodeView, MarkdownTheme, ?(String) -> Unit) -> Unit // 音频布局
    @BuilderParam
    var listCustomBlockBuilder: (NodeView, Int64) -> Unit // 自定义块结构布局
    @BuilderParam
    var listCustomHeadingLineBuilder: (NodeView, Int64) -> Unit // 自定义行内标题布局
    @BuilderParam
    var listCustomParagraphLineBuilder: (NodeView, Int64) -> Unit // 自定义行内段落布局
    @BuilderParam
    var listCustomTableLineBuilder: (NodeView, Int64) -> Unit // 自定义行内表格布局
    var listFootnoteCallback: (String) -> Unit // 脚注点击事件
    var listTocListOnClick: (Int64) -> Unit // TOC列表点击事件回调
    var listImageCallback: (String) -> Unit // 图片点击事件
    var listVideoCallback: (String) -> Unit // 视频点击事件
    var listDepth: Int64 // 列表深度
    var listNodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>()) // 懒加载数据源

    protected override func aboutToAppear(): Unit {
        refreshListData(listNodeView) // 初始化刷新数据
        listMarkdownCacheConfiguration.listComponents.add(listNodeView.nodeHash, this) // 缓存当前控件
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = listMarkdownCacheConfiguration.listComponents.get(listNodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                listMarkdownCacheConfiguration.listComponents.remove(listNodeView.nodeHash)
            }
        } else {
            listMarkdownCacheConfiguration.listComponents.remove(listNodeView.nodeHash)
        }
    }

    func build() {
        List(space: listChildSpacing(listMarkdownConfiguration.markdownTheme, listNodeView)) {
            LazyForEach(
                listNodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.nodeType == "ListItem") {
                        // ListItem
                        ListItem() {
                            Row() {
                                if (isOrdered) {
                                    // 普通有序列表
                                    listPrefixTextINCComponent(item, true, listMarkdownConfiguration, listDepth)
                                } else {
                                    // 普通无序列表
                                    listPrefixTextINCComponent(item, false, listMarkdownConfiguration, listDepth)
                                }
                                MarkdownListItemComponent(
                                    listItemMarkdownConfiguration: listMarkdownConfiguration,
                                    listItemNodeView: item,
                                    listItemComponentWidth: listComponentWidth,
                                    listItemTableBlockComponentWidth: listTableBlockComponentWidth,
                                    listItemMarkdownCacheConfiguration: listMarkdownCacheConfiguration,
                                    listItemAdBuilder: listAdBuilder,
                                    listItemVideoBuilder: listVideoBuilder,
                                    listItemAudioBuilder: listAudioBuilder,
                                    listItemCustomBlockBuilder: listCustomBlockBuilder,
                                    listItemCustomHeadingLineBuilder: listCustomHeadingLineBuilder,
                                    listItemCustomParagraphLineBuilder: listCustomParagraphLineBuilder,
                                    listItemCustomTableLineBuilder: listCustomTableLineBuilder,
                                    listItemFootnoteCallback: listFootnoteCallback,
                                    listItemTocListOnClick: listTocListOnClick,
                                    listItemImageCallback: listImageCallback,
                                    listItemVideoCallback: listVideoCallback,
                                    listItemDepth: listDepth
                                )
                            }
                            .alignItems(VerticalAlign.Top)
                            .justifyContent(FlexAlign.Start)
                        }
                        .layoutWeight(1)
                    } else if (item.nodeType == "TaskListItem") {
                        // TaskListItem
                        ListItem() {
                            Row() {
                                // 任务列表
                                listPrefixCheckboxINCComponent(item, listMarkdownConfiguration)
                                MarkdownListItemComponent(
                                    listItemMarkdownConfiguration: listMarkdownConfiguration,
                                    listItemNodeView: item,
                                    listItemComponentWidth: listComponentWidth,
                                    listItemTableBlockComponentWidth: listTableBlockComponentWidth,
                                    listItemMarkdownCacheConfiguration: listMarkdownCacheConfiguration,
                                    listItemAdBuilder: listAdBuilder,
                                    listItemVideoBuilder: listVideoBuilder,
                                    listItemAudioBuilder: listAudioBuilder,
                                    listItemCustomBlockBuilder: listCustomBlockBuilder,
                                    listItemCustomHeadingLineBuilder: listCustomHeadingLineBuilder,
                                    listItemCustomParagraphLineBuilder: listCustomParagraphLineBuilder,
                                    listItemCustomTableLineBuilder: listCustomTableLineBuilder,
                                    listItemFootnoteCallback: listFootnoteCallback,
                                    listItemTocListOnClick: listTocListOnClick,
                                    listItemImageCallback: listImageCallback,
                                    listItemVideoCallback: listVideoCallback,
                                    listItemDepth: listDepth
                                )
                            }
                            .alignItems(VerticalAlign.Top)
                            .justifyContent(FlexAlign.Start)
                        }
                        .layoutWeight(1)
                    } else {
                        // 其他节点
                        ListItem() {
                            Text("")
                        }
                    }
                },
                keyGeneratorFunc: {
                    listNodeView: NodeView, idx: Int64 => return "${idx}-${listNodeView.nodeHash}-${listNodeView.contentHash}"
                }
            )
        }
        .backgroundColor(listBackgroundColor(isOrdered, listMarkdownConfiguration.markdownTheme, listNodeView))
        .alignListItem(ListItemAlign.Start)
        .listDirection(Axis.Vertical)
        .width(100.percent)
        .padding(
            top: listPaddingTop(isOrdered, listMarkdownConfiguration.markdownTheme),
            right: listPaddingRight(isOrdered, listMarkdownConfiguration.markdownTheme),
            bottom: listPaddingBottom(isOrdered, listMarkdownConfiguration.markdownTheme),
            left: listPaddingLeft(isOrdered, listMarkdownConfiguration.markdownTheme)
        )
        .margin(
            top: listMarginTop(isOrdered, listMarkdownConfiguration.markdownTheme),
            right: listMarginRight(isOrdered, listMarkdownConfiguration.markdownTheme),
            bottom: listMarginBottom(isOrdered, listMarkdownConfiguration.markdownTheme),
            left: listMarginLeft(isOrdered, listMarkdownConfiguration.markdownTheme)
        )
    }

    /**
     * 无序/有序列表的前缀文本
     */
    @Builder
    func listPrefixTextINCComponent(item: NodeView, isBullet: Bool, markdownConfiguration: MarkdownConfiguration, listDepth: Int64) {
        if (DeviceInfo.sdkApiVersion >= 19) {
            listPrefixTextINCComponent19(item, isBullet, markdownConfiguration, listDepth)
        } else {
            listPrefixTextINCComponent18(item, isBullet, markdownConfiguration, listDepth)
        }
    }

    /**
     * 无序/有序列表的前缀文本
     */
    @Builder
    func listPrefixTextINCComponent18(item: NodeView, isBullet: Bool, markdownConfiguration: MarkdownConfiguration, listDepth: Int64) {
        Text(listPrefixStr(item, listDepth, isBullet, markdownConfiguration.markdownTheme))
            .fontFamily(listPrefixFontFamily(isBullet, markdownConfiguration.markdownTheme))
            .fontSize(listPrefixSize(isBullet, markdownConfiguration.markdownTheme))
            .fontWeight(listPrefixFontWeight(isBullet, markdownConfiguration.markdownTheme))
            .fontStyle(listPrefixFontStyle(isBullet, markdownConfiguration.markdownTheme))
            .fontColor(listPrefixColor(isBullet, markdownConfiguration.markdownTheme))
            .lineHeight(listPrefixLineHeight(isBullet, markdownConfiguration.markdownTheme))
            .margin(right: listPrefixSpacing(isBullet, markdownConfiguration.markdownTheme))
            .interopHalfLeading(true)
            .textAlign(TextAlign.Center)
    }

    /**
     * 无序/有序列表的前缀文本
     */
    @Builder
    func listPrefixTextINCComponent19(item: NodeView, isBullet: Bool, markdownConfiguration: MarkdownConfiguration, listDepth: Int64) {
        Text(listPrefixStr(item, listDepth, isBullet, markdownConfiguration.markdownTheme))
            .fontFamily(listPrefixFontFamily(isBullet, markdownConfiguration.markdownTheme))
            .fontSize(listPrefixSize(isBullet, markdownConfiguration.markdownTheme))
            .fontWeight(listPrefixFontWeight(isBullet, markdownConfiguration.markdownTheme))
            .fontStyle(listPrefixFontStyle(isBullet, markdownConfiguration.markdownTheme))
            .fontColor(listPrefixColor(isBullet, markdownConfiguration.markdownTheme))
            .lineHeight(listPrefixLineHeight(isBullet, markdownConfiguration.markdownTheme))
            .margin(right: listPrefixSpacing(isBullet, markdownConfiguration.markdownTheme))
            .halfLeading(true)
            .textAlign(TextAlign.Center)
    }

    /**
     * 任务列表的前缀多选框
     */
    @Builder
    func listPrefixCheckboxINCComponent(item: NodeView, markdownConfiguration: MarkdownConfiguration) {
        Checkbox()
            .height(markdownConfiguration.markdownTheme.bulletListTheme.bulletListCheckboxWidth)
            .width(markdownConfiguration.markdownTheme.bulletListTheme.bulletListCheckboxHeight)
            .margin(right: markdownConfiguration.markdownTheme.bulletListTheme.bulletListCheckboxSpacing)
            .shape(markdownConfiguration.markdownTheme.bulletListTheme.bulletListCheckboxShape)
            .selectedColor(markdownConfiguration.markdownTheme.bulletListTheme.bulletListCheckboxSelectedColor)
            .select(item.isTaskListSelected)
            .enabled(false)
    }

    /**
     * 数据刷新
     */
    public func refreshListData(listNodeView: NodeView): Unit {
        this.listNodeView = listNodeView
        let refreshNodeViewChildren = listNodeView.children // 子节点数据
        let refreshNodeViewSize: Int64 = refreshNodeViewChildren.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = listNodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            listNodeViewDataSource.clear()
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            refreshListDatas(dataSourceSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                listNodeViewDataSource.addData(refreshNodeViewChildren[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            refreshListDatas(dataSourceSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
        } else {
            // 新数据小于页面数据
            refreshListDatas(refreshNodeViewSize, refreshNodeViewChildren) // 循环判断历史数据有没有做过修改
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                listNodeViewDataSource.deleteData(i)
            }
        }
    }

    /**
     * 循环判断历史数据有没有做过修改
     *
     * @param size 长度
     * @param refreshNodes 刷新的数据
     */
    func refreshListDatas(size: Int64, refreshNodeViews: ArrayList<NodeView>): Unit {
        for (i in 0..size) {
            let refreshNodeView = refreshNodeViews[i]
            let dataSourceNode = listNodeViewDataSource.getData(i)
            let newNodeHash = refreshNodeView.nodeHash
            let oldNodeHash = dataSourceNode.nodeHash
            if (newNodeHash != oldNodeHash) {
                // 自身节点唯一ID不相同需要刷新数据
                listNodeViewDataSource.replaceData(i, refreshNodeView)
                continue
            }
            let newContentHash = refreshNodeView.contentHash
            let oldContentHash = dataSourceNode.contentHash
            if (newContentHash != oldContentHash) {
                // 子节点唯一ID不相同需要刷新子节点数据
                if (refreshNodeView.nodeType == "ListItem" || refreshNodeView.nodeType == "TaskListItem") {
                    // ListItem/TaskListItem节点
                    let listItemComponents = listMarkdownCacheConfiguration.listItemComponents
                    let cache = listItemComponents.get(newNodeHash)
                    if (let Some(v) <- cache) {
                        v.refreshListItemData(refreshNodeView)
                        listNodeViewDataSource.update(i, refreshNodeView)
                    } else {
                        listNodeViewDataSource.replaceData(i, refreshNodeView)
                    }
                    continue
                }
                // 其他节点
                listNodeViewDataSource.replaceData(i, refreshNodeView)
            }
        }
    }
}
