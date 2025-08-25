/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 音频
 */
@Component
public class MarkdownImageAudioComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 音频内容
     */
    var nodeView: NodeView

    /**
     * 上边距 - 单位vp
     */
    var marginTop: Float64

    /**
     * 下边距 - 单位vp
     */
    var marginBottom: Float64

    /**
     * 音频链接
     */
    @State
    var imageAudioUrl: String = ""

    /**
     * 音频标题
     */
    @State
    var audioTitle: String = ""

    /**
     * 音频类型
     */
    @State
    var audioType: String = ""

    protected override func aboutToAppear(): Unit {
        let nodeViews: ArrayList<NodeView> = nodeView.children
        for (node in nodeViews) {
            if (node.node is CommonmarkImage) {
                imageAudioUrl = (node.node as CommonmarkImage)().getDestination()
                let titleList = imageAudioUrl.split("/")
                let audioName = titleList[titleList.size - 1]
                let typeList = audioName.split(".")
                audioType = typeList[typeList.size - 1]
                audioTitle = typeList[0]
            }
        }
    }

    func build() {
        Row(10) {
            if (markdownConfiguration.markdownTheme.audioIcon.isSome()) {
                Image(markdownConfiguration.markdownTheme.audioIcon())
                    // 设置组件自身的宽度
                    .width(40)
                    // 设置组件自身的高度
                    .height(40)
                    // 设置圆角
                    .borderRadius(8)
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Cover)
            } else {
                Text("")
                    // 设置组件自身的宽度
                    .width(40)
                    // 设置组件自身的高度
                    .height(40)
            }

            Column(2) {
                Text(audioTitle)
                    // 设置文本尺寸
                    .fontSize(markdownConfiguration.markdownTheme.audioTitleTextSize)
                    // 设置行高
                    .lineHeight(markdownConfiguration.markdownTheme.audioTitleTextLineHeight)
                    // 设置文本的字体粗细
                    .fontWeight(FontWeight.Bold)
                    // 设置文本的最大行数
                    .maxLines(1)
                    // 设置文本超长时的显示方式
                    .textOverflow(TextOverflow.Ellipsis)
                    // 设置文本颜色
                    .fontColor(markdownConfiguration.markdownTheme.audioTitleTextColor)
                Row(8) {
                    Text(audioType)
                        // 设置文本尺寸
                        .fontSize(markdownConfiguration.markdownTheme.audioTypeTextSize)
                        // 设置行高
                        .lineHeight(markdownConfiguration.markdownTheme.audioTypeTextLineHeight)
                        // 设置文本颜色
                        .fontColor(markdownConfiguration.markdownTheme.audioTypeTextColor)
                }
            }
            // 设置子组件在垂直方向上的对齐格式
            .alignItems(HorizontalAlign.Start)
            // 对子组件进行重新布局
            .layoutWeight(1)

            Column() {
                Text(markdownConfiguration.markdownTheme.audioButtonText)
                    // 设置文本颜色
                    .fontColor(markdownConfiguration.markdownTheme.audioButtonTextColor)
                    // 设置文本尺寸
                    .fontSize(markdownConfiguration.markdownTheme.audioButtonTextSize)
                    // 设置文本的字体粗细
                    .fontWeight(FontWeight.Medium)
                    // 内边距
                    .padding(right: 3, left: 3)
                    // 设置文本的最大行数
                    .maxLines(1)
                    // 设置文本超长时的显示方式
                    .textOverflow(TextOverflow.Ellipsis)
                    // 组件被点击时触发的事件
                    .onClick({
                        event => if (let Some(v) <- markdownConfiguration.audioCallback) {
                            v(imageAudioUrl)
                        }
                    })
            }
            // 设置组件自身的宽度
            .width(84)
            // 设置组件自身的高度
            .height(32)
            // 设置圆角
            .borderRadius(markdownConfiguration.markdownTheme.audioButtonBorderRadius)
            // 设置子组件在水平方向上的对齐格式
            .justifyContent(FlexAlign.Center)
            // 设置背景色
            .backgroundColor(markdownConfiguration.markdownTheme.audioButtonBackgroundColor)
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置内边距属性
        .padding(top: 12, right: 16, bottom: 12, left: 12)
        // 为组件添加阴影效果。
        .shadow(radius:markdownConfiguration.markdownTheme.audioBorderRadius, offsetX: 0.0, offsetY: 2.0, color: markdownConfiguration.markdownTheme.audioShadowColor)
        // 边框样式设置接口
        .border(width: markdownConfiguration.markdownTheme.audioBorderWidth.vp, color: markdownConfiguration.markdownTheme.audioBorderColor, radius: markdownConfiguration.markdownTheme.audioBorderRadius.vp)
        // 设置子组件在水平方向上的对齐格式
        .justifyContent(FlexAlign.SpaceBetween)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
    }
}
