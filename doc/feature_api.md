# Markdown API

### struct CJMarkdown

```ets
@Component
export struct CJMarkdown {
  content: string
  config: new MarkdownConfiguration()
  plugin: new MarkdownPlugin()
  scroller: new Scroller()
  scrollController?: new MarkdownScrollController()
  @BuilderParam blockImageCardComponent: (desc: string, imageSrc: string, title: string) => void
  @BuilderParam blockLinkCardComponent: (desc: string, link: string, title: string) => void
  @BuilderParam customTagViewComponent: (tag: string, attrs: Record<string, string>, content: string) => void
}
```

### class MarkdownConfiguration

markdown配置

```ets
export class MarkdownConfiguration {

  /**
   * 设置链接点击回调
   * @param cb 链接点击回调(url：链接url)
   */
  setLinkCallback(cb: (url: string) => void): MarkdownConfiguration

  /**
   * 设置元素曝光回调
   * @param cb 曝光回调(event：{ eventType, visible, data })
   */
  setElementExposureCallback(cb: (event: MarkdownExposureEvent) => void): MarkdownConfiguration

  /**
   * 设置曝光可见阈值
   * @param threshold 0~1，链接与可见区交集面积 / 链接面积 ≥ 此值才算可见。0=漏出任意像素即可见
   */
  setExposureThreshold(threshold: number): MarkdownConfiguration

  /**
   * 设置文本复制的点击事件
   * @param cb 文本复制的点击事件(text：复制的文本)
   */
  setTextCopyCallback(cb: (text: string) => void): MarkdownConfiguration

  /**
   * 设置表格复制的点击事件
   * @param cb 文本复制的点击事件(text：复制的文本)
   */
  setTableCopyCallback(cb: (text: string) => void): MarkdownConfiguration

  /**
   * 设置段落动画开始回调
   * @param cb 段落动画开始回调
   */
  setParagraphHeadingAnimationStart(cb: () => void): MarkdownConfiguration

  /**
   * 设置段落动画结束回调
   * @param cb 段落动画结束回调
   */
  setParagraphHeadingAnimationEnd(cb: () => void): MarkdownConfiguration

  /**
   * 设置图片点击回调
   * @param cb 图片点击回调。 (url：图片url,urlList：所有图片和视频链接集合 --- 需要加载图片视频列表url集合列表解析插件)
   */
  setImageCallback(cb: (url: string, urlList: Array<string>) => void): MarkdownConfiguration

  /**
   * 设置图片替换事件
   * @param cb 图片替换事件。 (url：图片url 返回值是替换的图片数据)
   * @deprecated since 1.4.0
   * @useinstead MarkdownConfiguration#setImageReplaceCallback
   */
  setImageCallbackCallback(cb: (url: string) => Promise<ArrayBuffer | undefined>): MarkdownConfiguration

  /**
   * 设置图片替换事件
   * @param cb 图片替换事件。 (url：图片url 返回值是替换的图片数据)
   */
  setImageReplaceCallback(cb: (url: string) => Promise<ArrayBuffer | undefined>): MarkdownConfiguration

  /**
   * 设置图片下载的点击事件
   * @param cb 图片下载的点击事件。 (url：图片url)
   */
  setImageDownloadCallback(cb: (url: string) => void): MarkdownConfiguration

  /**
   * 设置音频点击回调
   * @param cb 音频点击回调(url：音频url) --- 需要加载音频解析插件
   */
  setAudioCallback(cb: (url: string) => void): MarkdownConfiguration

  /**
   * 设置视频点击回调
   * @param cb 视频点击回调。 (url：视频url,urlList：所有图片和视频链接集合 --- 需要加载图片视频列表url集合列表解析插件) --- 需要加载视频解析插件
   */
  setVideoCallback(cb: (url: string, urlList: Array<string>) => void): MarkdownConfiguration

  /**
   * 设置视频占位图和宽高比和视频时长的回调
   * @param cb 视频占位图和宽高比和视频时长回调。 (url：视频url,coverCallback：视频占位图和宽高比和视频时长回调 (coverUrl：视频首帧图,aspectRatio：图片宽高比,duration：视频时长)) --- 需要加载视频解析插件
   */
  setVideoImageCallback(cb: (url: string, coverCallback: (coverUrl: string, aspectRatio: number, duration: number) => void) => void): MarkdownConfiguration

  /**
   * 设置视频发布的点击事件
   * @param cb 视频发布的点击事件(url：视频url) --- 需要加载视频解析插件
   */
  setVideoReleaseCallback(cb: (url: string) => void): MarkdownConfiguration

  /**
   * 设置视频下载的点击事件
   * @param cb 视频下载的点击事件(url：视频url) --- 需要加载视频解析插件
   */
  setVideoDownloadCallback(cb: (url: string) => void): MarkdownConfiguration

  /**
   * 设置代码复制点击回调
   * @param cb 代码复制点击回调(code：代码内容)
   */
  setCodeCopyCallback(cb: (code: string) => void): MarkdownConfiguration

  /**
   * 设置代码全屏点击回调
   * @param cb 代码全屏点击回调(code：代码内容, language：代码类型)
   */
  setCodeFullScreenCallback(cb: (code: string, language: string | undefined) => void): MarkdownConfiguration

  /**
   * 设置TOC点击回调
   * @param cb TOC点击回调(index：第几条数据) --- 需要加载TOC解析插件
   */
  setTocIndexCallback(cb: (index: number | undefined) => void): MarkdownConfiguration

  /**
   * 设置脚注点击回调
   * @param cb 脚注点击回调(index：第几条数据) --- 需要加载脚注解析插件
   */
  setFootnoteCallback(cb: (index: number | undefined) => void): MarkdownConfiguration

  /**
   * 设置数学公式图片点击回调
   * @param cb 数学公式图片点击回调(data：图片数据,height：图片高度-单位px,width：图片宽度-单位px) --- 需要加载formula_hybrid
   */
  setLatexImageCallback(cb: (data: ArrayBuffer, height: number, width: number) => void): MarkdownConfiguration

  /**
   * 设置数学公式数据处理事件
   * @param cb 数学公式数据处理事件(str：数学公式文本 返回值是处理后的数学公式文本) --- 需要加载formula_hybrid
   */
  setLatexStrCallback(cb: (str: string) => string): MarkdownConfiguration

  /**
   * 自定义长按事件
   * @param cb 自定义长按事件
   */
  setCustomLongPressCallback(cb: (str: string) => void): MarkdownConfiguration

  /**
   * 设置全局文本对象
   * @param nodeString 全局文本对象
   */
  setNodeString(nodeString: MarkdownNodeViewString): MarkdownConfiguration

  /**
   * 设置markdown样式
   * @param markdownTheme markdown样式
   */
  setMarkdownTheme(markdownTheme: MarkdownTheme): MarkdownConfiguration

  /**
   * 获取高亮设置对象
   */
  getMarkdownHighlightParagraph(): MarkdownHighlightParagraph
}
```

### class MarkdownPlugin

Markdown插件配置

```ets
export class MarkdownPlugin {

  /**
   * 设置音频插件
   * @param isBlockAudioPlugin 是否设置音频插件 - true：设置音频插件；false：不设置音频插件。默认false
   */
  setIsBlockAudioPlugin(isBlockAudioPlugin: boolean): void

  /**
   * 设置视频插件
   * @param isBlockVideoPlugin 是否设置视频插件 - true：设置视频插件；false：不设置视频插件。默认false
   */
  setIsBlockVideoPlugin(isBlockVideoPlugin: boolean): void

  /**
   * 设置组合代码块列表插件
   * @param isCodeListPlugin 是否设置组合代码块列表插件 - true：设置组合代码块列表插件；false：不设置组合代码块列表插件。默认false
   */
  setIsCodeListPlugin(isCodeListPlugin: boolean): void

  /**
   * 设置脚注插件
   * @param isFootnotePlugin 是否设置脚注插件 - true：设置脚注插件；false：不设置脚注插件。默认false
   */
  setIsFootnotePlugin(isFootnotePlugin: boolean): void

  /**
   * 设置HTML插件
   * @param isHtmlPlugin 是否设置HTML插件 - true：设置HTML插件；false：不设置HTML插件。默认false
   */
  setIsHtmlPlugin(isHtmlPlugin: boolean): void

  /**
   * 设置表格插件
   * @param isTablePlugin 是否设置表格插件 - true：设置表格插件；false：不设置表格插件。默认false
   */
  setIsTablePlugin(isTablePlugin: boolean): void

  /**
   * 设置TOC插件
   * @param isTocPlugin 是否设置TOC插件 - true：设置TOC插件；false：不设置TOC插件。默认false
   */
  setIsTocPlugin(isTocPlugin: boolean): void

  /**
   * 设置自定义卡片插件
   * @param isBlockCustomCardPlugin 是否设置自定义卡片插件 - true：设置插件；false：不设置插件。默认false
   * @param blockImageCard 满足块级图片自定义卡片条件
   * @param blockLinkCard 满足块级链接自定义卡片条件
   */
  setIsBlockCustomCardPlugin(isBlockCustomCardPlugin: boolean, blockImageCard? :(desc: string, imageSrc: string, title: string) => boolean, blockLinkCard?: (desc: string, link: string, title: string) => boolean): void

  /**
   * 设置任务列表插件
   * @param isTaskListPlugin 是否设置任务列表插件 - true：设置任务列表插件；false：不设置任务列表插件。默认false
   */
  setIsTaskListPlugin(isTaskListPlugin: boolean): void

  /**
   * 设置删除线插件
   * @param isStrikethroughPlugin 是否设置删除线插件 - true：设置删除线插件；false：不设置删除线插件。默认false
   */
  setIsStrikethroughPlugin(isStrikethroughPlugin: boolean): void

  /**
   * 设置链接自动加载插件
   * @param isLinkifyPlugin 是否设置链接自动加载插件 - true：设置链接自动加载插件；false：不设置链接自动加载插件。默认false
   * @param regs 正则列表
   */
  setIsLinkifyPlugin(isLinkifyPlugin: boolean, regs?: Array<string>): void

  /**
   * 设置链接块状化插件
   * @param isLinkViewPlugin 是否设置链接块状化插件 - true：设置链接块状化插件；false：不设置链接块状化插件。默认false
   */
  setIsLinkViewPlugin(isLinkViewPlugin: boolean): void

  /**
   * 设置数学公式插件
   * @param isLatexMathPlugin 是否设置数学公式插件 - true：设置数学公式插件；false：不设置数学公式插件。默认false
   */
  setIsLatexMathPlugin(isLatexMathPlugin: boolean): void

  /**
   * 设置图片样式插件
   * @param isImageStylePlugin 是否设置图片样式插件 - true：设置图片样式插件；false：不设置图片样式插件。默认false
   */
  setIsImageStylePlugin(isImageStylePlugin: boolean): void

  /**
   * 设置图片幻灯片（Banner）插件
   * @param isImageSlidePlugin 是否设置图片幻灯片（Banner）插件 - true：设置图片幻灯片（Banner）插件；false：不设置图片幻灯片（Banner）插件。默认false
   */
  setIsImageSlidePlugin(isImageSlidePlugin: boolean): void

  /**
   * 设置图片不混排插件
   * @param isImageTextMixPlugin 是否图片不混排插件 - true：图片不混排；false：图片混排。默认false
   */
  setIsImageTextMixPlugin(isImageTextMixPlugin: boolean): void

  /**
   * 设置图片视频url集合列表插件
   * @param isImageCollectPlugin 是否设置图片视频url集合列表插件 - true：设置图片视频url集合列表插件；false：不设置图片视频url集合列表插件。默认false
   */
  setIsImageCollectPlugin(isImageCollectPlugin: boolean): void

  /**
   * 设置是否加载定义列表解析插件
   * @param isDescListPlugin 是否加载定义列表解析插件 - true：启用定义列表解析插件；false：禁用定义列表解析插件。默认false
   */
  setIsDescListPlugin(isDescListPlugin: boolean): void

  /**
   * 设置是否加载标题ID解析插件
   * @param isHeadIDPlugin 是否加载标题ID解析插件 - true：设置加载标题ID解析插件；false：不设置加载标题ID解析插件。默认false
   */
  setIsHeadIDPlugin(isHeadIDPlugin: boolean): void

  /**
   * 设置是否加载下标解析插件
   * @param isSubPlugin 是否加载下标解析插件 - true：设置加载下标解析插件；false：不设置加载下标解析插件。默认false
   */
  setIsSubPlugin(isSubPlugin: boolean): void

  /**
   * 设置是否加载上标解析插件
   * @param isSupPlugin 是否加载上标解析插件 - true：设置加载上标解析插件；false：不设置加载上标解析插件。默认false
   */
  setIsSupPlugin(isSupPlugin: boolean): void

  /**
   * 设置是否加载emoji解析插件
   * @param isEmojiPlugin 是否加载Emoji解析插件 - true：设置加载Emoji解析插件；false：不设置加载Emoji解析插件。默认false
   * @param isEmojiLight 是否加载精简emoji表情 - true：加载精简emoji表情；false：不加载精简emoji表情。默认false
   */
  setIsEmojiPlugin(isEmojiPlugin: boolean, isEmojiLight: boolean): void

  /**
   * 设置是否加载高亮解析插件
   * @param isHighlightPlugin 是否加载高亮解析插件 - true：设置加载高亮解析插件；false：不设置加载高亮解析插件。默认false
   */
  setIsHighlightPlugin(isHighlightPlugin: boolean): void

  /**
   * 设置是否加载白名单宽松分隔符插件
   * @param mode 加载模式。 - undefined：不加载插件。DelimiterFilterMode：(0:宽松模式，1：严格模式)。Array<string>：白名单模式
   */
  setIsWhitelistPlugin(mode: undefined | DelimiterFilterMode | Array<string>): void

}
```

### class AudioTheme

音频样式配置

```ets
export class AudioTheme {

  /**
   * 设置音频背景颜色
   * @param color 背景颜色
   * @return AudioTheme
   */
  setAudioBackgroundColor(color: ResourceColor): AudioTheme

  /**
   * 设置音频外边距
   * @param options 外边距选项或统一数值
   * @return AudioTheme
   */
  setAudioMargin(options: Margin | Length): AudioTheme

  /**
   * 设置音频内边距
   * @param options 内边距选项或统一数值
   * @return AudioTheme
   */
  setAudioPadding(options: Padding | Length): AudioTheme

  /**
   * 设置音频边框样式
   * @param borderStyle 边框样式
   * @return AudioTheme
   */
  setAudioBorderStyle(borderStyle: BorderStyle): AudioTheme

  /**
   * 设置音频边框宽度
   * @param borderWidth 边框宽度
   * @return AudioTheme
   */
  setAudioBorderWidth(borderWidth: Length): AudioTheme

  /**
   * 设置音频边框颜色
   * @param borderColor 边框颜色
   * @return AudioTheme
   */
  setAudioBorderColor(borderColor: ResourceColor): AudioTheme

  /**
   * 设置音频圆角
   * @param options 圆角选项或统一数值
   * @return AudioTheme
   */
  setAudioBorderRadius(options: BorderRadiuses | Length): AudioTheme

  /**
   * 设置音频阴影半径
   * @param radius 阴影半径
   * @return AudioTheme
   */
  setAudioShadowRadius(radius: number): AudioTheme

  /**
   * 设置音频阴影颜色
   * @param color 阴影颜色
   * @return AudioTheme
   */
  setAudioShadowColor(color: ResourceColor): AudioTheme

  /**
   * 设置音频阴影X偏移
   * @param offsetX X偏移
   * @return AudioTheme
   */
  setAudioShadowOffsetX(offsetX: number): AudioTheme

  /**
   * 设置音频阴影Y偏移
   * @param offsetY Y偏移
   * @return AudioTheme
   */
  setAudioShadowOffsetY(offsetY: number): AudioTheme

  /**
   * 设置音频图标
   * @param icon 图标资源
   * @return AudioTheme
   */
  setAudioIcon(icon: Resource): AudioTheme

  /**
   * 设置音频图标宽度
   * @param width 图标宽度
   * @return AudioTheme
   */
  setAudioIconWidth(width: Length): AudioTheme

  /**
   * 设置音频图标高度
   * @param height 图标高度
   * @return AudioTheme
   */
  setAudioIconHeight(height: Length): AudioTheme

  /**
   * 设置音频图标圆角
   * @param options 圆角选项或统一数值
   * @return AudioTheme
   */
  setAudioIconRadius(options: BorderRadiuses | Length): AudioTheme

  /**
   * 设置音频图标适应类型
   * @param fitType 适应类型
   * @return AudioTheme
   */
  setAudioIconFitType(fitType: ImageFit): AudioTheme

  /**
   * 设置音频标题与类型间距
   * @param spacing 间距
   * @return AudioTheme
   */
  setAudioTitleToTypeSpacing(spacing: number): AudioTheme

  /**
   * 设置音频标题文本字体颜色
   * @param color 字体颜色
   * @return AudioTheme
   */
  setAudioTitleTextFontColor(color: ResourceColor): AudioTheme

  /**
   * 设置音频标题文本字体大小
   * @param size 字体大小
   * @return AudioTheme
   */
  setAudioTitleTextFontSize(size: number | string | Resource): AudioTheme

  /**
   * 设置音频标题文本字体样式
   * @param style 字体样式
   * @return AudioTheme
   */
  setAudioTitleTextFontStyle(style: FontStyle): AudioTheme

  /**
   * 设置音频标题文本字体粗细
   * @param weight 字体粗细
   * @return AudioTheme
   */
  setAudioTitleTextFontWeight(weight: number | FontWeight): AudioTheme

  /**
   * 设置音频标题文本字体族
   * @param family 字体族
   * @return AudioTheme
   */
  setAudioTitleTextFontFamily(family: string | Resource): AudioTheme

  /**
   * 设置音频标题文本行高
   * @param height 行高
   * @return AudioTheme
   */
  setAudioTitleTextLineHeight(height: number | string | Resource): AudioTheme

  /**
   * 设置音频类型文本字体颜色
   * @param color 字体颜色
   * @return AudioTheme
   */
  setAudioTypeTextFontColor(color: ResourceColor): AudioTheme

  /**
   * 设置音频类型文本字体大小
   * @param size 字体大小
   * @return AudioTheme
   */
  setAudioTypeTextFontSize(size: number | string | Resource): AudioTheme

  /**
   * 设置音频类型文本字体样式
   * @param style 字体样式
   * @return AudioTheme
   */
  setAudioTypeTextFontStyle(style: FontStyle): AudioTheme

  /**
   * 设置音频类型文本字体粗细
   * @param weight 字体粗细
   * @return AudioTheme
   */
  setAudioTypeTextFontWeight(weight: number | FontWeight): AudioTheme

  /**
   * 设置音频类型文本字体族
   * @param family 字体族
   * @return AudioTheme
   */
  setAudioTypeTextFontFamily(family: string | Resource): AudioTheme

  /**
   * 设置音频类型文本行高
   * @param height 行高
   * @return AudioTheme
   */
  setAudioTypeTextLineHeight(height: number | string | Resource): AudioTheme

  /**
   * 设置音频按钮背景颜色
   * @param color 背景颜色
   * @return AudioTheme
   */
  setAudioButtonBackgroundColor(color: ResourceColor): AudioTheme

  /**
   * 设置音频按钮宽度
   * @param width 按钮宽度
   * @return AudioTheme
   */
  setAudioButtonWidth(width: Length): AudioTheme

  /**
   * 设置音频按钮高度
   * @param height 按钮高度
   * @return AudioTheme
   */
  setAudioButtonHeight(height: Length): AudioTheme

  /**
   * 设置音频按钮边框样式
   * @param borderStyle 边框样式
   * @return AudioTheme
   */
  setAudioButtonBorderStyle(borderStyle: BorderStyle): AudioTheme

  /**
   * 设置音频按钮边框宽度
   * @param borderWidth 边框宽度
   * @return AudioTheme
   */
  setAudioButtonBorderWidth(borderWidth: Length): AudioTheme

  /**
   * 设置音频按钮边框颜色
   * @param borderColor 边框颜色
   * @return AudioTheme
   */
  setAudioButtonBorderColor(borderColor: ResourceColor): AudioTheme

  /**
   * 设置音频按钮圆角
   * @param options 圆角选项或统一数值
   * @return AudioTheme
   */
  setAudioButtonRadius(options: BorderRadiuses | Length): AudioTheme

  /**
   * 设置音频按钮文本
   * @param text 按钮文本
   * @return AudioTheme
   */
  setAudioButtonText(text: string): AudioTheme

  /**
   * 设置音频按钮文本字体颜色
   * @param color 字体颜色
   * @return AudioTheme
   */
  setAudioButtonTextFontColor(color: ResourceColor): AudioTheme

  /**
   * 设置音频按钮文本字体大小
   * @param size 字体大小
   * @return AudioTheme
   */
  setAudioButtonTextFontSize(size: number | string | Resource): AudioTheme

  /**
   * 设置音频按钮文本字体样式
   * @param style 字体样式
   * @return AudioTheme
   */
  setAudioButtonTextFontStyle(style: FontStyle): AudioTheme

  /**
   * 设置音频按钮文本字体粗细
   * @param weight 字体粗细
   * @return AudioTheme
   */
  setAudioButtonTextFontWeight(weight: number | FontWeight): AudioTheme

  /**
   * 设置音频按钮文本字体族
   * @param family 字体族
   * @return AudioTheme
   */
  setAudioButtonTextFontFamily(family: string | Resource): AudioTheme

  /**
   * 设置音频按钮文本行高
   * @param height 行高
   * @return AudioTheme
   */
  setAudioButtonTextLineHeight(height: number | string | Resource): AudioTheme
}
```

