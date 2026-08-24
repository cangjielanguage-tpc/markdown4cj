import { NodeView } from "../model/NodeView"
import { VideoTheme } from "../theme/VideoTheme"
import { formatDurationToTime } from "../utils/MarkdownUtils"

/**
 * 视频控件
 */
@Component
export struct MarkdownVideo {
  @ObjectLink @Watch('refreshData') node: NodeView // 视频自身节点数据
  @ObjectLink videoTheme: VideoTheme // 视频样式
  videoCallback?: (url: string) => void // 视频点击事件
  videoImageCallback?: (url: string, callback: (url: string, ratio: number, time: number) => void) => void // 视频的图片替换回调
  videoReleaseCallback?: (url: string) => void // 视频发布的点击事件
  videoDownloadCallback?: (url: string) => void // 视频下载点击事件
  @State imageVideoUrl: string = "" // 视频链接
  @State imageUrl: string = "" // 回调得到的图片
  @State videoRatio: number = 16.0 / 9.0 // 图片宽高比
  @State time: string = "" // 视频时长
  private isAlive: boolean = false // 组件是否存活
  private refreshVersion: number = 0 // 刷新版本号，防止过期回调

  aboutToAppear(): void {
    this.isAlive = true
    this.refreshData()
  }

  aboutToDisappear(): void {
    this.isAlive = false
  }

  /**
   * 刷新数据
   */
  refreshData(): void {
    this.refreshVersion++
    const currentVersion = this.refreshVersion
    this.imageVideoUrl = this.node.imageUrl ?? ""
    this.imageUrl = ""
    this.videoRatio = 16.0 / 9.0
    this.time = ""
    try {
      this.videoImageCallback?.(this.imageVideoUrl, (url: string, ratio: number, time: number) => {
        if (!this.isAlive || currentVersion !== this.refreshVersion) {
          return
        }
        this.imageUrl = url
        if (ratio > 0) {
          this.videoRatio = ratio
        }
        this.time = formatDurationToTime(time)
      })
    } catch (e) {
      console.error('MarkdownVideo refreshData error: ' + JSON.stringify(e))
    }
  }

  build() {
    Row() {
      Column() {
        Stack({ alignContent: Alignment.BottomEnd }) {
          Stack({ alignContent: Alignment.Center }) {
            this.imgVideoComponent()
          }

          Text(this.time)
            .fontFamily(this.videoTheme.videoTimeTextFontFamily)
            .fontSize(this.videoTheme.videoTimeTextFontSize)
            .fontWeight(this.videoTheme.videoTimeTextFontWeight)
            .fontStyle(this.videoTheme.videoTimeTextFontStyle)
            .fontColor(this.videoTheme.videoTimeTextFontColor)
            .lineHeight(this.videoTheme.videoTimeTextLineHeight)
            .margin({
              right: this.videoTheme.videoTimeTextMarginRight,
              bottom: this.videoTheme.videoTimeTextMarginBottom
            })
        }
        .onClick(() => {
          this.videoCallback?.(this.imageVideoUrl)
        })

        if (this.videoTheme.videoBottomLayoutVisible) {
          this.imgVideoButtonComponent()
        }
      }
      .layoutWeight(1)
    }
    .backgroundColor(this.videoTheme.videoBackgroundColor)
    .padding({
      top: this.videoTheme.videoPaddingTop,
      right: this.videoTheme.videoPaddingRight,
      bottom: this.videoTheme.videoPaddingBottom,
      left: this.videoTheme.videoPaddingLeft
    })
    .margin({
      top: this.videoTheme.videoMarginTop,
      right: this.videoTheme.videoMarginRight,
      bottom: this.videoTheme.videoMarginBottom,
      left: this.videoTheme.videoMarginLeft
    })
  }

  /**
   * 视频图片
   */
  @Builder
  imgVideoComponent() {
    if (this.imageUrl === "") {
      if (this.videoTheme.videoPlaceholder !== undefined) {
        Image(this.videoTheme.videoPlaceholder)
          .width('100%')
          .aspectRatio(this.videoRatio > 0 ? this.videoRatio : 16.0 / 9.0)
          .objectFit(this.videoTheme.videoImageFitType)
          .borderRadius({
            topLeft: this.videoTheme.videoRadiusTopLeft,
            topRight: this.videoTheme.videoRadiusTopRight,
            bottomLeft: this.videoTheme.videoRadiusBottomLeft,
            bottomRight: this.videoTheme.videoRadiusBottomRight
          })
          .borderWidth(this.videoTheme.videoBorderWidth)
          .borderColor(this.videoTheme.videoBorderColor)
          .borderStyle(this.videoTheme.videoBorderStyle)
      }
    } else {
      Image(this.imageUrl)
        .width('100%')
        .aspectRatio(this.videoRatio > 0 ? this.videoRatio : 16.0 / 9.0)
        .objectFit(this.videoTheme.videoImageFitType)
        .borderRadius({
          topLeft: this.videoTheme.videoRadiusTopLeft,
          topRight: this.videoTheme.videoRadiusTopRight,
          bottomLeft: this.videoTheme.videoRadiusBottomLeft,
          bottomRight: this.videoTheme.videoRadiusBottomRight
        })
        .borderWidth(this.videoTheme.videoBorderWidth)
        .borderColor(this.videoTheme.videoBorderColor)
        .borderStyle(this.videoTheme.videoBorderStyle)
    }

    if (this.videoTheme.videoPlayIcon !== undefined) {
      Image(this.videoTheme.videoPlayIcon)
        .width(this.videoTheme.videoPlayIconWidth)
        .height(this.videoTheme.videoPlayIconHeight)
        .objectFit(this.videoTheme.videoPlayIconFitType)
    }
  }

