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
 *          列表左边距、列表右边距、列表展示的数量
 *          块引用左边线条宽度、块引用左边线条颜色、块引用背景颜色、块引用子模块间距
 *          有序列表前缀是否加粗、有序列表列表项的颜色、有序列表项的文本大小、有序列表项文本行高、有序列表无序列表任务列表子模块间距
 *          无序列表项的颜色、无序列表项的文本大小、无列表项文本行高、
 *          任务列表项的宽高
 * 5：代码 - 代码包含（内联代码、缩进代码、围栏代码、组合代码）（代码块有缩进代码、围栏代码、组合代码）
 *          内联代码文本颜色、内联代码背景颜色、内联代码文本字体、内联代码文本大小、
 *          代码块系列文本颜色、代码块系列类型文本颜色、代码块系列图片文字是否显示隐藏、代码块系列代码行是否显示隐藏、代码块系列背景颜色、代码块系列左边距、代码块系列字体、代码块系列文本大小、代码块系列行高、代码块圆角
 *          是否显示代码全屏按钮、代码全屏按钮和代码复制按钮的宽高、代码全屏按钮默认图标、代码复制按钮默认图标
 *          组合代码标题字体大小、组合代码标题字体大小、组合代码标题选中文本颜色、组合代码标题未选中文本颜色、组合代码标题选中背景颜色、组合代码标题未选中背景颜色
 *          是否单独代码块、单独代码块行号宽度、
 * 6：标题 - （1-6级标题）
 *          H1和H2标题下分割线高度、H1和H2标题下分割线颜色、标题元素字体、标题文本大小数组、标题文本颜色、标题文本字间距、
 *          一级标题文本行高、二级标题文本行高、三级标题文本行高、四级标题文本行高、五级标题文本行高、六级标题文本行高
 * 7：段落 - 段落文本大小、段落文本颜色、段落文本字间距、段落文本行高、段落元素字体
 * 8：分割线 - 分割线颜色、分割线高度、分割线上部外边距、分割线下部外边距
 * 9：软换行 - 软换行是否换行
 * 10：数学公式 - 数学公式文字大小、数学公式行距、数学公式背景色、数学公式字体颜色、数学公式生成图片格式、块结构的数学公式是否居中
 * 11：音频 - 音频图标、
 *           音频边框颜色、音频边框粗细、音频边框圆角、
 *           音频按钮背景颜色、音频按钮文字颜色、音频按钮文字大小、音频按钮文字内容、音频按钮圆角
 *           音频标题文字大小、音频标题文字颜色、音频标题文字行高
 *           音频类型文字大小、音频类型文字颜色、音频类型文字行高
 * 12：视频 - 视频默认占位图、视频播放按钮默认图标、视频圆角
 *           视频时间文本颜色、视频时间文本大小、视频时间文本居右边距、视频时间文本居底边距
 * 13：图片Banner - 图片banner默认占位图
 * 14：图片 - 图片宽度边距、图片默认占位图、网络图片是否压缩
 * 15：表格 - 表格内容内边距、表格边框颜色、表格边框宽度、表格奇数行背景色、表格偶数行背景色、表格头背景色、表格文本行高、表格圆角、表格一格最小宽度、表格一格最大宽度、表格第一列是否加粗
 * 16：代码高亮 - markdown代码高亮样式
 */
public class MarkdownAITheme {
    /**
     * markdown上下文 - 互操作
     */
    protected var stageContext: ?StageContext = None

    /**
     * markdown上下文 - 仓颉
     */
    protected var abilityContext: ?AbilityContext = None

    /**
     * 模块间上下间距
     */
    protected var blockTopAndBottomMargins: Float64 = 8.0

    /**
     * 链接是否是图片显示
     */
    protected var isLinkStyle: Bool = false

    /**
     * 列表中的单行链接是否是图片显示
     */
    protected var isListLinkStyle: Bool = false

    /**
     * 文本格式链接文本颜色
     */
    protected var linkColor: Color = COLOR_FF0000FF

    /**
     * 是否按照链接文字自己大小显示文本
     */
    protected var isLinkSize: Bool = true

    /**
     * 文本格式链接文字大小
     */
    protected var linkSize: Float64 = 14.0

    /**
     * 文本格式链接背景颜色
     */
    protected var linkBackGroupColor: Color = Color.TRANSPARENT

    /**
     * 文本格式是否显示链接下划线
     */
    protected var isLinkUnderlined: Bool = true

    /**
     * 圆形图片格式链接主题背景颜色
     */
    protected var linkCircleImageBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 圆形图片格式链接控件背景颜色
     */
    protected var linkCircleImageButtonBackGroupColor: Color = COLOR_FF000000

    /**
     * 圆形图片格式链接文字大小
     */
    protected var linkCircleImageTextSize: Float64 = fp2px(14.0.fp).getOrThrow().value

    /**
     * 圆形图片格式链接文字颜色
     */
    protected var linkCircleImageTextColor: Color = COLOR_FFFFFFFF

    /**
     * 圆形图片格式链接半径
     */
    protected var linkCircleImageRadius: Float64 = vp2px(20.0.vp).getOrThrow().value

    /**
     * 圆形图片格式链接左右外边距
     */
    protected var linkCircleImageMargin: Float64 = 6.0

    /**
     * 圆角矩形图片格式链接主题背景颜色
     */
    protected var linkRectImageBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 圆角矩形图片格式链接控件背景颜色
     */
    protected var linkRectImageButtonBackGroupColor: Color = COLOR_FF000000

    /**
     * 圆角矩形图片格式链接文字大小
     */
    protected var linkRectImageTextSize: Float64 = fp2px(14.0.fp).getOrThrow().value

    /**
     * 圆角矩形图片格式链接文字颜色
     */
    protected var linkRectImageTextColor: Color = COLOR_FFFFFFFF

    /**
     * 圆角矩形图片格式链接控件高度
     */
    protected var linkRectImageHeight: Float64 = vp2px(20.0.vp).getOrThrow().value

    /**
     * 圆角矩形图片格式链接左右内边距
     */
    protected var linkRectImagePadding: Float64 = vp2px(6.0.vp).getOrThrow().value

    /**
     * 圆角矩形图片格式链接圆角半径
     */
    protected var linkRectImageRadius: Float64 = vp2px(6.0.vp).getOrThrow().value

    /**
     * 圆角矩形图片格式链接左右外边距
     */
    protected var linkRectImageMargin: Float64 = 6.0

    /**
     * 空心圆角矩形图片格式链接主题背景颜色
     */
    protected var linkRectToolImageBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 空心圆角矩形图片格式链接控件背景颜色
     */
    protected var linkRectToolImageButtonBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 空心圆角矩形图片格式链接控件边框颜色
     */
    protected var linkRectToolImageButtonBorderColor: Color = COLOR_FF000000

    /**
     * 空心圆角矩形图片格式链接控件分割线颜色
     */
    protected var linkRectToolImageButtonDividingLineColor: Color = COLOR_FF000000

    /**
     * 空心圆角矩形图片格式链接文字大小
     */
    protected var linkRectToolImageTextSize: Float64 = fp2px(14.0.fp).getOrThrow().value

    /**
     * 空心圆角矩形图片格式链接文字颜色
     */
    protected var linkRectToolImageTextColor: Color = COLOR_FF000000

