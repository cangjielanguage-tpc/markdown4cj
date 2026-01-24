/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 图片下载按钮
 */
@Component
public class MarkdownImageDownloadComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 图片链接
     */
    var destination: String

    /**
     * markdown配置
     */
    var markdownTheme: MarkdownTheme = MarkdownTheme.emptyBuilder().build()

    protected override func aboutToAppear(): Unit {
        markdownTheme = markdownConfiguration.markdownTheme
    }

    func build() {
         Row(7) {
            if (markdownTheme.imageDownloadImage.isSome()) {
                Image(markdownTheme.imageDownloadImage())
                    .width(markdownTheme.imageDownloadImageWidthHeight)
                    .height(markdownTheme.imageDownloadImageWidthHeight)
                    .fillColor(markdownTheme.imageDownloadTexColor)
            }
            Text(markdownTheme.imageDownloadText)
                .fontSize(markdownTheme.imageDownloadTexSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(markdownTheme.imageDownloadTexColor)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .width(markdownTheme.imageDownloadWidth)
        .height(markdownTheme.imageDownloadHeight)
        .borderRadius(markdownTheme.imageDownloadRadius)
        .backgroundColor(markdownTheme.imageDownloadBackgroundColor)
        .margin(top: 14)
        .onClick {evt =>
            if (markdownConfiguration.imageDownloadCallback.isSome()) {
                markdownConfiguration.imageDownloadCallback()(destination)
            }
        }
    }
}