### class BannerTheme

Banner样式配置

```ets
export class BannerTheme {

  /**
   * 设置Banner外边距
   * @param options Banner外边距选项或统一数值
   * @return BannerTheme
   */
  setBannerMargin(options: Margin | Length): BannerTheme

  /**
   * 设置Banner内边距
   * @param options Banner内边距选项或统一数值
   * @return BannerTheme
   */
  setBannerPadding(options: Padding | Length): BannerTheme

  /**
   * 设置Banner占位图资源
   * @param resource Banner占位图资源
   * @return BannerTheme
   */
  setBannerPlaceholder(resource: Resource): BannerTheme
}
```

### class BlockQuoteTheme

块引用样式配置

```ets
export class BlockQuoteTheme {

  /**
   * 设置块引用背景颜色
   * @param color 块引用背景颜色
   * @return BlockQuoteTheme
   */
  setBlockQuoteBackgroundColor(color: ResourceColor): BlockQuoteTheme

  /**
   * 设置块引用外边距
   * @param options 块引用外边距选项或统一数值
   * @return BlockQuoteTheme
   */
  setBlockQuoteMargin(options: Margin | Length): BlockQuoteTheme

  /**
   * 设置块引用内边距
   * @param options 块引用内边距选项或统一数值
   * @return BlockQuoteTheme
   */
  setBlockQuotePadding(options: Padding | Length): BlockQuoteTheme

  /**
   * 设置块引用圆角
   * @param options 块引用圆角选项或统一数值
   * @return BlockQuoteTheme
   */
  setBlockQuoteRadius(options: BorderRadiuses | Length): BlockQuoteTheme

  /**
   * 设置块引用左边框宽度
   * @param width 块引用左边框宽度
   * @return BlockQuoteTheme
   */
  setBlockQuoteLeftBorderWidth(width: Length): BlockQuoteTheme

  /**
   * 设置块引用左边框颜色
   * @param color 块引用左边框颜色
   * @return BlockQuoteTheme
   */
  setBlockQuoteLeftBorderColor(color: ResourceColor): BlockQuoteTheme

  /**
   * 设置块引用子项间距
   * @param space 块引用子项间距
   * @return BlockQuoteTheme
   */
  setBlockQuoteChildSpacing(space: number): BlockQuoteTheme
}
```

### class BoldTheme

加粗文本样式配置

```ets
export class BoldTheme {

  /**
   * 设置粗体字体颜色
   * @param color 字体颜色
   * @return BoldTheme
   */
  setBoldTextFontColor(color: ResourceColor): BoldTheme

  /**
   * 设置粗体字体大小
   * @param size 字体大小
   * @return BoldTheme
   */
  setBoldTextFontSize(size: number | string | Resource): BoldTheme

  /**
   * 设置粗体字体样式
   * @param style 字体样式
   * @return BoldTheme
   */
  setBoldTextFontStyle(style: FontStyle): BoldTheme

  /**
   * 设置粗体字体粗细
   * @param weight 字体粗细
   * @return BoldTheme
   */
  setBoldTextFontWeight(weight: number | FontWeight): BoldTheme

  /**
   * 设置粗体字体族
   * @param family 字体族
   * @return BoldTheme
   */
  setBoldTextFontFamily(family: string | Resource): BoldTheme

  /**
   * 设置粗体行高
   * @param lineHeight 行高
   * @return BoldTheme
   */
  setBoldTextLineHeight(lineHeight: number | string | Resource): BoldTheme

  /**
   * 设置粗体字间距
   * @param spacing 字间距
   * @return BoldTheme
   */
  setBoldTextLetterSpacing(spacing: number): BoldTheme
}
```

### class BulletListTheme

无序/任务列表样式配置

```ets
export class BulletListTheme {

  /**
   * 设置无序/任务列表背景颜色
   * @param color 无序/任务列表背景颜色
   * @return BulletListTheme
   */
  setBulletListBackgroundColor(color: ResourceColor): BulletListTheme

  /**
   * 设置无序/任务列表外边距
   * @param options 无序/任务列表外边距选项或统一数值
   * @return BulletListTheme
   */
  setBulletListMargin(options: Margin | Length): BulletListTheme

  /**
   * 设置无序/任务列表内边距
   * @param options 无序/任务列表内边距选项或统一数值
   * @return BulletListTheme
   */
  setBulletListPadding(options: Padding | Length): BulletListTheme

  /**
   * 设置无序/任务列表子项间距
   * @param spacing 无序/任务列表子项间距
   * @return BulletListTheme
   */
  setBulletListChildSpacing(spacing: number): BulletListTheme

  /**
   * 设置无序/任务列表子子项间距
   * @param spacing 无序/任务列表子子项间距
   * @return BulletListTheme
   */
  setBulletListChildChildSpacing(spacing: number): BulletListTheme

  /**
   * 设置无序/任务列表标记间距
   * @param spacing 无序/任务列表标记间距
   * @return BulletListTheme
   */
  setBulletListBulletSpacing(spacing: number): BulletListTheme

  /**
   * 设置无序/任务列表标记是否圆形
   * @param isCircle 无序/任务列表标记是否圆形
   * @return BulletListTheme
   */
  setBulletListBulletIsCircle(isCircle: boolean): BulletListTheme

  /**
   * 设置无序/任务列表标记文本字体颜色
   * @param color 无序/任务列表标记文本字体颜色
   * @return BulletListTheme
   */
  setBulletListBulletTextFontColor(color: ResourceColor): BulletListTheme

  /**
   * 设置无序/任务列表标记文本字体大小
   * @param size 无序/任务列表标记文本字体大小
   * @return BulletListTheme
   */
  setBulletListBulletTextFontSize(size: number | string | Resource): BulletListTheme

  /**
   * 设置无序/任务列表标记文本字体样式
   * @param style 无序/任务列表标记文本字体样式
   * @return BulletListTheme
   */
  setBulletListBulletTextFontStyle(style: FontStyle): BulletListTheme

  /**
   * 设置无序/任务列表标记文本字体粗细
   * @param weight 无序/任务列表标记文本字体粗细
   * @return BulletListTheme
   */
  setBulletListBulletTextFontWeight(weight: number | FontWeight): BulletListTheme

  /**
   * 设置无序/任务列表标记文本字体族
   * @param family 无序/任务列表标记文本字体族
   * @return BulletListTheme
   */
  setBulletListBulletTextFontFamily(family: string | Resource): BulletListTheme

  /**
   * 设置无序/任务列表标记文本行高
   * @param lineHeight 无序/任务列表标记文本行高
   * @return BulletListTheme
   */
  setBulletListBulletTextLineHeight(lineHeight: number | string | Resource): BulletListTheme

  /**
   * 设置无序/任务列表复选框间距
   * @param spacing 无序/任务列表复选框间距
   * @return BulletListTheme
   */
  setBulletListCheckboxSpacing(spacing: number): BulletListTheme

  /**
   * 设置无序/任务列表复选框宽度
   * @param width 无序/任务列表复选框宽度
   * @return BulletListTheme
   */
  setBulletListCheckboxWidth(width: Length): BulletListTheme

  /**
   * 设置无序/任务列表复选框高度
   * @param height 无序/任务列表复选框高度
   * @return BulletListTheme
   */
  setBulletListCheckboxHeight(height: Length): BulletListTheme

  /**
   * 设置无序/任务列表复选框选中颜色
   * @param color 无序/任务列表复选框选中颜色
   * @return BulletListTheme
   */
  setBulletListCheckboxSelectedColor(color: ResourceColor): BulletListTheme

  /**
   * 设置无序/任务列表复选框形状
   * @param shape 无序/任务列表复选框形状
   * @return BulletListTheme
   */
  setBulletListCheckboxShape(shape: CheckBoxShape): BulletListTheme
}
```

### class CodeBlockTheme

代码块样式配置

```ets
export class CodeBlockTheme {

  /**
   * 设置代码块深浅色
   * @param isDark 是否是深色 - true：深色；false：浅色。默认false
   * @return CodeBlockTheme
   */
  setCodeBlockIsDark(isDark: boolean): CodeBlockTheme

  /**
   * 设置代码块是否为代码格式
   * @param isCodeFormat 是否为代码格式
   * @return CodeBlockTheme
   */
  setCodeBlockIsCodeFormat(isCodeFormat: boolean): CodeBlockTheme

  /**
   * 设置代码块是否使用Tab缩进
   * @param useTab 是否使用Tab缩进
   * @return CodeBlockTheme
   */
  setCodeBlockUseTab(useTab: boolean): CodeBlockTheme

  /**
   * 设置代码块缩进宽度
   * @param indentWidth 缩进宽度
   * @return CodeBlockTheme
   */
  setCodeBlockIndentWidth(indentWidth: Length): CodeBlockTheme

  /**
   * 设置代码块解析器是否同步
   * @param parserSync 解析器是否同步
   * @return CodeBlockTheme
   */
  setCodeBlockParserSync(parserSync: boolean): CodeBlockTheme

  /**
   * 设置代码块背景颜色
   * @param color 背景颜色
   * @return CodeBlockTheme
   */
  setCodeBlockBackgroundColor(color: ResourceColor): CodeBlockTheme

  /**
   * 设置代码块边距
   * @param options 边距选项
   * @return CodeBlockTheme
   */
  setCodeBlockMargin(options: Margin | Length): CodeBlockTheme

  /**
   * 设置代码块内边距
   * @param options 内边距选项
   * @return CodeBlockTheme
   */
  setCodeBlockPadding(options: Padding | Length): CodeBlockTheme

  /**
   * 设置代码块边框样式
   * @param borderStyle 边框样式
   * @return CodeBlockTheme
   */
  setCodeBlockBorderStyle(borderStyle: BorderStyle): CodeBlockTheme

  /**
   * 设置代码块边框宽度
   * @param borderWidth 边框宽度
   * @return CodeBlockTheme
   */
  setCodeBlockBorderWidth(borderWidth: Length): CodeBlockTheme

  /**
   * 设置代码块边框颜色
   * @param borderColor 边框颜色
   * @return CodeBlockTheme
   */
  setCodeBlockBorderColor(borderColor: ResourceColor): CodeBlockTheme

  /**
   * 设置代码块圆角
   * @param options 圆角选项
   * @return CodeBlockTheme
   */
  setCodeBlockRadius(options: BorderRadiuses | Length): CodeBlockTheme

  /**
   * 设置代码块标题布局下边距
   * @param marginBottom 下边距
   * @return CodeBlockTheme
   */
  setCodeBlockTitleLayoutMarginBottom(marginBottom: Length): CodeBlockTheme

  /**
   * 设置代码块类型文本左边距
   * @param marginLeft 左边距
   * @return CodeBlockTheme
   */
  setCodeBlockTypeTextMarginLeft(marginLeft: Length): CodeBlockTheme

  /**
   * 设置代码块类型文本
   * @param text 类型文本
   * @return CodeBlockTheme
   */
  setCodeBlockTypeText(text: string): CodeBlockTheme

  /**
   * 设置代码块类型文本字体颜色
   * @param color 字体颜色
   * @return CodeBlockTheme
   */
  setCodeBlockTypeTextFontColor(color: ResourceColor): CodeBlockTheme

  /**
   * 设置代码块类型文本字体大小
   * @param size 字体大小
   * @return CodeBlockTheme
   */
  setCodeBlockTypeTextFontSize(size: number | string | Resource): CodeBlockTheme

  /**
   * 设置代码块类型文本字体样式
   * @param style 字体样式
   * @return CodeBlockTheme
   */
  setCodeBlockTypeTextFontStyle(style: FontStyle): CodeBlockTheme

  /**
   * 设置代码块类型文本字体粗细
   * @param weight 字体粗细
   * @return CodeBlockTheme
   */
  setCodeBlockTypeTextFontWeight(weight: number | FontWeight): CodeBlockTheme

  /**
   * 设置代码块类型文本字体族
   * @param family 字体族
   * @return CodeBlockTheme
   */
  setCodeBlockTypeTextFontFamily(family: string | Resource): CodeBlockTheme

  /**
   * 设置代码块类型文本行高
   * @param height 行高
   * @return CodeBlockTheme
   */
  setCodeBlockTypeTextLineHeight(height: number | string | Resource): CodeBlockTheme

  /**
   * 设置代码块复制与全屏间距
   * @param spacing 间距
   * @return CodeBlockTheme
   */
  setCodeBlockCopyFullScreenSpacing(spacing: number): CodeBlockTheme

  /**
   * 设置代码块复制按钮是否显示
   * @param isShow 是否显示
   * @return CodeBlockTheme
   */
  setCodeBlockCopyButtonIsShow(isShow: boolean): CodeBlockTheme

  /**
   * 设置代码块复制文本是否显示
   * @param isShow 是否显示
   * @return CodeBlockTheme
   */
  setCodeBlockCopyTextIsShow(isShow: boolean): CodeBlockTheme

  /**
   * 设置代码块复制图标
   * @param icon 图标
   * @return CodeBlockTheme
   */
  setCodeBlockCopyIcon(icon: Resource): CodeBlockTheme

  /**
   * 设置代码块复制图标宽度
   * @param width 宽度
   * @return CodeBlockTheme
   */
  setCodeBlockCopyIconWidth(width: Length): CodeBlockTheme

  /**
   * 设置代码块复制图标高度
   * @param height 高度
   * @return CodeBlockTheme
   */
  setCodeBlockCopyIconHeight(height: Length): CodeBlockTheme

  /**
   * 设置代码块复制图标文本间距
   * @param spacing 间距
   * @return CodeBlockTheme
   */
  setCodeBlockCopyIconTextSpacing(spacing: number): CodeBlockTheme

  /**
   * 设置代码块复制文本
   * @param text 复制文本
   * @return CodeBlockTheme
   */
  setCodeBlockCopyText(text: string): CodeBlockTheme

  /**
   * 设置代码块复制文本字体颜色
   * @param color 字体颜色
   * @return CodeBlockTheme
   */
  setCodeBlockCopyTextFontColor(color: ResourceColor): CodeBlockTheme

  /**
   * 设置代码块复制文本字体大小
   * @param size 字体大小
   * @return CodeBlockTheme
   */
  setCodeBlockCopyTextFontSize(size: number | string | Resource): CodeBlockTheme

  /**
   * 设置代码块复制文本字体样式
   * @param style 字体样式
   * @return CodeBlockTheme
   */
  setCodeBlockCopyTextFontStyle(style: FontStyle): CodeBlockTheme

  /**
   * 设置代码块复制文本字体粗细
   * @param weight 字体粗细
   * @return CodeBlockTheme
   */
  setCodeBlockCopyTextFontWeight(weight: number | FontWeight): CodeBlockTheme

  /**
   * 设置代码块复制文本字体族
   * @param family 字体族
   * @return CodeBlockTheme
   */
  setCodeBlockCopyTextFontFamily(family: string | Resource): CodeBlockTheme

  /**
   * 设置代码块复制文本行高
   * @param height 行高
   * @return CodeBlockTheme
   */
  setCodeBlockCopyTextLineHeight(height: number | string | Resource): CodeBlockTheme

  /**
   * 设置代码块全屏按钮是否显示
   * @param isShow 是否显示
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenButtonIsShow(isShow: boolean): CodeBlockTheme

  /**
   * 设置代码块全屏文本是否显示
   * @param isShow 是否显示
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenTextIsShow(isShow: boolean): CodeBlockTheme

  /**
   * 设置代码块全屏图标
   * @param icon 图标
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenIcon(icon: Resource): CodeBlockTheme

  /**
   * 设置代码块全屏图标宽度
   * @param width 宽度
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenIconWidth(width: Length): CodeBlockTheme

  /**
   * 设置代码块全屏图标高度
   * @param height 高度
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenIconHeight(height: Length): CodeBlockTheme

  /**
   * 设置代码块全屏图标文本间距
   * @param spacing 间距
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenIconTextSpacing(spacing: number): CodeBlockTheme

  /**
   * 设置代码块全屏文本
   * @param text 全屏文本
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenText(text: string): CodeBlockTheme

  /**
   * 设置代码块全屏文本字体颜色
   * @param color 字体颜色
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenTextFontColor(color: ResourceColor): CodeBlockTheme

  /**
   * 设置代码块全屏文本字体大小
   * @param size 字体大小
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenTextFontSize(size: number | string | Resource): CodeBlockTheme

  /**
   * 设置代码块全屏文本字体样式
   * @param style 字体样式
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenTextFontStyle(style: FontStyle): CodeBlockTheme

  /**
   * 设置代码块全屏文本字体粗细
   * @param weight 字体粗细
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenTextFontWeight(weight: number | FontWeight): CodeBlockTheme

  /**
   * 设置代码块全屏文本字体族
   * @param family 字体族
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenTextFontFamily(family: string | Resource): CodeBlockTheme

  /**
   * 设置代码块全屏文本行高
   * @param height 行高
   * @return CodeBlockTheme
   */
  setCodeBlockFullScreenTextLineHeight(height: number | string | Resource): CodeBlockTheme

  /**
   * 设置代码块行号是否显示
   * @param isShow 是否显示
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberIsShow(isShow: boolean): CodeBlockTheme

  /**
   * 设置代码块行号文本左内边距
   * @param left 左内边距
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberTextPaddingLeft(left: Length): CodeBlockTheme

  /**
   * 设置代码块行号文本字体颜色
   * @param color 字体颜色
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberTextFontColor(color: ResourceColor): CodeBlockTheme

  /**
   * 设置代码块行号文本字体大小
   * @param size 字体大小
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberTextFontSize(size: number | string | Resource): CodeBlockTheme

  /**
   * 设置代码块行号文本字体样式
   * @param style 字体样式
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberTextFontStyle(style: FontStyle): CodeBlockTheme

  /**
   * 设置代码块行号文本字体粗细
   * @param weight 字体粗细
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberTextFontWeight(weight: number | FontWeight): CodeBlockTheme

  /**
   * 设置代码块行号文本字体族
   * @param family 字体族
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberTextFontFamily(family: string | Resource): CodeBlockTheme

  /**
   * 设置代码块行号文本行高
   * @param height 行高
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberTextLineHeight(height: number | string | Resource): CodeBlockTheme

  /**
   * 设置代码块分割线颜色
   * @param color 分割线颜色
   * @return CodeBlockTheme
   */
  setCodeBlockDividerColor(color: ResourceColor): CodeBlockTheme

  /**
   * 设置代码块分割线宽度
   * @param strokeWidth 分割线宽度
   * @return CodeBlockTheme
   */
  setCodeBlockDividerStrokeWidth(strokeWidth: Length): CodeBlockTheme

  /**
   * 设置代码块行号分割线间距
   * @param spacing 间距
   * @return CodeBlockTheme
   */
  setCodeBlockLineNumberDividerSpacing(spacing: number): CodeBlockTheme

  /**
   * 设置代码块文本右边距
   * @param marginRight 右边距
   * @return CodeBlockTheme
   */
  setCodeBlockTextMarginRight(marginRight: Length): CodeBlockTheme

  /**
   * 设置代码块文本左边距
   * @param marginLeft 左边距
   * @return CodeBlockTheme
   */
  setCodeBlockTextMarginLeft(marginLeft: Length): CodeBlockTheme

  /**
   * 设置代码块文本字体颜色
   * @param color 字体颜色
   * @return CodeBlockTheme
   */
  setCodeBlockTextFontColor(color: ResourceColor): CodeBlockTheme

  /**
   * 设置代码块文本字体大小
   * @param size 字体大小
   * @return CodeBlockTheme
   */
  setCodeBlockTextFontSize(size: number | string | Resource): CodeBlockTheme

  /**
   * 设置代码块文本字体样式
   * @param style 字体样式
   * @return CodeBlockTheme
   */
  setCodeBlockTextFontStyle(style: FontStyle): CodeBlockTheme

  /**
   * 设置代码块文本字体粗细
   * @param weight 字体粗细
   * @return CodeBlockTheme
   */
  setCodeBlockTextFontWeight(weight: number | FontWeight): CodeBlockTheme

  /**
   * 设置代码块文本字体族
   * @param family 字体族
   * @return CodeBlockTheme
   */
  setCodeBlockTextFontFamily(family: string | Resource): CodeBlockTheme

  /**
   * 设置代码块文本行高
   * @param height 行高
   * @return CodeBlockTheme
   */
  setCodeBlockTextLineHeight(height: number | string | Resource): CodeBlockTheme

  /**
   * 设置代码块文本字母间距
   * @param spacing 字母间距
   * @return CodeBlockTheme
   */
  setCodeBlockTextLetterSpacing(spacing: number): CodeBlockTheme

  /**
   * 设置代码块列表标题文本大小
   * @param size 文本大小
   * @return CodeBlockTheme
   */
  setCodeBlockListTitleTextSize(size: number): CodeBlockTheme

  /**
   * 设置代码块列表标题选中文本大小
   * @param size 选中文本大小
   * @return CodeBlockTheme
   */
  setCodeBlockListTitleSelectTextSize(size: number): CodeBlockTheme

  /**
   * 设置代码块列表标题选中文本颜色
   * @param color 选中文本颜色
   * @return CodeBlockTheme
   */
  setCodeBlockListTitleSelectTextColor(color: ResourceColor): CodeBlockTheme

  /**
   * 设置代码块列表标题未选中文本颜色
   * @param color 未选中文本颜色
   * @return CodeBlockTheme
   */
  setCodeBlockListTitleUnselectTextColor(color: ResourceColor): CodeBlockTheme

  /**
   * 设置代码块列表标题选中背景颜色
   * @param color 选中背景颜色
   * @return CodeBlockTheme
   */
  setCodeBlockListTitleSelectBackgroundColor(color: ResourceColor): CodeBlockTheme

  /**
   * 设置代码块列表标题未选中背景颜色
   * @param color 未选中背景颜色
   * @return CodeBlockTheme
   */
  setCodeBlockListTitleUnselectBackgroundColor(color: ResourceColor): CodeBlockTheme

  /**
   * 设置代码块是否分离
   * @param isSeparate 是否分离
   * @return CodeBlockTheme
   */
  setCodeBlockIsSeparate(isSeparate: boolean): CodeBlockTheme

  /**
   * 设置代码块分离宽度
   * @param width 分离宽度
   * @return CodeBlockTheme
   */
  setCodeBlockSeparateWidth(width: Length): CodeBlockTheme

  /**
   * 设置代码块分离是否在底部
   * @param isBottom 是否在底部
   * @return CodeBlockTheme
   */
  setCodeBlockSeparateIsBottom(isBottom: boolean): CodeBlockTheme
}
```

