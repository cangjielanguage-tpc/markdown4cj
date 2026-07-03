import {
  AudioTheme,
  CJMarkdown,
  GlobalTheme,
  // ImageFitType,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme} from '@cangjie-tpc/markdown_hybrid'
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { getFileContextStr } from '../utils/FileUtils'
import { AudioMDData } from '../model/AudioMDData'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct AudioDetailsPage {
  // ---------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // Markdown的控制器
  markdownScroller: Scroller = new Scroller()
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
  @State // Markdown块间距样式字符串
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
  @State // 音频背景颜色
  audioBackgroundColor: ResourceColor | undefined = undefined
  @State // 音频上外边距
  audioMarginTop: Length = 0.0
  @State // 音频右外边距
  audioMarginRight: Length = 0.0
  @State // 音频下外边距
  audioMarginBottom: Length = 0.0
  @State // 音频左外边距
  audioMarginLeft: Length = 0.0
  @State // 音频上内边距
  audioPaddingTop: Length = 12.0
  @State // 音频右内边距
  audioPaddingRight: Length = 16.0
  @State // 音频下内边距
  audioPaddingBottom: Length = 12.0
  @State // 音频左内边距
  audioPaddingLeft: Length = 12.0
  @State // 音频边框样式
  audioBorderStyle: BorderStyle = BorderStyle.Solid
  @State // 音频边框宽度
  audioBorderWidth: Length = 0.5
  @State // 音频边框颜色
  audioBorderColor: ResourceColor | undefined = undefined
  @State // 音频边框左上圆角
  audioRadiusTopLeft: Length = 12.0
  @State // 音频边框右上圆角
  audioRadiusTopRight: Length = 12.0
  @State // 音频边框左下圆角
  audioRadiusBottomLeft: Length = 12.0
  @State // 音频边框右下圆角
  audioRadiusBottomRight: Length = 12.0
  @State // 音频阴影模糊半径
  audioShadowRadius: number = 0
  @State // 音频阴影X轴偏移量
  audioShadowOffsetX: number = 0
  @State // 音频阴影Y轴偏移量
  audioShadowOffsetY: number = 0
  @State // 音频阴影颜色值
  audioShadowColor: ResourceColor | undefined = undefined
  audioIcon: Resource | undefined = undefined // 音频图标
  @State // 音频图标宽度
  audioIconWidth: Length = 40.0
  @State // 音频图标高度
  audioIconHeight: Length = 40.0
  @State // 音频图标左上圆角
  audioIconRadiusTopLeft: Length = 8.0
  @State // 音频图标右上圆角
  audioIconRadiusTopRight: Length = 8.0
  @State // 音频图标左下圆角
  audioIconRadiusBottomLeft: Length = 8.0
  @State // 音频图标右下圆角
  audioIconRadiusBottomRight: Length = 8.0
  @State // 音频图标缩放类型
  audioIconFitType: ImageFit = ImageFit.Contain
  @State // 音频标题文本和类型文本间距
  audioTitleToTypeSpacing: number = 8
  @State // 音频按钮宽度
  audioButtonWidth: Length = 84.0
  @State // 音频按钮高度
  audioButtonHeight: Length = 32.0
  @State // 音频按钮背景颜色
  audioButtonBackgroundColor: ResourceColor | undefined = undefined
  @State // 音频按钮边框样式
  audioButtonBorderStyle: BorderStyle = BorderStyle.Solid
  @State // 音频按钮边框宽度
  audioButtonBorderWidth: Length = 0.0
  @State // 音频按钮边框颜色
  audioButtonBorderColor: ResourceColor | undefined = undefined
  @State // 音频按钮边框左上圆角
  audioButtonRadiusTopLeft: Length = 16.0
  @State // 音频按钮边框右上圆角
  audioButtonRadiusTopRight: Length = 16.0
  @State // 音频按钮边框左下圆角
  audioButtonRadiusBottomLeft: Length = 16.0
  @State // 音频按钮边框右下圆角
  audioButtonRadiusBottomRight: Length = 16.0
  @State // 音频按钮默认文本内容
  audioButtonText: string = "立即播放"
  @State // 音频按钮文本颜色
  audioButtonTextFontColor: ResourceColor | undefined = undefined
  @State // 音频按钮文本尺寸
  audioButtonTextFontSize: number | string | Resource = 14.0
  @State // 音频按钮文本字体样式
  audioButtonTextFontStyle: FontStyle = FontStyle.Normal
  @State // 音频按钮文本字体粗细
  audioButtonTextFontWeight: number | FontWeight = FontWeight.Medium
  @State // 音频按钮文本字体
  audioButtonTextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 音频按钮文本行高
  audioButtonTextLineHeight: number | string | Resource = 22.0
  @State // 音频标题文本颜色
  audioTitleTextFontColor: ResourceColor | undefined = undefined
  @State // 音频标题文本尺寸
  audioTitleTextFontSize: number | string | Resource = 15.0
  @State // 音频标题文本字体样式
  audioTitleTextFontStyle: FontStyle = FontStyle.Normal
  @State // 音频标题文本字体粗细
  audioTitleTextFontWeight: number | FontWeight = FontWeight.Bold
  @State // 音频标题文本字体
  audioTitleTextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 音频标题文本行高
  audioTitleTextLineHeight: number | string | Resource = 20.0
  @State // 音频类型文本颜色
  audioTypeTextFontColor: ResourceColor | undefined = undefined
  @State // 音频类型文本尺寸
  audioTypeTextFontSize: number | string | Resource = 11.0
  @State // 音频类型文本字体样式
  audioTypeTextFontStyle: FontStyle = FontStyle.Normal
  @State // 音频类型文本字体粗细
  audioTypeTextFontWeight: number | FontWeight = FontWeight.Normal
  @State // 音频类型文本字体
  audioTypeTextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 音频类型文本行高
  audioTypeTextLineHeight: number | string | Resource = 15.0

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let audioData: AudioMDData = router.getParams() as AudioMDData
      this.fileStr = getFileContextStr(audioData._pagePath)
      // ---------- 通用
      this.isFull = audioData._isFull
      this.incrementalAnalysis = audioData._incrementalAnalysis
      this.enableParseThrottle = audioData._enableParseThrottle
      this.parseThrottleMs = audioData._parseThrottleMs
      this.time = audioData._time
      this.textNumber = audioData._textNumber
      this.isMarkdownParserSync = audioData._isMarkdownParserSync
      this.isOnCopy = audioData._isOnCopy
      this.blockMarginTop = audioData._blockMarginTop
      this.blockMarginRight = audioData._blockMarginRight
      this.blockMarginBottom = audioData._blockMarginBottom
      this.blockMarginLeft = audioData._blockMarginLeft
      this.markdownBlockSpacing = audioData._markdownBlockSpacing
      this.isLineBreak = audioData._isLineBreak
      this.globalBackgroundColor = audioData._backgroundColor
      this.openGestureSwipe = audioData._openGestureSwipe
      this.openGestureSwipeTest = audioData._openGestureSwipeTest
      // ---------- 专有
      this.audioBackgroundColor = audioData._audioBackgroundColor
      this.audioMarginTop = audioData._audioMarginTop
      this.audioMarginRight = audioData._audioMarginRight
      this.audioMarginBottom = audioData._audioMarginBottom
      this.audioMarginLeft = audioData._audioMarginLeft
      this.audioPaddingTop = audioData._audioPaddingTop
      this.audioPaddingRight = audioData._audioPaddingRight
      this.audioPaddingBottom = audioData._audioPaddingBottom
      this.audioPaddingLeft = audioData._audioPaddingLeft
      this.audioBorderStyle = audioData._audioBorderStyle
      this.audioBorderWidth = audioData._audioBorderWidth
      this.audioBorderColor = audioData._audioBorderColor
      this.audioRadiusTopLeft = audioData._audioRadiusTopLeft
      this.audioRadiusTopRight = audioData._audioRadiusTopRight
      this.audioRadiusBottomLeft = audioData._audioRadiusBottomLeft
      this.audioRadiusBottomRight = audioData._audioRadiusBottomRight
      this.audioShadowRadius = audioData._audioShadowRadius
      this.audioShadowOffsetX = audioData._audioShadowOffsetX
      this.audioShadowOffsetY = audioData._audioShadowOffsetY
      this.audioShadowColor = audioData._audioShadowColor
      this.audioIcon = audioData._audioIcon
      this.audioIconWidth = audioData._audioIconWidth
      this.audioIconHeight = audioData._audioIconHeight
      this.audioIconRadiusTopLeft = audioData._audioIconRadiusTopLeft
      this.audioIconRadiusTopRight = audioData._audioIconRadiusTopRight
      this.audioIconRadiusBottomLeft = audioData._audioIconRadiusBottomLeft
      this.audioIconRadiusBottomRight = audioData._audioIconRadiusBottomRight
      this.audioIconFitType = audioData._audioIconFitType
      this.audioTitleToTypeSpacing = audioData._audioTitleToTypeSpacing
      this.audioButtonWidth = audioData._audioButtonWidth
      this.audioButtonHeight = audioData._audioButtonHeight
      this.audioButtonBackgroundColor = audioData._audioButtonBackgroundColor
      this.audioButtonBorderStyle = audioData._audioButtonBorderStyle
      this.audioButtonBorderWidth = audioData._audioButtonBorderWidth
      this.audioButtonBorderColor = audioData._audioButtonBorderColor
      this.audioButtonRadiusTopLeft = audioData._audioButtonRadiusTopLeft
      this.audioButtonRadiusTopRight = audioData._audioButtonRadiusTopRight
      this.audioButtonRadiusBottomLeft = audioData._audioButtonRadiusBottomLeft
      this.audioButtonRadiusBottomRight = audioData._audioButtonRadiusBottomRight
      this.audioButtonText = audioData._audioButtonText
      this.audioButtonTextFontColor = audioData._audioButtonTextFontColor
      this.audioButtonTextFontSize = audioData._audioButtonTextFontSize
      this.audioButtonTextFontStyle = audioData._audioButtonTextFontStyle
      this.audioButtonTextFontWeight = audioData._audioButtonTextFontWeight
      this.audioButtonTextFontFamily = audioData._audioButtonTextFontFamily
      this.audioButtonTextLineHeight = audioData._audioButtonTextLineHeight
      this.audioTitleTextFontColor = audioData._audioTitleTextFontColor
      this.audioTitleTextFontSize = audioData._audioTitleTextFontSize
      this.audioTitleTextFontStyle = audioData._audioTitleTextFontStyle
      this.audioTitleTextFontWeight = audioData._audioTitleTextFontWeight
      this.audioTitleTextFontFamily = audioData._audioTitleTextFontFamily
      this.audioTitleTextLineHeight = audioData._audioTitleTextLineHeight
      this.audioTypeTextFontColor = audioData._audioTypeTextFontColor
      this.audioTypeTextFontSize = audioData._audioTypeTextFontSize
      this.audioTypeTextFontStyle = audioData._audioTypeTextFontStyle
      this.audioTypeTextFontWeight = audioData._audioTypeTextFontWeight
      this.audioTypeTextFontFamily = audioData._audioTypeTextFontFamily
      this.audioTypeTextLineHeight = audioData._audioTypeTextLineHeight
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
        "音频测试用例",
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
    config.setAudioCallback(this.audioCallback)
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
    
    // ---------- 专有 - Audio
    let audioTheme = new AudioTheme()
    if (this.audioBackgroundColor !== undefined) {
      audioTheme.setAudioBackgroundColor(this.audioBackgroundColor)
    }
    audioTheme.setAudioMargin({top: this.audioMarginTop, right: this.audioMarginRight, bottom: this.audioMarginBottom, left: this.audioMarginLeft})
    audioTheme.setAudioPadding({top: this.audioPaddingTop, right: this.audioPaddingRight, bottom: this.audioPaddingBottom, left: this.audioPaddingLeft})
    audioTheme.setAudioBorderStyle(this.audioBorderStyle)
    audioTheme.setAudioBorderWidth(this.audioBorderWidth)
    if (this.audioBorderColor !== undefined) {
      audioTheme.setAudioBorderColor(this.audioBorderColor)
    }
    audioTheme.setAudioBorderRadius({topLeft: this.audioRadiusTopLeft, topRight: this.audioRadiusTopRight, bottomLeft: this.audioRadiusBottomLeft, bottomRight: this.audioRadiusBottomRight})
    audioTheme.setAudioShadowRadius(this.audioShadowRadius)
    audioTheme.setAudioShadowOffsetX(this.audioShadowOffsetX)
    audioTheme.setAudioShadowOffsetY(this.audioShadowOffsetY)
    if (this.audioShadowColor !== undefined) {
      audioTheme.setAudioShadowColor(this.audioShadowColor)
    }
    if (this.audioIcon !== undefined) {
      audioTheme.setAudioIcon(this.audioIcon)
    }
    audioTheme.setAudioIconWidth(this.audioIconWidth)
    audioTheme.setAudioIconHeight(this.audioIconHeight)
    audioTheme.setAudioIconRadius({topLeft: this.audioIconRadiusTopLeft, topRight: this.audioIconRadiusTopRight, bottomLeft: this.audioIconRadiusBottomLeft, bottomRight: this.audioIconRadiusBottomRight})
    if (this.audioIconFitType !== undefined) {
      audioTheme.setAudioIconFitType(this.audioIconFitType)
    }
    audioTheme.setAudioTitleToTypeSpacing(this.audioTitleToTypeSpacing)
    audioTheme.setAudioButtonWidth(this.audioButtonWidth)
    audioTheme.setAudioButtonHeight(this.audioButtonHeight)
    if (this.audioButtonBackgroundColor !== undefined) {
      audioTheme.setAudioButtonBackgroundColor(this.audioButtonBackgroundColor)
    }
    audioTheme.setAudioButtonBorderStyle(this.audioButtonBorderStyle)
    audioTheme.setAudioButtonBorderWidth(this.audioButtonBorderWidth)
    if (this.audioButtonBorderColor !== undefined) {
      audioTheme.setAudioButtonBorderColor(this.audioButtonBorderColor)
    }
    audioTheme.setAudioButtonRadius({topLeft: this.audioButtonRadiusTopLeft, topRight: this.audioButtonRadiusTopRight, bottomLeft: this.audioButtonRadiusBottomLeft, bottomRight: this.audioButtonRadiusBottomRight})
    audioTheme.setAudioButtonText(this.audioButtonText)
    if (this.audioButtonTextFontColor !== undefined) {
      audioTheme.setAudioButtonTextFontColor(this.audioButtonTextFontColor)
    }
    audioTheme.setAudioButtonTextFontSize(this.audioButtonTextFontSize)
    audioTheme.setAudioButtonTextFontStyle(this.audioButtonTextFontStyle)
    audioTheme.setAudioButtonTextFontWeight(this.audioButtonTextFontWeight)
    audioTheme.setAudioButtonTextFontFamily(this.audioButtonTextFontFamily)
    audioTheme.setAudioButtonTextLineHeight(this.audioButtonTextLineHeight)
    if (this.audioTitleTextFontColor !== undefined) {
      audioTheme.setAudioTitleTextFontColor(this.audioTitleTextFontColor)
    }
    audioTheme.setAudioTitleTextFontSize(this.audioTitleTextFontSize)
    audioTheme.setAudioTitleTextFontStyle(this.audioTitleTextFontStyle)
    audioTheme.setAudioTitleTextFontWeight(this.audioTitleTextFontWeight)
    audioTheme.setAudioTitleTextFontFamily(this.audioTitleTextFontFamily)
    audioTheme.setAudioTitleTextLineHeight(this.audioTitleTextLineHeight)
    if (this.audioTypeTextFontColor !== undefined) {
      audioTheme.setAudioTypeTextFontColor(this.audioTypeTextFontColor)
    }
    audioTheme.setAudioTypeTextFontSize(this.audioTypeTextFontSize)
    audioTheme.setAudioTypeTextFontStyle(this.audioTypeTextFontStyle)
    audioTheme.setAudioTypeTextFontWeight(this.audioTypeTextFontWeight)
    audioTheme.setAudioTypeTextFontFamily(this.audioTypeTextFontFamily)
    audioTheme.setAudioTypeTextLineHeight(this.audioTypeTextLineHeight)
    theme.setAudioTheme(audioTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsLatexMathPlugin(true) // 数学公式插件
    plugin.setIsHtmlPlugin(true) // HTML插件
    plugin.setIsBlockAudioPlugin(true) // 音频插件
    plugin.setIsBlockVideoPlugin(true) // 视频插件
    plugin.setIsCodeListPlugin(true) // 组合代码快列表插件
    plugin.setIsImageSlidePlugin(true) // 图片幻灯片（Banner）插件
    return plugin
  }

  audioCallback(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }
}
