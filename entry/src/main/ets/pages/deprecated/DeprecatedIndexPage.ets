import { font } from '@kit.ArkUI'
import { itemListComponent, titleComponent } from '../../component/BaseComponent'

@Entry
@Component
struct DeprecatedIndexPage {
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
        "Markdown测试用例-已废弃接口",
        0xFFFF0000,
        false,
        this.safeTop
      )
      Scroll(this.scroller) {
        List() {
          ListItem() {
            itemListComponent(
              "0、定义列表-块引用-删除线-上/下标",
              0xFFFF0000,
              "pages/deprecated/Deprecated0Page"
            )
          }

          ListItem() {
            itemListComponent(
              "1、链接-下划线-软换行-banner",
              0xFFFF0000,
              "pages/deprecated/Deprecated1Page"
            )
          }

          ListItem() {
            itemListComponent(
              "2、音频、视频",
              0xFFFF0000,
              "pages/deprecated/Deprecated2Page"
            )
          }

          ListItem() {
            itemListComponent(
              "3、标题、段落、分割线、内联代码",
              0xFFFF0000,
              "pages/deprecated/Deprecated3Page"
            )
          }

          ListItem() {
            itemListComponent(
              "4、数学公式、图片",
              0xFFFF0000,
              "pages/deprecated/Deprecated4Page"
            )
          }

          ListItem() {
            itemListComponent(
              "5、代码块",
              0xFFFF0000,
              "pages/deprecated/Deprecated5Page"
            )
          }

          ListItem() {
            itemListComponent(
              "6、表格、列表",
              0xFFFF0000,
              "pages/deprecated/Deprecated6Page"
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