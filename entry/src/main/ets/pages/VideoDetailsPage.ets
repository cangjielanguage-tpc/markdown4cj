import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown,
  MarkdownConfiguration,
  MarkdownPlugin,
  MarkdownTheme,
  GlobalTheme,
  VideoTheme} from '@cangjie-tpc/markdown_arkui'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { VideoData } from '../model/VideoData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct VideoDetailsPage {
  // ---------- 通用
  scroller: Scroller = new Scroller() // 滑动控制器
  markdownScroller: Scroller = new Scroller() // Markdown的控制器
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  @StorageProp('currentColorMode') // 深浅色模式
  @Watch('onColorModeChanged') // 系统深浅色切换：重建markdown主题并重新下发
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
  @State // 视频背景颜色
  videoBackgroundColor: ResourceColor | undefined = undefined
  @State // 视频上外边距
  videoMarginTop: Length = 0.0
  @State // 视频右外边距
  videoMarginRight: Length = 0.0
  @State // 视频下外边距
  videoMarginBottom: Length = 0.0
  @State // 视频左外边距
  videoMarginLeft: Length = 0.0
  @State // 视频上内边距
  videoPaddingTop: Length = 0.0
  @State // 视频右内边距
  videoPaddingRight: Length = 0.0
  @State // 视频下内边距
  videoPaddingBottom: Length = 0.0
  @State // 视频左内边距
  videoPaddingLeft: Length = 0.0
  @State // 视频边框左上圆角
  videoRadiusTopLeft: Length = 10.0
  @State // 视频边框右上圆角
  videoRadiusTopRight: Length = 10.0
  @State // 视频边框左下圆角
  videoRadiusBottomLeft: Length = 10.0
  @State // 视频边框右下圆角
  videoRadiusBottomRight: Length = 10.0
  @State // 视频边框样式
  videoBorderStyle: BorderStyle = BorderStyle.Solid
  @State // 视频边框宽度
  videoBorderWidth: Length = 0.0
  @State // 视频边框颜色
  videoBorderColor: ResourceColor | undefined = undefined
  videoPlaceholder: Resource | undefined = undefined // 视频占位图
  @State // 视频图片缩放类型
  videoImageFitType: ImageFit = ImageFit.Contain
  videoPlayIcon: Resource | undefined = undefined // 播放按钮默认图片
  @State // 播放按钮图标宽度
  videoPlayIconWidth: Length = 60.0
  @State // 播放按钮图标高度
  videoPlayIconHeight: Length = 60.0
  @State // 播放按钮图标缩放类型
  videoPlayIconFitType: ImageFit = ImageFit.Contain
  @State // 视频时间文本颜色
  videoTimeTextFontColor: ResourceColor | undefined = undefined
  @State // 视频时间文本尺寸
  videoTimeTextFontSize: number | string | Resource = 14.0
  @State // 视频时间文本字体样式
  videoTimeTextFontStyle: FontStyle = FontStyle.Normal
  @State // 视频时间文本字体粗细
  videoTimeTextFontWeight: number | FontWeight = FontWeight.Normal
  @State // 视频时间文本字体
  videoTimeTextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 视频时间文本行高
  videoTimeTextLineHeight: number | string | Resource = 22.0
  @State // 视频时间文本居右边距
  videoTimeTextMarginRight: Length = 10.0
  @State // 视频时间文本居底边距
  videoTimeTextMarginBottom: Length = 10.0
  @State // 底部布局是否显示（视频发布/下载按钮）
  videoBottomLayoutVisible: boolean = false
  @State // 底部布局距离视频上边距
  videoBottomLayoutMarginTop: Length = 14.0
  @State // 视频发布按钮是否显示
  videoReleaseButtonVisible: boolean = true
  @State // 视频发布按钮背景颜色
  videoReleaseButtonBackgroundColor: ResourceColor | undefined = undefined
  @State // 视频发布按钮宽度
  videoReleaseButtonWidth: Length = 144.0
  @State // 视频发布按钮高度
  videoReleaseButtonHeight: Length = 44.0
  @State // 视频发布按钮左上圆角
  videoReleaseButtonRadiusTopLeft: Length = 22.0
  @State // 视频发布按钮右上圆角
  videoReleaseButtonRadiusTopRight: Length = 22.0
  @State // 视频发布按钮左下圆角
  videoReleaseButtonRadiusBottomLeft: Length = 22.0
  @State // 视频发布按钮右下圆角
  videoReleaseButtonRadiusBottomRight: Length = 22.0
  @State // 视频发布按钮图标和文本间距
  videoReleaseButtonIconTextGap: number = 6.0
  videoReleaseButtonIcon: Resource | undefined = undefined // 视频发布按钮图标
  @State // 视频发布按钮图标宽度
  videoReleaseButtonIconWidth: Length = 18.0
  @State // 视频发布按钮图标高度
  videoReleaseButtonIconHeight: Length = 18.0
  @State // 视频发布按钮默认文本内容
  videoReleaseButtonText: string = "发布视频"
  @State // 视频发布按钮文本颜色
  videoReleaseButtonTextFontColor: ResourceColor | undefined = undefined
  @State // 视频发布按钮文本尺寸
  videoReleaseButtonTextFontSize: number | string | Resource = 16.0
  @State // 视频发布按钮文本字体样式
  videoReleaseButtonTextFontStyle: FontStyle = FontStyle.Normal
  @State // 视频发布按钮文本字体粗细
  videoReleaseButtonTextFontWeight: number | FontWeight = FontWeight.Medium
  @State // 视频发布按钮文本字体
  videoReleaseButtonTextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 视频发布按钮文本行高
  videoReleaseButtonTextLineHeight: number | string | Resource = 22.0
  @State // 视频下载按钮是否显示
  videoDownloadButtonVisible: boolean = true
  @State // 视频下载按钮背景颜色
  videoDownloadButtonBackgroundColor: ResourceColor | undefined = undefined
  @State // 视频下载按钮宽度
  videoDownloadButtonWidth: Length = 144.0
  @State // 视频下载按钮高度
  videoDownloadButtonHeight: Length = 44.0
  @State // 视频下载按钮左上圆角
  videoDownloadButtonRadiusTopLeft: Length = 22.0
  @State // 视频下载按钮右上圆角
  videoDownloadButtonRadiusTopRight: Length = 22.0
  @State // 视频下载按钮左下圆角
  videoDownloadButtonRadiusBottomLeft: Length = 22.0
  @State // 视频下载按钮右下圆角
  videoDownloadButtonRadiusBottomRight: Length = 22.0
  @State // 视频下载按钮图标和文本间距
  videoDownloadButtonIconTextGap: number = 6.0
  videoDownloadButtonIcon: Resource | undefined = undefined // 视频下载按钮图标
  @State // 视频下载按钮图标宽度
  videoDownloadButtonIconWidth: Length = 18.0
  @State // 视频下载按钮图标高度
  videoDownloadButtonIconHeight: Length = 18.0
  @State // 视频下载按钮默认文本内容
  videoDownloadButtonText: string = "下载视频"
  @State // 视频下载按钮文本颜色
  videoDownloadButtonTextFontColor: ResourceColor | undefined = undefined
  @State // 视频下载按钮文本尺寸
  videoDownloadButtonTextFontSize: number | string | Resource = 16.0
  @State // 视频下载按钮文本字体样式
  videoDownloadButtonTextFontStyle: FontStyle = FontStyle.Normal
  @State // 视频下载按钮文本字体粗细
  videoDownloadButtonTextFontWeight: number | FontWeight = FontWeight.Medium
  @State // 视频下载按钮文本字体
  videoDownloadButtonTextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 视频下载按钮文本行高
  videoDownloadButtonTextLineHeight: number | string | Resource = 22.0

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let videoData: VideoData = router.getParams() as VideoData
      this.fileStr = getFileContextStr(videoData._pagePath)
      // ---------- 通用
      this.isFull = videoData._isFull
      this.incrementalAnalysis = videoData._incrementalAnalysis
      this.enableParseThrottle = videoData._enableParseThrottle
      this.parseThrottleMs = videoData._parseThrottleMs
      this.time = videoData._time
      this.textNumber = videoData._textNumber
      this.isMarkdownParserSync = videoData._isMarkdownParserSync
      this.isOnCopy = videoData._isOnCopy
      this.blockMarginTop = videoData._blockMarginTop
      this.blockMarginRight = videoData._blockMarginRight
      this.blockMarginBottom = videoData._blockMarginBottom
      this.blockMarginLeft = videoData._blockMarginLeft
      this.markdownBlockSpacing = videoData._markdownBlockSpacing
      this.isLineBreak = videoData._isLineBreak
      this.globalBackgroundColor = videoData._backgroundColor
      this.openGestureSwipe = videoData._openGestureSwipe
      this.openGestureSwipeTest = videoData._openGestureSwipeTest
      // ---------- 专有
      this.videoBackgroundColor = videoData._videoBackgroundColor
      this.videoMarginTop = videoData._videoMarginTop
      this.videoMarginRight = videoData._videoMarginRight
      this.videoMarginBottom = videoData._videoMarginBottom
      this.videoMarginLeft = videoData._videoMarginLeft
      this.videoPaddingTop = videoData._videoPaddingTop
      this.videoPaddingRight = videoData._videoPaddingRight
      this.videoPaddingBottom = videoData._videoPaddingBottom
      this.videoPaddingLeft = videoData._videoPaddingLeft
      this.videoRadiusTopLeft = videoData._videoRadiusTopLeft
      this.videoRadiusTopRight = videoData._videoRadiusTopRight
      this.videoRadiusBottomLeft = videoData._videoRadiusBottomLeft
      this.videoRadiusBottomRight = videoData._videoRadiusBottomRight
      this.videoBorderStyle = videoData._videoBorderStyle
      this.videoBorderWidth = videoData._videoBorderWidth
      this.videoBorderColor = videoData._videoBorderColor
      this.videoPlaceholder = videoData._videoPlaceholder
      this.videoImageFitType = videoData._videoImageFitType
      this.videoPlayIcon = videoData._videoPlayIcon
      this.videoPlayIconWidth = videoData._videoPlayIconWidth
      this.videoPlayIconHeight = videoData._videoPlayIconHeight
      this.videoPlayIconFitType = videoData._videoPlayIconFitType
      this.videoTimeTextFontColor = videoData._videoTimeTextFontColor
      this.videoTimeTextFontSize = videoData._videoTimeTextFontSize
      this.videoTimeTextFontStyle = videoData._videoTimeTextFontStyle
      this.videoTimeTextFontWeight = videoData._videoTimeTextFontWeight
      this.videoTimeTextFontFamily = videoData._videoTimeTextFontFamily
      this.videoTimeTextLineHeight = videoData._videoTimeTextLineHeight
      this.videoTimeTextMarginRight = videoData._videoTimeTextMarginRight
      this.videoTimeTextMarginBottom = videoData._videoTimeTextMarginBottom
      this.videoBottomLayoutVisible = videoData._videoBottomLayoutVisible
      this.videoBottomLayoutMarginTop = videoData._videoBottomLayoutMarginTop
      this.videoReleaseButtonVisible = videoData._videoReleaseButtonVisible
      this.videoReleaseButtonBackgroundColor = videoData._videoReleaseButtonBackgroundColor
      this.videoReleaseButtonWidth = videoData._videoReleaseButtonWidth
      this.videoReleaseButtonHeight = videoData._videoReleaseButtonHeight
      this.videoReleaseButtonRadiusTopLeft = videoData._videoReleaseButtonRadiusTopLeft
      this.videoReleaseButtonRadiusTopRight = videoData._videoReleaseButtonRadiusTopRight
      this.videoReleaseButtonRadiusBottomLeft = videoData._videoReleaseButtonRadiusBottomLeft
      this.videoReleaseButtonRadiusBottomRight = videoData._videoReleaseButtonRadiusBottomRight
      this.videoReleaseButtonIconTextGap = videoData._videoReleaseButtonIconTextGap
      this.videoReleaseButtonIcon = videoData._videoReleaseButtonIcon
      this.videoReleaseButtonIconWidth = videoData._videoReleaseButtonIconWidth
      this.videoReleaseButtonIconHeight = videoData._videoReleaseButtonIconHeight
      this.videoReleaseButtonText = videoData._videoReleaseButtonText
      this.videoReleaseButtonTextFontColor = videoData._videoReleaseButtonTextFontColor
      this.videoReleaseButtonTextFontSize = videoData._videoReleaseButtonTextFontSize
      this.videoReleaseButtonTextFontStyle = videoData._videoReleaseButtonTextFontStyle
      this.videoReleaseButtonTextFontWeight = videoData._videoReleaseButtonTextFontWeight
      this.videoReleaseButtonTextFontFamily = videoData._videoReleaseButtonTextFontFamily
      this.videoReleaseButtonTextLineHeight = videoData._videoReleaseButtonTextLineHeight
      this.videoDownloadButtonVisible = videoData._videoDownloadButtonVisible
      this.videoDownloadButtonBackgroundColor = videoData._videoDownloadButtonBackgroundColor
      this.videoDownloadButtonWidth = videoData._videoDownloadButtonWidth
      this.videoDownloadButtonHeight = videoData._videoDownloadButtonHeight
      this.videoDownloadButtonRadiusTopLeft = videoData._videoDownloadButtonRadiusTopLeft
      this.videoDownloadButtonRadiusTopRight = videoData._videoDownloadButtonRadiusTopRight
      this.videoDownloadButtonRadiusBottomLeft = videoData._videoDownloadButtonRadiusBottomLeft
      this.videoDownloadButtonRadiusBottomRight = videoData._videoDownloadButtonRadiusBottomRight
      this.videoDownloadButtonIconTextGap = videoData._videoDownloadButtonIconTextGap
      this.videoDownloadButtonIcon = videoData._videoDownloadButtonIcon
      this.videoDownloadButtonIconWidth = videoData._videoDownloadButtonIconWidth
      this.videoDownloadButtonIconHeight = videoData._videoDownloadButtonIconHeight
      this.videoDownloadButtonText = videoData._videoDownloadButtonText
      this.videoDownloadButtonTextFontColor = videoData._videoDownloadButtonTextFontColor
      this.videoDownloadButtonTextFontSize = videoData._videoDownloadButtonTextFontSize
      this.videoDownloadButtonTextFontStyle = videoData._videoDownloadButtonTextFontStyle
      this.videoDownloadButtonTextFontWeight = videoData._videoDownloadButtonTextFontWeight
      this.videoDownloadButtonTextFontFamily = videoData._videoDownloadButtonTextFontFamily
      this.videoDownloadButtonTextLineHeight = videoData._videoDownloadButtonTextLineHeight
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
        "视频测试用例",
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
    config.setVideoCallback(this.videoCallback) // 视频点击回调
    config.setVideoImageCallback(this.videoImageCallback) // 视频占位图和宽高比和视频时长的回调
    config.setVideoReleaseCallback(this.videoReleaseCallback) // 视频发布的点击事件
    config.setVideoDownloadCallback(this.videoDownloadCallback) // 视频下载的点击事件
    return config
  }

  // 系统深浅色切换：重建markdown主题并重新下发（CJMarkdown onConfigChanged 同步 renderTheme，按代次分类刷新）
  onColorModeChanged(): void {
    this.markdownTheme = this.setMarkdownTheme()
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
  }

  setMarkdownTheme(): MarkdownTheme {
    let theme = new MarkdownTheme()
    if (this.currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      theme.setDefaultTheme()
    } else {
      theme.setDarculaTheme()
    }
    // ---------- 通用 - Global
    if (this.globalBackgroundColor !== undefined) {
      theme.globalTheme.setBackgroundColor(this.globalBackgroundColor)
    }
    theme.globalTheme.setGlobalMargin({top: this.blockMarginTop, right: this.blockMarginRight, bottom: this.blockMarginBottom, left: this.blockMarginLeft})
    theme.globalTheme.setBlockSpacing(this.markdownBlockSpacing)
    theme.globalTheme.setIsLineBreak(this.isLineBreak)
    theme.globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    theme.globalTheme.setIsOnCopy(this.isOnCopy)
    theme.globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.globalTheme.setEnableParseThrottle(this.enableParseThrottle)
    theme.globalTheme.setParseThrottleMs(this.parseThrottleMs)
    
    // ---------- 专有 - Video
    if (this.videoBackgroundColor !== undefined) {
      theme.videoTheme.setVideoBackgroundColor(this.videoBackgroundColor)
    }
    theme.videoTheme.setVideoMargin({top: this.videoMarginTop, right: this.videoMarginRight, bottom: this.videoMarginBottom, left: this.videoMarginLeft})
    theme.videoTheme.setVideoPadding({top: this.videoPaddingTop, right: this.videoPaddingRight, bottom: this.videoPaddingBottom, left: this.videoPaddingLeft})
    theme.videoTheme.setVideoBorderRadius({topLeft: this.videoRadiusTopLeft, topRight: this.videoRadiusTopRight, bottomLeft: this.videoRadiusBottomLeft, bottomRight: this.videoRadiusBottomRight})
    theme.videoTheme.setVideoBorderStyle(this.videoBorderStyle)
    theme.videoTheme.setVideoBorderWidth(this.videoBorderWidth)
    if (this.videoBorderColor !== undefined) {
      theme.videoTheme.setVideoBorderColor(this.videoBorderColor)
    }
    if (this.videoPlaceholder !== undefined) {
      theme.videoTheme.setVideoPlaceholder(this.videoPlaceholder)
    }
    if (this.videoImageFitType !== undefined) {
      theme.videoTheme.setVideoImageFitType(this.videoImageFitType)
    }
    if (this.videoPlayIcon !== undefined) {
      theme.videoTheme.setVideoPlayIcon(this.videoPlayIcon)
    }
    theme.videoTheme.setVideoPlayIconWidth(this.videoPlayIconWidth)
    theme.videoTheme.setVideoPlayIconHeight(this.videoPlayIconHeight)
    if (this.videoPlayIconFitType !== undefined) {
      theme.videoTheme.setVideoPlayIconFitType(this.videoPlayIconFitType)
    }
    if (this.videoTimeTextFontColor !== undefined) {
      theme.videoTheme.setVideoTimeTextFontColor(this.videoTimeTextFontColor)
    }
    theme.videoTheme.setVideoTimeTextFontSize(this.videoTimeTextFontSize)
    theme.videoTheme.setVideoTimeTextFontStyle(this.videoTimeTextFontStyle)
    theme.videoTheme.setVideoTimeTextFontWeight(this.videoTimeTextFontWeight)
    theme.videoTheme.setVideoTimeTextFontFamily(this.videoTimeTextFontFamily)
    theme.videoTheme.setVideoTimeTextLineHeight(this.videoTimeTextLineHeight)
    theme.videoTheme.setVideoTimeTextMarginRight(this.videoTimeTextMarginRight)
    theme.videoTheme.setVideoTimeTextMarginBottom(this.videoTimeTextMarginBottom)
    theme.videoTheme.setVideoBottomLayoutVisible(this.videoBottomLayoutVisible)
    theme.videoTheme.setVideoBottomLayoutMarginTop(this.videoBottomLayoutMarginTop)
    theme.videoTheme.setVideoReleaseButtonVisible(this.videoReleaseButtonVisible)
    if (this.videoReleaseButtonBackgroundColor !== undefined) {
      theme.videoTheme.setVideoReleaseButtonBackgroundColor(this.videoReleaseButtonBackgroundColor)
    }
    theme.videoTheme.setVideoReleaseButtonWidth(this.videoReleaseButtonWidth)
    theme.videoTheme.setVideoReleaseButtonHeight(this.videoReleaseButtonHeight)
    theme.videoTheme.setVideoReleaseButtonRadius({topLeft: this.videoReleaseButtonRadiusTopLeft, topRight: this.videoReleaseButtonRadiusTopRight, bottomLeft: this.videoReleaseButtonRadiusBottomLeft, bottomRight: this.videoReleaseButtonRadiusBottomRight})
    theme.videoTheme.setVideoReleaseButtonIconTextGap(this.videoReleaseButtonIconTextGap)
    if (this.videoReleaseButtonIcon !== undefined) {
      theme.videoTheme.setVideoReleaseButtonIcon(this.videoReleaseButtonIcon)
    }
    theme.videoTheme.setVideoReleaseButtonIconWidth(this.videoReleaseButtonIconWidth)
    theme.videoTheme.setVideoReleaseButtonIconHeight(this.videoReleaseButtonIconHeight)
    theme.videoTheme.setVideoReleaseButtonText(this.videoReleaseButtonText)
    if (this.videoReleaseButtonTextFontColor !== undefined) {
      theme.videoTheme.setVideoReleaseButtonTextFontColor(this.videoReleaseButtonTextFontColor)
    }
    theme.videoTheme.setVideoReleaseButtonTextFontSize(this.videoReleaseButtonTextFontSize)
    theme.videoTheme.setVideoReleaseButtonTextFontStyle(this.videoReleaseButtonTextFontStyle)
    theme.videoTheme.setVideoReleaseButtonTextFontWeight(this.videoReleaseButtonTextFontWeight)
    theme.videoTheme.setVideoReleaseButtonTextFontFamily(this.videoReleaseButtonTextFontFamily)
    theme.videoTheme.setVideoReleaseButtonTextLineHeight(this.videoReleaseButtonTextLineHeight)
    theme.videoTheme.setVideoDownloadButtonVisible(this.videoDownloadButtonVisible)
    if (this.videoDownloadButtonBackgroundColor !== undefined) {
      theme.videoTheme.setVideoDownloadButtonBackgroundColor(this.videoDownloadButtonBackgroundColor)
    }
    theme.videoTheme.setVideoDownloadButtonWidth(this.videoDownloadButtonWidth)
    theme.videoTheme.setVideoDownloadButtonHeight(this.videoDownloadButtonHeight)
    theme.videoTheme.setVideoDownloadButtonRadius({topLeft: this.videoDownloadButtonRadiusTopLeft, topRight: this.videoDownloadButtonRadiusTopRight, bottomLeft: this.videoDownloadButtonRadiusBottomLeft, bottomRight: this.videoDownloadButtonRadiusBottomRight})
    theme.videoTheme.setVideoDownloadButtonIconTextGap(this.videoDownloadButtonIconTextGap)
    if (this.videoDownloadButtonIcon !== undefined) {
      theme.videoTheme.setVideoDownloadButtonIcon(this.videoDownloadButtonIcon)
    }
    theme.videoTheme.setVideoDownloadButtonIconWidth(this.videoDownloadButtonIconWidth)
    theme.videoTheme.setVideoDownloadButtonIconHeight(this.videoDownloadButtonIconHeight)
    theme.videoTheme.setVideoDownloadButtonText(this.videoDownloadButtonText)
    if (this.videoDownloadButtonTextFontColor !== undefined) {
      theme.videoTheme.setVideoDownloadButtonTextFontColor(this.videoDownloadButtonTextFontColor)
    }
    theme.videoTheme.setVideoDownloadButtonTextFontSize(this.videoDownloadButtonTextFontSize)
    theme.videoTheme.setVideoDownloadButtonTextFontStyle(this.videoDownloadButtonTextFontStyle)
    theme.videoTheme.setVideoDownloadButtonTextFontWeight(this.videoDownloadButtonTextFontWeight)
    theme.videoTheme.setVideoDownloadButtonTextFontFamily(this.videoDownloadButtonTextFontFamily)
    theme.videoTheme.setVideoDownloadButtonTextLineHeight(this.videoDownloadButtonTextLineHeight)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsBlockVideoPlugin(true) // 视频插件
    plugin.setIsImageCollectPlugin(true) // 图片视频url集合列表插件
    return plugin
  }

  videoCallback(url: string, urlList: Array<string>): void {
    hilog.error(1, "1", `---url:${url},urlList:${urlList}`)
  }

  videoImageCallback(url: string, cb: (imageUrl: string, aspectRatio: number, time: number) => void): void {
    hilog.error(1, "1", `---url:${url}`)
    cb("https://markdown.com.cn/images/philly-magic-garden.jpg", 16 / 9, 200)
  }

  videoReleaseCallback(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  videoDownloadCallback(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }
}
