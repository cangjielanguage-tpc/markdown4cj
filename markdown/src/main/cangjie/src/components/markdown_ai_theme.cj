/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.ark_interop_helper.*

/**
 * Markdown用户可设置的样式
 * 0: 上下文，每个模块之间上下间距
 * 1：链接（连接颜色，是否显示链接下划线）
 * 2：块引用、有序列表、无序列表、任务列表、TOC列表（左边距，块引用左边线条宽度，块引用左边线条颜色，有序列表项的颜色，有序列表项的大小，无序列表项的颜色，无序列表项的大小，任务列表项的宽高，所有列表最多展示的数量）
 * 3：内联代码、缩进代码、围栏代码、组合代码（内联代码文本颜色，内联代码背景颜色，内联代码文本字体，内联代码文本大小，代码块系列（缩进代码、围栏代码、组合代码）文本颜色，代码块系列（缩进代码、围栏代码、组合代码）背景颜色，代码块系列（缩进代码、围栏代码、组合代码）左边距，代码块系列（缩进代码、围栏代码、组合代码）字体，代码块系列（缩进代码、围栏代码、组合代码）文本大小，是否显示代码全屏按钮，代码全屏按钮和代码复制按钮的宽高，代码全屏按钮默认图标，代码复制按钮默认图标，组合代码标题文本大小，组合代码标题选中文本颜色，组合代码标题未选中文本颜色，组合代码标题选中背景颜色，组合代码标题未选中背景颜色）
 * 4：标题（一级标题二级标题下划线高度，一级标题二级标题下划线颜色，标题文字字体，标题文字大小，标题文字颜色，标题字间距）
 * 5：段落（段落字体大小，段落字体颜色，段落字间距）
 * 6：分割线（分割线高度，分割线颜色）
 * 7：软换行（软换行是否换行）
 * 8：数学公式（数学公式文字大小，数学公式行距，数学公式背景色，数学公式字体颜色，数学公式图片格式，数学公式资源目录路径）
 * 9：视频（视频默认占位图，视频播放按钮默认图标）
 * 10：图片Banner（图片banner默认占位图）
 * 11：图片（图片宽度边距 - 计算屏幕宽度需要减去padding的宽度单位vp，图片默认占位图，图片是否压缩）
 * 12：按钮（按钮文字内容，按钮文字字体大小，按钮文字颜色，按钮背景颜色，按钮高度，按钮上下边距）
 */
public class MarkdownAITheme {
    /**
     * 上下文
     */
    protected var stageContext: ?StageContext = None

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
    protected var linkColor: Color = COLOR_0000FF

    /**
     * 链接文字大小
     */
    protected var linkSize: Float64 = 14.0

    /**
     * 是否显示链接下划线
     */
    protected var isLinkUnderlined: Bool = true

    /**
     * 有序列表、无序列表、任务列表、块引用左边距
     */
    protected var blockMargin: Float64 = 8.0

    /**
     * 块引用左边线条宽度
     */
    protected var blockQuoteWidth: Float64 = 1.0

    /**
     * 块引用左边线条颜色
     */
    protected var blockQuoteColor: Color = COLOR_191919

    /**
     * 块引用背景颜色
     */
    protected var blockQuoteBackGroupClor: Color = COLOR_FFFFFF

    /**
     * 有序列表列表项的颜色。
     */
    protected var orderedListItemColor: Color = COLOR_191919

    /**
     * 有序列表项的文本大小。
     */
    protected var orderedListItemSize: Float64 = 14.0

    /**
     * 无序列表项的颜色。
     */
    protected var bulletListItemColor: Color = COLOR_191919

    /**
     * 无序列表项的文本大小。
     */
    protected var bulletListItemSize: Float64 = 4.0

    /**
     * 任务列表项的宽高。
     */
    protected var taskListItemLength: Float64 = 15.0

    /**
     * 列表展示的数量。
     */
    protected var listNumber: Int64 = 1000

    /**
     * 内联代码文本颜色
     */
    protected var codeTextColor: Color = COLOR_000000

    /**
     * 内联代码背景颜色
     */
    protected var codeBackgroundColor: Color = COLOR_191919

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
    protected var headingBreakColor: Color = COLOR_191919

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
    protected var headingTextColor: Color = COLOR_191919

    /**
     * 标题文本字间距
     */
    protected var headingTextWordSpace: Float64 = 0.0

    /**
     * 段落文本大小
     */
    protected var paragraphTextSize: Float64 = 14.0

    /**
     * 段落文本颜色
     */
    protected var paragraphTextColor: Color = COLOR_191919

    /**
     * 段落文本字间距
     */
    protected var paragraphTextWordSpace: Float64 = 0.0

    /**
     * 分割线颜色
     */
    protected var thematicBreakColor: Color = COLOR_191919

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
    protected var latexMathBackGroupColor: Color = COLOR_00FFFFFF

    /**
     * 数学公式字体颜色
     */
    protected var latexMathTextColor: Color = COLOR_FF000000

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
    protected var imagePadding: Int64 = 0

    /**
     * 图片默认占位图
     */
    protected var imageResource: ?CJResource = None

    /**
     * 网络图片是否压缩
     */
    protected var isAutoResize: Bool = true

    /**
     * 按钮文字内容
     */
    protected var buttonTextStr: String = "加载更多数据"

    /**
     * 按钮文字字体大小
     */
    protected var buttonTextSize: Int64 = 14

    /**
     * 按钮文字颜色
     */
    protected var buttonTextColor: Color = COLOR_FFFFFF

    /**
     * 按钮背景颜色
     */
    protected var buttonTextBackgroupColor: Color = COLOR_FF0000

    /**
     * 按钮高度
     */
    protected var buttonTextHeight: Int64 = 30

