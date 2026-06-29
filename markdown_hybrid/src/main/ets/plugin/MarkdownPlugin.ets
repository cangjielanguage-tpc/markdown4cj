import { DelimiterFilterMode } from "../enum/DelimiterFilterMode"
import { JsNodeImpl, Options } from "@cangjie-tpc/markdown_parser_hybrid"

/**
 * Markdown插件配置
 */
export class MarkdownPlugin {
  /**
   * 是否加载音频解析插件
   */
  isBlockAudioPlugin: boolean = false
  /**
   * 是否加载视频解析插件
   */
  isBlockVideoPlugin: boolean = false
  /**
   * 是否加载代码列表解析插件
   */
  isCodeListPlugin: boolean = false
  /**
   * 是否加载脚注解析插件
   */
  isFootnotePlugin: boolean = false
  /**
   * 是否加载html解析插件
   */
  isHtmlPlugin: boolean = false
  /**
   * 是否加载表格解析插件
   */
  isTablePlugin: boolean = false
  /**
   * 是否加载toc解析插件
   */
  isTocPlugin: boolean = false
  /**
   * 是否加载任务列表解析插件
   */
  isTaskListPlugin: boolean = false
  /**
   * 是否加载删除线解析插件
   */
  isStrikethroughPlugin: boolean = false
  /**
   * 是否加载链接自动解析插件
   */
  isLinkifyPlugin: boolean = false
  /**
   * 正则列表
   */
  regs: Array<string> = []
  /**
   * 是否加载链接单独解析插件
   */
  isLinkViewPlugin: boolean = false
  /**
   * 是否加载数学公式解析插件
   */
  isLatexMathPlugin: boolean = false
  /**
   * 是否加载图片自定义样式解析插件
   */
  isImageStylePlugin: boolean = false
  /**
   * 是否加载图片banner解析插件
   */
  isImageSlidePlugin: boolean = false
  /**
   * 是否加载图片单独提取到block解析插件
   */
  isImageTextMixPlugin: boolean = false
  /**
   * 是否加载图片视频列表url集合列表解析插件
   */
  isImageCollectPlugin: boolean = false
  /**
   * 是否加载定义列表解析插件
   */
  isDescListPlugin: boolean = false
  /**
   * 是否加载标题ID解析插件
   */
  isHeadIDPlugin: boolean = false
  /**
   * 是否加载下标解析插件
   */
  isSubPlugin: boolean = false
  /**
   * 是否加载上标解析插件
   */
  isSupPlugin: boolean = false
  /**
   * 是否加载emoji解析插件
   */
  isEmojiPlugin: boolean = false
  /**
   * emoji解析插件是否精简加载
   */
  isEmojiLight: boolean = false

  /**
   * 是否加载高亮解析插件
   */
  isHighlightPlugin: boolean = false

  /**
   * 是否加载白名单宽松分隔符插件
   */
  isWhitelistPlugin: boolean = false

  /**
   * 分隔符过滤模式
   */
  mode: DelimiterFilterMode = DelimiterFilterMode.Permissive

  /**
   * 白名单列表
   */
  whitelist: Array<string> = []

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
   * 设置组合代码块列表插件
   *
   * @param isCodeListPlugin 是否设置组合代码块列表插件 - true：设置组合代码块列表插件；false：不设置组合代码块列表插件。默认false
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
  setIsLinkifyPlugin(isLinkifyPlugin: boolean, regs?: Array<string>): void {
    this.isLinkifyPlugin = isLinkifyPlugin
    // 判断是否传入了 regs 参数
    if (regs !== undefined) {
      this.regs = regs
    }
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
   * @param isImageTextMixPlugin 是否图片不混排插件 - true：图片不混排；false：图片混排。默认false
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
   * @param isDescListPlugin 是否加载定义列表解析插件 - true：启用定义列表解析插件；false：禁用定义列表解析插件。默认false
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
   * @param isEmojiPlugin 是否加载Emoji解析插件 - true：设置加载Emoji解析插件；false：不设置加载Emoji解析插件。默认false
   * @param isEmojiLight 是否加载精简emoji表情 - true：加载精简emoji表情；false：不加载精简emoji表情。默认true
   */
  setIsEmojiPlugin(isEmojiPlugin: boolean, isEmojiLight: boolean): void {
    this.isEmojiPlugin = isEmojiPlugin
    this.isEmojiLight = isEmojiLight
  }

  /**
   * 设置是否加载高亮解析插件
   *
   * @param isHighlightPlugin 是否加载高亮解析插件 - true：设置加载高亮解析插件；false：不设置加载高亮解析插件。默认false
   */
  setIsHighlightPlugin(isHighlightPlugin: boolean): void {
    this.isHighlightPlugin = isHighlightPlugin
  }

  /**
   * 设置是否加载白名单宽松分隔符插件
   *
   * @param mode 加载模式。 - undefined：不加载插件。DelimiterFilterMode：(0:宽松模式，1：严格模式)。Array<string>：白名单模式
   */
  setIsWhitelistPlugin(mode: undefined | DelimiterFilterMode | Array<string>): void {
    if (mode ===  undefined) {
      this.isWhitelistPlugin = false
      return
    }
    this.isWhitelistPlugin = true
    if (Array.isArray(mode)) {
      this.whitelist = mode
      this.mode = 2
    } else {
      this.mode = mode
    }
  }

  /**
   * 根据插件配置构建解析器Options
   *
   * @param jsNodeFactory JsNode工厂函数
   * @returns 解析器Options对象
   */
  buildOptions(jsNodeFactory: () => JsNodeImpl): Options {
    return {
      jsNodeFactory: jsNodeFactory,
      includeSourceSpans: 2,
      ADPlugin: false,
      BlockAudioPlugin: this.isBlockAudioPlugin,
      BlockVideoPlugin: this.isBlockVideoPlugin,
      CodeListPlugin: this.isCodeListPlugin,
      DescListPlugin: this.isDescListPlugin,
      EmojiPlugin: this.isEmojiPlugin,
      EmojiPlugin_light: this.isEmojiLight,
      FootnotePlugin: this.isFootnotePlugin,
      HighlightDelimeterPlugin: this.isHighlightPlugin,
      HtmlPlugin: this.isHtmlPlugin,
      IdHeadingPlugin: this.isHeadIDPlugin,
      ImageCollectPlugin: this.isImageCollectPlugin,
      ImageSinglePlugin: false,
      ImageSlidePlugin: this.isImageSlidePlugin,
      ImageStylePlugin: this.isImageStylePlugin,
      ImageTextMixPlugin: this.isImageTextMixPlugin,
      ImageVideoPlugin: false,
      LatexMathPluginV2: this.isLatexMathPlugin,
      LinkifyPlugin: this.isLinkifyPlugin,
      LinkifyPlugin_regs: this.isLinkifyPlugin ? this.regs : undefined,
      LinkViewPlugin: this.isLinkViewPlugin,
      NodeIdPlugin: true,
      StrikethroughPlugin: this.isStrikethroughPlugin,
      SubPlugin: this.isSubPlugin,
      SupPlugin: this.isSupPlugin,
      TablePlugin: this.isTablePlugin,
      TaskListPlugin: this.isTaskListPlugin,
      TocPlugin: this.isTocPlugin,
      WhitelistLooseDelimiterPlugin: this.isWhitelistPlugin,
      WhitelistLooseDelimiterPlugin_DelimiterFilterMode:
        this.mode === DelimiterFilterMode.Permissive ? "Permissive" :
        this.mode === DelimiterFilterMode.Strict ? "Strict" :
        this.whitelist
    }
  }
}