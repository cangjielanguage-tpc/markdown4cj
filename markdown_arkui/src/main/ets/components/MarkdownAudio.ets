import { NodeView } from "../model/NodeView"
import { AudioTheme } from "../theme/AudioTheme"

/**
 * 音频控件
 */
@Component
export struct MarkdownAudio {
  @ObjectLink @Watch('refreshData') node: NodeView // 音频自身节点数据
  @ObjectLink audioTheme: AudioTheme // 音频样式
  audioCallback?: (url: string) => void // 音频的点击事件
  @State imageAudioUrl: string = "" // 音频链接
  @State audioTitle: string = "" // 音频标题
  @State audioType: string = "" // 音频类型

  aboutToAppear(): void {
    this.refreshData()
  }

  /**
   * 刷新数据
   */
  refreshData(): void {
    this.imageAudioUrl = this.node.imageUrl ?? "" // 获取音频图片URL
    // 通过分割音频url获取音频类型和标题
    const path = this.imageAudioUrl.split('?')[0].split('#')[0]
    const audioName = path.substring(path.lastIndexOf('/') + 1)
    const dotIdx = audioName.lastIndexOf('.')
    this.audioTitle = dotIdx > 0 ? audioName.substring(0, dotIdx) : audioName
    this.audioType = dotIdx > 0 ? audioName.substring(dotIdx + 1) : ''
  }

  build() {
    Row() {
      Row({ space: 10 }) {
        if (this.audioTheme.audioIcon !== undefined) {
          Image(this.audioTheme.audioIcon)
            .width(this.audioTheme.audioIconWidth)
            .height(this.audioTheme.audioIconHeight)
            .borderRadius({
              topLeft: this.audioTheme.audioIconRadiusTopLeft,
              topRight: this.audioTheme.audioIconRadiusTopRight,
              bottomLeft: this.audioTheme.audioIconRadiusBottomLeft,
              bottomRight: this.audioTheme.audioIconRadiusBottomRight
            })
            .objectFit(this.audioTheme.audioIconFitType)
        } else {
          Blank()
            .width(this.audioTheme.audioIconWidth)
            .height(this.audioTheme.audioIconHeight)
        }
        Column({ space: this.audioTheme.audioTitleToTypeSpacing }) {
          Text(this.audioTitle)
            .fontFamily(this.audioTheme.audioTitleTextFontFamily)
            .fontSize(this.audioTheme.audioTitleTextFontSize)
            .fontWeight(this.audioTheme.audioTitleTextFontWeight)
            .fontStyle(this.audioTheme.audioTitleTextFontStyle)
            .fontColor(this.audioTheme.audioTitleTextFontColor)
            .lineHeight(this.audioTheme.audioTitleTextLineHeight)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Text(this.audioType)
            .fontFamily(this.audioTheme.audioTypeTextFontFamily)
            .fontSize(this.audioTheme.audioTypeTextFontSize)
            .fontWeight(this.audioTheme.audioTypeTextFontWeight)
            .fontStyle(this.audioTheme.audioTypeTextFontStyle)
            .fontColor(this.audioTheme.audioTypeTextFontColor)
            .lineHeight(this.audioTheme.audioTypeTextLineHeight)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(this.audioTheme.audioButtonText)
          .fontFamily(this.audioTheme.audioButtonTextFontFamily)
          .fontSize(this.audioTheme.audioButtonTextFontSize)
          .fontWeight(this.audioTheme.audioButtonTextFontWeight)
          .fontStyle(this.audioTheme.audioButtonTextFontStyle)
          .fontColor(this.audioTheme.audioButtonTextFontColor)
          .lineHeight(this.audioTheme.audioButtonTextLineHeight)
          .width(this.audioTheme.audioButtonWidth)
          .height(this.audioTheme.audioButtonHeight)
          .backgroundColor(this.audioTheme.audioButtonBackgroundColor)
          .borderRadius({
            topLeft: this.audioTheme.audioButtonRadiusTopLeft,
            topRight: this.audioTheme.audioButtonRadiusTopRight,
            bottomLeft: this.audioTheme.audioButtonRadiusBottomLeft,
            bottomRight: this.audioTheme.audioButtonRadiusBottomRight
          })
          .borderWidth(this.audioTheme.audioButtonBorderWidth)
          .borderColor(this.audioTheme.audioButtonBorderColor)
          .borderStyle(this.audioTheme.audioButtonBorderStyle)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .textAlign(TextAlign.Center)
          .align(Alignment.Center)
          .onClick(() => {
            this.audioCallback?.(this.imageAudioUrl)
          })
      }
      .width('100%')
    }
    .backgroundColor(this.audioTheme.audioBackgroundColor)
    .shadow({
      radius: this.audioTheme.audioShadowRadius,
      offsetX: this.audioTheme.audioShadowOffsetX,
      offsetY: this.audioTheme.audioShadowOffsetY,
      color: this.audioTheme.audioShadowColor
    })
    .borderRadius({
      topLeft: this.audioTheme.audioRadiusTopLeft,
      topRight: this.audioTheme.audioRadiusTopRight,
      bottomLeft: this.audioTheme.audioRadiusBottomLeft,
      bottomRight: this.audioTheme.audioRadiusBottomRight
    })
    .borderWidth(this.audioTheme.audioBorderWidth)
    .borderColor(this.audioTheme.audioBorderColor)
    .borderStyle(this.audioTheme.audioBorderStyle)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      top: this.audioTheme.audioPaddingTop,
      right: this.audioTheme.audioPaddingRight,
      bottom: this.audioTheme.audioPaddingBottom,
      left: this.audioTheme.audioPaddingLeft
    })
    .margin({
      top: this.audioTheme.audioMarginTop,
      right: this.audioTheme.audioMarginRight,
      bottom: this.audioTheme.audioMarginBottom,
      left: this.audioTheme.audioMarginLeft
    })
  }
}