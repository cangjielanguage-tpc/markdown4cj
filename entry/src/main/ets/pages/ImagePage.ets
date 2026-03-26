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
import { ImageDataMD } from '../model/ImageDataMD'

@Entry
@Component
struct ImagePage {
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
  rawFilePath: string = "016_图片"
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
   * 是否触发图片替换事件列表
   */
  callbackList: Array<boolean> = booleanListGeneralData
  /**
   * 是否触发图片替换事件
   */
  @State
  callback: boolean = false
  /**
   * 图片默认占位图选项列表
   */
  imageResourceList: Array<Resource | undefined> = [undefined, $r('app.media.startIcon')]
  /**
   * 图片默认占位图
   */
  @State
  imageResource: Resource | undefined = undefined
  /**
   * 网络图片是否压缩列表
   */
  isAutoResizeList: Array<boolean> = booleanListGeneralData
  /**
   * 网络图片是否压缩
   */
  @State
  isAutoResize: boolean = true
  /**
   * 图片上边距列表
   */
  imageMarginTopList: Array<number> = [0, 5, 10, 20, 25, 30, 40, 50, 55, 60, 65, 70, 75, 80, 100]
  /**
   * 图片上边距
   */
  @State
  imageMarginTop: number = 10
  /**
   * 图片下边距列表
   */
  imageMarginBottomList: Array<number> = [0, 5, 10, 20, 25, 30, 40, 50, 55, 60, 65, 70, 75, 80, 100]
  /**
   * 图片下边距
   */
  @State
  imageMarginBottom: number = 10
  /**
   * 图片圆角列表
   */
  imageBorderRadiusList: Array<number> = [0, 5, 10, 20, 25, 30, 40, 50, 55, 60, 65, 70, 75, 80, 100]
  /**
   * 图片圆角
   */
  @State
  imageBorderRadius: number = 0
  /**
   * 图片边框宽度列表
   */
  imageBorderWidthList: Array<number> = [0, 1, 2, 3, 4, 5, 8, 10, 15, 20]
  /**
   * 图片边框宽度
   */
  @State
  imageBorderWidth: number = 0
  /**
   * 图片边框颜色列表
   */
  imageBorderColorList: Array<number> = colorListGeneralData
  /**
   * 图片边框颜色
   */
  @State
  imageBorderColor: number = 0xFF000000
  /**
   * 图片基于自身宽度缩放百分比列表
   */
  imageMaximumWidthList: Array<number> = [0, 0.2, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1.0]
  /**
   * 图片基于自身宽度缩放百分比
   */
  @State
  imageMaximumWidth: number = 1.0
  /**
   * 图片基于父布局宽度缩放百分比列表
   */
  imageFixedRatioWidthList: Array<number| undefined> = [undefined,0, 0.2, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1.0]
  /**
   * 图片基于父布局宽度缩放百分比
   */
  @State
  imageFixedRatioWidth: number | undefined = undefined
  /**
   * 图片最大高度列表
   */
  imageMaxHeightList: Array<number | undefined> = [undefined, 50.0, 80.0, 100.0, 120.0, 150.0, 180.0, 200.0, 250.0, 300.0, 500.0]
  /**
   * 图片最大高度
   */
  @State
  imageMaxHeight: number | undefined = undefined
  /**
   * 图片最大宽度列表
   */
  imageMaxWidthList: Array<number | undefined> = [undefined, 50.0, 80.0, 100.0, 120.0, 150.0, 180.0, 200.0, 250.0, 300.0, 500.0]
  /**
   * 图片最大宽度
   */
  @State
  imageMaxWidth: number | undefined = undefined
  /**
   * 图片是否有下载按钮列表
   */
  isImageDownloadList: Array<boolean> = booleanListGeneralData
  /**
   * 图片是否有下载按钮
   */
  @State
  isImageDownload: boolean = false
  /**
   * 是否图文混排列表
   */
  isImageMixedLayoutList: Array<boolean> = booleanListGeneralData
  /**
   * 是否图文混排
   */
  @State
  isImageMixedLayout: boolean = true
  /**
   * 图片下载按钮图片宽度和高度列表
   */
  imageDownloadImageWidthHeightList: Array<number> = [10, 15, 18, 20, 25, 30, 35, 40]
  /**
   * 图片下载按钮图片宽度和高度
   */
  @State
  imageDownloadImageWidthHeight: number = 18
  /**
   * 图片下载按钮宽度列表
   */
  imageDownloadWidthList: Array<number> = [100, 120, 130, 144, 150, 160, 180, 200]
  /**
   * 图片下载按钮宽度
   */
  @State
  imageDownloadWidth: number = 144
  /**
   * 图片下载按钮高度列表
   */
  imageDownloadHeightList: Array<number> = [25, 30, 35, 40, 44, 50, 60, 70, 80]
  /**
   * 图片下载按钮高度
   */
  @State
  imageDownloadHeight: number = 44
  /**
   * 图片下载按钮圆角列表
   */
  imageDownloadRadiusList: Array<number> = [10, 12, 15, 18, 20, 22, 25, 28, 30,35,40]
  /**
   * 图片下载按钮圆角
   */
  @State
  imageDownloadRadius: number = 22
  /**
   * 图片下载按钮文本内容列表
   */
  imageDownloadTextList: Array<string> = ["下载", "提交", "下载图片"]
  /**
   * 图片下载按钮文本内容
   */
  @State
  imageDownloadText: string = "下载图片"
  /**
   * 图片下载按钮文本大小列表
   */
  imageDownloadTexSizeList: Array<number> = textSizeListGeneralData
  /**
   * 图片下载按钮文本大小
   */
  @State
  imageDownloadTexSize: number = 16
  /**
   * 图片下载按钮文本颜色列表
   */
  imageDownloadTexColorList: Array<number> = colorListGeneralData
  /**
   * 图片下载按钮文本颜色
   */
  @State
  imageDownloadTexColor: number = 0xFF191919
  /**
   * 图片下载按钮背景颜色列表
   */
  imageDownloadBackgroundColorList: Array<number> = colorListGeneralData
  /**
   * 图片下载按钮背景颜色
   */
  @State
  imageDownloadBackgroundColor: number = 0xFFE0E0E0
  /**
   * 配置数据内容
   */
  @State
  imageDataMD: ImageDataMD = new ImageDataMD()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "图片配置页面",
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
            titleStr: "是否触发图片替换事件 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.callbackList,
            allData: this.callback
          })
          BaseTabComponent({
            titleStr: "设置默认占位图 - ",
            typeEnum: TypeEnum.IS_RESOURCE,
            allListData: this.imageResourceList,
            allData: this.imageResource
          })
          BaseTabComponent({
            titleStr: "图片上边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageMarginTopList,
            allData: this.imageMarginTop
          })
          BaseTabComponent({
            titleStr: "图片下边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageMarginBottomList,
            allData: this.imageMarginBottom
          })
          BaseTabComponent({
            titleStr: "图片圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageBorderRadiusList,
            allData: this.imageBorderRadius
          })
          BaseTabComponent({
            titleStr: "图片边框宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageBorderWidthList,
            allData: this.imageBorderWidth
          })
          BaseTabComponent({
            titleStr: "图片边框颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.imageBorderColorList,
            allData: this.imageBorderColor
          })
          BaseTabComponent({
            titleStr: "图片基于自身宽度缩放百分比 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageMaximumWidthList,
            allData: this.imageMaximumWidth
          })
          BaseTabComponent({
            titleStr: "图片基于父布局宽度缩放百分比 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageFixedRatioWidthList,
            allData: this.imageFixedRatioWidth
          })
          BaseTabComponent({
            titleStr: "图片最大高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageMaxHeightList,
            allData: this.imageMaxHeight
          })
          BaseTabComponent({
            titleStr: "图片最大宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageMaxHeightList,
            allData: this.imageMaxHeight
          })
          BaseTabComponent({
            titleStr: "图片是否有下载按钮 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isImageDownloadList,
            allData: this.isImageDownload
          })
          BaseTabComponent({
            titleStr: "是否图文混排 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isImageMixedLayoutList,
            allData: this.isImageMixedLayout
          })
          BaseTabComponent({
            titleStr: "图片下载按钮图片宽度和高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageDownloadImageWidthHeightList,
            allData: this.imageDownloadImageWidthHeight
          })
          BaseTabComponent({
            titleStr: "图片下载按钮宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageDownloadWidthList,
            allData: this.imageDownloadWidth
          })
          BaseTabComponent({
            titleStr: "图片下载按钮高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageDownloadHeightList,
            allData: this.imageDownloadHeight
          })
          BaseTabComponent({
            titleStr: "图片下载按钮圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageDownloadRadiusList,
            allData: this.imageDownloadRadius
          })
          BaseTabComponent({
            titleStr: "图片下载按钮文本内容 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.imageDownloadTextList,
            allData: this.imageDownloadText
          })
          BaseTabComponent({
            titleStr: "图片下载按钮文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageDownloadTexSizeList,
            allData: this.imageDownloadTexSize
          })
          BaseTabComponent({
            titleStr: "图片下载按钮文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.imageDownloadTexColorList,
            allData: this.imageDownloadTexColor
          })
          BaseTabComponent({
            titleStr: "图片下载按钮背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.imageDownloadBackgroundColorList,
            allData: this.imageDownloadBackgroundColor
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
                    this.imageDataMD.isFull = this.isFull
                    this.imageDataMD.incrementalAnalysis = this.incrementalAnalysis
                    this.imageDataMD.time = this.time
                    this.imageDataMD.textNumber = this.textNumber
                    this.imageDataMD.isMarkdownParserSync = this.isMarkdownParserSync
                    this.imageDataMD.typeWriterOpen = this.typeWriterOpen
                    this.imageDataMD.typeWriterColor = this.typeWriterColor
                    this.imageDataMD.isOnCopy = this.isOnCopy
                    this.imageDataMD.blockFirstTopMargin = this.blockFirstTopMargin
                    this.imageDataMD.blockLastBottomMargin = this.blockLastBottomMargin
                    this.imageDataMD.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.imageDataMD.openGestureSwipe = this.openGestureSwipe
                    this.imageDataMD.openGestureSwipeTest = this.openGestureSwipeTest
                    this.imageDataMD.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.imageDataMD.callback = this.callback
                    this.imageDataMD.imageResource = this.imageResource
                    this.imageDataMD.imageMarginTop = this.imageMarginTop
                    this.imageDataMD.imageMarginBottom = this.imageMarginBottom
                    this.imageDataMD.imageBorderRadius = this.imageBorderRadius
                    this.imageDataMD.imageBorderWidth = this.imageBorderWidth
                    this.imageDataMD.imageBorderColor = this.imageBorderColor
                    this.imageDataMD.imageMaximumWidth = this.imageMaximumWidth
                    this.imageDataMD.imageFixedRatioWidth = this.imageFixedRatioWidth
                    this.imageDataMD.imageMaxHeight = this.imageMaxHeight
                    this.imageDataMD.imageMaxWidth = this.imageMaxWidth
                    this.imageDataMD.isImageDownload = this.isImageDownload
                    this.imageDataMD.isImageMixedLayout = this.isImageMixedLayout
                    this.imageDataMD.imageDownloadImageWidthHeight = this.imageDownloadImageWidthHeight
                    this.imageDataMD.imageDownloadWidth = this.imageDownloadWidth
                    this.imageDataMD.imageDownloadHeight = this.imageDownloadHeight
                    this.imageDataMD.imageDownloadRadius = this.imageDownloadRadius
                    this.imageDataMD.imageDownloadText = this.imageDownloadText
                    this.imageDataMD.imageDownloadTexSize = this.imageDownloadTexSize
                    this.imageDataMD.imageDownloadTexColor = this.imageDownloadTexColor
                    this.imageDataMD.imageDownloadBackgroundColor = this.imageDownloadBackgroundColor
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/ImageDetailsPage", params: this.imageDataMD })
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

  resToString(item: Resource | null): string {
    if (item !== null) {
      return "app.media.startIcon"
    } else {
      return "null"
    }
  }
}


export { ImageDataMD }
