import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme,
  MarkdownThemeAudio,
  MarkdownThemeGlobal } from '@cangjie-tpc/markdown_hybrid'
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
  @State // 音频背景颜色
  audioBackgroundColor: number | undefined = undefined
  @State // 音频上外边距
  audioMarginTop: number = 10
  @State // 音频右外边距
  audioMarginRight: number = 0
  @State // 音频下外边距
  audioMarginBottom: number = 10
  @State // 音频左外边距
  audioMarginLeft: number = 0
  @State // 音频上内边距
  audioPaddingTop: number = 0
  @State // 音频右内边距
  audioPaddingRight: number = 0
  @State // 音频下内边距
  audioPaddingBottom: number = 0
  @State // 音频左内边距
  audioPaddingLeft: number = 0
  @State // 音频边框样式
  audioBorderStyle: BorderStyle = BorderStyle.Solid
  @State // 音频边框宽度
  audioBorderWidth: number = 0.5
  @State // 音频边框颜色
  audioBorderColor: number | undefined = undefined
  @State // 音频边框左上圆角
  audioRadiusTopLeft: number = 12
  @State // 音频边框右上圆角
  audioRadiusTopRight: number = 12
  @State // 音频边框左下圆角
  audioRadiusBottomLeft: number = 12
  @State // 音频边框右下圆角
  audioRadiusBottomRight: number = 12
  @State // 音频阴影模糊半径
  audioShadowRadius: number = 0
  @State // 音频阴影X轴偏移量
  audioShadowOffsetX: number = 0
  @State // 音频阴影Y轴偏移量
  audioShadowOffsetY: number = 0
  @State // 音频阴影颜色值
  audioShadowColor: number | undefined = undefined
  audioIcon: Resource | undefined = undefined // 音频图标
  @State // 音频图标宽度
  audioIconWidth: number = 40
  @State // 音频图标高度
  audioIconHeight: number = 40
  @State // 音频图标左上圆角
  audioIconRadiusTopLeft: number = 0
  @State // 音频图标右上圆角
  audioIconRadiusTopRight: number = 0
  @State // 音频图标左下圆角
  audioIconRadiusBottomLeft: number = 0
  @State // 音频图标右下圆角
  audioIconRadiusBottomRight: number = 0
  @State // 音频图标缩放类型
  audioIconFitType: ImageFit = ImageFit.Contain
  @State // 音频标题文本和类型文本间距
  audioTitleToTypeSpacing: number = 8
  @State // 音频按钮宽度
  audioButtonWidth: number = 100
  @State // 音频按钮高度
  audioButtonHeight: number = 32
  @State // 音频按钮背景颜色
  audioButtonBackgroundColor: number | undefined = undefined
  @State // 音频按钮边框样式
  audioButtonBorderStyle: BorderStyle = BorderStyle.Solid
  @State // 音频按钮边框宽度
  audioButtonBorderWidth: number = 0
  @State // 音频按钮边框颜色
  audioButtonBorderColor: number | undefined = undefined
  @State // 音频按钮边框左上圆角
  audioButtonRadiusTopLeft: number = 16
  @State // 音频按钮边框右上圆角
  audioButtonRadiusTopRight: number = 16
  @State // 音频按钮边框左下圆角
  audioButtonRadiusBottomLeft: number = 16
  @State // 音频按钮边框右下圆角
  audioButtonRadiusBottomRight: number = 16
  @State // 音频按钮默认文本内容
  audioButtonText: string = "立即播放"
  @State // 音频按钮文本颜色
  audioButtonTextFontColor: number | undefined = undefined
  @State // 音频按钮文本尺寸
  audioButtonTextFontSize: number = 14
  @State // 音频按钮文本字体样式
  audioButtonTextFontStyle: FontStyle = FontStyle.Normal
  @State // 音频按钮文本字体粗细
  audioButtonTextFontWeight: FontWeight = FontWeight.Normal
  @State // 音频按钮文本字体
  audioButtonTextFontFamily: string = 'HarmonyOS Sans'
  @State // 音频按钮文本行高
  audioButtonTextLineHeight: number = 20
  @State // 音频标题文本颜色
  audioTitleTextFontColor: number | undefined = undefined
  @State // 音频标题文本尺寸
  audioTitleTextFontSize: number = 15
  @State // 音频标题文本字体样式
  audioTitleTextFontStyle: FontStyle = FontStyle.Normal
  @State // 音频标题文本字体粗细
  audioTitleTextFontWeight: FontWeight = FontWeight.Normal
  @State // 音频标题文本字体
  audioTitleTextFontFamily: string = 'HarmonyOS Sans'
  @State // 音频标题文本行高
  audioTitleTextLineHeight: number = 20
  @State // 音频类型文本颜色
  audioTypeTextFontColor: number | undefined = undefined
  @State // 音频类型文本尺寸
  audioTypeTextFontSize: number = 11
  @State // 音频类型文本字体样式
  audioTypeTextFontStyle: FontStyle = FontStyle.Normal
  @State // 音频类型文本字体粗细
  audioTypeTextFontWeight: FontWeight = FontWeight.Normal
  @State // 音频类型文本字体
  audioTypeTextFontFamily: string = 'HarmonyOS Sans'
  @State // 音频类型文本行高
  audioTypeTextLineHeight: number = 15

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
      let audioData: AudioMDData = router.getParams() as AudioMDData
      this.fileStr = getFileContextStr(audioData._pagePath)
      // ---------- 通用
      this.isFull = audioData._isFull
      this.incrementalAnalysis = audioData._incrementalAnalysis
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
  }

  build() {
    Column() {
      titleComponent(
        "音频测试用例",
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
    let globalTheme = new MarkdownThemeGlobal()
    if (this.globalBackgroundColor !== undefined) {
      globalTheme.setBackgroundColor(this.globalBackgroundColor)
    }
    globalTheme.setGlobalMargin(this.blockMarginTop, this.blockMarginRight, this.blockMarginBottom, this.blockMarginLeft)
    globalTheme.setIsLineBreak(this.isLineBreak)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.setMarkdownThemeGlobal(globalTheme)
    
    // ---------- 专有 - Audio
    let audioTheme = new MarkdownThemeAudio()
    if (this.audioBackgroundColor !== undefined) {
      audioTheme.setAudioBackgroundColor(this.audioBackgroundColor)
    }
    audioTheme.setAudioMargin(this.audioMarginTop, this.audioMarginRight, this.audioMarginBottom, this.audioMarginLeft)
    audioTheme.setAudioPadding(this.audioPaddingTop, this.audioPaddingRight, this.audioPaddingBottom, this.audioPaddingLeft)
    audioTheme.setAudioBorderStyle(this.audioBorderStyle)
    audioTheme.setAudioBorderWidth(this.audioBorderWidth)
    if (this.audioBorderColor !== undefined) {
      audioTheme.setAudioBorderColor(this.audioBorderColor)
    }
    audioTheme.setAudioBorderRadius(this.audioRadiusTopLeft, this.audioRadiusTopRight, this.audioRadiusBottomLeft, this.audioRadiusBottomRight)
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
    audioTheme.setAudioIconRadius(this.audioIconRadiusTopLeft, this.audioIconRadiusTopRight, this.audioIconRadiusBottomLeft, this.audioIconRadiusBottomRight)
    audioTheme.setAudioIconFitType(this.audioIconFitType)
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
    audioTheme.setAudioButtonRadius(this.audioButtonRadiusTopLeft, this.audioButtonRadiusTopRight, this.audioButtonRadiusBottomLeft, this.audioButtonRadiusBottomRight)
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
    theme.setMarkdownThemeAudio(audioTheme)
    
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
