/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { getFileListStr } from './FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from './BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct TitlePage {
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
  rawFilePath: string = "001_标题"
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
   * H1、H2下划线高度列表
   */
  headingBreakHeightList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  /**
   * H1、H2下划线高度
   */
  @State
  headingBreakHeight: number = 1
  /**
   * H1、H2下划线颜色列表
   */
  headingBreakColorList: Array<number> = [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * H1、H2下划线颜色
   */
  @State
  headingBreakColor: number = 0xFF000000
  /**
   * 标题文本颜色列表
   */
  headingTextColorList: Array<number> = [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 标题文本颜色
   */
  @State
  headingTextColor: number = 0xFF000000
  /**
   * 标题文本字间距列表
   */
  headingTextWordSpaceList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  /**
   * 标题文本字间距
   */
  @State
  headingTextWordSpace: number = 0
  /**
   * 一级标题行高列表
   */
  headingTextLineHeight1List: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 一级标题行高
   */
  @State
  headingTextLineHeight1: number = 22
  /**
   * 二级标题行高列表
   */
  headingTextLineHeight2List: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 二级标题行高
   */
  @State
  headingTextLineHeight2: number = 22
  /**
   * 三级标题行高列表
   */
  headingTextLineHeight3List: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 三级标题行高
   */
  @State
  headingTextLineHeight3: number = 22
  /**
   * 四级标题行高列表
   */
  headingTextLineHeight4List: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
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
  headingTextLineHeight6List: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 六级标题行高
   */
  @State
  headingTextLineHeight6: number = 22
  /**
   * 标题文本大小数组列表
   */
  headingTextSizeMultipliersList: Array<Array<number>> = [
    [15.0, 15.0, 15.0, 15.0, 15.0, 15.0],
    [18.0, 18.0, 18.0, 18.0, 18.0, 18.0],
    [20.0, 20.0, 20.0, 20.0, 20.0, 20.0],
    [22.0, 22.0, 22.0, 22.0, 22.0, 22.0],
    [20.0, 17.0, 16.0, 15.0, 15.0, 13.0],
    [22.0, 20.0, 18.0, 16.0, 14.0, 12.0],
    [24.0, 22.0, 20.0, 18.0, 16.0, 14.0]
  ]
  /**
   * 标题文本大小数组
   */
  @State
  headingTextSizeMultipliers: Array<number> = [20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
  /**
   * 标题文本字体列表
   */
  headingTypefaceList: Array<string> = ["HarmonyOS Sans", "Hei"]
  /**
   * 标题文本字体
   */
  @State
  headingTypeface: string = "HarmonyOS Sans"
  /**
   * 标题模块上间距列表
   */
  headingTopMarginsList: Array<number> = [0, 5, 8, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 标题模块上间距
   */
  @State
  headingTopMargins: number = 8
  /**
   * 标题模块下间距列表
   */
  headingBottomMarginsList: Array<number> = [0, 5, 8, 10, 15, 20, 25, 30, 35, 40]
  /**
   * 标题模块下间距
   */
  @State
  headingBottomMargins: number = 8
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
                    this.titleData.isFull = this.isFull
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`H1、H2下划线高度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.headingBreakHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.headingBreakHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.headingBreakHeight = item
                    this.titleData.headingBreakHeight = this.headingBreakHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`H1、H2下划线颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.headingBreakColor))
                .fontSize(16)
                .fontColor(this.headingBreakColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.headingBreakColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.headingBreakColor = item
                    this.titleData.headingBreakColor = this.headingBreakColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`标题文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.headingTextColor))
                .fontSize(16)
                .fontColor(this.headingTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.headingTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.headingTextColor = item
                    this.titleData.headingTextColor = this.headingTextColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`标题文本字间距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.headingTextWordSpace}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.headingTextWordSpaceList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.headingTextWordSpace = item
                    this.titleData.headingTextWordSpace = this.headingTextWordSpace
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`一级标题行高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.headingTextLineHeight1}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.headingTextLineHeight1List, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.headingTextLineHeight1 = item
                    this.titleData.headingTextLineHeight1 = this.headingTextLineHeight1
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`二级标题行高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.headingTextLineHeight2}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.headingTextLineHeight2List, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.headingTextLineHeight2 = item
                    this.titleData.headingTextLineHeight2 = this.headingTextLineHeight2
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`三级标题行高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.headingTextLineHeight3}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.headingTextLineHeight3List, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.headingTextLineHeight3 = item
                    this.titleData.headingTextLineHeight3 = this.headingTextLineHeight3
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`四级标题行高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.headingTextLineHeight4}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.headingTextLineHeight4List, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.headingTextLineHeight4 = item
                    this.titleData.headingTextLineHeight4 = this.headingTextLineHeight4
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`五级标题行高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.headingTextLineHeight5}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.headingTextLineHeight5List, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.headingTextLineHeight5 = item
                    this.titleData.headingTextLineHeight5 = this.headingTextLineHeight5
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`六级标题行高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.headingTextLineHeight6}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.headingTextLineHeight6List, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.headingTextLineHeight6 = item
                    this.titleData.headingTextLineHeight6 = this.headingTextLineHeight6
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`标题文本大小数组 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.headingTextSizeMultipliers}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.headingTextSizeMultipliersList, (item: Array<number>, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.headingTextSizeMultipliers = item
                    this.titleData.headingTextSizeMultipliers = this.headingTextSizeMultipliers
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`标题文本字体 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.headingTypeface}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.headingTypefaceList, (item: string, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.headingTypeface = item
                    this.titleData.headingTypeface = this.headingTypeface
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`标题模块上间距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.headingTopMargins}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.headingTopMarginsList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.headingTopMargins = item
                    this.titleData.headingTopMargins = this.headingTopMargins
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`标题模块下间距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.headingBottomMargins}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.headingBottomMarginsList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.headingBottomMargins = item
                    this.titleData.headingBottomMargins = this.headingBottomMargins
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
                    this.titleData.pagePath = `${this.rawFilePath}/${item}`
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

