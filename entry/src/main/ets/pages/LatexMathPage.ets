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
  textNumberListGeneralData,
  textSizeListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { LatexMathData } from '../model/LatexMathData'
import { LatexMathColorFormat } from '@cangjie-tpc/markdown_hybrid'

@Entry
@Component
struct LatexMathPage {
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
  rawFilePath: string = "005_数学公式"
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
   * 数学公式文本大小列表
   */
  latexMathTextSizeList: Array<number> = textSizeListGeneralData
  /**
   * 数学公式文本大小
   */
  @State
  latexMathTextSize: number = 16
  /**
   * 数学公式背景色列表
   */
  latexMathBackGroupColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 数学公式背景色
   */
  @State
  latexMathBackGroupColor: number | undefined = undefined
  /**
   * 数学公式文本颜色列表
   */
  latexMathTextColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 数学公式文本颜色
   */
  @State
  latexMathTextColor: number | undefined = undefined
  /**
   * 块结构的数学公式是否居中列表
   */
  latexMathBlockCenterList: Array<boolean> = booleanListGeneralData
  /**
   * 块结构的数学公式是否居中
   */
  @State
  latexMathBlockCenter: boolean = false
  /**
   * 数学公式生成图片格式列表
   */
  latexMathColorFormatList: Array<number> =
    [LatexMathColorFormat.COLOR_FORMAT_BGRA_8888, LatexMathColorFormat.COLOR_FORMAT_RGB_565]
  /**
   * 数学公式生成图片格式
   */
  @State
  latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
  /**
   * 数学公式字体路径列表
   */
  latexMathResStrList: Array<string> = ["/data/storage/el1/bundle/entry/resources/resfile/res"]
  /**
   * 数学公式字体路径
   */
  @State
  latexMathResStr: string = "/data/storage/el1/bundle/entry/resources/resfile/res"
  /**
   * 数学公式未加载状态是否显示文字列表
   */
  latexDefaultTextList: Array<boolean> = booleanListGeneralData
  /**
   * 数学公式未加载状态是否显示文字
   */
  @State
  latexDefaultText: boolean = true
  /**
   * 配置数据内容
   */
  @State
  latexMathData: LatexMathData = new LatexMathData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "数学公式配置页面",
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
            titleStr: "数学公式文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.latexMathTextSizeList,
            allData: this.latexMathTextSize
          })
          BaseTabComponent({
            titleStr: "数学公式背景色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.latexMathTextColorList,
            allData: this.latexMathTextColor
          })
          BaseTabComponent({
            titleStr: "数学公式文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.latexMathBackGroupColorList,
            allData: this.latexMathBackGroupColor
          })
          BaseTabComponent({
            titleStr: "数学公式生成图片格式 - ",
            typeEnum: TypeEnum.IS_LATEX_FORMAT,
            allListData: this.latexMathColorFormatList,
            allData: this.latexMathColorFormat
          })
          BaseTabComponent({
            titleStr: "块结构的数学公式是否居中 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.latexMathBlockCenterList,
            allData: this.latexMathBlockCenter
          })
          BaseTabComponent({
            titleStr: "数学公式字体路径 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.latexMathResStrList,
            allData: this.latexMathResStr
          })
          BaseTabComponent({
            titleStr: "数学公式未加载状态是否显示文字 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.latexDefaultTextList,
            allData: this.latexDefaultText
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
                    this.latexMathData.isFull = this.isFull
                    this.latexMathData.incrementalAnalysis = this.incrementalAnalysis
                    this.latexMathData.time = this.time
                    this.latexMathData.textNumber = this.textNumber
                    this.latexMathData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.latexMathData.typeWriterOpen = this.typeWriterOpen
                    this.latexMathData.typeWriterColor = this.typeWriterColor
                    this.latexMathData.isOnCopy = this.isOnCopy
                    this.latexMathData.blockFirstTopMargin = this.blockFirstTopMargin
                    this.latexMathData.blockLastBottomMargin = this.blockLastBottomMargin
                    this.latexMathData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.latexMathData.openGestureSwipe = this.openGestureSwipe
                    this.latexMathData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.latexMathData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.latexMathData.latexMathTextSize = this.latexMathTextSize
                    this.latexMathData.latexMathBackGroupColor = this.latexMathBackGroupColor
                    this.latexMathData.latexMathTextColor = this.latexMathTextColor
                    this.latexMathData.latexMathBlockCenter = this.latexMathBlockCenter
                    this.latexMathData.latexMathColorFormat = this.latexMathColorFormat
                    this.latexMathData.latexMathResStr = this.latexMathResStr
                    this.latexMathData.latexDefaultText = this.latexDefaultText
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/LatexMathDetailsPage", params: this.latexMathData })
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


