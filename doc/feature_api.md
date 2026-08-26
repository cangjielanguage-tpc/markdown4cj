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
    * @param config 传入markdown配置选项
    * @param plugin 传入markdown插件化选项
    * @param scroller 列表控制器(ArkUI内置Scroller)
    * @param scrollController 外层滚动控制器(不固定高度模式由页面传入)
    * @param blockImageCardComponent 块级图片的自定义组件
    * @param blockLinkCardComponent 块级链接的自定义组件

    */
    CJMarkdown(
        content: string,
        config: MarkdownConfiguration,
        plugin: MarkdownPlugin,
        blockImageCardComponent: (desc:string, imageSrc:string, title:string) => void,
        blockLinkCardComponent:(desc:string, link:string, title:string) => void
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
  setLinkCallback(cb: (url: string) => void): MarkdownConfiguration

  /**
   * 设置文本复制的点击事件
   *
   * @param cb 文本复制的点击事件(text：复制的文本)
   */
  setTextCopyCallback(cb: (text: string) => void): MarkdownConfiguration

  /**
   * 设置图片点击回调
   *
   * @param cb 图片点击回调。 (url：图片url,urlList:所有图片和视频链接集合 --- 需要加载图片视频列表url集合列表解析插件)
   */
  setImageCallback(cb: (url: string, urlList: Array<string>) => void): MarkdownConfiguration

  /**
   * 设置图片替换事件
   *
   * @deprecated since 1.4.0
   * @useinstead setImageReplaceCallback
   * @param cb 图片替换事件。 (url：图片url 返回值是替换的图片数据)
   * @return MarkdownConfiguration
   */
  setImageCallbackCallback(cb: (url: string) => Promise<ArrayBuffer | undefined>): MarkdownConfiguration

  /**
   * 设置图片下载的点击事件
   *
   * @param cb 图片下载的点击事件。 (url：图片url)
   */
  setImageDownloadCallback(cb: (url: string) => void): MarkdownConfiguration

  /**
   * 设置音频点击回调
   *
   * @param cb 音频点击回调(url：音频url) --- 需要加载音频解析插件
   */
  setAudioCallback(cb: (url: string) => void): MarkdownConfiguration

  /**
   * 设置视频点击回调
   *
   * @param cb 视频点击回调。 (url：视频url,urlList:所有图片和视频链接集合 --- 需要加载图片视频列表url集合列表解析插件) --- 需要加载视频解析插件
   */
  setVideoCallback(cb: (url: string, urlList: Array<string>) => void): MarkdownConfiguration

  /**
   * 设置视频占位图和宽高比和视频时长的回调
   *
   * @param cb 视频占位图和宽高比和视频时长回调。 (url：视频url,coverCallback:视频首帧图回调 (coverUrl:视频首帧图,aspectRatio:图片宽高比,duration:视频时长)) --- 需要加载视频解析插件
   */
  setVideoImageCallback(cb: (url: string, coverCallback: (coverUrl: string, aspectRatio: number, duration: number) => void) => void): MarkdownConfiguration

  /**
   * 设置视频发布的点击事件
   *
   * @param cb 视频发布的点击事件(url：视频url) --- 需要加载视频解析插件
   */
  setVideoReleaseCallback(cb: (url: string) => void): MarkdownConfiguration

  /**
   * 设置视频下载的点击事件
   *
   * @param cb 视频下载的点击事件(url：视频url) --- 需要加载视频解析插件
   */
  setVideoDownloadCallback(cb: (url: string) => void): MarkdownConfiguration

  /**
   * 设置代码复制点击回调
   *
   * @param cb 代码复制点击回调(code：代码内容)
   */
  setCodeCopyCallback(cb: (code: string) => void): MarkdownConfiguration

  /**
   * 设置代码全屏点击回调
   *
   * @param cb 代码全屏点击回调(code：代码内容, language:代码类型)
   */
  setCodeFullScreenCallback(cb: (code: string, language: string | undefined) => void): MarkdownConfiguration

  /**
   * 设置TOC点击回调
   *
   * @param cb TOC点击回调(index：偏移量) --- 需要加载TOC解析插件
   */
  setTocIndexCallback(cb: (index: number | undefined) => void): MarkdownConfiguration

  /**
   * 设置脚注点击回调
   *
   * @param cb 脚注点击回调(index：偏移量) --- 需要加载脚注解析插件
   */
  setFootnoteCallback(cb: (index: number | undefined) => void): MarkdownConfiguration

  /**
   * 自定义长按事件
   *
   * @param cb 自定义长按事件
   */
  setCustomLongPressCallback(cb: (str: string) => void): MarkdownConfiguration
  
  /**
   * 设置markdown样式
   *
   * @param markdownTheme markdown样式
   */
  setMarkdownTheme(markdownTheme: MarkdownTheme): MarkdownConfiguration
  
  /**
   * 获取高亮设置对象
   */
  getMarkdownHighlightParagraph(): MarkdownHighlightParagraph

  /**
   * 设置表格复制的点击事件
   *
   * @param cb 文本复制的点击事件(text：复制的文本)
   */
  setTableCopyCallback(cb: (text: string) => void): MarkdownConfiguration

  /**
   * 设置全局文本对象
   *
   * @param nodeString 全局文本对象
   */
  setNodeString(nodeString: MarkdownNodeViewString): MarkdownConfiguration

  /**
   * 设置段落标题动画开始回调
   *
   * @param cb 段落标题动画开始回调
   * @return MarkdownConfiguration
   */
  setParagraphHeadingAnimationStart(cb: () => void): MarkdownConfiguration

  /**
   * 设置段落标题动画结束回调
   *
   * @param cb 段落标题动画结束回调
   * @return MarkdownConfiguration
   */
  setParagraphHeadingAnimationEnd(cb: () => void): MarkdownConfiguration

  /**
   * 设置元素曝光回调
   *
   * @param cb 元素曝光回调(event：MarkdownExposureEvent曝光事件)
   * @return MarkdownConfiguration
   */
  setElementExposureCallback(cb: (event: MarkdownExposureEvent) => void): MarkdownConfiguration

  /**
   * 设置元素曝光的阈值
   *
   * @param threshold 曝光阈值
   * @return MarkdownConfiguration
   */
  setExposureThreshold(threshold: number): MarkdownConfiguration

  /**
   * 设置图片替换事件
   *
   * @param cb 图片替换事件(url：图片url,返回值是替换的图片数据)
   * @return MarkdownConfiguration
   */
  setImageReplaceCallback(cb: (url: string) => Promise<ArrayBuffer | undefined>): MarkdownConfiguration

  /**
   * 设置数学公式图片点击回调
   *
   * @param cb 数学公式图片点击回调(data：数学公式图片数组内容, height：图片高度, width：图片宽度)
   * @return MarkdownConfiguration
   */
  setLatexImageCallback(cb: (data: ArrayBuffer, height: number, width: number) => void): MarkdownConfiguration

  /**
   * 设置数学公式数据处理回调
   *
   * @param cb 数学公式数据处理回调(str：数学公式内容,返回值是数学公式处理之后的内容)
   * @return MarkdownConfiguration
   */
  setLatexStrCallback(cb: (str: string) => string): MarkdownConfiguration
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
  setContext(context: Context): MarkdownTheme

  /**
   * 设置代码块全屏图片icon
   *
   * @param codeFullScreenIcon 代码块全屏图片icon
   */
  setCodeFullScreenIcon(codeFullScreenIcon: Resource): MarkdownTheme

  /**
   * 设置代码块复制图片icon
   *
   * @param codeCopyIcon 代码块复制图片icon
   */
  setCodeCopyIcon(codeCopyIcon: Resource): MarkdownTheme

  /**
   * 设置音频图片icon
   *
   * @param audioIcon 音频图片icon
   */
  setAudioIcon(audioIcon: Resource): MarkdownTheme

  /**
   * 设置视频默认占位图
   *
   * @param videoImage 视频默认占位图
   */
  setVideoImage(videoImage: Resource): MarkdownTheme

  /**
   * 设置视频播放按钮icon
   *
   * @param playCircleFillIcon 视频播放按钮icon
   */
  setPlayCircleFillIcon(playCircleFillIcon: Resource): MarkdownTheme

  /**
   * 设置banner占位图
   *
   * @param bannerImage banner占位图
   */
  setBannerImage(bannerImage: Resource): MarkdownTheme

  /**
   * 设置图片占位图
   *
   * @param imageResource 图片占位图
   */
  setImageResource(imageResource: Resource): MarkdownTheme

  /**
   * 设置视频发布默认图标
   *
   * @param videoReleaseImage 视频发布默认图标
   */
  setVideoReleaseImage(videoReleaseImage: Resource): MarkdownTheme

  /**
   * 设置视频下载默认图标
   *
   * @param videoDownloadImage 视频下载默认图标
   */
  setVideoDownloadImage(videoDownloadImage: Resource): MarkdownTheme

  /**
   * 设置图片下载默认图标
   *
   * @param imageDownloadImage 图片下载默认图标
   */
  setImageDownloadImage(imageDownloadImage: Resource): MarkdownTheme

  /**
   * 设置markdown是否同步解析
   *
   * @param isMarkdownParserSync markdown是否同步解析 - 默认false
   */
  setIsMarkdownParserSync(isMarkdownParserSync: boolean): MarkdownTheme

  /**
   * 设置是否打开长按复制粘贴
   *
   * @param isOnCopy 是否打开长按复制粘贴 - 默认true
   */
  setIsOnCopy(isOnCopy: boolean): MarkdownTheme

  /**
   * 设置markdown第一个模块上边距
   *
   * @param blockFirstTopMargin markdown第一个模块上边距 - 默认8.0vp
   */
  setBlockFirstTopMargin(blockFirstTopMargin: number): MarkdownTheme

  /**
   * 设置markdown最后一个模块下边距
   *
   * @param blockLastBottomMargin markdown最后一个模块下边距 - 默认8.0vp
   */
  setBlockLastBottomMargin(blockLastBottomMargin: number): MarkdownTheme

  /**
   * 设置模块间上下间距
   *
   * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
   */
  setBlockTopAndBottomMargins(blockTopAndBottomMargins: number): MarkdownTheme

  /**
   * 设置链接是否是图片显示
   *
   * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   */
  setIsLinkStyle(isLinkStyle: boolean): MarkdownTheme

  /**
   * 设置列表中的单行链接是否是图片显示
   *
   * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   */
  setIsListLinkStyle(isListLinkStyle: boolean): MarkdownTheme

  /**
   * 设置文本格式链接文本颜色
   *
   * @param linkColor 文本格式链接文本颜色 - 默认0XFF0000FF
   */
  setLinkColor(linkColor: number): MarkdownTheme

  /**
   * 设置是否按照链接文本字体大小显示文本
   *
   * @param isLinkSize 是否按照链接文本字体大小显示文本 - true：显示链接字体文本大小；false：跟随标题段落大小显示。默认true
   */
  setIsLinkSize(isLinkSize: boolean): MarkdownTheme

  /**
   * 设置文本格式链接文字大小
   *
   * @param linkSize 文本格式链接文字大小 - 默认14.0fp
   */
  setLinkSize(linkSize: number): MarkdownTheme

  /**
   * 设置文本格式链接文字行高
   *
   * @param linkLineHeight 文本格式链接文字行高
   */
  setLinkLineHeight(linkLineHeight: number): MarkdownTheme

  /**
   * 设置文本格式链接背景颜色
   *
   * @param linkBackgroundColor 文本格式链接背景颜色 - 默认0XFF000000
   */
  setLinkBackgroundColor(linkBackgroundColor: number): MarkdownTheme

  /**
   * 设置文本格式是否显示链接下划线
   *
   * @param isLinkUnderlined 文本格式是否显示链接下划线 - true：显示下划线；false：不显示下划线。默认true
   */
  setIsLinkUnderlined(isLinkUnderlined: boolean): MarkdownTheme

  /**
   * 设置圆形图片格式链接主题背景颜色
   *
   * @param linkCircleImageBackgroundColor 圆形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   */
  setLinkCircleImageBackgroundColor(linkCircleImageBackgroundColor: number): MarkdownTheme

  /**
   * 设置圆形图片格式链接控件背景颜色
   *
   * @param linkCircleImageButtonBackgroundColor 圆形图片格式链接控件背景颜色 - 默认0XFF000000
   */
  setLinkCircleImageButtonBackgroundColor(linkCircleImageButtonBackgroundColor: number): MarkdownTheme

  /**
   * 设置圆形图片格式链接文字大小
   *
   * @param linkCircleImageTextSize 圆形图片格式链接文字大小 - 默认14.0fp
   */
  setLinkCircleImageTextSize(linkCircleImageTextSize: number): MarkdownTheme

  /**
   * 设置圆形图片格式链接文字颜色
   *
   * @param linkCircleImageTextColor 圆形图片格式链接文字颜色 - 默认0XFFFFFFFF
   */
  setLinkCircleImageTextColor(linkCircleImageTextColor: number): MarkdownTheme

  /**
   * 设置圆形图片格式链接半径
   *
   * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
   */
  setLinkCircleImageRadius(linkCircleImageRadius: number): MarkdownTheme

  /**
   * 设置圆形图片格式链接左右外边距
   *
   * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
   */
  setLinkCircleImageMargin(linkCircleImageMargin: number): MarkdownTheme

  /**
   * 设置圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectImageBackgroundColor 圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   */
  setLinkRectImageBackgroundColor(linkRectImageBackgroundColor: number): MarkdownTheme

  /**
   * 设置圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectImageButtonBackgroundColor 圆角矩形图片格式链接控件背景颜色 - 默认0XFF000000
   */
  setLinkRectImageButtonBackgroundColor(linkRectImageButtonBackgroundColor: number): MarkdownTheme

  /**
   * 圆角矩形图片格式链接文字大小
   *
   * @param linkRectImageTextSize 圆角矩形图片格式链接文字大小 - 默认14.0fp
   */
  setLinkRectImageTextSize(linkRectImageTextSize: number): MarkdownTheme

  /**
   * 设置圆角矩形图片格式链接文字颜色
   *
   * @param linkRectImageTextColor 圆角矩形图片格式链接文字颜色 - 默认0XFFFFFFFF
   */
  setLinkRectImageTextColor(linkRectImageTextColor: number): MarkdownTheme

  /**
   * 圆角矩形图片格式链接控件高度
   *
   * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
   */
  setLinkRectImageHeight(linkRectImageHeight: number): MarkdownTheme

  /**
   * 圆角矩形图片格式链接左右内边距
   *
   * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
   */
  setLinkRectImagePadding(linkRectImagePadding: number): MarkdownTheme

  /**
   * 圆角矩形图片格式链接圆角半径
   *
   * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
   */
  setLinkRectImageRadius(linkRectImageRadius: number): MarkdownTheme

  /**
   * 圆角矩形图片格式链接左右外边距
   *
   * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
   */
  setLinkRectImageMargin(linkRectImageMargin: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectToolImageBackgroundColor 空心圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   */
  setLinkRectToolImageBackgroundColor(linkRectToolImageBackgroundColor: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectToolImageButtonBackgroundColor 空心圆角矩形图片格式链接控件背景颜色 - 默认0XFFFFFFFF
   */
  setLinkRectToolImageButtonBackgroundColor(linkRectToolImageButtonBackgroundColor: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接文字大小
   *
   * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文字大小 - 默认14.0fp
   */
  setLinkRectToolImageTextSize(linkRectToolImageTextSize: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接控件高度
   *
   * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
   */
  setLinkRectToolImageHeight(linkRectToolImageHeight: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接左右内边距
   *
   * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
   */
  setLinkRectToolImagePadding(linkRectToolImagePadding: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接边框宽度
   *
   * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
   */
  setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接分割线宽度
   *
   * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
   */
  setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接左右外边距
   *
   * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
   */
  setLinkRectToolImageMargin(linkRectToolImageMargin: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式分割线和文本左边距
   *
   * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
   */
  setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式分割线和文本右边距
   *
   * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
   */
  setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: number): MarkdownTheme

  /**
   * 设置块引用左边距
   *
   * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
   */
  setBlockQuoteLeftMargin(blockQuoteLeftMargin: number): MarkdownTheme

  /**
   * 设置块引用右边距
   *
   * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
   */
  setBlockQuoteRightMargin(blockQuoteRightMargin: number): MarkdownTheme

  /**
   * 设置块引用左边线条宽度
   *
   * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
   */
  setBlockQuoteWidth(blockQuoteWidth: number): MarkdownTheme

  /**
   * 设置块引用左边线条颜色
   *
   * @param blockQuoteColor 块引用左边线条颜色 - 默认0XFF191919
   */
  setBlockQuoteColor(blockQuoteColor: number): MarkdownTheme

  /**
   * 设置块引用背景颜色
   *
   * @param blockQuoteBackgroundColor 块引用背景颜色 - 默认0XFFEAEAEA
   */
  setBlockQuoteBackgroundColor(blockQuoteBackgroundColor: number): MarkdownTheme

  /**
   * 设置块引用子模块上下间距
   *
   * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
   */
  setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: number): MarkdownTheme

  /**
   * 设置有序列表、无序列表、任务列表子模块上下间距
   *
   * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
   */
  setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: number): MarkdownTheme

  /**
   * 设置有序列表、无序列表、任务列表左边距
   *
   * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
   */
  setBlockLeftMargin(blockLeftMargin: number): MarkdownTheme

  /**
   * 设置有序列表、无序列表、任务列表右边距
   *
   * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
   */
  setBlockRightMargin(blockRightMargin: number): MarkdownTheme

  /**
   * 设置有序列表前缀文本是否加粗
   *
   * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true：加粗；false：不加粗。默认false
   */
  setOrderedListItemPrefixBold(orderedListItemPrefixBold: boolean): MarkdownTheme

  /**
   * 设置有序列表前缀文本颜色
   *
   * @param orderedListItemColor 有序列表前缀文本颜色 - 默认0XFF191919
   */
  setOrderedListItemColor(orderedListItemColor: number): MarkdownTheme

  /**
   * 设置有序列表前缀文本大小
   *
   * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
   */
  setOrderedListItemSize(orderedListItemSize: number): MarkdownTheme

  /**
   * 设置有序列表前缀文本行高
   *
   * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
   */
  setOrderedListItemLineHeight(orderedListItemLineHeight: number): MarkdownTheme

  /**
   * 设置无序列表前缀是否全部是实心圆型
   *
   * @param bulletListItemCircle 无序列表前缀是否全部是实心圆型 - 默认false
   */
  setBulletListItemCircle(bulletListItemCircle: boolean): MarkdownTheme

  /**
   * 设置无序列表前缀文本颜色
   *
   * @param bulletListItemColor 无序列表前缀文本颜色 - 默认0XFF191919
   */
  setBulletListItemColor(bulletListItemColor: number): MarkdownTheme

  /**
   * 设置无序列表前缀文本大小
   *
   * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
   */
  setBulletListItemSize(bulletListItemSize: number): MarkdownTheme

  /**
   * 设置无序列表前缀文本行高
   *
   * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
   */
  setBulletListItemLineHeight(bulletListItemLineHeight: number): MarkdownTheme

  /**
   * 设置任务列表选择框宽高
   *
   * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
   */
  setTaskListItemLength(taskListItemLength: number): MarkdownTheme

  /**
   * 设置是否格式化代码块内容
   *
   * @param isCodeFormat 是否格式化代码块内容 - true：格式化代码块内容；false：不格式化代码块内容。默认false
   */
  setIsCodeFormat(isCodeFormat: boolean): MarkdownTheme

  /**
   * 设置内联代码文本颜色
   *
   * @param codeTextColor 内联代码文本颜色 - 默认0XFF000000
   */
  setCodeTextColor(codeTextColor: number): MarkdownTheme

  /**
   * 设置内联代码背景颜色
   *
   * @param codeBackgroundColor 内联代码背景颜色 - 默认0XFFEAEAEA
   */
  setCodeBackgroundColor(codeBackgroundColor: number): MarkdownTheme

  /**
   * 设置内联代码文本大小
   *
   * @param codeTextSize 内联代码文本大小 - 默认13.0fp
   */
  setCodeTextSize(codeTextSize: number): MarkdownTheme

  /**
   * 设置内联代码文本字体
   *
   * @param codeTypeface 内联代码文本字体 - 默认"HarmonyOS Sans"
   */
  setCodeTypeface(codeTypeface: string): MarkdownTheme

  /**
   * 设置围栏代码块代码高亮是否同步解析
   *
   * @param isCodeBlockParserSync 围栏代码块代码高亮是否同步解析 - 默认false
   */
  setIsCodeBlockParserSync(isCodeBlockParserSync: boolean): MarkdownTheme

  /**
   * 设置代码块代码文本颜色
   *
   * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
   */
  setCodeBlockTextColor(codeBlockTextColor: number): MarkdownTheme

  /**
   * 设置代码块代码类型文本颜色
   *
   * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
   */
  setCodeBlockTypeTextColor(codeBlockTypeTextColor: number): MarkdownTheme

  /**
   * 设置代码块代码类型文本
   *
   * @param codeBlockTypeTextStr 代码块代码类型文本 - 默认""
   */
  setCodeBlockTypeTextStr(codeBlockTypeTextStr: string): MarkdownTheme

  /**
   * 设置代码类型和代码块距离
   *
   * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
   */
  setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: number): MarkdownTheme

  /**
   * 设置代码块复制、全屏图片文字是否显示
   *
   * @param codeBlockIconTextHide 代码块复制、全屏图片文字是否显示 - true：显示；false：不显示。默认true
   */
  setCodeBlockIconTextHide(codeBlockIconTextHide: boolean): MarkdownTheme

  /**
   * 设置代码块代码行号是否显示
   *
   * @param codeBlockLineNumberHide 代码块代码行号是否显示 - true：显示；false：不显示。默认true
   */
  setCodeBlockLineNumberHide(codeBlockLineNumberHide: boolean): MarkdownTheme

  /**
   * 设置代码块背景颜色
   *
   * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
   */
  setCodeBlockBackgroundColor(codeBlockBackgroundColor: number): MarkdownTheme

  /**
   * 设置代码块左边距
   *
   * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
   */
  setCodeMultilineMargin(codeMultilineMargin: number): MarkdownTheme

  /**
   * 设置代码块字体
   *
   * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
   */
  setCodeBlockTypeface(codeBlockTypeface: string): MarkdownTheme

  /**
   * 设置代码块代码文本大小
   *
   * @param codeBlockTextSize 代码块代码文本大小 -  默认13.0fp
   */
  setCodeBlockTextSize(codeBlockTextSize: number): MarkdownTheme

  /**
   * 设置代码块代码文本行高
   *
   * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
   */
  setCodeBlockLineHeight(codeBlockLineHeight: number): MarkdownTheme

  /**
   * 设置代码块控件圆角大小
   *
   * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
   */
  setCodeBlockRadius(codeBlockRadius: number): MarkdownTheme

  /**
   * 设置代码块代码全屏按钮是否显示
   *
   * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true：显示；false：不显示。默认true
   */
  setIsCodeFullScreen(isCodeFullScreen: boolean): MarkdownTheme

  /**
   * 设置代码块代码全屏、代码复制按钮宽高
   *
   * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
   */
  setIconWidthAndHeight(iconWidthAndHeight: number): MarkdownTheme

  /**
   * 设置组合代码未选中标题字体大小
   *
   * @param codeListTitleTextSize 组合代码未选中标题字体大小 - 默认13.0fp
   */
  setCodeListTitleTextSize(codeListTitleTextSize: number): MarkdownTheme

  /**
   * 设置组合代码选中标题字体大小
   *
   * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
   */
  setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: number): MarkdownTheme

  /**
   * 设置组合代码选中标题文本颜色
   *
   * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认Color.RED
   */
  setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: number): MarkdownTheme

  /**
   * 设置组合代码未选中标题文本颜色
   *
   * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认Color.BLACK
   */
  setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: number): MarkdownTheme

  /**
   * 设置组合代码选中标题背景颜色
   *
   * @param codeListTitleSelectBackgroundColor 组合代码选中标题背景颜色 - 默认Color.GRAY
   */
  setCodeListTitleSelectBackgroundColor(codeListTitleSelectBackgroundColor: number): MarkdownTheme

  /**
   * 设置组合代码未选中标题背景颜色
   *
   * @param codeListTitleUnSelectBackgroundColor 组合代码未选中标题背景颜色 - 默认Color.TRANSPARENT
   */
  setCodeListTitleUnSelectBackgroundColor(codeListTitleUnSelectBackgroundColor: number): MarkdownTheme

  /**
   * 设置是否单独代码块显示
   *
   * @param isSeparateCodeBlock 是否单独代码块显示 - true：显示；false：不显示。默认false
   */
  setIsSeparateCodeBlock(isSeparateCodeBlock: boolean): MarkdownTheme

  /**
   * 设置单独代码块行号宽度
   *
   * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
   */
  setSeparateCodeBlockWidth(separateCodeBlockWidth: number): MarkdownTheme

  /**
   * 设置单独代码块是否居底显示
   *
   * @param separateCodeIsBottom 单独代码块是否居底显示 - 默认false
   */
  setSeparateCodeIsBottom(separateCodeIsBottom: boolean): MarkdownTheme

  /**
   * 设置H1、H2标题下分割线高度
   *
   * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
   */
  setHeadingBreakHeight(headingBreakHeight: number): MarkdownTheme

  /**
   * 设置标题文本字体
   *
   * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
   */
  setHeadingTypeface(headingTypeface: string): MarkdownTheme

  /**
   * 设置标题模块上间距
   *
   * @param headingTopMargins 标题模块上间距 - 默认8.0
   */
  setHeadingTopMargins(headingTopMargins: number): MarkdownTheme

  /**
   * 设置标题模块下间距
   *
   * @param headingBottomMargins 标题模块下间距 - 默认8.0
   */
  setHeadingBottomMargins(headingBottomMargins: number): MarkdownTheme

  /**
   * 设置一级标题文本大小
   *
   * @param headingTextSize1 一级标题文本大小 - 默认20.0
   */
  setHeadingTextSize1(headingTextSize1: number): MarkdownTheme

  /**
   * 设置二级标题文本大小
   *
   * @param headingTextSize2 二级标题文本大小 - 默认17.0
   */
  setHeadingTextSize2(headingTextSize2: number): MarkdownTheme

  /**
   * 设置三级标题文本大小
   *
   * @param headingTextSize3 三级标题文本大小 - 默认16.0
   */
  setHeadingTextSize3(headingTextSize3: number): MarkdownTheme

  /**
   * 设置四级标题文本大小
   *
   * @param headingTextSize4 四级标题文本大小 - 默认15.0
   */
  setHeadingTextSize4(headingTextSize4: number): MarkdownTheme

  /**
   * 设置五级标题文本大小
   *
   * @param headingTextSize5 五级标题文本大小 - 默认15.0
   */
  setHeadingTextSize5(headingTextSize5: number): MarkdownTheme

  /**
   * 设置六级标题文本大小
   *
   * @param headingTextSize6 六级标题文本大小 - 默认13.0
   */
  setHeadingTextSize6(headingTextSize6: number): MarkdownTheme

  /**
   * 设置一级标题文本颜色
   *
   * @param headingTextColor1 标题文本颜色
   */
  setHeadingTextColor1(headingTextColor1: number): MarkdownTheme

  /**
   * 设置H1标题下分割线颜色
   *
   * @param headingBreakColor1 H1标题下分割线颜色 - 默认0XFF191919
   */
  setHeadingBreakColor1(headingBreakColor1: number): MarkdownTheme

  /**
   * 设置二级标题文本颜色
   *
   * @param headingTextColor2 标题文本颜色
   */
  setHeadingTextColor2(headingTextColor2: number): MarkdownTheme

  /**
   * 设置H2标题下分割线颜色
   *
   * @param headingBreakColor2 H2标题下分割线颜色 - 默认0XFF191919
   */
  setHeadingBreakColor2(headingBreakColor2: number): MarkdownTheme

  /**
   * 设置三级标题文本颜色
   *
   * @param headingTextColor3 标题文本颜色
   */
  setHeadingTextColor3(headingTextColor3: number): MarkdownTheme

  /**
   * 设置四级标题文本颜色
   *
   * @param headingTextColor4 标题文本颜色
   */
  setHeadingTextColor4(headingTextColor4: number): MarkdownTheme

  /**
   * 设置五级标题文本颜色
   *
   * @param headingTextColor5 标题文本颜色
   */
  setHeadingTextColor5(headingTextColor5: number): MarkdownTheme

  /**
   * 设置六级标题文本颜色
   *
   * @param headingTextColor6 标题文本颜色
   */
  setHeadingTextColor6(headingTextColor6: number): MarkdownTheme

  /**
   * 设置标题文本字间距
   *
   * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
   */
  setHeadingTextWordSpace(headingTextWordSpace: number): MarkdownTheme

  /**
   * 设置一级标题文本行高
   *
   * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight1(headingTextLineHeight1: number): MarkdownTheme

  /**
   * 设置二级标题文本行高
   *
   * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight2(headingTextLineHeight2: number): MarkdownTheme

  /**
   * 设置三级标题文本行高
   *
   * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight3(headingTextLineHeight3: number): MarkdownTheme

  /**
   * 设置四级标题文本行高
   *
   * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight4(headingTextLineHeight4: number): MarkdownTheme

  /**
   * 设置五级标题文本行高
   *
   * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight5(headingTextLineHeight5: number): MarkdownTheme

  /**
   * 设置六级标题文本行高
   *
   * @param headingTextLineHeight6 六级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight6(headingTextLineHeight6: number): MarkdownTheme

  /**
   * 设置段落模块上间距
   *
   * @param paragraphTopMargins 段落模块上间距 - 默认8.0vp
   */
  setParagraphTopMargins(paragraphTopMargins: number): MarkdownTheme

  /**
   * 设置段落模块下间距
   *
   * @param paragraphBottomMargins 段落模块下间距 - 默认8.0vp
   */
  setParagraphBottomMargins(paragraphBottomMargins: number): MarkdownTheme

  /**
   * 设置段落文本大小
   *
   * @param paragraphTextSize 段落文本大小 - 默认14.0fp
   */
  setParagraphTextSize(paragraphTextSize: number): MarkdownTheme

  /**
   * 设置段落文本颜色
   *
   * @param paragraphTextColor 段落文本颜色 - 默认0XFF191919
   */
  setParagraphTextColor(paragraphTextColor: number): MarkdownTheme

  /**
   * 设置段落文本字间距
   *
   * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
   */
  setParagraphTextWordSpace(paragraphTextWordSpace: number): MarkdownTheme

  /**
   * 设置段落文本行高
   *
   * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
   */
  setParagraphTextLineHeight(paragraphTextLineHeight: number): MarkdownTheme

  /**
   * 设置段落文本字体
   *
   * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
   */
  setParagraphTypeface(paragraphTypeface: string): MarkdownTheme

  /**
   * 设置分割线颜色
   *
   * @param thematicBreakColor 分割线颜色 - 默认0XFF191919
   */
  setThematicBreakColor(thematicBreakColor: number): MarkdownTheme

  /**
   * 设置分割线高度
   *
   * @param thematicBreakHeight 分割线高度 - 默认0.5vp
   */
  setThematicBreakHeight(thematicBreakHeight: number): MarkdownTheme

  /**
   * 设置分割线上部外边距
   *
   * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
   */
  setThematicBreakTopMargin(thematicBreakTopMargin: number): MarkdownTheme

  /**
   * 设置分割线下部外边距
   *
   * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
   */
  setThematicBreakBottomMargin(thematicBreakBottomMargin: number): MarkdownTheme

  /**
   * 设置软换行是否换行
   *
   * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
   */
  setIsLineBreak(isLineBreak: boolean): MarkdownTheme

  /**
   * 设置音频阴影颜色值
   *
   * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
   */
  setAudioShadowColor(audioShadowColor: number): MarkdownTheme

  /**
   * 设置音频边框颜色
   *
   * @param audioBorderColor 音频边框颜色 - 默认0x33000000
   */
  setAudioBorderColor(audioBorderColor: number): MarkdownTheme

  /**
   * 设置音频边框粗细
   *
   * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
   */
  setAudioBorderWidth(audioBorderWidth: number): MarkdownTheme

  /**
   * 设置音频边框圆角
   *
   * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
   */
  setAudioBorderRadius(audioBorderRadius: number): MarkdownTheme

  /**
   * 设置音频按钮背景颜色
   *
   * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认Color.BLACK
   */
  setAudioButtonBackgroundColor(audioButtonBackgroundColor: number): MarkdownTheme

  /**
   * 设置音频按钮文字颜色
   *
   * @param audioButtonTextColor 音频按钮文字颜色 - 默认Color.WHITE
   */
  setAudioButtonTextColor(audioButtonTextColor: number): MarkdownTheme

  /**
   * 设置音频按钮文字大小
   *
   * @param audioButtonTextSize 音频按钮文字大小 - 默认14.0fp
   */
  setAudioButtonTextSize(audioButtonTextSize: number): MarkdownTheme

  /**
   * 设置音频按钮文字内容
   *
   * @param audioButtonText 音频按钮文字内容 - 默认"立即播放"
   */
  setAudioButtonText(audioButtonText: string): MarkdownTheme

  /**
   * 设置音频按钮圆角
   *
   * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
   */
  setAudioButtonBorderRadius(audioButtonBorderRadius: number): MarkdownTheme

  /**
   * 设置音频标题文字大小
   *
   * @param audioTitleTextSize 音频标题文字大小 - 默认15.0fp
   */
  setAudioTitleTextSize(audioTitleTextSize: number): MarkdownTheme

  /**
   * 设置音频标题文字颜色
   *
   * @param audioTitleTextColor 音频标题文字颜色 - 默认Color.BLACK
   */
  setAudioTitleTextColor(audioTitleTextColor: number): MarkdownTheme

  /**
   * 设置音频标题文字行高
   *
   * @param audioTitleTextLineHeight 音频标题文字行高 - 默认20.0vp
   */
  setAudioTitleTextLineHeight(audioTitleTextLineHeight: number): MarkdownTheme

  /**
   * 设置音频类型文字大小
   *
   * @param audioTypeTextSize 音频类型文字大小 - 默认11.0fp
   */
  setAudioTypeTextSize(audioTypeTextSize: number): MarkdownTheme

  /**
   * 设置音频类型文字颜色
   *
   * @param audioTypeTextColor 音频类型文字颜色 - 默认0X80000000
   */
  setAudioTypeTextColor(audioTypeTextColor: number): MarkdownTheme

  /**
   * 设置音频类型文字行高
   *
   * @param audioTypeTextLineHeight 音频类型文字行高 - 默认15.0vp
   */
  setAudioTypeTextLineHeight(audioTypeTextLineHeight: number): MarkdownTheme

  /**
   * 设置音频上边距
   *
   * @param audioMarginTop 音频上边距 - 默认10.0vp
   */
  setAudioMarginTop(audioMarginTop: number): MarkdownTheme

  /**
   * 设置音频下边距
   *
   * @param audioMarginBottom 音频下边距 - 默认10.0vp
   */
  setAudioMarginBottom(audioMarginBottom: number): MarkdownTheme

  /**
   * 设置视频圆角
   *
   * @param videoBorderRadius 视频圆角 - 默认10.0vp
   */
  setVideoBorderRadius(videoBorderRadius: number): MarkdownTheme

  /**
   * 设置视频时间文本颜色
   *
   * @param videoTimeTextColor 视频时间文本颜色 - 默认Color.WHITE
   */
  setVideoTimeTextColor(videoTimeTextColor: number): MarkdownTheme

  /**
   * 设置视频时间文本大小
   *
   * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
   */
  setVideoTimeTextSize(videoTimeTextSize: number): MarkdownTheme

  /**
   * 设置视频时间文本居右边距
   *
   * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
   */
  setVideoTimeTextMarginRight(videoTimeTextMarginRight: number): MarkdownTheme

  /**
   * 设置视频时间文本居底边距
   *
   * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
   */
  setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: number): MarkdownTheme

  /**
   * 设置视频上边距
   *
   * @param videoMarginTop 视频上边距 - 默认10.0vp
   */
  setVideoMarginTop(videoMarginTop: number): MarkdownTheme

  /**
   * 设置视频下边距
   *
   * @param videoMarginBottom 视频下边距 - 默认10.0vp
   */
  setVideoMarginBottom(videoMarginBottom: number): MarkdownTheme

  /**
   * 设置视频发布/下载按钮布局是否显示
   *
   * @param isVideoBottomLayout 视频发布/下载按钮布局是否显示 - 默认false不显示
   */
  setIsVideoBottomLayout(isVideoBottomLayout: boolean): MarkdownTheme

  /**
   * 设置视频发布按钮图片宽度和高度
   *
   * @param videoReleaseImageWidthHeight 视频发布按钮图片宽度和高度 - 默认18.0vp
   */
  setVideoReleaseImageWidthHeight(videoReleaseImageWidthHeight: number): MarkdownTheme

  /**
   * 设置视频发布按钮宽度
   *
   * @param videoReleaseWidth 视频发布按钮宽度 - 默认144.0vp
   */
  setVideoReleaseWidth(videoReleaseWidth: number): MarkdownTheme

  /**
   * 设置视频发布按钮高度
   *
   * @param videoReleaseHeight 视频发布按钮高度 - 默认44.0vp
   */
  setVideoReleaseHeight(videoReleaseHeight: number): MarkdownTheme

  /**
   * 设置视频发布按钮圆角
   *
   * @param videoReleaseRadius 视频发布按钮圆角 - 默认22.0vp
   */
  setVideoReleaseRadius(videoReleaseRadius: number): MarkdownTheme

  /**
   * 设置视频发布按钮文本内容
   *
   * @param videoReleaseText 视频发布按钮文本内容 - 默认"发布视频"
   */
  setVideoReleaseText(videoReleaseText: string): MarkdownTheme

  /**
   * 设置视频发布按钮文本大小
   *
   * @param videoReleaseTextSize 视频发布按钮文本大小 - 默认16.0vp
   */
  setVideoReleaseTextSize(videoReleaseTextSize: number): MarkdownTheme

  /**
   * 设置视频发布按钮文本颜色
   *
   * @param videoReleaseTextColor 视频发布按钮文本颜色 - 默认0xE6000000
   */
  setVideoReleaseTextColor(videoReleaseTextColor: number): MarkdownTheme

  /**
   * 设置视频发布按钮背景颜色
   *
   * @param videoReleaseBackgroundColor 视频发布按钮背景颜色 - 默认0xFFF5F5F5
   */
  setVideoReleaseBackgroundColor(videoReleaseBackgroundColor: number): MarkdownTheme

  /**
   * 设置视频下载按钮图片宽度和高度
   *
   * @param videoDownloadImageWidthHeight 视频下载按钮图片宽度和高度 - 默认18.0vp
   */
  setVideoDownloadImageWidthHeight(videoDownloadImageWidthHeight: number): MarkdownTheme

  /**
   * 设置视频下载按钮宽度
   *
   * @param videoDownloadWidth 视频下载按钮宽度 - 默认144.0vp
   */
  setVideoDownloadWidth(videoDownloadWidth: number): MarkdownTheme

  /**
   * 设置视频下载按钮高度
   *
   * @param videoDownloadHeight 视频下载按钮高度 - 默认44.0vp
   */
  setVideoDownloadHeight(videoDownloadHeight: number): MarkdownTheme

  /**
   * 设置视频下载按钮圆角
   *
   * @param videoDownloadRadius 视频下载按钮圆角 - 默认22.0vp
   */
  setVideoDownloadRadius(videoDownloadRadius: number): MarkdownTheme

  /**
   * 设置视频下载按钮文本内容
   *
   * @param videoDownloadText 视频下载按钮文本内容 - 默认"下载视频"
   */
  setVideoDownloadText(videoDownloadText: string): MarkdownTheme

  /**
   * 设置视频下载按钮文本大小
   *
   * @param videoDownloadTextSize 视频下载按钮文本大小 - 默认16.0vp
   */
  setVideoDownloadTextSize(videoDownloadTextSize: number): MarkdownTheme

  /**
   * 设置视频下载按钮文本颜色
   *
   * @param videoDownloadTextColor 视频下载按钮文本颜色 - 默认0xE6000000
   */
  setVideoDownloadTextColor(videoDownloadTextColor: number): MarkdownTheme

  /**
   * 设置视频下载按钮背景颜色
   *
   * @param videoDownloadBackgroundColor 视频下载按钮背景颜色 - 默认0xFFF5F5F5
   */
  setVideoDownloadBackgroundColor(videoDownloadBackgroundColor: number): MarkdownTheme

  /**
   * 设置图片缩放类型
   *
   * @param imageFitType 图片缩放类型 - 默认ImageFit.Contain
   */
  setImageFitType(imageFitType: ImageFit): MarkdownTheme

  /**
   * 设置图片基于自身宽度缩放百分比
   *
   * @param imageMaximumWidth 图片基于自身宽度缩放百分比 - 默认1.0
   */
  setImageMaximumWidth(imageMaximumWidth: number): MarkdownTheme

  /**
   * 设置图片基于父布局宽度缩放百分比
   *
   * @param imageFixedRatioWidth 图片基于父布局宽度缩放百分比 - 默认None
   */
  setImageFixedRatioWidth(imageFixedRatioWidth: number): MarkdownTheme

  /**
   * 设置图片最大高度
   *
   * @param imageMaxHeight 图片最大高度 - 默认None
   */
  setImageMaxHeight(imageMaxHeight: number): MarkdownTheme

  /**
   * 设置图片最大宽度
   *
   * @param imageMaxWidth 图片最大宽度 - 默认None
   */
  setImageMaxWidth(imageMaxWidth: number): MarkdownTheme

  /**
   * 设置图片圆角大小
   *
   * @param imageBorderRadius 图片圆角大小 - 默认0.0vp
   */
  setImageBorderRadius(imageBorderRadius: number): MarkdownTheme

  /**
   * 设置图片边框宽度
   *
   * @param imageBorderWidth 图片边框宽度 - 默认0.0vp
   */
  setImageBorderWidth(imageBorderWidth: number): MarkdownTheme

  /**
   * 设置图片边框颜色
   *
   * @param imageBorderColor 图片边框颜色 - 默认Color.BLACK
   */
  setImageBorderColor(imageBorderColor: number): MarkdownTheme

  /**
   * 设置网络图片是否压缩
   *
   * @param isAutoResize 网络图片是否压缩 - true：压缩；false：不压缩。默认true
   */
  setIsAutoResize(isAutoResize: boolean): MarkdownTheme

  /**
   * 设置图片上边距
   *
   * @param imageMarginTop 图片上边距 - 默认10.0vp
   */
  setImageMarginTop(imageMarginTop: number): MarkdownTheme

  /**
   * 设置图片下边距
   *
   * @param imageMarginBottom 图片下边距 - 默认10.0vp
   */
  setImageMarginBottom(imageMarginBottom: number): MarkdownTheme

  /**
   * 设置图片是否有下载按钮
   *
   * @param isImageDownload 图片是否有下载按钮 - 默认false
   */
  setIsImageDownload(isImageDownload: boolean): MarkdownTheme

  /**
   * 设置是否图文混排
   *
   * @param isImageMixedLayout 是否图文混排 - 默认true
   */
  setIsImageMixedLayout(isImageMixedLayout: boolean): MarkdownTheme

  /**
   * 设置图片下载按钮图片宽度和高度
   *
   * @param imageDownloadImageWidthHeight 图片下载按钮图片宽度和高度 - 默认18.0
   */
  setImageDownloadImageWidthHeight(imageDownloadImageWidthHeight: number): MarkdownTheme

  /**
   * 设置图片下载按钮宽度
   *
   * @param imageDownloadWidth 图片下载按钮宽度 - 默认296.0
   */
  setImageDownloadWidth(imageDownloadWidth: number): MarkdownTheme

  /**
   * 设置图片下载按钮高度
   *
   * @param imageDownloadHeight 图片下载按钮高度 - 默认44.0
   */
  setImageDownloadHeight(imageDownloadHeight: number): MarkdownTheme

  /**
   * 设置图片下载按钮圆角
   *
   * @param imageDownloadRadius 图片下载按钮圆角 - 默认22.0
   */
  setImageDownloadRadius(imageDownloadRadius: number): MarkdownTheme

  /**
   * 设置图片下载按钮文本内容
   *
   * @param imageDownloadText 图片下载按钮文本内容 - 默认"下载图片"
   */
  setImageDownloadText(imageDownloadText: string): MarkdownTheme

  /**
   * 设置图片下载按钮文本大小
   *
   * @param imageDownloadTextSize 图片下载按钮文本大小 - 默认16.0
   */
  setImageDownloadTextSize(imageDownloadTextSize: number): MarkdownTheme

  /**
   * 设置图片下载按钮文本颜色
   *
   * @param imageDownloadTextColor 图片下载按钮文本颜色 - 默认0XE6000000
   */
  setImageDownloadTextColor(imageDownloadTextColor: number): MarkdownTheme

  /**
   * 设置图片下载按钮背景颜色
   *
   * @param imageDownloadBackgroundColor 图片下载按钮背景颜色 - 默认0XFFF5F5F5
   */
  setImageDownloadBackgroundColor(imageDownloadBackgroundColor: number): MarkdownTheme

  /**
   * 设置表格内容内边距
   *
   * @param tableCellPadding 表格内容内边距 - 默认4.0vp
   */
  setTableCellPadding(tableCellPadding: number): MarkdownTheme

  /**
   * 设置表格边框颜色
   *
   * @param tableBorderColor 表格边框颜色 - 默认0XFF000000
   */
  setTableBorderColor(tableBorderColor: number): MarkdownTheme

  /**
   * 设置表格边框宽度
   *
   * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
   */
  setTableBorderWidth(tableBorderWidth: number): MarkdownTheme

  /**
   * 设置表格奇数行背景色
   *
   * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0XFFFFFFFF
   */
  setTableOddRowBackgroundColor(tableOddRowBackgroundColor: number): MarkdownTheme

  /**
   * 设置表格偶数行背景色
   *
   * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0XFFE0E0E0
   */
  setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: number): MarkdownTheme

  /**
   * 设置表格标题背景色
   *
   * @param tableHeaderRowBackgroundColor 表格标题背景色 - 默认0XFFFFFFFF
   */
  setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: number): MarkdownTheme

  /**
   * 设置表格标题文本颜色
   *
   * @param tableTitleTextColor 表格标题文本颜色 - 默认0XFF191919
   */
  setTableTitleTextColor(tableTitleTextColor: number): MarkdownTheme

  /**
   * 设置表格标题文本大小
   *
   * @param tableTitleTextSize 表格标题文本大小 - 默认14.0vp
   */
  setTableTitleTextSize(tableTitleTextSize: number): MarkdownTheme

  /**
   * 设置表格标题文本行高
   *
   * @param tableTitleLineHeight 表格标题文本行高 - 默认22.0vp
   */
  setTableTitleLineHeight(tableTitleLineHeight: number): MarkdownTheme

  /**
   * 设置表格内容文本颜色
   *
   * @param tableContentTextColor 表格内容文本颜色 - 默认0XFF191919
   */
  setTableContentTextColor(tableContentTextColor: number): MarkdownTheme

  /**
   * 设置表格内容文本大小
   *
   * @param tableContentTextSize 表格内容文本大小 - 默认14.0vp
   */
  setTableContentTextSize(tableContentTextSize: number): MarkdownTheme

  /**
   * 设置表格内容文本行高
   *
   * @param tableTextLineHeight 表格内容文本行高 - 默认22.0vp
   */
  setTableTextLineHeight(tableTextLineHeight: number): MarkdownTheme

  /**
   * 设置表格圆角
   *
   * @param tableRadius 表格圆角 - 默认5.0vp
   */
  setTableRadius(tableRadius: number): MarkdownTheme

  /**
   * 设置表格最小宽度
   *
   * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
   */
  setTableMinTextWidth(tableMinTextWidth: number): MarkdownTheme

  /**
   * 设置表格最大宽度
   *
   * @param tableMaxTextWidth 表格最大宽度- 默认300.0vp
   */
  setTableMaxTextWidth(tableMaxTextWidth: number): MarkdownTheme

  /**
   * 设置表格第一列是否加粗
   *
   * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
   */
  setTableFirstColumnBold(tableFirstColumnBold: boolean): MarkdownTheme

  /**
   * 设置表格是否显示滚动条
   *
   * @param tableScrollBarShow 表格是否显示滚动条 - true：显示；false：不显示。默认false
   */
  setTableScrollBarShow(tableScrollBarShow: boolean): MarkdownTheme

  /**
   * 设置表格滚动条颜色
   *
   * @param tableScrollBarColor 表格滚动条颜色
   */
  setTableScrollBarColor(tableScrollBarColor: number): MarkdownTheme

  /**
   * 设置代码块深浅色
   *
   * @param isDark 是否是深色 - true：深色；false：浅色。默认false
   */
  setIsDark(isDark: boolean): MarkdownTheme

  /**
   * 设置删除线颜色
   *
   * @param strikethroughColor 删除线颜色 - 默认0XFF191919
   */
  setStrikethroughColor(strikethroughColor: number): MarkdownTheme

  /**
   * 设置删除线样式
   *
   * @param strikethroughStyle 删除线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   */
  setStrikethroughStyle(strikethroughStyle: TextDecorationStyle): MarkdownTheme

  /**
   * 设置定义列表术语和定义行之间间距
   *
   * @param descListTermAndDefMargins 定义列表定义行缩进 默认8.0
   */
  setDescListTermAndDefMargins(descListTermAndDefMargins: number): MarkdownTheme

  /**
   * 设置定义列表定义行缩进
   *
   * @param descListDefIndentation 定义列表定义行缩进 默认8.0
   */
  setDescListDefIndentation(descListDefIndentation: number): MarkdownTheme

  /**
   * 设置定义列表定义行间距
   *
   * @param descListDefMargins 定义列表定义行间距 默认8.0
   */
  setDescListDefMargins(descListDefMargins: number): MarkdownTheme

  /**
   * 设置下标字体颜色
   *
   * @param subTextColor 下标字体颜色 默认0XFF191919
   */
  setSubTextColor(subTextColor: number): MarkdownTheme

  /**
   * 设置下标字体大小
   *
   * @param subTextSize 下标字体大小 默认8.0
   */
  setSubTextSize(subTextSize: number): MarkdownTheme

  /**
   * 设置下标偏移距离
   *
   * @param subOffsetDist 下标偏移距离 默认0.0
   */
  setSubOffsetDist(subOffsetDist: number): MarkdownTheme

  /**
   * 设置上标字体颜色
   *
   * @param supTextColor 上标字体颜色 默认0XFF191919
   */
  setSupTextColor(supTextColor: number): MarkdownTheme

  /**
   * 设置上标字体大小
   *
   * @param supTextSize 上标字体大小 默认8.0
   */
  setSupTextSize(supTextSize: number): MarkdownTheme

  /**
   * 设置上标偏移距离
   *
   * @param supOffsetDist 上标偏移距离 默认6.0
   */
  setSupOffsetDist(supOffsetDist: number): MarkdownTheme

  /**
   * 设置下划线颜色
   *
   * @param underlineColor 下划线颜色 默认0XFF191919
   */
  setUnderlineColor(underlineColor: number): MarkdownTheme

  /**
   * 设置下划线样式
   *
   * @param underlineStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   */
  setUnderlineStyle(underlineStyle: TextDecorationStyle): MarkdownTheme

  /**
   * 设置markdown是否支持滚动手势
   *
   * @param openGestureSwipe true-支持滚动手势，false-不支持滚动手势，默认false
   */
  setOpenGestureSwipe(openGestureSwipe: boolean): MarkdownTheme

  /**
   * 设置codeformat是否用制表符
   *
   * @param useTab true-使用，false-不使用，默认false
   */
  setUseTab(useTab: boolean): MarkdownTheme

  /**
   * 设置codeformat空格缩进数量
   *
   * @param indentWidth 空格缩进数量，默认4空格
   */
  setIndentWidth(indentWidth: number): MarkdownTheme

  /**
   * 设置默认主题
   * @return MarkdownTheme
   */
  setDefaultTheme(): MarkdownTheme

  /**
   * 设置Darcula深色主题
   * @return MarkdownTheme
   */
  setDarculaTheme(): MarkdownTheme

  /**
   * 设置全局样式主题
   * @param globalTheme 全局样式主题
   * @return MarkdownTheme
   */
  setGlobalTheme(globalTheme: GlobalTheme): MarkdownTheme

  /**
   * 设置音频样式主题
   * @param audioTheme 音频样式主题
   * @return MarkdownTheme
   */
  setAudioTheme(audioTheme: AudioTheme): MarkdownTheme

  /**
   * 设置Banner样式主题
   * @param bannerTheme Banner样式主题
   * @return MarkdownTheme
   */
  setBannerTheme(bannerTheme: BannerTheme): MarkdownTheme

  /**
   * 设置引用样式主题
   * @param blockQuoteTheme 引用样式主题
   * @return MarkdownTheme
   */
  setBlockQuoteTheme(blockQuoteTheme: BlockQuoteTheme): MarkdownTheme

  /**
   * 设置加粗样式主题
   * @param boldTheme 加粗样式主题
   * @return MarkdownTheme
   */
  setBoldTheme(boldTheme: BoldTheme): MarkdownTheme

  /**
   * 设置代码块样式主题
   * @param codeBlockTheme 代码块样式主题
   * @return MarkdownTheme
   */
  setCodeBlockTheme(codeBlockTheme: CodeBlockTheme): MarkdownTheme

  /**
   * 设置定义列表样式主题
   * @param definitionListTheme 定义列表样式主题
   * @return MarkdownTheme
   */
  setDefinitionListTheme(definitionListTheme: DefinitionListTheme): MarkdownTheme

  /**
   * 设置分割线样式主题
   * @param dividerTheme 分割线样式主题
   * @return MarkdownTheme
   */
  setDividerTheme(dividerTheme: DividerTheme): MarkdownTheme

  /**
   * 设置脚注定义样式主题
   * @param footnoteDefTheme 脚注定义样式主题
   * @return MarkdownTheme
   */
  setFootnoteDefTheme(footnoteDefTheme: FootnoteDefTheme): MarkdownTheme

  /**
   * 设置脚注引用样式主题
   * @param footnoteRefTheme 脚注引用样式主题
   * @return MarkdownTheme
   */
  setFootnoteRefTheme(footnoteRefTheme: FootnoteRefTheme): MarkdownTheme

  /**
   * 设置标题样式主题
   * @param headingTheme 标题样式主题
   * @return MarkdownTheme
   */
  setHeadingTheme(headingTheme: HeadingTheme): MarkdownTheme

  /**
   * 设置HTML下划线样式主题
   * @param htmlUnderlineTheme HTML下划线样式主题
   * @return MarkdownTheme
   */
  setHtmlUnderlineTheme(htmlUnderlineTheme: HtmlUnderlineTheme): MarkdownTheme

  /**
   * 设置图片样式主题
   * @param imageTheme 图片样式主题
   * @return MarkdownTheme
   */
  setImageTheme(imageTheme: ImageTheme): MarkdownTheme

  /**
   * 设置行内代码样式主题
   * @param inlineCodeTheme 行内代码样式主题
   * @return MarkdownTheme
   */
  setInlineCodeTheme(inlineCodeTheme: InlineCodeTheme): MarkdownTheme

  /**
   * 设置斜体样式主题
   * @param italicTheme 斜体样式主题
   * @return MarkdownTheme
   */
  setItalicTheme(italicTheme: ItalicTheme): MarkdownTheme

  /**
   * 设置数学公式样式主题
   * @param latexMathTheme 数学公式样式主题
   * @return MarkdownTheme
   */
  setLatexMathTheme(latexMathTheme: LatexMathTheme): MarkdownTheme

  /**
   * 设置链接样式主题
   * @param linkTheme 链接样式主题
   * @return MarkdownTheme
   */
  setLinkTheme(linkTheme: LinkTheme): MarkdownTheme

  /**
   * 设置有序列表样式主题
   * @param orderedListTheme 有序列表样式主题
   * @return MarkdownTheme
   */
  setOrderedListTheme(orderedListTheme: OrderedListTheme): MarkdownTheme

  /**
   * 设置段落样式主题
   * @param paragraphTheme 段落样式主题
   * @return MarkdownTheme
   */
  setParagraphTheme(paragraphTheme: ParagraphTheme): MarkdownTheme

  /**
   * 设置删除线样式主题
   * @param strikethroughTheme 删除线样式主题
   * @return MarkdownTheme
   */
  setStrikethroughTheme(strikethroughTheme: StrikethroughTheme): MarkdownTheme

  /**
   * 设置下标样式主题
   * @param subTheme 下标样式主题
   * @return MarkdownTheme
   */
  setSubTheme(subTheme: SubTheme): MarkdownTheme

  /**
   * 设置上标样式主题
   * @param supTheme 上标样式主题
   * @return MarkdownTheme
   */
  setSupTheme(supTheme: SupTheme): MarkdownTheme

  /**
   * 设置表格样式主题
   * @param tableTheme 表格样式主题
   * @return MarkdownTheme
   */
  setTableTheme(tableTheme: TableTheme): MarkdownTheme

  /**
   * 设置无序列表样式主题
   * @param bulletListTheme 无序列表样式主题
   * @return MarkdownTheme
   */
  setBulletListTheme(bulletListTheme: BulletListTheme): MarkdownTheme

  /**
   * 设置视频样式主题
   * @param videoTheme 视频样式主题
   * @return MarkdownTheme
   */
  setVideoTheme(videoTheme: VideoTheme): MarkdownTheme

  /**
   * 设置高亮样式主题
   * @param highlightTheme 高亮样式主题
   * @return MarkdownTheme
   */
  setHighlightTheme(highlightTheme: HighlightTheme): MarkdownTheme

  /**
   * 设置各级标题文本尺寸倍率
   * @param headingTextSizeMultipliers 各级标题文本尺寸倍率数组
   * @return MarkdownTheme
   */
  setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<number>): MarkdownTheme

  /**
   * 统一设置标题文本颜色
   * @param headingTextColor 标题文本颜色
   * @return MarkdownTheme
   */
  setHeadingTextColor(headingTextColor: number): MarkdownTheme

  /**
   * 统一设置分割线颜色
   * @param headingBreakColor 分割线颜色
   * @return MarkdownTheme
   */
  setHeadingBreakColor(headingBreakColor: number): MarkdownTheme

  /**
   * 设置表格内容文本行高
   * @param tableTextLineHeight 表格内容文本行高
   * @return MarkdownTheme
   */
  setTableContentTextLineHeight(tableTextLineHeight: number): MarkdownTheme

  /**
   * 设置数学公式默认文本
   * @param latexDefaultText 是否使用数学公式默认文本 - 默认false
   * @return MarkdownTheme
   */
  setLatexDefaultText(latexDefaultText: boolean): MarkdownTheme

  /**
   * 设置数学公式文本尺寸
   * @param latexMathTextSize 数学公式文本尺寸
   * @return MarkdownTheme
   */
  setLatexMathTextSize(latexMathTextSize: number): MarkdownTheme

  /**
   * 设置数学公式背景颜色
   * @param latexMathBackgroundColor 数学公式背景颜色
   * @return MarkdownTheme
   */
  setLatexMathBackgroundColor(latexMathBackgroundColor: ResourceColor): MarkdownTheme

  /**
   * 设置数学公式文本颜色
   * @param latexMathTextColor 数学公式文本颜色
   * @return MarkdownTheme
   */
  setLatexMathTextColor(latexMathTextColor: ResourceColor): MarkdownTheme

  /**
   * 设置数学公式颜色格式
   * @param latexMathColorFormat 数学公式颜色格式
   * @return MarkdownTheme
   */
  setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): MarkdownTheme

  /**
   * 设置数学公式是否块级居中
   * @param latexMathBlockCenter 数学公式是否块级居中 - 默认false
   * @return MarkdownTheme
   */
  setLatexMathBlockCenter(latexMathBlockCenter: boolean): MarkdownTheme

  /**
   * 设置数学公式资源字符串
   * @param latexMathResStr 数学公式资源字符串
   * @return MarkdownTheme
   */
  setLatexMathResStr(latexMathResStr: string): MarkdownTheme
}
```

### class GlobalTheme

全局样式配置

```ets
/**
 * 全局样式配置
 */
