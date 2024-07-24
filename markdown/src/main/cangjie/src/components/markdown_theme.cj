/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown用户可设置的样式
 * 0: 每个模块之间上下间距，上下文
 * 1：链接（连接颜色，是否显示链接下划线）
 * 2：块引用、有序列表、无序列表、任务列表、TOC列表（左边距，块引用左边线条宽度，块引用左边线条颜色，有序列表项的颜色，有序列表项的大小，无序列表项的颜色，无序列表项的大小，任务列表项的宽高）
 * 3：内联代码、缩进代码、围栏代码、组合代码（内联代码文本颜色，内联代码背景颜色，内联代码文本字体，内联代码文本大小，代码块系列（缩进代码、围栏代码、组合代码）文本颜色，代码块系列（缩进代码、围栏代码、组合代码）背景颜色，代码块系列（缩进代码、围栏代码、组合代码）左边距，代码块系列（缩进代码、围栏代码、组合代码）字体，代码块系列（缩进代码、围栏代码、组合代码）文本大小，是否显示代码全屏按钮，代码全屏按钮和代码复制按钮的宽高，代码全屏按钮默认图标，代码复制按钮默认图标，组合代码标题文本大小，组合代码标题选中文本颜色，组合代码标题未选中文本颜色，组合代码标题选中背景颜色，组合代码标题未选中背景颜色）
 * 4：标题（一级标题二级标题下划线高度，一级标题二级标题下划线颜色，标题文字字体，标题文字大小，标题文字颜色）
 * 5：段落（段落字体大小，段落字体颜色）
 * 6：分割线（分割线高度，分割线颜色）
 * 7：软换行（软换行是否换行）
 * 8：数学公式（数学公式文字大小，数学公式行距，数学公式背景色，数学公式字体颜色，数学公式图片格式，数学公式资源目录路径）
 * 9：视频（视频默认占位图，视频播放按钮默认图标）
 * 10：图片Banner（图片banner默认占位图）
 * 11：图片（图片宽度边距 - 计算屏幕宽度需要减去padding的宽度单位vp，图片默认占位图，图片是否压缩）
 */
public class MarkdownTheme {
    /**
     * 上下文
     */
    protected var abilityContext: ?AbilityContext = None

    /**
     * 每个模块之间上下间距
     */
    protected var blockTopAndBottomMargins: Float64 = 8.0

    /**
     * 链接颜色
     */
    protected var linkColor: Color = Color(0x0000FF)

    /**
     * 是否显示链接下划线
     */
    protected var isLinkUnderlined: Bool = true

    /**
     * 有序列表、无序列表、任务列表、块引用左边距
     */
    protected var blockMargin: Float64 = 24.0

    /**
     * 块引用左边线条宽度
     */
    protected var blockQuoteWidth: Float64 = 1.0

    /**
     * 块引用左边线条颜色
     */
    protected var blockQuoteColor: Color = Color(0x191919)

    /**
     * 有序列表列表项的颜色。
     */
    protected var orderedListItemColor: Color = Color(0x191919)

    /**
     * 有序列表项的文本大小。
     */
    protected var orderedListItemSize: Float64 = 14.0

    /**
     * 无序列表项的颜色。
     */
    protected var bulletListItemColor: Color = Color(0x191919)

    /**
     * 无序列表项的文本大小。
     */
    protected var bulletListItemSize: Float64 = 14.0

    /**
     * 任务列表项的宽高。
     */
    protected var taskListItemLength: Float64 = 15.0

    /**
     * 内联代码文本颜色
     */
    protected var codeTextColor: Color = Color(0x000000)

    /**
     * 内联代码背景颜色
     */
    protected var codeBackgroundColor: Color = Color(0x191919)

    /**
     * 内联代码文本字体
     */
    protected var codeTypeface: String = "HarmonyOS Sans"

    /**
     * 内联代码文本大小
     */
    protected var codeTextSize: Float64 = 13.0

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）文本颜色
     */
    protected var codeBlockTextColor: ?Color = None

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）背景颜色
     */
    protected var codeBlockBackgroundColor: ?Color = None

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）左边距
     */
    protected var codeMultilineMargin: Float64 = 8.0

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）字体
     */
    protected var codeBlockTypeface: String = "HarmonyOS Sans"

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）文本大小
     */
    protected var codeBlockTextSize: Float64 = 13.0

    /**
     * 是否显示代码全屏按钮
     */
    protected var isCodeFullScreen: Bool = true

    /**
     * 代码全屏按钮和代码复制按钮的宽高
     */
    protected var iconWidthAndHeight: Float64 = 24.0

