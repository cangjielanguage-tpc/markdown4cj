/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { getFileListStr } from './FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from './BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct ListPage {
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
  rawFilePath: string = "009_有序无序任务列表"
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
   * 有序列表、无序列表、任务列表子模块上下间距列表
   */
  blockOrderedAndBulletTopAndBottomMarginsList: Array<number> =
    [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
  /**
   * 有序列表、无序列表、任务列表子模块上下间距
   */
  @State
  blockOrderedAndBulletTopAndBottomMargins: number = 0
  /**
   * 有序列表、无序列表、任务列表左边距列表
   */
  blockLeftMarginList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20]
  /**
   * 有序列表、无序列表、任务列表左边距
   */
  @State
  blockLeftMargin: number = 8
  /**
   * 有序列表、无序列表、任务列表右边距列表
   */
  blockRightMarginList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20]
  /**
   * 有序列表、无序列表、任务列表右边距
   */
  @State
  blockRightMargin: number = 8
  /**
   * 有序列表前缀文本是否加粗列表
   */
  orderedListItemPrefixBoldList: Array<boolean> = [true, false]
  /**
   * 有序列表前缀文本是否加粗
   */
  @State
  orderedListItemPrefixBold: boolean = false
  /**
   * 有序列表前缀文本颜色列表
   */
  orderedListItemColorList: Array<number> =
    [0xFF191919, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 有序列表前缀文本颜色
   */
  @State
  orderedListItemColor: number = 0xFF191919
  /**
   * 有序列表前缀文本大小列表
   */
  orderedListItemSizeList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 有序列表前缀文本大小
   */
  @State
  orderedListItemSize: number = 14
  /**
   * 有序列表前缀文本行高列表
   */
  orderedListItemLineHeightList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 有序列表前缀文本行高
   */
  @State
  orderedListItemLineHeight: number = 22
  /**
   * 无序列表前缀文本颜色列表
   */
  bulletListItemColorList: Array<number> =
    [0xFF191919, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 无序列表前缀文本颜色
   */
  @State
  bulletListItemColor: number = 0xFF191919
  /**
   * 无序列表前缀文本大小列表
   */
  bulletListItemSizeList: Array<number> = [1, 2, 4, 8, 10, 12, 14, 15, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 无序列表前缀文本大小
   */
  @State
  bulletListItemSize: number = 4
  /**
   * 无序列表前缀文本行高列表
   */
  bulletListItemLineHeightList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 无序列表前缀文本行高
   */
  @State
  bulletListItemLineHeight: number = 18
  /**
   * 无序列表前缀文本行高列表
   */
  taskListItemLengthList: Array<number> = [12, 14, 15, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 无序列表前缀文本行高
   */
  @State
  taskListItemLength: number = 15
  /**
   * 配置数据内容
   */
  @State
  listData: ListData = new ListData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "有序、无序、任务列表配置页面",
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
                    this.listData.isFull = this.isFull
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`有序列表、无序列表、任务列表子模块上下间距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.blockOrderedAndBulletTopAndBottomMargins}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockOrderedAndBulletTopAndBottomMarginsList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockOrderedAndBulletTopAndBottomMargins = item
                    this.listData.blockOrderedAndBulletTopAndBottomMargins =
                      this.blockOrderedAndBulletTopAndBottomMargins
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`有序列表、无序列表、任务列表左边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.blockLeftMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockLeftMarginList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockLeftMargin = item
                    this.listData.blockLeftMargin = this.blockLeftMargin
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`有序列表、无序列表、任务列表右边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.blockRightMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.blockRightMarginList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.blockRightMargin = item
                    this.listData.blockRightMargin = this.blockRightMargin
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`有序列表前缀文本是否加粗 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.orderedListItemPrefixBold}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.orderedListItemPrefixBoldList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.orderedListItemPrefixBold = item
                    this.listData.orderedListItemPrefixBold = this.orderedListItemPrefixBold
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`有序列表前缀文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.orderedListItemColor))
                .fontSize(16)
                .fontColor(this.orderedListItemColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.orderedListItemColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.orderedListItemColor = item
                    this.listData.orderedListItemColor = this.orderedListItemColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`有序列表前缀文本大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.orderedListItemSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.orderedListItemSizeList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.orderedListItemSize = item
                    this.listData.orderedListItemSize = this.orderedListItemSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`有序列表前缀文本行高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.orderedListItemLineHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.orderedListItemLineHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.orderedListItemLineHeight = item
                    this.listData.orderedListItemLineHeight = this.orderedListItemLineHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`无序列表前缀文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.bulletListItemColor))
                .fontSize(16)
                .fontColor(this.bulletListItemColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.bulletListItemColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.bulletListItemColor = item
                    this.listData.bulletListItemColor = this.bulletListItemColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`无序列表前缀文本大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.bulletListItemSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.bulletListItemSizeList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.bulletListItemSize = item
                    this.listData.bulletListItemSize = this.bulletListItemSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`无序列表前缀文本行高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.bulletListItemLineHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.bulletListItemLineHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.bulletListItemLineHeight = item
                    this.listData.bulletListItemLineHeight = this.bulletListItemLineHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`任务列表选择框宽高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.taskListItemLength}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.taskListItemLengthList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.taskListItemLength = item
                    this.listData.taskListItemLength = this.taskListItemLength
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
                    this.listData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/ListDetailsPage", params: this.listData })
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

export class ListData {
  _isFull: boolean = true
  _blockOrderedAndBulletTopAndBottomMargins: number = 0
  _blockLeftMargin: number = 8
  _blockRightMargin: number = 8
  _orderedListItemPrefixBold: boolean = false
  _orderedListItemColor: number = 0xFF191919
  _orderedListItemSize: number = 14
  _orderedListItemLineHeight: number = 22
  _bulletListItemColor: number = 0xFF191919
  _bulletListItemSize: number = 4
  _bulletListItemLineHeight: number = 18
  _taskListItemLength: number = 15
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set blockOrderedAndBulletTopAndBottomMargins(value: number) {
    this._blockOrderedAndBulletTopAndBottomMargins = value
  }

  public set blockLeftMargin(value: number) {
    this._blockLeftMargin = value
  }

  public set blockRightMargin(value: number) {
    this._blockRightMargin = value
  }

  public set orderedListItemPrefixBold(value: boolean) {
    this._orderedListItemPrefixBold = value
  }

  public set orderedListItemColor(value: number) {
    this._orderedListItemColor = value
  }

  public set orderedListItemSize(value: number) {
    this._orderedListItemSize = value
  }

  public set orderedListItemLineHeight(value: number) {
    this._orderedListItemLineHeight = value
  }

  public set bulletListItemColor(value: number) {
    this._bulletListItemColor = value
  }

  public set bulletListItemSize(value: number) {
    this._bulletListItemSize = value
  }

  public set bulletListItemLineHeight(value: number) {
    this._bulletListItemLineHeight = value
  }

  public set taskListItemLength(value: number) {
    this._taskListItemLength = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
