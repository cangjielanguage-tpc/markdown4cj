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
import std.collection.*
import markdown.components.*
import markdown.core.*
import markdown.plugin.*
import markdown.texttoimg4cj.*

@Component
class CJMarkdownComponent {
    /**
     * 外部传入的Markdown文档
     */
    @State
    @Watch[onChanged]
    var mdStr: String = ''

    /**
     * 配置
     */
    var cfg: ?CJMarkdownConfig

    /**
     * 插件
     */
    var plugin: ?CJMarkdownPlugin

    protected func aboutToAppear(): Unit {
    }

    func build() {
        Column() {
            MarkdownComponent(output: mdStr, markdownConfiguration: setConfig(), markdownPlugin: setPlugin())
        }
    }

    func onChanged(): Unit {
    }

    public func updateMarkDown(input: String) {
        mdStr = input
    }

    public func aboutToCJReuse(input: String) {
        mdStr = input
    }

    public func aboutToCJRecycle(input: String) {
        mdStr = input
    }

    func setPlugin():Markdown{
        let markdownBuilder:MarkdownBuilder = Markdown.builder()
        if(let Some(v) <- plugin){
            if(v.isBlockAudioPlugin){
                markdownBuilder.usePlugin(BlockAudioPlugin.create())
            }
            if(v.isBlockVideoPlugin){
                markdownBuilder.usePlugin(BlockVideoPlugin.create())
            }
            if(v.isCodeListPlugin){
                markdownBuilder.usePlugin(CodeListPlugin.create())
            }
            if(v.isHtmlPlugin){
                markdownBuilder.usePlugin(HtmlPlugin.create())
            }
            if(v.isTablePlugin){
                markdownBuilder.usePlugin(TablePlugin.create())
            }
            if(v.isTaskListPlugin){
                markdownBuilder.usePlugin(TaskListPlugin.create())
            }
            if(v.isStrikethroughPlugin){
                markdownBuilder.usePlugin(StrikethroughPlugin.create())
            }
            if(v.isLinkifyPlugin){
                markdownBuilder.usePlugin(LinkifyPlugin.create())
            }
            if(v.isLinkViewPlugin){
                markdownBuilder.usePlugin(LinkViewPlugin.create())
            }
            if(v.isLatexMathPlugin){
                markdownBuilder.usePlugin(LatexMathPluginV2.create())
            }
            if(v.isImageStylePlugin){
                markdownBuilder.usePlugin(ImageStylePlugin.create())
            }
            if(v.isImageSlidePlugin){
                markdownBuilder.usePlugin(ImageSlidePlugin.create())
            }
            if(v.isImageTextMixPlugin){
                markdownBuilder.usePlugin(ImageTextMixPlugin.create())
            }
            if(v.isDescListPlugin){
                markdownBuilder.usePlugin(DescListPlugin.create())
            }
            if(v.isHeadIDPlugin){
                markdownBuilder.usePlugin(IdHeadingPlugin.create())
            }
            if(v.isTocPlugin){
                markdownBuilder.usePlugin(TocPlugin.create())
            }
            if(v.isFootnotePlugin){
                markdownBuilder.usePlugin(FootnotePlugin.create())
            }
            if(v.isImageCollectPlugin){
                markdownBuilder.usePlugin(ImageCollectPlugin.create())
            }
        }
        // 唯一ID标识插件
        markdownBuilder.usePlugin(NodeIdPlugin.create())
        return markdownBuilder.build()
    }

