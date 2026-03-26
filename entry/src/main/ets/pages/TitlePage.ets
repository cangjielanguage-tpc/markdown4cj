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
import { TitleData } from '../model/TitleData'

@Entry
@Component
struct TitlePage {
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
  rawFilePath: string = "001_标题"
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
   * H1、H2下划线高度列表
   */
  headingBreakHeightList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  /**
   * H1、H2下划线高度
   */
  @State
  headingBreakHeight: number = 1
  /**
   * H1下划线颜色列表
   */
  headingBreakColorList1: Array<number> = colorListGeneralData
  /**
   * H1下划线颜色
   */
  @State
  headingBreakColor1: number = 0xFF000000
  /**
   * H2下划线颜色列表
   */
  headingBreakColorList2: Array<number> = colorListGeneralData
  /**
   * H2下划线颜色
   */
  @State
  headingBreakColor2: number = 0xFF000000
  /**
   * 标题文本字间距列表
   */
  headingTextWordSpaceList: Array<number> = textWordSpaceListGeneralData
  /**
   * 标题文本字间距
   */
  @State
  headingTextWordSpace: number = 0
  /**
   * 一级标题行高列表
   */
  headingTextLineHeight1List: Array<number> = textLineHeightListGeneralData
  /**
   * 一级标题行高
   */
  @State
  headingTextLineHeight1: number = 22
  /**
   * 二级标题行高列表
   */
  headingTextLineHeight2List: Array<number> = textLineHeightListGeneralData
  /**
   * 二级标题行高
   */
  @State
  headingTextLineHeight2: number = 22
  /**
   * 三级标题行高列表
   */
  headingTextLineHeight3List: Array<number> = textLineHeightListGeneralData
  /**
   * 三级标题行高
   */
  @State
  headingTextLineHeight3: number = 22
  /**
   * 四级标题行高列表
   */
  headingTextLineHeight4List: Array<number> = textLineHeightListGeneralData
  /**
   * 四级标题行高
   */
  @State
  headingTextLineHeight4: number = 22
  /**
   * 五级标题行高列表
   */
  headingTextLineHeight5List: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 五级标题行高
   */
  @State
  headingTextLineHeight5: number = 22
  /**
   * 六级标题行高列表
   */
  headingTextLineHeight6List: Array<number> = textLineHeightListGeneralData
  /**
   * 六级标题行高
   */
  @State
  headingTextLineHeight6: number = 22
  /**
   * 标题文本大小数组1
   */
  @State
  headingTextSizeMultipliersList1: Array<number> = textSizeListGeneralData
  /**
   * 标题文本大小1
   */
  @State
  headingTextSizeMultipliers1: number = 20
  /**
   * 标题文本大小数组2
   */
  @State
  headingTextSizeMultipliersList2: Array<number> = textSizeListGeneralData
  /**
   * 标题文本大小2
   */
  @State
  headingTextSizeMultipliers2: number = 17
  /**
   * 标题文本大小数组3
   */
  @State
  headingTextSizeMultipliersList3: Array<number> = textSizeListGeneralData
  /**
   * 标题文本大小3
   */
  @State
  headingTextSizeMultipliers3: number = 16
  /**
   * 标题文本大小数组4
   */
  @State
  headingTextSizeMultipliersList4: Array<number> = textSizeListGeneralData
  /**
   * 标题文本大小4
   */
  @State
  headingTextSizeMultipliers4: number = 15
  /**
   * 标题文本大小数组5
   */
  @State
  headingTextSizeMultipliersList5: Array<number> = textSizeListGeneralData
  /**
   * 标题文本大小5
   */
  @State
  headingTextSizeMultipliers5: number = 15
  /**
   * 标题文本大小数组6
   */
  @State
  headingTextSizeMultipliersList6: Array<number> = textSizeListGeneralData
  /**
   * 标题文本大小6
   */
  @State
  headingTextSizeMultipliers6: number = 13
  /**
   * 标题文本字体列表
   */
  headingTypefaceList: Array<string> = textTypefaceListGeneralData
  /**
   * 标题文本字体
   */
  @State
  headingTypeface: string = "HarmonyOS Sans"
  /**
   * 标题模块上间距列表
   */
  headingTopMarginsList: Array<number> = marginListGeneralData
  /**
   * 标题模块上间距
   */
  @State
  headingTopMargins: number = 8
  /**
   * 标题模块下间距列表
   */
  headingBottomMarginsList: Array<number> = marginListGeneralData
  /**
   * 标题模块下间距
   */
  @State
  headingBottomMargins: number = 8
  /**
   * 标题文本颜色数组1
   */
  @State
  headingTextColorsList1: Array<number> = colorListGeneralData
  /**
   * 标题文本颜色1
   */
  @State
  headingTextColors1: number = 0xFF000000
  /**
   * 标题文本颜色数组2
   */
  @State
  headingTextColorsList2: Array<number> = colorListGeneralData
  /**
   * 标题文本颜色2
   */
  @State
  headingTextColors2: number = 0xFF000000
  /**
   * 标题文本颜色数组3
   */
  @State
  headingTextColorsList3: Array<number> = colorListGeneralData
  /**
   * 标题文本颜色3
   */
  @State
  headingTextColors3: number = 0xFF000000
  /**
   * 标题文本颜色数组4
   */
  @State
  headingTextColorsList4: Array<number> = colorListGeneralData
  /**
   * 标题文本颜色4
   */
  @State
  headingTextColors4: number = 0xFF000000
  /**
   * 标题文本颜色数组5
   */
  @State
  headingTextColorsList5: Array<number> = colorListGeneralData
  /**
   * 标题文本颜色5
   */
  @State
  headingTextColors5: number = 0xFF000000
  /**
   * 标题文本颜色数组6
   */
  @State
  headingTextColorsList6: Array<number> = colorListGeneralData
  /**
   * 标题文本颜色6
   */
  @State
  headingTextColors6: number = 0xFF000000
  /**
   * 配置数据内容
   */
  @State
  titleData: TitleData = new TitleData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "标题配置页面",
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
            titleStr: "H1、H2下划线高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingBreakHeightList,
            allData: this.headingBreakHeight
          })
          BaseTabComponent({
            titleStr: "H1下划线颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingBreakColorList1,
            allData: this.headingBreakColor1
          })
          BaseTabComponent({
            titleStr: "H2下划线颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingBreakColorList2,
            allData: this.headingBreakColor2
          })
          BaseTabComponent({
            titleStr: "标题文本字间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextWordSpaceList,
            allData: this.headingTextWordSpace
          })
          BaseTabComponent({
            titleStr: "一级标题行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextLineHeight1List,
            allData: this.headingTextLineHeight1
          })
          BaseTabComponent({
            titleStr: "二级标题行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextLineHeight2List,
            allData: this.headingTextLineHeight2
          })
          BaseTabComponent({
            titleStr: "三级标题行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextLineHeight3List,
            allData: this.headingTextLineHeight3
          })
          BaseTabComponent({
            titleStr: "四级标题行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextLineHeight4List,
            allData: this.headingTextLineHeight4
          })
          BaseTabComponent({
            titleStr: "五级标题行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextLineHeight5List,
            allData: this.headingTextLineHeight5
          })
          BaseTabComponent({
            titleStr: "六级标题行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextLineHeight6List,
            allData: this.headingTextLineHeight6
          })

          BaseTabComponent({
            titleStr: "一级标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextSizeMultipliersList1,
            allData: this.headingTextSizeMultipliers1
          })
          BaseTabComponent({
            titleStr: "二级标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextSizeMultipliersList2,
            allData: this.headingTextSizeMultipliers2
          })
          BaseTabComponent({
            titleStr: "三级标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextSizeMultipliersList3,
            allData: this.headingTextSizeMultipliers3
          })
          BaseTabComponent({
            titleStr: "四级标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextSizeMultipliersList4,
            allData: this.headingTextSizeMultipliers4
          })
          BaseTabComponent({
            titleStr: "五级标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextSizeMultipliersList5,
            allData: this.headingTextSizeMultipliers5
          })
          BaseTabComponent({
            titleStr: "六级标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTextSizeMultipliersList6,
            allData: this.headingTextSizeMultipliers6
          })

          BaseTabComponent({
            titleStr: "一级标题颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingTextColorsList1,
            allData: this.headingTextColors1
          })
          BaseTabComponent({
            titleStr: "二级标题颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingTextColorsList2,
            allData: this.headingTextColors2
          })
          BaseTabComponent({
            titleStr: "三级标题颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingTextColorsList3,
            allData: this.headingTextColors3
          })
          BaseTabComponent({
            titleStr: "四级标题颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingTextColorsList4,
            allData: this.headingTextColors4
          })
          BaseTabComponent({
            titleStr: "五级标题颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingTextColorsList5,
            allData: this.headingTextColors5
          })
          BaseTabComponent({
            titleStr: "六级标题颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.headingTextColorsList6,
            allData: this.headingTextColors6
          })

          BaseTabComponent({
            titleStr: "标题文本字体 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.headingTypefaceList,
            allData: this.headingTypeface
          })
          BaseTabComponent({
            titleStr: "标题模块上间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingTopMarginsList,
            allData: this.headingTopMargins
          })
          BaseTabComponent({
            titleStr: "标题模块下间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.headingBottomMarginsList,
            allData: this.headingBottomMargins
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
                    this.titleData.isFull = this.isFull
                    this.titleData.incrementalAnalysis = this.incrementalAnalysis
                    this.titleData.time = this.time
                    this.titleData.textNumber = this.textNumber
                    this.titleData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.titleData.isOnCopy = this.isOnCopy
                    this.titleData.blockFirstTopMargin = this.blockFirstTopMargin
                    this.titleData.blockLastBottomMargin = this.blockLastBottomMargin
                    this.titleData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.titleData.openGestureSwipe = this.openGestureSwipe
                    this.titleData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.titleData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.titleData.headingBreakHeight = this.headingBreakHeight
                    this.titleData.headingBreakColor1 = this.headingBreakColor1
                    this.titleData.headingBreakColor2 = this.headingBreakColor2
                    this.titleData.headingTextWordSpace = this.headingTextWordSpace
                    this.titleData.headingTextLineHeight1 = this.headingTextLineHeight1
                    this.titleData.headingTextLineHeight2 = this.headingTextLineHeight2
                    this.titleData.headingTextLineHeight3 = this.headingTextLineHeight3
                    this.titleData.headingTextLineHeight4 = this.headingTextLineHeight4
                    this.titleData.headingTextLineHeight5 = this.headingTextLineHeight5
                    this.titleData.headingTextLineHeight6 = this.headingTextLineHeight6
                    this.titleData.headingTextSizeMultipliers1 = this.headingTextSizeMultipliers1
                    this.titleData.headingTextSizeMultipliers2 = this.headingTextSizeMultipliers2
                    this.titleData.headingTextSizeMultipliers3 = this.headingTextSizeMultipliers3
                    this.titleData.headingTextSizeMultipliers4 = this.headingTextSizeMultipliers4
                    this.titleData.headingTextSizeMultipliers5 = this.headingTextSizeMultipliers5
                    this.titleData.headingTextSizeMultipliers6 = this.headingTextSizeMultipliers6
                    this.titleData.headingTypeface = this.headingTypeface
                    this.titleData.headingTopMargins = this.headingTopMargins
                    this.titleData.headingBottomMargins = this.headingBottomMargins
                    this.titleData.headingTextColors1 = this.headingTextColors1
                    this.titleData.headingTextColors2 = this.headingTextColors2
                    this.titleData.headingTextColors3 = this.headingTextColors3
                    this.titleData.headingTextColors4 = this.headingTextColors4
                    this.titleData.headingTextColors5 = this.headingTextColors5
                    this.titleData.headingTextColors6 = this.headingTextColors6
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/TitleDetailsPage", params: this.titleData })
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