  /**
   * 视频发布下载按钮布局
   */
  @Builder
  imgVideoButtonComponent() {
    Row({ space: 8 }) {
      if (this.videoTheme.videoReleaseButtonVisible) {
        Row({ space: this.videoTheme.videoReleaseButtonIconTextGap }) {
          if (this.videoTheme.videoReleaseButtonIcon !== undefined) {
            Image(this.videoTheme.videoReleaseButtonIcon)
              .width(this.videoTheme.videoReleaseButtonIconWidth)
              .height(this.videoTheme.videoReleaseButtonIconHeight)
              .fillColor(this.videoTheme.videoReleaseButtonTextFontColor)
          }
          Text(this.videoTheme.videoReleaseButtonText)
            .fontFamily(this.videoTheme.videoReleaseButtonTextFontFamily)
            .fontSize(this.videoTheme.videoReleaseButtonTextFontSize)
            .fontWeight(this.videoTheme.videoReleaseButtonTextFontWeight)
            .fontStyle(this.videoTheme.videoReleaseButtonTextFontStyle)
            .fontColor(this.videoTheme.videoReleaseButtonTextFontColor)
            .lineHeight(this.videoTheme.videoReleaseButtonTextLineHeight)
        }
        .width(this.videoTheme.videoReleaseButtonWidth)
        .height(this.videoTheme.videoReleaseButtonHeight)
        .borderRadius({
          topLeft: this.videoTheme.videoReleaseButtonRadiusTopLeft,
          topRight: this.videoTheme.videoReleaseButtonRadiusTopRight,
          bottomLeft: this.videoTheme.videoReleaseButtonRadiusBottomLeft,
          bottomRight: this.videoTheme.videoReleaseButtonRadiusBottomRight
        })
        .backgroundColor(this.videoTheme.videoReleaseButtonBackgroundColor)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.videoReleaseCallback?.(this.imageVideoUrl)
        })
      }
      if (this.videoTheme.videoDownloadButtonVisible) {
        Row({ space: this.videoTheme.videoDownloadButtonIconTextGap }) {
          if (this.videoTheme.videoDownloadButtonIcon !== undefined) {
            Image(this.videoTheme.videoDownloadButtonIcon)
              .width(this.videoTheme.videoDownloadButtonIconWidth)
              .height(this.videoTheme.videoDownloadButtonIconHeight)
              .fillColor(this.videoTheme.videoDownloadButtonTextFontColor)
          }
          Text(this.videoTheme.videoDownloadButtonText)
            .fontFamily(this.videoTheme.videoDownloadButtonTextFontFamily)
            .fontSize(this.videoTheme.videoDownloadButtonTextFontSize)
            .fontWeight(this.videoTheme.videoDownloadButtonTextFontWeight)
            .fontStyle(this.videoTheme.videoDownloadButtonTextFontStyle)
            .fontColor(this.videoTheme.videoDownloadButtonTextFontColor)
            .lineHeight(this.videoTheme.videoDownloadButtonTextLineHeight)
        }
        .width(this.videoTheme.videoDownloadButtonWidth)
        .height(this.videoTheme.videoDownloadButtonHeight)
        .borderRadius({
          topLeft: this.videoTheme.videoDownloadButtonRadiusTopLeft,
          topRight: this.videoTheme.videoDownloadButtonRadiusTopRight,
          bottomLeft: this.videoTheme.videoDownloadButtonRadiusBottomLeft,
          bottomRight: this.videoTheme.videoDownloadButtonRadiusBottomRight
        })
        .backgroundColor(this.videoTheme.videoDownloadButtonBackgroundColor)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.videoDownloadCallback?.(this.imageVideoUrl)
        })
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .margin({ top: this.videoTheme.videoBottomLayoutMarginTop })
  }
}