    /**
     * 按钮上下边距
     */
    protected var buttonTextMargin: Int64 = 14

    /**
     * 表格内容内边距
     */
    protected var tableCellPadding: Float64 = 4.0

    /**
     * 表格边框颜色
     */
    protected var tableBorderColor: Color = COLOR_FF000000

    /**
     * 表格边框宽度
     */
    protected var tableBorderWidth: Float64 = 1.0

    /**
     * 表格奇数行背景色
     */
    protected var tableOddRowBackgroundColor: Color = COLOR_FFFFFFFF

    /**
     * 表格偶数行背景色
     */
    protected var tableEvenRowBackgroundColor: Color = COLOR_FFE0E0E0

    /**
     * 表格头背景色
     */
    protected var tableHeaderRowBackgroundColor: Color = COLOR_FFFFFFFF

    /**
     * markdown代码高亮样式
     */
    protected var prismTheme: PrismTheme = PrismThemeDefault.create()

    protected init(builder: MarkdownAIThemeBuilder) {
        this.stageContext = builder.stageContext
        this.abilityContext = builder.abilityContext
        this.blockTopAndBottomMargins = builder.blockTopAndBottomMargins
        // 链接
        this.linkColor = builder.linkColor
        this.linkSize = builder.linkSize
        this.isLinkUnderlined = builder.isLinkUnderlined
        // 块引用、有序列表，无序列表、任务列表、TOC列表
        this.blockMargin = builder.blockMargin
        this.blockQuoteWidth = builder.blockQuoteWidth
        this.blockQuoteColor = builder.blockQuoteColor
        this.blockQuoteBackGroupClor = builder.blockQuoteBackGroupClor
        this.orderedListItemColor = builder.orderedListItemColor
        this.orderedListItemSize = builder.orderedListItemSize
        this.bulletListItemColor = builder.bulletListItemColor
        this.bulletListItemSize = builder.bulletListItemSize
        this.taskListItemLength = builder.taskListItemLength
        this.listNumber = builder.listNumber
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
        this.headingTextWordSpace = builder.headingTextWordSpace
        // 段落
        this.paragraphTextSize = builder.paragraphTextSize
        this.paragraphTextColor = builder.paragraphTextColor
        this.paragraphTextWordSpace = builder.paragraphTextWordSpace
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
        // 按钮
        this.buttonTextStr = builder.buttonTextStr
        this.buttonTextSize = builder.buttonTextSize
        this.buttonTextColor = builder.buttonTextColor
        this.buttonTextBackgroupColor = builder.buttonTextBackgroupColor
        this.buttonTextHeight = builder.buttonTextHeight
        this.buttonTextMargin = builder.buttonTextMargin
        // 表格
        this.tableCellPadding = builder.tableCellPadding
        this.tableBorderColor = builder.tableBorderColor
        this.tableBorderWidth = builder.tableBorderWidth
        this.tableOddRowBackgroundColor = builder.tableOddRowBackgroundColor
        this.tableEvenRowBackgroundColor = builder.tableEvenRowBackgroundColor
        this.tableHeaderRowBackgroundColor = builder.tableHeaderRowBackgroundColor
        // 代码高亮
        this.prismTheme = builder.prismTheme
    }

    /**
     * 创建Theme对象
     *
     * @return MarkdownAITheme 创建空的MarkdownAITheme对象
     */
    public static func create(): MarkdownAITheme {
        return emptyBuilder().build()
    }

    /**
     * 创建一个空的builder对象
     *
     * @return MarkdownAIThemeBuilder 创建空的MarkdownAIThemeBuilder对象
     */
    public static func emptyBuilder(): MarkdownAIThemeBuilder {
        return MarkdownAIThemeBuilder()
    }

    /**
     * 创建默认的Theme对象
     *
     * @return MarkdownAITheme 创建默认的MarkdownAITheme对象
     */
    public static func createDefaultBuilder(): MarkdownAIThemeBuilder {
        let markdownAIThemeBuilder: MarkdownAIThemeBuilder = MarkdownAIThemeBuilder()
        // 高亮
        markdownAIThemeBuilder.setPrismTheme(PrismThemeDarkula.create())
        // 表格
        markdownAIThemeBuilder.setTableHeaderRowBackgroundColor(COLOR_FFFFFF)
        markdownAIThemeBuilder.setTableEvenRowBackgroundColor(COLOR_E0E0E0)
        markdownAIThemeBuilder.setTableOddRowBackgroundColor(COLOR_FFFFFF)
        markdownAIThemeBuilder.setTableBorderColor(COLOR_000000)
        // 按钮
        markdownAIThemeBuilder.setButtonTextBackgroupColor(COLOR_FF0000)
        markdownAIThemeBuilder.setButtonTextColor(COLOR_FFFFFF)
        // 数学公式
        markdownAIThemeBuilder.setLatexMathTextColor(COLOR_FF000000)
        markdownAIThemeBuilder.setLatexMathBackGroupColor(COLOR_00FFFFFF)
        // 分割线
        markdownAIThemeBuilder.setThematicBreakColor(COLOR_000000)
        // 段落
        markdownAIThemeBuilder.setParagraphTextColor(COLOR_000000)
        // 标题
        markdownAIThemeBuilder.setHeadingTextColor(COLOR_000000)
        markdownAIThemeBuilder.setHeadingBreakColor(COLOR_000000)
        // 组合代码
        markdownAIThemeBuilder.setCodeListTitleUnSelectBackgroupColor(Color.TRANSPARENT)
        markdownAIThemeBuilder.setCodeListTitleSelectBackgroupColor(Color.GRAY)
        markdownAIThemeBuilder.setCodeListTitleUnSelectTextColor(Color.BLACK)
        markdownAIThemeBuilder.setCodeListTitleSelectTextColor(Color.RED)
        // 内联代码
        markdownAIThemeBuilder.setCodeBackgroundColor(COLOR_FFFFFF)
        markdownAIThemeBuilder.setCodeTextColor(COLOR_000000)
        // 无序列表
        markdownAIThemeBuilder.setBulletListItemColor(COLOR_000000)
        // 有序列表
        markdownAIThemeBuilder.setOrderedListItemColor(COLOR_000000)
        // 块引用
        markdownAIThemeBuilder.setBlockQuoteColor(COLOR_000000)
        // 链接
        markdownAIThemeBuilder.setLinkColor(COLOR_0000FF)
        return markdownAIThemeBuilder
    }

