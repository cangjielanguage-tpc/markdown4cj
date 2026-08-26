import { MarkdownNodeViewString } from "../configs/MarkdownNodeViewString"
import { NodeView } from "../model/NodeView"
import { BlockQuoteTheme } from "../theme/BlockQuoteTheme"
import { TableTheme } from "../theme/TableTheme"

@Component
export struct MarkDownTableTitle {
  @ObjectLink @Watch('refreshData') node: NodeView // 表格自身节点数据
  @ObjectLink tableTheme: TableTheme // 表格样式
  @ObjectLink blockQuoteTheme: BlockQuoteTheme // 块引用样式
  tableCopyCallback?: (str: string) => void // 表格复制点击回调事件
  nodeViewString: MarkdownNodeViewString = new MarkdownNodeViewString() // 表格全部文本对象

  aboutToAppear(): void {
    this.refreshData() // 首次加载
  }

  build() {
    Row() {
      Text(this.tableTheme.tableHeadTitleText)
        .fontColor(this.tableTheme.tableHeadTitleTextFontColor ?? this.tableTheme.tableTitleTextFontColor)
        .fontSize(this.tableTheme.tableHeadTitleTextFontSize ?? this.tableTheme.tableTitleTextFontSize)
        .fontWeight(this.tableTheme.tableHeadTitleTextFontWeight ?? this.tableTheme.tableTitleTextFontWeight)
        .fontStyle(this.tableTheme.tableHeadTitleTextFontStyle ?? this.tableTheme.tableTitleTextFontStyle)
        .fontFamily(this.tableTheme.tableHeadTitleTextFontFamily ?? this.tableTheme.tableTitleTextFontFamily)
        .lineHeight(this.tableTheme.tableHeadTitleTextLineHeight ?? this.tableTheme.tableTitleTextLineHeight)
        .width('70%')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .padding({
          top: this.tableTheme.tableCellPaddingTop,
          bottom: this.tableTheme.tableCellPaddingBottom,
          left: this.tableTheme.tableCellPaddingLeft
        })
        .margin({ left: this.tableTheme.tableHeadTitleTextMarginLeft })
        .visibility(this.tableTheme.tableHeadTitleText.length > 0 ? Visibility.Visible : Visibility.Hidden)

      Blank()
        .layoutWeight(1)

      Row() {
        Image(this.tableTheme.tableHeadCopyIcon)
          .width(this.tableHeadCopyIconWidth())
          .height(this.tableHeadCopyIconHeight())
          .objectFit(ImageFit.Contain)
      }
      .onClick(() => {
        this.tableCopyCallback?.(this.nodeViewString.toString())
      })
      .visibility(this.tableTheme.tableHeadCopyIcon !== undefined ? Visibility.Visible : Visibility.None)
      .margin({ right: this.tableTheme.tableHeadCopyIconMarginRight })
      .padding({
        top: this.tableTheme.tableCellPaddingTop,
        bottom: this.tableTheme.tableCellPaddingBottom,
        right: this.tableTheme.tableCellPaddingRight
      })
    }
    .width('100%')
    .borderWidth({
      bottom: this.tableTheme.tableBorderWidth
    })
    .borderStyle(this.tableTheme.tableBorderStyle)
    .borderColor(this.tableTheme.tableBorderColor)
    .backgroundColor(this.node.isQuote ? this.blockQuoteTheme.blockQuoteBackgroundColor : this.tableTheme.tableTitleBackgroundColor)
    .alignItems(VerticalAlign.Center)
  }

  /**
   * 表格头复制图标宽度：负数/0 等非法尺寸会触发 Image 回退到原图尺寸导致图标异常放大，这里兜底为默认 24.0
   */
  private tableHeadCopyIconWidth(): Length {
    const w = this.tableTheme.tableHeadCopyIconWidth
    return typeof w === 'number' && w <= 0 ? 24.0 : w
  }
  /**
   * 表格头复制图标高度：同上，负值/0 兜底为默认 24.0
   */
  private tableHeadCopyIconHeight(): Length {
    const h = this.tableTheme.tableHeadCopyIconHeight
    return typeof h === 'number' && h <= 0 ? 24.0 : h
  }

  /**
   * 刷新数据
   */
  refreshData() {
    this.nodeViewString.setRoot(this.node)
  }
}
