import { image } from "@kit.ImageKit"
import { resourceColorToNumber } from "../base/Constants"
import { latexStringToImage, LatexMathColorFormat } from "@cangjie-tpc/formula_hybrid"
import { LatexMathTheme } from "../theme/LatexMathTheme"
import { LatexParseQueue } from "../model/LatexParseQueue"

/**
 * 数学公式块级别控件
 * 使用formula_hybrid将LaTeX文本渲染为图片显示
 * 通过全局队列串行化原生调用，避免大量公式同时解析导致卡死
 */
@Component
export struct MarkdownLatexMathBlock {
  @Prop @Watch('onLatexStrChanged') latexMathBlockStr: string // 数学公式文本
  @ObjectLink latexMathTheme: LatexMathTheme // 数学公式样式
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  @State pixelMap: PixelMap | undefined = undefined // 解析后的PixelMap
  @State imageHeight: number = 0 // 图片高度 - 单位px
  @State imageWidth: number = 0 // 图片宽度 - 单位px
  @State imageData: ArrayBuffer | undefined = undefined // 图片数组数据
  @State isParserEnd: boolean = false // 解析是否结束
  private isAlive: boolean = true // 组件是否存活
  private isQueued: boolean = false // 是否已在队列中等待

  aboutToAppear(): void {
    this.enqueueParse()
  }

  aboutToDisappear(): void {
    this.isAlive = false
    if (this.pixelMap !== undefined) {
      try {
        this.pixelMap.release()
      } catch (e) {
        console.error('PixelMap release failed: ' + JSON.stringify(e))
      }
      this.pixelMap = undefined
    }
    this.imageData = undefined
  }

  /**
   * @Watch回调：latexMathBlockStr变化时入队重新解析
   */
  private onLatexStrChanged(): void {
    this.enqueueParse()
  }

  /**
   * 将解析任务加入全局队列
   * isQueued去重：避免@Watch高频触发时重复入队
   */
  private enqueueParse(): void {
    if (this.isQueued) {
      return
    }
    this.isQueued = true
    LatexParseQueue.enqueue(() => {
      this.isQueued = false
      if (this.isAlive) {
        this.latexMathBlockParser()
      } else {
        LatexParseQueue.notifyDone()
      }
    })
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
   * 全局队列保证同一时间只有一个latexStringToImage调用
   */
  private latexMathBlockParser(): void {
    if (this.pixelMap !== undefined) {
      try {
        this.pixelMap.release()
      } catch (e) {
        console.error('PixelMap release failed: ' + JSON.stringify(e))
      }
      this.pixelMap = undefined
    }
    this.imageData = undefined
    this.isParserEnd = false
    const strLatexMath: string = this.latexStrCallback(this.latexMathBlockStr)
    const textSize: number = vp2px(this.latexMathTheme.latexMathTextSize)
    const textColor: number = resourceColorToNumber(this.latexMathTheme.latexMathTextColor)
    const bgColor: number = resourceColorToNumber(this.latexMathTheme.latexMathBackgroundColor)
    const colorFormat: LatexMathColorFormat = this.latexMathTheme.latexMathColorFormat === 0
      ? LatexMathColorFormat.COLOR_FORMAT_RGB_565
      : LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
    const resPath: string | undefined = this.latexMathTheme.latexMathResPath

    latexStringToImage(strLatexMath, textSize, textColor, bgColor, colorFormat, resPath)
      .then((buffer: ArrayBuffer) => {
        if (!this.isAlive) {
          LatexParseQueue.notifyDone()
          return
        }
        const imageSource: image.ImageSource = image.createImageSource(buffer)
        imageSource.createPixelMap().then((pm: PixelMap) => {
          try {
            imageSource.release()
          } catch (e) {
            console.error('ImageSource release failed: ' + JSON.stringify(e))
          }
          if (!this.isAlive) {
            try {
              pm.release()
            } catch (e) {
              console.error('PixelMap release failed: ' + JSON.stringify(e))
            }
            LatexParseQueue.notifyDone()
            return
          }
          this.pixelMap = pm
          this.imageData = buffer
          pm.getImageInfo().then((info: image.ImageInfo) => {
            if (!this.isAlive) {
              LatexParseQueue.notifyDone()
              return
            }
            this.imageWidth = info.size.width
            this.imageHeight = info.size.height
            this.isParserEnd = true
            LatexParseQueue.notifyDone()
          }).catch(() => {
            try {
              pm.release()
            } catch (e) {
              console.error('PixelMap release failed: ' + JSON.stringify(e))
            }
            this.pixelMap = undefined
            if (this.isAlive) {
              this.isParserEnd = true
            }
            LatexParseQueue.notifyDone()
          })
        }).catch(() => {
          try {
            imageSource.release()
          } catch (e) {
            console.error('ImageSource release failed: ' + JSON.stringify(e))
          }
          if (this.isAlive) {
            this.isParserEnd = true
          }
          LatexParseQueue.notifyDone()
        })
      })
      .catch(() => {
        if (this.isAlive) {
          this.isParserEnd = true
        }
        LatexParseQueue.notifyDone()
      })
  }
}
