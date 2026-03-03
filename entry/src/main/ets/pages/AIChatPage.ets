/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
import { Message, MessageContent, Who } from '../model/Message';
import { GeneralDataSource } from '../utils/ForLazyRender';
import { HARD_CODE_DATA, LLM } from '../utils/LLM';
import { ChatBlock } from '../component/ChatBlock';
import { CJMarkdownWrap } from '../component/CJMarkdownWrap';
import { MarkdownScroller } from '@cangjie-tpc/markdown_hybrid';
import { inputMethod } from '@kit.IMEKit';
import { titleComponent } from './BaseComponent';
import { MESSAGE_DATA_1,
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
  MESSAGE_DATA_3, MESSAGE_DATA_4,
  MESSAGE_DATA_5,
  MESSAGE_DATA_6, MESSAGE_DATA_7,
  MESSAGE_DATA_8,
  MESSAGE_DATA_9 } from '../model/MessageData';

@Entry
@Component
struct AIChatPage {
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0
  @State input: string = ''
  private messages = new GeneralDataSource<Message>()
  private scrollers: MarkdownScroller[] = []
  private llm = new LLM(
    'https://api.siliconflow.cn/v1/chat/completions',
    'sk-ujrvulmnsdiolckgtjklhqbwbkfudgeglrkxxbzljagbtrnk',
    'deepseek-ai/DeepSeek-V3',
    true
  )
  private scroller: Scroller = new Scroller()
  private currentIndex: number = 0
  private listWidth: number = 0
  private listHeight: number = 0

  aboutToAppear(): void {
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_1), Who.Me, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_2), Who.You, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_3), Who.Me, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_4), Who.You, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_5), Who.Me, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_6), Who.You, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_7), Who.Me, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_8), Who.You, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_9), Who.Me, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_10), Who.You, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_11), Who.Me, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_12), Who.You, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_13), Who.Me, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_14), Who.You, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_15), Who.Me, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_16), Who.You, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_17), Who.Me, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_18), Who.You, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_19), Who.Me, this.now()))
    this.scrollers.push(new MarkdownScroller())
    this.messages.append(new Message(new MessageContent(MESSAGE_DATA_20), Who.You, this.now()))
    this.scrollers.push(new MarkdownScroller())
  }

  onDidBuild(): void {
    for (let i = 0; i < this.messages.totalCount(); i++) {
      const element = this.scrollers[i];
      element.scrollEdge(Edge.Top)
    }
  }

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

  private async doChat(text: string) {
    this.messages.append(new Message(new MessageContent('思考中...'), Who.You, this.now()))
    let element = new MarkdownScroller()
    element.scrollEdge(Edge.Bottom)
    this.scrollers.push(element)
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
  @Builder
  MessageContent(text: string) {
    CJMarkdownWrap({
      input: text,
    })
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
      List({ scroller: this.scroller, initialIndex: this.messages.totalCount() - 1 }) {
        LazyForEach(this.messages, (value: Message, index?: number) => {
          ListItem() {
            ChatBlock({ message: value, scroller: this.scrollers[index || 0] })
          }
        })
      }
      .align(Alignment.TopStart)
      .layoutWeight(1)
      .cachedCount(10)
      .backgroundColor('rgb(238, 237, 242)')
      .stackFromEnd(true)
      .edgeEffect(EdgeEffect.None)
      .onSizeChange((_, value) => {
        this.listWidth = Number(value.width);
        this.listHeight = Number(value.height);
      })
      .onScrollIndex(index => {
          this.currentIndex = index
        }
      )
      .onScrollFrameBegin((offset, state) => {
        if(this.currentIndex % 2 == 0) {
          return { offsetRemain: offset }
        }
        const childOffset = this.scrollers[this.currentIndex]?.currentYOffset() || 0;
        if (offset >= 0) {
          // 上滑
          // 优先分发事件给子组件，当子组件无法下滑时，再分发给父组件
          if (!this.scrollers[this.currentIndex]?.isAtEnd()) {
            // 分发事件给子组件
            this.scrollers[this.currentIndex]?.scrollBy(0, offset);
            // 自身不响应事件
            return { offsetRemain: 0 };
          }

          // 父组件滑动，直到下一个子组件归位
          const rect = this.scroller.getItemRect(this.currentIndex);
          const rectBottom = rect.y + rect.height;
          if (rectBottom < offset) {
            this.currentIndex = Math.min(this.currentIndex + 1, this.scrollers.length - 1);
            this.scrollers[this.currentIndex]?.scrollBy(0, offset - rectBottom);
          }
          return { offsetRemain: Math.min(rectBottom, offset) }
        } else {
          // 下滑
          // 优先分发事件给子组件，当子组件无法下滑时，再分发给父组件
          const rect = this.scroller.getItemRect(this.currentIndex);
          const rectBottom = rect.y + rect.height;
          if (rectBottom < this.listHeight) {
            if (offset < rectBottom - this.listHeight) {
              this.scrollers[this.currentIndex]?.scrollBy(0, offset - rectBottom + this.listHeight);
            }
            return { offsetRemain: Math.max(offset, rectBottom - this.listHeight, -this.listHeight) }
          }

          if (childOffset > 0) {
            // 当当前子组件底部对齐时触发
            // 分发事件给子组件
            this.scrollers[this.currentIndex]?.scrollBy(0, offset);
            // 自身不响应事件
            return { offsetRemain: 0 };
          }

          // 父组件滑动，直到下一个子组件归位
          if (rect.y > offset) {
            this.currentIndex = Math.max(this.currentIndex - 1, 0);
          }
          return { offsetRemain: Math.max(offset, -this.listHeight) }
        }
      })
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
              this.scrollers.push(new MarkdownScroller())
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
        .padding({ bottom: 10})
      }
      .padding({ left: 10, right: 10, top: 5})
      .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
    .width('100%')
    .height('100%')
    .backgroundColor('rgb(242, 241, 247)')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
