import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown,
  CodeBlockTheme,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { CodeListData } from '../model/CodeListData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct CodeListDetailsPage {
  // ---------- 通用
  scroller: Scroller = new Scroller() // 滑动控制器
  markdownScroller: Scroller = new Scroller() // Markdown的控制器
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
  @State // 是否启用解析节流
  enableParseThrottle: boolean = false
  @State // 解析节流间隔（ms）
  parseThrottleMs: number = 200
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
  globalBackgroundColor: ResourceColor | undefined = undefined
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
  codeBlockIndentWidth: Length = 4
  @State // 围栏代码块代码高亮是否同步解析
  codeBlockParserSync: boolean = false
  @State // 代码块背景颜色
  codeBlockBackgroundColor: ResourceColor | undefined = undefined
  @State // 代码块上外边距
  codeBlockMarginTop: Length = 0.0
  @State // 代码块右外边距
  codeBlockMarginRight: Length = 0.0
  @State // 代码块下外边距
  codeBlockMarginBottom: Length = 0.0
  @State // 代码块左外边距
  codeBlockMarginLeft: Length = 0.0
  @State // 代码块上内边距
  codeBlockPaddingTop: Length = 0.0
  @State // 代码块右内边距
  codeBlockPaddingRight: Length = 8.0
  @State // 代码块下内边距
  codeBlockPaddingBottom: Length = 8.0
  @State // 代码块左内边距
  codeBlockPaddingLeft: Length = 0.0
  @State // 代码块边框样式
  codeBlockBorderStyle: BorderStyle = BorderStyle.Solid
  @State // 代码块边框宽度
  codeBlockBorderWidth: Length = 0.0
  @State // 代码块边框颜色
  codeBlockBorderColor: ResourceColor | undefined = undefined
  @State // 代码块边框左上圆角
  codeBlockRadiusTopLeft: Length = 8.0
  @State // 代码块边框右上圆角
  codeBlockRadiusTopRight: Length = 8.0
  @State // 代码块边框左下圆角
  codeBlockRadiusBottomLeft: Length = 8.0
  @State // 代码块边框右下圆角
  codeBlockRadiusBottomRight: Length = 8.0
  @State // 代码块类型和代码块内容间距
  codeBlockTitleLayoutMarginBottom: Length = 0.0
  @State // 代码块类型左边距
  codeBlockTypeTextMarginLeft: Length = 8.0
  @State // 代码块没有代码类型时默认显示文本
  codeBlockTypeText: string = "Code"
  @State // 代码块类型文本颜色
  codeBlockTypeTextFontColor: ResourceColor | undefined = undefined
  @State // 代码块类型文本尺寸
  codeBlockTypeTextFontSize: number | string | Resource | undefined = undefined
  @State // 代码块类型文本字体样式
  codeBlockTypeTextFontStyle: FontStyle | undefined = undefined
  @State // 代码块类型文本字体粗细
  codeBlockTypeTextFontWeight: FontWeight | undefined = undefined
  @State // 代码块类型文本字体
  codeBlockTypeTextFontFamily: string | undefined = undefined
  @State // 代码块类型文本行高
  codeBlockTypeTextLineHeight: number | string | Resource | undefined = undefined
  @State // 代码块代码复制和代码全屏间距
  codeBlockCopyFullScreenSpacing: number = 8.0
  @State // 代码块代码复制按钮是否显示
  codeBlockCopyButtonIsShow: boolean = true
  @State // 代码块代码复制文本是否显示
  codeBlockCopyTextIsShow: boolean = true
  codeBlockCopyIcon: Resource | undefined = undefined // 代码块代码复制按钮默认图标
  @State // 代码块代码复制图标宽度
  codeBlockCopyIconWidth: Length = 24.0
  @State // 代码块代码复制图标高度
  codeBlockCopyIconHeight: Length = 24.0
  @State // 代码块代码复制图标和文本间距
  codeBlockCopyIconTextSpacing: number = 4.0
  @State // 代码块代码复制默认文本内容
  codeBlockCopyText: string = "Copy"
  @State // 代码块代码复制文本颜色
  codeBlockCopyTextFontColor: ResourceColor | undefined = undefined
  @State // 代码块代码复制文本尺寸
  codeBlockCopyTextFontSize: number | string | Resource | undefined = undefined
  @State // 代码块代码复制文本字体样式
  codeBlockCopyTextFontStyle: FontStyle | undefined = undefined
  @State // 代码块代码复制文本字体粗细
  codeBlockCopyTextFontWeight: FontWeight | undefined = undefined
  @State // 代码块代码复制文本字体
  codeBlockCopyTextFontFamily: string | undefined = undefined
  @State // 代码块代码复制文本行高
  codeBlockCopyTextLineHeight: number | string | Resource | undefined = undefined
  @State // 代码块代码全屏按钮是否显示
  codeBlockFullScreenButtonIsShow: boolean = true
  @State // 代码块代码全屏文本是否显示
  codeBlockFullScreenTextIsShow: boolean = true
  codeBlockFullScreenIcon: Resource | undefined = undefined // 代码块代码全屏按钮默认图标
  @State // 代码块代码全屏图标宽度
  codeBlockFullScreenIconWidth: Length = 24.0
  @State // 代码块代码全屏图标高度
  codeBlockFullScreenIconHeight: Length = 24.0
  @State // 代码块代码全屏图标和文本间距
  codeBlockFullScreenIconTextSpacing: number = 4.0
  @State // 代码块代码全屏默认文本内容
  codeBlockFullScreenText: string = "Full Screen"
  @State // 代码块代码全屏文本颜色
  codeBlockFullScreenTextFontColor: ResourceColor | undefined = undefined
  @State // 代码块代码全屏文本尺寸
  codeBlockFullScreenTextFontSize: number | string | Resource | undefined = undefined
  @State // 代码块代码全屏文本字体样式
  codeBlockFullScreenTextFontStyle: FontStyle | undefined = undefined
  @State // 代码块代码全屏文本字体粗细
  codeBlockFullScreenTextFontWeight: FontWeight | undefined = undefined
  @State // 代码块代码全屏文本字体
  codeBlockFullScreenTextFontFamily: string | undefined = undefined
  @State // 代码块代码全屏文本行高
  codeBlockFullScreenTextLineHeight: number | string | Resource | undefined = undefined
  @State // 代码块代码行号是否显示
  codeBlockLineNumberIsShow: boolean = false
  @State // 代码块代码行号左内边距
  codeBlockLineNumberTextPaddingLeft: Length = 8.0
  @State // 代码块代码行号文本颜色
  codeBlockLineNumberTextFontColor: ResourceColor | undefined = undefined
  @State // 代码块代码行号文本尺寸
  codeBlockLineNumberTextFontSize: number | string | Resource | undefined = undefined
  @State // 代码块代码行号文本字体样式
  codeBlockLineNumberTextFontStyle: FontStyle | undefined = undefined
  @State // 代码块代码行号文本字体粗细
  codeBlockLineNumberTextFontWeight: FontWeight | undefined = undefined
  @State // 代码块代码行号文本字体
  codeBlockLineNumberTextFontFamily: string | undefined = undefined
  @State // 代码块代码行号文本行高
  codeBlockLineNumberTextLineHeight: number | string | Resource | undefined = undefined
  @State // 代码块代码行号和代码块中间分割线颜色
  codeBlockDividerColor: ResourceColor | undefined = undefined
  @State // 代码块代码行号和代码块中间分割线宽度
  codeBlockDividerStrokeWidth: Length = 0.5
  @State // 代码块代码行号和分割线间距
  codeBlockLineNumberDividerSpacing: number = 8.0
  @State // 代码块文本颜色
  codeBlockTextFontColor: ResourceColor | undefined = undefined
  @State // 代码块代码文本右外边距
  codeBlockTextMarginRight: Length = 8.0
  @State // 代码块代码文本左外边距
  codeBlockTextMarginLeft: Length = 8.0
  @State // 代码块文本尺寸
  codeBlockTextFontSize: number | string | Resource = 13.0
  @State // 代码块文本字体样式
  codeBlockTextFontStyle: FontStyle = FontStyle.Normal
  @State // 代码块文本字体粗细
  codeBlockTextFontWeight: number | FontWeight = FontWeight.Normal
  @State // 代码块文本字体
  codeBlockTextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 代码块文本行高
  codeBlockTextLineHeight: number | string | Resource = 22.0
  @State // 代码块文本字符间距
  codeBlockTextLetterSpacing: number = 0.0

  // ---------- 组合代码块专有
  @State // 组合代码块未选中标题字体大小
  codeBlockListTitleTextSize: number = 13.0
  @State // 组合代码块选中标题字体大小
  codeBlockListTitleSelectTextSize: number = 13.0
  @State // 组合代码块选中标题文本颜色
  codeBlockListTitleSelectTextColor: ResourceColor | undefined = undefined
  @State // 组合代码块未选中标题文本颜色
  codeBlockListTitleUnselectTextColor: ResourceColor | undefined = undefined
  @State // 组合代码块选中标题背景颜色
  codeBlockListTitleSelectBackgroundColor: ResourceColor | undefined = undefined
  @State // 组合代码块未选中标题背景颜色
  codeBlockListTitleUnselectBackgroundColor: ResourceColor | undefined = undefined

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let codeListData: CodeListData = router.getParams() as CodeListData
      this.fileStr = getFileContextStr(codeListData._pagePath)
      // ---------- 通用
      this.isFull = codeListData._isFull
      this.incrementalAnalysis = codeListData._incrementalAnalysis
      this.enableParseThrottle = codeListData._enableParseThrottle
      this.parseThrottleMs = codeListData._parseThrottleMs
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
      this.codeBlockIsDark = codeListData._codeBlockIsDark
      this.codeBlockIsCodeFormat = codeListData._codeBlockIsCodeFormat
      this.codeBlockUseTab = codeListData._codeBlockUseTab
      this.codeBlockIndentWidth = codeListData._codeBlockIndentWidth
      this.codeBlockParserSync = codeListData._codeBlockParserSync
      this.codeBlockBackgroundColor = codeListData._codeBlockBackgroundColor
      this.codeBlockMarginTop = codeListData._codeBlockMarginTop
      this.codeBlockMarginRight = codeListData._codeBlockMarginRight
      this.codeBlockMarginBottom = codeListData._codeBlockMarginBottom
      this.codeBlockMarginLeft = codeListData._codeBlockMarginLeft
      this.codeBlockPaddingTop = codeListData._codeBlockPaddingTop
      this.codeBlockPaddingRight = codeListData._codeBlockPaddingRight
      this.codeBlockPaddingBottom = codeListData._codeBlockPaddingBottom
      this.codeBlockPaddingLeft = codeListData._codeBlockPaddingLeft
      this.codeBlockBorderStyle = codeListData._codeBlockBorderStyle
      this.codeBlockBorderWidth = codeListData._codeBlockBorderWidth
      this.codeBlockBorderColor = codeListData._codeBlockBorderColor
      this.codeBlockRadiusTopLeft = codeListData._codeBlockRadiusTopLeft
      this.codeBlockRadiusTopRight = codeListData._codeBlockRadiusTopRight
      this.codeBlockRadiusBottomLeft = codeListData._codeBlockRadiusBottomLeft
      this.codeBlockRadiusBottomRight = codeListData._codeBlockRadiusBottomRight
      this.codeBlockTitleLayoutMarginBottom = codeListData._codeBlockTitleLayoutMarginBottom
      this.codeBlockTypeTextMarginLeft = codeListData._codeBlockTypeTextMarginLeft
      this.codeBlockTypeText = codeListData._codeBlockTypeText
      this.codeBlockTypeTextFontColor = codeListData._codeBlockTypeTextFontColor
      this.codeBlockTypeTextFontSize = codeListData._codeBlockTypeTextFontSize
      this.codeBlockTypeTextFontStyle = codeListData._codeBlockTypeTextFontStyle
      this.codeBlockTypeTextFontWeight = codeListData._codeBlockTypeTextFontWeight
      this.codeBlockTypeTextFontFamily = codeListData._codeBlockTypeTextFontFamily
      this.codeBlockTypeTextLineHeight = codeListData._codeBlockTypeTextLineHeight
      this.codeBlockCopyFullScreenSpacing = codeListData._codeBlockCopyFullScreenSpacing
      this.codeBlockCopyButtonIsShow = codeListData._codeBlockCopyButtonIsShow
      this.codeBlockCopyTextIsShow = codeListData._codeBlockCopyTextIsShow
      this.codeBlockCopyIcon = codeListData._codeBlockCopyIcon
      this.codeBlockCopyIconWidth = codeListData._codeBlockCopyIconWidth
      this.codeBlockCopyIconHeight = codeListData._codeBlockCopyIconHeight
      this.codeBlockCopyIconTextSpacing = codeListData._codeBlockCopyIconTextSpacing
      this.codeBlockCopyText = codeListData._codeBlockCopyText
      this.codeBlockCopyTextFontColor = codeListData._codeBlockCopyTextFontColor
      this.codeBlockCopyTextFontSize = codeListData._codeBlockCopyTextFontSize
      this.codeBlockCopyTextFontStyle = codeListData._codeBlockCopyTextFontStyle
      this.codeBlockCopyTextFontWeight = codeListData._codeBlockCopyTextFontWeight
      this.codeBlockCopyTextFontFamily = codeListData._codeBlockCopyTextFontFamily
      this.codeBlockCopyTextLineHeight = codeListData._codeBlockCopyTextLineHeight
      this.codeBlockFullScreenButtonIsShow = codeListData._codeBlockFullScreenButtonIsShow
      this.codeBlockFullScreenTextIsShow = codeListData._codeBlockFullScreenTextIsShow
      this.codeBlockFullScreenIcon = codeListData._codeBlockFullScreenIcon
      this.codeBlockFullScreenIconWidth = codeListData._codeBlockFullScreenIconWidth
      this.codeBlockFullScreenIconHeight = codeListData._codeBlockFullScreenIconHeight
      this.codeBlockFullScreenIconTextSpacing = codeListData._codeBlockFullScreenIconTextSpacing
      this.codeBlockFullScreenText = codeListData._codeBlockFullScreenText
      this.codeBlockFullScreenTextFontColor = codeListData._codeBlockFullScreenTextFontColor
      this.codeBlockFullScreenTextFontSize = codeListData._codeBlockFullScreenTextFontSize
      this.codeBlockFullScreenTextFontStyle = codeListData._codeBlockFullScreenTextFontStyle
      this.codeBlockFullScreenTextFontWeight = codeListData._codeBlockFullScreenTextFontWeight
      this.codeBlockFullScreenTextFontFamily = codeListData._codeBlockFullScreenTextFontFamily
      this.codeBlockFullScreenTextLineHeight = codeListData._codeBlockFullScreenTextLineHeight
      this.codeBlockLineNumberIsShow = codeListData._codeBlockLineNumberIsShow
      this.codeBlockLineNumberTextPaddingLeft = codeListData._codeBlockLineNumberTextPaddingLeft
      this.codeBlockLineNumberTextFontColor = codeListData._codeBlockLineNumberTextFontColor
      this.codeBlockLineNumberTextFontSize = codeListData._codeBlockLineNumberTextFontSize
      this.codeBlockLineNumberTextFontStyle = codeListData._codeBlockLineNumberTextFontStyle
      this.codeBlockLineNumberTextFontWeight = codeListData._codeBlockLineNumberTextFontWeight
      this.codeBlockLineNumberTextFontFamily = codeListData._codeBlockLineNumberTextFontFamily
      this.codeBlockLineNumberTextLineHeight = codeListData._codeBlockLineNumberTextLineHeight
      this.codeBlockDividerColor = codeListData._codeBlockDividerColor
      this.codeBlockDividerStrokeWidth = codeListData._codeBlockDividerStrokeWidth
      this.codeBlockLineNumberDividerSpacing = codeListData._codeBlockLineNumberDividerSpacing
      this.codeBlockTextFontColor = codeListData._codeBlockTextFontColor
      this.codeBlockTextMarginRight = codeListData._codeBlockTextMarginRight
      this.codeBlockTextMarginLeft = codeListData._codeBlockTextMarginLeft
      this.codeBlockTextFontSize = codeListData._codeBlockTextFontSize
      this.codeBlockTextFontStyle = codeListData._codeBlockTextFontStyle
      this.codeBlockTextFontWeight = codeListData._codeBlockTextFontWeight
      this.codeBlockTextFontFamily = codeListData._codeBlockTextFontFamily
      this.codeBlockTextLineHeight = codeListData._codeBlockTextLineHeight
      this.codeBlockTextLetterSpacing = codeListData._codeBlockTextLetterSpacing

      // ---------- 专有
      this.codeBlockListTitleTextSize = codeListData._codeBlockListTitleTextSize
      this.codeBlockListTitleSelectTextSize = codeListData._codeBlockListTitleSelectTextSize
      this.codeBlockListTitleSelectTextColor = codeListData._codeBlockListTitleSelectTextColor
      this.codeBlockListTitleUnselectTextColor = codeListData._codeBlockListTitleUnselectTextColor
      this.codeBlockListTitleSelectBackgroundColor = codeListData._codeBlockListTitleSelectBackgroundColor
      this.codeBlockListTitleUnselectBackgroundColor = codeListData._codeBlockListTitleUnselectBackgroundColor
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

  build() {
    Column() {
      titleComponent(
        "组合代码块测试用例",
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
              scroller: this.markdownScroller,
              config: this.markdownConfiguration,
              plugin: this.markdownPlugin
            })
          }.height("100%")
        } else {
          Column() {
            CJMarkdown({
              content: this.content,
              // isInputEnded: this.isInputEnded,
              scroller: this.markdownScroller,
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
    globalTheme.setEnableParseThrottle(this.enableParseThrottle)
    globalTheme.setParseThrottleMs(this.parseThrottleMs)
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
    theme.setCodeBlockTheme(codeBlockTheme)
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsCodeListPlugin(true) // 代码块列表
    return plugin
  }
}
