import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme,
  MarkdownThemeLink,
  MarkdownThemeGlobal } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { LinkData } from '../model/LinkData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct LinkDetailsPage {
  // ---------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // Markdown的控制器
  markdownScroller: MarkdownScroller = new MarkdownScroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  @StorageProp('currentColorMode')
  @Watch('onColorModeChange') // 深浅色模式
  currentColorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
  @State // 文件文本
  fileStr: string = ""
  @State // markdown文本
  content: string = ""
  @State // 是否全量加载Markdown文本
  isFull: boolean = true
  @State // 是否增量解析Markdown文本
  incrementalAnalysis: boolean = false
  @State // 增量加载每次间隔时间
  time: number = 50
  @State // 增量每次增量文本数量
  textNumber: number = 10
  @State // 是否同步解析Markdown文本
  isMarkdownParserSync: boolean = false
  @State // 是否打开长按复制粘贴效果
  isOnCopy: boolean = false
  @State // Markdown块上边距
  blockMarginTop: number = 8
  @State // Markdown块右边距
  blockMarginRight: number = 8
  @State // Markdown块下边距
  blockMarginBottom: number = 8
  @State // Markdown块左边距
  blockMarginLeft: number = 8
  @State // Markdown块间距样式
  markdownBlockSpacing: number = 8
  @State // 是否换行
  isLineBreak: boolean = false
  @State // 全局背景色
  globalBackgroundColor: number | undefined = undefined
  @State // 是否允许markdown控件自身响应滑动
  openGestureSwipe: boolean = false
  @State // 是否开启响应滑动测试
  openGestureSwipeTest: boolean = false
  @State // 流式输入是否输入结束(true:结束输入,false:持续输入)
  isInputEnded: boolean = false

  // ---------- 专有
  @State // 链接是否是图片显示
  linkIsIcon: boolean = false
  @State // 列表中的单行链接是否是图片显示
  linkListIsIcon: boolean = false
  @State // 链接文本颜色
  linkTextFontColor: number | undefined = undefined
  @State // 链接文本尺寸
  linkTextFontSize: number = 14
  @State // 链接文本字体样式
  linkTextFontStyle: FontStyle = FontStyle.Normal
  @State // 链接文本字体粗细
  linkTextFontWeight: FontWeight = FontWeight.Normal
  @State // 链接文本字体
  linkTextFontFamily: string = 'HarmonyOS Sans'
  @State // 链接文本行高
  linkTextLineHeight: number = 22
  @State // 链接文本字符间距
  linkTextLetterSpacing: number = 0
  @State // 链接文本装饰线类型
  linkTextDecorationType: TextDecorationType = TextDecorationType.None
  @State // 链接文本装饰线颜色
  linkTextDecorationColor: number | undefined = undefined
  @State // 链接文本装饰线样式
  linkTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID
  @State // 链接文本背景颜色
  linkTextBackgroundColor: number | undefined = undefined
  @State // 链接文本背景左上圆角
  linkTextBackgroundRadiusTopLeft: number = 0
  @State // 链接文本背景右上圆角
  linkTextBackgroundRadiusTopRight: number = 0
  @State // 链接文本背景左下圆角
  linkTextBackgroundRadiusBottomLeft: number = 0
  @State // 链接文本背景右下圆角
  linkTextBackgroundRadiusBottomRight: number = 0
  @State // 圆形图片格式链接主题背景颜色
  linkCircleIconBackgroundColor: number | undefined = undefined
  @State // 圆形图片格式链接控件背景颜色
  linkCircleIconButtonBackgroundColor: number | undefined = undefined
  @State // 圆形图片格式链接文字大小
  linkCircleIconTextSize: number = 14
  @State // 圆形图片格式链接文字颜色
  linkCircleIconTextColor: number | undefined = undefined
  @State // 圆形图片格式链接半径
  linkCircleIconRadius: number = 20
  @State // 圆形图片格式链接左右外边距
  linkCircleIconMargin: number = 6
  @State // 圆角矩形图片格式链接主题背景颜色
  linkRectIconBackgroundColor: number | undefined = undefined
  @State // 圆角矩形图片格式链接控件背景颜色
  linkRectIconButtonBackgroundColor: number | undefined = undefined
  @State // 圆角矩形图片格式链接文字大小
  linkRectIconTextSize: number = 14
  @State // 圆角矩形图片格式链接文字颜色
  linkRectIconTextColor: number | undefined = undefined
  @State // 圆角矩形图片格式链接控件高度
  linkRectIconHeight: number = 20
  @State // 圆角矩形图片格式链接左右内边距
  linkRectIconPadding: number = 6
  @State // 圆角矩形图片格式链接圆角半径
  linkRectIconRadius: number = 6
  @State // 圆角矩形图片格式链接左右外边距
  linkRectIconMargin: number = 6
  @State // 空心圆角矩形图片格式链接主题背景颜色
  linkRectToolIconBackgroundColor: number | undefined = undefined
  @State // 空心圆角矩形图片格式链接控件背景颜色
  linkRectToolIconButtonBackgroundColor: number | undefined = undefined
  @State // 空心圆角矩形图片格式链接文字大小
  linkRectToolIconTextSize: number = 14
  @State // 空心圆角矩形图片格式链接控件高度
  linkRectToolIconHeight: number = 21
  @State // 空心圆角矩形图片格式链接左右内边距
  linkRectToolIconPadding: number = 6
  @State // 空心圆角矩形图片格式链接边框宽度
  linkRectToolIconBorderWidth: number = 1
  @State // 空心圆角矩形图片格式链接分割线宽度
  linkRectToolIconDividingLineWidth: number = 1
  @State // 空心圆角矩形图片格式链接左右外边距
  linkRectToolIconMargin: number = 6
  @State // 空心圆角矩形图片格式分割线和文本左边距
  linkRectToolIconLineLeftPadding: number = 3
  @State // 空心圆角矩形图片格式分割线和文本右边距
  linkRectToolIconLineRightPadding: number = 3

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()
  @State // 刷新标志
  isRefresh: boolean = true

  onColorModeChange(): void {
    // 根据 this.currentColorMode 更新 UI 或状态栏
    if (this.currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      // 浅色模式处理
      this.markdownTheme.setDefaultTheme()
      this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
      hilog.error(1, 'onColorModeChange', '浅色模式')
    } else {
      // 深色模式处理
      this.markdownTheme.setDarculaTheme()
      this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
      hilog.error(1, 'onColorModeChange', '深色模式')
    }
    this.isRefresh = !this.isRefresh
  }

  aboutToAppear(): void {
    try {
      let linkData: LinkData = router.getParams() as LinkData
      this.fileStr = getFileContextStr(linkData._pagePath)
      // ---------- 通用
      this.isFull = linkData._isFull
      this.incrementalAnalysis = linkData._incrementalAnalysis
      this.time = linkData._time
      this.textNumber = linkData._textNumber
      this.isMarkdownParserSync = linkData._isMarkdownParserSync
      this.isOnCopy = linkData._isOnCopy
      this.blockMarginTop = linkData._blockMarginTop
      this.blockMarginRight = linkData._blockMarginRight
      this.blockMarginBottom = linkData._blockMarginBottom
      this.blockMarginLeft = linkData._blockMarginLeft
      this.markdownBlockSpacing = linkData._markdownBlockSpacing
      this.isLineBreak = linkData._isLineBreak
      this.globalBackgroundColor = linkData._backgroundColor
      this.openGestureSwipe = linkData._openGestureSwipe
      this.openGestureSwipeTest = linkData._openGestureSwipeTest
      // ---------- 专有
      this.linkIsIcon = linkData._linkIsIcon
      this.linkListIsIcon = linkData._linkListIsIcon
      this.linkTextFontColor = linkData._linkTextFontColor
      this.linkTextFontSize = linkData._linkTextFontSize
      this.linkTextFontStyle = linkData._linkTextFontStyle
      this.linkTextFontWeight = linkData._linkTextFontWeight
      this.linkTextFontFamily = linkData._linkTextFontFamily
      this.linkTextLineHeight = linkData._linkTextLineHeight
      this.linkTextLetterSpacing = linkData._linkTextLetterSpacing
      this.linkTextDecorationType = linkData._linkTextDecorationType
      this.linkTextDecorationColor = linkData._linkTextDecorationColor
      this.linkTextDecorationStyle = linkData._linkTextDecorationStyle
      this.linkTextBackgroundColor = linkData._linkTextBackgroundColor
      this.linkTextBackgroundRadiusTopLeft = linkData._linkTextBackgroundRadiusTopLeft
      this.linkTextBackgroundRadiusTopRight = linkData._linkTextBackgroundRadiusTopRight
      this.linkTextBackgroundRadiusBottomLeft = linkData._linkTextBackgroundRadiusBottomLeft
      this.linkTextBackgroundRadiusBottomRight = linkData._linkTextBackgroundRadiusBottomRight
      this.linkCircleIconBackgroundColor = linkData._linkCircleIconBackgroundColor
      this.linkCircleIconButtonBackgroundColor = linkData._linkCircleIconButtonBackgroundColor
      this.linkCircleIconTextSize = linkData._linkCircleIconTextSize
      this.linkCircleIconTextColor = linkData._linkCircleIconTextColor
      this.linkCircleIconRadius = linkData._linkCircleIconRadius
      this.linkCircleIconMargin = linkData._linkCircleIconMargin
      this.linkRectIconBackgroundColor = linkData._linkRectIconBackgroundColor
      this.linkRectIconButtonBackgroundColor = linkData._linkRectIconButtonBackgroundColor
      this.linkRectIconTextSize = linkData._linkRectIconTextSize
      this.linkRectIconTextColor = linkData._linkRectIconTextColor
      this.linkRectIconHeight = linkData._linkRectIconHeight
      this.linkRectIconPadding = linkData._linkRectIconPadding
      this.linkRectIconRadius = linkData._linkRectIconRadius
      this.linkRectIconMargin = linkData._linkRectIconMargin
      this.linkRectToolIconBackgroundColor = linkData._linkRectToolIconBackgroundColor
      this.linkRectToolIconButtonBackgroundColor = linkData._linkRectToolIconButtonBackgroundColor
      this.linkRectToolIconTextSize = linkData._linkRectToolIconTextSize
      this.linkRectToolIconHeight = linkData._linkRectToolIconHeight
      this.linkRectToolIconPadding = linkData._linkRectToolIconPadding
      this.linkRectToolIconBorderWidth = linkData._linkRectToolIconBorderWidth
      this.linkRectToolIconDividingLineWidth = linkData._linkRectToolIconDividingLineWidth
      this.linkRectToolIconMargin = linkData._linkRectToolIconMargin
      this.linkRectToolIconLineLeftPadding = linkData._linkRectToolIconLineLeftPadding
      this.linkRectToolIconLineRightPadding = linkData._linkRectToolIconLineRightPadding
    } catch (e) {
    }
    this.markdownPlugin = this.setPlugin()
    this.markdownTheme = this.setMarkdownTheme()
    this.markdownConfiguration = this.setMarkdownConfig()
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
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
        if (this.isRefresh) {
          if (this.openGestureSwipeTest) { // 允许滑动响应测试，生效前提高度设置为100%
            Column() {
              CJMarkdown({
                content: this.content,
                isInputEnded: this.isInputEnded,
                incrementalAnalysis: this.incrementalAnalysis,
                listScroller: this.markdownScroller,
                config: this.markdownConfiguration,
                plugin: this.markdownPlugin
              })
            }.height("100%")
          } else {
            Column() {
              CJMarkdown({
                content: this.content,
                isInputEnded: this.isInputEnded,
                listScroller: this.markdownScroller,
                config: this.markdownConfiguration,
                plugin: this.markdownPlugin
              })
            }
          }
        } else {
          if (this.openGestureSwipeTest) { // 允许滑动响应测试，生效前提高度设置为100%
            Column() {
              CJMarkdown({
                content: this.content,
                isInputEnded: this.isInputEnded,
                incrementalAnalysis: this.incrementalAnalysis,
                listScroller: this.markdownScroller,
                config: this.markdownConfiguration,
                plugin: this.markdownPlugin
              })
            }.height("100%")
          } else {
            Column() {
              CJMarkdown({
                content: this.content,
                isInputEnded: this.isInputEnded,
                listScroller: this.markdownScroller,
                config: this.markdownConfiguration,
                plugin: this.markdownPlugin
              })
            }
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
    config.setLinkCallback(this.linkCallBack.bind(this)) // 链接点击回调
    return config
  }

  setMarkdownTheme(): MarkdownTheme {
    let theme = new MarkdownTheme()
    if (this.currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      theme.setDefaultTheme()
    } else {
      theme.setDarculaTheme()
    }
    // ---------- 通用 - Global
    let globalTheme = new MarkdownThemeGlobal()
    if (this.globalBackgroundColor !== undefined) {
      globalTheme.setBackgroundColor(this.globalBackgroundColor)
    }
    globalTheme.setGlobalMargin(this.blockMarginTop, this.blockMarginRight, this.blockMarginBottom, this.blockMarginLeft)
    globalTheme.setBlockSpacing(this.markdownBlockSpacing)
    globalTheme.setIsLineBreak(this.isLineBreak)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.setMarkdownThemeGlobal(globalTheme)
    
    // ---------- 专有 - Link
    let linkTheme = new MarkdownThemeLink()
    linkTheme.setLinkIsIcon(this.linkIsIcon)
    linkTheme.setLinkListIsIcon(this.linkListIsIcon)
    if (this.linkTextFontColor !== undefined) {
      linkTheme.setLinkTextFontColor(this.linkTextFontColor)
    }
    linkTheme.setLinkTextFontSize(this.linkTextFontSize)
    linkTheme.setLinkTextFontStyle(this.linkTextFontStyle)
    linkTheme.setLinkTextFontWeight(this.linkTextFontWeight)
    linkTheme.setLinkTextFontFamily(this.linkTextFontFamily)
    linkTheme.setLinkTextLineHeight(this.linkTextLineHeight)
    linkTheme.setLinkTextLetterSpacing(this.linkTextLetterSpacing)
    linkTheme.setLinkTextDecorationType(this.linkTextDecorationType)
    if (this.linkTextDecorationColor !== undefined) {
      linkTheme.setLinkTextDecorationColor(this.linkTextDecorationColor)
    }
    linkTheme.setLinkTextDecorationStyle(this.linkTextDecorationStyle)
    if (this.linkTextBackgroundColor !== undefined) {
      linkTheme.setLinkTextBackgroundColor(this.linkTextBackgroundColor)
    }
    linkTheme.setLinkTextBackgroundRadius(this.linkTextBackgroundRadiusTopLeft, this.linkTextBackgroundRadiusTopRight, this.linkTextBackgroundRadiusBottomLeft, this.linkTextBackgroundRadiusBottomRight)
    if (this.linkCircleIconBackgroundColor !== undefined) {
      linkTheme.setLinkCircleIconBackgroundColor(this.linkCircleIconBackgroundColor)
    }
    if (this.linkCircleIconButtonBackgroundColor !== undefined) {
      linkTheme.setLinkCircleIconButtonBackgroundColor(this.linkCircleIconButtonBackgroundColor)
    }
    linkTheme.setLinkCircleIconTextSize(this.linkCircleIconTextSize)
    if (this.linkCircleIconTextColor !== undefined) {
      linkTheme.setLinkCircleIconTextColor(this.linkCircleIconTextColor)
    }
    linkTheme.setLinkCircleIconRadius(this.linkCircleIconRadius)
    linkTheme.setLinkCircleIconMargin(this.linkCircleIconMargin)
    if (this.linkRectIconBackgroundColor !== undefined) {
      linkTheme.setLinkRectIconBackgroundColor(this.linkRectIconBackgroundColor)
    }
    if (this.linkRectIconButtonBackgroundColor !== undefined) {
      linkTheme.setLinkRectIconButtonBackgroundColor(this.linkRectIconButtonBackgroundColor)
    }
    linkTheme.setLinkRectIconTextSize(this.linkRectIconTextSize)
    if (this.linkRectIconTextColor !== undefined) {
      linkTheme.setLinkRectIconTextColor(this.linkRectIconTextColor)
    }
    linkTheme.setLinkRectIconHeight(this.linkRectIconHeight)
    linkTheme.setLinkRectIconPadding(this.linkRectIconPadding)
    linkTheme.setLinkRectIconRadius(this.linkRectIconRadius)
    linkTheme.setLinkRectIconMargin(this.linkRectIconMargin)
    if (this.linkRectToolIconBackgroundColor !== undefined) {
      linkTheme.setLinkRectToolIconBackgroundColor(this.linkRectToolIconBackgroundColor)
    }
    if (this.linkRectToolIconButtonBackgroundColor !== undefined) {
      linkTheme.setLinkRectToolIconButtonBackgroundColor(this.linkRectToolIconButtonBackgroundColor)
    }
    linkTheme.setLinkRectToolIconTextSize(this.linkRectToolIconTextSize)
    linkTheme.setLinkRectToolIconHeight(this.linkRectToolIconHeight)
    linkTheme.setLinkRectToolIconPadding(this.linkRectToolIconPadding)
    linkTheme.setLinkRectToolIconBorderWidth(this.linkRectToolIconBorderWidth)
    linkTheme.setLinkRectToolIconDividingLineWidth(this.linkRectToolIconDividingLineWidth)
    linkTheme.setLinkRectToolIconMargin(this.linkRectToolIconMargin)
    linkTheme.setLinkRectToolIconLineLeftPadding(this.linkRectToolIconLineLeftPadding)
    linkTheme.setLinkRectToolIconLineRightPadding(this.linkRectToolIconLineRightPadding)
    theme.setMarkdownThemeLink(linkTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    if (this.linkIsIcon) {
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
