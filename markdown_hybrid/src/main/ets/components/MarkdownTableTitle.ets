import { MarkdownNodeViewString } from "../configs/MarkdownNodeViewString"
import { NodeView } from "../model/NodeView"
import { TableTheme } from "../theme/TableTheme"
import { hilog } from "@kit.PerformanceAnalysisKit"

@Component
export struct MarkDownTableTitle {
  @ObjectLink @Watch('refreshData') node: NodeView
  @ObjectLink tableTheme: TableTheme
  tableCopyCallback?: (str: string) => void
  nodeViewString: MarkdownNodeViewString = new MarkdownNodeViewString()

  refreshData() {
    this.nodeViewString.setRoot(this.node)
  }

  aboutToAppear(): void {
    this.refreshData()
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
          .layoutWeight(1)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .padding({
            top: this.tableTheme.tableCellPaddingTop,
            bottom: this.tableTheme.tableCellPaddingBottom,
            left: this.tableTheme.tableCellPaddingLeft
          })
          .visibility(this.tableTheme.tableHeadTitleText.length > 0?Visibility.Visible:Visibility.Hidden)


      Row() {
        Image(this.tableTheme.tableHeadCopyIcon)
          .width(this.tableTheme.tableHeadCopyIconWidth)
          .height(this.tableTheme.tableHeadCopyIconHeight)
          .objectFit(ImageFit.Contain)
          .visibility(this.tableTheme.tableHeadCopyIcon !== undefined ? Visibility.Visible : Visibility.Hidden)

        Blank()
          .width(this.tableTheme.tableHeadCopyTextSpacing)
          .visibility(this.tableTheme.tableHeadCopyIcon !== undefined && this.tableTheme.tableHeadCopyTextIsShow ? Visibility.Visible : Visibility.Hidden)

        Text(this.tableTheme.tableHeadCopyText)
          .fontFamily(this.tableTheme.tableHeadCopyTextFontFamily ?? this.tableTheme.tableTitleTextFontFamily)
          .fontSize(this.tableTheme.tableHeadCopyTextFontSize ?? this.tableTheme.tableTitleTextFontSize)
          .fontWeight(this.tableTheme.tableHeadCopyTextFontWeight ?? this.tableTheme.tableTitleTextFontWeight)
          .fontStyle(this.tableTheme.tableHeadCopyTextFontStyle ?? this.tableTheme.tableTitleTextFontStyle)
          .fontColor(this.tableTheme.tableHeadCopyTextFontColor ?? this.tableTheme.tableTitleTextFontColor)
          .lineHeight(this.tableTheme.tableHeadCopyTextLineHeight ?? this.tableTheme.tableTitleTextLineHeight)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .visibility(this.tableTheme.tableHeadCopyTextIsShow ? Visibility.Visible : Visibility.None)
      }
      .onClick(() => {
        this.tableCopyCallback?.(this.nodeViewString.toString())
      })
      .visibility(this.tableTheme.tableHeadCopyButtonIsShow ? Visibility.Visible : Visibility.Hidden)
      .padding({
        top: this.tableTheme.tableCellPaddingTop,
        bottom: this.tableTheme.tableCellPaddingBottom,
        right: this.tableTheme.tableCellPaddingRight
      })
    }
    .width('100%')
    .borderWidth({
      bottom:this.tableTheme.tableBorderWidth
    })
    .borderStyle(this.tableTheme.tableBorderStyle)
    .borderColor(this.tableTheme.tableBorderColor)
    .borderRadius({
      topLeft: this.tableTheme.tableRadiusTopLeft,
      topRight: this.tableTheme.tableRadiusTopRight,
      bottomLeft: 0,
      bottomRight: 0
    })
    .backgroundColor(this.tableTheme.tableTitleBackgroundColor)
    .alignItems(VerticalAlign.Center)
  }
}
