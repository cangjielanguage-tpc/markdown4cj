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
   * @param cb 链接点击回调(funcArg0：链接url)
   */
  setLinkCallback(cb: (funcArg0: string) => void): void

  /**
   * 设置文本复制的点击事件
   *
   * @param cb 文本复制的点击事件(funcArg0：复制的文本)
   */
  setTextCopyCallback(cb: (funcArg0: string) => void): void

  /**
   * 设置图片点击回调
   *
   * @param cb 图片点击回调。 (funcArg0：图片url,funcArg1:所有图片和视频连接集合 --- 需要加载图片视频列表url集合列表解析插件)
   */
  setImageCallback(cb: (funcArg0: string, funcArg1: Array<string>) => void): void

  /**
   * 设置图片替换事件
   *
   * @param cb 图片替换事件。 (funcArg0：图片url 返回值是替换的图片数据)
   */
  setImageCallbackCallback(cb: (funcArg0: string) => Promise<ArrayBuffer | undefined>): void

  /**
   * 设置图片下载的点击事件
   *
   * @param cb 图片下载的点击事件。 (funcArg0：图片url)
   */
  setImageDownloadCallback(cb: (funcArg0: string) => void): void

  /**
   * 设置音频点击回调
   *
   * @param cb 音频点击回调(funcArg0：音频url) --- 需要加载音频解析插件
   */
  setAudioCallback(cb: (funcArg0: string) => void): void

  /**
   * 设置视频点击回调
   *
   * @param cb 视频点击回调。 (funcArg0：视频url,funcArg1:所有图片和视频连接集合 --- 需要加载图片视频列表url集合列表解析插件) --- 需要加载视频解析插件
   */
  setVideoCallback(cb: (funcArg0: string, funcArg1: Array<string>) => void): void

  /**
   * 设置视频占位图和宽高比和视频时长的回调
   *
   * @param cb 视频视频占位图和宽高比和视频时长回调。 (funcArg0：视频url,funcArg1:视频占位图和宽高比和视频时长回调 (funcArgfuncArg0:视频首帧图,funcArgfuncArg1:图片宽高比,funcArgfuncArg2,视频时长)) --- 需要加载视频解析插件
   */
  setVideoImageCallback(cb: (funcArg0: string, funcArg1: (funcArgfuncArg0: string, funcArgfuncArg1: number, funcArgfuncArg2: number) => void) => void): void

  /**
   * 设置视频发布的点击事件
   *
   * @param cb 视频发布的点击事件(funcArg0：视频url) --- 需要加载视频解析插件
   */
  setVideoReleaseCallback(cb: (funcArg0: string) => void): void

  /**
   * 设置视频下载的点击事件
   *
   * @param cb 视频下载的点击事件(funcArg0：视频url) --- 需要加载视频解析插件
   */
  setVideoDownloadCallback(cb: (funcArg0: string) => void): void

  /**
   * 设置代码复制点击回调
   *
   * @param cb 代码复制点击回调(funcArg0：代码内容)
   */
  setCodeCopyCallback(cb: (funcArg0: string) => void): void

  /**
   * 设置代码全屏点击回调
   *
   * @param cb 代码全屏点击回调(funcArg0：代码内容, funcArg1:代码类型)
   */
  setCodeFullScreenCallback(cb: (funcArg0: string, funcArg1: string | undefined) => void): void

  /**
   * 设置数学公式点击回调
   *
   * @param cb 数学公式点击回调(funcArg0：数学公式图片数组数据, funcArg1:图片高度, funcArg2:图片宽度) --- 需要加载数学公式解析插件
   */
  setLatexImageCallback(cb: (funcArg0: ArrayBuffer, funcArg1: number, funcArg2: number) => void): void

  /**
   * 设置数学公式公式预处理回调
   *
   * @param cb 数学公式公式预处理回调(funcArg0：数学公式文本内容,return：处理过后的数学公式文本) --- 需要加载数学公式解析插件
   */
  setLatexStrCallback(cb: (funcArg0: string) => string): void

  /**
   * 设置TOC点击回调
   *
   * @param cb TOC点击回调(funcArg0：偏移量) --- 需要加载TOC解析插件
   */
  setTocIndexCallback(cb: (funcArg0: number | undefined) => void): void

  /**
   * 设置脚注点击回调
   *
   * @param cb 脚注点击回调(funcArg0：偏移量) --- 需要加载脚注解析插件
   */
  setFootnoteCallback(cb: (funcArg0: number | undefined) => void): void

  /**
   * 获取全局文本
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

  /**
   * 获取链接的点击事件
   *
   * @returns 链接的点击事件回调函数
   */
  getLinkCallback(): ((funcArg0: string) => void) | undefined

  /**
   * 获取文本复制的点击事件
   *
   * @returns 文本复制的点击事件回调函数
   */
  getTextCopyCallback(): ((funcArg0: string) => void) | undefined

  /**
   * 获取图片的点击事件
   *
   * @returns 图片的点击事件回调函数
   */
  getImageCallback(): ((funcArg0: string, funcArg1: Array<string>) => void) | undefined

  /**
   * 获取图片替换事件
   *
   * @returns 图片替换事件回调函数
   */
  getImageCallbackCallback(): ((funcArg0: string) => Promise<ArrayBuffer | undefined>) | undefined

  /**
   * 获取图片下载的点击事件
   *
   * @returns 图片下载的点击事件回调函数
   */
  getImageDownloadCallback(): ((funcArg0: string) => void) | undefined

  /**
   * 获取音频的点击事件
   *
   * @returns 音频的点击事件回调函数
   */
  getAudioCallback(): ((funcArg0: string) => void) | undefined

  /**
   * 获取视频的点击事件
   *
   * @returns 视频的点击事件回调函数
   */
  getVideoCallback(): ((funcArg0: string, funcArg1: Array<string>) => void) | undefined

  /**
   * 获取视频的图片替换回调
   *
   * @returns 视频的图片替换回调函数
   */
  getVideoImageCallback(): ((funcArg0: string, funcArg1: (funcArgfuncArg0: string, funcArgfuncArg1: number, funcArgfuncArg2: number) => void) => void) | undefined

  /**
   * 获取视频发布的点击事件
   *
   * @returns 视频发布的点击事件回调函数
   */
  getVideoReleaseCallback(): ((funcArg0: string) => void) | undefined

  /**
   * 获取视频下载的点击事件
   *
   * @returns 视频下载的点击事件回调函数
   */
  getVideoDownloadCallback(): ((funcArg0: string) => void) | undefined

  /**
   * 获取代码复制按钮的点击事件
   *
   * @returns 代码复制按钮的点击事件回调函数
   */
  getCodeCopyCallback(): ((funcArg0: string) => void) | undefined

  /**
   * 获取代码全屏按钮的点击事件
   *
   * @returns 代码全屏按钮的点击事件回调函数
   */
  getCodeFullScreenCallback(): ((funcArg0: string, funcArg1: string | undefined) => void) | undefined

  /**
   * 获取数学公式图片点击事件
   *
   * @returns 数学公式图片点击事件回调函数
   */
  getLatexImageCallback(): ((funcArg0: ArrayBuffer, funcArg1: number, funcArg2: number) => void) | undefined

  /**
   * 获取数学公式数据处理事件
   *
   * @returns 数学公式数据处理事件回调函数
   */
  getLatexStrCallback(): ((funcArg0: string) => string) | undefined

  /**
   * 获取TOC跳转指定位置回调
   *
   * @returns TOC跳转指定位置回调函数
   */
  getTocIndexCallback(): ((funcArg0: number | undefined) => void) | undefined

  /**
   * 获取脚注跳转指定位置回调
   *
   * @returns 脚注跳转指定位置回调函数
   */
  getFootnoteCallback(): ((funcArg0: number | undefined) => void) | undefined

  /**
   * 获取全局文本对象
   *
   * @returns 全局文本对象
   */
  getMarkdownNodeViewString(): MarkdownNodeViewString

  /**
   * 获取markdown默认样式
   *
   * @returns markdown默认样式对象
   */
  getMarkdownTheme(): MarkdownTheme | undefined
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
   * @useinstead MarkdownThemeGlobal#setStageContext
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
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockFullScreenIcon
   */
  setCodeFullScreenIcon(codeFullScreenIcon: Resource): void

  /**
   * 设置代码块复制图片icon
   *
   * @param codeCopyIcon 代码块复制图片icon
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockCopyIcon
   */
  setCodeCopyIcon(codeCopyIcon: Resource): void

  /**
   * 设置音频图片icon
   *
   * @param audioIcon 音频图片icon
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioIcon
   */
  setAudioIcon(audioIcon: Resource): void

  /**
   * 设置视频默认占位图
   *
   * @param videoImage 视频默认占位图
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoPlaceholder
   */
  setVideoImage(videoImage: Resource): void

  /**
   * 设置视频播放按钮icon
   *
   * @param playCircleFillIcon 视频播放按钮icon
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoPlayIcon
   */
  setPlayCircleFillIcon(playCircleFillIcon: Resource): void

  /**
   * 设置banner占位图
   *
   * @param bannerImage banner占位图
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBanner#setBannerPlaceholder
   */
  setBannerImage(bannerImage: Resource): void

  /**
   * 设置图片占位图
   *
   * @param imageResource 图片占位图
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImagePlaceholder
   */
  setImageResource(imageResource: Resource): void

  /**
   * 设置视频发布默认图标
   *
   * @param videoReleaseImage 视频发布默认图标
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonIcon
   */
  setVideoReleaseImage(videoReleaseImage: Resource): void

  /**
   * 设置视频下载默认图标
   *
   * @param videoDownloadImage 视频下载默认图标
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonIcon
   */
  setVideoDownloadImage(videoDownloadImage: Resource): void

  /**
   * 设置图片下载默认图标
   *
   * @param imageDownloadImage 图片下载默认图标
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonIcon
   */
  setImageDownloadImage(imageDownloadImage: Resource): void

  /**
   * 设置markdown是否同步解析
   *
   * @param isMarkdownParserSync markdown是否同步解析 - 默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setIsMarkdownParserSync
   */
  setIsMarkdownParserSync(isMarkdownParserSync: boolean): void

  /**
   * 设置是否打开长按复制粘贴
   *
   * @param isOnCopy 是否打开长按复制粘贴 - 默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setIsOnCopy
   */
  setIsOnCopy(isOnCopy: boolean): void

  /**
   * 设置markdown第一个模块上边距
   *
   * @param blockFirstTopMargin markdown第一个模块上边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setGlobalMargin
   */
  setBlockFirstTopMargin(blockFirstTopMargin: number): void

  /**
   * 设置markdown最后一个模块下边距
   *
   * @param blockLastBottomMargin markdown最后一个模块下边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setGlobalMargin
   */
  setBlockLastBottomMargin(blockLastBottomMargin: number): void

  /**
   * 设置模块间上下间距
   *
   * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setBlockSpacing
   */
  setBlockTopAndBottomMargins(blockTopAndBottomMargins: number): void

  /**
   * 设置链接是否是图片显示
   *
   * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkIsIcon
   */
  setIsLinkStyle(isLinkStyle: boolean): void

  /**
   * 设置列表中的单行链接是否是图片显示
   *
   * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkListIsIcon
   */
  setIsListLinkStyle(isListLinkStyle: boolean): void

  /**
   * 设置文本格式链接文本颜色
   *
   * @param linkColor 文本格式链接文本颜色 - 默认0xFF0000FF
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkTextFontColor
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
   * @useinstead MarkdownThemeLink#setLinkTextFontSize
   */
  setLinkSize(linkSize: number): void

  /**
   * 设置文本格式链接文字行高
   *
   * @param linkLineHeight 文本格式链接文字行高
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkTextLineHeight
   */
  setLinkLineHeight(linkLineHeight: number): void

  /**
   * 设置文本格式链接背景颜色
   *
   * @param linkBackGroupColor 文本格式链接背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkTextBackgroundColor
   */
  setLinkBackGroupColor(linkBackGroupColor: number): void

  /**
   * 设置文本格式是否显示链接下划线
   *
   * @param isLinkUnderlined 文本格式是否显示链接下划线 - true：显示下划线；false：不显示下划线。默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkTextDecorationType
   */
  setIsLinkUnderlined(isLinkUnderlined: boolean): void

  /**
   * 设置圆形图片格式链接主题背景颜色
   *
   * @param linkCircleImageBackGroupColor 圆形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkCircleIconBackgroundColor
   */
  setLinkCircleImageBackGroupColor(linkCircleImageBackGroupColor: number): void

  /**
   * 设置圆形图片格式链接控件背景颜色
   *
   * @param linkCircleImageButtonBackGroupColor 圆形图片格式链接控件背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkCircleIconButtonBackgroundColor
   */
  setLinkCircleImageButtonBackGroupColor(linkCircleImageButtonBackGroupColor: number): void

  /**
   * 设置圆形图片格式链接文字大小
   *
   * @param linkCircleImageTextSize 圆形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkCircleIconTextSize
   */
  setLinkCircleImageTextSize(linkCircleImageTextSize: number): void

  /**
   * 设置圆形图片格式链接文字颜色
   *
   * @param linkCircleImageTextColor 圆形图片格式链接文字颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkCircleIconTextColor
   */
  setLinkCircleImageTextColor(linkCircleImageTextColor: number): void

  /**
   * 设置圆形图片格式链接半径
   *
   * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkCircleIconRadius
   */
  setLinkCircleImageRadius(linkCircleImageRadius: number): void

  /**
   * 设置圆形图片格式链接左右外边距
   *
   * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkCircleIconMargin
   */
  setLinkCircleImageMargin(linkCircleImageMargin: number): void

  /**
   * 设置圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectImageBackGroupColor 圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconBackgroundColor
   */
  setLinkRectImageBackGroupColor(linkRectImageBackGroupColor: number): void

  /**
   * 设置圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectImageButtonBackGroupColor 圆角矩形图片格式链接控件背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconButtonBackgroundColor
   */
  setLinkRectImageButtonBackGroupColor(linkRectImageButtonBackGroupColor: number): void

  /**
   * 圆角矩形图片格式链接文字大小
   *
   * @param linkRectImageTextSize 圆角矩形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconTextSize
   */
  setLinkRectImageTextSize(linkRectImageTextSize: number): void

  /**
   * 设置圆角矩形图片格式链接文字颜色
   *
   * @param linkRectImageTextColor 圆角矩形图片格式链接文字颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconTextColor
   */
  setLinkRectImageTextColor(linkRectImageTextColor: number): void

  /**
   * 圆角矩形图片格式链接控件高度
   *
   * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconHeight
   */
  setLinkRectImageHeight(linkRectImageHeight: number): void

  /**
   * 圆角矩形图片格式链接左右内边距
   *
   * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconPadding
   */
  setLinkRectImagePadding(linkRectImagePadding: number): void

  /**
   * 圆角矩形图片格式链接圆角半径
   *
   * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconRadius
   */
  setLinkRectImageRadius(linkRectImageRadius: number): void

  /**
   * 圆角矩形图片格式链接左右外边距
   *
   * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconMargin
   */
  setLinkRectImageMargin(linkRectImageMargin: number): void

  /**
   * 设置空心圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectToolImageBackGroupColor 空心圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconBackgroundColor
   */
  setLinkRectToolImageBackGroupColor(linkRectToolImageBackGroupColor: number): void

  /**
   * 设置空心圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectToolImageButtonBackGroupColor 空心圆角矩形图片格式链接控件背景颜色 - 默认OXFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconBackgroundColor
   */
  setLinkRectToolImageButtonBackGroupColor(linkRectToolImageButtonBackGroupColor: number): void

  /**
   * 设置空心圆角矩形图片格式链接文字大小
   *
   * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconTextSize
   */
  setLinkRectToolImageTextSize(linkRectToolImageTextSize: number): void

  /**
   * 设置空心圆角矩形图片格式链接控件高度
   *
   * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconHeight
   */
  setLinkRectToolImageHeight(linkRectToolImageHeight: number): void

  /**
   * 设置空心圆角矩形图片格式链接左右内边距
   *
   * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconPadding
   */
  setLinkRectToolImagePadding(linkRectToolImagePadding: number): void

  /**
   * 设置空心圆角矩形图片格式链接边框宽度
   *
   * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconBorderWidth
   */
  setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: number): void

  /**
   * 设置空心圆角矩形图片格式链接分割线宽度
   *
   * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconDividingLineWidth
   */
  setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: number): void

  /**
   * 设置空心圆角矩形图片格式链接左右外边距
   *
   * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconMargin
   */
  setLinkRectToolImageMargin(linkRectToolImageMargin: number): void

  /**
   * 设置空心圆角矩形图片格式分割线和文本左边距
   *
   * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconLineLeftPadding
   */
  setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: number): void

  /**
   * 设置空心圆角矩形图片格式分割线和文本右边距
   *
   * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconLineRightPadding
   */
  setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: number): void

  /**
   * 设置块引用左边距
   *
   * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBlockQuote#setBlockQuoteMargin
   */
  setBlockQuoteLeftMargin(blockQuoteLeftMargin: number): void

  /**
   * 设置块引用右边距
   *
   * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBlockQuote#setBlockQuoteMargin
   */
  setBlockQuoteRightMargin(blockQuoteRightMargin: number): void

  /**
   * 设置块引用左边线条宽度
   *
   * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBlockQuote#setBlockQuoteLeftBorderWidth
   */
  setBlockQuoteWidth(blockQuoteWidth: number): void

  /**
   * 设置块引用左边线条颜色
   *
   * @param blockQuoteColor 块引用左边线条颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBlockQuote#setBlockQuoteLeftBorderColor
   */
  setBlockQuoteColor(blockQuoteColor: number): void

  /**
   * 设置块引用背景颜色
   *
   * @param blockQuoteBackGroupColor 块引用背景颜色 - 默认0xFFEAEAEA
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBlockQuote#setBlockQuoteBackgroundColor
   */
  setBlockQuoteBackGroupColor(blockQuoteBackGroupColor: number): void

  /**
   * 设置块引用子模块上下间距
   *
   * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBlockQuote#setBlockQuoteChildSpacing
   */
  setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: number): void

  /**
   * 设置有序列表、无序列表、任务列表子模块上下间距
   *
   * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeOrderedList#setOrderedListChildSpacing
   *             MarkdownThemeOrderedList#setBulletListChildSpacing
   */
  setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: number): void

  /**
   * 设置有序列表、无序列表、任务列表左边距
   *
   * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeOrderedList#setOrderedListMargin
   *             MarkdownThemeOrderedList#setBulletListMargin
   */
  setBlockLeftMargin(blockLeftMargin: number): void

  /**
   * 设置有序列表、无序列表、任务列表右边距
   *
   * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeOrderedList#setOrderedListMargin
   *             MarkdownThemeOrderedList#setBulletListMargin
   */
  setBlockRightMargin(blockRightMargin: number): void

  /**
   * 设置有序列表前缀文本是否加粗
   *
   * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true：加粗；false：不加粗。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeOrderedList#setOrderedListMarkerTextFontWeight
   */
  setOrderedListItemPrefixBold(orderedListItemPrefixBold: boolean): void

  /**
   * 设置有序列表前缀文本颜色
   *
   * @param orderedListItemColor 有序列表前缀文本颜色 - 默认OXFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeOrderedList#setOrderedListMarkerTextFontColor
   */
  setOrderedListItemColor(orderedListItemColor: number): void

  /**
   * 设置有序列表前缀文本大小
   *
   * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeOrderedList#setOrderedListMarkerTextFontSize
   */
  setOrderedListItemSize(orderedListItemSize: number): void

  /**
   * 设置有序列表前缀文本行高
   *
   * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeOrderedList#setOrderedListMarkerTextLineHeight
   */
  setOrderedListItemLineHeight(orderedListItemLineHeight: number): void

  /**
   * 设置无序列表前缀是否全部是实心圆型
   *
   * @param bulletListItemCircle 无序列表前缀是否全部是实心圆型 - 默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBulletList#setBulletListBulletIsCircle
   */
  setBulletListItemCircle(bulletListItemCircle: boolean): void

  /**
   * 设置无序列表前缀文本颜色
   *
   * @param bulletListItemColor 无序列表前缀文本颜色 - 默认OXFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBulletList#setBulletListBulletTextFontColor
   */
  setBulletListItemColor(bulletListItemColor: number): void

  /**
   * 设置无序列表前缀文本大小
   *
   * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBulletList#setBulletListBulletTextFontSize
   */
  setBulletListItemSize(bulletListItemSize: number): void

  /**
   * 设置无序列表前缀文本行高
   *
   * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBulletList#setBulletListBulletTextLineHeight
   */
  setBulletListItemLineHeight(bulletListItemLineHeight: number): void

  /**
   * 设置任务列表选择框宽高
   *
   * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBulletList#setBulletListCheckboxWidth
   *             MarkdownThemeBulletList#setBulletListCheckboxHeight
   */
  setTaskListItemLength(taskListItemLength: number): void

  /**
   * 设置是否格式化代码块内容
   *
   * @param isCodeFormat 是否格式化代码块内容 - true：格式化代码块内容；false：不格式化代码块内容。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockIsCodeFormat
   */
  setIsCodeFormat(isCodeFormat: boolean): void

  /**
   * 设置内联代码文本颜色
   *
   * @param codeTextColor 内联代码文本颜色 - 默认OXFF000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeInlineCode#setInlineCodeTextFontColor
   */
  setCodeTextColor(codeTextColor: number): void

  /**
   * 设置内联代码背景颜色
   *
   * @param codeBackgroundColor 内联代码背景颜色 - 默认OXFFEAEAEA
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeInlineCode#setInlineCodeTextBackgroundColor
   */
  setCodeBackgroundColor(codeBackgroundColor: number): void

  /**
   * 设置内联代码文本大小
   *
   * @param codeTextSize 内联代码文本大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeInlineCode#setInlineCodeTextFontSize
   */
  setCodeTextSize(codeTextSize: number): void

  /**
   * 设置内联代码文本字体
   *
   * @param codeTypeface 内联代码文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeInlineCode#setInlineCodeTextFontFamily
   */
  setCodeTypeface(codeTypeface: string): void

  /**
   * 设置围栏代码块代码高亮是否同步解析
   *
   * @param isCodeBlockParserSync 围栏代码块代码高亮是否同步解析 - 默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockParserSync
   */
  setIsCodeBlockParserSync(isCodeBlockParserSync: boolean): void

  /**
   * 设置代码块代码文本颜色
   *
   * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockTextFontColor
   */
  setCodeBlockTextColor(codeBlockTextColor: number): void

  /**
   * 设置代码块代码类型文本颜色
   *
   * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockTypeTextFontColor
   */
  setCodeBlockTypeTextColor(codeBlockTypeTextColor: number): void

  /**
   * 设置代码块代码类型文本
   *
   * @param codeBlockTypeTextStr 代码块代码类型文本 - 默认""
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockTypeText
   */
  setCodeBlockTypeTextStr(codeBlockTypeTextStr: string): void

  /**
   * 设置代码类型和代码块距离
   *
   * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockTitleLayoutMarginBottom
   */
  setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: number): void

  /**
   * 设置代码块复制、全屏图片文字是否显示
   *
   * @param codeBlockIconTextHide 代码块复制、全屏图片文字是否显示 - true：显示；false：不显示。默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockFullScreenTextIsShow
   *             MarkdownThemeCodeBlock#setCodeBlockCopyTextIsShow
   */
  setCodeBlockIconTextHide(codeBlockIconTextHide: boolean): void

  /**
   * 设置代码块代码行号是否显示
   *
   * @param codeBlockLineNumberHide 代码块代码行号是否显示 - true：显示；false：不显示。默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockLineNumberIsShow
   */
  setCodeBlockLineNumberHide(codeBlockLineNumberHide: boolean): void

  /**
   * 设置代码块背景颜色
   *
   * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockBackgroundColor
   */
  setCodeBlockBackgroundColor(codeBlockBackgroundColor: number): void

  /**
   * 设置代码块左边距
   *
   * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockMargin
   */
  setCodeMultilineMargin(codeMultilineMargin: number): void

  /**
   * 设置代码块字体
   *
   * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockTextFontFamily
   */
  setCodeBlockTypeface(codeBlockTypeface: string): void

  /**
   * 设置代码块代码文本大小
   *
   * @param codeBlockTextSize 代码块代码文本大小 -  默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockTextFontSize
   */
  setCodeBlockTextSize(codeBlockTextSize: number): void

  /**
   * 设置代码块代码文本行高
   *
   * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockTextLineHeight
   */
  setCodeBlockLineHeight(codeBlockLineHeight: number): void

  /**
   * 设置代码块控件圆角大小
   *
   * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockAllRadius
   */
  setCodeBlockRadius(codeBlockRadius: number): void

  /**
   * 设置代码块代码全屏按钮是否显示
   *
   * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true：显示；false：不显示。默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockFullScreenButtonIsShow
   */
  setIsCodeFullScreen(isCodeFullScreen: boolean): void

  /**
   * 设置代码块代码全屏、代码复制按钮宽高
   *
   * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockFullScreenIconHeight
   *             MarkdownThemeCodeBlock#setCodeBlockFullScreenIconWidth
   *             MarkdownThemeCodeBlock#setCodeBlockCopyIconHeight
   *             MarkdownThemeCodeBlock#setCodeBlockCopyIconWidth
   */
  setIconWidthAndHeight(iconWidthAndHeight: number): void

  /**
   * 设置组合代码未选中标题字体大小
   *
   * @param codeListTitleTextSize 组合代码未选中标题字体大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockListTitleTextSize
   */
  setCodeListTitleTextSize(codeListTitleTextSize: number): void

  /**
   * 设置组合代码选中标题字体大小
   *
   * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockListTitleSelectTextSize
   */
  setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: number): void

  /**
   * 设置组合代码选中标题文本颜色
   *
   * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认Color.RED
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockListTitleSelectTextColor
   */
  setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: number): void

  /**
   * 设置组合代码未选中标题文本颜色
   *
   * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认Color.BLACK
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockListTitleUnselectTextColor
   */
  setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: number): void

  /**
   * 设置组合代码选中标题背景颜色
   *
   * @param codeListTitleSelectBackGroupColor 组合代码选中标题背景颜色 - 默认Color.GRAY
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockListTitleSelectBackgroundColor
   */
  setCodeListTitleSelectBackGroupColor(codeListTitleSelectBackGroupColor: number): void

  /**
   * 设置组合代码未选中标题背景颜色
   *
   * @param codeListTitleUnSelectBackGroupColor 组合代码未选中标题背景颜色 - 默认Color.TRANSPARENT
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockListTitleUnselectBackgroundColor
   */
  setCodeListTitleUnSelectBackGroupColor(codeListTitleUnSelectBackGroupColor: number): void

  /**
   * 设置是否单独代码块显示
   *
   * @param isSeparateCodeBlock 是否单独代码块显示 - true：显示；false：不显示。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockIsSeparate
   */
  setIsSeparateCodeBlock(isSeparateCodeBlock: boolean): void

  /**
   * 设置单独代码块行号宽度
   *
   * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockSeparateWidth
   */
  setSeparateCodeBlockWidth(separateCodeBlockWidth: number): void

  /**
   * 设置单独代码块是否居底显示
   *
   * @param separateCodeIsBottom 单独代码块是否居底显示 - 默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockSeparateIsBottom
   */
  setSeparateCodeIsBottom(separateCodeIsBottom: boolean): void

  /**
   * 设置H1、H2标题下分割线高度
   *
   * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setUnderlineHeightForAllHeading
   */
  setHeadingBreakHeight(headingBreakHeight: number): void

  /**
   * 设置标题文本字体
   *
   * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontFamilyForAllHeading
   */
  setHeadingTypeface(headingTypeface: string): void

  /**
   * 设置标题模块上间距
   *
   * @param headingTopMargins 标题模块上间距 - 默认8.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setMarginForDesignateHeading
   */
  setHeadingTopMargins(headingTopMargins: number): void

  /**
   * 设置标题模块下间距
   *
   * @param headingBottomMargins 标题模块下间距 - 默认8.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setMarginForDesignateHeading
   */
  setHeadingBottomMargins(headingBottomMargins: number): void

  /**
   * 设置标题文本大小数组
   *
   * @param headingTextSizeMultipliers 标题文本大小数组 - 默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
   * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontSizeForEachHeading
   */
  setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<number>): void

  /**
   * 设置一级标题文本大小
   *
   * @param headingTextSize1 一级标题文本大小 - 默认20.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize1(headingTextSize1: number): void

  /**
   * 设置二级标题文本大小
   *
   * @param headingTextSize2 二级标题文本大小 - 默认17.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize2(headingTextSize2: number): void

  /**
   * 设置三级标题文本大小
   *
   * @param headingTextSize3 三级标题文本大小 - 默认16.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize3(headingTextSize3: number): void

  /**
   * 设置四级标题文本大小
   *
   * @param headingTextSize4 四级标题文本大小 - 默认15.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize4(headingTextSize4: number): void

  /**
   * 设置五级标题文本大小
   *
   * @param headingTextSize5 五级标题文本大小 - 默认15.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize5(headingTextSize5: number): void

  /**
   * 设置六级标题文本大小
   *
   * @param headingTextSize6 六级标题文本大小 - 默认13.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize6(headingTextSize6: number): void

  /**
   * 设置标题文本颜色
   *
   * @param headingTextColor 标题文本颜色 - 默认0xFF191919
   * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontColorForAllHeading
   */
  setHeadingTextColor(headingTextColor: number): void

  /**
   * 设置H1、H2标题下分割线颜色
   *
   * @param headingBreakColor H1、H2标题下分割线颜色 - 默认0xFF191919
   * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setUnderlineColorForAllHeading
   */
  setHeadingBreakColor(headingBreakColor: number): void

  /**
   * 设置标题文本字间距
   *
   * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextLetterSpacingForAllHeading
   */
  setHeadingTextWordSpace(headingTextWordSpace: number): void

  /**
   * 设置一级标题文本行高
   *
   * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight1(headingTextLineHeight1: number): void

  /**
   * 设置二级标题文本行高
   *
   * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight2(headingTextLineHeight2: number): void

  /**
   * 设置三级标题文本行高
   *
   * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight3(headingTextLineHeight3: number): void

  /**
   * 设置四级标题文本行高
   *
   * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight4(headingTextLineHeight4: number): void

  /**
   * 设置五级标题文本行高
   *
   * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight5(headingTextLineHeight5: number): void

  /**
   * 设置六级标题文本行高
   *
   * @param headingTextLineHeight6 六级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight6(headingTextLineHeight6: number): void

  /**
   * 设置一级标题文本颜色
   *
   * @param headingTextColor1 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor1(headingTextColor1: number): void

  /**
   * 设置H1标题下分割线颜色
   *
   * @param headingBreakColor1 H1标题下分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setUnderlineColorForDesignateHeading
   */
  setHeadingBreakColor1(headingBreakColor1: number): void

  /**
   * 设置二级标题文本颜色
   *
   * @param headingTextColor2 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor2(headingTextColor2: number): void

  /**
   * 设置H2标题下分割线颜色
   *
   * @param headingBreakColor2 H2标题下分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setUnderlineColorForDesignateHeading
   */
  setHeadingBreakColor2(headingBreakColor2: number): void

  /**
   * 设置三级标题文本颜色
   *
   * @param headingTextColor3 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor3(headingTextColor3: number): void

  /**
   * 设置四级标题文本颜色
   *
   * @param headingTextColor4 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor4(headingTextColor4: number): void

  /**
   * 设置五级标题文本颜色
   *
   * @param headingTextColor5 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor5(headingTextColor5: number): void

  /**
   * 设置六级标题文本颜色
   *
   * @param headingTextColor6 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor6(headingTextColor6: number): void

  /**
   * 设置段落模块上间距
   *
   * @param paragraphTopMargins 段落模块上间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeParagraph#setParagraphMargin
   */
  setParagraphTopMargins(paragraphTopMargins: number): void

  /**
   * 设置段落模块下间距
   *
   * @param paragraphBottomMargins 段落模块下间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeParagraph#setParagraphMargin
   */
  setParagraphBottomMargins(paragraphBottomMargins: number): void

  /**
   * 设置段落文本大小
   *
   * @param paragraphTextSize 段落文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeParagraph#setParagraphTextFontSize
   */
  setParagraphTextSize(paragraphTextSize: number): void

  /**
   * 设置段落文本颜色
   *
   * @param paragraphTextColor 段落文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeParagraph#setParagraphTextFontColor
   */
  setParagraphTextColor(paragraphTextColor: number): void

  /**
   * 设置段落文本字间距
   *
   * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeParagraph#setParagraphTextLetterSpacing
   */
  setParagraphTextWordSpace(paragraphTextWordSpace: number): void

  /**
   * 设置段落文本行高
   *
   * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeParagraph#setParagraphTextLineHeight
   */
  setParagraphTextLineHeight(paragraphTextLineHeight: number): void

  /**
   * 设置段落文本字体
   *
   * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeParagraph#setParagraphTextFontFamily
   */
  setParagraphTypeface(paragraphTypeface: string): void

  /**
   * 设置分割线颜色
   *
   * @param thematicBreakColor 分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeDivider#setDividerColor
   */
  setThematicBreakColor(thematicBreakColor: number): void

  /**
   * 设置分割线高度
   *
   * @param thematicBreakHeight 分割线高度 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeDivider#setDividerStrokeWidth
   */
  setThematicBreakHeight(thematicBreakHeight: number): void

  /**
   * 设置分割线上部外边距
   *
   * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeDivider#setDividerMargin
   */
  setThematicBreakTopMargin(thematicBreakTopMargin: number): void

  /**
   * 设置分割线下部外边距
   *
   * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeDivider#setDividerMargin
   */
  setThematicBreakBottomMargin(thematicBreakBottomMargin: number): void

  /**
   * 设置软换行是否换行
   *
   * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setIsLineBreak
   */
  setIsLineBreak(isLineBreak: boolean): void

  /**
   * 设置数学公式未加载状态是否显示文字
   *
   * @param latexDefaultText 数学公式未加载状态是否显示文字 - 默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLatexMath#setLatexMathDefaultText
   */
  setLatexDefaultText(latexDefaultText: boolean): void

  /**
   * 设置数学公式文本大小
   *
   * @param latexMathTextSize 数学公式文本大小 - 默认16.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLatexMath#setLatexMathDefaultTextFontSize
   */
  setLatexMathTextSize(latexMathTextSize: number): void

  /**
   * 设置数学公式背景色
   *
   * @param latexMathBackGroupColor 数学公式背景色 - 默认Color.TRANSPARENT
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLatexMath#setLatexMathBackgroundColor
   */
  setLatexMathBackGroupColor(latexMathBackGroupColor: number): void

  /**
   * 设置数学公式文本颜色
   *
   * @param latexMathTextColor 数学公式文本颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLatexMath#setLatexMathTextColor
   */
  setLatexMathTextColor(latexMathTextColor: number): void

  /**
   * 设置数学公式生成图片格式
   *
   * @param latexMathColorFormat 数学公式生成图片格式 - 默认LatexMathColorFormat.0xFORMAT_BGRA_8888
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLatexMath#setLatexMathColorFormat
   */
  setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): void

  /**
   * 设置块结构的数学公式是否居中
   *
   * @param latexMathBlockCenter 块结构的数学公式是否居中 - true：居中；false：不居中。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLatexMath#setLatexMathBlockCenter
   */
  setLatexMathBlockCenter(latexMathBlockCenter: boolean): void

  /**
   * 设置数学公式字体路径
   *
   * @param latexMathResStr 数学公式字体路径 默认 "/data/storage/el1/bundle/entry/resources/resfile/res"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLatexMath#setLatexMathResPath
   */
  setLatexMathResStr(latexMathResStr: string): void

  /**
   * 设置音频阴影颜色值
   *
   * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioShadowColor
   */
  setAudioShadowColor(audioShadowColor: number): void

  /**
   * 设置音频边框颜色
   *
   * @param audioBorderColor 音频边框颜色 - 默认0x33000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioBorderColor
   */
  setAudioBorderColor(audioBorderColor: number): void

  /**
   * 设置音频边框粗细
   *
   * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioBorderWidth
   */
  setAudioBorderWidth(audioBorderWidth: number): void

  /**
   * 设置音频边框圆角
   *
   * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioBorderAllRadius
   */
  setAudioBorderRadius(audioBorderRadius: number): void

  /**
   * 设置音频按钮背景颜色
   *
   * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认Color.BLACK
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioButtonBackgroundColor
   */
  setAudioButtonBackgroundColor(audioButtonBackgroundColor: number): void

  /**
   * 设置音频按钮文字颜色
   *
   * @param audioButtonTextColor 音频按钮文字颜色 - 默认Color.WHITE
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioButtonTextFontColor
   */
  setAudioButtonTextColor(audioButtonTextColor: number): void

  /**
   * 设置音频按钮文字大小
   *
   * @param audioButtonTextSize 音频按钮文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioButtonTextFontSize
   */
  setAudioButtonTextSize(audioButtonTextSize: number): void

  /**
   * 设置音频按钮文字内容
   *
   * @param audioButtonText 音频按钮文字内容 - 默认"立即播放"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioButtonText
   */
  setAudioButtonText(audioButtonText: string): void

  /**
   * 设置音频按钮圆角
   *
   * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioButtonAllRadius
   */
  setAudioButtonBorderRadius(audioButtonBorderRadius: number): void

  /**
   * 设置音频标题文字大小
   *
   * @param audioTitleTextSize 音频标题文字大小 - 默认15.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioTitleTextFontSize
   */
  setAudioTitleTextSize(audioTitleTextSize: number): void

  /**
   * 设置音频标题文字颜色
   *
   * @param audioTitleTextColor音频标题文字颜色 - 默认Color.BLACK
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioTitleTextFontColor
   */
  setAudioTitleTextColor(audioTitleTextColor: number): void

  /**
   * 设置音频标题文字行高
   *
   * @param audioTitleTextLineHeight 音频标题文字行高 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioTitleTextLineHeight
   */
  setAudioTitleTextLineHeight(audioTitleTextLineHeight: number): void

  /**
   * 设置音频类型文字大小
   *
   * @param audioTypeTextSize 音频类型文字大小 - 默认11.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioTypeTextFontSize
   */
  setAudioTypeTextSize(audioTypeTextSize: number): void

  /**
   * 设置音频类型文字颜色
   *
   * @param audioTypeTextColor 音频类型文字颜色 - 默认0X80000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioTypeTextFontColor
   */
  setAudioTypeTextColor(audioTypeTextColor: number): void

  /**
   * 设置音频类型文字行高
   *
   * @param audioTypeTextLineHeight 音频类型文字行高 - 默认15.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioTypeTextLineHeight
   */
  setAudioTypeTextLineHeight(audioTypeTextLineHeight: number): void

  /**
   * 设置音频上边距
   *
   * @param audioMarginTop 音频上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioMargin
   */
  setAudioMarginTop(audioMarginTop: number): void

  /**
   * 设置音频下边距
   *
   * @param audioMarginBottom 音频下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioMargin
   */
  setAudioMarginBottom(audioMarginBottom: number): void

  /**
   * 设置视频圆角
   *
   * @param videoBorderRadius 视频圆角 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoBorderAllRadius
   */
  setVideoBorderRadius(videoBorderRadius: number): void

  /**
   * 设置视频时间文本颜色
   *
   * @param videoTimeTextColor 视频时间文本颜色 - 默认Color.WHITE
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoTimeTextFontColor
   */
  setVideoTimeTextColor(videoTimeTextColor: number): void

  /**
   * 设置视频时间文本大小
   *
   * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoTimeTextFontSize
   */
  setVideoTimeTextSize(videoTimeTextSize: number): void

  /**
   * 设置视频时间文本居右边距
   *
   * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoTimeTextMarginRight
   */
  setVideoTimeTextMarginRight(videoTimeTextMarginRight: number): void

  /**
   * 设置视频时间文本居底边距
   *
   * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoTimeTextMarginBottom
   */
  setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: number): void

  /**
   * 设置视频上边距
   *
   * @param videoMarginTop 视频上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoMargin
   */
  setVideoMarginTop(videoMarginTop: number): void

  /**
   * 设置视频下边距
   *
   * @param videoMarginBottom 视频下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoMargin
   */
  setVideoMarginBottom(videoMarginBottom: number): void

  /**
   * 设置视频发布/下载按钮布局是否显示
   *
   * @param isVideoBottomLayout 视频发布/下载按钮布局是否显示 - 默认false不显示
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoBottomLayoutVisible
   */
  setIsVideoBottomLayout(isVideoBottomLayout: boolean): void

  /**
   * 设置视频发布按钮图片宽度和高度
   *
   * @param videoReleaseImageWidthHeight 视频发布按钮图片宽度和高度 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonIconWidth
   *             MarkdownThemeVideo#setVideoReleaseButtonIconHeight
   */
  setVideoReleaseImageWidthHeight(videoReleaseImageWidthHeight: number): void

  /**
   * 设置视频发布按钮宽度
   *
   * @param videoReleaseWidth 视频发布按钮宽度 - 默认144.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonWidth
   */
  setVideoReleaseWidth(videoReleaseWidth: number): void

  /**
   * 设置视频发布按钮高度
   *
   * @param videoReleaseHeight 视频发布按钮高度 - 默认44.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonHeight
   */
  setVideoReleaseHeight(videoReleaseHeight: number): void

  /**
   * 设置视频发布按钮圆角
   *
   * @param videoReleaseRadius 视频发布按钮圆角 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonAllRadius
   */
  setVideoReleaseRadius(videoReleaseRadius: number): void

  /**
   * 设置视频发布按钮文本内容
   *
   * @param videoReleaseText 视频发布按钮文本内容 - 默认"发布视频"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonText
   */
  setVideoReleaseText(videoReleaseText: string): void

  /**
   * 设置视频发布按钮文本大小
   *
   * @param videoReleaseTexSize 视频发布按钮文本大小 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonTextFontSize
   */
  setVideoReleaseTexSize(videoReleaseTexSize: number): void

  /**
   * 设置视频发布按钮文本颜色
   *
   * @param videoReleaseTexColor 视频发布按钮文本颜色 - 默认0xE6000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonTextFontColor
   */
  setVideoReleaseTexColor(videoReleaseTexColor: number): void

  /**
   * 设置视频发布按钮背景颜色
   *
   * @param videoReleaseBackgroundColor 视频发布按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonBackgroundColor
   */
  setVideoReleaseBackgroundColor(videoReleaseBackgroundColor: number): void

  /**
   * 设置视频下载按钮图片宽度和高度
   *
   * @param videoDownloadImageWidthHeight 视频下载按钮图片宽度和高度 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonIconWidth
   *             MarkdownThemeVideo#setVideoDownloadButtonIconHeight
   */
  setVideoDownloadImageWidthHeight(videoDownloadImageWidthHeight: number): void

  /**
   * 设置视频下载按钮宽度
   *
   * @param videoDownloadWidth 视频下载按钮宽度 - 默认144.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonWidth
   */
  setVideoDownloadWidth(videoDownloadWidth: number): void

  /**
   * 设置视频下载按钮高度
   *
   * @param videoDownloadHeight 视频下载按钮高度 - 默认44.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonHeight
   */
  setVideoDownloadHeight(videoDownloadHeight: number): void

  /**
   * 设置视频下载按钮圆角
   *
   * @param videoDownloadRadius 视频下载按钮圆角 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonAllRadius
   */
  setVideoDownloadRadius(videoDownloadRadius: number): void

  /**
   * 设置视频下载按钮文本内容
   *
   * @param videoDownloadText 视频下载按钮文本内容 - 默认"下载视频"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonText
   */
  setVideoDownloadText(videoDownloadText: string): void

  /**
   * 设置视频下载按钮文本大小
   *
   * @param videoDownloadTexSize 视频下载按钮文本大小 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonTextFontSize
   */
  setVideoDownloadTexSize(videoDownloadTexSize: number): void

  /**
   * 设置视频下载按钮文本颜色
   *
   * @param videoDownloadTexColor 视频下载按钮文本颜色 - 默认0xE6000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonTextFontColor
   */
  setVideoDownloadTexColor(videoDownloadTexColor: number): void

  /**
   * 设置视频下载按钮背景颜色
   *
   * @param videoDownloadBackgroundColor 视频下载按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonBackgroundColor
   */
  setVideoDownloadBackgroundColor(videoDownloadBackgroundColor: number): void

  /**
   * 设置图片缩放类型
   *
   * @param imageFitType 图片缩放类型 - 默认ImageFit.Contain
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageFitType
   */
  setImageFitType(imageFitType: ImageFitType): void

  /**
   * 设置图片基于自身宽度缩放百分比
   *
   * @param imageMaximumWidth 图片基于自身宽度缩放百分比 - 默认1.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageMaximumWidth
   */
  setImageMaximumWidth(imageMaximumWidth: number): void

  /**
   * 设置图片基于父布局宽度缩放百分比
   *
   * @param imageFixedRatioWidth 图片基于父布局宽度缩放百分比 - 默认None
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageFixedRatioWidth
   */
  setImageFixedRatioWidth(imageFixedRatioWidth: number): void

  /**
   * 设置图片最大高度
   *
   * @param imageMaxHeight 图片最大高度 - 默认None
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageMaxHeight
   */
  setImageMaxHeight(imageMaxHeight: number): void

  /**
   * 设置图片最大宽度
   *
   * @param imageMaxWidth 图片最大宽度 - 默认None
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageMaxWidth
   */
  setImageMaxWidth(imageMaxWidth: number): void

  /**
   * 设置图片圆角大小
   *
   * @param imageBorderRadius 图片圆角大小 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageBorderAllRadius
   */
  setImageBorderRadius(imageBorderRadius: number): void

  /**
   * 设置图片边框宽度
   *
   * @param imageBorderWidth 图片边框宽度 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageBorderWidth
   */
  setImageBorderWidth(imageBorderWidth: number): void

  /**
   * 设置图片边框颜色
   *
   * @param imageBorderColor 图片边框颜色 - 默认Color.BLACK
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageBorderColor
   */
  setImageBorderColor(imageBorderColor: number): void

  /**
   * 设置网络图片是否压缩
   *
   * @param isAutoResize 网络图片是否压缩 - true：压缩；false：不压缩。默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageAutoResize
   */
  setIsAutoResize(isAutoResize: boolean): void

  /**
   * 设置图片上边距
   *
   * @param imageMarginTop 图片上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageMargin
   */
  setImageMarginTop(imageMarginTop: number): void

  /**
   * 设置图片下边距
   *
   * @param imageMarginBottom 图片下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageMargin
   */
  setImageMarginBottom(imageMarginBottom: number): void

  /**
   * 设置图片是否有下载按钮
   *
   * @param isImageDownload 图片是否有下载按钮 - 默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonVisible
   */
  setIsImageDownload(isImageDownload: boolean): void

  /**
   * 设置是否图文混排
   *
   * @param isImageMixedLayout 是否图文混排 - 默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setIsImageMixedLayout
   */
  setIsImageMixedLayout(isImageMixedLayout: boolean): void

  /**
   * 设置图片下载按钮图片宽度和高度
   *
   * @param imageDownloadImageWidthHeight 图片下载按钮图片宽度和高度 - 默认18.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonIconWidth
   *             MarkdownThemeImage#setImageDownloadButtonIconHeight
   */
  setImageDownloadImageWidthHeight(imageDownloadImageWidthHeight: number): void

  /**
   * 设置图片下载按钮宽度
   *
   * @param imageDownloadWidth 图片下载按钮宽度 - 默认296.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonWidth
   */
  setImageDownloadWidth(imageDownloadWidth: number): void

  /**
   * 设置图片下载按钮高度
   *
   * @param imageDownloadHeight 图片下载按钮高度 - 默认44.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonHeight
   */
  setImageDownloadHeight(imageDownloadHeight: number): void

  /**
   * 设置图片下载按钮圆角
   *
   * @param imageDownloadRadius 图片下载按钮圆角 - 默认22.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonAllRadius
   */
  setImageDownloadRadius(imageDownloadRadius: number): void

  /**
   * 设置图片下载按钮文本内容
   *
   * @param imageDownloadText 图片下载按钮文本内容 - 默认"下载图片"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonText
   */
  setImageDownloadText(imageDownloadText: string): void

  /**
   * 设置图片下载按钮文本大小
   *
   * @param imageDownloadTexSize 图片下载按钮文本大小 - 默认16.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonTextFontSize
   */
  setImageDownloadTexSize(imageDownloadTexSize: number): void

  /**
   * 设置图片下载按钮文本颜色
   *
   * @param imageDownloadTexColor 图片下载按钮文本颜色 - 默认0XE6000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonTextFontColor
   */
  setImageDownloadTexColor(imageDownloadTexColor: number): void

  /**
   * 设置图片下载按钮背景颜色
   *
   * @param imageDownloadBackgroundColor 图片下载按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonBackgroundColor
   */
  setImageDownloadBackgroundColor(imageDownloadBackgroundColor: number): void

  /**
   * 设置表格内容内边距
   *
   * @param tableCellPadding 表格内容内边距 - 默认4.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableCellAllPadding
   */
  setTableCellPadding(tableCellPadding: number): void

  /**
   * 设置表格边框颜色
   *
   * @param tableBorderColor 表格边框颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableBorderColor
   */
  setTableBorderColor(tableBorderColor: number): void

  /**
   * 设置表格边框宽度
   *
   * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableBorderWidth
   */
  setTableBorderWidth(tableBorderWidth: number): void

  /**
   * 设置表格奇数行背景色
   *
   * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableContentOddRowBackgroundColor
   */
  setTableOddRowBackgroundColor(tableOddRowBackgroundColor: number): void

  /**
   * 设置表格偶数行背景色
   *
   * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0xFFE0E0E0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableContentEvenRowBackgroundColor
   */
  setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: number): void

  /**
   * 设置表格标题背景色
   *
   * @param tableHeaderRowBackgroundColor 表格标题背景色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableTitleBackgroundColor
   */
  setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: number): void

  /**
   * 设置表格标题文本颜色
   *
   * @param tableTitleTextColor 表格标题文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableTitleTextFontColor
   */
  setTableTitleTextColor(tableTitleTextColor: number): void

  /**
   * 设置表格文本行高
   *
   * @param tableTextLineHeight 表格文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableContentTextLineHeight
   *             MarkdownThemeTable#setTableTitleTextLineHeight
   */
  setTableTextLineHeight(tableTextLineHeight: number): void

  /**
   * 设置表格标题文本大小
   *
   * @param tableTitleTextSize 表格标题文本大小 - 默认14.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableTitleTextFontSize
   */
  setTableTitleTextSize(tableTitleTextSize: number): void

  /**
   * 设置表格标题文本行高
   *
   * @param tableTitleLineHeight 表格标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableTitleTextLineHeight
   */
  setTableTitleLineHeight(tableTitleLineHeight: number): void

  /**
   * 设置表格内容文本颜色
   *
   * @param tableContentTextColor 表格内容文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableContentTextFontColor
   */
  setTableContentTextColor(tableContentTextColor: number): void

  /**
   * 设置表格内容文本大小
   *
   * @param tableContentTextSize 表格内容文本大小 - 默认14.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableContentTextFontSize
   */
  setTableContentTextSize(tableContentTextSize: number): void

  /**
   * 设置表格内容文本行高
   *
   * @param tableTextLineHeight 表格内容文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableContentTextLineHeight
   */
  setTableContentTextLineHeight(tableTextLineHeight: number): void

  /**
   * 设置表格圆角
   *
   * @param tableRadius 表格圆角 - 默认5.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableAllRadius
   */
  setTableRadius(tableRadius: number): void

  /**
   * 设置表格最小宽度
   *
   * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableMinCellWidth
   */
  setTableMinTextWidth(tableMinTextWidth: number): void

  /**
   * 设置表格最大宽度
   *
   * @param tableMaxTextWidth 表格最大宽度- 默认300.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableMaxCellWidth
   */
  setTableMaxTextWidth(tableMaxTextWidth: number): void

  /**
   * 设置表格第一列是否加粗
   *
   * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableFirstColumnIsBold
   */
  setTableFirstColumnBold(tableFirstColumnBold: boolean): void

  /**
   * 设置表格是否显示滚动条
   *
   * @param tableScrollBarShow 表格是否显示滚动条 - true：显示(auto状态)；false：不显示。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableScrollBarState
   */
  setTableScrollBarShow(tableScrollBarShow: boolean): void

  /**
   * 设置表格滚动条颜色
   *
   * @param tableScrollBarColor 表格滚动条颜色
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableScrollBarColor
   */
  setTableScrollBarColor(tableScrollBarColor: number): void

  /**
   * 设置代码块深浅色
   *
   * @param isDark 是否是深色 - true：深色；false：浅色。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockIsDark
   */
  setIsDark(isDark: boolean): void

  /**
   * 设置删除线颜色
   *
   * @param strikethroughColor 删除线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeStrikethrough#setStrikethroughTextDecorationColor
   */
  setStrikethroughColor(strikethroughColor: number): void

  /**
   * 设置删除线样式
   *
   * @param strikethroughStyle 删除线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeStrikethrough#setStrikethroughTextDecorationStyle
   */
  setStrikethroughStyle(strikethroughStyle: MarkdownTextDecorationStyle): void

  /**
   * 设置定义列表术语和定义行之间间距
   *
   * @param descListTermAndDefMargins 定义列表定义行缩进 默认8.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeDefinitionList#setDefinitionListTermToDescriptionSpacing
   */
  setDescListTermAndDefMargins(descListTermAndDefMargins: number): void

  /**
   * 设置定义列表定义行缩进
   *
   * @param descListDefIndentation 定义列表定义行缩进 默认8.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeDefinitionList#setDefinitionListDescriptionIndent
   */
  setDescListDefIndentation(descListDefIndentation: number): void

  /**
   * 设置定义列表定义行间距
   *
   * @param descListDefMargins 定义列表定义行间距 默认8.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeDefinitionList#setDefinitionListDescriptionItemSpacing
   */
  setDescListDefMargins(descListDefMargins: number): void

  /**
   * 设置下标字体颜色
   *
   * @param subTextColor 下标字体颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeSub#setSubTextFontColor
   */
  setSubTextColor(subTextColor: number): void

  /**
   * 设置下标字体大小
   *
   * @param subTextSize 下标字体大小 默认8.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeSub#setSubTextFontSize
   */
  setSubTextSize(subTextSize: number): void

  /**
   * 设置下标偏移距离
   *
   * @param subOffsetDist 下标偏移距离 默认0.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeSub#setSubTextBaselineOffset
   */
  setSubOffsetDist(subOffsetDist: number): void

  /**
   * 设置上标字体颜色
   *
   * @param supTextColor 上标字体颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeSup#setSupTextFontColor
   */
  setSupTextColor(supTextColor: number): void

  /**
   * 设置上标字体大小
   *
   * @param supTextSize 上标字体大小 默认8.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeSup#setSupTextFontSize
   */
  setSupTextSize(supTextSize: number): void

  /**
   * 设置上标偏移距离
   *
   * @param supOffsetDist 上标偏移距离 默认6.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeSup#setSupTextBaselineOffset
   */
  setSupOffsetDist(supOffsetDist: number): void

  /**
   * 设置下划线颜色
   *
   * @param underlineColor 下划线颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHtmlUnderline#setHtmlUnderlineTextDecorationColor
   */
  setUnderlineColor(underlineColor: number): void

  /**
   * 设置下划线样式
   *
   * @param underlineStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHtmlUnderline#setHtmlUnderlineTextDecorationStyle
   */
  setUnderlineStyle(underlineStyle: MarkdownTextDecorationStyle): void

  /**
   * 设置markdown是否支持滚动手势
   *
   * @param openGestureSwipe true-支持滚动手势，false-不支持滚动手势，默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setOpenGestureSwipe
   */
  setOpenGestureSwipe(openGestureSwipe: boolean): void

  /**
   * 设置codeformat是否用制表符
   *
   * @param useTab true-使用，false-不使用，默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockUseTab
   */
  setUseTab(useTab: boolean): void

  /**
   * 设置codeformat空格缩进数量
   *
   * @param indentWidth 空格缩进数量，默认4空格
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockIndentWidth
   */
  setIndentWidth(indentWidth: number): void

  /**
   * 获取是否按照链接文本字体大小显示文本
   *
   * @returns 是否按照链接文本字体大小显示文本
   */
  getIsLinkSize(): boolean | undefined

  /**
   * 获取全局样式
   *
   * @returns 全局样式对象
   */
  getMarkdownThemeGlobal(): MarkdownThemeGlobal

  /**
   * 获取音频样式
   *
   * @returns 音频样式对象
   */
  getMarkdownThemeAudio(): MarkdownThemeAudio

  /**
   * 获取Banner样式
   *
   * @returns Banner样式对象
   */
  getMarkdownThemeBanner(): MarkdownThemeBanner

  /**
   * 获取块引用样式
   *
   * @returns 块引用样式对象
   */
  getMarkdownThemeBlockQuote(): MarkdownThemeBlockQuote

  /**
   * 获取加粗文本样式
   *
   * @returns 加粗文本样式对象
   */
  getMarkdownThemeBold(): MarkdownThemeBold

  /**
   * 获取代码块样式
   *
   * @returns 代码块样式对象
   */
  getMarkdownThemeCodeBlock(): MarkdownThemeCodeBlock

  /**
   * 获取定义列表样式
   *
   * @returns 定义列表样式对象
   */
  getMarkdownThemeDefinitionList(): MarkdownThemeDefinitionList

  /**
   * 获取分割线样式
   *
   * @returns 分割线样式对象
   */
  getMarkdownThemeDivider(): MarkdownThemeDivider

  /**
   * 获取脚注定义样式
   *
   * @returns 脚注定义样式对象
   */
  getMarkdownThemeFootnoteDef(): MarkdownThemeFootnoteDef

  /**
   * 获取脚注引用样式
   *
   * @returns 脚注引用样式对象
   */
  getMarkdownThemeFootnoteRef(): MarkdownThemeFootnoteRef

  /**
   * 获取数学公式样式
   *
   * @returns 数学公式样式对象
   */
  getMarkdownThemeLatexMath(): MarkdownThemeLatexMath

  /**
   * 获取标题样式
   *
   * @returns 标题样式对象
   */
  getMarkdownThemeHeading(): MarkdownThemeHeading

  /**
   * 获取HTML下划线文本样式
   *
   * @returns HTML下划线文本样式对象
   */
  getMarkdownThemeHtmlUnderline(): MarkdownThemeHtmlUnderline

  /**
   * 获取图片样式
   *
   * @returns 图片样式对象
   */
  getMarkdownThemeImage(): MarkdownThemeImage

  /**
   * 获取内联代码样式
   *
   * @returns 内联代码样式对象
   */
  getMarkdownThemeInlineCode(): MarkdownThemeInlineCode

  /**
   * 获取斜体文本样式
   *
   * @returns 斜体文本样式对象
   */
  getMarkdownThemeItalic(): MarkdownThemeItalic

  /**
   * 获取链接文本样式
   *
   * @returns 链接文本样式对象
   */
  getMarkdownThemeLink(): MarkdownThemeLink

  /**
   * 获取有序列表样式
   *
   * @returns 有序列表样式对象
   */
  getMarkdownThemeOrderedList(): MarkdownThemeOrderedList

  /**
   * 获取段落样式
   *
   * @returns 段落样式对象
   */
  getMarkdownThemeParagraph(): MarkdownThemeParagraph

  /**
   * 获取删除线文本样式
   *
   * @returns 删除线文本样式对象
   */
  getMarkdownThemeStrikethrough(): MarkdownThemeStrikethrough

  /**
   * 获取下标文本样式
   *
   * @returns 下标文本样式对象
   */
  getMarkdownThemeSub(): MarkdownThemeSub

  /**
   * 获取上标文本样式
   *
   * @returns 上标文本样式对象
   */
  getMarkdownThemeSup(): MarkdownThemeSup

  /**
   * 获取表格样式
   *
   * @returns 表格样式对象
   */
  getMarkdownThemeTable(): MarkdownThemeTable

  /**
   * 获取无序/任务列表样式
   *
   * @returns 无序/任务列表样式对象
   */
  getMarkdownThemeBulletList(): MarkdownThemeBulletList

  /**
   * 获取视频样式
   *
   * @returns 视频样式对象
   */
  getMarkdownThemeVideo(): MarkdownThemeVideo

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
   * 设置4个外边距为统一值
   *
   * @param margin 外边距
   */
  setGlobalAllMargin(margin: number): void

  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setGlobalMargin(top?: number, right?: number, bottom?: number, left?: number): void

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

  /**
   * 获取stageContext
   *
   * @returns stageContext
   */
  getStageContext(): Context | undefined

  /**
   * 获取isMarkdownParserSync
   *
   * @returns isMarkdownParserSync
   */
  getIsMarkdownParserSync(): boolean | undefined

  /**
   * 获取isOnCopy
   *
   * @returns isOnCopy
   */
  getIsOnCopy(): boolean | undefined

  /**
   * 获取blockMarginTop
   *
   * @returns blockMarginTop
   */
  getBlockMarginTop(): number | undefined

  /**
   * 获取blockMarginRight
   *
   * @returns blockMarginRight
   */
  getBlockMarginRight(): number | undefined

  /**
   * 获取blockMarginBottom
   *
   * @returns blockMarginBottom
   */
  getBlockMarginBottom(): number | undefined

  /**
   * 获取blockMarginLeft
   *
   * @returns blockMarginLeft
   */
  getBlockMarginLeft(): number | undefined

  /**
   * 获取markdownBlockSpacing
   *
   * @returns markdownBlockSpacing
   */
  getMarkdownBlockSpacing(): number | undefined

  /**
   * 获取isLineBreak
   *
   * @returns isLineBreak
   */
  getIsLineBreak(): boolean | undefined

  /**
   * 获取openGestureSwipe
   *
   * @returns openGestureSwipe
   */
  getOpenGestureSwipe(): boolean | undefined

  /**
   * 获取backgroundColor
   *
   * @returns backgroundColor
   */
  getBackgroundColor(): number | undefined

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

  /**
   * 获取italicTextFontColor
   *
   * @returns italicTextFontColor
   */
  getItalicTextFontColor(): number | undefined

  /**
   * 获取italicTextFontSize
   *
   * @returns italicTextFontSize
   */
  getItalicTextFontSize(): number | undefined

  /**
   * 获取italicTextFontWeight
   *
   * @returns italicTextFontWeight
   */
  getItalicTextFontWeight(): FontWeight | undefined

  /**
   * 获取italicTextFontFamily
   *
   * @returns italicTextFontFamily
   */
  getItalicTextFontFamily(): string | undefined

  /**
   * 获取italicTextLineHeight
   *
   * @returns italicTextLineHeight
   */
  getItalicTextLineHeight(): number | undefined

  /**
   * 获取italicTextLetterSpacing
   *
   * @returns italicTextLetterSpacing
   */
  getItalicTextLetterSpacing(): number | undefined

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

  /**
   * 获取strikethroughTextFontColor
   *
   * @returns strikethroughTextFontColor
   */
  getStrikethroughTextFontColor(): number | undefined

  /**
   * 获取strikethroughTextFontSize
   *
   * @returns strikethroughTextFontSize
   */
  getStrikethroughTextFontSize(): number | undefined

  /**
   * 获取strikethroughTextFontStyle
   *
   * @returns strikethroughTextFontStyle
   */
  getStrikethroughTextFontStyle(): FontStyle | undefined

  /**
   * 获取strikethroughTextFontWeight
   *
   * @returns strikethroughTextFontWeight
   */
  getStrikethroughTextFontWeight(): FontWeight | undefined

  /**
   * 获取strikethroughTextFontFamily
   *
   * @returns strikethroughTextFontFamily
   */
  getStrikethroughTextFontFamily(): string | undefined

  /**
   * 获取strikethroughTextLineHeight
   *
   * @returns strikethroughTextLineHeight
   */
  getStrikethroughTextLineHeight(): number | undefined

  /**
   * 获取strikethroughTextLetterSpacing
   *
   * @returns strikethroughTextLetterSpacing
   */
  getStrikethroughTextLetterSpacing(): number | undefined

  /**
   * 获取strikethroughTextDecorationColor
   *
   * @returns strikethroughTextDecorationColor
   */
  getStrikethroughTextDecorationColor(): number | undefined

  /**
   * 获取strikethroughTextDecorationStyle
   *
   * @returns strikethroughTextDecorationStyle
   */
  getStrikethroughTextDecorationStyle(): MarkdownTextDecorationStyle | undefined

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

  /**
   * 获取subTextFontColor
   *
   * @returns subTextFontColor
   */
  getSubTextFontColor(): number | undefined

  /**
   * 获取subTextFontSize
   *
   * @returns subTextFontSize
   */
  getSubTextFontSize(): number | undefined

  /**
   * 获取subTextFontStyle
   *
   * @returns subTextFontStyle
   */
  getSubTextFontStyle(): FontStyle | undefined

  /**
   * 获取subTextFontWeight
   *
   * @returns subTextFontWeight
   */
  getSubTextFontWeight(): FontWeight | undefined

  /**
   * 获取subTextFontFamily
   *
   * @returns subTextFontFamily
   */
  getSubTextFontFamily(): string | undefined

  /**
   * 获取subTextLetterSpacing
   *
   * @returns subTextLetterSpacing
   */
  getSubTextLetterSpacing(): number | undefined

  /**
   * 获取subTextBaselineOffset
   *
   * @returns subTextBaselineOffset
   */
  getSubTextBaselineOffset(): number | undefined

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

  /**
   * 获取supTextFontColor
   *
   * @returns supTextFontColor
   */
  getSupTextFontColor(): number | undefined

  /**
   * 获取supTextFontSize
   *
   * @returns supTextFontSize
   */
  getSupTextFontSize(): number | undefined

  /**
   * 获取supTextFontStyle
   *
   * @returns supTextFontStyle
   */
  getSupTextFontStyle(): FontStyle | undefined

  /**
   * 获取supTextFontWeight
   *
   * @returns supTextFontWeight
   */
  getSupTextFontWeight(): FontWeight | undefined

  /**
   * 获取supTextFontFamily
   *
   * @returns supTextFontFamily
   */
  getSupTextFontFamily(): string | undefined

  /**
   * 获取supTextLetterSpacing
   *
   * @returns supTextLetterSpacing
   */
  getSupTextLetterSpacing(): number | undefined

  /**
   * 获取supTextBaselineOffset
   *
   * @returns supTextBaselineOffset
   */
  getSupTextBaselineOffset(): number | undefined

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

  /**
   * 获取htmlUnderlineTextFontColor
   *
   * @returns htmlUnderlineTextFontColor
   */
  getHtmlUnderlineTextFontColor(): number | undefined

  /**
   * 获取htmlUnderlineTextFontSize
   *
   * @returns htmlUnderlineTextFontSize
   */
  getHtmlUnderlineTextFontSize(): number | undefined

  /**
   * 获取htmlUnderlineTextFontStyle
   *
   * @returns htmlUnderlineTextFontStyle
   */
  getHtmlUnderlineTextFontStyle(): FontStyle | undefined

  /**
   * 获取htmlUnderlineTextFontWeight
   *
   * @returns htmlUnderlineTextFontWeight
   */
  getHtmlUnderlineTextFontWeight(): FontWeight | undefined

  /**
   * 获取htmlUnderlineTextFontFamily
   *
   * @returns htmlUnderlineTextFontFamily
   */
  getHtmlUnderlineTextFontFamily(): string | undefined

  /**
   * 获取htmlUnderlineTextLineHeight
   *
   * @returns htmlUnderlineTextLineHeight
   */
  getHtmlUnderlineTextLineHeight(): number | undefined

  /**
   * 获取htmlUnderlineTextLetterSpacing
   *
   * @returns htmlUnderlineTextLetterSpacing
   */
  getHtmlUnderlineTextLetterSpacing(): number | undefined

  /**
   * 获取htmlUnderlineTextDecorationColor
   *
   * @returns htmlUnderlineTextDecorationColor
   */
  getHtmlUnderlineTextDecorationColor(): number | undefined

  /**
   * 获取htmlUnderlineTextDecorationStyle
   *
   * @returns htmlUnderlineTextDecorationStyle
   */
  getHtmlUnderlineTextDecorationStyle(): MarkdownTextDecorationStyle | undefined

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
   * 统一设置链接文本背景四个圆角
   *
   * @param radius 统一圆角半径，同时赋值给四个角
   */
  setLinkTextBackgroundAllRadius(radius: number): void

  /**
   * 分别设置4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setLinkTextBackgroundRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

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

  /**
   * 获取linkIsIcon
   *
   * @returns linkIsIcon
   */
  getLinkIsIcon(): boolean | undefined

  /**
   * 获取linkListIsIcon
   *
   * @returns linkListIsIcon
   */
  getLinkListIsIcon(): boolean | undefined

  /**
   * 获取linkTextFontColor
   *
   * @returns linkTextFontColor
   */
  getLinkTextFontColor(): number | undefined

  /**
   * 获取linkTextFontSize
   *
   * @returns linkTextFontSize
   */
  getLinkTextFontSize(): number | undefined

  /**
   * 获取linkTextFontStyle
   *
   * @returns linkTextFontStyle
   */
  getLinkTextFontStyle(): FontStyle | undefined

  /**
   * 获取linkTextFontWeight
   *
   * @returns linkTextFontWeight
   */
  getLinkTextFontWeight(): FontWeight | undefined

  /**
   * 获取linkTextFontFamily
   *
   * @returns linkTextFontFamily
   */
  getLinkTextFontFamily(): string | undefined

  /**
   * 获取linkTextLineHeight
   *
   * @returns linkTextLineHeight
   */
  getLinkTextLineHeight(): number | undefined

  /**
   * 获取linkTextLetterSpacing
   *
   * @returns linkTextLetterSpacing
   */
  getLinkTextLetterSpacing(): number | undefined

  /**
   * 获取linkTextDecorationType
   *
   * @returns linkTextDecorationType
   */
  getLinkTextDecorationType(): TextDecorationType | undefined

  /**
   * 获取linkTextDecorationColor
   *
   * @returns linkTextDecorationColor
   */
  getLinkTextDecorationColor(): number | undefined

  /**
   * 获取linkTextDecorationStyle
   *
   * @returns linkTextDecorationStyle
   */
  getLinkTextDecorationStyle(): TextDecorationStyle | undefined

  /**
   * 获取linkTextBackgroundColor
   *
   * @returns linkTextBackgroundColor
   */
  getLinkTextBackgroundColor(): number | undefined

  /**
   * 获取linkTextBackgroundRadiusTopLeft
   *
   * @returns linkTextBackgroundRadiusTopLeft
   */
  getLinkTextBackgroundRadiusTopLeft(): number | undefined

  /**
   * 获取linkTextBackgroundRadiusTopRight
   *
   * @returns linkTextBackgroundRadiusTopRight
   */
  getLinkTextBackgroundRadiusTopRight(): number | undefined

  /**
   * 获取linkTextBackgroundRadiusBottomLeft
   *
   * @returns linkTextBackgroundRadiusBottomLeft
   */
  getLinkTextBackgroundRadiusBottomLeft(): number | undefined

  /**
   * 获取linkTextBackgroundRadiusBottomRight
   *
   * @returns linkTextBackgroundRadiusBottomRight
   */
  getLinkTextBackgroundRadiusBottomRight(): number | undefined

  /**
   * 获取linkCircleIconBackgroundColor
   *
   * @returns linkCircleIconBackgroundColor
   */
  getLinkCircleIconBackgroundColor(): number | undefined

  /**
   * 获取linkCircleIconButtonBackgroundColor
   *
   * @returns linkCircleIconButtonBackgroundColor
   */
  getLinkCircleIconButtonBackgroundColor(): number | undefined

  /**
   * 获取linkCircleIconTextSize
   *
   * @returns linkCircleIconTextSize
   */
  getLinkCircleIconTextSize(): number | undefined

  /**
   * 获取linkCircleIconTextColor
   *
   * @returns linkCircleIconTextColor
   */
  getLinkCircleIconTextColor(): number | undefined

  /**
   * 获取linkCircleIconRadius
   *
   * @returns linkCircleIconRadius
   */
  getLinkCircleIconRadius(): number | undefined

  /**
   * 获取linkCircleIconMargin
   *
   * @returns linkCircleIconMargin
   */
  getLinkCircleIconMargin(): number | undefined

  /**
   * 获取linkRectIconBackgroundColor
   *
   * @returns linkRectIconBackgroundColor
   */
  getLinkRectIconBackgroundColor(): number | undefined

  /**
   * 获取linkRectIconButtonBackgroundColor
   *
   * @returns linkRectIconButtonBackgroundColor
   */
  getLinkRectIconButtonBackgroundColor(): number | undefined

  /**
   * 获取linkRectIconTextSize
   *
   * @returns linkRectIconTextSize
   */
  getLinkRectIconTextSize(): number | undefined

  /**
   * 获取linkRectIconTextColor
   *
   * @returns linkRectIconTextColor
   */
  getLinkRectIconTextColor(): number | undefined

  /**
   * 获取linkRectIconHeight
   *
   * @returns linkRectIconHeight
   */
  getLinkRectIconHeight(): number | undefined

  /**
   * 获取linkRectIconPadding
   *
   * @returns linkRectIconPadding
   */
  getLinkRectIconPadding(): number | undefined

  /**
   * 获取linkRectIconRadius
   *
   * @returns linkRectIconRadius
   */
  getLinkRectIconRadius(): number | undefined

  /**
   * 获取linkRectIconMargin
   *
   * @returns linkRectIconMargin
   */
  getLinkRectIconMargin(): number | undefined

  /**
   * 获取linkRectToolIconBackgroundColor
   *
   * @returns linkRectToolIconBackgroundColor
   */
  getLinkRectToolIconBackgroundColor(): number | undefined

  /**
   * 获取linkRectToolIconButtonBackgroundColor
   *
   * @returns linkRectToolIconButtonBackgroundColor
   */
  getLinkRectToolIconButtonBackgroundColor(): number | undefined

  /**
   * 获取linkRectToolIconTextSize
   *
   * @returns linkRectToolIconTextSize
   */
  getLinkRectToolIconTextSize(): number | undefined

  /**
   * 获取linkRectToolIconHeight
   *
   * @returns linkRectToolIconHeight
   */
  getLinkRectToolIconHeight(): number | undefined

  /**
   * 获取linkRectToolIconPadding
   *
   * @returns linkRectToolIconPadding
   */
  getLinkRectToolIconPadding(): number | undefined

  /**
   * 获取linkRectToolIconBorderWidth
   *
   * @returns linkRectToolIconBorderWidth
   */
  getLinkRectToolIconBorderWidth(): number | undefined

  /**
   * 获取linkRectToolIconDividingLineWidth
   *
   * @returns linkRectToolIconDividingLineWidth
   */
  getLinkRectToolIconDividingLineWidth(): number | undefined

  /**
   * 获取linkRectToolIconMargin
   *
   * @returns linkRectToolIconMargin
   */
  getLinkRectToolIconMargin(): number | undefined

  /**
   * 获取linkRectToolIconLineLeftPadding
   *
   * @returns linkRectToolIconLineLeftPadding
   */
  getLinkRectToolIconLineLeftPadding(): number | undefined

  /**
   * 获取linkRectToolIconLineRightPadding
   *
   * @returns linkRectToolIconLineRightPadding
   */
  getLinkRectToolIconLineRightPadding(): number | undefined

}
```

### class MarkdownThemeParagraph

Markdown用户可设置的样式-段落样式

```ets
export class MarkdownThemeParagraph {
  /**
   * 设置4个外边距为统一值
   *
   * @param margin 外边距
   */
  setParagraphAllMargin(margin: number): void

  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setParagraphMargin(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 设置4个内边距为统一值
   *
   * @param padding 内边距
   */
  setParagraphAllPadding(padding: number): void

  /**
   * 分别设置4个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setParagraphPadding(top?: number, right?: number, bottom?: number, left?: number): void

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

  /**
   * 获取paragraphBackgroundColor
   *
   * @returns paragraphBackgroundColor
   */
  getParagraphBackgroundColor(): number | undefined

  /**
   * 获取paragraphMarginTop
   *
   * @returns paragraphMarginTop
   */
  getParagraphMarginTop(): number | undefined

  /**
   * 获取paragraphMarginRight
   *
   * @returns paragraphMarginRight
   */
  getParagraphMarginRight(): number | undefined

  /**
   * 获取paragraphMarginBottom
   *
   * @returns paragraphMarginBottom
   */
  getParagraphMarginBottom(): number | undefined

  /**
   * 获取paragraphMarginLeft
   *
   * @returns paragraphMarginLeft
   */
  getParagraphMarginLeft(): number | undefined

  /**
   * 获取paragraphPaddingTop
   *
   * @returns paragraphPaddingTop
   */
  getParagraphPaddingTop(): number | undefined

  /**
   * 获取paragraphPaddingRight
   *
   * @returns paragraphPaddingRight
   */
  getParagraphPaddingRight(): number | undefined

  /**
   * 获取paragraphPaddingBottom
   *
   * @returns paragraphPaddingBottom
   */
  getParagraphPaddingBottom(): number | undefined

  /**
   * 获取paragraphPaddingLeft
   *
   * @returns paragraphPaddingLeft
   */
  getParagraphPaddingLeft(): number | undefined

  /**
   * 获取paragraphTextFontColor
   *
   * @returns paragraphTextFontColor
   */
  getParagraphTextFontColor(): number | undefined

  /**
   * 获取paragraphTextFontSize
   *
   * @returns paragraphTextFontSize
   */
  getParagraphTextFontSize(): number | undefined

  /**
   * 获取paragraphTextFontStyle
   *
   * @returns paragraphTextFontStyle
   */
  getParagraphTextFontStyle(): FontStyle | undefined

  /**
   * 获取paragraphTextFontWeight
   *
   * @returns paragraphTextFontWeight
   */
  getParagraphTextFontWeight(): FontWeight | undefined

  /**
   * 获取paragraphTextFontFamily
   *
   * @returns paragraphTextFontFamily
   */
  getParagraphTextFontFamily(): string | undefined

  /**
   * 获取paragraphTextLineHeight
   *
   * @returns paragraphTextLineHeight
   */
  getParagraphTextLineHeight(): number | undefined

  /**
   * 获取paragraphTextLetterSpacing
   *
   * @returns paragraphTextLetterSpacing
   */
  getParagraphTextLetterSpacing(): number | undefined

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
   * 统一设置内联代码文本背景四个圆角
   *
   * @param radius 统一圆角半径，同时赋值给四个角
   */
  setInlineCodeTextBackgroundAllRadius(radius: number): void

  /**
   * 分别设置4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setInlineCodeTextBackgroundRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

  /**
   * 获取inlineCodeTextFontColor
   *
   * @returns inlineCodeTextFontColor
   */
  getInlineCodeTextFontColor(): number | undefined

  /**
   * 获取inlineCodeTextFontSize
   *
   * @returns inlineCodeTextFontSize
   */
  getInlineCodeTextFontSize(): number | undefined

  /**
   * 获取inlineCodeTextFontStyle
   *
   * @returns inlineCodeTextFontStyle
   */
  getInlineCodeTextFontStyle(): FontStyle | undefined

  /**
   * 获取inlineCodeTextFontWeight
   *
   * @returns inlineCodeTextFontWeight
   */
  getInlineCodeTextFontWeight(): FontWeight | undefined

  /**
   * 获取inlineCodeTextFontFamily
   *
   * @returns inlineCodeTextFontFamily
   */
  getInlineCodeTextFontFamily(): string | undefined

  /**
   * 获取inlineCodeTextLineHeight
   *
   * @returns inlineCodeTextLineHeight
   */
  getInlineCodeTextLineHeight(): number | undefined

  /**
   * 获取inlineCodeTextLetterSpacing
   *
   * @returns inlineCodeTextLetterSpacing
   */
  getInlineCodeTextLetterSpacing(): number | undefined

  /**
   * 获取inlineCodeTextBackgroundColor
   *
   * @returns inlineCodeTextBackgroundColor
   */
  getInlineCodeTextBackgroundColor(): number | undefined

  /**
   * 获取inlineCodeTextBackgroundRadiusTopLeft
   *
   * @returns inlineCodeTextBackgroundRadiusTopLeft
   */
  getInlineCodeTextBackgroundRadiusTopLeft(): number | undefined

  /**
   * 获取inlineCodeTextBackgroundRadiusTopRight
   *
   * @returns inlineCodeTextBackgroundRadiusTopRight
   */
  getInlineCodeTextBackgroundRadiusTopRight(): number | undefined

  /**
   * 获取inlineCodeTextBackgroundRadiusBottomLeft
   *
   * @returns inlineCodeTextBackgroundRadiusBottomLeft
   */
  getInlineCodeTextBackgroundRadiusBottomLeft(): number | undefined

  /**
   * 获取inlineCodeTextBackgroundRadiusBottomRight
   *
   * @returns inlineCodeTextBackgroundRadiusBottomRight
   */
  getInlineCodeTextBackgroundRadiusBottomRight(): number | undefined

}
```

### class MarkdownThemeTable

Markdown用户可设置的样式-表格样式

```ets
export class MarkdownThemeTable {
  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setTableMargin(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 设置4个内边距为统一值
   *
   * @param padding 内边距
   */
  setTableAllPadding(padding: number): void

  /**
   * 分别设置4个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setTablePadding(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 设置表格内容内边距
   *
   * @param padding 内边距
   */
  setTableCellAllPadding(padding: number): void

  /**
   * 设置表格内容内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setTableCellPadding(top?: number, right?: number, bottom?: number, left?: number): void

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
   * 设置表格边框4个圆角为统一值
   *
   * @param radius 圆角半径
   */
  setTableAllRadius(radius: number): void

  /**
   * 分别设置表格边框4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setTableRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

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

  /**
   * 获取tableTitleBackgroundColor
   *
   * @returns tableTitleBackgroundColor
   */
  getTableTitleBackgroundColor(): number | undefined

  /**
   * 获取tableContentOddRowBackgroundColor
   *
   * @returns tableContentOddRowBackgroundColor
   */
  getTableContentOddRowBackgroundColor(): number | undefined

  /**
   * 获取tableContentEvenRowBackgroundColor
   *
   * @returns tableContentEvenRowBackgroundColor
   */
  getTableContentEvenRowBackgroundColor(): number | undefined

  /**
   * 获取tableMarginTop
   *
   * @returns tableMarginTop
   */
  getTableMarginTop(): number | undefined

  /**
   * 获取tableMarginRight
   *
   * @returns tableMarginRight
   */
  getTableMarginRight(): number | undefined

  /**
   * 获取tableMarginBottom
   *
   * @returns tableMarginBottom
   */
  getTableMarginBottom(): number | undefined

  /**
   * 获取tableMarginLeft
   *
   * @returns tableMarginLeft
   */
  getTableMarginLeft(): number | undefined

  /**
   * 获取tablePaddingTop
   *
   * @returns tablePaddingTop
   */
  getTablePaddingTop(): number | undefined

  /**
   * 获取tablePaddingRight
   *
   * @returns tablePaddingRight
   */
  getTablePaddingRight(): number | undefined

  /**
   * 获取tablePaddingBottom
   *
   * @returns tablePaddingBottom
   */
  getTablePaddingBottom(): number | undefined

  /**
   * 获取tablePaddingLeft
   *
   * @returns tablePaddingLeft
   */
  getTablePaddingLeft(): number | undefined

  /**
   * 获取tableCellPaddingTop
   *
   * @returns tableCellPaddingTop
   */
  getTableCellPaddingTop(): number | undefined

  /**
   * 获取tableCellPaddingRight
   *
   * @returns tableCellPaddingRight
   */
  getTableCellPaddingRight(): number | undefined

  /**
   * 获取tableCellPaddingBottom
   *
   * @returns tableCellPaddingBottom
   */
  getTableCellPaddingBottom(): number | undefined

  /**
   * 获取tableCellPaddingLeft
   *
   * @returns tableCellPaddingLeft
   */
  getTableCellPaddingLeft(): number | undefined

  /**
   * 获取tableBorderStyle
   *
   * @returns tableBorderStyle
   */
  getTableBorderStyle(): BorderStyle | undefined

  /**
   * 获取tableBorderWidth
   *
   * @returns tableBorderWidth
   */
  getTableBorderWidth(): number | undefined

  /**
   * 获取tableBorderColor
   *
   * @returns tableBorderColor
   */
  getTableBorderColor(): number | undefined

  /**
   * 获取tableRadiusTopLeft
   *
   * @returns tableRadiusTopLeft
   */
  getTableRadiusTopLeft(): number | undefined

  /**
   * 获取tableRadiusTopRight
   *
   * @returns tableRadiusTopRight
   */
  getTableRadiusTopRight(): number | undefined

  /**
   * 获取tableRadiusBottomLeft
   *
   * @returns tableRadiusBottomLeft
   */
  getTableRadiusBottomLeft(): number | undefined

  /**
   * 获取tableRadiusBottomRight
   *
   * @returns tableRadiusBottomRight
   */
  getTableRadiusBottomRight(): number | undefined

  /**
   * 获取tableScrollBarState
   *
   * @returns tableScrollBarState
   */
  getTableScrollBarState(): BarState | undefined

  /**
   * 获取tableScrollBarColor
   *
   * @returns tableScrollBarColor
   */
  getTableScrollBarColor(): number | undefined

  /**
   * 获取tableMinCellWidth
   *
   * @returns tableMinCellWidth
   */
  getTableMinCellWidth(): number | undefined

  /**
   * 获取tableMaxCellWidth
   *
   * @returns tableMaxCellWidth
   */
  getTableMaxCellWidth(): number | undefined

  /**
   * 获取tableFirstColumnIsBold
   *
   * @returns tableFirstColumnIsBold
   */
  getTableFirstColumnIsBold(): boolean | undefined

  /**
   * 获取tableTitleTextFontColor
   *
   * @returns tableTitleTextFontColor
   */
  getTableTitleTextFontColor(): number | undefined

  /**
   * 获取tableTitleTextFontSize
   *
   * @returns tableTitleTextFontSize
   */
  getTableTitleTextFontSize(): number | undefined

  /**
   * 获取tableTitleTextFontStyle
   *
   * @returns tableTitleTextFontStyle
   */
  getTableTitleTextFontStyle(): FontStyle | undefined

  /**
   * 获取tableTitleTextFontWeight
   *
   * @returns tableTitleTextFontWeight
   */
  getTableTitleTextFontWeight(): FontWeight | undefined

  /**
   * 获取tableTitleTextFontFamily
   *
   * @returns tableTitleTextFontFamily
   */
  getTableTitleTextFontFamily(): string | undefined

  /**
   * 获取tableTitleTextLineHeight
   *
   * @returns tableTitleTextLineHeight
   */
  getTableTitleTextLineHeight(): number | undefined

  /**
   * 获取tableTitleTextLetterSpacing
   *
   * @returns tableTitleTextLetterSpacing
   */
  getTableTitleTextLetterSpacing(): number | undefined

  /**
   * 获取tableContentTextFontColor
   *
   * @returns tableContentTextFontColor
   */
  getTableContentTextFontColor(): number | undefined

  /**
   * 获取tableContentTextFontSize
   *
   * @returns tableContentTextFontSize
   */
  getTableContentTextFontSize(): number | undefined

  /**
   * 获取tableContentTextFontStyle
   *
   * @returns tableContentTextFontStyle
   */
  getTableContentTextFontStyle(): FontStyle | undefined

  /**
   * 获取tableContentTextFontWeight
   *
   * @returns tableContentTextFontWeight
   */
  getTableContentTextFontWeight(): FontWeight | undefined

  /**
   * 获取tableContentTextFontFamily
   *
   * @returns tableContentTextFontFamily
   */
  getTableContentTextFontFamily(): string | undefined

  /**
   * 获取tableContentTextLineHeight
   *
   * @returns tableContentTextLineHeight
   */
  getTableContentTextLineHeight(): number | undefined

  /**
   * 获取tableContentTextLetterSpacing
   *
   * @returns tableContentTextLetterSpacing
   */
  getTableContentTextLetterSpacing(): number | undefined

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
   * 统一设置LaTeX数学公式外边距
   *
   * @param margin 外边距
   */
  setLatexMathAllMargin(margin: number): void

  /**
   * 分别设置LaTeX数学公式四个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setLatexMathMargin(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 统一设置LaTeX数学公式内边距
   *
   * @param padding 内边距
   */
  setLatexMathAllPadding(padding: number): void

  /**
   * 分别设置LaTeX数学公式四个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setLatexMathPadding(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 获取latexMathMarginTop
   *
   * @returns latexMathMarginTop
   */
  getLatexMathMarginTop(): number | undefined

  /**
   * 获取latexMathMarginRight
   *
   * @returns latexMathMarginRight
   */
  getLatexMathMarginRight(): number | undefined

  /**
   * 获取latexMathMarginBottom
   *
   * @returns latexMathMarginBottom
   */
  getLatexMathMarginBottom(): number | undefined

  /**
   * 获取latexMathMarginLeft
   *
   * @returns latexMathMarginLeft
   */
  getLatexMathMarginLeft(): number | undefined

  /**
   * 获取latexMathPaddingTop
   *
   * @returns latexMathPaddingTop
   */
  getLatexMathPaddingTop(): number | undefined

  /**
   * 获取latexMathPaddingRight
   *
   * @returns latexMathPaddingRight
   */
  getLatexMathPaddingRight(): number | undefined

  /**
   * 获取latexMathPaddingBottom
   *
   * @returns latexMathPaddingBottom
   */
  getLatexMathPaddingBottom(): number | undefined

  /**
   * 获取latexMathPaddingLeft
   *
   * @returns latexMathPaddingLeft
   */
  getLatexMathPaddingLeft(): number | undefined

  /**
   * 获取latexMathDefaultText
   *
   * @returns latexMathDefaultText
   */
  getLatexMathDefaultText(): boolean | undefined

  /**
   * 获取latexMathDefaultTextFontColor
   *
   * @returns latexMathDefaultTextFontColor
   */
  getLatexMathDefaultTextFontColor(): number | undefined

  /**
   * 获取latexMathDefaultTextFontSize
   *
   * @returns latexMathDefaultTextFontSize
   */
  getLatexMathDefaultTextFontSize(): number | undefined

  /**
   * 获取latexMathDefaultTextFontStyle
   *
   * @returns latexMathDefaultTextFontStyle
   */
  getLatexMathDefaultTextFontStyle(): FontStyle | undefined

  /**
   * 获取latexMathDefaultTextFontWeight
   *
   * @returns latexMathDefaultTextFontWeight
   */
  getLatexMathDefaultTextFontWeight(): FontWeight | undefined

  /**
   * 获取latexMathDefaultTextFontFamily
   *
   * @returns latexMathDefaultTextFontFamily
   */
  getLatexMathDefaultTextFontFamily(): string | undefined

  /**
   * 获取latexMathTextSize
   *
   * @returns latexMathTextSize
   */
  getLatexMathTextSize(): number | undefined

  /**
   * 获取latexMathBackgroundColor
   *
   * @returns latexMathBackgroundColor
   */
  getLatexMathBackgroundColor(): number | undefined

  /**
   * 获取latexMathTextColor
   *
   * @returns latexMathTextColor
   */
  getLatexMathTextColor(): number | undefined

  /**
   * 获取latexMathColorFormat
   *
   * @returns latexMathColorFormat
   */
  getLatexMathColorFormat(): LatexMathColorFormat | undefined

  /**
   * 获取latexMathBlockCenter
   *
   * @returns latexMathBlockCenter
   */
  getLatexMathBlockCenter(): boolean | undefined

  /**
   * 获取latexMathResPath
   *
   * @returns latexMathResPath
   */
  getLatexMathResPath(): string | undefined

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
   * 统一设置脚注引用文本背景四个圆角
   *
   * @param radius 统一圆角半径，同时赋值给四个角
   */
  setFootnoteRefTextBackgroundAllRadius(radius: number): void

  /**
   * 分别设置4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setFootnoteRefTextBackgroundRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

  /**
   * 获取footnoteRefTextFontColor
   *
   * @returns footnoteRefTextFontColor
   */
  getFootnoteRefTextFontColor(): number | undefined

  /**
   * 获取footnoteRefTextFontSize
   *
   * @returns footnoteRefTextFontSize
   */
  getFootnoteRefTextFontSize(): number | undefined

  /**
   * 获取footnoteRefTextFontStyle
   *
   * @returns footnoteRefTextFontStyle
   */
  getFootnoteRefTextFontStyle(): FontStyle | undefined

  /**
   * 获取footnoteRefTextFontWeight
   *
   * @returns footnoteRefTextFontWeight
   */
  getFootnoteRefTextFontWeight(): FontWeight | undefined

  /**
   * 获取footnoteRefTextFontFamily
   *
   * @returns footnoteRefTextFontFamily
   */
  getFootnoteRefTextFontFamily(): string | undefined

  /**
   * 获取footnoteRefTextLineHeight
   *
   * @returns footnoteRefTextLineHeight
   */
  getFootnoteRefTextLineHeight(): number | undefined

  /**
   * 获取footnoteRefTextLetterSpacing
   *
   * @returns footnoteRefTextLetterSpacing
   */
  getFootnoteRefTextLetterSpacing(): number | undefined

  /**
   * 获取footnoteRefTextDecorationType
   *
   * @returns footnoteRefTextDecorationType
   */
  getFootnoteRefTextDecorationType(): TextDecorationType | undefined

  /**
   * 获取footnoteRefTextDecorationColor
   *
   * @returns footnoteRefTextDecorationColor
   */
  getFootnoteRefTextDecorationColor(): number | undefined

  /**
   * 获取footnoteRefTextDecorationStyle
   *
   * @returns footnoteRefTextDecorationStyle
   */
  getFootnoteRefTextDecorationStyle(): MarkdownTextDecorationStyle | undefined

  /**
   * 获取footnoteRefTextBackgroundColor
   *
   * @returns footnoteRefTextBackgroundColor
   */
  getFootnoteRefTextBackgroundColor(): number | undefined

  /**
   * 获取footnoteRefTextBackgroundRadiusTopLeft
   *
   * @returns footnoteRefTextBackgroundRadiusTopLeft
   */
  getFootnoteRefTextBackgroundRadiusTopLeft(): number | undefined

  /**
   * 获取footnoteRefTextBackgroundRadiusTopRight
   *
   * @returns footnoteRefTextBackgroundRadiusTopRight
   */
  getFootnoteRefTextBackgroundRadiusTopRight(): number | undefined

  /**
   * 获取footnoteRefTextBackgroundRadiusBottomLeft
   *
   * @returns footnoteRefTextBackgroundRadiusBottomLeft
   */
  getFootnoteRefTextBackgroundRadiusBottomLeft(): number | undefined

  /**
   * 获取footnoteRefTextBackgroundRadiusBottomRight
   *
   * @returns footnoteRefTextBackgroundRadiusBottomRight
   */
  getFootnoteRefTextBackgroundRadiusBottomRight(): number | undefined

}
```

### class MarkdownThemeFootnoteDef

Markdown用户可设置的样式-脚注定义样式

```ets
export class MarkdownThemeFootnoteDef {
  /**
   * 设置4个外边距为统一值
   *
   * @param margin 外边距
   */
  setFootnoteDefAllMargin(margin: number): void

  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setFootnoteDefMargin(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 设置4个内边距为统一值
   *
   * @param padding 内边距
   */
  setFootnoteDefAllPadding(padding: number): void

  /**
   * 分别设置4个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setFootnoteDefPadding(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 获取footnoteDefBackgroundColor
   *
   * @returns footnoteDefBackgroundColor
   */
  getFootnoteDefBackgroundColor(): number | undefined

  /**
   * 获取footnoteDefMarginTop
   *
   * @returns footnoteDefMarginTop
   */
  getFootnoteDefMarginTop(): number | undefined

  /**
   * 获取footnoteDefMarginRight
   *
   * @returns footnoteDefMarginRight
   */
  getFootnoteDefMarginRight(): number | undefined

  /**
   * 获取footnoteDefMarginBottom
   *
   * @returns footnoteDefMarginBottom
   */
  getFootnoteDefMarginBottom(): number | undefined

  /**
   * 获取footnoteDefMarginLeft
   *
   * @returns footnoteDefMarginLeft
   */
  getFootnoteDefMarginLeft(): number | undefined

  /**
   * 获取footnoteDefPaddingTop
   *
   * @returns footnoteDefPaddingTop
   */
  getFootnoteDefPaddingTop(): number | undefined

  /**
   * 获取footnoteDefPaddingRight
   *
   * @returns footnoteDefPaddingRight
   */
  getFootnoteDefPaddingRight(): number | undefined

  /**
   * 获取footnoteDefPaddingBottom
   *
   * @returns footnoteDefPaddingBottom
   */
  getFootnoteDefPaddingBottom(): number | undefined

  /**
   * 获取footnoteDefPaddingLeft
   *
   * @returns footnoteDefPaddingLeft
   */
  getFootnoteDefPaddingLeft(): number | undefined

}
```

### class MarkdownThemeDefinitionList

Markdown用户可设置的样式-定义列表样式

```ets
export class MarkdownThemeDefinitionList {
  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setDefinitionListMargin(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 设置4个内边距为统一值
   *
   * @param padding 内边距
   */
  setDefinitionListAllPadding(padding: number): void

  /**
   * 分别设置4个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setDefinitionListPadding(top?: number, right?: number, bottom?: number, left?: number): void

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

  /**
   * 获取definitionListBackgroundColor
   *
   * @returns definitionListBackgroundColor
   */
  getDefinitionListBackgroundColor(): number | undefined

  /**
   * 获取definitionListMarginTop
   *
   * @returns definitionListMarginTop
   */
  getDefinitionListMarginTop(): number | undefined

  /**
   * 获取definitionListMarginRight
   *
   * @returns definitionListMarginRight
   */
  getDefinitionListMarginRight(): number | undefined

  /**
   * 获取definitionListMarginBottom
   *
   * @returns definitionListMarginBottom
   */
  getDefinitionListMarginBottom(): number | undefined

  /**
   * 获取definitionListMarginLeft
   *
   * @returns definitionListMarginLeft
   */
  getDefinitionListMarginLeft(): number | undefined

  /**
   * 获取definitionListPaddingTop
   *
   * @returns definitionListPaddingTop
   */
  getDefinitionListPaddingTop(): number | undefined

  /**
   * 获取definitionListPaddingRight
   *
   * @returns definitionListPaddingRight
   */
  getDefinitionListPaddingRight(): number | undefined

  /**
   * 获取definitionListPaddingBottom
   *
   * @returns definitionListPaddingBottom
   */
  getDefinitionListPaddingBottom(): number | undefined

  /**
   * 获取definitionListPaddingLeft
   *
   * @returns definitionListPaddingLeft
   */
  getDefinitionListPaddingLeft(): number | undefined

  /**
   * 获取definitionListTermToDescriptionSpacing
   *
   * @returns definitionListTermToDescriptionSpacing
   */
  getDefinitionListTermToDescriptionSpacing(): number | undefined

  /**
   * 获取definitionListTermTextFontWeight
   *
   * @returns definitionListTermTextFontWeight
   */
  getDefinitionListTermTextFontWeight(): FontWeight | undefined

  /**
   * 获取definitionListTermTextFontStyle
   *
   * @returns definitionListTermTextFontStyle
   */
  getDefinitionListTermTextFontStyle(): FontStyle | undefined

  /**
   * 获取definitionListDescriptionItemSpacing
   *
   * @returns definitionListDescriptionItemSpacing
   */
  getDefinitionListDescriptionItemSpacing(): number | undefined

  /**
   * 获取definitionListDescriptionIndent
   *
   * @returns definitionListDescriptionIndent
   */
  getDefinitionListDescriptionIndent(): number | undefined

}
```

### class MarkdownThemeOrderedList

Markdown用户可设置的样式-有序列表样式

```ets
export class MarkdownThemeOrderedList {
  /**
   * 设置4个外边距为统一值
   *
   * @param margin 外边距
   */
  setOrderedListAllMargin(margin: number): void

  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setOrderedListMargin(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 设置4个内边距为统一值
   *
   * @param padding 内边距
   */
  setOrderedListAllPadding(padding: number): void

  /**
   * 分别设置4个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setOrderedListPadding(top?: number, right?: number, bottom?: number, left?: number): void

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

  /**
   * 获取orderedListBackgroundColor
   *
   * @returns orderedListBackgroundColor
   */
  getOrderedListBackgroundColor(): number | undefined

  /**
   * 获取orderedListMarginTop
   *
   * @returns orderedListMarginTop
   */
  getOrderedListMarginTop(): number | undefined

  /**
   * 获取orderedListMarginRight
   *
   * @returns orderedListMarginRight
   */
  getOrderedListMarginRight(): number | undefined

  /**
   * 获取orderedListMarginBottom
   *
   * @returns orderedListMarginBottom
   */
  getOrderedListMarginBottom(): number | undefined

  /**
   * 获取orderedListMarginLeft
   *
   * @returns orderedListMarginLeft
   */
  getOrderedListMarginLeft(): number | undefined

  /**
   * 获取orderedListPaddingTop
   *
   * @returns orderedListPaddingTop
   */
  getOrderedListPaddingTop(): number | undefined

  /**
   * 获取orderedListPaddingRight
   *
   * @returns orderedListPaddingRight
   */
  getOrderedListPaddingRight(): number | undefined

  /**
   * 获取orderedListPaddingBottom
   *
   * @returns orderedListPaddingBottom
   */
  getOrderedListPaddingBottom(): number | undefined

  /**
   * 获取orderedListPaddingLeft
   *
   * @returns orderedListPaddingLeft
   */
  getOrderedListPaddingLeft(): number | undefined

  /**
   * 获取orderedListChildSpacing
   *
   * @returns orderedListChildSpacing
   */
  getOrderedListChildSpacing(): number | undefined

  /**
   * 获取orderedListChildChildSpacing
   *
   * @returns orderedListChildChildSpacing
   */
  getOrderedListChildChildSpacing(): number | undefined

  /**
   * 获取orderedListMarkerSpacing
   *
   * @returns orderedListMarkerSpacing
   */
  getOrderedListMarkerSpacing(): number | undefined

  /**
   * 获取orderedListMarkerTextFontColor
   *
   * @returns orderedListMarkerTextFontColor
   */
  getOrderedListMarkerTextFontColor(): number | undefined

  /**
   * 获取orderedListMarkerTextFontSize
   *
   * @returns orderedListMarkerTextFontSize
   */
  getOrderedListMarkerTextFontSize(): number | undefined

  /**
   * 获取orderedListMarkerTextFontStyle
   *
   * @returns orderedListMarkerTextFontStyle
   */
  getOrderedListMarkerTextFontStyle(): FontStyle | undefined

  /**
   * 获取orderedListMarkerTextFontWeight
   *
   * @returns orderedListMarkerTextFontWeight
   */
  getOrderedListMarkerTextFontWeight(): FontWeight | undefined

  /**
   * 获取orderedListMarkerTextFontFamily
   *
   * @returns orderedListMarkerTextFontFamily
   */
  getOrderedListMarkerTextFontFamily(): string | undefined

  /**
   * 获取orderedListMarkerTextLineHeight
   *
   * @returns orderedListMarkerTextLineHeight
   */
  getOrderedListMarkerTextLineHeight(): number | undefined

}
```

### class MarkdownThemeBulletList

Markdown用户可设置的样式-无序/任务列表样式

```ets
export class MarkdownThemeBulletList {
  /**
   * 统一设置无序/任务外边距
   *
   * @param margin 外边距
   */
  setBulletListAllMargin(margin: number): void

