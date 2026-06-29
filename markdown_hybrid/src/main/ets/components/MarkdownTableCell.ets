import { image } from "@kit.ImageKit"
import { latexStringToImage, LatexMathColorFormat } from "@cangjie-tpc/formula_hybrid"
import { CellWidthTracker } from "../model/CellWidthTracker"
import { LatexParseQueue } from "../model/LatexParseQueue"
import { NodeView } from "../model/NodeView"
import { BlockQuoteTheme } from "../theme/BlockQuoteTheme"
import { BoldTheme } from "../theme/BoldTheme"
import { DefinitionListTheme } from "../theme/DefinitionListTheme"
import { FootnoteRefTheme } from "../theme/FootnoteRefTheme"
import { GlobalTheme } from "../theme/GlobalTheme"
import { HeadingTheme } from "../theme/HeadingTheme"
import { HighlightTheme } from "../theme/HighlightTheme"
import { HtmlUnderlineTheme } from "../theme/HtmlUnderlineTheme"
import { ImageTheme } from "../theme/ImageTheme"
import { InlineCodeTheme } from "../theme/InlineCodeTheme"
import { ItalicTheme } from "../theme/ItalicTheme"
import { LatexMathTheme } from "../theme/LatexMathTheme"
import { LinkTheme } from "../theme/LinkTheme"
import { ParagraphTheme } from "../theme/ParagraphTheme"
import { StrikethroughTheme } from "../theme/StrikethroughTheme"
import { SubTheme } from "../theme/SubTheme"
import { SupTheme } from "../theme/SupTheme"
import { TableTheme } from "../theme/TableTheme"
import {
  imageUrlHandle, imageWidthAndHeight, spanSoftLineBreak
} from "../utils/MarkdownUtils"
import {
  spanBackgroundColor,
  spanBaselineOffset,
  spanDecoration,
  spanFontColor,
  spanFontFamily,
  spanFontSize,
  spanFontStyle,
  spanFontWeight,
  spanLetterSpacing,
  spanLineHeight,
  tableCellBackgroundColor
} from "../utils/MrkdownThemeUtils"

/**
 * 表格格子控件
 */
@Component
export struct MarkdownTableCell {
  @Consume placeholderPixelMap: PixelMap | undefined // 图片占位图
  @ObjectLink @Watch('refreshData') node: NodeView // 表格格子自身节点数据
  @ObjectLink headingTheme: HeadingTheme // 标题样式
  @ObjectLink globalTheme: GlobalTheme // 整体样式
  @ObjectLink blockQuoteTheme: BlockQuoteTheme // 块引用样式
  @ObjectLink subTheme: SubTheme // 下标样式
  @ObjectLink supTheme: SupTheme // 上标样式
  @ObjectLink inlineCodeTheme: InlineCodeTheme // 内联代码样式
  @ObjectLink boldTheme: BoldTheme // 加粗样式
  @ObjectLink italicTheme: ItalicTheme // 斜体样式
  @ObjectLink strikethroughTheme: StrikethroughTheme // 删除线样式
  @ObjectLink highlightTheme: HighlightTheme // 高亮样式
  @ObjectLink htmlUnderlineTheme: HtmlUnderlineTheme // 下划线样式
  @ObjectLink linkTheme: LinkTheme // 链接样式
  @ObjectLink footnoteRefTheme: FootnoteRefTheme // 内联脚注样式
  @ObjectLink tableTheme: TableTheme // 表格样式
  @ObjectLink paragraphTheme: ParagraphTheme // 标题样式
  @ObjectLink definitionListTheme: DefinitionListTheme // 定义列表样式
  @ObjectLink imageTheme: ImageTheme // 图片样式
  @ObjectLink latexMathTheme: LatexMathTheme // 数学公式样式
  @Prop componentWidth: number = 0.0 // 父布局控件宽度
  textCopyCallback?: (text: string) => void // 文本复制的点击事件
  footnoteCallback?: (index: string) => void // 脚注点击事件
  tocCallback?: (index: number) => void // TOC/标题ID点击事件
  linkCallback?: (url: string) => void // 链接点击事件
  imageCallback?: (url: string) => void // 图片点击事件
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  @Prop tableBlockCellRow: number // 表格的第几行
  @Prop tableBlockCellCell: number // 表格的第几条
  @Prop tableBlockCellCellSize: number // 表格总共有几列
  @Prop columnWidth: number = 0 // 本列宽度（来自父组件@State快照）
  @Consume cellWidthTracker: CellWidthTracker // 列宽跟踪器（非@Observed，onSizeChange只写不触发重渲染）
  @Consume isLatexMathEnabled: boolean // 数学公式插件是否启用
  @State @Watch('onListChanged') list: NodeView[] = [] // 表格格子子节点数据源
  private isAlive: boolean = true // 组件是否存活