    /**
     * 空心圆角矩形图片格式链接控件高度
     */
    protected var linkRectToolImageHeight: Float64 = vp2px(21.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形图片格式链接左右内边距
     */
    protected var linkRectToolImagePadding: Float64 = vp2px(6.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形图片格式链接边框宽度
     */
    protected var linkRectToolImageBorderWidth: Float64 = vp2px(1.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形图片格式链接分割线宽度
     */
    protected var linkRectToolImageDividingLineWidth: Float64 = vp2px(1.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形图片格式链接左右外边距
     */
    protected var linkRectToolImageMargin: Float64 = 6.0

    /**
     * 空心圆角矩形图片格式分割线和文本左边距
     */
    protected var linkRectToolImageLineLeftPadding: Float64 = vp2px(3.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形图片格式分割线和文本右边距
     */
    protected var linkRectToolImageLineRightPadding: Float64 = vp2px(3.0.vp).getOrThrow().value

    /**
     * 块引用左边距
     */
    protected var blockQuoteLeftMargin: Float64 = 8.0

    /**
     * 块引用右边距
     */
    protected var blockQuoteRightMargin: Float64 = 8.0

    /**
     * 块引用左边线条宽度
     */
    protected var blockQuoteWidth: Float64 = 1.0

    /**
     * 块引用左边线条颜色
     */
    protected var blockQuoteColor: Color = COLOR_FF191919

    /**
     * 块引用背景颜色
     */
    protected var blockQuoteBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 块引用子模块上下间距
     */
    protected var blockQuoteTopAndBottomMargins: Float64 = 0.0

    /**
     * 有序列表、无序列表、任务列表子模块上下间距
     */
    protected var blockOrderedAndBulletTopAndBottomMargins: Float64 = 0.0

    /**
     * 有序列表、无序列表、任务列表左边距
     */
    protected var blockLeftMargin: Float64 = 8.0

    /**
     * 有序列表、无序列表、任务列表右边距
     */
    protected var blockRightMargin: Float64 = 8.0

    /**
     * 有序列表前缀文本是否加粗
     */
    protected var orderedListItemPrefixBold: Bool = false

    /**
     * 有序列表前缀文本颜色
     */
    protected var orderedListItemColor: Color = COLOR_FF191919

    /**
     * 有序列表前缀文本大小
     */
    protected var orderedListItemSize: Float64 = 14.0

    /**
     * 有序列表前缀文本行高
     */
    protected var orderedListItemLineHeight: Float64 = 22.0

    /**
     * 无序列表前缀文本颜色
     */
    protected var bulletListItemColor: Color = COLOR_FF191919

    /**
     * 无序列表前缀文本大小
     */
    protected var bulletListItemSize: Float64 = 4.0

    /**
     * 无序列表前缀文本行高
     */
    protected var bulletListItemLineHeight: Float64 = 18.0

    /**
     * 任务列表选择框宽高
     */
    protected var taskListItemLength: Float64 = 15.0

    /**
     * 内联代码是否是图片显示
     */
    protected var isCodeStyle: Bool = false

    /**
     * 文本、图片格式内联代码文本颜色
     */
    protected var codeTextColor: Color = COLOR_FF000000

    /**
     * 文本、图片格式内联代码背景颜色
     */
    protected var codeBackgroundColor: Color = COLOR_FF191919

    /**
     * 文本、图片格式内联代码文本大小
     */
    protected var codeTextSize: Float64 = fp2px(13.0.fp).getOrThrow().value

    /**
     * 文本格式内联代码文本字体
     */
    protected var codeTypeface: String = "HarmonyOS Sans"

    /**
     * 图片格式内联代码文本左右边距
     */
    protected var codeLeftAndRightPadding: Float64 = vp2px(4.0.vp).getOrThrow().value

    /**
     * 图片格式内联代码文本高度
     */
    protected var codeHeight: Float64 = vp2px(20.0.vp).getOrThrow().value

    /**
     * 代码块代码文本颜色
     */
    protected var codeBlockTextColor: ?Color = None

    /**
     * 代码块代码类型文本颜色
     */
    protected var codeBlockTypeTextColor: ?Color = None

    /**
     * 代码块代码类型默认文本
     */
    protected var codeBlockTypeTextStr: String = ""

    /**
     * 代码类型和代码块距离
     */
    protected var codeBlockTypeTextPadding: Float64 = 0.0

    /**
     * 代码块复制、全屏图片文字是否显示
     */
    protected var codeBlockIconTextHide: Bool = true

    /**
     * 代码块代码行号是否显示
     */
    protected var codeBlockLineNumberHide: Bool = true

    /**
     * 代码块背景颜色
     */
    protected var codeBlockBackgroundColor: ?Color = None

    /**
     * 代码块左边距
     */
    protected var codeMultilineMargin: Float64 = 8.0

    /**
     * 代码块字体
     */
    protected var codeBlockTypeface: String = "HarmonyOS Sans"

    /**
     * 代码块代码文本大小
     */
    protected var codeBlockTextSize: Float64 = 13.0

    /**
     * 代码块代码文本行高
     */
    protected var codeBlockLineHeight: Float64 = 22.0

    /**
     * 代码块控件圆角大小
     */
    protected var codeBlockRadius: Float64 = 8.0

    /**
     * 代码块代码全屏按钮是否显示
     */
    protected var isCodeFullScreen: Bool = true

    /**
     * 代码块代码全屏、代码复制按钮宽高
     */
    protected var iconWidthAndHeight: Float64 = 24.0

    /**
     * 代码块代码全屏按钮默认图标
     */
    protected var codeFullScreenIcon: ?CJResource = None

    /**
     * 代码块代码复制按钮默认图标
     */
    protected var codeCopyIcon: ?CJResource = None

    /**
     * 组合代码未选中标题字体大小
     */
    protected var codeListTitleTextSize: Float64 = 13.0

    /**
     * 组合代码选中标题字体大小
     */
    protected var codeListTitleSelectTextSize: Float64 = 13.0

    /**
     * 组合代码选中标题文本颜色
     */
    protected var codeListTitleSelectTextColor: Color = Color.RED

    /**
     * 组合代码未选中标题文本颜色
     */
    protected var codeListTitleUnSelectTextColor: Color = Color.BLACK

    /**
     * 组合代码选中标题背景颜色
     */
    protected var codeListTitleSelectBackGroupColor: Color = Color.GRAY

    /**
     * 组合代码未选中标题背景颜色
     */
    protected var codeListTitleUnSelectBackGroupColor: Color = Color.TRANSPARENT

    /**
     * 是否单独代码块显示
     */
    protected var isSeparateCodeBlock: Bool = false

    /**
     * 单独代码块行号宽度
     */
    protected var separateCodeBlockWidth: Float64 = 50.0

    /**
     * H1、H2标题下分割线高度
     */
    protected var headingBreakHeight: Float64 = 0.5

    /**
     * H1、H2标题下分割线颜色
     */
    protected var headingBreakColor: Color = COLOR_FF191919

    /**
     * 标题文本字体
     */
    protected var headingTypeface: String = "HarmonyOS Sans"

    /**
     * 标题文本大小数组
     */
    protected var headingTextSizeMultipliers: Array<Float64> = [20.0, 17.0, 16.0, 15.0, 15.0, 13.0]

    /**
     * 标题文本颜色
     */
    protected var headingTextColor: Color = COLOR_FF191919

    /**
     * 标题文本字间距
     */
    protected var headingTextWordSpace: Float64 = 0.0

    /**
     * 一级标题文本行高
     */
    protected var headingTextLineHeight1: Float64 = 22.0

    /**
     * 二级标题文本行高
     */
    protected var headingTextLineHeight2: Float64 = 22.0

    /**
     * 三级标题文本行高
     */
    protected var headingTextLineHeight3: Float64 = 22.0

    /**
     * 四级标题文本行高
     */
    protected var headingTextLineHeight4: Float64 = 22.0

    /**
     * 五级标题文本行高
     */
    protected var headingTextLineHeight5: Float64 = 22.0

    /**
     * 六级标题文本行高
     */
    protected var headingTextLineHeight6: Float64 = 22.0

    /**
     * 段落文本大小
     */
    protected var paragraphTextSize: Float64 = 14.0

    /**
     * 段落文本颜色
     */
    protected var paragraphTextColor: Color = COLOR_FF191919

    /**
     * 段落文本字间距
     */
    protected var paragraphTextWordSpace: Float64 = 0.0

    /**
     * 段落文本行高
     */
    protected var paragraphTextLineHeight: Float64 = 22.0

    /**
     * 段落文本字体
     */
    protected var paragraphTypeface: String = "HarmonyOS Sans"

    /**
     * 分割线颜色
     */
    protected var thematicBreakColor: Color = COLOR_FF191919

    /**
     * 分割线高度
     */
    protected var thematicBreakHeight: Float64 = 0.5

    /**
     * 分割线上部外边距
     */
    protected var thematicBreakTopMargin: Float64 = 0.0

    /**
     * 分割线下部外边距
     */
    protected var thematicBreakBottomMargin: Float64 = 0.0

    /**
     * 软换行是否换行
     */
    protected var isLineBreak: Bool = false

    /**
     * 数学公式文本大小
     */
    protected var latexMathTextSize: Float64 = fp2px(16.0.fp)().value

    /**
     * 数学公式文本行距
     */
    protected var latexMathTextLineSpacing: Float64 = 10.0

    /**
     * 数学公式背景色
     */
    protected var latexMathBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 数学公式文本颜色
     */
    protected var latexMathTextColor: Color = COLOR_FF000000

    /**
     * 数学公式生成图片格式
     */
    protected var latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888

    /**
     * 块结构的数学公式是否居中
     */
    protected var latexMathBlockCenter: Bool = false

    /**
     * 数学公式字体路径
     */
    protected var latexMathResStr: String = "/data/storage/el1/bundle/entry/resources/resfile/res"

    /**
     * 音频图标
     */
    protected var audioIcon: ?CJResource = None

    /**
     * 音频阴影颜色值
     */
    protected var audioShadowColor: Color = COLOR_1A000000

    /**
     * 音频边框颜色
     */
    protected var audioBorderColor: Color = COLOR_33000000

    /**
     * 音频边框粗细
     */
    protected var audioBorderWidth: Float64 = 0.5

    /**
     * 音频边框圆角
     */
    protected var audioBorderRadius: Float64 = 12.0

    /**
     * 音频按钮背景颜色
     */
    protected var audioButtonBackgroundColor: Color = Color.BLACK

    /**
     * 音频按钮文字颜色
     */
    protected var audioButtonTextColor: Color = Color.WHITE

    /**
     * 音频按钮文字大小
     */
    protected var audioButtonTextSize: Float64 = 14.0

    /**
     * 音频按钮文字内容
     */
    protected var audioButtonText: String = "立即播放"

    /**
     * 音频按钮圆角
     */
    protected var audioButtonBorderRadius: Float64 = 16.0

    /**
     * 音频标题文字大小
     */
    protected var audioTitleTextSize: Float64 = 15.0

    /**
     * 音频标题文字颜色
     */
    protected var audioTitleTextColor: Color = Color.BLACK

    /**
     * 音频标题文字行高
     */
    protected var audioTitleTextLineHeight: Float64 = 20.0

    /**
     * 音频类型文字大小
     */
    protected var audioTypeTextSize: Float64 = 11.0

    /**
     * 音频类型文字颜色
     */
    protected var audioTypeTextColor: Color = COLOR_80000000

    /**
     * 音频类型文字行高
     */
    protected var audioTypeTextLineHeight: Float64 = 15.0

    /**
     * 音频上边距
     */
    protected var audioMarginTop: Float64 = 10.0

    /**
     * 音频下边距
     */
    protected var audioMarginBottom: Float64 = 10.0

    /**
     * 视频默认占位图
     */
    protected var videoImage: ?CJResource = None

    /**
     * 视频播放按钮默认图标
     */
    protected var playCircleFillIcon: ?CJResource = None

    /**
     * 视频圆角
     */
    protected var videoBorderRadius: Float64 = 10.0

    /**
     * 视频时间文本颜色
     */
    protected var videoTimeTextColor: Color = Color.WHITE

    /**
     * 视频时间文本大小
     */
    protected var videoTimeTextSize: Float64 = 14.0

    /**
     * 视频时间文本居右边距
     */
    protected var videoTimeTextMarginRight: Float64 = 10.0

    /**
     * 视频时间文本居底边距
     */
    protected var videoTimeTextMarginBottom: Float64 = 10.0

    /**
     * 视频上边距
     */
    protected var videoMarginTop: Float64 = 10.0

    /**
     * 视频下边距
     */
    protected var videoMarginBottom: Float64 = 10.0

    /**
     * 图片banner默认占位图
     */
    protected var bannerImage: ?CJResource = None

    /**
     * 图片文字是否需要图文混排
     */
    protected var isWord: Bool = true

    /**
     * 图片默认占位图 - CJResource
     */
    protected var imageResource: ?CJResource = None

    /**
     * 图片默认占位图 - String
     */
    protected var imagePlaceholder: ?String = None

    /**
     * 网络图片是否压缩
     */
    protected var isAutoResize: Bool = true

    /**
     * 图片上边距
     */
    protected var imageMarginTop: Float64 = 10.0

    /**
     * 图片下边距
     */
    protected var imageMarginBottom: Float64 = 10.0

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
     * 表格文本行高
     */
    protected var tableTextLineHeight: Float64 = 22.0

    /**
     * 表格圆角
     */
    protected var tableRadius: Float64 = 5.0

    /**
     * 表格最小宽度
     */
    protected var tableMinTextWidth: Float64 = 50.0

    /**
     * 表格最大宽度
     */
    protected var tableMaxTextWidth: Float64 = 300.0

    /**
     * 表格第一列是否加粗
     */
    protected var tableFirstColumnBold: Bool = false

    /**
     * markdown代码高亮样式
     */
    protected var prismTheme: PrismTheme = PrismThemeDarkula.create()

    protected init(builder: MarkdownAIThemeBuilder) {
        // 1、上下文
        this.stageContext = builder.stageContext
        this.abilityContext = builder.abilityContext

        // 2、模块间距
        this.blockTopAndBottomMargins = builder.blockTopAndBottomMargins

        // 3、链接
        this.isLinkStyle = builder.isLinkStyle
        this.isListLinkStyle = builder.isListLinkStyle
        // 3.1、文本格式链接
        this.linkColor = builder.linkColor
        this.isLinkSize = builder.isLinkSize
        this.linkSize = builder.linkSize
        this.linkBackGroupColor = builder.linkBackGroupColor
        this.isLinkUnderlined = builder.isLinkUnderlined
        // 3.2、圆形图片格式链接
        this.linkCircleImageBackGroupColor = builder.linkCircleImageBackGroupColor
        this.linkCircleImageButtonBackGroupColor = builder.linkCircleImageButtonBackGroupColor
        this.linkCircleImageTextSize = builder.linkCircleImageTextSize
        this.linkCircleImageTextColor = builder.linkCircleImageTextColor
        this.linkCircleImageRadius = builder.linkCircleImageRadius
        this.linkCircleImageMargin = builder.linkCircleImageMargin
        // 3.3、圆角矩形图片格式链接
        this.linkRectImageBackGroupColor = builder.linkRectImageBackGroupColor
        this.linkRectImageButtonBackGroupColor = builder.linkRectImageButtonBackGroupColor
        this.linkRectImageTextSize = builder.linkRectImageTextSize
        this.linkRectImageTextColor = builder.linkRectImageTextColor
        this.linkRectImageHeight = builder.linkRectImageHeight
        this.linkRectImagePadding = builder.linkRectImagePadding
        this.linkRectImageRadius = builder.linkRectImageRadius
        this.linkRectImageMargin = builder.linkRectImageMargin
        // 3.4、空心圆角矩形图片格式链接
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

        // 4、列表
        // 4.1、块引用
        this.blockQuoteLeftMargin = builder.blockQuoteLeftMargin
        this.blockQuoteRightMargin = builder.blockQuoteRightMargin
        this.blockQuoteWidth = builder.blockQuoteWidth
        this.blockQuoteColor = builder.blockQuoteColor
        this.blockQuoteBackGroupColor = builder.blockQuoteBackGroupColor
        this.blockQuoteTopAndBottomMargins = builder.blockQuoteTopAndBottomMargins
        // 4.2、有序列表、无序列表、任务列表
        this.blockOrderedAndBulletTopAndBottomMargins = builder.blockOrderedAndBulletTopAndBottomMargins
        this.blockLeftMargin = builder.blockLeftMargin
        this.blockRightMargin = builder.blockRightMargin
        // 4.3、有序列表
        this.orderedListItemPrefixBold = builder.orderedListItemPrefixBold
        this.orderedListItemColor = builder.orderedListItemColor
        this.orderedListItemSize = builder.orderedListItemSize
        this.orderedListItemLineHeight = builder.orderedListItemLineHeight
        // 4.4、无序列表
        this.bulletListItemColor = builder.bulletListItemColor
        this.bulletListItemSize = builder.bulletListItemSize
        this.bulletListItemLineHeight = builder.bulletListItemLineHeight
        // 4.5、任务列表
        this.taskListItemLength = builder.taskListItemLength

        // 5、代码
        // 5.1、内联代码
        this.isCodeStyle = builder.isCodeStyle
        this.codeTextColor = builder.codeTextColor
        this.codeBackgroundColor = builder.codeBackgroundColor
        this.codeTypeface = builder.codeTypeface
        this.codeTextSize = builder.codeTextSize
        this.codeLeftAndRightPadding = builder.codeLeftAndRightPadding
        this.codeHeight = builder.codeHeight
        // 5.2、代码块
        this.codeBlockTextColor = builder.codeBlockTextColor
        this.codeBlockTypeTextColor = builder.codeBlockTypeTextColor
        this.codeBlockTypeTextStr = builder.codeBlockTypeTextStr
        this.codeBlockTypeTextPadding = builder.codeBlockTypeTextPadding
        this.codeBlockIconTextHide = builder.codeBlockIconTextHide
        this.codeBlockLineNumberHide = builder.codeBlockLineNumberHide
        this.codeBlockBackgroundColor = builder.codeBlockBackgroundColor
        this.codeMultilineMargin = builder.codeMultilineMargin
        this.codeTypeface = builder.codeTypeface
        this.codeBlockTypeface = builder.codeBlockTypeface
        this.codeTextSize = builder.codeTextSize
        this.codeBlockTextSize = builder.codeBlockTextSize
        this.codeBlockLineHeight = builder.codeBlockLineHeight
        this.codeBlockRadius = builder.codeBlockRadius
        this.isCodeFullScreen = builder.isCodeFullScreen
        this.iconWidthAndHeight = builder.iconWidthAndHeight
        this.codeFullScreenIcon = builder.codeFullScreenIcon
        this.codeCopyIcon = builder.codeCopyIcon
        // 5.3、组合代码
        this.codeListTitleTextSize = builder.codeListTitleTextSize
        this.codeListTitleSelectTextColor = builder.codeListTitleSelectTextColor
        this.codeListTitleUnSelectTextColor = builder.codeListTitleUnSelectTextColor
        this.codeListTitleSelectBackGroupColor = builder.codeListTitleSelectBackGroupColor
        this.codeListTitleUnSelectBackGroupColor = builder.codeListTitleUnSelectBackGroupColor
        // 5.4、单独代码块
        this.isSeparateCodeBlock = builder.isSeparateCodeBlock
        this.separateCodeBlockWidth = builder.separateCodeBlockWidth

        // 6、标题
        this.headingBreakHeight = builder.headingBreakHeight
        this.headingBreakColor = builder.headingBreakColor
        this.headingTypeface = builder.headingTypeface
        this.headingTextSizeMultipliers = builder.headingTextSizeMultipliers
        this.headingTextColor = builder.headingTextColor
        this.headingTextWordSpace = builder.headingTextWordSpace
        this.headingTextLineHeight1 = builder.headingTextLineHeight1
        this.headingTextLineHeight2 = builder.headingTextLineHeight2
        this.headingTextLineHeight3 = builder.headingTextLineHeight3
        this.headingTextLineHeight4 = builder.headingTextLineHeight4
        this.headingTextLineHeight5 = builder.headingTextLineHeight5
        this.headingTextLineHeight6 = builder.headingTextLineHeight6

        // 7、段落
        this.paragraphTextSize = builder.paragraphTextSize
        this.paragraphTextColor = builder.paragraphTextColor
        this.paragraphTextWordSpace = builder.paragraphTextWordSpace
        this.paragraphTextLineHeight = builder.paragraphTextLineHeight
        this.paragraphTypeface = builder.paragraphTypeface

        // 8、分割线
        this.thematicBreakColor = builder.thematicBreakColor
        this.thematicBreakHeight = builder.thematicBreakHeight
        this.thematicBreakTopMargin = builder.thematicBreakTopMargin
        this.thematicBreakBottomMargin = builder.thematicBreakBottomMargin

        // 9、软换行
        this.isLineBreak = builder.isLineBreak

        // 10、数学公式
        this.latexMathTextSize = builder.latexMathTextSize
        this.latexMathTextLineSpacing = builder.latexMathTextLineSpacing
        this.latexMathBackGroupColor = builder.latexMathBackGroupColor
        this.latexMathTextColor = builder.latexMathTextColor
        this.latexMathColorFormat = builder.latexMathColorFormat
        this.latexMathBlockCenter = builder.latexMathBlockCenter
        this.latexMathResStr = builder.latexMathResStr

        // 11、音频
        this.audioIcon = builder.audioIcon
        this.audioShadowColor = builder.audioShadowColor
        this.audioBorderColor = builder.audioBorderColor
        this.audioBorderWidth = builder.audioBorderWidth
        this.audioBorderRadius = builder.audioBorderRadius
        this.audioButtonBackgroundColor = builder.audioButtonBackgroundColor
        this.audioButtonTextColor = builder.audioButtonTextColor
        this.audioButtonTextSize = builder.audioButtonTextSize
        this.audioButtonText = builder.audioButtonText
        this.audioButtonBorderRadius = builder.audioButtonBorderRadius
        this.audioTitleTextSize = builder.audioTitleTextSize
        this.audioTitleTextColor = builder.audioTitleTextColor
        this.audioTitleTextLineHeight = builder.audioTitleTextLineHeight
        this.audioTypeTextSize = builder.audioTypeTextSize
        this.audioTypeTextColor = builder.audioTypeTextColor
        this.audioTypeTextLineHeight = builder.audioTypeTextLineHeight
        this.audioMarginTop = builder.audioMarginTop
        this.audioMarginBottom = builder.audioMarginBottom

        // 12、视频
        this.videoImage = builder.videoImage
        this.playCircleFillIcon = builder.playCircleFillIcon
        this.videoBorderRadius = builder.videoBorderRadius
        this.videoTimeTextColor = builder.videoTimeTextColor
        this.videoTimeTextSize = builder.videoTimeTextSize
        this.videoTimeTextMarginRight = builder.videoTimeTextMarginRight
        this.videoTimeTextMarginBottom = builder.videoTimeTextMarginBottom
        this.videoMarginTop = builder.videoMarginTop
        this.videoMarginBottom = builder.videoMarginBottom

        // 13、图片banner
        this.bannerImage = builder.bannerImage

        // 14、图片
        this.isWord = builder.isWord
        this.imageResource = builder.imageResource
        this.imagePlaceholder = builder.imagePlaceholder
        this.isAutoResize = builder.isAutoResize
        this.imageMarginTop = builder.imageMarginTop
        this.imageMarginBottom = builder.imageMarginBottom

        // 15、表格
        this.tableCellPadding = builder.tableCellPadding
        this.tableBorderColor = builder.tableBorderColor
        this.tableBorderWidth = builder.tableBorderWidth
        this.tableOddRowBackgroundColor = builder.tableOddRowBackgroundColor
        this.tableEvenRowBackgroundColor = builder.tableEvenRowBackgroundColor
        this.tableHeaderRowBackgroundColor = builder.tableHeaderRowBackgroundColor
        this.tableTextLineHeight = builder.tableTextLineHeight
        this.tableRadius = builder.tableRadius
        this.tableMinTextWidth = builder.tableMinTextWidth
        this.tableMaxTextWidth = builder.tableMaxTextWidth
        this.tableFirstColumnBold = builder.tableFirstColumnBold

        // 16、代码高亮
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

        // 1、上下文

        // 2、模块间距

        // 3、链接
        // 3.1、文本格式链接
        markdownAIThemeBuilder.setLinkColor(COLOR_FF0000FF) // 链接文本颜色
        markdownAIThemeBuilder.setLinkBackGroupColor(COLOR_FFFFFFFF) // 链接背景颜色

        // 3.2、圆形图片格式链接
        markdownAIThemeBuilder.setLinkCircleImageBackGroupColor(COLOR_FFFFFFFF) // 圆形图片链接主题背景颜色
        markdownAIThemeBuilder.setLinkCircleImageButtonBackGroupColor(COLOR_FF000000) // 圆形图片链接控件背景颜色
        markdownAIThemeBuilder.setLinkCircleImageTextColor(COLOR_FFFFFFFF) // 圆形图片链接文字颜色
        markdownAIThemeBuilder.setLinkCircleImageBackGroupColor(COLOR_FFFFFFFF) // 圆形链接主题背景颜色

        // 3.3、圆角矩形图片格式链接
        markdownAIThemeBuilder.setLinkRectImageBackGroupColor(COLOR_FFFFFFFF) // 圆角矩形图片链接主题背景颜色
        markdownAIThemeBuilder.setLinkRectImageButtonBackGroupColor(COLOR_FF000000) // 圆角矩形图片链接控件背景颜色
        markdownAIThemeBuilder.setLinkRectImageTextColor(COLOR_FFFFFFFF) // 圆角矩形图片链接文字颜色

        // 3.4、空心圆角矩形图片格式链接
        markdownAIThemeBuilder.setLinkRectToolImageBackGroupColor(COLOR_FFFFFFFF) // 空心圆角矩形图片链接主题背景颜色
        markdownAIThemeBuilder.setLinkRectToolImageButtonBackGroupColor(COLOR_FFFFFFFF) // 空心圆角矩形图片链接控件背景颜色
        markdownAIThemeBuilder.setLinkRectToolImageButtonBorderColor(COLOR_FF000000) // 空心圆角矩形图片链接控件边框颜色
        markdownAIThemeBuilder.setLinkRectToolImageButtonDividingLineColor(COLOR_FF000000) // 空心圆角矩形图片链接控件分割线颜色
        markdownAIThemeBuilder.setLinkRectToolImageTextColor(COLOR_FF000000) // 空心圆角矩形图片链接文字颜色

        // 4、列表
        // 4.1、块引用
        markdownAIThemeBuilder.setBlockQuoteColor(COLOR_FF191919) // 块引用左边线条颜色
        markdownAIThemeBuilder.setBlockQuoteBackGroupColor(COLOR_FFFFFFFF) // 块引用背景颜色
        // 4.2、有序列表
        markdownAIThemeBuilder.setOrderedListItemColor(COLOR_FF191919) // 有序列表列表项的颜色
        // 4.1、无序列表
        markdownAIThemeBuilder.setBulletListItemColor(COLOR_FF191919) // 无序列表列表项的颜色

        // 5、代码
        // 5.1、内联代码
        markdownAIThemeBuilder.setCodeTextColor(COLOR_FF000000) // 文本、图片格式内联代码文本颜色
        markdownAIThemeBuilder.setCodeBackgroundColor(COLOR_FF191919) // 文本、图片格式内联代码背景颜色
        // 5.2、代码块
        // 5.3、组合代码
        markdownAIThemeBuilder.setCodeListTitleSelectTextColor(Color.RED) // 组合代码选中标题文本颜色
        markdownAIThemeBuilder.setCodeListTitleUnSelectTextColor(Color.BLACK) // 组合代码未选中标题文本颜色
        markdownAIThemeBuilder.setCodeListTitleSelectBackGroupColor(Color.GRAY) // 组合代码选中标题背景颜色
        markdownAIThemeBuilder.setCodeListTitleUnSelectBackGroupColor(Color.TRANSPARENT) // 组合代码未选中标题背景颜色
        // 5.4、单独代码块

        // 6、标题
        markdownAIThemeBuilder.setHeadingBreakColor(COLOR_FF191919) // H1、H2标题下分割线颜色
        markdownAIThemeBuilder.setHeadingTextColor(COLOR_FF191919) // 标题文本颜色

        // 7、段落
        markdownAIThemeBuilder.setParagraphTextColor(COLOR_FF191919) // 段落文本颜色

        // 8、分割线
        markdownAIThemeBuilder.setThematicBreakColor(COLOR_FF191919) // 分割线颜色

        // 9、软换行

        // 10、数学公式
        markdownAIThemeBuilder.setLatexMathBackGroupColor(COLOR_FFFFFFFF) // 数学公式背景色
        markdownAIThemeBuilder.setLatexMathTextColor(COLOR_FF000000) // 数学公式文本颜色

        // 11、音频
        markdownAIThemeBuilder.setAudioShadowColor(COLOR_1A000000) // 音频阴影颜色值
        markdownAIThemeBuilder.setAudioBorderColor(COLOR_33000000) // 音频边框颜色
        markdownAIThemeBuilder.setAudioButtonBackgroundColor(Color.BLACK) // 音频按钮背景颜色
        markdownAIThemeBuilder.setAudioButtonTextColor(Color.WHITE) // 音频按钮文字颜色
        markdownAIThemeBuilder.setAudioTitleTextColor(Color.BLACK) // 音频标题文字颜色
        markdownAIThemeBuilder.setAudioTypeTextColor(COLOR_80000000) // 音频类型文字颜色

        // 12、视频
        markdownAIThemeBuilder.setVideoTimeTextColor(Color.WHITE) // 视频时间文本颜色

        // 13、图片banner

        // 14、图片

        // 15、表格
        markdownAIThemeBuilder.setTableBorderColor(COLOR_FF000000) // 表格边框颜色
        markdownAIThemeBuilder.setTableOddRowBackgroundColor(COLOR_FFFFFFFF) // 表格奇数行背景色
        markdownAIThemeBuilder.setTableEvenRowBackgroundColor(COLOR_FFE0E0E0) // 表格偶数行背景色
        markdownAIThemeBuilder.setTableHeaderRowBackgroundColor(COLOR_FFFFFFFF) // 表格头背景色

        // 16、代码高亮
        markdownAIThemeBuilder.setPrismTheme(PrismThemeDarkula.create()) // markdown代码高亮样式

        return markdownAIThemeBuilder
    }

    /**
     * 创建暗色的Theme对象
     *
     * @return MarkdownAITheme 创建暗色的MarkdownAITheme对象
     */
    public static func createDarkulaBuilder(): MarkdownAIThemeBuilder {
        let markdownAIThemeBuilder: MarkdownAIThemeBuilder = MarkdownAIThemeBuilder()

        // 1、上下文

        // 2、模块间距

        // 3、链接
        // 3.1、文本格式链接
        markdownAIThemeBuilder.setLinkColor(COLOR_FF0000FF) // 链接文本颜色
        markdownAIThemeBuilder.setLinkBackGroupColor(COLOR_FFFFFFFF) // 链接背景颜色
        // 3.2、圆形图片格式链接
        markdownAIThemeBuilder.setLinkCircleImageBackGroupColor(COLOR_FFFFFFFF) // 圆形图片链接主题背景颜色
        markdownAIThemeBuilder.setLinkCircleImageButtonBackGroupColor(COLOR_FF000000) // 圆形图片链接控件背景颜色
        markdownAIThemeBuilder.setLinkCircleImageTextColor(COLOR_FFFFFFFF) // 圆形图片链接文字颜色
        markdownAIThemeBuilder.setLinkCircleImageBackGroupColor(COLOR_FFFFFFFF) // 圆形链接主题背景颜色
        // 3.3、圆角矩形图片格式链接
        markdownAIThemeBuilder.setLinkRectImageBackGroupColor(COLOR_FFFFFFFF) // 圆角矩形图片链接主题背景颜色
        markdownAIThemeBuilder.setLinkRectImageButtonBackGroupColor(COLOR_FF000000) // 圆角矩形图片链接控件背景颜色
        markdownAIThemeBuilder.setLinkRectImageTextColor(COLOR_FFFFFFFF) // 圆角矩形图片链接文字颜色
        // 3.4、空心圆角矩形图片格式链接
        markdownAIThemeBuilder.setLinkRectToolImageBackGroupColor(COLOR_FFFFFFFF) // 空心圆角矩形图片链接主题背景颜色
        markdownAIThemeBuilder.setLinkRectToolImageButtonBackGroupColor(COLOR_FFFFFFFF) // 空心圆角矩形图片链接控件背景颜色
        markdownAIThemeBuilder.setLinkRectToolImageButtonBorderColor(COLOR_FF000000) // 空心圆角矩形图片链接控件边框颜色
        markdownAIThemeBuilder.setLinkRectToolImageButtonDividingLineColor(COLOR_FF000000) // 空心圆角矩形图片链接控件分割线颜色
        markdownAIThemeBuilder.setLinkRectToolImageTextColor(COLOR_FF000000) // 空心圆角矩形图片链接文字颜色

        // 4、列表
        // 4.1、块引用
        markdownAIThemeBuilder.setBlockQuoteColor(COLOR_FF191919) // 块引用左边线条颜色
        markdownAIThemeBuilder.setBlockQuoteBackGroupColor(COLOR_FFFFFFFF) // 块引用背景颜色
        // 4.2、有序列表
        markdownAIThemeBuilder.setOrderedListItemColor(COLOR_FF191919) // 有序列表列表项的颜色
        // 4.1、无序列表
        markdownAIThemeBuilder.setBulletListItemColor(COLOR_FF191919) // 无序列表列表项的颜色

        // 5、代码
        // 5.1、内联代码
        markdownAIThemeBuilder.setCodeTextColor(COLOR_FF000000) // 文本、图片格式内联代码文本颜色
        markdownAIThemeBuilder.setCodeBackgroundColor(COLOR_FF191919) // 文本、图片格式内联代码背景颜色
        // 5.2、代码块
        // 5.3、组合代码
        markdownAIThemeBuilder.setCodeListTitleSelectTextColor(Color.RED) // 组合代码选中标题文本颜色
        markdownAIThemeBuilder.setCodeListTitleUnSelectTextColor(Color.BLACK) // 组合代码未选中标题文本颜色
        markdownAIThemeBuilder.setCodeListTitleSelectBackGroupColor(Color.GRAY) // 组合代码选中标题背景颜色
        markdownAIThemeBuilder.setCodeListTitleUnSelectBackGroupColor(Color.TRANSPARENT) // 组合代码未选中标题背景颜色
        // 5.4、单独代码块

        // 6、标题
        markdownAIThemeBuilder.setHeadingBreakColor(COLOR_FF191919) // H1、H2标题下分割线颜色
        markdownAIThemeBuilder.setHeadingTextColor(COLOR_FF191919) // 标题文本颜色

        // 7、段落
        markdownAIThemeBuilder.setParagraphTextColor(COLOR_FF191919) // 段落文本颜色

        // 8、分割线
        markdownAIThemeBuilder.setThematicBreakColor(COLOR_FF191919) // 分割线颜色

        // 9、软换行

        // 10、数学公式
        markdownAIThemeBuilder.setLatexMathBackGroupColor(COLOR_FFFFFFFF) // 数学公式背景色
        markdownAIThemeBuilder.setLatexMathTextColor(COLOR_FF000000) // 数学公式文本颜色

        // 11、音频
        markdownAIThemeBuilder.setAudioShadowColor(COLOR_1A000000) // 音频阴影颜色值
        markdownAIThemeBuilder.setAudioBorderColor(COLOR_33000000) // 音频边框颜色
        markdownAIThemeBuilder.setAudioButtonBackgroundColor(Color.BLACK) // 音频按钮背景颜色
        markdownAIThemeBuilder.setAudioButtonTextColor(Color.WHITE) // 音频按钮文字颜色
        markdownAIThemeBuilder.setAudioTitleTextColor(Color.BLACK) // 音频标题文字颜色
        markdownAIThemeBuilder.setAudioTypeTextColor(COLOR_80000000) // 音频类型文字颜色

        // 12、视频
        markdownAIThemeBuilder.setVideoTimeTextColor(Color.WHITE) // 视频时间文本颜色

        // 13、图片banner

        // 14、图片

        // 15、表格
        markdownAIThemeBuilder.setTableBorderColor(COLOR_FF000000) // 表格边框颜色
        markdownAIThemeBuilder.setTableOddRowBackgroundColor(COLOR_FFFFFFFF) // 表格奇数行背景色
        markdownAIThemeBuilder.setTableEvenRowBackgroundColor(COLOR_FFE0E0E0) // 表格偶数行背景色
        markdownAIThemeBuilder.setTableHeaderRowBackgroundColor(COLOR_FFFFFFFF) // 表格头背景色

        // 16、代码高亮
        markdownAIThemeBuilder.setPrismTheme(PrismThemeDarkula.create()) // markdown代码高亮样式

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
     * markdown上下文 - 互操作
     */
    protected var stageContext: ?StageContext = None

    /**
     * markdown上下文 - 仓颉
     */
    protected var abilityContext: ?AbilityContext = None

    /**
     * 模块间上下间距
     */
    protected var blockTopAndBottomMargins: Float64 = 8.0

    /**
     * 链接是否是图片显示
     */
    protected var isLinkStyle: Bool = false

    /**
     * 列表中的单行链接是否是图片显示
     */
    protected var isListLinkStyle: Bool = false

    /**
     * 文本格式链接文本颜色
     */
    protected var linkColor: Color = COLOR_FF0000FF

    /**
     * 是否按照链接文字自己大小显示文本
     */
    protected var isLinkSize: Bool = true

    /**
     * 文本格式链接文字大小
     */
    protected var linkSize: Float64 = 14.0

    /**
     * 文本格式链接背景颜色
     */
    protected var linkBackGroupColor: Color = Color.TRANSPARENT

    /**
     * 文本格式是否显示链接下划线
     */
    protected var isLinkUnderlined: Bool = true

    /**
     * 圆形图片格式链接主题背景颜色
     */
    protected var linkCircleImageBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 圆形图片格式链接控件背景颜色
     */
    protected var linkCircleImageButtonBackGroupColor: Color = COLOR_FF000000

    /**
     * 圆形图片格式链接文字大小
     */
    protected var linkCircleImageTextSize: Float64 = fp2px(14.0.fp).getOrThrow().value

    /**
     * 圆形图片格式链接文字颜色
     */
    protected var linkCircleImageTextColor: Color = COLOR_FFFFFFFF

    /**
     * 圆形图片格式链接半径
     */
    protected var linkCircleImageRadius: Float64 = vp2px(20.0.vp).getOrThrow().value

    /**
     * 圆形图片格式链接左右外边距
     */
    protected var linkCircleImageMargin: Float64 = 6.0

    /**
     * 圆角矩形图片格式链接主题背景颜色
     */
    protected var linkRectImageBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 圆角矩形图片格式链接控件背景颜色
     */
    protected var linkRectImageButtonBackGroupColor: Color = COLOR_FF000000

    /**
     * 圆角矩形图片格式链接文字大小
     */
    protected var linkRectImageTextSize: Float64 = fp2px(14.0.fp).getOrThrow().value

    /**
     * 圆角矩形图片格式链接文字颜色
     */
    protected var linkRectImageTextColor: Color = COLOR_FFFFFFFF

    /**
     * 圆角矩形图片格式链接控件高度
     */
    protected var linkRectImageHeight: Float64 = vp2px(20.0.vp).getOrThrow().value

    /**
     * 圆角矩形图片格式链接左右内边距
     */
    protected var linkRectImagePadding: Float64 = vp2px(6.0.vp).getOrThrow().value

    /**
     * 圆角矩形图片格式链接圆角半径
     */
    protected var linkRectImageRadius: Float64 = vp2px(6.0.vp).getOrThrow().value

    /**
     * 圆角矩形图片格式链接左右外边距
     */
    protected var linkRectImageMargin: Float64 = 6.0

    /**
     * 空心圆角矩形图片格式链接主题背景颜色
     */
    protected var linkRectToolImageBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 空心圆角矩形图片格式链接控件背景颜色
     */
    protected var linkRectToolImageButtonBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 空心圆角矩形图片格式链接控件边框颜色
     */
    protected var linkRectToolImageButtonBorderColor: Color = COLOR_FF000000

    /**
     * 空心圆角矩形图片格式链接控件分割线颜色
     */
    protected var linkRectToolImageButtonDividingLineColor: Color = COLOR_FF000000

    /**
     * 空心圆角矩形图片格式链接文字大小
     */
    protected var linkRectToolImageTextSize: Float64 = fp2px(14.0.fp).getOrThrow().value

    /**
     * 空心圆角矩形图片格式链接文字颜色
     */
    protected var linkRectToolImageTextColor: Color = COLOR_FF000000

    /**
     * 空心圆角矩形图片格式链接控件高度
     */
    protected var linkRectToolImageHeight: Float64 = vp2px(21.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形图片格式链接左右内边距
     */
    protected var linkRectToolImagePadding: Float64 = vp2px(6.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形图片格式链接边框宽度
     */
    protected var linkRectToolImageBorderWidth: Float64 = vp2px(1.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形图片格式链接分割线宽度
     */
    protected var linkRectToolImageDividingLineWidth: Float64 = vp2px(1.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形图片格式链接左右外边距
     */
    protected var linkRectToolImageMargin: Float64 = 6.0

    /**
     * 空心圆角矩形图片格式分割线和文本左边距
     */
    protected var linkRectToolImageLineLeftPadding: Float64 = vp2px(3.0.vp).getOrThrow().value

    /**
     * 空心圆角矩形图片格式分割线和文本右边距
     */
    protected var linkRectToolImageLineRightPadding: Float64 = vp2px(3.0.vp).getOrThrow().value

    /**
     * 块引用左边距
     */
    protected var blockQuoteLeftMargin: Float64 = 8.0

    /**
     * 块引用右边距
     */
    protected var blockQuoteRightMargin: Float64 = 8.0

    /**
     * 块引用左边线条宽度
     */
    protected var blockQuoteWidth: Float64 = 1.0

    /**
     * 块引用左边线条颜色
     */
    protected var blockQuoteColor: Color = COLOR_FF191919

    /**
     * 块引用背景颜色
     */
    protected var blockQuoteBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 块引用子模块上下间距
     */
    protected var blockQuoteTopAndBottomMargins: Float64 = 0.0

    /**
     * 有序列表、无序列表、任务列表子模块上下间距
     */
    protected var blockOrderedAndBulletTopAndBottomMargins: Float64 = 0.0

    /**
     * 有序列表、无序列表、任务列表左边距
     */
    protected var blockLeftMargin: Float64 = 8.0

    /**
     * 有序列表、无序列表、任务列表右边距
     */
    protected var blockRightMargin: Float64 = 8.0

    /**
     * 有序列表前缀文本是否加粗
     */
    protected var orderedListItemPrefixBold: Bool = false

    /**
     * 有序列表前缀文本颜色
     */
    protected var orderedListItemColor: Color = COLOR_FF191919

    /**
     * 有序列表前缀文本大小
     */
    protected var orderedListItemSize: Float64 = 14.0

    /**
     * 有序列表前缀文本行高
     */
    protected var orderedListItemLineHeight: Float64 = 22.0

    /**
     * 无序列表前缀文本颜色
     */
    protected var bulletListItemColor: Color = COLOR_FF191919

    /**
     * 无序列表前缀文本大小
     */
    protected var bulletListItemSize: Float64 = 4.0

    /**
     * 无序列表前缀文本行高
     */
    protected var bulletListItemLineHeight: Float64 = 18.0

    /**
     * 任务列表选择框宽高
     */
    protected var taskListItemLength: Float64 = 15.0

    /**
     * 内联代码是否是图片显示
     */
    protected var isCodeStyle: Bool = false

    /**
     * 文本、图片格式内联代码文本颜色
     */
    protected var codeTextColor: Color = COLOR_FF000000

    /**
     * 文本、图片格式内联代码背景颜色
     */
    protected var codeBackgroundColor: Color = COLOR_FF191919

    /**
     * 文本、图片格式内联代码文本大小
     */
    protected var codeTextSize: Float64 = fp2px(13.0.fp).getOrThrow().value

    /**
     * 文本格式内联代码文本字体
     */
    protected var codeTypeface: String = "HarmonyOS Sans"

    /**
     * 图片格式内联代码文本左右边距
     */
    protected var codeLeftAndRightPadding: Float64 = vp2px(4.0.vp).getOrThrow().value

    /**
     * 图片格式内联代码文本高度
     */
    protected var codeHeight: Float64 = vp2px(20.0.vp).getOrThrow().value

    /**
     * 代码块代码文本颜色
     */
    protected var codeBlockTextColor: ?Color = None

    /**
     * 代码块代码类型文本颜色
     */
    protected var codeBlockTypeTextColor: ?Color = None

    /**
     * 代码块复制、全屏图片文字是否显示
     */
    protected var codeBlockIconTextHide: Bool = true

    /**
     * 代码块代码行号是否显示
     */
    protected var codeBlockLineNumberHide: Bool = true

    /**
     * 代码块背景颜色
     */
    protected var codeBlockBackgroundColor: ?Color = None

    /**
     * 代码块代码类型默认文本
     */
    protected var codeBlockTypeTextStr: String = ""

    /**
     * 代码类型和代码块距离
     */
    protected var codeBlockTypeTextPadding: Float64 = 0.0

    /**
     * 代码块左边距
     */
    protected var codeMultilineMargin: Float64 = 8.0

    /**
     * 代码块字体
     */
    protected var codeBlockTypeface: String = "HarmonyOS Sans"

    /**
     * 代码块代码文本大小
     */
    protected var codeBlockTextSize: Float64 = 13.0

    /**
     * 代码块代码文本行高
     */
    protected var codeBlockLineHeight: Float64 = 22.0

    /**
     * 代码块控件圆角大小
     */
    protected var codeBlockRadius: Float64 = 8.0

    /**
     * 代码块代码全屏按钮是否显示
     */
    protected var isCodeFullScreen: Bool = true

    /**
     * 代码块代码全屏、代码复制按钮宽高
     */
    protected var iconWidthAndHeight: Float64 = 24.0

    /**
     * 代码块代码全屏按钮默认图标
     */
    protected var codeFullScreenIcon: ?CJResource = None

    /**
     * 代码块代码复制按钮默认图标
     */
    protected var codeCopyIcon: ?CJResource = None

    /**
     * 组合代码未选中标题字体大小
     */
    protected var codeListTitleTextSize: Float64 = 13.0

    /**
     * 组合代码选中标题字体大小
     */
    protected var codeListTitleSelectTextSize: Float64 = 13.0

    /**
     * 组合代码选中标题文本颜色
     */
    protected var codeListTitleSelectTextColor: Color = Color.RED

    /**
     * 组合代码未选中标题文本颜色
     */
    protected var codeListTitleUnSelectTextColor: Color = Color.BLACK

    /**
     * 组合代码选中标题背景颜色
     */
    protected var codeListTitleSelectBackGroupColor: Color = Color.GRAY

    /**
     * 组合代码未选中标题背景颜色
     */
    protected var codeListTitleUnSelectBackGroupColor: Color = Color.TRANSPARENT

    /**
     * 是否单独代码块显示
     */
    protected var isSeparateCodeBlock: Bool = false

    /**
     * 单独代码块行号宽度
     */
    protected var separateCodeBlockWidth: Float64 = 50.0

    /**
     * H1、H2标题下分割线高度
     */
    protected var headingBreakHeight: Float64 = 0.5

    /**
     * H1、H2标题下分割线颜色
     */
    protected var headingBreakColor: Color = COLOR_FF191919

    /**
     * 标题文本字体
     */
    protected var headingTypeface: String = "HarmonyOS Sans"

    /**
     * 标题文本大小数组
     */
    protected var headingTextSizeMultipliers: Array<Float64> = [20.0, 17.0, 16.0, 15.0, 15.0, 13.0]

    /**
     * 标题文本颜色
     */
    protected var headingTextColor: Color = COLOR_FF191919

    /**
     * 标题文本字间距
     */
    protected var headingTextWordSpace: Float64 = 0.0

    /**
     * 一级标题文本行高
     */
    protected var headingTextLineHeight1: Float64 = 22.0

    /**
     * 二级标题文本行高
     */
    protected var headingTextLineHeight2: Float64 = 22.0

    /**
     * 三级标题文本行高
     */
    protected var headingTextLineHeight3: Float64 = 22.0

    /**
     * 四级标题文本行高
     */
    protected var headingTextLineHeight4: Float64 = 22.0

    /**
     * 五级标题文本行高
     */
    protected var headingTextLineHeight5: Float64 = 22.0

    /**
     * 六级标题文本行高
     */
    protected var headingTextLineHeight6: Float64 = 22.0

    /**
     * 段落文本大小
     */
    protected var paragraphTextSize: Float64 = 14.0

    /**
     * 段落文本颜色
     */
    protected var paragraphTextColor: Color = COLOR_FF191919

    /**
     * 段落文本字间距
     */
    protected var paragraphTextWordSpace: Float64 = 0.0

    /**
     * 段落文本行高
     */
    protected var paragraphTextLineHeight: Float64 = 22.0

    /**
     * 段落文本字体
     */
    protected var paragraphTypeface: String = "HarmonyOS Sans"

    /**
     * 分割线颜色
     */
    protected var thematicBreakColor: Color = COLOR_FF191919

    /**
     * 分割线高度
     */
    protected var thematicBreakHeight: Float64 = 0.5

    /**
     * 分割线上部外边距
     */
    protected var thematicBreakTopMargin: Float64 = 0.0

    /**
     * 分割线下部外边距
     */
    protected var thematicBreakBottomMargin: Float64 = 0.0

    /**
     * 软换行是否换行
     */
    protected var isLineBreak: Bool = false

    /**
     * 数学公式文本大小
     */
    protected var latexMathTextSize: Float64 = fp2px(16.0.fp)().value

    /**
     * 数学公式文本行距
     */
    protected var latexMathTextLineSpacing: Float64 = 10.0

    /**
     * 数学公式背景色
     */
    protected var latexMathBackGroupColor: Color = COLOR_FFFFFFFF

    /**
     * 数学公式文本颜色
     */
    protected var latexMathTextColor: Color = COLOR_FF000000

    /**
     * 数学公式生成图片格式
     */
    protected var latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888

    /**
     * 块结构的数学公式是否居中
     */
    protected var latexMathBlockCenter: Bool = false

    /**
     * 数学公式字体路径
     */
    protected var latexMathResStr: String = "/data/storage/el1/bundle/entry/resources/resfile/res"

    /**
     * 音频图标
     */
    protected var audioIcon: ?CJResource = None

    /**
     * 音频阴影颜色值
     */
    protected var audioShadowColor: Color = COLOR_1A000000

    /**
     * 音频边框颜色
     */
    protected var audioBorderColor: Color = COLOR_33000000

    /**
     * 音频边框粗细
     */
    protected var audioBorderWidth: Float64 = 0.5

    /**
     * 音频边框圆角
     */
    protected var audioBorderRadius: Float64 = 12.0

    /**
     * 音频按钮背景颜色
     */
    protected var audioButtonBackgroundColor: Color = Color.BLACK

    /**
     * 音频按钮文字颜色
     */
    protected var audioButtonTextColor: Color = Color.WHITE

    /**
     * 音频按钮文字大小
     */
    protected var audioButtonTextSize: Float64 = 14.0

    /**
     * 音频按钮文字内容
     */
    protected var audioButtonText: String = "立即播放"

    /**
     * 音频按钮圆角
     */
    protected var audioButtonBorderRadius: Float64 = 16.0

    /**
     * 音频标题文字大小
     */
    protected var audioTitleTextSize: Float64 = 15.0

    /**
     * 音频标题文字颜色
     */
    protected var audioTitleTextColor: Color = Color.BLACK

    /**
     * 音频标题文字行高
     */
    protected var audioTitleTextLineHeight: Float64 = 20.0

    /**
     * 音频类型文字大小
     */
    protected var audioTypeTextSize: Float64 = 11.0

    /**
     * 音频类型文字颜色
     */
    protected var audioTypeTextColor: Color = COLOR_80000000

    /**
     * 音频类型文字行高
     */
    protected var audioTypeTextLineHeight: Float64 = 15.0

    /**
     * 音频上边距
     */
    protected var audioMarginTop: Float64 = 10.0

    /**
     * 音频下边距
     */
    protected var audioMarginBottom: Float64 = 10.0

    /**
     * 视频默认占位图
     */
    protected var videoImage: ?CJResource = None

    /**
     * 视频播放按钮默认图标
     */
    protected var playCircleFillIcon: ?CJResource = None

    /**
     * 视频圆角
     */
    protected var videoBorderRadius: Float64 = 10.0

    /**
     * 视频时间文本颜色
     */
    protected var videoTimeTextColor: Color = Color.WHITE

    /**
     * 视频时间文本大小
     */
    protected var videoTimeTextSize: Float64 = 14.0

    /**
     * 视频时间文本居右边距
     */
    protected var videoTimeTextMarginRight: Float64 = 10.0

    /**
     * 视频时间文本居底边距
     */
    protected var videoTimeTextMarginBottom: Float64 = 10.0

    /**
     * 视频上边距
     */
    protected var videoMarginTop: Float64 = 10.0

    /**
     * 视频下边距
     */
    protected var videoMarginBottom: Float64 = 10.0

    /**
     * 图片banner默认占位图
     */
    protected var bannerImage: ?CJResource = None

    /**
     * 图片文字是否需要图文混排
     */
    protected var isWord: Bool = true

    /**
     * 图片默认占位图 - CJResource
     */
    protected var imageResource: ?CJResource = None

    /**
     * 图片默认占位图 - String
     */
    protected var imagePlaceholder: ?String = None

    /**
     * 网络图片是否压缩
     */
    protected var isAutoResize: Bool = true

    /**
     * 图片上边距
     */
    protected var imageMarginTop: Float64 = 10.0

    /**
     * 图片下边距
     */
    protected var imageMarginBottom: Float64 = 10.0

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
     * 表格文本行高
     */
    protected var tableTextLineHeight: Float64 = 22.0

    /**
     * 表格圆角
     */
    protected var tableRadius: Float64 = 5.0

    /**
     * 表格最小宽度
     */
    protected var tableMinTextWidth: Float64 = 50.0

    /**
     * 表格最大宽度
     */
    protected var tableMaxTextWidth: Float64 = 300.0

    /**
     * 表格第一列是否加粗
     */
    protected var tableFirstColumnBold: Bool = false

    /**
     * markdown代码高亮样式
     */
    protected var prismTheme: PrismTheme = PrismThemeDarkula.create()

    init() {
    }

    init(theme: MarkdownAITheme) {
        // 1、上下文
        this.stageContext = theme.stageContext
        this.abilityContext = theme.abilityContext

        // 2、模块间距
        this.blockTopAndBottomMargins = theme.blockTopAndBottomMargins

        // 3、链接
        this.isLinkStyle = theme.isLinkStyle
        this.isListLinkStyle = theme.isListLinkStyle
        // 3.1、文本格式链接
        this.linkColor = theme.linkColor
        this.isLinkSize = theme.isLinkSize
        this.linkSize = theme.linkSize
        this.linkBackGroupColor = theme.linkBackGroupColor
        this.isLinkUnderlined = theme.isLinkUnderlined
        // 3.2、圆形图片格式链接
        this.linkCircleImageBackGroupColor = theme.linkCircleImageBackGroupColor
        this.linkCircleImageButtonBackGroupColor = theme.linkCircleImageButtonBackGroupColor
        this.linkCircleImageTextSize = theme.linkCircleImageTextSize
        this.linkCircleImageTextColor = theme.linkCircleImageTextColor
        this.linkCircleImageRadius = theme.linkCircleImageRadius
        this.linkCircleImageMargin = theme.linkCircleImageMargin
        // 3.3、圆角矩形图片格式链接
        this.linkRectImageBackGroupColor = theme.linkRectImageBackGroupColor
        this.linkRectImageButtonBackGroupColor = theme.linkRectImageButtonBackGroupColor
        this.linkRectImageTextSize = theme.linkRectImageTextSize
        this.linkRectImageTextColor = theme.linkRectImageTextColor
        this.linkRectImageHeight = theme.linkRectImageHeight
        this.linkRectImagePadding = theme.linkRectImagePadding
        this.linkRectImageRadius = theme.linkRectImageRadius
        this.linkRectImageMargin = theme.linkRectImageMargin
        // 3.4、空心圆角矩形图片格式链接
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

        // 4、列表
        // 4.1、块引用
        this.blockQuoteLeftMargin = theme.blockQuoteLeftMargin
        this.blockQuoteRightMargin = theme.blockQuoteRightMargin
        this.blockQuoteWidth = theme.blockQuoteWidth
        this.blockQuoteColor = theme.blockQuoteColor
        this.blockQuoteBackGroupColor = theme.blockQuoteBackGroupColor
        this.blockQuoteTopAndBottomMargins = theme.blockQuoteTopAndBottomMargins
        // 4.2、有序列表、无序列表、任务列表
        this.blockOrderedAndBulletTopAndBottomMargins = theme.blockOrderedAndBulletTopAndBottomMargins
        this.blockLeftMargin = theme.blockLeftMargin
        this.blockRightMargin = theme.blockRightMargin
        // 4.3、有序列表
        this.orderedListItemPrefixBold = theme.orderedListItemPrefixBold
        this.orderedListItemColor = theme.orderedListItemColor
        this.orderedListItemSize = theme.orderedListItemSize
        this.orderedListItemLineHeight = theme.orderedListItemLineHeight
        // 4.4、无序列表
        this.bulletListItemColor = theme.bulletListItemColor
        this.bulletListItemSize = theme.bulletListItemSize
        this.bulletListItemLineHeight = theme.bulletListItemLineHeight
        // 4.5、任务列表
        this.taskListItemLength = theme.taskListItemLength

        // 5、代码
        // 5.1、内联代码
        this.isCodeStyle = theme.isCodeStyle
        this.codeTextColor = theme.codeTextColor
        this.codeBackgroundColor = theme.codeBackgroundColor
        this.codeTypeface = theme.codeTypeface
        this.codeTextSize = theme.codeTextSize
        this.codeLeftAndRightPadding = theme.codeLeftAndRightPadding
        this.codeHeight = theme.codeHeight
        // 5.2、代码块
        this.codeBlockTextColor = theme.codeBlockTextColor
        this.codeBlockTypeTextColor = theme.codeBlockTypeTextColor
        this.codeBlockTypeTextStr = theme.codeBlockTypeTextStr
        this.codeBlockTypeTextPadding = theme.codeBlockTypeTextPadding
        this.codeBlockIconTextHide = theme.codeBlockIconTextHide
        this.codeBlockLineNumberHide = theme.codeBlockLineNumberHide
        this.codeBlockBackgroundColor = theme.codeBlockBackgroundColor
        this.codeMultilineMargin = theme.codeMultilineMargin
        this.codeTypeface = theme.codeTypeface
        this.codeBlockTypeface = theme.codeBlockTypeface
        this.codeTextSize = theme.codeTextSize
        this.codeBlockTextSize = theme.codeBlockTextSize
        this.codeBlockLineHeight = theme.codeBlockLineHeight
        this.codeBlockRadius = theme.codeBlockRadius
        this.isCodeFullScreen = theme.isCodeFullScreen
        this.iconWidthAndHeight = theme.iconWidthAndHeight
        this.codeFullScreenIcon = theme.codeFullScreenIcon
        this.codeCopyIcon = theme.codeCopyIcon
        // 5.3、组合代码
        this.codeListTitleTextSize = theme.codeListTitleTextSize
        this.codeListTitleSelectTextColor = theme.codeListTitleSelectTextColor
        this.codeListTitleUnSelectTextColor = theme.codeListTitleUnSelectTextColor
        this.codeListTitleSelectBackGroupColor = theme.codeListTitleSelectBackGroupColor
        this.codeListTitleUnSelectBackGroupColor = theme.codeListTitleUnSelectBackGroupColor
        // 5.4、单独代码块
        this.isSeparateCodeBlock = theme.isSeparateCodeBlock
        this.separateCodeBlockWidth = theme.separateCodeBlockWidth

        // 6、标题
        this.headingBreakHeight = theme.headingBreakHeight
        this.headingBreakColor = theme.headingBreakColor
        this.headingTypeface = theme.headingTypeface
        this.headingTextSizeMultipliers = theme.headingTextSizeMultipliers
        this.headingTextColor = theme.headingTextColor
        this.headingTextWordSpace = theme.headingTextWordSpace
        this.headingTextLineHeight1 = theme.headingTextLineHeight1
        this.headingTextLineHeight2 = theme.headingTextLineHeight2
        this.headingTextLineHeight3 = theme.headingTextLineHeight3
        this.headingTextLineHeight4 = theme.headingTextLineHeight4
        this.headingTextLineHeight5 = theme.headingTextLineHeight5
        this.headingTextLineHeight6 = theme.headingTextLineHeight6

        // 7、段落
        this.paragraphTextSize = theme.paragraphTextSize
        this.paragraphTextColor = theme.paragraphTextColor
        this.paragraphTextWordSpace = theme.paragraphTextWordSpace
        this.paragraphTextLineHeight = theme.paragraphTextLineHeight
        this.paragraphTypeface = theme.paragraphTypeface

        // 8、分割线
        this.thematicBreakColor = theme.thematicBreakColor
        this.thematicBreakHeight = theme.thematicBreakHeight
        this.thematicBreakTopMargin = theme.thematicBreakTopMargin
        this.thematicBreakBottomMargin = theme.thematicBreakBottomMargin

        // 9、软换行
        this.isLineBreak = theme.isLineBreak

        // 10、数学公式
        this.latexMathTextSize = theme.latexMathTextSize
        this.latexMathTextLineSpacing = theme.latexMathTextLineSpacing
        this.latexMathBackGroupColor = theme.latexMathBackGroupColor
        this.latexMathTextColor = theme.latexMathTextColor
        this.latexMathColorFormat = theme.latexMathColorFormat
        this.latexMathBlockCenter = theme.latexMathBlockCenter
        this.latexMathResStr = theme.latexMathResStr

        // 11、音频
        this.audioIcon = theme.audioIcon
        this.audioShadowColor = theme.audioShadowColor
        this.audioBorderColor = theme.audioBorderColor
        this.audioBorderWidth = theme.audioBorderWidth
        this.audioBorderRadius = theme.audioBorderRadius
        this.audioButtonBackgroundColor = theme.audioButtonBackgroundColor
        this.audioButtonTextColor = theme.audioButtonTextColor
        this.audioButtonTextSize = theme.audioButtonTextSize
        this.audioButtonText = theme.audioButtonText
        this.audioButtonBorderRadius = theme.audioButtonBorderRadius
        this.audioTitleTextSize = theme.audioTitleTextSize
        this.audioTitleTextColor = theme.audioTitleTextColor
        this.audioTitleTextLineHeight = theme.audioTitleTextLineHeight
        this.audioTypeTextSize = theme.audioTypeTextSize
        this.audioTypeTextColor = theme.audioTypeTextColor
        this.audioTypeTextLineHeight = theme.audioTypeTextLineHeight
        this.audioMarginTop = theme.audioMarginTop
        this.audioMarginBottom = theme.audioMarginBottom

        // 12、视频
        this.videoImage = theme.videoImage
        this.playCircleFillIcon = theme.playCircleFillIcon
        this.videoBorderRadius = theme.videoBorderRadius
        this.videoTimeTextColor = theme.videoTimeTextColor
        this.videoTimeTextSize = theme.videoTimeTextSize
        this.videoTimeTextMarginRight = theme.videoTimeTextMarginRight
        this.videoTimeTextMarginBottom = theme.videoTimeTextMarginBottom
        this.videoMarginTop = theme.videoMarginTop
        this.videoMarginBottom = theme.videoMarginBottom

        // 13、图片banner
        this.bannerImage = theme.bannerImage

        // 14、图片
        this.isWord = theme.isWord
        this.imageResource = theme.imageResource
        this.imagePlaceholder = theme.imagePlaceholder
        this.isAutoResize = theme.isAutoResize
        this.imageMarginTop = theme.imageMarginTop
        this.imageMarginBottom = theme.imageMarginBottom

        // 15、表格
        this.tableCellPadding = theme.tableCellPadding
        this.tableBorderColor = theme.tableBorderColor
        this.tableBorderWidth = theme.tableBorderWidth
        this.tableOddRowBackgroundColor = theme.tableOddRowBackgroundColor
        this.tableEvenRowBackgroundColor = theme.tableEvenRowBackgroundColor
        this.tableHeaderRowBackgroundColor = theme.tableHeaderRowBackgroundColor
        this.tableTextLineHeight = theme.tableTextLineHeight
        this.tableRadius = theme.tableRadius
        this.tableMinTextWidth = theme.tableMinTextWidth
        this.tableMaxTextWidth = theme.tableMaxTextWidth
        this.tableFirstColumnBold = theme.tableFirstColumnBold

        // 16、代码高亮
        this.prismTheme = theme.prismTheme
    }

    /**
     * 设置浅色主题整体样式
     *
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setDefaultTheme(): MarkdownAIThemeBuilder {
        // 1、上下文

        // 2、模块间距

        // 3、链接
        // 3.1、文本格式链接
        setLinkColor(COLOR_FF0000FF) // 链接文本颜色
        setLinkBackGroupColor(COLOR_FFFFFFFF) // 链接背景颜色
        // 3.2、圆形图片格式链接
        setLinkCircleImageBackGroupColor(COLOR_FFFFFFFF) // 圆形图片链接主题背景颜色
        setLinkCircleImageButtonBackGroupColor(COLOR_FF000000) // 圆形图片链接控件背景颜色
        setLinkCircleImageTextColor(COLOR_FFFFFFFF) // 圆形图片链接文字颜色
        setLinkCircleImageBackGroupColor(COLOR_FFFFFFFF) // 圆形链接主题背景颜色
        // 3.3、圆角矩形图片格式链接
        setLinkRectImageBackGroupColor(COLOR_FFFFFFFF) // 圆角矩形图片链接主题背景颜色
        setLinkRectImageButtonBackGroupColor(COLOR_FF000000) // 圆角矩形图片链接控件背景颜色
        setLinkRectImageTextColor(COLOR_FFFFFFFF) // 圆角矩形图片链接文字颜色
        // 3.4、空心圆角矩形图片格式链接
        setLinkRectToolImageBackGroupColor(COLOR_FFFFFFFF) // 空心圆角矩形图片链接主题背景颜色
        setLinkRectToolImageButtonBackGroupColor(COLOR_FFFFFFFF) // 空心圆角矩形图片链接控件背景颜色
        setLinkRectToolImageButtonBorderColor(COLOR_FF000000) // 空心圆角矩形图片链接控件边框颜色
        setLinkRectToolImageButtonDividingLineColor(COLOR_FF000000) // 空心圆角矩形图片链接控件分割线颜色
        setLinkRectToolImageTextColor(COLOR_FF000000) // 空心圆角矩形图片链接文字颜色

        // 4、列表
        // 4.1、块引用
        setBlockQuoteColor(COLOR_FF191919) // 块引用左边线条颜色
        setBlockQuoteBackGroupColor(COLOR_FFFFFFFF) // 块引用背景颜色
        // 4.2、有序列表
        setOrderedListItemColor(COLOR_FF191919) // 有序列表列表项的颜色
        // 4.1、无序列表
        setBulletListItemColor(COLOR_FF191919) // 无序列表列表项的颜色

        // 5、代码
        // 5.1、内联代码
        setCodeTextColor(COLOR_FF000000) // 文本、图片格式内联代码文本颜色
        setCodeBackgroundColor(COLOR_FF191919) // 文本、图片格式内联代码背景颜色
        // 5.2、代码块
        // 5.3、组合代码
        setCodeListTitleSelectTextColor(Color.RED) // 组合代码选中标题文本颜色
        setCodeListTitleUnSelectTextColor(Color.BLACK) // 组合代码未选中标题文本颜色
        setCodeListTitleSelectBackGroupColor(Color.GRAY) // 组合代码选中标题背景颜色
        setCodeListTitleUnSelectBackGroupColor(Color.TRANSPARENT) // 组合代码未选中标题背景颜色
        // 5.4、单独代码块

        // 6、标题
        setHeadingBreakColor(COLOR_FF191919) // H1、H2标题下分割线颜色
        setHeadingTextColor(COLOR_FF191919) // 标题文本颜色

        // 7、段落
        setParagraphTextColor(COLOR_FF191919) // 段落文本颜色

        // 8、分割线
        setThematicBreakColor(COLOR_FF191919) // 分割线颜色

        // 9、软换行

        // 10、数学公式
        setLatexMathBackGroupColor(COLOR_FFFFFFFF) // 数学公式背景色
        setLatexMathTextColor(COLOR_FF000000) // 数学公式文本颜色

        // 11、音频
        setAudioShadowColor(COLOR_1A000000) // 音频阴影颜色值
        setAudioBorderColor(COLOR_33000000) // 音频边框颜色
        setAudioButtonBackgroundColor(Color.BLACK) // 音频按钮背景颜色
        setAudioButtonTextColor(Color.WHITE) // 音频按钮文字颜色
        setAudioTitleTextColor(Color.BLACK) // 音频标题文字颜色
        setAudioTypeTextColor(COLOR_80000000) // 音频类型文字颜色

        // 12、视频
        setVideoTimeTextColor(Color.WHITE) // 视频时间文本颜色

        // 13、图片banner

        // 14、图片

        // 15、表格
        setTableBorderColor(COLOR_FF000000) // 表格边框颜色
        setTableOddRowBackgroundColor(COLOR_FFFFFFFF) // 表格奇数行背景色
        setTableEvenRowBackgroundColor(COLOR_FFE0E0E0) // 表格偶数行背景色
        setTableHeaderRowBackgroundColor(COLOR_FFFFFFFF) // 表格头背景色

        // 16、代码高亮
        setPrismTheme(PrismThemeDarkula.create()) // markdown代码高亮样式

        return this
    }

    /**
     * 设置深色主题整体样式
     *
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setDarkulaTheme(): MarkdownAIThemeBuilder {
        // 1、上下文

        // 2、模块间距

        // 3、链接
        // 3.1、文本格式链接
        setLinkColor(COLOR_FF0000FF) // 链接文本颜色
        setLinkBackGroupColor(COLOR_FFFFFFFF) // 链接背景颜色
        // 3.2、圆形图片格式链接
        setLinkCircleImageBackGroupColor(COLOR_FFFFFFFF) // 圆形图片链接主题背景颜色
        setLinkCircleImageButtonBackGroupColor(COLOR_FF000000) // 圆形图片链接控件背景颜色
        setLinkCircleImageTextColor(COLOR_FFFFFFFF) // 圆形图片链接文字颜色
        setLinkCircleImageBackGroupColor(COLOR_FFFFFFFF) // 圆形链接主题背景颜色
        // 3.3、圆角矩形图片格式链接
        setLinkRectImageBackGroupColor(COLOR_FFFFFFFF) // 圆角矩形图片链接主题背景颜色
        setLinkRectImageButtonBackGroupColor(COLOR_FF000000) // 圆角矩形图片链接控件背景颜色
        setLinkRectImageTextColor(COLOR_FFFFFFFF) // 圆角矩形图片链接文字颜色
        // 3.4、空心圆角矩形图片格式链接
        setLinkRectToolImageBackGroupColor(COLOR_FFFFFFFF) // 空心圆角矩形图片链接主题背景颜色
        setLinkRectToolImageButtonBackGroupColor(COLOR_FFFFFFFF) // 空心圆角矩形图片链接控件背景颜色
        setLinkRectToolImageButtonBorderColor(COLOR_FF000000) // 空心圆角矩形图片链接控件边框颜色
        setLinkRectToolImageButtonDividingLineColor(COLOR_FF000000) // 空心圆角矩形图片链接控件分割线颜色
        setLinkRectToolImageTextColor(COLOR_FF000000) // 空心圆角矩形图片链接文字颜色

        // 4、列表
        // 4.1、块引用
        setBlockQuoteColor(COLOR_FF191919) // 块引用左边线条颜色
        setBlockQuoteBackGroupColor(COLOR_FFFFFFFF) // 块引用背景颜色
        // 4.2、有序列表
        setOrderedListItemColor(COLOR_FF191919) // 有序列表列表项的颜色
        // 4.1、无序列表
        setBulletListItemColor(COLOR_FF191919) // 无序列表列表项的颜色

        // 5、代码
        // 5.1、内联代码
        setCodeTextColor(COLOR_FF000000) // 文本、图片格式内联代码文本颜色
        setCodeBackgroundColor(COLOR_FF191919) // 文本、图片格式内联代码背景颜色
        // 5.2、代码块
        // 5.3、组合代码
        setCodeListTitleSelectTextColor(Color.RED) // 组合代码选中标题文本颜色
        setCodeListTitleUnSelectTextColor(Color.BLACK) // 组合代码未选中标题文本颜色
        setCodeListTitleSelectBackGroupColor(Color.GRAY) // 组合代码选中标题背景颜色
        setCodeListTitleUnSelectBackGroupColor(Color.TRANSPARENT) // 组合代码未选中标题背景颜色
        // 5.4、单独代码块

        // 6、标题
        setHeadingBreakColor(COLOR_FF191919) // H1、H2标题下分割线颜色
        setHeadingTextColor(COLOR_FF191919) // 标题文本颜色

        // 7、段落
        setParagraphTextColor(COLOR_FF191919) // 段落文本颜色

        // 8、分割线
        setThematicBreakColor(COLOR_FF191919) // 分割线颜色

        // 9、软换行

        // 10、数学公式
        setLatexMathBackGroupColor(COLOR_FFFFFFFF) // 数学公式背景色
        setLatexMathTextColor(COLOR_FF000000) // 数学公式文本颜色

        // 11、音频
        setAudioShadowColor(COLOR_1A000000) // 音频阴影颜色值
        setAudioBorderColor(COLOR_33000000) // 音频边框颜色
        setAudioButtonBackgroundColor(Color.BLACK) // 音频按钮背景颜色
        setAudioButtonTextColor(Color.WHITE) // 音频按钮文字颜色
        setAudioTitleTextColor(Color.BLACK) // 音频标题文字颜色
        setAudioTypeTextColor(COLOR_80000000) // 音频类型文字颜色

        // 12、视频
        setVideoTimeTextColor(Color.WHITE) // 视频时间文本颜色

        // 13、图片banner

        // 14、图片

        // 15、表格
        setTableBorderColor(COLOR_FF000000) // 表格边框颜色
        setTableOddRowBackgroundColor(COLOR_FFFFFFFF) // 表格奇数行背景色
        setTableEvenRowBackgroundColor(COLOR_FFE0E0E0) // 表格偶数行背景色
        setTableHeaderRowBackgroundColor(COLOR_FFFFFFFF) // 表格头背景色

        // 16、代码高亮
        setPrismTheme(PrismThemeDarkula.create()) // markdown代码高亮样式

        return this
    }

    /**
     * 设置markdown上下文 - 互操作
     *
     * @param stageContext markdown上下文 - 默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setStageContext(stageContext: StageContext): MarkdownAIThemeBuilder {
        this.stageContext = stageContext
        return this
    }

    /**
     * 设置markdown上下文 - 仓颉
     *
     * @param abilityContext markdown上下文 - 默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAbilityContext(abilityContext: AbilityContext): MarkdownAIThemeBuilder {
        this.abilityContext = abilityContext
        return this
    }

    /**
     * 设置模块间上下间距
     *
     * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockTopAndBottomMargins(blockTopAndBottomMargins: Float64): MarkdownAIThemeBuilder {
        this.blockTopAndBottomMargins = blockTopAndBottomMargins
        return this
    }

    /**
     * 设置链接是否是图片显示
     *
     * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsLinkStyle(isLinkStyle: Bool): MarkdownAIThemeBuilder {
        this.isLinkStyle = isLinkStyle
        return this
    }

    /**
     * 设置列表中的单行链接是否是图片显示
     *
     * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true：图片显示；false：文本显示。默认false
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsListLinkStyle(isListLinkStyle: Bool): MarkdownAIThemeBuilder {
        this.isListLinkStyle = isListLinkStyle
        return this
    }

    /**
     * 设置文本格式链接文本颜色
     *
     * @param linkColor 文本格式链接文本颜色 - 默认0XFF0000FF
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkColor(linkColor: Color): MarkdownAIThemeBuilder {
        this.linkColor = linkColor
        return this
    }

    /**
     * 设置是否按照链接文本自己大小显示文本
     *
     * @param isLinkSize 是否按照链接文本自己大小显示文本 - true：显示链接自己文本大小；false：跟随标题段落大小显示。默认true
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsLinkSize(isLinkSize: Bool): MarkdownAIThemeBuilder {
        this.isLinkSize = isLinkSize
        return this
    }

    /**
     * 设置文本格式链接文字大小
     *
     * @param linkSize 文本格式链接文字大小 - 默认14.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkSize(linkSize: Float64): MarkdownAIThemeBuilder {
        this.linkSize = linkSize
        return this
    }

    /**
     * 设置文本格式链接背景颜色
     *
     * @param linkBackGroupColor 文本格式链接背景颜色 - 默认Color.TRANSPARENT
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkBackGroupColor(linkBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.linkBackGroupColor = linkBackGroupColor
        return this
    }

    /**
     * 设置文本格式是否显示链接下划线
     *
     * @param isLinkUnderlined 文本格式是否显示链接下划线 - true：显示下划线；false：不显示下划线。默认true
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsLinkUnderlined(isLinkUnderlined: Bool): MarkdownAIThemeBuilder {
        this.isLinkUnderlined = isLinkUnderlined
        return this
    }

    /**
     * 设置圆形图片格式链接主题背景颜色
     *
     * @param linkCircleImageBackGroupColor 圆形图片格式链接主题背景颜色 - 默认0XFFFFFFFF
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkCircleImageBackGroupColor(linkCircleImageBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.linkCircleImageBackGroupColor = linkCircleImageBackGroupColor
        return this
    }

    /**
     * 设置圆形图片格式链接控件背景颜色
     *
     * @param linkCircleImageButtonBackGroupColor 圆形图片格式链接控件背景颜色 - 默认0XFF000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkCircleImageButtonBackGroupColor(linkCircleImageButtonBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.linkCircleImageButtonBackGroupColor = linkCircleImageButtonBackGroupColor
        return this
    }

    /**
     * 设置圆形图片格式链接文字大小
     *
     * @param linkCircleImageTextSize 圆形图片格式链接文字大小 - 默认14.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkCircleImageTextSize(linkCircleImageTextSize: Float64): MarkdownAIThemeBuilder {
        this.linkCircleImageTextSize = fp2px(linkCircleImageTextSize.fp).getOrThrow().value
        return this
    }

    /**
     * 设置圆形图片格式链接文字颜色
     *
     * @param linkCircleImageTextColor 圆形图片格式链接文字颜色 - 默认0XFFFFFFFF
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkCircleImageTextColor(linkCircleImageTextColor: Color): MarkdownAIThemeBuilder {
        this.linkCircleImageTextColor = linkCircleImageTextColor
        return this
    }

    /**
     * 设置圆形图片格式链接半径
     *
     * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkCircleImageRadius(linkCircleImageRadius: Float64): MarkdownAIThemeBuilder {
        this.linkCircleImageRadius = vp2px(linkCircleImageRadius.vp).getOrThrow().value
        return this
    }

    /**
     * 设置圆形图片格式链接左右外边距
     *
     * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkCircleImageMargin(linkCircleImageMargin: Float64): MarkdownAIThemeBuilder {
        this.linkCircleImageMargin = linkCircleImageMargin
        return this
    }

    /**
     * 设置圆角矩形图片格式链接主题背景颜色
     *
     * @param linkRectImageBackGroupColor 圆角矩形图片格式链接主题背景颜色 - 默认0XFFFFFFFF
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImageBackGroupColor(linkRectImageBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.linkRectImageBackGroupColor = linkRectImageBackGroupColor
        return this
    }

    /**
     * 设置圆角矩形图片格式链接控件背景颜色
     *
     * @param linkRectImageButtonBackGroupColor 圆角矩形图片格式链接控件背景颜色 - 默认0XFF000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImageButtonBackGroupColor(linkRectImageButtonBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.linkRectImageButtonBackGroupColor = linkRectImageButtonBackGroupColor
        return this
    }

    /**
     * 圆角矩形图片格式链接文字大小
     *
     * @param linkRectImageTextSize 圆角矩形图片格式链接文字大小 - 默认14.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImageTextSize(linkRectImageTextSize: Float64): MarkdownAIThemeBuilder {
        this.linkRectImageTextSize = fp2px(linkRectImageTextSize.fp).getOrThrow().value
        return this
    }

    /**
     * 设置圆角矩形图片格式链接文字颜色
     *
     * @param linkRectImageTextColor 圆角矩形图片格式链接文字颜色 - 默认0XFFFFFFFF
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImageTextColor(linkRectImageTextColor: Color): MarkdownAIThemeBuilder {
        this.linkRectImageTextColor = linkRectImageTextColor
        return this
    }

    /**
     * 圆角矩形图片格式链接控件高度
     *
     * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImageHeight(linkRectImageHeight: Float64): MarkdownAIThemeBuilder {
        this.linkRectImageHeight = vp2px(linkRectImageHeight.vp).getOrThrow().value
        return this
    }

    /**
     * 圆角矩形图片格式链接左右内边距
     *
     * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImagePadding(linkRectImagePadding: Float64): MarkdownAIThemeBuilder {
        this.linkRectImagePadding = vp2px(linkRectImagePadding.vp).getOrThrow().value
        return this
    }

    /**
     * 圆角矩形图片格式链接圆角半径
     *
     * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImageRadius(linkRectImageRadius: Float64): MarkdownAIThemeBuilder {
        this.linkRectImageRadius = vp2px(linkRectImageRadius.vp).getOrThrow().value
        return this
    }

    /**
     * 圆角矩形图片格式链接左右外边距
     *
     * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectImageMargin(linkRectImageMargin: Float64): MarkdownAIThemeBuilder {
        this.linkRectImageMargin = linkRectImageMargin
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接主题背景颜色
     *
     * @param linkRectToolImageBackGroupColor 空心圆角矩形图片格式链接主题背景颜色 - 默认OXFFFFFFFF
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageBackGroupColor(linkRectToolImageBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.linkRectToolImageBackGroupColor = linkRectToolImageBackGroupColor
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接控件背景颜色
     *
     * @param linkRectToolImageButtonBackGroupColor 空心圆角矩形图片格式链接控件背景颜色 - 默认OXFFFFFFFF
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageButtonBackGroupColor(linkRectToolImageButtonBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.linkRectToolImageButtonBackGroupColor = linkRectToolImageButtonBackGroupColor
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接控件边框颜色
     *
     * @param linkRectToolImageButtonBorderColor 空心圆角矩形图片格式链接控件边框颜色 - 默认OXFF000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageButtonBorderColor(linkRectToolImageButtonBorderColor: Color): MarkdownAIThemeBuilder {
        this.linkRectToolImageButtonBorderColor = linkRectToolImageButtonBorderColor
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接控件分割线颜色
     *
     * @param linkRectToolImageButtonDividingLineColor 空心圆角矩形图片格式链接控件分割线颜色 - 默认OXFF000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageButtonDividingLineColor(linkRectToolImageButtonDividingLineColor: Color): MarkdownAIThemeBuilder {
        this.linkRectToolImageButtonDividingLineColor = linkRectToolImageButtonDividingLineColor
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接文字大小
     *
     * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文字大小 - 默认14.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageTextSize(linkRectToolImageTextSize: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImageTextSize = fp2px(linkRectToolImageTextSize.fp).getOrThrow().value
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接文字颜色
     *
     * @param linkRectToolImageTextColor 空心圆角矩形图片格式链接文字颜色 - 默认OXFF000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageTextColor(linkRectToolImageTextColor: Color): MarkdownAIThemeBuilder {
        this.linkRectToolImageTextColor = linkRectToolImageTextColor
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接控件高度
     *
     * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageHeight(linkRectToolImageHeight: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImageHeight = vp2px(linkRectToolImageHeight.vp).getOrThrow().value
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接左右内边距
     *
     * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImagePadding(linkRectToolImagePadding: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImagePadding = vp2px(linkRectToolImagePadding.vp).getOrThrow().value
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接边框宽度
     *
     * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImageBorderWidth = vp2px(linkRectToolImageBorderWidth.vp).getOrThrow().value
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接分割线宽度
     *
     * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImageDividingLineWidth = vp2px(linkRectToolImageDividingLineWidth.vp).getOrThrow().value
        return this
    }

    /**
     * 设置空心圆角矩形图片格式链接左右外边距
     *
     * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageMargin(linkRectToolImageMargin: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImageMargin = linkRectToolImageMargin
        return this
    }

    /**
     * 设置空心圆角矩形图片格式分割线和文本左边距
     *
     * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImageLineLeftPadding = vp2px(linkRectToolImageLineLeftPadding.vp).getOrThrow().value
        return this
    }

    /**
     * 设置空心圆角矩形图片格式分割线和文本右边距
     *
     * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: Float64): MarkdownAIThemeBuilder {
        this.linkRectToolImageLineRightPadding = vp2px(linkRectToolImageLineRightPadding.vp).getOrThrow().value
        return this
    }

    /**
     * 设置块引用左边距
     *
     * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockQuoteLeftMargin(blockQuoteLeftMargin: Float64): MarkdownAIThemeBuilder {
        this.blockQuoteLeftMargin = blockQuoteLeftMargin
        return this
    }

    /**
     * 设置块引用右边距
     *
     * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockQuoteRightMargin(blockQuoteRightMargin: Float64): MarkdownAIThemeBuilder {
        this.blockQuoteRightMargin = blockQuoteRightMargin
        return this
    }

    /**
     * 设置块引用左边线条宽度
     *
     * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockQuoteWidth(blockQuoteWidth: Float64): MarkdownAIThemeBuilder {
        this.blockQuoteWidth = blockQuoteWidth
        return this
    }

    /**
     * 设置块引用左边线条颜色
     *
     * @param blockQuoteColor 块引用左边线条颜色 - 默认0XFF191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockQuoteColor(blockQuoteColor: Color): MarkdownAIThemeBuilder {
        this.blockQuoteColor = blockQuoteColor
        return this
    }

    /**
     * 设置块引用背景颜色
     *
     * @param blockQuoteBackGroupColor 块引用背景颜色 - 默认0XFFFFFFFF
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockQuoteBackGroupColor(blockQuoteBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.blockQuoteBackGroupColor = blockQuoteBackGroupColor
        return this
    }

    /**
     * 设置块引用子模块上下间距
     *
     * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: Float64): MarkdownAIThemeBuilder {
        this.blockQuoteTopAndBottomMargins = blockQuoteTopAndBottomMargins
        return this
    }

    /**
     * 设置有序列表、无序列表、任务列表子模块上下间距
     *
     * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: Float64): MarkdownAIThemeBuilder {
        this.blockOrderedAndBulletTopAndBottomMargins = blockOrderedAndBulletTopAndBottomMargins
        return this
    }

    /**
     * 设置有序列表、无序列表、任务列表左边距
     *
     * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockLeftMargin(blockLeftMargin: Float64): MarkdownAIThemeBuilder {
        this.blockLeftMargin = blockLeftMargin
        return this
    }

    /**
     * 设置有序列表、无序列表、任务列表右边距
     *
     * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockRightMargin(blockRightMargin: Float64): MarkdownAIThemeBuilder {
        this.blockRightMargin = blockRightMargin
        return this
    }

    /**
     * 设置有序列表前缀文本是否加粗
     *
     * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true：加粗；false：不加粗。默认false
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setOrderedListItemPrefixBold(orderedListItemPrefixBold: Bool): MarkdownAIThemeBuilder {
        this.orderedListItemPrefixBold = orderedListItemPrefixBold
        return this
    }

    /**
     * 设置有序列表前缀文本颜色
     *
     * @param orderedListItemColor 有序列表前缀文本颜色 - 默认OXFF191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setOrderedListItemColor(orderedListItemColor: Color): MarkdownAIThemeBuilder {
        this.orderedListItemColor = orderedListItemColor
        return this
    }

    /**
     * 设置有序列表前缀文本大小
     *
     * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setOrderedListItemSize(orderedListItemSize: Float64): MarkdownAIThemeBuilder {
        this.orderedListItemSize = orderedListItemSize
        return this
    }

    /**
     * 设置有序列表前缀文本行高
     *
     * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setOrderedListItemLineHeight(orderedListItemLineHeight: Float64): MarkdownAIThemeBuilder {
        this.orderedListItemLineHeight = orderedListItemLineHeight
        return this
    }

    /**
     * 设置无序列表前缀文本颜色
     *
     * @param bulletListItemColor 无序列表前缀文本颜色 - 默认OXFF191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBulletListItemColor(bulletListItemColor: Color): MarkdownAIThemeBuilder {
        this.bulletListItemColor = bulletListItemColor
        return this
    }

    /**
     * 设置无序列表前缀文本大小
     *
     * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBulletListItemSize(bulletListItemSize: Float64): MarkdownAIThemeBuilder {
        this.bulletListItemSize = bulletListItemSize
        return this
    }

    /**
     * 设置无序列表前缀文本行高
     *
     * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBulletListItemLineHeight(bulletListItemLineHeight: Float64): MarkdownAIThemeBuilder {
        this.bulletListItemLineHeight = bulletListItemLineHeight
        return this
    }

    /**
     * 设置任务列表选择框宽高
     *
     * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setTaskListItemLength(taskListItemLength: Float64): MarkdownAIThemeBuilder {
        this.taskListItemLength = taskListItemLength
        return this
    }

    /**
     * 设置内联代码是否是图片显示
     *
     * @param isCodeStyle 内联代码是否是图片显示 - true：图片化显示；false：不图片化显示。默认false
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsCodeStyle(isCodeStyle: Bool): MarkdownAIThemeBuilder {
        this.isCodeStyle = isCodeStyle
        return this
    }

    /**
     * 设置文本、图片格式内联代码文本颜色
     *
     * @param codeTextColor 文本、图片格式内联代码文本颜色 - 默认OXFF000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeTextColor(codeTextColor: Color): MarkdownAIThemeBuilder {
        this.codeTextColor = codeTextColor
        return this
    }

    /**
     * 设置文本、图片格式内联代码背景颜色
     *
     * @param codeBackgroundColor 文本、图片格式内联代码背景颜色 - 默认OXFF191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBackgroundColor(codeBackgroundColor: Color): MarkdownAIThemeBuilder {
        this.codeBackgroundColor = codeBackgroundColor
        return this
    }

    /**
     * 设置文本、图片格式内联代码文本大小
     *
     * @param codeTextSize 文本、图片格式内联代码文本大小 - 默认13.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeTextSize(codeTextSize: Float64): MarkdownAIThemeBuilder {
        this.codeTextSize = fp2px(codeTextSize.fp)().value
        return this
    }

    /**
     * 设置文本格式内联代码文本字体
     *
     * @param codeTypeface 文本格式内联代码文本字体 - 默认"HarmonyOS Sans"
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeTypeface(codeTypeface: String): MarkdownAIThemeBuilder {
        this.codeTypeface = codeTypeface
        return this
    }

    /**
     * 设置图片格式内联代码文本左右边距
     *
     * @param codeLeftAndRightPadding 图片格式内联代码文本左右边距 - 默认4.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeLeftAndRightPadding(codeLeftAndRightPadding: Float64): MarkdownAIThemeBuilder {
        this.codeLeftAndRightPadding = vp2px(codeLeftAndRightPadding.vp)().value
        return this
    }

    /**
     * 设置图片格式内联代码文本高度
     *
     * @param codeHeight 图片格式内联代码文本高度 - 默认20.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeHeight(codeHeight: Float64): MarkdownAIThemeBuilder {
        this.codeHeight = vp2px(codeHeight.vp)().value
        return this
    }

    /**
     * 设置代码块代码文本颜色
     *
     * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockTextColor(codeBlockTextColor: Color): MarkdownAIThemeBuilder {
        this.codeBlockTextColor = codeBlockTextColor
        return this
    }

    /**
     * 设置代码块代码类型文本颜色
     *
     * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockTypeTextColor(codeBlockTypeTextColor: Color): MarkdownAIThemeBuilder {
        this.codeBlockTypeTextColor = codeBlockTypeTextColor
        return this
    }

    /**
     * 设置代码块代码类型默认文本
     *
     * @param codeBlockTypeTextStr 代码块代码类型默认文本 - 默认""
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockTypeTextStr(codeBlockTypeTextStr: String): MarkdownAIThemeBuilder {
        this.codeBlockTypeTextStr = codeBlockTypeTextStr
        return this
    }

    /**
     * 设置代码类型和代码块距离
     *
     * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: Float64): MarkdownAIThemeBuilder {
        this.codeBlockTypeTextPadding = codeBlockTypeTextPadding
        return this
    }

    /**
     * 设置代码块复制、全屏图片文字是否显示
     *
     * @param codeBlockIconTextHide 代码块复制、全屏图片文字是否显示 - true：显示；false：不显示。默认true
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockIconTextHide(codeBlockIconTextHide: Bool): MarkdownAIThemeBuilder {
        this.codeBlockIconTextHide = codeBlockIconTextHide
        return this
    }

    /**
     * 设置代码块代码行号是否显示
     *
     * @param codeBlockLineNumberHide 代码块代码行号是否显示 - true：显示；false：不显示。默认true
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockLineNumberHide(codeBlockLineNumberHide: Bool): MarkdownAIThemeBuilder {
        this.codeBlockLineNumberHide = codeBlockLineNumberHide
        return this
    }

    /**
     * 设置代码块背景颜色
     *
     * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockBackgroundColor(codeBlockBackgroundColor: Color): MarkdownAIThemeBuilder {
        this.codeBlockBackgroundColor = codeBlockBackgroundColor
        return this
    }

    /**
     * 设置代码块左边距
     *
     * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeMultilineMargin(codeMultilineMargin: Float64): MarkdownAIThemeBuilder {
        this.codeMultilineMargin = codeMultilineMargin
        return this
    }

    /**
     * 设置代码块字体
     *
     * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockTypeface(codeBlockTypeface: String): MarkdownAIThemeBuilder {
        this.codeBlockTypeface = codeBlockTypeface
        return this
    }

    /**
     * 设置代码块代码文本大小
     *
     * @param codeBlockTextSize 代码块代码文本大小 -  默认13.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockTextSize(codeBlockTextSize: Float64): MarkdownAIThemeBuilder {
        this.codeBlockTextSize = codeBlockTextSize
        return this
    }

    /**
     * 设置代码块代码文本行高
     *
     * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockLineHeight(codeBlockLineHeight: Float64): MarkdownAIThemeBuilder {
        this.codeBlockLineHeight = codeBlockLineHeight
        return this
    }

    /**
     * 设置代码块控件圆角大小
     *
     * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeBlockRadius(codeBlockRadius: Float64): MarkdownAIThemeBuilder {
        this.codeBlockRadius = codeBlockRadius
        return this
    }

    /**
     * 设置代码块代码全屏按钮是否显示
     *
     * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true：显示；false：不显示。默认true
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsCodeFullScreen(isCodeFullScreen: Bool): MarkdownAIThemeBuilder {
        this.isCodeFullScreen = isCodeFullScreen
        return this
    }

    /**
     * 设置代码块代码全屏、代码复制按钮宽高
     *
     * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIconWidthAndHeight(iconWidthAndHeight: Float64): MarkdownAIThemeBuilder {
        this.iconWidthAndHeight = iconWidthAndHeight
        return this
    }

    /**
     * 设置代码块代码全屏按钮默认图标
     *
     * @param codeFullScreenIcon 代码块代码全屏按钮默认图标 - 默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeFullScreenIcon(codeFullScreenIcon: CJResource): MarkdownAIThemeBuilder {
        this.codeFullScreenIcon = codeFullScreenIcon
        return this
    }

    /**
     * 设置代码块代码复制按钮默认图标
     *
     * @param codeCopyIcon 代码块代码复制按钮默认图标 - 默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeCopyIcon(codeCopyIcon: CJResource): MarkdownAIThemeBuilder {
        this.codeCopyIcon = codeCopyIcon
        return this
    }

    /**
     * 设置组合代码未选中标题字体大小
     *
     * @param codeListTitleTextSize 组合代码未选中标题字体大小 - 默认13.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleTextSize(codeListTitleTextSize: Float64): MarkdownAIThemeBuilder {
        this.codeListTitleTextSize = codeListTitleTextSize
        return this
    }

    /**
     * 设置组合代码选中标题字体大小
     *
     * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: Float64): MarkdownAIThemeBuilder {
        this.codeListTitleSelectTextSize = codeListTitleSelectTextSize
        return this
    }

    /**
     * 设置组合代码选中标题文本颜色
     *
     * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认Color.RED
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: Color): MarkdownAIThemeBuilder {
        this.codeListTitleSelectTextColor = codeListTitleSelectTextColor
        return this
    }

    /**
     * 设置组合代码未选中标题文本颜色
     *
     * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认Color.BLACK
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: Color): MarkdownAIThemeBuilder {
        this.codeListTitleUnSelectTextColor = codeListTitleUnSelectTextColor
        return this
    }

    /**
     * 设置组合代码选中标题背景颜色
     *
     * @param codeListTitleSelectBackGroupColor 组合代码选中标题背景颜色 - 默认Color.GRAY
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleSelectBackGroupColor(codeListTitleSelectBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.codeListTitleSelectBackGroupColor = codeListTitleSelectBackGroupColor
        return this
    }

    /**
     * 设置组合代码未选中标题背景颜色
     *
     * @param codeListTitleUnSelectBackGroupColor 组合代码未选中标题背景颜色 - 默认Color.TRANSPARENT
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setCodeListTitleUnSelectBackGroupColor(codeListTitleUnSelectBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.codeListTitleUnSelectBackGroupColor = codeListTitleUnSelectBackGroupColor
        return this
    }

    /**
     * 设置是否单独代码块显示
     *
     * @param isSeparateCodeBlock 是否单独代码块显示 - true：显示；false：不显示。默认false
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsSeparateCodeBlock(isSeparateCodeBlock: Bool): MarkdownAIThemeBuilder {
        this.isSeparateCodeBlock = isSeparateCodeBlock
        return this
    }

    /**
     * 设置单独代码块行号宽度
     *
     * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setSeparateCodeBlockWidth(separateCodeBlockWidth: Float64): MarkdownAIThemeBuilder {
        this.separateCodeBlockWidth = separateCodeBlockWidth
        return this
    }

    /**
     * 设置H1、H2标题下分割线高度
     *
     * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingBreakHeight(headingBreakHeight: Float64): MarkdownAIThemeBuilder {
        this.headingBreakHeight = headingBreakHeight
        return this
    }

    /**
     * 设置H1、H2标题下分割线颜色
     *
     * @param headingBreakColor H1、H2标题下分割线颜色 - 默认0XFF191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingBreakColor(headingBreakColor: Color): MarkdownAIThemeBuilder {
        this.headingBreakColor = headingBreakColor
        return this
    }

    /**
     * 设置标题文本字体
     *
     * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTypeface(headingTypeface: String): MarkdownAIThemeBuilder {
        this.headingTypeface = headingTypeface
        return this
    }

    /**
     * 设置标题文本大小数组
     *
     * @param headingTextSizeMultipliers 标题文本大小数组 - 默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<Float64>): MarkdownAIThemeBuilder {
        this.headingTextSizeMultipliers = headingTextSizeMultipliers
        return this
    }

    /**
     * 设置标题文本颜色
     *
     * @param headingTextColor 标题文本颜色 - 默认0XFF191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextColor(headingTextColor: Color): MarkdownAIThemeBuilder {
        this.headingTextColor = headingTextColor
        return this
    }

    /**
     * 设置标题文本字间距
     *
     * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextWordSpace(headingTextWordSpace: Float64): MarkdownAIThemeBuilder {
        this.headingTextWordSpace = headingTextWordSpace
        return this
    }

    /**
     * 设置一级标题文本行高
     *
     * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextLineHeight1(headingTextLineHeight1: Float64): MarkdownAIThemeBuilder {
        this.headingTextLineHeight1 = headingTextLineHeight1
        return this
    }

    /**
     * 设置二级标题文本行高
     *
     * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextLineHeight2(headingTextLineHeight2: Float64): MarkdownAIThemeBuilder {
        this.headingTextLineHeight2 = headingTextLineHeight2
        return this
    }

    /**
     * 设置三级标题文本行高
     *
     * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextLineHeight3(headingTextLineHeight3: Float64): MarkdownAIThemeBuilder {
        this.headingTextLineHeight3 = headingTextLineHeight3
        return this
    }

    /**
     * 设置四级标题文本行高
     *
     * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextLineHeight4(headingTextLineHeight4: Float64): MarkdownAIThemeBuilder {
        this.headingTextLineHeight4 = headingTextLineHeight4
        return this
    }

    /**
     * 设置五级标题文本行高
     *
     * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextLineHeight5(headingTextLineHeight5: Float64): MarkdownAIThemeBuilder {
        this.headingTextLineHeight5 = headingTextLineHeight5
        return this
    }

    /**
     * 设置六级标题文本行高
     *
     * @param headingTextLineHeight1 六级标题文本行高 - 默认22.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setHeadingTextLineHeight6(headingTextLineHeight6: Float64): MarkdownAIThemeBuilder {
        this.headingTextLineHeight6 = headingTextLineHeight6
        return this
    }

    /**
     * 设置段落文本大小
     *
     * @param paragraphTextSize 段落文本大小 - 默认14.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setParagraphTextSize(paragraphTextSize: Float64): MarkdownAIThemeBuilder {
        this.paragraphTextSize = paragraphTextSize
        return this
    }

    /**
     * 设置段落文本颜色
     *
     * @param paragraphTextColor 段落文本颜色 - 默认0XFF191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setParagraphTextColor(paragraphTextColor: Color): MarkdownAIThemeBuilder {
        this.paragraphTextColor = paragraphTextColor
        return this
    }

    /**
     * 设置段落文本字间距
     *
     * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setParagraphTextWordSpace(paragraphTextWordSpace: Float64): MarkdownAIThemeBuilder {
        this.paragraphTextWordSpace = paragraphTextWordSpace
        return this
    }

    /**
     * 设置段落文本行高
     *
     * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setParagraphTextLineHeight(paragraphTextLineHeight: Float64): MarkdownAIThemeBuilder {
        this.paragraphTextLineHeight = paragraphTextLineHeight
        return this
    }

    /**
     * 设置段落文本字体
     *
     * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setParagraphTypeface(paragraphTypeface: String): MarkdownAIThemeBuilder {
        this.paragraphTypeface = paragraphTypeface
        return this
    }

    /**
     * 设置分割线颜色
     *
     * @param thematicBreakColor 分割线颜色 - 默认0XFF191919
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setThematicBreakColor(thematicBreakColor: Color): MarkdownAIThemeBuilder {
        this.thematicBreakColor = thematicBreakColor
        return this
    }

    /**
     * 设置分割线高度
     *
     * @param thematicBreakHeight 分割线高度 - 默认0.5vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setThematicBreakHeight(thematicBreakHeight: Float64): MarkdownAIThemeBuilder {
        this.thematicBreakHeight = thematicBreakHeight
        return this
    }

    /**
     * 设置分割线上部外边距
     *
     * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setThematicBreakTopMargin(thematicBreakTopMargin: Float64): MarkdownAIThemeBuilder {
        this.thematicBreakTopMargin = thematicBreakTopMargin
        return this
    }

    /**
     * 设置分割线下部外边距
     *
     * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setThematicBreakBottomMargin(thematicBreakBottomMargin: Float64): MarkdownAIThemeBuilder {
        this.thematicBreakBottomMargin = thematicBreakBottomMargin
        return this
    }

    /**
     * 设置软换行是否换行
     *
     * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsLineBreak(isLineBreak: Bool): MarkdownAIThemeBuilder {
        this.isLineBreak = isLineBreak
        return this
    }

    /**
     * 设置数学公式文本大小
     *
     * @param latexMathTextSize 数学公式文本大小 - 默认16.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathTextSize(latexMathTextSize: Float64): MarkdownAIThemeBuilder {
        this.latexMathTextSize = fp2px(latexMathTextSize.fp)().value
        return this
    }

    /**
     * 设置数学公式文本行距
     *
     * @param latexMathTextLineSpacing 数学公式文本行距 - 默认10.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathTextLineSpacing(latexMathTextLineSpacing: Float64): MarkdownAIThemeBuilder {
        this.latexMathTextLineSpacing = latexMathTextLineSpacing
        return this
    }

    /**
     * 设置数学公式背景色
     *
     * @param latexMathBackGroupColor 数学公式背景色 - 默认0xFFFFFFFF
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathBackGroupColor(latexMathBackGroupColor: Color): MarkdownAIThemeBuilder {
        this.latexMathBackGroupColor = latexMathBackGroupColor
        return this
    }

    /**
     * 设置数学公式文本颜色
     *
     * @param latexMathTextColor 数学公式文本颜色 - 默认0xFF000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathTextColor(latexMathTextColor: Color): MarkdownAIThemeBuilder {
        this.latexMathTextColor = latexMathTextColor
        return this
    }

    /**
     * 设置数学公式生成图片格式
     *
     * @param latexMathColorFormat 数学公式生成图片格式 - 默认LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): MarkdownAIThemeBuilder {
        this.latexMathColorFormat = latexMathColorFormat
        return this
    }

    /**
     * 设置块结构的数学公式是否居中
     *
     * @param latexMathBlockCenter 块结构的数学公式是否居中 - true：居中；false：不居中。默认false
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathBlockCenter(latexMathBlockCenter: Bool): MarkdownAIThemeBuilder {
        this.latexMathBlockCenter = latexMathBlockCenter
        return this
    }

    /**
     * 设置数学公式字体路径
     *
     * @param latexMathResStr 数学公式字体路径 默认 "/data/storage/el1/bundle/entry/resources/resfile/res"
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setLatexMathResStr(latexMathResStr: String): MarkdownAIThemeBuilder {
        this.latexMathResStr = latexMathResStr
        return this
    }

    /**
     * 设置音频图标
     *
     * @param audioIcon 音频图标 - 默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioIcon(audioIcon: CJResource): MarkdownAIThemeBuilder {
        this.audioIcon = audioIcon
        return this
    }

    /**
     * 设置音频阴影颜色值
     *
     * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioShadowColor(audioShadowColor: Color): MarkdownAIThemeBuilder {
        this.audioShadowColor = audioShadowColor
        return this
    }

    /**
     * 设置音频边框颜色
     *
     * @param audioBorderColor 音频边框颜色 - 默认0x33000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioBorderColor(audioBorderColor: Color): MarkdownAIThemeBuilder {
        this.audioBorderColor = audioBorderColor
        return this
    }

    /**
     * 设置音频边框粗细
     *
     * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioBorderWidth(audioBorderWidth: Float64): MarkdownAIThemeBuilder {
        this.audioBorderWidth = audioBorderWidth
        return this
    }

    /**
     * 设置音频边框圆角
     *
     * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioBorderRadius(audioBorderRadius: Float64): MarkdownAIThemeBuilder {
        this.audioBorderRadius = audioBorderRadius
        return this
    }

    /**
     * 设置音频按钮背景颜色
     *
     * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认Color.BLACK
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioButtonBackgroundColor(audioButtonBackgroundColor: Color): MarkdownAIThemeBuilder {
        this.audioButtonBackgroundColor = audioButtonBackgroundColor
        return this
    }

    /**
     * 设置音频按钮文字颜色
     *
     * @param audioButtonTextColor 音频按钮文字颜色 - 默认Color.WHITE
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioButtonTextColor(audioButtonTextColor: Color): MarkdownAIThemeBuilder {
        this.audioButtonTextColor = audioButtonTextColor
        return this
    }

    /**
     * 设置音频按钮文字大小
     *
     * @param audioButtonTextSize 音频按钮文字大小 - 默认14.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioButtonTextSize(audioButtonTextSize: Float64): MarkdownAIThemeBuilder {
        this.audioButtonTextSize = audioButtonTextSize
        return this
    }

    /**
     * 设置音频按钮文字内容
     *
     * @param audioButtonText 音频按钮文字内容 - 默认"立即播放"
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioButtonText(audioButtonText: String): MarkdownAIThemeBuilder {
        this.audioButtonText = audioButtonText
        return this
    }

    /**
     * 设置音频按钮圆角
     *
     * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioButtonBorderRadius(audioButtonBorderRadius: Float64): MarkdownAIThemeBuilder {
        this.audioButtonBorderRadius = audioButtonBorderRadius
        return this
    }

    /**
     * 设置音频标题文字大小
     *
     * @param audioTitleTextSize 音频标题文字大小 - 默认15.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioTitleTextSize(audioTitleTextSize: Float64): MarkdownAIThemeBuilder {
        this.audioTitleTextSize = audioTitleTextSize
        return this
    }

    /**
     * 设置音频标题文字颜色
     *
     * @param audioTitleTextColor音频标题文字颜色 - 默认Color.BLACK
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioTitleTextColor(audioTitleTextColor: Color): MarkdownAIThemeBuilder {
        this.audioTitleTextColor = audioTitleTextColor
        return this
    }

    /**
     * 设置音频标题文字行高
     *
     * @param audioTitleTextLineHeight 音频标题文字行高 - 默认20.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioTitleTextLineHeight(audioTitleTextLineHeight: Float64): MarkdownAIThemeBuilder {
        this.audioTitleTextLineHeight = audioTitleTextLineHeight
        return this
    }

    /**
     * 设置音频类型文字大小
     *
     * @param audioTypeTextSize 音频类型文字大小 - 默认11.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioTypeTextSize(audioTypeTextSize: Float64): MarkdownAIThemeBuilder {
        this.audioTypeTextSize = audioTypeTextSize
        return this
    }

    /**
     * 设置音频类型文字颜色
     *
     * @param audioTypeTextColor 音频类型文字颜色 - 默认0X80000000
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioTypeTextColor(audioTypeTextColor: Color): MarkdownAIThemeBuilder {
        this.audioTypeTextColor = audioTypeTextColor
        return this
    }

    /**
     * 设置音频类型文字行高
     *
     * @param audioTypeTextLineHeight 音频类型文字行高 - 默认15.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioTypeTextLineHeight(audioTypeTextLineHeight: Float64): MarkdownAIThemeBuilder {
        this.audioTypeTextLineHeight = audioTypeTextLineHeight
        return this
    }

    /**
     * 设置音频上边距
     *
     * @param audioMarginTop 音频上边距 - 默认10.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioMarginTop(audioMarginTop: Float64): MarkdownAIThemeBuilder {
        this.audioMarginTop = audioMarginTop
        return this
    }

    /**
     * 设置音频下边距
     *
     * @param audioMarginBottom 音频下边距 - 默认10.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setAudioMarginBottom(audioMarginBottom: Float64): MarkdownAIThemeBuilder {
        this.audioMarginBottom = audioMarginBottom
        return this
    }

    /**
     * 设置视频默认占位图
     *
     * @param videoImage 视频默认占位图 - 默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setVideoImage(videoImage: CJResource): MarkdownAIThemeBuilder {
        this.videoImage = videoImage
        return this
    }

    /**
     * 设置视频播放按钮默认图标
     *
     * @param playCircleFillIcon 视频播放按钮默认图标 - 默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setPlayCircleFillIcon(playCircleFillIcon: CJResource): MarkdownAIThemeBuilder {
        this.playCircleFillIcon = playCircleFillIcon
        return this
    }

    /**
     * 设置视频圆角
     *
     * @param videoBorderRadius 视频圆角 - 默认10.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setVideoBorderRadius(videoBorderRadius: Float64): MarkdownAIThemeBuilder {
        this.videoBorderRadius = videoBorderRadius
        return this
    }

    /**
     * 设置视频时间文本颜色
     *
     * @param videoTimeTextColor 视频时间文本颜色 - 默认Color.WHITE
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setVideoTimeTextColor(videoTimeTextColor: Color): MarkdownAIThemeBuilder {
        this.videoTimeTextColor = videoTimeTextColor
        return this
    }

    /**
     * 设置视频时间文本大小
     *
     * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setVideoTimeTextSize(videoTimeTextSize: Float64): MarkdownAIThemeBuilder {
        this.videoTimeTextSize = videoTimeTextSize
        return this
    }

    /**
     * 设置视频时间文本居右边距
     *
     * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setVideoTimeTextMarginRight(videoTimeTextMarginRight: Float64): MarkdownAIThemeBuilder {
        this.videoTimeTextMarginRight = videoTimeTextMarginRight
        return this
    }

    /**
     * 设置视频时间文本居底边距
     *
     * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: Float64): MarkdownAIThemeBuilder {
        this.videoTimeTextMarginBottom = videoTimeTextMarginBottom
        return this
    }

    /**
     * 设置视频上边距
     *
     * @param videoMarginTop 视频上边距 - 默认10.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setVideoMarginTop(videoMarginTop: Float64): MarkdownAIThemeBuilder {
        this.videoMarginTop = videoMarginTop
        return this
    }

    /**
     * 设置视频下边距
     *
     * @param videoMarginBottom 视频下边距 - 默认10.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setVideoMarginBottom(videoMarginBottom: Float64): MarkdownAIThemeBuilder {
        this.videoMarginBottom = videoMarginBottom
        return this
    }

    /**
     * 设置图片banner默认占位图
     *
     * @param bannerImage 图片banner占位图 - 默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBannerImage(bannerImage: CJResource): MarkdownAIThemeBuilder {
        this.bannerImage = bannerImage
        return this
    }

    /**
     * 设置图片文字是否需要图文混排
     *
     * @param isWord 图片文字是否需要图文混排 - true:图文混排；false:不图文混排。默认true
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsWord(isWord: Bool): MarkdownAIThemeBuilder {
        this.isWord = isWord
        return this
    }

    /**
     * 设置图片默认占位图 - CJResource
     *
     * @param imageResource 图片默认占位图 - CJResource - 默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setImageResource(imageResource: CJResource): MarkdownAIThemeBuilder {
        this.imageResource = imageResource
        return this
    }

    /**
     * 设置图片默认占位图 - String
     *
     * @param imagePlaceholder 图片默认占位图 - String - 默认None
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setImagePlaceholder(imagePlaceholder: String): MarkdownAIThemeBuilder {
        this.imagePlaceholder = imagePlaceholder
        return this
    }

    /**
     * 设置网络图片是否压缩
     *
     * @param isAutoResize 网络图片是否压缩 - true：压缩；false：不压缩。默认true
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setIsAutoResize(isAutoResize: Bool): MarkdownAIThemeBuilder {
        this.isAutoResize = isAutoResize
        return this
    }

    /**
     * 设置图片上边距
     *
     * @param imageMarginTop 图片上边距 - 默认10.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setImageMarginTop(imageMarginTop: Float64): MarkdownAIThemeBuilder {
        this.imageMarginTop = imageMarginTop
        return this
    }

    /**
     * 设置图片下边距
     *
     * @param imageMarginBottom 图片下边距 - 默认10.0vp
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setImageMarginBottom(imageMarginBottom: Float64): MarkdownAIThemeBuilder {
        this.imageMarginBottom = imageMarginBottom
        return this
    }

    /**
     * 设置图片边距 - TODO:已废弃，控件自动计算宽度
     *
     * @param imageMarginBottom 图片边距
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setImagePadding(imagePadding: Int64): MarkdownAIThemeBuilder {
        return this
    }

    /**
     * 设置表格内容内边距
     *
     * @param tableCellPadding 表格内容内边距 - 默认4.0vp
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setTableCellPadding(tableCellPadding: Float64): MarkdownAIThemeBuilder {
        this.tableCellPadding = tableCellPadding
        return this
    }

    /**
     * 设置表格边框颜色
     *
     * @param tableBorderColor 表格边框颜色 - 默认0XFF000000
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setTableBorderColor(tableBorderColor: Color): MarkdownAIThemeBuilder {
        this.tableBorderColor = tableBorderColor
        return this
    }

    /**
     * 设置表格边框宽度
     *
     * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setTableBorderWidth(tableBorderWidth: Float64): MarkdownAIThemeBuilder {
        this.tableBorderWidth = tableBorderWidth
        return this
    }

    /**
     * 设置表格奇数行背景色
     *
     * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0XFFFFFFFF
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setTableOddRowBackgroundColor(tableOddRowBackgroundColor: Color): MarkdownAIThemeBuilder {
        this.tableOddRowBackgroundColor = tableOddRowBackgroundColor
        return this
    }

    /**
     * 设置表格偶数行背景色
     *
     * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0XFFE0E0E0
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: Color): MarkdownAIThemeBuilder {
        this.tableEvenRowBackgroundColor = tableEvenRowBackgroundColor
        return this
    }

    /**
     * 设置表格头背景色
     *
     * @param tableHeaderRowBackgroundColor 表格头背景色 - 默认0XFFFFFFFF
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: Color): MarkdownAIThemeBuilder {
        this.tableHeaderRowBackgroundColor = tableHeaderRowBackgroundColor
        return this
    }

    /**
     * 设置表格文本行高
     *
     * @param tableTextLineHeight 表格文本行高 - 默认22.0vp
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setTableTextLineHeight(tableTextLineHeight: Float64): MarkdownAIThemeBuilder {
        this.tableTextLineHeight = tableTextLineHeight
        return this
    }

    /**
     * 设置表格圆角
     *
     * @param tableRadius 表格圆角 - 默认5.0vp
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setTableRadius(tableRadius: Float64): MarkdownAIThemeBuilder {
        this.tableRadius = tableRadius
        return this
    }

    /**
     * 设置表格最小宽度
     *
     * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setTableMinTextWidth(tableMinTextWidth: Float64): MarkdownAIThemeBuilder {
        this.tableMinTextWidth = tableMinTextWidth
        return this
    }

    /**
     * 设置表格最大宽度
     *
     * @param tableMaxTextWidth 表格最大宽度- 默认300.0vp
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setTableMaxTextWidth(tableMaxTextWidth: Float64): MarkdownAIThemeBuilder {
        this.tableMaxTextWidth = tableMaxTextWidth
        return this
    }

    /**
     * 设置表格第一列是否加粗
     *
     * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
     * @return MarkdownAIConfigurationBuilder MarkdownAIConfigurationBuilder对象
     */
    public func setTableFirstColumnBold(tableFirstColumnBold: Bool): MarkdownAIThemeBuilder {
        this.tableFirstColumnBold = tableFirstColumnBold
        return this
    }

    /**
     * 设置markdown代码高亮样式
     *
     * @param PrismTheme markdown代码高亮样式 - 默认PrismThemeDarkula.create()
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
