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
import ohos.ability.*
import std.collection.*
import markdown.components.*
import ohos.resource_manager.AppResource

@Interop[ArkTS]
public class CJMarkdownTheme {
    /**
     * 是否打开长按复制粘贴
     */
    var isOnCopy: ?Bool = None

    /**
     * markdown第一个模块上边距
     */
    var blockFirstTopMargin: ?Float64 = None

    /**
     * markdown最后一个模块下边距
     */
    var blockLastBottomMargin: ?Float64 = None

    /**
     * 模块间上下间距
     */
    var blockTopAndBottomMargins: ?Float64 = None

    /**
     * 链接是否是图片显示
     */
    var isLinkStyle: ?Bool = None

    /**
     * 列表中的单行链接是否是图片显示
     */
    var isListLinkStyle: ?Bool = None

    /**
     * 文本格式链接文本颜色
     */
    var linkColor: ?Color = None

    /**
     * 是否按照链接文字字体大小显示文本
     */
    var isLinkSize: ?Bool = None

    /**
     * 文本格式链接文字大小
     */
    var linkSize: ?Float64 = None

    /**
     * 文本格式链接背景颜色
     */
    var linkBackGroupColor: ?Color = None

    /**
     * 文本格式是否显示链接下划线
     */
    var isLinkUnderlined: ?Bool = None

    /**
     * 圆形图片格式链接主题背景颜色
     */
    var linkCircleImageBackGroupColor: ?Color = None

    /**
     * 圆形图片格式链接控件背景颜色
     */
    var linkCircleImageButtonBackGroupColor: ?Color = None

    /**
     * 圆形图片格式链接文字大小
     */
    var linkCircleImageTextSize: ?Float64 = None

    /**
     * 圆形图片格式链接文字颜色
     */
    var linkCircleImageTextColor: ?Color = None

    /**
     * 圆形图片格式链接半径
     */
    var linkCircleImageRadius: ?Float64 = None

    /**
     * 圆形图片格式链接左右外边距
     */
    var linkCircleImageMargin: ?Float64 = None

    /**
     * 圆角矩形图片格式链接主题背景颜色
     */
    var linkRectImageBackGroupColor: ?Color = None

    /**
     * 圆角矩形图片格式链接控件背景颜色
     */
    var linkRectImageButtonBackGroupColor: ?Color = None

    /**
     * 圆角矩形图片格式链接文字大小
     */
    var linkRectImageTextSize: ?Float64 = None

    /**
     * 圆角矩形图片格式链接文字颜色
     */
    var linkRectImageTextColor: ?Color = None

    /**
     * 圆角矩形图片格式链接控件高度
     */
    var linkRectImageHeight: ?Float64 = None

    /**
     * 圆角矩形图片格式链接左右内边距
     */
    var linkRectImagePadding: ?Float64 = None

    /**
     * 圆角矩形图片格式链接圆角半径
     */
    var linkRectImageRadius: ?Float64 = None

    /**
     * 圆角矩形图片格式链接左右外边距
     */
    var linkRectImageMargin: ?Float64 = None

    /**
     * 空心圆角矩形图片格式链接主题背景颜色
     */
    var linkRectToolImageBackGroupColor: ?Color = None

    /**
     * 空心圆角矩形图片格式链接控件背景颜色
     */
    var linkRectToolImageButtonBackGroupColor: ?Color = None

    /**
     * 空心圆角矩形图片格式链接文字大小
     */
    var linkRectToolImageTextSize: ?Float64 = None

    /**
     * 空心圆角矩形图片格式链接控件高度
     */
    var linkRectToolImageHeight: ?Float64 = None

    /**
     * 空心圆角矩形图片格式链接左右内边距
     */
    var linkRectToolImagePadding: ?Float64 = None

    /**
     * 空心圆角矩形图片格式链接边框宽度
     */
    var linkRectToolImageBorderWidth: ?Float64 = None

    /**
     * 空心圆角矩形图片格式链接分割线宽度
     */
    var linkRectToolImageDividingLineWidth: ?Float64 = None

    /**
     * 空心圆角矩形图片格式链接左右外边距
     */
    var linkRectToolImageMargin: ?Float64 = None

    /**
     * 空心圆角矩形图片格式分割线和文本左边距
     */
    var linkRectToolImageLineLeftPadding: ?Float64 = None

    /**
     * 空心圆角矩形图片格式分割线和文本右边距
     */
    var linkRectToolImageLineRightPadding: ?Float64 = None

    /**
     * 块引用左边距
     */
    var blockQuoteLeftMargin: ?Float64 = None

    /**
     * 块引用右边距
     */
    var blockQuoteRightMargin: ?Float64 = None

    /**
     * 块引用左边线条宽度
     */
    var blockQuoteWidth: ?Float64 = None

    /**
     * 块引用左边线条颜色
     */
    var blockQuoteColor: ?Color = None

    /**
     * 块引用背景颜色
     */
    var blockQuoteBackGroupColor: ?Color = None

    /**
     * 块引用子模块上下间距
     */
    var blockQuoteTopAndBottomMargins: ?Float64 = None

    /**
     * 有序列表、无序列表、任务列表子模块上下间距
     */
    var blockOrderedAndBulletTopAndBottomMargins: ?Float64 = None

    /**
     * 有序列表、无序列表、任务列表左边距
     */
    var blockLeftMargin: ?Float64 = None

    /**
     * 有序列表、无序列表、任务列表右边距
     */
    var blockRightMargin: ?Float64 = None

    /**
     * 有序列表前缀文本是否加粗
     */
    var orderedListItemPrefixBold: ?Bool = None

    /**
     * 有序列表前缀文本颜色
     */
    var orderedListItemColor: ?Color = None

    /**
     * 有序列表前缀文本大小
     */
    var orderedListItemSize: ?Float64 = None

    /**
     * 有序列表前缀文本行高
     */
    var orderedListItemLineHeight: ?Float64 = None

    /**
     * 无序列表前缀是否全部是实心圆型
     */
    var bulletListItemCircle: ?Bool = None

    /**
     * 无序列表前缀文本颜色
     */
    var bulletListItemColor: ?Color = None

    /**
     * 无序列表前缀文本大小
     */
    var bulletListItemSize: ?Float64 = None

    /**
     * 无序列表前缀文本行高
     */
    var bulletListItemLineHeight: ?Float64 = None

    /**
     * 任务列表选择框宽高
     */
    var taskListItemLength: ?Float64 = None

    /**
     * 内联代码是否是图片显示
     */
    var isCodeStyle: ?Bool = None

    /**
     * 文本、图片格式内联代码文本颜色
     */
    var codeTextColor: ?Color = None

    /**
     * 文本、图片格式内联代码背景颜色
     */
    var codeBackgroundColor: ?Color = None

    /**
     * 文本、图片格式内联代码文本大小
     */
    var codeTextSize: ?Float64 = None

    /**
     * 文本格式内联代码文本字体
     */
    var codeTypeface: ?String = None

    /**
     * 图片格式内联代码文本左右边距
     */
    var codeLeftAndRightPadding: ?Float64 = None

    /**
     * 图片格式内联代码文本高度
     */
    var codeHeight: ?Float64 = None

    /**
     * 代码块代码文本颜色
     */
    var codeBlockTextColor: ?Color = None

    /**
     * 代码块代码类型文本颜色
     */
    var codeBlockTypeTextColor: ?Color = None

    /**
     * 代码块代码类型文本
     */
     var codeBlockTypeTextStr: ?String = None

    /**
     * 代码类型和代码块距离
     */
     var codeBlockTypeTextPadding: ?Float64 = None

    /**
     * 代码块复制、全屏图片文字是否显示
     */
    var codeBlockIconTextHide: ?Bool = None

    /**
     * 代码块代码行号是否显示
     */
    var codeBlockLineNumberHide: ?Bool = None

