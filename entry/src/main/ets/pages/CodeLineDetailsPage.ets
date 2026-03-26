/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import { CodeLineData } from '../model/CodeLineData'

@Entry
@Component
struct CodeLineDetailsPage {
  // ---------- 通用
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
  typeWriterColor: number = 0xFFFF0000
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
   * 内联代码文本颜色
   */
  codeTextColor: number = 0xFF000000
  /**
   * 内联代码背景颜色
   */
  codeBackgroundColor: number = 0xFFE0E0E0
  /**
   * 内联代码文本大小
   */
  codeTextSize: number = 13
  /**
   * 内联代码文本字体
   */
  codeTypeface: string = "HarmonyOS Sans"

  aboutToAppear(): void {
    try {
      let codeLineData: CodeLineData = router.getParams() as CodeLineData
      this.fileStr = getFileContextStr(codeLineData._pagePath)
      // ---------- 通用
      this.isFull = codeLineData._isFull
      this.incrementalAnalysis = codeLineData._incrementalAnalysis
      this.time = codeLineData._time
      this.textNumber = codeLineData._textNumber
      this.isMarkdownParserSync = codeLineData._isMarkdownParserSync
      this.typeWriterOpen = codeLineData._typeWriterOpen
      this.typeWriterColor = codeLineData._typeWriterColor
      this.isOnCopy = codeLineData._isOnCopy
      this.blockFirstTopMargin = codeLineData._blockFirstTopMargin
      this.blockLastBottomMargin = codeLineData._blockLastBottomMargin
      this.blockTopAndBottomMargins = codeLineData._blockTopAndBottomMargins
      this.openGestureSwipe = codeLineData._openGestureSwipe
      this.openGestureSwipeTest = codeLineData._openGestureSwipeTest
      // ---------- 专有
      this.codeTextColor = codeLineData._codeTextColor
      this.codeBackgroundColor = codeLineData._codeBackgroundColor
      this.codeTextSize = codeLineData._codeTextSize
      this.codeTypeface = codeLineData._codeTypeface
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "内联代码测试用例",
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
    theme.setCodeTextColor(this.codeTextColor)
    theme.setCodeBackgroundColor(this.codeBackgroundColor)
    theme.setCodeTextSize(this.codeTextSize)
    theme.setCodeTypeface(this.codeTypeface)
    theme.setIsMarkdownParserSync(this.isMarkdownParserSync) // markdown是否同步解析
    theme.setTypeWriterOpen(this.typeWriterOpen) // 是否开启打字机效果
    theme.setTypeWriterColor(this.typeWriterColor) // 打字机效果颜色
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
    plugin.setIsTablePlugin(true)
    return plugin
  }
}