### class DefinitionListTheme

定义列表样式配置

```ets
export class DefinitionListTheme {

  /**
   * 设置定义列表背景颜色
   * @param color 定义列表背景颜色
   * @return DefinitionListTheme
   */
  setDefinitionListBackgroundColor(color: ResourceColor): DefinitionListTheme

  /**
   * 设置定义列表外边距
   * @param options 定义列表外边距选项或统一数值
   * @return DefinitionListTheme
   */
  setDefinitionListMargin(options: Margin | Length): DefinitionListTheme

  /**
   * 设置定义列表内边距
   * @param options 定义列表内边距选项或统一数值
   * @return DefinitionListTheme
   */
  setDefinitionListPadding(options: Padding | Length): DefinitionListTheme

  /**
   * 设置定义列表术语到描述间距
   * @param spacing 定义列表术语到描述间距
   * @return DefinitionListTheme
   */
  setDefinitionListTermToDescriptionSpacing(spacing: number): DefinitionListTheme

  /**
   * 设置定义列表术语文本字体粗细
   * @param weight 定义列表术语文本字体粗细
   * @return DefinitionListTheme
   */
  setDefinitionListTermTextFontWeight(weight: number | FontWeight): DefinitionListTheme

  /**
   * 设置定义列表术语文本字体样式
   * @param style 定义列表术语文本字体样式
   * @return DefinitionListTheme
   */
  setDefinitionListTermTextFontStyle(style: FontStyle): DefinitionListTheme

  /**
   * 设置定义列表描述项间距
   * @param spacing 定义列表描述项间距
   * @return DefinitionListTheme
   */
  setDefinitionListDescriptionItemSpacing(spacing: number): DefinitionListTheme

  /**
   * 设置定义列表描述缩进
   * @param indent 定义列表描述缩进
   * @return DefinitionListTheme
   */
  setDefinitionListDescriptionIndent(indent: number): DefinitionListTheme
}
```

### class DividerTheme

分割线样式配置

```ets
export class DividerTheme {

  /**
   * 设置分割线外边距
   * @param options 分割线外边距选项或统一数值
   * @return DividerTheme
   */
  setDividerMargin(options: Margin | Length): DividerTheme

  /**
   * 设置分割线内边距
   * @param options 分割线内边距选项或统一数值
   * @return DividerTheme
   */
  setDividerPadding(options: Padding | Length): DividerTheme

  /**
   * 设置分割线颜色
   * @param color 分割线颜色
   * @return DividerTheme
   */
  setDividerColor(color: ResourceColor): DividerTheme

  /**
   * 设置分割线线条宽度
   * @param strokeWidth 分割线线条宽度
   * @return DividerTheme
   */
  setDividerStrokeWidth(strokeWidth: number): DividerTheme

  /**
   * 设置分割线样式
   * @param style 分割线样式
   * @return DividerTheme
   */
  setDividerStyle(style: LineCapStyle): DividerTheme
}
```

### class FootnoteDefTheme

脚注定义样式配置

```ets
export class FootnoteDefTheme {

  /**
   * 设置脚注定义背景颜色
   * @param color 脚注定义背景颜色
   * @return FootnoteDefTheme
   */
  setFootnoteDefBackgroundColor(color: ResourceColor): FootnoteDefTheme

  /**
   * 设置脚注定义外边距
   * @param options 脚注定义外边距选项或统一数值
   * @return FootnoteDefTheme
   */
  setFootnoteDefMargin(options: Margin | Length): FootnoteDefTheme

  /**
   * 设置脚注定义内边距
   * @param options 脚注定义内边距选项或统一数值
   * @return FootnoteDefTheme
   */
  setFootnoteDefPadding(options: Padding | Length): FootnoteDefTheme
}
```

### class FootnoteRefTheme

脚注引用样式配置

```ets
export class FootnoteRefTheme {

  /**
   * 设置脚注引用文本字体颜色
   * @param color 脚注引用文本字体颜色
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextFontColor(color: ResourceColor): FootnoteRefTheme

  /**
   * 设置脚注引用文本字体大小
   * @param size 脚注引用文本字体大小
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextFontSize(size: number | string | Resource): FootnoteRefTheme

  /**
   * 设置脚注引用文本字体样式
   * @param style 脚注引用文本字体样式
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextFontStyle(style: FontStyle): FootnoteRefTheme

  /**
   * 设置脚注引用文本字体粗细
   * @param weight 脚注引用文本字体粗细
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextFontWeight(weight: number | FontWeight): FootnoteRefTheme

  /**
   * 设置脚注引用文本字体族
   * @param family 脚注引用文本字体族
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextFontFamily(family: string | Resource): FootnoteRefTheme

  /**
   * 设置脚注引用文本行高
   * @param lineHeight 脚注引用文本行高
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextLineHeight(lineHeight: number | string | Resource): FootnoteRefTheme

  /**
   * 设置脚注引用文本字间距
   * @param spacing 脚注引用文本字间距
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextLetterSpacing(spacing: number): FootnoteRefTheme

  /**
   * 设置脚注引用文本装饰类型
   * @param decorationType 脚注引用文本装饰类型
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextDecorationType(decorationType: TextDecorationType): FootnoteRefTheme

  /**
   * 设置脚注引用文本装饰颜色
   * @param color 脚注引用文本装饰颜色
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextDecorationColor(color: ResourceColor): FootnoteRefTheme

  /**
   * 设置脚注引用文本装饰样式
   * @param style 脚注引用文本装饰样式
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextDecorationStyle(style: TextDecorationStyle): FootnoteRefTheme

  /**
   * 设置脚注引用文本背景颜色
   * @param color 脚注引用文本背景颜色
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextBackgroundColor(color: ResourceColor): FootnoteRefTheme

  /**
   * 设置脚注引用文本背景圆角
   * @param options 脚注引用文本背景圆角选项或统一数值
   * @return FootnoteRefTheme
   */
  setFootnoteRefTextBackgroundRadius(options: BorderRadiuses | Length): FootnoteRefTheme
}
```

### class GlobalTheme

全局样式配置

```ets
export class GlobalTheme {

  /**
   * 设置Stage上下文
   * @param context Stage上下文
   * @return GlobalTheme
   */
  setStageContext(context: Context): GlobalTheme

  /**
   * 设置UIAbility上下文
   * @param context UIAbility上下文
   * @return GlobalTheme
   */
  setUiAbilityContext(context: Context): GlobalTheme

  /**
   * 设置Markdown解析器是否同步
   * @param parserSync 同步状态
   * @return GlobalTheme
   */
  setIsMarkdownParserSync(parserSync: boolean): GlobalTheme

  /**
   * 设置是否启用解析节流
   * @param enable 是否启用解析节流，true为markdown控制节流，false为用户自行控制
   * @return GlobalTheme
   */
  setEnableParseThrottle(enable: boolean): GlobalTheme

  /**
   * 设置解析节流间隔
   * @param throttleMs 节流间隔（ms），0表示不节流 - 默认200
   * @return GlobalTheme
   */
  setParseThrottleMs(throttleMs: number): GlobalTheme

  /**
   * 设置是否启用复制功能
   * @param onCopy 复制启用状态
   * @return GlobalTheme
   */
  setIsOnCopy(onCopy: boolean): GlobalTheme

  /**
   * 设置四周外边距
   * @param options 外边距选项或统一数值
   * @return GlobalTheme
   */
  setGlobalMargin(options: Margin | Length): GlobalTheme

  /**
   * 设置Markdown块间距
   * @param space 间距
   * @return GlobalTheme
   */
  setBlockSpacing(space: number): GlobalTheme

  /**
   * 设置是否启用换行渲染
   * @param lineBreak 换行渲染启用状态
   * @return GlobalTheme
   */
  setIsLineBreak(lineBreak: boolean): GlobalTheme

  /**
   * 设置是否启用手势滑动打开
   * @param gestureSwipe 手势滑动启用状态
   * @return GlobalTheme
   */
  setOpenGestureSwipe(gestureSwipe: boolean): GlobalTheme

  /**
   * 设置Markdown容器背景颜色
   * @param color 背景颜色
   * @return GlobalTheme
   */
  setBackgroundColor(color: ResourceColor): GlobalTheme

  /**
   * 设置段落加载动画是否启用
   * @param enabled 是否启用
   * @return GlobalTheme
   */
  setParagraphHeadingAnimationEnabled(enabled: boolean): GlobalTheme

  /**
   * 设置段落加载动画时长
   * @param duration 动画时长（ms）
   * @return GlobalTheme
   */
  setParagraphHeadingAnimationDuration(duration: number): GlobalTheme
}
```

### class HeadingTheme

标题样式配置

```ets
export class HeadingTheme {

  /**
   * 设置所有标题等级背景颜色
   * @param color 背景颜色
   * @return HeadingTheme
   */
  setBackgroundColorForAllHeading(color: ResourceColor): HeadingTheme

  /**
   * 分别设置每个标题等级背景颜色
   * @param colorList 背景颜色列表
   * @return HeadingTheme
   */
  setBackgroundColorForEachHeading(colorList: ResourceColor[]): HeadingTheme

  /**
   * 设置指定标题等级背景颜色
   * @param level 标题等级
   * @param color 背景颜色
   * @return HeadingTheme
   */
  setBackgroundColorForDesignateHeading(level: number, color: ResourceColor): HeadingTheme

  /**
   * 设置标题的4个外边距：设置H1-H6级标题，所有等级的某一个外边距为统一值
   * @param options MarkdownMarginOptions | number 类型
   */
  setMarginForAllHeadingEachLevel(options: Margin | Length): HeadingTheme

  /**
   * 分别设置每个标题等级外边距
   * @param marginList 外边距列表
   * @return HeadingTheme
   */
  setMarginForEachHeading(marginList: Length[]): HeadingTheme

  /**
   * 分别设置H1-H6每级标题的每个外边距
   * @param options 包含四个外边距的H1-H6的数值集合
   * @return HeadingTheme
   */
  setMarginForEachHeadingDetail(options: MarkdownMarginArrayOptions): HeadingTheme

  /**
   * 设置指定标题等级外边距
   * @param level 标题等级
   * @param options 外边距选项或统一数值
   * @return HeadingTheme
   */
  setMarginForDesignateHeading(level: number, options: Margin | Length): HeadingTheme

  /**
   * 设置标题的4个内边距：设置H1-H6级标题，所有等级的内边距为统一值，或某一个内边距6个级别为统一值
   * @param options MarkdownPaddingOptions | number 类型
   */
  setPaddingForAllHeadingEachLevel(options: Padding | Length): HeadingTheme

  /**
   * 分别设置每个标题等级内边距
   * @param paddingList 内边距列表
   * @return HeadingTheme
   */
  setPaddingForEachHeading(paddingList: Length[]): HeadingTheme

  /**
   * 分别设置H1-H6每级标题的每个内边距
   * @param options 包含四个内边距的H1-H6的数值集合
   * @return HeadingTheme
   */
  setPaddingForEachHeadingDetail(options: MarkdownPaddingArrayOptions): HeadingTheme

  /**
   * 设置指定标题等级内边距
   * @param level 标题等级
   * @param options 内边距选项或统一数值
   * @return HeadingTheme
   */
  setPaddingForDesignateHeading(level: number, options: Padding | Length): HeadingTheme

  /**
   * 设置所有标题等级文本字体颜色
   * @param color 字体颜色
   * @return HeadingTheme
   */
  setTextFontColorForAllHeading(color: ResourceColor): HeadingTheme

  /**
   * 分别设置每个标题等级文本字体颜色
   * @param colorList 字体颜色列表
   * @return HeadingTheme
   */
  setTextFontColorForEachHeading(colorList: ResourceColor[]): HeadingTheme

  /**
   * 设置指定标题等级文本字体颜色
   * @param level 标题等级
   * @param color 字体颜色
   * @return HeadingTheme
   */
  setTextFontColorForDesignateHeading(level: number, color: ResourceColor): HeadingTheme

  /**
   * 设置所有标题等级文本字体大小
   * @param size 字体大小
   * @return HeadingTheme
   */
  setTextFontSizeForAllHeading(size: number | string | Resource): HeadingTheme

  /**
   * 分别设置每个标题等级文本字体大小
   * @param sizeList 字体大小列表
   * @return HeadingTheme
   */
  setTextFontSizeForEachHeading(sizeList: (number | string | Resource)[]): HeadingTheme

  /**
   * 设置指定标题等级文本字体大小
   * @param level 标题等级
   * @param size 字体大小
   * @return HeadingTheme
   */
  setTextFontSizeForDesignateHeading(level: number, size: number | string | Resource): HeadingTheme

  /**
   * 设置所有标题等级文本字体样式
   * @param style 字体样式
   * @return HeadingTheme
   */
  setTextFontStyleForAllHeading(style: FontStyle): HeadingTheme

  /**
   * 分别设置每个标题等级文本字体样式
   * @param styleList 字体样式列表
   * @return HeadingTheme
   */
  setTextFontStyleForEachHeading(styleList: FontStyle[]): HeadingTheme

  /**
   * 设置指定标题等级文本字体样式
   * @param level 标题等级
   * @param style 字体样式
   * @return HeadingTheme
   */
  setTextFontStyleForDesignateHeading(level: number, style: FontStyle): HeadingTheme

  /**
   * 设置所有标题等级文本字体粗细
   * @param weight 字体粗细
   * @return HeadingTheme
   */
  setTextFontWeightForAllHeading(weight: number | FontWeight): HeadingTheme

  /**
   * 分别设置每个标题等级文本字体粗细
   * @param weightList 字体粗细列表
   * @return HeadingTheme
   */
  setTextFontWeightForEachHeading(weightList: (number | FontWeight)[]): HeadingTheme

  /**
   * 设置指定标题等级文本字体粗细
   * @param level 标题等级
   * @param weight 字体粗细
   * @return HeadingTheme
   */
  setTextFontWeightForDesignateHeading(level: number, weight: number | FontWeight): HeadingTheme

  /**
   * 设置所有标题等级文本字体族
   * @param family 字体族
   * @return HeadingTheme
   */
  setTextFontFamilyForAllHeading(family: string | Resource): HeadingTheme

  /**
   * 分别设置每个标题等级文本字体族
   * @param familyList 字体族列表
   * @return HeadingTheme
   */
  setTextFontFamilyForEachHeading(familyList: (string | Resource)[]): HeadingTheme

  /**
   * 设置指定标题等级文本字体族
   * @param level 标题等级
   * @param family 字体族
   * @return HeadingTheme
   */
  setTextFontFamilyForDesignateHeading(level: number, family: string | Resource): HeadingTheme

  /**
   * 设置所有标题等级文本行高
   * @param lineHeight 文本行高
   * @return HeadingTheme
   */
  setTextLineHeightForAllHeading(lineHeight: number | string | Resource): HeadingTheme

  /**
   * 分别设置每个标题等级文本行高
   * @param lineHeightList 文本行高列表
   * @return HeadingTheme
   */
  setTextLineHeightForEachHeading(lineHeightList: (number | string | Resource)[]): HeadingTheme

  /**
   * 设置指定标题等级文本行高
   * @param level 标题等级
   * @param lineHeight 文本行高
   * @return HeadingTheme
   */
  setTextLineHeightForDesignateHeading(level: number, lineHeight: number | string | Resource): HeadingTheme

  /**
   * 设置所有标题等级字母间距
   * @param spacing 字母间距
   * @return HeadingTheme
   */
  setTextLetterSpacingForAllHeading(spacing: number): HeadingTheme

  /**
   * 分别设置每个标题等级字母间距
   * @param spacingList 字母间距列表
   * @return HeadingTheme
   */
  setTextLetterSpacingForEachHeading(spacingList: number[]): HeadingTheme

  /**
   * 设置指定标题等级字母间距
   * @param level 标题等级
   * @param spacing 字母间距
   * @return HeadingTheme
   */
  setTextLetterSpacingForDesignateHeading(level: number, spacing: number): HeadingTheme

  /**
   * 设置所有标题下划线高度
   * @param height 下划线高度
   * @return HeadingTheme
   */
  setUnderlineHeightForAllHeading(height: number): HeadingTheme

  /**
   * 设置指定标题等级下划线高度
   * @param level 标题等级
   * @param height 下划线高度
   * @return HeadingTheme
   */
  setUnderlineHeightForDesignateHeading(level: number, height: number): HeadingTheme

  /**
   * 设置所有标题下划线颜色
   * @param color 下划线颜色
   * @return HeadingTheme
   */
  setUnderlineColorForAllHeading(color: ResourceColor): HeadingTheme

  /**
   * 设置指定标题等级下划线颜色
   * @param level 标题等级
   * @param color 下划线颜色
   * @return HeadingTheme
   */
  setUnderlineColorForDesignateHeading(level: number, color: ResourceColor): HeadingTheme

  /**
   * 设置所有标题下划线间距
   * @param spacing 下划线间距
   * @return HeadingTheme
   */
  setUnderlineSpacingForAllHeading(spacing: number): HeadingTheme

  /**
   * 设置指定标题等级下划线间距
   * @param level 标题等级
   * @param spacing 下划线间距
   * @return HeadingTheme
   */
  setUnderlineSpacingForDesignateHeading(level: number, spacing: number): HeadingTheme
}
```

### class HighlightTheme

高亮样式配置

```ets
export class HighlightTheme {

  /**
   * 设置字体颜色
   * @param color 字体颜色
   * @return HighlightTheme
   */
  setHighlightTextFontColor(color: ResourceColor): HighlightTheme

  /**
   * 设置字体大小
   * @param size 字体大小
   * @return HighlightTheme
   */
  setHighlightTextFontSize(size: number | string | Resource): HighlightTheme

  /**
   * 设置字体样式
   * @param style 字体样式
   * @return HighlightTheme
   */
  setHighlightTextFontStyle(style: FontStyle): HighlightTheme

  /**
   * 设置字体粗细
   * @param weight 字体粗细
   * @return HighlightTheme
   */
  setHighlightTextFontWeight(weight: number | FontWeight): HighlightTheme

  /**
   * 设置字体族
   * @param family 字体族
   * @return HighlightTheme
   */
  setHighlightTextFontFamily(family: string | Resource): HighlightTheme

  /**
   * 设置行高
   * @param lineHeight 行高
   * @return HighlightTheme
   */
  setHighlightTextLineHeight(lineHeight: number | string | Resource): HighlightTheme

  /**
   * 设置字间距
   * @param spacing 字间距
   * @return HighlightTheme
   */
  setHighlightTextLetterSpacing(spacing: number): HighlightTheme

  /**
   * 设置背景颜色
   * @param color 背景颜色
   * @return HighlightTheme
   */
  setHighlightTextBackgroundColor(color: ResourceColor): HighlightTheme

  /**
   * 设置背景圆角
   * @param options 圆角选项
   * @return HighlightTheme
   */
  setHighlightTextBackgroundRadius(options: BorderRadiuses | Length): HighlightTheme
}
```

### class HtmlUnderlineTheme

HTML下划线样式配置

```ets
export class HtmlUnderlineTheme {

  /**
   * 设置字体颜色
   * @param color 字体颜色
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextFontColor(color: ResourceColor): HtmlUnderlineTheme

  /**
   * 设置字体大小
   * @param size 字体大小
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextFontSize(size: number | string | Resource): HtmlUnderlineTheme

  /**
   * 设置字体样式
   * @param style 字体样式
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextFontStyle(style: FontStyle): HtmlUnderlineTheme

  /**
   * 设置字体粗细
   * @param weight 字体粗细
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextFontWeight(weight: number | FontWeight): HtmlUnderlineTheme

  /**
   * 设置字体族
   * @param family 字体族
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextFontFamily(family: string | Resource): HtmlUnderlineTheme

  /**
   * 设置行高
   * @param lineHeight 行高
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextLineHeight(lineHeight: number | string | Resource): HtmlUnderlineTheme

  /**
   * 设置字间距
   * @param spacing 字间距
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextLetterSpacing(spacing: number): HtmlUnderlineTheme

  /**
   * 设置装饰颜色
   * @param color 装饰颜色
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextDecorationColor(color: ResourceColor): HtmlUnderlineTheme

  /**
   * 设置装饰样式
   * @param style 装饰样式
   * @return HtmlUnderlineTheme
   */
  setHtmlUnderlineTextDecorationStyle(style: TextDecorationStyle): HtmlUnderlineTheme
}
```

