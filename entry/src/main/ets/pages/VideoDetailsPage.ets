/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from './FileUtils'
import { VideoData } from './VideoPage'
import { hilog } from '@kit.PerformanceAnalysisKit'

@Entry
@Component
struct VideoDetailsPage {
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
   * 视频圆角
   */
  videoBorderRadius: number = 10
  /**
   * 视频时间文本颜色
   */
  videoTimeTextColor: number = 0xFFFFFFFF
  /**
   * 视频时间文本大小
   */
  videoTimeTextSize: number = 14
  /**
   * 视频时间文本居右边距
   */
  videoTimeTextMarginRight: number = 10
  /**
   * 视频时间文本居底边距
   */
  videoTimeTextMarginBottom: number = 10
  /**
   * 视频上边距
   */
  videoMarginTop: number = 10
  /**
   * 视频下边距
   */
  videoMarginBottom: number = 10
  /**
   * 增量加载延迟
   */
  time: number = 50

  aboutToAppear(): void {
    try {
      let videoData: VideoData = router.getParams() as VideoData
      this.fileStr = getFileContextStr(videoData._pagePath)
      this.isFull = videoData._isFull
      this.videoBorderRadius = videoData._videoBorderRadius
      this.videoTimeTextColor = videoData._videoTimeTextColor
      this.videoTimeTextSize = videoData._videoTimeTextSize
      this.videoTimeTextMarginRight = videoData._videoTimeTextMarginRight
      this.videoTimeTextMarginBottom = videoData._videoTimeTextMarginBottom
      this.videoMarginTop = videoData._videoMarginTop
      this.videoMarginBottom = videoData._videoMarginBottom
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "视频测试用例",
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
        }.backgroundColor(Color.Gray)
      }
      .padding({ bottom: 200 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    config.setVideoCallback(this.videoCallback)
    config.setVideoImageCallback(this.videoImageCallback)
    let theme = new MarkdownTheme()
    theme.setVideoImage($r('app.media.place_holder'))
    theme.setPlayCircleFillIcon($r('app.media.play_circle_fill'))
    theme.setVideoBorderRadius(this.videoBorderRadius)
    theme.setVideoTimeTextColor(this.videoTimeTextColor)
    theme.setVideoTimeTextSize(this.videoTimeTextSize)
    theme.setVideoTimeTextMarginRight(this.videoTimeTextMarginRight)
    theme.setVideoTimeTextMarginBottom(this.videoTimeTextMarginBottom)
    theme.setVideoMarginTop(this.videoMarginTop)
    theme.setVideoMarginBottom(this.videoMarginBottom)
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsBlockVideoPlugin(true) // 视频插件
    return plugin
  }

  videoCallback(url: string, urlList: Array<string>): void {
    hilog.error(1, "1", `---url:${url},urlList:${urlList}`)
  }

  videoImageCallback(url: string, cb: (imageUrl: string, aspectRatio: number, time: number) => void): void {
    hilog.error(1, "1", `---url:${url}`)
    cb("https://pic.leetcode-cn.com/1614477066-YeEeWg-file_1614477068523", 16 / 9, 200)
  }
}