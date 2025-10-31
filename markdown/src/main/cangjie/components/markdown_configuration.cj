/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * markdown配置
 */
public class MarkdownConfiguration {
    /**
     * markdown默认样式
     */
    protected var markdownTheme: MarkdownTheme = MarkdownTheme.emptyBuilder().build()

    /**
     * 文本复制的点击事件
     */
    protected var textCopyCallback: ?(String) -> Unit = None

    /**
     * 链接的点击事件
     */
    protected var linkCallback: ?(String) -> Unit = None

    /**
     * 图片的点击事件
     */
    protected var imageCallback: ?(String, ArrayList<String>) -> Unit = None

    /**
     * 图片替换事件
     */
    protected var imageCallbackCallback: ?(String) -> ?Array<UInt8> = None

    /**
     * 音频的点击事件
     */
    protected var audioCallback: ?(String) -> Unit = None

    /**
     * 视频的点击事件
     */
    protected var videoCallback: ?(String, ArrayList<String>) -> Unit = None

    /**
     * 视频的图片替换回调
     */
    protected var videoImageCallback: (String, (String, Float64, Int64) -> Unit) -> Unit = {
        url: String, coverCallback: (String, Float64, Int64) -> Unit => ()
    }

    /**
     * 代码复制按钮的点击事件
     */
    protected var codeCopyCallback: ?(String) -> Unit = None

    /**
     * 代码全屏按钮的点击事件
     */
    protected var codeFullScreenCallback: ?(String, Option<String>) -> Unit = None

    /**
     * 数学公式图片点击事件
     */
    protected var latexImageCallback: ?(Array<UInt8>, Length, Length) -> Unit = None

    /**
     * 数学公式数据处理事件
     */
    protected var latexStrCallback: (String) -> String = {
        data: String =>
        var dataNew = data.replace("{aligned*}", "{aligned}")
        dataNew = dataNew.replace("{align*}", "{align}")
        dataNew = dataNew.replace("{flalign*}", "{flalign}")
        dataNew = dataNew.replace("{gather*}", "{gather}")
        dataNew = dataNew.replace("{multline*}", "{multline}")
        dataNew = dataNew.replace("{eqnarray*}", "{eqnarray}")
        return dataNew
    }

    /**
     * TOC跳转指定位置
     */
    protected var tocIndexCallback: ?(?Float64) -> Unit = None

    /**
     * 脚注跳转指定位置
     */
    protected var footnoteCallback: ?(?Float64) -> Unit = None

    /**
     * 全部文本
     */
    protected var nodeString: ?(NodeViewStringBuilder) -> Unit = None

    protected init(builder: MarkdownConfigurationBuilder) {
        this.markdownTheme = builder.markdownTheme
        this.textCopyCallback = builder.textCopyCallback
        this.linkCallback = builder.linkCallback
        this.imageCallback = builder.imageCallback
        this.imageCallbackCallback = builder.imageCallbackCallback
        this.audioCallback = builder.audioCallback
        this.videoCallback = builder.videoCallback
        this.videoImageCallback = builder.videoImageCallback
        this.codeCopyCallback = builder.codeCopyCallback
        this.codeFullScreenCallback = builder.codeFullScreenCallback
        this.latexImageCallback = builder.latexImageCallback
        this.latexStrCallback = builder.latexStrCallback
        this.tocIndexCallback = builder.tocIndexCallback
        this.footnoteCallback = builder.footnoteCallback
        this.nodeString = builder.nodeString
    }

    /**
     * 创建Config对象
     *
     * @return MarkdownConfiguration 创建空的MarkdownConfiguration对象
     */
    public static func create(): MarkdownConfiguration {
        return emptyBuilder().build()
    }

    /**
     * 创建一个空的builder对象
     *
     * @return MarkdownConfigurationBuilder 创建空的MarkdownConfigurationBuilder对象
     */
    public static func emptyBuilder(): MarkdownConfigurationBuilder {
        return MarkdownConfigurationBuilder()
    }

    /**
     * 通过已有的Config创建builder对象
     *
     * @param copyFrom MarkdownConfiguration对象
     * @return MarkdownConfigurationBuilder 创建MarkdownConfigurationBuilder对象
     */
    public static func builder(copyFrom: MarkdownConfiguration): MarkdownConfigurationBuilder {
        return MarkdownConfigurationBuilder(copyFrom)
    }
}

