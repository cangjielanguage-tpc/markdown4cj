/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
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
class MarkdownAIHeadingComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 标题内容数据
     */
    var nodeViews: ArrayList<NodeView>

    /**
     * 定位需要的数组
     */
    var indexList: ArrayList<Int64> = ArrayList<Int64>()

    /**
     * 标题等级
     */
    @State
    var level: Int64 = 1

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
    var headingComponents: ArrayList<MarkdownAIHeadingComponent>

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
        refreshData(nodeViews, level)
        // 缓存当前控件
        headingComponents.add(this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        headingComponents.removeIf(
            {
                predicate => if (predicate.indexList == indexList && predicate.size == size) {
                    true
                } else {
                    false
                }
            })
    }

    func build() {
        Column() {
            // 标题内容
            headingTitleComponent()

            // 一级二级标题是否显示下划线
            if ((level == 1 || level == 2) && markdownAIConfiguration.markdownAITheme.headingBreakHeight > 0.0) {
                Divider()
                    // 设置分割线颜色
                    .color(markdownAIConfiguration.markdownAITheme.headingBreakColor)
                    // 设置分割线宽度
                    .strokeWidth(markdownAIConfiguration.markdownAITheme.headingBreakHeight)
            }
        }
        // 设置子组件在水平方向上的对齐格式
        .alignItems(HorizontalAlign.Start)
        // 设置子组件在垂直方向上的对齐格式
        .justifyContent(FlexAlign.Center)
        // 设置外边距属性
        .margin(top: isMarginTop(), bottom: isMarginBottom())
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
                        headingTextComponent(
                            item,
                            markdownAIConfiguration,
                            level
                        )
                    } else if (item.node is Footnote) {
                        // 脚注
                        headingFootnoteComponent(
                            item,
                            markdownAIConfiguration,
                            level,
                            fontCallback
                        )
                    } else if (item.node is Code) {
                        // 内联代码
                        if(markdownAIConfiguration.markdownAITheme.isCodeStyle){
                            MarkdownAICodeLineImageSpanComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                strCode: (item.node as Code)().getLiteral(),
                                strUrl: linkUrl(item),
                                isFakeBoldText: true
                            )
                        }else{
                            headingCodeComponent(
                                item,
                                markdownAIConfiguration
                            )
                        }
                    } else if (item.node is CommonmarkLink) {
                        // 链接
                        if (isListTo && !markdownAIConfiguration.markdownAITheme.isListLinkStyle && isOneLink && !markdownAIConfiguration.markdownAITheme.isLinkStyle) {
                            if(getLinkString(item).isSome()){
                                headingLinkComponent(
                                    item,
                                    getLinkString(item)(),
                                    markdownAIConfiguration,
                                    level
                                )
                            }else{
                                Span("")
                            }
                        } else {
                            if ((item.node as CommonmarkLink)().getDestination().startsWith("http://") || (item.node as CommonmarkLink)().getDestination().startsWith("https://")) {
                                if(getLinkString(item).isSome()){
                                    if(getLinkString(item)().trimAscii().toRuneArray().size > 1){
                                        MarkdownAILinkRectImageComponent(
                                            markdownAIConfiguration: markdownAIConfiguration,
                                            strText: getLinkString(item)().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownAIConfiguration.markdownAITheme.linkRectImageBackGroupColor)
                                        )
                                    }else{
                                        MarkdownAILinkCircleImageComponent(
                                            markdownAIConfiguration: markdownAIConfiguration,
                                            strText: getLinkString(item)().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownAIConfiguration.markdownAITheme.linkCircleImageBackGroupColor)
                                        )
                                    }
                                }else{
                                    Span("")
                                }
                            } else {
                                if(getLinkString(item).isSome()){
                                    MarkdownAILinkRectToolImageComponent(
                                        markdownAIConfiguration: markdownAIConfiguration,
                                        strText: getLinkString(item)(),
                                        strUrl: (item.node as CommonmarkLink)().getDestination(),
                                        strType: urlSafeBase64Decode((item.node as CommonmarkLink)().getDestination()),
                                        backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownAIConfiguration.markdownAITheme.linkRectToolImageBackGroupColor)
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
                        Span(spanSoftLineBreak(markdownAIConfiguration.markdownAITheme.isLineBreak))
                    } else if (item.node is ImageHtmlNode) {
                        // HTML图片
                        MarkdownAIHtmlImageSpanComponent(
                            destination: (item.node as ImageHtmlNode)().getDestination(),
                            imagePlaceholder: markdownAIConfiguration.markdownAITheme.imagePlaceholder,
                            imageWidth: strToFloat64((item.node as ImageHtmlNode)().getWidth()),
                            imageHeight: strToFloat64((item.node as ImageHtmlNode)().getHeight()),
                            componentWidth:componentWidth,
                            imageMarginTop: imageMarginTop,
                            imageMarginBottom: imageMarginBottom,
                            imageCallback: imageCallback
                        )
                    } else if (item.node is CommonmarkImage) {
                        // 图片节点
                        MarkdownAIImagePixelmapSpanComponent(
                            destination: (item.node as CommonmarkImage)().getDestination(),
                            imagePlaceholder: markdownAIConfiguration.markdownAITheme.imagePlaceholder,
                            componentWidth: componentWidth,
                            imageMarginTop: imageMarginTop,
                            imageMarginBottom: imageMarginBottom,
                            imageCallback: imageCallback,
                            linkCallback: markdownAIConfiguration.linkCallback,
                            isLink: item.link.isSome(),
                            linkUrl: if (item.link.isSome()) {item.link().getDestination()} else {Option<String>.None},
                            imageCallbackCallback : markdownAIConfiguration.imageCallbackCallback
                        )
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        MarkdownAILatexImageSpanComponent(
                            markdownAIConfiguration: markdownAIConfiguration,
                            componentWidth: componentWidth,
                            strLatexMath: (item.node as LatexMathNode)().latex,
                            backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownAIConfiguration.markdownAITheme.latexMathBackGroupColor)
                        )
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                }
            )
        }
        // 设置多行文本的文本对齐方式
        .textAlign(TextAlign.Start)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置行高
        .lineHeight(tableLineHeight())
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
                        headingTextComponent(
                            item,
                            markdownAIConfiguration,
                            level
                        )
                    } else if (item.node is Footnote) {
                        // 脚注
                        headingFootnoteComponent(
                            item,
                            markdownAIConfiguration,
                            level,
                            fontCallback
                        )
                    } else if (item.node is Code) {
                        // 内联代码
                        if(markdownAIConfiguration.markdownAITheme.isCodeStyle){
                            MarkdownAICodeLineImageSpanComponent(
                                markdownAIConfiguration: markdownAIConfiguration,
                                strCode: (item.node as Code)().getLiteral(),
                                strUrl: linkUrl(item),
                                isFakeBoldText: true
                            )
                        }else{
                            headingCodeComponent(
                                item,
                                markdownAIConfiguration
                            )
                        }
                    } else if (item.node is CommonmarkLink) {
                        // 链接
                        if (isListTo && !markdownAIConfiguration.markdownAITheme.isListLinkStyle && isOneLink && !markdownAIConfiguration.markdownAITheme.isLinkStyle) {
                            if(getLinkString(item).isSome()){
                                headingLinkComponent(
                                    item,
                                    getLinkString(item)(),
                                    markdownAIConfiguration,
                                    level
                                )
                            }else{
                                Span("")
                            }
                        } else {
                            if ((item.node as CommonmarkLink)().getDestination().startsWith("http://") || (item.node as CommonmarkLink)().getDestination().startsWith("https://")) {
                                if(getLinkString(item).isSome()){
                                    if(getLinkString(item)().trimAscii().toRuneArray().size > 1){
                                        MarkdownAILinkRectImageComponent(
                                            markdownAIConfiguration: markdownAIConfiguration,
                                            strText: getLinkString(item)().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownAIConfiguration.markdownAITheme.linkRectImageBackGroupColor)
                                        )
                                    }else{
                                        MarkdownAILinkCircleImageComponent(
                                            markdownAIConfiguration: markdownAIConfiguration,
                                            strText: getLinkString(item)().trimAscii(),
                                            strUrl: (item.node as CommonmarkLink)().getDestination(),
                                            backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownAIConfiguration.markdownAITheme.linkCircleImageBackGroupColor)
                                        )
                                    }
                                }else{
                                    Span("")
                                }
                            } else {
                                if(getLinkString(item).isSome()){
                                    MarkdownAILinkRectToolImageComponent(
                                        markdownAIConfiguration: markdownAIConfiguration,
                                        strText: getLinkString(item)(),
                                        strUrl: (item.node as CommonmarkLink)().getDestination(),
                                        strType: urlSafeBase64Decode((item.node as CommonmarkLink)().getDestination()),
                                        backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownAIConfiguration.markdownAITheme.linkRectToolImageBackGroupColor)
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
                        Span(spanSoftLineBreak(markdownAIConfiguration.markdownAITheme.isLineBreak))
                    } else if (item.node is ImageHtmlNode) {
                        // HTML图片
                        MarkdownAIHtmlImageSpanComponent(
                            destination: (item.node as ImageHtmlNode)().getDestination(),
                            imagePlaceholder: markdownAIConfiguration.markdownAITheme.imagePlaceholder,
                            imageWidth: strToFloat64((item.node as ImageHtmlNode)().getWidth()),
                            imageHeight: strToFloat64((item.node as ImageHtmlNode)().getHeight()),
                            componentWidth:componentWidth,
                            imageMarginTop: imageMarginTop,
                            imageMarginBottom: imageMarginBottom,
                            imageCallback: imageCallback
                        )
                    } else if (item.node is CommonmarkImage) {
                        // 图片节点
                        MarkdownAIImagePixelmapSpanComponent(
                            destination: (item.node as CommonmarkImage)().getDestination(),
                            imagePlaceholder: markdownAIConfiguration.markdownAITheme.imagePlaceholder,
                            componentWidth: componentWidth,
                            imageMarginTop: imageMarginTop,
                            imageMarginBottom: imageMarginBottom,
                            imageCallback: imageCallback,
                            linkCallback: markdownAIConfiguration.linkCallback,
                            isLink: item.link.isSome(),
                            linkUrl: if (item.link.isSome()) {item.link().getDestination()} else {Option<String>.None},
                            imageCallbackCallback : markdownAIConfiguration.imageCallbackCallback
                        )
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        MarkdownAILatexImageSpanComponent(
                            markdownAIConfiguration: markdownAIConfiguration,
                            componentWidth: componentWidth,
                            strLatexMath: (item.node as LatexMathNode)().latex,
                            backGroupColor: markdownbackGroupColor(blockQuoteBackGroupColor, markdownAIConfiguration.markdownAITheme.latexMathBackGroupColor)
                        )
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
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
        .copyOption(CopyOptions.LocalDevice)
        // 长按文本内部区域弹出剪贴板后，点击剪切板复制按钮，触发该事件。目前文本复制仅支持文本。
        .onCopy({
            str =>
                if(markdownAIConfiguration.textCopyCallback.isSome()){
                   markdownAIConfiguration.textCopyCallback()(str)
                }
        })
    }

    /**
     * 标题文字内容
     */
    @Builder
    func headingTitleComponent() {
        if(DeviceInfo.sdkApiVersion >=19){
            headingTitleComponent19()
        } else {
            headingTitleComponent18()
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

    func tableLineHeight(): Float64 {
        return match (level) {
            case 1 => markdownAIConfiguration.markdownAITheme.headingTextLineHeight1
            case 2 => markdownAIConfiguration.markdownAITheme.headingTextLineHeight2
            case 3 => markdownAIConfiguration.markdownAITheme.headingTextLineHeight3
            case 4 => markdownAIConfiguration.markdownAITheme.headingTextLineHeight4
            case 5 => markdownAIConfiguration.markdownAITheme.headingTextLineHeight5
            case 6 => markdownAIConfiguration.markdownAITheme.headingTextLineHeight6
            case _ => markdownAIConfiguration.markdownAITheme.headingTextLineHeight6
        }
    }

    /**
     * 数据刷新
     */
    public func refreshData(refreshNodeViews: ArrayList<NodeView>, level: Int64): Unit {
        this.level = level // 等级
        let refreshNodeViewSize: Int64 = refreshNodeViews.size // 刷新进来的数据长度
        let nodeViewListSize: Int64 = nodeViewList.size // 页面缓存的数据长度
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
