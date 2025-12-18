/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { getFileListStr } from './FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from './BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct TablePage {
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
  rawFilePath: string = "006_表格"
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
   * 表格内容内边距列表
   */
  tableCellPaddingList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  /**
   * 表格内容内边距
   */
  @State
  tableCellPadding: number = 4
  /**
   * 表格边框颜色列表
   */
  tableBorderColorList: Array<number> = [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 表格边框颜色
   */
  @State
  tableBorderColor: number = 0xFF000000
  /**
   * 表格边框宽度列表
   */
  tableBorderWidthList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  /**
   * 表格边框宽度
   */
  @State
  tableBorderWidth: number = 1
  /**
   * 表格奇数行背景色列表
   */
  tableOddRowBackgroundColorList: Array<number> =
    [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 表格奇数行背景色
   */
  @State
  tableOddRowBackgroundColor: number = 0xFFFFFFFF
  /**
   * 表格偶数行背景色列表
   */
  tableEvenRowBackgroundColorList: Array<number> =
    [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 表格偶数行背景色
   */
  @State
  tableEvenRowBackgroundColor: number = 0xFFE0E0E0
  /**
   * 表格头背景色列表
   */
  tableHeaderRowBackgroundColorList: Array<number> =
    [0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 表格头背景色
   */
  @State
  tableHeaderRowBackgroundColor: number = 0xFFFFFFFF
  /**
   * 表格文本行高列表
   */
  tableTextLineHeightList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 表格文本行高
   */
  @State
  tableTextLineHeight: number = 22
  /**
   * 表格圆角列表
   */
  tableRadiusList: Array<number> = [0, 1, 2, 5, 10, 15, 20, 25, 30]
  /**
   * 表格圆角
   */
  @State
  tableRadius: number = 5
  /**
   * 表格最小宽度列表
   */
  tableMinTextWidthList: Array<number> = [0, 30, 50, 80, 100, 150, 200, 250, 300, 350, 400]
  /**
   * 表格最小宽度
   */
  @State
  tableMinTextWidth: number = 50
  /**
   * 表格最大宽度列表
   */
  tableMaxTextWidthList: Array<number> = [0, 30, 50, 80, 100, 150, 200, 250, 300, 350, 400]
  /**
   * 表格最大宽度
   */
  @State
  tableMaxTextWidth: number = 300
  /**
   * 表格第一列是否加粗列表
   */
  tableFirstColumnBoldList: Array<boolean> = [true, false]
  /**
   * 表格第一列是否加粗
   */
  @State
  tableFirstColumnBold: boolean = false
  /**
   * 配置数据内容
   */
  @State
  tableData: TableData = new TableData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "表格配置页面",
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
                    this.tableData.isFull = this.isFull
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`表格内容内边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.tableCellPadding}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.tableCellPaddingList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.tableCellPadding = item
                    this.tableData.tableCellPadding = this.tableCellPadding
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`表格边框颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.tableBorderColor))
                .fontSize(16)
                .fontColor(this.tableBorderColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.tableBorderColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.tableBorderColor = item
                    this.tableData.tableBorderColor = this.tableBorderColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`表格边框宽度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.tableBorderWidth}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.tableBorderWidthList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.tableBorderWidth = item
                    this.tableData.tableBorderWidth = this.tableBorderWidth
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`表格奇数行背景色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.tableOddRowBackgroundColor))
                .fontSize(16)
                .fontColor(this.tableOddRowBackgroundColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.tableOddRowBackgroundColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.tableOddRowBackgroundColor = item
                    this.tableData.tableOddRowBackgroundColor = this.tableOddRowBackgroundColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`表格偶数行背景色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.tableEvenRowBackgroundColor))
                .fontSize(16)
                .fontColor(this.tableEvenRowBackgroundColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.tableEvenRowBackgroundColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.tableEvenRowBackgroundColor = item
                    this.tableData.tableEvenRowBackgroundColor = this.tableEvenRowBackgroundColor
                  })
              })
            }
          }


          Column() {
            Row() {
              Text(`表格头背景色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.tableHeaderRowBackgroundColor))
                .fontSize(16)
                .fontColor(this.tableHeaderRowBackgroundColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.tableHeaderRowBackgroundColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.tableHeaderRowBackgroundColor = item
                    this.tableData.tableHeaderRowBackgroundColor = this.tableHeaderRowBackgroundColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`表格文本行高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.tableTextLineHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.tableTextLineHeightList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.tableTextLineHeight = item
                    this.tableData.tableTextLineHeight = this.tableTextLineHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`表格圆角 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.tableRadius}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.tableRadiusList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.tableRadius = item
                    this.tableData.tableRadius = this.tableRadius
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`表格最小宽度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.tableMinTextWidth}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.tableMinTextWidthList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.tableMinTextWidth = item
                    this.tableData.tableMinTextWidth = this.tableMinTextWidth
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`表格最大宽度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.tableMaxTextWidth}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.tableMaxTextWidthList, (item: number, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.tableMaxTextWidth = item
                    this.tableData.tableMaxTextWidth = this.tableMaxTextWidth
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`表格第一列是否加粗 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.tableFirstColumnBold}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.tableFirstColumnBoldList, (item: boolean, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.tableFirstColumnBold = item
                    this.tableData.tableFirstColumnBold = this.tableFirstColumnBold
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
                    this.tableData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/TableDetailsPage", params: this.tableData })
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

export class TableData {
  _isFull: boolean = true
  _tableCellPadding: number = 4
  _tableBorderColor: number = 0xFF000000
  _tableBorderWidth: number = 1
  _tableOddRowBackgroundColor: number = 0xFFFFFFFF
  _tableEvenRowBackgroundColor: number = 0xFFE0E0E0
  _tableHeaderRowBackgroundColor: number = 0xFFFFFFFF
  _tableTextLineHeight: number = 22
  _tableRadius: number = 5
  _tableMinTextWidth: number = 50
  _tableMaxTextWidth: number = 300
  _tableFirstColumnBold: boolean = false
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set tableCellPadding(value: number) {
    this._tableCellPadding = value
  }

  public set tableBorderColor(value: number) {
    this._tableBorderColor = value
  }

  public set tableBorderWidth(value: number) {
    this._tableBorderWidth = value
  }

  public set tableOddRowBackgroundColor(value: number) {
    this._tableOddRowBackgroundColor = value
  }

  public set tableEvenRowBackgroundColor(value: number) {
    this._tableEvenRowBackgroundColor = value
  }

  public set tableHeaderRowBackgroundColor(value: number) {
    this._tableHeaderRowBackgroundColor = value
  }

  public set tableTextLineHeight(value: number) {
    this._tableTextLineHeight = value
  }

  public set tableRadius(value: number) {
    this._tableRadius = value
  }

  public set tableMinTextWidth(value: number) {
    this._tableMinTextWidth = value
  }

  public set tableMaxTextWidth(value: number) {
    this._tableMaxTextWidth = value
  }

  public set tableFirstColumnBold(value: boolean) {
    this._tableFirstColumnBold = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
