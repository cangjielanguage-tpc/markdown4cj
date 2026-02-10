package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
/**
 * Markdown卡片自定义控件
 */
@Component
public class MarkdownCardComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 卡片节点视图
     */
    var nodeView: NodeView

    /**
     * 卡片名称
     */
    var cardName: String

    /**
     * 卡片数据
     */
    var cardData: String

    protected override func aboutToAppear(): Unit {

    }

    protected override func aboutToDisappear(): Unit {

    }

    func build() {
        Column {
            CardWrapper(
                cardName,
                jsonStr: cardData
            )
        }
    }

}
