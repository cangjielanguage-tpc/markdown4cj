import { titleComponent } from '../../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../../utils/FileUtils'
import hilog from '@ohos.hilog'
import { DeprecatedData } from '../../model/DeprecatedData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct Deprecated2DetailsPage {
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
  @State // Markdown文本第一个模块上边距
  blockFirstTopMargin: number = 8
  @State // Markdown文本最后一个模块下边距
  blockLastBottomMargin: number = 8
  @State // Markdown文本模块间上下间距
  blockTopAndBottomMargins: number = 8
  @State // 是否允许markdown控件自身响应滑动
  openGestureSwipe: boolean = false
  @State // 是否开启响应滑动测试
  openGestureSwipeTest: boolean = false
  @State // 流式输入是否输入结束(true:结束输入,false:持续输入)
  isInputEnded: boolean = false

  // ---------- 资源图标配置
  @State // 音频图片icon
  audioIcon: Resource | undefined = undefined
  @State // 视频默认占位图
  videoImage: Resource | undefined = undefined
  @State // 视频播放按钮icon
  playCircleFillIcon: Resource | undefined = undefined
  @State // 视频发布默认图标
  videoReleaseImage: Resource | undefined = undefined
  @State // 视频下载默认图标
  videoDownloadImage: Resource | undefined = undefined

  // ---------- 音频配置
  @State // 音频阴影颜色值
  audioShadowColor: number = 0x1A000000
  @State // 音频边框颜色
  audioBorderColor: number = 0x33000000
  @State // 音频边框粗细
  audioBorderWidth: number = 0.5
  @State // 音频边框圆角
  audioBorderRadius: number = 12
  @State // 音频按钮背景颜色
  audioButtonBackgroundColor: number = 0xFF000000
  @State // 音频按钮文字颜色
  audioButtonTextColor: number = 0xFFFFFFFF
  @State // 音频按钮文字大小
  audioButtonTextSize: number = 14
  @State // 音频按钮文字内容
  audioButtonText: string = "立即播放"
  @State // 音频按钮圆角
  audioButtonBorderRadius: number = 16
  @State // 音频标题文字大小
  audioTitleTextSize: number = 15
  @State // 音频标题文字颜色
  audioTitleTextColor: number = 0xFF000000
  @State // 音频标题文字行高
  audioTitleTextLineHeight: number = 20
  @State // 音频类型文字大小
  audioTypeTextSize: number = 11
  @State // 音频类型文字颜色
  audioTypeTextColor: number = 0x80000000
  @State // 音频类型文字行高
  audioTypeTextLineHeight: number = 15
  @State // 音频上边距
  audioMarginTop: number = 10
  @State // 音频下边距
  audioMarginBottom: number = 10

  // ---------- 视频配置
  @State // 视频圆角
  videoBorderRadius: number = 10
  @State // 视频时间文本颜色
  videoTimeTextColor: number = 0xFFFFFFFF
  @State // 视频时间文本大小
  videoTimeTextSize: number = 14
  @State // 视频时间文本居右边距
  videoTimeTextMarginRight: number = 10
  @State // 视频时间文本居底边距
  videoTimeTextMarginBottom: number = 10
  @State // 视频上边距
  videoMarginTop: number = 10
  @State // 视频下边距
  videoMarginBottom: number = 10
  @State // 视频发布/下载按钮布局是否显示
  isVideoBottomLayout: boolean = false
  @State // 视频发布按钮图片宽度和高度
  videoReleaseImageWidthHeight: number = 18
  @State // 视频发布按钮宽度
  videoReleaseWidth: number = 144
  @State // 视频发布按钮高度
  videoReleaseHeight: number = 44
  @State // 视频发布按钮圆角
  videoReleaseRadius: number = 22
  @State // 视频发布按钮文本内容
  videoReleaseText: string = "发布视频"
  @State // 视频发布按钮文本大小
  videoReleaseTexSize: number = 16
  @State // 视频发布按钮文本颜色
  videoReleaseTexColor: number = 0xE6000000
  @State // 视频发布按钮背景颜色
  videoReleaseBackgroundColor: number = 0xFFF5F5F5
  @State // 视频下载按钮图片宽度和高度
  videoDownloadImageWidthHeight: number = 18
  @State // 视频下载按钮宽度
  videoDownloadWidth: number = 144
  @State // 视频下载按钮高度
  videoDownloadHeight: number = 44
  @State // 视频下载按钮圆角
  videoDownloadRadius: number = 22
  @State // 视频下载按钮文本内容
  videoDownloadText: string = "下载视频"
  @State // 视频下载按钮文本大小
  videoDownloadTexSize: number = 16
  @State // 视频下载按钮文本颜色
  videoDownloadTexColor: number = 0xE6000000
  @State // 视频下载按钮背景颜色
  videoDownloadBackgroundColor: number = 0xFFF5F5F5

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
      let deprecatedData: DeprecatedData = router.getParams() as DeprecatedData
      this.fileStr = getFileContextStr(deprecatedData._pagePath)
      // ---------- 通用
      this.isFull = deprecatedData._isFull
      this.incrementalAnalysis = deprecatedData._incrementalAnalysis
      this.time = deprecatedData._time
      this.textNumber = deprecatedData._textNumber
      this.isMarkdownParserSync = deprecatedData._isMarkdownParserSync
      this.isOnCopy = deprecatedData._isOnCopy
      this.blockFirstTopMargin = deprecatedData._blockFirstTopMargin
      this.blockLastBottomMargin = deprecatedData._blockLastBottomMargin
      this.blockTopAndBottomMargins = deprecatedData._blockTopAndBottomMargins
      this.openGestureSwipe = deprecatedData._openGestureSwipe
      this.openGestureSwipeTest = deprecatedData._openGestureSwipeTest
      // ---------- 资源图标配置
      this.audioIcon = deprecatedData._audioIcon
      this.videoImage = deprecatedData._videoImage
      this.playCircleFillIcon = deprecatedData._playCircleFillIcon
      this.videoReleaseImage = deprecatedData._videoReleaseImage
      this.videoDownloadImage = deprecatedData._videoDownloadImage
      // ---------- 音频配置
      this.audioShadowColor = deprecatedData._audioShadowColor
      this.audioBorderColor = deprecatedData._audioBorderColor
      this.audioBorderWidth = deprecatedData._audioBorderWidth
      this.audioBorderRadius = deprecatedData._audioBorderRadius
      this.audioButtonBackgroundColor = deprecatedData._audioButtonBackgroundColor
      this.audioButtonTextColor = deprecatedData._audioButtonTextColor
      this.audioButtonTextSize = deprecatedData._audioButtonTextSize
      this.audioButtonText = deprecatedData._audioButtonText
      this.audioButtonBorderRadius = deprecatedData._audioButtonBorderRadius
      this.audioTitleTextSize = deprecatedData._audioTitleTextSize
      this.audioTitleTextColor = deprecatedData._audioTitleTextColor
      this.audioTitleTextLineHeight = deprecatedData._audioTitleTextLineHeight
      this.audioTypeTextSize = deprecatedData._audioTypeTextSize
      this.audioTypeTextColor = deprecatedData._audioTypeTextColor
      this.audioTypeTextLineHeight = deprecatedData._audioTypeTextLineHeight
      this.audioMarginTop = deprecatedData._audioMarginTop
      this.audioMarginBottom = deprecatedData._audioMarginBottom
      // ---------- 视频配置
      this.videoBorderRadius = deprecatedData._videoBorderRadius
      this.videoTimeTextColor = deprecatedData._videoTimeTextColor
      this.videoTimeTextSize = deprecatedData._videoTimeTextSize
      this.videoTimeTextMarginRight = deprecatedData._videoTimeTextMarginRight
      this.videoTimeTextMarginBottom = deprecatedData._videoTimeTextMarginBottom
      this.videoMarginTop = deprecatedData._videoMarginTop
      this.videoMarginBottom = deprecatedData._videoMarginBottom
      this.isVideoBottomLayout = deprecatedData._isVideoBottomLayout
      this.videoReleaseImageWidthHeight = deprecatedData._videoReleaseImageWidthHeight
      this.videoReleaseWidth = deprecatedData._videoReleaseWidth
      this.videoReleaseHeight = deprecatedData._videoReleaseHeight
      this.videoReleaseRadius = deprecatedData._videoReleaseRadius
      this.videoReleaseText = deprecatedData._videoReleaseText
      this.videoReleaseTexSize = deprecatedData._videoReleaseTexSize
      this.videoReleaseTexColor = deprecatedData._videoReleaseTexColor
      this.videoReleaseBackgroundColor = deprecatedData._videoReleaseBackgroundColor
      this.videoDownloadImageWidthHeight = deprecatedData._videoDownloadImageWidthHeight
      this.videoDownloadWidth = deprecatedData._videoDownloadWidth
      this.videoDownloadHeight = deprecatedData._videoDownloadHeight
      this.videoDownloadRadius = deprecatedData._videoDownloadRadius
      this.videoDownloadText = deprecatedData._videoDownloadText
      this.videoDownloadTexSize = deprecatedData._videoDownloadTexSize
      this.videoDownloadTexColor = deprecatedData._videoDownloadTexColor
      this.videoDownloadBackgroundColor = deprecatedData._videoDownloadBackgroundColor
    } catch (e) {
    }
    this.markdownPlugin = this.setPlugin()
    this.markdownTheme = this.setMarkdownTheme()
    this.markdownConfiguration = this.setMarkdownConfig()
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
  }

  build() {
    Column() {
      titleComponent("废弃接口用例2", 0xFF317AFF, true, this.safeTop)
      Button("点击加载markdown")
        .height(40).width("80%").type(ButtonType.Capsule)
        .margin({ top: 5, bottom: 5 })
        .fontColor(0xFFFFFFFF).backgroundColor(0xFF317AFF)
        .align(Alignment.Center).fontSize(16)
        .onClick(() => {
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
        })
      Scroll(this.scroller) {
        if (this.isRefresh) {
          if (this.openGestureSwipeTest) {
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
          if (this.openGestureSwipeTest) {
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
    config.setLinkCallback(this.linkCallBack.bind(this))
    config.setImageCallback(this.imageCallback.bind(this))
    config.setAudioCallback(this.audioCallback.bind(this))
    config.setVideoCallback(this.videoCallback.bind(this))
    config.setVideoImageCallback(this.videoImageCallback.bind(this))
    config.setCodeCopyCallback(this.codeCopyCallback.bind(this))
    config.setCodeFullScreenCallback(this.codeFullScreenCallback.bind(this))
    config.setLatexImageCallback(this.latexCallBack.bind(this))
    config.setTocIndexCallback(this.tocIndexCallback.bind(this))
    config.setFootnoteCallback(this.footnoteCallback.bind(this))
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
    globalTheme.setMargin({top: this.blockTopAndBottomMargins, bottom: this.blockTopAndBottomMargins})
    globalTheme.setMarkdownBlockSpacing(this.blockTopAndBottomMargins)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.setGlobalTheme(globalTheme)
    
    // ---------- 资源图标配置
    if (this.audioIcon !== undefined) {
      theme.setAudioIcon(this.audioIcon)
    }
    if (this.videoImage !== undefined) {
      theme.setVideoImage(this.videoImage)
    }
    if (this.playCircleFillIcon !== undefined) {
      theme.setPlayCircleFillIcon(this.playCircleFillIcon)
    }
    if (this.videoReleaseImage !== undefined) {
      theme.setVideoReleaseImage(this.videoReleaseImage)
    }
    if (this.videoDownloadImage !== undefined) {
      theme.setVideoDownloadImage(this.videoDownloadImage)
    }
    
    // ---------- 音频配置
    theme.setAudioShadowColor(this.audioShadowColor)
    theme.setAudioBorderColor(this.audioBorderColor)
    theme.setAudioBorderWidth(this.audioBorderWidth)
    theme.setAudioBorderRadius(this.audioBorderRadius)
    theme.setAudioButtonBackgroundColor(this.audioButtonBackgroundColor)
    theme.setAudioButtonTextColor(this.audioButtonTextColor)
    theme.setAudioButtonTextSize(this.audioButtonTextSize)
    theme.setAudioButtonText(this.audioButtonText)
    theme.setAudioButtonBorderRadius(this.audioButtonBorderRadius)
    theme.setAudioTitleTextSize(this.audioTitleTextSize)
    theme.setAudioTitleTextColor(this.audioTitleTextColor)
    theme.setAudioTitleTextLineHeight(this.audioTitleTextLineHeight)
    theme.setAudioTypeTextSize(this.audioTypeTextSize)
    theme.setAudioTypeTextColor(this.audioTypeTextColor)
    theme.setAudioTypeTextLineHeight(this.audioTypeTextLineHeight)
    theme.setAudioMarginTop(this.audioMarginTop)
    theme.setAudioMarginBottom(this.audioMarginBottom)
    
    // ---------- 视频配置
    theme.setVideoBorderRadius(this.videoBorderRadius)
    theme.setVideoTimeTextColor(this.videoTimeTextColor)
    theme.setVideoTimeTextSize(this.videoTimeTextSize)
    theme.setVideoTimeTextMarginRight(this.videoTimeTextMarginRight)
    theme.setVideoTimeTextMarginBottom(this.videoTimeTextMarginBottom)
    theme.setVideoMarginTop(this.videoMarginTop)
    theme.setVideoMarginBottom(this.videoMarginBottom)
    theme.setIsVideoBottomLayout(this.isVideoBottomLayout)
    theme.setVideoReleaseImageWidthHeight(this.videoReleaseImageWidthHeight)
    theme.setVideoReleaseWidth(this.videoReleaseWidth)
    theme.setVideoReleaseHeight(this.videoReleaseHeight)
    theme.setVideoReleaseRadius(this.videoReleaseRadius)
    theme.setVideoReleaseText(this.videoReleaseText)
    theme.setVideoReleaseTextSize(this.videoReleaseTexSize)
    theme.setVideoReleaseTextColor(this.videoReleaseTexColor)
    theme.setVideoReleaseBackgroundColor(this.videoReleaseBackgroundColor)
    theme.setVideoDownloadImageWidthHeight(this.videoDownloadImageWidthHeight)
    theme.setVideoDownloadWidth(this.videoDownloadWidth)
    theme.setVideoDownloadHeight(this.videoDownloadHeight)
    theme.setVideoDownloadRadius(this.videoDownloadRadius)
    theme.setVideoDownloadText(this.videoDownloadText)
    theme.setVideoDownloadTextSize(this.videoDownloadTexSize)
    theme.setVideoDownloadTextColor(this.videoDownloadTexColor)
    theme.setVideoDownloadBackgroundColor(this.videoDownloadBackgroundColor)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true)
    plugin.setIsLatexMathPlugin(true)
    plugin.setIsStrikethroughPlugin(true)
    plugin.setIsTaskListPlugin(true)
    plugin.setIsLinkifyPlugin(true)
    plugin.setIsBlockAudioPlugin(true)
    plugin.setIsBlockVideoPlugin(true)
    plugin.setIsImageCollectPlugin(true)
    plugin.setIsImageTextMixPlugin(true)
    plugin.setIsImageSlidePlugin(true)
    plugin.setIsCodeListPlugin(true)
    plugin.setIsImageStylePlugin(true)
    plugin.setIsTocPlugin(true)
    plugin.setIsFootnotePlugin(true)
    plugin.setIsHtmlPlugin(true)
    plugin.setIsLinkViewPlugin(true)
    return plugin
  }

  linkCallBack(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  imageCallback(url: string, urlList: Array<string>): void {
    hilog.error(1, "1", `---url:${url},urlList:${urlList}`)
  }

  audioCallback(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  videoCallback(url: string, urlList: Array<string>): void {
    hilog.error(1, "1", `---url:${url},urlList:${urlList}`)
  }

  videoImageCallback(url: string, cb: (imageUrl: string, aspectRatio: number, time: number) => void): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  codeCopyCallback(code: string): void {
    hilog.error(1, "1", `---code:${code}`)
  }

  codeFullScreenCallback(code: string, type: string | undefined): void {
    hilog.error(1, "1", `---code:${code},type:${type}`)
  }

  latexCallBack(data: ArrayBuffer, heightNumber: number, widthNumber: number): void {
    hilog.error(1, "1", `---data.size:${data.byteLength},heightNumber:${heightNumber},widthNumber:${widthNumber}`)
  }

  tocIndexCallback(y: number | undefined): void {
    if(y !==undefined){
      hilog.error(1, "1", `---y:${y}`)
      // let rect = this.markdownScroller.getItemRect(y)
      // this.scroller.scrollTo({xOffset:0, yOffset: rect.getItemRectY()})
    }
  }

  footnoteCallback(y: number | undefined): void {
    if(y !==undefined){
      hilog.error(1, "1", `---y:${y}`)
      // let rect = this.markdownScroller.getItemRect(y)
      // this.scroller.scrollTo({xOffset:0, yOffset: rect.getItemRectY()})
    }
  }
}
