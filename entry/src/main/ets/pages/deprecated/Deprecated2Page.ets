import { titleComponent } from '../../component/BaseComponent'
import { getFileListStr } from '../../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../../component/BaseTabComponent'
import { TypeEnum } from '../../model/TypeEnum'
import {
  booleanListGeneralData,
  colorListGeneralData,
  marginListGeneralData,
  textNumberListGeneralData,
  timeListGeneralData
} from '../../model/GeneralData'
import { DeprecatedData } from '../../model/DeprecatedData'

// 音频、视频
@Entry
@Component
struct Deprecated2Page {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // 顶部导航栏高度
  @StorageProp('safeTop') safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "102_Deprecated"
  // rawfile文件夹列表
  @State folderList: Array<string> = new Array<string>()
  // 是否全量加载Markdown文本列表
  isFullList: Array<boolean> = booleanListGeneralData
  // 是否全量加载Markdown文本
  @State isFull: boolean = true
  // 是否增量解析Markdown文本列表
  incrementalAnalysisList: Array<boolean> = booleanListGeneralData
  // 是否增量解析Markdown文本
  @State incrementalAnalysis: boolean = false
  // 增量加载每次间隔时间列表
  timeList: Array<number> = timeListGeneralData
  // 增量加载每次间隔时间
  @State time: number = 50
  // 增量每次增量文本数量列表
  textNumberList: Array<number> = textNumberListGeneralData
  // 增量每次增量文本数量
  @State textNumber: number = 10
  // 是否同步解析Markdown文本列表
  isMarkdownParserSyncList: Array<boolean> = booleanListGeneralData
  // 是否同步解析Markdown文本
  @State isMarkdownParserSync: boolean = false
  // 是否打开长按复制粘贴效果列表
  isOnCopyList: Array<boolean> = booleanListGeneralData
  // 是否打开长按复制粘贴效果
  @State isOnCopy: boolean = false
  // Markdown文本第一个模块上边距列表
  blockFirstTopMarginList: Array<number> = marginListGeneralData
  // Markdown文本第一个模块上边距
  @State blockFirstTopMargin: number = 8
  // Markdown文本最后一个模块下边距列表
  blockLastBottomMarginList: Array<number> = marginListGeneralData
  // Markdown文本最后一个模块下边距
  @State blockLastBottomMargin: number = 8
  // Markdown文本模块间上下间距列表
  blockTopAndBottomMarginsList: Array<number> = marginListGeneralData
  // Markdown文本模块间上下间距
  @State blockTopAndBottomMargins: number = 8
  // 是否允许markdown控件自身响应滑动列表
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  // 是否允许markdown控件自身响应滑动
  @State openGestureSwipe: boolean = false
  // 是否开启响应滑动测试列表
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  @State openGestureSwipeTest: boolean = false // 是否开启响应滑动测试

  // ---------------- 资源图标配置
  audioIconList: Array<Resource | undefined> = [undefined]
  @State audioIcon: Resource | undefined = undefined // 音频图片icon
  videoImageList: Array<Resource | undefined> = [undefined]
  @State videoImage: Resource | undefined = undefined // 视频默认占位图
  playCircleFillIconList: Array<Resource | undefined> = [undefined]
  @State playCircleFillIcon: Resource | undefined = undefined // 视频播放按钮icon
  videoReleaseImageList: Array<Resource | undefined> = [undefined]
  @State videoReleaseImage: Resource | undefined = undefined // 视频发布默认图标
  videoDownloadImageList: Array<Resource | undefined> = [undefined]
  @State videoDownloadImage: Resource | undefined = undefined // 视频下载默认图标

