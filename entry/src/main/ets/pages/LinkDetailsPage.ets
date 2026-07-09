import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown,
  GlobalTheme,
  LinkTheme,
  MarkdownConfiguration, MarkdownExposureEvent, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
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
  markdownScroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  @StorageProp('currentColorMode') // 深浅色模式
  currentColorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
  @State // 文件文本
  fileStr: string = ""
  @State // markdown文本
  content: string = ""
  @State // 是否全量加载Markdown文本
  isFull: boolean = true
  @State // 是否增量解析Markdown文本
  incrementalAnalysis: boolean = false
  @State // 是否启用解析节流
  enableParseThrottle: boolean = false
  @State // 解析节流间隔（ms）
  parseThrottleMs: number = 200
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
  globalBackgroundColor: ResourceColor | undefined = undefined
  @State // 是否允许markdown控件自身响应滑动
  openGestureSwipe: boolean = false
  @State // 是否开启响应滑动测试
  openGestureSwipeTest: boolean = false
  @State // 流式输入是否输入结束(true:结束输入,false:持续输入)
  isInputEnded: boolean = false

  // ---------- 专有
  @State // 是否加载链接自动解析插件
  isLinkifyPlugin: boolean = false
  @State // 链接是否是图片显示
  linkIsIcon: boolean = false
  @State // 列表中的单行链接是否是图片显示
  linkListIsIcon: boolean = false
  @State // 链接文本颜色
  linkTextFontColor: ResourceColor | undefined = undefined
  @State // 链接文本尺寸
  linkTextFontSize: number | string | Resource | undefined = undefined
  @State // 链接文本字体样式
  linkTextFontStyle: FontStyle | undefined = undefined
  @State // 链接文本字体粗细
  linkTextFontWeight: number | FontWeight | undefined = undefined
  @State // 链接文本字体
  linkTextFontFamily: string | Resource | undefined = undefined
  @State // 链接文本行高
  linkTextLineHeight: number | string | Resource | undefined = undefined
  @State // 链接文本字符间距
  linkTextLetterSpacing: number | undefined = undefined
  @State // 链接文本装饰线类型
  linkTextDecorationType: TextDecorationType = TextDecorationType.None
  @State // 链接文本装饰线颜色
  linkTextDecorationColor: ResourceColor | undefined = undefined
  @State // 链接文本装饰线样式
  linkTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID
  @State // 链接文本背景颜色
  linkTextBackgroundColor: ResourceColor | undefined = undefined
  @State // 链接文本背景左上圆角
  linkTextBackgroundRadiusTopLeft: Length = 0.0
  @State // 链接文本背景右上圆角
  linkTextBackgroundRadiusTopRight: Length = 0.0
  @State // 链接文本背景左下圆角
  linkTextBackgroundRadiusBottomLeft: Length = 0.0
  @State // 链接文本背景右下圆角
  linkTextBackgroundRadiusBottomRight: Length = 0.0
  @State // 圆形图片格式链接主题背景颜色
  linkCircleIconBackgroundColor: ResourceColor | undefined = undefined
  @State // 圆形图片格式链接控件背景颜色
  linkCircleIconButtonBackgroundColor: ResourceColor | undefined = undefined
  @State // 圆形图片格式链接文字大小
  linkCircleIconTextSize: number = 14.0
  @State // 圆形图片格式链接文字颜色
  linkCircleIconTextColor: ResourceColor | undefined = undefined
  @State // 圆形图片格式链接半径
  linkCircleIconRadius: number = 20.0
  @State // 圆形图片格式链接左右外边距
  linkCircleIconMargin: number = 6.0
  @State // 圆角矩形图片格式链接主题背景颜色
  linkRectIconBackgroundColor: ResourceColor | undefined = undefined
  @State // 圆角矩形图片格式链接控件背景颜色
  linkRectIconButtonBackgroundColor: ResourceColor | undefined = undefined
  @State // 圆角矩形图片格式链接文字大小
  linkRectIconTextSize: number = 14.0
  @State // 圆角矩形图片格式链接文字颜色
  linkRectIconTextColor: ResourceColor | undefined = undefined
  @State // 圆角矩形图片格式链接控件高度
  linkRectIconHeight: Length = 20.0
  @State // 圆角矩形图片格式链接左右内边距
  linkRectIconPadding: number = 6.0
  @State // 圆角矩形图片格式链接圆角半径
  linkRectIconRadius: number = 6.0
  @State // 圆角矩形图片格式链接左右外边距
  linkRectIconMargin: number = 6.0
  @State // 空心圆角矩形图片格式链接主题背景颜色
  linkRectToolIconBackgroundColor: ResourceColor | undefined = undefined
  @State // 空心圆角矩形图片格式链接控件背景颜色
  linkRectToolIconButtonBackgroundColor: ResourceColor | undefined = undefined
  @State // 空心圆角矩形图片格式链接文字大小
  linkRectToolIconTextSize: number = 14.0
  @State // 空心圆角矩形图片格式链接控件高度
  linkRectToolIconHeight: Length = 21.0
  @State // 空心圆角矩形图片格式链接左右内边距
  linkRectToolIconPadding: number = 6.0
  @State // 空心圆角矩形图片格式链接边框宽度
  linkRectToolIconBorderWidth: Length = 1.0
  @State // 空心圆角矩形图片格式链接分割线宽度
  linkRectToolIconDividingLineWidth: Length = 1.0
  @State // 空心圆角矩形图片格式链接左右外边距
  linkRectToolIconMargin: number = 6.0
  @State // 空心圆角矩形图片格式分割线和文本左边距
  linkRectToolIconLineLeftPadding: number = 3.0
  @State // 空心圆角矩形图片格式分割线和文本右边距
  linkRectToolIconLineRightPadding: number = 3.0

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let linkData: LinkData = router.getParams() as LinkData
      this.fileStr = getFileContextStr(linkData._pagePath)
      // ---------- 通用
      this.isFull = linkData._isFull
      this.incrementalAnalysis = linkData._incrementalAnalysis
      this.enableParseThrottle = linkData._enableParseThrottle
      this.parseThrottleMs = linkData._parseThrottleMs
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
      this.isLinkifyPlugin = linkData._isLinkifyPlugin
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

  build() {
    Column() {
      titleComponent(
        "链接配置详情",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Scroll(this.scroller) {
        if (this.openGestureSwipeTest) { // 允许滑动响应测试，生效前提高度设置为100%
          Column() {
            CJMarkdown({
              content: this.content,
              // isInputEnded: this.isInputEnded,
              // incrementalAnalysis: this.incrementalAnalysis,
              scroller: this.markdownScroller,
              config: this.markdownConfiguration,
              plugin: this.markdownPlugin
            })
          }.height("100%")
        } else {
          Column() {
            CJMarkdown({
              content: this.content,
              // isInputEnded: this.isInputEnded,
              scroller: this.markdownScroller,
              config: this.markdownConfiguration,
              plugin: this.markdownPlugin
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
    config.setLinkCallback(this.linkCallBack.bind(this)) // 链接点击回调
    config.setElementExposureCallback(this.elementExposureCallBack.bind(this)) // 元素曝光回调（链接显示/消失）
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
    let globalTheme: GlobalTheme = new GlobalTheme()
    if (this.globalBackgroundColor !== undefined) {
      globalTheme.setBackgroundColor(this.globalBackgroundColor)
    }
    globalTheme.setGlobalMargin({top: this.blockMarginTop, right: this.blockMarginRight, bottom: this.blockMarginBottom, left: this.blockMarginLeft})
    globalTheme.setBlockSpacing(this.markdownBlockSpacing)
    globalTheme.setIsLineBreak(this.isLineBreak)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    globalTheme.setEnableParseThrottle(this.enableParseThrottle)
    globalTheme.setParseThrottleMs(this.parseThrottleMs)
    theme.setGlobalTheme(globalTheme)
    
    // ---------- 专有 - Link
    let linkTheme = new LinkTheme()
    linkTheme.setLinkIsIcon(this.linkIsIcon)
    linkTheme.setLinkListIsIcon(this.linkListIsIcon)
    if (this.linkTextFontColor !== undefined) {
      linkTheme.setLinkTextFontColor(this.linkTextFontColor)
    }
    if (this.linkTextFontSize !== undefined) {
      linkTheme.setLinkTextFontSize(this.linkTextFontSize)
    }
    if (this.linkTextFontStyle !== undefined) {
      linkTheme.setLinkTextFontStyle(this.linkTextFontStyle)
    }
    if (this.linkTextFontWeight !== undefined) {
      linkTheme.setLinkTextFontWeight(this.linkTextFontWeight)
    }
    if (this.linkTextFontFamily !== undefined) {
      linkTheme.setLinkTextFontFamily(this.linkTextFontFamily)
    }
    if (this.linkTextLineHeight !== undefined) {
      linkTheme.setLinkTextLineHeight(this.linkTextLineHeight)
    }
    if (this.linkTextLetterSpacing !== undefined) {
      linkTheme.setLinkTextLetterSpacing(this.linkTextLetterSpacing)
    }
    linkTheme.setLinkTextDecorationType(this.linkTextDecorationType)
    if (this.linkTextDecorationColor !== undefined) {
      linkTheme.setLinkTextDecorationColor(this.linkTextDecorationColor)
    }
    linkTheme.setLinkTextDecorationStyle(this.linkTextDecorationStyle)
    if (this.linkTextBackgroundColor !== undefined) {
      linkTheme.setLinkTextBackgroundColor(this.linkTextBackgroundColor)
    }
    linkTheme.setLinkTextBackgroundRadius({topLeft: this.linkTextBackgroundRadiusTopLeft, topRight: this.linkTextBackgroundRadiusTopRight, bottomLeft: this.linkTextBackgroundRadiusBottomLeft, bottomRight: this.linkTextBackgroundRadiusBottomRight})
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
    theme.setLinkTheme(linkTheme)

    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    if (this.linkIsIcon) {
      plugin.setIsLinkViewPlugin(true) // 链接块状化插件
    } else if (this.isLinkifyPlugin) {
      plugin.setIsLinkifyPlugin(true) // 链接自动加载插件
    }
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsDescListPlugin(true) // 定义列表插件
    return plugin
  }

  linkCallBack(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  elementExposureCallBack(event: MarkdownExposureEvent): void {
    hilog.error(1, "1", `---elementExposure type:${event.type} visible:${event.visible} data:${event.data}`)
  }
}