    /**
     * 代码全屏按钮默认图标
     */
    protected var codeFullScreenIcon: ?CJResource = None

    /**
     * 代码复制按钮默认图标
     */
    protected var codeCopyIcon: ?CJResource = None

    /**
     * 组合代码标题字体大小
     */
    protected var codeListTitleTextSize: Float64 = 13.0

    /**
     * 组合代码标题字体大小
     */
    protected var codeListTitleSelectTextSize: Float64 = 13.0

    /**
     * 组合代码标题选中文本颜色
     */
    protected var codeListTitleSelectTextColor: Color = Color.RED

    /**
     * 组合代码标题未选中文本颜色
     */
    protected var codeListTitleUnSelectTextColor: Color = Color.BLACK

    /**
     * 组合代码标题选中背景颜色
     */
    protected var codeListTitleSelectBackgroupColor: Color = Color.GRAY

    /**
     * 组合代码标题未选中背景颜色
     */
    protected var codeListTitleUnSelectBackgroupColor: Color = Color.TRANSPARENT

    /**
     * H1、H2标题下分割线高度
     */
    protected var headingBreakHeight: Float64 = 0.5

    /**
     * H1、H2标题下分割线颜色
     */
    protected var headingBreakColor: Color = Color(0x191919)

    /**
     * 标题元素字体
     */
    protected var headingTypeface: String = "HarmonyOS Sans"

    /**
     * 标题文本大小数组
     */
    protected var headingTextSizeMultipliers: Array<Float64> = [20.0, 17.0, 16.0, 15.0, 15.0, 13.0]

    /**
     * 标题文本颜色
     */
    protected var headingTextColor: Color = Color(0x191919)

    /**
     * 段落文本大小
     */
    protected var paragraphTextSize: Float64 = 14.0

    /**
     * 段落文本颜色
     */
    protected var paragraphTextColor: Color = Color(0x191919)

    /**
     * 分割线颜色
     */
    protected var thematicBreakColor: Color = Color(0x191919)

    /**
     * 分割线高度
     */
    protected var thematicBreakHeight: Float64 = 0.5

    /**
     * 软换行是否换行
     */
    protected var isLineBreak: Bool = false

    /**
     * 数学公式文字大小(px)
     */
    protected var latexMathTextSize: Float64 = 48.0

    /**
     * 数学公式行距
     */
    protected var latexMathTextLineSpacing: Float64 = 10.0

    /**
     * 数学公式背景色
     */
    protected var latexMathBackGroupColor: Color = Color(0x00FFFFFF)

    /**
     * 数学公式字体颜色
     */
    protected var latexMathTextColor: Color = Color(0xFF000000)

    /**
     * 数学公式生成图片格式
     */
    protected var latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888

    /**
     * 数学公式资源目录路径
     */
    protected var resPath: String = "/data/storage/el1/bundle/entry/resources/resfile/res"

    /**
     * 视频默认占位图
     */
    protected var videoImage: ?CJResource = None

    /**
     * 视频播放按钮默认图标
     */
    protected var playCircleFillIcon: ?CJResource = None

    /**
     * 图片banner默认占位图
     */
    protected var bannerImage: ?CJResource = None

    /**
     * 图片宽度边距 - 计算屏幕宽度需要减去padding的宽度，单位vp
     */
    protected var imagePadding: Int64 = 40

    /**
     * 图片默认占位图
     */
    protected var imageResource: ?CJResource = None

    /**
     * 网络图片是否压缩
     */
    protected var isAutoResize: Bool = true

