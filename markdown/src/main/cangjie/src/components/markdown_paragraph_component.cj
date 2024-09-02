/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
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
     * 段落NodeView
     */
    var paragraphNodeView: NodeView

    /**
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

    /**
     * 控件宽度 - 单位px
     */
    var componentWidth: Float64

    /**
     * TOC列表点击事件回调
     */
    let tocListOnClick: (Int64) -> Unit

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

    func build() {
        Column() {
            paragraphOtherComponent()

            // TODO 图片单独用image处理,图文混排暂时未处理
            ForEach(
                paragraphNodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is ImgVideo) {
                        // 视频图片
                        paragraphVideoComponent((item.node as ImgVideo)())
                    } else if (item.node is StyleImage) {
                        // 图片Style
                        paragraphImageStyleComponent((item.node as StyleImage)(),
                            parsePicStyle((item.node as StyleImage)().styles, markdownConfiguration, componentWidth))
                    }
                }
            )
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
            .fontSize(spanFontSize(false, markdownConfiguration.markdownTheme, false, 0))
            // 设置文本的字体粗细
            .fontWeight(spanFontWeight(nodeView, false))
            // 设置文本的字体样式
            .fontStyle(spanFontStyle(nodeView))
            // 设置文本颜色
            .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
            // 设置文本字符间距
            .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
            // 设置文本装饰线样式及其颜色
            .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
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
            .fontSize(spanFontSize(true, markdownConfiguration.markdownTheme, false, 0))
            // 设置文本的字体粗细
            .fontWeight(spanFontWeight(nodeView, false))
            // 设置文本的字体样式
            .fontStyle(spanFontStyle(nodeView))
            // 设置文本颜色
            .fontColor(spanFontColor(nodeView, true, markdownConfiguration.markdownTheme, false))
            // 设置文本字符间距
            .letterSpacing(markdownConfiguration.markdownTheme.paragraphTextWordSpace)
            // 设置文本装饰线样式及其颜色
            .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
            // 点击动作触发该方法调用
            .onClick {evt => tocListOnClickFunc(nodeView)}
    }

    /**
     * 内联HTML
     */
    @Builder
    func paragraphHtmlInlineComponent(htmlInline: HtmlInline) {
        // 文本内容
        if (htmlInline.getLiteral().toAsciiLower().replace(" ", "") == "<br>" ||
            htmlInline.getLiteral().toAsciiLower().replace(" ", "") == "</br>" ||
            htmlInline.getLiteral().toAsciiLower().replace(" ", "") == "<br/>") {
            // 设置文本内容
            Span("\n")
        } else {
            // TODO 其他内容，暂时只支持br标签
        }
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
                            .onClick {evt => latexImageOnClick(item.arrayUint8(), item.height().px, item.width().px, markdownConfiguration.latexImageCallback)}
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
     * 带样式的图片
     */
    @Builder
    func paragraphImageStyleComponent(styleImage: StyleImage, picStyleObj: PicStyleObj) {
        MarkdownImageStyleComponent(styleImage: styleImage, picStyleObj: picStyleObj,
            markdownConfiguration: markdownConfiguration)
    }

    /**
     * 图片
     */
    @Builder
    func paragraphImageSpanPixelMapComponent(ret: Int64, destination: String) {
        ForEach(
            arrayListPixelMap,
            itemGeneratorFunc: {
                item: ImageData, idx: Int64 => if (item.ret == ret) {
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
                commonmarkImage.getDestination())
        } else if (commonmarkImage.getDestination().startsWith("./")) {
            // rawfile图片
            paragraphImageSpanPixelMapComponent(localRowImageToPixelMap(commonmarkImage.getDestination(), idx),
                commonmarkImage.getDestination())
        } else if (commonmarkImage.getDestination().toAsciiLower().startsWith("http") ||
            commonmarkImage.getDestination().toAsciiLower().startsWith("ftp")) {
            // 网络图片
            paragraphImageSpanPixelMapComponent(httpImageToPixelMap(commonmarkImage.getDestination(), idx),
                commonmarkImage.getDestination())
        }
    }

    /**
     * 段落文字内容
     */
    @Builder
    func paragraphOtherComponent() {
        Text() {
            ForEach(
                paragraphNodeView.children.toArray(),
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        paragraphTextComponent(item)
                    } else if (item.node is HeadLink) {
                        // TOC列表
                        paragraphTextComponent(item)
                    } else if (item.node is Code) {
                        // 内联代码
                        paragraphCodeComponent(item)
                    } else if (item.node is HtmlInline) {
                        // 内联HTML
                        paragraphHtmlInlineComponent((item.node as HtmlInline)())
                    } else if (item.node is HardLineBreak) {
                        // 硬换行
                        Span("\n")
                    } else if (item.node is SoftLineBreak) {
                        // 软换行
                        Span(spanSoftLineBreak(markdownConfiguration.markdownTheme.isLineBreak))
                    } else if (item.node is ImgVideo) {
                        // TODO 视频节点
                        Span("")
                    } else if (item.node is StyleImage) {
                        // TODO 图片Style节点
                        Span("")
                    } else if (item.node is CommonmarkImage) {
                        // TODO 图片节点
                        paragraphImageSpanComponent((item.node as CommonmarkImage)(), idx)
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        paragraphLatexMathComponent(latexMathImagePixelmap((item.node as LatexMathNode)().latex, idx))
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
        .onDisAppear({=>
            threadFutureCancel(futs)
            delPixelMap(listPixelMap)
        })
    }

    /**
     * 判断是否是TOC列表还是链接，做不同的点击事件处理
     */
    func tocListOnClickFunc(nodeView: NodeView) {
        if (nodeView.node is HeadLink) {
            tocListOnClick((nodeView.node as HeadLink)().headIndex)
        } else {
            linkOnClick(nodeView, markdownConfiguration.linkCallback)
        }
    }

    /**
     * 数学公式数据处理 - 行内数学公式
     */
    func latexMathImagePixelmap(strLatexMath: String, idx: Int64): Int64 {
        let callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit = {
            pixelMap, height, width, arr => launch {
                arrayListPixelMap.append(ImageData(ret: idx, pixelMap: pixelMap, height: height, width: width,arrayUint8: arr))
            }
        }
        let fut = MarkdownParseLatexUtil.latexMathStrToPixelMapRow(strLatexMath, markdownConfiguration.markdownTheme.resPath,
            markdownConfiguration, componentWidth, callback)
        futs.append(fut)
        return idx
    }

    /**
     * 图片数据处理 - 本地沙盒图片
     */
    func filesPixelmap(destination: String, idx: Int64): Int64 {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            pixelMap, width, height => launch {
                arrayListPixelMap.append(ImageData(ret: idx, pixelMap: pixelMap, height: height, width: width))
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
        let fut = rawfileToPixelmap(destination, markdownConfiguration.markdownTheme.abilityContext, componentWidth, callback)
        futs.append(fut)
        return idx
    }

    /**
     * 图片数据处理 - 网络图片
     */
    func httpImageToPixelMap(destination: String, idx: Int64): Int64 {
        let callback: (?PixelMap, ?Float64, ?Float64) -> Unit = {
            pixelMap, width, height => launch {
                arrayListPixelMap.append(ImageData(ret: idx, pixelMap: pixelMap, height: height, width: width))
            }
        }
        let fut = getImageFromHttpClient(destination, componentWidth, callback)
        futs.append(fut)
        return idx
    }
}
