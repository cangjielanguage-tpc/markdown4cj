/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import { CodeSeparateData } from './CodeSeparatePage'

@Entry
@Component
struct CodeSeparateDetailsPage {
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
   * markdown是否增量解析(true:增量解析,false:全量解析)
   */
  @State
  incrementalAnalysis: boolean = false
  /**
   * 增量加载每次间隔时间 - 毫秒
   */
  @State
  time: number = 50
  /**
   * 增量每次增量文本数量
   */
  @State
  textNumber: number = 10
  /**
   * 是否单独代码块显示
   */
  isSeparateCodeBlock: boolean = false
  /**
   * 单独代码块行号宽度
   */
  separateCodeBlockWidth: number = 50
  /**
   * 是否滑动到底部
   */
  separateCodeIsBottom: boolean = false
  /**
   * 流式输入是否输入结束(true:结束输入,false:持续输入)
   */
  @State
  isInputEnded: boolean = false
  /**
   * markdown是否同步解析
   */
  @State
  isMarkdownParserSync: boolean = false
  /**
   * 是否打开长按复制粘贴
   */
  @State
  isOnCopy: boolean = false
  /**
   * markdown第一个模块上边距
   */
  @State
  blockFirstTopMargin: number = 8
  /**
   * markdown最后一个模块下边距
   */
  @State
  blockLastBottomMargin: number = 8
  /**
   * 模块间上下间距
   */
  @State
  blockTopAndBottomMargins: number = 8

  aboutToAppear(): void {
    try {
      let codeSeparateData: CodeSeparateData = router.getParams() as CodeSeparateData
      this.fileStr = getFileContextStr(codeSeparateData._pagePath)
      this.isFull = codeSeparateData._isFull
      this.incrementalAnalysis = codeSeparateData._incrementalAnalysis
      this.time = codeSeparateData._time
      this.textNumber = codeSeparateData._textNumber
      this.isSeparateCodeBlock = codeSeparateData._isSeparateCodeBlock
      this.separateCodeBlockWidth = codeSeparateData._separateCodeBlockWidth
      this.separateCodeIsBottom = codeSeparateData._separateCodeIsBottom
      this.isMarkdownParserSync = codeSeparateData._isMarkdownParserSync
      this.isOnCopy = codeSeparateData._isOnCopy
      this.blockFirstTopMargin = codeSeparateData._blockFirstTopMargin
      this.blockLastBottomMargin = codeSeparateData._blockLastBottomMargin
      this.blockTopAndBottomMargins = codeSeparateData._blockTopAndBottomMargins
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "单独代码块测试用例",
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
            if (this.isFull) {
              this.isInputEnded = true
              this.content = this.fileStr
            } else {
              this.isInputEnded = false
              let index = 0
              let id = setInterval(() => {
                this.content = this.content + this.fileStr.substring(this.content.length, index)
                this.scroller.scrollEdge(Edge.Bottom)
                if (index >= this.fileStr.length) {
                  this.isInputEnded = true
                  clearInterval(id)
                }
                if (this.fileStr.length > index + this.textNumber) {
                  index = index + this.textNumber
                } else {
                  index = this.fileStr.length
                }
              }, this.time)
            }
          }
        )
      Scroll(this.scroller) {
        Column() {
          CJMarkdown({
            content: this.content,
            isInputEnded: this.isInputEnded,
            incrementalAnalysis: this.incrementalAnalysis,
            config: this.setMarkdownConfig()
          })
        }
      }
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    let theme = new MarkdownTheme()
    theme.setIsSeparateCodeBlock(this.isSeparateCodeBlock) // 是否单独代码块显示
    theme.setSeparateCodeBlockWidth(this.separateCodeBlockWidth) // 单独代码块行号宽度
    theme.setCodeFullScreenIcon($r('app.media.startIcon')) // 代码块全屏图片icon
    theme.setCodeCopyIcon($r('app.media.startIcon')) // 代码块复制图片icon
    theme.setSeparateCodeIsBottom(this.separateCodeIsBottom) // 单独代码块是否居底显示
    theme.setIsMarkdownParserSync(this.isMarkdownParserSync) // markdown是否同步解析
    theme.setIsOnCopy(this.isOnCopy) // 是否打开长按复制粘贴
    theme.setBlockFirstTopMargin(this.blockFirstTopMargin) // markdown第一个模块上边距
    theme.setBlockLastBottomMargin(this.blockLastBottomMargin) // markdown最后一个模块下边距
    theme.setBlockTopAndBottomMargins(this.blockTopAndBottomMargins) // 模块间上下间距
    config.setMarkdownTheme(theme)
    return config
  }
}