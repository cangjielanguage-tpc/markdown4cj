import {
  CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownNodeViewString, MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme
} from '@cangjie-tpc/markdown_hybrid'
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { pasteboard } from '@kit.BasicServicesKit'
import { BaseMDData } from '../model/BaseMDData'
import { ConfigurationConstant } from '@kit.AbilityKit'

/**
 * 全文复制测试用例
 * 加载Markdown后点击"获取全文文本"，将Markdown渲染后的纯文本展示并复制到剪贴板
 */
@Entry
@Component
struct AllPageCopyDetailsPage {
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
  // 全文文本对象
  nodeViewString: MarkdownNodeViewString = new MarkdownNodeViewString()
  @State
  allText: string = ""

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
      this.time = baseData._time
      this.textNumber = baseData._textNumber
    } catch (e) {
    }
    this.markdownPlugin = this.setPlugin()
    this.markdownTheme = this.setMarkdownTheme()
    this.markdownConfiguration = this.setMarkdownConfig()
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
  }

  /**
   * 获取全文文本并复制到剪贴板
   */
  getAllText(): void {
    this.allText = this.nodeViewString.toString()
    hilog.error(1, "allPageCopy", `---allText:${this.allText}`)
    let systemPasteboard = pasteboard.getSystemPasteboard()
    systemPasteboard.setData(pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, this.allText))
    this.getUIContext().getPromptAction().showToast({ message: "全文已复制", duration: 2000 })
  }

  build() {
    Column() {
      titleComponent(
        "全文复制测试用例",
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
      Button("获取全文文本并复制")
        .height(40)
        .width("80%")
        .type(ButtonType.Capsule)
        .margin({ top: 5, bottom: 5 })
        .fontColor(0xFFFFFFFF)
        .backgroundColor(0xFF317AFF)
        .align(Alignment.Center)
        .fontSize(16)
        .onClick(() => {
          this.getAllText()
        })
      if (this.allText !== "") {
        Text(`全文文本（${this.allText.length}字符）：`)
          .fontSize(12)
          .fontColor(0xFF666666)
          .margin({ left: 10 })
          .width('100%')
        Text(this.allText)
          .fontSize(12)
          .fontColor(0xFF333333)
          .padding(10)
          .margin({ left: 10, right: 10, bottom: 5 })
          .backgroundColor(0xFFFFFFFF)
          .borderRadius(5)
          .maxLines(5)
          .width('calc(100% - 20)')
      }
      Scroll(this.scroller) {
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
      .align(Alignment.TopStart)
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    // 全文复制配置
    config.setNodeString(this.nodeViewString)
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
    plugin.setIsTablePlugin(true)
    plugin.setIsHtmlPlugin(true)
    plugin.setIsTaskListPlugin(true)
    plugin.setIsStrikethroughPlugin(true)
    return plugin
  }
}
