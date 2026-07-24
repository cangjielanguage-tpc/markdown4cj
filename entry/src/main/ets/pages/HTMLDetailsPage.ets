import { CJMarkdown,
  GlobalTheme,
  HtmlUnderlineTheme,
  MarkdownConfiguration, MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { getFileContextStr } from '../utils/FileUtils'
import { HTMLData } from '../model/HTMLData'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct HTMLDetailsPage {
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
  // 文件文本
  @State
  fileStr: string = ""
  // markdown文本
  @State
  content: string = ""
  // 是否全量加载Markdown文本
  @State
  isFull: boolean = true
  // 是否增量解析Markdown文本
  @State
  incrementalAnalysis: boolean = false
  // 增量加载每次间隔时间
  @State
  time: number = 50
  // 增量每次增量文本数量
  @State
  textNumber: number = 10
  // 是否同步解析Markdown文本
  @State
  isMarkdownParserSync: boolean = false
  // 是否打开长按复制粘贴效果
  @State
  isOnCopy: boolean = false
  // Markdown块上边距
  @State
  blockMarginTop: number = 8
  // Markdown块右边距
  @State
  blockMarginRight: number = 8
  // Markdown块下边距
  @State
  blockMarginBottom: number = 8
  // Markdown块左边距
  @State
  blockMarginLeft: number = 8
  // Markdown块间距样式字符串
  @State
  markdownBlockSpacing: number = 8
  // 是否换行
  @State
  isLineBreak: boolean = false
  // 全局背景色
  @State
  globalBackgroundColor: number | undefined = undefined
  // 是否允许markdown控件自身响应滑动
  @State
  openGestureSwipe: boolean = false
  // 是否开启响应滑动测试
  @State
  openGestureSwipeTest: boolean = false
  // 流式输入是否输入结束(true:结束输入,false:持续输入)
  @State
  isInputEnded: boolean = false

  // ---------- 专有
  // HTML下划线文本颜色
  @State
  htmlUnderlineTextFontColor: number | undefined = undefined
  // HTML下划线文本尺寸
  @State
  htmlUnderlineTextFontSize: number | undefined = undefined
  // HTML下划线文本字体样式
  @State
  htmlUnderlineTextFontStyle: FontStyle | undefined = undefined
  // HTML下划线文本字体粗细
  @State
  htmlUnderlineTextFontWeight: FontWeight | undefined = undefined
  // HTML下划线文本字体
  @State
  htmlUnderlineTextFontFamily: string | undefined = undefined
  // HTML下划线文本行高
  @State
  htmlUnderlineTextLineHeight: number | undefined = undefined
  // HTML下划线文本字符间距
  @State
  htmlUnderlineTextLetterSpacing: number | undefined = undefined
  // HTML下划线文本装饰线颜色
  @State
  htmlUnderlineTextDecorationColor: number | undefined = undefined
  // HTML下划线文本装饰线样式
  @State
  htmlUnderlineTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID

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
      let htmlData: HTMLData = router.getParams() as HTMLData
      this.fileStr = getFileContextStr(htmlData._pagePath)
      // ---------- 通用
      this.isFull = htmlData._isFull
      this.incrementalAnalysis = htmlData._incrementalAnalysis
      this.time = htmlData._time
      this.textNumber = htmlData._textNumber
      this.isMarkdownParserSync = htmlData._isMarkdownParserSync
      this.isOnCopy = htmlData._isOnCopy
      this.blockMarginTop = htmlData._blockMarginTop
      this.blockMarginRight = htmlData._blockMarginRight
      this.blockMarginBottom = htmlData._blockMarginBottom
      this.blockMarginLeft = htmlData._blockMarginLeft
      this.markdownBlockSpacing = htmlData._markdownBlockSpacing
      this.isLineBreak = htmlData._isLineBreak
      this.globalBackgroundColor = htmlData._backgroundColor
      this.openGestureSwipe = htmlData._openGestureSwipe
      this.openGestureSwipeTest = htmlData._openGestureSwipeTest
      // ---------- 专有
      this.htmlUnderlineTextFontColor = htmlData._htmlUnderlineTextFontColor
      this.htmlUnderlineTextFontSize = htmlData._htmlUnderlineTextFontSize
      this.htmlUnderlineTextFontStyle = htmlData._htmlUnderlineTextFontStyle
      this.htmlUnderlineTextFontWeight = htmlData._htmlUnderlineTextFontWeight
      this.htmlUnderlineTextFontFamily = htmlData._htmlUnderlineTextFontFamily
      this.htmlUnderlineTextLineHeight = htmlData._htmlUnderlineTextLineHeight
      this.htmlUnderlineTextLetterSpacing = htmlData._htmlUnderlineTextLetterSpacing
      this.htmlUnderlineTextDecorationColor = htmlData._htmlUnderlineTextDecorationColor
      this.htmlUnderlineTextDecorationStyle = htmlData._htmlUnderlineTextDecorationStyle
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
        "HTML测试用例",
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
                this.content = this.content + this.fileStr[index]
                this.scroller.scrollEdge(Edge.Bottom)
                if (index === this.fileStr.length - 1) {
                  this.isInputEnded = true
                  clearInterval(id)
                }
                index++
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
    theme.setGlobalTheme(globalTheme)
    
    // ---------- 专有 - HtmlUnderline
    let htmlUnderlineTheme = new HtmlUnderlineTheme()
    if (this.htmlUnderlineTextFontColor !== undefined) {
      htmlUnderlineTheme.setHtmlUnderlineTextFontColor(this.htmlUnderlineTextFontColor)
    }
    if (this.htmlUnderlineTextFontSize !== undefined) {
      htmlUnderlineTheme.setHtmlUnderlineTextFontSize(this.htmlUnderlineTextFontSize)
    }
    if (this.htmlUnderlineTextFontStyle !== undefined) {
      htmlUnderlineTheme.setHtmlUnderlineTextFontStyle(this.htmlUnderlineTextFontStyle)
    }
    if (this.htmlUnderlineTextFontWeight !== undefined) {
      htmlUnderlineTheme.setHtmlUnderlineTextFontWeight(this.htmlUnderlineTextFontWeight)
    }
    if (this.htmlUnderlineTextFontFamily !== undefined) {
      htmlUnderlineTheme.setHtmlUnderlineTextFontFamily(this.htmlUnderlineTextFontFamily)
    }
    if (this.htmlUnderlineTextLineHeight !== undefined) {
      htmlUnderlineTheme.setHtmlUnderlineTextLineHeight(this.htmlUnderlineTextLineHeight)
    }
    if (this.htmlUnderlineTextLetterSpacing !== undefined) {
      htmlUnderlineTheme.setHtmlUnderlineTextLetterSpacing(this.htmlUnderlineTextLetterSpacing)
    }
    if (this.htmlUnderlineTextDecorationColor !== undefined) {
      htmlUnderlineTheme.setHtmlUnderlineTextDecorationColor(this.htmlUnderlineTextDecorationColor)
    }
    htmlUnderlineTheme.setHtmlUnderlineTextDecorationStyle(this.htmlUnderlineTextDecorationStyle)
    theme.setHtmlUnderlineTheme(htmlUnderlineTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsHtmlPlugin(true) // HTML插件
    plugin.setIsTablePlugin(true) // 表格插件
    return plugin
  }
}
