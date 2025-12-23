/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from './FileUtils'
import { ThematicData } from './ThematicPage'
import { QuoteData } from './QuotePage'

@Entry
@Component
struct QuoteDetailsPage {
  /**
   * 滑动控制器
   */
  scroller: Scroller = new Scroller()
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0
  /**
   * 文件文本
   */
  @State
  fileStr: string = ""
  /**
   * markdown文本
   */
  @State
  content: string = ""
  /**
   * 是否全量加载
   */
  @State
  isFull: boolean = true
  /**
   * 块引用左边距
   */
  blockQuoteLeftMargin: number = 8
  /**
   * 块引用右边距
   */
  blockQuoteRightMargin: number = 8
  /**
   * 块引用左边线条宽度
   */
  blockQuoteWidth: number = 1
  /**
   * 块引用左边线条颜色
   */
  blockQuoteColor: number = 0xFF191919
  /**
   * 块引用背景颜色
   */
  blockQuoteBackGroupColor: number = 0xFFE0E0E0
  /**
   * 块引用子模块上下间距
   */
  blockQuoteTopAndBottomMargins: number = 0
  /**
   * 增量加载延迟
   */
  time: number = 50

  aboutToAppear(): void {
    try {
      let quoteData: QuoteData = router.getParams() as QuoteData
      this.fileStr = getFileContextStr(quoteData._pagePath)
      this.isFull = quoteData._isFull
      this.blockQuoteLeftMargin = quoteData._blockQuoteLeftMargin
      this.blockQuoteRightMargin = quoteData._blockQuoteRightMargin
      this.blockQuoteWidth = quoteData._blockQuoteWidth
      this.blockQuoteColor = quoteData._blockQuoteColor
      this.blockQuoteBackGroupColor = quoteData._blockQuoteBackGroupColor
      this.blockQuoteTopAndBottomMargins = quoteData._blockQuoteTopAndBottomMargins
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "块引用测试用例",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Button("点击加载markdown")
        .height(40)
        .width("80%")
        .type(ButtonType.Capsule)
        .margin({ top: 5, bottom: 5 })
        .fontColor(0xFFFFFFFF)
        .backgroundColor(0xFF317AFF)
        .align(Alignment.Center)
        .fontSize(16)
        .onClick(
          () => {
            if (this.isFull) {
              this.content = this.fileStr
            } else {
              let index = 0
              let id = setInterval(() => {
                this.content = this.content + this.fileStr[index]
                this.scroller.scrollEdge(Edge.Bottom)
                if (index === this.fileStr.length - 1) {
                  clearInterval(id)
                }
                index++
              }, this.time)
            }
          }
        )
      Scroll(this.scroller) {
        Column() {
          CJMarkdown({
            content: this.content,
            config: this.setMarkdownConfig(),
            plugin: this.setPlugin()
          })
        }
      }
      .padding({ bottom: 200 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    let theme = new MarkdownTheme()
    theme.setBlockQuoteLeftMargin(this.blockQuoteLeftMargin) // 块引用左边距
    theme.setBlockQuoteRightMargin(this.blockQuoteRightMargin) // 块引用右边距
    theme.setBlockQuoteWidth(this.blockQuoteWidth) // 块引用左边线条宽度
    theme.setBlockQuoteColor(this.blockQuoteColor) // 块引用左边线条颜色
    theme.setBlockQuoteBackGroupColor(this.blockQuoteBackGroupColor) // 块引用背景颜色
    theme.setBlockQuoteTopAndBottomMargins(this.blockQuoteTopAndBottomMargins) // 块引用子模块上下间距
    theme.setCodeFullScreenIcon($r('app.media.startIcon')) // 代码块全屏图片icon
    theme.setCodeCopyIcon($r('app.media.startIcon')) // 代码块复制图片icon
    theme.setAudioIcon($r('app.media.startIcon')) // 音频图片icon
    theme.setVideoImage($r('app.media.place_holder')) // 视频默认占位图
    theme.setPlayCircleFillIcon($r('app.media.play_circle_fill')) // 视频播放按钮icon
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsLatexMathPlugin(true) // 数学公式插件
    plugin.setIsHtmlPlugin(true) // HTML插件
    plugin.setIsBlockAudioPlugin(true) // 音频插件
    plugin.setIsBlockVideoPlugin(true) // 视频插件
    plugin.setIsCodeListPlugin(true) // 组合代码快列表插件
    plugin.setIsImageSlidePlugin(true) // 图片幻灯片（Banner）插件
    return plugin
  }
}