    /**
     * 创建暗色的Theme对象
     *
     * @return MarkdownAITheme 创建暗色的MarkdownAITheme对象
     */
    public static func createDarkulaBuilder(): MarkdownAIThemeBuilder {
        let markdownAIThemeBuilder: MarkdownAIThemeBuilder = MarkdownAIThemeBuilder()
        // 高亮
        markdownAIThemeBuilder.setPrismTheme(PrismThemeDefault.create())
        // 表格
        markdownAIThemeBuilder.setTableHeaderRowBackgroundColor(COLOR_000000)
        markdownAIThemeBuilder.setTableEvenRowBackgroundColor(COLOR_333333)
        markdownAIThemeBuilder.setTableOddRowBackgroundColor(COLOR_000000)
        markdownAIThemeBuilder.setTableBorderColor(COLOR_FFFFFF)
        // 按钮
        markdownAIThemeBuilder.setButtonTextBackgroupColor(COLOR_FF0000)
        markdownAIThemeBuilder.setButtonTextColor(COLOR_FFFFFF)
        // 数学公式
        markdownAIThemeBuilder.setLatexMathTextColor(COLOR_FFFFFFFF)
        markdownAIThemeBuilder.setLatexMathBackGroupColor(COLOR_00000000)
        // 分割线
        markdownAIThemeBuilder.setThematicBreakColor(COLOR_FFFFFF)
        // 段落
        markdownAIThemeBuilder.setParagraphTextColor(COLOR_FFFFFF)
        // 标题
        markdownAIThemeBuilder.setHeadingTextColor(COLOR_FFFFFF)
        markdownAIThemeBuilder.setHeadingBreakColor(COLOR_FFFFFF)
        // 组合代码
        markdownAIThemeBuilder.setCodeListTitleUnSelectBackgroupColor(Color.TRANSPARENT)
        markdownAIThemeBuilder.setCodeListTitleSelectBackgroupColor(Color.GRAY)
        markdownAIThemeBuilder.setCodeListTitleUnSelectTextColor(Color.WHITE)
        markdownAIThemeBuilder.setCodeListTitleSelectTextColor(Color.RED)
        // 内联代码
        markdownAIThemeBuilder.setCodeBackgroundColor(COLOR_000000)
        markdownAIThemeBuilder.setCodeTextColor(COLOR_FFFFFF)
        // 无序列表
        markdownAIThemeBuilder.setBulletListItemColor(COLOR_FFFFFF)
        // 有序列表
        markdownAIThemeBuilder.setOrderedListItemColor(COLOR_FFFFFF)
        // 块引用
        markdownAIThemeBuilder.setBlockQuoteColor(COLOR_FFFFFF)
        // 链接
        markdownAIThemeBuilder.setLinkColor(COLOR_0000FF)
        return markdownAIThemeBuilder
    }

    /**
     * 通过已有的Theme创建builder对象
     *
     * @param copyFrom MarkdownAITheme对象
     * @return MarkdownAIThemeBuilder 创建MarkdownAIThemeBuilder对象
     */
    public static func builder(copyFrom: MarkdownAITheme): MarkdownAIThemeBuilder {
        return MarkdownAIThemeBuilder(copyFrom)
    }
}

/**
 * MarkdownAITheme Builder
 */
public class MarkdownAIThemeBuilder {
    /**
     * 上下文
     */
    protected var stageContext: ?StageContext = None

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
    protected var linkColor: Color = COLOR_0000FF

    /**
     * 链接文字大小
     */
    protected var linkSize: Float64 = 14.0

    /**
     * 是否显示链接下划线
     */
    protected var isLinkUnderlined: Bool = true

    /**
     * 有序列表、无序列表、任务列表、块引用左边距
     */
    protected var blockMargin: Float64 = 8.0

    /**
     * 块引用左边线条宽度
     */
    protected var blockQuoteWidth: Float64 = 1.0

    /**
     * 块引用左边线条颜色
     */
    protected var blockQuoteColor: Color = COLOR_191919

    /**
     * 块引用背景颜色
     */
    protected var blockQuoteBackGroupClor: Color = COLOR_FFFFFF

    /**
     * 有序列表列表项的颜色。
     */
    protected var orderedListItemColor: Color = COLOR_191919

    /**
     * 有序列表项的文本大小。
     */
    protected var orderedListItemSize: Float64 = 14.0

    /**
     * 无序列表项的颜色。
     */
    protected var bulletListItemColor: Color = COLOR_191919

    /**
     * 无序列表项的文本大小。
     */
    protected var bulletListItemSize: Float64 = 4.0

    /**
     * 任务列表项的宽高。
     */
    protected var taskListItemLength: Float64 = 15.0

    /**
     * 列表展示的数量。
     */
    protected var listNumber: Int64 = 1000

    /**
     * 内联代码文本颜色
     */
    protected var codeTextColor: Color = COLOR_000000

    /**
     * 内联代码背景颜色
     */
    protected var codeBackgroundColor: Color = COLOR_191919

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
    protected var headingBreakColor: Color = COLOR_191919

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
    protected var headingTextColor: Color = COLOR_191919

