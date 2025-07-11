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
    func build() {
        Scroll() {
            Column {
                List() {
                    ListItem() {
                        Row() {
                            Text("")
                                // 宽度
                                .width(40)
                            Button("1、全量数据全量加载")
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
                                .onClick {Router.push(url: "AllCompletePage")}
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
                            Button("2、全量数据增量加载")
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
                                .onClick {Router.push(url: "AllIncrementPage")}
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
                            Button("3、超大代码块全量加载")
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
                                .onClick {Router.push(url: "BigCodeBlockCompletePage")}
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
                            Button("4、超大代码块增量加载")
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
                                .onClick {Router.push(url: "BigCodeBlockIncrementPage")}
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
                            Button("5、小代码块全量加载")
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
                                .onClick {Router.push(url: "CodeBlockCompletePage")}
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
                            Button("6、小代码块增量加载")
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
                                .onClick {Router.push(url: "CodeBlockIncrementPage")}
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
                            Button("7、小代码块全量加载1")
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
                                .onClick {Router.push(url: "CodeBlock1CompletePage")}
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
                            Button("8、小代码块增量加载1")
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
                                .onClick {Router.push(url: "CodeBlock1IncrementPage")}
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
                            Button("9、小代码块全量加载2")
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
                                .onClick {Router.push(url: "CodeBlock2CompletePage")}
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
                            Button("10、小代码块增量加载2")
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
                                .onClick {Router.push(url: "CodeBlock2IncrementPage")}
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
                            Button("11、小代码块全量加载3")
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
                                .onClick {Router.push(url: "CodeBlock3CompletePage")}
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
                            Button("12、小代码块增量加载3")
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
                                .onClick {Router.push(url: "CodeBlock3IncrementPage")}
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
                            Button("13、小代码块全量加载4")
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
                                .onClick {Router.push(url: "CodeBlock4CompletePage")}
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
                            Button("14、小代码块增量加载4")
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
                                .onClick {Router.push(url: "CodeBlock4IncrementPage")}
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
                            Button("15、数学公式全量加载")
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
                                .onClick {Router.push(url: "LatexCompletePage")}
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
                            Button("16、数学公式增量加载")
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
                                .onClick {Router.push(url: "LatexIncrementPage")}
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
                            Button("17、表格全量加载")
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
                                .onClick {Router.push(url: "TableCompletePage")}
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
                            Button("18、表格增量加载")
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
                                .onClick {Router.push(url: "TableIncrementPage")}
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
                            Button("19、标题全量加载")
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
                                .onClick {Router.push(url: "TitleCompletePage")}
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
                            Button("20、标题增量加载")
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
                                .onClick {Router.push(url: "TitleIncrementPage")}
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
                            Button("21、音频视频全量加载")
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
                                .onClick {Router.push(url: "AudioAndVideoCompletePage")}
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
                            Button("22、音频视频增量加载")
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
                                .onClick {Router.push(url: "AudioAndVideoIncrementPage")}
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
                            Button("23、音频视频全量加载1")
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
                                .onClick {Router.push(url: "AudioAndVideo1CompletePage")}
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
                            Button("24、音频视频增量加载1")
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
                                .onClick {Router.push(url: "AudioAndVideo1IncrementPage")}
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
                            Button("25、音频视频全量加载2")
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
                                .onClick {Router.push(url: "AudioAndVideo2CompletePage")}
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
                            Button("26、音频视频增量加载2")
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
                                .onClick {Router.push(url: "AudioAndVideo2IncrementPage")}
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
                            Button("27、音频视频全量加载3")
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
                                .onClick {Router.push(url: "AudioAndVideo3CompletePage")}
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
                            Button("28、音频视频增量加载3")
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
                                .onClick {Router.push(url: "AudioAndVideo3IncrementPage")}
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
                            Button("29、音频视频全量加载4")
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
                                .onClick {Router.push(url: "AudioAndVideo4CompletePage")}
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
                            Button("30、音频视频增量加载4")
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
                                .onClick {Router.push(url: "AudioAndVideo4IncrementPage")}
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
                            Button("31、超大数据全量加载")
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
                                .onClick {Router.push(url: "BigDataCompletePage")}
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
                            Button("32、超大数据增量加载")
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
                                .onClick {Router.push(url: "BigDataIncrementPage")}
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
                            Button("33、列表嵌套markdown")
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
                                .onClick {Router.push(url: "MDListPage")}
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
                            Button("34、bug数据1全量加载")
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
                                .onClick {Router.push(url: "Bug1CompletePage")}
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
                            Button("35、bug数据1增量加载")
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
                                .onClick {Router.push(url: "Bug1IncrementPage")}
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
