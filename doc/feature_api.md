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
   */
  setContext(context: Context): void

  /**
   * 设置代码块全屏图片icon
   *
   * @param codeFullScreenIcon 代码块全屏图片icon
   */
  setCodeFullScreenIcon(codeFullScreenIcon: Resource): void

  /**
   * 设置代码块复制图片icon
   *
   * @param codeCopyIcon 代码块复制图片icon
   */
  setCodeCopyIcon(codeCopyIcon: Resource): void

  /**
   * 设置音频图片icon
   *
   * @param audioIcon 音频图片icon
   */
  setAudioIcon(audioIcon: Resource): void

  /**
   * 设置视频默认占位图
   *
   * @param videoImage 视频默认占位图
   */
  setVideoImage(videoImage: Resource): void

  /**
   * 设置视频播放按钮icon
   *
   * @param playCircleFillIcon 视频播放按钮icon
   */
  setPlayCircleFillIcon(playCircleFillIcon: Resource): void

  /**
   * 设置banner占位图
   *
   * @param bannerImage banner占位图
   */
  setBannerImage(bannerImage: Resource): void

  /**
   * 设置图片占位图
   *
   * @param imageResource 图片占位图
   */
  setImageResource(imageResource: Resource): void

  /**
   * 设置视频发布默认图标
   *
   * @param videoReleaseImage 视频发布默认图标
   */
  setVideoReleaseImage(videoReleaseImage: Resource): void

  /**
   * 设置视频下载默认图标
   *
   * @param videoDownloadImage 视频下载默认图标
   */
  setVideoDownloadImage(videoDownloadImage: Resource): void

  /**
   * 设置图片下载默认图标
   *
   * @param imageDownloadImage 图片下载默认图标
   */
  setImageDownloadImage(imageDownloadImage: Resource): void

  /**
   * 设置markdown是否同步解析
   *
   * @param isMarkdownParserSync markdown是否同步解析 - 默认false
   */
  setIsMarkdownParserSync(isMarkdownParserSync: boolean): void
  
  /**
   * 设置是否显示打字机效果
   *
   * @param typeWriterOpen 是否显示打字机效果 - true：显示；false：不显示。默认true
   */
  setTypeWriterOpen(typeWriterOpen: boolean): void

  /**
   * 设置打字机效果颜色
   *
   * @param typeWriterColor 打字机效果颜色 - 默认RED
   */
  setTypeWriterColor(typeWriterColor: number): void
    
  /**
   * 设置是否打开长按复制粘贴
   *
   * @param isOnCopy 是否打开长按复制粘贴 - 默认true
   */
  setIsOnCopy(isOnCopy: boolean): void

  /**
   * 设置markdown第一个模块上边距
   *
   * @param blockFirstTopMargin markdown第一个模块上边距 - 默认8.0vp
   */
  setBlockFirstTopMargin(blockFirstTopMargin: number): void

  /**
   * 设置markdown最后一个模块下边距
   *
   * @param blockLastBottomMargin markdown最后一个模块下边距 - 默认8.0vp
   */
  setBlockLastBottomMargin(blockLastBottomMargin: number): void

  /**
   * 设置模块间上下间距
   *
   * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
   */
  setBlockTopAndBottomMargins(blockTopAndBottomMargins: number): void

  /**
   * 设置链接是否是图片显示
   *
   * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   */
  setIsLinkStyle(isLinkStyle: boolean): void

  /**
   * 设置列表中的单行链接是否是图片显示
   *
   * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   */
  setIsListLinkStyle(isListLinkStyle: boolean): void

  /**
   * 设置文本格式链接文本颜色
   *
   * @param linkColor 文本格式链接文本颜色 - 默认0XFF0000FF
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
   */
  setLinkSize(linkSize: number): void
  
  /**
   * 设置文本格式链接文字行高
   *
   * @param linkLineHeight 文本格式链接文字行高
   */
  setLinkLineHeight(linkLineHeight: number): void
  
  /**
   * 设置文本格式链接背景颜色
   *
   * @param linkBackGroupColor 文本格式链接背景颜色 - 默认0XFF000000
   */
  setLinkBackGroupColor(linkBackGroupColor: number): void

  /**
   * 设置文本格式是否显示链接下划线
   *
   * @param isLinkUnderlined 文本格式是否显示链接下划线 - true：显示下划线；false：不显示下划线。默认true
   */
  setIsLinkUnderlined(isLinkUnderlined: boolean): void

  /**
   * 设置圆形图片格式链接主题背景颜色
   *
   * @param linkCircleImageBackGroupColor 圆形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   */
  setLinkCircleImageBackGroupColor(linkCircleImageBackGroupColor: number): void

  /**
   * 设置圆形图片格式链接控件背景颜色
   *
   * @param linkCircleImageButtonBackGroupColor 圆形图片格式链接控件背景颜色 - 默认0XFF000000
   */
  setLinkCircleImageButtonBackGroupColor(linkCircleImageButtonBackGroupColor: number): void

  /**
   * 设置圆形图片格式链接文字大小
   *
   * @param linkCircleImageTextSize 圆形图片格式链接文字大小 - 默认14.0fp
   */
  setLinkCircleImageTextSize(linkCircleImageTextSize: number): void

  /**
   * 设置圆形图片格式链接文字颜色
   *
   * @param linkCircleImageTextColor 圆形图片格式链接文字颜色 - 默认0XFFFFFFFF
   */
  setLinkCircleImageTextColor(linkCircleImageTextColor: number): void

  /**
   * 设置圆形图片格式链接半径
   *
   * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
   */
  setLinkCircleImageRadius(linkCircleImageRadius: number): void

  /**
   * 设置圆形图片格式链接左右外边距
   *
   * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
   */
  setLinkCircleImageMargin(linkCircleImageMargin: number): void

  /**
   * 设置圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectImageBackGroupColor 圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   */
  setLinkRectImageBackGroupColor(linkRectImageBackGroupColor: number): void

  /**
   * 设置圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectImageButtonBackGroupColor 圆角矩形图片格式链接控件背景颜色 - 默认0XFF000000
   */
  setLinkRectImageButtonBackGroupColor(linkRectImageButtonBackGroupColor: number): void

  /**
   * 圆角矩形图片格式链接文字大小
   *
   * @param linkRectImageTextSize 圆角矩形图片格式链接文字大小 - 默认14.0fp
   */
  setLinkRectImageTextSize(linkRectImageTextSize: number): void

  /**
   * 设置圆角矩形图片格式链接文字颜色
   *
   * @param linkRectImageTextColor 圆角矩形图片格式链接文字颜色 - 默认0XFFFFFFFF
   */
  setLinkRectImageTextColor(linkRectImageTextColor: number): void

  /**
   * 圆角矩形图片格式链接控件高度
   *
   * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
   */
  setLinkRectImageHeight(linkRectImageHeight: number): void

  /**
   * 圆角矩形图片格式链接左右内边距
   *
   * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
   */
  setLinkRectImagePadding(linkRectImagePadding: number): void

  /**
   * 圆角矩形图片格式链接圆角半径
   *
   * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
   */
  setLinkRectImageRadius(linkRectImageRadius: number): void

  /**
   * 圆角矩形图片格式链接左右外边距
   *
   * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
   */
  setLinkRectImageMargin(linkRectImageMargin: number): void

  /**
   * 设置空心圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectToolImageBackGroupColor 空心圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   */
  setLinkRectToolImageBackGroupColor(linkRectToolImageBackGroupColor: number): void

  /**
   * 设置空心圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectToolImageButtonBackGroupColor 空心圆角矩形图片格式链接控件背景颜色 - 默认OXFFFFFFFF
   */
  setLinkRectToolImageButtonBackGroupColor(linkRectToolImageButtonBackGroupColor: number): void

  /**
   * 设置空心圆角矩形图片格式链接文字大小
   *
   * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文字大小 - 默认14.0fp
   */
  setLinkRectToolImageTextSize(linkRectToolImageTextSize: number): void

  /**
   * 设置空心圆角矩形图片格式链接控件高度
   *
   * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
   */
  setLinkRectToolImageHeight(linkRectToolImageHeight: number): void

  /**
   * 设置空心圆角矩形图片格式链接左右内边距
   *
   * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
   */
  setLinkRectToolImagePadding(linkRectToolImagePadding: number): void

  /**
   * 设置空心圆角矩形图片格式链接边框宽度
   *
   * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
   */
  setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: number): void

  /**
   * 设置空心圆角矩形图片格式链接分割线宽度
   *
   * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
   */
  setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: number): void

  /**
   * 设置空心圆角矩形图片格式链接左右外边距
   *
   * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
   */
  setLinkRectToolImageMargin(linkRectToolImageMargin: number): void

  /**
   * 设置空心圆角矩形图片格式分割线和文本左边距
   *
   * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
   */
  setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: number): void

  /**
   * 设置空心圆角矩形图片格式分割线和文本右边距
   *
   * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
   */
  setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: number): void

  /**
   * 设置块引用左边距
   *
   * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
   */
  setBlockQuoteLeftMargin(blockQuoteLeftMargin: number): void

  /**
   * 设置块引用右边距
   *
   * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
   */
  setBlockQuoteRightMargin(blockQuoteRightMargin: number): void

  /**
   * 设置块引用左边线条宽度
   *
   * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
   */
  setBlockQuoteWidth(blockQuoteWidth: number): void

  /**
   * 设置块引用左边线条颜色
   *
   * @param blockQuoteColor 块引用左边线条颜色 - 默认0XFF191919
   */
  setBlockQuoteColor(blockQuoteColor: number): void

  /**
   * 设置块引用背景颜色
   *
   * @param blockQuoteBackGroupColor 块引用背景颜色 - 默认0XFFEAEAEA
   */
  setBlockQuoteBackGroupColor(blockQuoteBackGroupColor: number): void

  /**
   * 设置块引用子模块上下间距
   *
   * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
   */
  setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: number): void

  /**
   * 设置有序列表、无序列表、任务列表子模块上下间距
   *
   * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
   */
  setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: number): void

  /**
   * 设置有序列表、无序列表、任务列表左边距
   *
   * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
   */
  setBlockLeftMargin(blockLeftMargin: number): void

  /**
   * 设置有序列表、无序列表、任务列表右边距
   *
   * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
   */
  setBlockRightMargin(blockRightMargin: number): void

  /**
   * 设置有序列表前缀文本是否加粗
   *
   * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true：加粗；false：不加粗。默认false
   */
  setOrderedListItemPrefixBold(orderedListItemPrefixBold: boolean): void

  /**
   * 设置有序列表前缀文本颜色
   *
   * @param orderedListItemColor 有序列表前缀文本颜色 - 默认OXFF191919
   */
  setOrderedListItemColor(orderedListItemColor: number): void

  /**
   * 设置有序列表前缀文本大小
   *
   * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
   */
  setOrderedListItemSize(orderedListItemSize: number): void

  /**
   * 设置有序列表前缀文本行高
   *
   * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
   */
  setOrderedListItemLineHeight(orderedListItemLineHeight: number): void

  /**
   * 设置无序列表前缀是否全部是实心圆型
   *
   * @param orderedListItemLineHeight 无序列表前缀是否全部是实心圆型 - 默认false
   */
  setBulletListItemCircle(bulletListItemCircle: boolean): void

  /**
   * 设置无序列表前缀文本颜色
   *
   * @param bulletListItemColor 无序列表前缀文本颜色 - 默认OXFF191919
   */
  setBulletListItemColor(bulletListItemColor: number): void

  /**
   * 设置无序列表前缀文本大小
   *
   * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
   */
  setBulletListItemSize(bulletListItemSize: number): void

  /**
   * 设置无序列表前缀文本行高
   *
   * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
   */
  setBulletListItemLineHeight(bulletListItemLineHeight: number): void

  /**
   * 设置任务列表选择框宽高
   *
   * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
   */
  setTaskListItemLength(taskListItemLength: number): void

  /**
   * 设置是否格式化代码块内容
   *
   * @param isCodeFormat 是否格式化代码块内容 - true：格式化代码块内容；false：不格式化代码块内容。默认false
   */
  setIsCodeFormat(isCodeFormat: boolean): void

  /**
   * 设置内联代码文本颜色
   *
   * @param codeTextColor 内联代码文本颜色 - 默认OXFF000000
   */
  setCodeTextColor(codeTextColor: number): void

  /**
   * 设置内联代码背景颜色
   *
   * @param codeBackgroundColor 内联代码背景颜色 - 默认OXFFEAEAEA
   */
  setCodeBackgroundColor(codeBackgroundColor: number): void

  /**
   * 设置内联代码文本大小
   *
   * @param codeTextSize 内联代码文本大小 - 默认13.0fp
   */
  setCodeTextSize(codeTextSize: number): void

  /**
   * 设置内联代码文本字体
   *
   * @param codeTypeface 内联代码文本字体 - 默认"HarmonyOS Sans"
   */
  setCodeTypeface(codeTypeface: string): void

  /**
   * 设置围栏代码块代码高亮是否同步解析
   *
   * @param isCodeBlockParserSync 围栏代码块代码高亮是否同步解析 - 默认false
   */
  setIsCodeBlockParserSync(isCodeBlockParserSync: boolean): void

  /**
   * 设置代码块代码文本颜色
   *
   * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
   */
  setCodeBlockTextColor(codeBlockTextColor: number): void

  /**
   * 设置代码块代码类型文本颜色
   *
   * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
   */
  setCodeBlockTypeTextColor(codeBlockTypeTextColor: number): void

  /**
   * 设置代码块代码类型文本
   *
   * @param codeBlockTypeTextStr 代码块代码类型文本 - 默认""
   */
  setCodeBlockTypeTextStr(codeBlockTypeTextStr: string): void

  /**
   * 设置代码类型和代码块距离
   *
   * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
   */
  setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: number): void

  /**
   * 设置代码块复制、全屏图片文字是否显示
   *
   * @param codeBlockIconTextHide 代码块复制、全屏图片文字是否显示 - true：显示；false：不显示。默认true
   */
  setCodeBlockIconTextHide(codeBlockIconTextHide: boolean): void

  /**
   * 设置代码块代码行号是否显示
   *
   * @param codeBlockLineNumberHide 代码块代码行号是否显示 - true：显示；false：不显示。默认true
   */
  setCodeBlockLineNumberHide(codeBlockLineNumberHide: boolean): void

  /**
   * 设置代码块背景颜色
   *
   * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
   */
  setCodeBlockBackgroundColor(codeBlockBackgroundColor: number): void

  /**
   * 设置代码块左边距
   *
   * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
   */
  setCodeMultilineMargin(codeMultilineMargin: number): void

  /**
   * 设置代码块字体
   *
   * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
   */
  setCodeBlockTypeface(codeBlockTypeface: string): void

  /**
   * 设置代码块代码文本大小
   *
   * @param codeBlockTextSize 代码块代码文本大小 -  默认13.0fp
   */
  setCodeBlockTextSize(codeBlockTextSize: number): void

  /**
   * 设置代码块代码文本行高
   *
   * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
   */
  setCodeBlockLineHeight(codeBlockLineHeight: number): void

  /**
   * 设置代码块控件圆角大小
   *
   * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
   */
  setCodeBlockRadius(codeBlockRadius: number): void

  /**
   * 设置代码块代码全屏按钮是否显示
   *
   * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true：显示；false：不显示。默认true
   */
  setIsCodeFullScreen(isCodeFullScreen: boolean): void

  /**
   * 设置代码块代码全屏、代码复制按钮宽高
   *
   * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
   */
  setIconWidthAndHeight(iconWidthAndHeight: number): void

  /**
   * 设置组合代码未选中标题字体大小
   *
   * @param codeListTitleTextSize 组合代码未选中标题字体大小 - 默认13.0fp
   */
  setCodeListTitleTextSize(codeListTitleTextSize: number): void

  /**
   * 设置组合代码选中标题字体大小
   *
   * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
   */
  setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: number): void

  /**
   * 设置组合代码选中标题文本颜色
   *
   * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认Color.RED
   */
  setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: number): void

  /**
   * 设置组合代码未选中标题文本颜色
   *
   * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认Color.BLACK
   */
  setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: number): void

  /**
   * 设置组合代码选中标题背景颜色
   *
   * @param codeListTitleSelectBackGroupColor 组合代码选中标题背景颜色 - 默认Color.GRAY
   */
  setCodeListTitleSelectBackGroupColor(codeListTitleSelectBackGroupColor: number): void

  /**
   * 设置组合代码未选中标题背景颜色
   *
   * @param codeListTitleUnSelectBackGroupColor 组合代码未选中标题背景颜色 - 默认Color.TRANSPARENT
   */
  setCodeListTitleUnSelectBackGroupColor(codeListTitleUnSelectBackGroupColor: number): void

  /**
   * 设置是否单独代码块显示
   *
   * @param isSeparateCodeBlock 是否单独代码块显示 - true：显示；false：不显示。默认false
   */
  setIsSeparateCodeBlock(isSeparateCodeBlock: boolean): void

  /**
   * 设置单独代码块行号宽度
   *
   * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
   */
  setSeparateCodeBlockWidth(separateCodeBlockWidth: number): void

  /**
   * 设置单独代码块是否居底显示
   *
   * @param separateCodeIsBottom 单独代码块是否居底显示 - 默认false
   */
  setSeparateCodeIsBottom(separateCodeIsBottom: boolean): void

  /**
   * 设置H1、H2标题下分割线高度
   *
   * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
   */
  setHeadingBreakHeight(headingBreakHeight: number): void

  /**
   * 设置标题文本字体
   *
   * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
   */
  setHeadingTypeface(headingTypeface: string): void

  /**
   * 设置标题模块上间距
   *
   * @param headingTopMargins 标题模块上间距 - 默认8.0
   */
  setHeadingTopMargins(headingTopMargins: number): void

  /**
   * 设置标题模块下间距
   *
   * @param headingBottomMargins 标题模块下间距 - 默认8.0
   */
  setHeadingBottomMargins(headingBottomMargins: number): void

  /**
   * 设置一级标题文本大小
   *
   * @param headingTextSize1 一级标题文本大小 - 默认20.0
   */
  setHeadingTextSize1(headingTextSize1: number): void 

  /**
   * 设置二级标题文本大小
   *
   * @param headingTextSize2 二级标题文本大小 - 默认17.0
   */
  setHeadingTextSize2(headingTextSize2: number): void 

  /**
   * 设置三级标题文本大小
   *
   * @param headingTextSize3 三级标题文本大小 - 默认16.0
   */
  setHeadingTextSize3(headingTextSize3: number): void 

  /**
   * 设置四级标题文本大小
   *
   * @param headingTextSize4 四级标题文本大小 - 默认15.0
   */
  setHeadingTextSize4(headingTextSize4: number): void 

  /**
   * 设置五级标题文本大小
   *
   * @param headingTextSize5 五级标题文本大小 - 默认15.0
   */
  setHeadingTextSize5(headingTextSize5: number): void 

  /**
   * 设置六级标题文本大小
   *
   * @param headingTextSize6 六级标题文本大小 - 默认13.0
   */
  setHeadingTextSize6(headingTextSize6: number): void 

  /**
   * 设置一级标题文本颜色
   *
   * @param headingTextColor1 标题文本颜色
   */
  setHeadingTextColor1(headingTextColor1: number): void 
  
  /**
   * 设置H1标题下分割线颜色
   *
   * @param headingBreakColor1 H1标题下分割线颜色 - 默认0XFF191919
   */
  setHeadingBreakColor1(headingBreakColor1: number): void

  /**
   * 设置二级标题文本颜色
   *
   * @param headingTextColor2 标题文本颜色
   */
  setHeadingTextColor2(headingTextColor2: number): void 
  
  /**
   * 设置H2标题下分割线颜色
   *
   * @param headingBreakColor2 H2标题下分割线颜色 - 默认0XFF191919
   */
  setHeadingBreakColor2(headingBreakColor2: number): void

  /**
   * 设置三级标题文本颜色
   *
   * @param headingTextColor3 标题文本颜色
   */
  setHeadingTextColor3(headingTextColor3: number): void 

  /**
   * 设置四级标题文本颜色
   *
   * @param headingTextColor4 标题文本颜色
   */
  setHeadingTextColor4(headingTextColor4: number): void {
    this.headingTextColor4 = headingTextColor4
  }

  /**
   * 设置五级标题文本颜色
   *
   * @param headingTextColor5 标题文本颜色
   */
  setHeadingTextColor5(headingTextColor5: number): void 

  /**
   * 设置六级标题文本颜色
   *
   * @param headingTextColor6 标题文本颜色
   */
  setHeadingTextColor6(headingTextColor6: number): void 

  /**
   * 设置标题文本字间距
   *
   * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
   */
  setHeadingTextWordSpace(headingTextWordSpace: number): void

  /**
   * 设置一级标题文本行高
   *
   * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight1(headingTextLineHeight1: number): void

  /**
   * 设置二级标题文本行高
   *
   * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight2(headingTextLineHeight2: number): void

  /**
   * 设置三级标题文本行高
   *
   * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight3(headingTextLineHeight3: number): void

  /**
   * 设置四级标题文本行高
   *
   * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight4(headingTextLineHeight4: number): void

  /**
   * 设置五级标题文本行高
   *
   * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight5(headingTextLineHeight5: number): void

  /**
   * 设置六级标题文本行高
   *
   * @param headingTextLineHeight6 六级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight6(headingTextLineHeight6: number): void

  /**
   * 设置段落模块上间距
   *
   * @param paragraphTopMargins 段落模块上间距 - 默认8.0vp
   */
  setParagraphTopMargins(paragraphTopMargins: number): void

  /**
   * 设置段落模块下间距
   *
   * @param paragraphBottomMargins 段落模块下间距 - 默认8.0vp
   */
  setParagraphBottomMargins(paragraphBottomMargins: number): void

  /**
   * 设置段落文本大小
   *
   * @param paragraphTextSize 段落文本大小 - 默认14.0fp
   */
  setParagraphTextSize(paragraphTextSize: number): void

  /**
   * 设置段落文本颜色
   *
   * @param paragraphTextColor 段落文本颜色 - 默认0XFF191919
   */
  setParagraphTextColor(paragraphTextColor: number): void

  /**
   * 设置段落文本字间距
   *
   * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
   */
  setParagraphTextWordSpace(paragraphTextWordSpace: number): void

  /**
   * 设置段落文本行高
   *
   * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
   */
  setParagraphTextLineHeight(paragraphTextLineHeight: number): void

  /**
   * 设置段落文本字体
   *
   * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
   */
  setParagraphTypeface(paragraphTypeface: string): void

  /**
   * 设置分割线颜色
   *
   * @param thematicBreakColor 分割线颜色 - 默认0XFF191919
   */
  setThematicBreakColor(thematicBreakColor: number): void

  /**
   * 设置分割线高度
   *
   * @param thematicBreakHeight 分割线高度 - 默认0.5vp
   */
  setThematicBreakHeight(thematicBreakHeight: number): void

  /**
   * 设置分割线上部外边距
   *
   * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
   */
  setThematicBreakTopMargin(thematicBreakTopMargin: number): void

  /**
   * 设置分割线下部外边距
   *
   * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
   */
  setThematicBreakBottomMargin(thematicBreakBottomMargin: number): void

  /**
   * 设置软换行是否换行
   *
   * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
   */
  setIsLineBreak(isLineBreak: boolean): void

  /**
   * 设置数学公式未加载状态是否显示文字
   *
   * @param latexDefaultText 数学公式未加载状态是否显示文字 - 默认true
   */
  setLatexDefaultText(latexDefaultText: boolean): void

  /**
   * 设置数学公式文本大小
   *
   * @param latexMathTextSize 数学公式文本大小 - 默认16.0fp
   */
  setLatexMathTextSize(latexMathTextSize: number): void

  /**
   * 设置数学公式背景色
   *
   * @param latexMathBackGroupColor 数学公式背景色 - 默认Color.TRANSPARENT
   */
  setLatexMathBackGroupColor(latexMathBackGroupColor: number): void

  /**
   * 设置数学公式文本颜色
   *
   * @param latexMathTextColor 数学公式文本颜色 - 默认0xFF000000
   */
  setLatexMathTextColor(latexMathTextColor: number): void

  /**
   * 设置数学公式生成图片格式
   *
   * @param latexMathColorFormat 数学公式生成图片格式 - 默认LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
   */
  setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): void

  /**
   * 设置块结构的数学公式是否居中
   *
   * @param latexMathBlockCenter 块结构的数学公式是否居中 - true：居中；false：不居中。默认false
   */
  setLatexMathBlockCenter(latexMathBlockCenter: boolean): void

  /**
   * 设置数学公式字体路径
   *
   * @param latexMathResStr 数学公式字体路径 默认 "/data/storage/el1/bundle/entry/resources/resfile/res"
   */
  setLatexMathResStr(latexMathResStr: string): void

  /**
   * 设置音频阴影颜色值
   *
   * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
   */
  setAudioShadowColor(audioShadowColor: number): void

  /**
   * 设置音频边框颜色
   *
   * @param audioBorderColor 音频边框颜色 - 默认0x33000000
   */
  setAudioBorderColor(audioBorderColor: number): void

  /**
   * 设置音频边框粗细
   *
   * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
   */
  setAudioBorderWidth(audioBorderWidth: number): void

  /**
   * 设置音频边框圆角
   *
   * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
   */
  setAudioBorderRadius(audioBorderRadius: number): void

  /**
   * 设置音频按钮背景颜色
   *
   * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认Color.BLACK
   */
  setAudioButtonBackgroundColor(audioButtonBackgroundColor: number): void

  /**
   * 设置音频按钮文字颜色
   *
   * @param audioButtonTextColor 音频按钮文字颜色 - 默认Color.WHITE
   */
  setAudioButtonTextColor(audioButtonTextColor: number): void

  /**
   * 设置音频按钮文字大小
   *
   * @param audioButtonTextSize 音频按钮文字大小 - 默认14.0fp
   */
  setAudioButtonTextSize(audioButtonTextSize: number): void

  /**
   * 设置音频按钮文字内容
   *
   * @param audioButtonText 音频按钮文字内容 - 默认"立即播放"
   */
  setAudioButtonText(audioButtonText: string): void

  /**
   * 设置音频按钮圆角
   *
   * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
   */
  setAudioButtonBorderRadius(audioButtonBorderRadius: number): void

  /**
   * 设置音频标题文字大小
   *
   * @param audioTitleTextSize 音频标题文字大小 - 默认15.0fp
   */
  setAudioTitleTextSize(audioTitleTextSize: number): void

  /**
   * 设置音频标题文字颜色
   *
   * @param audioTitleTextColor音频标题文字颜色 - 默认Color.BLACK
   */
  setAudioTitleTextColor(audioTitleTextColor: number): void

  /**
   * 设置音频标题文字行高
   *
   * @param audioTitleTextLineHeight 音频标题文字行高 - 默认20.0vp
   */
  setAudioTitleTextLineHeight(audioTitleTextLineHeight: number): void

  /**
   * 设置音频类型文字大小
   *
   * @param audioTypeTextSize 音频类型文字大小 - 默认11.0fp
   */
  setAudioTypeTextSize(audioTypeTextSize: number): void

  /**
   * 设置音频类型文字颜色
   *
   * @param audioTypeTextColor 音频类型文字颜色 - 默认0X80000000
   */
  setAudioTypeTextColor(audioTypeTextColor: number): void

  /**
   * 设置音频类型文字行高
   *
   * @param audioTypeTextLineHeight 音频类型文字行高 - 默认15.0vp
   */
  setAudioTypeTextLineHeight(audioTypeTextLineHeight: number): void

  /**
   * 设置音频上边距
   *
   * @param audioMarginTop 音频上边距 - 默认10.0vp
   */
  setAudioMarginTop(audioMarginTop: number): void

  /**
   * 设置音频下边距
   *
   * @param audioMarginBottom 音频下边距 - 默认10.0vp
   */
  setAudioMarginBottom(audioMarginBottom: number): void

  /**
   * 设置视频圆角
   *
   * @param videoBorderRadius 视频圆角 - 默认10.0vp
   */
  setVideoBorderRadius(videoBorderRadius: number): void

  /**
   * 设置视频时间文本颜色
   *
   * @param videoTimeTextColor 视频时间文本颜色 - 默认Color.WHITE
   */
  setVideoTimeTextColor(videoTimeTextColor: number): void

  /**
   * 设置视频时间文本大小
   *
   * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
   */
  setVideoTimeTextSize(videoTimeTextSize: number): void

  /**
   * 设置视频时间文本居右边距
   *
   * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
   */
  setVideoTimeTextMarginRight(videoTimeTextMarginRight: number): void

  /**
   * 设置视频时间文本居底边距
   *
   * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
   */
  setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: number): void

  /**
   * 设置视频上边距
   *
   * @param videoMarginTop 视频上边距 - 默认10.0vp
   */
  setVideoMarginTop(videoMarginTop: number): void

  /**
   * 设置视频下边距
   *
   * @param videoMarginBottom 视频下边距 - 默认10.0vp
   */
  setVideoMarginBottom(videoMarginBottom: number): void

  /**
   * 设置视频发布/下载按钮布局是否显示
   *
   * @param isVideoBottomLayout 视频发布/下载按钮布局是否显示 - 默认false不显示
   */
  setIsVideoBottomLayout(isVideoBottomLayout: boolean): void

  /**
   * 设置视频发布按钮图片宽度和高度
   *
   * @param videoReleaseImageWidthHeight 视频发布按钮图片宽度和高度 - 默认18.0vp
   */
  setVideoReleaseImageWidthHeight(videoReleaseImageWidthHeight: number): void

  /**
   * 设置视频发布按钮宽度
   *
   * @param videoReleaseWidth 视频发布按钮宽度 - 默认144.0vp
   */
  setVideoReleaseWidth(videoReleaseWidth: number): void

  /**
   * 设置视频发布按钮高度
   *
   * @param videoReleaseHeight 视频发布按钮高度 - 默认44.0vp
   */
  setVideoReleaseHeight(videoReleaseHeight: number): void

  /**
   * 设置视频发布按钮圆角
   *
   * @param videoReleaseRadius 视频发布按钮圆角 - 默认22.0vp
   */
  setVideoReleaseRadius(videoReleaseRadius: number): void

  /**
   * 设置视频发布按钮文本内容
   *
   * @param videoReleaseText 视频发布按钮文本内容 - 默认"发布视频"
   */
  setVideoReleaseText(videoReleaseText: string): void

  /**
   * 设置视频发布按钮文本大小
   *
   * @param videoReleaseTexSize 视频发布按钮文本大小 - 默认16.0vp
   */
  setVideoReleaseTexSize(videoReleaseTexSize: number): void

  /**
   * 设置视频发布按钮文本颜色
   *
   * @param videoReleaseTexColor 视频发布按钮文本颜色 - 默认0xE6000000
   */
  setVideoReleaseTexColor(videoReleaseTexColor: number): void

  /**
   * 设置视频发布按钮背景颜色
   *
   * @param videoReleaseBackgroundColor 视频发布按钮背景颜色 - 默认0xFFF5F5F5
   */
  setVideoReleaseBackgroundColor(videoReleaseBackgroundColor: number): void

  /**
   * 设置视频下载按钮图片宽度和高度
   *
   * @param videoDownloadImageWidthHeight 视频下载按钮图片宽度和高度 - 默认18.0vp
   */
  setVideoDownloadImageWidthHeight(videoDownloadImageWidthHeight: number): void

  /**
   * 设置视频下载按钮宽度
   *
   * @param videoDownloadWidth 视频下载按钮宽度 - 默认144.0vp
   */
  setVideoDownloadWidth(videoDownloadWidth: number): void

  /**
   * 设置视频下载按钮高度
   *
   * @param videoDownloadHeight 视频下载按钮高度 - 默认44.0vp
   */
  setVideoDownloadHeight(videoDownloadHeight: number): void

  /**
   * 设置视频下载按钮圆角
   *
   * @param videoDownloadRadius 视频下载按钮圆角 - 默认22.0vp
   */
  setVideoDownloadRadius(videoDownloadRadius: number): void

  /**
   * 设置视频下载按钮文本内容
   *
   * @param videoDownloadText 视频下载按钮文本内容 - 默认"下载视频"
   */
  setVideoDownloadText(videoDownloadText: string): void

  /**
   * 设置视频下载按钮文本大小
   *
   * @param videoDownloadTexSize 视频下载按钮文本大小 - 默认16.0vp
   */
  setVideoDownloadTexSize(videoDownloadTexSize: number): void

  /**
   * 设置视频下载按钮文本颜色
   *
   * @param videoDownloadTexColor 视频下载按钮文本颜色 - 默认0xE6000000
   */
  setVideoDownloadTexColor(videoDownloadTexColor: number): void

  /**
   * 设置视频下载按钮背景颜色
   *
   * @param videoDownloadBackgroundColor 视频下载按钮背景颜色 - 默认0xFFF5F5F5
   */
  setVideoDownloadBackgroundColor(videoDownloadBackgroundColor: number): void

  /**
   * 设置图片缩放类型
   *
   * @param imageFitType 图片缩放类型 - 默认ImageFit.Contain
   */
  setImageFitType(imageFitType: ImageFitType): void

  /**
   * 设置图片基于自身宽度缩放百分比
   *
   * @param imageMaximumWidth 图片基于自身宽度缩放百分比 - 默认1.0
   */
  setImageMaximumWidth(imageMaximumWidth: number): void

  /**
   * 设置图片基于父布局宽度缩放百分比
   *
   * @param imageFixedRatioWidth 图片基于父布局宽度缩放百分比 - 默认None
   */
  setImageFixedRatioWidth(imageFixedRatioWidth: number): void

  /**
   * 设置图片最大高度
   *
   * @param imageMaxHeight 图片最大高度 - 默认None
   */
  setImageMaxHeight(imageMaxHeight: number): void

  /**
   * 设置图片圆角大小
   *
   * @param imageBorderRadius 图片圆角大小 - 默认0.0vp
   */
  setImageBorderRadius(imageBorderRadius: number): void

  /**
   * 设置网络图片是否压缩
   *
   * @param isAutoResize 网络图片是否压缩 - true：压缩；false：不压缩。默认true
   */
  setIsAutoResize(isAutoResize: boolean): void

  /**
   * 设置图片上边距
   *
   * @param imageMarginTop 图片上边距 - 默认10.0vp
   */
  setImageMarginTop(imageMarginTop: number): void

  /**
   * 设置图片下边距
   *
   * @param imageMarginBottom 图片下边距 - 默认10.0vp
   */
  setImageMarginBottom(imageMarginBottom: number): void

  /**
   * 设置图片是否有下载按钮
   *
   * @param isImageDownload 图片是否有下载按钮 - 默认false
   */
  setIsImageDownload(isImageDownload: boolean): void

  /**
   * 设置是否图文混排
   *
   * @param isImageMixedLayout 是否图文混排 - 默认true
   */
  setIsImageMixedLayout(isImageMixedLayout: boolean): void

  /**
   * 设置图片下载按钮图片宽度和高度
   *
   * @param imageDownloadImageWidthHeight 图片下载按钮图片宽度和高度 - 默认18.0
   */
  setImageDownloadImageWidthHeight(imageDownloadImageWidthHeight: number): void

  /**
   * 设置图片下载按钮宽度
   *
   * @param imageDownloadWidth 图片下载按钮宽度 - 默认296.0
   */
  setImageDownloadWidth(imageDownloadWidth: number): void

  /**
   * 设置图片下载按钮高度
   *
   * @param imageDownloadHeight 图片下载按钮高度 - 默认44.0
   */
  setImageDownloadHeight(imageDownloadHeight: number): void

  /**
   * 设置图片下载按钮圆角
   *
   * @param imageDownloadRadius 图片下载按钮圆角 - 默认22.0
   */
  setImageDownloadRadius(imageDownloadRadius: number): void

  /**
   * 设置图片下载按钮文本内容
   *
   * @param imageDownloadText 图片下载按钮文本内容 - 默认"下载图片"
   */
  setImageDownloadText(imageDownloadText: string): void

  /**
   * 设置图片下载按钮文本大小
   *
   * @param imageDownloadTexSize 图片下载按钮文本大小 - 默认16.0
   */
  setImageDownloadTexSize(imageDownloadTexSize: number): void

  /**
   * 设置图片下载按钮文本颜色
   *
   * @param imageDownloadTexColor 图片下载按钮文本颜色 - 默认0XE6000000
   */
  setImageDownloadTexColor(imageDownloadTexColor: number): void

  /**
   * 设置图片下载按钮背景颜色
   *
   * @param imageDownloadBackgroundColor 图片下载按钮背景颜色 - 默认0XFFF5F5F5
   */
  setImageDownloadBackgroundColor(imageDownloadBackgroundColor: number): void

  /**
   * 设置表格内容内边距
   *
   * @param tableCellPadding 表格内容内边距 - 默认4.0vp
   */
  setTableCellPadding(tableCellPadding: number): void

  /**
   * 设置表格边框颜色
   *
   * @param tableBorderColor 表格边框颜色 - 默认0XFF000000
   */
  setTableBorderColor(tableBorderColor: number): void

  /**
   * 设置表格边框宽度
   *
   * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
   */
  setTableBorderWidth(tableBorderWidth: number): void

  /**
   * 设置表格奇数行背景色
   *
   * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0XFFFFFFFF
   */
  setTableOddRowBackgroundColor(tableOddRowBackgroundColor: number): void

  /**
   * 设置表格偶数行背景色
   *
   * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0XFFE0E0E0
   */
  setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: number): void

  /**
   * 设置表格头背景色
   *
   * @param tableHeaderRowBackgroundColor 表格头背景色 - 默认0XFFFFFFFF
   */
  setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: number): void

  /**
   * 设置表格头文本颜色
   *
   * @param tableTitleTextColor 表格头文本颜色 - 默认0XFF191919
   */
  setTableTitleTextColor(tableTitleTextColor: number): void

  /**
   * 设置表格头文本大小
   *
   * @param tableTitleTextSize 表格头文本大小 - 默认14.0vp
   */
  setTableTitleTextSize(tableTitleTextSize: number): void

  /**
   * 设置表格头文本行高
   *
   * @param tableTitleLineHeight 表格头文本行高 - 默认22.0vp
   */
  setTableTitleLineHeight(tableTitleLineHeight: number): void 
    
  /**
   * 设置表格内容文本颜色
   *
   * @param tableContentTextColor 表格内容文本颜色 - 默认0XFF191919
   */
  setTableContentTextColor(tableContentTextColor: number): void

  /**
   * 设置表格内容文本大小
   *
   * @param tableContentTextSize 表格内容文本大小 - 默认14.0vp
   */
  setTableContentTextSize(tableContentTextSize: number): void

  /**
   * 设置表格内容文本行高
   *
   * @param tableTextLineHeight 表格文本行高 - 默认22.0vp
   */
  setTableTextLineHeight(tableTextLineHeight: number): void

  /**
   * 设置表格圆角
   *
   * @param tableRadius 表格圆角 - 默认5.0vp
   */
  setTableRadius(tableRadius: number): void

  /**
   * 设置表格最小宽度
   *
   * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
   */
  setTableMinTextWidth(tableMinTextWidth: number): void

  /**
   * 设置表格最大宽度
   *
   * @param tableMaxTextWidth 表格最大宽度- 默认300.0vp
   */
  setTableMaxTextWidth(tableMaxTextWidth: number): void

  /**
   * 设置表格第一列是否加粗
   *
   * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
   */
  setTableFirstColumnBold(tableFirstColumnBold: boolean): void
  
  /**
   * 设置表格是否显示滚动条
   *
   * @param tableScrollBarShow 表格是否显示滚动条 - true：显示；false：不显示。默认false
   */
  setTableScrollBarShow(tableScrollBarShow: boolean): void 

  /**
   * 设置表格滚动条颜色
   *
   * @param tableScrollBarColor 表格滚动条颜色
   */
  setTableScrollBarColor(tableScrollBarColor: number): void 
  
  /**
   * 设置代码块深浅色
   *
   * @param isDark 是否是深色 - true：深色；false：浅色。默认false
   */
  setIsDark(isDark: boolean): void

  /**
   * 设置删除线颜色
   *
   * @param strikethroughColor 删除线颜色 - 默认0XFF191919
   */
  setStrikethroughColor(strikethroughColor: number): void

  /**
   * 设置定义列表术语和定义行之间间距
   *
   * @param descListTermAndDefMargins 定义列表定义行缩进 默认8.0
   */
  setDescListTermAndDefMargins(descListTermAndDefMargins: number): void

  /**
   * 设置定义列表定义行缩进
   *
   * @param descListDefIndentation 定义列表定义行缩进 默认8.0
   */
  setDescListDefIndentation(descListDefIndentation: number): void

  /**
   * 设置定义列表定义行间距
   *
   * @param descListDefMargins 定义列表定义行间距 默认8.0
   */
  setDescListDefMargins(descListDefMargins: number): void

  /**
   * 设置下标字体颜色
   *
   * @param subTextColor 下标字体颜色 默认0XFF191919
   */
  setSubTextColor(subTextColor: number): void

  /**
   * 设置下标字体大小
   *
   * @param subTextSize 下标字体大小 默认8.0
   */
  setSubTextSize(subTextSize: number): void

  /**
   * 设置下标偏移距离
   *
   * @param subOffsetDist 下标偏移距离 默认0.0
   */
  setSubOffsetDist(subOffsetDist: number): void

  /**
   * 设置上标字体颜色
   *
   * @param supTextColor 上标字体颜色 默认0XFF191919
   */
  setSupTextColor(supTextColor: number): void

  /**
   * 设置上标字体大小
   *
   * @param supTextSize 上标字体大小 默认8.0
   */
  setSupTextSize(supTextSize: number): void

  /**
   * 设置上标偏移距离
   *
   * @param supOffsetDist 上标偏移距离 默认6.0
   */
  setSupOffsetDist(supOffsetDist: number): void

  /**
   * 设置下划线颜色
   *
   * @param underlineColor 下划线颜色 默认0XFF191919
   */
  setUnderlineColor(underlineColor: number): void
  
  /**
   * 设置下划线样式
   *
   * @param underlineStyle 下划线样式 默认DecorationStyle.Solid
   */
  setUnderlineStyle(underlineStyle: DecorationStyle): void  
}
```

### enum ImageFitType

图片缩放类型的枚举

```ets
/**
 * 图片缩放类型的枚举
 */
