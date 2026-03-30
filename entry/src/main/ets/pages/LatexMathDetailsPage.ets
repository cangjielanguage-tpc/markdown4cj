/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import {
  CJMarkdown,
  LatexMathColorFormat,
  MarkdownConfiguration,
  MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme
} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { LatexMathData } from '../model/LatexMathData'

@Entry
@Component
struct LatexMathDetailsPage {
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
   * 数学公式文本大小
   */
  @State
  latexMathTextSize: number = 16
  /**
   * 数学公式背景色
   */
  @State
  latexMathBackGroupColor: number | undefined = undefined
  /**
   * 数学公式文本颜色
   */
  @State
  latexMathTextColor: number | undefined = undefined
  /**
   * 块结构的数学公式是否居中
   */
  @State
  latexMathBlockCenter: boolean = false
  /**
   * 数学公式生成图片格式
   */
  @State
  latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
  /**
   * 数学公式字体路径
   */
  @State
  latexMathResStr: string = "/data/storage/el1/bundle/entry/resources/resfile/res"
  /**
   * 数学公式未加载状态是否显示文字
   */
  latexDefaultText: boolean = true

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
      this.latexMathBackGroupColor = latexMathData._latexMathBackGroupColor
      this.latexMathTextColor = latexMathData._latexMathTextColor
      this.latexMathBlockCenter = latexMathData._latexMathBlockCenter
      this.latexMathColorFormat = latexMathData._latexMathColorFormat
      this.latexMathResStr = latexMathData._latexMathResStr
      this.latexDefaultText = latexMathData._latexDefaultText
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "数学公式测试用例",
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
    config.setLatexImageCallback(this.latexCallBack.bind(this)) // 数学公式点击回调
    let theme = new MarkdownTheme()
    theme.setContext(getContext(this)) // 上下文

    theme.setIsMarkdownParserSync(this.isMarkdownParserSync) // markdown是否同步解析
    theme.setIsOnCopy(this.isOnCopy) // 是否打开长按复制粘贴
    theme.setBlockFirstTopMargin(this.blockFirstTopMargin) // markdown第一个模块上边距
    theme.setBlockLastBottomMargin(this.blockLastBottomMargin) // markdown最后一个模块下边距
    theme.setBlockTopAndBottomMargins(this.blockTopAndBottomMargins) // 模块间上下间距

    theme.setLatexDefaultText(this.latexDefaultText) // 数学公式未加载状态是否显示文字
    theme.setLatexMathTextSize(this.latexMathTextSize) // 数学公式文本大小
    if (this.latexMathBackGroupColor !== undefined) {
      theme.setLatexMathBackGroupColor(this.latexMathBackGroupColor) // 数学公式背景色
    }
    if (this.latexMathTextColor !== undefined) {
      theme.setLatexMathTextColor(this.latexMathTextColor) // 数学公式文本颜色
    }
    theme.setLatexMathColorFormat(this.latexMathColorFormat) // 数学公式生成图片格式
    theme.setLatexMathBlockCenter(this.latexMathBlockCenter) // 块结构的数学公式是否居中
    theme.setLatexMathResStr(this.latexMathResStr) // 数学公式字体路径
    theme.setOpenGestureSwipe(this.openGestureSwipe) // 是否允许markdown控件自身响应滑动

    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsLatexMathPlugin(true) // 数学公式插件
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsDescListPlugin(true) // 定义列表插件
    return plugin
  }

  latexCallBack(data: ArrayBuffer, heightNumber: number, widthNumber: number): void {
    hilog.error(1, "1", `---data.size:${data.byteLength},heightNumber:${heightNumber},widthNumber:${widthNumber}`)
  }
}
