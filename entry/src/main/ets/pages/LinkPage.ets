/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from '../utils/BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct LinkPage {
  /**
   * 滑动控制器
   */
  scroller: Scroller = new Scroller()
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0
  /**
   * rawfile路径
   */
  rawFilePath: string = "007_链接"
  /**
   * rawfile标题文件夹列表
   */
  @State
  folderList: Array<string> = new Array<string>()
  /**
   * 增量加载全量加载选项列表
   */
  isFullList: Array<string> = ["全量加载", "增量加载"]
  /**
   * 增量加载全量加载选项
   */
  @State
  isFull: boolean = true
  /**
   * markdown是否增量解析列表
   */
  incrementalAnalysisList: Array<boolean> = [true, false]
  /**
   * markdown是否增量解析(true:增量解析,false:全量解析)
   */
  @State
  incrementalAnalysis: boolean = false
  /**
   * 增量加载每次间隔时间列表
   */
  timeList: Array<number> = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 200, 300, 400, 500]
  /**
   * 增量加载每次间隔时间 - 毫秒
   */
  @State
  time: number = 50
  /**
   * 增量每次增量文本数量列表
   */
  textNumberList: Array<number> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30, 35, 40, 45, 50, 100, 150, 200]
  /**
   * 增量每次增量文本数量
   */
  @State
  textNumber: number = 10
  /**
   * 链接是否是图片显示列表
   */
  isLinkStyleList: Array<boolean> = [true, false]
  /**
   * 链接是否是图片显示
   */
  @State
  isLinkStyle: boolean = false
  /**
   * 列表中的单行链接是否是图片显示列表
   */
  isListLinkStyleList: Array<boolean> = [true, false]
  /**
   * 列表中的单行链接是否是图片显示
   */
  @State
  isListLinkStyle: boolean = false
  /**
   * 文本格式链接文本颜色列表
   */
  linkColorList: Array<number> = [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 文本格式链接文本颜色
   */
  @State
  linkColor: number = 0xFF0000FF
  /**
   * 文本格式链接文字大小列表
   */
  linkSizeList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 文本格式链接文字大小
   */
  @State
  linkSize: number = 14
  /**
   * 文本格式链接背景颜色列表
   */
  linkBackGroupColorList: Array<number> =
    [0x00000000, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 文本格式链接背景颜色
   */
  @State
  linkBackGroupColor: number = 0x00000000
  /**
   * 文本格式是否显示链接下划线列表
   */
  isLinkUnderlinedList: Array<boolean> = [true, false]
  /**
   * 文本格式是否显示链接下划线
   */
  @State
  isLinkUnderlined: boolean = true
  /**
   * 文本格式是否显示链接下划线列表
   */
  isLinkSizeList: Array<boolean> = [true, false]
  /**
   * 文本格式是否显示链接下划线
   */
  @State
  isLinkSize: boolean = true
  /**
   * 圆形图片格式链接主题背景颜色列表
   */
  linkCircleImageBackGroupColorList: Array<number> =
    [0x00000000, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 圆形图片格式链接主题背景颜色
   */
  @State
  linkCircleImageBackGroupColor: number = 0x00000000
  /**
   * 圆形图片格式链接控件背景颜色列表
   */
  linkCircleImageButtonBackGroupColorList: Array<number> =
    [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 圆形图片格式链接控件背景颜色
   */
  @State
  linkCircleImageButtonBackGroupColor: number = 0xFFFFFFFF
  /**
   * 文本格式链接文字大小列表
   */
  linkCircleImageTextSizeList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 文本格式链接文字大小
   */
  @State
  linkCircleImageTextSize: number = 14
  /**
   * 圆形图片格式链接文字颜色列表
   */
  linkCircleImageTextColorList: Array<number> = [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 圆形图片格式链接文字颜色
   */
  @State
  linkCircleImageTextColor: number = 0xFFFFFFFF
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
  linkCircleImageMarginList: Array<number> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  /**
   * 圆形图片格式链接左右外边距
   */
  @State
  linkCircleImageMargin: number = 6
  /**
   * 圆角矩形图片格式链接主题背景颜色列表
   */
  linkRectImageBackGroupColorList: Array<number> =
    [0x00000000, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 圆角矩形图片格式链接主题背景颜色
   */
  @State
  linkRectImageBackGroupColor: number = 0x00000000
  /**
   * 圆角矩形图片格式链接控件背景颜色列表
   */
  linkRectImageButtonBackGroupColorList: Array<number> =
    [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 圆角矩形图片格式链接控件背景颜色
   */
  @State
  linkRectImageButtonBackGroupColor: number = 0xFFFFFFFF
  /**
   * 圆角矩形图片格式链接文字大小列表
   */
  linkRectImageTextSizeList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 圆角矩形图片格式链接文字大小
   */
  @State
  linkRectImageTextSize: number = 14
  /**
   * 圆角矩形图片格式链接文字颜色列表
   */
  linkRectImageTextColorList: Array<number> = [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 圆角矩形图片格式链接文字颜色
   */
  @State
  linkRectImageTextColor: number = 0xFFFFFFFF
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
  linkRectImagePaddingList: Array<number> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
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
  linkRectImageMarginList: Array<number> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  /**
   * 圆角矩形图片格式链接左右外边距
   */
  @State
  linkRectImageMargin: number = 6
  /**
   * 空心圆角矩形图片格式链接主题背景颜色列表
   */
  linkRectToolImageBackGroupColorList: Array<number> =
    [0x00000000, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 空心圆角矩形图片格式链接主题背景颜色
   */
  @State
  linkRectToolImageBackGroupColor: number = 0x00000000
  /**
   * 空心圆角矩形图片格式链接控件背景颜色列表
   */
  linkRectToolImageButtonBackGroupColorList: Array<number> =
    [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 空心圆角矩形图片格式链接控件背景颜色
   */
  @State
  linkRectToolImageButtonBackGroupColor: number = 0xFFFFFFFF
  /**
   * 空心圆角矩形图片格式链接文字大小列表
   */
  linkRectToolImageTextSizeList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
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
  linkRectToolImagePaddingList: Array<number> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
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
  linkRectToolImageMarginList: Array<number> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  /**
   * 空心圆角矩形图片格式链接左右外边距
   */
  @State
  linkRectToolImageMargin: number = 6
  /**
   * 空心圆角矩形图片格式链接左右外边距列表
   */
  linkRectToolImageLineLeftPaddingList: Array<number> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  /**
   * 空心圆角矩形图片格式链接左右外边距
   */
  @State
  linkRectToolImageLineLeftPadding: number = 3
  /**
   * 空心圆角矩形图片格式链接左右外边距列表
   */
  linkRectToolImageLineRightPaddingList: Array<number> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  /**
   * 空心圆角矩形图片格式链接左右外边距
   */
  @State
  linkRectToolImageLineRightPadding: number = 3
  /**
   * markdown是否同步解析
   */
  @State
  isMarkdownParserSync: boolean = false
  /**
   * markdown是否同步解析
   */
  isMarkdownParserSyncList: Array<boolean> = [true, false]
  /**
   * 是否开启打字机效果
   */
  @State
  typeWriterOpen: boolean = false
  /**
   * 是否开启打字机效果
   */
  typeWriterOpenList: Array<boolean> = [true, false]
  /**
   * 打字机效果颜色
   */
  @State
  typeWriterColor: number = 0xFFFF0000
  /**
   * 打字机效果颜色列表
   */
  typeWriterColorList: Array<number> = [0xFFF5F5F5, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 是否打开长按复制粘贴
   */
  @State
  isOnCopy: boolean = false
  /**
   * 是否打开长按复制粘贴
   */
  isOnCopyList: Array<boolean> = [true, false]
  /**
   * markdown第一个模块上边距
   */
  @State
  blockFirstTopMargin: number = 8
  /**
   * markdown第一个模块上边距
   */
  blockFirstTopMarginList: Array<number> = [0, 5, 8, 10, 15, 20, 25, 30, 35, 40]
  /**
   * markdown最后一个模块下边距
   */
  @State
  blockLastBottomMargin: number = 8
  /**
   * markdown最后一个模块下边距
   */
  blockLastBottomMarginList: Array<number> = [0, 5, 8, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 模块间上下间距
   */
  @State
  blockTopAndBottomMargins: number = 8
  /**
   * 模块间上下间距
   */
  blockTopAndBottomMarginsList: Array<number> = [0, 5, 8, 10, 15, 20, 25, 30, 35, 40]
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
          Column() {
            Row() {
              Text(`是否增量加载 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${booleanToString(this.isFull)}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isFullList, (item: string, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isFull = stringToBoolean(item)
                    this.linkData.isFull = this.isFull
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`markdown是否增量解析 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.incrementalAnalysis}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.incrementalAnalysisList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.incrementalAnalysis = item
                    this.linkData.incrementalAnalysis = this.incrementalAnalysis
                  })
              })
            }
          }


          Column() {
            Row() {
              Text(`增量加载每次间隔时间 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.time}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.timeList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.time = item
                    this.linkData.time = this.time
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`增量每次增量文本数量 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.textNumber}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.textNumberList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.textNumber = item
                    this.linkData.textNumber = this.textNumber
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`链接是否是图片显示 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isLinkStyle}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isLinkStyleList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isLinkStyle = item
                    this.linkData.isLinkStyle = this.isLinkStyle
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`列表中的单行链接是否是图片显示 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isListLinkStyle}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isListLinkStyleList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isListLinkStyle = item
                    this.linkData.isListLinkStyle = this.isListLinkStyle
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`文本格式链接文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.linkColor))
                .fontSize(16)
                .fontColor(this.linkColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkColor = item
                    this.linkData.linkColor = this.linkColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`文本格式链接文字大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkSizeList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkSize = item
                    this.linkData.linkSize = this.linkSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`文本格式链接背景颜色(5.0不支持) - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.linkBackGroupColor))
                .fontSize(16)
                .fontColor(this.linkBackGroupColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkBackGroupColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkBackGroupColor = item
                    this.linkData.linkBackGroupColor = this.linkBackGroupColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`文本格式是否显示链接下划线 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isLinkUnderlined}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isLinkUnderlinedList, (item: boolean, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isLinkUnderlined = item
                    this.linkData.isLinkUnderlined = this.isLinkUnderlined
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`是否按照链接文本自己大小显示文本 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isLinkSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isLinkSizeList, (item: boolean, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isLinkSize = item
                    this.linkData.isLinkSize = this.isLinkSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`圆形图片格式链接主题背景颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.linkCircleImageBackGroupColor))
                .fontSize(16)
                .fontColor(this.linkCircleImageBackGroupColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkCircleImageBackGroupColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkCircleImageBackGroupColor = item
                    this.linkData.linkCircleImageBackGroupColor = this.linkCircleImageBackGroupColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`圆形图片格式链接控件背景颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.linkCircleImageButtonBackGroupColor))
                .fontSize(16)
                .fontColor(this.linkCircleImageButtonBackGroupColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkCircleImageButtonBackGroupColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkCircleImageButtonBackGroupColor = item
                    this.linkData.linkCircleImageButtonBackGroupColor = this.linkCircleImageButtonBackGroupColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`圆形图片格式链接文字大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkCircleImageTextSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkCircleImageTextSizeList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkCircleImageTextSize = item
                    this.linkData.linkCircleImageTextSize = this.linkCircleImageTextSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`圆形图片格式链接文字颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.linkCircleImageTextColor))
                .fontSize(16)
                .fontColor(this.linkCircleImageTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkCircleImageTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkCircleImageTextColor = item
                    this.linkData.linkCircleImageTextColor = this.linkCircleImageTextColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`圆形图片格式链接半径 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkCircleImageRadius}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkCircleImageRadiusList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkCircleImageRadius = item
                    this.linkData.linkCircleImageRadius = this.linkCircleImageRadius
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`圆形图片格式链接左右外边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkCircleImageMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkCircleImageMarginList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkCircleImageMargin = item
                    this.linkData.linkCircleImageMargin = this.linkCircleImageMargin
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`圆角矩形图片格式链接主题背景颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.linkRectImageBackGroupColor))
                .fontSize(16)
                .fontColor(this.linkRectImageBackGroupColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectImageBackGroupColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectImageBackGroupColor = item
                    this.linkData.linkRectImageBackGroupColor = this.linkRectImageBackGroupColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`圆角矩形图片格式链接控件背景颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.linkRectImageButtonBackGroupColor))
                .fontSize(16)
                .fontColor(this.linkRectImageButtonBackGroupColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectImageButtonBackGroupColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectImageButtonBackGroupColor = item
                    this.linkData.linkRectImageButtonBackGroupColor = this.linkRectImageButtonBackGroupColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`圆角矩形图片格式链接文字大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkRectImageTextSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectImageTextSizeList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectImageTextSize = item
                    this.linkData.linkRectImageTextSize = this.linkRectImageTextSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`圆角矩形图片格式链接文字颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.linkRectImageTextColor))
                .fontSize(16)
                .fontColor(this.linkRectImageTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectImageTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectImageTextColor = item
                    this.linkData.linkRectImageTextColor = this.linkRectImageTextColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`圆角矩形图片格式链接控件高度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkRectImageHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectImageHeightList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectImageHeight = item
                    this.linkData.linkRectImageHeight = this.linkRectImageHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`圆角矩形图片格式链接左右内边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkRectImagePadding}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectImagePaddingList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectImagePadding = item
                    this.linkData.linkRectImagePadding = this.linkRectImagePadding
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`圆角矩形图片格式链接圆角半径 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkRectImageRadius}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectImageRadiusList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectImageRadius = item
                    this.linkData.linkRectImageRadius = this.linkRectImageRadius
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`圆角矩形图片格式链接左右外边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkRectImageMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectImageMarginList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectImageMargin = item
                    this.linkData.linkRectImageMargin = this.linkRectImageMargin
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`空心圆角矩形图片格式链接主题背景颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.linkRectToolImageBackGroupColor))
                .fontSize(16)
                .fontColor(this.linkRectToolImageBackGroupColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectToolImageBackGroupColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectToolImageBackGroupColor = item
                    this.linkData.linkRectToolImageBackGroupColor = this.linkRectToolImageBackGroupColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`空心圆角矩形图片格式链接控件背景颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.linkRectToolImageButtonBackGroupColor))
                .fontSize(16)
                .fontColor(this.linkRectToolImageButtonBackGroupColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectToolImageButtonBackGroupColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectToolImageButtonBackGroupColor = item
                    this.linkData.linkRectToolImageButtonBackGroupColor = this.linkRectToolImageButtonBackGroupColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`空心圆角矩形图片格式链接文字大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkRectToolImageTextSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectToolImageTextSizeList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectToolImageTextSize = item
                    this.linkData.linkRectToolImageTextSize = this.linkRectToolImageTextSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`空心圆角矩形图片格式链接控件高度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkRectToolImageHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectToolImageHeightList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectToolImageHeight = item
                    this.linkData.linkRectToolImageHeight = this.linkRectToolImageHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`空心圆角矩形图片格式链接左右内边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkRectToolImagePadding}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectToolImagePaddingList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectToolImagePadding = item
                    this.linkData.linkRectToolImagePadding = this.linkRectToolImagePadding
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`空心圆角矩形图片格式链接边框宽度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkRectToolImageBorderWidth}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectToolImageBorderWidthList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectToolImageBorderWidth = item
                    this.linkData.linkRectToolImageBorderWidth = this.linkRectToolImageBorderWidth
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`空心圆角矩形图片格式链接分割线宽度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkRectToolImageDividingLineWidth}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectToolImageDividingLineWidthList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectToolImageDividingLineWidth = item
                    this.linkData.linkRectToolImageDividingLineWidth = this.linkRectToolImageDividingLineWidth
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`空心圆角矩形图片格式链接左右外边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkRectToolImageMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectToolImageMarginList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectToolImageMargin = item
                    this.linkData.linkRectToolImageMargin = this.linkRectToolImageMargin
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`空心圆角矩形图片格式分割线和文本左边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkRectToolImageLineLeftPadding}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectToolImageLineLeftPaddingList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectToolImageLineLeftPadding = item
                    this.linkData.linkRectToolImageLineLeftPadding = this.linkRectToolImageLineLeftPadding
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`空心圆角矩形图片格式分割线和文本右边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.linkRectToolImageLineRightPadding}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.linkRectToolImageLineRightPaddingList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.linkRectToolImageLineRightPadding = item
                    this.linkData.linkRectToolImageLineRightPadding = this.linkRectToolImageLineRightPadding
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`markdown是否同步解析 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isMarkdownParserSync}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isMarkdownParserSyncList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isMarkdownParserSync = item
                    this.linkData.isMarkdownParserSync = this.isMarkdownParserSync
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`是否开启打字机效果 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.typeWriterOpen}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.typeWriterOpenList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.typeWriterOpen = item
                    this.linkData.typeWriterOpen = this.typeWriterOpen
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`打字机效果颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.typeWriterColor))
                .fontSize(16)
                .fontColor(this.typeWriterColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.typeWriterColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.typeWriterColor = item
                    this.linkData.typeWriterColor = this.typeWriterColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`是否打开长按复制粘贴 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isOnCopy}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isOnCopyList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isOnCopy = item
                    this.linkData.isOnCopy = this.isOnCopy
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`markdown第一个模块上边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.blockFirstTopMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockFirstTopMarginList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockFirstTopMargin = item
                    this.linkData.blockFirstTopMargin = this.blockFirstTopMargin
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`markdown最后一个模块下边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.blockLastBottomMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockLastBottomMarginList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockLastBottomMargin = item
                    this.linkData.blockLastBottomMargin = this.blockLastBottomMargin
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`模块间上下间距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.blockTopAndBottomMargins}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockTopAndBottomMarginsList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockTopAndBottomMargins = item
                    this.linkData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                  })
              })
            }
          }

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
                    this.linkData.pagePath = `${this.rawFilePath}/${item}`
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

