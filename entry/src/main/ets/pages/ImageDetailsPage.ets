/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from './FileUtils'
import { ImageDataMD } from './ImagePage'
import hilog from '@ohos.hilog'

@Entry
@Component
struct ImageDetailsPage {
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
   * 图片默认占位图
   */
  @State
  imageResource: Resource | null = null
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
   * 图片基于自身宽度缩放百分比
   */
  @State
  imageMaximumWidth: number = 1.0
  /**
   * 图片基于父布局宽度缩放百分比
   */
  @State
  imageFixedRatioWidth: number| null = null
  /**
   * 增量加载延迟
   */
  time: number = 50

  aboutToAppear(): void {
    try {
      let imageDataMD: ImageDataMD = router.getParams() as ImageDataMD
      this.fileStr = getFileContextStr(imageDataMD._pagePath)
      this.isFull = imageDataMD._isFull
      this.imageResource = imageDataMD._imageResource
      this.imageMarginTop = imageDataMD._imageMarginTop
      this.imageMarginBottom = imageDataMD._imageMarginBottom
      this.imageBorderRadius = imageDataMD._imageBorderRadius
      this.imageMaximumWidth = imageDataMD._imageMaximumWidth
      this.imageFixedRatioWidth = imageDataMD._imageFixedRatioWidth
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
        Column() {
          CJMarkdown({
            content: this.content,
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
    config.setImageCallback(this.setImageCallback)
    let theme = new MarkdownTheme()
    theme.setContext(getContext(this))
    if (this.imageResource !== null) {
      theme.setImageResource(this.imageResource)
    }
    theme.setImageMarginTop(this.imageMarginTop)
    theme.setImageMarginBottom(this.imageMarginBottom)
    theme.setImageBorderRadius(this.imageBorderRadius)
    theme.setImageMaximumWidth(this.imageMaximumWidth)
    if (this.imageFixedRatioWidth !== null) {
      theme.setImageFixedRatioWidth(this.imageFixedRatioWidth)
    }
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    // plugin.setIsImageSinglePlugin(true) // 图片单独提取到block解析插件
    plugin.setIsImageStylePlugin(true) // 图片样式
    plugin.setIsHtmlPlugin(true) // HTML
    return plugin
  }

  setImageCallback(funcArg0: string, funcArg1: Array<string>) {
    hilog.error(1, "1", `-------------funcArg0:${funcArg0}`)
  }
}