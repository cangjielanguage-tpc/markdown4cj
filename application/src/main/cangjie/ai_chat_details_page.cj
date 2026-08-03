package ohos_app_cangjie_entry

import ohos.state_macro_manage.*
import ohos.hybrid_base.*

/**
 * AI 聊天全量加载页（对齐 ArkTS AIChatDetailsPage.ets）
 *
 * 使用 ForEach + ObservedArrayList 全量渲染所有消息。
 * 流式回答通过重建列表并 reassign @State 触发刷新（对齐 link_exposure_page 模式）。
 */
@HybridComponentEntry
@Component
class AIChatDetailsPage {
    @State
    var input: String = ""
    @State
    var incrementalAnalysis: Bool = false
    @State
    var messages: ObservedArrayList<Message> = ObservedArrayList<Message>()

    var llm: LLM = LLM()
    var scroller: Scroller = Scroller()

    protected override func aboutToAppear(): Unit {
        incrementalAnalysis = parseBool(getGlobalString("aiChatIncremental"))
        let allContent: Array<String> = [
            MESSAGE_DATA_1, MESSAGE_DATA_2, MESSAGE_DATA_3, MESSAGE_DATA_4,
            MESSAGE_DATA_5, MESSAGE_DATA_6, MESSAGE_DATA_7, MESSAGE_DATA_8,
            MESSAGE_DATA_9, MESSAGE_DATA_10, MESSAGE_DATA_11, MESSAGE_DATA_12,
            MESSAGE_DATA_13, MESSAGE_DATA_14, MESSAGE_DATA_15, MESSAGE_DATA_16,
            MESSAGE_DATA_17, MESSAGE_DATA_18, MESSAGE_DATA_19, MESSAGE_DATA_20
        ]
        let allWho: Array<Who> = [
            Who.Me, Who.You, Who.Me, Who.You,
            Who.Me, Who.You, Who.Me, Who.You,
            Who.Me, Who.You, Who.Me, Who.You,
            Who.Me, Who.You, Who.Me, Who.You,
            Who.Me, Who.You, Who.Me, Who.You
        ]
        let next = ObservedArrayList<Message>()
        for (i in 0..allContent.size) {
            next.append(Message(allContent[i], allWho[i], ""))
        }
        messages = next
    }

    func sendMessage(text: String): Unit {
        let next = ObservedArrayList<Message>()
        for (i in 0..messages.size) {
            next.append(messages[i])
        }
        next.append(Message(text, Who.Me, ""))
        messages = next
        input = ""
        doChat(text)
    }

    func doChat(text: String): Unit {
        let next = ObservedArrayList<Message>()
        for (i in 0..messages.size) {
            next.append(messages[i])
        }
        next.append(Message("思考中...", Who.You, ""))
        messages = next
        let lastIndex = messages.size - 1
        llm.chat(text, { slice: String =>
            launch {
                let updated = ObservedArrayList<Message>()
                for (i in 0..messages.size) {
                    if (i == lastIndex) {
                        if (messages[i].content == "思考中...") {
                            updated.append(Message(slice, Who.You, ""))
                        } else {
                            updated.append(Message(messages[i].content + slice, Who.You, ""))
                        }
                    } else {
                        updated.append(messages[i])
                    }
                }
                messages = updated
                scroller.scrollEdge(Edge.Bottom)
            }
        }, true)
    }

    public func build() {
        Column {
            List(scroller: scroller, space: 15) {
                ForEach(
                    messages,
                    itemGeneratorFunc: {
                        msg: Message, _: Int64 =>
                            ListItem() {
                                AIChatBlock(
                                    output: msg.content,
                                    who: msg.who,
                                    incrementalAnalysis: incrementalAnalysis
                                )
                            }
                    }
                )
            }
            .align(Alignment.TopStart)
            .layoutWeight(1)
            .cachedCount(10)
            .backgroundColor(0xFFEEEDF2)
            .edgeEffect(EdgeEffect.None)
            .onTouch { evt =>
                ()
            }

            Column {
                Row {
                    TextInput(text: input)
                        .fontColor(0xFF000000)
                        .backgroundColor(0xFFFFFFFF)
                        .layoutWeight(1)
                        .borderRadius(6.0)
                        .margin(right: 10.0)
                        .onChange { value =>
                            input = value
                        }

                    Button("发送")
                        .height(40.0)
                        .width(60.0)
                        .fontSize(12.0)
                        .fontColor(0xFFFFFFFF)
                        .borderRadius(6.0)
                        .backgroundColor(0xFF4397F7)
                        .onClick { evt =>
                            if (input.size == 0) {
                                return
                            }
                            sendMessage(input)
                        }
                }

                Row {
                    Text("🎤").width(30.0).height(30.0).textAlign(TextAlign.Center)
                    Text("🖼").width(30.0).height(30.0).textAlign(TextAlign.Center)
                    Text("📷").width(30.0).height(30.0).textAlign(TextAlign.Center)
                    Text("🎁").width(30.0).height(30.0).textAlign(TextAlign.Center)
                    Text("😊").width(30.0).height(30.0).textAlign(TextAlign.Center)
                    Text("➕").width(26.0).height(26.0).textAlign(TextAlign.Center)
                }
                .width(100.percent)
                .alignItems(VerticalAlign.Center)
                .justifyContent(FlexAlign.SpaceBetween)
                .padding(bottom: 10.0)
            }
            .padding(left: 10.0, right: 10.0, top: 5.0)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xFFF2F1F7)
    }
}
