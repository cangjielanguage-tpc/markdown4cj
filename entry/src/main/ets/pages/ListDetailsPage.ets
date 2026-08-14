import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import {
  BulletListTheme,
  CJMarkdown,
  GlobalTheme,
  MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme,
  OrderedListTheme} from '@cangjie-tpc/markdown_arkui'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { ListData } from '../model/ListData'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct ListDetailsPage {
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
  blockMarginTop: number = 0
  @State // Markdown块右边距
  blockMarginRight: number = 0
  @State // Markdown块下边距
  blockMarginBottom: number = 0
  @State // Markdown块左边距
  blockMarginLeft: number = 0
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
  @State // 有序列表背景颜色
  orderedListBackgroundColor: ResourceColor | undefined = undefined
  @State // 有序列表上外边距
  orderedListMarginTop: Length = 8.0
  @State // 有序列表右外边距
  orderedListMarginRight: Length = 0.0
  @State // 有序列表下外边距
  orderedListMarginBottom: Length = 8.0
  @State // 有序列表左外边距
  orderedListMarginLeft: Length = 0.0
  @State // 有序列表上内边距
  orderedListPaddingTop: Length = 0.0
  @State // 有序列表右内边距
  orderedListPaddingRight: Length = 0.0
  @State // 有序列表下内边距
  orderedListPaddingBottom: Length = 0.0
  @State // 有序列表左内边距
  orderedListPaddingLeft: Length = 0.0
  @State // 有序列表子模块上下间距
  orderedListChildSpacing: number = 8.0
  @State // 有序列表子模块中子模块上下间距
  orderedListChildChildSpacing: number = 8.0
  @State // 有序列表列表编号和列表内容间距
  orderedListMarkerSpacing: number = 8.0
  @State // 有序列表列表编号文本颜色
  orderedListMarkerTextFontColor: ResourceColor | undefined = undefined
  @State // 有序列表列表编号文本尺寸
  orderedListMarkerTextFontSize: number | string | Resource | undefined = undefined
  @State // 有序列表列表编号文本字体样式
  orderedListMarkerTextFontStyle: FontStyle | undefined = undefined
  @State // 有序列表列表编号文本字体粗细
  orderedListMarkerTextFontWeight: number | FontWeight | undefined = undefined
  @State // 有序列表列表编号文本字体
  orderedListMarkerTextFontFamily: string | Resource | undefined = undefined
  @State // 有序列表列表编号文本行高
  orderedListMarkerTextLineHeight: number | string | Resource | undefined = undefined

  @State // 无序/任务背景颜色
  bulletListBackgroundColor: ResourceColor | undefined = undefined
  @State // 无序/任务上外边距
  bulletListMarginTop: Length = 8.0
  @State // 无序/任务右外边距
  bulletListMarginRight: Length = 0.0
  @State // 无序/任务下外边距
  bulletListMarginBottom: Length = 8.0
  @State // 无序/任务左外边距
  bulletListMarginLeft: Length = 0.0
  @State // 无序/任务上内边距
  bulletListPaddingTop: Length = 0.0
  @State // 无序/任务右内边距
  bulletListPaddingRight: Length = 0.0
  @State // 无序/任务下内边距
  bulletListPaddingBottom: Length = 0.0
  @State // 无序/任务左内边距
  bulletListPaddingLeft: Length = 0.0
  @State // 无序/任务子模块上下间距
  bulletListChildSpacing: number = 8.0
  @State // 无序/任务子模块中子模块上下间距
  bulletListChildChildSpacing: number = 8.0
  @State // 无序列表列表符号和列表内容间距
  bulletListBulletSpacing: number = 8.0
  @State // 无序列表列表符号是否全部是实心圆型
  bulletListBulletIsCircle: boolean = false
  @State // 无序列表列表符号文本颜色
  bulletListBulletTextFontColor: ResourceColor | undefined = undefined
  @State // 无序列表列表符号文本尺寸
  bulletListBulletTextFontSize: number | string | Resource | undefined = undefined
  @State // 无序列表列表符号文本字体样式
  bulletListBulletTextFontStyle: FontStyle | undefined = undefined
  @State // 无序列表列表符号文本字体粗细
  bulletListBulletTextFontWeight: number | FontWeight | undefined = undefined
  @State // 无序列表列表符号文本字体
  bulletListBulletTextFontFamily: string | Resource | undefined = undefined
  @State // 无序列表列表符号文本行高
  bulletListBulletTextLineHeight: number | string | Resource | undefined = undefined
  @State // 任务列表多选框和列表内容间距
  bulletListCheckboxSpacing: number = 8.0
  @State // 任务列表多选框宽度
  bulletListCheckboxWidth: Length = 15.0
  @State // 任务列表多选框高度
  bulletListCheckboxHeight: Length = 15.0
  @State // 任务列表多选框选中颜色
  bulletListCheckboxSelectedColor: ResourceColor | undefined = undefined
  @State // 任务列表多选框形状
  bulletListCheckboxShape: CheckBoxShape = CheckBoxShape.CIRCLE

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let listData: ListData = router.getParams() as ListData
      this.fileStr = getFileContextStr(listData._pagePath)
      // ---------- 通用
      this.isFull = listData._isFull
      this.incrementalAnalysis = listData._incrementalAnalysis
      this.enableParseThrottle = listData._enableParseThrottle
      this.parseThrottleMs = listData._parseThrottleMs
      this.time = listData._time
      this.textNumber = listData._textNumber
      this.isMarkdownParserSync = listData._isMarkdownParserSync
      this.isOnCopy = listData._isOnCopy
      this.blockMarginTop = listData._blockMarginTop
      this.blockMarginRight = listData._blockMarginRight
      this.blockMarginBottom = listData._blockMarginBottom
      this.blockMarginLeft = listData._blockMarginLeft
      this.markdownBlockSpacing = listData._markdownBlockSpacing
      this.isLineBreak = listData._isLineBreak
      this.globalBackgroundColor = listData._backgroundColor
      this.openGestureSwipe = listData._openGestureSwipe
      this.openGestureSwipeTest = listData._openGestureSwipeTest
      // ---------- 专有
      this.orderedListBackgroundColor = listData._orderedListBackgroundColor
      this.orderedListMarginTop = listData._orderedListMarginTop
      this.orderedListMarginRight = listData._orderedListMarginRight
      this.orderedListMarginBottom = listData._orderedListMarginBottom
      this.orderedListMarginLeft = listData._orderedListMarginLeft
      this.orderedListPaddingTop = listData._orderedListPaddingTop
      this.orderedListPaddingRight = listData._orderedListPaddingRight
      this.orderedListPaddingBottom = listData._orderedListPaddingBottom
      this.orderedListPaddingLeft = listData._orderedListPaddingLeft
      this.orderedListChildSpacing = listData._orderedListChildSpacing
      this.orderedListChildChildSpacing = listData._orderedListChildChildSpacing
      this.orderedListMarkerSpacing = listData._orderedListMarkerSpacing
      this.orderedListMarkerTextFontColor = listData._orderedListMarkerTextFontColor
      this.orderedListMarkerTextFontSize = listData._orderedListMarkerTextFontSize
      this.orderedListMarkerTextFontStyle = listData._orderedListMarkerTextFontStyle
      this.orderedListMarkerTextFontWeight = listData._orderedListMarkerTextFontWeight
      this.orderedListMarkerTextFontFamily = listData._orderedListMarkerTextFontFamily
      this.orderedListMarkerTextLineHeight = listData._orderedListMarkerTextLineHeight

      this.bulletListBackgroundColor = listData._bulletListBackgroundColor
      this.bulletListMarginTop = listData._bulletListMarginTop
      this.bulletListMarginRight = listData._bulletListMarginRight
      this.bulletListMarginBottom = listData._bulletListMarginBottom
      this.bulletListMarginLeft = listData._bulletListMarginLeft
      this.bulletListPaddingTop = listData._bulletListPaddingTop
      this.bulletListPaddingRight = listData._bulletListPaddingRight
      this.bulletListPaddingBottom = listData._bulletListPaddingBottom
      this.bulletListPaddingLeft = listData._bulletListPaddingLeft
      this.bulletListChildSpacing = listData._bulletListChildSpacing
      this.bulletListChildChildSpacing = listData._bulletListChildChildSpacing
      this.bulletListBulletSpacing = listData._bulletListBulletSpacing
      this.bulletListBulletIsCircle = listData._bulletListBulletIsCircle
      this.bulletListBulletTextFontColor = listData._bulletListBulletTextFontColor
      this.bulletListBulletTextFontSize = listData._bulletListBulletTextFontSize
      this.bulletListBulletTextFontStyle = listData._bulletListBulletTextFontStyle
      this.bulletListBulletTextFontWeight = listData._bulletListBulletTextFontWeight
      this.bulletListBulletTextFontFamily = listData._bulletListBulletTextFontFamily
      this.bulletListBulletTextLineHeight = listData._bulletListBulletTextLineHeight
      this.bulletListCheckboxSpacing = listData._bulletListCheckboxSpacing
      this.bulletListCheckboxWidth = listData._bulletListCheckboxWidth
      this.bulletListCheckboxHeight = listData._bulletListCheckboxHeight
      this.bulletListCheckboxSelectedColor = listData._bulletListCheckboxSelectedColor
      this.bulletListCheckboxShape = listData._bulletListCheckboxShape
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
        "有序、无序、任务列表测试用例",
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
    config.setImageCallback(this.imageCallback) // 图片点击回调
    config.setAudioCallback(this.audioCallback) // 音频点击回调
    config.setVideoCallback(this.videoCallback) // 视频点击回调
    config.setVideoImageCallback(this.videoImageCallback) // 视频占位图和宽高比和视频时长的回调
    config.setCodeCopyCallback(this.codeCopyCallback) // 代码复制点击回调
    config.setCodeFullScreenCallback(this.codeFullScreenCallback) // 代码全屏点击回调
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
    
    // ---------- 专有 - OrderedList
    let orderedListTheme = new OrderedListTheme()
    if (this.orderedListBackgroundColor !== undefined) {
      orderedListTheme.setOrderedListBackgroundColor(this.orderedListBackgroundColor)
    }
    orderedListTheme.setOrderedListMargin({top: this.orderedListMarginTop, right: this.orderedListMarginRight, bottom: this.orderedListMarginBottom, left: this.orderedListMarginLeft})
    orderedListTheme.setOrderedListPadding({top: this.orderedListPaddingTop, right: this.orderedListPaddingRight, bottom: this.orderedListPaddingBottom, left: this.orderedListPaddingLeft})
    orderedListTheme.setOrderedListChildSpacing(this.orderedListChildSpacing)
    orderedListTheme.setOrderedListChildChildSpacing(this.orderedListChildChildSpacing)
    orderedListTheme.setOrderedListMarkerSpacing(this.orderedListMarkerSpacing)
    if (this.orderedListMarkerTextFontColor !== undefined) {
      orderedListTheme.setOrderedListMarkerTextFontColor(this.orderedListMarkerTextFontColor)
    }
    if (this.orderedListMarkerTextFontSize !== undefined) {
      orderedListTheme.setOrderedListMarkerTextFontSize(this.orderedListMarkerTextFontSize)
    }
    if (this.orderedListMarkerTextFontStyle !== undefined) {
      orderedListTheme.setOrderedListMarkerTextFontStyle(this.orderedListMarkerTextFontStyle)
    }
    if (this.orderedListMarkerTextFontWeight !== undefined) {
      orderedListTheme.setOrderedListMarkerTextFontWeight(this.orderedListMarkerTextFontWeight)
    }
    if (this.orderedListMarkerTextFontFamily !== undefined) {
      orderedListTheme.setOrderedListMarkerTextFontFamily(this.orderedListMarkerTextFontFamily)
    }
    if (this.orderedListMarkerTextLineHeight !== undefined) {
      orderedListTheme.setOrderedListMarkerTextLineHeight(this.orderedListMarkerTextLineHeight)
    }
    theme.setOrderedListTheme(orderedListTheme)
    
    // ---------- 专有 - BulletList
    let bulletListTheme = new BulletListTheme()
    if (this.bulletListBackgroundColor !== undefined) {
      bulletListTheme.setBulletListBackgroundColor(this.bulletListBackgroundColor)
    }
    bulletListTheme.setBulletListMargin({top: this.bulletListMarginTop, right: this.bulletListMarginRight, bottom: this.bulletListMarginBottom, left: this.bulletListMarginLeft})
    bulletListTheme.setBulletListPadding({top: this.bulletListPaddingTop, right: this.bulletListPaddingRight, bottom: this.bulletListPaddingBottom, left: this.bulletListPaddingLeft})
    bulletListTheme.setBulletListChildSpacing(this.bulletListChildSpacing)
    bulletListTheme.setBulletListChildChildSpacing(this.bulletListChildChildSpacing)
    bulletListTheme.setBulletListBulletSpacing(this.bulletListBulletSpacing)
    bulletListTheme.setBulletListBulletIsCircle(this.bulletListBulletIsCircle)
    if (this.bulletListBulletTextFontColor !== undefined) {
      bulletListTheme.setBulletListBulletTextFontColor(this.bulletListBulletTextFontColor)
    }
    if (this.bulletListBulletTextFontSize !== undefined) {
      bulletListTheme.setBulletListBulletTextFontSize(this.bulletListBulletTextFontSize)
    }
    if (this.bulletListBulletTextFontStyle !== undefined) {
      bulletListTheme.setBulletListBulletTextFontStyle(this.bulletListBulletTextFontStyle)
    }
    if (this.bulletListBulletTextFontWeight !== undefined) {
      bulletListTheme.setBulletListBulletTextFontWeight(this.bulletListBulletTextFontWeight)
    }
    if (this.bulletListBulletTextFontFamily !== undefined) {
      bulletListTheme.setBulletListBulletTextFontFamily(this.bulletListBulletTextFontFamily)
    }
    if (this.bulletListBulletTextLineHeight !== undefined) {
      bulletListTheme.setBulletListBulletTextLineHeight(this.bulletListBulletTextLineHeight)
    }
    bulletListTheme.setBulletListCheckboxSpacing(this.bulletListCheckboxSpacing)
    bulletListTheme.setBulletListCheckboxWidth(this.bulletListCheckboxWidth)
    bulletListTheme.setBulletListCheckboxHeight(this.bulletListCheckboxHeight)
    if (this.bulletListCheckboxSelectedColor !== undefined) {
      bulletListTheme.setBulletListCheckboxSelectedColor(this.bulletListCheckboxSelectedColor)
    }
    bulletListTheme.setBulletListCheckboxShape(this.bulletListCheckboxShape)
    theme.setBulletListTheme(bulletListTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsLatexMathPlugin(true) // 数学公式插件
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsLinkifyPlugin(true) // 自动链接插件
    plugin.setIsBlockAudioPlugin(true) // 音频插件
    plugin.setIsBlockVideoPlugin(true) // 视频插件
    plugin.setIsImageCollectPlugin(true) // 图片视频列表url集合列表解析插件
    plugin.setIsImageTextMixPlugin(true) // 图文不混排插件
    plugin.setIsImageSlidePlugin(true) // 图片banner
    plugin.setIsCodeListPlugin(true) // 代码块列表
    plugin.setIsImageStylePlugin(true) // 图片样式
    plugin.setIsTocPlugin(true) // TOC插件
    plugin.setIsFootnotePlugin(true) // 脚注
    plugin.setIsHtmlPlugin(true) // Html插件
    plugin.setIsLinkViewPlugin(true) // 链接单独块解析插件
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
    hilog.error(1, "1", `---y:${y}`)
  }

  footnoteCallback(y: number | undefined): void {
    hilog.error(1, "1", `---y:${y}`)
  }
}