### class ImageTheme

图片样式配置

```ets
export class ImageTheme {

  /**
   * 设置图片边距
   * @param options 边距选项
   * @return ImageTheme
   */
  setImageMargin(options: Margin | Length): ImageTheme

  /**
   * 设置图片圆角
   * @param options 圆角选项
   * @return ImageTheme
   */
  setImageBorderRadius(options: BorderRadiuses | Length): ImageTheme

  /**
   * 设置图片边框样式
   * @param borderStyle 边框样式
   * @return ImageTheme
   */
  setImageBorderStyle(borderStyle: BorderStyle): ImageTheme

  /**
   * 设置图片边框宽度
   * @param borderWidth 边框宽度
   * @return ImageTheme
   */
  setImageBorderWidth(borderWidth: Length): ImageTheme

  /**
   * 设置图片边框颜色
   * @param borderColor 边框颜色
   * @return ImageTheme
   */
  setImageBorderColor(borderColor: ResourceColor): ImageTheme

  /**
   * 设置图片占位图
   * @param placeholder 占位图资源
   * @return ImageTheme
   */
  setImagePlaceholder(placeholder: Resource): ImageTheme

  /**
   * 设置图片自动调整大小
   * @param imageAutoResize 是否自动调整大小
   * @return ImageTheme
   */
  setImageAutoResize(imageAutoResize: boolean): ImageTheme

  /**
   * 设置图片混合布局
   * @param mixedLayout 是否混合布局
   * @return ImageTheme
   */
  setIsImageMixedLayout(mixedLayout: boolean): ImageTheme

  /**
   * 设置图片最大宽度比例
   * @param maximumWidth 最大宽度比例
   * @return ImageTheme
   */
  setImageMaximumWidth(maximumWidth: number): ImageTheme

  /**
   * 设置图片固定比例宽度
   * @param fixedRatioWidth 固定比例宽度
   * @return ImageTheme
   */
  setImageFixedRatioWidth(fixedRatioWidth: number): ImageTheme

  /**
   * 设置图片最大高度
   * @param maxHeight 最大高度
   * @return ImageTheme
   */
  setImageMaxHeight(maxHeight: number): ImageTheme

  /**
   * 设置图片高度
   * @param height 高度
   * @return ImageTheme
   */
  setImageHeight(height: number): ImageTheme

  /**
   * 设置图片最大宽度
   * @param maxWidth 最大宽度
   * @return ImageTheme
   */
  setImageMaxWidth(maxWidth: number): ImageTheme

  /**
   * 设置图片宽度
   * @param width 宽度
   * @return ImageTheme
   */
  setImageWidth(width: number): ImageTheme

  /**
   * 设置图片填充类型
   * @param fitType 填充类型
   * @return ImageTheme
   */
  setImageFitType(fitType: ImageFit): ImageTheme

  /**
   * 设置图片底部布局上边距
   * @param marginTop 上边距
   * @return ImageTheme
   */
  setImageBottomLayoutMarginTop(marginTop: Length): ImageTheme

  /**
   * 设置图片下载按钮可见性
   * @param visible 是否可见
   * @return ImageTheme
   */
  setImageDownloadButtonVisible(visible: boolean): ImageTheme

  /**
   * 设置图片下载按钮宽度
   * @param width 宽度
   * @return ImageTheme
   */
  setImageDownloadButtonWidth(width: Length): ImageTheme

  /**
   * 设置图片下载按钮高度
   * @param height 高度
   * @return ImageTheme
   */
  setImageDownloadButtonHeight(height: Length): ImageTheme

  /**
   * 设置图片下载按钮圆角
   * @param options 圆角选项
   * @return ImageTheme
   */
  setImageDownloadButtonRadius(options: BorderRadiuses | Length): ImageTheme

  /**
   * 设置图片下载按钮图标文本间距
   * @param iconTextGap 图标文本间距
   * @return ImageTheme
   */
  setImageDownloadButtonIconTextGap(iconTextGap: number): ImageTheme

  /**
   * 设置图片下载按钮图标
   * @param icon 图标资源
   * @return ImageTheme
   */
  setImageDownloadButtonIcon(icon: Resource): ImageTheme

  /**
   * 设置图片下载按钮图标宽度
   * @param width 宽度
   * @return ImageTheme
   */
  setImageDownloadButtonIconWidth(width: Length): ImageTheme

  /**
   * 设置图片下载按钮图标高度
   * @param height 高度
   * @return ImageTheme
   */
  setImageDownloadButtonIconHeight(height: Length): ImageTheme

  /**
   * 设置图片下载按钮背景颜色
   * @param color 背景颜色
   * @return ImageTheme
   */
  setImageDownloadButtonBackgroundColor(color: ResourceColor): ImageTheme

  /**
   * 设置图片下载按钮文本
   * @param text 文本
   * @return ImageTheme
   */
  setImageDownloadButtonText(text: string): ImageTheme

  /**
   * 设置图片下载按钮文本字体颜色
   * @param color 字体颜色
   * @return ImageTheme
   */
  setImageDownloadButtonTextFontColor(color: ResourceColor): ImageTheme

  /**
   * 设置图片下载按钮文本字体大小
   * @param size 字体大小
   * @return ImageTheme
   */
  setImageDownloadButtonTextFontSize(size: number | string | Resource): ImageTheme

  /**
   * 设置图片下载按钮文本字体样式
   * @param style 字体样式
   * @return ImageTheme
   */
  setImageDownloadButtonTextFontStyle(style: FontStyle): ImageTheme

  /**
   * 设置图片下载按钮文本字体粗细
   * @param weight 字体粗细
   * @return ImageTheme
   */
  setImageDownloadButtonTextFontWeight(weight: number | FontWeight): ImageTheme

  /**
   * 设置图片下载按钮文本字体族
   * @param family 字体族
   * @return ImageTheme
   */
  setImageDownloadButtonTextFontFamily(family: string | Resource): ImageTheme

  /**
   * 设置图片下载按钮文本行高
   * @param lineHeight 行高
   * @return ImageTheme
   */
  setImageDownloadButtonTextLineHeight(lineHeight: number | string | Resource): ImageTheme
}
```

### class InlineCodeTheme

内联代码样式配置

```ets
export class InlineCodeTheme {

  /**
   * 设置字体颜色
   * @param color 字体颜色
   * @return InlineCodeTheme
   */
  setInlineCodeTextFontColor(color: ResourceColor): InlineCodeTheme

  /**
   * 设置字体大小
   * @param size 字体大小
   * @return InlineCodeTheme
   */
  setInlineCodeTextFontSize(size: number | string | Resource): InlineCodeTheme

  /**
   * 设置字体样式
   * @param style 字体样式
   * @return InlineCodeTheme
   */
  setInlineCodeTextFontStyle(style: FontStyle): InlineCodeTheme

  /**
   * 设置字体粗细
   * @param weight 字体粗细
   * @return InlineCodeTheme
   */
  setInlineCodeTextFontWeight(weight: number | FontWeight): InlineCodeTheme

  /**
   * 设置字体族
   * @param family 字体族
   * @return InlineCodeTheme
   */
  setInlineCodeTextFontFamily(family: string | Resource): InlineCodeTheme

  /**
   * 设置行高
   * @param lineHeight 行高
   * @return InlineCodeTheme
   */
  setInlineCodeTextLineHeight(lineHeight: number | string | Resource): InlineCodeTheme

  /**
   * 设置字间距
   * @param spacing 字间距
   * @return InlineCodeTheme
   */
  setInlineCodeTextLetterSpacing(spacing: number): InlineCodeTheme

  /**
   * 设置背景颜色
   * @param color 背景颜色
   * @return InlineCodeTheme
   */
  setInlineCodeTextBackgroundColor(color: ResourceColor): InlineCodeTheme

  /**
   * 设置背景圆角
   * @param options 圆角选项
   * @return InlineCodeTheme
   */
  setInlineCodeTextBackgroundRadius(options: BorderRadiuses | Length): InlineCodeTheme
}
```

### class ItalicTheme

斜体样式配置

```ets
export class ItalicTheme {

  /**
   * 设置斜体字体颜色
   * @param color 字体颜色
   * @return ItalicTheme
   */
  setItalicTextFontColor(color: ResourceColor): ItalicTheme

  /**
   * 设置斜体字体大小
   * @param size 字体大小
   * @return ItalicTheme
   */
  setItalicTextFontSize(size: number | string | Resource): ItalicTheme

  /**
   * 设置斜体字体粗细
   * @param weight 字体粗细
   * @return ItalicTheme
   */
  setItalicTextFontWeight(weight: number | FontWeight): ItalicTheme

  /**
   * 设置斜体字体族
   * @param family 字体族
   * @return ItalicTheme
   */
  setItalicTextFontFamily(family: string | Resource): ItalicTheme

  /**
   * 设置斜体行高
   * @param lineHeight 行高
   * @return ItalicTheme
   */
  setItalicTextLineHeight(lineHeight: number | string | Resource): ItalicTheme

  /**
   * 设置斜体字间距
   * @param spacing 字间距
   * @return ItalicTheme
   */
  setItalicTextLetterSpacing(spacing: number): ItalicTheme
}
```

### class LatexMathTheme

数学公式样式配置

```ets
export class LatexMathTheme {

  /**
   * 设置LaTeX数学公式外边距
   * @param options Margin | Length 类型
   * @return LatexMathTheme
   */
  setLatexMathMargin(options: Margin | Length): LatexMathTheme

  /**
   * 设置LaTeX数学公式内边距
   * @param options Padding | Length 类型
   * @return LatexMathTheme
   */
  setLatexMathPadding(options: Padding | Length): LatexMathTheme

  /**
   * 设置数学公式未加载状态是否显示文字
   * @param defaultText 是否显示文字
   * @return LatexMathTheme
   */
  setLatexMathDefaultText(defaultText: boolean): LatexMathTheme

  /**
   * 设置数学公式未加载状态文本颜色
   * @param color 文本颜色
   * @return LatexMathTheme
   */
  setLatexMathDefaultTextFontColor(color: ResourceColor): LatexMathTheme

  /**
   * 设置数学公式未加载状态文本尺寸
   * @param size 文本尺寸
   * @return LatexMathTheme
   */
  setLatexMathDefaultTextFontSize(size: number | string | Resource): LatexMathTheme

  /**
   * 设置数学公式未加载状态文本字体样式
   * @param style 文本字体样式
   * @return LatexMathTheme
   */
  setLatexMathDefaultTextFontStyle(style: FontStyle): LatexMathTheme

  /**
   * 设置数学公式未加载状态文本字体粗细
   * @param weight 文本字体粗细
   * @return LatexMathTheme
   */
  setLatexMathDefaultTextFontWeight(weight: number | FontWeight): LatexMathTheme

  /**
   * 设置数学公式未加载状态文本字体
   * @param family 文本字体
   * @return LatexMathTheme
   */
  setLatexMathDefaultTextFontFamily(family: string | Resource): LatexMathTheme

  /**
   * 设置数学公式文本大小
   * @param size 文本大小 - 单位fp
   * @return LatexMathTheme
   */
  setLatexMathTextSize(size: number): LatexMathTheme

  /**
   * 设置数学公式背景颜色
   * @param color 背景颜色
   * @return LatexMathTheme
   */
  setLatexMathBackgroundColor(color: ResourceColor): LatexMathTheme

  /**
   * 设置数学公式文本颜色
   * @param color 文本颜色
   * @return LatexMathTheme
   */
  setLatexMathTextColor(color: ResourceColor): LatexMathTheme

  /**
   * 设置数学公式生成图片格式
   * @param colorFormat 图片格式 - 0:RGB_565, 1:BGRA_8888。默认1
   * @return LatexMathTheme
   */
  setLatexMathColorFormat(colorFormat: LatexMathColorFormat): LatexMathTheme

  /**
   * 设置块结构的数学公式是否居中
   * @param center 是否居中
   * @return LatexMathTheme
   */
  setLatexMathBlockCenter(center: boolean): LatexMathTheme

  /**
   * 设置数学公式资源路径
   * @param path 资源路径
   * @return LatexMathTheme
   */
  setLatexMathResPath(path: string): LatexMathTheme
}
```

### class LinkTheme

链接样式配置

```ets
export class LinkTheme {

  /**
   * 设置链接是否图标显示
   * @param isIcon 链接是否图标显示
   * @return LinkTheme
   */
  setLinkIsIcon(isIcon: boolean): LinkTheme

  /**
   * 设置列表中链接是否图标显示
   * @param isIcon 列表中链接是否图标显示
   * @return LinkTheme
   */
  setLinkListIsIcon(isIcon: boolean): LinkTheme

  /**
   * 设置链接文本字体颜色
   * @param color 链接文本字体颜色
   * @return LinkTheme
   */
  setLinkTextFontColor(color: ResourceColor): LinkTheme

  /**
   * 设置链接文本字体大小
   * @param size 链接文本字体大小
   * @return LinkTheme
   */
  setLinkTextFontSize(size: number | string | Resource | undefined): LinkTheme

  /**
   * 设置链接文本字体样式
   * @param style 链接文本字体样式
   * @return LinkTheme
   */
  setLinkTextFontStyle(style: FontStyle): LinkTheme

  /**
   * 设置链接文本字体粗细
   * @param weight 链接文本字体粗细
   * @return LinkTheme
   */
  setLinkTextFontWeight(weight: number | FontWeight): LinkTheme

  /**
   * 设置链接文本字体族
   * @param family 链接文本字体族
   * @return LinkTheme
   */
  setLinkTextFontFamily(family: string | Resource): LinkTheme

  /**
   * 设置链接文本行高
   * @param lineHeight 链接文本行高
   * @return LinkTheme
   */
  setLinkTextLineHeight(lineHeight: number | string | Resource): LinkTheme

  /**
   * 设置链接文本字间距
   * @param spacing 链接文本字间距
   * @return LinkTheme
   */
  setLinkTextLetterSpacing(spacing: number): LinkTheme

  /**
   * 设置链接文本装饰类型
   * @param decorationType 链接文本装饰类型
   * @return LinkTheme
   */
  setLinkTextDecorationType(decorationType: TextDecorationType): LinkTheme

  /**
   * 设置链接文本装饰颜色
   * @param color 链接文本装饰颜色
   * @return LinkTheme
   */
  setLinkTextDecorationColor(color: ResourceColor): LinkTheme

  /**
   * 设置链接文本装饰样式
   * @param style 链接文本装饰样式
   * @return LinkTheme
   */
  setLinkTextDecorationStyle(style: TextDecorationStyle): LinkTheme

  /**
   * 设置链接文本背景颜色
   * @param color 链接文本背景颜色
   * @return LinkTheme
   */
  setLinkTextBackgroundColor(color: ResourceColor): LinkTheme

  /**
   * 设置链接文本背景圆角
   * @param options 链接文本背景圆角选项或统一数值
   * @return LinkTheme
   */
  setLinkTextBackgroundRadius(options: BorderRadiuses | Length): LinkTheme

  /**
   * 设置链接圆形图标背景颜色
   * @param color 链接圆形图标背景颜色
   * @return LinkTheme
   */
  setLinkCircleIconBackgroundColor(color: ResourceColor): LinkTheme

  /**
   * 设置链接圆形图标按钮背景颜色
   * @param color 链接圆形图标按钮背景颜色
   * @return LinkTheme
   */
  setLinkCircleIconButtonBackgroundColor(color: ResourceColor): LinkTheme

  /**
   * 设置链接圆形图标文本大小
   * @param size 链接圆形图标文本大小
   * @return LinkTheme
   */
  setLinkCircleIconTextSize(size: number): LinkTheme

  /**
   * 设置链接圆形图标文本颜色
   * @param color 链接圆形图标文本颜色
   * @return LinkTheme
   */
  setLinkCircleIconTextColor(color: ResourceColor): LinkTheme

  /**
   * 设置链接圆形图标半径
   * @param radius 链接圆形图标半径
   * @return LinkTheme
   */
  setLinkCircleIconRadius(radius: number): LinkTheme

  /**
   * 设置链接圆形图标外边距
   * @param margin 链接圆形图标外边距
   * @return LinkTheme
   */
  setLinkCircleIconMargin(margin: number): LinkTheme

  /**
   * 设置链接方形图标背景颜色
   * @param color 链接方形图标背景颜色
   * @return LinkTheme
   */
  setLinkRectIconBackgroundColor(color: ResourceColor): LinkTheme

  /**
   * 设置链接方形图标按钮背景颜色
   * @param color 链接方形图标按钮背景颜色
   * @return LinkTheme
   */
  setLinkRectIconButtonBackgroundColor(color: ResourceColor): LinkTheme

  /**
   * 设置链接方形图标文本大小
   * @param size 链接方形图标文本大小
   * @return LinkTheme
   */
  setLinkRectIconTextSize(size: number): LinkTheme

  /**
   * 设置链接方形图标文本颜色
   * @param color 链接方形图标文本颜色
   * @return LinkTheme
   */
  setLinkRectIconTextColor(color: ResourceColor): LinkTheme

  /**
   * 设置链接方形图标高度
   * @param height 链接方形图标高度
   * @return LinkTheme
   */
  setLinkRectIconHeight(height: Length): LinkTheme

  /**
   * 设置链接方形图标内边距
   * @param padding 链接方形图标内边距
   * @return LinkTheme
   */
  setLinkRectIconPadding(padding: number): LinkTheme

  /**
   * 设置链接方形图标圆角
   * @param radius 链接方形图标圆角
   * @return LinkTheme
   */
  setLinkRectIconRadius(radius: number): LinkTheme

  /**
   * 设置链接方形图标外边距
   * @param margin 链接方形图标外边距
   * @return LinkTheme
   */
  setLinkRectIconMargin(margin: number): LinkTheme

  /**
   * 设置链接空心方形图标背景颜色
   * @param color 链接空心方形图标背景颜色
   * @return LinkTheme
   */
  setLinkRectToolIconBackgroundColor(color: ResourceColor): LinkTheme

  /**
   * 设置链接空心方形图标按钮背景颜色
   * @param color 链接空心方形图标按钮背景颜色
   * @return LinkTheme
   */
  setLinkRectToolIconButtonBackgroundColor(color: ResourceColor): LinkTheme

  /**
   * 设置链接空心方形图标文本大小
   * @param size 链接空心方形图标文本大小
   * @return LinkTheme
   */
  setLinkRectToolIconTextSize(size: number): LinkTheme

  /**
   * 设置链接空心方形图标高度
   * @param height 链接空心方形图标高度
   * @return LinkTheme
   */
  setLinkRectToolIconHeight(height: Length): LinkTheme

  /**
   * 设置链接空心方形图标内边距
   * @param padding 链接空心方形图标内边距
   * @return LinkTheme
   */
  setLinkRectToolIconPadding(padding: number): LinkTheme

  /**
   * 设置链接空心方形图标边框宽度
   * @param width 链接空心方形图标边框宽度
   * @return LinkTheme
   */
  setLinkRectToolIconBorderWidth(width: Length): LinkTheme

  /**
   * 设置链接空心方形图标分割线宽度
   * @param width 链接空心方形图标分割线宽度
   * @return LinkTheme
   */
  setLinkRectToolIconDividingLineWidth(width: Length): LinkTheme

  /**
   * 设置链接空心方形图标外边距
   * @param margin 链接空心方形图标外边距
   * @return LinkTheme
   */
  setLinkRectToolIconMargin(margin: number): LinkTheme

  /**
   * 设置链接空心方形图标分割线左内边距
   * @param padding 链接空心方形图标分割线左内边距
   * @return LinkTheme
   */
  setLinkRectToolIconLineLeftPadding(padding: number): LinkTheme

  /**
   * 设置链接空心方形图标分割线右内边距
   * @param padding 链接空心方形图标分割线右内边距
   * @return LinkTheme
   */
  setLinkRectToolIconLineRightPadding(padding: number): LinkTheme
}
```

### class MarkdownTheme

Markdown样式配置

