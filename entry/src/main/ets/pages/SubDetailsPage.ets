import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme,
  MarkdownThemeSub,
  MarkdownThemeGlobal } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { SubData } from '../model/SubData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct SubDetailsPage {
  // ---------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // Markdown的控制器
  markdownScroller: MarkdownScroller = new MarkdownScroller()
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
  @State // 下标文本颜色
  subTextFontColor: number | undefined = undefined
  @State // 下标文本尺寸
  subTextFontSize: number = 8
  @State // 下标文本字体样式
  subTextFontStyle: FontStyle = FontStyle.Normal
  @State // 下标文本字体粗细
  subTextFontWeight: FontWeight = FontWeight.Normal
  @State // 下标文本字体
  subTextFontFamily: string = 'HarmonyOS Sans'
  @State // 下标文本字符间距
  subTextLetterSpacing: number = 0
  @State // 下标文本基线的偏移量
  subTextBaselineOffset: number = 0

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
      let subData: SubData = router.getParams() as SubData
      this.fileStr = getFileContextStr(subData._pagePath)
      // ---------- 通用
      this.isFull = subData._isFull
      this.incrementalAnalysis = subData._incrementalAnalysis
      this.time = subData._time
      this.textNumber = subData._textNumber
      this.isMarkdownParserSync = subData._isMarkdownParserSync
      this.isOnCopy = subData._isOnCopy
      this.blockMarginTop = subData._blockMarginTop
      this.blockMarginRight = subData._blockMarginRight
      this.blockMarginBottom = subData._blockMarginBottom
      this.blockMarginLeft = subData._blockMarginLeft
      this.markdownBlockSpacing = subData._markdownBlockSpacing
      this.isLineBreak = subData._isLineBreak
      this.globalBackgroundColor = subData._backgroundColor
      this.openGestureSwipe = subData._openGestureSwipe
      this.openGestureSwipeTest = subData._openGestureSwipeTest
      // ---------- 专有
      this.subTextFontColor = subData._subTextFontColor
      this.subTextFontSize = subData._subTextFontSize
      this.subTextFontStyle = subData._subTextFontStyle
      this.subTextFontWeight = subData._subTextFontWeight
      this.subTextFontFamily = subData._subTextFontFamily
      this.subTextLetterSpacing = subData._subTextLetterSpacing
      this.subTextBaselineOffset = subData._subTextBaselineOffset
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
        "下标测试用例",
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
    
    // ---------- 专有 - Sub
    let subTheme = new MarkdownThemeSub()
    if (this.subTextFontColor !== undefined) {
      subTheme.setSubTextFontColor(this.subTextFontColor)
    }
    subTheme.setSubTextFontSize(this.subTextFontSize)
    subTheme.setSubTextFontStyle(this.subTextFontStyle)
    subTheme.setSubTextFontWeight(this.subTextFontWeight)
    subTheme.setSubTextFontFamily(this.subTextFontFamily)
    subTheme.setSubTextLetterSpacing(this.subTextLetterSpacing)
    subTheme.setSubTextBaselineOffset(this.subTextBaselineOffset)
    theme.setMarkdownThemeSub(subTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsHtmlPlugin(true) // HTML插件
    plugin.setIsSubPlugin(true) // 下标插件
    plugin.setIsSupPlugin(true) // 上标插件
    return plugin
  }
}
