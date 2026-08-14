import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration,
  MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_arkui'
import { getFileContextStr } from '../utils/FileUtils'
import { LineBreakData } from '../model/LineBreakData'
import hilog from '@ohos.hilog'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct LineBreakDetailsPage {
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
  @State // Markdown块间距样式字符串
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
  @State // 软换行是否换行
  isLineBreakProp: boolean = false

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let lineBreakData: LineBreakData = router.getParams() as LineBreakData
      this.fileStr = getFileContextStr(lineBreakData._pagePath)
      // ---------- 通用
      this.isFull = lineBreakData._isFull
      this.incrementalAnalysis = lineBreakData._incrementalAnalysis
      this.enableParseThrottle = lineBreakData._enableParseThrottle
      this.parseThrottleMs = lineBreakData._parseThrottleMs
      this.time = lineBreakData._time
      this.textNumber = lineBreakData._textNumber
      this.isMarkdownParserSync = lineBreakData._isMarkdownParserSync
      this.isOnCopy = lineBreakData._isOnCopy
      this.blockMarginTop = lineBreakData._blockMarginTop
      this.blockMarginRight = lineBreakData._blockMarginRight
      this.blockMarginBottom = lineBreakData._blockMarginBottom
      this.blockMarginLeft = lineBreakData._blockMarginLeft
      this.markdownBlockSpacing = lineBreakData._markdownBlockSpacing
      this.isLineBreak = lineBreakData._isLineBreak
      this.globalBackgroundColor = lineBreakData._backgroundColor
      this.openGestureSwipe = lineBreakData._openGestureSwipe
      this.openGestureSwipeTest = lineBreakData._openGestureSwipeTest
      // ---------- 专有
      this.isLineBreakProp = lineBreakData._isLineBreak
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
        "软换行测试用例",
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
    plugin.setIsLatexMathPlugin(true) // 数学公式插件
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsLinkifyPlugin(true) // 自动链接插件
    plugin.setIsBlockAudioPlugin(true) // 音频插件
    plugin.setIsBlockVideoPlugin(true) // 视频插件
    plugin.setIsImageCollectPlugin(true) // 图片视频列表url集合列表解析插件
    plugin.setIsImageTextMixPlugin(true) // 图文不混排插件
    plugin.setIsImageSlidePlugin(true) // 图片banner
    plugin.setIsCodeListPlugin(true) // 代码块列表
    plugin.setIsImageStylePlugin(true) // 图片样式
    plugin.setIsTocPlugin(true) // TOC插件
    plugin.setIsFootnotePlugin(true) // 脚注
    plugin.setIsHtmlPlugin(true) // Html插件
    plugin.setIsLinkViewPlugin(true) // 链接单独块解析插件
    return plugin
  }
}