  /**
   * 分别设置无序/任务四个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setBulletListMargin(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 统一设置无序/任务内边距
   *
   * @param padding 内边距
   */
  setBulletListAllPadding(padding: number): void

  /**
   * 分别设置无序/任务四个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setBulletListPadding(top?: number, right?: number, bottom?: number, left?: number): void

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

  /**
   * 获取bulletListBackgroundColor
   *
   * @returns bulletListBackgroundColor
   */
  getBulletListBackgroundColor(): number | undefined

  /**
   * 获取bulletListMarginTop
   *
   * @returns bulletListMarginTop
   */
  getBulletListMarginTop(): number | undefined

  /**
   * 获取bulletListMarginRight
   *
   * @returns bulletListMarginRight
   */
  getBulletListMarginRight(): number | undefined

  /**
   * 获取bulletListMarginBottom
   *
   * @returns bulletListMarginBottom
   */
  getBulletListMarginBottom(): number | undefined

  /**
   * 获取bulletListMarginLeft
   *
   * @returns bulletListMarginLeft
   */
  getBulletListMarginLeft(): number | undefined

  /**
   * 获取bulletListPaddingTop
   *
   * @returns bulletListPaddingTop
   */
  getBulletListPaddingTop(): number | undefined

  /**
   * 获取bulletListPaddingRight
   *
   * @returns bulletListPaddingRight
   */
  getBulletListPaddingRight(): number | undefined

