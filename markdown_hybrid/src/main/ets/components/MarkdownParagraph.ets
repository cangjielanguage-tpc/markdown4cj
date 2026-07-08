import { image } from "@kit.ImageKit"
import { resourceColorToNumber } from "../base/Constants"
import { latexStringToImage, LatexMathColorFormat } from "@cangjie-tpc/formula_hybrid"
import { NodeView } from "../model/NodeView"
import { LatexParseQueue } from "../model/LatexParseQueue"
import { BlockQuoteTheme } from "../theme/BlockQuoteTheme"
import { BoldTheme } from "../theme/BoldTheme"
import { DefinitionListTheme } from "../theme/DefinitionListTheme"
import { FootnoteRefTheme } from "../theme/FootnoteRefTheme"
import { GlobalTheme } from "../theme/GlobalTheme"
import { HeadingTheme } from "../theme/HeadingTheme"
import { HighlightTheme } from "../theme/HighlightTheme"
import { HtmlUnderlineTheme } from "../theme/HtmlUnderlineTheme"
import { ImageTheme } from "../theme/ImageTheme"
import { MarkdownImageBlock } from "./MarkdownImageBlock"
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
  imageUrlHandle,
  imageWidthAndHeight,
  spanSoftLineBreak
} from "../utils/MarkdownUtils"
import {
  generateLinkIconPixelMap,
  LinkIconResult
} from "../utils/MarkdownLinkIconGenerator"
import {
  paragraphBackgroundColor,
  spanBackgroundColor,
  spanBaselineOffset,
  spanDecoration,
  spanFontColor,
  spanFontFamily,
  spanFontSize,
  spanFontStyle,
  spanFontWeight,
  spanLetterSpacing,
  spanLineHeight
} from "../utils/MarkdownThemeUtils"
import { MarkdownHighlightParagraph } from "../configs/MarkdownHighlightParagraph"

/**
 * 段落控件
 */
@Component
export struct MarkdownParagraph {
  @Consume placeholderPixelMap: PixelMap | undefined // 图片占位图
  @Consume isLatexMathEnabled: boolean // 数学公式插件是否启用
  @ObjectLink @Watch('refreshData') node: NodeView // 段落自身节点数据
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
  @ObjectLink paragraphTheme: ParagraphTheme // 段落样式
  @ObjectLink definitionListTheme: DefinitionListTheme // 定义列表样式
  @ObjectLink imageTheme: ImageTheme // 图片样式
  @ObjectLink latexMathTheme: LatexMathTheme // 数学公式样式
  @ObjectLink markdownHighlightParagraph: MarkdownHighlightParagraph // 段落高亮配置
  @Prop componentWidth: number = 0.0 // 父布局控件宽度
  textCopyCallback?: (text: string) => void // 文本复制的点击事件
  footnoteCallback?: (index: string) => void // 脚注点击事件
  tocCallback?: (index: number) => void // TOC/标题ID点击事件
  linkCallback?: (url: string) => void // 链接点击事件
  imageCallback?: (url: string) => void // 图片点击事件
  imageDownloadCallback?: (url: string) => void // 图片下载点击事件
  imageReplaceCallback?: (url: string) => Promise<ArrayBuffer | undefined> // 图片替换回调
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  @State @Watch('onListChanged') list: NodeView[] = [] // 段落子节点数据源
  private isAlive: boolean = true // 组件是否存活

  aboutToAppear(): void {
    // 组件重建时（LazyForEach key变化导致销毁+重建），复用的LatexMathNode可能
    // 带有旧组件遗留的latexIsLoading=true（旧组件的异步loadLatexImage尚未走到!isAlive分支重置）
    // 此处重置，确保tryEnqueueLatexLoading能重新入队
    for (const child of this.node.children) {
      if (child.nodeType === "LatexMathNode" && child.latexPixelMap === undefined && child.latexIsLoading) {
        child.latexIsLoading = false
      }
    }
    this.refreshData() // 首次加载
  }

  aboutToDisappear(): void {
    this.isAlive = false
  }

  build() {
    Row() {
      this.paragraphColumn()
    }
    .backgroundColor(paragraphBackgroundColor(
      this.globalTheme,
      this.blockQuoteTheme,
      this.paragraphTheme,
      this.markdownHighlightParagraph,
      this.node.isQuote,
      this.node.nodeHash
    ))
    .padding({
      top: this.paragraphTheme.paragraphPaddingTop,
      right: this.paragraphTheme.paragraphPaddingRight,
      bottom: this.paragraphTheme.paragraphPaddingBottom,
      left: this.paragraphTheme.paragraphPaddingLeft
    })
    .margin({
      top: this.paragraphTheme.paragraphMarginTop,
      right: this.paragraphTheme.paragraphMarginRight,
      bottom: this.paragraphTheme.paragraphMarginBottom,
      left: this.paragraphTheme.paragraphMarginLeft
    })
  }