  aboutToAppear(): void {
    this.refreshData() // 首次加载
  }

  aboutToDisappear(): void {
    this.isAlive = false
    for (const item of this.list) {
      if (item.latexPixelMap !== undefined) {
        item.latexPixelMap.release()
        item.latexPixelMap = undefined
        item.latexImageData = undefined
        item.latexImageWidth = 0
        item.latexImageHeight = 0
        item.latexIsLoading = false
      }
    }
  }

  build() {
    Column() {
      this.tableCellColumn()
    }
    .alignItems(this.node.tableAlignment)
    .justifyContent(FlexAlign.Center)
    .alignSelf(ItemAlign.Stretch)
    .padding({
      top: this.tableTheme.tableCellPaddingTop,
      right: this.tableTheme.tableCellPaddingRight,
      bottom: this.tableTheme.tableCellPaddingBottom,
      left: this.tableTheme.tableCellPaddingLeft
    })
    .backgroundColor(tableCellBackgroundColor(this.node, this.blockQuoteTheme, this.tableTheme, this.node.isQuote, this.tableBlockCellRow))
    .borderWidth({
      left: this.leftWidths(),
      right: this.rightWidths(),
      top: this.topWidths(),
      bottom: this.bottomWidths()
    })
    .borderStyle(this.tableTheme.tableBorderStyle)
    .borderColor(this.tableTheme.tableBorderColor)
    .constraintSize({ minWidth: this.columnWidth, maxWidth: this.tableTheme.tableMaxCellWidth })
    .onSizeChange((oldValue, newValue) => {
      let newWidth: number = 0
      if (typeof newValue.width === 'number') {
        newWidth = newValue.width
      }
      if (newWidth > 0) {
        this.cellWidthTracker.updateIfWider(this.tableBlockCellCell, newWidth)
      }
    })
  }

  /**
   * 段落文本数据循环
   * 注意：顶层ForEach直接引用this.list(@State)，不通过@Builder参数传递
   * 因为@Builder参数会创建本地副本，导致@State变化无法同步到ForEach
   */
  @Builder
  tableCellColumn() {
    Text() {
      ForEach(
        this.list,
        (item: NodeView, index: number) => {
          this.tableCellInlineItem(item, index)
        },
        (item: NodeView, index: number) => {
          return `${index}-${item.nodeType}-${item.contentHash}-${item.imageWidth}-${item.imageHeight}-${item.latexImageWidth}`
        }
      )
    }
    .textAlign(TextAlign.Start)
    .halfLeading(true)
    .copyOption(
      this.globalTheme.isOnCopy ? CopyOptions.LocalDevice : CopyOptions.None
    )
    .onCopy((str) => {
      this.textCopyCallback?.(str)
    })
  }

