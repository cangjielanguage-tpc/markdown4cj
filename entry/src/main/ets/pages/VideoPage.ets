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
import { VideoData } from '../model/VideoData'
// import { ImageFitType } from '@cangjie-tpc/markdown_hybrid'

@Entry
@Component
struct VideoPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') safeTop: number = 0 // 顶部导航栏高度
  // rawfile路径
  rawFilePath: string = "015_Video"
  @State folderList: Array<string> = new Array<string>() // rawfile文件夹列表
  // 是否全量加载Markdown文本列表
  isFullList: Array<boolean> = booleanListGeneralData
  @State isFull: boolean = true // 是否全量加载Markdown文本
  // 是否增量解析Markdown文本列表
  incrementalAnalysisList: Array<boolean> = booleanListGeneralData
  @State incrementalAnalysis: boolean = false // 是否增量解析Markdown文本
  // 增量加载每次间隔时间列表
  timeList: Array<number> = timeListGeneralData
  @State time: number = 50 // 增量加载每次间隔时间
  // 增量每次增量文本数量列表
  textNumberList: Array<number> = textNumberListGeneralData
  @State textNumber: number = 10 // 增量每次增量文本数量
  // 是否同步解析Markdown文本列表
  isMarkdownParserSyncList: Array<boolean> = booleanListGeneralData
  @State isMarkdownParserSync: boolean = false // 是否同步解析Markdown文本
  // 是否打开长按复制粘贴效果列表
  isOnCopyList: Array<boolean> = booleanListGeneralData
  @State isOnCopy: boolean = false // 是否打开长按复制粘贴效果
  // markdown全局上外边距列表
  blockMarginTopList: Array<number> = marginListGeneralData
  @State blockMarginTop: number = 0 // markdown全局上外边距
  // markdown全局右外边距列表
  blockMarginRightList: Array<number> = marginListGeneralData
  @State blockMarginRight: number = 0 // markdown全局右外边距
  // markdown全局下外边距列表
  blockMarginBottomList: Array<number> = marginListGeneralData
  @State blockMarginBottom: number = 0 // markdown全局下外边距
  // markdown全局左外边距列表
  blockMarginLeftList: Array<number> = marginListGeneralData
  @State blockMarginLeft: number = 0 // markdown全局左外边距
  // 模块间上下间距列表
  markdownBlockSpacingList: Array<number> = marginListGeneralData
  @State markdownBlockSpacing: number = 8 // 模块间上下间距
  // 软换行是否换行列表
  isLineBreakList: Array<boolean> = booleanListGeneralData
  @State isLineBreak: boolean = false // 软换行是否换行
  // 背景颜色列表
  globalBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State globalBackgroundColor: ResourceColor | undefined = undefined // 背景颜色
  // 是否允许markdown控件自身响应滑动列表
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  @State openGestureSwipe: boolean = false // 是否允许markdown控件自身响应滑动
  // 是否开启响应滑动测试列表
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  @State openGestureSwipeTest: boolean = false // 是否开启响应滑动测试
  // 是否启用解析节流列表
  enableParseThrottleList: Array<boolean> = booleanListGeneralData
  @State enableParseThrottle: boolean = false // 是否启用解析节流
  // 解析节流间隔列表
  parseThrottleMsList: Array<number> = timeListGeneralData
  @State parseThrottleMs: number = 200 // 解析节流间隔（ms）
  // ---------------- 专有
  // 视频背景颜色列表
  videoBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State videoBackgroundColor: ResourceColor | undefined = undefined // 视频背景颜色
  // 视频上外边距列表
  videoMarginTopList: Array<number> = marginListGeneralData
  @State videoMarginTop: number = 0 // 视频上外边距
  // 视频右外边距列表
  videoMarginRightList: Array<number> = marginListGeneralData
  @State videoMarginRight: number = 0 // 视频右外边距
  // 视频下外边距列表
  videoMarginBottomList: Array<number> = marginListGeneralData
  @State videoMarginBottom: number = 0 // 视频下外边距
  // 视频左外边距列表
  videoMarginLeftList: Array<number> = marginListGeneralData
  @State videoMarginLeft: number = 0 // 视频左外边距
  // 视频上内边距列表
  videoPaddingTopList: Array<number> = marginListGeneralData
  @State videoPaddingTop: number = 0 // 视频上内边距
  // 视频右内边距列表
  videoPaddingRightList: Array<number> = marginListGeneralData
  @State videoPaddingRight: number = 0 // 视频右内边距
  // 视频下内边距列表
  videoPaddingBottomList: Array<number> = marginListGeneralData
  @State videoPaddingBottom: number = 0 // 视频下内边距
  // 视频左内边距列表
  videoPaddingLeftList: Array<number> = marginListGeneralData
  @State videoPaddingLeft: number = 0 // 视频左内边距
  // 视频边框左上圆角列表
  videoRadiusTopLeftList: Array<number> = radiusListGeneraData
  @State videoRadiusTopLeft: number = 10 // 视频边框左上圆角
  // 视频边框右上圆角列表
  videoRadiusTopRightList: Array<number> = radiusListGeneraData
  @State videoRadiusTopRight: number = 10 // 视频边框右上圆角
  // 视频边框左下圆角列表
  videoRadiusBottomLeftList: Array<number> = radiusListGeneraData
  @State videoRadiusBottomLeft: number = 10 // 视频边框左下圆角
  // 视频边框右下圆角列表
  videoRadiusBottomRightList: Array<number> = radiusListGeneraData
  @State videoRadiusBottomRight: number = 10 // 视频边框右下圆角
  // 视频边框样式列表
  videoBorderStyleList: Array<BorderStyle> = borderStyleListGeneraData
  @State videoBorderStyle: BorderStyle = BorderStyle.Solid // 视频边框样式
  // 视频边框宽度列表
  videoBorderWidthList: Array<number> = lineOrBorderWidthListGeneraData
  @State videoBorderWidth: number = 0 // 视频边框宽度
  // 视频边框颜色列表
  videoBorderColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State videoBorderColor: ResourceColor | undefined = undefined // 视频边框颜色
  // 视频占位图列表
  videoPlaceholderList: Array<Resource | undefined> = [undefined, $r('app.media.background'), $r('app.media.you')]
  @State videoPlaceholder: Resource | undefined = undefined // 视频占位图
  // 视频图片缩放类型列表
  videoImageFitTypeList: Array<ImageFit> = imageFitListData
  @State videoImageFitType: ImageFit = ImageFit.Cover // 视频图片缩放类型
  // 播放按钮图标列表
  videoPlayIconList: Array<Resource | undefined> = [undefined, $r('app.media.startIcon'), $r('app.media.app_icon')]
  @State videoPlayIcon: Resource | undefined = undefined // 播放按钮图标
  // 播放按钮图标宽度列表
  videoPlayIconWidthList: Array<number> = widthOrHeightListGeneralData
  @State videoPlayIconWidth: number = 60 // 播放按钮图标宽度
  // 播放按钮图标高度列表
  videoPlayIconHeightList: Array<number> = widthOrHeightListGeneralData
  @State videoPlayIconHeight: number = 60 // 播放按钮图标高度
  // 播放按钮图标缩放类型列表
  videoPlayIconFitTypeList: Array<ImageFit> = imageFitListData
  @State videoPlayIconFitType: ImageFit = ImageFit.Contain // 播放按钮图标缩放类型
  // 视频时间文本颜色列表
  videoTimeTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State videoTimeTextFontColor: ResourceColor | undefined = undefined // 视频时间文本颜色
  // 视频时间文本尺寸列表
  videoTimeTextFontSizeList: Array<number> = textSizeListGeneralData
  @State videoTimeTextFontSize: number = 14 // 视频时间文本尺寸
  // 视频时间文本字体样式列表
  videoTimeTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State videoTimeTextFontStyle: FontStyle = FontStyle.Normal // 视频时间文本字体样式
  // 视频时间文本字体粗细列表
  videoTimeTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State videoTimeTextFontWeight: FontWeight = FontWeight.Normal // 视频时间文本字体粗细
  // 视频时间文本字体列表
  videoTimeTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State videoTimeTextFontFamily: string = 'HarmonyOS Sans' // 视频时间文本字体
  // 视频时间文本行高列表
  videoTimeTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State videoTimeTextLineHeight: number = 22 // 视频时间文本行高
  // 视频时间文本居右边距列表
  videoTimeTextMarginRightList: Array<number> = marginListGeneralData
  @State videoTimeTextMarginRight: number = 10 // 视频时间文本居右边距
  // 视频时间文本居底边距列表
  videoTimeTextMarginBottomList: Array<number> = marginListGeneralData
  @State videoTimeTextMarginBottom: number = 10 // 视频时间文本居底边距
  // 底部布局是否显示列表
  videoBottomLayoutVisibleList: Array<boolean> = booleanListGeneralData
  @State videoBottomLayoutVisible: boolean = false // 底部布局是否显示
  // 底部布局距离视频上边距列表
  videoBottomLayoutMarginTopList: Array<number> = marginListGeneralData
  @State videoBottomLayoutMarginTop: number = 14 // 底部布局距离视频上边距
  // 视频发布按钮是否显示列表
  videoReleaseButtonVisibleList: Array<boolean> = booleanListGeneralData
  @State videoReleaseButtonVisible: boolean = true // 视频发布按钮是否显示
  // 视频发布按钮背景颜色列表
  videoReleaseButtonBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State videoReleaseButtonBackgroundColor: ResourceColor | undefined = undefined // 视频发布按钮背景颜色
  // 视频发布按钮宽度列表
  videoReleaseButtonWidthList: Array<number> = widthOrHeightListGeneralData
  @State videoReleaseButtonWidth: number = 144 // 视频发布按钮宽度
  // 视频发布按钮高度列表
  videoReleaseButtonHeightList: Array<number> = widthOrHeightListGeneralData
  @State videoReleaseButtonHeight: number = 44 // 视频发布按钮高度
  // 视频发布按钮左上圆角列表
  videoReleaseButtonRadiusTopLeftList: Array<number> = radiusListGeneraData
  @State videoReleaseButtonRadiusTopLeft: number = 22 // 视频发布按钮左上圆角
  // 视频发布按钮右上圆角列表
  videoReleaseButtonRadiusTopRightList: Array<number> = radiusListGeneraData
  @State videoReleaseButtonRadiusTopRight: number = 22 // 视频发布按钮右上圆角
  // 视频发布按钮左下圆角列表
  videoReleaseButtonRadiusBottomLeftList: Array<number> = radiusListGeneraData
  @State videoReleaseButtonRadiusBottomLeft: number = 22 // 视频发布按钮左下圆角
  // 视频发布按钮右下圆角列表
  videoReleaseButtonRadiusBottomRightList: Array<number> = radiusListGeneraData
  @State videoReleaseButtonRadiusBottomRight: number = 22 // 视频发布按钮右下圆角
  // 视频发布按钮图标和文本间距列表
  videoReleaseButtonIconTextGapList: Array<number> = spaceListGeneralData
  @State videoReleaseButtonIconTextGap: number = 6 // 视频发布按钮图标和文本间距
  // 视频发布按钮图标列表
  videoReleaseButtonIconList: Array<Resource | undefined> =
    [undefined, $r('app.media.startIcon'), $r('app.media.app_icon')]
  @State videoReleaseButtonIcon: Resource | undefined = undefined // 视频发布按钮图标
  // 视频发布按钮图标宽度列表
  videoReleaseButtonIconWidthList: Array<number> = widthOrHeightListGeneralData
  @State videoReleaseButtonIconWidth: number = 18 // 视频发布按钮图标宽度
  // 视频发布按钮图标高度列表
  videoReleaseButtonIconHeightList: Array<number> = widthOrHeightListGeneralData
  @State videoReleaseButtonIconHeight: number = 18 // 视频发布按钮图标高度
  // 视频发布按钮默认文本内容列表
  videoReleaseButtonTextList: Array<string> = ['发布视频', '发布', '提交']
  @State videoReleaseButtonText: string = "发布视频" // 视频发布按钮默认文本内容
  // 视频发布按钮文本颜色列表
  videoReleaseButtonTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State videoReleaseButtonTextFontColor: ResourceColor | undefined = undefined // 视频发布按钮文本颜色
  // 视频发布按钮文本尺寸列表
  videoReleaseButtonTextFontSizeList: Array<number> = textSizeListGeneralData
  @State videoReleaseButtonTextFontSize: number = 16 // 视频发布按钮文本尺寸
  // 视频发布按钮文本字体样式列表
  videoReleaseButtonTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State videoReleaseButtonTextFontStyle: FontStyle = FontStyle.Normal // 视频发布按钮文本字体样式
  // 视频发布按钮文本字体粗细列表
  videoReleaseButtonTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State videoReleaseButtonTextFontWeight: FontWeight = FontWeight.Medium // 视频发布按钮文本字体粗细
  // 视频发布按钮文本字体列表
  videoReleaseButtonTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State videoReleaseButtonTextFontFamily: string = 'HarmonyOS Sans' // 视频发布按钮文本字体
  // 视频发布按钮文本行高列表
  videoReleaseButtonTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State videoReleaseButtonTextLineHeight: number = 22 // 视频发布按钮文本行高
  // 视频下载按钮是否显示列表
  videoDownloadButtonVisibleList: Array<boolean> = booleanListGeneralData
  @State videoDownloadButtonVisible: boolean = true // 视频下载按钮是否显示
  // 视频下载按钮背景颜色列表
  videoDownloadButtonBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State videoDownloadButtonBackgroundColor: ResourceColor | undefined = undefined // 视频下载按钮背景颜色
  // 视频下载按钮宽度列表
  videoDownloadButtonWidthList: Array<number> = widthOrHeightListGeneralData
  @State videoDownloadButtonWidth: number = 144 // 视频下载按钮宽度
  // 视频下载按钮高度列表
  videoDownloadButtonHeightList: Array<number> = widthOrHeightListGeneralData
  @State videoDownloadButtonHeight: number = 44 // 视频下载按钮高度
  // 视频下载按钮左上圆角列表
  videoDownloadButtonRadiusTopLeftList: Array<number> = radiusListGeneraData
  @State videoDownloadButtonRadiusTopLeft: number = 22 // 视频下载按钮左上圆角
  // 视频下载按钮右上圆角列表
  videoDownloadButtonRadiusTopRightList: Array<number> = radiusListGeneraData
  @State videoDownloadButtonRadiusTopRight: number = 22 // 视频下载按钮右上圆角
  // 视频下载按钮左下圆角列表
  videoDownloadButtonRadiusBottomLeftList: Array<number> = radiusListGeneraData
  @State videoDownloadButtonRadiusBottomLeft: number = 22 // 视频下载按钮左下圆角
  // 视频下载按钮右下圆角列表
  videoDownloadButtonRadiusBottomRightList: Array<number> = radiusListGeneraData
  @State videoDownloadButtonRadiusBottomRight: number = 22 // 视频下载按钮右下圆角
  // 视频下载按钮图标和文本间距列表
  videoDownloadButtonIconTextGapList: Array<number> = spaceListGeneralData
  @State videoDownloadButtonIconTextGap: number = 6 // 视频下载按钮图标和文本间距
  // 视频下载按钮图标列表
  videoDownloadButtonIconList: Array<Resource | undefined> =
    [undefined, $r('app.media.startIcon'), $r('app.media.app_icon')]
  @State videoDownloadButtonIcon: Resource | undefined = undefined // 视频下载按钮图标
  // 视频下载按钮图标宽度列表
  videoDownloadButtonIconWidthList: Array<number> = widthOrHeightListGeneralData
  @State videoDownloadButtonIconWidth: number = 18 // 视频下载按钮图标宽度
  // 视频下载按钮图标高度列表
  videoDownloadButtonIconHeightList: Array<number> = widthOrHeightListGeneralData
  @State videoDownloadButtonIconHeight: number = 18 // 视频下载按钮图标高度
  // 视频下载按钮默认文本内容列表
  videoDownloadButtonTextList: Array<string> = ['下载视频', '下载', '保存']
  @State videoDownloadButtonText: string = "下载视频" // 视频下载按钮默认文本内容
  // 视频下载按钮文本颜色列表
  videoDownloadButtonTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State videoDownloadButtonTextFontColor: ResourceColor | undefined = undefined // 视频下载按钮文本颜色
  // 视频下载按钮文本尺寸列表
  videoDownloadButtonTextFontSizeList: Array<number> = textSizeListGeneralData
  @State videoDownloadButtonTextFontSize: number = 16 // 视频下载按钮文本尺寸
  // 视频下载按钮文本字体样式列表
  videoDownloadButtonTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State videoDownloadButtonTextFontStyle: FontStyle = FontStyle.Normal // 视频下载按钮文本字体样式
  // 视频下载按钮文本字体粗细列表
  videoDownloadButtonTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State videoDownloadButtonTextFontWeight: FontWeight = FontWeight.Medium // 视频下载按钮文本字体粗细
  // 视频下载按钮文本字体列表
  videoDownloadButtonTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State videoDownloadButtonTextFontFamily: string = 'HarmonyOS Sans' // 视频下载按钮文本字体
  // 视频下载按钮文本行高列表
  videoDownloadButtonTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State videoDownloadButtonTextLineHeight: number = 22 // 视频下载按钮文本行高
  @State videoData: VideoData = new VideoData() // 配置数据内容
  heightMD: number = 30 * 1 // 乘以行数
  @State isExpanded1: boolean = false // 控制展开/折叠状态
  @State isExpanded2: boolean = false // 控制展开/折叠状态 - 视频基本属性
  @State isExpanded3: boolean = false // 控制展开/折叠状态 - 播放按钮
  @State isExpanded4: boolean = false // 控制展开/折叠状态 - 视频时间文本和底部布局
  @State isExpanded5: boolean = false // 控制展开/折叠状态 - 发布按钮
  @State isExpanded6: boolean = false // 控制展开/折叠状态 - 下载按钮

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "视频配置页面",
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
                  this.videoData._isFull = this.isFull
                  this.videoData._incrementalAnalysis = this.incrementalAnalysis
                  this.videoData._enableParseThrottle = this.enableParseThrottle
                  this.videoData._parseThrottleMs = this.parseThrottleMs
                  this.videoData._time = this.time
                  this.videoData._textNumber = this.textNumber
                  this.videoData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.videoData._isOnCopy = this.isOnCopy
                  this.videoData._blockMarginTop = this.blockMarginTop
                  this.videoData._blockMarginRight = this.blockMarginRight
                  this.videoData._blockMarginBottom = this.blockMarginBottom
                  this.videoData._blockMarginLeft = this.blockMarginLeft
                  this.videoData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.videoData._isLineBreak = this.isLineBreak
                  this.videoData._backgroundColor = this.globalBackgroundColor
                  this.videoData._openGestureSwipe = this.openGestureSwipe
                  this.videoData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.videoData._pagePath = `${this.rawFilePath}/${item}`
                  // ---------- 专有 - 视频基本属性
                  this.videoData._videoBackgroundColor = this.videoBackgroundColor
                  this.videoData._videoMarginTop = this.videoMarginTop
                  this.videoData._videoMarginRight = this.videoMarginRight
                  this.videoData._videoMarginBottom = this.videoMarginBottom
                  this.videoData._videoMarginLeft = this.videoMarginLeft
                  this.videoData._videoPaddingTop = this.videoPaddingTop
                  this.videoData._videoPaddingRight = this.videoPaddingRight
                  this.videoData._videoPaddingBottom = this.videoPaddingBottom
                  this.videoData._videoPaddingLeft = this.videoPaddingLeft
                  this.videoData._videoRadiusTopLeft = this.videoRadiusTopLeft
                  this.videoData._videoRadiusTopRight = this.videoRadiusTopRight
                  this.videoData._videoRadiusBottomLeft = this.videoRadiusBottomLeft
                  this.videoData._videoRadiusBottomRight = this.videoRadiusBottomRight
                  this.videoData._videoBorderStyle = this.videoBorderStyle
                  this.videoData._videoBorderWidth = this.videoBorderWidth
                  this.videoData._videoBorderColor = this.videoBorderColor
                  this.videoData._videoPlaceholder = this.videoPlaceholder
                  this.videoData._videoImageFitType = this.videoImageFitType
                  this.videoData._videoPlayIcon = this.videoPlayIcon
                  this.videoData._videoPlayIconWidth = this.videoPlayIconWidth
                  this.videoData._videoPlayIconHeight = this.videoPlayIconHeight
                  this.videoData._videoPlayIconFitType = this.videoPlayIconFitType
                  // ---------- 专有 - 视频时间文本
                  this.videoData._videoTimeTextFontColor = this.videoTimeTextFontColor
                  this.videoData._videoTimeTextFontSize = this.videoTimeTextFontSize
                  this.videoData._videoTimeTextFontStyle = this.videoTimeTextFontStyle
                  this.videoData._videoTimeTextFontWeight = this.videoTimeTextFontWeight
                  this.videoData._videoTimeTextFontFamily = this.videoTimeTextFontFamily
                  this.videoData._videoTimeTextLineHeight = this.videoTimeTextLineHeight
                  this.videoData._videoTimeTextMarginRight = this.videoTimeTextMarginRight
                  this.videoData._videoTimeTextMarginBottom = this.videoTimeTextMarginBottom
                  // ---------- 专有 - 底部布局
                  this.videoData._videoBottomLayoutVisible = this.videoBottomLayoutVisible
                  this.videoData._videoBottomLayoutMarginTop = this.videoBottomLayoutMarginTop
                  // ---------- 专有 - 发布按钮
                  this.videoData._videoReleaseButtonVisible = this.videoReleaseButtonVisible
                  this.videoData._videoReleaseButtonBackgroundColor = this.videoReleaseButtonBackgroundColor
                  this.videoData._videoReleaseButtonWidth = this.videoReleaseButtonWidth
                  this.videoData._videoReleaseButtonHeight = this.videoReleaseButtonHeight
                  this.videoData._videoReleaseButtonRadiusTopLeft = this.videoReleaseButtonRadiusTopLeft
                  this.videoData._videoReleaseButtonRadiusTopRight = this.videoReleaseButtonRadiusTopRight
                  this.videoData._videoReleaseButtonRadiusBottomLeft = this.videoReleaseButtonRadiusBottomLeft
                  this.videoData._videoReleaseButtonRadiusBottomRight = this.videoReleaseButtonRadiusBottomRight
                  this.videoData._videoReleaseButtonIconTextGap = this.videoReleaseButtonIconTextGap
                  this.videoData._videoReleaseButtonIcon = this.videoReleaseButtonIcon
                  this.videoData._videoReleaseButtonIconWidth = this.videoReleaseButtonIconWidth
                  this.videoData._videoReleaseButtonIconHeight = this.videoReleaseButtonIconHeight
                  this.videoData._videoReleaseButtonText = this.videoReleaseButtonText
                  this.videoData._videoReleaseButtonTextFontColor = this.videoReleaseButtonTextFontColor
                  this.videoData._videoReleaseButtonTextFontSize = this.videoReleaseButtonTextFontSize
                  this.videoData._videoReleaseButtonTextFontStyle = this.videoReleaseButtonTextFontStyle
                  this.videoData._videoReleaseButtonTextFontWeight = this.videoReleaseButtonTextFontWeight
                  this.videoData._videoReleaseButtonTextFontFamily = this.videoReleaseButtonTextFontFamily
                  this.videoData._videoReleaseButtonTextLineHeight = this.videoReleaseButtonTextLineHeight
                  // ---------- 专有 - 下载按钮
                  this.videoData._videoDownloadButtonVisible = this.videoDownloadButtonVisible
                  this.videoData._videoDownloadButtonBackgroundColor = this.videoDownloadButtonBackgroundColor
                  this.videoData._videoDownloadButtonWidth = this.videoDownloadButtonWidth
                  this.videoData._videoDownloadButtonHeight = this.videoDownloadButtonHeight
                  this.videoData._videoDownloadButtonRadiusTopLeft = this.videoDownloadButtonRadiusTopLeft
                  this.videoData._videoDownloadButtonRadiusTopRight = this.videoDownloadButtonRadiusTopRight
                  this.videoData._videoDownloadButtonRadiusBottomLeft = this.videoDownloadButtonRadiusBottomLeft
                  this.videoData._videoDownloadButtonRadiusBottomRight = this.videoDownloadButtonRadiusBottomRight
                  this.videoData._videoDownloadButtonIconTextGap = this.videoDownloadButtonIconTextGap
                  this.videoData._videoDownloadButtonIcon = this.videoDownloadButtonIcon
                  this.videoData._videoDownloadButtonIconWidth = this.videoDownloadButtonIconWidth
                  this.videoData._videoDownloadButtonIconHeight = this.videoDownloadButtonIconHeight
                  this.videoData._videoDownloadButtonText = this.videoDownloadButtonText
                  this.videoData._videoDownloadButtonTextFontColor = this.videoDownloadButtonTextFontColor
                  this.videoData._videoDownloadButtonTextFontSize = this.videoDownloadButtonTextFontSize
                  this.videoData._videoDownloadButtonTextFontStyle = this.videoDownloadButtonTextFontStyle
                  this.videoData._videoDownloadButtonTextFontWeight = this.videoDownloadButtonTextFontWeight
                  this.videoData._videoDownloadButtonTextFontFamily = this.videoDownloadButtonTextFontFamily
                  this.videoData._videoDownloadButtonTextLineHeight = this.videoDownloadButtonTextLineHeight
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/VideoDetailsPage", params: this.videoData })
                })
            }
          })
        }.width('100%').height('100%')
      }.padding({ top: 5, bottom: 5 }).width('100%').height(this.heightMD)

      Scroll() {
        Column() {
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
                  titleStr: "markdown全局上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginTopList,
                  allData: this.blockMarginTop
                })
                BaseTabComponent({
                  titleStr: "markdown全局右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginRightList,
                  allData: this.blockMarginRight
                })
                BaseTabComponent({
                  titleStr: "markdown全局下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginBottomList,
                  allData: this.blockMarginBottom
                })
                BaseTabComponent({
                  titleStr: "markdown全局左外边距 - ",
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

          // 视频基本属性
          Column() {
            Row() {
              Text("视频基本属性")
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
                  titleStr: "视频占位图 - ",
                  typeEnum: TypeEnum.IS_RESOURCE,
                  allListData: this.videoPlaceholderList,
                  allData: this.videoPlaceholder
                })
                BaseTabComponent({
                  titleStr: "视频图片缩放类型 - ",
                  typeEnum: TypeEnum.IS_IMAGE_FIT,
                  allListData: this.videoImageFitTypeList,
                  allData: this.videoImageFitType
                })
                BaseTabComponent({
                  titleStr: "视频上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoMarginTopList,
                  allData: this.videoMarginTop
                })
                BaseTabComponent({
                  titleStr: "视频右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoMarginRightList,
                  allData: this.videoMarginRight
                })
                BaseTabComponent({
                  titleStr: "视频下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoMarginBottomList,
                  allData: this.videoMarginBottom
                })
                BaseTabComponent({
                  titleStr: "视频左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoMarginLeftList,
                  allData: this.videoMarginLeft
                })
                BaseTabComponent({
                  titleStr: "视频上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoPaddingTopList,
                  allData: this.videoPaddingTop
                })
                BaseTabComponent({
                  titleStr: "视频右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoPaddingRightList,
                  allData: this.videoPaddingRight
                })
                BaseTabComponent({
                  titleStr: "视频下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoPaddingBottomList,
                  allData: this.videoPaddingBottom
                })
                BaseTabComponent({
                  titleStr: "视频左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoPaddingLeftList,
                  allData: this.videoPaddingLeft
                })
                BaseTabComponent({
                  titleStr: "视频边框左上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoRadiusTopLeftList,
                  allData: this.videoRadiusTopLeft
                })
                BaseTabComponent({
                  titleStr: "视频边框右上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoRadiusTopRightList,
                  allData: this.videoRadiusTopRight
                })
                BaseTabComponent({
                  titleStr: "视频边框左下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoRadiusBottomLeftList,
                  allData: this.videoRadiusBottomLeft
                })
                BaseTabComponent({
                  titleStr: "视频边框右下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoRadiusBottomRightList,
                  allData: this.videoRadiusBottomRight
                })
                BaseTabComponent({
                  titleStr: "视频边框样式 - ",
                  typeEnum: TypeEnum.IS_BORDER_STYLE,
                  allListData: this.videoBorderStyleList,
                  allData: this.videoBorderStyle
                })
                BaseTabComponent({
                  titleStr: "视频边框宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoBorderWidthList,
                  allData: this.videoBorderWidth
                })
                BaseTabComponent({
                  titleStr: "视频边框颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.videoBorderColorList,
                  allData: this.videoBorderColor
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

          // 播放按钮
          Column() {
            Row() {
              Text("播放按钮")
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
                  titleStr: "播放按钮图标 - ",
                  typeEnum: TypeEnum.IS_RESOURCE,
                  allListData: this.videoPlayIconList,
                  allData: this.videoPlayIcon
                })
                BaseTabComponent({
                  titleStr: "播放按钮图标宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoPlayIconWidthList,
                  allData: this.videoPlayIconWidth
                })
                BaseTabComponent({
                  titleStr: "播放按钮图标高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoPlayIconHeightList,
                  allData: this.videoPlayIconHeight
                })
                BaseTabComponent({
                  titleStr: "播放按钮图标缩放类型 - ",
                  typeEnum: TypeEnum.IS_IMAGE_FIT,
                  allListData: this.videoPlayIconFitTypeList,
                  allData: this.videoPlayIconFitType
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

          // 视频时间文本和底部布局
          Column() {
            Row() {
              Text("视频时间文本和底部布局")
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
                  titleStr: "视频时间文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.videoTimeTextFontColorList,
                  allData: this.videoTimeTextFontColor
                })
                BaseTabComponent({
                  titleStr: "视频时间文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoTimeTextFontSizeList,
                  allData: this.videoTimeTextFontSize
                })
                BaseTabComponent({
                  titleStr: "视频时间文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.videoTimeTextFontStyleList,
                  allData: this.videoTimeTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "视频时间文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.videoTimeTextFontWeightList,
                  allData: this.videoTimeTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "视频时间文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.videoTimeTextFontFamilyList,
                  allData: this.videoTimeTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "视频时间文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoTimeTextLineHeightList,
                  allData: this.videoTimeTextLineHeight
                })
                BaseTabComponent({
                  titleStr: "视频时间文本居右边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoTimeTextMarginRightList,
                  allData: this.videoTimeTextMarginRight
                })
                BaseTabComponent({
                  titleStr: "视频时间文本居底边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoTimeTextMarginBottomList,
                  allData: this.videoTimeTextMarginBottom
                })
                BaseTabComponent({
                  titleStr: "底部布局是否显示 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.videoBottomLayoutVisibleList,
                  allData: this.videoBottomLayoutVisible
                })
                BaseTabComponent({
                  titleStr: "底部布局距离视频上边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoBottomLayoutMarginTopList,
                  allData: this.videoBottomLayoutMarginTop
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

          // 发布按钮
          Column() {
            Row() {
              Text("发布按钮")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded5 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded5 = !this.isExpanded5
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded5 = !this.isExpanded5
            })

            if (this.isExpanded5) {
              Column() {
                BaseTabComponent({
                  titleStr: "视频发布按钮是否显示 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.videoReleaseButtonVisibleList,
                  allData: this.videoReleaseButtonVisible
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.videoReleaseButtonBackgroundColorList,
                  allData: this.videoReleaseButtonBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoReleaseButtonWidthList,
                  allData: this.videoReleaseButtonWidth
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoReleaseButtonHeightList,
                  allData: this.videoReleaseButtonHeight
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮左上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoReleaseButtonRadiusTopLeftList,
                  allData: this.videoReleaseButtonRadiusTopLeft
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮右上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoReleaseButtonRadiusTopRightList,
                  allData: this.videoReleaseButtonRadiusTopRight
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮左下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoReleaseButtonRadiusBottomLeftList,
                  allData: this.videoReleaseButtonRadiusBottomLeft
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮右下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoReleaseButtonRadiusBottomRightList,
                  allData: this.videoReleaseButtonRadiusBottomRight
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮图标和文本间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoReleaseButtonIconTextGapList,
                  allData: this.videoReleaseButtonIconTextGap
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮图标 - ",
                  typeEnum: TypeEnum.IS_RESOURCE,
                  allListData: this.videoReleaseButtonIconList,
                  allData: this.videoReleaseButtonIcon
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮图标宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoReleaseButtonIconWidthList,
                  allData: this.videoReleaseButtonIconWidth
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮图标高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoReleaseButtonIconHeightList,
                  allData: this.videoReleaseButtonIconHeight
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮默认文本内容 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.videoReleaseButtonTextList,
                  allData: this.videoReleaseButtonText
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.videoReleaseButtonTextFontColorList,
                  allData: this.videoReleaseButtonTextFontColor
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoReleaseButtonTextFontSizeList,
                  allData: this.videoReleaseButtonTextFontSize
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.videoReleaseButtonTextFontStyleList,
                  allData: this.videoReleaseButtonTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.videoReleaseButtonTextFontWeightList,
                  allData: this.videoReleaseButtonTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.videoReleaseButtonTextFontFamilyList,
                  allData: this.videoReleaseButtonTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "视频发布按钮文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoReleaseButtonTextLineHeightList,
                  allData: this.videoReleaseButtonTextLineHeight
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

          // 下载按钮
          Column() {
            Row() {
              Text("下载按钮")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded6 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded6 = !this.isExpanded6
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded6 = !this.isExpanded6
            })

            if (this.isExpanded6) {
              Column() {
                BaseTabComponent({
                  titleStr: "视频下载按钮是否显示 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.videoDownloadButtonVisibleList,
                  allData: this.videoDownloadButtonVisible
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.videoDownloadButtonBackgroundColorList,
                  allData: this.videoDownloadButtonBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoDownloadButtonWidthList,
                  allData: this.videoDownloadButtonWidth
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoDownloadButtonHeightList,
                  allData: this.videoDownloadButtonHeight
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮左上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoDownloadButtonRadiusTopLeftList,
                  allData: this.videoDownloadButtonRadiusTopLeft
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮右上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoDownloadButtonRadiusTopRightList,
                  allData: this.videoDownloadButtonRadiusTopRight
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮左下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoDownloadButtonRadiusBottomLeftList,
                  allData: this.videoDownloadButtonRadiusBottomLeft
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮右下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoDownloadButtonRadiusBottomRightList,
                  allData: this.videoDownloadButtonRadiusBottomRight
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮图标和文本间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoDownloadButtonIconTextGapList,
                  allData: this.videoDownloadButtonIconTextGap
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮图标 - ",
                  typeEnum: TypeEnum.IS_RESOURCE,
                  allListData: this.videoDownloadButtonIconList,
                  allData: this.videoDownloadButtonIcon
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮图标宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoDownloadButtonIconWidthList,
                  allData: this.videoDownloadButtonIconWidth
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮图标高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoDownloadButtonIconHeightList,
                  allData: this.videoDownloadButtonIconHeight
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮默认文本内容 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.videoDownloadButtonTextList,
                  allData: this.videoDownloadButtonText
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.videoDownloadButtonTextFontColorList,
                  allData: this.videoDownloadButtonTextFontColor
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoDownloadButtonTextFontSizeList,
                  allData: this.videoDownloadButtonTextFontSize
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.videoDownloadButtonTextFontStyleList,
                  allData: this.videoDownloadButtonTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.videoDownloadButtonTextFontWeightList,
                  allData: this.videoDownloadButtonTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.videoDownloadButtonTextFontFamilyList,
                  allData: this.videoDownloadButtonTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "视频下载按钮文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.videoDownloadButtonTextLineHeightList,
                  allData: this.videoDownloadButtonTextLineHeight
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