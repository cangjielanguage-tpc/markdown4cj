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
import { LinkData } from '../model/LinkData'

@Entry
@Component
struct LinkPage {
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
  rawFilePath: string = "007_链接"
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
   * 链接是否是图片显示列表
   */
  isLinkStyleList: Array<boolean> = booleanListGeneralData
  /**
   * 链接是否是图片显示
   */
  @State
  isLinkStyle: boolean = false
  /**
   * 列表中的单行链接是否是图片显示列表
   */
  isListLinkStyleList: Array<boolean> = booleanListGeneralData
  /**
   * 列表中的单行链接是否是图片显示
   */
  @State
  isListLinkStyle: boolean = false
  /**
   * 文本格式链接文本颜色列表
   */
  linkColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 文本格式链接文本颜色
   */
  @State
  linkColor: number | undefined = undefined
  /**
   * 文本格式链接文字大小列表
   */
  linkSizeList: Array<number> = textSizeListGeneralData
  /**
   * 文本格式链接文字大小
   */
  @State
  linkSize: number = 14
  /**
   * 文本格式链接背景颜色列表
   */
  linkBackGroupColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 文本格式链接背景颜色
   */
  @State
  linkBackGroupColor: number | undefined = undefined
  /**
   * 文本格式是否显示链接下划线列表
   */
  isLinkUnderlinedList: Array<boolean> = booleanListGeneralData
  /**
   * 文本格式是否显示链接下划线
   */
  @State
  isLinkUnderlined: boolean = true
  /**
   * 文本格式是否显示链接下划线列表
   */
  isLinkSizeList: Array<boolean> = booleanListGeneralData
  /**
   * 文本格式是否显示链接下划线
   */
  @State
  isLinkSize: boolean = true
  /**
   * 圆形图片格式链接主题背景颜色列表
   */
  linkCircleImageBackGroupColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 圆形图片格式链接主题背景颜色
   */
  @State
  linkCircleImageBackGroupColor: number | undefined = undefined
  /**
   * 圆形图片格式链接控件背景颜色列表
   */
  linkCircleImageButtonBackGroupColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 圆形图片格式链接控件背景颜色
   */
  @State
  linkCircleImageButtonBackGroupColor: number | undefined = undefined
  /**
   * 文本格式链接文字大小列表
   */
  linkCircleImageTextSizeList: Array<number> = textSizeListGeneralData
  /**
   * 文本格式链接文字大小
   */
  @State
  linkCircleImageTextSize: number = 14
  /**
   * 圆形图片格式链接文字颜色列表
   */
  linkCircleImageTextColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 圆形图片格式链接文字颜色
   */
  @State
  linkCircleImageTextColor: number | undefined = undefined
  /**
   * 圆形图片格式链接半径列表
   */
  linkCircleImageRadiusList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 圆形图片格式链接半径
   */
  @State
  linkCircleImageRadius: number = 20
  /**
   * 圆形图片格式链接左右外边距列表
   */
  linkCircleImageMarginList: Array<number> = textWordSpaceListGeneralData
  /**
   * 圆形图片格式链接左右外边距
   */
  @State
  linkCircleImageMargin: number = 6
  /**
   * 圆角矩形图片格式链接主题背景颜色列表
   */
  linkRectImageBackGroupColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 圆角矩形图片格式链接主题背景颜色
   */
  @State
  linkRectImageBackGroupColor: number | undefined = undefined
  /**
   * 圆角矩形图片格式链接控件背景颜色列表
   */
  linkRectImageButtonBackGroupColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 圆角矩形图片格式链接控件背景颜色
   */
  @State
  linkRectImageButtonBackGroupColor: number | undefined = undefined
  /**
   * 圆角矩形图片格式链接文字大小列表
   */
  linkRectImageTextSizeList: Array<number> = textSizeListGeneralData
  /**
   * 圆角矩形图片格式链接文字大小
   */
  @State
  linkRectImageTextSize: number = 14
  /**
   * 圆角矩形图片格式链接文字颜色列表
   */
  linkRectImageTextColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 圆角矩形图片格式链接文字颜色
   */
  @State
  linkRectImageTextColor: number | undefined = undefined
  /**
   * 圆角矩形图片格式链接控件高度列表
   */
  linkRectImageHeightList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 圆角矩形图片格式链接控件高度
   */
  @State
  linkRectImageHeight: number = 20
  /**
   * 圆角矩形图片格式链接左右内边距列表
   */
  linkRectImagePaddingList: Array<number> = textWordSpaceListGeneralData
  /**
   * 圆角矩形图片格式链接左右内边距
   */
  @State
  linkRectImagePadding: number = 6
  /**
   * 圆角矩形图片格式链接圆角半径列表
   */
  linkRectImageRadiusList: Array<number> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  /**
   * 圆角矩形图片格式链接圆角半径
   */
  @State
  linkRectImageRadius: number = 6
  /**
   * 圆角矩形图片格式链接左右外边距列表
   */
  linkRectImageMarginList: Array<number> = textWordSpaceListGeneralData
  /**
   * 圆角矩形图片格式链接左右外边距
   */
  @State
  linkRectImageMargin: number = 6
  /**
   * 空心圆角矩形图片格式链接主题背景颜色列表
   */
  linkRectToolImageBackGroupColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 空心圆角矩形图片格式链接主题背景颜色
   */
  @State
  linkRectToolImageBackGroupColor: number | undefined = undefined
  /**
   * 空心圆角矩形图片格式链接控件背景颜色列表
   */
  linkRectToolImageButtonBackGroupColorList: Array<number | undefined> = colorListGeneralData
  /**
   * 空心圆角矩形图片格式链接控件背景颜色
   */
  @State
  linkRectToolImageButtonBackGroupColor: number | undefined = undefined
  /**
   * 空心圆角矩形图片格式链接文字大小列表
   */
  linkRectToolImageTextSizeList: Array<number> = textSizeListGeneralData
  /**
   * 空心圆角矩形图片格式链接文字大小
   */
  @State
  linkRectToolImageTextSize: number = 14
  /**
   * 空心圆角矩形图片格式链接控件高度列表
   */
  linkRectToolImageHeightList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 空心圆角矩形图片格式链接控件高度
   */
  @State
  linkRectToolImageHeight: number = 21
  /**
   * 空心圆角矩形图片格式链接左右内边距列表
   */
  linkRectToolImagePaddingList: Array<number> = textWordSpaceListGeneralData
  /**
   * 空心圆角矩形图片格式链接左右内边距
   */
  @State
  linkRectToolImagePadding: number = 6
  /**
   * 空心圆角矩形图片格式链接边框宽度列表
   */
  linkRectToolImageBorderWidthList: Array<number> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  /**
   * 空心圆角矩形图片格式链接边框宽度
   */
  @State
  linkRectToolImageBorderWidth: number = 1
  /**
   * 空心圆角矩形图片格式链接分割线宽度列表
   */
  linkRectToolImageDividingLineWidthList: Array<number> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  /**
   * 空心圆角矩形图片格式链接分割线宽度
   */
  @State
  linkRectToolImageDividingLineWidth: number = 1
  /**
   * 空心圆角矩形图片格式链接左右外边距列表
   */
  linkRectToolImageMarginList: Array<number> =textWordSpaceListGeneralData
  /**
   * 空心圆角矩形图片格式链接左右外边距
   */
  @State
  linkRectToolImageMargin: number = 6
  /**
   * 空心圆角矩形图片格式链接左右外边距列表
   */
  linkRectToolImageLineLeftPaddingList: Array<number> = textWordSpaceListGeneralData
  /**
   * 空心圆角矩形图片格式链接左右外边距
   */
  @State
  linkRectToolImageLineLeftPadding: number = 3
  /**
   * 空心圆角矩形图片格式链接左右外边距列表
   */
  linkRectToolImageLineRightPaddingList: Array<number> = textWordSpaceListGeneralData
  /**
   * 空心圆角矩形图片格式链接左右外边距
   */
  @State
  linkRectToolImageLineRightPadding: number = 3
  /**
   * 文本格式链接文字行高
   */
  @State
  linkLineHeight: number = 22
  /**
   * 文本格式链接文字行高
   */
  linkLineHeightList: Array<number> = textLineHeightListGeneralData
  /**
   * 配置数据内容
   */
  @State
  linkData: LinkData = new LinkData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "链接配置页面",
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
            titleStr: "链接是否是图片显示 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isLinkStyleList,
            allData: this.isLinkStyle
          })
          BaseTabComponent({
            titleStr: "列表中的单行链接是否是图片显示 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isListLinkStyleList,
            allData: this.isListLinkStyle
          })
          BaseTabComponent({
            titleStr: "文本格式链接文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkColorList,
            allData: this.linkColor
          })
          BaseTabComponent({
            titleStr: "文本格式链接文字大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkSizeList,
            allData: this.linkSize
          })
          BaseTabComponent({
            titleStr: "文本格式链接背景颜色(5.0不支持) - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkBackGroupColorList,
            allData: this.linkBackGroupColor
          })
          BaseTabComponent({
            titleStr: "文本格式是否显示链接下划线 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isLinkUnderlinedList,
            allData: this.isLinkUnderlined
          })
          BaseTabComponent({
            titleStr: "是否按照链接文本自己大小显示文本 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isLinkSizeList,
            allData: this.isLinkSize
          })
          BaseTabComponent({
            titleStr: "圆形图片格式链接主题背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkCircleImageBackGroupColorList,
            allData: this.linkCircleImageBackGroupColor
          })
          BaseTabComponent({
            titleStr: "圆形图片格式链接控件背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkCircleImageButtonBackGroupColorList,
            allData: this.linkCircleImageButtonBackGroupColor
          })
          BaseTabComponent({
            titleStr: "圆形图片格式链接文字大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkCircleImageTextSizeList,
            allData: this.linkCircleImageTextSize
          })
          BaseTabComponent({
            titleStr: "圆形图片格式链接文字颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkCircleImageTextColorList,
            allData: this.linkCircleImageTextColor
          })
          BaseTabComponent({
            titleStr: "圆形图片格式链接半径 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkCircleImageRadiusList,
            allData: this.linkCircleImageRadius
          })
          BaseTabComponent({
            titleStr: "圆形图片格式链接左右外边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkCircleImageMarginList,
            allData: this.linkCircleImageMargin
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接主题背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkRectImageBackGroupColorList,
            allData: this.linkRectImageBackGroupColor
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接控件背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkRectImageButtonBackGroupColorList,
            allData: this.linkRectImageButtonBackGroupColor
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接文字大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectImageTextSizeList,
            allData: this.linkRectImageTextSize
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接文字颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkRectImageTextColorList,
            allData: this.linkRectImageTextColor
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接控件高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectImageHeightList,
            allData: this.linkRectImageHeight
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接左右内边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectImagePaddingList,
            allData: this.linkRectImagePadding
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接圆角半径 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectImageRadiusList,
            allData: this.linkRectImageRadius
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接左右外边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectImageMarginList,
            allData: this.linkRectImageMargin
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接主题背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkRectToolImageBackGroupColorList,
            allData: this.linkRectToolImageBackGroupColor
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接控件背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkRectToolImageButtonBackGroupColorList,
            allData: this.linkRectToolImageButtonBackGroupColor
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接文字大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImageTextSizeList,
            allData: this.linkRectToolImageTextSize
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接控件高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImageHeightList,
            allData: this.linkRectToolImageHeight
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接左右内边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImagePaddingList,
            allData: this.linkRectToolImagePadding
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接边框宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImageBorderWidthList,
            allData: this.linkRectToolImageBorderWidth
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接分割线宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImageDividingLineWidthList,
            allData: this.linkRectToolImageDividingLineWidth
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接左右外边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImageMarginList,
            allData: this.linkRectToolImageMargin
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式分割线和文本左边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImageLineLeftPaddingList,
            allData: this.linkRectToolImageLineLeftPadding
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式分割线和文本右边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImageLineRightPaddingList,
            allData: this.linkRectToolImageLineRightPadding
          })
          BaseTabComponent({
            titleStr: "文本格式链接文字行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkLineHeightList,
            allData: this.linkLineHeight
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
                    this.linkData.isFull = this.isFull
                    this.linkData.incrementalAnalysis = this.incrementalAnalysis
                    this.linkData.time = this.time
                    this.linkData.textNumber = this.textNumber
                    this.linkData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.linkData.typeWriterOpen = this.typeWriterOpen
                    this.linkData.typeWriterColor = this.typeWriterColor
                    this.linkData.isOnCopy = this.isOnCopy
                    this.linkData.blockFirstTopMargin = this.blockFirstTopMargin
                    this.linkData.blockLastBottomMargin = this.blockLastBottomMargin
                    this.linkData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.linkData.openGestureSwipe = this.openGestureSwipe
                    this.linkData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.linkData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.linkData.isLinkStyle = this.isLinkStyle
                    this.linkData.isListLinkStyle = this.isListLinkStyle
                    this.linkData.linkColor = this.linkColor
                    this.linkData.isLinkSize = this.isLinkSize
                    this.linkData.linkSize = this.linkSize
                    this.linkData.linkBackGroupColor = this.linkBackGroupColor
                    this.linkData.isLinkUnderlined = this.isLinkUnderlined
                    this.linkData.linkCircleImageBackGroupColor = this.linkCircleImageBackGroupColor
                    this.linkData.linkCircleImageButtonBackGroupColor = this.linkCircleImageButtonBackGroupColor
                    this.linkData.linkCircleImageTextSize = this.linkCircleImageTextSize
                    this.linkData.linkCircleImageTextColor = this.linkCircleImageTextColor
                    this.linkData.linkCircleImageRadius = this.linkCircleImageRadius
                    this.linkData.linkCircleImageMargin = this.linkCircleImageMargin
                    this.linkData.linkRectImageBackGroupColor = this.linkRectImageBackGroupColor
                    this.linkData.linkRectImageButtonBackGroupColor = this.linkRectImageButtonBackGroupColor
                    this.linkData.linkRectImageTextSize = this.linkRectImageTextSize
                    this.linkData.linkRectImageTextColor = this.linkRectImageTextColor
                    this.linkData.linkRectImageHeight = this.linkRectImageHeight
                    this.linkData.linkRectImagePadding = this.linkRectImagePadding
                    this.linkData.linkRectImageRadius = this.linkRectImageRadius
                    this.linkData.linkRectImageMargin = this.linkRectImageMargin
                    this.linkData.linkRectToolImageBackGroupColor = this.linkRectToolImageBackGroupColor
                    this.linkData.linkRectToolImageButtonBackGroupColor = this.linkRectToolImageButtonBackGroupColor
                    this.linkData.linkRectToolImageTextSize = this.linkRectToolImageTextSize
                    this.linkData.linkRectToolImageHeight = this.linkRectToolImageHeight
                    this.linkData.linkRectToolImagePadding = this.linkRectToolImagePadding
                    this.linkData.linkRectToolImageBorderWidth = this.linkRectToolImageBorderWidth
                    this.linkData.linkRectToolImageDividingLineWidth = this.linkRectToolImageDividingLineWidth
                    this.linkData.linkRectToolImageMargin = this.linkRectToolImageMargin
                    this.linkData.linkRectToolImageLineLeftPadding = this.linkRectToolImageLineLeftPadding
                    this.linkData.linkRectToolImageLineRightPadding = this.linkRectToolImageLineRightPadding
                    this.linkData.linkLineHeight = this.linkLineHeight
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/LinkDetailsPage", params: this.linkData })
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


