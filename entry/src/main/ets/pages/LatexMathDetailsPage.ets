/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import { LatexMathData } from '../model/LatexMathData'

@Entry
@Component
struct LatexMathDetailsPage {
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop')
  safeTop: number = 0
  @State
  fileStr: string = ""
  @State
  content: string = ""
  @State
  isFull: boolean = true
  @State
  incrementalAnalysis: boolean = false
  @State
  time: number = 50
  @State
  textNumber: number = 10
  @State
  isMarkdownParserSync: boolean = false
  @State
  isOnCopy: boolean = false
  @State
  blockFirstTopMargin: number = 8
  @State
  blockLastBottomMargin: number = 8
  @State
  blockTopAndBottomMargins: number = 8
  @State
  openGestureSwipe: boolean = false
  @State
  openGestureSwipeTest: boolean = false
  @State
  isInputEnded: boolean = false

  // ---------- 专有
  @State
  latexMathTextSize: number = 14
  @State
  latexMathTextColor: number | undefined = 0xFF000000
  @State
  latexMathBackgroundColor: number | undefined = 0x00000000
  @State
  latexMathColorFormat: number = 1
  @State
  latexMathBlockCenter: boolean = true
  @State
  latexMathDefaultText: boolean = true

  aboutToAppear(): void {
    try {
      let latexMathData: LatexMathData = router.getParams() as LatexMathData
      this.fileStr = getFileContextStr(latexMathData._pagePath)
      // ---------- 通用
      this.isFull = latexMathData._isFull
      this.incrementalAnalysis = latexMathData._incrementalAnalysis
      this.time = latexMathData._time
      this.textNumber = latexMathData._textNumber
      this.isMarkdownParserSync = latexMathData._isMarkdownParserSync
      this.isOnCopy = latexMathData._isOnCopy
      this.blockFirstTopMargin = latexMathData._blockFirstTopMargin
      this.blockLastBottomMargin = latexMathData._blockLastBottomMargin
      this.blockTopAndBottomMargins = latexMathData._blockTopAndBottomMargins
      this.openGestureSwipe = latexMathData._openGestureSwipe
      this.openGestureSwipeTest = latexMathData._openGestureSwipeTest
      // ---------- 专有
      this.latexMathTextSize = latexMathData._latexMathTextSize
      this.latexMathTextColor = latexMathData._latexMathTextColor
      this.latexMathBackgroundColor = latexMathData._latexMathBackgroundColor
      this.latexMathColorFormat = latexMathData._latexMathColorFormat
      this.latexMathBlockCenter = latexMathData._latexMathBlockCenter
      this.latexMathDefaultText = latexMathData._latexMathDefaultText
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "LatexMath测试用例",
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
              this.isInputEnded = true
              this.content = this.fileStr
            } else {
              this.isInputEnded = false
              let index = 0
              let id = setInterval(() => {
                this.content = this.content + this.fileStr[index]
                this.scroller.scrollEdge(Edge.Bottom)
                if (index === this.fileStr.length - 1) {
                  this.isInputEnded = true
                  clearInterval(id)
                }
                index++
              }, this.time)
            }
          }
        )
      Scroll(this.scroller) {
        if (this.openGestureSwipeTest) {
          Column() {
            CJMarkdown({
              content: this.content,
              config: this.setMarkdownConfig(),
              plugin: this.setPlugin()
            })
          }.height("100%")
        } else {
          Column() {
            CJMarkdown({
              content: this.content,
              config: this.setMarkdownConfig(),
              plugin: this.setPlugin()
            })
          }
        }
      }
      .align(Alignment.TopStart)
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    let theme = new MarkdownTheme()
    theme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    theme.setIsOnCopy(this.isOnCopy)
    theme.setBlockFirstTopMargin(this.blockFirstTopMargin)
    theme.setBlockLastBottomMargin(this.blockLastBottomMargin)
    theme.setBlockTopAndBottomMargins(this.blockTopAndBottomMargins)
    theme.setOpenGestureSwipe(this.openGestureSwipe)

    // ---------- 数学公式样式
    theme.latexMathTheme.setLatexMathTextSize(this.latexMathTextSize)
    if (this.latexMathTextColor !== undefined) {
      theme.latexMathTheme.setLatexMathTextColor(this.latexMathTextColor)
    }
    if (this.latexMathBackgroundColor !== undefined) {
      theme.latexMathTheme.setLatexMathBackgroundColor(this.latexMathBackgroundColor)
    }
    theme.latexMathTheme.setLatexMathColorFormat(this.latexMathColorFormat)
    theme.latexMathTheme.setLatexMathBlockCenter(this.latexMathBlockCenter)
    theme.latexMathTheme.setLatexMathDefaultText(this.latexMathDefaultText)

    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true)
    plugin.setIsTaskListPlugin(true)
    plugin.setIsHtmlPlugin(true)
    plugin.setIsLatexMathPlugin(true)
    return plugin
  }
}