    /**
     * 代码块背景颜色
     */
    var codeBlockBackgroundColor: ?Color = None

    /**
     * 代码块左边距
     */
    var codeMultilineMargin: ?Float64 = None

    /**
     * 代码块字体
     */
    var codeBlockTypeface: ?String = None

    /**
     * 代码块代码文本大小
     */
    var codeBlockTextSize: ?Float64 = None

    /**
     * 代码块代码文本行高
     */
    var codeBlockLineHeight: ?Float64 = None

    /**
     * 代码块控件圆角大小
     */
    var codeBlockRadius: ?Float64 = None

    /**
     * 代码块代码全屏按钮是否显示
     */
    var isCodeFullScreen: ?Bool = None

    /**
     * 代码块代码全屏、代码复制按钮宽高
     */
    var iconWidthAndHeight: ?Float64 = None

    /**
     * 组合代码未选中标题字体大小
     */
    var codeListTitleTextSize: ?Float64 = None

    /**
     * 组合代码选中标题字体大小
     */
    var codeListTitleSelectTextSize: ?Float64 = None

    /**
     * 组合代码选中标题文本颜色
     */
    var codeListTitleSelectTextColor: ?Color = None

    /**
     * 组合代码未选中标题文本颜色
     */
    var codeListTitleUnSelectTextColor: ?Color = None

    /**
     * 组合代码选中标题背景颜色
     */
    var codeListTitleSelectBackGroupColor: ?Color = None

    /**
     * 组合代码未选中标题背景颜色
     */
    var codeListTitleUnSelectBackGroupColor: ?Color = None

    /**
     * 是否单独代码块显示
     */
    var isSeparateCodeBlock: ?Bool = None

    /**
     * 单独代码块行号宽度
     */
    var separateCodeBlockWidth: ?Float64 = None

    /**
     * 单独代码块是否居底显示
     */
    var separateCodeIsBottom: ?Bool = None

    /**
     * H1、H2标题下分割线高度
     */
    var headingBreakHeight: ?Float64 = None

    /**
     * H1、H2标题下分割线颜色
     */
    var headingBreakColor: ?Color = None

    /**
     * 标题文本字体
     */
    var headingTypeface: ?String = None

    /**
     * 标题模块上间距
     */
    var headingTopMargins: ?Float64 = None

    /**
     * 标题模块下间距
     */
    var headingBottomMargins: ?Float64 = None

    /**
     * 标题文本大小数组
     */
    var headingTextSizeMultipliers: ?Array<Float64> = None

    /**
     * 标题文本颜色
     */
    var headingTextColor: ?Color = None

    /**
     * 标题文本字间距
     */
    var headingTextWordSpace: ?Float64 = None

    /**
     * 一级标题文本行高
     */
    var headingTextLineHeight1: ?Float64 = None

    /**
     * 二级标题文本行高
     */
    var headingTextLineHeight2: ?Float64 = None

    /**
     * 三级标题文本行高
     */
    var headingTextLineHeight3: ?Float64 = None

    /**
     * 四级标题文本行高
     */
    var headingTextLineHeight4: ?Float64 = None

    /**
     * 五级标题文本行高
     */
    var headingTextLineHeight5: ?Float64 = None

    /**
     * 六级标题文本行高
     */
    var headingTextLineHeight6: ?Float64 = None

    /**
     * 段落模块上间距
     */
    var paragraphTopMargins: ?Float64 = None

    /**
     * 段落模块下间距
     */
    var paragraphBottomMargins: ?Float64 = None

    /**
     * 段落文本大小
     */
    var paragraphTextSize: ?Float64 = None

    /**
     * 段落文本颜色
     */
    var paragraphTextColor: ?Color = None

    /**
     * 段落文本字间距
     */
    var paragraphTextWordSpace: ?Float64 = None

    /**
     * 段落文本行高
     */
    var paragraphTextLineHeight: ?Float64 = None

    /**
     * 段落文本字体
     */
    var paragraphTypeface: ?String = None

    /**
     * 分割线颜色
     */
    var thematicBreakColor: ?Color = None

    /**
     * 分割线高度
     */
    var thematicBreakHeight: ?Float64 = None

    /**
     * 分割线上部外边距
     */
    var thematicBreakTopMargin: ?Float64 = None

    /**
     * 分割线下部外边距
     */
    var thematicBreakBottomMargin: ?Float64 = None

    /**
     * 软换行是否换行
     */
    var isLineBreak: ?Bool = None

    /**
     * 数学公式未加载状态是否显示文字
     */
    var latexDefaultText: ?Bool = None

    /**
     * 数学公式文本大小
     */
    var latexMathTextSize: ?Float64 = None

    /**
     * 数学公式背景色
     */
    var latexMathBackGroupColor: ?Color = None

    /**
     * 数学公式文本颜色
     */
    var latexMathTextColor: ?Color = None

    /**
     * 数学公式生成图片格式
     */
    var latexMathColorFormat: ?LatexMathColorFormat = None

    /**
     * 块结构的数学公式是否居中
     */
    var latexMathBlockCenter: ?Bool = None

    /**
     * 数学公式字体路径
     */
    var latexMathResStr: ?String = None

    /**
     * 音频阴影颜色值
     */
    var audioShadowColor: ?Color = None

    /**
     * 音频边框颜色
     */
    var audioBorderColor: ?Color = None

    /**
     * 音频边框粗细
     */
    var audioBorderWidth: ?Float64 = None

    /**
     * 音频边框圆角
     */
    var audioBorderRadius: ?Float64 = None

    /**
     * 音频按钮背景颜色
     */
    var audioButtonBackgroundColor: ?Color = None

    /**
     * 音频按钮文字颜色
     */
    var audioButtonTextColor: ?Color = None

    /**
     * 音频按钮文字大小
     */
    var audioButtonTextSize: ?Float64 = None

    /**
     * 音频按钮文字内容
     */
    var audioButtonText: ?String = None

    /**
     * 音频按钮圆角
     */
    var audioButtonBorderRadius: ?Float64 = None

    /**
     * 音频标题文字大小
     */
    var audioTitleTextSize: ?Float64 = None

    /**
     * 音频标题文字颜色
     */
    var audioTitleTextColor: ?Color = None

    /**
     * 音频标题文字行高
     */
    var audioTitleTextLineHeight: ?Float64 = None

    /**
     * 音频类型文字大小
     */
    var audioTypeTextSize: ?Float64 = None

    /**
     * 音频类型文字颜色
     */
    var audioTypeTextColor: ?Color = None

    /**
     * 音频类型文字行高
     */
    var audioTypeTextLineHeight: ?Float64 = None

    /**
     * 音频上边距
     */
    var audioMarginTop: ?Float64 = None

    /**
     * 音频下边距
     */
    var audioMarginBottom: ?Float64 = None

    /**
     * 视频圆角
     */
    var videoBorderRadius: ?Float64 = None

    /**
     * 视频时间文本颜色
     */
    var videoTimeTextColor: ?Color = None

    /**
     * 视频时间文本大小
     */
    var videoTimeTextSize: ?Float64 = None

    /**
     * 视频时间文本居右边距
     */
    var videoTimeTextMarginRight: ?Float64 = None

    /**
     * 视频时间文本居底边距
     */
    var videoTimeTextMarginBottom: ?Float64 = None

    /**
     * 视频上边距
     */
    var videoMarginTop: ?Float64 = None

    /**
     * 视频下边距
     */
    var videoMarginBottom: ?Float64 = None

    /**
     * 图片缩放类型
     */
    var imageFitType: ?ImageFit = Option<ImageFit>.None

    /**
     * 图片最大宽度百分比
     */
    var imageMaximumWidth: ?Float64 = None

    /**
     * 图片固定宽度百分比
     */
    var imageFixedRatioWidth: ?Float64 = None

    /**
     * 图片圆角大小
     */
    var imageBorderRadius: ?Float64 = None

