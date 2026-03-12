/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 音频控件
 */
@Component
public class MarkdownAudioComponent {
    /**
     * markdown样式
     */
    var markdownTheme: MarkdownTheme

    /**
     * NodeView
     */
    var nodeView: NodeView

    /**
     * 音频的点击事件
     */
    var audioCallback: ?(String) -> Unit = None

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
        // 获取音频图片URL
        imageAudioUrl = nodeView.imageUrl()
        // 通过分割音频url获取音频类型和标题
        let titleList = imageAudioUrl.split("/")
        let audioName = titleList[titleList.size - 1]
        let typeList = audioName.split(".")
        audioType = typeList[typeList.size - 1]
        audioTitle = typeList[0]
    }

    func build() {
        Row(10) {
            if (markdownTheme.audioIcon.isSome()) {
                Image(markdownTheme.audioIcon())
                    .width(40)
                    .height(40)
                    .borderRadius(8)
                    .objectFit(ImageFit.Cover)
            } else {
                Text("")
                    .width(40)
                    .height(40)
            }
            Column(2) {
                Text(audioTitle)
                    .fontSize(markdownTheme.audioTitleTextSize)
                    .lineHeight(markdownTheme.audioTitleTextLineHeight)
                    .fontWeight(FontWeight.Bold)
                    .maxLines(1)
                    .textOverflow(TextOverflow.Ellipsis)
                    .fontColor(markdownTheme.audioTitleTextColor)
                Row(8) {
                    Text(audioType)
                        .fontSize(markdownTheme.audioTypeTextSize)
                        .lineHeight(markdownTheme.audioTypeTextLineHeight)
                        .fontColor(markdownTheme.audioTypeTextColor)
                }
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
            Column() {
                Text(markdownTheme.audioButtonText)
                    .fontColor(markdownTheme.audioButtonTextColor)
                    .fontSize(markdownTheme.audioButtonTextSize)
                    .fontWeight(FontWeight.Medium)
                    .padding(right: 3, left: 3)
                    .maxLines(1)
                    .textOverflow(TextOverflow.Ellipsis)
                    .onClick({
                        event => if (let Some(v) <- audioCallback) {
                            v(imageAudioUrl)
                        }
                    })
            }
            .width(84)
            .height(32)
            .borderRadius(markdownTheme.audioButtonBorderRadius)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(markdownTheme.audioButtonBackgroundColor)
        }
        .width(100.percent)
        .padding(top: 12, right: 16, bottom: 12, left: 12)
        .shadow(radius: markdownTheme.audioBorderRadius, offsetX: 0.0, offsetY: 2.0, color: markdownTheme.audioShadowColor)
        .border(width: markdownTheme.audioBorderWidth.vp, color: markdownTheme.audioBorderColor, radius: markdownTheme.audioBorderRadius.vp)
        .justifyContent(FlexAlign.SpaceBetween)
    }
}
