import { image } from "@kit.ImageKit"
import { NodeView } from "../model/NodeView"
import { ImageTheme } from "../theme/ImageTheme"
import {
  imageUrlHandle, imageWidthAndHeight
} from "../utils/MarkdownUtils"

/**
 * 块级图片控件
 *
 * 当段落/标题仅含单张图片且isImageMixedLayout=false时使用。
 * 以块级Image（非ImageSpan）渲染，支持：
 * - onComplete自动计算宽高
 * - 图片替换回调（imageReplaceCallback）：宿主拦截URL返回原始字节，转为PixelMap渲染
 * - 下载按钮（imageDownloadButtonVisible=true时显示）
 */
@Component
export struct MarkdownImageBlock {
  @Consume placeholderPixelMap: PixelMap | undefined // 图片占位图
  @ObjectLink @Watch('refreshData') item: NodeView // 图片节点数据
  @ObjectLink imageTheme: ImageTheme // 图片样式
  @Prop componentWidth: number = 0.0 // 父布局控件宽度
  imageCallback?: (url: string) => void // 图片点击事件
  imageDownloadCallback?: (url: string) => void // 图片下载点击事件
  imageReplaceCallback?: (url: string) => Promise<ArrayBuffer | undefined> // 图片替换回调
  @State replacePixelMap: PixelMap | undefined = undefined // 替换后的PixelMap
  private isAlive: boolean = false // 组件是否存活
  private replaceToken: number = 0 // 替换请求令牌（防stale回调覆盖新数据）

  aboutToAppear(): void {
    this.isAlive = true
    this.tryReplaceImage()
  }

  /**
   * 刷新数据
   */
  refreshData(): void {
    if (this.replacePixelMap !== undefined) {
      try {
        this.replacePixelMap.release()
      } catch (e) {
        console.error('ImageBlock replacePixelMap release failed: ' + JSON.stringify(e))
      }
      this.replacePixelMap = undefined
    }
    this.tryReplaceImage()
  }

  aboutToDisappear(): void {
    this.isAlive = false
    if (this.replacePixelMap !== undefined) {
      try {
        this.replacePixelMap.release()
      } catch (e) {
        console.error('ImageBlock replacePixelMap release failed: ' + JSON.stringify(e))
      }
      this.replacePixelMap = undefined
    }
  }

  build() {
    Column() {
      if (this.replacePixelMap !== undefined) {
        Image(this.replacePixelMap)
          .alt(this.placeholderPixelMap)
          .margin({
            top: this.imageTheme.imageMarginTop,
            right: this.imageTheme.imageMarginRight,
            bottom: this.imageTheme.imageMarginBottom,
            left: this.imageTheme.imageMarginLeft
          })
          .borderRadius({
            topLeft: this.item.imageRadius ?? this.imageTheme.imageRadiusTopLeft,
            topRight: this.item.imageRadius ?? this.imageTheme.imageRadiusTopRight,
            bottomLeft: this.item.imageRadius ?? this.imageTheme.imageRadiusBottomLeft,
            bottomRight: this.item.imageRadius ?? this.imageTheme.imageRadiusBottomRight
          })
          .borderWidth(this.imageTheme.imageBorderWidth)
          .borderColor(this.imageTheme.imageBorderColor)
          .borderStyle(this.imageTheme.imageBorderStyle)
          .width(this.item.imageWidth ?? (this.componentWidth > 0 ? this.componentWidth * this.imageTheme.imageMaximumWidth : undefined))
          .height(this.item.imageHeight)
          .objectFit(this.imageTheme.imageFitType)
          .constraintSize({
            maxWidth: this.imageTheme.imageMaxWidth ?? '100%',
            maxHeight: this.imageTheme.imageMaxHeight
          })
          .onClick(() => {
            this.imageCallback?.(this.item.imageUrl ?? "")
          })
          .onComplete((imageLoadResult) => {
            if (imageLoadResult !== undefined && imageLoadResult !== null) {
              const l = imageWidthAndHeight(
                this.componentWidth,
                imageLoadResult.width,
                imageLoadResult.height,
                (this.item.imageStyleWidth !== undefined ? vp2px(this.item.imageStyleWidth) : undefined) ??
                (this.imageTheme.imageWidth !== undefined ? vp2px(this.imageTheme.imageWidth) : undefined),
                (this.item.imageStyleHeight !== undefined ? vp2px(this.item.imageStyleHeight) : undefined) ??
                (this.imageTheme.imageHeight !== undefined ? vp2px(this.imageTheme.imageHeight) : undefined),
                this.imageTheme.imageMaxWidth,
                this.imageTheme.imageMaxHeight,
                this.imageTheme.imageFixedRatioWidth,
                this.imageTheme.imageMaximumWidth
              )
              this.item.imageWidth = px2vp(l[0])
              this.item.imageHeight = px2vp(l[1])
            }
          })
      } else {
        Image(imageUrlHandle(this.item.imageUrl))
          .alt(this.placeholderPixelMap)
          .margin({
            top: this.imageTheme.imageMarginTop,
            right: this.imageTheme.imageMarginRight,
            bottom: this.imageTheme.imageMarginBottom,
            left: this.imageTheme.imageMarginLeft
          })
          .borderRadius({
            topLeft: this.item.imageRadius ?? this.imageTheme.imageRadiusTopLeft,
            topRight: this.item.imageRadius ?? this.imageTheme.imageRadiusTopRight,
            bottomLeft: this.item.imageRadius ?? this.imageTheme.imageRadiusBottomLeft,
            bottomRight: this.item.imageRadius ?? this.imageTheme.imageRadiusBottomRight
          })
          .borderWidth(this.imageTheme.imageBorderWidth)
          .borderColor(this.imageTheme.imageBorderColor)
          .borderStyle(this.imageTheme.imageBorderStyle)
          .width(this.item.imageWidth ?? (this.componentWidth > 0 ? this.componentWidth * this.imageTheme.imageMaximumWidth : undefined))
          .height(this.item.imageHeight)
          .objectFit(this.imageTheme.imageFitType)
          .autoResize(this.imageTheme.imageAutoResize)
          .constraintSize({
            maxWidth: this.imageTheme.imageMaxWidth ?? '100%',
            maxHeight: this.imageTheme.imageMaxHeight
          })
          .onClick(() => {
            this.imageCallback?.(this.item.imageUrl ?? "")
          })
          .onComplete((imageLoadResult) => {
            if (imageLoadResult !== undefined && imageLoadResult !== null) {
              const l = imageWidthAndHeight(
                this.componentWidth,
                imageLoadResult.width,
                imageLoadResult.height,
                (this.item.imageStyleWidth !== undefined ? vp2px(this.item.imageStyleWidth) : undefined) ??
                (this.imageTheme.imageWidth !== undefined ? vp2px(this.imageTheme.imageWidth) : undefined),
                (this.item.imageStyleHeight !== undefined ? vp2px(this.item.imageStyleHeight) : undefined) ??
                (this.imageTheme.imageHeight !== undefined ? vp2px(this.imageTheme.imageHeight) : undefined),
                this.imageTheme.imageMaxWidth,
                this.imageTheme.imageMaxHeight,
                this.imageTheme.imageFixedRatioWidth,
                this.imageTheme.imageMaximumWidth
              )
              this.item.imageWidth = px2vp(l[0])
              this.item.imageHeight = px2vp(l[1])
            }
          })
      }

      if (this.imageTheme.imageDownloadButtonVisible) {
        this.downloadButtonComponent()
      }
    }
    .alignItems(HorizontalAlign.Center)
  }