    protected init(builder: MarkdownThemeBuilder) {
        this.abilityContext = builder.abilityContext
        this.blockTopAndBottomMargins = builder.blockTopAndBottomMargins
        // 链接
        this.linkColor = builder.linkColor
        this.isLinkUnderlined = builder.isLinkUnderlined
        // 块引用、有序列表，无序列表、任务列表、TOC列表
        this.blockMargin = builder.blockMargin
        this.blockQuoteWidth = builder.blockQuoteWidth
        this.blockQuoteColor = builder.blockQuoteColor
        this.orderedListItemColor = builder.orderedListItemColor
        this.orderedListItemSize = builder.orderedListItemSize
        this.bulletListItemColor = builder.bulletListItemColor
        this.bulletListItemSize = builder.bulletListItemSize
        this.taskListItemLength = builder.taskListItemLength
        // 内联代码、缩进代码、围栏代码、围栏代码列表
        this.codeTextColor = builder.codeTextColor
        this.codeBackgroundColor = builder.codeBackgroundColor
        this.codeBlockTextColor = builder.codeBlockTextColor
        this.codeBlockBackgroundColor = builder.codeBlockBackgroundColor
        this.codeMultilineMargin = builder.codeMultilineMargin
        this.codeTypeface = builder.codeTypeface
        this.codeBlockTypeface = builder.codeBlockTypeface
        this.codeTextSize = builder.codeTextSize
        this.codeBlockTextSize = builder.codeBlockTextSize
        this.isCodeFullScreen = builder.isCodeFullScreen
        this.iconWidthAndHeight = builder.iconWidthAndHeight
        this.codeFullScreenIcon = builder.codeFullScreenIcon
        this.codeCopyIcon = builder.codeCopyIcon
        this.codeListTitleTextSize = builder.codeListTitleTextSize
        this.codeListTitleSelectTextColor = builder.codeListTitleSelectTextColor
        this.codeListTitleUnSelectTextColor = builder.codeListTitleUnSelectTextColor
        this.codeListTitleSelectBackgroupColor = builder.codeListTitleSelectBackgroupColor
        this.codeListTitleUnSelectBackgroupColor = builder.codeListTitleUnSelectBackgroupColor
        // 标题
        this.headingBreakHeight = builder.headingBreakHeight
        this.headingBreakColor = builder.headingBreakColor
        this.headingTypeface = builder.headingTypeface
        this.headingTextSizeMultipliers = builder.headingTextSizeMultipliers
        this.headingTextColor = builder.headingTextColor
        // 段落
        this.paragraphTextSize = builder.paragraphTextSize
        this.paragraphTextColor = builder.paragraphTextColor
        // 分割线
        this.thematicBreakColor = builder.thematicBreakColor
        this.thematicBreakHeight = builder.thematicBreakHeight
        // 软换行
        this.isLineBreak = builder.isLineBreak
        // 数学公式
        this.latexMathTextSize = builder.latexMathTextSize
        this.latexMathTextLineSpacing = builder.latexMathTextLineSpacing
        this.latexMathBackGroupColor = builder.latexMathBackGroupColor
        this.latexMathTextColor = builder.latexMathTextColor
        this.latexMathColorFormat = builder.latexMathColorFormat
        this.resPath = builder.resPath
        // 视频
        this.videoImage = builder.videoImage
        this.playCircleFillIcon = builder.playCircleFillIcon
        // 图片banner
        this.bannerImage = builder.bannerImage
        // 图片
        this.imagePadding = builder.imagePadding
        this.imageResource = builder.imageResource
        this.isAutoResize = builder.isAutoResize
    }

    /**
     * 创建Theme对象
     *
     * @return MarkdownTheme 创建空的MarkdownTheme对象
     */
    public static func create(): MarkdownTheme {
        return emptyBuilder().build()
    }

    /**
     * 创建一个空的builder对象
     *
     * @return MarkdownThemeBuilder 创建空的MarkdownThemeBuilder对象
     */
    public static func emptyBuilder(): MarkdownThemeBuilder {
        return MarkdownThemeBuilder()
    }

    /**
     * 通过已有的Theme创建builder对象
     *
     * @param copyFrom MarkdownTheme对象
     * @return MarkdownThemeBuilder 创建MarkdownThemeBuilder对象
     */
    public static func builder(copyFrom: MarkdownTheme): MarkdownThemeBuilder {
        return MarkdownThemeBuilder(copyFrom)
    }
}

/**
 * MarkdownTheme Builder
 */
public class MarkdownThemeBuilder {
    /**
     * 上下文
     */
    protected var abilityContext: ?AbilityContext = None

    /**
     * 每个模块之间上下间距
     */
    protected var blockTopAndBottomMargins: Float64 = 8.0

    /**
     * 链接颜色
     */
    protected var linkColor: Color = Color(0x0000FF)

    /**
     * 是否显示链接下划线
     */
    protected var isLinkUnderlined: Bool = true

    /**
     * 有序列表、无序列表、任务列表、块引用左边距
     */
    protected var blockMargin: Float64 = 24.0

    /**
     * 块引用左边线条宽度
     */
    protected var blockQuoteWidth: Float64 = 1.0

    /**
     * 块引用左边线条颜色
     */
    protected var blockQuoteColor: Color = Color(0x191919)

    /**
     * 有序列表列表项的颜色。
     */
    protected var orderedListItemColor: Color = Color(0x191919)

    /**
     * 有序列表项的文本大小。
     */
    protected var orderedListItemSize: Float64 = 14.0

    /**
     * 无序列表项的颜色。
     */
    protected var bulletListItemColor: Color = Color(0x191919)

    /**
     * 无序列表项的文本大小。
     */
    protected var bulletListItemSize: Float64 = 14.0

