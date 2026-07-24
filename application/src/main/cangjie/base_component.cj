package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.hybrid_base.*
import markdown.components.*

@Builder
func titleComponent(title: String, titleColor: UInt32, isBack: Bool, safeTop: Float64) {
    Column {
        Text("")
            .height(safeTop)
            .width(100.percent)
        Row {
            if (isBack) {
                Text("‹")
                    .fontSize(24.0)
                    .fontColor(0xFFFFFFFF)
                    .margin(right: 20.0, left: 20.0)
                    .onClick {
                        evt => routerBack()
                    }
            }
            Text(title)
                .height(40.0)
                .layoutWeight(1)
                .fontColor(0xFFFFFFFF)
                .textAlign(TextAlign.Center)
                .fontSize(16.0)
            if (isBack) {
                Text("")
                    .width(20.0)
                    .height(20.0)
                    .margin(right: 20.0, left: 20.0)
            }
        }
    }
    .backgroundColor(titleColor)
}

func routerBack(): Unit {
    callGlobalFunc("routerBack", "")
}
