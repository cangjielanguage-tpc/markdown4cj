/**
 * Markdown插件配置
 */
export class MarkdownPlugin {
  /**
   * 是否加载音频解析插件
   */
  private isBlockAudioPlugin: boolean = false
  /**
   * 是否加载视频解析插件
   */
  private isBlockVideoPlugin: boolean = false
  /**
   * 是否加载代码列表解析插件
   */
  private isCodeListPlugin: boolean = false
  /**
   * 是否加载脚注解析插件
   */
  private isFootnotePlugin: boolean = false
  /**
   * 是否加载html解析插件
   */
  private isHtmlPlugin: boolean = false
  /**
   * 是否加载表格解析插件
   */
  private isTablePlugin: boolean = false
  /**
   * 是否加载toc解析插件
   */
  private isTocPlugin: boolean = false
  /**
   * 是否加载任务列表解析插件
   */
  private isTaskListPlugin: boolean = false
  /**
   * 是否加载删除线解析插件
   */
  private isStrikethroughPlugin: boolean = false
  /**
   * 是否加载链接自动解析插件
   */
  private isLinkifyPlugin: boolean = false
  /**
   * 正则列表
   */
  private regs: Array<string> = []
  /**
   * 是否加载链接单独解析插件
   */
  private isLinkViewPlugin: boolean = false
  /**
   * 是否加载图片自定义样式解析插件
   */
  private isImageStylePlugin: boolean = false
  /**
   * 是否加载图片banner解析插件
   */
  private isImageSlidePlugin: boolean = false
  /**
   * 是否加载图片单独提取到block解析插件
   */
  private isImageTextMixPlugin: boolean = false
  /**
   * 是否加载图片视频列表url集合列表解析插件
   */
  private isImageCollectPlugin: boolean = false
  /**
   * 是否加载定义列表解析插件
   */
  private isDescListPlugin: boolean = false
  /**
   * 是否加载标题ID解析插件
   */
  private isHeadIDPlugin: boolean = false
  /**
   * 是否加载下标解析插件
   */
  private isSubPlugin: boolean = false
  /**
   * 是否加载上标解析插件
   */
  private isSupPlugin: boolean = false
  /**
   * 是否加载emoji解析插件
   */
  private isEmojiPlugin: boolean = false
  /**
   * emoji解析插件是否精简加载
   */
  private isEmojiLight: boolean = false

  /**
   * 是否加载高亮解析插件
   */
  private isHighlightPlugin: boolean = false

  /**
   * 是否加载白名单宽松分隔符插件
   */
  private isWhitelistPlugin: boolean = false

  /**
   * 分隔符过滤模式
   */
  private mode: DelimiterFilterMode = DelimiterFilterMode.Permissive

  /**
   * 白名单列表
   */
  private whitelist: Array<string> = []

  /**
   * 设置音频插件
   *
   * @param isBlockAudioPlugin 是否设置音频插件 - true：设置音频插件；false：不设置音频插件。默认false
   */
  setIsBlockAudioPlugin(isBlockAudioPlugin: boolean): MarkdownPlugin {
    this.isBlockAudioPlugin = isBlockAudioPlugin
    return this
  }

  /**
   * 设置视频插件
   *
   * @param isBlockVideoPlugin 是否设置视频插件 - true：设置视频插件；false：不设置视频插件。默认false
   */
  setIsBlockVideoPlugin(isBlockVideoPlugin: boolean): MarkdownPlugin {
    this.isBlockVideoPlugin = isBlockVideoPlugin
    return this
  }

  /**
   * 设置组合代码块列表插件
   *
   * @param isCodeListPlugin 是否设置组合代码块列表插件 - true：设置组合代码块列表插件；false：不设置组合代码块列表插件。默认false
   */
  setIsCodeListPlugin(isCodeListPlugin: boolean): MarkdownPlugin {
    this.isCodeListPlugin = isCodeListPlugin
    return this
  }

  /**
   * 设置脚注插件
   *
   * @param isFootnotePlugin 是否设置脚注插件 - true：设置脚注插件；false：不设置脚注插件。默认false
   */
  setIsFootnotePlugin(isFootnotePlugin: boolean): MarkdownPlugin {
    this.isFootnotePlugin = isFootnotePlugin
    return this
  }

