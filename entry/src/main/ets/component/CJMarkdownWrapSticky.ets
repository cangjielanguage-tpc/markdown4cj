/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
import {
  CJMarkdown,
  MarkdownConfiguration,
  MarkdownPlugin,
  MarkdownScrollController,
  MarkdownTheme
} from '@cangjie-tpc/markdown_hybrid'
import hilog from '@ohos.hilog'
import { promptAction } from '@kit.ArkUI'

@Component
export struct CJMarkdownWrapSticky {
  @Prop
  input: string
  @State
  incrementalAnalysis: boolean = false
  scrollController?: MarkdownScrollController = undefined
  tableStickyHeader: boolean = false
  markdownScroller: Scroller = new Scroller()

  build() {
    CJMarkdown({
      content: this.input,
      config: this.setConfiguration(),
      plugin: this.setPlugin(),
      scrollController: this.scrollController,
      scroller: this.markdownScroller
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
    theme.tableTheme.setTableStickyHeader(this.tableStickyHeader)
    theme.setCodeFullScreenIcon($r('app.media.startIcon'))
    theme.setCodeCopyIcon($r('app.media.startIcon'))
    config.setMarkdownTheme(theme)
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
