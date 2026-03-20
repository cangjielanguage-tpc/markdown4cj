/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { booleanToString, numberToColorString, stringToBoolean, styleToString } from '../utils/BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct HTMLPage {
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
  rawFilePath: string = "025_HTML"
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
   * 下划线颜色列表
   */
  underlineColorList: Array<number> = [0xFF191919, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0]
  /**
   * 下划线颜色
   */
  @State
  underlineColor: number = 0xFF191919
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
   * 下划线样式
   */
  @State
  underlineStyle: TextDecorationStyle = TextDecorationStyle.SOLID
  /**
   * 下划线样式
   */
  underlineStyleList: Array<TextDecorationStyle> = [TextDecorationStyle.SOLID, TextDecorationStyle.DOUBLE, TextDecorationStyle.DOTTED, TextDecorationStyle.DASHED, TextDecorationStyle.WAVY]
  /**
   * 配置数据内容
   */
  @State
  htmlData: HTMLData = new HTMLData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "HTML配置页面",
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
                    this.htmlData.isFull = this.isFull
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
                    this.htmlData.isMarkdownParserSync = this.isMarkdownParserSync
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
                    this.htmlData.isOnCopy = this.isOnCopy
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
                    this.htmlData.blockFirstTopMargin = this.blockFirstTopMargin
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
                    this.htmlData.blockLastBottomMargin = this.blockLastBottomMargin
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
                    this.htmlData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`HTML下划线颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.underlineColor))
                .fontSize(16)
                .fontColor(this.underlineColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.underlineColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.underlineColor = item
                    this.htmlData.underlineColor = this.underlineColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`HTML下划线样式 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(styleToString(this.underlineStyle))
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.underlineStyleList, (item: TextDecorationStyle, index: number) => {
                Button(styleToString(item))
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.underlineStyle = item
                    this.htmlData.underlineStyle = this.underlineStyle
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
                    this.htmlData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/HTMLDetailsPage", params: this.htmlData })
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

export class HTMLData {
  _isFull: boolean = true
  _underlineColor: number = 0xFF191919
  _isMarkdownParserSync: boolean = false
  _isOnCopy: boolean = false
  _blockFirstTopMargin: number = 8
  _blockLastBottomMargin: number = 8
  _blockTopAndBottomMargins: number = 8
  _underlineStyle: TextDecorationStyle = TextDecorationStyle.SOLID
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set underlineColor(value: number) {
    this._underlineColor = value
  }

  public set isMarkdownParserSync(value: boolean) {
    this._isMarkdownParserSync = value
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

  public set underlineStyle(value: TextDecorationStyle) {
    this._underlineStyle = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
