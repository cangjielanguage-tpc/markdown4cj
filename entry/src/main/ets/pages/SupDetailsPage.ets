import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme,
  SupTheme} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { SupData } from '../model/SupData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct SupDetailsPage {
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
  blockMarginTop: number = 0
  @State // Markdown块右边距
  blockMarginRight: number = 0
  @State // Markdown块下边距
  blockMarginBottom: number = 0
  @State // Markdown块左边距
  blockMarginLeft: number = 0
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
  @State // 上标文本颜色
  supTextFontColor: ResourceColor | undefined = undefined
  @State // 上标文本尺寸
  supTextFontSize: number | string | Resource = 8.0
  @State // 上标文本字体样式
  supTextFontStyle: FontStyle | undefined = undefined
  @State // 上标文本字体粗细
  supTextFontWeight: number | FontWeight | undefined = undefined
  @State // 上标文本字体
  supTextFontFamily: string | Resource | undefined = undefined
  @State // 上标文本字符间距
  supTextLetterSpacing: number | undefined = undefined
  @State // 上标文本基线的偏移量
  supTextBaselineOffset: number = 6.0

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let supData: SupData = router.getParams() as SupData
      this.fileStr = getFileContextStr(supData._pagePath)
      // ---------- 通用
      this.isFull = supData._isFull
      this.incrementalAnalysis = supData._incrementalAnalysis
      this.enableParseThrottle = supData._enableParseThrottle
      this.parseThrottleMs = supData._parseThrottleMs
      this.time = supData._time
      this.textNumber = supData._textNumber
      this.isMarkdownParserSync = supData._isMarkdownParserSync
      this.isOnCopy = supData._isOnCopy
      this.blockMarginTop = supData._blockMarginTop
      this.blockMarginRight = supData._blockMarginRight
      this.blockMarginBottom = supData._blockMarginBottom
      this.blockMarginLeft = supData._blockMarginLeft
      this.markdownBlockSpacing = supData._markdownBlockSpacing
      this.isLineBreak = supData._isLineBreak
      this.globalBackgroundColor = supData._backgroundColor
      this.openGestureSwipe = supData._openGestureSwipe
      this.openGestureSwipeTest = supData._openGestureSwipeTest
      // ---------- 专有
      this.supTextFontColor = supData._supTextFontColor
      this.supTextFontSize = supData._supTextFontSize
      this.supTextFontStyle = supData._supTextFontStyle
      this.supTextFontWeight = supData._supTextFontWeight
      this.supTextFontFamily = supData._supTextFontFamily
      this.supTextLetterSpacing = supData._supTextLetterSpacing
      this.supTextBaselineOffset = supData._supTextBaselineOffset
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
        "上标测试用例",
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
    
    // ---------- 专有 - Sup
    let supTheme = new SupTheme()
    if (this.supTextFontColor !== undefined) {
      supTheme.setSupTextFontColor(this.supTextFontColor)
    }
    supTheme.setSupTextFontSize(this.supTextFontSize)
    if (this.supTextFontStyle !== undefined) {
      supTheme.setSupTextFontStyle(this.supTextFontStyle)
    }
    if (this.supTextFontWeight !== undefined) {
      supTheme.setSupTextFontWeight(this.supTextFontWeight)
    }
    if (this.supTextFontFamily !== undefined) {
      supTheme.setSupTextFontFamily(this.supTextFontFamily)
    }
    if (this.supTextLetterSpacing !== undefined) {
      supTheme.setSupTextLetterSpacing(this.supTextLetterSpacing)
    }
    supTheme.setSupTextBaselineOffset(this.supTextBaselineOffset)
    theme.setSupTheme(supTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsHtmlPlugin(true) // HTML插件
    plugin.setIsSubPlugin(true) // 下标插件
    plugin.setIsSupPlugin(true) // 上标插件
    return plugin
  }
}
