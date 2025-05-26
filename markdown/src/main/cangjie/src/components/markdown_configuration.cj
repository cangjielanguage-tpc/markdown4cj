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
    protected var imageCallback: ?(String) -> Unit = None

    /**
     * 视频的点击事件
     */
    protected var videoCallback: ?(String) -> Unit = None

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

    protected init(builder: MarkdownConfigurationBuilder) {
        this.markdownTheme = builder.markdownTheme
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
    protected var imageCallback: ?(String) -> Unit = None

    /**
     * 视频的点击事件
     */
    protected var videoCallback: ?(String) -> Unit = None

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

    init(configuration: MarkdownConfiguration) {
        this.markdownTheme = configuration.markdownTheme
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
     * @param markdownTheme Markdown基础样式
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setMarkdownTheme(markdownTheme: MarkdownTheme): MarkdownConfigurationBuilder {
        this.markdownTheme = markdownTheme
        return this
    }

    /**
     * 设置markdown核心解析器
     *
     * @param markdownPlugin markdown核心解析器
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setMarkdownParser(markdownParser: Markdown): MarkdownConfigurationBuilder {
        this.markdownParser = markdownParser
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
     * @param imageCallback 图片点击回调接口 (String:图片链接)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setImageCallback(imageCallback: (String) -> Unit): MarkdownConfigurationBuilder {
        this.imageCallback = imageCallback
        return this
    }

    /**
     * 设置视频的点击事件
     *
     * @param videoCallback 视频点击回调接口 (String:视频ID)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setVideoCallback(videoCallback: (String) -> Unit): MarkdownConfigurationBuilder {
        this.videoCallback = videoCallback
        return this
    }

    /**
     * 设置视频的图片替换回调
     *
     * @param videoImageCallback 视频的图片替换回调接口
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setVideoImageCallback(videoImageCallback: (String, (String) -> Unit) -> Unit): MarkdownConfigurationBuilder {
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
     * 设置超大数据跳转页面显示全部数据
     *
     * @param listBigDataCallback 超大数据跳转页面显示全部数据接口 (NodeView:NodeView数据,Float64:上外边距,Float64:下外边距,Float64:控件宽度)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setListBigDataCallback(listBigDataCallback: ?(NodeView, Float64, Float64, Float64) -> Unit): MarkdownConfigurationBuilder {
        this.listBigDataCallback = listBigDataCallback
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
