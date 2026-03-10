/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import { CodeLineData } from './CodeLinePage'

@Entry
@Component
struct CodeLineDetailsPage {
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
  /**
   * 流式输入是否输入结束(true:结束输入,false:持续输入)
   */
  @State
  isInputEnded: boolean = false

  aboutToAppear(): void {
    try {
      let codeLineData: CodeLineData = router.getParams() as CodeLineData
      this.fileStr = getFileContextStr(codeLineData._pagePath)
      this.isFull = codeLineData._isFull
      this.incrementalAnalysis = codeLineData._incrementalAnalysis
      this.time = codeLineData._time
      this.textNumber = codeLineData._textNumber
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
      .padding({ bottom: 200 })
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
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true)
    return plugin
  }
}