  // ---------------- 音频配置
  // 音频阴影颜色值列表
  audioShadowColorList: Array<number | undefined> = colorListGeneralData
  @State audioShadowColor: number = 0x1A000000 // 音频阴影颜色值
  // 音频边框颜色列表
  audioBorderColorList: Array<number | undefined> = colorListGeneralData
  @State audioBorderColor: number = 0x33000000 // 音频边框颜色
  // 音频边框粗细列表
  audioBorderWidthList: Array<number> = [0, 0.5, 1, 1.5, 2]
  @State audioBorderWidth: number = 0.5 // 音频边框粗细
  // 音频边框圆角列表
  audioBorderRadiusList: Array<number> = [8, 10, 12, 14, 16]
  @State audioBorderRadius: number = 12 // 音频边框圆角
  // 音频按钮背景颜色列表
  audioButtonBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State audioButtonBackgroundColor: number = 0xFF000000 // 音频按钮背景颜色
  // 音频按钮文字颜色列表
  audioButtonTextColorList: Array<number | undefined> = colorListGeneralData
  @State audioButtonTextColor: number = 0xFFFFFFFF // 音频按钮文字颜色
  // 音频按钮文字大小列表
  audioButtonTextSizeList: Array<number> = textNumberListGeneralData
  @State audioButtonTextSize: number = 14 // 音频按钮文字大小
  // 音频按钮文字内容列表
  audioButtonTextList: Array<string> = ["立即播放", "播放", "点击播放"]
  @State audioButtonText: string = "立即播放" // 音频按钮文字内容
  // 音频按钮圆角列表
  audioButtonBorderRadiusList: Array<number> = [12, 14, 16, 18, 20]
  @State audioButtonBorderRadius: number = 16 // 音频按钮圆角
  // 音频标题文字大小列表
  audioTitleTextSizeList: Array<number> = textNumberListGeneralData
  @State audioTitleTextSize: number = 15 // 音频标题文字大小
  // 音频标题文字颜色列表
  audioTitleTextColorList: Array<number | undefined> = colorListGeneralData
  @State audioTitleTextColor: number = 0xFF000000 // 音频标题文字颜色
  // 音频标题文字行高列表
  audioTitleTextLineHeightList: Array<number> = textNumberListGeneralData
  @State audioTitleTextLineHeight: number = 20 // 音频标题文字行高
  // 音频类型文字大小列表
  audioTypeTextSizeList: Array<number> = [9, 10, 11, 12, 13]
  @State audioTypeTextSize: number = 11 // 音频类型文字大小
  // 音频类型文字颜色列表
  audioTypeTextColorList: Array<number | undefined> = colorListGeneralData
  @State audioTypeTextColor: number = 0x80000000 // 音频类型文字颜色
  // 音频类型文字行高列表
  audioTypeTextLineHeightList: Array<number> = textNumberListGeneralData
  @State audioTypeTextLineHeight: number = 15 // 音频类型文字行高
  // 音频上边距列表
  audioMarginTopList: Array<number> = marginListGeneralData
  @State audioMarginTop: number = 10 // 音频上边距
  // 音频下边距列表
  audioMarginBottomList: Array<number> = marginListGeneralData
  @State audioMarginBottom: number = 10 // 音频下边距

