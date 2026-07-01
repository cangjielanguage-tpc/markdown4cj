import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme,
  // ImageFitType,
  GlobalTheme,
  VideoTheme} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { VideoData } from '../model/VideoData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct VideoDetailsPage {
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
  @State // 视频背景颜色
  videoBackgroundColor: number | undefined = undefined
  @State // 视频上外边距
  videoMarginTop: number = 10
  @State // 视频右外边距
  videoMarginRight: number = 0
  @State // 视频下外边距
  videoMarginBottom: number = 10
  @State // 视频左外边距
  videoMarginLeft: number = 0
  @State // 视频上内边距
  videoPaddingTop: number = 0
  @State // 视频右内边距
  videoPaddingRight: number = 0
  @State // 视频下内边距
  videoPaddingBottom: number = 0
  @State // 视频左内边距
  videoPaddingLeft: number = 0
  @State // 视频边框左上圆角
  videoRadiusTopLeft: number = 10
  @State // 视频边框右上圆角
  videoRadiusTopRight: number = 10
  @State // 视频边框左下圆角
  videoRadiusBottomLeft: number = 10
  @State // 视频边框右下圆角
  videoRadiusBottomRight: number = 10
  @State // 视频边框样式
  videoBorderStyle: BorderStyle = BorderStyle.Solid
  @State // 视频边框宽度
  videoBorderWidth: number = 0
  @State // 视频边框颜色
  videoBorderColor: number | undefined = undefined
  videoPlaceholder: Resource | undefined = undefined // 视频占位图
  @State // 视频图片缩放类型
  videoImageFitType: ImageFit = ImageFit.Contain
  videoPlayIcon: Resource | undefined = undefined // 播放按钮默认图片
  @State // 播放按钮图标宽度
  videoPlayIconWidth: number = 40
  @State // 播放按钮图标高度
  videoPlayIconHeight: number = 60
  @State // 播放按钮图标缩放类型
  videoPlayIconFitType: ImageFit = ImageFit.Contain
  @State // 视频时间文本颜色
  videoTimeTextFontColor: number | undefined = undefined
  @State // 视频时间文本尺寸
  videoTimeTextFontSize: number = 14
  @State // 视频时间文本字体样式
  videoTimeTextFontStyle: FontStyle = FontStyle.Normal
  @State // 视频时间文本字体粗细
  videoTimeTextFontWeight: FontWeight = FontWeight.Normal
  @State // 视频时间文本字体
  videoTimeTextFontFamily: string = 'HarmonyOS Sans'
  @State // 视频时间文本行高
  videoTimeTextLineHeight: number = 22
  @State // 视频时间文本居右边距
  videoTimeTextMarginRight: number = 10
  @State // 视频时间文本居底边距
  videoTimeTextMarginBottom: number = 10
  @State // 底部布局是否显示（视频发布/下载按钮）
  videoBottomLayoutVisible: boolean = false
  @State // 底部布局距离视频上边距
  videoBottomLayoutMarginTop: number = 14
  @State // 视频发布按钮是否显示
  videoReleaseButtonVisible: boolean = true
  @State // 视频发布按钮背景颜色
  videoReleaseButtonBackgroundColor: number | undefined = undefined
  @State // 视频发布按钮宽度
  videoReleaseButtonWidth: number = 144
  @State // 视频发布按钮高度
  videoReleaseButtonHeight: number = 44
  @State // 视频发布按钮左上圆角
  videoReleaseButtonRadiusTopLeft: number = 22
  @State // 视频发布按钮右上圆角
  videoReleaseButtonRadiusTopRight: number = 22
  @State // 视频发布按钮左下圆角
  videoReleaseButtonRadiusBottomLeft: number = 22
  @State // 视频发布按钮右下圆角
  videoReleaseButtonRadiusBottomRight: number = 22
  @State // 视频发布按钮图标和文本间距
  videoReleaseButtonIconTextGap: number = 6
  videoReleaseButtonIcon: Resource | undefined = undefined // 视频发布按钮图标
  @State // 视频发布按钮图标宽度
  videoReleaseButtonIconWidth: number = 18
  @State // 视频发布按钮图标高度
  videoReleaseButtonIconHeight: number = 18
  @State // 视频发布按钮默认文本内容
  videoReleaseButtonText: string = "发布视频"
  @State // 视频发布按钮文本颜色
  videoReleaseButtonTextFontColor: number | undefined = undefined
  @State // 视频发布按钮文本尺寸
  videoReleaseButtonTextFontSize: number = 16
  @State // 视频发布按钮文本字体样式
  videoReleaseButtonTextFontStyle: FontStyle = FontStyle.Normal
  @State // 视频发布按钮文本字体粗细
  videoReleaseButtonTextFontWeight: FontWeight = FontWeight.Medium
  @State // 视频发布按钮文本字体
  videoReleaseButtonTextFontFamily: string = 'HarmonyOS Sans'
  @State // 视频发布按钮文本行高
  videoReleaseButtonTextLineHeight: number = 22
  @State // 视频下载按钮是否显示
  videoDownloadButtonVisible: boolean = true
  @State // 视频下载按钮背景颜色
  videoDownloadButtonBackgroundColor: number | undefined = undefined
  @State // 视频下载按钮宽度
  videoDownloadButtonWidth: number = 144
  @State // 视频下载按钮高度
  videoDownloadButtonHeight: number = 44
  @State // 视频下载按钮左上圆角
  videoDownloadButtonRadiusTopLeft: number = 22
  @State // 视频下载按钮右上圆角
  videoDownloadButtonRadiusTopRight: number = 22
  @State // 视频下载按钮左下圆角
  videoDownloadButtonRadiusBottomLeft: number = 22
  @State // 视频下载按钮右下圆角
  videoDownloadButtonRadiusBottomRight: number = 22
  @State // 视频下载按钮图标和文本间距
  videoDownloadButtonIconTextGap: number = 6
  videoDownloadButtonIcon: Resource | undefined = undefined // 视频下载按钮图标
  @State // 视频下载按钮图标宽度
  videoDownloadButtonIconWidth: number = 18
  @State // 视频下载按钮图标高度
  videoDownloadButtonIconHeight: number = 18
  @State // 视频下载按钮默认文本内容
  videoDownloadButtonText: string = "下载视频"
  @State // 视频下载按钮文本颜色
  videoDownloadButtonTextFontColor: number | undefined = undefined
  @State // 视频下载按钮文本尺寸
  videoDownloadButtonTextFontSize: number = 16
  @State // 视频下载按钮文本字体样式
  videoDownloadButtonTextFontStyle: FontStyle = FontStyle.Normal
  @State // 视频下载按钮文本字体粗细
  videoDownloadButtonTextFontWeight: FontWeight = FontWeight.Medium
  @State // 视频下载按钮文本字体
  videoDownloadButtonTextFontFamily: string = 'HarmonyOS Sans'
  @State // 视频下载按钮文本行高
  videoDownloadButtonTextLineHeight: number = 22

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
      let videoData: VideoData = router.getParams() as VideoData
      this.fileStr = getFileContextStr(videoData._pagePath)
      // ---------- 通用
      this.isFull = videoData._isFull
      this.incrementalAnalysis = videoData._incrementalAnalysis
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
  }

  build() {
    Column() {
      titleComponent(
        "视频测试用例",
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
    config.setVideoCallback(this.videoCallback) // 视频点击回调
    config.setVideoImageCallback(this.videoImageCallback) // 视频占位图和宽高比和视频时长的回调
    config.setVideoReleaseCallback(this.videoReleaseCallback) // 视频发布的点击事件
    config.setVideoDownloadCallback(this.videoDownloadCallback) // 视频下载的点击事件
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
    // globalTheme.setGlobalMargin({top: this.blockMarginTop, right: this.blockMarginRight, bottom: this.blockMarginBottom, left: this.blockMarginLeft})
    // globalTheme.setBlockSpacing(this.markdownBlockSpacing)
    globalTheme.setMargin({top: this.blockMarginTop, right: this.blockMarginRight, bottom: this.blockMarginBottom, left: this.blockMarginLeft})
    globalTheme.setMarkdownBlockSpacing(this.markdownBlockSpacing)
    globalTheme.setIsLineBreak(this.isLineBreak)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.setGlobalTheme(globalTheme)
    
    // ---------- 专有 - Video
    let videoTheme = new VideoTheme()
    if (this.videoBackgroundColor !== undefined) {
      videoTheme.setVideoBackgroundColor(this.videoBackgroundColor)
    }
    videoTheme.setVideoMargin({top: this.videoMarginTop, right: this.videoMarginRight, bottom: this.videoMarginBottom, left: this.videoMarginLeft})
    videoTheme.setVideoPadding({top: this.videoPaddingTop, right: this.videoPaddingRight, bottom: this.videoPaddingBottom, left: this.videoPaddingLeft})
    videoTheme.setVideoRadius({topLeft: this.videoRadiusTopLeft, topRight: this.videoRadiusTopRight, bottomLeft: this.videoRadiusBottomLeft, bottomRight: this.videoRadiusBottomRight})
    videoTheme.setVideoBorderStyle(this.videoBorderStyle)
    videoTheme.setVideoBorderWidth(this.videoBorderWidth)
    if (this.videoBorderColor !== undefined) {
      videoTheme.setVideoBorderColor(this.videoBorderColor)
    }
    if (this.videoPlaceholder !== undefined) {
      videoTheme.setVideoPlaceholder(this.videoPlaceholder)
    }
    if (this.videoImageFitType !== undefined) {
      videoTheme.setVideoImageFitType(this.videoImageFitType)
    }
    if (this.videoPlayIcon !== undefined) {
      videoTheme.setVideoPlayIcon(this.videoPlayIcon)
    }
    videoTheme.setVideoPlayIconWidth(this.videoPlayIconWidth)
    videoTheme.setVideoPlayIconHeight(this.videoPlayIconHeight)
    if (this.videoPlayIconFitType !== undefined) {
      videoTheme.setVideoPlayIconFitType(this.videoPlayIconFitType)
    }
    if (this.videoTimeTextFontColor !== undefined) {
      videoTheme.setVideoTimeTextFontColor(this.videoTimeTextFontColor)
    }
    videoTheme.setVideoTimeTextFontSize(this.videoTimeTextFontSize)
    videoTheme.setVideoTimeTextFontStyle(this.videoTimeTextFontStyle)
    videoTheme.setVideoTimeTextFontWeight(this.videoTimeTextFontWeight)
    videoTheme.setVideoTimeTextFontFamily(this.videoTimeTextFontFamily)
    videoTheme.setVideoTimeTextLineHeight(this.videoTimeTextLineHeight)
    videoTheme.setVideoTimeTextMarginRight(this.videoTimeTextMarginRight)
    videoTheme.setVideoTimeTextMarginBottom(this.videoTimeTextMarginBottom)
    videoTheme.setVideoBottomLayoutVisible(this.videoBottomLayoutVisible)
    videoTheme.setVideoBottomLayoutMarginTop(this.videoBottomLayoutMarginTop)
    videoTheme.setVideoReleaseButtonVisible(this.videoReleaseButtonVisible)
    if (this.videoReleaseButtonBackgroundColor !== undefined) {
      videoTheme.setVideoReleaseButtonBackgroundColor(this.videoReleaseButtonBackgroundColor)
    }
    videoTheme.setVideoReleaseButtonWidth(this.videoReleaseButtonWidth)
    videoTheme.setVideoReleaseButtonHeight(this.videoReleaseButtonHeight)
    videoTheme.setVideoReleaseButtonRadius({topLeft: this.videoReleaseButtonRadiusTopLeft, topRight: this.videoReleaseButtonRadiusTopRight, bottomLeft: this.videoReleaseButtonRadiusBottomLeft, bottomRight: this.videoReleaseButtonRadiusBottomRight})
    videoTheme.setVideoReleaseButtonIconTextGap(this.videoReleaseButtonIconTextGap)
    if (this.videoReleaseButtonIcon !== undefined) {
      videoTheme.setVideoReleaseButtonIcon(this.videoReleaseButtonIcon)
    }
    videoTheme.setVideoReleaseButtonIconWidth(this.videoReleaseButtonIconWidth)
    videoTheme.setVideoReleaseButtonIconHeight(this.videoReleaseButtonIconHeight)
    videoTheme.setVideoReleaseButtonText(this.videoReleaseButtonText)
    if (this.videoReleaseButtonTextFontColor !== undefined) {
      videoTheme.setVideoReleaseButtonTextFontColor(this.videoReleaseButtonTextFontColor)
    }
    videoTheme.setVideoReleaseButtonTextFontSize(this.videoReleaseButtonTextFontSize)
    videoTheme.setVideoReleaseButtonTextFontStyle(this.videoReleaseButtonTextFontStyle)
    videoTheme.setVideoReleaseButtonTextFontWeight(this.videoReleaseButtonTextFontWeight)
    videoTheme.setVideoReleaseButtonTextFontFamily(this.videoReleaseButtonTextFontFamily)
    videoTheme.setVideoReleaseButtonTextLineHeight(this.videoReleaseButtonTextLineHeight)
    videoTheme.setVideoDownloadButtonVisible(this.videoDownloadButtonVisible)
    if (this.videoDownloadButtonBackgroundColor !== undefined) {
      videoTheme.setVideoDownloadButtonBackgroundColor(this.videoDownloadButtonBackgroundColor)
    }
    videoTheme.setVideoDownloadButtonWidth(this.videoDownloadButtonWidth)
    videoTheme.setVideoDownloadButtonHeight(this.videoDownloadButtonHeight)
    videoTheme.setVideoDownloadButtonRadius({topLeft: this.videoDownloadButtonRadiusTopLeft, topRight: this.videoDownloadButtonRadiusTopRight, bottomLeft: this.videoDownloadButtonRadiusBottomLeft, bottomRight: this.videoDownloadButtonRadiusBottomRight})
    videoTheme.setVideoDownloadButtonIconTextGap(this.videoDownloadButtonIconTextGap)
    if (this.videoDownloadButtonIcon !== undefined) {
      videoTheme.setVideoDownloadButtonIcon(this.videoDownloadButtonIcon)
    }
    videoTheme.setVideoDownloadButtonIconWidth(this.videoDownloadButtonIconWidth)
    videoTheme.setVideoDownloadButtonIconHeight(this.videoDownloadButtonIconHeight)
    videoTheme.setVideoDownloadButtonText(this.videoDownloadButtonText)
    if (this.videoDownloadButtonTextFontColor !== undefined) {
      videoTheme.setVideoDownloadButtonTextFontColor(this.videoDownloadButtonTextFontColor)
    }
    videoTheme.setVideoDownloadButtonTextFontSize(this.videoDownloadButtonTextFontSize)
    videoTheme.setVideoDownloadButtonTextFontStyle(this.videoDownloadButtonTextFontStyle)
    videoTheme.setVideoDownloadButtonTextFontWeight(this.videoDownloadButtonTextFontWeight)
    videoTheme.setVideoDownloadButtonTextFontFamily(this.videoDownloadButtonTextFontFamily)
    videoTheme.setVideoDownloadButtonTextLineHeight(this.videoDownloadButtonTextLineHeight)
    theme.setVideoTheme(videoTheme)
    
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
