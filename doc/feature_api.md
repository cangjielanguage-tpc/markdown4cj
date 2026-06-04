# Markdown API

## UI使用接口

### class CJMarkdown

Markdown预览自定义控件

```ets
/**
 * Markdown预览自定义控件
 */
@Component
export struct CJMarkdown {
    /**
    * 初始化Markdown自定义控件
    *
    * @param content 传入markdown文档内容
    * @param isInputEnded 流式输入是否输入结束。true:结束输入,false:持续输入。默认true
    * @param incrementalAnalysis markdown是否增量解析。true:增量解析,false:全量解析。默认false
    * @param config 传入markdown配置选项
    * @param plugin 传入markdown插件化选项
    * @param listScroller 滑动控制器
    * @param useCangjieComponent 是否使用Cangjie互操作组件展示。true:使用Cangjie互操作组件,false:使用ArkUI。默认true
    * @param customContains 使用ArkUI布局用户传入ArkUI自定义组件,不传则使用三方库自带的Text组件显示
    */
    CJMarkdown(
        content: string,
        isInputEnded?: boolean,
        incrementalAnalysis?: boolean,
        config?: MarkdownConfiguration,
        plugin?: MarkdownPlugin,
        listScroller?: MarkdownScroller,
        useCangjieComponent?: boolean,
        customContains?: () => void
    )
}
```

## Markdown配置接口

### class MarkdownConfiguration

Markdown配置

```ets
/**
 * markdown配置
 */
export class MarkdownConfiguration {
  /**
   * 设置链接点击回调
   *
   * @param cb 链接点击回调(url：链接url)
   */
  setLinkCallback(cb: (url: string) => void): void

  /**
   * 设置文本复制的点击事件
   *
   * @param cb 文本复制的点击事件(text：复制的文本)
   */
  setTextCopyCallback(cb: (text: string) => void): void

  /**
   * 设置图片点击回调
   *
   * @param cb 图片点击回调。 (url：图片url,urlList：所有图片和视频链接集合 --- 需要加载图片视频列表url集合列表解析插件)
   */
  setImageCallback(cb: (url: string, urlList: Array<string>) => void): void

  /**
   * 设置图片替换事件
   *
   * @param cb 图片替换事件。 (url：图片url 返回值是替换的图片数据)
   * @useinstead MarkdownConfiguration#setImageReplaceCallback
   */
  setImageCallbackCallback(cb: (url: string) => Promise<ArrayBuffer | undefined>): void

  /**
   * 设置图片替换事件
   *
   * @param cb 图片替换事件。 (url：图片url 返回值是替换的图片数据)
   */
  setImageReplaceCallback (cb: (url: string) => Promise<ArrayBuffer | undefined>): void
  
  /**
   * 设置图片下载的点击事件
   *
   * @param cb 图片下载的点击事件。 (url：图片url)
   */
  setImageDownloadCallback(cb: (url: string) => void): void

  /**
   * 设置音频点击回调
   *
   * @param cb 音频点击回调(url：音频url) --- 需要加载音频解析插件
   */
  setAudioCallback(cb: (url: string) => void): void

  /**
   * 设置视频点击回调
   *
   * @param cb 视频点击回调。 (url：视频url,urlList：所有图片和视频链接集合 --- 需要加载图片视频列表url集合列表解析插件) --- 需要加载视频解析插件
   */
  setVideoCallback(cb: (url: string, urlList: Array<string>) => void): void

  /**
   * 设置视频占位图和宽高比和视频时长的回调
   *
   * @param cb 视频占位图和宽高比和视频时长回调。 (url：视频url,coverCallback：视频占位图和宽高比和视频时长回调 (coverUrl：视频首帧图,aspectRatio：图片宽高比,duration：视频时长)) --- 需要加载视频解析插件
   */
  setVideoImageCallback(cb: (url: string, coverCallback: (coverUrl: string, aspectRatio: number, duration: number) => void) => void): void

  /**
   * 设置视频发布的点击事件
   *
   * @param cb 视频发布的点击事件(url：视频url) --- 需要加载视频解析插件
   */
  setVideoReleaseCallback(cb: (url: string) => void): void

  /**
   * 设置视频下载的点击事件
   *
   * @param cb 视频下载的点击事件(url：视频url) --- 需要加载视频解析插件
   */
  setVideoDownloadCallback(cb: (url: string) => void): void

  /**
   * 设置代码复制点击回调
   *
   * @param cb 代码复制点击回调(code：代码内容)
   */
  setCodeCopyCallback(cb: (code: string) => void): void

  /**
   * 设置代码全屏点击回调
   *
   * @param cb 代码全屏点击回调(code：代码内容, language：代码类型)
   */
  setCodeFullScreenCallback(cb: (code: string, language: string | undefined) => void): void

  /**
   * 设置数学公式点击回调
   *
   * @param cb 数学公式点击回调(imageData：数学公式图片数组数据, height：图片高度, width：图片宽度) --- 需要加载数学公式解析插件
   */
  setLatexImageCallback(cb: (imageData: ArrayBuffer, height: number, width: number) => void): void

  /**
   * 设置数学公式公式预处理回调
   *
   * @param cb 数学公式公式预处理回调(formula：数学公式文本内容,return：处理过后的数学公式文本) --- 需要加载数学公式解析插件
   */
  setLatexStrCallback(cb: (formula: string) => string): void

  /**
   * 设置TOC点击回调
   *
   * @param cb TOC点击回调(index：第几条数据) --- 需要加载TOC解析插件
   */
  setTocIndexCallback(cb: (index: number | undefined) => void): void

  /**
   * 设置脚注点击回调
   *
   * @param cb 脚注点击回调(index：第几条数据) --- 需要加载脚注解析插件
   */
  setFootnoteCallback(cb: (index: number | undefined) => void): void

  /**
   * 设置全局文本对象
   *
   * @param nodeString 全局文本对象
   */
  setNodeString(nodeString: MarkdownNodeViewString): void

  /**
   * 设置markdown样式
   *
   * @param markdownTheme markdown样式
   */
  setMarkdownTheme(markdownTheme: MarkdownTheme): void
}
```

## Markdown样式配置类

### class MarkdownTheme

Markdown用户可设置的样式