  // ---------------- 视频配置
  // 视频圆角列表
  videoBorderRadiusList: Array<number> = [5, 8, 10, 12, 15]
  @State videoBorderRadius: number = 10 // 视频圆角
  // 视频时间文本颜色列表
  videoTimeTextColorList: Array<number | undefined> = colorListGeneralData
  @State videoTimeTextColor: number = 0xFFFFFFFF // 视频时间文本颜色
  // 视频时间文本大小列表
  videoTimeTextSizeList: Array<number> = textNumberListGeneralData
  @State videoTimeTextSize: number = 14 // 视频时间文本大小
  // 视频时间文本居右边距列表
  videoTimeTextMarginRightList: Array<number> = marginListGeneralData
  @State videoTimeTextMarginRight: number = 10 // 视频时间文本居右边距
  // 视频时间文本居底边距列表
  videoTimeTextMarginBottomList: Array<number> = marginListGeneralData
  @State videoTimeTextMarginBottom: number = 10 // 视频时间文本居底边距
  // 视频上边距列表
  videoMarginTopList: Array<number> = marginListGeneralData
  @State videoMarginTop: number = 10 // 视频上边距
  // 视频下边距列表
  videoMarginBottomList: Array<number> = marginListGeneralData
  @State videoMarginBottom: number = 10 // 视频下边距
  // 视频发布/下载按钮布局是否显示列表
  isVideoBottomLayoutList: Array<boolean> = booleanListGeneralData
  @State isVideoBottomLayout: boolean = false // 视频发布/下载按钮布局是否显示
  // 视频发布按钮图片宽度和高度列表
  videoReleaseImageWidthHeightList: Array<number> = [15, 16, 18, 20, 22]
  @State videoReleaseImageWidthHeight: number = 18 // 视频发布按钮图片宽度和高度
  // 视频发布按钮宽度列表
  videoReleaseWidthList: Array<number> = [120, 130, 144, 160, 180]
  @State videoReleaseWidth: number = 144 // 视频发布按钮宽度
  // 视频发布按钮高度列表
  videoReleaseHeightList: Array<number> = [40, 42, 44, 46, 48]
  @State videoReleaseHeight: number = 44 // 视频发布按钮高度
  // 视频发布按钮圆角列表
  videoReleaseRadiusList: Array<number> = [18, 20, 22, 24, 26]
  @State videoReleaseRadius: number = 22 // 视频发布按钮圆角
  // 视频发布按钮文本内容列表
  videoReleaseTextList: Array<string> = ["发布视频", "上传视频"]
  @State videoReleaseText: string = "发布视频" // 视频发布按钮文本内容
  // 视频发布按钮文本大小列表
  videoReleaseTexSizeList: Array<number> = textNumberListGeneralData
  @State videoReleaseTexSize: number = 16 // 视频发布按钮文本大小
  // 视频发布按钮文本颜色列表
  videoReleaseTexColorList: Array<number | undefined> = colorListGeneralData
  @State videoReleaseTexColor: number = 0xE6000000 // 视频发布按钮文本颜色
  // 视频发布按钮背景颜色列表
  videoReleaseBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State videoReleaseBackgroundColor: number = 0xFFF5F5F5 // 视频发布按钮背景颜色
  // 视频下载按钮图片宽度和高度列表
  videoDownloadImageWidthHeightList: Array<number> = [15, 16, 18, 20, 22]
  @State videoDownloadImageWidthHeight: number = 18 // 视频下载按钮图片宽度和高度
  // 视频下载按钮宽度列表
  videoDownloadWidthList: Array<number> = [120, 130, 144, 160, 180]
  @State videoDownloadWidth: number = 144 // 视频下载按钮宽度
  // 视频下载按钮高度列表
  videoDownloadHeightList: Array<number> = [40, 42, 44, 46, 48]
  @State videoDownloadHeight: number = 44 // 视频下载按钮高度
  // 视频下载按钮圆角列表
  videoDownloadRadiusList: Array<number> = [18, 20, 22, 24, 26]
  @State videoDownloadRadius: number = 22 // 视频下载按钮圆角
  // 视频下载按钮文本内容列表
  videoDownloadTextList: Array<string> = ["下载视频", "保存视频"]
  @State videoDownloadText: string = "下载视频" // 视频下载按钮文本内容
  // 视频下载按钮文本大小列表
  videoDownloadTexSizeList: Array<number> = textNumberListGeneralData
  @State videoDownloadTexSize: number = 16 // 视频下载按钮文本大小
  // 视频下载按钮文本颜色列表
  videoDownloadTexColorList: Array<number | undefined> = colorListGeneralData
  @State videoDownloadTexColor: number = 0xE6000000 // 视频下载按钮文本颜色
  // 视频下载按钮背景颜色列表
  videoDownloadBackgroundColorList: Array<number | undefined> = colorListGeneralData
  @State videoDownloadBackgroundColor: number = 0xFFF5F5F5 // 视频下载按钮背景颜色

