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
public class MarkdownAIConfiguration {
    /**
     * markdown默认样式
     */
    protected var markdownAITheme: MarkdownAITheme = MarkdownAITheme.emptyBuilder().build()

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
        var dataNew = data.replace("\\\\\\\\", "\\\\\\text{ }\\\\").replace("\\\\\\\\", "\\\\\\text{ }\\\\")
        dataNew = dataNew.replace("{aligned*}", "{aligned}")
        dataNew = dataNew.replace("{align*}", "{align}")
        dataNew = dataNew.replace("{flalign*}", "{flalign}")
        dataNew = dataNew.replace("{gather*}", "{gather}")
        dataNew = dataNew.replace("{multline*}", "{multline}")
        dataNew = dataNew.replace("{eqnarray*}", "{eqnarray}")
        dataNew = dataNew.replace("\\\\frac", "\\frac")
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

    protected init(builder: MarkdownAIConfigurationBuilder) {
        this.markdownAITheme = builder.markdownAITheme
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
    }

    /**
     * 创建Config对象
     *
     * @return MarkdownAIConfiguration 创建空的MarkdownAIConfiguration对象
     */
    public static func create(): MarkdownAIConfiguration {
        return emptyBuilder().build()
    }

    /**
     * 创建一个空的builder对象
     *
     * @return MarkdownAIConfigurationBuilder 创建空的MarkdownAIConfigurationBuilder对象
     */
    public static func emptyBuilder(): MarkdownAIConfigurationBuilder {
        return MarkdownAIConfigurationBuilder()
    }

    /**
     * 通过已有的Config创建builder对象
     *
     * @param copyFrom MarkdownAIConfiguration对象
     * @return MarkdownAIConfigurationBuilder 创建MarkdownAIConfigurationBuilder对象
     */
    public static func builder(copyFrom: MarkdownAIConfiguration): MarkdownAIConfigurationBuilder {
        return MarkdownAIConfigurationBuilder(copyFrom)
    }
}

/**
 * MarkdownAIConfiguration Builder
 */
public class MarkdownAIConfigurationBuilder {
    /**
     * markdown默认样式
     */
    protected var markdownAITheme: MarkdownAITheme = MarkdownAITheme.emptyBuilder().build()

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
        var dataNew = data.replace("\\\\\\\\", "\\\\\\text{ }\\\\").replace("\\\\\\\\", "\\\\\\text{ }\\\\")
        dataNew = dataNew.replace("{aligned*}", "{aligned}")
        dataNew = dataNew.replace("{align*}", "{align}")
        dataNew = dataNew.replace("{flalign*}", "{flalign}")
        dataNew = dataNew.replace("{gather*}", "{gather}")
        dataNew = dataNew.replace("{multline*}", "{multline}")
        dataNew = dataNew.replace("{eqnarray*}", "{eqnarray}")
        dataNew = dataNew.replace("\\\\frac", "\\frac")
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

    init() {
    }

    init(configuration: MarkdownAIConfiguration) {
        this.markdownAITheme = configuration.markdownAITheme
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
    }

