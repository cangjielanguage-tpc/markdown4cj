import { titleComponent } from '../../component/BaseComponent'
import { router } from '@kit.ArkUI'
import {
  CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration,
  MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme
} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../../utils/FileUtils'
import hilog from '@ohos.hilog'
import { DeprecatedData } from '../../model/DeprecatedData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct Deprecated5DetailsPage {
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
  @State codeFullScreenIcon: Resource | undefined = undefined
  @State codeCopyIcon: Resource | undefined = undefined
  @State isCodeFormat: boolean = false
  @State useTab: boolean = false
  @State indentWidth: number = 4
  @State isDark: boolean = false
  @State isCodeBlockParserSync: boolean = false
  @State codeBlockTextColor: ResourceColor | undefined = undefined
  @State codeBlockTypeTextColor: ResourceColor | undefined = undefined
  @State codeBlockTypeTextStr: string = ""
  @State codeBlockTypeTextPadding: number = 0
  @State codeBlockIconTextHide: boolean = true
  @State codeBlockLineNumberHide: boolean = true
  @State codeBlockBackgroundColor: ResourceColor | undefined = undefined
  @State codeMultilineMargin: number = 8
  @State codeBlockTypeface: string = "HarmonyOS Sans"
  @State codeBlockTextSize: number = 13
  @State codeBlockLineHeight: number = 22
  @State codeBlockRadius: number = 8
  @State isCodeFullScreen: boolean = true
  @State iconWidthAndHeight: number = 24
  @State codeListTitleTextSize: number = 13
  @State codeListTitleSelectTextSize: number = 13
  @State codeListTitleSelectTextColor: number = 0xFFFF0000
  @State codeListTitleUnSelectTextColor: number = 0xFF000000
  @State codeListTitleSelectBackGroupColor: number = 0xFF808080
  @State codeListTitleUnSelectBackGroupColor: number = 0x00000000
  @State isSeparateCodeBlock: boolean = false
  @State separateCodeBlockWidth: number = 50
  @State separateCodeIsBottom: boolean = false
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

      this.codeFullScreenIcon = deprecatedData._codeFullScreenIcon
      this.codeCopyIcon = deprecatedData._codeCopyIcon

      this.isCodeFormat = deprecatedData._isCodeFormat
      this.useTab = deprecatedData._useTab
      this.indentWidth = deprecatedData._indentWidth
      this.isDark = deprecatedData._isDark
      this.isCodeBlockParserSync = deprecatedData._isCodeBlockParserSync
      this.codeBlockTextColor = deprecatedData._codeBlockTextColor
      this.codeBlockTypeTextColor = deprecatedData._codeBlockTypeTextColor
      this.codeBlockTypeTextStr = deprecatedData._codeBlockTypeTextStr
      this.codeBlockTypeTextPadding = deprecatedData._codeBlockTypeTextPadding
      this.codeBlockIconTextHide = deprecatedData._codeBlockIconTextHide
      this.codeBlockLineNumberHide = deprecatedData._codeBlockLineNumberHide
      this.codeBlockBackgroundColor = deprecatedData._codeBlockBackgroundColor
      this.codeMultilineMargin = deprecatedData._codeMultilineMargin
      this.codeBlockTypeface = deprecatedData._codeBlockTypeface
      this.codeBlockTextSize = deprecatedData._codeBlockTextSize
      this.codeBlockLineHeight = deprecatedData._codeBlockLineHeight
      this.codeBlockRadius = deprecatedData._codeBlockRadius
      this.isCodeFullScreen = deprecatedData._isCodeFullScreen
      this.iconWidthAndHeight = deprecatedData._iconWidthAndHeight
      this.codeListTitleTextSize = deprecatedData._codeListTitleTextSize
      this.codeListTitleSelectTextSize = deprecatedData._codeListTitleSelectTextSize
      this.codeListTitleSelectTextColor = deprecatedData._codeListTitleSelectTextColor
      this.codeListTitleUnSelectTextColor = deprecatedData._codeListTitleUnSelectTextColor
      this.codeListTitleSelectBackGroupColor = deprecatedData._codeListTitleSelectBackGroupColor
      this.codeListTitleUnSelectBackGroupColor = deprecatedData._codeListTitleUnSelectBackGroupColor
      this.isSeparateCodeBlock = deprecatedData._isSeparateCodeBlock
      this.separateCodeBlockWidth = deprecatedData._separateCodeBlockWidth
      this.separateCodeIsBottom = deprecatedData._separateCodeIsBottom
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
      titleComponent("废弃接口用例5", 0xFF317AFF, true, this.safeTop)
      Scroll(this.scroller) {
        if (this.openGestureSwipeTest) {
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
    globalTheme.setGlobalMargin({ top: this.blockTopAndBottomMargins, bottom: this.blockTopAndBottomMargins })
    globalTheme.setBlockSpacing(this.blockTopAndBottomMargins)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.setGlobalTheme(globalTheme)

    if (this.codeFullScreenIcon !== undefined) {
      theme.setCodeFullScreenIcon(this.codeFullScreenIcon)
    }
    if (this.codeCopyIcon !== undefined) {
      theme.setCodeCopyIcon(this.codeCopyIcon)
    }

    theme.setIsCodeFormat(this.isCodeFormat)
    theme.setUseTab(this.useTab)
    theme.setIndentWidth(this.indentWidth)
    // theme.setIsDark(this.isDark)
    theme.setIsCodeBlockParserSync(this.isCodeBlockParserSync)
    if (this.codeBlockTextColor !== undefined) {
      theme.setCodeBlockTextColor(this.codeBlockTextColor.valueOf() as number)
    }
    if (this.codeBlockTypeTextColor !== undefined) {
      theme.setCodeBlockTypeTextColor(this.codeBlockTypeTextColor.valueOf() as number)
    }
    theme.setCodeBlockTypeTextStr(this.codeBlockTypeTextStr)
    theme.setCodeBlockTypeTextPadding(this.codeBlockTypeTextPadding)
    theme.setCodeBlockIconTextHide(this.codeBlockIconTextHide)
    theme.setCodeBlockLineNumberHide(this.codeBlockLineNumberHide)
    if (this.codeBlockBackgroundColor !== undefined) {
      theme.setCodeBlockBackgroundColor(this.codeBlockBackgroundColor.valueOf() as number)
    }
    theme.setCodeMultilineMargin(this.codeMultilineMargin)
    theme.setCodeBlockTypeface(this.codeBlockTypeface)
    theme.setCodeBlockTextSize(this.codeBlockTextSize)
    theme.setCodeBlockLineHeight(this.codeBlockLineHeight)
    theme.setCodeBlockRadius(this.codeBlockRadius)
    theme.setIsCodeFullScreen(this.isCodeFullScreen)
    theme.setIconWidthAndHeight(this.iconWidthAndHeight)
    theme.setCodeListTitleTextSize(this.codeListTitleTextSize)
    theme.setCodeListTitleSelectTextSize(this.codeListTitleSelectTextSize)
    theme.setCodeListTitleSelectTextColor(this.codeListTitleSelectTextColor)
    theme.setCodeListTitleUnSelectTextColor(this.codeListTitleUnSelectTextColor)
    theme.setCodeListTitleSelectBackgroundColor(this.codeListTitleSelectBackGroupColor)
    theme.setCodeListTitleUnSelectBackgroundColor(this.codeListTitleUnSelectBackGroupColor)
    theme.setIsSeparateCodeBlock(this.isSeparateCodeBlock)
    theme.setSeparateCodeBlockWidth(this.separateCodeBlockWidth)
    theme.setSeparateCodeIsBottom(this.separateCodeIsBottom)

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
