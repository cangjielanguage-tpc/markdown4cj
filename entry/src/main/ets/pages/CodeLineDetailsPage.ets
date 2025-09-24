/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from './FileUtils'
import { CodeLineData } from './CodeLinePage'

@Entry
@Component
struct CodeLineDetailsPage {
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
   * 内联代码是否是图片显示
   */
  isCodeStyle: boolean = false
  /**
   * 文本、图片格式内联代码文本颜色
   */
  codeTextColor: number = 0xFF000000
  /**
   * 文本、图片格式内联代码背景颜色
   */
  codeBackgroundColor: number = 0xFF191919
  /**
   * 文本、图片格式内联代码文本大小
   */
  codeTextSize: number = 13
  /**
   * 文本格式内联代码文本字体
   */
  codeTypeface: string = "HarmonyOS Sans"
  /**
   * 图片格式内联代码文本左右边距
   */
  codeLeftAndRightPadding: number = 4
  /**
   * 图片格式内联代码文本高度
   */
  codeHeight: number = 20
  /**
   * 增量加载延迟
   */
  time: number = 50

  aboutToAppear(): void {
    try {
      let codeLineData: CodeLineData = router.getParams() as CodeLineData
      this.fileStr = getFileContextStr(codeLineData._pagePath)
      this.isFull = codeLineData._isFull
      this.isCodeStyle = codeLineData._isCodeStyle
      this.codeTextColor = codeLineData._codeTextColor
      this.codeBackgroundColor = codeLineData._codeBackgroundColor
      this.codeTextSize = codeLineData._codeTextSize
      this.codeTypeface = codeLineData._codeTypeface
      this.codeLeftAndRightPadding = codeLineData._codeLeftAndRightPadding
      this.codeHeight = codeLineData._codeHeight
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "内联代码测试用例",
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
    let theme = new MarkdownTheme()
    theme.setIsCodeStyle(this.isCodeStyle)
    theme.setCodeTextColor(this.codeTextColor)
    theme.setCodeBackgroundColor(this.codeBackgroundColor)
    theme.setCodeTextSize(this.codeTextSize)
    theme.setCodeTypeface(this.codeTypeface)
    theme.setCodeLeftAndRightPadding(this.codeLeftAndRightPadding)
    theme.setCodeHeight(this.codeHeight)
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true)
    return plugin
  }
}