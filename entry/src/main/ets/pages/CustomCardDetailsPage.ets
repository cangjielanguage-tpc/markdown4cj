import {
  CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
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
 * 自定义卡片测试用例
 * md文本中 alt="Custom" 的图片和 description="Custom" 的链接由自定义Builder渲染
 */
@Entry
@Component
struct CustomCardDetailsPage {
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
  @State // 是否启用解析节流
  enableParseThrottle: boolean = false
  @State // 解析节流间隔（ms）
  parseThrottleMs: number = 200
  // 是否启用自定义卡片
  isCustomCard: boolean = true

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
    } catch (e) {
    }
    this.markdownPlugin = this.setPlugin()
    this.markdownTheme = this.setMarkdownTheme()
    this.markdownConfiguration = this.setMarkdownConfig()
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
    this.isInputEnded = true
    this.content = this.fileStr
  }

  /**
   * 自定义块级图片卡片
   */
  @Builder
  CustomBlockImageBuilder(url: string, alt: string, title: string) {
    Column({ space: 10 }) {
      Text(`${alt}-----${title}-----${url}`)
        .fontSize(14)
        .fontColor(0xFF333333)
      Image(url)
        .width('80%')
        .objectFit(ImageFit.Contain)
    }
    .padding(10)
    .backgroundColor(0xFFF0F8FF)
    .borderRadius(10)
    .width('100%')
  }

  /**
   * 自定义块级链接卡片
   */
  @Builder
  CustomBlockLinkBuilder(url: string, description: string, title: string) {
    Column({ space: 10 }) {
      Text(`${description}-----${title}-----${url}`)
        .fontSize(14)
        .fontColor(0xFF333333)
      Text("点击访问")
        .fontSize(14)
        .fontColor(0xFF317AFF)
        .padding({ left: 10, right: 10, top: 5, bottom: 5 })
        .borderRadius(5)
        .backgroundColor(0xFF317AFF22)
    }
    .padding(10)
    .backgroundColor(0xFFF0FFF0)
    .borderRadius(10)
    .width('100%')
  }

  /**
   * 自定义行内图片卡片
   */
  @Builder
  CustomInLineImageBuilder(url: string, alt: string, title: string) {
    Row({ space: 5 }) {
      Image(url)
        .width(40)
        .height(40)
        .objectFit(ImageFit.Cover)
        .borderRadius(5)
      Text(`${alt}-${title}`)
        .fontSize(13)
        .fontColor(0xFF317AFF)
    }
    .alignItems(VerticalAlign.Center)
  }

  /**
   * 自定义行内链接卡片
   */
  @Builder
  CustomInLineLinkBuilder(url: string, description: string, title: string) {
    Text(`${description}-${title}`)
      .fontSize(13)
      .fontColor(0xFFFF6600)
      .decoration({ type: TextDecorationType.Underline, color: 0xFFFF6600 })
      .onClick(() => {
        hilog.error(1, "customCard", `---inline link click:${url}`)
        this.getUIContext().getPromptAction().showToast({ message: `自定义链接卡片: ${url}`, duration: 2000 })
      })
  }

  build() {
    Column() {
      titleComponent(
        "自定义卡片测试用例",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Scroll(this.scroller) {
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
      .align(Alignment.TopStart)
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    if (this.isCustomCard) {
      // 自定义块级图片卡片条件 - alt为Custom
      config.setIsBlockImageCustom((url: string) => {
        return url === "Custom"
      })
      // 自定义行内图片卡片条件 - alt为Custom
      config.setIsInLineImageCustom((url: string) => {
        return url === "Custom"
      })
      // 自定义行内链接卡片条件 - description为Custom
      config.setIsInLineLinkCustom((url: string) => {
        return url === "Custom"
      })
    }
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
    globalTheme.setEnableParseThrottle(this.enableParseThrottle)
    globalTheme.setParseThrottleMs(this.parseThrottleMs)
    theme.setGlobalTheme(globalTheme)
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true)
    plugin.setIsHtmlPlugin(true)
    return plugin
  }
}
