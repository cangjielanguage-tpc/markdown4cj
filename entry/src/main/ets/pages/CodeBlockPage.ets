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
  timeListGeneralData
} from '../model/GeneralData'
import { CodeBlockData } from '../model/CodeBlockData'

@Entry
@Component
struct CodeBlockPage {
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
  rawFilePath: string = "011_代码块"
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
   * 是否格式化代码块内容列表
   */
  isCodeFormatList: Array<boolean> = booleanListGeneralData
  /**
   * 是否格式化代码块内容
   */
  @State
  isCodeFormat: boolean = false
  /**
   * 代码块代码文本颜色列表
   */
  codeBlockTextColorList: Array<number> = colorListGeneralData
  /**
   * 代码块代码文本颜色
   */
  @State
  codeBlockTextColor: number = 0xFF191919
  /**
   * 代码块代码类型文本颜色列表
   */
  codeBlockTypeTextColorList: Array<number> = colorListGeneralData
  /**
   * 代码块代码类型文本颜色
   */
  @State
  codeBlockTypeTextColor: number = 0xFF191919
  /**
   * 代码块代码类型文本列表
   */
  codeBlockTypeTextStrList: Array<string> = ["", "代码块", "默认文本"]
  /**
   * 代码块代码类型文本
   */
  @State
  codeBlockTypeTextStr: string = ""
  /**
   * 代码类型和代码块距离列表
   */
  codeBlockTypeTextPaddingList: Array<number> = marginListGeneralData
  /**
   * 代码类型和代码块距离
   */
  @State
  codeBlockTypeTextPadding: number = 0
  /**
   * 代码块复制、全屏图片文字是否显示列表
   */
  codeBlockIconTextHideList: Array<boolean> = booleanListGeneralData
  /**
   * 代码块复制、全屏图片文字是否显示
   */
  @State
  codeBlockIconTextHide: boolean = true
  /**
   * 代码块代码行号是否显示列表
   */
  codeBlockLineNumberHideList: Array<boolean> = booleanListGeneralData
  /**
   * 代码块代码行号是否显示
   */
  @State
  codeBlockLineNumberHide: boolean = true
  /**
   * 代码块背景颜色列表
   */
  codeBlockBackgroundColorList: Array<number> = colorListGeneralData
  /**
   * 代码块背景颜色
   */
  @State
  codeBlockBackgroundColor: number = 0xFF191919
  /**
   * 代码块左边距列表
   */
  codeMultilineMarginList: Array<number> = marginListGeneralData
  /**
   * 代码块左边距
   */
  @State
  codeMultilineMargin: number = 8
  /**
   * 代码块字体列表
   */
  codeBlockTypefaceList: Array<string> = ["HarmonyOS Sans", "Hei"]
  /**
   * 代码块字体
   */
  @State
  codeBlockTypeface: string = "HarmonyOS Sans"
  /**
   * 代码块代码文本大小列表
   */
  codeBlockTextSizeList: Array<number> = textSizeListGeneralData
  /**
   * 代码块代码文本大小
   */
  @State
  codeBlockTextSize: number = 13
  /**
   * 代码块代码文本行高列表
   */
  codeBlockLineHeightList: Array<number> = textLineHeightListGeneralData
  /**
   * 代码块代码文本行高
   */
  @State
  codeBlockLineHeight: number = 22
  /**
   * 代码块控件圆角大小列表
   */
  codeBlockRadiusList: Array<number> = [0, 5, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 代码块控件圆角大小
   */
  @State
  codeBlockRadius: number = 8
  /**
   * 代码块代码全屏按钮是否显示列表
   */
  isCodeFullScreenList: Array<boolean> = booleanListGeneralData
  /**
   * 代码块代码全屏按钮是否显示
   */
  @State
  isCodeFullScreen: boolean = true
  /**
   * 代码块代码全屏、代码复制按钮宽高列表
   */
  iconWidthAndHeightList: Array<number> = [0, 5, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 代码块代码全屏、代码复制按钮宽高
   */
  @State
  iconWidthAndHeight: number = 24
  /**
   * 代码块深浅色模式列表
   */
  isDarkList: Array<boolean> = booleanListGeneralData
  /**
   * 代码块深浅色模式
   */
  @State
  isDark: boolean = true
  /**
   * codeformat是否使用制表符
   */
  @State
  useTab: boolean = false
  /**
   * codeformat是否使用制表符列表
   */
  useTabList: Array<boolean> = booleanListGeneralData
  /**
   * codeformat空格缩进数量
   */
  @State
  indentWidth: number = 4
  /**
   * codeformat空格缩进数量列表
   */
  indentWidthList: Array<number> = [0, 2, 4, 6, 8, 10]
  /**
   * 配置数据内容
   */
  @State
  codeBlockData: CodeBlockData = new CodeBlockData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "代码块配置页面",
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
            titleStr: "代码块代码文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeBlockTextColorList,
            allData: this.codeBlockTextColor
          })
          BaseTabComponent({
            titleStr: "代码块代码类型文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeBlockTypeTextColorList,
            allData: this.codeBlockTypeTextColor
          })
          BaseTabComponent({
            titleStr: "设置代码块代码类型文本 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.codeBlockTypeTextStrList,
            allData: this.codeBlockTypeTextStr
          })
          BaseTabComponent({
            titleStr: "设置代码类型和代码块距离 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeBlockTypeTextPaddingList,
            allData: this.codeBlockTypeTextPadding
          })
          BaseTabComponent({
            titleStr: "代码块复制、全屏图片文字是否显示 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.codeBlockIconTextHideList,
            allData: this.codeBlockIconTextHide
          })
          BaseTabComponent({
            titleStr: "代码块代码行号是否显示 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.codeBlockLineNumberHideList,
            allData: this.codeBlockLineNumberHide
          })
          BaseTabComponent({
            titleStr: "代码块左边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeBlockBackgroundColorList,
            allData: this.codeBlockBackgroundColor
          })
          BaseTabComponent({
            titleStr: "代码块字体 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeBlockTypefaceList,
            allData: this.codeBlockTypeface
          })
          BaseTabComponent({
            titleStr: "代码块代码文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeBlockTextSizeList,
            allData: this.codeBlockTextSize
          })
          BaseTabComponent({
            titleStr: "代码块代码文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeBlockLineHeightList,
            allData: this.codeBlockLineHeight
          })
          BaseTabComponent({
            titleStr: "代码块控件圆角大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeBlockRadiusList,
            allData: this.codeBlockRadius
          })
          BaseTabComponent({
            titleStr: "代码块代码全屏按钮是否显示 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isCodeFullScreenList,
            allData: this.isCodeFullScreen
          })
          BaseTabComponent({
            titleStr: "代码块代码全屏、代码复制按钮宽高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.iconWidthAndHeightList,
            allData: this.iconWidthAndHeight
          })
          BaseTabComponent({
            titleStr: "代码块深浅色模式 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isDarkList,
            allData: this.isDark
          })
          BaseTabComponent({
            titleStr: "是否格式化代码块内容 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isCodeFormatList,
            allData: this.isCodeFormat
          })
          BaseTabComponent({
            titleStr: "codeformat是否使用制表符 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.useTabList,
            allData: this.useTab
          })
          BaseTabComponent({
            titleStr: "codeformat空格缩进数量 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.indentWidthList,
            allData: this.indentWidth
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
                    this.codeBlockData.isFull = this.isFull
                    this.codeBlockData.incrementalAnalysis = this.incrementalAnalysis
                    this.codeBlockData.time = this.time
                    this.codeBlockData.textNumber = this.textNumber
                    this.codeBlockData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.codeBlockData.typeWriterOpen = this.typeWriterOpen
                    this.codeBlockData.typeWriterColor = this.typeWriterColor
                    this.codeBlockData.isOnCopy = this.isOnCopy
                    this.codeBlockData.blockFirstTopMargin = this.blockFirstTopMargin
                    this.codeBlockData.blockLastBottomMargin = this.blockLastBottomMargin
                    this.codeBlockData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.codeBlockData.openGestureSwipe = this.openGestureSwipe
                    this.codeBlockData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.codeBlockData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.codeBlockData.isCodeFormat = this.isCodeFormat
                    this.codeBlockData.codeBlockTextColor = this.codeBlockTextColor
                    this.codeBlockData.codeBlockTypeTextColor = this.codeBlockTypeTextColor
                    this.codeBlockData.codeBlockTypeTextStr = this.codeBlockTypeTextStr
                    this.codeBlockData.codeBlockTypeTextPadding = this.codeBlockTypeTextPadding
                    this.codeBlockData.codeBlockIconTextHide = this.codeBlockIconTextHide
                    this.codeBlockData.codeBlockLineNumberHide = this.codeBlockLineNumberHide
                    this.codeBlockData.codeBlockBackgroundColor = this.codeBlockBackgroundColor
                    this.codeBlockData.codeMultilineMargin = this.codeMultilineMargin
                    this.codeBlockData.codeBlockTypeface = this.codeBlockTypeface
                    this.codeBlockData.codeBlockTextSize = this.codeBlockTextSize
                    this.codeBlockData.codeBlockLineHeight = this.codeBlockLineHeight
                    this.codeBlockData.codeBlockRadius = this.codeBlockRadius
                    this.codeBlockData.isCodeFullScreen = this.isCodeFullScreen
                    this.codeBlockData.iconWidthAndHeight = this.iconWidthAndHeight
                    this.codeBlockData.iconWidthAndHeight = this.iconWidthAndHeight
                    this.codeBlockData.isDark = this.isDark
                    this.codeBlockData.useTab = this.useTab
                    this.codeBlockData.indentWidth = this.indentWidth
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/CodeBlockDetailsPage", params: this.codeBlockData })
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


