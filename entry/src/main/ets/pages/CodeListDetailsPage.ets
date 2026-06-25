/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import { CodeListData } from '../model/CodeListData'

@Entry
@Component
struct CodeListDetailsPage {
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
   * 组合代码未选中标题字体大小
   */
  codeListTitleTextSize: number = 13
  /**
   * 组合代码选中标题字体大小
   */
  codeListTitleSelectTextSize: number = 13
  /**
   * 组合代码选中标题文本颜色
   */
  codeListTitleSelectTextColor: number | undefined = undefined
  /**
   * 组合代码未选中标题文本颜色
   */
  codeListTitleUnSelectTextColor: number | undefined = undefined
  /**
   * 组合代码选中标题背景颜色
   */
  codeListTitleSelectBackGroupColor: number | undefined = undefined
  /**
   * 组合代码未选中标题背景颜色
   */
  codeListTitleUnSelectBackGroupColor: number | undefined = undefined

  aboutToAppear(): void {
    try {
      let codeListData: CodeListData = router.getParams() as CodeListData
      this.fileStr = getFileContextStr(codeListData._pagePath)
      // ---------- 通用
      this.isFull = codeListData._isFull
      this.incrementalAnalysis = codeListData._incrementalAnalysis
      this.time = codeListData._time
      this.textNumber = codeListData._textNumber
      this.isMarkdownParserSync = codeListData._isMarkdownParserSync
      this.isOnCopy = codeListData._isOnCopy
      this.blockFirstTopMargin = codeListData._blockFirstTopMargin
      this.blockLastBottomMargin = codeListData._blockLastBottomMargin
      this.blockTopAndBottomMargins = codeListData._blockTopAndBottomMargins
      this.openGestureSwipe = codeListData._openGestureSwipe
      this.openGestureSwipeTest = codeListData._openGestureSwipeTest
      // ---------- 专有
      this.codeListTitleTextSize = codeListData._codeListTitleTextSize
      this.codeListTitleSelectTextSize = codeListData._codeListTitleSelectTextSize
      this.codeListTitleSelectTextColor = codeListData._codeListTitleSelectTextColor
      this.codeListTitleUnSelectTextColor = codeListData._codeListTitleUnSelectTextColor
      this.codeListTitleSelectBackGroupColor = codeListData._codeListTitleSelectBackGroupColor
      this.codeListTitleUnSelectBackGroupColor = codeListData._codeListTitleUnSelectBackGroupColor
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "组合代码块测试用例",
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
    theme.setCodeListTitleTextSize(this.codeListTitleTextSize)
    theme.setCodeListTitleSelectTextSize(this.codeListTitleSelectTextSize)
    if (this.codeListTitleSelectTextColor !== undefined) {
      theme.setCodeListTitleSelectTextColor(this.codeListTitleSelectTextColor)
    }
    if (this.codeListTitleUnSelectTextColor !== undefined) {
      theme.setCodeListTitleUnSelectTextColor(this.codeListTitleUnSelectTextColor)
    }
    if (this.codeListTitleSelectBackGroupColor !== undefined) {
      theme.setCodeListTitleSelectBackgroundColor(this.codeListTitleSelectBackGroupColor)
    }
    if (this.codeListTitleUnSelectBackGroupColor !== undefined) {
      theme.setCodeListTitleUnSelectBackgroundColor(this.codeListTitleUnSelectBackGroupColor)
    }
    theme.setCodeFullScreenIcon($r('app.media.startIcon'))
    theme.setCodeCopyIcon($r('app.media.startIcon'))

    theme.setIsMarkdownParserSync(this.isMarkdownParserSync) // markdown是否同步解析
    theme.setIsOnCopy(this.isOnCopy) // 是否打开长按复制粘贴
    theme.setBlockFirstTopMargin(this.blockFirstTopMargin) // markdown第一个模块上边距
    theme.setBlockLastBottomMargin(this.blockLastBottomMargin) // markdown最后一个模块下边距
    theme.setBlockTopAndBottomMargins(this.blockTopAndBottomMargins) // 模块间上下间距
    theme.setOpenGestureSwipe(this.openGestureSwipe) // 是否允许markdown控件自身响应滑动

    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsCodeListPlugin(true) // 代码块列表
    return plugin
  }
}