  /**
   * 获取bulletListPaddingBottom
   *
   * @returns bulletListPaddingBottom
   */
  getBulletListPaddingBottom(): number | undefined

  /**
   * 获取bulletListPaddingLeft
   *
   * @returns bulletListPaddingLeft
   */
  getBulletListPaddingLeft(): number | undefined

  /**
   * 获取bulletListChildSpacing
   *
   * @returns bulletListChildSpacing
   */
  getBulletListChildSpacing(): number | undefined

  /**
   * 获取bulletListChildChildSpacing
   *
   * @returns bulletListChildChildSpacing
   */
  getBulletListChildChildSpacing(): number | undefined

  /**
   * 获取bulletListBulletSpacing
   *
   * @returns bulletListBulletSpacing
   */
  getBulletListBulletSpacing(): number | undefined

  /**
   * 获取bulletListBulletIsCircle
   *
   * @returns bulletListBulletIsCircle
   */
  getBulletListBulletIsCircle(): boolean | undefined

  /**
   * 获取bulletListBulletTextFontColor
   *
   * @returns bulletListBulletTextFontColor
   */
  getBulletListBulletTextFontColor(): number | undefined

  /**
   * 获取bulletListBulletTextFontSize
   *
   * @returns bulletListBulletTextFontSize
   */
  getBulletListBulletTextFontSize(): number | undefined

