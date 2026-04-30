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
   * 是否加载数学公式解析插件
   */
  private isLatexMathPlugin: boolean = false
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
   * 设置音频插件
   *
   * @param isBlockAudioPlugin 是否设置音频插件 - true：设置音频插件；false：不设置音频插件。默认false
   */
  setIsBlockAudioPlugin(isBlockAudioPlugin: boolean): void {
    this.isBlockAudioPlugin = isBlockAudioPlugin
  }

  /**
   * 设置视频插件
   *
   * @param isBlockVideoPlugin 是否设置视频插件 - true：设置视频插件；false：不设置视频插件。默认false
   */
  setIsBlockVideoPlugin(isBlockVideoPlugin: boolean): void {
    this.isBlockVideoPlugin = isBlockVideoPlugin
  }

  /**
   * 设置组合代码快列表插件
   *
   * @param isCodeListPlugin 是否设置组合代码快列表插件 - true：设置组合代码快列表插件；false：不设置组合代码快列表插件。默认false
   */
  setIsCodeListPlugin(isCodeListPlugin: boolean): void {
    this.isCodeListPlugin = isCodeListPlugin
  }

  /**
   * 设置脚注插件
   *
   * @param isFootnotePlugin 是否设置脚注插件 - true：设置脚注插件；false：不设置脚注插件。默认false
   */
  setIsFootnotePlugin(isFootnotePlugin: boolean): void {
    this.isFootnotePlugin = isFootnotePlugin
  }

  /**
   * 设置HTML插件
   *
   * @param isHtmlPlugin 是否设置HTML插件 - true：设置HTML插件；false：不设置HTML插件。默认false
   */
  setIsHtmlPlugin(isHtmlPlugin: boolean): void {
    this.isHtmlPlugin = isHtmlPlugin
  }

  /**
   * 设置表格插件
   *
   * @param isTablePlugin 是否设置表格插件 - true：设置表格插件；false：不设置表格插件。默认false
   */
  setIsTablePlugin(isTablePlugin: boolean): void {
    this.isTablePlugin = isTablePlugin
  }

  /**
   * 设置TOC插件
   *
   * @param isTocPlugin 是否设置TOC插件 - true：设置TOC插件；false：不设置TOC插件。默认false
   */
  setIsTocPlugin(isTocPlugin: boolean): void {
    this.isTocPlugin = isTocPlugin
  }

  /**
   * 设置任务列表插件
   *
   * @param isTaskListPlugin 是否设置任务列表插件 - true：设置任务列表插件；false：不设置任务列表插件。默认false
   */
  setIsTaskListPlugin(isTaskListPlugin: boolean): void {
    this.isTaskListPlugin = isTaskListPlugin
  }

  /**
   * 设置删除线插件
   *
   * @param isStrikethroughPlugin 是否设置删除线插件 - true：设置删除线插件；false：不设置删除线插件。默认false
   */
  setIsStrikethroughPlugin(isStrikethroughPlugin: boolean): void {
    this.isStrikethroughPlugin = isStrikethroughPlugin
  }

  /**
   * 设置链接自动加载插件
   *
   * @param isLinkifyPlugin 是否设置链接自动加载插件 - true：设置链接自动加载插件；false：不设置链接自动加载插件。默认false
   * @param regs 正则列表
   */
  setIsLinkifyPlugin(isLinkifyPlugin: boolean, regs: Array<string>): void {
    this.isLinkifyPlugin = isLinkifyPlugin
    this.regs = regs
  }

  /**
   * 设置链接块状化插件
   *
   * @param isLinkViewPlugin 是否设置链接块状化插件 - true：设置链接块状化插件；false：不设置链接块状化插件。默认false
   */
  setIsLinkViewPlugin(isLinkViewPlugin: boolean): void {
    this.isLinkViewPlugin = isLinkViewPlugin
  }

  /**
   * 设置数学公式插件
   *
   * @param isLatexMathPlugin 是否设置数学公式插件 - true：设置数学公式插件；false：不设置数学公式插件。默认false
   */
  setIsLatexMathPlugin(isLatexMathPlugin: boolean): void {
    this.isLatexMathPlugin = isLatexMathPlugin
  }

  /**
   * 设置图片样式插件
   *
   * @param isImageStylePlugin 是否设置图片样式插件 - true：设置图片样式插件；false：不设置图片样式插件。默认false
   */
  setIsImageStylePlugin(isImageStylePlugin: boolean): void {
    this.isImageStylePlugin = isImageStylePlugin
  }

  /**
   * 设置图片幻灯片（Banner）插件
   *
   * @param isImageSlidePlugin 是否设置图片幻灯片（Banner）插件 - true：设置图片幻灯片（Banner）插件；false：不设置图片幻灯片（Banner）插件。默认false
   */
  setIsImageSlidePlugin(isImageSlidePlugin: boolean): void {
    this.isImageSlidePlugin = isImageSlidePlugin
  }

  /**
   * 设置图片不混排插件
   *
   * @param isImageTextMixPlugin 是否图片不混排插件 - true：图片混排；false：图片不混排。默认true
   */
  setIsImageTextMixPlugin(isImageTextMixPlugin: boolean): void {
    this.isImageTextMixPlugin = isImageTextMixPlugin
  }

  /**
   * 设置图片视频url集合列表插件
   *
   * @param isImageCollectPlugin 是否设置图片视频url集合列表插件 - true：设置图片视频url集合列表插件；false：不设置图片视频url集合列表插件。默认false
   */
  setIsImageCollectPlugin(isImageCollectPlugin: boolean): void {
    this.isImageCollectPlugin = isImageCollectPlugin
  }

  /**
   * 设置是否加载定义列表解析插件
   *
   * @param isDescListPlugin 是否加载定义列表解析插件 - true：设置加载定义列表解析插件；false：不设置加载定义列表解析插件。默认false
   */
  setIsDescListPlugin(isDescListPlugin: boolean): void {
    this.isDescListPlugin = isDescListPlugin
  }

  /**
   * 设置是否加载标题ID解析插件
   *
   * @param isHeadIDPlugin 是否加载标题ID解析插件 - true：设置加载标题ID解析插件；false：不设置加载标题ID解析插件。默认false
   */
  setIsHeadIDPlugin(isHeadIDPlugin: boolean): void {
    this.isHeadIDPlugin = isHeadIDPlugin
  }

  /**
   * 设置是否加载下标解析插件
   *
   * @param isSubPlugin 是否加载下标解析插件 - true：设置加载下标解析插件；false：不设置加载下标解析插件。默认false
   */
  setIsSubPlugin(isSubPlugin: boolean): void {
    this.isSubPlugin = isSubPlugin
  }

  /**
   * 设置是否加载上标解析插件
   *
   * @param isSupPlugin 是否加载上标解析插件 - true：设置加载上标解析插件；false：不设置加载上标解析插件。默认false
   */
  setIsSupPlugin(isSupPlugin: boolean): void {
    this.isSupPlugin = isSupPlugin
  }

  /**
   * 设置是否加载emoji解析插件
   *
   * @param isEmojiPlugin 是否加载Emoji解析插件 - true：设置加载Emoji解析插件件；false：不设置加载Emoji解析插件。默认false
   * @param isEmojiLight 是否加载精简emoji表情 - true：加载精简emoji表情；false：不加载精简emoji表情。默认true
   */
  setIsEmojiPlugin(isEmojiPlugin: boolean, isEmojiLight: boolean): void {
    this.isEmojiPlugin = isEmojiPlugin
    this.isEmojiLight = isEmojiLight
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
   * 获取是否加载数学公式解析插件
   *
   * @returns 是否加载数学公式解析插件
   */
  getIsLatexMathPlugin(): boolean {
    return this.isLatexMathPlugin
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
}