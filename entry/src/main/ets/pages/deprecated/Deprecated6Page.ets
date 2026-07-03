import { titleComponent } from '../../component/BaseComponent'
import { getFileListStr } from '../../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../../component/BaseTabComponent'
import { TypeEnum } from '../../model/TypeEnum'
import {
  booleanListGeneralData,
  colorListGeneralData,
  marginListGeneralData,
  textNumberListGeneralData,
  timeListGeneralData
} from '../../model/GeneralData'
import { DeprecatedData } from '../../model/DeprecatedData'

// 表格、列表配置
@Entry
@Component
struct Deprecated6Page {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // 顶部导航栏高度
  @StorageProp('safeTop') safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "106_Deprecated"
  // rawfile文件夹列表
  @State folderList: Array<string> = new Array<string>()
  // 是否全量加载Markdown文本列表
  isFullList: Array<boolean> = booleanListGeneralData
  // 是否全量加载Markdown文本
  @State isFull: boolean = true
  // 是否增量解析Markdown文本列表
  incrementalAnalysisList: Array<boolean> = booleanListGeneralData
  // 是否增量解析Markdown文本
  @State incrementalAnalysis: boolean = false
  // 增量加载每次间隔时间列表
  timeList: Array<number> = timeListGeneralData
  // 增量加载每次间隔时间
  @State time: number = 50
  // 增量每次增量文本数量列表
  textNumberList: Array<number> = textNumberListGeneralData
  // 增量每次增量文本数量
  @State textNumber: number = 10
  // 是否同步解析Markdown文本列表
  isMarkdownParserSyncList: Array<boolean> = booleanListGeneralData
  // 是否同步解析Markdown文本
  @State isMarkdownParserSync: boolean = false
  // 是否打开长按复制粘贴效果列表
  isOnCopyList: Array<boolean> = booleanListGeneralData
  // 是否打开长按复制粘贴效果
  @State isOnCopy: boolean = false
  // Markdown文本第一个模块上边距列表
  blockFirstTopMarginList: Array<number> = marginListGeneralData
  // Markdown文本第一个模块上边距
  @State blockFirstTopMargin: number = 8
  // Markdown文本最后一个模块下边距列表
  blockLastBottomMarginList: Array<number> = marginListGeneralData
  // Markdown文本最后一个模块下边距
  @State blockLastBottomMargin: number = 8
  // Markdown文本模块间上下间距列表
  blockTopAndBottomMarginsList: Array<number> = marginListGeneralData
  // Markdown文本模块间上下间距
  @State blockTopAndBottomMargins: number = 8
  // 是否允许markdown控件自身响应滑动列表
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  // 是否允许markdown控件自身响应滑动
  @State openGestureSwipe: boolean = false
  // 是否开启响应滑动测试列表
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  @State openGestureSwipeTest: boolean = false // 是否开启响应滑动测试

  // ---------------- 表格配置
  // 表格内容内边距列表
  tableCellPaddingList: Array<number> = [2, 3, 4, 5, 6]
  @State tableCellPadding: number = 4 // 表格内容内边距
  // 表格边框颜色列表
  tableBorderColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State tableBorderColor: number = 0xFF000000 // 表格边框颜色
  // 表格奇数行背景色列表
  tableOddRowBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State tableOddRowBackgroundColor: number = 0xFFFFFFFF // 表格奇数行背景色
  // 表格偶数行背景色列表
  tableEvenRowBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State tableEvenRowBackgroundColor: number = 0xFFE0E0E0 // 表格偶数行背景色
  // 表格第一列是否加粗列表
  tableFirstColumnBoldList: Array<boolean> = booleanListGeneralData
  @State tableFirstColumnBold: boolean = false // 表格第一列是否加粗
  // 表格是否显示滚动条列表
  tableScrollBarShowList: Array<boolean> = booleanListGeneralData
  @State tableScrollBarShow: boolean = false // 表格是否显示滚动条
  // 表格边框宽度列表
  tableBorderWidthList: Array<number> = [0, 1, 2, 3, 4]
  @State tableBorderWidth: number = 1 // 表格边框宽度
  // 表格标题背景色列表
  tableHeaderRowBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State tableHeaderRowBackgroundColor: number = 0xFFFFFFFF // 表格标题背景色
  // 表格标题文本颜色列表
  tableTitleTextColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State tableTitleTextColor: number = 0xFF191919 // 表格标题文本颜色
  // 表格标题文本大小列表
  tableTitleTextSizeList: Array<number> = textNumberListGeneralData
  @State tableTitleTextSize: number = 14 // 表格标题文本大小
  // 表格标题文本行高列表
  tableTitleLineHeightList: Array<number> = textNumberListGeneralData
  @State tableTitleLineHeight: number = 22 // 表格标题文本行高
  // 表格内容文本颜色列表
  tableContentTextColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State tableContentTextColor: number = 0xFF191919 // 表格内容文本颜色
  // 表格内容文本大小列表
  tableContentTextSizeList: Array<number> = textNumberListGeneralData
  @State tableContentTextSize: number = 14 // 表格内容文本大小
  // 表格文本行高列表
  tableTextLineHeightList: Array<number> = textNumberListGeneralData
  @State tableTextLineHeight: number = 22 // 表格文本行高
  // 表格圆角列表
  tableRadiusList: Array<number> = [0, 2, 4, 6, 8, 10]
  @State tableRadius: number = 5 // 表格圆角
  // 表格最小宽度列表
  tableMinTextWidthList: Array<number> = [30, 40, 50, 60, 70]
  @State tableMinTextWidth: number = 50 // 表格最小宽度
  // 表格最大宽度列表
  tableMaxTextWidthList: Array<number> = [200, 250, 300, 350, 400]
  @State tableMaxTextWidth: number = 300 // 表格最大宽度
  // 表格滚动条颜色列表
  tableScrollBarColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State tableScrollBarColor: number = 0xFF191919 // 表格滚动条颜色

