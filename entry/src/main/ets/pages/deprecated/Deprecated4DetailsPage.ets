import { titleComponent } from '../../component/BaseComponent'
import { router } from '@kit.ArkUI'
import {
  CJMarkdown,
  MarkdownConfiguration,
  MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme,
  // ImageFitType,
  // LatexMathColorFormat,
  GlobalTheme
} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../../utils/FileUtils'
import hilog from '@ohos.hilog'
import { DeprecatedData } from '../../model/DeprecatedData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct Deprecated4DetailsPage {
  scroller: Scroller = new Scroller()
  // markdownScroller: MarkdownScroller = new MarkdownScroller()
  @StorageProp('safeTop') safeTop: number = 0
  @StorageProp('currentColorMode') @Watch('onColorModeChange')
  currentColorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
  @State fileStr: string = ""
  @State content: string = ""
  @State isFull: boolean = true
  @State incrementalAnalysis: boolean = false
  @State time: number = 50
  @State textNumber: number = 10
  @State isMarkdownParserSync: boolean = false
  @State isOnCopy: boolean = false
  @State blockFirstTopMargin: number = 8
  @State blockLastBottomMargin: number = 8
  @State blockTopAndBottomMargins: number = 8
  @State openGestureSwipe: boolean = false
  @State openGestureSwipeTest: boolean = false
  @State isInputEnded: boolean = false
  @State imageResource: Resource | undefined = undefined
  @State imageDownloadImage: Resource | undefined = undefined
  @State latexDefaultText: boolean = true
  @State latexMathTextSize: number = 16
  @State latexMathBackGroupColor: number = 0x00000000
  @State latexMathTextColor: number = 0xFF000000
  // @State latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
  @State latexMathBlockCenter: boolean = false
  @State latexMathResStr: string = "/data/storage/el1/bundle/entry/resources/resfile/res"
  @State imageFitType: ImageFit = ImageFit.Contain
  @State imageMaximumWidth: number = 1
  @State imageFixedRatioWidth: number | undefined = undefined
  @State imageMaxHeight: number | undefined = undefined
  @State imageMaxWidth: number | undefined = undefined
  @State imageBorderRadius: number = 0
  @State imageBorderWidth: number = 0
  @State imageBorderColor: number = 0xFF000000
  @State isAutoResize: boolean = true
  @State imageMarginTop: number = 10
  @State imageMarginBottom: number = 10
  @State isImageDownload: boolean = false
  @State isImageMixedLayout: boolean = true
  @State imageDownloadImageWidthHeight: number = 18
  @State imageDownloadWidth: number = 296
  @State imageDownloadHeight: number = 44
  @State imageDownloadRadius: number = 22
  @State imageDownloadText: string = "下载图片"
  @State imageDownloadTexSize: number = 16
  @State imageDownloadTexColor: number = 0xE6000000
  @State imageDownloadBackgroundColor: number = 0xFFF5F5F5
  @State markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State markdownPlugin: MarkdownPlugin = new MarkdownPlugin()
  @State isRefresh: boolean = true

  onColorModeChange(): void {
    if (this.currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      this.markdownTheme.setDefaultTheme()
    } else {
      this.markdownTheme.setDarculaTheme()
    }
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
    this.isRefresh = !this.isRefresh
  }

  aboutToAppear(): void {
    try {
      let deprecatedData: DeprecatedData = router.getParams() as DeprecatedData
      this.fileStr = getFileContextStr(deprecatedData._pagePath)
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

      this.imageResource = deprecatedData._imageResource
      this.imageDownloadImage = deprecatedData._imageDownloadImage

      this.latexDefaultText = deprecatedData._latexDefaultText
      this.latexMathTextSize = deprecatedData._latexMathTextSize
      this.latexMathBackGroupColor = deprecatedData._latexMathBackGroupColor
      this.latexMathTextColor = deprecatedData._latexMathTextColor
      // this.latexMathColorFormat = deprecatedData._latexMathColorFormat
      this.latexMathBlockCenter = deprecatedData._latexMathBlockCenter
      this.latexMathResStr = deprecatedData._latexMathResStr

      this.imageFitType = deprecatedData._imageFitType
      this.imageMaximumWidth = deprecatedData._imageMaximumWidth
      this.imageFixedRatioWidth = deprecatedData._imageFixedRatioWidth
      this.imageMaxHeight = deprecatedData._imageMaxHeight
      this.imageMaxWidth = deprecatedData._imageMaxWidth
      this.imageBorderRadius = deprecatedData._imageBorderRadius
      this.imageBorderWidth = deprecatedData._imageBorderWidth
      this.imageBorderColor = deprecatedData._imageBorderColor
      this.isAutoResize = deprecatedData._isAutoResize
      this.imageMarginTop = deprecatedData._imageMarginTop
      this.imageMarginBottom = deprecatedData._imageMarginBottom
      this.isImageDownload = deprecatedData._isImageDownload
      this.isImageMixedLayout = deprecatedData._isImageMixedLayout
      this.imageDownloadImageWidthHeight = deprecatedData._imageDownloadImageWidthHeight
      this.imageDownloadWidth = deprecatedData._imageDownloadWidth
      this.imageDownloadHeight = deprecatedData._imageDownloadHeight
      this.imageDownloadRadius = deprecatedData._imageDownloadRadius
      this.imageDownloadText = deprecatedData._imageDownloadText
      this.imageDownloadTexSize = deprecatedData._imageDownloadTexSize
      this.imageDownloadTexColor = deprecatedData._imageDownloadTexColor
      this.imageDownloadBackgroundColor = deprecatedData._imageDownloadBackgroundColor
    } catch (e) {
    }
    this.markdownPlugin = this.setPlugin()
    this.markdownTheme = this.setMarkdownTheme()
    this.markdownConfiguration = this.setMarkdownConfig()
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
  }

  build() {
    Column() {
      titleComponent("废弃接口用例4", 0xFF317AFF, true, this.safeTop)
      Button("点击加载markdown")
        .height(40)
        .width("80%")
        .type(ButtonType.Capsule)
        .margin({ top: 5, bottom: 5 })
        .fontColor(0xFFFFFFFF)
        .backgroundColor(0xFF317AFF)
        .align(Alignment.Center)
        .fontSize(16)
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
      }.align(Alignment.TopStart).layoutWeight(1)
    }.alignItems(HorizontalAlign.Center)
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
    let globalTheme: GlobalTheme = new GlobalTheme()
    globalTheme.setMargin({ top: this.blockTopAndBottomMargins, bottom: this.blockTopAndBottomMargins })
    globalTheme.setMarkdownBlockSpacing(this.blockTopAndBottomMargins)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.setGlobalTheme(globalTheme)

    if (this.imageResource !== undefined) {
      theme.setImageResource(this.imageResource)
    }
    if (this.imageDownloadImage !== undefined) {
      theme.setImageDownloadImage(this.imageDownloadImage)
    }

    // theme.setLatexDefaultText(this.latexDefaultText)
    // theme.setLatexMathTextSize(this.latexMathTextSize)
    // theme.setLatexMathBackgroundColor(this.latexMathBackGroupColor)
    // theme.setLatexMathTextColor(this.latexMathTextColor)
    // theme.setLatexMathColorFormat(this.latexMathColorFormat)
    // theme.setLatexMathBlockCenter(this.latexMathBlockCenter)
    // theme.setLatexMathResStr(this.latexMathResStr)

    theme.setImageFitType(this.imageFitType)
    theme.setImageMaximumWidth(this.imageMaximumWidth)
    if (this.imageFixedRatioWidth !== undefined) {
      theme.setImageFixedRatioWidth(this.imageFixedRatioWidth)
    }
    if (this.imageMaxHeight !== undefined) {
      theme.setImageMaxHeight(this.imageMaxHeight)
    }
    if (this.imageMaxWidth !== undefined) {
      theme.setImageMaxWidth(this.imageMaxWidth)
    }
    theme.setImageBorderRadius(this.imageBorderRadius)
    theme.setImageBorderWidth(this.imageBorderWidth)
    theme.setImageBorderColor(this.imageBorderColor)
    theme.setIsAutoResize(this.isAutoResize)
    theme.setImageMarginTop(this.imageMarginTop)
    theme.setImageMarginBottom(this.imageMarginBottom)
    theme.setIsImageDownload(this.isImageDownload)
    theme.setIsImageMixedLayout(this.isImageMixedLayout)
    theme.setImageDownloadImageWidthHeight(this.imageDownloadImageWidthHeight)
    theme.setImageDownloadWidth(this.imageDownloadWidth)
    theme.setImageDownloadHeight(this.imageDownloadHeight)
    theme.setImageDownloadRadius(this.imageDownloadRadius)
    theme.setImageDownloadText(this.imageDownloadText)
    theme.setImageDownloadTextSize(this.imageDownloadTexSize)
    theme.setImageDownloadTextColor(this.imageDownloadTexColor)
    theme.setImageDownloadBackgroundColor(this.imageDownloadBackgroundColor)

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
    if (y !== undefined) {
      // let rect = this.markdownScroller.getItemRect(y);
      // this.scroller.scrollTo({ xOffset: 0, yOffset: rect.getItemRectY() })
    }
  }

  footnoteCallback(y: number | undefined): void {
    if (y !== undefined) {
      // let rect = this.markdownScroller.getItemRect(y);
      // this.scroller.scrollTo({ xOffset: 0, yOffset: rect.getItemRectY() })
    }
  }
}