  @State deprecatedData: DeprecatedData = new DeprecatedData() // 配置数据内容

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "音视频配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Scroll() {
        Column() {
          // ------------ 通用配置
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
            titleStr: "是否允许markdown控件自身响应滑动 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.openGestureSwipeList,
            allData: this.openGestureSwipe
          })
          BaseTabComponent({
            titleStr: "是否开启响应滑动测试 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.openGestureSwipeTestList,
            allData: this.openGestureSwipeTest
          })

          // ------------ 资源图标配置
          BaseTabComponent({
            titleStr: "音频图片icon - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.audioIconList,
            allData: this.audioIcon
          })
          BaseTabComponent({
            titleStr: "视频默认占位图 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.videoImageList,
            allData: this.videoImage
          })
          BaseTabComponent({
            titleStr: "视频播放按钮icon - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.playCircleFillIconList,
            allData: this.playCircleFillIcon
          })
          BaseTabComponent({
            titleStr: "视频发布默认图标 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.videoReleaseImageList,
            allData: this.videoReleaseImage
          })
          BaseTabComponent({
            titleStr: "视频下载默认图标 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.videoDownloadImageList,
            allData: this.videoDownloadImage
          })

          // ------------ 音频配置
          BaseTabComponent({
            titleStr: "音频阴影颜色 - ",
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
            titleStr: "音频边框宽度 - ",
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
            titleStr: "音频按钮文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.audioButtonTextColorList,
            allData: this.audioButtonTextColor
          })
          BaseTabComponent({
            titleStr: "音频按钮文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioButtonTextSizeList,
            allData: this.audioButtonTextSize
          })
          BaseTabComponent({
            titleStr: "音频按钮文本 - ",
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
            titleStr: "音频标题文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioTitleTextSizeList,
            allData: this.audioTitleTextSize
          })
          BaseTabComponent({
            titleStr: "音频标题文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.audioTitleTextColorList,
            allData: this.audioTitleTextColor
          })
          BaseTabComponent({
            titleStr: "音频标题文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioTitleTextLineHeightList,
            allData: this.audioTitleTextLineHeight
          })
          BaseTabComponent({
            titleStr: "音频类型文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioTypeTextSizeList,
            allData: this.audioTypeTextSize
          })
          BaseTabComponent({
            titleStr: "音频类型文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.audioTypeTextColorList,
            allData: this.audioTypeTextColor
          })
          BaseTabComponent({
            titleStr: "音频类型文本行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioTypeTextLineHeightList,
            allData: this.audioTypeTextLineHeight
          })
          BaseTabComponent({
            titleStr: "音频上边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioMarginTopList,
            allData: this.audioMarginTop
          })
          BaseTabComponent({
            titleStr: "音频下边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.audioMarginBottomList,
            allData: this.audioMarginBottom
          })

          // ------------ 视频配置
          BaseTabComponent({
            titleStr: "视频边框圆角 - ",
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
            titleStr: "视频时间文本右边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoTimeTextMarginRightList,
            allData: this.videoTimeTextMarginRight
          })
          BaseTabComponent({
            titleStr: "视频时间文本下边距 - ",
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
            titleStr: "是否视频底部布局 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isVideoBottomLayoutList,
            allData: this.isVideoBottomLayout
          })
          // 视频发布按钮配置
          BaseTabComponent({
            titleStr: "视频发布图片宽高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoReleaseImageWidthHeightList,
            allData: this.videoReleaseImageWidthHeight
          })
          BaseTabComponent({
            titleStr: "视频发布宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoReleaseWidthList,
            allData: this.videoReleaseWidth
          })
          BaseTabComponent({
            titleStr: "视频发布高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoReleaseHeightList,
            allData: this.videoReleaseHeight
          })
          BaseTabComponent({
            titleStr: "视频发布圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoReleaseRadiusList,
            allData: this.videoReleaseRadius
          })
          BaseTabComponent({
            titleStr: "视频发布文本 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.videoReleaseTextList,
            allData: this.videoReleaseText
          })
          BaseTabComponent({
            titleStr: "视频发布文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoReleaseTexSizeList,
            allData: this.videoReleaseTexSize
          })
          BaseTabComponent({
            titleStr: "视频发布文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.videoReleaseTexColorList,
            allData: this.videoReleaseTexColor
          })
          BaseTabComponent({
            titleStr: "视频发布背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.videoReleaseBackgroundColorList,
            allData: this.videoReleaseBackgroundColor
          })
          // 视频下载按钮配置
          BaseTabComponent({
            titleStr: "视频下载图片宽高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoDownloadImageWidthHeightList,
            allData: this.videoDownloadImageWidthHeight
          })
          BaseTabComponent({
            titleStr: "视频下载宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoDownloadWidthList,
            allData: this.videoDownloadWidth
          })
          BaseTabComponent({
            titleStr: "视频下载高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoDownloadHeightList,
            allData: this.videoDownloadHeight
          })
          BaseTabComponent({
            titleStr: "视频下载圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoDownloadRadiusList,
            allData: this.videoDownloadRadius
          })
          BaseTabComponent({
            titleStr: "视频下载文本 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.videoDownloadTextList,
            allData: this.videoDownloadText
          })
          BaseTabComponent({
            titleStr: "视频下载文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.videoDownloadTexSizeList,
            allData: this.videoDownloadTexSize
          })
          BaseTabComponent({
            titleStr: "视频下载文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.videoDownloadTexColorList,
            allData: this.videoDownloadTexColor
          })
          BaseTabComponent({
            titleStr: "视频下载背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.videoDownloadBackgroundColorList,
            allData: this.videoDownloadBackgroundColor
          })

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
                    // ---------- 通用配置
                    this.deprecatedData.isFull = this.isFull
                    this.deprecatedData.incrementalAnalysis = this.incrementalAnalysis
                    this.deprecatedData.time = this.time
                    this.deprecatedData.textNumber = this.textNumber
                    this.deprecatedData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.deprecatedData.isOnCopy = this.isOnCopy
                    this.deprecatedData.blockFirstTopMargin = this.blockFirstTopMargin
                    this.deprecatedData.blockLastBottomMargin = this.blockLastBottomMargin
                    this.deprecatedData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.deprecatedData.openGestureSwipe = this.openGestureSwipe
                    this.deprecatedData.openGestureSwipeTest = this.openGestureSwipeTest

                    // ---------- 资源图标配置
                    this.deprecatedData.audioIcon = this.audioIcon
                    this.deprecatedData.videoImage = this.videoImage
                    this.deprecatedData.playCircleFillIcon = this.playCircleFillIcon
                    this.deprecatedData.videoReleaseImage = this.videoReleaseImage
                    this.deprecatedData.videoDownloadImage = this.videoDownloadImage

                    // ---------- 音频配置
                    this.deprecatedData.audioShadowColor = this.audioShadowColor
                    this.deprecatedData.audioBorderColor = this.audioBorderColor
                    this.deprecatedData.audioBorderWidth = this.audioBorderWidth
                    this.deprecatedData.audioBorderRadius = this.audioBorderRadius
                    this.deprecatedData.audioButtonBackgroundColor = this.audioButtonBackgroundColor
                    this.deprecatedData.audioButtonTextColor = this.audioButtonTextColor
                    this.deprecatedData.audioButtonTextSize = this.audioButtonTextSize
                    this.deprecatedData.audioButtonText = this.audioButtonText
                    this.deprecatedData.audioButtonBorderRadius = this.audioButtonBorderRadius
                    this.deprecatedData.audioTitleTextSize = this.audioTitleTextSize
                    this.deprecatedData.audioTitleTextColor = this.audioTitleTextColor
                    this.deprecatedData.audioTitleTextLineHeight = this.audioTitleTextLineHeight
                    this.deprecatedData.audioTypeTextSize = this.audioTypeTextSize
                    this.deprecatedData.audioTypeTextColor = this.audioTypeTextColor
                    this.deprecatedData.audioTypeTextLineHeight = this.audioTypeTextLineHeight
                    this.deprecatedData.audioMarginTop = this.audioMarginTop
                    this.deprecatedData.audioMarginBottom = this.audioMarginBottom

                    // ---------- 视频配置
                    this.deprecatedData.videoBorderRadius = this.videoBorderRadius
                    this.deprecatedData.videoTimeTextColor = this.videoTimeTextColor
                    this.deprecatedData.videoTimeTextSize = this.videoTimeTextSize
                    this.deprecatedData.videoTimeTextMarginRight = this.videoTimeTextMarginRight
                    this.deprecatedData.videoTimeTextMarginBottom = this.videoTimeTextMarginBottom
                    this.deprecatedData.videoMarginTop = this.videoMarginTop
                    this.deprecatedData.videoMarginBottom = this.videoMarginBottom
                    this.deprecatedData.isVideoBottomLayout = this.isVideoBottomLayout
                    this.deprecatedData.videoReleaseImageWidthHeight = this.videoReleaseImageWidthHeight
                    this.deprecatedData.videoReleaseWidth = this.videoReleaseWidth
                    this.deprecatedData.videoReleaseHeight = this.videoReleaseHeight
                    this.deprecatedData.videoReleaseRadius = this.videoReleaseRadius
                    this.deprecatedData.videoReleaseText = this.videoReleaseText
                    this.deprecatedData.videoReleaseTexSize = this.videoReleaseTexSize
                    this.deprecatedData.videoReleaseTexColor = this.videoReleaseTexColor
                    this.deprecatedData.videoReleaseBackgroundColor = this.videoReleaseBackgroundColor
                    this.deprecatedData.videoDownloadImageWidthHeight = this.videoDownloadImageWidthHeight
                    this.deprecatedData.videoDownloadWidth = this.videoDownloadWidth
                    this.deprecatedData.videoDownloadHeight = this.videoDownloadHeight
                    this.deprecatedData.videoDownloadRadius = this.videoDownloadRadius
                    this.deprecatedData.videoDownloadText = this.videoDownloadText
                    this.deprecatedData.videoDownloadTexSize = this.videoDownloadTexSize
                    this.deprecatedData.videoDownloadTexColor = this.videoDownloadTexColor
                    this.deprecatedData.videoDownloadBackgroundColor = this.videoDownloadBackgroundColor

                    this.deprecatedData.pagePath = `${this.rawFilePath}/${item}`

                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/deprecated/Deprecated2DetailsPage", params: this.deprecatedData })
                  })
              }
            })
          }
          // 设置ListItem在List交叉轴方向的布局方式
          .alignListItem(ListItemAlign.Center)
        }
        .padding({ bottom: 100 })
      }
    }
    .backgroundColor($r('app.color.page_background'))
    .height("100%")
  }
}