```ets
/**
 * Markdown用户可设置的样式
 */
export class MarkdownTheme {
  /**
   * 设置上下文
   *
   * @param context 上下文
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setStageContext
   */
  setContext(context: Context): void

  /**
   * 设置浅色主题整体样式
   */
  setDefaultTheme(): void
  
  /**
   * 设置深色主题整体样式
   */
  setDarculaTheme(): void
  
  /**
   * 设置全局样式
   *
   * @param markdownThemeGlobal 全局样式
   */
  setMarkdownThemeGlobal(markdownThemeGlobal: MarkdownThemeGlobal): void

  /**
   * 设置音频样式
   *
   * @param markdownThemeAudio 音频样式
   */
  setMarkdownThemeAudio(markdownThemeAudio: MarkdownThemeAudio): void

  /**
   * 设置Banner样式
   *
   * @param markdownThemeBanner Banner样式
   */
  setMarkdownThemeBanner(markdownThemeBanner: MarkdownThemeBanner): void

  /**
   * 设置块引用样式
   *
   * @param markdownThemeBlockQuote 块引用样式
   */
  setMarkdownThemeBlockQuote(markdownThemeBlockQuote: MarkdownThemeBlockQuote): void

  /**
   * 设置加粗文本样式
   *
   * @param markdownThemeBold 加粗文本样式
   */
  setMarkdownThemeBold(markdownThemeBold: MarkdownThemeBold): void

  /**
   * 设置代码块样式
   *
   * @param markdownThemeCodeBlock 代码块样式
   */
  setMarkdownThemeCodeBlock(markdownThemeCodeBlock: MarkdownThemeCodeBlock): void

  /**
   * 设置定义列表样式
   *
   * @param markdownThemeDefinitionList 定义列表样式
   */
  setMarkdownThemeDefinitionList(markdownThemeDefinitionList: MarkdownThemeDefinitionList): void

  /**
   * 设置分割线样式
   *
   * @param markdownThemeDivider 分割线样式
   */
  setMarkdownThemeDivider(markdownThemeDivider: MarkdownThemeDivider): void

  /**
   * 设置脚注定义样式
   *
   * @param markdownThemeFootnoteDef 脚注定义样式
   */
  setMarkdownThemeFootnoteDef(markdownThemeFootnoteDef: MarkdownThemeFootnoteDef): void

  /**
   * 设置脚注引用样式
   *
   * @param markdownThemeFootnoteRef 脚注引用样式
   */
  setMarkdownThemeFootnoteRef(markdownThemeFootnoteRef: MarkdownThemeFootnoteRef): void

  /**
   * 设置数学公式样式
   *
   * @param markdownThemeLatexMath 数学公式样式
   */
  setMarkdownThemeLatexMath(markdownThemeLatexMath: MarkdownThemeLatexMath): void

  /**
   * 设置标题样式
   *
   * @param markdownThemeHeading 标题样式
   */
  setMarkdownThemeHeading(markdownThemeHeading: MarkdownThemeHeading): void

  /**
   * 设置HTML下划线文本样式
   *
   * @param markdownThemeHtmlUnderline HTML下划线文本样式
   */
  setMarkdownThemeHtmlUnderline(markdownThemeHtmlUnderline: MarkdownThemeHtmlUnderline): void

  /**
   * 设置图片样式
   *
   * @param markdownThemeImage 图片样式
   */
  setMarkdownThemeImage(markdownThemeImage: MarkdownThemeImage): void

  /**
   * 设置内联代码样式
   *
   * @param markdownThemeInlineCode 内联代码样式
   */
  setMarkdownThemeInlineCode(markdownThemeInlineCode: MarkdownThemeInlineCode): void

  /**
   * 设置斜体文本样式
   *
   * @param markdownThemeItalic 斜体文本样式
   */
  setMarkdownThemeItalic(markdownThemeItalic: MarkdownThemeItalic): void

  /**
   * 设置链接文本样式
   *
   * @param markdownThemeLink 链接文本样式
   */
  setMarkdownThemeLink(markdownThemeLink: MarkdownThemeLink): void

  /**
   * 设置有序列表样式
   *
   * @param markdownThemeOrderedList 有序列表样式
   */
  setMarkdownThemeOrderedList(markdownThemeOrderedList: MarkdownThemeOrderedList): void

  /**
   * 设置段落样式
   *
   * @param markdownThemeParagraph 段落样式
   */
  setMarkdownThemeParagraph(markdownThemeParagraph: MarkdownThemeParagraph): void

  /**
   * 设置删除线文本样式
   *
   * @param markdownThemeStrikethrough 删除线文本样式
   */
  setMarkdownThemeStrikethrough(markdownThemeStrikethrough: MarkdownThemeStrikethrough): void

  /**
   * 设置下标文本样式
   *
   * @param markdownThemeSub 下标文本样式
   */
  setMarkdownThemeSub(markdownThemeSub: MarkdownThemeSub): void

  /**
   * 设置上标文本样式
   *
   * @param markdownThemeSup 上标文本样式
   */
  setMarkdownThemeSup(markdownThemeSup: MarkdownThemeSup): void

  /**
   * 设置表格样式
   *
   * @param markdownThemeTable 表格样式
   */
  setMarkdownThemeTable(markdownThemeTable: MarkdownThemeTable): void

  /**
   * 设置无序/任务列表样式
   *
   * @param markdownThemeBulletList 无序/任务列表样式
   */
  setMarkdownThemeBulletList(markdownThemeBulletList: MarkdownThemeBulletList): void

  /**
   * 设置视频样式
   *
   * @param markdownThemeVideo 视频样式
   */
  setMarkdownThemeVideo(markdownThemeVideo: MarkdownThemeVideo): void

  /**
   * 设置代码块全屏图片icon
   *
   * @param codeFullScreenIcon 代码块全屏图片icon
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenIcon
   */
  setCodeFullScreenIcon(codeFullScreenIcon: Resource): void

  /**
   * 设置代码块复制图片icon
   *
   * @param codeCopyIcon 代码块复制图片icon
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockCopyIcon
   */
  setCodeCopyIcon(codeCopyIcon: Resource): void

  /**
   * 设置音频图片icon
   *
   * @param audioIcon 音频图片icon
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioIcon
   */
  setAudioIcon(audioIcon: Resource): void

  /**
   * 设置视频默认占位图
   *
   * @param videoImage 视频默认占位图
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoPlaceholder
   */
  setVideoImage(videoImage: Resource): void

  /**
   * 设置视频播放按钮icon
   *
   * @param playCircleFillIcon 视频播放按钮icon
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoPlayIcon
   */
  setPlayCircleFillIcon(playCircleFillIcon: Resource): void

  /**
   * 设置banner占位图
   *
   * @param bannerImage banner占位图
   * @deprecated since 1.4.0
   * @useinstead BannerTheme#setBannerPlaceholder
   */
  setBannerImage(bannerImage: Resource): void

  /**
   * 设置图片占位图
   *
   * @param imageResource 图片占位图
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImagePlaceholder
   */
  setImageResource(imageResource: Resource): void

  /**
   * 设置视频发布默认图标
   *
   * @param videoReleaseImage 视频发布默认图标
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonIcon
   */
  setVideoReleaseImage(videoReleaseImage: Resource): void

  /**
   * 设置视频下载默认图标
   *
   * @param videoDownloadImage 视频下载默认图标
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonIcon
   */
  setVideoDownloadImage(videoDownloadImage: Resource): void

  /**
   * 设置图片下载默认图标
   *
   * @param imageDownloadImage 图片下载默认图标
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonIcon
   */
  setImageDownloadImage(imageDownloadImage: Resource): void

  /**
   * 设置markdown是否同步解析
   *
   * @param isMarkdownParserSync markdown是否同步解析 - 默认false
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setIsMarkdownParserSync
   */
  setIsMarkdownParserSync(isMarkdownParserSync: boolean): void

  /**
   * 设置是否打开长按复制粘贴
   *
   * @param isOnCopy 是否打开长按复制粘贴 - 默认true
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setIsOnCopy
   */
  setIsOnCopy(isOnCopy: boolean): void

  /**
   * 设置markdown第一个模块上边距
   *
   * @param blockFirstTopMargin markdown第一个模块上边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setGlobalMargin
   */
  setBlockFirstTopMargin(blockFirstTopMargin: number): void

  /**
   * 设置markdown最后一个模块下边距
   *
   * @param blockLastBottomMargin markdown最后一个模块下边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setGlobalMargin
   */
  setBlockLastBottomMargin(blockLastBottomMargin: number): void

  /**
   * 设置模块间上下间距
   *
   * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setBlockSpacing
   */
  setBlockTopAndBottomMargins(blockTopAndBottomMargins: number): void

  /**
   * 设置链接是否是图片显示
   *
   * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkIsIcon
   */
  setIsLinkStyle(isLinkStyle: boolean): void

  /**
   * 设置列表中的单行链接是否是图片显示
   *
   * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkListIsIcon
   */
  setIsListLinkStyle(isListLinkStyle: boolean): void

  /**
   * 设置文本格式链接文本颜色
   *
   * @param linkColor 文本格式链接文本颜色 - 默认0xFF0000FF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextFontColor
   */
  setLinkColor(linkColor: number): void

  /**
   * 设置是否按照链接文本字体大小显示文本
   *
   * @param isLinkSize 是否按照链接文本字体大小显示文本 - true：显示链接字体文本大小；false：跟随标题段落大小显示。默认true
   */
  setIsLinkSize(isLinkSize: boolean): void

  /**
   * 设置文本格式链接文字大小
   *
   * @param linkSize 文本格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextFontSize
   */
  setLinkSize(linkSize: number): void

  /**
   * 设置文本格式链接文字行高
   *
   * @param linkLineHeight 文本格式链接文字行高
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextLineHeight
   */
  setLinkLineHeight(linkLineHeight: number): void

  /**
   * 设置文本格式链接背景颜色
   *
   * @param linkBackgroundColor 文本格式链接背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextBackgroundColor
   */
  setLinkBackgroundColor(linkBackgroundColor: number): void

  /**
   * 设置文本格式是否显示链接下划线
   *
   * @param isLinkUnderlined 文本格式是否显示链接下划线 - true：显示下划线；false：不显示下划线。默认true
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextDecorationType
   */
  setIsLinkUnderlined(isLinkUnderlined: boolean): void

  /**
   * 设置圆形图片格式链接主题背景颜色
   *
   * @param linkCircleImageBackgroundColor 圆形图片格式链接主题背景颜色 - 默认0x00FFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconBackgroundColor
   */
  setLinkCircleImageBackgroundColor(linkCircleImageBackgroundColor: number): void

  /**
   * 设置圆形图片格式链接控件背景颜色
   *
   * @param linkCircleImageButtonBackgroundColor 圆形图片格式链接控件背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconButtonBackgroundColor
   */
  setLinkCircleImageButtonBackgroundColor(linkCircleImageButtonBackgroundColor: number): void

  /**
   * 设置圆形图片格式链接文字大小
   *
   * @param linkCircleImageTextSize 圆形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconTextSize
   */
  setLinkCircleImageTextSize(linkCircleImageTextSize: number): void

  /**
   * 设置圆形图片格式链接文字颜色
   *
   * @param linkCircleImageTextColor 圆形图片格式链接文字颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconTextColor
   */
  setLinkCircleImageTextColor(linkCircleImageTextColor: number): void

  /**
   * 设置圆形图片格式链接半径
   *
   * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconRadius
   */
  setLinkCircleImageRadius(linkCircleImageRadius: number): void

  /**
   * 设置圆形图片格式链接左右外边距
   *
   * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconMargin
   */
  setLinkCircleImageMargin(linkCircleImageMargin: number): void

  /**
   * 设置圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectImageBackgroundColor 圆角矩形图片格式链接主题背景颜色 - 默认0x00FFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconBackgroundColor
   */
  setLinkRectImageBackgroundColor(linkRectImageBackgroundColor: number): void

  /**
   * 设置圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectImageButtonBackgroundColor 圆角矩形图片格式链接控件背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconButtonBackgroundColor
   */
  setLinkRectImageButtonBackgroundColor(linkRectImageButtonBackgroundColor: number): void

  /**
   * 圆角矩形图片格式链接文字大小
   *
   * @param linkRectImageTextSize 圆角矩形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconTextSize
   */
  setLinkRectImageTextSize(linkRectImageTextSize: number): void

  /**
   * 设置圆角矩形图片格式链接文字颜色
   *
   * @param linkRectImageTextColor 圆角矩形图片格式链接文字颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconTextColor
   */
  setLinkRectImageTextColor(linkRectImageTextColor: number): void

  /**
   * 圆角矩形图片格式链接控件高度
   *
   * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconHeight
   */
  setLinkRectImageHeight(linkRectImageHeight: number): void

  /**
   * 圆角矩形图片格式链接左右内边距
   *
   * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconPadding
   */
  setLinkRectImagePadding(linkRectImagePadding: number): void

  /**
   * 圆角矩形图片格式链接圆角半径
   *
   * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconRadius
   */
  setLinkRectImageRadius(linkRectImageRadius: number): void

  /**
   * 圆角矩形图片格式链接左右外边距
   *
   * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconMargin
   */
  setLinkRectImageMargin(linkRectImageMargin: number): void

  /**
   * 设置空心圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectToolImageBackgroundColor 空心圆角矩形图片格式链接主题背景颜色 - 默认0x00FFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconBackgroundColor
   */
  setLinkRectToolImageBackgroundColor(linkRectToolImageBackgroundColor: number): void

  /**
   * 设置空心圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectToolImageButtonBackgroundColor 空心圆角矩形图片格式链接控件背景颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconBackgroundColor
   */
  setLinkRectToolImageButtonBackgroundColor(linkRectToolImageButtonBackgroundColor: number): void

  /**
   * 设置空心圆角矩形图片格式链接文字大小
   *
   * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconTextSize
   */
  setLinkRectToolImageTextSize(linkRectToolImageTextSize: number): void

  /**
   * 设置空心圆角矩形图片格式链接控件高度
   *
   * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconHeight
   */
  setLinkRectToolImageHeight(linkRectToolImageHeight: number): void

  /**
   * 设置空心圆角矩形图片格式链接左右内边距
   *
   * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconPadding
   */
  setLinkRectToolImagePadding(linkRectToolImagePadding: number): void

  /**
   * 设置空心圆角矩形图片格式链接边框宽度
   *
   * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconBorderWidth
   */
  setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: number): void

  /**
   * 设置空心圆角矩形图片格式链接分割线宽度
   *
   * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconDividingLineWidth
   */
  setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: number): void

  /**
   * 设置空心圆角矩形图片格式链接左右外边距
   *
   * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconMargin
   */
  setLinkRectToolImageMargin(linkRectToolImageMargin: number): void

  /**
   * 设置空心圆角矩形图片格式分割线和文本左边距
   *
   * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconLineLeftPadding
   */
  setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: number): void

  /**
   * 设置空心圆角矩形图片格式分割线和文本右边距
   *
   * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconLineRightPadding
   */
  setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: number): void

  /**
   * 设置块引用左边距
   *
   * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteMargin
   */
  setBlockQuoteLeftMargin(blockQuoteLeftMargin: number): void

  /**
   * 设置块引用右边距
   *
   * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteMargin
   */
  setBlockQuoteRightMargin(blockQuoteRightMargin: number): void

  /**
   * 设置块引用左边线条宽度
   *
   * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteLeftBorderWidth
   */
  setBlockQuoteWidth(blockQuoteWidth: number): void

  /**
   * 设置块引用左边线条颜色
   *
   * @param blockQuoteColor 块引用左边线条颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteLeftBorderColor
   */
  setBlockQuoteColor(blockQuoteColor: number): void

  /**
   * 设置块引用背景颜色
   *
   * @param blockQuoteBackgroundColor 块引用背景颜色 - 默认0xFFEAEAEA
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteBackgroundColor
   */
  setBlockQuoteBackgroundColor(blockQuoteBackgroundColor: number): void

  /**
   * 设置块引用子模块上下间距
   *
   * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteChildSpacing
   */
  setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: number): void

  /**
   * 设置有序列表、无序列表、任务列表子模块上下间距
   *
   * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListChildSpacing
   *             MarkdownThemeOrderedListTheme#setBulletListChildSpacing
   */
  setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: number): void

  /**
   * 设置有序列表、无序列表、任务列表左边距
   *
   * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMargin
   *             MarkdownThemeOrderedListTheme#setBulletListMargin
   */
  setBlockLeftMargin(blockLeftMargin: number): void

  /**
   * 设置有序列表、无序列表、任务列表右边距
   *
   * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMargin
   *             MarkdownThemeOrderedListTheme#setBulletListMargin
   */
  setBlockRightMargin(blockRightMargin: number): void

  /**
   * 设置有序列表前缀文本是否加粗
   *
   * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true：加粗；false：不加粗。默认false
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextFontWeight
   */
  setOrderedListItemPrefixBold(orderedListItemPrefixBold: boolean): void

  /**
   * 设置有序列表前缀文本颜色
   *
   * @param orderedListItemColor 有序列表前缀文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextFontColor
   */
  setOrderedListItemColor(orderedListItemColor: number): void

  /**
   * 设置有序列表前缀文本大小
   *
   * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextFontSize
   */
  setOrderedListItemSize(orderedListItemSize: number): void

  /**
   * 设置有序列表前缀文本行高
   *
   * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextLineHeight
   */
  setOrderedListItemLineHeight(orderedListItemLineHeight: number): void

  /**
   * 设置无序列表前缀是否全部是实心圆型
   *
   * @param bulletListItemCircle 无序列表前缀是否全部是实心圆型 - 默认false
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletIsCircle
   */
  setBulletListItemCircle(bulletListItemCircle: boolean): void

  /**
   * 设置无序列表前缀文本颜色
   *
   * @param bulletListItemColor 无序列表前缀文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletTextFontColor
   */
  setBulletListItemColor(bulletListItemColor: number): void

  /**
   * 设置无序列表前缀文本大小
   *
   * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletTextFontSize
   */
  setBulletListItemSize(bulletListItemSize: number): void

  /**
   * 设置无序列表前缀文本行高
   *
   * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletTextLineHeight
   */
  setBulletListItemLineHeight(bulletListItemLineHeight: number): void

  /**
   * 设置任务列表选择框宽高
   *
   * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListCheckboxWidth
   *             MarkdownThemeBulletListTheme#setBulletListCheckboxHeight
   */
  setTaskListItemLength(taskListItemLength: number): void

  /**
   * 设置是否格式化代码块内容
   *
   * @param isCodeFormat 是否格式化代码块内容 - true：格式化代码块内容；false：不格式化代码块内容。默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIsCodeFormat
   */
  setIsCodeFormat(isCodeFormat: boolean): void

  /**
   * 设置内联代码文本颜色
   *
   * @param codeTextColor 内联代码文本颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextFontColor
   */
  setCodeTextColor(codeTextColor: number): void

  /**
   * 设置内联代码背景颜色
   *
   * @param codeBackgroundColor 内联代码背景颜色 - 默认0xFFEAEAEA
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextBackgroundColor
   */
  setCodeBackgroundColor(codeBackgroundColor: number): void

  /**
   * 设置内联代码文本大小
   *
   * @param codeTextSize 内联代码文本大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextFontSize
   */
  setCodeTextSize(codeTextSize: number): void

  /**
   * 设置内联代码文本字体
   *
   * @param codeTypeface 内联代码文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextFontFamily
   */
  setCodeTypeface(codeTypeface: string): void

  /**
   * 设置围栏代码块代码高亮是否同步解析
   *
   * @param isCodeBlockParserSync 围栏代码块代码高亮是否同步解析 - 默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockParserSync
   */
  setIsCodeBlockParserSync(isCodeBlockParserSync: boolean): void

  /**
   * 设置代码块代码文本颜色
   *
   * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextFontColor
   */
  setCodeBlockTextColor(codeBlockTextColor: number): void

  /**
   * 设置代码块代码类型文本颜色
   *
   * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTypeTextFontColor
   */
  setCodeBlockTypeTextColor(codeBlockTypeTextColor: number): void

  /**
   * 设置代码块代码类型文本
   *
   * @param codeBlockTypeTextStr 代码块代码类型文本 - 默认""
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTypeText
   */
  setCodeBlockTypeTextStr(codeBlockTypeTextStr: string): void

  /**
   * 设置代码类型和代码块距离
   *
   * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTitleLayoutMarginBottom
   */
  setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: number): void

  /**
   * 设置代码块复制、全屏图片文字是否显示
   *
   * @param codeBlockIconTextHide 代码块复制、全屏图片文字是否显示 - true：显示；false：不显示。默认true
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenTextIsShow
   *             MarkdownThemeCodeBlockTheme#setCodeBlockCopyTextIsShow
   */
  setCodeBlockIconTextHide(codeBlockIconTextHide: boolean): void

  /**
   * 设置代码块代码行号是否显示
   *
   * @param codeBlockLineNumberHide 代码块代码行号是否显示 - true：显示；false：不显示。默认true
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockLineNumberIsShow
   */
  setCodeBlockLineNumberHide(codeBlockLineNumberHide: boolean): void

  /**
   * 设置代码块背景颜色
   *
   * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockBackgroundColor
   */
  setCodeBlockBackgroundColor(codeBlockBackgroundColor: number): void

  /**
   * 设置代码块左边距
   *
   * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockMargin
   */
  setCodeMultilineMargin(codeMultilineMargin: number): void

  /**
   * 设置代码块字体
   *
   * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextFontFamily
   */
  setCodeBlockTypeface(codeBlockTypeface: string): void

  /**
   * 设置代码块代码文本大小
   *
   * @param codeBlockTextSize 代码块代码文本大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextFontSize
   */
  setCodeBlockTextSize(codeBlockTextSize: number): void

  /**
   * 设置代码块代码文本行高
   *
   * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextLineHeight
   */
  setCodeBlockLineHeight(codeBlockLineHeight: number): void

  /**
   * 设置代码块控件圆角大小
   *
   * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockRadius
   */
  setCodeBlockRadius(codeBlockRadius: number): void

  /**
   * 设置代码块代码全屏按钮是否显示
   *
   * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true：显示；false：不显示。默认true
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenButtonIsShow
   */
  setIsCodeFullScreen(isCodeFullScreen: boolean): void

  /**
   * 设置代码块代码全屏、代码复制按钮宽高
   *
   * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenIconHeight
   *             MarkdownThemeCodeBlockTheme#setCodeBlockFullScreenIconWidth
   *             MarkdownThemeCodeBlockTheme#setCodeBlockCopyIconHeight
   *             MarkdownThemeCodeBlockTheme#setCodeBlockCopyIconWidth
   */
  setIconWidthAndHeight(iconWidthAndHeight: number): void

  /**
   * 设置组合代码未选中标题字体大小
   *
   * @param codeListTitleTextSize 组合代码未选中标题字体大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleTextSize
   */
  setCodeListTitleTextSize(codeListTitleTextSize: number): void

  /**
   * 设置组合代码选中标题字体大小
   *
   * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleSelectTextSize
   */
  setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: number): void

  /**
   * 设置组合代码选中标题文本颜色
   *
   * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认0xFFFF0000
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleSelectTextColor
   */
  setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: number): void

  /**
   * 设置组合代码未选中标题文本颜色
   *
   * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleUnselectTextColor
   */
  setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: number): void

  /**
   * 设置组合代码选中标题背景颜色
   *
   * @param codeListTitleSelectBackgroundColor 组合代码选中标题背景颜色 - 默认0xFF808080
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleSelectBackgroundColor
   */
  setCodeListTitleSelectBackgroundColor(codeListTitleSelectBackgroundColor: number): void

  /**
   * 设置组合代码未选中标题背景颜色
   *
   * @param codeListTitleUnSelectBackgroundColor 组合代码未选中标题背景颜色 - 默认0x00FFFFFF
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleUnselectBackgroundColor
   */
  setCodeListTitleUnSelectBackgroundColor(codeListTitleUnSelectBackgroundColor: number): void

  /**
   * 设置是否单独代码块显示
   *
   * @param isSeparateCodeBlock 是否单独代码块显示 - true：显示；false：不显示。默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIsSeparate
   */
  setIsSeparateCodeBlock(isSeparateCodeBlock: boolean): void

  /**
   * 设置单独代码块行号宽度
   *
   * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockSeparateWidth
   */
  setSeparateCodeBlockWidth(separateCodeBlockWidth: number): void

  /**
   * 设置单独代码块是否居底显示
   *
   * @param separateCodeIsBottom 单独代码块是否居底显示 - 默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockSeparateIsBottom
   */
  setSeparateCodeIsBottom(separateCodeIsBottom: boolean): void

  /**
   * 设置H1、H2标题下分割线高度
   *
   * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineHeightForAllHeading
   */
  setHeadingBreakHeight(headingBreakHeight: number): void

  /**
   * 设置标题文本字体
   *
   * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontFamilyForAllHeading
   */
  setHeadingTypeface(headingTypeface: string): void

  /**
   * 设置标题模块上间距
   *
   * @param headingTopMargins 标题模块上间距 - 默认8.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setMarginForAllHeadingEachLevel
   */
  setHeadingTopMargins(headingTopMargins: number): void

  /**
   * 设置标题模块下间距
   *
   * @param headingBottomMargins 标题模块下间距 - 默认8.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setMarginForAllHeadingEachLevel
   */
  setHeadingBottomMargins(headingBottomMargins: number): void

  /**
   * 设置标题文本大小数组
   *
   * @param headingTextSizeMultipliers 标题文本大小数组 - 默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForEachHeading
   */
  setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<number>): void

  /**
   * 设置一级标题文本大小
   *
   * @param headingTextSize1 一级标题文本大小 - 默认20.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize1(headingTextSize1: number): void

  /**
   * 设置二级标题文本大小
   *
   * @param headingTextSize2 二级标题文本大小 - 默认17.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize2(headingTextSize2: number): void

  /**
   * 设置三级标题文本大小
   *
   * @param headingTextSize3 三级标题文本大小 - 默认16.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize3(headingTextSize3: number): void

  /**
   * 设置四级标题文本大小
   *
   * @param headingTextSize4 四级标题文本大小 - 默认15.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize4(headingTextSize4: number): void

  /**
   * 设置五级标题文本大小
   *
   * @param headingTextSize5 五级标题文本大小 - 默认15.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize5(headingTextSize5: number): void

  /**
   * 设置六级标题文本大小
   *
   * @param headingTextSize6 六级标题文本大小 - 默认13.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize6(headingTextSize6: number): void

  /**
   * 设置标题文本颜色
   *
   * @param headingTextColor 标题文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForAllHeading
   */
  setHeadingTextColor(headingTextColor: number): void

  /**
   * 设置H1、H2标题下分割线颜色
   *
   * @param headingBreakColor H1、H2标题下分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineColorForAllHeading
   */
  setHeadingBreakColor(headingBreakColor: number): void

  /**
   * 设置标题文本字间距
   *
   * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLetterSpacingForAllHeading
   */
  setHeadingTextWordSpace(headingTextWordSpace: number): void

  /**
   * 设置一级标题文本行高
   *
   * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight1(headingTextLineHeight1: number): void

  /**
   * 设置二级标题文本行高
   *
   * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight2(headingTextLineHeight2: number): void

  /**
   * 设置三级标题文本行高
   *
   * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight3(headingTextLineHeight3: number): void

  /**
   * 设置四级标题文本行高
   *
   * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight4(headingTextLineHeight4: number): void

  /**
   * 设置五级标题文本行高
   *
   * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight5(headingTextLineHeight5: number): void

  /**
   * 设置六级标题文本行高
   *
   * @param headingTextLineHeight6 六级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight6(headingTextLineHeight6: number): void

  /**
   * 设置一级标题文本颜色
   *
   * @param headingTextColor1 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor1(headingTextColor1: number): void

  /**
   * 设置H1标题下分割线颜色
   *
   * @param headingBreakColor1 H1标题下分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineColorForDesignateHeading
   */
  setHeadingBreakColor1(headingBreakColor1: number): void

  /**
   * 设置二级标题文本颜色
   *
   * @param headingTextColor2 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor2(headingTextColor2: number): void

  /**
   * 设置H2标题下分割线颜色
   *
   * @param headingBreakColor2 H2标题下分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineColorForDesignateHeading
   */
  setHeadingBreakColor2(headingBreakColor2: number): void

  /**
   * 设置三级标题文本颜色
   *
   * @param headingTextColor3 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor3(headingTextColor3: number): void

  /**
   * 设置四级标题文本颜色
   *
   * @param headingTextColor4 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor4(headingTextColor4: number): void

  /**
   * 设置五级标题文本颜色
   *
   * @param headingTextColor5 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor5(headingTextColor5: number): void

  /**
   * 设置六级标题文本颜色
   *
   * @param headingTextColor6 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor6(headingTextColor6: number): void

  /**
   * 设置段落模块上间距
   *
   * @param paragraphTopMargins 段落模块上间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphMargin
   */
  setParagraphTopMargins(paragraphTopMargins: number): void

  /**
   * 设置段落模块下间距
   *
   * @param paragraphBottomMargins 段落模块下间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphMargin
   */
  setParagraphBottomMargins(paragraphBottomMargins: number): void

  /**
   * 设置段落文本大小
   *
   * @param paragraphTextSize 段落文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextFontSize
   */
  setParagraphTextSize(paragraphTextSize: number): void

  /**
   * 设置段落文本颜色
   *
   * @param paragraphTextColor 段落文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextFontColor
   */
  setParagraphTextColor(paragraphTextColor: number): void

  /**
   * 设置段落文本字间距
   *
   * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextLetterSpacing
   */
  setParagraphTextWordSpace(paragraphTextWordSpace: number): void

  /**
   * 设置段落文本行高
   *
   * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextLineHeight
   */
  setParagraphTextLineHeight(paragraphTextLineHeight: number): void

  /**
   * 设置段落文本字体
   *
   * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextFontFamily
   */
  setParagraphTypeface(paragraphTypeface: string): void

  /**
   * 设置分割线颜色
   *
   * @param thematicBreakColor 分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerColor
   */
  setThematicBreakColor(thematicBreakColor: number): void

  /**
   * 设置分割线高度
   *
   * @param thematicBreakHeight 分割线高度 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerStrokeWidth
   */
  setThematicBreakHeight(thematicBreakHeight: number): void

  /**
   * 设置分割线上部外边距
   *
   * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerMargin
   */
  setThematicBreakTopMargin(thematicBreakTopMargin: number): void

  /**
   * 设置分割线下部外边距
   *
   * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerMargin
   */
  setThematicBreakBottomMargin(thematicBreakBottomMargin: number): void

  /**
   * 设置软换行是否换行
   *
   * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setIsLineBreak
   */
  setIsLineBreak(isLineBreak: boolean): void

  /**
   * 设置数学公式未加载状态是否显示文字
   *
   * @param latexDefaultText 数学公式未加载状态是否显示文字 - 默认true
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathDefaultText
   */
  setLatexDefaultText(latexDefaultText: boolean): void

  /**
   * 设置数学公式文本大小
   *
   * @param latexMathTextSize 数学公式文本大小 - 默认16.0fp
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathDefaultTextFontSize
   */
  setLatexMathTextSize(latexMathTextSize: number): void

  /**
   * 设置数学公式背景色
   *
   * @param latexMathBackgroundColor 数学公式背景色 - 默认0x00FFFFFF
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathBackgroundColor
   */
  setLatexMathBackgroundColor(latexMathBackgroundColor: number): void

  /**
   * 设置数学公式文本颜色
   *
   * @param latexMathTextColor 数学公式文本颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathTextColor
   */
  setLatexMathTextColor(latexMathTextColor: number): void

  /**
   * 设置数学公式生成图片格式
   *
   * @param latexMathColorFormat 数学公式生成图片格式 - 默认LatexMathColorFormat.0xFORMAT_BGRA_8888
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathColorFormat
   */
  setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): void

  /**
   * 设置块结构的数学公式是否居中
   *
   * @param latexMathBlockCenter 块结构的数学公式是否居中 - true：居中；false：不居中。默认false
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathBlockCenter
   */
  setLatexMathBlockCenter(latexMathBlockCenter: boolean): void

  /**
   * 设置数学公式字体路径
   *
   * @param latexMathResStr 数学公式字体路径 默认 "/data/storage/el1/bundle/entry/resources/resfile/res"
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathResPath
   */
  setLatexMathResStr(latexMathResStr: string): void

  /**
   * 设置音频阴影颜色值
   *
   * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioShadowColor
   */
  setAudioShadowColor(audioShadowColor: number): void

  /**
   * 设置音频边框颜色
   *
   * @param audioBorderColor 音频边框颜色 - 默认0x33000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioBorderColor
   */
  setAudioBorderColor(audioBorderColor: number): void

  /**
   * 设置音频边框粗细
   *
   * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioBorderWidth
   */
  setAudioBorderWidth(audioBorderWidth: number): void

  /**
   * 设置音频边框圆角
   *
   * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioBorderRadius
   */
  setAudioBorderRadius(audioBorderRadius: number): void

  /**
   * 设置音频按钮背景颜色
   *
   * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonBackgroundColor
   */
  setAudioButtonBackgroundColor(audioButtonBackgroundColor: number): void

  /**
   * 设置音频按钮文字颜色
   *
   * @param audioButtonTextColor 音频按钮文字颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonTextFontColor
   */
  setAudioButtonTextColor(audioButtonTextColor: number): void

  /**
   * 设置音频按钮文字大小
   *
   * @param audioButtonTextSize 音频按钮文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonTextFontSize
   */
  setAudioButtonTextSize(audioButtonTextSize: number): void

  /**
   * 设置音频按钮文字内容
   *
   * @param audioButtonText 音频按钮文字内容 - 默认"立即播放"
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonText
   */
  setAudioButtonText(audioButtonText: string): void

  /**
   * 设置音频按钮圆角
   *
   * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonAllRadius
   */
  setAudioButtonBorderRadius(audioButtonBorderRadius: number): void

  /**
   * 设置音频标题文字大小
   *
   * @param audioTitleTextSize 音频标题文字大小 - 默认15.0fp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTitleTextFontSize
   */
  setAudioTitleTextSize(audioTitleTextSize: number): void

  /**
   * 设置音频标题文字颜色
   *
   * @param audioTitleTextColor 音频标题文字颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTitleTextFontColor
   */
  setAudioTitleTextColor(audioTitleTextColor: number): void

  /**
   * 设置音频标题文字行高
   *
   * @param audioTitleTextLineHeight 音频标题文字行高 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTitleTextLineHeight
   */
  setAudioTitleTextLineHeight(audioTitleTextLineHeight: number): void

  /**
   * 设置音频类型文字大小
   *
   * @param audioTypeTextSize 音频类型文字大小 - 默认11.0fp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTypeTextFontSize
   */
  setAudioTypeTextSize(audioTypeTextSize: number): void

  /**
   * 设置音频类型文字颜色
   *
   * @param audioTypeTextColor 音频类型文字颜色 - 默认0x80000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTypeTextFontColor
   */
  setAudioTypeTextColor(audioTypeTextColor: number): void

  /**
   * 设置音频类型文字行高
   *
   * @param audioTypeTextLineHeight 音频类型文字行高 - 默认15.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTypeTextLineHeight
   */
  setAudioTypeTextLineHeight(audioTypeTextLineHeight: number): void

  /**
   * 设置音频上边距
   *
   * @param audioMarginTop 音频上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioMargin
   */
  setAudioMarginTop(audioMarginTop: number): void

  /**
   * 设置音频下边距
   *
   * @param audioMarginBottom 音频下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioMargin
   */
  setAudioMarginBottom(audioMarginBottom: number): void

  /**
   * 设置视频时间文本颜色
   *
   * @param videoTimeTextColor 视频时间文本颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextFontColor
   */
  setVideoTimeTextColor(videoTimeTextColor: number): void

  /**
   * 设置视频时间文本大小
   *
   * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextFontSize
   */
  setVideoTimeTextSize(videoTimeTextSize: number): void

  /**
   * 设置视频时间文本居右边距
   *
   * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextMarginRight
   */
  setVideoTimeTextMarginRight(videoTimeTextMarginRight: number): void

  /**
   * 设置视频时间文本居底边距
   *
   * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextMarginBottom
   */
  setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: number): void

  /**
   * 设置视频上边距
   *
   * @param videoMarginTop 视频上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoMargin
   */
  setVideoMarginTop(videoMarginTop: number): void

  /**
   * 设置视频下边距
   *
   * @param videoMarginBottom 视频下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoMargin
   */
  setVideoMarginBottom(videoMarginBottom: number): void

  /**
   * 设置视频发布/下载按钮布局是否显示
   *
   * @param isVideoBottomLayout 视频发布/下载按钮布局是否显示 - 默认false不显示
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoBottomLayoutVisible
   */
  setIsVideoBottomLayout(isVideoBottomLayout: boolean): void

  /**
   * 设置视频发布按钮图片宽度和高度
   *
   * @param videoReleaseImageWidthHeight 视频发布按钮图片宽度和高度 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonIconWidth
   *             MarkdownThemeVideoTheme#setVideoReleaseButtonIconHeight
   */
  setVideoReleaseImageWidthHeight(videoReleaseImageWidthHeight: number): void

  /**
   * 设置视频发布按钮宽度
   *
   * @param videoReleaseWidth 视频发布按钮宽度 - 默认144.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonWidth
   */
  setVideoReleaseWidth(videoReleaseWidth: number): void

  /**
   * 设置视频发布按钮高度
   *
   * @param videoReleaseHeight 视频发布按钮高度 - 默认44.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonHeight
   */
  setVideoReleaseHeight(videoReleaseHeight: number): void

  /**
   * 设置视频发布按钮圆角
   *
   * @param videoReleaseRadius 视频发布按钮圆角 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonAllRadius
   */
  setVideoReleaseRadius(videoReleaseRadius: number): void

  /**
   * 设置视频发布按钮文本内容
   *
   * @param videoReleaseText 视频发布按钮文本内容 - 默认"发布视频"
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonText
   */
  setVideoReleaseText(videoReleaseText: string): void

  /**
   * 设置视频发布按钮文本大小
   *
   * @param videoReleaseTextSize 视频发布按钮文本大小 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonTextFontSize
   */
  setVideoReleaseTextSize(videoReleaseTextSize: number): void

  /**
   * 设置视频发布按钮文本颜色
   *
   * @param videoReleaseTextColor 视频发布按钮文本颜色 - 默认0xE6000000
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonTextFontColor
   */
  setVideoReleaseTextColor(videoReleaseTextColor: number): void

  /**
   * 设置视频发布按钮背景颜色
   *
   * @param videoReleaseBackgroundColor 视频发布按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonBackgroundColor
   */
  setVideoReleaseBackgroundColor(videoReleaseBackgroundColor: number): void

  /**
   * 设置视频下载按钮图片宽度和高度
   *
   * @param videoDownloadImageWidthHeight 视频下载按钮图片宽度和高度 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonIconWidth
   *             MarkdownThemeVideoTheme#setVideoDownloadButtonIconHeight
   */
  setVideoDownloadImageWidthHeight(videoDownloadImageWidthHeight: number): void

  /**
   * 设置视频下载按钮宽度
   *
   * @param videoDownloadWidth 视频下载按钮宽度 - 默认144.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonWidth
   */
  setVideoDownloadWidth(videoDownloadWidth: number): void

  /**
   * 设置视频下载按钮高度
   *
   * @param videoDownloadHeight 视频下载按钮高度 - 默认44.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonHeight
   */
  setVideoDownloadHeight(videoDownloadHeight: number): void

  /**
   * 设置视频下载按钮圆角
   *
   * @param videoDownloadRadius 视频下载按钮圆角 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonAllRadius
   */
  setVideoDownloadRadius(videoDownloadRadius: number): void

  /**
   * 设置视频下载按钮文本内容
   *
   * @param videoDownloadText 视频下载按钮文本内容 - 默认"下载视频"
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonText
   */
  setVideoDownloadText(videoDownloadText: string): void

  /**
   * 设置视频下载按钮文本大小
   *
   * @param videoDownloadTextSize 视频下载按钮文本大小 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonTextFontSize
   */
  setVideoDownloadTextSize(videoDownloadTextSize: number): void

  /**
   * 设置视频下载按钮文本颜色
   *
   * @param videoDownloadTextColor 视频下载按钮文本颜色 - 默认0xE6000000
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonTextFontColor
   */
  setVideoDownloadTextColor(videoDownloadTextColor: number): void

  /**
   * 设置视频下载按钮背景颜色
   *
   * @param videoDownloadBackgroundColor 视频下载按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonBackgroundColor
   */
  setVideoDownloadBackgroundColor(videoDownloadBackgroundColor: number): void

  /**
   * 设置图片缩放类型
   *
   * @param imageFitType 图片缩放类型 - 默认ImageFit.Contain
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageFitType
   */
  setImageFitType(imageFitType: ImageFitType): void

  /**
   * 设置图片基于自身宽度缩放百分比
   *
   * @param imageMaximumWidth 图片基于自身宽度缩放百分比 - 默认1.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMaximumWidth
   */
  setImageMaximumWidth(imageMaximumWidth: number): void

  /**
   * 设置图片基于父布局宽度缩放百分比
   *
   * @param imageFixedRatioWidth 图片基于父布局宽度缩放百分比 - 默认None
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageFixedRatioWidth
   */
  setImageFixedRatioWidth(imageFixedRatioWidth: number): void

  /**
   * 设置图片最大高度
   *
   * @param imageMaxHeight 图片最大高度 - 默认None
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMaxHeight
   */
  setImageMaxHeight(imageMaxHeight: number): void

  /**
   * 设置图片最大宽度
   *
   * @param imageMaxWidth 图片最大宽度 - 默认None
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMaxWidth
   */
  setImageMaxWidth(imageMaxWidth: number): void

  /**
   * 设置图片圆角大小
   *
   * @param imageBorderRadius 图片圆角大小 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageBorderAllRadius
   */
  setImageBorderRadius(imageBorderRadius: number): void

  /**
   * 设置图片边框宽度
   *
   * @param imageBorderWidth 图片边框宽度 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageBorderWidth
   */
  setImageBorderWidth(imageBorderWidth: number): void

  /**
   * 设置图片边框颜色
   *
   * @param imageBorderColor 图片边框颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageBorderColor
   */
  setImageBorderColor(imageBorderColor: number): void

  /**
   * 设置网络图片是否压缩
   *
   * @param isAutoResize 网络图片是否压缩 - true：压缩；false：不压缩。默认true
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageAutoResize
   */
  setIsAutoResize(isAutoResize: boolean): void

  /**
   * 设置图片上边距
   *
   * @param imageMarginTop 图片上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMargin
   */
  setImageMarginTop(imageMarginTop: number): void

  /**
   * 设置图片下边距
   *
   * @param imageMarginBottom 图片下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMargin
   */
  setImageMarginBottom(imageMarginBottom: number): void

  /**
   * 设置图片是否有下载按钮
   *
   * @param isImageDownload 图片是否有下载按钮 - 默认false
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonVisible
   */
  setIsImageDownload(isImageDownload: boolean): void

  /**
   * 设置是否图文混排
   *
   * @param isImageMixedLayout 是否图文混排 - 默认true
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setIsImageMixedLayout
   */
  setIsImageMixedLayout(isImageMixedLayout: boolean): void

  /**
   * 设置图片下载按钮图片宽度和高度
   *
   * @param imageDownloadImageWidthHeight 图片下载按钮图片宽度和高度 - 默认18.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonIconWidth
   *             MarkdownThemeImageTheme#setImageDownloadButtonIconHeight
   */
  setImageDownloadImageWidthHeight(imageDownloadImageWidthHeight: number): void

  /**
   * 设置图片下载按钮宽度
   *
   * @param imageDownloadWidth 图片下载按钮宽度 - 默认296.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonWidth
   */
  setImageDownloadWidth(imageDownloadWidth: number): void

  /**
   * 设置图片下载按钮高度
   *
   * @param imageDownloadHeight 图片下载按钮高度 - 默认44.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonHeight
   */
  setImageDownloadHeight(imageDownloadHeight: number): void

  /**
   * 设置图片下载按钮圆角
   *
   * @param imageDownloadRadius 图片下载按钮圆角 - 默认22.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonAllRadius
   */
  setImageDownloadRadius(imageDownloadRadius: number): void

  /**
   * 设置图片下载按钮文本内容
   *
   * @param imageDownloadText 图片下载按钮文本内容 - 默认"下载图片"
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonText
   */
  setImageDownloadText(imageDownloadText: string): void

  /**
   * 设置图片下载按钮文本大小
   *
   * @param imageDownloadTextSize 图片下载按钮文本大小 - 默认16.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonTextFontSize
   */
  setImageDownloadTextSize(imageDownloadTextSize: number): void

  /**
   * 设置图片下载按钮文本颜色
   *
   * @param imageDownloadTextColor 图片下载按钮文本颜色 - 默认0xE6000000
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonTextFontColor
   */
  setImageDownloadTextColor(imageDownloadTextColor: number): void

  /**
   * 设置图片下载按钮背景颜色
   *
   * @param imageDownloadBackgroundColor 图片下载按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonBackgroundColor
   */
  setImageDownloadBackgroundColor(imageDownloadBackgroundColor: number): void

  /**
   * 设置表格内容内边距
   *
   * @param tableCellPadding 表格内容内边距 - 默认4.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableCellAllPadding
   */
  setTableCellPadding(tableCellPadding: number): void

  /**
   * 设置表格边框颜色
   *
   * @param tableBorderColor 表格边框颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableBorderColor
   */
  setTableBorderColor(tableBorderColor: number): void

  /**
   * 设置表格边框宽度
   *
   * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableBorderWidth
   */
  setTableBorderWidth(tableBorderWidth: number): void

  /**
   * 设置表格奇数行背景色
   *
   * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentOddRowBackgroundColor
   */
  setTableOddRowBackgroundColor(tableOddRowBackgroundColor: number): void

  /**
   * 设置表格偶数行背景色
   *
   * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0xFFE0E0E0
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentEvenRowBackgroundColor
   */
  setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: number): void

  /**
   * 设置表格标题背景色
   *
   * @param tableHeaderRowBackgroundColor 表格标题背景色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleBackgroundColor
   */
  setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: number): void

  /**
   * 设置表格标题文本颜色
   *
   * @param tableTitleTextColor 表格标题文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleTextFontColor
   */
  setTableTitleTextColor(tableTitleTextColor: number): void

  /**
   * 设置表格文本行高
   *
   * @param tableTextLineHeight 表格文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextLineHeight
   *             MarkdownThemeTableTheme#setTableTitleTextLineHeight
   */
  setTableTextLineHeight(tableTextLineHeight: number): void

  /**
   * 设置表格标题文本大小
   *
   * @param tableTitleTextSize 表格标题文本大小 - 默认14.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleTextFontSize
   */
  setTableTitleTextSize(tableTitleTextSize: number): void

  /**
   * 设置表格标题文本行高
   *
   * @param tableTitleLineHeight 表格标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleTextLineHeight
   */
  setTableTitleLineHeight(tableTitleLineHeight: number): void

  /**
   * 设置表格内容文本颜色
   *
   * @param tableContentTextColor 表格内容文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextFontColor
   */
  setTableContentTextColor(tableContentTextColor: number): void

  /**
   * 设置表格内容文本大小
   *
   * @param tableContentTextSize 表格内容文本大小 - 默认14.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextFontSize
   */
  setTableContentTextSize(tableContentTextSize: number): void

  /**
   * 设置表格内容文本行高
   *
   * @param tableTextLineHeight 表格内容文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextLineHeight
   */
  setTableContentTextLineHeight(tableTextLineHeight: number): void

  /**
   * 设置表格圆角
   *
   * @param tableRadius 表格圆角 - 默认5.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableAllRadius
   */
  setTableRadius(tableRadius: number): void

  /**
   * 设置表格最小宽度
   *
   * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableMinCellWidth
   */
  setTableMinTextWidth(tableMinTextWidth: number): void

  /**
   * 设置表格最大宽度
   *
   * @param tableMaxTextWidth 表格最大宽度- 默认300.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableMaxCellWidth
   */
  setTableMaxTextWidth(tableMaxTextWidth: number): void

  /**
   * 设置表格第一列是否加粗
   *
   * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableFirstColumnIsBold
   */
  setTableFirstColumnBold(tableFirstColumnBold: boolean): void

  /**
   * 设置表格是否显示滚动条
   *
   * @param tableScrollBarShow 表格是否显示滚动条 - true：显示(auto状态)；false：不显示。默认false
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableScrollBarState
   */
  setTableScrollBarShow(tableScrollBarShow: boolean): void

  /**
   * 设置表格滚动条颜色
   *
   * @param tableScrollBarColor 表格滚动条颜色
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableScrollBarColor
   */
  setTableScrollBarColor(tableScrollBarColor: number): void

  /**
   * 设置代码块深浅色
   *
   * @param isDark 是否是深色 - true：深色；false：浅色。默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIsDark
   */
  setIsDark(isDark: boolean): void

  /**
   * 设置删除线颜色
   *
   * @param strikethroughColor 删除线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead StrikethroughTheme#setStrikethroughTextDecorationColor
   */
  setStrikethroughColor(strikethroughColor: number): void

  /**
   * 设置删除线样式
   *
   * @param strikethroughStyle 删除线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   * @deprecated since 1.4.0
   * @useinstead StrikethroughTheme#setStrikethroughTextDecorationStyle
   */
  setStrikethroughStyle(strikethroughStyle: MarkdownTextDecorationStyle): void

  /**
   * 设置定义列表术语和定义行之间间距
   *
   * @param descListTermAndDefMargins 定义列表定义行缩进 默认8.0
   * @deprecated since 1.4.0
   * @useinstead DefinitionListTheme#setDefinitionListTermToDescriptionSpacing
   */
  setDescListTermAndDefMargins(descListTermAndDefMargins: number): void

  /**
   * 设置定义列表定义行缩进
   *
   * @param descListDefIndentation 定义列表定义行缩进 默认8.0
   * @deprecated since 1.4.0
   * @useinstead DefinitionListTheme#setDefinitionListDescriptionIndent
   */
  setDescListDefIndentation(descListDefIndentation: number): void

  /**
   * 设置定义列表定义行间距
   *
   * @param descListDefMargins 定义列表定义行间距 默认8.0
   * @deprecated since 1.4.0
   * @useinstead DefinitionListTheme#setDefinitionListDescriptionItemSpacing
   */
  setDescListDefMargins(descListDefMargins: number): void

  /**
   * 设置下标字体颜色
   *
   * @param subTextColor 下标字体颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead SubTheme#setSubTextFontColor
   */
  setSubTextColor(subTextColor: number): void

  /**
   * 设置下标字体大小
   *
   * @param subTextSize 下标字体大小 默认8.0
   * @deprecated since 1.4.0
   * @useinstead SubTheme#setSubTextFontSize
   */
  setSubTextSize(subTextSize: number): void

  /**
   * 设置下标偏移距离
   *
   * @param subOffsetDist 下标偏移距离 默认0.0
   * @deprecated since 1.4.0
   * @useinstead SubTheme#setSubTextBaselineOffset
   */
  setSubOffsetDist(subOffsetDist: number): void

  /**
   * 设置上标字体颜色
   *
   * @param supTextColor 上标字体颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead SupTheme#setSupTextFontColor
   */
  setSupTextColor(supTextColor: number): void

  /**
   * 设置上标字体大小
   *
   * @param supTextSize 上标字体大小 默认8.0
   * @deprecated since 1.4.0
   * @useinstead SupTheme#setSupTextFontSize
   */
  setSupTextSize(supTextSize: number): void

  /**
   * 设置上标偏移距离
   *
   * @param supOffsetDist 上标偏移距离 默认6.0
   * @deprecated since 1.4.0
   * @useinstead SupTheme#setSupTextBaselineOffset
   */
  setSupOffsetDist(supOffsetDist: number): void

  /**
   * 设置下划线颜色
   *
   * @param underlineColor 下划线颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead HtmlUnderlineTheme#setHtmlUnderlineTextDecorationColor
   */
  setUnderlineColor(underlineColor: number): void

  /**
   * 设置下划线样式
   *
   * @param underlineStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   * @deprecated since 1.4.0
   * @useinstead HtmlUnderlineTheme#setHtmlUnderlineTextDecorationStyle
   */
  setUnderlineStyle(underlineStyle: MarkdownTextDecorationStyle): void

  /**
   * 设置markdown是否支持滚动手势
   *
   * @param openGestureSwipe true-支持滚动手势，false-不支持滚动手势，默认false
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setOpenGestureSwipe
   */
  setOpenGestureSwipe(openGestureSwipe: boolean): void

  /**
   * 设置codeformat是否用制表符
   *
   * @param useTab true-使用，false-不使用，默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockUseTab
   */
  setUseTab(useTab: boolean): void

  /**
   * 设置codeformat空格缩进数量
   *
   * @param indentWidth 空格缩进数量，默认4空格
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIndentWidth
   */
  setIndentWidth(indentWidth: number): void
}
```

