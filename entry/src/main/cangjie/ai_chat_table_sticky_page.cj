package ohos_app_cangjie_entry

import ohos.state_macro_manage.*
import ohos.hybrid_base.*
import std.collection.ArrayList

/**
 * AI 聊天表格吸顶全量加载页（对齐 ArkTS AIChatTableStickyPage.ets）
 *
 * 使用 ForEach + AIChatBlockSticky 全量渲染。
 * 每个消息分配独立的 MarkdownScrollController，通过 getItemRect 计算各 item
 * 相对视口顶部的偏移，调用 notifyScrollY 实现表格表头随外层滚动吸顶。
 * messages 用 ObservedArrayList + reassign 触发 @State 刷新。
 */
@HybridComponentEntry
@Component
class AIChatTableStickyPage {
    @State
    var input: String = ""
    @State
    var messages: ObservedArrayList<Message> = ObservedArrayList<Message>()
    var controllers: ArrayList<MarkdownScrollController> = ArrayList<MarkdownScrollController>()
    var scroller: Scroller = Scroller()

    protected override func aboutToAppear(): Unit {
        let allContent: Array<String> = [
            MESSAGE_DATA_1, MESSAGE_DATA_2, MESSAGE_DATA_3, MESSAGE_DATA_4,
            MESSAGE_DATA_7, MESSAGE_DATA_8, MESSAGE_DATA_9, MESSAGE_DATA_10
        ]
        let allWho: Array<Who> = [
            Who.Me, Who.You, Who.Me, Who.You,
            Who.Me, Who.You, Who.Me, Who.You
        ]
        let next = ObservedArrayList<Message>()
        for (i in 0..allContent.size) {
            next.append(Message(allContent[i], allWho[i], ""))
            controllers.add(MarkdownScrollController())
        }
        messages = next
    }

    func notifyAllControllers(offset: Float64): Unit {
        for (i in 0..controllers.size) {
            let rect = scroller.getItemRect(Int32(i))
            if (rect.height > 0.0) {
                controllers[i].notifyScrollY(-rect.y + offset)
            }
        }
    }

    func sendMessage(text: String): Unit {
        let next = ObservedArrayList<Message>()
        for (i in 0..messages.size) {
            next.append(messages[i])
        }
        next.append(Message(text, Who.Me, ""))
        controllers.add(MarkdownScrollController())
        messages = next
        input = ""
        scroller.scrollEdge(Edge.Bottom)
    }

    public func build() {
        Column {
            List(scroller: scroller, space: 15) {
                ForEach(
                    messages,
                    itemGeneratorFunc: {
                        msg: Message, index: Int64 =>
                            ListItem() {
                                AIChatBlockSticky(
                                    output: msg.content,
                                    who: msg.who,
                                    incrementalAnalysis: false,
                                    scrollController: controllers[Int64(index)],
                                    tableStickyHeader: true
                                )
                            }
                    }
                )
            }
            .align(Alignment.TopStart)
            .layoutWeight(1)
            .cachedCount(50)
            .backgroundColor(0xFFEEEDF2)
            .edgeEffect(EdgeEffect.None)
            .onScrollFrameBegin({
                offset: Float64, _: ScrollState =>
                    notifyAllControllers(offset)
                    offset
            })
            .onScroll({
                _: Float64, _: ScrollState =>
                    notifyAllControllers(0.0)
            })

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
