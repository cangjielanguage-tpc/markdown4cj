/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown段落自定义页面
 */
@Component
class MarkdownParagraphComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 段落节点
     */
    var nodeView: NodeView

    /**
     * 脚注
     */
    var footnoteBlock: Option<FootnoteBlock> = Option<FootnoteBlock>.None

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidth: Float64

    /**
     * 缓存的第一层段落控件列表
     */
    var paragraphComponents: HashMap<Int64, MarkdownParagraphComponent>

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
    @State
    var nodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    /**
     * 是否列表中的段落
     */
    var isListTo: Bool = false

    /**
     * 是否定义列表中的段落
     */
    var isDescList: Bool = false

    /**
     * 是否只有一条链接数据
     */
    @State
    var isOneLink: Bool = false

    /**
     * 自定义行内段落布局
     */
    @BuilderParam
    var customParagraphLineBuilder: (NodeView, Int64) -> Unit

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeView)
        // 缓存当前控件
        paragraphComponents.add(this.nodeView.nodeHash, this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = paragraphComponents.get(this.nodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                paragraphComponents.remove(this.nodeView.nodeHash)
            }
        } else {
            paragraphComponents.remove(this.nodeView.nodeHash)
        }
    }

    func build() {
        Column() {
            if (nodeViewList.size == 1 && (nodeViewList[0].node.getNodeType() == "Image") && !markdownConfiguration.markdownTheme.isImageMixedLayout) {
                if (markdownConfiguration.imageCallbackCallback.isNone()) {
                    if ((nodeViewList[0].node as CommonmarkImage)().getDestination().startsWith("./")){
                        MarkdownImageRawFileComponent(
                            imgRawFileConfig: markdownConfiguration,
                            imgRawFileDestination: (nodeViewList[0].node as CommonmarkImage)().getDestination(),
                            imgRawFileComponentWidth: componentWidth,
                            imgRawFileImgCb: imageCallback,
                            imgRawFileLinkCb: markdownConfiguration.linkCallback,
                            imgRawFileIsLink: nodeViewList[0].link.isSome(),
                            imgRawFileLinkUrl: if (nodeViewList[0].link.isSome()) {
                                nodeViewList[0].link().getDestination()
                            } else {
                                Option<String>.None
                            }
                        )
                    } else {
                        MarkdownImageUrlComponent(
                            imgUrlConfig: markdownConfiguration,
                            imgUrlDestination: (nodeViewList[0].node as CommonmarkImage)().getDestination(),
                            imgUrlComponentWidth: componentWidth,
                            imgUrlImgCb: imageCallback,
                            imgUrlLinkCb: markdownConfiguration.linkCallback,
                            imgUrlIsLink: nodeViewList[0].link.isSome(),
                            imgUrlLinkUrl: if (nodeViewList[0].link.isSome()) {
                                nodeViewList[0].link().getDestination()
                            } else {
                                Option<String>.None
                            }
                        )
                    }
                } else {
                    if ((nodeViewList[0].node as CommonmarkImage)().getDestination().startsWith("./")){
                        MarkdownImageRawFileCallbackComponent(
                            imgRawFileCbConfig: markdownConfiguration,
                            imgRawFileCbDestination: (nodeViewList[0].node as CommonmarkImage)().getDestination(),
                            imgRawFileCbComponentWidth: componentWidth,
                            imgRawFileCbImgCb: imageCallback,
                            imgRawFileCbLinkCb: markdownConfiguration.linkCallback,
                            imgRawFileCbIsLink: nodeViewList[0].link.isSome(),
                            imgRawFileCbLinkUrl: if (nodeViewList[0].link.isSome()) {
                                nodeViewList[0].link().getDestination()
                            } else {
                                Option<String>.None
                            }
                        )
                    } else {
                        MarkdownImageUrlCallbackComponent(
                            imgUrlCbConfig: markdownConfiguration,
                            imgUrlCbDestination: (nodeViewList[0].node as CommonmarkImage)().getDestination(),
                            imgUrlCbComponentWidth: componentWidth,
                            imgUrlCbImgCb: imageCallback,
                            imgUrlCbLinkCb: markdownConfiguration.linkCallback,
                            imgUrlCbIsLink: nodeViewList[0].link.isSome(),
                            imgUrlCbLinkUrl: if (nodeViewList[0].link.isSome()) {
                                nodeViewList[0].link().getDestination()
                            } else {
                                Option<String>.None
                            }
                        )
                    }
                }
            } else  if (nodeViewList.size == 1 && (nodeViewList[0].node.getNodeType() == "StyleImage") && !markdownConfiguration.markdownTheme.isImageMixedLayout) {
                if (markdownConfiguration.imageCallbackCallback.isNone()) {
                    if ((nodeViewList[0].node as CommonmarkImage)().getDestination().startsWith("./")){
                        MarkdownImageStyleRawFileComponent(
                            imgStyleRawFileConfig: markdownConfiguration,
                            imgStyleRawFileDestination: (nodeViewList[0].node as StyleImage)().getDestination(),
                            imgStyleRawFileComponentWidth: componentWidth,
                            imgStyleRawFileImgCb: imageCallback,
                            imgStyleRawFileLinkCb: markdownConfiguration.linkCallback,
                            imgStyleRawFileIsLink: nodeViewList[0].link.isSome(),
                            imgStyleRawFileLinkUrl: if (nodeViewList[0].link.isSome()) {
                                nodeViewList[0].link().getDestination()
                            } else {
                                Option<String>.None
                            },
                            imgStyleRawFileStyle: (nodeViewList[0].node as StyleImage)().styles
                        )
                    } else {
                        MarkdownImageStyleUrlComponent(
                            imgStyleUrlConfig: markdownConfiguration,
                            imgStyleUrlDestination: (nodeViewList[0].node as StyleImage)().getDestination(),
                            imgStyleUrlComponentWidth: componentWidth,
                            imgStyleUrlImgCb: imageCallback,
                            imgStyleUrlLinkCb: markdownConfiguration.linkCallback,
                            imgStyleUrlIsLink: nodeViewList[0].link.isSome(),
                            imgStyleUrlLinkUrl: if (nodeViewList[0].link.isSome()) {
                                nodeViewList[0].link().getDestination()
                            } else {
                                Option<String>.None
                            },
                            imgStyleUrlStyle: (nodeViewList[0].node as StyleImage)().styles
                        )
                    }
                } else {
                    if ((nodeViewList[0].node as CommonmarkImage)().getDestination().startsWith("./")){
                        MarkdownImageStyleRawFileCallBackComponent(
                            imgStyleRawFileCbConfig: markdownConfiguration,
                            imgStyleRawFileCbDestination: (nodeViewList[0].node as StyleImage)().getDestination(),
                            imgStyleRawFileCbComponentWidth: componentWidth,
                            imgStyleRawFileCbImgCb: imageCallback,
                            imgStyleRawFileCbLinkCb: markdownConfiguration.linkCallback,
                            imgStyleRawFileCbIsLink: nodeViewList[0].link.isSome(),
                            imgStyleRawFileCbLinkUrl: if (nodeViewList[0].link.isSome()) {
                                nodeViewList[0].link().getDestination()
                            } else {
                                Option<String>.None
                            },
                            imgStyleRawFileCbStyle: (nodeViewList[0].node as StyleImage)().styles
                        )
                    } else {
                        MarkdownImageStyleUrlCallbackComponent(
                            imgStyleUrlCbConfig: markdownConfiguration,
                            imgStyleUrlCbDestination: (nodeViewList[0].node as StyleImage)().getDestination(),
                            imgStyleUrlCbComponentWidth: componentWidth,
                            imgStyleUrlCbImgCb: imageCallback,
                            imgStyleUrlCbLinkCb: markdownConfiguration.linkCallback,
                            imgStyleUrlCbIsLink: nodeViewList[0].link.isSome(),
                            imgStyleUrlCbLinkUrl: if (nodeViewList[0].link.isSome()) {
                                nodeViewList[0].link().getDestination()
                            } else {
                                Option<String>.None
                            },
                            imgStyleUrlCbStyle: (nodeViewList[0].node as StyleImage)().styles
                        )
                    }
                }
            } else {
                paragraphComponent()
            }
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置子组件在水平方向上的对齐格式
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式
        .justifyContent(FlexAlign.Center)
    }

    /**
     * 段落文字内容
     */
    @Builder
    func paragraphComponent() {
        if (DeviceInfo.sdkApiVersion >= 19) {
            paragraphComponent19()
        } else {
            paragraphComponent18()
        }
    }

    /**
     * 段落文字内容
     */
    @Builder
    func paragraphComponent18() {
        Text() {
            if (footnoteBlock.isSome()) {
                Span("[^${footnoteBlock().noteid}]: ")
                    // 设置文本尺寸
                    .fontSize(markdownConfiguration.markdownTheme.paragraphTextSize)
                    // 设置文本的字体粗细
                    .fontWeight(FontWeight.W400)
                    // 设置文本颜色
                    .fontColor(markdownConfiguration.markdownTheme.paragraphTextColor)
            }
            ForEach(
                nodeViewList,
                itemGeneratorFunc: {
                    item18: NodeView, idx18: Int64 => paragraphListComponent(item18, idx18)
                },
                keyGeneratorFunc: {
                    item18: NodeView, idx18: Int64 => return "${idx18}-${item18.nodeHash}-${item18.contentHash}"
                }
            )
        }
        // 设置多行文本的文本对齐方式
        .textAlign(TextAlign.Start)
        // 设置文本是否将行间距平分至行的顶部与底部。
        .interopHalfLeading(true)
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
     * 段落文字内容
     */
    @Builder
    func paragraphComponent19() {
        Text() {
            if (footnoteBlock.isSome()) {
                Span("[^${footnoteBlock().noteid}]: ")
                    // 设置文本尺寸
                    .fontSize(markdownConfiguration.markdownTheme.paragraphTextSize)
                    // 设置文本的字体粗细
                    .fontWeight(FontWeight.W400)
                    // 设置文本颜色
                    .fontColor(markdownConfiguration.markdownTheme.paragraphTextColor)
            }
            ForEach(
                nodeViewList,
                itemGeneratorFunc: {
                    item19: NodeView, idx19: Int64 => paragraphListComponent(item19, idx19)
                },
                keyGeneratorFunc: {
                    item19: NodeView, idx19: Int64 => return "${idx19}-${item19.nodeHash}-${item19.contentHash}"
                }
            )
        }
        // 设置多行文本的文本对齐方式
        .textAlign(TextAlign.Start)
        // 设置文本是否将行间距平分至行的顶部与底部。
        .halfLeading(true)
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

    @Builder
    func paragraphListComponent(item: NodeView, index: Int64) {
        if (item.node is CommonmarkText) {
            // 文本
            if (DeviceInfo.sdkApiVersion >= 19) {
                paragraphTextComponent19(item, isDescList, markdownConfiguration)
            } else {
                paragraphTextComponent18(item, isDescList, markdownConfiguration)
            }
        } else if (item.node is HeadLink) {
            // TOC列表
            if (DeviceInfo.sdkApiVersion >= 19) {
                paragraphTocComponent19(item, isDescList, markdownConfiguration, tocListOnClick)
            } else {
                paragraphTocComponent18(item, isDescList, markdownConfiguration, tocListOnClick)
            }
        } else if (item.node is Footnote) {
            // 脚注
            if (DeviceInfo.sdkApiVersion >= 19) {
               paragraphFootnoteComponent19(item, isDescList, markdownConfiguration, fontCallback)
            } else {
                paragraphFootnoteComponent18(item, isDescList, markdownConfiguration, fontCallback)
            }
        } else if (item.node is Code) {
            // 内联代码
            inLineCodeSpanComponent(item, markdownConfiguration, item.strongEmphasis, false, isDescList, 1, 0)
        } else if (item.node is CommonmarkLink) {
            // 链接
            linkSpanComponent(isOneLink, isListTo, 0, item, markdownConfiguration, componentWidth, imageCallback, false, isDescList, 1, markdownConfiguration.markdownTheme.isListLinkStyle)
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
            customParagraphLineBuilder(item, index)
        }
    }

    /**
     * 数据刷新
     */
    public func refreshData(nodeView: NodeView): Unit {
        this.nodeView = nodeView
        refreshnodeViewList(this.nodeView, nodeViewList, Option<HashMap<Int64,MarkdownTableBlockCellComponent>>.None)
        if (nodeViewList.size == 1 && nodeViewList[0].node is CommonmarkLink) {
            isOneLink = true
        } else {
            isOneLink = false
        }
    }
}