### enum LatexMathColorFormat

```ets
/**
 * 数学公式生成图片格式的枚举
 */
export enum LatexMathColorFormat {
    COLOR_FORMAT_RGB_565, // 16位
    COLOR_FORMAT_BGRA_8888 // 32位
}
```

### enum ImageFitType

```ets
/**
 * 图片缩放类型的枚举
 */
export enum ImageFitType {
    // 保持宽高比进行缩小或者放大，使得图片两边都大于或等于显示边界。
    Contain,
    // 保持宽高比进行缩小或者放大，使得图片恰好完全显示在显示边界内。
    Cover,
    // 不保持宽高比进行放大缩小，使得图片充满显示边界。
    Fill
}
```

### enum MarkdownTextDecorationStyle
```ets
/**
 * 文本装饰线样式
 */
export enum MarkdownTextDecorationStyle {
    SOLID = 0, // 实线
    DOUBLE = 1, // 双横线
    DOTTED = 2, // 点线
    DASHED = 3, // 虚线
    WAVY = 4 // 波浪线
}
```

### interface MarkdownMarginOptions
```ets
/**
 * 通用外边距配置
 */
export interface MarkdownMarginOptions {
    top?: number
    right?: number
    bottom?: number
    left?: number
}
```

### interface MarkdownPaddingOptions
```ets
/**
 * 通用内边距配置
 */
export interface MarkdownPaddingOptions {
    top?: number
    right?: number
    bottom?: number
    left?: number
}
```