    /**
     * 网络图片是否压缩
     */
    var isAutoResize: ?Bool = None

    /**
     * 图片上边距
     */
    var imageMarginTop: ?Float64 = None

    /**
     * 图片下边距
     */
    var imageMarginBottom: ?Float64 = None

    /**
     * 表格内容内边距
     */
    var tableCellPadding: ?Float64 = None

    /**
     * 表格边框颜色
     */
    var tableBorderColor: ?Color = None

    /**
     * 表格边框宽度
     */
    var tableBorderWidth: ?Float64 = None

    /**
     * 表格奇数行背景色
     */
    var tableOddRowBackgroundColor: ?Color = None

    /**
     * 表格偶数行背景色
     */
    var tableEvenRowBackgroundColor: ?Color = None

    /**
     * 表格头背景色
     */
    var tableHeaderRowBackgroundColor: ?Color = None

    /**
     * 表格文本行高
     */
    var tableTextLineHeight: ?Float64 = None

    /**
     * 表格圆角
     */
    var tableRadius: ?Float64 = None

    /**
     * 表格最小宽度
     */
    var tableMinTextWidth: ?Float64 = None

    /**
     * 表格最大宽度
     */
    var tableMaxTextWidth: ?Float64 = None

    /**
     * 表格第一列是否加粗
     */
    var tableFirstColumnBold: ?Bool = None

    /**
     * 代码深浅色模式
     */
    var isDark: ?Bool = None

    /**
     * 删除线颜色
     */
    var strikethroughColor: ?Color = None

    /**
     * 定义列表术语和定义行之间间距
     */
    var descListTermAndDefMargins: ?Float64 = None

    /**
     * 定义列表定义行缩进
     */
    var descListDefIndentation: ?Float64 = None

    /**
     * 定义列表定义行间距
     */
    var descListDefMargins: ?Float64 = None

    public init() {}

    /**
     * 设置是否打开长按复制粘贴
     *
     * @param isOnCopy 是否打开长按复制粘贴 - 默认true
     */
    public func setIsOnCopy(isOnCopy: Bool): Unit {
        this.isOnCopy = isOnCopy
    }

    /**
     * 设置markdown第一个模块上边距
     *
     * @param blockFirstTopMargin markdown第一个模块上边距 - 默认8.0vp
     */
    public func setBlockFirstTopMargin(blockFirstTopMargin: Float64): Unit {
        this.blockFirstTopMargin = blockFirstTopMargin
    }

    /**
     * 设置markdown最后一个模块下边距
     *
     * @param blockLastBottomMargin markdown最后一个模块下边距 - 默认8.0vp
     */
    public func setBlockLastBottomMargin(blockLastBottomMargin: Float64): Unit {
        this.blockLastBottomMargin = blockLastBottomMargin
    }

    /**
     * 设置模块间上下间距
     *
     * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
     */
    public func setBlockTopAndBottomMargins(blockTopAndBottomMargins: Float64): Unit {
        this.blockTopAndBottomMargins = blockTopAndBottomMargins
    }

    /**
     * 设置链接是否是图片显示
     *
     * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
     */
    public func setIsLinkStyle(isLinkStyle: Bool): Unit {
        this.isLinkStyle = isLinkStyle
    }

    /**
     * 设置列表中的单行链接是否是图片显示
     *
     * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true：图片显示；false：文本显示。默认false
     */
    public func setIsListLinkStyle(isListLinkStyle: Bool): Unit {
        this.isListLinkStyle = isListLinkStyle
    }

    /**
     * 设置文本格式链接文本颜色
     *
     * @param linkColor 文本格式链接文本颜色 - 默认0XFF0000FF
     */
    public func setLinkColor(linkColor: UInt32): Unit {
        this.linkColor = Color(linkColor)
    }

    /**
     * 设置是否按照链接文本自己大小显示文本
     *
     * @param isLinkSize 是否按照链接文本自己大小显示文本 - true：显示链接自己文本大小；false：跟随标题段落大小显示。默认true
     */
    public func setIsLinkSize(isLinkSize: Bool): Unit {
        this.isLinkSize = isLinkSize
    }

    /**
     * 设置文本格式链接文字大小
     *
     * @param linkSize 文本格式链接文字大小 - 默认14.0fp
     */
    public func setLinkSize(linkSize: Float64): Unit {
        this.linkSize = linkSize
    }

    /**
     * 设置文本格式链接背景颜色
     *
     * @param linkBackGroupColor 文本格式链接背景颜色 - 默认0XFF000000
     */
    public func setLinkBackGroupColor(linkBackGroupColor: UInt32): Unit {
        this.linkBackGroupColor = Color(linkBackGroupColor)
    }

    /**
     * 设置文本格式是否显示链接下划线
     *
     * @param isLinkUnderlined 文本格式是否显示链接下划线 - true：显示下划线；false：不显示下划线。默认true
     */
    public func setIsLinkUnderlined(isLinkUnderlined: Bool): Unit {
        this.isLinkUnderlined = isLinkUnderlined
    }

    /**
     * 设置圆形图片格式链接主题背景颜色
     *
     * @param linkCircleImageBackGroupColor 圆形图片格式链接主题背景颜色 - 默认0XFFFFFFFF
     */
    public func setLinkCircleImageBackGroupColor(linkCircleImageBackGroupColor: UInt32): Unit {
        this.linkCircleImageBackGroupColor = Color(linkCircleImageBackGroupColor)
    }

    /**
     * 设置圆形图片格式链接控件背景颜色
     *
     * @param linkCircleImageButtonBackGroupColor 圆形图片格式链接控件背景颜色 - 默认0XFF000000
     */
    public func setLinkCircleImageButtonBackGroupColor(linkCircleImageButtonBackGroupColor: UInt32): Unit {
        this.linkCircleImageButtonBackGroupColor = Color(linkCircleImageButtonBackGroupColor)
    }

    /**
     * 设置圆形图片格式链接文字大小
     *
     * @param linkCircleImageTextSize 圆形图片格式链接文字大小 - 默认14.0fp
     */
    public func setLinkCircleImageTextSize(linkCircleImageTextSize: Float64): Unit {
        this.linkCircleImageTextSize = linkCircleImageTextSize
    }

    /**
     * 设置圆形图片格式链接文字颜色
     *
     * @param linkCircleImageTextColor 圆形图片格式链接文字颜色 - 默认0XFFFFFFFF
     */
    public func setLinkCircleImageTextColor(linkCircleImageTextColor: UInt32): Unit {
        this.linkCircleImageTextColor = Color(linkCircleImageTextColor)
    }

    /**
     * 设置圆形图片格式链接半径
     *
     * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
     */
    public func setLinkCircleImageRadius(linkCircleImageRadius: Float64): Unit {
        this.linkCircleImageRadius = linkCircleImageRadius
    }

    /**
     * 设置圆形图片格式链接左右外边距
     *
     * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
     */
    public func setLinkCircleImageMargin(linkCircleImageMargin: Float64): Unit {
        this.linkCircleImageMargin = linkCircleImageMargin
    }

    /**
     * 设置圆角矩形图片格式链接主题背景颜色
     *
     * @param linkRectImageBackGroupColor 圆角矩形图片格式链接主题背景颜色 - 默认0XFFFFFFFF
     */
    public func setLinkRectImageBackGroupColor(linkRectImageBackGroupColor: UInt32): Unit {
        this.linkRectImageBackGroupColor = Color(linkRectImageBackGroupColor)
    }

    /**
     * 设置圆角矩形图片格式链接控件背景颜色
     *
     * @param linkRectImageButtonBackGroupColor 圆角矩形图片格式链接控件背景颜色 - 默认0XFF000000
     */
    public func setLinkRectImageButtonBackGroupColor(linkRectImageButtonBackGroupColor: UInt32): Unit {
        this.linkRectImageButtonBackGroupColor = Color(linkRectImageButtonBackGroupColor)
    }