    /**
     * 标题文本字间距
     */
    protected var headingTextWordSpace: Float64 = 0.0

    /**
     * 段落文本大小
     */
    protected var paragraphTextSize: Float64 = 14.0

    /**
     * 段落文本颜色
     */
    protected var paragraphTextColor: Color = COLOR_191919

    /**
     * 段落文本字间距
     */
    protected var paragraphTextWordSpace: Float64 = 0.0

    /**
     * 分割线颜色
     */
    protected var thematicBreakColor: Color = COLOR_191919

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
    protected var latexMathBackGroupColor: Color = COLOR_00FFFFFF

    /**
     * 数学公式字体颜色
     */
    protected var latexMathTextColor: Color = COLOR_FF000000

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
    protected var imagePadding: Int64 = 0

    /**
     * 图片默认占位图
     */
    protected var imageResource: ?CJResource = None

    /**
     * 网络图片是否压缩
     */
    protected var isAutoResize: Bool = true

    /**
     * 按钮文字内容
     */
    protected var buttonTextStr: String = "加载更多数据"

    /**
     * 按钮文字字体大小
     */
    protected var buttonTextSize: Int64 = 14

    /**
     * 按钮文字颜色
     */
    protected var buttonTextColor: Color = COLOR_FFFFFF

    /**
     * 按钮背景颜色
     */
    protected var buttonTextBackgroupColor: Color = COLOR_FF0000

    /**
     * 按钮高度
     */
    protected var buttonTextHeight: Int64 = 30

    /**
     * 按钮上下边距
     */
    protected var buttonTextMargin: Int64 = 14

    /**
     * 表格内容内边距
     */
    protected var tableCellPadding: Float64 = 4.0

    /**
     * 表格边框颜色
     */
    protected var tableBorderColor: Color = COLOR_FF000000

    /**
     * 表格边框宽度
     */
    protected var tableBorderWidth: Float64 = 1.0

    /**
     * 表格奇数行背景色
     */
    protected var tableOddRowBackgroundColor: Color = COLOR_FFFFFFFF

    /**
     * 表格偶数行背景色
     */
    protected var tableEvenRowBackgroundColor: Color = COLOR_FFE0E0E0

    /**
     * 表格头背景色
     */
    protected var tableHeaderRowBackgroundColor: Color = COLOR_FFFFFFFF

    /**
     * markdown代码高亮样式
     */
    protected var prismTheme: PrismTheme = PrismThemeDefault.create()

    init() {
    }

    init(theme: MarkdownAITheme) {
        this.stageContext = theme.stageContext
        this.abilityContext = theme.abilityContext
        this.blockTopAndBottomMargins = theme.blockTopAndBottomMargins
        // 链接
        this.linkColor = theme.linkColor
        this.linkSize = theme.linkSize
        this.isLinkUnderlined = theme.isLinkUnderlined
        // 块引用、有序列表，无序列表、任务列表、TOC列表
        this.blockMargin = theme.blockMargin
        this.blockQuoteWidth = theme.blockQuoteWidth
        this.blockQuoteColor = theme.blockQuoteColor
        this.blockQuoteBackGroupClor = theme.blockQuoteBackGroupClor
        this.orderedListItemColor = theme.orderedListItemColor
        this.orderedListItemSize = theme.orderedListItemSize
        this.bulletListItemColor = theme.bulletListItemColor
        this.bulletListItemSize = theme.bulletListItemSize
        this.taskListItemLength = theme.taskListItemLength
        this.listNumber = theme.listNumber
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
        this.headingTextWordSpace = theme.headingTextWordSpace
        // 段落
        this.paragraphTextSize = theme.paragraphTextSize
        this.paragraphTextColor = theme.paragraphTextColor
        this.paragraphTextWordSpace = theme.paragraphTextWordSpace
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
        // 按钮
        this.buttonTextStr = theme.buttonTextStr
        this.buttonTextSize = theme.buttonTextSize
        this.buttonTextColor = theme.buttonTextColor
        this.buttonTextBackgroupColor = theme.buttonTextBackgroupColor
        this.buttonTextHeight = theme.buttonTextHeight
        this.buttonTextMargin = theme.buttonTextMargin
        // 表格
        this.tableCellPadding = theme.tableCellPadding
        this.tableBorderColor = theme.tableBorderColor
        this.tableBorderWidth = theme.tableBorderWidth
        this.tableOddRowBackgroundColor = theme.tableOddRowBackgroundColor
        this.tableEvenRowBackgroundColor = theme.tableEvenRowBackgroundColor
        this.tableHeaderRowBackgroundColor = theme.tableHeaderRowBackgroundColor
        // 代码高亮
        this.prismTheme = theme.prismTheme
    }

