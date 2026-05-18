import { itemListComponent, titleComponent } from '../component/BaseComponent'
import { font } from '@kit.ArkUI'

@Entry
@Component
struct IndexPage {
  /**
   * 滑动控制器
   */
  scroller: Scroller = new Scroller()
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0

  aboutToAppear(): void {
    font.registerFont({
      "familyName": "Hei",
      "familySrc": "font/myfont.ttf"
    })
  }

  build() {
    Column() {
      titleComponent(
        "Markdown测试用例",
        0xFFFF0000,
        false,
        this.safeTop
      )
      Scroll(this.scroller) {
        List() {
          ListItem() {
            itemListComponent(
              "示例",
              0xFFFF0000,
              "pages/Index"
            )
          }

          ListItem() {
            itemListComponent(
              "0、演示样例",
              0xFFFF0000,
              "pages/DemoPage"
            )
          }

          ListItem() {
            itemListComponent(
              "1、标题",
              0xFFFF0000,
              "pages/TitlePage"
            )
          }

          ListItem() {
            itemListComponent(
              "2、段落",
              0xFFFF0000,
              "pages/ParagraphPage"
            )
          }

          ListItem() {
            itemListComponent(
              "3、分割线",
              0xFFFF0000,
              "pages/ThematicPage"
            )
          }

          ListItem() {
            itemListComponent(
              "4、软换行",
              0xFFFF0000,
              "pages/LineBreakPage"
            )
          }

          ListItem() {
            itemListComponent(
              "5、数学公式",
              0xFFFF0000,
              "pages/LatexMathPage"
            )
          }

          ListItem() {
            itemListComponent(
              "6、表格",
              0xFFFF0000,
              "pages/TablePage"
            )
          }

          ListItem() {
            itemListComponent(
              "7、链接",
              0xFFFF0000,
              "pages/LinkPage"
            )
          }

          ListItem() {
            itemListComponent(
              "8、块引用",
              0xFFFF0000,
              "pages/QuotePage"
            )
          }

          ListItem() {
            itemListComponent(
              "9、有序、无序、任务列表",
              0xFFFF0000,
              "pages/ListPage"
            )
          }

          ListItem() {
            itemListComponent(
              "10、内联代码",
              0xFFFF0000,
              "pages/CodeLinePage"
            )
          }

          ListItem() {
            itemListComponent(
              "11、代码块",
              0xFFFF0000,
              "pages/CodeBlockPage"
            )
          }

          ListItem() {
            itemListComponent(
              "12、组合代码块",
              0xFFFF0000,
              "pages/CodeListPage"
            )
          }

          ListItem() {
            itemListComponent(
              "13、单独代码块",
              0xFFFF0000,
              "pages/CodeSeparatePage"
            )
          }

          ListItem() {
            itemListComponent(
              "14、音频",
              0xFFFF0000,
              "pages/AudioPage"
            )
          }

          ListItem() {
            itemListComponent(
              "15、视频",
              0xFFFF0000,
              "pages/VideoPage"
            )
          }

          ListItem() {
            itemListComponent(
              "16、图片",
              0xFFFF0000,
              "pages/ImagePage"
            )
          }

          ListItem() {
            itemListComponent(
              "17、加粗",
              0xFFFF0000,
              "pages/BoldPage"
            )
          }

          ListItem() {
            itemListComponent(
              "18、斜体",
              0xFFFF0000,
              "pages/ItalicPage"
            )
          }

          ListItem() {
            itemListComponent(
              "19、删除线",
              0xFFFF0000,
              "pages/StrikethroughPage"
            )
          }

          ListItem() {
            itemListComponent(
              "22、脚注",
              0xFFFF0000,
              "pages/FootnotePage"
            )
          }

          ListItem() {
            itemListComponent(
              "23、定义列表",
              0xFFFF0000,
              "pages/DescListPage"
            )
          }

          ListItem() {
            itemListComponent(
              "24、标题ID",
              0xFFFF0000,
              "pages/HeadIDPage"
            )
          }

          ListItem() {
            itemListComponent(
              "25、HTML",
              0xFFFF0000,
              "pages/HTMLPage"
            )
          }

          ListItem() {
            itemListComponent(
              "26、下标",
              0xFFFF0000,
              "pages/SubPage"
            )
          }

          ListItem() {
            itemListComponent(
              "27、上标",
              0xFFFF0000,
              "pages/SupPage"
            )
          }

          ListItem() {
            itemListComponent(
              "28、Emoji",
              0xFFFF0000,
              "pages/EmojiPage"
            )
          }

          ListItem() {
            itemListComponent(
              "29、综合",
              0xFFFF0000,
              "pages/AllPage"
            )
          }
          ListItem() {
            itemListComponent(
              "30、card",
              0xFFFF0000,
              "pages/CardPage"
            )
          }
          ListItem() {
            itemListComponent(
              "31、AB方案",
              0xFFFF0000,
              "pages/ABCustomPage"
            )
          }
          ListItem() {
            itemListComponent(
              "32、AI聊天懒加载",
              0xFFFF0000,
              "pages/AIChatPage"
            )
          }
          ListItem() {
            itemListComponent(
              "33、文本全量切换",
              0xFFFF0000,
              "pages/SwitchDataPage"
            )
          }
          ListItem() {
            itemListComponent(
              "34、超大数据",
              0xFFFF0000,
              "pages/BigDataPage"
            )
          }
        }
        // 设置ListItem在List交叉轴方向的布局方式
        .alignListItem(ListItemAlign.Center)
      }
      // 内边距
      .padding({ bottom: 100 })
      // 设置滚动方法
      .scrollable(ScrollDirection.Vertical)
    }
  }
}