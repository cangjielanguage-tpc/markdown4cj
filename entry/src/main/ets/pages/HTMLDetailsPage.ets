/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import { HTMLData } from '../model/HTMLData'

@Entry
@Component
struct HTMLDetailsPage {
  /**
   * 滑动控制器
   */
  scroller: Scroller = new Scroller()
  /**
   * Markdown的控制器
   */
  markdownScroller: MarkdownScroller = new MarkdownScroller()
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop')
  safeTop: number = 0
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
   * 是否全量加载Markdown文本
   */
  @State
  isFull: boolean = true
  /**
   * 是否增量解析Markdown文本
   */
  @State
  incrementalAnalysis: boolean = false
  /**
   * 增量加载每次间隔时间
   */
  @State
  time: number = 50
  /**
   * 增量每次增量文本数量
   */
  @State
  textNumber: number = 10
  /**
   * 是否同步解析Markdown文本
   */
  @State
  isMarkdownParserSync: boolean = false
  /**
   * 是否开启打字机效果
   */
  @State
  typeWriterOpen: boolean = false
  /**
   * 打字机效果颜色
   */
  @State
  typeWriterColor: number | undefined = undefined
  /**
   * 是否打开长按复制粘贴效果
   */
  @State
  isOnCopy: boolean = false
  /**
   * Markdown文本第一个模块上边距
   */
  @State
  blockFirstTopMargin: number = 8
  /**
   * Markdown文本最后一个模块下边距
   */
  @State
  blockLastBottomMargin: number = 8
  /**
   * Markdown文本模块间上下间距
   */
  @State
  blockTopAndBottomMargins: number = 8
  /**
   * 是否允许markdown控件自身响应滑动
   */
  @State
  openGestureSwipe: boolean = false
  /**
   * 是否开启响应滑动测试
   */
  @State
  openGestureSwipeTest: boolean = false
  /**
   * 流式输入是否输入结束(true:结束输入,false:持续输入)
   */
  @State
  isInputEnded: boolean = false

  // ---------- 专有
  /**
   * 下划线颜色
   */
  @State
  underlineColor: number | undefined = undefined
  /**
   * 下划线样式
   */
  @State
  underlineStyle: TextDecorationStyle = TextDecorationStyle.SOLID

  aboutToAppear(): void {
    try {
      let htmlData: HTMLData = router.getParams() as HTMLData
      this.fileStr = getFileContextStr(htmlData._pagePath)
      // ---------- 通用
      this.isFull = htmlData._isFull
      this.incrementalAnalysis = htmlData._incrementalAnalysis
      this.time = htmlData._time
      this.textNumber = htmlData._textNumber
      this.isMarkdownParserSync = htmlData._isMarkdownParserSync
      this.typeWriterOpen = htmlData._typeWriterOpen
      this.typeWriterColor = htmlData._typeWriterColor
      this.isOnCopy = htmlData._isOnCopy
      this.blockFirstTopMargin = htmlData._blockFirstTopMargin
      this.blockLastBottomMargin = htmlData._blockLastBottomMargin
      this.blockTopAndBottomMargins = htmlData._blockTopAndBottomMargins
      this.openGestureSwipe = htmlData._openGestureSwipe
      this.openGestureSwipeTest = htmlData._openGestureSwipeTest
      // ---------- 专有
      this.underlineColor = htmlData._underlineColor
      this.underlineStyle = htmlData._underlineStyle
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "HTML测试用例",
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
        if (this.openGestureSwipeTest) { // 允许滑动响应测试，生效前提高度设置为100%
          Column() {
            CJMarkdown({
              content: this.content,
              isInputEnded: this.isInputEnded,
              incrementalAnalysis: this.incrementalAnalysis,
              listScroller: this.markdownScroller,
              config: this.setMarkdownConfig(),
              plugin: this.setPlugin()
            })
          }.height("100%")
        } else {
          Column() {
            CJMarkdown({
              content: this.content,
              isInputEnded: this.isInputEnded,
              incrementalAnalysis: this.incrementalAnalysis,
              listScroller: this.markdownScroller,
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
    if (this.underlineColor !== undefined) {
      theme.setUnderlineColor(this.underlineColor) // 下划线颜色
    }
    theme.setUnderlineStyle(this.underlineStyle) // 下划线样式
    theme.setCodeFullScreenIcon($r('app.media.startIcon'))
    theme.setCodeCopyIcon($r('app.media.startIcon'))
    theme.setIsMarkdownParserSync(this.isMarkdownParserSync) // markdown是否同步解析
    theme.setTypeWriterOpen(this.typeWriterOpen) // 是否开启打字机效果
    if (this.typeWriterColor !== undefined) {
      theme.setTypeWriterColor(this.typeWriterColor) // 打字机效果颜色
    }
    theme.setIsOnCopy(this.isOnCopy) // 是否打开长按复制粘贴
    theme.setBlockFirstTopMargin(this.blockFirstTopMargin) // markdown第一个模块上边距
    theme.setBlockLastBottomMargin(this.blockLastBottomMargin) // markdown最后一个模块下边距
    theme.setBlockTopAndBottomMargins(this.blockTopAndBottomMargins) // 模块间上下间距
    theme.setOpenGestureSwipe(this.openGestureSwipe) // 是否允许markdown控件自身响应滑动

    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsHtmlPlugin(true) // HTML插件
    plugin.setIsTablePlugin(true) // 表格插件
    return plugin
  }
}