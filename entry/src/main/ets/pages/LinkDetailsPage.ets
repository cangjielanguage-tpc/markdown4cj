/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from './FileUtils'
import { LinkData } from './LinkPage'
import { hilog } from '@kit.PerformanceAnalysisKit'

@Entry
@Component
struct LinkDetailsPage {
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
   * 链接是否是图片显示
   */
  isLinkStyle: boolean = false
  /**
   * 列表中的单行链接是否是图片显示
   */
  isListLinkStyle: boolean = false
  /**
   * 文本格式链接文本颜色
   */
  linkColor: number = 0xFF0000FF
  /**
   * 文本格式链接文字大小
   */
  isLinkSize: boolean = true
  /**
   * 文本格式链接文字大小
   */
  linkSize: number = 14
  /**
   * 文本格式链接背景颜色
   */
  linkBackGroupColor: number = 0xFF000000
  /**
   * 文本格式是否显示链接下划线
   */
  isLinkUnderlined: boolean = true
  /**
   * 圆形图片格式链接主题背景颜色
   */
  linkCircleImageBackGroupColor: number = 0xFFFFFFFF
  /**
   * 圆形图片格式链接控件背景颜色
   */
  linkCircleImageButtonBackGroupColor: number = 0xFF000000
  /**
   * 圆形图片格式链接文字大小
   */
  linkCircleImageTextSize: number = 14
  /**
   * 圆形图片格式链接文字颜色
   */
  linkCircleImageTextColor: number = 0xFFFFFFFF
  /**
   * 圆形图片格式链接半径
   */
  linkCircleImageRadius: number = 20
  /**
   * 圆形图片格式链接左右外边距
   */
  linkCircleImageMargin: number = 6.0
  /**
   * 圆角矩形图片格式链接主题背景颜色
   */
  linkRectImageBackGroupColor: number = 0xFFFFFFFF
  /**
   * 圆角矩形图片格式链接控件背景颜色
   */
  linkRectImageButtonBackGroupColor: number = 0xFF000000
  /**
   * 圆角矩形图片格式链接文字大小
   */
  linkRectImageTextSize: number = 14
  /**
   * 圆角矩形图片格式链接文字颜色
   */
  linkRectImageTextColor: number = 0xFFFFFFFF
  /**
   * 圆角矩形图片格式链接控件高度
   */
  linkRectImageHeight: number = 20
  /**
   * 圆角矩形图片格式链接左右内边距
   */
  linkRectImagePadding: number = 6
  /**
   * 圆角矩形图片格式链接圆角半径
   */
  linkRectImageRadius: number = 6
  /**
   * 圆角矩形图片格式链接左右外边距
   */
  linkRectImageMargin: number = 6
  /**
   * 空心圆角矩形图片格式链接主题背景颜色
   */
  linkRectToolImageBackGroupColor: number = 0xFFFFFFFF
  /**
   * 空心圆角矩形图片格式链接控件背景颜色
   */
  linkRectToolImageButtonBackGroupColor: number = 0xFFFFFFFF
  /**
   * 空心圆角矩形图片格式链接控件边框颜色
   */
  linkRectToolImageButtonBorderColor: number = 0xFF000000
  /**
   * 空心圆角矩形图片格式链接控件分割线颜色
   */
  linkRectToolImageButtonDividingLineColor: number = 0xFF000000
  /**
   * 空心圆角矩形图片格式链接文字大小
   */
  linkRectToolImageTextSize: number = 14
  /**
   * 空心圆角矩形图片格式链接文字颜色
   */
  linkRectToolImageTextColor: number = 0xFF000000
  /**
   * 空心圆角矩形图片格式链接控件高度
   */
  linkRectToolImageHeight: number = 21
  /**
   * 空心圆角矩形图片格式链接左右内边距
   */
  linkRectToolImagePadding: number = 6
  /**
   * 空心圆角矩形图片格式链接边框宽度
   */
  linkRectToolImageBorderWidth: number = 1
  /**
   * 空心圆角矩形图片格式链接分割线宽度
   */
  linkRectToolImageDividingLineWidth: number = 1
  /**
   * 空心圆角矩形图片格式链接左右外边距
   */
  linkRectToolImageMargin: number = 6
  /**
   * 空心圆角矩形图片格式分割线和文本左边距
   */
  linkRectToolImageLineLeftPadding: number = 3
  /**
   * 空心圆角矩形图片格式分割线和文本右边距
   */
  linkRectToolImageLineRightPadding: number = 3
  /**
   * 增量加载延迟
   */
  time: number = 50

