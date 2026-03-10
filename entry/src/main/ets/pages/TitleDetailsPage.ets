/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { TitleData } from './TitlePage'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'

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
   * 标题模块上间距
   */
  @State
  headingTopMargins: number = 8
  /**
   * 标题模块下间距
   */
  @State
  headingBottomMargins: number = 8
  /**
   * 流式输入是否输入结束(true:结束输入,false:持续输入)
   */
  @State
  isInputEnded: boolean = false

  aboutToAppear(): void {
    try {
      let titleData: TitleData = router.getParams() as TitleData
      this.fileStr = getFileContextStr(titleData._pagePath)
      this.isFull = titleData._isFull
      this.incrementalAnalysis = titleData._incrementalAnalysis
      this.time = titleData._time
      this.textNumber = titleData._textNumber
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
      this.headingTopMargins = titleData._headingTopMargins
      this.headingBottomMargins = titleData._headingBottomMargins
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
    theme.setHeadingBreakHeight(this.headingBreakHeight) // H1、H2标题下分割线高度
    theme.setHeadingBreakColor(this.headingBreakColor) // H1、H2标题下分割线颜色
    theme.setHeadingTypeface(this.headingTypeface) // 标题文本字体
    theme.setHeadingTopMargins(this.headingTopMargins) // 标题模块上间距
    theme.setHeadingBottomMargins(this.headingBottomMargins) // 标题模块下间距
    theme.setHeadingTextSizeMultipliers(this.headingTextSizeMultipliers) // 标题文本大小数组
    theme.setHeadingTextColor(this.headingTextColor) // 标题文本颜色
    theme.setHeadingTextWordSpace(this.headingTextWordSpace) // 标题文本字间距
    theme.setHeadingTextLineHeight1(this.headingTextLineHeight1) // 一级标题文本行高
    theme.setHeadingTextLineHeight2(this.headingTextLineHeight2) // 二级标题文本行高
    theme.setHeadingTextLineHeight3(this.headingTextLineHeight3) // 三级标题文本行高
    theme.setHeadingTextLineHeight4(this.headingTextLineHeight4) // 四级标题文本行高
    theme.setHeadingTextLineHeight5(this.headingTextLineHeight5) // 五级标题文本行高
    theme.setHeadingTextLineHeight6(this.headingTextLineHeight6) // 六级标题文本行高

    theme.setHeadingTextColor1(0xFFB22222) // 各级标题颜色
    theme.setHeadingTextColor2(0xFFD2691E)
    theme.setHeadingTextColor3(0xFFFFD700)
    theme.setHeadingTextColor4(0xFF228B22)
    theme.setHeadingTextColor5(0xFF00BFFF)
    theme.setHeadingTextColor6(0xFF9400D3)

    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    return plugin
  }
}