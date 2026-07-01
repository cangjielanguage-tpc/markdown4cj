import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  // MarkdownScroller,
  MarkdownTheme,
  // ImageFitType,
  GlobalTheme,
  ImageTheme} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextArr, getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { ImageDataMD } from '../model/ImageDataMD'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct ImageDetailsPage {
  // ---------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // Markdown的控制器
  // markdownScroller: MarkdownScroller = new MarkdownScroller()
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
  globalBackgroundColor: ResourceColor | undefined = undefined
  @State // 是否允许markdown控件自身响应滑动
  openGestureSwipe: boolean = false
  @State // 是否开启响应滑动测试
  openGestureSwipeTest: boolean = false
  @State // 流式输入是否输入结束(true:结束输入,false:持续输入)
  isInputEnded: boolean = false

  // ---------- 专有
  // @State // 图片是否替换
  // imageReplace: boolean = true
  @State // 网络图片是否压缩
  imageAutoResize: boolean = true
  @State // 图片默认占位图
  imagePlaceholder: Resource | undefined = undefined
  @State // 是否图文混排
  isImageMixedLayout: boolean = true
  @State // 图片上外边距
  imageMarginTop: Length = 10.0
  @State // 图片右外边距
  imageMarginRight: Length = 0.0
  @State // 图片下外边距
  imageMarginBottom: Length = 10.0
  @State // 图片左外边距
  imageMarginLeft: Length = 0.0
  @State // 图片边框左上圆角
  imageRadiusTopLeft: Length = 0.0
  @State // 图片边框右上圆角
  imageRadiusTopRight: Length = 0.0
  @State // 图片边框左下圆角
  imageRadiusBottomLeft: Length = 0.0
  @State // 图片边框右下圆角
  imageRadiusBottomRight: Length = 0.0
  @State // 图片边框样式
  imageBorderStyle: BorderStyle = BorderStyle.Solid
  @State // 图片边框宽度
  imageBorderWidth: Length = 0.0
  @State // 图片边框颜色
  imageBorderColor: ResourceColor | undefined = undefined
  @State // 图片基于自身宽度缩放百分比
  imageMaximumWidth: number = 1.0
  @State // 图片基于父布局宽度缩放百分比
  imageFixedRatioWidth: number | undefined = undefined
  @State // 图片最大高度
  imageMaxHeight: number | undefined = undefined
  @State // 图片高度
  imageHeight: number | undefined = undefined
  @State // 图片最大宽度
  imageMaxWidth: number | undefined = undefined
  @State // 图片宽度
  imageWidth: number | undefined = undefined
  @State // 图片缩放类型
  imageFitType: ImageFit = ImageFit.Contain
  @State // 底部布局距离图片上边距
  imageBottomLayoutMarginTop: Length = 14.0
  @State // 图片下载按钮是否显示
  imageDownloadButtonVisible: boolean = true
  @State // 图片下载按钮宽度
  imageDownloadButtonWidth: Length = 144.0
  @State // 图片下载按钮高度
  imageDownloadButtonHeight: Length = 44.0
  @State // 图片下载按钮左上圆角
  imageDownloadButtonRadiusTopLeft: Length = 22.0
  @State // 图片下载按钮右上圆角
  imageDownloadButtonRadiusTopRight: Length = 22.0
  @State // 图片下载按钮左下圆角
  imageDownloadButtonRadiusBottomLeft: Length = 22.0
  @State // 图片下载按钮右下圆角
  imageDownloadButtonRadiusBottomRight: Length = 22.0
  @State // 图片下载按钮图标
  imageDownloadButtonIcon: Resource | undefined = undefined
  @State // 图片下载按钮图标宽度
  imageDownloadButtonIconWidth: Length = 18.0
  @State // 图片下载按钮图标高度
  imageDownloadButtonIconHeight: Length = 18.0
  @State // 图片下载按钮图标和文本间距
  imageDownloadButtonIconTextGap: number = 6.0
  @State // 图片下载按钮背景颜色
  imageDownloadButtonBackgroundColor: ResourceColor | undefined = undefined
  @State // 图片下载按钮默认文本内容
  imageDownloadButtonText: string = "下载图片"
  @State // 图片下载按钮文本颜色
  imageDownloadButtonTextFontColor: ResourceColor | undefined = undefined
  @State // 图片下载按钮文本尺寸
  imageDownloadButtonTextFontSize: number | string | Resource = 16.0
  @State // 图片下载按钮文本字体样式
  imageDownloadButtonTextFontStyle: FontStyle = FontStyle.Normal
  @State // 图片下载按钮文本字体粗细
  imageDownloadButtonTextFontWeight: number | FontWeight = FontWeight.Medium
  @State // 图片下载按钮文本字体
  imageDownloadButtonTextFontFamily: string | Resource = 'HarmonyOS Sans'
  @State // 图片下载按钮文本行高
  imageDownloadButtonTextLineHeight: number | string | Resource = 22.0

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  aboutToAppear(): void {
    try {
      let imageDataMD: ImageDataMD = router.getParams() as ImageDataMD
      this.fileStr = getFileContextStr(imageDataMD._pagePath)
      // ---------- 通用
      this.isFull = imageDataMD._isFull
      this.incrementalAnalysis = imageDataMD._incrementalAnalysis
      this.time = imageDataMD._time
      this.textNumber = imageDataMD._textNumber
      this.isMarkdownParserSync = imageDataMD._isMarkdownParserSync
      this.isOnCopy = imageDataMD._isOnCopy
      this.blockMarginTop = imageDataMD._blockMarginTop
      this.blockMarginRight = imageDataMD._blockMarginRight
      this.blockMarginBottom = imageDataMD._blockMarginBottom
      this.blockMarginLeft = imageDataMD._blockMarginLeft
      this.markdownBlockSpacing = imageDataMD._markdownBlockSpacing
      this.isLineBreak = imageDataMD._isLineBreak
      this.globalBackgroundColor = imageDataMD._backgroundColor
      this.openGestureSwipe = imageDataMD._openGestureSwipe
      this.openGestureSwipeTest = imageDataMD._openGestureSwipeTest
      // ---------- 专有
      // this.imageReplace = imageDataMD._imageReplace
      this.imageAutoResize = imageDataMD._imageAutoResize
      this.imagePlaceholder = imageDataMD._imagePlaceholder
      this.isImageMixedLayout = imageDataMD._isImageMixedLayout
      this.imageMarginTop = imageDataMD._imageMarginTop
      this.imageMarginRight = imageDataMD._imageMarginRight
      this.imageMarginBottom = imageDataMD._imageMarginBottom
      this.imageMarginLeft = imageDataMD._imageMarginLeft
      this.imageRadiusTopLeft = imageDataMD._imageRadiusTopLeft
      this.imageRadiusTopRight = imageDataMD._imageRadiusTopRight
      this.imageRadiusBottomLeft = imageDataMD._imageRadiusBottomLeft
      this.imageRadiusBottomRight = imageDataMD._imageRadiusBottomRight
      this.imageBorderStyle = imageDataMD._imageBorderStyle
      this.imageBorderWidth = imageDataMD._imageBorderWidth
      this.imageBorderColor = imageDataMD._imageBorderColor
      this.imageMaximumWidth = imageDataMD._imageMaximumWidth
      this.imageFixedRatioWidth = imageDataMD._imageFixedRatioWidth
      this.imageMaxHeight = imageDataMD._imageMaxHeight
      this.imageHeight = imageDataMD._imageHeight
      this.imageMaxWidth = imageDataMD._imageMaxWidth
      this.imageWidth = imageDataMD._imageWidth
      this.imageFitType = imageDataMD._imageFitType
      this.imageBottomLayoutMarginTop = imageDataMD._imageBottomLayoutMarginTop
      this.imageDownloadButtonVisible = imageDataMD._imageDownloadButtonVisible
      this.imageDownloadButtonWidth = imageDataMD._imageDownloadButtonWidth
      this.imageDownloadButtonHeight = imageDataMD._imageDownloadButtonHeight
      this.imageDownloadButtonRadiusTopLeft = imageDataMD._imageDownloadButtonRadiusTopLeft
      this.imageDownloadButtonRadiusTopRight = imageDataMD._imageDownloadButtonRadiusTopRight
      this.imageDownloadButtonRadiusBottomLeft = imageDataMD._imageDownloadButtonRadiusBottomLeft
      this.imageDownloadButtonRadiusBottomRight = imageDataMD._imageDownloadButtonRadiusBottomRight
      this.imageDownloadButtonIcon = imageDataMD._imageDownloadButtonIcon
      this.imageDownloadButtonIconWidth = imageDataMD._imageDownloadButtonIconWidth
      this.imageDownloadButtonIconHeight = imageDataMD._imageDownloadButtonIconHeight
      this.imageDownloadButtonIconTextGap = imageDataMD._imageDownloadButtonIconTextGap
      this.imageDownloadButtonBackgroundColor = imageDataMD._imageDownloadButtonBackgroundColor
      this.imageDownloadButtonText = imageDataMD._imageDownloadButtonText
      this.imageDownloadButtonTextFontColor = imageDataMD._imageDownloadButtonTextFontColor
      this.imageDownloadButtonTextFontSize = imageDataMD._imageDownloadButtonTextFontSize
      this.imageDownloadButtonTextFontStyle = imageDataMD._imageDownloadButtonTextFontStyle
      this.imageDownloadButtonTextFontWeight = imageDataMD._imageDownloadButtonTextFontWeight
      this.imageDownloadButtonTextFontFamily = imageDataMD._imageDownloadButtonTextFontFamily
      this.imageDownloadButtonTextLineHeight = imageDataMD._imageDownloadButtonTextLineHeight
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
        "图片测试用例",
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
    config.setImageCallback(this.setImageCallback) // 图片点击回调
    // if (this.imageReplace) {
    //   config.setImageCallbackCallback(this.setImageReplaceCallback) // 图片替换事件
    // }
    config.setImageDownloadCallback(this.setImageDownloadCallback) // 图片下载的点击事件
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
    const hostContext = this.getUIContext().getHostContext()
    if (hostContext != undefined) {
      globalTheme.setStageContext(hostContext)
    }
    globalTheme.setMargin({top: this.blockMarginTop, right: this.blockMarginRight, bottom: this.blockMarginBottom, left: this.blockMarginLeft})
    globalTheme.setMarkdownBlockSpacing(this.markdownBlockSpacing)
    globalTheme.setIsLineBreak(this.isLineBreak)
    globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
    globalTheme.setIsOnCopy(this.isOnCopy)
    globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
    theme.setGlobalTheme(globalTheme)
    
    // ---------- 专有 - Image
    let imageTheme: ImageTheme = new ImageTheme()
    if (this.imagePlaceholder !== undefined) {
      imageTheme.setImagePlaceholder(this.imagePlaceholder)
    }
    imageTheme.setImageAutoResize(this.imageAutoResize)
    imageTheme.setIsImageMixedLayout(this.isImageMixedLayout)
    imageTheme.setMargin({top: this.imageMarginTop, right: this.imageMarginRight, bottom: this.imageMarginBottom, left: this.imageMarginLeft})
    imageTheme.setImageBorderRadius({topLeft: this.imageRadiusTopLeft, topRight: this.imageRadiusTopRight, bottomLeft: this.imageRadiusBottomLeft, bottomRight: this.imageRadiusBottomRight})
    imageTheme.setImageBorderStyle(this.imageBorderStyle)
    imageTheme.setImageBorderWidth(this.imageBorderWidth)
    if (this.imageBorderColor !== undefined) {
      imageTheme.setImageBorderColor(this.imageBorderColor)
    }
    imageTheme.setImageMaximumWidth(this.imageMaximumWidth)
    if (this.imageFixedRatioWidth !== undefined) {
      imageTheme.setImageFixedRatioWidth(this.imageFixedRatioWidth)
    }
    if (this.imageMaxHeight !== undefined) {
      imageTheme.setImageMaxHeight(this.imageMaxHeight)
    }
    if (this.imageHeight !== undefined) {
      imageTheme.setImageHeight(this.imageHeight)
    }
    if (this.imageMaxWidth !== undefined) {
      imageTheme.setImageMaxWidth(this.imageMaxWidth)
    }
    if (this.imageWidth !== undefined) {
      imageTheme.setImageWidth(this.imageWidth)
    }
    imageTheme.setImageFitType(this.imageFitType)
    imageTheme.setImageBottomLayoutMarginTop(this.imageBottomLayoutMarginTop)
    imageTheme.setImageDownloadButtonVisible(this.imageDownloadButtonVisible)
    imageTheme.setImageDownloadButtonWidth(this.imageDownloadButtonWidth)
    imageTheme.setImageDownloadButtonHeight(this.imageDownloadButtonHeight)
    imageTheme.setImageDownloadButtonRadius({topLeft: this.imageDownloadButtonRadiusTopLeft, topRight: this.imageDownloadButtonRadiusTopRight, bottomLeft: this.imageDownloadButtonRadiusBottomLeft, bottomRight: this.imageDownloadButtonRadiusBottomRight})
    if (this.imageDownloadButtonIcon !== undefined) {
      imageTheme.setImageDownloadButtonIcon(this.imageDownloadButtonIcon)
    }
    imageTheme.setImageDownloadButtonIconWidth(this.imageDownloadButtonIconWidth)
    imageTheme.setImageDownloadButtonIconHeight(this.imageDownloadButtonIconHeight)
    imageTheme.setImageDownloadButtonIconTextGap(this.imageDownloadButtonIconTextGap.valueOf() as number)
    if (this.imageDownloadButtonBackgroundColor !== undefined) {
      imageTheme.setImageDownloadButtonBackgroundColor(this.imageDownloadButtonBackgroundColor)
    }
    imageTheme.setImageDownloadButtonText(this.imageDownloadButtonText)
    if (this.imageDownloadButtonTextFontColor !== undefined) {
      imageTheme.setImageDownloadButtonTextFontColor(this.imageDownloadButtonTextFontColor)
    }
    imageTheme.setImageDownloadButtonTextFontSize(this.imageDownloadButtonTextFontSize)
    imageTheme.setImageDownloadButtonTextFontStyle(this.imageDownloadButtonTextFontStyle)
    imageTheme.setImageDownloadButtonTextFontWeight(this.imageDownloadButtonTextFontWeight)
    imageTheme.setImageDownloadButtonTextFontFamily(this.imageDownloadButtonTextFontFamily)
    imageTheme.setImageDownloadButtonTextLineHeight(this.imageDownloadButtonTextLineHeight)
    theme.setImageTheme(imageTheme)
    
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsImageStylePlugin(true) // 图片样式
    if (!this.isImageMixedLayout) {
      plugin.setIsImageTextMixPlugin(true) // 图片不混排插件
    }
    plugin.setIsImageCollectPlugin(true) // 图片视频url集合列表插件
    plugin.setIsHtmlPlugin(true) // HTML
    return plugin
  }

  setImageCallback(funcArg0: string, funcArg1: Array<string>) {
    hilog.error(1, "1", `-------------funcArg0:${funcArg0},funcArg1:${funcArg1}`)
  }

  async setImageReplaceCallback(funcArg0: string): Promise<ArrayBuffer | undefined> {
    hilog.error(1, "1", `-------------funcArg0:${funcArg0}`)
    return getFileContextArr("app_icon.png")
  }

  setImageDownloadCallback(funcArg0: string) {
    hilog.error(1, "1", `-------------funcArg0:${funcArg0}`)
  }
}
