import { NodeView } from "../model/NodeView"
import { CodeBlockTheme } from "../theme/CodeBlockTheme"
import { codeTitle } from "./MarkdownCodeTitle"

/**
 * 缩进代码块控件
 */
@Component
export struct MarkdownCodeIndented {
  @ObjectLink @Watch('refreshData') node: NodeView // 缩进代码块自身节点数据
  @ObjectLink codeBlockTheme: CodeBlockTheme // 代码块样式
  codeCopyCallback?: (code: string) => void // 代码复制点击事件
  codeFullScreenCallback?: (code: string, language: string | undefined) => void // 代码全屏点击事件
  @State codeText: string = "" // 代码内容
  @State info: string | undefined = undefined // 代码类型
  @State lines: number = 0 // 代码行数
  @State lineArray: Array<number> = new Array<number>() // 代码行数显示数据列表

  aboutToAppear(): void {
    this.refreshData()
  }

  build() {
    Column() {
      codeTitle(this.codeText, this.info, this.codeBlockTheme, this.codeCopyCallback, this.codeFullScreenCallback)
      Row() {
        this.codeLineComponent()
        this.codeBlockComponent()
      }
    }
    .borderRadius({
      topLeft: this.codeBlockTheme.codeBlockRadiusTopLeft,
      topRight: this.codeBlockTheme.codeBlockRadiusTopRight,
      bottomLeft: this.codeBlockTheme.codeBlockRadiusBottomLeft,
      bottomRight: this.codeBlockTheme.codeBlockRadiusBottomRight
    })
    .borderColor(this.codeBlockTheme.codeBlockBorderColor)
    .borderWidth(this.codeBlockTheme.codeBlockBorderWidth)
    .borderStyle(this.codeBlockTheme.codeBlockBorderStyle)
    .backgroundColor(this.codeBlockTheme.codeBlockBackgroundColor)
    .padding({
      top: this.codeBlockTheme.codeBlockPaddingTop,
      right: this.codeBlockTheme.codeBlockPaddingRight,
      bottom: this.codeBlockTheme.codeBlockPaddingBottom,
      left: this.codeBlockTheme.codeBlockPaddingLeft
    })
    .margin({
      top: this.codeBlockTheme.codeBlockMarginTop,
      right: this.codeBlockTheme.codeBlockMarginRight,
      bottom: this.codeBlockTheme.codeBlockMarginBottom,
      left: this.codeBlockTheme.codeBlockMarginLeft
    })
  }

  /**
   * 代码块行号部分
   */
  @Builder
  codeLineComponent() {
    Column() {
      ForEach(
        this.lineArray,
        (item: number) => {
          Text(item.toString())
            .fontFamily(this.codeBlockTheme.codeBlockLineNumberTextFontFamily ?? this.codeBlockTheme.codeBlockTextFontFamily)
            .fontSize(this.codeBlockTheme.codeBlockLineNumberTextFontSize ?? this.codeBlockTheme.codeBlockTextFontSize)
            .fontWeight(this.codeBlockTheme.codeBlockLineNumberTextFontWeight ?? this.codeBlockTheme.codeBlockTextFontWeight)
            .fontStyle(this.codeBlockTheme.codeBlockLineNumberTextFontStyle ?? this.codeBlockTheme.codeBlockTextFontStyle)
            .fontColor(this.codeBlockTheme.codeBlockLineNumberTextFontColor ?? this.codeBlockTheme.codeBlockTextFontColor)
            .lineHeight(this.codeBlockTheme.codeBlockLineNumberTextLineHeight ?? this.codeBlockTheme.codeBlockTextLineHeight)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        },
        (item: number) => {
          return item.toString()
        }
      )
    }
    .visibility(this.codeBlockTheme.codeBlockLineNumberIsShow ? Visibility.Visible : Visibility.None)
    .padding({
      right: this.codeBlockTheme.codeBlockLineNumberDividerSpacing,
      left: this.codeBlockTheme.codeBlockLineNumberTextPaddingLeft
    })
    .borderWidth({
      right: this.codeBlockTheme.codeBlockDividerStrokeWidth
    })
    .borderColor(this.codeBlockTheme.codeBlockDividerColor ?? this.codeBlockTheme.codeBlockTextFontColor)
    .borderStyle(BorderStyle.Solid)
    .alignItems(HorizontalAlign.End)
  }

  /**
   * 代码块文本内容部分
   */
  @Builder
  codeBlockComponent() {
    Scroll() {
      Text(this.codeText)
        .fontFamily(this.codeBlockTheme.codeBlockTextFontFamily)
        .fontSize(this.codeBlockTheme.codeBlockTextFontSize)
        .fontWeight(this.codeBlockTheme.codeBlockTextFontWeight)
        .fontStyle(this.codeBlockTheme.codeBlockTextFontStyle)
        .fontColor(this.codeBlockTheme.codeBlockCopyTextFontColor ?? this.codeBlockTheme.codeBlockTextFontColor)
        .lineHeight(this.codeBlockTheme.codeBlockTextLineHeight)
        .textAlign(TextAlign.Start)
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .align(Alignment.Start)
    .layoutWeight(1)
    .margin({
      left: this.codeBlockTheme.codeBlockTextMarginLeft,
      right: this.codeBlockTheme.codeBlockTextMarginRight
    })
  }

  /**
   * 刷新数据
   */
  refreshData() {
    this.codeText = this.node.nodeText
    this.info = this.node.codeInfo
    let arr = this.codeText.split("\n") // 代码块数据分割
    if (arr.length > 1 && arr[arr.length - 1] === "") {
      arr.pop()
    }
    this.lines = arr.length
    let lineArr: number[] = []
    for (let i = 1; i <= this.lines; i++) {
      lineArr.push(i)
    }
    this.lineArray = lineArr
  }
}

