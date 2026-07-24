import { router } from '@kit.ArkUI'
import { font } from '@kit.ArkUI'
import { getFileContextStr } from '../utils/FileUtils'

/**
 * 入口页面 - 直接使用 ArkUI 渲染列表（不再走 CJHybridComponentV2 互操作）
 * 参考 markdown4cj_hybrid_lite 的 IndexPage.ets 实现
 */
@Entry
@Component
struct IndexPage {
  @StorageProp('safeTop') safeTop: number = 0

  aboutToAppear(): void {
    font.registerFont({
      "familyName": "Hei",
      "familySrc": "font/myfont.ttf"
    })
    // 仍需保留 globalThis 上的全局回调，供仓颉页面调用
    globalThis.navigate = (page: string) => {
      if (page === 'demo') {
        router.pushUrl({ url: 'pages/demo_page' })
      } else {
        router.pushUrl({ url: 'pages/' + page })
      }
    }
    globalThis.routerBack = (_: string) => {
      router.back()
    }
    globalThis.loadContent = (filePath: string) => {
      let content = getFileContextStr(filePath)
      globalThis.markdownContent = content
    }
    globalThis.safeTop = this.safeTop.toString()
    globalThis.appResources = {
      "startIcon": $r('app.media.startIcon'),
      "app_icon": $r('app.media.app_icon'),
      "background": $r('app.media.background'),
      "you": $r('app.media.you'),
    }
  }

  build() {
    Column() {
      // 顶部标题栏
      Column() {
        Text("")
          .height(this.safeTop)
          .width('100%')
        Row() {
          Text("Markdown测试用例")
            .height(40)
            .layoutWeight(1)
            .fontColor(0xFFFFFFFF)
            .align(Alignment.Center)
            .textAlign(TextAlign.Center)
            .fontSize(18)
        }
      }
      .backgroundColor(0xFFFF0000)

      // 列表
      Scroll() {
        List() {
          ListItem() {
            Button("0、演示样例")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/demo_page' }))
          }

          ListItem() {
            Button("1、标题")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/TitlePage' }))
          }

          ListItem() {
            Button("2、段落")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/ParagraphPage' }))
          }

          ListItem() {
            Button("3、分割线")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/ThematicPage' }))
          }

          ListItem() {
            Button("4、软换行")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/LineBreakPage' }))
          }

          ListItem() {
            Button("5、数学公式")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/LatexMathPage' }))
          }

          ListItem() {
            Button("6、表格")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/TablePage' }))
          }

          ListItem() {
            Button("7、链接")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/LinkPage' }))
          }

          ListItem() {
            Button("8、块引用")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/QuotePage' }))
          }

          ListItem() {
            Button("9、列表")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/ListPage' }))
          }

          ListItem() {
            Button("10、内联代码")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/CodeLinePage' }))
          }

          ListItem() {
            Button("11、代码块")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/CodeBlockPage' }))
          }

          ListItem() {
            Button("12、组合代码块")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/CodeListPage' }))
          }

          ListItem() {
            Button("13、单独代码块")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/CodeSeparatePage' }))
          }

          ListItem() {
            Button("14、音频")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/AudioPage' }))
          }

          ListItem() {
            Button("15、视频")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/VideoPage' }))
          }

          ListItem() {
            Button("16、图片")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/ImagePage' }))
          }

          ListItem() {
            Button("17、加粗")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/BoldPage' }))
          }

          ListItem() {
            Button("18、斜体")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/ItalicPage' }))
          }

          ListItem() {
            Button("19、删除线")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/StrikethroughPage' }))
          }

          ListItem() {
            Button("20、图片style")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/ImageStylePage' }))
          }

          ListItem() {
            Button("21、Toc目录")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/TocPage' }))
          }

          ListItem() {
            Button("22、脚注")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/FootnotePage' }))
          }

          ListItem() {
            Button("23、定义列表")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/DescListPage' }))
          }

          ListItem() {
            Button("24、标题ID")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/HeadIDPage' }))
          }

          ListItem() {
            Button("25、HTML")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/HTMLPage' }))
          }

          ListItem() {
            Button("26、下标")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/SubPage' }))
          }

          ListItem() {
            Button("27、上标")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/SupPage' }))
          }

          ListItem() {
            Button("28、Emoji")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/EmojiPage' }))
          }

          ListItem() {
            Button("29、综合")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/AllPage' }))
          }

          ListItem() {
            Button("30、Banner")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/BannerPage' }))
          }

          ListItem() {
            Button("31、AB方案")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/ABCustomPage' }))
          }

          ListItem() {
            Button("33、文本全量切换")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/SwitchDataPage' }))
          }

          ListItem() {
            Button("34、超大数据")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/BigDataPage' }))
          }

          ListItem() {
            Button("35、高亮文本")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/HighlightPage' }))
          }

          ListItem() {
            Button("38、链接曝光功能")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/LinkExposurePage' }))
          }

          ListItem() {
            Button("39、全局文本复制")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/AllPageCopyPage' }))
          }

          ListItem() {
            Button("40、段落高亮")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/HighlightParagraphPage' }))
          }


          ListItem() {
            Button("41、自定义卡片")
              .height(40)
              .width('80%')
              .type(ButtonType.Capsule)
              .fontColor(0xFFFFFFFF)
              .backgroundColor(0xFFFF0000)
              .margin({ top: 5, bottom: 5 })
              .fontSize(16)
              .onClick(() => router.pushUrl({ url: 'pages/CustomCardPage' }))
          }
        }
        .alignListItem(ListItemAlign.Center)
      }
      .padding({ bottom: 100 })
      .scrollable(ScrollDirection.Vertical)
      .layoutWeight(1)
    }
    .height('100%')
    .width('100%')
  }
}