export class GlobalTheme {
  /**
   * 设置Stage上下文
   *
   * @param context Stage上下文
   * @return GlobalTheme
   */
  setStageContext(context: Context): GlobalTheme

  /**
   * 设置UIAbility上下文
   *
   * @param context UIAbility上下文
   * @return GlobalTheme
   */
  setUiAbilityContext(context: Context): GlobalTheme

  /**
   * 设置markdown解析是否同步
   *
   * @param parserSync 是否同步解析 - true：同步；false：异步。默认false
   * @return GlobalTheme
   */
  setIsMarkdownParserSync(parserSync: boolean): GlobalTheme

  /**
   * 设置解析节流开关
   *
   * @param enable 是否启用解析节流 - 默认false
   * @return GlobalTheme
   */
  setEnableParseThrottle(enable: boolean): GlobalTheme

  /**
   * 设置解析节流时间间隔(ms)
   *
   * @param throttleMs 解析节流时间间隔 - 默认0
   * @return GlobalTheme
   */
  setParseThrottleMs(throttleMs: number): GlobalTheme

  /**
   * 设置是否启用长按复制
   *
   * @param onCopy 是否启用长按复制 - true：启用；false：不启用。默认true
   * @return GlobalTheme
   */
  setIsOnCopy(onCopy: boolean): GlobalTheme