  /**
   * 设置HTML插件
   *
   * @param isHtmlPlugin 是否设置HTML插件 - true：设置HTML插件；false：不设置HTML插件。默认false
   */
  setIsHtmlPlugin(isHtmlPlugin: boolean): MarkdownPlugin {
    this.isHtmlPlugin = isHtmlPlugin
    return this
  }

  /**
   * 设置表格插件
   *
   * @param isTablePlugin 是否设置表格插件 - true：设置表格插件；false：不设置表格插件。默认false
   */
  setIsTablePlugin(isTablePlugin: boolean): MarkdownPlugin {
    this.isTablePlugin = isTablePlugin
    return this
  }

  /**
   * 设置TOC插件
   *
   * @param isTocPlugin 是否设置TOC插件 - true：设置TOC插件；false：不设置TOC插件。默认false
   */
  setIsTocPlugin(isTocPlugin: boolean): MarkdownPlugin {
    this.isTocPlugin = isTocPlugin
    return this
  }

  /**
   * 设置任务列表插件
   *
   * @param isTaskListPlugin 是否设置任务列表插件 - true：设置任务列表插件；false：不设置任务列表插件。默认false
   */
  setIsTaskListPlugin(isTaskListPlugin: boolean): MarkdownPlugin {
    this.isTaskListPlugin = isTaskListPlugin
    return this
  }

  /**
   * 设置删除线插件
   *
   * @param isStrikethroughPlugin 是否设置删除线插件 - true：设置删除线插件；false：不设置删除线插件。默认false
   */
  setIsStrikethroughPlugin(isStrikethroughPlugin: boolean): MarkdownPlugin {
    this.isStrikethroughPlugin = isStrikethroughPlugin
    return this
  }

  /**
   * 设置链接自动加载插件
   *
   * @param isLinkifyPlugin 是否设置链接自动加载插件 - true：设置链接自动加载插件；false：不设置链接自动加载插件。默认false
   * @param regs 正则列表
   */
  setIsLinkifyPlugin(isLinkifyPlugin: boolean, regs?: Array<string>): MarkdownPlugin {
    this.isLinkifyPlugin = isLinkifyPlugin
    // 判断是否传入了 regs 参数
    if (regs !== undefined) {
      this.regs = regs
    }
    return this
  }

  /**
   * 设置链接块状化插件
   *
   * @param isLinkViewPlugin 是否设置链接块状化插件 - true：设置链接块状化插件；false：不设置链接块状化插件。默认false
   */
  setIsLinkViewPlugin(isLinkViewPlugin: boolean): MarkdownPlugin {
    this.isLinkViewPlugin = isLinkViewPlugin
    return this
  }

  /**
   * 设置图片样式插件
   *
   * @param isImageStylePlugin 是否设置图片样式插件 - true：设置图片样式插件；false：不设置图片样式插件。默认false
   */
  setIsImageStylePlugin(isImageStylePlugin: boolean): MarkdownPlugin {
    this.isImageStylePlugin = isImageStylePlugin
    return this
  }

  /**
   * 设置图片幻灯片（Banner）插件
   *
   * @param isImageSlidePlugin 是否设置图片幻灯片（Banner）插件 - true：设置图片幻灯片（Banner）插件；false：不设置图片幻灯片（Banner）插件。默认false
   */
  setIsImageSlidePlugin(isImageSlidePlugin: boolean): MarkdownPlugin {
    this.isImageSlidePlugin = isImageSlidePlugin
    return this
  }

  /**
   * 设置图片不混排插件
   *
   * @param isImageTextMixPlugin 是否图片不混排插件 - true：图片不混排；false：图片混排。默认false
   */
  setIsImageTextMixPlugin(isImageTextMixPlugin: boolean): MarkdownPlugin {
    this.isImageTextMixPlugin = isImageTextMixPlugin
    return this
  }

  /**
   * 设置图片视频url集合列表插件
   *
   * @param isImageCollectPlugin 是否设置图片视频url集合列表插件 - true：设置图片视频url集合列表插件；false：不设置图片视频url集合列表插件。默认false
   */
  setIsImageCollectPlugin(isImageCollectPlugin: boolean): MarkdownPlugin {
    this.isImageCollectPlugin = isImageCollectPlugin
    return this
  }

