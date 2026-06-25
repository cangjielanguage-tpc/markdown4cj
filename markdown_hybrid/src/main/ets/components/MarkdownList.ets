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
import { listPrefixStr } from "../utils/MarkdownUtils"
import { listBackgroundColor } from "../utils/MrkdownThemeUtils"

/**
 * 列表控件
 */
@Component
export struct MarkdownList {
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
  @Prop listDepth: number = 0 // 列表深度

  aboutToAppear(): void {
    this.refreshData() // 首次加载
  }

  build() {
    List({
      space: this.isOrdered ? this.orderedListTheme.orderedListChildSpacing : this.bulletListTheme.bulletListChildSpacing
    }) {
      LazyForEach(
        this.markdownDataSource,
        (item: NodeView, idx: number) => {
          ListItem(){
            Row() {
              if (item.nodeType == "ListItem") {
                this.listPrefixTextINCComponent()
              } else if (item.nodeType == "TaskListItem") {
                this.listPrefixCheckboxINCComponent()
              }

            }
            .alignItems(VerticalAlign.Top)
            .justifyContent(FlexAlign.Start)
          }
          .layoutWeight(1)
        },
        (item: NodeView, index: number) => {
          // 稳定key：仅用index+nodeType，不包含内容指纹
          // 内容更新通过就地修改NodeView属性+@ObjectLink的@Watch实现，避免组件重建
          // 仅当nodeType变化（如Paragraph→Heading）时key才变化，触发组件重建
          return `${index}-${item.nodeType}`
        }
      )
    }
    .backgroundColor(listBackgroundColor(this.isOrdered, this.blockQuoteTheme, this.orderedListTheme,this.bulletListTheme, this.globalTheme,this.node))
    .alignListItem(ListItemAlign.Start)
    .listDirection(Axis.Vertical)
    .padding({
      top: this.isOrdered ? this.orderedListTheme.orderedListChildSpacing : this.bulletListTheme.bulletListChildSpacing,
      right: this.isOrdered ? this.orderedListTheme.orderedListChildSpacing : this.bulletListTheme.bulletListChildSpacing,
      bottom: this.isOrdered ? this.orderedListTheme.orderedListChildSpacing : this.bulletListTheme.bulletListChildSpacing,
      left: this.isOrdered ? this.orderedListTheme.orderedListChildSpacing : this.bulletListTheme.bulletListChildSpacing
    })
    .margin({
      top: this.isOrdered ? this.orderedListTheme.orderedListChildSpacing : this.bulletListTheme.bulletListChildSpacing,
      right: this.isOrdered ? this.orderedListTheme.orderedListChildSpacing : this.bulletListTheme.bulletListChildSpacing,
      bottom: this.isOrdered ? this.orderedListTheme.orderedListChildSpacing : this.bulletListTheme.bulletListChildSpacing,
      left: this.isOrdered ? this.orderedListTheme.orderedListChildSpacing : this.bulletListTheme.bulletListChildSpacing
    })
  }

  /**
   * 无序/有序列表的前缀文本
   */
  @Builder
  listPrefixTextINCComponent() {
    Text(listPrefixStr(this.node, this.listDepth, this.isOrdered, this.bulletListTheme))
      .fontFamily(this.isOrdered ? this.orderedListTheme.orderedListMarkerTextFontFamily : this.bulletListTheme.bulletListBulletTextFontFamily)
      .fontSize(this.isOrdered ? this.orderedListTheme.orderedListMarkerTextFontSize : this.bulletListTheme.bulletListBulletTextFontSize)
      .fontWeight(this.isOrdered ? this.orderedListTheme.orderedListMarkerTextFontWeight : this.bulletListTheme.bulletListBulletTextFontWeight)
      .fontStyle(this.isOrdered ? this.orderedListTheme.orderedListMarkerTextFontStyle : this.bulletListTheme.bulletListBulletTextFontStyle)
      .fontColor(this.isOrdered ? this.orderedListTheme.orderedListMarkerTextFontColor : this.bulletListTheme.bulletListBulletTextFontColor)
      .lineHeight(this.isOrdered ? this.orderedListTheme.orderedListMarkerTextLineHeight : this.bulletListTheme.bulletListBulletTextLineHeight)
      .margin({
        right: this.isOrdered ? this.orderedListTheme.orderedListMarkerSpacing : this.bulletListTheme.bulletListBulletSpacing
      })
      .halfLeading(true)
      .textAlign(TextAlign.Center)
  }

  /**
   * 任务列表的前缀多选框
   */
  @Builder
  listPrefixCheckboxINCComponent() {
    Checkbox()
      .height(this.bulletListTheme.bulletListCheckboxWidth)
      .width(this.bulletListTheme.bulletListCheckboxHeight)
      .margin({ right: this.bulletListTheme.bulletListCheckboxSpacing })
      .shape(this.bulletListTheme.bulletListCheckboxShape)
      .selectedColor(this.bulletListTheme.bulletListCheckboxSelectedColor)
      .select(this.node.isTaskListSelected)
      .enabled(false)
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