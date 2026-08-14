import { titleComponent } from '../component/BaseComponent'
import { Message, MessageContent, Who } from '../model/Message'
import { MarkdownScrollController } from '@cangjie-tpc/markdown_arkui'
import { inputMethod } from '@kit.IMEKit'
import { AIChatBlockSticky } from '../component/AIChatBlockSticky'
import {
  MESSAGE_DATA_1, MESSAGE_DATA_2, MESSAGE_DATA_3, MESSAGE_DATA_4,
  MESSAGE_DATA_7, MESSAGE_DATA_8, MESSAGE_DATA_9, MESSAGE_DATA_10
} from '../model/MessageData'

const LIST_SPACE: number = 15

@Entry
@Component
struct AIChatTableStickyPage {
  @StorageProp('safeTop') safeTop: number = 0
  @State input: string = ''
  @State messages: Array<Message> = []

  private scroller: Scroller = new Scroller()
  private controllers: Array<MarkdownScrollController> = []
  private itemHeights: Array<number> = []

  aboutToAppear(): void {
    const data: Array<[string, Who]> = [
      [MESSAGE_DATA_1, Who.Me],
      [MESSAGE_DATA_2, Who.You],
      [MESSAGE_DATA_3, Who.Me],
      [MESSAGE_DATA_4, Who.You],
      [MESSAGE_DATA_7, Who.Me],
      [MESSAGE_DATA_8, Who.You],
      [MESSAGE_DATA_9, Who.Me],
      [MESSAGE_DATA_10, Who.You]
    ]
    for (let i = 0; i < data.length; i++) {
      this.messages.push(new Message(new MessageContent(data[i][0]), data[i][1], ''))
      this.controllers.push(new MarkdownScrollController())
      this.itemHeights.push(0)
    }
  }

  private notifyAllControllers(scrollY: number): void {
    let accumulatedY = 0
    for (let i = 0; i < this.controllers.length; i++) {
      this.controllers[i].notifyScrollY(scrollY - accumulatedY)
      accumulatedY += (this.itemHeights[i] || 0) + LIST_SPACE
    }
  }

  build() {
    Column() {
      titleComponent(
        "AI聊天表格吸顶",
        0xFF317AFF,
        true,
        this.safeTop
      )

      List({ scroller: this.scroller, space: LIST_SPACE }) {
        ForEach(this.messages, (value: Message, index: number) => {
          ListItem() {
            AIChatBlockSticky({
              message: value,
              scrollController: this.controllers[index],
              tableStickyHeader: true
            })
          }
          .onAreaChange((oldValue: Area, newValue: Area) => {
            this.itemHeights[index] = newValue.height as number
            this.notifyAllControllers(this.scroller.currentOffset().yOffset)
          })
        }, (value: Message, index: number) => index.toString())
      }
      .align(Alignment.TopStart)
      .layoutWeight(1)
      .cachedCount(50)
      .backgroundColor('rgb(238, 237, 242)')
      .stackFromEnd(true)
      .edgeEffect(EdgeEffect.None)
      .onScrollFrameBegin((offset: number, scrollState: ScrollState) => {
        const currentY = this.scroller.currentOffset().yOffset
        let newY = currentY + offset
        if (newY < 0) newY = 0
        this.notifyAllControllers(newY)
        return { offsetRemain: offset }
      })
      .onScroll((scrollOffset: number, scrollState: ScrollState) => {
        this.notifyAllControllers(this.scroller.currentOffset().yOffset)
      })
      .onTouch((event: TouchEvent) => {
        if (event.type == TouchType.Down) {
          inputMethod.getController().stopInputSession()
        }
      })

      Column({ space: 10 }) {
        Row() {
          TextInput({ text: this.input })
            .fontColor(Color.Black)
            .backgroundColor(Color.White)
            .layoutWeight(1)
            .borderRadius(6)
            .margin({ right: 10 })
            .onChange((value: string) => {
              this.input = value
            })

          Button("发送")
            .height(40)
            .width(60)
            .fontSize(12)
            .fontColor(Color.White)
            .borderRadius(6)
            .backgroundColor('rgb(67, 151, 247)')
            .onClick(() => {
              if (this.input.length === 0) {
                return
              }
              this.messages.push(new Message(new MessageContent(this.input), Who.Me, ''))
              this.controllers.push(new MarkdownScrollController())
              this.itemHeights.push(0)
              this.messages = [...this.messages]
              this.input = ''
              this.scroller.scrollEdge(Edge.Bottom)
            })
        }

        Row() {
          Image($r('app.media.microphones')).width(30).height(30)
          Image($r('app.media.image')).width(30).height(30)
          Image($r('app.media.camera')).width(30).height(30)
          Image($r('app.media.red_gift')).width(30).height(30)
          Image($r('app.media.emotion_happy_line')).width(30).height(30)
          Image($r('app.media.chatview_add_icon')).width(26).height(26)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ bottom: 10 })
      }
      .padding({ left: 10, right: 10, top: 5 })
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
    .width('100%')
    .height('100%')
    .backgroundColor('rgb(242, 241, 247)')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
