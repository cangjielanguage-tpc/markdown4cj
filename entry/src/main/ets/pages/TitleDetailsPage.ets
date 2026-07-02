import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown,
  GlobalTheme,
  HeadingTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { TitleData } from '../model/TitleData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct TitleDetailsPage {
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
  @State // 一级标题背景颜色
  heading1BackgroundColor: ResourceColor | undefined = undefined
  @State // 一级标题上外边距
  heading1MarginTop: Length = 0.0
  @State // 一级标题右外边距
  heading1MarginRight: Length = 0.0
  @State // 一级标题下外边距
  heading1MarginBottom: Length = 0.0
  @State // 一级标题左外边距
  heading1MarginLeft: Length = 0.0
  @State // 一级标题上内边距
  heading1PaddingTop: Length = 0.0
  @State // 一级标题右内边距
  heading1PaddingRight: Length = 0.0
  @State // 一级标题下内边距
  heading1PaddingBottom: Length = 0.0
  @State // 一级标题左内边距
  heading1PaddingLeft: Length = 0.0
  @State // 一级标题文本颜色
  heading1TextFontColor: ResourceColor | undefined = undefined
  @State // 一级标题文本尺寸
  heading1TextFontSize: number | string | Resource = 20.0
  @State // 一级标题文本字体样式
  heading1TextFontStyle: FontStyle = FontStyle.Normal
  @State // 一级标题文本字体粗细
  heading1TextFontWeight: number | FontWeight = FontWeight.Bold
  @State // 一级标题文本字体
  heading1TextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 一级标题文本行高
  heading1TextLineHeight: number | string | Resource = 22.0
  @State // 一级标题文本字符间距
  heading1TextLetterSpacing: number = 0.0
  @State // 一级标题下划线高度
  heading1UnderlineHeight: number = 0.5
  @State // 一级标题下划线颜色
  heading1UnderlineColor: ResourceColor | undefined = undefined
  @State // 一级标题距离标题文本间距
  heading1UnderlineSpacing: number = 0.0

  @State // 二级标题背景颜色
  heading2BackgroundColor: ResourceColor | undefined = undefined
  @State // 二级标题上外边距
  heading2MarginTop: Length = 0.0
  @State // 二级标题右外边距
  heading2MarginRight: Length = 0.0
  @State // 二级标题下外边距
  heading2MarginBottom: Length = 0.0
  @State // 二级标题左外边距
  heading2MarginLeft: Length = 0.0
  @State // 二级标题上内边距
  heading2PaddingTop: Length = 0.0
  @State // 二级标题右内边距
  heading2PaddingRight: Length = 0.0
  @State // 二级标题下内边距
  heading2PaddingBottom: Length = 0.0
  @State // 二级标题左内边距
  heading2PaddingLeft: Length = 0.0
  @State // 二级标题文本颜色
  heading2TextFontColor: ResourceColor | undefined = undefined
  @State // 二级标题文本尺寸
  heading2TextFontSize: number | string | Resource = 17.0
  @State // 二级标题文本字体样式
  heading2TextFontStyle: FontStyle = FontStyle.Normal
  @State // 二级标题文本字体粗细
  heading2TextFontWeight: number | FontWeight = FontWeight.Bold
  @State // 二级标题文本字体
  heading2TextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 二级标题文本行高
  heading2TextLineHeight: number | string | Resource = 22.0
  @State // 二级标题文本字符间距
  heading2TextLetterSpacing: number = 0.0
  @State // 二级标题下划线高度
  heading2UnderlineHeight: number = 0.5
  @State // 二级标题下划线颜色
  heading2UnderlineColor: ResourceColor | undefined = undefined
  @State // 二级标题距离标题文本间距
  heading2UnderlineSpacing: number = 0.0

  @State // 三级标题背景颜色
  heading3BackgroundColor: ResourceColor | undefined = undefined
  @State // 三级标题上外边距
  heading3MarginTop: Length = 0.0
  @State // 三级标题右外边距
  heading3MarginRight: Length = 0.0
  @State // 三级标题下外边距
  heading3MarginBottom: Length = 0.0
  @State // 三级标题左外边距
  heading3MarginLeft: Length = 0.0
  @State // 三级标题上内边距
  heading3PaddingTop: Length = 0.0
  @State // 三级标题右内边距
  heading3PaddingRight: Length = 0.0
  @State // 三级标题下内边距
  heading3PaddingBottom: Length = 0.0
  @State // 三级标题左内边距
  heading3PaddingLeft: Length = 0.0
  @State // 三级标题文本颜色
  heading3TextFontColor: ResourceColor | undefined = undefined
  @State // 三级标题文本尺寸
  heading3TextFontSize: number | string | Resource = 16.0
  @State // 三级标题文本字体样式
  heading3TextFontStyle: FontStyle = FontStyle.Normal
  @State // 三级标题文本字体粗细
  heading3TextFontWeight: number | FontWeight = FontWeight.Bold
  @State // 三级标题文本字体
  heading3TextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 三级标题文本行高
  heading3TextLineHeight: number | string | Resource = 22.0
  @State // 三级标题文本字符间距
  heading3TextLetterSpacing: number = 0.0

  @State // 四级标题背景颜色
  heading4BackgroundColor: ResourceColor | undefined = undefined
  @State // 四级标题上外边距
  heading4MarginTop: Length = 0.0
  @State // 四级标题右外边距
  heading4MarginRight: Length = 0.0
  @State // 四级标题下外边距
  heading4MarginBottom: Length = 0.0
  @State // 四级标题左外边距
  heading4MarginLeft: Length = 0.0
  @State // 四级标题上内边距
  heading4PaddingTop: Length = 0.0
  @State // 四级标题右内边距
  heading4PaddingRight: Length = 0.0
  @State // 四级标题下内边距
  heading4PaddingBottom: Length = 0.0
  @State // 四级标题左内边距
  heading4PaddingLeft: Length = 0.0
  @State // 四级标题文本颜色
  heading4TextFontColor: ResourceColor | undefined = undefined
  @State // 四级标题文本尺寸
  heading4TextFontSize: number | string | Resource = 15.0
  @State // 四级标题文本字体样式
  heading4TextFontStyle: FontStyle = FontStyle.Normal
  @State // 四级标题文本字体粗细
  heading4TextFontWeight: number | FontWeight = FontWeight.Bold
  @State // 四级标题文本字体
  heading4TextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 四级标题文本行高
  heading4TextLineHeight: number | string | Resource = 22.0
  @State // 四级标题文本字符间距
  heading4TextLetterSpacing: number = 0.0

  @State // 五级标题背景颜色
  heading5BackgroundColor: ResourceColor | undefined = undefined
  @State // 五级标题上外边距
  heading5MarginTop: Length = 0.0
  @State // 五级标题右外边距
  heading5MarginRight: Length = 0.0
  @State // 五级标题下外边距
  heading5MarginBottom: Length = 0.0
  @State // 五级标题左外边距
  heading5MarginLeft: Length = 0.0
  @State // 五级标题上内边距
  heading5PaddingTop: Length = 0.0
  @State // 五级标题右内边距
  heading5PaddingRight: Length = 0.0
  @State // 五级标题下内边距
  heading5PaddingBottom: Length = 0.0
  @State // 五级标题左内边距
  heading5PaddingLeft: Length = 0.0
  @State // 五级标题文本颜色
  heading5TextFontColor: ResourceColor | undefined = undefined
  @State // 五级标题文本尺寸
  heading5TextFontSize: number | string | Resource = 15.0
  @State // 五级标题文本字体样式
  heading5TextFontStyle: FontStyle = FontStyle.Normal
  @State // 五级标题文本字体粗细
  heading5TextFontWeight: number | FontWeight = FontWeight.Bold
  @State // 五级标题文本字体
  heading5TextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 五级标题文本行高
  heading5TextLineHeight: number | string | Resource = 22.0
  @State // 五级标题文本字符间距
  heading5TextLetterSpacing: number = 0.0

  @State // 六级标题背景颜色
  heading6BackgroundColor: ResourceColor | undefined = undefined
  @State // 六级标题上外边距
  heading6MarginTop: Length = 0.0
  @State // 六级标题右外边距
  heading6MarginRight: Length = 0.0
  @State // 六级标题下外边距
  heading6MarginBottom: Length = 0.0
  @State // 六级标题左外边距
  heading6MarginLeft: Length = 0.0
  @State // 六级标题上内边距
  heading6PaddingTop: Length = 0.0
  @State // 六级标题右内边距
  heading6PaddingRight: Length = 0.0
  @State // 六级标题下内边距
  heading6PaddingBottom: Length = 0.0
  @State // 六级标题左内边距
  heading6PaddingLeft: Length = 0.0
  @State // 六级标题文本颜色
  heading6TextFontColor: ResourceColor | undefined = undefined
  @State // 六级标题文本尺寸
  heading6TextFontSize: number | string | Resource = 13.0
  @State // 六级标题文本字体样式
  heading6TextFontStyle: FontStyle = FontStyle.Normal
  @State // 六级标题文本字体粗细
  heading6TextFontWeight: number | FontWeight = FontWeight.Bold
  @State // 六级标题文本字体
  heading6TextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 六级标题文本行高
  heading6TextLineHeight: number | string | Resource = 22.0
  @State // 六级标题文本字符间距
  heading6TextLetterSpacing: number = 0.0

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let titleData: TitleData = router.getParams() as TitleData
      this.fileStr = getFileContextStr(titleData._pagePath)
      // ---------- 通用
      this.isFull = titleData._isFull
      this.incrementalAnalysis = titleData._incrementalAnalysis
      this.time = titleData._time
      this.textNumber = titleData._textNumber
      this.isMarkdownParserSync = titleData._isMarkdownParserSync
      this.isOnCopy = titleData._isOnCopy
      this.blockMarginTop = titleData._blockMarginTop
      this.blockMarginRight = titleData._blockMarginRight
      this.blockMarginBottom = titleData._blockMarginBottom
      this.blockMarginLeft = titleData._blockMarginLeft
      this.markdownBlockSpacing = titleData._markdownBlockSpacing
      this.isLineBreak = titleData._isLineBreak
      this.globalBackgroundColor = titleData._backgroundColor
      this.openGestureSwipe = titleData._openGestureSwipe
      this.openGestureSwipeTest = titleData._openGestureSwipeTest
      // ---------- 专有 - 一级标题
      this.heading1BackgroundColor = titleData._heading1BackgroundColor
      this.heading1MarginTop = titleData._heading1MarginTop
      this.heading1MarginRight = titleData._heading1MarginRight
      this.heading1MarginBottom = titleData._heading1MarginBottom
      this.heading1MarginLeft = titleData._heading1MarginLeft
      this.heading1PaddingTop = titleData._heading1PaddingTop
      this.heading1PaddingRight = titleData._heading1PaddingRight
      this.heading1PaddingBottom = titleData._heading1PaddingBottom
      this.heading1PaddingLeft = titleData._heading1PaddingLeft
      this.heading1TextFontColor = titleData._heading1TextFontColor
      this.heading1TextFontSize = titleData._heading1TextFontSize
      this.heading1TextFontStyle = titleData._heading1TextFontStyle
      this.heading1TextFontWeight = titleData._heading1TextFontWeight
      this.heading1TextFontFamily = titleData._heading1TextFontFamily
      this.heading1TextLineHeight = titleData._heading1TextLineHeight
      this.heading1TextLetterSpacing = titleData._heading1TextLetterSpacing
      this.heading1UnderlineHeight = titleData._heading1UnderlineHeight
      this.heading1UnderlineColor = titleData._heading1UnderlineColor
      this.heading1UnderlineSpacing = titleData._heading1UnderlineSpacing
      // ---------- 专有 - 二级标题
      this.heading2BackgroundColor = titleData._heading2BackgroundColor
      this.heading2MarginTop = titleData._heading2MarginTop
      this.heading2MarginRight = titleData._heading2MarginRight
      this.heading2MarginBottom = titleData._heading2MarginBottom
      this.heading2MarginLeft = titleData._heading2MarginLeft
      this.heading2PaddingTop = titleData._heading2PaddingTop
      this.heading2PaddingRight = titleData._heading2PaddingRight
      this.heading2PaddingBottom = titleData._heading2PaddingBottom
      this.heading2PaddingLeft = titleData._heading2PaddingLeft
      this.heading2TextFontColor = titleData._heading2TextFontColor
      this.heading2TextFontSize = titleData._heading2TextFontSize
      this.heading2TextFontStyle = titleData._heading2TextFontStyle
      this.heading2TextFontWeight = titleData._heading2TextFontWeight
      this.heading2TextFontFamily = titleData._heading2TextFontFamily
      this.heading2TextLineHeight = titleData._heading2TextLineHeight
      this.heading2TextLetterSpacing = titleData._heading2TextLetterSpacing
      this.heading2UnderlineHeight = titleData._heading2UnderlineHeight
      this.heading2UnderlineColor = titleData._heading2UnderlineColor
      this.heading2UnderlineSpacing = titleData._heading2UnderlineSpacing
      // ---------- 专有 - 三级标题
      this.heading3BackgroundColor = titleData._heading3BackgroundColor
      this.heading3MarginTop = titleData._heading3MarginTop
      this.heading3MarginRight = titleData._heading3MarginRight
      this.heading3MarginBottom = titleData._heading3MarginBottom
      this.heading3MarginLeft = titleData._heading3MarginLeft
      this.heading3PaddingTop = titleData._heading3PaddingTop
      this.heading3PaddingRight = titleData._heading3PaddingRight
      this.heading3PaddingBottom = titleData._heading3PaddingBottom
      this.heading3PaddingLeft = titleData._heading3PaddingLeft
      this.heading3TextFontColor = titleData._heading3TextFontColor
      this.heading3TextFontSize = titleData._heading3TextFontSize
      this.heading3TextFontStyle = titleData._heading3TextFontStyle
      this.heading3TextFontWeight = titleData._heading3TextFontWeight
      this.heading3TextFontFamily = titleData._heading3TextFontFamily
      this.heading3TextLineHeight = titleData._heading3TextLineHeight
      this.heading3TextLetterSpacing = titleData._heading3TextLetterSpacing
      // ---------- 专有 - 四级标题
      this.heading4BackgroundColor = titleData._heading4BackgroundColor
      this.heading4MarginTop = titleData._heading4MarginTop
      this.heading4MarginRight = titleData._heading4MarginRight
      this.heading4MarginBottom = titleData._heading4MarginBottom
      this.heading4MarginLeft = titleData._heading4MarginLeft
      this.heading4PaddingTop = titleData._heading4PaddingTop
      this.heading4PaddingRight = titleData._heading4PaddingRight
      this.heading4PaddingBottom = titleData._heading4PaddingBottom
      this.heading4PaddingLeft = titleData._heading4PaddingLeft
      this.heading4TextFontColor = titleData._heading4TextFontColor
      this.heading4TextFontSize = titleData._heading4TextFontSize
      this.heading4TextFontStyle = titleData._heading4TextFontStyle
      this.heading4TextFontWeight = titleData._heading4TextFontWeight
      this.heading4TextFontFamily = titleData._heading4TextFontFamily
      this.heading4TextLineHeight = titleData._heading4TextLineHeight
      this.heading4TextLetterSpacing = titleData._heading4TextLetterSpacing
      // ---------- 专有 - 五级标题
      this.heading5BackgroundColor = titleData._heading5BackgroundColor
      this.heading5MarginTop = titleData._heading5MarginTop
      this.heading5MarginRight = titleData._heading5MarginRight
      this.heading5MarginBottom = titleData._heading5MarginBottom
      this.heading5MarginLeft = titleData._heading5MarginLeft
      this.heading5PaddingTop = titleData._heading5PaddingTop
      this.heading5PaddingRight = titleData._heading5PaddingRight
      this.heading5PaddingBottom = titleData._heading5PaddingBottom
      this.heading5PaddingLeft = titleData._heading5PaddingLeft
      this.heading5TextFontColor = titleData._heading5TextFontColor
      this.heading5TextFontSize = titleData._heading5TextFontSize
      this.heading5TextFontStyle = titleData._heading5TextFontStyle
      this.heading5TextFontWeight = titleData._heading5TextFontWeight
      this.heading5TextFontFamily = titleData._heading5TextFontFamily
      this.heading5TextLineHeight = titleData._heading5TextLineHeight
      this.heading5TextLetterSpacing = titleData._heading5TextLetterSpacing
      // ---------- 专有 - 六级标题
      this.heading6BackgroundColor = titleData._heading6BackgroundColor
      this.heading6MarginTop = titleData._heading6MarginTop
      this.heading6MarginRight = titleData._heading6MarginRight
      this.heading6MarginBottom = titleData._heading6MarginBottom
      this.heading6MarginLeft = titleData._heading6MarginLeft
      this.heading6PaddingTop = titleData._heading6PaddingTop
      this.heading6PaddingRight = titleData._heading6PaddingRight
      this.heading6PaddingBottom = titleData._heading6PaddingBottom
      this.heading6PaddingLeft = titleData._heading6PaddingLeft
      this.heading6TextFontColor = titleData._heading6TextFontColor
      this.heading6TextFontSize = titleData._heading6TextFontSize
      this.heading6TextFontStyle = titleData._heading6TextFontStyle
      this.heading6TextFontWeight = titleData._heading6TextFontWeight
      this.heading6TextFontFamily = titleData._heading6TextFontFamily
      this.heading6TextLineHeight = titleData._heading6TextLineHeight
      this.heading6TextLetterSpacing = titleData._heading6TextLetterSpacing
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
        "标题测试用例",
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
    
    // ---------- 专有 - Heading
    let headingTheme = new HeadingTheme()
    // 一级标题
    if (this.heading1BackgroundColor !== undefined) {
      headingTheme.setBackgroundColorForDesignateHeading(1, this.heading1BackgroundColor)
    }
    headingTheme.setMarginForDesignateHeading(1, {top: this.heading1MarginTop, right: this.heading1MarginRight, bottom: this.heading1MarginBottom, left: this.heading1MarginLeft})
    headingTheme.setPaddingForDesignateHeading(1, {top: this.heading1PaddingTop, right: this.heading1PaddingRight, bottom: this.heading1PaddingBottom, left: this.heading1PaddingLeft})
    if (this.heading1TextFontColor !== undefined) {
      headingTheme.setTextFontColorForDesignateHeading(1, this.heading1TextFontColor)
    }
    headingTheme.setTextFontSizeForDesignateHeading(1, this.heading1TextFontSize)
    headingTheme.setTextFontStyleForDesignateHeading(1, this.heading1TextFontStyle)
    headingTheme.setTextFontWeightForDesignateHeading(1, this.heading1TextFontWeight)
    headingTheme.setTextFontFamilyForDesignateHeading(1, this.heading1TextFontFamily)
    headingTheme.setTextLineHeightForDesignateHeading(1, this.heading1TextLineHeight)
    headingTheme.setTextLetterSpacingForDesignateHeading(1, this.heading1TextLetterSpacing)
    headingTheme.setUnderlineHeightForDesignateHeading(1, this.heading1UnderlineHeight)
    if (this.heading1UnderlineColor !== undefined) {
      headingTheme.setUnderlineColorForDesignateHeading(1, this.heading1UnderlineColor)
    }
    headingTheme.setUnderlineSpacingForDesignateHeading(1, this.heading1UnderlineSpacing)
    // 二级标题
    if (this.heading2BackgroundColor !== undefined) {
      headingTheme.setBackgroundColorForDesignateHeading(2, this.heading2BackgroundColor)
    }
    headingTheme.setMarginForDesignateHeading(2, {top: this.heading2MarginTop, right: this.heading2MarginRight, bottom: this.heading2MarginBottom, left: this.heading2MarginLeft})
    headingTheme.setPaddingForDesignateHeading(2, {top: this.heading2PaddingTop, right: this.heading2PaddingRight, bottom: this.heading2PaddingBottom, left: this.heading2PaddingLeft})
    if (this.heading2TextFontColor !== undefined) {
      headingTheme.setTextFontColorForDesignateHeading(2, this.heading2TextFontColor)
    }
    headingTheme.setTextFontSizeForDesignateHeading(2, this.heading2TextFontSize)
    headingTheme.setTextFontStyleForDesignateHeading(2, this.heading2TextFontStyle)
    headingTheme.setTextFontWeightForDesignateHeading(2, this.heading2TextFontWeight)
    headingTheme.setTextFontFamilyForDesignateHeading(2, this.heading2TextFontFamily)
    headingTheme.setTextLineHeightForDesignateHeading(2, this.heading2TextLineHeight)
    headingTheme.setTextLetterSpacingForDesignateHeading(2, this.heading2TextLetterSpacing)
    headingTheme.setUnderlineHeightForDesignateHeading(2, this.heading2UnderlineHeight)
    if (this.heading2UnderlineColor !== undefined) {
      headingTheme.setUnderlineColorForDesignateHeading(2, this.heading2UnderlineColor)
    }
    headingTheme.setUnderlineSpacingForDesignateHeading(2, this.heading2UnderlineSpacing)
    // 三级标题
    if (this.heading3BackgroundColor !== undefined) {
      headingTheme.setBackgroundColorForDesignateHeading(3, this.heading3BackgroundColor)
    }
    headingTheme.setMarginForDesignateHeading(3, {top: this.heading3MarginTop, right: this.heading3MarginRight, bottom: this.heading3MarginBottom, left: this.heading3MarginLeft})
    headingTheme.setPaddingForDesignateHeading(3, {top: this.heading3PaddingTop, right: this.heading3PaddingRight, bottom: this.heading3PaddingBottom, left: this.heading3PaddingLeft})
    if (this.heading3TextFontColor !== undefined) {
      headingTheme.setTextFontColorForDesignateHeading(3, this.heading3TextFontColor)
    }
    headingTheme.setTextFontSizeForDesignateHeading(3, this.heading3TextFontSize)
    headingTheme.setTextFontStyleForDesignateHeading(3, this.heading3TextFontStyle)
    headingTheme.setTextFontWeightForDesignateHeading(3, this.heading3TextFontWeight)
    headingTheme.setTextFontFamilyForDesignateHeading(3, this.heading3TextFontFamily)
    headingTheme.setTextLineHeightForDesignateHeading(3, this.heading3TextLineHeight)
    headingTheme.setTextLetterSpacingForDesignateHeading(3, this.heading3TextLetterSpacing)
    // 四级标题
    if (this.heading4BackgroundColor !== undefined) {
      headingTheme.setBackgroundColorForDesignateHeading(4, this.heading4BackgroundColor)
    }
    headingTheme.setMarginForDesignateHeading(4, {top: this.heading4MarginTop, right: this.heading4MarginRight, bottom: this.heading4MarginBottom, left: this.heading4MarginLeft})
    headingTheme.setPaddingForDesignateHeading(4, {top: this.heading4PaddingTop, right: this.heading4PaddingRight, bottom: this.heading4PaddingBottom, left: this.heading4PaddingLeft})
    if (this.heading4TextFontColor !== undefined) {
      headingTheme.setTextFontColorForDesignateHeading(4, this.heading4TextFontColor)
    }
    headingTheme.setTextFontSizeForDesignateHeading(4, this.heading4TextFontSize)
    headingTheme.setTextFontStyleForDesignateHeading(4, this.heading4TextFontStyle)
    headingTheme.setTextFontWeightForDesignateHeading(4, this.heading4TextFontWeight)
    headingTheme.setTextFontFamilyForDesignateHeading(4, this.heading4TextFontFamily)
    headingTheme.setTextLineHeightForDesignateHeading(4, this.heading4TextLineHeight)
    headingTheme.setTextLetterSpacingForDesignateHeading(4, this.heading4TextLetterSpacing)
    // 五级标题
    if (this.heading5BackgroundColor !== undefined) {
      headingTheme.setBackgroundColorForDesignateHeading(5, this.heading5BackgroundColor)
    }
    headingTheme.setMarginForDesignateHeading(5, {top: this.heading5MarginTop, right: this.heading5MarginRight, bottom: this.heading5MarginBottom, left: this.heading5MarginLeft})
    headingTheme.setPaddingForDesignateHeading(5, {top: this.heading5PaddingTop, right: this.heading5PaddingRight, bottom: this.heading5PaddingBottom, left: this.heading5PaddingLeft})
    if (this.heading5TextFontColor !== undefined) {
      headingTheme.setTextFontColorForDesignateHeading(5, this.heading5TextFontColor)
    }
    headingTheme.setTextFontSizeForDesignateHeading(5, this.heading5TextFontSize)
    headingTheme.setTextFontStyleForDesignateHeading(5, this.heading5TextFontStyle)
    headingTheme.setTextFontWeightForDesignateHeading(5, this.heading5TextFontWeight)
    headingTheme.setTextFontFamilyForDesignateHeading(5, this.heading5TextFontFamily)
    headingTheme.setTextLineHeightForDesignateHeading(5, this.heading5TextLineHeight)
    headingTheme.setTextLetterSpacingForDesignateHeading(5, this.heading5TextLetterSpacing)
    // 六级标题
    if (this.heading6BackgroundColor !== undefined) {
      headingTheme.setBackgroundColorForDesignateHeading(6, this.heading6BackgroundColor)
    }
    headingTheme.setMarginForDesignateHeading(6, {top: this.heading6MarginTop, right: this.heading6MarginRight, bottom: this.heading6MarginBottom, left: this.heading6MarginLeft})
    headingTheme.setPaddingForDesignateHeading(6, {top: this.heading6PaddingTop, right: this.heading6PaddingRight, bottom: this.heading6PaddingBottom, left: this.heading6PaddingLeft})
    if (this.heading6TextFontColor !== undefined) {
      headingTheme.setTextFontColorForDesignateHeading(6, this.heading6TextFontColor)
    }
    headingTheme.setTextFontSizeForDesignateHeading(6, this.heading6TextFontSize)
    headingTheme.setTextFontStyleForDesignateHeading(6, this.heading6TextFontStyle)
    headingTheme.setTextFontWeightForDesignateHeading(6, this.heading6TextFontWeight)
    headingTheme.setTextFontFamilyForDesignateHeading(6, this.heading6TextFontFamily)
    headingTheme.setTextLineHeightForDesignateHeading(6, this.heading6TextLineHeight)
    headingTheme.setTextLetterSpacingForDesignateHeading(6, this.heading6TextLetterSpacing)
    theme.setHeadingTheme(headingTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    return plugin
  }
}
