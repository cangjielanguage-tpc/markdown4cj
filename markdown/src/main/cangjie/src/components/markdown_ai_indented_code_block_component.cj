/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown缩进代码块自定义控件
 */
@Component
class MarkdownAIIndentedCodeBlockComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 定位需要的数组
     */
    var indexList: ArrayList<Int64> = ArrayList<Int64>()

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
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

    /**
     * 缓存的第一层代码块控件列表
     */
    var indentedCodeComponents: ArrayList<MarkdownAIIndentedCodeBlockComponent>

    /**
     * 代码行数
     */
    @State
    @Watch[refreshLines]
    var lines: Int64 = 0

    /**
     * 代码行数显示数据列表
     */
    @State
    var lineArray: ObservedArrayList<Int64> = ObservedArrayList<Int64>()

    protected override func aboutToAppear(): Unit {
        refreshData(codeText, info)
        indentedCodeComponents.append(this)
    }

    protected override func aboutToDisappear(): Unit {
        indentedCodeComponents.removeIf(
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
                Column() {
                    ForEach(
                        lineArray,
                        itemGeneratorFunc: {
                            item: Int64, idx: Int64 => Text((idx + 1).toString())
                                // 设置文本颜色
                                .fontColor(indentedCodeTextColor(markdownAIConfiguration.markdownAITheme, markdownAIConfiguration.markdownAITheme.prismTheme))
                                // 设置文本尺寸
                                .fontSize(markdownAIConfiguration.markdownAITheme.codeBlockTextSize)
                                // 设置行高
                                .lineHeight(markdownAIConfiguration.markdownAITheme.codeBlockLineHeight)
                                // 设置文本的最大行数
                                .maxLines(1)
                                // 设置文本超长时的显示方式
                                .textOverflow(TextOverflow.Ellipsis)
                        }
                    )
                }
                // 设置外边距属性
                .margin(bottom: 10)
                // 设置内边距属性
                .padding(left: 8, right: 8)
                // 设置 Column 子组件在水平方向上的对齐格式
                .alignItems(HorizontalAlign.End)
                // 设置边框的宽度
                .borderWidth(EdgeWidths(right: markdownAIConfiguration.markdownAITheme.thematicBreakHeight.vp))
                // 设置元素的边框样式
                .borderStyle(BorderStyle.Solid)
                // 设置边框的颜色
                .borderColor(indentedCodeTextColor(markdownAIConfiguration.markdownAITheme, markdownAIConfiguration.markdownAITheme.prismTheme))
                // 控件显示和隐藏
                .visibility(isVisibility(markdownAIConfiguration.markdownAITheme.codeBlockLineNumberHide))
                codeBlockComponent()
            }
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
        // 设置圆角
        .borderRadius(markdownAIConfiguration.markdownAITheme.codeBlockRadius)
        // 设置背景色
        .backgroundColor(codeBackgroundColor(markdownAIConfiguration.markdownAITheme, markdownAIConfiguration.markdownAITheme.prismTheme))
    }

    /**
     * 代码块部分
     */
    @Builder
    func codeBlockComponent() {
        Scroll() {
            // 代码文本内容
            Text(codeText)
                // 设置文本颜色
                .fontColor(indentedCodeTextColor(markdownAIConfiguration.markdownAITheme, markdownAIConfiguration.markdownAITheme.prismTheme))
                // 设置文本尺寸
                .fontSize(markdownAIConfiguration.markdownAITheme.codeBlockTextSize)
                // 设置文本的字体列表
                .fontFamily(markdownAIConfiguration.markdownAITheme.codeBlockTypeface)
                // 设置多行文本的文本对齐方式
                .textAlign(TextAlign.Start)
                // 设置内边距属性
                .padding(left: markdownAIConfiguration.markdownAITheme.codeMultilineMargin)
                // 设置行高
                .lineHeight(markdownAIConfiguration.markdownAITheme.codeBlockLineHeight)
        }
        // 设置滚动方法
        .scrollable(ScrollDirection.Horizontal)
        // 设置滚动条状态
        .scrollBar(BarState.Off)
        // 设置元素内容的对齐方式
        .align(Alignment.Start)
        // 设置元素水平方向的布局
        .direction(Direction.Ltr)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置内边距属性
        .padding(bottom: 10)
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
                            .fontColor(indentedCodeodeBlockTypeTextColor(markdownAIConfiguration.markdownAITheme, markdownAIConfiguration.markdownAITheme.prismTheme))
                            // 设置字体大小
                            .fontSize(markdownAIConfiguration.markdownAITheme.codeBlockTextSize)
                            // 设置文本的最大行数
                            .maxLines(1)
                            // 设置文本超长时的显示方式
                            .textOverflow(TextOverflow.Ellipsis)
                            // 设置外边距
                            .margin(left: 8)
                    }
                    // 设置宽度
                    .width(30.percent)
                    // 设置子组件在水平方向上的对齐格式
                    .justifyContent(FlexAlign.Start)
                } else {
                    Row() {
                        Text(markdownAIConfiguration.markdownAITheme.codeBlockTypeTextStr)
                            // 设置字体颜色
                            .fontColor(indentedCodeodeBlockTypeTextColor(markdownAIConfiguration.markdownAITheme, markdownAIConfiguration.markdownAITheme.prismTheme))
                            // 设置字体大小
                            .fontSize(markdownAIConfiguration.markdownAITheme.codeBlockTextSize)
                            // 设置文本的最大行数
                            .maxLines(1)
                            // 设置文本超长时的显示方式
                            .textOverflow(TextOverflow.Ellipsis)
                            // 设置外边距
                            .margin(left: 8)
                    }
                    // 设置宽度
                    .width(30.percent)
                    // 设置子组件在水平方向上的对齐格式
                    .justifyContent(FlexAlign.Start)
                }
                Row() {
                    if (markdownAIConfiguration.markdownAITheme.codeCopyIcon.isSome()) {
                        Row() {
                            Image(markdownAIConfiguration.markdownAITheme.codeCopyIcon())
                                // 设置组件自身的宽度
                                .width(markdownAIConfiguration.markdownAITheme.iconWidthAndHeight)
                                // 设置组件自身的高度
                                .height(markdownAIConfiguration.markdownAITheme.iconWidthAndHeight)
                                // 设置图片的缩放类型
                                .objectFit(ImageFit.Contain)

                            Row()
                                // 设置宽度
                                .width(5)


                            if(markdownAIConfiguration.markdownAITheme.codeBlockIconTextHide){
                                Text("复制代码")
                                    // 设置字体颜色
                                    .fontColor(indentedCodeTextColor(markdownAIConfiguration.markdownAITheme, markdownAIConfiguration.markdownAITheme.prismTheme))
                                    // 设置字体大小
                                    .fontSize(markdownAIConfiguration.markdownAITheme.codeBlockTextSize)
                                    // 设置容器元素绘制区域内的子元素的对齐方式
                                    .align(Alignment.End)
                                    // 设置文本的最大行数
                                    .maxLines(1)
                                    // 设置文本超长时的显示方式
                                    .textOverflow(TextOverflow.Ellipsis)
                                    // 设置外边距
                                    .margin(right: 4)
                            }
                        }
                        // 设置子组件在水平方向上的对齐格式
                        .justifyContent(FlexAlign.End)
                        // 点击动作触发该方法调用
                        .onClick {evt => codeCopyOnClick(codeText, markdownAIConfiguration.codeCopyCallback)}
                    }

                    if (markdownAIConfiguration.markdownAITheme.codeFullScreenIcon.isSome()) {
                        Row() {
                            Image(markdownAIConfiguration.markdownAITheme.codeFullScreenIcon())
                                // 设置组件自身的宽度
                                .width(markdownAIConfiguration.markdownAITheme.iconWidthAndHeight)
                                // 设置组件自身的高度
                                .height(markdownAIConfiguration.markdownAITheme.iconWidthAndHeight)
                                // 设置外边距属性
                                .margin(left: 4)
                                // 设置图片的缩放类型
                                .objectFit(ImageFit.Contain)

                            Row()
                                // 设置宽度
                                .width(5)

                            if(markdownAIConfiguration.markdownAITheme.codeBlockIconTextHide){
                                Text("全屏代码")
                                    // 设置字体颜色
                                    .fontColor(indentedCodeTextColor(markdownAIConfiguration.markdownAITheme, markdownAIConfiguration.markdownAITheme.prismTheme))
                                    // 设置字体大小
                                    .fontSize(markdownAIConfiguration.markdownAITheme.codeBlockTextSize)
                                    // 设置容器元素绘制区域内的子元素的对齐方式
                                    .align(Alignment.End)
                                    // 设置文本的最大行数
                                    .maxLines(1)
                                    // 设置文本超长时的显示方式
                                    .textOverflow(TextOverflow.Ellipsis)
                                    // 设置外边距
                                    .margin(right: 4)
                            }
                        }
                        // 设置子组件在水平方向上的对齐格式
                        .justifyContent(FlexAlign.End)
                        // 控制当前组件显示或隐藏
                        .visibility(isVisibility(markdownAIConfiguration.markdownAITheme.isCodeFullScreen))
                        // 点击动作触发该方法调用
                        .onClick {
                            evt => codeFullScreenOnClick(codeText, info, markdownAIConfiguration.codeFullScreenCallback)
                        }
                    }
                }
                // 设置宽度
                .width(70.percent)
                // 设置子组件在水平方向上的对齐格式
                .justifyContent(FlexAlign.End)
            } else {
                Row()
                    // 设置宽度
                    .width(70.percent)
                    // 设置子组件在水平方向上的对齐格式
                    .justifyContent(FlexAlign.Start)
            }
        }
        // 设置外边距属性
        .margin(top: 8.0, right: 8.0, bottom: markdownAIConfiguration.markdownAITheme.codeBlockTypeTextPadding)
        // 设置子组件在垂直方向上的对齐格式
        .alignItems(VerticalAlign.Center)
    }

    func refreshLines(): Unit {
        lineArray.set(Array<Int64>(lines, item: 0))
    }

    /**
     * 数据刷新
     */
    public func refreshData(str: String, tp: Option<String>): Unit {
        codeText = str.trimRight("\n")
        lines = codeText.lines().count()
        lineArray.set(Array<Int64>(lines, item: 0))
        info = tp
    }
}