    /**
     * 任务列表项的宽高。
     */
    protected var taskListItemLength: Float64 = 15.0

    /**
     * 内联代码文本颜色
     */
    protected var codeTextColor: Color = Color(0x000000)

    /**
     * 内联代码背景颜色
     */
    protected var codeBackgroundColor: Color = Color(0x191919)

    /**
     * 内联代码文本字体
     */
    protected var codeTypeface: String = "HarmonyOS Sans"

    /**
     * 内联代码文本大小
     */
    protected var codeTextSize: Float64 = 13.0

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）文本颜色
     */
    protected var codeBlockTextColor: ?Color = None

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）背景颜色
     */
    protected var codeBlockBackgroundColor: ?Color = None

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）左边距
     */
    protected var codeMultilineMargin: Float64 = 8.0

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）字体
     */
    protected var codeBlockTypeface: String = "HarmonyOS Sans"

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）文本大小
     */
    protected var codeBlockTextSize: Float64 = 13.0

    /**
     * 是否显示代码全屏按钮
     */
    protected var isCodeFullScreen: Bool = true

    /**
     * 代码全屏按钮和代码复制按钮的宽高
     */
    protected var iconWidthAndHeight: Float64 = 24.0

    /**
     * 代码全屏按钮默认图标
     */
    protected var codeFullScreenIcon: ?CJResource = None

    /**
     * 代码复制按钮默认图标
     */
    protected var codeCopyIcon: ?CJResource = None

    /**
     * 组合代码标题字体大小
     */
    protected var codeListTitleTextSize: Float64 = 13.0

    /**
     * 组合代码标题选中文本颜色
     */
    protected var codeListTitleSelectTextColor: Color = Color.RED

    /**
     * 组合代码标题未选中文本颜色
     */
    protected var codeListTitleUnSelectTextColor: Color = Color.BLACK

    /**
     * 组合代码标题选中背景颜色
     */
    protected var codeListTitleSelectBackgroupColor: Color = Color.GRAY

    /**
     * 组合代码标题未选中背景颜色
     */
    protected var codeListTitleUnSelectBackgroupColor: Color = Color.TRANSPARENT

    /**
     * H1、H2标题下分割线高度
     */
    protected var headingBreakHeight: Float64 = 0.5

    /**
     * H1、H2标题下分割线颜色
     */
    protected var headingBreakColor: Color = Color(0x191919)

    /**
     * 标题元素字体
     */
    protected var headingTypeface: String = "HarmonyOS Sans"

    /**
     * 标题文本大小数组
     */
    protected var headingTextSizeMultipliers: Array<Float64> = [20.0, 17.0, 16.0, 15.0, 15.0, 13.0]

    /**
     * 标题文本颜色
     */
    protected var headingTextColor: Color = Color(0x191919)

    /**
     * 段落文本大小
     */
    protected var paragraphTextSize: Float64 = 14.0

    /**
     * 段落文本颜色
     */
    protected var paragraphTextColor: Color = Color(0x191919)

    /**
     * 分割线颜色
     */
    protected var thematicBreakColor: Color = Color(0x191919)

    /**
     * 分割线高度
     */
    protected var thematicBreakHeight: Float64 = 0.5

    /**
     * 软换行是否换行
     */
    protected var isLineBreak: Bool = false

    /**
     * 数学公式文字大小(px)
     */
    protected var latexMathTextSize: Float64 = 48.0

    /**
     * 数学公式行距
     */
    protected var latexMathTextLineSpacing: Float64 = 10.0

    /**
     * 数学公式背景色
     */
    protected var latexMathBackGroupColor: Color = Color(0x00FFFFFF)

    /**
     * 数学公式字体颜色
     */
    protected var latexMathTextColor: Color = Color(0xFF000000)

    /**
     * 数学公式生成图片格式
     */
    protected var latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888

    /**
     * 数学公式资源目录路径
     */
    protected var resPath: String = "/data/storage/el1/bundle/entry/resources/resfile/res"

    /**
     * 视频默认占位图
     */
    protected var videoImage: ?CJResource = None

    /**
     * 视频播放按钮默认图标
     */
    protected var playCircleFillIcon: ?CJResource = None

    /**
     * 图片banner默认占位图
     */
    protected var bannerImage: ?CJResource = None

    /**
     * 图片宽度边距 - 计算屏幕宽度需要减去padding的宽度，单位vp
     */
    protected var imagePadding: Int64 = 40

    /**
     * 图片默认占位图
     */
    protected var imageResource: ?CJResource = None

    /**
     * 网络图片是否压缩
     */
    protected var isAutoResize: Bool = true

    init() {
    }