### interface MarkdownRadiusOptions
```ets
/**
 * 通用圆角配置
 */
export interface MarkdownRadiusOptions {
    topLeft?: number
    topRight?: number
    bottomLeft?: number
    bottomRight?: number
}
```

### class MarkdownThemeGlobal

Markdown用户可设置的样式-全局样式

```ets
export class MarkdownThemeGlobal {
  /**
   * 设置markdown是否同步解析
   *
   * @param isSync 是否同步解析
   */
  setIsMarkdownParserSync(isSync: boolean): void

  /**
   * 设置是否打开长按复制粘贴
   *
   * @param onCopy 是否打开
   */
  setIsOnCopy(onCopy: boolean): void

  /**
   * 设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setGlobalMargin(options: MarkdownMarginOptions | number): void

  /**
   * 设置模块间上下间距
   *
   * @param spacing 模块间上下间距
   */
  setBlockSpacing(spacing: number): void

  /**
   * 设置软换行是否换行
   *
   * @param isLineBreak 是否换行
   */
  setIsLineBreak(isLineBreak: boolean): void

  /**
   * 设置markdown是否允许滑动
   *
   * @param openGestureSwipe 是否允许滑动
   */
  setOpenGestureSwipe(openGestureSwipe: boolean): void

  /**
   * 设置背景颜色
   *
   * @param color 背景颜色
   */
  setBackgroundColor(color: number): void
}
```

### class MarkdownThemeItalic

Markdown用户可设置的样式-斜体文本样式

```ets
export class MarkdownThemeItalic {
  /**
   * 设置斜体文本尺寸
   *
   * @param size 斜体文本尺寸
   */
  setItalicTextFontSize(size: number): void

  /**
   * 设置斜体文本字体粗细
   *
   * @param weight 斜体文本字体粗细
   */
  setItalicTextFontWeight(weight: FontWeight): void

  /**
   * 设置斜体文本字体
   *
   * @param family 斜体文本字体
   */
  setItalicTextFontFamily(family: string): void

  /**
   * 设置斜体文本行高
   *
   * @param lineHeight 斜体文本行高
   */
  setItalicTextLineHeight(lineHeight: number): void

  /**
   * 设置斜体文本字符间距
   *
   * @param spacing 斜体文本字符间距
   */
  setItalicTextLetterSpacing(spacing: number): void
}
```

### class MarkdownThemeStrikethrough

Markdown用户可设置的样式-删除线文本样式

```ets
export class MarkdownThemeStrikethrough {
  /**
   * 设置删除线文本尺寸
   *
   * @param size 删除线文本字号
   */
  setStrikethroughTextFontSize(size: number): void

  /**
   * 设置删除线文本字体样式
   *
   * @param style 删除线文本字体样式
   */
  setStrikethroughTextFontStyle(style: FontStyle): void

  /**
   * 设置删除线文本字体粗细
   *
   * @param weight 删除线文本字体粗细
   */
  setStrikethroughTextFontWeight(weight: FontWeight): void

  /**
   * 设置删除线文本字体
   *
   * @param family 删除线文本字体
   */
  setStrikethroughTextFontFamily(family: string): void

  /**
   * 设置删除线文本行高
   *
   * @param lineHeight 删除线文本行高
   */
  setStrikethroughTextLineHeight(lineHeight: number): void

  /**
   * 设置删除线文本字符间距
   *
   * @param spacing 删除线文本字符间距
   */
  setStrikethroughTextLetterSpacing(spacing: number): void

  /**
   * 设置删除线文本装饰线颜色
   *
   * @param color 删除线文本装饰线颜色
   */
  setStrikethroughTextDecorationColor(color: number): void

  /**
   * 设置删除线文本装饰线样式
   *
   * @param style 删除线文本装饰线样式
   */
  setStrikethroughTextDecorationStyle(style: MarkdownTextDecorationStyle): void
}
```

### class MarkdownThemeSub

Markdown用户可设置的样式-下标文本样式

```ets
export class MarkdownThemeSub {
  /**
   * 设置下标文本尺寸
   *
   * @param size 下标文本尺寸
   */
  setSubTextFontSize(size: number): void

  /**
   * 设置下标文本字体样式
   *
   * @param style 下标文本字体样式
   */
  setSubTextFontStyle(style: FontStyle): void

  /**
   * 设置下标文本字体粗细
   *
   * @param weight 下标文本字体粗细
   */
  setSubTextFontWeight(weight: FontWeight): void

  /**
   * 设置下标文本字体
   *
   * @param family 下标文本字体
   */
  setSubTextFontFamily(family: string): void

  /**
   * 设置下标文本字符间距
   *
   * @param spacing 下标文本字符间距
   */
  setSubTextLetterSpacing(spacing: number): void

  /**
   * 设置下标文本基线的偏移量
   *
   * @param offset 下标文本基线的偏移量
   */
  setSubTextBaselineOffset(offset: number): void
}
```

### class MarkdownThemeSup

Markdown用户可设置的样式-上标文本样式

```ets
export class MarkdownThemeSup {
  /**
   * 设置上标文本尺寸
   *
   * @param size 上标文本尺寸
   */
  setSupTextFontSize(size: number): void

  /**
   * 设置上标文本字体样式
   *
   * @param style 上标文本字体样式
   */
  setSupTextFontStyle(style: FontStyle): void

  /**
   * 设置上标文本字体粗细
   *
   * @param weight 上标文本字体粗细
   */
  setSupTextFontWeight(weight: FontWeight): void

  /**
   * 设置上标文本字体
   *
   * @param family 上标文本字体
   */
  setSupTextFontFamily(family: string): void

  /**
   * 设置上标文本字符间距
   *
   * @param spacing 上标文本字符间距
   */
  setSupTextLetterSpacing(spacing: number): void

  /**
   * 设置上标文本基线的偏移量
   *
   * @param offset 上标文本基线的偏移量
   */
  setSupTextBaselineOffset(offset: number): void
}
```

### class MarkdownThemeHtmlUnderline

Markdown用户可设置的样式-HTML下划线文本样式

```ets
export class MarkdownThemeHtmlUnderline {
  /**
   * 设置HTML下划线文本尺寸
   *
   * @param size HTML下划线文本尺寸
   */
  setHtmlUnderlineTextFontSize(size: number): void

  /**
   * 设置HTML下划线文本字体样式
   *
   * @param style HTML下划线文本字体样式
   */
  setHtmlUnderlineTextFontStyle(style: FontStyle): void

  /**
   * 设置HTML下划线文本字体粗细
   *
   * @param weight HTML下划线文本字体粗细
   */
  setHtmlUnderlineTextFontWeight(weight: FontWeight): void

  /**
   * 设置HTML下划线文本字体
   *
   * @param family HTML下划线文本字体
   */
  setHtmlUnderlineTextFontFamily(family: string): void

  /**
   * 设置HTML下划线文本行高
   *
   * @param lineHeight HTML下划线文本行高
   */
  setHtmlUnderlineTextLineHeight(lineHeight: number): void

  /**
   * 设置HTML下划线文本字符间距
   *
   * @param spacing HTML下划线文本字符间距
   */
  setHtmlUnderlineTextLetterSpacing(spacing: number): void

  /**
   * 设置HTML下划线文本装饰线颜色
   *
   * @param color HTML下划线文本装饰线颜色
   */
  setHtmlUnderlineTextDecorationColor(color: number): void

  /**
   * 设置HTML下划线文本装饰线样式
   *
   * @param style HTML下划线文本装饰线样式
   */
  setHtmlUnderlineTextDecorationStyle(style: MarkdownTextDecorationStyle): void
}
```

### class MarkdownThemeLink

Markdown用户可设置的样式-链接文本样式

```ets
export class MarkdownThemeLink {
  /**
   * 设置列表中的单行链接是否是图片显示
   *
   * @param isIcon 列表中的单行链接是否是图片显示
   */
  setLinkListIsIcon(isIcon: boolean): void

  /**
   * 设置链接文本颜色
   *
   * @param color 链接文本颜色
   */
  setLinkTextFontColor(color: number): void

  /**
   * 设置链接文本尺寸
   *
   * @param size 链接文本尺寸
   */
  setLinkTextFontSize(size: number): void

  /**
   * 设置链接文本字体样式
   *
   * @param style 链接文本字体样式
   */
  setLinkTextFontStyle(style: FontStyle): void

  /**
   * 设置链接文本字体粗细
   *
   * @param weight 链接文本字体粗细
   */
  setLinkTextFontWeight(weight: FontWeight): void

  /**
   * 设置链接文本字体
   *
   * @param family 链接文本字体
   */
  setLinkTextFontFamily(family: string): void

  /**
   * 设置链接文本行高
   *
   * @param lineHeight 链接文本行高
   */
  setLinkTextLineHeight(lineHeight: number): void

  /**
   * 设置链接文本字符间距
   *
   * @param spacing 链接文本字符间距
   */
  setLinkTextLetterSpacing(spacing: number): void

  /**
   * 设置链接文本装饰线类型
   *
   * @param decorationType 链接文本装饰线类型
   */
  setLinkTextDecorationType(decorationType: TextDecorationType): void

  /**
   * 设置链接文本装饰线颜色
   *
   * @param color 链接文本装饰线颜色
   */
  setLinkTextDecorationColor(color: number): void

  /**
   * 设置链接文本装饰线样式
   *
   * @param style 链接文本装饰线样式
   */
  setLinkTextDecorationStyle(style: TextDecorationStyle): void

  /**
   * 设置链接文本背景颜色
   *
   * @param color 链接文本背景颜色
   */
  setLinkTextBackgroundColor(color: number): void

  /**
   * 设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setLinkTextBackgroundRadius(options: MarkdownRadiusOptions | number): void

  /**
   * 设置圆形图片格式链接主题背景颜色
   *
   * @param color 圆形图片格式链接主题背景颜色
   */
  setLinkCircleIconBackgroundColor(color: number): void

  /**
   * 设置圆形图片格式链接控件背景颜色
   *
   * @param color 圆形图片格式链接控件背景颜色
   */
  setLinkCircleIconButtonBackgroundColor(color: number): void

  /**
   * 设置圆形图片格式链接文字大小
   *
   * @param size 圆形图片格式链接文字大小
   */
  setLinkCircleIconTextSize(size: number): void

  /**
   * 设置圆形图片格式链接文字颜色
   *
   * @param color 圆形图片格式链接文字颜色
   */
  setLinkCircleIconTextColor(color: number): void

  /**
   * 设置圆形图片格式链接半径
   *
   * @param radius 圆形图片格式链接半径
   */
  setLinkCircleIconRadius(radius: number): void

  /**
   * 设置圆形图片格式链接左右外边距
   *
   * @param margin 圆形图片格式链接左右外边距
   */
  setLinkCircleIconMargin(margin: number): void

  /**
   * 设置圆角矩形图片格式链接主题背景颜色
   *
   * @param color 圆角矩形图片格式链接主题背景颜色
   */
  setLinkRectIconBackgroundColor(color: number): void

  /**
   * 设置圆角矩形图片格式链接控件背景颜色
   *
   * @param color 圆角矩形图片格式链接控件背景颜色
   */
  setLinkRectIconButtonBackgroundColor(color: number): void

  /**
   * 设置圆角矩形图片格式链接文字大小
   *
   * @param size 圆角矩形图片格式链接文字大小
   */
  setLinkRectIconTextSize(size: number): void

  /**
   * 设置圆角矩形图片格式链接文字颜色
   *
   * @param color 圆角矩形图片格式链接文字颜色
   */
  setLinkRectIconTextColor(color: number): void

  /**
   * 设置圆角矩形图片格式链接控件高度
   *
   * @param height 圆角矩形图片格式链接控件高度
   */
  setLinkRectIconHeight(height: number): void

  /**
   * 设置圆角矩形图片格式链接左右内边距
   *
   * @param padding 圆角矩形图片格式链接左右内边距
   */
  setLinkRectIconPadding(padding: number): void

  /**
   * 设置圆角矩形图片格式链接圆角半径
   *
   * @param radius 圆角矩形图片格式链接圆角半径
   */
  setLinkRectIconRadius(radius: number): void

  /**
   * 设置圆角矩形图片格式链接左右外边距
   *
   * @param margin 圆角矩形图片格式链接左右外边距
   */
  setLinkRectIconMargin(margin: number): void

  /**
   * 设置空心圆角矩形图片格式链接主题背景颜色
   *
   * @param color 空心圆角矩形图片格式链接主题背景颜色
   */
  setLinkRectToolIconBackgroundColor(color: number): void

  /**
   * 设置空心圆角矩形图片格式链接控件背景颜色
   *
   * @param color 空心圆角矩形图片格式链接控件背景颜色
   */
  setLinkRectToolIconButtonBackgroundColor(color: number): void

  /**
   * 设置空心圆角矩形图片格式链接文字大小
   *
   * @param size 空心圆角矩形图片格式链接文字大小
   */
  setLinkRectToolIconTextSize(size: number): void

  /**
   * 设置空心圆角矩形图片格式链接控件高度
   *
   * @param height 空心圆角矩形图片格式链接控件高度
   */
  setLinkRectToolIconHeight(height: number): void

  /**
   * 设置空心圆角矩形图片格式链接左右内边距
   *
   * @param padding 空心圆角矩形图片格式链接左右内边距
   */
  setLinkRectToolIconPadding(padding: number): void

  /**
   * 设置空心圆角矩形图片格式链接边框宽度
   *
   * @param width 空心圆角矩形图片格式链接边框宽度
   */
  setLinkRectToolIconBorderWidth(width: number): void

  /**
   * 设置空心圆角矩形图片格式链接分割线宽度
   *
   * @param width 空心圆角矩形图片格式链接分割线宽度
   */
  setLinkRectToolIconDividingLineWidth(width: number): void

  /**
   * 设置空心圆角矩形图片格式链接左右外边距
   *
   * @param margin 空心圆角矩形图片格式链接左右外边距
   */
  setLinkRectToolIconMargin(margin: number): void

  /**
   * 设置空心圆角矩形图片格式分割线和文本左边距
   *
   * @param padding 空心圆角矩形图片格式分割线和文本左边距
   */
  setLinkRectToolIconLineLeftPadding(padding: number): void

  /**
   * 设置空心圆角矩形图片格式分割线和文本右边距
   *
   * @param padding 空心圆角矩形图片格式分割线和文本右边距
   */
  setLinkRectToolIconLineRightPadding(padding: number): void
}
```

