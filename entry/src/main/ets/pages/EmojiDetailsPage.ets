import { CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_arkui'
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { getFileContextStr } from '../utils/FileUtils'
import { EmojiData } from '../model/EmojiData'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct EmojiDetailsPage {
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
  // emoji解析插件是否精简加载
  @State
  isEmojiLight: boolean = true

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let emojiData: EmojiData = router.getParams() as EmojiData
      this.fileStr = getFileContextStr(emojiData._pagePath)
      // ---------- 通用
      this.isFull = emojiData._isFull
      this.incrementalAnalysis = emojiData._incrementalAnalysis
      this.enableParseThrottle = emojiData._enableParseThrottle
      this.parseThrottleMs = emojiData._parseThrottleMs
      this.time = emojiData._time
      this.textNumber = emojiData._textNumber
      this.isMarkdownParserSync = emojiData._isMarkdownParserSync
      this.isOnCopy = emojiData._isOnCopy
      this.blockMarginTop = emojiData._blockMarginTop
      this.blockMarginRight = emojiData._blockMarginRight
      this.blockMarginBottom = emojiData._blockMarginBottom
      this.blockMarginLeft = emojiData._blockMarginLeft
      this.markdownBlockSpacing = emojiData._markdownBlockSpacing
      this.isLineBreak = emojiData._isLineBreak
      this.globalBackgroundColor = emojiData._backgroundColor
      this.openGestureSwipe = emojiData._openGestureSwipe
      this.openGestureSwipeTest = emojiData._openGestureSwipeTest
      // ---------- 专有
      this.isEmojiLight = emojiData._isEmojiLight
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
        "Emoji测试用例",
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
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsHtmlPlugin(true) // HTML插件
    plugin.setIsEmojiPlugin(true, this.isEmojiLight) // emoji插件
    return plugin
  }
}
