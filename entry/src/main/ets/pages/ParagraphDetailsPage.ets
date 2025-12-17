/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from './FileUtils'
import { ParagraphData } from './ParagraphPage'

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
   * 增量加载延迟
   */
  time: number = 50

  aboutToAppear(): void {
    try {
      let paragraphData: ParagraphData = router.getParams() as ParagraphData
      this.fileStr = getFileContextStr(paragraphData._pagePath)
      this.isFull = paragraphData._isFull
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
          CJMarkdown({
            content: this.content,
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
    theme.setParagraphTextSize(this.paragraphTextSize) // 段落文本大小
    theme.setParagraphTextColor(this.paragraphTextColor) // 段落文本颜色
    theme.setParagraphTextWordSpace(this.paragraphTextWordSpace) // 段落文本字间距
    theme.setParagraphTextLineHeight(this.paragraphTextLineHeight) // 段落文本行高
    theme.setParagraphTypeface(this.paragraphTypeface) // 段落文本字体
    theme.setParagraphTopMargins(this.paragraphTopMargins) // 段落模块上间距
    theme.setParagraphBottomMargins(this.paragraphBottomMargins) // 段落模块下间距
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    return plugin
  }
}