export class LinkData {
  _isFull: boolean = true
  _incrementalAnalysis: boolean = false
  _time: number = 50
  _textNumber: number = 10
  _isLinkStyle: boolean = false
  _isListLinkStyle: boolean = false
  _linkColor: number = 0xFF0000FF
  _isLinkSize: boolean = true
  _linkSize: number = 14
  _linkBackGroupColor: number = 0x00000000
  _isLinkUnderlined: boolean = true
  _linkCircleImageBackGroupColor: number = 0x00000000
  _linkCircleImageButtonBackGroupColor: number = 0xFF000000
  _linkCircleImageTextColor: number = 0xFFFFFFFF
  _linkCircleImageTextSize: number = 14
  _linkCircleImageRadius: number = 20
  _linkCircleImageMargin: number = 6
  _linkRectImageBackGroupColor: number = 0x00000000
  _linkRectImageButtonBackGroupColor: number = 0xFF000000
  _linkRectImageTextSize: number = 14
  _linkRectImageTextColor: number = 0xFFFFFFFF
  _linkRectImageHeight: number = 20
  _linkRectImagePadding: number = 6
  _linkRectImageRadius: number = 6
  _linkRectImageMargin: number = 6
  _linkRectToolImageBackGroupColor: number = 0x00000000
  _linkRectToolImageButtonBackGroupColor: number = 0xFFFFFFFF
  _linkRectToolImageTextSize: number = 14
  _linkRectToolImageHeight: number = 21
  _linkRectToolImagePadding: number = 6
  _linkRectToolImageBorderWidth: number = 1
  _linkRectToolImageDividingLineWidth: number = 1
  _linkRectToolImageMargin: number = 6
  _linkRectToolImageLineLeftPadding: number = 3
  _linkRectToolImageLineRightPadding: number = 3
  _isMarkdownParserSync: boolean = false
  _typeWriterOpen: boolean = false
  _typeWriterColor: number = 0xFFFF0000
  _isOnCopy: boolean = false
  _blockFirstTopMargin: number = 8
  _blockLastBottomMargin: number = 8
  _blockTopAndBottomMargins: number = 8
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set incrementalAnalysis(value: boolean) {
    this._incrementalAnalysis = value
  }