  // ---------------- 列表配置
  // 有序列表、无序列表、任务列表子模块上下间距列表
  blockOrderedAndBulletTopAndBottomMarginsList: Array<number> = marginListGeneralData
  @State blockOrderedAndBulletTopAndBottomMargins: number = 0 // 有序列表、无序列表、任务列表子模块上下间距
  // 有序列表、无序列表、任务列表左边距列表
  blockLeftMarginList: Array<number> = marginListGeneralData
  @State blockLeftMargin: number = 8 // 有序列表、无序列表、任务列表左边距
  // 有序列表、无序列表、任务列表右边距列表
  blockRightMarginList: Array<number> = marginListGeneralData
  @State blockRightMargin: number = 8 // 有序列表、无序列表、任务列表右边距
  // 有序列表前缀文本是否加粗列表
  orderedListItemPrefixBoldList: Array<boolean> = booleanListGeneralData
  @State orderedListItemPrefixBold: boolean = false // 有序列表前缀文本是否加粗
  // 有序列表前缀文本颜色列表
  orderedListItemColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State orderedListItemColor: number = 0xFF191919 // 有序列表前缀文本颜色
  // 有序列表前缀文本大小列表
  orderedListItemSizeList: Array<number> = textNumberListGeneralData
  @State orderedListItemSize: number = 14 // 有序列表前缀文本大小
  // 有序列表前缀文本行高列表
  orderedListItemLineHeightList: Array<number> = textNumberListGeneralData
  @State orderedListItemLineHeight: number = 22 // 有序列表前缀文本行高
  // 无序列表前缀是否全部是实心圆型列表
  bulletListItemCircleList: Array<boolean> = booleanListGeneralData
  @State bulletListItemCircle: boolean = false // 无序列表前缀是否全部是实心圆型
  // 无序列表前缀文本颜色列表
  bulletListItemColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State bulletListItemColor: number = 0xFF191919 // 无序列表前缀文本颜色
  // 无序列表前缀文本大小列表
  bulletListItemSizeList: Array<number> = [2, 3, 4, 5, 6]
  @State bulletListItemSize: number = 4 // 无序列表前缀文本大小
  // 无序列表前缀文本行高列表
  bulletListItemLineHeightList: Array<number> = textNumberListGeneralData
  @State bulletListItemLineHeight: number = 18 // 无序列表前缀文本行高
  // 任务列表选择框宽高列表
  taskListItemLengthList: Array<number> = [10, 12, 15, 18, 20]
  @State taskListItemLength: number = 15 // 任务列表选择框宽高

