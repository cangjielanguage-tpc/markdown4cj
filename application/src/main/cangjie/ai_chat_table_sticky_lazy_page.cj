package ohos_app_cangjie_entry

import ohos.state_macro_manage.*
import ohos.hybrid_base.*
import std.collection.ArrayList

/**
 * AI 聊天表格吸顶懒加载页（对齐 ArkTS AIChatTableStickyLazyPage.ets）
 *
 * 使用 LazyForEach + AIChatBlockSticky 懒渲染。
 * 每个消息分配独立的 MarkdownScrollController，通过 onScrollIndex 追踪可见范围，
 * 仅通知可见区间内的控制器（含 VIS_MARGIN 缓冲），调用 notifyScrollY 实现表格吸顶。
 * 含 LLM 流式回答 + reachBottom 智能滚动控制。
 */
@HybridComponentEntry
@Component
class AIChatTableStickyLazyPage {
    @State
    var input: String = ""
    @State
    var incrementalAnalysis: Bool = false
    var messages: MessageDataSource = MessageDataSource()
    var controllers: ArrayList<MarkdownScrollController> = ArrayList<MarkdownScrollController>()
    var scroller: Scroller = Scroller()
    var llm: LLM = LLM()
    var visibleStart: Int64 = 0
    var visibleEnd: Int64 = 0
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
            controllers.add(MarkdownScrollController())
        }
    }

    func notifyVisibleControllers(offset: Float64): Unit {
        let visMargin: Int64 = 2
        let start = if (visibleStart - visMargin > 0) {
            visibleStart - visMargin
        } else {
            0
        }
        let end = if (visibleEnd + visMargin < controllers.size) {
            visibleEnd + visMargin
        } else {
            controllers.size - 1
        }
        for (i in start..=end) {
            let rect = scroller.getItemRect(Int32(i))
            if (rect.height > 0.0) {
                controllers[i].notifyScrollY(-rect.y + offset)
            }
        }
    }

    func scrollChatIfAtBottom(): Unit {
        if (reachBottom) {
            scroller.scrollEdge(Edge.Bottom)
        }
    }

    func sendMessage(text: String): Unit {
        messages.append(Message(text, Who.Me, ""))
        controllers.add(MarkdownScrollController())
        input = ""
        doChat(text)
    }

    func doChat(text: String): Unit {
        messages.append(Message("思考中...", Who.You, ""))
        controllers.add(MarkdownScrollController())
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
                        msg: Message, index: Int64 =>
                            ListItem() {
                                AIChatBlockSticky(
                                    output: msg.content,
                                    who: msg.who,
                                    incrementalAnalysis: incrementalAnalysis,
                                    scrollController: controllers[index],
                                    tableStickyHeader: true
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
            .onScrollIndex({
                start: Int32, end: Int32 =>
                    visibleStart = Int64(start)
                    visibleEnd = Int64(end)
                    notifyVisibleControllers(0.0)
            })
            .onScrollFrameBegin({
                offset: Float64, _: ScrollState =>
                    if (offset < -0.5 && chatTouch) {
                        reachBottom = false
                    }
                    notifyVisibleControllers(offset)
                    offset
            })
            .onScroll({
                _: Float64, _: ScrollState =>
                    notifyVisibleControllers(0.0)
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
