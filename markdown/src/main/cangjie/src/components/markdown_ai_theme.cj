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
 * 1：上下文 - 本地图片rawfile需要上下文混合项目是stageContext，仓颉项目是abilityContext
 * 2：每个模块之间上下间距
 * 3：链接 - 链接包含（纯文本显示、图片显示）
 *          链接文本颜色、链接字体大小、链接背景颜色、是否显示链接下划线、
 *          链接是否是图片显示、
 *          圆形链接主题背景颜色、圆形链接控件背景颜色、圆形链接文字大小、圆形链接文字颜色、圆形链接半径、圆形链接左右外边距、
 *          圆角矩形链接主题背景颜色、圆角矩形链接控件背景颜色、圆角矩形链接文字大小、圆角矩形链接文字颜色、圆角矩形链接控件高度、圆角矩形链接左右内边距、圆角矩形链接圆角半径、圆角矩形链接左右外边距、
 *          空心圆角矩形链接主题背景颜色、空心圆角矩形链接控件背景颜色、空心圆角矩形链接控件边框颜色、空心圆角矩形链接控件分割线颜色、空心圆角矩形链接文字大小、空心圆角矩形链接文字颜色、空心圆角矩形链接控件高度、空心圆角矩形链接左右内边距、空心圆角矩形链接边框宽度、空心圆角矩形链接分割线宽度、空心圆角矩形链接左右外边距、空心圆角矩形链接分割线和文本左边距、空心圆角矩形链接分割线和文本右边距
 * 4：列表 - 列表包含（块引用、有序列表、无序列表、任务列表、TOC列表）
 *          列表左边距、列表展示的数量
 *          块引用左边线条宽度、块引用左边线条颜色、块引用背景颜色、
 *          有序列表列表项的颜色、有序列表项的文本大小、有序列表项文本行高、
 *          无序列表项的颜色、无序列表项的文本大小、无列表项文本行高、
 *          任务列表项的宽高
 * 5：代码 - 代码包含（内联代码、缩进代码、围栏代码、组合代码）（代码块有缩进代码、围栏代码、组合代码）
 *          内联代码文本颜色、内联代码背景颜色、内联代码文本字体、内联代码文本大小、
 *          代码块系列文本颜色、代码块系列背景颜色、代码块系列左边距、代码块系列字体、代码块系列文本大小、代码块系列行高
 *          是否显示代码全屏按钮、代码全屏按钮和代码复制按钮的宽高、代码全屏按钮默认图标、代码复制按钮默认图标
 *          组合代码标题字体大小、组合代码标题字体大小、组合代码标题选中文本颜色、组合代码标题未选中文本颜色、组合代码标题选中背景颜色、组合代码标题未选中背景颜色
 * 6：标题 - （1-6级标题）
 *          H1和H2标题下分割线高度、H1和H2标题下分割线颜色、标题元素字体、标题文本大小数组、标题文本颜色、标题文本字间距、
 *          一级标题文本行高、二级标题文本行高、三级标题文本行高、四级标题文本行高、五级标题文本行高、六级标题文本行高
 * 7：段落 - 段落文本大小、段落文本颜色、段落文本字间距、段落文本行高
 * 8：分割线 - 分割线颜色、分割线高度
 * 9：软换行 - 软换行是否换行
 * 10：数学公式 - 数学公式文字大小、数学公式行距、数学公式背景色、数学公式字体颜色、数学公式生成图片格式、数学公式资源目录路径
 * 11：视频 - 视频默认占位图、视频播放按钮默认图标
 * 12：图片Banner - 图片banner默认占位图
 * 13：图片 - 图片宽度边距、图片默认占位图、网络图片是否压缩
 * 14：按钮 - 按钮文字内容、按钮文字字体大小、按钮文字颜色、按钮背景颜色、按钮高度、按钮上下边距
 * 15：表格 - 表格内容内边距、表格边框颜色、表格边框宽度、表格奇数行背景色、表格偶数行背景色、表格头背景色、表格文本行高
 * 14：代码高亮 - markdown代码高亮样式
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
     * 每个模块之间上下间距 - 单位vp
     */
    protected var blockTopAndBottomMargins: Float64 = 8.0

    /**
     * 链接文本颜色
     */
    protected var linkColor: Color = COLOR_0000FF

    /**
     * 链接文字大小 - 单位vp
     */
    protected var linkSize: Float64 = 14.0

    /**
     * 链接背景颜色
     */
    protected var linkBackGroupColor: Color = COLOR_000000

    /**
     * 是否显示链接下划线
     */
    protected var isLinkUnderlined: Bool = true

    /**
     * 链接是否是图片显示
     */
    protected var isLinkStyle: Bool = false

    /**
     * 圆形链接主题背景颜色
     */
    protected var linkCircleImageBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 圆形链接控件背景颜色
     */
    protected var linkCircleImageButtonBackGroupColor: Color = COLOR_FF000000

    /**
     * 圆形链接文字大小 - 单位px
     */
    protected var linkCircleImageTextSize: Float64 = fp2px(14.0.fp).getOrThrow().value

    /**
     * 圆形链接文字颜色
     */
    protected var linkCircleImageTextColor: Color = COLOR_FFFFFFFF

    /**
     * 圆形链接半径 - 单位px
     */
    protected var linkCircleImageRadius: Float64 = vp2px(20.0.vp).getOrThrow().value

    /**
     * 圆形链接左右外边距 - 单位vp
     */
    protected var linkCircleImageMargin: Float64 = 6.0

    /**
     * 圆角矩形链接主题背景颜色
     */
    protected var linkRectImageBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 圆角矩形链接控件背景颜色
     */
    protected var linkRectImageButtonBackGroupColor: Color = COLOR_FF000000

    /**
     * 圆角矩形链接文字大小 - 单位px
     */
    protected var linkRectImageTextSize: Float64 = fp2px(14.0.fp).getOrThrow().value

    /**
     * 圆角矩形链接文字颜色
     */
    protected var linkRectImageTextColor: Color = COLOR_FFFFFFFF

    /**
     * 圆角矩形链接控件高度 - 单位px
     */
    protected var linkRectImageHeight: Float64 = vp2px(20.0.vp).getOrThrow().value

    /**
     * 圆角矩形链接左右内边距 - 单位px
     */
    protected var linkRectImagePadding: Float64 = vp2px(6.0.vp).getOrThrow().value

    /**
     * 圆角矩形链接圆角半径 - 单位px
     */
    protected var linkRectImageRadius: Float64 = vp2px(6.0.vp).getOrThrow().value

    /**
     * 圆角矩形链接左右外边距 - 单位vp
     */
    protected var linkRectImageMargin: Float64 = 6.0

    /**
     * 空心圆角矩形链接主题背景颜色
     */
    protected var linkRectToolImageBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 空心圆角矩形链接控件背景颜色
     */
    protected var linkRectToolImageButtonBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 空心圆角矩形链接控件边框颜色
     */
    protected var linkRectToolImageButtonBorderColor: Color = COLOR_FF000000

    /**
     * 空心圆角矩形链接控件分割线颜色
     */
    protected var linkRectToolImageButtonDividingLineColor: Color = COLOR_FF000000

    /**
     * 空心圆角矩形链接文字大小 - 单位px
     */
    protected var linkRectToolImageTextSize: Float64 = fp2px(14.0.fp).getOrThrow().value

    /**
     * 空心圆角矩形链接文字颜色
     */
    protected var linkRectToolImageTextColor: Color = COLOR_FF000000

    /**
     * 空心圆角矩形链接控件高度 - 单位px
     */
    protected var linkRectToolImageHeight: Float64 = vp2px(21.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形链接左右内边距 - 单位px
     */
    protected var linkRectToolImagePadding: Float64 = vp2px(6.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形链接边框宽度 - 单位px
     */
    protected var linkRectToolImageBorderWidth: Float64 = vp2px(1.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形链接分割线宽度 - 单位px
     */
    protected var linkRectToolImageDividingLineWidth: Float64 = vp2px(1.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形链接左右外边距 - 单位vp
     */
    protected var linkRectToolImageMargin: Float64 = 6.0

    /**
     * 空心圆角矩形分割线和文本左边距 - 单位px
     */
    protected var linkRectToolImageLineLeftPadding: Float64 = vp2px(3.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形分割线和文本右边距 - 单位px
     */
    protected var linkRectToolImageLineRightPadding: Float64 = vp2px(3.0.vp).getOrThrow().value

    /**
     * 有序列表、无序列表、任务列表、块引用左边距 - 单位vp
     */
    protected var blockMargin: Float64 = 8.0

    /**
     * 块引用左边线条宽度 - 单位vp
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
     * 有序列表列表项的颜色
     */
    protected var orderedListItemColor: Color = COLOR_191919

    /**
     * 有序列表项的文本大小 - 单位fp
     */
    protected var orderedListItemSize: Float64 = 14.0

    /**
     * 有序列表项文本行高 - 单位vp
     */
    protected var orderedListItemLineheight: Float64 = 22.0

    /**
     * 无序列表项的颜色
     */
    protected var bulletListItemColor: Color = COLOR_191919

    /**
     * 无序列表项的文本大小 - 单位vp
     */
    protected var bulletListItemSize: Float64 = 4.0

    /**
     * 无列表项文本行高 - 单位vp
     */
    protected var bulletListItemLineheight: Float64 = 18.0

    /**
     * 任务列表项的宽高 - 单位vp
     */
    protected var taskListItemLength: Float64 = 15.0

    /**
     * 列表展示的数量
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
     * 内联代码文本大小 - 单位fp
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
     * 代码块系列（缩进代码、围栏代码、组合代码）左边距 - 单位vp
     */
    protected var codeMultilineMargin: Float64 = 8.0

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）字体
     */
    protected var codeBlockTypeface: String = "HarmonyOS Sans"

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）文本大小 - 单位fp
     */
    protected var codeBlockTextSize: Float64 = 13.0

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）行高 - 单位vp
     */
    protected var codeBlockLineheight: Float64 = 22.0

    /**
     * 是否显示代码全屏按钮
     */
    protected var isCodeFullScreen: Bool = true

    /**
     * 代码全屏按钮和代码复制按钮的宽高 - 单位vp
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
     * 组合代码标题字体大小 - 单位fp
     */
    protected var codeListTitleTextSize: Float64 = 13.0

    /**
     * 组合代码标题字体大小 - 单位fp
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
     * H1、H2标题下分割线高度 - 单位vp
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
     * 标题文本大小数组 - 单位fp
     */
    protected var headingTextSizeMultipliers: Array<Float64> = [20.0, 17.0, 16.0, 15.0, 15.0, 13.0]

    /**
     * 标题文本颜色
     */
    protected var headingTextColor: Color = COLOR_191919

    /**
     * 标题文本字间距 - 单位vp
     */
    protected var headingTextWordSpace: Float64 = 0.0

    /**
     * 一级标题文本行高 - 单位vp
     */
    protected var headingTextLineheight1: Float64 = 22.0

    /**
     * 二级标题文本行高 - 单位vp
     */
    protected var headingTextLineheight2: Float64 = 22.0

    /**
     * 三级标题文本行高 - 单位vp
     */
    protected var headingTextLineheight3: Float64 = 22.0

    /**
     * 四级标题文本行高 - 单位vp
     */
    protected var headingTextLineheight4: Float64 = 22.0

    /**
     * 五级标题文本行高 - 单位vp
     */
    protected var headingTextLineheight5: Float64 = 22.0

    /**
     * 六级标题文本行高 - 单位vp
     */
    protected var headingTextLineheight6: Float64 = 22.0

    /**
     * 段落文本大小 - 单位fp
     */
    protected var paragraphTextSize: Float64 = 14.0

    /**
     * 段落文本颜色
     */
    protected var paragraphTextColor: Color = COLOR_191919

    /**
     * 段落文本字间距 - 单位vp
     */
    protected var paragraphTextWordSpace: Float64 = 0.0

    /**
     * 段落文本行高 - 单位vp
     */
    protected var paragraphTextLineheight: Float64 = 22.0

    /**
     * 分割线颜色
     */
    protected var thematicBreakColor: Color = COLOR_191919

    /**
     * 分割线高度 - 单位vp
     */
    protected var thematicBreakHeight: Float64 = 0.5

    /**
     * 软换行是否换行
     */
    protected var isLineBreak: Bool = false

    /**
     * 数学公式文字大小 - 单位px
     */
    protected var latexMathTextSize: Float64 = 48.0

    /**
     * 数学公式行距 - 单位px
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
     * 按钮文字字体大小 - 单位fp
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
     * 按钮高度 - 单位vp
     */
    protected var buttonTextHeight: Int64 = 30

    /**
     * 按钮上下边距 - 单位vp
     */
    protected var buttonTextMargin: Int64 = 14

    /**
     * 表格内容内边距 - 单位vp
     */
    protected var tableCellPadding: Float64 = 4.0

    /**
     * 表格边框颜色
     */
    protected var tableBorderColor: Color = COLOR_FF000000

    /**
     * 表格边框宽度 - 单位vp
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
     * 表格行高 - 单位vp
     */
    protected var tableTextLineheight: Float64 = 22.0

    /**
     * markdown代码高亮样式
     */
    protected var prismTheme: PrismTheme = PrismThemeDefault.create()

    protected init(builder: MarkdownAIThemeBuilder) {
        // 上下文
        this.stageContext = builder.stageContext
        this.abilityContext = builder.abilityContext
        // 模块间距
        this.blockTopAndBottomMargins = builder.blockTopAndBottomMargins
        // 链接
        this.linkColor = builder.linkColor
        this.linkSize = builder.linkSize
        this.linkBackGroupColor = builder.linkBackGroupColor
        this.isLinkUnderlined = builder.isLinkUnderlined
        this.isLinkStyle = builder.isLinkStyle
        this.linkCircleImageBackGroupColor = builder.linkCircleImageBackGroupColor
        this.linkCircleImageButtonBackGroupColor = builder.linkCircleImageButtonBackGroupColor
        this.linkCircleImageTextSize = builder.linkCircleImageTextSize
        this.linkCircleImageTextColor = builder.linkCircleImageTextColor
        this.linkCircleImageRadius = builder.linkCircleImageRadius
        this.linkCircleImageMargin = builder.linkCircleImageMargin
        this.linkRectImageBackGroupColor = builder.linkRectImageBackGroupColor
        this.linkRectImageButtonBackGroupColor = builder.linkRectImageButtonBackGroupColor
        this.linkRectImageTextSize = builder.linkRectImageTextSize
        this.linkRectImageTextColor = builder.linkRectImageTextColor
        this.linkRectImageHeight = builder.linkRectImageHeight
        this.linkRectImagePadding = builder.linkRectImagePadding
        this.linkRectImageRadius = builder.linkRectImageRadius
        this.linkRectImageMargin = builder.linkRectImageMargin
        this.linkRectToolImageBackGroupColor = builder.linkRectToolImageBackGroupColor
        this.linkRectToolImageButtonBackGroupColor = builder.linkRectToolImageButtonBackGroupColor
        this.linkRectToolImageButtonBorderColor = builder.linkRectToolImageButtonBorderColor
        this.linkRectToolImageButtonDividingLineColor = builder.linkRectToolImageButtonDividingLineColor
        this.linkRectToolImageTextSize = builder.linkRectToolImageTextSize
        this.linkRectToolImageTextColor = builder.linkRectToolImageTextColor
        this.linkRectToolImageHeight = builder.linkRectToolImageHeight
        this.linkRectToolImagePadding = builder.linkRectToolImagePadding
        this.linkRectToolImageBorderWidth = builder.linkRectToolImageBorderWidth
        this.linkRectToolImageDividingLineWidth = builder.linkRectToolImageDividingLineWidth
        this.linkRectToolImageMargin = builder.linkRectToolImageMargin
        this.linkRectToolImageLineLeftPadding = builder.linkRectToolImageLineLeftPadding
        this.linkRectToolImageLineRightPadding = builder.linkRectToolImageLineRightPadding
        // 列表
        this.blockMargin = builder.blockMargin
        this.blockQuoteWidth = builder.blockQuoteWidth
        this.blockQuoteColor = builder.blockQuoteColor
        this.blockQuoteBackGroupClor = builder.blockQuoteBackGroupClor
        this.orderedListItemColor = builder.orderedListItemColor
        this.orderedListItemSize = builder.orderedListItemSize
        this.orderedListItemLineheight = builder.orderedListItemLineheight
        this.bulletListItemColor = builder.bulletListItemColor
        this.bulletListItemSize = builder.bulletListItemSize
        this.bulletListItemLineheight = builder.bulletListItemLineheight
        this.taskListItemLength = builder.taskListItemLength
        this.listNumber = builder.listNumber
        // 代码
        this.codeTextColor = builder.codeTextColor
        this.codeBackgroundColor = builder.codeBackgroundColor
        this.codeBlockTextColor = builder.codeBlockTextColor
        this.codeBlockBackgroundColor = builder.codeBlockBackgroundColor
        this.codeMultilineMargin = builder.codeMultilineMargin
        this.codeTypeface = builder.codeTypeface
        this.codeBlockTypeface = builder.codeBlockTypeface
        this.codeTextSize = builder.codeTextSize
        this.codeBlockTextSize = builder.codeBlockTextSize
        this.codeBlockLineheight = builder.codeBlockLineheight
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
        this.headingTextLineheight1 = builder.headingTextLineheight1
        this.headingTextLineheight2 = builder.headingTextLineheight2
        this.headingTextLineheight3 = builder.headingTextLineheight3
        this.headingTextLineheight4 = builder.headingTextLineheight4
        this.headingTextLineheight5 = builder.headingTextLineheight5
        this.headingTextLineheight6 = builder.headingTextLineheight6
        // 段落
        this.paragraphTextSize = builder.paragraphTextSize
        this.paragraphTextColor = builder.paragraphTextColor
        this.paragraphTextWordSpace = builder.paragraphTextWordSpace
        this.paragraphTextLineheight = builder.paragraphTextLineheight
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
        this.tableTextLineheight = builder.tableTextLineheight
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
        markdownAIThemeBuilder.setBlockQuoteBackGroupColor(COLOR_FFFFFF)
        // 链接
        markdownAIThemeBuilder.setLinkColor(COLOR_0000FF)
        markdownAIThemeBuilder.setLinkBackGroupColor(COLOR_FFFFFF)
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
        markdownAIThemeBuilder.setBlockQuoteBackGroupColor(COLOR_000000)
        // 链接
        markdownAIThemeBuilder.setLinkColor(COLOR_0000FF)
        markdownAIThemeBuilder.setLinkBackGroupColor(COLOR_000000)
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
     * 每个模块之间上下间距 - 单位vp
     */
    protected var blockTopAndBottomMargins: Float64 = 8.0

    /**
     * 链接文本颜色
     */
    protected var linkColor: Color = COLOR_0000FF

    /**
     * 链接文字大小 - 单位vp
     */
    protected var linkSize: Float64 = 14.0

    /**
     * 链接背景颜色
     */
    protected var linkBackGroupColor: Color = COLOR_000000

    /**
     * 是否显示链接下划线
     */
    protected var isLinkUnderlined: Bool = true

    /**
     * 链接是否是图片显示
     */
    protected var isLinkStyle: Bool = false

    /**
     * 圆形链接主题背景颜色
     */
    protected var linkCircleImageBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 圆形链接控件背景颜色
     */
    protected var linkCircleImageButtonBackGroupColor: Color = COLOR_FF000000

    /**
     * 圆形链接文字大小 - 单位px
     */
    protected var linkCircleImageTextSize: Float64 = fp2px(14.0.fp).getOrThrow().value

    /**
     * 圆形链接文字颜色
     */
    protected var linkCircleImageTextColor: Color = COLOR_FFFFFFFF

    /**
     * 圆形链接半径 - 单位px
     */
    protected var linkCircleImageRadius: Float64 = vp2px(20.0.vp).getOrThrow().value

    /**
     * 圆形链接左右外边距 - 单位vp
     */
    protected var linkCircleImageMargin: Float64 = 6.0

    /**
     * 圆角矩形链接主题背景颜色
     */
    protected var linkRectImageBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 圆角矩形链接控件背景颜色
     */
    protected var linkRectImageButtonBackGroupColor: Color = COLOR_FF000000

    /**
     * 圆角矩形链接文字大小 - 单位px
     */
    protected var linkRectImageTextSize: Float64 = fp2px(14.0.fp).getOrThrow().value

    /**
     * 圆角矩形链接文字颜色
     */
    protected var linkRectImageTextColor: Color = COLOR_FFFFFFFF

    /**
     * 圆角矩形链接控件高度 - 单位px
     */
    protected var linkRectImageHeight: Float64 = vp2px(20.0.vp).getOrThrow().value

    /**
     * 圆角矩形链接左右内边距 - 单位px
     */
    protected var linkRectImagePadding: Float64 = vp2px(6.0.vp).getOrThrow().value

    /**
     * 圆角矩形链接圆角半径 - 单位px
     */
    protected var linkRectImageRadius: Float64 = vp2px(6.0.vp).getOrThrow().value

    /**
     * 圆角矩形链接左右外边距 - 单位vp
     */
    protected var linkRectImageMargin: Float64 = 6.0

    /**
     * 空心圆角矩形链接主题背景颜色
     */
    protected var linkRectToolImageBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 空心圆角矩形链接控件背景颜色
     */
    protected var linkRectToolImageButtonBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 空心圆角矩形链接控件边框颜色
     */
    protected var linkRectToolImageButtonBorderColor: Color = COLOR_FF000000

    /**
     * 空心圆角矩形链接控件分割线颜色
     */
    protected var linkRectToolImageButtonDividingLineColor: Color = COLOR_FF000000

    /**
     * 空心圆角矩形链接文字大小 - 单位px
     */
    protected var linkRectToolImageTextSize: Float64 = fp2px(14.0.fp).getOrThrow().value

    /**
     * 空心圆角矩形链接文字颜色
     */
    protected var linkRectToolImageTextColor: Color = COLOR_FF000000

    /**
     * 空心圆角矩形链接控件高度 - 单位px
     */
    protected var linkRectToolImageHeight: Float64 = vp2px(21.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形链接左右内边距 - 单位px
     */
    protected var linkRectToolImagePadding: Float64 = vp2px(6.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形链接边框宽度 - 单位px
     */
    protected var linkRectToolImageBorderWidth: Float64 = vp2px(1.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形链接分割线宽度 - 单位px
     */
    protected var linkRectToolImageDividingLineWidth: Float64 = vp2px(1.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形链接左右外边距 - 单位vp
     */
    protected var linkRectToolImageMargin: Float64 = 6.0

    /**
     * 空心圆角矩形分割线和文本左边距 - 单位px
     */
    protected var linkRectToolImageLineLeftPadding: Float64 = vp2px(3.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形分割线和文本右边距 - 单位px
     */
    protected var linkRectToolImageLineRightPadding: Float64 = vp2px(3.0.vp).getOrThrow().value

    /**
     * 有序列表、无序列表、任务列表、块引用左边距 - 单位vp
     */
    protected var blockMargin: Float64 = 8.0

    /**
     * 块引用左边线条宽度 - 单位vp
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
     * 有序列表列表项的颜色
     */
    protected var orderedListItemColor: Color = COLOR_191919

    /**
     * 有序列表项的文本大小 - 单位fp
     */
    protected var orderedListItemSize: Float64 = 14.0

    /**
     * 有序列表项文本行高 - 单位vp
     */
    protected var orderedListItemLineheight: Float64 = 22.0

    /**
     * 无序列表项的颜色
     */
    protected var bulletListItemColor: Color = COLOR_191919

    /**
     * 无序列表项的文本大小 - 单位vp
     */
    protected var bulletListItemSize: Float64 = 4.0

    /**
     * 无列表项文本行高 - 单位vp
     */
    protected var bulletListItemLineheight: Float64 = 18.0

    /**
     * 任务列表项的宽高 - 单位vp
     */
    protected var taskListItemLength: Float64 = 15.0

    /**
     * 列表展示的数量
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
     * 内联代码文本大小 - 单位fp
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
     * 代码块系列（缩进代码、围栏代码、组合代码）左边距 - 单位vp
     */
    protected var codeMultilineMargin: Float64 = 8.0

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）字体
     */
    protected var codeBlockTypeface: String = "HarmonyOS Sans"

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）文本大小 - 单位fp
     */
    protected var codeBlockTextSize: Float64 = 13.0

    /**
     * 代码块系列（缩进代码、围栏代码、组合代码）行高 - 单位vp
     */
    protected var codeBlockLineheight: Float64 = 22.0

    /**
     * 是否显示代码全屏按钮
     */
    protected var isCodeFullScreen: Bool = true

    /**
     * 代码全屏按钮和代码复制按钮的宽高 - 单位vp
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
     * 组合代码标题字体大小 - 单位fp
     */
    protected var codeListTitleTextSize: Float64 = 13.0

    /**
     * 组合代码标题字体大小 - 单位fp
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
     * H1、H2标题下分割线高度 - 单位vp
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
     * 标题文本大小数组 - 单位fp
     */
    protected var headingTextSizeMultipliers: Array<Float64> = [20.0, 17.0, 16.0, 15.0, 15.0, 13.0]

    /**
     * 标题文本颜色
     */
    protected var headingTextColor: Color = COLOR_191919

    /**
     * 标题文本字间距 - 单位vp
     */
    protected var headingTextWordSpace: Float64 = 0.0

    /**
     * 一级标题文本行高 - 单位vp
     */
    protected var headingTextLineheight1: Float64 = 22.0

    /**
     * 二级标题文本行高 - 单位vp
     */
    protected var headingTextLineheight2: Float64 = 22.0

    /**
     * 三级标题文本行高 - 单位vp
     */
    protected var headingTextLineheight3: Float64 = 22.0

    /**
     * 四级标题文本行高 - 单位vp
     */
    protected var headingTextLineheight4: Float64 = 22.0

    /**
     * 五级标题文本行高 - 单位vp
     */
    protected var headingTextLineheight5: Float64 = 22.0

    /**
     * 六级标题文本行高 - 单位vp
     */
    protected var headingTextLineheight6: Float64 = 22.0

    /**
     * 段落文本大小 - 单位fp
     */
    protected var paragraphTextSize: Float64 = 14.0

    /**
     * 段落文本颜色
     */
    protected var paragraphTextColor: Color = COLOR_191919

    /**
     * 段落文本字间距 - 单位vp
     */
    protected var paragraphTextWordSpace: Float64 = 0.0

    /**
     * 段落文本行高 - 单位vp
     */
    protected var paragraphTextLineheight: Float64 = 22.0

    /**
     * 分割线颜色
     */
    protected var thematicBreakColor: Color = COLOR_191919

    /**
     * 分割线高度 - 单位vp
     */
    protected var thematicBreakHeight: Float64 = 0.5

    /**
     * 软换行是否换行
     */
    protected var isLineBreak: Bool = false

    /**
     * 数学公式文字大小 - 单位px
     */
    protected var latexMathTextSize: Float64 = 48.0

    /**
     * 数学公式行距 - 单位px
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
     * 按钮文字字体大小 - 单位fp
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
     * 按钮高度 - 单位vp
     */
    protected var buttonTextHeight: Int64 = 30

    /**
     * 按钮上下边距 - 单位vp
     */
    protected var buttonTextMargin: Int64 = 14

    /**
     * 表格内容内边距 - 单位vp
     */
    protected var tableCellPadding: Float64 = 4.0

    /**
     * 表格边框颜色
     */
    protected var tableBorderColor: Color = COLOR_FF000000

    /**
     * 表格边框宽度 - 单位vp
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
     * 表格行高 - 单位vp
     */
    protected var tableTextLineheight: Float64 = 22.0

    /**
     * markdown代码高亮样式
     */
    protected var prismTheme: PrismTheme = PrismThemeDefault.create()

    init() {
    }

    init(theme: MarkdownAITheme) {
        // 上下文
        this.stageContext = theme.stageContext
        this.abilityContext = theme.abilityContext
        // 模块间距
        this.blockTopAndBottomMargins = theme.blockTopAndBottomMargins
        // 链接
        this.linkColor = theme.linkColor
        this.linkSize = theme.linkSize
        this.linkBackGroupColor = theme.linkBackGroupColor
        this.isLinkUnderlined = theme.isLinkUnderlined
        this.isLinkStyle = theme.isLinkStyle
        this.linkCircleImageBackGroupColor = theme.linkCircleImageBackGroupColor
        this.linkCircleImageButtonBackGroupColor = theme.linkCircleImageButtonBackGroupColor
        this.linkCircleImageTextSize = theme.linkCircleImageTextSize
        this.linkCircleImageTextColor = theme.linkCircleImageTextColor
        this.linkCircleImageRadius = theme.linkCircleImageRadius
        this.linkCircleImageMargin = theme.linkCircleImageMargin
        this.linkRectImageBackGroupColor = theme.linkRectImageBackGroupColor
        this.linkRectImageButtonBackGroupColor = theme.linkRectImageButtonBackGroupColor
        this.linkRectImageTextSize = theme.linkRectImageTextSize
        this.linkRectImageTextColor = theme.linkRectImageTextColor
        this.linkRectImageHeight = theme.linkRectImageHeight
        this.linkRectImagePadding = theme.linkRectImagePadding
        this.linkRectImageRadius = theme.linkRectImageRadius
        this.linkRectImageMargin = theme.linkRectImageMargin
        this.linkRectToolImageBackGroupColor = theme.linkRectToolImageBackGroupColor
        this.linkRectToolImageButtonBackGroupColor = theme.linkRectToolImageButtonBackGroupColor
        this.linkRectToolImageButtonBorderColor = theme.linkRectToolImageButtonBorderColor
        this.linkRectToolImageButtonDividingLineColor = theme.linkRectToolImageButtonDividingLineColor
        this.linkRectToolImageTextSize = theme.linkRectToolImageTextSize
        this.linkRectToolImageTextColor = theme.linkRectToolImageTextColor
        this.linkRectToolImageHeight = theme.linkRectToolImageHeight
        this.linkRectToolImagePadding = theme.linkRectToolImagePadding
        this.linkRectToolImageBorderWidth = theme.linkRectToolImageBorderWidth
        this.linkRectToolImageDividingLineWidth = theme.linkRectToolImageDividingLineWidth
        this.linkRectToolImageMargin = theme.linkRectToolImageMargin
        this.linkRectToolImageLineLeftPadding = theme.linkRectToolImageLineLeftPadding
        this.linkRectToolImageLineRightPadding = theme.linkRectToolImageLineRightPadding
        // 列表
        this.blockMargin = theme.blockMargin
        this.blockQuoteWidth = theme.blockQuoteWidth
        this.blockQuoteColor = theme.blockQuoteColor
        this.blockQuoteBackGroupClor = theme.blockQuoteBackGroupClor
        this.orderedListItemColor = theme.orderedListItemColor
        this.orderedListItemSize = theme.orderedListItemSize
        this.orderedListItemLineheight = theme.orderedListItemLineheight
        this.bulletListItemColor = theme.bulletListItemColor
        this.bulletListItemSize = theme.bulletListItemSize
        this.bulletListItemLineheight = theme.bulletListItemLineheight
        this.taskListItemLength = theme.taskListItemLength
        this.listNumber = theme.listNumber
        // 代码
        this.codeTextColor = theme.codeTextColor
        this.codeBackgroundColor = theme.codeBackgroundColor
        this.codeBlockTextColor = theme.codeBlockTextColor
        this.codeBlockBackgroundColor = theme.codeBlockBackgroundColor
        this.codeMultilineMargin = theme.codeMultilineMargin
        this.codeTypeface = theme.codeTypeface
        this.codeBlockTypeface = theme.codeBlockTypeface
        this.codeTextSize = theme.codeTextSize
        this.codeBlockTextSize = theme.codeBlockTextSize
        this.codeBlockLineheight = theme.codeBlockLineheight
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
        this.headingTextLineheight1 = theme.headingTextLineheight1
        this.headingTextLineheight2 = theme.headingTextLineheight2
        this.headingTextLineheight3 = theme.headingTextLineheight3
        this.headingTextLineheight4 = theme.headingTextLineheight4
        this.headingTextLineheight5 = theme.headingTextLineheight5
        this.headingTextLineheight6 = theme.headingTextLineheight6
        // 段落
        this.paragraphTextSize = theme.paragraphTextSize
        this.paragraphTextColor = theme.paragraphTextColor
        this.paragraphTextWordSpace = theme.paragraphTextWordSpace
        this.paragraphTextLineheight = theme.paragraphTextLineheight
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
        this.tableTextLineheight = theme.tableTextLineheight
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
        this.linkBackGroupColor = COLOR_FFFFFF
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
        this.linkBackGroupColor = COLOR_000000
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
     * @param blockTopAndBottomMargins 模块上下间距距离默认8.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockTopAndBottomMargins(blockTopAndBottomMargins: Float64): MarkdownAIThemeBuilder {
        this.blockTopAndBottomMargins = blockTopAndBottomMargins
        return this
    }

    /**
     * 设置链接颜色
     *
     * @param linkColor 链接的颜色默认0x0000FF
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
     * 设置链接背景颜色
     *
     * @param linkBackGroupColor 链接的背景颜色默认0x000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkBackGroupColor(linkBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.linkBackGroupColor = linkBackGroupColor
        return this
    }

    /**
     * 设置是否显示链接下划线
     *
     * @param isLinkUnderlined 是否显示链接的下划线true：显示链接下划线，false：不显示链接下划线默认显示链接下划线
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsLinkUnderlined(isLinkUnderlined: Bool): MarkdownAIThemeBuilder {
        this.isLinkUnderlined = isLinkUnderlined
        return this
    }

    /**
     * 设置链接是否是图片显示
     *
     * @param isLinkStyle 链接是否是图片显示true：图片显示，false：文本显示
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsLinkStyle(isLinkStyle: Bool): MarkdownAIThemeBuilder {
        this.isLinkStyle = isLinkStyle
        return this
    }

    /**
     * 设置圆形链接主题背景颜色
     *
     * @param linkCircleImageBackGroupColor 圆形链接主题背景颜色
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkCircleImageBackGroupColor(linkCircleImageBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.linkCircleImageBackGroupColor = linkCircleImageBackGroupColor
        return this
    }

    /**
     * 设置圆形链接控件背景颜色
     *
     * @param linkCircleImageButtonBackGroupColor 圆形链接控件背景颜色
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkCircleImageButtonBackGroupColor(linkCircleImageButtonBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.linkCircleImageButtonBackGroupColor = linkCircleImageButtonBackGroupColor
        return this
    }

    /**
     * 设置圆形链接文字大小 - 单位fp
     *
     * @param linkCircleImageTextSize 圆形链接文字大小 - 单位fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkCircleImageTextSize(linkCircleImageTextSize: Float64): MarkdownAIThemeBuilder {
        this.linkCircleImageTextSize = fp2px(linkCircleImageTextSize.fp).getOrThrow().value
        return this
    }

    /**
     * 设置圆形链接文字颜色
     *
     * @param linkCircleImageTextColor 圆形链接文字颜色
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkCircleImageTextColor(linkCircleImageTextColor: Color): MarkdownAIThemeBuilder {
        this.linkCircleImageTextColor = linkCircleImageTextColor
        return this
    }

    /**
     * 设置圆形链接半径 - 单位vp
     *
     * @param linkCircleImageRadius 圆形链接半径 - 单位vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkCircleImageRadius(linkCircleImageRadius: Float64): MarkdownAIThemeBuilder {
        this.linkCircleImageRadius = vp2px(linkCircleImageRadius.vp).getOrThrow().value
        return this
    }

    /**
     * 设置圆形链接左右边距 - 单位vp
     *
     * @param linkCircleImageMargin 圆形链接半径 - 单位vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkCircleImageMargin(linkCircleImageMargin: Float64): MarkdownAIThemeBuilder {
        this.linkCircleImageMargin = linkCircleImageMargin
        return this
    }

    /**
     * 设置圆角矩形链接主题背景颜色
     *
     * @param linkRectImageBackGroupColor 圆角矩形链接主题背景颜色
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImageBackGroupColor(linkRectImageBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.linkRectImageBackGroupColor = linkRectImageBackGroupColor
        return this
    }

    /**
     * 设置圆角矩形链接控件背景颜色
     *
     * @param linkRectImageButtonBackGroupColor 圆角矩形链接控件背景颜色
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImageButtonBackGroupColor(linkRectImageButtonBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.linkRectImageButtonBackGroupColor = linkRectImageButtonBackGroupColor
        return this
    }

    /**
     * 设置圆角矩形链接文字大小 - 单位fp
     *
     * @param linkRectImageTextSize 圆角矩形链接文字大小 - 单位fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImageTextSize(linkRectImageTextSize: Float64): MarkdownAIThemeBuilder {
        this.linkRectImageTextSize = fp2px(linkRectImageTextSize.fp).getOrThrow().value
        return this
    }

    /**
     * 设置圆角矩形链接文字颜色
     *
     * @param linkRectImageTextColor 圆角矩形链接文字颜色
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImageTextColor(linkRectImageTextColor: Color): MarkdownAIThemeBuilder {
        this.linkRectImageTextColor = linkRectImageTextColor
        return this
    }

    /**
     * 设置圆角矩形链接控件高度 - 单位vp
     *
     * @param linkRectImageHeight 圆角矩形链接控件高度 - 单位vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImageHeight(linkRectImageHeight: Float64): MarkdownAIThemeBuilder {
        this.linkRectImageHeight = vp2px(linkRectImageHeight.vp).getOrThrow().value
        return this
    }

    /**
     * 设置圆角矩形链接左右边距 - 单位vp
     *
     * @param linkRectImagePadding 圆角矩形链接左右边距 - 单位vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImagePadding(linkRectImagePadding: Float64): MarkdownAIThemeBuilder {
        this.linkRectImagePadding = vp2px(linkRectImagePadding.vp).getOrThrow().value
        return this
    }

    /**
     * 设置圆角矩形链接圆角半径 - 单位vp
     *
     * @param linkRectImageRadius 圆角矩形链接圆角半径 - 单位vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImageRadius(linkRectImageRadius: Float64): MarkdownAIThemeBuilder {
        this.linkRectImageRadius = vp2px(linkRectImageRadius.vp).getOrThrow().value
        return this
    }

    /**
     * 设置圆角矩形链接左右边距 - 单位vp
     *
     * @param linkRectImageMargin 圆形链接半径 - 单位vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImageMargin(linkRectImageMargin: Float64): MarkdownAIThemeBuilder {
        this.linkRectImageMargin = linkRectImageMargin
        return this
    }

    /**
     * 设置空心圆角矩形链接主题背景颜色
     *
     * @param linkRectToolImageBackGroupColor 空心圆角矩形链接主题背景颜色
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageBackGroupColor(linkRectToolImageBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.linkRectToolImageBackGroupColor = linkRectToolImageBackGroupColor
        return this
    }

    /**
     * 设置空心圆角矩形链接控件背景颜色
     *
     * @param linkRectToolImageButtonBackGroupColor 空心圆角矩形链接控件背景颜色
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageButtonBackGroupColor(linkRectToolImageButtonBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.linkRectToolImageButtonBackGroupColor = linkRectToolImageButtonBackGroupColor
        return this
    }

    /**
     * 设置空心圆角矩形链接控件边框颜色
     *
     * @param linkRectToolImageButtonBorderColor 空心圆角矩形链接控件边框颜色
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageButtonBorderColor(linkRectToolImageButtonBorderColor: Color): MarkdownAIThemeBuilder {
        this.linkRectToolImageButtonBorderColor = linkRectToolImageButtonBorderColor
        return this
    }

    /**
     * 设置空心圆角矩形链接控件分割线颜色
     *
     * @param linkRectToolImageButtonDividingLineColor 空心圆角矩形链接控件分割线颜色
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageButtonDividingLineColor(linkRectToolImageButtonDividingLineColor: Color): MarkdownAIThemeBuilder {
        this.linkRectToolImageButtonDividingLineColor = linkRectToolImageButtonDividingLineColor
        return this
    }

    /**
     * 设置空心圆角矩形链接文字大小 - 单位fp
     *
     * @param linkRectToolImageTextSize 空心圆角矩形链接文字大小 - 单位fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageTextSize(linkRectToolImageTextSize: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImageTextSize = fp2px(linkRectToolImageTextSize.fp).getOrThrow().value
        return this
    }

    /**
     * 设置空心圆角矩形链接文字颜色
     *
     * @param linkRectToolImageTextColor 空心圆角矩形链接文字颜色
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageTextColor(linkRectToolImageTextColor: Color): MarkdownAIThemeBuilder {
        this.linkRectToolImageTextColor = linkRectToolImageTextColor
        return this
    }

    /**
     * 设置空心圆角矩形链接控件高度 - 单位vp
     *
     * @param linkRectToolImageHeight 空心圆角矩形链接控件高度 - 单位vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageHeight(linkRectToolImageHeight: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImageHeight = vp2px(linkRectToolImageHeight.vp).getOrThrow().value
        return this
    }

    /**
     * 设置空心圆角矩形链接左右边距 - 单位vp
     *
     * @param linkRectToolImagePadding 空心圆角矩形链接左右边距 - 单位vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImagePadding(linkRectToolImagePadding: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImagePadding = vp2px(linkRectToolImagePadding.vp).getOrThrow().value
        return this
    }

    /**
     * 设置空心圆角矩形链接边框宽度 - 单位vp
     *
     * @param linkRectToolImageBorderWidth 空心圆角矩形链接边框宽度 - 单位vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setlinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImageBorderWidth = vp2px(linkRectToolImageBorderWidth.vp).getOrThrow().value
        return this
    }

    /**
     * 设置空心圆角矩形链接分割线宽度 - 单位vp
     *
     * @param linkRectToolImageDividingLineWidth 空心圆角矩形链接分割线宽度 - 单位vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImageDividingLineWidth = vp2px(linkRectToolImageDividingLineWidth.vp).getOrThrow().value
        return this
    }

    /**
     * 设置空心圆角矩形链接左右边距 - 单位vp
     *
     * @param linkRectToolImageMargin 圆形链接半径 - 单位vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageMargin(linkRectToolImageMargin: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImageMargin = linkRectToolImageMargin
        return this
    }

    /**
     * 设置空心圆角矩形分割线和文本左边距 - 单位vp
     *
     * @param linkRectToolImageLineLeftPadding 空心圆角矩形分割线和文本左边距 - 单位vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImageLineLeftPadding = vp2px(linkRectToolImageLineLeftPadding.vp).getOrThrow().value
        return this
    }

    /**
     * 设置空心圆角矩形分割线和文本右边距 - 单位vp
     *
     * @param linkRectToolImageLineRightPadding 空心圆角矩形分割线和文本右边距 - 单位vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImageLineRightPadding = vp2px(linkRectToolImageLineRightPadding.vp).getOrThrow().value
        return this
    }

    /**
     * 设置有序列表、无序列表、任务列表、块引用左边距
     *
     * @param blockMargin 左边距默认8.0
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
     * @param blockQuoteColor 块引用左线条颜色默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockQuoteColor(blockQuoteColor: Color): MarkdownAIThemeBuilder {
        this.blockQuoteColor = blockQuoteColor
        return this
    }

    /**
     * 设置块引用背景颜色
     *
     * @param blockQuoteBackGroupClor 块引用左线条颜色默认0xFFFFFF
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockQuoteBackGroupColor(blockQuoteBackGroupClor: Color): MarkdownAIThemeBuilder {
        this.blockQuoteBackGroupClor = blockQuoteBackGroupClor
        return this
    }

    /**
     * 设置有序列表项的颜色
     *
     * @param orderedListItemColor 有序列表项的颜色默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setOrderedListItemColor(orderedListItemColor: Color): MarkdownAIThemeBuilder {
        this.orderedListItemColor = orderedListItemColor
        return this
    }

    /**
     * 设置有序列表项的字体大小
     *
     * @param orderedListItemSize 有序列表项的字体大小默认14.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setOrderedListItemSize(orderedListItemSize: Float64): MarkdownAIThemeBuilder {
        this.orderedListItemSize = orderedListItemSize
        return this
    }

    /**
     * 设置有序列表项文本行高
     *
     * @param orderedListItemLineheight 有序列表项文本行高默认22.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setOrderedListItemLineheight(orderedListItemLineheight: Float64): MarkdownAIThemeBuilder {
        this.orderedListItemLineheight = orderedListItemLineheight
        return this
    }

    /**
     * 设置无序列表项的颜色
     *
     * @param bulletListItemColor 无序列表项的颜色默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBulletListItemColor(bulletListItemColor: Color): MarkdownAIThemeBuilder {
        this.bulletListItemColor = bulletListItemColor
        return this
    }

    /**
     * 设置无序列表项的字体大小
     *
     * @param bulletListItemSize 无序列表项的字体大小默认14.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBulletListItemSize(bulletListItemSize: Float64): MarkdownAIThemeBuilder {
        this.bulletListItemSize = bulletListItemSize
        return this
    }

    /**
     * 设置无列表项文本行高
     *
     * @param bulletListItemLineheight 无列表项文本行高默认18.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBulletListItemLineheight(bulletListItemLineheight: Float64): MarkdownAIThemeBuilder {
        this.bulletListItemLineheight = bulletListItemLineheight
        return this
    }

    /**
     * 设置任务列表项的宽高
     *
     * @param taskListItemLength 任务列表项的宽高默认15.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setTaskListItemLength(taskListItemLength: Float64): MarkdownAIThemeBuilder {
        this.taskListItemLength = taskListItemLength
        return this
    }

    /**
     * 设置列表展示的数量
     *
     * @param listNumber 列表展示的数量默认1000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setListNumber(listNumber: Int64): MarkdownAIThemeBuilder {
        this.listNumber = listNumber
        return this
    }

    /**
     * 设置内联代码文本颜色
     *
     * @param codeTextColor 内联代码文本颜色默认0x000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeTextColor(codeTextColor: Color): MarkdownAIThemeBuilder {
        this.codeTextColor = codeTextColor
        return this
    }

    /**
     * 设置内联代码背景颜色
     *
     * @param codeBackgroundColor 内联代码背景颜色默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBackgroundColor(codeBackgroundColor: Color): MarkdownAIThemeBuilder {
        this.codeBackgroundColor = codeBackgroundColor
        return this
    }

    /**
     * 设置内联代码文本字体
     *
     * @param codeTypeface 内联代码文本字体默认HarmonyOS Sans
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeTypeface(codeTypeface: String): MarkdownAIThemeBuilder {
        this.codeTypeface = codeTypeface
        return this
    }

    /**
     * 设置内联代码文本大小
     *
     * @param codeTextSize 内联代码文本大小默认13.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeTextSize(codeTextSize: Float64): MarkdownAIThemeBuilder {
        this.codeTextSize = codeTextSize
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）文本颜色
     *
     * @param codeBlockTextColor 代码块系列文本颜色默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockTextColor(codeBlockTextColor: Color): MarkdownAIThemeBuilder {
        this.codeBlockTextColor = codeBlockTextColor
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）背景颜色
     *
     * @param codeBlockBackgroundColor 代码块系列背景颜色默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockBackgroundColor(codeBlockBackgroundColor: Color): MarkdownAIThemeBuilder {
        this.codeBlockBackgroundColor = codeBlockBackgroundColor
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）左边距
     *
     * @param codeMultilineMargin 代码块系列左边距默认8.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeMultilineMargin(codeMultilineMargin: Float64): MarkdownAIThemeBuilder {
        this.codeMultilineMargin = codeMultilineMargin
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）字体
     *
     * @param codeBlockTypeface 代码块系列字体默认HarmonyOS Sans
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockTypeface(codeBlockTypeface: String): MarkdownAIThemeBuilder {
        this.codeBlockTypeface = codeBlockTypeface
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）文本大小
     *
     * @param codeBlockTextSize 代码块系列文本大小默认13.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockTextSize(codeBlockTextSize: Float64): MarkdownAIThemeBuilder {
        this.codeBlockTextSize = codeBlockTextSize
        return this
    }

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）行高
     *
     * @param codeBlockLineheight 代码块系列（缩进代码、围栏代码、组合代码）行高默认22.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockLineheight(codeBlockLineheight: Float64): MarkdownAIThemeBuilder {
        this.codeBlockLineheight = codeBlockLineheight
        return this
    }

    /**
     * 设置是否显示代码全屏按钮
     *
     * @param isCodeFullScreen 是否显示代码全屏按钮true：显示代码全屏按钮，false：不显示代码全屏按钮默认显示代码全屏按钮
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
     * @param codeFullScreenIcon 代码全屏按钮图标默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeFullScreenIcon(codeFullScreenIcon: CJResource): MarkdownAIThemeBuilder {
        this.codeFullScreenIcon = codeFullScreenIcon
        return this
    }

    /**
     * 设置代码复制按钮默认图标
     *
     * @param codeCopyIcon 代码复制按钮图标默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeCopyIcon(codeCopyIcon: CJResource): MarkdownAIThemeBuilder {
        this.codeCopyIcon = codeCopyIcon
        return this
    }

    /**
     * 设置组合代码标题字体大小
     *
     * @param codeListTitleTextSize 组合代码标题字体大小默认13.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleTextSize(codeListTitleTextSize: Float64): MarkdownAIThemeBuilder {
        this.codeListTitleTextSize = codeListTitleTextSize
        return this
    }

    /**
     * 设置组合代码标题选中文本颜色
     *
     * @param codeListTitleSelectTextColor 组合代码标题选中文本颜色默认Color.RED
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: Color): MarkdownAIThemeBuilder {
        this.codeListTitleSelectTextColor = codeListTitleSelectTextColor
        return this
    }

    /**
     * 设置组合代码标题未选中文本颜色
     *
     * @param codeListTitleUnSelectTextColor 组合代码标题未选中文本颜色默认Color.BLACK
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: Color): MarkdownAIThemeBuilder {
        this.codeListTitleUnSelectTextColor = codeListTitleUnSelectTextColor
        return this
    }

    /**
     * 设置组合代码标题选中背景颜色
     *
     * @param codeListTitleSelectBackgroupColor 组合代码标题选中背景颜色默认Color.GRAY
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleSelectBackgroupColor(codeListTitleSelectBackgroupColor: Color): MarkdownAIThemeBuilder {
        this.codeListTitleSelectBackgroupColor = codeListTitleSelectBackgroupColor
        return this
    }

    /**
     * 设置组合代码标题未选中背景颜色
     *
     * @param codeListTitleUnSelectBackgroupColor 组合代码标题未选中背景颜色默认Color.TRANSPARENT
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleUnSelectBackgroupColor(codeListTitleUnSelectBackgroupColor: Color): MarkdownAIThemeBuilder {
        this.codeListTitleUnSelectBackgroupColor = codeListTitleUnSelectBackgroupColor
        return this
    }

    /**
     * 设置H1、H2标题下分割线高度
     *
     * @param headingBreakHeight H1、H2标题下分割线高度默认0.5
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingBreakHeight(headingBreakHeight: Float64): MarkdownAIThemeBuilder {
        this.headingBreakHeight = headingBreakHeight
        return this
    }

    /**
     * 设置H1、H2标题下分割线颜色
     *
     * @param headingBreakColor H1、H2标题下分割线颜色默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingBreakColor(headingBreakColor: Color): MarkdownAIThemeBuilder {
        this.headingBreakColor = headingBreakColor
        return this
    }

    /**
     * 设置标题元素字体
     *
     * @param headingTypeface 标题元素字体默认HarmonyOS Sans
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTypeface(headingTypeface: String): MarkdownAIThemeBuilder {
        this.headingTypeface = headingTypeface
        return this
    }

    /**
     * 设置标题文本大小数组
     *
     * @param headingTextSizeMultipliers 标题文本大小数组默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<Float64>): MarkdownAIThemeBuilder {
        this.headingTextSizeMultipliers = headingTextSizeMultipliers
        return this
    }

    /**
     * 设置标题字体颜色
     *
     * @param headingTextColor 标题字体颜色默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextColor(headingTextColor: Color): MarkdownAIThemeBuilder {
        this.headingTextColor = headingTextColor
        return this
    }

    /**
     * 设置标题字体字间距
     *
     * @param headingTextWordSpace 标题字体字间距默认0.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextWordSpace(headingTextWordSpace: Float64): MarkdownAIThemeBuilder {
        this.headingTextWordSpace = headingTextWordSpace
        return this
    }

    /**
     * 设置一级标题文本行高
     *
     * @param headingTextLineheight1 一级标题文本行高默认22.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextLineheight1(headingTextLineheight1: Float64): MarkdownAIThemeBuilder {
        this.headingTextLineheight1 = headingTextLineheight1
        return this
    }

    /**
     * 设置二级标题文本行高
     *
     * @param headingTextLineheight2 二级标题文本行高默认22.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextLineheight2(headingTextLineheight2: Float64): MarkdownAIThemeBuilder {
        this.headingTextLineheight2 = headingTextLineheight2
        return this
    }

    /**
     * 设置三级标题文本行高
     *
     * @param headingTextLineheight3 三级标题文本行高默认22.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextLineheight3(headingTextLineheight3: Float64): MarkdownAIThemeBuilder {
        this.headingTextLineheight3 = headingTextLineheight3
        return this
    }

    /**
     * 设置四级标题文本行高
     *
     * @param headingTextLineheight4 四级标题文本行高默认22.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextLineheight4(headingTextLineheight4: Float64): MarkdownAIThemeBuilder {
        this.headingTextLineheight4 = headingTextLineheight4
        return this
    }

    /**
     * 设置五级标题文本行高
     *
     * @param headingTextLineheight5 五级标题文本行高默认22.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextLineheight5(headingTextLineheight5: Float64): MarkdownAIThemeBuilder {
        this.headingTextLineheight5 = headingTextLineheight5
        return this
    }

    /**
     * 设置六级标题文本行高
     *
     * @param headingTextLineheight1 六级标题文本行高默认22.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextLineheight6(headingTextLineheight6: Float64): MarkdownAIThemeBuilder {
        this.headingTextLineheight6 = headingTextLineheight6
        return this
    }

    /**
     * 设置段落字体大小
     *
     * @param paragraphTextSize 段落字体大小默认14.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setParagraphTextSize(paragraphTextSize: Float64): MarkdownAIThemeBuilder {
        this.paragraphTextSize = paragraphTextSize
        return this
    }

    /**
     * 设置段落字体颜色
     *
     * @param paragraphTextColor 段落字体颜色默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setParagraphTextColor(paragraphTextColor: Color): MarkdownAIThemeBuilder {
        this.paragraphTextColor = paragraphTextColor
        return this
    }

    /**
     * 设置段落文本字间距
     *
     * @param paragraphTextWordSpace 段落字体字间距默认0.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setParagraphTextWordSpace(paragraphTextWordSpace: Float64): MarkdownAIThemeBuilder {
        this.paragraphTextWordSpace = paragraphTextWordSpace
        return this
    }

    /**
     * 设置段落文本行高
     *
     * @param paragraphTextLineheight 段落文本行高默认22.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setParagraphTextLineheight(paragraphTextLineheight: Float64): MarkdownAIThemeBuilder {
        this.paragraphTextLineheight = paragraphTextLineheight
        return this
    }

    /**
     * 设置分割线颜色
     *
     * @param thematicBreakColor 分割线颜色默认0x191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setThematicBreakColor(thematicBreakColor: Color): MarkdownAIThemeBuilder {
        this.thematicBreakColor = thematicBreakColor
        return this
    }

    /**
     * 设置分割线高度
     *
     * @param thematicBreakHeight 分割线高度默认0.5
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setThematicBreakHeight(thematicBreakHeight: Float64): MarkdownAIThemeBuilder {
        this.thematicBreakHeight = thematicBreakHeight
        return this
    }

    /**
     * 设置软换行是否换行
     *
     * @param isLineBreak 软换行是否换行true：软换行换行，false：软换行不换行默认软换行不换行
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsLineBreak(isLineBreak: Bool): MarkdownAIThemeBuilder {
        this.isLineBreak = isLineBreak
        return this
    }

    /**
     * 设置数学公式文字大小(px)
     *
     * @param latexMathTextSize 数学公式文字大小(px)默认48.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathTextSize(latexMathTextSize: Float64): MarkdownAIThemeBuilder {
        this.latexMathTextSize = latexMathTextSize
        return this
    }

    /**
     * 设置数学公式行距
     *
     * @param latexMathTextLineSpacing 数学公式行距默认10.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathTextLineSpacing(latexMathTextLineSpacing: Float64): MarkdownAIThemeBuilder {
        this.latexMathTextLineSpacing = latexMathTextLineSpacing
        return this
    }

    /**
     * 设置数学公式背景色
     *
     * @param latexMathBackGroupColor 数学公式背景色默认0x00FFFFFF
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathBackGroupColor(latexMathBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.latexMathBackGroupColor = latexMathBackGroupColor
        return this
    }

    /**
     * 设置数学公式字体颜色
     *
     * @param latexMathTextColor 数学公式字体颜色默认0xFF000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathTextColor(latexMathTextColor: Color): MarkdownAIThemeBuilder {
        this.latexMathTextColor = latexMathTextColor
        return this
    }

    /**
     * 设置数学公式生成图片格式
     *
     * @param latexMathColorFormat 数学公式生成图片格式默认LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): MarkdownAIThemeBuilder {
        this.latexMathColorFormat = latexMathColorFormat
        return this
    }

    /**
     * 设置数学公式资源路径
     *
     * @param resPath 数学公式资源路径默认"/data/storage/el1/bundle/entry/resources/resfile/res"
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setResPath(resPath: String): MarkdownAIThemeBuilder {
        this.resPath = resPath
        return this
    }

    /**
     * 设置视频默认占位图
     *
     * @param videoImage 视频默认占位图默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setVideoImage(videoImage: CJResource): MarkdownAIThemeBuilder {
        this.videoImage = videoImage
        return this
    }

    /**
     * 设置视频播放按钮默认图标
     *
     * @param playCircleFillIcon 视频播放按钮图标默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setPlayCircleFillIcon(playCircleFillIcon: CJResource): MarkdownAIThemeBuilder {
        this.playCircleFillIcon = playCircleFillIcon
        return this
    }

    /**
     * 设置图片banner默认占位图
     *
     * @param bannerImage 图片banner占位图默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBannerImage(bannerImage: CJResource): MarkdownAIThemeBuilder {
        this.bannerImage = bannerImage
        return this
    }

    /**
     * 设置图片宽度边距 - 计算屏幕宽度需要减去padding的宽度，单位vp
     *
     * @param imagePadding 图片宽度边距默认40vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setImagePadding(imagePadding: Int64): MarkdownAIThemeBuilder {
        this.imagePadding = imagePadding
        return this
    }

    /**
     * 设置图片默认占位图
     *
     * @param imageResource 图片占位图默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setImageResource(imageResource: CJResource): MarkdownAIThemeBuilder {
        this.imageResource = imageResource
        return this
    }

    /**
     * 设置是否压缩图片
     *
     * @param isAutoResize 是否压缩图片true：压缩，false：不压缩默认压缩
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
     * 设置表格行高
     */
    public func setTableTextLineheight(tableTextLineheight: Float64): MarkdownAIThemeBuilder {
        this.tableTextLineheight = tableTextLineheight
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