  /**
   * 获取bulletListBulletTextFontStyle
   *
   * @returns bulletListBulletTextFontStyle
   */
  getBulletListBulletTextFontStyle(): FontStyle | undefined

  /**
   * 获取bulletListBulletTextFontWeight
   *
   * @returns bulletListBulletTextFontWeight
   */
  getBulletListBulletTextFontWeight(): FontWeight | undefined

  /**
   * 获取bulletListBulletTextFontFamily
   *
   * @returns bulletListBulletTextFontFamily
   */
  getBulletListBulletTextFontFamily(): string | undefined

  /**
   * 获取bulletListBulletTextLineHeight
   *
   * @returns bulletListBulletTextLineHeight
   */
  getBulletListBulletTextLineHeight(): number | undefined

  /**
   * 获取bulletListCheckboxSpacing
   *
   * @returns bulletListCheckboxSpacing
   */
  getBulletListCheckboxSpacing(): number | undefined

  /**
   * 获取bulletListCheckboxWidth
   *
   * @returns bulletListCheckboxWidth
   */
  getBulletListCheckboxWidth(): number | undefined

  /**
   * 获取bulletListCheckboxHeight
   *
   * @returns bulletListCheckboxHeight
   */
  getBulletListCheckboxHeight(): number | undefined

  /**
   * 获取bulletListCheckboxSelectedColor
   *
   * @returns bulletListCheckboxSelectedColor
   */
  getBulletListCheckboxSelectedColor(): number | undefined