```ets
export class MarkdownTheme {

  /**
   * 设置上下文
   * @param context 上下文
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setStageContext
   */
  setContext(context: Context): MarkdownTheme

  /**
   * 设置默认浅色主题
   * @return MarkdownTheme
   */
  setDefaultTheme(): MarkdownTheme

  /**
   * 设置Darcula深色主题
   * @return MarkdownTheme
   */
  setDarculaTheme(): MarkdownTheme

  /**
   * 设置全局样式
   * @param globalTheme 全局样式
   * @return MarkdownTheme
   */
  setGlobalTheme(globalTheme: GlobalTheme): MarkdownTheme

  /**
   * 设置音频样式
   * @param audioTheme 音频样式
   * @return MarkdownTheme
   */
  setAudioTheme(audioTheme: AudioTheme): MarkdownTheme

  /**
   * 设置Banner样式
   * @param bannerTheme Banner样式
   * @return MarkdownTheme
   */
  setBannerTheme(bannerTheme: BannerTheme): MarkdownTheme

  /**
   * 设置块引用样式
   * @param blockQuoteTheme 块引用样式
   * @return MarkdownTheme
   */
  setBlockQuoteTheme(blockQuoteTheme: BlockQuoteTheme): MarkdownTheme

  /**
   * 设置加粗文本样式
   * @param boldTheme 加粗文本样式
   * @return MarkdownTheme
   */
  setBoldTheme(boldTheme: BoldTheme): MarkdownTheme

  /**
   * 设置代码块样式
   * @param codeBlockTheme 代码块样式
   * @return MarkdownTheme
   */
  setCodeBlockTheme(codeBlockTheme: CodeBlockTheme): MarkdownTheme

  /**
   * 设置定义列表样式
   * @param definitionListTheme 定义列表样式
   * @return MarkdownTheme
   */
  setDefinitionListTheme(definitionListTheme: DefinitionListTheme): MarkdownTheme

  /**
   * 设置分割线样式
   * @param dividerTheme 分割线样式
   * @return MarkdownTheme
   */
  setDividerTheme(dividerTheme: DividerTheme): MarkdownTheme

  /**
   * 设置脚注定义样式
   * @param footnoteDefTheme 脚注定义样式
   * @return MarkdownTheme
   */
  setFootnoteDefTheme(footnoteDefTheme: FootnoteDefTheme): MarkdownTheme

  /**
   * 设置脚注引用样式
   * @param footnoteRefTheme 脚注引用样式
   * @return MarkdownTheme
   */
  setFootnoteRefTheme(footnoteRefTheme: FootnoteRefTheme): MarkdownTheme

  /**
   * 设置标题样式
   * @param headingTheme 标题样式
   * @return MarkdownTheme
   */
  setHeadingTheme(headingTheme: HeadingTheme): MarkdownTheme

  /**
   * 设置HTML下划线文本样式
   * @param htmlUnderlineTheme HTML下划线文本样式
   * @return MarkdownTheme
   */
  setHtmlUnderlineTheme(htmlUnderlineTheme: HtmlUnderlineTheme): MarkdownTheme

  /**
   * 设置图片样式
   * @param imageTheme 图片样式
   * @return MarkdownTheme
   */
  setImageTheme(imageTheme: ImageTheme): MarkdownTheme

  /**
   * 设置内联代码样式
   * @param inlineCodeTheme 内联代码样式
   * @return MarkdownTheme
   */
  setInlineCodeTheme(inlineCodeTheme: InlineCodeTheme): MarkdownTheme

  /**
   * 设置斜体文本样式
   * @param italicTheme 斜体文本样式
   * @return MarkdownTheme
   */
  setItalicTheme(italicTheme: ItalicTheme): MarkdownTheme

  /**
   * 设置数学公式样式
   * @param latexMathTheme 数学公式样式
   * @return MarkdownTheme
   */
  setLatexMathTheme(latexMathTheme: LatexMathTheme): MarkdownTheme

  /**
   * 设置数学公式未加载状态是否显示文字
   * @param latexDefaultText 数学公式未加载状态是否显示文字 - 默认true
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathDefaultText
   */
  setLatexDefaultText(latexDefaultText: boolean): MarkdownTheme

  /**
   * 设置数学公式文本大小
   * @param latexMathTextSize 数学公式文本大小 - 默认16.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathDefaultTextFontSize
   */
  setLatexMathTextSize(latexMathTextSize: number): MarkdownTheme

  /**
   * 设置数学公式背景色
   * @param latexMathBackgroundColor 数学公式背景色 - 默认0x00FFFFFF
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathBackgroundColor
   */
  setLatexMathBackgroundColor(latexMathBackgroundColor: ResourceColor): MarkdownTheme

  /**
   * 设置数学公式文本颜色
   * @param latexMathTextColor 数学公式文本颜色 - 默认0xFF000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathTextColor
   */
  setLatexMathTextColor(latexMathTextColor: ResourceColor): MarkdownTheme

  /**
   * 设置数学公式生成图片格式
   * @param latexMathColorFormat 数学公式生成图片格式 - 0:RGB_565, 1:BGRA_8888。默认1
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathColorFormat
   */
  setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): MarkdownTheme

  /**
   * 设置块结构的数学公式是否居中
   * @param latexMathBlockCenter 块结构的数学公式是否居中 - true：居中；false：不居中。默认true
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathBlockCenter
   */
  setLatexMathBlockCenter(latexMathBlockCenter: boolean): MarkdownTheme

  /**
   * 设置数学公式字体路径
   * @param latexMathResStr 数学公式字体路径 默认 "/data/storage/el1/bundle/entry/resources/resfile/res"
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathResPath
   */
  setLatexMathResStr(latexMathResStr: string): MarkdownTheme

  /**
   * 设置链接文本样式
   * @param linkTheme 链接文本样式
   * @return MarkdownTheme
   */
  setLinkTheme(linkTheme: LinkTheme): MarkdownTheme

  /**
   * 设置有序列表样式
   * @param orderedListTheme 有序列表样式
   * @return MarkdownTheme
   */
  setOrderedListTheme(orderedListTheme: OrderedListTheme): MarkdownTheme

  /**
   * 设置段落样式
   * @param paragraphTheme 段落样式
   * @return MarkdownTheme
   */
  setParagraphTheme(paragraphTheme: ParagraphTheme): MarkdownTheme

  /**
   * 设置删除线文本样式
   * @param strikethroughTheme 删除线文本样式
   * @return MarkdownTheme
   */
  setStrikethroughTheme(strikethroughTheme: StrikethroughTheme): MarkdownTheme

  /**
   * 设置下标文本样式
   * @param subTheme 下标文本样式
   * @return MarkdownTheme
   */
  setSubTheme(subTheme: SubTheme): MarkdownTheme

  /**
   * 设置上标文本样式
   * @param supTheme 上标文本样式
   * @return MarkdownTheme
   */
  setSupTheme(supTheme: SupTheme): MarkdownTheme

  /**
   * 设置表格样式
   * @param tableTheme 表格样式
   * @return MarkdownTheme
   */
  setTableTheme(tableTheme: TableTheme): MarkdownTheme

  /**
   * 设置无序/任务列表样式
   * @param bulletListTheme 无序/任务列表样式
   * @return MarkdownTheme
   */
  setBulletListTheme(bulletListTheme: BulletListTheme): MarkdownTheme

  /**
   * 设置视频样式
   * @param videoTheme 视频样式
   * @return MarkdownTheme
   */
  setVideoTheme(videoTheme: VideoTheme): MarkdownTheme

  /**
   * 设置高亮样式
   * @param highlightTheme 高亮样式
   * @return MarkdownTheme
   */
  setHighlightTheme(highlightTheme: HighlightTheme): MarkdownTheme

  /**
   * 设置代码块全屏图片icon
   * @param codeFullScreenIcon 代码块全屏图片icon
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenIcon
   */
  setCodeFullScreenIcon(codeFullScreenIcon: Resource): MarkdownTheme

  /**
   * 设置代码块复制图片icon
   * @param codeCopyIcon 代码块复制图片icon
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockCopyIcon
   */
  setCodeCopyIcon(codeCopyIcon: Resource): MarkdownTheme

  /**
   * 设置音频图片icon
   * @param audioIcon 音频图片icon
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioIcon
   */
  setAudioIcon(audioIcon: Resource): MarkdownTheme

  /**
   * 设置视频默认占位图
   * @param videoImage 视频默认占位图
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoPlaceholder
   */
  setVideoImage(videoImage: Resource): MarkdownTheme

  /**
   * 设置视频播放按钮icon
   * @param playCircleFillIcon 视频播放按钮icon
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoPlayIcon
   */
  setPlayCircleFillIcon(playCircleFillIcon: Resource): MarkdownTheme

  /**
   * 设置banner占位图
   * @param bannerImage banner占位图
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead BannerTheme#setBannerPlaceholder
   */
  setBannerImage(bannerImage: Resource): MarkdownTheme

  /**
   * 设置图片占位图
   * @param imageResource 图片占位图
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImagePlaceholder
   */
  setImageResource(imageResource: Resource): MarkdownTheme

  /**
   * 设置视频发布默认图标
   * @param videoReleaseImage 视频发布默认图标
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonIcon
   */
  setVideoReleaseImage(videoReleaseImage: Resource): MarkdownTheme

  /**
   * 设置视频下载默认图标
   * @param videoDownloadImage 视频下载默认图标
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonIcon
   */
  setVideoDownloadImage(videoDownloadImage: Resource): MarkdownTheme

  /**
   * 设置图片下载默认图标
   * @param imageDownloadImage 图片下载默认图标
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonIcon
   */
  setImageDownloadImage(imageDownloadImage: Resource): MarkdownTheme

  /**
   * 设置markdown是否同步解析
   * @param isMarkdownParserSync markdown是否同步解析 - 默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setIsMarkdownParserSync
   */
  setIsMarkdownParserSync(isMarkdownParserSync: boolean): MarkdownTheme

  /**
   * 设置是否打开长按复制粘贴
   * @param isOnCopy 是否打开长按复制粘贴 - 默认true
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setIsOnCopy
   */
  setIsOnCopy(isOnCopy: boolean): MarkdownTheme

  /**
   * 设置markdown第一个模块上边距
   * @param blockFirstTopMargin markdown第一个模块上边距 - 默认8.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setGlobalMargin
   */
  setBlockFirstTopMargin(blockFirstTopMargin: number): MarkdownTheme

  /**
   * 设置markdown最后一个模块下边距
   * @param blockLastBottomMargin markdown最后一个模块下边距 - 默认8.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setGlobalMargin
   */
  setBlockLastBottomMargin(blockLastBottomMargin: number): MarkdownTheme

  /**
   * 设置模块间上下间距
   * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setBlockSpacing
   */
  setBlockTopAndBottomMargins(blockTopAndBottomMargins: number): MarkdownTheme

  /**
   * 设置链接是否是图片显示
   * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkIsIcon
   */
  setIsLinkStyle(isLinkStyle: boolean): MarkdownTheme

  /**
   * 设置列表中的单行链接是否是图片显示
   * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkListIsIcon
   */
  setIsListLinkStyle(isListLinkStyle: boolean): MarkdownTheme

  /**
   * 设置文本格式链接文本颜色
   * @param linkColor 文本格式链接文本颜色 - 默认0xFF0000FF
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextFontColor
   */
  setLinkColor(linkColor: number): MarkdownTheme

  /**
   * 设置是否按照链接文本字体大小显示文本
   * @param isLinkSize 是否按照链接文本字体大小显示文本 - true：显示链接字体文本大小；false：跟随标题段落大小显示。默认true
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextFontSize
   */
  setIsLinkSize(isLinkSize: boolean): MarkdownTheme

  /**
   * 设置文本格式链接文字大小
   * @param linkSize 文本格式链接文字大小 - 默认14.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextFontSize
   */
  setLinkSize(linkSize: number): MarkdownTheme

  /**
   * 设置文本格式链接文字行高
   * @param linkLineHeight 文本格式链接文字行高
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextLineHeight
   */
  setLinkLineHeight(linkLineHeight: number): MarkdownTheme

  /**
   * 设置文本格式链接背景颜色
   * @param linkBackgroundColor 文本格式链接背景颜色 - 默认0xFF000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextBackgroundColor
   */
  setLinkBackgroundColor(linkBackgroundColor: number): MarkdownTheme

  /**
   * 设置文本格式是否显示链接下划线
   * @param isLinkUnderlined 文本格式是否显示链接下划线 - true：显示下划线；false：不显示下划线。默认true
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextDecorationType
   */
  setIsLinkUnderlined(isLinkUnderlined: boolean): MarkdownTheme

  /**
   * 设置圆形图片格式链接主题背景颜色
   * @param linkCircleImageBackgroundColor 圆形图片格式链接主题背景颜色 - 默认0x00FFFFFF
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconBackgroundColor
   */
  setLinkCircleImageBackgroundColor(linkCircleImageBackgroundColor: number): MarkdownTheme

  /**
   * 设置圆形图片格式链接控件背景颜色
   * @param linkCircleImageButtonBackgroundColor 圆形图片格式链接控件背景颜色 - 默认0xFF000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconButtonBackgroundColor
   */
  setLinkCircleImageButtonBackgroundColor(linkCircleImageButtonBackgroundColor: number): MarkdownTheme

  /**
   * 设置圆形图片格式链接文字大小
   * @param linkCircleImageTextSize 圆形图片格式链接文字大小 - 默认14.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconTextSize
   */
  setLinkCircleImageTextSize(linkCircleImageTextSize: number): MarkdownTheme

  /**
   * 设置圆形图片格式链接文字颜色
   * @param linkCircleImageTextColor 圆形图片格式链接文字颜色 - 默认0xFFFFFFFF
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconTextColor
   */
  setLinkCircleImageTextColor(linkCircleImageTextColor: number): MarkdownTheme

  /**
   * 设置圆形图片格式链接半径
   * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconRadius
   */
  setLinkCircleImageRadius(linkCircleImageRadius: number): MarkdownTheme

  /**
   * 设置圆形图片格式链接左右外边距
   * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconMargin
   */
  setLinkCircleImageMargin(linkCircleImageMargin: number): MarkdownTheme

  /**
   * 设置圆角矩形图片格式链接主题背景颜色
   * @param linkRectImageBackgroundColor 圆角矩形图片格式链接主题背景颜色 - 默认0x00FFFFFF
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconBackgroundColor
   */
  setLinkRectImageBackgroundColor(linkRectImageBackgroundColor: number): MarkdownTheme

  /**
   * 设置圆角矩形图片格式链接控件背景颜色
   * @param linkRectImageButtonBackgroundColor 圆角矩形图片格式链接控件背景颜色 - 默认0xFF000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconButtonBackgroundColor
   */
  setLinkRectImageButtonBackgroundColor(linkRectImageButtonBackgroundColor: number): MarkdownTheme

  /**
   * 设置圆角矩形图片格式链接文字大小
   * @param linkRectImageTextSize 圆角矩形图片格式链接文字大小 - 默认14.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconTextSize
   */
  setLinkRectImageTextSize(linkRectImageTextSize: number): MarkdownTheme

  /**
   * 设置圆角矩形图片格式链接文字颜色
   * @param linkRectImageTextColor 圆角矩形图片格式链接文字颜色 - 默认0xFFFFFFFF
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconTextColor
   */
  setLinkRectImageTextColor(linkRectImageTextColor: number): MarkdownTheme

  /**
   * 设置圆角矩形图片格式链接控件高度
   * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconHeight
   */
  setLinkRectImageHeight(linkRectImageHeight: Length): MarkdownTheme

  /**
   * 设置圆角矩形图片格式链接左右内边距
   * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconPadding
   */
  setLinkRectImagePadding(linkRectImagePadding: number): MarkdownTheme

  /**
   * 设置圆角矩形图片格式链接圆角半径
   * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconRadius
   */
  setLinkRectImageRadius(linkRectImageRadius: number): MarkdownTheme

  /**
   * 设置圆角矩形图片格式链接左右外边距
   * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconMargin
   */
  setLinkRectImageMargin(linkRectImageMargin: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接主题背景颜色
   * @param linkRectToolImageBackgroundColor 空心圆角矩形图片格式链接主题背景颜色 - 默认0x00FFFFFF
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconBackgroundColor
   */
  setLinkRectToolImageBackgroundColor(linkRectToolImageBackgroundColor: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接控件背景颜色
   * @param linkRectToolImageButtonBackgroundColor 空心圆角矩形图片格式链接控件背景颜色 - 默认0xFFFFFFFF
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconButtonBackgroundColor
   */
  setLinkRectToolImageButtonBackgroundColor(linkRectToolImageButtonBackgroundColor: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接文字大小
   * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文字大小 - 默认14.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconTextSize
   */
  setLinkRectToolImageTextSize(linkRectToolImageTextSize: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接控件高度
   * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconHeight
   */
  setLinkRectToolImageHeight(linkRectToolImageHeight: Length): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接左右内边距
   * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconPadding
   */
  setLinkRectToolImagePadding(linkRectToolImagePadding: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接边框宽度
   * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconBorderWidth
   */
  setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: Length): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接分割线宽度
   * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconDividingLineWidth
   */
  setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: Length): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式链接左右外边距
   * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconMargin
   */
  setLinkRectToolImageMargin(linkRectToolImageMargin: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式分割线和文本左边距
   * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconLineLeftPadding
   */
  setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: number): MarkdownTheme

  /**
   * 设置空心圆角矩形图片格式分割线和文本右边距
   * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconLineRightPadding
   */
  setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: number): MarkdownTheme

  /**
   * 设置块引用左边距
   * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteMargin
   */
  setBlockQuoteLeftMargin(blockQuoteLeftMargin: number): MarkdownTheme

  /**
   * 设置块引用右边距
   * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteMargin
   */
  setBlockQuoteRightMargin(blockQuoteRightMargin: number): MarkdownTheme

  /**
   * 设置块引用左边线条宽度
   * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteLeftBorderWidth
   */
  setBlockQuoteWidth(blockQuoteWidth: Length): MarkdownTheme

  /**
   * 设置块引用左边线条颜色
   * @param blockQuoteColor 块引用左边线条颜色 - 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteLeftBorderColor
   */
  setBlockQuoteColor(blockQuoteColor: number): MarkdownTheme

  /**
   * 设置块引用背景颜色
   * @param blockQuoteBackgroundColor 块引用背景颜色 - 默认0xFFEAEAEA
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteBackgroundColor
   */
  setBlockQuoteBackgroundColor(blockQuoteBackgroundColor: number): MarkdownTheme

  /**
   * 设置块引用子模块上下间距
   * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteChildSpacing
   */
  setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: number): MarkdownTheme

  /**
   * 设置有序列表、无序列表、任务列表子模块上下间距
   * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListChildSpacing
   */
  setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: number): MarkdownTheme

  /**
   * 设置有序列表、无序列表、任务列表左边距
   * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMargin
   */
  setBlockLeftMargin(blockLeftMargin: number): MarkdownTheme

  /**
   * 设置有序列表、无序列表、任务列表右边距
   * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMargin
   */
  setBlockRightMargin(blockRightMargin: number): MarkdownTheme

  /**
   * 设置有序列表前缀文本是否加粗
   * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true：加粗；false：不加粗。默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextFontWeight
   */
  setOrderedListItemPrefixBold(orderedListItemPrefixBold: boolean): MarkdownTheme

  /**
   * 设置有序列表前缀文本颜色
   * @param orderedListItemColor 有序列表前缀文本颜色 - 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextFontColor
   */
  setOrderedListItemColor(orderedListItemColor: number): MarkdownTheme

  /**
   * 设置有序列表前缀文本大小
   * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextFontSize
   */
  setOrderedListItemSize(orderedListItemSize: number): MarkdownTheme

  /**
   * 设置有序列表前缀文本行高
   * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextLineHeight
   */
  setOrderedListItemLineHeight(orderedListItemLineHeight: number): MarkdownTheme

  /**
   * 设置无序列表前缀是否全部是实心圆型
   * @param bulletListItemCircle 无序列表前缀是否全部是实心圆型 - 默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletIsCircle
   */
  setBulletListItemCircle(bulletListItemCircle: boolean): MarkdownTheme

  /**
   * 设置无序列表前缀文本颜色
   * @param bulletListItemColor 无序列表前缀文本颜色 - 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletTextFontColor
   */
  setBulletListItemColor(bulletListItemColor: number): MarkdownTheme

  /**
   * 设置无序列表前缀文本大小
   * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletTextFontSize
   */
  setBulletListItemSize(bulletListItemSize: number): MarkdownTheme

  /**
   * 设置无序列表前缀文本行高
   * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletTextLineHeight
   */
  setBulletListItemLineHeight(bulletListItemLineHeight: number): MarkdownTheme

  /**
   * 设置任务列表选择框宽高
   * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListCheckboxWidth
   */
  setTaskListItemLength(taskListItemLength: number): MarkdownTheme

  /**
   * 设置是否格式化代码块内容
   * @param isCodeFormat 是否格式化代码块内容 - true：格式化代码块内容；false：不格式化代码块内容。默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIsCodeFormat
   */
  setIsCodeFormat(isCodeFormat: boolean): MarkdownTheme

  /**
   * 设置内联代码文本颜色
   * @param codeTextColor 内联代码文本颜色 - 默认0xFF000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextFontColor
   */
  setCodeTextColor(codeTextColor: number): MarkdownTheme

  /**
   * 设置内联代码背景颜色
   * @param codeBackgroundColor 内联代码背景颜色 - 默认0xFFEAEAEA
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextBackgroundColor
   */
  setCodeBackgroundColor(codeBackgroundColor: number): MarkdownTheme

  /**
   * 设置内联代码文本大小
   * @param codeTextSize 内联代码文本大小 - 默认13.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextFontSize
   */
  setCodeTextSize(codeTextSize: number): MarkdownTheme

  /**
   * 设置内联代码文本字体
   * @param codeTypeface 内联代码文本字体 - 默认"HarmonyOS Sans"
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextFontFamily
   */
  setCodeTypeface(codeTypeface: string): MarkdownTheme

  /**
   * 设置围栏代码块代码高亮是否同步解析
   * @param isCodeBlockParserSync 围栏代码块代码高亮是否同步解析 - 默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockParserSync
   */
  setIsCodeBlockParserSync(isCodeBlockParserSync: boolean): MarkdownTheme

  /**
   * 设置代码块代码文本颜色
   * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextFontColor
   */
  setCodeBlockTextColor(codeBlockTextColor: number): MarkdownTheme

  /**
   * 设置代码块代码类型文本颜色
   * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTypeTextFontColor
   */
  setCodeBlockTypeTextColor(codeBlockTypeTextColor: number): MarkdownTheme

  /**
   * 设置代码块代码类型文本
   * @param codeBlockTypeTextStr 代码块代码类型文本 - 默认""
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTypeText
   */
  setCodeBlockTypeTextStr(codeBlockTypeTextStr: string): MarkdownTheme

  /**
   * 设置代码类型和代码块距离
   * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTitleLayoutMarginBottom
   */
  setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: number): MarkdownTheme

  /**
   * 设置代码块复制、全屏图片文字是否显示
   * @param codeBlockIconTextHide 代码块复制、全屏图片文字是否隐藏 - true：隐藏；false：显示。默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenTextIsShow
   */
  setCodeBlockIconTextHide(codeBlockIconTextHide: boolean): MarkdownTheme

  /**
   * 设置代码块代码行号是否显示
   * @param codeBlockLineNumberHide 代码块代码行号是否隐藏 - true：隐藏；false：显示。默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockLineNumberIsShow
   */
  setCodeBlockLineNumberHide(codeBlockLineNumberHide: boolean): MarkdownTheme

  /**
   * 设置代码块背景颜色
   * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockBackgroundColor
   */
  setCodeBlockBackgroundColor(codeBlockBackgroundColor: number): MarkdownTheme

  /**
   * 设置代码块左边距
   * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockMargin
   */
  setCodeMultilineMargin(codeMultilineMargin: number): MarkdownTheme

  /**
   * 设置代码块字体
   * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextFontFamily
   */
  setCodeBlockTypeface(codeBlockTypeface: string): MarkdownTheme

  /**
   * 设置代码块代码文本大小
   * @param codeBlockTextSize 代码块代码文本大小 - 默认13.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextFontSize
   */
  setCodeBlockTextSize(codeBlockTextSize: number): MarkdownTheme

  /**
   * 设置代码块代码文本行高
   * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextLineHeight
   */
  setCodeBlockLineHeight(codeBlockLineHeight: number): MarkdownTheme

  /**
   * 设置代码块控件圆角大小
   * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockRadius
   */
  setCodeBlockRadius(codeBlockRadius: number): MarkdownTheme

  /**
   * 设置代码块代码全屏按钮是否显示
   * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true：显示；false：不显示。默认true
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenButtonIsShow
   */
  setIsCodeFullScreen(isCodeFullScreen: boolean): MarkdownTheme

  /**
   * 设置代码块代码全屏、代码复制按钮宽高
   * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenIconHeight
   */
  setIconWidthAndHeight(iconWidthAndHeight: Length): MarkdownTheme

  /**
   * 设置组合代码未选中标题字体大小
   * @param codeListTitleTextSize 组合代码未选中标题字体大小 - 默认13.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleTextSize
   */
  setCodeListTitleTextSize(codeListTitleTextSize: number): MarkdownTheme

  /**
   * 设置组合代码选中标题字体大小
   * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleSelectTextSize
   */
  setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: number): MarkdownTheme

  /**
   * 设置组合代码选中标题文本颜色
   * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认0xFFFF0000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleSelectTextColor
   */
  setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: number): MarkdownTheme

  /**
   * 设置组合代码未选中标题文本颜色
   * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认0xFF000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleUnselectTextColor
   */
  setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: number): MarkdownTheme

  /**
   * 设置组合代码选中标题背景颜色
   * @param codeListTitleSelectBackgroundColor 组合代码选中标题背景颜色 - 默认0xFF808080
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleSelectBackgroundColor
   */
  setCodeListTitleSelectBackgroundColor(codeListTitleSelectBackgroundColor: number): MarkdownTheme

  /**
   * 设置组合代码未选中标题背景颜色
   * @param codeListTitleUnSelectBackgroundColor 组合代码未选中标题背景颜色 - 默认0x00FFFFFF
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleUnselectBackgroundColor
   */
  setCodeListTitleUnSelectBackgroundColor(codeListTitleUnSelectBackgroundColor: number): MarkdownTheme

  /**
   * 设置是否单独代码块显示
   * @param isSeparateCodeBlock 是否单独代码块显示 - true：显示；false：不显示。默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIsSeparate
   */
  setIsSeparateCodeBlock(isSeparateCodeBlock: boolean): MarkdownTheme

  /**
   * 设置单独代码块行号宽度
   * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockSeparateWidth
   */
  setSeparateCodeBlockWidth(separateCodeBlockWidth: Length): MarkdownTheme

  /**
   * 设置单独代码块是否居底显示
   * @param separateCodeIsBottom 单独代码块是否居底显示 - 默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockSeparateIsBottom
   */
  setSeparateCodeIsBottom(separateCodeIsBottom: boolean): MarkdownTheme

  /**
   * 设置H1、H2标题下分割线高度
   * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineHeightForAllHeading
   */
  setHeadingBreakHeight(headingBreakHeight: number): MarkdownTheme

  /**
   * 设置标题文本字体
   * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontFamilyForAllHeading
   */
  setHeadingTypeface(headingTypeface: string): MarkdownTheme

  /**
   * 设置标题模块上间距
   * @param headingTopMargins 标题模块上间距 - 默认8.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setMarginForAllHeadingEachLevel
   */
  setHeadingTopMargins(headingTopMargins: number): MarkdownTheme

  /**
   * 设置标题模块下间距
   * @param headingBottomMargins 标题模块下间距 - 默认8.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setMarginForAllHeadingEachLevel
   */
  setHeadingBottomMargins(headingBottomMargins: number): MarkdownTheme

  /**
   * 设置标题文本大小数组
   * @param headingTextSizeMultipliers 标题文本大小数组 - 默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForEachHeading
   */
  setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<number>): MarkdownTheme

  /**
   * 设置一级标题文本大小
   * @param headingTextSize1 一级标题文本大小 - 默认20.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize1(headingTextSize1: number): MarkdownTheme

  /**
   * 设置二级标题文本大小
   * @param headingTextSize2 二级标题文本大小 - 默认17.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize2(headingTextSize2: number): MarkdownTheme

  /**
   * 设置三级标题文本大小
   * @param headingTextSize3 三级标题文本大小 - 默认16.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize3(headingTextSize3: number): MarkdownTheme

  /**
   * 设置四级标题文本大小
   * @param headingTextSize4 四级标题文本大小 - 默认15.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize4(headingTextSize4: number): MarkdownTheme

  /**
   * 设置五级标题文本大小
   * @param headingTextSize5 五级标题文本大小 - 默认15.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize5(headingTextSize5: number): MarkdownTheme

  /**
   * 设置六级标题文本大小
   * @param headingTextSize6 六级标题文本大小 - 默认13.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize6(headingTextSize6: number): MarkdownTheme

  /**
   * 设置标题文本颜色
   * @param headingTextColor 标题文本颜色 - 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForAllHeading
   */
  setHeadingTextColor(headingTextColor: number): MarkdownTheme

  /**
   * 设置H1、H2标题下分割线颜色
   * @param headingBreakColor H1、H2标题下分割线颜色 - 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineColorForAllHeading
   */
  setHeadingBreakColor(headingBreakColor: number): MarkdownTheme

  /**
   * 设置标题文本字间距
   * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLetterSpacingForAllHeading
   */
  setHeadingTextWordSpace(headingTextWordSpace: number): MarkdownTheme

  /**
   * 设置一级标题文本行高
   * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight1(headingTextLineHeight1: number): MarkdownTheme

  /**
   * 设置二级标题文本行高
   * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight2(headingTextLineHeight2: number): MarkdownTheme

  /**
   * 设置三级标题文本行高
   * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight3(headingTextLineHeight3: number): MarkdownTheme

  /**
   * 设置四级标题文本行高
   * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight4(headingTextLineHeight4: number): MarkdownTheme

  /**
   * 设置五级标题文本行高
   * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight5(headingTextLineHeight5: number): MarkdownTheme

  /**
   * 设置六级标题文本行高
   * @param headingTextLineHeight6 六级标题文本行高 - 默认22.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight6(headingTextLineHeight6: number): MarkdownTheme

  /**
   * 设置一级标题文本颜色
   * @param headingTextColor1 标题文本颜色
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor1(headingTextColor1: number): MarkdownTheme

  /**
   * 设置H1标题下分割线颜色
   * @param headingBreakColor1 H1标题下分割线颜色 - 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineColorForDesignateHeading
   */
  setHeadingBreakColor1(headingBreakColor1: number): MarkdownTheme

  /**
   * 设置二级标题文本颜色
   * @param headingTextColor2 标题文本颜色
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor2(headingTextColor2: number): MarkdownTheme

  /**
   * 设置H2标题下分割线颜色
   * @param headingBreakColor2 H2标题下分割线颜色 - 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineColorForDesignateHeading
   */
  setHeadingBreakColor2(headingBreakColor2: number): MarkdownTheme

  /**
   * 设置三级标题文本颜色
   * @param headingTextColor3 标题文本颜色
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor3(headingTextColor3: number): MarkdownTheme

  /**
   * 设置四级标题文本颜色
   * @param headingTextColor4 标题文本颜色
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor4(headingTextColor4: number): MarkdownTheme

  /**
   * 设置五级标题文本颜色
   * @param headingTextColor5 标题文本颜色
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor5(headingTextColor5: number): MarkdownTheme

  /**
   * 设置六级标题文本颜色
   * @param headingTextColor6 标题文本颜色
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor6(headingTextColor6: number): MarkdownTheme

  /**
   * 设置段落模块上间距
   * @param paragraphTopMargins 段落模块上间距 - 默认8.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphMargin
   */
  setParagraphTopMargins(paragraphTopMargins: number): MarkdownTheme

  /**
   * 设置段落模块下间距
   * @param paragraphBottomMargins 段落模块下间距 - 默认8.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphMargin
   */
  setParagraphBottomMargins(paragraphBottomMargins: number): MarkdownTheme

  /**
   * 设置段落文本大小
   * @param paragraphTextSize 段落文本大小 - 默认14.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextFontSize
   */
  setParagraphTextSize(paragraphTextSize: number): MarkdownTheme

  /**
   * 设置段落文本颜色
   * @param paragraphTextColor 段落文本颜色 - 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextFontColor
   */
  setParagraphTextColor(paragraphTextColor: number): MarkdownTheme

  /**
   * 设置段落文本字间距
   * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextLetterSpacing
   */
  setParagraphTextWordSpace(paragraphTextWordSpace: number): MarkdownTheme

  /**
   * 设置段落文本行高
   * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextLineHeight
   */
  setParagraphTextLineHeight(paragraphTextLineHeight: number): MarkdownTheme

  /**
   * 设置段落文本字体
   * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextFontFamily
   */
  setParagraphTypeface(paragraphTypeface: string): MarkdownTheme

  /**
   * 设置分割线颜色
   * @param thematicBreakColor 分割线颜色 - 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerColor
   */
  setThematicBreakColor(thematicBreakColor: number): MarkdownTheme

  /**
   * 设置分割线高度
   * @param thematicBreakHeight 分割线高度 - 默认0.5vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerStrokeWidth
   */
  setThematicBreakHeight(thematicBreakHeight: number): MarkdownTheme

  /**
   * 设置分割线上部外边距
   * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerMargin
   */
  setThematicBreakTopMargin(thematicBreakTopMargin: number): MarkdownTheme

  /**
   * 设置分割线下部外边距
   * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerMargin
   */
  setThematicBreakBottomMargin(thematicBreakBottomMargin: number): MarkdownTheme

  /**
   * 设置软换行是否换行
   * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setIsLineBreak
   */
  setIsLineBreak(isLineBreak: boolean): MarkdownTheme

  /**
   * 设置音频阴影颜色值
   * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioShadowColor
   */
  setAudioShadowColor(audioShadowColor: number): MarkdownTheme

  /**
   * 设置音频边框颜色
   * @param audioBorderColor 音频边框颜色 - 默认0x33000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioBorderColor
   */
  setAudioBorderColor(audioBorderColor: number): MarkdownTheme

  /**
   * 设置音频边框粗细
   * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioBorderWidth
   */
  setAudioBorderWidth(audioBorderWidth: Length): MarkdownTheme

  /**
   * 设置音频边框圆角
   * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioBorderRadius
   */
  setAudioBorderRadius(audioBorderRadius: number): MarkdownTheme

  /**
   * 设置音频按钮背景颜色
   * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认0xFF000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonBackgroundColor
   */
  setAudioButtonBackgroundColor(audioButtonBackgroundColor: number): MarkdownTheme

  /**
   * 设置音频按钮文字颜色
   * @param audioButtonTextColor 音频按钮文字颜色 - 默认0xFFFFFFFF
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonTextFontColor
   */
  setAudioButtonTextColor(audioButtonTextColor: number): MarkdownTheme

  /**
   * 设置音频按钮文字大小
   * @param audioButtonTextSize 音频按钮文字大小 - 默认14.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonTextFontSize
   */
  setAudioButtonTextSize(audioButtonTextSize: number): MarkdownTheme

  /**
   * 设置音频按钮文字内容
   * @param audioButtonText 音频按钮文字内容 - 默认"立即播放"
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonText
   */
  setAudioButtonText(audioButtonText: string): MarkdownTheme

  /**
   * 设置音频按钮圆角
   * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonRadius
   */
  setAudioButtonBorderRadius(audioButtonBorderRadius: number): MarkdownTheme

  /**
   * 设置音频标题文字大小
   * @param audioTitleTextSize 音频标题文字大小 - 默认15.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTitleTextFontSize
   */
  setAudioTitleTextSize(audioTitleTextSize: number): MarkdownTheme

  /**
   * 设置音频标题文字颜色
   * @param audioTitleTextColor 音频标题文字颜色 - 默认0xFF000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTitleTextFontColor
   */
  setAudioTitleTextColor(audioTitleTextColor: number): MarkdownTheme

  /**
   * 设置音频标题文字行高
   * @param audioTitleTextLineHeight 音频标题文字行高 - 默认20.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTitleTextLineHeight
   */
  setAudioTitleTextLineHeight(audioTitleTextLineHeight: number): MarkdownTheme

  /**
   * 设置音频类型文字大小
   * @param audioTypeTextSize 音频类型文字大小 - 默认11.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTypeTextFontSize
   */
  setAudioTypeTextSize(audioTypeTextSize: number): MarkdownTheme

  /**
   * 设置音频类型文字颜色
   * @param audioTypeTextColor 音频类型文字颜色 - 默认0X80000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTypeTextFontColor
   */
  setAudioTypeTextColor(audioTypeTextColor: number): MarkdownTheme

  /**
   * 设置音频类型文字行高
   * @param audioTypeTextLineHeight 音频类型文字行高 - 默认15.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTypeTextLineHeight
   */
  setAudioTypeTextLineHeight(audioTypeTextLineHeight: number): MarkdownTheme

  /**
   * 设置音频上边距
   * @param audioMarginTop 音频上边距 - 默认10.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioMargin
   */
  setAudioMarginTop(audioMarginTop: number): MarkdownTheme

  /**
   * 设置音频下边距
   * @param audioMarginBottom 音频下边距 - 默认10.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioMargin
   */
  setAudioMarginBottom(audioMarginBottom: number): MarkdownTheme

  /**
   * 设置视频圆角
   * @param videoBorderRadius 视频圆角 - 默认10.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoBorderRadius
   */
  setVideoBorderRadius(videoBorderRadius: number): MarkdownTheme

  /**
   * 设置视频时间文本颜色
   * @param videoTimeTextColor 视频时间文本颜色 - 默认0xFFFFFFFF
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextFontColor
   */
  setVideoTimeTextColor(videoTimeTextColor: number): MarkdownTheme

  /**
   * 设置视频时间文本大小
   * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextFontSize
   */
  setVideoTimeTextSize(videoTimeTextSize: number): MarkdownTheme

  /**
   * 设置视频时间文本居右边距
   * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextMarginRight
   */
  setVideoTimeTextMarginRight(videoTimeTextMarginRight: number): MarkdownTheme

  /**
   * 设置视频时间文本居底边距
   * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextMarginBottom
   */
  setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: number): MarkdownTheme

  /**
   * 设置视频上边距
   * @param videoMarginTop 视频上边距 - 默认10.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoMargin
   */
  setVideoMarginTop(videoMarginTop: number): MarkdownTheme

  /**
   * 设置视频下边距
   * @param videoMarginBottom 视频下边距 - 默认10.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoMargin
   */
  setVideoMarginBottom(videoMarginBottom: number): MarkdownTheme

  /**
   * 设置视频发布/下载按钮布局是否显示
   * @param isVideoBottomLayout 视频发布/下载按钮布局是否显示 - 默认false不显示
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoBottomLayoutVisible
   */
  setIsVideoBottomLayout(isVideoBottomLayout: boolean): MarkdownTheme

  /**
   * 设置视频发布按钮图片宽度和高度
   * @param videoReleaseImageWidthHeight 视频发布按钮图片宽度和高度 - 默认18.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonIconWidth
   */
  setVideoReleaseImageWidthHeight(videoReleaseImageWidthHeight: Length): MarkdownTheme

  /**
   * 设置视频发布按钮宽度
   * @param videoReleaseWidth 视频发布按钮宽度 - 默认144.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonWidth
   */
  setVideoReleaseWidth(videoReleaseWidth: Length): MarkdownTheme

  /**
   * 设置视频发布按钮高度
   * @param videoReleaseHeight 视频发布按钮高度 - 默认44.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonHeight
   */
  setVideoReleaseHeight(videoReleaseHeight: Length): MarkdownTheme

  /**
   * 设置视频发布按钮圆角
   * @param videoReleaseRadius 视频发布按钮圆角 - 默认22.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonRadius
   */
  setVideoReleaseRadius(videoReleaseRadius: number): MarkdownTheme

  /**
   * 设置视频发布按钮文本内容
   * @param videoReleaseText 视频发布按钮文本内容 - 默认"发布视频"
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonText
   */
  setVideoReleaseText(videoReleaseText: string): MarkdownTheme

  /**
   * 设置视频发布按钮文本大小
   * @param videoReleaseTextSize 视频发布按钮文本大小 - 默认16.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonTextFontSize
   */
  setVideoReleaseTextSize(videoReleaseTextSize: number): MarkdownTheme

  /**
   * 设置视频发布按钮文本颜色
   * @param videoReleaseTextColor 视频发布按钮文本颜色 - 默认0xE6000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonTextFontColor
   */
  setVideoReleaseTextColor(videoReleaseTextColor: number): MarkdownTheme

  /**
   * 设置视频发布按钮背景颜色
   * @param videoReleaseBackgroundColor 视频发布按钮背景颜色 - 默认0xFFF5F5F5
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonBackgroundColor
   */
  setVideoReleaseBackgroundColor(videoReleaseBackgroundColor: number): MarkdownTheme

  /**
   * 设置视频下载按钮图片宽度和高度
   * @param videoDownloadImageWidthHeight 视频下载按钮图片宽度和高度 - 默认18.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonIconWidth
   */
  setVideoDownloadImageWidthHeight(videoDownloadImageWidthHeight: Length): MarkdownTheme

  /**
   * 设置视频下载按钮宽度
   * @param videoDownloadWidth 视频下载按钮宽度 - 默认144.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonWidth
   */
  setVideoDownloadWidth(videoDownloadWidth: Length): MarkdownTheme

  /**
   * 设置视频下载按钮高度
   * @param videoDownloadHeight 视频下载按钮高度 - 默认44.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonHeight
   */
  setVideoDownloadHeight(videoDownloadHeight: Length): MarkdownTheme

  /**
   * 设置视频下载按钮圆角
   * @param videoDownloadRadius 视频下载按钮圆角 - 默认22.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonRadius
   */
  setVideoDownloadRadius(videoDownloadRadius: number): MarkdownTheme

  /**
   * 设置视频下载按钮文本内容
   * @param videoDownloadText 视频下载按钮文本内容 - 默认"下载视频"
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonText
   */
  setVideoDownloadText(videoDownloadText: string): MarkdownTheme

  /**
   * 设置视频下载按钮文本大小
   * @param videoDownloadTextSize 视频下载按钮文本大小 - 默认16.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonTextFontSize
   */
  setVideoDownloadTextSize(videoDownloadTextSize: number): MarkdownTheme

  /**
   * 设置视频下载按钮文本颜色
   * @param videoDownloadTextColor 视频下载按钮文本颜色 - 默认0xE6000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonTextFontColor
   */
  setVideoDownloadTextColor(videoDownloadTextColor: number): MarkdownTheme

  /**
   * 设置视频下载按钮背景颜色
   * @param videoDownloadBackgroundColor 视频下载按钮背景颜色 - 默认0xFFF5F5F5
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonBackgroundColor
   */
  setVideoDownloadBackgroundColor(videoDownloadBackgroundColor: number): MarkdownTheme

  /**
   * 设置图片缩放类型
   * @param imageFitType 图片缩放类型 - 默认ImageFit.Contain
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageFitType
   */
  setImageFitType(imageFitType: ImageFit): MarkdownTheme

  /**
   * 设置图片基于自身宽度缩放百分比
   * @param imageMaximumWidth 图片基于自身宽度缩放百分比 - 默认1.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMaximumWidth
   */
  setImageMaximumWidth(imageMaximumWidth: number): MarkdownTheme

  /**
   * 设置图片基于父布局宽度缩放百分比
   * @param imageFixedRatioWidth 图片基于父布局宽度缩放百分比 - 默认None
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageFixedRatioWidth
   */
  setImageFixedRatioWidth(imageFixedRatioWidth: number): MarkdownTheme

  /**
   * 设置图片最大高度
   * @param imageMaxHeight 图片最大高度 - 默认None
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMaxHeight
   */
  setImageMaxHeight(imageMaxHeight: number): MarkdownTheme

  /**
   * 设置图片最大宽度
   * @param imageMaxWidth 图片最大宽度 - 默认None
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMaxWidth
   */
  setImageMaxWidth(imageMaxWidth: number): MarkdownTheme

  /**
   * 设置图片圆角大小
   * @param imageBorderRadius 图片圆角大小 - 默认0.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageBorderRadius
   */
  setImageBorderRadius(imageBorderRadius: number): MarkdownTheme

  /**
   * 设置图片边框宽度
   * @param imageBorderWidth 图片边框宽度 - 默认0.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageBorderWidth
   */
  setImageBorderWidth(imageBorderWidth: Length): MarkdownTheme

  /**
   * 设置图片边框颜色
   * @param imageBorderColor 图片边框颜色 - 默认0xFF000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageBorderColor
   */
  setImageBorderColor(imageBorderColor: number): MarkdownTheme

  /**
   * 设置网络图片是否压缩
   * @param isAutoResize 网络图片是否压缩 - true：压缩；false：不压缩。默认true
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageAutoResize
   */
  setIsAutoResize(isAutoResize: boolean): MarkdownTheme

  /**
   * 设置图片上边距
   * @param imageMarginTop 图片上边距 - 默认10.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMargin
   */
  setImageMarginTop(imageMarginTop: number): MarkdownTheme

  /**
   * 设置图片下边距
   * @param imageMarginBottom 图片下边距 - 默认10.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMargin
   */
  setImageMarginBottom(imageMarginBottom: number): MarkdownTheme

  /**
   * 设置图片是否有下载按钮
   * @param isImageDownload 图片是否有下载按钮 - 默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonVisible
   */
  setIsImageDownload(isImageDownload: boolean): MarkdownTheme

  /**
   * 设置是否图文混排
   * @param isImageMixedLayout 是否图文混排 - 默认true
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setIsImageMixedLayout
   */
  setIsImageMixedLayout(isImageMixedLayout: boolean): MarkdownTheme

  /**
   * 设置图片下载按钮图片宽度和高度
   * @param imageDownloadImageWidthHeight 图片下载按钮图片宽度和高度 - 默认18.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonIconWidth
   */
  setImageDownloadImageWidthHeight(imageDownloadImageWidthHeight: Length): MarkdownTheme

  /**
   * 设置图片下载按钮宽度
   * @param imageDownloadWidth 图片下载按钮宽度 - 默认296.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonWidth
   */
  setImageDownloadWidth(imageDownloadWidth: Length): MarkdownTheme

  /**
   * 设置图片下载按钮高度
   * @param imageDownloadHeight 图片下载按钮高度 - 默认44.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonHeight
   */
  setImageDownloadHeight(imageDownloadHeight: Length): MarkdownTheme

  /**
   * 设置图片下载按钮圆角
   * @param imageDownloadRadius 图片下载按钮圆角 - 默认22.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonRadius
   */
  setImageDownloadRadius(imageDownloadRadius: number): MarkdownTheme

  /**
   * 设置图片下载按钮文本内容
   * @param imageDownloadText 图片下载按钮文本内容 - 默认"下载图片"
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonText
   */
  setImageDownloadText(imageDownloadText: string): MarkdownTheme

  /**
   * 设置图片下载按钮文本大小
   * @param imageDownloadTextSize 图片下载按钮文本大小 - 默认16.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonTextFontSize
   */
  setImageDownloadTextSize(imageDownloadTextSize: number): MarkdownTheme

  /**
   * 设置图片下载按钮文本颜色
   * @param imageDownloadTextColor 图片下载按钮文本颜色 - 默认0xE6000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonTextFontColor
   */
  setImageDownloadTextColor(imageDownloadTextColor: number): MarkdownTheme

  /**
   * 设置图片下载按钮背景颜色
   * @param imageDownloadBackgroundColor 图片下载按钮背景颜色 - 默认0xFFF5F5F5
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonBackgroundColor
   */
  setImageDownloadBackgroundColor(imageDownloadBackgroundColor: number): MarkdownTheme

  /**
   * 设置表格内容内边距
   * @param tableCellPadding 表格内容内边距 - 默认4.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableCellPadding
   */
  setTableCellPadding(tableCellPadding: number): MarkdownTheme

  /**
   * 设置表格边框颜色
   * @param tableBorderColor 表格边框颜色 - 默认0xFF000000
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableBorderColor
   */
  setTableBorderColor(tableBorderColor: number): MarkdownTheme

  /**
   * 设置表格边框宽度
   * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableBorderWidth
   */
  setTableBorderWidth(tableBorderWidth: Length): MarkdownTheme

  /**
   * 设置表格奇数行背景色
   * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0xFFFFFFFF
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentOddRowBackgroundColor
   */
  setTableOddRowBackgroundColor(tableOddRowBackgroundColor: number): MarkdownTheme

  /**
   * 设置表格偶数行背景色
   * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0xFFE0E0E0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentEvenRowBackgroundColor
   */
  setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: number): MarkdownTheme

  /**
   * 设置表格标题背景色
   * @param tableHeaderRowBackgroundColor 表格标题背景色 - 默认0xFFFFFFFF
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleBackgroundColor
   */
  setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: number): MarkdownTheme

  /**
   * 设置表格标题文本颜色
   * @param tableTitleTextColor 表格标题文本颜色 - 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleTextFontColor
   */
  setTableTitleTextColor(tableTitleTextColor: number): MarkdownTheme

  /**
   * 设置表格文本行高
   * @param tableTextLineHeight 表格文本行高 - 默认22.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextLineHeight
   */
  setTableTextLineHeight(tableTextLineHeight: number): MarkdownTheme

  /**
   * 设置表格标题文本大小
   * @param tableTitleTextSize 表格标题文本大小 - 默认14.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleTextFontSize
   */
  setTableTitleTextSize(tableTitleTextSize: number): MarkdownTheme

  /**
   * 设置表格标题文本行高
   * @param tableTitleLineHeight 表格标题文本行高 - 默认22.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleTextLineHeight
   */
  setTableTitleLineHeight(tableTitleLineHeight: number): MarkdownTheme

  /**
   * 设置表格内容文本颜色
   * @param tableContentTextColor 表格内容文本颜色 - 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextFontColor
   */
  setTableContentTextColor(tableContentTextColor: number): MarkdownTheme

  /**
   * 设置表格内容文本大小
   * @param tableContentTextSize 表格内容文本大小 - 默认14.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextFontSize
   */
  setTableContentTextSize(tableContentTextSize: number): MarkdownTheme

  /**
   * 设置表格内容文本行高
   * @param tableTextLineHeight 表格内容文本行高 - 默认22.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextLineHeight
   */
  setTableContentTextLineHeight(tableTextLineHeight: number): MarkdownTheme

  /**
   * 设置表格圆角
   * @param tableRadius 表格圆角 - 默认5.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableRadius
   */
  setTableRadius(tableRadius: number): MarkdownTheme

  /**
   * 设置表格最小宽度
   * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableMinCellWidth
   */
  setTableMinTextWidth(tableMinTextWidth: Length): MarkdownTheme

  /**
   * 设置表格最大宽度
   * @param tableMaxTextWidth 表格最大宽度 - 默认300.0vp
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableMaxCellWidth
   */
  setTableMaxTextWidth(tableMaxTextWidth: Length): MarkdownTheme

  /**
   * 设置表格第一列是否加粗
   * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableFirstColumnIsBold
   */
  setTableFirstColumnBold(tableFirstColumnBold: boolean): MarkdownTheme

  /**
   * 设置表格是否显示滚动条
   * @param tableScrollBarShow 表格是否显示滚动条 - true：显示(auto状态)；false：不显示。默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableScrollBarState
   */
  setTableScrollBarShow(tableScrollBarShow: boolean): MarkdownTheme

  /**
   * 设置表格滚动条颜色
   * @param tableScrollBarColor 表格滚动条颜色
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableScrollBarColor
   */
  setTableScrollBarColor(tableScrollBarColor: number): MarkdownTheme

  /**
   * 设置代码块深浅色
   * @param isDark 是否是深色 - true：深色；false：浅色。默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIsDark
   */
  setIsDark(isDark: boolean): MarkdownTheme

  /**
   * 设置删除线颜色
   * @param strikethroughColor 删除线颜色 - 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead StrikethroughTheme#setStrikethroughTextDecorationColor
   */
  setStrikethroughColor(strikethroughColor: number): MarkdownTheme

  /**
   * 设置删除线样式
   * @param strikethroughStyle 删除线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead StrikethroughTheme#setStrikethroughTextDecorationStyle
   */
  setStrikethroughStyle(strikethroughStyle: TextDecorationStyle): MarkdownTheme

  /**
   * 设置定义列表术语和定义行之间间距
   * @param descListTermAndDefMargins 定义列表术语和定义行之间间距 默认8.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead DefinitionListTheme#setDefinitionListTermToDescriptionSpacing
   */
  setDescListTermAndDefMargins(descListTermAndDefMargins: number): MarkdownTheme

  /**
   * 设置定义列表定义行缩进
   * @param descListDefIndentation 定义列表定义行缩进 默认8.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead DefinitionListTheme#setDefinitionListDescriptionIndent
   */
  setDescListDefIndentation(descListDefIndentation: number): MarkdownTheme

  /**
   * 设置定义列表定义行间距
   * @param descListDefMargins 定义列表定义行间距 默认8.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead DefinitionListTheme#setDefinitionListDescriptionItemSpacing
   */
  setDescListDefMargins(descListDefMargins: number): MarkdownTheme

  /**
   * 设置下标字体颜色
   * @param subTextColor 下标字体颜色 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead SubTheme#setSubTextFontColor
   */
  setSubTextColor(subTextColor: number): MarkdownTheme

  /**
   * 设置下标字体大小
   * @param subTextSize 下标字体大小 默认8.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead SubTheme#setSubTextFontSize
   */
  setSubTextSize(subTextSize: number): MarkdownTheme

  /**
   * 设置下标偏移距离
   * @param subOffsetDist 下标偏移距离 默认0.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead SubTheme#setSubTextBaselineOffset
   */
  setSubOffsetDist(subOffsetDist: number): MarkdownTheme

  /**
   * 设置上标字体颜色
   * @param supTextColor 上标字体颜色 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead SupTheme#setSupTextFontColor
   */
  setSupTextColor(supTextColor: number): MarkdownTheme

  /**
   * 设置上标字体大小
   * @param supTextSize 上标字体大小 默认8.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead SupTheme#setSupTextFontSize
   */
  setSupTextSize(supTextSize: number): MarkdownTheme

  /**
   * 设置上标偏移距离
   * @param supOffsetDist 上标偏移距离 默认6.0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead SupTheme#setSupTextBaselineOffset
   */
  setSupOffsetDist(supOffsetDist: number): MarkdownTheme

  /**
   * 设置下划线颜色
   * @param underlineColor 下划线颜色 默认0xFF191919
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HtmlUnderlineTheme#setHtmlUnderlineTextDecorationColor
   */
  setUnderlineColor(underlineColor: number): MarkdownTheme

  /**
   * 设置下划线样式
   * @param underlineStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead HtmlUnderlineTheme#setHtmlUnderlineTextDecorationStyle
   */
  setUnderlineStyle(underlineStyle: TextDecorationStyle): MarkdownTheme

  /**
   * 设置markdown是否支持滚动手势
   * @param openGestureSwipe true-支持滚动手势，false-不支持滚动手势，默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setOpenGestureSwipe
   */
  setOpenGestureSwipe(openGestureSwipe: boolean): MarkdownTheme

  /**
   * 设置codeformat是否用制表符
   * @param useTab true-使用，false-不使用，默认false
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockUseTab
   */
  setUseTab(useTab: boolean): MarkdownTheme

  /**
   * 设置codeformat空格缩进数量
   * @param indentWidth 空格缩进数量，默认4空格
   * @return MarkdownTheme
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIndentWidth
   */
  setIndentWidth(indentWidth: Length): MarkdownTheme
}
```