  /**
   * 设置全局外边距
   *
   * @param options 外边距
   * @return GlobalTheme
   */
  setGlobalMargin(options: Margin | Length): GlobalTheme

  /**
   * 设置块间距
   *
   * @param space 块间距
   * @return GlobalTheme
   */
  setBlockSpacing(space: number): GlobalTheme

  /**
   * 设置是否软换行
   *
   * @param lineBreak 是否软换行 - 默认false
   * @return GlobalTheme
   */
  setIsLineBreak(lineBreak: boolean): GlobalTheme

  /**
   * 设置是否支持滚动手势
   *
   * @param gestureSwipe 是否支持滚动手势 - 默认false
   * @return GlobalTheme
   */
  setOpenGestureSwipe(gestureSwipe: boolean): GlobalTheme

  /**
   * 设置背景颜色
   *
   * @param color 背景颜色
   * @return GlobalTheme
   */
  setBackgroundColor(color: ResourceColor): GlobalTheme

  /**
   * 设置段落标题加载动画是否启用
   *
   * @param enabled 是否启用 - 默认false
   * @return GlobalTheme
   */
  setParagraphHeadingAnimationEnabled(enabled: boolean): GlobalTheme

  /**
   * 设置段落标题加载动画时长
   *
   * @param duration 动画时长（ms） - 默认300
   * @return GlobalTheme
   */
  setParagraphHeadingAnimationDuration(duration: number): GlobalTheme
}
```


### class TableTheme

表格样式配置

```ets
/**
 * 表格样式配置
 */
