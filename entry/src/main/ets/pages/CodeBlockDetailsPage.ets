/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { CodeBlockData } from '../model/CodeBlockData'

@Entry
@Component
struct CodeBlockDetailsPage {
  // ---------- 通用
  /**
   * 滑动控制器
   */
  scroller: Scroller = new Scroller()
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
   * 是否开启打字机效果
   */
  @State
  typeWriterOpen: boolean = false
  /**
   * 打字机效果颜色
   */
  @State
  typeWriterColor: number = 0xFFFF0000
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
   * 是否格式化代码块内容
   */
  @State
  isCodeFormat: boolean = true
  /**
   * 代码块代码文本颜色
   */
  @State
  codeBlockTextColor: number | undefined = undefined
  /**
   * 代码块代码类型文本颜色
   */
  @State
  codeBlockTypeTextColor: number | undefined = undefined
  /**
   * 代码块代码类型文本
   */
  @State
  codeBlockTypeTextStr: string = ""
  /**
   * 代码类型和代码块距离
   */
  @State
  codeBlockTypeTextPadding: number = 0
  /**
   * 代码块复制、全屏图片文字是否显示
   */
  @State
  codeBlockIconTextHide: boolean = true
  /**
   * 代码块代码行号是否显示
   */
  @State
  codeBlockLineNumberHide: boolean = true
  /**
   * 代码块背景颜色
   */
  @State
  codeBlockBackgroundColor: number | undefined = undefined
  /**
   * 代码块左边距
   */
  @State
  codeMultilineMargin: number = 8
  /**
   * 代码块字体
   */
  @State
  codeBlockTypeface: string = "HarmonyOS Sans"
  /**
   * 代码块代码文本大小
   */
  @State
  codeBlockTextSize: number = 13
  /**
   * 代码块代码文本行高
   */
  @State
  codeBlockLineHeight: number = 22
  /**
   * 代码块控件圆角大小
   */
  @State
  codeBlockRadius: number = 8
  /**
   * 代码块代码全屏按钮是否显示
   */
  @State
  isCodeFullScreen: boolean = true
  /**
   * 代码块代码全屏、代码复制按钮宽高
   */
  @State
  iconWidthAndHeight: number = 24
  /**
   * 代码深浅色模式
   */
  @State
  isDark: boolean = true
  /**
   * codeformat是否使用制表符
   */
  @State
  useTab: boolean = false
  /**
   * codeformat空格缩进数量
   */
  @State
  indentWidth: number = 4

