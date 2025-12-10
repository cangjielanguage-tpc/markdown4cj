/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown标题自定义控件
 */
@Component
class MarkdownHeadingComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 标题节点
     */
    var nodeView: NodeView

    /**
     * 控件宽度 - 单位px
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
     * 缓存的标题控件列表
     */
    var headingComponents: HashMap<Int64, MarkdownHeadingComponent>

    /**
     * 标题等级
     */
    @State
    var level: Int64 = 1

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    /**
     * 是否列表中的标题
     */
    var isListTo: Bool = false

    /**
     * 是否只有一条链接数据
     */
    @State
    var isOneLink: Bool = false

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(this.nodeView)
        // 缓存当前控件
        headingComponents.add(this.nodeView.nodeHash, this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = headingComponents.get(this.nodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                headingComponents.remove(this.nodeView.nodeHash)
            }
        } else {
            headingComponents.remove(this.nodeView.nodeHash)
        }
    }

    func build() {
        Column() {
            // 标题内容
            headingTitleComponent()

            // 一级二级标题是否显示下划线
            if ((level == 1 || level == 2) && markdownConfiguration.markdownTheme.headingBreakHeight > 0.0) {
                Divider()
                    // 设置分割线颜色
                    .color(markdownConfiguration.markdownTheme.headingBreakColor)
                    // 设置分割线宽度
                    .strokeWidth(markdownConfiguration.markdownTheme.headingBreakHeight)
            }
        }
        // 设置子组件在水平方向上的对齐格式
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式
        .justifyContent(FlexAlign.Center)
        // 设置组件自身的宽度
        .width(100.percent)
    }

    /**
     * 标题文字内容
     */
    @Builder
    func headingTitleComponent18() {
        Text() {
            ForEach(
                nodeViewList,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        headingTextComponent18(item, markdownConfiguration, level)
                    } else if (item.node is Footnote) {
                        // 脚注
                        headingFootnoteComponent18(item, markdownConfiguration, level, fontCallback)
                    } else if (item.node is Code) {
                        // 内联代码
                        inLineCodeSpanComponent(item, markdownConfiguration, true, true, false, 0)
                    } else if (item.node is CommonmarkLink) {
                        // 链接
                        linkSpanComponent(isOneLink, isListTo, level, item, markdownConfiguration, componentWidth, imageCallback, true, false, 0, markdownConfiguration.markdownTheme.isListLinkStyle)
                    } else if (item.node is HardLineBreak) {
                        // 硬换行
                        Span("\n")
                    } else if (item.node is SoftLineBreak) {
                        // 软换行
                        Span(spanSoftLineBreak(markdownConfiguration.markdownTheme.isLineBreak))
                    } else if (item.node is ImageHtmlNode) {
                        // HTML图片
                        htmlImageSpanComponent(item, markdownConfiguration, componentWidth, imageCallback)
                    } else if (item.node is StyleImage) {
                        //  图片Style节点
                        styleImageSpanComponent(item, markdownConfiguration, componentWidth, imageCallback)
                    } else if (item.node is CommonmarkImage) {
                        // 图片节点
                        coreImageSpanComponent(item, markdownConfiguration, componentWidth, imageCallback)
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        latexSpanComponent(item, markdownConfiguration, componentWidth)
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                },
                keyGeneratorFunc: {
                    item: NodeView, idx: Int64 => return "${idx}-${item.nodeHash}-${item.contentHash}"
                }
            )
        }
        // 设置多行文本的文本对齐方式
        .textAlign(TextAlign.Start)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置行高
        .lineHeight(tableLineHeight())
        // 自定义设置组件是否支持文本可复制粘贴
        .interopCopyOption(if (markdownConfiguration.markdownTheme.isOnCopy) {
            true
        } else {
            false
        })
        // 自定义长按文本内部区域弹出剪贴板后，点击剪切板复制按钮，触发该事件
        .interopOnCopy({
            str => if (let Some(v) <- markdownConfiguration.textCopyCallback) {
                v(str)
            }
        })
    }

    /**
     * 标题文字内容
     */
    @Builder
    func headingTitleComponent19() {
        Text() {
            ForEach(
                nodeViewList,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        headingTextComponent19(item, markdownConfiguration, level)
                    } else if (item.node is Footnote) {
                        // 脚注
                        headingFootnoteComponent19(item, markdownConfiguration, level, fontCallback)
                    } else if (item.node is Code) {
                        // 内联代码
                        inLineCodeSpanComponent(item, markdownConfiguration, true, true, false, 0)
                    } else if (item.node is CommonmarkLink) {
                        // 链接
                        linkSpanComponent(isOneLink, isListTo, level, item, markdownConfiguration, componentWidth, imageCallback, true, false, 0, markdownConfiguration.markdownTheme.isListLinkStyle)
                    } else if (item.node is HardLineBreak) {
                        // 硬换行
                        Span("\n")
                    } else if (item.node is SoftLineBreak) {
                        // 软换行
                        Span(spanSoftLineBreak(markdownConfiguration.markdownTheme.isLineBreak))
                    } else if (item.node is ImageHtmlNode) {
                        // HTML图片
                        htmlImageSpanComponent(item, markdownConfiguration, componentWidth, imageCallback)
                    } else if (item.node is StyleImage) {
                        //  图片Style节点
                        styleImageSpanComponent(item, markdownConfiguration, componentWidth, imageCallback)
                    } else if (item.node is CommonmarkImage) {
                        // 图片节点
                        coreImageSpanComponent(item, markdownConfiguration, componentWidth, imageCallback)
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        latexSpanComponent(item, markdownConfiguration, componentWidth)
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                },
                keyGeneratorFunc: {
                    item: NodeView, idx: Int64 => return "${idx}-${item.nodeHash}-${item.contentHash}"
                }
            )
        }
        // 设置多行文本的文本对齐方式
        .textAlign(TextAlign.Start)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置行高
        .lineHeight(tableLineHeight())
        // 支持设备内复制
        .copyOption(if (markdownConfiguration.markdownTheme.isOnCopy) {
            CopyOptions.LocalDevice
        } else {
            CopyOptions.None
        })
        // 长按文本内部区域弹出剪贴板后，点击剪切板复制按钮，触发该事件。目前文本复制仅支持文本。
        .onCopy({
            str => if (let Some(v) <- markdownConfiguration.textCopyCallback) {
                v(str)
            }
        })
    }

    /**
     * 标题文字内容
     */
    @Builder
    func headingTitleComponent() {
        if (DeviceInfo.sdkApiVersion >= 19) {
            headingTitleComponent19()
        } else {
            headingTitleComponent18()
        }
    }

    func tableLineHeight(): Float64 {
        return match (level) {
            case 1 => markdownConfiguration.markdownTheme.headingTextLineHeight1
            case 2 => markdownConfiguration.markdownTheme.headingTextLineHeight2
            case 3 => markdownConfiguration.markdownTheme.headingTextLineHeight3
            case 4 => markdownConfiguration.markdownTheme.headingTextLineHeight4
            case 5 => markdownConfiguration.markdownTheme.headingTextLineHeight5
            case 6 => markdownConfiguration.markdownTheme.headingTextLineHeight6
            case _ => markdownConfiguration.markdownTheme.headingTextLineHeight6
        }
    }

    /**
     * 数据刷新
     */
    public func refreshData(nodeView: NodeView): Unit {
        this.nodeView = nodeView
        this.level = (nodeView.node as Heading)().getLevel() // 等级
        let refreshNodeViews = nodeView.children
        let refreshNodeViewSize: Int64 = refreshNodeViews.size // 刷新进来的数据长度
        let nodeViewListSize: Int64 = nodeViewList.size // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > nodeViewListSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..nodeViewListSize) {
                let newBlockHash = refreshNodeViews[i].nodeHash
                let oldBlockHash = nodeViewList[i].nodeHash
                let newContentHash = refreshNodeViews[i].contentHash
                let oldContentHash = nodeViewList[i].contentHash
                // 唯一ID是否相同
                if (newBlockHash != oldBlockHash || newContentHash != oldContentHash) {
                    nodeViewList[i] = refreshNodeViews[i]
                }
            }
            // 循环添加新数据
            for (i in nodeViewListSize..refreshNodeViewSize) {
                nodeViewList.append(refreshNodeViews[i])
            }
        } else if (refreshNodeViewSize == nodeViewListSize) {
            // 新数据等于页面数据
            for (i in 0..nodeViewListSize) {
                let newBlockHash = refreshNodeViews[i].nodeHash
                let oldBlockHash = nodeViewList[i].nodeHash
                let newContentHash = refreshNodeViews[i].contentHash
                let oldContentHash = nodeViewList[i].contentHash
                // 唯一ID是否相同
                if (newBlockHash != oldBlockHash || newContentHash != oldContentHash) {
                    nodeViewList[i] = refreshNodeViews[i]
                }
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..refreshNodeViewSize) {
                let newBlockHash = refreshNodeViews[i].nodeHash
                let oldBlockHash = nodeViewList[i].nodeHash
                let newContentHash = refreshNodeViews[i].contentHash
                let oldContentHash = nodeViewList[i].contentHash
                // 唯一ID是否相同
                if (newBlockHash != oldBlockHash || newContentHash != oldContentHash) {
                    nodeViewList[i] = refreshNodeViews[i]
                }
            }
            // 循环删除多余的旧数据
            for (i in nodeViewListSize - 1..=refreshNodeViewSize : -1) {
                nodeViewList.remove(i)
            }
        }
        if (nodeViewList.size == 1 && nodeViewList[0].node is CommonmarkLink) {
            isOneLink = true
        } else {
            isOneLink = false
        }
    }
}
