import {
  CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownExposureEvent, MarkdownPlugin,
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
 * 曝光事件日志项 - 对齐仓颉侧 ExposureLogItem: seq/visible/url
 */
class ExposureLogItem {
  seq: number
  visible: boolean
  url: string

  constructor(seq: number, visible: boolean, url: string) {
    this.seq = seq
    this.visible = visible
    this.url = url
  }
}

/**
 * 超链接曝光测试用例
 * 加载Markdown后滚动内容，屏幕底部实时显示链接曝光事件（显示=绿/消失=红）
 */
@Entry
@Component
struct LinkExposureDetailsPage {
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
  // 是否启用解析节流列表
  enableParseThrottleList: Array<boolean> = booleanListGeneralData
  @State // 是否启用解析节流
  enableParseThrottle: boolean = false
  // 解析节流间隔列表
  parseThrottleMsList: Array<number> = timeListGeneralData
  @State // 解析节流间隔（ms）
  parseThrottleMs: number = 200
  @State
  textNumber: number = 10
  @State
  isInputEnded: boolean = false

  // ---------- 专有
  @State // 曝光可见阈值(0~1)
  exposureThreshold: number = 0.5
  @State
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()
  @State
  isRefresh: boolean = true
  // 曝光事件总数
  debugEventCount: number = 0
  @State // 曝光事件列表
  exposureEvents: Array<ExposureLogItem> = new Array<ExposureLogItem>()

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
      this.enableParseThrottle = baseData._enableParseThrottle
      this.parseThrottleMs = baseData._parseThrottleMs
      this.textNumber = baseData._textNumber
    } catch (e) {
    }
    this.markdownPlugin = this.setPlugin()
    this.markdownTheme = this.setMarkdownTheme()
    this.markdownConfiguration = this.setMarkdownConfig()
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
  }

  /**
   * 元素曝光回调
   */
  exposureCallback(event: MarkdownExposureEvent): void {
    hilog.error(1, "elementExposure", `---elementExposure type:${event.eventType} visible:${event.visible} data:${event.data}`)
    this.debugEventCount = this.debugEventCount + 1
    // eventType=1(显示)/0(消失)对齐仓颉侧；data为链接url
    let item = new ExposureLogItem(this.debugEventCount, event.visible, event.data)
    // 重新赋值确保 @State 触发更新
    let next: Array<ExposureLogItem> = []
    for (let e of this.exposureEvents) {
      next.push(e)
    }
    next.push(item)
    // 最多保留最近100条
    if (next.length > 100) {
      next = next.slice(next.length - 100)
    }
    this.exposureEvents = next

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
      }, 50)
    }
  }

  build() {
    Column() {
      titleComponent(
        "超链接曝光测试用例",
        0xFF317AFF,
        true,
        this.safeTop
      )
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
      // 曝光事件显示区
      Text(`曝光事件（count=${this.debugEventCount} 最近${this.exposureEvents.length}条 阈值${this.exposureThreshold}）`)
        .fontSize(12)
        .fontColor(0xFF333333)
        .padding({ left: 5, top: 3 })
        .width('100%')
        .backgroundColor(0xFFEAEAEA)
      List() {
        ForEach(this.exposureEvents, (item: ExposureLogItem, index: number) => {
          ListItem() {
            Text(`${item.seq}-${item.visible ? '显示' : '消失'}-${item.url}`)
              .fontSize(12)
              .fontColor(item.visible ? 0xFF00AA00 : 0xFFAA0000)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .padding({ left: 5, right: 5 })
              .width('100%')
          }
        }, (item: ExposureLogItem) => `${item.seq}`)
      }
      .height(120)
      .backgroundColor(0xFFFFFFFF)
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    // 元素曝光回调
    config.setElementExposureCallback(this.exposureCallback.bind(this))
    // 曝光可见阈值
    config.setExposureThreshold(this.exposureThreshold)
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
    plugin.setIsLinkifyPlugin(true)
    return plugin
  }
}