    init(theme: MarkdownTheme) {
        this.abilityContext = theme.abilityContext
        this.blockTopAndBottomMargins = theme.blockTopAndBottomMargins
        // 链接
        this.linkColor = theme.linkColor
        this.isLinkUnderlined = theme.isLinkUnderlined
        // 块引用、有序列表，无序列表、任务列表、TOC列表
        this.blockMargin = theme.blockMargin
        this.blockQuoteWidth = theme.blockQuoteWidth
        this.blockQuoteColor = theme.blockQuoteColor
        this.orderedListItemColor = theme.orderedListItemColor
        this.orderedListItemSize = theme.orderedListItemSize
        this.bulletListItemColor = theme.bulletListItemColor
        this.bulletListItemSize = theme.bulletListItemSize
        this.taskListItemLength = theme.taskListItemLength
        // 内联代码、缩进代码、围栏代码、围栏代码列表
        this.codeTextColor = theme.codeTextColor
        this.codeBackgroundColor = theme.codeBackgroundColor
        this.codeBlockTextColor = theme.codeBlockTextColor
        this.codeBlockBackgroundColor = theme.codeBlockBackgroundColor
        this.codeMultilineMargin = theme.codeMultilineMargin
        this.codeTypeface = theme.codeTypeface
        this.codeBlockTypeface = theme.codeBlockTypeface
        this.codeTextSize = theme.codeTextSize
        this.codeBlockTextSize = theme.codeBlockTextSize
        this.isCodeFullScreen = theme.isCodeFullScreen
        this.iconWidthAndHeight = theme.iconWidthAndHeight
        this.codeFullScreenIcon = theme.codeFullScreenIcon
        this.codeCopyIcon = theme.codeCopyIcon
        this.codeListTitleTextSize = theme.codeListTitleTextSize
        this.codeListTitleSelectTextColor = theme.codeListTitleSelectTextColor
        this.codeListTitleUnSelectTextColor = theme.codeListTitleUnSelectTextColor
        this.codeListTitleSelectBackgroupColor = theme.codeListTitleSelectBackgroupColor
        this.codeListTitleUnSelectBackgroupColor = theme.codeListTitleUnSelectBackgroupColor
        // 标题
        this.headingBreakHeight = theme.headingBreakHeight
        this.headingBreakColor = theme.headingBreakColor
        this.headingTypeface = theme.headingTypeface
        this.headingTextSizeMultipliers = theme.headingTextSizeMultipliers
        this.headingTextColor = theme.headingTextColor
        // 段落
        this.paragraphTextSize = theme.paragraphTextSize
        this.paragraphTextColor = theme.paragraphTextColor
        // 分割线
        this.thematicBreakColor = theme.thematicBreakColor
        this.thematicBreakHeight = theme.thematicBreakHeight
        // 软换行
        this.isLineBreak = theme.isLineBreak
        // 数学公式
        this.latexMathTextSize = theme.latexMathTextSize
        this.latexMathTextLineSpacing = theme.latexMathTextLineSpacing
        this.latexMathBackGroupColor = theme.latexMathBackGroupColor
        this.latexMathTextColor = theme.latexMathTextColor
        this.latexMathColorFormat = theme.latexMathColorFormat
        this.resPath = theme.resPath
        // 视频
        this.videoImage = theme.videoImage
        this.playCircleFillIcon = theme.playCircleFillIcon
        // 图片banner
        this.bannerImage = theme.bannerImage
        // 图片
        this.imagePadding = theme.imagePadding
        this.imageResource = theme.imageResource
        this.isAutoResize = theme.isAutoResize
    }

