package markdown_hybrid

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownConfig {
    /**
     * 链接的点击事件
     */
    var linkCallback: ?(String) -> Unit = None

    /**
     * 文本复制的点击事件
     */
    var textCopyCallback: ?(String) -> Unit = None

    /**
     * 图片的点击事件
     */
    var imageCallback: ?(String, ArrayList<String>) -> Unit = None

    /**
     * 图片下载的点击事件
     */
    var imageDownloadCallback: ?(String) -> Unit = None

    /**
     * 音频的点击事件
     */
    var audioCallback: ?(String) -> Unit = None

    /**
     * 视频的点击事件
     */
    var videoCallback: ?(String, ArrayList<String>) -> Unit = None

    /**
     * 视频的图片替换回调
     */
    var videoImageCallback: ?(String, (String, Float64, Int64) -> Unit) -> Unit = None

    /**
     * 视频发布的点击事件
     */
    var videoReleaseCallback: ?(String) -> Unit = None

    /**
     * 视频下载的点击事件
     */
    var videoDownloadCallback: ?(String) -> Unit = None

    /**
     * 代码复制按钮的点击事件
     */
    var codeCopyCallback: ?(String) -> Unit = None

    /**
     * 代码全屏按钮的点击事件
     */
    var codeFullScreenCallback: ?(String, Option<String>) -> Unit = None

    /**
     * 数学公式图片点击事件
     */
    var latexImageCallback: ?(Array<UInt8>, Length, Length) -> Unit = None

    /**
     * 数学公式数据处理事件
     */
    var latexStrCallback: ?(String) -> String = None

    /**
     * TOC跳转指定位置
     */
    var tocIndexCallback: ?(Option<Int64>) -> Unit = None

    /**
     * 脚注跳转指定位置
     */
    var footnoteCallback: ?(Option<Int64>) -> Unit = None

    var nodeString: ?(NodeViewStringBuilder) -> Unit = None // 全部文本

    /**
     * markdown默认样式
     */
    var cjMarkdownTheme: CJMarkdownTheme = CJMarkdownTheme()

    /**
     * 表格复制按钮的点击事件
     */
    var tableCopyCallback: ?(String) -> Unit = None

    /**
     * 元素曝光回调（链接显示/消失时触发）
     */
    var elementExposureCallback: ?(CJMarkdownExposureEvent) -> Unit = None

    /**
     * 曝光可见阈值（0~1）
     */
    var exposureThreshold: Float64 = 0.5

    /**
     * 段落高亮配置
     */
    var cjMarkdownHighlightParagraph: CJMarkdownHighlightParagraph = CJMarkdownHighlightParagraph()

    /**
     * 外层滚动控制器（用于不固定高度模式下吸顶）
     */
    var cjScrollController: ?CJMarkdownScrollController = None

    /**
     * 段落动画开始回调
     */
    var paragraphHeadingAnimationStart: ?() -> Unit = None

    /**
     * 段落动画结束回调
     */
    var paragraphHeadingAnimationEnd: ?() -> Unit = None

    /**
     * 段落长按回调（返回段落纯文本内容）
     */
    var customLongPressCallback: ?(String) -> Unit = None

    /**
     * 满足自定义块级图片的条件
     */
    var isBlockImageCustom: ?(String) -> Bool = None

    /**
     * 满足自定义行内图片的条件
     */
    var isInLineImageCustom: ?(String) -> Bool = None

    /**
     * 满足自定义行内链接的条件
     */
    var isInLineLinkCustom: ?(String) -> Bool = None

    /**
     * 是否启用自定义卡片插件
     */
    var isBlockCustomCardPlugin: Bool = false

    /**
     * 满足块级图片自定义卡片条件 (desc, imageSrc, title)
     */
    var blockImageCard: ?(String, String, String) -> Bool = None

    /**
     * 满足块级链接自定义卡片条件 (desc, link, title)
     */
    var blockLinkCard: ?(String, String, String) -> Bool = None

    public init() {}

    /**
     * 设置链接的点击事件
     *
     * @param cb 链接点击回调接口 (链接url)
     */
    public func setLinkCallback(cb: (String) -> Unit): Unit {
        this.linkCallback = cb
    }

    /**
     * 设置文本复制的点击事件
     *
     * @param cb 文本复制的点击事件 (复制的文本)
     */
    public func setTextCopyCallback(cb: (String) -> Unit): Unit {
        this.textCopyCallback = cb
    }

    /**
     * 设置图片的点击事件
     *
     * @param cb 图片点击回调接口 (图片url，图片和视频url列表)
     */
    public func setImageCallback(cb: (String, JSArrayEx<String>) -> Unit): Unit {
        this.imageCallback = {
            url, list => cb(url, JSArrayEx<String>(list.toArray()))
        }
    }

    /**
     * 设置图片下载的点击事件
     *
     * @param cb 图片下载的点击事件 (图片url)
     */
    public func setImageDownloadCallback(cb: (String) -> Unit): Unit {
        this.imageDownloadCallback = cb
    }

    /**
     * 设置音频的点击事件
     *
     * @param cb 音频点击回调接口 (音频url)
     */
    public func setAudioCallback(cb: (String) -> Unit): Unit {
        this.audioCallback = cb
    }

    /**
     * 设置视频的点击事件
     *
     * @param cb 视频点击回调接口 (视频url，图片和视频url列表)
     */
    public func setVideoCallback(cb: (String, JSArrayEx<String>) -> Unit): Unit {
        this.videoCallback = {
            url, list => cb(url, JSArrayEx<String>(list.toArray()))
        }
    }

    /**
     * 设置视频的图片替换回调
     *
     * @param cb 视频的图片替换回调接口 - (视频url，(视频首帧图片url，图片宽高比，视频时长))
     */
    public func setVideoImageCallback(cb: (String, (String, Float64, Int64) -> Unit) -> Unit): Unit {
        this.videoImageCallback = cb
    }

    /**
     * 设置视频发布的点击事件
     *
     * @param videoReleaseCallback 视频发布的点击事件 (String:视频链接)
     */
    public func setVideoReleaseCallback(videoReleaseCallback: (String) -> Unit): Unit {
        this.videoReleaseCallback = videoReleaseCallback
    }

    /**
     * 设置视频下载的点击事件
     *
     * @param videoDownloadCallback 视频下载的点击事件 (String:视频链接)
     */
    public func setVideoDownloadCallback(videoDownloadCallback: (String) -> Unit): Unit {
        this.videoDownloadCallback = videoDownloadCallback
    }

    /**
     * 设置代码复制按钮的点击事件
     *
     * @param cb 代码复制点击回调接口 (代码内容)
     */
    public func setCodeCopyCallback(cb: (String) -> Unit): Unit {
        this.codeCopyCallback = cb
    }

    /**
     * 设置代码全屏按钮的点击事件
     *
     * @param cb 代码全屏点击回调接口 (代码内容，代码类型)
     */
    public func setCodeFullScreenCallback(cb: (String, Option<String>) -> Unit): Unit {
        this.codeFullScreenCallback = cb
    }

    /**
     * 设置数学公式图片点击事件
     *
     * @param cb 数学公式图片点击回调接口 (数学公式图片数组数据，高度，宽度)
     */
    public func setLatexImageCallback(cb: (Array<Byte>, Float64, Float64) -> Unit): Unit {
        this.latexImageCallback = {
            data, height, width => cb(data, height.value, width.value)
        }
    }

    /**
     * 设置数学公式数据处理事件
     *
     * @param cb 数学公式数据处理回调接口 (数学公式文本内容)：数学公式处理之后的文本内容
     */
    public func setLatexStrCallback(cb: (String) -> String): Unit {
        this.latexStrCallback = cb
    }

    /**
     * 设置TOC跳转指定位置
     *
     * @param cb TOC跳转指定位置接口 (第几条数据)
     */
    public func setTocIndexCallback(cb: (Option<Int64>) -> Unit): Unit {
        this.tocIndexCallback = cb
    }

    /**
     * 设置脚注跳转指定位置
     *
     * @param cb 脚注跳转指定位置接口 (第几条数据)
     */
    public func setFootnoteCallback(cb: (Option<Int64>) -> Unit): Unit {
        this.footnoteCallback = cb
    }

    /**
     * 设置获取markdown全文的回调
     *
     * @param nodeString 用于接收markdown全文的对象
     */
    public func setNodeString(nodeString: CJNodeViewStringBuilder): Unit {
        this.nodeString = {
            builder => nodeString.nodeViewStringBuilder = builder
        }
    }

    /**
     * 设置markdown默认样式
     *
     * @param cjMarkdownTheme Markdown基础样式
     */
    public func setCJMarkdownTheme(cjMarkdownTheme: CJMarkdownTheme): Unit {
        this.cjMarkdownTheme = cjMarkdownTheme
    }

    /**
     * 设置表格复制按钮的点击事件
     *
     * @param cb 表格复制点击回调接口 (String:表格纯文本内容)
     */
    public func setTableCopyCallback(cb: (String) -> Unit): Unit {
        this.tableCopyCallback = cb
    }

    /**
     * 设置元素曝光回调
     * 链接进入屏幕可见区域时回调 visible=true，离开时回调 visible=false
     *
     * @param cb 曝光回调 (CJMarkdownExposureEvent: { eventType, visible, data })
     */
    public func setElementExposureCallback(cb: (CJMarkdownExposureEvent) -> Unit): Unit {
        this.elementExposureCallback = cb
    }

    /**
     * 设置曝光可见阈值
     * 阈值范围 [0, 1]：>1 按 1 处理（完全可见才报），<0 按 0 处理（漏出即报）
     *
     * @param threshold 0~1，0=漏出任意像素即可见
     */
    public func setExposureThreshold(threshold: Float64): Unit {
        var t = threshold
        if (t > 1.0) {
            t = 1.0
        } else if (t < 0.0) {
            t = 0.0
        }
        this.exposureThreshold = t
    }

    /**
     * 设置段落高亮配置
     *
     * @param highlightParagraph 段落高亮配置对象
     */
    public func setMarkdownHighlightParagraph(highlightParagraph: CJMarkdownHighlightParagraph): Unit {
        this.cjMarkdownHighlightParagraph = highlightParagraph
    }

    /**
     * 获取段落高亮配置
     *
     * @return CJMarkdownHighlightParagraph 段落高亮配置对象
     */
    public func getMarkdownHighlightParagraph(): CJMarkdownHighlightParagraph {
        return this.cjMarkdownHighlightParagraph
    }

    /**
     * 设置外层滚动控制器
     * 不固定高度模式下，页面通过此控制器将外层Scroll的滚动Y传递给MarkdownComponent，
     * 实现表格吸顶功能。固定高度模式下无需设置。
     *
     * @param scrollController 外层滚动控制器
     */
    public func setScrollController(scrollController: CJMarkdownScrollController): Unit {
        this.cjScrollController = scrollController
    }

    /**
     * 设置段落动画开始回调
     *
     * @param cb 段落动画开始回调
     */
    public func setParagraphHeadingAnimationStart(cb: () -> Unit): Unit {
        this.paragraphHeadingAnimationStart = cb
    }

    /**
     * 设置段落动画结束回调
     *
     * @param cb 段落动画结束回调
     */
    public func setParagraphHeadingAnimationEnd(cb: () -> Unit): Unit {
        this.paragraphHeadingAnimationEnd = cb
    }

    /**
     * 设置段落长按回调
     * 长按段落时触发，回调参数为当前段落的纯文本内容
     *
     * @param cb 段落长按回调，参数为当前段落的纯文本内容
     */
    public func setCustomLongPressCallback(cb: (String) -> Unit): Unit {
        this.customLongPressCallback = cb
    }

    /**
     * 设置满足自定义块级图片的条件
     *
     * @param cb 满足自定义块级图片的条件 (图片alt或url)
     */
    public func setIsBlockImageCustom(cb: (String) -> Bool): Unit {
        this.isBlockImageCustom = cb
    }

    /**
     * 设置满足自定义行内图片的条件
     *
     * @param cb 满足自定义行内图片的条件 (图片alt或url)
     */
    public func setIsInLineImageCustom(cb: (String) -> Bool): Unit {
        this.isInLineImageCustom = cb
    }

    /**
     * 设置满足自定义行内链接的条件
     *
     * @param cb 满足自定义行内链接的条件 (链接描述或url)
     */
    public func setIsInLineLinkCustom(cb: (String) -> Bool): Unit {
        this.isInLineLinkCustom = cb
    }

    /**
     * 设置是否启用自定义卡片插件
     *
     * @param isBlockCustomCardPlugin 是否启用自定义卡片插件
     */
    public func setIsBlockCustomCardPlugin(isBlockCustomCardPlugin: Bool): Unit {
        this.isBlockCustomCardPlugin = isBlockCustomCardPlugin
    }

    /**
     * 设置块级图片自定义卡片条件回调
     *
     * @param cb 满足块级图片自定义卡片条件 (desc, imageSrc, title)
     */
    public func setBlockImageCard(cb: (String, String, String) -> Bool): Unit {
        this.blockImageCard = Some(cb)
    }

    /**
     * 设置块级链接自定义卡片条件回调
     *
     * @param cb 满足块级链接自定义卡片条件 (desc, link, title)
     */
    public func setBlockLinkCard(cb: (String, String, String) -> Bool): Unit {
        this.blockLinkCard = Some(cb)
    }
}
