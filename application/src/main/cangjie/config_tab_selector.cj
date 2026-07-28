package ohos_app_cangjie_entry

import ohos.state_macro_manage.*

func isColorValue(s: String): Bool {
    return s == "#FF000000" || s == "#FFFFFFFF" || s == "#FFFF0000" ||
           s == "#FF00FF00" || s == "#FF0000FF" || s == "#FF808080" ||
           s == "#FFFA8072" || s == "#FFFFD700" || s == "#FFEE82EE" ||
           s == "#FF7EC0EE" || s == "#00000000"
}

func colorToUInt32(s: String): UInt32 {
    match (s) {
        case "#FF000000" => 0xFF000000
        case "#FFFFFFFF" => 0xFFFFFFFF
        case "#FFFF0000" => 0xFFFF0000
        case "#FF00FF00" => 0xFF00FF00
        case "#FF0000FF" => 0xFF0000FF
        case "#FF808080" => 0xFF808080
        case "#FFFA8072" => 0xFFFA8072
        case "#FFFFD700" => 0xFFFFD700
        case "#FFEE82EE" => 0xFFEE82EE
        case "#FF7EC0EE" => 0xFF7EC0EE
        case "#00000000" => 0xFFCCCCCC
        case _ => 0xFF317AFF
    }
}

func contrastColor(s: String): UInt32 {
    match (s) {
        case "#FF000000" => 0xFFFFFFFF
        case "#FF808080" => 0xFFFFFFFF
        case "#FF0000FF" => 0xFFFFFFFF
        case "#FFFF0000" => 0xFFFFFFFF
        case "#FFFA8072" => 0xFF000000
        case "#FFFFD700" => 0xFF000000
        case "#FFEE82EE" => 0xFF000000
        case "#FF7EC0EE" => 0xFF000000
        case "#FFFFFFFF" => 0xFF000000
        case "#FF00FF00" => 0xFF000000
        case "#00000000" => 0xFF000000
        case _ => 0xFFFFFFFF
    }
}

func colorDisplayName(s: String): String {
    match (s) {
        case "#FF000000" => "黑"
        case "#FFFFFFFF" => "白"
        case "#FFFF0000" => "红"
        case "#FF00FF00" => "绿"
        case "#FF0000FF" => "蓝"
        case "#FF808080" => "灰"
        case "#FFFA8072" => "肉粉"
        case "#FFFFD700" => "金"
        case "#FFEE82EE" => "紫罗兰"
        case "#FF7EC0EE" => "天空蓝"
        case "#00000000" => "透明"
        case _ => s
    }
}

/**
 * 配置选项卡组件
 * 使用 Flex+Wrap 实现自动换行的按钮布局（参考 BaseTabComponent）
 * 颜色选项自动显示为色块（背景=颜色值，文字=中文名称+对比色）
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
    @Prop
    var currentValue: String
    var onSelect: ?(String) -> Unit = None

    public func build() {
        Column {
            Row {
                Text(title)
                    .fontSize(16.0)
                    .textAlign(TextAlign.Start)
                    .layoutWeight(1)
                Text(
                    if (isColorValue(currentValue)) {
                        colorDisplayName(currentValue)
                    } else {
                        currentValue
                    }
                )
                    .fontSize(16.0)
                    .textAlign(TextAlign.End)
                    .margin(right: 5.0)
                    .backgroundColor(
                        if (isColorValue(currentValue)) {
                            colorToUInt32(currentValue)
                        } else {
                            0xFFE0E0E0
                        }
                    )
                    .fontColor(
                        if (isColorValue(currentValue)) {
                            contrastColor(currentValue)
                        } else {
                            0xFF000000
                        }
                    )
                    .padding(2.0)
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
                            Button(if (isColorValue(item)) { colorDisplayName(item) } else { item })
                                .shape(ShapeType.Capsule)
                                .height(25.0)
                                .margin(2.0)
                                .backgroundColor(if (isColorValue(item)) { colorToUInt32(item) } else { 0xFF317AFF })
                                .fontSize(14.0)
                                .fontColor(if (isColorValue(item)) { contrastColor(item) } else { 0xFFFFFFFF })
                                .onClick {evt =>
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
