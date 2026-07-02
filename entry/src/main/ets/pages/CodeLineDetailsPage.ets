import { CJMarkdown,
  GlobalTheme,
  InlineCodeTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme} from '@cangjie-tpc/markdown_hybrid'
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { getFileContextStr } from '../utils/FileUtils'
import { CodeLineData } from '../model/CodeLineData'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct CodeLineDetailsPage {
  // ---------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // Markdown的控制器
  // markdownScroller: MarkdownScroller = new MarkdownScroller()
  // 顶部导航栏高度
  @StorageProp('safeTop')
  safeTop: number = 0
  // 深浅色模式
  @StorageProp('currentColorMode')
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
  // 内联代码文本颜色
  @State
  inlineCodeTextFontColor: ResourceColor | undefined = undefined
  // 内联代码文本尺寸
  @State
  inlineCodeTextFontSize: number | string | Resource | undefined = undefined
  // 内联代码文本字体样式
  @State
  inlineCodeTextFontStyle: FontStyle | undefined = undefined
  // 内联代码文本字体粗细
  @State
  inlineCodeTextFontWeight: number | FontWeight | undefined = undefined
  // 内联代码文本字体
  @State
  inlineCodeTextFontFamily: string | Resource | undefined = undefined
  // 内联代码文本行高
  @State
  inlineCodeTextLineHeight: number | string | Resource | undefined = undefined
  // 内联代码文本字符间距
  @State
  inlineCodeTextLetterSpacing: number | undefined = undefined
  // 内联代码文本背景颜色
  @State
  inlineCodeTextBackgroundColor: ResourceColor | undefined = undefined
  // 内联代码文本背景左上圆角
  @State
  inlineCodeTextBackgroundRadiusTopLeft: Length = 0.0
  // 内联代码文本背景右上圆角
  @State
  inlineCodeTextBackgroundRadiusTopRight: Length = 0.0
  // 内联代码文本背景左下圆角
  @State
  inlineCodeTextBackgroundRadiusBottomLeft: Length = 0.0
  // 内联代码文本背景右下圆角
  @State
  inlineCodeTextBackgroundRadiusBottomRight: Length = 0.0
  // markdown配置
  @State
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  // markdown主题
  @State
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  // markdown插件
  @State
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let codeLineData: CodeLineData = router.getParams() as CodeLineData
      this.fileStr = getFileContextStr(codeLineData._pagePath)
      // ---------- 通用
      this.isFull = codeLineData._isFull
      this.incrementalAnalysis = codeLineData._incrementalAnalysis
      this.time = codeLineData._time
      this.textNumber = codeLineData._textNumber
      this.isMarkdownParserSync = codeLineData._isMarkdownParserSync
      this.isOnCopy = codeLineData._isOnCopy
      this.blockMarginTop = codeLineData._blockMarginTop
      this.blockMarginRight = codeLineData._blockMarginRight
      this.blockMarginBottom = codeLineData._blockMarginBottom
      this.blockMarginLeft = codeLineData._blockMarginLeft
      this.markdownBlockSpacing = codeLineData._markdownBlockSpacing
      this.isLineBreak = codeLineData._isLineBreak
      this.globalBackgroundColor = codeLineData._backgroundColor
      this.openGestureSwipe = codeLineData._openGestureSwipe
      this.openGestureSwipeTest = codeLineData._openGestureSwipeTest
      // ---------- 专有
      this.inlineCodeTextFontColor = codeLineData._inlineCodeTextFontColor
      this.inlineCodeTextFontSize = codeLineData._inlineCodeTextFontSize
      this.inlineCodeTextFontStyle = codeLineData._inlineCodeTextFontStyle
      this.inlineCodeTextFontWeight = codeLineData._inlineCodeTextFontWeight
      this.inlineCodeTextFontFamily = codeLineData._inlineCodeTextFontFamily
      this.inlineCodeTextLineHeight = codeLineData._inlineCodeTextLineHeight
      this.inlineCodeTextLetterSpacing = codeLineData._inlineCodeTextLetterSpacing
      this.inlineCodeTextBackgroundColor = codeLineData._inlineCodeTextBackgroundColor
      this.inlineCodeTextBackgroundRadiusTopLeft = codeLineData._inlineCodeTextBackgroundRadiusTopLeft
      this.inlineCodeTextBackgroundRadiusTopRight = codeLineData._inlineCodeTextBackgroundRadiusTopRight
      this.inlineCodeTextBackgroundRadiusBottomLeft = codeLineData._inlineCodeTextBackgroundRadiusBottomLeft
      this.inlineCodeTextBackgroundRadiusBottomRight = codeLineData._inlineCodeTextBackgroundRadiusBottomRight
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
        "内联代码测试用例",
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
              scroller: this.scroller,
              config: this.markdownConfiguration,
              plugin: this.markdownPlugin
            })
          }.height("100%")
        } else {
          Column() {
            CJMarkdown({
              content: this.content,
              // isInputEnded: this.isInputEnded,
              scroller: this.scroller,
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
    theme.setGlobalTheme(globalTheme)
    
    // ---------- 专有 - InlineCode
    let inlineCodeTheme = new InlineCodeTheme()
    if (this.inlineCodeTextFontColor !== undefined) {
      inlineCodeTheme.setInlineCodeTextFontColor(this.inlineCodeTextFontColor)
    }
    if (this.inlineCodeTextFontSize !== undefined) {
      inlineCodeTheme.setInlineCodeTextFontSize(this.inlineCodeTextFontSize)
    }
    if (this.inlineCodeTextFontStyle !== undefined) {
      inlineCodeTheme.setInlineCodeTextFontStyle(this.inlineCodeTextFontStyle)
    }
    if (this.inlineCodeTextFontWeight !== undefined) {
      inlineCodeTheme.setInlineCodeTextFontWeight(this.inlineCodeTextFontWeight)
    }
    if (this.inlineCodeTextFontFamily !== undefined) {
      inlineCodeTheme.setInlineCodeTextFontFamily(this.inlineCodeTextFontFamily)
    }
    if (this.inlineCodeTextLineHeight !== undefined) {
      inlineCodeTheme.setInlineCodeTextLineHeight(this.inlineCodeTextLineHeight)
    }
    if (this.inlineCodeTextLetterSpacing !== undefined) {
      inlineCodeTheme.setInlineCodeTextLetterSpacing(this.inlineCodeTextLetterSpacing)
    }
    if (this.inlineCodeTextBackgroundColor !== undefined) {
      inlineCodeTheme.setInlineCodeTextBackgroundColor(this.inlineCodeTextBackgroundColor)
    }
    inlineCodeTheme.setInlineCodeTextBackgroundRadius({
      topLeft: this.inlineCodeTextBackgroundRadiusTopLeft,
      topRight: this.inlineCodeTextBackgroundRadiusTopRight,
      bottomLeft: this.inlineCodeTextBackgroundRadiusBottomLeft,
      bottomRight: this.inlineCodeTextBackgroundRadiusBottomRight
    })
    theme.setInlineCodeTheme(inlineCodeTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true)
    return plugin
  }
}
