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
  MarkdownTheme
} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import { LatexMathData } from './LatexMathPage'
import hilog from '@ohos.hilog'

@Entry
@Component
struct LatexMathDetailsPage {
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
   * 数学公式文本大小
   */
  @State
  latexMathTextSize: number = 16
  /**
   * 数学公式背景色
   */
  @State
  latexMathBackGroupColor: number = 0x00000000
  /**
   * 数学公式文本颜色
   */
  @State
  latexMathTextColor: number = 0xFF000000
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
      let latexMathData: LatexMathData = router.getParams() as LatexMathData
      this.fileStr = getFileContextStr(latexMathData._pagePath)
      this.isFull = latexMathData._isFull
      this.incrementalAnalysis = latexMathData._incrementalAnalysis
      this.time = latexMathData._time
      this.textNumber = latexMathData._textNumber
      this.latexMathTextSize = latexMathData._latexMathTextSize
      this.latexMathBackGroupColor = latexMathData._latexMathBackGroupColor
      this.latexMathTextColor = latexMathData._latexMathTextColor
      this.latexMathBlockCenter = latexMathData._latexMathBlockCenter
      this.latexMathColorFormat = latexMathData._latexMathColorFormat
      this.latexMathResStr = latexMathData._latexMathResStr
      this.latexDefaultText = latexMathData._latexDefaultText
      this.isMarkdownParserSync = latexMathData._isMarkdownParserSync
      this.isOnCopy = latexMathData._isOnCopy
      this.blockFirstTopMargin = latexMathData._blockFirstTopMargin
      this.blockLastBottomMargin = latexMathData._blockLastBottomMargin
      this.blockTopAndBottomMargins = latexMathData._blockTopAndBottomMargins
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
        Column() {
          CJMarkdown({
            content: this.content,
            isInputEnded: this.isInputEnded,
            incrementalAnalysis: this.incrementalAnalysis,
            config: this.setMarkdownConfig(),
            plugin: this.setPlugin()
          })
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
    theme.setLatexDefaultText(this.latexDefaultText) // 数学公式未加载状态是否显示文字
    theme.setLatexMathTextSize(this.latexMathTextSize) // 数学公式文本大小
    theme.setLatexMathBackGroupColor(this.latexMathBackGroupColor) // 数学公式背景色
    theme.setLatexMathTextColor(this.latexMathTextColor) // 数学公式文本颜色
    theme.setLatexMathColorFormat(this.latexMathColorFormat) // 数学公式生成图片格式
    theme.setLatexMathBlockCenter(this.latexMathBlockCenter) // 块结构的数学公式是否居中
    theme.setLatexMathResStr(this.latexMathResStr) // 数学公式字体路径
    theme.setIsMarkdownParserSync(this.isMarkdownParserSync) // markdown是否同步解析
    theme.setIsOnCopy(this.isOnCopy) // 是否打开长按复制粘贴
    theme.setBlockFirstTopMargin(this.blockFirstTopMargin) // markdown第一个模块上边距
    theme.setBlockLastBottomMargin(this.blockLastBottomMargin) // markdown最后一个模块下边距
    theme.setBlockTopAndBottomMargins(this.blockTopAndBottomMargins) // 模块间上下间距
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
