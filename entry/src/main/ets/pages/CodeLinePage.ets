/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { getFileListStr } from './FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from './BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct CodeLinePage {
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
  rawFilePath: string = "010_内联代码"
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
   * 内联代码是否是图片显示列表
   */
  isCodeStyleList: Array<boolean> = [true, false]
  /**
   * 内联代码是否是图片显示
   */
  @State
  isCodeStyle: boolean = false
  /**
   * 文本、图片格式内联代码文本颜色列表
   */
  codeTextColorList: Array<number> =
    [0xFF191919, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 文本、图片格式内联代码文本颜色
   */
  @State
  codeTextColor: number = 0xFF000000
  /**
   * 文本、图片格式内联代码背景颜色列表
   */
  codeBackgroundColorList: Array<number> =
    [0xFF191919, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 文本、图片格式内联代码背景颜色
   */
  @State
  codeBackgroundColor: number = 0xFFE0E0E0
  /**
   * 文本、图片格式内联代码文本大小列表
   */
  codeTextSizeList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 文本、图片格式内联代码文本大小
   */
  @State
  codeTextSize: number = 14
  /**
   * 文本格式内联代码文本字体列表
   */
  codeTypefaceList: Array<string> = ["HarmonyOS Sans", "Hei"]
  /**
   * 文本格式内联代码文本字体
   */
  @State
  codeTypeface: string = "HarmonyOS Sans"
  /**
   * 图片格式内联代码文本左右边距列表
   */
  codeLeftAndRightPaddingList: Array<number> = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  /**
   * 图片格式内联代码文本左右边距
   */
  @State
  codeLeftAndRightPadding: number = 4
  /**
   * 图片格式内联代码文本高度列表
   */
  codeHeightList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 图片格式内联代码文本高度
   */
  @State
  codeHeight: number = 20
  /**
   * 配置数据内容
   */
  @State
  codeLineData: CodeLineData = new CodeLineData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "内联代码配置页面",
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
                    this.codeLineData.isFull = this.isFull
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`内联代码是否是图片显示 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isCodeStyle}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isCodeStyleList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isCodeStyle = item
                    this.codeLineData.isCodeStyle = this.isCodeStyle
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`文本、图片格式内联代码文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.codeTextColor))
                .fontSize(16)
                .fontColor(this.codeTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeTextColor = item
                    this.codeLineData.codeTextColor = this.codeTextColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`文本、图片格式内联代码背景颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.codeBackgroundColor))
                .fontSize(16)
                .fontColor(this.codeBackgroundColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBackgroundColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBackgroundColor = item
                    this.codeLineData.codeBackgroundColor = this.codeBackgroundColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`文本、图片格式内联代码文本大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeTextSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeTextSizeList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeTextSize = item
                    this.codeLineData.codeTextSize = this.codeTextSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`文本格式内联代码文本字体 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeTypeface}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeTypefaceList, (item: string, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeTypeface = item
                    this.codeLineData.codeTypeface = this.codeTypeface
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片格式内联代码文本左右边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeLeftAndRightPadding}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeLeftAndRightPaddingList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeLeftAndRightPadding = item
                    this.codeLineData.codeLeftAndRightPadding = this.codeLeftAndRightPadding
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`图片格式内联代码文本高度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeHeight = item
                    this.codeLineData.codeHeight = this.codeHeight
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
                    this.codeLineData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/CodeLineDetailsPage", params: this.codeLineData })
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

export class CodeLineData {
  _isFull: boolean = true
  _isCodeStyle: boolean = false
  _codeTextColor: number = 0xFF000000
  _codeBackgroundColor: number = 0xFFE0E0E0
  _codeTextSize: number = 13
  _codeTypeface: string = "HarmonyOS Sans"
  _codeLeftAndRightPadding: number = 4
  _codeHeight: number = 20
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set isCodeStyle(value: boolean) {
    this._isCodeStyle = value
  }

  public set codeTextColor(value: number) {
    this._codeTextColor = value
  }

  public set codeBackgroundColor(value: number) {
    this._codeBackgroundColor = value
  }

  public set codeTextSize(value: number) {
    this._codeTextSize = value
  }

  public set codeTypeface(value: string) {
    this._codeTypeface = value
  }

  public set codeLeftAndRightPadding(value: number) {
    this._codeLeftAndRightPadding = value
  }

  public set codeHeight(value: number) {
    this._codeHeight = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