  public set time(value: number) {
    this._time = value
  }

  public set textNumber(value: number) {
    this._textNumber = value
  }

  public set isLinkStyle(value: boolean) {
    this._isLinkStyle = value
  }

  public set isListLinkStyle(value: boolean) {
    this._isListLinkStyle = value
  }

  public set linkColor(value: number) {
    this._linkColor = value
  }

  public set isLinkSize(value: boolean) {
    this._isLinkSize = value
  }

  public set linkSize(value: number) {
    this._linkSize = value
  }

  public set linkBackGroupColor(value: number) {
    this._linkBackGroupColor = value
  }

  public set isLinkUnderlined(value: boolean) {
    this._isLinkUnderlined = value
  }

  public set linkCircleImageBackGroupColor(value: number) {
    this._linkCircleImageBackGroupColor = value
  }

  public set linkCircleImageButtonBackGroupColor(value: number) {
    this._linkCircleImageButtonBackGroupColor = value
  }

  public set linkCircleImageTextSize(value: number) {
    this._linkCircleImageTextSize = value
  }

  public set linkCircleImageTextColor(value: number) {
    this._linkCircleImageTextColor = value
  }

  public set linkCircleImageRadius(value: number) {
    this._linkCircleImageRadius = value
  }

  public set linkCircleImageMargin(value: number) {
    this._linkCircleImageMargin = value
  }

