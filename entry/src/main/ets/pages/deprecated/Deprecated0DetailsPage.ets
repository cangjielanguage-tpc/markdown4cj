import { titleComponent } from '../../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../../utils/FileUtils'
import hilog from '@ohos.hilog'
import { DeprecatedData } from '../../model/DeprecatedData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct Deprecated0DetailsPage {
  // ---------- 通用
  scroller: Scroller = new Scroller() // 滑动控制器
  markdownScroller: MarkdownScroller = new MarkdownScroller() // Markdown的控制器
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
  @State // Markdown文本第一个模块上边距
  blockFirstTopMargin: number = 8
  @State // Markdown文本最后一个模块下边距
  blockLastBottomMargin: number = 8
  @State // Markdown文本模块间上下间距
  blockTopAndBottomMargins: number = 8
  @State // 是否允许markdown控件自身响应滑动
  openGestureSwipe: boolean = false
  @State // 是否开启响应滑动测试
  openGestureSwipeTest: boolean = false
  @State // 流式输入是否输入结束(true:结束输入,false:持续输入)
  isInputEnded: boolean = false

  // ---------- 其他配置
  @State // 删除线颜色
  strikethroughColor: number = 0xFF191919
  @State // 删除线样式
  strikethroughStyle: TextDecorationStyle = TextDecorationStyle.SOLID
  @State // 定义列表定义行缩进
  descListTermAndDefMargins: number = 8
  @State // 定义列表定义行缩进
  descListDefIndentation: number = 8
  @State // 定义列表定义行间距
  descListDefMargins: number = 8
  @State // 下标字体颜色
  subTextColor: number = 0xFF191919
  @State // 下标字体大小
  subTextSize: number = 8
  @State // 下标偏移距离
  subOffsetDist: number = 0
  @State // 上标字体颜色
  supTextColor: number = 0xFF191919
  @State // 上标字体大小
  supTextSize: number = 8
  @State // 上标偏移距离
  supOffsetDist: number = 6

  // ---------- 块引用配置
  @State // 块引用左边距
  blockQuoteLeftMargin: number = 8
  @State // 块引用右边距
  blockQuoteRightMargin: number = 8
  @State // 块引用左边线条宽度
  blockQuoteWidth: number = 1
  @State // 块引用左边线条颜色
  blockQuoteColor: number = 0xFF191919
  @State // 块引用背景颜色
  blockQuoteBackGroupColor: number = 0xFFEAEAEA
  @State // 块引用子模块上下间距
  blockQuoteTopAndBottomMargins: number = 0

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
      let deprecatedData: DeprecatedData = router.getParams() as DeprecatedData
      this.fileStr = getFileContextStr(deprecatedData._pagePath)
      // ---------- 通用
      this.isFull = deprecatedData._isFull
      this.incrementalAnalysis = deprecatedData._incrementalAnalysis
      this.time = deprecatedData._time
      this.textNumber = deprecatedData._textNumber
      this.isMarkdownParserSync = deprecatedData._isMarkdownParserSync
      this.isOnCopy = deprecatedData._isOnCopy
      this.blockFirstTopMargin = deprecatedData._blockFirstTopMargin
      this.blockLastBottomMargin = deprecatedData._blockLastBottomMargin
      this.blockTopAndBottomMargins = deprecatedData._blockTopAndBottomMargins
      this.openGestureSwipe = deprecatedData._openGestureSwipe
      this.openGestureSwipeTest = deprecatedData._openGestureSwipeTest
      // ---------- 其他配置
      this.strikethroughColor = deprecatedData._strikethroughColor
      this.strikethroughStyle = deprecatedData._strikethroughStyle
      this.descListTermAndDefMargins = deprecatedData._descListTermAndDefMargins
      this.descListDefIndentation = deprecatedData._descListDefIndentation
      this.descListDefMargins = deprecatedData._descListDefMargins
      this.subTextColor = deprecatedData._subTextColor
      this.subTextSize = deprecatedData._subTextSize
      this.subOffsetDist = deprecatedData._subOffsetDist
      this.supTextColor = deprecatedData._supTextColor
      this.supTextSize = deprecatedData._supTextSize
      this.supOffsetDist = deprecatedData._supOffsetDist
      // ---------- 块引用配置
      this.blockQuoteLeftMargin = deprecatedData._blockQuoteLeftMargin
      this.blockQuoteRightMargin = deprecatedData._blockQuoteRightMargin
      this.blockQuoteWidth = deprecatedData._blockQuoteWidth
      this.blockQuoteColor = deprecatedData._blockQuoteColor
      this.blockQuoteBackGroupColor = deprecatedData._blockQuoteBackGroupColor
      this.blockQuoteTopAndBottomMargins = deprecatedData._blockQuoteTopAndBottomMargins
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
        "废弃接口用例0",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Button("点击加载markdown")
        .height(40)// 高度
        .width("80%")// 宽度
        .type(ButtonType.Capsule)// 圆角
        .margin({ top: 5, bottom: 5 })// 外边距
        .fontColor(0xFFFFFFFF)// 文本颜色
        .backgroundColor(0xFF317AFF)// 背景颜色
        .align(Alignment.Center)// 内容对齐方式
        .fontSize(16)// 字体大小
        .onClick(
          () => {
            // 点击动作触发该方法调用
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
    globalTheme.setGlobalMargin({top: this.blockTopAndBottomMargins, bottom: this.blockTopAndBottomMargins})
    globalTheme.setBlockSpacing(this.blockTopAndBottomMargins)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.setGlobalTheme(globalTheme)
    
    // ---------- 其他配置
    theme.setStrikethroughColor(this.strikethroughColor)
    theme.setStrikethroughStyle(this.strikethroughStyle)
    theme.setDescListTermAndDefMargins(this.descListTermAndDefMargins)
    theme.setDescListDefIndentation(this.descListDefIndentation)
    theme.setDescListDefMargins(this.descListDefMargins)
    theme.setSubTextColor(this.subTextColor)
    theme.setSubTextSize(this.subTextSize)
    theme.setSubOffsetDist(this.subOffsetDist)
    theme.setSupTextColor(this.supTextColor)
    theme.setSupTextSize(this.supTextSize)
    theme.setSupOffsetDist(this.supOffsetDist)
    
    // ---------- 块引用配置
    theme.setBlockQuoteLeftMargin(this.blockQuoteLeftMargin)
    theme.setBlockQuoteRightMargin(this.blockQuoteRightMargin)
    theme.setBlockQuoteWidth(this.blockQuoteWidth)
    theme.setBlockQuoteColor(this.blockQuoteColor)
    theme.setBlockQuoteBackgroundColor(this.blockQuoteBackGroupColor)
    theme.setBlockQuoteTopAndBottomMargins(this.blockQuoteTopAndBottomMargins)
    
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
      let rect = this.markdownScroller.getItemRect(y)
      this.scroller.scrollTo({xOffset:0, yOffset: rect.getItemRectY()})
    }
  }

  footnoteCallback(y: number | undefined): void {
    if(y !==undefined){
      hilog.error(1, "1", `---y:${y}`)
      let rect = this.markdownScroller.getItemRect(y)
      this.scroller.scrollTo({xOffset:0, yOffset: rect.getItemRectY()})
    }
  }
}