  /**
   * 获取bulletListCheckboxShape
   *
   * @returns bulletListCheckboxShape
   */
  getBulletListCheckboxShape(): CheckBoxShape | undefined

}
```

### class MarkdownThemeImage

Markdown用户可设置的样式-图片样式

```ets
export class MarkdownThemeImage {
  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setImageMargin(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 设置4个圆角为统一值
   *
   * @param radius 圆角
   */
  setImageBorderAllRadius(radius: number): void

  /**
   * 分别设置4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setImageBorderRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

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
   * 设置图片下载按钮4个圆角为统一值
   *
   * @param radius 圆角
   */
  setImageDownloadButtonAllRadius(radius: number): void

  /**
   * 分别设置图片下载按钮4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setImageDownloadButtonRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

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

  /**
   * 获取imageMarginTop
   *
   * @returns imageMarginTop
   */
  getImageMarginTop(): number | undefined

  /**
   * 获取imageMarginRight
   *
   * @returns imageMarginRight
   */
  getImageMarginRight(): number | undefined

  /**
   * 获取imageMarginBottom
   *
   * @returns imageMarginBottom
   */
  getImageMarginBottom(): number | undefined

  /**
   * 获取imageMarginLeft
   *
   * @returns imageMarginLeft
   */
  getImageMarginLeft(): number | undefined

  /**
   * 获取imageRadiusTopLeft
   *
   * @returns imageRadiusTopLeft
   */
  getImageRadiusTopLeft(): number | undefined

  /**
   * 获取imageRadiusTopRight
   *
   * @returns imageRadiusTopRight
   */
  getImageRadiusTopRight(): number | undefined

  /**
   * 获取imageRadiusBottomLeft
   *
   * @returns imageRadiusBottomLeft
   */
  getImageRadiusBottomLeft(): number | undefined

  /**
   * 获取imageRadiusBottomRight
   *
   * @returns imageRadiusBottomRight
   */
  getImageRadiusBottomRight(): number | undefined

  /**
   * 获取imageBorderStyle
   *
   * @returns imageBorderStyle
   */
  getImageBorderStyle(): BorderStyle | undefined

  /**
   * 获取imageBorderWidth
   *
   * @returns imageBorderWidth
   */
  getImageBorderWidth(): number | undefined

  /**
   * 获取imageBorderColor
   *
   * @returns imageBorderColor
   */
  getImageBorderColor(): number | undefined

  /**
   * 获取imagePlaceholder
   *
   * @returns imagePlaceholder
   */
  getImagePlaceholder(): Resource | undefined

  /**
   * 获取imageAutoResize
   *
   * @returns imageAutoResize
   */
  getImageAutoResize(): boolean | undefined

  /**
   * 获取isImageMixedLayout
   *
   * @returns isImageMixedLayout
   */
  getIsImageMixedLayout(): boolean | undefined

  /**
   * 获取imageMaximumWidth
   *
   * @returns imageMaximumWidth
   */
  getImageMaximumWidth(): number | undefined

  /**
   * 获取imageFixedRatioWidth
   *
   * @returns imageFixedRatioWidth
   */
  getImageFixedRatioWidth(): number | undefined

  /**
   * 获取imageMaxHeight
   *
   * @returns imageMaxHeight
   */
  getImageMaxHeight(): number | undefined

  /**
   * 获取imageHeight
   *
   * @returns imageHeight
   */
  getImageHeight(): number | undefined

  /**
   * 获取imageMaxWidth
   *
   * @returns imageMaxWidth
   */
  getImageMaxWidth(): number | undefined

  /**
   * 获取imageWidth
   *
   * @returns imageWidth
   */
  getImageWidth(): number | undefined

  /**
   * 获取imageFitType
   *
   * @returns imageFitType
   */
  getImageFitType(): ImageFitType | undefined

  /**
   * 获取imageBottomLayoutMarginTop
   *
   * @returns imageBottomLayoutMarginTop
   */
  getImageBottomLayoutMarginTop(): number | undefined

  /**
   * 获取imageDownloadButtonVisible
   *
   * @returns imageDownloadButtonVisible
   */
  getImageDownloadButtonVisible(): boolean | undefined

  /**
   * 获取imageDownloadButtonWidth
   *
   * @returns imageDownloadButtonWidth
   */
  getImageDownloadButtonWidth(): number | undefined

  /**
   * 获取imageDownloadButtonHeight
   *
   * @returns imageDownloadButtonHeight
   */
  getImageDownloadButtonHeight(): number | undefined

  /**
   * 获取imageDownloadButtonRadiusTopLeft
   *
   * @returns imageDownloadButtonRadiusTopLeft
   */
  getImageDownloadButtonRadiusTopLeft(): number | undefined

  /**
   * 获取imageDownloadButtonRadiusTopRight
   *
   * @returns imageDownloadButtonRadiusTopRight
   */
  getImageDownloadButtonRadiusTopRight(): number | undefined

  /**
   * 获取imageDownloadButtonRadiusBottomLeft
   *
   * @returns imageDownloadButtonRadiusBottomLeft
   */
  getImageDownloadButtonRadiusBottomLeft(): number | undefined

  /**
   * 获取imageDownloadButtonRadiusBottomRight
   *
   * @returns imageDownloadButtonRadiusBottomRight
   */
  getImageDownloadButtonRadiusBottomRight(): number | undefined

  /**
   * 获取imageDownloadButtonIcon
   *
   * @returns imageDownloadButtonIcon
   */
  getImageDownloadButtonIcon(): Resource | undefined

  /**
   * 获取imageDownloadButtonIconWidth
   *
   * @returns imageDownloadButtonIconWidth
   */
  getImageDownloadButtonIconWidth(): number | undefined

  /**
   * 获取imageDownloadButtonIconHeight
   *
   * @returns imageDownloadButtonIconHeight
   */
  getImageDownloadButtonIconHeight(): number | undefined

  /**
   * 获取imageDownloadButtonIconTextGap
   *
   * @returns imageDownloadButtonIconTextGap
   */
  getImageDownloadButtonIconTextGap(): number | undefined

  /**
   * 获取imageDownloadButtonBackgroundColor
   *
   * @returns imageDownloadButtonBackgroundColor
   */
  getImageDownloadButtonBackgroundColor(): number | undefined

  /**
   * 获取imageDownloadButtonText
   *
   * @returns imageDownloadButtonText
   */
  getImageDownloadButtonText(): string | undefined

  /**
   * 获取imageDownloadButtonTextFontColor
   *
   * @returns imageDownloadButtonTextFontColor
   */
  getImageDownloadButtonTextFontColor(): number | undefined

  /**
   * 获取imageDownloadButtonTextFontSize
   *
   * @returns imageDownloadButtonTextFontSize
   */
  getImageDownloadButtonTextFontSize(): number | undefined

  /**
   * 获取imageDownloadButtonTextFontStyle
   *
   * @returns imageDownloadButtonTextFontStyle
   */
  getImageDownloadButtonTextFontStyle(): FontStyle | undefined

  /**
   * 获取imageDownloadButtonTextFontWeight
   *
   * @returns imageDownloadButtonTextFontWeight
   */
  getImageDownloadButtonTextFontWeight(): FontWeight | undefined

  /**
   * 获取imageDownloadButtonTextFontFamily
   *
   * @returns imageDownloadButtonTextFontFamily
   */
  getImageDownloadButtonTextFontFamily(): string | undefined

  /**
   * 获取imageDownloadButtonTextLineHeight
   *
   * @returns imageDownloadButtonTextLineHeight
   */
  getImageDownloadButtonTextLineHeight(): number | undefined

}
```

### class MarkdownThemeAudio

Markdown用户可设置的样式-音频样式

```ets
export class MarkdownThemeAudio {
  /**
   * 音频整体外边距
   *
   * @param margin 外边距
   */
  setAudioAllMargin(margin: number): void

  /**
   * 音频分别设置四个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setAudioMargin(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 音频整体内边距
   *
   * @param padding 内边距
   */
  setAudioAllPadding(padding: number): void

  /**
   * 音频分别设置四个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setAudioPadding(top?: number, right?: number, bottom?: number, left?: number): void

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
   * 音频整体圆角
   *
   * @param radius 圆角
   */
  setAudioBorderAllRadius(radius: number): void

  /**
   * 音频分别设置四个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setAudioBorderRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

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
   * 音频图标整体圆角
   *
   * @param radius 圆角
   */
  setAudioIconAllRadius(radius: number): void

