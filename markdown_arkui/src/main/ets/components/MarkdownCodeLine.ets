import { CodeBlockTheme } from "../theme/CodeBlockTheme"

/**
 * 代码行号组件
 * 行号列合并为单个多行Text：原实现每行一个独立Text组件且Column无虚拟化，
 * 长代码块滑入视口时一次性构建数百个节点导致掉帧。
 * 行对齐由行号列与代码列使用相同lineHeight保证（两者来自同一theme字段链），
 * letterSpacing只影响水平不影响行高。
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
      if (this.lineArray.length > 0) {
        Text(this.lineArray.join('\n'))
          .fontFamily(this.codeBlockTheme.codeBlockLineNumberTextFontFamily ?? this.codeBlockTheme.codeBlockTextFontFamily)
          .fontSize(this.codeBlockTheme.codeBlockLineNumberTextFontSize ?? this.codeBlockTheme.codeBlockTextFontSize)
          .fontWeight(this.codeBlockTheme.codeBlockLineNumberTextFontWeight ?? this.codeBlockTheme.codeBlockTextFontWeight)
          .fontStyle(this.codeBlockTheme.codeBlockLineNumberTextFontStyle ?? this.codeBlockTheme.codeBlockTextFontStyle)
          .fontColor(this.codeBlockTheme.codeBlockLineNumberTextFontColor ?? this.codeBlockTheme.codeBlockTextFontColor)
          .lineHeight(this.codeBlockTheme.codeBlockLineNumberTextLineHeight ?? this.codeBlockTheme.codeBlockTextLineHeight)
          .textAlign(TextAlign.End)
      }
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
