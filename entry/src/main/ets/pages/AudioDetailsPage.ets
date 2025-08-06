/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown'
import { getFileContextStr } from './FileUtils'
import { AudioDataMD } from './AudioPage'
import { hilog } from '@kit.PerformanceAnalysisKit'

@Entry
@Component
struct AudioDetailsPage {
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
   * 音频阴影颜色值
   */
  audioShadowColor: number = 0x1A000000
  /**
   * 音频边框颜色
   */
  audioBorderColor: number = 0x33000000
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
  audioButtonBackgroundColor: number = 0xFF000000
  /**
   * 音频按钮文字颜色
   */
  audioButtonTextColor: number = 0xFFFFFFFF
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
  audioTitleTextColor: number = 0xFF000000
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
  audioTypeTextColor: number = 0x80000000
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
  /**
   * 增量加载延迟
   */
  time: number = 50

  aboutToAppear(): void {
    try {
      let audioData: AudioDataMD = router.getParams() as AudioDataMD
      this.fileStr = getFileContextStr(audioData._pagePath)
      this.isFull = audioData._isFull
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
    config.setAudioCallback(this.audioCallback)
    let theme = new MarkdownTheme()
    theme.setAudioIcon($r('app.media.startIcon'))
    theme.setAudioShadowColor(this.audioShadowColor)
    theme.setAudioBorderColor(this.audioBorderColor)
    theme.setAudioBorderWidth(this.audioBorderWidth)
    theme.setAudioBorderRadius(this.audioBorderRadius)
    theme.setAudioButtonBackgroundColor(this.audioButtonBackgroundColor)
    theme.setAudioButtonTextColor(this.audioButtonTextColor)
    theme.setAudioButtonTextSize(this.audioButtonTextSize)
    theme.setAudioButtonText(this.audioButtonText)
    theme.setAudioButtonBorderRadius(this.audioButtonBorderRadius)
    theme.setAudioTitleTextSize(this.audioTitleTextSize)
    theme.setAudioTitleTextColor(this.audioTitleTextColor)
    theme.setAudioTitleTextLineHeight(this.audioTitleTextLineHeight)
    theme.setAudioTypeTextSize(this.audioTypeTextSize)
    theme.setAudioTypeTextColor(this.audioTypeTextColor)
    theme.setAudioTypeTextLineHeight(this.audioTypeTextLineHeight)
    theme.setAudioMarginTop(this.audioMarginTop)
    theme.setAudioMarginBottom(this.audioMarginBottom)
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