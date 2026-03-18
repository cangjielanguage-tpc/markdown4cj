/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import { ThematicData } from './ThematicPage'

@Entry
@Component
struct ThematicDetailsPage {
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
   * 分割线颜色
   */
  @State
  thematicBreakColor: number = 0xFF000000
  /**
   * 分割线高度
   */
  @State
  thematicBreakHeight: number = 0.5
  /**
   * 分割线上部外边距
   */
  @State
  thematicBreakTopMargin: number = 0.0
  /**
   * 分割线下部外边距
   */
  @State
  thematicBreakBottomMargin: number = 0.0
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
  blockFirstTopMargin: number = 8.0
  /**
   * markdown最后一个模块下边距
   */
  @State
  blockLastBottomMargin: number = 8.0
  /**
   * 模块间上下间距
   */
  @State
  blockTopAndBottomMargins: number = 8.0

  aboutToAppear(): void {
    try {
      let thematicData: ThematicData = router.getParams() as ThematicData
      this.fileStr = getFileContextStr(thematicData._pagePath)
      this.isFull = thematicData._isFull
      this.incrementalAnalysis = thematicData._incrementalAnalysis
      this.time = thematicData._time
      this.textNumber = thematicData._textNumber
      this.thematicBreakColor = thematicData._thematicBreakColor
      this.thematicBreakHeight = thematicData._thematicBreakHeight
      this.thematicBreakTopMargin = thematicData._thematicBreakTopMargin
      this.thematicBreakBottomMargin = thematicData._thematicBreakBottomMargin
      this.isMarkdownParserSync = thematicData._isMarkdownParserSync
      this.isOnCopy = thematicData._isOnCopy
      this.blockFirstTopMargin = thematicData._blockFirstTopMargin
      this.blockLastBottomMargin = thematicData._blockLastBottomMargin
      this.blockTopAndBottomMargins = thematicData._blockTopAndBottomMargins
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "分割线测试用例",
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
            config: this.setMarkdownConfig()
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
    theme.setThematicBreakColor(this.thematicBreakColor) // 分割线颜色
    theme.setThematicBreakHeight(this.thematicBreakHeight) // 分割线高度
    theme.setThematicBreakTopMargin(this.thematicBreakTopMargin) // 分割线上部外边距
    theme.setThematicBreakBottomMargin(this.thematicBreakBottomMargin) // 分割线下部外边距
    theme.setIsMarkdownParserSync(this.isMarkdownParserSync) // markdown是否同步解析
    theme.setIsOnCopy(this.isOnCopy) // 是否打开长按复制粘贴
    theme.setBlockFirstTopMargin(this.blockFirstTopMargin) // markdown第一个模块上边距
    theme.setBlockLastBottomMargin(this.blockLastBottomMargin) // markdown最后一个模块下边距
    theme.setBlockTopAndBottomMargins(this.blockTopAndBottomMargins) // 模块间上下间距
    config.setMarkdownTheme(theme)
    return config
  }
}