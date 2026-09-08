/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
import {
  CJMarkdown,
  MarkdownConfiguration,
  MarkdownPlugin,
  MarkdownTheme,
  MarkdownScroller,
  MarkdownHighlightParagraph,
  MarkdownExposureEvent,
  MarkdownScrollController,
  MarkdownNodeViewString
} from '@cangjie-tpc/markdown_hybrid'
import hilog from '@ohos.hilog'
import { promptAction } from '@kit.ArkUI'

@Component
export struct CJMarkdownWrap {
  /**
   * 消息文本对象
   */
  @Prop
  input: string
  /**
   * markdown是否增量解析(true:增量解析,false:全量解析)
   */
  @State
  incrementalAnalysis: boolean = false
  /**
   * Markdown的控制器
   */
  @State
  scroller?: MarkdownScroller = undefined

  // ===== 段落高亮 =====
  /**
   * 段落高亮配置对象
   */
  @State
  highlightParagraph?: MarkdownHighlightParagraph = undefined

  // ===== 长按段落背景 =====
  /**
   * 是否启用长按段落背景效果
   */
  @Prop
  enableLongPressCallback: boolean = false

  // ===== 表格吸顶 =====
  /**
   * 是否启用表格首行吸顶
   */
  @Prop
  enableTableStickyHeader: boolean = false

  // ===== 表格复制 =====
  /**
   * 是否启用表格复制按钮
   */
  @Prop
  enableTableCopy: boolean = false

  // ===== 全文复制 =====
  /**
   * 全文文本对象
   */
  @State
  nodeViewString: MarkdownNodeViewString = new MarkdownNodeViewString()

  // ===== 超链接曝光 =====
  /**
   * 是否启用链接曝光回调
   */
  @Prop
  enableLinkExposure: boolean = false
  /**
   * 曝光可见阈值(0~1)
   */
  @Prop
  exposureThreshold: number = 0.5

  // ===== 段落出现效果 =====
  /**
   * 是否启用段落出现动画
   */
  @Prop
  enableParagraphAnimation: boolean = false

  // ===== 自定义卡片 =====
  /**
   * 是否启用自定义块级图片卡片
   */
  @Prop
  enableBlockImageCustom: boolean = false
  /**
   * 是否启用自定义行内图片卡片
   */
  @Prop
  enableInLineImageCustom: boolean = false
  /**
   * 是否启用自定义行内链接卡片
   */
  @Prop
  enableInLineLinkCustom: boolean = false

  // ===== 外层滚动控制器(表格吸顶-非固定高度模式) =====
  @State
  scrollController?: MarkdownScrollController = undefined

  build() {
    CJMarkdown({
      content: this.input,
      config: this.setConfiguration(),
      plugin: this.setPlugin(),
      listScroller: this.setScroller(),
      incrementalAnalysis: this.incrementalAnalysis
    })
  }

  /**
   * MarkdownConfiguration
   */
  setConfiguration(): MarkdownConfiguration {
    let config: MarkdownConfiguration = new MarkdownConfiguration()

    // 基础回调
    config.setLinkCallback(this.linkCallback.bind(this))
    config.setImageCallback(this.imageCallback.bind(this))
    config.setCodeCopyCallback(this.codeCopyCallback.bind(this))
    config.setCodeFullScreenCallback(this.codeFullScreenCallback.bind(this))

    // 全文复制
    config.setNodeString(this.nodeViewString)

    // 段落高亮
    if (this.highlightParagraph !== undefined) {
      config.setMarkdownHighlightParagraph(this.highlightParagraph)
    }

    // 长按段落背景效果
    if (this.enableLongPressCallback) {
      config.setCustomLongPressCallback(this.longPressCallback.bind(this))
    }

    // 表格复制
    if (this.enableTableCopy) {
      config.setTableCopyCallback(this.tableCopyCallback.bind(this))
    }

    // 超链接曝光
    if (this.enableLinkExposure) {
      config.setElementExposureCallback(this.exposureCallback.bind(this))
      config.setExposureThreshold(this.exposureThreshold)
    }

    // 段落出现效果
    if (this.enableParagraphAnimation) {
      config.setParagraphHeadingAnimationStart(this.paragraphAnimationStart.bind(this))
      config.setParagraphHeadingAnimationEnd(this.paragraphAnimationEnd.bind(this))
    }

    // 自定义卡片
    if (this.enableBlockImageCustom) {
      config.setIsBlockImageCustom(this.blockImageCustomCheck.bind(this))
    }
    if (this.enableInLineImageCustom) {
      config.setIsInLineImageCustom(this.inLineImageCustomCheck.bind(this))
    }
    if (this.enableInLineLinkCustom) {
      config.setIsInLineLinkCustom(this.inLineLinkCustomCheck.bind(this))
    }

    // 外层滚动控制器(表格吸顶)
    if (this.scrollController !== undefined) {
      config.setScrollController(this.scrollController)
    }

    // 主题样式
    let theme: MarkdownTheme = new MarkdownTheme()
    theme.setImageMaximumWidth(1)
    theme.setIsOnCopy(false)
    theme.setIsMarkdownParserSync(true)
    theme.setIsCodeBlockParserSync(true)
    theme.setImageFitType(1)
    theme.setTableOddRowBackgroundColor(0XFFFFFFFF)
    theme.setTableEvenRowBackgroundColor(0XFFFFFFFF)
    theme.setCodeFullScreenIcon($r('app.media.startIcon'))
    theme.setCodeCopyIcon($r('app.media.startIcon'))

    // 表格吸顶
    if (this.enableTableStickyHeader) {
      theme.getTableTheme().setTableStickyHeader(true)
    }

    // 表格复制按钮
    if (this.enableTableCopy) {
      theme.getTableTheme().setTableHeadIsShow(true)
      theme.getTableTheme().setTableHeadTitleText('表格')
      theme.getTableTheme().setTableHeadCopyIcon($r('app.media.startIcon'))
      theme.getTableTheme().setTableHeadCopyIconWidth(24)
      theme.getTableTheme().setTableHeadCopyIconHeight(24)
    }

    config.setMarkdownTheme(theme)
    return config
  }