export enum ImageFitType {
  /**
   * 保持宽高比进行缩小或者放大，使得图片两边都大于或等于显示边界。
   */
  Contain,
  /**
   * 保持宽高比进行缩小或者放大，使得图片恰好完全显示在显示边界内。
   */
  Cover,
  /**
   * 不保持宽高比进行放大缩小，使得图片充满显示边界。
   */
  Fill
}
```

### enum DecorationStyle

装饰线样式的枚举

```ets
/**
 * 装饰线样式的枚举
 */
export enum DecorationStyle {
  Solid, // 单实线
  Double, // 双实线
  Dotted, // 点线
  Dashed, // 虚线
  Wavy // 波浪线
}
```
### enum LatexMathColorFormat

数学公式生成图片格式的枚举

```ets
/**
 * 数学公式生成图片格式的枚举
 */
export enum LatexMathColorFormat {
  /**
   * 16位
   */
  COLOR_FORMAT_RGB_565,
  /**
   * 32位
   */
  COLOR_FORMAT_BGRA_8888
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
   * @param isEmojiPlugin 是否加载上标解析插件 - true：设置加载上标解析插件件；false：不设置加载上标解析插件。默认false
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
   * 获取内部CJMarkdownScroller实例
   *
   * @returns CJMarkdownScroller实例
   */
  getScroller(): CJMarkdownScroller
}
```
