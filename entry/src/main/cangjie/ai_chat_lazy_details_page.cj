package ohos_app_cangjie_entry

import ohos.state_macro_manage.*
import ohos.hybrid_base.*

/**
 * AI 聊天懒加载页（对齐 ArkTS AIChatLazyDetailsPage.ets）
 *
 * 使用 LazyForEach + MessageDataSource 懒渲染消息列表。
 * 流式回答通过更新最后一条 Message 并 reload() 触发刷新。
 * 含 reachBottom 智能滚动控制：用户手动上滑时暂停自动滚底。
 */
@HybridComponentEntry
@Component
class AIChatLazyDetailsPage {
    @State
    var input: String = ""
    @State
    var incrementalAnalysis: Bool = false
    var messages: MessageDataSource = MessageDataSource()
    var scroller: Scroller = Scroller()
    var llm: LLM = LLM()
    @State
    var reachBottom: Bool = true
    var chatTouch: Bool = false

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
        for (i in 0..allContent.size) {
            messages.append(Message(allContent[i], allWho[i], ""))
        }
    }

    func now(): String {
        return ""
    }

    func scrollChatIfAtBottom(): Unit {
        if (reachBottom) {
            scroller.scrollEdge(Edge.Bottom)
        }
    }

    func sendMessage(text: String): Unit {
        messages.append(Message(text, Who.Me, now()))
        input = ""
        doChat(text)
    }

    func doChat(text: String): Unit {
        messages.append(Message("思考中...", Who.You, now()))
        llm.chat(text, { slice: String =>
            launch {
                let talking = messages.get(-1)
                if (talking.content == "思考中...") {
                    talking.content = slice
                } else {
                    talking.content = talking.content + slice
                }
                messages.reload()
                scrollChatIfAtBottom()
            }
        }, true)
    }

    public func build() {
        Column {
            List(scroller: scroller, initialIndex: Int32(messages.totalCount() - 1), space: 15) {
                LazyForEach(
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
                    },
                    keyGeneratorFunc: {
                        msg: Message, idx: Int64 => idx.toString()
                    }
                )
            }
            .align(Alignment.TopStart)
            .layoutWeight(1)
            .cachedCount(10)
            .backgroundColor(0xFFEEEDF2)
            .edgeEffect(EdgeEffect.None)
            .onReachEnd {
                => reachBottom = true
            }
            .onScrollFrameBegin({
                offset: Float64, _: ScrollState =>
                    if (offset < -0.5 && chatTouch) {
                        reachBottom = false
                    }
                    offset
            })
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
