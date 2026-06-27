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

@Entry
@Component
struct LatexMathPage {
  // ---------------- 通用
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop')
  safeTop: number = 0
  rawFilePath: string = "005_LatexMath"
  @State
  folderList: Array<string> = new Array<string>()
  isFullList: Array<boolean> = booleanListGeneralData
  @State
  isFull: boolean = true
  incrementalAnalysisList: Array<boolean> = booleanListGeneralData
  @State
  incrementalAnalysis: boolean = false
  timeList: Array<number> = timeListGeneralData
  @State
  time: number = 50
  textNumberList: Array<number> = textNumberListGeneralData
  @State
  textNumber: number = 10
  isMarkdownParserSyncList: Array<boolean> = booleanListGeneralData
  @State
  isMarkdownParserSync: boolean = false
  isOnCopyList: Array<boolean> = booleanListGeneralData
  @State
  isOnCopy: boolean = false
  blockFirstTopMarginList: Array<number> = marginListGeneralData
  @State
  blockFirstTopMargin: number = 8
  blockLastBottomMarginList: Array<number> = marginListGeneralData
  @State
  blockLastBottomMargin: number = 8
  blockTopAndBottomMarginsList: Array<number> = marginListGeneralData
  @State
  blockTopAndBottomMargins: number = 8
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  @State
  openGestureSwipe: boolean = false
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  @State
  openGestureSwipeTest: boolean = false

  // ---------------- 专有
  latexMathTextSizeList: Array<number> = textSizeListGeneralData
  @State
  latexMathTextSize: number = 14
  latexMathTextColorList: Array<number | undefined> = colorListGeneralData
  @State
  latexMathTextColor: number | undefined = 0xFF000000
  latexMathBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State
  latexMathBackgroundColor: number | undefined = 0x00000000
  latexMathColorFormatList: Array<number> = [0, 1]
  @State
  latexMathColorFormat: number = 1
  latexMathBlockCenterList: Array<boolean> = booleanListGeneralData
  @State
  latexMathBlockCenter: boolean = true
  latexMathDefaultTextList: Array<boolean> = booleanListGeneralData
  @State
  latexMathDefaultText: boolean = true
  @State
  latexMathData: LatexMathData = new LatexMathData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "LatexMath配置页面",
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
            titleStr: "数学公式文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.latexMathTextSizeList,
            allData: this.latexMathTextSize
          })
          BaseTabComponent({
            titleStr: "数学公式文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.latexMathTextColorList,
            allData: this.latexMathTextColor
          })
          BaseTabComponent({
            titleStr: "数学公式背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.latexMathBackgroundColorList,
            allData: this.latexMathBackgroundColor
          })
          BaseTabComponent({
            titleStr: "数学公式图片格式(0:RGB_565,1:BGRA_8888) - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.latexMathColorFormatList,
            allData: this.latexMathColorFormat
          })
          BaseTabComponent({
            titleStr: "块级数学公式是否居中 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.latexMathBlockCenterList,
            allData: this.latexMathBlockCenter
          })
          BaseTabComponent({
            titleStr: "未加载状态是否显示文字 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.latexMathDefaultTextList,
            allData: this.latexMathDefaultText
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
                    this.latexMathData.isOnCopy = this.isOnCopy
                    this.latexMathData.blockFirstTopMargin = this.blockFirstTopMargin
                    this.latexMathData.blockLastBottomMargin = this.blockLastBottomMargin
                    this.latexMathData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.latexMathData.openGestureSwipe = this.openGestureSwipe
                    this.latexMathData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.latexMathData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.latexMathData.latexMathTextSize = this.latexMathTextSize
                    this.latexMathData.latexMathTextColor = this.latexMathTextColor
                    this.latexMathData.latexMathBackgroundColor = this.latexMathBackgroundColor
                    this.latexMathData.latexMathColorFormat = this.latexMathColorFormat
                    this.latexMathData.latexMathBlockCenter = this.latexMathBlockCenter
                    this.latexMathData.latexMathDefaultText = this.latexMathDefaultText
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