export class TableTheme {
  /**
   * 设置表格头是否显示
   *
   * @param enable 是否显示 - 默认true
   */
  setTableHeadIsShow(enable: boolean): TableTheme

  /**
   * 设置表格头标题文本
   *
   * @param text 标题文本 - 默认""
   */
  setTableHeadTitleText(text: string): TableTheme

  /**
   * 设置表格头标题文本字体族
   *
   * @param family 字体族 - 默认"HarmonyOS Sans"
   */
  setTableHeadTitleTextFontFamily(family: string | Resource | undefined): TableTheme

  /**
   * 设置表格头标题文本字体大小
   *
   * @param size 字体大小 - 默认14.0fp
   */
  setTableHeadTitleTextFontSize(size: number | string | Resource | undefined): TableTheme

  /**
   * 设置表格头标题文本字体粗细
   *
   * @param weight 字体粗细 - 默认FontWeight.Bold
   */
  setTableHeadTitleTextFontWeight(weight: number | FontWeight | undefined): TableTheme

  /**
   * 设置表格头标题文本字体样式
   *
   * @param style 字体样式 - 默认FontStyle.Normal
   */
  setTableHeadTitleTextFontStyle(style: FontStyle | undefined): TableTheme

  /**
   * 设置表格头标题文本字体颜色
   *
   * @param color 颜色 - 默认0XFF191919
   */
  setTableHeadTitleTextFontColor(color: ResourceColor | undefined): TableTheme

