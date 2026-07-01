import { titleComponent } from '../../component/BaseComponent'
import { router } from '@kit.ArkUI'
import {
  CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration,
  MarkdownPlugin,
  MarkdownTheme
} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../../utils/FileUtils'
import hilog from '@ohos.hilog'
import { DeprecatedData } from '../../model/DeprecatedData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct Deprecated1DetailsPage {
  scroller: Scroller = new Scroller()
  // markdownScroller: MarkdownScroller = new MarkdownScroller()
  @StorageProp('safeTop') safeTop: number = 0
  @StorageProp('currentColorMode')
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
  @State bannerImage: Resource | undefined = undefined
  @State isLineBreak: boolean = false
  @State underlineColor: number = 0xFF191919
  @State underlineStyle: TextDecorationStyle = TextDecorationStyle.SOLID
  @State isLinkStyle: boolean = false
  @State isListLinkStyle: boolean = false
  @State linkColor: number = 0xFF0000FF
  @State isLinkSize: boolean = true
  @State linkSize: number = 14
  @State linkLineHeight: number = 20
  @State linkBackGroupColor: number = 0x00000000
  @State isLinkUnderlined: boolean = true
  @State linkCircleImageBackGroupColor: number = 0x00000000
  @State linkCircleImageButtonBackGroupColor: number = 0xFF000000
  @State linkCircleImageTextSize: number = 14
  @State linkCircleImageTextColor: number = 0xFFFFFFFF
  @State linkCircleImageRadius: number = 20
  @State linkCircleImageMargin: number = 6
  @State linkRectImageBackGroupColor: number = 0x00000000
  @State linkRectImageButtonBackGroupColor: number = 0xFF000000
  @State linkRectImageTextSize: number = 14
  @State linkRectImageTextColor: number = 0xFFFFFFFF
  @State linkRectImageHeight: number = 20
  @State linkRectImagePadding: number = 6
  @State linkRectImageRadius: number = 6
  @State linkRectImageMargin: number = 6
  @State linkRectToolImageBackGroupColor: number = 0x00000000
  @State linkRectToolImageButtonBackGroupColor: number = 0xFFFFFFFF
  @State linkRectToolImageTextSize: number = 14
  @State linkRectToolImageHeight: number = 21
  @State linkRectToolImagePadding: number = 6
  @State linkRectToolImageBorderWidth: number = 1
  @State linkRectToolImageDividingLineWidth: number = 1
  @State linkRectToolImageMargin: number = 6
  @State linkRectToolImageLineLeftPadding: number = 3
  @State linkRectToolImageLineRightPadding: number = 3
  @State markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

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

      this.bannerImage = deprecatedData._bannerImage
      this.isLineBreak = deprecatedData._isLineBreak
      this.underlineColor = deprecatedData._underlineColor
      this.underlineStyle = deprecatedData._underlineStyle
      this.isLinkStyle = deprecatedData._isLinkStyle
      this.isListLinkStyle = deprecatedData._isListLinkStyle
      this.linkColor = deprecatedData._linkColor
      this.isLinkSize = deprecatedData._isLinkSize
      this.linkSize = deprecatedData._linkSize
      this.linkLineHeight = deprecatedData._linkLineHeight
      this.linkBackGroupColor = deprecatedData._linkBackGroupColor
      this.isLinkUnderlined = deprecatedData._isLinkUnderlined
      this.linkCircleImageBackGroupColor = deprecatedData._linkCircleImageBackGroupColor
      this.linkCircleImageButtonBackGroupColor = deprecatedData._linkCircleImageButtonBackGroupColor
      this.linkCircleImageTextSize = deprecatedData._linkCircleImageTextSize
      this.linkCircleImageTextColor = deprecatedData._linkCircleImageTextColor
      this.linkCircleImageRadius = deprecatedData._linkCircleImageRadius
      this.linkCircleImageMargin = deprecatedData._linkCircleImageMargin
      this.linkRectImageBackGroupColor = deprecatedData._linkRectImageBackGroupColor
      this.linkRectImageButtonBackGroupColor = deprecatedData._linkRectImageButtonBackGroupColor
      this.linkRectImageTextSize = deprecatedData._linkRectImageTextSize
      this.linkRectImageTextColor = deprecatedData._linkRectImageTextColor
      this.linkRectImageHeight = deprecatedData._linkRectImageHeight
      this.linkRectImagePadding = deprecatedData._linkRectImagePadding
      this.linkRectImageRadius = deprecatedData._linkRectImageRadius
      this.linkRectImageMargin = deprecatedData._linkRectImageMargin
      this.linkRectToolImageBackGroupColor = deprecatedData._linkRectToolImageBackGroupColor
      this.linkRectToolImageButtonBackGroupColor = deprecatedData._linkRectToolImageButtonBackGroupColor
      this.linkRectToolImageTextSize = deprecatedData._linkRectToolImageTextSize
      this.linkRectToolImageHeight = deprecatedData._linkRectToolImageHeight
      this.linkRectToolImagePadding = deprecatedData._linkRectToolImagePadding
      this.linkRectToolImageBorderWidth = deprecatedData._linkRectToolImageBorderWidth
      this.linkRectToolImageDividingLineWidth = deprecatedData._linkRectToolImageDividingLineWidth
      this.linkRectToolImageMargin = deprecatedData._linkRectToolImageMargin
      this.linkRectToolImageLineLeftPadding = deprecatedData._linkRectToolImageLineLeftPadding
      this.linkRectToolImageLineRightPadding = deprecatedData._linkRectToolImageLineRightPadding
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
      titleComponent("废弃接口用例1", 0xFF317AFF, true, this.safeTop)
      Scroll(this.scroller) {
        if (this.openGestureSwipeTest) {
          Column() {
            CJMarkdown({
              content: this.content, config: this.markdownConfiguration, plugin: this.markdownPlugin
            })
          }.height("100%")
        } else {
          Column() {
            CJMarkdown({ content: this.content, config: this.markdownConfiguration, plugin: this.markdownPlugin })
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
    globalTheme.setIsLineBreak(this.isLineBreak)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.setGlobalTheme(globalTheme)

    if (this.bannerImage !== undefined) {
      theme.setBannerImage(this.bannerImage)
    }

    theme.setUnderlineColor(this.underlineColor)
    theme.setUnderlineStyle(this.underlineStyle)

    theme.setIsLinkStyle(this.isLinkStyle)
    theme.setIsListLinkStyle(this.isListLinkStyle)
    theme.setLinkColor(this.linkColor)
    theme.setIsLinkSize(this.isLinkSize)
    theme.setLinkSize(this.linkSize)
    theme.setLinkLineHeight(this.linkLineHeight)
    theme.setLinkBackgroundColor(this.linkBackGroupColor)
    theme.setIsLinkUnderlined(this.isLinkUnderlined)
    theme.setLinkCircleImageBackgroundColor(this.linkCircleImageBackGroupColor)
    theme.setLinkCircleImageButtonBackgroundColor(this.linkCircleImageButtonBackGroupColor)
    theme.setLinkCircleImageTextSize(this.linkCircleImageTextSize)
    theme.setLinkCircleImageTextColor(this.linkCircleImageTextColor)
    theme.setLinkCircleImageRadius(this.linkCircleImageRadius)
    theme.setLinkCircleImageMargin(this.linkCircleImageMargin)
    theme.setLinkRectImageBackgroundColor(this.linkRectImageBackGroupColor)
    theme.setLinkRectImageButtonBackgroundColor(this.linkRectImageButtonBackGroupColor)
    theme.setLinkRectImageTextSize(this.linkRectImageTextSize)
    theme.setLinkRectImageTextColor(this.linkRectImageTextColor)
    theme.setLinkRectImageHeight(this.linkRectImageHeight)
    theme.setLinkRectImagePadding(this.linkRectImagePadding)
    theme.setLinkRectImageRadius(this.linkRectImageRadius)
    theme.setLinkRectImageMargin(this.linkRectImageMargin)
    theme.setLinkRectToolImageBackgroundColor(this.linkRectToolImageBackGroupColor)
    theme.setLinkRectToolImageButtonBackgroundColor(this.linkRectToolImageButtonBackGroupColor)
    theme.setLinkRectToolImageTextSize(this.linkRectToolImageTextSize)
    theme.setLinkRectToolImageHeight(this.linkRectToolImageHeight)
    theme.setLinkRectToolImagePadding(this.linkRectToolImagePadding)
    theme.setLinkRectToolImageBorderWidth(this.linkRectToolImageBorderWidth)
    theme.setLinkRectToolImageDividingLineWidth(this.linkRectToolImageDividingLineWidth)
    theme.setLinkRectToolImageMargin(this.linkRectToolImageMargin)
    theme.setLinkRectToolImageLineLeftPadding(this.linkRectToolImageLineLeftPadding)
    theme.setLinkRectToolImageLineRightPadding(this.linkRectToolImageLineRightPadding)

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
