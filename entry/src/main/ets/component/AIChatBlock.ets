/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
import { getIcon, Message } from "../model/Message"
import { CJMarkdownWrap } from "./CJMarkdownWrap"
// import { MarkdownScroller } from '@cangjie-tpc/markdown_hybrid'

const SIZE: number = 36
const MARGIN: number = SIZE * 2 + 25

@Component
export struct AIChatBlock {
  /**
   * 消息文本对象
   */
  @Prop
  message: Message
  /**
   * markdown是否增量解析(true:增量解析,false:全量解析)
   */
  @State
  incrementalAnalysis: boolean = false
  // /**
  //  * Markdown的控制器
  //  */
  // scroller?: MarkdownScroller = undefined

  build() {
    if (this.message.who === 'Me') {
      Column({ space: 3 }) {
        // 时间戳
        // Row() {
        //   Text(this.message.time)
        //     .fontSize(12)
        // }
        // .width('100%')
        // .justifyContent(FlexAlign.End)
        // .margin({ right: MARGIN })

        // 消息气泡
        Row() {
          this.MessageContent(0x4c96ff, 0xffffff)
          // Row()
          //   .width(10)
          // this.Avatar()
        }
        .justifyContent(FlexAlign.End)
        .alignItems(VerticalAlign.Top)
        .width('100%')
      }
      .width('100%')
      .padding({ left: 10, right: 10 })
    } else {
      Column({ space: 3 }) {
        // 时间戳
        // Row() {
        //   Text(this.message.time)
        //     .fontSize(12)
        // }
        // .width('100%')
        // .justifyContent(FlexAlign.Start)
        // .margin({ left: MARGIN })

        // 消息气泡
        Row() {
          // this.Avatar()
          // Row()
          //   .width(10)
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
        CJMarkdownWrap({
          input: this.message.content.content,
          // scroller: this.markdownScroller,
          incrementalAnalysis: this.incrementalAnalysis
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

  /**
   * 头像
   */
  @Builder
  Avatar() {
    Image(getIcon(this.message.who))
      .width(SIZE)
      .height(SIZE)
      .borderRadius(SIZE / 2)
  }

  /**
   * 文本小于60个字符使用普通文本显示
   */
  isText(): boolean {
    return this.message.content.content.length <= 60
  }
}
