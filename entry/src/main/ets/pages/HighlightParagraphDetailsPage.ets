import {
  CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  MarkdownHighlightParagraph,
  MarkdownScroller,
  MarkdownTheme
} from '@cangjie-tpc/markdown_hybrid'
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { BaseMDData } from '../model/BaseMDData'
import { ConfigurationConstant } from '@kit.AbilityKit'

/**
 * 段落高亮测试用例
 * 加载Markdown后点击"获取段落列表"，再点击"高亮下一段"逐段高亮，"清除所有高亮"恢复
 */
@Entry
@Component
struct HighlightParagraphDetailsPage {
  // ---------- 通用
  scroller: Scroller = new Scroller()
  markdownScroller: MarkdownScroller = new MarkdownScroller()
  @StorageProp('safeTop')
  safeTop: number = 0
  @StorageProp('currentColorMode')
  @Watch('onColorModeChange')
  currentColorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
  @State
  fileStr: string = ""
  @State
  content: string = ""
  @State
  isFull: boolean = true
  @State
  incrementalAnalysis: boolean = false
  @State // 是否启用解析节流
  enableParseThrottle: boolean = false
  @State // 解析节流间隔（ms）
  parseThrottleMs: number = 200
  @State
  time: number = 50
  @State
  textNumber: number = 10
  @State
  isInputEnded: boolean = false

  // ---------- 专有
  @State
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()
  @State
  isRefresh: boolean = true
  // 段落高亮对象
  highlightParagraph: MarkdownHighlightParagraph = new MarkdownHighlightParagraph()
  @State // 段落nodeHash集合
  paragraphItems: Array<string> = new Array<string>()
  // 当前高亮段落索引
  nodeHashIndex: number = -1

  onColorModeChange(): void {
    if (this.currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      this.markdownTheme.setDefaultTheme()
      this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
    } else {
      this.markdownTheme.setDarculaTheme()
      this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
    }
    this.isRefresh = !this.isRefresh
  }

  aboutToAppear(): void {
    try {
      let baseData: BaseMDData = router.getParams() as BaseMDData
      this.fileStr = getFileContextStr(baseData._pagePath)
      this.isFull = baseData._isFull
      this.incrementalAnalysis = baseData._incrementalAnalysis
      this.enableParseThrottle = baseData._enableParseThrottle
      this.parseThrottleMs = baseData._parseThrottleMs
      this.time = baseData._time
      this.textNumber = baseData._textNumber
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

  /**
   * 获取所有段落nodeHash集合
   */
  getParagraphItems(): void {
    this.paragraphItems = this.highlightParagraph.getAllParagraphItems()
    hilog.error(1, "highlightParagraph", `---paragraphItems:${JSON.stringify(this.paragraphItems)}`)
  }

  /**
   * 高亮下一段
   */
  highlightNextParagraph(): void {
    if (this.paragraphItems.length === 0) {
      this.getParagraphItems()
    }
    if (this.paragraphItems.length === 0) {
      return
    }
    // 清除上一段的高亮
    if (this.nodeHashIndex >= 0 && this.nodeHashIndex < this.paragraphItems.length) {
      this.highlightParagraph.clearParagraphHighlight(this.paragraphItems[this.nodeHashIndex])
    }
    // 高亮下一段（交替两种颜色）
    this.nodeHashIndex = this.nodeHashIndex + 1
    if (this.nodeHashIndex >= this.paragraphItems.length) {
      this.nodeHashIndex = 0
    }
    if (this.nodeHashIndex % 2 === 0) {
      this.highlightParagraph.setParagraphHighlight(this.paragraphItems[this.nodeHashIndex], 0xFFFA8072)
    } else {
      this.highlightParagraph.setParagraphHighlight(this.paragraphItems[this.nodeHashIndex], 0xFFFFD700)
    }
  }

  /**
   * 全部段落高亮（交替两种颜色，验证多段落同时高亮）
   */
  highlightAllParagraphs(): void {
    if (this.paragraphItems.length === 0) {
      this.getParagraphItems()
    }
    for (let i = 0; i < this.paragraphItems.length; i++) {
      if (i % 2 === 0) {
        this.highlightParagraph.setParagraphHighlight(this.paragraphItems[i], 0xFFFA8072)
      } else {
        this.highlightParagraph.setParagraphHighlight(this.paragraphItems[i], 0xFFFFD700)
      }
    }
  }

  /**
   * 清除所有段落的高亮
   */
  clearAllParagraphHighlights(): void {
    this.highlightParagraph.clearAllParagraphHighlights()
    this.nodeHashIndex = -1
  }

  build() {
    Column() {
      titleComponent(
        "段落高亮测试用例",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Flex({ wrap: FlexWrap.Wrap }) {
        Button("获取段落")
          .height(35)
          .type(ButtonType.Capsule)
          .padding({ left: 8, right: 8 })
          .margin({ left: 5, right: 5 })
          .fontColor(0xFFFFFFFF)
          .backgroundColor(0xFF317AFF)
          .fontSize(12)
          .onClick(() => {
            this.getParagraphItems()
          })
        Button("下一段")
          .height(35)
          .type(ButtonType.Capsule)
          .padding({ left: 8, right: 8 })
          .margin({ left: 5, right: 5 })
          .fontColor(0xFFFFFFFF)
          .backgroundColor(0xFF317AFF)
          .fontSize(12)
          .onClick(() => {
            this.highlightNextParagraph()
          })
        Button("全部高亮")
          .height(35)
          .type(ButtonType.Capsule)
          .padding({ left: 8, right: 8 })
          .margin({ left: 5, right: 5 })
          .fontColor(0xFFFFFFFF)
          .backgroundColor(0xFF317AFF)
          .fontSize(12)
          .onClick(() => {
            this.highlightAllParagraphs()
          })
        Button("清除高亮")
          .height(35)
          .type(ButtonType.Capsule)
          .padding({ left: 8, right: 8 })
          .margin({ left: 5, right: 5 })
          .fontColor(0xFFFFFFFF)
          .backgroundColor(0xFF317AFF)
          .fontSize(12)
          .onClick(() => {
            this.clearAllParagraphHighlights()
          })
      }
      .width('100%')
      .margin({ top: 5, bottom: 5 })
      Text(`段落总数: ${this.paragraphItems.length}`)
        .fontSize(12)
        .fontColor(0xFF666666)
        .margin({ bottom: 5 })
      Scroll(this.scroller) {
        if (this.isRefresh) {
          Column() {
            CJMarkdown({
              content: this.content,
              isInputEnded: this.isInputEnded,
              incrementalAnalysis: this.incrementalAnalysis,
              listScroller: this.markdownScroller,
              config: this.markdownConfiguration,
              plugin: this.markdownPlugin
            })
          }
        } else {
          Column() {
            CJMarkdown({
              content: this.content,
              isInputEnded: this.isInputEnded,
              incrementalAnalysis: this.incrementalAnalysis,
              listScroller: this.markdownScroller,
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
    // 段落高亮配置
    config.setMarkdownHighlightParagraph(this.highlightParagraph)
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
    globalTheme.setIsMarkdownParserSync(true)
    theme.setGlobalTheme(globalTheme)
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    return plugin
  }
}
