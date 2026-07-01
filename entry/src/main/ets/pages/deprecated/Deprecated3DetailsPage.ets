import { titleComponent } from '../../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../../utils/FileUtils'
import hilog from '@ohos.hilog'
import { DeprecatedData } from '../../model/DeprecatedData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct Deprecated3DetailsPage {
  // ---------- 通用
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

  // ---------- 标题配置
  @State headingBreakHeight: number = 0.5
  @State headingTextSize1: number = 20
  @State headingTextSize2: number = 17
  @State headingTextSize3: number = 16
  @State headingTypeface: string = "HarmonyOS Sans"
  @State headingTopMargins: number = 8
  @State headingBottomMargins: number = 8
  @State headingTextSize4: number = 15
  @State headingTextSize5: number = 15
  @State headingTextSize6: number = 13
  @State headingTextWordSpace: number = 0
  @State headingTextLineHeight1: number = 22
  @State headingTextLineHeight2: number = 22
  @State headingTextLineHeight3: number = 22
  @State headingTextLineHeight4: number = 22
  @State headingTextLineHeight5: number = 22
  @State headingTextLineHeight6: number = 22
  @State headingTextColor1: number = 0xFF191919
  @State headingBreakColor1: number = 0xFF191919
  @State headingTextColor2: number = 0xFF191919
  @State headingBreakColor2: number = 0xFF191919
  @State headingTextColor3: number = 0xFF191919
  @State headingTextColor4: number = 0xFF191919
  @State headingTextColor5: number = 0xFF191919
  @State headingTextColor6: number = 0xFF191919

  // ---------- 段落配置
  @State paragraphTextSize: number = 14
  @State paragraphTextColor: number = 0xFF191919
  @State paragraphTypeface: string = "HarmonyOS Sans"
  @State paragraphTopMargins: number = 8
  @State paragraphBottomMargins: number = 8
  @State paragraphTextWordSpace: number = 0
  @State paragraphTextLineHeight: number = 22

  // ---------- 分割线配置
  @State thematicBreakColor: number = 0xFF191919
  @State thematicBreakHeight: number = 0.5
  @State thematicBreakTopMargin: number = 0
  @State thematicBreakBottomMargin: number = 0

  // ---------- 内联代码配置
  @State codeTextColor: number = 0xFF000000
  @State codeBackgroundColor: number = 0xFFEAEAEA
  @State codeTextSize: number = 13
  @State codeTypeface: string = "HarmonyOS Sans"

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
      
      this.headingBreakHeight = deprecatedData._headingBreakHeight
      this.headingTextSize1 = deprecatedData._headingTextSize1
      this.headingTextSize2 = deprecatedData._headingTextSize2
      this.headingTextSize3 = deprecatedData._headingTextSize3
      this.headingTypeface = deprecatedData._headingTypeface
      this.headingTopMargins = deprecatedData._headingTopMargins
      this.headingBottomMargins = deprecatedData._headingBottomMargins
      this.headingTextSize4 = deprecatedData._headingTextSize4
      this.headingTextSize5 = deprecatedData._headingTextSize5
      this.headingTextSize6 = deprecatedData._headingTextSize6
      this.headingTextWordSpace = deprecatedData._headingTextWordSpace
      this.headingTextLineHeight1 = deprecatedData._headingTextLineHeight1
      this.headingTextLineHeight2 = deprecatedData._headingTextLineHeight2
      this.headingTextLineHeight3 = deprecatedData._headingTextLineHeight3
      this.headingTextLineHeight4 = deprecatedData._headingTextLineHeight4
      this.headingTextLineHeight5 = deprecatedData._headingTextLineHeight5
      this.headingTextLineHeight6 = deprecatedData._headingTextLineHeight6
      this.headingTextColor1 = deprecatedData._headingTextColor1
      this.headingBreakColor1 = deprecatedData._headingBreakColor1
      this.headingTextColor2 = deprecatedData._headingTextColor2
      this.headingBreakColor2 = deprecatedData._headingBreakColor2
      this.headingTextColor3 = deprecatedData._headingTextColor3
      this.headingTextColor4 = deprecatedData._headingTextColor4
      this.headingTextColor5 = deprecatedData._headingTextColor5
      this.headingTextColor6 = deprecatedData._headingTextColor6
      
      this.paragraphTextSize = deprecatedData._paragraphTextSize
      this.paragraphTextColor = deprecatedData._paragraphTextColor
      this.paragraphTypeface = deprecatedData._paragraphTypeface
      this.paragraphTopMargins = deprecatedData._paragraphTopMargins
      this.paragraphBottomMargins = deprecatedData._paragraphBottomMargins
      this.paragraphTextWordSpace = deprecatedData._paragraphTextWordSpace
      this.paragraphTextLineHeight = deprecatedData._paragraphTextLineHeight
      
      this.thematicBreakColor = deprecatedData._thematicBreakColor
      this.thematicBreakHeight = deprecatedData._thematicBreakHeight
      this.thematicBreakTopMargin = deprecatedData._thematicBreakTopMargin
      this.thematicBreakBottomMargin = deprecatedData._thematicBreakBottomMargin
      
      this.codeTextColor = deprecatedData._codeTextColor
      this.codeBackgroundColor = deprecatedData._codeBackgroundColor
      this.codeTextSize = deprecatedData._codeTextSize
      this.codeTypeface = deprecatedData._codeTypeface
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
      titleComponent("废弃接口用例3", 0xFF317AFF, true, this.safeTop)
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
    let globalTheme: GlobalTheme = new GlobalTheme()
    globalTheme.setMargin({top: this.blockTopAndBottomMargins, bottom: this.blockTopAndBottomMargins})
    globalTheme.setMarkdownBlockSpacing(this.blockTopAndBottomMargins)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.setGlobalTheme(globalTheme)
    
    theme.setHeadingBreakHeight(this.headingBreakHeight)
    theme.setHeadingTextSize1(this.headingTextSize1)
    theme.setHeadingTextSize2(this.headingTextSize2)
    theme.setHeadingTextSize3(this.headingTextSize3)
    theme.setHeadingTypeface(this.headingTypeface)
    theme.setHeadingTopMargins(this.headingTopMargins)
    theme.setHeadingBottomMargins(this.headingBottomMargins)
    theme.setHeadingTextSize4(this.headingTextSize4)
    theme.setHeadingTextSize5(this.headingTextSize5)
    theme.setHeadingTextSize6(this.headingTextSize6)
    theme.setHeadingTextWordSpace(this.headingTextWordSpace)
    theme.setHeadingTextLineHeight1(this.headingTextLineHeight1)
    theme.setHeadingTextLineHeight2(this.headingTextLineHeight2)
    theme.setHeadingTextLineHeight3(this.headingTextLineHeight3)
    theme.setHeadingTextLineHeight4(this.headingTextLineHeight4)
    theme.setHeadingTextLineHeight5(this.headingTextLineHeight5)
    theme.setHeadingTextLineHeight6(this.headingTextLineHeight6)
    theme.setHeadingTextColor1(this.headingTextColor1)
    theme.setHeadingBreakColor1(this.headingBreakColor1)
    theme.setHeadingTextColor2(this.headingTextColor2)
    theme.setHeadingBreakColor2(this.headingBreakColor2)
    theme.setHeadingTextColor3(this.headingTextColor3)
    theme.setHeadingTextColor4(this.headingTextColor4)
    theme.setHeadingTextColor5(this.headingTextColor5)
    theme.setHeadingTextColor6(this.headingTextColor6)
    
    theme.setParagraphTextSize(this.paragraphTextSize)
    theme.setParagraphTextColor(this.paragraphTextColor)
    theme.setParagraphTypeface(this.paragraphTypeface)
    theme.setParagraphTopMargins(this.paragraphTopMargins)
    theme.setParagraphBottomMargins(this.paragraphBottomMargins)
    theme.setParagraphTextWordSpace(this.paragraphTextWordSpace)
    theme.setParagraphTextLineHeight(this.paragraphTextLineHeight)
    
    theme.setThematicBreakColor(this.thematicBreakColor)
    theme.setThematicBreakHeight(this.thematicBreakHeight)
    theme.setThematicBreakTopMargin(this.thematicBreakTopMargin)
    theme.setThematicBreakBottomMargin(this.thematicBreakBottomMargin)
    
    theme.setCodeTextColor(this.codeTextColor)
    theme.setCodeBackgroundColor(this.codeBackgroundColor)
    theme.setCodeTextSize(this.codeTextSize)
    theme.setCodeTypeface(this.codeTypeface)
    
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

  linkCallBack(url: string): void { hilog.error(1, "1", `---url:${url}`) }
  imageCallback(url: string, urlList: Array<string>): void { hilog.error(1, "1", `---url:${url},urlList:${urlList}`) }
  audioCallback(url: string): void { hilog.error(1, "1", `---url:${url}`) }
  videoCallback(url: string, urlList: Array<string>): void { hilog.error(1, "1", `---url:${url},urlList:${urlList}`) }
  videoImageCallback(url: string, cb: (imageUrl: string, aspectRatio: number, time: number) => void): void { hilog.error(1, "1", `---url:${url}`) }
  codeCopyCallback(code: string): void { hilog.error(1, "1", `---code:${code}`) }
  codeFullScreenCallback(code: string, type: string | undefined): void { hilog.error(1, "1", `---code:${code},type:${type}`) }
  latexCallBack(data: ArrayBuffer, heightNumber: number, widthNumber: number): void { hilog.error(1, "1", `---data.size:${data.byteLength},heightNumber:${heightNumber},widthNumber:${widthNumber}`) }
  tocIndexCallback(y: number | undefined): void {
    if(y !==undefined){
      // let rect = this.markdownScroller.getItemRect(y)
      // this.scroller.scrollTo({xOffset:0, yOffset: rect.getItemRectY()})
    }
  }
  footnoteCallback(y: number | undefined): void {
    if(y !==undefined){
      // let rect = this.markdownScroller.getItemRect(y)
      // this.scroller.scrollTo({xOffset:0, yOffset: rect.getItemRectY()})
    }
  }
}
