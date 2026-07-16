package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

@Component
class TabSelector {
    @Prop
    var title: String
    @Prop
    var options: Array<String>
    @Prop
    var currentValue: String
    var onSelect: (String) -> Unit

    public func build() {
        Column {
            Row {
                Text(title)
                    .fontSize(16.0)
                    .textAlign(TextAlign.Start)
                Text(currentValue)
                    .fontSize(16.0)
                    .textAlign(TextAlign.Start)
                    .margin(left: 5.0)
            }
            .width(100.percent)
            .backgroundColor(0xFF317AFF)
            .padding(top: 5.0, bottom: 5.0, left: 2.0, right: 2.0)
            .margin(2.0)

            Column {
                ForEach(
                    options,
                    itemGeneratorFunc: {
                        item: String, _: Int64 =>
                            Button(item)
                                .shape(ShapeType.Capsule)
                                .height(25.0)
                                .margin(2.0)
                                .backgroundColor(0xFF317AFF)
                                .fontSize(14.0)
                                .fontColor(0xFFFFFFFF)
                                .onClick {
                                    evt => onSelect(item)
                                }
                    }
                )
            }
            .width(100.percent)
            .padding(2.0)
        }
    }
}
