/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import { TitleData } from '../model/TitleData'

@Entry
@Component
struct TitleDetailsPage {
  /**
   * 滑动控制器
   */
  scroller: Scroller = new Scroller()
  // /**
  //  * Markdown的控制器
  //  */
  // markdownScroller: MarkdownScroller = new MarkdownScroller()
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop')
  safeTop: number = 0
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
   * 是否全量加载Markdown文本
   */
  @State
  isFull: boolean = true
  /**
   * 是否增量解析Markdown文本
   */
  @State
  incrementalAnalysis: boolean = false
  /**
   * 增量加载每次间隔时间
   */
  @State
  time: number = 50
  /**
   * 增量每次增量文本数量
   */
  @State
  textNumber: number = 10
  /**
   * 是否同步解析Markdown文本
   */
  @State
  isMarkdownParserSync: boolean = false
  /**
   * 是否打开长按复制粘贴效果
   */
  @State
  isOnCopy: boolean = false
  /**
   * Markdown文本第一个模块上边距
   */
  @State
  blockFirstTopMargin: number = 8
  /**
   * Markdown文本最后一个模块下边距
   */
  @State
  blockLastBottomMargin: number = 8
  /**
   * Markdown文本模块间上下间距
   */
  @State
  blockTopAndBottomMargins: number = 8
  /**
   * 是否允许markdown控件自身响应滑动
   */
  @State
  openGestureSwipe: boolean = false
  /**
   * 是否开启响应滑动测试
   */
  @State
  openGestureSwipeTest: boolean = false
  /**
   * 流式输入是否输入结束(true:结束输入,false:持续输入)
   */
  @State
  isInputEnded: boolean = false

  // ---------- 专有
  /**
   * H1、H2下划线高度
   */
  @State
  headingBreakHeight: number = 1
  /**
   * H1下划线颜色
   */
  @State
  headingBreakColor1: number | undefined = undefined
  /**
   * H2下划线颜色
   */
  @State
  headingBreakColor2: number | undefined = undefined
  /**
   * 标题文本颜色
   */
  @State
  headingTextColor: number | undefined = undefined
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
   * 标题文本大小1
   */
  @State
  headingTextSizeMultipliers1: number = 20
  /**
   * 标题文本大小2
   */
  @State
  headingTextSizeMultipliers2: number = 17
  /**
   * 标题文本大小3
   */
  @State
  headingTextSizeMultipliers3: number = 16
  /**
   * 标题文本大小4
   */
  @State
  headingTextSizeMultipliers4: number = 15
  /**
   * 标题文本大小5
   */
  @State
  headingTextSizeMultipliers5: number = 15
  /**
   * 标题文本大小6
   */
  @State
  headingTextSizeMultipliers6: number = 13
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
   * 标题文本颜色1
   */
  @State
  headingTextColors1: number | undefined = undefined
  /**
   * 标题文本颜色2
   */
  @State
  headingTextColors2: number | undefined = undefined
  /**
   * 标题文本颜色3
   */
  @State
  headingTextColors3: number | undefined = undefined
  /**
   * 标题文本颜色4
   */
  @State
  headingTextColors4: number | undefined = undefined
  /**
   * 标题文本颜色5
   */
  @State
  headingTextColors5: number | undefined = undefined
  /**
   * 标题文本颜色6
   */
  @State
  headingTextColors6: number | undefined = undefined

