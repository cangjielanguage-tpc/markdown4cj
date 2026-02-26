import { HotelCard } from '../customuicard/HotelCard';
import { PlaneCard } from '../customuicard/PlaneTicket';
import { CJMarkdown, MarkdownPlugin } from '@cangjie-tpc/markdown_hybrid'

globalThis.HotelCard = HotelCard
globalThis.PlaneCard = PlaneCard

@Entry
@Component
struct CardPage {
  build() {
    Column() {
      Column() {
        Text("你的管家")
          .fontWeight(FontWeight.Bold)
      }
      .height('10%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Column() {
        DemoPage()
      }
      .height('90%')
      .width('100%')
    }
    .height('100%')
    .width('100%')
  }
}


@Component
struct DemoPage {
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0
  /**
   * md文本
   */
  @State message: string = '## 您的行程订单\n' +
    '\n' +
    '- ### 住宿订单\n' +
    '\n' +
    '<card  name = "HotelCard"  data = \'{"hotelName":"安朴","roomType":"大床房","checkInDate":"2025-12-26","price":"800.0","status":"confirmed"}\' />\n' +
    '\n' +
    '- ### 机票订单\n' +
    '\n' +
    '<card  name = "PlaneCard" data = \'{"hotelName":"东方航空 DF1235","roomType":"经济仓","checkInDate":"2025-12-25 18:00","price":"2000.0","status":"confirmed"}\' />\n' +
    '\n' +
    '> **温馨提示**\n' +
    '> 1. 住宿订单可在入住前24小时免费取消\n' +
    '> 2. 机票订单改签需提前1小时申请\n' +
    '> 3. 如需开具行程单，请在订单完成后7天内操作\n';

  build() {
    Column() {
      Column() {
        CJMarkdown({
          content: this.message,
          plugin: this.setPlugin()

        })
      }
    }
    .padding({ left: 10, right: 10, top: this.safeTop })
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsHtmlPlugin(true) // HTML插件
    return plugin
  }
}

