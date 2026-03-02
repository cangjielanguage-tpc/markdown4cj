/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from './FileUtils'
import { ParagraphData } from './ParagraphPage'
import hilog from '@ohos.hilog'

@Entry
@Component
struct ParagraphDetailsPage {
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
   * 段落文本大小
   */
  @State
  paragraphTextSize: number = 14
  /**
   * 段落文本颜色
   */
  @State
  paragraphTextColor: number = 0xFF000000
  /**
   * 段落文本字间距
   */
  @State
  paragraphTextWordSpace: number = 0.0
  /**
   * 段落文本行高
   */
  @State
  paragraphTextLineHeight: number = 22.0
  /**
   * 段落文本字体
   */
  @State
  paragraphTypeface: string = "HarmonyOS Sans"
  /**
   * 段落模块上间距
   */
  @State
  paragraphTopMargins: number = 8
  /**
   * 段落模块下间距
   */
  @State
  paragraphBottomMargins: number = 8
  /**
   * 流式输入是否输入结束(true:结束输入,false:持续输入)
   */
  @State
  isInputEnded: boolean = false

  aboutToAppear(): void {
    try {
      let paragraphData: ParagraphData = router.getParams() as ParagraphData
      this.fileStr = getFileContextStr(paragraphData._pagePath)
      this.isFull = paragraphData._isFull
      this.incrementalAnalysis = paragraphData._incrementalAnalysis
      this.time = paragraphData._time
      this.textNumber = paragraphData._textNumber
      this.paragraphTextSize = paragraphData._paragraphTextSize
      this.paragraphTextColor = paragraphData._paragraphTextColor
      this.paragraphTextWordSpace = paragraphData._paragraphTextWordSpace
      this.paragraphTextLineHeight = paragraphData._paragraphTextLineHeight
      this.paragraphTypeface = paragraphData._paragraphTypeface
      this.paragraphTopMargins = paragraphData._paragraphTopMargins
      this.paragraphBottomMargins = paragraphData._paragraphBottomMargins
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "段落测试用例",
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
      .padding({ bottom: 200 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    let theme = new MarkdownTheme()
    theme.setContext(getContext(this)) // 上下文
    theme.setParagraphTopMargins(this.paragraphTopMargins) // 段落模块上间距
    theme.setParagraphBottomMargins(this.paragraphBottomMargins) // 段落模块下间距
    theme.setParagraphTextSize(this.paragraphTextSize) // 段落文本大小
    theme.setParagraphTextColor(this.paragraphTextColor) // 段落文本颜色
    theme.setParagraphTextWordSpace(this.paragraphTextWordSpace) // 段落文本字间距
    theme.setParagraphTextLineHeight(this.paragraphTextLineHeight) // 段落文本行高
    theme.setParagraphTypeface(this.paragraphTypeface) // 段落文本字体
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    return plugin
  }
}