/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import { ListData } from './ListPage'
import hilog from '@ohos.hilog'

@Entry
@Component
struct ListDetailsPage {
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
   * 有序列表、无序列表、任务列表子模块上下间距
   */
  blockOrderedAndBulletTopAndBottomMargins: number = 0
  /**
   * 有序列表、无序列表、任务列表左边距
   */
  blockLeftMargin: number = 8
  /**
   * 有序列表、无序列表、任务列表右边距
   */
  blockRightMargin: number = 8
  /**
   * 有序列表前缀文本是否加粗
   */
  orderedListItemPrefixBold: boolean = false
  /**
   * 有序列表前缀文本颜色
   */
  orderedListItemColor: number = 0xFF191919
  /**
   * 有序列表前缀文本大小
   */
  orderedListItemSize: number = 14
  /**
   * 有序列表前缀文本行高
   */
  orderedListItemLineHeight: number = 22
  /**
   * 无序列表前缀是否全部是实心圆型
   */
  bulletListItemCircle: boolean = false
  /**
   * 无序列表前缀文本颜色
   */
  bulletListItemColor: number = 0xFF191919
  /**
   * 无序列表前缀文本大小
   */
  bulletListItemSize: number = 4
  /**
   * 无序列表前缀文本行高
   */
  bulletListItemLineHeight: number = 18
  /**
   * 任务列表选择框宽高
   */
  taskListItemLength: number = 15
  /**
   * 流式输入是否输入结束(true:结束输入,false:持续输入)
   */
  @State
  isInputEnded: boolean = false

  aboutToAppear(): void {
    try {
      let listData: ListData = router.getParams() as ListData
      this.fileStr = getFileContextStr(listData._pagePath)
      this.isFull = listData._isFull
      this.incrementalAnalysis = listData._incrementalAnalysis
      this.time = listData._time
      this.textNumber = listData._textNumber
      this.blockOrderedAndBulletTopAndBottomMargins = listData._blockOrderedAndBulletTopAndBottomMargins
      this.blockLeftMargin = listData._blockLeftMargin
      this.blockRightMargin = listData._blockRightMargin
      this.orderedListItemPrefixBold = listData._orderedListItemPrefixBold
      this.orderedListItemColor = listData._orderedListItemColor
      this.orderedListItemSize = listData._orderedListItemSize
      this.orderedListItemLineHeight = listData._orderedListItemLineHeight
      this.bulletListItemCircle = listData._bulletListItemCircle
      this.bulletListItemColor = listData._bulletListItemColor
      this.bulletListItemSize = listData._bulletListItemSize
      this.bulletListItemLineHeight = listData._bulletListItemLineHeight
      this.taskListItemLength = listData._taskListItemLength
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "有序、无序、任务列表测试用例",
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
        }
      }
      .padding({ bottom: 200 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    config.setImageCallback(this.imageCallback) // 图片点击回调
    config.setAudioCallback(this.audioCallback) // 音频点击回调
    config.setVideoCallback(this.videoCallback) // 视频点击回调
    config.setVideoImageCallback(this.videoImageCallback) // 视频占位图和宽高比和视频时长的回调
    config.setCodeCopyCallback(this.codeCopyCallback) // 代码复制点击回调
    config.setCodeFullScreenCallback(this.codeFullScreenCallback) // 代码全屏点击回调
    let theme = new MarkdownTheme()
    theme.setCodeFullScreenIcon($r('app.media.startIcon')) // 代码块全屏图片icon
    theme.setCodeCopyIcon($r('app.media.startIcon')) // 代码块复制图片icon
    theme.setAudioIcon($r('app.media.startIcon')) // 音频图片icon
    theme.setVideoImage($r('app.media.place_holder')) // 视频默认占位图
    theme.setPlayCircleFillIcon($r('app.media.play_circle_fill')) // 视频播放按钮icon
    theme.setBannerImage($r('app.media.place_holder')) // banner占位图
    theme.setImageResource($r('app.media.place_holder')) // 图片占位图
    theme.setBlockOrderedAndBulletTopAndBottomMargins(this.blockOrderedAndBulletTopAndBottomMargins) // 有序列表、无序列表、任务列表子模块上下间距
    theme.setBlockLeftMargin(this.blockLeftMargin) // 有序列表、无序列表、任务列表左边距
    theme.setBlockRightMargin(this.blockRightMargin) // 有序列表、无序列表、任务列表右边距
    theme.setOrderedListItemPrefixBold(this.orderedListItemPrefixBold) // 有序列表前缀文本是否加粗
    theme.setOrderedListItemColor(this.orderedListItemColor) // 有序列表前缀文本颜色
    theme.setOrderedListItemSize(this.orderedListItemSize) // 有序列表前缀文本大小
    theme.setOrderedListItemLineHeight(this.orderedListItemLineHeight) // 有序列表前缀文本行高
    theme.setBulletListItemCircle(this.bulletListItemCircle) // 无序列表前缀是否全部是实心圆型
    theme.setBulletListItemColor(this.bulletListItemColor) // 无序列表前缀文本颜色
    theme.setBulletListItemSize(this.bulletListItemSize) // 无序列表前缀文本大小
    theme.setBulletListItemLineHeight(this.bulletListItemLineHeight) // 无序列表前缀文本行高
    theme.setTaskListItemLength(this.taskListItemLength) // 任务列表选择框宽高
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsLatexMathPlugin(true) // 数学公式插件
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsLinkifyPlugin(true, []) // 自动链接插件
    plugin.setIsBlockAudioPlugin(true) // 音频插件
    plugin.setIsBlockVideoPlugin(true) // 视频插件
    plugin.setIsImageCollectPlugin(true) // 图片视频列表url集合列表解析插件
    plugin.setIsImageTextMixPlugin(true) // 图文不混排插件
    plugin.setIsImageSlidePlugin(true) // 图片banner
    plugin.setIsCodeListPlugin(true) // 代码块列表
    plugin.setIsImageStylePlugin(true) // 图片样式
    plugin.setIsTocPlugin(true) // TOC插件
    plugin.setIsFootnotePlugin(true) // 脚注
    plugin.setIsHtmlPlugin(true) // Html插件
    plugin.setIsLinkViewPlugin(true) // 链接单独块解析插件
    return plugin
  }

  linkCallBack(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  imageCallback(url: string, urlList: Array<string>): void {
    hilog.error(1, "1", `---url:${url},urlList:${urlList}`)
  }

  audioCallback(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  videoCallback(url: string, urlList: Array<string>): void {
    hilog.error(1, "1", `---url:${url},urlList:${urlList}`)
  }

  videoImageCallback(url: string, cb: (imageUrl: string, aspectRatio: number, time: number) => void): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  codeCopyCallback(code: string): void {
    hilog.error(1, "1", `---code:${code}`)
  }

  codeFullScreenCallback(code: string, type: string | undefined): void {
    hilog.error(1, "1", `---code:${code},type:${type}`)
  }

  latexCallBack(data: ArrayBuffer, heightNumber: number, widthNumber: number): void {
    hilog.error(1, "1", `---data.size:${data.byteLength},heightNumber:${heightNumber},widthNumber:${widthNumber}`)
  }

  tocIndexCallback(y: number | undefined): void {
    hilog.error(1, "1", `---y:${y}`)
  }

  footnoteCallback(y: number | undefined): void {
    hilog.error(1, "1", `---y:${y}`)
  }
}