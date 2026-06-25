/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextArr, getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { ImageDataMD } from './ImagePage'

@Entry
@Component
struct ImageDetailsPage {
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
   * 是否触发图片替换事件
   */
  @State
  callback: boolean = false
  /**
   * 图片默认占位图
   */
  @State
  imageResource: Resource | undefined = undefined
  /**
   * 图片上边距
   */
  @State
  imageMarginTop: number = 10
  /**
   * 图片下边距
   */
  @State
  imageMarginBottom: number = 10
  /**
   * 图片圆角
   */
  @State
  imageBorderRadius: number = 0
  /**
 * 图片边框宽度
 */
  @State
  imageBorderWidth: number = 0
  /**
 * 图片边框颜色
 */
  @State
  imageBorderColor: number | undefined = undefined
  /**
   * 图片基于自身宽度缩放百分比
   */
  @State
  imageMaximumWidth: number = 1.0
  /**
   * 图片基于父布局宽度缩放百分比
   */
  @State
  imageFixedRatioWidth: number | undefined = undefined
  /**
   * 图片最大高度
   */
  @State
  imageMaxHeight: number | undefined = undefined
  /**
 * 图片最大宽度
 */
  @State
  imageMaxWidth: number | undefined = undefined
  /**
   * 图片是否有下载按钮
   */
  @State
  isImageDownload: boolean = false
  /**
   * 是否图文混排
   */
  @State
  isImageMixedLayout: boolean = true
  /**
   * 图片下载按钮图片宽度和高度
   */
  @State
  imageDownloadImageWidthHeight: number = 18
  /**
   * 图片下载按钮宽度
   */
  @State
  imageDownloadWidth: number = 144
  /**
   * 图片下载按钮高度
   */
  @State
  imageDownloadHeight: number = 44
  /**
   * 图片下载按钮圆角
   */
  @State
  imageDownloadRadius: number = 22
  /**
   * 图片下载按钮文本内容
   */
  @State
  imageDownloadText: string = "下载图片"
  /**
   * 图片下载按钮文本大小
   */
  @State
  imageDownloadTexSize: number = 16
  /**
   * 图片下载按钮文本颜色
   */
  @State
  imageDownloadTexColor: number | undefined = undefined
  /**
   * 图片下载按钮背景颜色
   */
  @State
  imageDownloadBackgroundColor: number | undefined = undefined

