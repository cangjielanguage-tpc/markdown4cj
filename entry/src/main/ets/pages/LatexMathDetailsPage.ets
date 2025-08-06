/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import {
  CJMarkdown,
  LatexMathColorFormat,
  MarkdownConfiguration,
  MarkdownPlugin,
  MarkdownTheme
} from '@cangjie-tpc/markdown'
import { getFileContextStr } from './FileUtils'
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
  mdStr: string = ""
  /**
   * 是否全量加载
   */
  @State
  isFull: boolean = true
  /**
   * 数学公式文本大小
   */
  @State
  latexMathTextSize: number = 16
  /**
   * 数学公式背景色
   */
  @State
  latexMathBackGroupColor: number = 0xFFFFFFFF
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
   * 增量加载延迟
   */
  time: number = 50

  aboutToAppear(): void {
    try {
      let latexMathData: LatexMathData = router.getParams() as LatexMathData
      this.fileStr = getFileContextStr(latexMathData._pagePath)
      this.isFull = latexMathData._isFull
      this.latexMathTextSize = latexMathData._latexMathTextSize
      this.latexMathBackGroupColor = latexMathData._latexMathBackGroupColor
      this.latexMathTextColor = latexMathData._latexMathTextColor
      this.latexMathBlockCenter = latexMathData._latexMathBlockCenter
      this.latexMathColorFormat = latexMathData._latexMathColorFormat
      this.latexMathResStr = latexMathData._latexMathResStr
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
          CJMarkdown({
            mdStr: this.mdStr,
            isFull: this.isFull,
            cfg: this.setMarkdownConfig(),
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
    config.setLatexImageCallback(this.latexCallBack)
    let theme = new MarkdownTheme()
    theme.setLatexMathTextSize(this.latexMathTextSize)
    theme.setLatexMathBackGroupColor(this.latexMathBackGroupColor)
    theme.setLatexMathTextColor(this.latexMathTextColor)
    theme.setLatexMathBlockCenter(this.latexMathBlockCenter)
    theme.setLatexMathColorFormat(this.latexMathColorFormat)
    theme.setLatexMathResStr(this.latexMathResStr)
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsLatexMathPlugin(true)
    return plugin
  }

  latexCallBack(data: ArrayBuffer, heightNumber: number, widthNumber: number): void {
    hilog.error(1, "1", `---data.size:${data.byteLength},heightNumber:${heightNumber},widthNumber:${widthNumber}`)
  }
}
