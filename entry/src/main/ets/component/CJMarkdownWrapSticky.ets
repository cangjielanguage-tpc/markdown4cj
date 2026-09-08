/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
import {
  CJMarkdown,
  MarkdownConfiguration,
  MarkdownPlugin,
  MarkdownScroller,
  MarkdownScrollController,
  MarkdownTheme
} from '@cangjie-tpc/markdown_hybrid'
import hilog from '@ohos.hilog'
import { promptAction } from '@kit.ArkUI'

/**
 * AI聊天表格吸顶 - Markdown包装组件
 *
 * 外层List将滚动Y通过 MarkdownScrollController 分发给每条消息内的MarkdownComponent，
 * 配合 tableStickyHeader 实现表格首行吸顶（非固定高度模式）。
 */
@Component
export struct CJMarkdownWrapSticky {
  @Prop
  input: string
  @State
  incrementalAnalysis: boolean = false
  /**
   * 外层滚动控制器（表格吸顶）
   */
  scrollController?: MarkdownScrollController = undefined
  /**
   * 是否启用表格首行吸顶
   */
  tableStickyHeader: boolean = false
  /**
   * Markdown的控制器
   */
  markdownScroller: MarkdownScroller = new MarkdownScroller()

  build() {
    CJMarkdown({
      content: this.input,
      config: this.setConfiguration(),
      plugin: this.setPlugin(),
      listScroller: this.markdownScroller,
      incrementalAnalysis: this.incrementalAnalysis
    })
  }

  setConfiguration(): MarkdownConfiguration {
    let config: MarkdownConfiguration = new MarkdownConfiguration()
    config.setLinkCallback(this.linkCallback.bind(this))
    config.setImageCallback(this.imageCallback.bind(this))
    config.setCodeCopyCallback(this.codeCopyCallback.bind(this))
    config.setCodeFullScreenCallback(this.codeFullScreenCallback.bind(this))
    let theme: MarkdownTheme = new MarkdownTheme()
    theme.setImageMaximumWidth(1)
    theme.setIsOnCopy(false)
    theme.setIsMarkdownParserSync(true)
    theme.setIsCodeBlockParserSync(true)
    theme.setImageFitType(1)
    theme.setTableOddRowBackgroundColor(0XFFFFFFFF)
    theme.setTableEvenRowBackgroundColor(0XFFFFFFFF)
    // 表格吸顶
    if (this.tableStickyHeader) {
      theme.getTableTheme().setTableStickyHeader(true)
    }
    theme.setCodeFullScreenIcon($r('app.media.startIcon'))
    theme.setCodeCopyIcon($r('app.media.startIcon'))
    config.setMarkdownTheme(theme)
    // 外层滚动控制器（表格吸顶-非固定高度模式）
    if (this.scrollController !== undefined) {
      config.setScrollController(this.scrollController)
    }
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsImageStylePlugin(true)
    plugin.setIsImageSlidePlugin(true)
    plugin.setIsImageTextMixPlugin(true)
    plugin.setIsImageCollectPlugin(true)
    plugin.setIsTablePlugin(true)
    plugin.setIsStrikethroughPlugin(true)
    plugin.setIsTaskListPlugin(true)
    plugin.setIsHtmlPlugin(true)
    plugin.setIsFootnotePlugin(true)
    plugin.setIsTocPlugin(true)
    plugin.setIsLinkifyPlugin(true, [])
    plugin.setIsDescListPlugin(true)
    plugin.setIsHeadIDPlugin(true)
    plugin.setIsSubPlugin(true)
    plugin.setIsSupPlugin(true)
    plugin.setIsEmojiPlugin(true, false)
    return plugin
  }

  linkCallback(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
    promptAction.showToast({ message: url, duration: 2000 })
  }

  imageCallback(url: string, urlList: Array<string>): void {
    hilog.error(1, "1", `---url:${url},urlList:${urlList}`)
    promptAction.showToast({ message: url, duration: 2000 })
  }

  codeCopyCallback(code: string): void {
    hilog.error(1, "1", `---code:${code}`)
    promptAction.showToast({ message: code, duration: 2000 })
  }

  codeFullScreenCallback(code: string, info: string | undefined): void {
    hilog.error(1, "1", `---code:${code},info:${info}`)
    promptAction.showToast({ message: code, duration: 2000 })
  }
}
