/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from './FileUtils'
import { VideoData } from './VideoPage'
import hilog from '@ohos.hilog'

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
   * 视频发布/下载按钮布局是否显示
   */
  @State
  isVideoBottomLayout: boolean = false
  /**
   * 视频发布按钮图片宽度和高度
   */
  @State
  videoReleaseImageWidthHeight: number = 18
  /**
   * 视频发布按钮宽度
   */
  @State
  videoReleaseWidth: number = 144
  /**
   * 视频发布按钮高度
   */
  @State
  videoReleaseHeight: number = 44
  /**
   * 视频发布按钮圆角
   */
  @State
  videoReleaseRadius: number = 22
  /**
   * 视频发布按钮文本内容
   */
  @State
  videoReleaseText: string = "发布视频"
  /**
   * 视频发布按钮文本大小
   */
  @State
  videoReleaseTexSize: number = 16
  /**
   * 视频发布按钮文本颜色
   */
  @State
  videoReleaseTexColor: number = 0xE6000000
  /**
   * 视频发布按钮背景颜色
   */
  @State
  videoReleaseBackgroundColor: number = 0xFFF5F5F5
  /**
   * 视频下载按钮图片宽度和高度
   */
  @State
  videoDownloadImageWidthHeight: number = 18
  /**
   * 视频下载按钮宽度
   */
  @State
  videoDownloadWidth: number = 144
  /**
   * 视频下载按钮高度
   */
  @State
  videoDownloadHeight: number = 44
  /**
   * 视频下载按钮圆角
   */
  @State
  videoDownloadRadius: number = 22
  /**
   * 视频下载按钮文本内容
   */
  @State
  videoDownloadText: string = "下载视频"
  /**
   * 视频下载按钮文本大小
   */
  @State
  videoDownloadTexSize: number = 16
  /**
   * 视频下载按钮文本颜色
   */
  @State
  videoDownloadTexColor: number = 0xE6000000
  /**
   * 视频下载按钮背景颜色
   */
  @State
  videoDownloadBackgroundColor: number = 0xFFF5F5F5
  /**
   * 流式输入是否输入结束(true:结束输入,false:持续输入)
   */
  @State
  isInputEnded: boolean = false

  aboutToAppear(): void {
    try {
      let videoData: VideoData = router.getParams() as VideoData
      this.fileStr = getFileContextStr(videoData._pagePath)
      this.isFull = videoData._isFull
      this.incrementalAnalysis = videoData._incrementalAnalysis
      this.time = videoData._time
      this.textNumber = videoData._textNumber
      this.videoBorderRadius = videoData._videoBorderRadius
      this.videoTimeTextColor = videoData._videoTimeTextColor
      this.videoTimeTextSize = videoData._videoTimeTextSize
      this.videoTimeTextMarginRight = videoData._videoTimeTextMarginRight
      this.videoTimeTextMarginBottom = videoData._videoTimeTextMarginBottom
      this.videoMarginTop = videoData._videoMarginTop
      this.videoMarginBottom = videoData._videoMarginBottom
      this.isVideoBottomLayout = videoData._isVideoBottomLayout
      this.videoReleaseImageWidthHeight = videoData._videoReleaseImageWidthHeight
      this.videoReleaseWidth = videoData._videoReleaseWidth
      this.videoReleaseHeight = videoData._videoReleaseHeight
      this.videoReleaseRadius = videoData._videoReleaseRadius
      this.videoReleaseText = videoData._videoReleaseText
      this.videoReleaseTexSize = videoData._videoReleaseTexSize
      this.videoReleaseTexColor = videoData._videoReleaseTexColor
      this.videoReleaseBackgroundColor = videoData._videoReleaseBackgroundColor
      this.videoDownloadImageWidthHeight = videoData._videoDownloadImageWidthHeight
      this.videoDownloadWidth = videoData._videoDownloadWidth
      this.videoDownloadHeight = videoData._videoDownloadHeight
      this.videoDownloadRadius = videoData._videoDownloadRadius
      this.videoDownloadText = videoData._videoDownloadText
      this.videoDownloadTexSize = videoData._videoDownloadTexSize
      this.videoDownloadTexColor = videoData._videoDownloadTexColor
      this.videoDownloadBackgroundColor = videoData._videoDownloadBackgroundColor
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
        }.backgroundColor(Color.Gray)
      }
      .padding({ bottom: 200 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    config.setVideoCallback(this.videoCallback) // 视频点击回调
    config.setVideoImageCallback(this.videoImageCallback) // 视频占位图和宽高比和视频时长的回调
    config.setVideoReleaseCallback(this.videoReleaseCallback) // 视频发布的点击事件
    config.setVideoDownloadCallback(this.videoDownloadCallback) // 视频下载的点击事件
    let theme = new MarkdownTheme()
    theme.setVideoImage($r('app.media.place_holder')) // 视频默认占位图
    theme.setPlayCircleFillIcon($r('app.media.play_circle_fill')) // 视频播放按钮默认图标
    theme.setVideoReleaseImage($r('app.media.video_release')) // 视频发布默认图标
    theme.setVideoDownloadImage($r('app.media.video_download')) // 视频下载默认图标
    theme.setVideoBorderRadius(this.videoBorderRadius) // 视频圆角
    theme.setVideoTimeTextColor(this.videoTimeTextColor) // 视频时间文本颜色
    theme.setVideoTimeTextSize(this.videoTimeTextSize) // 视频时间文本大小
    theme.setVideoTimeTextMarginRight(this.videoTimeTextMarginRight) // 视频时间文本居右边距
    theme.setVideoTimeTextMarginBottom(this.videoTimeTextMarginBottom) // 视频时间文本居底边距
    theme.setVideoMarginTop(this.videoMarginTop) // 视频上边距
    theme.setVideoMarginBottom(this.videoMarginBottom) // 视频下边距
    theme.setIsVideoBottomLayout(this.isVideoBottomLayout) // 视频发布/下载按钮布局是否显示
    theme.setVideoReleaseImageWidthHeight(this.videoReleaseImageWidthHeight) // 视频发布按钮图片宽度和高度
    theme.setVideoReleaseWidth(this.videoReleaseWidth) // 视频发布按钮宽度
    theme.setVideoReleaseHeight(this.videoReleaseHeight) // 视频发布按钮高度
    theme.setVideoReleaseRadius(this.videoReleaseRadius) // 视频发布按钮圆角
    theme.setVideoReleaseText(this.videoReleaseText) // 视频发布按钮文本内容
    theme.setVideoReleaseTexSize(this.videoReleaseTexSize) // 视频发布按钮文本大小
    theme.setVideoReleaseTexColor(this.videoReleaseTexColor) // 视频发布按钮文本颜色
    theme.setVideoReleaseBackgroundColor(this.videoReleaseBackgroundColor) // 视频发布按钮背景颜色
    theme.setVideoDownloadImageWidthHeight(this.videoDownloadImageWidthHeight) // 视频下载按钮图片宽度和高度
    theme.setVideoDownloadWidth(this.videoDownloadWidth) // 视频下载按钮宽度
    theme.setVideoDownloadHeight(this.videoDownloadHeight) // 视频下载按钮高度
    theme.setVideoDownloadRadius(this.videoDownloadRadius) // 视频下载按钮圆角
    theme.setVideoDownloadText(this.videoDownloadText) // 视频下载按钮文本内容
    theme.setVideoDownloadTexSize(this.videoDownloadTexSize) // 视频下载按钮文本大小
    theme.setVideoDownloadTexColor(this.videoDownloadTexColor) // 视频下载按钮文本颜色
    theme.setVideoDownloadBackgroundColor(this.videoDownloadBackgroundColor) // 视频下载按钮背景颜色
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

  videoReleaseCallback(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  videoDownloadCallback(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }
}