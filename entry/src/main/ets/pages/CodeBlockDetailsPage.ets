/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownTheme } from '@cangjie-tpc/markdown'
import { getFileContextStr } from './FileUtils'
import { CodeBlockData } from './CodeBlockPage'

@Entry
@Component
struct CodeBlockDetailsPage {
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
   * 增量加载延迟
   */
  time: number = 50

  aboutToAppear(): void {
    try {
      let codeBlockData: CodeBlockData = router.getParams() as CodeBlockData
      this.fileStr = getFileContextStr(codeBlockData._pagePath)
      this.isFull = codeBlockData._isFull
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
    if(this.codeBlockTextColor !== undefined){
      theme.setCodeBlockTextColor(this.codeBlockTextColor)
    }
    if(this.codeBlockTypeTextColor !== undefined){
      theme.setCodeBlockTypeTextColor(this.codeBlockTypeTextColor)
    }
    theme.setCodeBlockTypeTextStr(this.codeBlockTypeTextStr)
    theme.setCodeBlockTypeTextPadding(this.codeBlockTypeTextPadding)
    theme.setCodeBlockIconTextHide(this.codeBlockIconTextHide)
    theme.setCodeBlockLineNumberHide(this.codeBlockLineNumberHide)
    if(this.codeBlockBackgroundColor !== undefined){
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
    config.setMarkdownTheme(theme)
    return config
  }
}