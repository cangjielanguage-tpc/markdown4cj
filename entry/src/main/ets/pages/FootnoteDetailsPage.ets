import { CJMarkdown,
  FootnoteDefTheme,
  FootnoteRefTheme,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme} from '@cangjie-tpc/markdown_hybrid'
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { getFileContextStr } from '../utils/FileUtils'
import { FootnoteData } from '../model/FootnoteData'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct FootnoteDetailsPage {
  // ---------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // Markdown的控制器
  // markdownScroller: MarkdownScroller = new MarkdownScroller()
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
  // 脚注定义背景颜色
  @State
  footnoteDefBackgroundColor: ResourceColor | undefined = undefined
  // 脚注定义上外边距
  @State
  footnoteDefMarginTop: Length = 0.0
  // 脚注定义右外边距
  @State
  footnoteDefMarginRight: Length = 0.0
  // 脚注定义下外边距
  @State
  footnoteDefMarginBottom: Length = 0.0
  // 脚注定义左外边距
  @State
  footnoteDefMarginLeft: Length = 0.0
  // 脚注定义上内边距
  @State
  footnoteDefPaddingTop: Length = 0.0
  // 脚注定义右内边距
  @State
  footnoteDefPaddingRight: Length = 0.0
  // 脚注定义下内边距
  @State
  footnoteDefPaddingBottom: Length = 0.0
  // 脚注定义左内边距
  @State
  footnoteDefPaddingLeft: Length = 0.0
  // 脚注引用文本颜色
  @State
  footnoteRefTextFontColor: ResourceColor | undefined = undefined
  // 脚注引用文本尺寸
  @State
  footnoteRefTextFontSize: number | string | Resource | undefined = undefined
  // 脚注引用文本字体样式
  @State
  footnoteRefTextFontStyle: FontStyle | undefined = undefined
  // 脚注引用文本字体粗细
  @State
  footnoteRefTextFontWeight: number | FontWeight | undefined = undefined
  // 脚注引用文本字体
  @State
  footnoteRefTextFontFamily: string | Resource | undefined = undefined
  // 脚注引用文本行高
  @State
  footnoteRefTextLineHeight: number | string | Resource | undefined = undefined
  // 脚注引用文本字符间距
  @State
  footnoteRefTextLetterSpacing: number | undefined = undefined
  // 脚注引用文本装饰线类型
  @State
  footnoteRefTextDecorationType: TextDecorationType = TextDecorationType.None
  // 脚注引用文本装饰线颜色
  @State
  footnoteRefTextDecorationColor: ResourceColor | undefined = undefined
  // 脚注引用文本装饰线样式
  @State
  footnoteRefTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID
  // 脚注引用文本背景颜色
  @State
  footnoteRefTextBackgroundColor: ResourceColor | undefined = undefined
  // 脚注引用文本背景左上圆角
  @State
  footnoteRefTextBackgroundRadiusTopLeft: Length = 0.0
  // 脚注引用文本背景右上圆角
  @State
  footnoteRefTextBackgroundRadiusTopRight: Length = 0.0
  // 脚注引用文本背景左下圆角
  @State
  footnoteRefTextBackgroundRadiusBottomLeft: Length = 0.0
  // 脚注引用文本背景右下圆角
  @State
  footnoteRefTextBackgroundRadiusBottomRight: Length = 0.0

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let footnoteData: FootnoteData = router.getParams() as FootnoteData
      this.fileStr = getFileContextStr(footnoteData._pagePath)
      // ---------- 通用
      this.isFull = footnoteData._isFull
      this.incrementalAnalysis = footnoteData._incrementalAnalysis
      this.time = footnoteData._time
      this.textNumber = footnoteData._textNumber
      this.isMarkdownParserSync = footnoteData._isMarkdownParserSync
      this.isOnCopy = footnoteData._isOnCopy
      this.blockMarginTop = footnoteData._blockMarginTop
      this.blockMarginRight = footnoteData._blockMarginRight
      this.blockMarginBottom = footnoteData._blockMarginBottom
      this.blockMarginLeft = footnoteData._blockMarginLeft
      this.markdownBlockSpacing = footnoteData._markdownBlockSpacing
      this.isLineBreak = footnoteData._isLineBreak
      this.globalBackgroundColor = footnoteData._backgroundColor
      this.openGestureSwipe = footnoteData._openGestureSwipe
      this.openGestureSwipeTest = footnoteData._openGestureSwipeTest
      // ---------- 专有
      this.footnoteDefBackgroundColor = footnoteData._footnoteDefBackgroundColor
      this.footnoteDefMarginTop = footnoteData._footnoteDefMarginTop
      this.footnoteDefMarginRight = footnoteData._footnoteDefMarginRight
      this.footnoteDefMarginBottom = footnoteData._footnoteDefMarginBottom
      this.footnoteDefMarginLeft = footnoteData._footnoteDefMarginLeft
      this.footnoteDefPaddingTop = footnoteData._footnoteDefPaddingTop
      this.footnoteDefPaddingRight = footnoteData._footnoteDefPaddingRight
      this.footnoteDefPaddingBottom = footnoteData._footnoteDefPaddingBottom
      this.footnoteDefPaddingLeft = footnoteData._footnoteDefPaddingLeft
      this.footnoteRefTextFontColor = footnoteData._footnoteRefTextFontColor
      this.footnoteRefTextFontSize = footnoteData._footnoteRefTextFontSize
      this.footnoteRefTextFontStyle = footnoteData._footnoteRefTextFontStyle
      this.footnoteRefTextFontWeight = footnoteData._footnoteRefTextFontWeight
      this.footnoteRefTextFontFamily = footnoteData._footnoteRefTextFontFamily
      this.footnoteRefTextLineHeight = footnoteData._footnoteRefTextLineHeight
      this.footnoteRefTextLetterSpacing = footnoteData._footnoteRefTextLetterSpacing
      this.footnoteRefTextDecorationType = footnoteData._footnoteRefTextDecorationType
      this.footnoteRefTextDecorationColor = footnoteData._footnoteRefTextDecorationColor
      this.footnoteRefTextDecorationStyle = footnoteData._footnoteRefTextDecorationStyle
      this.footnoteRefTextBackgroundColor = footnoteData._footnoteRefTextBackgroundColor
      this.footnoteRefTextBackgroundRadiusTopLeft = footnoteData._footnoteRefTextBackgroundRadiusTopLeft
      this.footnoteRefTextBackgroundRadiusTopRight = footnoteData._footnoteRefTextBackgroundRadiusTopRight
      this.footnoteRefTextBackgroundRadiusBottomLeft = footnoteData._footnoteRefTextBackgroundRadiusBottomLeft
      this.footnoteRefTextBackgroundRadiusBottomRight = footnoteData._footnoteRefTextBackgroundRadiusBottomRight
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
        "脚注测试用例",
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
    
    // ---------- 专有 - FootnoteDef
    let footnoteDefTheme = new FootnoteDefTheme()
    if (this.footnoteDefBackgroundColor !== undefined) {
      footnoteDefTheme.setFootnoteDefBackgroundColor(this.footnoteDefBackgroundColor)
    }
    footnoteDefTheme.setFootnoteDefMargin({top: this.footnoteDefMarginTop, right: this.footnoteDefMarginRight, bottom: this.footnoteDefMarginBottom, left: this.footnoteDefMarginLeft})
    footnoteDefTheme.setFootnoteDefPadding({top: this.footnoteDefPaddingTop, right: this.footnoteDefPaddingRight, bottom: this.footnoteDefPaddingBottom, left: this.footnoteDefPaddingLeft})
    theme.setFootnoteDefTheme(footnoteDefTheme)
    
    // ---------- 专有 - FootnoteRef
    let footnoteRefTheme = new FootnoteRefTheme()
    if (this.footnoteRefTextFontColor !== undefined) {
      footnoteRefTheme.setFootnoteRefTextFontColor(this.footnoteRefTextFontColor)
    }
    if (this.footnoteRefTextFontSize !== undefined) {
      footnoteRefTheme.setFootnoteRefTextFontSize(this.footnoteRefTextFontSize)
    }
    if (this.footnoteRefTextFontStyle !== undefined) {
      footnoteRefTheme.setFootnoteRefTextFontStyle(this.footnoteRefTextFontStyle)
    }
    if (this.footnoteRefTextFontWeight !== undefined) {
      footnoteRefTheme.setFootnoteRefTextFontWeight(this.footnoteRefTextFontWeight)
    }
    if (this.footnoteRefTextFontFamily !== undefined) {
      footnoteRefTheme.setFootnoteRefTextFontFamily(this.footnoteRefTextFontFamily)
    }
    if (this.footnoteRefTextLineHeight !== undefined) {
      footnoteRefTheme.setFootnoteRefTextLineHeight(this.footnoteRefTextLineHeight)
    }
    if (this.footnoteRefTextLetterSpacing !== undefined) {
      footnoteRefTheme.setFootnoteRefTextLetterSpacing(this.footnoteRefTextLetterSpacing)
    }
    footnoteRefTheme.setFootnoteRefTextDecorationType(this.footnoteRefTextDecorationType)
    if (this.footnoteRefTextDecorationColor !== undefined) {
      footnoteRefTheme.setFootnoteRefTextDecorationColor(this.footnoteRefTextDecorationColor)
    }
    footnoteRefTheme.setFootnoteRefTextDecorationStyle(this.footnoteRefTextDecorationStyle)
    if (this.footnoteRefTextBackgroundColor !== undefined) {
      footnoteRefTheme.setFootnoteRefTextBackgroundColor(this.footnoteRefTextBackgroundColor)
    }
    footnoteRefTheme.setFootnoteRefTextBackgroundRadius({
      topLeft: this.footnoteRefTextBackgroundRadiusTopLeft,
      topRight: this.footnoteRefTextBackgroundRadiusTopRight,
      bottomLeft: this.footnoteRefTextBackgroundRadiusBottomLeft,
      bottomRight: this.footnoteRefTextBackgroundRadiusBottomRight
    })
    theme.setFootnoteRefTheme(footnoteRefTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsFootnotePlugin(true)
    return plugin
  }

  footnoteCallback(y: number | undefined): void {
    if(y !==undefined){
      hilog.error(1, "1", `---y:${y}`)
      // if (this.openGestureSwipeTest) {
      //   this.markdownScroller.scrollToIndex(y)
      // } else {
      //   let rect = this.markdownScroller.getItemRect(y)
      //   this.scroller.scrollTo({xOffset:0, yOffset: rect.getItemRectY()})
      // }
    }
  }
}
