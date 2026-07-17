package markdown.components

import ohos.state_macro_manage.*

/**
 * markdown配置
 * 使用 @Observed + @Publish 实现样式实时变动，修改markdownTheme后UI自动更新
 */
@Observed
public class MarkdownConfiguration {
    @Publish
    var markdownTheme: MarkdownTheme = MarkdownTheme.create() // markdown默认样式
    var textCopyCallback: ?(String) -> Unit = None // 文本复制的点击事件
    var linkCallback: ?(String) -> Unit = None // 链接的点击事件
    var imageCallback: ?(String, ArrayList<String>) -> Unit = None // 图片的点击事件
    var imageReplaceCallback: ?(String) -> ?Array<UInt8> = None // 图片替换事件
    var imageDownloadCallback: ?(String) -> Unit = None // 图片下载的点击事件
    var audioCallback: ?(String) -> Unit = None // 音频的点击事件
    var videoCallback: ?(String, ArrayList<String>) -> Unit = None // 视频的点击事件
    var videoImageCallback: (String, (String, Float64, Int64) -> Unit) -> Unit = {
        url: String, coverCallback: (String, Float64, Int64) -> Unit => ()
    } // 视频的图片替换回调
    var videoReleaseCallback: ?(String) -> Unit = None // 视频发布的点击事件
    var videoDownloadCallback: ?(String) -> Unit = None // 视频下载的点击事件
    var codeCopyCallback: ?(String) -> Unit = None // 代码复制按钮的点击事件
    var codeFullScreenCallback: ?(String, Option<String>) -> Unit = None // 代码全屏按钮的点击事件
    var latexImageCallback: ?(Array<UInt8>, Length, Length) -> Unit = None // 数学公式图片点击事件
    var latexStrCallback: (String) -> String = {
        data: String =>
            var dataNew = data.replace("{aligned*}", "{aligned}")
            dataNew = dataNew.replace("{align*}", "{align}")
            dataNew = dataNew.replace("{flalign*}", "{flalign}")
            dataNew = dataNew.replace("{gather*}", "{gather}")
            dataNew = dataNew.replace("{multline*}", "{multline}")
            dataNew = dataNew.replace("{eqnarray*}", "{eqnarray}")
            return dataNew
    } // 数学公式数据处理事件
    var tocIndexCallback: ?(?Int64) -> Unit = None // TOC跳转指定位置
    var footnoteCallback: ?(?Int64) -> Unit = None // 脚注跳转指定位置
    var nodeString: ?(NodeViewStringBuilder) -> Unit = None // 全部文本
    var tableCopyCallback: ?(String) -> Unit = None // 表格复制按钮的点击事件
    var elementExposureCallback: ?(MarkdownExposureEvent) -> Unit = None // 元素曝光回调（链接显示/消失时触发）
    var exposureThreshold: Float64 = 0.5 // 曝光可见阈值（0~1，链接与可见区交集面积/链接面积 ≥ 此值才算可见）
    var markdownHighlightParagraph: MarkdownHighlightParagraph = MarkdownHighlightParagraph() // 高亮段落设置
    var scrollController: ?MarkdownScrollController = None // 外层滚动控制器（用于不固定高度模式下吸顶）
    var paragraphAnimationStart: ?() -> Unit = None // 段落动画开始回调
    var paragraphAnimationEnd: ?() -> Unit = None // 段落动画结束回调
    var customLongPressCallback: ?(String) -> Unit = None // 段落长按回调（返回段落纯文本内容）

    /**
     * 创建Config对象
     * @Observed 类不能定义构造函数，由宏自动生成命名参数构造函数
     *
     * @return MarkdownConfiguration 创建空的MarkdownConfiguration对象
     */
    public static func create(): MarkdownConfiguration {
        return MarkdownConfiguration()
    }

    /**
     * 创建一个空的配置对象
     *
     * @return MarkdownConfiguration 创建空的MarkdownConfiguration对象
     */
    public static func createEmpty(): MarkdownConfiguration {
        return MarkdownConfiguration()
    }

