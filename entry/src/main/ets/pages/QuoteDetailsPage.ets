import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import {
  BlockQuoteTheme,
  CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_arkui'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { QuoteData } from '../model/QuoteData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct QuoteDetailsPage {
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
  @State // 块引用背景颜色
  blockQuoteBackgroundColor: ResourceColor | undefined = undefined
  @State // 块引用上外边距
  blockQuoteMarginTop: Length = 0.0
  @State // 块引用右外边距
  blockQuoteMarginRight: Length = 0.0
  @State // 块引用下外边距
  blockQuoteMarginBottom: Length = 0.0
  @State // 块引用左外边距
  blockQuoteMarginLeft: Length = 8.0
  @State // 块引用上内边距
  blockQuotePaddingTop: Length = 0.0
  @State // 块引用右内边距
  blockQuotePaddingRight: Length = 0.0
  @State // 块引用下内边距
  blockQuotePaddingBottom: Length = 0.0
  @State // 块引用左内边距
  blockQuotePaddingLeft: Length = 8.0
  @State // 块引用边框左上圆角
  blockQuoteRadiusTopLeft: Length = 0.0
  @State // 块引用边框右上圆角
  blockQuoteRadiusTopRight: Length = 0.0
  @State // 块引用边框左下圆角
  blockQuoteRadiusBottomLeft: Length = 0.0
  @State // 块引用边框右下圆角
  blockQuoteRadiusBottomRight: Length = 0.0
  @State // 块引用左侧边框宽度
  blockQuoteLeftBorderWidth: Length = 1.0
  @State // 块引用左侧边框颜色
  blockQuoteLeftBorderColor: ResourceColor | undefined = undefined
  @State // 块引用子模块上下间距
  blockQuoteChildSpacing: number = 8.0

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let quoteData: QuoteData = router.getParams() as QuoteData
      this.fileStr = getFileContextStr(quoteData._pagePath)
      // ---------- 通用
      this.isFull = quoteData._isFull
      this.incrementalAnalysis = quoteData._incrementalAnalysis
      this.enableParseThrottle = quoteData._enableParseThrottle
      this.parseThrottleMs = quoteData._parseThrottleMs
      this.time = quoteData._time
      this.textNumber = quoteData._textNumber
      this.isMarkdownParserSync = quoteData._isMarkdownParserSync
      this.isOnCopy = quoteData._isOnCopy
      this.blockMarginTop = quoteData._blockMarginTop
      this.blockMarginRight = quoteData._blockMarginRight
      this.blockMarginBottom = quoteData._blockMarginBottom
      this.blockMarginLeft = quoteData._blockMarginLeft
      this.markdownBlockSpacing = quoteData._markdownBlockSpacing
      this.isLineBreak = quoteData._isLineBreak
      this.globalBackgroundColor = quoteData._backgroundColor
      this.openGestureSwipe = quoteData._openGestureSwipe
      this.openGestureSwipeTest = quoteData._openGestureSwipeTest
      // ---------- 专有
      this.blockQuoteBackgroundColor = quoteData._blockQuoteBackgroundColor
      this.blockQuoteMarginTop = quoteData._blockQuoteMarginTop
      this.blockQuoteMarginRight = quoteData._blockQuoteMarginRight
      this.blockQuoteMarginBottom = quoteData._blockQuoteMarginBottom
      this.blockQuoteMarginLeft = quoteData._blockQuoteMarginLeft
      this.blockQuotePaddingTop = quoteData._blockQuotePaddingTop
      this.blockQuotePaddingRight = quoteData._blockQuotePaddingRight
      this.blockQuotePaddingBottom = quoteData._blockQuotePaddingBottom
      this.blockQuotePaddingLeft = quoteData._blockQuotePaddingLeft
      this.blockQuoteRadiusTopLeft = quoteData._blockQuoteRadiusTopLeft
      this.blockQuoteRadiusTopRight = quoteData._blockQuoteRadiusTopRight
      this.blockQuoteRadiusBottomLeft = quoteData._blockQuoteRadiusBottomLeft
      this.blockQuoteRadiusBottomRight = quoteData._blockQuoteRadiusBottomRight
      this.blockQuoteLeftBorderWidth = quoteData._blockQuoteLeftBorderWidth
      this.blockQuoteLeftBorderColor = quoteData._blockQuoteLeftBorderColor
      this.blockQuoteChildSpacing = quoteData._blockQuoteChildSpacing
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
        "块引用测试用例",
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
    
    // ---------- 专有 - BlockQuote
    let blockQuoteTheme = new BlockQuoteTheme()
    if (this.blockQuoteBackgroundColor !== undefined) {
      blockQuoteTheme.setBlockQuoteBackgroundColor(this.blockQuoteBackgroundColor)
    }
    blockQuoteTheme.setBlockQuoteMargin({top: this.blockQuoteMarginTop, right: this.blockQuoteMarginRight, bottom: this.blockQuoteMarginBottom, left: this.blockQuoteMarginLeft})
    blockQuoteTheme.setBlockQuotePadding({top: this.blockQuotePaddingTop, right: this.blockQuotePaddingRight, bottom: this.blockQuotePaddingBottom, left: this.blockQuotePaddingLeft})
    blockQuoteTheme.setBlockQuoteRadius({topLeft: this.blockQuoteRadiusTopLeft, topRight: this.blockQuoteRadiusTopRight, bottomLeft: this.blockQuoteRadiusBottomLeft, bottomRight: this.blockQuoteRadiusBottomRight})
    blockQuoteTheme.setBlockQuoteLeftBorderWidth(this.blockQuoteLeftBorderWidth)
    if (this.blockQuoteLeftBorderColor !== undefined) {
      blockQuoteTheme.setBlockQuoteLeftBorderColor(this.blockQuoteLeftBorderColor)
    }
    blockQuoteTheme.setBlockQuoteChildSpacing(this.blockQuoteChildSpacing)
    theme.setBlockQuoteTheme(blockQuoteTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsLatexMathPlugin(true) // 数学公式插件
    plugin.setIsHtmlPlugin(true) // HTML插件
    plugin.setIsBlockAudioPlugin(true) // 音频插件
    plugin.setIsBlockVideoPlugin(true) // 视频插件
    plugin.setIsCodeListPlugin(true) // 组合代码快列表插件
    plugin.setIsImageSlidePlugin(true) // 图片幻灯片（Banner）插件
    return plugin
  }
}
