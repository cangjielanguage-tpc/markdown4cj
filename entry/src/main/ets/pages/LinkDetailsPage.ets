/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import { LinkData } from './LinkPage'
import hilog from '@ohos.hilog'

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
  linkBackGroupColor: number = 0x00000000
  /**
   * 文本格式是否显示链接下划线
   */
  isLinkUnderlined: boolean = true
  /**
   * 圆形图片格式链接主题背景颜色
   */
  linkCircleImageBackGroupColor: number = 0x00000000
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
  linkRectImageBackGroupColor: number = 0x00000000
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
  linkRectToolImageBackGroupColor: number = 0x00000000
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
   * 流式输入是否输入结束(true:结束输入,false:持续输入)
   */
  @State
  isInputEnded: boolean = false
  /**
   * markdown是否同步解析
   */
  @State
  isMarkdownParserSync: boolean = false
  /**
   * 是否开启打字机效果
   */
  @State
  typeWriterOpen: boolean = false
  /**
   * 打字机效果颜色
   */
  @State
  typeWriterColor: number = 0xFFFF0000
  /**
   * 是否打开长按复制粘贴
   */
  @State
  isOnCopy: boolean = false
  /**
   * markdown第一个模块上边距
   */
  @State
  blockFirstTopMargin: number = 8
  /**
   * markdown最后一个模块下边距
   */
  @State
  blockLastBottomMargin: number = 8
  /**
   * 模块间上下间距
   */
  @State
  blockTopAndBottomMargins: number = 8
  /**
   * 文本格式链接文字行高
   */
  @State
  linkLineHeight: number = 22

  aboutToAppear(): void {
    try {
      let linkData: LinkData = router.getParams() as LinkData
      this.fileStr = getFileContextStr(linkData._pagePath)
      this.isFull = linkData._isFull
      this.incrementalAnalysis = linkData._incrementalAnalysis
      this.time = linkData._time
      this.textNumber = linkData._textNumber
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
      this.isMarkdownParserSync = linkData._isMarkdownParserSync
      this.typeWriterOpen = linkData._typeWriterOpen
      this.typeWriterColor = linkData._typeWriterColor
      this.isOnCopy = linkData._isOnCopy
      this.blockFirstTopMargin = linkData._blockFirstTopMargin
      this.blockLastBottomMargin = linkData._blockLastBottomMargin
      this.blockTopAndBottomMargins = linkData._blockTopAndBottomMargins
      this.linkLineHeight = linkData._linkLineHeight
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
        .height(40)
        .width("80%")
        .type(ButtonType.Capsule)
        .margin({ top: 5, bottom: 5 })
        .fontColor(0xFFFFFFFF)
        .backgroundColor(0xFF317AFF)
        .align(Alignment.Center)
        .fontSize(16)
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
    config.setLinkCallback(this.linkCallBack.bind(this)) // 链接点击回调
    let theme = new MarkdownTheme()
    theme.setContext(getContext(this)) // 上下文
    theme.setIsLinkStyle(this.isLinkStyle) // 链接是否是图片显示
    theme.setIsListLinkStyle(this.isListLinkStyle) // 列表中的单行链接是否是图片显示
    theme.setLinkColor(this.linkColor) // 文本格式链接文本颜色
    theme.setIsLinkSize(this.isLinkSize) // 是否按照链接文本字体大小显示文本
    theme.setLinkSize(this.linkSize) // 文本格式链接文字大小
    theme.setLinkBackGroupColor(this.linkBackGroupColor) // 文本格式链接背景颜色
    theme.setIsLinkUnderlined(this.isLinkUnderlined) // 文本格式是否显示链接下划线
    theme.setLinkCircleImageBackGroupColor(this.linkCircleImageBackGroupColor) // 圆形图片格式链接主题背景颜色
    theme.setLinkCircleImageButtonBackGroupColor(this.linkCircleImageButtonBackGroupColor) // 圆形图片格式链接控件背景颜色
    theme.setLinkCircleImageTextSize(this.linkCircleImageTextSize) // 圆形图片格式链接文字大小
    theme.setLinkCircleImageTextColor(this.linkCircleImageTextColor) // 圆形图片格式链接文字颜色
    theme.setLinkCircleImageRadius(this.linkCircleImageRadius) // 圆形图片格式链接半径
    theme.setLinkCircleImageMargin(this.linkCircleImageMargin) // 圆形图片格式链接左右外边距
    theme.setLinkRectImageBackGroupColor(this.linkRectImageBackGroupColor) // 圆角矩形图片格式链接主题背景颜色
    theme.setLinkRectImageButtonBackGroupColor(this.linkRectImageButtonBackGroupColor) // 圆角矩形图片格式链接控件背景颜色
    theme.setLinkRectImageTextSize(this.linkRectImageTextSize) // 圆角矩形图片格式链接文字大小
    theme.setLinkRectImageTextColor(this.linkRectImageTextColor) // 圆角矩形图片格式链接文字颜色
    theme.setLinkRectImageHeight(this.linkRectImageHeight) // 圆角矩形图片格式链接控件高度
    theme.setLinkRectImagePadding(this.linkRectImagePadding) // 圆角矩形图片格式链接左右内边距
    theme.setLinkRectImageRadius(this.linkRectImageRadius) // 圆角矩形图片格式链接圆角半径
    theme.setLinkRectImageMargin(this.linkRectImageMargin) // 圆角矩形图片格式链接左右外边距
    theme.setLinkRectToolImageBackGroupColor(this.linkRectToolImageBackGroupColor) // 空心圆角矩形图片格式链接主题背景颜色
    theme.setLinkRectToolImageButtonBackGroupColor(this.linkRectToolImageButtonBackGroupColor) // 空心圆角矩形图片格式链接控件背景颜色
    theme.setLinkRectToolImageTextSize(this.linkRectToolImageTextSize) // 空心圆角矩形图片格式链接文字大小
    theme.setLinkRectToolImageHeight(this.linkRectToolImageHeight) // 空心圆角矩形图片格式链接控件高度
    theme.setLinkRectToolImagePadding(this.linkRectToolImagePadding) // 空心圆角矩形图片格式链接左右内边距
    theme.setLinkRectToolImageBorderWidth(this.linkRectToolImageBorderWidth) // 空心圆角矩形图片格式链接边框宽度
    theme.setLinkRectToolImageDividingLineWidth(this.linkRectToolImageDividingLineWidth) // 空心圆角矩形图片格式链接分割线宽度
    theme.setLinkRectToolImageMargin(this.linkRectToolImageMargin) // 空心圆角矩形图片格式链接左右外边距
    theme.setLinkRectToolImageLineLeftPadding(this.linkRectToolImageLineLeftPadding) // 空心圆角矩形图片格式分割线和文本左边距
    theme.setLinkRectToolImageLineRightPadding(this.linkRectToolImageLineRightPadding) // 空心圆角矩形图片格式分割线和文本右边距
    theme.setIsMarkdownParserSync(this.isMarkdownParserSync) // markdown是否同步解析
    theme.setTypeWriterOpen(this.typeWriterOpen) // 是否开启打字机效果
    theme.setTypeWriterColor(this.typeWriterColor) // 打字机效果颜色
    theme.setIsOnCopy(this.isOnCopy) // 是否打开长按复制粘贴
    theme.setBlockFirstTopMargin(this.blockFirstTopMargin) // markdown第一个模块上边距
    theme.setBlockLastBottomMargin(this.blockLastBottomMargin) // markdown最后一个模块下边距
    theme.setBlockTopAndBottomMargins(this.blockTopAndBottomMargins) // 模块间上下间距
    theme.setLinkLineHeight(this.linkLineHeight) // 文本格式链接文字行高
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    if (this.isLinkStyle) {
      plugin.setIsLinkViewPlugin(true) // 链接块状化插件
    } else {
      plugin.setIsLinkifyPlugin(true, []) // 链接自动加载插件
    }
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsDescListPlugin(true) // 定义列表插件
    return plugin
  }

  linkCallBack(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }
}