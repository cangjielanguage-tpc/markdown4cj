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
  imageFitTypeListData,
  lineOrBorderWidthListGeneraData,
  marginListGeneralData,
  radiusListGeneraData,
  spaceListGeneralData,
  textLineHeightListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  timeListGeneralData,
  widthOrHeightListGeneralData
} from '../model/GeneralData'
import { VideoData } from '../model/VideoData'
import { ImageFitType } from '@cangjie-tpc/markdown_hybrid'

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
  globalBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State globalBackgroundColor: number | undefined = undefined // 背景颜色
  // 是否允许markdown控件自身响应滑动列表
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  @State openGestureSwipe: boolean = false // 是否允许markdown控件自身响应滑动
  // 是否开启响应滑动测试列表
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  @State openGestureSwipeTest: boolean = false // 是否开启响应滑动测试

  // ---------------- 专有
  // 视频背景颜色列表
  videoBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State videoBackgroundColor: number | undefined = undefined // 视频背景颜色
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
  videoBorderColorList: Array<number | undefined> = colorListGeneralData
  @State videoBorderColor: number | undefined = undefined // 视频边框颜色
  // 视频占位图
  videoPlaceholder: Resource | undefined = undefined
  // 视频图片缩放类型列表
  videoImageFitTypeList: Array<ImageFit> = imageFitListData
  @State videoImageFitType: ImageFit = ImageFit.Contain // 视频图片缩放类型
  // 播放按钮默认图片
  videoPlayIcon: Resource | undefined = undefined
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
  videoTimeTextFontColorList: Array<number | undefined> = colorListGeneralData
  @State videoTimeTextFontColor: number | undefined = undefined // 视频时间文本颜色
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
  videoReleaseButtonBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State videoReleaseButtonBackgroundColor: number | undefined = undefined // 视频发布按钮背景颜色
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
  // 视频发布按钮图标
  videoReleaseButtonIcon: Resource | undefined = undefined
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
  videoReleaseButtonTextFontColorList: Array<number | undefined> = colorListGeneralData
  @State videoReleaseButtonTextFontColor: number | undefined = undefined // 视频发布按钮文本颜色
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
  videoDownloadButtonBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State videoDownloadButtonBackgroundColor: number | undefined = undefined // 视频下载按钮背景颜色
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
  // 视频下载按钮图标
  videoDownloadButtonIcon: Resource | undefined = undefined
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
  videoDownloadButtonTextFontColorList: Array<number | undefined> = colorListGeneralData
  @State videoDownloadButtonTextFontColor: number | undefined = undefined // 视频下载按钮文本颜色
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
      Scroll() {
        Column() {
          // ------------ 通用
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

          // ---------------- 专有
          BaseTabComponent({
            titleStr: "视频背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.videoBackgroundColorList,
            allData: this.videoBackgroundColor
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
          BaseTabComponent({
            titleStr: "视频图片缩放类型 - ",
            typeEnum: TypeEnum.IS_IMAGE_FIT,
            allListData: this.videoImageFitTypeList,
            allData: this.videoImageFitType
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

          // 列表显示
          List() {
            ForEach(this.folderList, (item: string, index: number) => {
              ListItem() {
                Button(`${index + 1}、${item}`)
                  .height(40)
                  .width('80%')
                  .type(ButtonType.Capsule)
                  .fontColor(0xFFFFFFFF)
                  .backgroundColor(0xFF317AFF)
                  .margin({ top: 5, bottom: 5 })
                  .align(Alignment.Center)
                  .fontSize(16)
                  .onClick(() => {
                    // ---------- 通用
                    this.videoData.isFull = this.isFull
                    this.videoData.incrementalAnalysis = this.incrementalAnalysis
                    this.videoData.time = this.time
                    this.videoData.textNumber = this.textNumber
                    this.videoData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.videoData.isOnCopy = this.isOnCopy
                    this.videoData.blockMarginTop = this.blockMarginTop
                    this.videoData.blockMarginRight = this.blockMarginRight
                    this.videoData.blockMarginBottom = this.blockMarginBottom
                    this.videoData.blockMarginLeft = this.blockMarginLeft
                    this.videoData.markdownBlockSpacing = this.markdownBlockSpacing
                    this.videoData.isLineBreak = this.isLineBreak
                    this.videoData.backgroundColor = this.globalBackgroundColor
                    this.videoData.openGestureSwipe = this.openGestureSwipe
                    this.videoData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.videoData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有 - 视频基本属性
                    this.videoData.videoBackgroundColor = this.videoBackgroundColor
                    this.videoData.videoMarginTop = this.videoMarginTop
                    this.videoData.videoMarginRight = this.videoMarginRight
                    this.videoData.videoMarginBottom = this.videoMarginBottom
                    this.videoData.videoMarginLeft = this.videoMarginLeft
                    this.videoData.videoPaddingTop = this.videoPaddingTop
                    this.videoData.videoPaddingRight = this.videoPaddingRight
                    this.videoData.videoPaddingBottom = this.videoPaddingBottom
                    this.videoData.videoPaddingLeft = this.videoPaddingLeft
                    this.videoData.videoRadiusTopLeft = this.videoRadiusTopLeft
                    this.videoData.videoRadiusTopRight = this.videoRadiusTopRight
                    this.videoData.videoRadiusBottomLeft = this.videoRadiusBottomLeft
                    this.videoData.videoRadiusBottomRight = this.videoRadiusBottomRight
                    this.videoData.videoBorderStyle = this.videoBorderStyle
                    this.videoData.videoBorderWidth = this.videoBorderWidth
                    this.videoData.videoBorderColor = this.videoBorderColor
                    this.videoData.videoPlaceholder = this.videoPlaceholder
                    this.videoData.videoImageFitType = this.videoImageFitType
                    this.videoData.videoPlayIcon = this.videoPlayIcon
                    this.videoData.videoPlayIconWidth = this.videoPlayIconWidth
                    this.videoData.videoPlayIconHeight = this.videoPlayIconHeight
                    this.videoData.videoPlayIconFitType = this.videoPlayIconFitType
                    // ---------- 专有 - 视频时间文本
                    this.videoData.videoTimeTextFontColor = this.videoTimeTextFontColor
                    this.videoData.videoTimeTextFontSize = this.videoTimeTextFontSize
                    this.videoData.videoTimeTextFontStyle = this.videoTimeTextFontStyle
                    this.videoData.videoTimeTextFontWeight = this.videoTimeTextFontWeight
                    this.videoData.videoTimeTextFontFamily = this.videoTimeTextFontFamily
                    this.videoData.videoTimeTextLineHeight = this.videoTimeTextLineHeight
                    this.videoData.videoTimeTextMarginRight = this.videoTimeTextMarginRight
                    this.videoData.videoTimeTextMarginBottom = this.videoTimeTextMarginBottom
                    // ---------- 专有 - 底部布局
                    this.videoData.videoBottomLayoutVisible = this.videoBottomLayoutVisible
                    this.videoData.videoBottomLayoutMarginTop = this.videoBottomLayoutMarginTop
                    // ---------- 专有 - 发布按钮
                    this.videoData.videoReleaseButtonVisible = this.videoReleaseButtonVisible
                    this.videoData.videoReleaseButtonBackgroundColor = this.videoReleaseButtonBackgroundColor
                    this.videoData.videoReleaseButtonWidth = this.videoReleaseButtonWidth
                    this.videoData.videoReleaseButtonHeight = this.videoReleaseButtonHeight
                    this.videoData.videoReleaseButtonRadiusTopLeft = this.videoReleaseButtonRadiusTopLeft
                    this.videoData.videoReleaseButtonRadiusTopRight = this.videoReleaseButtonRadiusTopRight
                    this.videoData.videoReleaseButtonRadiusBottomLeft = this.videoReleaseButtonRadiusBottomLeft
                    this.videoData.videoReleaseButtonRadiusBottomRight = this.videoReleaseButtonRadiusBottomRight
                    this.videoData.videoReleaseButtonIconTextGap = this.videoReleaseButtonIconTextGap
                    this.videoData.videoReleaseButtonIcon = this.videoReleaseButtonIcon
                    this.videoData.videoReleaseButtonIconWidth = this.videoReleaseButtonIconWidth
                    this.videoData.videoReleaseButtonIconHeight = this.videoReleaseButtonIconHeight
                    this.videoData.videoReleaseButtonText = this.videoReleaseButtonText
                    this.videoData.videoReleaseButtonTextFontColor = this.videoReleaseButtonTextFontColor
                    this.videoData.videoReleaseButtonTextFontSize = this.videoReleaseButtonTextFontSize
                    this.videoData.videoReleaseButtonTextFontStyle = this.videoReleaseButtonTextFontStyle
                    this.videoData.videoReleaseButtonTextFontWeight = this.videoReleaseButtonTextFontWeight
                    this.videoData.videoReleaseButtonTextFontFamily = this.videoReleaseButtonTextFontFamily
                    this.videoData.videoReleaseButtonTextLineHeight = this.videoReleaseButtonTextLineHeight
                    // ---------- 专有 - 下载按钮
                    this.videoData.videoDownloadButtonVisible = this.videoDownloadButtonVisible
                    this.videoData.videoDownloadButtonBackgroundColor = this.videoDownloadButtonBackgroundColor
                    this.videoData.videoDownloadButtonWidth = this.videoDownloadButtonWidth
                    this.videoData.videoDownloadButtonHeight = this.videoDownloadButtonHeight
                    this.videoData.videoDownloadButtonRadiusTopLeft = this.videoDownloadButtonRadiusTopLeft
                    this.videoData.videoDownloadButtonRadiusTopRight = this.videoDownloadButtonRadiusTopRight
                    this.videoData.videoDownloadButtonRadiusBottomLeft = this.videoDownloadButtonRadiusBottomLeft
                    this.videoData.videoDownloadButtonRadiusBottomRight = this.videoDownloadButtonRadiusBottomRight
                    this.videoData.videoDownloadButtonIconTextGap = this.videoDownloadButtonIconTextGap
                    this.videoData.videoDownloadButtonIcon = this.videoDownloadButtonIcon
                    this.videoData.videoDownloadButtonIconWidth = this.videoDownloadButtonIconWidth
                    this.videoData.videoDownloadButtonIconHeight = this.videoDownloadButtonIconHeight
                    this.videoData.videoDownloadButtonText = this.videoDownloadButtonText
                    this.videoData.videoDownloadButtonTextFontColor = this.videoDownloadButtonTextFontColor
                    this.videoData.videoDownloadButtonTextFontSize = this.videoDownloadButtonTextFontSize
                    this.videoData.videoDownloadButtonTextFontStyle = this.videoDownloadButtonTextFontStyle
                    this.videoData.videoDownloadButtonTextFontWeight = this.videoDownloadButtonTextFontWeight
                    this.videoData.videoDownloadButtonTextFontFamily = this.videoDownloadButtonTextFontFamily
                    this.videoData.videoDownloadButtonTextLineHeight = this.videoDownloadButtonTextLineHeight
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/VideoDetailsPage", params: this.videoData })
                  })
              }
            })
          }
          .alignListItem(ListItemAlign.Center)
        }
        .padding({ bottom: 100 })
      }
    }
    .backgroundColor(0xFFEAEAEA)
    .height("100%")
  }
}


