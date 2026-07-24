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
  marginListGeneralData,
  textLineHeightListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  textWordSpaceListGeneralData,
  timeListGeneralData,
  widthOrHeightListGeneralData
} from '../model/GeneralData'
import { ListData } from '../model/ListData'

@Entry
@Component
struct ListPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "009_OrderedUnorderedTaskList"
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
  // markdown全局上外边距列表
  blockMarginTopList: Array<number> = marginListGeneralData
  @State // markdown全局上外边距
  blockMarginTop: number = 0
  // markdown全局右外边距列表
  blockMarginRightList: Array<number> = marginListGeneralData
  @State // markdown全局右外边距
  blockMarginRight: number = 0
  // markdown全局下外边距列表
  blockMarginBottomList: Array<number> = marginListGeneralData
  @State // markdown全局下外边距
  blockMarginBottom: number = 0
  // markdown全局左外边距列表
  blockMarginLeftList: Array<number> = marginListGeneralData
  @State // markdown全局左外边距
  blockMarginLeft: number = 0
  // 模块间上下间距列表
  markdownBlockSpacingList: Array<number> = marginListGeneralData
  @State // 模块间上下间距
  markdownBlockSpacing: number = 8
  // 软换行是否换行列表
  isLineBreakList: Array<boolean> = booleanListGeneralData
  @State // 软换行是否换行
  isLineBreak: boolean = false
  // 背景颜色列表
  globalBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State // 背景颜色
  globalBackgroundColor: number | undefined = undefined
  // 是否允许markdown控件自身响应滑动列表
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  @State // 是否允许markdown控件自身响应滑动
  openGestureSwipe: boolean = false
  // 是否开启响应滑动测试列表
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  @State // 是否开启响应滑动测试
  openGestureSwipeTest: boolean = false
  // ---------------- 专有
  // 有序列表背景颜色列表
  orderedListBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State // 有序列表背景颜色
  orderedListBackgroundColor: number | undefined = undefined
  // 有序列表上外边距列表
  orderedListMarginTopList: Array<number> = marginListGeneralData
  @State // 有序列表上外边距
  orderedListMarginTop: number = 0
  // 有序列表右外边距列表
  orderedListMarginRightList: Array<number> = marginListGeneralData
  @State // 有序列表右外边距
  orderedListMarginRight: number = 0
  // 有序列表下外边距列表
  orderedListMarginBottomList: Array<number> = marginListGeneralData
  @State // 有序列表下外边距
  orderedListMarginBottom: number = 0
  // 有序列表左外边距列表
  orderedListMarginLeftList: Array<number> = marginListGeneralData
  @State // 有序列表左外边距
  orderedListMarginLeft: number = 8
  // 有序列表上内边距列表
  orderedListPaddingTopList: Array<number> = marginListGeneralData
  @State // 有序列表上内边距
  orderedListPaddingTop: number = 0
  // 有序列表右内边距列表
  orderedListPaddingRightList: Array<number> = marginListGeneralData
  @State // 有序列表右内边距
  orderedListPaddingRight: number = 0
  // 有序列表下内边距列表
  orderedListPaddingBottomList: Array<number> = marginListGeneralData
  @State // 有序列表下内边距
  orderedListPaddingBottom: number = 0
  // 有序列表左内边距列表
  orderedListPaddingLeftList: Array<number> = marginListGeneralData
  @State // 有序列表左内边距
  orderedListPaddingLeft: number = 0
  // 有序列表子模块上下间距列表
  orderedListChildSpacingList: Array<number> = marginListGeneralData
  @State // 有序列表子模块上下间距
  orderedListChildSpacing: number = 8
  // 有序列表子模块中子模块上下间距列表
  orderedListChildChildSpacingList: Array<number> = marginListGeneralData
  @State // 有序列表子模块中子模块上下间距
  orderedListChildChildSpacing: number = 8
  // 有序列表列表编号和列表内容间距列表
  orderedListMarkerSpacingList: Array<number> = marginListGeneralData
  @State // 有序列表列表编号和列表内容间距
  orderedListMarkerSpacing: number = 8
  // 有序列表列表编号文本颜色列表
  orderedListMarkerTextFontColorList: Array<number | undefined> = colorListGeneralData
  @State // 有序列表列表编号文本颜色
  orderedListMarkerTextFontColor: number | undefined = undefined
  // 有序列表列表编号文本尺寸列表
  orderedListMarkerTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 有序列表列表编号文本尺寸
  orderedListMarkerTextFontSize: number = 14
  // 有序列表列表编号文本字体样式列表
  orderedListMarkerTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 有序列表列表编号文本字体样式
  orderedListMarkerTextFontStyle: FontStyle = FontStyle.Normal
  // 有序列表列表编号文本字体粗细列表
  orderedListMarkerTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 有序列表列表编号文本字体粗细
  orderedListMarkerTextFontWeight: FontWeight = FontWeight.Normal
  // 有序列表列表编号文本字体列表
  orderedListMarkerTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 有序列表列表编号文本字体
  orderedListMarkerTextFontFamily: string = 'HarmonyOS Sans'
  // 有序列表列表编号文本行高列表
  orderedListMarkerTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State // 有序列表列表编号文本行高
  orderedListMarkerTextLineHeight: number = 22
  // 无序/任务背景颜色列表
  bulletListBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State // 无序/任务背景颜色
  bulletListBackgroundColor: number | undefined = undefined
  // 无序/任务上外边距列表
  bulletListMarginTopList: Array<number> = marginListGeneralData
  @State // 无序/任务上外边距
  bulletListMarginTop: number = 0
  // 无序/任务右外边距列表
  bulletListMarginRightList: Array<number> = marginListGeneralData
  @State // 无序/任务右外边距
  bulletListMarginRight: number = 0
  // 无序/任务下外边距列表
  bulletListMarginBottomList: Array<number> = marginListGeneralData
  @State // 无序/任务下外边距
  bulletListMarginBottom: number = 0
  // 无序/任务左外边距列表
  bulletListMarginLeftList: Array<number> = marginListGeneralData
  @State // 无序/任务左外边距
  bulletListMarginLeft: number = 8
  // 无序/任务上内边距列表
  bulletListPaddingTopList: Array<number> = marginListGeneralData
  @State // 无序/任务上内边距
  bulletListPaddingTop: number = 0
  // 无序/任务右内边距列表
  bulletListPaddingRightList: Array<number> = marginListGeneralData
  @State // 无序/任务右内边距
  bulletListPaddingRight: number = 0
  // 无序/任务下内边距列表
  bulletListPaddingBottomList: Array<number> = marginListGeneralData
  @State // 无序/任务下内边距
  bulletListPaddingBottom: number = 0
  // 无序/任务左内边距列表
  bulletListPaddingLeftList: Array<number> = marginListGeneralData
  @State // 无序/任务左内边距
  bulletListPaddingLeft: number = 0
  // 无序/任务子模块上下间距列表
  bulletListChildSpacingList: Array<number> = marginListGeneralData
  @State // 无序/任务子模块上下间距
  bulletListChildSpacing: number = 8
  // 无序/任务子模块中子模块上下间距列表
  bulletListChildChildSpacingList: Array<number> = marginListGeneralData
  @State // 无序/任务子模块中子模块上下间距
  bulletListChildChildSpacing: number = 8
  // 无序列表列表符号和列表内容间距列表
  bulletListBulletSpacingList: Array<number> = marginListGeneralData
  @State // 无序列表列表符号和列表内容间距
  bulletListBulletSpacing: number = 8
  // 无序列表列表符号是否全部是实心圆型列表
  bulletListBulletIsCircleList: Array<boolean> = booleanListGeneralData
  @State // 无序列表列表符号是否全部是实心圆型
  bulletListBulletIsCircle: boolean = false
  // 无序列表列表符号文本颜色列表
  bulletListBulletTextFontColorList: Array<number | undefined> = colorListGeneralData
  @State // 无序列表列表符号文本颜色
  bulletListBulletTextFontColor: number | undefined = undefined
  // 无序列表列表符号文本尺寸列表
  bulletListBulletTextFontSizeList: Array<number> = textSizeListGeneralData
  @State // 无序列表列表符号文本尺寸
  bulletListBulletTextFontSize: number = 4
  // 无序列表列表符号文本字体样式列表
  bulletListBulletTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 无序列表列表符号文本字体样式
  bulletListBulletTextFontStyle: FontStyle = FontStyle.Normal
  // 无序列表列表符号文本字体粗细列表
  bulletListBulletTextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State // 无序列表列表符号文本字体粗细
  bulletListBulletTextFontWeight: FontWeight = FontWeight.Normal
  // 无序列表列表符号文本字体列表
  bulletListBulletTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 无序列表列表符号文本字体
  bulletListBulletTextFontFamily: string = 'HarmonyOS Sans'
  // 无序列表列表符号文本行高列表
  bulletListBulletTextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State // 无序列表列表符号文本行高
  bulletListBulletTextLineHeight: number = 18
  // 任务列表多选框和列表内容间距列表
  bulletListCheckboxSpacingList: Array<number> = marginListGeneralData
  @State // 任务列表多选框和列表内容间距
  bulletListCheckboxSpacing: number = 8
  // 任务列表多选框宽度列表
  bulletListCheckboxWidthList: Array<number> = widthOrHeightListGeneralData
  @State // 任务列表多选框宽度
  bulletListCheckboxWidth: number = 15
  // 任务列表多选框高度列表
  bulletListCheckboxHeightList: Array<number> = widthOrHeightListGeneralData
  @State // 任务列表多选框高度
  bulletListCheckboxHeight: number = 15
  // 任务列表多选框选中颜色列表
  bulletListCheckboxSelectedColorList: Array<number | undefined> = colorListGeneralData
  @State // 任务列表多选框选中颜色
  bulletListCheckboxSelectedColor: number | undefined = undefined
  // 任务列表多选框形状列表
  bulletListCheckboxShapeList: Array<CheckBoxShape> = [CheckBoxShape.CIRCLE, CheckBoxShape.ROUNDED_SQUARE]
  @State // 任务列表多选框形状
  bulletListCheckboxShape: CheckBoxShape = CheckBoxShape.ROUNDED_SQUARE
  @State // 配置数据内容
  listData: ListData = new ListData()
  heightMD: number = 30 * 1 // 乘以行数
  @State isExpanded1: boolean = false // 控制展开/折叠状态 - 通用样式配置
  @State isExpanded2: boolean = false // 控制展开/折叠状态 - 有序列表设置
  @State isExpanded3: boolean = false // 控制展开/折叠状态 - 无序和任务列表通用设置
  @State isExpanded4: boolean = false // 控制展开/折叠状态 - 无序列表设置
  @State isExpanded5: boolean = false // 控制展开/折叠状态 - 任务列表设置

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "有序、无序、任务列表配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )

      // md文档展示部分
      Column() {
        GridRow({
          columns: 4,
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
                .fontColor(0xFFFFFFFF)
                .backgroundColor(0xFF2196F3)
                .height(25).width('100%')
                .padding(5)
                .borderRadius(5)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Clip })
                .onClick(() => {
                  // ---------- 通用
                  this.listData._isFull = this.isFull
                  this.listData._incrementalAnalysis = this.incrementalAnalysis
                  this.listData._time = this.time
                  this.listData._textNumber = this.textNumber
                  this.listData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.listData._isOnCopy = this.isOnCopy
                  this.listData._blockMarginTop = this.blockMarginTop
                  this.listData._blockMarginRight = this.blockMarginRight
                  this.listData._blockMarginBottom = this.blockMarginBottom
                  this.listData._blockMarginLeft = this.blockMarginLeft
                  this.listData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.listData._isLineBreak = this.isLineBreak
                  this.listData._backgroundColor = this.globalBackgroundColor
                  this.listData._openGestureSwipe = this.openGestureSwipe
                  this.listData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.listData._pagePath = `${this.rawFilePath}/${item}`

                  // ---------- 专有
                  this.listData.orderedListBackgroundColor = this.orderedListBackgroundColor
                  this.listData.orderedListMarginTop = this.orderedListMarginTop
                  this.listData.orderedListMarginRight = this.orderedListMarginRight
                  this.listData.orderedListMarginBottom = this.orderedListMarginBottom
                  this.listData.orderedListMarginLeft = this.orderedListMarginLeft
                  this.listData.orderedListPaddingTop = this.orderedListPaddingTop
                  this.listData.orderedListPaddingRight = this.orderedListPaddingRight
                  this.listData.orderedListPaddingBottom = this.orderedListPaddingBottom
                  this.listData.orderedListPaddingLeft = this.orderedListPaddingLeft
                  this.listData.orderedListChildSpacing = this.orderedListChildSpacing
                  this.listData.orderedListChildChildSpacing = this.orderedListChildChildSpacing
                  this.listData.orderedListMarkerSpacing = this.orderedListMarkerSpacing
                  this.listData.orderedListMarkerTextFontColor = this.orderedListMarkerTextFontColor
                  this.listData.orderedListMarkerTextFontSize = this.orderedListMarkerTextFontSize
                  this.listData.orderedListMarkerTextFontStyle = this.orderedListMarkerTextFontStyle
                  this.listData.orderedListMarkerTextFontWeight = this.orderedListMarkerTextFontWeight
                  this.listData.orderedListMarkerTextFontFamily = this.orderedListMarkerTextFontFamily
                  this.listData.orderedListMarkerTextLineHeight = this.orderedListMarkerTextLineHeight
                  this.listData.bulletListBackgroundColor = this.bulletListBackgroundColor
                  this.listData.bulletListMarginTop = this.bulletListMarginTop
                  this.listData.bulletListMarginRight = this.bulletListMarginRight
                  this.listData.bulletListMarginBottom = this.bulletListMarginBottom
                  this.listData.bulletListMarginLeft = this.bulletListMarginLeft
                  this.listData.bulletListPaddingTop = this.bulletListPaddingTop
                  this.listData.bulletListPaddingRight = this.bulletListPaddingRight
                  this.listData.bulletListPaddingBottom = this.bulletListPaddingBottom
                  this.listData.bulletListPaddingLeft = this.bulletListPaddingLeft
                  this.listData.bulletListChildSpacing = this.bulletListChildSpacing
                  this.listData.bulletListChildChildSpacing = this.bulletListChildChildSpacing
                  this.listData.bulletListBulletSpacing = this.bulletListBulletSpacing
                  this.listData.bulletListBulletIsCircle = this.bulletListBulletIsCircle
                  this.listData.bulletListBulletTextFontColor = this.bulletListBulletTextFontColor
                  this.listData.bulletListBulletTextFontSize = this.bulletListBulletTextFontSize
                  this.listData.bulletListBulletTextFontStyle = this.bulletListBulletTextFontStyle
                  this.listData.bulletListBulletTextFontWeight = this.bulletListBulletTextFontWeight
                  this.listData.bulletListBulletTextFontFamily = this.bulletListBulletTextFontFamily
                  this.listData.bulletListBulletTextLineHeight = this.bulletListBulletTextLineHeight
                  this.listData.bulletListCheckboxSpacing = this.bulletListCheckboxSpacing
                  this.listData.bulletListCheckboxWidth = this.bulletListCheckboxWidth
                  this.listData.bulletListCheckboxHeight = this.bulletListCheckboxHeight
                  this.listData.bulletListCheckboxSelectedColor = this.bulletListCheckboxSelectedColor
                  this.listData.bulletListCheckboxShape = this.bulletListCheckboxShape
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/ListDetailsPage", params: this.listData })
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
                .fontColor(0xFFF5F5F5)
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded1 ? "▲" : "▼")
                .fontSize(16)
                .fontColor(0xFFF5F5F5)
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

          // 有序列表设置
          Column() {
            Row() {
              Text("有序列表设置")
                .fontSize(16)
                .fontColor(0xFFF5F5F5)
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded2 ? "▲" : "▼")
                .fontSize(16)
                .fontColor(0xFFF5F5F5)
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
                  titleStr: "有序列表背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.orderedListBackgroundColorList,
                  allData: this.orderedListBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "有序列表上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.orderedListMarginTopList,
                  allData: this.orderedListMarginTop
                })
                BaseTabComponent({
                  titleStr: "有序列表右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.orderedListMarginRightList,
                  allData: this.orderedListMarginRight
                })
                BaseTabComponent({
                  titleStr: "有序列表下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.orderedListMarginBottomList,
                  allData: this.orderedListMarginBottom
                })
                BaseTabComponent({
                  titleStr: "有序列表左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.orderedListMarginLeftList,
                  allData: this.orderedListMarginLeft
                })
                BaseTabComponent({
                  titleStr: "有序列表上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.orderedListPaddingTopList,
                  allData: this.orderedListPaddingTop
                })
                BaseTabComponent({
                  titleStr: "有序列表右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.orderedListPaddingRightList,
                  allData: this.orderedListPaddingRight
                })
                BaseTabComponent({
                  titleStr: "有序列表下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.orderedListPaddingBottomList,
                  allData: this.orderedListPaddingBottom
                })
                BaseTabComponent({
                  titleStr: "有序列表左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.orderedListPaddingLeftList,
                  allData: this.orderedListPaddingLeft
                })
                BaseTabComponent({
                  titleStr: "有序列表子模块上下间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.orderedListChildSpacingList,
                  allData: this.orderedListChildSpacing
                })
                BaseTabComponent({
                  titleStr: "有序列表子模块中子模块上下间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.orderedListChildChildSpacingList,
                  allData: this.orderedListChildChildSpacing
                })
                BaseTabComponent({
                  titleStr: "有序列表列表编号和列表内容间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.orderedListMarkerSpacingList,
                  allData: this.orderedListMarkerSpacing
                })
                BaseTabComponent({
                  titleStr: "有序列表列表编号文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.orderedListMarkerTextFontColorList,
                  allData: this.orderedListMarkerTextFontColor
                })
                BaseTabComponent({
                  titleStr: "有序列表列表编号文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.orderedListMarkerTextFontSizeList,
                  allData: this.orderedListMarkerTextFontSize
                })
                BaseTabComponent({
                  titleStr: "有序列表列表编号文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.orderedListMarkerTextFontStyleList,
                  allData: this.orderedListMarkerTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "有序列表列表编号文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.orderedListMarkerTextFontWeightList,
                  allData: this.orderedListMarkerTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "有序列表列表编号文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.orderedListMarkerTextFontFamilyList,
                  allData: this.orderedListMarkerTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "有序列表列表编号文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.orderedListMarkerTextLineHeightList,
                  allData: this.orderedListMarkerTextLineHeight
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

          // 无序和任务列表通用设置
          Column() {
            Row() {
              Text("无序和任务列表通用设置")
                .fontSize(16)
                .fontColor(0xFFF5F5F5)
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded3 ? "▲" : "▼")
                .fontSize(16)
                .fontColor(0xFFF5F5F5)
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
                  titleStr: "无序/任务背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.bulletListBackgroundColorList,
                  allData: this.bulletListBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "无序/任务上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListMarginTopList,
                  allData: this.bulletListMarginTop
                })
                BaseTabComponent({
                  titleStr: "无序/任务右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListMarginRightList,
                  allData: this.bulletListMarginRight
                })
                BaseTabComponent({
                  titleStr: "无序/任务下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListMarginBottomList,
                  allData: this.bulletListMarginBottom
                })
                BaseTabComponent({
                  titleStr: "无序/任务左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListMarginLeftList,
                  allData: this.bulletListMarginLeft
                })
                BaseTabComponent({
                  titleStr: "无序/任务上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListPaddingTopList,
                  allData: this.bulletListPaddingTop
                })
                BaseTabComponent({
                  titleStr: "无序/任务右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListPaddingRightList,
                  allData: this.bulletListPaddingRight
                })
                BaseTabComponent({
                  titleStr: "无序/任务下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListPaddingBottomList,
                  allData: this.bulletListPaddingBottom
                })
                BaseTabComponent({
                  titleStr: "无序/任务左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListPaddingLeftList,
                  allData: this.bulletListPaddingLeft
                })
                BaseTabComponent({
                  titleStr: "无序/任务子模块上下间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListChildSpacingList,
                  allData: this.bulletListChildSpacing
                })
                BaseTabComponent({
                  titleStr: "无序/任务子模块中子模块上下间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListChildChildSpacingList,
                  allData: this.bulletListChildChildSpacing
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

          // 无序列表设置
          Column() {
            Row() {
              Text("无序列表设置")
                .fontSize(16)
                .fontColor(0xFFF5F5F5)
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded4 ? "▲" : "▼")
                .fontSize(16)
                .fontColor(0xFFF5F5F5)
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
                  titleStr: "无序列表列表符号和列表内容间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListBulletSpacingList,
                  allData: this.bulletListBulletSpacing
                })
                BaseTabComponent({
                  titleStr: "无序列表列表符号是否全部是实心圆型 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.bulletListBulletIsCircleList,
                  allData: this.bulletListBulletIsCircle
                })
                BaseTabComponent({
                  titleStr: "无序列表列表符号文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.bulletListBulletTextFontColorList,
                  allData: this.bulletListBulletTextFontColor
                })
                BaseTabComponent({
                  titleStr: "无序列表列表符号文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListBulletTextFontSizeList,
                  allData: this.bulletListBulletTextFontSize
                })
                BaseTabComponent({
                  titleStr: "无序列表列表符号文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.bulletListBulletTextFontStyleList,
                  allData: this.bulletListBulletTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "无序列表列表符号文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.bulletListBulletTextFontWeightList,
                  allData: this.bulletListBulletTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "无序列表列表符号文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.bulletListBulletTextFontFamilyList,
                  allData: this.bulletListBulletTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "无序列表列表符号文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListBulletTextLineHeightList,
                  allData: this.bulletListBulletTextLineHeight
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

          // 任务列表设置
          Column() {
            Row() {
              Text("任务列表设置")
                .fontSize(16)
                .fontColor(0xFFF5F5F5)
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded5 ? "▲" : "▼")
                .fontSize(16)
                .fontColor(0xFFF5F5F5)
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
                  titleStr: "任务列表多选框和列表内容间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListCheckboxSpacingList,
                  allData: this.bulletListCheckboxSpacing
                })
                BaseTabComponent({
                  titleStr: "任务列表多选框宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListCheckboxWidthList,
                  allData: this.bulletListCheckboxWidth
                })
                BaseTabComponent({
                  titleStr: "任务列表多选框高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.bulletListCheckboxHeightList,
                  allData: this.bulletListCheckboxHeight
                })
                BaseTabComponent({
                  titleStr: "任务列表多选框选中颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.bulletListCheckboxSelectedColorList,
                  allData: this.bulletListCheckboxSelectedColor
                })
                BaseTabComponent({
                  titleStr: "任务列表多选框形状 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.bulletListCheckboxShapeList,
                  allData: this.bulletListCheckboxShape
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
    .backgroundColor(0xFFEAEAEA)
    .height("90%")
  }
}