  /**
   * 音频图标分别设置四个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setAudioIconRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

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
   * 音频按钮整体圆角
   *
   * @param radius 圆角
   */
  setAudioButtonAllRadius(radius: number): void

  /**
   * 音频按钮分别设置四个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setAudioButtonRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

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

  /**
   * 获取音频背景颜色
   *
   * @returns 音频背景颜色
   */
  getAudioBackgroundColor(): number | undefined

  /**
   * 获取音频上外边距
   *
   * @returns 音频上外边距
   */
  getAudioMarginTop(): number | undefined

  /**
   * 获取音频右外边距
   *
   * @returns 音频右外边距
   */
  getAudioMarginRight(): number | undefined

  /**
   * 获取音频下外边距
   *
   * @returns 音频下外边距
   */
  getAudioMarginBottom(): number | undefined

  /**
   * 获取音频左外边距
   *
   * @returns 音频左外边距
   */
  getAudioMarginLeft(): number | undefined

  /**
   * 获取音频上内边距
   *
   * @returns 音频上内边距
   */
  getAudioPaddingTop(): number | undefined

  /**
   * 获取音频右内边距
   *
   * @returns 音频右内边距
   */
  getAudioPaddingRight(): number | undefined

  /**
   * 获取音频下内边距
   *
   * @returns 音频下内边距
   */
  getAudioPaddingBottom(): number | undefined

  /**
   * 获取音频左内边距
   *
   * @returns 音频左内边距
   */
  getAudioPaddingLeft(): number | undefined

  /**
   * 获取音频边框样式
   *
   * @returns 音频边框样式
   */
  getAudioBorderStyle(): BorderStyle | undefined

  /**
   * 获取音频边框宽度
   *
   * @returns 音频边框宽度
   */
  getAudioBorderWidth(): number | undefined

  /**
   * 获取音频边框颜色
   *
   * @returns 音频边框颜色
   */
  getAudioBorderColor(): number | undefined

  /**
   * 获取音频边框左上圆角
   *
   * @returns 音频边框左上圆角
   */
  getAudioRadiusTopLeft(): number | undefined

  /**
   * 获取音频边框右上圆角
   *
   * @returns 音频边框右上圆角
   */
  getAudioRadiusTopRight(): number | undefined

  /**
   * 获取音频边框左下圆角
   *
   * @returns 音频边框左下圆角
   */
  getAudioRadiusBottomLeft(): number | undefined

  /**
   * 获取音频边框右下圆角
   *
   * @returns 音频边框右下圆角
   */
  getAudioRadiusBottomRight(): number | undefined

  /**
   * 获取音频阴影模糊半径
   *
   * @returns 音频阴影模糊半径
   */
  getAudioShadowRadius(): number | undefined

  /**
   * 获取音频阴影X轴偏移量
   *
   * @returns 音频阴影X轴偏移量
   */
  getAudioShadowOffsetX(): number | undefined

  /**
   * 获取音频阴影Y轴偏移量
   *
   * @returns 音频阴影Y轴偏移量
   */
  getAudioShadowOffsetY(): number | undefined

  /**
   * 获取音频图标
   *
   * @returns 音频图标
   */
  getAudioIcon(): Resource | undefined

  /**
   * 获取音频图标宽度
   *
   * @returns 音频图标宽度
   */
  getAudioIconWidth(): number | undefined

  /**
   * 获取音频图标高度
   *
   * @returns 音频图标高度
   */
  getAudioIconHeight(): number | undefined

  /**
   * 获取音频图标左上圆角
   *
   * @returns 音频图标左上圆角
   */
  getAudioIconRadiusTopLeft(): number | undefined

  /**
   * 获取音频图标右上圆角
   *
   * @returns 音频图标右上圆角
   */
  getAudioIconRadiusTopRight(): number | undefined

  /**
   * 获取音频图标左下圆角
   *
   * @returns 音频图标左下圆角
   */
  getAudioIconRadiusBottomLeft(): number | undefined

  /**
   * 获取音频图标右下圆角
   *
   * @returns 音频图标右下圆角
   */
  getAudioIconRadiusBottomRight(): number | undefined

  /**
   * 获取音频图标缩放类型
   *
   * @returns 音频图标缩放类型
   */
  getAudioIconFitType(): ImageFit | undefined

  /**
   * 获取音频标题文本和类型文本间距
   *
   * @returns 音频标题文本和类型文本间距
   */
  getAudioTitleToTypeSpacing(): number | undefined

  /**
   * 获取音频阴影颜色值
   *
   * @returns 音频阴影颜色值
   */
  getAudioShadowColor(): number | undefined

  /**
   * 获取音频按钮宽度
   *
   * @returns 音频按钮宽度
   */
  getAudioButtonWidth(): number | undefined

  /**
   * 获取音频按钮高度
   *
   * @returns 音频按钮高度
   */
  getAudioButtonHeight(): number | undefined

  /**
   * 获取音频按钮背景颜色
   *
   * @returns 音频按钮背景颜色
   */
  getAudioButtonBackgroundColor(): number | undefined

  /**
   * 获取音频按钮边框样式
   *
   * @returns 音频按钮边框样式
   */
  getAudioButtonBorderStyle(): BorderStyle | undefined

  /**
   * 获取音频按钮边框宽度
   *
   * @returns 音频按钮边框宽度
   */
  getAudioButtonBorderWidth(): number | undefined

  /**
   * 获取音频按钮边框颜色
   *
   * @returns 音频按钮边框颜色
   */
  getAudioButtonBorderColor(): number | undefined

  /**
   * 获取音频按钮边框左上圆角
   *
   * @returns 音频按钮边框左上圆角
   */
  getAudioButtonRadiusTopLeft(): number | undefined

  /**
   * 获取音频按钮边框右上圆角
   *
   * @returns 音频按钮边框右上圆角
   */
  getAudioButtonRadiusTopRight(): number | undefined

  /**
   * 获取音频按钮边框左下圆角
   *
   * @returns 音频按钮边框左下圆角
   */
  getAudioButtonRadiusBottomLeft(): number | undefined

  /**
   * 获取音频按钮边框右下圆角
   *
   * @returns 音频按钮边框右下圆角
   */
  getAudioButtonRadiusBottomRight(): number | undefined

  /**
   * 获取音频按钮默认文本内容
   *
   * @returns 音频按钮默认文本内容
   */
  getAudioButtonText(): string | undefined

  /**
   * 获取音频按钮文本颜色
   *
   * @returns 音频按钮文本颜色
   */
  getAudioButtonTextFontColor(): number | undefined

  /**
   * 获取音频按钮文本尺寸
   *
   * @returns 音频按钮文本尺寸
   */
  getAudioButtonTextFontSize(): number | undefined

  /**
   * 获取音频按钮文本字体样式
   *
   * @returns 音频按钮文本字体样式
   */
  getAudioButtonTextFontStyle(): FontStyle | undefined

  /**
   * 获取音频按钮文本字体粗细
   *
   * @returns 音频按钮文本字体粗细
   */
  getAudioButtonTextFontWeight(): FontWeight | undefined

  /**
   * 获取音频按钮文本字体
   *
   * @returns 音频按钮文本字体
   */
  getAudioButtonTextFontFamily(): string | undefined

  /**
   * 获取音频按钮文本行高
   *
   * @returns 音频按钮文本行高
   */
  getAudioButtonTextLineHeight(): number | undefined

  /**
   * 获取音频标题文本颜色
   *
   * @returns 音频标题文本颜色
   */
  getAudioTitleTextFontColor(): number | undefined

  /**
   * 获取音频标题文本尺寸
   *
   * @returns 音频标题文本尺寸
   */
  getAudioTitleTextFontSize(): number | undefined

  /**
   * 获取音频标题文本字体样式
   *
   * @returns 音频标题文本字体样式
   */
  getAudioTitleTextFontStyle(): FontStyle | undefined

  /**
   * 获取音频标题文本字体粗细
   *
   * @returns 音频标题文本字体粗细
   */
  getAudioTitleTextFontWeight(): FontWeight | undefined

  /**
   * 获取音频标题文本字体
   *
   * @returns 音频标题文本字体
   */
  getAudioTitleTextFontFamily(): string | undefined

  /**
   * 获取音频标题文本行高
   *
   * @returns 音频标题文本行高
   */
  getAudioTitleTextLineHeight(): number | undefined

  /**
   * 获取音频类型文本颜色
   *
   * @returns 音频类型文本颜色
   */
  getAudioTypeTextFontColor(): number | undefined

  /**
   * 获取音频类型文本尺寸
   *
   * @returns 音频类型文本尺寸
   */
  getAudioTypeTextFontSize(): number | undefined

  /**
   * 获取音频类型文本字体样式
   *
   * @returns 音频类型文本字体样式
   */
  getAudioTypeTextFontStyle(): FontStyle | undefined

  /**
   * 获取音频类型文本字体粗细
   *
   * @returns 音频类型文本字体粗细
   */
  getAudioTypeTextFontWeight(): FontWeight | undefined

  /**
   * 获取音频类型文本字体
   *
   * @returns 音频类型文本字体
   */
  getAudioTypeTextFontFamily(): string | undefined

  /**
   * 获取音频类型文本行高
   *
   * @returns 音频类型文本行高
   */
  getAudioTypeTextLineHeight(): number | undefined

}
```

### class MarkdownThemeVideo

Markdown用户可设置的样式-视频样式

```ets
export class MarkdownThemeVideo {
  /**
   * 设置4个外边距为统一值
   *
   * @param margin 外边距
   */
  setVideoAllMargin(margin: number): void

  /**
   * 分别设置4个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setVideoMargin(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 设置4个内边距为统一值
   *
   * @param padding 内边距
   */
  setVideoAllPadding(padding: number): void

  /**
   * 分别设置4个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setVideoPadding(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 统一设置视频背景四个圆角
   *
   * @param radius 统一圆角半径，同时赋值给四个角
   */
  setVideoBorderAllRadius(radius: number): void

  /**
   * 分别设置4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setVideoBorderRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

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
   * 统一设置视频发布按钮四个圆角
   *
   * @param radius 统一圆角半径，同时赋值给四个角
   */
  setVideoReleaseButtonAllRadius(radius: number): void

  /**
   * 分别设置视频发布按钮4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setVideoReleaseButtonRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

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
   * 统一设置视频下载按钮四个圆角
   *
   * @param radius 统一圆角半径，同时赋值给四个角
   */
  setVideoDownloadButtonAllRadius(radius: number): void

  /**
   * 分别设置视频下载按钮4个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setVideoDownloadButtonRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

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

  /**
   * 获取videoBackgroundColor
   *
   * @returns videoBackgroundColor
   */
  getVideoBackgroundColor(): number | undefined

  /**
   * 获取videoMarginTop
   *
   * @returns videoMarginTop
   */
  getVideoMarginTop(): number | undefined

  /**
   * 获取videoMarginRight
   *
   * @returns videoMarginRight
   */
  getVideoMarginRight(): number | undefined

  /**
   * 获取videoMarginBottom
   *
   * @returns videoMarginBottom
   */
  getVideoMarginBottom(): number | undefined

  /**
   * 获取videoMarginLeft
   *
   * @returns videoMarginLeft
   */
  getVideoMarginLeft(): number | undefined

  /**
   * 获取videoPaddingTop
   *
   * @returns videoPaddingTop
   */
  getVideoPaddingTop(): number | undefined

  /**
   * 获取videoPaddingRight
   *
   * @returns videoPaddingRight
   */
  getVideoPaddingRight(): number | undefined

  /**
   * 获取videoPaddingBottom
   *
   * @returns videoPaddingBottom
   */
  getVideoPaddingBottom(): number | undefined

  /**
   * 获取videoPaddingLeft
   *
   * @returns videoPaddingLeft
   */
  getVideoPaddingLeft(): number | undefined

  /**
   * 获取videoRadiusTopLeft
   *
   * @returns videoRadiusTopLeft
   */
  getVideoRadiusTopLeft(): number | undefined

  /**
   * 获取videoRadiusTopRight
   *
   * @returns videoRadiusTopRight
   */
  getVideoRadiusTopRight(): number | undefined

  /**
   * 获取videoRadiusBottomLeft
   *
   * @returns videoRadiusBottomLeft
   */
  getVideoRadiusBottomLeft(): number | undefined

  /**
   * 获取videoRadiusBottomRight
   *
   * @returns videoRadiusBottomRight
   */
  getVideoRadiusBottomRight(): number | undefined

  /**
   * 获取videoBorderStyle
   *
   * @returns videoBorderStyle
   */
  getVideoBorderStyle(): BorderStyle | undefined

  /**
   * 获取videoBorderWidth
   *
   * @returns videoBorderWidth
   */
  getVideoBorderWidth(): number | undefined

  /**
   * 获取videoBorderColor
   *
   * @returns videoBorderColor
   */
  getVideoBorderColor(): number | undefined

  /**
   * 获取videoPlaceholder
   *
   * @returns videoPlaceholder
   */
  getVideoPlaceholder(): Resource | undefined

  /**
   * 获取videoImageFitType
   *
   * @returns videoImageFitType
   */
  getVideoImageFitType(): ImageFit | undefined

  /**
   * 获取videoPlayIcon
   *
   * @returns videoPlayIcon
   */
  getVideoPlayIcon(): Resource | undefined

  /**
   * 获取videoPlayIconWidth
   *
   * @returns videoPlayIconWidth
   */
  getVideoPlayIconWidth(): number | undefined

  /**
   * 获取videoPlayIconHeight
   *
   * @returns videoPlayIconHeight
   */
  getVideoPlayIconHeight(): number | undefined

  /**
   * 获取videoPlayIconFitType
   *
   * @returns videoPlayIconFitType
   */
  getVideoPlayIconFitType(): ImageFit | undefined

  /**
   * 获取videoTimeTextFontColor
   *
   * @returns videoTimeTextFontColor
   */
  getVideoTimeTextFontColor(): number | undefined

  /**
   * 获取videoTimeTextFontSize
   *
   * @returns videoTimeTextFontSize
   */
  getVideoTimeTextFontSize(): number | undefined

  /**
   * 获取videoTimeTextFontStyle
   *
   * @returns videoTimeTextFontStyle
   */
  getVideoTimeTextFontStyle(): FontStyle | undefined

  /**
   * 获取videoTimeTextFontWeight
   *
   * @returns videoTimeTextFontWeight
   */
  getVideoTimeTextFontWeight(): FontWeight | undefined

  /**
   * 获取videoTimeTextFontFamily
   *
   * @returns videoTimeTextFontFamily
   */
  getVideoTimeTextFontFamily(): string | undefined

  /**
   * 获取videoTimeTextLineHeight
   *
   * @returns videoTimeTextLineHeight
   */
  getVideoTimeTextLineHeight(): number | undefined

  /**
   * 获取videoTimeTextMarginRight
   *
   * @returns videoTimeTextMarginRight
   */
  getVideoTimeTextMarginRight(): number | undefined

  /**
   * 获取videoTimeTextMarginBottom
   *
   * @returns videoTimeTextMarginBottom
   */
  getVideoTimeTextMarginBottom(): number | undefined

  /**
   * 获取videoBottomLayoutVisible
   *
   * @returns videoBottomLayoutVisible
   */
  getVideoBottomLayoutVisible(): boolean | undefined

  /**
   * 获取videoBottomLayoutMarginTop
   *
   * @returns videoBottomLayoutMarginTop
   */
  getVideoBottomLayoutMarginTop(): number | undefined

  /**
   * 获取videoReleaseButtonVisible
   *
   * @returns videoReleaseButtonVisible
   */
  getVideoReleaseButtonVisible(): boolean | undefined

  /**
   * 获取videoReleaseButtonBackgroundColor
   *
   * @returns videoReleaseButtonBackgroundColor
   */
  getVideoReleaseButtonBackgroundColor(): number | undefined

  /**
   * 获取videoReleaseButtonWidth
   *
   * @returns videoReleaseButtonWidth
   */
  getVideoReleaseButtonWidth(): number | undefined

  /**
   * 获取videoReleaseButtonHeight
   *
   * @returns videoReleaseButtonHeight
   */
  getVideoReleaseButtonHeight(): number | undefined

  /**
   * 获取videoReleaseButtonRadiusTopLeft
   *
   * @returns videoReleaseButtonRadiusTopLeft
   */
  getVideoReleaseButtonRadiusTopLeft(): number | undefined

  /**
   * 获取videoReleaseButtonRadiusTopRight
   *
   * @returns videoReleaseButtonRadiusTopRight
   */
  getVideoReleaseButtonRadiusTopRight(): number | undefined

  /**
   * 获取videoReleaseButtonRadiusBottomLeft
   *
   * @returns videoReleaseButtonRadiusBottomLeft
   */
  getVideoReleaseButtonRadiusBottomLeft(): number | undefined

  /**
   * 获取videoReleaseButtonRadiusBottomRight
   *
   * @returns videoReleaseButtonRadiusBottomRight
   */
  getVideoReleaseButtonRadiusBottomRight(): number | undefined

  /**
   * 获取videoReleaseButtonIconTextGap
   *
   * @returns videoReleaseButtonIconTextGap
   */
  getVideoReleaseButtonIconTextGap(): number | undefined

  /**
   * 获取videoReleaseButtonIcon
   *
   * @returns videoReleaseButtonIcon
   */
  getVideoReleaseButtonIcon(): Resource | undefined

  /**
   * 获取videoReleaseButtonIconWidth
   *
   * @returns videoReleaseButtonIconWidth
   */
  getVideoReleaseButtonIconWidth(): number | undefined

  /**
   * 获取videoReleaseButtonIconHeight
   *
   * @returns videoReleaseButtonIconHeight
   */
  getVideoReleaseButtonIconHeight(): number | undefined

  /**
   * 获取videoReleaseButtonText
   *
   * @returns videoReleaseButtonText
   */
  getVideoReleaseButtonText(): string | undefined

  /**
   * 获取videoReleaseButtonTextFontColor
   *
   * @returns videoReleaseButtonTextFontColor
   */
  getVideoReleaseButtonTextFontColor(): number | undefined

  /**
   * 获取videoReleaseButtonTextFontSize
   *
   * @returns videoReleaseButtonTextFontSize
   */
  getVideoReleaseButtonTextFontSize(): number | undefined

  /**
   * 获取videoReleaseButtonTextFontStyle
   *
   * @returns videoReleaseButtonTextFontStyle
   */
  getVideoReleaseButtonTextFontStyle(): FontStyle | undefined

  /**
   * 获取videoReleaseButtonTextFontWeight
   *
   * @returns videoReleaseButtonTextFontWeight
   */
  getVideoReleaseButtonTextFontWeight(): FontWeight | undefined

  /**
   * 获取videoReleaseButtonTextFontFamily
   *
   * @returns videoReleaseButtonTextFontFamily
   */
  getVideoReleaseButtonTextFontFamily(): string | undefined

  /**
   * 获取videoReleaseButtonTextLineHeight
   *
   * @returns videoReleaseButtonTextLineHeight
   */
  getVideoReleaseButtonTextLineHeight(): number | undefined

  /**
   * 获取videoDownloadButtonVisible
   *
   * @returns videoDownloadButtonVisible
   */
  getVideoDownloadButtonVisible(): boolean | undefined

  /**
   * 获取videoDownloadButtonBackgroundColor
   *
   * @returns videoDownloadButtonBackgroundColor
   */
  getVideoDownloadButtonBackgroundColor(): number | undefined

  /**
   * 获取videoDownloadButtonWidth
   *
   * @returns videoDownloadButtonWidth
   */
  getVideoDownloadButtonWidth(): number | undefined

  /**
   * 获取videoDownloadButtonHeight
   *
   * @returns videoDownloadButtonHeight
   */
  getVideoDownloadButtonHeight(): number | undefined

  /**
   * 获取videoDownloadButtonRadiusTopLeft
   *
   * @returns videoDownloadButtonRadiusTopLeft
   */
  getVideoDownloadButtonRadiusTopLeft(): number | undefined

  /**
   * 获取videoDownloadButtonRadiusTopRight
   *
   * @returns videoDownloadButtonRadiusTopRight
   */
  getVideoDownloadButtonRadiusTopRight(): number | undefined

  /**
   * 获取videoDownloadButtonRadiusBottomLeft
   *
   * @returns videoDownloadButtonRadiusBottomLeft
   */
  getVideoDownloadButtonRadiusBottomLeft(): number | undefined

  /**
   * 获取videoDownloadButtonRadiusBottomRight
   *
   * @returns videoDownloadButtonRadiusBottomRight
   */
  getVideoDownloadButtonRadiusBottomRight(): number | undefined

  /**
   * 获取videoDownloadButtonIconTextGap
   *
   * @returns videoDownloadButtonIconTextGap
   */
  getVideoDownloadButtonIconTextGap(): number | undefined

  /**
   * 获取videoDownloadButtonIcon
   *
   * @returns videoDownloadButtonIcon
   */
  getVideoDownloadButtonIcon(): Resource | undefined

  /**
   * 获取videoDownloadButtonIconWidth
   *
   * @returns videoDownloadButtonIconWidth
   */
  getVideoDownloadButtonIconWidth(): number | undefined

  /**
   * 获取videoDownloadButtonIconHeight
   *
   * @returns videoDownloadButtonIconHeight
   */
  getVideoDownloadButtonIconHeight(): number | undefined

  /**
   * 获取videoDownloadButtonText
   *
   * @returns videoDownloadButtonText
   */
  getVideoDownloadButtonText(): string | undefined

  /**
   * 获取videoDownloadButtonTextFontColor
   *
   * @returns videoDownloadButtonTextFontColor
   */
  getVideoDownloadButtonTextFontColor(): number | undefined

  /**
   * 获取videoDownloadButtonTextFontSize
   *
   * @returns videoDownloadButtonTextFontSize
   */
  getVideoDownloadButtonTextFontSize(): number | undefined

  /**
   * 获取videoDownloadButtonTextFontStyle
   *
   * @returns videoDownloadButtonTextFontStyle
   */
  getVideoDownloadButtonTextFontStyle(): FontStyle | undefined

  /**
   * 获取videoDownloadButtonTextFontWeight
   *
   * @returns videoDownloadButtonTextFontWeight
   */
  getVideoDownloadButtonTextFontWeight(): FontWeight | undefined

  /**
   * 获取videoDownloadButtonTextFontFamily
   *
   * @returns videoDownloadButtonTextFontFamily
   */
  getVideoDownloadButtonTextFontFamily(): string | undefined

  /**
   * 获取videoDownloadButtonTextLineHeight
   *
   * @returns videoDownloadButtonTextLineHeight
   */
  getVideoDownloadButtonTextLineHeight(): number | undefined

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
   * 代码块整体外边距
   *
   * @param margin 外边距
   */
  setCodeBlockAllMargin(margin: number): void

  /**
   * 代码块分别设置四个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setCodeBlockMargin(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 代码块整体内边距
   *
   * @param padding 内边距
   */
  setCodeBlockAllPadding(padding: number): void

  /**
   * 代码块分别设置四个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setCodeBlockPadding(top?: number, right?: number, bottom?: number, left?: number): void

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
   * 代码块整体圆角
   *
   * @param radius 圆角
   */
  setCodeBlockAllRadius(radius: number): void

  /**
   * 代码块分别设置四个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setCodeBlockRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

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

  /**
   * 获取codeBlockIsDark
   *
   * @returns codeBlockIsDark
   */
  getCodeBlockIsDark(): boolean | undefined