    /**
     * 设置浅色主题整体样式
     *
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setDefaultTheme(): MarkdownAIThemeBuilder {
        // 高亮
        this.prismTheme = PrismThemeDarkula.create()
        // 表格
        this.tableHeaderRowBackgroundColor = COLOR_FFFFFF
        this.tableEvenRowBackgroundColor = COLOR_E0E0E0
        this.tableOddRowBackgroundColor = COLOR_FFFFFF
        this.tableBorderColor = COLOR_000000
        // 按钮
        this.buttonTextBackgroupColor = COLOR_FF0000
        this.buttonTextColor = COLOR_FFFFFF
        // 数学公式
        this.latexMathTextColor = COLOR_FF000000
        this.latexMathBackGroupColor = COLOR_00FFFFFF
        // 分割线
        this.thematicBreakColor = COLOR_000000
        // 段落
        this.paragraphTextColor = COLOR_000000
        // 标题
        this.headingTextColor = COLOR_000000
        this.headingBreakColor = COLOR_000000
        // 组合代码
        this.codeListTitleUnSelectBackgroupColor = Color.TRANSPARENT
        this.codeListTitleSelectBackgroupColor = Color.GRAY
        this.codeListTitleUnSelectTextColor = Color.BLACK
        this.codeListTitleSelectTextColor = Color.RED
        // 内联代码
        this.codeBackgroundColor = COLOR_FFFFFF
        this.codeTextColor = COLOR_000000
        // 无序列表
        this.bulletListItemColor = COLOR_000000
        // 有序列表
        this.orderedListItemColor = COLOR_000000
        // 块引用
        this.blockQuoteColor = COLOR_000000
        this.blockQuoteBackGroupClor = COLOR_FFFFFF
        // 链接
        this.linkColor = COLOR_0000FF
        return this
    }

    /**
     * 设置深色主题整体样式
     *
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setDarkulaTheme(): MarkdownAIThemeBuilder {
        // 高亮
        this.prismTheme = PrismThemeDefault.create()
        // 表格
        this.tableHeaderRowBackgroundColor = COLOR_000000
        this.tableEvenRowBackgroundColor = COLOR_333333
        this.tableOddRowBackgroundColor = COLOR_000000
        this.tableBorderColor = COLOR_FFFFFF
        // 按钮
        this.buttonTextBackgroupColor = COLOR_FF0000
        this.buttonTextColor = COLOR_FFFFFF
        // 数学公式
        this.latexMathTextColor = COLOR_FFFFFFFF
        this.latexMathBackGroupColor = COLOR_00000000
        // 分割线
        this.thematicBreakColor = COLOR_FFFFFF
        // 段落
        this.paragraphTextColor = COLOR_FFFFFF
        // 标题
        this.headingTextColor = COLOR_FFFFFF
        this.headingBreakColor = COLOR_FFFFFF
        // 组合代码
        this.codeListTitleUnSelectBackgroupColor = Color.TRANSPARENT
        this.codeListTitleSelectBackgroupColor = Color.GRAY
        this.codeListTitleUnSelectTextColor = Color.BLACK
        this.codeListTitleSelectTextColor = Color.RED
        // 内联代码
        this.codeBackgroundColor = COLOR_000000
        this.codeTextColor = COLOR_FFFFFF
        // 无序列表
        this.bulletListItemColor = COLOR_FFFFFF
        // 有序列表
        this.orderedListItemColor = COLOR_FFFFFF
        // 块引用
        this.blockQuoteColor = COLOR_FFFFFF
        this.blockQuoteBackGroupClor = COLOR_000000
        // 链接
        this.linkColor = COLOR_0000FF
        return this
    }

    /**
     * 设置上下文
     *
     * @param stageContext 上下文
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setStageContext(stageContext: StageContext): MarkdownAIThemeBuilder {
        this.stageContext = stageContext
        return this
    }

    /**
     * 设置上下文
     *
     * @param abilityContext 上下文
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAbilityContext(abilityContext: AbilityContext): MarkdownAIThemeBuilder {
        this.abilityContext = abilityContext
        return this
    }

    /**
     * 设置每个模块之间上下间距
     *
     * @param blockTopAndBottomMargins 模块上下间距距离。默认8.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockTopAndBottomMargins(blockTopAndBottomMargins: Float64): MarkdownAIThemeBuilder {
        this.blockTopAndBottomMargins = blockTopAndBottomMargins
        return this
    }

    /**
     * 设置链接颜色
     *
     * @param linkColor 链接的颜色。默认0x0000FF
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkColor(linkColor: Color): MarkdownAIThemeBuilder {
        this.linkColor = linkColor
        return this
    }

    /**
     * 设置链接文字大小
     *
     * @param LinkSize 链接文字大小，单位默认vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkSize(linkSize: Float64): MarkdownAIThemeBuilder {
        this.linkSize = linkSize
        return this
    }

    /**
     * 设置是否显示链接下划线
     *
     * @param isLinkUnderlined 是否显示链接的下划线。true：显示链接下划线，false：不显示链接下划线。默认显示链接下划线
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsLinkUnderlined(isLinkUnderlined: Bool): MarkdownAIThemeBuilder {
        this.isLinkUnderlined = isLinkUnderlined
        return this
    }

    /**
     * 设置有序列表、无序列表、任务列表、块引用左边距
     *
     * @param blockMargin 左边距。默认8.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockMargin(blockMargin: Float64): MarkdownAIThemeBuilder {
        this.blockMargin = blockMargin
        return this
    }

    /**
     * 设置块引用左边线条宽度
     *
     * @param blockQuoteWidth 块引用左线条宽度.默认1.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockQuoteWidth(blockQuoteWidth: Float64): MarkdownAIThemeBuilder {
        this.blockQuoteWidth = blockQuoteWidth
        return this
    }

    /**
     * 设置块引用左边线条颜色
     *
     * @param blockQuoteColor 块引用左线条颜色。默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockQuoteColor(blockQuoteColor: Color): MarkdownAIThemeBuilder {
        this.blockQuoteColor = blockQuoteColor
        return this
    }

    /**
     * 设置块引用背景颜色
     *
     * @param blockQuoteBackGroupClor 块引用左线条颜色。默认0xFFFFFF
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockQuoteBackGroupColor(blockQuoteBackGroupClor: Color): MarkdownAIThemeBuilder {
        this.blockQuoteBackGroupClor = blockQuoteBackGroupClor
        return this
    }

    /**
     * 设置有序列表项的颜色
     *
     * @param orderedListItemColor 有序列表项的颜色。默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setOrderedListItemColor(orderedListItemColor: Color): MarkdownAIThemeBuilder {
        this.orderedListItemColor = orderedListItemColor
        return this
    }

    /**
     * 设置有序列表项的字体大小
     *
     * @param orderedListItemSize 有序列表项的字体大小。默认14.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setOrderedListItemSize(orderedListItemSize: Float64): MarkdownAIThemeBuilder {
        this.orderedListItemSize = orderedListItemSize
        return this
    }

    /**
     * 设置无序列表项的颜色
     *
     * @param bulletListItemColor 无序列表项的颜色。默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBulletListItemColor(bulletListItemColor: Color): MarkdownAIThemeBuilder {
        this.bulletListItemColor = bulletListItemColor
        return this
    }

    /**
     * 设置无序列表项的字体大小
     *
     * @param bulletListItemSize 无序列表项的字体大小。默认14.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBulletListItemSize(bulletListItemSize: Float64): MarkdownAIThemeBuilder {
        this.bulletListItemSize = bulletListItemSize
        return this
    }

    /**
     * 设置任务列表项的宽高
     *
     * @param taskListItemLength 任务列表项的宽高。默认15.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setTaskListItemLength(taskListItemLength: Float64): MarkdownAIThemeBuilder {
        this.taskListItemLength = taskListItemLength
        return this
    }

    /**
     * 设置列表展示的数量
     *
     * @param listNumber 列表展示的数量。默认1000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setListNumber(listNumber: Int64): MarkdownAIThemeBuilder {
        this.listNumber = listNumber
        return this
    }

    /**
     * 设置内联代码文本颜色
     *
     * @param codeTextColor 内联代码文本颜色。默认0x000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeTextColor(codeTextColor: Color): MarkdownAIThemeBuilder {
        this.codeTextColor = codeTextColor
        return this
    }

    /**
     * 设置内联代码背景颜色
     *
     * @param codeBackgroundColor 内联代码背景颜色。默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBackgroundColor(codeBackgroundColor: Color): MarkdownAIThemeBuilder {
        this.codeBackgroundColor = codeBackgroundColor
        return this
    }

    /**
     * 设置内联代码文本字体
     *
     * @param codeTypeface 内联代码文本字体。默认HarmonyOS Sans
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeTypeface(codeTypeface: String): MarkdownAIThemeBuilder {
        this.codeTypeface = codeTypeface
        return this
    }

    /**
     * 设置内联代码文本大小
     *
     * @param codeTextSize 内联代码文本大小。默认13.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeTextSize(codeTextSize: Float64): MarkdownAIThemeBuilder {
        this.codeTextSize = codeTextSize
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）文本颜色
     *
     * @param codeBlockTextColor 代码块系列文本颜色。默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockTextColor(codeBlockTextColor: Color): MarkdownAIThemeBuilder {
        this.codeBlockTextColor = codeBlockTextColor
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）背景颜色
     *
     * @param codeBlockBackgroundColor 代码块系列背景颜色。默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockBackgroundColor(codeBlockBackgroundColor: Color): MarkdownAIThemeBuilder {
        this.codeBlockBackgroundColor = codeBlockBackgroundColor
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）左边距
     *
     * @param codeMultilineMargin 代码块系列左边距。默认8.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeMultilineMargin(codeMultilineMargin: Float64): MarkdownAIThemeBuilder {
        this.codeMultilineMargin = codeMultilineMargin
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）字体
     *
     * @param codeBlockTypeface 代码块系列字体。默认HarmonyOS Sans
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockTypeface(codeBlockTypeface: String): MarkdownAIThemeBuilder {
        this.codeBlockTypeface = codeBlockTypeface
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）文本大小
     *
     * @param codeBlockTextSize 代码块系列文本大小。默认13.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockTextSize(codeBlockTextSize: Float64): MarkdownAIThemeBuilder {
        this.codeBlockTextSize = codeBlockTextSize
        return this
    }

    /**
     * 设置是否显示代码全屏按钮
     *
     * @param isCodeFullScreen 是否显示代码全屏按钮。true：显示代码全屏按钮，false：不显示代码全屏按钮。默认显示代码全屏按钮
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsCodeFullScreen(isCodeFullScreen: Bool): MarkdownAIThemeBuilder {
        this.isCodeFullScreen = isCodeFullScreen
        return this
    }

    /**
     * 设置代码全屏按钮和代码复制按钮宽高
     *
     * @param iconWidthAndHeight 代码全屏按钮和代码复制按钮宽高
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIconWidthAndHeight(iconWidthAndHeight: Float64): MarkdownAIThemeBuilder {
        this.iconWidthAndHeight = iconWidthAndHeight
        return this
    }

    /**
     * 设置代码全屏按钮默认图标
     *
     * @param codeFullScreenIcon 代码全屏按钮图标。默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeFullScreenIcon(codeFullScreenIcon: CJResource): MarkdownAIThemeBuilder {
        this.codeFullScreenIcon = codeFullScreenIcon
        return this
    }

    /**
     * 设置代码复制按钮默认图标
     *
     * @param codeCopyIcon 代码复制按钮图标。默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeCopyIcon(codeCopyIcon: CJResource): MarkdownAIThemeBuilder {
        this.codeCopyIcon = codeCopyIcon
        return this
    }

    /**
     * 设置组合代码标题字体大小
     *
     * @param codeListTitleTextSize 组合代码标题字体大小。默认13.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleTextSize(codeListTitleTextSize: Float64): MarkdownAIThemeBuilder {
        this.codeListTitleTextSize = codeListTitleTextSize
        return this
    }

    /**
     * 设置组合代码标题选中文本颜色
     *
     * @param codeListTitleSelectTextColor 组合代码标题选中文本颜色。默认Color.RED
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: Color): MarkdownAIThemeBuilder {
        this.codeListTitleSelectTextColor = codeListTitleSelectTextColor
        return this
    }

    /**
     * 设置组合代码标题未选中文本颜色
     *
     * @param codeListTitleUnSelectTextColor 组合代码标题未选中文本颜色。默认Color.BLACK
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: Color): MarkdownAIThemeBuilder {
        this.codeListTitleUnSelectTextColor = codeListTitleUnSelectTextColor
        return this
    }

    /**
     * 设置组合代码标题选中背景颜色
     *
     * @param codeListTitleSelectBackgroupColor 组合代码标题选中背景颜色。默认Color.GRAY
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleSelectBackgroupColor(codeListTitleSelectBackgroupColor: Color): MarkdownAIThemeBuilder {
        this.codeListTitleSelectBackgroupColor = codeListTitleSelectBackgroupColor
        return this
    }

    /**
     * 设置组合代码标题未选中背景颜色
     *
     * @param codeListTitleUnSelectBackgroupColor 组合代码标题未选中背景颜色。默认Color.TRANSPARENT
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleUnSelectBackgroupColor(codeListTitleUnSelectBackgroupColor: Color): MarkdownAIThemeBuilder {
        this.codeListTitleUnSelectBackgroupColor = codeListTitleUnSelectBackgroupColor
        return this
    }

    /**
     * 设置H1、H2标题下分割线高度
     *
     * @param headingBreakHeight H1、H2标题下分割线高度。默认0.5
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingBreakHeight(headingBreakHeight: Float64): MarkdownAIThemeBuilder {
        this.headingBreakHeight = headingBreakHeight
        return this
    }

    /**
     * 设置H1、H2标题下分割线颜色
     *
     * @param headingBreakColor H1、H2标题下分割线颜色。默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingBreakColor(headingBreakColor: Color): MarkdownAIThemeBuilder {
        this.headingBreakColor = headingBreakColor
        return this
    }

    /**
     * 设置标题元素字体
     *
     * @param headingTypeface 标题元素字体。默认HarmonyOS Sans
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTypeface(headingTypeface: String): MarkdownAIThemeBuilder {
        this.headingTypeface = headingTypeface
        return this
    }

    /**
     * 设置标题文本大小数组
     *
     * @param headingTextSizeMultipliers 标题文本大小数组。默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<Float64>): MarkdownAIThemeBuilder {
        this.headingTextSizeMultipliers = headingTextSizeMultipliers
        return this
    }

    /**
     * 设置标题字体颜色
     *
     * @param headingTextColor 标题字体颜色。默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextColor(headingTextColor: Color): MarkdownAIThemeBuilder {
        this.headingTextColor = headingTextColor
        return this
    }

    /**
     * 设置标题字体字间距
     *
     * @param headingTextWordSpace 标题字体字间距。默认0.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextWordSpace(headingTextWordSpace: Float64): MarkdownAIThemeBuilder {
        this.headingTextWordSpace = headingTextWordSpace
        return this
    }

    /**
     * 设置段落字体大小
     *
     * @param paragraphTextSize 段落字体大小。默认14.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setParagraphTextSize(paragraphTextSize: Float64): MarkdownAIThemeBuilder {
        this.paragraphTextSize = paragraphTextSize
        return this
    }

    /**
     * 设置段落字体颜色
     *
     * @param paragraphTextColor 段落字体颜色。默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setParagraphTextColor(paragraphTextColor: Color): MarkdownAIThemeBuilder {
        this.paragraphTextColor = paragraphTextColor
        return this
    }

    /**
     * 设置段落文本字间距
     *
     * @param paragraphTextWordSpace 段落字体字间距。默认0.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setParagraphTextWordSpace(paragraphTextWordSpace: Float64): MarkdownAIThemeBuilder {
        this.paragraphTextWordSpace = paragraphTextWordSpace
        return this
    }

    /**
     * 设置分割线颜色
     *
     * @param thematicBreakColor 分割线颜色。默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setThematicBreakColor(thematicBreakColor: Color): MarkdownAIThemeBuilder {
        this.thematicBreakColor = thematicBreakColor
        return this
    }

    /**
     * 设置分割线高度
     *
     * @param thematicBreakHeight 分割线高度。默认0.5
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setThematicBreakHeight(thematicBreakHeight: Float64): MarkdownAIThemeBuilder {
        this.thematicBreakHeight = thematicBreakHeight
        return this
    }

    /**
     * 设置软换行是否换行
     *
     * @param isLineBreak 软换行是否换行。true：软换行换行，false：软换行不换行。默认软换行不换行
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsLineBreak(isLineBreak: Bool): MarkdownAIThemeBuilder {
        this.isLineBreak = isLineBreak
        return this
    }

    /**
     * 设置数学公式文字大小(px)
     *
     * @param latexMathTextSize 数学公式文字大小(px)。默认48.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathTextSize(latexMathTextSize: Float64): MarkdownAIThemeBuilder {
        this.latexMathTextSize = latexMathTextSize
        return this
    }

    /**
     * 设置数学公式行距
     *
     * @param latexMathTextLineSpacing 数学公式行距。默认10.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathTextLineSpacing(latexMathTextLineSpacing: Float64): MarkdownAIThemeBuilder {
        this.latexMathTextLineSpacing = latexMathTextLineSpacing
        return this
    }

    /**
     * 设置数学公式背景色
     *
     * @param latexMathBackGroupColor 数学公式背景色。默认0x00FFFFFF
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathBackGroupColor(latexMathBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.latexMathBackGroupColor = latexMathBackGroupColor
        return this
    }

    /**
     * 设置数学公式字体颜色
     *
     * @param latexMathTextColor 数学公式字体颜色。默认0xFF000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathTextColor(latexMathTextColor: Color): MarkdownAIThemeBuilder {
        this.latexMathTextColor = latexMathTextColor
        return this
    }

    /**
     * 设置数学公式生成图片格式
     *
     * @param latexMathColorFormat 数学公式生成图片格式。默认LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): MarkdownAIThemeBuilder {
        this.latexMathColorFormat = latexMathColorFormat
        return this
    }

    /**
     * 设置数学公式资源路径
     *
     * @param resPath 数学公式资源路径。默认"/data/storage/el1/bundle/entry/resources/resfile/res"
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setResPath(resPath: String): MarkdownAIThemeBuilder {
        this.resPath = resPath
        return this
    }

    /**
     * 设置视频默认占位图
     *
     * @param videoImage 视频默认占位图。默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setVideoImage(videoImage: CJResource): MarkdownAIThemeBuilder {
        this.videoImage = videoImage
        return this
    }

    /**
     * 设置视频播放按钮默认图标
     *
     * @param playCircleFillIcon 视频播放按钮图标。默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setPlayCircleFillIcon(playCircleFillIcon: CJResource): MarkdownAIThemeBuilder {
        this.playCircleFillIcon = playCircleFillIcon
        return this
    }

    /**
     * 设置图片banner默认占位图
     *
     * @param bannerImage 图片banner占位图。默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBannerImage(bannerImage: CJResource): MarkdownAIThemeBuilder {
        this.bannerImage = bannerImage
        return this
    }

    /**
     * 设置图片宽度边距 - 计算屏幕宽度需要减去padding的宽度，单位vp
     *
     * @param imagePadding 图片宽度边距。默认40vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setImagePadding(imagePadding: Int64): MarkdownAIThemeBuilder {
        this.imagePadding = imagePadding
        return this
    }

    /**
     * 设置图片默认占位图
     *
     * @param imageResource 图片占位图。默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setImageResource(imageResource: CJResource): MarkdownAIThemeBuilder {
        this.imageResource = imageResource
        return this
    }

    /**
     * 设置是否压缩图片
     *
     * @param isAutoResize 是否压缩图片。true：压缩，false：不压缩。默认压缩
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsAutoResize(isAutoResize: Bool): MarkdownAIThemeBuilder {
        this.isAutoResize = isAutoResize
        return this
    }

    /**
     * 设置按钮文字内容
     *
     * @param buttonTextStr 按钮文字内容
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setButtonTextStr(buttonTextStr: String): MarkdownAIThemeBuilder {
        this.buttonTextStr = buttonTextStr
        return this
    }

    /**
     * 设置按钮文字字体大小
     *
     * @param buttonTextSize 按钮文字字体大小
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setButtonTextSize(buttonTextSize: Int64): MarkdownAIThemeBuilder {
        this.buttonTextSize = buttonTextSize
        return this
    }

    /**
     * 设置按钮文字颜色
     *
     * @param buttonTextColor 按钮文字颜色
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setButtonTextColor(buttonTextColor: Color): MarkdownAIThemeBuilder {
        this.buttonTextColor = buttonTextColor
        return this
    }

    /**
     * 设置按钮背景颜色
     *
     * @param buttonTextBackgroupColor 按钮背景颜色
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setButtonTextBackgroupColor(buttonTextBackgroupColor: Color): MarkdownAIThemeBuilder {
        this.buttonTextBackgroupColor = buttonTextBackgroupColor
        return this
    }

    /**
     * 设置按钮高度
     *
     * @param buttonTextHeight 按钮高度
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setButtonTextHeight(buttonTextHeight: Int64): MarkdownAIThemeBuilder {
        this.buttonTextHeight = buttonTextHeight
        return this
    }

    /**
     * 设置按钮上下边距
     *
     * @param buttonTextMargin 按钮上下边距
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setButtonTextMargine(buttonTextMargin: Int64): MarkdownAIThemeBuilder {
        this.buttonTextMargin = buttonTextMargin
        return this
    }

    /**
     * 设置表格内容内边距
     */
    public func setTableCellPadding(tableCellPadding: Float64): MarkdownAIThemeBuilder {
        this.tableCellPadding = tableCellPadding
        return this
    }

