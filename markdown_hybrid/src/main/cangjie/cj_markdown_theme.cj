/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownTheme {
    /**
     * 全局样式
     */
    var cjMarkdownGlobalTheme: CJMarkdownGlobalTheme = CJMarkdownGlobalTheme()

    /**
     * 链接文本样式
     */
    var cjMarkdownLinkTheme: CJMarkdownLinkTheme = CJMarkdownLinkTheme()

    /**
     * banner样式
     */
    var cjMarkdownBannerTheme: CJMarkdownBannerTheme = CJMarkdownBannerTheme()

    /**
     * 块引用样式
     */
    var cjMarkdownBlockQuoteTheme: CJMarkdownBlockQuoteTheme = CJMarkdownBlockQuoteTheme()

    /**
     * 有序列表样式
     */
    var cjMarkdownOrderedListTheme: CJMarkdownOrderedListTheme = CJMarkdownOrderedListTheme()

    /**
     * 无序/任务列表样式
     */
    var cjMarkdownBulletListTheme: CJMarkdownBulletListTheme = CJMarkdownBulletListTheme()

    /**
     * 代码块样式
     */
    var cjMarkdownCodeBlockTheme: CJMarkdownCodeBlockTheme = CJMarkdownCodeBlockTheme()

    /**
     * 内联代码样式
     */
    var cjMarkdownInlineCodeTheme: CJMarkdownInlineCodeTheme = CJMarkdownInlineCodeTheme()

    /**
     * 标题样式
     */
    var cjMarkdownHeadingTheme: CJMarkdownHeadingTheme = CJMarkdownHeadingTheme()

    /**
     * 段落样式
     */
    var cjMarkdownParagraphTheme: CJMarkdownParagraphTheme = CJMarkdownParagraphTheme()

    /**
     * 分割线样式
     */
    var cjMarkdownDividerTheme: CJMarkdownDividerTheme = CJMarkdownDividerTheme()

    /**
     * 数学公式样式
     */
    var cjMarkdownLatexMathTheme: CJMarkdownLatexMathTheme = CJMarkdownLatexMathTheme()

    /**
     * 音频样式
     */
    var cjMarkdownAudioTheme: CJMarkdownAudioTheme = CJMarkdownAudioTheme()

    /**
     * 加粗文本样式
     */
    var cjMarkdownBoldTheme: CJMarkdownBoldTheme = CJMarkdownBoldTheme()

    /**
     * 斜体文本样式
     */
    var cjMarkdownItalicTheme: CJMarkdownItalicTheme = CJMarkdownItalicTheme()

    /**
     * 删除线文本样式
     */
    var cjMarkdownStrikethroughTheme: CJMarkdownStrikethroughTheme = CJMarkdownStrikethroughTheme()

    /**
     * 脚注定义样式
     */
    var cjMarkdownFootnoteDefTheme: CJMarkdownFootnoteDefTheme = CJMarkdownFootnoteDefTheme()

    /**
     * 脚注引用样式
     */
    var cjMarkdownFootnoteRefTheme: CJMarkdownFootnoteRefTheme = CJMarkdownFootnoteRefTheme()

    /**
     * 视频样式
     */
    var cjMarkdownVideoTheme: CJMarkdownVideoTheme = CJMarkdownVideoTheme()

    /**
     * 图片样式
     */
    var cjMarkdownImageTheme: CJMarkdownImageTheme = CJMarkdownImageTheme()

    /**
     * 表格样式
     */
    var cjMarkdownTableTheme: CJMarkdownTableTheme = CJMarkdownTableTheme()

    /**
     * 定义列表样式
     */
    var cjMarkdownDefinitionListTheme: CJMarkdownDefinitionListTheme = CJMarkdownDefinitionListTheme()

    /**
     * 下标文本样式
     */
    var cjMarkdownSubTheme: CJMarkdownSubTheme = CJMarkdownSubTheme()

    /**
     * 上标文本样式
     */
    var cjMarkdownSupTheme: CJMarkdownSupTheme = CJMarkdownSupTheme()

    /**
     * 下划线样式
     */
    var cjMarkdownHtmlUnderlineTheme: CJMarkdownHtmlUnderlineTheme = CJMarkdownHtmlUnderlineTheme()

    /**
     * 代码深浅色模式
     */
    var isDark: ?Bool = None

    /**
     * 是否按照链接文本字体大小显示文本
     */
    var isLinkSize: ?Bool = None

    public init() {}

    /**
     * 设置markdown是否同步解析
     *
     * @param isMarkdownParserSync markdown是否同步解析 - 默认false
     */
    public func setIsMarkdownParserSync(isMarkdownParserSync: Bool): Unit {
        this.cjMarkdownGlobalTheme.setIsMarkdownParserSync(isMarkdownParserSync)
    }

    /**
     * 设置是否打开长按复制粘贴
     *
     * @param isOnCopy 是否打开长按复制粘贴 - 默认true
     */
    public func setIsOnCopy(isOnCopy: Bool): Unit {
        this.cjMarkdownGlobalTheme.setIsOnCopy(isOnCopy)
    }

    /**
     * 设置markdown第一个模块上边距
     *
     * @param blockFirstTopMargin markdown第一个模块上边距 - 默认8.0vp
     */
    public func setBlockFirstTopMargin(blockFirstTopMargin: Float64): Unit {
        this.cjMarkdownGlobalTheme.blockMarginTop = blockFirstTopMargin
    }

    /**
     * 设置markdown最后一个模块下边距
     *
     * @param blockLastBottomMargin markdown最后一个模块下边距 - 默认8.0vp
     */
    public func setBlockLastBottomMargin(blockLastBottomMargin: Float64): Unit {
        this.cjMarkdownGlobalTheme.blockMarginBottom = blockLastBottomMargin
    }

    /**
     * 设置模块间上下间距
     *
     * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
     */
    public func setBlockTopAndBottomMargins(blockTopAndBottomMargins: Float64): Unit {
        this.cjMarkdownGlobalTheme.setBlockSpacing(Int64(blockTopAndBottomMargins))
    }

    /**
     * 设置链接是否是图片显示
     *
     * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
     */
    public func setIsLinkStyle(isLinkStyle: Bool): Unit {
        this.cjMarkdownLinkTheme.setLinkIsIcon(isLinkStyle)
    }

    /**
     * 设置列表中的单行链接是否是图片显示
     *
     * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true：图片显示；false：文本显示。默认false
     */
    public func setIsListLinkStyle(isListLinkStyle: Bool): Unit {
        this.cjMarkdownLinkTheme.setLinkListIsIcon(isListLinkStyle)
    }

    /**
     * 设置文本格式链接文本颜色
     *
     * @param linkColor 文本格式链接文本颜色 - 默认0XFF0000FF
     */
    public func setLinkColor(linkColor: UInt32): Unit {
        this.cjMarkdownLinkTheme.setLinkTextFontColor(linkColor)
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
        this.cjMarkdownLinkTheme.setLinkTextFontSize(linkSize)
    }

    /**
     * 设置文本格式链接文字行高
     *
     * @param linkLineHeight 文本格式链接文字行高
     */
    public func setLinkLineHeight(linkLineHeight: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkTextLineHeight(linkLineHeight)
    }

    /**
     * 设置文本格式链接背景颜色
     *
     * @param linkBackGroupColor 文本格式链接背景颜色 - 默认0XFF000000
     */
    public func setLinkBackGroupColor(linkBackGroupColor: UInt32): Unit {
        this.cjMarkdownLinkTheme.setLinkTextBackgroundColor(linkBackGroupColor)
    }

    /**
     * 设置文本格式是否显示链接下划线
     *
     * @param isLinkUnderlined 文本格式是否显示链接下划线 - true：显示下划线；false：不显示下划线。默认true
     */
    public func setIsLinkUnderlined(isLinkUnderlined: Bool): Unit {
        if (isLinkUnderlined) {
            this.cjMarkdownLinkTheme.setLinkTextDecorationType(2)
        } else {
            this.cjMarkdownLinkTheme.setLinkTextDecorationType(0)
        }
    }

    /**
     * 设置圆形图片格式链接主题背景颜色
     *
     * @param linkCircleImageBackGroupColor 圆形图片格式链接主题背景颜色 - 默认0XFFFFFFFF
     */
    public func setLinkCircleImageBackGroupColor(linkCircleImageBackGroupColor: UInt32): Unit {
        this.cjMarkdownLinkTheme.setLinkCircleIconBackgroundColor(linkCircleImageBackGroupColor)
    }

    /**
     * 设置圆形图片格式链接控件背景颜色
     *
     * @param linkCircleImageButtonBackGroupColor 圆形图片格式链接控件背景颜色 - 默认0XFF000000
     */
    public func setLinkCircleImageButtonBackGroupColor(linkCircleImageButtonBackGroupColor: UInt32): Unit {
        this.cjMarkdownLinkTheme.setLinkCircleIconButtonBackgroundColor(linkCircleImageButtonBackGroupColor)
    }

    /**
     * 设置圆形图片格式链接文字大小
     *
     * @param linkCircleImageTextSize 圆形图片格式链接文字大小 - 默认14.0fp
     */
    public func setLinkCircleImageTextSize(linkCircleImageTextSize: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkCircleIconTextSize(linkCircleImageTextSize)
    }

    /**
     * 设置圆形图片格式链接文字颜色
     *
     * @param linkCircleImageTextColor 圆形图片格式链接文字颜色 - 默认0XFFFFFFFF
     */
    public func setLinkCircleImageTextColor(linkCircleImageTextColor: UInt32): Unit {
        this.cjMarkdownLinkTheme.setLinkCircleIconTextColor(linkCircleImageTextColor)
    }

    /**
     * 设置圆形图片格式链接半径
     *
     * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
     */
    public func setLinkCircleImageRadius(linkCircleImageRadius: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkCircleIconRadius(linkCircleImageRadius)
    }

    /**
     * 设置圆形图片格式链接左右外边距
     *
     * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
     */
    public func setLinkCircleImageMargin(linkCircleImageMargin: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkCircleIconMargin(linkCircleImageMargin)
    }

    /**
     * 设置圆角矩形图片格式链接主题背景颜色
     *
     * @param linkRectImageBackGroupColor 圆角矩形图片格式链接主题背景颜色 - 默认0XFFFFFFFF
     */
    public func setLinkRectImageBackGroupColor(linkRectImageBackGroupColor: UInt32): Unit {
        this.cjMarkdownLinkTheme.setLinkRectIconBackgroundColor(linkRectImageBackGroupColor)
    }

    /**
     * 设置圆角矩形图片格式链接控件背景颜色
     *
     * @param linkRectImageButtonBackGroupColor 圆角矩形图片格式链接控件背景颜色 - 默认0XFF000000
     */
    public func setLinkRectImageButtonBackGroupColor(linkRectImageButtonBackGroupColor: UInt32): Unit {
        this.cjMarkdownLinkTheme.setLinkRectIconButtonBackgroundColor(linkRectImageButtonBackGroupColor)
    }

    /**
     * 圆角矩形图片格式链接文字大小
     *
     * @param linkRectImageTextSize 圆角矩形图片格式链接文字大小 - 默认14.0fp
     */
    public func setLinkRectImageTextSize(linkRectImageTextSize: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkRectIconTextSize(linkRectImageTextSize)
    }

    /**
     * 设置圆角矩形图片格式链接文字颜色
     *
     * @param linkRectImageTextColor 圆角矩形图片格式链接文字颜色 - 默认0XFFFFFFFF
     */
    public func setLinkRectImageTextColor(linkRectImageTextColor: UInt32): Unit {
        this.cjMarkdownLinkTheme.setLinkRectIconTextColor(linkRectImageTextColor)
    }

    /**
     * 圆角矩形图片格式链接控件高度
     *
     * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
     */
    public func setLinkRectImageHeight(linkRectImageHeight: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkRectIconHeight(linkRectImageHeight)
    }

    /**
     * 圆角矩形图片格式链接左右内边距
     *
     * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
     */
    public func setLinkRectImagePadding(linkRectImagePadding: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkRectIconPadding(linkRectImagePadding)
    }

    /**
     * 圆角矩形图片格式链接圆角半径
     *
     * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
     */
    public func setLinkRectImageRadius(linkRectImageRadius: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkRectIconRadius(linkRectImageRadius)
    }

    /**
     * 圆角矩形图片格式链接左右外边距
     *
     * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
     */
    public func setLinkRectImageMargin(linkRectImageMargin: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkRectIconMargin(linkRectImageMargin)
    }

    /**
     * 设置空心圆角矩形图片格式链接主题背景颜色
     *
     * @param linkRectToolImageBackGroupColor 空心圆角矩形图片格式链接主题背景颜色 - 默认OXFFFFFFFF
     */
    public func setLinkRectToolImageBackGroupColor(linkRectToolImageBackGroupColor: UInt32): Unit {
        this.cjMarkdownLinkTheme.setLinkRectToolIconBackgroundColor(linkRectToolImageBackGroupColor)
    }

    /**
     * 设置空心圆角矩形图片格式链接控件背景颜色
     *
     * @param linkRectToolImageButtonBackGroupColor 空心圆角矩形图片格式链接控件背景颜色 - 默认OXFFFFFFFF
     */
    public func setLinkRectToolImageButtonBackGroupColor(linkRectToolImageButtonBackGroupColor: UInt32): Unit {
        this.cjMarkdownLinkTheme.setLinkRectToolIconButtonBackgroundColor(linkRectToolImageButtonBackGroupColor)
    }

    /**
     * 设置空心圆角矩形图片格式链接文字大小
     *
     * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文字大小 - 默认14.0fp
     */
    public func setLinkRectToolImageTextSize(linkRectToolImageTextSize: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkRectToolIconTextSize(linkRectToolImageTextSize)
    }

    /**
     * 设置空心圆角矩形图片格式链接控件高度
     *
     * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
     */
    public func setLinkRectToolImageHeight(linkRectToolImageHeight: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkRectToolIconHeight(linkRectToolImageHeight)
    }

    /**
     * 设置空心圆角矩形图片格式链接左右内边距
     *
     * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
     */
    public func setLinkRectToolImagePadding(linkRectToolImagePadding: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkRectToolIconPadding(linkRectToolImagePadding)
    }

    /**
     * 设置空心圆角矩形图片格式链接边框宽度
     *
     * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
     */
    public func setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkRectToolIconBorderWidth(linkRectToolImageBorderWidth)
    }

    /**
     * 设置空心圆角矩形图片格式链接分割线宽度
     *
     * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
     */
    public func setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkRectToolIconDividingLineWidth(linkRectToolImageDividingLineWidth)
    }

    /**
     * 设置空心圆角矩形图片格式链接左右外边距
     *
     * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
     */
    public func setLinkRectToolImageMargin(linkRectToolImageMargin: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkRectToolIconMargin(linkRectToolImageMargin)
    }

    /**
     * 设置空心圆角矩形图片格式分割线和文本左边距
     *
     * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
     */
    public func setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkRectToolIconLineLeftPadding(linkRectToolImageLineLeftPadding)
    }

    /**
     * 设置空心圆角矩形图片格式分割线和文本右边距
     *
     * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
     */
    public func setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: Float64): Unit {
        this.cjMarkdownLinkTheme.setLinkRectToolIconLineRightPadding(linkRectToolImageLineRightPadding)
    }

    /**
     * 设置块引用左边距
     *
     * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
     */
    public func setBlockQuoteLeftMargin(blockQuoteLeftMargin: Float64): Unit {
        this.cjMarkdownBlockQuoteTheme.blockQuoteMarginLeft = blockQuoteLeftMargin
    }

    /**
     * 设置块引用右边距
     *
     * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
     */
    public func setBlockQuoteRightMargin(blockQuoteRightMargin: Float64): Unit {
        this.cjMarkdownBlockQuoteTheme.blockQuoteMarginRight = blockQuoteRightMargin
    }

    /**
     * 设置块引用左边线条宽度
     *
     * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
     */
    public func setBlockQuoteWidth(blockQuoteWidth: Float64): Unit {
        this.cjMarkdownBlockQuoteTheme.setBlockQuoteLeftBorderWidth(blockQuoteWidth)
    }

    /**
     * 设置块引用左边线条颜色
     *
     * @param blockQuoteColor 块引用左边线条颜色 - 默认0XFF191919
     */
    public func setBlockQuoteColor(blockQuoteColor: UInt32): Unit {
        this.cjMarkdownBlockQuoteTheme.setBlockQuoteLeftBorderColor(blockQuoteColor)
    }

    /**
     * 设置块引用背景颜色
     *
     * @param blockQuoteBackGroupColor 块引用背景颜色 - 默认0XFFFFFFFF
     */
    public func setBlockQuoteBackGroupColor(blockQuoteBackGroupColor: UInt32): Unit {
        this.cjMarkdownBlockQuoteTheme.setBlockQuoteBackgroundColor(blockQuoteBackGroupColor)
    }

    /**
     * 设置块引用子模块上下间距
     *
     * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
     */
    public func setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: Float64): Unit {
        this.cjMarkdownBlockQuoteTheme.setBlockQuoteChildSpacing(blockQuoteTopAndBottomMargins)
    }

    /**
     * 设置有序列表、无序列表、任务列表子模块上下间距
     *
     * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
     */
    public func setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: Float64): Unit {
        this.cjMarkdownOrderedListTheme.setOrderedListChildSpacing(Int64(blockOrderedAndBulletTopAndBottomMargins))
        this.cjMarkdownBulletListTheme.setBulletListChildSpacing(Int64(blockOrderedAndBulletTopAndBottomMargins))
    }

    /**
     * 设置有序列表、无序列表、任务列表左边距
     *
     * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
     */
    public func setBlockLeftMargin(blockLeftMargin: Float64): Unit {
        this.cjMarkdownOrderedListTheme.orderedListMarginLeft = blockLeftMargin
        this.cjMarkdownBulletListTheme.bulletListMarginLeft = blockLeftMargin
    }

    /**
     * 设置有序列表、无序列表、任务列表右边距 - 列表前缀和列表内容间距
     *
     * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
     */
    public func setBlockRightMargin(blockRightMargin: Float64): Unit {
        this.cjMarkdownOrderedListTheme.setOrderedListMarkerSpacing(blockRightMargin)
        this.cjMarkdownBulletListTheme.setBulletListBulletSpacing(blockRightMargin)
    }

    /**
     * 设置有序列表前缀文本是否加粗
     *
     * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true：加粗；false：不加粗。默认false
     */
    public func setOrderedListItemPrefixBold(orderedListItemPrefixBold: Bool): Unit {
        if (orderedListItemPrefixBold) {
            this.cjMarkdownOrderedListTheme.setOrderedListMarkerTextFontWeight(4) // convertFontWeight转换时4表示Blod
        } else {
            this.cjMarkdownOrderedListTheme.setOrderedListMarkerTextFontWeight(1) // convertFontWeight转换时1表示Normal
        }
    }

    /**
     * 设置有序列表前缀文本颜色
     *
     * @param orderedListItemColor 有序列表前缀文本颜色 - 默认OXFF191919
     */
    public func setOrderedListItemColor(orderedListItemColor: UInt32): Unit {
        this.cjMarkdownOrderedListTheme.setOrderedListMarkerTextFontColor(orderedListItemColor)
    }

    /**
     * 设置有序列表前缀文本大小
     *
     * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
     */
    public func setOrderedListItemSize(orderedListItemSize: Float64): Unit {
        this.cjMarkdownOrderedListTheme.setOrderedListMarkerTextFontSize(orderedListItemSize)
    }

    /**
     * 设置有序列表前缀文本行高
     *
     * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
     */
    public func setOrderedListItemLineHeight(orderedListItemLineHeight: Float64): Unit {
        this.cjMarkdownOrderedListTheme.setOrderedListMarkerTextLineHeight(orderedListItemLineHeight)
    }

    /**
     * 设置无序列表前缀是否全部是实心圆型
     *
     * @param bulletListItemCircle 无序列表前缀是否全部是实心圆型 - 默认false
     */
    public func setBulletListItemCircle(bulletListItemCircle: Bool): Unit {
        this.cjMarkdownBulletListTheme.setBulletListBulletIsCircle(bulletListItemCircle)
    }

    /**
     * 设置无序列表前缀文本颜色
     *
     * @param bulletListItemColor 无序列表前缀文本颜色 - 默认OXFF191919
     */
    public func setBulletListItemColor(bulletListItemColor: UInt32): Unit {
        this.cjMarkdownBulletListTheme.setBulletListBulletTextFontColor(bulletListItemColor)
    }

    /**
     * 设置无序列表前缀文本大小
     *
     * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
     */
    public func setBulletListItemSize(bulletListItemSize: Float64): Unit {
        this.cjMarkdownBulletListTheme.setBulletListBulletTextFontSize(bulletListItemSize)
    }

    /**
     * 设置无序列表前缀文本行高
     *
     * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
     */
    public func setBulletListItemLineHeight(bulletListItemLineHeight: Float64): Unit {
        this.cjMarkdownBulletListTheme.setBulletListBulletTextLineHeight(bulletListItemLineHeight)
    }

    /**
     * 设置任务列表选择框宽高
     *
     * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
     */
    public func setTaskListItemLength(taskListItemLength: Float64): Unit {
        this.cjMarkdownBulletListTheme.setBulletListCheckboxWidth(taskListItemLength)
        this.cjMarkdownBulletListTheme.setBulletListCheckboxHeight(taskListItemLength)
    }

    /**
     * 设置是否格式化代码块内容
     *
     * @param isCodeFormat 是否格式化代码块内容 - true：格式化代码块内容；false：不格式化代码块内容。默认false
     */
    public func setIsCodeFormat(isCodeFormat: Bool): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockIsCodeFormat(isCodeFormat)
    }

    /**
     * 设置内联代码文本颜色
     *
     * @param codeTextColor 内联代码文本颜色 - 默认OXFF000000
     */
    public func setCodeTextColor(codeTextColor: UInt32): Unit {
        this.cjMarkdownInlineCodeTheme.setInlineCodeTextFontColor(codeTextColor)
    }

    /**
     * 设置内联代码背景颜色
     *
     * @param codeBackgroundColor 内联代码背景颜色 - 默认OXFF191919
     */
    public func setCodeBackgroundColor(codeBackgroundColor: UInt32): Unit {
        this.cjMarkdownInlineCodeTheme.setInlineCodeTextBackgroundColor(codeBackgroundColor)
    }

    /**
     * 设置内联代码文本大小
     *
     * @param codeTextSize 内联代码文本大小 - 默认13.0fp
     */
    public func setCodeTextSize(codeTextSize: Float64): Unit {
        this.cjMarkdownInlineCodeTheme.setInlineCodeTextFontSize(codeTextSize)
    }

    /**
     * 设置内联代码文本字体
     *
     * @param codeTypeface 内联代码文本字体 - 默认"HarmonyOS Sans"
     */
    public func setCodeTypeface(codeTypeface: String): Unit {
        this.cjMarkdownInlineCodeTheme.setInlineCodeTextFontFamily(codeTypeface)
    }

    /**
     * 设置围栏代码块代码高亮是否同步解析
     *
     * @param isCodeBlockParserSync 围栏代码块代码高亮是否同步解析 - 默认false
     */
    public func setIsCodeBlockParserSync(isCodeBlockParserSync: Bool): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockParserSync(isCodeBlockParserSync)
    }

    /**
     * 设置代码块代码文本颜色
     *
     * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
     */
    public func setCodeBlockTextColor(codeBlockTextColor: UInt32): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockTextFontColor(codeBlockTextColor)
    }

    /**
     * 设置代码块代码类型文本颜色
     *
     * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
     */
    public func setCodeBlockTypeTextColor(codeBlockTypeTextColor: UInt32): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockTypeTextFontColor(codeBlockTypeTextColor)
    }

    /**
     * 设置代码块代码类型文本
     *
     * @param codeBlockTypeTextStr 代码块代码类型文本 - 默认""
     */
    public func setCodeBlockTypeTextStr(codeBlockTypeTextStr: String): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockTypeText(codeBlockTypeTextStr)
    }

    /**
     * 设置代码类型和代码块距离
     *
     * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
     */
    public func setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: Float64): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockTitleLayoutMarginBottom(codeBlockTypeTextPadding)
    }

    /**
     * 设置代码块复制、全屏图片文字是否显示
     *
     * @param codeBlockIconTextHide 代码块复制、全屏图片文字是否显示 - true：显示；false：不显示。默认true
     */
    public func setCodeBlockIconTextHide(codeBlockIconTextHide: Bool): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockCopyTextIsShow(codeBlockIconTextHide)
        this.cjMarkdownCodeBlockTheme.setCodeBlockFullScreenTextIsShow(codeBlockIconTextHide)
    }

    /**
     * 设置代码块代码行号是否显示
     *
     * @param codeBlockLineNumberHide 代码块代码行号是否显示 - true：显示；false：不显示。默认true
     */
    public func setCodeBlockLineNumberHide(codeBlockLineNumberHide: Bool): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockLineNumberIsShow(codeBlockLineNumberHide)
    }

    /**
     * 设置代码块背景颜色
     *
     * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
     */
    public func setCodeBlockBackgroundColor(codeBlockBackgroundColor: UInt32): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockBackgroundColor(codeBlockBackgroundColor)
    }

    /**
     * 设置代码块左边距（代码块代码行号和分割线间距）
     *
     * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
     */
    public func setCodeMultilineMargin(codeMultilineMargin: Float64): Unit {
        this.cjMarkdownCodeBlockTheme.codeBlockLineNumberDividerSpacing = codeMultilineMargin
    }

    /**
     * 设置代码块字体
     *
     * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
     */
    public func setCodeBlockTypeface(codeBlockTypeface: String): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockTextFontFamily(codeBlockTypeface)
    }

    /**
     * 设置代码块代码文本大小
     *
     * @param codeBlockTextSize 代码块代码文本大小 -  默认13.0fp
     */
    public func setCodeBlockTextSize(codeBlockTextSize: Float64): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockTextFontSize(codeBlockTextSize)
    }

    /**
     * 设置代码块代码文本行高
     *
     * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
     */
    public func setCodeBlockLineHeight(codeBlockLineHeight: Float64): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockTextLineHeight(codeBlockLineHeight)
    }

    /**
     * 设置代码块控件圆角大小
     *
     * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
     */
    public func setCodeBlockRadius(codeBlockRadius: Float64): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockAllRadius(codeBlockRadius)
    }

    /**
     * 设置代码块代码全屏按钮是否显示
     *
     * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true：显示；false：不显示。默认true
     */
    public func setIsCodeFullScreen(isCodeFullScreen: Bool): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockCopyButtonIsShow(isCodeFullScreen)
    }

    /**
     * 设置代码块代码全屏、代码复制按钮宽高
     *
     * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
     */
    public func setIconWidthAndHeight(iconWidthAndHeight: Float64): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockCopyIconWidth(iconWidthAndHeight)
        this.cjMarkdownCodeBlockTheme.setCodeBlockCopyIconHeight(iconWidthAndHeight)
        this.cjMarkdownCodeBlockTheme.setCodeBlockFullScreenIconWidth(iconWidthAndHeight)
        this.cjMarkdownCodeBlockTheme.setCodeBlockFullScreenIconHeight(iconWidthAndHeight)
    }

    /**
     * 设置组合代码未选中标题字体大小
     *
     * @param codeListTitleTextSize 组合代码未选中标题字体大小 - 默认13.0fp
     */
    public func setCodeListTitleTextSize(codeListTitleTextSize: Float64): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockListTitleTextSize(codeListTitleTextSize)
    }

    /**
     * 设置组合代码选中标题字体大小
     *
     * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
     */
    public func setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: Float64): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockListTitleSelectTextSize(codeListTitleSelectTextSize)
    }

    /**
     * 设置组合代码选中标题文本颜色
     *
     * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认Color.RED
     */
    public func setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: UInt32): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockListTitleSelectTextColor(codeListTitleSelectTextColor)
    }

    /**
     * 设置组合代码未选中标题文本颜色
     *
     * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认Color.BLACK
     */
    public func setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: UInt32): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockListTitleUnSelectTextColor(codeListTitleUnSelectTextColor)
    }

    /**
     * 设置组合代码选中标题背景颜色
     *
     * @param codeListTitleSelectBackGroupColor 组合代码选中标题背景颜色 - 默认Color.GRAY
     */
    public func setCodeListTitleSelectBackGroupColor(codeListTitleSelectBackGroupColor: UInt32): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockListTitleSelectBackgroupColor(codeListTitleSelectBackGroupColor)
    }

    /**
     * 设置组合代码未选中标题背景颜色
     *
     * @param codeListTitleUnSelectBackGroupColor 组合代码未选中标题背景颜色 - 默认Color.TRANSPARENT
     */
    public func setCodeListTitleUnSelectBackGroupColor(codeListTitleUnSelectBackGroupColor: UInt32): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockListTitleUnSelectBackgroupColor(codeListTitleUnSelectBackGroupColor)
    }

    /**
     * 设置是否单独代码块显示
     *
     * @param isSeparateCodeBlock 是否单独代码块显示 - true：显示；false：不显示。默认false
     */
    public func setIsSeparateCodeBlock(isSeparateCodeBlock: Bool): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockIsSeparate(isSeparateCodeBlock)
    }

    /**
     * 设置单独代码块行号宽度
     *
     * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
     */
    public func setSeparateCodeBlockWidth(separateCodeBlockWidth: Float64): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockSeparateWidth(separateCodeBlockWidth)
    }

    /**
     * 设置单独代码块是否居底显示
     *
     * @param separateCodeIsBottom 单独代码块是否居底显示 - 默认false
     */
    public func setSeparateCodeIsBottom(separateCodeIsBottom: Bool): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockSeparateIsBottom(separateCodeIsBottom)
    }

    /**
     * 设置H1、H2标题下分割线高度
     *
     * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
     */
    public func setHeadingBreakHeight(headingBreakHeight: Float64): Unit {
        this.cjMarkdownHeadingTheme.setUnderlineHeightForAllHeading(headingBreakHeight)
    }

    /**
     * 设置标题文本字体
     *
     * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
     */
    public func setHeadingTypeface(headingTypeface: String): Unit {
        this.cjMarkdownHeadingTheme.setTextFontFamilyForAllHeading(headingTypeface)
    }

    /**
     * 设置标题模块上间距
     *
     * @param headingTopMargins 标题模块上间距 - 默认8.0
     */
    public func setHeadingTopMargins(headingTopMargins: Float64): Unit {
        this.cjMarkdownHeadingTheme.heading1MarginTop = headingTopMargins
        this.cjMarkdownHeadingTheme.heading2MarginTop = headingTopMargins
        this.cjMarkdownHeadingTheme.heading3MarginTop = headingTopMargins
        this.cjMarkdownHeadingTheme.heading4MarginTop = headingTopMargins
        this.cjMarkdownHeadingTheme.heading5MarginTop = headingTopMargins
        this.cjMarkdownHeadingTheme.heading6MarginTop = headingTopMargins
    }

    /**
     * 设置标题模块下间距
     *
     * @param headingBottomMargins 标题模块下间距 - 默认8.0
     */
    public func setHeadingBottomMargins(headingBottomMargins: Float64): Unit {
        this.cjMarkdownHeadingTheme.heading1MarginBottom = headingBottomMargins
        this.cjMarkdownHeadingTheme.heading2MarginBottom = headingBottomMargins
        this.cjMarkdownHeadingTheme.heading3MarginBottom = headingBottomMargins
        this.cjMarkdownHeadingTheme.heading4MarginBottom = headingBottomMargins
        this.cjMarkdownHeadingTheme.heading5MarginBottom = headingBottomMargins
        this.cjMarkdownHeadingTheme.heading6MarginBottom = headingBottomMargins
    }

    /**
     * 设置一级标题文本大小
     *
     * @param headingTextSize1 一级标题文本大小 - 默认20.0
     */
    public func setHeadingTextSize1(headingTextSize1: Float64): Unit {
        this.cjMarkdownHeadingTheme.setTextFontSizeForDesignateHeading(1, headingTextSize1)
    }

    /**
     * 设置二级标题文本大小
     *
     * @param headingTextSize2 二级标题文本大小 - 默认17.0
     */
    public func setHeadingTextSize2(headingTextSize2: Float64): Unit {
        this.cjMarkdownHeadingTheme.setTextFontSizeForDesignateHeading(2, headingTextSize2)
    }

    /**
     * 设置三级标题文本大小
     *
     * @param headingTextSize3 三级标题文本大小 - 默认16.0
     */
    public func setHeadingTextSize3(headingTextSize3: Float64): Unit {
        this.cjMarkdownHeadingTheme.setTextFontSizeForDesignateHeading(3, headingTextSize3)
    }

    /**
     * 设置四级标题文本大小
     *
     * @param headingTextSize4 四级标题文本大小 - 默认15.0
     */
    public func setHeadingTextSize4(headingTextSize4: Float64): Unit {
        this.cjMarkdownHeadingTheme.setTextFontSizeForDesignateHeading(4, headingTextSize4)
    }

    /**
     * 设置五级标题文本大小
     *
     * @param headingTextSize5 五级标题文本大小 - 默认15.0
     */
    public func setHeadingTextSize5(headingTextSize5: Float64): Unit {
        this.cjMarkdownHeadingTheme.setTextFontSizeForDesignateHeading(5, headingTextSize5)
    }

    /**
     * 设置六级标题文本大小
     *
     * @param headingTextSize6 六级标题文本大小 - 默认13.0
     */
    public func setHeadingTextSize6(headingTextSize6: Float64): Unit {
        this.cjMarkdownHeadingTheme.setTextFontSizeForDesignateHeading(6, headingTextSize6)
    }

    /**
     * 设置标题文本字间距
     *
     * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
     */
    public func setHeadingTextWordSpace(headingTextWordSpace: Float64): Unit {
        this.cjMarkdownHeadingTheme.setTextLetterSpacingForAllHeading(headingTextWordSpace)
    }

    /**
     * 设置一级标题文本行高
     *
     * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
     */
    public func setHeadingTextLineHeight1(headingTextLineHeight1: Float64): Unit {
        this.cjMarkdownHeadingTheme.setTextLineHeightForDesignateHeading(1, headingTextLineHeight1)
    }

    /**
     * 设置二级标题文本行高
     *
     * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
     */
    public func setHeadingTextLineHeight2(headingTextLineHeight2: Float64): Unit {
        this.cjMarkdownHeadingTheme.setTextLineHeightForDesignateHeading(2, headingTextLineHeight2)
    }

    /**
     * 设置三级标题文本行高
     *
     * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
     */
    public func setHeadingTextLineHeight3(headingTextLineHeight3: Float64): Unit {
        this.cjMarkdownHeadingTheme.setTextLineHeightForDesignateHeading(3, headingTextLineHeight3)
    }

    /**
     * 设置四级标题文本行高
     *
     * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
     */
    public func setHeadingTextLineHeight4(headingTextLineHeight4: Float64): Unit {
        this.cjMarkdownHeadingTheme.setTextLineHeightForDesignateHeading(4, headingTextLineHeight4)
    }

    /**
     * 设置五级标题文本行高
     *
     * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
     */
    public func setHeadingTextLineHeight5(headingTextLineHeight5: Float64): Unit {
        this.cjMarkdownHeadingTheme.setTextLineHeightForDesignateHeading(5, headingTextLineHeight5)
    }

    /**
     * 设置六级标题文本行高
     *
     * @param headingTextLineHeight1 六级标题文本行高 - 默认22.0vp
     */
    public func setHeadingTextLineHeight6(headingTextLineHeight6: Float64): Unit {
        this.cjMarkdownHeadingTheme.setTextLineHeightForDesignateHeading(6, headingTextLineHeight6)
    }

    /**
     * 设置一级标题文本颜色
     *
     * @param headingTextColor1 一级标题文本颜色
     */
    public func setHeadingTextColor1(headingTextColor1: UInt32): Unit {
        this.cjMarkdownHeadingTheme.setTextFontColorForDesignateHeading(1, headingTextColor1)
    }

    /**
     * 设置H1标题下分割线颜色
     *
     * @param headingBreakColor H1标题下分割线颜色 - 默认0XFF191919
     */
    public func setHeadingBreakColor1(headingBreakColor1: UInt32): Unit {
        this.cjMarkdownHeadingTheme.setUnderlineColorForDesignateHeading(1, headingBreakColor1)
    }

    /**
     * 设置二级标题文本颜色
     *
     * @param headingTextColor2 二级标题文本颜色
     */
    public func setHeadingTextColor2(headingTextColor2: UInt32): Unit {
        this.cjMarkdownHeadingTheme.setTextFontColorForDesignateHeading(2, headingTextColor2)
    }

    /**
     * 设置H2标题下分割线颜色
     *
     * @param headingBreakColor2 H1、H2标题下分割线颜色 - 默认0XFF191919
     */
    public func setHeadingBreakColor2(headingBreakColor2: UInt32): Unit {
        this.cjMarkdownHeadingTheme.setUnderlineColorForDesignateHeading(2, headingBreakColor2)
    }

    /**
     * 设置三级标题文本颜色
     *
     * @param headingTextColor3 三级标题文本颜色
     */
    public func setHeadingTextColor3(headingTextColor3: UInt32): Unit {
        this.cjMarkdownHeadingTheme.setTextFontColorForDesignateHeading(3, headingTextColor3)
    }

    /**
     * 设置四级标题文本颜色
     *
     * @param headingTextColor4 四级标题文本颜色
     */
    public func setHeadingTextColor4(headingTextColor4: UInt32): Unit {
        this.cjMarkdownHeadingTheme.setTextFontColorForDesignateHeading(4, headingTextColor4)
    }

    /**
     * 设置五级标题文本颜色
     *
     * @param headingTextColor5 五级标题文本颜色
     */
    public func setHeadingTextColor5(headingTextColor5: UInt32): Unit {
        this.cjMarkdownHeadingTheme.setTextFontColorForDesignateHeading(5, headingTextColor5)
    }

    /**
     * 设置六级标题文本颜色
     *
     * @param headingTextColor6 六级标题文本颜色
     */
    public func setHeadingTextColor6(headingTextColor6: UInt32): Unit {
        this.cjMarkdownHeadingTheme.setTextFontColorForDesignateHeading(6, headingTextColor6)
    }

    /**
     * 设置段落模块上间距
     *
     * @param paragraphTopMargins 段落模块上间距 - 默认8.0
     */
    public func setParagraphTopMargins(paragraphTopMargins: Float64): Unit {
        this.cjMarkdownParagraphTheme.paragraphMarginTop = paragraphTopMargins
    }

    /**
     * 设置段落模块下间距
     *
     * @param paragraphBottomMargins 段落模块下间距 - 默认8.0
     */
    public func setParagraphBottomMargins(paragraphBottomMargins: Float64): Unit {
        this.cjMarkdownParagraphTheme.paragraphMarginBottom = paragraphBottomMargins
    }

    /**
     * 设置段落文本大小
     *
     * @param paragraphTextSize 段落文本大小 - 默认14.0fp
     */
    public func setParagraphTextSize(paragraphTextSize: Float64): Unit {
        this.cjMarkdownParagraphTheme.setParagraphTextFontSize(paragraphTextSize)
    }

    /**
     * 设置段落文本颜色
     *
     * @param paragraphTextColor 段落文本颜色 - 默认0XFF191919
     */
    public func setParagraphTextColor(paragraphTextColor: UInt32): Unit {
        this.cjMarkdownParagraphTheme.setParagraphTextFontColor(paragraphTextColor)
    }

    /**
     * 设置段落文本字间距
     *
     * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
     */
    public func setParagraphTextWordSpace(paragraphTextWordSpace: Float64): Unit {
        this.cjMarkdownParagraphTheme.setParagraphTextLetterSpacing(paragraphTextWordSpace)
    }

    /**
     * 设置段落文本行高
     *
     * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
     */
    public func setParagraphTextLineHeight(paragraphTextLineHeight: Float64): Unit {
        this.cjMarkdownParagraphTheme.setParagraphTextLineHeight(paragraphTextLineHeight)
    }

    /**
     * 设置段落文本字体
     *
     * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
     */
    public func setParagraphTypeface(paragraphTypeface: String): Unit {
        this.cjMarkdownParagraphTheme.setParagraphTextFontFamily(paragraphTypeface)
    }

    /**
     * 设置分割线颜色
     *
     * @param thematicBreakColor 分割线颜色 - 默认0XFF191919
     */
    public func setThematicBreakColor(thematicBreakColor: UInt32): Unit {
        this.cjMarkdownDividerTheme.setDividerColor(thematicBreakColor)
    }

    /**
     * 设置分割线高度
     *
     * @param thematicBreakHeight 分割线高度 - 默认0.5vp
     */
    public func setThematicBreakHeight(thematicBreakHeight: Float64): Unit {
        this.cjMarkdownDividerTheme.setDividerStrokeWidth(thematicBreakHeight)
    }

    /**
     * 设置分割线上部外边距
     *
     * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
     */
    public func setThematicBreakTopMargin(thematicBreakTopMargin: Float64): Unit {
        this.cjMarkdownDividerTheme.dividerMarginTop = thematicBreakTopMargin
    }

    /**
     * 设置分割线下部外边距
     *
     * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
     */
    public func setThematicBreakBottomMargin(thematicBreakBottomMargin: Float64): Unit {
        this.cjMarkdownDividerTheme.dividerMarginBottom = thematicBreakBottomMargin
    }

    /**
     * 设置软换行是否换行
     *
     * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
     */
    public func setIsLineBreak(isLineBreak: Bool): Unit {
        this.cjMarkdownGlobalTheme.setIsLineBreak(isLineBreak)
    }

    /**
     * 设置数学公式未加载状态是否显示文字
     *
     * @param latexDefaultText 数学公式未加载状态是否显示文字 - 默认true
     */
    public func setLatexDefaultText(latexDefaultText: Bool): Unit {
        this.cjMarkdownLatexMathTheme.setLatexMathDefaultText(latexDefaultText)
    }

    /**
     * 设置数学公式文本大小
     *
     * @param latexMathTextSize 数学公式文本大小 - 默认16.0fp
     */
    public func setLatexMathTextSize(latexMathTextSize: Float64): Unit {
        this.cjMarkdownLatexMathTheme.setLatexMathTextSize(latexMathTextSize)
    }

    /**
     * 设置数学公式背景色
     *
     * @param latexMathBackGroupColor 数学公式背景色 - 默认0xFFFFFFFF
     */
    public func setLatexMathBackGroupColor(latexMathBackGroupColor: UInt32): Unit {
        this.cjMarkdownLatexMathTheme.setLatexMathBackgroundColor(latexMathBackGroupColor)
    }

    /**
     * 设置数学公式文本颜色
     *
     * @param latexMathTextColor 数学公式文本颜色 - 默认0xFF000000
     */
    public func setLatexMathTextColor(latexMathTextColor: UInt32): Unit {
        this.cjMarkdownLatexMathTheme.setLatexMathTextColor(latexMathTextColor)
    }

    /**
     * 设置数学公式生成图片格式
     *
     * @param latexMathColorFormat 数学公式生成图片格式 - 默认LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
     */
    public func setLatexMathColorFormat(latexMathColorFormat: Int64): Unit {
        this.cjMarkdownLatexMathTheme.setLatexMathColorFormat(latexMathColorFormat)
    }

    /**
     * 设置块结构的数学公式是否居中
     *
     * @param latexMathBlockCenter 块结构的数学公式是否居中 - true：居中；false：不居中。默认false
     */
    public func setLatexMathBlockCenter(latexMathBlockCenter: Bool): Unit {
        this.cjMarkdownLatexMathTheme.setLatexMathBlockCenter(latexMathBlockCenter)
    }

    /**
     * 设置数学公式字体路径
     *
     * @param latexMathResStr 数学公式字体路径 默认 "/data/storage/el1/bundle/entry/resources/resfile/res"
     */
    public func setLatexMathResStr(latexMathResStr: String): Unit {
        this.cjMarkdownLatexMathTheme.setLatexMathResPath(latexMathResStr)
    }

    /**
     * 设置音频阴影颜色值
     *
     * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
     */
    public func setAudioShadowColor(audioShadowColor: UInt32): Unit {
        this.cjMarkdownAudioTheme.setAudioShadowColor(audioShadowColor)
    }

    /**
     * 设置音频边框颜色
     *
     * @param audioBorderColor 音频边框颜色 - 默认0x33000000
     */
    public func setAudioBorderColor(audioBorderColor: UInt32): Unit {
        this.cjMarkdownAudioTheme.setAudioBorderColor(audioBorderColor)
    }

    /**
     * 设置音频边框粗细
     *
     * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
     */
    public func setAudioBorderWidth(audioBorderWidth: Float64): Unit {
        this.cjMarkdownAudioTheme.setAudioBorderWidth(audioBorderWidth)
    }

    /**
     * 设置音频边框圆角
     *
     * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
     */
    public func setAudioBorderRadius(audioBorderRadius: Float64): Unit {
        this.cjMarkdownAudioTheme.setAudioBorderAllRadius(audioBorderRadius)
    }

    /**
     * 设置音频按钮背景颜色
     *
     * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认Color.BLACK
     */
    public func setAudioButtonBackgroundColor(audioButtonBackgroundColor: UInt32): Unit {
        this.cjMarkdownAudioTheme.setAudioButtonBackgroundColor(audioButtonBackgroundColor)
    }

    /**
     * 设置音频按钮文字颜色
     *
     * @param audioButtonTextColor 音频按钮文字颜色 - 默认Color.WHITE
     */
    public func setAudioButtonTextColor(audioButtonTextColor: UInt32): Unit {
        this.cjMarkdownAudioTheme.setAudioButtonTextFontColor(audioButtonTextColor)
    }

    /**
     * 设置音频按钮文字大小
     *
     * @param audioButtonTextSize 音频按钮文字大小 - 默认14.0fp
     */
    public func setAudioButtonTextSize(audioButtonTextSize: Float64): Unit {
        this.cjMarkdownAudioTheme.setAudioButtonTextFontSize(audioButtonTextSize)
    }

    /**
     * 设置音频按钮文字内容
     *
     * @param audioButtonText 音频按钮文字内容 - 默认"立即播放"
     */
    public func setAudioButtonText(audioButtonText: String): Unit {
        this.cjMarkdownAudioTheme.setAudioButtonText(audioButtonText)
    }

    /**
     * 设置音频按钮圆角
     *
     * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
     */
    public func setAudioButtonBorderRadius(audioButtonBorderRadius: Float64): Unit {
        this.cjMarkdownAudioTheme.setAudioButtonAllRadius(audioButtonBorderRadius)
    }

    /**
     * 设置音频标题文字大小
     *
     * @param audioTitleTextSize 音频标题文字大小 - 默认15.0fp
     */
    public func setAudioTitleTextSize(audioTitleTextSize: Float64): Unit {
        this.cjMarkdownAudioTheme.setAudioTitleTextFontSize(audioTitleTextSize)
    }

    /**
     * 设置音频标题文字颜色
     *
     * @param audioTitleTextColor音频标题文字颜色 - 默认Color.BLACK
     */
    public func setAudioTitleTextColor(audioTitleTextColor: UInt32): Unit {
        this.cjMarkdownAudioTheme.setAudioTitleTextFontColor(audioTitleTextColor)
    }

    /**
     * 设置音频标题文字行高
     *
     * @param audioTitleTextLineHeight 音频标题文字行高 - 默认20.0vp
     */
    public func setAudioTitleTextLineHeight(audioTitleTextLineHeight: Float64): Unit {
        this.cjMarkdownAudioTheme.setAudioTitleTextLineHeight(audioTitleTextLineHeight)
    }

    /**
     * 设置音频类型文字大小
     *
     * @param audioTypeTextSize 音频类型文字大小 - 默认11.0fp
     */
    public func setAudioTypeTextSize(audioTypeTextSize: Float64): Unit {
        this.cjMarkdownAudioTheme.setAudioTypeTextFontSize(audioTypeTextSize)
    }

    /**
     * 设置音频类型文字颜色
     *
     * @param audioTypeTextColor 音频类型文字颜色 - 默认0X80000000
     */
    public func setAudioTypeTextColor(audioTypeTextColor: UInt32): Unit {
        this.cjMarkdownAudioTheme.setAudioTypeTextFontColor(audioTypeTextColor)
    }

    /**
     * 设置音频类型文字行高
     *
     * @param audioTypeTextLineHeight 音频类型文字行高 - 默认15.0vp
     */
    public func setAudioTypeTextLineHeight(audioTypeTextLineHeight: Float64): Unit {
        this.cjMarkdownAudioTheme.setAudioTypeTextLineHeight(audioTypeTextLineHeight)
    }

    /**
     * 设置音频上边距
     *
     * @param audioMarginTop 音频上边距 - 默认10.0vp
     */
    public func setAudioMarginTop(audioMarginTop: Float64): Unit {
        this.cjMarkdownAudioTheme.audioMarginTop = audioMarginTop
    }

    /**
     * 设置音频下边距
     *
     * @param audioMarginBottom 音频下边距 - 默认10.0vp
     */
    public func setAudioMarginBottom(audioMarginBottom: Float64): Unit {
        this.cjMarkdownAudioTheme.audioMarginBottom = audioMarginBottom
    }

    /**
     * 设置视频圆角
     *
     * @param videoBorderRadius 视频圆角 - 默认10.0vp
     */
    public func setVideoBorderRadius(videoBorderRadius: Float64): Unit {
        this.cjMarkdownVideoTheme.setVideoBorderAllRadius(videoBorderRadius)
    }

    /**
     * 设置视频时间文本颜色
     *
     * @param videoTimeTextColor 视频时间文本颜色 - 默认Color.WHITE
     */
    public func setVideoTimeTextColor(videoTimeTextColor: UInt32): Unit {
        this.cjMarkdownVideoTheme.setVideoTimeTextFontColor(videoTimeTextColor)
    }

    /**
     * 设置视频时间文本大小
     *
     * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
     */
    public func setVideoTimeTextSize(videoTimeTextSize: Float64): Unit {
        this.cjMarkdownVideoTheme.setVideoTimeTextFontSize(videoTimeTextSize)
    }

    /**
     * 设置视频时间文本居右边距
     *
     * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
     */
    public func setVideoTimeTextMarginRight(videoTimeTextMarginRight: Float64): Unit {
        this.cjMarkdownVideoTheme.setVideoTimeTextMarginRight(videoTimeTextMarginRight)
    }

    /**
     * 设置视频时间文本居底边距
     *
     * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
     */
    public func setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: Float64): Unit {
        this.cjMarkdownVideoTheme.setVideoTimeTextMarginBottom(videoTimeTextMarginBottom)
    }

    /**
     * 设置视频上边距
     *
     * @param videoMarginTop 视频上边距 - 默认10.0vp
     */
    public func setVideoMarginTop(videoMarginTop: Float64): Unit {
        this.cjMarkdownVideoTheme.videoMarginTop = videoMarginTop
    }

    /**
     * 设置视频下边距
     *
     * @param videoMarginBottom 视频下边距 - 默认10.0vp
     */
    public func setVideoMarginBottom(videoMarginBottom: Float64): Unit {
        this.cjMarkdownVideoTheme.videoMarginBottom = videoMarginBottom
    }

    /**
     * 设置视频发布/下载按钮布局是否显示
     *
     * @param isVideoBottomLayout 视频发布/下载按钮布局是否显示 - 默认false不显示
     */
    public func setIsVideoBottomLayout(isVideoBottomLayout: Bool): Unit {
        this.cjMarkdownVideoTheme.setVideoBottomLayoutVisible(isVideoBottomLayout)
    }

    /**
     * 设置视频发布按钮图片宽度和高度
     *
     * @param videoReleaseImageWidthHeight 视频发布按钮图片宽度和高度 - 默认18.0vp
     */
    public func setVideoReleaseImageWidthHeight(videoReleaseImageWidthHeight: Float64): Unit {
        this.cjMarkdownVideoTheme.setVideoReleaseButtonIconWidth(videoReleaseImageWidthHeight)
        this.cjMarkdownVideoTheme.setVideoReleaseButtonIconHeight(videoReleaseImageWidthHeight)
    }

    /**
     * 设置视频发布按钮宽度
     *
     * @param videoReleaseWidth 视频发布按钮宽度 - 默认144.0vp
     */
    public func setVideoReleaseWidth(videoReleaseWidth: Float64): Unit {
        this.cjMarkdownVideoTheme.setVideoReleaseButtonWidth(videoReleaseWidth)
    }

    /**
     * 设置视频发布按钮高度
     *
     * @param videoReleaseHeight 视频发布按钮高度 - 默认44.0vp
     */
    public func setVideoReleaseHeight(videoReleaseHeight: Float64): Unit {
        this.cjMarkdownVideoTheme.setVideoReleaseButtonHeight(videoReleaseHeight)
    }

    /**
     * 设置视频发布按钮圆角
     *
     * @param videoReleaseRadius 视频发布按钮圆角 - 默认22.0vp
     */
    public func setVideoReleaseRadius(videoReleaseRadius: Float64): Unit {
        this.cjMarkdownVideoTheme.setVideoReleaseButtonAllRadius(videoReleaseRadius)
    }

    /**
     * 设置视频发布按钮文本内容
     *
     * @param videoReleaseText 视频发布按钮文本内容 - 默认"发布视频"
     */
    public func setVideoReleaseText(videoReleaseText: String): Unit {
        this.cjMarkdownVideoTheme.setVideoReleaseButtonText(videoReleaseText)
    }

    /**
     * 设置视频发布按钮文本大小
     *
     * @param videoReleaseTexSize 视频发布按钮文本大小 - 默认16.0vp
     */
    public func setVideoReleaseTexSize(videoReleaseTexSize: Float64): Unit {
        this.cjMarkdownVideoTheme.setVideoReleaseButtonTextFontSize(videoReleaseTexSize)
    }

    /**
     * 设置视频发布按钮文本颜色
     *
     * @param videoReleaseTexColor 视频发布按钮文本颜色 - 默认0xE6000000
     */
    public func setVideoReleaseTexColor(videoReleaseTexColor: UInt32): Unit {
        this.cjMarkdownVideoTheme.setVideoReleaseButtonTextFontColor(videoReleaseTexColor)
    }

    /**
     * 设置视频发布按钮背景颜色
     *
     * @param videoReleaseBackgroundColor 视频发布按钮背景颜色 - 默认0xFFF5F5F5
     */
    public func setVideoReleaseBackgroundColor(videoReleaseBackgroundColor: UInt32): Unit {
        this.cjMarkdownVideoTheme.setVideoReleaseButtonBackgroundColor(videoReleaseBackgroundColor)
    }

    /**
     * 设置视频下载按钮图片宽度和高度
     *
     * @param videoDownloadImageWidthHeight 视频下载按钮图片宽度和高度 - 默认18.0vp
     */
    public func setVideoDownloadImageWidthHeight(videoDownloadImageWidthHeight: Float64): Unit {
        this.cjMarkdownVideoTheme.setVideoDownloadButtonIconWidth(videoDownloadImageWidthHeight)
        this.cjMarkdownVideoTheme.setVideoDownloadButtonIconHeight(videoDownloadImageWidthHeight)
    }

    /**
     * 设置视频下载按钮宽度
     *
     * @param videoDownloadWidth 视频下载按钮宽度 - 默认144.0vp
     */
    public func setVideoDownloadWidth(videoDownloadWidth: Float64): Unit {
        this.cjMarkdownVideoTheme.setVideoDownloadButtonWidth(videoDownloadWidth)
    }

    /**
     * 设置视频下载按钮高度
     *
     * @param videoDownloadHeight 视频下载按钮高度 - 默认44.0vp
     */
    public func setVideoDownloadHeight(videoDownloadHeight: Float64): Unit {
        this.cjMarkdownVideoTheme.setVideoDownloadButtonHeight(videoDownloadHeight)
    }

    /**
     * 设置视频下载按钮圆角
     *
     * @param videoDownloadRadius 视频下载按钮圆角 - 默认22.0vp
     */
    public func setVideoDownloadRadius(videoDownloadRadius: Float64): Unit {
        this.cjMarkdownVideoTheme.setVideoDownloadButtonAllRadius(videoDownloadRadius)
    }

    /**
     * 设置视频下载按钮文本内容
     *
     * @param videoDownloadText 视频下载按钮文本内容 - 默认"下载视频"
     */
    public func setVideoDownloadText(videoDownloadText: String): Unit {
        this.cjMarkdownVideoTheme.setVideoDownloadButtonText(videoDownloadText)
    }

    /**
     * 设置视频下载按钮文本大小
     *
     * @param videoDownloadTexSize 视频下载按钮文本大小 - 默认16.0vp
     */
    public func setVideoDownloadTexSize(videoDownloadTexSize: Float64): Unit {
        this.cjMarkdownVideoTheme.setVideoDownloadButtonTextFontSize(videoDownloadTexSize)
    }

    /**
     * 设置视频下载按钮文本颜色
     *
     * @param videoDownloadTexColor 视频下载按钮文本颜色 - 默认0xE6000000
     */
    public func setVideoDownloadTexColor(videoDownloadTexColor: UInt32): Unit {
        this.cjMarkdownVideoTheme.setVideoDownloadButtonTextFontColor(videoDownloadTexColor)
    }

    /**
     * 设置视频下载按钮背景颜色
     *
     * @param videoDownloadBackgroundColor 视频下载按钮背景颜色 - 默认0xFFF5F5F5
     */
    public func setVideoDownloadBackgroundColor(videoDownloadBackgroundColor: UInt32): Unit {
        this.cjMarkdownVideoTheme.setVideoDownloadButtonBackgroundColor(videoDownloadBackgroundColor)
    }

    /**
     * 设置图片缩放类型
     *
     * @param imageFitType 图片缩放类型 - 默认ImageFit.Contain
     */
    public func setImageFitType(imageFitType: Int64): Unit {
        this.cjMarkdownImageTheme.setImageFitType(imageFitType)
    }

    /**
     * 设置图片最大宽度百分比
     *
     * @param imageMaximumWidth 图片最大宽度百分比 - 默认1.0
     */
    public func setImageMaximumWidth(imageMaximumWidth: Float64): Unit {
        this.cjMarkdownImageTheme.setImageMaximumWidth(imageMaximumWidth)
    }

    /**
     * 设置图片固定宽度百分比
     *
     * @param imageFixedRatioWidth 图片固定宽度百分比 - 默认None
     */
    public func setImageFixedRatioWidth(imageFixedRatioWidth: Float64): Unit {
        this.cjMarkdownImageTheme.setImageFixedRatioWidth(imageFixedRatioWidth)
    }

    /**
     * 设置图片最大高度
     *
     * @param imageMaxHeight 图片最大高度 - 默认None
     */
    public func setImageMaxHeight(imageMaxHeight: Float64): Unit {
        this.cjMarkdownImageTheme.setImageMaxHeight(imageMaxHeight)
    }

    /**
     * 设置图片最大宽度
     *
     * @param imageMaxWidth 图片最大宽度 - 默认None
     */
    public func setImageMaxWidth(imageMaxWidth: Float64): Unit {
        this.cjMarkdownImageTheme.setImageMaxWidth(imageMaxWidth)
    }

    /**
     * 设置图片圆角大小
     *
     * @param imageBorderRadius 图片圆角大小 - 默认0.0vp
     */
    public func setImageBorderRadius(imageBorderRadius: Float64): Unit {
        this.cjMarkdownImageTheme.setImageBorderAllRadius(imageBorderRadius)
    }

    /**
     * 设置图片边框宽度
     *
     * @param imageBorderWidth 图片边框宽度 - 默认0.0
     */
    public func setImageBorderWidth(imageBorderWidth: Float64): Unit {
        this.cjMarkdownImageTheme.setImageBorderWidth(imageBorderWidth)
    }

    /**
     * 设置图片边框颜色
     *
     * @param imageBorderColor 图片边框颜色 - 默认Color.BLACK
     */
    public func setImageBorderColor(imageBorderColor: UInt32): Unit {
        this.cjMarkdownImageTheme.setImageBorderColor(imageBorderColor)
    }

    /**
     * 设置网络图片是否压缩
     *
     * @param isAutoResize 网络图片是否压缩 - true：压缩；false：不压缩。默认true
     */
    public func setIsAutoResize(isAutoResize: Bool): Unit {
        this.cjMarkdownImageTheme.setImageAutoResize(isAutoResize)
    }

    /**
     * 设置图片上边距
     *
     * @param imageMarginTop 图片上边距 - 默认10.0vp
     */
    public func setImageMarginTop(imageMarginTop: Float64): Unit {
        this.cjMarkdownImageTheme.imageMarginTop = imageMarginTop
    }

    /**
     * 设置图片下边距
     *
     * @param imageMarginBottom 图片下边距 - 默认10.0vp
     */
    public func setImageMarginBottom(imageMarginBottom: Float64): Unit {
        this.cjMarkdownImageTheme.imageMarginBottom = imageMarginBottom
    }

    /**
     * 设置图片是否有下载按钮
     *
     * @param isImageDownload 图片是否有下载按钮 - 默认false
     */
    public func setIsImageDownload(isImageDownload: Bool): Unit {
        this.cjMarkdownImageTheme.setImageDownloadButtonVisible(isImageDownload)
    }

    /**
     * 设置是否图文混排
     *
     * @param isImageMixedLayout 是否图文混排 - 默认true
     */
    public func setIsImageMixedLayout(isImageMixedLayout: Bool): Unit {
        this.cjMarkdownImageTheme.setIsImageMixedLayout(isImageMixedLayout)
    }

    /**
     * 设置图片下载按钮图片宽度和高度
     *
     * @param imageDownloadImageWidthHeight 图片下载按钮图片宽度和高度 - 默认18.0
     */
    public func setImageDownloadImageWidthHeight(imageDownloadImageWidthHeight: Float64): Unit {
        this.cjMarkdownImageTheme.setImageDownloadButtonIconWidth(imageDownloadImageWidthHeight)
        this.cjMarkdownImageTheme.setImageDownloadButtonIconHeight(imageDownloadImageWidthHeight)
    }

    /**
     * 设置图片下载按钮宽度
     *
     * @param imageDownloadWidth 图片下载按钮宽度 - 默认296.0
     */
    public func setImageDownloadWidth(imageDownloadWidth: Float64): Unit {
        this.cjMarkdownImageTheme.setImageDownloadButtonWidth(imageDownloadWidth)
    }

    /**
     * 设置图片下载按钮高度
     *
     * @param imageDownloadHeight 图片下载按钮高度 - 默认44.0
     */
    public func setImageDownloadHeight(imageDownloadHeight: Float64): Unit {
        this.cjMarkdownImageTheme.setImageDownloadButtonHeight(imageDownloadHeight)
    }

    /**
     * 设置图片下载按钮圆角
     *
     * @param imageDownloadRadius 图片下载按钮圆角 - 默认22.0
     */
    public func setImageDownloadRadius(imageDownloadRadius: Float64): Unit {
        this.cjMarkdownImageTheme.setImageDownloadButtonAllRadius(imageDownloadRadius)
    }

    /**
     * 设置图片下载按钮文本内容
     *
     * @param imageDownloadText 图片下载按钮文本内容 - 默认"下载图片"
     */
    public func setImageDownloadText(imageDownloadText: String): Unit {
        this.cjMarkdownImageTheme.setImageDownloadButtonText(imageDownloadText)
    }

    /**
     * 设置图片下载按钮文本大小
     *
     * @param imageDownloadTexSize 图片下载按钮文本大小 - 默认16.0
     */
    public func setImageDownloadTexSize(imageDownloadTexSize: Float64): Unit {
        this.cjMarkdownImageTheme.setImageDownloadButtonTextFontSize(imageDownloadTexSize)
    }

    /**
     * 设置图片下载按钮文本颜色
     *
     * @param imageDownloadTexColor 图片下载按钮文本颜色 - 默认0XE6000000
     */
    public func setImageDownloadTexColor(imageDownloadTexColor: UInt32): Unit {
        this.cjMarkdownImageTheme.setImageDownloadButtonTextFontColor(imageDownloadTexColor)
    }

    /**
     * 设置图片下载按钮背景颜色
     *
     * @param imageDownloadBackgroundColor 图片下载按钮背景颜色 - 默认0XFFF5F5F5
     */
    public func setImageDownloadBackgroundColor(imageDownloadBackgroundColor: UInt32): Unit {
        this.cjMarkdownImageTheme.setImageDownloadButtonBackgroundColor(imageDownloadBackgroundColor)
    }

    /**
     * 设置表格内容内边距
     *
     * @param tableCellPadding 表格内容内边距 - 默认4.0vp
     */
    public func setTableCellPadding(tableCellPadding: Float64): Unit {
        this.cjMarkdownTableTheme.setTableCellAllPadding(tableCellPadding)
    }

    /**
     * 设置表格边框颜色
     *
     * @param tableBorderColor 表格边框颜色 - 默认0XFF000000
     */
    public func setTableBorderColor(tableBorderColor: UInt32): Unit {
        this.cjMarkdownTableTheme.setTableBorderColor(tableBorderColor)
    }

    /**
     * 设置表格边框宽度
     *
     * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
     */
    public func setTableBorderWidth(tableBorderWidth: Float64): Unit {
        this.cjMarkdownTableTheme.setTableBorderWidth(tableBorderWidth)
    }

    /**
     * 设置表格奇数行背景色
     *
     * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0XFFFFFFFF
     */
    public func setTableOddRowBackgroundColor(tableOddRowBackgroundColor: UInt32): Unit {
        this.cjMarkdownTableTheme.setTableContentOddRowBackgroundColor(tableOddRowBackgroundColor)
    }

    /**
     * 设置表格偶数行背景色
     *
     * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0XFFE0E0E0
     */
    public func setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: UInt32): Unit {
        this.cjMarkdownTableTheme.setTableContentEvenRowBackgroundColor(tableEvenRowBackgroundColor)
    }

    /**
     * 设置表格标题背景色
     *
     * @param tableHeaderRowBackgroundColor 表格标题背景色 - 默认0XFFFFFFFF
     */
    public func setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: UInt32): Unit {
        this.cjMarkdownTableTheme.setTableTitleBackgroundColor(tableHeaderRowBackgroundColor)
    }

    /**
     * 设置表格标题文本颜色
     *
     * @param tableTitleTextColor 表格标题文本颜色 - 默认0XFF191919
     */
    public func setTableTitleTextColor(tableTitleTextColor: UInt32): Unit {
        this.cjMarkdownTableTheme.setTableTitleTextFontColor(tableTitleTextColor)
    }

    /**
     * 设置表格标题文本大小
     *
     * @param tableTitleTextSize 表格标题文本大小 - 默认14.0vp
     */
    public func setTableTitleTextSize(tableTitleTextSize: Float64): Unit {
        this.cjMarkdownTableTheme.setTableTitleTextFontSize(tableTitleTextSize)
    }

    /**
     * 设置表格标题文本行高
     *
     * @param tableTitleLineHeight 表格标题文本行高 - 默认22.0vp
     */
    public func setTableTitleLineHeight(tableTitleLineHeight: Float64): Unit {
        this.cjMarkdownTableTheme.setTableTitleTextLineHeight(tableTitleLineHeight)
    }

    /**
     * 设置表格内容文本颜色
     *
     * @param tableContentTextColor 表格内容文本颜色 - 默认0XFF191919
     */
    public func setTableContentTextColor(tableContentTextColor: UInt32): Unit {
        this.cjMarkdownTableTheme.setTableContentTextFontColor(tableContentTextColor)
    }

    /**
     * 设置表格内容文本大小
     *
     * @param tableContentTextSize 表格内容文本大小 - 默认14.0vp
     */
    public func setTableContentTextSize(tableContentTextSize: Float64): Unit {
        this.cjMarkdownTableTheme.setTableContentTextFontSize(tableContentTextSize)
    }

    /**
     * 设置表格文本行高
     *
     * @param tableTextLineHeight 表格文本行高 - 默认22.0vp
     */
    public func setTableTextLineHeight(tableTextLineHeight: Float64): Unit {
        this.cjMarkdownTableTheme.setTableContentTextLineHeight(tableTextLineHeight)
    }

    /**
     * 设置表格圆角
     *
     * @param tableRadius 表格圆角 - 默认5.0vp
     */
    public func setTableRadius(tableRadius: Float64): Unit {
        this.cjMarkdownTableTheme.setTableAllRadius(tableRadius)
    }

    /**
     * 设置表格最小宽度
     *
     * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
     */
    public func setTableMinTextWidth(tableMinTextWidth: Float64): Unit {
        this.cjMarkdownTableTheme.setTableMinCellWidth(tableMinTextWidth)
    }

    /**
     * 设置表格最大宽度
     *
     * @param tableMaxTextWidth 表格最大宽度- 默认300.0vp
     */
    public func setTableMaxTextWidth(tableMaxTextWidth: Float64): Unit {
        this.cjMarkdownTableTheme.setTableMaxCellWidth(tableMaxTextWidth)
    }

    /**
     * 设置表格第一列是否加粗
     *
     * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
     */
    public func setTableFirstColumnBold(tableFirstColumnBold: Bool): Unit {
        this.cjMarkdownTableTheme.setTableFirstColumnIsBold(tableFirstColumnBold)
    }

    /**
     * 设置表格滚动条状态
     *
     * @param tableScrollBarShow 滚动条状态 - 0-显示 1-不显示 2-自动，默认不显示
     */
    public func setTableScrollBarShow(tableScrollBarShow: Int64): Unit {
        this.cjMarkdownTableTheme.setTableScrollBarState(tableScrollBarShow)
    }

    /**
     * 设置表格滚动条颜色
     *
     * @param tableScrollBarColor 表格滚动条颜色
     */
    public func setTableScrollBarColor(tableScrollBarColor: UInt32): Unit {
        this.cjMarkdownTableTheme.setTableScrollBarColor(tableScrollBarColor)
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
        this.cjMarkdownStrikethroughTheme.setStrikethroughTextDecorationColor(strikethroughColor)
    }

    /**
     * 设置删除线样式
     *
     * @param strikethroughStyle 删除线样式 - 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
     */
    public func setStrikethroughStyle(strikethroughStyle: Int32): Unit {
        this.cjMarkdownStrikethroughTheme.setStrikethroughTextDecorationStyle(Int64(strikethroughStyle))
    }

    /**
     * 设置定义列表术语和定义行之间间距
     *
     * @param descListTermAndDefMargins 定义列表定义行缩进 默认8.0
     */
    public func setDescListTermAndDefMargins(descListTermAndDefMargins: Float64): Unit {
        this.cjMarkdownDefinitionListTheme.setDefinitionListTermToDescriptionSpacing(descListTermAndDefMargins)
    }

    /**
     * 设置定义列表定义行缩进
     *
     * @param descListDefIndentation 定义列表定义行缩进 默认8.0
     */
    public func setDescListDefIndentation(descListDefIndentation: Float64): Unit {
        this.cjMarkdownDefinitionListTheme.setDefinitionListDescriptionIndent(descListDefIndentation)
    }

    /**
     * 设置定义列表定义行间距
     *
     * @param descListDefMargins 定义列表定义行间距 默认8.0
     */
    public func setDescListDefMargins(descListDefMargins: Float64): Unit {
        this.cjMarkdownDefinitionListTheme.setDefinitionListDescriptionItemSpacing(descListDefMargins)
    }

    /**
     * 设置下标字体颜色
     *
     * @param subTextColor 下标字体颜色 默认0XFF191919
     */
    public func setSubTextColor(subTextColor: UInt32): Unit {
        this.cjMarkdownSubTheme.setSubTextFontColor(subTextColor)
    }

    /**
     * 设置下标字体大小
     *
     * @param subTextSize 下标字体大小 默认8.0
     */
    public func setSubTextSize(subTextSize: Float64): Unit {
        this.cjMarkdownSubTheme.setSubTextFontSize(subTextSize)
    }

    /**
     * 设置下标偏移距离
     *
     * @param subOffsetDist 下标偏移距离 默认0.0
     */
    public func setSubOffsetDist(subOffsetDist: Float64): Unit {
        this.cjMarkdownSubTheme.setSubTextBaselineOffset(subOffsetDist)
    }

    /**
     * 设置上标字体颜色
     *
     * @param supTextColor 上标字体颜色 默认0XFF191919
     */
    public func setSupTextColor(supTextColor: UInt32): Unit {
        this.cjMarkdownSupTheme.setSupTextFontColor(supTextColor)
    }

    /**
     * 设置上标字体大小
     *
     * @param supTextSize 上标字体大小 默认8.0
     */
    public func setSupTextSize(supTextSize: Float64): Unit {
        this.cjMarkdownSupTheme.setSupTextFontSize(supTextSize)
    }

    /**
     * 设置上标偏移距离
     *
     * @param supOffsetDist 上标偏移距离 默认6.0
     */
    public func setSupOffsetDist(supOffsetDist: Float64): Unit {
        this.cjMarkdownSupTheme.setSupTextFontSize(supOffsetDist)
    }

    /**
     * 设置下划线颜色
     *
     * @param underlineColor 下划线颜色 默认0XFF191919
     */
    public func setUnderlineColor(underlineColor: UInt32): Unit {
        this.cjMarkdownHtmlUnderlineTheme.setHtmlUnderlineTextFontColor(underlineColor)
    }

    /**
     * 设置下划线样式
     *
     * @param underlineStyle 下划线样式 - 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
     */
    public func setUnderlineStyle(underlineStyle: Int32): Unit {
        this.cjMarkdownHtmlUnderlineTheme.setHtmlUnderlineTextDecorationStyle(Int64(underlineStyle))
    }

    /**
     * 设置markdown是否支持滚动手势
     *
     * @param openGestureSwipe true-支持滚动手势，false-不支持滚动手势，默认false
     */
    public func setOpenGestureSwipe(openGestureSwipe: Bool): Unit {
        this.cjMarkdownGlobalTheme.setOpenGestureSwipe(openGestureSwipe)
    }

    /**
     * 设置codeformat是否用制表符
     *
     * @param useTab true-使用，false-不使用，默认false
     */
    public func setUseTab(useTab: Bool): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockUseTab(useTab)
    }

    /**
     * 设置codeformat空格缩进数量
     *
     * @param indentWidth 空格缩进数量，默认4空格
     */
    public func setIndentWidth(indentWidth: Int64): Unit {
        this.cjMarkdownCodeBlockTheme.setCodeBlockIndentWidth(indentWidth)
    }

    /**
     * 设置全局样式
     *
     * @param cjMarkdownGlobalTheme 全局样式
     */
    public func setCJMarkdownGlobalTheme(cjMarkdownGlobalTheme: CJMarkdownGlobalTheme): Unit {
        this.cjMarkdownGlobalTheme = cjMarkdownGlobalTheme
    }

    /**
     * 设置音频样式
     *
     * @param cjMarkdownAudioTheme 全局样式
     */
    public func setCJMarkdownAudioTheme(cjMarkdownAudioTheme: CJMarkdownAudioTheme): Unit {
        this.cjMarkdownAudioTheme = cjMarkdownAudioTheme
    }

    /**
     * 设置加粗文本样式
     *
     * @param cjMarkdownBoldTheme 全局样式
     */
    public func setCJMarkdownBoldTheme(cjMarkdownBoldTheme: CJMarkdownBoldTheme): Unit {
        this.cjMarkdownBoldTheme = cjMarkdownBoldTheme
    }

    /**
     * 设置定义列表样式
     *
     * @param cjMarkdownDefinitionListTheme 定义列表样式
     */
    public func setCJMarkdownDefinitionListTheme(cjMarkdownDefinitionListTheme: CJMarkdownDefinitionListTheme): Unit {
        this.cjMarkdownDefinitionListTheme = cjMarkdownDefinitionListTheme
    }

    /**
     * 设置分割线样式
     *
     * @param  cjMarkdownDividerTheme分割线样式
     */
    public func setCJMarkdownDividerTheme(cjMarkdownDividerTheme: CJMarkdownDividerTheme): Unit {
        this.cjMarkdownDividerTheme = cjMarkdownDividerTheme
    }

    /**
     * 设置脚注定义样式
     *
     * @param cjMarkdownFootnoteDefTheme 脚注定义样式
     */
    public func setCJMarkdownFootnoteDefTheme(cjMarkdownFootnoteDefTheme: CJMarkdownFootnoteDefTheme): Unit {
        this.cjMarkdownFootnoteDefTheme = cjMarkdownFootnoteDefTheme
    }

    /**
     * 设置脚注引用样式
     *
     * @param cjMarkdownFootnoteRefTheme 脚注引用样式
     */
    public func setCJMarkdownFootnoteRefTheme(cjMarkdownFootnoteRefTheme: CJMarkdownFootnoteRefTheme): Unit {
        this.cjMarkdownFootnoteRefTheme = cjMarkdownFootnoteRefTheme
    }

    /**
     * 设置数学公式样式
     *
     * @param cjMarkdownLatexMathTheme 数学公式样式
     */
    public func setCJMarkdownLatexMathTheme(cjMarkdownLatexMathTheme: CJMarkdownLatexMathTheme): Unit {
        this.cjMarkdownLatexMathTheme = cjMarkdownLatexMathTheme
    }

    /**
     * 设置HTML下划线样式
     *
     * @param cjMarkdownHtmlUnderlineTheme HTML下划线样式
     */
    public func setCJMarkdownHtmlUnderlineTheme(cjMarkdownHtmlUnderlineTheme: CJMarkdownHtmlUnderlineTheme): Unit {
        this.cjMarkdownHtmlUnderlineTheme = cjMarkdownHtmlUnderlineTheme
    }

    /**
     * 设置斜体文本样式
     *
     * @param cjMarkdownItalicTheme 斜体文本样式
     */
    public func setCJMarkdownItalicTheme(cjMarkdownItalicTheme: CJMarkdownItalicTheme): Unit {
        this.cjMarkdownItalicTheme = cjMarkdownItalicTheme
    }

    /**
     * 设置删除线文本样式
     *
     * @param cjMarkdownStrikethroughTheme 删除线文本样式
     */
    public func setCJMarkdownStrikethroughTheme(cjMarkdownStrikethroughTheme: CJMarkdownStrikethroughTheme): Unit {
        this.cjMarkdownStrikethroughTheme = cjMarkdownStrikethroughTheme
    }

    /**
     * 设置下标文本样式
     *
     * @param cjMarkdownSubTheme 下标文本样式
     */
    public func setCJMarkdownSubTheme(cjMarkdownSubTheme: CJMarkdownSubTheme): Unit {
        this.cjMarkdownSubTheme = cjMarkdownSubTheme
    }

    /**
     * 设置上标文本样式
     *
     * @param cjMarkdownSupTheme 上标文本样式
     */
    public func setCJMarkdownSupTheme(cjMarkdownSupTheme: CJMarkdownSupTheme): Unit {
        this.cjMarkdownSupTheme = cjMarkdownSupTheme
    }

    /**
     * 设置内联代码样式
     *
     * @param  内联代码样式
     */
    public func setCJMarkdownInlineCodeTheme(cjMarkdownInlineCodeTheme: CJMarkdownInlineCodeTheme): Unit {
        this.cjMarkdownInlineCodeTheme = cjMarkdownInlineCodeTheme
    }

    /**
     * 设置链接文本样式
     *
     * @param cjMarkdownLinkTheme 链接文本样式
     */
    public func setCJMarkdownLinkTheme(cjMarkdownLinkTheme: CJMarkdownLinkTheme): Unit {
        this.cjMarkdownLinkTheme = cjMarkdownLinkTheme
    }

    /**
     * 设置有序列表样式
     *
     * @param cjMarkdownOrderedListTheme 有序列表样式
     */
    public func setCJMarkdownOrderedListTheme(cjMarkdownOrderedListTheme: CJMarkdownOrderedListTheme): Unit {
        this.cjMarkdownOrderedListTheme = cjMarkdownOrderedListTheme
    }

    /**
     * 设置无序/任务列表样式
     *
     * @param cjMarkdownBulletListTheme 无序列表样式
     */
    public func setCJMarkdownBulletListTheme(cjMarkdownBulletListTheme: CJMarkdownBulletListTheme): Unit {
        this.cjMarkdownBulletListTheme = cjMarkdownBulletListTheme
    }

    /**
     * 设置段落样式
     *
     * @param cjMarkdownParagraphTheme 段落样式
     */
    public func setCJMarkdownParagraphTheme(cjMarkdownParagraphTheme: CJMarkdownParagraphTheme): Unit {
        this.cjMarkdownParagraphTheme = cjMarkdownParagraphTheme
    }

    /**
     * 设置视频样式
     *
     * @param cjMarkdownVideoTheme 视频样式
     */
    public func setCJMarkdownVideoTheme(cjMarkdownVideoTheme: CJMarkdownVideoTheme): Unit {
        this.cjMarkdownVideoTheme = cjMarkdownVideoTheme
    }

    /**
     * 设置表格样式
     *
     * @param cjMarkdownTableTheme 表格样式
     */
    public func setCJMarkdownTableTheme(cjMarkdownTableTheme: CJMarkdownTableTheme): Unit {
        this.cjMarkdownTableTheme = cjMarkdownTableTheme
    }

    /**
     * 设置块引用样式
     *
     * @param cjMarkdownBlockQuoteTheme 块引用样式
     */
    public func setCJMarkdownBlockQuoteTheme(cjMarkdownBlockQuoteTheme: CJMarkdownBlockQuoteTheme): Unit {
        this.cjMarkdownBlockQuoteTheme = cjMarkdownBlockQuoteTheme
    }

    /**
     * 设置banner样式
     *
     * @param cjMarkdownBannerTheme banner样式
     */
    public func setCJMarkdownBannerTheme(cjMarkdownBannerTheme: CJMarkdownBannerTheme): Unit {
        this.cjMarkdownBannerTheme = cjMarkdownBannerTheme
    }

    /**
     * 设置图片样式
     *
     * @param cjMarkdownImageTheme 图片样式
     */
    public func setCJMarkdownImageTheme(cjMarkdownImageTheme: CJMarkdownImageTheme): Unit {
        this.cjMarkdownImageTheme = cjMarkdownImageTheme
    }

    /**
     * 设置标题样式
     *
     * @param cjMarkdownHeadingTheme 标题样式
     */
    public func setCJMarkdownHeadingTheme(cjMarkdownHeadingTheme: CJMarkdownHeadingTheme): Unit {
        this.cjMarkdownHeadingTheme = cjMarkdownHeadingTheme
    }

    /**
     * 设置代码块样式
     *
     * @param cjMarkdownCodeBlockTheme 代码块样式
     */
    public func setCJMarkdownCodeBlockTheme(cjMarkdownCodeBlockTheme: CJMarkdownCodeBlockTheme): Unit {
        this.cjMarkdownCodeBlockTheme = cjMarkdownCodeBlockTheme
    }
}
