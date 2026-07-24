import { CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme,
  StrikethroughTheme} from '@cangjie-tpc/markdown_hybrid'
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { StrikethroughData } from '../model/StrikethroughData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct StrikethroughDetailsPage {
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
  @State // 删除线文本颜色
  strikethroughTextFontColor: number | undefined = undefined
  @State // 删除线文本尺寸
  strikethroughTextFontSize: number | undefined = undefined
  @State // 删除线文本字体样式
  strikethroughTextFontStyle: FontStyle | undefined = undefined
  @State // 删除线文本字体粗细
  strikethroughTextFontWeight: FontWeight | undefined = undefined
  @State // 删除线文本字体
  strikethroughTextFontFamily: string | undefined = undefined
  @State // 删除线文本行高
  strikethroughTextLineHeight: number | undefined = undefined
  @State // 删除线文本字符间距
  strikethroughTextLetterSpacing: number | undefined = undefined
  @State // 删除线文本装饰线颜色
  strikethroughTextDecorationColor: number | undefined = undefined
  @State // 删除线文本装饰线样式
  strikethroughTextDecorationStyle: TextDecorationStyle | undefined = undefined

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
      let strikethroughData: StrikethroughData = router.getParams() as StrikethroughData
      this.fileStr = getFileContextStr(strikethroughData._pagePath)
      // ---------- 通用
      this.isFull = strikethroughData._isFull
      this.incrementalAnalysis = strikethroughData._incrementalAnalysis
      this.time = strikethroughData._time
      this.textNumber = strikethroughData._textNumber
      this.isMarkdownParserSync = strikethroughData._isMarkdownParserSync
      this.isOnCopy = strikethroughData._isOnCopy
      this.blockMarginTop = strikethroughData._blockMarginTop
      this.blockMarginRight = strikethroughData._blockMarginRight
      this.blockMarginBottom = strikethroughData._blockMarginBottom
      this.blockMarginLeft = strikethroughData._blockMarginLeft
      this.markdownBlockSpacing = strikethroughData._markdownBlockSpacing
      this.isLineBreak = strikethroughData._isLineBreak
      this.globalBackgroundColor = strikethroughData._backgroundColor
      this.openGestureSwipe = strikethroughData._openGestureSwipe
      this.openGestureSwipeTest = strikethroughData._openGestureSwipeTest
      // ---------- 专有
      this.strikethroughTextFontColor = strikethroughData._strikethroughTextFontColor
      this.strikethroughTextFontSize = strikethroughData._strikethroughTextFontSize
      this.strikethroughTextFontStyle = strikethroughData._strikethroughTextFontStyle
      this.strikethroughTextFontWeight = strikethroughData._strikethroughTextFontWeight
      this.strikethroughTextFontFamily = strikethroughData._strikethroughTextFontFamily
      this.strikethroughTextLineHeight = strikethroughData._strikethroughTextLineHeight
      this.strikethroughTextLetterSpacing = strikethroughData._strikethroughTextLetterSpacing
      this.strikethroughTextDecorationColor = strikethroughData._strikethroughTextDecorationColor
      this.strikethroughTextDecorationStyle = strikethroughData._strikethroughTextDecorationStyle
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
        "删除线测试用例",
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
    
    // ---------- 专有 - Strikethrough
    let strikethroughTheme = new StrikethroughTheme()
    if (this.strikethroughTextFontColor !== undefined) {
      strikethroughTheme.setStrikethroughTextFontColor(this.strikethroughTextFontColor)
    }
    if (this.strikethroughTextFontSize !== undefined) {
      strikethroughTheme.setStrikethroughTextFontSize(this.strikethroughTextFontSize)
    }
    if (this.strikethroughTextFontStyle !== undefined) {
      strikethroughTheme.setStrikethroughTextFontStyle(this.strikethroughTextFontStyle)
    }
    if (this.strikethroughTextFontWeight !== undefined) {
      strikethroughTheme.setStrikethroughTextFontWeight(this.strikethroughTextFontWeight)
    }
    if (this.strikethroughTextFontFamily !== undefined) {
      strikethroughTheme.setStrikethroughTextFontFamily(this.strikethroughTextFontFamily)
    }
    if (this.strikethroughTextLineHeight !== undefined) {
      strikethroughTheme.setStrikethroughTextLineHeight(this.strikethroughTextLineHeight)
    }
    if (this.strikethroughTextLetterSpacing !== undefined) {
      strikethroughTheme.setStrikethroughTextLetterSpacing(this.strikethroughTextLetterSpacing)
    }
    if (this.strikethroughTextDecorationColor !== undefined) {
      strikethroughTheme.setStrikethroughTextDecorationColor(this.strikethroughTextDecorationColor)
    }
    if (this.strikethroughTextDecorationStyle !== undefined) {
      strikethroughTheme.setStrikethroughTextDecorationStyle(this.strikethroughTextDecorationStyle)
    }
    theme.setStrikethroughTheme(strikethroughTheme)
    
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
