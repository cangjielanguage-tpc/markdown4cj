/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.concurrency.*
import markdown.components.*

@Entry
@Component
class IndexPage {
    /**
     * 滑动控制器
     */
    var scroller: Scroller = Scroller()

    func build() {
        Column {
            Text("")
                // 高度
                .height(50)
                // 宽度
                .width(100.percent)
                // 背景颜色
                .backgroundColor(0xFF0000)
            Text("Markdown测试用例")
                // 高度
                .height(40)
                // 宽度
                .width(100.percent)
                // 文本颜色
                .fontColor(0xFFFFFF)
                // 背景颜色
                .backgroundColor(0xFF0000)
                // 设置容器元素绘制区域内的子元素的对齐方式
                .align(Alignment.Center)
                // 设置文本段落在水平方向的对齐方式
                .textAlign(TextAlign.Center)
                // 字体大小
                .fontSize(16)
            Scroll(scroller) {
                List() {
                    ListItem() {
                        Row() {
                            Button("1、Markdown全量加载")
                                // 高度
                                .height(40)
                                // 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
                                .layoutWeight(1)
                                // 圆角
                                .shape(ShapeType.Capsule)
                                // 文本颜色
                                .fontColor(0xFFFFFF)
                                // 背景颜色
                                .backgroundColor(0xFF0000)
                                // 外边距
                                .margin(top: 5, bottom: 5, right: 40, left: 40)
                                // 内容对齐方式
                                .align(Alignment.Center)
                                // 字体大小
                                .fontSize(16)
                                // 点击动作触发该方法调用
                                .onClick {Router.push(url: "CompletePage")}
                        }
                    }
                    ListItem() {
                        Row() {
                            Button("2、Markdown增量加载")
                                // 高度
                                .height(40)
                                // 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
                                .layoutWeight(1)
                                // 圆角
                                .shape(ShapeType.Capsule)
                                // 文本颜色
                                .fontColor(0xFFFFFF)
                                // 背景颜色
                                .backgroundColor(0xFF0000)
                                // 外边距
                                .margin(top: 5, bottom: 5, right: 40, left: 40)
                                // 内容对齐方式
                                .align(Alignment.Center)
                                // 字体大小
                                .fontSize(16)
                                // 点击动作触发该方法调用
                                .onClick {Router.push(url: "IncrementPage")}
                        }
                    }
                    ListItem() {
                        Row() {
                            Button("3、单独代码块全量加载")
                                // 高度
                                .height(40)
                                // 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
                                .layoutWeight(1)
                                // 圆角
                                .shape(ShapeType.Capsule)
                                // 文本颜色
                                .fontColor(0xFFFFFF)
                                // 背景颜色
                                .backgroundColor(0xFF0000)
                                // 外边距
                                .margin(top: 5, bottom: 5, right: 40, left: 40)
                                // 内容对齐方式
                                .align(Alignment.Center)
                                // 字体大小
                                .fontSize(16)
                                // 点击动作触发该方法调用
                                .onClick {Router.push(url: "CodeCompletePage")}
                        }
                    }
                    ListItem() {
                        Row() {
                            Button("4、单独代码块增量加载")
                                // 高度
                                .height(40)
                                // 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
                                .layoutWeight(1)
                                // 圆角
                                .shape(ShapeType.Capsule)
                                // 文本颜色
                                .fontColor(0xFFFFFF)
                                // 背景颜色
                                .backgroundColor(0xFF0000)
                                // 外边距
                                .margin(top: 5, bottom: 5, right: 40, left: 40)
                                // 内容对齐方式
                                .align(Alignment.Center)
                                // 字体大小
                                .fontSize(16)
                                // 点击动作触发该方法调用
                                .onClick {Router.push(url: "CodeIncrementPage")}
                        }
                    }
                    ListItem() {
                        Row() {
                            Button("5、定制化设置全量加载")
                                // 高度
                                .height(40)
                                // 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
                                .layoutWeight(1)
                                // 圆角
                                .shape(ShapeType.Capsule)
                                // 文本颜色
                                .fontColor(0xFFFFFF)
                                // 背景颜色
                                .backgroundColor(0xFF0000)
                                // 外边距
                                .margin(top: 5, bottom: 5, right: 40, left: 40)
                                // 内容对齐方式
                                .align(Alignment.Center)
                                // 字体大小
                                .fontSize(16)
                                // 点击动作触发该方法调用
                                .onClick {Router.push(url: "CustomizationCompletePage")}
                        }
                    }
                    ListItem() {
                        Row() {
                            Button("6、定制化设置增量加载")
                                // 高度
                                .height(40)
                                // 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
                                .layoutWeight(1)
                                // 圆角
                                .shape(ShapeType.Capsule)
                                // 文本颜色
                                .fontColor(0xFFFFFF)
                                // 背景颜色
                                .backgroundColor(0xFF0000)
                                // 外边距
                                .margin(top: 5, bottom: 5, right: 40, left: 40)
                                // 内容对齐方式
                                .align(Alignment.Center)
                                // 字体大小
                                .fontSize(16)
                                // 点击动作触发该方法调用
                                .onClick {Router.push(url: "CustomizationIncrementPage")}
                        }
                    }
                    ListItem() {
                        Row() {
                            Button("7、列表嵌套markdown")
                                // 高度
                                .height(40)
                                // 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
                                .layoutWeight(1)
                                // 圆角
                                .shape(ShapeType.Capsule)
                                // 文本颜色
                                .fontColor(0xFFFFFF)
                                // 背景颜色
                                .backgroundColor(0xFF0000)
                                // 外边距
                                .margin(top: 5, bottom: 5, right: 40, left: 40)
                                // 内容对齐方式
                                .align(Alignment.Center)
                                // 字体大小
                                .fontSize(16)
                                // 点击动作触发该方法调用
                                .onClick {Router.push(url: "ListMarkdownPage")}
                        }
                    }
                }
            }
            // 内边距
            .padding(bottom: 100)
            // 设置滚动方法
            .scrollable(ScrollDirection.Vertical)
        }
    }
}