    /**
     * 通过已有的Config创建新的配置对象
     *
     * @param copyFrom MarkdownConfiguration对象
     * @return MarkdownConfiguration 创建MarkdownConfiguration对象
     */
    public static func copy(copyFrom: MarkdownConfiguration): MarkdownConfiguration {
        return MarkdownConfiguration(markdownTheme: copyFrom.markdownTheme, textCopyCallback: copyFrom.textCopyCallback, linkCallback: copyFrom.linkCallback, imageCallback: copyFrom.imageCallback, imageReplaceCallback: copyFrom.imageReplaceCallback, imageDownloadCallback: copyFrom.imageDownloadCallback, audioCallback: copyFrom.audioCallback, videoCallback: copyFrom.videoCallback, videoImageCallback: copyFrom.videoImageCallback, videoReleaseCallback: copyFrom.videoReleaseCallback, videoDownloadCallback: copyFrom.videoDownloadCallback, codeCopyCallback: copyFrom.codeCopyCallback, codeFullScreenCallback: copyFrom.codeFullScreenCallback, latexImageCallback: copyFrom.latexImageCallback, latexStrCallback: copyFrom.latexStrCallback, tocIndexCallback: copyFrom.tocIndexCallback, footnoteCallback: copyFrom.footnoteCallback, nodeString: copyFrom.nodeString, tableCopyCallback: copyFrom.tableCopyCallback, elementExposureCallback: copyFrom.elementExposureCallback, exposureThreshold: copyFrom.exposureThreshold, markdownHighlightParagraph: copyFrom.markdownHighlightParagraph, scrollController: copyFrom.scrollController, paragraphAnimationStart: copyFrom.paragraphAnimationStart, paragraphAnimationEnd: copyFrom.paragraphAnimationEnd, customLongPressCallback: copyFrom.customLongPressCallback)
    }
    public func setMarkdownTheme(markdownTheme: MarkdownTheme): MarkdownConfiguration {
        this.markdownTheme = markdownTheme
        return this
    }