  /**
   * 下载按钮
   */
  @Builder
  downloadButtonComponent() {
    Row() {
      if (this.imageTheme.imageDownloadButtonIcon !== undefined) {
        Image(this.imageTheme.imageDownloadButtonIcon)
          .width(this.imageTheme.imageDownloadButtonIconWidth)
          .height(this.imageTheme.imageDownloadButtonIconHeight)
          .objectFit(ImageFit.Contain)
          .fillColor(this.imageTheme.imageDownloadButtonTextFontColor as ResourceColor)
      }

      Blank()
        .width(this.imageTheme.imageDownloadButtonIconTextGap)
        .visibility(this.imageTheme.imageDownloadButtonIcon !== undefined ? Visibility.Visible : Visibility.None)

      Text(this.imageTheme.imageDownloadButtonText)
        .fontFamily(this.imageTheme.imageDownloadButtonTextFontFamily)
        .fontSize(this.imageTheme.imageDownloadButtonTextFontSize)
        .fontWeight(this.imageTheme.imageDownloadButtonTextFontWeight)
        .fontStyle(this.imageTheme.imageDownloadButtonTextFontStyle)
        .fontColor(this.imageTheme.imageDownloadButtonTextFontColor)
        .lineHeight(this.imageTheme.imageDownloadButtonTextLineHeight)
        .align(Alignment.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width(this.imageTheme.imageDownloadButtonWidth)
    .height(this.imageTheme.imageDownloadButtonHeight)
    .borderRadius({
      topLeft: this.imageTheme.imageDownloadButtonRadiusTopLeft,
      topRight: this.imageTheme.imageDownloadButtonRadiusTopRight,
      bottomLeft: this.imageTheme.imageDownloadButtonRadiusBottomLeft,
      bottomRight: this.imageTheme.imageDownloadButtonRadiusBottomRight
    })
    .backgroundColor(this.imageTheme.imageDownloadButtonBackgroundColor)
    .margin({ top: this.imageTheme.imageBottomLayoutMarginTop })
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.imageDownloadCallback?.(this.item.imageUrl ?? "")
    })
  }

  /**
   * 尝试用imageReplaceCallback替换图片
   * 宿主返回原始字节→转为PixelMap→渲染替换后的图片；失败则回退到URL加载
   */
  private tryReplaceImage(): void {
    if (this.imageReplaceCallback === undefined || this.item.imageUrl === undefined) {
      return
    }
    const myToken = ++this.replaceToken
    this.imageReplaceCallback(this.item.imageUrl).then((buffer: ArrayBuffer | undefined) => {
      if (!this.isAlive || buffer === undefined || myToken !== this.replaceToken) {
        return
      }
      const imageSource: image.ImageSource = image.createImageSource(buffer)
      imageSource.createPixelMap().then((pm: PixelMap) => {
        try {
          imageSource.release()
        } catch (e) {
          console.error('ImageBlock imageSource release failed: ' + JSON.stringify(e))
        }
        if (!this.isAlive || myToken !== this.replaceToken) {
          try {
            pm.release()
          } catch (e) {
            console.error('ImageBlock pm release failed: ' + JSON.stringify(e))
          }
          return
        }
        if (this.replacePixelMap !== undefined) {
          try {
            this.replacePixelMap.release()
          } catch (e) {
            console.error('ImageBlock replacePixelMap release failed: ' + JSON.stringify(e))
          }
        }
        this.replacePixelMap = pm
      }).catch(() => {
        try {
          imageSource.release()
        } catch (e) {
          console.error('ImageBlock imageSource release failed: ' + JSON.stringify(e))
        }
      })
    }).catch(() => {
      console.error('ImageBlock imageReplaceCallback failed')
    })
  }
}
