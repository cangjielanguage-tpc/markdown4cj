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
import { AudioMDData } from '../model/AudioMDData'

@Entry
@Component
struct AudioPage {
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
  rawFilePath: string = "014_音频"
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
   * 音频阴影颜色值列表
   */
  audioShadowColorList: Array<number> = colorListGeneralData
  /**
   * 音频阴影颜色值
   */
  @State
  audioShadowColor: number = 0xFF808080
  /**
   * 音频边框颜色列表
   */
  audioBorderColorList: Array<number> = colorListGeneralData
  /**
   * 音频边框颜色
   */
  @State
  audioBorderColor: number = 0xFF808080
  /**
   * 音频边框粗细列表
   */
  audioBorderWidthList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  /**
   * 音频边框粗细
   */
  @State
  audioBorderWidth: number = 0.5
  /**
   * 音频边框圆角列表
   */
  audioBorderRadiusList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 音频边框圆角
   */
  @State
  audioBorderRadius: number = 12
  /**
   * 音频按钮背景颜色列表
   */
  audioButtonBackgroundColorList: Array<number> = colorListGeneralData
  /**
   * 音频按钮背景颜色
   */
  @State
  audioButtonBackgroundColor: number = 0xFF000000
  /**
   * 音频按钮文字颜色列表
   */
  audioButtonTextColorList: Array<number> = colorListGeneralData
  /**
   * 音频按钮文字颜色
   */
  @State
  audioButtonTextColor: number = 0xFFFFFFFF
  /**
   * 音频按钮文字大小列表
   */
  audioButtonTextSizeList: Array<number> = textSizeListGeneralData
  /**
   * 音频按钮文字大小
   */
  @State
  audioButtonTextSize: number = 14
  /**
   * 音频按钮文字内容列表
   */
  audioButtonTextList: Array<string> = [`立即播放`, `超长长长长长长长的按钮`]
  /**
   * 音频按钮文字内容
   */
  @State
  audioButtonText: string = `立即播放`
  /**
   * 音频按钮圆角列表
   */
  audioButtonBorderRadiusList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 音频按钮圆角
   */
  @State
  audioButtonBorderRadius: number = 16
  /**
   * 音频标题文字大小列表
   */
  audioTitleTextSizeList: Array<number> = textSizeListGeneralData
  /**
   * 音频标题文字大小
   */
  @State
  audioTitleTextSize: number = 15
  /**
   * 音频标题文字颜色列表
   */
  audioTitleTextColorList: Array<number> = colorListGeneralData
  /**
   * 音频标题文字颜色
   */
  @State
  audioTitleTextColor: number = 0xFF000000
  /**
   * 音频标题文字行高列表
   */
  audioTitleTextLineHeightList: Array<number> = textLineHeightListGeneralData
  /**
   * 音频标题文字行高
   */
  @State
  audioTitleTextLineHeight: number = 20
  /**
   * 音频类型文字大小列表
   */
  audioTypeTextSizeList: Array<number> = textSizeListGeneralData
  /**
   * 音频类型文字大小
   */
  @State
  audioTypeTextSize: number = 11
  /**
   * 音频类型文字颜色列表
   */
  audioTypeTextColorList: Array<number> = colorListGeneralData
  /**
   * 音频类型文字颜色
   */
  @State
  audioTypeTextColor: number = 0x80000000
  /**
   * 音频类型文字行高列表
   */
  audioTypeTextLineHeightList: Array<number> = textLineHeightListGeneralData
  /**
   * 音频类型文字行高
   */
  @State
  audioTypeTextLineHeight: number = 15
  /**
   * 音频上边距列表
   */
  audioMarginTopList: Array<number> = marginListGeneralData
  /**
   * 音频上边距
   */
  @State
  audioMarginTop: number = 10
  /**
   * 音频下边距列表
   */
  audioMarginBottomList: Array<number> = marginListGeneralData
  /**
   * 音频下边距
   */
  @State
  audioMarginBottom: number = 10
  /**
   * 配置数据内容
   */
  @State
  audioData: AudioMDData = new AudioMDData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "音频配置页面",
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
            titleStr: "音频阴影颜色值 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.audioShadowColorList,
            allData: this.audioShadowColor
          })
          BaseTabComponent({
            titleStr: "音频边框颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.audioBorderColorList,
            allData: this.audioBorderColor
          })
          BaseTabComponent({
            titleStr: "音频边框粗细 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioBorderWidthList,
            allData: this.audioBorderWidth
          })
          BaseTabComponent({
            titleStr: "音频边框圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioBorderRadiusList,
            allData: this.audioBorderRadius
          })
          BaseTabComponent({
            titleStr: "音频按钮背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.audioButtonBackgroundColorList,
            allData: this.audioButtonBackgroundColor
          })
          BaseTabComponent({
            titleStr: "音频按钮文字颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.audioButtonTextColorList,
            allData: this.audioButtonTextColor
          })
          BaseTabComponent({
            titleStr: "音频按钮文字大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioButtonTextSizeList,
            allData: this.audioButtonTextSize
          })
          BaseTabComponent({
            titleStr: "音频按钮文字内容 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.audioButtonTextList,
            allData: this.audioButtonText
          })
          BaseTabComponent({
            titleStr: "音频按钮圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioButtonBorderRadiusList,
            allData: this.audioButtonBorderRadius
          })
          BaseTabComponent({
            titleStr: "音频标题文字大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioTitleTextSizeList,
            allData: this.audioTitleTextSize
          })
          BaseTabComponent({
            titleStr: "音频标题文字颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.audioTitleTextColorList,
            allData: this.audioTitleTextColor
          })
          BaseTabComponent({
            titleStr: "音频标题文字行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioTitleTextLineHeightList,
            allData: this.audioTitleTextLineHeight
          })
          BaseTabComponent({
            titleStr: "音频类型文字大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioTypeTextSizeList,
            allData: this.audioTypeTextSize
          })
          BaseTabComponent({
            titleStr: "音频类型文字颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.audioTypeTextColorList,
            allData: this.audioTypeTextColor
          })
          BaseTabComponent({
            titleStr: "音频类型文字行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioTypeTextLineHeightList,
            allData: this.audioTypeTextLineHeight
          })
          BaseTabComponent({
            titleStr: "音频上边距 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.audioMarginTopList,
            allData: this.audioMarginTop
          })
          BaseTabComponent({
            titleStr: "音频下边距 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.audioMarginBottomList,
            allData: this.audioMarginBottom
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
                    this.audioData.isFull = this.isFull
                    this.audioData.incrementalAnalysis = this.incrementalAnalysis
                    this.audioData.time = this.time
                    this.audioData.textNumber = this.textNumber
                    this.audioData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.audioData.typeWriterOpen = this.typeWriterOpen
                    this.audioData.typeWriterColor = this.typeWriterColor
                    this.audioData.isOnCopy = this.isOnCopy
                    this.audioData.blockFirstTopMargin = this.blockFirstTopMargin
                    this.audioData.blockLastBottomMargin = this.blockLastBottomMargin
                    this.audioData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.audioData.openGestureSwipe = this.openGestureSwipe
                    this.audioData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.audioData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.audioData.audioShadowColor = this.audioShadowColor
                    this.audioData.audioBorderColor = this.audioBorderColor
                    this.audioData.audioBorderWidth = this.audioBorderWidth
                    this.audioData.audioBorderRadius = this.audioBorderRadius
                    this.audioData.audioButtonBackgroundColor = this.audioButtonBackgroundColor
                    this.audioData.audioButtonTextColor = this.audioButtonTextColor
                    this.audioData.audioButtonTextSize = this.audioButtonTextSize
                    this.audioData.audioButtonText = this.audioButtonText
                    this.audioData.audioButtonBorderRadius = this.audioButtonBorderRadius
                    this.audioData.audioTitleTextSize = this.audioTitleTextSize
                    this.audioData.audioTitleTextColor = this.audioTitleTextColor
                    this.audioData.audioTitleTextLineHeight = this.audioTitleTextLineHeight
                    this.audioData.audioTypeTextSize = this.audioTypeTextSize
                    this.audioData.audioTypeTextColor = this.audioTypeTextColor
                    this.audioData.audioTypeTextLineHeight = this.audioTypeTextLineHeight
                    this.audioData.audioMarginTop = this.audioMarginTop
                    this.audioData.audioMarginBottom = this.audioMarginBottom
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/AudioDetailsPage", params: this.audioData })
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


