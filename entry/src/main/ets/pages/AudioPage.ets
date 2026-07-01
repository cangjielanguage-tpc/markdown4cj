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
  offsetListGeneralData,
  paddingListGeneralData,
  radiusListGeneraData,
  spaceListGeneralData,
  textLineHeightListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  timeListGeneralData,
  widthOrHeightListGeneralData
} from '../model/GeneralData'
import { AudioMDData } from '../model/AudioMDData'
import hilog from '@ohos.hilog'

@Entry
@Component
struct AudioPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') safeTop: number = 0 // 顶部导航栏高度
  // rawfile路径
  rawFilePath: string = "014_Audio"
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
  @State audioData: AudioMDData = new AudioMDData() // 配置数据内容
  // ---------------- 专有
  // 音频背景颜色列表
  audioBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State audioBackgroundColor: ResourceColor | undefined = undefined // 音频背景颜色
  // 音频上外边距列表
  audioMarginTopList: Array<number> = marginListGeneralData
  @State audioMarginTop: number = 0 // 音频上外边距
  // 音频右外边距列表
  audioMarginRightList: Array<number> = marginListGeneralData
  @State audioMarginRight: number = 0 // 音频右外边距
  // 音频下外边距列表
  audioMarginBottomList: Array<number> = marginListGeneralData
  @State audioMarginBottom: number = 0 // 音频下外边距
  // 音频左外边距列表
  audioMarginLeftList: Array<number> = marginListGeneralData
  @State audioMarginLeft: number = 0 // 音频左外边距
  // 音频上内边距列表
  audioPaddingTopList: Array<number> = paddingListGeneralData
  @State audioPaddingTop: number = 12 // 音频上内边距
  // 音频右内边距列表
  audioPaddingRightList: Array<number> = paddingListGeneralData
  @State audioPaddingRight: number = 16 // 音频右内边距
  // 音频下内边距列表
  audioPaddingBottomList: Array<number> = paddingListGeneralData
  @State audioPaddingBottom: number = 12 // 音频下内边距
  // 音频左内边距列表
  audioPaddingLeftList: Array<number> = paddingListGeneralData
  @State audioPaddingLeft: number = 12 // 音频左内边距
  // 音频边框样式列表
  audioBorderStyleList: Array<BorderStyle> = borderStyleListGeneraData
  @State audioBorderStyle: BorderStyle = BorderStyle.Solid // 音频边框样式
  // 音频边框宽度列表
  audioBorderWidthList: Array<number> = lineOrBorderWidthListGeneraData
  @State audioBorderWidth: number = 0.5 // 音频边框宽度
  // 音频边框颜色列表
  audioBorderColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State audioBorderColor: ResourceColor | undefined = '#33000000' // 音频边框颜色
  // 音频边框左上圆角列表
  audioRadiusTopLeftList: Array<number> = radiusListGeneraData
  @State audioRadiusTopLeft: number = 12 // 音频边框左上圆角
  // 音频边框右上圆角列表
  audioRadiusTopRightList: Array<number> = radiusListGeneraData
  @State audioRadiusTopRight: number = 12 // 音频边框右上圆角
  // 音频边框左下圆角列表
  audioRadiusBottomLeftList: Array<number> = radiusListGeneraData
  @State audioRadiusBottomLeft: number = 12 // 音频边框左下圆角
  // 音频边框右下圆角列表
  audioRadiusBottomRightList: Array<number> = radiusListGeneraData
  @State audioRadiusBottomRight: number = 12 // 音频边框右下圆角
  // 音频阴影模糊半径列表
  audioShadowRadiusList: Array<number> = radiusListGeneraData
  @State audioShadowRadius: number = 12 // 音频阴影模糊半径
  // 音频阴影X轴偏移量列表
  audioShadowOffsetXList: Array<number> = offsetListGeneralData
  @State audioShadowOffsetX: number = 0 // 音频阴影X轴偏移量
  // 音频阴影Y轴偏移量列表
  audioShadowOffsetYList: Array<number> = offsetListGeneralData
  @State audioShadowOffsetY: number = 2 // 音频阴影Y轴偏移量
  // 音频阴影颜色值列表
  audioShadowColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State audioShadowColor: ResourceColor | undefined = undefined // 音频阴影颜色值
  // 音频图标列表
  audioIconList: Array<Resource | undefined> = [undefined, $r('app.media.startIcon'), $r('app.media.app_icon')]
  @State audioIcon: Resource | undefined = undefined // 音频图标
  // 音频图标宽度列表
  audioIconWidthList: Array<number> = widthOrHeightListGeneralData
  @State audioIconWidth: number = 40 // 音频图标宽度
  // 音频图标高度列表
  audioIconHeightList: Array<number> = widthOrHeightListGeneralData
  @State audioIconHeight: number = 40 // 音频图标高度
  // 音频图标左上圆角列表
  audioIconRadiusTopLeftList: Array<number> = radiusListGeneraData
  @State audioIconRadiusTopLeft: number = 8 // 音频图标左上圆角
  // 音频图标右上圆角列表
  audioIconRadiusTopRightList: Array<number> = radiusListGeneraData
  @State audioIconRadiusTopRight: number = 8 // 音频图标右上圆角
  // 音频图标左下圆角列表
  audioIconRadiusBottomLeftList: Array<number> = radiusListGeneraData
  @State audioIconRadiusBottomLeft: number = 8 // 音频图标左下圆角
  // 音频图标右下圆角列表
  audioIconRadiusBottomRightList: Array<number> = radiusListGeneraData
  @State audioIconRadiusBottomRight: number = 8 // 音频图标右下圆角
  // 音频图标缩放类型列表
  audioIconFitTypeList: Array<ImageFit> = imageFitListData
  @State audioIconFitType: ImageFit = ImageFit.Contain // 音频图标缩放类型
  // 音频标题文本和类型文本间距列表
  audioTitleToTypeSpacingList: Array<number> = spaceListGeneralData
  @State audioTitleToTypeSpacing: number = 2 // 音频标题文本和类型文本间距
  // 音频按钮宽度列表
  audioButtonWidthList: Array<number> = widthOrHeightListGeneralData
  @State audioButtonWidth: number = 84 // 音频按钮宽度
  // 音频按钮高度列表
  audioButtonHeightList: Array<number> = widthOrHeightListGeneralData
  @State audioButtonHeight: number = 32 // 音频按钮高度
  // 音频按钮背景颜色列表
  audioButtonBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State audioButtonBackgroundColor: ResourceColor | undefined = '#FF000000' // 音频按钮背景颜色
  // 音频按钮边框样式列表
  audioButtonBorderStyleList: Array<BorderStyle> = borderStyleListGeneraData
  @State audioButtonBorderStyle: BorderStyle = BorderStyle.Solid // 音频按钮边框样式
  // 音频按钮边框宽度列表
  audioButtonBorderWidthList: Array<number> = lineOrBorderWidthListGeneraData
  @State audioButtonBorderWidth: number = 0 // 音频按钮边框宽度
  // 音频按钮边框颜色列表
  audioButtonBorderColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State audioButtonBorderColor: ResourceColor | undefined = undefined // 音频按钮边框颜色
  // 音频按钮边框左上圆角列表
  audioButtonRadiusTopLeftList: Array<number> = radiusListGeneraData
  @State audioButtonRadiusTopLeft: number = 16 // 音频按钮边框左上圆角
  // 音频按钮边框右上圆角列表
  audioButtonRadiusTopRightList: Array<number> = radiusListGeneraData
  @State audioButtonRadiusTopRight: number = 16 // 音频按钮边框右上圆角
  // 音频按钮边框左下圆角列表
  audioButtonRadiusBottomLeftList: Array<number> = radiusListGeneraData
  @State audioButtonRadiusBottomLeft: number = 16 // 音频按钮边框左下圆角
  // 音频按钮边框右下圆角列表
  audioButtonRadiusBottomRightList: Array<number> = radiusListGeneraData
  @State audioButtonRadiusBottomRight: number = 16 // 音频按钮边框右下圆角
  // 音频按钮默认文本内容列表
  audioButtonTextList: Array<string> = ['立即播放', '播放', '超长长长长长长长的按钮']
  @State audioButtonText: string = '立即播放' // 音频按钮默认文本内容
  // 音频按钮文本颜色列表
  audioButtonTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State audioButtonTextFontColor: ResourceColor | undefined = undefined // 音频按钮文本颜色
  // 音频按钮文本尺寸列表
  audioButtonTextFontSizeList: Array<number> = textSizeListGeneralData
  @State audioButtonTextFontSize: number = 14 // 音频按钮文本尺寸
  // 音频按钮文本字体样式列表
  audioButtonTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State audioButtonTextFontStyle: FontStyle = FontStyle.Normal // 音频按钮文本字体样式
  // 音频按钮文本字体粗细列表
  audioButtonTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State audioButtonTextFontWeight: FontWeight = FontWeight.Medium // 音频按钮文本字体粗细
  // 音频按钮文本字体列表
  audioButtonTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State audioButtonTextFontFamily: string = 'HarmonyOS Sans' // 音频按钮文本字体
  // 音频按钮文本行高列表
  audioButtonTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State audioButtonTextLineHeight: number = 22 // 音频按钮文本行高
  // 音频标题文本颜色列表
  audioTitleTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State audioTitleTextFontColor: ResourceColor | undefined = undefined // 音频标题文本颜色
  // 音频标题文本尺寸列表
  audioTitleTextFontSizeList: Array<number> = textSizeListGeneralData
  @State audioTitleTextFontSize: number = 15 // 音频标题文本尺寸
  // 音频标题文本字体样式列表
  audioTitleTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State audioTitleTextFontStyle: FontStyle = FontStyle.Normal // 音频标题文本字体样式
  // 音频标题文本字体粗细列表
  audioTitleTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State audioTitleTextFontWeight: FontWeight = FontWeight.Bold // 音频标题文本字体粗细
  // 音频标题文本字体列表
  audioTitleTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State audioTitleTextFontFamily: string = 'HarmonyOS Sans' // 音频标题文本字体
  // 音频标题文本行高列表
  audioTitleTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State audioTitleTextLineHeight: number = 20 // 音频标题文本行高
  // 音频类型文本颜色列表
  audioTypeTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State audioTypeTextFontColor: ResourceColor | undefined = '#80000000' // 音频类型文本颜色
  // 音频类型文本尺寸列表
  audioTypeTextFontSizeList: Array<number> = textSizeListGeneralData
  @State audioTypeTextFontSize: number = 11 // 音频类型文本尺寸
  // 音频类型文本字体样式列表
  audioTypeTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State audioTypeTextFontStyle: FontStyle = FontStyle.Normal // 音频类型文本字体样式
  // 音频类型文本字体粗细列表
  audioTypeTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State audioTypeTextFontWeight: FontWeight = FontWeight.Normal // 音频类型文本字体粗细
  // 音频类型文本字体列表
  audioTypeTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State audioTypeTextFontFamily: string = 'HarmonyOS Sans' // 音频类型文本字体
  // 音频类型文本行高列表
  audioTypeTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State audioTypeTextLineHeight: number = 15 // 音频类型文本行高
  heightMD: number = 30 * 1 // 乘以行数
  @State isExpanded1: boolean = false // 控制展开/折叠状态 - 通用样式配置
  @State isExpanded2: boolean = false // 控制展开/折叠状态 - 音频边距和边框
  @State isExpanded3: boolean = false // 控制展开/折叠状态 - 音频图标和其他
  @State isExpanded4: boolean = false // 控制展开/折叠状态 - 音频按钮
  @State isExpanded5: boolean = false // 控制展开/折叠状态 - 音频标题和类型文本

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "音频配置页面",
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
                  this.audioData._isFull = this.isFull
                  this.audioData._incrementalAnalysis = this.incrementalAnalysis
                  this.audioData._time = this.time
                  this.audioData._textNumber = this.textNumber
                  this.audioData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.audioData._isOnCopy = this.isOnCopy
                  this.audioData._blockMarginTop = this.blockMarginTop
                  this.audioData._blockMarginRight = this.blockMarginRight
                  this.audioData._blockMarginBottom = this.blockMarginBottom
                  this.audioData._blockMarginLeft = this.blockMarginLeft
                  this.audioData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.audioData._isLineBreak = this.isLineBreak
                  this.audioData._backgroundColor = this.globalBackgroundColor
                  this.audioData._openGestureSwipe = this.openGestureSwipe
                  this.audioData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.audioData._pagePath = `${this.rawFilePath}/${item}`

                  // ---------- 专有
                  this.audioData.audioBackgroundColor = this.audioBackgroundColor
                  this.audioData.audioMarginTop = this.audioMarginTop
                  this.audioData.audioMarginRight = this.audioMarginRight
                  this.audioData.audioMarginBottom = this.audioMarginBottom
                  this.audioData.audioMarginLeft = this.audioMarginLeft
                  this.audioData.audioPaddingTop = this.audioPaddingTop
                  this.audioData.audioPaddingRight = this.audioPaddingRight
                  this.audioData.audioPaddingBottom = this.audioPaddingBottom
                  this.audioData.audioPaddingLeft = this.audioPaddingLeft
                  this.audioData.audioBorderStyle = this.audioBorderStyle
                  this.audioData.audioBorderWidth = this.audioBorderWidth
                  this.audioData.audioBorderColor = this.audioBorderColor
                  this.audioData.audioRadiusTopLeft = this.audioRadiusTopLeft
                  this.audioData.audioRadiusTopRight = this.audioRadiusTopRight
                  this.audioData.audioRadiusBottomLeft = this.audioRadiusBottomLeft
                  this.audioData.audioRadiusBottomRight = this.audioRadiusBottomRight
                  this.audioData.audioShadowRadius = this.audioShadowRadius
                  this.audioData.audioShadowOffsetX = this.audioShadowOffsetX
                  this.audioData.audioShadowOffsetY = this.audioShadowOffsetY
                  this.audioData.audioShadowColor = this.audioShadowColor
                  this.audioData.audioIcon = this.audioIcon
                  this.audioData.audioIconWidth = this.audioIconWidth
                  this.audioData.audioIconHeight = this.audioIconHeight
                  this.audioData.audioIconRadiusTopLeft = this.audioIconRadiusTopLeft
                  this.audioData.audioIconRadiusTopRight = this.audioIconRadiusTopRight
                  this.audioData.audioIconRadiusBottomLeft = this.audioIconRadiusBottomLeft
                  this.audioData.audioIconRadiusBottomRight = this.audioIconRadiusBottomRight
                  this.audioData.audioIconFitType = this.audioIconFitType
                  this.audioData.audioTitleToTypeSpacing = this.audioTitleToTypeSpacing
                  this.audioData.audioButtonWidth = this.audioButtonWidth
                  this.audioData.audioButtonHeight = this.audioButtonHeight
                  this.audioData.audioButtonBackgroundColor = this.audioButtonBackgroundColor
                  this.audioData.audioButtonBorderStyle = this.audioButtonBorderStyle
                  this.audioData.audioButtonBorderWidth = this.audioButtonBorderWidth
                  this.audioData.audioButtonBorderColor = this.audioButtonBorderColor
                  this.audioData.audioButtonRadiusTopLeft = this.audioButtonRadiusTopLeft
                  this.audioData.audioButtonRadiusTopRight = this.audioButtonRadiusTopRight
                  this.audioData.audioButtonRadiusBottomLeft = this.audioButtonRadiusBottomLeft
                  this.audioData.audioButtonRadiusBottomRight = this.audioButtonRadiusBottomRight
                  this.audioData.audioButtonText = this.audioButtonText
                  this.audioData.audioButtonTextFontColor = this.audioButtonTextFontColor
                  this.audioData.audioButtonTextFontSize = this.audioButtonTextFontSize
                  this.audioData.audioButtonTextFontStyle = this.audioButtonTextFontStyle
                  this.audioData.audioButtonTextFontWeight = this.audioButtonTextFontWeight
                  this.audioData.audioButtonTextFontFamily = this.audioButtonTextFontFamily
                  this.audioData.audioButtonTextLineHeight = this.audioButtonTextLineHeight
                  this.audioData.audioTitleTextFontColor = this.audioTitleTextFontColor
                  this.audioData.audioTitleTextFontSize = this.audioTitleTextFontSize
                  this.audioData.audioTitleTextFontStyle = this.audioTitleTextFontStyle
                  this.audioData.audioTitleTextFontWeight = this.audioTitleTextFontWeight
                  this.audioData.audioTitleTextFontFamily = this.audioTitleTextFontFamily
                  this.audioData.audioTitleTextLineHeight = this.audioTitleTextLineHeight
                  this.audioData.audioTypeTextFontColor = this.audioTypeTextFontColor
                  this.audioData.audioTypeTextFontSize = this.audioTypeTextFontSize
                  this.audioData.audioTypeTextFontStyle = this.audioTypeTextFontStyle
                  this.audioData.audioTypeTextFontWeight = this.audioTypeTextFontWeight
                  this.audioData.audioTypeTextFontFamily = this.audioTypeTextFontFamily
                  this.audioData.audioTypeTextLineHeight = this.audioTypeTextLineHeight
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/AudioDetailsPage", params: this.audioData })
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

          // 音频边距和边框
          Column() {
            Row() {
              Text("音频边距和边框")
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
                  titleStr: "音频背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.audioBackgroundColorList,
                  allData: this.audioBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "音频上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioMarginTopList,
                  allData: this.audioMarginTop
                })
                BaseTabComponent({
                  titleStr: "音频右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioMarginRightList,
                  allData: this.audioMarginRight
                })
                BaseTabComponent({
                  titleStr: "音频下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioMarginBottomList,
                  allData: this.audioMarginBottom
                })
                BaseTabComponent({
                  titleStr: "音频左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioMarginLeftList,
                  allData: this.audioMarginLeft
                })
                BaseTabComponent({
                  titleStr: "音频上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioPaddingTopList,
                  allData: this.audioPaddingTop
                })
                BaseTabComponent({
                  titleStr: "音频右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioPaddingRightList,
                  allData: this.audioPaddingRight
                })
                BaseTabComponent({
                  titleStr: "音频下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioPaddingBottomList,
                  allData: this.audioPaddingBottom
                })
                BaseTabComponent({
                  titleStr: "音频左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioPaddingLeftList,
                  allData: this.audioPaddingLeft
                })
                BaseTabComponent({
                  titleStr: "音频边框样式 - ",
                  typeEnum: TypeEnum.IS_BORDER_STYLE,
                  allListData: this.audioBorderStyleList,
                  allData: this.audioBorderStyle
                })
                BaseTabComponent({
                  titleStr: "音频边框宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioBorderWidthList,
                  allData: this.audioBorderWidth
                })
                BaseTabComponent({
                  titleStr: "音频边框颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.audioBorderColorList,
                  allData: this.audioBorderColor
                })
                BaseTabComponent({
                  titleStr: "音频边框左上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioRadiusTopLeftList,
                  allData: this.audioRadiusTopLeft
                })
                BaseTabComponent({
                  titleStr: "音频边框右上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioRadiusTopRightList,
                  allData: this.audioRadiusTopRight
                })
                BaseTabComponent({
                  titleStr: "音频边框左下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioRadiusBottomLeftList,
                  allData: this.audioRadiusBottomLeft
                })
                BaseTabComponent({
                  titleStr: "音频边框右下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioRadiusBottomRightList,
                  allData: this.audioRadiusBottomRight
                })
                BaseTabComponent({
                  titleStr: "音频阴影模糊半径 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioShadowRadiusList,
                  allData: this.audioShadowRadius
                })
                BaseTabComponent({
                  titleStr: "音频阴影X轴偏移量 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioShadowOffsetXList,
                  allData: this.audioShadowOffsetX
                })
                BaseTabComponent({
                  titleStr: "音频阴影Y轴偏移量 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioShadowOffsetYList,
                  allData: this.audioShadowOffsetY
                })
                BaseTabComponent({
                  titleStr: "音频阴影颜色值 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.audioShadowColorList,
                  allData: this.audioShadowColor
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

          // 音频图标和其他
          Column() {
            Row() {
              Text("音频图标和其他")
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
                  titleStr: "音频图标 - ",
                  typeEnum: TypeEnum.IS_RESOURCE,
                  allListData: this.audioIconList,
                  allData: this.audioIcon
                })
                BaseTabComponent({
                  titleStr: "音频图标宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioIconWidthList,
                  allData: this.audioIconWidth
                })
                BaseTabComponent({
                  titleStr: "音频图标高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioIconHeightList,
                  allData: this.audioIconHeight
                })
                BaseTabComponent({
                  titleStr: "音频图标左上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioIconRadiusTopLeftList,
                  allData: this.audioIconRadiusTopLeft
                })
                BaseTabComponent({
                  titleStr: "音频图标右上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioIconRadiusTopRightList,
                  allData: this.audioIconRadiusTopRight
                })
                BaseTabComponent({
                  titleStr: "音频图标左下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioIconRadiusBottomLeftList,
                  allData: this.audioIconRadiusBottomLeft
                })
                BaseTabComponent({
                  titleStr: "音频图标右下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioIconRadiusBottomRightList,
                  allData: this.audioIconRadiusBottomRight
                })
                BaseTabComponent({
                  titleStr: "音频图标缩放类型 - ",
                  typeEnum: TypeEnum.IS_IMAGE_FIT,
                  allListData: this.audioIconFitTypeList,
                  allData: this.audioIconFitType
                })
                BaseTabComponent({
                  titleStr: "音频标题文本和类型文本间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioTitleToTypeSpacingList,
                  allData: this.audioTitleToTypeSpacing
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

          // 音频按钮
          Column() {
            Row() {
              Text("音频按钮")
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
                  titleStr: "音频按钮背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.audioButtonBackgroundColorList,
                  allData: this.audioButtonBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "音频按钮宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioButtonWidthList,
                  allData: this.audioButtonWidth
                })
                BaseTabComponent({
                  titleStr: "音频按钮高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioButtonHeightList,
                  allData: this.audioButtonHeight
                })
                BaseTabComponent({
                  titleStr: "音频按钮边框样式 - ",
                  typeEnum: TypeEnum.IS_BORDER_STYLE,
                  allListData: this.audioButtonBorderStyleList,
                  allData: this.audioButtonBorderStyle
                })
                BaseTabComponent({
                  titleStr: "音频按钮边框宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioButtonBorderWidthList,
                  allData: this.audioButtonBorderWidth
                })
                BaseTabComponent({
                  titleStr: "音频按钮边框颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.audioButtonBorderColorList,
                  allData: this.audioButtonBorderColor
                })
                BaseTabComponent({
                  titleStr: "音频按钮边框左上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioButtonRadiusTopLeftList,
                  allData: this.audioButtonRadiusTopLeft
                })
                BaseTabComponent({
                  titleStr: "音频按钮边框右上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioButtonRadiusTopRightList,
                  allData: this.audioButtonRadiusTopRight
                })
                BaseTabComponent({
                  titleStr: "音频按钮边框左下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioButtonRadiusBottomLeftList,
                  allData: this.audioButtonRadiusBottomLeft
                })
                BaseTabComponent({
                  titleStr: "音频按钮边框右下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioButtonRadiusBottomRightList,
                  allData: this.audioButtonRadiusBottomRight
                })
                BaseTabComponent({
                  titleStr: "音频按钮默认文本内容 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.audioButtonTextList,
                  allData: this.audioButtonText
                })
                BaseTabComponent({
                  titleStr: "音频按钮文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.audioButtonTextFontColorList,
                  allData: this.audioButtonTextFontColor
                })
                BaseTabComponent({
                  titleStr: "音频按钮文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioButtonTextFontSizeList,
                  allData: this.audioButtonTextFontSize
                })
                BaseTabComponent({
                  titleStr: "音频按钮文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.audioButtonTextFontStyleList,
                  allData: this.audioButtonTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "音频按钮文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.audioButtonTextFontWeightList,
                  allData: this.audioButtonTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "音频按钮文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.audioButtonTextFontFamilyList,
                  allData: this.audioButtonTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "音频按钮文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioButtonTextLineHeightList,
                  allData: this.audioButtonTextLineHeight
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

          // 音频标题和类型文本
          Column() {
            Row() {
              Text("音频标题和类型文本")
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
                  titleStr: "音频标题文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.audioTitleTextFontColorList,
                  allData: this.audioTitleTextFontColor
                })
                BaseTabComponent({
                  titleStr: "音频标题文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioTitleTextFontSizeList,
                  allData: this.audioTitleTextFontSize
                })
                BaseTabComponent({
                  titleStr: "音频标题文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.audioTitleTextFontStyleList,
                  allData: this.audioTitleTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "音频标题文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.audioTitleTextFontWeightList,
                  allData: this.audioTitleTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "音频标题文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.audioTitleTextFontFamilyList,
                  allData: this.audioTitleTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "音频标题文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioTitleTextLineHeightList,
                  allData: this.audioTitleTextLineHeight
                })
                BaseTabComponent({
                  titleStr: "音频类型文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.audioTypeTextFontColorList,
                  allData: this.audioTypeTextFontColor
                })
                BaseTabComponent({
                  titleStr: "音频类型文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioTypeTextFontSizeList,
                  allData: this.audioTypeTextFontSize
                })
                BaseTabComponent({
                  titleStr: "音频类型文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.audioTypeTextFontStyleList,
                  allData: this.audioTypeTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "音频类型文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.audioTypeTextFontWeightList,
                  allData: this.audioTypeTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "音频类型文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.audioTypeTextFontFamilyList,
                  allData: this.audioTypeTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "音频类型文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.audioTypeTextLineHeightList,
                  allData: this.audioTypeTextLineHeight
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