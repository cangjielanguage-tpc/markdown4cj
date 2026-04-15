package markdown.components

import ohos.state_macro_manage.*

/**
 * 音频控件
 */
@Component
public class MarkdownAudioComponent {
    var markdownTheme: MarkdownTheme // markdown样式
    var nodeView: NodeView // NodeView
    var audioCallback: ?(String) -> Unit = None // 音频的点击事件
    @State
    var imageAudioUrl: String = "" // 音频链接
    @State
    var audioTitle: String = "" // 音频标题
    @State
    var audioType: String = "" // 音频类型

    protected override func aboutToAppear(): Unit {
        imageAudioUrl = nodeView.imageUrl() // 获取音频图片URL
        // 通过分割音频url获取音频类型和标题
        let titleList = imageAudioUrl.split("/")
        let audioName = titleList[titleList.size - 1]
        let typeList = audioName.split(".")
        audioType = typeList[typeList.size - 1]
        audioTitle = typeList[0]
    }

    func build() {
        Row(10) {
            if (markdownTheme.audioTheme.audioIcon.isSome()) {
                Image(markdownTheme.audioTheme.audioIcon())
                    .width(markdownTheme.audioTheme.audioIconWidth)
                    .height(markdownTheme.audioTheme.audioIconHeight)
                    .borderRadius(topLeft: markdownTheme.audioTheme.audioIconRadiusTopLeft, topRight: markdownTheme.audioTheme.audioIconRadiusTopRight, bottomLeft: markdownTheme.audioTheme.audioIconRadiusBottomLeft, bottomRight: markdownTheme.audioTheme.audioIconRadiusBottomRight)
                    .objectFit(markdownTheme.audioTheme.audioIconFitType)
            } else {
                Blank()
                    .width(markdownTheme.audioTheme.audioIconWidth)
                    .height(markdownTheme.audioTheme.audioIconHeight)
            }
            Column(markdownTheme.audioTheme.audioTitleToTypeSpacing) {
                Text(audioTitle)
                    .fontFamily(markdownTheme.audioTheme.audioTitleTextFontFamily)
                    .fontSize(markdownTheme.audioTheme.audioTitleTextFontSize)
                    .fontWeight(markdownTheme.audioTheme.audioTitleTextFontWeight)
                    .fontStyle(markdownTheme.audioTheme.audioTitleTextFontStyle)
                    .fontColor(markdownTheme.audioTheme.audioTitleTextFontColor)
                    .lineHeight(markdownTheme.audioTheme.audioTitleTextLineHeight)
                    .maxLines(1)
                    .textOverflow(TextOverflow.Ellipsis)
                Text(audioType)
                    .fontFamily(markdownTheme.audioTheme.audioTypeTextFontFamily)
                    .fontSize(markdownTheme.audioTheme.audioTypeTextFontSize)
                    .fontWeight(markdownTheme.audioTheme.audioTypeTextFontWeight)
                    .fontStyle(markdownTheme.audioTheme.audioTypeTextFontStyle)
                    .fontColor(markdownTheme.audioTheme.audioTypeTextFontColor)
                    .lineHeight(markdownTheme.audioTheme.audioTypeTextLineHeight)
                    .maxLines(1)
                    .textOverflow(TextOverflow.Ellipsis)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
            Text(markdownTheme.audioTheme.audioButtonText)
                .fontFamily(markdownTheme.audioTheme.audioButtonTextFontFamily)
                .fontSize(markdownTheme.audioTheme.audioButtonTextFontSize)
                .fontWeight(markdownTheme.audioTheme.audioButtonTextFontWeight)
                .fontStyle(markdownTheme.audioTheme.audioButtonTextFontStyle)
                .fontColor(markdownTheme.audioTheme.audioButtonTextFontColor)
                .lineHeight(markdownTheme.audioTheme.audioButtonTextLineHeight)
                .width(markdownTheme.audioTheme.audioButtonWidth)
                .height(markdownTheme.audioTheme.audioButtonHeight)
                .backgroundColor(markdownTheme.audioTheme.audioButtonBackgroundColor)
                .borderRadius(topLeft: markdownTheme.audioTheme.audioButtonRadiusTopLeft, topRight: markdownTheme.audioTheme.audioButtonRadiusTopRight, bottomLeft: markdownTheme.audioTheme.audioButtonRadiusBottomLeft, bottomRight: markdownTheme.audioTheme.audioButtonRadiusBottomRight)
                .borderWidth(markdownTheme.audioTheme.audioButtonBorderWidth)
                .borderColor(markdownTheme.audioTheme.audioButtonBorderColor)
                .borderStyle(markdownTheme.audioTheme.audioButtonBorderStyle)
                .maxLines(1)
                .textOverflow(TextOverflow.Ellipsis)
                .textAlign(TextAlign.Center)
                .align(Alignment.Center)
                .onClick({
                    event => if (let Some(v) <- audioCallback) {
                        v(imageAudioUrl)
                    }
                })
        }
        .width(100.percent)
        .backgroundColor(markdownTheme.audioTheme.audioBackgroundColor)
        .shadow(radius: markdownTheme.audioTheme.audioShadowRadius, offsetX: markdownTheme.audioTheme.audioShadowOffsetX, offsetY: markdownTheme.audioTheme.audioShadowOffsetY, color: markdownTheme.audioTheme.audioShadowColor)
        .borderRadius(topLeft: markdownTheme.audioTheme.audioRadiusTopLeft, topRight: markdownTheme.audioTheme.audioRadiusTopRight, bottomLeft: markdownTheme.audioTheme.audioRadiusBottomLeft, bottomRight: markdownTheme.audioTheme.audioRadiusBottomRight)
        .borderWidth(markdownTheme.audioTheme.audioBorderWidth)
        .borderColor(markdownTheme.audioTheme.audioBorderColor)
        .borderStyle(markdownTheme.audioTheme.audioBorderStyle)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(
            top: markdownTheme.audioTheme.audioPaddingTop,
            right: markdownTheme.audioTheme.audioPaddingRight,
            bottom: markdownTheme.audioTheme.audioPaddingBottom,
            left: markdownTheme.audioTheme.audioPaddingLeft
        )
    }
}