    func setConfig(): MarkdownConfiguration {
        let markdownConfigurationBuilder: MarkdownConfigurationBuilder = MarkdownConfiguration.emptyBuilder()
        if (let Some(v) <- arkImgPreprocessFunc) {
            markdownConfigurationBuilder.setImageCallbackCallback(v) // 设置图片替换事件
        }
        if(let Some(w) <- cfg){
            markdownConfigurationBuilder.setMarkdownTheme(setTheme()) // 设置markdown默认样式
            if (let Some(v) <- w.linkCallback) {
                markdownConfigurationBuilder.setLinkCallback(v) // 设置链接的点击事件
            }
            if (let Some(v) <- w.textCopyCallback) {
                markdownConfigurationBuilder.setTextCopyCallback(v) // 设置文本复制的点击事件
            }
            if (let Some(v) <- w.imageCallback) {
                markdownConfigurationBuilder.setImageCallback(v) // 设置图片的点击事件
            }
            if (let Some(v) <- w.audioCallback) {
                markdownConfigurationBuilder.setAudioCallback(v) // 设置音频的点击事件
            }
            if (let Some(v) <- w.videoCallback) {
                markdownConfigurationBuilder.setVideoCallback(v) // 设置视频的点击事件
            }
            if (let Some(v) <- w.videoImageCallback) {
                markdownConfigurationBuilder.setVideoImageCallback(v) // 设置视频的图片替换回调
            }
            if (let Some(v) <- w.codeCopyCallback) {
                markdownConfigurationBuilder.setCodeCopyCallback(v) // 设置代码复制按钮的点击事件
            }
            if (let Some(v) <- w.codeFullScreenCallback) {
                markdownConfigurationBuilder.setCodeFullScreenCallback(v) // 设置代码全屏按钮的点击事件
            }
            if (let Some(v) <- w.latexImageCallback) {
                markdownConfigurationBuilder.setLatexImageCallbackCallback(v) // 设置数学公式图片点击事件
            }
            if (let Some(v) <- w.latexStrCallback) {
                markdownConfigurationBuilder.setLatexStrCallback(v) // 设置数学公式数据处理事件
            }
            if (let Some(v) <- w.tocIndexCallback) {
                markdownConfigurationBuilder.setTocIndexCallback(v) // 设置TOC跳转指定位置
            }
            if (let Some(v) <- w.footnoteCallback) {
                markdownConfigurationBuilder.setFootnoteCallback(v) // 设置脚注跳转指定位置
            }
        }
        let markdownConfiguration: MarkdownConfiguration = markdownConfigurationBuilder.build()
        return markdownConfiguration
    }

