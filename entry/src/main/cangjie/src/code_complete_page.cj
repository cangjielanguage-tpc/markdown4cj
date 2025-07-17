/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.concurrency.*
import markdown.components.*
import std.sync.*
import std.time.*
import ohos.hilog.*

/**
 * 全量加载
 */
@Entry
@Component
class CodeCompletePage {
    /**
     * markdown文本内容
     */
    @State
    var mdStr: String = ""

    /**
     * 滑动控制器
     */
    var scroller: Scroller = Scroller()

    /**
     * rawfile文件夹列表
     */
    @State
    var folderList: ObservedArrayList<String> = ObservedArrayList<String>()

    protected override func aboutToAppear(): Unit {
        let arr1: Array<String> = getFileListStr("")
        Hilog.error(1,"1","------------arr1")

        let arr: Array<String> = getFileListStr("002_单独代码块测试用例/")
        Hilog.error(1,"1","------------arr")
        folderList.appendAll(arr)
    }

    func build() {
        Column {
            Text("全量加载")
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
                    ForEach(
                        folderList,
                        itemGeneratorFunc: {
                            str: String, index: Int64 => ListItem() {
                                Row() {
                                    Button("${index+1}、${str}")
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
                                        .onClick {Router.push(url: "CodeCompleteDetailsPage", params: "002_单独代码块测试用例/${str}")}
                                }
                            }
                        },
                        keyGeneratorFunc: {
                            str: String, index: Int64 => return "${str} - ${index}"
                        }
                    )
                }
            }
            // 设置容器元素绘制区域内的子元素的对齐方式。
            .align(Alignment.TopStart)
            // 高度
            .height(100.percent)
            // 外边距
            .margin(bottom: 40)
            // 设置滚动方法
            .scrollable(ScrollDirection.Vertical)
        }
    }
}
