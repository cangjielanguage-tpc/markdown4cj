/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
import {
  CJMarkdown,
  MarkdownConfiguration,
  MarkdownPlugin,
  MarkdownTheme,
  MarkdownScroller
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
   * Markdown的控制器
   */
  @State
  scroller?: MarkdownScroller = undefined

  build() {
    CJMarkdown({
      content: this.input,
      config: this.setConfiguration(),
      plugin: this.setPlugin(),
      listScroller: this.setScroller()
    })
    .constraintSize({ maxHeight: '120%' })
    .width("75%")
  }

  /**
   * MarkdownConfiguration
   */
  setConfiguration(): MarkdownConfiguration {
    let config: MarkdownConfiguration = new MarkdownConfiguration()
    config.setLinkCallback(this.linkCallback.bind(this)) // 链接点击回调
    config.setImageCallback(this.imageCallback.bind(this)) // 图片点击回调
    config.setCodeCopyCallback(this.codeCopyCallback.bind(this)) // 代码复制点击回调
    config.setCodeFullScreenCallback(this.codeFullScreenCallback.bind(this)) // 代码全屏点击回调
    let theme: MarkdownTheme = new MarkdownTheme()
    theme.setImageMaximumWidth(1) // 图片基于自身宽度缩放百分比
    theme.setIsOnCopy(false) // 是否打开长按复制粘贴
    theme.setIsMarkdownParserSync(true) // markdown是否同步解析
    theme.setImageFitType(1) // 图片缩放类型
    theme.setTableOddRowBackgroundColor(0XFFFFFFFF) // 表格奇数行背景色
    theme.setTableEvenRowBackgroundColor(0XFFFFFFFF) // 表格偶数行背景色
    theme.setCodeFullScreenIcon($r('app.media.startIcon')) // 代码块全屏图片icon
    theme.setCodeCopyIcon($r('app.media.startIcon')) // 代码块复制图片icon
    config.setMarkdownTheme(theme) // markdown样式
    return config
  }

  /**
   * MarkdownPlugin
   */
  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsImageStylePlugin(true) // 图片样式插件
    plugin.setIsImageSlidePlugin(true) // 图片幻灯片（Banner）插件
    plugin.setIsImageTextMixPlugin(true) // 图片不混排插件
    plugin.setIsImageCollectPlugin(true) // 图片视频url集合列表插件
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsLatexMathPlugin(true) // 数学公式插件
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsHtmlPlugin(true) // HTML插件
    plugin.setIsFootnotePlugin(true) // 脚注插件
    plugin.setIsTocPlugin(true) // TOC插件
    plugin.setIsLinkifyPlugin(true, []) // 链接自动加载插件
    plugin.setIsDescListPlugin(true) // 定义列表解析插件
    plugin.setIsHeadIDPlugin(true) // 标题ID解析插件
    plugin.setIsSubPlugin(true) // 下标解析插件
    plugin.setIsSupPlugin(true) // 上标解析插件
    plugin.setIsEmojiPlugin(true, false) // emoji解析插件
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
   * 图片代码块复制点击事件
   */
  codeCopyCallback(code: string): void {
    hilog.error(1, "1", `---code:${code}`)
    promptAction.showToast({
      message: code,
      duration: 2000
    })
  }

  /**
   * 图片代码块全屏点击事件
   */
  codeFullScreenCallback(code: string, info: string | undefined): void {
    hilog.error(1, "1", `---code:${code},info:${info}`)
    promptAction.showToast({
      message: code,
      duration: 2000
    })
  }
}
