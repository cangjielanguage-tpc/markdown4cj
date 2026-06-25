/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { AudioMDData } from '../model/AudioMDData'

@Entry
@Component
struct AudioDetailsPage {
  // ---------- 通用
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
   * 音频阴影颜色值
   */
  audioShadowColor: number | undefined = undefined
  /**
   * 音频边框颜色
   */
  audioBorderColor: number | undefined = undefined
  /**
   * 音频边框粗细
   */
  audioBorderWidth: number = 0.5
  /**
   * 音频边框圆角
   */
  audioBorderRadius: number = 12.0
  /**
   * 音频按钮背景颜色
   */
  audioButtonBackgroundColor: number | undefined = undefined
  /**
   * 音频按钮文字颜色
   */
  audioButtonTextColor: number | undefined = undefined
  /**
   * 音频按钮文字大小
   */
  audioButtonTextSize: number = 14.0
  /**
   * 音频按钮文字内容
   */
  audioButtonText: string = "立即播放"
  /**
   * 音频按钮圆角
   */
  audioButtonBorderRadius: number = 16.0
  /**
   * 音频标题文字大小
   */
  audioTitleTextSize: number = 15.0
  /**
   * 音频标题文字颜色
   */
  audioTitleTextColor: number | undefined = undefined
  /**
   * 音频标题文字行高
   */
  audioTitleTextLineHeight: number = 20.0
  /**
   * 音频类型文字大小
   */
  audioTypeTextSize: number = 11.0
  /**
   * 音频类型文字颜色
   */
  audioTypeTextColor: number | undefined = undefined
  /**
   * 音频类型文字行高
   */
  audioTypeTextLineHeight: number = 15.0
  /**
   * 音频上边距
   */
  audioMarginTop: number = 10.0
  /**
   * 音频下边距
   */
  audioMarginBottom: number = 10.0

  aboutToAppear(): void {
    try {
      let audioData: AudioMDData = router.getParams() as AudioMDData
      this.fileStr = getFileContextStr(audioData._pagePath)
      // ---------- 通用
      this.isFull = audioData._isFull
      this.incrementalAnalysis = audioData._incrementalAnalysis
      this.time = audioData._time
      this.textNumber = audioData._textNumber
      this.isMarkdownParserSync = audioData._isMarkdownParserSync
      this.isOnCopy = audioData._isOnCopy
      this.blockFirstTopMargin = audioData._blockFirstTopMargin
      this.blockLastBottomMargin = audioData._blockLastBottomMargin
      this.blockTopAndBottomMargins = audioData._blockTopAndBottomMargins
      this.openGestureSwipe = audioData._openGestureSwipe
      this.openGestureSwipeTest = audioData._openGestureSwipeTest
      // ---------- 专有
      this.audioShadowColor = audioData._audioShadowColor
      this.audioBorderColor = audioData._audioBorderColor
      this.audioBorderWidth = audioData._audioBorderWidth
      this.audioBorderRadius = audioData._audioBorderRadius
      this.audioButtonBackgroundColor = audioData._audioButtonBackgroundColor
      this.audioButtonTextColor = audioData._audioButtonTextColor
      this.audioButtonTextSize = audioData._audioButtonTextSize
      this.audioButtonText = audioData._audioButtonText
      this.audioButtonBorderRadius = audioData._audioButtonBorderRadius
      this.audioTitleTextSize = audioData._audioTitleTextSize
      this.audioTitleTextColor = audioData._audioTitleTextColor
      this.audioTitleTextLineHeight = audioData._audioTitleTextLineHeight
      this.audioTypeTextSize = audioData._audioTypeTextSize
      this.audioTypeTextColor = audioData._audioTypeTextColor
      this.audioTypeTextLineHeight = audioData._audioTypeTextLineHeight
      this.audioMarginTop = audioData._audioMarginTop
      this.audioMarginBottom = audioData._audioMarginBottom
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "音频测试用例",
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
              this.isInputEnded = true
              this.content = this.fileStr
            } else {
              this.isInputEnded = false
              let index = 0
              let id = setInterval(() => {
                this.content = this.content + this.fileStr[index]
                this.scroller.scrollEdge(Edge.Bottom)
                if (index === this.fileStr.length - 1) {
                  this.isInputEnded = true
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
    config.setAudioCallback(this.audioCallback)

    let theme = new MarkdownTheme()
    theme.setAudioIcon($r('app.media.startIcon'))
    if (this.audioShadowColor !== undefined) {
      theme.setAudioShadowColor(this.audioShadowColor)
    }
    if (this.audioBorderColor !== undefined) {
      theme.setAudioBorderColor(this.audioBorderColor)
    }
    theme.setAudioBorderWidth(this.audioBorderWidth)
    theme.setAudioBorderRadius(this.audioBorderRadius)
    if (this.audioButtonBackgroundColor !== undefined) {
      theme.setAudioButtonBackgroundColor(this.audioButtonBackgroundColor)
    }
    if (this.audioButtonTextColor !== undefined) {
      theme.setAudioButtonTextColor(this.audioButtonTextColor)
    }
    theme.setAudioButtonTextSize(this.audioButtonTextSize)
    theme.setAudioButtonText(this.audioButtonText)
    theme.setAudioButtonBorderRadius(this.audioButtonBorderRadius)
    theme.setAudioTitleTextSize(this.audioTitleTextSize)
    if (this.audioTitleTextColor !== undefined) {
      theme.setAudioTitleTextColor(this.audioTitleTextColor)
    }
    theme.setAudioTitleTextLineHeight(this.audioTitleTextLineHeight)
    theme.setAudioTypeTextSize(this.audioTypeTextSize)
    if (this.audioTypeTextColor !== undefined) {
      theme.setAudioTypeTextColor(this.audioTypeTextColor)
    }
    theme.setAudioTypeTextLineHeight(this.audioTypeTextLineHeight)
    theme.setAudioMarginTop(this.audioMarginTop)
    theme.setAudioMarginBottom(this.audioMarginBottom)

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
    plugin.setIsBlockAudioPlugin(true) // 音频插件
    return plugin
  }

  audioCallback(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }
}