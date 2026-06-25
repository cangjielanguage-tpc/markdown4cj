import { CodeBlockTheme } from "../theme/CodeBlockTheme"
import { codeTitle } from "./MarkdownCodeTitle"

/**
 * 缩进代码块控件
 */
@Component
export struct MarkdownListItem {
  @ObjectLink codeBlockTheme: CodeBlockTheme
  codeCopyCallback?: (code: string) => void
  codeFullScreenCallback?: (code: string, language: string | undefined) => void
  @State codeText: string = "" // 代码内容
  @State info: string | undefined = undefined // 代码类型
  @State lines: number = 0 // 代码行数

  aboutToAppear(): void {

  }

  build() {
    Column() {
      codeTitle(this.codeText, this.info, this.codeBlockTheme, this.codeCopyCallback, this.codeFullScreenCallback)
      Row() {

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
}