  aboutToAppear(): void {
    try {
      let linkData: LinkData = router.getParams() as LinkData
      this.fileStr = getFileContextStr(linkData._pagePath)
      this.isFull = linkData._isFull
      this.isLinkStyle = linkData._isLinkStyle
      this.isListLinkStyle = linkData._isListLinkStyle
      this.linkColor = linkData._linkColor
      this.isLinkSize = linkData._isLinkSize
      this.linkSize = linkData._linkSize
      this.linkBackGroupColor = linkData._linkBackGroupColor
      this.isLinkUnderlined = linkData._isLinkUnderlined
      this.linkCircleImageBackGroupColor = linkData._linkCircleImageBackGroupColor
      this.linkCircleImageButtonBackGroupColor = linkData._linkCircleImageButtonBackGroupColor
      this.linkCircleImageTextSize = linkData._linkCircleImageTextSize
      this.linkCircleImageTextColor = linkData._linkCircleImageTextColor
      this.linkCircleImageRadius = linkData._linkCircleImageRadius
      this.linkCircleImageMargin = linkData._linkCircleImageMargin
      this.linkRectImageBackGroupColor = linkData._linkRectImageBackGroupColor
      this.linkRectImageButtonBackGroupColor = linkData._linkRectImageButtonBackGroupColor
      this.linkRectImageTextSize = linkData._linkRectImageTextSize
      this.linkRectImageTextColor = linkData._linkRectImageTextColor
      this.linkRectImageHeight = linkData._linkRectImageHeight
      this.linkRectImagePadding = linkData._linkRectImagePadding
      this.linkRectImageRadius = linkData._linkRectImageRadius
      this.linkRectImageMargin = linkData._linkRectImageMargin
      this.linkRectToolImageBackGroupColor = linkData._linkRectToolImageBackGroupColor
      this.linkRectToolImageButtonBackGroupColor = linkData._linkRectToolImageButtonBackGroupColor
      this.linkRectToolImageTextSize = linkData._linkRectToolImageTextSize
      this.linkRectToolImageHeight = linkData._linkRectToolImageHeight
      this.linkRectToolImagePadding = linkData._linkRectToolImagePadding
      this.linkRectToolImageBorderWidth = linkData._linkRectToolImageBorderWidth
      this.linkRectToolImageDividingLineWidth = linkData._linkRectToolImageDividingLineWidth
      this.linkRectToolImageMargin = linkData._linkRectToolImageMargin
      this.linkRectToolImageLineLeftPadding = linkData._linkRectToolImageLineLeftPadding
      this.linkRectToolImageLineRightPadding = linkData._linkRectToolImageLineRightPadding
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "标题测试用例",
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
    let theme = new MarkdownTheme()
    theme.setIsLinkStyle(this.isLinkStyle)
    theme.setIsListLinkStyle(this.isListLinkStyle)
    theme.setLinkColor(this.linkColor)
    theme.setIsLinkSize(this.isLinkSize)
    theme.setLinkSize(this.linkSize)
    theme.setLinkBackGroupColor(this.linkBackGroupColor)
    theme.setIsLinkUnderlined(this.isLinkUnderlined)
    theme.setLinkCircleImageBackGroupColor(this.linkCircleImageBackGroupColor)
    theme.setLinkCircleImageButtonBackGroupColor(this.linkCircleImageButtonBackGroupColor)
    theme.setLinkCircleImageTextSize(this.linkCircleImageTextSize)
    theme.setLinkCircleImageTextColor(this.linkCircleImageTextColor)
    theme.setLinkCircleImageRadius(this.linkCircleImageRadius)
    theme.setLinkCircleImageMargin(this.linkCircleImageMargin)
    theme.setLinkRectImageBackGroupColor(this.linkRectImageBackGroupColor)
    theme.setLinkRectImageButtonBackGroupColor(this.linkRectImageButtonBackGroupColor)
    theme.setLinkRectImageTextSize(this.linkRectImageTextSize)
    theme.setLinkRectImageTextColor(this.linkRectImageTextColor)
    theme.setLinkRectImageHeight(this.linkRectImageHeight)
    theme.setLinkRectImagePadding(this.linkRectImagePadding)
    theme.setLinkRectImageRadius(this.linkRectImageRadius)
    theme.setLinkRectImageMargin(this.linkRectImageMargin)
    theme.setLinkRectToolImageBackGroupColor(this.linkRectToolImageBackGroupColor)
    theme.setLinkRectToolImageButtonBackGroupColor(this.linkRectToolImageButtonBackGroupColor)
    theme.setLinkRectToolImageTextSize(this.linkRectToolImageTextSize)
    theme.setLinkRectToolImageHeight(this.linkRectToolImageHeight)
    theme.setLinkRectToolImagePadding(this.linkRectToolImagePadding)
    theme.setLinkRectToolImageBorderWidth(this.linkRectToolImageBorderWidth)
    theme.setLinkRectToolImageDividingLineWidth(this.linkRectToolImageDividingLineWidth)
    theme.setLinkRectToolImageMargin(this.linkRectToolImageMargin)
    theme.setLinkRectToolImageLineLeftPadding(this.linkRectToolImageLineLeftPadding)
    theme.setLinkRectToolImageLineRightPadding(this.linkRectToolImageLineRightPadding)
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    if (this.isLinkStyle) {
      plugin.setIsLinkViewPlugin(true)
    } else {
      plugin.setIsLinkifyPlugin(true)
    }
    return plugin
  }

  linkCallBack(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }
}