import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import {
  CJMarkdown,
  GlobalTheme,
  // LatexMathColorFormat,
  LatexMathTheme,
  MarkdownConfiguration,
  MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme
} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { LatexMathData } from '../model/LatexMathData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct LatexMathDetailsPage {
  // ---------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // Markdown的控制器
  // markdownScroller: MarkdownScroller = new MarkdownScroller()
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
  @State // LaTeX数学公式上外边距
  latexMathMarginTop: number = 0
  @State // LaTeX数学公式右外边距
  latexMathMarginRight: number = 0
  @State // LaTeX数学公式下外边距
  latexMathMarginBottom: number = 0
  @State // LaTeX数学公式左外边距
  latexMathMarginLeft: number = 0
  @State // LaTeX数学公式上内边距
  latexMathPaddingTop: number = 0
  @State // LaTeX数学公式右内边距
  latexMathPaddingRight: number = 0
  @State // LaTeX数学公式下内边距
  latexMathPaddingBottom: number = 0
  @State // LaTeX数学公式左内边距
  latexMathPaddingLeft: number = 0
  @State // 数学公式未加载状态是否显示文字
  latexMathDefaultText: boolean = true
  @State // 数学公式未加载状态文本颜色
  latexMathDefaultTextFontColor: number | undefined = undefined
  @State // 数学公式未加载状态文本尺寸
  latexMathDefaultTextFontSize: number = 14
  @State // 数学公式未加载状态文本字体样式
  latexMathDefaultTextFontStyle: FontStyle = FontStyle.Normal
  @State // 数学公式未加载状态文本字体粗细
  latexMathDefaultTextFontWeight: FontWeight = FontWeight.Normal
  @State // 数学公式未加载状态文本字体
  latexMathDefaultTextFontFamily: string = 'HarmonyOS Sans'
  @State // 数学公式文本大小
  latexMathTextSize: number = 16
  @State // 数学公式背景色
  latexMathBackgroundColor: number | undefined = undefined
  @State // 数学公式文本颜色
  latexMathTextColor: number | undefined = undefined
  // @State // 数学公式生成图片格式
  // latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
  @State // 块结构的数学公式是否居中
  latexMathBlockCenter: boolean = false
  @State // 数学公式字体路径
  latexMathResPath: string = '/data/storage/el1/bundle/entry/resources/resfile/res'

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
      let latexMathData: LatexMathData = router.getParams() as LatexMathData
      this.fileStr = getFileContextStr(latexMathData._pagePath)
      // ---------- 通用
      this.isFull = latexMathData._isFull
      this.incrementalAnalysis = latexMathData._incrementalAnalysis
      this.time = latexMathData._time
      this.textNumber = latexMathData._textNumber
      this.isMarkdownParserSync = latexMathData._isMarkdownParserSync
      this.isOnCopy = latexMathData._isOnCopy
      this.blockMarginTop = latexMathData._blockMarginTop
      this.blockMarginRight = latexMathData._blockMarginRight
      this.blockMarginBottom = latexMathData._blockMarginBottom
      this.blockMarginLeft = latexMathData._blockMarginLeft
      this.markdownBlockSpacing = latexMathData._markdownBlockSpacing
      this.isLineBreak = latexMathData._isLineBreak
      this.globalBackgroundColor = latexMathData._backgroundColor
      this.openGestureSwipe = latexMathData._openGestureSwipe
      this.openGestureSwipeTest = latexMathData._openGestureSwipeTest
      // ---------- 专有
      this.latexMathMarginTop = latexMathData._latexMathMarginTop
      this.latexMathMarginRight = latexMathData._latexMathMarginRight
      this.latexMathMarginBottom = latexMathData._latexMathMarginBottom
      this.latexMathMarginLeft = latexMathData._latexMathMarginLeft
      this.latexMathPaddingTop = latexMathData._latexMathPaddingTop
      this.latexMathPaddingRight = latexMathData._latexMathPaddingRight
      this.latexMathPaddingBottom = latexMathData._latexMathPaddingBottom
      this.latexMathPaddingLeft = latexMathData._latexMathPaddingLeft
      this.latexMathDefaultText = latexMathData._latexMathDefaultText
      this.latexMathDefaultTextFontColor = latexMathData._latexMathDefaultTextFontColor
      this.latexMathDefaultTextFontSize = latexMathData._latexMathDefaultTextFontSize
      this.latexMathDefaultTextFontStyle = latexMathData._latexMathDefaultTextFontStyle
      this.latexMathDefaultTextFontWeight = latexMathData._latexMathDefaultTextFontWeight
      this.latexMathDefaultTextFontFamily = latexMathData._latexMathDefaultTextFontFamily
      this.latexMathTextSize = latexMathData._latexMathTextSize
      this.latexMathBackgroundColor = latexMathData._latexMathBackgroundColor
      this.latexMathTextColor = latexMathData._latexMathTextColor
      // this.latexMathColorFormat = latexMathData._latexMathColorFormat
      this.latexMathBlockCenter = latexMathData._latexMathBlockCenter
      this.latexMathResPath = latexMathData._latexMathResPath
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
        "数学公式测试用例",
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
                // isInputEnded: this.isInputEnded,
                // incrementalAnalysis: this.incrementalAnalysis,
                // listScroller: this.markdownScroller,
                config: this.markdownConfiguration,
                plugin: this.markdownPlugin
              })
            }.height("100%")
          } else {
            Column() {
              CJMarkdown({
                content: this.content,
                // isInputEnded: this.isInputEnded,
                // listScroller: this.markdownScroller,
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
                // isInputEnded: this.isInputEnded,
                // incrementalAnalysis: this.incrementalAnalysis,
                // listScroller: this.markdownScroller,
                config: this.markdownConfiguration,
                plugin: this.markdownPlugin
              })
            }.height("100%")
          } else {
            Column() {
              CJMarkdown({
                content: this.content,
                // isInputEnded: this.isInputEnded,
                // listScroller: this.markdownScroller,
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
    config.setLatexImageCallback(this.latexCallBack.bind(this)) // 数学公式点击回调
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
    globalTheme.setMargin({top: this.blockMarginTop, right: this.blockMarginRight, bottom: this.blockMarginBottom, left: this.blockMarginLeft})
    globalTheme.setMarkdownBlockSpacing(this.markdownBlockSpacing)
    globalTheme.setIsLineBreak(this.isLineBreak)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.setGlobalTheme(globalTheme)
    
    // ---------- 专有 - LatexMath
    let latexMathTheme = new LatexMathTheme()
    // latexMathTheme.setLatexMathMargin({top: this.latexMathMarginTop, right: this.latexMathMarginRight, bottom: this.latexMathMarginBottom, left: this.latexMathMarginLeft})
    // latexMathTheme.setLatexMathPadding({top: this.latexMathPaddingTop, right: this.latexMathPaddingRight, bottom: this.latexMathPaddingBottom, left: this.latexMathPaddingLeft})
    latexMathTheme.setLatexMathDefaultText(this.latexMathDefaultText)
    if (this.latexMathDefaultTextFontColor !== undefined) {
      latexMathTheme.setLatexMathDefaultTextFontColor(this.latexMathDefaultTextFontColor)
    }
    latexMathTheme.setLatexMathDefaultTextFontSize(this.latexMathDefaultTextFontSize)
    latexMathTheme.setLatexMathDefaultTextFontStyle(this.latexMathDefaultTextFontStyle)
    latexMathTheme.setLatexMathDefaultTextFontWeight(this.latexMathDefaultTextFontWeight)
    latexMathTheme.setLatexMathDefaultTextFontFamily(this.latexMathDefaultTextFontFamily)
    latexMathTheme.setLatexMathTextSize(this.latexMathTextSize)
    if (this.latexMathBackgroundColor !== undefined) {
      latexMathTheme.setLatexMathBackgroundColor(this.latexMathBackgroundColor)
    }
    if (this.latexMathTextColor !== undefined) {
      latexMathTheme.setLatexMathTextColor(this.latexMathTextColor)
    }
    // latexMathTheme.setLatexMathColorFormat(this.latexMathColorFormat)
    latexMathTheme.setLatexMathBlockCenter(this.latexMathBlockCenter)
    latexMathTheme.setLatexMathResPath(this.latexMathResPath)
    theme.setLatexMathTheme(latexMathTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsLatexMathPlugin(true) // 数学公式插件
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsDescListPlugin(true) // 定义列表插件
    return plugin
  }

  latexCallBack(data: ArrayBuffer, heightNumber: number, widthNumber: number): void {
    hilog.error(1, "1", `---data.size:${data.byteLength},heightNumber:${heightNumber},widthNumber:${widthNumber}`)
  }
}
