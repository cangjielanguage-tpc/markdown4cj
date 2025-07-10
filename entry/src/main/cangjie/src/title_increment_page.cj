/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.concurrency.*
import markdown.components.*
import std.sync.sleep
import std.time.*
import ohos.hilog.Hilog

/**
 * 标题增量加载
 */
@Entry
@Component
class TitleIncrementPage {
    let mdStr: String = getFileContextStr("title.md")

    @State
    var output: String = ""

    var scroller: Scroller = Scroller()

    func build() {
        Column(){
            Text("点击")
                .onClick(
                    {
                        e => spawn {
                            let arr = mdStr.toRuneArray()
                            for (i in 0..arr.size) {
                                sleep(Duration.millisecond * 50)
                                launch {
                                    output = output + arr[i].toString()
                                    scroller.scrollEdge(Edge.Bottom)
                                }
                            }
                        }
                    }
                )
            Scroll(scroller) {
                Column {
                    MarkdownAIComponent(output: output, isFull: false)
                }
            }
            // 设置滚动方法
            .scrollable(ScrollDirection.Vertical)
        }
    }
}
