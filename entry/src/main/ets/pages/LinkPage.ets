import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import {
  booleanListGeneralData,
  colorListGeneralData,
  fontStyleListGeneraData,
  fontWeightListGeneraData,
  lineOrBorderWidthListGeneraData,
  marginListGeneralData,
  radiusListGeneraData,
  textDecorationStyleListGeneralData,
  textDecorationTypeListGeneralData,
  textLineHeightListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  textWordSpaceListGeneralData,
  timeListGeneralData,
  widthOrHeightListGeneralData
} from '../model/GeneralData'
import { LinkData } from '../model/LinkData'

@Entry
@Component
struct LinkPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "007_Link"
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
  blockMarginRight: number = 8
  // Markdown全局下外边距列表
  blockMarginBottomList: Array<number> = marginListGeneralData
  @State // Markdown全局下外边距
  blockMarginBottom: number = 8
  // Markdown全局左外边距列表
  blockMarginLeftList: Array<number> = marginListGeneralData
  @State // Markdown全局左外边距
  blockMarginLeft: number = 8
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
  // 链接是否是图片显示列表
  linkIsIconList: Array<boolean> = booleanListGeneralData
  @State // 链接是否是图片显示
  linkIsIcon: boolean = false
  // 列表中的单行链接是否是图片显示列表
  linkListIsIconList: Array<boolean> = booleanListGeneralData
  @State // 列表中的单行链接是否是图片显示
  linkListIsIcon: boolean = false
  // 文本格式链接文本颜色列表
  linkTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 文本格式链接文本颜色
  linkTextFontColor: ResourceColor | undefined = undefined
  // 文本格式链接文字大小列表
  linkTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 文本格式链接文字大小
  linkTextFontSize: number | undefined = undefined
  // 文本格式链接背景颜色列表
  linkTextBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 文本格式链接背景颜色
  linkTextBackgroundColor: ResourceColor | undefined = undefined
  // 圆形图片格式链接主题背景颜色列表
  linkCircleIconBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 圆形图片格式链接主题背景颜色
  linkCircleIconBackgroundColor: ResourceColor | undefined = undefined
  // 圆形图片格式链接控件背景颜色列表
  linkCircleIconButtonBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 圆形图片格式链接控件背景颜色
  linkCircleIconButtonBackgroundColor: ResourceColor | undefined = undefined
  // 圆形图片格式链接文字大小列表
  linkCircleIconTextSizeList: Array<number> = textSizeListGeneralData
  @State // 圆形图片格式链接文字大小
  linkCircleIconTextSize: number = 14
  // 圆形图片格式链接文字颜色列表
  linkCircleIconTextColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 圆形图片格式链接文字颜色
  linkCircleIconTextColor: ResourceColor | undefined = undefined
  // 圆形图片格式链接半径列表
  linkCircleIconRadiusList: Array<number> = radiusListGeneraData
  @State // 圆形图片格式链接半径
  linkCircleIconRadius: number = 20
  // 圆形图片格式链接左右外边距列表
  linkCircleIconMarginList: Array<number> = textWordSpaceListGeneralData
  @State // 圆形图片格式链接左右外边距
  linkCircleIconMargin: number = 6
  // 圆角矩形图片格式链接主题背景颜色列表
  linkRectIconBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 圆角矩形图片格式链接主题背景颜色
  linkRectIconBackgroundColor: ResourceColor | undefined = undefined
  // 圆角矩形图片格式链接控件背景颜色列表
  linkRectIconButtonBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 圆角矩形图片格式链接控件背景颜色
  linkRectIconButtonBackgroundColor: ResourceColor | undefined = undefined
  // 圆角矩形图片格式链接文字大小列表
  linkRectIconTextSizeList: Array<number> = textSizeListGeneralData
  @State // 圆角矩形图片格式链接文字大小
  linkRectIconTextSize: number = 14
  // 圆角矩形图片格式链接文字颜色列表
  linkRectIconTextColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 圆角矩形图片格式链接文字颜色
  linkRectIconTextColor: ResourceColor | undefined = undefined
  // 圆角矩形图片格式链接控件高度列表
  linkRectIconHeightList: Array<number> = widthOrHeightListGeneralData
  @State // 圆角矩形图片格式链接控件高度
  linkRectIconHeight: number = 20
  // 圆角矩形图片格式链接左右内边距列表
  linkRectIconPaddingList: Array<number> = textWordSpaceListGeneralData
  @State // 圆角矩形图片格式链接左右内边距
  linkRectIconPadding: number = 6
  // 圆角矩形图片格式链接圆角半径列表
  linkRectIconRadiusList: Array<number> = radiusListGeneraData
  @State // 圆角矩形图片格式链接圆角半径
  linkRectIconRadius: number = 6
  // 圆角矩形图片格式链接左右外边距列表
  linkRectIconMarginList: Array<number> = textWordSpaceListGeneralData
  @State // 圆角矩形图片格式链接左右外边距
  linkRectIconMargin: number = 6
  // 空心圆角矩形图片格式链接主题背景颜色列表
  linkRectToolIconBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 空心圆角矩形图片格式链接主题背景颜色
  linkRectToolIconBackgroundColor: ResourceColor | undefined = undefined
  // 空心圆角矩形图片格式链接控件背景颜色列表
  linkRectToolIconButtonBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 空心圆角矩形图片格式链接控件背景颜色
  linkRectToolIconButtonBackgroundColor: ResourceColor | undefined = undefined
  // 空心圆角矩形图片格式链接文字大小列表
  linkRectToolIconTextSizeList: Array<number> = textSizeListGeneralData
  @State // 空心圆角矩形图片格式链接文字大小
  linkRectToolIconTextSize: number = 14
  // 空心圆角矩形图片格式链接控件高度列表
  linkRectToolIconHeightList: Array<number> = widthOrHeightListGeneralData
  @State // 空心圆角矩形图片格式链接控件高度
  linkRectToolIconHeight: number = 21
  // 空心圆角矩形图片格式链接左右内边距列表
  linkRectToolIconPaddingList: Array<number> = textWordSpaceListGeneralData
  @State // 空心圆角矩形图片格式链接左右内边距
  linkRectToolIconPadding: number = 6
  // 空心圆角矩形图片格式链接边框宽度列表
  linkRectToolIconBorderWidthList: Array<number> = lineOrBorderWidthListGeneraData
  @State // 空心圆角矩形图片格式链接边框宽度
  linkRectToolIconBorderWidth: number = 1
  // 空心圆角矩形图片格式链接分割线宽度列表
  linkRectToolIconDividingLineWidthList: Array<number> = lineOrBorderWidthListGeneraData
  @State // 空心圆角矩形图片格式链接分割线宽度
  linkRectToolIconDividingLineWidth: number = 1
  // 空心圆角矩形图片格式链接左右外边距列表
  linkRectToolIconMarginList: Array<number> = textWordSpaceListGeneralData
  @State // 空心圆角矩形图片格式链接左右外边距
  linkRectToolIconMargin: number = 6
  // 空心圆角矩形图片格式链接左右外边距列表
  linkRectToolIconLineLeftPaddingList: Array<number> = textWordSpaceListGeneralData
  @State // 空心圆角矩形图片格式链接左右外边距
  linkRectToolIconLineLeftPadding: number = 3
  // 空心圆角矩形图片格式链接左右外边距列表
  linkRectToolIconLineRightPaddingList: Array<number> = textWordSpaceListGeneralData
  @State // 空心圆角矩形图片格式链接左右外边距
  linkRectToolIconLineRightPadding: number = 3
  // 文本格式链接文字行高列表
  linkTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State // 文本格式链接文字行高
  linkTextLineHeight: number | undefined = undefined
  // 链接文本字体样式列表
  linkTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 链接文本字体样式
  linkTextFontStyle: FontStyle = FontStyle.Normal
  // 链接文本字体粗细列表
  linkTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 链接文本字体粗细
  linkTextFontWeight: FontWeight = FontWeight.Normal
  // 链接文本字体列表
  linkTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 链接文本字体
  linkTextFontFamily: string = 'HarmonyOS Sans'
  // 链接文本字符间距列表
  linkTextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State // 链接文本字符间距
  linkTextLetterSpacing: number = 0
  // 链接文本装饰线类型列表
  linkTextDecorationTypeList: Array<TextDecorationType> = textDecorationTypeListGeneralData
  @State // 链接文本装饰线类型
  linkTextDecorationType: TextDecorationType = TextDecorationType.None
  // 链接文本装饰线颜色列表
  linkTextDecorationColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 链接文本装饰线颜色
  linkTextDecorationColor: ResourceColor | undefined = undefined
  // 链接文本装饰线样式列表
  linkTextDecorationStyleList: Array<TextDecorationStyle> = textDecorationStyleListGeneralData
  @State // 链接文本装饰线样式
  linkTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID
  // 链接文本背景左上圆角列表
  linkTextBackgroundRadiusTopLeftList: Array<number> = radiusListGeneraData
  @State // 链接文本背景左上圆角
  linkTextBackgroundRadiusTopLeft: number = 0
  // 链接文本背景右上圆角列表
  linkTextBackgroundRadiusTopRightList: Array<number> = radiusListGeneraData
  @State // 链接文本背景右上圆角
  linkTextBackgroundRadiusTopRight: number = 0
  // 链接文本背景左下圆角列表
  linkTextBackgroundRadiusBottomLeftList: Array<number> = radiusListGeneraData
  @State // 链接文本背景左下圆角
  linkTextBackgroundRadiusBottomLeft: number = 0
  // 链接文本背景右下圆角列表
  linkTextBackgroundRadiusBottomRightList: Array<number> = radiusListGeneraData
  @State // 链接文本背景右下圆角
  linkTextBackgroundRadiusBottomRight: number = 0
  @State linkData: LinkData = new LinkData() // 配置数据内容
  heightMD: number = 30 * 1 // 乘以行数
  @State isExpanded1: boolean = false // 控制展开/折叠状态 - 通用样式配置
  @State isExpanded2: boolean = false // 控制展开/折叠状态 - 圆形图片和其他设置
  @State isExpanded3: boolean = false // 控制展开/折叠状态 - 圆角矩形设置
  @State isExpanded4: boolean = false // 控制展开/折叠状态 - 空心圆角矩形设置
  @State isExpanded5: boolean = false // 控制展开/折叠状态 - 链接文本设置

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "链接配置页面",
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
                  this.linkData._isFull = this.isFull
                  this.linkData._incrementalAnalysis = this.incrementalAnalysis
                  this.linkData._time = this.time
                  this.linkData._textNumber = this.textNumber
                  this.linkData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.linkData._isOnCopy = this.isOnCopy
                  this.linkData._blockMarginTop = this.blockMarginTop
                  this.linkData._blockMarginRight = this.blockMarginRight
                  this.linkData._blockMarginBottom = this.blockMarginBottom
                  this.linkData._blockMarginLeft = this.blockMarginLeft
                  this.linkData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.linkData._isLineBreak = this.isLineBreak
                  this.linkData._backgroundColor = this.globalBackgroundColor
                  this.linkData._openGestureSwipe = this.openGestureSwipe
                  this.linkData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.linkData._pagePath = `${this.rawFilePath}/${item}`

                  // ---------- 专有
                  this.linkData.linkIsIcon = this.linkIsIcon
                  this.linkData.linkListIsIcon = this.linkListIsIcon
                  this.linkData.linkTextFontColor = this.linkTextFontColor
                  this.linkData.linkTextFontSize = this.linkTextFontSize
                  this.linkData.linkTextBackgroundColor = this.linkTextBackgroundColor
                  this.linkData.linkCircleIconBackgroundColor = this.linkCircleIconBackgroundColor
                  this.linkData.linkCircleIconButtonBackgroundColor = this.linkCircleIconButtonBackgroundColor
                  this.linkData.linkCircleIconTextSize = this.linkCircleIconTextSize
                  this.linkData.linkCircleIconTextColor = this.linkCircleIconTextColor
                  this.linkData.linkCircleIconRadius = this.linkCircleIconRadius
                  this.linkData.linkCircleIconMargin = this.linkCircleIconMargin
                  this.linkData.linkRectIconBackgroundColor = this.linkRectIconBackgroundColor
                  this.linkData.linkRectIconButtonBackgroundColor = this.linkRectIconButtonBackgroundColor
                  this.linkData.linkRectIconTextSize = this.linkRectIconTextSize
                  this.linkData.linkRectIconTextColor = this.linkRectIconTextColor
                  this.linkData.linkRectIconHeight = this.linkRectIconHeight
                  this.linkData.linkRectIconPadding = this.linkRectIconPadding
                  this.linkData.linkRectIconRadius = this.linkRectIconRadius
                  this.linkData.linkRectIconMargin = this.linkRectIconMargin
                  this.linkData.linkRectToolIconBackgroundColor = this.linkRectToolIconBackgroundColor
                  this.linkData.linkRectToolIconButtonBackgroundColor = this.linkRectToolIconButtonBackgroundColor
                  this.linkData.linkRectToolIconTextSize = this.linkRectToolIconTextSize
                  this.linkData.linkRectToolIconHeight = this.linkRectToolIconHeight
                  this.linkData.linkRectToolIconPadding = this.linkRectToolIconPadding
                  this.linkData.linkRectToolIconBorderWidth = this.linkRectToolIconBorderWidth
                  this.linkData.linkRectToolIconDividingLineWidth = this.linkRectToolIconDividingLineWidth
                  this.linkData.linkRectToolIconMargin = this.linkRectToolIconMargin
                  this.linkData.linkRectToolIconLineLeftPadding = this.linkRectToolIconLineLeftPadding
                  this.linkData.linkRectToolIconLineRightPadding = this.linkRectToolIconLineRightPadding
                  this.linkData.linkTextLineHeight = this.linkTextLineHeight
                  this.linkData.linkTextFontStyle = this.linkTextFontStyle
                  this.linkData.linkTextFontWeight = this.linkTextFontWeight
                  this.linkData.linkTextFontFamily = this.linkTextFontFamily
                  this.linkData.linkTextLetterSpacing = this.linkTextLetterSpacing
                  this.linkData.linkTextDecorationType = this.linkTextDecorationType
                  this.linkData.linkTextDecorationColor = this.linkTextDecorationColor
                  this.linkData.linkTextDecorationStyle = this.linkTextDecorationStyle
                  this.linkData.linkTextBackgroundRadiusTopLeft = this.linkTextBackgroundRadiusTopLeft
                  this.linkData.linkTextBackgroundRadiusTopRight = this.linkTextBackgroundRadiusTopRight
                  this.linkData.linkTextBackgroundRadiusBottomLeft = this.linkTextBackgroundRadiusBottomLeft
                  this.linkData.linkTextBackgroundRadiusBottomRight = this.linkTextBackgroundRadiusBottomRight
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/LinkDetailsPage", params: this.linkData })
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

          // 圆形图片和其他设置
          Column() {
            Row() {
              Text("圆形图片和其他设置")
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
                  titleStr: "链接是否是图片显示 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.linkIsIconList,
                  allData: this.linkIsIcon
                })
                BaseTabComponent({
                  titleStr: "列表中的单行链接是否是图片显示 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.linkListIsIconList,
                  allData: this.linkListIsIcon
                })
                BaseTabComponent({
                  titleStr: "圆形图片格式链接主题背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.linkCircleIconBackgroundColorList,
                  allData: this.linkCircleIconBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "圆形图片格式链接控件背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.linkCircleIconButtonBackgroundColorList,
                  allData: this.linkCircleIconButtonBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "圆形图片格式链接文字大小 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkCircleIconTextSizeList,
                  allData: this.linkCircleIconTextSize
                })
                BaseTabComponent({
                  titleStr: "圆形图片格式链接文字颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.linkCircleIconTextColorList,
                  allData: this.linkCircleIconTextColor
                })
                BaseTabComponent({
                  titleStr: "圆形图片格式链接半径 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkCircleIconRadiusList,
                  allData: this.linkCircleIconRadius
                })
                BaseTabComponent({
                  titleStr: "圆形图片格式链接左右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkCircleIconMarginList,
                  allData: this.linkCircleIconMargin
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

          // 圆角矩形设置
          Column() {
            Row() {
              Text("圆角矩形设置")
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
                  titleStr: "圆角矩形图片格式链接主题背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.linkRectIconBackgroundColorList,
                  allData: this.linkRectIconBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "圆角矩形图片格式链接控件背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.linkRectIconButtonBackgroundColorList,
                  allData: this.linkRectIconButtonBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "圆角矩形图片格式链接文字大小 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkRectIconTextSizeList,
                  allData: this.linkRectIconTextSize
                })
                BaseTabComponent({
                  titleStr: "圆角矩形图片格式链接文字颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.linkRectIconTextColorList,
                  allData: this.linkRectIconTextColor
                })
                BaseTabComponent({
                  titleStr: "圆角矩形图片格式链接控件高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkRectIconHeightList,
                  allData: this.linkRectIconHeight
                })
                BaseTabComponent({
                  titleStr: "圆角矩形图片格式链接左右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkRectIconPaddingList,
                  allData: this.linkRectIconPadding
                })
                BaseTabComponent({
                  titleStr: "圆角矩形图片格式链接圆角半径 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkRectIconRadiusList,
                  allData: this.linkRectIconRadius
                })
                BaseTabComponent({
                  titleStr: "圆角矩形图片格式链接左右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkRectIconMarginList,
                  allData: this.linkRectIconMargin
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

          // 空心圆角矩形设置
          Column() {
            Row() {
              Text("空心圆角矩形设置")
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
                  titleStr: "空心圆角矩形图片格式链接主题背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.linkRectToolIconBackgroundColorList,
                  allData: this.linkRectToolIconBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "空心圆角矩形图片格式链接控件背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.linkRectToolIconButtonBackgroundColorList,
                  allData: this.linkRectToolIconButtonBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "空心圆角矩形图片格式链接文字大小 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkRectToolIconTextSizeList,
                  allData: this.linkRectToolIconTextSize
                })
                BaseTabComponent({
                  titleStr: "空心圆角矩形图片格式链接控件高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkRectToolIconHeightList,
                  allData: this.linkRectToolIconHeight
                })
                BaseTabComponent({
                  titleStr: "空心圆角矩形图片格式链接左右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkRectToolIconPaddingList,
                  allData: this.linkRectToolIconPadding
                })
                BaseTabComponent({
                  titleStr: "空心圆角矩形图片格式链接边框宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkRectToolIconBorderWidthList,
                  allData: this.linkRectToolIconBorderWidth
                })
                BaseTabComponent({
                  titleStr: "空心圆角矩形图片格式链接分割线宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkRectToolIconDividingLineWidthList,
                  allData: this.linkRectToolIconDividingLineWidth
                })
                BaseTabComponent({
                  titleStr: "空心圆角矩形图片格式链接左右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkRectToolIconMarginList,
                  allData: this.linkRectToolIconMargin
                })
                BaseTabComponent({
                  titleStr: "空心圆角矩形图片格式分割线和文本左边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkRectToolIconLineLeftPaddingList,
                  allData: this.linkRectToolIconLineLeftPadding
                })
                BaseTabComponent({
                  titleStr: "空心圆角矩形图片格式分割线和文本右边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkRectToolIconLineRightPaddingList,
                  allData: this.linkRectToolIconLineRightPadding
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

          // 链接文本设置
          Column() {
            Row() {
              Text("链接文本设置")
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
                  titleStr: "文本格式链接文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.linkTextFontColorList,
                  allData: this.linkTextFontColor
                })
                BaseTabComponent({
                  titleStr: "文本格式链接文字大小 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkTextFontSizeList,
                  allData: this.linkTextFontSize
                })
                BaseTabComponent({
                  titleStr: "文本格式链接背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.linkTextBackgroundColorList,
                  allData: this.linkTextBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "文本格式链接文字行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkTextLineHeightList,
                  allData: this.linkTextLineHeight
                })
                BaseTabComponent({
                  titleStr: "链接文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.linkTextFontStyleList,
                  allData: this.linkTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "链接文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.linkTextFontWeightList,
                  allData: this.linkTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "链接文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.linkTextFontFamilyList,
                  allData: this.linkTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "链接文本字符间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkTextLetterSpacingList,
                  allData: this.linkTextLetterSpacing
                })
                BaseTabComponent({
                  titleStr: "链接文本装饰线类型 - ",
                  typeEnum: TypeEnum.IS_DECORATION_TYPE,
                  allListData: this.linkTextDecorationTypeList,
                  allData: this.linkTextDecorationType
                })
                BaseTabComponent({
                  titleStr: "链接文本装饰线颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.linkTextDecorationColorList,
                  allData: this.linkTextDecorationColor
                })
                BaseTabComponent({
                  titleStr: "链接文本装饰线样式 - ",
                  typeEnum: TypeEnum.IS_DECORATION_STYLE,
                  allListData: this.linkTextDecorationStyleList,
                  allData: this.linkTextDecorationStyle
                })
                BaseTabComponent({
                  titleStr: "链接文本背景左上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkTextBackgroundRadiusTopLeftList,
                  allData: this.linkTextBackgroundRadiusTopLeft
                })
                BaseTabComponent({
                  titleStr: "链接文本背景右上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkTextBackgroundRadiusTopRightList,
                  allData: this.linkTextBackgroundRadiusTopRight
                })
                BaseTabComponent({
                  titleStr: "链接文本背景左下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkTextBackgroundRadiusBottomLeftList,
                  allData: this.linkTextBackgroundRadiusBottomLeft
                })
                BaseTabComponent({
                  titleStr: "链接文本背景右下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.linkTextBackgroundRadiusBottomRightList,
                  allData: this.linkTextBackgroundRadiusBottomRight
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