    func setTheme(): MarkdownTheme {
        let markdownThemeBuilder: MarkdownThemeBuilder = MarkdownTheme.emptyBuilder()
        if (let Some(v) <- GlobalContext.getContext()) {
            markdownThemeBuilder.setStageContext(v) // 设置markdown上下文 - 互操作
        }
        if (let Some(v) <- codeFullScreenIcon) {
            markdownThemeBuilder.setCodeFullScreenIcon(v) // 设置代码块代码全屏按钮默认图标
        }
        if (let Some(v) <- codeCopyIcon) {
            markdownThemeBuilder.setCodeCopyIcon(v) // 设置代码块代码复制按钮默认图标
        }
        if (let Some(v) <- audioIcon) {
            markdownThemeBuilder.setAudioIcon(v) // 设置音频图标
        }
        if (let Some(v) <- videoImage) {
            markdownThemeBuilder.setVideoImage(v) // 设置视频默认占位图
        }
        if (let Some(v) <- playCircleFillIcon) {
            markdownThemeBuilder.setPlayCircleFillIcon(v) // 设置视频播放按钮默认图标
        }
        if (let Some(v) <- bannerImage) {
            markdownThemeBuilder.setBannerImage(v) // 设置图片banner默认占位图
        }
        if (let Some(v) <- imageResource) {
            markdownThemeBuilder.setImageResource(v) // 设置图片默认占位图
        }
        if(let Some(w) <- cfg){
            if (let Some(v) <- w.cjMarkdownTheme.isOnCopy) {
                markdownThemeBuilder.setIsOnCopy(v) // 设置是否打开长按复制粘贴
            }
            if (let Some(v) <- w.cjMarkdownTheme.blockTopAndBottomMargins) {
                markdownThemeBuilder.setBlockTopAndBottomMargins(v) // 设置模块间上下间距
            }
            if (let Some(v) <- w.cjMarkdownTheme.isLinkStyle) {
                markdownThemeBuilder.setIsLinkStyle(v) // 设置链接是否是图片显示
            }
            if (let Some(v) <- w.cjMarkdownTheme.isListLinkStyle) {
                markdownThemeBuilder.setIsListLinkStyle(v) // 设置列表中的单行链接是否是图片显示
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkColor) {
                markdownThemeBuilder.setLinkColor(v) // 设置文本格式链接文本颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.isLinkSize) {
                markdownThemeBuilder.setIsLinkSize(v) // 设置文本格式链接文字大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkSize) {
                markdownThemeBuilder.setLinkSize(v) // 设置文本格式链接文字大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkBackGroupColor) {
                markdownThemeBuilder.setLinkBackGroupColor(v) // 设置文本格式链接背景颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.isLinkUnderlined) {
                markdownThemeBuilder.setIsLinkUnderlined(v) // 设置文本格式是否显示链接下划线
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkCircleImageBackGroupColor) {
                markdownThemeBuilder.setLinkCircleImageBackGroupColor(v) // 设置文本格式是否显示链接下划线
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkCircleImageButtonBackGroupColor) {
                markdownThemeBuilder.setLinkCircleImageButtonBackGroupColor(v) // 设置圆形图片格式链接控件背景颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkCircleImageTextSize) {
                markdownThemeBuilder.setLinkCircleImageTextSize(v) // 设置圆形图片格式链接文字大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkCircleImageTextColor) {
                markdownThemeBuilder.setLinkCircleImageTextColor(v) // 设置圆形图片格式链接文字颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkCircleImageRadius) {
                markdownThemeBuilder.setLinkCircleImageRadius(v) // 设置圆形图片格式链接半径
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkCircleImageMargin) {
                markdownThemeBuilder.setLinkCircleImageMargin(v) // 设置圆形图片格式链接左右外边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectImageBackGroupColor) {
                markdownThemeBuilder.setLinkRectImageBackGroupColor(v) // 设置圆角矩形图片格式链接主题背景颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectImageButtonBackGroupColor) {
                markdownThemeBuilder.setLinkRectImageButtonBackGroupColor(v) // 设置圆角矩形图片格式链接控件背景颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectImageTextSize) {
                markdownThemeBuilder.setLinkRectImageTextSize(v) // 圆角矩形图片格式链接文字大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectImageTextColor) {
                markdownThemeBuilder.setLinkRectImageTextColor(v) // 设置圆角矩形图片格式链接文字颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectImageHeight) {
                markdownThemeBuilder.setLinkRectImageHeight(v) // 圆角矩形图片格式链接控件高度
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectImagePadding) {
                markdownThemeBuilder.setLinkRectImagePadding(v) // 圆角矩形图片格式链接左右内边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectImageRadius) {
                markdownThemeBuilder.setLinkRectImageRadius(v) // 圆角矩形图片格式链接圆角半径
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectImageMargin) {
                markdownThemeBuilder.setLinkRectImageMargin(v) // 圆角矩形图片格式链接左右外边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectToolImageBackGroupColor) {
                markdownThemeBuilder.setLinkRectToolImageBackGroupColor(v) // 设置空心圆角矩形图片格式链接主题背景颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectToolImageButtonBackGroupColor) {
                markdownThemeBuilder.setLinkRectToolImageButtonBackGroupColor(v) // 设置空心圆角矩形图片格式链接控件背景颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectToolImageTextSize) {
                markdownThemeBuilder.setLinkRectToolImageTextSize(v) // 设置空心圆角矩形图片格式链接文字大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectToolImageHeight) {
                markdownThemeBuilder.setLinkRectToolImageHeight(v) // 设置空心圆角矩形图片格式链接控件高度
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectToolImagePadding) {
                markdownThemeBuilder.setLinkRectToolImagePadding(v) // 设置空心圆角矩形图片格式链接左右内边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectToolImageBorderWidth) {
                markdownThemeBuilder.setLinkRectToolImageBorderWidth(v) // 设置空心圆角矩形图片格式链接边框宽度
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectToolImageDividingLineWidth) {
                markdownThemeBuilder.setLinkRectToolImageDividingLineWidth(v) // 设置空心圆角矩形图片格式链接分割线宽度
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectToolImageMargin) {
                markdownThemeBuilder.setLinkRectToolImageMargin(v) // 设置空心圆角矩形图片格式链接左右外边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectToolImageLineLeftPadding) {
                markdownThemeBuilder.setLinkRectToolImageLineLeftPadding(v) // 设置空心圆角矩形图片格式分割线和文本左边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.linkRectToolImageLineRightPadding) {
                markdownThemeBuilder.setLinkRectToolImageLineRightPadding(v) // 设置空心圆角矩形图片格式分割线和文本右边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.blockQuoteLeftMargin) {
                markdownThemeBuilder.setBlockQuoteLeftMargin(v) // 设置块引用左边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.blockQuoteRightMargin) {
                markdownThemeBuilder.setBlockQuoteRightMargin(v) // 设置块引用右边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.blockQuoteWidth) {
                markdownThemeBuilder.setBlockQuoteWidth(v) // 设置块引用左边线条宽度
            }
            if (let Some(v) <- w.cjMarkdownTheme.blockQuoteColor) {
                markdownThemeBuilder.setBlockQuoteColor(v) // 设置块引用左边线条颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.blockQuoteBackGroupColor) {
                markdownThemeBuilder.setBlockQuoteBackGroupColor(v) // 设置块引用背景颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.blockQuoteTopAndBottomMargins) {
                markdownThemeBuilder.setBlockQuoteTopAndBottomMargins(v) // 设置块引用子模块上下间距
            }
            if (let Some(v) <- w.cjMarkdownTheme.blockOrderedAndBulletTopAndBottomMargins) {
                markdownThemeBuilder.setBlockOrderedAndBulletTopAndBottomMargins(v) // 设置有序列表、无序列表、任务列表子模块上下间距
            }
            if (let Some(v) <- w.cjMarkdownTheme.blockLeftMargin) {
                markdownThemeBuilder.setBlockLeftMargin(v) // 设置有序列表、无序列表、任务列表左边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.blockRightMargin) {
                markdownThemeBuilder.setBlockRightMargin(v) // 设置有序列表、无序列表、任务列表右边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.orderedListItemPrefixBold) {
                markdownThemeBuilder.setOrderedListItemPrefixBold(v) // 设置有序列表前缀文本是否加粗
            }
            if (let Some(v) <- w.cjMarkdownTheme.orderedListItemColor) {
                markdownThemeBuilder.setOrderedListItemColor(v) // 设置有序列表前缀文本颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.orderedListItemSize) {
                markdownThemeBuilder.setOrderedListItemSize(v) // 设置有序列表前缀文本大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.orderedListItemLineHeight) {
                markdownThemeBuilder.setOrderedListItemLineHeight(v) // 设置有序列表前缀文本行高
            }
            if (let Some(v) <- w.cjMarkdownTheme.bulletListItemCircle) {
                markdownThemeBuilder.setBulletListItemCircle(v) // 设置无序列表前缀是否全部是实心圆型
            }
            if (let Some(v) <- w.cjMarkdownTheme.bulletListItemColor) {
                markdownThemeBuilder.setBulletListItemColor(v) // 设置无序列表前缀文本颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.bulletListItemSize) {
                markdownThemeBuilder.setBulletListItemSize(v) // 设置无序列表前缀文本大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.bulletListItemLineHeight) {
                markdownThemeBuilder.setBulletListItemLineHeight(v) // 设置无序列表前缀文本行高
            }
            if (let Some(v) <- w.cjMarkdownTheme.taskListItemLength) {
                markdownThemeBuilder.setTaskListItemLength(v) // 设置任务列表选择框宽高
            }
            if (let Some(v) <- w.cjMarkdownTheme.isCodeStyle) {
                markdownThemeBuilder.setIsCodeStyle(v) // 设置内联代码是否是图片显示
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeTextColor) {
                markdownThemeBuilder.setCodeTextColor(v) // 设置文本、图片格式内联代码文本颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeBackgroundColor) {
                markdownThemeBuilder.setCodeBackgroundColor(v) // 设置文本、图片格式内联代码背景颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeTextSize) {
                markdownThemeBuilder.setCodeTextSize(v) // 设置文本、图片格式内联代码文本大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeTypeface) {
                markdownThemeBuilder.setCodeTypeface(v) // 设置文本格式内联代码文本字体
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeLeftAndRightPadding) {
                markdownThemeBuilder.setCodeLeftAndRightPadding(v) // 设置图片格式内联代码文本左右边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeHeight) {
                markdownThemeBuilder.setCodeHeight(v) // 设置图片格式内联代码文本高度
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeBlockTextColor) {
                markdownThemeBuilder.setCodeBlockTextColor(v) // 设置代码块代码文本颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeBlockTypeTextColor) {
                markdownThemeBuilder.setCodeBlockTypeTextColor(v) // 设置代码块代码类型文本颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeBlockTypeTextStr) {
                markdownThemeBuilder.setCodeBlockTypeTextStr(v) // 设置代码块代码类型文本
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeBlockTypeTextPadding) {
                markdownThemeBuilder.setCodeBlockTypeTextPadding(v) // 设置代码类型和代码块距离
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeBlockIconTextHide) {
                markdownThemeBuilder.setCodeBlockIconTextHide(v) // 设置代码块复制、全屏图片文字是否显示
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeBlockLineNumberHide) {
                markdownThemeBuilder.setCodeBlockLineNumberHide(v) // 设置代码块代码行号是否显示
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeBlockBackgroundColor) {
                markdownThemeBuilder.setCodeBlockBackgroundColor(v) // 设置代码块背景颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeMultilineMargin) {
                markdownThemeBuilder.setCodeMultilineMargin(v) // 设置代码块左边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeBlockTypeface) {
                markdownThemeBuilder.setCodeBlockTypeface(v) // 设置代码块字体
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeBlockTextSize) {
                markdownThemeBuilder.setCodeBlockTextSize(v) // 设置代码块代码文本大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeBlockLineHeight) {
                markdownThemeBuilder.setCodeBlockLineHeight(v) // 设置代码块代码文本行高
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeBlockRadius) {
                markdownThemeBuilder.setCodeBlockRadius(v) // 设置代码块控件圆角大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.isCodeFullScreen) {
                markdownThemeBuilder.setIsCodeFullScreen(v) // 设置代码块代码全屏按钮是否显示
            }
            if (let Some(v) <- w.cjMarkdownTheme.iconWidthAndHeight) {
                markdownThemeBuilder.setIconWidthAndHeight(v) // 设置代码块代码全屏、代码复制按钮宽高
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeListTitleTextSize) {
                markdownThemeBuilder.setCodeListTitleTextSize(v) // 设置组合代码未选中标题字体大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeListTitleSelectTextSize) {
                markdownThemeBuilder.setCodeListTitleSelectTextSize(v) // 设置组合代码选中标题字体大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeListTitleSelectTextColor) {
                markdownThemeBuilder.setCodeListTitleSelectTextColor(v) // 设置组合代码选中标题文本颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeListTitleUnSelectTextColor) {
                markdownThemeBuilder.setCodeListTitleUnSelectTextColor(v) // 设置组合代码未选中标题文本颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeListTitleSelectBackGroupColor) {
                markdownThemeBuilder.setCodeListTitleSelectBackGroupColor(v) // 设置组合代码选中标题背景颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.codeListTitleUnSelectBackGroupColor) {
                markdownThemeBuilder.setCodeListTitleUnSelectBackGroupColor(v) // 设置组合代码未选中标题背景颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.isSeparateCodeBlock) {
                markdownThemeBuilder.setIsSeparateCodeBlock(v) // 设置是否单独代码块显示
            }
            if (let Some(v) <- w.cjMarkdownTheme.separateCodeBlockWidth) {
                markdownThemeBuilder.setSeparateCodeBlockWidth(v) // 设置单独代码块行号宽度
            }
            if (let Some(v) <- w.cjMarkdownTheme.separateCodeIsBottom) {
                markdownThemeBuilder.setSeparateCodeIsBottom(v) // 设置单独代码块是否居底显示
            }
            if (let Some(v) <- w.cjMarkdownTheme.headingBreakHeight) {
                markdownThemeBuilder.setHeadingBreakHeight(v) // 设置H1、H2标题下分割线高度
            }
            if (let Some(v) <- w.cjMarkdownTheme.headingBreakColor) {
                markdownThemeBuilder.setHeadingBreakColor(v) // 设置H1、H2标题下分割线颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.headingTypeface) {
                markdownThemeBuilder.setHeadingTypeface(v) // 设置标题文本字体
            }
            if (let Some(v) <- w.cjMarkdownTheme.headingTopMargins) {
                markdownThemeBuilder.setHeadingTopMargins(v) // 设置标题模块上间距
            }
            if (let Some(v) <- w.cjMarkdownTheme.headingBottomMargins) {
                markdownThemeBuilder.setHeadingBottomMargins(v) // 设置标题模块下间距
            }
            if (let Some(v) <- w.cjMarkdownTheme.headingTextSizeMultipliers) {
                markdownThemeBuilder.setHeadingTextSizeMultipliers(v) // 设置标题文本大小数组
            }
            if (let Some(v) <- w.cjMarkdownTheme.headingTextColor) {
                markdownThemeBuilder.setHeadingTextColor(v) // 设置标题文本颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.headingTextWordSpace) {
                markdownThemeBuilder.setHeadingTextWordSpace(v) // 设置标题文本字间距
            }
            if (let Some(v) <- w.cjMarkdownTheme.headingTextLineHeight1) {
                markdownThemeBuilder.setHeadingTextLineHeight1(v) // 设置一级标题文本行高
            }
            if (let Some(v) <- w.cjMarkdownTheme.headingTextLineHeight2) {
                markdownThemeBuilder.setHeadingTextLineHeight2(v) // 设置二级标题文本行高
            }
            if (let Some(v) <- w.cjMarkdownTheme.headingTextLineHeight3) {
                markdownThemeBuilder.setHeadingTextLineHeight3(v) // 设置三级标题文本行高
            }
            if (let Some(v) <- w.cjMarkdownTheme.headingTextLineHeight4) {
                markdownThemeBuilder.setHeadingTextLineHeight4(v) // 设置四级标题文本行高
            }
            if (let Some(v) <- w.cjMarkdownTheme.headingTextLineHeight5) {
                markdownThemeBuilder.setHeadingTextLineHeight5(v) // 设置五级标题文本行高
            }
            if (let Some(v) <- w.cjMarkdownTheme.headingTextLineHeight6) {
                markdownThemeBuilder.setHeadingTextLineHeight6(v) // 设置六级标题文本行高
            }
            if (let Some(v) <- w.cjMarkdownTheme.paragraphTopMargins) {
                markdownThemeBuilder.setParagraphTopMargins(v) // 设置段落模块上间距
            }
            if (let Some(v) <- w.cjMarkdownTheme.paragraphBottomMargins) {
                markdownThemeBuilder.setParagraphBottomMargins(v) // 设置段落模块下间距
            }
            if (let Some(v) <- w.cjMarkdownTheme.paragraphTextSize) {
                markdownThemeBuilder.setParagraphTextSize(v) // 设置段落文本大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.paragraphTextColor) {
                markdownThemeBuilder.setParagraphTextColor(v) // 设置段落文本颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.paragraphTextWordSpace) {
                markdownThemeBuilder.setParagraphTextWordSpace(v) // 设置段落文本字间距
            }
            if (let Some(v) <- w.cjMarkdownTheme.paragraphTextLineHeight) {
                markdownThemeBuilder.setParagraphTextLineHeight(v) // 设置段落文本行高
            }
            if (let Some(v) <- w.cjMarkdownTheme.paragraphTypeface) {
                markdownThemeBuilder.setParagraphTypeface(v) // 设置段落文本字体
            }
            if (let Some(v) <- w.cjMarkdownTheme.thematicBreakColor) {
                markdownThemeBuilder.setThematicBreakColor(v) // 设置分割线颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.thematicBreakHeight) {
                markdownThemeBuilder.setThematicBreakHeight(v) // 设置分割线高度
            }
            if (let Some(v) <- w.cjMarkdownTheme.thematicBreakTopMargin) {
                markdownThemeBuilder.setThematicBreakTopMargin(v) // 设置分割线上部外边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.thematicBreakBottomMargin) {
                markdownThemeBuilder.setThematicBreakBottomMargin(v) // 设置分割线下部外边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.isLineBreak) {
                markdownThemeBuilder.setIsLineBreak(v) // 设置软换行是否换行
            }
            if (let Some(v) <- w.cjMarkdownTheme.latexMathTextSize) {
                markdownThemeBuilder.setLatexMathTextSize(v) // 设置数学公式文本大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.latexMathBackGroupColor) {
                markdownThemeBuilder.setLatexMathBackGroupColor(v) // 设置数学公式背景色
            }
            if (let Some(v) <- w.cjMarkdownTheme.latexMathTextColor) {
                markdownThemeBuilder.setLatexMathTextColor(v) // 设置数学公式文本颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.latexMathColorFormat) {
                markdownThemeBuilder.setLatexMathColorFormat(v) // 设置数学公式生成图片格式
            }
            if (let Some(v) <- w.cjMarkdownTheme.latexMathBlockCenter) {
                markdownThemeBuilder.setLatexMathBlockCenter(v) // 设置块结构的数学公式是否居中
            }
            if (let Some(v) <- w.cjMarkdownTheme.latexMathResStr) {
                markdownThemeBuilder.setLatexMathResStr(v) // 设置数学公式字体路径
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioShadowColor) {
                markdownThemeBuilder.setAudioShadowColor(v) // 设置音频阴影颜色值
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioBorderColor) {
                markdownThemeBuilder.setAudioBorderColor(v) // 设置音频边框颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioBorderWidth) {
                markdownThemeBuilder.setAudioBorderWidth(v) // 设置音频边框粗细
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioBorderRadius) {
                markdownThemeBuilder.setAudioBorderRadius(v) // 设置音频边框圆角
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioButtonBackgroundColor) {
                markdownThemeBuilder.setAudioButtonBackgroundColor(v) // 设置音频按钮背景颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioButtonTextColor) {
                markdownThemeBuilder.setAudioButtonTextColor(v) // 设置音频按钮文字颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioButtonTextSize) {
                markdownThemeBuilder.setAudioButtonTextSize(v) // 设置音频按钮文字大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioButtonText) {
                markdownThemeBuilder.setAudioButtonText(v) // 设置音频按钮文字内容
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioButtonBorderRadius) {
                markdownThemeBuilder.setAudioButtonBorderRadius(v) // 设置音频按钮圆角
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioTitleTextSize) {
                markdownThemeBuilder.setAudioTitleTextSize(v) // 设置音频标题文字大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioTitleTextColor) {
                markdownThemeBuilder.setAudioTitleTextColor(v) // 设置音频标题文字颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioTitleTextLineHeight) {
                markdownThemeBuilder.setAudioTitleTextLineHeight(v) // 设置音频标题文字行高
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioTypeTextSize) {
                markdownThemeBuilder.setAudioTypeTextSize(v) // 设置音频类型文字大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioTypeTextColor) {
                markdownThemeBuilder.setAudioTypeTextColor(v) // 设置音频类型文字颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioTypeTextLineHeight) {
                markdownThemeBuilder.setAudioTypeTextLineHeight(v) // 设置音频类型文字行高
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioMarginTop) {
                markdownThemeBuilder.setAudioMarginTop(v) // 设置音频上边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.audioMarginBottom) {
                markdownThemeBuilder.setAudioMarginBottom(v) // 设置音频下边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.videoBorderRadius) {
                markdownThemeBuilder.setVideoBorderRadius(v) // 设置视频圆角
            }
            if (let Some(v) <- w.cjMarkdownTheme.videoTimeTextColor) {
                markdownThemeBuilder.setVideoTimeTextColor(v) // 设置视频时间文本颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.videoTimeTextSize) {
                markdownThemeBuilder.setVideoTimeTextSize(v) // 设置视频时间文本大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.videoTimeTextMarginRight) {
                markdownThemeBuilder.setVideoTimeTextMarginRight(v) // 设置视频时间文本居右边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.videoTimeTextMarginBottom) {
                markdownThemeBuilder.setVideoTimeTextMarginBottom(v) // 设置视频时间文本居底边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.videoMarginTop) {
                markdownThemeBuilder.setVideoMarginTop(v) // 设置视频上边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.videoMarginBottom) {
                markdownThemeBuilder.setVideoMarginBottom(v) // 设置视频下边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.imageFitType) {
                markdownThemeBuilder.setImageFitType(v) // 设置图片缩放类型
            }
            if (let Some(v) <- w.cjMarkdownTheme.imageMaximumWidth) {
                markdownThemeBuilder.setImageMaximumWidth(v) // 设置图片基于自身宽度缩放百分比
            }
            if (let Some(v) <- w.cjMarkdownTheme.imageFixedRatioWidth) {
                markdownThemeBuilder.setImageFixedRatioWidth(v) // 设置图片基于父布局宽度缩放百分比
            }
            if (let Some(v) <- w.cjMarkdownTheme.imageBorderRadius) {
                markdownThemeBuilder.setImageBorderRadius(v) // 设置图片圆角大小
            }
            if (let Some(v) <- w.cjMarkdownTheme.isAutoResize) {
                markdownThemeBuilder.setIsAutoResize(v) // 设置网络图片是否压缩
            }
            if (let Some(v) <- w.cjMarkdownTheme.imageMarginTop) {
                markdownThemeBuilder.setImageMarginTop(v) // 设置图片上边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.imageMarginBottom) {
                markdownThemeBuilder.setImageMarginBottom(v) // 设置图片下边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.tableCellPadding) {
                markdownThemeBuilder.setTableCellPadding(v) // 设置表格内容内边距
            }
            if (let Some(v) <- w.cjMarkdownTheme.tableBorderColor) {
                markdownThemeBuilder.setTableBorderColor(v) // 设置表格边框颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.tableBorderWidth) {
                markdownThemeBuilder.setTableBorderWidth(v) // 设置表格边框宽度
            }
            if (let Some(v) <- w.cjMarkdownTheme.tableOddRowBackgroundColor) {
                markdownThemeBuilder.setTableOddRowBackgroundColor(v) // 设置表格奇数行背景色
            }
            if (let Some(v) <- w.cjMarkdownTheme.tableEvenRowBackgroundColor) {
                markdownThemeBuilder.setTableEvenRowBackgroundColor(v) // 设置表格偶数行背景色
            }
            if (let Some(v) <- w.cjMarkdownTheme.tableHeaderRowBackgroundColor) {
                markdownThemeBuilder.setTableHeaderRowBackgroundColor(v) // 设置表格头背景色
            }
            if (let Some(v) <- w.cjMarkdownTheme.tableTextLineHeight) {
                markdownThemeBuilder.setTableTextLineHeight(v) // 设置表格文本行高
            }
            if (let Some(v) <- w.cjMarkdownTheme.tableRadius) {
                markdownThemeBuilder.setTableRadius(v) // 设置表格圆角
            }
            if (let Some(v) <- w.cjMarkdownTheme.tableMinTextWidth) {
                markdownThemeBuilder.setTableMinTextWidth(v) // 设置表格最小宽度
            }
            if (let Some(v) <- w.cjMarkdownTheme.tableMaxTextWidth) {
                markdownThemeBuilder.setTableMaxTextWidth(v) // 设置表格最大宽度
            }
            if (let Some(v) <- w.cjMarkdownTheme.tableFirstColumnBold) {
                markdownThemeBuilder.setTableFirstColumnBold(v) // 设置表格第一列是否加粗
            }
            if (let Some(v) <- w.cjMarkdownTheme.isDark) {
                // 设置markdown代码高亮样式
                if(v){
                    markdownThemeBuilder.setPrismTheme(PrismThemeDarkula.create()) // 深色
                }else{
                    markdownThemeBuilder.setPrismTheme(PrismThemeDefault.create()) // 浅色
                }
            }
            if (let Some(v) <- w.cjMarkdownTheme.strikethroughColor) {
                markdownThemeBuilder.setStrikethroughColor(v) // 设置删除线颜色
            }
            if (let Some(v) <- w.cjMarkdownTheme.descListTermAndDefMargins) {
                markdownThemeBuilder.setDescListTermAndDefMargins(v) // 设置定义列表术语和定义行之间间距
            }
            if (let Some(v) <- w.cjMarkdownTheme.descListDefIndentation) {
                markdownThemeBuilder.setDescListDefIndentation(v) // 设置定义列表定义行缩进
            }
            if (let Some(v) <- w.cjMarkdownTheme.descListDefMargins) {
                markdownThemeBuilder.setDescListDefMargins(v) // 设置定义列表定义行间距
            }
        }
        let markdownTheme: MarkdownTheme = markdownThemeBuilder.build()
        return markdownTheme
    }
}
