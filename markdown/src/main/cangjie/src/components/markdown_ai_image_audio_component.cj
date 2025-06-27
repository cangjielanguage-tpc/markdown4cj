/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

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
                .width(40)
                .height(40)
                .borderRadius(8)
                .objectFit(ImageFit.Cover)

            Column(2) {
                Text('title')
                    .fontSize(15)
                    .lineHeight(20)
                    .fontWeight(FontWeight.Bold)
                    .maxLines(1)
                    .textOverflow(TextOverflow.Ellipsis)
                Row(8) {
                    Text('MP3')
                        .fontSize(11)
                        .lineHeight(15)
                        .fontColor(Color(0x80000000))
                    Text('100KB')
                        .fontSize(11)
                        .lineHeight(15)
                        .fontColor(Color(0x80000000))
                }
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Column() {
                Text('立即播放')
                .fontColor(Color.WHITE)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
            }
            .width(84)
            .height(32)
            .borderRadius(16)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(Color.BLACK)
        }
        .width(100.percent)
        .padding(top: 12, right: 16, bottom: 12, left: 12)
        .border(width: 1.vp, color: Color.BLACK, radius: 12.vp)
        .justifyContent(FlexAlign.SpaceBetween)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
    }
}
