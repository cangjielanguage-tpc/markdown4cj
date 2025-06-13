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
class Index {
    func build() {
        Scroll() {
            Column {
                List() {
                    ListItem() {
                        Row() {
                            Text("")
                                // 宽度
                                .width(40)
                            Button("1、全量数据")
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
                                .margin(top: 5, bottom: 5)
                                // 内容对齐方式
                                .align(Alignment.Center)
                                // 字体大小
                                .fontSize(16)
                                // 点击动作触发该方法调用
                                .onClick {Router.push(url: "All")}
                            Text("")
                                // 宽度
                                .width(40)
                        }
                    }
                    ListItem() {
                        Row() {
                            Text("")
                                // 宽度
                                .width(40)
                            Button("2、单独代码块")
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
                                .margin(top: 5, bottom: 5)
                                // 内容对齐方式
                                .align(Alignment.Center)
                                // 字体大小
                                .fontSize(16)
                                // 点击动作触发该方法调用
                                .onClick {Router.push(url: "CodeBlock")}
                            Text("")
                                // 宽度
                                .width(40)
                        }
                    }
                    ListItem() {
                        Row() {
                            Text("")
                                // 宽度
                                .width(40)
                            Button("3、数学公式")
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
                                .margin(top: 5, bottom: 5)
                                // 内容对齐方式
                                .align(Alignment.Center)
                                // 字体大小
                                .fontSize(16)
                                // 点击动作触发该方法调用
                                .onClick {Router.push(url: "Latex")}
                            Text("")
                                // 宽度
                                .width(40)
                        }
                    }
                    ListItem() {
                        Row() {
                            Text("")
                                // 宽度
                                .width(40)
                            Button("4、表格")
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
                                .margin(top: 5, bottom: 5)
                                // 内容对齐方式
                                .align(Alignment.Center)
                                // 字体大小
                                .fontSize(16)
                                // 点击动作触发该方法调用
                                .onClick {Router.push(url: "Table")}
                            Text("")
                                // 宽度
                                .width(40)
                        }
                    }
                    ListItem() {
                        Row() {
                            Text("")
                                // 宽度
                                .width(40)
                            Button("5、标题")
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
                                .margin(top: 5, bottom: 5)
                                // 内容对齐方式
                                .align(Alignment.Center)
                                // 字体大小
                                .fontSize(16)
                                // 点击动作触发该方法调用
                                .onClick {Router.push(url: "TitlePage")}
                            Text("")
                                // 宽度
                                .width(40)
                        }
                    }
                }
                // 设置List组件排列方向
                .listDirection(Axis.Vertical)
                // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
                .alignListItem(ListItemAlign.Start)
                // 设置组件自身的宽度
                .width(100.percent)
                // 设置滚动条状态
                .scrollBar(BarState.Off)
            }
        }
        // 设置滚动方法
        .scrollable(ScrollDirection.Vertical)
    }
}