  /**
   * 设置表格头标题文本行高
   *
   * @param lineHeight 行高 - 默认22.0vp
   */
  setTableHeadTitleTextLineHeight(lineHeight: number | string | Resource | undefined): TableTheme

  /**
   * 设置表格头标题文本左边距
   *
   * @param marginLeft 左边距 - 默认16.0vp
   */
  setTableHeadTitleTextMarginLeft(marginLeft: Length): TableTheme

  /**
   * 设置表格头复制图标
   *
   * @param icon 图标资源 - 默认undefined
   */
  setTableHeadCopyIcon(icon: Resource | undefined): TableTheme

  /**
   * 设置表格头复制图标宽度
   *
   * @param width 宽度 - 默认24.0vp
   */
  setTableHeadCopyIconWidth(width: Length): TableTheme

  /**
   * 设置表格头复制图标高度
   *
   * @param height 高度 - 默认24.0vp
   */
  setTableHeadCopyIconHeight(height: Length): TableTheme

  /**
   * 设置表格头复制图标右边距
   *
   * @param marginRight 右边距离 - 默认16.0vp
   */
  setTableHeadCopyIconMarginRight(marginRight: Length): TableTheme
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
   * @param isImageTextMixPlugin 是否图片不混排插件 - true：图片不混排；false：图片混排。默认false
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
   * @param isEmojiLight 是否加载精简emoji表情 - true：加载精简emoji表情；false：不加载精简emoji表情。默认false
   */
  setIsEmojiPlugin(isEmojiPlugin: boolean, isEmojiLight: boolean): void

