/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown图片页面
 */
@Component
class MarkdownImageComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 图片节点
     */
    var commonmarkImage: CommonmarkImage

    func build() {
        // TODO ImageSpan缺少String入参，网络图片只能用Image接收
        Column() {
            imageComponent()
        }
        // 设置约束尺寸
        .constraintSize(maxWidth: Length(100, unitType: LengthType.percent))
    }

    /**
     * 图片
     */
    @Builder
    func imageComponent() {
        if (markdownConfiguration.markdownTheme.imageResource.isSome()) {
            Image(commonmarkImage.getDestination())
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置图片解码过程中是否对图源自动缩放
                .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
                // 占位图
                .alt(markdownConfiguration.markdownTheme.imageResource())
                // 图片的点击事件
                .onClick {evt => imageOnClick(commonmarkImage.getDestination(), markdownConfiguration.imageCallback)}
        } else {
            Image(commonmarkImage.getDestination())
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置图片解码过程中是否对图源自动缩放
                .autoResize(markdownConfiguration.markdownTheme.isAutoResize)
                // 图片的点击事件
                .onClick {evt => imageOnClick(commonmarkImage.getDestination(), markdownConfiguration.imageCallback)}
        }
    }
}