/**
 * MarkdownConfiguration Builder
 */
public class MarkdownConfigurationBuilder {
    /**
     * markdown默认样式
     */
    protected var markdownTheme: MarkdownTheme = MarkdownTheme.emptyBuilder().build()

    /**
     * 文本复制的点击事件
     */
    protected var textCopyCallback: ?(String) -> Unit = None

    /**
     * 链接的点击事件
     */
    protected var linkCallback: ?(String) -> Unit = None

    /**
     * 图片的点击事件
     */
    protected var imageCallback: ?(String, ArrayList<String>) -> Unit = None

    /**
     * 图片替换事件
     */
    protected var imageCallbackCallback: ?(String) -> ?Array<UInt8> = None

    /**
     * 音频的点击事件
     */
    protected var audioCallback: ?(String) -> Unit = None

    /**
     * 视频的点击事件
     */
    protected var videoCallback: ?(String, ArrayList<String>) -> Unit = None

    /**
     * 视频的图片替换回调
     */
    protected var videoImageCallback: (String, (String, Float64, Int64) -> Unit) -> Unit = {
        url: String, coverCallback: (String, Float64, Int64) -> Unit => ()
    }

    /**
     * 代码复制按钮的点击事件
     */
    protected var codeCopyCallback: ?(String) -> Unit = None

    /**
     * 代码全屏按钮的点击事件
     */
    protected var codeFullScreenCallback: ?(String, Option<String>) -> Unit = None

    /**
     * 数学公式图片点击事件
     */
    protected var latexImageCallback: ?(Array<UInt8>, Length, Length) -> Unit = None

    /**
     * 数学公式数据处理事件
     */
    protected var latexStrCallback: (String) -> String = {
        data: String =>
        var dataNew = data.replace("{aligned*}", "{aligned}")
        dataNew = dataNew.replace("{align*}", "{align}")
        dataNew = dataNew.replace("{flalign*}", "{flalign}")
        dataNew = dataNew.replace("{gather*}", "{gather}")
        dataNew = dataNew.replace("{multline*}", "{multline}")
        dataNew = dataNew.replace("{eqnarray*}", "{eqnarray}")
        return dataNew
    }

    /**
     * TOC跳转指定位置
     */
    protected var tocIndexCallback: ?(?Float64) -> Unit = None

    /**
     * 脚注跳转指定位置
     */
    protected var footnoteCallback: ?(?Float64) -> Unit = None

    /**
     * 全部文本
     */
    protected var nodeString: ?(NodeViewStringBuilder) -> Unit = None

    init() {
    }

    init(configuration: MarkdownConfiguration) {
        this.markdownTheme = configuration.markdownTheme
        this.textCopyCallback = configuration.textCopyCallback
        this.linkCallback = configuration.linkCallback
        this.imageCallback = configuration.imageCallback
        this.imageCallbackCallback = configuration.imageCallbackCallback
        this.audioCallback = configuration.audioCallback
        this.videoCallback = configuration.videoCallback
        this.videoImageCallback = configuration.videoImageCallback
        this.codeCopyCallback = configuration.codeCopyCallback
        this.codeFullScreenCallback = configuration.codeFullScreenCallback
        this.latexImageCallback = configuration.latexImageCallback
        this.latexStrCallback = configuration.latexStrCallback
        this.tocIndexCallback = configuration.tocIndexCallback
        this.footnoteCallback = configuration.footnoteCallback
        this.nodeString = configuration.nodeString
    }