    /**
     * 圆角矩形图片格式链接文字大小
     *
     * @param linkRectImageTextSize 圆角矩形图片格式链接文字大小 - 默认14.0fp
     */
    public func setLinkRectImageTextSize(linkRectImageTextSize: Float64): Unit {
        this.linkRectImageTextSize = linkRectImageTextSize
    }

    /**
     * 设置圆角矩形图片格式链接文字颜色
     *
     * @param linkRectImageTextColor 圆角矩形图片格式链接文字颜色 - 默认0XFFFFFFFF
     */
    public func setLinkRectImageTextColor(linkRectImageTextColor: UInt32): Unit {
        this.linkRectImageTextColor = Color(linkRectImageTextColor)
    }

    /**
     * 圆角矩形图片格式链接控件高度
     *
     * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
     */
    public func setLinkRectImageHeight(linkRectImageHeight: Float64): Unit {
        this.linkRectImageHeight = linkRectImageHeight
    }

    /**
     * 圆角矩形图片格式链接左右内边距
     *
     * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
     */
    public func setLinkRectImagePadding(linkRectImagePadding: Float64): Unit {
        this.linkRectImagePadding = linkRectImagePadding
    }

    /**
     * 圆角矩形图片格式链接圆角半径
     *
     * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
     */
    public func setLinkRectImageRadius(linkRectImageRadius: Float64): Unit {
        this.linkRectImageRadius = linkRectImageRadius
    }

    /**
     * 圆角矩形图片格式链接左右外边距
     *
     * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
     */
    public func setLinkRectImageMargin(linkRectImageMargin: Float64): Unit {
        this.linkRectImageMargin = linkRectImageMargin
    }

    /**
     * 设置空心圆角矩形图片格式链接主题背景颜色
     *
     * @param linkRectToolImageBackGroupColor 空心圆角矩形图片格式链接主题背景颜色 - 默认OXFFFFFFFF
     */
    public func setLinkRectToolImageBackGroupColor(linkRectToolImageBackGroupColor: UInt32): Unit {
        this.linkRectToolImageBackGroupColor = Color(linkRectToolImageBackGroupColor)
    }

    /**
     * 设置空心圆角矩形图片格式链接控件背景颜色
     *
     * @param linkRectToolImageButtonBackGroupColor 空心圆角矩形图片格式链接控件背景颜色 - 默认OXFFFFFFFF
     */
    public func setLinkRectToolImageButtonBackGroupColor(linkRectToolImageButtonBackGroupColor: UInt32): Unit {
        this.linkRectToolImageButtonBackGroupColor = Color(linkRectToolImageButtonBackGroupColor)
    }

    /**
     * 设置空心圆角矩形图片格式链接文字大小
     *
     * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文字大小 - 默认14.0fp
     */
    public func setLinkRectToolImageTextSize(linkRectToolImageTextSize: Float64): Unit {
        this.linkRectToolImageTextSize = linkRectToolImageTextSize
    }

    /**
     * 设置空心圆角矩形图片格式链接控件高度
     *
     * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
     */
    public func setLinkRectToolImageHeight(linkRectToolImageHeight: Float64): Unit {
        this.linkRectToolImageHeight = linkRectToolImageHeight
    }

    /**
     * 设置空心圆角矩形图片格式链接左右内边距
     *
     * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
     */
    public func setLinkRectToolImagePadding(linkRectToolImagePadding: Float64): Unit {
        this.linkRectToolImagePadding = linkRectToolImagePadding
    }

