package ohos_app_cangjie_markdown_test

import ohos.base.LengthProp
import ohos.component.Column
import ohos.component.Row
import ohos.component.Text
import ohos.component.CustomView
import ohos.component.CJEntry
import ohos.component.loadNativeView
import ohos.component.FontWeight
import ohos.state_manage.SubscriberManager
import ohos.state_manage.ObservedProperty
import ohos.state_manage.LocalStorage
import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.State

@Entry
@Component
class MarkdownView {
    @State
    var message: String = "Hello World"

    func build() {
        Row {
            Column {
                Text(this.message)
                    .fontSize(50)
                    .fontWeight(FontWeight.Bold)
                    .onClick ({
                        evt => this.message = "Hello Cangjie"
                    })
            }.width(100.percent)
        }.height(100.percent)
    }
}
