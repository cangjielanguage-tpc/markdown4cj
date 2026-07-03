import {
  HighlightTheme,
  CJMarkdown,
  DelimiterFilterMode,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme} from '@cangjie-tpc/markdown_hybrid'
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { getFileContextStr } from '../utils/FileUtils'
import { BaseMDData } from '../model/BaseMDData'
import { HighlightData } from '../model/HighlightData'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct HighlightDetailsPage {
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
  @State // 高亮文本颜色
  highlightTextFontColor: ResourceColor | undefined = undefined
  @State // 高亮文本尺寸
  highlightTextFontSize: number | string | Resource | undefined = undefined
  @State // 高亮文本字体样式
  highlightTextFontStyle: FontStyle | undefined = undefined
  @State // 高亮文本字体粗细
  highlightTextFontWeight: number | FontWeight | undefined = undefined
  @State // 高亮文本字体
  highlightTextFontFamily: string | Resource | undefined = undefined
  @State // 高亮文本行高
  highlightTextLineHeight: number | string | Resource | undefined = undefined
  @State // 高亮文本字符间距
  highlightTextLetterSpacing: number | undefined = undefined
  @State // 高亮文本背景颜色
  highlightTextBackgroundColor: ResourceColor | undefined = undefined
  @State // 高亮文本背景左上圆角
  highlightTextBackgroundRadiusTopLeft: Length = 0.0
  @State // 高亮文本背景右上圆角
  highlightTextBackgroundRadiusTopRight: Length = 0.0
  @State // 高亮文本背景左下圆角
  highlightTextBackgroundRadiusBottomLeft: Length = 0.0
  @State // 高亮文本背景右下圆角
  highlightTextBackgroundRadiusBottomRight: Length = 0.0

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let highlightData: HighlightData = router.getParams() as HighlightData
      this.fileStr = getFileContextStr(highlightData._pagePath)
      // ---------- 通用
      this.isFull = highlightData._isFull
      this.incrementalAnalysis = highlightData._incrementalAnalysis
      this.enableParseThrottle = highlightData._enableParseThrottle
      this.parseThrottleMs = highlightData._parseThrottleMs
      this.time = highlightData._time
      this.textNumber = highlightData._textNumber
      this.isMarkdownParserSync = highlightData._isMarkdownParserSync
      this.isOnCopy = highlightData._isOnCopy
      this.blockMarginTop = highlightData._blockMarginTop
      this.blockMarginRight = highlightData._blockMarginRight
      this.blockMarginBottom = highlightData._blockMarginBottom
      this.blockMarginLeft = highlightData._blockMarginLeft
      this.markdownBlockSpacing = highlightData._markdownBlockSpacing
      this.isLineBreak = highlightData._isLineBreak
      this.globalBackgroundColor = highlightData._backgroundColor
      this.openGestureSwipe = highlightData._openGestureSwipe
      this.openGestureSwipeTest = highlightData._openGestureSwipeTest
      // ---------- 专有
      this.highlightTextFontColor = highlightData._highlightTextFontColor
      this.highlightTextFontSize = highlightData._highlightTextFontSize
      this.highlightTextFontStyle = highlightData._highlightTextFontStyle
      this.highlightTextFontWeight = highlightData._highlightTextFontWeight
      this.highlightTextFontFamily = highlightData._highlightTextFontFamily
      this.highlightTextLineHeight = highlightData._highlightTextLineHeight
      this.highlightTextLetterSpacing = highlightData._highlightTextLetterSpacing
      this.highlightTextBackgroundColor = highlightData._highlightTextBackgroundColor
      this.highlightTextBackgroundRadiusTopLeft = highlightData._highlightTextBackgroundRadiusTopLeft
      this.highlightTextBackgroundRadiusTopRight = highlightData._highlightTextBackgroundRadiusTopRight
      this.highlightTextBackgroundRadiusBottomLeft = highlightData._highlightTextBackgroundRadiusBottomLeft
      this.highlightTextBackgroundRadiusBottomRight = highlightData._highlightTextBackgroundRadiusBottomRight
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
        "高亮测试用例",
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

    let highlightTheme = new HighlightTheme()
    if (this.highlightTextFontColor !== undefined) {
      highlightTheme.setHighlightTextFontColor(this.highlightTextFontColor)
    }
    if (this.highlightTextFontSize !== undefined) {
      highlightTheme.setHighlightTextFontSize(this.highlightTextFontSize)
    }
    if (this.highlightTextFontStyle !== undefined) {
      highlightTheme.setHighlightTextFontStyle(this.highlightTextFontStyle)
    }
    if (this.highlightTextFontWeight !== undefined) {
      highlightTheme.setHighlightTextFontWeight(this.highlightTextFontWeight)
    }
    if (this.highlightTextFontFamily !== undefined) {
      highlightTheme.setHighlightTextFontFamily(this.highlightTextFontFamily)
    }
    if (this.highlightTextLineHeight !== undefined) {
      highlightTheme.setHighlightTextLineHeight(this.highlightTextLineHeight)
    }
    if (this.highlightTextLetterSpacing !== undefined) {
      highlightTheme.setHighlightTextLetterSpacing(this.highlightTextLetterSpacing)
    }
    if (this.highlightTextBackgroundColor !== undefined) {
      highlightTheme.setHighlightTextBackgroundColor(this.highlightTextBackgroundColor)
    }
    if (this.highlightTextBackgroundRadiusTopLeft !== undefined ||
        this.highlightTextBackgroundRadiusTopRight !== undefined ||
        this.highlightTextBackgroundRadiusBottomLeft !== undefined ||
        this.highlightTextBackgroundRadiusBottomRight !== undefined) {
      highlightTheme.setHighlightTextBackgroundRadius({
        topLeft: this.highlightTextBackgroundRadiusTopLeft,
        topRight: this.highlightTextBackgroundRadiusTopRight,
        bottomLeft: this.highlightTextBackgroundRadiusBottomLeft,
        bottomRight: this.highlightTextBackgroundRadiusBottomRight
      })
    }
    theme.setHighlightTheme(highlightTheme)

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
    plugin.setIsHighlightPlugin(true) // 高亮插件
    return plugin
  }
}
