package markdown.components

import ohos.state_macro_manage.*

/**
 * 图片下载按钮
 */
@Component
public class MarkdownImageDownloadComponent {
    var markdownTheme: MarkdownTheme // markdown配置
    var destination: String // 图片链接
    var imageDownloadCallback: ?(String) -> Unit // 图片下载的点击事件

    func build() {
         Row(markdownTheme.imageTheme.imageDownloadButtonIconTextGap) {
            if (markdownTheme.imageTheme.imageDownloadButtonIcon.isSome()) {
                Image(markdownTheme.imageTheme.imageDownloadButtonIcon())
                    .width(markdownTheme.imageTheme.imageDownloadButtonIconWidth)
                    .height(markdownTheme.imageTheme.imageDownloadButtonIconHeight)
                    .fillColor(markdownTheme.imageTheme.imageDownloadButtonTextFontColor)
            }
            Text(markdownTheme.imageTheme.imageDownloadButtonText)
                .fontFamily(markdownTheme.imageTheme.imageDownloadButtonTextFontFamily)
                .fontSize(markdownTheme.imageTheme.imageDownloadButtonTextFontSize)
                .fontWeight(markdownTheme.imageTheme.imageDownloadButtonTextFontWeight)
                .fontStyle(markdownTheme.imageTheme.imageDownloadButtonTextFontStyle)
                .fontColor(markdownTheme.imageTheme.imageDownloadButtonTextFontColor)
                .lineHeight(markdownTheme.imageTheme.imageDownloadButtonTextLineHeight)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .width(markdownTheme.imageTheme.imageDownloadButtonWidth)
        .height(markdownTheme.imageTheme.imageDownloadButtonHeight)
        .borderRadius(topLeft: markdownTheme.imageTheme.imageDownloadButtonRadiusTopLeft, topRight: markdownTheme.imageTheme.imageDownloadButtonRadiusTopRight, bottomLeft: markdownTheme.imageTheme.imageDownloadButtonRadiusBottomLeft, bottomRight: markdownTheme.imageTheme.imageDownloadButtonRadiusBottomRight)
        .backgroundColor(markdownTheme.imageTheme.imageDownloadButtonBackgroundColor)
        .margin(top: markdownTheme.imageTheme.imageBottomLayoutMarginTop)
        .onClick {evt =>
            if (imageDownloadCallback.isSome()) {
                imageDownloadCallback()(destination)
            }
        }
    }
}