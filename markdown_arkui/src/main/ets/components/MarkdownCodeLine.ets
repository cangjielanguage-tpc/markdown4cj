import { CodeBlockTheme } from "../theme/CodeBlockTheme"

/**
 * 代码行号组件
 *
 * @param lineArray 行号数组
 * @param codeBlockTheme 代码样式
 */
@Component
export struct CodeLineComponent {
  @Prop lineArray: Array<number> = []
  @ObjectLink codeBlockTheme: CodeBlockTheme

  build() {
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
}