    /**
     * 设置markdown默认样式
     *
     * @param markdownAITheme Markdown基础样式
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setMarkdownAITheme(markdownAITheme: MarkdownAITheme): MarkdownAIConfigurationBuilder {
        this.markdownAITheme = markdownAITheme
        return this
    }

    /**
     * 设置文本复制的点击事件
     *
     * @param textCopyCallback 文本复制的点击事件 (String:复制文本)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setTextCopyCallback(textCopyCallback: (String) -> Unit): MarkdownAIConfigurationBuilder {
        this.textCopyCallback = textCopyCallback
        return this
    }

    /**
     * 设置链接的点击事件
     *
     * @param linkCallback 链接点击回调接口 (String:链接)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setLinkCallback(linkCallback: (String) -> Unit): MarkdownAIConfigurationBuilder {
        this.linkCallback = linkCallback
        return this
    }

    /**
     * 设置图片的点击事件
     *
     * @param imageCallback 图片点击回调接口 (String:图片链接，图片和视频链接列表)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setImageCallback(imageCallback: (String, ArrayList<String>) -> Unit): MarkdownAIConfigurationBuilder {
        this.imageCallback = imageCallback
        return this
    }

    /**
     * 设置图片替换事件
     *
     * @param imageCallbackCallback 图片替换回调接口 (String:图片链接 -> ?Array<UInt8>:图片数据)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setImageCallbackCallback(imageCallbackCallback: (String) -> ?Array<UInt8>): MarkdownAIConfigurationBuilder {
        this.imageCallbackCallback = imageCallbackCallback
        return this
    }

    /**
     * 设置音频的点击事件
     *
     * @param audioCallback 音频点击回调接口 (String:音频链接)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setAudioCallback(audioCallback: (String) -> Unit): MarkdownAIConfigurationBuilder {
        this.audioCallback = audioCallback
        return this
    }

    /**
     * 设置视频的点击事件
     *
     * @param videoCallback 视频点击回调接口 (String:视频ID，图片和视频链接列表)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setVideoCallback(videoCallback: (String, ArrayList<String>) -> Unit): MarkdownAIConfigurationBuilder {
        this.videoCallback = videoCallback
        return this
    }

    /**
     * 设置视频的图片替换回调
     *
     * @param videoImageCallback 视频的图片替换回调接口 - 图片url、宽高比、视频时长
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setVideoImageCallback(videoImageCallback: (String, (String, Float64, Int64) -> Unit) -> Unit): MarkdownAIConfigurationBuilder {
        this.videoImageCallback = videoImageCallback
        return this
    }

    /**
     * 设置代码复制按钮的点击事件
     *
     * @param codeCopyCallback 代码复制点击回调接口 (String:代码内容型)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setCodeCopyCallback(codeCopyCallback: (String) -> Unit): MarkdownAIConfigurationBuilder {
        this.codeCopyCallback = codeCopyCallback
        return this
    }

    /**
     * 设置代码全屏按钮的点击事件
     *
     * @param codeFullScreenCallback 代码全屏点击回调接口 (String:代码内容,Option<String>:代码类型)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setCodeFullScreenCallback(codeFullScreenCallback: (String, Option<String>) -> Unit): MarkdownAIConfigurationBuilder {
        this.codeFullScreenCallback = codeFullScreenCallback
        return this
    }

    /**
     * 设置数学公式图片点击事件
     *
     * @param latexImageCallback 数学公式图片点击回调接口 (Array<UInt8>:图片数据,Length:高度,Length:宽度)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setLatexImageCallbackCallback(latexImageCallback: (Array<UInt8>, Length, Length) -> Unit): MarkdownAIConfigurationBuilder {
        this.latexImageCallback = latexImageCallback
        return this
    }

    /**
     * 设置数学公式数据处理事件
     *
     * @param latexStrCallback 数学公式数据处理回调接口 (参数String:数学公式的内容,返回值String:数学公式处理之后的内容)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setLatexStrCallback(latexStrCallback: (String) -> String): MarkdownAIConfigurationBuilder {
        this.latexStrCallback = latexStrCallback
        return this
    }

    /**
     * 设置TOC跳转指定位置
     *
     * @param tocIndexCallback TOC跳转指定位置接口 (?Float64:位置距离)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setTocIndexCallback(tocIndexCallback: (?Float64) -> Unit): MarkdownAIConfigurationBuilder {
        this.tocIndexCallback = tocIndexCallback
        return this
    }

    /**
     * 设置脚注跳转指定位置
     *
     * @param footnoteCallback 脚注跳转指定位置接口 (?Float64:位置距离)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setFootnoteCallback(footnoteCallback: (?Float64) -> Unit): MarkdownAIConfigurationBuilder {
        this.footnoteCallback = footnoteCallback
        return this
    }

    /**
     * 返回Config对象
     *
     * @return MarkdownAIConfiguration MarkdownAIConfiguration对象
     */
    public func build(): MarkdownAIConfiguration {
        return MarkdownAIConfiguration(this)
    }
}