  /**
   * 设置自定义卡片插件
   *
   * @param isBlockCustomCardPlugin 是否设置自定义卡片插件 - true：设置插件；false：不设置插件。默认false
   * @param blockImageCard 满足块级图片自定义卡片条件
   * @param blockLinkCard 满足块级链接自定义卡片条件
   */
  setIsBlockCustomCardPlugin(isBlockCustomCardPlugin: boolean, blockImageCard?: (desc: string, imageSrc: string, title: string) => boolean,
    blockLinkCard?: (desc: string, link: string, title: string) => boolean): void

  /**
   * 设置数学公式插件
   *
   * @param isLatexMathPlugin 是否设置数学公式插件 - true：设置数学公式插件；false：不设置数学公式插件。默认false
   */
  setIsLatexMathPlugin(isLatexMathPlugin: boolean): void

  /**
   * 设置高亮插件
   *
   * @param isHighlightPlugin 是否设置高亮插件 - true：设置高亮插件；false：不设置高亮插件。默认false
   */
  setIsHighlightPlugin(isHighlightPlugin: boolean): void

  /**
   * 设置白名单插件
   *
   * @param mode 白名单过滤模式 - 可为undefined、DelimiterFilterMode或过滤标签字符串数组
   */
  setIsWhitelistPlugin(mode: undefined | DelimiterFilterMode | Array<string>): void
}
```

### class MarkdownHighlightParagraph

Markdown段落高亮配置

```ets
export class MarkdownHighlightParagraph {
  /**
   * 获取所有可以设置高亮的段落的nodeHash集合
   * @return 段落nodeHash集合
   */
  getAllParagraphItems(): Array<string>

