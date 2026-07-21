package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.hybrid_base.*
import markdown.components.*
import ohos.concurrency.launch

@HybridComponentEntry
@Component
class SwitchDataPage {
    @State
    var arr: Array<Rune> = Array<Rune>()
    var scroller: Scroller = Scroller()
    @State
    var markdownConfiguration: MarkdownConfiguration = MarkdownConfiguration.createEmpty()

    protected override func aboutToAppear(): Unit {
        markdownConfiguration.setMarkdownTheme(MarkdownTheme.createDefault())
    }
    var mdStr: String = getGlobalString("markdownContent")

    public func build() {
        Column {
            Scroll {
                Column {
                    MarkdownComponent(
                        output: mdStr,
                        isInputEnded: true,
                        incrementalAnalysis: false,
                        scroller: scroller,
                        markdownConfiguration: markdownConfiguration
                    )
                }
            }
            .scrollable(ScrollDirection.Vertical)
            .align(Alignment.Top)
            .layoutWeight(1)
        }
        .width(100.percent)
        .height(100.percent)
        .justifyContent(FlexAlign.Start)
    }
}
