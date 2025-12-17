/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from './FileUtils'
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
   * 增量加载延迟
   */
  time: number = 50

  aboutToAppear(): void {
    try {
      let thematicData: ThematicData = router.getParams() as ThematicData
      this.fileStr = getFileContextStr(thematicData._pagePath)
      this.isFull = thematicData._isFull
      this.thematicBreakColor = thematicData._thematicBreakColor
      this.thematicBreakHeight = thematicData._thematicBreakHeight
      this.thematicBreakTopMargin = thematicData._thematicBreakTopMargin
      this.thematicBreakBottomMargin = thematicData._thematicBreakBottomMargin
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
              this.content = this.fileStr
            } else {
              let index = 0
              let id = setInterval(() => {
                this.content = this.content + this.fileStr[index]
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
          CJMarkdown({ content: this.content, config: this.setMarkdownConfig() })
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
    config.setMarkdownTheme(theme)
    return config
  }
}