  /**
   * 段落文本数据循环
   * 注意：顶层ForEach直接引用this.list(@State)，不通过@Builder参数传递
   * 因为@Builder参数会创建本地副本，导致@State变化无法同步到ForEach
   */
  @Builder
  paragraphColumn() {
    Column() {
      if (!this.imageTheme.isImageMixedLayout
        && this.list.length === 1
        && (this.list[0].nodeType === "Image" || this.list[0].nodeType === "StyleImage" || this.list[0].nodeType === "ImageHtmlNode")) {
        MarkdownImageBlock({
          item: this.list[0],
          imageTheme: this.imageTheme,
          componentWidth: this.componentWidth,
          imageCallback: this.imageCallback,
          imageDownloadCallback: this.imageDownloadCallback,
          imageReplaceCallback: this.imageReplaceCallback
        })
      } else {
      Text() {
        if (this.node.footnoteID !== undefined) {
          Span(`[^${this.node.footnoteID}]: `)
            .fontSize(this.paragraphTheme.paragraphTextFontSize)
            .fontWeight(this.paragraphTheme.paragraphTextFontWeight)
            .fontColor(this.paragraphTheme.paragraphTextFontColor)
        }
        ForEach(
          this.list,
          (item: NodeView, index: number) => {
            this.paragraphInlineItem(item, index)
          },
          (item: NodeView, index: number) => {
          return `${index}-${item.nodeHash}-${item.contentHash}-${item.imageWidth}-${item.imageHeight}-${item.latexImageWidth}-${item.latexImageHeight}-${item.latexPixelMap !== undefined}-${item.imageReplacePixelMap !== undefined}-${item.linkIconPixelMap !== undefined}`
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
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .layoutWeight(1)
  }

  /**
   * 渲染单个内联节点（文本/代码/链接/加粗等）
   *
   * @param item 节点视图
   * @param index 索引
   */
  @Builder
  paragraphInlineItem(item: NodeView, index: number) {
    if (item.nodeType === "Text" || item.nodeType === "Code" || item.nodeType === "Footnote") {
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
    } else if (item.nodeType === "SoftLineBreak") {
      // 软换行
      Span(spanSoftLineBreak(this.globalTheme.isLineBreak))
    } else if (item.nodeType === "HardLineBreak") {
      // 硬换行
      Span("\n")
    } else if (item.nodeType === "Link" || item.nodeType === "HeadLink") {
      if ((item.isBulletList || item.isOrderedList || item.isQuote || item.isDescList) && this.isSingleLinkNode() && !this.linkTheme.linkListIsIcon) {
        Span(item.nodeText)
          .fontColor(this.linkTheme.linkTextFontColor)
          .fontSize(this.paragraphTheme.paragraphTextFontSize)
          .onClick(() => {
            if (item.linkUrl !== undefined) {
              this.linkCallback?.(item.linkUrl)
            }
          })
      } else {
        if (item.linkIconPixelMap !== undefined && item.linkIconWidth > 0 && item.linkIconHeight > 0) {
          ImageSpan(item.linkIconPixelMap)
            .width(px2vp(item.linkIconWidth))
            .height(px2vp(item.linkIconHeight))
            .verticalAlign(ImageSpanAlignment.CENTER)
            .onClick(() => {
              if (item.linkUrl !== undefined) {
                this.linkCallback?.(item.linkUrl)
              }
            })
        } else {
          Span(item.nodeText)
            .fontColor(this.linkTheme.linkTextFontColor)
            .fontSize(this.paragraphTheme.paragraphTextFontSize)
            .decoration(spanDecoration(
              item,
              this.strikethroughTheme,
              this.htmlUnderlineTheme,
              this.linkTheme,
              this.footnoteRefTheme
            ))
            .onClick(() => {
              if (item.linkUrl !== undefined) {
                this.linkCallback?.(item.linkUrl)
              }
            })
        }
      }
    } else if (item.nodeType === "Image" || item.nodeType === "StyleImage" || item.nodeType === "ImageHtmlNode") {
      // 图片/图片Style/HTML图片
      if (item.imageReplacePixelMap !== undefined || item.imageUrl !== undefined) {
      ImageSpan(item.imageReplacePixelMap ?? imageUrlHandle(item.imageUrl))
        .alt(this.placeholderPixelMap)
        .margin({
          top: this.imageTheme.imageMarginTop,
          right: this.imageTheme.imageMarginRight,
          bottom: this.imageTheme.imageMarginBottom,
          left: this.imageTheme.imageMarginLeft
        })
        .borderRadius({
          topLeft: item.imageRadius ?? this.imageTheme.imageRadiusTopLeft,
          topRight: item.imageRadius ?? this.imageTheme.imageRadiusTopRight,
          bottomLeft: item.imageRadius ?? this.imageTheme.imageRadiusBottomLeft,
          bottomRight: item.imageRadius ?? this.imageTheme.imageRadiusBottomRight
        })
        .borderWidth(this.imageTheme.imageBorderWidth)
        .borderColor(this.imageTheme.imageBorderColor)
        .borderStyle(this.imageTheme.imageBorderStyle)
        .width(item.imageWidth ?? (this.componentWidth > 0 ? this.componentWidth * this.imageTheme.imageMaximumWidth : undefined))
        .height(item.imageHeight)
        .objectFit(this.imageTheme.imageFitType)
        .verticalAlign(ImageSpanAlignment.CENTER)
        .constraintSize({ maxWidth: this.imageTheme.imageMaxWidth ?? '100%', maxHeight: this.imageTheme.imageMaxHeight})
        .onClick(()=>{
          if(item.isLink){
            this.linkCallback?.(item.linkUrl ?? "")
          }else{
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
          }
        })
      }
    } else if (item.nodeType === "LatexMathNode") {
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
    * 刷新数据
    */
  refreshData() {
    const children = this.node.children
    if (children.length === 0) {
      for (const old of this.list) {
        old.releaseOwnPixelMaps()
      }
      this.list = []
      return
    }
    const oldImageSizes: Map<string, number[]> = new Map()
    for (const oldChild of this.list) {
      if (oldChild.imageUrl !== undefined && oldChild.imageWidth !== undefined && oldChild.imageWidth > 0 && oldChild.imageHeight !== undefined) {
        oldImageSizes.set(oldChild.imageUrl, [oldChild.imageWidth, oldChild.imageHeight])
      }
    }
    for (const newChild of children) {
      if (newChild.imageUrl !== undefined) {
        const oldSize = oldImageSizes.get(newChild.imageUrl)
        if (oldSize) {
          newChild.imageWidth = oldSize[0]
          newChild.imageHeight = oldSize[1]
        }
      }
    }
    const oldList = this.list
    this.list = [...children]
    // 释放不在新列表中的旧子节点的自身pixmap
    // copyDataFrom不再递归释放孙节点pixmap（避免释放被复用到新容器的节点）
    // 由组件在此处对比oldList和newList，仅释放确实未被复用的节点
    const newSet: Set<NodeView> = new Set<NodeView>(children)
    for (const old of oldList) {
      if (!newSet.has(old)) {
        old.releaseOwnPixelMaps()
      }
    }
    this.tryEnqueueLatexLoading()
  }

  /**
   * 数学公式异步加载入队（从onListChanged提取，refreshData直接调用，不依赖@Watch链）
   */
  private tryEnqueueLatexLoading(): void {
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
            child.latexIsLoading = false
            LatexParseQueue.notifyDone()
          }
        })
      }
    }
  }

  /**
   * list变化时触发数学公式异步加载（从refreshData移出，避免每次流式输出都跑for循环）
   */
  onListChanged() {
    this.tryReplaceImages()
    this.tryGenerateLinkIcons()
    this.tryEnqueueLatexLoading()
  }

  /**
   * 判断当前list是否仅含一个Link节点（用于列表上下文是否图片化判断）
   */
  private isSingleLinkNode(): boolean {
    if (this.list.length !== 1) {
      return false
    }
    const node = this.list[0]
    return node.nodeType === "Link" || node.nodeType === "HeadLink"
  }

  /**
   * 异步生成链接图标PixelMap（通过C++原生绘图）
   */
  private tryGenerateLinkIcons(): void {
    for (const child of this.list) {
      if ((child.nodeType === "Link" || child.nodeType === "HeadLink") && child.isLinkStyle && !child.linkIconTried) {
        child.linkIconTried = true
        child.linkIconText = child.nodeText
        generateLinkIconPixelMap(child.nodeText, child.linkUrl ?? "", this.linkTheme)
          .then((result: LinkIconResult | undefined) => {
            if (!this.isAlive || result === undefined) {
              if (result !== undefined) {
                result.pixelMap.release()
              }
              return
            }
            if (this.list.indexOf(child) < 0) {
              result.pixelMap.release()
              return
            }
            // 流式输出中文本可能已变化，检查是否仍是生成时的文本
            if (child.linkIconText !== child.nodeText) {
              result.pixelMap.release()
              return
            }
            if (child.linkIconPixelMap !== undefined) {
              try {
                child.linkIconPixelMap.release()
              } catch (e) {
                console.error('linkIconPixelMap release failed: ' + JSON.stringify(e))
              }
            }
            child.linkIconPixelMap = result.pixelMap
            child.linkIconWidth = result.width
            child.linkIconHeight = result.height
            this.list = [...this.list]
          })
          .catch(() => {
            console.error('Paragraph linkIcon generation failed')
          })
      }
    }
  }

  /**
   * 异步替换图片：调用imageReplaceCallback获取原始字节→转为PixelMap→更新ImageSpan渲染
   */
  private tryReplaceImages(): void {
    if (this.imageReplaceCallback === undefined) {
      return
    }
    for (const child of this.list) {
      if (child.imageUrl !== undefined && !child.imageReplaceTried) {
        child.imageReplaceTried = true
        this.imageReplaceCallback(child.imageUrl).then((buffer: ArrayBuffer | undefined) => {
          if (!this.isAlive || buffer === undefined) {
            return
          }
          if (this.list.indexOf(child) < 0) {
            return
          }
          const imageSource: image.ImageSource = image.createImageSource(buffer)
          imageSource.createPixelMap().then((pm: PixelMap) => {
            imageSource.release()
            if (!this.isAlive || this.list.indexOf(child) < 0) {
              pm.release()
              return
            }
            child.imageReplacePixelMap = pm
            this.list = [...this.list]
          }).catch(() => {
            imageSource.release()
          })
        }).catch(() => {
          console.error('Paragraph imageReplace failed')
        })
      }
    }
  }

  /**
   * 异步加载数学公式图片
   * 流式输出时latex文本可能增长，需捕获调用时的文本，回调中校验是否已过期，
   * 避免旧文本的图片覆盖新状态（旧图片闪烁/内存泄漏）。
   *
   * @param item 节点视图
   */
  private loadLatexImage(item: NodeView): void {
    const capturedNodeText: string = item.nodeText
    const strLatexMath: string = this.latexStrCallback(capturedNodeText)
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
          item.latexIsLoading = false
          LatexParseQueue.notifyDone()
          return
        }
        const imageSource: image.ImageSource = image.createImageSource(buffer)
        imageSource.createPixelMap().then((pm: PixelMap) => {
          imageSource.release()
          if (!this.isAlive) {
            pm.release()
            item.latexIsLoading = false
            LatexParseQueue.notifyDone()
            return
          }
          pm.getImageInfo().then((info: image.ImageInfo) => {
            if (!this.isAlive) {
              pm.release()
              item.latexIsLoading = false
              LatexParseQueue.notifyDone()
              return
            }
            // 流式输出中文本可能已变化，丢弃过期结果
            // 重新触发onListChanged检查是否需要为新文本重新入队加载
            if (item.nodeText !== capturedNodeText) {
              pm.release()
              LatexParseQueue.notifyDone()
              this.list = [...this.list]
              return
            }
            // 释放旧PixelMap（防御性：理论上此处应为undefined）
            if (item.latexPixelMap !== undefined) {
              try {
                item.latexPixelMap.release()
              } catch (e) {
                console.error('Paragraph latexPixelMap release failed: ' + JSON.stringify(e))
              }
            }
            item.latexPixelMap = pm
            item.latexImageData = buffer
            item.latexImageWidth = info.size.width
            item.latexImageHeight = info.size.height
            item.latexIsLoading = false
            this.list = [...this.list]
            LatexParseQueue.notifyDone()
          }).catch(() => {
            pm.release()
            // 仅当文本未变化时才重置loading，避免覆盖新一轮加载的loading状态
            if (item.nodeText === capturedNodeText) {
              item.latexIsLoading = false
            }
            LatexParseQueue.notifyDone()
          })
        }).catch(() => {
          imageSource.release()
          if (item.nodeText === capturedNodeText) {
            item.latexIsLoading = false
          }
          LatexParseQueue.notifyDone()
        })
      })
      .catch(() => {
        if (item.nodeText === capturedNodeText) {
          item.latexIsLoading = false
        }
        LatexParseQueue.notifyDone()
      })
  }

}
