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
public class MarkdownAIImageAudioComponent {
    /**
     * markdown配置
     */
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 音频链接
     */
    @State
    var imageAudioUrl: String = ""

    /**
     * 上边距 - 单位vp
     */
    var marginTop: Float64

    /**
     * 下边距 - 单位vp
     */
    var marginBottom: Float64

    func build() {
        Row(10) {
            Image('icon')
                // 设置组件自身的宽度
                .width(40)
                // 设置组件自身的高度
                .height(40)
                // 设置圆角
                .borderRadius(8)
                // 设置图片的缩放类型
                .objectFit(ImageFit.Cover)

            Column(2) {
                Text('title')
                    // 设置文本尺寸
                    .fontSize(15)
                    // 设置行高
                    .lineHeight(20)
                    // 设置文本的字体粗细
                    .fontWeight(FontWeight.Bold)
                    // 设置文本的最大行数
                    .maxLines(1)
                    // 设置文本超长时的显示方式
                    .textOverflow(TextOverflow.Ellipsis)
                Row(8) {
                    Text('MP3')
                        // 设置文本尺寸
                        .fontSize(11)
                        // 设置行高
                        .lineHeight(15)
                        // 设置文本颜色
                        .fontColor(Color(0x80000000))
                    Text('100KB')
                        // 设置文本尺寸
                        .fontSize(11)
                        // 设置行高
                        .lineHeight(15)
                        // 设置文本颜色
                        .fontColor(Color(0x80000000))
                }
            }
            // 设置子组件在垂直方向上的对齐格式
            .alignItems(HorizontalAlign.Start)
            // 对子组件进行重新布局
            .layoutWeight(1)

            Column() {
                Text('立即播放')
                    // 设置文本颜色
                    .fontColor(Color.WHITE)
                    // 设置文本尺寸
                    .fontSize(14)
                    // 设置文本的字体粗细
                    .fontWeight(FontWeight.Medium)
            }
            // 设置组件自身的宽度
            .width(84)
            // 设置组件自身的高度
            .height(32)
            // 设置圆角
            .borderRadius(16)
            // 设置子组件在水平方向上的对齐格式
            .justifyContent(FlexAlign.Center)
            // 设置背景色
            .backgroundColor(Color.BLACK)
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置内边距属性
        .padding(top: 12, right: 16, bottom: 12, left: 12)
        // 边框样式设置接口
        .border(width: 1.vp, color: Color.BLACK, radius: 12.vp)
        // 设置子组件在水平方向上的对齐格式
        .justifyContent(FlexAlign.SpaceBetween)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
    }
}