  @State deprecatedData: DeprecatedData = new DeprecatedData() // 配置数据内容

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "表格列表配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Scroll() {
        Column() {
          // ------------ 通用配置
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
            titleStr: "Markdown文本第一个模块上边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockFirstTopMarginList,
            allData: this.blockFirstTopMargin
          })
          BaseTabComponent({
            titleStr: "Markdown文本最后一个模块下边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockLastBottomMarginList,
            allData: this.blockLastBottomMargin
          })
          BaseTabComponent({
            titleStr: "Markdown文本模块间上下间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockTopAndBottomMarginsList,
            allData: this.blockTopAndBottomMargins
          })
          BaseTabComponent({
            titleStr: "是否允许markdown控件自身响应滑动 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.openGestureSwipeList,
            allData: this.openGestureSwipe
          })
          BaseTabComponent({
            titleStr: "是否开启响应滑动测试 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.openGestureSwipeTestList,
            allData: this.openGestureSwipeTest
          })

          // ------------ 表格配置
          BaseTabComponent({
            titleStr: "表格内容内边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.tableCellPaddingList,
            allData: this.tableCellPadding
          })
          BaseTabComponent({
            titleStr: "表格边框颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.tableBorderColorList,
            allData: this.tableBorderColor
          })
          BaseTabComponent({
            titleStr: "表格边框宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.tableBorderWidthList,
            allData: this.tableBorderWidth
          })
          BaseTabComponent({
            titleStr: "表格奇数行背景色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.tableOddRowBackgroundColorList,
            allData: this.tableOddRowBackgroundColor
          })
          BaseTabComponent({
            titleStr: "表格偶数行背景色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.tableEvenRowBackgroundColorList,
            allData: this.tableEvenRowBackgroundColor
          })
          BaseTabComponent({
            titleStr: "表格标题背景色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.tableHeaderRowBackgroundColorList,
            allData: this.tableHeaderRowBackgroundColor
          })
          BaseTabComponent({
            titleStr: "表格标题文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.tableTitleTextColorList,
            allData: this.tableTitleTextColor
          })
          BaseTabComponent({
            titleStr: "表格标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.tableTitleTextSizeList,
            allData: this.tableTitleTextSize
          })
          BaseTabComponent({
            titleStr: "表格标题文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.tableTitleLineHeightList,
            allData: this.tableTitleLineHeight
          })
          BaseTabComponent({
            titleStr: "表格内容文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.tableContentTextColorList,
            allData: this.tableContentTextColor
          })
          BaseTabComponent({
            titleStr: "表格内容文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.tableContentTextSizeList,
            allData: this.tableContentTextSize
          })
          BaseTabComponent({
            titleStr: "表格文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.tableTextLineHeightList,
            allData: this.tableTextLineHeight
          })
          BaseTabComponent({
            titleStr: "表格圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.tableRadiusList,
            allData: this.tableRadius
          })
          BaseTabComponent({
            titleStr: "表格最小宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.tableMinTextWidthList,
            allData: this.tableMinTextWidth
          })
          BaseTabComponent({
            titleStr: "表格最大宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.tableMaxTextWidthList,
            allData: this.tableMaxTextWidth
          })
          BaseTabComponent({
            titleStr: "表格第一列是否加粗 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.tableFirstColumnBoldList,
            allData: this.tableFirstColumnBold
          })
          BaseTabComponent({
            titleStr: "表格是否显示滚动条 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.tableScrollBarShowList,
            allData: this.tableScrollBarShow
          })
          BaseTabComponent({
            titleStr: "表格滚动条颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.tableScrollBarColorList,
            allData: this.tableScrollBarColor
          })

          // ------------ 列表配置
          BaseTabComponent({
            titleStr: "有序列表和无序列表上下间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockOrderedAndBulletTopAndBottomMarginsList,
            allData: this.blockOrderedAndBulletTopAndBottomMargins
          })
          BaseTabComponent({
            titleStr: "列表左边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockLeftMarginList,
            allData: this.blockLeftMargin
          })
          BaseTabComponent({
            titleStr: "列表右边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockRightMarginList,
            allData: this.blockRightMargin
          })
          // 有序列表配置
          BaseTabComponent({
            titleStr: "有序列表项前缀是否加粗 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.orderedListItemPrefixBoldList,
            allData: this.orderedListItemPrefixBold
          })
          BaseTabComponent({
            titleStr: "有序列表项颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.orderedListItemColorList,
            allData: this.orderedListItemColor
          })
          BaseTabComponent({
            titleStr: "有序列表项大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.orderedListItemSizeList,
            allData: this.orderedListItemSize
          })
          BaseTabComponent({
            titleStr: "有序列表项行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.orderedListItemLineHeightList,
            allData: this.orderedListItemLineHeight
          })
          // 无序列表配置
          BaseTabComponent({
            titleStr: "无序列表项前缀是否实心圆 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.bulletListItemCircleList,
            allData: this.bulletListItemCircle
          })
          BaseTabComponent({
            titleStr: "无序列表项颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.bulletListItemColorList,
            allData: this.bulletListItemColor
          })
          BaseTabComponent({
            titleStr: "无序列表项大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.bulletListItemSizeList,
            allData: this.bulletListItemSize
          })
          BaseTabComponent({
            titleStr: "无序列表项行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.bulletListItemLineHeightList,
            allData: this.bulletListItemLineHeight
          })
          // 任务列表配置
          BaseTabComponent({
            titleStr: "任务列表项长度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.taskListItemLengthList,
            allData: this.taskListItemLength
          })

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
                    // ---------- 通用配置
                    this.deprecatedData._isFull = this.isFull
                    this.deprecatedData._incrementalAnalysis = this.incrementalAnalysis
                    this.deprecatedData._time = this.time
                    this.deprecatedData._textNumber = this.textNumber
                    this.deprecatedData._isMarkdownParserSync = this.isMarkdownParserSync
                    this.deprecatedData._isOnCopy = this.isOnCopy
                    this.deprecatedData._blockFirstTopMargin = this.blockFirstTopMargin
                    this.deprecatedData._blockLastBottomMargin = this.blockLastBottomMargin
                    this.deprecatedData._blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.deprecatedData._openGestureSwipe = this.openGestureSwipe
                    this.deprecatedData._openGestureSwipeTest = this.openGestureSwipeTest

                    // ---------- 表格配置
                    this.deprecatedData._tableCellPadding = this.tableCellPadding
                    this.deprecatedData._tableBorderColor = this.tableBorderColor
                    this.deprecatedData._tableBorderWidth = this.tableBorderWidth
                    this.deprecatedData._tableOddRowBackgroundColor = this.tableOddRowBackgroundColor
                    this.deprecatedData._tableEvenRowBackgroundColor = this.tableEvenRowBackgroundColor
                    this.deprecatedData._tableHeaderRowBackgroundColor = this.tableHeaderRowBackgroundColor
                    this.deprecatedData._tableTitleTextColor = this.tableTitleTextColor
                    this.deprecatedData._tableTitleTextSize = this.tableTitleTextSize
                    this.deprecatedData._tableTitleLineHeight = this.tableTitleLineHeight
                    this.deprecatedData._tableContentTextColor = this.tableContentTextColor
                    this.deprecatedData._tableContentTextSize = this.tableContentTextSize
                    this.deprecatedData._tableTextLineHeight = this.tableTextLineHeight
                    this.deprecatedData._tableRadius = this.tableRadius
                    this.deprecatedData._tableMinTextWidth = this.tableMinTextWidth
                    this.deprecatedData._tableMaxTextWidth = this.tableMaxTextWidth
                    this.deprecatedData._tableFirstColumnBold = this.tableFirstColumnBold
                    this.deprecatedData._tableScrollBarShow = this.tableScrollBarShow
                    this.deprecatedData._tableScrollBarColor = this.tableScrollBarColor

                    // ---------- 列表配置
                    this.deprecatedData._blockOrderedAndBulletTopAndBottomMargins = this.blockOrderedAndBulletTopAndBottomMargins
                    this.deprecatedData._blockLeftMargin = this.blockLeftMargin
                    this.deprecatedData._blockRightMargin = this.blockRightMargin
                    this.deprecatedData._orderedListItemPrefixBold = this.orderedListItemPrefixBold
                    this.deprecatedData._orderedListItemColor = this.orderedListItemColor
                    this.deprecatedData._orderedListItemSize = this.orderedListItemSize
                    this.deprecatedData._orderedListItemLineHeight = this.orderedListItemLineHeight
                    this.deprecatedData._bulletListItemCircle = this.bulletListItemCircle
                    this.deprecatedData._bulletListItemColor = this.bulletListItemColor
                    this.deprecatedData._bulletListItemSize = this.bulletListItemSize
                    this.deprecatedData._bulletListItemLineHeight = this.bulletListItemLineHeight
                    this.deprecatedData._taskListItemLength = this.taskListItemLength

                    this.deprecatedData._pagePath = `${this.rawFilePath}/${item}`

                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/deprecated/Deprecated6DetailsPage", params: this.deprecatedData })
                  })
              }
            })
          }
          // 设置ListItem在List交叉轴方向的布局方式
          .alignListItem(ListItemAlign.Center)
        }
        .padding({ bottom: 100 })
      }
    }
    .backgroundColor($r('app.color.page_background'))
    .height("100%")
  }
}
