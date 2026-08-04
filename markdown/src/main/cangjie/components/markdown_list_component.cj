package markdown.components

import ohos.state_macro_manage.*

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)自定义控件
 */
@Component
public class MarkdownListComponent {
    @Prop
    var listMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var listNodeView: NodeView // 列表节点
    @Prop
    var listComponentWidth: Float64 // 控件宽度 - 单位vp
    @Prop
    var listTableBlockComponentWidth: Float64 // 表格控件宽度 - 单位vp
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
    @BuilderParam
    var blockImageCardComponent: (?String, ?String, ?String) -> Unit = CustomBlockImageBuilder  //自定义卡片布局块级图片
    @BuilderParam
    var blockLinkCardComponent: (?String, ?String, ?String) -> Unit = CustomBlockLinkBuilder  //自定义卡片布局行内链接

    protected override func aboutToAppear(): Unit {
        MarkdownRefreshRegistry.register(listNodeView.nodeHash, refreshListData)
        refreshListData(listNodeView)
    }

    protected override func aboutToDisappear(): Unit {
        MarkdownRefreshRegistry.unregister(listNodeView.nodeHash)
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
                                    listItemDepth: listDepth,
                                    blockImageCardComponent: blockImageCardComponent,
                                    blockLinkCardComponent: blockLinkCardComponent
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
                                    listItemDepth: listDepth,
                                    blockImageCardComponent: blockImageCardComponent,
                                    blockLinkCardComponent: blockLinkCardComponent
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
                    item: NodeView, idx: Int64 => return "${idx}-${item.nodeHash}-${item.contentHash}"
                }
            )
        }
        .backgroundColor(listBackgroundColor(isOrdered, listMarkdownConfiguration.markdownTheme, listNodeView))
        .alignListItem(ListItemAlign.Start)
        .listDirection(Axis.Vertical)
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
            .transition(
               TransitionEffect.asymmetric(
                 if(listMarkdownConfiguration.markdownTheme.globalTheme.paragraphHeadingAnimationEnabled){
                    TransitionEffect.opacity(0.0).animation(AnimateParam(duration:listMarkdownConfiguration.markdownTheme.globalTheme.paragraphHeadingAnimationDuration))
                 }else{ TransitionEffect.IDENTITY}
                 ,
                 TransitionEffect.IDENTITY
               )
             )
             .onAppear({ =>
                // 段落加载动画开始回调在组件显示时触发
                if (listMarkdownConfiguration.markdownTheme.globalTheme.paragraphHeadingAnimationEnabled) {
                    if (let Some(cb) <- listMarkdownConfiguration.paragraphHeadingAnimationStart) {
                        cb()
                    }
                    let duration = listMarkdownConfiguration.markdownTheme.globalTheme.paragraphHeadingAnimationDuration
                    let endCb = listMarkdownConfiguration.paragraphHeadingAnimationEnd
                    Timer.once(Int64(duration) * Duration.millisecond, { =>
                        if (let Some(cb) <- endCb) {
                            cb()
                        }
                    })
                }
            })
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
            .transition(
               TransitionEffect.asymmetric(
                 if(listMarkdownConfiguration.markdownTheme.globalTheme.paragraphHeadingAnimationEnabled){
                    TransitionEffect.opacity(0.0).animation(AnimateParam(duration:listMarkdownConfiguration.markdownTheme.globalTheme.paragraphHeadingAnimationDuration))
                 }else{ TransitionEffect.IDENTITY}
                 ,
                 TransitionEffect.IDENTITY
               )
             )
             .onAppear({ =>
                // 段落加载动画开始回调在组件显示时触发
                if (listMarkdownConfiguration.markdownTheme.globalTheme.paragraphHeadingAnimationEnabled) {
                    if (let Some(cb) <- listMarkdownConfiguration.paragraphHeadingAnimationStart) {
                        cb()
                    }
                    let duration = listMarkdownConfiguration.markdownTheme.globalTheme.paragraphHeadingAnimationDuration
                    let endCb = listMarkdownConfiguration.paragraphHeadingAnimationEnd
                    Timer.once(Int64(duration) * Duration.millisecond, { =>
                        if (let Some(cb) <- endCb) {
                            cb()
                        }
                    })
                }
            })
    }

    /**
     * 数据刷新
     * 通过smartUpdateDataArray驱动UI更新，无需页面缓存。
     * keyGenerator含contentHash，hash变化时框架自动重建对应组件。
     */
    public func refreshListData(newNodeView: NodeView): Unit {
        this.listNodeView = newNodeView
        let refreshNodeViewChildren = listNodeView.children // 子节点数据
        if (refreshNodeViewChildren.size == 0) {
            listNodeViewDataSource.clear()
            return
        }
        listNodeViewDataSource.smartUpdateDataArray(refreshNodeViewChildren)
    }
}
