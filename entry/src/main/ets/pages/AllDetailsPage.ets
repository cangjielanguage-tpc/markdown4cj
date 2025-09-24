/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from './FileUtils'
import { AllData } from './AllPage'
import { hilog } from '@kit.PerformanceAnalysisKit'

@Entry
@Component
struct AllDetailsPage {
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
   * 模块间上下间距
   */
  @State
  blockTopAndBottomMargins: number = 8
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
      let allData: AllData = router.getParams() as AllData
      this.fileStr = getFileContextStr(allData._pagePath)
      this.isFull = allData._isFull
      this.blockTopAndBottomMargins = allData._blockTopAndBottomMargins
      this.isDark = allData._isDark
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "综合测试用例",
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
    config.setLinkCallback(this.linkCallBack)
    config.setImageCallback(this.imageCallback)
    config.setAudioCallback(this.audioCallback)
    config.setVideoCallback(this.videoCallback)
    config.setVideoImageCallback(this.videoImageCallback)
    config.setCodeCopyCallback(this.codeCopyCallback)
    config.setCodeFullScreenCallback(this.codeFullScreenCallback)
    config.setLatexImageCallback(this.latexCallBack)
    config.setTocIndexCallback(this.tocIndexCallback)
    config.setFootnoteCallback(this.footnoteCallback)
    let theme = new MarkdownTheme()
    theme.setBlockTopAndBottomMargins(this.blockTopAndBottomMargins)
    theme.setIsDark(this.isDark)
    theme.setCodeFullScreenIcon($r('app.media.startIcon'))
    theme.setCodeCopyIcon($r('app.media.startIcon'))
    theme.setAudioIcon($r('app.media.startIcon'))
    theme.setVideoImage($r('app.media.place_holder'))
    theme.setPlayCircleFillIcon($r('app.media.play_circle_fill'))
    theme.setBannerImage($r('app.media.place_holder'))
    theme.setImageResource($r('app.media.place_holder'))
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsLatexMathPlugin(true) // 数学公式插件
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsLinkifyPlugin(true) // 自动链接插件
    plugin.setIsBlockAudioPlugin(true) // 音频插件
    plugin.setIsBlockVideoPlugin(true) // 视频插件
    plugin.setIsImageCollectPlugin(true) // 图片视频列表url集合列表解析插件
    plugin.setIsImageSinglePlugin(true) // 图片单独提取到block解析插件
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