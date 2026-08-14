import {
  BoldTheme,
  CJMarkdown,
  DelimiterFilterMode,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme} from '@cangjie-tpc/markdown_arkui'
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { getFileContextStr } from '../utils/FileUtils'
import { BaseMDData } from '../model/BaseMDData'
import { BoldData } from '../model/BoldData'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct BoldDetailsPage {
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
  @State // 加粗文本颜色
  boldTextFontColor: ResourceColor | undefined = undefined
  @State // 加粗文本尺寸
  boldTextFontSize: number | string | Resource | undefined = undefined
  @State // 加粗文本字体样式
  boldTextFontStyle: FontStyle | undefined = undefined
  @State // 加粗文本字体粗细
  boldTextFontWeight: number | FontWeight = FontWeight.Bold
  @State // 加粗文本字体
  boldTextFontFamily: string | Resource | undefined = undefined
  @State // 加粗文本行高
  boldTextLineHeight: number | string | Resource | undefined = undefined
  @State // 加粗文本字符间距
  boldTextLetterSpacing: number | undefined = undefined

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let boldData: BoldData = router.getParams() as BoldData
      this.fileStr = getFileContextStr(boldData._pagePath)
      // ---------- 通用
      this.isFull = boldData._isFull
      this.incrementalAnalysis = boldData._incrementalAnalysis
      this.enableParseThrottle = boldData._enableParseThrottle
      this.parseThrottleMs = boldData._parseThrottleMs
      this.time = boldData._time
      this.textNumber = boldData._textNumber
      this.isMarkdownParserSync = boldData._isMarkdownParserSync
      this.isOnCopy = boldData._isOnCopy
      this.blockMarginTop = boldData._blockMarginTop
      this.blockMarginRight = boldData._blockMarginRight
      this.blockMarginBottom = boldData._blockMarginBottom
      this.blockMarginLeft = boldData._blockMarginLeft
      this.markdownBlockSpacing = boldData._markdownBlockSpacing
      this.isLineBreak = boldData._isLineBreak
      this.globalBackgroundColor = boldData._backgroundColor
      this.openGestureSwipe = boldData._openGestureSwipe
      this.openGestureSwipeTest = boldData._openGestureSwipeTest
      // ---------- 专有
      this.boldTextFontColor = boldData._boldTextFontColor
      this.boldTextFontSize = boldData._boldTextFontSize
      this.boldTextFontStyle = boldData._boldTextFontStyle
      this.boldTextFontWeight = boldData._boldTextFontWeight
      this.boldTextFontFamily = boldData._boldTextFontFamily
      this.boldTextLineHeight = boldData._boldTextLineHeight
      this.boldTextLetterSpacing = boldData._boldTextLetterSpacing
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
        "加粗测试用例",
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

    let boldTheme = new BoldTheme()
    if (this.boldTextFontColor !== undefined) {
      boldTheme.setBoldTextFontColor(this.boldTextFontColor)
    }
    if (this.boldTextFontSize !== undefined) {
      boldTheme.setBoldTextFontSize(this.boldTextFontSize)
    }
    if (this.boldTextFontStyle !== undefined) {
      boldTheme.setBoldTextFontStyle(this.boldTextFontStyle)
    }
    boldTheme.setBoldTextFontWeight(this.boldTextFontWeight)
    if (this.boldTextFontFamily !== undefined) {
      boldTheme.setBoldTextFontFamily(this.boldTextFontFamily)
    }
    if (this.boldTextLineHeight !== undefined) {
      boldTheme.setBoldTextLineHeight(this.boldTextLineHeight)
    }
    if (this.boldTextLetterSpacing !== undefined) {
      boldTheme.setBoldTextLetterSpacing(this.boldTextLetterSpacing)
    }
    theme.setBoldTheme(boldTheme)

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
    plugin.setIsWhitelistPlugin(DelimiterFilterMode.Permissive) // 白名单宽松分隔符插件
    return plugin
  }
}