  /**
   * 设置是否加载定义列表解析插件
   *
   * @param isDescListPlugin 是否加载定义列表解析插件 - true：启用定义列表解析插件；false：禁用定义列表解析插件。默认false
   */
  setIsDescListPlugin(isDescListPlugin: boolean): MarkdownPlugin {
    this.isDescListPlugin = isDescListPlugin
    return this
  }

  /**
   * 设置是否加载标题ID解析插件
   *
   * @param isHeadIDPlugin 是否加载标题ID解析插件 - true：设置加载标题ID解析插件；false：不设置加载标题ID解析插件。默认false
   */
  setIsHeadIDPlugin(isHeadIDPlugin: boolean): MarkdownPlugin {
    this.isHeadIDPlugin = isHeadIDPlugin
    return this
  }

  /**
   * 设置是否加载下标解析插件
   *
   * @param isSubPlugin 是否加载下标解析插件 - true：设置加载下标解析插件；false：不设置加载下标解析插件。默认false
   */
  setIsSubPlugin(isSubPlugin: boolean): MarkdownPlugin {
    this.isSubPlugin = isSubPlugin
    return this
  }

  /**
   * 设置是否加载上标解析插件
   *
   * @param isSupPlugin 是否加载上标解析插件 - true：设置加载上标解析插件；false：不设置加载上标解析插件。默认false
   */
  setIsSupPlugin(isSupPlugin: boolean): MarkdownPlugin {
    this.isSupPlugin = isSupPlugin
    return this
  }

  /**
   * 设置是否加载emoji解析插件
   *
   * @param isEmojiPlugin 是否加载Emoji解析插件 - true：设置加载Emoji解析插件；false：不设置加载Emoji解析插件。默认false
   * @param isEmojiLight 是否加载精简emoji表情 - true：加载精简emoji表情；false：不加载精简emoji表情。默认true
   */
  setIsEmojiPlugin(isEmojiPlugin: boolean, isEmojiLight: boolean): MarkdownPlugin {
    this.isEmojiPlugin = isEmojiPlugin
    this.isEmojiLight = isEmojiLight
    return this
  }

  /**
   * 设置是否加载高亮解析插件
   *
   * @param isHighlightPlugin 是否加载高亮解析插件 - true：设置加载高亮解析插件；false：不设置加载高亮解析插件。默认false
   */
  setIsHighlightPlugin(isHighlightPlugin: boolean): MarkdownPlugin {
    this.isHighlightPlugin = isHighlightPlugin
    return this
  }

  /**
   * 设置是否加载白名单宽松分隔符插件
   *
   * @param mode 加载模式。 - undefined：不加载插件。DelimiterFilterMode：(0:宽松模式，1：严格模式)。Array<string>：白名单模式
   */
   setIsWhitelistPlugin(mode: undefined | DelimiterFilterMode | Array<string>): MarkdownPlugin {
    if (mode ===  undefined) {
      this.isWhitelistPlugin = false
      return this
    }
    this.isWhitelistPlugin = true
    if (Array.isArray(mode)) {
      this.whitelist = mode
      this.mode = 2
    } else {
      this.mode = mode
    }
    return this
  }

  /**
   * 获取是否加载音频解析插件
   *
   * @returns 是否加载音频解析插件
   */
  getIsBlockAudioPlugin(): boolean {
    return this.isBlockAudioPlugin
  }

  /**
   * 获取是否加载视频解析插件
   *
   * @returns 是否加载视频解析插件
   */
  getIsBlockVideoPlugin(): boolean {
    return this.isBlockVideoPlugin
  }

  /**
   * 获取是否加载代码列表解析插件
   *
   * @returns 是否加载代码列表解析插件
   */
  getIsCodeListPlugin(): boolean {
    return this.isCodeListPlugin
  }

  /**
   * 获取是否加载脚注解析插件
   *
   * @returns 是否加载脚注解析插件
   */
  getIsFootnotePlugin(): boolean {
    return this.isFootnotePlugin
  }

  /**
   * 获取是否加载html解析插件
   *
   * @returns 是否加载html解析插件
   */
  getIsHtmlPlugin(): boolean {
    return this.isHtmlPlugin
  }

  /**
   * 获取是否加载表格解析插件
   *
   * @returns 是否加载表格解析插件
   */
  getIsTablePlugin(): boolean {
    return this.isTablePlugin
  }

