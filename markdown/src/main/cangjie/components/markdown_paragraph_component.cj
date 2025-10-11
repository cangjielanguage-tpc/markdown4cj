/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
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
     * 段落内容数据
     */
    var nodeViews: ArrayList<NodeView>

    /**
     * 定位需要的数组
     */
    var indexList: ArrayList<Int64> = ArrayList<Int64>()

    /**
     * 脚注
     */
    var footnoteBlock: Option<FootnoteBlock> = Option<FootnoteBlock>.None

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

    /**
     * 缓存的第一层段落控件列表
     */
    var paragraphComponents: ArrayList<MarkdownParagraphComponent>

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

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
     * 块引用背景颜色
     */
    var blockQuoteBackGroupColor: Option<Color> = Option<Color>.None

    /**
     * 图片上边距
     */
    var imageMarginTop: Float64 = 0.0

    /**
     * 图片下边距
     */
    var imageMarginBottom: Float64 = 0.0

    /**
     * 是否列表中的段落
     */
    var isListTo: Bool = false

    /**
     * 是否只有一条链接数据
     */
    @State
    var isOneLink: Bool = false

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeViews)
        // 缓存当前控件
        paragraphComponents.add(this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        paragraphComponents.removeIf(
            {
                predicate => if (predicate.indexList == indexList && predicate.size == size) {
                    true
                } else {
                    false
                }
            })
    }

    func build() {
        Column(){
            paragraphComponent()
        }
        // 设置外边距属性
        .margin(top: isMarginTop(), bottom: isMarginBottom())
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
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        paragraphTextComponent(
                            item,
                            markdownConfiguration
                        )
                    } else if (item.node is Footnote) {
                        // 脚注
                        paragraphFootnoteComponent(
                            item,
                            markdownConfiguration,
                            fontCallback
                        )
                    } else if (item.node is Code) {
                        // 内联代码
                        if (markdownConfiguration.markdownTheme.isCodeStyle) {
                            MarkdownCodeLineImageSpanComponent(
                                markdownConfiguration: markdownConfiguration,
                                strCode: (item.node as Code)().getLiteral(),
                                strUrl: linkUrl(item),
                                isFakeBoldText: item.strongEmphasis
                            )
                        } else {
                            paragraphCodeComponent(
                                item,
                                markdownConfiguration
                            )
                        }
                    } else if (item.node is CommonmarkLink) {
                        // 链接
                        if (isListTo && !markdownConfiguration.markdownTheme.isListLinkStyle && isOneLink && !markdownConfiguration.markdownTheme.isLinkStyle) {
                            if(getLinkString(item).isSome()){
                                paragraphLinkComponent(
                                    item,
                                    getLinkString(item)(),
                                    markdownConfiguration
                                )
                            }else{
                                Span("")
                            }
                        } else {
                            if ((item.node as CommonmarkLink)().getDestination().startsWith("http://") || (item.node as CommonmarkLink)().getDestination().startsWith("https://")) {
                                if(getLinkString(item).isSome()){
                                    if(getLinkString(item)().trimAscii().toRuneArray().size > 1){
                                        MarkdownLinkRectImageComponent(
                                            markdownConfiguration: markdownConfiguration,
                                            strText: getLinkString(item)().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownConfiguration.markdownTheme.linkRectImageBackGroupColor)
                                        )
                                    }else{
                                        MarkdownLinkCircleImageComponent(
                                            markdownConfiguration: markdownConfiguration,
                                            strText: getLinkString(item)().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownConfiguration.markdownTheme.linkCircleImageBackGroupColor)
                                        )
                                    }
                                }else{
                                    Span("")
                                }
                            } else {
                                if(getLinkString(item).isSome()){
                                    MarkdownLinkRectToolImageComponent(
                                        markdownConfiguration: markdownConfiguration,
                                        strText: getLinkString(item)(),
                                        strUrl: (item.node as CommonmarkLink)().getDestination(),
                                        strType: urlSafeBase64Decode((item.node as CommonmarkLink)().getDestination()),
                                        backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownConfiguration.markdownTheme.linkRectToolImageBackGroupColor)
                                    )
                                }else{
                                    Span("")
                                }
                            }
                        }
                    } else if (item.node is HardLineBreak) {
                        // 硬换行
                        Span("\n")
                    } else if (item.node is SoftLineBreak) {
                        // 软换行
                        Span(spanSoftLineBreak(markdownConfiguration.markdownTheme.isLineBreak))
                    } else if (item.node is ImageHtmlNode) {
                        // HTML图片
                        if (DeviceInfo.sdkApiVersion >= 15) {
                            MarkdownHtmlImageSpanComponent(
                                destination: (item.node as ImageHtmlNode)().getDestination(),
                                imagePlaceholder: markdownConfiguration.markdownTheme.imagePlaceholder,
                                imageWidth: strToFloat64((item.node as ImageHtmlNode)().getWidth()),
                                imageHeight: strToFloat64((item.node as ImageHtmlNode)().getHeight()),
                                componentWidth: componentWidth,
                                imageMarginTop: imageMarginTop,
                                imageMarginBottom: imageMarginBottom,
                                imageCallback: imageCallback
                            )
                        } else {
                            MarkdownHtmlImageSpan15Component(
                                destination: (item.node as ImageHtmlNode)().getDestination(),
                                imagePlaceholder: markdownConfiguration.markdownTheme.imagePlaceholder,
                                imageWidth: strToFloat64((item.node as ImageHtmlNode)().getWidth()),
                                imageHeight: strToFloat64((item.node as ImageHtmlNode)().getHeight()),
                                componentWidth: componentWidth,
                                imageMarginTop: imageMarginTop,
                                imageMarginBottom: imageMarginBottom,
                                imageCallback: imageCallback
                            )
                        }
                    } else if (item.node is CommonmarkImage) {
                        // 图片节点
                        if (markdownConfiguration.imageCallbackCallback.isNone()) {
                            if (DeviceInfo.sdkApiVersion >= 15) {
                                MarkdownImageSpanComponent(
                                    destination: (item.node as CommonmarkImage)().getDestination(),
                                    imagePlaceholder: markdownConfiguration.markdownTheme.imagePlaceholder,
                                    componentWidth: componentWidth,
                                    imageMarginTop: imageMarginTop,
                                    imageMarginBottom: imageMarginBottom,
                                    imageCallback: imageCallback,
                                    linkCallback: markdownConfiguration.linkCallback,
                                    isLink: item.link.isSome(),
                                    linkUrl: if (item.link.isSome()) {item.link().getDestination()} else {Option<String>.None},
                                    imageBorderRadius: markdownConfiguration.markdownTheme.imageBorderRadius
                                )
                            } else {
                                MarkdownImageSpan15Component(
                                    destination: (item.node as CommonmarkImage)().getDestination(),
                                    imagePlaceholder: markdownConfiguration.markdownTheme.imagePlaceholder,
                                    componentWidth: componentWidth,
                                    imageMarginTop: imageMarginTop,
                                    imageMarginBottom: imageMarginBottom,
                                    imageCallback: imageCallback,
                                    linkCallback: markdownConfiguration.linkCallback,
                                    isLink: item.link.isSome(),
                                    linkUrl: if (item.link.isSome()) {item.link().getDestination()} else {Option<String>.None},
                                    imageBorderRadius: markdownConfiguration.markdownTheme.imageBorderRadius
                                )
                            }
                        } else {
                            MarkdownImagePixelmapSpanComponent(
                                destination: (item.node as CommonmarkImage)().getDestination(),
                                imagePlaceholder: markdownConfiguration.markdownTheme.imagePlaceholder,
                                componentWidth: componentWidth,
                                imageMarginTop: imageMarginTop,
                                imageMarginBottom: imageMarginBottom,
                                imageCallback: imageCallback,
                                linkCallback: markdownConfiguration.linkCallback,
                                isLink: item.link.isSome(),
                                linkUrl: if (item.link.isSome()) {item.link().getDestination()} else {Option<String>.None},
                                imageCallbackCallback : markdownConfiguration.imageCallbackCallback(),
                                imageBorderRadius: markdownConfiguration.markdownTheme.imageBorderRadius
                            )
                        }
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        MarkdownLatexImageSpanComponent(
                            markdownConfiguration: markdownConfiguration,
                            componentWidth: componentWidth,
                            strLatexMath: (item.node as LatexMathNode)().latex,
                            backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownConfiguration.markdownTheme.latexMathBackGroupColor)
                        )
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                },
                keyGeneratorFunc:{
                     item: NodeView, idx: Int64 => return "${idx}-${getProp<Int64>(item,"nodeid",0)}"
                }
            )
        }
        // 设置多行文本的文本对齐方式
        .textAlign(TextAlign.Start)
        // 设置行高
        .lineHeight(markdownConfiguration.markdownTheme.paragraphTextLineHeight)
        // 自定义设置组件是否支持文本可复制粘贴
        .interopCopyOption(if (markdownConfiguration.markdownTheme.isOnCopy) { true } else { false })
        // 自定义长按文本内部区域弹出剪贴板后，点击剪切板复制按钮，触发该事件
        .interopOnCopy({
            str => if (markdownConfiguration.textCopyCallback.isSome()) {
                markdownConfiguration.textCopyCallback()(str)
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
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        paragraphTextComponent(
                            item,
                            markdownConfiguration
                        )
                    } else if (item.node is Footnote) {
                        // 脚注
                        paragraphFootnoteComponent(
                            item,
                            markdownConfiguration,
                            fontCallback
                        )
                    } else if (item.node is Code) {
                        // 内联代码
                        if (markdownConfiguration.markdownTheme.isCodeStyle) {
                            MarkdownCodeLineImageSpanComponent(
                                markdownConfiguration: markdownConfiguration,
                                strCode: (item.node as Code)().getLiteral(),
                                strUrl: linkUrl(item),
                                isFakeBoldText: item.strongEmphasis
                            )
                        } else {
                            paragraphCodeComponent(
                                item,
                                markdownConfiguration
                            )
                        }
                    } else if (item.node is CommonmarkLink) {
                        // 链接
                        if (isListTo && !markdownConfiguration.markdownTheme.isListLinkStyle && isOneLink && !markdownConfiguration.markdownTheme.isLinkStyle) {
                            if(getLinkString(item).isSome()){
                                paragraphLinkComponent(
                                    item,
                                    getLinkString(item)(),
                                    markdownConfiguration
                                )
                            }else{
                                Span("")
                            }
                        } else {
                            if ((item.node as CommonmarkLink)().getDestination().startsWith("http://") || (item.node as CommonmarkLink)().getDestination().startsWith("https://")) {
                                if(getLinkString(item).isSome()){
                                    if(getLinkString(item)().trimAscii().toRuneArray().size > 1){
                                        MarkdownLinkRectImageComponent(
                                            markdownConfiguration: markdownConfiguration,
                                            strText: getLinkString(item)().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownConfiguration.markdownTheme.linkRectImageBackGroupColor)
                                        )
                                    }else{
                                        MarkdownLinkCircleImageComponent(
                                            markdownConfiguration: markdownConfiguration,
                                            strText: getLinkString(item)().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownConfiguration.markdownTheme.linkCircleImageBackGroupColor)
                                        )
                                    }
                                }else{
                                    Span("")
                                }
                            } else {
                                if(getLinkString(item).isSome()){
                                    MarkdownLinkRectToolImageComponent(
                                        markdownConfiguration: markdownConfiguration,
                                        strText: getLinkString(item)(),
                                        strUrl: (item.node as CommonmarkLink)().getDestination(),
                                        strType: urlSafeBase64Decode((item.node as CommonmarkLink)().getDestination()),
                                        backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownConfiguration.markdownTheme.linkRectToolImageBackGroupColor)
                                    )
                                }else{
                                    Span("")
                                }
                            }
                        }
                    } else if (item.node is HardLineBreak) {
                        // 硬换行
                        Span("\n")
                    } else if (item.node is SoftLineBreak) {
                        // 软换行
                        Span(spanSoftLineBreak(markdownConfiguration.markdownTheme.isLineBreak))
                    } else if (item.node is ImageHtmlNode) {
                        // HTML图片
                        MarkdownHtmlImageSpanComponent(
                            destination: (item.node as ImageHtmlNode)().getDestination(),
                            imagePlaceholder: markdownConfiguration.markdownTheme.imagePlaceholder,
                            imageWidth: strToFloat64((item.node as ImageHtmlNode)().getWidth()),
                            imageHeight: strToFloat64((item.node as ImageHtmlNode)().getHeight()),
                            componentWidth: componentWidth,
                            imageMarginTop: imageMarginTop,
                            imageMarginBottom: imageMarginBottom,
                            imageCallback: imageCallback
                        )
                    } else if (item.node is CommonmarkImage) {
                        // 图片节点
                        if (markdownConfiguration.imageCallbackCallback.isNone()) {
                            MarkdownImageSpanComponent(
                                destination: (item.node as CommonmarkImage)().getDestination(),
                                imagePlaceholder: markdownConfiguration.markdownTheme.imagePlaceholder,
                                componentWidth: componentWidth,
                                imageMarginTop: imageMarginTop,
                                imageMarginBottom: imageMarginBottom,
                                imageCallback: imageCallback,
                                linkCallback: markdownConfiguration.linkCallback,
                                isLink: item.link.isSome(),
                                linkUrl: if (item.link.isSome()) {item.link().getDestination()} else {Option<String>.None},
                                imageBorderRadius: markdownConfiguration.markdownTheme.imageBorderRadius
                            )
                        } else {
                            MarkdownImagePixelmapSpanComponent(
                                destination: (item.node as CommonmarkImage)().getDestination(),
                                imagePlaceholder: markdownConfiguration.markdownTheme.imagePlaceholder,
                                componentWidth: componentWidth,
                                imageMarginTop: imageMarginTop,
                                imageMarginBottom: imageMarginBottom,
                                imageCallback: imageCallback,
                                linkCallback: markdownConfiguration.linkCallback,
                                isLink: item.link.isSome(),
                                linkUrl: if (item.link.isSome()) {item.link().getDestination()} else {Option<String>.None},
                                imageCallbackCallback : markdownConfiguration.imageCallbackCallback(),
                                imageBorderRadius: markdownConfiguration.markdownTheme.imageBorderRadius
                            )
                        }
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        MarkdownLatexImageSpanComponent(
                            markdownConfiguration: markdownConfiguration,
                            componentWidth: componentWidth,
                            strLatexMath: (item.node as LatexMathNode)().latex,
                            backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownConfiguration.markdownTheme.latexMathBackGroupColor)
                        )
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                },
                keyGeneratorFunc:{
                     item: NodeView, idx: Int64 => return "${idx}-${getProp<Int64>(item,"nodeid",0)}"
                }
            )
        }
        // 设置多行文本的文本对齐方式
        .textAlign(TextAlign.Start)
        // 设置行高
        .lineHeight(markdownConfiguration.markdownTheme.paragraphTextLineHeight)
        // 支持设备内复制
        .copyOption(if (markdownConfiguration.markdownTheme.isOnCopy) { CopyOptions.LocalDevice } else { CopyOptions.None })
        // 长按文本内部区域弹出剪贴板后，点击剪切板复制按钮，触发该事件。目前文本复制仅支持文本。
        .onCopy({
            str =>
                if(markdownConfiguration.textCopyCallback.isSome()){
                   markdownConfiguration.textCopyCallback()(str)
                }
        })
    }

    /**
     * 段落文字内容
     */
    @Builder
    func paragraphComponent() {
        if(DeviceInfo.sdkApiVersion >=19){
            paragraphComponent19()
        } else {
            paragraphComponent18()
        }
    }

    func isMarginTop():Float64{
        if(nodeViewList.size == 1 && nodeViewList[0].node is CommonmarkImage){
            return 0.0
        }else{
            return marginTop
        }
    }

    func isMarginBottom():Float64{
        if(nodeViewList.size == 1 && nodeViewList[0].node is CommonmarkImage){
            return 0.0
        }else{
            return marginBottom
        }
    }

    /**
     * 数据刷新
     */
    public func refreshData(refreshNodeViews: ArrayList<NodeView>): Unit {
        let refreshNodeViewSize: Int64 = refreshNodeViews.size // 刷新进来的数据长度
        let nodeViewListSize: Int64 = nodeViewList.size // 页面缓存的数据长度
        // 增量加载
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > nodeViewListSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for(i in 0..nodeViewListSize){
                if(getProp<Int64>(refreshNodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewList[i],"nodeid",0)){
                    nodeViewList[i] = refreshNodeViews[i]
                }
            }
            // 循环添加新数据
            for(i in nodeViewListSize..refreshNodeViewSize){
                nodeViewList.append(refreshNodeViews[i])
            }
        } else if (refreshNodeViewSize == nodeViewListSize) {
            // 新数据等于页面数据
            for(i in 0..nodeViewListSize){
                if(getProp<Int64>(refreshNodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewList[i],"nodeid",0)){
                    nodeViewList[i] = refreshNodeViews[i]
                }
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for(i in 0..refreshNodeViewSize){
                if(getProp<Int64>(refreshNodeViews[i],"nodeid",0) != getProp<Int64>(nodeViewList[i],"nodeid",0)){
                    nodeViewList[i] = refreshNodeViews[i]
                }
            }
            // 循环删除多余的旧数据
            for(i in nodeViewListSize - 1..=refreshNodeViewSize : -1){
                nodeViewList.remove(i)
            }
        }
        size = nodeViewList.size // 更新列表长度
        if(nodeViewList.size==1 && nodeViewList[0].node is CommonmarkLink){
            isOneLink = true
        }else{
            isOneLink = false
        }
    }
}
