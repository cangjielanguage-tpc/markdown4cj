import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import {
  booleanListGeneralData,
  borderStyleListGeneraData,
  colorListGeneralData,
  fontStyleListGeneraData,
  fontWeightListGeneraData,
  imageFitListData,
  // imageFitTypeListData,
  imageWidthOrHeightListData,
  lineOrBorderWidthListGeneraData,
  marginListGeneralData,
  radiusListGeneraData,
  spaceListGeneralData,
  textLineHeightListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  widthOrHeightListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { ImageDataMD } from '../model/ImageDataMD'
// import { ImageFitType } from '@cangjie-tpc/markdown_hybrid'

@Entry
@Component
struct ImagePage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "016_Image"
  @State // rawfile文件夹列表
  folderList: Array<string> = new Array<string>()
  // 是否全量加载Markdown文本列表
  isFullList: Array<boolean> = booleanListGeneralData
  @State // 是否全量加载Markdown文本
  isFull: boolean = true
  // 是否增量解析Markdown文本列表
  incrementalAnalysisList: Array<boolean> = booleanListGeneralData
  @State // 是否增量解析Markdown文本
  incrementalAnalysis: boolean = false
  // 是否启用解析节流列表
  enableParseThrottleList: Array<boolean> = booleanListGeneralData
  @State // 是否启用解析节流
  enableParseThrottle: boolean = false
  // 解析节流间隔列表
  parseThrottleMsList: Array<number> = timeListGeneralData
  @State // 解析节流间隔（ms）
  parseThrottleMs: number = 200
  // 增量加载每次间隔时间列表
  timeList: Array<number> = timeListGeneralData
  @State // 增量加载每次间隔时间
  time: number = 50
  // 增量每次增量文本数量列表
  textNumberList: Array<number> = textNumberListGeneralData
  @State // 增量每次增量文本数量
  textNumber: number = 10
  // 是否同步解析Markdown文本列表
  isMarkdownParserSyncList: Array<boolean> = booleanListGeneralData
  @State // 是否同步解析Markdown文本
  isMarkdownParserSync: boolean = false
  // 是否打开长按复制粘贴效果列表
  isOnCopyList: Array<boolean> = booleanListGeneralData
  @State // 是否打开长按复制粘贴效果
  isOnCopy: boolean = false
  // Markdown全局上外边距列表
  blockMarginTopList: Array<number> = marginListGeneralData
  @State // Markdown全局上外边距
  blockMarginTop: number = 8
  // Markdown全局右外边距列表
  blockMarginRightList: Array<number> = marginListGeneralData
  @State // Markdown全局右外边距
  blockMarginRight: number = 0
  // Markdown全局下外边距列表
  blockMarginBottomList: Array<number> = marginListGeneralData
  @State // Markdown全局下外边距
  blockMarginBottom: number = 8
  // Markdown全局左外边距列表
  blockMarginLeftList: Array<number> = marginListGeneralData
  @State // Markdown全局左外边距
  blockMarginLeft: number = 0
  // 模块间上下间距列表
  markdownBlockSpacingList: Array<number> = marginListGeneralData
  @State // 模块间上下间距
  markdownBlockSpacing: number = 8
  // 软换行是否换行列列表
  isLineBreakList: Array<boolean> = booleanListGeneralData
  @State // 软换行是否换行
  isLineBreak: boolean = false
  // 背景颜色列表
  globalBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 背景颜色
  globalBackgroundColor: ResourceColor | undefined = undefined
  // 是否允许markdown控件自身响应滑动列表
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  @State // 是否允许markdown控件自身响应滑动
  openGestureSwipe: boolean = false
  // 是否开启响应滑动测试列表
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  @State // 是否开启响应滑动测试
  openGestureSwipeTest: boolean = false
  // ---------------- 专有
  // 是否触发图片替换事件列表
  imageReplaceList: Array<boolean> = booleanListGeneralData
  @State // 是否触发图片替换事件
  imageReplace: boolean = false
  // 网络图片是否压缩列表
  imageAutoResizeList: Array<boolean> = booleanListGeneralData
  @State // 网络图片是否压缩
  imageAutoResize: boolean = true
  // 图片默认占位图选项列表
  imagePlaceholderList: Array<Resource | undefined> = [undefined, $r('app.media.startIcon')]
  @State // 图片默认占位图
  imagePlaceholder: Resource | undefined = undefined
  // 是否图文混排列表
  isImageMixedLayoutList: Array<boolean> = booleanListGeneralData
  @State // 是否图文混排
  isImageMixedLayout: boolean = true
  // 图片上外边距列表
  imageMarginTopList: Array<Length> = marginListGeneralData
  @State // 图片上外边距
  imageMarginTop: Length = 0.0
  // 图片右外边距列表
  imageMarginRightList: Array<Length> = marginListGeneralData
  @State // 图片右外边距
  imageMarginRight: Length = 0.0
  // 图片下外边距列表
  imageMarginBottomList: Array<Length> = marginListGeneralData
  @State // 图片下外边距
  imageMarginBottom: Length = 0.0
  // 图片左外边距列表
  imageMarginLeftList: Array<Length> = marginListGeneralData
  @State // 图片左外边距
  imageMarginLeft: Length = 0.0
  // 图片边框左上圆角列表
  imageRadiusTopLeftList: Array<Length> = radiusListGeneraData
  @State // 图片边框左上圆角
  imageRadiusTopLeft: Length = 0.0
  // 图片边框右上圆角列表
  imageRadiusTopRightList: Array<Length> = radiusListGeneraData
  @State // 图片边框右上圆角
  imageRadiusTopRight: Length = 0.0
  // 图片边框左下圆角列表
  imageRadiusBottomLeftList: Array<Length> = radiusListGeneraData
  @State // 图片边框左下圆角
  imageRadiusBottomLeft: Length = 0.0
  // 图片边框右下圆角列表
  imageRadiusBottomRightList: Array<Length> = radiusListGeneraData
  @State // 图片边框右下圆角
  imageRadiusBottomRight: Length = 0.0
  // 图片边框样式列表
  imageBorderStyleList: Array<BorderStyle> = borderStyleListGeneraData
  @State // 图片边框样式
  imageBorderStyle: BorderStyle = BorderStyle.Solid
  // 图片边框宽度列表
  imageBorderWidthList: Array<Length> = lineOrBorderWidthListGeneraData
  @State // 图片边框宽度
  imageBorderWidth: Length = 0.0
  // 图片边框颜色列表
  imageBorderColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 图片边框颜色
  imageBorderColor: ResourceColor | undefined = undefined
  // 图片基于自身宽度缩放百分比列表
  imageMaximumWidthList: Array<number> = [0, 0.2, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1.0]
  @State // 图片基于自身宽度缩放百分比
  imageMaximumWidth: number = 1.0
  // 图片基于父布局宽度缩放百分比列表
  imageFixedRatioWidthList: Array<number | undefined> = [undefined, 0, 0.2, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1.0]
  @State // 图片基于父布局宽度缩放百分比
  imageFixedRatioWidth: number | undefined = undefined
  // 图片最大高度列表
  imageMaxHeightList: Array<number | undefined> = imageWidthOrHeightListData
  @State // 图片最大高度
  imageMaxHeight: number | undefined = undefined
  // 图片高度列表
  imageHeightList: Array<number | undefined> = imageWidthOrHeightListData
  @State // 图片高度
  imageHeight: number | undefined = undefined
  // 图片最大宽度列表
  imageMaxWidthList: Array<number | undefined> = imageWidthOrHeightListData
  @State // 图片最大宽度
  imageMaxWidth: number | undefined = undefined
  // 图片宽度列表
  imageWidthList: Array<number | undefined> = imageWidthOrHeightListData
  @State // 图片宽度
  imageWidth: number | undefined = undefined
  // 图片缩放类型列表
  imageFitTypeList: Array<ImageFit> = imageFitListData
  @State // 图片缩放类型
  imageFitType: ImageFit = ImageFit.Contain
  // 底部布局距离图片上边距列表
  imageBottomLayoutMarginTopList: Array<Length> = marginListGeneralData
  @State // 底部布局距离图片上边距
  imageBottomLayoutMarginTop: Length = 14.0
  // 图片下载按钮是否显示列表
  imageDownloadButtonVisibleList: Array<boolean> = booleanListGeneralData
  @State // 图片下载按钮是否显示
  imageDownloadButtonVisible: boolean = false
  // 图片下载按钮宽度列表
  imageDownloadButtonWidthList: Array<Length> = widthOrHeightListGeneralData
  @State // 图片下载按钮宽度
  imageDownloadButtonWidth: Length = 296.0
  // 图片下载按钮高度列表
  imageDownloadButtonHeightList: Array<Length> = widthOrHeightListGeneralData
  @State // 图片下载按钮高度
  imageDownloadButtonHeight: Length = 44.0
  // 图片下载按钮左上圆角列表
  imageDownloadButtonRadiusTopLeftList: Array<Length> = radiusListGeneraData
  @State // 图片下载按钮左上圆角
  imageDownloadButtonRadiusTopLeft: Length = 22.0
  // 图片下载按钮右上圆角列表
  imageDownloadButtonRadiusTopRightList: Array<Length> = radiusListGeneraData
  @State // 图片下载按钮右上圆角
  imageDownloadButtonRadiusTopRight: Length = 22.0
  // 图片下载按钮左下圆角列表
  imageDownloadButtonRadiusBottomLeftList: Array<Length> = radiusListGeneraData
  @State // 图片下载按钮左下圆角
  imageDownloadButtonRadiusBottomLeft: Length = 22.0
  // 图片下载按钮右下圆角列表
  imageDownloadButtonRadiusBottomRightList: Array<Length> = radiusListGeneraData
  @State // 图片下载按钮右下圆角
  imageDownloadButtonRadiusBottomRight: Length = 22.0
  // 图片下载按钮图标列表
  imageDownloadButtonIconList: Array<Resource | undefined> = [undefined, $r('app.media.startIcon')]
  @State // 图片下载按钮图标
  imageDownloadButtonIcon: Resource | undefined = undefined
  // 图片下载按钮图标宽度列表
  imageDownloadButtonIconWidthList: Array<Length> = widthOrHeightListGeneralData
  @State // 图片下载按钮图标宽度
  imageDownloadButtonIconWidth: Length = 18.0
  // 图片下载按钮图标高度列表
  imageDownloadButtonIconHeightList: Array<Length> = widthOrHeightListGeneralData
  @State // 图片下载按钮图标高度
  imageDownloadButtonIconHeight: Length = 18.0
  // 图片下载按钮图标和文本间距列表
  imageDownloadButtonIconTextGapList: Array<number> = spaceListGeneralData
  @State // 图片下载按钮图标和文本间距
  imageDownloadButtonIconTextGap: number = 6.0
  // 图片下载按钮背景颜色列表
  imageDownloadButtonBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 图片下载按钮背景颜色
  imageDownloadButtonBackgroundColor: ResourceColor | undefined = undefined
  // 图片下载按钮默认文本内容列表
  imageDownloadButtonTextList: Array<string> = ["下载", "提交", "下载图片"]
  @State // 图片下载按钮默认文本内容
  imageDownloadButtonText: string = "下载图片"
  // 图片下载按钮文本颜色列表
  imageDownloadButtonTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 图片下载按钮文本颜色
  imageDownloadButtonTextFontColor: ResourceColor | undefined = undefined
  // 图片下载按钮文本尺寸列表
  imageDownloadButtonTextFontSizeList: Array<number | string | Resource> = textSizeListGeneralData
  @State // 图片下载按钮文本尺寸
  imageDownloadButtonTextFontSize: number | string | Resource = 16.0
  // 图片下载按钮文本字体样式列表
  imageDownloadButtonTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 图片下载按钮文本字体样式
  imageDownloadButtonTextFontStyle: FontStyle = FontStyle.Normal
  // 图片下载按钮文本字体粗细列表
  imageDownloadButtonTextFontWeightList: Array<number | FontWeight> = fontWeightListGeneraData
  @State // 图片下载按钮文本字体粗细
  imageDownloadButtonTextFontWeight: number | FontWeight = FontWeight.Medium
  // 图片下载按钮文本字体列表
  imageDownloadButtonTextFontFamilyList: Array<string | Resource> = textTypefaceListGeneralData
  @State // 图片下载按钮文本字体
  imageDownloadButtonTextFontFamily: string | Resource = 'HarmonyOS Sans'
  // 图片下载按钮文本行高列表
  imageDownloadButtonTextLineHeightList: Array<number | string | Resource> = textLineHeightListGeneralData
  @State // 图片下载按钮文本行高
  imageDownloadButtonTextLineHeight: number | string | Resource = 22.0
  @State // 配置数据内容
  imageDataMD: ImageDataMD = new ImageDataMD()
  heightMD: number = 30 * 2 // 乘以行数
  @State isExpanded1: boolean = false // 控制展开/折叠状态 - 通用样式配置
  @State isExpanded2: boolean = false // 控制展开/折叠状态 - 图片边距和边框
  @State isExpanded3: boolean = false // 控制展开/折叠状态 - 图片设置和其他
  @State isExpanded4: boolean = false // 控制展开/折叠状态 - 图片下载按钮

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "图片配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )

      // md文档展示部分
      Column() {
        GridRow({
          columns: 3,
          gutter: { x: 5, y: 5 },
          breakpoints: {
            value: ['400vp', '600vp', '800vp'],
            reference: BreakpointsReference.ComponentSize
          },
          direction: GridRowDirection.Row
        }) {
          ForEach(this.folderList, (item: string, index: number) => {
            GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 }, offset: 0, order: 0 }) {
              Text(`${item}`)
                .fontSize(12)
                .fontColor('#FFFFFFFF')
                .backgroundColor('#FF2196F3')
                .height(25).width('100%')
                .padding(5)
                .borderRadius(5)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Clip })
                .onClick(() => {
                  // ---------- 通用
                  this.imageDataMD._isFull = this.isFull
                  this.imageDataMD._incrementalAnalysis = this.incrementalAnalysis
                  this.imageDataMD._enableParseThrottle = this.enableParseThrottle
                  this.imageDataMD._parseThrottleMs = this.parseThrottleMs
                  this.imageDataMD._time = this.time
                  this.imageDataMD._textNumber = this.textNumber
                  this.imageDataMD._isMarkdownParserSync = this.isMarkdownParserSync
                  this.imageDataMD._isOnCopy = this.isOnCopy
                  this.imageDataMD._blockMarginTop = this.blockMarginTop
                  this.imageDataMD._blockMarginRight = this.blockMarginRight
                  this.imageDataMD._blockMarginBottom = this.blockMarginBottom
                  this.imageDataMD._blockMarginLeft = this.blockMarginLeft
                  this.imageDataMD._markdownBlockSpacing = this.markdownBlockSpacing
                  this.imageDataMD._isLineBreak = this.isLineBreak
                  this.imageDataMD._backgroundColor = this.globalBackgroundColor
                  this.imageDataMD._openGestureSwipe = this.openGestureSwipe
                  this.imageDataMD._openGestureSwipeTest = this.openGestureSwipeTest

                  // ---------- 专有
                  this.imageDataMD._pagePath = `${this.rawFilePath}/${item}`
                  this.imageDataMD.imageReplace = this.imageReplace
                  this.imageDataMD.imageAutoResize = this.imageAutoResize
                  this.imageDataMD.imagePlaceholder = this.imagePlaceholder
                  this.imageDataMD.isImageMixedLayout = this.isImageMixedLayout
                  this.imageDataMD.imageMarginTop = this.imageMarginTop
                  this.imageDataMD.imageMarginRight = this.imageMarginRight
                  this.imageDataMD.imageMarginBottom = this.imageMarginBottom
                  this.imageDataMD.imageMarginLeft = this.imageMarginLeft
                  this.imageDataMD.imageRadiusTopLeft = this.imageRadiusTopLeft
                  this.imageDataMD.imageRadiusTopRight = this.imageRadiusTopRight
                  this.imageDataMD.imageRadiusBottomLeft = this.imageRadiusBottomLeft
                  this.imageDataMD.imageRadiusBottomRight = this.imageRadiusBottomRight
                  this.imageDataMD.imageBorderStyle = this.imageBorderStyle
                  this.imageDataMD.imageBorderWidth = this.imageBorderWidth
                  this.imageDataMD.imageBorderColor = this.imageBorderColor
                  this.imageDataMD.imageMaximumWidth = this.imageMaximumWidth
                  this.imageDataMD.imageFixedRatioWidth = this.imageFixedRatioWidth
                  this.imageDataMD.imageMaxHeight = this.imageMaxHeight
                  this.imageDataMD.imageHeight = this.imageHeight
                  this.imageDataMD.imageMaxWidth = this.imageMaxWidth
                  this.imageDataMD.imageWidth = this.imageWidth
                  this.imageDataMD.imageFitType = this.imageFitType
                  this.imageDataMD.imageBottomLayoutMarginTop = this.imageBottomLayoutMarginTop
                  this.imageDataMD.imageDownloadButtonVisible = this.imageDownloadButtonVisible
                  this.imageDataMD.imageDownloadButtonWidth = this.imageDownloadButtonWidth
                  this.imageDataMD.imageDownloadButtonHeight = this.imageDownloadButtonHeight
                  this.imageDataMD.imageDownloadButtonRadiusTopLeft = this.imageDownloadButtonRadiusTopLeft
                  this.imageDataMD.imageDownloadButtonRadiusTopRight = this.imageDownloadButtonRadiusTopRight
                  this.imageDataMD.imageDownloadButtonRadiusBottomLeft = this.imageDownloadButtonRadiusBottomLeft
                  this.imageDataMD.imageDownloadButtonRadiusBottomRight = this.imageDownloadButtonRadiusBottomRight
                  this.imageDataMD.imageDownloadButtonIcon = this.imageDownloadButtonIcon
                  this.imageDataMD.imageDownloadButtonIconWidth = this.imageDownloadButtonIconWidth
                  this.imageDataMD.imageDownloadButtonIconHeight = this.imageDownloadButtonIconHeight
                  this.imageDataMD.imageDownloadButtonIconTextGap = this.imageDownloadButtonIconTextGap
                  this.imageDataMD.imageDownloadButtonBackgroundColor = this.imageDownloadButtonBackgroundColor
                  this.imageDataMD.imageDownloadButtonText = this.imageDownloadButtonText
                  this.imageDataMD.imageDownloadButtonTextFontColor = this.imageDownloadButtonTextFontColor
                  this.imageDataMD.imageDownloadButtonTextFontSize = this.imageDownloadButtonTextFontSize
                  this.imageDataMD.imageDownloadButtonTextFontStyle = this.imageDownloadButtonTextFontStyle
                  this.imageDataMD.imageDownloadButtonTextFontWeight = this.imageDownloadButtonTextFontWeight
                  this.imageDataMD.imageDownloadButtonTextFontFamily = this.imageDownloadButtonTextFontFamily
                  this.imageDataMD.imageDownloadButtonTextLineHeight = this.imageDownloadButtonTextLineHeight
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/ImageDetailsPage", params: this.imageDataMD })
                })
            }
          })
        }.width('100%').height('100%')
      }.padding({ top: 5, bottom: 5 }).width('100%').height(this.heightMD)

      Scroll() {
        Column() {
          // 通用样式配置
          Column() {
            Row() {
              Text("通用样式配置")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded1 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded1 = !this.isExpanded1
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded1 = !this.isExpanded1
            })

            if (this.isExpanded1) {
              Column() {
                BaseTabComponent({
                  titleStr: "是否全量加载Markdown文本 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.isFullList,
                  allData: this.isFull
                })
                BaseTabComponent({
                  titleStr: "是否增量解析Markdown文本 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.incrementalAnalysisList,
                  allData: this.incrementalAnalysis
                })
                BaseTabComponent({
                  titleStr: "是否启用解析节流 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.enableParseThrottleList,
                  allData: this.enableParseThrottle
                })
                BaseTabComponent({
                  titleStr: "解析节流间隔(ms) - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.parseThrottleMsList,
                  allData: this.parseThrottleMs
                })
                BaseTabComponent({
                  titleStr: "增量加载每次间隔时间 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.timeList,
                  allData: this.time
                })
                BaseTabComponent({
                  titleStr: "增量每次增量文本数量 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.textNumberList,
                  allData: this.textNumber
                })
                BaseTabComponent({
                  titleStr: "是否同步解析Markdown文本 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.isMarkdownParserSyncList,
                  allData: this.isMarkdownParserSync
                })
                BaseTabComponent({
                  titleStr: "是否打开长按复制粘贴效果 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.isOnCopyList,
                  allData: this.isOnCopy
                })
                BaseTabComponent({
                  titleStr: "Markdown全局上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginTopList,
                  allData: this.blockMarginTop
                })
                BaseTabComponent({
                  titleStr: "Markdown全局右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginRightList,
                  allData: this.blockMarginRight
                })
                BaseTabComponent({
                  titleStr: "Markdown全局下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginBottomList,
                  allData: this.blockMarginBottom
                })
                BaseTabComponent({
                  titleStr: "Markdown全局左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginLeftList,
                  allData: this.blockMarginLeft
                })
                BaseTabComponent({
                  titleStr: "模块间上下间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.markdownBlockSpacingList,
                  allData: this.markdownBlockSpacing
                })
                BaseTabComponent({
                  titleStr: "软换行是否换行 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.isLineBreakList,
                  allData: this.isLineBreak
                })
                BaseTabComponent({
                  titleStr: "背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.globalBackgroundColorList,
                  allData: this.globalBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "是否开启响应滑动测试 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.openGestureSwipeTestList,
                  allData: this.openGestureSwipeTest
                })
                BaseTabComponent({
                  titleStr: "是否允许markdown控件自身响应滑动 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.openGestureSwipeList,
                  allData: this.openGestureSwipe
                })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)

          // 图片边距和边框
          Column() {
            Row() {
              Text("图片边距和边框")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded2 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded2 = !this.isExpanded2
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded2 = !this.isExpanded2
            })

            if (this.isExpanded2) {
              Column() {
                BaseTabComponent({
                  titleStr: "图片上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageMarginTopList,
                  allData: this.imageMarginTop
                })
                BaseTabComponent({
                  titleStr: "图片右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageMarginRightList,
                  allData: this.imageMarginRight
                })
                BaseTabComponent({
                  titleStr: "图片下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageMarginBottomList,
                  allData: this.imageMarginBottom
                })
                BaseTabComponent({
                  titleStr: "图片左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageMarginLeftList,
                  allData: this.imageMarginLeft
                })
                BaseTabComponent({
                  titleStr: "图片边框左上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageRadiusTopLeftList,
                  allData: this.imageRadiusTopLeft
                })
                BaseTabComponent({
                  titleStr: "图片边框右上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageRadiusTopRightList,
                  allData: this.imageRadiusTopRight
                })
                BaseTabComponent({
                  titleStr: "图片边框左下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageRadiusBottomLeftList,
                  allData: this.imageRadiusBottomLeft
                })
                BaseTabComponent({
                  titleStr: "图片边框右下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageRadiusBottomRightList,
                  allData: this.imageRadiusBottomRight
                })
                BaseTabComponent({
                  titleStr: "图片边框样式 - ",
                  typeEnum: TypeEnum.IS_BORDER_STYLE,
                  allListData: this.imageBorderStyleList,
                  allData: this.imageBorderStyle
                })
                BaseTabComponent({
                  titleStr: "图片边框宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageBorderWidthList,
                  allData: this.imageBorderWidth
                })
                BaseTabComponent({
                  titleStr: "图片边框颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.imageBorderColorList,
                  allData: this.imageBorderColor
                })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)

          // 图片设置和其他
          Column() {
            Row() {
              Text("图片设置和其他")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded3 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded3 = !this.isExpanded3
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded3 = !this.isExpanded3
            })

            if (this.isExpanded3) {
              Column() {
                BaseTabComponent({
                  titleStr: "是否触发图片替换事件 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.imageReplaceList,
                  allData: this.imageReplace
                })
                BaseTabComponent({
                  titleStr: "网络图片是否压缩 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.imageAutoResizeList,
                  allData: this.imageAutoResize
                })
                BaseTabComponent({
                  titleStr: "设置默认占位图 - ",
                  typeEnum: TypeEnum.IS_RESOURCE,
                  allListData: this.imagePlaceholderList,
                  allData: this.imagePlaceholder
                })
                BaseTabComponent({
                  titleStr: "是否图文混排 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.isImageMixedLayoutList,
                  allData: this.isImageMixedLayout
                })
                BaseTabComponent({
                  titleStr: "图片基于自身宽度缩放百分比 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageMaximumWidthList,
                  allData: this.imageMaximumWidth
                })
                BaseTabComponent({
                  titleStr: "图片基于父布局宽度缩放百分比 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageFixedRatioWidthList,
                  allData: this.imageFixedRatioWidth
                })
                BaseTabComponent({
                  titleStr: "图片最大高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageMaxHeightList,
                  allData: this.imageMaxHeight
                })
                BaseTabComponent({
                  titleStr: "图片高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageHeightList,
                  allData: this.imageHeight
                })
                BaseTabComponent({
                  titleStr: "图片最大宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageMaxWidthList,
                  allData: this.imageMaxWidth
                })
                BaseTabComponent({
                  titleStr: "图片宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageWidthList,
                  allData: this.imageWidth
                })
                BaseTabComponent({
                  titleStr: "图片缩放类型 - ",
                  typeEnum: TypeEnum.IS_IMAGE_FIT,
                  allListData: this.imageFitTypeList,
                  allData: this.imageFitType
                })
                BaseTabComponent({
                  titleStr: "底部布局距离图片上边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageBottomLayoutMarginTopList,
                  allData: this.imageBottomLayoutMarginTop
                })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)

          // 图片下载按钮
          Column() {
            Row() {
              Text("图片下载按钮")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded4 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded4 = !this.isExpanded4
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded4 = !this.isExpanded4
            })

            if (this.isExpanded4) {
              Column() {
                BaseTabComponent({
                  titleStr: "图片下载按钮是否显示 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.imageDownloadButtonVisibleList,
                  allData: this.imageDownloadButtonVisible
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageDownloadButtonWidthList,
                  allData: this.imageDownloadButtonWidth
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageDownloadButtonHeightList,
                  allData: this.imageDownloadButtonHeight
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮左上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageDownloadButtonRadiusTopLeftList,
                  allData: this.imageDownloadButtonRadiusTopLeft
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮右上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageDownloadButtonRadiusTopRightList,
                  allData: this.imageDownloadButtonRadiusTopRight
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮左下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageDownloadButtonRadiusBottomLeftList,
                  allData: this.imageDownloadButtonRadiusBottomLeft
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮右下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageDownloadButtonRadiusBottomRightList,
                  allData: this.imageDownloadButtonRadiusBottomRight
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮图标 - ",
                  typeEnum: TypeEnum.IS_RESOURCE,
                  allListData: this.imageDownloadButtonIconList,
                  allData: this.imageDownloadButtonIcon
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮图标宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageDownloadButtonIconWidthList,
                  allData: this.imageDownloadButtonIconWidth
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮图标高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageDownloadButtonIconHeightList,
                  allData: this.imageDownloadButtonIconHeight
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮图标和文本间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageDownloadButtonIconTextGapList,
                  allData: this.imageDownloadButtonIconTextGap
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.imageDownloadButtonBackgroundColorList,
                  allData: this.imageDownloadButtonBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮默认文本内容 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.imageDownloadButtonTextList,
                  allData: this.imageDownloadButtonText
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.imageDownloadButtonTextFontColorList,
                  allData: this.imageDownloadButtonTextFontColor
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageDownloadButtonTextFontSizeList,
                  allData: this.imageDownloadButtonTextFontSize
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.imageDownloadButtonTextFontStyleList,
                  allData: this.imageDownloadButtonTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.imageDownloadButtonTextFontWeightList,
                  allData: this.imageDownloadButtonTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.imageDownloadButtonTextFontFamilyList,
                  allData: this.imageDownloadButtonTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "图片下载按钮文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.imageDownloadButtonTextLineHeightList,
                  allData: this.imageDownloadButtonTextLineHeight
                })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)
        }
        .padding({ top: 10, bottom: 100 })
      }
    }
    .backgroundColor('#FFEAEAEA')
    .height("90%")
  }
}
