/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
import { Message, MessageContent, Who } from '../model/Message'
import { GeneralDataSource } from '../utils/ForLazyRender'
import { LLM } from '../utils/LLM'
// import { MarkdownScroller } from '@cangjie-tpc/markdown_arkui'
import { inputMethod } from '@kit.IMEKit'
import { titleComponent } from '../component/BaseComponent'
import {
  MESSAGE_DATA_1,
  MESSAGE_DATA_10,
  MESSAGE_DATA_11,
  MESSAGE_DATA_12,
  MESSAGE_DATA_13,
  MESSAGE_DATA_14,
  MESSAGE_DATA_15,
  MESSAGE_DATA_16,
  MESSAGE_DATA_17,
  MESSAGE_DATA_18,
  MESSAGE_DATA_19,
  MESSAGE_DATA_2,
  MESSAGE_DATA_20,
  MESSAGE_DATA_3,
  MESSAGE_DATA_4,
  MESSAGE_DATA_5,
  MESSAGE_DATA_6,
  MESSAGE_DATA_7,
  MESSAGE_DATA_8,
  MESSAGE_DATA_9
} from '../model/MessageData'
import { AIChatBlock } from '../component/AIChatBlock'

@Entry
@Component
struct AIChatDetailsPage {
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0
  /**
   * 输入内容
   */
  @State input: string = ''
  /**
   * markdown是否增量解析(true:增量解析,false:全量解析)
   */
  @State
  incrementalAnalysis: boolean = false
  /**
   * 消息对象列表
   */
  private messages = new GeneralDataSource<Message>()
  // /**
  //  * 滑动控制器列表
  //  */
  // private markdownScrollerArray: MarkdownScroller[] = []
  /**
   * LLM
   */
  private llm = new LLM(
    'https://api.siliconflow.cn/v1/chat/completions',
    'sk-ujrvulmnsdiolckgtjklhqbwbkfudgeglrkxxbzljagbtrnk',
    'deepseek-ai/DeepSeek-V3',
    true
  )
  /**
   * Scroller
   */
  private scroller: Scroller = new Scroller()

  aboutToAppear(): void {
    // 数据添加
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_1), Who.Me, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_2), Who.You, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_3), Who.Me, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_4), Who.You, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_5), Who.Me, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_6), Who.You, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_7), Who.Me, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_8), Who.You, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_9), Who.Me, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_10), Who.You, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_11), Who.Me, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_12), Who.You, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_13), Who.Me, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_14), Who.You, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_15), Who.Me, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_16), Who.You, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_17), Who.Me, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_18), Who.You, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_19), Who.Me, this.now()))
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_20), Who.You, this.now()))
  }

  build() {
    Column() {
      // 顶部标题
      titleComponent(
        "仓宝",
        0xFF317AFF,
        true,
        this.safeTop
      )

      // 聊天消息区
      List({ scroller: this.scroller, initialIndex: this.messages.totalCount() - 1, space: 15 }) {
        LazyForEach(this.messages, (value: Message, index: number) => {
          ListItem() {
            AIChatBlock({
              message: value,
              // scroller: this.markdownScrollerArray[index],
              incrementalAnalysis: this.incrementalAnalysis
            })
          }
        })
      }
      .align(Alignment.TopStart)
      .layoutWeight(1)
      .cachedCount(10)
      .backgroundColor('rgb(238, 237, 242)')
      .stackFromEnd(true)
      .edgeEffect(EdgeEffect.None)
      .onTouch((event: TouchEvent) => {
        if (event.type == TouchType.Down) {
          inputMethod.getController().stopInputSession()
        }
      })

      // 输入区
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
              // this.markdownScrollerArray.push(new MarkdownScroller())
              this.doChat(this.input)
              this.input = ''
            })
        }

        // 底部控制栏
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

  /**
   * 获取当前时间
   */
  private now() {
    return new Intl.DateTimeFormat('zh-CN', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
      hour12: false
    }).format(new Date()).replace(/\//g, '-')
  }

  /**
   * AI流式回答
   */
  private async doChat(text: string) {
    this.messages.append(new Message(new MessageContent('思考中...'), Who.You, this.now()))
    // let element = new MarkdownScroller()
    // element.scrollEdge(Edge.Bottom)
    // this.markdownScrollerArray.push(element)
    this.llm.chat(text, (slice: string) => {
      const talking = this.messages.get(-1)
      if (talking.content.content == '思考中...') {
        talking.content = new MessageContent(slice)
      } else {
        talking.content = new MessageContent(talking.content.content + slice)
      }
      this.messages.reload()
    }, true).then(() => {
      this.scroller.scrollEdge(Edge.Bottom)
    })
  }
}
