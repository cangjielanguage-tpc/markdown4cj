/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.ark_interop.*
import ohos.ark_interop_helper.*
import ohos.ark_interop_macro.*
import std.collection.*

@Interop[ArkTS]
public class CJMarkdownPlugin {
    /**
     * 是否加载音频解析插件
     */
    var isBlockAudioPlugin: Bool = false

    /**
     * 是否加载视频解析插件
     */
    var isBlockVideoPlugin: Bool = false

    /**
     * 是否加载代码列表解析插件
     */
    var isCodeListPlugin: Bool = false

    /**
     * 是否加载脚注解析插件
     */
    var isFootnotePlugin: Bool = false

    /**
     * 是否加载html解析插件
     */
    var isHtmlPlugin: Bool = false

    /**
     * 是否加载表格解析插件
     */
    var isTablePlugin: Bool = false

    /**
     * 是否加载toc解析插件
     */
    var isTocPlugin: Bool = false

    /**
     * 是否加载任务列表解析插件
     */
    var isTaskListPlugin: Bool = false

    /**
     * 是否加载删除线解析插件
     */
    var isStrikethroughPlugin: Bool = false

    /**
     * 是否加载链接自动解析插件
     */
    var isLinkifyPlugin: Bool = false

    /**
     * 是否加载链接单独解析插件
     */
    var isLinkViewPlugin: Bool = false

    /**
     * 是否加载数学公式解析插件
     */
    var isLatexMathPlugin: Bool = false

    /**
     * 是否加载图片自定义样式解析插件
     */
    var isImageStylePlugin: Bool = false

    /**
     * 是否加载图片banner解析插件
     */
    var isImageSlidePlugin: Bool = false

    /**
     * 是否加载图片单独提取到block解析插件
     */
    var isImageTextMixPlugin: Bool = false

    /**
     * 是否加载图片视频列表url集合列表解析插件
     */
    var isImageCollectPlugin: Bool = false

    /**
     * 是否加载定义列表解析插件
     */
    var isDescListPlugin: Bool = false

    /**
     * 是否加载标题ID解析插件
     */
    var isHeadIDPlugin: Bool = false

    public init() {}

    /**
     * 设置是否加载音频解析插件
     *
     * @param isBlockAudioPlugin
     */
    public func setIsBlockAudioPlugin(isBlockAudioPlugin: Bool): Unit {
        this.isBlockAudioPlugin = isBlockAudioPlugin
    }

    /**
     * 设置是否加载视频解析插件
     *
     * @param isBlockVideoPlugin
     */
    public func setIsBlockVideoPlugin(isBlockVideoPlugin: Bool): Unit {
        this.isBlockVideoPlugin = isBlockVideoPlugin
    }

    /**
     * 设置是否加载代码列表解析插件
     *
     * @param isCodeListPlugin
     */
    public func setIsCodeListPlugin(isCodeListPlugin: Bool): Unit {
        this.isCodeListPlugin = isCodeListPlugin
    }

    /**
     * 设置是否加载脚注插件
     *
     * @param isFootnotePlugin
     */
    public func setIsFootnotePlugin(isFootnotePlugin: Bool): Unit {
        this.isFootnotePlugin = isFootnotePlugin
    }

    /**
     * 设置是否加载HTML解析插件
     *
     * @param isHtmlPlugin
     */
    public func setIsHtmlPlugin(isHtmlPlugin: Bool): Unit {
        this.isHtmlPlugin = isHtmlPlugin
    }

    /**
     * 设置是否加载表格解析插件
     *
     * @param isTablePlugin
     */
    public func setIsTablePlugin(isTablePlugin: Bool): Unit {
        this.isTablePlugin = isTablePlugin
    }

    /**
     * 设置是否加载TOC解析插件
     *
     * @param isTocPlugin
     */
    public func setIsTocPlugin(isTocPlugin: Bool): Unit {
        this.isTocPlugin = isTocPlugin
    }

    /**
     * 设置是否加载任务列表解析插件
     *
     * @param isTaskListPlugin
     */
    public func setIsTaskListPlugin(isTaskListPlugin: Bool): Unit {
        this.isTaskListPlugin = isTaskListPlugin
    }

    /**
     * 设置是否加载删除线解析插件
     *
     * @param isStrikethroughPlugin
     */
    public func setIsStrikethroughPlugin(isStrikethroughPlugin: Bool): Unit {
        this.isStrikethroughPlugin = isStrikethroughPlugin
    }

    /**
     * 设置是否加载链接自动解析解析插件
     *
     * @param isLinkifyPlugin
     */
    public func setIsLinkifyPlugin(isLinkifyPlugin: Bool): Unit {
        this.isLinkifyPlugin = isLinkifyPlugin
    }

    /**
     * 设置是否加载链接单独块解析插件
     *
     * @param isLinkViewPlugin
     */
    public func setIsLinkViewPlugin(isLinkViewPlugin: Bool): Unit {
        this.isLinkViewPlugin = isLinkViewPlugin
    }

    /**
     * 设置是否加载数学公式解析插件
     *
     * @param isLatexMathPlugin
     */
    public func setIsLatexMathPlugin(isLatexMathPlugin: Bool): Unit {
        this.isLatexMathPlugin = isLatexMathPlugin
    }

    /**
     * 设置是否加载图片自定义样式解析插件
     *
     * @param isImageStylePlugin
     */
    public func setIsImageStylePlugin(isImageStylePlugin: Bool): Unit {
        this.isImageStylePlugin = isImageStylePlugin
    }

    /**
     * 设置是否加载图片banner解析插件
     *
     * @param isImageSlidePlugin
     */
    public func setIsImageSlidePlugin(isImageSlidePlugin: Bool): Unit {
        this.isImageSlidePlugin = isImageSlidePlugin
    }

    /**
     * 设置是否加载不图文混排插件解析插件
     *
     * @param isImageTextMixPlugin
     */
    public func setIsImageTextMixPlugin(isImageTextMixPlugin: Bool): Unit {
        this.isImageTextMixPlugin = isImageTextMixPlugin
    }

    /**
     * 设置是否加载图片单独提取到block解析插件
     *
     * @param isImageCollectPlugin
     */
    public func setIsImageCollectPlugin(isImageCollectPlugin: Bool): Unit {
        this.isImageCollectPlugin = isImageCollectPlugin
    }

    /**
     * 设置是否加载定义列表解析插件
     *
     * @param isDescListPlugin
     */
    public func setIsDescListPlugin(isDescListPlugin: Bool): Unit {
        this.isDescListPlugin = isDescListPlugin
    }

    /**
     * 设置是否加载标题ID解析插件
     *
     * @param isHeadIDPlugin
     */
    public func setIsHeadIDPlugin(isHeadIDPlugin: Bool): Unit {
        this.isHeadIDPlugin = isHeadIDPlugin
    }
}