    /**
     * 设置markdown默认样式
     *
     * @param markdownTheme Markdown基础样式
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setMarkdownTheme(markdownTheme: MarkdownTheme): MarkdownConfigurationBuilder {
        this.markdownTheme = markdownTheme
        return this
    }

    /**
     * 设置文本复制的点击事件
     *
     * @param textCopyCallback 文本复制的点击事件 (String:复制文本)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTextCopyCallback(textCopyCallback: (String) -> Unit): MarkdownConfigurationBuilder {
        this.textCopyCallback = textCopyCallback
        return this
    }

    /**
     * 设置链接的点击事件
     *
     * @param linkCallback 链接点击回调接口 (String:链接)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setLinkCallback(linkCallback: (String) -> Unit): MarkdownConfigurationBuilder {
        this.linkCallback = linkCallback
        return this
    }

    /**
     * 设置图片的点击事件
     *
     * @param imageCallback 图片点击回调接口 (String:图片链接，图片和视频链接列表)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setImageCallback(imageCallback: (String, ArrayList<String>) -> Unit): MarkdownConfigurationBuilder {
        this.imageCallback = imageCallback
        return this
    }

    /**
     * 设置图片替换事件
     *
     * @param imageCallbackCallback 图片替换回调接口 (String:图片链接 -> ?Array<UInt8>:图片数据)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setImageCallbackCallback(imageCallbackCallback: (String) -> ?Array<UInt8>): MarkdownConfigurationBuilder {
        this.imageCallbackCallback = imageCallbackCallback
        return this
    }

    /**
     * 设置音频的点击事件
     *
     * @param audioCallback 音频点击回调接口 (String:音频链接)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setAudioCallback(audioCallback: (String) -> Unit): MarkdownConfigurationBuilder {
        this.audioCallback = audioCallback
        return this
    }

    /**
     * 设置视频的点击事件
     *
     * @param videoCallback 视频点击回调接口 (String:视频ID，图片和视频链接列表)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setVideoCallback(videoCallback: (String, ArrayList<String>) -> Unit): MarkdownConfigurationBuilder {
        this.videoCallback = videoCallback
        return this
    }

    /**
     * 设置视频的图片替换回调
     *
     * @param videoImageCallback 视频的图片替换回调接口 - 图片url、宽高比、视频时长
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setVideoImageCallback(videoImageCallback: (String, (String, Float64, Int64) -> Unit) -> Unit): MarkdownConfigurationBuilder {
        this.videoImageCallback = videoImageCallback
        return this
    }

    /**
     * 设置代码复制按钮的点击事件
     *
     * @param codeCopyCallback 代码复制点击回调接口 (String:代码内容型)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setCodeCopyCallback(codeCopyCallback: (String) -> Unit): MarkdownConfigurationBuilder {
        this.codeCopyCallback = codeCopyCallback
        return this
    }

    /**
     * 设置代码全屏按钮的点击事件
     *
     * @param codeFullScreenCallback 代码全屏点击回调接口 (String:代码内容,Option<String>:代码类型)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setCodeFullScreenCallback(codeFullScreenCallback: (String, Option<String>) -> Unit): MarkdownConfigurationBuilder {
        this.codeFullScreenCallback = codeFullScreenCallback
        return this
    }

    /**
     * 设置数学公式图片点击事件
     *
     * @param latexImageCallback 数学公式图片点击回调接口 (Array<UInt8>:图片数据,Length:高度,Length:宽度)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setLatexImageCallbackCallback(latexImageCallback: (Array<UInt8>, Length, Length) -> Unit): MarkdownConfigurationBuilder {
        this.latexImageCallback = latexImageCallback
        return this
    }

    /**
     * 设置数学公式数据处理事件
     *
     * @param latexStrCallback 数学公式数据处理回调接口 (参数String:数学公式的内容,返回值String:数学公式处理之后的内容)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setLatexStrCallback(latexStrCallback: (String) -> String): MarkdownConfigurationBuilder {
        this.latexStrCallback = latexStrCallback
        return this
    }

    /**
     * 设置TOC跳转指定位置
     *
     * @param tocIndexCallback TOC跳转指定位置接口 (?Float64:位置距离)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTocIndexCallback(tocIndexCallback: (?Float64) -> Unit): MarkdownConfigurationBuilder {
        this.tocIndexCallback = tocIndexCallback
        return this
    }

    /**
     * 设置脚注跳转指定位置
     *
     * @param footnoteCallback 脚注跳转指定位置接口 (?Float64:位置距离)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setFootnoteCallback(footnoteCallback: (?Float64) -> Unit): MarkdownConfigurationBuilder {
        this.footnoteCallback = footnoteCallback
        return this
    }

    /**
     * 设置全部文本
     *
     * @param nodeString 全部文本
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setNodeString(nodeString: (NodeViewStringBuilder) -> Unit): MarkdownConfigurationBuilder {
        this.nodeString = nodeString
        return this
    }

    /**
     * 返回Config对象
     *
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func build(): MarkdownConfiguration {
        return MarkdownConfiguration(this)
    }
}
