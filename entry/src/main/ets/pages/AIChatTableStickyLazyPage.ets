/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
import { Message, MessageContent, Who } from '../model/Message'
import { GeneralDataSource } from '../utils/ForLazyRender'
import { LLM } from '../utils/LLM'
import { AIChatLazyBlockSticky } from '../component/AIChatLazyBlockSticky'
import { MarkdownScrollController } from '@cangjie-tpc/markdown_hybrid'
import { inputMethod } from '@kit.IMEKit'
import { titleComponent } from '../component/BaseComponent'
import {
  MESSAGE_DATA_1, MESSAGE_DATA_2, MESSAGE_DATA_3, MESSAGE_DATA_4,
  MESSAGE_DATA_5, MESSAGE_DATA_6, MESSAGE_DATA_7, MESSAGE_DATA_8,
  MESSAGE_DATA_9, MESSAGE_DATA_10, MESSAGE_DATA_11, MESSAGE_DATA_12,
  MESSAGE_DATA_13, MESSAGE_DATA_14, MESSAGE_DATA_15, MESSAGE_DATA_16,
  MESSAGE_DATA_17, MESSAGE_DATA_18, MESSAGE_DATA_19, MESSAGE_DATA_20
} from '../model/MessageData'

const VIS_MARGIN: number = 2
const LIST_SPACE: number = 15

@Entry
@Component
struct AIChatTableStickyLazyPage {
  @StorageProp('safeTop') safeTop: number = 0
  @State input: string = ''
  @State incrementalAnalysis: boolean = false

  private messages = new GeneralDataSource<Message>()
  private controllers: Array<MarkdownScrollController> = []
  private scroller: Scroller = new Scroller()
  private llm = new LLM(
    'https://api.siliconflow.cn/v1/chat/completions',
    'sk-ujrvulmnsdiolckgtjklhqbwbkfudgeglrkxxbzljagbtrnk',
    'deepseek-ai/DeepSeek-V3',
    true
  )

  private visibleStart: number = 0
  private visibleEnd: number = 0
  @State reachBottom: boolean = true
  private chatTouch: boolean = false

  aboutToAppear(): void {
    const allData: Array<[string, Who]> = [
      [MESSAGE_DATA_1, Who.Me], [MESSAGE_DATA_2, Who.You],
      [MESSAGE_DATA_3, Who.Me], [MESSAGE_DATA_4, Who.You],
      [MESSAGE_DATA_5, Who.Me], [MESSAGE_DATA_6, Who.You],
      [MESSAGE_DATA_7, Who.Me], [MESSAGE_DATA_8, Who.You],
      [MESSAGE_DATA_9, Who.Me], [MESSAGE_DATA_10, Who.You],
      [MESSAGE_DATA_11, Who.Me], [MESSAGE_DATA_12, Who.You],
      [MESSAGE_DATA_13, Who.Me], [MESSAGE_DATA_14, Who.You],
      [MESSAGE_DATA_15, Who.Me], [MESSAGE_DATA_16, Who.You],
      [MESSAGE_DATA_17, Who.Me], [MESSAGE_DATA_18, Who.You],
      [MESSAGE_DATA_19, Who.Me], [MESSAGE_DATA_20, Who.You]
    ]
    for (let i = 0; i < allData.length; i++) {
      this.messages.append(new Message(new MessageContent(allData[i][0]), allData[i][1], this.now()))
      this.controllers.push(new MarkdownScrollController())
    }
  }

  private notifyVisibleControllers(offset: number): void {
    const start = Math.max(0, this.visibleStart - VIS_MARGIN)
    const end = Math.min(this.controllers.length - 1, this.visibleEnd + VIS_MARGIN)
    for (let i = start; i <= end; i++) {
      const rect = this.scroller.getItemRect(i)
      if (rect.height > 0) {
        this.controllers[i].notifyScrollY(-rect.y + offset)
      }
    }
  }

  build() {
    Column() {
      titleComponent("仓宝 - 表格吸顶懒加载", 0xFF317AFF, true, this.safeTop)

      List({ scroller: this.scroller, initialIndex: this.messages.totalCount() - 1, space: LIST_SPACE }) {
        LazyForEach(this.messages, (value: Message, index: number) => {
          ListItem() {
            AIChatLazyBlockSticky({
              message: value,
              incrementalAnalysis: this.incrementalAnalysis,
              scrollController: this.controllers[index],
              tableStickyHeader: true
            })
          }
          .onAreaChange((oldValue: Area, newValue: Area) => {
            this.notifyVisibleControllers(0)
          })
        }, (value: Message, index: number) => index.toString())
      }
      .align(Alignment.TopStart)
      .layoutWeight(1)
      .cachedCount(10)
      .backgroundColor('rgb(238, 237, 242)')
      .stackFromEnd(true)
      .edgeEffect(EdgeEffect.None)
      .onReachEnd(() => {
        this.reachBottom = true
      })
      .onScrollIndex((start: number, end: number) => {
        this.visibleStart = start
        this.visibleEnd = end
        this.notifyVisibleControllers(0)
      })
      .onScrollFrameBegin((offset: number, scrollState: ScrollState) => {
        if (offset < -0.5 && this.chatTouch) {
          this.reachBottom = false
        }
        this.notifyVisibleControllers(offset)
        return { offsetRemain: offset }
      })
      .onScroll((scrollOffset: number, scrollState: ScrollState) => {
        this.notifyVisibleControllers(0)
      })
      .onTouch((event: TouchEvent) => {
        switch (event.type) {
          case TouchType.Down:
            this.chatTouch = true
            break
          case TouchType.Up:
            this.chatTouch = false
            break
        }
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
              this.messages.append(new Message(new MessageContent(this.input), Who.Me, this.now()))
              this.controllers.push(new MarkdownScrollController())
              this.doChat(this.input)
              this.input = ''
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

  private scrollChatIfAtBottom() {
    if (this.reachBottom) {
      this.scroller.scrollEdge(Edge.Bottom)
    }
  }

  private now() {
    return new Intl.DateTimeFormat('zh-CN', {
      year: 'numeric', month: '2-digit', day: '2-digit',
      hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false
    }).format(new Date()).replace(/\//g, '-')
  }

  private async doChat(text: string) {
    this.messages.append(new Message(new MessageContent('思考中...'), Who.You, this.now()))
    this.controllers.push(new MarkdownScrollController())
    this.llm.chat(text, (slice: string) => {
      const talking = this.messages.get(-1)
      if (talking.content.content == '思考中...') {
        talking.content = new MessageContent(slice)
      } else {
        talking.content = new MessageContent(talking.content.content + slice)
      }
      this.messages.reload()
      this.scrollChatIfAtBottom()
    }, true).then(() => {
      this.scrollChatIfAtBottom()
    })
  }
}
