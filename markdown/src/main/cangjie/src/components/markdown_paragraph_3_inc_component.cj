/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import cj_res_markdown.sys

class Paragraph3IncData {
    var component: MarkdownParagraph3INCComponent
    var index: Int64
    var index2: Int64
    var index3: Int64
    var indexItem: Int64
    var indexItem2: Int64

    init(component: MarkdownParagraph3INCComponent, index: Int64, index2: Int64, index3: Int64, indexItem: Int64,
        indexItem2: Int64) {
        this.component = component
        this.index = index
        this.index2 = index2
        this.index3 = index3
        this.indexItem = indexItem
        this.indexItem2 = indexItem2
    }
}

/**
 * Markdown段落自定义页面
 */
@Component
class MarkdownParagraph3INCComponent {
    /**
     * markdown配置
     */
    @Prop
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 段落NodeView
     */
    @Prop
    var nodeView: NodeView

    /**
     * 外边距 - 上面
     */
    @Prop
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    @Prop
    var marginBottom: Float64

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidth: Float64

    /**
     * 是否全量加载
     */
    @Prop
    var isFull: Bool

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var index: Int64

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var index2: Int64

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var index3: Int64

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var indexItem: Int64

    /**
     * 标识符，第几条块引用
     */
    @Prop
    var indexItem2: Int64

    @Prop
    var markdownListConfiguration: MarkdownListConfiguration

    /**
     * 储存的PixelMap，最后需要释放
     */
    var listPixelMap: ArrayList<?PixelMap> = ArrayList<?PixelMap>()

    /**
     * 异步加载的图片数据
     */
    @State
    var arrayListPixelMap: ObservedArrayList<ImageData> = ObservedArrayList<ImageData>()

    /**
     * 线程列表
     */
    @State
    var futs: ArrayList<?Future<Unit>> = ArrayList<?Future<Unit>>()

    /**
     * 懒加载数据源
     */
    @State
    var nodeViewList: ObservedArrayList<NodeView> = ObservedArrayList<NodeView>()

    protected override func aboutToAppear(): Unit {
        refreshData(nodeView)
        markdownListConfiguration.paragraph3Components.append(Paragraph3IncData(this, index, index2, index3, indexItem,
            indexItem2))
    }

    protected override func aboutToDisappear(): Unit {
        markdownListConfiguration
            .paragraph3Components
            .removeIf(
                {
                    predicate => if (predicate.index == index && predicate.index2 == index2
                        && predicate.index3 == index3 && predicate.indexItem == indexItem
                        && predicate.indexItem2 == indexItem2 && predicate.component.nodeView.children.size == nodeView
                        .children
                        .size) {
                        true
                    } else {
                        false
                    }
                })
    }

    public func refreshData(nodeView: NodeView): Unit {
        let nodeViews = nodeView.children
        if (isFull) {
            nodeViewList.clear()
            nodeViewList.appendAll(nodeViews)
        } else {
            if (nodeViews.size == 0) {
                return
            }
            if (nodeViews.size > nodeViewList.size) {
                if (nodeViewList.size != 0) {
                    nodeViewList.remove(nodeViewList.size - 1)
                    nodeViewList.append(nodeViews[nodeViewList.size - 1])
                }
                for (i in nodeViews.size - nodeViewList.size..0 : -1) {
                    nodeViewList.append(nodeViews[nodeViews.size - i])
                }
            } else if (nodeViews.size == nodeViewList.size) {
                nodeViewList.remove(nodeViewList.size - 1)
                nodeViewList.append(nodeViews[nodeViewList.size - 1])
            } else {
                nodeViewList.remove(nodeViews.size - 1)
                nodeViewList.append(nodeViews[nodeViews.size - 1])
                for (i in nodeViewList.size - nodeViews.size..0 : -1) {
                    nodeViewList.remove(nodeViewList.size - i)
                }
            }
        }
    }

    func build() {
        Column() {
            paragraphOtherComponent()
        }
            // 设置元素内容的对齐方式
            .align(Alignment.Start)
            // 设置元素水平方向的布局
            .direction(Direction.Ltr)
            // 设置外边距属性
            .margin(top: marginTop, bottom: marginBottom)
            // 设置组件自身的宽度
            .width(100.percent)
    }