### class OrderedListTheme

有序列表样式配置

```ets
export class OrderedListTheme {

  /**
   * 设置有序列表背景颜色
   * @param color 有序列表背景颜色
   * @return OrderedListTheme
   */
  setOrderedListBackgroundColor(color: ResourceColor): OrderedListTheme

  /**
   * 设置有序列表外边距
   * @param options 有序列表外边距选项或统一数值
   * @return OrderedListTheme
   */
  setOrderedListMargin(options: Margin | Length): OrderedListTheme

  /**
   * 设置有序列表内边距
   * @param options 有序列表内边距选项或统一数值
   * @return OrderedListTheme
   */
  setOrderedListPadding(options: Padding | Length): OrderedListTheme

  /**
   * 设置有序列表子项间距
   * @param spacing 有序列表子项间距
   * @return OrderedListTheme
   */
  setOrderedListChildSpacing(spacing: number): OrderedListTheme

  /**
   * 设置有序列表子子项间距
   * @param spacing 有序列表子子项间距
   * @return OrderedListTheme
   */
  setOrderedListChildChildSpacing(spacing: number): OrderedListTheme

  /**
   * 设置有序列表标记间距
   * @param spacing 有序列表标记间距
   * @return OrderedListTheme
   */
  setOrderedListMarkerSpacing(spacing: number): OrderedListTheme

  /**
   * 设置有序列表标记文本字体颜色
   * @param color 有序列表标记文本字体颜色
   * @return OrderedListTheme
   */
  setOrderedListMarkerTextFontColor(color: ResourceColor): OrderedListTheme

  /**
   * 设置有序列表标记文本字体大小
   * @param size 有序列表标记文本字体大小
   * @return OrderedListTheme
   */
  setOrderedListMarkerTextFontSize(size: number | string | Resource): OrderedListTheme

  /**
   * 设置有序列表标记文本字体样式
   * @param style 有序列表标记文本字体样式
   * @return OrderedListTheme
   */
  setOrderedListMarkerTextFontStyle(style: FontStyle): OrderedListTheme

  /**
   * 设置有序列表标记文本字体粗细
   * @param weight 有序列表标记文本字体粗细
   * @return OrderedListTheme
   */
  setOrderedListMarkerTextFontWeight(weight: number | FontWeight): OrderedListTheme

  /**
   * 设置有序列表标记文本字体族
   * @param family 有序列表标记文本字体族
   * @return OrderedListTheme
   */
  setOrderedListMarkerTextFontFamily(family: string | Resource): OrderedListTheme

  /**
   * 设置有序列表标记文本行高
   * @param lineHeight 有序列表标记文本行高
   * @return OrderedListTheme
   */
  setOrderedListMarkerTextLineHeight(lineHeight: number | string | Resource): OrderedListTheme
}
```