  aboutToAppear(): void {
    try {
      let codeBlockData: CodeBlockData = router.getParams() as CodeBlockData
      this.fileStr = getFileContextStr(codeBlockData._pagePath)
      // ---------- 通用
      this.isFull = codeBlockData._isFull
      this.incrementalAnalysis = codeBlockData._incrementalAnalysis
      this.time = codeBlockData._time
      this.textNumber = codeBlockData._textNumber
      this.isMarkdownParserSync = codeBlockData._isMarkdownParserSync
      this.typeWriterOpen = codeBlockData._typeWriterOpen
      this.typeWriterColor = codeBlockData._typeWriterColor
      this.isOnCopy = codeBlockData._isOnCopy
      this.blockFirstTopMargin = codeBlockData._blockFirstTopMargin
      this.blockLastBottomMargin = codeBlockData._blockLastBottomMargin
      this.blockTopAndBottomMargins = codeBlockData._blockTopAndBottomMargins
      this.openGestureSwipe = codeBlockData._openGestureSwipe
      this.openGestureSwipeTest = codeBlockData._openGestureSwipeTest
      // ---------- 专有
      this.isCodeFormat = codeBlockData._isCodeFormat
      this.codeBlockTextColor = codeBlockData._codeBlockTextColor
      this.codeBlockTypeTextColor = codeBlockData._codeBlockTypeTextColor
      this.codeBlockTypeTextStr = codeBlockData._codeBlockTypeTextStr
      this.codeBlockTypeTextPadding = codeBlockData._codeBlockTypeTextPadding
      this.codeBlockIconTextHide = codeBlockData._codeBlockIconTextHide
      this.codeBlockLineNumberHide = codeBlockData._codeBlockLineNumberHide
      this.codeBlockBackgroundColor = codeBlockData._codeBlockBackgroundColor
      this.codeMultilineMargin = codeBlockData._codeMultilineMargin
      this.codeBlockTypeface = codeBlockData._codeBlockTypeface
      this.codeBlockTextSize = codeBlockData._codeBlockTextSize
      this.codeBlockLineHeight = codeBlockData._codeBlockLineHeight
      this.codeBlockRadius = codeBlockData._codeBlockRadius
      this.isCodeFullScreen = codeBlockData._isCodeFullScreen
      this.iconWidthAndHeight = codeBlockData._iconWidthAndHeight
      this.iconWidthAndHeight = codeBlockData._iconWidthAndHeight
      this.isDark = codeBlockData._isDark
      this.useTab = codeBlockData._useTab
      this.indentWidth = codeBlockData._indentWidth
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "代码块测试用例",
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
        if (this.openGestureSwipeTest) { // 允许滑动响应测试，生效前提高度设置为100%
          Column() {
            CJMarkdown({
              content: this.content,
              isInputEnded: this.isInputEnded,
              incrementalAnalysis: this.incrementalAnalysis,
              config: this.setMarkdownConfig()
            })
          }.height("100%")
        } else {
          Column() {
            CJMarkdown({
              content: this.content,
              isInputEnded: this.isInputEnded,
              incrementalAnalysis: this.incrementalAnalysis,
              config: this.setMarkdownConfig()
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
    config.setCodeCopyCallback(this.codeCopyCallback.bind(this))
    let theme = new MarkdownTheme()
    theme.setIsCodeFormat(this.isCodeFormat)
    if (this.codeBlockTextColor !== undefined) {
      theme.setCodeBlockTextColor(this.codeBlockTextColor)
    }
    if (this.codeBlockTypeTextColor !== undefined) {
      theme.setCodeBlockTypeTextColor(this.codeBlockTypeTextColor)
    }
    theme.setCodeBlockTypeTextStr(this.codeBlockTypeTextStr)
    theme.setCodeBlockTypeTextPadding(this.codeBlockTypeTextPadding)
    theme.setCodeBlockIconTextHide(this.codeBlockIconTextHide)
    theme.setCodeBlockLineNumberHide(this.codeBlockLineNumberHide)
    if (this.codeBlockBackgroundColor !== undefined) {
      theme.setCodeBlockBackgroundColor(this.codeBlockBackgroundColor)
    }
    theme.setCodeMultilineMargin(this.codeMultilineMargin)
    theme.setCodeBlockTypeface(this.codeBlockTypeface)
    theme.setCodeBlockTextSize(this.codeBlockTextSize)
    theme.setCodeBlockLineHeight(this.codeBlockLineHeight)
    theme.setCodeBlockRadius(this.codeBlockRadius)
    theme.setIsCodeFullScreen(this.isCodeFullScreen)
    theme.setIconWidthAndHeight(this.iconWidthAndHeight)
    theme.setIsDark(this.isDark)
    theme.setCodeFullScreenIcon($r('app.media.startIcon'))
    theme.setCodeCopyIcon($r('app.media.startIcon'))
    theme.setUseTab(this.useTab) // codeformat是否使用制表符
    theme.setIndentWidth(this.indentWidth) // codeformat空格缩进数量

    theme.setIsMarkdownParserSync(this.isMarkdownParserSync) // markdown是否同步解析
    theme.setTypeWriterOpen(this.typeWriterOpen) // 是否开启打字机效果
    theme.setTypeWriterColor(this.typeWriterColor) // 打字机效果颜色
    theme.setIsOnCopy(this.isOnCopy) // 是否打开长按复制粘贴
    theme.setBlockFirstTopMargin(this.blockFirstTopMargin) // markdown第一个模块上边距
    theme.setBlockLastBottomMargin(this.blockLastBottomMargin) // markdown最后一个模块下边距
    theme.setBlockTopAndBottomMargins(this.blockTopAndBottomMargins) // 模块间上下间距
    theme.setOpenGestureSwipe(this.openGestureSwipe) // 是否允许markdown控件自身响应滑动

    config.setMarkdownTheme(theme)
    return config
  }

  codeCopyCallback(code: string): void {
    hilog.error(1, "1", `---code:${code}`)
  }
}