  aboutToAppear(): void {
    try {
      let imageDataMD: ImageDataMD = router.getParams() as ImageDataMD
      this.fileStr = getFileContextStr(imageDataMD._pagePath)
      // ---------- 通用
      this.isFull = imageDataMD._isFull
      this.incrementalAnalysis = imageDataMD._incrementalAnalysis
      this.time = imageDataMD._time
      this.textNumber = imageDataMD._textNumber
      this.isMarkdownParserSync = imageDataMD._isMarkdownParserSync
      this.isOnCopy = imageDataMD._isOnCopy
      this.blockFirstTopMargin = imageDataMD._blockFirstTopMargin
      this.blockLastBottomMargin = imageDataMD._blockLastBottomMargin
      this.blockTopAndBottomMargins = imageDataMD._blockTopAndBottomMargins
      this.openGestureSwipe = imageDataMD._openGestureSwipe
      this.openGestureSwipeTest = imageDataMD._openGestureSwipeTest
      // ---------- 专有
      this.callback = imageDataMD._callback
      this.imageResource = imageDataMD._imageResource
      this.imageMarginTop = imageDataMD._imageMarginTop
      this.imageMarginBottom = imageDataMD._imageMarginBottom
      this.imageBorderRadius = imageDataMD._imageBorderRadius
      this.imageBorderWidth = imageDataMD._imageBorderWidth
      this.imageBorderColor = imageDataMD._imageBorderColor
      this.imageMaximumWidth = imageDataMD._imageMaximumWidth
      this.imageFixedRatioWidth = imageDataMD._imageFixedRatioWidth
      this.imageMaxHeight = imageDataMD._imageMaxHeight
      this.imageMaxWidth = imageDataMD._imageMaxWidth
      this.isImageDownload = imageDataMD._isImageDownload
      this.isImageMixedLayout = imageDataMD._isImageMixedLayout
      this.imageDownloadImageWidthHeight = imageDataMD._imageDownloadImageWidthHeight
      this.imageDownloadWidth = imageDataMD._imageDownloadWidth
      this.imageDownloadHeight = imageDataMD._imageDownloadHeight
      this.imageDownloadRadius = imageDataMD._imageDownloadRadius
      this.imageDownloadText = imageDataMD._imageDownloadText
      this.imageDownloadTexSize = imageDataMD._imageDownloadTexSize
      this.imageDownloadTexColor = imageDataMD._imageDownloadTexColor
      this.imageDownloadBackgroundColor = imageDataMD._imageDownloadBackgroundColor
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "图片测试用例",
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
    config.setImageCallback(this.setImageCallback) // 图片点击回调
    if (this.callback) {
      config.setImageCallbackCallback(this.setImageCallbackCallback) // 图片替换事件
    }
    config.setImageDownloadCallback(this.setImageDownloadCallback) // 图片下载的点击事件
    let theme = new MarkdownTheme()
    theme.setContext(getContext(this)) // 上下文
    if (this.imageResource !== undefined) {
      theme.setImageResource(this.imageResource) // 图片占位图
    }
    theme.setImageMarginTop(this.imageMarginTop) // 图片上边距
    theme.setImageMarginBottom(this.imageMarginBottom) // 图片下边距
    theme.setImageBorderRadius(this.imageBorderRadius) // 图片圆角大小
    theme.setImageBorderWidth(this.imageBorderWidth) // 图片边框宽度
    if (this.imageBorderColor !== undefined) {
      theme.setImageBorderColor(this.imageBorderColor) // 图片边框颜色
    }
    theme.setImageMaximumWidth(this.imageMaximumWidth) // 图片基于自身宽度缩放百分比
    if (this.imageFixedRatioWidth !== undefined) {
      theme.setImageFixedRatioWidth(this.imageFixedRatioWidth) // 图片基于父布局宽度缩放百分比
    }
    if (this.imageMaxHeight !== undefined) {
      theme.setImageMaxHeight(this.imageMaxHeight) // 图片最大高度
    }
    if (this.imageMaxWidth !== undefined) {
      theme.setImageMaxWidth(this.imageMaxWidth) // 图片最大宽度
    }
    theme.setImageDownloadImage($r('app.media.video_download')) // 图片下载默认图标
    theme.setIsImageDownload(this.isImageDownload) // 图片是否有下载按钮
    theme.setIsImageMixedLayout(this.isImageMixedLayout) // 是否图文混排
    theme.setImageDownloadImageWidthHeight(this.imageDownloadImageWidthHeight) // 图片下载按钮图片宽度和高度
    theme.setImageDownloadWidth(this.imageDownloadWidth) // 图片下载按钮宽度
    theme.setImageDownloadHeight(this.imageDownloadHeight) // 图片下载按钮高度
    theme.setImageDownloadRadius(this.imageDownloadRadius) // 图片下载按钮圆角
    theme.setImageDownloadText(this.imageDownloadText) // 图片下载按钮文本内容
    theme.setImageDownloadTextSize(this.imageDownloadTexSize) // 图片下载按钮文本大小
    if (this.imageDownloadTexColor !== undefined) {
      theme.setImageDownloadTextColor(this.imageDownloadTexColor) // 图片下载按钮文本颜色
    }
    if (this.imageDownloadBackgroundColor !== undefined) {
      theme.setImageDownloadBackgroundColor(this.imageDownloadBackgroundColor) // 图片下载按钮背景颜色
    }

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
    plugin.setIsImageStylePlugin(true) // 图片样式
    if (!this.isImageMixedLayout) {
      plugin.setIsImageTextMixPlugin(true) // 图片不混排插件
    }
    plugin.setIsImageCollectPlugin(true) // 图片视频url集合列表插件
    plugin.setIsHtmlPlugin(true) // HTML
    return plugin
  }

  setImageCallback(funcArg0: string, funcArg1: Array<string>) {
    hilog.error(1, "1", `-------------funcArg0:${funcArg0},funcArg1:${funcArg1}`)
  }

  async setImageCallbackCallback(funcArg0: string): Promise<ArrayBuffer | undefined> {
    hilog.error(1, "1", `-------------funcArg0:${funcArg0}`)
    return getFileContextArr("app_icon.png")
  }

  setImageDownloadCallback(funcArg0: string) {
    hilog.error(1, "1", `-------------funcArg0:${funcArg0}`)
  }
}