  aboutToAppear(): void {
    try {
      let titleData: TitleData = router.getParams() as TitleData
      this.fileStr = getFileContextStr(titleData._pagePath)
      // ---------- 通用
      this.isFull = titleData._isFull
      this.incrementalAnalysis = titleData._incrementalAnalysis
      this.time = titleData._time
      this.textNumber = titleData._textNumber
      this.isMarkdownParserSync = titleData._isMarkdownParserSync
      this.isOnCopy = titleData._isOnCopy
      this.blockFirstTopMargin = titleData._blockFirstTopMargin
      this.blockLastBottomMargin = titleData._blockLastBottomMargin
      this.blockTopAndBottomMargins = titleData._blockTopAndBottomMargins
      this.openGestureSwipe = titleData._openGestureSwipe
      this.openGestureSwipeTest = titleData._openGestureSwipeTest
      // ---------- 专有
      this.headingBreakHeight = titleData._headingBreakHeight
      this.headingBreakColor1 = titleData._headingBreakColor1
      this.headingBreakColor2 = titleData._headingBreakColor2
      this.headingTextWordSpace = titleData._headingTextWordSpace
      this.headingTextLineHeight1 = titleData._headingTextLineHeight1
      this.headingTextLineHeight2 = titleData._headingTextLineHeight2
      this.headingTextLineHeight3 = titleData._headingTextLineHeight3
      this.headingTextLineHeight4 = titleData._headingTextLineHeight4
      this.headingTextLineHeight5 = titleData._headingTextLineHeight5
      this.headingTextLineHeight6 = titleData._headingTextLineHeight6
      this.headingTextSizeMultipliers1 = titleData._headingTextSizeMultipliers1
      this.headingTextSizeMultipliers2 = titleData._headingTextSizeMultipliers2
      this.headingTextSizeMultipliers3 = titleData._headingTextSizeMultipliers3
      this.headingTextSizeMultipliers4 = titleData._headingTextSizeMultipliers4
      this.headingTextSizeMultipliers5 = titleData._headingTextSizeMultipliers5
      this.headingTextSizeMultipliers6 = titleData._headingTextSizeMultipliers6
      this.headingTypeface = titleData._headingTypeface
      this.headingTopMargins = titleData._headingTopMargins
      this.headingBottomMargins = titleData._headingBottomMargins
      this.headingTextColors1 = titleData._headingTextColors1
      this.headingTextColors2 = titleData._headingTextColors2
      this.headingTextColors3 = titleData._headingTextColors3
      this.headingTextColors4 = titleData._headingTextColors4
      this.headingTextColors5 = titleData._headingTextColors5
      this.headingTextColors6 = titleData._headingTextColors6
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
        if (this.openGestureSwipeTest) { // 允许滑动响应测试，生效前提高度设置为100%
          Column() {
            CJMarkdown({
              content: this.content,
              // isInputEnded: this.isInputEnded,
              // incrementalAnalysis: this.incrementalAnalysis,
              // listScroller: this.markdownScroller,
              config: this.setMarkdownConfig(),
              // plugin: this.setPlugin()
            })
          }.height("100%")
        } else {
          Column() {
            CJMarkdown({
              content: this.content,
              // isInputEnded: this.isInputEnded,
              // incrementalAnalysis: this.incrementalAnalysis,
              // listScroller: this.markdownScroller,
              config: this.setMarkdownConfig(),
              // plugin: this.setPlugin()
            })
          }
        }
      }
      .align(Alignment.TopStart)
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    let theme = new MarkdownTheme()
    theme.setContext(getContext(this)) // 上下文

    theme.setIsMarkdownParserSync(this.isMarkdownParserSync) // markdown是否同步解析
    theme.setIsOnCopy(this.isOnCopy) // 是否打开长按复制粘贴
    theme.setBlockFirstTopMargin(this.blockFirstTopMargin) // markdown第一个模块上边距
    theme.setBlockLastBottomMargin(this.blockLastBottomMargin) // markdown最后一个模块下边距
    theme.setBlockTopAndBottomMargins(this.blockTopAndBottomMargins) // 模块间上下间距
    theme.setOpenGestureSwipe(this.openGestureSwipe) // 是否允许markdown控件自身响应滑动

    theme.setHeadingBreakHeight(this.headingBreakHeight) // H1、H2标题下分割线高度
    theme.setHeadingTypeface(this.headingTypeface) // 标题文本字体
    theme.setHeadingTopMargins(this.headingTopMargins) // 标题模块上间距
    theme.setHeadingBottomMargins(this.headingBottomMargins) // 标题模块下间距

    theme.setHeadingTextSize1(this.headingTextSizeMultipliers1) // [20, 17, 16, 15, 15, 13]
    theme.setHeadingTextSize2(this.headingTextSizeMultipliers2)
    theme.setHeadingTextSize3(this.headingTextSizeMultipliers3)
    theme.setHeadingTextSize4(this.headingTextSizeMultipliers4)
    theme.setHeadingTextSize5(this.headingTextSizeMultipliers5)
    theme.setHeadingTextSize6(this.headingTextSizeMultipliers6)

    theme.setHeadingTextWordSpace(this.headingTextWordSpace) // 标题文本字间距
    theme.setHeadingTextLineHeight1(this.headingTextLineHeight1) // 一级标题文本行高
    theme.setHeadingTextLineHeight2(this.headingTextLineHeight2) // 二级标题文本行高
    theme.setHeadingTextLineHeight3(this.headingTextLineHeight3) // 三级标题文本行高
    theme.setHeadingTextLineHeight4(this.headingTextLineHeight4) // 四级标题文本行高
    theme.setHeadingTextLineHeight5(this.headingTextLineHeight5) // 五级标题文本行高
    theme.setHeadingTextLineHeight6(this.headingTextLineHeight6) // 六级标题文本行高

    if (this.headingTextColors1 !== undefined) {
      theme.setHeadingTextColor1(this.headingTextColors1) // 一级标题文本颜色
    }
    if (this.headingTextColors2 !== undefined) {
      theme.setHeadingTextColor2(this.headingTextColors2) // 二级标题文本颜色
    }
    if (this.headingTextColors3 !== undefined) {
      theme.setHeadingTextColor3(this.headingTextColors3) // 三级标题文本颜色
    }
    if (this.headingTextColors4 !== undefined) {
      theme.setHeadingTextColor4(this.headingTextColors4) // 四级标题文本颜色
    }
    if (this.headingTextColors5 !== undefined) {
      theme.setHeadingTextColor5(this.headingTextColors5) // 五级标题文本颜色
    }
    if (this.headingTextColors6 !== undefined) {
      theme.setHeadingTextColor6(this.headingTextColors6) // 六级标题文本颜色
    }

    if (this.headingBreakColor1 !== undefined) {
      theme.setHeadingBreakColor1(this.headingBreakColor1) // H1标题下分割线颜色
    }
    if (this.headingBreakColor2 !== undefined) {
      theme.setHeadingBreakColor2(this.headingBreakColor2) // H2标题下分割线颜色
    }

    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    return plugin
  }
}