    /**
     * 设置上下文
     *
     * @param abilityContext 上下文
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAbilityContext(abilityContext: AbilityContext): MarkdownThemeBuilder {
        this.abilityContext = abilityContext
        return this
    }

    /**
     * 设置每个模块之间上下间距
     *
     * @param blockTopAndBottomMargins 模块上下间距距离。默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockTopAndBottomMargins(blockTopAndBottomMargins: Float64): MarkdownThemeBuilder {
        this.blockTopAndBottomMargins = blockTopAndBottomMargins
        return this
    }

    /**
     * 设置链接颜色
     *
     * @param linkColor 链接的颜色。默认0x0000FF
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkColor(linkColor: Color): MarkdownThemeBuilder {
        this.linkColor = linkColor
        return this
    }

    /**
     * 设置是否显示链接下划线
     *
     * @param isLinkUnderlined 是否显示链接的下划线。true：显示链接下划线，false：不显示链接下划线。默认显示链接下划线
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsLinkUnderlined(isLinkUnderlined: Bool): MarkdownThemeBuilder {
        this.isLinkUnderlined = isLinkUnderlined
        return this
    }

    /**
     * 设置有序列表、无序列表、任务列表、块引用左边距
     *
     * @param blockMargin 左边距。默认24.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockMargin(blockMargin: Float64): MarkdownThemeBuilder {
        this.blockMargin = blockMargin
        return this
    }

    /**
     * 设置块引用左边线条宽度
     *
     * @param blockQuoteWidth 块引用左线条宽度.默认1.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockQuoteWidth(blockQuoteWidth: Float64): MarkdownThemeBuilder {
        this.blockQuoteWidth = blockQuoteWidth
        return this
    }

    /**
     * 设置块引用左边线条颜色
     *
     * @param blockMargin 块引用左线条颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockQuoteColor(blockQuoteColor: Color): MarkdownThemeBuilder {
        this.blockQuoteColor = blockQuoteColor
        return this
    }

    /**
     * 设置有序列表项的颜色
     *
     * @param blockMargin 有序列表项的颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setOrderedListItemColor(orderedListItemColor: Color): MarkdownThemeBuilder {
        this.orderedListItemColor = orderedListItemColor
        return this
    }

    /**
     * 设置有序列表项的字体大小
     *
     * @param orderedListItemSize 有序列表项的字体大小。默认14.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setOrderedListItemSize(orderedListItemSize: Float64): MarkdownThemeBuilder {
        this.orderedListItemSize = orderedListItemSize
        return this
    }

    /**
     * 设置无序列表项的颜色
     *
     * @param bulletListItemColor 无序列表项的颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBulletListItemColor(bulletListItemColor: Color): MarkdownThemeBuilder {
        this.bulletListItemColor = bulletListItemColor
        return this
    }

    /**
     * 设置无序列表项的字体大小
     *
     * @param bulletListItemSize 无序列表项的字体大小。默认14.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBulletListItemSize(bulletListItemSize: Float64): MarkdownThemeBuilder {
        this.bulletListItemSize = bulletListItemSize
        return this
    }

    /**
     * 设置任务列表项的宽高
     *
     * @param taskListItemLength 任务列表项的宽高。默认15.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTaskListItemLength(taskListItemLength: Float64): MarkdownThemeBuilder {
        this.taskListItemLength = taskListItemLength
        return this
    }

    /**
     * 设置内联代码文本颜色
     *
     * @param codeTextColor 内联代码文本颜色。默认0x000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTextColor(codeTextColor: Color): MarkdownThemeBuilder {
        this.codeTextColor = codeTextColor
        return this
    }

    /**
     * 设置内联代码背景颜色
     *
     * @param codeBackgroundColor 内联代码背景颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBackgroundColor(codeBackgroundColor: Color): MarkdownThemeBuilder {
        this.codeBackgroundColor = codeBackgroundColor
        return this
    }

    /**
     * 设置内联代码文本字体
     *
     * @param codeTypeface 内联代码文本字体。默认HarmonyOS Sans
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTypeface(codeTypeface: String): MarkdownThemeBuilder {
        this.codeTypeface = codeTypeface
        return this
    }

    /**
     * 设置内联代码文本大小
     *
     * @param codeTextSize 内联代码文本大小。默认13.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTextSize(codeTextSize: Float64): MarkdownThemeBuilder {
        this.codeTextSize = codeTextSize
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）文本颜色
     *
     * @param codeBlockTextColor 代码块系列文本颜色。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTextColor(codeBlockTextColor: Color): MarkdownThemeBuilder {
        this.codeBlockTextColor = codeBlockTextColor
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）背景颜色
     *
     * @param codeBlockBackgroundColor 代码块系列背景颜色。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockBackgroundColor(codeBlockBackgroundColor: Color): MarkdownThemeBuilder {
        this.codeBlockBackgroundColor = codeBlockBackgroundColor
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）左边距
     *
     * @param codeMultilineMargin 代码块系列左边距。默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeMultilineMargin(codeMultilineMargin: Float64): MarkdownThemeBuilder {
        this.codeMultilineMargin = codeMultilineMargin
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）字体
     *
     * @param codeBlockTypeface 代码块系列字体。默认HarmonyOS Sans
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTypeface(codeBlockTypeface: String): MarkdownThemeBuilder {
        this.codeBlockTypeface = codeBlockTypeface
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）文本大小
     *
     * @param codeBlockTextSize 代码块系列文本大小。默认13.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTextSize(codeBlockTextSize: Float64): MarkdownThemeBuilder {
        this.codeBlockTextSize = codeBlockTextSize
        return this
    }

    /**
     * 设置是否显示代码全屏按钮
     *
     * @param isCodeFullScreen 是否显示代码全屏按钮。true：显示代码全屏按钮，false：不显示代码全屏按钮。默认显示代码全屏按钮
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsCodeFullScreen(isCodeFullScreen: Bool): MarkdownThemeBuilder {
        this.isCodeFullScreen = isCodeFullScreen
        return this
    }

    /**
     * 设置代码全屏按钮和代码复制按钮宽高
     *
     * @param iconWidthAndHeight 代码全屏按钮和代码复制按钮宽高
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIconWidthAndHeight(iconWidthAndHeight: Float64): MarkdownThemeBuilder {
        this.iconWidthAndHeight = iconWidthAndHeight
        return this
    }

    /**
     * 设置代码全屏按钮默认图标
     *
     * @param codeFullScreenIcon 代码全屏按钮图标。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeFullScreenIcon(codeFullScreenIcon: CJResource): MarkdownThemeBuilder {
        this.codeFullScreenIcon = codeFullScreenIcon
        return this
    }

    /**
     * 设置代码复制按钮默认图标
     *
     * @param codeCopyIcon 代码复制按钮图标。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeCopyIcon(codeCopyIcon: CJResource): MarkdownThemeBuilder {
        this.codeCopyIcon = codeCopyIcon
        return this
    }

    /**
     * 设置组合代码标题字体大小
     *
     * @param codeListTitleTextSize 组合代码标题字体大小。默认13.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleTextSize(codeListTitleTextSize: Float64): MarkdownThemeBuilder {
        this.codeListTitleTextSize = codeListTitleTextSize
        return this
    }

    /**
     * 设置组合代码标题选中文本颜色
     *
     * @param codeListTitleSelectTextColor 组合代码标题选中文本颜色。默认Color.RED
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: Color): MarkdownThemeBuilder {
        this.codeListTitleSelectTextColor = codeListTitleSelectTextColor
        return this
    }

    /**
     * 设置组合代码标题未选中文本颜色
     *
     * @param codeListTitleUnSelectTextColor 组合代码标题未选中文本颜色。默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: Color): MarkdownThemeBuilder {
        this.codeListTitleUnSelectTextColor = codeListTitleUnSelectTextColor
        return this
    }

    /**
     * 设置组合代码标题选中背景颜色
     *
     * @param codeListTitleSelectBackgroupColor 组合代码标题选中背景颜色。默认Color.GRAY
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleSelectBackgroupColor(codeListTitleSelectBackgroupColor: Color): MarkdownThemeBuilder {
        this.codeListTitleSelectBackgroupColor = codeListTitleSelectBackgroupColor
        return this
    }

    /**
     * 设置组合代码标题未选中背景颜色
     *
     * @param codeListTitleUnSelectBackgroupColor 组合代码标题未选中背景颜色。默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleUnSelectBackgroupColor(codeListTitleUnSelectBackgroupColor: Color): MarkdownThemeBuilder {
        this.codeListTitleUnSelectBackgroupColor = codeListTitleUnSelectBackgroupColor
        return this
    }

    /**
     * 设置H1、H2标题下分割线高度
     *
     * @param headingBreakHeight H1、H2标题下分割线高度。默认0.5
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingBreakHeight(headingBreakHeight: Float64): MarkdownThemeBuilder {
        this.headingBreakHeight = headingBreakHeight
        return this
    }

    /**
     * 设置H1、H2标题下分割线颜色
     *
     * @param headingBreakColor H1、H2标题下分割线颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingBreakColor(headingBreakColor: Color): MarkdownThemeBuilder {
        this.headingBreakColor = headingBreakColor
        return this
    }

    /**
     * 设置标题元素字体
     *
     * @param headingTypeface 标题元素字体。默认HarmonyOS Sans
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTypeface(headingTypeface: String): MarkdownThemeBuilder {
        this.headingTypeface = headingTypeface
        return this
    }

    /**
     * 设置标题文本大小数组
     *
     * @param headingTextSizeMultipliers 标题文本大小数组。默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<Float64>): MarkdownThemeBuilder {
        this.headingTextSizeMultipliers = headingTextSizeMultipliers
        return this
    }

    /**
     * 设置标题字体颜色
     *
     * @param headingTextColor 标题字体颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextColor(headingTextColor: Color): MarkdownThemeBuilder {
        this.headingTextColor = headingTextColor
        return this
    }

    /**
     * 设置段落字体大小
     *
     * @param paragraphTextSize 段落字体大小。默认14.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTextSize(paragraphTextSize: Float64): MarkdownThemeBuilder {
        this.paragraphTextSize = paragraphTextSize
        return this
    }

    /**
     * 设置段落字体颜色
     *
     * @param paragraphTextColor 段落字体颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTextColor(paragraphTextColor: Color): MarkdownThemeBuilder {
        this.paragraphTextColor = paragraphTextColor
        return this
    }

    /**
     * 设置分割线颜色
     *
     * @param thematicBreakColor 分割线颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setThematicBreakColor(thematicBreakColor: Color): MarkdownThemeBuilder {
        this.thematicBreakColor = thematicBreakColor
        return this
    }

    /**
     * 设置分割线高度
     *
     * @param thematicBreakHeight 分割线高度。默认0.5
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setThematicBreakHeight(thematicBreakHeight: Float64): MarkdownThemeBuilder {
        this.thematicBreakHeight = thematicBreakHeight
        return this
    }

    /**
     * 设置软换行是否换行
     *
     * @param isLineBreak 软换行是否换行。true：软换行换行，false：软换行不换行。默认软换行不换行
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsLineBreak(isLineBreak: Bool): MarkdownThemeBuilder {
        this.isLineBreak = isLineBreak
        return this
    }

    /**
     * 设置数学公式文字大小(px)
     *
     * @param latexMathTextSize 数学公式文字大小(px)。默认48.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathTextSize(latexMathTextSize: Float64): MarkdownThemeBuilder {
        this.latexMathTextSize = latexMathTextSize
        return this
    }

    /**
     * 设置数学公式行距
     *
     * @param latexMathTextLineSpacing 数学公式行距。默认10.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathTextLineSpacing(latexMathTextLineSpacing: Float64): MarkdownThemeBuilder {
        this.latexMathTextLineSpacing = latexMathTextLineSpacing
        return this
    }

    /**
     * 设置数学公式背景色
     *
     * @param latexMathBackGroupColor 数学公式背景色。默认0x00FFFFFF
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathBackGroupColor(latexMathBackGroupColor: Color): MarkdownThemeBuilder {
        this.latexMathBackGroupColor = latexMathBackGroupColor
        return this
    }

    /**
     * 设置数学公式字体颜色
     *
     * @param latexMathTextColor 数学公式字体颜色。默认0xFF000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathTextColor(latexMathTextColor: Color): MarkdownThemeBuilder {
        this.latexMathTextColor = latexMathTextColor
        return this
    }

    /**
     * 设置数学公式生成图片格式
     *
     * @param latexMathColorFormat 数学公式生成图片格式。默认LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): MarkdownThemeBuilder {
        this.latexMathColorFormat = latexMathColorFormat
        return this
    }

    /**
     * 设置数学公式资源路径
     *
     * @param resPath 数学公式资源路径。默认"/data/storage/el1/bundle/entry/resources/resfile/res"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setResPath(resPath: String): MarkdownThemeBuilder {
        this.resPath = resPath
        return this
    }

    /**
     * 设置视频默认占位图
     *
     * @param videoImage 视频默认占位图。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoImage(videoImage: CJResource): MarkdownThemeBuilder {
        this.videoImage = videoImage
        return this
    }

    /**
     * 设置视频播放按钮默认图标
     *
     * @param playCircleFillIcon 视频播放按钮图标。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setPlayCircleFillIcon(playCircleFillIcon: CJResource): MarkdownThemeBuilder {
        this.playCircleFillIcon = playCircleFillIcon
        return this
    }

    /**
     * 设置图片banner默认占位图
     *
     * @param bannerImage 图片banner占位图。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBannerImage(bannerImage: CJResource): MarkdownThemeBuilder {
        this.bannerImage = bannerImage
        return this
    }

    /**
     * 设置图片宽度边距 - 计算屏幕宽度需要减去padding的宽度，单位vp
     *
     * @param imagePadding 图片宽度边距。默认40vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImagePadding(imagePadding: Int64): MarkdownThemeBuilder {
        this.imagePadding = imagePadding
        return this
    }

    /**
     * 设置图片默认占位图
     *
     * @param imageResource 图片占位图。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageResource(imageResource: CJResource): MarkdownThemeBuilder {
        this.imageResource = imageResource
        return this
    }

    /**
     * 设置是否压缩图片
     *
     * @param isAutoResize 是否压缩图片。true：压缩，false：不压缩。默认压缩
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsAutoResize(isAutoResize: Bool): MarkdownThemeBuilder {
        this.isAutoResize = isAutoResize
        return this
    }

    /**
     * 返回Theme对象
     *
     * @return MarkdownTheme MarkdownTheme对象
     */
    public func build(): MarkdownTheme {
        return MarkdownTheme(this)
    }
}
