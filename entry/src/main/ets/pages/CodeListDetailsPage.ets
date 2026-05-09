import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme,
  MarkdownThemeCodeBlock,
  MarkdownThemeGlobal } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { CodeListData } from '../model/CodeListData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct CodeListDetailsPage {
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
  globalBackgroundColor: number | undefined = undefined
  @State // 是否允许markdown控件自身响应滑动
  openGestureSwipe: boolean = false
  @State // 是否开启响应滑动测试
  openGestureSwipeTest: boolean = false
  @State // 流式输入是否输入结束(true:结束输入,false:持续输入)
  isInputEnded: boolean = false

  // ---------- 专有
  @State // 组合代码块未选中标题字体大小
  codeBlockListTitleTextSize: number = 14
  @State // 组合代码块选中标题字体大小
  codeBlockListTitleSelectTextSize: number = 15
  @State // 组合代码块选中标题文本颜色
  codeBlockListTitleSelectTextColor: number | undefined = undefined
  @State // 组合代码块未选中标题文本颜色
  codeBlockListTitleUnselectTextColor: number | undefined = undefined
  @State // 组合代码块选中标题背景颜色
  codeBlockListTitleSelectBackgroundColor: number | undefined = undefined
  @State // 组合代码块未选中标题背景颜色
  codeBlockListTitleUnselectBackgroundColor: number | undefined = undefined

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
      let codeListData: CodeListData = router.getParams() as CodeListData
      this.fileStr = getFileContextStr(codeListData._pagePath)
      // ---------- 通用
      this.isFull = codeListData._isFull
      this.incrementalAnalysis = codeListData._incrementalAnalysis
      this.time = codeListData._time
      this.textNumber = codeListData._textNumber
      this.isMarkdownParserSync = codeListData._isMarkdownParserSync
      this.isOnCopy = codeListData._isOnCopy
      this.blockMarginTop = codeListData._blockMarginTop
      this.blockMarginRight = codeListData._blockMarginRight
      this.blockMarginBottom = codeListData._blockMarginBottom
      this.blockMarginLeft = codeListData._blockMarginLeft
      this.markdownBlockSpacing = codeListData._markdownBlockSpacing
      this.isLineBreak = codeListData._isLineBreak
      this.globalBackgroundColor = codeListData._backgroundColor
      this.openGestureSwipe = codeListData._openGestureSwipe
      this.openGestureSwipeTest = codeListData._openGestureSwipeTest
      // ---------- 专有
      this.codeBlockListTitleTextSize = codeListData._codeListTitleTextSize
      this.codeBlockListTitleSelectTextSize = codeListData._codeListTitleSelectTextSize
      this.codeBlockListTitleSelectTextColor = codeListData._codeListTitleSelectTextColor
      this.codeBlockListTitleUnselectTextColor = codeListData._codeListTitleUnSelectTextColor
      this.codeBlockListTitleSelectBackgroundColor = codeListData._codeListTitleSelectBackGroupColor
      this.codeBlockListTitleUnselectBackgroundColor = codeListData._codeListTitleUnSelectBackGroupColor
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
        "组合代码块测试用例",
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
    let globalTheme = new MarkdownThemeGlobal()
    if (this.globalBackgroundColor !== undefined) {
      globalTheme.setBackgroundColor(this.globalBackgroundColor)
    }
    globalTheme.setGlobalMargin(this.blockMarginTop, this.blockMarginRight, this.blockMarginBottom, this.blockMarginLeft)
    globalTheme.setBlockSpacing(this.markdownBlockSpacing)
    globalTheme.setIsLineBreak(this.isLineBreak)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.setMarkdownThemeGlobal(globalTheme)
    
    // ---------- 专有
    let codeBlockTheme = new MarkdownThemeCodeBlock()
    codeBlockTheme.setCodeBlockListTitleTextSize(this.codeBlockListTitleTextSize)
    codeBlockTheme.setCodeBlockListTitleSelectTextSize(this.codeBlockListTitleSelectTextSize)
    if (this.codeBlockListTitleSelectTextColor !== undefined) {
      codeBlockTheme.setCodeBlockListTitleSelectTextColor(this.codeBlockListTitleSelectTextColor)
    }
    if (this.codeBlockListTitleUnselectTextColor !== undefined) {
      codeBlockTheme.setCodeBlockListTitleUnselectTextColor(this.codeBlockListTitleUnselectTextColor)
    }
    if (this.codeBlockListTitleSelectBackgroundColor !== undefined) {
      codeBlockTheme.setCodeBlockListTitleSelectBackgroundColor(this.codeBlockListTitleSelectBackgroundColor)
    }
    if (this.codeBlockListTitleUnselectBackgroundColor !== undefined) {
      codeBlockTheme.setCodeBlockListTitleUnselectBackgroundColor(this.codeBlockListTitleUnselectBackgroundColor)
    }
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsCodeListPlugin(true) // 代码块列表
    return plugin
  }
}
