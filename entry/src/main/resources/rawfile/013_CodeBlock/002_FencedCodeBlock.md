围栏代码块

```cangjie
setPlugin(): MarkdownPlugin {
    let a = new MarkdownPlugin()
    a.setIsTablePlugin(true)
    a.setIsLatexMathPlugin(true)
    return a
}
```

```cangjie
setPlugin(): MarkdownPlugin {
    let a = new MarkdownPlugin()
    a.setIsTablePlugin(true)
    a.setIsLatexMathPlugin(true)
    return a
}






```

```
setPlugin(): MarkdownPlugin {
    let a = new MarkdownPlugin()
    a.setIsTablePlugin(true)
    a.setIsLatexMathPlugin(true)
    return a
}
```

围栏代码块

```js
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { getFileListStr } from './FileUtils'
import { booleanToString, numberToColorString, stringToBoolean } from './BaseUtils'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct CodeBlockPage {
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
  rawFilePath: string = "011_代码块"
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
   * 代码块代码文本颜色列表
   */
  codeBlockTextColorList: Array<number | undefined> =
    [0xFF191919, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0, undefined]
  /**
   * 代码块代码文本颜色
   */
  @State
  codeBlockTextColor: number | undefined = undefined
  /**
   * 代码块代码类型文本颜色列表
   */
  codeBlockTypeTextColorList: Array<number | undefined> =
    [0xFF191919, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0, undefined]
  /**
   * 代码块代码类型文本颜色
   */
  @State
  codeBlockTypeTextColor: number | undefined = undefined
  /**
   * 代码块复制、全屏图片文字是否显示列表
   */
  codeBlockIconTextHideList: Array<boolean> = [true, false]
  /**
   * 代码块复制、全屏图片文字是否显示
   */
  @State
  codeBlockIconTextHide: boolean = false
  /**
   * 代码块代码行号是否显示列表
   */
  codeBlockLineNumberHideList: Array<boolean> = [true, false]
  /**
   * 代码块代码行号是否显示
   */
  @State
  codeBlockLineNumberHide: boolean = false
  /**
   * 代码块背景颜色列表
   */
  codeBlockBackgroundColorList: Array<number | undefined> =
    [0xFF191919, 0xFF000000, 0xFFFFFFFF, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFE0E0E0, undefined]
  /**
   * 代码块背景颜色
   */
  @State
  codeBlockBackgroundColor: number | undefined = undefined
  /**
   * 代码块左边距列表
   */
  codeMultilineMarginList: Array<number> = [1, 2, 4, 8, 10, 12, 14, 15, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 代码块左边距
   */
  @State
  codeMultilineMargin: number = 8
  /**
   * 代码块字体列表
   */
  codeBlockTypefaceList: Array<string> = ["HarmonyOS Sans", "Hei"]
  /**
   * 代码块字体
   */
  @State
  codeBlockTypeface: string = "HarmonyOS Sans"
  /**
   * 代码块代码文本大小列表
   */
  codeBlockTextSizeList: Array<number> = [12, 13, 14, 15, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 代码块代码文本大小
   */
  @State
  codeBlockTextSize: number = 13
  /**
   * 代码块代码文本行高列表
   */
  codeBlockLineHeightList: Array<number> = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 代码块代码文本行高
   */
  @State
  codeBlockLineHeight: number = 22
  /**
   * 代码块控件圆角大小列表
   */
  codeBlockRadiusList: Array<number> = [0, 5, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 代码块控件圆角大小
   */
  @State
  codeBlockRadius: number = 8
  /**
   * 代码块代码全屏按钮是否显示列表
   */
  isCodeFullScreenList: Array<boolean> = [true, false]
  /**
   * 代码块代码全屏按钮是否显示
   */
  @State
  isCodeFullScreen: boolean = true
  /**
   * 代码块代码全屏、代码复制按钮宽高列表
   */
  iconWidthAndHeightList: Array<number> = [0, 5, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
  /**
   * 代码块代码全屏、代码复制按钮宽高
   */
  @State
  iconWidthAndHeight: number = 24
  /**
   * 代码块深浅色模式列表
   */
  isDarkList: Array<boolean> = [true, false]
  /**
   * 代码块深浅色模式
   */
  @State
  isDark: boolean = true
  /**
   * 配置数据内容
   */
  @State
  codeBlockData: CodeBlockData = new CodeBlockData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "代码块配置页面",
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
                    this.codeBlockData.isFull = this.isFull
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块代码文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.codeBlockTextColor))
                .fontSize(16)
                .fontColor(this.codeBlockTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockTextColor = item
                    this.codeBlockData.codeBlockTextColor = this.codeBlockTextColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块代码类型文本颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.codeBlockTypeTextColor))
                .fontSize(16)
                .fontColor(this.codeBlockTypeTextColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockTypeTextColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockTypeTextColor = item
                    this.codeBlockData.codeBlockTypeTextColor = this.codeBlockTypeTextColor
                  })
              })
            }
          }


          Column() {
            Row() {
              Text(`代码块复制、全屏图片文字是否显示 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeBlockIconTextHide}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockIconTextHideList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockIconTextHide = item
                    this.codeBlockData.codeBlockIconTextHide = this.codeBlockIconTextHide
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块代码行号是否显示 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeBlockLineNumberHide}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockLineNumberHideList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockLineNumberHide = item
                    this.codeBlockData.codeBlockLineNumberHide = this.codeBlockLineNumberHide
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块背景颜色 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(numberToColorString(this.codeBlockBackgroundColor))
                .fontSize(16)
                .fontColor(this.codeBlockBackgroundColor)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockBackgroundColorList, (item: number, index: number) => {
                Button(numberToColorString(item))
                  .type(ButtonType.Capsule)
                  .fontColor(Color.Gray)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(item)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockBackgroundColor = item
                    this.codeBlockData.codeBlockBackgroundColor = this.codeBlockBackgroundColor
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块左边距 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeMultilineMargin}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeMultilineMarginList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeMultilineMargin = item
                    this.codeBlockData.codeMultilineMargin = this.codeMultilineMargin
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块字体 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeBlockTypeface}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockTypefaceList, (item: string, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockTypeface = item
                    this.codeBlockData.codeBlockTypeface = this.codeBlockTypeface
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块代码文本大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeBlockTextSize}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockTextSizeList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockTextSize = item
                    this.codeBlockData.codeBlockTextSize = this.codeBlockTextSize
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块代码文本行高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeBlockLineHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockLineHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockLineHeight = item
                    this.codeBlockData.codeBlockLineHeight = this.codeBlockLineHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块控件圆角大小 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.codeBlockRadius}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.codeBlockRadiusList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.codeBlockRadius = item
                    this.codeBlockData.codeBlockRadius = this.codeBlockRadius
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块代码全屏按钮是否显示 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isCodeFullScreen}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isCodeFullScreenList, (item: boolean, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isCodeFullScreen = item
                    this.codeBlockData.isCodeFullScreen = this.isCodeFullScreen
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块代码全屏、代码复制按钮宽高 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.iconWidthAndHeight}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.iconWidthAndHeightList, (item: number, index: number) => {
                Button(item.toString())
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.iconWidthAndHeight = item
                    this.codeBlockData.iconWidthAndHeight = this.iconWidthAndHeight
                  })
              })
            }
          }

          Column() {
            Row() {
              Text(`代码块深浅色模式 - `)
                .fontSize(16)
                .textAlign(TextAlign.Start)
              Text(`${this.isDark}`)
                .fontSize(16)
                .textAlign(TextAlign.Start)
            }
            .width("100%")
            .backgroundColor(Color.Gray)
            .padding(2)
            .margin(2)

            Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
              ForEach(this.isDarkList, (item: boolean, index: number) => {
                Button(`${item}`)
                  .type(ButtonType.Capsule)
                  .stateEffect(true)
                  .height(25)
                  .margin(2)
                  .backgroundColor(0xFF317AFF)
                  .fontSize(14)
                  .onClick(() => {
                    this.isDark = item
                    this.codeBlockData.isDark = this.isDark
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
                    this.codeBlockData.pagePath = `${this.rawFilePath}/${item}`
                    router.pushUrl({ url: "pages/CodeBlockDetailsPage", params: this.codeBlockData })
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

export class CodeBlockData {
  _isFull: boolean = true
  _codeBlockTextColor: number | undefined = undefined
  _codeBlockTypeTextColor: number | undefined = undefined
  _codeBlockIconTextHide: boolean = true
  _codeBlockLineNumberHide: boolean = true
  _codeBlockBackgroundColor: number | undefined = undefined
  _codeMultilineMargin: number = 8.0
  _codeBlockTypeface: string = "HarmonyOS Sans"
  _codeBlockTextSize: number = 13
  _codeBlockLineHeight: number = 22
  _codeBlockRadius: number = 8
  _isCodeFullScreen: boolean = true
  _iconWidthAndHeight: number = 24
  _isDark: boolean = true
  _pagePath: string = ""

  public set isFull(value: boolean) {
    this._isFull = value
  }

  public set codeBlockTextColor(value: ResourceColor | undefined) {
    this._codeBlockTextColor = value
  }

  public set codeBlockTypeTextColor(value: ResourceColor | undefined) {
    this._codeBlockTypeTextColor = value
  }

  public set codeBlockIconTextHide(value: boolean) {
    this._codeBlockIconTextHide = value
  }

  public set codeBlockLineNumberHide(value: boolean) {
    this._codeBlockLineNumberHide = value
  }

  public set codeBlockBackgroundColor(value: ResourceColor | undefined) {
    this._codeBlockBackgroundColor = value
  }

  public set codeMultilineMargin(value: number) {
    this._codeMultilineMargin = value
  }

  public set codeBlockTypeface(value: string) {
    this._codeBlockTypeface = value
  }

  public set codeBlockTextSize(value: number) {
    this._codeBlockTextSize = value
  }

  public set codeBlockLineHeight(value: number) {
    this._codeBlockLineHeight = value
  }

  public set codeBlockRadius(value: number) {
    this._codeBlockRadius = value
  }


  public set isCodeFullScreen(value: boolean) {
    this._isCodeFullScreen = value
  }


  public set iconWidthAndHeight(value: number) {
    this._iconWidthAndHeight = value
  }

  public set isDark(value: boolean) {
    this._isDark = value
  }
  public set pagePath(value: string) {
    this._pagePath = value
  }

  constructor() {
  }
}
```

围栏代码块

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的第一个HTML页面</title>
</head>
<body>
    <header>
        <h1>欢迎来到我的网站</h1>
        <nav>
            <ul>
                <li><a href="#home">首页</a></li>
                <li><a href="#about">关于我们</a></li>
                <li><a href="#contact">联系我们</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section id="home">
            <h2>首页内容</h2>
            <p>这是一个简单的HTML页面示例。</p>
            <p>HTML是构建网页的基础语言。</p>
        </section>

        <section id="about">
            <h2>关于我们</h2>
            <p>我们是一个专注于Web开发的团队。</p>
            <h3>我们的服务</h3>
            <ul>
                <li>网站开发</li>
                <li>前端设计</li>
                <li>后端开发</li>
            </ul>
        </section>

        <section id="contact">
            <h2>联系我们</h2>
            <p>邮箱：contact@example.com</p>
            <p>电话：123-456-7890</p>
        </section>
    </main>

    <footer>
        <p>&copy; 2023 我的网站 版权所有</p>
    </footer>
</body>
</html>
```