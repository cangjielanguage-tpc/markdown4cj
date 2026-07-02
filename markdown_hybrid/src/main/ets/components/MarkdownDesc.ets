import { MarkdownDataSource } from "../datasource/MarkdownDataSource"
import { NodeView } from "../model/NodeView"
import { GlobalTheme } from "../theme/GlobalTheme"
import { HeadingTheme } from "../theme/HeadingTheme"
import { BlockQuoteTheme } from "../theme/BlockQuoteTheme"
import { BoldTheme } from "../theme/BoldTheme"
import { DefinitionListTheme } from "../theme/DefinitionListTheme"
import { FootnoteRefTheme } from "../theme/FootnoteRefTheme"
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
import { MarkdownDescDef } from "./MarkdownDescDef"
import { MarkdownDescTerm } from "./MarkdownDescTerm"

/**
 * 定义列表控件
 */
@Component
export struct MarkdownDesc {
  @ObjectLink @Watch('refreshData') node: NodeView // 定义列表自身节点数据
  @ObjectLink definitionListTheme: DefinitionListTheme // 定义列表样式
  @ObjectLink headingTheme: HeadingTheme // 标题样式
  @ObjectLink globalTheme: GlobalTheme // 整体样式
  @ObjectLink blockQuoteTheme: BlockQuoteTheme // 块引用样式
  @ObjectLink subTheme: SubTheme // 下标样式
  @ObjectLink supTheme: SupTheme // 上标样式
  @ObjectLink inlineCodeTheme: InlineCodeTheme // 内联代码样式
  @ObjectLink boldTheme: BoldTheme // 加粗样式
  @ObjectLink italicTheme: ItalicTheme // 斜体样式
  @ObjectLink latexMathTheme: LatexMathTheme // 数学公式样式
  @ObjectLink strikethroughTheme: StrikethroughTheme // 删除线样式
  @ObjectLink highlightTheme: HighlightTheme // 高亮样式
  @ObjectLink htmlUnderlineTheme: HtmlUnderlineTheme // 下划线样式
  @ObjectLink linkTheme: LinkTheme // 链接样式
  @ObjectLink footnoteRefTheme: FootnoteRefTheme // 内联脚注样式
  @ObjectLink tableTheme: TableTheme // 表格样式
  @ObjectLink paragraphTheme: ParagraphTheme // 段落样式
  @ObjectLink imageTheme: ImageTheme // 图片样式
  @Prop componentWidth: number = 0.0 // 父布局控件宽度
  textCopyCallback?: (text: string) => void // 文本复制的点击事件
  footnoteCallback?: (index: string) => void // 脚注点击事件
  tocCallback?: (index: number) => void // TOC/标题ID点击事件
  linkCallback?: (url: string) => void // 链接点击事件
  imageCallback?: (url: string) => void // 图片点击事件
  imageDownloadCallback?: (url: string) => void // 图片下载事件
  imageReplaceCallback?: (url: string) => Promise<ArrayBuffer | undefined> // 图片替换回调
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  scroller: Scroller = new Scroller() // list控制器
  markdownDataSource: MarkdownDataSource = new MarkdownDataSource([]) // markdown页面数据源

  aboutToAppear(): void {
    this.refreshData() // 首次加载
  }

  build() {
    List({ scroller: this.scroller }) {
      LazyForEach(
        this.markdownDataSource,
        (item: NodeView, index: number) => {
          ListItem() {
            if (item.nodeType === "DescDef") {
              // 定义列表释义
              MarkdownDescDef({
                node: item,
                headingTheme: this.headingTheme,
                globalTheme: this.globalTheme,
                subTheme: this.subTheme,
                supTheme: this.supTheme,
                inlineCodeTheme: this.inlineCodeTheme,
                boldTheme: this.boldTheme,
                italicTheme: this.italicTheme,
                strikethroughTheme: this.strikethroughTheme,
                highlightTheme: this.highlightTheme,
                htmlUnderlineTheme: this.htmlUnderlineTheme,
                linkTheme: this.linkTheme,
                footnoteRefTheme: this.footnoteRefTheme,
                tableTheme: this.tableTheme,
                paragraphTheme: this.paragraphTheme,
                blockQuoteTheme: this.blockQuoteTheme,
                definitionListTheme: this.definitionListTheme,
                imageTheme: this.imageTheme,
                latexMathTheme: this.latexMathTheme,
                latexImageCallback: this.latexImageCallback,
                latexStrCallback: this.latexStrCallback,
                componentWidth: this.componentWidth,
                textCopyCallback: this.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback,
                linkCallback: this.linkCallback,
                imageCallback: this.imageCallback,
                imageDownloadCallback: this.imageDownloadCallback,
                imageReplaceCallback: this.imageReplaceCallback
              })
            } else if (item.nodeType === "DescTerm") {
              // 定义列表术语
              MarkdownDescTerm({
                node: item,
                headingTheme: this.headingTheme,
                globalTheme: this.globalTheme,
                subTheme: this.subTheme,
                supTheme: this.supTheme,
                inlineCodeTheme: this.inlineCodeTheme,
                boldTheme: this.boldTheme,
                italicTheme: this.italicTheme,
                strikethroughTheme: this.strikethroughTheme,
                highlightTheme: this.highlightTheme,
                htmlUnderlineTheme: this.htmlUnderlineTheme,
                linkTheme: this.linkTheme,
                footnoteRefTheme: this.footnoteRefTheme,
                tableTheme: this.tableTheme,
                paragraphTheme: this.paragraphTheme,
                blockQuoteTheme: this.blockQuoteTheme,
                definitionListTheme: this.definitionListTheme,
                imageTheme: this.imageTheme,
                latexMathTheme: this.latexMathTheme,
                latexImageCallback: this.latexImageCallback,
                latexStrCallback: this.latexStrCallback,
                componentWidth: this.componentWidth,
                textCopyCallback: this.textCopyCallback,
                footnoteCallback: this.footnoteCallback,
                tocCallback: this.tocCallback,
                linkCallback: this.linkCallback,
                imageCallback: this.imageCallback,
                imageDownloadCallback: this.imageDownloadCallback,
                imageReplaceCallback: this.imageReplaceCallback
              })
            } else {
              // 其它
              Text("")
            }
          }
        },
        (item: NodeView, index: number) => {
          return `${index}-${item.nodeType}`
        }
      )
    }
    .backgroundColor(this.definitionListTheme.definitionListBackgroundColor ?? this.globalTheme.backgroundColor)
    .listDirection(Axis.Vertical)
    .alignListItem(ListItemAlign.Start)
    .padding({
      top: this.definitionListTheme.definitionListPaddingTop,
      right: this.definitionListTheme.definitionListPaddingRight,
      bottom: this.definitionListTheme.definitionListPaddingBottom,
      left: this.definitionListTheme.definitionListPaddingLeft
    })
    .margin({
      top: this.definitionListTheme.definitionListMarginTop,
      right: this.definitionListTheme.definitionListMarginRight,
      bottom: this.definitionListTheme.definitionListMarginBottom,
      left: this.definitionListTheme.definitionListMarginLeft
    })
  }

  /**
   * 刷新数据
   */
  refreshData() {
    if (this.node.children.length === 0) {
      this.markdownDataSource.clear()
      return
    }
    this.markdownDataSource.smartUpdateDataArray(this.node.children)
  }
}