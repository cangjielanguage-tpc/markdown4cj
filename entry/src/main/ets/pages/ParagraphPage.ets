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
  textTypefaceListGeneralData,
  textWordSpaceListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { ParagraphData } from '../model/ParagraphData'

@Entry
@Component
struct ParagraphPage {
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
  rawFilePath: string = "002_段落"
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
  typeWriterColorList: Array<number> = colorListGeneralData
  /**
   * 打字机效果颜色
   */
  @State
  typeWriterColor: number = 0xFFFF0000
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
   * 段落文本大小列表
   */
  paragraphTextSizeList: Array<number> = textSizeListGeneralData
  /**
   * 段落文本大小
   */
  @State
  paragraphTextSize: number = 14
  /**
   * 段落文本颜色列表
   */
  paragraphTextColorList: Array<number> = colorListGeneralData
  /**
   * 段落文本颜色
   */
  @State
  paragraphTextColor: number = 0xFF000000
  /**
   * 段落文本字间距列表
   */
  paragraphTextWordSpaceList: Array<number> = textWordSpaceListGeneralData
  /**
   * 段落文本字间距
   */
  @State
  paragraphTextWordSpace: number = 0
  /**
   * 段落文本行高列表
   */
  paragraphTextLineHeightList: Array<number> = textLineHeightListGeneralData
  /**
   * 段落文本行高
   */
  @State
  paragraphTextLineHeight: number = 22
  /**
   * 段落文本字体列表
   */
  paragraphTypefaceList: Array<string> = textTypefaceListGeneralData
  /**
   * 段落文本字体
   */
  @State
  paragraphTypeface: string = "HarmonyOS Sans"
  /**
   * 段落模块上间距列表
   */
  paragraphTopMarginsList: Array<number> = marginListGeneralData
  /**
   * 段落模块上间距
   */
  @State
  paragraphTopMargins: number = 8
  /**
   * 段落模块下间距列表
   */
  paragraphBottomMarginsList: Array<number> = marginListGeneralData
  /**
   * 段落模块下间距
   */
  @State
  paragraphBottomMargins: number = 8
  /**
   * 配置数据内容
   */
  @State
  paragraphData: ParagraphData = new ParagraphData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "段落配置页面",
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
            titleStr: "段落文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.paragraphTextSizeList,
            allData: this.paragraphTextSize
          })
          BaseTabComponent({
            titleStr: "段落文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.paragraphTextColorList,
            allData: this.paragraphTextColor
          })
          BaseTabComponent({
            titleStr: "段落文本字间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.paragraphTextWordSpaceList,
            allData: this.paragraphTextWordSpace
          })
          BaseTabComponent({
            titleStr: "段落文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.paragraphTextLineHeightList,
            allData: this.paragraphTextLineHeight
          })
          BaseTabComponent({
            titleStr: "段落文本字体 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.paragraphTypefaceList,
            allData: this.paragraphTypeface
          })
          BaseTabComponent({
            titleStr: "段落模块上间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.paragraphTopMarginsList,
            allData: this.paragraphTopMargins
          })
          BaseTabComponent({
            titleStr: "段落模块下间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.paragraphBottomMarginsList,
            allData: this.paragraphBottomMargins
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
                    this.paragraphData.isFull = this.isFull
                    this.paragraphData.incrementalAnalysis = this.incrementalAnalysis
                    this.paragraphData.time = this.time
                    this.paragraphData.textNumber = this.textNumber
                    this.paragraphData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.paragraphData.typeWriterOpen = this.typeWriterOpen
                    this.paragraphData.typeWriterColor = this.typeWriterColor
                    this.paragraphData.isOnCopy = this.isOnCopy
                    this.paragraphData.blockFirstTopMargin = this.blockFirstTopMargin
                    this.paragraphData.blockLastBottomMargin = this.blockLastBottomMargin
                    this.paragraphData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.paragraphData.openGestureSwipe = this.openGestureSwipe
                    this.paragraphData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.paragraphData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.paragraphData.paragraphTextSize = this.paragraphTextSize
                    this.paragraphData.paragraphTextColor = this.paragraphTextColor
                    this.paragraphData.paragraphTextWordSpace = this.paragraphTextWordSpace
                    this.paragraphData.paragraphTextLineHeight = this.paragraphTextLineHeight
                    this.paragraphData.paragraphTypeface = this.paragraphTypeface
                    this.paragraphData.paragraphTopMargins = this.paragraphTopMargins
                    this.paragraphData.paragraphBottomMargins = this.paragraphBottomMargins
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/ParagraphDetailsPage", params: this.paragraphData })
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


