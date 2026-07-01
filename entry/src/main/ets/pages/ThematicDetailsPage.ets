import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown,
  DividerTheme,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { ThematicData } from '../model/ThematicData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct ThematicDetailsPage {
  // ---------- 通用
  scroller: Scroller = new Scroller() // 滑动控制器
  // markdownScroller: MarkdownScroller = new MarkdownScroller() // Markdown的控制器
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
  blockMarginTop: number = 0
  @State // Markdown块右边距
  blockMarginRight: number = 0
  @State // Markdown块下边距
  blockMarginBottom: number = 0
  @State // Markdown块左边距
  blockMarginLeft: number = 0
  @State // Markdown块间距样式
  markdownBlockSpacing: number = 0
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
  @State // 分割线上外边距
  dividerMarginTop: number = 8
  @State // 分割线右外边距
  dividerMarginRight: number = 0
  @State // 分割线下外边距
  dividerMarginBottom: number = 8
  @State // 分割线左外边距
  dividerMarginLeft: number = 0
  @State // 分割线上内边距
  dividerPaddingTop: number = 0
  @State // 分割线右内边距
  dividerPaddingRight: number = 0
  @State // 分割线下内边距
  dividerPaddingBottom: number = 0
  @State // 分割线左内边距
  dividerPaddingLeft: number = 0
  @State // 分割线颜色
  dividerColor: number | undefined = undefined
  @State // 分割线宽度
  dividerStrokeWidth: number = 1
  @State // 分割线端点样式
  dividerStyle: LineCapStyle = LineCapStyle.Round

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()
  @State // 刷新标志
  isRefresh: boolean = true

  onColorModeChange(): void {
    if (this.currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      this.markdownTheme.setDefaultTheme()
      this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
      hilog.error(1, 'onColorModeChange', '浅色模式')
    } else {
      this.markdownTheme.setDarculaTheme()
      this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
      hilog.error(1, 'onColorModeChange', '深色模式')
    }
    this.isRefresh = !this.isRefresh
  }

  aboutToAppear(): void {
    try {
      let thematicData: ThematicData = router.getParams() as ThematicData
      this.fileStr = getFileContextStr(thematicData._pagePath)
      // ---------- 通用
      this.isFull = thematicData._isFull
      this.incrementalAnalysis = thematicData._incrementalAnalysis
      this.time = thematicData._time
      this.textNumber = thematicData._textNumber
      this.isMarkdownParserSync = thematicData._isMarkdownParserSync
      this.isOnCopy = thematicData._isOnCopy
      this.blockMarginTop = thematicData._blockMarginTop
      this.blockMarginRight = thematicData._blockMarginRight
      this.blockMarginBottom = thematicData._blockMarginBottom
      this.blockMarginLeft = thematicData._blockMarginLeft
      this.markdownBlockSpacing = thematicData._markdownBlockSpacing
      this.isLineBreak = thematicData._isLineBreak
      this.globalBackgroundColor = thematicData._backgroundColor
      this.openGestureSwipe = thematicData._openGestureSwipe
      this.openGestureSwipeTest = thematicData._openGestureSwipeTest
      // ---------- 专有
      this.dividerMarginTop = thematicData._dividerMarginTop
      this.dividerMarginRight = thematicData._dividerMarginRight
      this.dividerMarginBottom = thematicData._dividerMarginBottom
      this.dividerMarginLeft = thematicData._dividerMarginLeft
      this.dividerPaddingTop = thematicData._dividerPaddingTop
      this.dividerPaddingRight = thematicData._dividerPaddingRight
      this.dividerPaddingBottom = thematicData._dividerPaddingBottom
      this.dividerPaddingLeft = thematicData._dividerPaddingLeft
      this.dividerColor = thematicData._dividerColor
      this.dividerStrokeWidth = thematicData._dividerStrokeWidth
      this.dividerStyle = thematicData._dividerStyle
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
        "分割线测试用例",
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
                // isInputEnded: this.isInputEnded,
                // incrementalAnalysis: this.incrementalAnalysis,
                // listScroller: this.markdownScroller,
                config: this.markdownConfiguration,
                plugin: this.markdownPlugin
              })
            }.height("100%")
          } else {
            Column() {
              CJMarkdown({
                content: this.content,
                // isInputEnded: this.isInputEnded,
                // listScroller: this.markdownScroller,
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
                // isInputEnded: this.isInputEnded,
                // incrementalAnalysis: this.incrementalAnalysis,
                // listScroller: this.markdownScroller,
                config: this.markdownConfiguration,
                plugin: this.markdownPlugin
              })
            }.height("100%")
          } else {
            Column() {
              CJMarkdown({
                content: this.content,
                // isInputEnded: this.isInputEnded,
                // listScroller: this.markdownScroller,
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
    globalTheme.setMargin({top: this.blockMarginTop, right: this.blockMarginRight, bottom: this.blockMarginBottom, left: this.blockMarginLeft})
    globalTheme.setMarkdownBlockSpacing(this.markdownBlockSpacing)
    globalTheme.setIsLineBreak(this.isLineBreak)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.setGlobalTheme(globalTheme)
    
    // ---------- 专有 - Divider
    let dividerTheme = new DividerTheme()
    dividerTheme.setDividerMargin({top: this.dividerMarginTop, right: this.dividerMarginRight, bottom: this.dividerMarginBottom, left: this.dividerMarginLeft})
    dividerTheme.setDividerPadding({top: this.dividerPaddingTop, right: this.dividerPaddingRight, bottom: this.dividerPaddingBottom, left: this.dividerPaddingLeft})
    if (this.dividerColor !== undefined) {
      dividerTheme.setDividerColor(this.dividerColor)
    }
    dividerTheme.setDividerStrokeWidth(this.dividerStrokeWidth)
    dividerTheme.setDividerStyle(this.dividerStyle)
    theme.setDividerTheme(dividerTheme)
    
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
}
