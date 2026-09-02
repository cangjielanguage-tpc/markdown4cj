import { getIcon, Message } from "../model/Message"
import { CJMarkdownWrapSticky } from "./CJMarkdownWrapSticky"
import { MarkdownScrollController } from '@cangjie-tpc/markdown_arkui'

const SIZE: number = 36
const MARGIN: number = SIZE * 2 + 25

@Component
export struct AIChatBlockSticky {
  @Prop
  message: Message
  @State
  incrementalAnalysis: boolean = false
  scrollController?: MarkdownScrollController = undefined
  tableStickyHeader: boolean = false

  build() {
    if (this.message.who === 'Me') {
      Column({ space: 3 }) {
        Row() {
          this.MessageContent(0x4c96ff, 0xffffff)
        }
        .justifyContent(FlexAlign.End)
        .alignItems(VerticalAlign.Top)
        .width('100%')
      }
      .width('100%')
      .padding({ left: 10, right: 10 })
    } else {
      Column({ space: 3 }) {
        Row() {
          this.MessageContent(0xffffff, 0x000000)
        }
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Top)
        .width('100%')
      }
      .width('100%')
      .padding({ left: 10, right: 10 })
    }
  }

  @Builder
  MessageContent(bgColor: number, fontColor: number) {
    Column() {
      if (this.isText()) {
        Text(this.message.content.content)
          .fontColor(fontColor)
          .fontSize(15)
      } else {
        CJMarkdownWrapSticky({
          input: this.message.content.content,
          incrementalAnalysis: this.incrementalAnalysis,
          scrollController: this.scrollController,
          tableStickyHeader: this.tableStickyHeader
        })
      }
    }
    .constraintSize({ maxWidth: '75%' })
    .padding({
      left: 10,
      right: 10,
      top: this.isText() ? 10 : 1,
      bottom: this.isText() ? 10 : 0
    })
    .backgroundColor(bgColor)
    .borderRadius(10)
  }

  @Builder
  Avatar() {
    Image(getIcon(this.message.who))
      .width(SIZE)
      .height(SIZE)
      .borderRadius(SIZE / 2)
  }

  isText(): boolean {
    return this.message.content.content.length <= 60
  }
}