### class MarkdownThemeParagraph

Markdown用户可设置的样式-段落样式

```ets
export class MarkdownThemeParagraph {
  /**
   * 设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setParagraphMargin(options: MarkdownMarginOptions | number): void

  /**
   * 设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setParagraphPadding(options: MarkdownPaddingOptions | number): void

  /**
   * 设置段落文本颜色
   *
   * @param color 段落文本颜色
   */
  setParagraphTextFontColor(color: number): void

  /**
   * 设置段落文本尺寸
   *
   * @param size 段落文本尺寸
   */
  setParagraphTextFontSize(size: number): void

  /**
   * 设置段落文本字体样式
   *
   * @param style 段落文本字体样式
   */
  setParagraphTextFontStyle(style: FontStyle): void

  /**
   * 设置段落文本字体粗细
   *
   * @param weight 段落文本字体粗细
   */
  setParagraphTextFontWeight(weight: FontWeight): void

  /**
   * 设置段落文本字体
   *
   * @param family 段落文本字体
   */
  setParagraphTextFontFamily(family: string): void

  /**
   * 设置段落文本行高
   *
   * @param lineHeight 段落文本行高
   */
  setParagraphTextLineHeight(lineHeight: number): void

  /**
   * 设置段落文本字符间距
   *
   * @param spacing 段落文本字符间距
   */
  setParagraphTextLetterSpacing(spacing: number): void
}
```

### class MarkdownThemeInlineCode

Markdown用户可设置的样式-内联代码样式

```ets
export class MarkdownThemeInlineCode {
  /**
   * 设置内联代码文本尺寸
   *
   * @param size 内联代码文本尺寸
   */
  setInlineCodeTextFontSize(size: number): void

  /**
   * 设置内联代码文本字体样式
   *
   * @param style 内联代码文本字体样式
   */
  setInlineCodeTextFontStyle(style: FontStyle): void

  /**
   * 设置内联代码文本字体粗细
   *
   * @param weight 内联代码文本字体粗细
   */
  setInlineCodeTextFontWeight(weight: FontWeight): void

  /**
   * 设置内联代码文本字体
   *
   * @param family 内联代码文本字体
   */
  setInlineCodeTextFontFamily(family: string): void

  /**
   * 设置内联代码文本行高
   *
   * @param lineHeight 内联代码文本行高
   */
  setInlineCodeTextLineHeight(lineHeight: number): void

  /**
   * 设置内联代码文本字符间距
   *
   * @param spacing 内联代码文本字符间距
   */
  setInlineCodeTextLetterSpacing(spacing: number): void

  /**
   * 设置内联代码文本背景颜色
   *
   * @param color 内联代码文本背景颜色
   */
  setInlineCodeTextBackgroundColor(color: number): void

  /**
   * 设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setInlineCodeTextBackgroundRadius(options: MarkdownRadiusOptions | number): void
}
```

### class MarkdownThemeTable

Markdown用户可设置的样式-表格样式

```ets
export class MarkdownThemeTable {
  /**
   * 设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setTableMargin(options: MarkdownMarginOptions | number): void

  /**
   * 设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setTablePadding(options: MarkdownPaddingOptions | number): void

  /**
   * 设置表格内容内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setTableCellPadding(options: MarkdownPaddingOptions | number): void

  /**
   * 设置表格标题背景颜色
   *
   * @param color 表格标题背景颜色
   */
  setTableTitleBackgroundColor(color: number): void

  /**
   * 设置表格内容奇数行背景颜色
   *
   * @param color 奇数行背景颜色
   */
  setTableContentOddRowBackgroundColor(color: number): void

  /**
   * 设置表格内容偶数行背景颜色
   *
   * @param color 偶数行背景颜色
   */
  setTableContentEvenRowBackgroundColor(color: number): void

  /**
   * 设置表格边框样式
   *
   * @param style 表格边框样式
   */
  setTableBorderStyle(style: BorderStyle): void

  /**
   * 设置表格边框宽度
   *
   * @param width 表格边框宽度
   */
  setTableBorderWidth(width: number): void

  /**
   * 设置表格边框颜色
   *
   * @param color 表格边框颜色
   */
  setTableBorderColor(color: number): void

  /**
   * 分别设置表格边框4个圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setTableRadius(options: MarkdownRadiusOptions | number): void 

  /**
   * 设置表格滚动条状态
   *
   * @param state 滚动条状态
   */
  setTableScrollBarState(state: BarState): void

  /**
   * 设置表格滚动条颜色
   *
   * @param color 滚动条颜色
   */
  setTableScrollBarColor(color: number): void

  /**
   * 设置表格一格最小宽度
   *
   * @param width 最小宽度
   */
  setTableMinCellWidth(width: number): void

  /**
   * 设置表格一格最大宽度
   *
   * @param width 最大宽度
   */
  setTableMaxCellWidth(width: number): void

  /**
   * 设置表格第一列是否加粗
   *
   * @param isBold 是否加粗
   */
  setTableFirstColumnIsBold(isBold: boolean): void

  /**
   * 设置表格标题文本颜色
   *
   * @param color 表格标题文本颜色
   */
  setTableTitleTextFontColor(color: number): void

  /**
   * 设置表格标题文本尺寸
   *
   * @param size 表格标题文本尺寸
   */
  setTableTitleTextFontSize(size: number): void

  /**
   * 设置表格标题文本字体样式
   *
   * @param style 表格标题文本字体样式
   */
  setTableTitleTextFontStyle(style: FontStyle): void

  /**
   * 设置表格标题文本字体粗细
   *
   * @param weight 表格标题文本字体粗细
   */
  setTableTitleTextFontWeight(weight: FontWeight): void

  /**
   * 设置表格标题文本字体
   *
   * @param family 表格标题文本字体
   */
  setTableTitleTextFontFamily(family: string): void

  /**
   * 设置表格标题文本行高
   *
   * @param lineHeight 表格标题文本行高
   */
  setTableTitleTextLineHeight(lineHeight: number): void

  /**
   * 设置表格标题文本字符间距
   *
   * @param spacing 表格标题文本字符间距
   */
  setTableTitleTextLetterSpacing(spacing: number): void

  /**
   * 设置表格内容文本颜色
   *
   * @param color 表格内容文本颜色
   */
  setTableContentTextFontColor(color: number): void

  /**
   * 设置表格内容文本尺寸
   *
   * @param size 表格内容文本尺寸
   */
  setTableContentTextFontSize(size: number): void

  /**
   * 设置表格内容文本字体样式
   *
   * @param style 表格内容文本字体样式
   */
  setTableContentTextFontStyle(style: FontStyle): void

  /**
   * 设置表格内容文本字体粗细
   *
   * @param weight 表格内容文本字体粗细
   */
  setTableContentTextFontWeight(weight: FontWeight): void

  /**
   * 设置表格内容文本字体
   *
   * @param family 表格内容文本字体
   */
  setTableContentTextFontFamily(family: string): void

  /**
   * 设置表格内容文本行高
   *
   * @param lineHeight 表格内容文本行高
   */
  setTableContentTextLineHeight(lineHeight: number): void

  /**
   * 设置表格内容文本字符间距
   *
   * @param spacing 表格内容文本字符间距
   */
  setTableContentTextLetterSpacing(spacing: number): void
}
```

### class MarkdownThemeLatexMath

Markdown用户可设置的样式-数学公式样式

```ets
export class MarkdownThemeLatexMath {
  /**
   * 设置数学公式未加载状态文本颜色
   *
   * @param color 文本颜色
   */
  setLatexMathDefaultTextFontColor(color: number): void

  /**
   * 设置数学公式未加载状态文本尺寸
   *
   * @param size 文本尺寸
   */
  setLatexMathDefaultTextFontSize(size: number): void

  /**
   * 设置数学公式未加载状态文本字体样式
   *
   * @param style 字体样式
   */
  setLatexMathDefaultTextFontStyle(style: FontStyle): void

  /**
   * 设置数学公式未加载状态文本字体粗细
   *
   * @param weight 字体粗细
   */
  setLatexMathDefaultTextFontWeight(weight: FontWeight): void

  /**
   * 设置数学公式未加载状态文本字体
   *
   * @param family 字体
   */
  setLatexMathDefaultTextFontFamily(family: string): void

  /**
   * 设置数学公式文本大小
   *
   * @param size 文本大小
   */
  setLatexMathTextSize(size: number): void

  /**
   * 设置数学公式背景色
   *
   * @param color 背景色
   */
  setLatexMathBackgroundColor(color: number): void

  /**
   * 设置数学公式文本颜色
   *
   * @param color 文本颜色
   */
  setLatexMathTextColor(color: number): void

  /**
   * 设置数学公式生成图片格式
   *
   * @param format 生成图片格式
   */
  setLatexMathColorFormat(format: LatexMathColorFormat): void

  /**
   * 设置块结构的数学公式是否居中
   *
   * @param center 是否居中
   */
  setLatexMathBlockCenter(center: boolean): void

  /**
   * 设置数学公式字体路径
   *
   * @param path 字体路径
   */
  setLatexMathResPath(path: string): void

  /**
   * 设置LaTeX数学公式外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setLatexMathMargin(options: MarkdownMarginOptions | number): void

  /**
   * 设置LaTeX数学公式内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setLatexMathPadding(options: MarkdownPaddingOptions | number): void
}
```

### class MarkdownThemeFootnoteRef

Markdown用户可设置的样式-脚注引用样式

```ets
export class MarkdownThemeFootnoteRef {
  /**
   * 设置脚注引用文本尺寸
   *
   * @param size 脚注引用文本尺寸
   */
  setFootnoteRefTextFontSize(size: number): void

  /**
   * 设置脚注引用文本字体样式
   *
   * @param style 脚注引用文本字体样式
   */
  setFootnoteRefTextFontStyle(style: FontStyle): void

  /**
   * 设置脚注引用文本字体粗细
   *
   * @param weight 脚注引用文本字体粗细
   */
  setFootnoteRefTextFontWeight(weight: FontWeight): void

  /**
   * 设置脚注引用文本字体
   *
   * @param family 脚注引用文本字体
   */
  setFootnoteRefTextFontFamily(family: string): void

  /**
   * 设置脚注引用文本行高
   *
   * @param lineHeight 脚注引用文本行高
   */
  setFootnoteRefTextLineHeight(lineHeight: number): void

  /**
   * 设置脚注引用文本字符间距
   *
   * @param spacing 脚注引用文本字符间距
   */
  setFootnoteRefTextLetterSpacing(spacing: number): void

  /**
   * 设置脚注引用文本装饰线类型
   *
   * @param decorationType 脚注引用文本装饰线类型
   */
  setFootnoteRefTextDecorationType(decorationType: TextDecorationType): void

  /**
   * 设置脚注引用文本装饰线颜色
   *
   * @param color 脚注引用文本装饰线颜色
   */
  setFootnoteRefTextDecorationColor(color: number): void

  /**
   * 设置脚注引用文本装饰线样式
   *
   * @param style 脚注引用文本装饰线样式
   */
  setFootnoteRefTextDecorationStyle(style: MarkdownTextDecorationStyle): void

  /**
   * 设置脚注引用文本背景颜色
   *
   * @param color 脚注引用文本背景颜色
   */
  setFootnoteRefTextBackgroundColor(color: number): void

  /**
   * 设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setFootnoteRefTextBackgroundRadius(options: MarkdownRadiusOptions | number): void
}
```

### class MarkdownThemeFootnoteDef

Markdown用户可设置的样式-脚注定义样式

```ets
export class MarkdownThemeFootnoteDef {
  /**
   * 设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setFootnoteDefMargin(options: MarkdownMarginOptions | number): void 

  /**
   * 设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setFootnoteDefPadding(options: MarkdownPaddingOptions | number): void 
}
```

### class MarkdownThemeDefinitionList

Markdown用户可设置的样式-定义列表样式

```ets
export class MarkdownThemeDefinitionList {
  /**
   * 设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setDefinitionListMargin(options: MarkdownMarginOptions | number): void 

  /**
   * 设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setDefinitionListPadding(options: MarkdownPaddingOptions | number): void

  /**
   * 设置定义列表背景颜色
   *
   * @param color 定义列表背景颜色
   */
  setDefinitionListBackgroundColor(color: number): void

  /**
   * 设置定义列表术语和定义行之间间距
   *
   * @param spacing 间距
   */
  setDefinitionListTermToDescriptionSpacing(spacing: number): void

  /**
   * 设置定义列表术语文本字体粗细
   *
   * @param weight 文本字体粗细
   */
  setDefinitionListTermTextFontWeight(weight: FontWeight): void

  /**
   * 设置定义列表术语文本字体样式
   *
   * @param style 定义列表术语文本字体样式
   */
  setDefinitionListTermTextFontStyle(style: FontStyle): void

  /**
   * 设置定义列表定义行之间间距
   *
   * @param spacing 间距
   */
  setDefinitionListDescriptionItemSpacing(spacing: number): void

  /**
   * 设置定义列表定义行左缩进距离
   *
   * @param indent 左缩进距离
   */
  setDefinitionListDescriptionIndent(indent: number): void
}
```

### class MarkdownThemeOrderedList

Markdown用户可设置的样式-有序列表样式

```ets
export class MarkdownThemeOrderedList {
  /**
   * 设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setOrderedListMargin(options: MarkdownMarginOptions | number): void 

  /**
   * 设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setOrderedListPadding(options: MarkdownPaddingOptions | number): void

  /**
   * 设置有序列表子模块上下间距
   *
   * @param spacing 上下间距
   */
  setOrderedListChildSpacing(spacing: number): void

  /**
   * 设置有序列表子模块中子模块上下间距
   *
   * @param spacing 上下间距
   */
  setOrderedListChildChildSpacing(spacing: number): void

  /**
   * 设置有序列表列表编号和列表内容间距
   *
   * @param spacing 间距
   */
  setOrderedListMarkerSpacing(spacing: number): void

  /**
   * 设置有序列表列表编号文本颜色
   *
   * @param color 列表编号文本颜色
   */
  setOrderedListMarkerTextFontColor(color: number): void

  /**
   * 设置有序列表列表编号文本尺寸
   *
   * @param size 列表编号文本尺寸
   */
  setOrderedListMarkerTextFontSize(size: number): void

  /**
   * 设置有序列表列表编号文本字体样式
   *
   * @param style 列表编号文本字体样式
   */
  setOrderedListMarkerTextFontStyle(style: FontStyle): void

  /**
   * 设置有序列表列表编号文本字体粗细
   *
   * @param weight 列表编号文本字体粗细
   */
  setOrderedListMarkerTextFontWeight(weight: FontWeight): void

  /**
   * 设置有序列表列表编号文本字体
   *
   * @param family 列表编号文本字体
   */
  setOrderedListMarkerTextFontFamily(family: string): void

  /**
   * 设置有序列表列表编号文本行高
   *
   * @param lineHeight 列表编号文本行高
   */
  setOrderedListMarkerTextLineHeight(lineHeight: number): void
}
```

### class MarkdownThemeBulletList

Markdown用户可设置的样式-无序/任务列表样式

```ets
export class MarkdownThemeBulletList {
  /**
   * 设置无序/任务外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setBulletListMargin(options: MarkdownMarginOptions | number): void 

  /**
   * 设置无序/任务内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setBulletListPadding(options: MarkdownPaddingOptions | number): void 

  /**
   * 设置无序/任务子模块上下间距
   *
   * @param spacing 无序/任务子模块上下间距
   */
  setBulletListChildSpacing(spacing: number): void

  /**
   * 设置无序/任务子模块中子模块上下间距
   *
   * @param spacing 无序/任务子模块中子模块上下间距
   */
  setBulletListChildChildSpacing(spacing: number): void

  /**
   * 设置无序列表列表符号和列表内容间距
   *
   * @param spacing 无序列表列表符号和列表内容间距
   */
  setBulletListBulletSpacing(spacing: number): void

  /**
   * 设置无序列表列表符号是否全部是实心圆型
   *
   * @param isCircle 无序列表列表符号是否全部是实心圆型
   */
  setBulletListBulletIsCircle(isCircle: boolean): void

  /**
   * 设置无序列表列表符号文本颜色
   *
   * @param color 无序列表列表符号文本颜色
   */
  setBulletListBulletTextFontColor(color: number): void

  /**
   * 设置无序列表列表符号文本尺寸
   *
   * @param size 无序列表列表符号文本尺寸
   */
  setBulletListBulletTextFontSize(size: number): void

  /**
   * 设置无序列表列表符号文本字体样式
   *
   * @param style 无序列表列表符号文本字体样式
   */
  setBulletListBulletTextFontStyle(style: FontStyle): void

  /**
   * 设置无序列表列表符号文本字体粗细
   *
   * @param weight 无序列表列表符号文本字体粗细
   */
  setBulletListBulletTextFontWeight(weight: FontWeight): void

  /**
   * 设置无序列表列表符号文本字体
   *
   * @param family 无序列表列表符号文本字体
   */
  setBulletListBulletTextFontFamily(family: string): void

  /**
   * 设置无序列表列表符号文本行高
   *
   * @param lineHeight 无序列表列表符号文本行高
   */
  setBulletListBulletTextLineHeight(lineHeight: number): void

  /**
   * 设置任务列表多选框和列表内容间距
   *
   * @param spacing 任务列表多选框和列表内容间距
   */
  setBulletListCheckboxSpacing(spacing: number): void

  /**
   * 设置任务列表多选框宽度
   *
   * @param width 任务列表多选框宽度
   */
  setBulletListCheckboxWidth(width: number): void

  /**
   * 设置任务列表多选框高度
   *
   * @param height 任务列表多选框高度
   */
  setBulletListCheckboxHeight(height: number): void

  /**
   * 设置任务列表多选框选中颜色
   *
   * @param color 任务列表多选框选中颜色
   */
  setBulletListCheckboxSelectedColor(color: number): void

  /**
   * 设置任务列表多选框形状
   *
   * @param shape 任务列表多选框形状
   */
  setBulletListCheckboxShape(shape: CheckBoxShape): void
}
```

### class MarkdownThemeImage

Markdown用户可设置的样式-图片样式