### class ParagraphTheme

段落样式配置

```ets
export class ParagraphTheme {

  /**
   * 设置段落背景颜色
   * @param color 段落背景颜色
   * @return ParagraphTheme
   */
  setParagraphBackgroundColor(color: ResourceColor): ParagraphTheme

  /**
   * 设置段落外边距
   * @param options 段落外边距选项或统一数值
   * @return ParagraphTheme
   */
  setParagraphMargin(options: Margin | Length): ParagraphTheme

  /**
   * 设置段落内边距
   * @param options 段落内边距选项或统一数值
   * @return ParagraphTheme
   */
  setParagraphPadding(options: Padding | Length): ParagraphTheme

  /**
   * 设置段落文本字体颜色
   * @param color 段落文本字体颜色
   * @return ParagraphTheme
   */
  setParagraphTextFontColor(color: ResourceColor): ParagraphTheme

  /**
   * 设置段落文本字体大小
   * @param size 段落文本字体大小
   * @return ParagraphTheme
   */
  setParagraphTextFontSize(size: number | string | Resource): ParagraphTheme

  /**
   * 设置段落文本字体样式
   * @param style 段落文本字体样式
   * @return ParagraphTheme
   */
  setParagraphTextFontStyle(style: FontStyle): ParagraphTheme

  /**
   * 设置段落文本字体粗细
   * @param weight 段落文本字体粗细
   * @return ParagraphTheme
   */
  setParagraphTextFontWeight(weight: number | FontWeight): ParagraphTheme

  /**
   * 设置段落文本字体族
   * @param family 段落文本字体族
   * @return ParagraphTheme
   */
  setParagraphTextFontFamily(family: string | Resource): ParagraphTheme

  /**
   * 设置段落文本行高
   * @param lineHeight 段落文本行高
   * @return ParagraphTheme
   */
  setParagraphTextLineHeight(lineHeight: number | string | Resource): ParagraphTheme

  /**
   * 设置段落文本字间距
   * @param spacing 段落文本字间距
   * @return ParagraphTheme
   */
  setParagraphTextLetterSpacing(spacing: number): ParagraphTheme
}
```

### class StrikethroughTheme

删除线样式配置

```ets
export class StrikethroughTheme {

  /**
   * 设置字体颜色
   * @param color 字体颜色
   * @return StrikethroughTheme
   */
  setStrikethroughTextFontColor(color: ResourceColor): StrikethroughTheme

  /**
   * 设置字体大小
   * @param size 字体大小
   * @return StrikethroughTheme
   */
  setStrikethroughTextFontSize(size: number | string | Resource): StrikethroughTheme

  /**
   * 设置字体样式
   * @param style 字体样式
   * @return StrikethroughTheme
   */
  setStrikethroughTextFontStyle(style: FontStyle): StrikethroughTheme

  /**
   * 设置字体粗细
   * @param weight 字体粗细
   * @return StrikethroughTheme
   */
  setStrikethroughTextFontWeight(weight: number | FontWeight): StrikethroughTheme

  /**
   * 设置字体族
   * @param family 字体族
   * @return StrikethroughTheme
   */
  setStrikethroughTextFontFamily(family: string | Resource): StrikethroughTheme

  /**
   * 设置行高
   * @param lineHeight 行高
   * @return StrikethroughTheme
   */
  setStrikethroughTextLineHeight(lineHeight: number | string | Resource): StrikethroughTheme

  /**
   * 设置字间距
   * @param spacing 字间距
   * @return StrikethroughTheme
   */
  setStrikethroughTextLetterSpacing(spacing: number): StrikethroughTheme

  /**
   * 设置装饰颜色
   * @param color 装饰颜色
   * @return StrikethroughTheme
   */
  setStrikethroughTextDecorationColor(color: ResourceColor): StrikethroughTheme

  /**
   * 设置装饰样式
   * @param style 装饰样式
   * @return StrikethroughTheme
   */
  setStrikethroughTextDecorationStyle(style: TextDecorationStyle): StrikethroughTheme
}
```

### class SubTheme

下标样式配置

```ets
export class SubTheme {

  /**
   * 设置字体颜色
   * @param color 字体颜色
   * @return SubTheme
   */
  setSubTextFontColor(color: ResourceColor): SubTheme

  /**
   * 设置字体大小
   * @param size 字体大小
   * @return SubTheme
   */
  setSubTextFontSize(size: number | string | Resource): SubTheme

  /**
   * 设置字体样式
   * @param style 字体样式
   * @return SubTheme
   */
  setSubTextFontStyle(style: FontStyle): SubTheme

  /**
   * 设置字体粗细
   * @param weight 字体粗细
   * @return SubTheme
   */
  setSubTextFontWeight(weight: number | FontWeight): SubTheme

  /**
   * 设置字体族
   * @param family 字体族
   * @return SubTheme
   */
  setSubTextFontFamily(family: string | Resource): SubTheme

  /**
   * 设置字符间距
   * @param spacing 字符间距
   * @return SubTheme
   */
  setSubTextLetterSpacing(spacing: number): SubTheme

  /**
   * 设置基线偏移
   * @param offset 基线偏移
   * @return SubTheme
   */
  setSubTextBaselineOffset(offset: number): SubTheme
}
```

### class SupTheme

上标样式配置

```ets
export class SupTheme {

  /**
   * 设置字体颜色
   * @param color 字体颜色
   * @return SupTheme
   */
  setSupTextFontColor(color: ResourceColor): SupTheme

  /**
   * 设置字体大小
   * @param size 字体大小
   * @return SupTheme
   */
  setSupTextFontSize(size: number | string | Resource): SupTheme

  /**
   * 设置字体样式
   * @param style 字体样式
   * @return SupTheme
   */
  setSupTextFontStyle(style: FontStyle): SupTheme

  /**
   * 设置字体粗细
   * @param weight 字体粗细
   * @return SupTheme
   */
  setSupTextFontWeight(weight: number | FontWeight): SupTheme

  /**
   * 设置字体族
   * @param family 字体族
   * @return SupTheme
   */
  setSupTextFontFamily(family: string | Resource): SupTheme

  /**
   * 设置字符间距
   * @param spacing 字符间距
   * @return SupTheme
   */
  setSupTextLetterSpacing(spacing: number): SupTheme

  /**
   * 设置基线偏移
   * @param offset 基线偏移
   * @return SupTheme
   */
  setSupTextBaselineOffset(offset: number): SupTheme
}
```

### class TableTheme

表格样式配置

