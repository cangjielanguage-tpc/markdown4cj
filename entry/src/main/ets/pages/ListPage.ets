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
import { ListData } from '../model/ListData'

@Entry
@Component
struct ListPage {
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
  rawFilePath: string = "009_有序无序任务列表"
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
   * 是否开启打字机效果列表
   */
  typeWriterOpenList: Array<boolean> = booleanListGeneralData
  /**
   * 是否开启打字机效果
   */
  @State
  typeWriterOpen: boolean = false
  /**
   * 打字机效果颜色列表
   */
  typeWriterColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 打字机效果颜色
   */
  @State
  typeWriterColor: number | undefined = undefined
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
   * 有序列表、无序列表、任务列表子模块上下间距列表
   */
  blockOrderedAndBulletTopAndBottomMarginsList: Array<number> =
    [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
  /**
   * 有序列表、无序列表、任务列表子模块上下间距
   */
  @State
  blockOrderedAndBulletTopAndBottomMargins: number = 0
  /**
   * 有序列表、无序列表、任务列表左边距列表
   */
  blockLeftMarginList: Array<number> = textWordSpaceListGeneralData
  /**
   * 有序列表、无序列表、任务列表左边距
   */
  @State
  blockLeftMargin: number = 8
  /**
   * 有序列表、无序列表、任务列表右边距列表
   */
  blockRightMarginList: Array<number> = textWordSpaceListGeneralData
  /**
   * 有序列表、无序列表、任务列表右边距
   */
  @State
  blockRightMargin: number = 8
  /**
   * 有序列表前缀文本是否加粗列表
   */
  orderedListItemPrefixBoldList: Array<boolean> = booleanListGeneralData
  /**
   * 有序列表前缀文本是否加粗
   */
  @State
  orderedListItemPrefixBold: boolean = false
  /**
   * 有序列表前缀文本颜色列表
   */
  orderedListItemColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 有序列表前缀文本颜色
   */
  @State
  orderedListItemColor: number | undefined = undefined
  /**
   * 有序列表前缀文本大小列表
   */
  orderedListItemSizeList: Array<number> = textSizeListGeneralData
  /**
   * 有序列表前缀文本大小
   */
  @State
  orderedListItemSize: number = 14
  /**
   * 有序列表前缀文本行高列表
   */
  orderedListItemLineHeightList: Array<number> = textLineHeightListGeneralData
  /**
   * 有序列表前缀文本行高
   */
  @State
  orderedListItemLineHeight: number = 22
  /**
   * 无序列表前缀是否全部是实心圆型列表
   */
  bulletListItemCircleList: Array<boolean> = booleanListGeneralData
  /**
   * 无序列表前缀是否全部是实心圆型
   */
  @State
  bulletListItemCircle: boolean = false
  /**
   * 无序列表前缀文本颜色列表
   */
  bulletListItemColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 无序列表前缀文本颜色
   */
  @State
  bulletListItemColor: number | undefined = undefined
  /**
   * 无序列表前缀文本大小列表
   */
  bulletListItemSizeList: Array<number> = textSizeListGeneralData
  /**
   * 无序列表前缀文本大小
   */
  @State
  bulletListItemSize: number = 4
  /**
   * 无序列表前缀文本行高列表
   */
  bulletListItemLineHeightList: Array<number> = textLineHeightListGeneralData
  /**
   * 无序列表前缀文本行高
   */
  @State
  bulletListItemLineHeight: number = 18
  /**
   * 任务列表前缀文本行高列表
   */
  taskListItemLengthList: Array<number> = textLineHeightListGeneralData
  /**
   * 任务列表前缀文本行高
   */
  @State
  taskListItemLength: number = 15
  /**
   * 配置数据内容
   */
  @State
  listData: ListData = new ListData()

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
            titleStr: "是否开启打字机效果 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.typeWriterOpenList,
            allData: this.typeWriterOpen
          })
          BaseTabComponent({
            titleStr: "打字机效果颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.typeWriterColorList,
            allData: this.typeWriterColor
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
            titleStr: "有序列表、无序列表、任务列表子模块上下间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockOrderedAndBulletTopAndBottomMarginsList,
            allData: this.blockOrderedAndBulletTopAndBottomMargins
          })
          BaseTabComponent({
            titleStr: "有序列表、无序列表、任务列表左边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockLeftMarginList,
            allData: this.blockLeftMargin
          })
          BaseTabComponent({
            titleStr: "有序列表、无序列表、任务列表右边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockRightMarginList,
            allData: this.blockRightMargin
          })
          BaseTabComponent({
            titleStr: "有序列表前缀文本是否加粗 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.orderedListItemPrefixBoldList,
            allData: this.orderedListItemPrefixBold
          })
          BaseTabComponent({
            titleStr: "有序列表前缀文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.orderedListItemColorList,
            allData: this.orderedListItemColor
          })
          BaseTabComponent({
            titleStr: "有序列表前缀文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.orderedListItemSizeList,
            allData: this.orderedListItemSize
          })
          BaseTabComponent({
            titleStr: "有序列表前缀文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.orderedListItemLineHeightList,
            allData: this.orderedListItemLineHeight
          })
          BaseTabComponent({
            titleStr: "无序列表前缀是否全部是实心圆型 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.bulletListItemCircleList,
            allData: this.bulletListItemCircle
          })
          BaseTabComponent({
            titleStr: "无序列表前缀文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.bulletListItemColorList,
            allData: this.bulletListItemColor
          })
          BaseTabComponent({
            titleStr: "无序列表前缀文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.bulletListItemSizeList,
            allData: this.bulletListItemSize
          })
          BaseTabComponent({
            titleStr: "无序列表前缀文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.bulletListItemLineHeightList,
            allData: this.bulletListItemLineHeight
          })
          BaseTabComponent({
            titleStr: "任务列表选择框宽高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.taskListItemLengthList,
            allData: this.taskListItemLength
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
                    this.listData.isFull = this.isFull
                    this.listData.incrementalAnalysis = this.incrementalAnalysis
                    this.listData.time = this.time
                    this.listData.textNumber = this.textNumber
                    this.listData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.listData.typeWriterOpen = this.typeWriterOpen
                    this.listData.typeWriterColor = this.typeWriterColor
                    this.listData.isOnCopy = this.isOnCopy
                    this.listData.blockFirstTopMargin = this.blockFirstTopMargin
                    this.listData.blockLastBottomMargin = this.blockLastBottomMargin
                    this.listData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.listData.openGestureSwipe = this.openGestureSwipe
                    this.listData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.listData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.listData.blockOrderedAndBulletTopAndBottomMargins = this.blockOrderedAndBulletTopAndBottomMargins
                    this.listData.blockLeftMargin = this.blockLeftMargin
                    this.listData.blockRightMargin = this.blockRightMargin
                    this.listData.orderedListItemPrefixBold = this.orderedListItemPrefixBold
                    this.listData.orderedListItemColor = this.orderedListItemColor
                    this.listData.orderedListItemSize = this.orderedListItemSize
                    this.listData.orderedListItemLineHeight = this.orderedListItemLineHeight
                    this.listData.bulletListItemCircle = this.bulletListItemCircle
                    this.listData.bulletListItemColor = this.bulletListItemColor
                    this.listData.bulletListItemSize = this.bulletListItemSize
                    this.listData.bulletListItemLineHeight = this.bulletListItemLineHeight
                    this.listData.taskListItemLength = this.taskListItemLength
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/ListDetailsPage", params: this.listData })
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