  /**
   * 获取codeBlockIsCodeFormat
   *
   * @returns codeBlockIsCodeFormat
   */
  getCodeBlockIsCodeFormat(): boolean | undefined

  /**
   * 获取codeBlockUseTab
   *
   * @returns codeBlockUseTab
   */
  getCodeBlockUseTab(): boolean | undefined

  /**
   * 获取codeBlockIndentWidth
   *
   * @returns codeBlockIndentWidth
   */
  getCodeBlockIndentWidth(): number | undefined

  /**
   * 获取codeBlockParserSync
   *
   * @returns codeBlockParserSync
   */
  getCodeBlockParserSync(): boolean | undefined

  /**
   * 获取codeBlockBackgroundColor
   *
   * @returns codeBlockBackgroundColor
   */
  getCodeBlockBackgroundColor(): number | undefined

  /**
   * 获取codeBlockMarginTop
   *
   * @returns codeBlockMarginTop
   */
  getCodeBlockMarginTop(): number | undefined

  /**
   * 获取codeBlockMarginRight
   *
   * @returns codeBlockMarginRight
   */
  getCodeBlockMarginRight(): number | undefined

  /**
   * 获取codeBlockMarginBottom
   *
   * @returns codeBlockMarginBottom
   */
  getCodeBlockMarginBottom(): number | undefined

  /**
   * 获取codeBlockMarginLeft
   *
   * @returns codeBlockMarginLeft
   */
  getCodeBlockMarginLeft(): number | undefined

  /**
   * 获取codeBlockPaddingTop
   *
   * @returns codeBlockPaddingTop
   */
  getCodeBlockPaddingTop(): number | undefined

  /**
   * 获取codeBlockPaddingRight
   *
   * @returns codeBlockPaddingRight
   */
  getCodeBlockPaddingRight(): number | undefined

  /**
   * 获取codeBlockPaddingBottom
   *
   * @returns codeBlockPaddingBottom
   */
  getCodeBlockPaddingBottom(): number | undefined

  /**
   * 获取codeBlockPaddingLeft
   *
   * @returns codeBlockPaddingLeft
   */
  getCodeBlockPaddingLeft(): number | undefined

  /**
   * 获取codeBlockBorderStyle
   *
   * @returns codeBlockBorderStyle
   */
  getCodeBlockBorderStyle(): BorderStyle | undefined

  /**
   * 获取codeBlockBorderWidth
   *
   * @returns codeBlockBorderWidth
   */
  getCodeBlockBorderWidth(): number | undefined

  /**
   * 获取codeBlockBorderColor
   *
   * @returns codeBlockBorderColor
   */
  getCodeBlockBorderColor(): number | undefined

  /**
   * 获取codeBlockRadiusTopLeft
   *
   * @returns codeBlockRadiusTopLeft
   */
  getCodeBlockRadiusTopLeft(): number | undefined

  /**
   * 获取codeBlockRadiusTopRight
   *
   * @returns codeBlockRadiusTopRight
   */
  getCodeBlockRadiusTopRight(): number | undefined

  /**
   * 获取codeBlockRadiusBottomLeft
   *
   * @returns codeBlockRadiusBottomLeft
   */
  getCodeBlockRadiusBottomLeft(): number | undefined

  /**
   * 获取codeBlockRadiusBottomRight
   *
   * @returns codeBlockRadiusBottomRight
   */
  getCodeBlockRadiusBottomRight(): number | undefined

  /**
   * 获取codeBlockTitleLayoutMarginBottom
   *
   * @returns codeBlockTitleLayoutMarginBottom
   */
  getCodeBlockTitleLayoutMarginBottom(): number | undefined

  /**
   * 获取codeBlockTypeTextMarginLeft
   *
   * @returns codeBlockTypeTextMarginLeft
   */
  getCodeBlockTypeTextMarginLeft(): number | undefined

  /**
   * 获取codeBlockTypeText
   *
   * @returns codeBlockTypeText
   */
  getCodeBlockTypeText(): string | undefined

  /**
   * 获取codeBlockTypeTextFontColor
   *
   * @returns codeBlockTypeTextFontColor
   */
  getCodeBlockTypeTextFontColor(): number | undefined

  /**
   * 获取codeBlockTypeTextFontSize
   *
   * @returns codeBlockTypeTextFontSize
   */
  getCodeBlockTypeTextFontSize(): number | undefined

  /**
   * 获取codeBlockTypeTextFontStyle
   *
   * @returns codeBlockTypeTextFontStyle
   */
  getCodeBlockTypeTextFontStyle(): FontStyle | undefined

  /**
   * 获取codeBlockTypeTextFontWeight
   *
   * @returns codeBlockTypeTextFontWeight
   */
  getCodeBlockTypeTextFontWeight(): FontWeight | undefined

  /**
   * 获取codeBlockTypeTextFontFamily
   *
   * @returns codeBlockTypeTextFontFamily
   */
  getCodeBlockTypeTextFontFamily(): string | undefined

  /**
   * 获取codeBlockTypeTextLineHeight
   *
   * @returns codeBlockTypeTextLineHeight
   */
  getCodeBlockTypeTextLineHeight(): number | undefined

  /**
   * 获取codeBlockCopyFullScreenSpacing
   *
   * @returns codeBlockCopyFullScreenSpacing
   */
  getCodeBlockCopyFullScreenSpacing(): number | undefined

  /**
   * 获取codeBlockCopyButtonIsShow
   *
   * @returns codeBlockCopyButtonIsShow
   */
  getCodeBlockCopyButtonIsShow(): boolean | undefined

  /**
   * 获取codeBlockCopyTextIsShow
   *
   * @returns codeBlockCopyTextIsShow
   */
  getCodeBlockCopyTextIsShow(): boolean | undefined

  /**
   * 获取codeBlockCopyIcon
   *
   * @returns codeBlockCopyIcon
   */
  getCodeBlockCopyIcon(): Resource | undefined

  /**
   * 获取codeBlockCopyIconWidth
   *
   * @returns codeBlockCopyIconWidth
   */
  getCodeBlockCopyIconWidth(): number | undefined

  /**
   * 获取codeBlockCopyIconHeight
   *
   * @returns codeBlockCopyIconHeight
   */
  getCodeBlockCopyIconHeight(): number | undefined

  /**
   * 获取codeBlockCopyIconTextSpacing
   *
   * @returns codeBlockCopyIconTextSpacing
   */
  getCodeBlockCopyIconTextSpacing(): number | undefined

  /**
   * 获取codeBlockCopyText
   *
   * @returns codeBlockCopyText
   */
  getCodeBlockCopyText(): string | undefined

  /**
   * 获取codeBlockCopyTextFontColor
   *
   * @returns codeBlockCopyTextFontColor
   */
  getCodeBlockCopyTextFontColor(): number | undefined

  /**
   * 获取codeBlockCopyTextFontSize
   *
   * @returns codeBlockCopyTextFontSize
   */
  getCodeBlockCopyTextFontSize(): number | undefined

  /**
   * 获取codeBlockCopyTextFontStyle
   *
   * @returns codeBlockCopyTextFontStyle
   */
  getCodeBlockCopyTextFontStyle(): FontStyle | undefined

  /**
   * 获取codeBlockCopyTextFontWeight
   *
   * @returns codeBlockCopyTextFontWeight
   */
  getCodeBlockCopyTextFontWeight(): FontWeight | undefined

  /**
   * 获取codeBlockCopyTextFontFamily
   *
   * @returns codeBlockCopyTextFontFamily
   */
  getCodeBlockCopyTextFontFamily(): string | undefined

  /**
   * 获取codeBlockCopyTextLineHeight
   *
   * @returns codeBlockCopyTextLineHeight
   */
  getCodeBlockCopyTextLineHeight(): number | undefined

  /**
   * 获取codeBlockFullScreenButtonIsShow
   *
   * @returns codeBlockFullScreenButtonIsShow
   */
  getCodeBlockFullScreenButtonIsShow(): boolean | undefined

  /**
   * 获取codeBlockFullScreenTextIsShow
   *
   * @returns codeBlockFullScreenTextIsShow
   */
  getCodeBlockFullScreenTextIsShow(): boolean | undefined

  /**
   * 获取codeBlockFullScreenIcon
   *
   * @returns codeBlockFullScreenIcon
   */
  getCodeBlockFullScreenIcon(): Resource | undefined

  /**
   * 获取codeBlockFullScreenIconWidth
   *
   * @returns codeBlockFullScreenIconWidth
   */
  getCodeBlockFullScreenIconWidth(): number | undefined

  /**
   * 获取codeBlockFullScreenIconHeight
   *
   * @returns codeBlockFullScreenIconHeight
   */
  getCodeBlockFullScreenIconHeight(): number | undefined

  /**
   * 获取codeBlockFullScreenIconTextSpacing
   *
   * @returns codeBlockFullScreenIconTextSpacing
   */
  getCodeBlockFullScreenIconTextSpacing(): number | undefined

  /**
   * 获取codeBlockFullScreenText
   *
   * @returns codeBlockFullScreenText
   */
  getCodeBlockFullScreenText(): string | undefined

  /**
   * 获取codeBlockFullScreenTextFontColor
   *
   * @returns codeBlockFullScreenTextFontColor
   */
  getCodeBlockFullScreenTextFontColor(): number | undefined

  /**
   * 获取codeBlockFullScreenTextFontSize
   *
   * @returns codeBlockFullScreenTextFontSize
   */
  getCodeBlockFullScreenTextFontSize(): number | undefined

  /**
   * 获取codeBlockFullScreenTextFontStyle
   *
   * @returns codeBlockFullScreenTextFontStyle
   */
  getCodeBlockFullScreenTextFontStyle(): FontStyle | undefined

  /**
   * 获取codeBlockFullScreenTextFontWeight
   *
   * @returns codeBlockFullScreenTextFontWeight
   */
  getCodeBlockFullScreenTextFontWeight(): FontWeight | undefined

  /**
   * 获取codeBlockFullScreenTextFontFamily
   *
   * @returns codeBlockFullScreenTextFontFamily
   */
  getCodeBlockFullScreenTextFontFamily(): string | undefined

  /**
   * 获取codeBlockFullScreenTextLineHeight
   *
   * @returns codeBlockFullScreenTextLineHeight
   */
  getCodeBlockFullScreenTextLineHeight(): number | undefined

  /**
   * 获取codeBlockLineNumberIsShow
   *
   * @returns codeBlockLineNumberIsShow
   */
  getCodeBlockLineNumberIsShow(): boolean | undefined

  /**
   * 获取codeBlockLineNumberTextPaddingLeft
   *
   * @returns codeBlockLineNumberTextPaddingLeft
   */
  getCodeBlockLineNumberTextPaddingLeft(): number | undefined

  /**
   * 获取codeBlockLineNumberTextFontColor
   *
   * @returns codeBlockLineNumberTextFontColor
   */
  getCodeBlockLineNumberTextFontColor(): number | undefined

  /**
   * 获取codeBlockLineNumberTextFontSize
   *
   * @returns codeBlockLineNumberTextFontSize
   */
  getCodeBlockLineNumberTextFontSize(): number | undefined

  /**
   * 获取codeBlockLineNumberTextFontStyle
   *
   * @returns codeBlockLineNumberTextFontStyle
   */
  getCodeBlockLineNumberTextFontStyle(): FontStyle | undefined

  /**
   * 获取codeBlockLineNumberTextFontWeight
   *
   * @returns codeBlockLineNumberTextFontWeight
   */
  getCodeBlockLineNumberTextFontWeight(): FontWeight | undefined

  /**
   * 获取codeBlockLineNumberTextFontFamily
   *
   * @returns codeBlockLineNumberTextFontFamily
   */
  getCodeBlockLineNumberTextFontFamily(): string | undefined

  /**
   * 获取codeBlockLineNumberTextLineHeight
   *
   * @returns codeBlockLineNumberTextLineHeight
   */
  getCodeBlockLineNumberTextLineHeight(): number | undefined

  /**
   * 获取codeBlockDividerColor
   *
   * @returns codeBlockDividerColor
   */
  getCodeBlockDividerColor(): number | undefined

  /**
   * 获取codeBlockDividerStrokeWidth
   *
   * @returns codeBlockDividerStrokeWidth
   */
  getCodeBlockDividerStrokeWidth(): number | undefined

  /**
   * 获取codeBlockLineNumberDividerSpacing
   *
   * @returns codeBlockLineNumberDividerSpacing
   */
  getCodeBlockLineNumberDividerSpacing(): number | undefined

  /**
   * 获取codeBlockTextFontColor
   *
   * @returns codeBlockTextFontColor
   */
  getCodeBlockTextFontColor(): number | undefined

  /**
   * 获取codeBlockTextMarginRight
   *
   * @returns codeBlockTextMarginRight
   */
  getCodeBlockTextMarginRight(): number | undefined

  /**
   * 获取codeBlockTextMarginLeft
   *
   * @returns codeBlockTextMarginLeft
   */
  getCodeBlockTextMarginLeft(): number | undefined

  /**
   * 获取codeBlockTextFontSize
   *
   * @returns codeBlockTextFontSize
   */
  getCodeBlockTextFontSize(): number | undefined

  /**
   * 获取codeBlockTextFontStyle
   *
   * @returns codeBlockTextFontStyle
   */
  getCodeBlockTextFontStyle(): FontStyle | undefined

  /**
   * 获取codeBlockTextFontWeight
   *
   * @returns codeBlockTextFontWeight
   */
  getCodeBlockTextFontWeight(): FontWeight | undefined

  /**
   * 获取codeBlockTextFontFamily
   *
   * @returns codeBlockTextFontFamily
   */
  getCodeBlockTextFontFamily(): string | undefined

  /**
   * 获取codeBlockTextLineHeight
   *
   * @returns codeBlockTextLineHeight
   */
  getCodeBlockTextLineHeight(): number | undefined

  /**
   * 获取codeBlockTextLetterSpacing
   *
   * @returns codeBlockTextLetterSpacing
   */
  getCodeBlockTextLetterSpacing(): number | undefined

  /**
   * 获取codeBlockListTitleTextSize
   *
   * @returns codeBlockListTitleTextSize
   */
  getCodeBlockListTitleTextSize(): number | undefined

  /**
   * 获取codeBlockListTitleSelectTextSize
   *
   * @returns codeBlockListTitleSelectTextSize
   */
  getCodeBlockListTitleSelectTextSize(): number | undefined

  /**
   * 获取codeBlockListTitleSelectTextColor
   *
   * @returns codeBlockListTitleSelectTextColor
   */
  getCodeBlockListTitleSelectTextColor(): number | undefined

  /**
   * 获取codeBlockListTitleUnselectTextColor
   *
   * @returns codeBlockListTitleUnselectTextColor
   */
  getCodeBlockListTitleUnselectTextColor(): number | undefined

  /**
   * 获取codeBlockListTitleSelectBackgroundColor
   *
   * @returns codeBlockListTitleSelectBackgroundColor
   */
  getCodeBlockListTitleSelectBackgroundColor(): number | undefined

  /**
   * 获取codeBlockListTitleUnselectBackgroundColor
   *
   * @returns codeBlockListTitleUnselectBackgroundColor
   */
  getCodeBlockListTitleUnselectBackgroundColor(): number | undefined

  /**
   * 获取codeBlockIsSeparate
   *
   * @returns codeBlockIsSeparate
   */
  getCodeBlockIsSeparate(): boolean | undefined

  /**
   * 获取codeBlockSeparateWidth
   *
   * @returns codeBlockSeparateWidth
   */
  getCodeBlockSeparateWidth(): number | undefined

  /**
   * 获取codeBlockSeparateIsBottom
   *
   * @returns codeBlockSeparateIsBottom
   */
  getCodeBlockSeparateIsBottom(): boolean | undefined

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
   * 设置标题的4个外边距：设置H1-H6级标题所有4个外边距为统一值
   *
   * @param margin 外边距
   */
  setAllMarginForAllHeading(margin: number): void

  /**
   * 设置标题的4个外边距：设置H1-H6级标题，所有等级的某一个外边距为统一值
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setMarginForAllHeadingEachLevel(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 设置标题的4个外边距：设置H1-H6级标题，每级标题自己的4个外边距为统一值
   *
   * @param marginList 外边距集合
   */
  setMarginForEachHeading(marginList: number[]): void

