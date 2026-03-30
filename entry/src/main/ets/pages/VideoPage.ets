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
import { VideoData } from '../model/VideoData'

@Entry
@Component
struct VideoPage {
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
  rawFilePath: string = "015_视频"
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
   * 视频圆角列表
   */
  videoBorderRadiusList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 视频圆角
   */
  @State
  videoBorderRadius: number = 22
  /**
   * 视频时间文本颜色列表
   */
  videoTimeTextColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 视频时间文本颜色
   */
  @State
  videoTimeTextColor: number | undefined = undefined
  /**
   * 视频时间文本大小列表
   */
  videoTimeTextSizeList: Array<number> = textSizeListGeneralData
  /**
   * 视频时间文本大小
   */
  @State
  videoTimeTextSize: number = 14
  /**
   * 视频上边距列表
   */
  videoTimeTextMarginRightList: Array<number> = marginListGeneralData
  /**
   * 视频上边距
   */
  @State
  videoTimeTextMarginRight: number = 10
  /**
   * 视频下边距列表
   */
  videoTimeTextMarginBottomList: Array<number> = marginListGeneralData
  /**
   * 视频下边距
   */
  @State
  videoTimeTextMarginBottom: number = 10
  /**
   * 视频上边距列表
   */
  videoMarginTopList: Array<number> = marginListGeneralData
  /**
   * 视频上边距
   */
  @State
  videoMarginTop: number = 10
  /**
   * 视频下边距列表
   */
  videoMarginBottomList: Array<number> = marginListGeneralData
  /**
   * 视频下边距
   */
  @State
  videoMarginBottom: number = 10
  /**
   * 视频发布/下载按钮布局是否显示列表
   */
  isVideoBottomLayoutList: Array<boolean> = [true, false]
  /**
   * 视频发布/下载按钮布局是否显示
   */
  @State
  isVideoBottomLayout: boolean = false
  /**
   * 视频发布按钮图片宽度和高度列表
   */
  videoReleaseImageWidthHeightList: Array<number> = [10, 15, 18, 20, 25, 30, 35, 40]
  /**
   * 视频发布按钮图片宽度和高度
   */
  @State
  videoReleaseImageWidthHeight: number = 18
  /**
   * 视频发布按钮宽度列表
   */
  videoReleaseWidthList: Array<number> = [100, 120, 130, 144, 150, 160, 180, 200]
  /**
   * 视频发布按钮宽度
   */
  @State
  videoReleaseWidth: number = 144
  /**
   * 视频发布按钮高度列表
   */
  videoReleaseHeightList: Array<number> = [25, 30, 35, 40, 44, 50, 60, 70, 80]
  /**
   * 视频发布按钮高度
   */
  @State
  videoReleaseHeight: number = 44
  /**
   * 视频发布按钮圆角列表
   */
  videoReleaseRadiusList: Array<number> = [10, 12, 15, 18, 20, 22, 25, 28, 30,35,40]
  /**
   * 视频发布按钮圆角
   */
  @State
  videoReleaseRadius: number = 22
  /**
   * 视频发布按钮文本内容列表
   */
  videoReleaseTextList: Array<string> = ["发布", "提交", "发布视频"]
  /**
   * 视频发布按钮文本内容
   */
  @State
  videoReleaseText: string = "发布视频"
  /**
   * 视频发布按钮文本大小列表
   */
  videoReleaseTexSizeList: Array<number> = textSizeListGeneralData
  /**
   * 视频发布按钮文本大小
   */
  @State
  videoReleaseTexSize: number = 16
  /**
   * 视频发布按钮文本颜色列表
   */
  videoReleaseTexColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 视频发布按钮文本颜色
   */
  @State
  videoReleaseTexColor: number | undefined = undefined
  /**
   * 视频发布按钮背景颜色列表
   */
  videoReleaseBackgroundColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 视频发布按钮背景颜色
   */
  @State
  videoReleaseBackgroundColor: number | undefined = undefined
  /**
   * 视频下载按钮图片宽度和高度列表
   */
  videoDownloadImageWidthHeightList: Array<number> = [10, 15, 18, 20, 25, 30, 35, 40]
  /**
   * 视频下载按钮图片宽度和高度
   */
  @State
  videoDownloadImageWidthHeight: number = 18
  /**
   * 视频下载按钮宽度列表
   */
  videoDownloadWidthList: Array<number> = [100, 120, 130, 144, 150, 160, 180, 200]
  /**
   * 视频下载按钮宽度
   */
  @State
  videoDownloadWidth: number = 144
  /**
   * 视频下载按钮高度列表
   */
  videoDownloadHeightList: Array<number> = [25, 30, 35, 40, 44, 50, 60, 70, 80]
  /**
   * 视频下载按钮高度
   */
  @State
  videoDownloadHeight: number = 44
  /**
   * 视频下载按钮圆角列表
   */
  videoDownloadRadiusList: Array<number> = [10, 12, 15, 18, 20, 22, 25, 28, 30,35,40]
  /**
   * 视频下载按钮圆角
   */
  @State
  videoDownloadRadius: number = 22
  /**
   * 视频下载按钮文本内容列表
   */
  videoDownloadTextList: Array<string> = ["下载", "提交", "下载视频"]
  /**
   * 视频下载按钮文本内容
   */
  @State
  videoDownloadText: string = "下载视频"
  /**
   * 视频下载按钮文本大小列表
   */
  videoDownloadTexSizeList: Array<number> = textSizeListGeneralData
  /**
   * 视频下载按钮文本大小
   */
  @State
  videoDownloadTexSize: number = 16
  /**
   * 视频下载按钮文本颜色列表
   */
  videoDownloadTexColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 视频下载按钮文本颜色
   */
  @State
  videoDownloadTexColor: number | undefined = undefined
  /**
   * 视频下载按钮背景颜色列表
   */
  videoDownloadBackgroundColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 视频下载按钮背景颜色
   */
  @State
  videoDownloadBackgroundColor: number | undefined = undefined
  /**
   * 配置数据内容
   */
  @State
  videoData: VideoData = new VideoData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "视频配置页面",
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
            titleStr: "视频圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoBorderRadiusList,
            allData: this.videoBorderRadius
          })
          BaseTabComponent({
            titleStr: "视频时间文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.videoTimeTextColorList,
            allData: this.videoTimeTextColor
          })
          BaseTabComponent({
            titleStr: "视频时间文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoTimeTextSizeList,
            allData: this.videoTimeTextSize
          })
          BaseTabComponent({
            titleStr: "视频时间文本居右边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoTimeTextMarginRightList,
            allData: this.videoTimeTextMarginRight
          })
          BaseTabComponent({
            titleStr: "视频时间文本居底边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoTimeTextMarginBottomList,
            allData: this.videoTimeTextMarginBottom
          })
          BaseTabComponent({
            titleStr: "视频上边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoMarginTopList,
            allData: this.videoMarginTop
          })
          BaseTabComponent({
            titleStr: "视频下边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoMarginBottomList,
            allData: this.videoMarginBottom
          })
          BaseTabComponent({
            titleStr: "视频发布/下载按钮布局是否显示 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isVideoBottomLayoutList,
            allData: this.isVideoBottomLayout
          })
          BaseTabComponent({
            titleStr: "视频发布按钮图片宽度和高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoReleaseImageWidthHeightList,
            allData: this.videoReleaseImageWidthHeight
          })
          BaseTabComponent({
            titleStr: "视频发布按钮高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoReleaseHeightList,
            allData: this.videoReleaseHeight
          })
          BaseTabComponent({
            titleStr: "视频发布按钮圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoReleaseRadiusList,
            allData: this.videoReleaseRadius
          })
          BaseTabComponent({
            titleStr: "视频发布按钮文本内容 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.videoReleaseTextList,
            allData: this.videoReleaseText
          })
          BaseTabComponent({
            titleStr: "视频发布按钮文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoReleaseTexSizeList,
            allData: this.videoReleaseTexSize
          })
          BaseTabComponent({
            titleStr: "视频发布按钮文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.videoReleaseTexColorList,
            allData: this.videoReleaseTexColor
          })
          BaseTabComponent({
            titleStr: "视频发布按钮背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.videoReleaseBackgroundColorList,
            allData: this.videoReleaseBackgroundColor
          })
          BaseTabComponent({
            titleStr: "视频下载按钮图片宽度和高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoDownloadImageWidthHeightList,
            allData: this.videoDownloadImageWidthHeight
          })
          BaseTabComponent({
            titleStr: "视频下载按钮宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoDownloadWidthList,
            allData: this.videoDownloadWidth
          })
          BaseTabComponent({
            titleStr: "视频下载按钮高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoDownloadHeightList,
            allData: this.videoDownloadHeight
          })
          BaseTabComponent({
            titleStr: "视频下载按钮圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoDownloadRadiusList,
            allData: this.videoDownloadRadius
          })
          BaseTabComponent({
            titleStr: "视频下载按钮文本内容 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.videoDownloadTextList,
            allData: this.videoDownloadText
          })
          BaseTabComponent({
            titleStr: "视频下载按钮文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoDownloadTexSizeList,
            allData: this.videoDownloadTexSize
          })
          BaseTabComponent({
            titleStr: "视频下载按钮文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.videoDownloadTexColorList,
            allData: this.videoDownloadTexColor
          })
          BaseTabComponent({
            titleStr: "视频下载按钮背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.videoDownloadBackgroundColorList,
            allData: this.videoDownloadBackgroundColor
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
                    this.videoData.isFull = this.isFull
                    this.videoData.incrementalAnalysis = this.incrementalAnalysis
                    this.videoData.time = this.time
                    this.videoData.textNumber = this.textNumber
                    this.videoData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.videoData.typeWriterOpen = this.typeWriterOpen
                    this.videoData.typeWriterColor = this.typeWriterColor
                    this.videoData.isOnCopy = this.isOnCopy
                    this.videoData.blockFirstTopMargin = this.blockFirstTopMargin
                    this.videoData.blockLastBottomMargin = this.blockLastBottomMargin
                    this.videoData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.videoData.openGestureSwipe = this.openGestureSwipe
                    this.videoData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.videoData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.videoData.videoBorderRadius = this.videoBorderRadius
                    this.videoData.videoTimeTextColor = this.videoTimeTextColor
                    this.videoData.videoTimeTextSize = this.videoTimeTextSize
                    this.videoData.videoTimeTextMarginRight = this.videoTimeTextMarginRight
                    this.videoData.videoTimeTextMarginBottom = this.videoTimeTextMarginBottom
                    this.videoData.videoMarginTop = this.videoMarginTop
                    this.videoData.videoMarginBottom = this.videoMarginBottom
                    this.videoData.isVideoBottomLayout = this.isVideoBottomLayout
                    this.videoData.videoReleaseImageWidthHeight = this.videoReleaseImageWidthHeight
                    this.videoData.videoReleaseWidth = this.videoReleaseWidth
                    this.videoData.videoReleaseHeight = this.videoReleaseHeight
                    this.videoData.videoReleaseRadius = this.videoReleaseRadius
                    this.videoData.videoReleaseText = this.videoReleaseText
                    this.videoData.videoReleaseTexSize = this.videoReleaseTexSize
                    this.videoData.videoReleaseTexColor = this.videoReleaseTexColor
                    this.videoData.videoReleaseBackgroundColor = this.videoReleaseBackgroundColor
                    this.videoData.videoDownloadImageWidthHeight = this.videoDownloadImageWidthHeight
                    this.videoData.videoDownloadWidth = this.videoDownloadWidth
                    this.videoData.videoDownloadHeight = this.videoDownloadHeight
                    this.videoData.videoDownloadRadius = this.videoDownloadRadius
                    this.videoData.videoDownloadText = this.videoDownloadText
                    this.videoData.videoDownloadTexSize = this.videoDownloadTexSize
                    this.videoData.videoDownloadTexColor = this.videoDownloadTexColor
                    this.videoData.videoDownloadBackgroundColor = this.videoDownloadBackgroundColor
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/VideoDetailsPage", params: this.videoData })
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


