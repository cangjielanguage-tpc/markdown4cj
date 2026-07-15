package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.hybrid_base.*
import markdown.components.*

@HybridComponentEntry
@Component
class AudioDetailsPage {
    @State
    var mdStr: String = getGlobalString("markdownContent")

    public func build() {
        Column {
            Scroll {
                Column {
                    MarkdownComponent(
                        output: mdStr,
                        isInputEnded: true,
                        incrementalAnalysis: false,
                        scroller: Scroller()
                    )
                }
            }
            .scrollable(ScrollDirection.Vertical)
            .layoutWeight(1)
        }
    }
}
