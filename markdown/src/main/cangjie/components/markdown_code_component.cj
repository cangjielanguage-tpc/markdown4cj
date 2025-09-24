/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 单独代码块自定义控件
 */
@Component
class MarkdownCodeComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 代码内容
     */
    @State
    var codeText: String = ""

    /**
     * 代码类型
     */
    @State
    var info: Option<String> = Option<String>.None

    /**
     * 定位需要的数组
     */
    var indexList: ArrayList<Int64> = ArrayList<Int64>()

    /**
     * 代码列表
     */
    @State
    var lineStrArray: StringDataSource = StringDataSource(ArrayList<String>())

    /**
     * 代码列表
     */
    @State
    var lineInt64Array: StringDataSource = StringDataSource(ArrayList<String>())

    /**
     * list控制器
     */
    let scroller1: Scroller = Scroller()

    /**
     * list控制器
     */
    let scroller2: Scroller = Scroller()

    var CodeComponents: ArrayList<MarkdownCodeComponent>

    var CodeTextComponents: ArrayList<MarkdownCodeTextComponent>

    /**
     * 长度
     */
    var size: Int64 = -1

    @State
    var reachBottom: Bool = true

    var chatTouch: Bool = false

    protected override func aboutToAppear(): Unit {
        refreshData(codeText, info)
        CodeComponents.add(this)
    }

    protected override func aboutToDisappear(): Unit {
        CodeComponents.removeIf(
            {
                predicate => if (predicate.indexList == indexList && predicate.codeText == codeText) {
                    true
                } else {
                    false
                }
            })
    }

    func build() {
        Column() {
            codeBlockButtonComponent()
            Row() {
                List(scroller: scroller1) {
                    LazyForEach(
                        lineInt64Array,
                        itemGeneratorFunc: {
                            item: String, idx: Int64 => ListItem() {
                                Text((idx + 1).toString())
                                    // 设置文本颜色
                                    .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                    // 设置文本尺寸
                                    .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                                    // 设置行高
                                    .lineHeight(markdownConfiguration.markdownTheme.codeBlockLineHeight)
                                    // 设置多行文本的文本对齐方式
                                    .textAlign(TextAlign.End)
                                    // 设置文本的最大行数
                                    .maxLines(1)
                                    // 设置文本超长时的显示方式
                                    .textOverflow(TextOverflow.Ellipsis)
                            }
                        }
                    )
                }
                // 设置组件自身的宽度
                .height(100.percent)
                // 设置内边距属性
                .padding(left: 8, right: 8)
                // 设置组件自身的宽度
                .width(markdownConfiguration.markdownTheme.separateCodeBlockWidth)
                // 设置边框的宽度
                .borderWidth(EdgeWidths(right: markdownConfiguration.markdownTheme.thematicBreakHeight.vp))
                // 设置元素的边框样式
                .borderStyle(BorderStyle.Solid)
                // 设置边框的颜色
                .borderColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                // 设置滚动条状态
                .scrollBar(BarState.Off)
                // 设置ListItem在List交叉轴方向的布局方式
                .alignListItem(ListItemAlign.End)
                // 设置组件是否可交
                .enabled(false)
                // 嵌套滚动选项。设置向前向后两个方向上的嵌套滚动模式，实现与父组件的滚动联动。
                .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))
                Scroll() {
                    Column() {
                        List(scroller: scroller2) {
                            LazyForEach(
                                lineStrArray,
                                itemGeneratorFunc: {
                                    item: String, idx: Int64 => ListItem() {
                                        MarkdownCodeTextComponent(
                                            markdownConfiguration: markdownConfiguration,
                                            codeText: item,
                                            info: info,
                                            idx: idx,
                                            indexList: indexAdd(indexList, idx),
                                            CodeTextComponents: CodeTextComponents
                                        )
                                    }
                                }
                            )
                        }
                        // 设置组件自身的宽度
                        .height(100.percent)
                        // 设置滚动条状态
                        .scrollBar(BarState.Off)
                        // 设置组件的滑动效果
                        .edgeEffect(EdgeEffect.None)
                        // 列表到底末尾位置时触发
                        .onReachEnd {
                            => reachBottom = true
                        }
                        // 列表滑动时触发
                        .onScroll {
                            offset, _ =>
                            scroller1.scrollTo(xOffset: 0.0, yOffset: scroller2.currentOffset().yOffset)
                            checkScroll(offset)
                        }
                        // 触摸动作触发该事件
                        .onTouch {
                            evt => chatOnTouch(evt)
                        }
                        // 嵌套滚动选项。设置向前向后两个方向上的嵌套滚动模式，实现与父组件的滚动联动。
                        .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))
                    }
                    // 设置组件自身的宽度
                    .height(100.percent)
                }
                // 设置滚动方法
                .scrollable(ScrollDirection.Horizontal)
                // 设置滚动条状态
                .scrollBar(BarState.Off)
                // 设置元素内容的对齐方式
                .align(Alignment.Start)
                // 设置组件自身的宽度
                .width(100.percent)
                // 设置组件自身的宽度
                .height(100.percent)
                // 嵌套滚动选项。设置向前向后两个方向上的嵌套滚动模式，实现与父组件的滚动联动。
                .nestedScroll(NestedScrollOptions(NestedScrollMode.PARENT_FIRST, NestedScrollMode.PARENT_FIRST))
            }
            // 设置组件自身的宽度
            .width(100.percent)
            // 设置组件自身的宽度
            .height(100.percent)
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置组件自身的宽度
        .height(100.percent)
        // 设置内边距属性
        .padding(bottom: bottomSize())
        // 设置圆角
        .borderRadius(markdownConfiguration.markdownTheme.codeBlockRadius)
        // 设置背景色
        .backgroundColor(codeBackgroundColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
    }

    func bottomSize():Float64{
        if (markdownConfiguration.markdownTheme.codeCopyIcon.isSome() || markdownConfiguration.markdownTheme.codeFullScreenIcon.isSome()) {
            return 50.0
        }else {
            return 20.0
        }
    }

    /**
     * 复制按钮和全屏按钮部分
     */
    @Builder
    func codeBlockButtonComponent() {
        Row() {
            if (codeText.trimAscii().size > 0) {
                // 设置图片的数据源
                if (let Some(i) <- info) {
                    Row() {
                        Text(i)
                            // 设置字体颜色
                            .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                            // 设置字体大小
                            .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                            // 设置外边距
                            .margin(left: 8)
                            // 设置文本的最大行数
                            .maxLines(1)
                            // 设置文本超长时的显示方式
                            .textOverflow(TextOverflow.Ellipsis)
                            // 是否隐藏
                            .visibility(isVisibility(!markdownConfiguration.markdownTheme.isSeparateCodeBlock))
                    }
                    // 设置宽度
                    .width(30.percent)
                    // 设置子组件在水平方向上的对齐格式
                    .justifyContent(FlexAlign.Start)
                } else {
                    Row()
                        // 设置宽度
                        .width(30.percent)
                        // 设置子组件在水平方向上的对齐格式
                        .justifyContent(FlexAlign.Start)
                }

                Row() {
                    if (markdownConfiguration.markdownTheme.codeCopyIcon.isSome()) {
                        Row() {
                            Image(markdownConfiguration.markdownTheme.codeCopyIcon())
                                // 设置组件自身的宽度
                                .width(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                // 设置组件自身的高度
                                .height(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                // 设置图片的缩放类型
                                .objectFit(ImageFit.Contain)

                            Row()
                                // 设置宽度
                                .width(5)

                            Text("复制代码")
                                // 设置字体颜色
                                .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                // 设置字体大小
                                .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                                // 设置容器元素绘制区域内的子元素的对齐方式
                                .align(Alignment.End)
                                // 设置文本的最大行数
                                .maxLines(1)
                                // 设置文本超长时的显示方式
                                .textOverflow(TextOverflow.Ellipsis)
                                // 设置外边距
                                .margin(right: 4)
                        }
                        // 设置子组件在水平方向上的对齐格式
                        .justifyContent(FlexAlign.End)
                        // 点击动作触发该方法调用
                        .onClick {evt => codeCopyOnClick(codeText, markdownConfiguration.codeCopyCallback)}
                    }

                    if (markdownConfiguration.markdownTheme.codeFullScreenIcon.isSome()) {
                        Row() {
                            Image(markdownConfiguration.markdownTheme.codeFullScreenIcon())
                                // 设置组件自身的宽度
                                .width(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                // 设置组件自身的高度
                                .height(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                                // 设置外边距属性
                                .margin(left: 4)
                                // 设置图片的缩放类型
                                .objectFit(ImageFit.Contain)

                            Row()
                                // 设置宽度
                                .width(5)

                            Text("全屏代码")
                                // 设置字体颜色
                                .fontColor(indentedCodeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.markdownTheme.prismTheme))
                                // 设置字体大小
                                .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
                                // 设置容器元素绘制区域内的子元素的对齐方式
                                .align(Alignment.End)
                                // 设置文本的最大行数
                                .maxLines(1)
                                // 设置文本超长时的显示方式
                                .textOverflow(TextOverflow.Ellipsis)
                                // 设置外边距
                                .margin(right: 4)
                        }
                        // 设置子组件在水平方向上的对齐格式
                        .justifyContent(FlexAlign.End)
                        // 控制当前组件显示或隐藏
                        .visibility(isVisibility(markdownConfiguration.markdownTheme.isCodeFullScreen))
                        // 点击动作触发该方法调用
                        .onClick {
                            evt => codeFullScreenOnClick(codeText, info, markdownConfiguration.codeFullScreenCallback)
                        }
                    }
                }
                // 设置宽度
                .width(70.percent)
                // 设置子组件在水平方向上的对齐格式
                .justifyContent(FlexAlign.End)
            }
        }
        // 设置外边距属性
        .margin(top: 8.0, right: 8.0, bottom: markdownConfiguration.markdownTheme.codeBlockTypeTextPadding)
        // 设置子组件在垂直方向上的对齐格式
        .alignItems(VerticalAlign.Center)
    }

    /**
     * 是否滑动到底部
     */
    func scrollChatIfAtBottom() {
        if (reachBottom) {
            scroll2Bottom()
        }
    }

    /**
     * 滑动到底部
     */
    func scroll2Bottom() {
        scroller2.scrollEdge(Edge.Bottom)
    }

    /**
     * 判断滑动距离和是否手指触摸
     */
    func checkScroll(offset: Float64) {
        if (offset < -0.5 && chatTouch) {
            reachBottom = false
        }
    }

    /**
     * 手指触摸判断
     */
    func chatOnTouch(evt: TouchEvent) {
        if (let TouchType.Down <- evt.eventType) {
            chatTouch = true
        } else if (let TouchType.Up <- evt.eventType) {
            chatTouch = false
        }
    }

    /**
     * 数据刷新
     */
    public func refreshData(codeText: String, info: Option<String>): Unit {
        this.codeText = codeText
        this.info = info
        let arr = ArrayList<String>()
        codeText.lines().forEach({
            s => arr.add(s)
        })
        let refreshNodeViewSize = arr.size // 刷新进来的数据长度
        let dataSourceSize = lineStrArray.totalCount() // 页面缓存的数据长度
        if (markdownConfiguration.markdownTheme.separateCodeIsBottom) {
            scrollChatIfAtBottom()
        }
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for(i in 0..dataSourceSize){
                if(lineStrArray.getData(i) != arr[i]){
                    lineStrArray.replaceData(i, arr[i])
                    lineInt64Array.replaceData(i, arr[i])
                }
            }
            // 循环添加新数据
            for(i in dataSourceSize..refreshNodeViewSize){
                lineStrArray.addData(arr[i])
                lineInt64Array.addData(arr[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            for(i in 0..dataSourceSize){
                if(lineStrArray.getData(i) != arr[i]){
                    lineStrArray.replaceData(i, arr[i])
                    lineInt64Array.replaceData(i, arr[i])
                }
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for(i in 0..refreshNodeViewSize){
                if(lineStrArray.getData(i) != arr[i]){
                    lineStrArray.replaceData(i, arr[i])
                    lineInt64Array.replaceData(i, arr[i])
                }
            }
            // 循环删除多余的旧数据
            for(i in dataSourceSize - 1..=refreshNodeViewSize : -1){
                lineStrArray.deleteData(i)
                lineInt64Array.deleteData(i)
            }
        }
        size = lineStrArray.totalCount() // 更新列表长度
    }
}
