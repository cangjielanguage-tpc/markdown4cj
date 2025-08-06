/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { getFileListStr } from './FileUtils'
import { booleanToString, stringToBoolean } from './BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct CodeSeparatePage {
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
  rawFilePath: string = "013_单独代码块"
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
   * 是否单独代码块显示列表
   */
  isSeparateCodeBlockList: Array<boolean> = [true, false]
  /**
   * 是否单独代码块显示
   */
  @State
  isSeparateCodeBlock: boolean = false
  /**
   * 单独代码块行号宽度列表
   */
  separateCodeBlockWidthList: Array<number> = [10, 20, 25, 30, 40, 50, 55, 60, 65, 70, 75, 80, 100]
  /**
   * 单独代码块行号宽度
   */
  @State
  separateCodeBlockWidth: number = 50
  /**
   * 配置数据内容
   */
  @State
  codeSeparateData: CodeSeparateData = new CodeSeparateData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "单独代码块配置页面",
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
                    this.codeSeparateData.isFull = this.isFull
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`是否单独代码块显示 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isSeparateCodeBlock}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isSeparateCodeBlockList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isSeparateCodeBlock = item
                    this.codeSeparateData.isSeparateCodeBlock = this.isSeparateCodeBlock
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`单独代码块行号宽度 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.separateCodeBlockWidth}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.separateCodeBlockWidthList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.separateCodeBlockWidth = item
                    this.codeSeparateData.separateCodeBlockWidth = this.separateCodeBlockWidth
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
                    this.codeSeparateData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/CodeSeparateDetailsPage", params: this.codeSeparateData })
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

export class CodeSeparateData {
  _isFull: boolean = true
  _isSeparateCodeBlock: boolean = false
  _separateCodeBlockWidth: number = 50
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set isSeparateCodeBlock(value: boolean) {
    this._isSeparateCodeBlock = value
  }

  public set separateCodeBlockWidth(value: number) {
    this._separateCodeBlockWidth = value
  }

  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
