/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import {
  booleanListGeneralData,
  colorListGeneralData,
  marginListGeneralData,
  textLineHeightListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  textWordSpaceListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { TableData } from '../model/TableData'

@Entry
@Component
struct TablePage {
  // ---------------- 通用
  /**
   * 滑动控制器
   */
  scroller: Scroller = new Scroller()
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop')
  safeTop: number = 0
  /**
   * rawfile路径
   */
  rawFilePath: string = "006_表格"
  /**
   * rawfile文件夹列表
   */
  @State
  folderList: Array<string> = new Array<string>()
  /**
   * 是否全量加载Markdown文本列表
   */
  isFullList: Array<boolean> = booleanListGeneralData
  /**
   * 是否全量加载Markdown文本
   */
  @State
  isFull: boolean = true
  /**
   * 是否增量解析Markdown文本列表
   */
  incrementalAnalysisList: Array<boolean> = booleanListGeneralData
  /**
   * 是否增量解析Markdown文本
   */
  @State
  incrementalAnalysis: boolean = false
  /**
   * 增量加载每次间隔时间列表
   */
  timeList: Array<number> = timeListGeneralData
  /**
   * 增量加载每次间隔时间
   */
  @State
  time: number = 50
  /**
   * 增量每次增量文本数量列表
   */
  textNumberList: Array<number> = textNumberListGeneralData
  /**
   * 增量每次增量文本数量
   */
  @State
  textNumber: number = 10
  /**
   * 是否同步解析Markdown文本列表
   */
  isMarkdownParserSyncList: Array<boolean> = booleanListGeneralData
  /**
   * 是否同步解析Markdown文本
   */
  @State
  isMarkdownParserSync: boolean = false
  /**
   * 是否打开长按复制粘贴效果列表
   */
  isOnCopyList: Array<boolean> = booleanListGeneralData
  /**
   * 是否打开长按复制粘贴效果
   */
  @State
  isOnCopy: boolean = false
  /**
   * Markdown文本第一个模块上边距列表
   */
  blockFirstTopMarginList: Array<number> = marginListGeneralData
  /**
   * Markdown文本第一个模块上边距
   */
  @State
  blockFirstTopMargin: number = 8
  /**
   * Markdown文本最后一个模块下边距列表
   */
  blockLastBottomMarginList: Array<number> = marginListGeneralData
  /**
   * Markdown文本最后一个模块下边距
   */
  @State
  blockLastBottomMargin: number = 8
  /**
   * Markdown文本模块间上下间距列表
   */
  blockTopAndBottomMarginsList: Array<number> = marginListGeneralData
  /**
   * Markdown文本模块间上下间距
   */
  @State
  blockTopAndBottomMargins: number = 8
  /**
   * 是否允许markdown控件自身响应滑动列表
   */
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  /**
   * 是否允许markdown控件自身响应滑动
   */
  @State
  openGestureSwipe: boolean = false
  /**
   * 是否开启响应滑动测试列表
   */
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  /**
   * 是否开启响应滑动测试
   */
  @State
  openGestureSwipeTest: boolean = false

  // ---------------- 专有
  /**
   * 表格内容内边距列表
   */
  tableCellPaddingList: Array<number> = textWordSpaceListGeneralData
  /**
   * 表格内容内边距
   */
  @State
  tableCellPadding: number = 4
  /**
   * 表格边框颜色列表
   */
  tableBorderColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 表格边框颜色
   */
  @State
  tableBorderColor: number | undefined = undefined
  /**
   * 表格边框宽度列表
   */
  tableBorderWidthList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  /**
   * 表格边框宽度
   */
  @State
  tableBorderWidth: number = 1
  /**
   * 表格奇数行背景色列表
   */
  tableOddRowBackgroundColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 表格奇数行背景色
   */
  @State
  tableOddRowBackgroundColor: number | undefined = undefined
  /**
   * 表格偶数行背景色列表
   */
  tableEvenRowBackgroundColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 表格偶数行背景色
   */
  @State
  tableEvenRowBackgroundColor: number | undefined = undefined
  /**
   * 表格标题背景色列表
   */
  tableHeaderRowBackgroundColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 表格标题背景色
   */
  @State
  tableHeaderRowBackgroundColor: number | undefined = undefined
  /**
   * 表格文本行高列表
   */
  tableTextLineHeightList: Array<number> = textLineHeightListGeneralData
  /**
   * 表格文本行高
   */
  @State
  tableTextLineHeight: number = 22
  /**
   * 表格圆角列表
   */
  tableRadiusList: Array<number> = [0, 1, 2, 5, 10, 15, 20, 25, 30]
  /**
   * 表格圆角
   */
  @State
  tableRadius: number = 5
  /**
   * 表格最小宽度列表
   */
  tableMinTextWidthList: Array<number> = [0, 30, 50, 80, 100, 150, 200, 250, 300, 350, 400]
  /**
   * 表格最小宽度
   */
  @State
  tableMinTextWidth: number = 50
  /**
   * 表格最大宽度列表
   */
  tableMaxTextWidthList: Array<number> = [0, 30, 50, 80, 100, 150, 200, 250, 300, 350, 400]
  /**
   * 表格最大宽度
   */
  @State
  tableMaxTextWidth: number = 300
  /**
   * 表格第一列是否加粗列表
   */
  tableFirstColumnBoldList: Array<boolean> = booleanListGeneralData
  /**
   * 表格第一列是否加粗
   */
  @State
  tableFirstColumnBold: boolean = false
  /**
   * 表格标题文本行高列表
   */
  tableTitleLineHeightList: Array<number> = textLineHeightListGeneralData
  /**
   * 表格标题文本行高
   */
  @State
  tableTitleLineHeight: number = 22
  /**
   * 表格标题文本大小列表
   */
  tableTitleTextSizeList: Array<number> = textSizeListGeneralData
  /**
   * 表格标题文本大小
   */
  @State
  tableTitleTextSize: number = 14
  /**
   * 表格标题文本颜色列表
   */
  tableTitleTextColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 表格标题文本颜色
   */
  @State
  tableTitleTextColor: number | undefined = undefined
  /**
   * 表格内容文本行高列表
   */
  tableContentTextLineHeightList: Array<number> = textLineHeightListGeneralData
  /**
   * 表格内容文本行高
   */
  @State
  tableContentTextLineHeight: number = 22
  /**
   * 表格内容文本大小列表
   */
  tableContentTextSizeList: Array<number> = textSizeListGeneralData
  /**
   * 表格内容文本大小
   */
  @State
  tableContentTextSize: number = 14
  /**
   * 表格内容文本颜色列表
   */
  tableContentTextColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 表格内容文本颜色
   */
  @State
  tableContentTextColor: number | undefined = undefined
  /**
   * 是否显示滚动条
   */
  @State
  tableScrollBarShow: boolean = false
  /**
   * 是否显示滚动条
   */
  tableScrollBarShowList: Array<boolean> = booleanListGeneralData
  /**
   * 表格滚动条颜色
   */
  @State
  tableScrollBarColor: number | undefined = undefined
  /**
   * 表格滚动条颜色列表
   */
  tableScrollBarColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 配置数据内容
   */
  @State
  tableData: TableData = new TableData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "表格配置页面",
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
            titleStr: "表格标题文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.tableTitleLineHeightList,
            allData: this.tableTitleLineHeight
          })
          BaseTabComponent({
            titleStr: "表格标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.tableTitleTextSizeList,
            allData: this.tableTitleTextSize
          })
          BaseTabComponent({
            titleStr: "表格标题文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.tableTitleTextColorList,
            allData: this.tableTitleTextColor
          })
          BaseTabComponent({
            titleStr: "表格内容文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.tableContentTextLineHeightList,
            allData: this.tableContentTextLineHeight
          })
          BaseTabComponent({
            titleStr: "表格内容文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.tableContentTextSizeList,
            allData: this.tableContentTextSize
          })
          BaseTabComponent({
            titleStr: "表格内容文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.tableContentTextColorList,
            allData: this.tableContentTextColor
          })
          BaseTabComponent({
            titleStr: "是否显示滚动条 - ",
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
                    this.tableData.isFull = this.isFull
                    this.tableData.incrementalAnalysis = this.incrementalAnalysis
                    this.tableData.time = this.time
                    this.tableData.textNumber = this.textNumber
                    this.tableData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.tableData.isOnCopy = this.isOnCopy
                    this.tableData.blockFirstTopMargin = this.blockFirstTopMargin
                    this.tableData.blockLastBottomMargin = this.blockLastBottomMargin
                    this.tableData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.tableData.openGestureSwipe = this.openGestureSwipe
                    this.tableData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.tableData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.tableData.tableCellPadding = this.tableCellPadding
                    this.tableData.tableBorderColor = this.tableBorderColor
                    this.tableData.tableBorderWidth = this.tableBorderWidth
                    this.tableData.tableOddRowBackgroundColor = this.tableOddRowBackgroundColor
                    this.tableData.tableEvenRowBackgroundColor = this.tableEvenRowBackgroundColor
                    this.tableData.tableHeaderRowBackgroundColor = this.tableHeaderRowBackgroundColor
                    this.tableData.tableRadius = this.tableRadius
                    this.tableData.tableMinTextWidth = this.tableMinTextWidth
                    this.tableData.tableMaxTextWidth = this.tableMaxTextWidth
                    this.tableData.tableFirstColumnBold = this.tableFirstColumnBold
                    this.tableData.tableTitleLineHeight = this.tableTitleLineHeight
                    this.tableData._tableTitleTextSize = this.tableTitleTextSize
                    this.tableData._tableTitleTextColor = this.tableTitleTextColor
                    this.tableData._tableContentTextLineHeight = this.tableContentTextLineHeight
                    this.tableData._tableContentTextSize = this.tableContentTextSize
                    this.tableData._tableContentTextColor = this.tableContentTextColor
                    this.tableData.tableScrollBarShow = this.tableScrollBarShow
                    this.tableData.tableScrollBarColor = this.tableScrollBarColor
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/TableDetailsPage", params: this.tableData })
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


