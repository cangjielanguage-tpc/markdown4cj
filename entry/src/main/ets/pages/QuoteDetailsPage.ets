import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme,
  MarkdownThemeBlockQuote,
  MarkdownThemeGlobal } from '@cangjie-tpc/markdown_hybrid'
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
  @State // 块引用背景颜色
  blockQuoteBackgroundColor: number | undefined = undefined
  @State // 块引用上外边距
  blockQuoteMarginTop: number = 0
  @State // 块引用右外边距
  blockQuoteMarginRight: number = 0
  @State // 块引用下外边距
  blockQuoteMarginBottom: number = 0
  @State // 块引用左外边距
  blockQuoteMarginLeft: number = 8
  @State // 块引用上内边距
  blockQuotePaddingTop: number = 0
  @State // 块引用右内边距
  blockQuotePaddingRight: number = 0
  @State // 块引用下内边距
  blockQuotePaddingBottom: number = 0
  @State // 块引用左内边距
  blockQuotePaddingLeft: number = 0
  @State // 块引用边框左上圆角
  blockQuoteRadiusTopLeft: number = 0
  @State // 块引用边框右上圆角
  blockQuoteRadiusTopRight: number = 0
  @State // 块引用边框左下圆角
  blockQuoteRadiusBottomLeft: number = 0
  @State // 块引用边框右下圆角
  blockQuoteRadiusBottomRight: number = 0
  @State // 块引用左侧边框宽度
  blockQuoteLeftBorderWidth: number = 4
  @State // 块引用左侧边框颜色
  blockQuoteLeftBorderColor: number | undefined = undefined
  @State // 块引用子模块上下间距
  blockQuoteChildSpacing: number = 4

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
      let quoteData: QuoteData = router.getParams() as QuoteData
      this.fileStr = getFileContextStr(quoteData._pagePath)
      // ---------- 通用
      this.isFull = quoteData._isFull
      this.incrementalAnalysis = quoteData._incrementalAnalysis
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
  }

  build() {
    Column() {
      titleComponent(
        "块引用测试用例",
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
    
    // ---------- 专有 - BlockQuote
    let blockQuoteTheme = new MarkdownThemeBlockQuote()
    if (this.blockQuoteBackgroundColor !== undefined) {
      blockQuoteTheme.setBlockQuoteBackgroundColor(this.blockQuoteBackgroundColor)
    }
    blockQuoteTheme.setBlockQuoteMargin(this.blockQuoteMarginTop, this.blockQuoteMarginRight, this.blockQuoteMarginBottom, this.blockQuoteMarginLeft)
    blockQuoteTheme.setBlockQuotePadding(this.blockQuotePaddingTop, this.blockQuotePaddingRight, this.blockQuotePaddingBottom, this.blockQuotePaddingLeft)
    blockQuoteTheme.setBlockQuoteRadius(this.blockQuoteRadiusTopLeft, this.blockQuoteRadiusTopRight, this.blockQuoteRadiusBottomLeft, this.blockQuoteRadiusBottomRight)
    blockQuoteTheme.setBlockQuoteLeftBorderWidth(this.blockQuoteLeftBorderWidth)
    if (this.blockQuoteLeftBorderColor !== undefined) {
      blockQuoteTheme.setBlockQuoteLeftBorderColor(this.blockQuoteLeftBorderColor)
    }
    blockQuoteTheme.setBlockQuoteChildSpacing(this.blockQuoteChildSpacing)
    theme.setMarkdownThemeBlockQuote(blockQuoteTheme)
    
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