```ets
export class TableTheme {

  /**
   * 设置表格标题背景颜色
   * @param color 颜色
   * @return TableTheme
   */
  setTableTitleBackgroundColor(color: ResourceColor): TableTheme

  /**
   * 设置表格内容奇数行背景颜色
   * @param color 颜色
   * @return TableTheme
   */
  setTableContentOddRowBackgroundColor(color: ResourceColor): TableTheme

  /**
   * 设置表格内容偶数行背景颜色
   * @param color 颜色
   * @return TableTheme
   */
  setTableContentEvenRowBackgroundColor(color: ResourceColor): TableTheme

  /**
   * 设置表格边距
   * @param options 边距选项
   * @return TableTheme
   */
  setTableMargin(options: Margin | Length): TableTheme

  /**
   * 设置表格内边距
   * @param options 内边距选项
   * @return TableTheme
   */
  setTablePadding(options: Padding | Length): TableTheme

  /**
   * 设置单元格内边距
   * @param options 内边距选项
   * @return TableTheme
   */
  setTableCellPadding(options: Padding | Length): TableTheme

  /**
   * 设置表格边框样式
   * @param style 边框样式
   * @return TableTheme
   */
  setTableBorderStyle(style: BorderStyle): TableTheme

  /**
   * 设置表格边框宽度
   * @param width 边框宽度
   * @return TableTheme
   */
  setTableBorderWidth(width: Length): TableTheme

  /**
   * 设置表格边框颜色
   * @param color 颜色
   * @return TableTheme
   */
  setTableBorderColor(color: ResourceColor): TableTheme

  /**
   * 设置表格圆角
   * @param options 圆角选项
   * @return TableTheme
   */
  setTableRadius(options: BorderRadiuses | Length): TableTheme

  /**
   * 设置表格滚动条状态
   * @param state 滚动条状态
   * @return TableTheme
   */
  setTableScrollBarState(state: BarState): TableTheme

  /**
   * 设置表格滚动条颜色
   * @param color 颜色
   * @return TableTheme
   */
  setTableScrollBarColor(color: Color | number | string): TableTheme

  /**
   * 设置表格最小单元格宽度
   * @param width 最小单元格宽度
   * @return TableTheme
   */
  setTableMinCellWidth(width: Length): TableTheme

  /**
   * 设置表格最大单元格宽度
   * @param width 最大单元格宽度
   * @return TableTheme
   */
  setTableMaxCellWidth(width: Length): TableTheme

  /**
   * 设置表格第一列是否加粗
   * @param isBold 是否加粗
   * @return TableTheme
   */
  setTableFirstColumnIsBold(isBold: boolean): TableTheme

  /**
   * 设置表格标题文字字体颜色
   * @param color 颜色
   * @return TableTheme
   */
  setTableTitleTextFontColor(color: ResourceColor): TableTheme

  /**
   * 设置表格标题文字字体大小
   * @param size 字体大小
   * @return TableTheme
   */
  setTableTitleTextFontSize(size: number | string | Resource): TableTheme

  /**
   * 设置表格标题文字字体样式
   * @param style 字体样式
   * @return TableTheme
   */
  setTableTitleTextFontStyle(style: FontStyle): TableTheme

  /**
   * 设置表格标题文字字体粗细
   * @param weight 字体粗细
   * @return TableTheme
   */
  setTableTitleTextFontWeight(weight: number | FontWeight): TableTheme

  /**
   * 设置表格标题文字字体族
   * @param family 字体族
   * @return TableTheme
   */
  setTableTitleTextFontFamily(family: string | Resource): TableTheme

  /**
   * 设置表格标题文字行高
   * @param lineHeight 行高
   * @return TableTheme
   */
  setTableTitleTextLineHeight(lineHeight: number | string | Resource): TableTheme

  /**
   * 设置表格标题文字字间距
   * @param spacing 字间距
   * @return TableTheme
   */
  setTableTitleTextLetterSpacing(spacing: number): TableTheme

  /**
   * 设置表格内容文字字体颜色
   * @param color 颜色
   * @return TableTheme
   */
  setTableContentTextFontColor(color: ResourceColor): TableTheme

  /**
   * 设置表格内容文字字体大小
   * @param size 字体大小
   * @return TableTheme
   */
  setTableContentTextFontSize(size: number | string | Resource): TableTheme

  /**
   * 设置表格内容文字字体样式
   * @param style 字体样式
   * @return TableTheme
   */
  setTableContentTextFontStyle(style: FontStyle): TableTheme

  /**
   * 设置表格内容文字字体粗细
   * @param weight 字体粗细
   * @return TableTheme
   */
  setTableContentTextFontWeight(weight: number | FontWeight): TableTheme

  /**
   * 设置表格内容文字字体族
   * @param family 字体族
   * @return TableTheme
   */
  setTableContentTextFontFamily(family: string | Resource): TableTheme

  /**
   * 设置表格内容文字行高
   * @param lineHeight 行高
   * @return TableTheme
   */
  setTableContentTextLineHeight(lineHeight: number | string | Resource): TableTheme

  /**
   * 设置表格内容文字字间距
   * @param spacing 字间距
   * @return TableTheme
   */
  setTableContentTextLetterSpacing(spacing: number): TableTheme

  /**
   * 设置表格标题行是否吸顶
   * @param enable 是否吸顶
   * @return TableTheme
   */
  setTableStickyHeader(enable: boolean): TableTheme

  /**
   * 设置表格头是否显示
   * @param enable 是否显示表头 true显示 false不显示
   * @return TableTheme
   */
  setTableHeadIsShow(enable: boolean): TableTheme

  /**
   * 设置表格头标题文本
   * @param text 标题文本
   * @return TableTheme
   */
  setTableHeadTitleText(text: string): TableTheme

  /**
   * 设置表格头标题文本字体族
   * @param family 字体族
   * @return TableTheme
   */
  setTableHeadTitleTextFontFamily(family: string | Resource | undefined): TableTheme

  /**
   * 设置表格头标题文本字体大小
   * @param size 字体大小
   * @return TableTheme
   */
  setTableHeadTitleTextFontSize(size: number | string | Resource | undefined): TableTheme

  /**
   * 设置表格头标题文本字体粗细
   * @param weight 字体粗细
   * @return TableTheme
   */
  setTableHeadTitleTextFontWeight(weight: number | FontWeight | undefined): TableTheme

  /**
   * 设置表格头标题文本字体样式
   * @param style 字体样式
   * @return TableTheme
   */
  setTableHeadTitleTextFontStyle(style: FontStyle | undefined): TableTheme

  /**
   * 设置表格头标题文本字体颜色
   * @param color 颜色
   * @return TableTheme
   */
  setTableHeadTitleTextFontColor(color: ResourceColor | undefined): TableTheme

  /**
   * 设置表格头标题文本行高
   * @param lineHeight 行高
   * @return TableTheme
   */
  setTableHeadTitleTextLineHeight(lineHeight: number | string | Resource | undefined): TableTheme

  /**
   * 设置表格头标题文本左边距
   * @param marginLeft 左边距
   * @return TableTheme
   */
  setTableHeadTitleTextMarginLeft(marginLeft: Length): TableTheme

  /**
   * 设置表格头复制图标
   * @param icon 图标资源
   * @return TableTheme
   */
  setTableHeadCopyIcon(icon: Resource | undefined): TableTheme

  /**
   * 设置表格头复制图标宽度
   * @param width 宽度
   * @return TableTheme
   */
  setTableHeadCopyIconWidth(width: Length): TableTheme

  /**
   * 设置表格头复制图标高度
   * @param height 高度
   * @return TableTheme
   */
  setTableHeadCopyIconHeight(height: Length): TableTheme

  /**
   * 设置表格头复制图标右边距
   * @param marginRight 右边距
   * @return TableTheme
   */
  setTableHeadCopyIconMarginRight(marginRight: Length): TableTheme
}
```

### class VideoTheme

视频样式配置

```ets
export class VideoTheme {

  /**
   * 设置视频背景颜色
   * @param color 背景颜色
   * @return VideoTheme
   */
  setVideoBackgroundColor(color: ResourceColor): VideoTheme

  /**
   * 设置视频边距
   * @param options 边距选项
   * @return VideoTheme
   */
  setVideoMargin(options: Margin | Length): VideoTheme

  /**
   * 设置视频内边距
   * @param options 内边距选项
   * @return VideoTheme
   */
  setVideoPadding(options: Padding | Length): VideoTheme

  /**
   * 设置视频圆角
   * @param options 圆角选项
   * @return VideoTheme
   */
  setVideoBorderRadius(options: BorderRadiuses | Length): VideoTheme

  /**
   * 设置视频边框样式
   * @param borderStyle 边框样式
   * @return VideoTheme
   */
  setVideoBorderStyle(borderStyle: BorderStyle): VideoTheme

  /**
   * 设置视频边框宽度
   * @param borderWidth 边框宽度
   * @return VideoTheme
   */
  setVideoBorderWidth(borderWidth: Length): VideoTheme

  /**
   * 设置视频边框颜色
   * @param borderColor 边框颜色
   * @return VideoTheme
   */
  setVideoBorderColor(borderColor: ResourceColor): VideoTheme

  /**
   * 设置视频占位图
   * @param resource 资源
   * @return VideoTheme
   */
  setVideoPlaceholder(resource: Resource): VideoTheme

  /**
   * 设置视频图片填充类型
   * @param fitType 填充类型
   * @return VideoTheme
   */
  setVideoImageFitType(fitType: ImageFit): VideoTheme

  /**
   * 设置视频播放图标
   * @param icon 图标资源
   * @return VideoTheme
   */
  setVideoPlayIcon(icon: Resource): VideoTheme

  /**
   * 设置视频播放图标宽度
   * @param width 宽度
   * @return VideoTheme
   */
  setVideoPlayIconWidth(width: Length): VideoTheme

  /**
   * 设置视频播放图标高度
   * @param height 高度
   * @return VideoTheme
   */
  setVideoPlayIconHeight(height: Length): VideoTheme

  /**
   * 设置视频播放图标填充类型
   * @param fitType 填充类型
   * @return VideoTheme
   */
  setVideoPlayIconFitType(fitType: ImageFit): VideoTheme

  /**
   * 设置视频时间文本字体颜色
   * @param color 字体颜色
   * @return VideoTheme
   */
  setVideoTimeTextFontColor(color: ResourceColor): VideoTheme

  /**
   * 设置视频时间文本字体大小
   * @param size 字体大小
   * @return VideoTheme
   */
  setVideoTimeTextFontSize(size: number | string | Resource): VideoTheme

  /**
   * 设置视频时间文本字体样式
   * @param style 字体样式
   * @return VideoTheme
   */
  setVideoTimeTextFontStyle(style: FontStyle): VideoTheme

  /**
   * 设置视频时间文本字体粗细
   * @param weight 字体粗细
   * @return VideoTheme
   */
  setVideoTimeTextFontWeight(weight: number | FontWeight): VideoTheme

  /**
   * 设置视频时间文本字体族
   * @param family 字体族
   * @return VideoTheme
   */
  setVideoTimeTextFontFamily(family: string | Resource): VideoTheme

  /**
   * 设置视频时间文本行高
   * @param height 行高
   * @return VideoTheme
   */
  setVideoTimeTextLineHeight(height: number | string | Resource): VideoTheme

  /**
   * 设置视频时间文本右边距
   * @param margin 右边距
   * @return VideoTheme
   */
  setVideoTimeTextMarginRight(margin: Length): VideoTheme

  /**
   * 设置视频时间文本下边距
   * @param margin 下边距
   * @return VideoTheme
   */
  setVideoTimeTextMarginBottom(margin: Length): VideoTheme

  /**
   * 设置视频底部布局可见性
   * @param visible 是否可见
   * @return VideoTheme
   */
  setVideoBottomLayoutVisible(visible: boolean): VideoTheme

  /**
   * 设置视频底部布局上边距
   * @param marginTop 上边距
   * @return VideoTheme
   */
  setVideoBottomLayoutMarginTop(marginTop: Length): VideoTheme

  /**
   * 设置视频发布按钮可见性
   * @param visible 是否可见
   * @return VideoTheme
   */
  setVideoReleaseButtonVisible(visible: boolean): VideoTheme

  /**
   * 设置视频发布按钮背景颜色
   * @param color 背景颜色
   * @return VideoTheme
   */
  setVideoReleaseButtonBackgroundColor(color: ResourceColor): VideoTheme

  /**
   * 设置视频发布按钮宽度
   * @param width 宽度
   * @return VideoTheme
   */
  setVideoReleaseButtonWidth(width: Length): VideoTheme

  /**
   * 设置视频发布按钮高度
   * @param height 高度
   * @return VideoTheme
   */
  setVideoReleaseButtonHeight(height: Length): VideoTheme

  /**
   * 设置视频发布按钮圆角
   * @param options 圆角选项
   * @return VideoTheme
   */
  setVideoReleaseButtonRadius(options: BorderRadiuses | Length): VideoTheme

  /**
   * 设置视频发布按钮图标文本间距
   * @param gap 间距
   * @return VideoTheme
   */
  setVideoReleaseButtonIconTextGap(gap: number): VideoTheme

  /**
   * 设置视频发布按钮图标
   * @param icon 图标资源
   * @return VideoTheme
   */
  setVideoReleaseButtonIcon(icon: Resource): VideoTheme

  /**
   * 设置视频发布按钮图标宽度
   * @param width 宽度
   * @return VideoTheme
   */
  setVideoReleaseButtonIconWidth(width: Length): VideoTheme

  /**
   * 设置视频发布按钮图标高度
   * @param height 高度
   * @return VideoTheme
   */
  setVideoReleaseButtonIconHeight(height: Length): VideoTheme

  /**
   * 设置视频发布按钮文本
   * @param text 文本
   * @return VideoTheme
   */
  setVideoReleaseButtonText(text: string): VideoTheme

  /**
   * 设置视频发布按钮文本字体颜色
   * @param color 字体颜色
   * @return VideoTheme
   */
  setVideoReleaseButtonTextFontColor(color: ResourceColor): VideoTheme

  /**
   * 设置视频发布按钮文本字体大小
   * @param size 字体大小
   * @return VideoTheme
   */
  setVideoReleaseButtonTextFontSize(size: number | string | Resource): VideoTheme

  /**
   * 设置视频发布按钮文本字体样式
   * @param style 字体样式
   * @return VideoTheme
   */
  setVideoReleaseButtonTextFontStyle(style: FontStyle): VideoTheme

  /**
   * 设置视频发布按钮文本字体粗细
   * @param weight 字体粗细
   * @return VideoTheme
   */
  setVideoReleaseButtonTextFontWeight(weight: number | FontWeight): VideoTheme

  /**
   * 设置视频发布按钮文本字体族
   * @param family 字体族
   * @return VideoTheme
   */
  setVideoReleaseButtonTextFontFamily(family: string | Resource): VideoTheme

  /**
   * 设置视频发布按钮文本行高
   * @param height 行高
   * @return VideoTheme
   */
  setVideoReleaseButtonTextLineHeight(height: number | string | Resource): VideoTheme

  /**
   * 设置视频下载按钮可见性
   * @param visible 是否可见
   * @return VideoTheme
   */
  setVideoDownloadButtonVisible(visible: boolean): VideoTheme

  /**
   * 设置视频下载按钮背景颜色
   * @param color 背景颜色
   * @return VideoTheme
   */
  setVideoDownloadButtonBackgroundColor(color: ResourceColor): VideoTheme

  /**
   * 设置视频下载按钮宽度
   * @param width 宽度
   * @return VideoTheme
   */
  setVideoDownloadButtonWidth(width: Length): VideoTheme

  /**
   * 设置视频下载按钮高度
   * @param height 高度
   * @return VideoTheme
   */
  setVideoDownloadButtonHeight(height: Length): VideoTheme

  /**
   * 设置视频下载按钮圆角
   * @param options 圆角选项
   * @return VideoTheme
   */
  setVideoDownloadButtonRadius(options: BorderRadiuses | Length): VideoTheme

  /**
   * 设置视频下载按钮图标文本间距
   * @param gap 间距
   * @return VideoTheme
   */
  setVideoDownloadButtonIconTextGap(gap: number): VideoTheme

  /**
   * 设置视频下载按钮图标
   * @param icon 图标资源
   * @return VideoTheme
   */
  setVideoDownloadButtonIcon(icon: Resource): VideoTheme

  /**
   * 设置视频下载按钮图标宽度
   * @param width 宽度
   * @return VideoTheme
   */
  setVideoDownloadButtonIconWidth(width: Length): VideoTheme

  /**
   * 设置视频下载按钮图标高度
   * @param height 高度
   * @return VideoTheme
   */
  setVideoDownloadButtonIconHeight(height: Length): VideoTheme

  /**
   * 设置视频下载按钮文本
   * @param text 文本
   * @return VideoTheme
   */
  setVideoDownloadButtonText(text: string): VideoTheme

  /**
   * 设置视频下载按钮文本字体颜色
   * @param color 字体颜色
   * @return VideoTheme
   */
  setVideoDownloadButtonTextFontColor(color: ResourceColor): VideoTheme

  /**
   * 设置视频下载按钮文本字体大小
   * @param size 字体大小
   * @return VideoTheme
   */
  setVideoDownloadButtonTextFontSize(size: number | string | Resource): VideoTheme

  /**
   * 设置视频下载按钮文本字体样式
   * @param style 字体样式
   * @return VideoTheme
   */
  setVideoDownloadButtonTextFontStyle(style: FontStyle): VideoTheme

  /**
   * 设置视频下载按钮文本字体粗细
   * @param weight 字体粗细
   * @return VideoTheme
   */
  setVideoDownloadButtonTextFontWeight(weight: number | FontWeight): VideoTheme

  /**
   * 设置视频下载按钮文本字体族
   * @param family 字体族
   * @return VideoTheme
   */
  setVideoDownloadButtonTextFontFamily(family: string | Resource): VideoTheme

  /**
   * 设置视频下载按钮文本行高
   * @param height 行高
   * @return VideoTheme
   */
  setVideoDownloadButtonTextLineHeight(height: number | string | Resource): VideoTheme
}
```

### interface MarkdownMarginArrayOptions

通用外边距数组配置

```ets
export interface MarkdownMarginArrayOptions {
  top?: Length[]
  right?: Length[]
  bottom?: Length[]
  left?: Length[]
}
```

### interface MarkdownPaddingArrayOptions

通用内边距数组配置

```ets
export interface MarkdownPaddingArrayOptions {
  top?: Length[]
  right?: Length[]
  bottom?: Length[]
  left?: Length[]
}
```

### class MarkdownNodeViewString

全局文本对象

```ets
export class MarkdownNodeViewString {
  /**
   * 构造函数
   */
  constructor()


  /**
   * 获取全局文本
   * @return 全局文本
   */
  toString(): string
}
```

### class CustomViewRegistry

自定义标签视图注册表（全局生效）

```ets
export class CustomViewRegistry {
  /**
   * 注册自定义标签（仅标签名，渲染由 customTagViewComponent 回调完成）
   * @param tag 标签名（大小写不敏感，内部统一小写存储）
   */
  static register(tag: string): void

  /**
   * 注销自定义标签
   * @param tag 标签名
   */
  static unregister(tag: string): void

  /**
   * 标签是否已注册
   * @param tag 标签名
   * @return true：已注册；false：未注册
   */
  static isRegistered(tag: string): boolean

  /**
   * 解析前预处理：把已注册标签的原文包进无语言围栏代码块
   * @param content 原始 markdown 文本
   * @return 预处理后的文本
   */
  static preprocessCustomTags(content: string): string

  /**
   * 从 HtmlBlock 原文解析自定义标签（仅解析第一个开标签）
   * @param literal HtmlBlock 原文
   * @return 解析结果；不是合法开标签时返回 undefined
   */
  static parseTagLiteral(literal: string | undefined): ParsedCustomTag | undefined
}
```

### class ParsedCustomTag

自定义标签解析结果

```ets
export class ParsedCustomTag {
  tag: string = '' // 标签名（统一小写）
  attrs: Record<string, string> = {} // 标签属性表
  content: string = '' // 开闭标签之间的内容
}
```

### enum DelimiterFilterMode

分隔符过滤模式

```ets
export enum DelimiterFilterMode {
  Permissive,
  Strict,
  Whitelist,
}
```

### interface MarkdownExposureEvent

元素曝光事件模型。

```ets
export interface MarkdownExposureEvent {
  eventType: string
  visible: boolean
  data: string
}
```

### class MarkdownScrollController

外层滚动控制器

```ets
export class MarkdownScrollController {
  /**
   * 注册滚动Y监听（由 CJMarkdown 内部调用）
   */
  setListener(listener: ((yOffset: number) => void) | null): void

  /**
   * 通知滚动Y变化（由页面在外层 Scroll.onScrollFrameBegin 中调用）
   */
  notifyScrollY(yOffset: number): void
}
```

### class MarkdownHighlightParagraph

markdown 段落高亮配置（通过 MarkdownConfiguration#getMarkdownHighlightParagraph 获取）

```ets
export class MarkdownHighlightParagraph {
  /**
   * (markdown解析后自动调用)设置所有可以设置高亮的段落nodeHash集合
   * @param itemNodeHashList 段落nodeHash集合
   */
  setAllParagraphItems(itemNodeHashList: ArrayList<string>): void

  /**
   * 获取所有可以设置高亮的段落的nodeHash集合
   * @return 段落nodeHash集合
   */
  getAllParagraphItems(): Array<string>

  /**
   * 获取当前高亮显示的段落nodeHash集合
   * @return 段落nodeHash集合
   */
  getSelectedParagraphItems(): ArrayList<string>

  /**
   * 设置指定段落高亮显示
   * @param nodeHash 段落nodeHash
   * @param color 段落高亮颜色
   * @return 是否设置成功 false表示已经设置过或设置失败
   */
  setParagraphHighlight(nodeHash: string, color: ResourceColor): boolean

  /**
   * 取消指定段落的高亮
   * @param nodeHash 段落nodeHash
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
}
```