  /**
   * 获取是否加载toc解析插件
   *
   * @returns 是否加载toc解析插件
   */
  getIsTocPlugin(): boolean {
    return this.isTocPlugin
  }

  /**
   * 获取是否加载任务列表解析插件
   *
   * @returns 是否加载任务列表解析插件
   */
  getIsTaskListPlugin(): boolean {
    return this.isTaskListPlugin
  }

  /**
   * 获取是否加载删除线解析插件
   *
   * @returns 是否加载删除线解析插件
   */
  getIsStrikethroughPlugin(): boolean {
    return this.isStrikethroughPlugin
  }

  /**
   * 获取是否加载链接自动解析插件
   *
   * @returns 是否加载链接自动解析插件
   */
  getIsLinkifyPlugin(): boolean {
    return this.isLinkifyPlugin
  }

  /**
   * 获取正则列表
   *
   * @returns 正则列表
   */
  getRegs(): Array<string> {
    return this.regs
  }

  /**
   * 获取是否加载链接单独解析插件
   *
   * @returns 是否加载链接单独解析插件
   */
  getIsLinkViewPlugin(): boolean {
    return this.isLinkViewPlugin
  }

  /**
   * 获取是否加载图片自定义样式解析插件
   *
   * @returns 是否加载图片自定义样式解析插件
   */
  getIsImageStylePlugin(): boolean {
    return this.isImageStylePlugin
  }

  /**
   * 获取是否加载图片banner解析插件
   *
   * @returns 是否加载图片banner解析插件
   */
  getIsImageSlidePlugin(): boolean {
    return this.isImageSlidePlugin
  }

  /**
   * 获取是否加载图片单独提取到block解析插件
   *
   * @returns 是否加载图片单独提取到block解析插件
   */
  getIsImageTextMixPlugin(): boolean {
    return this.isImageTextMixPlugin
  }

  /**
   * 获取是否加载图片视频列表url集合列表解析插件
   *
   * @returns 是否加载图片视频列表url集合列表解析插件
   */
  getIsImageCollectPlugin(): boolean {
    return this.isImageCollectPlugin
  }

  /**
   * 获取是否加载定义列表解析插件
   *
   * @returns 是否加载定义列表解析插件
   */
  getIsDescListPlugin(): boolean {
    return this.isDescListPlugin
  }

  /**
   * 获取是否加载标题ID解析插件
   *
   * @returns 是否加载标题ID解析插件
   */
  getIsHeadIDPlugin(): boolean {
    return this.isHeadIDPlugin
  }

  /**
   * 获取是否加载下标解析插件
   *
   * @returns 是否加载下标解析插件
   */
  getIsSubPlugin(): boolean {
    return this.isSubPlugin
  }

  /**
   * 获取是否加载上标解析插件
   *
   * @returns 是否加载上标解析插件
   */
  getIsSupPlugin(): boolean {
    return this.isSupPlugin
  }

  /**
   * 获取是否加载emoji解析插件
   *
   * @returns 是否加载emoji解析插件
   */
  getIsEmojiPlugin(): boolean {
    return this.isEmojiPlugin
  }

  /**
   * 获取emoji解析插件是否精简加载
   *
   * @returns emoji解析插件是否精简加载
   */
  getIsEmojiLight(): boolean {
    return this.isEmojiLight
  }

  /**
   * 获取是否加载高亮解析插件
   *
   * @returns 是否加载高亮解析插件
   */
  getIsHighlightPlugin(): boolean {
    return this.isHighlightPlugin
  }

  /**
   * 获取是否加载白名单宽松分隔符插件
   *
   * @returns 是否加载白名单宽松分隔符插件
   */
  getIsWhitelistPlugin(): boolean {
    return this.isWhitelistPlugin
  }

  /**
   * 获取分隔符过滤模式
   *
   * @returns 分隔符过滤模式
   */
  getMode(): DelimiterFilterMode {
    return this.mode
  }

  /**
   * 获取白名单列表
   *
   * @returns 白名单列表
   */
  getWhitelist(): Array<string> {
    return this.whitelist
  }
}

export enum DelimiterFilterMode{
   Permissive,  // 宽松模式（全部允许）
   Strict     // 严格模式（全部禁止）
}