```ets
export class MarkdownThemeImage {
  /**
   * 设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setImageMargin(options: MarkdownMarginOptions | number): void

  /**
   * 设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setImageBorderRadius(options: MarkdownRadiusOptions | number): void

  /**
   * 设置图片边框样式
   *
   * @param borderStyle 图片边框样式
   */
  setImageBorderStyle(borderStyle: BorderStyle): void

  /**
   * 设置图片边框宽度
   *
   * @param borderWidth 图片边框宽度
   */
  setImageBorderWidth(borderWidth: number): void

  /**
   * 设置图片边框颜色
   *
   * @param borderColor 图片边框颜色
   */
  setImageBorderColor(borderColor: number): void

  /**
   * 设置图片默认占位图
   *
   * @param placeholder 图片默认占位图
   */
  setImagePlaceholder(placeholder: Resource): void

  /**
   * 设置网络图片是否压缩
   *
   * @param imageAutoResize 网络图片是否压缩
   */
  setImageAutoResize(imageAutoResize: boolean): void

  /**
   * 设置是否图文混排
   *
   * @param mixedLayout 是否图文混排
   */
  setIsImageMixedLayout(mixedLayout: boolean): void

  /**
   * 设置图片基于自身宽度缩放百分比
   *
   * @param maximumWidth 图片基于自身宽度缩放百分比
   */
  setImageMaximumWidth(maximumWidth: number): void

  /**
   * 设置图片基于父布局宽度缩放百分比
   *
   * @param fixedRatioWidth 图片基于父布局宽度缩放百分比
   */
  setImageFixedRatioWidth(fixedRatioWidth: number): void

  /**
   * 设置图片最大高度
   *
   * @param maxHeight 图片最大高度
   */
  setImageMaxHeight(maxHeight: number): void

  /**
   * 设置图片高度
   *
   * @param height 图片高度
   */
  setImageHeight(height: number): void

  /**
   * 设置图片最大宽度
   *
   * @param maxWidth 图片最大宽度
   */
  setImageMaxWidth(maxWidth: number): void

  /**
   * 设置图片宽度
   *
   * @param width 图片宽度
   */
  setImageWidth(width: number): void

  /**
   * 设置图片缩放类型
   *
   * @param fitType 图片缩放类型
   */
  setImageFitType(fitType: ImageFitType): void

  /**
   * 设置底部布局距离图片上边距
   *
   * @param marginTop 底部布局距离图片上边距
   */
  setImageBottomLayoutMarginTop(marginTop: number): void

  /**
   * 设置图片下载按钮是否显示
   *
   * @param visible 图片下载按钮是否显示
   */
  setImageDownloadButtonVisible(visible: boolean): void

  /**
   * 设置图片下载按钮宽度
   *
   * @param width 图片下载按钮宽度
   */
  setImageDownloadButtonWidth(width: number): void

  /**
   * 设置图片下载按钮高度
   *
   * @param height 图片下载按钮高度
   */
  setImageDownloadButtonHeight(height: number): void

  /**
   * 设置图片下载按钮圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setImageDownloadButtonRadius(options: MarkdownRadiusOptions | number): void

  /**
   * 设置图片下载按钮图标
   *
   * @param icon 图片下载按钮图标
   */
  setImageDownloadButtonIcon(icon: Resource): void

  /**
   * 设置图片下载按钮图标宽度
   *
   * @param width 图片下载按钮图标宽度
   */
  setImageDownloadButtonIconWidth(width: number): void

  /**
   * 设置图片下载按钮图标高度
   *
   * @param height 图片下载按钮图标高度
   */
  setImageDownloadButtonIconHeight(height: number): void

  /**
   * 设置图片下载按钮图标和文本间距
   *
   * @param gap 图片下载按钮图标和文本间距
   */
  setImageDownloadButtonIconTextGap(gap: number): void

  /**
   * 设置图片下载按钮背景颜色
   *
   * @param color 图片下载按钮背景颜色
   */
  setImageDownloadButtonBackgroundColor(color: number): void

  /**
   * 设置图片下载按钮默认文本内容
   *
   * @param text 图片下载按钮默认文本内容
   */
  setImageDownloadButtonText(text: string): void

  /**
   * 设置图片下载按钮文本颜色
   *
   * @param color 图片下载按钮文本颜色
   */
  setImageDownloadButtonTextFontColor(color: number): void

  /**
   * 设置图片下载按钮文本尺寸
   *
   * @param size 图片下载按钮文本尺寸
   */
  setImageDownloadButtonTextFontSize(size: number): void

  /**
   * 设置图片下载按钮文本字体样式
   *
   * @param style 图片下载按钮文本字体样式
   */
  setImageDownloadButtonTextFontStyle(style: FontStyle): void

  /**
   * 设置图片下载按钮文本字体粗细
   *
   * @param weight 图片下载按钮文本字体粗细
   */
  setImageDownloadButtonTextFontWeight(weight: FontWeight): void

  /**
   * 设置图片下载按钮文本字体
   *
   * @param family 图片下载按钮文本字体
   */
  setImageDownloadButtonTextFontFamily(family: string): void

  /**
   * 设置图片下载按钮文本行高
   *
   * @param lineHeight 图片下载按钮文本行高
   */
  setImageDownloadButtonTextLineHeight(lineHeight: number): void
}
```

### class MarkdownThemeAudio

Markdown用户可设置的样式-音频样式

```ets
export class MarkdownThemeAudio {
  /**
   * 音频设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setAudioMargin(options: MarkdownMarginOptions | number): void 

  /**
   * 音频设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setAudioPadding(options: MarkdownPaddingOptions | number): void

  /**
   * 设置音频边框样式
   *
   * @param borderStyle 音频边框样式
   */
  setAudioBorderStyle(borderStyle: BorderStyle): void

  /**
   * 设置音频边框宽度
   *
   * @param borderWidth 音频边框宽度
   */
  setAudioBorderWidth(borderWidth: number): void

  /**
   * 设置音频边框颜色
   *
   * @param borderColor 音频边框颜色
   */
  setAudioBorderColor(borderColor: number): void

  /**
   * 音频设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setAudioBorderRadius(options: MarkdownRadiusOptions | number): void 

  /**
   * 设置音频阴影模糊半径
   *
   * @param radius 音频阴影模糊半径
   */
  setAudioShadowRadius(radius: number): void

  /**
   * 设置音频阴影X轴偏移量
   *
   * @param offsetX 音频阴影X轴偏移量
   */
  setAudioShadowOffsetX(offsetX: number): void

  /**
   * 设置音频阴影Y轴偏移量
   *
   * @param offsetY 音频阴影Y轴偏移量
   */
  setAudioShadowOffsetY(offsetY: number): void

  /**
   * 设置音频图标
   *
   * @param icon 音频图标
   */
  setAudioIcon(icon: Resource): void

  /**
   * 设置音频图标宽度
   *
   * @param width 音频图标宽度
   */
  setAudioIconWidth(width: number): void

  /**
   * 设置音频图标高度
   *
   * @param height 音频图标高度
   */
  setAudioIconHeight(height: number): void

  /**
   * 音频图标设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setAudioIconRadius(options: MarkdownRadiusOptions | number): void 

  /**
   * 设置音频图标缩放类型
   *
   * @param fitType 音频图标缩放类型
   */
  setAudioIconFitType(fitType: ImageFit): void

  /**
   * 设置音频标题文本和类型文本间距
   *
   * @param spacing 音频标题文本和类型文本间距
   */
  setAudioTitleToTypeSpacing(spacing: number): void

  /**
   * 设置音频阴影颜色
   *
   * @param color 音频阴影颜色
   */
  setAudioShadowColor(color: number): void

  /**
   * 设置音频按钮宽度
   *
   * @param width 音频按钮宽度
   */
  setAudioButtonWidth(width: number): void

  /**
   * 设置音频按钮高度
   *
   * @param height 音频按钮高度
   */
  setAudioButtonHeight(height: number): void

  /**
   * 设置音频按钮背景颜色
   *
   * @param color 音频按钮背景颜色
   */
  setAudioButtonBackgroundColor(color: number): void

  /**
   * 设置音频按钮边框样式
   *
   * @param borderStyle 音频按钮边框样式
   */
  setAudioButtonBorderStyle(borderStyle: BorderStyle): void

  /**
   * 设置音频按钮边框宽度
   *
   * @param borderWidth 音频按钮边框宽度
   */
  setAudioButtonBorderWidth(borderWidth: number): void

  /**
   * 设置音频按钮边框颜色
   *
   * @param borderColor 音频按钮边框颜色
   */
  setAudioButtonBorderColor(borderColor: number): void

  /**
   * 音频按钮设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setAudioButtonRadius(options: MarkdownRadiusOptions | number): void

  /**
   * 设置音频按钮默认文本内容
   *
   * @param text 音频按钮默认文本内容
   */
  setAudioButtonText(text: string): void

  /**
   * 设置音频按钮文本颜色
   *
   * @param color 音频按钮文本颜色
   */
  setAudioButtonTextFontColor(color: number): void

  /**
   * 设置音频按钮文本尺寸
   *
   * @param size 音频按钮文本尺寸
   */
  setAudioButtonTextFontSize(size: number): void

  /**
   * 设置音频按钮文本字体样式
   *
   * @param style 音频按钮文本字体样式
   */
  setAudioButtonTextFontStyle(style: FontStyle): void

  /**
   * 设置音频按钮文本字体粗细
   *
   * @param weight 音频按钮文本字体粗细
   */
  setAudioButtonTextFontWeight(weight: FontWeight): void

  /**
   * 设置音频按钮文本字体
   *
   * @param family 音频按钮文本字体
   */
  setAudioButtonTextFontFamily(family: string): void

  /**
   * 设置音频按钮文本行高
   *
   * @param height 音频按钮文本行高
   */
  setAudioButtonTextLineHeight(height: number): void

  /**
   * 设置音频标题文本颜色
   *
   * @param color 音频标题文本颜色
   */
  setAudioTitleTextFontColor(color: number): void

  /**
   * 设置音频标题文本尺寸
   *
   * @param size 音频标题文本尺寸
   */
  setAudioTitleTextFontSize(size: number): void

  /**
   * 设置音频标题文本字体样式
   *
   * @param style 音频标题文本字体样式
   */
  setAudioTitleTextFontStyle(style: FontStyle): void

  /**
   * 设置音频标题文本字体粗细
   *
   * @param weight 音频标题文本字体粗细
   */
  setAudioTitleTextFontWeight(weight: FontWeight): void

  /**
   * 设置音频标题文本字体
   *
   * @param family 音频标题文本字体
   */
  setAudioTitleTextFontFamily(family: string): void

  /**
   * 设置音频标题文本行高
   *
   * @param height 音频标题文本行高
   */
  setAudioTitleTextLineHeight(height: number): void

  /**
   * 设置音频类型文本颜色
   *
   * @param color 音频类型文本颜色
   */
  setAudioTypeTextFontColor(color: number): void

  /**
   * 设置音频类型文本尺寸
   *
   * @param size 音频类型文本尺寸
   */
  setAudioTypeTextFontSize(size: number): void

  /**
   * 设置音频类型文本字体样式
   *
   * @param style 音频类型文本字体样式
   */
  setAudioTypeTextFontStyle(style: FontStyle): void

  /**
   * 设置音频类型文本字体粗细
   *
   * @param weight 音频类型文本字体粗细
   */
  setAudioTypeTextFontWeight(weight: FontWeight): void

  /**
   * 设置音频类型文本字体
   *
   * @param family 音频类型文本字体
   */
  setAudioTypeTextFontFamily(family: string): void

  /**
   * 设置音频类型文本行高
   *
   * @param height 音频类型文本行高
   */
  setAudioTypeTextLineHeight(height: number): void
}
```

### class MarkdownThemeVideo

Markdown用户可设置的样式-视频样式

```ets
export class MarkdownThemeVideo {
  /**
   * 设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setVideoMargin(options: MarkdownMarginOptions | number): void

  /**
   * 设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setVideoPadding(options: MarkdownPaddingOptions | number): void

  /**
   * 设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setVideoBorderRadius(options: MarkdownRadiusOptions | number): void

  /**
   * 设置视频边框样式
   *
   * @param borderStyle 视频边框样式
   */
  setVideoBorderStyle(borderStyle: BorderStyle): void

  /**
   * 设置视频边框宽度
   *
   * @param borderWidth 视频边框宽度
   */
  setVideoBorderWidth(borderWidth: number): void

  /**
   * 设置视频边框颜色
   *
   * @param borderColor 视频边框颜色
   */
  setVideoBorderColor(borderColor: number): void

  /**
   * 设置视频占位图
   *
   * @param resource 视频占位图
   */
  setVideoPlaceholder(resource: Resource): void

  /**
   * 设置视频图片缩放类型
   *
   * @param fitType 视频图片缩放类型
   */
  setVideoImageFitType(fitType: ImageFit): void

  /**
   * 设置播放按钮默认图片
   *
   * @param icon 播放按钮默认图片
   */
  setVideoPlayIcon(icon: Resource): void

  /**
   * 设置播放按钮图标宽度
   *
   * @param width 播放按钮图标宽度
   */
  setVideoPlayIconWidth(width: number): void

  /**
   * 设置播放按钮图标高度
   *
   * @param height 播放按钮图标高度
   */
  setVideoPlayIconHeight(height: number): void

  /**
   * 设置播放按钮图标缩放类型
   *
   * @param fitType 播放按钮图标缩放类型
   */
  setVideoPlayIconFitType(fitType: ImageFit): void

  /**
   * 设置视频时间文本颜色
   *
   * @param color 视频时间文本颜色
   */
  setVideoTimeTextFontColor(color: number): void

  /**
   * 设置视频时间文本尺寸
   *
   * @param size 视频时间文本尺寸
   */
  setVideoTimeTextFontSize(size: number): void

  /**
   * 设置视频时间文本字体样式
   *
   * @param style 视频时间文本字体样式
   */
  setVideoTimeTextFontStyle(style: FontStyle): void

  /**
   * 设置视频时间文本字体粗细
   *
   * @param weight 视频时间文本字体粗细
   */
  setVideoTimeTextFontWeight(weight: FontWeight): void

  /**
   * 设置视频时间文本字体
   *
   * @param family 视频时间文本字体
   */
  setVideoTimeTextFontFamily(family: string): void

  /**
   * 设置视频时间文本行高
   *
   * @param lineHeight 视频时间文本行高
   */
  setVideoTimeTextLineHeight(lineHeight: number): void

  /**
   * 设置视频时间文本居右边距
   *
   * @param margin 视频时间文本居右边距
   */
  setVideoTimeTextMarginRight(margin: number): void

  /**
   * 设置视频时间文本居底边距
   *
   * @param margin 视频时间文本居底边距
   */
  setVideoTimeTextMarginBottom(margin: number): void

  /**
   * 设置底部布局是否显示
   *
   * @param visible 底部布局是否显示
   */
  setVideoBottomLayoutVisible(visible: boolean): void

  /**
   * 设置底部布局距离视频上边距
   *
   * @param marginTop 底部布局距离视频上边距
   */
  setVideoBottomLayoutMarginTop(marginTop: number): void

  /**
   * 设置视频发布按钮是否显示
   *
   * @param visible 视频发布按钮是否显示
   */
  setVideoReleaseButtonVisible(visible: boolean): void

  /**
   * 设置视频发布按钮背景颜色
   *
   * @param color 视频发布按钮背景颜色
   */
  setVideoReleaseButtonBackgroundColor(color: number): void

  /**
   * 设置视频发布按钮宽度
   *
   * @param width 视频发布按钮宽度
   */
  setVideoReleaseButtonWidth(width: number): void

  /**
   * 设置视频发布按钮高度
   *
   * @param height 视频发布按钮高度
   */
  setVideoReleaseButtonHeight(height: number): void

  /**
   * 设置视频发布按钮圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setVideoReleaseButtonRadius(options: MarkdownRadiusOptions | number): void

  /**
   * 设置视频发布按钮图标和文本间距
   *
   * @param gap 视频发布按钮图标和文本间距
   */
  setVideoReleaseButtonIconTextGap(gap: number): void

  /**
   * 设置视频发布按钮图标
   *
   * @param icon 视频发布按钮图标
   */
  setVideoReleaseButtonIcon(icon: Resource): void

  /**
   * 设置视频发布按钮图标宽度
   *
   * @param width 视频发布按钮图标宽度
   */
  setVideoReleaseButtonIconWidth(width: number): void

  /**
   * 设置视频发布按钮图标高度
   *
   * @param height 视频发布按钮图标高度
   */
  setVideoReleaseButtonIconHeight(height: number): void

  /**
   * 设置视频发布按钮默认文本内容
   *
   * @param text 视频发布按钮默认文本内容
   */
  setVideoReleaseButtonText(text: string): void

  /**
   * 设置视频发布按钮文本颜色
   *
   * @param color 视频发布按钮文本颜色
   */
  setVideoReleaseButtonTextFontColor(color: number): void

  /**
   * 设置视频发布按钮文本尺寸
   *
   * @param size 视频发布按钮文本尺寸
   */
  setVideoReleaseButtonTextFontSize(size: number): void

  /**
   * 设置视频发布按钮文本字体样式
   *
   * @param style 视频发布按钮文本字体样式
   */
  setVideoReleaseButtonTextFontStyle(style: FontStyle): void

  /**
   * 设置视频发布按钮文本字体粗细
   *
   * @param weight 视频发布按钮文本字体粗细
   */
  setVideoReleaseButtonTextFontWeight(weight: FontWeight): void

  /**
   * 设置视频发布按钮文本字体
   *
   * @param family 视频发布按钮文本字体
   */
  setVideoReleaseButtonTextFontFamily(family: string): void

  /**
   * 设置视频发布按钮文本行高
   *
   * @param lineHeight 视频发布按钮文本行高
   */
  setVideoReleaseButtonTextLineHeight(lineHeight: number): void

  /**
   * 设置视频下载按钮是否显示
   *
   * @param visible 视频下载按钮是否显示
   */
  setVideoDownloadButtonVisible(visible: boolean): void

  /**
   * 设置视频下载按钮背景颜色
   *
   * @param color 视频下载按钮背景颜色
   */
  setVideoDownloadButtonBackgroundColor(color: number): void

  /**
   * 设置视频下载按钮宽度
   *
   * @param width 视频下载按钮宽度
   */
  setVideoDownloadButtonWidth(width: number): void

  /**
   * 设置视频下载按钮高度
   *
   * @param height 视频下载按钮高度
   */
  setVideoDownloadButtonHeight(height: number): void

  /**
   * 设置视频下载按钮圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setVideoDownloadButtonRadius(options: MarkdownRadiusOptions | number): void

  /**
   * 设置视频下载按钮图标和文本间距
   *
   * @param gap 视频下载按钮图标和文本间距
   */
  setVideoDownloadButtonIconTextGap(gap: number): void

  /**
   * 设置视频下载按钮图标
   *
   * @param icon 视频下载按钮图标
   */
  setVideoDownloadButtonIcon(icon: Resource): void

  /**
   * 设置视频下载按钮图标宽度
   *
   * @param width 视频下载按钮图标宽度
   */
  setVideoDownloadButtonIconWidth(width: number): void

  /**
   * 设置视频下载按钮图标高度
   *
   * @param height 视频下载按钮图标高度
   */
  setVideoDownloadButtonIconHeight(height: number): void

  /**
   * 设置视频下载按钮默认文本内容
   *
   * @param text 视频下载按钮默认文本内容
   */
  setVideoDownloadButtonText(text: string): void

  /**
   * 设置视频下载按钮文本颜色
   *
   * @param color 视频下载按钮文本颜色
   */
  setVideoDownloadButtonTextFontColor(color: number): void

  /**
   * 设置视频下载按钮文本尺寸
   *
   * @param size 视频下载按钮文本尺寸
   */
  setVideoDownloadButtonTextFontSize(size: number): void

  /**
   * 设置视频下载按钮文本字体样式
   *
   * @param style 视频下载按钮文本字体样式
   */
  setVideoDownloadButtonTextFontStyle(style: FontStyle): void

  /**
   * 设置视频下载按钮文本字体粗细
   *
   * @param weight 视频下载按钮文本字体粗细
   */
  setVideoDownloadButtonTextFontWeight(weight: FontWeight): void

  /**
   * 设置视频下载按钮文本字体
   *
   * @param family 视频下载按钮文本字体
   */
  setVideoDownloadButtonTextFontFamily(family: string): void

  /**
   * 设置视频下载按钮文本行高
   *
   * @param lineHeight 视频下载按钮文本行高
   */
  setVideoDownloadButtonTextLineHeight(lineHeight: number): void
}
```

