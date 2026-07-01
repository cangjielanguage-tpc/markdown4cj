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
struct Deprecated6DetailsPage {
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
  @State tableCellPadding: number = 4
  @State tableBorderColor: number = 0xFF000000
  @State tableBorderWidth: number = 1
  @State tableOddRowBackgroundColor: number = 0xFFFFFFFF
  @State tableEvenRowBackgroundColor: number = 0xFFE0E0E0
  @State tableHeaderRowBackgroundColor: number = 0xFFFFFFFF
  @State tableTitleTextColor: number = 0xFF191919
  @State tableTitleTextSize: number = 14
  @State tableTitleLineHeight: number = 22
  @State tableContentTextColor: number = 0xFF191919
  @State tableContentTextSize: number = 14
  @State tableTextLineHeight: number = 22
  @State tableRadius: number = 5
  @State tableMinTextWidth: number = 50
  @State tableMaxTextWidth: number = 300
  @State tableFirstColumnBold: boolean = false
  @State tableScrollBarShow: boolean = false
  @State tableScrollBarColor: number = 0xFF191919
  @State blockOrderedAndBulletTopAndBottomMargins: number = 0
  @State blockLeftMargin: number = 8
  @State blockRightMargin: number = 8
  @State orderedListItemPrefixBold: boolean = false
  @State orderedListItemColor: number = 0xFF191919
  @State orderedListItemSize: number = 14
  @State orderedListItemLineHeight: number = 22
  @State bulletListItemCircle: boolean = false
  @State bulletListItemColor: number = 0xFF191919
  @State bulletListItemSize: number = 4
  @State bulletListItemLineHeight: number = 18
  @State taskListItemLength: number = 15
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

      this.tableCellPadding = deprecatedData._tableCellPadding
      this.tableBorderColor = deprecatedData._tableBorderColor
      this.tableBorderWidth = deprecatedData._tableBorderWidth
      this.tableOddRowBackgroundColor = deprecatedData._tableOddRowBackgroundColor
      this.tableEvenRowBackgroundColor = deprecatedData._tableEvenRowBackgroundColor
      this.tableHeaderRowBackgroundColor = deprecatedData._tableHeaderRowBackgroundColor
      this.tableTitleTextColor = deprecatedData._tableTitleTextColor
      this.tableTitleTextSize = deprecatedData._tableTitleTextSize
      this.tableTitleLineHeight = deprecatedData._tableTitleLineHeight
      this.tableContentTextColor = deprecatedData._tableContentTextColor
      this.tableContentTextSize = deprecatedData._tableContentTextSize
      this.tableTextLineHeight = deprecatedData._tableTextLineHeight
      this.tableRadius = deprecatedData._tableRadius
      this.tableMinTextWidth = deprecatedData._tableMinTextWidth
      this.tableMaxTextWidth = deprecatedData._tableMaxTextWidth
      this.tableFirstColumnBold = deprecatedData._tableFirstColumnBold
      this.tableScrollBarShow = deprecatedData._tableScrollBarShow
      this.tableScrollBarColor = deprecatedData._tableScrollBarColor

      this.blockOrderedAndBulletTopAndBottomMargins = deprecatedData._blockOrderedAndBulletTopAndBottomMargins
      this.blockLeftMargin = deprecatedData._blockLeftMargin
      this.blockRightMargin = deprecatedData._blockRightMargin
      this.orderedListItemPrefixBold = deprecatedData._orderedListItemPrefixBold
      this.orderedListItemColor = deprecatedData._orderedListItemColor
      this.orderedListItemSize = deprecatedData._orderedListItemSize
      this.orderedListItemLineHeight = deprecatedData._orderedListItemLineHeight
      this.bulletListItemCircle = deprecatedData._bulletListItemCircle
      this.bulletListItemColor = deprecatedData._bulletListItemColor
      this.bulletListItemSize = deprecatedData._bulletListItemSize
      this.bulletListItemLineHeight = deprecatedData._bulletListItemLineHeight
      this.taskListItemLength = deprecatedData._taskListItemLength
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
      titleComponent("废弃接口用例6", 0xFF317AFF, true, this.safeTop)
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
    globalTheme.setMargin({ top: this.blockTopAndBottomMargins, bottom: this.blockTopAndBottomMargins })
    globalTheme.setMarkdownBlockSpacing(this.blockTopAndBottomMargins)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.setGlobalTheme(globalTheme)

    theme.setTableCellPadding(this.tableCellPadding)
    theme.setTableBorderColor(this.tableBorderColor)
    theme.setTableBorderWidth(this.tableBorderWidth)
    theme.setTableOddRowBackgroundColor(this.tableOddRowBackgroundColor)
    theme.setTableEvenRowBackgroundColor(this.tableEvenRowBackgroundColor)
    theme.setTableHeaderRowBackgroundColor(this.tableHeaderRowBackgroundColor)
    theme.setTableTitleTextColor(this.tableTitleTextColor)
    theme.setTableTitleTextSize(this.tableTitleTextSize)
    theme.setTableTitleLineHeight(this.tableTitleLineHeight)
    theme.setTableContentTextColor(this.tableContentTextColor)
    theme.setTableContentTextSize(this.tableContentTextSize)
    theme.setTableTextLineHeight(this.tableTextLineHeight)
    theme.setTableRadius(this.tableRadius)
    theme.setTableMinTextWidth(this.tableMinTextWidth)
    theme.setTableMaxTextWidth(this.tableMaxTextWidth)
    theme.setTableFirstColumnBold(this.tableFirstColumnBold)
    theme.setTableScrollBarShow(this.tableScrollBarShow)
    theme.setTableScrollBarColor(this.tableScrollBarColor)

    theme.setBlockOrderedAndBulletTopAndBottomMargins(this.blockOrderedAndBulletTopAndBottomMargins)
    theme.setBlockLeftMargin(this.blockLeftMargin)
    theme.setBlockRightMargin(this.blockRightMargin)
    theme.setOrderedListItemPrefixBold(this.orderedListItemPrefixBold)
    theme.setOrderedListItemColor(this.orderedListItemColor)
    theme.setOrderedListItemSize(this.orderedListItemSize)
    theme.setOrderedListItemLineHeight(this.orderedListItemLineHeight)
    theme.setBulletListItemCircle(this.bulletListItemCircle)
    theme.setBulletListItemColor(this.bulletListItemColor)
    theme.setBulletListItemSize(this.bulletListItemSize)
    theme.setBulletListItemLineHeight(this.bulletListItemLineHeight)
    theme.setTaskListItemLength(this.taskListItemLength)

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