    /**
     * 设置表格边框颜色
     */
    public func setTableBorderColor(tableBorderColor: Color): MarkdownAIThemeBuilder {
        this.tableBorderColor = tableBorderColor
        return this
    }

    /**
     * 设置表格边框宽度
     */
    public func setTableBorderWidth(tableBorderWidth: Float64): MarkdownAIThemeBuilder {
        this.tableBorderWidth = tableBorderWidth
        return this
    }

    /**
     * 设置表格奇数行背景色
     */
    public func setTableOddRowBackgroundColor(tableOddRowBackgroundColor: Color): MarkdownAIThemeBuilder {
        this.tableOddRowBackgroundColor = tableOddRowBackgroundColor
        return this
    }

    /**
     * 设置表格偶数行背景色
     */
    public func setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: Color): MarkdownAIThemeBuilder {
        this.tableEvenRowBackgroundColor = tableEvenRowBackgroundColor
        return this
    }

    /**
     * 设置表格头背景色
     */
    public func setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: Color): MarkdownAIThemeBuilder {
        this.tableHeaderRowBackgroundColor = tableHeaderRowBackgroundColor
        return this
    }

    /**
     * 设置markdown代码高亮样式
     *
     * @param PrismTheme 高亮样式
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setPrismTheme(prismTheme: PrismTheme): MarkdownAIThemeBuilder {
        this.prismTheme = prismTheme
        return this
    }

    /**
     * 返回Theme对象
     *
     * @return MarkdownAITheme MarkdownAITheme对象
     */
    public func build(): MarkdownAITheme {
        return MarkdownAITheme(this)
    }
}
