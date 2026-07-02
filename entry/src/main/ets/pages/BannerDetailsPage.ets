import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import {
  BannerTheme,
  CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { BannerData } from '../model/BannerData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct BannerDetailsPage {
  // ---------- 通用
  scroller: Scroller = new Scroller() // 滑动控制器
  // markdownScroller: MarkdownScroller = new MarkdownScroller() // Markdown的控制器
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
  @State // 增量加载每次间隔时间
  time: number = 50
  @State // 增量每次增量文本数量
  textNumber: number = 10
  @State // 是否同步解析Markdown文本
  isMarkdownParserSync: boolean = false
  @State // 是否打开长按复制粘贴效果
  isOnCopy: boolean = false
  @State // markdown全局上外边距
  blockMarginTop: number = 0
  @State // markdown全局右外边距
  blockMarginRight: number = 0
  @State // markdown全局下外边距
  blockMarginBottom: number = 0
  @State // markdown全局左外边距
  blockMarginLeft: number = 0
  @State // 模块间上下间距
  markdownBlockSpacing: number = 8
  @State // 软换行是否换行
  isLineBreak: boolean = false
  @State // 背景颜色
  globalBackgroundColor: ResourceColor | undefined = undefined
  @State // 是否允许markdown控件自身响应滑动
  openGestureSwipe: boolean = false
  @State // 是否开启响应滑动测试
  openGestureSwipeTest: boolean = false
  @State // 流式输入是否输入结束(true:结束输入,false:持续输入)
  isInputEnded: boolean = false

  // ---------- Banner专有配置
  @State // banner上外边距
  bannerMarginTop: Length = 0.0
  @State // banner右外边距
  bannerMarginRight: Length = 0.0
  @State // banner下外边距
  bannerMarginBottom: Length = 0.0
  @State // banner左外边距
  bannerMarginLeft: Length = 0.0
  @State // banner上内边距
  bannerPaddingTop: Length = 0.0
  @State // banner右内边距
  bannerPaddingRight: Length = 0.0
  @State // banner下内边距
  bannerPaddingBottom: Length = 0.0
  @State // banner左内边距
  bannerPaddingLeft: Length = 0.0
  @State // banner占位图
  bannerPlaceholder: Resource | undefined = undefined

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let bannerData: BannerData = router.getParams() as BannerData
      this.fileStr = getFileContextStr(bannerData._pagePath)
      // ---------- 通用
      this.isFull = bannerData._isFull
      this.incrementalAnalysis = bannerData._incrementalAnalysis
      this.time = bannerData._time
      this.textNumber = bannerData._textNumber
      this.isMarkdownParserSync = bannerData._isMarkdownParserSync
      this.isOnCopy = bannerData._isOnCopy
      this.blockMarginTop = bannerData._blockMarginTop
      this.blockMarginRight = bannerData._blockMarginRight
      this.blockMarginBottom = bannerData._blockMarginBottom
      this.blockMarginLeft = bannerData._blockMarginLeft
      this.markdownBlockSpacing = bannerData._markdownBlockSpacing
      this.isLineBreak = bannerData._isLineBreak
      this.globalBackgroundColor = bannerData._backgroundColor
      this.openGestureSwipe = bannerData._openGestureSwipe
      this.openGestureSwipeTest = bannerData._openGestureSwipeTest
      // ---------- Banner专有配置
      this.bannerMarginTop = bannerData._bannerMarginTop
      this.bannerMarginRight = bannerData._bannerMarginRight
      this.bannerMarginBottom = bannerData._bannerMarginBottom
      this.bannerMarginLeft = bannerData._bannerMarginLeft
      this.bannerPaddingTop = bannerData._bannerPaddingTop
      this.bannerPaddingRight = bannerData._bannerPaddingRight
      this.bannerPaddingBottom = bannerData._bannerPaddingBottom
      this.bannerPaddingLeft = bannerData._bannerPaddingLeft
      this.bannerPlaceholder = bannerData._bannerPlaceholder
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
        "Banner配置详情",
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
    config.setLinkCallback(this.linkCallBack.bind(this))
    config.setImageCallback(this.imageCallback.bind(this))
    config.setAudioCallback(this.audioCallback.bind(this))
    config.setVideoCallback(this.videoCallback.bind(this))
    config.setVideoImageCallback(this.videoImageCallback.bind(this))
    config.setCodeCopyCallback(this.codeCopyCallback.bind(this))
    config.setCodeFullScreenCallback(this.codeFullScreenCallback.bind(this))
    config.setLatexImageCallback(this.latexCallBack.bind(this))
    config.setTocIndexCallback(this.tocIndexCallback.bind(this))
    config.setFootnoteCallback(this.footnoteCallback.bind(this))
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
    globalTheme.setGlobalMargin({top: this.blockMarginTop, right: this.blockMarginRight, bottom: this.blockMarginBottom, left: this.blockMarginLeft})
    globalTheme.setBlockSpacing(this.markdownBlockSpacing)
    globalTheme.setIsLineBreak(this.isLineBreak)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    if (this.globalBackgroundColor !== undefined) {
      globalTheme.setBackgroundColor(this.globalBackgroundColor)
    }
    theme.setGlobalTheme(globalTheme)
    
    // ---------- Banner专有配置
    let bannerTheme = new BannerTheme()
    bannerTheme.setBannerMargin({top: this.bannerMarginTop, right: this.bannerMarginRight, bottom: this.bannerMarginBottom, left: this.bannerMarginLeft})
    bannerTheme.setBannerPadding({top: this.bannerPaddingTop, right: this.bannerPaddingRight, bottom: this.bannerPaddingBottom, left: this.bannerPaddingLeft})
    if (this.bannerPlaceholder !== undefined) {
      bannerTheme.setBannerPlaceholder(this.bannerPlaceholder)
    }
    theme.setBannerTheme(bannerTheme)
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsLatexMathPlugin(true) // 数学公式插件
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsLinkifyPlugin(true) // 自动链接插件
    plugin.setIsBlockAudioPlugin(true) // 音频插件
    plugin.setIsBlockVideoPlugin(true) // 视频插件
    plugin.setIsImageCollectPlugin(true) // 图片视频列表url集合列表解析插件
    plugin.setIsImageTextMixPlugin(true) // 图文不混排插件
    plugin.setIsImageSlidePlugin(true) // 图片banner
    plugin.setIsCodeListPlugin(true) // 代码块列表
    plugin.setIsImageStylePlugin(true) // 图片样式
    plugin.setIsTocPlugin(true) // TOC插件
    plugin.setIsFootnotePlugin(true) // 脚注
    plugin.setIsHtmlPlugin(true) // Html插件
    plugin.setIsLinkViewPlugin(true) // 链接单独块解析插件
    return plugin
  }

  linkCallBack(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  imageCallback(url: string, urlList: Array<string>): void {
    hilog.error(1, "1", `---url:${url},urlList:${urlList}`)
  }

  audioCallback(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  videoCallback(url: string, urlList: Array<string>): void {
    hilog.error(1, "1", `---url:${url},urlList:${urlList}`)
  }

  videoImageCallback(url: string, cb: (imageUrl: string, aspectRatio: number, time: number) => void): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  codeCopyCallback(code: string): void {
    hilog.error(1, "1", `---code:${code}`)
  }

  codeFullScreenCallback(code: string, type: string | undefined): void {
    hilog.error(1, "1", `---code:${code},type:${type}`)
  }

  latexCallBack(data: ArrayBuffer, heightNumber: number, widthNumber: number): void {
    hilog.error(1, "1", `---data.size:${data.byteLength},heightNumber:${heightNumber},widthNumber:${widthNumber}`)
  }

  tocIndexCallback(y: number | undefined): void {
    if(y !==undefined){
      hilog.error(1, "1", `---y:${y}`)
      // let rect = this.markdownScroller.getItemRect(y)
      // this.scroller.scrollTo({xOffset:0, yOffset: rect.getItemRectY()})
    }
  }

  footnoteCallback(y: number | undefined): void {
    if(y !==undefined){
      hilog.error(1, "1", `---y:${y}`)
      // let rect = this.markdownScroller.getItemRect(y)
      // this.scroller.scrollTo({xOffset:0, yOffset: rect.getItemRectY()})
    }
  }
}
