import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme,
  ParagraphTheme} from '@cangjie-tpc/markdown_arkui'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { ParagraphData } from '../model/ParagraphData'
import { ConfigurationConstant } from '@kit.AbilityKit'
import { COLOR_FF4A90E2, NUM_FFE9967A } from '@cangjie-tpc/markdown_arkui/src/main/ets/base/Constants'
import {
  MarkdownHighlightParagraph
} from '@cangjie-tpc/markdown_arkui/src/main/ets/configs/MarkdownHighlightParagraph'

@Entry
@Component
struct ParagraphDetailsPage {
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
  @State // 当前长按未触发弹窗时段落前的背景色
  beforeSelectedParagraphBackgroundColor: ResourceColor | undefined = undefined
  @State // 当前长按放手后选中文字的背景色
  selectedParagraphBackgroundColor: ResourceColor | undefined = undefined

  // ---------- 专有
  @State // 段落背景颜色
  paragraphBackgroundColor: ResourceColor | undefined = undefined
  @State // 段落上外边距
  paragraphMarginTop: Length = 0.0
  @State // 段落右外边距
  paragraphMarginRight: Length = 0.0
  @State // 段落下外边距
  paragraphMarginBottom: Length = 0.0
  @State // 段落左外边距
  paragraphMarginLeft: Length = 0.0
  @State // 段落上内边距
  paragraphPaddingTop: Length = 0.0
  @State // 段落右内边距
  paragraphPaddingRight: Length = 0.0
  @State // 段落下内边距
  paragraphPaddingBottom: Length = 0.0
  @State // 段落左内边距
  paragraphPaddingLeft: Length = 0.0
  @State // 段落文本颜色
  paragraphTextFontColor: ResourceColor | undefined = undefined
  @State // 段落文本尺寸
  paragraphTextFontSize: number | string | Resource = 14.0
  @State // 段落文本字体样式
  paragraphTextFontStyle: FontStyle = FontStyle.Normal
  @State // 段落文本字体粗细
  paragraphTextFontWeight: number | FontWeight = FontWeight.Normal
  @State // 段落文本字体
  paragraphTextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 段落文本行高
  paragraphTextLineHeight: number | string | Resource = 22.0
  @State // 段落文本字符间距
  paragraphTextLetterSpacing: number = 0.0
  @State // 段落加载动画是否启用
  paragraphHeadingAnimationEnabled: boolean = false
  @State // 段落加载动画时长（ms）
  paragraphHeadingAnimationDuration: number = 0

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()
  @State // 段落背景高亮设置
  markdownHighlight: MarkdownHighlightParagraph = new MarkdownHighlightParagraph()

  @State
  showHighlight: boolean = true
  currentIndex: number = -1
  currentItem: string = ''
  highlightIndexList: string[] = []

