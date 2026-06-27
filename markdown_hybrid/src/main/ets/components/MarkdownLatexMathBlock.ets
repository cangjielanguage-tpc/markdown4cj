import { image } from "@kit.ImageKit"
import { latexStringToImage, LatexMathColorFormat } from "@cangjie-tpc/formula_hybrid"
import { LatexMathTheme } from "../theme/LatexMathTheme"

/**
 * 数学公式块级别控件
 * 使用formula_hybrid将LaTeX文本渲染为图片显示
 */
@Component
export struct MarkdownLatexMathBlock {
  @Prop @Watch('latexMathBlockParser') latexMathBlockStr: string // 数学公式文本
  @ObjectLink latexMathTheme: LatexMathTheme // 数学公式样式
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  @State pixelMap: PixelMap | undefined = undefined // 解析后的PixelMap
  @State imageHeight: number = 0 // 图片高度 - 单位px
  @State imageWidth: number = 0 // 图片宽度 - 单位px
  @State imageData: ArrayBuffer | undefined = undefined // 图片数组数据
  @State isParserEnd: boolean = false // 解析是否结束

  aboutToAppear(): void {
    this.latexMathBlockParser()
  }

  aboutToDisappear(): void {
    if (this.pixelMap !== undefined) {
      this.pixelMap.release()
      this.pixelMap = undefined
    }
    this.imageData = undefined
  }

  build() {
    if (this.isParserEnd) {
      if (this.pixelMap !== undefined && this.imageHeight > 0 && this.imageWidth > 0 && this.imageData !== undefined) {
        Scroll() {
          Image(this.pixelMap)
            .height(px2vp(this.imageHeight))
            .width(px2vp(this.imageWidth))
            .objectFit(ImageFit.Contain)
            .onClick(() => {
              if (this.latexImageCallback !== undefined && this.imageData !== undefined) {
                this.latexImageCallback(this.imageData, this.imageHeight, this.imageWidth)
              }
            })
        }
        .scrollable(ScrollDirection.Horizontal)
        .width('100%')
        .scrollBar(BarState.Off)
        .align(this.latexMathTheme.latexMathBlockCenter ? Alignment.Center : Alignment.Start)
        .padding({
          top: this.latexMathTheme.latexMathPaddingTop,
          right: this.latexMathTheme.latexMathPaddingRight,
          bottom: this.latexMathTheme.latexMathPaddingBottom,
          left: this.latexMathTheme.latexMathPaddingLeft
        })
        .margin({
          top: this.latexMathTheme.latexMathMarginTop,
          right: this.latexMathTheme.latexMathMarginRight,
          bottom: this.latexMathTheme.latexMathMarginBottom,
          left: this.latexMathTheme.latexMathMarginLeft
        })
      } else {
        Text(this.latexMathBlockStr)
          .fontFamily(this.latexMathTheme.latexMathDefaultTextFontFamily)
          .fontSize(this.latexMathTheme.latexMathDefaultTextFontSize)
          .fontWeight(this.latexMathTheme.latexMathDefaultTextFontWeight)
          .fontStyle(this.latexMathTheme.latexMathDefaultTextFontStyle)
          .fontColor(this.latexMathTheme.latexMathDefaultTextFontColor)
          .padding({
            top: this.latexMathTheme.latexMathPaddingTop,
            right: this.latexMathTheme.latexMathPaddingRight,
            bottom: this.latexMathTheme.latexMathPaddingBottom,
            left: this.latexMathTheme.latexMathPaddingLeft
          })
          .margin({
            top: this.latexMathTheme.latexMathMarginTop,
            right: this.latexMathTheme.latexMathMarginRight,
            bottom: this.latexMathTheme.latexMathMarginBottom,
            left: this.latexMathTheme.latexMathMarginLeft
          })
      }
    } else {
      if (this.latexMathTheme.latexMathDefaultText) {
        Text(this.latexMathBlockStr)
          .fontFamily(this.latexMathTheme.latexMathDefaultTextFontFamily)
          .fontSize(this.latexMathTheme.latexMathDefaultTextFontSize)
          .fontWeight(this.latexMathTheme.latexMathDefaultTextFontWeight)
          .fontStyle(this.latexMathTheme.latexMathDefaultTextFontStyle)
          .fontColor(this.latexMathTheme.latexMathDefaultTextFontColor)
          .padding({
            top: this.latexMathTheme.latexMathPaddingTop,
            right: this.latexMathTheme.latexMathPaddingRight,
            bottom: this.latexMathTheme.latexMathPaddingBottom,
            left: this.latexMathTheme.latexMathPaddingLeft
          })
          .margin({
            top: this.latexMathTheme.latexMathMarginTop,
            right: this.latexMathTheme.latexMathMarginRight,
            bottom: this.latexMathTheme.latexMathMarginBottom,
            left: this.latexMathTheme.latexMathMarginLeft
          })
      }
    }
  }

  /**
   * 将数学公式文本解析成图片
   */
  private latexMathBlockParser(): void {
    if (this.pixelMap !== undefined) {
      this.pixelMap.release()
      this.pixelMap = undefined
    }
    this.imageData = undefined
    this.isParserEnd = false
    const strLatexMath: string = this.latexStrCallback(this.latexMathBlockStr)
    const textSize: number = vp2px(this.latexMathTheme.latexMathTextSize)
    const textColor: number = this.resourceColorToNumber(this.latexMathTheme.latexMathTextColor)
    const bgColor: number = this.resourceColorToNumber(this.latexMathTheme.latexMathBackgroundColor)
    const colorFormat: LatexMathColorFormat = this.latexMathTheme.latexMathColorFormat === 0
      ? LatexMathColorFormat.COLOR_FORMAT_RGB_565
      : LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
    const resPath: string | undefined = this.latexMathTheme.latexMathResPath

    latexStringToImage(strLatexMath, textSize, textColor, bgColor, colorFormat, resPath)
      .then((buffer: ArrayBuffer) => {
        const imageSource: image.ImageSource = image.createImageSource(buffer)
        imageSource.createPixelMap().then((pm: PixelMap) => {
          this.pixelMap = pm
          this.imageData = buffer
          pm.getImageInfo().then((info: image.ImageInfo) => {
            this.imageWidth = info.size.width
            this.imageHeight = info.size.height
            this.isParserEnd = true
          }).catch(() => {
            this.isParserEnd = true
          })
        }).catch(() => {
          this.isParserEnd = true
        })
      })
      .catch(() => {
        this.isParserEnd = true
      })
  }

  /**
   * ResourceColor转number
   */
  private resourceColorToNumber(color: ResourceColor): number {
    if (typeof color === 'number') {
      return color
    }
    return 0xFF000000
  }
}