    /**
     * 设置文本复制的点击事件
     *
     * @param textCopyCallback 文本复制的点击事件 (String:复制文本)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setTextCopyCallback(textCopyCallback: (String) -> Unit): MarkdownConfiguration {
        this.textCopyCallback = textCopyCallback
        return this
    }

    /**
     * 设置链接的点击事件
     *
     * @param linkCallback 链接点击回调接口 (String:链接)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setLinkCallback(linkCallback: (String) -> Unit): MarkdownConfiguration {
        this.linkCallback = linkCallback
        return this
    }

    /**
     * 设置图片的点击事件
     *
     * @param imageCallback 图片点击回调接口 (String:图片链接，图片和视频链接列表)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setImageCallback(imageCallback: (String, ArrayList<String>) -> Unit): MarkdownConfiguration {
        this.imageCallback = imageCallback
        return this
    }

    /**
     * 设置图片替换事件
     *
     * @param imageCallbackCallback 图片替换回调接口 (String:图片链接 -> ?Array<UInt8>:图片数据)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    @Deprecated["用MarkdownConfiguration.setImageReplaceCallback方法代替", since: "1.4.0"]
    public func setImageCallbackCallback(imageCallbackCallback: (String) -> ?Array<UInt8>): MarkdownConfiguration {
        setImageReplaceCallback(imageCallbackCallback)
        return this
    }

    /**
     * 设置图片替换事件
     *
     * @param imageReplaceCallback 图片替换回调接口 (String:图片链接 -> ?Array<UInt8>:图片数据)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setImageReplaceCallback(imageReplaceCallback: (String) -> ?Array<UInt8>): MarkdownConfiguration {
        this.imageReplaceCallback = imageReplaceCallback
        return this
    }

    /**
     * 设置图片下载的点击事件
     *
     * @param imageDownloadCallback 图片下载的点击事件
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setImageDownloadCallback(imageDownloadCallback: (String) -> Unit): MarkdownConfiguration {
        this.imageDownloadCallback = imageDownloadCallback
        return this
    }

    /**
     * 设置音频的点击事件
     *
     * @param audioCallback 音频点击回调接口 (String:音频链接)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setAudioCallback(audioCallback: (String) -> Unit): MarkdownConfiguration {
        this.audioCallback = audioCallback
        return this
    }

    /**
     * 设置视频的点击事件
     *
     * @param videoCallback 视频点击回调接口 (String:视频URL，图片和视频链接列表)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setVideoCallback(videoCallback: (String, ArrayList<String>) -> Unit): MarkdownConfiguration {
        this.videoCallback = videoCallback
        return this
    }

    /**
     * 设置视频的图片替换回调
     *
     * @param videoImageCallback 视频的图片替换回调接口 - 图片url、宽高比、视频时长
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setVideoImageCallback(videoImageCallback: (String, (String, Float64, Int64) -> Unit) -> Unit): MarkdownConfiguration {
        this.videoImageCallback = videoImageCallback
        return this
    }

    /**
     * 设置视频发布的点击事件
     *
     * @param videoReleaseCallback 视频发布的点击事件 (String:视频链接)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setVideoReleaseCallback(videoReleaseCallback: (String) -> Unit): MarkdownConfiguration {
        this.videoReleaseCallback = videoReleaseCallback
        return this
    }

    /**
     * 设置视频下载的点击事件
     *
     * @param videoDownloadCallback 视频下载的点击事件 (String:视频链接)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setVideoDownloadCallback(videoDownloadCallback: (String) -> Unit): MarkdownConfiguration {
        this.videoDownloadCallback = videoDownloadCallback
        return this
    }

    /**
     * 设置代码复制按钮的点击事件
     *
     * @param codeCopyCallback 代码复制点击回调接口 (String:代码内容)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setCodeCopyCallback(codeCopyCallback: (String) -> Unit): MarkdownConfiguration {
        this.codeCopyCallback = codeCopyCallback
        return this
    }

    /**
     * 设置代码全屏按钮的点击事件
     *
     * @param codeFullScreenCallback 代码全屏点击回调接口 (String:代码内容,Option<String>:代码类型)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setCodeFullScreenCallback(codeFullScreenCallback: (String, Option<String>) -> Unit): MarkdownConfiguration {
        this.codeFullScreenCallback = codeFullScreenCallback
        return this
    }

    /**
     * 设置数学公式图片点击事件
     *
     * @param latexImageCallback 数学公式图片点击回调接口 (Array<UInt8>:图片数据,Length:高度,Length:宽度)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    @Deprecated["用MarkdownConfiguration.setLatexImageCallback方法代替", since: "1.4.0"]
    public func setLatexImageCallbackCallback(latexImageCallback: (Array<UInt8>, Length, Length) -> Unit): MarkdownConfiguration {
        setLatexImageCallback(latexImageCallback)
        return this
    }

    /**
     * 设置数学公式图片点击事件
     *
     * @param latexImageCallback 数学公式图片点击回调接口 (Array<UInt8>:图片数据,Length:高度,Length:宽度)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setLatexImageCallback(latexImageCallback: (Array<UInt8>, Length, Length) -> Unit): MarkdownConfiguration {
        this.latexImageCallback = latexImageCallback
        return this
    }


    /**
     * 设置数学公式数据处理事件
     *
     * @param latexStrCallback 数学公式数据处理回调接口 (参数String:数学公式的内容,返回值String:数学公式处理之后的内容)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setLatexStrCallback(latexStrCallback: (String) -> String): MarkdownConfiguration {
        this.latexStrCallback = latexStrCallback
        return this
    }

    /**
     * 设置TOC跳转指定位置
     *
     * @param tocIndexCallback TOC跳转指定位置接口 (?Int64:第几条数据)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setTocIndexCallback(tocIndexCallback: (?Int64) -> Unit): MarkdownConfiguration {
        this.tocIndexCallback = tocIndexCallback
        return this
    }

    /**
     * 设置脚注跳转指定位置
     *
     * @param footnoteCallback 脚注跳转指定位置接口 (?Int64:第几条数据)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setFootnoteCallback(footnoteCallback: (?Int64) -> Unit): MarkdownConfiguration {
        this.footnoteCallback = footnoteCallback
        return this
    }

    /**
     * 设置获取markdown全部文本
     *
     * @param nodeString markdown全部文本对象
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setNodeString(nodeString: (NodeViewStringBuilder) -> Unit): MarkdownConfiguration {
        this.nodeString = nodeString
        return this
    }

    /**
     * 设置表格复制按钮的点击事件
     *
     * @param tableCopyCallback 表格复制点击回调接口 (String:表格纯文本内容)
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setTableCopyCallback(tableCopyCallback: (String) -> Unit): MarkdownConfiguration {
        this.tableCopyCallback = tableCopyCallback
        return this
    }

    /**
     * 设置元素曝光回调
     * 链接（type='link'）进入屏幕可见区域时回调 visible=true，离开时回调 visible=false。
     * 可见判定：链接渲染矩形与段落在屏可见区交集面积 / 链接面积 ≥ exposureThreshold。
     * 同一链接持续停留不重复触发；滚出后再滚入会再次触发（一次显示+一次消失成对）。
     *
     * @param elementExposureCallback 曝光回调 (MarkdownExposureEvent: { type, visible, data })
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setElementExposureCallback(elementExposureCallback: (MarkdownExposureEvent) -> Unit): MarkdownConfiguration {
        this.elementExposureCallback = elementExposureCallback
        return this
    }

    /**
     * 设置曝光可见阈值
     *
     * @param threshold 0~1，链接与可见区交集面积 / 链接面积 ≥ 此值才算可见。0=漏出任意像素即可见
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setExposureThreshold(threshold: Float64): MarkdownConfiguration {
        this.exposureThreshold = threshold
        return this
    }

    /**
     * 设置高亮段落配置
     *
     * @param markdownHighlightParagraph 高亮段落配置对象
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setMarkdownHighlightParagraph(markdownHighlightParagraph: MarkdownHighlightParagraph): MarkdownConfiguration {
        this.markdownHighlightParagraph = markdownHighlightParagraph
        return this
    }

    /**
     * 设置外层滚动控制器
     * 不固定高度模式下，页面通过此控制器将外层Scroll的滚动Y传递给MarkdownComponent，
     * 实现表格吸顶功能。固定高度模式下无需设置。
     *
     * @param scrollController 外层滚动控制器
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setScrollController(scrollController: MarkdownScrollController): MarkdownConfiguration {
        this.scrollController = scrollController
        return this
    }

    /**
     * 设置段落动画开始回调
     *
     * @param cb 段落动画开始回调
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setParagraphAnimationStart(cb: () -> Unit): MarkdownConfiguration {
        this.paragraphAnimationStart = cb
        return this
    }

    /**
     * 设置段落动画结束回调
     *
     * @param cb 段落动画结束回调
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setParagraphAnimationEnd(cb: () -> Unit): MarkdownConfiguration {
        this.paragraphAnimationEnd = cb
        return this
    }

    /**
     * 设置段落长按回调
     * 长按段落时触发，回调参数为当前段落的纯文本内容
     *
     * 使用示例：
     * ```cangjie
     * let config = MarkdownConfiguration.createEmpty()
     *     .setCustomLongPressCallback({ text: String =>
     *         // text 为长按段落的纯文本内容，可在此处执行自定义操作（如弹Toast、跳转等）
     *         PromptAction.showToast(message: "长按段落: ${text}", duration: 2000)
     *     })
     * ```
     *
     * @param cb 段落长按回调，参数为当前段落的纯文本内容
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func setCustomLongPressCallback(cb: (String) -> Unit): MarkdownConfiguration {
        this.customLongPressCallback = cb
        return this
    }


}