### class MarkdownThemeCodeBlock

Markdown用户可设置的样式-代码块样式

```ets
export class MarkdownThemeCodeBlock {
  /**
   * 设置是否格式化围栏代码块内容
   *
   * @param isCodeFormat 是否格式化围栏代码块内容
   */
  setCodeBlockIsCodeFormat(isCodeFormat: boolean): void

  /**
   * 设置codeformat是否用制表符
   *
   * @param useTab 是否用制表符
   */
  setCodeBlockUseTab(useTab: boolean): void

  /**
   * 设置codeformat空格缩进数量
   *
   * @param indentWidth 空格缩进数量
   */
  setCodeBlockIndentWidth(indentWidth: number): void

  /**
   * 设置围栏代码块代码高亮是否同步解析
   *
   * @param parserSync 是否同步解析
   */
  setCodeBlockParserSync(parserSync: boolean): void

  /**
   * 设置代码块背景颜色
   *
   * @param color 代码块背景颜色
   */
  setCodeBlockBackgroundColor(color: number): void

  /**
   * 代码块设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setCodeBlockMargin(options: MarkdownMarginOptions | number): void

  /**
   * 代码块设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setCodeBlockPadding(options: MarkdownPaddingOptions | number): void

  /**
   * 设置代码块边框样式
   *
   * @param borderStyle 代码块边框样式
   */
  setCodeBlockBorderStyle(borderStyle: BorderStyle): void

  /**
   * 设置代码块边框宽度
   *
   * @param borderWidth 代码块边框宽度
   */
  setCodeBlockBorderWidth(borderWidth: number): void

  /**
   * 设置代码块边框颜色
   *
   * @param borderColor 代码块边框颜色
   */
  setCodeBlockBorderColor(borderColor: number): void

  /**
   * 代码块设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setCodeBlockRadius(options: MarkdownRadiusOptions | number): void

  /**
   * 设置代码块类型和代码块内容间距
   *
   * @param marginBottom 代码块类型和代码块内容间距
   */
  setCodeBlockTitleLayoutMarginBottom(marginBottom: number): void

  /**
   * 设置代码块类型左边距
   *
   * @param marginLeft 代码块类型左边距
   */
  setCodeBlockTypeTextMarginLeft(marginLeft: number): void

  /**
   * 设置代码块没有代码类型时默认显示文本
   *
   * @param text 默认显示文本
   */
  setCodeBlockTypeText(text: string): void

  /**
   * 设置代码块类型文本颜色
   *
   * @param color 代码块类型文本颜色
   */
  setCodeBlockTypeTextFontColor(color: number): void

  /**
   * 设置代码块类型文本尺寸
   *
   * @param size 代码块类型文本尺寸
   */
  setCodeBlockTypeTextFontSize(size: number): void

  /**
   * 设置代码块类型文本字体样式
   *
   * @param style 代码块类型文本字体样式
   */
  setCodeBlockTypeTextFontStyle(style: FontStyle): void

  /**
   * 设置代码块类型文本字体粗细
   *
   * @param weight 代码块类型文本字体粗细
   */
  setCodeBlockTypeTextFontWeight(weight: FontWeight): void

  /**
   * 设置代码块类型文本字体
   *
   * @param family 代码块类型文本字体
   */
  setCodeBlockTypeTextFontFamily(family: string): void

  /**
   * 设置代码块类型文本行高
   *
   * @param height 代码块类型文本行高
   */
  setCodeBlockTypeTextLineHeight(height: number): void

  /**
   * 设置代码块代码复制和代码全屏间距
   *
   * @param spacing 代码块代码复制和代码全屏间距
   */
  setCodeBlockCopyFullScreenSpacing(spacing: number): void

  /**
   * 设置代码块代码复制按钮是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockCopyButtonIsShow(isShow: boolean): void

  /**
   * 设置代码块代码复制文本是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockCopyTextIsShow(isShow: boolean): void

  /**
   * 设置代码块代码复制按钮默认图标
   *
   * @param icon 默认图标
   */
  setCodeBlockCopyIcon(icon: Resource): void

  /**
   * 设置代码块代码复制图标宽度
   *
   * @param width 图标宽度
   */
  setCodeBlockCopyIconWidth(width: number): void

  /**
   * 设置代码块代码复制图标高度
   *
   * @param height 图标高度
   */
  setCodeBlockCopyIconHeight(height: number): void

  /**
   * 设置代码块代码复制图标和文本间距
   *
   * @param spacing 代码块代码复制图标和文本间距
   */
  setCodeBlockCopyIconTextSpacing(spacing: number): void

  /**
   * 设置代码块代码复制默认文本内容
   *
   * @param text 默认文本内容
   */
  setCodeBlockCopyText(text: string): void

  /**
   * 设置代码块代码复制文本颜色
   *
   * @param color 代码块代码复制文本颜色
   */
  setCodeBlockCopyTextFontColor(color: number): void

  /**
   * 设置代码块代码复制文本尺寸
   *
   * @param size 代码块代码复制文本尺寸
   */
  setCodeBlockCopyTextFontSize(size: number): void

  /**
   * 设置代码块代码复制文本字体样式
   *
   * @param style 代码块代码复制文本字体样式
   */
  setCodeBlockCopyTextFontStyle(style: FontStyle): void

  /**
   * 设置代码块代码复制文本字体粗细
   *
   * @param weight 代码块代码复制文本字体粗细
   */
  setCodeBlockCopyTextFontWeight(weight: FontWeight): void

  /**
   * 设置代码块代码复制文本字体
   *
   * @param family 代码块代码复制文本字体
   */
  setCodeBlockCopyTextFontFamily(family: string): void

  /**
   * 设置代码块代码复制文本行高
   *
   * @param height 代码块代码复制文本行高
   */
  setCodeBlockCopyTextLineHeight(height: number): void

  /**
   * 设置代码块代码全屏按钮是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockFullScreenButtonIsShow(isShow: boolean): void

  /**
   * 设置代码块代码全屏文本是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockFullScreenTextIsShow(isShow: boolean): void

  /**
   * 设置代码块代码全屏按钮默认图标
   *
   * @param icon 默认图标
   */
  setCodeBlockFullScreenIcon(icon: Resource): void

  /**
   * 设置代码块代码全屏图标宽度
   *
   * @param width 图标宽度
   */
  setCodeBlockFullScreenIconWidth(width: number): void

  /**
   * 设置代码块代码全屏图标高度
   *
   * @param height 图标高度
   */
  setCodeBlockFullScreenIconHeight(height: number): void

  /**
   * 设置代码块代码全屏图标和文本间距
   *
   * @param spacing 代码块代码全屏图标和文本间距
   */
  setCodeBlockFullScreenIconTextSpacing(spacing: number): void

  /**
   * 设置代码块代码全屏默认文本内容
   *
   * @param text 默认文本内容
   */
  setCodeBlockFullScreenText(text: string): void

  /**
   * 设置代码块代码全屏文本颜色
   *
   * @param color 代码块代码全屏文本颜色
   */
  setCodeBlockFullScreenTextFontColor(color: number): void

  /**
   * 设置代码块代码全屏文本尺寸
   *
   * @param size 代码块代码全屏文本尺寸
   */
  setCodeBlockFullScreenTextFontSize(size: number): void

  /**
   * 设置代码块代码全屏文本字体样式
   *
   * @param style 代码块代码全屏文本字体样式
   */
  setCodeBlockFullScreenTextFontStyle(style: FontStyle): void

  /**
   * 设置代码块代码全屏文本字体粗细
   *
   * @param weight 代码块代码全屏文本字体粗细
   */
  setCodeBlockFullScreenTextFontWeight(weight: FontWeight): void

  /**
   * 设置代码块代码全屏文本字体
   *
   * @param family 代码块代码全屏文本字体
   */
  setCodeBlockFullScreenTextFontFamily(family: string): void

  /**
   * 设置代码块代码全屏文本行高
   *
   * @param height 代码块代码全屏文本行高
   */
  setCodeBlockFullScreenTextLineHeight(height: number): void

  /**
   * 设置代码块代码行号是否显示
   *
   * @param isShow 是否显示
   */
  setCodeBlockLineNumberIsShow(isShow: boolean): void

  /**
   * 设置代码块代码行号左内边距
   *
   * @param left 代码块代码行号左内边距
   */
  setCodeBlockLineNumberTextPaddingLeft(left: number): void

  /**
   * 设置代码块代码行号文本颜色
   *
   * @param color 代码块代码行号文本颜色
   */
  setCodeBlockLineNumberTextFontColor(color: number): void

  /**
   * 设置代码块代码行号文本尺寸
   *
   * @param size 代码块代码行号文本尺寸
   */
  setCodeBlockLineNumberTextFontSize(size: number): void

  /**
   * 设置代码块代码行号文本字体样式
   *
   * @param style 代码块代码行号文本字体样式
   */
  setCodeBlockLineNumberTextFontStyle(style: FontStyle): void

  /**
   * 设置代码块代码行号文本字体粗细
   *
   * @param weight 代码块代码行号文本字体粗细
   */
  setCodeBlockLineNumberTextFontWeight(weight: FontWeight): void

  /**
   * 设置代码块代码行号文本字体
   *
   * @param family 代码块代码行号文本字体
   */
  setCodeBlockLineNumberTextFontFamily(family: string): void

  /**
   * 设置代码块代码行号文本行高
   *
   * @param height 代码块代码行号文本行高
   */
  setCodeBlockLineNumberTextLineHeight(height: number): void

  /**
   * 设置代码块代码行号和代码块中间分割线颜色
   *
   * @param color 分割线颜色
   */
  setCodeBlockDividerColor(color: number): void

  /**
   * 设置代码块代码行号和代码块中间分割线宽度
   *
   * @param strokeWidth 分割线宽度
   */
  setCodeBlockDividerStrokeWidth(strokeWidth: number): void

  /**
   * 设置代码块代码行号和分割线间距
   *
   * @param spacing 代码块代码行号和分割线间距
   */
  setCodeBlockLineNumberDividerSpacing(spacing: number): void

  /**
   * 设置代码块文本颜色
   *
   * @param color 代码块文本颜色
   */
  setCodeBlockTextFontColor(color: number): void

  /**
   * 设置代码块代码文本右外边距
   *
   * @param marginRight 代码块代码文本右外边距
   */
  setCodeBlockTextMarginRight(marginRight: number): void

  /**
   * 设置代码块代码文本左外边距
   *
   * @param marginLeft 代码块代码文本左外边距
   */
  setCodeBlockTextMarginLeft(marginLeft: number): void

  /**
   * 设置代码块文本尺寸
   *
   * @param size 代码块文本尺寸
   */
  setCodeBlockTextFontSize(size: number): void

  /**
   * 设置代码块文本字体样式
   *
   * @param style 代码块文本字体样式
   */
  setCodeBlockTextFontStyle(style: FontStyle): void

  /**
   * 设置代码块文本字体粗细
   *
   * @param weight 代码块文本字体粗细
   */
  setCodeBlockTextFontWeight(weight: FontWeight): void

  /**
   * 设置代码块文本字体
   *
   * @param family 代码块文本字体
   */
  setCodeBlockTextFontFamily(family: string): void

  /**
   * 设置代码块文本行高
   *
   * @param height 代码块文本行高
   */
  setCodeBlockTextLineHeight(height: number): void

  /**
   * 设置代码块文本字符间距
   *
   * @param spacing 代码块文本字符间距
   */
  setCodeBlockTextLetterSpacing(spacing: number): void

  /**
   * 设置组合代码块未选中标题字体大小
   *
   * @param size 字体大小
   */
  setCodeBlockListTitleTextSize(size: number): void

  /**
   * 设置组合代码块选中标题字体大小
   *
   * @param size 字体大小
   */
  setCodeBlockListTitleSelectTextSize(size: number): void

  /**
   * 设置组合代码块选中标题文本颜色
   *
   * @param color 文本颜色
   */
  setCodeBlockListTitleSelectTextColor(color: number): void

  /**
   * 设置组合代码块未选中标题文本颜色
   *
   * @param color 文本颜色
   */
  setCodeBlockListTitleUnselectTextColor(color: number): void

  /**
   * 设置组合代码块选中标题背景颜色
   *
   * @param color 背景颜色
   */
  setCodeBlockListTitleSelectBackgroundColor(color: number): void

  /**
   * 设置组合代码块未选中标题背景颜色
   *
   * @param color 背景颜色
   */
  setCodeBlockListTitleUnselectBackgroundColor(color: number): void

  /**
   * 设置是否单独代码块显示
   *
   * @param isSeparate 是否单独显示
   */
  setCodeBlockIsSeparate(isSeparate: boolean): void

  /**
   * 设置单独代码块行号宽度
   *
   * @param width 行号宽度
   */
  setCodeBlockSeparateWidth(width: number): void

  /**
   * 设置单独代码块是否居底显示
   *
   * @param isBottom 是否居底
   */
  setCodeBlockSeparateIsBottom(isBottom: boolean): void
}
```

### class MarkdownThemeHeading

Markdown用户可设置的样式-标题样式

```ets
export class MarkdownThemeHeading {
  /**
   * 设置标题的背景颜色：通过集合的方式，分别设置每级标题的背景颜色
   *
   * @param colorList 背景颜色集合
   */
  setBackgroundColorForEachHeading(colorList: number[]): void

  /**
   * 设置标题的背景颜色：指定标题等级，设置该等级标题的背景颜色
   *
   * @param level 标题等级
   * @param color 背景颜色
   */
  setBackgroundColorForDesignateHeading(level: number, color: number): void

  /**
   * 设置标题的4个外边距：设置H1-H6级标题，所有等级的某一个外边距为统一值
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时所有外边距设为相同值
   *                  入参 MarkdownMarginOptions 类型时设置H1-H6级的top（right, bottom, left）外边距为统一值
   */
  setMarginForAllHeadingEachLevel(options: MarkdownMarginOptions | number): void

  /**
   * 设置标题的4个外边距：设置H1-H6级标题，每级标题自己的4个外边距为统一值
   *
   * @param marginList 外边距集合
   */
  setMarginForEachHeading(marginList: number[]): void

  /**
   * 设置标题的4个外边距：分别设置H1-H6每级标题的每个外边距
   *
   * @param top 上外边距集合
   * @param right 右外边距集合
   * @param bottom 下外边距集合
   * @param left 左外边距集合
   */
  setMarginForEachHeadingDetail(top: number[], right: number[], bottom: number[], left: number[]): void

  /**
   * 设置标题的4个外边距：指定标题等级，分别设置该标题的每个外边距
   *
   * @param level 标题等级
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setMarginForDesignateHeading(level: number, options: MarkdownMarginOptions | number): void

  /**
   * 设置标题的4个内边距：设置H1-H6级标题，所有等级的内边距为统一值，或某一个内边距6个级别为统一值
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时所有内边距设为相同值
   *                  入参 MarkdownPaddingOptions 类型时设置H1-H6级的top（right, bottom, left）内边距为统一值
   */
  setPaddingForAllHeadingEachLevel(options: MarkdownPaddingOptions | number): void

  /**
   * 设置标题的4个内边距：设置H1-H6级标题，每级标题自己的4个内边距为统一值
   *
   * @param paddingList 内边距集合
   */
  setPaddingForEachHeading(paddingList: number[]): void

  /**
   * 设置标题的4个内边距：分别设置H1-H6每级标题的每个内边距
   *
   * @param top 上内边距集合
   * @param right 右内边距集合
   * @param bottom 下内边距集合
   * @param left 左内边距集合
   */
  setPaddingForEachHeadingDetail(top: number[], right: number[], bottom: number[], left: number[]): void

  /**
   * 设置标题的4个内边距：指定标题等级，分别设置该标题的每个内边距
   *
   * @param level 标题等级
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setPaddingForDesignateHeading(level: number, options: MarkdownPaddingOptions | number): void

  /**
   * 设置标题文本颜色：所有标题的统一文本颜色
   *
   * @param color 文本颜色
   */
  setTextFontColorForAllHeading(color: number): void

  /**
   * 设置标题文本颜色：分别设置每级标题的文本颜色
   *
   * @param colorList 文本颜色集合
   */
  setTextFontColorForEachHeading(colorList: number[]): void

  /**
   * 设置标题文本颜色：设置指定等级的标题的文本颜色
   *
   * @param level 标题等级
   * @param color 文本颜色
   */
  setTextFontColorForDesignateHeading(level: number, color: number): void

  /**
   * 设置标题文本尺寸：所有标题的统一文本尺寸
   *
   * @param size 文本尺寸
   */
  setTextFontSizeForAllHeading(size: number): void

  /**
   * 设置标题文本尺寸：分别设置每级标题的文本尺寸
   *
   * @param sizeList 文本尺寸集合
   */
  setTextFontSizeForEachHeading(sizeList: number[]): void

  /**
   * 设置标题文本尺寸：设置指定等级的标题的文本尺寸
   *
   * @param level 标题等级
   * @param size 文本尺寸
   */
  setTextFontSizeForDesignateHeading(level: number, size: number): void

  /**
   * 设置标题文本字体样式：所有标题的统一文本字体样式
   *
   * @param style 文本字体样式
   */
  setTextFontStyleForAllHeading(style: FontStyle): void

  /**
   * 设置标题文本字体样式：分别设置每级标题的文本字体样式
   *
   * @param styleList 文本字体样式集合
   */
  setTextFontStyleForEachHeading(styleList: FontStyle[]): void

  /**
   * 设置标题文本字体样式：设置指定等级的标题的文本字体样式
   *
   * @param level 标题等级
   * @param style 文本字体样式
   */
  setTextFontStyleForDesignateHeading(level: number, style: FontStyle): void

  /**
   * 设置标题文本字体粗细：所有标题的统一文本字体粗细
   *
   * @param weight 文本字体粗细
   */
  setTextFontWeightForAllHeading(weight: FontWeight): void

  /**
   * 设置标题文本字体粗细：分别设置每级标题的文本字体粗细
   *
   * @param weightList 文本字体粗细集合
   */
  setTextFontWeightForEachHeading(weightList: FontWeight[]): void

  /**
   * 设置标题文本字体粗细：设置指定等级的标题的文本字体粗细
   *
   * @param level 标题等级
   * @param weight 文本字体粗细
   */
  setTextFontWeightForDesignateHeading(level: number, weight: FontWeight): void

  /**
   * 设置标题文本字体：所有标题的统一文本字体
   *
   * @param family 文本字体
   */
  setTextFontFamilyForAllHeading(family: string): void

  /**
   * 设置标题文本字体：分别设置每级标题的文本字体
   *
   * @param familyList 文本字体集合
   */
  setTextFontFamilyForEachHeading(familyList: string[]): void

  /**
   * 设置标题文本字体：设置指定等级的标题的文本字体
   *
   * @param level 标题等级
   * @param family 文本字体
   */
  setTextFontFamilyForDesignateHeading(level: number, family: string): void

  /**
   * 设置标题文本行高：所有标题的统一文本行高
   *
   * @param lineHeight 文本行高
   */
  setTextLineHeightForAllHeading(lineHeight: number): void

  /**
   * 设置标题文本行高：分别设置每级标题的文本行高
   *
   * @param lineHeightList 文本行高集合
   */
  setTextLineHeightForEachHeading(lineHeightList: number[]): void

  /**
   * 设置标题文本行高：设置指定等级的标题的文本行高
   *
   * @param level 标题等级
   * @param lineHeight 文本行高
   */
  setTextLineHeightForDesignateHeading(level: number, lineHeight: number): void

  /**
   * 设置标题文本字符间距：所有标题的统一文本字符间距
   *
   * @param spacing 文本字符间距
   */
  setTextLetterSpacingForAllHeading(spacing: number): void

  /**
   * 设置标题文本字符间距：分别设置每级标题的文本字符间距
   *
   * @param spacingList 文本字符间距集合
   */
  setTextLetterSpacingForEachHeading(spacingList: number[]): void

  /**
   * 设置标题文本字符间距：设置指定等级的标题的文本字符间距
   *
   * @param level 标题等级
   * @param spacing 文本字符间距
   */
  setTextLetterSpacingForDesignateHeading(level: number, spacing: number): void

  /**
   * 设置标题下划线高度：H1和H2标题的统一下划线高度
   *
   * @param height 下划线高度
   */
  setUnderlineHeightForAllHeading(height: number): void

  /**
   * 设置标题下划线高度：设置指定等级标题的下划线高度（仅H1和H2）
   *
   * @param level 标题等级
   * @param height 下划线高度
   */
  setUnderlineHeightForDesignateHeading(level: number, height: number): void

  /**
   * 设置标题下划线颜色：H1和H2标题的统一下划线颜色
   *
   * @param color 下划线颜色
   */
  setUnderlineColorForAllHeading(color: number): void

  /**
   * 设置标题下划线颜色：设置指定等级标题的下划线颜色（仅H1和H2）
   *
   * @param level 标题等级
   * @param color 下划线颜色
   */
  setUnderlineColorForDesignateHeading(level: number, color: number): void

  /**
   * 设置标题下划线间距：H1和H2标题的统一下划线间距
   *
   * @param spacing 下划线间距
   */
  setUnderlineSpacingForAllHeading(spacing: number): void

  /**
   * 设置标题下划线间距：设置指定等级标题的下划线间距（仅H1和H2）
   *
   * @param level 标题等级
   * @param spacing 下划线间距
   */
  setUnderlineSpacingForDesignateHeading(level: number, spacing: number): void
}
```