  /**
   * 设置标题的4个外边距：指定标题等级，设置标题的4个外边距为统一值
   *
   * @param level 标题等级
   * @param margin 外边距
   */
  setAllMarginForDesignateHeading(level: number, margin: number): void

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
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setMarginForDesignateHeading(level: number, top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 设置标题的4个内边距：设置H1-H6级标题所有4个内边距为统一值
   *
   * @param padding 内边距
   */
  setAllPaddingForAllHeading(padding: number): void

  /**
   * 设置标题的4个内边距：设置H1-H6级标题，所有等级的某一个内边距为统一值
   *
   * @param top 上内边距集合
   * @param right 右内边距集合
   * @param bottom 下内边距集合
   * @param left 左内边距集合
   */
  setPaddingForAllHeadingEachLevel(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 设置标题的4个内边距：设置H1-H6级标题，每级标题自己的4个内边距为统一值
   *
   * @param paddingList 内边距集合
   */
  setPaddingForEachHeading(paddingList: number[]): void

  /**
   * 设置标题的4个内边距：指定标题等级，设置标题的4个内边距为统一值
   *
   * @param level 标题等级
   * @param padding 内边距
   */
  setAllPaddingForDesignateHeading(level: number, padding: number): void

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
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setPaddingForDesignateHeading(level: number, top?: number, right?: number, bottom?: number, left?: number): void

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

  /**
   * 获取heading1BackgroundColor
   *
   * @returns heading1BackgroundColor
   */
  getHeading1BackgroundColor(): number | undefined

  /**
   * 获取heading1MarginTop
   *
   * @returns heading1MarginTop
   */
  getHeading1MarginTop(): number | undefined

  /**
   * 获取heading1MarginRight
   *
   * @returns heading1MarginRight
   */
  getHeading1MarginRight(): number | undefined

  /**
   * 获取heading1MarginBottom
   *
   * @returns heading1MarginBottom
   */
  getHeading1MarginBottom(): number | undefined

  /**
   * 获取heading1MarginLeft
   *
   * @returns heading1MarginLeft
   */
  getHeading1MarginLeft(): number | undefined

  /**
   * 获取heading1PaddingTop
   *
   * @returns heading1PaddingTop
   */
  getHeading1PaddingTop(): number | undefined

  /**
   * 获取heading1PaddingRight
   *
   * @returns heading1PaddingRight
   */
  getHeading1PaddingRight(): number | undefined

  /**
   * 获取heading1PaddingBottom
   *
   * @returns heading1PaddingBottom
   */
  getHeading1PaddingBottom(): number | undefined

  /**
   * 获取heading1PaddingLeft
   *
   * @returns heading1PaddingLeft
   */
  getHeading1PaddingLeft(): number | undefined

  /**
   * 获取heading1TextFontColor
   *
   * @returns heading1TextFontColor
   */
  getHeading1TextFontColor(): number | undefined

  /**
   * 获取heading1TextFontSize
   *
   * @returns heading1TextFontSize
   */
  getHeading1TextFontSize(): number | undefined

  /**
   * 获取heading1TextFontStyle
   *
   * @returns heading1TextFontStyle
   */
  getHeading1TextFontStyle(): FontStyle | undefined

  /**
   * 获取heading1TextFontWeight
   *
   * @returns heading1TextFontWeight
   */
  getHeading1TextFontWeight(): FontWeight | undefined

  /**
   * 获取heading1TextFontFamily
   *
   * @returns heading1TextFontFamily
   */
  getHeading1TextFontFamily(): string | undefined

  /**
   * 获取heading1TextLineHeight
   *
   * @returns heading1TextLineHeight
   */
  getHeading1TextLineHeight(): number | undefined

  /**
   * 获取heading1TextLetterSpacing
   *
   * @returns heading1TextLetterSpacing
   */
  getHeading1TextLetterSpacing(): number | undefined

  /**
   * 获取heading1UnderlineHeight
   *
   * @returns heading1UnderlineHeight
   */
  getHeading1UnderlineHeight(): number | undefined

  /**
   * 获取heading1UnderlineColor
   *
   * @returns heading1UnderlineColor
   */
  getHeading1UnderlineColor(): number | undefined

  /**
   * 获取heading1UnderlineSpacing
   *
   * @returns heading1UnderlineSpacing
   */
  getHeading1UnderlineSpacing(): number | undefined

  /**
   * 获取heading2BackgroundColor
   *
   * @returns heading2BackgroundColor
   */
  getHeading2BackgroundColor(): number | undefined

  /**
   * 获取heading2MarginTop
   *
   * @returns heading2MarginTop
   */
  getHeading2MarginTop(): number | undefined

  /**
   * 获取heading2MarginRight
   *
   * @returns heading2MarginRight
   */
  getHeading2MarginRight(): number | undefined

  /**
   * 获取heading2MarginBottom
   *
   * @returns heading2MarginBottom
   */
  getHeading2MarginBottom(): number | undefined

  /**
   * 获取heading2MarginLeft
   *
   * @returns heading2MarginLeft
   */
  getHeading2MarginLeft(): number | undefined

  /**
   * 获取heading2PaddingTop
   *
   * @returns heading2PaddingTop
   */
  getHeading2PaddingTop(): number | undefined

  /**
   * 获取heading2PaddingRight
   *
   * @returns heading2PaddingRight
   */
  getHeading2PaddingRight(): number | undefined

  /**
   * 获取heading2PaddingBottom
   *
   * @returns heading2PaddingBottom
   */
  getHeading2PaddingBottom(): number | undefined

  /**
   * 获取heading2PaddingLeft
   *
   * @returns heading2PaddingLeft
   */
  getHeading2PaddingLeft(): number | undefined

  /**
   * 获取heading2TextFontColor
   *
   * @returns heading2TextFontColor
   */
  getHeading2TextFontColor(): number | undefined

  /**
   * 获取heading2TextFontSize
   *
   * @returns heading2TextFontSize
   */
  getHeading2TextFontSize(): number | undefined

  /**
   * 获取heading2TextFontStyle
   *
   * @returns heading2TextFontStyle
   */
  getHeading2TextFontStyle(): FontStyle | undefined

  /**
   * 获取heading2TextFontWeight
   *
   * @returns heading2TextFontWeight
   */
  getHeading2TextFontWeight(): FontWeight | undefined

  /**
   * 获取heading2TextFontFamily
   *
   * @returns heading2TextFontFamily
   */
  getHeading2TextFontFamily(): string | undefined

  /**
   * 获取heading2TextLineHeight
   *
   * @returns heading2TextLineHeight
   */
  getHeading2TextLineHeight(): number | undefined

  /**
   * 获取heading2TextLetterSpacing
   *
   * @returns heading2TextLetterSpacing
   */
  getHeading2TextLetterSpacing(): number | undefined

  /**
   * 获取heading2UnderlineHeight
   *
   * @returns heading2UnderlineHeight
   */
  getHeading2UnderlineHeight(): number | undefined

  /**
   * 获取heading2UnderlineColor
   *
   * @returns heading2UnderlineColor
   */
  getHeading2UnderlineColor(): number | undefined

  /**
   * 获取heading2UnderlineSpacing
   *
   * @returns heading2UnderlineSpacing
   */
  getHeading2UnderlineSpacing(): number | undefined

  /**
   * 获取heading3BackgroundColor
   *
   * @returns heading3BackgroundColor
   */
  getHeading3BackgroundColor(): number | undefined

  /**
   * 获取heading3MarginTop
   *
   * @returns heading3MarginTop
   */
  getHeading3MarginTop(): number | undefined

  /**
   * 获取heading3MarginRight
   *
   * @returns heading3MarginRight
   */
  getHeading3MarginRight(): number | undefined

  /**
   * 获取heading3MarginBottom
   *
   * @returns heading3MarginBottom
   */
  getHeading3MarginBottom(): number | undefined

  /**
   * 获取heading3MarginLeft
   *
   * @returns heading3MarginLeft
   */
  getHeading3MarginLeft(): number | undefined

  /**
   * 获取heading3PaddingTop
   *
   * @returns heading3PaddingTop
   */
  getHeading3PaddingTop(): number | undefined

  /**
   * 获取heading3PaddingRight
   *
   * @returns heading3PaddingRight
   */
  getHeading3PaddingRight(): number | undefined

  /**
   * 获取heading3PaddingBottom
   *
   * @returns heading3PaddingBottom
   */
  getHeading3PaddingBottom(): number | undefined

  /**
   * 获取heading3PaddingLeft
   *
   * @returns heading3PaddingLeft
   */
  getHeading3PaddingLeft(): number | undefined

  /**
   * 获取heading3TextFontColor
   *
   * @returns heading3TextFontColor
   */
  getHeading3TextFontColor(): number | undefined

  /**
   * 获取heading3TextFontSize
   *
   * @returns heading3TextFontSize
   */
  getHeading3TextFontSize(): number | undefined

  /**
   * 获取heading3TextFontStyle
   *
   * @returns heading3TextFontStyle
   */
  getHeading3TextFontStyle(): FontStyle | undefined

  /**
   * 获取heading3TextFontWeight
   *
   * @returns heading3TextFontWeight
   */
  getHeading3TextFontWeight(): FontWeight | undefined

  /**
   * 获取heading3TextFontFamily
   *
   * @returns heading3TextFontFamily
   */
  getHeading3TextFontFamily(): string | undefined

  /**
   * 获取heading3TextLineHeight
   *
   * @returns heading3TextLineHeight
   */
  getHeading3TextLineHeight(): number | undefined

  /**
   * 获取heading3TextLetterSpacing
   *
   * @returns heading3TextLetterSpacing
   */
  getHeading3TextLetterSpacing(): number | undefined

  /**
   * 获取heading4BackgroundColor
   *
   * @returns heading4BackgroundColor
   */
  getHeading4BackgroundColor(): number | undefined

  /**
   * 获取heading4MarginTop
   *
   * @returns heading4MarginTop
   */
  getHeading4MarginTop(): number | undefined

  /**
   * 获取heading4MarginRight
   *
   * @returns heading4MarginRight
   */
  getHeading4MarginRight(): number | undefined

  /**
   * 获取heading4MarginBottom
   *
   * @returns heading4MarginBottom
   */
  getHeading4MarginBottom(): number | undefined

  /**
   * 获取heading4MarginLeft
   *
   * @returns heading4MarginLeft
   */
  getHeading4MarginLeft(): number | undefined

  /**
   * 获取heading4PaddingTop
   *
   * @returns heading4PaddingTop
   */
  getHeading4PaddingTop(): number | undefined

  /**
   * 获取heading4PaddingRight
   *
   * @returns heading4PaddingRight
   */
  getHeading4PaddingRight(): number | undefined

  /**
   * 获取heading4PaddingBottom
   *
   * @returns heading4PaddingBottom
   */
  getHeading4PaddingBottom(): number | undefined

  /**
   * 获取heading4PaddingLeft
   *
   * @returns heading4PaddingLeft
   */
  getHeading4PaddingLeft(): number | undefined

  /**
   * 获取heading4TextFontColor
   *
   * @returns heading4TextFontColor
   */
  getHeading4TextFontColor(): number | undefined

  /**
   * 获取heading4TextFontSize
   *
   * @returns heading4TextFontSize
   */
  getHeading4TextFontSize(): number | undefined

  /**
   * 获取heading4TextFontStyle
   *
   * @returns heading4TextFontStyle
   */
  getHeading4TextFontStyle(): FontStyle | undefined

  /**
   * 获取heading4TextFontWeight
   *
   * @returns heading4TextFontWeight
   */
  getHeading4TextFontWeight(): FontWeight | undefined

  /**
   * 获取heading4TextFontFamily
   *
   * @returns heading4TextFontFamily
   */
  getHeading4TextFontFamily(): string | undefined

  /**
   * 获取heading4TextLineHeight
   *
   * @returns heading4TextLineHeight
   */
  getHeading4TextLineHeight(): number | undefined

  /**
   * 获取heading4TextLetterSpacing
   *
   * @returns heading4TextLetterSpacing
   */
  getHeading4TextLetterSpacing(): number | undefined

  /**
   * 获取heading5BackgroundColor
   *
   * @returns heading5BackgroundColor
   */
  getHeading5BackgroundColor(): number | undefined

  /**
   * 获取heading5MarginTop
   *
   * @returns heading5MarginTop
   */
  getHeading5MarginTop(): number | undefined

  /**
   * 获取heading5MarginRight
   *
   * @returns heading5MarginRight
   */
  getHeading5MarginRight(): number | undefined

  /**
   * 获取heading5MarginBottom
   *
   * @returns heading5MarginBottom
   */
  getHeading5MarginBottom(): number | undefined

  /**
   * 获取heading5MarginLeft
   *
   * @returns heading5MarginLeft
   */
  getHeading5MarginLeft(): number | undefined

  /**
   * 获取heading5PaddingTop
   *
   * @returns heading5PaddingTop
   */
  getHeading5PaddingTop(): number | undefined

  /**
   * 获取heading5PaddingRight
   *
   * @returns heading5PaddingRight
   */
  getHeading5PaddingRight(): number | undefined

  /**
   * 获取heading5PaddingBottom
   *
   * @returns heading5PaddingBottom
   */
  getHeading5PaddingBottom(): number | undefined

  /**
   * 获取heading5PaddingLeft
   *
   * @returns heading5PaddingLeft
   */
  getHeading5PaddingLeft(): number | undefined

  /**
   * 获取heading5TextFontColor
   *
   * @returns heading5TextFontColor
   */
  getHeading5TextFontColor(): number | undefined

  /**
   * 获取heading5TextFontSize
   *
   * @returns heading5TextFontSize
   */
  getHeading5TextFontSize(): number | undefined

  /**
   * 获取heading5TextFontStyle
   *
   * @returns heading5TextFontStyle
   */
  getHeading5TextFontStyle(): FontStyle | undefined

  /**
   * 获取heading5TextFontWeight
   *
   * @returns heading5TextFontWeight
   */
  getHeading5TextFontWeight(): FontWeight | undefined

  /**
   * 获取heading5TextFontFamily
   *
   * @returns heading5TextFontFamily
   */
  getHeading5TextFontFamily(): string | undefined

  /**
   * 获取heading5TextLineHeight
   *
   * @returns heading5TextLineHeight
   */
  getHeading5TextLineHeight(): number | undefined

  /**
   * 获取heading5TextLetterSpacing
   *
   * @returns heading5TextLetterSpacing
   */
  getHeading5TextLetterSpacing(): number | undefined

  /**
   * 获取heading6BackgroundColor
   *
   * @returns heading6BackgroundColor
   */
  getHeading6BackgroundColor(): number | undefined

  /**
   * 获取heading6MarginTop
   *
   * @returns heading6MarginTop
   */
  getHeading6MarginTop(): number | undefined

  /**
   * 获取heading6MarginRight
   *
   * @returns heading6MarginRight
   */
  getHeading6MarginRight(): number | undefined

  /**
   * 获取heading6MarginBottom
   *
   * @returns heading6MarginBottom
   */
  getHeading6MarginBottom(): number | undefined

  /**
   * 获取heading6MarginLeft
   *
   * @returns heading6MarginLeft
   */
  getHeading6MarginLeft(): number | undefined

  /**
   * 获取heading6PaddingTop
   *
   * @returns heading6PaddingTop
   */
  getHeading6PaddingTop(): number | undefined

  /**
   * 获取heading6PaddingRight
   *
   * @returns heading6PaddingRight
   */
  getHeading6PaddingRight(): number | undefined

  /**
   * 获取heading6PaddingBottom
   *
   * @returns heading6PaddingBottom
   */
  getHeading6PaddingBottom(): number | undefined

  /**
   * 获取heading6PaddingLeft
   *
   * @returns heading6PaddingLeft
   */
  getHeading6PaddingLeft(): number | undefined

  /**
   * 获取heading6TextFontColor
   *
   * @returns heading6TextFontColor
   */
  getHeading6TextFontColor(): number | undefined

  /**
   * 获取heading6TextFontSize
   *
   * @returns heading6TextFontSize
   */
  getHeading6TextFontSize(): number | undefined

  /**
   * 获取heading6TextFontStyle
   *
   * @returns heading6TextFontStyle
   */
  getHeading6TextFontStyle(): FontStyle | undefined

  /**
   * 获取heading6TextFontWeight
   *
   * @returns heading6TextFontWeight
   */
  getHeading6TextFontWeight(): FontWeight | undefined

  /**
   * 获取heading6TextFontFamily
   *
   * @returns heading6TextFontFamily
   */
  getHeading6TextFontFamily(): string | undefined

  /**
   * 获取heading6TextLineHeight
   *
   * @returns heading6TextLineHeight
   */
  getHeading6TextLineHeight(): number | undefined

  /**
   * 获取heading6TextLetterSpacing
   *
   * @returns heading6TextLetterSpacing
   */
  getHeading6TextLetterSpacing(): number | undefined

}
```

### class MarkdownThemeBanner

Markdown用户可设置的样式-Banner样式

```ets
export class MarkdownThemeBanner {
  /**
   * banner分别设置四个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setBannerMargin(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * banner整体内边距
   *
   * @param padding 内边距
   */
  setBannerAllPadding(padding: number): void

  /**
   * banner分别设置四个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setBannerPadding(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 设置banner占位图
   *
   * @param resource banner占位图
   */
  setBannerPlaceholder(resource: Resource): void

  /**
   * 获取bannerMarginTop
   *
   * @returns bannerMarginTop
   */
  getBannerMarginTop(): number | undefined

  /**
   * 获取bannerMarginRight
   *
   * @returns bannerMarginRight
   */
  getBannerMarginRight(): number | undefined

  /**
   * 获取bannerMarginBottom
   *
   * @returns bannerMarginBottom
   */
  getBannerMarginBottom(): number | undefined

  /**
   * 获取bannerMarginLeft
   *
   * @returns bannerMarginLeft
   */
  getBannerMarginLeft(): number | undefined

  /**
   * 获取bannerPaddingTop
   *
   * @returns bannerPaddingTop
   */
  getBannerPaddingTop(): number | undefined

  /**
   * 获取bannerPaddingRight
   *
   * @returns bannerPaddingRight
   */
  getBannerPaddingRight(): number | undefined

  /**
   * 获取bannerPaddingBottom
   *
   * @returns bannerPaddingBottom
   */
  getBannerPaddingBottom(): number | undefined

  /**
   * 获取bannerPaddingLeft
   *
   * @returns bannerPaddingLeft
   */
  getBannerPaddingLeft(): number | undefined

  /**
   * 获取bannerPlaceholder
   *
   * @returns bannerPlaceholder
   */
  getBannerPlaceholder(): Resource | undefined

}
```

### class MarkdownThemeBlockQuote

Markdown用户可设置的样式-块引用样式

```ets
export class MarkdownThemeBlockQuote {
  /**
   * 块引用整体外边距
   *
   * @param margin 外边距
   */
  setBlockQuoteAllMargin(margin: number): void

  /**
   * 块引用分别设置四个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setBlockQuoteMargin(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 块引用整体内边距
   *
   * @param padding 内边距
   */
  setBlockQuoteAllPadding(padding: number): void

  /**
   * 块引用分别设置四个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setBlockQuotePadding(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 块引用整体圆角
   *
   * @param radius 圆角
   */
  setBlockQuoteAllRadius(radius: number): void

  /**
   * 块引用分别设置四个圆角
   *
   * @param topLeft 左上圆角
   * @param topRight 右上圆角
   * @param bottomLeft 左下圆角
   * @param bottomRight 右下圆角
   */
  setBlockQuoteRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

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
   * 设置块引用左侧线条和内容的间距
   *
   * @param spacing 块引用左侧线条和内容的间距
   */
  setBlockQuoteBorderContentSpacing(spacing: number): void

  /**
   * 设置块引用子模块上下间距
   *
   * @param spacing 块引用子模块上下间距
   */
  setBlockQuoteChildSpacing(spacing: number): void

  /**
   * 获取blockQuoteBackgroundColor
   *
   * @returns blockQuoteBackgroundColor
   */
  getBlockQuoteBackgroundColor(): number | undefined

  /**
   * 获取blockQuoteMarginTop
   *
   * @returns blockQuoteMarginTop
   */
  getBlockQuoteMarginTop(): number | undefined

  /**
   * 获取blockQuoteMarginRight
   *
   * @returns blockQuoteMarginRight
   */
  getBlockQuoteMarginRight(): number | undefined

  /**
   * 获取blockQuoteMarginBottom
   *
   * @returns blockQuoteMarginBottom
   */
  getBlockQuoteMarginBottom(): number | undefined

  /**
   * 获取blockQuoteMarginLeft
   *
   * @returns blockQuoteMarginLeft
   */
  getBlockQuoteMarginLeft(): number | undefined

  /**
   * 获取blockQuotePaddingTop
   *
   * @returns blockQuotePaddingTop
   */
  getBlockQuotePaddingTop(): number | undefined

  /**
   * 获取blockQuotePaddingRight
   *
   * @returns blockQuotePaddingRight
   */
  getBlockQuotePaddingRight(): number | undefined

  /**
   * 获取blockQuotePaddingBottom
   *
   * @returns blockQuotePaddingBottom
   */
  getBlockQuotePaddingBottom(): number | undefined

  /**
   * 获取blockQuotePaddingLeft
   *
   * @returns blockQuotePaddingLeft
   */
  getBlockQuotePaddingLeft(): number | undefined

  /**
   * 获取blockQuoteRadiusTopLeft
   *
   * @returns blockQuoteRadiusTopLeft
   */
  getBlockQuoteRadiusTopLeft(): number | undefined

  /**
   * 获取blockQuoteRadiusTopRight
   *
   * @returns blockQuoteRadiusTopRight
   */
  getBlockQuoteRadiusTopRight(): number | undefined

  /**
   * 获取blockQuoteRadiusBottomLeft
   *
   * @returns blockQuoteRadiusBottomLeft
   */
  getBlockQuoteRadiusBottomLeft(): number | undefined

  /**
   * 获取blockQuoteRadiusBottomRight
   *
   * @returns blockQuoteRadiusBottomRight
   */
  getBlockQuoteRadiusBottomRight(): number | undefined

  /**
   * 获取blockQuoteLeftBorderWidth
   *
   * @returns blockQuoteLeftBorderWidth
   */
  getBlockQuoteLeftBorderWidth(): number | undefined

  /**
   * 获取blockQuoteLeftBorderColor
   *
   * @returns blockQuoteLeftBorderColor
   */
  getBlockQuoteLeftBorderColor(): number | undefined

  /**
   * 获取blockQuoteBorderContentSpacing
   *
   * @returns blockQuoteBorderContentSpacing
   */
  getBlockQuoteBorderContentSpacing(): number | undefined

  /**
   * 获取blockQuoteChildSpacing
   *
   * @returns blockQuoteChildSpacing
   */
  getBlockQuoteChildSpacing(): number | undefined

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

  /**
   * 获取boldTextFontColor
   *
   * @returns boldTextFontColor
   */
  getBoldTextFontColor(): number | undefined

  /**
   * 获取boldTextFontSize
   *
   * @returns boldTextFontSize
   */
  getBoldTextFontSize(): number | undefined

  /**
   * 获取boldTextFontStyle
   *
   * @returns boldTextFontStyle
   */
  getBoldTextFontStyle(): FontStyle | undefined

  /**
   * 获取boldTextFontWeight
   *
   * @returns boldTextFontWeight
   */
  getBoldTextFontWeight(): FontWeight | undefined

  /**
   * 获取boldTextFontFamily
   *
   * @returns boldTextFontFamily
   */
  getBoldTextFontFamily(): string | undefined

  /**
   * 获取boldTextLineHeight
   *
   * @returns boldTextLineHeight
   */
  getBoldTextLineHeight(): number | undefined

  /**
   * 获取boldTextLetterSpacing
   *
   * @returns boldTextLetterSpacing
   */
  getBoldTextLetterSpacing(): number | undefined

}
```

### class MarkdownThemeDivider

Markdown用户可设置的样式-分割线样式

```ets
export class MarkdownThemeDivider {
  /**
   * 分割线分别设置四个外边距
   *
   * @param top 上外边距
   * @param right 右外边距
   * @param bottom 下外边距
   * @param left 左外边距
   */
  setDividerMargin(top?: number, right?: number, bottom?: number, left?: number): void

  /**
   * 分割线整体内边距
   *
   * @param padding 内边距
   */
  setDividerAllPadding(padding: number): void

  /**
   * 分割线分别设置四个内边距
   *
   * @param top 上内边距
   * @param right 右内边距
   * @param bottom 下内边距
   * @param left 左内边距
   */
  setDividerPadding(top?: number, right?: number, bottom?: number, left?: number): void

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

  /**
   * 获取dividerMarginTop
   *
   * @returns dividerMarginTop
   */
  getDividerMarginTop(): number | undefined

  /**
   * 获取dividerMarginRight
   *
   * @returns dividerMarginRight
   */
  getDividerMarginRight(): number | undefined

  /**
   * 获取dividerMarginBottom
   *
   * @returns dividerMarginBottom
   */
  getDividerMarginBottom(): number | undefined

  /**
   * 获取dividerMarginLeft
   *
   * @returns dividerMarginLeft
   */
  getDividerMarginLeft(): number | undefined

  /**
   * 获取dividerPaddingTop
   *
   * @returns dividerPaddingTop
   */
  getDividerPaddingTop(): number | undefined

  /**
   * 获取dividerPaddingRight
   *
   * @returns dividerPaddingRight
   */
  getDividerPaddingRight(): number | undefined

  /**
   * 获取dividerPaddingBottom
   *
   * @returns dividerPaddingBottom
   */
  getDividerPaddingBottom(): number | undefined

  /**
   * 获取dividerPaddingLeft
   *
   * @returns dividerPaddingLeft
   */
  getDividerPaddingLeft(): number | undefined

  /**
   * 获取dividerColor
   *
   * @returns dividerColor
   */
  getDividerColor(): number | undefined

  /**
   * 获取dividerStrokeWidth
   *
   * @returns dividerStrokeWidth
   */
  getDividerStrokeWidth(): number | undefined

  /**
   * 获取dividerStyle
   *
   * @returns dividerStyle
   */
  getDividerStyle(): LineCapStyle | undefined

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
   * 设置组合代码快列表插件
   *
   * @param isCodeListPlugin 是否设置组合代码快列表插件 - true：设置组合代码快列表插件；false：不设置组合代码快列表插件。默认false
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
  setIsLinkifyPlugin(isLinkifyPlugin: boolean, regs: Array<string>): void

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
   * @param isEmojiPlugin 是否加载Emoji解析插件 - true：设置加载Emoji解析插件件；false：不设置加载Emoji解析插件。默认false
   * @param isEmojiLight 是否加载精简emoji表情 - true：加载精简emoji表情；false：不加载精简emoji表情。默认true
   */
  setIsEmojiPlugin(isEmojiPlugin: boolean, isEmojiLight: boolean): void

  /**
   * 获取是否加载音频解析插件
   *
   * @returns 是否加载音频解析插件
   */
  getIsBlockAudioPlugin(): boolean

  /**
   * 获取是否加载视频解析插件
   *
   * @returns 是否加载视频解析插件
   */
  getIsBlockVideoPlugin(): boolean

  /**
   * 获取是否加载代码列表解析插件
   *
   * @returns 是否加载代码列表解析插件
   */
  getIsCodeListPlugin(): boolean

  /**
   * 获取是否加载脚注解析插件
   *
   * @returns 是否加载脚注解析插件
   */
  getIsFootnotePlugin(): boolean

  /**
   * 获取是否加载html解析插件
   *
   * @returns 是否加载html解析插件
   */
  getIsHtmlPlugin(): boolean

  /**
   * 获取是否加载表格解析插件
   *
   * @returns 是否加载表格解析插件
   */
  getIsTablePlugin(): boolean

  /**
   * 获取是否加载toc解析插件
   *
   * @returns 是否加载toc解析插件
   */
  getIsTocPlugin(): boolean

  /**
   * 获取是否加载任务列表解析插件
   *
   * @returns 是否加载任务列表解析插件
   */
  getIsTaskListPlugin(): boolean

  /**
   * 获取是否加载删除线解析插件
   *
   * @returns 是否加载删除线解析插件
   */
  getIsStrikethroughPlugin(): boolean

  /**
   * 获取是否加载链接自动解析插件
   *
   * @returns 是否加载链接自动解析插件
   */
  getIsLinkifyPlugin(): boolean

  /**
   * 获取正则列表
   *
   * @returns 正则列表
   */
  getRegs(): Array<string>

  /**
   * 获取是否加载链接单独解析插件
   *
   * @returns 是否加载链接单独解析插件
   */
  getIsLinkViewPlugin(): boolean

  /**
   * 获取是否加载数学公式解析插件
   *
   * @returns 是否加载数学公式解析插件
   */
  getIsLatexMathPlugin(): boolean

  /**
   * 获取是否加载图片自定义样式解析插件
   *
   * @returns 是否加载图片自定义样式解析插件
   */
  getIsImageStylePlugin(): boolean

  /**
   * 获取是否加载图片banner解析插件
   *
   * @returns 是否加载图片banner解析插件
   */
  getIsImageSlidePlugin(): boolean

  /**
   * 获取是否加载图片单独提取到block解析插件
   *
   * @returns 是否加载图片单独提取到block解析插件
   */
  getIsImageTextMixPlugin(): boolean

  /**
   * 获取是否加载图片视频列表url集合列表解析插件
   *
   * @returns 是否加载图片视频列表url集合列表解析插件
   */
  getIsImageCollectPlugin(): boolean

  /**
   * 获取是否加载定义列表解析插件
   *
   * @returns 是否加载定义列表解析插件
   */
  getIsDescListPlugin(): boolean

  /**
   * 获取是否加载标题ID解析插件
   *
   * @returns 是否加载标题ID解析插件
   */
  getIsHeadIDPlugin(): boolean

  /**
   * 获取是否加载下标解析插件
   *
   * @returns 是否加载下标解析插件
   */
  getIsSubPlugin(): boolean

  /**
   * 获取是否加载上标解析插件
   *
   * @returns 是否加载上标解析插件
   */
  getIsSupPlugin(): boolean

  /**
   * 获取是否加载emoji解析插件
   *
   * @returns 是否加载emoji解析插件
   */
  getIsEmojiPlugin(): boolean

  /**
   * 获取emoji解析插件是否精简加载
   *
   * @returns emoji解析插件是否精简加载
   */
  getIsEmojiLight(): boolean
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
