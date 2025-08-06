/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { getFileListStr } from './FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from './BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct QuotePage {
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
  rawFilePath: string = "008_块引用"
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
   * 块引用左边距列表
   */
  blockQuoteLeftMarginList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20]
  /**
   * 块引用左边距
   */
  @State
  blockQuoteLeftMargin: number = 8
  /**
   * 块引用右边距列表
   */
  blockQuoteRightMarginList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20]
  /**
   * 块引用右边距
   */
  @State
  blockQuoteRightMargin: number = 8
  /**
   * 块引用左边线条宽度列表
   */
  blockQuoteWidthList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20]
  /**
   * 块引用左边线条宽度
   */
  @State
  blockQuoteWidth: number = 1
  /**
   * 块引用左边线条颜色列表
   */
  blockQuoteColorList: Array<number> =
    [0xFF191919, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 块引用左边线条颜色
   */
  @State
  blockQuoteColor: number = 0xFF191919
  /**
   * 块引用背景颜色列表
   */
  blockQuoteBackGroupColorList: Array<number> =
    [0xFF191919, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 块引用背景颜色
   */
  @State
  blockQuoteBackGroupColor: number = 0xFFFFFFFF
  /**
   * 块引用子模块上下间距列表
   */
  blockQuoteTopAndBottomMarginsList: Array<number> =
    [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50]
  /**
   * 块引用子模块上下间距
   */
  @State
  blockQuoteTopAndBottomMargins: number = 0
  /**
   * 配置数据内容
   */
  @State
  quoteData: QuoteData = new QuoteData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "块引用配置页面",
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
                    this.quoteData.isFull = this.isFull
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`块引用左边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.blockQuoteLeftMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockQuoteLeftMarginList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockQuoteLeftMargin = item
                    this.quoteData.blockQuoteLeftMargin = this.blockQuoteLeftMargin
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`块引用右边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.blockQuoteRightMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockQuoteRightMarginList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockQuoteRightMargin = item
                    this.quoteData.blockQuoteRightMargin = this.blockQuoteRightMargin
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`块引用左边线条宽度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.blockQuoteWidth}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockQuoteWidthList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockQuoteWidth = item
                    this.quoteData.blockQuoteWidth = this.blockQuoteWidth
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`块引用左边线条颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.blockQuoteColor))
                .fontSize(16)
                .fontColor(this.blockQuoteColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockQuoteColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockQuoteColor = item
                    this.quoteData.blockQuoteColor = this.blockQuoteColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`块引用背景颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.blockQuoteBackGroupColor))
                .fontSize(16)
                .fontColor(this.blockQuoteBackGroupColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockQuoteBackGroupColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockQuoteBackGroupColor = item
                    this.quoteData.blockQuoteBackGroupColor = this.blockQuoteBackGroupColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`块引用子模块上下间距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.blockQuoteTopAndBottomMargins}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockQuoteTopAndBottomMarginsList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockQuoteTopAndBottomMargins = item
                    this.quoteData.blockQuoteTopAndBottomMargins = this.blockQuoteTopAndBottomMargins
                  })
              })
            }
          }

          List() {
            ForEach(this.folderList, (item: string, index: number) => {
              ListItem() {
                Button(`${index + 1}、${item}`)
                  .height(40)// 高度
                  .width('80%')// 宽度
                  .type(ButtonType.Capsule)// 圆角
                  .fontColor(0xFFFFFFFF)// 文本颜色
                  .backgroundColor(0xFF317AFF)// 背景颜色
                  .margin({ top: 5, bottom: 5 })// 外边距
                  .align(Alignment.Center)// 内容对齐方式
                  .fontSize(16)// 字体大小
                  .onClick(() => {
                    // 点击动作触发该方法调用
                    this.quoteData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/QuoteDetailsPage", params: this.quoteData })
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
    .backgroundColor(0xFFEAEAEA)
    .height("100%")
  }
}

export class QuoteData {
  _isFull: boolean = true
  _blockQuoteLeftMargin: number = 8
  _blockQuoteRightMargin: number = 8
  _blockQuoteWidth: number = 1
  _blockQuoteColor: number = 0xFF191919
  _blockQuoteBackGroupColor: number = 0xFFFFFFFF
  _blockQuoteTopAndBottomMargins: number = 0
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set blockQuoteLeftMargin(value: number) {
    this._blockQuoteLeftMargin = value
  }

  public set blockQuoteRightMargin(value: number) {
    this._blockQuoteRightMargin = value
  }

  public set blockQuoteWidth(value: number) {
    this._blockQuoteWidth = value
  }

  public set blockQuoteColor(value: number) {
    this._blockQuoteColor = value
  }

  public set blockQuoteBackGroupColor(value: number) {
    this._blockQuoteBackGroupColor = value
  }

  public set blockQuoteTopAndBottomMargins(value: number) {
    this._blockQuoteTopAndBottomMargins = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
