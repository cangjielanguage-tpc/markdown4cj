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
 * 定制化全量加载
 */
@Entry
@Component
class BigCompletePage {
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
        let arr: Array<String> = getFileListStr("006_超大数据/")
        folderList.appendAll(arr)
    }

    func build() {
        Column {
            titleComponent(
                "全量加载",
                true
            )
            Scroll(scroller) {
                List() {
                    ForEach(
                        folderList,
                        itemGeneratorFunc: {
                            str: String, index: Int64 => ListItem() {
                                itemListComponent(
                                    "${index+1}、${str}",
                                    "BigCompleteDetailsPage",
                                    "006_超大数据/${str}"
                                )
                            }
                        },
                        keyGeneratorFunc: {
                            str: String, index: Int64 => return "${str} - ${index}"
                        }
                    )
                }
                // 设置ListItem在List交叉轴方向的布局方式
                .alignListItem(ListItemAlign.Center)
            }
            // 设置容器元素绘制区域内的子元素的对齐方式。
            .align(Alignment.TopStart)
            // 高度
            .height(100.percent)
            // 内边距
            .padding(bottom: 100)
            // 设置滚动方法
            .scrollable(ScrollDirection.Vertical)
        }
    }
}
