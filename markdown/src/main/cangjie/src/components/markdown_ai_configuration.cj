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
     * 插件化使用
     */
    protected var markdownParser: ?Markdown = None

    /**
     * 链接的点击事件
     */
    protected var linkCallback: ?(String) -> Unit = None

    /**
     * 图片的点击事件
     */
    protected var imageCallback: ?(String,ArrayList<String>) -> Unit = None

    /**
     * 视频的点击事件
     */
    protected var videoCallback: ?(String,ArrayList<String>) -> Unit = None

    /**
     * 视频的图片替换回调
     */
    protected var videoImageCallback: (String, (String) -> Unit) -> Unit = {
        url: String, coverCallback: (String) -> Unit => ()
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
     * 超大数据跳转页面显示全部数据
     */
    protected var listBigDataCallback: ?(NodeView, Float64, Float64, Float64) -> Unit = None

    protected init(builder: MarkdownAIConfigurationBuilder) {
        this.markdownAITheme = builder.markdownAITheme
        // 插件化
        this.markdownParser = builder.markdownParser
        this.linkCallback = builder.linkCallback
        this.imageCallback = builder.imageCallback
        this.videoCallback = builder.videoCallback
        this.videoImageCallback = builder.videoImageCallback
        this.codeCopyCallback = builder.codeCopyCallback
        this.codeFullScreenCallback = builder.codeFullScreenCallback
        this.latexImageCallback = builder.latexImageCallback
        this.latexStrCallback = builder.latexStrCallback
        this.tocIndexCallback = builder.tocIndexCallback
        this.footnoteCallback = builder.footnoteCallback
        this.listBigDataCallback = builder.listBigDataCallback
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
     * 插件化使用
     */
    protected var markdownParser: ?Markdown = None

    /**
     * 链接的点击事件
     */
    protected var linkCallback: ?(String) -> Unit = None

    /**
     * 图片的点击事件
     */
    protected var imageCallback: ?(String,ArrayList<String>) -> Unit = None

    /**
     * 视频的点击事件
     */
    protected var videoCallback: ?(String,ArrayList<String>) -> Unit = None

    /**
     * 视频的图片替换回调
     */
    protected var videoImageCallback: (String, (String) -> Unit) -> Unit = {
        url: String, coverCallback: (String) -> Unit => ()
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
     * 超大数据跳转页面显示全部数据
     */
    protected var listBigDataCallback: ?(NodeView, Float64, Float64, Float64) -> Unit = None

    init() {
    }

    init(configuration: MarkdownAIConfiguration) {
        this.markdownAITheme = configuration.markdownAITheme
        // 插件化
        this.markdownParser = configuration.markdownParser
        this.linkCallback = configuration.linkCallback
        this.imageCallback = configuration.imageCallback
        this.videoCallback = configuration.videoCallback
        this.videoImageCallback = configuration.videoImageCallback
        this.codeCopyCallback = configuration.codeCopyCallback
        this.codeFullScreenCallback = configuration.codeFullScreenCallback
        this.latexImageCallback = configuration.latexImageCallback
        this.latexStrCallback = configuration.latexStrCallback
        this.tocIndexCallback = configuration.tocIndexCallback
        this.footnoteCallback = configuration.footnoteCallback
        this.listBigDataCallback = configuration.listBigDataCallback
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
     * 设置markdown核心解析器
     *
     * @param markdownPlugin markdown核心解析器
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setMarkdownParser(markdownParser: Markdown): MarkdownAIConfigurationBuilder {
        this.markdownParser = markdownParser
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
     * @param imageCallback 图片点击回调接口 (String:图片链接)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setImageCallback(imageCallback: (String,ArrayList<String>) -> Unit): MarkdownAIConfigurationBuilder {
        this.imageCallback = imageCallback
        return this
    }

    /**
     * 设置视频的点击事件
     *
     * @param videoCallback 视频点击回调接口 (String:视频ID)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setVideoCallback(videoCallback: (String,ArrayList<String>) -> Unit): MarkdownAIConfigurationBuilder {
        this.videoCallback = videoCallback
        return this
    }

    /**
     * 设置视频的图片替换回调
     *
     * @param videoImageCallback 视频的图片替换回调接口
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setVideoImageCallback(videoImageCallback: (String, (String) -> Unit) -> Unit): MarkdownAIConfigurationBuilder {
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
     * 设置超大数据跳转页面显示全部数据
     *
     * @param listBigDataCallback 超大数据跳转页面显示全部数据接口 (NodeView:NodeView数据,Float64:上外边距,Float64:下外边距,Float64:控件宽度)
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setListBigDataCallback(listBigDataCallback: ?(NodeView, Float64, Float64, Float64) -> Unit): MarkdownAIConfigurationBuilder {
        this.listBigDataCallback = listBigDataCallback
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