export class TitleData {
  _isFull: boolean = true
  _headingBreakHeight: number = 1
  _headingBreakColor: number = 0xFF000000
  _headingTextColor: number = 0xFF000000
  _headingTextWordSpace: number = 0
  _headingTextLineHeight1: number = 22
  _headingTextLineHeight2: number = 22
  _headingTextLineHeight3: number = 22
  _headingTextLineHeight4: number = 22
  _headingTextLineHeight5: number = 22
  _headingTextLineHeight6: number = 22
  _headingTextSizeMultipliers: Array<number> = [20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
  _headingTypeface: string = "HarmonyOS Sans"
  _headingTopMargins: number = 8
  _headingBottomMargins: number = 8
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set headingBreakHeight(value: number) {
    this._headingBreakHeight = value
  }

  public set headingBreakColor(value: number) {
    this._headingBreakColor = value
  }

  public set headingTextColor(value: number) {
    this._headingTextColor = value
  }

  public set headingTextWordSpace(value: number) {
    this._headingTextWordSpace = value
  }

  public set headingTextLineHeight1(value: number) {
    this._headingTextLineHeight1 = value
  }

  public set headingTextLineHeight2(value: number) {
    this._headingTextLineHeight2 = value
  }

  public set headingTextLineHeight3(value: number) {
    this._headingTextLineHeight3 = value
  }

  public set headingTextLineHeight4(value: number) {
    this._headingTextLineHeight4 = value
  }

  public set headingTextLineHeight5(value: number) {
    this._headingTextLineHeight5 = value
  }

  public set headingTextLineHeight6(value: number) {
    this._headingTextLineHeight6 = value
  }

  public set headingTextSizeMultipliers(value: Array<number>) {
    this._headingTextSizeMultipliers = value
  }

  public set headingTypeface(value: string) {
    this._headingTypeface = value
  }

  public set headingTopMargins(value: number) {
    this._headingTopMargins = value
  }

  public set headingBottomMargins(value: number) {
    this._headingBottomMargins = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
