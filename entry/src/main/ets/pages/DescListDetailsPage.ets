import { CJMarkdown,
  DefinitionListTheme,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_arkui'
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { getFileContextStr } from '../utils/FileUtils'
import { DescListData } from '../model/DescListData'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct DescListDetailsPage {
  // ---------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // Markdown的控制器
  markdownScroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  @StorageProp('currentColorMode') // 深浅色模式
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
  // 是否启用解析节流
  @State
  enableParseThrottle: boolean = false
  // 解析节流间隔（ms）
  @State
  parseThrottleMs: number = 200
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
  blockMarginTop: number = 0
  // Markdown块右边距
  @State
  blockMarginRight: number = 0
  // Markdown块下边距
  @State
  blockMarginBottom: number = 0
  // Markdown块左边距
  @State
  blockMarginLeft: number = 0
  // Markdown块间距样式字符串
  @State
  markdownBlockSpacing: number = 8
  // 是否换行
  @State
  isLineBreak: boolean = false
  // 全局背景色
  @State
  globalBackgroundColor: ResourceColor | undefined = undefined
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
  // 定义列表背景颜色
  @State
  definitionListBackgroundColor: ResourceColor | undefined = undefined
  // 定义列表上外边距
  @State
  definitionListMarginTop: Length = 8.0
  // 定义列表右外边距
  @State
  definitionListMarginRight: Length = 0.0
  // 定义列表下外边距
  @State
  definitionListMarginBottom: Length = 8.0
  // 定义列表左外边距
  @State
  definitionListMarginLeft: Length = 0.0
  // 定义列表上内边距
  @State
  definitionListPaddingTop: Length = 0.0
  // 定义列表右内边距
  @State
  definitionListPaddingRight: Length = 0.0
  // 定义列表下内边距
  @State
  definitionListPaddingBottom: Length = 0.0
  // 定义列表左内边距
  @State
  definitionListPaddingLeft: Length = 0.0
  // 定义列表术语和定义行之间间距
  @State
  definitionListTermToDescriptionSpacing: number = 8.0
  // 定义列表术语文本字体粗细
  @State
  definitionListTermTextFontWeight: number | FontWeight = FontWeight.Bold
  // 定义列表术语文本字体样式
  @State
  definitionListTermTextFontStyle: FontStyle = FontStyle.Italic
  // 定义列表定义行之间间距
  @State
  definitionListDescriptionItemSpacing: number = 8.0
  // 定义列表定义行左缩进距离
  @State
  definitionListDescriptionIndent: number = 8.0

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let descListData: DescListData = router.getParams() as DescListData
      this.fileStr = getFileContextStr(descListData._pagePath)
      // ---------- 通用
      this.isFull = descListData._isFull
      this.incrementalAnalysis = descListData._incrementalAnalysis
      this.enableParseThrottle = descListData._enableParseThrottle
      this.parseThrottleMs = descListData._parseThrottleMs
      this.time = descListData._time
      this.textNumber = descListData._textNumber
      this.isMarkdownParserSync = descListData._isMarkdownParserSync
      this.isOnCopy = descListData._isOnCopy
      this.blockMarginTop = descListData._blockMarginTop
      this.blockMarginRight = descListData._blockMarginRight
      this.blockMarginBottom = descListData._blockMarginBottom
      this.blockMarginLeft = descListData._blockMarginLeft
      this.markdownBlockSpacing = descListData._markdownBlockSpacing
      this.isLineBreak = descListData._isLineBreak
      this.globalBackgroundColor = descListData._backgroundColor
      this.openGestureSwipe = descListData._openGestureSwipe
      this.openGestureSwipeTest = descListData._openGestureSwipeTest
      // ---------- 专有
      this.definitionListBackgroundColor = descListData._definitionListBackgroundColor
      this.definitionListMarginTop = descListData._definitionListMarginTop
      this.definitionListMarginRight = descListData._definitionListMarginRight
      this.definitionListMarginBottom = descListData._definitionListMarginBottom
      this.definitionListMarginLeft = descListData._definitionListMarginLeft
      this.definitionListPaddingTop = descListData._definitionListPaddingTop
      this.definitionListPaddingRight = descListData._definitionListPaddingRight
      this.definitionListPaddingBottom = descListData._definitionListPaddingBottom
      this.definitionListPaddingLeft = descListData._definitionListPaddingLeft
      this.definitionListTermToDescriptionSpacing = descListData._definitionListTermToDescriptionSpacing
      this.definitionListTermTextFontWeight = descListData._definitionListTermTextFontWeight
      this.definitionListTermTextFontStyle = descListData._definitionListTermTextFontStyle
      this.definitionListDescriptionItemSpacing = descListData._definitionListDescriptionItemSpacing
      this.definitionListDescriptionIndent = descListData._definitionListDescriptionIndent
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

  build() {
    Column() {
      titleComponent(
        "定义列表测试用例",
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
    
    // ---------- 专有 - DefinitionList
    let definitionListTheme = new DefinitionListTheme()
    if (this.definitionListBackgroundColor !== undefined) {
      definitionListTheme.setDefinitionListBackgroundColor(this.definitionListBackgroundColor)
    }
    definitionListTheme.setDefinitionListMargin({
      top: this.definitionListMarginTop,
      right: this.definitionListMarginRight,
      bottom: this.definitionListMarginBottom,
      left: this.definitionListMarginLeft
    })
    definitionListTheme.setDefinitionListPadding({
      top: this.definitionListPaddingTop,
      right: this.definitionListPaddingRight,
      bottom: this.definitionListPaddingBottom,
      left: this.definitionListPaddingLeft
    })
    definitionListTheme.setDefinitionListTermToDescriptionSpacing(this.definitionListTermToDescriptionSpacing)
    definitionListTheme.setDefinitionListTermTextFontWeight(this.definitionListTermTextFontWeight)
    definitionListTheme.setDefinitionListTermTextFontStyle(this.definitionListTermTextFontStyle)
    definitionListTheme.setDefinitionListDescriptionItemSpacing(this.definitionListDescriptionItemSpacing)
    definitionListTheme.setDefinitionListDescriptionIndent(this.definitionListDescriptionIndent)
    theme.setDefinitionListTheme(definitionListTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsDescListPlugin(true)
    return plugin
  }
}
