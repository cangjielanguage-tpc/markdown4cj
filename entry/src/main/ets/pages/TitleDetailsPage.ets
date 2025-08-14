/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { TitleData } from './TitlePage'
import { CJMarkdown, MarkdownConfiguration, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from './FileUtils'

@Entry
@Component
struct TitleDetailsPage {
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
   * H1、H2下划线高度
   */
  @State
  headingBreakHeight: number = 1
  /**
   * H1、H2下划线颜色
   */
  @State
  headingBreakColor: number = 0xFF000000
  /**
   * 标题文本颜色
   */
  @State
  headingTextColor: number = 0xFF000000
  /**
   * 标题文本字间距
   */
  @State
  headingTextWordSpace: number = 0
  /**
   * 一级标题行高
   */
  @State
  headingTextLineHeight1: number = 22
  /**
   * 二级标题行高
   */
  @State
  headingTextLineHeight2: number = 22
  /**
   * 三级标题行高
   */
  @State
  headingTextLineHeight3: number = 22
  /**
   * 四级标题行高
   */
  @State
  headingTextLineHeight4: number = 22
  /**
   * 五级标题行高
   */
  @State
  headingTextLineHeight5: number = 22
  /**
   * 六级标题行高
   */
  @State
  headingTextLineHeight6: number = 22
  /**
   * 标题文本大小数组
   */
  @State
  headingTextSizeMultipliers: Array<number> = [20, 17, 16, 15, 15, 13]
  /**
   * 标题文本字体
   */
  @State
  headingTypeface: string = "HarmonyOS Sans"
  /**
   * 增量加载延迟
   */
  time: number = 50

  aboutToAppear(): void {
    try {
      let titleData: TitleData = router.getParams() as TitleData
      this.fileStr = getFileContextStr(titleData._pagePath)
      this.isFull = titleData._isFull
      this.headingBreakHeight = titleData._headingBreakHeight
      this.headingBreakColor = titleData._headingBreakColor
      this.headingTextColor = titleData._headingTextColor
      this.headingTextWordSpace = titleData._headingTextWordSpace
      this.headingTextLineHeight1 = titleData._headingTextLineHeight1
      this.headingTextLineHeight2 = titleData._headingTextLineHeight2
      this.headingTextLineHeight3 = titleData._headingTextLineHeight3
      this.headingTextLineHeight4 = titleData._headingTextLineHeight4
      this.headingTextLineHeight5 = titleData._headingTextLineHeight5
      this.headingTextLineHeight6 = titleData._headingTextLineHeight6
      this.headingTextSizeMultipliers = titleData._headingTextSizeMultipliers
      this.headingTypeface = titleData._headingTypeface
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "标题测试用例",
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
          CJMarkdown({ mdStr: this.mdStr, isFull: this.isFull, cfg: this.setMarkdownConfig() })
        }
      }
      .padding({ bottom: 200 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    let theme = new MarkdownTheme()
    theme.setHeadingBreakHeight(this.headingBreakHeight)
    theme.setHeadingBreakColor(this.headingBreakColor)
    theme.setHeadingTextColor(this.headingTextColor)
    theme.setHeadingTextWordSpace(this.headingTextWordSpace)
    theme.setHeadingTextLineHeight1(this.headingTextLineHeight1)
    theme.setHeadingTextLineHeight2(this.headingTextLineHeight2)
    theme.setHeadingTextLineHeight3(this.headingTextLineHeight3)
    theme.setHeadingTextLineHeight4(this.headingTextLineHeight4)
    theme.setHeadingTextLineHeight5(this.headingTextLineHeight5)
    theme.setHeadingTextLineHeight6(this.headingTextLineHeight6)
    theme.setHeadingTypeface(this.headingTypeface)
    theme.setHeadingTextSizeMultipliers(this.headingTextSizeMultipliers)
    config.setMarkdownTheme(theme)
    return config
  }
}