### class MarkdownThemeBanner

Markdown用户可设置的样式-Banner样式

```ets
export class MarkdownThemeBanner {
  /**
   * banner设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setBannerMargin(options: MarkdownMarginOptions | number): void

  /**
   * banner设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setBannerPadding(options: MarkdownPaddingOptions | number): void 

  /**
   * 设置banner占位图
   *
   * @param resource banner占位图
   */
  setBannerPlaceholder(resource: Resource): void
}
```

### class MarkdownThemeBlockQuote

Markdown用户可设置的样式-块引用样式

```ets
export class MarkdownThemeBlockQuote {
  /**
   * 块引用设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setBlockQuoteMargin(options: MarkdownMarginOptions | number): void

  /**
   * 块引用设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setBlockQuotePadding(options: MarkdownPaddingOptions | number): void

  /**
   * 块引用设置圆角
   *
   * @param options MarkdownRadiusOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownRadiusOptions 类型时分别设置
   */
  setBlockQuoteRadius(options: MarkdownRadiusOptions | number): void

  /**
   * 设置块引用左侧边框宽度
   *
   * @param width 块引用左侧边框宽度
   */
  setBlockQuoteLeftBorderWidth(width: number): void

  /**
   * 设置块引用左侧边框颜色
   *
   * @param color 块引用左侧边框颜色
   */
  setBlockQuoteLeftBorderColor(color: number): void

  /**
   * 设置块引用子模块上下间距
   *
   * @param spacing 块引用子模块上下间距
   */
  setBlockQuoteChildSpacing(spacing: number): void
}
```

### class MarkdownThemeBold

Markdown用户可设置的样式-加粗文本样式

```ets
export class MarkdownThemeBold {
  /**
   * 设置加粗文本尺寸
   *
   * @param size 加粗文本尺寸
   */
  setBoldTextFontSize(size: number): void

  /**
   * 设置加粗文本字体样式
   *
   * @param style 加粗文本字体样式
   */
  setBoldTextFontStyle(style: FontStyle): void

  /**
   * 设置加粗文本字体粗细
   *
   * @param weight 加粗文本字体粗细
   */
  setBoldTextFontWeight(weight: FontWeight): void

  /**
   * 设置加粗文本字体
   *
   * @param family 加粗文本字体
   */
  setBoldTextFontFamily(family: string): void

  /**
   * 设置加粗文本行高
   *
   * @param lineHeight 加粗文本行高
   */
  setBoldTextLineHeight(lineHeight: number): void

  /**
   * 设置加粗文本字符间距
   *
   * @param spacing 加粗文本字符间距
   */
  setBoldTextLetterSpacing(spacing: number): void
}
```

### class MarkdownThemeDivider

Markdown用户可设置的样式-分割线样式

```ets
export class MarkdownThemeDivider {
  /**
   * 分割线设置外边距
   *
   * @param options MarkdownMarginOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownMarginOptions 类型时分别设置
   */
  setDividerMargin(options: MarkdownMarginOptions | number): void

  /**
   * 分割线设置内边距
   *
   * @param options MarkdownPaddingOptions | number 类型
   *                  入参 number 类型时四个设为相同值
   *                  入参 MarkdownPaddingOptions 类型时分别设置
   */
  setDividerPadding(options: MarkdownPaddingOptions | number): void

  /**
   * 设置分割线颜色
   *
   * @param color 分割线颜色
   */
  setDividerColor(color: number): void

  /**
   * 设置分割线宽度
   *
   * @param strokeWidth 分割线宽度
   */
  setDividerStrokeWidth(strokeWidth: number): void

  /**
   * 设置分割线端点样式
   *
   * @param style 分割线端点样式
   */
  setDividerStyle(style: LineCapStyle): void
}
```

### class MarkdownPlugin

Markdown插件配置

```ets
/**
 * Markdown插件配置
 */
export class MarkdownPlugin {
  /**
   * 设置音频插件
   *
   * @param isBlockAudioPlugin 是否设置音频插件 - true：设置音频插件；false：不设置音频插件。默认false
   */
  setIsBlockAudioPlugin(isBlockAudioPlugin: boolean): void

  /**
   * 设置视频插件
   *
   * @param isBlockVideoPlugin 是否设置视频插件 - true：设置视频插件；false：不设置视频插件。默认false
   */
  setIsBlockVideoPlugin(isBlockVideoPlugin: boolean): void

  /**
   * 设置组合代码块列表插件
   *
   * @param isCodeListPlugin 是否设置组合代码块列表插件 - true：设置组合代码块列表插件；false：不设置组合代码块列表插件。默认false
   */
  setIsCodeListPlugin(isCodeListPlugin: boolean): void

  /**
   * 设置脚注插件
   *
   * @param isFootnotePlugin 是否设置脚注插件 - true：设置脚注插件；false：不设置脚注插件。默认false
   */
  setIsFootnotePlugin(isFootnotePlugin: boolean): void

  /**
   * 设置HTML插件
   *
   * @param isHtmlPlugin 是否设置HTML插件 - true：设置HTML插件；false：不设置HTML插件。默认false
   */
  setIsHtmlPlugin(isHtmlPlugin: boolean): void

  /**
   * 设置表格插件
   *
   * @param isTablePlugin 是否设置表格插件 - true：设置表格插件；false：不设置表格插件。默认false
   */
  setIsTablePlugin(isTablePlugin: boolean): void

  /**
   * 设置TOC插件
   *
   * @param isTocPlugin 是否设置TOC插件 - true：设置TOC插件；false：不设置TOC插件。默认false
   */
  setIsTocPlugin(isTocPlugin: boolean): void

  /**
   * 设置任务列表插件
   *
   * @param isTaskListPlugin 是否设置任务列表插件 - true：设置任务列表插件；false：不设置任务列表插件。默认false
   */
  setIsTaskListPlugin(isTaskListPlugin: boolean): void

  /**
   * 设置删除线插件
   *
   * @param isStrikethroughPlugin 是否设置删除线插件 - true：设置删除线插件；false：不设置删除线插件。默认false
   */
  setIsStrikethroughPlugin(isStrikethroughPlugin: boolean): void

  /**
   * 设置链接自动加载插件
   *
   * @param isLinkifyPlugin 是否设置链接自动加载插件 - true：设置链接自动加载插件；false：不设置链接自动加载插件。默认false
   * @param regs 正则列表
   */
  setIsLinkifyPlugin(isLinkifyPlugin: boolean, regs?: Array<string>): void

  /**
   * 设置链接块状化插件
   *
   * @param isLinkViewPlugin 是否设置链接块状化插件 - true：设置链接块状化插件；false：不设置链接块状化插件。默认false
   */
  setIsLinkViewPlugin(isLinkViewPlugin: boolean): void

  /**
   * 设置数学公式插件
   *
   * @param isLatexMathPlugin 是否设置数学公式插件 - true：设置数学公式插件；false：不设置数学公式插件。默认false
   */
  setIsLatexMathPlugin(isLatexMathPlugin: boolean): void

  /**
   * 设置图片样式插件
   *
   * @param isImageStylePlugin 是否设置图片样式插件 - true：设置图片样式插件；false：不设置图片样式插件。默认false
   */
  setIsImageStylePlugin(isImageStylePlugin: boolean): void

  /**
   * 设置图片幻灯片（Banner）插件
   *
   * @param isImageSlidePlugin 是否设置图片幻灯片（Banner）插件 - true：设置图片幻灯片（Banner）插件；false：不设置图片幻灯片（Banner）插件。默认false
   */
  setIsImageSlidePlugin(isImageSlidePlugin: boolean): void

  /**
   * 设置图片不混排插件
   *
   * @param isImageTextMixPlugin 是否图片不混排插件 - true：图片混排；false：图片不混排。默认true
   */
  setIsImageTextMixPlugin(isImageTextMixPlugin: boolean): void

  /**
   * 设置图片视频url集合列表插件
   *
   * @param isImageCollectPlugin 是否设置图片视频url集合列表插件 - true：设置图片视频url集合列表插件；false：不设置图片视频url集合列表插件。默认false
   */
  setIsImageCollectPlugin(isImageCollectPlugin: boolean): void

  /**
   * 设置是否加载定义列表解析插件
   *
   * @param isDescListPlugin 是否加载定义列表解析插件 - true：设置加载定义列表解析插件；false：不设置加载定义列表解析插件。默认false
   */
  setIsDescListPlugin(isDescListPlugin: boolean): void

  /**
   * 设置是否加载标题ID解析插件
   *
   * @param isHeadIDPlugin 是否加载标题ID解析插件 - true：设置加载标题ID解析插件；false：不设置加载标题ID解析插件。默认false
   */
  setIsHeadIDPlugin(isHeadIDPlugin: boolean): void

  /**
   * 设置是否加载下标解析插件
   *
   * @param isSubPlugin 是否加载下标解析插件 - true：设置加载下标解析插件；false：不设置加载下标解析插件。默认false
   */
  setIsSubPlugin(isSubPlugin: boolean): void

  /**
   * 设置是否加载上标解析插件
   *
   * @param isSupPlugin 是否加载上标解析插件 - true：设置加载上标解析插件；false：不设置加载上标解析插件。默认false
   */
  setIsSupPlugin(isSupPlugin: boolean): void

  /**
   * 设置是否加载emoji解析插件
   *
   * @param isEmojiPlugin 是否加载Emoji解析插件 - true：设置加载Emoji解析插件；false：不设置加载Emoji解析插件。默认false
   * @param isEmojiLight 是否加载精简emoji表情 - true：加载精简emoji表情；false：不加载精简emoji表情。默认true
   */
  setIsEmojiPlugin(isEmojiPlugin: boolean, isEmojiLight: boolean): void
}
```

### class MarkdownScroller

Markdown滑动控制器

```ets
/**
 * Markdown滑动控制器
 */
export class MarkdownScroller {
  /**
   * 构造函数
   */
  constructor()

  /**
   * 滚动到容器边缘
   *
   * @param edge 滚动到容器边缘
   */
  scrollEdge(edge: Edge): void

  /**
   * 滚动指定距离
   *
   * @param xOffset x轴偏移量
   * @param yOffset y轴偏移量
   */
  scrollBy(xOffset: number, yOffset: number): void

  /**
   * 滑动到指定Index
   *
   * @param index 要滑动到的目标元素在当前容器中的索引值
   */
  scrollToIndex(index: number): void

  /**
   * 判断是否滚动到底部
   *
   * @returns 是否滚动到底部
   */
  isAtEnd(): boolean

  /**
   * 获取当前y轴偏移量
   *
   * @returns 当前y轴偏移量
   */
  currentYOffset(): number

  /**
   * 获取子组件的大小及相对容器组件的位置
   *
   * @param index 索引值
   * @returns 子组件的大小和相对于组件的位置
   */
  getItemRect(index: number): MarkdownRectResult
  
  /**
   * 获取内部CJMarkdownScroller实例
   *
   * @returns CJMarkdownScroller实例
   */
  getScroller(): CJMarkdownScroller | undefined
}
```

### class MarkdownRectResult

子组件的大小和相对于组件的位置

```ets
/**
 * 子组件的大小和相对于组件的位置
 */
export class MarkdownRectResult {
  /**
   * 构造函数
   */
  constructor (x: number, y: number, width: number, height: number)
  
  /**
   * 获取子组件相对坐标x
   *
   * @returns 子组件x轴位置
   */
  getItemRectX(): number
  
  /**
   * 获取子组件相对坐标y
   *
   * @returns 子组件y轴位置
   */
  getItemRectY(): number
  
  /**
   * 获取子组件宽度
   *
   * @returns 子组件宽度
   */
  getItemRectWidth(): number
  
  /**
   * 获取子组件高度
   *
   * @returns 子组件高度
   */
  getItemRectHeight(): number
}
```

### class MarkdownNodeViewString

全局文本对象

```ets
/**
 * 全局文本对象
 */
export class MarkdownNodeViewString {
  /**
   * 构造函数
   */
  constructor()

  /**
   * 获取全局文本对象
   *
   * @returns 全局文本对象
   */
  getCJNodeViewStringBuilder(): CJNodeViewStringBuilder | undefined

  /**
   * 获取全局文本
   *
   * @returns 全局文本
   */
  toString(): string
}
```

### class MarkdownCardComponent

Markdown卡片自定义控件，支持在Markdown文档中通过`<card>`HTML标签嵌入ArkTS自定义组件。

```ets
/**
 * Markdown卡片自定义控件
 */
export class MarkdownCardComponent {
  /**
   * 构造函数
   *
   * @param markdownConfiguration Markdown配置
   * @param nodeView 卡片节点视图
   * @param cardName 卡片名称，对应ArkTS端注册的组件类名
   * @param cardData 卡片数据，JSON字符串，将传递给组件的data属性
   */
  constructor(
    markdownConfiguration: MarkdownConfiguration,
    nodeView: NodeView,
    cardName: string,
    cardData: string
  )
}
```

#### 卡片功能使用说明

卡片功能允许用户在Markdown文档中通过HTML `<card>` 标签嵌入任意的ArkTS自定义组件。

**Markdown语法**

在Markdown文档中使用 `<card>` HTML标签：

```html
<card name="MyCardComponent" data='{"title":"示例","content":"卡片内容"}'></card>
```

- `name`（必填）：ArkTS端注册的组件类名，CardWrapper将通过该名称在全局上下文中查找并动态实例化对应组件
- `data`（可选）：JSON字符串，将作为 `param["data"]` 传递给组件的data属性

**前置条件**

1. 需要启用HTML插件（`setIsHtmlPlugin(true)`），卡片标签通过HtmlPlugin的CardHandler解析。如果未启用HtmlPlugin，`<card>`标签会被当作普通HTML文本忽略
2. `<card>`标签必须包含`name`属性，否则CardHandler会忽略该标签（返回IgnoreBlockNode）
3. ArkTS端需将自定义组件类注册到全局上下文中（如`globalThis.XXX = XXXComponent`），确保CardWrapper能通过 `globalCtx.global[cardName]` 查找到组件类
4. 如果手动创建HtmlPlugin实例，不能调用`excludeDefaults(true)`，否则CardHandler不会被注册

**数据流**

1. Markdown文档中的 `<card name="XXX" data="{...}"/>` 标签被HtmlPlugin解析
2. CardHandler从标签属性提取 `name` 和 `data`，创建CardNode（CustomBlock子类）
3. MarkdownVisitor遍历CardNode，nodeToNodeView()转换为NodeView（nodeType="CardNode"）
4. MarkdownComponent渲染时匹配"CardNode"，实例化MarkdownCardComponent
5. MarkdownCardComponent.build()创建CardWrapper，传入cardName和cardData
6. CardWrapper通过JS互操作机制动态实例化cardName对应的ArkTS组件，将cardData作为data参数传入

