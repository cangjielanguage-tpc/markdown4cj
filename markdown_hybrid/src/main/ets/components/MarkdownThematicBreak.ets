import { DividerTheme } from "../theme/DividerTheme"

/**
 * 分割线控件
 */
@Component
export struct MarkdownThematicBreak {
  @ObjectLink dividerTheme: DividerTheme

  build() {
    Column() {
      if (this.dividerTheme.dividerStrokeWidth > 0) {
        Divider()
          .color(this.dividerTheme.dividerColor)
          .strokeWidth(this.dividerTheme.dividerStrokeWidth)
          .lineCap(this.dividerTheme.dividerStyle)
      }
    }
    .padding({
      top: this.dividerTheme.dividerPaddingTop,
      right: this.dividerTheme.dividerPaddingRight,
      bottom: this.dividerTheme.dividerPaddingBottom,
      left: this.dividerTheme.dividerPaddingLeft
    })
    .margin({
      top: this.dividerTheme.dividerMarginTop,
      right: this.dividerTheme.dividerMarginRight,
      bottom: this.dividerTheme.dividerMarginBottom,
      left: this.dividerTheme.dividerMarginLeft
    })
  }
}