  public set linkRectImageBackGroupColor(value: number) {
    this._linkRectImageBackGroupColor = value
  }

  public set linkRectImageButtonBackGroupColor(value: number) {
    this._linkRectImageButtonBackGroupColor = value
  }

  public set linkRectImageTextSize(value: number) {
    this._linkRectImageTextSize = value
  }

  public set linkRectImageTextColor(value: number) {
    this._linkRectImageTextColor = value
  }

  public set linkRectImageHeight(value: number) {
    this._linkRectImageHeight = value
  }

  public set linkRectImagePadding(value: number) {
    this._linkRectImagePadding = value
  }

  public set linkRectImageRadius(value: number) {
    this._linkRectImageRadius = value
  }

  public set linkRectImageMargin(value: number) {
    this._linkRectImageMargin = value
  }

  public set linkRectToolImageBackGroupColor(value: number) {
    this._linkRectToolImageBackGroupColor = value
  }

  public set linkRectToolImageButtonBackGroupColor(value: number) {
    this._linkRectToolImageButtonBackGroupColor = value
  }

  public set linkRectToolImageTextSize(value: number) {
    this._linkRectToolImageTextSize = value
  }

  public set linkRectToolImageHeight(value: number) {
    this._linkRectToolImageHeight = value
  }

  public set linkRectToolImagePadding(value: number) {
    this._linkRectToolImagePadding = value
  }

  public set linkRectToolImageBorderWidth(value: number) {
    this._linkRectToolImageBorderWidth = value
  }

  public set linkRectToolImageDividingLineWidth(value: number) {
    this._linkRectToolImageDividingLineWidth = value
  }

  public set linkRectToolImageMargin(value: number) {
    this._linkRectToolImageMargin = value
  }

  public set linkRectToolImageLineLeftPadding(value: number) {
    this._linkRectToolImageLineLeftPadding = value
  }

  public set linkRectToolImageLineRightPadding(value: number) {
    this._linkRectToolImageLineRightPadding = value
  }

  public set isMarkdownParserSync(value: boolean) {
    this._isMarkdownParserSync = value
  }

  public set typeWriterOpen(value: boolean) {
    this._typeWriterOpen = value
  }

  public set typeWriterColor(value: number) {
    this._typeWriterColor = value
  }

  public set isOnCopy(value: boolean) {
    this._isOnCopy = value
  }

  public set blockFirstTopMargin(value: number) {
    this._blockFirstTopMargin = value
  }

  public set blockLastBottomMargin(value: number) {
    this._blockLastBottomMargin = value
  }

  public set blockTopAndBottomMargins(value: number) {
    this._blockTopAndBottomMargins = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
