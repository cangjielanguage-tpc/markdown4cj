package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import markdown.components.*

/**
 * 配置选项卡组件
 * 使用 Flex+Wrap 实现自动换行的按钮布局（参考 BaseTabComponent）
 *
 * 数据传递支持两种模式：
 *   1. 新模式（推荐）：通过 onSelect 回调将选中值回传父组件，不走 globalThis 互操作
 *   2. 兼容模式：通过 configKey + setGlobalString 走 globalThis（旧页面逐步迁移）
 *
 * 同时传入时优先使用 onSelect 回调。
 */
@Component
class ConfigTabSelector {
    @Prop
    var title: String
    @Prop
    var options: Array<String>
    @Prop
    var defaultValue: String
    @Prop
    var configKey: String
    var onSelect: ?(String) -> Unit = None
    @State
    var currentValue: String = ""

    public func build() {
        Column {
            Row {
                Text(title)
                    .fontSize(16.0)
                    .textAlign(TextAlign.Start)
                    .layoutWeight(1)
                Text(if (currentValue == "") { defaultValue } else { currentValue })
                    .fontSize(16.0)
                    .textAlign(TextAlign.End)
                    .margin(right: 5.0)
            }
            .width(100.percent)
            .backgroundColor(0xFFE0E0E0)
            .padding(top: 5.0, bottom: 5.0, left: 2.0, right: 2.0)
            .margin(2.0)

            Flex(FlexOptions(direction: FlexDirection.Row, wrap: FlexWrap.Wrap, alignItems: ItemAlign.Start)) {
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
                                .onClick {evt =>
                                    currentValue = item
                                    if (let Some(cb) <- onSelect) {
                                        cb(item)
                                    } else if (configKey != "") {
                                        setGlobalString(configKey, item)
                                    }
                                }
                    }
                )
            }
            .width(100.percent)
            .backgroundColor(0xFFFFFFFF)
            .padding(2.0)
        }
    }
}
