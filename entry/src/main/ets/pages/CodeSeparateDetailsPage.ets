/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from './FileUtils'
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
  mdStr: string = ""
  /**
   * 是否全量加载
   */
  @State
  isFull: boolean = true
  /**
   * 是否单独代码块显示
   */
  isSeparateCodeBlock: boolean = false
  /**
   * 单独代码块行号宽度
   */
  separateCodeBlockWidth: number = 50
  /**
   * 增量加载延迟
   */
  time: number = 50

  aboutToAppear(): void {
    try {
      let codeSeparateData: CodeSeparateData = router.getParams() as CodeSeparateData
      this.fileStr = getFileContextStr(codeSeparateData._pagePath)
      this.isFull = codeSeparateData._isFull
      this.isSeparateCodeBlock = codeSeparateData._isSeparateCodeBlock
      this.separateCodeBlockWidth = codeSeparateData._separateCodeBlockWidth
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
            // 点击动作触发该方法调用
            if (this.isFull) {
              this.mdStr = this.fileStr
            } else {
              let index = 0
              let id = setInterval(() => {
                this.mdStr = this.mdStr + this.fileStr[index]
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
          CJMarkdown({ mdStr: this.mdStr, cfg: this.setMarkdownConfig() })
        }
      }
      .padding({ bottom: 200 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    let theme = new MarkdownTheme()
    theme.setIsSeparateCodeBlock(this.isSeparateCodeBlock)
    theme.setSeparateCodeBlockWidth(this.separateCodeBlockWidth)
    theme.setCodeFullScreenIcon($r('app.media.startIcon'))
    theme.setCodeCopyIcon($r('app.media.startIcon'))
    config.setMarkdownTheme(theme)
    return config
  }
}