    /**
     * 文本
     */
    @Builder
    func paragraphTextComponent(nodeView: NodeView) {
        // 设置文本内容
        Span(spanText(nodeView))
            // 设置文本的字体列表
            .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
            // 设置文本尺寸
            .fontSize(spanFontSize(nodeView, false, markdownConfiguration.markdownTheme, false, 0))
            // 设置文本的字体粗细
            .fontWeight(spanFontWeight(nodeView, false))
            // 设置文本的字体样式
            .fontStyle(spanFontStyle(nodeView))
            // 设置文本颜色
            .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
            // 设置文本字符间距
            .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
            // 设置文本装饰线样式及其颜色
            .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0],
                color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
            // 点击动作触发该方法调用
            .onClick {evt => tocListOnClickFunc(nodeView)}
    }

    /**
     * 内联代码
     */
    @Builder
    func paragraphCodeComponent(nodeView: NodeView) {
        // 设置文本内容
        Span(spanText(nodeView))
            // 设置文本的字体列表
            .fontFamily(spanFontFamily(true, markdownConfiguration.markdownTheme, false))
            // 设置文本尺寸
            .fontSize(spanFontSize(nodeView, true, markdownConfiguration.markdownTheme, false, 0))
            // 设置文本的字体粗细
            .fontWeight(spanFontWeight(nodeView, false))
            // 设置文本的字体样式
            .fontStyle(spanFontStyle(nodeView))
            // 设置文本颜色
            .fontColor(spanFontColor(nodeView, true, markdownConfiguration.markdownTheme, false))
            // 设置文本字符间距
            .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
            // 设置文本装饰线样式及其颜色
            .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0],
                color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
            // 点击动作触发该方法调用
            .onClick {evt => tocListOnClickFunc(nodeView)}
    }

    /**
     * 行内数学公式
     */
    @Builder
    func paragraphLatexMathComponent(ret: Int64) {
        ForEach(
            arrayListPixelMap,
            itemGeneratorFunc: {
                item: ImageData, idx: Int64 => if (item.ret == ret) {
                    if (isLatexImagePixelMap(item, listPixelMap)) {
                        ImageSpan(item.pixelMap())
                            // 设置组件自身的高度
                            .height(pxToVp(item.height()))
                            // 设置组件自身的宽度
                            .width(pxToVp(item.width()))
                            // 设置图片的缩放类型
                            .objectFit(ImageFit.Contain)
                            // 设置约束尺寸
                            .constraintSize(maxWidth: Length(100, unitType: LengthType.percent))
                            // 点击动作触发该方法调用
                            .onClick {
                                evt => latexImageOnClick(item.arrayUint8(), item.height().px, item.width().px,
                                    markdownConfiguration.latexImageCallback)
                            }
                    }
                }
            }
        )
    }

    /**
     * 视频
     */
    @Builder
    func paragraphVideoComponent(imgVideo: ImgVideo) {
        MarkdownVideoComponent(imgVideo: imgVideo, markdownConfiguration: markdownConfiguration)
    }

    /**
     * 图片
     */
    @Builder
    func paragraphImageSpanPixelMapComponent(ret: Int64, destination: String, imageType: Int64,
        picStyleObj: ?PicStyleObj) {
        ForEach(
            arrayListPixelMap,
            itemGeneratorFunc: {
                item: ImageData, idx: Int64 => if (item.ret == ret && imageType == 1) {
                    if (isImagePixelMap(item, listPixelMap)) {
                        ImageSpan(item.pixelMap())
                            // 设置组件自身的高度
                            .height(pxToVp(item.height()))
                            // 设置组件自身的宽度
                            .width(pxToVp(item.width()))
                            // 设置图片的缩放类型
                            .objectFit(ImageFit.Contain)
                            // 设置约束尺寸
                            .constraintSize(maxWidth: Length(100, unitType: LengthType.percent))
                            // 图片的点击事件
                            .onClick {evt => imageOnClick(destination, markdownConfiguration.imageCallback)}
                    }
                } else if (item.ret == ret && item.height.isSome()) {
                    ImageSpan(destination)
                        // 设置组件自身的高度
                        .height(pxToVp(item.height()))
                        // 设置组件自身的宽度
                        .width(pxToVp(item.width()))
                        // 设置图片的缩放类型
                        .objectFit(ImageFit.Contain)
                        // 设置约束尺寸
                        .constraintSize(maxWidth: Length(100, unitType: LengthType.percent))
                        // 图片的点击事件
                        .onClick {evt => imageOnClick(destination, markdownConfiguration.imageCallback)}
                }
            }
        )
    }

    /**
     * 图片
     */
    @Builder
    func paragraphImageSpanComponent(commonmarkImage: CommonmarkImage, idx: Int64) {
        if (commonmarkImage.getDestination().startsWith("file:")) {
            // 沙盒图片
            paragraphImageSpanPixelMapComponent(filesPixelmap(commonmarkImage.getDestination(), idx),
                commonmarkImage.getDestination(), 0, Option<PicStyleObj>.None)
        } else if (commonmarkImage.getDestination().startsWith("./")) {
            // rawfile图片
            paragraphImageSpanPixelMapComponent(localRowImageToPixelMap(commonmarkImage.getDestination(), idx),
                commonmarkImage.getDestination(), 1, Option<PicStyleObj>.None)
        } else if (commonmarkImage.getDestination().toAsciiLower().startsWith("http") ||
            commonmarkImage.getDestination().toAsciiLower().startsWith("ftp")) {
            // 网络图片
            paragraphImageSpanPixelMapComponent(httpImageToPixelMap(commonmarkImage.getDestination(), idx),
                commonmarkImage.getDestination(), 2, Option<PicStyleObj>.None)
        }
    }

    /**
     * 图片
     */
    @Builder
    func paragraphImageSpanStyleComponent(commonmarkImage: StyleImage, picStyleObj: PicStyleObj, idx: Int64) {
        if (commonmarkImage.getDestination().startsWith("file:")) {
            // 沙盒图片
            paragraphImageSpanPixelMapComponent(filesPixelmapStyle(commonmarkImage.getDestination(), idx, picStyleObj),
                commonmarkImage.getDestination(), 0, picStyleObj)
        } else if (commonmarkImage.getDestination().startsWith("./")) {
            // rawfile图片
            paragraphImageSpanPixelMapComponent(
                localRowImageToPixelMapStyle(commonmarkImage.getDestination(), idx, picStyleObj),
                commonmarkImage.getDestination(), 1, picStyleObj)
        } else if (commonmarkImage.getDestination().toAsciiLower().startsWith("http") ||
            commonmarkImage.getDestination().toAsciiLower().startsWith("ftp")) {
            // 网络图片
            paragraphImageSpanPixelMapComponent(
                httpImageToPixelMapStyle(commonmarkImage.getDestination(), idx, picStyleObj),
                commonmarkImage.getDestination(), 2, picStyleObj)
        }
    }

    /**
     * 图片
     */
    @Builder
    func paragraphHtmlImageSpanComponent(imageHtmlNode: ImageHtmlNode, idx: Int64) {
        if (imageHtmlNode.getDestination().startsWith("file:")) {
            // 沙盒图片
            paragraphImageSpanPixelMapComponent(
                filesPixelmapStyle(imageHtmlNode.getDestination(), idx, toPicStyleObj(imageHtmlNode)),
                imageHtmlNode.getDestination(), 0, toPicStyleObj(imageHtmlNode))
        } else if (imageHtmlNode.getDestination().startsWith("./")) {
            // rawfile图片
            paragraphImageSpanPixelMapComponent(
                localRowImageToPixelMapStyle(imageHtmlNode.getDestination(), idx, toPicStyleObj(imageHtmlNode)),
                imageHtmlNode.getDestination(), 1, toPicStyleObj(imageHtmlNode))
        } else if (imageHtmlNode.getDestination().toAsciiLower().startsWith("http") ||
            imageHtmlNode.getDestination().toAsciiLower().startsWith("ftp")) {
            // 网络图片
            paragraphImageSpanPixelMapComponent(
                httpImageToPixelMapStyle(imageHtmlNode.getDestination(), idx, toPicStyleObj(imageHtmlNode)),
                imageHtmlNode.getDestination(), 2, toPicStyleObj(imageHtmlNode))
        }
    }

    func toPicStyleObj(imageHtmlNode: ImageHtmlNode): PicStyleObj {
        let picStyleObj: PicStyleObj = PicStyleObj()
        if (let Some(v) <- imageHtmlNode.getWidth()) {
            picStyleObj.width = Float64.parse(v).px
        }
        if (let Some(v) <- imageHtmlNode.getHeight()) {
            picStyleObj.height = Float64.parse(v).px
        }
        return picStyleObj
    }

    /**
     * 段落文字内容
     */
    @Builder
    func paragraphOtherComponent() {
        Text() {
            ForEach(
                nodeViewList,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        paragraphTextComponent(item)
                    } else if (item.node is Code) {
                        // 内联代码
                        paragraphCodeComponent(item)
                    } else if (item.node is HardLineBreak) {
                        // 硬换行
                        Span("\n")
                    } else if (item.node is SoftLineBreak) {
                        // 软换行
                        Span(spanSoftLineBreak(markdownConfiguration.markdownTheme.isLineBreak))
                    } else if (item.node is CommonmarkImage) {
                        // 图片节点
                        paragraphImageSpanComponent((item.node as CommonmarkImage)(), idx)
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        paragraphLatexMathComponent(latexMathImagePixelmap((item.node as LatexMathNode)().latex, idx))
                    } else if (item.node is ImageHtmlNode) {
                        // HTML图片
                        paragraphHtmlImageSpanComponent((item.node as ImageHtmlNode)(), idx)
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
            // 组件卸载消失时触发此回调
            .onDisAppear(
                {
                    =>
                    threadFutureCancel(futs)
                    delPixelMap(listPixelMap)
                }
            )
    }

    /**
     * 判断是否是TOC列表还是链接，做不同的点击事件处理
     */
    func tocListOnClickFunc(nodeView: NodeView) {
        linkOnClick(nodeView, markdownConfiguration.linkCallback)
    }

    /**
     * 数学公式数据处理 - 行内数学公式
     */
    func latexMathImagePixelmap(strLatexMath: String, idx: Int64): Int64 {
        let callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit = {
            pixelMap, height, width, arr => launch {
                arrayListPixelMap.append(
                    ImageData(ret: idx, pixelMap: pixelMap, height: height, width: width, arrayUint8: arr))
            }
        }
        let fut = MarkdownParseLatexUtil.latexMathStrToPixelMapRow(strLatexMath,
            markdownConfiguration.markdownTheme.resPath, markdownConfiguration, componentWidth, callback)
        futs.append(fut)
        return idx
    }

    /**
     * 图片数据处理 - 本地沙盒图片
     */
    func filesPixelmap(destination: String, idx: Int64): Int64 {
        let callback: (?Float64, ?Float64) -> Unit = {
            width, height => launch {
                arrayListPixelMap.append(ImageData(ret: idx, height: height, width: width))
            }
        }
        let fut = imageSpanToPixelmap(destination, componentWidth, callback)
        futs.append(fut)
        return idx
    }

    /**
     * 图片数据处理 - 本地rawfile图片
     */
    func localRowImageToPixelMap(destination: String, idx: Int64): Int64 {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            pixelMap, width, height => launch {
                arrayListPixelMap.append(ImageData(ret: idx, pixelMap: pixelMap, height: height, width: width))
            }
        }
        let fut = rawfileToPixelmap(destination, markdownConfiguration.markdownTheme.abilityContext, componentWidth,
            callback)
        futs.append(fut)
        return idx
    }

    /**
     * 图片数据处理 - 网络图片
     */
    func httpImageToPixelMap(destination: String, idx: Int64): Int64 {
        let callback: (?Float64, ?Float64) -> Unit = {
            width, height => launch {
                arrayListPixelMap.append(ImageData(ret: idx, height: height, width: width))
            }
        }
        let fut = getImageFromHttpClient(destination, componentWidth, callback)
        futs.append(fut)
        return idx
    }

    /**
     * 图片数据处理 - 本地沙盒图片
     */
    func filesPixelmapStyle(destination: String, idx: Int64, picStyleObj: PicStyleObj): Int64 {
        let callback: (?Float64, ?Float64) -> Unit = {
            width, height => launch {
                arrayListPixelMap.append(ImageData(ret: idx, height: height, width: width))
            }
        }
        let fut = imageSpanToPixelmapStyle(destination, componentWidth, length2Float64(picStyleObj.width),
            length2Float64(picStyleObj.height), callback)
        futs.append(fut)
        return idx
    }

    /**
     * 图片数据处理 - 本地rawfile图片
     */
    func localRowImageToPixelMapStyle(destination: String, idx: Int64, picStyleObj: PicStyleObj): Int64 {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            pixelMap, width, height => launch {
                arrayListPixelMap.append(ImageData(ret: idx, pixelMap: pixelMap, height: height, width: width))
            }
        }
        let fut = rawfileToPixelmapStyle(destination, markdownConfiguration.markdownTheme.abilityContext, componentWidth,
            length2Float64(picStyleObj.width), length2Float64(picStyleObj.height), callback)
        futs.append(fut)
        return idx
    }

    /**
     * 图片数据处理 - 网络图片
     */
    func httpImageToPixelMapStyle(destination: String, idx: Int64, picStyleObj: PicStyleObj): Int64 {
        let callback: (?Float64, ?Float64) -> Unit = {
            width, height => launch {
                arrayListPixelMap.append(ImageData(ret: idx, height: height, width: width))
            }
        }
        let fut = getImageFromHttpClientStyle(destination, componentWidth, length2Float64(picStyleObj.width),
            length2Float64(picStyleObj.height), callback)
        futs.append(fut)
        return idx
    }

    func length2Float64(length: ?Length): ?Float64 {
        if (let Some(v) <- length) {
            return match (v.unitType) {
                case LengthType.vp => vp2px(v)().value
                case LengthType.px => v.value
                case LengthType.percent => (v.value / 1.0) * componentWidth
                case _ => v.value
            }
        } else {
            return None
        }
    }
}
