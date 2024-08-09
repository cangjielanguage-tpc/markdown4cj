/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown围栏代码列表切换自定义控件
 */
@Component
class MarkdownCodeBlockListComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 所有数据
     */
    @State
    var arrayLists: ArrayList<ArrayList<PrismNodesParseRes>> = ArrayList<ArrayList<PrismNodesParseRes>>()

    /**
     * NodeView
     */
    var nodeView: NodeView

    /**
     * 代码类型列表标题
     */
    var strInfos: ArrayList<String>

    /**
     * 代码内容列表
     */
    var strText: ArrayList<String>

    /**
     * 代码真实类型列表
     */
    var strInfoText: ArrayList<String>

    /**
     * 选中Index
     */
    @State
    var idxSelect: Int64 = 0

    /**
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

    func build() {
        Column() {
            // 组合代码标题内容
            codeBlockTitleComponent()
            // 组合代码代码块内容
            codeBlockComponent()
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
        // 组件挂载显示时触发此回调
        .onAppear {=> stringCodeToResLists()}
    }

    /**
     * 组合代码标题部分
     */
    @Builder
    func codeBlockTitleComponent() {
        Scroll() {
            Row() {
                ForEach(
                    strInfos,
                    itemGeneratorFunc: {
                        item: String, idx: Int64 =>
                        // 设置文本内容
                        Text(item)
                            // 设置文本颜色
                            .fontColor(listCodeTextColor(idxSelect, idx, markdownConfiguration))
                            // 设置组件的背景色
                            .backgroundColor(listCodeBackgroupColor(idxSelect, idx, markdownConfiguration))
                            // 设置文本的最大行数
                            .maxLines(1)
                            // 设置文本尺寸
                            .fontSize(markdownConfiguration.markdownTheme.codeListTitleTextSize)
                            // 设置内边距属性
                            .padding(left: 14, right: 14, top: 5, bottom: 5)
                            // 点击动作触发该方法调用
                            .onClick {evt => idxSelect = idx}
                    }
                )
            }
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置滚动方法
        .scrollable(ScrollDirection.Horizontal)
        // 设置滚动条状态
        .scrollBar(BarState.Off)
        // 设置元素内容的对齐方式
        .align(Alignment.Start)
        // 设置外边距属性
        .margin(bottom: markdownConfiguration.markdownTheme.blockTopAndBottomMargins)
    }

    /**
     * 组合代码代码文本内容
     */
    @Builder
    func codeBlockTextComponent(items: ArrayList<PrismNodesParseRes>, idx: Int64) {
        Text() {
            ForEach(
                items,
                itemGeneratorFunc: {
                    item: PrismNodesParseRes, idx1: Int64 =>
                    // 设置文本内容
                    Span(item.getText())
                        // 设置文本颜色
                        .fontColor(codeTextColor(item, markdownConfiguration.markdownTheme, markdownConfiguration.prismTheme))
                        // 设置文本字符间距
                        .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
                }
            )
        }
        // 设置文本尺寸
        .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
        // 设置文本的字体列表
        .fontFamily(markdownConfiguration.markdownTheme.codeBlockTypeface)
        // 设置多行文本的文本对齐方式
        .textAlign(TextAlign.Start)
        // 设置内边距属性
        .padding(left: markdownConfiguration.markdownTheme.codeMultilineMargin)
        // 控制当前组件显示或隐藏
        .visibility(listCodeTextBool(idx, idxSelect))
    }

    /**
     * 组合代码代码文本列表内容
     */
    @Builder
    func codeBlockTextListComponent() {
        Column() {
            ForEach(
                arrayLists,
                itemGeneratorFunc: {
                    items: ArrayList<PrismNodesParseRes>, idx: Int64 =>
                    // 组合代码代码内容
                    codeBlockTextComponent(items, idx)
                }
            )
        }
    }

    /**
     * 组合代码代码部分
     */
    @Builder
    func codeBlockCodeComponent() {
        Scroll() {
            // 组合代码代码列表内容
            codeBlockTextListComponent()
        }
        // 设置组件的背景色
        .backgroundColor(codeBackgroundColor(markdownConfiguration.markdownTheme, markdownConfiguration.prismTheme))
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
        .padding(top: 10, bottom: 10)
    }

    /**
     * 组合代码复制按钮和全屏按钮部分
     */
    @Builder
    func codeBlockButtonComponent() {
        Row() {
            // 复制按钮 
            if (markdownConfiguration.markdownTheme.codeCopyIcon.isSome() && strText[idxSelect].trimAscii().size > 0) {
                // 设置图片的数据源
                Image(markdownConfiguration.markdownTheme.codeCopyIcon())
                    // 设置组件自身的宽度
                    .width(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                    // 设置组件自身的高度
                    .height(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Contain)
                    // 点击动作触发该方法调用
                    .onClick {evt => codeCopyOnClick(strText[idxSelect], markdownConfiguration.codeCopyCallback)}
            }
            // 全屏按钮
            if (markdownConfiguration.markdownTheme.codeFullScreenIcon.isSome() && strText[idxSelect].trimAscii().size > 0) {
                // 设置图片的数据源
                Image(markdownConfiguration.markdownTheme.codeFullScreenIcon())
                    // 设置组件自身的宽度
                    .width(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                    // 设置组件自身的高度
                    .height(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                    // 设置外边距属性
                    .margin(left: 8)
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Contain)
                    // 控制当前组件显示或隐藏
                    .visibility(isVisibility(markdownConfiguration.markdownTheme.isCodeFullScreen))
                    // 点击动作触发该方法调用
                    .onClick {evt => codeFullScreenOnClick(strText[idxSelect], strInfoText[idxSelect], markdownConfiguration.codeFullScreenCallback)}
            }
        }
        // 设置外边距属性
        .margin(top: 8, right: 8)
    }

    /**
     * 组合代码部分
     */
    @Builder
    func codeBlockComponent() {
        Stack(Alignment.TopEnd) {
            // 组合代码代码块内容
            codeBlockCodeComponent()
            // 复制按钮和全屏按钮内容
            codeBlockButtonComponent()
        }
        // 设置组件自身的宽度
        .width(100.percent)
    }

    /**
     * 代码数据高亮解析
     */
    func stringCodeToResLists() {
        let callback: (ArrayList<ArrayList<PrismNodesParseRes>>) -> Unit = {
            prismNodesParseResLists => launch {
                arrayLists = prismNodesParseResLists
            }
        }
        stringToResLists(nodeView, markdownConfiguration, strText, callback)
    }
}