  /**
   * MarkdownPlugin
   */
  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsImageStylePlugin(true)
    plugin.setIsImageSlidePlugin(true)
    plugin.setIsImageTextMixPlugin(true)
    plugin.setIsImageCollectPlugin(true)
    plugin.setIsTablePlugin(true)
    plugin.setIsLatexMathPlugin(true)
    plugin.setIsStrikethroughPlugin(true)
    plugin.setIsTaskListPlugin(true)
    plugin.setIsHtmlPlugin(true)
    plugin.setIsFootnotePlugin(true)
    plugin.setIsTocPlugin(true)
    plugin.setIsLinkifyPlugin(true)
    plugin.setIsDescListPlugin(true)
    plugin.setIsHeadIDPlugin(true)
    plugin.setIsSubPlugin(true)
    plugin.setIsSupPlugin(true)
    plugin.setIsEmojiPlugin(true, false)
    return plugin
  }

  /**
   * MarkdownScroller
   */
  setScroller(): MarkdownScroller {
    if (this.scroller === undefined) {
      this.scroller = new MarkdownScroller()
    }
    return this.scroller
  }

  /**
   * 获取全文复制文本
   */
  getAllText(): string {
    return this.nodeViewString.toString()
  }

  // ===== 回调方法 =====

  /**
   * 链接点击事件
   */
  linkCallback(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
    promptAction.showToast({
      message: url,
      duration: 2000
    })
  }

  /**
   * 图片点击事件
   */
  imageCallback(url: string, urlList: Array<string>): void {
    hilog.error(1, "1", `---url:${url},urlList:${urlList}`)
    promptAction.showToast({
      message: url,
      duration: 2000
    })
  }

  /**
   * 代码块复制点击事件
   */
  codeCopyCallback(code: string): void {
    hilog.error(1, "1", `---code:${code}`)
    promptAction.showToast({
      message: code,
      duration: 2000
    })
  }

  /**
   * 代码块全屏点击事件
   */
  codeFullScreenCallback(code: string, info: string | undefined): void {
    hilog.error(1, "1", `---code:${code},info:${info}`)
    promptAction.showToast({
      message: code,
      duration: 2000
    })
  }

  /**
   * 表格复制点击事件
   */
  tableCopyCallback(text: string): void {
    hilog.error(1, "1", `---tableText:${text}`)
    promptAction.showToast({
      message: text,
      duration: 2000
    })
  }

  /**
   * 长按段落回调
   */
  longPressCallback(text: string): void {
    hilog.error(1, "1", `---longPressText:${text}`)
    promptAction.showToast({
      message: text,
      duration: 2000
    })
  }

  /**
   * 元素曝光回调
   */
  exposureCallback(event: MarkdownExposureEvent): void {
    hilog.error(1, "1", `---exposure type:${event.eventType} visible:${event.visible} data:${event.data}`)
  }

  /**
   * 段落动画开始回调
   */
  paragraphAnimationStart(): void {
    hilog.error(1, "1", `---paragraphAnimationStart`)
  }

  /**
   * 段落动画结束回调
   */
  paragraphAnimationEnd(): void {
    hilog.error(1, "1", `---paragraphAnimationEnd`)
  }

  /**
   * 满足自定义块级图片的条件
   */
  blockImageCustomCheck(url: string): boolean {
    return true
  }

  /**
   * 满足自定义行内图片的条件
   */
  inLineImageCustomCheck(url: string): boolean {
    return true
  }

  /**
   * 满足自定义行内链接的条件
   */
  inLineLinkCustomCheck(url: string): boolean {
    return true
  }
}
