/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
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
  mdStr: string = ""
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
  blockQuoteBackGroupColor: number = 0xFFFFFFFF
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
        .height(40)// 高度
        .width("80%")// 宽度
        .type(ButtonType.Capsule)// 圆角
        .margin({ top: 5, bottom: 5 })// 外边距
        .fontColor(0xFFFFFFFF)// 文本颜色
        .backgroundColor(0xFF317AFF)// 背景颜色
        .align(Alignment.Center)// 内容对齐方式
        .fontSize(16)// 字体大小
        .onClick(
          () => {
            // 点击动作触发该方法调用
            if (this.isFull) {
              this.mdStr = this.fileStr
            } else {
              let index = 0
              let id = setInterval(() => {
                this.mdStr = this.mdStr + this.fileStr[index]
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
          CJMarkdown({ mdStr: this.mdStr, isFull: this.isFull, cfg: this.setMarkdownConfig() })
        }
      }
      .padding({ bottom: 200 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    let theme = new MarkdownTheme()
    theme.setBlockQuoteLeftMargin(this.blockQuoteLeftMargin)
    theme.setBlockQuoteRightMargin(this.blockQuoteRightMargin)
    theme.setBlockQuoteWidth(this.blockQuoteWidth)
    theme.setBlockQuoteColor(this.blockQuoteColor)
    theme.setBlockQuoteBackGroupColor(this.blockQuoteBackGroupColor)
    theme.setBlockQuoteTopAndBottomMargins(this.blockQuoteTopAndBottomMargins)
    config.setMarkdownTheme(theme)
    return config
  }
}