    /**
     * 设置空心圆角矩形图片格式链接边框宽度
     *
     * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
     */
    public func setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: Float64): Unit {
        this.linkRectToolImageBorderWidth = linkRectToolImageBorderWidth
    }

    /**
     * 设置空心圆角矩形图片格式链接分割线宽度
     *
     * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
     */
    public func setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: Float64): Unit {
        this.linkRectToolImageDividingLineWidth = linkRectToolImageDividingLineWidth
    }

    /**
     * 设置空心圆角矩形图片格式链接左右外边距
     *
     * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
     */
    public func setLinkRectToolImageMargin(linkRectToolImageMargin: Float64): Unit {
        this.linkRectToolImageMargin = linkRectToolImageMargin
    }

    /**
     * 设置空心圆角矩形图片格式分割线和文本左边距
     *
     * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
     */
    public func setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: Float64): Unit {
        this.linkRectToolImageLineLeftPadding = linkRectToolImageLineLeftPadding
    }

    /**
     * 设置空心圆角矩形图片格式分割线和文本右边距
     *
     * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
     */
    public func setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: Float64): Unit {
        this.linkRectToolImageLineRightPadding = linkRectToolImageLineRightPadding
    }

    /**
     * 设置块引用左边距
     *
     * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
     */
    public func setBlockQuoteLeftMargin(blockQuoteLeftMargin: Float64): Unit {
        this.blockQuoteLeftMargin = blockQuoteLeftMargin
    }

    /**
     * 设置块引用右边距
     *
     * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
     */
    public func setBlockQuoteRightMargin(blockQuoteRightMargin: Float64): Unit {
        this.blockQuoteRightMargin = blockQuoteRightMargin
    }

    /**
     * 设置块引用左边线条宽度
     *
     * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
     */
    public func setBlockQuoteWidth(blockQuoteWidth: Float64): Unit {
        this.blockQuoteWidth = blockQuoteWidth
    }

    /**
     * 设置块引用左边线条颜色
     *
     * @param blockQuoteColor 块引用左边线条颜色 - 默认0XFF191919
     */
    public func setBlockQuoteColor(blockQuoteColor: UInt32): Unit {
        this.blockQuoteColor = Color(blockQuoteColor)
    }

    /**
     * 设置块引用背景颜色
     *
     * @param blockQuoteBackGroupColor 块引用背景颜色 - 默认0XFFFFFFFF
     */
    public func setBlockQuoteBackGroupColor(blockQuoteBackGroupColor: UInt32): Unit {
        this.blockQuoteBackGroupColor = Color(blockQuoteBackGroupColor)
    }

    /**
     * 设置块引用子模块上下间距
     *
     * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
     */
    public func setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: Float64): Unit {
        this.blockQuoteTopAndBottomMargins = blockQuoteTopAndBottomMargins
    }

    /**
     * 设置有序列表、无序列表、任务列表子模块上下间距
     *
     * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
     */
    public func setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: Float64): Unit {
        this.blockOrderedAndBulletTopAndBottomMargins = blockOrderedAndBulletTopAndBottomMargins
    }

    /**
     * 设置有序列表、无序列表、任务列表左边距
     *
     * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
     */
    public func setBlockLeftMargin(blockLeftMargin: Float64): Unit {
        this.blockLeftMargin = blockLeftMargin
    }

    /**
     * 设置有序列表、无序列表、任务列表右边距
     *
     * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
     */
    public func setBlockRightMargin(blockRightMargin: Float64): Unit {
        this.blockRightMargin = blockRightMargin
    }

    /**
     * 设置有序列表前缀文本是否加粗
     *
     * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true：加粗；false：不加粗。默认false
     */
    public func setOrderedListItemPrefixBold(orderedListItemPrefixBold: Bool): Unit {
        this.orderedListItemPrefixBold = orderedListItemPrefixBold
    }

    /**
     * 设置有序列表前缀文本颜色
     *
     * @param orderedListItemColor 有序列表前缀文本颜色 - 默认OXFF191919
     */
    public func setOrderedListItemColor(orderedListItemColor: UInt32): Unit {
        this.orderedListItemColor = Color(orderedListItemColor)
    }

    /**
     * 设置有序列表前缀文本大小
     *
     * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
     */
    public func setOrderedListItemSize(orderedListItemSize: Float64): Unit {
        this.orderedListItemSize = orderedListItemSize
    }

    /**
     * 设置有序列表前缀文本行高
     *
     * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
     */
    public func setOrderedListItemLineHeight(orderedListItemLineHeight: Float64): Unit {
        this.orderedListItemLineHeight = orderedListItemLineHeight
    }

    /**
     * 设置无序列表前缀是否全部是实心圆型
     *
     * @param bulletListItemCircle 无序列表前缀是否全部是实心圆型 - 默认false
     */
    public func setBulletListItemCircle(bulletListItemCircle: Bool): Unit {
        this.bulletListItemCircle = bulletListItemCircle
    }

    /**
     * 设置无序列表前缀文本颜色
     *
     * @param bulletListItemColor 无序列表前缀文本颜色 - 默认OXFF191919
     */
    public func setBulletListItemColor(bulletListItemColor: UInt32): Unit {
        this.bulletListItemColor = Color(bulletListItemColor)
    }

    /**
     * 设置无序列表前缀文本大小
     *
     * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
     */
    public func setBulletListItemSize(bulletListItemSize: Float64): Unit {
        this.bulletListItemSize = bulletListItemSize
    }

    /**
     * 设置无序列表前缀文本行高
     *
     * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
     */
    public func setBulletListItemLineHeight(bulletListItemLineHeight: Float64): Unit {
        this.bulletListItemLineHeight = bulletListItemLineHeight
    }

    /**
     * 设置任务列表选择框宽高
     *
     * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
     */
    public func setTaskListItemLength(taskListItemLength: Float64): Unit {
        this.taskListItemLength = taskListItemLength
    }

    /**
     * 设置内联代码是否是图片显示
     *
     * @param isCodeStyle 内联代码是否是图片显示 - true：图片化显示；false：不图片化显示。默认false
     */
    public func setIsCodeStyle(isCodeStyle: Bool): Unit {
        this.isCodeStyle = isCodeStyle
    }

    /**
     * 设置文本、图片格式内联代码文本颜色
     *
     * @param codeTextColor 文本、图片格式内联代码文本颜色 - 默认OXFF000000
     */
    public func setCodeTextColor(codeTextColor: UInt32): Unit {
        this.codeTextColor = Color(codeTextColor)
    }

    /**
     * 设置文本、图片格式内联代码背景颜色
     *
     * @param codeBackgroundColor 文本、图片格式内联代码背景颜色 - 默认OXFF191919
     */
    public func setCodeBackgroundColor(codeBackgroundColor: UInt32): Unit {
        this.codeBackgroundColor = Color(codeBackgroundColor)
    }

    /**
     * 设置文本、图片格式内联代码文本大小
     *
     * @param codeTextSize 文本、图片格式内联代码文本大小 - 默认13.0fp
     */
    public func setCodeTextSize(codeTextSize: Float64): Unit {
        this.codeTextSize = codeTextSize
    }

    /**
     * 设置文本格式内联代码文本字体
     *
     * @param codeTypeface 文本格式内联代码文本字体 - 默认"HarmonyOS Sans"
     */
    public func setCodeTypeface(codeTypeface: String): Unit {
        this.codeTypeface = codeTypeface
    }

    /**
     * 设置图片格式内联代码文本左右边距
     *
     * @param codeLeftAndRightPadding 图片格式内联代码文本左右边距 - 默认4.0vp
     */
    public func setCodeLeftAndRightPadding(codeLeftAndRightPadding: Float64): Unit {
        this.codeLeftAndRightPadding = codeLeftAndRightPadding
    }

    /**
     * 设置图片格式内联代码文本高度
     *
     * @param codeHeight 图片格式内联代码文本高度 - 默认20.0vp
     */
    public func setCodeHeight(codeHeight: Float64): Unit {
        this.codeHeight = codeHeight
    }

    /**
     * 设置代码块代码文本颜色
     *
     * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
     */
    public func setCodeBlockTextColor(codeBlockTextColor: UInt32): Unit {
        this.codeBlockTextColor = Color(codeBlockTextColor)
    }

    /**
     * 设置代码块代码类型文本颜色
     *
     * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
     */
    public func setCodeBlockTypeTextColor(codeBlockTypeTextColor: UInt32): Unit {
        this.codeBlockTypeTextColor = Color(codeBlockTypeTextColor)
    }

    /**
     * 设置代码块代码类型文本
     *
     * @param codeBlockTypeTextStr 代码块代码类型文本 - 默认""
     */
    public func setCodeBlockTypeTextStr(codeBlockTypeTextStr: String): Unit {
        this.codeBlockTypeTextStr = codeBlockTypeTextStr
    }

    /**
     * 设置代码类型和代码块距离
     *
     * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
     */
    public func setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: Float64): Unit {
        this.codeBlockTypeTextPadding = codeBlockTypeTextPadding
    }

    /**
     * 设置代码块复制、全屏图片文字是否显示
     *
     * @param codeBlockIconTextHide 代码块复制、全屏图片文字是否显示 - true：显示；false：不显示。默认true
     */
    public func setCodeBlockIconTextHide(codeBlockIconTextHide: Bool): Unit {
        this.codeBlockIconTextHide = codeBlockIconTextHide
    }

    /**
     * 设置代码块代码行号是否显示
     *
     * @param codeBlockLineNumberHide 代码块代码行号是否显示 - true：显示；false：不显示。默认true
     */
    public func setCodeBlockLineNumberHide(codeBlockLineNumberHide: Bool): Unit {
        this.codeBlockLineNumberHide = codeBlockLineNumberHide
    }

    /**
     * 设置代码块背景颜色
     *
     * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
     */
    public func setCodeBlockBackgroundColor(codeBlockBackgroundColor: UInt32): Unit {
        this.codeBlockBackgroundColor = Color(codeBlockBackgroundColor)
    }

    /**
     * 设置代码块左边距
     *
     * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
     */
    public func setCodeMultilineMargin(codeMultilineMargin: Float64): Unit {
        this.codeMultilineMargin = codeMultilineMargin
    }

    /**
     * 设置代码块字体
     *
     * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
     */
    public func setCodeBlockTypeface(codeBlockTypeface: String): Unit {
        this.codeBlockTypeface = codeBlockTypeface
    }

    /**
     * 设置代码块代码文本大小
     *
     * @param codeBlockTextSize 代码块代码文本大小 -  默认13.0fp
     */
    public func setCodeBlockTextSize(codeBlockTextSize: Float64): Unit {
        this.codeBlockTextSize = codeBlockTextSize
    }

    /**
     * 设置代码块代码文本行高
     *
     * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
     */
    public func setCodeBlockLineHeight(codeBlockLineHeight: Float64): Unit {
        this.codeBlockLineHeight = codeBlockLineHeight
    }

    /**
     * 设置代码块控件圆角大小
     *
     * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
     */
    public func setCodeBlockRadius(codeBlockRadius: Float64): Unit {
        this.codeBlockRadius = codeBlockRadius
    }

    /**
     * 设置代码块代码全屏按钮是否显示
     *
     * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true：显示；false：不显示。默认true
     */
    public func setIsCodeFullScreen(isCodeFullScreen: Bool): Unit {
        this.isCodeFullScreen = isCodeFullScreen
    }

    /**
     * 设置代码块代码全屏、代码复制按钮宽高
     *
     * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
     */
    public func setIconWidthAndHeight(iconWidthAndHeight: Float64): Unit {
        this.iconWidthAndHeight = iconWidthAndHeight
    }

    /**
     * 设置组合代码未选中标题字体大小
     *
     * @param codeListTitleTextSize 组合代码未选中标题字体大小 - 默认13.0fp
     */
    public func setCodeListTitleTextSize(codeListTitleTextSize: Float64): Unit {
        this.codeListTitleTextSize = codeListTitleTextSize
    }

    /**
     * 设置组合代码选中标题字体大小
     *
     * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
     */
    public func setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: Float64): Unit {
        this.codeListTitleSelectTextSize = codeListTitleSelectTextSize
    }

    /**
     * 设置组合代码选中标题文本颜色
     *
     * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认Color.RED
     */
    public func setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: UInt32): Unit {
        this.codeListTitleSelectTextColor = Color(codeListTitleSelectTextColor)
    }

    /**
     * 设置组合代码未选中标题文本颜色
     *
     * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认Color.BLACK
     */
    public func setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: UInt32): Unit {
        this.codeListTitleUnSelectTextColor = Color(codeListTitleUnSelectTextColor)
    }

    /**
     * 设置组合代码选中标题背景颜色
     *
     * @param codeListTitleSelectBackGroupColor 组合代码选中标题背景颜色 - 默认Color.GRAY
     */
    public func setCodeListTitleSelectBackGroupColor(codeListTitleSelectBackGroupColor: UInt32): Unit {
        this.codeListTitleSelectBackGroupColor = Color(codeListTitleSelectBackGroupColor)
    }

    /**
     * 设置组合代码未选中标题背景颜色
     *
     * @param codeListTitleUnSelectBackGroupColor 组合代码未选中标题背景颜色 - 默认Color.TRANSPARENT
     */
    public func setCodeListTitleUnSelectBackGroupColor(codeListTitleUnSelectBackGroupColor: UInt32): Unit {
        this.codeListTitleUnSelectBackGroupColor = Color(codeListTitleUnSelectBackGroupColor)
    }

    /**
     * 设置是否单独代码块显示
     *
     * @param isSeparateCodeBlock 是否单独代码块显示 - true：显示；false：不显示。默认false
     */
    public func setIsSeparateCodeBlock(isSeparateCodeBlock: Bool): Unit {
        this.isSeparateCodeBlock = isSeparateCodeBlock
    }

    /**
     * 设置单独代码块行号宽度
     *
     * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
     */
    public func setSeparateCodeBlockWidth(separateCodeBlockWidth: Float64): Unit {
        this.separateCodeBlockWidth = separateCodeBlockWidth
    }

    /**
     * 设置单独代码块是否居底显示
     *
     * @param separateCodeIsBottom 单独代码块是否居底显示 - 默认false
     */
    public func setSeparateCodeIsBottom(separateCodeIsBottom: Bool): Unit {
        this.separateCodeIsBottom = separateCodeIsBottom
    }

    /**
     * 设置H1、H2标题下分割线高度
     *
     * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
     */
    public func setHeadingBreakHeight(headingBreakHeight: Float64): Unit {
        this.headingBreakHeight = headingBreakHeight
    }

    /**
     * 设置H1、H2标题下分割线颜色
     *
     * @param headingBreakColor H1、H2标题下分割线颜色 - 默认0XFF191919
     */
    public func setHeadingBreakColor(headingBreakColor: UInt32): Unit {
        this.headingBreakColor = Color(headingBreakColor)
    }

    /**
     * 设置标题文本字体
     *
     * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
     */
    public func setHeadingTypeface(headingTypeface: String): Unit {
        this.headingTypeface = headingTypeface
    }

    /**
     * 设置标题模块上间距
     *
     * @param headingTopMargins 标题模块上间距 - 默认8.0
     */
    public func setHeadingTopMargins(headingTopMargins: Float64): Unit {
        this.headingTopMargins = headingTopMargins
    }

    /**
     * 设置标题模块下间距
     *
     * @param headingBottomMargins 标题模块下间距 - 默认8.0
     */
    public func setHeadingBottomMargins(headingBottomMargins: Float64): Unit {
        this.headingBottomMargins = headingBottomMargins
    }

    /**
     * 设置标题文本大小数组
     *
     * @param headingTextSizeMultipliers 标题文本大小数组 - 默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
     */
    public func setHeadingTextSizeMultipliers(headingTextSizeMultipliers: JSArrayEx<Float64>): Unit {
        this.headingTextSizeMultipliers = headingTextSizeMultipliers.toArray()
    }

    /**
     * 设置标题文本颜色
     *
     * @param headingTextColor 标题文本颜色 - 默认0XFF191919
     */
    public func setHeadingTextColor(headingTextColor: UInt32): Unit {
        this.headingTextColor = Color(headingTextColor)
    }

    /**
     * 设置标题文本字间距
     *
     * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
     */
    public func setHeadingTextWordSpace(headingTextWordSpace: Float64): Unit {
        this.headingTextWordSpace = headingTextWordSpace
    }

    /**
     * 设置一级标题文本行高
     *
     * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
     */
    public func setHeadingTextLineHeight1(headingTextLineHeight1: Float64): Unit {
        this.headingTextLineHeight1 = headingTextLineHeight1
    }

    /**
     * 设置二级标题文本行高
     *
     * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
     */
    public func setHeadingTextLineHeight2(headingTextLineHeight2: Float64): Unit {
        this.headingTextLineHeight2 = headingTextLineHeight2
    }

    /**
     * 设置三级标题文本行高
     *
     * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
     */
    public func setHeadingTextLineHeight3(headingTextLineHeight3: Float64): Unit {
        this.headingTextLineHeight3 = headingTextLineHeight3
    }

    /**
     * 设置四级标题文本行高
     *
     * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
     */
    public func setHeadingTextLineHeight4(headingTextLineHeight4: Float64): Unit {
        this.headingTextLineHeight4 = headingTextLineHeight4
    }

    /**
     * 设置五级标题文本行高
     *
     * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
     */
    public func setHeadingTextLineHeight5(headingTextLineHeight5: Float64): Unit {
        this.headingTextLineHeight5 = headingTextLineHeight5
    }

    /**
     * 设置六级标题文本行高
     *
     * @param headingTextLineHeight1 六级标题文本行高 - 默认22.0vp
     */
    public func setHeadingTextLineHeight6(headingTextLineHeight6: Float64): Unit {
        this.headingTextLineHeight6 = headingTextLineHeight6
    }

    /**
     * 设置段落模块上间距
     *
     * @param paragraphTopMargins 段落模块上间距 - 默认8.0
     */
    public func setParagraphTopMargins(paragraphTopMargins: Float64): Unit {
        this.paragraphTopMargins = paragraphTopMargins
    }

    /**
     * 设置段落模块下间距
     *
     * @param paragraphBottomMargins 段落模块下间距 - 默认8.0
     */
    public func setParagraphBottomMargins(paragraphBottomMargins: Float64): Unit {
        this.paragraphBottomMargins = paragraphBottomMargins
    }

    /**
     * 设置段落文本大小
     *
     * @param paragraphTextSize 段落文本大小 - 默认14.0fp
     */
    public func setParagraphTextSize(paragraphTextSize: Float64): Unit {
        this.paragraphTextSize = paragraphTextSize
    }

    /**
     * 设置段落文本颜色
     *
     * @param paragraphTextColor 段落文本颜色 - 默认0XFF191919
     */
    public func setParagraphTextColor(paragraphTextColor: UInt32): Unit {
        this.paragraphTextColor = Color(paragraphTextColor)
    }

    /**
     * 设置段落文本字间距
     *
     * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
     */
    public func setParagraphTextWordSpace(paragraphTextWordSpace: Float64): Unit {
        this.paragraphTextWordSpace = paragraphTextWordSpace
    }

    /**
     * 设置段落文本行高
     *
     * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
     */
    public func setParagraphTextLineHeight(paragraphTextLineHeight: Float64): Unit {
        this.paragraphTextLineHeight = paragraphTextLineHeight
    }

    /**
     * 设置段落文本字体
     *
     * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
     */
    public func setParagraphTypeface(paragraphTypeface: String): Unit {
        this.paragraphTypeface = paragraphTypeface
    }

    /**
     * 设置分割线颜色
     *
     * @param thematicBreakColor 分割线颜色 - 默认0XFF191919
     */
    public func setThematicBreakColor(thematicBreakColor: UInt32): Unit {
        this.thematicBreakColor = Color(thematicBreakColor)
    }

    /**
     * 设置分割线高度
     *
     * @param thematicBreakHeight 分割线高度 - 默认0.5vp
     */
    public func setThematicBreakHeight(thematicBreakHeight: Float64): Unit {
        this.thematicBreakHeight = thematicBreakHeight
    }

    /**
     * 设置分割线上部外边距
     *
     * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
     */
    public func setThematicBreakTopMargin(thematicBreakTopMargin: Float64): Unit {
        this.thematicBreakTopMargin = thematicBreakTopMargin
    }

    /**
     * 设置分割线下部外边距
     *
     * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
     */
    public func setThematicBreakBottomMargin(thematicBreakBottomMargin: Float64): Unit {
        this.thematicBreakBottomMargin = thematicBreakBottomMargin
    }

    /**
     * 设置软换行是否换行
     *
     * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
     */
    public func setIsLineBreak(isLineBreak: Bool): Unit {
        this.isLineBreak = isLineBreak
    }

    /**
     * 设置数学公式未加载状态是否显示文字
     *
     * @param latexDefaultText 数学公式未加载状态是否显示文字 - 默认true
     */
    public func setLatexDefaultText(latexDefaultText: Bool): Unit {
        this.latexDefaultText = latexDefaultText
    }

    /**
     * 设置数学公式文本大小
     *
     * @param latexMathTextSize 数学公式文本大小 - 默认16.0fp
     */
    public func setLatexMathTextSize(latexMathTextSize: Float64): Unit {
        this.latexMathTextSize = latexMathTextSize
    }

    /**
     * 设置数学公式背景色
     *
     * @param latexMathBackGroupColor 数学公式背景色 - 默认0xFFFFFFFF
     */
    public func setLatexMathBackGroupColor(latexMathBackGroupColor: UInt32): Unit {
        this.latexMathBackGroupColor = Color(latexMathBackGroupColor)
    }

    /**
     * 设置数学公式文本颜色
     *
     * @param latexMathTextColor 数学公式文本颜色 - 默认0xFF000000
     */
    public func setLatexMathTextColor(latexMathTextColor: UInt32): Unit {
        this.latexMathTextColor = Color(latexMathTextColor)
    }

    /**
     * 设置数学公式生成图片格式
     *
     * @param latexMathColorFormat 数学公式生成图片格式 - 默认LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
     */
    public func setLatexMathColorFormat(latexMathColorFormat: Int64): Unit {
        match (latexMathColorFormat) {
            case 0 => this.latexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_RGB_565
            case 1 => this.latexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
            case _ => this.latexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_RGB_565
        }
    }

    /**
     * 设置块结构的数学公式是否居中
     *
     * @param latexMathBlockCenter 块结构的数学公式是否居中 - true：居中；false：不居中。默认false
     */
    public func setLatexMathBlockCenter(latexMathBlockCenter: Bool): Unit {
        this.latexMathBlockCenter = latexMathBlockCenter
    }

    /**
     * 设置数学公式字体路径
     *
     * @param latexMathResStr 数学公式字体路径 默认 "/data/storage/el1/bundle/entry/resources/resfile/res"
     */
    public func setLatexMathResStr(latexMathResStr: String): Unit {
        this.latexMathResStr = latexMathResStr
    }

    /**
     * 设置音频阴影颜色值
     *
     * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
     */
    public func setAudioShadowColor(audioShadowColor: UInt32): Unit {
        this.audioShadowColor = Color(audioShadowColor)
    }

    /**
     * 设置音频边框颜色
     *
     * @param audioBorderColor 音频边框颜色 - 默认0x33000000
     */
    public func setAudioBorderColor(audioBorderColor: UInt32): Unit {
        this.audioBorderColor = Color(audioBorderColor)
    }

    /**
     * 设置音频边框粗细
     *
     * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
     */
    public func setAudioBorderWidth(audioBorderWidth: Float64): Unit {
        this.audioBorderWidth = audioBorderWidth
    }

    /**
     * 设置音频边框圆角
     *
     * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
     */
    public func setAudioBorderRadius(audioBorderRadius: Float64): Unit {
        this.audioBorderRadius = audioBorderRadius
    }

    /**
     * 设置音频按钮背景颜色
     *
     * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认Color.BLACK
     */
    public func setAudioButtonBackgroundColor(audioButtonBackgroundColor: UInt32): Unit {
        this.audioButtonBackgroundColor = Color(audioButtonBackgroundColor)
    }

    /**
     * 设置音频按钮文字颜色
     *
     * @param audioButtonTextColor 音频按钮文字颜色 - 默认Color.WHITE
     */
    public func setAudioButtonTextColor(audioButtonTextColor: UInt32): Unit {
        this.audioButtonTextColor = Color(audioButtonTextColor)
    }

    /**
     * 设置音频按钮文字大小
     *
     * @param audioButtonTextSize 音频按钮文字大小 - 默认14.0fp
     */
    public func setAudioButtonTextSize(audioButtonTextSize: Float64): Unit {
        this.audioButtonTextSize = audioButtonTextSize
    }

    /**
     * 设置音频按钮文字内容
     *
     * @param audioButtonText 音频按钮文字内容 - 默认"立即播放"
     */
    public func setAudioButtonText(audioButtonText: String): Unit {
        this.audioButtonText = audioButtonText
    }

    /**
     * 设置音频按钮圆角
     *
     * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
     */
    public func setAudioButtonBorderRadius(audioButtonBorderRadius: Float64): Unit {
        this.audioButtonBorderRadius = audioButtonBorderRadius
    }

    /**
     * 设置音频标题文字大小
     *
     * @param audioTitleTextSize 音频标题文字大小 - 默认15.0fp
     */
    public func setAudioTitleTextSize(audioTitleTextSize: Float64): Unit {
        this.audioTitleTextSize = audioTitleTextSize
    }

    /**
     * 设置音频标题文字颜色
     *
     * @param audioTitleTextColor音频标题文字颜色 - 默认Color.BLACK
     */
    public func setAudioTitleTextColor(audioTitleTextColor: UInt32): Unit {
        this.audioTitleTextColor = Color(audioTitleTextColor)
    }

    /**
     * 设置音频标题文字行高
     *
     * @param audioTitleTextLineHeight 音频标题文字行高 - 默认20.0vp
     */
    public func setAudioTitleTextLineHeight(audioTitleTextLineHeight: Float64): Unit {
        this.audioTitleTextLineHeight = audioTitleTextLineHeight
    }

    /**
     * 设置音频类型文字大小
     *
     * @param audioTypeTextSize 音频类型文字大小 - 默认11.0fp
     */
    public func setAudioTypeTextSize(audioTypeTextSize: Float64): Unit {
        this.audioTypeTextSize = audioTypeTextSize
    }

    /**
     * 设置音频类型文字颜色
     *
     * @param audioTypeTextColor 音频类型文字颜色 - 默认0X80000000
     */
    public func setAudioTypeTextColor(audioTypeTextColor: UInt32): Unit {
        this.audioTypeTextColor = Color(audioTypeTextColor)
    }

    /**
     * 设置音频类型文字行高
     *
     * @param audioTypeTextLineHeight 音频类型文字行高 - 默认15.0vp
     */
    public func setAudioTypeTextLineHeight(audioTypeTextLineHeight: Float64): Unit {
        this.audioTypeTextLineHeight = audioTypeTextLineHeight
    }

    /**
     * 设置音频上边距
     *
     * @param audioMarginTop 音频上边距 - 默认10.0vp
     */
    public func setAudioMarginTop(audioMarginTop: Float64): Unit {
        this.audioMarginTop = audioMarginTop
    }

    /**
     * 设置音频下边距
     *
     * @param audioMarginBottom 音频下边距 - 默认10.0vp
     */
    public func setAudioMarginBottom(audioMarginBottom: Float64): Unit {
        this.audioMarginBottom = audioMarginBottom
    }

    /**
     * 设置视频圆角
     *
     * @param videoBorderRadius 视频圆角 - 默认10.0vp
     */
    public func setVideoBorderRadius(videoBorderRadius: Float64): Unit {
        this.videoBorderRadius = videoBorderRadius
    }

    /**
     * 设置视频时间文本颜色
     *
     * @param videoTimeTextColor 视频时间文本颜色 - 默认Color.WHITE
     */
    public func setVideoTimeTextColor(videoTimeTextColor: UInt32): Unit {
        this.videoTimeTextColor = Color(videoTimeTextColor)
    }

    /**
     * 设置视频时间文本大小
     *
     * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
     */
    public func setVideoTimeTextSize(videoTimeTextSize: Float64): Unit {
        this.videoTimeTextSize = videoTimeTextSize
    }

    /**
     * 设置视频时间文本居右边距
     *
     * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
     */
    public func setVideoTimeTextMarginRight(videoTimeTextMarginRight: Float64): Unit {
        this.videoTimeTextMarginRight = videoTimeTextMarginRight
    }

    /**
     * 设置视频时间文本居底边距
     *
     * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
     */
    public func setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: Float64): Unit {
        this.videoTimeTextMarginBottom = videoTimeTextMarginBottom
    }

    /**
     * 设置视频上边距
     *
     * @param videoMarginTop 视频上边距 - 默认10.0vp
     */
    public func setVideoMarginTop(videoMarginTop: Float64): Unit {
        this.videoMarginTop = videoMarginTop
    }

    /**
     * 设置视频下边距
     *
     * @param videoMarginBottom 视频下边距 - 默认10.0vp
     */
    public func setVideoMarginBottom(videoMarginBottom: Float64): Unit {
        this.videoMarginBottom = videoMarginBottom
    }

    /**
     * 设置图片缩放类型
     *
     * @param imageFitType 图片缩放类型 - 默认ImageFit.Contain
     */
    public func setImageFitType(imageFitType: Int64): Unit {
        this.imageFitType = match (imageFitType) {
            case 0 => ImageFit.Contain
            case 1 => ImageFit.Cover
            case 2 => ImageFit.Fill
            case _ => ImageFit.Contain
        }
    }

    /**
     * 设置图片最大宽度百分比
     *
     * @param imageMaximumWidth 图片最大宽度百分比 - 默认1.0
     */
    public func setImageMaximumWidth(imageMaximumWidth: Float64): Unit {
        this.imageMaximumWidth = imageMaximumWidth
    }

    /**
     * 设置图片固定宽度百分比
     *
     * @param imageFixedRatioWidth 图片固定宽度百分比 - 默认None
     */
    public func setImageFixedRatioWidth(imageFixedRatioWidth: Float64): Unit {
        this.imageFixedRatioWidth = imageFixedRatioWidth
    }

    /**
     * 设置图片圆角大小
     *
     * @param imageBorderRadius 图片圆角大小 - 默认0.0vp
     */
    public func setImageBorderRadius(imageBorderRadius: Float64): Unit {
        this.imageBorderRadius = imageBorderRadius
    }

    /**
     * 设置网络图片是否压缩
     *
     * @param isAutoResize 网络图片是否压缩 - true：压缩；false：不压缩。默认true
     */
    public func setIsAutoResize(isAutoResize: Bool): Unit {
        this.isAutoResize = isAutoResize
    }

    /**
     * 设置图片上边距
     *
     * @param imageMarginTop 图片上边距 - 默认10.0vp
     */
    public func setImageMarginTop(imageMarginTop: Float64): Unit {
        this.imageMarginTop = imageMarginTop
    }

    /**
     * 设置图片下边距
     *
     * @param imageMarginBottom 图片下边距 - 默认10.0vp
     */
    public func setImageMarginBottom(imageMarginBottom: Float64): Unit {
        this.imageMarginBottom = imageMarginBottom
    }

    /**
     * 设置表格内容内边距
     *
     * @param tableCellPadding 表格内容内边距 - 默认4.0vp
     */
    public func setTableCellPadding(tableCellPadding: Float64): Unit {
        this.tableCellPadding = tableCellPadding
    }

    /**
     * 设置表格边框颜色
     *
     * @param tableBorderColor 表格边框颜色 - 默认0XFF000000
     */
    public func setTableBorderColor(tableBorderColor: UInt32): Unit {
        this.tableBorderColor = Color(tableBorderColor)
    }

    /**
     * 设置表格边框宽度
     *
     * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
     */
    public func setTableBorderWidth(tableBorderWidth: Float64): Unit {
        this.tableBorderWidth = tableBorderWidth
    }

    /**
     * 设置表格奇数行背景色
     *
     * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0XFFFFFFFF
     */
    public func setTableOddRowBackgroundColor(tableOddRowBackgroundColor: UInt32): Unit {
        this.tableOddRowBackgroundColor = Color(tableOddRowBackgroundColor)
    }

    /**
     * 设置表格偶数行背景色
     *
     * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0XFFE0E0E0
     */
    public func setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: UInt32): Unit {
        this.tableEvenRowBackgroundColor = Color(tableEvenRowBackgroundColor)
    }

    /**
     * 设置表格头背景色
     *
     * @param tableHeaderRowBackgroundColor 表格头背景色 - 默认0XFFFFFFFF
     */
    public func setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: UInt32): Unit {
        this.tableHeaderRowBackgroundColor = Color(tableHeaderRowBackgroundColor)
    }

    /**
     * 设置表格文本行高
     *
     * @param tableTextLineHeight 表格文本行高 - 默认22.0vp
     */
    public func setTableTextLineHeight(tableTextLineHeight: Float64): Unit {
        this.tableTextLineHeight = tableTextLineHeight
    }

    /**
     * 设置表格圆角
     *
     * @param tableRadius 表格圆角 - 默认5.0vp
     */
    public func setTableRadius(tableRadius: Float64): Unit {
        this.tableRadius = tableRadius
    }

    /**
     * 设置表格最小宽度
     *
     * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
     */
    public func setTableMinTextWidth(tableMinTextWidth: Float64): Unit {
        this.tableMinTextWidth = tableMinTextWidth
    }

    /**
     * 设置表格最大宽度
     *
     * @param tableMaxTextWidth 表格最大宽度- 默认300.0vp
     */
    public func setTableMaxTextWidth(tableMaxTextWidth: Float64): Unit {
        this.tableMaxTextWidth = tableMaxTextWidth
    }

    /**
     * 设置表格第一列是否加粗
     *
     * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
     */
    public func setTableFirstColumnBold(tableFirstColumnBold: Bool): Unit {
        this.tableFirstColumnBold = tableFirstColumnBold
    }

    /**
     * 设置代码块深浅色
     *
     * @param isDark 是否是深色 - true：深色；false：浅色。默认false
     */
    public func setIsDark(isDark: Bool): Unit {
        this.isDark = isDark
    }

    /**
     * 设置删除线颜色
     *
     * @param strikethroughColor 删除线颜色 - 默认0X191919
     */
    public func setStrikethroughColor(strikethroughColor: UInt32): Unit {
        this.strikethroughColor = Color(strikethroughColor)
    }

    /**
     * 设置定义列表术语和定义行之间间距
     *
     * @param descListTermAndDefMargins 定义列表定义行缩进 默认8.0
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setDescListTermAndDefMargins(descListTermAndDefMargins: Float64): Unit {
        this.descListTermAndDefMargins = descListTermAndDefMargins
    }

    /**
     * 设置定义列表定义行缩进
     *
     * @param descListDefIndentation 定义列表定义行缩进 默认8.0
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setDescListDefIndentation(descListDefIndentation: Float64): Unit {
        this.descListDefIndentation = descListDefIndentation
    }

    /**
     * 设置定义列表定义行间距
     *
     * @param descListDefMargins 定义列表定义行间距 默认8.0
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setDescListDefMargins(descListDefMargins: Float64): Unit {
        this.descListDefMargins = descListDefMargins
    }
}
