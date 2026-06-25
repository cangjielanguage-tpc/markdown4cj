import { MarkdownDataSource } from "../datasorce/MarkdownDataSource"
import { NodeView } from "../model/NodeView"
import { BlockQuoteTheme } from "../theme/BlockQuoteTheme"
import { BoldTheme } from "../theme/BoldTheme"
import { BulletListTheme } from "../theme/BulletListTheme"
import { DefinitionListTheme } from "../theme/DefinitionListTheme"
import { FootnoteRefTheme } from "../theme/FootnoteRefTheme"
import { GlobalTheme } from "../theme/GlobalTheme"
import { HeadingTheme } from "../theme/HeadingTheme"
import { HighlightTheme } from "../theme/HighlightTheme"
import { HtmlUnderlineTheme } from "../theme/HtmlUnderlineTheme"
import { InlineCodeTheme } from "../theme/InlineCodeTheme"
import { ItalicTheme } from "../theme/ItalicTheme"
import { LinkTheme } from "../theme/LinkTheme"
import { OrderedListTheme } from "../theme/OrderedListTheme"
import { ParagraphTheme } from "../theme/ParagraphTheme"
import { StrikethroughTheme } from "../theme/StrikethroughTheme"
import { SubTheme } from "../theme/SubTheme"
import { SupTheme } from "../theme/SupTheme"
import { TableTheme } from "../theme/TableTheme"

/**
 * 列表子模块控件
 */
@Component
export struct MarkdownListItem {
  @ObjectLink @Watch('refreshData') node: NodeView // 视频自身节点数据
  @ObjectLink orderedListTheme: OrderedListTheme // 视频样式
  @ObjectLink bulletListTheme: BulletListTheme // 视频样式
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
  markdownDataSource: MarkdownDataSource = new MarkdownDataSource([]) // markdown页面数据源
  @Prop isOrdered: boolean // 是无序列表还是有序列表 - true：有序列表，false：无序列表

  aboutToAppear(): void {
    this.refreshData() // 首次加载
  }

  build() {
    List({
      space: this.isOrdered ? this.orderedListTheme.orderedListChildChildSpacing : this.bulletListTheme.bulletListChildChildSpacing
    }) {
      LazyForEach(
        this.markdownDataSource,
        (item: NodeView, idx: number) => {
          ListItem() {
            if (item.nodeType == "Paragraph") {
              // 段落
            } else if (item.nodeType == "Heading" || item.nodeType == "IdHeading") {
              // 标题/标题ID
            } else if (item.nodeType == "FencedCodeBlockListBlock") {
              // 围栏代码块列表
            } else if (item.nodeType == "FencedCodeBlock") {
              // 围栏代码块
            } else if (item.nodeType == "IndentedCodeBlock") {
              // 缩进代码块
            } else if (item.nodeType == "BulletList") {
              // 无序列表
            } else if (item.nodeType == "OrderedList") {
              // 有序列表
            } else if (item.nodeType == "BlockQuote") {
              // 块引用
            } else if (item.nodeType == "LatexMathBlock") {
              // 数学公式块
            } else if (item.nodeType == "TableBlock") {
              // 表格
            } else if (item.nodeType == "ThematicBreak") {
              // 分割线
            } else if (item.nodeType == "FootnoteBlock") {
              // 脚注
            } else if (item.nodeType == "SlideBlock") {
              // 图片幻灯片
            } else if (item.nodeType == "BlockVideo") {
              // 视频
            } else if (item.nodeType == "BlockAudio") {
              // 音频
            } else if (item.nodeType == "BlockAD") {
              // 广告
            } else {
              // 其它
            }
          }
        },
        (item: NodeView, index: number) => {
          // 稳定key：仅用index+nodeType，不包含内容指纹
          // 内容更新通过就地修改NodeView属性+@ObjectLink的@Watch实现，避免组件重建
          // 仅当nodeType变化（如Paragraph→Heading）时key才变化，触发组件重建
          return `${index}-${item.nodeType}`
        }
      )
    }
  }

  /**
   * 刷新数据
   */
  refreshData() {
    if (this.node.children.length == 0) {
      this.markdownDataSource.clear()
      return
    }
    this.markdownDataSource.smartUpdateDataArray(this.node.children)
  }
}