  /**
   * 设置指定段落高亮显示
   * @param nodeHash 段落nodeHash
   * @param color 段落高亮颜色
   *
   * @return 是否设置成功 false表示已经设置过或设置失败
   */
  setParagraphHighlight(nodeHash: string, color: ResourceColor): boolean

  /**
   * 取消指定段落的高亮
   * @param nodeHash 段落nodeHash
   *
   * @return 是否取消成功 false表示该段落没有高亮
   */
  clearParagraphHighlight(nodeHash: string): boolean

  /**
   * 取消所有段落高亮
   */
  clearAllParagraphHighlights(): void

  /**
   * 设置当前长按未触发弹窗时段落前的背景色
   * @param backgroundColor 段落背景色
   */
  setBeforeSelectedParagraphBackgroundColor(backgroundColor: ResourceColor): void

  /**
   * 设置当前长按放手后选中文字的背景色
   * @param backgroundColor 选中文字的背景色
   */
  setSelectedParagraphBackgroundColor(backgroundColor: ResourceColor): void

  /**
   * 获取当前高亮显示的段落nodeHash集合
   * @return 当前高亮显示的段落nodeHash集合
   */
  getSelectedParagraphItems(): ArrayList<string>

  /**
   * 设置所有可以设置高亮的段落的nodeHash集合(markdown解析后自动调用)
   * @param itemNodeHashList 段落nodeHash集合
   */
  setAllParagraphItems(itemNodeHashList: ArrayList<string>): void
}
```

### class MarkdownNodeViewString

全局文本对象，深度优先遍历NodeView树，提取纯文本

```ets
/**
 * 全局文本对象
 * 深度优先遍历NodeView树，提取纯文本
 */
export class MarkdownNodeViewString {
  /**
   * 构造函数
   */
  constructor()

  /**
   * 设置根节点并构建全局文本(markdown解析后自动调用)
   *
   * @param root 根NodeView节点
   * @param codeBlockIsSeparate 代码块是否单独分离显示 - 默认false
   */
  setRoot(root: NodeView, codeBlockIsSeparate: boolean = false): void

  /**
   * 获取全局文本
   * - 处理缩进（列表、引用）
   * - 处理行内节点（Text/Code/换行等）
   * - block节点尾插换行
   *
   * @return 全局文本
   */
  toString(): string
}
```