  /**
   * 渲染单个内联节点（文本/代码/链接/加粗等）
   */
  @Builder
  tableCellInlineItem(item: NodeView, index: number) {
    if (item.nodeType == "Text" || item.nodeType == "Code" || item.nodeType == "Footnote") {
      // 普通文本/内联代码/内联脚注
      Span(item.nodeText)
        .fontColor(spanFontColor(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .fontSize(spanFontSize(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .fontStyle(spanFontStyle(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme,
          this.definitionListTheme
        ))
        .fontWeight(spanFontWeight(
          item,
          false,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme,
          this.definitionListTheme
        ))
        .fontFamily(spanFontFamily(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .letterSpacing(spanLetterSpacing(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .decoration(spanDecoration(
          item,
          this.strikethroughTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme
        ))
        .textBackgroundStyle(spanBackgroundColor(
          item,
          this.inlineCodeTheme,
          this.highlightTheme,
          this.linkTheme,
          this.footnoteRefTheme
        ))
        .baselineOffset(spanBaselineOffset(
          item,
          this.subTheme,
          this.supTheme
        ))
        .lineHeight(spanLineHeight(
          item,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .onClick(() => {
          if (item.footnoteID !== undefined) {
            this.footnoteCallback?.(item.footnoteID)
            return
          }
          if (item.headLinkIndex !== undefined) {
            this.tocCallback?.(item.headLinkIndex)
            return
          }
          if (item.linkUrl !== undefined) {
            this.linkCallback?.(item.linkUrl)
            return
          }
        })
    } else if (item.nodeType == "SoftLineBreak") {
      // 软换行
      Span(spanSoftLineBreak(this.globalTheme.isLineBreak))
    } else if (item.nodeType == "HardLineBreak") {
      // 硬换行
      Span("\n")
    } else if (item.nodeType == "Image" || item.nodeType == "StyleImage" || item.nodeType == "ImageHtmlNode") {
      // 图片/图片Style/HTML图片
      ImageSpan(imageUrlHandle(item.imageUrl))
        .alt(this.placeholderPixelMap)
        .margin({
          top: this.imageTheme.imageMarginTop,
          right: this.imageTheme.imageMarginRight,
          bottom: this.imageTheme.imageMarginBottom,
          left: this.imageTheme.imageMarginLeft
        })
        .borderRadius({
          topLeft: this.imageTheme.imageRadiusTopLeft,
          topRight: this.imageTheme.imageRadiusTopRight,
          bottomLeft: this.imageTheme.imageRadiusBottomLeft,
          bottomRight: this.imageTheme.imageRadiusBottomRight
        })
        .borderWidth(this.imageTheme.imageBorderWidth)
        .borderColor(this.imageTheme.imageBorderColor)
        .borderStyle(this.imageTheme.imageBorderStyle)
        .width(item.imageWidth)
        .height(item.imageHeight)
        .objectFit(this.imageTheme.imageFitType)
        .verticalAlign(ImageSpanAlignment.CENTER)
        .constraintSize({
          maxWidth: this.columnWidth > 0 ? this.columnWidth : (this.imageTheme.imageMaxWidth ?? '100%'),
          maxHeight: this.imageTheme.imageMaxHeight
        })
        .onClick(() => {
          if (item.isLink) {
            this.linkCallback?.(item.linkUrl ?? "")
          } else {
            this.imageCallback?.(item.imageUrl ?? "")
          }
        })
        .onComplete((imageLoadResult) => {
          const l = imageWidthAndHeight(
            this.componentWidth,
            imageLoadResult.width,
            imageLoadResult.height,
            item.imageStyleWidth ?? this.imageTheme.imageWidth,
            item.imageStyleHeight ?? this.imageTheme.imageHeight,
            this.imageTheme.imageMaxWidth,
            this.imageTheme.imageMaxHeight,
            this.imageTheme.imageFixedRatioWidth,
            this.imageTheme.imageMaximumWidth
          )
          let w = l[0]
          let h = l[1]
          item.imageWidth = w
          item.imageHeight = h
          if (this.list.indexOf(item) >= 0) {
            this.list = [...this.list]
            this.cellWidthTracker.onWidthUpdated?.() // 图片加载后触发列宽重算
          }
        })
    } else if (item.nodeType == "LatexMathNode") {
      // 数学公式行内 - 和图片一样直接用ImageSpan
      if (this.isLatexMathEnabled && item.latexPixelMap !== undefined && item.latexImageWidth > 0 && item.latexImageHeight > 0) {
        ImageSpan(item.latexPixelMap)
          .height(this.latexMathTheme.latexMathTextSize)
          .width((item.latexImageWidth / item.latexImageHeight) * this.latexMathTheme.latexMathTextSize)
          .verticalAlign(ImageSpanAlignment.CENTER)
          .onClick(() => {
            if (this.latexImageCallback !== undefined && item.latexImageData !== undefined) {
              this.latexImageCallback(item.latexImageData, item.latexImageHeight, item.latexImageWidth)
            }
          })
      } else {
        Span(item.nodeText)
      }
    } else {
      // 其它
    }
  }

  /**
   * 表格左部边框宽度
   */
  leftWidths(): Length {
    return 0
  }

  /**
   * 表格右部边框宽度
   */
  rightWidths(): Length {
    return this.tableBlockCellCell == this.tableBlockCellCellSize - 1 ? 0 : this.tableTheme.tableBorderWidth
  }

  /**
   * 表格顶部边框宽度
   */
  topWidths(): Length {
    return this.tableBlockCellRow == 0 ? 0 : this.tableTheme.tableBorderWidth
  }

  /**
   * 表格底部边框宽度
   */
  bottomWidths(): Length {
    return 0
  }

  /**
   * 刷新数据
   */
  refreshData() {
    const children = this.node.children
    if (children.length == 0) {
      this.list = []
      return
    }
    const oldImageSizes: Map<string, number[]> = new Map()
    for (const oldChild of this.list) {
      if (oldChild.imageUrl && oldChild.imageWidth > 0) {
        oldImageSizes.set(oldChild.imageUrl, [oldChild.imageWidth, oldChild.imageHeight])
      }
    }
    for (const newChild of children) {
      if (newChild.imageUrl) {
        const oldSize = oldImageSizes.get(newChild.imageUrl)
        if (oldSize) {
          newChild.imageWidth = oldSize[0]
          newChild.imageHeight = oldSize[1]
        }
      }
    }
    this.list = [...children]
  }

  /**
   * list变化时触发数学公式异步加载（从refreshData移出，避免每次流式输出都跑for循环）
   */
  onListChanged() {
    if (!this.isLatexMathEnabled) {
      return
    }
    for (const child of this.list) {
      if (child.nodeType === "LatexMathNode" && !child.latexIsLoading && child.latexPixelMap === undefined) {
        child.latexIsLoading = true
        LatexParseQueue.enqueue(() => {
          if (this.isAlive) {
            this.loadLatexImage(child)
          } else {
            LatexParseQueue.notifyDone()
          }
        })
      }
    }
  }

  /**
   * 异步加载数学公式图片（通过全局队列串行调用latexStringToImage）
   */
  private loadLatexImage(item: NodeView): void {
    const strLatexMath: string = this.latexStrCallback(item.nodeText)
    const textSize: number = vp2px(this.latexMathTheme.latexMathTextSize)
    const textColor: number = this.resourceColorToNumber(this.latexMathTheme.latexMathTextColor)
    const bgColor: number = this.resourceColorToNumber(this.latexMathTheme.latexMathBackgroundColor)
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
          if (!this.isAlive) {
            pm.release()
            LatexParseQueue.notifyDone()
            return
          }
          pm.getImageInfo().then((info: image.ImageInfo) => {
            if (!this.isAlive) {
              pm.release()
              LatexParseQueue.notifyDone()
              return
            }
            item.latexPixelMap = pm
            item.latexImageData = buffer
            item.latexImageWidth = info.size.width
            item.latexImageHeight = info.size.height
            item.latexIsLoading = false
            this.list = [...this.list] // 触发重渲染
            this.cellWidthTracker.onWidthUpdated?.() // 触发列宽重算
            LatexParseQueue.notifyDone()
          }).catch(() => {
            item.latexIsLoading = false
            LatexParseQueue.notifyDone()
          })
        }).catch(() => {
          item.latexIsLoading = false
          LatexParseQueue.notifyDone()
        })
      })
      .catch(() => {
        item.latexIsLoading = false
        LatexParseQueue.notifyDone()
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
