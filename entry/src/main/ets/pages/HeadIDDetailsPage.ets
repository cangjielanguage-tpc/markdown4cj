import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { HeadIDData } from '../model/HeadIDData'
import { ConfigurationConstant } from '@kit.AbilityKit'
import { COLOR_FF4A90E2, NUM_FFE9967A } from '@cangjie-tpc/markdown_hybrid/src/main/ets/base/Constants'

@Entry
@Component
struct HeadIDDetailsPage {
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

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  @State
  showHighlight: boolean = true
  currentIndex: number = -1
  currentItem: string = ''
  highlightIndexList: string[] = []

  aboutToAppear(): void {
    try {
      let headIDData: HeadIDData = router.getParams() as HeadIDData
      this.fileStr = getFileContextStr(headIDData._pagePath)
      // ---------- 通用
      this.isFull = headIDData._isFull
      this.incrementalAnalysis = headIDData._incrementalAnalysis
      this.enableParseThrottle = headIDData._enableParseThrottle
      this.parseThrottleMs = headIDData._parseThrottleMs
      this.time = headIDData._time
      this.textNumber = headIDData._textNumber
      this.isMarkdownParserSync = headIDData._isMarkdownParserSync
      this.isOnCopy = headIDData._isOnCopy
      this.blockMarginTop = headIDData._blockMarginTop
      this.blockMarginRight = headIDData._blockMarginRight
      this.blockMarginBottom = headIDData._blockMarginBottom
      this.blockMarginLeft = headIDData._blockMarginLeft
      this.markdownBlockSpacing = headIDData._markdownBlockSpacing
      this.isLineBreak = headIDData._isLineBreak
      this.globalBackgroundColor = headIDData._backgroundColor
      this.openGestureSwipe = headIDData._openGestureSwipe
      this.openGestureSwipeTest = headIDData._openGestureSwipeTest
      this.showHighlight = headIDData._showHighlight
      // ---------- 专有
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
        "标题ID测试用例",
        0xFF317AFF,
        true,
        this.safeTop
      )
      if (this.showHighlight) {
        Row() {
          Button("获取所有高亮节点").fontSize(14)
            .onClick(() => {
              this.highlightIndexList = this.getAllItems()
              hilog.error(1111, 'MarkdownCX', '所有ID：' + this.highlightIndexList)
            })

          Button("上一个").fontSize(14)
            .onClick(() => {
              hilog.error(1111, 'MarkdownCX', '当前id：' + this.currentIndex)
              if (this.currentIndex < 0) {
                // 当前已经是最后一个，不做修改
                this.currentIndex = -1
              } else {
                // 删除当前高亮，添加上一个高亮
                this.markdownConfiguration.markdownHighlightParagraph.clearParagraphHighlight(this.highlightIndexList[this.currentIndex])
                this.currentIndex = this.currentIndex - 1
                this.markdownConfiguration.markdownHighlightParagraph.setParagraphHighlight(this.highlightIndexList[this.currentIndex], COLOR_FF4A90E2)
              }
              hilog.error(1111, 'MarkdownCX', '当前id：' + this.currentIndex)
            })

          Button("下一个").fontSize(14)
            .onClick(() => {
              hilog.error(1111, 'MarkdownCX', '当前id：' + this.currentIndex)
              if (this.currentIndex >= this.highlightIndexList.length) {
                // 当前已经是最后一个，不做修改
                this.currentIndex = this.highlightIndexList.length
              } else {
                // 删除当前高亮，添加上一个高亮
                this.markdownConfiguration.markdownHighlightParagraph.clearParagraphHighlight(this.highlightIndexList[this.currentIndex])
                this.currentIndex = this.currentIndex + 1
                this.markdownConfiguration.markdownHighlightParagraph.setParagraphHighlight(this.highlightIndexList[this.currentIndex], NUM_FFE9967A)
              }
              hilog.error(1111, 'MarkdownCX', '当前id：' + this.currentIndex)
            })

          Button("清除所有").fontSize(14)
            .onClick(() => {
              this.markdownConfiguration.markdownHighlightParagraph.clearAllParagraphHighlights()
              this.currentIndex = -1
              this.currentItem = ''
            })
        }
        .padding(3).margin(3).align(Alignment.Start)
      }
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
    plugin.setIsHeadIDPlugin(true)
    return plugin
  }

  tocIndexCallback(y: number | undefined): void {
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

  getAllItems(): Array<string> {
    return this.markdownConfiguration.markdownHighlightParagraph.getAllParagraphItems()
  }
}