  aboutToAppear(): void {
    try {
      let paragraphData: ParagraphData = router.getParams() as ParagraphData
      this.fileStr = getFileContextStr(paragraphData._pagePath)
      // ---------- 通用
      this.isFull = paragraphData._isFull
      this.incrementalAnalysis = paragraphData._incrementalAnalysis
      this.enableParseThrottle = paragraphData._enableParseThrottle
      this.parseThrottleMs = paragraphData._parseThrottleMs
      this.time = paragraphData._time
      this.textNumber = paragraphData._textNumber
      this.isMarkdownParserSync = paragraphData._isMarkdownParserSync
      this.isOnCopy = paragraphData._isOnCopy
      this.blockMarginTop = paragraphData._blockMarginTop
      this.blockMarginRight = paragraphData._blockMarginRight
      this.blockMarginBottom = paragraphData._blockMarginBottom
      this.blockMarginLeft = paragraphData._blockMarginLeft
      this.markdownBlockSpacing = paragraphData._markdownBlockSpacing
      this.isLineBreak = paragraphData._isLineBreak
      this.globalBackgroundColor = paragraphData._backgroundColor
      this.openGestureSwipe = paragraphData._openGestureSwipe
      this.openGestureSwipeTest = paragraphData._openGestureSwipeTest
      this.showHighlight = paragraphData._showHighlight
      this.beforeSelectedParagraphBackgroundColor = paragraphData._beforeSelectedParagraphBackgroundColor
      this.selectedParagraphBackgroundColor = paragraphData._selectedParagraphBackgroundColor
      // ---------- 专有
      this.paragraphBackgroundColor = paragraphData._paragraphBackgroundColor
      this.paragraphMarginTop = paragraphData._paragraphMarginTop
      this.paragraphMarginRight = paragraphData._paragraphMarginRight
      this.paragraphMarginBottom = paragraphData._paragraphMarginBottom
      this.paragraphMarginLeft = paragraphData._paragraphMarginLeft
      this.paragraphPaddingTop = paragraphData._paragraphPaddingTop
      this.paragraphPaddingRight = paragraphData._paragraphPaddingRight
      this.paragraphPaddingBottom = paragraphData._paragraphPaddingBottom
      this.paragraphPaddingLeft = paragraphData._paragraphPaddingLeft
      this.paragraphTextFontColor = paragraphData._paragraphTextFontColor
      this.paragraphTextFontSize = paragraphData._paragraphTextFontSize
      this.paragraphTextFontStyle = paragraphData._paragraphTextFontStyle
      this.paragraphTextFontWeight = paragraphData._paragraphTextFontWeight
      this.paragraphTextFontFamily = paragraphData._paragraphTextFontFamily
      this.paragraphTextLineHeight = paragraphData._paragraphTextLineHeight
      this.paragraphTextLetterSpacing = paragraphData._paragraphTextLetterSpacing
      this.paragraphHeadingAnimationEnabled = paragraphData._paragraphHeadingAnimationEnabled
      this.paragraphHeadingAnimationDuration = paragraphData._paragraphHeadingAnimationDuration
    } catch (e) {
    }
    this.markdownPlugin = this.setPlugin()
    this.markdownTheme = this.setMarkdownTheme()
    this.markdownConfiguration = this.setMarkdownConfig()
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
    this.markdownHighlight = this.markdownConfiguration.getMarkdownHighlightParagraph()

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
        "段落测试用例",
        0xFF317AFF,
        true,
        this.safeTop
      )
      if (this.showHighlight) {
        Row() {
          Button("获取所有高亮节点").fontSize(14)
            .onClick(() => {
              this.highlightIndexList = this.markdownHighlight.getAllParagraphItems()
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
                this.markdownHighlight.clearParagraphHighlight(this.highlightIndexList[this.currentIndex])
                this.currentIndex = this.currentIndex - 1
                this.markdownHighlight.setParagraphHighlight(this.highlightIndexList[this.currentIndex], COLOR_FF4A90E2)
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
                this.markdownHighlight.clearParagraphHighlight(this.highlightIndexList[this.currentIndex])
                this.currentIndex = this.currentIndex + 1
                this.markdownHighlight.setParagraphHighlight(this.highlightIndexList[this.currentIndex], NUM_FFE9967A)
              }
              hilog.error(1111, 'MarkdownCX', '当前id：' + this.currentIndex)
            })

          Button("清除所有").fontSize(14)
            .onClick(() => {
              this.markdownHighlight.clearAllParagraphHighlights()
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
    config.setParagraphHeadingAnimationStart(this.paragraphHeadingAnimationStartCallBack)
    config.setParagraphHeadingAnimationEnd(this.paragraphHeadingAnimationEndCallBack)
    if (this.beforeSelectedParagraphBackgroundColor !== undefined) {
      config.getMarkdownHighlightParagraph().setBeforeSelectedParagraphBackgroundColor(this.beforeSelectedParagraphBackgroundColor)
    }
    if (this.selectedParagraphBackgroundColor !== undefined) {
      config.getMarkdownHighlightParagraph().setSelectedParagraphBackgroundColor(this.selectedParagraphBackgroundColor)
    }
    config.setLongCallback(this.longPressCallback.bind(this))
    return config
  }

  paragraphHeadingAnimationStartCallBack(): void {
    hilog.error(1, "paragraphAnimation", `---AnimationStart`)
  }

  paragraphHeadingAnimationEndCallBack(): void {
    hilog.error(1, "paragraphAnimation", `---AnimationEnd`)
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
    globalTheme.setParagraphHeadingAnimationEnabled(this.paragraphHeadingAnimationEnabled)
    globalTheme.setParagraphHeadingAnimationDuration(this.paragraphHeadingAnimationDuration)
    theme.setGlobalTheme(globalTheme)
    
    // ---------- 专有 - Paragraph
    let paragraphTheme = new ParagraphTheme()
    if (this.paragraphBackgroundColor !== undefined) {
      paragraphTheme.setParagraphBackgroundColor(this.paragraphBackgroundColor)
    }
    paragraphTheme.setParagraphMargin({top: this.paragraphMarginTop, right: this.paragraphMarginRight, bottom: this.paragraphMarginBottom, left: this.paragraphMarginLeft})
    paragraphTheme.setParagraphPadding({top: this.paragraphPaddingTop, right: this.paragraphPaddingRight, bottom: this.paragraphPaddingBottom, left: this.paragraphPaddingLeft})
    if (this.paragraphTextFontColor !== undefined) {
      paragraphTheme.setParagraphTextFontColor(this.paragraphTextFontColor)
    }
    paragraphTheme.setParagraphTextFontSize(this.paragraphTextFontSize)
    paragraphTheme.setParagraphTextFontStyle(this.paragraphTextFontStyle)
    paragraphTheme.setParagraphTextFontWeight(this.paragraphTextFontWeight)
    paragraphTheme.setParagraphTextFontFamily(this.paragraphTextFontFamily)
    paragraphTheme.setParagraphTextLineHeight(this.paragraphTextLineHeight)
    paragraphTheme.setParagraphTextLetterSpacing(this.paragraphTextLetterSpacing)
    theme.setParagraphTheme(paragraphTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    return plugin
  }

  longPressCallback(): void {
    hilog.error(1, "1", `-----> 自定义长按回调方法触发 <-----`)
  }
}
