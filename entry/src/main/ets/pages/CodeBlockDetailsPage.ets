import { CJMarkdown,
  CodeBlockTheme,
  GlobalTheme,
  MarkdownConfiguration,
  MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme} from '@cangjie-tpc/markdown_hybrid'
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { getFileContextStr } from '../utils/FileUtils'
import { CodeBlockData } from '../model/CodeBlockData'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct CodeBlockDetailsPage {
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
  blockMarginTop: number = 8
  @State // Markdown块右边距
  blockMarginRight: number = 8
  @State // Markdown块下边距
  blockMarginBottom: number = 8
  @State // Markdown块左边距
  blockMarginLeft: number = 8
  @State // Markdown块间距样式字符串
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
  @State // 代码深浅色模式
  codeBlockIsDark: boolean = false
  @State // 是否格式化围栏代码块内容
  codeBlockIsCodeFormat: boolean = false
  @State // codeformat是否用制表符
  codeBlockUseTab: boolean = false
  @State // codeformat空格缩进数量
  codeBlockIndentWidth: number = 4
  @State // 围栏代码块代码高亮是否同步解析
  codeBlockParserSync: boolean = false
  @State // 代码块背景颜色
  codeBlockBackgroundColor: number | undefined = undefined
  @State // 代码块上外边距
  codeBlockMarginTop: number = 8
  @State // 代码块右外边距
  codeBlockMarginRight: number = 0
  @State // 代码块下外边距
  codeBlockMarginBottom: number = 8
  @State // 代码块左外边距
  codeBlockMarginLeft: number = 0
  @State // 代码块上内边距
  codeBlockPaddingTop: number = 12
  @State // 代码块右内边距
  codeBlockPaddingRight: number = 12
  @State // 代码块下内边距
  codeBlockPaddingBottom: number = 12
  @State // 代码块左内边距
  codeBlockPaddingLeft: number = 12
  @State // 代码块边框样式
  codeBlockBorderStyle: BorderStyle = BorderStyle.Solid
  @State // 代码块边框宽度
  codeBlockBorderWidth: number = 0
  @State // 代码块边框颜色
  codeBlockBorderColor: number | undefined = undefined
  @State // 代码块边框左上圆角
  codeBlockRadiusTopLeft: number = 8
  @State // 代码块边框右上圆角
  codeBlockRadiusTopRight: number = 8
  @State // 代码块边框左下圆角
  codeBlockRadiusBottomLeft: number = 8
  @State // 代码块边框右下圆角
  codeBlockRadiusBottomRight: number = 8
  @State // 代码块类型和代码块内容间距
  codeBlockTitleLayoutMarginBottom: number = 8
  @State // 代码块类型左边距
  codeBlockTypeTextMarginLeft: number = 8
  @State // 代码块没有代码类型时默认显示文本
  codeBlockTypeText: string = "Code"
  @State // 代码块类型文本颜色
  codeBlockTypeTextFontColor: number | undefined = undefined
  @State // 代码块类型文本尺寸
  codeBlockTypeTextFontSize: number | undefined = undefined
  @State // 代码块类型文本字体样式
  codeBlockTypeTextFontStyle: FontStyle | undefined = undefined
  @State // 代码块类型文本字体粗细
  codeBlockTypeTextFontWeight: FontWeight | undefined = undefined
  @State // 代码块类型文本字体
  codeBlockTypeTextFontFamily: string | undefined = undefined
  @State // 代码块类型文本行高
  codeBlockTypeTextLineHeight: number | undefined = undefined
  @State // 代码块代码复制和代码全屏间距
  codeBlockCopyFullScreenSpacing: number = 8
  @State // 代码块代码复制按钮是否显示
  codeBlockCopyButtonIsShow: boolean = true
  @State // 代码块代码复制文本是否显示
  codeBlockCopyTextIsShow: boolean = true
  codeBlockCopyIcon: Resource | undefined = undefined // 代码块代码复制按钮默认图标
  @State // 代码块代码复制图标宽度
  codeBlockCopyIconWidth: number = 18
  @State // 代码块代码复制图标高度
  codeBlockCopyIconHeight: number = 18
  @State // 代码块代码复制图标和文本间距
  codeBlockCopyIconTextSpacing: number = 4
  @State // 代码块代码复制默认文本内容
  codeBlockCopyText: string = "Copy"
  @State // 代码块代码复制文本颜色
  codeBlockCopyTextFontColor: number | undefined = undefined
  @State // 代码块代码复制文本尺寸
  codeBlockCopyTextFontSize: number | undefined = undefined
  @State // 代码块代码复制文本字体样式
  codeBlockCopyTextFontStyle: FontStyle | undefined = undefined
  @State // 代码块代码复制文本字体粗细
  codeBlockCopyTextFontWeight: FontWeight | undefined = undefined
  @State // 代码块代码复制文本字体
  codeBlockCopyTextFontFamily: string | undefined = undefined
  @State // 代码块代码复制文本行高
  codeBlockCopyTextLineHeight: number | undefined = undefined
  @State // 代码块代码全屏按钮是否显示
  codeBlockFullScreenButtonIsShow: boolean = true
  @State // 代码块代码全屏文本是否显示
  codeBlockFullScreenTextIsShow: boolean = true
  codeBlockFullScreenIcon: Resource | undefined = undefined // 代码块代码全屏按钮默认图标
  @State // 代码块代码全屏图标宽度
  codeBlockFullScreenIconWidth: number = 18
  @State // 代码块代码全屏图标高度
  codeBlockFullScreenIconHeight: number = 18
  @State // 代码块代码全屏图标和文本间距
  codeBlockFullScreenIconTextSpacing: number = 4
  @State // 代码块代码全屏默认文本内容
  codeBlockFullScreenText: string = "Full Screen"
  @State // 代码块代码全屏文本颜色
  codeBlockFullScreenTextFontColor: number | undefined = undefined
  @State // 代码块代码全屏文本尺寸
  codeBlockFullScreenTextFontSize: number | undefined = undefined
  @State // 代码块代码全屏文本字体样式
  codeBlockFullScreenTextFontStyle: FontStyle | undefined = undefined
  @State // 代码块代码全屏文本字体粗细
  codeBlockFullScreenTextFontWeight: FontWeight | undefined = undefined
  @State // 代码块代码全屏文本字体
  codeBlockFullScreenTextFontFamily: string | undefined = undefined
  @State // 代码块代码全屏文本行高
  codeBlockFullScreenTextLineHeight: number | undefined = undefined
  @State // 代码块代码行号是否显示
  codeBlockLineNumberIsShow: boolean = false
  @State // 代码块代码行号左内边距
  codeBlockLineNumberTextPaddingLeft: number = 8
  @State // 代码块代码行号文本颜色
  codeBlockLineNumberTextFontColor: number | undefined = undefined
  @State // 代码块代码行号文本尺寸
  codeBlockLineNumberTextFontSize: number | undefined = undefined
  @State // 代码块代码行号文本字体样式
  codeBlockLineNumberTextFontStyle: FontStyle | undefined = undefined
  @State // 代码块代码行号文本字体粗细
  codeBlockLineNumberTextFontWeight: FontWeight | undefined = undefined
  @State // 代码块代码行号文本字体
  codeBlockLineNumberTextFontFamily: string | undefined = undefined
  @State // 代码块代码行号文本行高
  codeBlockLineNumberTextLineHeight: number | undefined = undefined
  @State // 代码块代码行号和代码块中间分割线颜色
  codeBlockDividerColor: number | undefined = undefined
  @State // 代码块代码行号和代码块中间分割线宽度
  codeBlockDividerStrokeWidth: number = 1
  @State // 代码块代码行号和分割线间距
  codeBlockLineNumberDividerSpacing: number = 8
  @State // 代码块文本颜色
  codeBlockTextFontColor: number | undefined = undefined
  @State // 代码块代码文本右外边距
  codeBlockTextMarginRight: number = 0
  @State // 代码块代码文本左外边距
  codeBlockTextMarginLeft: number = 0
  @State // 代码块文本尺寸
  codeBlockTextFontSize: number | undefined = undefined
  @State // 代码块文本字体样式
  codeBlockTextFontStyle: FontStyle | undefined = undefined
  @State // 代码块文本字体粗细
  codeBlockTextFontWeight: FontWeight | undefined = undefined
  @State // 代码块文本字体
  codeBlockTextFontFamily: string | undefined = undefined
  @State // 代码块文本行高
  codeBlockTextLineHeight: number | undefined = undefined
  @State // 代码块文本字符间距
  codeBlockTextLetterSpacing: number = 0

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
      let codeBlockData: CodeBlockData = router.getParams() as CodeBlockData
      this.fileStr = getFileContextStr(codeBlockData._pagePath)
      // ---------- 通用
      this.isFull = codeBlockData._isFull
      this.incrementalAnalysis = codeBlockData._incrementalAnalysis
      this.time = codeBlockData._time
      this.textNumber = codeBlockData._textNumber
      this.isMarkdownParserSync = codeBlockData._isMarkdownParserSync
      this.isOnCopy = codeBlockData._isOnCopy
      this.blockMarginTop = codeBlockData._blockMarginTop
      this.blockMarginRight = codeBlockData._blockMarginRight
      this.blockMarginBottom = codeBlockData._blockMarginBottom
      this.blockMarginLeft = codeBlockData._blockMarginLeft
      this.markdownBlockSpacing = codeBlockData._markdownBlockSpacing
      this.isLineBreak = codeBlockData._isLineBreak
      this.globalBackgroundColor = codeBlockData._backgroundColor
      this.openGestureSwipe = codeBlockData._openGestureSwipe
      this.openGestureSwipeTest = codeBlockData._openGestureSwipeTest
      // ---------- 专有
      this.codeBlockIsDark = codeBlockData._codeBlockIsDark
      this.codeBlockIsCodeFormat = codeBlockData._codeBlockIsCodeFormat
      this.codeBlockUseTab = codeBlockData._codeBlockUseTab
      this.codeBlockIndentWidth = codeBlockData._codeBlockIndentWidth
      this.codeBlockParserSync = codeBlockData._codeBlockParserSync
      this.codeBlockBackgroundColor = codeBlockData._codeBlockBackgroundColor
      this.codeBlockMarginTop = codeBlockData._codeBlockMarginTop
      this.codeBlockMarginRight = codeBlockData._codeBlockMarginRight
      this.codeBlockMarginBottom = codeBlockData._codeBlockMarginBottom
      this.codeBlockMarginLeft = codeBlockData._codeBlockMarginLeft
      this.codeBlockPaddingTop = codeBlockData._codeBlockPaddingTop
      this.codeBlockPaddingRight = codeBlockData._codeBlockPaddingRight
      this.codeBlockPaddingBottom = codeBlockData._codeBlockPaddingBottom
      this.codeBlockPaddingLeft = codeBlockData._codeBlockPaddingLeft
      this.codeBlockBorderStyle = codeBlockData._codeBlockBorderStyle
      this.codeBlockBorderWidth = codeBlockData._codeBlockBorderWidth
      this.codeBlockBorderColor = codeBlockData._codeBlockBorderColor
      this.codeBlockRadiusTopLeft = codeBlockData._codeBlockRadiusTopLeft
      this.codeBlockRadiusTopRight = codeBlockData._codeBlockRadiusTopRight
      this.codeBlockRadiusBottomLeft = codeBlockData._codeBlockRadiusBottomLeft
      this.codeBlockRadiusBottomRight = codeBlockData._codeBlockRadiusBottomRight
      this.codeBlockTitleLayoutMarginBottom = codeBlockData._codeBlockTitleLayoutMarginBottom
      this.codeBlockTypeTextMarginLeft = codeBlockData._codeBlockTypeTextMarginLeft
      this.codeBlockTypeText = codeBlockData._codeBlockTypeText
      this.codeBlockTypeTextFontColor = codeBlockData._codeBlockTypeTextFontColor
      this.codeBlockTypeTextFontSize = codeBlockData._codeBlockTypeTextFontSize
      this.codeBlockTypeTextFontStyle = codeBlockData._codeBlockTypeTextFontStyle
      this.codeBlockTypeTextFontWeight = codeBlockData._codeBlockTypeTextFontWeight
      this.codeBlockTypeTextFontFamily = codeBlockData._codeBlockTypeTextFontFamily
      this.codeBlockTypeTextLineHeight = codeBlockData._codeBlockTypeTextLineHeight
      this.codeBlockCopyFullScreenSpacing = codeBlockData._codeBlockCopyFullScreenSpacing
      this.codeBlockCopyButtonIsShow = codeBlockData._codeBlockCopyButtonIsShow
      this.codeBlockCopyTextIsShow = codeBlockData._codeBlockCopyTextIsShow
      this.codeBlockCopyIcon = codeBlockData._codeBlockCopyIcon
      this.codeBlockCopyIconWidth = codeBlockData._codeBlockCopyIconWidth
      this.codeBlockCopyIconHeight = codeBlockData._codeBlockCopyIconHeight
      this.codeBlockCopyIconTextSpacing = codeBlockData._codeBlockCopyIconTextSpacing
      this.codeBlockCopyText = codeBlockData._codeBlockCopyText
      this.codeBlockCopyTextFontColor = codeBlockData._codeBlockCopyTextFontColor
      this.codeBlockCopyTextFontSize = codeBlockData._codeBlockCopyTextFontSize
      this.codeBlockCopyTextFontStyle = codeBlockData._codeBlockCopyTextFontStyle
      this.codeBlockCopyTextFontWeight = codeBlockData._codeBlockCopyTextFontWeight
      this.codeBlockCopyTextFontFamily = codeBlockData._codeBlockCopyTextFontFamily
      this.codeBlockCopyTextLineHeight = codeBlockData._codeBlockCopyTextLineHeight
      this.codeBlockFullScreenButtonIsShow = codeBlockData._codeBlockFullScreenButtonIsShow
      this.codeBlockFullScreenTextIsShow = codeBlockData._codeBlockFullScreenTextIsShow
      this.codeBlockFullScreenIcon = codeBlockData._codeBlockFullScreenIcon
      this.codeBlockFullScreenIconWidth = codeBlockData._codeBlockFullScreenIconWidth
      this.codeBlockFullScreenIconHeight = codeBlockData._codeBlockFullScreenIconHeight
      this.codeBlockFullScreenIconTextSpacing = codeBlockData._codeBlockFullScreenIconTextSpacing
      this.codeBlockFullScreenText = codeBlockData._codeBlockFullScreenText
      this.codeBlockFullScreenTextFontColor = codeBlockData._codeBlockFullScreenTextFontColor
      this.codeBlockFullScreenTextFontSize = codeBlockData._codeBlockFullScreenTextFontSize
      this.codeBlockFullScreenTextFontStyle = codeBlockData._codeBlockFullScreenTextFontStyle
      this.codeBlockFullScreenTextFontWeight = codeBlockData._codeBlockFullScreenTextFontWeight
      this.codeBlockFullScreenTextFontFamily = codeBlockData._codeBlockFullScreenTextFontFamily
      this.codeBlockFullScreenTextLineHeight = codeBlockData._codeBlockFullScreenTextLineHeight
      this.codeBlockLineNumberIsShow = codeBlockData._codeBlockLineNumberIsShow
      this.codeBlockLineNumberTextPaddingLeft = codeBlockData._codeBlockLineNumberTextPaddingLeft
      this.codeBlockLineNumberTextFontColor = codeBlockData._codeBlockLineNumberTextFontColor
      this.codeBlockLineNumberTextFontSize = codeBlockData._codeBlockLineNumberTextFontSize
      this.codeBlockLineNumberTextFontStyle = codeBlockData._codeBlockLineNumberTextFontStyle
      this.codeBlockLineNumberTextFontWeight = codeBlockData._codeBlockLineNumberTextFontWeight
      this.codeBlockLineNumberTextFontFamily = codeBlockData._codeBlockLineNumberTextFontFamily
      this.codeBlockLineNumberTextLineHeight = codeBlockData._codeBlockLineNumberTextLineHeight
      this.codeBlockDividerColor = codeBlockData._codeBlockDividerColor
      this.codeBlockDividerStrokeWidth = codeBlockData._codeBlockDividerStrokeWidth
      this.codeBlockLineNumberDividerSpacing = codeBlockData._codeBlockLineNumberDividerSpacing
      this.codeBlockTextFontColor = codeBlockData._codeBlockTextFontColor
      this.codeBlockTextMarginRight = codeBlockData._codeBlockTextMarginRight
      this.codeBlockTextMarginLeft = codeBlockData._codeBlockTextMarginLeft
      this.codeBlockTextFontSize = codeBlockData._codeBlockTextFontSize
      this.codeBlockTextFontStyle = codeBlockData._codeBlockTextFontStyle
      this.codeBlockTextFontWeight = codeBlockData._codeBlockTextFontWeight
      this.codeBlockTextFontFamily = codeBlockData._codeBlockTextFontFamily
      this.codeBlockTextLineHeight = codeBlockData._codeBlockTextLineHeight
      this.codeBlockTextLetterSpacing = codeBlockData._codeBlockTextLetterSpacing
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
        "代码块测试用例",
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
    theme.setGlobalTheme(globalTheme)
    
    // ---------- 专有 - CodeBlock
    let codeBlockTheme = new CodeBlockTheme()
    codeBlockTheme.setCodeBlockIsDark(this.codeBlockIsDark)
    codeBlockTheme.setCodeBlockIsCodeFormat(this.codeBlockIsCodeFormat)
    codeBlockTheme.setCodeBlockUseTab(this.codeBlockUseTab)
    codeBlockTheme.setCodeBlockIndentWidth(this.codeBlockIndentWidth)
    codeBlockTheme.setCodeBlockParserSync(this.codeBlockParserSync)
    if (this.codeBlockBackgroundColor !== undefined) {
      codeBlockTheme.setCodeBlockBackgroundColor(this.codeBlockBackgroundColor)
    }
    codeBlockTheme.setCodeBlockMargin({top: this.codeBlockMarginTop, right: this.codeBlockMarginRight, bottom: this.codeBlockMarginBottom, left: this.codeBlockMarginLeft})
    codeBlockTheme.setCodeBlockPadding({top: this.codeBlockPaddingTop, right: this.codeBlockPaddingRight, bottom: this.codeBlockPaddingBottom, left: this.codeBlockPaddingLeft})
    codeBlockTheme.setCodeBlockBorderStyle(this.codeBlockBorderStyle)
    codeBlockTheme.setCodeBlockBorderWidth(this.codeBlockBorderWidth)
    if (this.codeBlockBorderColor !== undefined) {
      codeBlockTheme.setCodeBlockBorderColor(this.codeBlockBorderColor)
    }
    codeBlockTheme.setCodeBlockRadius({topLeft: this.codeBlockRadiusTopLeft, topRight: this.codeBlockRadiusTopRight, bottomLeft: this.codeBlockRadiusBottomLeft, bottomRight: this.codeBlockRadiusBottomRight})
    codeBlockTheme.setCodeBlockTitleLayoutMarginBottom(this.codeBlockTitleLayoutMarginBottom)
    codeBlockTheme.setCodeBlockTypeTextMarginLeft(this.codeBlockTypeTextMarginLeft)
    codeBlockTheme.setCodeBlockTypeText(this.codeBlockTypeText)
    if (this.codeBlockTypeTextFontColor !== undefined) {
      codeBlockTheme.setCodeBlockTypeTextFontColor(this.codeBlockTypeTextFontColor)
    }
    if (this.codeBlockTypeTextFontSize !== undefined) {
      codeBlockTheme.setCodeBlockTypeTextFontSize(this.codeBlockTypeTextFontSize)
    }
    if (this.codeBlockTypeTextFontStyle !== undefined) {
      codeBlockTheme.setCodeBlockTypeTextFontStyle(this.codeBlockTypeTextFontStyle)
    }
    if (this.codeBlockTypeTextFontWeight !== undefined) {
      codeBlockTheme.setCodeBlockTypeTextFontWeight(this.codeBlockTypeTextFontWeight)
    }
    if (this.codeBlockTypeTextFontFamily !== undefined) {
      codeBlockTheme.setCodeBlockTypeTextFontFamily(this.codeBlockTypeTextFontFamily)
    }
    if (this.codeBlockTypeTextLineHeight !== undefined) {
      codeBlockTheme.setCodeBlockTypeTextLineHeight(this.codeBlockTypeTextLineHeight)
    }
    codeBlockTheme.setCodeBlockCopyFullScreenSpacing(this.codeBlockCopyFullScreenSpacing)
    codeBlockTheme.setCodeBlockCopyButtonIsShow(this.codeBlockCopyButtonIsShow)
    codeBlockTheme.setCodeBlockCopyTextIsShow(this.codeBlockCopyTextIsShow)
    if (this.codeBlockCopyIcon !== undefined) {
      codeBlockTheme.setCodeBlockCopyIcon(this.codeBlockCopyIcon)
    }
    codeBlockTheme.setCodeBlockCopyIconWidth(this.codeBlockCopyIconWidth)
    codeBlockTheme.setCodeBlockCopyIconHeight(this.codeBlockCopyIconHeight)
    codeBlockTheme.setCodeBlockCopyIconTextSpacing(this.codeBlockCopyIconTextSpacing)
    codeBlockTheme.setCodeBlockCopyText(this.codeBlockCopyText)
    if (this.codeBlockCopyTextFontColor !== undefined) {
      codeBlockTheme.setCodeBlockCopyTextFontColor(this.codeBlockCopyTextFontColor)
    }
    if (this.codeBlockCopyTextFontSize !== undefined) {
      codeBlockTheme.setCodeBlockCopyTextFontSize(this.codeBlockCopyTextFontSize)
    }
    if (this.codeBlockCopyTextFontStyle !== undefined) {
      codeBlockTheme.setCodeBlockCopyTextFontStyle(this.codeBlockCopyTextFontStyle)
    }
    if (this.codeBlockCopyTextFontWeight !== undefined) {
      codeBlockTheme.setCodeBlockCopyTextFontWeight(this.codeBlockCopyTextFontWeight)
    }
    if (this.codeBlockCopyTextFontFamily !== undefined) {
      codeBlockTheme.setCodeBlockCopyTextFontFamily(this.codeBlockCopyTextFontFamily)
    }
    if (this.codeBlockCopyTextLineHeight !== undefined) {
      codeBlockTheme.setCodeBlockCopyTextLineHeight(this.codeBlockCopyTextLineHeight)
    }
    codeBlockTheme.setCodeBlockFullScreenButtonIsShow(this.codeBlockFullScreenButtonIsShow)
    codeBlockTheme.setCodeBlockFullScreenTextIsShow(this.codeBlockFullScreenTextIsShow)
    if (this.codeBlockFullScreenIcon !== undefined) {
      codeBlockTheme.setCodeBlockFullScreenIcon(this.codeBlockFullScreenIcon)
    }
    codeBlockTheme.setCodeBlockFullScreenIconWidth(this.codeBlockFullScreenIconWidth)
    codeBlockTheme.setCodeBlockFullScreenIconHeight(this.codeBlockFullScreenIconHeight)
    codeBlockTheme.setCodeBlockFullScreenIconTextSpacing(this.codeBlockFullScreenIconTextSpacing)
    codeBlockTheme.setCodeBlockFullScreenText(this.codeBlockFullScreenText)
    if (this.codeBlockFullScreenTextFontColor !== undefined) {
      codeBlockTheme.setCodeBlockFullScreenTextFontColor(this.codeBlockFullScreenTextFontColor)
    }
    if (this.codeBlockFullScreenTextFontSize !== undefined) {
      codeBlockTheme.setCodeBlockFullScreenTextFontSize(this.codeBlockFullScreenTextFontSize)
    }
    if (this.codeBlockFullScreenTextFontStyle !== undefined) {
      codeBlockTheme.setCodeBlockFullScreenTextFontStyle(this.codeBlockFullScreenTextFontStyle)
    }
    if (this.codeBlockFullScreenTextFontWeight !== undefined) {
      codeBlockTheme.setCodeBlockFullScreenTextFontWeight(this.codeBlockFullScreenTextFontWeight)
    }
    if (this.codeBlockFullScreenTextFontFamily !== undefined) {
      codeBlockTheme.setCodeBlockFullScreenTextFontFamily(this.codeBlockFullScreenTextFontFamily)
    }
    if (this.codeBlockFullScreenTextLineHeight !== undefined) {
      codeBlockTheme.setCodeBlockFullScreenTextLineHeight(this.codeBlockFullScreenTextLineHeight)
    }
    codeBlockTheme.setCodeBlockLineNumberIsShow(this.codeBlockLineNumberIsShow)
    codeBlockTheme.setCodeBlockLineNumberTextPaddingLeft(this.codeBlockLineNumberTextPaddingLeft)
    if (this.codeBlockLineNumberTextFontColor !== undefined) {
      codeBlockTheme.setCodeBlockLineNumberTextFontColor(this.codeBlockLineNumberTextFontColor)
    }
    if (this.codeBlockLineNumberTextFontSize !== undefined) {
      codeBlockTheme.setCodeBlockLineNumberTextFontSize(this.codeBlockLineNumberTextFontSize)
    }
    if (this.codeBlockLineNumberTextFontStyle !== undefined) {
      codeBlockTheme.setCodeBlockLineNumberTextFontStyle(this.codeBlockLineNumberTextFontStyle)
    }
    if (this.codeBlockLineNumberTextFontWeight !== undefined) {
      codeBlockTheme.setCodeBlockLineNumberTextFontWeight(this.codeBlockLineNumberTextFontWeight)
    }
    if (this.codeBlockLineNumberTextFontFamily !== undefined) {
      codeBlockTheme.setCodeBlockLineNumberTextFontFamily(this.codeBlockLineNumberTextFontFamily)
    }
    if (this.codeBlockLineNumberTextLineHeight !== undefined) {
      codeBlockTheme.setCodeBlockLineNumberTextLineHeight(this.codeBlockLineNumberTextLineHeight)
    }
    if (this.codeBlockDividerColor !== undefined) {
      codeBlockTheme.setCodeBlockDividerColor(this.codeBlockDividerColor)
    }
    codeBlockTheme.setCodeBlockDividerStrokeWidth(this.codeBlockDividerStrokeWidth)
    codeBlockTheme.setCodeBlockLineNumberDividerSpacing(this.codeBlockLineNumberDividerSpacing)
    if (this.codeBlockTextFontColor !== undefined) {
      codeBlockTheme.setCodeBlockTextFontColor(this.codeBlockTextFontColor)
    }
    codeBlockTheme.setCodeBlockTextMarginRight(this.codeBlockTextMarginRight)
    codeBlockTheme.setCodeBlockTextMarginLeft(this.codeBlockTextMarginLeft)
    if (this.codeBlockTextFontSize !== undefined) {
      codeBlockTheme.setCodeBlockTextFontSize(this.codeBlockTextFontSize)
    }
    if (this.codeBlockTextFontStyle !== undefined) {
      codeBlockTheme.setCodeBlockTextFontStyle(this.codeBlockTextFontStyle)
    }
    if (this.codeBlockTextFontWeight !== undefined) {
      codeBlockTheme.setCodeBlockTextFontWeight(this.codeBlockTextFontWeight)
    }
    if (this.codeBlockTextFontFamily !== undefined) {
      codeBlockTheme.setCodeBlockTextFontFamily(this.codeBlockTextFontFamily)
    }
    if (this.codeBlockTextLineHeight !== undefined) {
      codeBlockTheme.setCodeBlockTextLineHeight(this.codeBlockTextLineHeight)
    }
    codeBlockTheme.setCodeBlockTextLetterSpacing(this.codeBlockTextLetterSpacing)
    theme.setCodeBlockTheme(codeBlockTheme)
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